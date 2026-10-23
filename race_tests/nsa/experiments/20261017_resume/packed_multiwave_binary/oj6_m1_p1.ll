; ModuleID = 'experiments/20261017_resume/packed_multiwave_binary/oj6_m1_p1.bc'
source_filename = "/tmp/tmpvmxf9wxh/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 !dbg !40 {
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
  %cmp20 = icmp ult i32 %19, 32
  br i1 %cmp20, label %land.rhs, label %if.else366, !dbg !49

land.rhs:                                         ; preds = %entry
  %mul21 = shl nuw nsw i32 %19, 5, !dbg !50
  %cmp23.not = icmp ugt i32 %mul21, %1, !dbg !51
  br i1 %cmp23.not, label %if.else366, label %for.cond24.preheader, !dbg !52

for.cond24.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul30 = shl nuw nsw i64 %conv, 18
  %20 = shl nuw nsw i32 %19, 13
  %mul32 = zext nneg i32 %20 to i64
  %add33 = or disjoint i64 %mul30, %mul32
  %21 = shl nuw nsw i32 %2, 3
  %mul42 = zext nneg i32 %21 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul42, !dbg !53
  %gep = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add33, !dbg !54
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %gep, align 16, !dbg !55
  %k.sroa.4.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep, i64 8, !dbg !55
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.gep.sroa_idx, align 8, !dbg !55
  %add36.1 = or disjoint i64 %add33, 1024, !dbg !56
  %gep.1 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36.1, !dbg !54
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !55
  %k.sroa.10.32.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.1, i64 8, !dbg !55
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.1.sroa_idx, align 8, !dbg !55
  %add36.2 = or disjoint i64 %add33, 2048, !dbg !56
  %gep.2 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36.2, !dbg !54
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16, !dbg !55
  %k.sroa.16.64.gep.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.2, i64 8, !dbg !55
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.2.sroa_idx, align 8, !dbg !55
  %add36.3 = or disjoint i64 %add33, 3072, !dbg !56
  %gep.3 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36.3, !dbg !54
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16, !dbg !55
  %k.sroa.22.96.gep.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.3, i64 8, !dbg !55
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.3.sroa_idx, align 8, !dbg !55
  %add39.4 = or disjoint i64 %add33, 512, !dbg !57
  %gep.4 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.4, !dbg !54
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16, !dbg !55
  %k.sroa.7.16.gep.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.4, i64 8, !dbg !55
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.4.sroa_idx, align 8, !dbg !55
  %add39.5 = or disjoint i64 %add33, 1536, !dbg !57
  %gep.5 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.5, !dbg !54
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16, !dbg !55
  %k.sroa.13.48.gep.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.5, i64 8, !dbg !55
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.5.sroa_idx, align 8, !dbg !55
  %add39.6 = or disjoint i64 %add33, 2560, !dbg !57
  %gep.6 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.6, !dbg !54
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16, !dbg !55
  %k.sroa.19.80.gep.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.6, i64 8, !dbg !55
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.6.sroa_idx, align 8, !dbg !55
  %add39.7 = or disjoint i64 %add33, 3584, !dbg !57
  %gep.7 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.7, !dbg !54
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16, !dbg !55
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.7, i64 8, !dbg !55
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8, !dbg !55
  %and71 = lshr i32 %2, 1
  %shr72 = and i32 %and71, 15
  %shr75 = lshr i32 %2, 5
  %add69 = and i32 %mul10, 3972
  %xor = xor i32 %shr75, %shr72, !dbg !58
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add69, !dbg !59
  %add.ptr84.idx = shl nuw nsw i32 %xor, 4, !dbg !59
  %add.ptr84 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr84.idx, !dbg !59
  store i64 %4, ptr addrspace(3) %add.ptr84, align 8, !dbg !60
  %add76.1 = add nuw nsw i32 %shr75, 2, !dbg !61
  %xor.1 = xor i32 %add76.1, %shr72, !dbg !58
  %23 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 512, !dbg !59
  %add.ptr84.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !59
  %add.ptr84.1 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 %add.ptr84.idx.1, !dbg !59
  store i64 %6, ptr addrspace(3) %add.ptr84.1, align 8, !dbg !60
  %add76.2 = add nuw nsw i32 %shr75, 4, !dbg !61
  %xor.2 = xor i32 %add76.2, %shr72, !dbg !58
  %24 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 1024, !dbg !59
  %add.ptr84.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !59
  %add.ptr84.2 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr84.idx.2, !dbg !59
  store i64 %8, ptr addrspace(3) %add.ptr84.2, align 8, !dbg !60
  %add76.3 = add nuw nsw i32 %shr75, 6, !dbg !61
  %xor.3 = xor i32 %add76.3, %shr72, !dbg !58
  %25 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 1536, !dbg !59
  %add.ptr84.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !59
  %add.ptr84.3 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr84.idx.3, !dbg !59
  store i64 %10, ptr addrspace(3) %add.ptr84.3, align 8, !dbg !60
  %add76.4 = add nuw nsw i32 %shr75, 8, !dbg !61
  %xor.4 = xor i32 %add76.4, %shr72, !dbg !58
  %26 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 2048, !dbg !59
  %add.ptr84.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !59
  %add.ptr84.4 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr84.idx.4, !dbg !59
  store i64 %12, ptr addrspace(3) %add.ptr84.4, align 8, !dbg !60
  %add76.5 = add nuw nsw i32 %shr75, 10, !dbg !61
  %xor.5 = xor i32 %add76.5, %shr72, !dbg !58
  %27 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 2560, !dbg !59
  %add.ptr84.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !59
  %add.ptr84.5 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr84.idx.5, !dbg !59
  store i64 %14, ptr addrspace(3) %add.ptr84.5, align 8, !dbg !60
  %add76.6 = add nuw nsw i32 %shr75, 12, !dbg !61
  %xor.6 = xor i32 %add76.6, %shr72, !dbg !58
  %28 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 3072, !dbg !59
  %add.ptr84.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !59
  %add.ptr84.6 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr84.idx.6, !dbg !59
  store i64 %16, ptr addrspace(3) %add.ptr84.6, align 8, !dbg !60
  %add76.7 = add nuw nsw i32 %shr75, 14, !dbg !61
  %xor.7 = xor i32 %add76.7, %shr72, !dbg !58
  %29 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 3584, !dbg !59
  %add.ptr84.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !59
  %add.ptr84.7 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr84.idx.7, !dbg !59
  store i64 %18, ptr addrspace(3) %add.ptr84.7, align 8, !dbg !60
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !68
  fence syncscope("warp") acquire, !dbg !69
  %and94 = shl nuw nsw i32 %2, 7
  %mul95 = and i32 %and94, 1920
  %shr98 = lshr i32 %2, 4
  %and101 = and i32 %2, 15
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul95
  %xor102 = xor i32 %shr98, %and101, !dbg !70
  %add.ptr106.idx = shl nuw nsw i32 %xor102, 4, !dbg !71
  %add.ptr106 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx, !dbg !71
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106, align 16, !dbg !72
  %q.sroa.4.0.add.ptr106.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106, i32 8, !dbg !72
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr106.sroa_idx, align 8, !dbg !72
  %add99.1 = add nuw nsw i32 %shr98, 4, !dbg !73
  %xor102.1 = xor i32 %add99.1, %and101, !dbg !70
  %add.ptr106.idx.1 = shl nuw nsw i32 %xor102.1, 4, !dbg !71
  %add.ptr106.1 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx.1, !dbg !71
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106.1, align 16, !dbg !72
  %q.sroa.7.16.add.ptr106.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106.1, i32 8, !dbg !72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr106.1.sroa_idx, align 8, !dbg !72
  %add99.2 = add nuw nsw i32 %shr98, 8, !dbg !73
  %xor102.2 = xor i32 %add99.2, %and101, !dbg !70
  %add.ptr106.idx.2 = shl nuw nsw i32 %xor102.2, 4, !dbg !71
  %add.ptr106.2 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx.2, !dbg !71
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106.2, align 16, !dbg !72
  %q.sroa.10.32.add.ptr106.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106.2, i32 8, !dbg !72
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr106.2.sroa_idx, align 8, !dbg !72
  %add99.3 = add nuw nsw i32 %shr98, 12, !dbg !73
  %xor102.3 = xor i32 %add99.3, %and101, !dbg !70
  %add.ptr106.idx.3 = shl nuw nsw i32 %xor102.3, 4, !dbg !71
  %add.ptr106.3 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx.3, !dbg !71
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106.3, align 16, !dbg !72
  %q.sroa.13.48.add.ptr106.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106.3, i32 8, !dbg !72
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr106.3.sroa_idx, align 8, !dbg !72
  %31 = lshr i32 %2, 2
  %mul127 = and i32 %31, 252
  %add124 = add nuw nsw i32 %mul21, %mul127
  %cmp132.not = icmp ugt i32 %add124, %1, !dbg !74
  %spec.select = select i1 %cmp132.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !76
  %cmp132.not.1.not = icmp ult i32 %add124, %1, !dbg !74
  %spec.select.1 = select i1 %cmp132.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !75
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !76
  %add128.2 = or disjoint i32 %add124, 2, !dbg !77
  %cmp132.not.2 = icmp ugt i32 %add128.2, %1, !dbg !74
  %spec.select.2 = select i1 %cmp132.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !76
  %add128.3 = or disjoint i32 %add124, 3, !dbg !77
  %cmp132.not.3 = icmp ugt i32 %add128.3, %1, !dbg !74
  %spec.select.3 = select i1 %cmp132.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !76
  %add130.4 = add nuw nsw i32 %add124, 16, !dbg !78
  %cmp132.not.4 = icmp ugt i32 %add130.4, %1, !dbg !74
  %spec.select.4 = select i1 %cmp132.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !76
  %add130.5 = add nuw nsw i32 %add124, 17, !dbg !78
  %cmp132.not.5 = icmp ugt i32 %add130.5, %1, !dbg !74
  %spec.select.5 = select i1 %cmp132.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1, !dbg !76
  %add130.6 = add nuw nsw i32 %add124, 18, !dbg !78
  %cmp132.not.6 = icmp ugt i32 %add130.6, %1, !dbg !74
  %spec.select.6 = select i1 %cmp132.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2, !dbg !76
  %add130.7 = add nuw nsw i32 %add124, 19, !dbg !78
  %cmp132.not.7 = icmp ugt i32 %add130.7, %1, !dbg !74
  %spec.select.7 = select i1 %cmp132.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3, !dbg !76
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !79, !call_argsrelate !80
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !79, !call_argsrelate !80
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %32), !dbg !79, !call_argsrelate !80
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %33), !dbg !79, !call_argsrelate !80
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %34), !dbg !79, !call_argsrelate !80
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %35), !dbg !79, !call_argsrelate !80
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %36), !dbg !79, !call_argsrelate !80
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %37), !dbg !79, !call_argsrelate !80
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %38), !dbg !79, !call_argsrelate !80
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %39), !dbg !79, !call_argsrelate !80
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %40), !dbg !79, !call_argsrelate !80
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %41), !dbg !79, !call_argsrelate !80
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %42), !dbg !79, !call_argsrelate !80
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %43), !dbg !79, !call_argsrelate !80
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %44), !dbg !79, !call_argsrelate !80
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %45), !dbg !79, !call_argsrelate !80
  %add198 = or disjoint i64 %mul30, %mul42
  %add189 = or disjoint i64 %add198, %mul32
  %invariant.gep590 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !81
  %48 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add189, !dbg !82
  %add206.1 = or disjoint i64 %add189, 4, !dbg !83
  %49 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.1, !dbg !82
  %add202.2 = add nuw nsw i64 %add189, 512, !dbg !84
  %50 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.2, !dbg !82
  %add206.3 = or disjoint i64 %add202.2, 4, !dbg !83
  %51 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.3, !dbg !82
  %add202.4 = add nuw nsw i64 %add189, 1024, !dbg !84
  %52 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.4, !dbg !82
  %add206.5 = or disjoint i64 %add202.4, 4, !dbg !83
  %53 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.5, !dbg !82
  %add202.6 = add nuw nsw i64 %add189, 1536, !dbg !84
  %54 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.6, !dbg !82
  %add206.7 = or disjoint i64 %add202.6, 4, !dbg !83
  %55 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.7, !dbg !82
  %56 = load <4 x half>, ptr addrspace(4) %48, align 2, !dbg !85, !tbaa !86
  %57 = load <4 x half>, ptr addrspace(4) %49, align 2, !dbg !85, !tbaa !86
  %58 = load <4 x half>, ptr addrspace(4) %50, align 2, !dbg !85, !tbaa !86
  %59 = load <4 x half>, ptr addrspace(4) %51, align 2, !dbg !85, !tbaa !86
  %60 = load <4 x half>, ptr addrspace(4) %52, align 2, !dbg !85, !tbaa !86
  %61 = load <4 x half>, ptr addrspace(4) %53, align 2, !dbg !85, !tbaa !86
  %62 = load <4 x half>, ptr addrspace(4) %54, align 2, !dbg !85, !tbaa !86
  %63 = load <4 x half>, ptr addrspace(4) %55, align 2, !dbg !85, !tbaa !86
  %add193.32 = add nuw nsw i64 %add189, 2048, !dbg !87
  %64 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add193.32, !dbg !82
  %add206.33 = or disjoint i64 %add193.32, 4, !dbg !83
  %65 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.33, !dbg !82
  %add202.34 = add nuw nsw i64 %add189, 2560, !dbg !84
  %66 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.34, !dbg !82
  %add206.35 = or disjoint i64 %add202.34, 4, !dbg !83
  %67 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.35, !dbg !82
  %add202.36 = add nuw nsw i64 %add189, 3072, !dbg !84
  %68 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.36, !dbg !82
  %add206.37 = or disjoint i64 %add202.36, 4, !dbg !83
  %69 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.37, !dbg !82
  %add202.38 = add nuw nsw i64 %add189, 3584, !dbg !84
  %70 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.38, !dbg !82
  %add206.39 = or disjoint i64 %add202.38, 4, !dbg !83
  %71 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.39, !dbg !82
  %72 = load <4 x half>, ptr addrspace(4) %64, align 2, !dbg !85, !tbaa !86
  %73 = load <4 x half>, ptr addrspace(4) %65, align 2, !dbg !85, !tbaa !86
  %74 = load <4 x half>, ptr addrspace(4) %66, align 2, !dbg !85, !tbaa !86
  %75 = load <4 x half>, ptr addrspace(4) %67, align 2, !dbg !85, !tbaa !86
  %76 = load <4 x half>, ptr addrspace(4) %68, align 2, !dbg !85, !tbaa !86
  %77 = load <4 x half>, ptr addrspace(4) %69, align 2, !dbg !85, !tbaa !86
  %78 = load <4 x half>, ptr addrspace(4) %70, align 2, !dbg !85, !tbaa !86
  %79 = load <4 x half>, ptr addrspace(4) %71, align 2, !dbg !85, !tbaa !86
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !88
  %mul232 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !89
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul232, float 1.500000e+01), !dbg !90
  %cmp.i.i = fcmp contract olt float %80, -1.260000e+02, !dbg !94
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573 = fadd contract float %80, %cond.i.i, !dbg !94
  %81 = tail call contract float @llvm.exp2.f32(float %add.i.i573), !dbg !94
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i = fmul contract float %cond2.i.i, %81, !dbg !94
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1, !dbg !88
  %mul232.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !89
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul232.1, float 1.500000e+01), !dbg !90
  %cmp.i.i.1 = fcmp contract olt float %82, -1.260000e+02, !dbg !94
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573.1 = fadd contract float %82, %cond.i.i.1, !dbg !94
  %83 = tail call contract float @llvm.exp2.f32(float %add.i.i573.1), !dbg !94
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %83, !dbg !94
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2, !dbg !88
  %mul232.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !89
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul232.2, float 1.500000e+01), !dbg !90
  %cmp.i.i.2 = fcmp contract olt float %84, -1.260000e+02, !dbg !94
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573.2 = fadd contract float %84, %cond.i.i.2, !dbg !94
  %85 = tail call contract float @llvm.exp2.f32(float %add.i.i573.2), !dbg !94
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %85, !dbg !94
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3, !dbg !88
  %mul232.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !89
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul232.3, float 1.500000e+01), !dbg !90
  %cmp.i.i.3 = fcmp contract olt float %86, -1.260000e+02, !dbg !94
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573.3 = fadd contract float %86, %cond.i.i.3, !dbg !94
  %87 = tail call contract float @llvm.exp2.f32(float %add.i.i573.3), !dbg !94
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %87, !dbg !94
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %47, i64 0, !dbg !88
  %mul232.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !89
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul232.4, float 1.500000e+01), !dbg !90
  %cmp.i.i.4 = fcmp contract olt float %88, -1.260000e+02, !dbg !94
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573.4 = fadd contract float %88, %cond.i.i.4, !dbg !94
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i573.4), !dbg !94
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %89, !dbg !94
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %47, i64 1, !dbg !88
  %mul232.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !89
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul232.5, float 1.500000e+01), !dbg !90
  %cmp.i.i.5 = fcmp contract olt float %90, -1.260000e+02, !dbg !94
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573.5 = fadd contract float %90, %cond.i.i.5, !dbg !94
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i573.5), !dbg !94
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %91, !dbg !94
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %47, i64 2, !dbg !88
  %mul232.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !89
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul232.6, float 1.500000e+01), !dbg !90
  %cmp.i.i.6 = fcmp contract olt float %92, -1.260000e+02, !dbg !94
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573.6 = fadd contract float %92, %cond.i.i.6, !dbg !94
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i573.6), !dbg !94
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %93, !dbg !94
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %47, i64 3, !dbg !88
  %mul232.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !89
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul232.7, float 1.500000e+01), !dbg !90
  %cmp.i.i.7 = fcmp contract olt float %94, -1.260000e+02, !dbg !94
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !94
  %add.i.i573.7 = fadd contract float %94, %cond.i.i.7, !dbg !94
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i573.7), !dbg !94
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !94
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %95, !dbg !94
  %add252 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !97
  %add252.1 = fadd contract float %add252, %mul.i.i.4, !dbg !97
  %add252.2 = fadd contract float %add252.1, %mul.i.i.1, !dbg !97
  %add252.3 = fadd contract float %add252.2, %mul.i.i.5, !dbg !97
  %add252.4 = fadd contract float %add252.3, %mul.i.i.2, !dbg !97
  %add252.5 = fadd contract float %add252.4, %mul.i.i.6, !dbg !97
  %add252.6 = fadd contract float %add252.5, %mul.i.i.3, !dbg !97
  %add252.7 = fadd contract float %add252.6, %mul.i.i.7, !dbg !97
  %96 = bitcast float %add252.7 to i32, !dbg !98
  %97 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !109
  %98 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %97) #11, !dbg !114
  %xor.i.i = xor i32 %98, 32, !dbg !115
  %99 = and i32 %98, -64, !dbg !116
  %and.i.i = add nsw i32 %99, 64, !dbg !116
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !117
  %cond.i.i574 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %98, !dbg !118
  %shl.i.i = shl i32 %cond.i.i574, 2, !dbg !119
  %100 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %96), !dbg !120
  %101 = bitcast i32 %100 to float, !dbg !121
  %add.i = fadd contract float %add252.7, %101, !dbg !122
  %102 = bitcast float %add.i to i32, !dbg !125
  %103 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !132
  %104 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %103) #11, !dbg !135
  %xor.i.i575 = xor i32 %104, 16, !dbg !136
  %105 = and i32 %104, -64, !dbg !137
  %and.i.i576 = add nsw i32 %105, 64, !dbg !137
  %cmp.not.i.i577 = icmp slt i32 %xor.i.i575, %and.i.i576, !dbg !138
  %cond.i.i578 = select i1 %cmp.not.i.i577, i32 %xor.i.i575, i32 %104, !dbg !139
  %shl.i.i579 = shl i32 %cond.i.i578, 2, !dbg !140
  %106 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i579, i32 %102), !dbg !141
  %107 = bitcast i32 %106 to float, !dbg !142
  %add.i.i = fadd contract float %add.i, %107, !dbg !143
  %cmp261 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !145
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !146
  %condval_1.0 = select i1 %cmp261, float %div, float 0.000000e+00, !dbg !146
  %mul274 = fmul contract float %condval_1.0, %mul.i.i, !dbg !147
  %mul274.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !147
  %mul274.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !147
  %mul274.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !147
  %mul274.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !147
  %mul274.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !147
  %mul274.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !147
  %mul274.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !147
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274), !dbg !148
  %109 = insertelement <4 x i16> poison, i16 %108, i64 0, !dbg !157
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.1), !dbg !148
  %111 = insertelement <4 x i16> %109, i16 %110, i64 1, !dbg !157
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.2), !dbg !148
  %113 = insertelement <4 x i16> %111, i16 %112, i64 2, !dbg !157
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.3), !dbg !148
  %115 = insertelement <4 x i16> %113, i16 %114, i64 3, !dbg !157
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %115 to <4 x half>, !dbg !157
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.4), !dbg !148
  %117 = insertelement <4 x i16> poison, i16 %116, i64 0, !dbg !157
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.5), !dbg !148
  %119 = insertelement <4 x i16> %117, i16 %118, i64 1, !dbg !157
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.6), !dbg !148
  %121 = insertelement <4 x i16> %119, i16 %120, i64 2, !dbg !157
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.7), !dbg !148
  %123 = insertelement <4 x i16> %121, i16 %122, i64 3, !dbg !157
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %123 to <4 x half>, !dbg !157
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %57, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %58, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %59, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %62, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %63, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !158, !call_argsrelate !80
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %124), !dbg !158, !call_argsrelate !80
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %125), !dbg !158, !call_argsrelate !80
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %126), !dbg !158, !call_argsrelate !80
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %127), !dbg !158, !call_argsrelate !80
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %128), !dbg !158, !call_argsrelate !80
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %129), !dbg !158, !call_argsrelate !80
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %78, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %130), !dbg !158, !call_argsrelate !80
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %79, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %131), !dbg !158, !call_argsrelate !80
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %132, i64 0, !dbg !159
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !160
  %output_reg.sroa.0.0.insert.ext = zext i16 %140 to i64, !dbg !164
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %132, i64 1, !dbg !159
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !160
  %output_reg.sroa.0.2.insert.ext = zext i16 %141 to i64, !dbg !164
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !164
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !164
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %132, i64 2, !dbg !159
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !160
  %output_reg.sroa.0.4.insert.ext = zext i16 %142 to i64, !dbg !164
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !164
  %output_reg.sroa.0.4.insert.insert649 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !164
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %132, i64 3, !dbg !159
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !160
  %output_reg.sroa.0.6.insert.ext = zext i16 %143 to i64, !dbg !164
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !164
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert649, %output_reg.sroa.0.6.insert.shift, !dbg !164
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %133, i64 0, !dbg !159
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !160
  %output_reg.sroa.9.8.insert.ext = zext i16 %144 to i64, !dbg !164
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %133, i64 1, !dbg !159
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !160
  %output_reg.sroa.9.10.insert.ext = zext i16 %145 to i64, !dbg !164
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16, !dbg !164
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext, !dbg !164
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %133, i64 2, !dbg !159
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !160
  %output_reg.sroa.9.12.insert.ext = zext i16 %146 to i64, !dbg !164
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32, !dbg !164
  %output_reg.sroa.9.12.insert.insert655 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift, !dbg !164
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %133, i64 3, !dbg !159
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !160
  %output_reg.sroa.9.14.insert.ext = zext i16 %147 to i64, !dbg !164
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48, !dbg !164
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert655, %output_reg.sroa.9.14.insert.shift, !dbg !164
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %134, i64 0, !dbg !159
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !160
  %output_reg.sroa.16.16.insert.ext = zext i16 %148 to i64, !dbg !164
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %134, i64 1, !dbg !159
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !160
  %output_reg.sroa.16.18.insert.ext = zext i16 %149 to i64, !dbg !164
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16, !dbg !164
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext, !dbg !164
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %134, i64 2, !dbg !159
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !160
  %output_reg.sroa.16.20.insert.ext = zext i16 %150 to i64, !dbg !164
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32, !dbg !164
  %output_reg.sroa.16.20.insert.insert661 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift, !dbg !164
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %134, i64 3, !dbg !159
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !160
  %output_reg.sroa.16.22.insert.ext = zext i16 %151 to i64, !dbg !164
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48, !dbg !164
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert661, %output_reg.sroa.16.22.insert.shift, !dbg !164
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %135, i64 0, !dbg !159
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !160
  %output_reg.sroa.23.24.insert.ext = zext i16 %152 to i64, !dbg !164
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %135, i64 1, !dbg !159
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !160
  %output_reg.sroa.23.26.insert.ext = zext i16 %153 to i64, !dbg !164
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16, !dbg !164
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext, !dbg !164
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %135, i64 2, !dbg !159
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !160
  %output_reg.sroa.23.28.insert.ext = zext i16 %154 to i64, !dbg !164
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32, !dbg !164
  %output_reg.sroa.23.28.insert.insert667 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift, !dbg !164
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %135, i64 3, !dbg !159
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !160
  %output_reg.sroa.23.30.insert.ext = zext i16 %155 to i64, !dbg !164
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48, !dbg !164
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert667, %output_reg.sroa.23.30.insert.shift, !dbg !164
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %136, i64 0, !dbg !159
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !160
  %output_reg.sroa.30.32.insert.ext = zext i16 %156 to i64, !dbg !164
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %136, i64 1, !dbg !159
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !160
  %output_reg.sroa.30.34.insert.ext = zext i16 %157 to i64, !dbg !164
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16, !dbg !164
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext, !dbg !164
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %136, i64 2, !dbg !159
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !160
  %output_reg.sroa.30.36.insert.ext = zext i16 %158 to i64, !dbg !164
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32, !dbg !164
  %output_reg.sroa.30.36.insert.insert673 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift, !dbg !164
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %136, i64 3, !dbg !159
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !160
  %output_reg.sroa.30.38.insert.ext = zext i16 %159 to i64, !dbg !164
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48, !dbg !164
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert673, %output_reg.sroa.30.38.insert.shift, !dbg !164
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %137, i64 0, !dbg !159
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !160
  %output_reg.sroa.37.40.insert.ext = zext i16 %160 to i64, !dbg !164
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %137, i64 1, !dbg !159
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !160
  %output_reg.sroa.37.42.insert.ext = zext i16 %161 to i64, !dbg !164
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16, !dbg !164
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext, !dbg !164
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %137, i64 2, !dbg !159
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !160
  %output_reg.sroa.37.44.insert.ext = zext i16 %162 to i64, !dbg !164
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32, !dbg !164
  %output_reg.sroa.37.44.insert.insert679 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift, !dbg !164
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %137, i64 3, !dbg !159
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !160
  %output_reg.sroa.37.46.insert.ext = zext i16 %163 to i64, !dbg !164
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48, !dbg !164
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert679, %output_reg.sroa.37.46.insert.shift, !dbg !164
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %138, i64 0, !dbg !159
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !160
  %output_reg.sroa.44.48.insert.ext = zext i16 %164 to i64, !dbg !164
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %138, i64 1, !dbg !159
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !160
  %output_reg.sroa.44.50.insert.ext = zext i16 %165 to i64, !dbg !164
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16, !dbg !164
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext, !dbg !164
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %138, i64 2, !dbg !159
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !160
  %output_reg.sroa.44.52.insert.ext = zext i16 %166 to i64, !dbg !164
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32, !dbg !164
  %output_reg.sroa.44.52.insert.insert685 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift, !dbg !164
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %138, i64 3, !dbg !159
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !160
  %output_reg.sroa.44.54.insert.ext = zext i16 %167 to i64, !dbg !164
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48, !dbg !164
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert685, %output_reg.sroa.44.54.insert.shift, !dbg !164
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %139, i64 0, !dbg !159
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !160
  %output_reg.sroa.51.56.insert.ext = zext i16 %168 to i64, !dbg !164
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %139, i64 1, !dbg !159
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !160
  %output_reg.sroa.51.58.insert.ext = zext i16 %169 to i64, !dbg !164
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16, !dbg !164
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext, !dbg !164
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %139, i64 2, !dbg !159
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !160
  %output_reg.sroa.51.60.insert.ext = zext i16 %170 to i64, !dbg !164
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32, !dbg !164
  %output_reg.sroa.51.60.insert.insert691 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift, !dbg !164
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %139, i64 3, !dbg !159
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !160
  %output_reg.sroa.51.62.insert.ext = zext i16 %171 to i64, !dbg !164
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48, !dbg !164
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert691, %output_reg.sroa.51.62.insert.shift, !dbg !164
  br label %if.end388, !dbg !165

if.else366:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre862 = and i32 %.pre, 1920
  %.pre863 = lshr i32 %2, 5
  %.pre864 = and i32 %2, 15
  %.pre865 = lshr i32 %2, 2
  %.pre866 = add nuw nsw i32 %.pre863, 2, !dbg !168
  %.pre867 = add nuw nsw i32 %.pre863, 4, !dbg !168
  %.pre868 = add nuw nsw i32 %.pre863, 6, !dbg !168
  %.pre869 = add nuw nsw i32 %.pre863, 8, !dbg !168
  %.pre870 = add nuw nsw i32 %.pre863, 10, !dbg !168
  %.pre871 = add nuw nsw i32 %.pre863, 12, !dbg !168
  %.pre872 = add nuw nsw i32 %.pre863, 14, !dbg !168
  %.pre873 = shl nuw nsw i32 %2, 3
  %.pre875 = lshr i32 %2, 4
  %.pre876 = xor i32 %.pre875, %.pre864, !dbg !169
  %.pre877 = shl nuw nsw i32 %.pre876, 4, !dbg !170
  %.pre878 = add nuw nsw i32 %.pre875, 4, !dbg !171
  %.pre879 = xor i32 %.pre878, %.pre864, !dbg !169
  %.pre880 = shl nuw nsw i32 %.pre879, 4, !dbg !170
  %.pre881 = add nuw nsw i32 %.pre875, 8, !dbg !171
  %.pre882 = xor i32 %.pre881, %.pre864, !dbg !169
  %.pre883 = shl nuw nsw i32 %.pre882, 4, !dbg !170
  %.pre884 = add nuw nsw i32 %.pre875, 12, !dbg !171
  %.pre885 = xor i32 %.pre884, %.pre864, !dbg !169
  %.pre886 = shl nuw nsw i32 %.pre885, 4, !dbg !170
  br label %if.end388, !dbg !165

if.end388:                                        ; preds = %for.cond24.preheader, %if.else366
  %add.ptr438.idx.3.pre-phi = phi i32 [ %add.ptr106.idx.3, %for.cond24.preheader ], [ %.pre886, %if.else366 ], !dbg !170
  %add.ptr438.idx.2.pre-phi = phi i32 [ %add.ptr106.idx.2, %for.cond24.preheader ], [ %.pre883, %if.else366 ], !dbg !170
  %add.ptr438.idx.1.pre-phi = phi i32 [ %add.ptr106.idx.1, %for.cond24.preheader ], [ %.pre880, %if.else366 ], !dbg !170
  %add.ptr438.idx.pre-phi = phi i32 [ %add.ptr106.idx, %for.cond24.preheader ], [ %.pre877, %if.else366 ], !dbg !170
  %.pre-phi874 = phi i32 [ %21, %for.cond24.preheader ], [ %.pre873, %if.else366 ]
  %add403.7.pre-phi = phi i32 [ %add76.7, %for.cond24.preheader ], [ %.pre872, %if.else366 ], !dbg !168
  %add403.6.pre-phi = phi i32 [ %add76.6, %for.cond24.preheader ], [ %.pre871, %if.else366 ], !dbg !168
  %add403.5.pre-phi = phi i32 [ %add76.5, %for.cond24.preheader ], [ %.pre870, %if.else366 ], !dbg !168
  %add403.4.pre-phi = phi i32 [ %add76.4, %for.cond24.preheader ], [ %.pre869, %if.else366 ], !dbg !168
  %add403.3.pre-phi = phi i32 [ %add76.3, %for.cond24.preheader ], [ %.pre868, %if.else366 ], !dbg !168
  %add403.2.pre-phi = phi i32 [ %add76.2, %for.cond24.preheader ], [ %.pre867, %if.else366 ], !dbg !168
  %add403.1.pre-phi = phi i32 [ %add76.1, %for.cond24.preheader ], [ %.pre866, %if.else366 ], !dbg !168
  %.pre-phi = phi i32 [ %31, %for.cond24.preheader ], [ %.pre865, %if.else366 ]
  %and405.pre-phi = phi i32 [ %and101, %for.cond24.preheader ], [ %.pre864, %if.else366 ]
  %shr402.pre-phi = phi i32 [ %shr75, %for.cond24.preheader ], [ %.pre863, %if.else366 ]
  %mul399.pre-phi = phi i32 [ %mul95, %for.cond24.preheader ], [ %.pre862, %if.else366 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ], !dbg !172
  fence syncscope("warp") release, !dbg !165
  tail call void @llvm.mxc.barrier.warp(), !dbg !173
  fence syncscope("warp") acquire, !dbg !174
  %mul412 = and i32 %.pre-phi, 4
  %xor406 = xor i32 %shr402.pre-phi, %and405.pre-phi, !dbg !175
  %mul407 = shl nuw nsw i32 %xor406, 3, !dbg !176
  %add408 = add nuw nsw i32 %mul407, %mul399.pre-phi, !dbg !177
  %add413 = or disjoint i32 %add408, %mul412, !dbg !178
  %add.ptr415 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413, !dbg !179
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr415, align 8, !dbg !180
  %xor406.1 = xor i32 %add403.1.pre-phi, %and405.pre-phi, !dbg !175
  %mul407.1 = shl nuw nsw i32 %xor406.1, 3, !dbg !176
  %add408.1 = add nuw nsw i32 %mul407.1, %mul399.pre-phi, !dbg !177
  %add413.1 = or disjoint i32 %add408.1, %mul412, !dbg !178
  %add.ptr415.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.1, !dbg !179
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr415.1, align 8, !dbg !180
  %xor406.2 = xor i32 %add403.2.pre-phi, %and405.pre-phi, !dbg !175
  %mul407.2 = shl nuw nsw i32 %xor406.2, 3, !dbg !176
  %add408.2 = add nuw nsw i32 %mul407.2, %mul399.pre-phi, !dbg !177
  %add413.2 = or disjoint i32 %add408.2, %mul412, !dbg !178
  %add.ptr415.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.2, !dbg !179
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr415.2, align 8, !dbg !180
  %xor406.3 = xor i32 %add403.3.pre-phi, %and405.pre-phi, !dbg !175
  %mul407.3 = shl nuw nsw i32 %xor406.3, 3, !dbg !176
  %add408.3 = add nuw nsw i32 %mul407.3, %mul399.pre-phi, !dbg !177
  %add413.3 = or disjoint i32 %add408.3, %mul412, !dbg !178
  %add.ptr415.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.3, !dbg !179
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr415.3, align 8, !dbg !180
  %xor406.4 = xor i32 %add403.4.pre-phi, %and405.pre-phi, !dbg !175
  %mul407.4 = shl nuw nsw i32 %xor406.4, 3, !dbg !176
  %add408.4 = add nuw nsw i32 %mul407.4, %mul399.pre-phi, !dbg !177
  %add413.4 = or disjoint i32 %add408.4, %mul412, !dbg !178
  %add.ptr415.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.4, !dbg !179
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr415.4, align 8, !dbg !180
  %xor406.5 = xor i32 %add403.5.pre-phi, %and405.pre-phi, !dbg !175
  %mul407.5 = shl nuw nsw i32 %xor406.5, 3, !dbg !176
  %add408.5 = add nuw nsw i32 %mul407.5, %mul399.pre-phi, !dbg !177
  %add413.5 = or disjoint i32 %add408.5, %mul412, !dbg !178
  %add.ptr415.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.5, !dbg !179
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr415.5, align 8, !dbg !180
  %xor406.6 = xor i32 %add403.6.pre-phi, %and405.pre-phi, !dbg !175
  %mul407.6 = shl nuw nsw i32 %xor406.6, 3, !dbg !176
  %add408.6 = add nuw nsw i32 %mul407.6, %mul399.pre-phi, !dbg !177
  %add413.6 = or disjoint i32 %add408.6, %mul412, !dbg !178
  %add.ptr415.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.6, !dbg !179
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr415.6, align 8, !dbg !180
  %xor406.7 = xor i32 %add403.7.pre-phi, %and405.pre-phi, !dbg !175
  %mul407.7 = shl nuw nsw i32 %xor406.7, 3, !dbg !176
  %add408.7 = add nuw nsw i32 %mul407.7, %mul399.pre-phi, !dbg !177
  %add413.7 = or disjoint i32 %add408.7, %mul412, !dbg !178
  %add.ptr415.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.7, !dbg !179
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr415.7, align 8, !dbg !180
  fence syncscope("warp") release, !dbg !181
  tail call void @llvm.mxc.barrier.warp(), !dbg !184
  fence syncscope("warp") acquire, !dbg !185
  %mul426 = and i32 %.pre-phi874, 8064
  %invariant.gep606 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul426, !dbg !186
  %add.ptr438 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 %add.ptr438.idx.pre-phi, !dbg !170
  %gep607.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 1024, !dbg !170
  %add.ptr438.1 = getelementptr inbounds i8, ptr addrspace(3) %gep607.1, i32 %add.ptr438.idx.1.pre-phi, !dbg !170
  %gep607.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 2048, !dbg !170
  %add.ptr438.2 = getelementptr inbounds i8, ptr addrspace(3) %gep607.2, i32 %add.ptr438.idx.2.pre-phi, !dbg !170
  %gep607.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 3072, !dbg !170
  %add.ptr438.3 = getelementptr inbounds i8, ptr addrspace(3) %gep607.3, i32 %add.ptr438.idx.3.pre-phi, !dbg !170
  %add460 = add nuw nsw i32 %add, %.pre-phi874
  %172 = zext nneg i32 %add460 to i64, !dbg !187
  %add.ptr465 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438, i64 16, i1 false), !dbg !189, !call_argsrelate !190
  %173 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172, !dbg !188
  %add.ptr465.1 = getelementptr inbounds i8, ptr addrspace(1) %173, i64 1024, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438.1, i64 16, i1 false), !dbg !189, !call_argsrelate !190
  %174 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172, !dbg !188
  %add.ptr465.2 = getelementptr inbounds i8, ptr addrspace(1) %174, i64 2048, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438.2, i64 16, i1 false), !dbg !189, !call_argsrelate !190
  %175 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172, !dbg !188
  %add.ptr465.3 = getelementptr inbounds i8, ptr addrspace(1) %175, i64 3072, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438.3, i64 16, i1 false), !dbg !189, !call_argsrelate !190
  ret void, !dbg !191
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
!1 = !DIFile(filename: "/tmp/tmpvmxf9wxh/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpvmxf9wxh/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 25, column: 48, scope: !40)
!45 = !DILocation(line: 25, column: 34, scope: !40)
!46 = !DILocation(line: 27, column: 43, scope: !40)
!47 = !DILocation(line: 27, column: 51, scope: !40)
!48 = !DILocation(line: 27, column: 15, scope: !40)
!49 = !DILocation(line: 28, column: 31, scope: !40)
!50 = !DILocation(line: 28, column: 59, scope: !40)
!51 = !DILocation(line: 28, column: 65, scope: !40)
!52 = !DILocation(line: 29, column: 7, scope: !40)
!53 = !DILocation(line: 31, column: 5, scope: !40)
!54 = !DILocation(line: 32, column: 81, scope: !40)
!55 = !DILocation(line: 32, column: 60, scope: !40)
!56 = !DILocation(line: 32, column: 174, scope: !40)
!57 = !DILocation(line: 32, column: 225, scope: !40)
!58 = !DILocation(line: 36, column: 133, scope: !40)
!59 = !DILocation(line: 36, column: 42, scope: !40)
!60 = !DILocation(line: 36, column: 217, scope: !40)
!61 = !DILocation(line: 36, column: 146, scope: !40)
!62 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !65)
!63 = distinct !DISubprogram(name: "__barrier_warp", scope: !64, file: !64, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!64 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!65 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !67)
!66 = distinct !DISubprogram(name: "__syncwarp", scope: !64, file: !64, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!67 = distinct !DILocation(line: 38, column: 5, scope: !40)
!68 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !65)
!69 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !65)
!70 = !DILocation(line: 41, column: 150, scope: !40)
!71 = !DILocation(line: 41, column: 69, scope: !40)
!72 = !DILocation(line: 41, column: 32, scope: !40)
!73 = !DILocation(line: 41, column: 121, scope: !40)
!74 = !DILocation(line: 46, column: 114, scope: !40)
!75 = !DILocation(line: 46, column: 11, scope: !40)
!76 = !DILocation(line: 51, column: 19, scope: !40)
!77 = !DILocation(line: 46, column: 66, scope: !40)
!78 = !DILocation(line: 46, column: 101, scope: !40)
!79 = !DILocation(line: 57, column: 37, scope: !40)
!80 = !{i32 2, i32 -1, i32 -1}
!81 = !DILocation(line: 65, column: 5, scope: !40)
!82 = !DILocation(line: 66, column: 72, scope: !40)
!83 = !DILocation(line: 66, column: 341, scope: !40)
!84 = !DILocation(line: 66, column: 293, scope: !40)
!85 = !DILocation(line: 66, column: 70, scope: !40)
!86 = !{!26, !26, i64 0}
!87 = !DILocation(line: 66, column: 175, scope: !40)
!88 = !DILocation(line: 70, column: 32, scope: !40)
!89 = !DILocation(line: 70, column: 44, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "min", scope: !92, file: !92, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!93 = distinct !DILocation(line: 70, column: 27, scope: !40)
!94 = !DILocation(line: 285, column: 49, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "exp2f", scope: !92, file: !92, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 70, column: 21, scope: !40)
!97 = !DILocation(line: 75, column: 28, scope: !40)
!98 = !DILocation(line: 1018, column: 9, scope: !99, inlinedAt: !100)
!99 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = distinct !DILocation(line: 396, column: 10, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !102, file: !102, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!103 = distinct !DILocation(line: 129, column: 24, scope: !104, inlinedAt: !106)
!104 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !105, file: !105, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!106 = distinct !DILocation(line: 101, column: 14, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "run<float>", scope: !105, file: !105, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 77, column: 16, scope: !40)
!109 = !DILocation(line: 171, column: 37, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__lane_id", scope: !64, file: !64, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 990, column: 14, scope: !112, inlinedAt: !113)
!112 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!113 = distinct !DILocation(line: 1019, column: 11, scope: !99, inlinedAt: !100)
!114 = !DILocation(line: 171, column: 10, scope: !110, inlinedAt: !111)
!115 = !DILocation(line: 991, column: 20, scope: !112, inlinedAt: !113)
!116 = !DILocation(line: 992, column: 36, scope: !112, inlinedAt: !113)
!117 = !DILocation(line: 992, column: 17, scope: !112, inlinedAt: !113)
!118 = !DILocation(line: 992, column: 11, scope: !112, inlinedAt: !113)
!119 = !DILocation(line: 993, column: 43, scope: !112, inlinedAt: !113)
!120 = !DILocation(line: 993, column: 10, scope: !112, inlinedAt: !113)
!121 = !DILocation(line: 1020, column: 14, scope: !99, inlinedAt: !100)
!122 = !DILocation(line: 25, column: 14, scope: !123, inlinedAt: !124)
!123 = distinct !DISubprogram(name: "operator()<float>", scope: !105, file: !105, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!124 = distinct !DILocation(line: 129, column: 11, scope: !104, inlinedAt: !106)
!125 = !DILocation(line: 1018, column: 9, scope: !99, inlinedAt: !126)
!126 = distinct !DILocation(line: 396, column: 10, scope: !101, inlinedAt: !127)
!127 = distinct !DILocation(line: 129, column: 24, scope: !128, inlinedAt: !129)
!128 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !105, file: !105, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!129 = distinct !DILocation(line: 101, column: 14, scope: !130, inlinedAt: !131)
!130 = distinct !DISubprogram(name: "run<float>", scope: !105, file: !105, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!131 = distinct !DILocation(line: 134, column: 14, scope: !104, inlinedAt: !106)
!132 = !DILocation(line: 171, column: 37, scope: !110, inlinedAt: !133)
!133 = distinct !DILocation(line: 990, column: 14, scope: !112, inlinedAt: !134)
!134 = distinct !DILocation(line: 1019, column: 11, scope: !99, inlinedAt: !126)
!135 = !DILocation(line: 171, column: 10, scope: !110, inlinedAt: !133)
!136 = !DILocation(line: 991, column: 20, scope: !112, inlinedAt: !134)
!137 = !DILocation(line: 992, column: 36, scope: !112, inlinedAt: !134)
!138 = !DILocation(line: 992, column: 17, scope: !112, inlinedAt: !134)
!139 = !DILocation(line: 992, column: 11, scope: !112, inlinedAt: !134)
!140 = !DILocation(line: 993, column: 43, scope: !112, inlinedAt: !134)
!141 = !DILocation(line: 993, column: 10, scope: !112, inlinedAt: !134)
!142 = !DILocation(line: 1020, column: 14, scope: !99, inlinedAt: !126)
!143 = !DILocation(line: 25, column: 14, scope: !123, inlinedAt: !144)
!144 = distinct !DILocation(line: 129, column: 11, scope: !128, inlinedAt: !129)
!145 = !DILocation(line: 79, column: 34, scope: !40)
!146 = !DILocation(line: 79, column: 9, scope: !40)
!147 = !DILocation(line: 87, column: 34, scope: !40)
!148 = !DILocation(line: 75, column: 10, scope: !149, inlinedAt: !151)
!149 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !150, file: !150, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!151 = distinct !DILocation(line: 984, column: 9, scope: !152, inlinedAt: !154)
!152 = distinct !DISubprogram(name: "__float2half", scope: !153, file: !153, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!153 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!154 = distinct !DILocation(line: 133, column: 53, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "__half", scope: !153, file: !153, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!156 = distinct !DILocation(line: 93, column: 34, scope: !40)
!157 = !DILocation(line: 93, column: 31, scope: !40)
!158 = !DILocation(line: 104, column: 36, scope: !40)
!159 = !DILocation(line: 114, column: 52, scope: !40)
!160 = !DILocation(line: 75, column: 10, scope: !149, inlinedAt: !161)
!161 = distinct !DILocation(line: 984, column: 9, scope: !152, inlinedAt: !162)
!162 = distinct !DILocation(line: 133, column: 53, scope: !155, inlinedAt: !163)
!163 = distinct !DILocation(line: 114, column: 44, scope: !40)
!164 = !DILocation(line: 114, column: 41, scope: !40)
!165 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !166)
!166 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !167)
!167 = distinct !DILocation(line: 124, column: 3, scope: !40)
!168 = !DILocation(line: 127, column: 94, scope: !40)
!169 = !DILocation(line: 132, column: 163, scope: !40)
!170 = !DILocation(line: 132, column: 79, scope: !40)
!171 = !DILocation(line: 132, column: 177, scope: !40)
!172 = !DILocation(line: 0, scope: !40)
!173 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !166)
!174 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !166)
!175 = !DILocation(line: 127, column: 123, scope: !40)
!176 = !DILocation(line: 127, column: 152, scope: !40)
!177 = !DILocation(line: 127, column: 78, scope: !40)
!178 = !DILocation(line: 127, column: 158, scope: !40)
!179 = !DILocation(line: 127, column: 40, scope: !40)
!180 = !DILocation(line: 127, column: 201, scope: !40)
!181 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !182)
!182 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !183)
!183 = distinct !DILocation(line: 129, column: 3, scope: !40)
!184 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !182)
!185 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !182)
!186 = !DILocation(line: 131, column: 8, scope: !40)
!187 = !DILocation(line: 135, column: 3, scope: !40)
!188 = !DILocation(line: 136, column: 22, scope: !40)
!189 = !DILocation(line: 136, column: 132, scope: !40)
!190 = !{i32 1, i32 -1, i32 -1, i32 -1}
!191 = !DILocation(line: 138, column: 1, scope: !40)
