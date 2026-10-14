; ModuleID = 'experiments/20261009_goal8933/schedule_extra_binary_audit/oj6_m0_p1.bc'
source_filename = "/tmp/tmpdwrhkqpn/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 2
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %4 = load i64, ptr addrspace(4) %add.ptr, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 512, !dbg !44
  %6 = load i64, ptr addrspace(4) %add.ptr.1, align 8, !dbg !45
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1024, !dbg !44
  %8 = load i64, ptr addrspace(4) %add.ptr.2, align 8, !dbg !45
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1536, !dbg !44
  %10 = load i64, ptr addrspace(4) %add.ptr.3, align 8, !dbg !45
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.4 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 2048, !dbg !44
  %12 = load i64, ptr addrspace(4) %add.ptr.4, align 8, !dbg !45
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.5 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2560, !dbg !44
  %14 = load i64, ptr addrspace(4) %add.ptr.5, align 8, !dbg !45
  %15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.6 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 3072, !dbg !44
  %16 = load i64, ptr addrspace(4) %add.ptr.6, align 8, !dbg !45
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.7 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 3584, !dbg !44
  %18 = load i64, ptr addrspace(4) %add.ptr.7, align 8, !dbg !45
  %mul17 = shl nsw i32 %0, 10, !dbg !46
  %add19 = add nuw nsw i32 %mul17, %1, !dbg !47
  %idxprom = zext nneg i32 %add19 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !48
  %19 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %cmp20 = icmp sgt i32 %19, -1, !dbg !49
  br i1 %cmp20, label %land.lhs.true, label %land.end, !dbg !50

land.lhs.true:                                    ; preds = %entry
  %cmp21 = icmp ult i32 %19, 32, !dbg !51
  %mul22 = shl nsw i32 %19, 5
  %cmp24 = icmp sle i32 %mul22, %1
  %spec.select = select i1 %cmp21, i1 %cmp24, i1 false, !dbg !52
  br label %land.end, !dbg !52

land.end:                                         ; preds = %land.lhs.true, %entry
  %20 = phi i1 [ false, %entry ], [ %spec.select, %land.lhs.true ], !dbg !53
  br i1 %20, label %for.cond25.preheader, label %if.end273, !dbg !54

for.cond25.preheader:                             ; preds = %land.end
  %conv = zext nneg i32 %0 to i64
  %conv32 = sext i32 %19 to i64
  %21 = shl nuw nsw i32 %2, 3
  %mul40 = zext nneg i32 %21 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul40, !dbg !55
  %.idx = shl nsw i64 %conv32, 13, !dbg !56
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx, !dbg !56
  %.idx527 = shl nuw nsw i64 %conv, 18, !dbg !56
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx527, !dbg !56
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %23, align 16, !dbg !57
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 8, !dbg !57
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8, !dbg !57
  %gep.1 = getelementptr i8, ptr addrspace(4) %23, i64 1024, !dbg !56
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !57
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 1032, !dbg !57
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8, !dbg !57
  %gep.2 = getelementptr i8, ptr addrspace(4) %23, i64 2048, !dbg !56
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16, !dbg !57
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 2056, !dbg !57
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8, !dbg !57
  %gep.3 = getelementptr i8, ptr addrspace(4) %23, i64 3072, !dbg !56
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16, !dbg !57
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 3080, !dbg !57
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8, !dbg !57
  %gep.4 = getelementptr i8, ptr addrspace(4) %23, i64 4096, !dbg !56
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16, !dbg !57
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 4104, !dbg !57
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8, !dbg !57
  %gep.5 = getelementptr i8, ptr addrspace(4) %23, i64 5120, !dbg !56
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16, !dbg !57
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 5128, !dbg !57
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8, !dbg !57
  %gep.6 = getelementptr i8, ptr addrspace(4) %23, i64 6144, !dbg !56
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16, !dbg !57
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 6152, !dbg !57
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8, !dbg !57
  %gep.7 = getelementptr i8, ptr addrspace(4) %23, i64 7168, !dbg !56
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16, !dbg !57
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 7176, !dbg !57
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8, !dbg !57
  %and = lshr i32 %2, 1
  %shr64 = and i32 %and, 15
  %shr67 = lshr i32 %2, 5
  %add62 = and i32 %mul11, 3972
  %xor = xor i32 %shr67, %shr64, !dbg !58
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add62, !dbg !59
  %add.ptr76.idx = shl nuw nsw i32 %xor, 4, !dbg !59
  %add.ptr76 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr76.idx, !dbg !59
  store i64 %4, ptr addrspace(3) %add.ptr76, align 8, !dbg !60
  %add68.1 = add nuw nsw i32 %shr67, 2, !dbg !61
  %xor.1 = xor i32 %add68.1, %shr64, !dbg !58
  %25 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 512, !dbg !59
  %add.ptr76.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !59
  %add.ptr76.1 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr76.idx.1, !dbg !59
  store i64 %6, ptr addrspace(3) %add.ptr76.1, align 8, !dbg !60
  %add68.2 = add nuw nsw i32 %shr67, 4, !dbg !61
  %xor.2 = xor i32 %add68.2, %shr64, !dbg !58
  %26 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1024, !dbg !59
  %add.ptr76.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !59
  %add.ptr76.2 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr76.idx.2, !dbg !59
  store i64 %8, ptr addrspace(3) %add.ptr76.2, align 8, !dbg !60
  %add68.3 = add nuw nsw i32 %shr67, 6, !dbg !61
  %xor.3 = xor i32 %add68.3, %shr64, !dbg !58
  %27 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1536, !dbg !59
  %add.ptr76.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !59
  %add.ptr76.3 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr76.idx.3, !dbg !59
  store i64 %10, ptr addrspace(3) %add.ptr76.3, align 8, !dbg !60
  %add68.4 = add nuw nsw i32 %shr67, 8, !dbg !61
  %xor.4 = xor i32 %add68.4, %shr64, !dbg !58
  %28 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2048, !dbg !59
  %add.ptr76.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !59
  %add.ptr76.4 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr76.idx.4, !dbg !59
  store i64 %12, ptr addrspace(3) %add.ptr76.4, align 8, !dbg !60
  %add68.5 = add nuw nsw i32 %shr67, 10, !dbg !61
  %xor.5 = xor i32 %add68.5, %shr64, !dbg !58
  %29 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2560, !dbg !59
  %add.ptr76.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !59
  %add.ptr76.5 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr76.idx.5, !dbg !59
  store i64 %14, ptr addrspace(3) %add.ptr76.5, align 8, !dbg !60
  %add68.6 = add nuw nsw i32 %shr67, 12, !dbg !61
  %xor.6 = xor i32 %add68.6, %shr64, !dbg !58
  %30 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3072, !dbg !59
  %add.ptr76.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !59
  %add.ptr76.6 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr76.idx.6, !dbg !59
  store i64 %16, ptr addrspace(3) %add.ptr76.6, align 8, !dbg !60
  %add68.7 = add nuw nsw i32 %shr67, 14, !dbg !61
  %xor.7 = xor i32 %add68.7, %shr64, !dbg !58
  %31 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3584, !dbg !59
  %add.ptr76.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !59
  %add.ptr76.7 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr76.idx.7, !dbg !59
  store i64 %18, ptr addrspace(3) %add.ptr76.7, align 8, !dbg !60
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !68
  fence syncscope("warp") acquire, !dbg !69
  %and86 = shl nuw nsw i32 %2, 7
  %mul87 = and i32 %and86, 1920
  %shr90 = lshr i32 %2, 4
  %and93 = and i32 %2, 15
  %32 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul87
  %xor94 = xor i32 %shr90, %and93, !dbg !70
  %add.ptr98.idx = shl nuw nsw i32 %xor94, 4, !dbg !71
  %add.ptr98 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx, !dbg !71
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98, align 16, !dbg !72
  %q.sroa.4.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98, i32 8, !dbg !72
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr98.sroa_idx, align 8, !dbg !72
  %add91.1 = add nuw nsw i32 %shr90, 4, !dbg !73
  %xor94.1 = xor i32 %add91.1, %and93, !dbg !70
  %add.ptr98.idx.1 = shl nuw nsw i32 %xor94.1, 4, !dbg !71
  %add.ptr98.1 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx.1, !dbg !71
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.1, align 16, !dbg !72
  %q.sroa.7.16.add.ptr98.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.1, i32 8, !dbg !72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr98.1.sroa_idx, align 8, !dbg !72
  %add91.2 = add nuw nsw i32 %shr90, 8, !dbg !73
  %xor94.2 = xor i32 %add91.2, %and93, !dbg !70
  %add.ptr98.idx.2 = shl nuw nsw i32 %xor94.2, 4, !dbg !71
  %add.ptr98.2 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx.2, !dbg !71
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.2, align 16, !dbg !72
  %q.sroa.10.32.add.ptr98.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.2, i32 8, !dbg !72
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr98.2.sroa_idx, align 8, !dbg !72
  %add91.3 = add nuw nsw i32 %shr90, 12, !dbg !73
  %xor94.3 = xor i32 %add91.3, %and93, !dbg !70
  %add.ptr98.idx.3 = shl nuw nsw i32 %xor94.3, 4, !dbg !71
  %add.ptr98.3 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx.3, !dbg !71
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.3, align 16, !dbg !72
  %q.sroa.13.48.add.ptr98.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.3, i32 8, !dbg !72
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr98.3.sroa_idx, align 8, !dbg !72
  %cmp111 = icmp slt i32 %19, 32
  %mul113 = shl nsw i32 %19, 5
  %33 = lshr i32 %2, 2
  %mul119 = and i32 %33, 252
  %add116 = add i32 %mul113, %mul119
  %cmp124.not = icmp sle i32 %add116, %1
  %or.cond.not = select i1 %cmp111, i1 %cmp124.not, i1 false, !dbg !74
  %condval.0 = select i1 %or.cond.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %condval.0, i64 0, !dbg !75
  %cmp124.not.1.not = icmp slt i32 %add116, %1
  %or.cond718 = select i1 %cmp111, i1 %cmp124.not.1.not, i1 false, !dbg !74
  %condval.0.1 = select i1 %or.cond718, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %condval.0.1, i64 1, !dbg !75
  %add120.2 = or disjoint i32 %add116, 2
  %cmp124.not.2 = icmp sle i32 %add120.2, %1
  %or.cond720.not = select i1 %cmp111, i1 %cmp124.not.2, i1 false, !dbg !74
  %condval.0.2 = select i1 %or.cond720.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %condval.0.2, i64 2, !dbg !75
  %add120.3 = or disjoint i32 %add116, 3
  %cmp124.not.3 = icmp sle i32 %add120.3, %1
  %or.cond722.not = select i1 %cmp111, i1 %cmp124.not.3, i1 false, !dbg !74
  %condval.0.3 = select i1 %or.cond722.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %condval.0.3, i64 3, !dbg !75
  %add122.4 = add i32 %add116, 16
  %cmp124.not.4 = icmp sle i32 %add122.4, %1
  %or.cond724.not = select i1 %cmp111, i1 %cmp124.not.4, i1 false, !dbg !74
  %condval.0.4 = select i1 %or.cond724.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %condval.0.4, i64 0, !dbg !75
  %add122.5 = add i32 %add116, 17
  %cmp124.not.5 = icmp sle i32 %add122.5, %1
  %or.cond726.not = select i1 %cmp111, i1 %cmp124.not.5, i1 false, !dbg !74
  %condval.0.5 = select i1 %or.cond726.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %condval.0.5, i64 1, !dbg !75
  %add122.6 = add i32 %add116, 18
  %cmp124.not.6 = icmp sle i32 %add122.6, %1
  %or.cond728.not = select i1 %cmp111, i1 %cmp124.not.6, i1 false, !dbg !74
  %condval.0.6 = select i1 %or.cond728.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %condval.0.6, i64 2, !dbg !75
  %add122.7 = add i32 %add116, 19
  %cmp124.not.7 = icmp sle i32 %add122.7, %1
  %or.cond730.not = select i1 %cmp111, i1 %cmp124.not.7, i1 false, !dbg !74
  %condval.0.7 = select i1 %or.cond730.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %condval.0.7, i64 3, !dbg !75
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !76, !call_argsrelate !77
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !76, !call_argsrelate !77
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %34), !dbg !76, !call_argsrelate !77
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %35), !dbg !76, !call_argsrelate !77
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %36), !dbg !76, !call_argsrelate !77
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %37), !dbg !76, !call_argsrelate !77
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %38), !dbg !76, !call_argsrelate !77
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %39), !dbg !76, !call_argsrelate !77
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %40), !dbg !76, !call_argsrelate !77
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %41), !dbg !76, !call_argsrelate !77
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %42), !dbg !76, !call_argsrelate !77
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %43), !dbg !76, !call_argsrelate !77
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %44), !dbg !76, !call_argsrelate !77
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %45), !dbg !76, !call_argsrelate !77
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %46), !dbg !76, !call_argsrelate !77
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %47), !dbg !76, !call_argsrelate !77
  %invariant.gep509 = getelementptr %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul40, !dbg !78
  %50 = getelementptr i8, ptr addrspace(4) %invariant.gep509, i64 %.idx, !dbg !79
  %51 = getelementptr i8, ptr addrspace(4) %50, i64 %.idx527, !dbg !79
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %51, align 16, !dbg !80
  %v.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %51, i64 8, !dbg !80
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0..sroa_idx, align 8, !dbg !80
  %gep510.1 = getelementptr i8, ptr addrspace(4) %51, i64 1024, !dbg !79
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep510.1, align 16, !dbg !80
  %v.sroa.7.16.gep510.1.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 1032, !dbg !80
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.gep510.1.sroa_idx, align 8, !dbg !80
  %gep510.2 = getelementptr i8, ptr addrspace(4) %51, i64 2048, !dbg !79
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep510.2, align 16, !dbg !80
  %v.sroa.10.32.gep510.2.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 2056, !dbg !80
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.gep510.2.sroa_idx, align 8, !dbg !80
  %gep510.3 = getelementptr i8, ptr addrspace(4) %51, i64 3072, !dbg !79
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep510.3, align 16, !dbg !80
  %v.sroa.13.48.gep510.3.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 3080, !dbg !80
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.gep510.3.sroa_idx, align 8, !dbg !80
  %gep510.4 = getelementptr i8, ptr addrspace(4) %51, i64 4096, !dbg !79
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep510.4, align 16, !dbg !80
  %v.sroa.16.64.gep510.4.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 4104, !dbg !80
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.gep510.4.sroa_idx, align 8, !dbg !80
  %gep510.5 = getelementptr i8, ptr addrspace(4) %51, i64 5120, !dbg !79
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep510.5, align 16, !dbg !80
  %v.sroa.19.80.gep510.5.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 5128, !dbg !80
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.gep510.5.sroa_idx, align 8, !dbg !80
  %gep510.6 = getelementptr i8, ptr addrspace(4) %51, i64 6144, !dbg !79
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep510.6, align 16, !dbg !80
  %v.sroa.22.96.gep510.6.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 6152, !dbg !80
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.gep510.6.sroa_idx, align 8, !dbg !80
  %gep510.7 = getelementptr i8, ptr addrspace(4) %51, i64 7168, !dbg !79
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep510.7, align 16, !dbg !80
  %v.sroa.25.112.gep510.7.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 7176, !dbg !80
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.gep510.7.sroa_idx, align 8, !dbg !80
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %48, i64 0, !dbg !81
  %mul203 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !82
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul203, float 1.500000e+01), !dbg !83
  %cmp.i.i = fcmp contract olt float %52, -1.260000e+02, !dbg !87
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494 = fadd contract float %52, %cond.i.i, !dbg !87
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i494), !dbg !87
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i = fmul contract float %cond2.i.i, %53, !dbg !87
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %48, i64 1, !dbg !81
  %mul203.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !82
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul203.1, float 1.500000e+01), !dbg !83
  %cmp.i.i.1 = fcmp contract olt float %54, -1.260000e+02, !dbg !87
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494.1 = fadd contract float %54, %cond.i.i.1, !dbg !87
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i494.1), !dbg !87
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %55, !dbg !87
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %48, i64 2, !dbg !81
  %mul203.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !82
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul203.2, float 1.500000e+01), !dbg !83
  %cmp.i.i.2 = fcmp contract olt float %56, -1.260000e+02, !dbg !87
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494.2 = fadd contract float %56, %cond.i.i.2, !dbg !87
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i494.2), !dbg !87
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %57, !dbg !87
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %48, i64 3, !dbg !81
  %mul203.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !82
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul203.3, float 1.500000e+01), !dbg !83
  %cmp.i.i.3 = fcmp contract olt float %58, -1.260000e+02, !dbg !87
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494.3 = fadd contract float %58, %cond.i.i.3, !dbg !87
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i494.3), !dbg !87
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %59, !dbg !87
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %49, i64 0, !dbg !81
  %mul203.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !82
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul203.4, float 1.500000e+01), !dbg !83
  %cmp.i.i.4 = fcmp contract olt float %60, -1.260000e+02, !dbg !87
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494.4 = fadd contract float %60, %cond.i.i.4, !dbg !87
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i494.4), !dbg !87
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %61, !dbg !87
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %49, i64 1, !dbg !81
  %mul203.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !82
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul203.5, float 1.500000e+01), !dbg !83
  %cmp.i.i.5 = fcmp contract olt float %62, -1.260000e+02, !dbg !87
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494.5 = fadd contract float %62, %cond.i.i.5, !dbg !87
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i494.5), !dbg !87
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %63, !dbg !87
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %49, i64 2, !dbg !81
  %mul203.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !82
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul203.6, float 1.500000e+01), !dbg !83
  %cmp.i.i.6 = fcmp contract olt float %64, -1.260000e+02, !dbg !87
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494.6 = fadd contract float %64, %cond.i.i.6, !dbg !87
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i494.6), !dbg !87
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %65, !dbg !87
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %49, i64 3, !dbg !81
  %mul203.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !82
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul203.7, float 1.500000e+01), !dbg !83
  %cmp.i.i.7 = fcmp contract olt float %66, -1.260000e+02, !dbg !87
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !87
  %add.i.i494.7 = fadd contract float %66, %cond.i.i.7, !dbg !87
  %67 = tail call contract float @llvm.exp2.f32(float %add.i.i494.7), !dbg !87
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !87
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %67, !dbg !87
  %add223 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !90
  %add223.1 = fadd contract float %add223, %mul.i.i.4, !dbg !90
  %add223.2 = fadd contract float %add223.1, %mul.i.i.1, !dbg !90
  %add223.3 = fadd contract float %add223.2, %mul.i.i.5, !dbg !90
  %add223.4 = fadd contract float %add223.3, %mul.i.i.2, !dbg !90
  %add223.5 = fadd contract float %add223.4, %mul.i.i.6, !dbg !90
  %add223.6 = fadd contract float %add223.5, %mul.i.i.3, !dbg !90
  %add223.7 = fadd contract float %add223.6, %mul.i.i.7, !dbg !90
  %68 = bitcast float %add223.7 to i32, !dbg !91
  %69 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !102
  %70 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %69) #11, !dbg !107
  %xor.i.i = xor i32 %70, 32, !dbg !108
  %71 = and i32 %70, -64, !dbg !109
  %and.i.i = add nsw i32 %71, 64, !dbg !109
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !110
  %cond.i.i495 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %70, !dbg !111
  %shl.i.i = shl i32 %cond.i.i495, 2, !dbg !112
  %72 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %68), !dbg !113
  %73 = bitcast i32 %72 to float, !dbg !114
  %add.i = fadd contract float %add223.7, %73, !dbg !115
  %74 = bitcast float %add.i to i32, !dbg !118
  %75 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !125
  %76 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %75) #11, !dbg !128
  %xor.i.i496 = xor i32 %76, 16, !dbg !129
  %77 = and i32 %76, -64, !dbg !130
  %and.i.i497 = add nsw i32 %77, 64, !dbg !130
  %cmp.not.i.i498 = icmp slt i32 %xor.i.i496, %and.i.i497, !dbg !131
  %cond.i.i499 = select i1 %cmp.not.i.i498, i32 %xor.i.i496, i32 %76, !dbg !132
  %shl.i.i500 = shl i32 %cond.i.i499, 2, !dbg !133
  %78 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i500, i32 %74), !dbg !134
  %79 = bitcast i32 %78 to float, !dbg !135
  %add.i.i = fadd contract float %add.i, %79, !dbg !136
  %cmp232 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !138
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !139
  %condval_1.0 = select i1 %cmp232, float %div, float 0.000000e+00, !dbg !139
  %mul245 = fmul contract float %condval_1.0, %mul.i.i, !dbg !140
  %mul245.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !140
  %mul245.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !140
  %mul245.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !140
  %mul245.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !140
  %mul245.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !140
  %mul245.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !140
  %mul245.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !140
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245), !dbg !141
  %81 = insertelement <4 x i16> poison, i16 %80, i64 0, !dbg !150
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.1), !dbg !141
  %83 = insertelement <4 x i16> %81, i16 %82, i64 1, !dbg !150
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.2), !dbg !141
  %85 = insertelement <4 x i16> %83, i16 %84, i64 2, !dbg !150
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.3), !dbg !141
  %87 = insertelement <4 x i16> %85, i16 %86, i64 3, !dbg !150
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %87 to <4 x half>, !dbg !150
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.4), !dbg !141
  %89 = insertelement <4 x i16> poison, i16 %88, i64 0, !dbg !150
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.5), !dbg !141
  %91 = insertelement <4 x i16> %89, i16 %90, i64 1, !dbg !150
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.6), !dbg !141
  %93 = insertelement <4 x i16> %91, i16 %92, i64 2, !dbg !150
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.7), !dbg !141
  %95 = insertelement <4 x i16> %93, i16 %94, i64 3, !dbg !150
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %95 to <4 x half>, !dbg !150
  br label %if.end273, !dbg !151

if.end273:                                        ; preds = %for.cond25.preheader, %land.end
  %v.sroa.25.0 = phi <4 x half> [ %v.sroa.25.112.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.23.0 = phi <4 x half> [ %v.sroa.23.112.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.22.0 = phi <4 x half> [ %v.sroa.22.96.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.20.0 = phi <4 x half> [ %v.sroa.20.96.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.19.0 = phi <4 x half> [ %v.sroa.19.80.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.17.0 = phi <4 x half> [ %v.sroa.17.80.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.16.0 = phi <4 x half> [ %v.sroa.16.64.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.14.0 = phi <4 x half> [ %v.sroa.14.64.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.13.0 = phi <4 x half> [ %v.sroa.13.48.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.11.0 = phi <4 x half> [ %v.sroa.11.48.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.10.0 = phi <4 x half> [ %v.sroa.10.32.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.8.0 = phi <4 x half> [ %v.sroa.8.32.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.7.0 = phi <4 x half> [ %v.sroa.7.16.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.5.0 = phi <4 x half> [ %v.sroa.5.16.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.4.0 = phi <4 x half> [ %v.sroa.4.0.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.0.0 = phi <4 x half> [ %v.sroa.0.0.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %prob.sroa.7.0 = phi <4 x half> [ %prob.sroa.7.14.vec.insert, %for.cond25.preheader ], [ undef, %land.end ]
  %prob.sroa.0.0 = phi <4 x half> [ %prob.sroa.0.6.vec.insert, %for.cond25.preheader ], [ undef, %land.end ]
  br i1 %20, label %for.cond293.preheader.preheader, label %if.end317, !dbg !152

for.cond293.preheader.preheader:                  ; preds = %if.end273
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !153
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.0, <4 x half> %prob.sroa.7.0, <4 x float> %96), !dbg !153
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.0, <4 x half> %prob.sroa.7.0, <4 x float> %97), !dbg !153
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.0, <4 x half> %prob.sroa.7.0, <4 x float> %98), !dbg !153
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.0, <4 x half> %prob.sroa.7.0, <4 x float> %99), !dbg !153
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.0, <4 x half> %prob.sroa.7.0, <4 x float> %100), !dbg !153
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.0, <4 x half> %prob.sroa.7.0, <4 x float> %101), !dbg !153
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.0, <4 x half> %prob.sroa.7.0, <4 x float> %102), !dbg !153
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.0, <4 x half> %prob.sroa.7.0, <4 x float> %103), !dbg !153
  br label %if.end317, !dbg !154

if.end317:                                        ; preds = %for.cond293.preheader.preheader, %if.end273
  %out.sroa.86.0 = phi <4 x float> [ %111, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.74.0 = phi <4 x float> [ %110, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.62.0 = phi <4 x float> [ %109, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.50.0 = phi <4 x float> [ %108, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.38.0 = phi <4 x float> [ %107, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.26.0 = phi <4 x float> [ %106, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.14.0 = phi <4 x float> [ %105, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.0.0 = phi <4 x float> [ %104, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ], !dbg !53
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0, !dbg !155
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !156
  %output_reg.sroa.0.0.insert.ext = zext i16 %112 to i64, !dbg !160
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1, !dbg !155
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !156
  %output_reg.sroa.0.2.insert.ext = zext i16 %113 to i64, !dbg !160
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !160
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !160
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2, !dbg !155
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !156
  %output_reg.sroa.0.4.insert.ext = zext i16 %114 to i64, !dbg !160
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !160
  %output_reg.sroa.0.4.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !160
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3, !dbg !155
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !156
  %output_reg.sroa.0.6.insert.ext = zext i16 %115 to i64, !dbg !160
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !160
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert, %output_reg.sroa.0.6.insert.shift, !dbg !160
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 0, !dbg !155
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !156
  %output_reg.sroa.7.8.insert.ext = zext i16 %116 to i64, !dbg !160
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 1, !dbg !155
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !156
  %output_reg.sroa.7.10.insert.ext = zext i16 %117 to i64, !dbg !160
  %output_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.7.10.insert.ext, 16, !dbg !160
  %output_reg.sroa.7.10.insert.insert = or disjoint i64 %output_reg.sroa.7.10.insert.shift, %output_reg.sroa.7.8.insert.ext, !dbg !160
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 2, !dbg !155
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !156
  %output_reg.sroa.7.12.insert.ext = zext i16 %118 to i64, !dbg !160
  %output_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.7.12.insert.ext, 32, !dbg !160
  %output_reg.sroa.7.12.insert.insert = or disjoint i64 %output_reg.sroa.7.10.insert.insert, %output_reg.sroa.7.12.insert.shift, !dbg !160
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 3, !dbg !155
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !156
  %output_reg.sroa.7.14.insert.ext = zext i16 %119 to i64, !dbg !160
  %output_reg.sroa.7.14.insert.shift = shl nuw i64 %output_reg.sroa.7.14.insert.ext, 48, !dbg !160
  %output_reg.sroa.7.14.insert.insert = or disjoint i64 %output_reg.sroa.7.12.insert.insert, %output_reg.sroa.7.14.insert.shift, !dbg !160
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 0, !dbg !155
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !156
  %output_reg.sroa.12.16.insert.ext = zext i16 %120 to i64, !dbg !160
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 1, !dbg !155
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !156
  %output_reg.sroa.12.18.insert.ext = zext i16 %121 to i64, !dbg !160
  %output_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.18.insert.ext, 16, !dbg !160
  %output_reg.sroa.12.18.insert.insert = or disjoint i64 %output_reg.sroa.12.18.insert.shift, %output_reg.sroa.12.16.insert.ext, !dbg !160
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 2, !dbg !155
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !156
  %output_reg.sroa.12.20.insert.ext = zext i16 %122 to i64, !dbg !160
  %output_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.20.insert.ext, 32, !dbg !160
  %output_reg.sroa.12.20.insert.insert = or disjoint i64 %output_reg.sroa.12.18.insert.insert, %output_reg.sroa.12.20.insert.shift, !dbg !160
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 3, !dbg !155
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !156
  %output_reg.sroa.12.22.insert.ext = zext i16 %123 to i64, !dbg !160
  %output_reg.sroa.12.22.insert.shift = shl nuw i64 %output_reg.sroa.12.22.insert.ext, 48, !dbg !160
  %output_reg.sroa.12.22.insert.insert = or disjoint i64 %output_reg.sroa.12.20.insert.insert, %output_reg.sroa.12.22.insert.shift, !dbg !160
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 0, !dbg !155
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !156
  %output_reg.sroa.17.24.insert.ext = zext i16 %124 to i64, !dbg !160
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 1, !dbg !155
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !156
  %output_reg.sroa.17.26.insert.ext = zext i16 %125 to i64, !dbg !160
  %output_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.17.26.insert.ext, 16, !dbg !160
  %output_reg.sroa.17.26.insert.insert = or disjoint i64 %output_reg.sroa.17.26.insert.shift, %output_reg.sroa.17.24.insert.ext, !dbg !160
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 2, !dbg !155
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !156
  %output_reg.sroa.17.28.insert.ext = zext i16 %126 to i64, !dbg !160
  %output_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.17.28.insert.ext, 32, !dbg !160
  %output_reg.sroa.17.28.insert.insert = or disjoint i64 %output_reg.sroa.17.26.insert.insert, %output_reg.sroa.17.28.insert.shift, !dbg !160
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 3, !dbg !155
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !156
  %output_reg.sroa.17.30.insert.ext = zext i16 %127 to i64, !dbg !160
  %output_reg.sroa.17.30.insert.shift = shl nuw i64 %output_reg.sroa.17.30.insert.ext, 48, !dbg !160
  %output_reg.sroa.17.30.insert.insert = or disjoint i64 %output_reg.sroa.17.28.insert.insert, %output_reg.sroa.17.30.insert.shift, !dbg !160
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 0, !dbg !155
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !156
  %output_reg.sroa.22.32.insert.ext = zext i16 %128 to i64, !dbg !160
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 1, !dbg !155
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !156
  %output_reg.sroa.22.34.insert.ext = zext i16 %129 to i64, !dbg !160
  %output_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.34.insert.ext, 16, !dbg !160
  %output_reg.sroa.22.34.insert.insert = or disjoint i64 %output_reg.sroa.22.34.insert.shift, %output_reg.sroa.22.32.insert.ext, !dbg !160
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 2, !dbg !155
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !156
  %output_reg.sroa.22.36.insert.ext = zext i16 %130 to i64, !dbg !160
  %output_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.36.insert.ext, 32, !dbg !160
  %output_reg.sroa.22.36.insert.insert = or disjoint i64 %output_reg.sroa.22.34.insert.insert, %output_reg.sroa.22.36.insert.shift, !dbg !160
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 3, !dbg !155
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !156
  %output_reg.sroa.22.38.insert.ext = zext i16 %131 to i64, !dbg !160
  %output_reg.sroa.22.38.insert.shift = shl nuw i64 %output_reg.sroa.22.38.insert.ext, 48, !dbg !160
  %output_reg.sroa.22.38.insert.insert = or disjoint i64 %output_reg.sroa.22.36.insert.insert, %output_reg.sroa.22.38.insert.shift, !dbg !160
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 0, !dbg !155
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !156
  %output_reg.sroa.27.40.insert.ext = zext i16 %132 to i64, !dbg !160
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 1, !dbg !155
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !156
  %output_reg.sroa.27.42.insert.ext = zext i16 %133 to i64, !dbg !160
  %output_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.27.42.insert.ext, 16, !dbg !160
  %output_reg.sroa.27.42.insert.insert = or disjoint i64 %output_reg.sroa.27.42.insert.shift, %output_reg.sroa.27.40.insert.ext, !dbg !160
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 2, !dbg !155
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !156
  %output_reg.sroa.27.44.insert.ext = zext i16 %134 to i64, !dbg !160
  %output_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.27.44.insert.ext, 32, !dbg !160
  %output_reg.sroa.27.44.insert.insert = or disjoint i64 %output_reg.sroa.27.42.insert.insert, %output_reg.sroa.27.44.insert.shift, !dbg !160
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 3, !dbg !155
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !156
  %output_reg.sroa.27.46.insert.ext = zext i16 %135 to i64, !dbg !160
  %output_reg.sroa.27.46.insert.shift = shl nuw i64 %output_reg.sroa.27.46.insert.ext, 48, !dbg !160
  %output_reg.sroa.27.46.insert.insert = or disjoint i64 %output_reg.sroa.27.44.insert.insert, %output_reg.sroa.27.46.insert.shift, !dbg !160
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 0, !dbg !155
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !156
  %output_reg.sroa.32.48.insert.ext = zext i16 %136 to i64, !dbg !160
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 1, !dbg !155
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !156
  %output_reg.sroa.32.50.insert.ext = zext i16 %137 to i64, !dbg !160
  %output_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.50.insert.ext, 16, !dbg !160
  %output_reg.sroa.32.50.insert.insert = or disjoint i64 %output_reg.sroa.32.50.insert.shift, %output_reg.sroa.32.48.insert.ext, !dbg !160
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 2, !dbg !155
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !156
  %output_reg.sroa.32.52.insert.ext = zext i16 %138 to i64, !dbg !160
  %output_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.52.insert.ext, 32, !dbg !160
  %output_reg.sroa.32.52.insert.insert = or disjoint i64 %output_reg.sroa.32.50.insert.insert, %output_reg.sroa.32.52.insert.shift, !dbg !160
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 3, !dbg !155
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !156
  %output_reg.sroa.32.54.insert.ext = zext i16 %139 to i64, !dbg !160
  %output_reg.sroa.32.54.insert.shift = shl nuw i64 %output_reg.sroa.32.54.insert.ext, 48, !dbg !160
  %output_reg.sroa.32.54.insert.insert = or disjoint i64 %output_reg.sroa.32.52.insert.insert, %output_reg.sroa.32.54.insert.shift, !dbg !160
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 0, !dbg !155
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !156
  %output_reg.sroa.37.56.insert.ext = zext i16 %140 to i64, !dbg !160
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 1, !dbg !155
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !156
  %output_reg.sroa.37.58.insert.ext = zext i16 %141 to i64, !dbg !160
  %output_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.58.insert.ext, 16, !dbg !160
  %output_reg.sroa.37.58.insert.insert = or disjoint i64 %output_reg.sroa.37.58.insert.shift, %output_reg.sroa.37.56.insert.ext, !dbg !160
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 2, !dbg !155
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !156
  %output_reg.sroa.37.60.insert.ext = zext i16 %142 to i64, !dbg !160
  %output_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.60.insert.ext, 32, !dbg !160
  %output_reg.sroa.37.60.insert.insert = or disjoint i64 %output_reg.sroa.37.58.insert.insert, %output_reg.sroa.37.60.insert.shift, !dbg !160
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 3, !dbg !155
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !156
  %output_reg.sroa.37.62.insert.ext = zext i16 %143 to i64, !dbg !160
  %output_reg.sroa.37.62.insert.shift = shl nuw i64 %output_reg.sroa.37.62.insert.ext, 48, !dbg !160
  %output_reg.sroa.37.62.insert.insert = or disjoint i64 %output_reg.sroa.37.60.insert.insert, %output_reg.sroa.37.62.insert.shift, !dbg !160
  fence syncscope("warp") release, !dbg !161
  tail call void @llvm.mxc.barrier.warp(), !dbg !164
  fence syncscope("warp") acquire, !dbg !165
  %and350 = shl nuw nsw i32 %2, 7
  %mul351 = and i32 %and350, 1920
  %shr354 = lshr i32 %2, 5
  %and357 = and i32 %2, 15
  %144 = lshr i32 %2, 2
  %mul364 = and i32 %144, 4
  %xor358 = xor i32 %shr354, %and357, !dbg !166
  %mul359 = shl nuw nsw i32 %xor358, 3, !dbg !167
  %add360 = add nuw nsw i32 %mul359, %mul351, !dbg !168
  %add365 = or disjoint i32 %add360, %mul364, !dbg !169
  %add.ptr367 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365, !dbg !170
  store i64 %output_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr367, align 8, !dbg !171
  %add355.1 = add nuw nsw i32 %shr354, 2, !dbg !172
  %xor358.1 = xor i32 %add355.1, %and357, !dbg !166
  %mul359.1 = shl nuw nsw i32 %xor358.1, 3, !dbg !167
  %add360.1 = add nuw nsw i32 %mul359.1, %mul351, !dbg !168
  %add365.1 = or disjoint i32 %add360.1, %mul364, !dbg !169
  %add.ptr367.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.1, !dbg !170
  store i64 %output_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr367.1, align 8, !dbg !171
  %add355.2 = add nuw nsw i32 %shr354, 4, !dbg !172
  %xor358.2 = xor i32 %add355.2, %and357, !dbg !166
  %mul359.2 = shl nuw nsw i32 %xor358.2, 3, !dbg !167
  %add360.2 = add nuw nsw i32 %mul359.2, %mul351, !dbg !168
  %add365.2 = or disjoint i32 %add360.2, %mul364, !dbg !169
  %add.ptr367.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.2, !dbg !170
  store i64 %output_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr367.2, align 8, !dbg !171
  %add355.3 = add nuw nsw i32 %shr354, 6, !dbg !172
  %xor358.3 = xor i32 %add355.3, %and357, !dbg !166
  %mul359.3 = shl nuw nsw i32 %xor358.3, 3, !dbg !167
  %add360.3 = add nuw nsw i32 %mul359.3, %mul351, !dbg !168
  %add365.3 = or disjoint i32 %add360.3, %mul364, !dbg !169
  %add.ptr367.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.3, !dbg !170
  store i64 %output_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr367.3, align 8, !dbg !171
  %add355.4 = add nuw nsw i32 %shr354, 8, !dbg !172
  %xor358.4 = xor i32 %add355.4, %and357, !dbg !166
  %mul359.4 = shl nuw nsw i32 %xor358.4, 3, !dbg !167
  %add360.4 = add nuw nsw i32 %mul359.4, %mul351, !dbg !168
  %add365.4 = or disjoint i32 %add360.4, %mul364, !dbg !169
  %add.ptr367.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.4, !dbg !170
  store i64 %output_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr367.4, align 8, !dbg !171
  %add355.5 = add nuw nsw i32 %shr354, 10, !dbg !172
  %xor358.5 = xor i32 %add355.5, %and357, !dbg !166
  %mul359.5 = shl nuw nsw i32 %xor358.5, 3, !dbg !167
  %add360.5 = add nuw nsw i32 %mul359.5, %mul351, !dbg !168
  %add365.5 = or disjoint i32 %add360.5, %mul364, !dbg !169
  %add.ptr367.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.5, !dbg !170
  store i64 %output_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr367.5, align 8, !dbg !171
  %add355.6 = add nuw nsw i32 %shr354, 12, !dbg !172
  %xor358.6 = xor i32 %add355.6, %and357, !dbg !166
  %mul359.6 = shl nuw nsw i32 %xor358.6, 3, !dbg !167
  %add360.6 = add nuw nsw i32 %mul359.6, %mul351, !dbg !168
  %add365.6 = or disjoint i32 %add360.6, %mul364, !dbg !169
  %add.ptr367.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.6, !dbg !170
  store i64 %output_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr367.6, align 8, !dbg !171
  %add355.7 = add nuw nsw i32 %shr354, 14, !dbg !172
  %xor358.7 = xor i32 %add355.7, %and357, !dbg !166
  %mul359.7 = shl nuw nsw i32 %xor358.7, 3, !dbg !167
  %add360.7 = add nuw nsw i32 %mul359.7, %mul351, !dbg !168
  %add365.7 = or disjoint i32 %add360.7, %mul364, !dbg !169
  %add.ptr367.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.7, !dbg !170
  store i64 %output_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr367.7, align 8, !dbg !171
  fence syncscope("warp") release, !dbg !173
  tail call void @llvm.mxc.barrier.warp(), !dbg !176
  fence syncscope("warp") acquire, !dbg !177
  %145 = shl nuw nsw i32 %2, 3
  %mul378 = and i32 %145, 8064
  %shr384 = lshr i32 %2, 4
  %invariant.gep524 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul378, !dbg !178
  %add397 = add nuw nsw i32 %add, %145
  %146 = zext nneg i32 %add397 to i64, !dbg !179
  %xor386 = xor i32 %shr384, %and357, !dbg !180
  %add.ptr390.idx = shl nuw nsw i32 %xor386, 4, !dbg !181
  %add.ptr390 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 %add.ptr390.idx, !dbg !181
  %add.ptr402 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %147 = add nuw nsw i32 %shr384, 4, !dbg !186
  %xor386.1 = xor i32 %147, %and357, !dbg !180
  %gep525.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 1024, !dbg !181
  %add.ptr390.idx.1 = shl nuw nsw i32 %xor386.1, 4, !dbg !181
  %add.ptr390.1 = getelementptr inbounds i8, ptr addrspace(3) %gep525.1, i32 %add.ptr390.idx.1, !dbg !181
  %148 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146, !dbg !182
  %add.ptr402.1 = getelementptr inbounds i8, ptr addrspace(1) %148, i64 1024, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390.1, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %149 = add nuw nsw i32 %shr384, 8, !dbg !186
  %xor386.2 = xor i32 %149, %and357, !dbg !180
  %gep525.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 2048, !dbg !181
  %add.ptr390.idx.2 = shl nuw nsw i32 %xor386.2, 4, !dbg !181
  %add.ptr390.2 = getelementptr inbounds i8, ptr addrspace(3) %gep525.2, i32 %add.ptr390.idx.2, !dbg !181
  %150 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146, !dbg !182
  %add.ptr402.2 = getelementptr inbounds i8, ptr addrspace(1) %150, i64 2048, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390.2, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %narrow = add nuw nsw i32 %shr384, 12, !dbg !186
  %xor386.3 = xor i32 %narrow, %and357, !dbg !180
  %gep525.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 3072, !dbg !181
  %add.ptr390.idx.3 = shl nuw nsw i32 %xor386.3, 4, !dbg !181
  %add.ptr390.3 = getelementptr inbounds i8, ptr addrspace(3) %gep525.3, i32 %add.ptr390.idx.3, !dbg !181
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146, !dbg !182
  %add.ptr402.3 = getelementptr inbounds i8, ptr addrspace(1) %151, i64 3072, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390.3, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
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

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

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
declare void @llvm.mxc.sleep(i32 immarg) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #9

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpdwrhkqpn/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpdwrhkqpn/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 23, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 48, scope: !40)
!45 = !DILocation(line: 24, column: 34, scope: !40)
!46 = !DILocation(line: 26, column: 43, scope: !40)
!47 = !DILocation(line: 26, column: 51, scope: !40)
!48 = !DILocation(line: 26, column: 15, scope: !40)
!49 = !DILocation(line: 27, column: 21, scope: !40)
!50 = !DILocation(line: 27, column: 31, scope: !40)
!51 = !DILocation(line: 27, column: 41, scope: !40)
!52 = !DILocation(line: 27, column: 48, scope: !40)
!53 = !DILocation(line: 0, scope: !40)
!54 = !DILocation(line: 28, column: 7, scope: !40)
!55 = !DILocation(line: 30, column: 5, scope: !40)
!56 = !DILocation(line: 31, column: 46, scope: !40)
!57 = !DILocation(line: 31, column: 32, scope: !40)
!58 = !DILocation(line: 35, column: 133, scope: !40)
!59 = !DILocation(line: 35, column: 42, scope: !40)
!60 = !DILocation(line: 35, column: 217, scope: !40)
!61 = !DILocation(line: 35, column: 146, scope: !40)
!62 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !65)
!63 = distinct !DISubprogram(name: "__barrier_warp", scope: !64, file: !64, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!64 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!65 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !67)
!66 = distinct !DISubprogram(name: "__syncwarp", scope: !64, file: !64, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!67 = distinct !DILocation(line: 37, column: 5, scope: !40)
!68 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !65)
!69 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !65)
!70 = !DILocation(line: 40, column: 150, scope: !40)
!71 = !DILocation(line: 40, column: 69, scope: !40)
!72 = !DILocation(line: 40, column: 32, scope: !40)
!73 = !DILocation(line: 40, column: 121, scope: !40)
!74 = !DILocation(line: 45, column: 25, scope: !40)
!75 = !DILocation(line: 50, column: 19, scope: !40)
!76 = !DILocation(line: 56, column: 37, scope: !40)
!77 = !{i32 1, i32 -1, i32 -1}
!78 = !DILocation(line: 64, column: 5, scope: !40)
!79 = !DILocation(line: 65, column: 46, scope: !40)
!80 = !DILocation(line: 65, column: 32, scope: !40)
!81 = !DILocation(line: 69, column: 32, scope: !40)
!82 = !DILocation(line: 69, column: 44, scope: !40)
!83 = !DILocation(line: 354, column: 10, scope: !84, inlinedAt: !86)
!84 = distinct !DISubprogram(name: "min", scope: !85, file: !85, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!85 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!86 = distinct !DILocation(line: 69, column: 27, scope: !40)
!87 = !DILocation(line: 285, column: 49, scope: !88, inlinedAt: !89)
!88 = distinct !DISubprogram(name: "exp2f", scope: !85, file: !85, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!89 = distinct !DILocation(line: 69, column: 21, scope: !40)
!90 = !DILocation(line: 74, column: 28, scope: !40)
!91 = !DILocation(line: 1018, column: 9, scope: !92, inlinedAt: !93)
!92 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = distinct !DILocation(line: 396, column: 10, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !95, file: !95, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!96 = distinct !DILocation(line: 129, column: 24, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !98, file: !98, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!99 = distinct !DILocation(line: 101, column: 14, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "run<float>", scope: !98, file: !98, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 76, column: 16, scope: !40)
!102 = !DILocation(line: 171, column: 37, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "__lane_id", scope: !64, file: !64, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 990, column: 14, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 1019, column: 11, scope: !92, inlinedAt: !93)
!107 = !DILocation(line: 171, column: 10, scope: !103, inlinedAt: !104)
!108 = !DILocation(line: 991, column: 20, scope: !105, inlinedAt: !106)
!109 = !DILocation(line: 992, column: 36, scope: !105, inlinedAt: !106)
!110 = !DILocation(line: 992, column: 17, scope: !105, inlinedAt: !106)
!111 = !DILocation(line: 992, column: 11, scope: !105, inlinedAt: !106)
!112 = !DILocation(line: 993, column: 43, scope: !105, inlinedAt: !106)
!113 = !DILocation(line: 993, column: 10, scope: !105, inlinedAt: !106)
!114 = !DILocation(line: 1020, column: 14, scope: !92, inlinedAt: !93)
!115 = !DILocation(line: 25, column: 14, scope: !116, inlinedAt: !117)
!116 = distinct !DISubprogram(name: "operator()<float>", scope: !98, file: !98, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = distinct !DILocation(line: 129, column: 11, scope: !97, inlinedAt: !99)
!118 = !DILocation(line: 1018, column: 9, scope: !92, inlinedAt: !119)
!119 = distinct !DILocation(line: 396, column: 10, scope: !94, inlinedAt: !120)
!120 = distinct !DILocation(line: 129, column: 24, scope: !121, inlinedAt: !122)
!121 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !98, file: !98, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!122 = distinct !DILocation(line: 101, column: 14, scope: !123, inlinedAt: !124)
!123 = distinct !DISubprogram(name: "run<float>", scope: !98, file: !98, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!124 = distinct !DILocation(line: 134, column: 14, scope: !97, inlinedAt: !99)
!125 = !DILocation(line: 171, column: 37, scope: !103, inlinedAt: !126)
!126 = distinct !DILocation(line: 990, column: 14, scope: !105, inlinedAt: !127)
!127 = distinct !DILocation(line: 1019, column: 11, scope: !92, inlinedAt: !119)
!128 = !DILocation(line: 171, column: 10, scope: !103, inlinedAt: !126)
!129 = !DILocation(line: 991, column: 20, scope: !105, inlinedAt: !127)
!130 = !DILocation(line: 992, column: 36, scope: !105, inlinedAt: !127)
!131 = !DILocation(line: 992, column: 17, scope: !105, inlinedAt: !127)
!132 = !DILocation(line: 992, column: 11, scope: !105, inlinedAt: !127)
!133 = !DILocation(line: 993, column: 43, scope: !105, inlinedAt: !127)
!134 = !DILocation(line: 993, column: 10, scope: !105, inlinedAt: !127)
!135 = !DILocation(line: 1020, column: 14, scope: !92, inlinedAt: !119)
!136 = !DILocation(line: 25, column: 14, scope: !116, inlinedAt: !137)
!137 = distinct !DILocation(line: 129, column: 11, scope: !121, inlinedAt: !122)
!138 = !DILocation(line: 78, column: 34, scope: !40)
!139 = !DILocation(line: 78, column: 9, scope: !40)
!140 = !DILocation(line: 86, column: 34, scope: !40)
!141 = !DILocation(line: 75, column: 10, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !143, file: !143, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!143 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!144 = distinct !DILocation(line: 984, column: 9, scope: !145, inlinedAt: !147)
!145 = distinct !DISubprogram(name: "__float2half", scope: !146, file: !146, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!147 = distinct !DILocation(line: 133, column: 53, scope: !148, inlinedAt: !149)
!148 = distinct !DISubprogram(name: "__half", scope: !146, file: !146, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = distinct !DILocation(line: 92, column: 49, scope: !40)
!150 = !DILocation(line: 92, column: 46, scope: !40)
!151 = !DILocation(line: 97, column: 3, scope: !40)
!152 = !DILocation(line: 101, column: 7, scope: !40)
!153 = !DILocation(line: 105, column: 36, scope: !40)
!154 = !DILocation(line: 113, column: 3, scope: !40)
!155 = !DILocation(line: 116, column: 65, scope: !40)
!156 = !DILocation(line: 75, column: 10, scope: !142, inlinedAt: !157)
!157 = distinct !DILocation(line: 984, column: 9, scope: !145, inlinedAt: !158)
!158 = distinct !DILocation(line: 133, column: 53, scope: !148, inlinedAt: !159)
!159 = distinct !DILocation(line: 116, column: 57, scope: !40)
!160 = !DILocation(line: 116, column: 54, scope: !40)
!161 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !162)
!162 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !163)
!163 = distinct !DILocation(line: 119, column: 3, scope: !40)
!164 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !162)
!165 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !162)
!166 = !DILocation(line: 122, column: 122, scope: !40)
!167 = !DILocation(line: 122, column: 151, scope: !40)
!168 = !DILocation(line: 122, column: 78, scope: !40)
!169 = !DILocation(line: 122, column: 157, scope: !40)
!170 = !DILocation(line: 122, column: 40, scope: !40)
!171 = !DILocation(line: 122, column: 200, scope: !40)
!172 = !DILocation(line: 122, column: 93, scope: !40)
!173 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !174)
!174 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !175)
!175 = distinct !DILocation(line: 124, column: 3, scope: !40)
!176 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !174)
!177 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !174)
!178 = !DILocation(line: 126, column: 8, scope: !40)
!179 = !DILocation(line: 126, column: 3, scope: !40)
!180 = !DILocation(line: 127, column: 253, scope: !40)
!181 = !DILocation(line: 127, column: 169, scope: !40)
!182 = !DILocation(line: 127, column: 22, scope: !40)
!183 = !DILocation(line: 127, column: 132, scope: !40)
!184 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!185 = !{i32 2, i32 -1, i32 -1, i32 -1}
!186 = !DILocation(line: 127, column: 267, scope: !40)
!187 = !DILocation(line: 129, column: 1, scope: !40)
