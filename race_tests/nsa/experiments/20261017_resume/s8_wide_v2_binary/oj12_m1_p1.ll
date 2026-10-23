; ModuleID = 'experiments/20261017_resume/s8_wide_v2_binary/oj12_m1_p1.bc'
source_filename = "/tmp/tmp16izrl_h/tvm_kernels.maca"
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
  %cond.i.i796 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i796, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i796.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i796.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i796.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i796.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i796.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i796.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i796.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i796.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i796.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i796.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i796.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i796.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i796.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i796.7, 4, !dbg !52
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
  %qr.sroa.7.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !57
  %qr.sroa.7.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.7.0.add.ptr.sroa_idx, align 8, !dbg !57
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64, !dbg !56
  %qr.sroa.11.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !57
  %qr.sroa.16.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72, !dbg !57
  %qr.sroa.16.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.16.16.add.ptr.1.sroa_idx, align 8, !dbg !57
  %mul103 = shl nsw i32 %0, 16
  %mul110 = shl nuw nsw i32 %18, 3
  %add108 = or disjoint i32 %mul110, %mul103
  %invariant.op = add nsw i32 %1, -15
  %22 = lshr i32 %18, 2
  %mul175 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023, !dbg !58
  %cmp101.not = icmp sgt i32 %mul11, %1
  %or.cond854 = or i1 %or.cond, %cmp101.not, !dbg !58
  br i1 %or.cond854, label %if.end, label %if.then, !dbg !58

if.then:                                          ; preds = %entry
  %23 = shl nsw i32 %cond.i.i796, 10, !dbg !59
  %mul105 = and i32 %23, 64512, !dbg !59
  %add111 = add nuw nsw i32 %add108, %mul105, !dbg !60
  %idx.ext112 = zext nneg i32 %add111 to i64, !dbg !61
  %add.ptr113 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112, !dbg !61
  %kr.sroa.0.0.copyload2327 = load <4 x half>, ptr addrspace(4) %add.ptr113, align 16, !dbg !62
  %kr.sroa.18.0.add.ptr113.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113, i64 8, !dbg !62
  %kr.sroa.18.0.copyload2328 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.sroa_idx, align 8, !dbg !62
  br label %if.end, !dbg !63

if.end:                                           ; preds = %entry, %if.then
  %24 = phi <4 x half> [ %kr.sroa.18.0.copyload2328, %if.then ], [ zeroinitializer, %entry ], !dbg !64
  %25 = phi <4 x half> [ %kr.sroa.0.0.copyload2327, %if.then ], [ zeroinitializer, %entry ], !dbg !64
  %or.cond.1 = icmp ugt i32 %mul11.1, 1023, !dbg !58
  %cmp101.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond854.1 = or i1 %or.cond.1, %cmp101.not.1, !dbg !58
  br i1 %or.cond854.1, label %if.end.1, label %if.then.1, !dbg !58

if.then.1:                                        ; preds = %if.end
  %26 = shl nsw i32 %cond.i.i796.1, 10, !dbg !59
  %mul105.1 = and i32 %26, 64512, !dbg !59
  %add111.1 = add nuw nsw i32 %add108, %mul105.1, !dbg !60
  %idx.ext112.1 = zext nneg i32 %add111.1 to i64, !dbg !61
  %add.ptr113.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1, !dbg !61
  %kr.sroa.30.16.copyload2329 = load <4 x half>, ptr addrspace(4) %add.ptr113.1, align 16, !dbg !62
  %kr.sroa.46.16.add.ptr113.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1, i64 8, !dbg !62
  %kr.sroa.46.16.copyload2330 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1, !dbg !63

if.end.1:                                         ; preds = %if.end, %if.then.1
  %27 = phi <4 x half> [ %kr.sroa.46.16.copyload2330, %if.then.1 ], [ zeroinitializer, %if.end ], !dbg !64
  %28 = phi <4 x half> [ %kr.sroa.30.16.copyload2329, %if.then.1 ], [ zeroinitializer, %if.end ], !dbg !64
  %add106.1 = add nuw nsw i32 %add108, 512
  br i1 %or.cond854, label %if.end.1895, label %if.then.1888, !dbg !58

if.then.1888:                                     ; preds = %if.end.1
  %29 = shl nsw i32 %cond.i.i796, 10, !dbg !59
  %mul105.1882 = and i32 %29, 64512, !dbg !59
  %add111.1883 = add nuw nsw i32 %add106.1, %mul105.1882, !dbg !60
  %idx.ext112.1884 = zext nneg i32 %add111.1883 to i64, !dbg !61
  %add.ptr113.1885 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884, !dbg !61
  %kr.sroa.58.32.copyload2331 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885, align 16, !dbg !62
  %kr.sroa.74.32.add.ptr113.1885.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885, i64 8, !dbg !62
  %kr.sroa.74.32.copyload2332 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.sroa_idx, align 8, !dbg !62
  br label %if.end.1895, !dbg !63

if.end.1895:                                      ; preds = %if.end.1, %if.then.1888
  %30 = phi <4 x half> [ %kr.sroa.74.32.copyload2332, %if.then.1888 ], [ zeroinitializer, %if.end.1 ], !dbg !64
  %31 = phi <4 x half> [ %kr.sroa.58.32.copyload2331, %if.then.1888 ], [ zeroinitializer, %if.end.1 ], !dbg !64
  br i1 %or.cond854.1, label %if.end.1.1, label %if.then.1.1, !dbg !58

if.then.1.1:                                      ; preds = %if.end.1895
  %32 = shl nsw i32 %cond.i.i796.1, 10, !dbg !59
  %mul105.1.1 = and i32 %32, 64512, !dbg !59
  %add111.1.1 = add nuw nsw i32 %add106.1, %mul105.1.1, !dbg !60
  %idx.ext112.1.1 = zext nneg i32 %add111.1.1 to i64, !dbg !61
  %add.ptr113.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1, !dbg !61
  %kr.sroa.86.48.copyload2333 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1, align 16, !dbg !62
  %kr.sroa.102.48.add.ptr113.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1, i64 8, !dbg !62
  %kr.sroa.102.48.copyload2334 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1, !dbg !63

if.end.1.1:                                       ; preds = %if.end.1895, %if.then.1.1
  %33 = phi <4 x half> [ %kr.sroa.102.48.copyload2334, %if.then.1.1 ], [ zeroinitializer, %if.end.1895 ], !dbg !64
  %34 = phi <4 x half> [ %kr.sroa.86.48.copyload2333, %if.then.1.1 ], [ zeroinitializer, %if.end.1895 ], !dbg !64
  br i1 %or.cond854, label %if.end218, label %if.then164, !dbg !65

if.then164:                                       ; preds = %if.end.1.1
  %cmp167 = icmp sgt i32 %mul11, %invariant.op, !dbg !66
  br i1 %cmp167, label %for.cond169.preheader, label %if.end218, !dbg !67

for.cond169.preheader:                            ; preds = %if.then164
  %add176 = add nuw nsw i32 %mul11, %mul175
  %cmp179.not = icmp sgt i32 %add176, %1, !dbg !68
  %spec.select = select i1 %cmp179.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.0.vec.insert1422 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !70
  %cmp179.not.1.not = icmp slt i32 %add176, %1, !dbg !68
  %spec.select.1 = select i1 %cmp179.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.0.4.vec.insert1475 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1422, float %spec.select.1, i64 1, !dbg !70
  %add177.2 = or disjoint i32 %add176, 2, !dbg !71
  %cmp179.not.2 = icmp sgt i32 %add177.2, %1, !dbg !68
  %spec.select.2 = select i1 %cmp179.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.8.vec.insert1528 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1475, float %spec.select.2, i64 2, !dbg !70
  %add177.3 = or disjoint i32 %add176, 3, !dbg !71
  %cmp179.not.3 = icmp sgt i32 %add177.3, %1, !dbg !68
  %spec.select.3 = select i1 %cmp179.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.12.vec.insert1581 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1528, float %spec.select.3, i64 3, !dbg !70
  br label %if.end218, !dbg !72

if.end218:                                        ; preds = %if.end.1.1, %if.then164, %for.cond169.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1581, %for.cond169.preheader ], [ zeroinitializer, %if.then164 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1 ], !dbg !64
  br i1 %or.cond854.1, label %if.end218.1, label %if.then164.1, !dbg !65

if.then164.1:                                     ; preds = %if.end218
  %cmp167.1 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !66
  br i1 %cmp167.1, label %for.cond169.preheader.1, label %if.end218.1, !dbg !67

for.cond169.preheader.1:                          ; preds = %if.then164.1
  %add176.1 = add nuw nsw i32 %mul11.1, %mul175
  %cmp179.not.1897 = icmp sgt i32 %add176.1, %1, !dbg !68
  %spec.select.1898 = select i1 %cmp179.not.1897, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.16.vec.insert1650 = insertelement <4 x float> poison, float %spec.select.1898, i64 0, !dbg !70
  %cmp179.not.1.1.not = icmp slt i32 %add176.1, %1, !dbg !68
  %spec.select.1.1 = select i1 %cmp179.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.146.20.vec.insert1703 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1650, float %spec.select.1.1, i64 1, !dbg !70
  %add177.2.1 = or disjoint i32 %add176.1, 2, !dbg !71
  %cmp179.not.2.1 = icmp sgt i32 %add177.2.1, %1, !dbg !68
  %spec.select.2.1 = select i1 %cmp179.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.24.vec.insert1756 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1703, float %spec.select.2.1, i64 2, !dbg !70
  %add177.3.1 = or disjoint i32 %add176.1, 3, !dbg !71
  %cmp179.not.3.1 = icmp sgt i32 %add177.3.1, %1, !dbg !68
  %spec.select.3.1 = select i1 %cmp179.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.28.vec.insert1809 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1756, float %spec.select.3.1, i64 3, !dbg !70
  br label %if.end218.1, !dbg !72

if.end218.1:                                      ; preds = %if.end218, %if.then164.1, %for.cond169.preheader.1
  %scores.sroa.146.0 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1809, %for.cond169.preheader.1 ], [ zeroinitializer, %if.then164.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218 ], !dbg !64
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %25, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.0), !dbg !73, !call_argsrelate !74
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.0), !dbg !73, !call_argsrelate !74
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %24, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %35), !dbg !73, !call_argsrelate !74
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %36), !dbg !73, !call_argsrelate !74
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %37), !dbg !73, !call_argsrelate !74
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %38), !dbg !73, !call_argsrelate !74
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %39), !dbg !73, !call_argsrelate !74
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %40), !dbg !73, !call_argsrelate !74
  br i1 %or.cond854, label %if.end335, label %for.cond274.preheader, !dbg !75

for.cond274.preheader:                            ; preds = %if.end218.1
  %43 = shl nsw i32 %cond.i.i796, 10
  %mul281 = and i32 %43, 64512
  %add284 = add nuw nsw i32 %add108, %mul281
  %44 = zext nneg i32 %add284 to i64, !dbg !76
  %add.ptr289 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %44, !dbg !77
  %vr.sroa.0.0.copyload2335 = load <4 x half>, ptr addrspace(4) %add.ptr289, align 16, !dbg !78
  %vr.sroa.22.0.add.ptr289.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289, i64 8, !dbg !78
  %vr.sroa.22.0.copyload2336 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.sroa_idx, align 8, !dbg !78
  %45 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %44, !dbg !77
  %add.ptr289.1 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1024, !dbg !77
  %vr.sroa.38.16.copyload2337 = load <4 x half>, ptr addrspace(4) %add.ptr289.1, align 16, !dbg !78
  %vr.sroa.58.16.add.ptr289.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1032, !dbg !78
  %vr.sroa.58.16.copyload2338 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.sroa_idx, align 8, !dbg !78
  br label %if.end335, !dbg !79

if.end335:                                        ; preds = %if.end218.1, %for.cond274.preheader
  %46 = phi <4 x half> [ %vr.sroa.58.16.copyload2338, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ], !dbg !64
  %47 = phi <4 x half> [ %vr.sroa.38.16.copyload2337, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ], !dbg !64
  %48 = phi <4 x half> [ %vr.sroa.22.0.copyload2336, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ], !dbg !64
  %49 = phi <4 x half> [ %vr.sroa.0.0.copyload2335, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ], !dbg !64
  br i1 %or.cond854.1, label %if.end335.1, label %for.cond274.preheader.1, !dbg !75

for.cond274.preheader.1:                          ; preds = %if.end335
  %50 = shl nsw i32 %cond.i.i796.1, 10
  %mul281.1 = and i32 %50, 64512
  %add284.1 = add nuw nsw i32 %add108, %mul281.1
  %51 = zext nneg i32 %add284.1 to i64, !dbg !76
  %add.ptr289.1913 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %51, !dbg !77
  %vr.sroa.74.32.copyload2339 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913, align 16, !dbg !78
  %vr.sroa.94.32.add.ptr289.1913.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913, i64 8, !dbg !78
  %vr.sroa.94.32.copyload2340 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.sroa_idx, align 8, !dbg !78
  %52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %51, !dbg !77
  %add.ptr289.1.1 = getelementptr inbounds i8, ptr addrspace(4) %52, i64 1024, !dbg !77
  %vr.sroa.110.48.copyload2341 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1, align 16, !dbg !78
  %vr.sroa.130.48.add.ptr289.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %52, i64 1032, !dbg !78
  %vr.sroa.130.48.copyload2342 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.sroa_idx, align 8, !dbg !78
  br label %if.end335.1, !dbg !79

if.end335.1:                                      ; preds = %if.end335, %for.cond274.preheader.1
  %53 = phi <4 x half> [ %vr.sroa.130.48.copyload2342, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  %54 = phi <4 x half> [ %vr.sroa.110.48.copyload2341, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  %55 = phi <4 x half> [ %vr.sroa.94.32.copyload2340, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  %56 = phi <4 x half> [ %vr.sroa.74.32.copyload2339, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  br i1 %or.cond854, label %if.end415, label %for.cond352.preheader, !dbg !80

for.cond352.preheader:                            ; preds = %if.end335.1
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %41, i64 0, !dbg !81
  %mul360 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !82
  %57 = tail call contract noundef float @llvm.minnum.f32(float %mul360, float 0x4024CB5EC0000000), !dbg !83
  %58 = tail call contract noundef float @llvm.exp.f32(float %57), !dbg !86
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %41, i64 1, !dbg !81
  %mul360.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !82
  %59 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1, float 0x4024CB5EC0000000), !dbg !83
  %60 = tail call contract noundef float @llvm.exp.f32(float %59), !dbg !86
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %41, i64 2, !dbg !81
  %mul360.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !82
  %61 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2, float 0x4024CB5EC0000000), !dbg !83
  %62 = tail call contract noundef float @llvm.exp.f32(float %61), !dbg !86
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %41, i64 3, !dbg !81
  %mul360.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !82
  %63 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3, float 0x4024CB5EC0000000), !dbg !83
  %64 = tail call contract noundef float @llvm.exp.f32(float %63), !dbg !86
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %58), !dbg !89
  %66 = insertelement <4 x i16> poison, i16 %65, i64 0, !dbg !98
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %60), !dbg !89
  %68 = insertelement <4 x i16> %66, i16 %67, i64 1, !dbg !98
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %62), !dbg !89
  %70 = insertelement <4 x i16> %68, i16 %69, i64 2, !dbg !98
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %64), !dbg !89
  %72 = insertelement <4 x i16> %70, i16 %71, i64 3, !dbg !98
  %probs.sroa.0.6.vec.insert = bitcast <4 x i16> %72 to <4 x half>, !dbg !98
  br label %if.end415, !dbg !99

if.end415:                                        ; preds = %if.end335.1, %for.cond352.preheader
  %sums.sroa.56.0 = phi float [ %64, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ], !dbg !64
  %sums.sroa.38.0 = phi float [ %62, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ], !dbg !64
  %sums.sroa.20.0 = phi float [ %60, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ], !dbg !64
  %sums.sroa.0.0 = phi float [ %58, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ], !dbg !64
  %probs.sroa.0.0 = phi <4 x half> [ %probs.sroa.0.6.vec.insert, %for.cond352.preheader ], [ zeroinitializer, %if.end335.1 ], !dbg !64
  br i1 %or.cond854.1, label %if.end415.1, label %for.cond352.preheader.1, !dbg !80

for.cond352.preheader.1:                          ; preds = %if.end415
  %scores.sroa.146.16.vec.extract = extractelement <4 x float> %42, i64 0, !dbg !81
  %mul360.1922 = fmul contract float %scores.sroa.146.16.vec.extract, 0x3FB99999A0000000, !dbg !82
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922, float 0x4024CB5EC0000000), !dbg !83
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !86
  %scores.sroa.146.20.vec.extract = extractelement <4 x float> %42, i64 1, !dbg !81
  %mul360.1.1 = fmul contract float %scores.sroa.146.20.vec.extract, 0x3FB99999A0000000, !dbg !82
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1, float 0x4024CB5EC0000000), !dbg !83
  %76 = tail call contract noundef float @llvm.exp.f32(float %75), !dbg !86
  %scores.sroa.146.24.vec.extract = extractelement <4 x float> %42, i64 2, !dbg !81
  %mul360.2.1 = fmul contract float %scores.sroa.146.24.vec.extract, 0x3FB99999A0000000, !dbg !82
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1, float 0x4024CB5EC0000000), !dbg !83
  %78 = tail call contract noundef float @llvm.exp.f32(float %77), !dbg !86
  %scores.sroa.146.28.vec.extract = extractelement <4 x float> %42, i64 3, !dbg !81
  %mul360.3.1 = fmul contract float %scores.sroa.146.28.vec.extract, 0x3FB99999A0000000, !dbg !82
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1, float 0x4024CB5EC0000000), !dbg !83
  %80 = tail call contract noundef float @llvm.exp.f32(float %79), !dbg !86
  %add380.1924 = fadd contract float %sums.sroa.0.0, %74, !dbg !100
  %add380.1.1 = fadd contract float %sums.sroa.20.0, %76, !dbg !100
  %add380.2.1 = fadd contract float %sums.sroa.38.0, %78, !dbg !100
  %add380.3.1 = fadd contract float %sums.sroa.56.0, %80, !dbg !100
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74), !dbg !89
  %82 = insertelement <4 x i16> poison, i16 %81, i64 0, !dbg !98
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76), !dbg !89
  %84 = insertelement <4 x i16> %82, i16 %83, i64 1, !dbg !98
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78), !dbg !89
  %86 = insertelement <4 x i16> %84, i16 %85, i64 2, !dbg !98
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80), !dbg !89
  %88 = insertelement <4 x i16> %86, i16 %87, i64 3, !dbg !98
  %probs.sroa.46.14.vec.insert = bitcast <4 x i16> %88 to <4 x half>, !dbg !98
  br label %if.end415.1, !dbg !99

if.end415.1:                                      ; preds = %if.end415, %for.cond352.preheader.1
  %sums.sroa.56.1 = phi float [ %add380.3.1, %for.cond352.preheader.1 ], [ %sums.sroa.56.0, %if.end415 ], !dbg !64
  %sums.sroa.38.1 = phi float [ %add380.2.1, %for.cond352.preheader.1 ], [ %sums.sroa.38.0, %if.end415 ], !dbg !64
  %sums.sroa.20.1 = phi float [ %add380.1.1, %for.cond352.preheader.1 ], [ %sums.sroa.20.0, %if.end415 ], !dbg !64
  %sums.sroa.0.1 = phi float [ %add380.1924, %for.cond352.preheader.1 ], [ %sums.sroa.0.0, %if.end415 ], !dbg !64
  %probs.sroa.46.0 = phi <4 x half> [ %probs.sroa.46.14.vec.insert, %for.cond352.preheader.1 ], [ zeroinitializer, %if.end415 ], !dbg !64
  br i1 %or.cond854, label %if.end477, label %for.cond434.preheader, !dbg !101

for.cond434.preheader:                            ; preds = %if.end415.1
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %49, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %47, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %46, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  br label %if.end477, !dbg !103

if.end477:                                        ; preds = %for.cond434.preheader, %if.end415.1
  %out.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %92, %for.cond434.preheader ], !dbg !64
  %out.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %91, %for.cond434.preheader ], !dbg !64
  %out.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %90, %for.cond434.preheader ], !dbg !64
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %89, %for.cond434.preheader ], !dbg !64
  br i1 %or.cond854.1, label %if.end477.1, label %for.cond455.preheader.1, !dbg !101

for.cond455.preheader.1:                          ; preds = %if.end477
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer), !dbg !104
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer), !dbg !104
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer), !dbg !104
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %53, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer), !dbg !104
  br label %if.end477.1, !dbg !103

if.end477.1:                                      ; preds = %for.cond455.preheader.1, %if.end477
  %out_1.sroa.74.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %96, %for.cond455.preheader.1 ], !dbg !64
  %out_1.sroa.50.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %95, %for.cond455.preheader.1 ], !dbg !64
  %out_1.sroa.26.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %94, %for.cond455.preheader.1 ], !dbg !64
  %out_1.sroa.0.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %93, %for.cond455.preheader.1 ], !dbg !64
  %or.cond.1930 = icmp ugt i32 %mul11.2, 1023, !dbg !58
  %cmp101.not.1931 = icmp sgt i32 %mul11.2, %1
  %or.cond854.1932 = or i1 %or.cond.1930, %cmp101.not.1931, !dbg !58
  br i1 %or.cond854.1932, label %if.end.1947, label %if.then.1938, !dbg !58

if.then.1938:                                     ; preds = %if.end477.1
  %97 = shl nsw i32 %cond.i.i796.2, 10, !dbg !59
  %mul105.1934 = and i32 %97, 64512, !dbg !59
  %add111.1935 = add nuw nsw i32 %add108, %mul105.1934, !dbg !60
  %idx.ext112.1936 = zext nneg i32 %add111.1935 to i64, !dbg !61
  %add.ptr113.1937 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1936, !dbg !61
  %kr.sroa.0.0.copyload18712343 = load <4 x half>, ptr addrspace(4) %add.ptr113.1937, align 16, !dbg !62
  %kr.sroa.18.0.add.ptr113.1937.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1937, i64 8, !dbg !62
  %kr.sroa.18.0.copyload18802344 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.1937.sroa_idx, align 8, !dbg !62
  br label %if.end.1947, !dbg !63

if.end.1947:                                      ; preds = %if.end477.1, %if.then.1938
  %98 = phi <4 x half> [ %kr.sroa.18.0.copyload18802344, %if.then.1938 ], [ zeroinitializer, %if.end477.1 ], !dbg !64
  %99 = phi <4 x half> [ %kr.sroa.0.0.copyload18712343, %if.then.1938 ], [ zeroinitializer, %if.end477.1 ], !dbg !64
  %or.cond.1.1944 = icmp ugt i32 %mul11.3, 1023, !dbg !58
  %cmp101.not.1.1945 = icmp sgt i32 %mul11.3, %1
  %or.cond854.1.1946 = or i1 %or.cond.1.1944, %cmp101.not.1.1945, !dbg !58
  br i1 %or.cond854.1.1946, label %if.end.1.1957, label %if.then.1.1952, !dbg !58

if.then.1.1952:                                   ; preds = %if.end.1947
  %100 = shl nsw i32 %cond.i.i796.3, 10, !dbg !59
  %mul105.1.1948 = and i32 %100, 64512, !dbg !59
  %add111.1.1949 = add nuw nsw i32 %add108, %mul105.1.1948, !dbg !60
  %idx.ext112.1.1950 = zext nneg i32 %add111.1.1949 to i64, !dbg !61
  %add.ptr113.1.1951 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1950, !dbg !61
  %kr.sroa.30.16.copyload19092345 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1951, align 16, !dbg !62
  %kr.sroa.46.16.add.ptr113.1.1951.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1951, i64 8, !dbg !62
  %kr.sroa.46.16.copyload19182346 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.1951.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1957, !dbg !63

if.end.1.1957:                                    ; preds = %if.end.1947, %if.then.1.1952
  %101 = phi <4 x half> [ %kr.sroa.46.16.copyload19182346, %if.then.1.1952 ], [ zeroinitializer, %if.end.1947 ], !dbg !64
  %102 = phi <4 x half> [ %kr.sroa.30.16.copyload19092345, %if.then.1.1952 ], [ zeroinitializer, %if.end.1947 ], !dbg !64
  br i1 %or.cond854.1932, label %if.end.1895.1, label %if.then.1888.1, !dbg !58

if.then.1888.1:                                   ; preds = %if.end.1.1957
  %103 = shl nsw i32 %cond.i.i796.2, 10, !dbg !59
  %mul105.1882.1 = and i32 %103, 64512, !dbg !59
  %add111.1883.1 = add nuw nsw i32 %add106.1, %mul105.1882.1, !dbg !60
  %idx.ext112.1884.1 = zext nneg i32 %add111.1883.1 to i64, !dbg !61
  %add.ptr113.1885.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884.1, !dbg !61
  %kr.sroa.58.32.copyload19472347 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885.1, align 16, !dbg !62
  %kr.sroa.74.32.add.ptr113.1885.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885.1, i64 8, !dbg !62
  %kr.sroa.74.32.copyload19562348 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1895.1, !dbg !63

if.end.1895.1:                                    ; preds = %if.end.1.1957, %if.then.1888.1
  %104 = phi <4 x half> [ %kr.sroa.74.32.copyload19562348, %if.then.1888.1 ], [ zeroinitializer, %if.end.1.1957 ], !dbg !64
  %105 = phi <4 x half> [ %kr.sroa.58.32.copyload19472347, %if.then.1888.1 ], [ zeroinitializer, %if.end.1.1957 ], !dbg !64
  br i1 %or.cond854.1.1946, label %if.end.1.1.1, label %if.then.1.1.1, !dbg !58

if.then.1.1.1:                                    ; preds = %if.end.1895.1
  %106 = shl nsw i32 %cond.i.i796.3, 10, !dbg !59
  %mul105.1.1.1 = and i32 %106, 64512, !dbg !59
  %add111.1.1.1 = add nuw nsw i32 %add106.1, %mul105.1.1.1, !dbg !60
  %idx.ext112.1.1.1 = zext nneg i32 %add111.1.1.1 to i64, !dbg !61
  %add.ptr113.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1.1, !dbg !61
  %kr.sroa.86.48.copyload19852349 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1.1, align 16, !dbg !62
  %kr.sroa.102.48.add.ptr113.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1.1, i64 8, !dbg !62
  %kr.sroa.102.48.copyload19942350 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1.1, !dbg !63

if.end.1.1.1:                                     ; preds = %if.end.1895.1, %if.then.1.1.1
  %107 = phi <4 x half> [ %kr.sroa.102.48.copyload19942350, %if.then.1.1.1 ], [ zeroinitializer, %if.end.1895.1 ], !dbg !64
  %108 = phi <4 x half> [ %kr.sroa.86.48.copyload19852349, %if.then.1.1.1 ], [ zeroinitializer, %if.end.1895.1 ], !dbg !64
  br i1 %or.cond854.1932, label %if.end218.1990, label %if.then164.1962, !dbg !65

if.then164.1962:                                  ; preds = %if.end.1.1.1
  %cmp167.1961 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !66
  br i1 %cmp167.1961, label %for.cond169.preheader.1969, label %if.end218.1990, !dbg !67

for.cond169.preheader.1969:                       ; preds = %if.then164.1962
  %add176.1968 = add nuw nsw i32 %mul11.2, %mul175
  %cmp179.not.1970 = icmp sgt i32 %add176.1968, %1, !dbg !68
  %spec.select.1971 = select i1 %cmp179.not.1970, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.0.vec.insert1435 = insertelement <4 x float> poison, float %spec.select.1971, i64 0, !dbg !70
  %cmp179.not.1.1973.not = icmp slt i32 %add176.1968, %1, !dbg !68
  %spec.select.1.1974 = select i1 %cmp179.not.1.1973.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.0.4.vec.insert1488 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1435, float %spec.select.1.1974, i64 1, !dbg !70
  %add177.2.1976 = or disjoint i32 %add176.1968, 2, !dbg !71
  %cmp179.not.2.1977 = icmp sgt i32 %add177.2.1976, %1, !dbg !68
  %spec.select.2.1978 = select i1 %cmp179.not.2.1977, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.8.vec.insert1541 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1488, float %spec.select.2.1978, i64 2, !dbg !70
  %add177.3.1980 = or disjoint i32 %add176.1968, 3, !dbg !71
  %cmp179.not.3.1981 = icmp sgt i32 %add177.3.1980, %1, !dbg !68
  %spec.select.3.1982 = select i1 %cmp179.not.3.1981, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.12.vec.insert1594 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1541, float %spec.select.3.1982, i64 3, !dbg !70
  br label %if.end218.1990, !dbg !72

if.end218.1990:                                   ; preds = %if.end.1.1.1, %if.then164.1962, %for.cond169.preheader.1969
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1594, %for.cond169.preheader.1969 ], [ zeroinitializer, %if.then164.1962 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1.1 ], !dbg !64
  br i1 %or.cond854.1.1946, label %if.end218.1.1, label %if.then164.1.1, !dbg !65

if.then164.1.1:                                   ; preds = %if.end218.1990
  %cmp167.1.1 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !66
  br i1 %cmp167.1.1, label %for.cond169.preheader.1.1, label %if.end218.1.1, !dbg !67

for.cond169.preheader.1.1:                        ; preds = %if.then164.1.1
  %add176.1.1 = add nuw nsw i32 %mul11.3, %mul175
  %cmp179.not.1897.1 = icmp sgt i32 %add176.1.1, %1, !dbg !68
  %spec.select.1898.1 = select i1 %cmp179.not.1897.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.16.vec.insert1663 = insertelement <4 x float> poison, float %spec.select.1898.1, i64 0, !dbg !70
  %cmp179.not.1.1.1.not = icmp slt i32 %add176.1.1, %1, !dbg !68
  %spec.select.1.1.1 = select i1 %cmp179.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.146.20.vec.insert1716 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1663, float %spec.select.1.1.1, i64 1, !dbg !70
  %add177.2.1.1 = or disjoint i32 %add176.1.1, 2, !dbg !71
  %cmp179.not.2.1.1 = icmp sgt i32 %add177.2.1.1, %1, !dbg !68
  %spec.select.2.1.1 = select i1 %cmp179.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.24.vec.insert1769 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1716, float %spec.select.2.1.1, i64 2, !dbg !70
  %add177.3.1.1 = or disjoint i32 %add176.1.1, 3, !dbg !71
  %cmp179.not.3.1.1 = icmp sgt i32 %add177.3.1.1, %1, !dbg !68
  %spec.select.3.1.1 = select i1 %cmp179.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.28.vec.insert1822 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1769, float %spec.select.3.1.1, i64 3, !dbg !70
  br label %if.end218.1.1, !dbg !72

if.end218.1.1:                                    ; preds = %if.end218.1990, %if.then164.1.1, %for.cond169.preheader.1.1
  %scores.sroa.146.2 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1822, %for.cond169.preheader.1.1 ], [ zeroinitializer, %if.then164.1.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.1990 ], !dbg !64
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %99, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.2), !dbg !73, !call_argsrelate !74
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %102, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.2), !dbg !73, !call_argsrelate !74
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %98, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %109), !dbg !73, !call_argsrelate !74
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %101, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %110), !dbg !73, !call_argsrelate !74
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %105, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %111), !dbg !73, !call_argsrelate !74
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %108, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %112), !dbg !73, !call_argsrelate !74
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %104, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %113), !dbg !73, !call_argsrelate !74
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %107, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %114), !dbg !73, !call_argsrelate !74
  br i1 %or.cond854.1932, label %if.end335.11015, label %for.cond274.preheader.11003, !dbg !75

for.cond274.preheader.11003:                      ; preds = %if.end218.1.1
  %117 = shl nsw i32 %cond.i.i796.2, 10
  %mul281.11001 = and i32 %117, 64512
  %add284.11002 = add nuw nsw i32 %add108, %mul281.11001
  %118 = zext nneg i32 %add284.11002 to i64, !dbg !76
  %add.ptr289.11004 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118, !dbg !77
  %vr.sroa.0.0.copyload12352351 = load <4 x half>, ptr addrspace(4) %add.ptr289.11004, align 16, !dbg !78
  %vr.sroa.22.0.add.ptr289.11004.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.11004, i64 8, !dbg !78
  %vr.sroa.22.0.copyload12442352 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.11004.sroa_idx, align 8, !dbg !78
  %119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118, !dbg !77
  %add.ptr289.1.11005 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1024, !dbg !77
  %vr.sroa.38.16.copyload12812353 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.11005, align 16, !dbg !78
  %vr.sroa.58.16.add.ptr289.1.11005.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1032, !dbg !78
  %vr.sroa.58.16.copyload12902354 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.11005.sroa_idx, align 8, !dbg !78
  br label %if.end335.11015, !dbg !79

if.end335.11015:                                  ; preds = %if.end218.1.1, %for.cond274.preheader.11003
  %120 = phi <4 x half> [ %vr.sroa.58.16.copyload12902354, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ], !dbg !64
  %121 = phi <4 x half> [ %vr.sroa.38.16.copyload12812353, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ], !dbg !64
  %122 = phi <4 x half> [ %vr.sroa.22.0.copyload12442352, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ], !dbg !64
  %123 = phi <4 x half> [ %vr.sroa.0.0.copyload12352351, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ], !dbg !64
  br i1 %or.cond854.1.1946, label %if.end335.1.1, label %for.cond274.preheader.1.1, !dbg !75

for.cond274.preheader.1.1:                        ; preds = %if.end335.11015
  %124 = shl nsw i32 %cond.i.i796.3, 10
  %mul281.1.1 = and i32 %124, 64512
  %add284.1.1 = add nuw nsw i32 %add108, %mul281.1.1
  %125 = zext nneg i32 %add284.1.1 to i64, !dbg !76
  %add.ptr289.1913.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125, !dbg !77
  %vr.sroa.74.32.copyload13272355 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913.1, align 16, !dbg !78
  %vr.sroa.94.32.add.ptr289.1913.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913.1, i64 8, !dbg !78
  %vr.sroa.94.32.copyload13362356 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.1.sroa_idx, align 8, !dbg !78
  %126 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125, !dbg !77
  %add.ptr289.1.1.1 = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1024, !dbg !77
  %vr.sroa.110.48.copyload13732357 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1.1, align 16, !dbg !78
  %vr.sroa.130.48.add.ptr289.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1032, !dbg !78
  %vr.sroa.130.48.copyload13822358 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.1.sroa_idx, align 8, !dbg !78
  br label %if.end335.1.1, !dbg !79

if.end335.1.1:                                    ; preds = %if.end335.11015, %for.cond274.preheader.1.1
  %127 = phi <4 x half> [ %vr.sroa.130.48.copyload13822358, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ], !dbg !64
  %128 = phi <4 x half> [ %vr.sroa.110.48.copyload13732357, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ], !dbg !64
  %129 = phi <4 x half> [ %vr.sroa.94.32.copyload13362356, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ], !dbg !64
  %130 = phi <4 x half> [ %vr.sroa.74.32.copyload13272355, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ], !dbg !64
  br i1 %or.cond854.1932, label %if.end415.11051, label %for.cond352.preheader.11019, !dbg !80

for.cond352.preheader.11019:                      ; preds = %if.end335.1.1
  %scores.sroa.0.0.vec.extract1439 = extractelement <4 x float> %115, i64 0, !dbg !81
  %mul360.11020 = fmul contract float %scores.sroa.0.0.vec.extract1439, 0x3FB99999A0000000, !dbg !82
  %131 = tail call contract noundef float @llvm.minnum.f32(float %mul360.11020, float 0x4024CB5EC0000000), !dbg !83
  %132 = tail call contract noundef float @llvm.exp.f32(float %131), !dbg !86
  %scores.sroa.0.4.vec.extract1492 = extractelement <4 x float> %115, i64 1, !dbg !81
  %mul360.1.11022 = fmul contract float %scores.sroa.0.4.vec.extract1492, 0x3FB99999A0000000, !dbg !82
  %133 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.11022, float 0x4024CB5EC0000000), !dbg !83
  %134 = tail call contract noundef float @llvm.exp.f32(float %133), !dbg !86
  %scores.sroa.0.8.vec.extract1545 = extractelement <4 x float> %115, i64 2, !dbg !81
  %mul360.2.11024 = fmul contract float %scores.sroa.0.8.vec.extract1545, 0x3FB99999A0000000, !dbg !82
  %135 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.11024, float 0x4024CB5EC0000000), !dbg !83
  %136 = tail call contract noundef float @llvm.exp.f32(float %135), !dbg !86
  %scores.sroa.0.12.vec.extract1598 = extractelement <4 x float> %115, i64 3, !dbg !81
  %mul360.3.11026 = fmul contract float %scores.sroa.0.12.vec.extract1598, 0x3FB99999A0000000, !dbg !82
  %137 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.11026, float 0x4024CB5EC0000000), !dbg !83
  %138 = tail call contract noundef float @llvm.exp.f32(float %137), !dbg !86
  %add380.11028 = fadd contract float %sums.sroa.0.1, %132, !dbg !100
  %add380.1.11031 = fadd contract float %sums.sroa.20.1, %134, !dbg !100
  %add380.2.11034 = fadd contract float %sums.sroa.38.1, %136, !dbg !100
  %add380.3.11037 = fadd contract float %sums.sroa.56.1, %138, !dbg !100
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %132), !dbg !89
  %140 = insertelement <4 x i16> poison, i16 %139, i64 0, !dbg !98
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %134), !dbg !89
  %142 = insertelement <4 x i16> %140, i16 %141, i64 1, !dbg !98
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %136), !dbg !89
  %144 = insertelement <4 x i16> %142, i16 %143, i64 2, !dbg !98
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %138), !dbg !89
  %146 = insertelement <4 x i16> %144, i16 %145, i64 3, !dbg !98
  %probs.sroa.0.6.vec.insert1150 = bitcast <4 x i16> %146 to <4 x half>, !dbg !98
  br label %if.end415.11051, !dbg !99

if.end415.11051:                                  ; preds = %if.end335.1.1, %for.cond352.preheader.11019
  %sums.sroa.56.2 = phi float [ %add380.3.11037, %for.cond352.preheader.11019 ], [ %sums.sroa.56.1, %if.end335.1.1 ], !dbg !64
  %sums.sroa.38.2 = phi float [ %add380.2.11034, %for.cond352.preheader.11019 ], [ %sums.sroa.38.1, %if.end335.1.1 ], !dbg !64
  %sums.sroa.20.2 = phi float [ %add380.1.11031, %for.cond352.preheader.11019 ], [ %sums.sroa.20.1, %if.end335.1.1 ], !dbg !64
  %sums.sroa.0.2 = phi float [ %add380.11028, %for.cond352.preheader.11019 ], [ %sums.sroa.0.1, %if.end335.1.1 ], !dbg !64
  %probs.sroa.0.1 = phi <4 x half> [ %probs.sroa.0.6.vec.insert1150, %for.cond352.preheader.11019 ], [ zeroinitializer, %if.end335.1.1 ], !dbg !64
  br i1 %or.cond854.1.1946, label %if.end415.1.1, label %for.cond352.preheader.1.1, !dbg !80

for.cond352.preheader.1.1:                        ; preds = %if.end415.11051
  %scores.sroa.146.16.vec.extract1667 = extractelement <4 x float> %116, i64 0, !dbg !81
  %mul360.1922.1 = fmul contract float %scores.sroa.146.16.vec.extract1667, 0x3FB99999A0000000, !dbg !82
  %147 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922.1, float 0x4024CB5EC0000000), !dbg !83
  %148 = tail call contract noundef float @llvm.exp.f32(float %147), !dbg !86
  %scores.sroa.146.20.vec.extract1720 = extractelement <4 x float> %116, i64 1, !dbg !81
  %mul360.1.1.1 = fmul contract float %scores.sroa.146.20.vec.extract1720, 0x3FB99999A0000000, !dbg !82
  %149 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1.1, float 0x4024CB5EC0000000), !dbg !83
  %150 = tail call contract noundef float @llvm.exp.f32(float %149), !dbg !86
  %scores.sroa.146.24.vec.extract1773 = extractelement <4 x float> %116, i64 2, !dbg !81
  %mul360.2.1.1 = fmul contract float %scores.sroa.146.24.vec.extract1773, 0x3FB99999A0000000, !dbg !82
  %151 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1.1, float 0x4024CB5EC0000000), !dbg !83
  %152 = tail call contract noundef float @llvm.exp.f32(float %151), !dbg !86
  %scores.sroa.146.28.vec.extract1826 = extractelement <4 x float> %116, i64 3, !dbg !81
  %mul360.3.1.1 = fmul contract float %scores.sroa.146.28.vec.extract1826, 0x3FB99999A0000000, !dbg !82
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1.1, float 0x4024CB5EC0000000), !dbg !83
  %154 = tail call contract noundef float @llvm.exp.f32(float %153), !dbg !86
  %add380.1924.1 = fadd contract float %sums.sroa.0.2, %148, !dbg !100
  %add380.1.1.1 = fadd contract float %sums.sroa.20.2, %150, !dbg !100
  %add380.2.1.1 = fadd contract float %sums.sroa.38.2, %152, !dbg !100
  %add380.3.1.1 = fadd contract float %sums.sroa.56.2, %154, !dbg !100
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %148), !dbg !89
  %156 = insertelement <4 x i16> poison, i16 %155, i64 0, !dbg !98
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %150), !dbg !89
  %158 = insertelement <4 x i16> %156, i16 %157, i64 1, !dbg !98
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %152), !dbg !89
  %160 = insertelement <4 x i16> %158, i16 %159, i64 2, !dbg !98
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154), !dbg !89
  %162 = insertelement <4 x i16> %160, i16 %161, i64 3, !dbg !98
  %probs.sroa.46.14.vec.insert1210 = bitcast <4 x i16> %162 to <4 x half>, !dbg !98
  br label %if.end415.1.1, !dbg !99

if.end415.1.1:                                    ; preds = %if.end415.11051, %for.cond352.preheader.1.1
  %sums.sroa.56.3 = phi float [ %add380.3.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.56.2, %if.end415.11051 ], !dbg !64
  %sums.sroa.38.3 = phi float [ %add380.2.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.38.2, %if.end415.11051 ], !dbg !64
  %sums.sroa.20.3 = phi float [ %add380.1.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.20.2, %if.end415.11051 ], !dbg !64
  %sums.sroa.0.3 = phi float [ %add380.1924.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.0.2, %if.end415.11051 ], !dbg !64
  %probs.sroa.46.1 = phi <4 x half> [ %probs.sroa.46.14.vec.insert1210, %for.cond352.preheader.1.1 ], [ zeroinitializer, %if.end415.11051 ], !dbg !64
  br i1 %or.cond854.1932, label %if.end477.11073, label %for.cond434.preheader.11065, !dbg !101

for.cond434.preheader.11065:                      ; preds = %if.end415.1.1
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %123, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.0.0), !dbg !102
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.42.0), !dbg !102
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %121, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.82.0), !dbg !102
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %120, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.122.0), !dbg !102
  br label %if.end477.11073, !dbg !103

if.end477.11073:                                  ; preds = %for.cond434.preheader.11065, %if.end415.1.1
  %out.sroa.122.2 = phi <4 x float> [ %out.sroa.122.0, %if.end415.1.1 ], [ %166, %for.cond434.preheader.11065 ], !dbg !64
  %out.sroa.82.2 = phi <4 x float> [ %out.sroa.82.0, %if.end415.1.1 ], [ %165, %for.cond434.preheader.11065 ], !dbg !64
  %out.sroa.42.2 = phi <4 x float> [ %out.sroa.42.0, %if.end415.1.1 ], [ %164, %for.cond434.preheader.11065 ], !dbg !64
  %out.sroa.0.2 = phi <4 x float> [ %out.sroa.0.0, %if.end415.1.1 ], [ %163, %for.cond434.preheader.11065 ], !dbg !64
  br i1 %or.cond854.1.1946, label %if.end477.1.1, label %for.cond455.preheader.1.1, !dbg !101

for.cond455.preheader.1.1:                        ; preds = %if.end477.11073
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %130, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.0.1), !dbg !104
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %129, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.26.1), !dbg !104
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %128, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.50.1), !dbg !104
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %127, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.74.1), !dbg !104
  br label %if.end477.1.1, !dbg !103

if.end477.1.1:                                    ; preds = %for.cond455.preheader.1.1, %if.end477.11073
  %out_1.sroa.74.3 = phi <4 x float> [ %out_1.sroa.74.1, %if.end477.11073 ], [ %170, %for.cond455.preheader.1.1 ], !dbg !64
  %out_1.sroa.50.3 = phi <4 x float> [ %out_1.sroa.50.1, %if.end477.11073 ], [ %169, %for.cond455.preheader.1.1 ], !dbg !64
  %out_1.sroa.26.3 = phi <4 x float> [ %out_1.sroa.26.1, %if.end477.11073 ], [ %168, %for.cond455.preheader.1.1 ], !dbg !64
  %out_1.sroa.0.3 = phi <4 x float> [ %out_1.sroa.0.1, %if.end477.11073 ], [ %167, %for.cond455.preheader.1.1 ], !dbg !64
  %or.cond.2 = icmp ugt i32 %mul11.4, 1023, !dbg !58
  %cmp101.not.2 = icmp sgt i32 %mul11.4, %1
  %or.cond854.2 = or i1 %or.cond.2, %cmp101.not.2, !dbg !58
  br i1 %or.cond854.2, label %if.end.2, label %if.then.2, !dbg !58

if.then.2:                                        ; preds = %if.end477.1.1
  %171 = shl nsw i32 %cond.i.i796.4, 10, !dbg !59
  %mul105.2 = and i32 %171, 64512, !dbg !59
  %add111.2 = add nuw nsw i32 %add108, %mul105.2, !dbg !60
  %idx.ext112.2 = zext nneg i32 %add111.2 to i64, !dbg !61
  %add.ptr113.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.2, !dbg !61
  %kr.sroa.0.0.copyload18722359 = load <4 x half>, ptr addrspace(4) %add.ptr113.2, align 16, !dbg !62
  %kr.sroa.18.0.add.ptr113.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.2, i64 8, !dbg !62
  %kr.sroa.18.0.copyload18812360 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.2.sroa_idx, align 8, !dbg !62
  br label %if.end.2, !dbg !63

if.end.2:                                         ; preds = %if.end477.1.1, %if.then.2
  %172 = phi <4 x half> [ %kr.sroa.18.0.copyload18812360, %if.then.2 ], [ zeroinitializer, %if.end477.1.1 ], !dbg !64
  %173 = phi <4 x half> [ %kr.sroa.0.0.copyload18722359, %if.then.2 ], [ zeroinitializer, %if.end477.1.1 ], !dbg !64
  %or.cond.1.2 = icmp ugt i32 %mul11.5, 1023, !dbg !58
  %cmp101.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond854.1.2 = or i1 %or.cond.1.2, %cmp101.not.1.2, !dbg !58
  br i1 %or.cond854.1.2, label %if.end.1.2, label %if.then.1.2, !dbg !58

if.then.1.2:                                      ; preds = %if.end.2
  %174 = shl nsw i32 %cond.i.i796.5, 10, !dbg !59
  %mul105.1.2 = and i32 %174, 64512, !dbg !59
  %add111.1.2 = add nuw nsw i32 %add108, %mul105.1.2, !dbg !60
  %idx.ext112.1.2 = zext nneg i32 %add111.1.2 to i64, !dbg !61
  %add.ptr113.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.2, !dbg !61
  %kr.sroa.30.16.copyload19102361 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.2, align 16, !dbg !62
  %kr.sroa.46.16.add.ptr113.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.2, i64 8, !dbg !62
  %kr.sroa.46.16.copyload19192362 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.2.sroa_idx, align 8, !dbg !62
  br label %if.end.1.2, !dbg !63

if.end.1.2:                                       ; preds = %if.end.2, %if.then.1.2
  %175 = phi <4 x half> [ %kr.sroa.46.16.copyload19192362, %if.then.1.2 ], [ zeroinitializer, %if.end.2 ], !dbg !64
  %176 = phi <4 x half> [ %kr.sroa.30.16.copyload19102361, %if.then.1.2 ], [ zeroinitializer, %if.end.2 ], !dbg !64
  br i1 %or.cond854.2, label %if.end.1895.2, label %if.then.1888.2, !dbg !58

if.then.1888.2:                                   ; preds = %if.end.1.2
  %177 = shl nsw i32 %cond.i.i796.4, 10, !dbg !59
  %mul105.1882.2 = and i32 %177, 64512, !dbg !59
  %add111.1883.2 = add nuw nsw i32 %add106.1, %mul105.1882.2, !dbg !60
  %idx.ext112.1884.2 = zext nneg i32 %add111.1883.2 to i64, !dbg !61
  %add.ptr113.1885.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884.2, !dbg !61
  %kr.sroa.58.32.copyload19482363 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885.2, align 16, !dbg !62
  %kr.sroa.74.32.add.ptr113.1885.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885.2, i64 8, !dbg !62
  %kr.sroa.74.32.copyload19572364 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.2.sroa_idx, align 8, !dbg !62
  br label %if.end.1895.2, !dbg !63

if.end.1895.2:                                    ; preds = %if.end.1.2, %if.then.1888.2
  %178 = phi <4 x half> [ %kr.sroa.74.32.copyload19572364, %if.then.1888.2 ], [ zeroinitializer, %if.end.1.2 ], !dbg !64
  %179 = phi <4 x half> [ %kr.sroa.58.32.copyload19482363, %if.then.1888.2 ], [ zeroinitializer, %if.end.1.2 ], !dbg !64
  br i1 %or.cond854.1.2, label %if.end.1.1.2, label %if.then.1.1.2, !dbg !58

if.then.1.1.2:                                    ; preds = %if.end.1895.2
  %180 = shl nsw i32 %cond.i.i796.5, 10, !dbg !59
  %mul105.1.1.2 = and i32 %180, 64512, !dbg !59
  %add111.1.1.2 = add nuw nsw i32 %add106.1, %mul105.1.1.2, !dbg !60
  %idx.ext112.1.1.2 = zext nneg i32 %add111.1.1.2 to i64, !dbg !61
  %add.ptr113.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1.2, !dbg !61
  %kr.sroa.86.48.copyload19862365 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1.2, align 16, !dbg !62
  %kr.sroa.102.48.add.ptr113.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1.2, i64 8, !dbg !62
  %kr.sroa.102.48.copyload19952366 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.2.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1.2, !dbg !63

if.end.1.1.2:                                     ; preds = %if.end.1895.2, %if.then.1.1.2
  %181 = phi <4 x half> [ %kr.sroa.102.48.copyload19952366, %if.then.1.1.2 ], [ zeroinitializer, %if.end.1895.2 ], !dbg !64
  %182 = phi <4 x half> [ %kr.sroa.86.48.copyload19862365, %if.then.1.1.2 ], [ zeroinitializer, %if.end.1895.2 ], !dbg !64
  br i1 %or.cond854.2, label %if.end218.2, label %if.then164.2, !dbg !65

if.then164.2:                                     ; preds = %if.end.1.1.2
  %cmp167.2 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !66
  br i1 %cmp167.2, label %for.cond169.preheader.2, label %if.end218.2, !dbg !67

for.cond169.preheader.2:                          ; preds = %if.then164.2
  %add176.2 = add nuw nsw i32 %mul11.4, %mul175
  %cmp179.not.21074 = icmp sgt i32 %add176.2, %1, !dbg !68
  %spec.select.21075 = select i1 %cmp179.not.21074, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.0.vec.insert1449 = insertelement <4 x float> poison, float %spec.select.21075, i64 0, !dbg !70
  %cmp179.not.1.2.not = icmp slt i32 %add176.2, %1, !dbg !68
  %spec.select.1.2 = select i1 %cmp179.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.0.4.vec.insert1502 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1449, float %spec.select.1.2, i64 1, !dbg !70
  %add177.2.2 = or disjoint i32 %add176.2, 2, !dbg !71
  %cmp179.not.2.2 = icmp sgt i32 %add177.2.2, %1, !dbg !68
  %spec.select.2.2 = select i1 %cmp179.not.2.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.8.vec.insert1555 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1502, float %spec.select.2.2, i64 2, !dbg !70
  %add177.3.2 = or disjoint i32 %add176.2, 3, !dbg !71
  %cmp179.not.3.2 = icmp sgt i32 %add177.3.2, %1, !dbg !68
  %spec.select.3.2 = select i1 %cmp179.not.3.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.12.vec.insert1608 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1555, float %spec.select.3.2, i64 3, !dbg !70
  br label %if.end218.2, !dbg !72

if.end218.2:                                      ; preds = %if.end.1.1.2, %if.then164.2, %for.cond169.preheader.2
  %scores.sroa.0.4 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1608, %for.cond169.preheader.2 ], [ zeroinitializer, %if.then164.2 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1.2 ], !dbg !64
  br i1 %or.cond854.1.2, label %if.end218.1.2, label %if.then164.1.2, !dbg !65

if.then164.1.2:                                   ; preds = %if.end218.2
  %cmp167.1.2 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !66
  br i1 %cmp167.1.2, label %for.cond169.preheader.1.2, label %if.end218.1.2, !dbg !67

for.cond169.preheader.1.2:                        ; preds = %if.then164.1.2
  %add176.1.2 = add nuw nsw i32 %mul11.5, %mul175
  %cmp179.not.1897.2 = icmp sgt i32 %add176.1.2, %1, !dbg !68
  %spec.select.1898.2 = select i1 %cmp179.not.1897.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.16.vec.insert1677 = insertelement <4 x float> poison, float %spec.select.1898.2, i64 0, !dbg !70
  %cmp179.not.1.1.2.not = icmp slt i32 %add176.1.2, %1, !dbg !68
  %spec.select.1.1.2 = select i1 %cmp179.not.1.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.146.20.vec.insert1730 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1677, float %spec.select.1.1.2, i64 1, !dbg !70
  %add177.2.1.2 = or disjoint i32 %add176.1.2, 2, !dbg !71
  %cmp179.not.2.1.2 = icmp sgt i32 %add177.2.1.2, %1, !dbg !68
  %spec.select.2.1.2 = select i1 %cmp179.not.2.1.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.24.vec.insert1783 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1730, float %spec.select.2.1.2, i64 2, !dbg !70
  %add177.3.1.2 = or disjoint i32 %add176.1.2, 3, !dbg !71
  %cmp179.not.3.1.2 = icmp sgt i32 %add177.3.1.2, %1, !dbg !68
  %spec.select.3.1.2 = select i1 %cmp179.not.3.1.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.28.vec.insert1836 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1783, float %spec.select.3.1.2, i64 3, !dbg !70
  br label %if.end218.1.2, !dbg !72

if.end218.1.2:                                    ; preds = %if.end218.2, %if.then164.1.2, %for.cond169.preheader.1.2
  %scores.sroa.146.4 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1836, %for.cond169.preheader.1.2 ], [ zeroinitializer, %if.then164.1.2 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.2 ], !dbg !64
  %183 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %173, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.4), !dbg !73, !call_argsrelate !74
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %176, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.4), !dbg !73, !call_argsrelate !74
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %172, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %183), !dbg !73, !call_argsrelate !74
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %175, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %184), !dbg !73, !call_argsrelate !74
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %179, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %185), !dbg !73, !call_argsrelate !74
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %182, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %186), !dbg !73, !call_argsrelate !74
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %178, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %187), !dbg !73, !call_argsrelate !74
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %181, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %188), !dbg !73, !call_argsrelate !74
  br i1 %or.cond854.2, label %if.end335.2, label %for.cond274.preheader.2, !dbg !75

for.cond274.preheader.2:                          ; preds = %if.end218.1.2
  %191 = shl nsw i32 %cond.i.i796.4, 10
  %mul281.2 = and i32 %191, 64512
  %add284.2 = add nuw nsw i32 %add108, %mul281.2
  %192 = zext nneg i32 %add284.2 to i64, !dbg !76
  %add.ptr289.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %192, !dbg !77
  %vr.sroa.0.0.copyload12362375 = load <4 x half>, ptr addrspace(4) %add.ptr289.2, align 16, !dbg !78
  %vr.sroa.22.0.add.ptr289.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.2, i64 8, !dbg !78
  %vr.sroa.22.0.copyload12452376 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.2.sroa_idx, align 8, !dbg !78
  %193 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %192, !dbg !77
  %add.ptr289.1.2 = getelementptr inbounds i8, ptr addrspace(4) %193, i64 1024, !dbg !77
  %vr.sroa.38.16.copyload12822377 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.2, align 16, !dbg !78
  %vr.sroa.58.16.add.ptr289.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %193, i64 1032, !dbg !78
  %vr.sroa.58.16.copyload12912378 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.2.sroa_idx, align 8, !dbg !78
  br label %if.end335.2, !dbg !79

if.end335.2:                                      ; preds = %if.end218.1.2, %for.cond274.preheader.2
  %194 = phi <4 x half> [ %vr.sroa.58.16.copyload12912378, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ], !dbg !64
  %195 = phi <4 x half> [ %vr.sroa.38.16.copyload12822377, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ], !dbg !64
  %196 = phi <4 x half> [ %vr.sroa.22.0.copyload12452376, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ], !dbg !64
  %197 = phi <4 x half> [ %vr.sroa.0.0.copyload12362375, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ], !dbg !64
  br i1 %or.cond854.1.2, label %if.end335.1.2, label %for.cond274.preheader.1.2, !dbg !75

for.cond274.preheader.1.2:                        ; preds = %if.end335.2
  %198 = shl nsw i32 %cond.i.i796.5, 10
  %mul281.1.2 = and i32 %198, 64512
  %add284.1.2 = add nuw nsw i32 %add108, %mul281.1.2
  %199 = zext nneg i32 %add284.1.2 to i64, !dbg !76
  %add.ptr289.1913.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !77
  %vr.sroa.74.32.copyload13282379 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913.2, align 16, !dbg !78
  %vr.sroa.94.32.add.ptr289.1913.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913.2, i64 8, !dbg !78
  %vr.sroa.94.32.copyload13372380 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.2.sroa_idx, align 8, !dbg !78
  %200 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !77
  %add.ptr289.1.1.2 = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1024, !dbg !77
  %vr.sroa.110.48.copyload13742381 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1.2, align 16, !dbg !78
  %vr.sroa.130.48.add.ptr289.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1032, !dbg !78
  %vr.sroa.130.48.copyload13832382 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.2.sroa_idx, align 8, !dbg !78
  br label %if.end335.1.2, !dbg !79

if.end335.1.2:                                    ; preds = %if.end335.2, %for.cond274.preheader.1.2
  %201 = phi <4 x half> [ %vr.sroa.130.48.copyload13832382, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  %202 = phi <4 x half> [ %vr.sroa.110.48.copyload13742381, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  %203 = phi <4 x half> [ %vr.sroa.94.32.copyload13372380, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  %204 = phi <4 x half> [ %vr.sroa.74.32.copyload13282379, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  br i1 %or.cond854.2, label %if.end415.2, label %for.cond352.preheader.2, !dbg !80

for.cond352.preheader.2:                          ; preds = %if.end335.1.2
  %scores.sroa.0.0.vec.extract1453 = extractelement <4 x float> %189, i64 0, !dbg !81
  %mul360.21076 = fmul contract float %scores.sroa.0.0.vec.extract1453, 0x3FB99999A0000000, !dbg !82
  %205 = tail call contract noundef float @llvm.minnum.f32(float %mul360.21076, float 0x4024CB5EC0000000), !dbg !83
  %206 = tail call contract noundef float @llvm.exp.f32(float %205), !dbg !86
  %scores.sroa.0.4.vec.extract1506 = extractelement <4 x float> %189, i64 1, !dbg !81
  %mul360.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1506, 0x3FB99999A0000000, !dbg !82
  %207 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.2, float 0x4024CB5EC0000000), !dbg !83
  %208 = tail call contract noundef float @llvm.exp.f32(float %207), !dbg !86
  %scores.sroa.0.8.vec.extract1559 = extractelement <4 x float> %189, i64 2, !dbg !81
  %mul360.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1559, 0x3FB99999A0000000, !dbg !82
  %209 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.2, float 0x4024CB5EC0000000), !dbg !83
  %210 = tail call contract noundef float @llvm.exp.f32(float %209), !dbg !86
  %scores.sroa.0.12.vec.extract1612 = extractelement <4 x float> %189, i64 3, !dbg !81
  %mul360.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1612, 0x3FB99999A0000000, !dbg !82
  %211 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.2, float 0x4024CB5EC0000000), !dbg !83
  %212 = tail call contract noundef float @llvm.exp.f32(float %211), !dbg !86
  %add380.21077 = fadd contract float %sums.sroa.0.3, %206, !dbg !100
  %add380.1.2 = fadd contract float %sums.sroa.20.3, %208, !dbg !100
  %add380.2.2 = fadd contract float %sums.sroa.38.3, %210, !dbg !100
  %add380.3.2 = fadd contract float %sums.sroa.56.3, %212, !dbg !100
  %213 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %206), !dbg !89
  %214 = insertelement <4 x i16> poison, i16 %213, i64 0, !dbg !98
  %215 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %208), !dbg !89
  %216 = insertelement <4 x i16> %214, i16 %215, i64 1, !dbg !98
  %217 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %210), !dbg !89
  %218 = insertelement <4 x i16> %216, i16 %217, i64 2, !dbg !98
  %219 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %212), !dbg !89
  %220 = insertelement <4 x i16> %218, i16 %219, i64 3, !dbg !98
  %probs.sroa.0.6.vec.insert1154 = bitcast <4 x i16> %220 to <4 x half>, !dbg !98
  br label %if.end415.2, !dbg !99

if.end415.2:                                      ; preds = %if.end335.1.2, %for.cond352.preheader.2
  %sums.sroa.56.4 = phi float [ %add380.3.2, %for.cond352.preheader.2 ], [ %sums.sroa.56.3, %if.end335.1.2 ], !dbg !64
  %sums.sroa.38.4 = phi float [ %add380.2.2, %for.cond352.preheader.2 ], [ %sums.sroa.38.3, %if.end335.1.2 ], !dbg !64
  %sums.sroa.20.4 = phi float [ %add380.1.2, %for.cond352.preheader.2 ], [ %sums.sroa.20.3, %if.end335.1.2 ], !dbg !64
  %sums.sroa.0.4 = phi float [ %add380.21077, %for.cond352.preheader.2 ], [ %sums.sroa.0.3, %if.end335.1.2 ], !dbg !64
  %probs.sroa.0.2 = phi <4 x half> [ %probs.sroa.0.6.vec.insert1154, %for.cond352.preheader.2 ], [ zeroinitializer, %if.end335.1.2 ], !dbg !64
  br i1 %or.cond854.1.2, label %if.end415.1.2, label %for.cond352.preheader.1.2, !dbg !80

for.cond352.preheader.1.2:                        ; preds = %if.end415.2
  %scores.sroa.146.16.vec.extract1681 = extractelement <4 x float> %190, i64 0, !dbg !81
  %mul360.1922.2 = fmul contract float %scores.sroa.146.16.vec.extract1681, 0x3FB99999A0000000, !dbg !82
  %221 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922.2, float 0x4024CB5EC0000000), !dbg !83
  %222 = tail call contract noundef float @llvm.exp.f32(float %221), !dbg !86
  %scores.sroa.146.20.vec.extract1734 = extractelement <4 x float> %190, i64 1, !dbg !81
  %mul360.1.1.2 = fmul contract float %scores.sroa.146.20.vec.extract1734, 0x3FB99999A0000000, !dbg !82
  %223 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1.2, float 0x4024CB5EC0000000), !dbg !83
  %224 = tail call contract noundef float @llvm.exp.f32(float %223), !dbg !86
  %scores.sroa.146.24.vec.extract1787 = extractelement <4 x float> %190, i64 2, !dbg !81
  %mul360.2.1.2 = fmul contract float %scores.sroa.146.24.vec.extract1787, 0x3FB99999A0000000, !dbg !82
  %225 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1.2, float 0x4024CB5EC0000000), !dbg !83
  %226 = tail call contract noundef float @llvm.exp.f32(float %225), !dbg !86
  %scores.sroa.146.28.vec.extract1840 = extractelement <4 x float> %190, i64 3, !dbg !81
  %mul360.3.1.2 = fmul contract float %scores.sroa.146.28.vec.extract1840, 0x3FB99999A0000000, !dbg !82
  %227 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1.2, float 0x4024CB5EC0000000), !dbg !83
  %228 = tail call contract noundef float @llvm.exp.f32(float %227), !dbg !86
  %add380.1924.2 = fadd contract float %sums.sroa.0.4, %222, !dbg !100
  %add380.1.1.2 = fadd contract float %sums.sroa.20.4, %224, !dbg !100
  %add380.2.1.2 = fadd contract float %sums.sroa.38.4, %226, !dbg !100
  %add380.3.1.2 = fadd contract float %sums.sroa.56.4, %228, !dbg !100
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %222), !dbg !89
  %230 = insertelement <4 x i16> poison, i16 %229, i64 0, !dbg !98
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %224), !dbg !89
  %232 = insertelement <4 x i16> %230, i16 %231, i64 1, !dbg !98
  %233 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %226), !dbg !89
  %234 = insertelement <4 x i16> %232, i16 %233, i64 2, !dbg !98
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %228), !dbg !89
  %236 = insertelement <4 x i16> %234, i16 %235, i64 3, !dbg !98
  %probs.sroa.46.14.vec.insert1214 = bitcast <4 x i16> %236 to <4 x half>, !dbg !98
  br label %if.end415.1.2, !dbg !99

if.end415.1.2:                                    ; preds = %if.end415.2, %for.cond352.preheader.1.2
  %sums.sroa.56.5 = phi float [ %add380.3.1.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.56.4, %if.end415.2 ], !dbg !64
  %sums.sroa.38.5 = phi float [ %add380.2.1.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.38.4, %if.end415.2 ], !dbg !64
  %sums.sroa.20.5 = phi float [ %add380.1.1.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.20.4, %if.end415.2 ], !dbg !64
  %sums.sroa.0.5 = phi float [ %add380.1924.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.0.4, %if.end415.2 ], !dbg !64
  %probs.sroa.46.2 = phi <4 x half> [ %probs.sroa.46.14.vec.insert1214, %for.cond352.preheader.1.2 ], [ zeroinitializer, %if.end415.2 ], !dbg !64
  br i1 %or.cond854.2, label %if.end477.2, label %for.cond434.preheader.2, !dbg !101

for.cond434.preheader.2:                          ; preds = %if.end415.1.2
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %197, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.0.2), !dbg !102
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %196, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.42.2), !dbg !102
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %195, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.82.2), !dbg !102
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %194, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.122.2), !dbg !102
  br label %if.end477.2, !dbg !103

if.end477.2:                                      ; preds = %for.cond434.preheader.2, %if.end415.1.2
  %out.sroa.122.4 = phi <4 x float> [ %out.sroa.122.2, %if.end415.1.2 ], [ %240, %for.cond434.preheader.2 ], !dbg !64
  %out.sroa.82.4 = phi <4 x float> [ %out.sroa.82.2, %if.end415.1.2 ], [ %239, %for.cond434.preheader.2 ], !dbg !64
  %out.sroa.42.4 = phi <4 x float> [ %out.sroa.42.2, %if.end415.1.2 ], [ %238, %for.cond434.preheader.2 ], !dbg !64
  %out.sroa.0.4 = phi <4 x float> [ %out.sroa.0.2, %if.end415.1.2 ], [ %237, %for.cond434.preheader.2 ], !dbg !64
  br i1 %or.cond854.1.2, label %if.end477.1.2, label %for.cond455.preheader.1.2, !dbg !101

for.cond455.preheader.1.2:                        ; preds = %if.end477.2
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %204, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.0.3), !dbg !104
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %203, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.26.3), !dbg !104
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %202, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.50.3), !dbg !104
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %201, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.74.3), !dbg !104
  br label %if.end477.1.2, !dbg !103

if.end477.1.2:                                    ; preds = %for.cond455.preheader.1.2, %if.end477.2
  %out_1.sroa.74.5 = phi <4 x float> [ %out_1.sroa.74.3, %if.end477.2 ], [ %244, %for.cond455.preheader.1.2 ], !dbg !64
  %out_1.sroa.50.5 = phi <4 x float> [ %out_1.sroa.50.3, %if.end477.2 ], [ %243, %for.cond455.preheader.1.2 ], !dbg !64
  %out_1.sroa.26.5 = phi <4 x float> [ %out_1.sroa.26.3, %if.end477.2 ], [ %242, %for.cond455.preheader.1.2 ], !dbg !64
  %out_1.sroa.0.5 = phi <4 x float> [ %out_1.sroa.0.3, %if.end477.2 ], [ %241, %for.cond455.preheader.1.2 ], !dbg !64
  %or.cond.3 = icmp ugt i32 %mul11.6, 1023, !dbg !58
  %cmp101.not.3 = icmp sgt i32 %mul11.6, %1
  %or.cond854.3 = or i1 %or.cond.3, %cmp101.not.3, !dbg !58
  br i1 %or.cond854.3, label %if.end.3, label %if.then.3, !dbg !58

if.then.3:                                        ; preds = %if.end477.1.2
  %245 = shl nsw i32 %cond.i.i796.6, 10, !dbg !59
  %mul105.3 = and i32 %245, 64512, !dbg !59
  %add111.3 = add nuw nsw i32 %add108, %mul105.3, !dbg !60
  %idx.ext112.3 = zext nneg i32 %add111.3 to i64, !dbg !61
  %add.ptr113.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.3, !dbg !61
  %kr.sroa.0.0.copyload18732367 = load <4 x half>, ptr addrspace(4) %add.ptr113.3, align 16, !dbg !62
  %kr.sroa.18.0.add.ptr113.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.3, i64 8, !dbg !62
  %kr.sroa.18.0.copyload18822369 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.3.sroa_idx, align 8, !dbg !62
  br label %if.end.3, !dbg !63

if.end.3:                                         ; preds = %if.end477.1.2, %if.then.3
  %246 = phi <4 x half> [ %kr.sroa.18.0.copyload18822369, %if.then.3 ], [ zeroinitializer, %if.end477.1.2 ], !dbg !64
  %247 = phi <4 x half> [ %kr.sroa.0.0.copyload18732367, %if.then.3 ], [ zeroinitializer, %if.end477.1.2 ], !dbg !64
  %or.cond.1.3 = icmp ugt i32 %mul11.7, 1023, !dbg !58
  %cmp101.not.1.3 = icmp sgt i32 %mul11.7, %1
  %or.cond854.1.3 = or i1 %or.cond.1.3, %cmp101.not.1.3, !dbg !58
  br i1 %or.cond854.1.3, label %if.end.1.3, label %if.then.1.3, !dbg !58

if.then.1.3:                                      ; preds = %if.end.3
  %248 = shl nsw i32 %cond.i.i796.7, 10, !dbg !59
  %mul105.1.3 = and i32 %248, 64512, !dbg !59
  %add111.1.3 = add nuw nsw i32 %add108, %mul105.1.3, !dbg !60
  %idx.ext112.1.3 = zext nneg i32 %add111.1.3 to i64, !dbg !61
  %add.ptr113.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.3, !dbg !61
  %kr.sroa.30.16.copyload19112368 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.3, align 16, !dbg !62
  %kr.sroa.46.16.add.ptr113.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.3, i64 8, !dbg !62
  %kr.sroa.46.16.copyload19202370 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.3.sroa_idx, align 8, !dbg !62
  br label %if.end.1.3, !dbg !63

if.end.1.3:                                       ; preds = %if.end.3, %if.then.1.3
  %249 = phi <4 x half> [ %kr.sroa.46.16.copyload19202370, %if.then.1.3 ], [ zeroinitializer, %if.end.3 ], !dbg !64
  %250 = phi <4 x half> [ %kr.sroa.30.16.copyload19112368, %if.then.1.3 ], [ zeroinitializer, %if.end.3 ], !dbg !64
  br i1 %or.cond854.3, label %if.end.1895.3, label %if.then.1888.3, !dbg !58

if.then.1888.3:                                   ; preds = %if.end.1.3
  %251 = shl nsw i32 %cond.i.i796.6, 10, !dbg !59
  %mul105.1882.3 = and i32 %251, 64512, !dbg !59
  %add111.1883.3 = add nuw nsw i32 %add106.1, %mul105.1882.3, !dbg !60
  %idx.ext112.1884.3 = zext nneg i32 %add111.1883.3 to i64, !dbg !61
  %add.ptr113.1885.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884.3, !dbg !61
  %kr.sroa.58.32.copyload19492371 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885.3, align 16, !dbg !62
  %kr.sroa.74.32.add.ptr113.1885.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885.3, i64 8, !dbg !62
  %kr.sroa.74.32.copyload19582373 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.3.sroa_idx, align 8, !dbg !62
  br label %if.end.1895.3, !dbg !63

if.end.1895.3:                                    ; preds = %if.end.1.3, %if.then.1888.3
  %252 = phi <4 x half> [ %kr.sroa.74.32.copyload19582373, %if.then.1888.3 ], [ zeroinitializer, %if.end.1.3 ], !dbg !64
  %253 = phi <4 x half> [ %kr.sroa.58.32.copyload19492371, %if.then.1888.3 ], [ zeroinitializer, %if.end.1.3 ], !dbg !64
  br i1 %or.cond854.1.3, label %if.end.1.1.3, label %if.then.1.1.3, !dbg !58

if.then.1.1.3:                                    ; preds = %if.end.1895.3
  %254 = shl nsw i32 %cond.i.i796.7, 10, !dbg !59
  %mul105.1.1.3 = and i32 %254, 64512, !dbg !59
  %add111.1.1.3 = add nuw nsw i32 %add106.1, %mul105.1.1.3, !dbg !60
  %idx.ext112.1.1.3 = zext nneg i32 %add111.1.1.3 to i64, !dbg !61
  %add.ptr113.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1.3, !dbg !61
  %kr.sroa.86.48.copyload19872372 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1.3, align 16, !dbg !62
  %kr.sroa.102.48.add.ptr113.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1.3, i64 8, !dbg !62
  %kr.sroa.102.48.copyload19962374 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.3.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1.3, !dbg !63

if.end.1.1.3:                                     ; preds = %if.end.1895.3, %if.then.1.1.3
  %255 = phi <4 x half> [ %kr.sroa.102.48.copyload19962374, %if.then.1.1.3 ], [ zeroinitializer, %if.end.1895.3 ], !dbg !64
  %256 = phi <4 x half> [ %kr.sroa.86.48.copyload19872372, %if.then.1.1.3 ], [ zeroinitializer, %if.end.1895.3 ], !dbg !64
  br i1 %or.cond854.3, label %if.end218.3, label %if.then164.3, !dbg !65

if.then164.3:                                     ; preds = %if.end.1.1.3
  %cmp167.3 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !66
  br i1 %cmp167.3, label %for.cond169.preheader.3, label %if.end218.3, !dbg !67

for.cond169.preheader.3:                          ; preds = %if.then164.3
  %add176.3 = add nuw nsw i32 %mul11.6, %mul175
  %cmp179.not.31079 = icmp sgt i32 %add176.3, %1, !dbg !68
  %spec.select.31080 = select i1 %cmp179.not.31079, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.0.vec.insert1463 = insertelement <4 x float> poison, float %spec.select.31080, i64 0, !dbg !70
  %cmp179.not.1.3.not = icmp slt i32 %add176.3, %1, !dbg !68
  %spec.select.1.3 = select i1 %cmp179.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.0.4.vec.insert1516 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1463, float %spec.select.1.3, i64 1, !dbg !70
  %add177.2.3 = or disjoint i32 %add176.3, 2, !dbg !71
  %cmp179.not.2.3 = icmp sgt i32 %add177.2.3, %1, !dbg !68
  %spec.select.2.3 = select i1 %cmp179.not.2.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.8.vec.insert1569 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1516, float %spec.select.2.3, i64 2, !dbg !70
  %add177.3.3 = or disjoint i32 %add176.3, 3, !dbg !71
  %cmp179.not.3.3 = icmp sgt i32 %add177.3.3, %1, !dbg !68
  %spec.select.3.3 = select i1 %cmp179.not.3.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.12.vec.insert1622 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1569, float %spec.select.3.3, i64 3, !dbg !70
  br label %if.end218.3, !dbg !72

if.end218.3:                                      ; preds = %if.end.1.1.3, %if.then164.3, %for.cond169.preheader.3
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1622, %for.cond169.preheader.3 ], [ zeroinitializer, %if.then164.3 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1.3 ], !dbg !64
  br i1 %or.cond854.1.3, label %if.end218.1.3, label %if.then164.1.3, !dbg !65

if.then164.1.3:                                   ; preds = %if.end218.3
  %cmp167.1.3 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !66
  br i1 %cmp167.1.3, label %for.cond169.preheader.1.3, label %if.end218.1.3, !dbg !67

for.cond169.preheader.1.3:                        ; preds = %if.then164.1.3
  %add176.1.3 = add nuw nsw i32 %mul11.7, %mul175
  %cmp179.not.1897.3 = icmp sgt i32 %add176.1.3, %1, !dbg !68
  %spec.select.1898.3 = select i1 %cmp179.not.1897.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.16.vec.insert1691 = insertelement <4 x float> poison, float %spec.select.1898.3, i64 0, !dbg !70
  %cmp179.not.1.1.3.not = icmp slt i32 %add176.1.3, %1, !dbg !68
  %spec.select.1.1.3 = select i1 %cmp179.not.1.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.146.20.vec.insert1744 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1691, float %spec.select.1.1.3, i64 1, !dbg !70
  %add177.2.1.3 = or disjoint i32 %add176.1.3, 2, !dbg !71
  %cmp179.not.2.1.3 = icmp sgt i32 %add177.2.1.3, %1, !dbg !68
  %spec.select.2.1.3 = select i1 %cmp179.not.2.1.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.24.vec.insert1797 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1744, float %spec.select.2.1.3, i64 2, !dbg !70
  %add177.3.1.3 = or disjoint i32 %add176.1.3, 3, !dbg !71
  %cmp179.not.3.1.3 = icmp sgt i32 %add177.3.1.3, %1, !dbg !68
  %spec.select.3.1.3 = select i1 %cmp179.not.3.1.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.28.vec.insert1850 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1797, float %spec.select.3.1.3, i64 3, !dbg !70
  br label %if.end218.1.3, !dbg !72

if.end218.1.3:                                    ; preds = %if.end218.3, %if.then164.1.3, %for.cond169.preheader.1.3
  %scores.sroa.146.6 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1850, %for.cond169.preheader.1.3 ], [ zeroinitializer, %if.then164.1.3 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.3 ], !dbg !64
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %247, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.6), !dbg !73, !call_argsrelate !74
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %250, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.6), !dbg !73, !call_argsrelate !74
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %246, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %257), !dbg !73, !call_argsrelate !74
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %249, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %258), !dbg !73, !call_argsrelate !74
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %253, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %259), !dbg !73, !call_argsrelate !74
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %256, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %260), !dbg !73, !call_argsrelate !74
  %263 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %252, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %261), !dbg !73, !call_argsrelate !74
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %255, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %262), !dbg !73, !call_argsrelate !74
  br i1 %or.cond854.3, label %if.end335.3, label %for.cond274.preheader.3, !dbg !75

for.cond274.preheader.3:                          ; preds = %if.end218.1.3
  %265 = shl nsw i32 %cond.i.i796.6, 10
  %mul281.3 = and i32 %265, 64512
  %add284.3 = add nuw nsw i32 %add108, %mul281.3
  %266 = zext nneg i32 %add284.3 to i64, !dbg !76
  %add.ptr289.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %266, !dbg !77
  %vr.sroa.0.0.copyload12372383 = load <4 x half>, ptr addrspace(4) %add.ptr289.3, align 16, !dbg !78
  %vr.sroa.22.0.add.ptr289.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.3, i64 8, !dbg !78
  %vr.sroa.22.0.copyload12462384 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.3.sroa_idx, align 8, !dbg !78
  %267 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %266, !dbg !77
  %add.ptr289.1.3 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1024, !dbg !77
  %vr.sroa.38.16.copyload12832385 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.3, align 16, !dbg !78
  %vr.sroa.58.16.add.ptr289.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1032, !dbg !78
  %vr.sroa.58.16.copyload12922386 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.3.sroa_idx, align 8, !dbg !78
  br label %if.end335.3, !dbg !79

if.end335.3:                                      ; preds = %if.end218.1.3, %for.cond274.preheader.3
  %268 = phi <4 x half> [ %vr.sroa.58.16.copyload12922386, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ], !dbg !64
  %269 = phi <4 x half> [ %vr.sroa.38.16.copyload12832385, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ], !dbg !64
  %270 = phi <4 x half> [ %vr.sroa.22.0.copyload12462384, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ], !dbg !64
  %271 = phi <4 x half> [ %vr.sroa.0.0.copyload12372383, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ], !dbg !64
  br i1 %or.cond854.1.3, label %if.end335.1.3, label %for.cond274.preheader.1.3, !dbg !75

for.cond274.preheader.1.3:                        ; preds = %if.end335.3
  %272 = shl nsw i32 %cond.i.i796.7, 10
  %mul281.1.3 = and i32 %272, 64512
  %add284.1.3 = add nuw nsw i32 %add108, %mul281.1.3
  %273 = zext nneg i32 %add284.1.3 to i64, !dbg !76
  %add.ptr289.1913.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273, !dbg !77
  %vr.sroa.74.32.copyload13292387 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913.3, align 16, !dbg !78
  %vr.sroa.94.32.add.ptr289.1913.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913.3, i64 8, !dbg !78
  %vr.sroa.94.32.copyload13382388 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.3.sroa_idx, align 8, !dbg !78
  %274 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273, !dbg !77
  %add.ptr289.1.1.3 = getelementptr inbounds i8, ptr addrspace(4) %274, i64 1024, !dbg !77
  %vr.sroa.110.48.copyload13752389 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1.3, align 16, !dbg !78
  %vr.sroa.130.48.add.ptr289.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %274, i64 1032, !dbg !78
  %vr.sroa.130.48.copyload13842390 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.3.sroa_idx, align 8, !dbg !78
  br label %if.end335.1.3, !dbg !79

if.end335.1.3:                                    ; preds = %if.end335.3, %for.cond274.preheader.1.3
  %275 = phi <4 x half> [ %vr.sroa.130.48.copyload13842390, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ], !dbg !64
  %276 = phi <4 x half> [ %vr.sroa.110.48.copyload13752389, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ], !dbg !64
  %277 = phi <4 x half> [ %vr.sroa.94.32.copyload13382388, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ], !dbg !64
  %278 = phi <4 x half> [ %vr.sroa.74.32.copyload13292387, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ], !dbg !64
  br i1 %or.cond854.3, label %if.end415.3, label %for.cond352.preheader.3, !dbg !80

for.cond352.preheader.3:                          ; preds = %if.end335.1.3
  %scores.sroa.0.0.vec.extract1467 = extractelement <4 x float> %263, i64 0, !dbg !81
  %mul360.31081 = fmul contract float %scores.sroa.0.0.vec.extract1467, 0x3FB99999A0000000, !dbg !82
  %279 = tail call contract noundef float @llvm.minnum.f32(float %mul360.31081, float 0x4024CB5EC0000000), !dbg !83
  %280 = tail call contract noundef float @llvm.exp.f32(float %279), !dbg !86
  %scores.sroa.0.4.vec.extract1520 = extractelement <4 x float> %263, i64 1, !dbg !81
  %mul360.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1520, 0x3FB99999A0000000, !dbg !82
  %281 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.3, float 0x4024CB5EC0000000), !dbg !83
  %282 = tail call contract noundef float @llvm.exp.f32(float %281), !dbg !86
  %scores.sroa.0.8.vec.extract1573 = extractelement <4 x float> %263, i64 2, !dbg !81
  %mul360.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1573, 0x3FB99999A0000000, !dbg !82
  %283 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.3, float 0x4024CB5EC0000000), !dbg !83
  %284 = tail call contract noundef float @llvm.exp.f32(float %283), !dbg !86
  %scores.sroa.0.12.vec.extract1626 = extractelement <4 x float> %263, i64 3, !dbg !81
  %mul360.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1626, 0x3FB99999A0000000, !dbg !82
  %285 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.3, float 0x4024CB5EC0000000), !dbg !83
  %286 = tail call contract noundef float @llvm.exp.f32(float %285), !dbg !86
  %add380.31082 = fadd contract float %sums.sroa.0.5, %280, !dbg !100
  %add380.1.3 = fadd contract float %sums.sroa.20.5, %282, !dbg !100
  %add380.2.3 = fadd contract float %sums.sroa.38.5, %284, !dbg !100
  %add380.3.3 = fadd contract float %sums.sroa.56.5, %286, !dbg !100
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %280), !dbg !89
  %288 = insertelement <4 x i16> poison, i16 %287, i64 0, !dbg !98
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %282), !dbg !89
  %290 = insertelement <4 x i16> %288, i16 %289, i64 1, !dbg !98
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %284), !dbg !89
  %292 = insertelement <4 x i16> %290, i16 %291, i64 2, !dbg !98
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %286), !dbg !89
  %294 = insertelement <4 x i16> %292, i16 %293, i64 3, !dbg !98
  %probs.sroa.0.6.vec.insert1158 = bitcast <4 x i16> %294 to <4 x half>, !dbg !98
  br label %if.end415.3, !dbg !99

if.end415.3:                                      ; preds = %if.end335.1.3, %for.cond352.preheader.3
  %sums.sroa.56.6 = phi float [ %add380.3.3, %for.cond352.preheader.3 ], [ %sums.sroa.56.5, %if.end335.1.3 ], !dbg !64
  %sums.sroa.38.6 = phi float [ %add380.2.3, %for.cond352.preheader.3 ], [ %sums.sroa.38.5, %if.end335.1.3 ], !dbg !64
  %sums.sroa.20.6 = phi float [ %add380.1.3, %for.cond352.preheader.3 ], [ %sums.sroa.20.5, %if.end335.1.3 ], !dbg !64
  %sums.sroa.0.6 = phi float [ %add380.31082, %for.cond352.preheader.3 ], [ %sums.sroa.0.5, %if.end335.1.3 ], !dbg !64
  %probs.sroa.0.3 = phi <4 x half> [ %probs.sroa.0.6.vec.insert1158, %for.cond352.preheader.3 ], [ zeroinitializer, %if.end335.1.3 ], !dbg !64
  br i1 %or.cond854.1.3, label %if.end415.1.3, label %for.cond352.preheader.1.3, !dbg !80

for.cond352.preheader.1.3:                        ; preds = %if.end415.3
  %scores.sroa.146.16.vec.extract1695 = extractelement <4 x float> %264, i64 0, !dbg !81
  %mul360.1922.3 = fmul contract float %scores.sroa.146.16.vec.extract1695, 0x3FB99999A0000000, !dbg !82
  %295 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922.3, float 0x4024CB5EC0000000), !dbg !83
  %296 = tail call contract noundef float @llvm.exp.f32(float %295), !dbg !86
  %scores.sroa.146.20.vec.extract1748 = extractelement <4 x float> %264, i64 1, !dbg !81
  %mul360.1.1.3 = fmul contract float %scores.sroa.146.20.vec.extract1748, 0x3FB99999A0000000, !dbg !82
  %297 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1.3, float 0x4024CB5EC0000000), !dbg !83
  %298 = tail call contract noundef float @llvm.exp.f32(float %297), !dbg !86
  %scores.sroa.146.24.vec.extract1801 = extractelement <4 x float> %264, i64 2, !dbg !81
  %mul360.2.1.3 = fmul contract float %scores.sroa.146.24.vec.extract1801, 0x3FB99999A0000000, !dbg !82
  %299 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1.3, float 0x4024CB5EC0000000), !dbg !83
  %300 = tail call contract noundef float @llvm.exp.f32(float %299), !dbg !86
  %scores.sroa.146.28.vec.extract1854 = extractelement <4 x float> %264, i64 3, !dbg !81
  %mul360.3.1.3 = fmul contract float %scores.sroa.146.28.vec.extract1854, 0x3FB99999A0000000, !dbg !82
  %301 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1.3, float 0x4024CB5EC0000000), !dbg !83
  %302 = tail call contract noundef float @llvm.exp.f32(float %301), !dbg !86
  %add380.1924.3 = fadd contract float %sums.sroa.0.6, %296, !dbg !100
  %add380.1.1.3 = fadd contract float %sums.sroa.20.6, %298, !dbg !100
  %add380.2.1.3 = fadd contract float %sums.sroa.38.6, %300, !dbg !100
  %add380.3.1.3 = fadd contract float %sums.sroa.56.6, %302, !dbg !100
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %296), !dbg !89
  %304 = insertelement <4 x i16> poison, i16 %303, i64 0, !dbg !98
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %298), !dbg !89
  %306 = insertelement <4 x i16> %304, i16 %305, i64 1, !dbg !98
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %300), !dbg !89
  %308 = insertelement <4 x i16> %306, i16 %307, i64 2, !dbg !98
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %302), !dbg !89
  %310 = insertelement <4 x i16> %308, i16 %309, i64 3, !dbg !98
  %probs.sroa.46.14.vec.insert1218 = bitcast <4 x i16> %310 to <4 x half>, !dbg !98
  br label %if.end415.1.3, !dbg !99

if.end415.1.3:                                    ; preds = %if.end415.3, %for.cond352.preheader.1.3
  %sums.sroa.56.7 = phi float [ %add380.3.1.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.56.6, %if.end415.3 ], !dbg !64
  %sums.sroa.38.7 = phi float [ %add380.2.1.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.38.6, %if.end415.3 ], !dbg !64
  %sums.sroa.20.7 = phi float [ %add380.1.1.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.20.6, %if.end415.3 ], !dbg !64
  %sums.sroa.0.7 = phi float [ %add380.1924.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.0.6, %if.end415.3 ], !dbg !64
  %probs.sroa.46.3 = phi <4 x half> [ %probs.sroa.46.14.vec.insert1218, %for.cond352.preheader.1.3 ], [ zeroinitializer, %if.end415.3 ], !dbg !64
  br i1 %or.cond854.3, label %if.end477.3, label %for.cond434.preheader.3, !dbg !101

for.cond434.preheader.3:                          ; preds = %if.end415.1.3
  %311 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %271, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.0.4), !dbg !102
  %312 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %270, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.42.4), !dbg !102
  %313 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %269, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.82.4), !dbg !102
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %268, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.122.4), !dbg !102
  br label %if.end477.3, !dbg !103

if.end477.3:                                      ; preds = %for.cond434.preheader.3, %if.end415.1.3
  %out.sroa.122.6 = phi <4 x float> [ %out.sroa.122.4, %if.end415.1.3 ], [ %314, %for.cond434.preheader.3 ], !dbg !64
  %out.sroa.82.6 = phi <4 x float> [ %out.sroa.82.4, %if.end415.1.3 ], [ %313, %for.cond434.preheader.3 ], !dbg !64
  %out.sroa.42.6 = phi <4 x float> [ %out.sroa.42.4, %if.end415.1.3 ], [ %312, %for.cond434.preheader.3 ], !dbg !64
  %out.sroa.0.6 = phi <4 x float> [ %out.sroa.0.4, %if.end415.1.3 ], [ %311, %for.cond434.preheader.3 ], !dbg !64
  br i1 %or.cond854.1.3, label %if.end477.1.3, label %for.cond455.preheader.1.3, !dbg !101

for.cond455.preheader.1.3:                        ; preds = %if.end477.3
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %278, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.0.5), !dbg !104
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %277, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.26.5), !dbg !104
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %276, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.50.5), !dbg !104
  %318 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %275, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.74.5), !dbg !104
  br label %if.end477.1.3, !dbg !103

if.end477.1.3:                                    ; preds = %for.cond455.preheader.1.3, %if.end477.3
  %out_1.sroa.74.7 = phi <4 x float> [ %out_1.sroa.74.5, %if.end477.3 ], [ %318, %for.cond455.preheader.1.3 ], !dbg !64
  %out_1.sroa.50.7 = phi <4 x float> [ %out_1.sroa.50.5, %if.end477.3 ], [ %317, %for.cond455.preheader.1.3 ], !dbg !64
  %out_1.sroa.26.7 = phi <4 x float> [ %out_1.sroa.26.5, %if.end477.3 ], [ %316, %for.cond455.preheader.1.3 ], !dbg !64
  %out_1.sroa.0.7 = phi <4 x float> [ %out_1.sroa.0.5, %if.end477.3 ], [ %315, %for.cond455.preheader.1.3 ], !dbg !64
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 0, !dbg !105
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 0, !dbg !106
  %add492 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract, !dbg !107
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 1, !dbg !105
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 1, !dbg !106
  %add492.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract, !dbg !107
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 2, !dbg !105
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 2, !dbg !106
  %add492.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract, !dbg !107
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 3, !dbg !105
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 3, !dbg !106
  %add492.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract, !dbg !107
  %out.sroa.42.16.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 0, !dbg !105
  %out_1.sroa.26.16.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 0, !dbg !106
  %add492.4 = fadd contract float %out.sroa.42.16.vec.extract, %out_1.sroa.26.16.vec.extract, !dbg !107
  %out.sroa.42.20.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 1, !dbg !105
  %out_1.sroa.26.20.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 1, !dbg !106
  %add492.5 = fadd contract float %out.sroa.42.20.vec.extract, %out_1.sroa.26.20.vec.extract, !dbg !107
  %out.sroa.42.24.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 2, !dbg !105
  %out_1.sroa.26.24.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 2, !dbg !106
  %add492.6 = fadd contract float %out.sroa.42.24.vec.extract, %out_1.sroa.26.24.vec.extract, !dbg !107
  %out.sroa.42.28.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 3, !dbg !105
  %out_1.sroa.26.28.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 3, !dbg !106
  %add492.7 = fadd contract float %out.sroa.42.28.vec.extract, %out_1.sroa.26.28.vec.extract, !dbg !107
  %out.sroa.82.32.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 0, !dbg !105
  %out_1.sroa.50.32.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 0, !dbg !106
  %add492.8 = fadd contract float %out.sroa.82.32.vec.extract, %out_1.sroa.50.32.vec.extract, !dbg !107
  %out.sroa.82.36.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 1, !dbg !105
  %out_1.sroa.50.36.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 1, !dbg !106
  %add492.9 = fadd contract float %out.sroa.82.36.vec.extract, %out_1.sroa.50.36.vec.extract, !dbg !107
  %out.sroa.82.40.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 2, !dbg !105
  %out_1.sroa.50.40.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 2, !dbg !106
  %add492.10 = fadd contract float %out.sroa.82.40.vec.extract, %out_1.sroa.50.40.vec.extract, !dbg !107
  %out.sroa.82.44.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 3, !dbg !105
  %out_1.sroa.50.44.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 3, !dbg !106
  %add492.11 = fadd contract float %out.sroa.82.44.vec.extract, %out_1.sroa.50.44.vec.extract, !dbg !107
  %out.sroa.122.48.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 0, !dbg !105
  %out_1.sroa.74.48.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 0, !dbg !106
  %add492.12 = fadd contract float %out.sroa.122.48.vec.extract, %out_1.sroa.74.48.vec.extract, !dbg !107
  %out.sroa.122.52.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 1, !dbg !105
  %out_1.sroa.74.52.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 1, !dbg !106
  %add492.13 = fadd contract float %out.sroa.122.52.vec.extract, %out_1.sroa.74.52.vec.extract, !dbg !107
  %out.sroa.122.56.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 2, !dbg !105
  %out_1.sroa.74.56.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 2, !dbg !106
  %add492.14 = fadd contract float %out.sroa.122.56.vec.extract, %out_1.sroa.74.56.vec.extract, !dbg !107
  %out.sroa.122.60.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 3, !dbg !105
  %out_1.sroa.74.60.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 3, !dbg !106
  %add492.15 = fadd contract float %out.sroa.122.60.vec.extract, %out_1.sroa.74.60.vec.extract, !dbg !107
  %add506 = fadd contract float %sums.sroa.0.7, 0.000000e+00, !dbg !108
  %add506.1 = fadd contract float %add506, %sums.sroa.20.7, !dbg !108
  %add506.2 = fadd contract float %add506.1, %sums.sroa.38.7, !dbg !108
  %add506.3 = fadd contract float %add506.2, %sums.sroa.56.7, !dbg !108
  %319 = bitcast float %add506.3 to i32, !dbg !109
  %320 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !121
  %321 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %320) #11, !dbg !126
  %xor.i.i = xor i32 %321, 32, !dbg !127
  %322 = and i32 %321, -64, !dbg !128
  %and.i.i = add nsw i32 %322, 64, !dbg !128
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !129
  %cond.i.i801 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %321, !dbg !130
  %shl.i.i = shl i32 %cond.i.i801, 2, !dbg !131
  %323 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %319), !dbg !132
  %324 = bitcast i32 %323 to float, !dbg !133
  %add.i = fadd contract float %add506.3, %324, !dbg !134
  %325 = bitcast float %add.i to i32, !dbg !137
  %326 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !144
  %327 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %326) #11, !dbg !147
  %xor.i.i802 = xor i32 %327, 16, !dbg !148
  %328 = and i32 %327, -64, !dbg !149
  %and.i.i803 = add nsw i32 %328, 64, !dbg !149
  %cmp.not.i.i804 = icmp slt i32 %xor.i.i802, %and.i.i803, !dbg !150
  %cond.i.i805 = select i1 %cmp.not.i.i804, i32 %xor.i.i802, i32 %327, !dbg !151
  %shl.i.i806 = shl i32 %cond.i.i805, 2, !dbg !152
  %329 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i806, i32 %325), !dbg !153
  %330 = bitcast i32 %329 to float, !dbg !154
  %add.i.i = fadd contract float %add.i, %330, !dbg !155
  %cmp515 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !157
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !158
  %condval_1.0 = select i1 %cmp515, float %div, float 0.000000e+00, !dbg !158
  %mul528 = fmul contract float %condval_1.0, %add492, !dbg !159
  %mul528.1 = fmul contract float %condval_1.0, %add492.1, !dbg !159
  %mul528.2 = fmul contract float %condval_1.0, %add492.2, !dbg !159
  %mul528.3 = fmul contract float %condval_1.0, %add492.3, !dbg !159
  %mul528.4 = fmul contract float %condval_1.0, %add492.4, !dbg !159
  %mul528.5 = fmul contract float %condval_1.0, %add492.5, !dbg !159
  %mul528.6 = fmul contract float %condval_1.0, %add492.6, !dbg !159
  %mul528.7 = fmul contract float %condval_1.0, %add492.7, !dbg !159
  %mul528.8 = fmul contract float %condval_1.0, %add492.8, !dbg !159
  %mul528.9 = fmul contract float %condval_1.0, %add492.9, !dbg !159
  %mul528.10 = fmul contract float %condval_1.0, %add492.10, !dbg !159
  %mul528.11 = fmul contract float %condval_1.0, %add492.11, !dbg !159
  %mul528.12 = fmul contract float %condval_1.0, %add492.12, !dbg !159
  %mul528.13 = fmul contract float %condval_1.0, %add492.13, !dbg !159
  %mul528.14 = fmul contract float %condval_1.0, %add492.14, !dbg !159
  %mul528.15 = fmul contract float %condval_1.0, %add492.15, !dbg !159
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528), !dbg !160
  %O_reg.sroa.0.0.insert.ext = zext i16 %331 to i64, !dbg !164
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.1), !dbg !160
  %O_reg.sroa.0.2.insert.ext = zext i16 %332 to i64, !dbg !164
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !164
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !164
  %333 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.2), !dbg !160
  %O_reg.sroa.0.4.insert.ext = zext i16 %333 to i64, !dbg !164
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !164
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !164
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.3), !dbg !160
  %O_reg.sroa.0.6.insert.ext = zext i16 %334 to i64, !dbg !164
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !164
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !164
  %335 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.4), !dbg !160
  %O_reg.sroa.7.8.insert.ext = zext i16 %335 to i64, !dbg !164
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.5), !dbg !160
  %O_reg.sroa.7.10.insert.ext = zext i16 %336 to i64, !dbg !164
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !164
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !164
  %337 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.6), !dbg !160
  %O_reg.sroa.7.12.insert.ext = zext i16 %337 to i64, !dbg !164
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !164
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !164
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.7), !dbg !160
  %O_reg.sroa.7.14.insert.ext = zext i16 %338 to i64, !dbg !164
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !164
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !164
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.8), !dbg !160
  %O_reg.sroa.12.16.insert.ext = zext i16 %339 to i64, !dbg !164
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.9), !dbg !160
  %O_reg.sroa.12.18.insert.ext = zext i16 %340 to i64, !dbg !164
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !164
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !164
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.10), !dbg !160
  %O_reg.sroa.12.20.insert.ext = zext i16 %341 to i64, !dbg !164
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !164
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !164
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.11), !dbg !160
  %O_reg.sroa.12.22.insert.ext = zext i16 %342 to i64, !dbg !164
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !164
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !164
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.12), !dbg !160
  %O_reg.sroa.17.24.insert.ext = zext i16 %343 to i64, !dbg !164
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.13), !dbg !160
  %O_reg.sroa.17.26.insert.ext = zext i16 %344 to i64, !dbg !164
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !164
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !164
  %345 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.14), !dbg !160
  %O_reg.sroa.17.28.insert.ext = zext i16 %345 to i64, !dbg !164
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !164
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !164
  %346 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.15), !dbg !160
  %O_reg.sroa.17.30.insert.ext = zext i16 %346 to i64, !dbg !164
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !164
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !164
  %shr570 = lshr i32 %18, 5
  %and573 = and i32 %18, 7
  %mul579 = and i32 %22, 4
  %xor = xor i32 %shr570, %and573, !dbg !165
  %mul574 = shl nuw nsw i32 %xor, 3, !dbg !166
  %add575 = add nuw nsw i32 %mul574, %mul25, !dbg !167
  %add580 = or disjoint i32 %add575, %mul579, !dbg !168
  %add.ptr582 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580, !dbg !169
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr582, align 8, !dbg !170
  %add571.1 = add nuw nsw i32 %shr570, 2, !dbg !171
  %xor.1 = xor i32 %add571.1, %and573, !dbg !165
  %mul574.1 = shl nuw nsw i32 %xor.1, 3, !dbg !166
  %add575.1 = add nuw nsw i32 %mul574.1, %mul25, !dbg !167
  %add580.1 = or disjoint i32 %add575.1, %mul579, !dbg !168
  %add.ptr582.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580.1, !dbg !169
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr582.1, align 8, !dbg !170
  %add571.2 = add nuw nsw i32 %shr570, 4, !dbg !171
  %xor.2 = xor i32 %add571.2, %and573, !dbg !165
  %mul574.2 = shl nuw nsw i32 %xor.2, 3, !dbg !166
  %add575.2 = add nuw nsw i32 %mul574.2, %mul25, !dbg !167
  %add580.2 = or disjoint i32 %add575.2, %mul579, !dbg !168
  %add.ptr582.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580.2, !dbg !169
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr582.2, align 8, !dbg !170
  %add571.3 = add nuw nsw i32 %shr570, 6, !dbg !171
  %xor.3 = xor i32 %add571.3, %and573, !dbg !165
  %mul574.3 = shl nuw nsw i32 %xor.3, 3, !dbg !166
  %add575.3 = add nuw nsw i32 %mul574.3, %mul25, !dbg !167
  %add580.3 = or disjoint i32 %add575.3, %mul579, !dbg !168
  %add.ptr582.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580.3, !dbg !169
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr582.3, align 8, !dbg !170
  fence syncscope("warp") release, !dbg !172
  tail call void @llvm.mxc.barrier.warp(), !dbg !177
  fence syncscope("warp") acquire, !dbg !178
  %mul593 = and i32 %mul110, 8128
  %xor599758 = and i32 %mul110, 56
  %call597.masked = and i32 %18, 1016
  %mul600 = xor i32 %xor599758, %call597.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul593, !dbg !179
  %invariant.gep851 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul600, !dbg !179
  %add610 = add nuw nsw i32 %add23, %mul110
  %347 = zext nneg i32 %add610 to i64, !dbg !180
  %add.ptr615 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr615, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep851, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
  %gep852.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep851, i32 1024, !dbg !185
  %348 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !181
  %add.ptr615.1 = getelementptr inbounds i8, ptr addrspace(1) %348, i64 1024, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr615.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep852.1, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
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
!1 = !DIFile(filename: "/tmp/tmp16izrl_h/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp16izrl_h/tvm_kernels.maca", directory: "")
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
