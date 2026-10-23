; ModuleID = 'experiments/20261017_resume/packed_multiwave_v2_binary/oj6_m3_p1.bc'
source_filename = "/tmp/tmpr3ap_6nh/tvm_kernels.maca"
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
  %mul6 = shl nsw i32 %1, 13
  %add = add nuw nsw i32 %mul, %mul6
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %3 = shl nuw nsw i32 %2, 5
  %mul8 = and i32 %3, 30720
  %add9 = add nuw nsw i32 %add, %mul8
  %and = shl nuw nsw i32 %2, 3
  %mul13 = and i32 %and, 504
  %add11 = or disjoint i32 %add9, %mul13
  %4 = zext nneg i32 %add11 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %5 = or disjoint i64 %4, 512, !dbg !45
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !44
  %6 = or disjoint i64 %4, 1024, !dbg !45
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %7 = or disjoint i64 %4, 1536, !dbg !45
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %7, !dbg !44
  %mul19 = shl nsw i32 %0, 10, !dbg !46
  %mul21 = shl nsw i32 %1, 2, !dbg !47
  %shr24 = lshr i32 %2, 6, !dbg !48
  %add22 = add nuw nsw i32 %shr24, %mul21, !dbg !49
  %add25 = add nuw nsw i32 %add22, %mul19, !dbg !50
  %idxprom = zext nneg i32 %add25 to i64, !dbg !51
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !51
  %8 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !51, !tbaa !30
  %cmp26 = icmp sgt i32 %8, -1, !dbg !52
  br i1 %cmp26, label %land.lhs.true, label %if.else371, !dbg !53

land.lhs.true:                                    ; preds = %entry
  %cmp27 = icmp slt i32 %8, 32, !dbg !54
  %mul29 = shl nsw i32 %8, 3
  %cmp30 = icmp sge i32 %1, %mul29
  %or.cond = select i1 %cmp27, i1 %cmp30, i1 false, !dbg !55
  br i1 %or.cond, label %for.cond31.preheader, label %if.else371, !dbg !55

for.cond31.preheader:                             ; preds = %land.lhs.true
  %conv = zext nneg i32 %0 to i64
  %mul37 = shl nuw nsw i64 %conv, 18
  %conv38 = zext nneg i32 %8 to i64
  %mul39 = shl nuw nsw i64 %conv38, 13
  %add40 = add nuw nsw i64 %mul39, %mul37
  %mul47 = zext nneg i32 %mul13 to i64
  %add48 = or disjoint i64 %add40, %mul47, !dbg !56
  %add.ptr49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48, !dbg !57
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49, align 16, !dbg !58
  %k.sroa.4.0.add.ptr49.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8, !dbg !58
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr49.sroa_idx, align 8, !dbg !58
  %add43.1 = or disjoint i64 %add40, %mul47, !dbg !56
  %add48.1 = or disjoint i64 %add43.1, 512, !dbg !56
  %add.ptr49.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.1, !dbg !57
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.1, align 16, !dbg !58
  %k.sroa.7.16.add.ptr49.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8, !dbg !58
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.add.ptr49.1.sroa_idx, align 8, !dbg !58
  %add43.2 = or disjoint i64 %add40, %mul47, !dbg !56
  %add48.2 = or disjoint i64 %add43.2, 1024, !dbg !56
  %add.ptr49.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.2, !dbg !57
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.2, align 16, !dbg !58
  %k.sroa.10.32.add.ptr49.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8, !dbg !58
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.add.ptr49.2.sroa_idx, align 8, !dbg !58
  %add43.3 = or disjoint i64 %add40, %mul47, !dbg !56
  %add48.3 = or disjoint i64 %add43.3, 1536, !dbg !56
  %add.ptr49.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.3, !dbg !57
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.3, align 16, !dbg !58
  %k.sroa.13.48.add.ptr49.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8, !dbg !58
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.add.ptr49.3.sroa_idx, align 8, !dbg !58
  %add43.4 = or disjoint i64 %add40, %mul47, !dbg !56
  %add48.4 = or disjoint i64 %add43.4, 2048, !dbg !56
  %add.ptr49.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.4, !dbg !57
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.4, align 16, !dbg !58
  %k.sroa.16.64.add.ptr49.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8, !dbg !58
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.add.ptr49.4.sroa_idx, align 8, !dbg !58
  %add43.5 = or disjoint i64 %add40, %mul47, !dbg !56
  %add48.5 = or disjoint i64 %add43.5, 2560, !dbg !56
  %add.ptr49.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.5, !dbg !57
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.5, align 16, !dbg !58
  %k.sroa.19.80.add.ptr49.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8, !dbg !58
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.add.ptr49.5.sroa_idx, align 8, !dbg !58
  %add43.6 = or disjoint i64 %add40, %mul47, !dbg !56
  %add48.6 = or disjoint i64 %add43.6, 3072, !dbg !56
  %add.ptr49.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.6, !dbg !57
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.6, align 16, !dbg !58
  %k.sroa.22.96.add.ptr49.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8, !dbg !58
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.add.ptr49.6.sroa_idx, align 8, !dbg !58
  %add43.7 = or disjoint i64 %add40, %mul47, !dbg !56
  %add48.7 = or disjoint i64 %add43.7, 3584, !dbg !56
  %add.ptr49.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.7, !dbg !57
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.7, align 16, !dbg !58
  %k.sroa.25.112.add.ptr49.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8, !dbg !58
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.add.ptr49.7.sroa_idx, align 8, !dbg !58
  %mul74 = and i32 %and, 384
  %and77 = and i32 %2, 15
  %and80 = lshr i32 %2, 4
  %shr81 = and i32 %and80, 3
  %add75 = or disjoint i32 %mul8, %mul74, !dbg !59
  %xor = xor i32 %shr81, %and77, !dbg !60
  %.idx = shl nuw nsw i32 %xor, 4, !dbg !61
  %9 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx, !dbg !61
  %add.ptr86 = getelementptr inbounds %struct.__half, ptr addrspace(3) %9, i32 %add75, !dbg !61
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !62, !call_argsrelate !63
  %add70.1 = or disjoint i32 %mul8, %mul74, !dbg !59
  %add75.1 = or disjoint i32 %add70.1, 512, !dbg !59
  %add82.1 = or disjoint i32 %shr81, 4, !dbg !64
  %xor.1 = xor i32 %add82.1, %and77, !dbg !60
  %.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !61
  %10 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.1, !dbg !61
  %add.ptr86.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %10, i32 %add75.1, !dbg !61
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !62, !call_argsrelate !63
  %add70.2 = or disjoint i32 %mul8, %mul74, !dbg !59
  %add75.2 = or disjoint i32 %add70.2, 1024, !dbg !59
  %add82.2 = or disjoint i32 %shr81, 8, !dbg !64
  %xor.2 = xor i32 %add82.2, %and77, !dbg !60
  %.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !61
  %11 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.2, !dbg !61
  %add.ptr86.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %11, i32 %add75.2, !dbg !61
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !dbg !62, !call_argsrelate !63
  %add70.3 = or disjoint i32 %mul8, %mul74, !dbg !59
  %add75.3 = or disjoint i32 %add70.3, 1536, !dbg !59
  %add82.3 = or disjoint i32 %shr81, 12, !dbg !64
  %xor.3 = xor i32 %add82.3, %and77, !dbg !60
  %.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !61
  %12 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.3, !dbg !61
  %add.ptr86.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %12, i32 %add75.3, !dbg !61
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !dbg !62, !call_argsrelate !63
  fence syncscope("warp") release, !dbg !65
  tail call void @llvm.mxc.barrier.warp(), !dbg !71
  fence syncscope("warp") acquire, !dbg !72
  %and99 = shl nuw nsw i32 %2, 7
  %mul100 = and i32 %and99, 1920
  %add101 = or disjoint i32 %mul8, %mul100
  %add.ptr113 = getelementptr inbounds %struct.__half, ptr addrspace(3) %9, i32 %add101, !dbg !73
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113, align 16, !dbg !74
  %q.sroa.4.0.add.ptr113.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113, i32 8, !dbg !74
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr113.sroa_idx, align 8, !dbg !74
  %add.ptr113.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %10, i32 %add101, !dbg !73
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113.1, align 16, !dbg !74
  %q.sroa.7.16.add.ptr113.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.1, i32 8, !dbg !74
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr113.1.sroa_idx, align 8, !dbg !74
  %add.ptr113.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %11, i32 %add101, !dbg !73
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113.2, align 16, !dbg !74
  %q.sroa.10.32.add.ptr113.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.2, i32 8, !dbg !74
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr113.2.sroa_idx, align 8, !dbg !74
  %add.ptr113.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %12, i32 %add101, !dbg !73
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113.3, align 16, !dbg !74
  %q.sroa.13.48.add.ptr113.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.3, i32 8, !dbg !74
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr113.3.sroa_idx, align 8, !dbg !74
  %mul128 = shl nsw i32 %8, 5
  %13 = lshr i32 %2, 2
  %mul135 = and i32 %13, 12
  %add136 = or disjoint i32 %mul128, %mul135, !dbg !75
  %cmp144.not = icmp sgt i32 %add136, %add22, !dbg !76
  %spec.select = select i1 %cmp144.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !78
  %cmp144.not.1.not = icmp slt i32 %add136, %add22, !dbg !76
  %spec.select.1 = select i1 %cmp144.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !77
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !78
  %add138.2 = or disjoint i32 %add136, 2, !dbg !79
  %cmp144.not.2 = icmp sgt i32 %add138.2, %add22, !dbg !76
  %spec.select.2 = select i1 %cmp144.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !78
  %add138.3 = or disjoint i32 %add136, 3, !dbg !79
  %cmp144.not.3 = icmp sgt i32 %add138.3, %add22, !dbg !76
  %spec.select.3 = select i1 %cmp144.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !78
  %add131.4 = or disjoint i32 %mul128, %mul135, !dbg !75
  %add136.4 = or disjoint i32 %add131.4, 16, !dbg !75
  %cmp144.not.4 = icmp sgt i32 %add136.4, %add22, !dbg !76
  %spec.select.4 = select i1 %cmp144.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !78
  %add138.5 = or disjoint i32 %add131.4, 17, !dbg !79
  %cmp144.not.5 = icmp sgt i32 %add138.5, %add22, !dbg !76
  %spec.select.5 = select i1 %cmp144.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1, !dbg !78
  %add138.6 = or disjoint i32 %add131.4, 18, !dbg !79
  %cmp144.not.6 = icmp sgt i32 %add138.6, %add22, !dbg !76
  %spec.select.6 = select i1 %cmp144.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2, !dbg !78
  %add138.7 = or disjoint i32 %add131.4, 19, !dbg !79
  %cmp144.not.7 = icmp sgt i32 %add138.7, %add22, !dbg !76
  %spec.select.7 = select i1 %cmp144.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3, !dbg !78
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !80, !call_argsrelate !81
  %15 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !80, !call_argsrelate !81
  %16 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %14), !dbg !80, !call_argsrelate !81
  %17 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %15), !dbg !80, !call_argsrelate !81
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %16), !dbg !80, !call_argsrelate !81
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %17), !dbg !80, !call_argsrelate !81
  %20 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %18), !dbg !80, !call_argsrelate !81
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %19), !dbg !80, !call_argsrelate !81
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %20), !dbg !80, !call_argsrelate !81
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %21), !dbg !80, !call_argsrelate !81
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %22), !dbg !80, !call_argsrelate !81
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %23), !dbg !80, !call_argsrelate !81
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %24), !dbg !80, !call_argsrelate !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %25), !dbg !80, !call_argsrelate !81
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %26), !dbg !80, !call_argsrelate !81
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %27), !dbg !80, !call_argsrelate !81
  %add.ptr211 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8192, !dbg !82
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211, align 16, !dbg !83
  %v.sroa.4.0.add.ptr211.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8200, !dbg !83
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0.add.ptr211.sroa_idx, align 8, !dbg !83
  %add.ptr211.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8192, !dbg !82
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.1, align 16, !dbg !83
  %v.sroa.7.16.add.ptr211.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8200, !dbg !83
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.add.ptr211.1.sroa_idx, align 8, !dbg !83
  %add.ptr211.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8192, !dbg !82
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.2, align 16, !dbg !83
  %v.sroa.10.32.add.ptr211.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8200, !dbg !83
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.add.ptr211.2.sroa_idx, align 8, !dbg !83
  %add.ptr211.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8192, !dbg !82
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.3, align 16, !dbg !83
  %v.sroa.13.48.add.ptr211.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8200, !dbg !83
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.add.ptr211.3.sroa_idx, align 8, !dbg !83
  %add.ptr211.4 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8192, !dbg !82
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.4, align 16, !dbg !83
  %v.sroa.16.64.add.ptr211.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8200, !dbg !83
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.add.ptr211.4.sroa_idx, align 8, !dbg !83
  %add.ptr211.5 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8192, !dbg !82
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.5, align 16, !dbg !83
  %v.sroa.19.80.add.ptr211.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8200, !dbg !83
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.add.ptr211.5.sroa_idx, align 8, !dbg !83
  %add.ptr211.6 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8192, !dbg !82
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.6, align 16, !dbg !83
  %v.sroa.22.96.add.ptr211.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8200, !dbg !83
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.add.ptr211.6.sroa_idx, align 8, !dbg !83
  %add.ptr211.7 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8192, !dbg !82
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.7, align 16, !dbg !83
  %v.sroa.25.112.add.ptr211.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8200, !dbg !83
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.add.ptr211.7.sroa_idx, align 8, !dbg !83
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0, !dbg !84
  %mul225 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !85
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul225, float 1.500000e+01), !dbg !86
  %cmp.i.i = fcmp contract olt float %30, -1.260000e+02, !dbg !90
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i = fadd contract float %30, %cond.i.i, !dbg !90
  %31 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !90
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i = fmul contract float %cond2.i.i, %31, !dbg !90
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1, !dbg !84
  %mul225.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !85
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul225.1, float 1.500000e+01), !dbg !86
  %cmp.i.i.1 = fcmp contract olt float %32, -1.260000e+02, !dbg !90
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i.1 = fadd contract float %32, %cond.i.i.1, !dbg !90
  %33 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !90
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %33, !dbg !90
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2, !dbg !84
  %mul225.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !85
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul225.2, float 1.500000e+01), !dbg !86
  %cmp.i.i.2 = fcmp contract olt float %34, -1.260000e+02, !dbg !90
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i.2 = fadd contract float %34, %cond.i.i.2, !dbg !90
  %35 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !90
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %35, !dbg !90
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3, !dbg !84
  %mul225.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !85
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul225.3, float 1.500000e+01), !dbg !86
  %cmp.i.i.3 = fcmp contract olt float %36, -1.260000e+02, !dbg !90
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i.3 = fadd contract float %36, %cond.i.i.3, !dbg !90
  %37 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !90
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %37, !dbg !90
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %29, i64 0, !dbg !84
  %mul225.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !85
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul225.4, float 1.500000e+01), !dbg !86
  %cmp.i.i.4 = fcmp contract olt float %38, -1.260000e+02, !dbg !90
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i.4 = fadd contract float %38, %cond.i.i.4, !dbg !90
  %39 = tail call contract float @llvm.exp2.f32(float %add.i.i.4), !dbg !90
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %39, !dbg !90
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %29, i64 1, !dbg !84
  %mul225.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !85
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul225.5, float 1.500000e+01), !dbg !86
  %cmp.i.i.5 = fcmp contract olt float %40, -1.260000e+02, !dbg !90
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i.5 = fadd contract float %40, %cond.i.i.5, !dbg !90
  %41 = tail call contract float @llvm.exp2.f32(float %add.i.i.5), !dbg !90
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %41, !dbg !90
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %29, i64 2, !dbg !84
  %mul225.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !85
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul225.6, float 1.500000e+01), !dbg !86
  %cmp.i.i.6 = fcmp contract olt float %42, -1.260000e+02, !dbg !90
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i.6 = fadd contract float %42, %cond.i.i.6, !dbg !90
  %43 = tail call contract float @llvm.exp2.f32(float %add.i.i.6), !dbg !90
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %43, !dbg !90
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %29, i64 3, !dbg !84
  %mul225.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !85
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul225.7, float 1.500000e+01), !dbg !86
  %cmp.i.i.7 = fcmp contract olt float %44, -1.260000e+02, !dbg !90
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i.7 = fadd contract float %44, %cond.i.i.7, !dbg !90
  %45 = tail call contract float @llvm.exp2.f32(float %add.i.i.7), !dbg !90
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %45, !dbg !90
  %add247 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !93
  %add247.1 = fadd contract float %add247, %mul.i.i.4, !dbg !93
  %add247.1640 = fadd contract float %add247.1, %mul.i.i.1, !dbg !93
  %add247.1.1 = fadd contract float %add247.1640, %mul.i.i.5, !dbg !93
  %add247.2 = fadd contract float %add247.1.1, %mul.i.i.2, !dbg !93
  %add247.1.2 = fadd contract float %add247.2, %mul.i.i.6, !dbg !93
  %add247.3 = fadd contract float %add247.1.2, %mul.i.i.3, !dbg !93
  %add247.1.3 = fadd contract float %add247.3, %mul.i.i.7, !dbg !93
  %46 = bitcast float %add247.1.3 to i32, !dbg !94
  %47 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !97
  %48 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %47) #11, !dbg !102
  %xor.i.i = xor i32 %48, 32, !dbg !103
  %49 = and i32 %48, -64, !dbg !104
  %and.i.i = add nsw i32 %49, 64, !dbg !104
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !105
  %cond.i.i584 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %48, !dbg !106
  %shl.i.i = shl i32 %cond.i.i584, 2, !dbg !107
  %50 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %46), !dbg !108
  %51 = bitcast i32 %50 to float, !dbg !109
  %add258 = fadd contract float %add247.1.3, %51, !dbg !110
  %52 = bitcast float %add258 to i32, !dbg !111
  %53 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !113
  %54 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %53) #11, !dbg !116
  %xor.i.i585 = xor i32 %54, 16, !dbg !117
  %55 = and i32 %54, -64, !dbg !118
  %and.i.i586 = add nsw i32 %55, 64, !dbg !118
  %cmp.not.i.i587 = icmp slt i32 %xor.i.i585, %and.i.i586, !dbg !119
  %cond.i.i588 = select i1 %cmp.not.i.i587, i32 %xor.i.i585, i32 %54, !dbg !120
  %shl.i.i589 = shl i32 %cond.i.i588, 2, !dbg !121
  %56 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i589, i32 %52), !dbg !122
  %57 = bitcast i32 %56 to float, !dbg !123
  %add263 = fadd contract float %add258, %57, !dbg !124
  %cmp266 = fcmp contract ogt float %add263, 0.000000e+00, !dbg !125
  %div = fdiv contract float 1.000000e+00, %add263, !dbg !126
  %condval_1.0 = select i1 %cmp266, float %div, float 0.000000e+00, !dbg !126
  %mul279 = fmul contract float %condval_1.0, %mul.i.i, !dbg !127
  %mul279.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !127
  %mul279.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !127
  %mul279.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !127
  %mul279.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !127
  %mul279.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !127
  %mul279.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !127
  %mul279.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !127
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279), !dbg !128
  %59 = insertelement <4 x i16> poison, i16 %58, i64 0, !dbg !137
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.1), !dbg !128
  %61 = insertelement <4 x i16> %59, i16 %60, i64 1, !dbg !137
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.2), !dbg !128
  %63 = insertelement <4 x i16> %61, i16 %62, i64 2, !dbg !137
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.3), !dbg !128
  %65 = insertelement <4 x i16> %63, i16 %64, i64 3, !dbg !137
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %65 to <4 x half>, !dbg !137
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.4), !dbg !128
  %67 = insertelement <4 x i16> poison, i16 %66, i64 0, !dbg !137
  %68 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.5), !dbg !128
  %69 = insertelement <4 x i16> %67, i16 %68, i64 1, !dbg !137
  %70 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.6), !dbg !128
  %71 = insertelement <4 x i16> %69, i16 %70, i64 2, !dbg !137
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.7), !dbg !128
  %73 = insertelement <4 x i16> %71, i16 %72, i64 3, !dbg !137
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %73 to <4 x half>, !dbg !137
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !138, !call_argsrelate !81
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %74), !dbg !138, !call_argsrelate !81
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %75), !dbg !138, !call_argsrelate !81
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %76), !dbg !138, !call_argsrelate !81
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %77), !dbg !138, !call_argsrelate !81
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %78), !dbg !138, !call_argsrelate !81
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %79), !dbg !138, !call_argsrelate !81
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %80), !dbg !138, !call_argsrelate !81
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %81), !dbg !138, !call_argsrelate !81
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %82, i64 0, !dbg !139
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !140
  %output_reg.sroa.0.0.insert.ext = zext i16 %90 to i64, !dbg !144
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %82, i64 1, !dbg !139
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !140
  %output_reg.sroa.0.2.insert.ext = zext i16 %91 to i64, !dbg !144
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !144
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !144
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %82, i64 2, !dbg !139
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !140
  %output_reg.sroa.0.4.insert.ext = zext i16 %92 to i64, !dbg !144
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !144
  %output_reg.sroa.0.4.insert.insert660 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !144
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %82, i64 3, !dbg !139
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !140
  %output_reg.sroa.0.6.insert.ext = zext i16 %93 to i64, !dbg !144
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !144
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert660, %output_reg.sroa.0.6.insert.shift, !dbg !144
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %83, i64 0, !dbg !139
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !140
  %output_reg.sroa.9.8.insert.ext = zext i16 %94 to i64, !dbg !144
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %83, i64 1, !dbg !139
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !140
  %output_reg.sroa.9.10.insert.ext = zext i16 %95 to i64, !dbg !144
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16, !dbg !144
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext, !dbg !144
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %83, i64 2, !dbg !139
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !140
  %output_reg.sroa.9.12.insert.ext = zext i16 %96 to i64, !dbg !144
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32, !dbg !144
  %output_reg.sroa.9.12.insert.insert666 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift, !dbg !144
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %83, i64 3, !dbg !139
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !140
  %output_reg.sroa.9.14.insert.ext = zext i16 %97 to i64, !dbg !144
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48, !dbg !144
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert666, %output_reg.sroa.9.14.insert.shift, !dbg !144
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %84, i64 0, !dbg !139
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !140
  %output_reg.sroa.16.16.insert.ext = zext i16 %98 to i64, !dbg !144
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %84, i64 1, !dbg !139
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !140
  %output_reg.sroa.16.18.insert.ext = zext i16 %99 to i64, !dbg !144
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16, !dbg !144
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext, !dbg !144
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %84, i64 2, !dbg !139
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !140
  %output_reg.sroa.16.20.insert.ext = zext i16 %100 to i64, !dbg !144
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32, !dbg !144
  %output_reg.sroa.16.20.insert.insert672 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift, !dbg !144
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %84, i64 3, !dbg !139
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !140
  %output_reg.sroa.16.22.insert.ext = zext i16 %101 to i64, !dbg !144
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48, !dbg !144
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert672, %output_reg.sroa.16.22.insert.shift, !dbg !144
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %85, i64 0, !dbg !139
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !140
  %output_reg.sroa.23.24.insert.ext = zext i16 %102 to i64, !dbg !144
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %85, i64 1, !dbg !139
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !140
  %output_reg.sroa.23.26.insert.ext = zext i16 %103 to i64, !dbg !144
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16, !dbg !144
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext, !dbg !144
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %85, i64 2, !dbg !139
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !140
  %output_reg.sroa.23.28.insert.ext = zext i16 %104 to i64, !dbg !144
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32, !dbg !144
  %output_reg.sroa.23.28.insert.insert678 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift, !dbg !144
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %85, i64 3, !dbg !139
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !140
  %output_reg.sroa.23.30.insert.ext = zext i16 %105 to i64, !dbg !144
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48, !dbg !144
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert678, %output_reg.sroa.23.30.insert.shift, !dbg !144
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %86, i64 0, !dbg !139
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !140
  %output_reg.sroa.30.32.insert.ext = zext i16 %106 to i64, !dbg !144
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %86, i64 1, !dbg !139
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !140
  %output_reg.sroa.30.34.insert.ext = zext i16 %107 to i64, !dbg !144
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16, !dbg !144
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext, !dbg !144
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %86, i64 2, !dbg !139
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !140
  %output_reg.sroa.30.36.insert.ext = zext i16 %108 to i64, !dbg !144
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32, !dbg !144
  %output_reg.sroa.30.36.insert.insert684 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift, !dbg !144
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %86, i64 3, !dbg !139
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !140
  %output_reg.sroa.30.38.insert.ext = zext i16 %109 to i64, !dbg !144
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48, !dbg !144
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert684, %output_reg.sroa.30.38.insert.shift, !dbg !144
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %87, i64 0, !dbg !139
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !140
  %output_reg.sroa.37.40.insert.ext = zext i16 %110 to i64, !dbg !144
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %87, i64 1, !dbg !139
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !140
  %output_reg.sroa.37.42.insert.ext = zext i16 %111 to i64, !dbg !144
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16, !dbg !144
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext, !dbg !144
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %87, i64 2, !dbg !139
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !140
  %output_reg.sroa.37.44.insert.ext = zext i16 %112 to i64, !dbg !144
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32, !dbg !144
  %output_reg.sroa.37.44.insert.insert690 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift, !dbg !144
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %87, i64 3, !dbg !139
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !140
  %output_reg.sroa.37.46.insert.ext = zext i16 %113 to i64, !dbg !144
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48, !dbg !144
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert690, %output_reg.sroa.37.46.insert.shift, !dbg !144
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %88, i64 0, !dbg !139
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !140
  %output_reg.sroa.44.48.insert.ext = zext i16 %114 to i64, !dbg !144
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %88, i64 1, !dbg !139
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !140
  %output_reg.sroa.44.50.insert.ext = zext i16 %115 to i64, !dbg !144
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16, !dbg !144
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext, !dbg !144
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %88, i64 2, !dbg !139
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !140
  %output_reg.sroa.44.52.insert.ext = zext i16 %116 to i64, !dbg !144
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32, !dbg !144
  %output_reg.sroa.44.52.insert.insert696 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift, !dbg !144
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %88, i64 3, !dbg !139
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !140
  %output_reg.sroa.44.54.insert.ext = zext i16 %117 to i64, !dbg !144
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48, !dbg !144
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert696, %output_reg.sroa.44.54.insert.shift, !dbg !144
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %89, i64 0, !dbg !139
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !140
  %output_reg.sroa.51.56.insert.ext = zext i16 %118 to i64, !dbg !144
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %89, i64 1, !dbg !139
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !140
  %output_reg.sroa.51.58.insert.ext = zext i16 %119 to i64, !dbg !144
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16, !dbg !144
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext, !dbg !144
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %89, i64 2, !dbg !139
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !140
  %output_reg.sroa.51.60.insert.ext = zext i16 %120 to i64, !dbg !144
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32, !dbg !144
  %output_reg.sroa.51.60.insert.insert702 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift, !dbg !144
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %89, i64 3, !dbg !139
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !140
  %output_reg.sroa.51.62.insert.ext = zext i16 %121 to i64, !dbg !144
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48, !dbg !144
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert702, %output_reg.sroa.51.62.insert.shift, !dbg !144
  br label %if.end393, !dbg !145

if.else371:                                       ; preds = %land.lhs.true, %entry
  %.pre = shl nuw nsw i32 %2, 7
  %.pre857 = and i32 %.pre, 1920
  %.pre858 = or disjoint i32 %mul8, %.pre857
  %.pre859 = and i32 %2, 15
  %.pre860 = lshr i32 %2, 2
  %.pre861 = and i32 %and, 384
  %.pre862 = lshr i32 %2, 4
  %.pre863 = and i32 %.pre862, 3
  %.pre864 = or disjoint i32 %mul8, %.pre861, !dbg !148
  %.pre865 = xor i32 %.pre863, %.pre859, !dbg !149
  %.pre866 = shl nuw nsw i32 %.pre865, 4, !dbg !150
  %.pre867 = or disjoint i32 %mul8, %.pre861, !dbg !148
  %.pre868 = or disjoint i32 %.pre867, 512, !dbg !148
  %.pre869 = or disjoint i32 %.pre863, 4, !dbg !151
  %.pre870 = xor i32 %.pre869, %.pre859, !dbg !149
  %.pre871 = shl nuw nsw i32 %.pre870, 4, !dbg !150
  %.pre872 = or disjoint i32 %mul8, %.pre861, !dbg !148
  %.pre873 = or disjoint i32 %.pre872, 1024, !dbg !148
  %.pre874 = or disjoint i32 %.pre863, 8, !dbg !151
  %.pre875 = xor i32 %.pre874, %.pre859, !dbg !149
  %.pre876 = shl nuw nsw i32 %.pre875, 4, !dbg !150
  %.pre877 = or disjoint i32 %mul8, %.pre861, !dbg !148
  %.pre878 = or disjoint i32 %.pre877, 1536, !dbg !148
  %.pre879 = or disjoint i32 %.pre863, 12, !dbg !151
  %.pre880 = xor i32 %.pre879, %.pre859, !dbg !149
  %.pre881 = shl nuw nsw i32 %.pre880, 4, !dbg !150
  br label %if.end393, !dbg !145

if.end393:                                        ; preds = %if.else371, %for.cond31.preheader
  %.idx621.3.pre-phi = phi i32 [ %.pre881, %if.else371 ], [ %.idx.3, %for.cond31.preheader ], !dbg !150
  %add442.3.pre-phi = phi i32 [ %.pre878, %if.else371 ], [ %add75.3, %for.cond31.preheader ], !dbg !148
  %.idx621.2.pre-phi = phi i32 [ %.pre876, %if.else371 ], [ %.idx.2, %for.cond31.preheader ], !dbg !150
  %add442.2.pre-phi = phi i32 [ %.pre873, %if.else371 ], [ %add75.2, %for.cond31.preheader ], !dbg !148
  %.idx621.1.pre-phi = phi i32 [ %.pre871, %if.else371 ], [ %.idx.1, %for.cond31.preheader ], !dbg !150
  %add442.1.pre-phi = phi i32 [ %.pre868, %if.else371 ], [ %add75.1, %for.cond31.preheader ], !dbg !148
  %.idx621.pre-phi = phi i32 [ %.pre866, %if.else371 ], [ %.idx, %for.cond31.preheader ], !dbg !150
  %add442.pre-phi = phi i32 [ %.pre864, %if.else371 ], [ %add75, %for.cond31.preheader ], !dbg !148
  %.pre-phi = phi i32 [ %.pre860, %if.else371 ], [ %13, %for.cond31.preheader ]
  %and415.pre-phi = phi i32 [ %.pre859, %if.else371 ], [ %and77, %for.cond31.preheader ]
  %add408.pre-phi = phi i32 [ %.pre858, %if.else371 ], [ %add101, %for.cond31.preheader ]
  %output_reg.sroa.51.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.51.62.insert.insert, %for.cond31.preheader ], !dbg !152
  %output_reg.sroa.44.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.44.54.insert.insert, %for.cond31.preheader ], !dbg !152
  %output_reg.sroa.37.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.37.46.insert.insert, %for.cond31.preheader ], !dbg !152
  %output_reg.sroa.30.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.30.38.insert.insert, %for.cond31.preheader ], !dbg !152
  %output_reg.sroa.23.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.23.30.insert.insert, %for.cond31.preheader ], !dbg !152
  %output_reg.sroa.16.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.16.22.insert.insert, %for.cond31.preheader ], !dbg !152
  %output_reg.sroa.9.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.9.14.insert.insert, %for.cond31.preheader ], !dbg !152
  %output_reg.sroa.0.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.0.6.insert.insert, %for.cond31.preheader ], !dbg !152
  fence syncscope("warp") release, !dbg !145
  tail call void @llvm.mxc.barrier.warp(), !dbg !153
  fence syncscope("warp") acquire, !dbg !154
  %and411 = lshr i32 %2, 5
  %shr412 = and i32 %and411, 1
  %mul422 = and i32 %.pre-phi, 4
  %xor416 = xor i32 %shr412, %and415.pre-phi, !dbg !155
  %mul417 = shl nuw nsw i32 %xor416, 3, !dbg !156
  %add418 = add nuw nsw i32 %mul417, %add408.pre-phi, !dbg !157
  %add423 = or disjoint i32 %add418, %mul422, !dbg !158
  %add.ptr425 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423, !dbg !159
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr425, align 8, !dbg !160
  %add413.1 = or disjoint i32 %shr412, 2, !dbg !161
  %xor416.1 = xor i32 %add413.1, %and415.pre-phi, !dbg !155
  %mul417.1 = shl nuw nsw i32 %xor416.1, 3, !dbg !156
  %add418.1 = add nuw nsw i32 %mul417.1, %add408.pre-phi, !dbg !157
  %add423.1 = or disjoint i32 %add418.1, %mul422, !dbg !158
  %add.ptr425.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.1, !dbg !159
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr425.1, align 8, !dbg !160
  %add413.2 = or disjoint i32 %shr412, 4, !dbg !161
  %xor416.2 = xor i32 %add413.2, %and415.pre-phi, !dbg !155
  %mul417.2 = shl nuw nsw i32 %xor416.2, 3, !dbg !156
  %add418.2 = add nuw nsw i32 %mul417.2, %add408.pre-phi, !dbg !157
  %add423.2 = or disjoint i32 %add418.2, %mul422, !dbg !158
  %add.ptr425.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.2, !dbg !159
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr425.2, align 8, !dbg !160
  %add413.3 = or disjoint i32 %shr412, 6, !dbg !161
  %xor416.3 = xor i32 %add413.3, %and415.pre-phi, !dbg !155
  %mul417.3 = shl nuw nsw i32 %xor416.3, 3, !dbg !156
  %add418.3 = add nuw nsw i32 %mul417.3, %add408.pre-phi, !dbg !157
  %add423.3 = or disjoint i32 %add418.3, %mul422, !dbg !158
  %add.ptr425.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.3, !dbg !159
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr425.3, align 8, !dbg !160
  %add413.4 = or disjoint i32 %shr412, 8, !dbg !161
  %xor416.4 = xor i32 %add413.4, %and415.pre-phi, !dbg !155
  %mul417.4 = shl nuw nsw i32 %xor416.4, 3, !dbg !156
  %add418.4 = add nuw nsw i32 %mul417.4, %add408.pre-phi, !dbg !157
  %add423.4 = or disjoint i32 %add418.4, %mul422, !dbg !158
  %add.ptr425.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.4, !dbg !159
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr425.4, align 8, !dbg !160
  %add413.5 = or disjoint i32 %shr412, 10, !dbg !161
  %xor416.5 = xor i32 %add413.5, %and415.pre-phi, !dbg !155
  %mul417.5 = shl nuw nsw i32 %xor416.5, 3, !dbg !156
  %add418.5 = add nuw nsw i32 %mul417.5, %add408.pre-phi, !dbg !157
  %add423.5 = or disjoint i32 %add418.5, %mul422, !dbg !158
  %add.ptr425.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.5, !dbg !159
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr425.5, align 8, !dbg !160
  %add413.6 = or disjoint i32 %shr412, 12, !dbg !161
  %xor416.6 = xor i32 %add413.6, %and415.pre-phi, !dbg !155
  %mul417.6 = shl nuw nsw i32 %xor416.6, 3, !dbg !156
  %add418.6 = add nuw nsw i32 %mul417.6, %add408.pre-phi, !dbg !157
  %add423.6 = or disjoint i32 %add418.6, %mul422, !dbg !158
  %add.ptr425.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.6, !dbg !159
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr425.6, align 8, !dbg !160
  %add413.7 = or disjoint i32 %shr412, 14, !dbg !161
  %xor416.7 = xor i32 %add413.7, %and415.pre-phi, !dbg !155
  %mul417.7 = shl nuw nsw i32 %xor416.7, 3, !dbg !156
  %add418.7 = add nuw nsw i32 %mul417.7, %add408.pre-phi, !dbg !157
  %add423.7 = or disjoint i32 %add418.7, %mul422, !dbg !158
  %add.ptr425.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.7, !dbg !159
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr425.7, align 8, !dbg !160
  fence syncscope("warp") release, !dbg !162
  tail call void @llvm.mxc.barrier.warp(), !dbg !165
  fence syncscope("warp") acquire, !dbg !166
  %122 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.pre-phi, !dbg !150
  %add.ptr454 = getelementptr inbounds %struct.__half, ptr addrspace(3) %122, i32 %add442.pre-phi, !dbg !150
  %123 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.1.pre-phi, !dbg !150
  %add.ptr454.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %123, i32 %add442.1.pre-phi, !dbg !150
  %124 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.2.pre-phi, !dbg !150
  %add.ptr454.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %124, i32 %add442.2.pre-phi, !dbg !150
  %125 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.3.pre-phi, !dbg !150
  %add.ptr454.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %125, i32 %add442.3.pre-phi, !dbg !150
  %add.ptr486 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !167
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454, i64 16, i1 false), !dbg !168, !call_argsrelate !169
  %add.ptr486.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !167
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454.1, i64 16, i1 false), !dbg !168, !call_argsrelate !169
  %add.ptr486.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %6, !dbg !167
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454.2, i64 16, i1 false), !dbg !168, !call_argsrelate !169
  %add.ptr486.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %7, !dbg !167
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454.3, i64 16, i1 false), !dbg !168, !call_argsrelate !169
  ret void, !dbg !170
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

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

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
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="256" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
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
!1 = !DIFile(filename: "/tmp/tmpr3ap_6nh/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpr3ap_6nh/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 23, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 48, scope: !40)
!45 = !DILocation(line: 24, column: 165, scope: !40)
!46 = !DILocation(line: 26, column: 44, scope: !40)
!47 = !DILocation(line: 26, column: 73, scope: !40)
!48 = !DILocation(line: 26, column: 101, scope: !40)
!49 = !DILocation(line: 26, column: 52, scope: !40)
!50 = !DILocation(line: 26, column: 79, scope: !40)
!51 = !DILocation(line: 26, column: 15, scope: !40)
!52 = !DILocation(line: 27, column: 21, scope: !40)
!53 = !DILocation(line: 27, column: 31, scope: !40)
!54 = !DILocation(line: 27, column: 41, scope: !40)
!55 = !DILocation(line: 27, column: 48, scope: !40)
!56 = !DILocation(line: 31, column: 178, scope: !40)
!57 = !DILocation(line: 31, column: 52, scope: !40)
!58 = !DILocation(line: 31, column: 31, scope: !40)
!59 = !DILocation(line: 35, column: 97, scope: !40)
!60 = !DILocation(line: 35, column: 171, scope: !40)
!61 = !DILocation(line: 35, column: 42, scope: !40)
!62 = !DILocation(line: 35, column: 228, scope: !40)
!63 = !{i32 -1, i32 3, i32 -1, i32 -1}
!64 = !DILocation(line: 35, column: 184, scope: !40)
!65 = !DILocation(line: 68, column: 3, scope: !66, inlinedAt: !68)
!66 = distinct !DISubprogram(name: "__barrier_warp", scope: !67, file: !67, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!67 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!68 = distinct !DILocation(line: 192, column: 3, scope: !69, inlinedAt: !70)
!69 = distinct !DISubprogram(name: "__syncwarp", scope: !67, file: !67, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!70 = distinct !DILocation(line: 37, column: 5, scope: !40)
!71 = !DILocation(line: 69, column: 3, scope: !66, inlinedAt: !68)
!72 = !DILocation(line: 70, column: 3, scope: !66, inlinedAt: !68)
!73 = !DILocation(line: 40, column: 69, scope: !40)
!74 = !DILocation(line: 40, column: 32, scope: !40)
!75 = !DILocation(line: 45, column: 66, scope: !40)
!76 = !DILocation(line: 45, column: 121, scope: !40)
!77 = !DILocation(line: 45, column: 11, scope: !40)
!78 = !DILocation(line: 50, column: 19, scope: !40)
!79 = !DILocation(line: 45, column: 108, scope: !40)
!80 = !DILocation(line: 56, column: 37, scope: !40)
!81 = !{i32 2, i32 -1, i32 -1}
!82 = !DILocation(line: 65, column: 54, scope: !40)
!83 = !DILocation(line: 65, column: 33, scope: !40)
!84 = !DILocation(line: 69, column: 32, scope: !40)
!85 = !DILocation(line: 69, column: 44, scope: !40)
!86 = !DILocation(line: 354, column: 10, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: "min", scope: !88, file: !88, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!89 = distinct !DILocation(line: 69, column: 27, scope: !40)
!90 = !DILocation(line: 285, column: 49, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "exp2f", scope: !88, file: !88, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = distinct !DILocation(line: 69, column: 21, scope: !40)
!93 = !DILocation(line: 76, column: 36, scope: !40)
!94 = !DILocation(line: 1018, column: 9, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !67, file: !67, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 79, column: 34, scope: !40)
!97 = !DILocation(line: 171, column: 37, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "__lane_id", scope: !67, file: !67, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 990, column: 14, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !67, file: !67, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 1019, column: 11, scope: !95, inlinedAt: !96)
!102 = !DILocation(line: 171, column: 10, scope: !98, inlinedAt: !99)
!103 = !DILocation(line: 991, column: 20, scope: !100, inlinedAt: !101)
!104 = !DILocation(line: 992, column: 36, scope: !100, inlinedAt: !101)
!105 = !DILocation(line: 992, column: 17, scope: !100, inlinedAt: !101)
!106 = !DILocation(line: 992, column: 11, scope: !100, inlinedAt: !101)
!107 = !DILocation(line: 993, column: 43, scope: !100, inlinedAt: !101)
!108 = !DILocation(line: 993, column: 10, scope: !100, inlinedAt: !101)
!109 = !DILocation(line: 1020, column: 14, scope: !95, inlinedAt: !96)
!110 = !DILocation(line: 79, column: 32, scope: !40)
!111 = !DILocation(line: 1018, column: 9, scope: !95, inlinedAt: !112)
!112 = distinct !DILocation(line: 80, column: 34, scope: !40)
!113 = !DILocation(line: 171, column: 37, scope: !98, inlinedAt: !114)
!114 = distinct !DILocation(line: 990, column: 14, scope: !100, inlinedAt: !115)
!115 = distinct !DILocation(line: 1019, column: 11, scope: !95, inlinedAt: !112)
!116 = !DILocation(line: 171, column: 10, scope: !98, inlinedAt: !114)
!117 = !DILocation(line: 991, column: 20, scope: !100, inlinedAt: !115)
!118 = !DILocation(line: 992, column: 36, scope: !100, inlinedAt: !115)
!119 = !DILocation(line: 992, column: 17, scope: !100, inlinedAt: !115)
!120 = !DILocation(line: 992, column: 11, scope: !100, inlinedAt: !115)
!121 = !DILocation(line: 993, column: 43, scope: !100, inlinedAt: !115)
!122 = !DILocation(line: 993, column: 10, scope: !100, inlinedAt: !115)
!123 = !DILocation(line: 1020, column: 14, scope: !95, inlinedAt: !112)
!124 = !DILocation(line: 80, column: 32, scope: !40)
!125 = !DILocation(line: 82, column: 34, scope: !40)
!126 = !DILocation(line: 82, column: 9, scope: !40)
!127 = !DILocation(line: 90, column: 34, scope: !40)
!128 = !DILocation(line: 75, column: 10, scope: !129, inlinedAt: !131)
!129 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !130, file: !130, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!130 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!131 = distinct !DILocation(line: 984, column: 9, scope: !132, inlinedAt: !134)
!132 = distinct !DISubprogram(name: "__float2half", scope: !133, file: !133, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!133 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!134 = distinct !DILocation(line: 133, column: 53, scope: !135, inlinedAt: !136)
!135 = distinct !DISubprogram(name: "__half", scope: !133, file: !133, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!136 = distinct !DILocation(line: 96, column: 34, scope: !40)
!137 = !DILocation(line: 96, column: 31, scope: !40)
!138 = !DILocation(line: 107, column: 36, scope: !40)
!139 = !DILocation(line: 117, column: 52, scope: !40)
!140 = !DILocation(line: 75, column: 10, scope: !129, inlinedAt: !141)
!141 = distinct !DILocation(line: 984, column: 9, scope: !132, inlinedAt: !142)
!142 = distinct !DILocation(line: 133, column: 53, scope: !135, inlinedAt: !143)
!143 = distinct !DILocation(line: 117, column: 44, scope: !40)
!144 = !DILocation(line: 117, column: 41, scope: !40)
!145 = !DILocation(line: 68, column: 3, scope: !66, inlinedAt: !146)
!146 = distinct !DILocation(line: 192, column: 3, scope: !69, inlinedAt: !147)
!147 = distinct !DILocation(line: 127, column: 3, scope: !40)
!148 = !DILocation(line: 135, column: 133, scope: !40)
!149 = !DILocation(line: 135, column: 207, scope: !40)
!150 = !DILocation(line: 135, column: 78, scope: !40)
!151 = !DILocation(line: 135, column: 220, scope: !40)
!152 = !DILocation(line: 0, scope: !40)
!153 = !DILocation(line: 69, column: 3, scope: !66, inlinedAt: !146)
!154 = !DILocation(line: 70, column: 3, scope: !66, inlinedAt: !146)
!155 = !DILocation(line: 130, column: 168, scope: !40)
!156 = !DILocation(line: 130, column: 197, scope: !40)
!157 = !DILocation(line: 130, column: 117, scope: !40)
!158 = !DILocation(line: 130, column: 203, scope: !40)
!159 = !DILocation(line: 130, column: 40, scope: !40)
!160 = !DILocation(line: 130, column: 246, scope: !40)
!161 = !DILocation(line: 130, column: 132, scope: !40)
!162 = !DILocation(line: 68, column: 3, scope: !66, inlinedAt: !163)
!163 = distinct !DILocation(line: 192, column: 3, scope: !69, inlinedAt: !164)
!164 = distinct !DILocation(line: 132, column: 3, scope: !40)
!165 = !DILocation(line: 69, column: 3, scope: !66, inlinedAt: !163)
!166 = !DILocation(line: 70, column: 3, scope: !66, inlinedAt: !163)
!167 = !DILocation(line: 139, column: 22, scope: !40)
!168 = !DILocation(line: 139, column: 178, scope: !40)
!169 = !{i32 1, i32 -1, i32 -1, i32 -1}
!170 = !DILocation(line: 141, column: 1, scope: !40)
