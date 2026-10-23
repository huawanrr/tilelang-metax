; ModuleID = 'experiments/20261017_resume/s8_wide_v2_binary/oj12_m3_p1.bc'
source_filename = "/tmp/tmpkht84h34/tvm_kernels.maca"
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
  %cond.i.i788 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i788, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i788.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i788.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i788.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i788.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i788.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i788.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i788.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i788.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i788.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i788.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i788.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i788.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i788.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i788.7, 4, !dbg !52
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
  %qr.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !57
  %qr.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !57
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64, !dbg !56
  %qr.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !57
  %qr.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72, !dbg !57
  %qr.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !57
  %mul98 = shl nsw i32 %0, 16
  %mul105 = shl nuw nsw i32 %18, 3
  %add103 = or disjoint i32 %mul105, %mul98
  %or.cond = icmp ugt i32 %mul11, 1023, !dbg !58
  %cmp96.not = icmp sgt i32 %mul11, %1
  %or.cond845 = or i1 %or.cond, %cmp96.not, !dbg !58
  br i1 %or.cond845, label %if.end, label %if.then, !dbg !58

if.then:                                          ; preds = %entry
  %22 = shl nsw i32 %cond.i.i788, 10, !dbg !59
  %mul100 = and i32 %22, 64512, !dbg !59
  %add106 = add nuw nsw i32 %add103, %mul100, !dbg !60
  %idx.ext107 = zext nneg i32 %add106 to i64, !dbg !61
  %add.ptr108 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107, !dbg !61
  %kr.sroa.0.0.copyload1832 = load <4 x half>, ptr addrspace(4) %add.ptr108, align 16, !dbg !62
  %kr.sroa.6.0.add.ptr108.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108, i64 8, !dbg !62
  %kr.sroa.6.0.copyload1840 = load <4 x half>, ptr addrspace(4) %kr.sroa.6.0.add.ptr108.sroa_idx, align 8, !dbg !62
  br label %if.end, !dbg !63

if.end:                                           ; preds = %entry, %if.then
  %23 = phi <4 x half> [ %kr.sroa.6.0.copyload1840, %if.then ], [ zeroinitializer, %entry ], !dbg !64
  %24 = phi <4 x half> [ %kr.sroa.0.0.copyload1832, %if.then ], [ zeroinitializer, %entry ], !dbg !64
  %or.cond.1 = icmp ugt i32 %mul11.1, 1023, !dbg !58
  %cmp96.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond845.1 = or i1 %or.cond.1, %cmp96.not.1, !dbg !58
  br i1 %or.cond845.1, label %if.end.1, label %if.then.1, !dbg !58

if.then.1:                                        ; preds = %if.end
  %25 = shl nsw i32 %cond.i.i788.1, 10, !dbg !59
  %mul100.1 = and i32 %25, 64512, !dbg !59
  %add106.1 = add nuw nsw i32 %add103, %mul100.1, !dbg !60
  %idx.ext107.1 = zext nneg i32 %add106.1 to i64, !dbg !61
  %add.ptr108.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.1, !dbg !61
  %kr.sroa.9.16.copyload1833 = load <4 x half>, ptr addrspace(4) %add.ptr108.1, align 16, !dbg !62
  %kr.sroa.13.16.add.ptr108.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1, i64 8, !dbg !62
  %kr.sroa.13.16.copyload1841 = load <4 x half>, ptr addrspace(4) %kr.sroa.13.16.add.ptr108.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1, !dbg !63

if.end.1:                                         ; preds = %if.end, %if.then.1
  %26 = phi <4 x half> [ %kr.sroa.13.16.copyload1841, %if.then.1 ], [ zeroinitializer, %if.end ], !dbg !64
  %27 = phi <4 x half> [ %kr.sroa.9.16.copyload1833, %if.then.1 ], [ zeroinitializer, %if.end ], !dbg !64
  %or.cond.2 = icmp ugt i32 %mul11.2, 1023, !dbg !58
  %cmp96.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond845.2 = or i1 %or.cond.2, %cmp96.not.2, !dbg !58
  br i1 %or.cond845.2, label %if.end.2, label %if.then.2, !dbg !58

if.then.2:                                        ; preds = %if.end.1
  %28 = shl nsw i32 %cond.i.i788.2, 10, !dbg !59
  %mul100.2 = and i32 %28, 64512, !dbg !59
  %add106.2 = add nuw nsw i32 %add103, %mul100.2, !dbg !60
  %idx.ext107.2 = zext nneg i32 %add106.2 to i64, !dbg !61
  %add.ptr108.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.2, !dbg !61
  %kr.sroa.16.32.copyload1834 = load <4 x half>, ptr addrspace(4) %add.ptr108.2, align 16, !dbg !62
  %kr.sroa.20.32.add.ptr108.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.2, i64 8, !dbg !62
  %kr.sroa.20.32.copyload1842 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.32.add.ptr108.2.sroa_idx, align 8, !dbg !62
  br label %if.end.2, !dbg !63

if.end.2:                                         ; preds = %if.end.1, %if.then.2
  %29 = phi <4 x half> [ %kr.sroa.20.32.copyload1842, %if.then.2 ], [ zeroinitializer, %if.end.1 ], !dbg !64
  %30 = phi <4 x half> [ %kr.sroa.16.32.copyload1834, %if.then.2 ], [ zeroinitializer, %if.end.1 ], !dbg !64
  %or.cond.3 = icmp ugt i32 %mul11.3, 1023, !dbg !58
  %cmp96.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond845.3 = or i1 %or.cond.3, %cmp96.not.3, !dbg !58
  br i1 %or.cond845.3, label %if.end.3, label %if.then.3, !dbg !58

if.then.3:                                        ; preds = %if.end.2
  %31 = shl nsw i32 %cond.i.i788.3, 10, !dbg !59
  %mul100.3 = and i32 %31, 64512, !dbg !59
  %add106.3 = add nuw nsw i32 %add103, %mul100.3, !dbg !60
  %idx.ext107.3 = zext nneg i32 %add106.3 to i64, !dbg !61
  %add.ptr108.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.3, !dbg !61
  %kr.sroa.23.48.copyload1835 = load <4 x half>, ptr addrspace(4) %add.ptr108.3, align 16, !dbg !62
  %kr.sroa.27.48.add.ptr108.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.3, i64 8, !dbg !62
  %kr.sroa.27.48.copyload1843 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.48.add.ptr108.3.sroa_idx, align 8, !dbg !62
  br label %if.end.3, !dbg !63

if.end.3:                                         ; preds = %if.end.2, %if.then.3
  %32 = phi <4 x half> [ %kr.sroa.27.48.copyload1843, %if.then.3 ], [ zeroinitializer, %if.end.2 ], !dbg !64
  %33 = phi <4 x half> [ %kr.sroa.23.48.copyload1835, %if.then.3 ], [ zeroinitializer, %if.end.2 ], !dbg !64
  %or.cond.4 = icmp ugt i32 %mul11.4, 1023, !dbg !58
  %cmp96.not.4 = icmp sgt i32 %mul11.4, %1
  %or.cond845.4 = or i1 %or.cond.4, %cmp96.not.4, !dbg !58
  br i1 %or.cond845.4, label %if.end.4, label %if.then.4, !dbg !58

if.then.4:                                        ; preds = %if.end.3
  %34 = shl nsw i32 %cond.i.i788.4, 10, !dbg !59
  %mul100.4 = and i32 %34, 64512, !dbg !59
  %add106.4 = add nuw nsw i32 %add103, %mul100.4, !dbg !60
  %idx.ext107.4 = zext nneg i32 %add106.4 to i64, !dbg !61
  %add.ptr108.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.4, !dbg !61
  %kr.sroa.30.64.copyload1836 = load <4 x half>, ptr addrspace(4) %add.ptr108.4, align 16, !dbg !62
  %kr.sroa.34.64.add.ptr108.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.4, i64 8, !dbg !62
  %kr.sroa.34.64.copyload1844 = load <4 x half>, ptr addrspace(4) %kr.sroa.34.64.add.ptr108.4.sroa_idx, align 8, !dbg !62
  br label %if.end.4, !dbg !63

if.end.4:                                         ; preds = %if.end.3, %if.then.4
  %35 = phi <4 x half> [ %kr.sroa.34.64.copyload1844, %if.then.4 ], [ zeroinitializer, %if.end.3 ], !dbg !64
  %36 = phi <4 x half> [ %kr.sroa.30.64.copyload1836, %if.then.4 ], [ zeroinitializer, %if.end.3 ], !dbg !64
  %or.cond.5 = icmp ugt i32 %mul11.5, 1023, !dbg !58
  %cmp96.not.5 = icmp sgt i32 %mul11.5, %1
  %or.cond845.5 = or i1 %or.cond.5, %cmp96.not.5, !dbg !58
  br i1 %or.cond845.5, label %if.end.5, label %if.then.5, !dbg !58

if.then.5:                                        ; preds = %if.end.4
  %37 = shl nsw i32 %cond.i.i788.5, 10, !dbg !59
  %mul100.5 = and i32 %37, 64512, !dbg !59
  %add106.5 = add nuw nsw i32 %add103, %mul100.5, !dbg !60
  %idx.ext107.5 = zext nneg i32 %add106.5 to i64, !dbg !61
  %add.ptr108.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.5, !dbg !61
  %kr.sroa.37.80.copyload1837 = load <4 x half>, ptr addrspace(4) %add.ptr108.5, align 16, !dbg !62
  %kr.sroa.41.80.add.ptr108.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.5, i64 8, !dbg !62
  %kr.sroa.41.80.copyload1845 = load <4 x half>, ptr addrspace(4) %kr.sroa.41.80.add.ptr108.5.sroa_idx, align 8, !dbg !62
  br label %if.end.5, !dbg !63

if.end.5:                                         ; preds = %if.end.4, %if.then.5
  %38 = phi <4 x half> [ %kr.sroa.41.80.copyload1845, %if.then.5 ], [ zeroinitializer, %if.end.4 ], !dbg !64
  %39 = phi <4 x half> [ %kr.sroa.37.80.copyload1837, %if.then.5 ], [ zeroinitializer, %if.end.4 ], !dbg !64
  %or.cond.6 = icmp ugt i32 %mul11.6, 1023, !dbg !58
  %cmp96.not.6 = icmp sgt i32 %mul11.6, %1
  %or.cond845.6 = or i1 %or.cond.6, %cmp96.not.6, !dbg !58
  br i1 %or.cond845.6, label %if.end.6, label %if.then.6, !dbg !58

if.then.6:                                        ; preds = %if.end.5
  %40 = shl nsw i32 %cond.i.i788.6, 10, !dbg !59
  %mul100.6 = and i32 %40, 64512, !dbg !59
  %add106.6 = add nuw nsw i32 %add103, %mul100.6, !dbg !60
  %idx.ext107.6 = zext nneg i32 %add106.6 to i64, !dbg !61
  %add.ptr108.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.6, !dbg !61
  %kr.sroa.44.96.copyload1838 = load <4 x half>, ptr addrspace(4) %add.ptr108.6, align 16, !dbg !62
  %kr.sroa.48.96.add.ptr108.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.6, i64 8, !dbg !62
  %kr.sroa.48.96.copyload1846 = load <4 x half>, ptr addrspace(4) %kr.sroa.48.96.add.ptr108.6.sroa_idx, align 8, !dbg !62
  br label %if.end.6, !dbg !63

if.end.6:                                         ; preds = %if.end.5, %if.then.6
  %41 = phi <4 x half> [ %kr.sroa.48.96.copyload1846, %if.then.6 ], [ zeroinitializer, %if.end.5 ], !dbg !64
  %42 = phi <4 x half> [ %kr.sroa.44.96.copyload1838, %if.then.6 ], [ zeroinitializer, %if.end.5 ], !dbg !64
  %or.cond.7 = icmp ugt i32 %mul11.7, 1023, !dbg !58
  %cmp96.not.7 = icmp sgt i32 %mul11.7, %1
  %or.cond845.7 = or i1 %or.cond.7, %cmp96.not.7, !dbg !58
  br i1 %or.cond845.7, label %if.end.7, label %if.then.7, !dbg !58

if.then.7:                                        ; preds = %if.end.6
  %43 = shl nsw i32 %cond.i.i788.7, 10, !dbg !59
  %mul100.7 = and i32 %43, 64512, !dbg !59
  %add106.7 = add nuw nsw i32 %add103, %mul100.7, !dbg !60
  %idx.ext107.7 = zext nneg i32 %add106.7 to i64, !dbg !61
  %add.ptr108.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.7, !dbg !61
  %kr.sroa.51.112.copyload1839 = load <4 x half>, ptr addrspace(4) %add.ptr108.7, align 16, !dbg !62
  %kr.sroa.55.112.add.ptr108.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.7, i64 8, !dbg !62
  %kr.sroa.55.112.copyload1847 = load <4 x half>, ptr addrspace(4) %kr.sroa.55.112.add.ptr108.7.sroa_idx, align 8, !dbg !62
  br label %if.end.7, !dbg !63

if.end.7:                                         ; preds = %if.end.6, %if.then.7
  %44 = phi <4 x half> [ %kr.sroa.55.112.copyload1847, %if.then.7 ], [ zeroinitializer, %if.end.6 ], !dbg !64
  %45 = phi <4 x half> [ %kr.sroa.51.112.copyload1839, %if.then.7 ], [ zeroinitializer, %if.end.6 ], !dbg !64
  %add101.1 = add nuw nsw i32 %add103, 512
  br i1 %or.cond845, label %if.end.1886, label %if.then.1879, !dbg !58

if.then.1879:                                     ; preds = %if.end.7
  %46 = shl nsw i32 %cond.i.i788, 10, !dbg !59
  %mul100.1873 = and i32 %46, 64512, !dbg !59
  %add106.1874 = add nuw nsw i32 %add101.1, %mul100.1873, !dbg !60
  %idx.ext107.1875 = zext nneg i32 %add106.1874 to i64, !dbg !61
  %add.ptr108.1876 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.1875, !dbg !61
  %kr.sroa.58.128.copyload1848 = load <4 x half>, ptr addrspace(4) %add.ptr108.1876, align 16, !dbg !62
  %kr.sroa.62.128.add.ptr108.1876.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1876, i64 8, !dbg !62
  %kr.sroa.62.128.copyload1856 = load <4 x half>, ptr addrspace(4) %kr.sroa.62.128.add.ptr108.1876.sroa_idx, align 8, !dbg !62
  br label %if.end.1886, !dbg !63

if.end.1886:                                      ; preds = %if.end.7, %if.then.1879
  %47 = phi <4 x half> [ %kr.sroa.62.128.copyload1856, %if.then.1879 ], [ zeroinitializer, %if.end.7 ], !dbg !64
  %48 = phi <4 x half> [ %kr.sroa.58.128.copyload1848, %if.then.1879 ], [ zeroinitializer, %if.end.7 ], !dbg !64
  br i1 %or.cond845.1, label %if.end.1.1, label %if.then.1.1, !dbg !58

if.then.1.1:                                      ; preds = %if.end.1886
  %49 = shl nsw i32 %cond.i.i788.1, 10, !dbg !59
  %mul100.1.1 = and i32 %49, 64512, !dbg !59
  %add106.1.1 = add nuw nsw i32 %add101.1, %mul100.1.1, !dbg !60
  %idx.ext107.1.1 = zext nneg i32 %add106.1.1 to i64, !dbg !61
  %add.ptr108.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.1.1, !dbg !61
  %kr.sroa.65.144.copyload1849 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.1, align 16, !dbg !62
  %kr.sroa.69.144.add.ptr108.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.1, i64 8, !dbg !62
  %kr.sroa.69.144.copyload1857 = load <4 x half>, ptr addrspace(4) %kr.sroa.69.144.add.ptr108.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1, !dbg !63

if.end.1.1:                                       ; preds = %if.end.1886, %if.then.1.1
  %50 = phi <4 x half> [ %kr.sroa.69.144.copyload1857, %if.then.1.1 ], [ zeroinitializer, %if.end.1886 ], !dbg !64
  %51 = phi <4 x half> [ %kr.sroa.65.144.copyload1849, %if.then.1.1 ], [ zeroinitializer, %if.end.1886 ], !dbg !64
  br i1 %or.cond845.2, label %if.end.2.1, label %if.then.2.1, !dbg !58

if.then.2.1:                                      ; preds = %if.end.1.1
  %52 = shl nsw i32 %cond.i.i788.2, 10, !dbg !59
  %mul100.2.1 = and i32 %52, 64512, !dbg !59
  %add106.2.1 = add nuw nsw i32 %add101.1, %mul100.2.1, !dbg !60
  %idx.ext107.2.1 = zext nneg i32 %add106.2.1 to i64, !dbg !61
  %add.ptr108.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.2.1, !dbg !61
  %kr.sroa.72.160.copyload1850 = load <4 x half>, ptr addrspace(4) %add.ptr108.2.1, align 16, !dbg !62
  %kr.sroa.76.160.add.ptr108.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.2.1, i64 8, !dbg !62
  %kr.sroa.76.160.copyload1858 = load <4 x half>, ptr addrspace(4) %kr.sroa.76.160.add.ptr108.2.1.sroa_idx, align 8, !dbg !62
  br label %if.end.2.1, !dbg !63

if.end.2.1:                                       ; preds = %if.end.1.1, %if.then.2.1
  %53 = phi <4 x half> [ %kr.sroa.76.160.copyload1858, %if.then.2.1 ], [ zeroinitializer, %if.end.1.1 ], !dbg !64
  %54 = phi <4 x half> [ %kr.sroa.72.160.copyload1850, %if.then.2.1 ], [ zeroinitializer, %if.end.1.1 ], !dbg !64
  br i1 %or.cond845.3, label %if.end.3.1, label %if.then.3.1, !dbg !58

if.then.3.1:                                      ; preds = %if.end.2.1
  %55 = shl nsw i32 %cond.i.i788.3, 10, !dbg !59
  %mul100.3.1 = and i32 %55, 64512, !dbg !59
  %add106.3.1 = add nuw nsw i32 %add101.1, %mul100.3.1, !dbg !60
  %idx.ext107.3.1 = zext nneg i32 %add106.3.1 to i64, !dbg !61
  %add.ptr108.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.3.1, !dbg !61
  %kr.sroa.79.176.copyload1851 = load <4 x half>, ptr addrspace(4) %add.ptr108.3.1, align 16, !dbg !62
  %kr.sroa.83.176.add.ptr108.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.3.1, i64 8, !dbg !62
  %kr.sroa.83.176.copyload1859 = load <4 x half>, ptr addrspace(4) %kr.sroa.83.176.add.ptr108.3.1.sroa_idx, align 8, !dbg !62
  br label %if.end.3.1, !dbg !63

if.end.3.1:                                       ; preds = %if.end.2.1, %if.then.3.1
  %56 = phi <4 x half> [ %kr.sroa.83.176.copyload1859, %if.then.3.1 ], [ zeroinitializer, %if.end.2.1 ], !dbg !64
  %57 = phi <4 x half> [ %kr.sroa.79.176.copyload1851, %if.then.3.1 ], [ zeroinitializer, %if.end.2.1 ], !dbg !64
  br i1 %or.cond845.4, label %if.end.4.1, label %if.then.4.1, !dbg !58

if.then.4.1:                                      ; preds = %if.end.3.1
  %58 = shl nsw i32 %cond.i.i788.4, 10, !dbg !59
  %mul100.4.1 = and i32 %58, 64512, !dbg !59
  %add106.4.1 = add nuw nsw i32 %add101.1, %mul100.4.1, !dbg !60
  %idx.ext107.4.1 = zext nneg i32 %add106.4.1 to i64, !dbg !61
  %add.ptr108.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.4.1, !dbg !61
  %kr.sroa.86.192.copyload1852 = load <4 x half>, ptr addrspace(4) %add.ptr108.4.1, align 16, !dbg !62
  %kr.sroa.90.192.add.ptr108.4.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.4.1, i64 8, !dbg !62
  %kr.sroa.90.192.copyload1860 = load <4 x half>, ptr addrspace(4) %kr.sroa.90.192.add.ptr108.4.1.sroa_idx, align 8, !dbg !62
  br label %if.end.4.1, !dbg !63

if.end.4.1:                                       ; preds = %if.end.3.1, %if.then.4.1
  %59 = phi <4 x half> [ %kr.sroa.90.192.copyload1860, %if.then.4.1 ], [ zeroinitializer, %if.end.3.1 ], !dbg !64
  %60 = phi <4 x half> [ %kr.sroa.86.192.copyload1852, %if.then.4.1 ], [ zeroinitializer, %if.end.3.1 ], !dbg !64
  br i1 %or.cond845.5, label %if.end.5.1, label %if.then.5.1, !dbg !58

if.then.5.1:                                      ; preds = %if.end.4.1
  %61 = shl nsw i32 %cond.i.i788.5, 10, !dbg !59
  %mul100.5.1 = and i32 %61, 64512, !dbg !59
  %add106.5.1 = add nuw nsw i32 %add101.1, %mul100.5.1, !dbg !60
  %idx.ext107.5.1 = zext nneg i32 %add106.5.1 to i64, !dbg !61
  %add.ptr108.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.5.1, !dbg !61
  %kr.sroa.93.208.copyload1853 = load <4 x half>, ptr addrspace(4) %add.ptr108.5.1, align 16, !dbg !62
  %kr.sroa.97.208.add.ptr108.5.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.5.1, i64 8, !dbg !62
  %kr.sroa.97.208.copyload1861 = load <4 x half>, ptr addrspace(4) %kr.sroa.97.208.add.ptr108.5.1.sroa_idx, align 8, !dbg !62
  br label %if.end.5.1, !dbg !63

if.end.5.1:                                       ; preds = %if.end.4.1, %if.then.5.1
  %62 = phi <4 x half> [ %kr.sroa.97.208.copyload1861, %if.then.5.1 ], [ zeroinitializer, %if.end.4.1 ], !dbg !64
  %63 = phi <4 x half> [ %kr.sroa.93.208.copyload1853, %if.then.5.1 ], [ zeroinitializer, %if.end.4.1 ], !dbg !64
  br i1 %or.cond845.6, label %if.end.6.1, label %if.then.6.1, !dbg !58

if.then.6.1:                                      ; preds = %if.end.5.1
  %64 = shl nsw i32 %cond.i.i788.6, 10, !dbg !59
  %mul100.6.1 = and i32 %64, 64512, !dbg !59
  %add106.6.1 = add nuw nsw i32 %add101.1, %mul100.6.1, !dbg !60
  %idx.ext107.6.1 = zext nneg i32 %add106.6.1 to i64, !dbg !61
  %add.ptr108.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.6.1, !dbg !61
  %kr.sroa.100.224.copyload1854 = load <4 x half>, ptr addrspace(4) %add.ptr108.6.1, align 16, !dbg !62
  %kr.sroa.104.224.add.ptr108.6.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.6.1, i64 8, !dbg !62
  %kr.sroa.104.224.copyload1862 = load <4 x half>, ptr addrspace(4) %kr.sroa.104.224.add.ptr108.6.1.sroa_idx, align 8, !dbg !62
  br label %if.end.6.1, !dbg !63

if.end.6.1:                                       ; preds = %if.end.5.1, %if.then.6.1
  %65 = phi <4 x half> [ %kr.sroa.104.224.copyload1862, %if.then.6.1 ], [ zeroinitializer, %if.end.5.1 ], !dbg !64
  %66 = phi <4 x half> [ %kr.sroa.100.224.copyload1854, %if.then.6.1 ], [ zeroinitializer, %if.end.5.1 ], !dbg !64
  br i1 %or.cond845.7, label %if.end.7.1, label %if.then.7.1, !dbg !58

if.then.7.1:                                      ; preds = %if.end.6.1
  %67 = shl nsw i32 %cond.i.i788.7, 10, !dbg !59
  %mul100.7.1 = and i32 %67, 64512, !dbg !59
  %add106.7.1 = add nuw nsw i32 %add101.1, %mul100.7.1, !dbg !60
  %idx.ext107.7.1 = zext nneg i32 %add106.7.1 to i64, !dbg !61
  %add.ptr108.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext107.7.1, !dbg !61
  %kr.sroa.107.240.copyload1855 = load <4 x half>, ptr addrspace(4) %add.ptr108.7.1, align 16, !dbg !62
  %kr.sroa.111.240.add.ptr108.7.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.7.1, i64 8, !dbg !62
  %kr.sroa.111.240.copyload1863 = load <4 x half>, ptr addrspace(4) %kr.sroa.111.240.add.ptr108.7.1.sroa_idx, align 8, !dbg !62
  br label %if.end.7.1, !dbg !63

if.end.7.1:                                       ; preds = %if.end.6.1, %if.then.7.1
  %68 = phi <4 x half> [ %kr.sroa.111.240.copyload1863, %if.then.7.1 ], [ zeroinitializer, %if.end.6.1 ], !dbg !64
  %69 = phi <4 x half> [ %kr.sroa.107.240.copyload1855, %if.then.7.1 ], [ zeroinitializer, %if.end.6.1 ], !dbg !64
  %invariant.op = add nsw i32 %1, -15, !dbg !65
  %70 = lshr i32 %18, 2
  %mul170 = and i32 %70, 252
  br i1 %or.cond845, label %if.end213, label %if.then159, !dbg !66

if.then159:                                       ; preds = %if.end.7.1
  %cmp162 = icmp sgt i32 %mul11, %invariant.op, !dbg !67
  br i1 %cmp162, label %for.cond164.preheader, label %if.end213, !dbg !68

for.cond164.preheader:                            ; preds = %if.then159
  %add171 = add nuw nsw i32 %mul11, %mul170
  %cmp174.not = icmp sgt i32 %add171, %1, !dbg !69
  %spec.select = select i1 %cmp174.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.0.0.vec.insert1125 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !71
  %cmp174.not.1.not = icmp slt i32 %add171, %1, !dbg !69
  %spec.select.1 = select i1 %cmp174.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.0.4.vec.insert1136 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1125, float %spec.select.1, i64 1, !dbg !71
  %add172.2 = or disjoint i32 %add171, 2, !dbg !72
  %cmp174.not.2 = icmp sgt i32 %add172.2, %1, !dbg !69
  %spec.select.2 = select i1 %cmp174.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.0.8.vec.insert1147 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1136, float %spec.select.2, i64 2, !dbg !71
  %add172.3 = or disjoint i32 %add171, 3, !dbg !72
  %cmp174.not.3 = icmp sgt i32 %add172.3, %1, !dbg !69
  %spec.select.3 = select i1 %cmp174.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.0.12.vec.insert1158 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1147, float %spec.select.3, i64 3, !dbg !71
  br label %if.end213, !dbg !73

if.end213:                                        ; preds = %if.end.7.1, %if.then159, %for.cond164.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1158, %for.cond164.preheader ], [ zeroinitializer, %if.then159 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.7.1 ], !dbg !64
  br i1 %or.cond845.1, label %if.end213.1, label %if.then159.1, !dbg !66

if.then159.1:                                     ; preds = %if.end213
  %cmp162.1 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !67
  br i1 %cmp162.1, label %for.cond164.preheader.1, label %if.end213.1, !dbg !68

for.cond164.preheader.1:                          ; preds = %if.then159.1
  %add171.1 = add nuw nsw i32 %mul11.1, %mul170
  %cmp174.not.1888 = icmp sgt i32 %add171.1, %1, !dbg !69
  %spec.select.1889 = select i1 %cmp174.not.1888, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.38.16.vec.insert1173 = insertelement <4 x float> poison, float %spec.select.1889, i64 0, !dbg !71
  %cmp174.not.1.1.not = icmp slt i32 %add171.1, %1, !dbg !69
  %spec.select.1.1 = select i1 %cmp174.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.38.20.vec.insert1184 = insertelement <4 x float> %scores.sroa.38.16.vec.insert1173, float %spec.select.1.1, i64 1, !dbg !71
  %add172.2.1 = or disjoint i32 %add171.1, 2, !dbg !72
  %cmp174.not.2.1 = icmp sgt i32 %add172.2.1, %1, !dbg !69
  %spec.select.2.1 = select i1 %cmp174.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.38.24.vec.insert1195 = insertelement <4 x float> %scores.sroa.38.20.vec.insert1184, float %spec.select.2.1, i64 2, !dbg !71
  %add172.3.1 = or disjoint i32 %add171.1, 3, !dbg !72
  %cmp174.not.3.1 = icmp sgt i32 %add172.3.1, %1, !dbg !69
  %spec.select.3.1 = select i1 %cmp174.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.38.28.vec.insert1206 = insertelement <4 x float> %scores.sroa.38.24.vec.insert1195, float %spec.select.3.1, i64 3, !dbg !71
  br label %if.end213.1, !dbg !73

if.end213.1:                                      ; preds = %if.end213, %if.then159.1, %for.cond164.preheader.1
  %scores.sroa.38.0 = phi <4 x float> [ %scores.sroa.38.28.vec.insert1206, %for.cond164.preheader.1 ], [ zeroinitializer, %if.then159.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end213 ], !dbg !64
  br i1 %or.cond845.2, label %if.end213.2, label %if.then159.2, !dbg !66

if.then159.2:                                     ; preds = %if.end213.1
  %cmp162.2 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !67
  br i1 %cmp162.2, label %for.cond164.preheader.2, label %if.end213.2, !dbg !68

for.cond164.preheader.2:                          ; preds = %if.then159.2
  %add171.2 = add nuw nsw i32 %mul11.2, %mul170
  %cmp174.not.2893 = icmp sgt i32 %add171.2, %1, !dbg !69
  %spec.select.2894 = select i1 %cmp174.not.2893, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.74.32.vec.insert1221 = insertelement <4 x float> poison, float %spec.select.2894, i64 0, !dbg !71
  %cmp174.not.1.2.not = icmp slt i32 %add171.2, %1, !dbg !69
  %spec.select.1.2 = select i1 %cmp174.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.74.36.vec.insert1232 = insertelement <4 x float> %scores.sroa.74.32.vec.insert1221, float %spec.select.1.2, i64 1, !dbg !71
  %add172.2.2 = or disjoint i32 %add171.2, 2, !dbg !72
  %cmp174.not.2.2 = icmp sgt i32 %add172.2.2, %1, !dbg !69
  %spec.select.2.2 = select i1 %cmp174.not.2.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.74.40.vec.insert1243 = insertelement <4 x float> %scores.sroa.74.36.vec.insert1232, float %spec.select.2.2, i64 2, !dbg !71
  %add172.3.2 = or disjoint i32 %add171.2, 3, !dbg !72
  %cmp174.not.3.2 = icmp sgt i32 %add172.3.2, %1, !dbg !69
  %spec.select.3.2 = select i1 %cmp174.not.3.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.74.44.vec.insert1254 = insertelement <4 x float> %scores.sroa.74.40.vec.insert1243, float %spec.select.3.2, i64 3, !dbg !71
  br label %if.end213.2, !dbg !73

if.end213.2:                                      ; preds = %if.end213.1, %if.then159.2, %for.cond164.preheader.2
  %scores.sroa.74.0 = phi <4 x float> [ %scores.sroa.74.44.vec.insert1254, %for.cond164.preheader.2 ], [ zeroinitializer, %if.then159.2 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end213.1 ], !dbg !64
  br i1 %or.cond845.3, label %if.end213.3, label %if.then159.3, !dbg !66

if.then159.3:                                     ; preds = %if.end213.2
  %cmp162.3 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !67
  br i1 %cmp162.3, label %for.cond164.preheader.3, label %if.end213.3, !dbg !68

for.cond164.preheader.3:                          ; preds = %if.then159.3
  %add171.3 = add nuw nsw i32 %mul11.3, %mul170
  %cmp174.not.3898 = icmp sgt i32 %add171.3, %1, !dbg !69
  %spec.select.3899 = select i1 %cmp174.not.3898, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.110.48.vec.insert1269 = insertelement <4 x float> poison, float %spec.select.3899, i64 0, !dbg !71
  %cmp174.not.1.3.not = icmp slt i32 %add171.3, %1, !dbg !69
  %spec.select.1.3 = select i1 %cmp174.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.110.52.vec.insert1280 = insertelement <4 x float> %scores.sroa.110.48.vec.insert1269, float %spec.select.1.3, i64 1, !dbg !71
  %add172.2.3 = or disjoint i32 %add171.3, 2, !dbg !72
  %cmp174.not.2.3 = icmp sgt i32 %add172.2.3, %1, !dbg !69
  %spec.select.2.3 = select i1 %cmp174.not.2.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.110.56.vec.insert1291 = insertelement <4 x float> %scores.sroa.110.52.vec.insert1280, float %spec.select.2.3, i64 2, !dbg !71
  %add172.3.3 = or disjoint i32 %add171.3, 3, !dbg !72
  %cmp174.not.3.3 = icmp sgt i32 %add172.3.3, %1, !dbg !69
  %spec.select.3.3 = select i1 %cmp174.not.3.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.110.60.vec.insert1302 = insertelement <4 x float> %scores.sroa.110.56.vec.insert1291, float %spec.select.3.3, i64 3, !dbg !71
  br label %if.end213.3, !dbg !73

if.end213.3:                                      ; preds = %if.end213.2, %if.then159.3, %for.cond164.preheader.3
  %scores.sroa.110.0 = phi <4 x float> [ %scores.sroa.110.60.vec.insert1302, %for.cond164.preheader.3 ], [ zeroinitializer, %if.then159.3 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end213.2 ], !dbg !64
  br i1 %or.cond845.4, label %if.end213.4, label %if.then159.4, !dbg !66

if.then159.4:                                     ; preds = %if.end213.3
  %cmp162.4 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !67
  br i1 %cmp162.4, label %for.cond164.preheader.4, label %if.end213.4, !dbg !68

for.cond164.preheader.4:                          ; preds = %if.then159.4
  %add171.4 = add nuw nsw i32 %mul11.4, %mul170
  %cmp174.not.4 = icmp sgt i32 %add171.4, %1, !dbg !69
  %spec.select.4 = select i1 %cmp174.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.146.64.vec.insert1317 = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !71
  %cmp174.not.1.4.not = icmp slt i32 %add171.4, %1, !dbg !69
  %spec.select.1.4 = select i1 %cmp174.not.1.4.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.146.68.vec.insert1328 = insertelement <4 x float> %scores.sroa.146.64.vec.insert1317, float %spec.select.1.4, i64 1, !dbg !71
  %add172.2.4 = or disjoint i32 %add171.4, 2, !dbg !72
  %cmp174.not.2.4 = icmp sgt i32 %add172.2.4, %1, !dbg !69
  %spec.select.2.4 = select i1 %cmp174.not.2.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.146.72.vec.insert1339 = insertelement <4 x float> %scores.sroa.146.68.vec.insert1328, float %spec.select.2.4, i64 2, !dbg !71
  %add172.3.4 = or disjoint i32 %add171.4, 3, !dbg !72
  %cmp174.not.3.4 = icmp sgt i32 %add172.3.4, %1, !dbg !69
  %spec.select.3.4 = select i1 %cmp174.not.3.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.146.76.vec.insert1350 = insertelement <4 x float> %scores.sroa.146.72.vec.insert1339, float %spec.select.3.4, i64 3, !dbg !71
  br label %if.end213.4, !dbg !73

if.end213.4:                                      ; preds = %if.end213.3, %if.then159.4, %for.cond164.preheader.4
  %scores.sroa.146.0 = phi <4 x float> [ %scores.sroa.146.76.vec.insert1350, %for.cond164.preheader.4 ], [ zeroinitializer, %if.then159.4 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end213.3 ], !dbg !64
  br i1 %or.cond845.5, label %if.end213.5, label %if.then159.5, !dbg !66

if.then159.5:                                     ; preds = %if.end213.4
  %cmp162.5 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !67
  br i1 %cmp162.5, label %for.cond164.preheader.5, label %if.end213.5, !dbg !68

for.cond164.preheader.5:                          ; preds = %if.then159.5
  %add171.5 = add nuw nsw i32 %mul11.5, %mul170
  %cmp174.not.5 = icmp sgt i32 %add171.5, %1, !dbg !69
  %spec.select.5 = select i1 %cmp174.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.182.80.vec.insert1365 = insertelement <4 x float> poison, float %spec.select.5, i64 0, !dbg !71
  %cmp174.not.1.5.not = icmp slt i32 %add171.5, %1, !dbg !69
  %spec.select.1.5 = select i1 %cmp174.not.1.5.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.182.84.vec.insert1376 = insertelement <4 x float> %scores.sroa.182.80.vec.insert1365, float %spec.select.1.5, i64 1, !dbg !71
  %add172.2.5 = or disjoint i32 %add171.5, 2, !dbg !72
  %cmp174.not.2.5 = icmp sgt i32 %add172.2.5, %1, !dbg !69
  %spec.select.2.5 = select i1 %cmp174.not.2.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.182.88.vec.insert1387 = insertelement <4 x float> %scores.sroa.182.84.vec.insert1376, float %spec.select.2.5, i64 2, !dbg !71
  %add172.3.5 = or disjoint i32 %add171.5, 3, !dbg !72
  %cmp174.not.3.5 = icmp sgt i32 %add172.3.5, %1, !dbg !69
  %spec.select.3.5 = select i1 %cmp174.not.3.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.182.92.vec.insert1398 = insertelement <4 x float> %scores.sroa.182.88.vec.insert1387, float %spec.select.3.5, i64 3, !dbg !71
  br label %if.end213.5, !dbg !73

if.end213.5:                                      ; preds = %if.end213.4, %if.then159.5, %for.cond164.preheader.5
  %scores.sroa.182.0 = phi <4 x float> [ %scores.sroa.182.92.vec.insert1398, %for.cond164.preheader.5 ], [ zeroinitializer, %if.then159.5 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end213.4 ], !dbg !64
  br i1 %or.cond845.6, label %if.end213.6, label %if.then159.6, !dbg !66

if.then159.6:                                     ; preds = %if.end213.5
  %cmp162.6 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !67
  br i1 %cmp162.6, label %for.cond164.preheader.6, label %if.end213.6, !dbg !68

for.cond164.preheader.6:                          ; preds = %if.then159.6
  %add171.6 = add nuw nsw i32 %mul11.6, %mul170
  %cmp174.not.6 = icmp sgt i32 %add171.6, %1, !dbg !69
  %spec.select.6 = select i1 %cmp174.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.218.96.vec.insert1413 = insertelement <4 x float> poison, float %spec.select.6, i64 0, !dbg !71
  %cmp174.not.1.6.not = icmp slt i32 %add171.6, %1, !dbg !69
  %spec.select.1.6 = select i1 %cmp174.not.1.6.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.218.100.vec.insert1424 = insertelement <4 x float> %scores.sroa.218.96.vec.insert1413, float %spec.select.1.6, i64 1, !dbg !71
  %add172.2.6 = or disjoint i32 %add171.6, 2, !dbg !72
  %cmp174.not.2.6 = icmp sgt i32 %add172.2.6, %1, !dbg !69
  %spec.select.2.6 = select i1 %cmp174.not.2.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.218.104.vec.insert1435 = insertelement <4 x float> %scores.sroa.218.100.vec.insert1424, float %spec.select.2.6, i64 2, !dbg !71
  %add172.3.6 = or disjoint i32 %add171.6, 3, !dbg !72
  %cmp174.not.3.6 = icmp sgt i32 %add172.3.6, %1, !dbg !69
  %spec.select.3.6 = select i1 %cmp174.not.3.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.218.108.vec.insert1446 = insertelement <4 x float> %scores.sroa.218.104.vec.insert1435, float %spec.select.3.6, i64 3, !dbg !71
  br label %if.end213.6, !dbg !73

if.end213.6:                                      ; preds = %if.end213.5, %if.then159.6, %for.cond164.preheader.6
  %scores.sroa.218.0 = phi <4 x float> [ %scores.sroa.218.108.vec.insert1446, %for.cond164.preheader.6 ], [ zeroinitializer, %if.then159.6 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end213.5 ], !dbg !64
  br i1 %or.cond845.7, label %if.end213.7, label %if.then159.7, !dbg !66

if.then159.7:                                     ; preds = %if.end213.6
  %cmp162.7 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !67
  br i1 %cmp162.7, label %for.cond164.preheader.7, label %if.end213.7, !dbg !68

for.cond164.preheader.7:                          ; preds = %if.then159.7
  %add171.7 = add nuw nsw i32 %mul11.7, %mul170
  %cmp174.not.7 = icmp sgt i32 %add171.7, %1, !dbg !69
  %spec.select.7 = select i1 %cmp174.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.254.112.vec.insert1461 = insertelement <4 x float> poison, float %spec.select.7, i64 0, !dbg !71
  %cmp174.not.1.7.not = icmp slt i32 %add171.7, %1, !dbg !69
  %spec.select.1.7 = select i1 %cmp174.not.1.7.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %scores.sroa.254.116.vec.insert1472 = insertelement <4 x float> %scores.sroa.254.112.vec.insert1461, float %spec.select.1.7, i64 1, !dbg !71
  %add172.2.7 = or disjoint i32 %add171.7, 2, !dbg !72
  %cmp174.not.2.7 = icmp sgt i32 %add172.2.7, %1, !dbg !69
  %spec.select.2.7 = select i1 %cmp174.not.2.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.254.120.vec.insert1483 = insertelement <4 x float> %scores.sroa.254.116.vec.insert1472, float %spec.select.2.7, i64 2, !dbg !71
  %add172.3.7 = or disjoint i32 %add171.7, 3, !dbg !72
  %cmp174.not.3.7 = icmp sgt i32 %add172.3.7, %1, !dbg !69
  %spec.select.3.7 = select i1 %cmp174.not.3.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %scores.sroa.254.124.vec.insert1494 = insertelement <4 x float> %scores.sroa.254.120.vec.insert1483, float %spec.select.3.7, i64 3, !dbg !71
  br label %if.end213.7, !dbg !73

if.end213.7:                                      ; preds = %if.end213.6, %if.then159.7, %for.cond164.preheader.7
  %scores.sroa.254.0 = phi <4 x float> [ %scores.sroa.254.124.vec.insert1494, %for.cond164.preheader.7 ], [ zeroinitializer, %if.then159.7 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end213.6 ], !dbg !64
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %24, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.0), !dbg !74, !call_argsrelate !75
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.38.0), !dbg !74, !call_argsrelate !75
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.74.0), !dbg !74, !call_argsrelate !75
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.110.0), !dbg !74, !call_argsrelate !75
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.0), !dbg !74, !call_argsrelate !75
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %39, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.182.0), !dbg !74, !call_argsrelate !75
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.218.0), !dbg !74, !call_argsrelate !75
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %45, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.254.0), !dbg !74, !call_argsrelate !75
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %23, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %71), !dbg !74, !call_argsrelate !75
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %72), !dbg !74, !call_argsrelate !75
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %73), !dbg !74, !call_argsrelate !75
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %32, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %74), !dbg !74, !call_argsrelate !75
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %75), !dbg !74, !call_argsrelate !75
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %38, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %76), !dbg !74, !call_argsrelate !75
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %41, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %77), !dbg !74, !call_argsrelate !75
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %44, <4 x half> %qr.sroa.4.0.copyload, <4 x float> %78), !dbg !74, !call_argsrelate !75
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %79), !dbg !74, !call_argsrelate !75
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %51, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %80), !dbg !74, !call_argsrelate !75
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %81), !dbg !74, !call_argsrelate !75
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %57, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %82), !dbg !74, !call_argsrelate !75
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %83), !dbg !74, !call_argsrelate !75
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %63, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %84), !dbg !74, !call_argsrelate !75
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %85), !dbg !74, !call_argsrelate !75
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %qr.sroa.5.16.copyload, <4 x float> %86), !dbg !74, !call_argsrelate !75
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %47, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %87), !dbg !74, !call_argsrelate !75
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %50, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %88), !dbg !74, !call_argsrelate !75
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %53, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %89), !dbg !74, !call_argsrelate !75
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %90), !dbg !74, !call_argsrelate !75
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %59, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %91), !dbg !74, !call_argsrelate !75
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %62, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %92), !dbg !74, !call_argsrelate !75
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %65, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %93), !dbg !74, !call_argsrelate !75
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %94), !dbg !74, !call_argsrelate !75
  br i1 %or.cond845, label %if.end330, label %for.cond269.preheader, !dbg !76

for.cond269.preheader:                            ; preds = %if.end213.7
  %103 = shl nsw i32 %cond.i.i788, 10
  %mul276 = and i32 %103, 64512
  %add279 = add nuw nsw i32 %add103, %mul276
  %104 = zext nneg i32 %add279 to i64, !dbg !77
  %add.ptr284 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %104, !dbg !78
  %vr.sroa.0.0.copyload1864 = load <4 x half>, ptr addrspace(4) %add.ptr284, align 16, !dbg !79
  %vr.sroa.7.0.add.ptr284.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284, i64 8, !dbg !79
  %vr.sroa.7.0.copyload1865 = load <4 x half>, ptr addrspace(4) %vr.sroa.7.0.add.ptr284.sroa_idx, align 8, !dbg !79
  %105 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %104, !dbg !78
  %add.ptr284.1 = getelementptr inbounds i8, ptr addrspace(4) %105, i64 1024, !dbg !78
  %vr.sroa.11.16.copyload1866 = load <4 x half>, ptr addrspace(4) %add.ptr284.1, align 16, !dbg !79
  %vr.sroa.16.16.add.ptr284.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %105, i64 1032, !dbg !79
  %vr.sroa.16.16.copyload1867 = load <4 x half>, ptr addrspace(4) %vr.sroa.16.16.add.ptr284.1.sroa_idx, align 8, !dbg !79
  br label %if.end330, !dbg !80

if.end330:                                        ; preds = %if.end213.7, %for.cond269.preheader
  %106 = phi <4 x half> [ %vr.sroa.16.16.copyload1867, %for.cond269.preheader ], [ zeroinitializer, %if.end213.7 ], !dbg !64
  %107 = phi <4 x half> [ %vr.sroa.11.16.copyload1866, %for.cond269.preheader ], [ zeroinitializer, %if.end213.7 ], !dbg !64
  %108 = phi <4 x half> [ %vr.sroa.7.0.copyload1865, %for.cond269.preheader ], [ zeroinitializer, %if.end213.7 ], !dbg !64
  %109 = phi <4 x half> [ %vr.sroa.0.0.copyload1864, %for.cond269.preheader ], [ zeroinitializer, %if.end213.7 ], !dbg !64
  br i1 %or.cond845.1, label %if.end330.1, label %for.cond269.preheader.1, !dbg !76

for.cond269.preheader.1:                          ; preds = %if.end330
  %110 = shl nsw i32 %cond.i.i788.1, 10
  %mul276.1 = and i32 %110, 64512
  %add279.1 = add nuw nsw i32 %add103, %mul276.1
  %111 = zext nneg i32 %add279.1 to i64, !dbg !77
  %add.ptr284.1926 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %111, !dbg !78
  %vr.sroa.20.32.copyload1868 = load <4 x half>, ptr addrspace(4) %add.ptr284.1926, align 16, !dbg !79
  %vr.sroa.25.32.add.ptr284.1926.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284.1926, i64 8, !dbg !79
  %vr.sroa.25.32.copyload1869 = load <4 x half>, ptr addrspace(4) %vr.sroa.25.32.add.ptr284.1926.sroa_idx, align 8, !dbg !79
  %112 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %111, !dbg !78
  %add.ptr284.1.1 = getelementptr inbounds i8, ptr addrspace(4) %112, i64 1024, !dbg !78
  %vr.sroa.29.48.copyload1870 = load <4 x half>, ptr addrspace(4) %add.ptr284.1.1, align 16, !dbg !79
  %vr.sroa.34.48.add.ptr284.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %112, i64 1032, !dbg !79
  %vr.sroa.34.48.copyload1871 = load <4 x half>, ptr addrspace(4) %vr.sroa.34.48.add.ptr284.1.1.sroa_idx, align 8, !dbg !79
  br label %if.end330.1, !dbg !80

if.end330.1:                                      ; preds = %if.end330, %for.cond269.preheader.1
  %113 = phi <4 x half> [ %vr.sroa.34.48.copyload1871, %for.cond269.preheader.1 ], [ zeroinitializer, %if.end330 ], !dbg !64
  %114 = phi <4 x half> [ %vr.sroa.29.48.copyload1870, %for.cond269.preheader.1 ], [ zeroinitializer, %if.end330 ], !dbg !64
  %115 = phi <4 x half> [ %vr.sroa.25.32.copyload1869, %for.cond269.preheader.1 ], [ zeroinitializer, %if.end330 ], !dbg !64
  %116 = phi <4 x half> [ %vr.sroa.20.32.copyload1868, %for.cond269.preheader.1 ], [ zeroinitializer, %if.end330 ], !dbg !64
  br i1 %or.cond845.2, label %if.end330.2, label %for.cond269.preheader.2, !dbg !76

for.cond269.preheader.2:                          ; preds = %if.end330.1
  %117 = shl nsw i32 %cond.i.i788.2, 10
  %mul276.2 = and i32 %117, 64512
  %add279.2 = add nuw nsw i32 %add103, %mul276.2
  %118 = zext nneg i32 %add279.2 to i64, !dbg !77
  %add.ptr284.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118, !dbg !78
  %vr.sroa.38.64.copyload1872 = load <4 x half>, ptr addrspace(4) %add.ptr284.2, align 16, !dbg !79
  %vr.sroa.43.64.add.ptr284.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284.2, i64 8, !dbg !79
  %vr.sroa.43.64.copyload1873 = load <4 x half>, ptr addrspace(4) %vr.sroa.43.64.add.ptr284.2.sroa_idx, align 8, !dbg !79
  %119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118, !dbg !78
  %add.ptr284.1.2 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1024, !dbg !78
  %vr.sroa.47.80.copyload1874 = load <4 x half>, ptr addrspace(4) %add.ptr284.1.2, align 16, !dbg !79
  %vr.sroa.52.80.add.ptr284.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1032, !dbg !79
  %vr.sroa.52.80.copyload1875 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.80.add.ptr284.1.2.sroa_idx, align 8, !dbg !79
  br label %if.end330.2, !dbg !80

if.end330.2:                                      ; preds = %if.end330.1, %for.cond269.preheader.2
  %120 = phi <4 x half> [ %vr.sroa.52.80.copyload1875, %for.cond269.preheader.2 ], [ zeroinitializer, %if.end330.1 ], !dbg !64
  %121 = phi <4 x half> [ %vr.sroa.47.80.copyload1874, %for.cond269.preheader.2 ], [ zeroinitializer, %if.end330.1 ], !dbg !64
  %122 = phi <4 x half> [ %vr.sroa.43.64.copyload1873, %for.cond269.preheader.2 ], [ zeroinitializer, %if.end330.1 ], !dbg !64
  %123 = phi <4 x half> [ %vr.sroa.38.64.copyload1872, %for.cond269.preheader.2 ], [ zeroinitializer, %if.end330.1 ], !dbg !64
  br i1 %or.cond845.3, label %if.end330.3, label %for.cond269.preheader.3, !dbg !76

for.cond269.preheader.3:                          ; preds = %if.end330.2
  %124 = shl nsw i32 %cond.i.i788.3, 10
  %mul276.3 = and i32 %124, 64512
  %add279.3 = add nuw nsw i32 %add103, %mul276.3
  %125 = zext nneg i32 %add279.3 to i64, !dbg !77
  %add.ptr284.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125, !dbg !78
  %vr.sroa.56.96.copyload1876 = load <4 x half>, ptr addrspace(4) %add.ptr284.3, align 16, !dbg !79
  %vr.sroa.61.96.add.ptr284.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284.3, i64 8, !dbg !79
  %vr.sroa.61.96.copyload1877 = load <4 x half>, ptr addrspace(4) %vr.sroa.61.96.add.ptr284.3.sroa_idx, align 8, !dbg !79
  %126 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125, !dbg !78
  %add.ptr284.1.3 = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1024, !dbg !78
  %vr.sroa.65.112.copyload1878 = load <4 x half>, ptr addrspace(4) %add.ptr284.1.3, align 16, !dbg !79
  %vr.sroa.70.112.add.ptr284.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1032, !dbg !79
  %vr.sroa.70.112.copyload1879 = load <4 x half>, ptr addrspace(4) %vr.sroa.70.112.add.ptr284.1.3.sroa_idx, align 8, !dbg !79
  br label %if.end330.3, !dbg !80

if.end330.3:                                      ; preds = %if.end330.2, %for.cond269.preheader.3
  %127 = phi <4 x half> [ %vr.sroa.70.112.copyload1879, %for.cond269.preheader.3 ], [ zeroinitializer, %if.end330.2 ], !dbg !64
  %128 = phi <4 x half> [ %vr.sroa.65.112.copyload1878, %for.cond269.preheader.3 ], [ zeroinitializer, %if.end330.2 ], !dbg !64
  %129 = phi <4 x half> [ %vr.sroa.61.96.copyload1877, %for.cond269.preheader.3 ], [ zeroinitializer, %if.end330.2 ], !dbg !64
  %130 = phi <4 x half> [ %vr.sroa.56.96.copyload1876, %for.cond269.preheader.3 ], [ zeroinitializer, %if.end330.2 ], !dbg !64
  br i1 %or.cond845.4, label %if.end330.4, label %for.cond269.preheader.4, !dbg !76

for.cond269.preheader.4:                          ; preds = %if.end330.3
  %131 = shl nsw i32 %cond.i.i788.4, 10
  %mul276.4 = and i32 %131, 64512
  %add279.4 = add nuw nsw i32 %add103, %mul276.4
  %132 = zext nneg i32 %add279.4 to i64, !dbg !77
  %add.ptr284.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %132, !dbg !78
  %vr.sroa.74.128.copyload1880 = load <4 x half>, ptr addrspace(4) %add.ptr284.4, align 16, !dbg !79
  %vr.sroa.79.128.add.ptr284.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284.4, i64 8, !dbg !79
  %vr.sroa.79.128.copyload1881 = load <4 x half>, ptr addrspace(4) %vr.sroa.79.128.add.ptr284.4.sroa_idx, align 8, !dbg !79
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %132, !dbg !78
  %add.ptr284.1.4 = getelementptr inbounds i8, ptr addrspace(4) %133, i64 1024, !dbg !78
  %vr.sroa.83.144.copyload1882 = load <4 x half>, ptr addrspace(4) %add.ptr284.1.4, align 16, !dbg !79
  %vr.sroa.88.144.add.ptr284.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %133, i64 1032, !dbg !79
  %vr.sroa.88.144.copyload1883 = load <4 x half>, ptr addrspace(4) %vr.sroa.88.144.add.ptr284.1.4.sroa_idx, align 8, !dbg !79
  br label %if.end330.4, !dbg !80

if.end330.4:                                      ; preds = %if.end330.3, %for.cond269.preheader.4
  %134 = phi <4 x half> [ %vr.sroa.88.144.copyload1883, %for.cond269.preheader.4 ], [ zeroinitializer, %if.end330.3 ], !dbg !64
  %135 = phi <4 x half> [ %vr.sroa.83.144.copyload1882, %for.cond269.preheader.4 ], [ zeroinitializer, %if.end330.3 ], !dbg !64
  %136 = phi <4 x half> [ %vr.sroa.79.128.copyload1881, %for.cond269.preheader.4 ], [ zeroinitializer, %if.end330.3 ], !dbg !64
  %137 = phi <4 x half> [ %vr.sroa.74.128.copyload1880, %for.cond269.preheader.4 ], [ zeroinitializer, %if.end330.3 ], !dbg !64
  br i1 %or.cond845.5, label %if.end330.5, label %for.cond269.preheader.5, !dbg !76

for.cond269.preheader.5:                          ; preds = %if.end330.4
  %138 = shl nsw i32 %cond.i.i788.5, 10
  %mul276.5 = and i32 %138, 64512
  %add279.5 = add nuw nsw i32 %add103, %mul276.5
  %139 = zext nneg i32 %add279.5 to i64, !dbg !77
  %add.ptr284.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %139, !dbg !78
  %vr.sroa.92.160.copyload1884 = load <4 x half>, ptr addrspace(4) %add.ptr284.5, align 16, !dbg !79
  %vr.sroa.97.160.add.ptr284.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284.5, i64 8, !dbg !79
  %vr.sroa.97.160.copyload1885 = load <4 x half>, ptr addrspace(4) %vr.sroa.97.160.add.ptr284.5.sroa_idx, align 8, !dbg !79
  %140 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %139, !dbg !78
  %add.ptr284.1.5 = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1024, !dbg !78
  %vr.sroa.101.176.copyload1886 = load <4 x half>, ptr addrspace(4) %add.ptr284.1.5, align 16, !dbg !79
  %vr.sroa.106.176.add.ptr284.1.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1032, !dbg !79
  %vr.sroa.106.176.copyload1887 = load <4 x half>, ptr addrspace(4) %vr.sroa.106.176.add.ptr284.1.5.sroa_idx, align 8, !dbg !79
  br label %if.end330.5, !dbg !80

if.end330.5:                                      ; preds = %if.end330.4, %for.cond269.preheader.5
  %141 = phi <4 x half> [ %vr.sroa.106.176.copyload1887, %for.cond269.preheader.5 ], [ zeroinitializer, %if.end330.4 ], !dbg !64
  %142 = phi <4 x half> [ %vr.sroa.101.176.copyload1886, %for.cond269.preheader.5 ], [ zeroinitializer, %if.end330.4 ], !dbg !64
  %143 = phi <4 x half> [ %vr.sroa.97.160.copyload1885, %for.cond269.preheader.5 ], [ zeroinitializer, %if.end330.4 ], !dbg !64
  %144 = phi <4 x half> [ %vr.sroa.92.160.copyload1884, %for.cond269.preheader.5 ], [ zeroinitializer, %if.end330.4 ], !dbg !64
  br i1 %or.cond845.6, label %if.end330.6, label %for.cond269.preheader.6, !dbg !76

for.cond269.preheader.6:                          ; preds = %if.end330.5
  %145 = shl nsw i32 %cond.i.i788.6, 10
  %mul276.6 = and i32 %145, 64512
  %add279.6 = add nuw nsw i32 %add103, %mul276.6
  %146 = zext nneg i32 %add279.6 to i64, !dbg !77
  %add.ptr284.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %146, !dbg !78
  %vr.sroa.110.192.copyload1888 = load <4 x half>, ptr addrspace(4) %add.ptr284.6, align 16, !dbg !79
  %vr.sroa.115.192.add.ptr284.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284.6, i64 8, !dbg !79
  %vr.sroa.115.192.copyload1889 = load <4 x half>, ptr addrspace(4) %vr.sroa.115.192.add.ptr284.6.sroa_idx, align 8, !dbg !79
  %147 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %146, !dbg !78
  %add.ptr284.1.6 = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1024, !dbg !78
  %vr.sroa.119.208.copyload1890 = load <4 x half>, ptr addrspace(4) %add.ptr284.1.6, align 16, !dbg !79
  %vr.sroa.124.208.add.ptr284.1.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1032, !dbg !79
  %vr.sroa.124.208.copyload1891 = load <4 x half>, ptr addrspace(4) %vr.sroa.124.208.add.ptr284.1.6.sroa_idx, align 8, !dbg !79
  br label %if.end330.6, !dbg !80

if.end330.6:                                      ; preds = %if.end330.5, %for.cond269.preheader.6
  %148 = phi <4 x half> [ %vr.sroa.124.208.copyload1891, %for.cond269.preheader.6 ], [ zeroinitializer, %if.end330.5 ], !dbg !64
  %149 = phi <4 x half> [ %vr.sroa.119.208.copyload1890, %for.cond269.preheader.6 ], [ zeroinitializer, %if.end330.5 ], !dbg !64
  %150 = phi <4 x half> [ %vr.sroa.115.192.copyload1889, %for.cond269.preheader.6 ], [ zeroinitializer, %if.end330.5 ], !dbg !64
  %151 = phi <4 x half> [ %vr.sroa.110.192.copyload1888, %for.cond269.preheader.6 ], [ zeroinitializer, %if.end330.5 ], !dbg !64
  br i1 %or.cond845.7, label %if.end330.7, label %for.cond269.preheader.7, !dbg !76

for.cond269.preheader.7:                          ; preds = %if.end330.6
  %152 = shl nsw i32 %cond.i.i788.7, 10
  %mul276.7 = and i32 %152, 64512
  %add279.7 = add nuw nsw i32 %add103, %mul276.7
  %153 = zext nneg i32 %add279.7 to i64, !dbg !77
  %add.ptr284.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153, !dbg !78
  %vr.sroa.128.224.copyload1892 = load <4 x half>, ptr addrspace(4) %add.ptr284.7, align 16, !dbg !79
  %vr.sroa.133.224.add.ptr284.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr284.7, i64 8, !dbg !79
  %vr.sroa.133.224.copyload1893 = load <4 x half>, ptr addrspace(4) %vr.sroa.133.224.add.ptr284.7.sroa_idx, align 8, !dbg !79
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153, !dbg !78
  %add.ptr284.1.7 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024, !dbg !78
  %vr.sroa.137.240.copyload1894 = load <4 x half>, ptr addrspace(4) %add.ptr284.1.7, align 16, !dbg !79
  %vr.sroa.142.240.add.ptr284.1.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1032, !dbg !79
  %vr.sroa.142.240.copyload1895 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.240.add.ptr284.1.7.sroa_idx, align 8, !dbg !79
  br label %if.end330.7, !dbg !80

if.end330.7:                                      ; preds = %if.end330.6, %for.cond269.preheader.7
  %155 = phi <4 x half> [ %vr.sroa.142.240.copyload1895, %for.cond269.preheader.7 ], [ zeroinitializer, %if.end330.6 ], !dbg !64
  %156 = phi <4 x half> [ %vr.sroa.137.240.copyload1894, %for.cond269.preheader.7 ], [ zeroinitializer, %if.end330.6 ], !dbg !64
  %157 = phi <4 x half> [ %vr.sroa.133.224.copyload1893, %for.cond269.preheader.7 ], [ zeroinitializer, %if.end330.6 ], !dbg !64
  %158 = phi <4 x half> [ %vr.sroa.128.224.copyload1892, %for.cond269.preheader.7 ], [ zeroinitializer, %if.end330.6 ], !dbg !64
  br i1 %or.cond845, label %if.end410, label %for.cond347.preheader, !dbg !81

for.cond347.preheader:                            ; preds = %if.end330.7
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %95, i64 0, !dbg !82
  %mul355 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !83
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul355, float 0x4024CB5EC0000000), !dbg !84
  %160 = tail call contract noundef float @llvm.exp.f32(float %159), !dbg !87
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %95, i64 1, !dbg !82
  %mul355.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !83
  %161 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1, float 0x4024CB5EC0000000), !dbg !84
  %162 = tail call contract noundef float @llvm.exp.f32(float %161), !dbg !87
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %95, i64 2, !dbg !82
  %mul355.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !83
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2, float 0x4024CB5EC0000000), !dbg !84
  %164 = tail call contract noundef float @llvm.exp.f32(float %163), !dbg !87
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %95, i64 3, !dbg !82
  %mul355.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !83
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3, float 0x4024CB5EC0000000), !dbg !84
  %166 = tail call contract noundef float @llvm.exp.f32(float %165), !dbg !87
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160), !dbg !90
  %168 = insertelement <4 x i16> poison, i16 %167, i64 0, !dbg !99
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %162), !dbg !90
  %170 = insertelement <4 x i16> %168, i16 %169, i64 1, !dbg !99
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164), !dbg !90
  %172 = insertelement <4 x i16> %170, i16 %171, i64 2, !dbg !99
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166), !dbg !90
  %174 = insertelement <4 x i16> %172, i16 %173, i64 3, !dbg !99
  %probs.sroa.0.6.vec.insert = bitcast <4 x i16> %174 to <4 x half>, !dbg !99
  br label %if.end410, !dbg !100

if.end410:                                        ; preds = %if.end330.7, %for.cond347.preheader
  %sums.sroa.0.0 = phi float [ %160, %for.cond347.preheader ], [ 0.000000e+00, %if.end330.7 ], !dbg !64
  %sums.sroa.20.0 = phi float [ %162, %for.cond347.preheader ], [ 0.000000e+00, %if.end330.7 ], !dbg !64
  %sums.sroa.38.0 = phi float [ %164, %for.cond347.preheader ], [ 0.000000e+00, %if.end330.7 ], !dbg !64
  %sums.sroa.56.0 = phi float [ %166, %for.cond347.preheader ], [ 0.000000e+00, %if.end330.7 ], !dbg !64
  %probs.sroa.0.0 = phi <4 x half> [ %probs.sroa.0.6.vec.insert, %for.cond347.preheader ], [ zeroinitializer, %if.end330.7 ], !dbg !64
  br i1 %or.cond845.1, label %if.end410.1, label %for.cond347.preheader.1, !dbg !81

for.cond347.preheader.1:                          ; preds = %if.end410
  %scores.sroa.38.16.vec.extract = extractelement <4 x float> %96, i64 0, !dbg !82
  %mul355.1935 = fmul contract float %scores.sroa.38.16.vec.extract, 0x3FB99999A0000000, !dbg !83
  %175 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1935, float 0x4024CB5EC0000000), !dbg !84
  %176 = tail call contract noundef float @llvm.exp.f32(float %175), !dbg !87
  %scores.sroa.38.20.vec.extract = extractelement <4 x float> %96, i64 1, !dbg !82
  %mul355.1.1 = fmul contract float %scores.sroa.38.20.vec.extract, 0x3FB99999A0000000, !dbg !83
  %177 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1.1, float 0x4024CB5EC0000000), !dbg !84
  %178 = tail call contract noundef float @llvm.exp.f32(float %177), !dbg !87
  %scores.sroa.38.24.vec.extract = extractelement <4 x float> %96, i64 2, !dbg !82
  %mul355.2.1 = fmul contract float %scores.sroa.38.24.vec.extract, 0x3FB99999A0000000, !dbg !83
  %179 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2.1, float 0x4024CB5EC0000000), !dbg !84
  %180 = tail call contract noundef float @llvm.exp.f32(float %179), !dbg !87
  %scores.sroa.38.28.vec.extract = extractelement <4 x float> %96, i64 3, !dbg !82
  %mul355.3.1 = fmul contract float %scores.sroa.38.28.vec.extract, 0x3FB99999A0000000, !dbg !83
  %181 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3.1, float 0x4024CB5EC0000000), !dbg !84
  %182 = tail call contract noundef float @llvm.exp.f32(float %181), !dbg !87
  %add375.1937 = fadd contract float %sums.sroa.0.0, %176, !dbg !101
  %add375.1.1 = fadd contract float %sums.sroa.20.0, %178, !dbg !101
  %add375.2.1 = fadd contract float %sums.sroa.38.0, %180, !dbg !101
  %add375.3.1 = fadd contract float %sums.sroa.56.0, %182, !dbg !101
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %176), !dbg !90
  %184 = insertelement <4 x i16> poison, i16 %183, i64 0, !dbg !99
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %178), !dbg !90
  %186 = insertelement <4 x i16> %184, i16 %185, i64 1, !dbg !99
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %180), !dbg !90
  %188 = insertelement <4 x i16> %186, i16 %187, i64 2, !dbg !99
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %182), !dbg !90
  %190 = insertelement <4 x i16> %188, i16 %189, i64 3, !dbg !99
  %probs.sroa.12.14.vec.insert = bitcast <4 x i16> %190 to <4 x half>, !dbg !99
  br label %if.end410.1, !dbg !100

if.end410.1:                                      ; preds = %if.end410, %for.cond347.preheader.1
  %sums.sroa.0.1 = phi float [ %add375.1937, %for.cond347.preheader.1 ], [ %sums.sroa.0.0, %if.end410 ], !dbg !64
  %sums.sroa.20.1 = phi float [ %add375.1.1, %for.cond347.preheader.1 ], [ %sums.sroa.20.0, %if.end410 ], !dbg !64
  %sums.sroa.38.1 = phi float [ %add375.2.1, %for.cond347.preheader.1 ], [ %sums.sroa.38.0, %if.end410 ], !dbg !64
  %sums.sroa.56.1 = phi float [ %add375.3.1, %for.cond347.preheader.1 ], [ %sums.sroa.56.0, %if.end410 ], !dbg !64
  %probs.sroa.12.0 = phi <4 x half> [ %probs.sroa.12.14.vec.insert, %for.cond347.preheader.1 ], [ zeroinitializer, %if.end410 ], !dbg !64
  br i1 %or.cond845.2, label %if.end410.2, label %for.cond347.preheader.2, !dbg !81

for.cond347.preheader.2:                          ; preds = %if.end410.1
  %scores.sroa.74.32.vec.extract = extractelement <4 x float> %97, i64 0, !dbg !82
  %mul355.2942 = fmul contract float %scores.sroa.74.32.vec.extract, 0x3FB99999A0000000, !dbg !83
  %191 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2942, float 0x4024CB5EC0000000), !dbg !84
  %192 = tail call contract noundef float @llvm.exp.f32(float %191), !dbg !87
  %scores.sroa.74.36.vec.extract = extractelement <4 x float> %97, i64 1, !dbg !82
  %mul355.1.2 = fmul contract float %scores.sroa.74.36.vec.extract, 0x3FB99999A0000000, !dbg !83
  %193 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1.2, float 0x4024CB5EC0000000), !dbg !84
  %194 = tail call contract noundef float @llvm.exp.f32(float %193), !dbg !87
  %scores.sroa.74.40.vec.extract = extractelement <4 x float> %97, i64 2, !dbg !82
  %mul355.2.2 = fmul contract float %scores.sroa.74.40.vec.extract, 0x3FB99999A0000000, !dbg !83
  %195 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2.2, float 0x4024CB5EC0000000), !dbg !84
  %196 = tail call contract noundef float @llvm.exp.f32(float %195), !dbg !87
  %scores.sroa.74.44.vec.extract = extractelement <4 x float> %97, i64 3, !dbg !82
  %mul355.3.2 = fmul contract float %scores.sroa.74.44.vec.extract, 0x3FB99999A0000000, !dbg !83
  %197 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3.2, float 0x4024CB5EC0000000), !dbg !84
  %198 = tail call contract noundef float @llvm.exp.f32(float %197), !dbg !87
  %add375.2944 = fadd contract float %sums.sroa.0.1, %192, !dbg !101
  %add375.1.2 = fadd contract float %sums.sroa.20.1, %194, !dbg !101
  %add375.2.2 = fadd contract float %sums.sroa.38.1, %196, !dbg !101
  %add375.3.2 = fadd contract float %sums.sroa.56.1, %198, !dbg !101
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %192), !dbg !90
  %200 = insertelement <4 x i16> poison, i16 %199, i64 0, !dbg !99
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %194), !dbg !90
  %202 = insertelement <4 x i16> %200, i16 %201, i64 1, !dbg !99
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %196), !dbg !90
  %204 = insertelement <4 x i16> %202, i16 %203, i64 2, !dbg !99
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %198), !dbg !90
  %206 = insertelement <4 x i16> %204, i16 %205, i64 3, !dbg !99
  %probs.sroa.22.22.vec.insert = bitcast <4 x i16> %206 to <4 x half>, !dbg !99
  br label %if.end410.2, !dbg !100

if.end410.2:                                      ; preds = %if.end410.1, %for.cond347.preheader.2
  %sums.sroa.0.2 = phi float [ %add375.2944, %for.cond347.preheader.2 ], [ %sums.sroa.0.1, %if.end410.1 ], !dbg !64
  %sums.sroa.20.2 = phi float [ %add375.1.2, %for.cond347.preheader.2 ], [ %sums.sroa.20.1, %if.end410.1 ], !dbg !64
  %sums.sroa.38.2 = phi float [ %add375.2.2, %for.cond347.preheader.2 ], [ %sums.sroa.38.1, %if.end410.1 ], !dbg !64
  %sums.sroa.56.2 = phi float [ %add375.3.2, %for.cond347.preheader.2 ], [ %sums.sroa.56.1, %if.end410.1 ], !dbg !64
  %probs.sroa.22.0 = phi <4 x half> [ %probs.sroa.22.22.vec.insert, %for.cond347.preheader.2 ], [ zeroinitializer, %if.end410.1 ], !dbg !64
  br i1 %or.cond845.3, label %if.end410.3, label %for.cond347.preheader.3, !dbg !81

for.cond347.preheader.3:                          ; preds = %if.end410.2
  %scores.sroa.110.48.vec.extract = extractelement <4 x float> %98, i64 0, !dbg !82
  %mul355.3949 = fmul contract float %scores.sroa.110.48.vec.extract, 0x3FB99999A0000000, !dbg !83
  %207 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3949, float 0x4024CB5EC0000000), !dbg !84
  %208 = tail call contract noundef float @llvm.exp.f32(float %207), !dbg !87
  %scores.sroa.110.52.vec.extract = extractelement <4 x float> %98, i64 1, !dbg !82
  %mul355.1.3 = fmul contract float %scores.sroa.110.52.vec.extract, 0x3FB99999A0000000, !dbg !83
  %209 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1.3, float 0x4024CB5EC0000000), !dbg !84
  %210 = tail call contract noundef float @llvm.exp.f32(float %209), !dbg !87
  %scores.sroa.110.56.vec.extract = extractelement <4 x float> %98, i64 2, !dbg !82
  %mul355.2.3 = fmul contract float %scores.sroa.110.56.vec.extract, 0x3FB99999A0000000, !dbg !83
  %211 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2.3, float 0x4024CB5EC0000000), !dbg !84
  %212 = tail call contract noundef float @llvm.exp.f32(float %211), !dbg !87
  %scores.sroa.110.60.vec.extract = extractelement <4 x float> %98, i64 3, !dbg !82
  %mul355.3.3 = fmul contract float %scores.sroa.110.60.vec.extract, 0x3FB99999A0000000, !dbg !83
  %213 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3.3, float 0x4024CB5EC0000000), !dbg !84
  %214 = tail call contract noundef float @llvm.exp.f32(float %213), !dbg !87
  %add375.3951 = fadd contract float %sums.sroa.0.2, %208, !dbg !101
  %add375.1.3 = fadd contract float %sums.sroa.20.2, %210, !dbg !101
  %add375.2.3 = fadd contract float %sums.sroa.38.2, %212, !dbg !101
  %add375.3.3 = fadd contract float %sums.sroa.56.2, %214, !dbg !101
  %215 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %208), !dbg !90
  %216 = insertelement <4 x i16> poison, i16 %215, i64 0, !dbg !99
  %217 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %210), !dbg !90
  %218 = insertelement <4 x i16> %216, i16 %217, i64 1, !dbg !99
  %219 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %212), !dbg !90
  %220 = insertelement <4 x i16> %218, i16 %219, i64 2, !dbg !99
  %221 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %214), !dbg !90
  %222 = insertelement <4 x i16> %220, i16 %221, i64 3, !dbg !99
  %probs.sroa.32.30.vec.insert = bitcast <4 x i16> %222 to <4 x half>, !dbg !99
  br label %if.end410.3, !dbg !100

if.end410.3:                                      ; preds = %if.end410.2, %for.cond347.preheader.3
  %sums.sroa.0.3 = phi float [ %add375.3951, %for.cond347.preheader.3 ], [ %sums.sroa.0.2, %if.end410.2 ], !dbg !64
  %sums.sroa.20.3 = phi float [ %add375.1.3, %for.cond347.preheader.3 ], [ %sums.sroa.20.2, %if.end410.2 ], !dbg !64
  %sums.sroa.38.3 = phi float [ %add375.2.3, %for.cond347.preheader.3 ], [ %sums.sroa.38.2, %if.end410.2 ], !dbg !64
  %sums.sroa.56.3 = phi float [ %add375.3.3, %for.cond347.preheader.3 ], [ %sums.sroa.56.2, %if.end410.2 ], !dbg !64
  %probs.sroa.32.0 = phi <4 x half> [ %probs.sroa.32.30.vec.insert, %for.cond347.preheader.3 ], [ zeroinitializer, %if.end410.2 ], !dbg !64
  br i1 %or.cond845.4, label %if.end410.4, label %for.cond347.preheader.4, !dbg !81

for.cond347.preheader.4:                          ; preds = %if.end410.3
  %scores.sroa.146.64.vec.extract = extractelement <4 x float> %99, i64 0, !dbg !82
  %mul355.4 = fmul contract float %scores.sroa.146.64.vec.extract, 0x3FB99999A0000000, !dbg !83
  %223 = tail call contract noundef float @llvm.minnum.f32(float %mul355.4, float 0x4024CB5EC0000000), !dbg !84
  %224 = tail call contract noundef float @llvm.exp.f32(float %223), !dbg !87
  %scores.sroa.146.68.vec.extract = extractelement <4 x float> %99, i64 1, !dbg !82
  %mul355.1.4 = fmul contract float %scores.sroa.146.68.vec.extract, 0x3FB99999A0000000, !dbg !83
  %225 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1.4, float 0x4024CB5EC0000000), !dbg !84
  %226 = tail call contract noundef float @llvm.exp.f32(float %225), !dbg !87
  %scores.sroa.146.72.vec.extract = extractelement <4 x float> %99, i64 2, !dbg !82
  %mul355.2.4 = fmul contract float %scores.sroa.146.72.vec.extract, 0x3FB99999A0000000, !dbg !83
  %227 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2.4, float 0x4024CB5EC0000000), !dbg !84
  %228 = tail call contract noundef float @llvm.exp.f32(float %227), !dbg !87
  %scores.sroa.146.76.vec.extract = extractelement <4 x float> %99, i64 3, !dbg !82
  %mul355.3.4 = fmul contract float %scores.sroa.146.76.vec.extract, 0x3FB99999A0000000, !dbg !83
  %229 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3.4, float 0x4024CB5EC0000000), !dbg !84
  %230 = tail call contract noundef float @llvm.exp.f32(float %229), !dbg !87
  %add375.4 = fadd contract float %sums.sroa.0.3, %224, !dbg !101
  %add375.1.4 = fadd contract float %sums.sroa.20.3, %226, !dbg !101
  %add375.2.4 = fadd contract float %sums.sroa.38.3, %228, !dbg !101
  %add375.3.4 = fadd contract float %sums.sroa.56.3, %230, !dbg !101
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %224), !dbg !90
  %232 = insertelement <4 x i16> poison, i16 %231, i64 0, !dbg !99
  %233 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %226), !dbg !90
  %234 = insertelement <4 x i16> %232, i16 %233, i64 1, !dbg !99
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %228), !dbg !90
  %236 = insertelement <4 x i16> %234, i16 %235, i64 2, !dbg !99
  %237 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %230), !dbg !90
  %238 = insertelement <4 x i16> %236, i16 %237, i64 3, !dbg !99
  %probs.sroa.42.38.vec.insert = bitcast <4 x i16> %238 to <4 x half>, !dbg !99
  br label %if.end410.4, !dbg !100

if.end410.4:                                      ; preds = %if.end410.3, %for.cond347.preheader.4
  %sums.sroa.0.4 = phi float [ %add375.4, %for.cond347.preheader.4 ], [ %sums.sroa.0.3, %if.end410.3 ], !dbg !64
  %sums.sroa.20.4 = phi float [ %add375.1.4, %for.cond347.preheader.4 ], [ %sums.sroa.20.3, %if.end410.3 ], !dbg !64
  %sums.sroa.38.4 = phi float [ %add375.2.4, %for.cond347.preheader.4 ], [ %sums.sroa.38.3, %if.end410.3 ], !dbg !64
  %sums.sroa.56.4 = phi float [ %add375.3.4, %for.cond347.preheader.4 ], [ %sums.sroa.56.3, %if.end410.3 ], !dbg !64
  %probs.sroa.42.0 = phi <4 x half> [ %probs.sroa.42.38.vec.insert, %for.cond347.preheader.4 ], [ zeroinitializer, %if.end410.3 ], !dbg !64
  br i1 %or.cond845.5, label %if.end410.5, label %for.cond347.preheader.5, !dbg !81

for.cond347.preheader.5:                          ; preds = %if.end410.4
  %scores.sroa.182.80.vec.extract = extractelement <4 x float> %100, i64 0, !dbg !82
  %mul355.5 = fmul contract float %scores.sroa.182.80.vec.extract, 0x3FB99999A0000000, !dbg !83
  %239 = tail call contract noundef float @llvm.minnum.f32(float %mul355.5, float 0x4024CB5EC0000000), !dbg !84
  %240 = tail call contract noundef float @llvm.exp.f32(float %239), !dbg !87
  %scores.sroa.182.84.vec.extract = extractelement <4 x float> %100, i64 1, !dbg !82
  %mul355.1.5 = fmul contract float %scores.sroa.182.84.vec.extract, 0x3FB99999A0000000, !dbg !83
  %241 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1.5, float 0x4024CB5EC0000000), !dbg !84
  %242 = tail call contract noundef float @llvm.exp.f32(float %241), !dbg !87
  %scores.sroa.182.88.vec.extract = extractelement <4 x float> %100, i64 2, !dbg !82
  %mul355.2.5 = fmul contract float %scores.sroa.182.88.vec.extract, 0x3FB99999A0000000, !dbg !83
  %243 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2.5, float 0x4024CB5EC0000000), !dbg !84
  %244 = tail call contract noundef float @llvm.exp.f32(float %243), !dbg !87
  %scores.sroa.182.92.vec.extract = extractelement <4 x float> %100, i64 3, !dbg !82
  %mul355.3.5 = fmul contract float %scores.sroa.182.92.vec.extract, 0x3FB99999A0000000, !dbg !83
  %245 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3.5, float 0x4024CB5EC0000000), !dbg !84
  %246 = tail call contract noundef float @llvm.exp.f32(float %245), !dbg !87
  %add375.5 = fadd contract float %sums.sroa.0.4, %240, !dbg !101
  %add375.1.5 = fadd contract float %sums.sroa.20.4, %242, !dbg !101
  %add375.2.5 = fadd contract float %sums.sroa.38.4, %244, !dbg !101
  %add375.3.5 = fadd contract float %sums.sroa.56.4, %246, !dbg !101
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %240), !dbg !90
  %248 = insertelement <4 x i16> poison, i16 %247, i64 0, !dbg !99
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %242), !dbg !90
  %250 = insertelement <4 x i16> %248, i16 %249, i64 1, !dbg !99
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %244), !dbg !90
  %252 = insertelement <4 x i16> %250, i16 %251, i64 2, !dbg !99
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %246), !dbg !90
  %254 = insertelement <4 x i16> %252, i16 %253, i64 3, !dbg !99
  %probs.sroa.52.46.vec.insert = bitcast <4 x i16> %254 to <4 x half>, !dbg !99
  br label %if.end410.5, !dbg !100

if.end410.5:                                      ; preds = %if.end410.4, %for.cond347.preheader.5
  %sums.sroa.0.5 = phi float [ %add375.5, %for.cond347.preheader.5 ], [ %sums.sroa.0.4, %if.end410.4 ], !dbg !64
  %sums.sroa.20.5 = phi float [ %add375.1.5, %for.cond347.preheader.5 ], [ %sums.sroa.20.4, %if.end410.4 ], !dbg !64
  %sums.sroa.38.5 = phi float [ %add375.2.5, %for.cond347.preheader.5 ], [ %sums.sroa.38.4, %if.end410.4 ], !dbg !64
  %sums.sroa.56.5 = phi float [ %add375.3.5, %for.cond347.preheader.5 ], [ %sums.sroa.56.4, %if.end410.4 ], !dbg !64
  %probs.sroa.52.0 = phi <4 x half> [ %probs.sroa.52.46.vec.insert, %for.cond347.preheader.5 ], [ zeroinitializer, %if.end410.4 ], !dbg !64
  br i1 %or.cond845.6, label %if.end410.6, label %for.cond347.preheader.6, !dbg !81

for.cond347.preheader.6:                          ; preds = %if.end410.5
  %scores.sroa.218.96.vec.extract = extractelement <4 x float> %101, i64 0, !dbg !82
  %mul355.6 = fmul contract float %scores.sroa.218.96.vec.extract, 0x3FB99999A0000000, !dbg !83
  %255 = tail call contract noundef float @llvm.minnum.f32(float %mul355.6, float 0x4024CB5EC0000000), !dbg !84
  %256 = tail call contract noundef float @llvm.exp.f32(float %255), !dbg !87
  %scores.sroa.218.100.vec.extract = extractelement <4 x float> %101, i64 1, !dbg !82
  %mul355.1.6 = fmul contract float %scores.sroa.218.100.vec.extract, 0x3FB99999A0000000, !dbg !83
  %257 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1.6, float 0x4024CB5EC0000000), !dbg !84
  %258 = tail call contract noundef float @llvm.exp.f32(float %257), !dbg !87
  %scores.sroa.218.104.vec.extract = extractelement <4 x float> %101, i64 2, !dbg !82
  %mul355.2.6 = fmul contract float %scores.sroa.218.104.vec.extract, 0x3FB99999A0000000, !dbg !83
  %259 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2.6, float 0x4024CB5EC0000000), !dbg !84
  %260 = tail call contract noundef float @llvm.exp.f32(float %259), !dbg !87
  %scores.sroa.218.108.vec.extract = extractelement <4 x float> %101, i64 3, !dbg !82
  %mul355.3.6 = fmul contract float %scores.sroa.218.108.vec.extract, 0x3FB99999A0000000, !dbg !83
  %261 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3.6, float 0x4024CB5EC0000000), !dbg !84
  %262 = tail call contract noundef float @llvm.exp.f32(float %261), !dbg !87
  %add375.6 = fadd contract float %sums.sroa.0.5, %256, !dbg !101
  %add375.1.6 = fadd contract float %sums.sroa.20.5, %258, !dbg !101
  %add375.2.6 = fadd contract float %sums.sroa.38.5, %260, !dbg !101
  %add375.3.6 = fadd contract float %sums.sroa.56.5, %262, !dbg !101
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %256), !dbg !90
  %264 = insertelement <4 x i16> poison, i16 %263, i64 0, !dbg !99
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %258), !dbg !90
  %266 = insertelement <4 x i16> %264, i16 %265, i64 1, !dbg !99
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %260), !dbg !90
  %268 = insertelement <4 x i16> %266, i16 %267, i64 2, !dbg !99
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %262), !dbg !90
  %270 = insertelement <4 x i16> %268, i16 %269, i64 3, !dbg !99
  %probs.sroa.62.54.vec.insert = bitcast <4 x i16> %270 to <4 x half>, !dbg !99
  br label %if.end410.6, !dbg !100

if.end410.6:                                      ; preds = %if.end410.5, %for.cond347.preheader.6
  %sums.sroa.0.6 = phi float [ %add375.6, %for.cond347.preheader.6 ], [ %sums.sroa.0.5, %if.end410.5 ], !dbg !64
  %sums.sroa.20.6 = phi float [ %add375.1.6, %for.cond347.preheader.6 ], [ %sums.sroa.20.5, %if.end410.5 ], !dbg !64
  %sums.sroa.38.6 = phi float [ %add375.2.6, %for.cond347.preheader.6 ], [ %sums.sroa.38.5, %if.end410.5 ], !dbg !64
  %sums.sroa.56.6 = phi float [ %add375.3.6, %for.cond347.preheader.6 ], [ %sums.sroa.56.5, %if.end410.5 ], !dbg !64
  %probs.sroa.62.0 = phi <4 x half> [ %probs.sroa.62.54.vec.insert, %for.cond347.preheader.6 ], [ zeroinitializer, %if.end410.5 ], !dbg !64
  br i1 %or.cond845.7, label %if.end410.7, label %for.cond347.preheader.7, !dbg !81

for.cond347.preheader.7:                          ; preds = %if.end410.6
  %scores.sroa.254.112.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !82
  %mul355.7 = fmul contract float %scores.sroa.254.112.vec.extract, 0x3FB99999A0000000, !dbg !83
  %271 = tail call contract noundef float @llvm.minnum.f32(float %mul355.7, float 0x4024CB5EC0000000), !dbg !84
  %272 = tail call contract noundef float @llvm.exp.f32(float %271), !dbg !87
  %scores.sroa.254.116.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !82
  %mul355.1.7 = fmul contract float %scores.sroa.254.116.vec.extract, 0x3FB99999A0000000, !dbg !83
  %273 = tail call contract noundef float @llvm.minnum.f32(float %mul355.1.7, float 0x4024CB5EC0000000), !dbg !84
  %274 = tail call contract noundef float @llvm.exp.f32(float %273), !dbg !87
  %scores.sroa.254.120.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !82
  %mul355.2.7 = fmul contract float %scores.sroa.254.120.vec.extract, 0x3FB99999A0000000, !dbg !83
  %275 = tail call contract noundef float @llvm.minnum.f32(float %mul355.2.7, float 0x4024CB5EC0000000), !dbg !84
  %276 = tail call contract noundef float @llvm.exp.f32(float %275), !dbg !87
  %scores.sroa.254.124.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !82
  %mul355.3.7 = fmul contract float %scores.sroa.254.124.vec.extract, 0x3FB99999A0000000, !dbg !83
  %277 = tail call contract noundef float @llvm.minnum.f32(float %mul355.3.7, float 0x4024CB5EC0000000), !dbg !84
  %278 = tail call contract noundef float @llvm.exp.f32(float %277), !dbg !87
  %add375.7 = fadd contract float %sums.sroa.0.6, %272, !dbg !101
  %add375.1.7 = fadd contract float %sums.sroa.20.6, %274, !dbg !101
  %add375.2.7 = fadd contract float %sums.sroa.38.6, %276, !dbg !101
  %add375.3.7 = fadd contract float %sums.sroa.56.6, %278, !dbg !101
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %272), !dbg !90
  %280 = insertelement <4 x i16> poison, i16 %279, i64 0, !dbg !99
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %274), !dbg !90
  %282 = insertelement <4 x i16> %280, i16 %281, i64 1, !dbg !99
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %276), !dbg !90
  %284 = insertelement <4 x i16> %282, i16 %283, i64 2, !dbg !99
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %278), !dbg !90
  %286 = insertelement <4 x i16> %284, i16 %285, i64 3, !dbg !99
  %probs.sroa.72.62.vec.insert = bitcast <4 x i16> %286 to <4 x half>, !dbg !99
  br label %if.end410.7, !dbg !100

if.end410.7:                                      ; preds = %if.end410.6, %for.cond347.preheader.7
  %sums.sroa.0.7 = phi float [ %add375.7, %for.cond347.preheader.7 ], [ %sums.sroa.0.6, %if.end410.6 ], !dbg !64
  %sums.sroa.20.7 = phi float [ %add375.1.7, %for.cond347.preheader.7 ], [ %sums.sroa.20.6, %if.end410.6 ], !dbg !64
  %sums.sroa.38.7 = phi float [ %add375.2.7, %for.cond347.preheader.7 ], [ %sums.sroa.38.6, %if.end410.6 ], !dbg !64
  %sums.sroa.56.7 = phi float [ %add375.3.7, %for.cond347.preheader.7 ], [ %sums.sroa.56.6, %if.end410.6 ], !dbg !64
  %probs.sroa.72.0 = phi <4 x half> [ %probs.sroa.72.62.vec.insert, %for.cond347.preheader.7 ], [ zeroinitializer, %if.end410.6 ], !dbg !64
  br i1 %or.cond845, label %if.end473, label %for.cond429.preheader, !dbg !102

for.cond429.preheader:                            ; preds = %if.end410.7
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %109, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !103
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %108, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !103
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %107, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !103
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %106, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !103
  br label %if.end473, !dbg !104

if.end473:                                        ; preds = %for.cond429.preheader, %if.end410.7
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end410.7 ], [ %287, %for.cond429.preheader ], !dbg !64
  %out.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end410.7 ], [ %288, %for.cond429.preheader ], !dbg !64
  %out.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end410.7 ], [ %289, %for.cond429.preheader ], !dbg !64
  %out.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end410.7 ], [ %290, %for.cond429.preheader ], !dbg !64
  br i1 %or.cond845.1, label %if.end473.1, label %for.cond451.preheader.1, !dbg !102

for.cond451.preheader.1:                          ; preds = %if.end473
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %116, <4 x half> %probs.sroa.12.0, <4 x float> zeroinitializer), !dbg !105
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %115, <4 x half> %probs.sroa.12.0, <4 x float> zeroinitializer), !dbg !105
  %293 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %114, <4 x half> %probs.sroa.12.0, <4 x float> zeroinitializer), !dbg !105
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %113, <4 x half> %probs.sroa.12.0, <4 x float> zeroinitializer), !dbg !105
  br label %if.end473.1, !dbg !104

if.end473.1:                                      ; preds = %for.cond451.preheader.1, %if.end473
  %out_1.sroa.74.1 = phi <4 x float> [ zeroinitializer, %if.end473 ], [ %294, %for.cond451.preheader.1 ], !dbg !64
  %out_1.sroa.50.1 = phi <4 x float> [ zeroinitializer, %if.end473 ], [ %293, %for.cond451.preheader.1 ], !dbg !64
  %out_1.sroa.26.1 = phi <4 x float> [ zeroinitializer, %if.end473 ], [ %292, %for.cond451.preheader.1 ], !dbg !64
  %out_1.sroa.0.1 = phi <4 x float> [ zeroinitializer, %if.end473 ], [ %291, %for.cond451.preheader.1 ], !dbg !64
  br i1 %or.cond845.2, label %if.end473.2, label %for.cond429.preheader.2, !dbg !102

for.cond429.preheader.2:                          ; preds = %if.end473.1
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %123, <4 x half> %probs.sroa.22.0, <4 x float> %out.sroa.0.0), !dbg !103
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %probs.sroa.22.0, <4 x float> %out.sroa.42.0), !dbg !103
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %121, <4 x half> %probs.sroa.22.0, <4 x float> %out.sroa.82.0), !dbg !103
  %298 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %120, <4 x half> %probs.sroa.22.0, <4 x float> %out.sroa.122.0), !dbg !103
  br label %if.end473.2, !dbg !104

if.end473.2:                                      ; preds = %for.cond429.preheader.2, %if.end473.1
  %out.sroa.0.2 = phi <4 x float> [ %out.sroa.0.0, %if.end473.1 ], [ %295, %for.cond429.preheader.2 ], !dbg !64
  %out.sroa.42.2 = phi <4 x float> [ %out.sroa.42.0, %if.end473.1 ], [ %296, %for.cond429.preheader.2 ], !dbg !64
  %out.sroa.82.2 = phi <4 x float> [ %out.sroa.82.0, %if.end473.1 ], [ %297, %for.cond429.preheader.2 ], !dbg !64
  %out.sroa.122.2 = phi <4 x float> [ %out.sroa.122.0, %if.end473.1 ], [ %298, %for.cond429.preheader.2 ], !dbg !64
  br i1 %or.cond845.3, label %if.end473.3, label %for.cond451.preheader.3, !dbg !102

for.cond451.preheader.3:                          ; preds = %if.end473.2
  %299 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %130, <4 x half> %probs.sroa.32.0, <4 x float> %out_1.sroa.0.1), !dbg !105
  %300 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %129, <4 x half> %probs.sroa.32.0, <4 x float> %out_1.sroa.26.1), !dbg !105
  %301 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %128, <4 x half> %probs.sroa.32.0, <4 x float> %out_1.sroa.50.1), !dbg !105
  %302 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %127, <4 x half> %probs.sroa.32.0, <4 x float> %out_1.sroa.74.1), !dbg !105
  br label %if.end473.3, !dbg !104

if.end473.3:                                      ; preds = %for.cond451.preheader.3, %if.end473.2
  %out_1.sroa.74.3 = phi <4 x float> [ %out_1.sroa.74.1, %if.end473.2 ], [ %302, %for.cond451.preheader.3 ], !dbg !64
  %out_1.sroa.50.3 = phi <4 x float> [ %out_1.sroa.50.1, %if.end473.2 ], [ %301, %for.cond451.preheader.3 ], !dbg !64
  %out_1.sroa.26.3 = phi <4 x float> [ %out_1.sroa.26.1, %if.end473.2 ], [ %300, %for.cond451.preheader.3 ], !dbg !64
  %out_1.sroa.0.3 = phi <4 x float> [ %out_1.sroa.0.1, %if.end473.2 ], [ %299, %for.cond451.preheader.3 ], !dbg !64
  br i1 %or.cond845.4, label %if.end473.4, label %for.cond429.preheader.4, !dbg !102

for.cond429.preheader.4:                          ; preds = %if.end473.3
  %303 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %137, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.0.2), !dbg !103
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %136, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.42.2), !dbg !103
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %135, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.82.2), !dbg !103
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %134, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.122.2), !dbg !103
  br label %if.end473.4, !dbg !104

if.end473.4:                                      ; preds = %for.cond429.preheader.4, %if.end473.3
  %out.sroa.0.4 = phi <4 x float> [ %out.sroa.0.2, %if.end473.3 ], [ %303, %for.cond429.preheader.4 ], !dbg !64
  %out.sroa.42.4 = phi <4 x float> [ %out.sroa.42.2, %if.end473.3 ], [ %304, %for.cond429.preheader.4 ], !dbg !64
  %out.sroa.82.4 = phi <4 x float> [ %out.sroa.82.2, %if.end473.3 ], [ %305, %for.cond429.preheader.4 ], !dbg !64
  %out.sroa.122.4 = phi <4 x float> [ %out.sroa.122.2, %if.end473.3 ], [ %306, %for.cond429.preheader.4 ], !dbg !64
  br i1 %or.cond845.5, label %if.end473.5, label %for.cond451.preheader.5, !dbg !102

for.cond451.preheader.5:                          ; preds = %if.end473.4
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %144, <4 x half> %probs.sroa.52.0, <4 x float> %out_1.sroa.0.3), !dbg !105
  %308 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %143, <4 x half> %probs.sroa.52.0, <4 x float> %out_1.sroa.26.3), !dbg !105
  %309 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %142, <4 x half> %probs.sroa.52.0, <4 x float> %out_1.sroa.50.3), !dbg !105
  %310 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %141, <4 x half> %probs.sroa.52.0, <4 x float> %out_1.sroa.74.3), !dbg !105
  br label %if.end473.5, !dbg !104

if.end473.5:                                      ; preds = %for.cond451.preheader.5, %if.end473.4
  %out_1.sroa.74.5 = phi <4 x float> [ %out_1.sroa.74.3, %if.end473.4 ], [ %310, %for.cond451.preheader.5 ], !dbg !64
  %out_1.sroa.50.5 = phi <4 x float> [ %out_1.sroa.50.3, %if.end473.4 ], [ %309, %for.cond451.preheader.5 ], !dbg !64
  %out_1.sroa.26.5 = phi <4 x float> [ %out_1.sroa.26.3, %if.end473.4 ], [ %308, %for.cond451.preheader.5 ], !dbg !64
  %out_1.sroa.0.5 = phi <4 x float> [ %out_1.sroa.0.3, %if.end473.4 ], [ %307, %for.cond451.preheader.5 ], !dbg !64
  br i1 %or.cond845.6, label %if.end473.6, label %for.cond429.preheader.6, !dbg !102

for.cond429.preheader.6:                          ; preds = %if.end473.5
  %311 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %151, <4 x half> %probs.sroa.62.0, <4 x float> %out.sroa.0.4), !dbg !103
  %312 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %150, <4 x half> %probs.sroa.62.0, <4 x float> %out.sroa.42.4), !dbg !103
  %313 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %149, <4 x half> %probs.sroa.62.0, <4 x float> %out.sroa.82.4), !dbg !103
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %148, <4 x half> %probs.sroa.62.0, <4 x float> %out.sroa.122.4), !dbg !103
  br label %if.end473.6, !dbg !104

if.end473.6:                                      ; preds = %for.cond429.preheader.6, %if.end473.5
  %out.sroa.0.6 = phi <4 x float> [ %out.sroa.0.4, %if.end473.5 ], [ %311, %for.cond429.preheader.6 ], !dbg !64
  %out.sroa.42.6 = phi <4 x float> [ %out.sroa.42.4, %if.end473.5 ], [ %312, %for.cond429.preheader.6 ], !dbg !64
  %out.sroa.82.6 = phi <4 x float> [ %out.sroa.82.4, %if.end473.5 ], [ %313, %for.cond429.preheader.6 ], !dbg !64
  %out.sroa.122.6 = phi <4 x float> [ %out.sroa.122.4, %if.end473.5 ], [ %314, %for.cond429.preheader.6 ], !dbg !64
  br i1 %or.cond845.7, label %if.end473.7, label %for.cond451.preheader.7, !dbg !102

for.cond451.preheader.7:                          ; preds = %if.end473.6
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %158, <4 x half> %probs.sroa.72.0, <4 x float> %out_1.sroa.0.5), !dbg !105
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %157, <4 x half> %probs.sroa.72.0, <4 x float> %out_1.sroa.26.5), !dbg !105
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %156, <4 x half> %probs.sroa.72.0, <4 x float> %out_1.sroa.50.5), !dbg !105
  %318 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %155, <4 x half> %probs.sroa.72.0, <4 x float> %out_1.sroa.74.5), !dbg !105
  br label %if.end473.7, !dbg !104

if.end473.7:                                      ; preds = %for.cond451.preheader.7, %if.end473.6
  %out_1.sroa.74.7 = phi <4 x float> [ %out_1.sroa.74.5, %if.end473.6 ], [ %318, %for.cond451.preheader.7 ], !dbg !64
  %out_1.sroa.50.7 = phi <4 x float> [ %out_1.sroa.50.5, %if.end473.6 ], [ %317, %for.cond451.preheader.7 ], !dbg !64
  %out_1.sroa.26.7 = phi <4 x float> [ %out_1.sroa.26.5, %if.end473.6 ], [ %316, %for.cond451.preheader.7 ], !dbg !64
  %out_1.sroa.0.7 = phi <4 x float> [ %out_1.sroa.0.5, %if.end473.6 ], [ %315, %for.cond451.preheader.7 ], !dbg !64
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 0, !dbg !106
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 0, !dbg !107
  %add485 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract, !dbg !108
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 1, !dbg !106
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 1, !dbg !107
  %add485.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract, !dbg !108
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 2, !dbg !106
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 2, !dbg !107
  %add485.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract, !dbg !108
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 3, !dbg !106
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 3, !dbg !107
  %add485.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract, !dbg !108
  %out.sroa.42.16.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 0, !dbg !106
  %out_1.sroa.26.16.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 0, !dbg !107
  %add485.4 = fadd contract float %out.sroa.42.16.vec.extract, %out_1.sroa.26.16.vec.extract, !dbg !108
  %out.sroa.42.20.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 1, !dbg !106
  %out_1.sroa.26.20.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 1, !dbg !107
  %add485.5 = fadd contract float %out.sroa.42.20.vec.extract, %out_1.sroa.26.20.vec.extract, !dbg !108
  %out.sroa.42.24.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 2, !dbg !106
  %out_1.sroa.26.24.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 2, !dbg !107
  %add485.6 = fadd contract float %out.sroa.42.24.vec.extract, %out_1.sroa.26.24.vec.extract, !dbg !108
  %out.sroa.42.28.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 3, !dbg !106
  %out_1.sroa.26.28.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 3, !dbg !107
  %add485.7 = fadd contract float %out.sroa.42.28.vec.extract, %out_1.sroa.26.28.vec.extract, !dbg !108
  %out.sroa.82.32.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 0, !dbg !106
  %out_1.sroa.50.32.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 0, !dbg !107
  %add485.8 = fadd contract float %out.sroa.82.32.vec.extract, %out_1.sroa.50.32.vec.extract, !dbg !108
  %out.sroa.82.36.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 1, !dbg !106
  %out_1.sroa.50.36.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 1, !dbg !107
  %add485.9 = fadd contract float %out.sroa.82.36.vec.extract, %out_1.sroa.50.36.vec.extract, !dbg !108
  %out.sroa.82.40.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 2, !dbg !106
  %out_1.sroa.50.40.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 2, !dbg !107
  %add485.10 = fadd contract float %out.sroa.82.40.vec.extract, %out_1.sroa.50.40.vec.extract, !dbg !108
  %out.sroa.82.44.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 3, !dbg !106
  %out_1.sroa.50.44.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 3, !dbg !107
  %add485.11 = fadd contract float %out.sroa.82.44.vec.extract, %out_1.sroa.50.44.vec.extract, !dbg !108
  %out.sroa.122.48.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 0, !dbg !106
  %out_1.sroa.74.48.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 0, !dbg !107
  %add485.12 = fadd contract float %out.sroa.122.48.vec.extract, %out_1.sroa.74.48.vec.extract, !dbg !108
  %out.sroa.122.52.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 1, !dbg !106
  %out_1.sroa.74.52.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 1, !dbg !107
  %add485.13 = fadd contract float %out.sroa.122.52.vec.extract, %out_1.sroa.74.52.vec.extract, !dbg !108
  %out.sroa.122.56.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 2, !dbg !106
  %out_1.sroa.74.56.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 2, !dbg !107
  %add485.14 = fadd contract float %out.sroa.122.56.vec.extract, %out_1.sroa.74.56.vec.extract, !dbg !108
  %out.sroa.122.60.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 3, !dbg !106
  %out_1.sroa.74.60.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 3, !dbg !107
  %add485.15 = fadd contract float %out.sroa.122.60.vec.extract, %out_1.sroa.74.60.vec.extract, !dbg !108
  %add499 = fadd contract float %sums.sroa.0.7, 0.000000e+00, !dbg !109
  %add499.1 = fadd contract float %add499, %sums.sroa.20.7, !dbg !109
  %add499.2 = fadd contract float %add499.1, %sums.sroa.38.7, !dbg !109
  %add499.3 = fadd contract float %add499.2, %sums.sroa.56.7, !dbg !109
  %319 = bitcast float %add499.3 to i32, !dbg !110
  %320 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !122
  %321 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %320) #11, !dbg !127
  %xor.i.i = xor i32 %321, 32, !dbg !128
  %322 = and i32 %321, -64, !dbg !129
  %and.i.i = add nsw i32 %322, 64, !dbg !129
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !130
  %cond.i.i793 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %321, !dbg !131
  %shl.i.i = shl i32 %cond.i.i793, 2, !dbg !132
  %323 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %319), !dbg !133
  %324 = bitcast i32 %323 to float, !dbg !134
  %add.i = fadd contract float %add499.3, %324, !dbg !135
  %325 = bitcast float %add.i to i32, !dbg !138
  %326 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !145
  %327 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %326) #11, !dbg !148
  %xor.i.i794 = xor i32 %327, 16, !dbg !149
  %328 = and i32 %327, -64, !dbg !150
  %and.i.i795 = add nsw i32 %328, 64, !dbg !150
  %cmp.not.i.i796 = icmp slt i32 %xor.i.i794, %and.i.i795, !dbg !151
  %cond.i.i797 = select i1 %cmp.not.i.i796, i32 %xor.i.i794, i32 %327, !dbg !152
  %shl.i.i798 = shl i32 %cond.i.i797, 2, !dbg !153
  %329 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i798, i32 %325), !dbg !154
  %330 = bitcast i32 %329 to float, !dbg !155
  %add.i.i = fadd contract float %add.i, %330, !dbg !156
  %cmp508 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !158
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !159
  %condval_1.0 = select i1 %cmp508, float %div, float 0.000000e+00, !dbg !159
  %mul521 = fmul contract float %condval_1.0, %add485, !dbg !160
  %mul521.1 = fmul contract float %condval_1.0, %add485.1, !dbg !160
  %mul521.2 = fmul contract float %condval_1.0, %add485.2, !dbg !160
  %mul521.3 = fmul contract float %condval_1.0, %add485.3, !dbg !160
  %mul521.4 = fmul contract float %condval_1.0, %add485.4, !dbg !160
  %mul521.5 = fmul contract float %condval_1.0, %add485.5, !dbg !160
  %mul521.6 = fmul contract float %condval_1.0, %add485.6, !dbg !160
  %mul521.7 = fmul contract float %condval_1.0, %add485.7, !dbg !160
  %mul521.8 = fmul contract float %condval_1.0, %add485.8, !dbg !160
  %mul521.9 = fmul contract float %condval_1.0, %add485.9, !dbg !160
  %mul521.10 = fmul contract float %condval_1.0, %add485.10, !dbg !160
  %mul521.11 = fmul contract float %condval_1.0, %add485.11, !dbg !160
  %mul521.12 = fmul contract float %condval_1.0, %add485.12, !dbg !160
  %mul521.13 = fmul contract float %condval_1.0, %add485.13, !dbg !160
  %mul521.14 = fmul contract float %condval_1.0, %add485.14, !dbg !160
  %mul521.15 = fmul contract float %condval_1.0, %add485.15, !dbg !160
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521), !dbg !161
  %O_reg.sroa.0.0.insert.ext = zext i16 %331 to i64, !dbg !165
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.1), !dbg !161
  %O_reg.sroa.0.2.insert.ext = zext i16 %332 to i64, !dbg !165
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !165
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !165
  %333 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.2), !dbg !161
  %O_reg.sroa.0.4.insert.ext = zext i16 %333 to i64, !dbg !165
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !165
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !165
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.3), !dbg !161
  %O_reg.sroa.0.6.insert.ext = zext i16 %334 to i64, !dbg !165
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !165
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !165
  %335 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.4), !dbg !161
  %O_reg.sroa.7.8.insert.ext = zext i16 %335 to i64, !dbg !165
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.5), !dbg !161
  %O_reg.sroa.7.10.insert.ext = zext i16 %336 to i64, !dbg !165
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !165
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !165
  %337 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.6), !dbg !161
  %O_reg.sroa.7.12.insert.ext = zext i16 %337 to i64, !dbg !165
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !165
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !165
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.7), !dbg !161
  %O_reg.sroa.7.14.insert.ext = zext i16 %338 to i64, !dbg !165
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !165
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !165
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.8), !dbg !161
  %O_reg.sroa.12.16.insert.ext = zext i16 %339 to i64, !dbg !165
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.9), !dbg !161
  %O_reg.sroa.12.18.insert.ext = zext i16 %340 to i64, !dbg !165
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !165
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !165
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.10), !dbg !161
  %O_reg.sroa.12.20.insert.ext = zext i16 %341 to i64, !dbg !165
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !165
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !165
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.11), !dbg !161
  %O_reg.sroa.12.22.insert.ext = zext i16 %342 to i64, !dbg !165
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !165
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !165
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.12), !dbg !161
  %O_reg.sroa.17.24.insert.ext = zext i16 %343 to i64, !dbg !165
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.13), !dbg !161
  %O_reg.sroa.17.26.insert.ext = zext i16 %344 to i64, !dbg !165
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !165
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !165
  %345 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.14), !dbg !161
  %O_reg.sroa.17.28.insert.ext = zext i16 %345 to i64, !dbg !165
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !165
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !165
  %346 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul521.15), !dbg !161
  %O_reg.sroa.17.30.insert.ext = zext i16 %346 to i64, !dbg !165
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !165
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !165
  %shr563 = lshr i32 %18, 5
  %and566 = and i32 %18, 7
  %mul572 = and i32 %70, 4
  %xor = xor i32 %shr563, %and566, !dbg !166
  %mul567 = shl nuw nsw i32 %xor, 3, !dbg !167
  %add568 = add nuw nsw i32 %mul567, %mul25, !dbg !168
  %add573 = or disjoint i32 %add568, %mul572, !dbg !169
  %add.ptr575 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add573, !dbg !170
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr575, align 8, !dbg !171
  %add564.1 = add nuw nsw i32 %shr563, 2, !dbg !172
  %xor.1 = xor i32 %add564.1, %and566, !dbg !166
  %mul567.1 = shl nuw nsw i32 %xor.1, 3, !dbg !167
  %add568.1 = add nuw nsw i32 %mul567.1, %mul25, !dbg !168
  %add573.1 = or disjoint i32 %add568.1, %mul572, !dbg !169
  %add.ptr575.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add573.1, !dbg !170
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr575.1, align 8, !dbg !171
  %add564.2 = add nuw nsw i32 %shr563, 4, !dbg !172
  %xor.2 = xor i32 %add564.2, %and566, !dbg !166
  %mul567.2 = shl nuw nsw i32 %xor.2, 3, !dbg !167
  %add568.2 = add nuw nsw i32 %mul567.2, %mul25, !dbg !168
  %add573.2 = or disjoint i32 %add568.2, %mul572, !dbg !169
  %add.ptr575.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add573.2, !dbg !170
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr575.2, align 8, !dbg !171
  %add564.3 = add nuw nsw i32 %shr563, 6, !dbg !172
  %xor.3 = xor i32 %add564.3, %and566, !dbg !166
  %mul567.3 = shl nuw nsw i32 %xor.3, 3, !dbg !167
  %add568.3 = add nuw nsw i32 %mul567.3, %mul25, !dbg !168
  %add573.3 = or disjoint i32 %add568.3, %mul572, !dbg !169
  %add.ptr575.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add573.3, !dbg !170
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr575.3, align 8, !dbg !171
  fence syncscope("warp") release, !dbg !173
  tail call void @llvm.mxc.barrier.warp(), !dbg !178
  fence syncscope("warp") acquire, !dbg !179
  %mul586 = and i32 %mul105, 8128
  %xor592750 = and i32 %mul105, 56
  %call590.masked = and i32 %18, 1016
  %mul593 = xor i32 %xor592750, %call590.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul586, !dbg !180
  %invariant.gep842 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul593, !dbg !180
  %add603 = add nuw nsw i32 %add23, %mul105
  %347 = zext nneg i32 %add603 to i64, !dbg !181
  %add.ptr608 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr608, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep842, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %gep843.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep842, i32 1024, !dbg !186
  %348 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !182
  %add.ptr608.1 = getelementptr inbounds i8, ptr addrspace(1) %348, i64 1024, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr608.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep843.1, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  ret void, !dbg !187
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
!1 = !DIFile(filename: "/tmp/tmpkht84h34/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpkht84h34/tvm_kernels.maca", directory: "")
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
!58 = !DILocation(line: 55, column: 23, scope: !40)
!59 = !DILocation(line: 56, column: 110, scope: !40)
!60 = !DILocation(line: 56, column: 133, scope: !40)
!61 = !DILocation(line: 56, column: 63, scope: !40)
!62 = !DILocation(line: 56, column: 49, scope: !40)
!63 = !DILocation(line: 57, column: 7, scope: !40)
!64 = !DILocation(line: 0, scope: !40)
!65 = !DILocation(line: 64, column: 3, scope: !40)
!66 = !DILocation(line: 66, column: 23, scope: !40)
!67 = !DILocation(line: 67, column: 29, scope: !40)
!68 = !DILocation(line: 67, column: 11, scope: !40)
!69 = !DILocation(line: 71, column: 66, scope: !40)
!70 = !DILocation(line: 71, column: 15, scope: !40)
!71 = !DILocation(line: 76, column: 37, scope: !40)
!72 = !DILocation(line: 71, column: 59, scope: !40)
!73 = !DILocation(line: 64, column: 30, scope: !40)
!74 = !DILocation(line: 95, column: 37, scope: !40)
!75 = !{i32 -1, i32 3, i32 -1}
!76 = !DILocation(line: 105, column: 23, scope: !40)
!77 = !DILocation(line: 107, column: 7, scope: !40)
!78 = !DILocation(line: 108, column: 63, scope: !40)
!79 = !DILocation(line: 108, column: 49, scope: !40)
!80 = !DILocation(line: 103, column: 30, scope: !40)
!81 = !DILocation(line: 121, column: 23, scope: !40)
!82 = !DILocation(line: 124, column: 47, scope: !40)
!83 = !DILocation(line: 124, column: 73, scope: !40)
!84 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!86 = distinct !DILocation(line: 124, column: 42, scope: !40)
!87 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !89)
!88 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!89 = distinct !DILocation(line: 124, column: 37, scope: !40)
!90 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !92, file: !92, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!93 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "__float2half", scope: !95, file: !95, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!96 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !98)
!97 = distinct !DISubprogram(name: "__half", scope: !95, file: !95, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = distinct !DILocation(line: 132, column: 36, scope: !40)
!99 = !DILocation(line: 132, column: 33, scope: !40)
!100 = !DILocation(line: 119, column: 30, scope: !40)
!101 = !DILocation(line: 128, column: 32, scope: !40)
!102 = !DILocation(line: 144, column: 23, scope: !40)
!103 = !DILocation(line: 148, column: 36, scope: !40)
!104 = !DILocation(line: 142, column: 30, scope: !40)
!105 = !DILocation(line: 156, column: 38, scope: !40)
!106 = !DILocation(line: 166, column: 17, scope: !40)
!107 = !DILocation(line: 166, column: 28, scope: !40)
!108 = !DILocation(line: 166, column: 26, scope: !40)
!109 = !DILocation(line: 171, column: 22, scope: !40)
!110 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !113)
!111 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !112, file: !112, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!113 = distinct !DILocation(line: 396, column: 10, scope: !114, inlinedAt: !116)
!114 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !115, file: !115, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!116 = distinct !DILocation(line: 129, column: 24, scope: !117, inlinedAt: !119)
!117 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !118, file: !118, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!119 = distinct !DILocation(line: 101, column: 14, scope: !120, inlinedAt: !121)
!120 = distinct !DISubprogram(name: "run<float>", scope: !118, file: !118, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!121 = distinct !DILocation(line: 173, column: 12, scope: !40)
!122 = !DILocation(line: 171, column: 37, scope: !123, inlinedAt: !124)
!123 = distinct !DISubprogram(name: "__lane_id", scope: !112, file: !112, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!124 = distinct !DILocation(line: 990, column: 14, scope: !125, inlinedAt: !126)
!125 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !112, file: !112, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!126 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !113)
!127 = !DILocation(line: 171, column: 10, scope: !123, inlinedAt: !124)
!128 = !DILocation(line: 991, column: 20, scope: !125, inlinedAt: !126)
!129 = !DILocation(line: 992, column: 36, scope: !125, inlinedAt: !126)
!130 = !DILocation(line: 992, column: 17, scope: !125, inlinedAt: !126)
!131 = !DILocation(line: 992, column: 11, scope: !125, inlinedAt: !126)
!132 = !DILocation(line: 993, column: 43, scope: !125, inlinedAt: !126)
!133 = !DILocation(line: 993, column: 10, scope: !125, inlinedAt: !126)
!134 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !113)
!135 = !DILocation(line: 25, column: 14, scope: !136, inlinedAt: !137)
!136 = distinct !DISubprogram(name: "operator()<float>", scope: !118, file: !118, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!137 = distinct !DILocation(line: 129, column: 11, scope: !117, inlinedAt: !119)
!138 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !139)
!139 = distinct !DILocation(line: 396, column: 10, scope: !114, inlinedAt: !140)
!140 = distinct !DILocation(line: 129, column: 24, scope: !141, inlinedAt: !142)
!141 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !118, file: !118, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!142 = distinct !DILocation(line: 101, column: 14, scope: !143, inlinedAt: !144)
!143 = distinct !DISubprogram(name: "run<float>", scope: !118, file: !118, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!144 = distinct !DILocation(line: 134, column: 14, scope: !117, inlinedAt: !119)
!145 = !DILocation(line: 171, column: 37, scope: !123, inlinedAt: !146)
!146 = distinct !DILocation(line: 990, column: 14, scope: !125, inlinedAt: !147)
!147 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !139)
!148 = !DILocation(line: 171, column: 10, scope: !123, inlinedAt: !146)
!149 = !DILocation(line: 991, column: 20, scope: !125, inlinedAt: !147)
!150 = !DILocation(line: 992, column: 36, scope: !125, inlinedAt: !147)
!151 = !DILocation(line: 992, column: 17, scope: !125, inlinedAt: !147)
!152 = !DILocation(line: 992, column: 11, scope: !125, inlinedAt: !147)
!153 = !DILocation(line: 993, column: 43, scope: !125, inlinedAt: !147)
!154 = !DILocation(line: 993, column: 10, scope: !125, inlinedAt: !147)
!155 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !139)
!156 = !DILocation(line: 25, column: 14, scope: !136, inlinedAt: !157)
!157 = distinct !DILocation(line: 129, column: 11, scope: !141, inlinedAt: !142)
!158 = !DILocation(line: 175, column: 32, scope: !40)
!159 = !DILocation(line: 175, column: 7, scope: !40)
!160 = !DILocation(line: 183, column: 26, scope: !40)
!161 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !162)
!162 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !163)
!163 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !164)
!164 = distinct !DILocation(line: 189, column: 35, scope: !40)
!165 = !DILocation(line: 189, column: 32, scope: !40)
!166 = !DILocation(line: 194, column: 122, scope: !40)
!167 = !DILocation(line: 194, column: 150, scope: !40)
!168 = !DILocation(line: 194, column: 77, scope: !40)
!169 = !DILocation(line: 194, column: 156, scope: !40)
!170 = !DILocation(line: 194, column: 40, scope: !40)
!171 = !DILocation(line: 194, column: 199, scope: !40)
!172 = !DILocation(line: 194, column: 93, scope: !40)
!173 = !DILocation(line: 68, column: 3, scope: !174, inlinedAt: !175)
!174 = distinct !DISubprogram(name: "__barrier_warp", scope: !112, file: !112, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!175 = distinct !DILocation(line: 192, column: 3, scope: !176, inlinedAt: !177)
!176 = distinct !DISubprogram(name: "__syncwarp", scope: !112, file: !112, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!177 = distinct !DILocation(line: 196, column: 3, scope: !40)
!178 = !DILocation(line: 69, column: 3, scope: !174, inlinedAt: !175)
!179 = !DILocation(line: 70, column: 3, scope: !174, inlinedAt: !175)
!180 = !DILocation(line: 198, column: 8, scope: !40)
!181 = !DILocation(line: 198, column: 3, scope: !40)
!182 = !DILocation(line: 199, column: 22, scope: !40)
!183 = !DILocation(line: 199, column: 132, scope: !40)
!184 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!185 = !{i32 2, i32 -1, i32 -1, i32 -1}
!186 = !DILocation(line: 199, column: 169, scope: !40)
!187 = !DILocation(line: 201, column: 1, scope: !40)
