; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj6_m2_p1.bc'
source_filename = "/tmp/tmpb_w3isz1/tvm_kernels.maca"
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
  br i1 %cmp20, label %land.rhs, label %if.else346, !dbg !49

land.rhs:                                         ; preds = %entry
  %mul21 = shl nuw nsw i32 %19, 5, !dbg !50
  %cmp23.not = icmp ugt i32 %mul21, %1, !dbg !51
  br i1 %cmp23.not, label %if.else346, label %for.cond24.preheader, !dbg !52

for.cond24.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul30 = shl nuw nsw i64 %conv, 18
  %20 = shl nuw nsw i32 %19, 13
  %mul32 = zext nneg i32 %20 to i64
  %21 = shl nuw nsw i32 %2, 3
  %mul39 = zext nneg i32 %21 to i64
  %add33 = or disjoint i64 %mul30, %mul39
  %add36 = or disjoint i64 %add33, %mul32
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add36, !dbg !53
  %23 = load <4 x half>, ptr addrspace(4) %22, align 2, !dbg !54, !tbaa !55
  %add40.4 = or disjoint i64 %add36, 4, !dbg !56
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add40.4, !dbg !53
  %25 = load <4 x half>, ptr addrspace(4) %24, align 2, !dbg !54, !tbaa !55
  %arrayidx43.8 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1024, !dbg !53
  %26 = load <4 x half>, ptr addrspace(4) %arrayidx43.8, align 2, !dbg !54, !tbaa !55
  %arrayidx43.12 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024, !dbg !53
  %27 = load <4 x half>, ptr addrspace(4) %arrayidx43.12, align 2, !dbg !54, !tbaa !55
  %arrayidx43.16 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 2048, !dbg !53
  %28 = load <4 x half>, ptr addrspace(4) %arrayidx43.16, align 2, !dbg !54, !tbaa !55
  %arrayidx43.20 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2048, !dbg !53
  %29 = load <4 x half>, ptr addrspace(4) %arrayidx43.20, align 2, !dbg !54, !tbaa !55
  %arrayidx43.24 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 3072, !dbg !53
  %30 = load <4 x half>, ptr addrspace(4) %arrayidx43.24, align 2, !dbg !54, !tbaa !55
  %arrayidx43.28 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 3072, !dbg !53
  %31 = load <4 x half>, ptr addrspace(4) %arrayidx43.28, align 2, !dbg !54, !tbaa !55
  %arrayidx43.32 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 4096, !dbg !53
  %32 = load <4 x half>, ptr addrspace(4) %arrayidx43.32, align 2, !dbg !54, !tbaa !55
  %arrayidx43.36 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 4096, !dbg !53
  %33 = load <4 x half>, ptr addrspace(4) %arrayidx43.36, align 2, !dbg !54, !tbaa !55
  %arrayidx43.40 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 5120, !dbg !53
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx43.40, align 2, !dbg !54, !tbaa !55
  %arrayidx43.44 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 5120, !dbg !53
  %35 = load <4 x half>, ptr addrspace(4) %arrayidx43.44, align 2, !dbg !54, !tbaa !55
  %arrayidx43.48 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 6144, !dbg !53
  %36 = load <4 x half>, ptr addrspace(4) %arrayidx43.48, align 2, !dbg !54, !tbaa !55
  %arrayidx43.52 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 6144, !dbg !53
  %37 = load <4 x half>, ptr addrspace(4) %arrayidx43.52, align 2, !dbg !54, !tbaa !55
  %arrayidx43.56 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 7168, !dbg !53
  %38 = load <4 x half>, ptr addrspace(4) %arrayidx43.56, align 2, !dbg !54, !tbaa !55
  %arrayidx43.60 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 7168, !dbg !53
  %39 = load <4 x half>, ptr addrspace(4) %arrayidx43.60, align 2, !dbg !54, !tbaa !55
  %and65 = lshr i32 %2, 1
  %shr66 = and i32 %and65, 15
  %shr69 = lshr i32 %2, 5
  %add63 = and i32 %mul10, 3972
  %xor = xor i32 %shr69, %shr66, !dbg !57
  %40 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add63, !dbg !58
  %add.ptr78.idx = shl nuw nsw i32 %xor, 4, !dbg !58
  %add.ptr78 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr78.idx, !dbg !58
  store i64 %4, ptr addrspace(3) %add.ptr78, align 8, !dbg !59
  %add70.1 = add nuw nsw i32 %shr69, 2, !dbg !60
  %xor.1 = xor i32 %add70.1, %shr66, !dbg !57
  %41 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 512, !dbg !58
  %add.ptr78.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !58
  %add.ptr78.1 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %add.ptr78.idx.1, !dbg !58
  store i64 %6, ptr addrspace(3) %add.ptr78.1, align 8, !dbg !59
  %add70.2 = add nuw nsw i32 %shr69, 4, !dbg !60
  %xor.2 = xor i32 %add70.2, %shr66, !dbg !57
  %42 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 1024, !dbg !58
  %add.ptr78.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !58
  %add.ptr78.2 = getelementptr inbounds i8, ptr addrspace(3) %42, i32 %add.ptr78.idx.2, !dbg !58
  store i64 %8, ptr addrspace(3) %add.ptr78.2, align 8, !dbg !59
  %add70.3 = add nuw nsw i32 %shr69, 6, !dbg !60
  %xor.3 = xor i32 %add70.3, %shr66, !dbg !57
  %43 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 1536, !dbg !58
  %add.ptr78.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !58
  %add.ptr78.3 = getelementptr inbounds i8, ptr addrspace(3) %43, i32 %add.ptr78.idx.3, !dbg !58
  store i64 %10, ptr addrspace(3) %add.ptr78.3, align 8, !dbg !59
  %add70.4 = add nuw nsw i32 %shr69, 8, !dbg !60
  %xor.4 = xor i32 %add70.4, %shr66, !dbg !57
  %44 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 2048, !dbg !58
  %add.ptr78.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !58
  %add.ptr78.4 = getelementptr inbounds i8, ptr addrspace(3) %44, i32 %add.ptr78.idx.4, !dbg !58
  store i64 %12, ptr addrspace(3) %add.ptr78.4, align 8, !dbg !59
  %add70.5 = add nuw nsw i32 %shr69, 10, !dbg !60
  %xor.5 = xor i32 %add70.5, %shr66, !dbg !57
  %45 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 2560, !dbg !58
  %add.ptr78.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !58
  %add.ptr78.5 = getelementptr inbounds i8, ptr addrspace(3) %45, i32 %add.ptr78.idx.5, !dbg !58
  store i64 %14, ptr addrspace(3) %add.ptr78.5, align 8, !dbg !59
  %add70.6 = add nuw nsw i32 %shr69, 12, !dbg !60
  %xor.6 = xor i32 %add70.6, %shr66, !dbg !57
  %46 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 3072, !dbg !58
  %add.ptr78.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !58
  %add.ptr78.6 = getelementptr inbounds i8, ptr addrspace(3) %46, i32 %add.ptr78.idx.6, !dbg !58
  store i64 %16, ptr addrspace(3) %add.ptr78.6, align 8, !dbg !59
  %add70.7 = add nuw nsw i32 %shr69, 14, !dbg !60
  %xor.7 = xor i32 %add70.7, %shr66, !dbg !57
  %47 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 3584, !dbg !58
  %add.ptr78.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !58
  %add.ptr78.7 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr78.idx.7, !dbg !58
  store i64 %18, ptr addrspace(3) %add.ptr78.7, align 8, !dbg !59
  fence syncscope("warp") release, !dbg !61
  tail call void @llvm.mxc.barrier.warp(), !dbg !67
  fence syncscope("warp") acquire, !dbg !68
  %and88 = shl nuw nsw i32 %2, 7
  %mul89 = and i32 %and88, 1920
  %shr92 = lshr i32 %2, 4
  %and95 = and i32 %2, 15
  %48 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul89
  %xor96 = xor i32 %shr92, %and95, !dbg !69
  %add.ptr100.idx = shl nuw nsw i32 %xor96, 4, !dbg !70
  %add.ptr100 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx, !dbg !70
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100, align 16, !dbg !71
  %q.sroa.4.0.add.ptr100.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100, i32 8, !dbg !71
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr100.sroa_idx, align 8, !dbg !71
  %add93.1 = add nuw nsw i32 %shr92, 4, !dbg !72
  %xor96.1 = xor i32 %add93.1, %and95, !dbg !69
  %add.ptr100.idx.1 = shl nuw nsw i32 %xor96.1, 4, !dbg !70
  %add.ptr100.1 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx.1, !dbg !70
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100.1, align 16, !dbg !71
  %q.sroa.7.16.add.ptr100.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100.1, i32 8, !dbg !71
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr100.1.sroa_idx, align 8, !dbg !71
  %add93.2 = add nuw nsw i32 %shr92, 8, !dbg !72
  %xor96.2 = xor i32 %add93.2, %and95, !dbg !69
  %add.ptr100.idx.2 = shl nuw nsw i32 %xor96.2, 4, !dbg !70
  %add.ptr100.2 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx.2, !dbg !70
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100.2, align 16, !dbg !71
  %q.sroa.10.32.add.ptr100.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100.2, i32 8, !dbg !71
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr100.2.sroa_idx, align 8, !dbg !71
  %add93.3 = add nuw nsw i32 %shr92, 12, !dbg !72
  %xor96.3 = xor i32 %add93.3, %and95, !dbg !69
  %add.ptr100.idx.3 = shl nuw nsw i32 %xor96.3, 4, !dbg !70
  %add.ptr100.3 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx.3, !dbg !70
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100.3, align 16, !dbg !71
  %q.sroa.13.48.add.ptr100.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100.3, i32 8, !dbg !71
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr100.3.sroa_idx, align 8, !dbg !71
  %49 = lshr i32 %2, 2
  %mul121 = and i32 %49, 252
  %add118 = add nuw nsw i32 %mul21, %mul121
  %cmp126.not = icmp ugt i32 %add118, %1, !dbg !73
  %spec.select = select i1 %cmp126.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !75
  %cmp126.not.1.not = icmp ult i32 %add118, %1, !dbg !73
  %spec.select.1 = select i1 %cmp126.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !75
  %add122.2 = or disjoint i32 %add118, 2, !dbg !76
  %cmp126.not.2 = icmp ugt i32 %add122.2, %1, !dbg !73
  %spec.select.2 = select i1 %cmp126.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !75
  %add122.3 = or disjoint i32 %add118, 3, !dbg !76
  %cmp126.not.3 = icmp ugt i32 %add122.3, %1, !dbg !73
  %spec.select.3 = select i1 %cmp126.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !75
  %add124.4 = add nuw nsw i32 %add118, 16, !dbg !77
  %cmp126.not.4 = icmp ugt i32 %add124.4, %1, !dbg !73
  %spec.select.4 = select i1 %cmp126.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !75
  %add124.5 = add nuw nsw i32 %add118, 17, !dbg !77
  %cmp126.not.5 = icmp ugt i32 %add124.5, %1, !dbg !73
  %spec.select.5 = select i1 %cmp126.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1, !dbg !75
  %add124.6 = add nuw nsw i32 %add118, 18, !dbg !77
  %cmp126.not.6 = icmp ugt i32 %add124.6, %1, !dbg !73
  %spec.select.6 = select i1 %cmp126.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2, !dbg !75
  %add124.7 = add nuw nsw i32 %add118, 19, !dbg !77
  %cmp126.not.7 = icmp ugt i32 %add124.7, %1, !dbg !73
  %spec.select.7 = select i1 %cmp126.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3, !dbg !75
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %23, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !78, !call_argsrelate !79
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !78, !call_argsrelate !79
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %25, <4 x half> %q.sroa.4.0.copyload, <4 x float> %50), !dbg !78, !call_argsrelate !79
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %q.sroa.4.0.copyload, <4 x float> %51), !dbg !78, !call_argsrelate !79
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %q.sroa.5.16.copyload, <4 x float> %52), !dbg !78, !call_argsrelate !79
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %q.sroa.5.16.copyload, <4 x float> %53), !dbg !78, !call_argsrelate !79
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %q.sroa.7.16.copyload, <4 x float> %54), !dbg !78, !call_argsrelate !79
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %q.sroa.7.16.copyload, <4 x float> %55), !dbg !78, !call_argsrelate !79
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %32, <4 x half> %q.sroa.8.32.copyload, <4 x float> %56), !dbg !78, !call_argsrelate !79
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %q.sroa.8.32.copyload, <4 x float> %57), !dbg !78, !call_argsrelate !79
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %q.sroa.10.32.copyload, <4 x float> %58), !dbg !78, !call_argsrelate !79
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %q.sroa.10.32.copyload, <4 x float> %59), !dbg !78, !call_argsrelate !79
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %q.sroa.11.48.copyload, <4 x float> %60), !dbg !78, !call_argsrelate !79
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %38, <4 x half> %q.sroa.11.48.copyload, <4 x float> %61), !dbg !78, !call_argsrelate !79
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %37, <4 x half> %q.sroa.13.48.copyload, <4 x float> %62), !dbg !78, !call_argsrelate !79
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %39, <4 x half> %q.sroa.13.48.copyload, <4 x float> %63), !dbg !78, !call_argsrelate !79
  %invariant.gep = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !80
  %66 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36, !dbg !81
  %67 = load <4 x half>, ptr addrspace(4) %66, align 2, !dbg !82, !tbaa !55
  %68 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add40.4, !dbg !81
  %69 = load <4 x half>, ptr addrspace(4) %68, align 2, !dbg !82, !tbaa !55
  %gep.8 = getelementptr i8, ptr addrspace(4) %66, i64 1024, !dbg !81
  %70 = load <4 x half>, ptr addrspace(4) %gep.8, align 2, !dbg !82, !tbaa !55
  %gep.12 = getelementptr i8, ptr addrspace(4) %68, i64 1024, !dbg !81
  %71 = load <4 x half>, ptr addrspace(4) %gep.12, align 2, !dbg !82, !tbaa !55
  %gep.16 = getelementptr i8, ptr addrspace(4) %66, i64 2048, !dbg !81
  %72 = load <4 x half>, ptr addrspace(4) %gep.16, align 2, !dbg !82, !tbaa !55
  %gep.20 = getelementptr i8, ptr addrspace(4) %68, i64 2048, !dbg !81
  %73 = load <4 x half>, ptr addrspace(4) %gep.20, align 2, !dbg !82, !tbaa !55
  %gep.24 = getelementptr i8, ptr addrspace(4) %66, i64 3072, !dbg !81
  %74 = load <4 x half>, ptr addrspace(4) %gep.24, align 2, !dbg !82, !tbaa !55
  %gep.28 = getelementptr i8, ptr addrspace(4) %68, i64 3072, !dbg !81
  %75 = load <4 x half>, ptr addrspace(4) %gep.28, align 2, !dbg !82, !tbaa !55
  %gep.32 = getelementptr i8, ptr addrspace(4) %66, i64 4096, !dbg !81
  %76 = load <4 x half>, ptr addrspace(4) %gep.32, align 2, !dbg !82, !tbaa !55
  %gep.36 = getelementptr i8, ptr addrspace(4) %68, i64 4096, !dbg !81
  %77 = load <4 x half>, ptr addrspace(4) %gep.36, align 2, !dbg !82, !tbaa !55
  %gep.40 = getelementptr i8, ptr addrspace(4) %66, i64 5120, !dbg !81
  %78 = load <4 x half>, ptr addrspace(4) %gep.40, align 2, !dbg !82, !tbaa !55
  %gep.44 = getelementptr i8, ptr addrspace(4) %68, i64 5120, !dbg !81
  %79 = load <4 x half>, ptr addrspace(4) %gep.44, align 2, !dbg !82, !tbaa !55
  %gep.48 = getelementptr i8, ptr addrspace(4) %66, i64 6144, !dbg !81
  %80 = load <4 x half>, ptr addrspace(4) %gep.48, align 2, !dbg !82, !tbaa !55
  %gep.52 = getelementptr i8, ptr addrspace(4) %68, i64 6144, !dbg !81
  %81 = load <4 x half>, ptr addrspace(4) %gep.52, align 2, !dbg !82, !tbaa !55
  %gep.56 = getelementptr i8, ptr addrspace(4) %66, i64 7168, !dbg !81
  %82 = load <4 x half>, ptr addrspace(4) %gep.56, align 2, !dbg !82, !tbaa !55
  %gep.60 = getelementptr i8, ptr addrspace(4) %68, i64 7168, !dbg !81
  %83 = load <4 x half>, ptr addrspace(4) %gep.60, align 2, !dbg !82, !tbaa !55
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %64, i64 0, !dbg !83
  %mul211 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !84
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul211, float 1.500000e+01), !dbg !85
  %cmp.i.i = fcmp contract olt float %84, -1.260000e+02, !dbg !89
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531 = fadd contract float %84, %cond.i.i, !dbg !89
  %85 = tail call contract float @llvm.exp2.f32(float %add.i.i531), !dbg !89
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i = fmul contract float %cond2.i.i, %85, !dbg !89
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %64, i64 1, !dbg !83
  %mul211.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !84
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul211.1, float 1.500000e+01), !dbg !85
  %cmp.i.i.1 = fcmp contract olt float %86, -1.260000e+02, !dbg !89
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531.1 = fadd contract float %86, %cond.i.i.1, !dbg !89
  %87 = tail call contract float @llvm.exp2.f32(float %add.i.i531.1), !dbg !89
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %87, !dbg !89
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %64, i64 2, !dbg !83
  %mul211.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !84
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul211.2, float 1.500000e+01), !dbg !85
  %cmp.i.i.2 = fcmp contract olt float %88, -1.260000e+02, !dbg !89
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531.2 = fadd contract float %88, %cond.i.i.2, !dbg !89
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i531.2), !dbg !89
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %89, !dbg !89
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %64, i64 3, !dbg !83
  %mul211.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !84
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul211.3, float 1.500000e+01), !dbg !85
  %cmp.i.i.3 = fcmp contract olt float %90, -1.260000e+02, !dbg !89
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531.3 = fadd contract float %90, %cond.i.i.3, !dbg !89
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i531.3), !dbg !89
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %91, !dbg !89
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %65, i64 0, !dbg !83
  %mul211.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !84
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul211.4, float 1.500000e+01), !dbg !85
  %cmp.i.i.4 = fcmp contract olt float %92, -1.260000e+02, !dbg !89
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531.4 = fadd contract float %92, %cond.i.i.4, !dbg !89
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i531.4), !dbg !89
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %93, !dbg !89
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %65, i64 1, !dbg !83
  %mul211.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !84
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul211.5, float 1.500000e+01), !dbg !85
  %cmp.i.i.5 = fcmp contract olt float %94, -1.260000e+02, !dbg !89
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531.5 = fadd contract float %94, %cond.i.i.5, !dbg !89
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i531.5), !dbg !89
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %95, !dbg !89
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %65, i64 2, !dbg !83
  %mul211.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !84
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul211.6, float 1.500000e+01), !dbg !85
  %cmp.i.i.6 = fcmp contract olt float %96, -1.260000e+02, !dbg !89
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531.6 = fadd contract float %96, %cond.i.i.6, !dbg !89
  %97 = tail call contract float @llvm.exp2.f32(float %add.i.i531.6), !dbg !89
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %97, !dbg !89
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %65, i64 3, !dbg !83
  %mul211.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !84
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul211.7, float 1.500000e+01), !dbg !85
  %cmp.i.i.7 = fcmp contract olt float %98, -1.260000e+02, !dbg !89
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i531.7 = fadd contract float %98, %cond.i.i.7, !dbg !89
  %99 = tail call contract float @llvm.exp2.f32(float %add.i.i531.7), !dbg !89
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %99, !dbg !89
  %add231 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !92
  %add231.1 = fadd contract float %add231, %mul.i.i.4, !dbg !92
  %add231.2 = fadd contract float %add231.1, %mul.i.i.1, !dbg !92
  %add231.3 = fadd contract float %add231.2, %mul.i.i.5, !dbg !92
  %add231.4 = fadd contract float %add231.3, %mul.i.i.2, !dbg !92
  %add231.5 = fadd contract float %add231.4, %mul.i.i.6, !dbg !92
  %add231.6 = fadd contract float %add231.5, %mul.i.i.3, !dbg !92
  %add231.7 = fadd contract float %add231.6, %mul.i.i.7, !dbg !92
  %100 = bitcast float %add231.7 to i32, !dbg !93
  %101 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !104
  %102 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %101) #11, !dbg !109
  %xor.i.i = xor i32 %102, 32, !dbg !110
  %103 = and i32 %102, -64, !dbg !111
  %and.i.i = add nsw i32 %103, 64, !dbg !111
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !112
  %cond.i.i532 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %102, !dbg !113
  %shl.i.i = shl i32 %cond.i.i532, 2, !dbg !114
  %104 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %100), !dbg !115
  %105 = bitcast i32 %104 to float, !dbg !116
  %add.i = fadd contract float %add231.7, %105, !dbg !117
  %106 = bitcast float %add.i to i32, !dbg !120
  %107 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !127
  %108 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %107) #11, !dbg !130
  %xor.i.i533 = xor i32 %108, 16, !dbg !131
  %109 = and i32 %108, -64, !dbg !132
  %and.i.i534 = add nsw i32 %109, 64, !dbg !132
  %cmp.not.i.i535 = icmp slt i32 %xor.i.i533, %and.i.i534, !dbg !133
  %cond.i.i536 = select i1 %cmp.not.i.i535, i32 %xor.i.i533, i32 %108, !dbg !134
  %shl.i.i537 = shl i32 %cond.i.i536, 2, !dbg !135
  %110 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i537, i32 %106), !dbg !136
  %111 = bitcast i32 %110 to float, !dbg !137
  %add.i.i = fadd contract float %add.i, %111, !dbg !138
  %cmp240 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !140
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !141
  %condval_1.0 = select i1 %cmp240, float %div, float 0.000000e+00, !dbg !141
  %mul253 = fmul contract float %condval_1.0, %mul.i.i, !dbg !142
  %mul253.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !142
  %mul253.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !142
  %mul253.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !142
  %mul253.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !142
  %mul253.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !142
  %mul253.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !142
  %mul253.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !142
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253), !dbg !143
  %113 = insertelement <4 x i16> poison, i16 %112, i64 0, !dbg !152
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.1), !dbg !143
  %115 = insertelement <4 x i16> %113, i16 %114, i64 1, !dbg !152
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.2), !dbg !143
  %117 = insertelement <4 x i16> %115, i16 %116, i64 2, !dbg !152
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.3), !dbg !143
  %119 = insertelement <4 x i16> %117, i16 %118, i64 3, !dbg !152
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %119 to <4 x half>, !dbg !152
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.4), !dbg !143
  %121 = insertelement <4 x i16> poison, i16 %120, i64 0, !dbg !152
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.5), !dbg !143
  %123 = insertelement <4 x i16> %121, i16 %122, i64 1, !dbg !152
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.6), !dbg !143
  %125 = insertelement <4 x i16> %123, i16 %124, i64 2, !dbg !152
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.7), !dbg !143
  %127 = insertelement <4 x i16> %125, i16 %126, i64 3, !dbg !152
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %127 to <4 x half>, !dbg !152
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %70, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %71, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %128), !dbg !153, !call_argsrelate !79
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %129), !dbg !153, !call_argsrelate !79
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %78, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %130), !dbg !153, !call_argsrelate !79
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %79, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %131), !dbg !153, !call_argsrelate !79
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %132), !dbg !153, !call_argsrelate !79
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %81, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %133), !dbg !153, !call_argsrelate !79
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %82, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %134), !dbg !153, !call_argsrelate !79
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %83, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %135), !dbg !153, !call_argsrelate !79
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %136, i64 0, !dbg !154
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !155
  %output_reg.sroa.0.0.insert.ext = zext i16 %144 to i64, !dbg !159
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %136, i64 1, !dbg !154
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !155
  %output_reg.sroa.0.2.insert.ext = zext i16 %145 to i64, !dbg !159
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !159
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !159
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %136, i64 2, !dbg !154
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !155
  %output_reg.sroa.0.4.insert.ext = zext i16 %146 to i64, !dbg !159
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !159
  %output_reg.sroa.0.4.insert.insert650 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !159
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %136, i64 3, !dbg !154
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !155
  %output_reg.sroa.0.6.insert.ext = zext i16 %147 to i64, !dbg !159
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !159
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert650, %output_reg.sroa.0.6.insert.shift, !dbg !159
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %137, i64 0, !dbg !154
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !155
  %output_reg.sroa.9.8.insert.ext = zext i16 %148 to i64, !dbg !159
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %137, i64 1, !dbg !154
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !155
  %output_reg.sroa.9.10.insert.ext = zext i16 %149 to i64, !dbg !159
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16, !dbg !159
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext, !dbg !159
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %137, i64 2, !dbg !154
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !155
  %output_reg.sroa.9.12.insert.ext = zext i16 %150 to i64, !dbg !159
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32, !dbg !159
  %output_reg.sroa.9.12.insert.insert656 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift, !dbg !159
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %137, i64 3, !dbg !154
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !155
  %output_reg.sroa.9.14.insert.ext = zext i16 %151 to i64, !dbg !159
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48, !dbg !159
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert656, %output_reg.sroa.9.14.insert.shift, !dbg !159
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %138, i64 0, !dbg !154
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !155
  %output_reg.sroa.16.16.insert.ext = zext i16 %152 to i64, !dbg !159
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %138, i64 1, !dbg !154
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !155
  %output_reg.sroa.16.18.insert.ext = zext i16 %153 to i64, !dbg !159
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16, !dbg !159
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext, !dbg !159
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %138, i64 2, !dbg !154
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !155
  %output_reg.sroa.16.20.insert.ext = zext i16 %154 to i64, !dbg !159
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32, !dbg !159
  %output_reg.sroa.16.20.insert.insert662 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift, !dbg !159
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %138, i64 3, !dbg !154
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !155
  %output_reg.sroa.16.22.insert.ext = zext i16 %155 to i64, !dbg !159
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48, !dbg !159
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert662, %output_reg.sroa.16.22.insert.shift, !dbg !159
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %139, i64 0, !dbg !154
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !155
  %output_reg.sroa.23.24.insert.ext = zext i16 %156 to i64, !dbg !159
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %139, i64 1, !dbg !154
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !155
  %output_reg.sroa.23.26.insert.ext = zext i16 %157 to i64, !dbg !159
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16, !dbg !159
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext, !dbg !159
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %139, i64 2, !dbg !154
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !155
  %output_reg.sroa.23.28.insert.ext = zext i16 %158 to i64, !dbg !159
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32, !dbg !159
  %output_reg.sroa.23.28.insert.insert668 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift, !dbg !159
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %139, i64 3, !dbg !154
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !155
  %output_reg.sroa.23.30.insert.ext = zext i16 %159 to i64, !dbg !159
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48, !dbg !159
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert668, %output_reg.sroa.23.30.insert.shift, !dbg !159
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %140, i64 0, !dbg !154
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !155
  %output_reg.sroa.30.32.insert.ext = zext i16 %160 to i64, !dbg !159
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %140, i64 1, !dbg !154
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !155
  %output_reg.sroa.30.34.insert.ext = zext i16 %161 to i64, !dbg !159
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16, !dbg !159
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext, !dbg !159
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %140, i64 2, !dbg !154
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !155
  %output_reg.sroa.30.36.insert.ext = zext i16 %162 to i64, !dbg !159
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32, !dbg !159
  %output_reg.sroa.30.36.insert.insert674 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift, !dbg !159
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %140, i64 3, !dbg !154
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !155
  %output_reg.sroa.30.38.insert.ext = zext i16 %163 to i64, !dbg !159
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48, !dbg !159
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert674, %output_reg.sroa.30.38.insert.shift, !dbg !159
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %141, i64 0, !dbg !154
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !155
  %output_reg.sroa.37.40.insert.ext = zext i16 %164 to i64, !dbg !159
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %141, i64 1, !dbg !154
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !155
  %output_reg.sroa.37.42.insert.ext = zext i16 %165 to i64, !dbg !159
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16, !dbg !159
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext, !dbg !159
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %141, i64 2, !dbg !154
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !155
  %output_reg.sroa.37.44.insert.ext = zext i16 %166 to i64, !dbg !159
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32, !dbg !159
  %output_reg.sroa.37.44.insert.insert680 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift, !dbg !159
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %141, i64 3, !dbg !154
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !155
  %output_reg.sroa.37.46.insert.ext = zext i16 %167 to i64, !dbg !159
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48, !dbg !159
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert680, %output_reg.sroa.37.46.insert.shift, !dbg !159
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %142, i64 0, !dbg !154
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !155
  %output_reg.sroa.44.48.insert.ext = zext i16 %168 to i64, !dbg !159
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %142, i64 1, !dbg !154
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !155
  %output_reg.sroa.44.50.insert.ext = zext i16 %169 to i64, !dbg !159
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16, !dbg !159
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext, !dbg !159
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %142, i64 2, !dbg !154
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !155
  %output_reg.sroa.44.52.insert.ext = zext i16 %170 to i64, !dbg !159
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32, !dbg !159
  %output_reg.sroa.44.52.insert.insert686 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift, !dbg !159
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %142, i64 3, !dbg !154
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !155
  %output_reg.sroa.44.54.insert.ext = zext i16 %171 to i64, !dbg !159
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48, !dbg !159
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert686, %output_reg.sroa.44.54.insert.shift, !dbg !159
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %143, i64 0, !dbg !154
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !155
  %output_reg.sroa.51.56.insert.ext = zext i16 %172 to i64, !dbg !159
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %143, i64 1, !dbg !154
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !155
  %output_reg.sroa.51.58.insert.ext = zext i16 %173 to i64, !dbg !159
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16, !dbg !159
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext, !dbg !159
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %143, i64 2, !dbg !154
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !155
  %output_reg.sroa.51.60.insert.ext = zext i16 %174 to i64, !dbg !159
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32, !dbg !159
  %output_reg.sroa.51.60.insert.insert692 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift, !dbg !159
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %143, i64 3, !dbg !154
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !155
  %output_reg.sroa.51.62.insert.ext = zext i16 %175 to i64, !dbg !159
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48, !dbg !159
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert692, %output_reg.sroa.51.62.insert.shift, !dbg !159
  br label %if.end369, !dbg !160

if.else346:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre831 = and i32 %.pre, 1920
  %.pre832 = lshr i32 %2, 5
  %.pre833 = and i32 %2, 15
  %.pre834 = lshr i32 %2, 2
  %.pre835 = add nuw nsw i32 %.pre832, 2, !dbg !163
  %.pre836 = add nuw nsw i32 %.pre832, 4, !dbg !163
  %.pre837 = add nuw nsw i32 %.pre832, 6, !dbg !163
  %.pre838 = add nuw nsw i32 %.pre832, 8, !dbg !163
  %.pre839 = add nuw nsw i32 %.pre832, 10, !dbg !163
  %.pre840 = add nuw nsw i32 %.pre832, 12, !dbg !163
  %.pre841 = add nuw nsw i32 %.pre832, 14, !dbg !163
  %.pre842 = shl nuw nsw i32 %2, 3
  %.pre844 = lshr i32 %2, 4
  %.pre845 = xor i32 %.pre844, %.pre833, !dbg !164
  %.pre846 = shl nuw nsw i32 %.pre845, 4, !dbg !165
  br label %if.end369, !dbg !160

if.end369:                                        ; preds = %for.cond24.preheader, %if.else346
  %add.ptr419.idx.pre-phi = phi i32 [ %add.ptr100.idx, %for.cond24.preheader ], [ %.pre846, %if.else346 ], !dbg !165
  %shr413.pre-phi = phi i32 [ %shr92, %for.cond24.preheader ], [ %.pre844, %if.else346 ]
  %.pre-phi843 = phi i32 [ %21, %for.cond24.preheader ], [ %.pre842, %if.else346 ]
  %add384.7.pre-phi = phi i32 [ %add70.7, %for.cond24.preheader ], [ %.pre841, %if.else346 ], !dbg !163
  %add384.6.pre-phi = phi i32 [ %add70.6, %for.cond24.preheader ], [ %.pre840, %if.else346 ], !dbg !163
  %add384.5.pre-phi = phi i32 [ %add70.5, %for.cond24.preheader ], [ %.pre839, %if.else346 ], !dbg !163
  %add384.4.pre-phi = phi i32 [ %add70.4, %for.cond24.preheader ], [ %.pre838, %if.else346 ], !dbg !163
  %add384.3.pre-phi = phi i32 [ %add70.3, %for.cond24.preheader ], [ %.pre837, %if.else346 ], !dbg !163
  %add384.2.pre-phi = phi i32 [ %add70.2, %for.cond24.preheader ], [ %.pre836, %if.else346 ], !dbg !163
  %add384.1.pre-phi = phi i32 [ %add70.1, %for.cond24.preheader ], [ %.pre835, %if.else346 ], !dbg !163
  %.pre-phi = phi i32 [ %49, %for.cond24.preheader ], [ %.pre834, %if.else346 ]
  %and386.pre-phi = phi i32 [ %and95, %for.cond24.preheader ], [ %.pre833, %if.else346 ]
  %shr383.pre-phi = phi i32 [ %shr69, %for.cond24.preheader ], [ %.pre832, %if.else346 ]
  %mul380.pre-phi = phi i32 [ %mul89, %for.cond24.preheader ], [ %.pre831, %if.else346 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ], !dbg !166
  fence syncscope("warp") release, !dbg !160
  tail call void @llvm.mxc.barrier.warp(), !dbg !167
  fence syncscope("warp") acquire, !dbg !168
  %mul393 = and i32 %.pre-phi, 4
  %xor387 = xor i32 %shr383.pre-phi, %and386.pre-phi, !dbg !169
  %mul388 = shl nuw nsw i32 %xor387, 3, !dbg !170
  %add389 = add nuw nsw i32 %mul388, %mul380.pre-phi, !dbg !171
  %add394 = or disjoint i32 %add389, %mul393, !dbg !172
  %add.ptr396 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394, !dbg !173
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr396, align 8, !dbg !174
  %xor387.1 = xor i32 %add384.1.pre-phi, %and386.pre-phi, !dbg !169
  %mul388.1 = shl nuw nsw i32 %xor387.1, 3, !dbg !170
  %add389.1 = add nuw nsw i32 %mul388.1, %mul380.pre-phi, !dbg !171
  %add394.1 = or disjoint i32 %add389.1, %mul393, !dbg !172
  %add.ptr396.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.1, !dbg !173
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr396.1, align 8, !dbg !174
  %xor387.2 = xor i32 %add384.2.pre-phi, %and386.pre-phi, !dbg !169
  %mul388.2 = shl nuw nsw i32 %xor387.2, 3, !dbg !170
  %add389.2 = add nuw nsw i32 %mul388.2, %mul380.pre-phi, !dbg !171
  %add394.2 = or disjoint i32 %add389.2, %mul393, !dbg !172
  %add.ptr396.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.2, !dbg !173
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr396.2, align 8, !dbg !174
  %xor387.3 = xor i32 %add384.3.pre-phi, %and386.pre-phi, !dbg !169
  %mul388.3 = shl nuw nsw i32 %xor387.3, 3, !dbg !170
  %add389.3 = add nuw nsw i32 %mul388.3, %mul380.pre-phi, !dbg !171
  %add394.3 = or disjoint i32 %add389.3, %mul393, !dbg !172
  %add.ptr396.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.3, !dbg !173
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr396.3, align 8, !dbg !174
  %xor387.4 = xor i32 %add384.4.pre-phi, %and386.pre-phi, !dbg !169
  %mul388.4 = shl nuw nsw i32 %xor387.4, 3, !dbg !170
  %add389.4 = add nuw nsw i32 %mul388.4, %mul380.pre-phi, !dbg !171
  %add394.4 = or disjoint i32 %add389.4, %mul393, !dbg !172
  %add.ptr396.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.4, !dbg !173
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr396.4, align 8, !dbg !174
  %xor387.5 = xor i32 %add384.5.pre-phi, %and386.pre-phi, !dbg !169
  %mul388.5 = shl nuw nsw i32 %xor387.5, 3, !dbg !170
  %add389.5 = add nuw nsw i32 %mul388.5, %mul380.pre-phi, !dbg !171
  %add394.5 = or disjoint i32 %add389.5, %mul393, !dbg !172
  %add.ptr396.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.5, !dbg !173
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr396.5, align 8, !dbg !174
  %xor387.6 = xor i32 %add384.6.pre-phi, %and386.pre-phi, !dbg !169
  %mul388.6 = shl nuw nsw i32 %xor387.6, 3, !dbg !170
  %add389.6 = add nuw nsw i32 %mul388.6, %mul380.pre-phi, !dbg !171
  %add394.6 = or disjoint i32 %add389.6, %mul393, !dbg !172
  %add.ptr396.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.6, !dbg !173
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr396.6, align 8, !dbg !174
  %xor387.7 = xor i32 %add384.7.pre-phi, %and386.pre-phi, !dbg !169
  %mul388.7 = shl nuw nsw i32 %xor387.7, 3, !dbg !170
  %add389.7 = add nuw nsw i32 %mul388.7, %mul380.pre-phi, !dbg !171
  %add394.7 = or disjoint i32 %add389.7, %mul393, !dbg !172
  %add.ptr396.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.7, !dbg !173
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr396.7, align 8, !dbg !174
  fence syncscope("warp") release, !dbg !175
  tail call void @llvm.mxc.barrier.warp(), !dbg !178
  fence syncscope("warp") acquire, !dbg !179
  %mul407 = and i32 %.pre-phi843, 8064
  %invariant.gep562 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul407, !dbg !180
  %add426 = add nuw nsw i32 %add, %.pre-phi843
  %176 = zext nneg i32 %add426 to i64, !dbg !181
  %add.ptr419 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 %add.ptr419.idx.pre-phi, !dbg !165
  %add.ptr431 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %177 = add nuw nsw i32 %shr413.pre-phi, 4, !dbg !186
  %xor415.1 = xor i32 %177, %and386.pre-phi, !dbg !164
  %gep563.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 1024, !dbg !165
  %add.ptr419.idx.1 = shl nuw nsw i32 %xor415.1, 4, !dbg !165
  %add.ptr419.1 = getelementptr inbounds i8, ptr addrspace(3) %gep563.1, i32 %add.ptr419.idx.1, !dbg !165
  %178 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176, !dbg !182
  %add.ptr431.1 = getelementptr inbounds i8, ptr addrspace(1) %178, i64 1024, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419.1, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %179 = add nuw nsw i32 %shr413.pre-phi, 8, !dbg !186
  %xor415.2 = xor i32 %179, %and386.pre-phi, !dbg !164
  %gep563.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 2048, !dbg !165
  %add.ptr419.idx.2 = shl nuw nsw i32 %xor415.2, 4, !dbg !165
  %add.ptr419.2 = getelementptr inbounds i8, ptr addrspace(3) %gep563.2, i32 %add.ptr419.idx.2, !dbg !165
  %180 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176, !dbg !182
  %add.ptr431.2 = getelementptr inbounds i8, ptr addrspace(1) %180, i64 2048, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419.2, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %narrow = add nuw nsw i32 %shr413.pre-phi, 12, !dbg !186
  %xor415.3 = xor i32 %narrow, %and386.pre-phi, !dbg !164
  %gep563.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 3072, !dbg !165
  %add.ptr419.idx.3 = shl nuw nsw i32 %xor415.3, 4, !dbg !165
  %add.ptr419.3 = getelementptr inbounds i8, ptr addrspace(3) %gep563.3, i32 %add.ptr419.idx.3, !dbg !165
  %181 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176, !dbg !182
  %add.ptr431.3 = getelementptr inbounds i8, ptr addrspace(1) %181, i64 3072, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419.3, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
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
!1 = !DIFile(filename: "/tmp/tmpb_w3isz1/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpb_w3isz1/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 23, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 48, scope: !40)
!45 = !DILocation(line: 24, column: 34, scope: !40)
!46 = !DILocation(line: 26, column: 43, scope: !40)
!47 = !DILocation(line: 26, column: 51, scope: !40)
!48 = !DILocation(line: 26, column: 15, scope: !40)
!49 = !DILocation(line: 27, column: 31, scope: !40)
!50 = !DILocation(line: 27, column: 59, scope: !40)
!51 = !DILocation(line: 27, column: 65, scope: !40)
!52 = !DILocation(line: 28, column: 7, scope: !40)
!53 = !DILocation(line: 31, column: 24, scope: !40)
!54 = !DILocation(line: 31, column: 16, scope: !40)
!55 = !{!26, !26, i64 0}
!56 = !DILocation(line: 31, column: 175, scope: !40)
!57 = !DILocation(line: 35, column: 133, scope: !40)
!58 = !DILocation(line: 35, column: 42, scope: !40)
!59 = !DILocation(line: 35, column: 217, scope: !40)
!60 = !DILocation(line: 35, column: 146, scope: !40)
!61 = !DILocation(line: 68, column: 3, scope: !62, inlinedAt: !64)
!62 = distinct !DISubprogram(name: "__barrier_warp", scope: !63, file: !63, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!63 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!64 = distinct !DILocation(line: 192, column: 3, scope: !65, inlinedAt: !66)
!65 = distinct !DISubprogram(name: "__syncwarp", scope: !63, file: !63, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!66 = distinct !DILocation(line: 37, column: 5, scope: !40)
!67 = !DILocation(line: 69, column: 3, scope: !62, inlinedAt: !64)
!68 = !DILocation(line: 70, column: 3, scope: !62, inlinedAt: !64)
!69 = !DILocation(line: 40, column: 150, scope: !40)
!70 = !DILocation(line: 40, column: 69, scope: !40)
!71 = !DILocation(line: 40, column: 32, scope: !40)
!72 = !DILocation(line: 40, column: 121, scope: !40)
!73 = !DILocation(line: 45, column: 114, scope: !40)
!74 = !DILocation(line: 45, column: 11, scope: !40)
!75 = !DILocation(line: 50, column: 19, scope: !40)
!76 = !DILocation(line: 45, column: 66, scope: !40)
!77 = !DILocation(line: 45, column: 101, scope: !40)
!78 = !DILocation(line: 56, column: 37, scope: !40)
!79 = !{i32 2, i32 -1, i32 -1}
!80 = !DILocation(line: 64, column: 5, scope: !40)
!81 = !DILocation(line: 65, column: 24, scope: !40)
!82 = !DILocation(line: 65, column: 16, scope: !40)
!83 = !DILocation(line: 69, column: 32, scope: !40)
!84 = !DILocation(line: 69, column: 44, scope: !40)
!85 = !DILocation(line: 354, column: 10, scope: !86, inlinedAt: !88)
!86 = distinct !DISubprogram(name: "min", scope: !87, file: !87, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!87 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!88 = distinct !DILocation(line: 69, column: 27, scope: !40)
!89 = !DILocation(line: 285, column: 49, scope: !90, inlinedAt: !91)
!90 = distinct !DISubprogram(name: "exp2f", scope: !87, file: !87, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = distinct !DILocation(line: 69, column: 21, scope: !40)
!92 = !DILocation(line: 74, column: 28, scope: !40)
!93 = !DILocation(line: 1018, column: 9, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !63, file: !63, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 396, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !97, file: !97, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!98 = distinct !DILocation(line: 129, column: 24, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !100, file: !100, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!101 = distinct !DILocation(line: 101, column: 14, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "run<float>", scope: !100, file: !100, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 76, column: 16, scope: !40)
!104 = !DILocation(line: 171, column: 37, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__lane_id", scope: !63, file: !63, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 990, column: 14, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !63, file: !63, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 1019, column: 11, scope: !94, inlinedAt: !95)
!109 = !DILocation(line: 171, column: 10, scope: !105, inlinedAt: !106)
!110 = !DILocation(line: 991, column: 20, scope: !107, inlinedAt: !108)
!111 = !DILocation(line: 992, column: 36, scope: !107, inlinedAt: !108)
!112 = !DILocation(line: 992, column: 17, scope: !107, inlinedAt: !108)
!113 = !DILocation(line: 992, column: 11, scope: !107, inlinedAt: !108)
!114 = !DILocation(line: 993, column: 43, scope: !107, inlinedAt: !108)
!115 = !DILocation(line: 993, column: 10, scope: !107, inlinedAt: !108)
!116 = !DILocation(line: 1020, column: 14, scope: !94, inlinedAt: !95)
!117 = !DILocation(line: 25, column: 14, scope: !118, inlinedAt: !119)
!118 = distinct !DISubprogram(name: "operator()<float>", scope: !100, file: !100, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!119 = distinct !DILocation(line: 129, column: 11, scope: !99, inlinedAt: !101)
!120 = !DILocation(line: 1018, column: 9, scope: !94, inlinedAt: !121)
!121 = distinct !DILocation(line: 396, column: 10, scope: !96, inlinedAt: !122)
!122 = distinct !DILocation(line: 129, column: 24, scope: !123, inlinedAt: !124)
!123 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !100, file: !100, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!124 = distinct !DILocation(line: 101, column: 14, scope: !125, inlinedAt: !126)
!125 = distinct !DISubprogram(name: "run<float>", scope: !100, file: !100, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!126 = distinct !DILocation(line: 134, column: 14, scope: !99, inlinedAt: !101)
!127 = !DILocation(line: 171, column: 37, scope: !105, inlinedAt: !128)
!128 = distinct !DILocation(line: 990, column: 14, scope: !107, inlinedAt: !129)
!129 = distinct !DILocation(line: 1019, column: 11, scope: !94, inlinedAt: !121)
!130 = !DILocation(line: 171, column: 10, scope: !105, inlinedAt: !128)
!131 = !DILocation(line: 991, column: 20, scope: !107, inlinedAt: !129)
!132 = !DILocation(line: 992, column: 36, scope: !107, inlinedAt: !129)
!133 = !DILocation(line: 992, column: 17, scope: !107, inlinedAt: !129)
!134 = !DILocation(line: 992, column: 11, scope: !107, inlinedAt: !129)
!135 = !DILocation(line: 993, column: 43, scope: !107, inlinedAt: !129)
!136 = !DILocation(line: 993, column: 10, scope: !107, inlinedAt: !129)
!137 = !DILocation(line: 1020, column: 14, scope: !94, inlinedAt: !121)
!138 = !DILocation(line: 25, column: 14, scope: !118, inlinedAt: !139)
!139 = distinct !DILocation(line: 129, column: 11, scope: !123, inlinedAt: !124)
!140 = !DILocation(line: 78, column: 34, scope: !40)
!141 = !DILocation(line: 78, column: 9, scope: !40)
!142 = !DILocation(line: 86, column: 34, scope: !40)
!143 = !DILocation(line: 75, column: 10, scope: !144, inlinedAt: !146)
!144 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !145, file: !145, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!146 = distinct !DILocation(line: 984, column: 9, scope: !147, inlinedAt: !149)
!147 = distinct !DISubprogram(name: "__float2half", scope: !148, file: !148, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!149 = distinct !DILocation(line: 133, column: 53, scope: !150, inlinedAt: !151)
!150 = distinct !DISubprogram(name: "__half", scope: !148, file: !148, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!151 = distinct !DILocation(line: 92, column: 49, scope: !40)
!152 = !DILocation(line: 92, column: 46, scope: !40)
!153 = !DILocation(line: 103, column: 36, scope: !40)
!154 = !DILocation(line: 113, column: 67, scope: !40)
!155 = !DILocation(line: 75, column: 10, scope: !144, inlinedAt: !156)
!156 = distinct !DILocation(line: 984, column: 9, scope: !147, inlinedAt: !157)
!157 = distinct !DILocation(line: 133, column: 53, scope: !150, inlinedAt: !158)
!158 = distinct !DILocation(line: 113, column: 59, scope: !40)
!159 = !DILocation(line: 113, column: 56, scope: !40)
!160 = !DILocation(line: 68, column: 3, scope: !62, inlinedAt: !161)
!161 = distinct !DILocation(line: 192, column: 3, scope: !65, inlinedAt: !162)
!162 = distinct !DILocation(line: 123, column: 3, scope: !40)
!163 = !DILocation(line: 126, column: 94, scope: !40)
!164 = !DILocation(line: 131, column: 253, scope: !40)
!165 = !DILocation(line: 131, column: 169, scope: !40)
!166 = !DILocation(line: 0, scope: !40)
!167 = !DILocation(line: 69, column: 3, scope: !62, inlinedAt: !161)
!168 = !DILocation(line: 70, column: 3, scope: !62, inlinedAt: !161)
!169 = !DILocation(line: 126, column: 123, scope: !40)
!170 = !DILocation(line: 126, column: 152, scope: !40)
!171 = !DILocation(line: 126, column: 78, scope: !40)
!172 = !DILocation(line: 126, column: 158, scope: !40)
!173 = !DILocation(line: 126, column: 40, scope: !40)
!174 = !DILocation(line: 126, column: 201, scope: !40)
!175 = !DILocation(line: 68, column: 3, scope: !62, inlinedAt: !176)
!176 = distinct !DILocation(line: 192, column: 3, scope: !65, inlinedAt: !177)
!177 = distinct !DILocation(line: 128, column: 3, scope: !40)
!178 = !DILocation(line: 69, column: 3, scope: !62, inlinedAt: !176)
!179 = !DILocation(line: 70, column: 3, scope: !62, inlinedAt: !176)
!180 = !DILocation(line: 130, column: 8, scope: !40)
!181 = !DILocation(line: 130, column: 3, scope: !40)
!182 = !DILocation(line: 131, column: 22, scope: !40)
!183 = !DILocation(line: 131, column: 132, scope: !40)
!184 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!185 = !{i32 1, i32 -1, i32 -1, i32 -1}
!186 = !DILocation(line: 131, column: 267, scope: !40)
!187 = !DILocation(line: 133, column: 1, scope: !40)
