; ModuleID = 'experiments/20261017_resume/packed_binary/oj6_m3_p1.bc'
source_filename = "/tmp/tmpxvm_pk3m/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul6 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul6
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul10 = shl nuw nsw i32 %2, 2
  %add8 = add nuw nsw i32 %add, %mul10
  %3 = zext nneg i32 %add8 to i64, !dbg !43
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
  %mul16 = shl nsw i32 %0, 10, !dbg !46
  %add18 = add nuw nsw i32 %mul16, %1, !dbg !47
  %idxprom = zext nneg i32 %add18 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !48
  %19 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %cmp19 = icmp sgt i32 %19, -1, !dbg !49
  br i1 %cmp19, label %land.lhs.true, label %land.end, !dbg !50

land.lhs.true:                                    ; preds = %entry
  %cmp20 = icmp ult i32 %19, 32, !dbg !51
  %mul21 = shl nsw i32 %19, 5
  %cmp23 = icmp sle i32 %mul21, %1
  %spec.select = select i1 %cmp20, i1 %cmp23, i1 false, !dbg !52
  br label %land.end, !dbg !52

land.end:                                         ; preds = %land.lhs.true, %entry
  %20 = phi i1 [ false, %entry ], [ %spec.select, %land.lhs.true ], !dbg !53
  %21 = shl nuw nsw i32 %2, 3
  br i1 %20, label %for.cond24.preheader, label %land.end.if.end278_crit_edge, !dbg !54

land.end.if.end278_crit_edge:                     ; preds = %land.end
  %.pre = lshr i32 %2, 5
  %.pre994 = lshr i32 %2, 2
  %.pre997 = zext nneg i32 %0 to i64
  %.pre998 = shl nuw nsw i64 %.pre997, 18
  %.pre999 = sext i32 %19 to i64
  %.pre1000 = shl nsw i64 %.pre999, 13
  %.pre1001 = add nsw i64 %.pre1000, %.pre998
  %.pre1002 = zext nneg i32 %21 to i64
  br label %if.end278, !dbg !54

for.cond24.preheader:                             ; preds = %land.end
  %conv = zext nneg i32 %0 to i64
  %conv31 = sext i32 %19 to i64
  %mul39 = zext nneg i32 %21 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul39, !dbg !55
  %.idx607 = shl nsw i64 %conv31, 14, !dbg !56
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx607, !dbg !56
  %.idx608 = shl nuw nsw i64 %conv, 19, !dbg !56
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx608, !dbg !56
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
  %shr63 = and i32 %and, 15
  %shr66 = lshr i32 %2, 5
  %add61 = and i32 %mul10, 3972
  %xor = xor i32 %shr66, %shr63, !dbg !58
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add61, !dbg !59
  %add.ptr75.idx = shl nuw nsw i32 %xor, 4, !dbg !59
  %add.ptr75 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr75.idx, !dbg !59
  store i64 %4, ptr addrspace(3) %add.ptr75, align 8, !dbg !60
  %add67.1 = add nuw nsw i32 %shr66, 2, !dbg !61
  %xor.1 = xor i32 %add67.1, %shr63, !dbg !58
  %25 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 512, !dbg !59
  %add.ptr75.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !59
  %add.ptr75.1 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr75.idx.1, !dbg !59
  store i64 %6, ptr addrspace(3) %add.ptr75.1, align 8, !dbg !60
  %add67.2 = add nuw nsw i32 %shr66, 4, !dbg !61
  %xor.2 = xor i32 %add67.2, %shr63, !dbg !58
  %26 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1024, !dbg !59
  %add.ptr75.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !59
  %add.ptr75.2 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr75.idx.2, !dbg !59
  store i64 %8, ptr addrspace(3) %add.ptr75.2, align 8, !dbg !60
  %add67.3 = add nuw nsw i32 %shr66, 6, !dbg !61
  %xor.3 = xor i32 %add67.3, %shr63, !dbg !58
  %27 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1536, !dbg !59
  %add.ptr75.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !59
  %add.ptr75.3 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr75.idx.3, !dbg !59
  store i64 %10, ptr addrspace(3) %add.ptr75.3, align 8, !dbg !60
  %add67.4 = add nuw nsw i32 %shr66, 8, !dbg !61
  %xor.4 = xor i32 %add67.4, %shr63, !dbg !58
  %28 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2048, !dbg !59
  %add.ptr75.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !59
  %add.ptr75.4 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr75.idx.4, !dbg !59
  store i64 %12, ptr addrspace(3) %add.ptr75.4, align 8, !dbg !60
  %add67.5 = add nuw nsw i32 %shr66, 10, !dbg !61
  %xor.5 = xor i32 %add67.5, %shr63, !dbg !58
  %29 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2560, !dbg !59
  %add.ptr75.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !59
  %add.ptr75.5 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr75.idx.5, !dbg !59
  store i64 %14, ptr addrspace(3) %add.ptr75.5, align 8, !dbg !60
  %add67.6 = add nuw nsw i32 %shr66, 12, !dbg !61
  %xor.6 = xor i32 %add67.6, %shr63, !dbg !58
  %30 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3072, !dbg !59
  %add.ptr75.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !59
  %add.ptr75.6 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr75.idx.6, !dbg !59
  store i64 %16, ptr addrspace(3) %add.ptr75.6, align 8, !dbg !60
  %add67.7 = add nuw nsw i32 %shr66, 14, !dbg !61
  %xor.7 = xor i32 %add67.7, %shr63, !dbg !58
  %31 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3584, !dbg !59
  %add.ptr75.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !59
  %add.ptr75.7 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr75.idx.7, !dbg !59
  store i64 %18, ptr addrspace(3) %add.ptr75.7, align 8, !dbg !60
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !68
  fence syncscope("warp") acquire, !dbg !69
  %and85 = shl nuw nsw i32 %2, 7
  %mul86 = and i32 %and85, 1920
  %shr89 = lshr i32 %2, 4
  %and92 = and i32 %2, 15
  %32 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul86
  %xor93 = xor i32 %shr89, %and92, !dbg !70
  %add.ptr97.idx = shl nuw nsw i32 %xor93, 4, !dbg !71
  %add.ptr97 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr97.idx, !dbg !71
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97, align 16, !dbg !72
  %q.sroa.4.0.add.ptr97.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97, i32 8, !dbg !72
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr97.sroa_idx, align 8, !dbg !72
  %add90.1 = add nuw nsw i32 %shr89, 4, !dbg !73
  %xor93.1 = xor i32 %add90.1, %and92, !dbg !70
  %add.ptr97.idx.1 = shl nuw nsw i32 %xor93.1, 4, !dbg !71
  %add.ptr97.1 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr97.idx.1, !dbg !71
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.1, align 16, !dbg !72
  %q.sroa.7.16.add.ptr97.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.1, i32 8, !dbg !72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr97.1.sroa_idx, align 8, !dbg !72
  %add90.2 = add nuw nsw i32 %shr89, 8, !dbg !73
  %xor93.2 = xor i32 %add90.2, %and92, !dbg !70
  %add.ptr97.idx.2 = shl nuw nsw i32 %xor93.2, 4, !dbg !71
  %add.ptr97.2 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr97.idx.2, !dbg !71
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.2, align 16, !dbg !72
  %q.sroa.10.32.add.ptr97.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.2, i32 8, !dbg !72
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr97.2.sroa_idx, align 8, !dbg !72
  %add90.3 = add nuw nsw i32 %shr89, 12, !dbg !73
  %xor93.3 = xor i32 %add90.3, %and92, !dbg !70
  %add.ptr97.idx.3 = shl nuw nsw i32 %xor93.3, 4, !dbg !71
  %add.ptr97.3 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr97.idx.3, !dbg !71
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.3, align 16, !dbg !72
  %q.sroa.13.48.add.ptr97.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.3, i32 8, !dbg !72
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr97.3.sroa_idx, align 8, !dbg !72
  %cmp110 = icmp slt i32 %19, 32
  %33 = lshr i32 %2, 2
  br i1 %cmp110, label %for.body109.us.preheader, label %for.cond131.preheader

for.body109.us.preheader:                         ; preds = %for.cond24.preheader
  %mul112 = shl nsw i32 %19, 5
  %mul118 = and i32 %33, 252
  %add115 = add i32 %mul112, %mul118
  %cmp123.not.us = icmp sgt i32 %add115, %1, !dbg !74
  %spec.select606 = select i1 %cmp123.not.us, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.0.vec.insert883 = insertelement <4 x float> poison, float %spec.select606, i64 0, !dbg !76
  %cmp123.not.us.1.not = icmp slt i32 %add115, %1, !dbg !74
  %spec.select606.1 = select i1 %cmp123.not.us.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !75
  %scores.sroa.0.4.vec.insert896 = insertelement <4 x float> %scores.sroa.0.0.vec.insert883, float %spec.select606.1, i64 1, !dbg !76
  %add119.us.2 = or disjoint i32 %add115, 2, !dbg !77
  %cmp123.not.us.2 = icmp sgt i32 %add119.us.2, %1, !dbg !74
  %spec.select606.2 = select i1 %cmp123.not.us.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.8.vec.insert909 = insertelement <4 x float> %scores.sroa.0.4.vec.insert896, float %spec.select606.2, i64 2, !dbg !76
  %add119.us.3 = or disjoint i32 %add115, 3, !dbg !77
  %cmp123.not.us.3 = icmp sgt i32 %add119.us.3, %1, !dbg !74
  %spec.select606.3 = select i1 %cmp123.not.us.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.12.vec.insert922 = insertelement <4 x float> %scores.sroa.0.8.vec.insert909, float %spec.select606.3, i64 3, !dbg !76
  %add121.us.4 = add i32 %add115, 16, !dbg !78
  %cmp123.not.us.4 = icmp sgt i32 %add121.us.4, %1, !dbg !74
  %spec.select606.4 = select i1 %cmp123.not.us.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.50.16.vec.insert943 = insertelement <4 x float> poison, float %spec.select606.4, i64 0, !dbg !76
  %add121.us.5 = add i32 %add115, 17, !dbg !78
  %cmp123.not.us.5 = icmp sgt i32 %add121.us.5, %1, !dbg !74
  %spec.select606.5 = select i1 %cmp123.not.us.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.50.20.vec.insert956 = insertelement <4 x float> %scores.sroa.50.16.vec.insert943, float %spec.select606.5, i64 1, !dbg !76
  %add121.us.6 = add i32 %add115, 18, !dbg !78
  %cmp123.not.us.6 = icmp sgt i32 %add121.us.6, %1, !dbg !74
  %spec.select606.6 = select i1 %cmp123.not.us.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.50.24.vec.insert969 = insertelement <4 x float> %scores.sroa.50.20.vec.insert956, float %spec.select606.6, i64 2, !dbg !76
  %add121.us.7 = add i32 %add115, 19, !dbg !78
  %cmp123.not.us.7 = icmp sgt i32 %add121.us.7, %1, !dbg !74
  %spec.select606.7 = select i1 %cmp123.not.us.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.50.28.vec.insert982 = insertelement <4 x float> %scores.sroa.50.24.vec.insert969, float %spec.select606.7, i64 3, !dbg !76
  br label %for.cond131.preheader, !dbg !79

for.cond131.preheader:                            ; preds = %for.cond24.preheader, %for.body109.us.preheader
  %scores.sroa.50.0 = phi <4 x float> [ %scores.sroa.50.28.vec.insert982, %for.body109.us.preheader ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %for.cond24.preheader ], !dbg !76
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert922, %for.body109.us.preheader ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %for.cond24.preheader ], !dbg !76
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.0), !dbg !80, !call_argsrelate !81
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.50.0), !dbg !80, !call_argsrelate !81
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %34), !dbg !80, !call_argsrelate !81
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %35), !dbg !80, !call_argsrelate !81
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %36), !dbg !80, !call_argsrelate !81
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %37), !dbg !80, !call_argsrelate !81
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %38), !dbg !80, !call_argsrelate !81
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %39), !dbg !80, !call_argsrelate !81
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %40), !dbg !80, !call_argsrelate !81
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %41), !dbg !80, !call_argsrelate !81
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %42), !dbg !80, !call_argsrelate !81
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %43), !dbg !80, !call_argsrelate !81
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %44), !dbg !80, !call_argsrelate !81
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %45), !dbg !80, !call_argsrelate !81
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %46), !dbg !80, !call_argsrelate !81
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %47), !dbg !80, !call_argsrelate !81
  %mul177 = shl nuw nsw i64 %conv, 18
  %mul179 = shl nsw i64 %conv31, 13
  %add180 = add nsw i64 %mul179, %mul177
  %invariant.gep578 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192, !dbg !82
  %gep579 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep578, i64 %add180, !dbg !83
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %gep579, align 16, !dbg !84
  %v.sroa.7.0.gep579.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep579, i64 8, !dbg !84
  %v.sroa.7.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.0.gep579.sroa_idx, align 8, !dbg !84
  %add188.1 = or disjoint i64 %add180, 512, !dbg !85
  %gep579.1 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep578, i64 %add188.1, !dbg !83
  %v.sroa.9.16.copyload = load <4 x half>, ptr addrspace(4) %gep579.1, align 16, !dbg !84
  %v.sroa.14.16.gep579.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep579.1, i64 8, !dbg !84
  %v.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.14.16.gep579.1.sroa_idx, align 8, !dbg !84
  %add184.2 = or disjoint i64 %add180, 2048, !dbg !86
  %gep579.2 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep578, i64 %add184.2, !dbg !83
  %v.sroa.16.32.copyload = load <4 x half>, ptr addrspace(4) %gep579.2, align 16, !dbg !84
  %v.sroa.21.32.gep579.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep579.2, i64 8, !dbg !84
  %v.sroa.21.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.21.32.gep579.2.sroa_idx, align 8, !dbg !84
  %add188.3 = or disjoint i64 %add180, 2560, !dbg !85
  %gep579.3 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep578, i64 %add188.3, !dbg !83
  %v.sroa.23.48.copyload = load <4 x half>, ptr addrspace(4) %gep579.3, align 16, !dbg !84
  %v.sroa.28.48.gep579.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep579.3, i64 8, !dbg !84
  %v.sroa.28.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.28.48.gep579.3.sroa_idx, align 8, !dbg !84
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %48, i64 0, !dbg !87
  %mul208 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !88
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul208, float 1.500000e+01), !dbg !89
  %cmp.i.i = fcmp contract olt float %50, -1.260000e+02, !dbg !93
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561 = fadd contract float %50, %cond.i.i, !dbg !93
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i561), !dbg !93
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i = fmul contract float %cond2.i.i, %51, !dbg !93
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %48, i64 1, !dbg !87
  %mul208.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !88
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1, float 1.500000e+01), !dbg !89
  %cmp.i.i.1 = fcmp contract olt float %52, -1.260000e+02, !dbg !93
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561.1 = fadd contract float %52, %cond.i.i.1, !dbg !93
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i561.1), !dbg !93
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %53, !dbg !93
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %48, i64 2, !dbg !87
  %mul208.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !88
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2, float 1.500000e+01), !dbg !89
  %cmp.i.i.2 = fcmp contract olt float %54, -1.260000e+02, !dbg !93
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561.2 = fadd contract float %54, %cond.i.i.2, !dbg !93
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i561.2), !dbg !93
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %55, !dbg !93
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %48, i64 3, !dbg !87
  %mul208.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !88
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3, float 1.500000e+01), !dbg !89
  %cmp.i.i.3 = fcmp contract olt float %56, -1.260000e+02, !dbg !93
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561.3 = fadd contract float %56, %cond.i.i.3, !dbg !93
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i561.3), !dbg !93
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %57, !dbg !93
  %scores.sroa.50.16.vec.extract = extractelement <4 x float> %49, i64 0, !dbg !87
  %mul208.4 = fmul contract float %scores.sroa.50.16.vec.extract, 0x3FC2776C60000000, !dbg !88
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul208.4, float 1.500000e+01), !dbg !89
  %cmp.i.i.4 = fcmp contract olt float %58, -1.260000e+02, !dbg !93
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561.4 = fadd contract float %58, %cond.i.i.4, !dbg !93
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i561.4), !dbg !93
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %59, !dbg !93
  %scores.sroa.50.20.vec.extract = extractelement <4 x float> %49, i64 1, !dbg !87
  %mul208.5 = fmul contract float %scores.sroa.50.20.vec.extract, 0x3FC2776C60000000, !dbg !88
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul208.5, float 1.500000e+01), !dbg !89
  %cmp.i.i.5 = fcmp contract olt float %60, -1.260000e+02, !dbg !93
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561.5 = fadd contract float %60, %cond.i.i.5, !dbg !93
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i561.5), !dbg !93
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %61, !dbg !93
  %scores.sroa.50.24.vec.extract = extractelement <4 x float> %49, i64 2, !dbg !87
  %mul208.6 = fmul contract float %scores.sroa.50.24.vec.extract, 0x3FC2776C60000000, !dbg !88
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul208.6, float 1.500000e+01), !dbg !89
  %cmp.i.i.6 = fcmp contract olt float %62, -1.260000e+02, !dbg !93
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561.6 = fadd contract float %62, %cond.i.i.6, !dbg !93
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i561.6), !dbg !93
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %63, !dbg !93
  %scores.sroa.50.28.vec.extract = extractelement <4 x float> %49, i64 3, !dbg !87
  %mul208.7 = fmul contract float %scores.sroa.50.28.vec.extract, 0x3FC2776C60000000, !dbg !88
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul208.7, float 1.500000e+01), !dbg !89
  %cmp.i.i.7 = fcmp contract olt float %64, -1.260000e+02, !dbg !93
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i561.7 = fadd contract float %64, %cond.i.i.7, !dbg !93
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i561.7), !dbg !93
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %65, !dbg !93
  %add228 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !96
  %add228.1 = fadd contract float %add228, %mul.i.i.4, !dbg !96
  %add228.2 = fadd contract float %add228.1, %mul.i.i.1, !dbg !96
  %add228.3 = fadd contract float %add228.2, %mul.i.i.5, !dbg !96
  %add228.4 = fadd contract float %add228.3, %mul.i.i.2, !dbg !96
  %add228.5 = fadd contract float %add228.4, %mul.i.i.6, !dbg !96
  %add228.6 = fadd contract float %add228.5, %mul.i.i.3, !dbg !96
  %add228.7 = fadd contract float %add228.6, %mul.i.i.7, !dbg !96
  %66 = bitcast float %add228.7 to i32, !dbg !97
  %67 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !108
  %68 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %67) #11, !dbg !113
  %xor.i.i = xor i32 %68, 32, !dbg !114
  %69 = and i32 %68, -64, !dbg !115
  %and.i.i = add nsw i32 %69, 64, !dbg !115
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !116
  %cond.i.i562 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %68, !dbg !117
  %shl.i.i = shl i32 %cond.i.i562, 2, !dbg !118
  %70 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %66), !dbg !119
  %71 = bitcast i32 %70 to float, !dbg !120
  %add.i = fadd contract float %add228.7, %71, !dbg !121
  %72 = bitcast float %add.i to i32, !dbg !124
  %73 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !131
  %74 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %73) #11, !dbg !134
  %xor.i.i563 = xor i32 %74, 16, !dbg !135
  %75 = and i32 %74, -64, !dbg !136
  %and.i.i564 = add nsw i32 %75, 64, !dbg !136
  %cmp.not.i.i565 = icmp slt i32 %xor.i.i563, %and.i.i564, !dbg !137
  %cond.i.i566 = select i1 %cmp.not.i.i565, i32 %xor.i.i563, i32 %74, !dbg !138
  %shl.i.i567 = shl i32 %cond.i.i566, 2, !dbg !139
  %76 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i567, i32 %72), !dbg !140
  %77 = bitcast i32 %76 to float, !dbg !141
  %add.i.i = fadd contract float %add.i, %77, !dbg !142
  %cmp237 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !144
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !145
  %condval_1.0 = select i1 %cmp237, float %div, float 0.000000e+00, !dbg !145
  %mul250 = fmul contract float %condval_1.0, %mul.i.i, !dbg !146
  %mul250.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !146
  %mul250.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !146
  %mul250.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !146
  %mul250.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !146
  %mul250.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !146
  %mul250.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !146
  %mul250.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !146
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250), !dbg !147
  %79 = insertelement <4 x i16> poison, i16 %78, i64 0, !dbg !156
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250.1), !dbg !147
  %81 = insertelement <4 x i16> %79, i16 %80, i64 1, !dbg !156
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250.2), !dbg !147
  %83 = insertelement <4 x i16> %81, i16 %82, i64 2, !dbg !156
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250.3), !dbg !147
  %85 = insertelement <4 x i16> %83, i16 %84, i64 3, !dbg !156
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %85 to <4 x half>, !dbg !156
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250.4), !dbg !147
  %87 = insertelement <4 x i16> poison, i16 %86, i64 0, !dbg !156
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250.5), !dbg !147
  %89 = insertelement <4 x i16> %87, i16 %88, i64 1, !dbg !156
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250.6), !dbg !147
  %91 = insertelement <4 x i16> %89, i16 %90, i64 2, !dbg !156
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul250.7), !dbg !147
  %93 = insertelement <4 x i16> %91, i16 %92, i64 3, !dbg !156
  %prob.sroa.8.14.vec.insert = bitcast <4 x i16> %93 to <4 x half>, !dbg !156
  br label %if.end278, !dbg !157

if.end278:                                        ; preds = %land.end.if.end278_crit_edge, %for.cond131.preheader
  %mul323.pre-phi = phi i64 [ %.pre1002, %land.end.if.end278_crit_edge ], [ %mul39, %for.cond131.preheader ]
  %add309.pre-phi = phi i64 [ %.pre1001, %land.end.if.end278_crit_edge ], [ %add180, %for.cond131.preheader ]
  %.pre-phi = phi i32 [ %.pre994, %land.end.if.end278_crit_edge ], [ %33, %for.cond131.preheader ]
  %shr400.pre-phi = phi i32 [ %.pre, %land.end.if.end278_crit_edge ], [ %shr66, %for.cond131.preheader ]
  %v.sroa.28.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.28.48.copyload, %for.cond131.preheader ]
  %v.sroa.23.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.23.48.copyload, %for.cond131.preheader ]
  %v.sroa.21.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.21.32.copyload, %for.cond131.preheader ]
  %v.sroa.16.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.16.32.copyload, %for.cond131.preheader ]
  %v.sroa.14.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.14.16.copyload, %for.cond131.preheader ]
  %v.sroa.9.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.9.16.copyload, %for.cond131.preheader ]
  %v.sroa.7.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.7.0.copyload, %for.cond131.preheader ]
  %v.sroa.0.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %v.sroa.0.0.copyload, %for.cond131.preheader ]
  %prob.sroa.8.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %prob.sroa.8.14.vec.insert, %for.cond131.preheader ]
  %prob.sroa.0.0 = phi <4 x half> [ undef, %land.end.if.end278_crit_edge ], [ %prob.sroa.0.6.vec.insert, %for.cond131.preheader ]
  %invariant.gep603 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !157
  %and396 = shl nuw nsw i32 %2, 6
  %mul397 = and i32 %and396, 960
  %and403 = and i32 %2, 7
  %mul410 = and i32 %.pre-phi, 4
  %mul424 = and i32 %21, 8128
  %xor430551 = and i32 %21, 56
  %call428.masked = and i32 %2, 1016
  %mul431 = xor i32 %xor430551, %call428.masked
  %invariant.gep598 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul424
  %invariant.gep600 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep598, i32 %mul431
  %94 = shl nuw nsw i32 %2, 4
  %mul444 = and i32 %94, 16256
  %add441 = add nuw nsw i32 %add, %mul444
  %add445 = or disjoint i32 %add441, %xor430551
  %gep604 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep603, i64 %mul323.pre-phi
  %95 = zext nneg i32 %add445 to i64, !dbg !158
  br i1 %20, label %if.end334, label %if.end363, !dbg !159

if.end334:                                        ; preds = %if.end278
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.9.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.0, <4 x half> %prob.sroa.8.0, <4 x float> %96), !dbg !160
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.21.0, <4 x half> %prob.sroa.8.0, <4 x float> %97), !dbg !160
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.0, <4 x half> %prob.sroa.8.0, <4 x float> %98), !dbg !160
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.28.0, <4 x half> %prob.sroa.8.0, <4 x float> %99), !dbg !160
  br label %if.end363, !dbg !161

if.end363:                                        ; preds = %if.end334, %if.end278
  %out.sroa.74.0 = phi <4 x float> [ %103, %if.end334 ], [ zeroinitializer, %if.end278 ], !dbg !53
  %out.sroa.50.0 = phi <4 x float> [ %102, %if.end334 ], [ zeroinitializer, %if.end278 ], !dbg !53
  %out.sroa.26.0 = phi <4 x float> [ %101, %if.end334 ], [ zeroinitializer, %if.end278 ], !dbg !53
  %out.sroa.0.0 = phi <4 x float> [ %100, %if.end334 ], [ zeroinitializer, %if.end278 ], !dbg !53
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0, !dbg !162
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !163
  %output_reg.sroa.0.0.insert.ext = zext i16 %104 to i64, !dbg !167
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1, !dbg !162
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !163
  %output_reg.sroa.0.2.insert.ext = zext i16 %105 to i64, !dbg !167
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !167
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !167
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2, !dbg !162
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !163
  %output_reg.sroa.0.4.insert.ext = zext i16 %106 to i64, !dbg !167
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !167
  %output_reg.sroa.0.4.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !167
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3, !dbg !162
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !163
  %output_reg.sroa.0.6.insert.ext = zext i16 %107 to i64, !dbg !167
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !167
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert, %output_reg.sroa.0.6.insert.shift, !dbg !167
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 0, !dbg !162
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract), !dbg !163
  %output_reg.sroa.12.8.insert.ext = zext i16 %108 to i64, !dbg !167
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 1, !dbg !162
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract), !dbg !163
  %output_reg.sroa.12.10.insert.ext = zext i16 %109 to i64, !dbg !167
  %output_reg.sroa.12.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.10.insert.ext, 16, !dbg !167
  %output_reg.sroa.12.10.insert.insert = or disjoint i64 %output_reg.sroa.12.10.insert.shift, %output_reg.sroa.12.8.insert.ext, !dbg !167
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 2, !dbg !162
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract), !dbg !163
  %output_reg.sroa.12.12.insert.ext = zext i16 %110 to i64, !dbg !167
  %output_reg.sroa.12.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.12.insert.ext, 32, !dbg !167
  %output_reg.sroa.12.12.insert.insert = or disjoint i64 %output_reg.sroa.12.10.insert.insert, %output_reg.sroa.12.12.insert.shift, !dbg !167
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 3, !dbg !162
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract), !dbg !163
  %output_reg.sroa.12.14.insert.ext = zext i16 %111 to i64, !dbg !167
  %output_reg.sroa.12.14.insert.shift = shl nuw i64 %output_reg.sroa.12.14.insert.ext, 48, !dbg !167
  %output_reg.sroa.12.14.insert.insert = or disjoint i64 %output_reg.sroa.12.12.insert.insert, %output_reg.sroa.12.14.insert.shift, !dbg !167
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 0, !dbg !162
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract), !dbg !163
  %output_reg.sroa.22.16.insert.ext = zext i16 %112 to i64, !dbg !167
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 1, !dbg !162
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract), !dbg !163
  %output_reg.sroa.22.18.insert.ext = zext i16 %113 to i64, !dbg !167
  %output_reg.sroa.22.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.18.insert.ext, 16, !dbg !167
  %output_reg.sroa.22.18.insert.insert = or disjoint i64 %output_reg.sroa.22.18.insert.shift, %output_reg.sroa.22.16.insert.ext, !dbg !167
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 2, !dbg !162
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract), !dbg !163
  %output_reg.sroa.22.20.insert.ext = zext i16 %114 to i64, !dbg !167
  %output_reg.sroa.22.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.20.insert.ext, 32, !dbg !167
  %output_reg.sroa.22.20.insert.insert = or disjoint i64 %output_reg.sroa.22.18.insert.insert, %output_reg.sroa.22.20.insert.shift, !dbg !167
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 3, !dbg !162
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract), !dbg !163
  %output_reg.sroa.22.22.insert.ext = zext i16 %115 to i64, !dbg !167
  %output_reg.sroa.22.22.insert.shift = shl nuw i64 %output_reg.sroa.22.22.insert.ext, 48, !dbg !167
  %output_reg.sroa.22.22.insert.insert = or disjoint i64 %output_reg.sroa.22.20.insert.insert, %output_reg.sroa.22.22.insert.shift, !dbg !167
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 0, !dbg !162
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract), !dbg !163
  %output_reg.sroa.32.24.insert.ext = zext i16 %116 to i64, !dbg !167
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 1, !dbg !162
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract), !dbg !163
  %output_reg.sroa.32.26.insert.ext = zext i16 %117 to i64, !dbg !167
  %output_reg.sroa.32.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.26.insert.ext, 16, !dbg !167
  %output_reg.sroa.32.26.insert.insert = or disjoint i64 %output_reg.sroa.32.26.insert.shift, %output_reg.sroa.32.24.insert.ext, !dbg !167
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 2, !dbg !162
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract), !dbg !163
  %output_reg.sroa.32.28.insert.ext = zext i16 %118 to i64, !dbg !167
  %output_reg.sroa.32.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.28.insert.ext, 32, !dbg !167
  %output_reg.sroa.32.28.insert.insert = or disjoint i64 %output_reg.sroa.32.26.insert.insert, %output_reg.sroa.32.28.insert.shift, !dbg !167
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 3, !dbg !162
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract), !dbg !163
  %output_reg.sroa.32.30.insert.ext = zext i16 %119 to i64, !dbg !167
  %output_reg.sroa.32.30.insert.shift = shl nuw i64 %output_reg.sroa.32.30.insert.ext, 48, !dbg !167
  %output_reg.sroa.32.30.insert.insert = or disjoint i64 %output_reg.sroa.32.28.insert.insert, %output_reg.sroa.32.30.insert.shift, !dbg !167
  fence syncscope("warp") release, !dbg !168
  tail call void @llvm.mxc.barrier.warp(), !dbg !171
  fence syncscope("warp") acquire, !dbg !172
  %xor404 = xor i32 %shr400.pre-phi, %and403, !dbg !173
  %mul405 = shl nuw nsw i32 %xor404, 3, !dbg !174
  %add406 = add nuw nsw i32 %mul405, %mul397, !dbg !175
  %add411 = or disjoint i32 %add406, %mul410, !dbg !176
  %add.ptr413 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411, !dbg !177
  store i64 %output_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr413, align 8, !dbg !178
  %add401.1 = add nuw nsw i32 %shr400.pre-phi, 2, !dbg !179
  %xor404.1 = xor i32 %add401.1, %and403, !dbg !173
  %mul405.1 = shl nuw nsw i32 %xor404.1, 3, !dbg !174
  %add406.1 = add nuw nsw i32 %mul405.1, %mul397, !dbg !175
  %add411.1 = or disjoint i32 %add406.1, %mul410, !dbg !176
  %add.ptr413.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1, !dbg !177
  store i64 %output_reg.sroa.12.14.insert.insert, ptr addrspace(3) %add.ptr413.1, align 8, !dbg !178
  %add401.2 = add nuw nsw i32 %shr400.pre-phi, 4, !dbg !179
  %xor404.2 = xor i32 %add401.2, %and403, !dbg !173
  %mul405.2 = shl nuw nsw i32 %xor404.2, 3, !dbg !174
  %add406.2 = add nuw nsw i32 %mul405.2, %mul397, !dbg !175
  %add411.2 = or disjoint i32 %add406.2, %mul410, !dbg !176
  %add.ptr413.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2, !dbg !177
  store i64 %output_reg.sroa.22.22.insert.insert, ptr addrspace(3) %add.ptr413.2, align 8, !dbg !178
  %add401.3 = add nuw nsw i32 %shr400.pre-phi, 6, !dbg !179
  %xor404.3 = xor i32 %add401.3, %and403, !dbg !173
  %mul405.3 = shl nuw nsw i32 %xor404.3, 3, !dbg !174
  %add406.3 = add nuw nsw i32 %mul405.3, %mul397, !dbg !175
  %add411.3 = or disjoint i32 %add406.3, %mul410, !dbg !176
  %add.ptr413.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3, !dbg !177
  store i64 %output_reg.sroa.32.30.insert.insert, ptr addrspace(3) %add.ptr413.3, align 8, !dbg !178
  fence syncscope("warp") release, !dbg !180
  tail call void @llvm.mxc.barrier.warp(), !dbg !183
  fence syncscope("warp") acquire, !dbg !184
  %add.ptr453 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr453, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep600, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
  %gep601.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 1024, !dbg !189
  %120 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !185
  %add.ptr453.1 = getelementptr inbounds i8, ptr addrspace(1) %120, i64 2048, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr453.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep601.1, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
  br i1 %20, label %if.end334.1, label %if.end363.1, !dbg !159

if.end334.1:                                      ; preds = %if.end363
  %add313.3.1 = add nuw nsw i64 %add309.pre-phi, 3072, !dbg !190
  %add316.3.1 = or i64 %add313.3.1, 1536, !dbg !191
  %gep591.3.1 = getelementptr %struct.__half, ptr addrspace(4) %gep604, i64 %add316.3.1, !dbg !192
  %v.sroa.28.48.gep591.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep591.3.1, i64 8, !dbg !193
  %v.sroa.28.48.copyload872 = load <4 x half>, ptr addrspace(4) %v.sroa.28.48.gep591.3.1.sroa_idx, align 8, !dbg !193
  %v.sroa.23.48.copyload870 = load <4 x half>, ptr addrspace(4) %gep591.3.1, align 16, !dbg !193
  %121 = or i64 %add309.pre-phi, 1024, !dbg !191
  %122 = getelementptr %struct.__half, ptr addrspace(4) %gep604, i64 %121, !dbg !192
  %v.sroa.21.32.gep591.2.1.sroa_idx = getelementptr i8, ptr addrspace(4) %122, i64 4104, !dbg !193
  %v.sroa.21.32.copyload866 = load <4 x half>, ptr addrspace(4) %v.sroa.21.32.gep591.2.1.sroa_idx, align 8, !dbg !193
  %gep591.2.1 = getelementptr i8, ptr addrspace(4) %122, i64 4096, !dbg !192
  %v.sroa.16.32.copyload864 = load <4 x half>, ptr addrspace(4) %gep591.2.1, align 16, !dbg !193
  %123 = or i64 %add309.pre-phi, 512, !dbg !191
  %add316.1.1 = add nuw nsw i64 %123, 1024, !dbg !191
  %add320.1.1 = or i64 %add316.1.1, 1024, !dbg !191
  %gep591.1.1 = getelementptr %struct.__half, ptr addrspace(4) %gep604, i64 %add320.1.1, !dbg !192
  %v.sroa.14.16.gep591.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep591.1.1, i64 8, !dbg !193
  %v.sroa.14.16.copyload860 = load <4 x half>, ptr addrspace(4) %v.sroa.14.16.gep591.1.1.sroa_idx, align 8, !dbg !193
  %v.sroa.9.16.copyload858 = load <4 x half>, ptr addrspace(4) %gep591.1.1, align 16, !dbg !193
  %add320.1651 = or i64 %add309.pre-phi, 1024, !dbg !191
  %gep591.1652 = getelementptr %struct.__half, ptr addrspace(4) %gep604, i64 %add320.1651, !dbg !192
  %v.sroa.7.0.gep591.1652.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep591.1652, i64 8, !dbg !193
  %v.sroa.7.0.copyload854 = load <4 x half>, ptr addrspace(4) %v.sroa.7.0.gep591.1652.sroa_idx, align 8, !dbg !193
  %v.sroa.0.0.copyload852 = load <4 x half>, ptr addrspace(4) %gep591.1652, align 16, !dbg !193
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload852, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !81
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0.copyload854, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !81
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.9.16.copyload858, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !81
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.16.copyload860, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !81
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.32.copyload864, <4 x half> %prob.sroa.8.0, <4 x float> %124), !dbg !160, !call_argsrelate !81
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.21.32.copyload866, <4 x half> %prob.sroa.8.0, <4 x float> %125), !dbg !160, !call_argsrelate !81
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.48.copyload870, <4 x half> %prob.sroa.8.0, <4 x float> %126), !dbg !160, !call_argsrelate !81
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.28.48.copyload872, <4 x half> %prob.sroa.8.0, <4 x float> %127), !dbg !160, !call_argsrelate !81
  br label %if.end363.1, !dbg !161

if.end363.1:                                      ; preds = %if.end334.1, %if.end363
  %out.sroa.74.1 = phi <4 x float> [ %131, %if.end334.1 ], [ zeroinitializer, %if.end363 ], !dbg !53
  %out.sroa.50.1 = phi <4 x float> [ %130, %if.end334.1 ], [ zeroinitializer, %if.end363 ], !dbg !53
  %out.sroa.26.1 = phi <4 x float> [ %129, %if.end334.1 ], [ zeroinitializer, %if.end363 ], !dbg !53
  %out.sroa.0.1 = phi <4 x float> [ %128, %if.end334.1 ], [ zeroinitializer, %if.end363 ], !dbg !53
  %out.sroa.0.0.vec.extract758 = extractelement <4 x float> %out.sroa.0.1, i64 0, !dbg !162
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract758), !dbg !163
  %output_reg.sroa.0.0.insert.ext672 = zext i16 %132 to i64, !dbg !167
  %out.sroa.0.4.vec.extract763 = extractelement <4 x float> %out.sroa.0.1, i64 1, !dbg !162
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract763), !dbg !163
  %output_reg.sroa.0.2.insert.ext676 = zext i16 %133 to i64, !dbg !167
  %output_reg.sroa.0.2.insert.shift677 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext676, 16, !dbg !167
  %output_reg.sroa.0.2.insert.insert679 = or disjoint i64 %output_reg.sroa.0.2.insert.shift677, %output_reg.sroa.0.0.insert.ext672, !dbg !167
  %out.sroa.0.8.vec.extract768 = extractelement <4 x float> %out.sroa.0.1, i64 2, !dbg !162
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract768), !dbg !163
  %output_reg.sroa.0.4.insert.ext681 = zext i16 %134 to i64, !dbg !167
  %output_reg.sroa.0.4.insert.shift682 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext681, 32, !dbg !167
  %output_reg.sroa.0.4.insert.insert684 = or disjoint i64 %output_reg.sroa.0.2.insert.insert679, %output_reg.sroa.0.4.insert.shift682, !dbg !167
  %out.sroa.0.12.vec.extract773 = extractelement <4 x float> %out.sroa.0.1, i64 3, !dbg !162
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract773), !dbg !163
  %output_reg.sroa.0.6.insert.ext686 = zext i16 %135 to i64, !dbg !167
  %output_reg.sroa.0.6.insert.shift687 = shl nuw i64 %output_reg.sroa.0.6.insert.ext686, 48, !dbg !167
  %output_reg.sroa.0.6.insert.insert689 = or disjoint i64 %output_reg.sroa.0.4.insert.insert684, %output_reg.sroa.0.6.insert.shift687, !dbg !167
  %out.sroa.26.16.vec.extract782 = extractelement <4 x float> %out.sroa.26.1, i64 0, !dbg !162
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract782), !dbg !163
  %output_reg.sroa.12.8.insert.ext692 = zext i16 %136 to i64, !dbg !167
  %out.sroa.26.20.vec.extract787 = extractelement <4 x float> %out.sroa.26.1, i64 1, !dbg !162
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract787), !dbg !163
  %output_reg.sroa.12.10.insert.ext696 = zext i16 %137 to i64, !dbg !167
  %output_reg.sroa.12.10.insert.shift697 = shl nuw nsw i64 %output_reg.sroa.12.10.insert.ext696, 16, !dbg !167
  %output_reg.sroa.12.10.insert.insert699 = or disjoint i64 %output_reg.sroa.12.10.insert.shift697, %output_reg.sroa.12.8.insert.ext692, !dbg !167
  %out.sroa.26.24.vec.extract792 = extractelement <4 x float> %out.sroa.26.1, i64 2, !dbg !162
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract792), !dbg !163
  %output_reg.sroa.12.12.insert.ext701 = zext i16 %138 to i64, !dbg !167
  %output_reg.sroa.12.12.insert.shift702 = shl nuw nsw i64 %output_reg.sroa.12.12.insert.ext701, 32, !dbg !167
  %output_reg.sroa.12.12.insert.insert704 = or disjoint i64 %output_reg.sroa.12.10.insert.insert699, %output_reg.sroa.12.12.insert.shift702, !dbg !167
  %out.sroa.26.28.vec.extract797 = extractelement <4 x float> %out.sroa.26.1, i64 3, !dbg !162
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract797), !dbg !163
  %output_reg.sroa.12.14.insert.ext706 = zext i16 %139 to i64, !dbg !167
  %output_reg.sroa.12.14.insert.shift707 = shl nuw i64 %output_reg.sroa.12.14.insert.ext706, 48, !dbg !167
  %output_reg.sroa.12.14.insert.insert709 = or disjoint i64 %output_reg.sroa.12.12.insert.insert704, %output_reg.sroa.12.14.insert.shift707, !dbg !167
  %out.sroa.50.32.vec.extract806 = extractelement <4 x float> %out.sroa.50.1, i64 0, !dbg !162
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract806), !dbg !163
  %output_reg.sroa.22.16.insert.ext712 = zext i16 %140 to i64, !dbg !167
  %out.sroa.50.36.vec.extract811 = extractelement <4 x float> %out.sroa.50.1, i64 1, !dbg !162
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract811), !dbg !163
  %output_reg.sroa.22.18.insert.ext716 = zext i16 %141 to i64, !dbg !167
  %output_reg.sroa.22.18.insert.shift717 = shl nuw nsw i64 %output_reg.sroa.22.18.insert.ext716, 16, !dbg !167
  %output_reg.sroa.22.18.insert.insert719 = or disjoint i64 %output_reg.sroa.22.18.insert.shift717, %output_reg.sroa.22.16.insert.ext712, !dbg !167
  %out.sroa.50.40.vec.extract816 = extractelement <4 x float> %out.sroa.50.1, i64 2, !dbg !162
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract816), !dbg !163
  %output_reg.sroa.22.20.insert.ext721 = zext i16 %142 to i64, !dbg !167
  %output_reg.sroa.22.20.insert.shift722 = shl nuw nsw i64 %output_reg.sroa.22.20.insert.ext721, 32, !dbg !167
  %output_reg.sroa.22.20.insert.insert724 = or disjoint i64 %output_reg.sroa.22.18.insert.insert719, %output_reg.sroa.22.20.insert.shift722, !dbg !167
  %out.sroa.50.44.vec.extract821 = extractelement <4 x float> %out.sroa.50.1, i64 3, !dbg !162
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract821), !dbg !163
  %output_reg.sroa.22.22.insert.ext726 = zext i16 %143 to i64, !dbg !167
  %output_reg.sroa.22.22.insert.shift727 = shl nuw i64 %output_reg.sroa.22.22.insert.ext726, 48, !dbg !167
  %output_reg.sroa.22.22.insert.insert729 = or disjoint i64 %output_reg.sroa.22.20.insert.insert724, %output_reg.sroa.22.22.insert.shift727, !dbg !167
  %out.sroa.74.48.vec.extract830 = extractelement <4 x float> %out.sroa.74.1, i64 0, !dbg !162
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract830), !dbg !163
  %output_reg.sroa.32.24.insert.ext732 = zext i16 %144 to i64, !dbg !167
  %out.sroa.74.52.vec.extract835 = extractelement <4 x float> %out.sroa.74.1, i64 1, !dbg !162
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract835), !dbg !163
  %output_reg.sroa.32.26.insert.ext736 = zext i16 %145 to i64, !dbg !167
  %output_reg.sroa.32.26.insert.shift737 = shl nuw nsw i64 %output_reg.sroa.32.26.insert.ext736, 16, !dbg !167
  %output_reg.sroa.32.26.insert.insert739 = or disjoint i64 %output_reg.sroa.32.26.insert.shift737, %output_reg.sroa.32.24.insert.ext732, !dbg !167
  %out.sroa.74.56.vec.extract840 = extractelement <4 x float> %out.sroa.74.1, i64 2, !dbg !162
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract840), !dbg !163
  %output_reg.sroa.32.28.insert.ext741 = zext i16 %146 to i64, !dbg !167
  %output_reg.sroa.32.28.insert.shift742 = shl nuw nsw i64 %output_reg.sroa.32.28.insert.ext741, 32, !dbg !167
  %output_reg.sroa.32.28.insert.insert744 = or disjoint i64 %output_reg.sroa.32.26.insert.insert739, %output_reg.sroa.32.28.insert.shift742, !dbg !167
  %out.sroa.74.60.vec.extract845 = extractelement <4 x float> %out.sroa.74.1, i64 3, !dbg !162
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract845), !dbg !163
  %output_reg.sroa.32.30.insert.ext746 = zext i16 %147 to i64, !dbg !167
  %output_reg.sroa.32.30.insert.shift747 = shl nuw i64 %output_reg.sroa.32.30.insert.ext746, 48, !dbg !167
  %output_reg.sroa.32.30.insert.insert749 = or disjoint i64 %output_reg.sroa.32.28.insert.insert744, %output_reg.sroa.32.30.insert.shift747, !dbg !167
  fence syncscope("warp") release, !dbg !168
  tail call void @llvm.mxc.barrier.warp(), !dbg !171
  fence syncscope("warp") acquire, !dbg !172
  store i64 %output_reg.sroa.0.6.insert.insert689, ptr addrspace(3) %add.ptr413, align 8, !dbg !178
  store i64 %output_reg.sroa.12.14.insert.insert709, ptr addrspace(3) %add.ptr413.1, align 8, !dbg !178
  store i64 %output_reg.sroa.22.22.insert.insert729, ptr addrspace(3) %add.ptr413.2, align 8, !dbg !178
  store i64 %output_reg.sroa.32.30.insert.insert749, ptr addrspace(3) %add.ptr413.3, align 8, !dbg !178
  fence syncscope("warp") release, !dbg !180
  tail call void @llvm.mxc.barrier.warp(), !dbg !183
  fence syncscope("warp") acquire, !dbg !184
  %148 = or disjoint i64 %95, 64
  %add.ptr453.1669 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %148, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr453.1669, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep600, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
  %149 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !185
  %add.ptr453.1.1 = getelementptr inbounds i8, ptr addrspace(1) %149, i64 2176, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr453.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep601.1, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
  ret void, !dbg !194
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
!1 = !DIFile(filename: "/tmp/tmpxvm_pk3m/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpxvm_pk3m/tvm_kernels.maca", directory: "")
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
!56 = !DILocation(line: 31, column: 53, scope: !40)
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
!74 = !DILocation(line: 45, column: 114, scope: !40)
!75 = !DILocation(line: 45, column: 11, scope: !40)
!76 = !DILocation(line: 50, column: 19, scope: !40)
!77 = !DILocation(line: 45, column: 66, scope: !40)
!78 = !DILocation(line: 45, column: 101, scope: !40)
!79 = !DILocation(line: 52, column: 5, scope: !40)
!80 = !DILocation(line: 56, column: 37, scope: !40)
!81 = !{i32 2, i32 -1, i32 -1}
!82 = !DILocation(line: 64, column: 5, scope: !40)
!83 = !DILocation(line: 65, column: 53, scope: !40)
!84 = !DILocation(line: 65, column: 32, scope: !40)
!85 = !DILocation(line: 65, column: 199, scope: !40)
!86 = !DILocation(line: 65, column: 147, scope: !40)
!87 = !DILocation(line: 69, column: 32, scope: !40)
!88 = !DILocation(line: 69, column: 44, scope: !40)
!89 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "min", scope: !91, file: !91, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!92 = distinct !DILocation(line: 69, column: 27, scope: !40)
!93 = !DILocation(line: 285, column: 49, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "exp2f", scope: !91, file: !91, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 69, column: 21, scope: !40)
!96 = !DILocation(line: 74, column: 28, scope: !40)
!97 = !DILocation(line: 1018, column: 9, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 396, column: 10, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !101, file: !101, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!102 = distinct !DILocation(line: 129, column: 24, scope: !103, inlinedAt: !105)
!103 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !104, file: !104, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!105 = distinct !DILocation(line: 101, column: 14, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "run<float>", scope: !104, file: !104, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = distinct !DILocation(line: 76, column: 16, scope: !40)
!108 = !DILocation(line: 171, column: 37, scope: !109, inlinedAt: !110)
!109 = distinct !DISubprogram(name: "__lane_id", scope: !64, file: !64, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!110 = distinct !DILocation(line: 990, column: 14, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = distinct !DILocation(line: 1019, column: 11, scope: !98, inlinedAt: !99)
!113 = !DILocation(line: 171, column: 10, scope: !109, inlinedAt: !110)
!114 = !DILocation(line: 991, column: 20, scope: !111, inlinedAt: !112)
!115 = !DILocation(line: 992, column: 36, scope: !111, inlinedAt: !112)
!116 = !DILocation(line: 992, column: 17, scope: !111, inlinedAt: !112)
!117 = !DILocation(line: 992, column: 11, scope: !111, inlinedAt: !112)
!118 = !DILocation(line: 993, column: 43, scope: !111, inlinedAt: !112)
!119 = !DILocation(line: 993, column: 10, scope: !111, inlinedAt: !112)
!120 = !DILocation(line: 1020, column: 14, scope: !98, inlinedAt: !99)
!121 = !DILocation(line: 25, column: 14, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "operator()<float>", scope: !104, file: !104, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 129, column: 11, scope: !103, inlinedAt: !105)
!124 = !DILocation(line: 1018, column: 9, scope: !98, inlinedAt: !125)
!125 = distinct !DILocation(line: 396, column: 10, scope: !100, inlinedAt: !126)
!126 = distinct !DILocation(line: 129, column: 24, scope: !127, inlinedAt: !128)
!127 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !104, file: !104, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!128 = distinct !DILocation(line: 101, column: 14, scope: !129, inlinedAt: !130)
!129 = distinct !DISubprogram(name: "run<float>", scope: !104, file: !104, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!130 = distinct !DILocation(line: 134, column: 14, scope: !103, inlinedAt: !105)
!131 = !DILocation(line: 171, column: 37, scope: !109, inlinedAt: !132)
!132 = distinct !DILocation(line: 990, column: 14, scope: !111, inlinedAt: !133)
!133 = distinct !DILocation(line: 1019, column: 11, scope: !98, inlinedAt: !125)
!134 = !DILocation(line: 171, column: 10, scope: !109, inlinedAt: !132)
!135 = !DILocation(line: 991, column: 20, scope: !111, inlinedAt: !133)
!136 = !DILocation(line: 992, column: 36, scope: !111, inlinedAt: !133)
!137 = !DILocation(line: 992, column: 17, scope: !111, inlinedAt: !133)
!138 = !DILocation(line: 992, column: 11, scope: !111, inlinedAt: !133)
!139 = !DILocation(line: 993, column: 43, scope: !111, inlinedAt: !133)
!140 = !DILocation(line: 993, column: 10, scope: !111, inlinedAt: !133)
!141 = !DILocation(line: 1020, column: 14, scope: !98, inlinedAt: !125)
!142 = !DILocation(line: 25, column: 14, scope: !122, inlinedAt: !143)
!143 = distinct !DILocation(line: 129, column: 11, scope: !127, inlinedAt: !128)
!144 = !DILocation(line: 78, column: 34, scope: !40)
!145 = !DILocation(line: 78, column: 9, scope: !40)
!146 = !DILocation(line: 86, column: 34, scope: !40)
!147 = !DILocation(line: 75, column: 10, scope: !148, inlinedAt: !150)
!148 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !149, file: !149, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!150 = distinct !DILocation(line: 984, column: 9, scope: !151, inlinedAt: !153)
!151 = distinct !DISubprogram(name: "__float2half", scope: !152, file: !152, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!153 = distinct !DILocation(line: 133, column: 53, scope: !154, inlinedAt: !155)
!154 = distinct !DISubprogram(name: "__half", scope: !152, file: !152, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!155 = distinct !DILocation(line: 92, column: 49, scope: !40)
!156 = !DILocation(line: 92, column: 46, scope: !40)
!157 = !DILocation(line: 97, column: 8, scope: !40)
!158 = !DILocation(line: 97, column: 3, scope: !40)
!159 = !DILocation(line: 103, column: 9, scope: !40)
!160 = !DILocation(line: 113, column: 36, scope: !40)
!161 = !DILocation(line: 121, column: 5, scope: !40)
!162 = !DILocation(line: 124, column: 67, scope: !40)
!163 = !DILocation(line: 75, column: 10, scope: !148, inlinedAt: !164)
!164 = distinct !DILocation(line: 984, column: 9, scope: !151, inlinedAt: !165)
!165 = distinct !DILocation(line: 133, column: 53, scope: !154, inlinedAt: !166)
!166 = distinct !DILocation(line: 124, column: 59, scope: !40)
!167 = !DILocation(line: 124, column: 56, scope: !40)
!168 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !169)
!169 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !170)
!170 = distinct !DILocation(line: 127, column: 5, scope: !40)
!171 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !169)
!172 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !169)
!173 = !DILocation(line: 130, column: 124, scope: !40)
!174 = !DILocation(line: 130, column: 152, scope: !40)
!175 = !DILocation(line: 130, column: 79, scope: !40)
!176 = !DILocation(line: 130, column: 158, scope: !40)
!177 = !DILocation(line: 130, column: 42, scope: !40)
!178 = !DILocation(line: 130, column: 201, scope: !40)
!179 = !DILocation(line: 130, column: 95, scope: !40)
!180 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !181)
!181 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !182)
!182 = distinct !DILocation(line: 132, column: 5, scope: !40)
!183 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !181)
!184 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !181)
!185 = !DILocation(line: 135, column: 24, scope: !40)
!186 = !DILocation(line: 135, column: 193, scope: !40)
!187 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!188 = !{i32 1, i32 -1, i32 -1, i32 -1}
!189 = !DILocation(line: 135, column: 230, scope: !40)
!190 = !DILocation(line: 107, column: 152, scope: !40)
!191 = !DILocation(line: 107, column: 239, scope: !40)
!192 = !DILocation(line: 107, column: 57, scope: !40)
!193 = !DILocation(line: 107, column: 36, scope: !40)
!194 = !DILocation(line: 138, column: 1, scope: !40)
