; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj6_m1_p1.bc'
source_filename = "/tmp/tmpivf37iyi/tvm_kernels.maca"
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
  %arrayidx.val = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !49, !tbaa !30
  %or.cond = icmp ult i32 %arrayidx.val, 32, !dbg !50
  br i1 %or.cond, label %land.rhs, label %if.else338, !dbg !50

land.rhs:                                         ; preds = %entry
  %mul22 = shl nuw nsw i32 %arrayidx.val, 5, !dbg !51
  %cmp24.not = icmp ugt i32 %mul22, %1, !dbg !52
  br i1 %cmp24.not, label %if.else338, label %for.cond25.preheader, !dbg !53

for.cond25.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul31 = shl nuw nsw i64 %conv, 18
  %19 = shl nuw nsw i32 %arrayidx.val, 13
  %mul33 = zext nneg i32 %19 to i64
  %add34 = or disjoint i64 %mul31, %mul33
  %20 = shl nuw nsw i32 %2, 3
  %mul40 = zext nneg i32 %20 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul40, !dbg !54
  %21 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add34, !dbg !55
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %21, align 16, !dbg !56
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 8, !dbg !56
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8, !dbg !56
  %gep.1 = getelementptr i8, ptr addrspace(4) %21, i64 1024, !dbg !55
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !56
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %21, i64 1032, !dbg !56
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8, !dbg !56
  %gep.2 = getelementptr i8, ptr addrspace(4) %21, i64 2048, !dbg !55
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16, !dbg !56
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %21, i64 2056, !dbg !56
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8, !dbg !56
  %gep.3 = getelementptr i8, ptr addrspace(4) %21, i64 3072, !dbg !55
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16, !dbg !56
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %21, i64 3080, !dbg !56
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8, !dbg !56
  %gep.4 = getelementptr i8, ptr addrspace(4) %21, i64 4096, !dbg !55
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16, !dbg !56
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %21, i64 4104, !dbg !56
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8, !dbg !56
  %gep.5 = getelementptr i8, ptr addrspace(4) %21, i64 5120, !dbg !55
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16, !dbg !56
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %21, i64 5128, !dbg !56
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8, !dbg !56
  %gep.6 = getelementptr i8, ptr addrspace(4) %21, i64 6144, !dbg !55
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16, !dbg !56
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %21, i64 6152, !dbg !56
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8, !dbg !56
  %gep.7 = getelementptr i8, ptr addrspace(4) %21, i64 7168, !dbg !55
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16, !dbg !56
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %21, i64 7176, !dbg !56
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8, !dbg !56
  %and = lshr i32 %2, 1
  %shr64 = and i32 %and, 15
  %shr67 = lshr i32 %2, 5
  %add62 = and i32 %mul10, 3972
  %xor = xor i32 %shr67, %shr64, !dbg !57
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add62, !dbg !58
  %add.ptr76.idx = shl nuw nsw i32 %xor, 4, !dbg !58
  %add.ptr76 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr76.idx, !dbg !58
  store i64 %4, ptr addrspace(3) %add.ptr76, align 8, !dbg !59
  %add68.1 = add nuw nsw i32 %shr67, 2, !dbg !60
  %xor.1 = xor i32 %add68.1, %shr64, !dbg !57
  %23 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 512, !dbg !58
  %add.ptr76.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !58
  %add.ptr76.1 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 %add.ptr76.idx.1, !dbg !58
  store i64 %6, ptr addrspace(3) %add.ptr76.1, align 8, !dbg !59
  %add68.2 = add nuw nsw i32 %shr67, 4, !dbg !60
  %xor.2 = xor i32 %add68.2, %shr64, !dbg !57
  %24 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 1024, !dbg !58
  %add.ptr76.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !58
  %add.ptr76.2 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr76.idx.2, !dbg !58
  store i64 %8, ptr addrspace(3) %add.ptr76.2, align 8, !dbg !59
  %add68.3 = add nuw nsw i32 %shr67, 6, !dbg !60
  %xor.3 = xor i32 %add68.3, %shr64, !dbg !57
  %25 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 1536, !dbg !58
  %add.ptr76.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !58
  %add.ptr76.3 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr76.idx.3, !dbg !58
  store i64 %10, ptr addrspace(3) %add.ptr76.3, align 8, !dbg !59
  %add68.4 = add nuw nsw i32 %shr67, 8, !dbg !60
  %xor.4 = xor i32 %add68.4, %shr64, !dbg !57
  %26 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 2048, !dbg !58
  %add.ptr76.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !58
  %add.ptr76.4 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr76.idx.4, !dbg !58
  store i64 %12, ptr addrspace(3) %add.ptr76.4, align 8, !dbg !59
  %add68.5 = add nuw nsw i32 %shr67, 10, !dbg !60
  %xor.5 = xor i32 %add68.5, %shr64, !dbg !57
  %27 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 2560, !dbg !58
  %add.ptr76.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !58
  %add.ptr76.5 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr76.idx.5, !dbg !58
  store i64 %14, ptr addrspace(3) %add.ptr76.5, align 8, !dbg !59
  %add68.6 = add nuw nsw i32 %shr67, 12, !dbg !60
  %xor.6 = xor i32 %add68.6, %shr64, !dbg !57
  %28 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 3072, !dbg !58
  %add.ptr76.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !58
  %add.ptr76.6 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr76.idx.6, !dbg !58
  store i64 %16, ptr addrspace(3) %add.ptr76.6, align 8, !dbg !59
  %add68.7 = add nuw nsw i32 %shr67, 14, !dbg !60
  %xor.7 = xor i32 %add68.7, %shr64, !dbg !57
  %29 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 3584, !dbg !58
  %add.ptr76.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !58
  %add.ptr76.7 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr76.idx.7, !dbg !58
  store i64 %18, ptr addrspace(3) %add.ptr76.7, align 8, !dbg !59
  fence syncscope("warp") release, !dbg !61
  tail call void @llvm.mxc.barrier.warp(), !dbg !67
  fence syncscope("warp") acquire, !dbg !68
  %and86 = shl nuw nsw i32 %2, 7
  %mul87 = and i32 %and86, 1920
  %shr90 = lshr i32 %2, 4
  %and93 = and i32 %2, 15
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul87
  %xor94 = xor i32 %shr90, %and93, !dbg !69
  %add.ptr98.idx = shl nuw nsw i32 %xor94, 4, !dbg !70
  %add.ptr98 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr98.idx, !dbg !70
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98, align 16, !dbg !71
  %q.sroa.4.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98, i32 8, !dbg !71
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr98.sroa_idx, align 8, !dbg !71
  %add91.1 = add nuw nsw i32 %shr90, 4, !dbg !72
  %xor94.1 = xor i32 %add91.1, %and93, !dbg !69
  %add.ptr98.idx.1 = shl nuw nsw i32 %xor94.1, 4, !dbg !70
  %add.ptr98.1 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr98.idx.1, !dbg !70
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.1, align 16, !dbg !71
  %q.sroa.7.16.add.ptr98.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.1, i32 8, !dbg !71
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr98.1.sroa_idx, align 8, !dbg !71
  %add91.2 = add nuw nsw i32 %shr90, 8, !dbg !72
  %xor94.2 = xor i32 %add91.2, %and93, !dbg !69
  %add.ptr98.idx.2 = shl nuw nsw i32 %xor94.2, 4, !dbg !70
  %add.ptr98.2 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr98.idx.2, !dbg !70
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.2, align 16, !dbg !71
  %q.sroa.10.32.add.ptr98.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.2, i32 8, !dbg !71
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr98.2.sroa_idx, align 8, !dbg !71
  %add91.3 = add nuw nsw i32 %shr90, 12, !dbg !72
  %xor94.3 = xor i32 %add91.3, %and93, !dbg !69
  %add.ptr98.idx.3 = shl nuw nsw i32 %xor94.3, 4, !dbg !70
  %add.ptr98.3 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr98.idx.3, !dbg !70
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.3, align 16, !dbg !71
  %q.sroa.13.48.add.ptr98.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.3, i32 8, !dbg !71
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr98.3.sroa_idx, align 8, !dbg !71
  %31 = lshr i32 %2, 2
  %mul119 = and i32 %31, 252
  %add116 = add nuw nsw i32 %mul22, %mul119
  %cmp124.not = icmp ugt i32 %add116, %1, !dbg !73
  %spec.select = select i1 %cmp124.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !75
  %cmp124.not.1.not = icmp ult i32 %add116, %1, !dbg !73
  %spec.select.1 = select i1 %cmp124.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !74
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !75
  %add120.2 = or disjoint i32 %add116, 2, !dbg !76
  %cmp124.not.2 = icmp ugt i32 %add120.2, %1, !dbg !73
  %spec.select.2 = select i1 %cmp124.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !75
  %add120.3 = or disjoint i32 %add116, 3, !dbg !76
  %cmp124.not.3 = icmp ugt i32 %add120.3, %1, !dbg !73
  %spec.select.3 = select i1 %cmp124.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !75
  %add122.4 = add nuw nsw i32 %add116, 16, !dbg !77
  %cmp124.not.4 = icmp ugt i32 %add122.4, %1, !dbg !73
  %spec.select.4 = select i1 %cmp124.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !75
  %add122.5 = add nuw nsw i32 %add116, 17, !dbg !77
  %cmp124.not.5 = icmp ugt i32 %add122.5, %1, !dbg !73
  %spec.select.5 = select i1 %cmp124.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1, !dbg !75
  %add122.6 = add nuw nsw i32 %add116, 18, !dbg !77
  %cmp124.not.6 = icmp ugt i32 %add122.6, %1, !dbg !73
  %spec.select.6 = select i1 %cmp124.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2, !dbg !75
  %add122.7 = add nuw nsw i32 %add116, 19, !dbg !77
  %cmp124.not.7 = icmp ugt i32 %add122.7, %1, !dbg !73
  %spec.select.7 = select i1 %cmp124.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !74
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3, !dbg !75
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !78, !call_argsrelate !79
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !78, !call_argsrelate !79
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %32), !dbg !78, !call_argsrelate !79
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %33), !dbg !78, !call_argsrelate !79
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %34), !dbg !78, !call_argsrelate !79
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %35), !dbg !78, !call_argsrelate !79
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %36), !dbg !78, !call_argsrelate !79
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %37), !dbg !78, !call_argsrelate !79
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %38), !dbg !78, !call_argsrelate !79
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %39), !dbg !78, !call_argsrelate !79
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %40), !dbg !78, !call_argsrelate !79
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %41), !dbg !78, !call_argsrelate !79
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %42), !dbg !78, !call_argsrelate !79
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %43), !dbg !78, !call_argsrelate !79
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %44), !dbg !78, !call_argsrelate !79
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %45), !dbg !78, !call_argsrelate !79
  %invariant.gep539 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192, !dbg !80
  %48 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep539, i64 %add34, !dbg !81
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %48, align 16, !dbg !82
  %v.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %48, i64 8, !dbg !82
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0..sroa_idx, align 8, !dbg !82
  %gep540.1 = getelementptr i8, ptr addrspace(4) %48, i64 1024, !dbg !81
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep540.1, align 16, !dbg !82
  %v.sroa.7.16.gep540.1.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 1032, !dbg !82
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.gep540.1.sroa_idx, align 8, !dbg !82
  %gep540.2 = getelementptr i8, ptr addrspace(4) %48, i64 2048, !dbg !81
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep540.2, align 16, !dbg !82
  %v.sroa.10.32.gep540.2.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 2056, !dbg !82
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.gep540.2.sroa_idx, align 8, !dbg !82
  %gep540.3 = getelementptr i8, ptr addrspace(4) %48, i64 3072, !dbg !81
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep540.3, align 16, !dbg !82
  %v.sroa.13.48.gep540.3.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 3080, !dbg !82
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.gep540.3.sroa_idx, align 8, !dbg !82
  %gep540.4 = getelementptr i8, ptr addrspace(4) %48, i64 4096, !dbg !81
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep540.4, align 16, !dbg !82
  %v.sroa.16.64.gep540.4.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 4104, !dbg !82
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.gep540.4.sroa_idx, align 8, !dbg !82
  %gep540.5 = getelementptr i8, ptr addrspace(4) %48, i64 5120, !dbg !81
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep540.5, align 16, !dbg !82
  %v.sroa.19.80.gep540.5.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 5128, !dbg !82
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.gep540.5.sroa_idx, align 8, !dbg !82
  %gep540.6 = getelementptr i8, ptr addrspace(4) %48, i64 6144, !dbg !81
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep540.6, align 16, !dbg !82
  %v.sroa.22.96.gep540.6.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 6152, !dbg !82
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.gep540.6.sroa_idx, align 8, !dbg !82
  %gep540.7 = getelementptr i8, ptr addrspace(4) %48, i64 7168, !dbg !81
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep540.7, align 16, !dbg !82
  %v.sroa.25.112.gep540.7.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 7176, !dbg !82
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.gep540.7.sroa_idx, align 8, !dbg !82
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !83
  %mul204 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !84
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul204, float 1.500000e+01), !dbg !85
  %cmp.i.i = fcmp contract olt float %49, -1.260000e+02, !dbg !89
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520 = fadd contract float %49, %cond.i.i, !dbg !89
  %50 = tail call contract float @llvm.exp2.f32(float %add.i.i520), !dbg !89
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i = fmul contract float %cond2.i.i, %50, !dbg !89
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1, !dbg !83
  %mul204.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !84
  %51 = tail call contract noundef float @llvm.minnum.f32(float %mul204.1, float 1.500000e+01), !dbg !85
  %cmp.i.i.1 = fcmp contract olt float %51, -1.260000e+02, !dbg !89
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520.1 = fadd contract float %51, %cond.i.i.1, !dbg !89
  %52 = tail call contract float @llvm.exp2.f32(float %add.i.i520.1), !dbg !89
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %52, !dbg !89
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2, !dbg !83
  %mul204.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !84
  %53 = tail call contract noundef float @llvm.minnum.f32(float %mul204.2, float 1.500000e+01), !dbg !85
  %cmp.i.i.2 = fcmp contract olt float %53, -1.260000e+02, !dbg !89
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520.2 = fadd contract float %53, %cond.i.i.2, !dbg !89
  %54 = tail call contract float @llvm.exp2.f32(float %add.i.i520.2), !dbg !89
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %54, !dbg !89
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3, !dbg !83
  %mul204.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !84
  %55 = tail call contract noundef float @llvm.minnum.f32(float %mul204.3, float 1.500000e+01), !dbg !85
  %cmp.i.i.3 = fcmp contract olt float %55, -1.260000e+02, !dbg !89
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520.3 = fadd contract float %55, %cond.i.i.3, !dbg !89
  %56 = tail call contract float @llvm.exp2.f32(float %add.i.i520.3), !dbg !89
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %56, !dbg !89
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %47, i64 0, !dbg !83
  %mul204.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !84
  %57 = tail call contract noundef float @llvm.minnum.f32(float %mul204.4, float 1.500000e+01), !dbg !85
  %cmp.i.i.4 = fcmp contract olt float %57, -1.260000e+02, !dbg !89
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520.4 = fadd contract float %57, %cond.i.i.4, !dbg !89
  %58 = tail call contract float @llvm.exp2.f32(float %add.i.i520.4), !dbg !89
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %58, !dbg !89
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %47, i64 1, !dbg !83
  %mul204.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !84
  %59 = tail call contract noundef float @llvm.minnum.f32(float %mul204.5, float 1.500000e+01), !dbg !85
  %cmp.i.i.5 = fcmp contract olt float %59, -1.260000e+02, !dbg !89
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520.5 = fadd contract float %59, %cond.i.i.5, !dbg !89
  %60 = tail call contract float @llvm.exp2.f32(float %add.i.i520.5), !dbg !89
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %60, !dbg !89
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %47, i64 2, !dbg !83
  %mul204.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !84
  %61 = tail call contract noundef float @llvm.minnum.f32(float %mul204.6, float 1.500000e+01), !dbg !85
  %cmp.i.i.6 = fcmp contract olt float %61, -1.260000e+02, !dbg !89
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520.6 = fadd contract float %61, %cond.i.i.6, !dbg !89
  %62 = tail call contract float @llvm.exp2.f32(float %add.i.i520.6), !dbg !89
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %62, !dbg !89
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %47, i64 3, !dbg !83
  %mul204.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !84
  %63 = tail call contract noundef float @llvm.minnum.f32(float %mul204.7, float 1.500000e+01), !dbg !85
  %cmp.i.i.7 = fcmp contract olt float %63, -1.260000e+02, !dbg !89
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !89
  %add.i.i520.7 = fadd contract float %63, %cond.i.i.7, !dbg !89
  %64 = tail call contract float @llvm.exp2.f32(float %add.i.i520.7), !dbg !89
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !89
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %64, !dbg !89
  %add224 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !92
  %add224.1 = fadd contract float %add224, %mul.i.i.4, !dbg !92
  %add224.2 = fadd contract float %add224.1, %mul.i.i.1, !dbg !92
  %add224.3 = fadd contract float %add224.2, %mul.i.i.5, !dbg !92
  %add224.4 = fadd contract float %add224.3, %mul.i.i.2, !dbg !92
  %add224.5 = fadd contract float %add224.4, %mul.i.i.6, !dbg !92
  %add224.6 = fadd contract float %add224.5, %mul.i.i.3, !dbg !92
  %add224.7 = fadd contract float %add224.6, %mul.i.i.7, !dbg !92
  %65 = bitcast float %add224.7 to i32, !dbg !93
  %66 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !104
  %67 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %66) #11, !dbg !109
  %xor.i.i = xor i32 %67, 32, !dbg !110
  %68 = and i32 %67, -64, !dbg !111
  %and.i.i = add nsw i32 %68, 64, !dbg !111
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !112
  %cond.i.i521 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %67, !dbg !113
  %shl.i.i = shl i32 %cond.i.i521, 2, !dbg !114
  %69 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %65), !dbg !115
  %70 = bitcast i32 %69 to float, !dbg !116
  %add.i = fadd contract float %add224.7, %70, !dbg !117
  %71 = bitcast float %add.i to i32, !dbg !120
  %72 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !127
  %73 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %72) #11, !dbg !130
  %xor.i.i522 = xor i32 %73, 16, !dbg !131
  %74 = and i32 %73, -64, !dbg !132
  %and.i.i523 = add nsw i32 %74, 64, !dbg !132
  %cmp.not.i.i524 = icmp slt i32 %xor.i.i522, %and.i.i523, !dbg !133
  %cond.i.i525 = select i1 %cmp.not.i.i524, i32 %xor.i.i522, i32 %73, !dbg !134
  %shl.i.i526 = shl i32 %cond.i.i525, 2, !dbg !135
  %75 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i526, i32 %71), !dbg !136
  %76 = bitcast i32 %75 to float, !dbg !137
  %add.i.i = fadd contract float %add.i, %76, !dbg !138
  %cmp233 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !140
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !141
  %condval_1.0 = select i1 %cmp233, float %div, float 0.000000e+00, !dbg !141
  %mul246 = fmul contract float %condval_1.0, %mul.i.i, !dbg !142
  %mul246.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !142
  %mul246.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !142
  %mul246.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !142
  %mul246.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !142
  %mul246.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !142
  %mul246.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !142
  %mul246.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !142
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246), !dbg !143
  %78 = insertelement <4 x i16> poison, i16 %77, i64 0, !dbg !152
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246.1), !dbg !143
  %80 = insertelement <4 x i16> %78, i16 %79, i64 1, !dbg !152
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246.2), !dbg !143
  %82 = insertelement <4 x i16> %80, i16 %81, i64 2, !dbg !152
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246.3), !dbg !143
  %84 = insertelement <4 x i16> %82, i16 %83, i64 3, !dbg !152
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %84 to <4 x half>, !dbg !152
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246.4), !dbg !143
  %86 = insertelement <4 x i16> poison, i16 %85, i64 0, !dbg !152
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246.5), !dbg !143
  %88 = insertelement <4 x i16> %86, i16 %87, i64 1, !dbg !152
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246.6), !dbg !143
  %90 = insertelement <4 x i16> %88, i16 %89, i64 2, !dbg !152
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul246.7), !dbg !143
  %92 = insertelement <4 x i16> %90, i16 %91, i64 3, !dbg !152
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %92 to <4 x half>, !dbg !152
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !79
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %93), !dbg !153, !call_argsrelate !79
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %94), !dbg !153, !call_argsrelate !79
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %95), !dbg !153, !call_argsrelate !79
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %96), !dbg !153, !call_argsrelate !79
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %97), !dbg !153, !call_argsrelate !79
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %98), !dbg !153, !call_argsrelate !79
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %99), !dbg !153, !call_argsrelate !79
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %100), !dbg !153, !call_argsrelate !79
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %101, i64 0, !dbg !154
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !155
  %output_reg.sroa.0.0.insert.ext = zext i16 %109 to i64, !dbg !159
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %101, i64 1, !dbg !154
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !155
  %output_reg.sroa.0.2.insert.ext = zext i16 %110 to i64, !dbg !159
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !159
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !159
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %101, i64 2, !dbg !154
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !155
  %output_reg.sroa.0.4.insert.ext = zext i16 %111 to i64, !dbg !159
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !159
  %output_reg.sroa.0.4.insert.insert645 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !159
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %101, i64 3, !dbg !154
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !155
  %output_reg.sroa.0.6.insert.ext = zext i16 %112 to i64, !dbg !159
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !159
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert645, %output_reg.sroa.0.6.insert.shift, !dbg !159
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !154
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !155
  %output_reg.sroa.9.8.insert.ext = zext i16 %113 to i64, !dbg !159
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !154
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !155
  %output_reg.sroa.9.10.insert.ext = zext i16 %114 to i64, !dbg !159
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16, !dbg !159
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext, !dbg !159
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !154
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !155
  %output_reg.sroa.9.12.insert.ext = zext i16 %115 to i64, !dbg !159
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32, !dbg !159
  %output_reg.sroa.9.12.insert.insert651 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift, !dbg !159
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !154
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !155
  %output_reg.sroa.9.14.insert.ext = zext i16 %116 to i64, !dbg !159
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48, !dbg !159
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert651, %output_reg.sroa.9.14.insert.shift, !dbg !159
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %103, i64 0, !dbg !154
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !155
  %output_reg.sroa.16.16.insert.ext = zext i16 %117 to i64, !dbg !159
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %103, i64 1, !dbg !154
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !155
  %output_reg.sroa.16.18.insert.ext = zext i16 %118 to i64, !dbg !159
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16, !dbg !159
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext, !dbg !159
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %103, i64 2, !dbg !154
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !155
  %output_reg.sroa.16.20.insert.ext = zext i16 %119 to i64, !dbg !159
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32, !dbg !159
  %output_reg.sroa.16.20.insert.insert657 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift, !dbg !159
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %103, i64 3, !dbg !154
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !155
  %output_reg.sroa.16.22.insert.ext = zext i16 %120 to i64, !dbg !159
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48, !dbg !159
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert657, %output_reg.sroa.16.22.insert.shift, !dbg !159
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %104, i64 0, !dbg !154
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !155
  %output_reg.sroa.23.24.insert.ext = zext i16 %121 to i64, !dbg !159
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %104, i64 1, !dbg !154
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !155
  %output_reg.sroa.23.26.insert.ext = zext i16 %122 to i64, !dbg !159
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16, !dbg !159
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext, !dbg !159
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %104, i64 2, !dbg !154
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !155
  %output_reg.sroa.23.28.insert.ext = zext i16 %123 to i64, !dbg !159
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32, !dbg !159
  %output_reg.sroa.23.28.insert.insert663 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift, !dbg !159
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %104, i64 3, !dbg !154
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !155
  %output_reg.sroa.23.30.insert.ext = zext i16 %124 to i64, !dbg !159
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48, !dbg !159
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert663, %output_reg.sroa.23.30.insert.shift, !dbg !159
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %105, i64 0, !dbg !154
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !155
  %output_reg.sroa.30.32.insert.ext = zext i16 %125 to i64, !dbg !159
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %105, i64 1, !dbg !154
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !155
  %output_reg.sroa.30.34.insert.ext = zext i16 %126 to i64, !dbg !159
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16, !dbg !159
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext, !dbg !159
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %105, i64 2, !dbg !154
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !155
  %output_reg.sroa.30.36.insert.ext = zext i16 %127 to i64, !dbg !159
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32, !dbg !159
  %output_reg.sroa.30.36.insert.insert669 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift, !dbg !159
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %105, i64 3, !dbg !154
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !155
  %output_reg.sroa.30.38.insert.ext = zext i16 %128 to i64, !dbg !159
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48, !dbg !159
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert669, %output_reg.sroa.30.38.insert.shift, !dbg !159
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %106, i64 0, !dbg !154
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !155
  %output_reg.sroa.37.40.insert.ext = zext i16 %129 to i64, !dbg !159
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %106, i64 1, !dbg !154
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !155
  %output_reg.sroa.37.42.insert.ext = zext i16 %130 to i64, !dbg !159
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16, !dbg !159
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext, !dbg !159
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %106, i64 2, !dbg !154
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !155
  %output_reg.sroa.37.44.insert.ext = zext i16 %131 to i64, !dbg !159
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32, !dbg !159
  %output_reg.sroa.37.44.insert.insert675 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift, !dbg !159
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %106, i64 3, !dbg !154
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !155
  %output_reg.sroa.37.46.insert.ext = zext i16 %132 to i64, !dbg !159
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48, !dbg !159
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert675, %output_reg.sroa.37.46.insert.shift, !dbg !159
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %107, i64 0, !dbg !154
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !155
  %output_reg.sroa.44.48.insert.ext = zext i16 %133 to i64, !dbg !159
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %107, i64 1, !dbg !154
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !155
  %output_reg.sroa.44.50.insert.ext = zext i16 %134 to i64, !dbg !159
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16, !dbg !159
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext, !dbg !159
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %107, i64 2, !dbg !154
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !155
  %output_reg.sroa.44.52.insert.ext = zext i16 %135 to i64, !dbg !159
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32, !dbg !159
  %output_reg.sroa.44.52.insert.insert681 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift, !dbg !159
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %107, i64 3, !dbg !154
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !155
  %output_reg.sroa.44.54.insert.ext = zext i16 %136 to i64, !dbg !159
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48, !dbg !159
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert681, %output_reg.sroa.44.54.insert.shift, !dbg !159
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %108, i64 0, !dbg !154
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !155
  %output_reg.sroa.51.56.insert.ext = zext i16 %137 to i64, !dbg !159
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %108, i64 1, !dbg !154
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !155
  %output_reg.sroa.51.58.insert.ext = zext i16 %138 to i64, !dbg !159
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16, !dbg !159
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext, !dbg !159
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %108, i64 2, !dbg !154
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !155
  %output_reg.sroa.51.60.insert.ext = zext i16 %139 to i64, !dbg !159
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32, !dbg !159
  %output_reg.sroa.51.60.insert.insert687 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift, !dbg !159
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %108, i64 3, !dbg !154
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !155
  %output_reg.sroa.51.62.insert.ext = zext i16 %140 to i64, !dbg !159
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48, !dbg !159
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert687, %output_reg.sroa.51.62.insert.shift, !dbg !159
  br label %if.end360, !dbg !160

if.else338:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre794 = and i32 %.pre, 1920
  %.pre795 = lshr i32 %2, 5
  %.pre796 = and i32 %2, 15
  %.pre797 = lshr i32 %2, 2
  %.pre798 = add nuw nsw i32 %.pre795, 2, !dbg !163
  %.pre799 = add nuw nsw i32 %.pre795, 4, !dbg !163
  %.pre800 = add nuw nsw i32 %.pre795, 6, !dbg !163
  %.pre801 = add nuw nsw i32 %.pre795, 8, !dbg !163
  %.pre802 = add nuw nsw i32 %.pre795, 10, !dbg !163
  %.pre803 = add nuw nsw i32 %.pre795, 12, !dbg !163
  %.pre804 = add nuw nsw i32 %.pre795, 14, !dbg !163
  %.pre805 = shl nuw nsw i32 %2, 3
  %.pre807 = lshr i32 %2, 4
  %.pre808 = xor i32 %.pre807, %.pre796, !dbg !164
  %.pre809 = shl nuw nsw i32 %.pre808, 4, !dbg !165
  br label %if.end360, !dbg !160

if.end360:                                        ; preds = %for.cond25.preheader, %if.else338
  %add.ptr410.idx.pre-phi = phi i32 [ %add.ptr98.idx, %for.cond25.preheader ], [ %.pre809, %if.else338 ], !dbg !165
  %shr404.pre-phi = phi i32 [ %shr90, %for.cond25.preheader ], [ %.pre807, %if.else338 ]
  %.pre-phi806 = phi i32 [ %20, %for.cond25.preheader ], [ %.pre805, %if.else338 ]
  %add375.7.pre-phi = phi i32 [ %add68.7, %for.cond25.preheader ], [ %.pre804, %if.else338 ], !dbg !163
  %add375.6.pre-phi = phi i32 [ %add68.6, %for.cond25.preheader ], [ %.pre803, %if.else338 ], !dbg !163
  %add375.5.pre-phi = phi i32 [ %add68.5, %for.cond25.preheader ], [ %.pre802, %if.else338 ], !dbg !163
  %add375.4.pre-phi = phi i32 [ %add68.4, %for.cond25.preheader ], [ %.pre801, %if.else338 ], !dbg !163
  %add375.3.pre-phi = phi i32 [ %add68.3, %for.cond25.preheader ], [ %.pre800, %if.else338 ], !dbg !163
  %add375.2.pre-phi = phi i32 [ %add68.2, %for.cond25.preheader ], [ %.pre799, %if.else338 ], !dbg !163
  %add375.1.pre-phi = phi i32 [ %add68.1, %for.cond25.preheader ], [ %.pre798, %if.else338 ], !dbg !163
  %.pre-phi = phi i32 [ %31, %for.cond25.preheader ], [ %.pre797, %if.else338 ]
  %and377.pre-phi = phi i32 [ %and93, %for.cond25.preheader ], [ %.pre796, %if.else338 ]
  %shr374.pre-phi = phi i32 [ %shr67, %for.cond25.preheader ], [ %.pre795, %if.else338 ]
  %mul371.pre-phi = phi i32 [ %mul87, %for.cond25.preheader ], [ %.pre794, %if.else338 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond25.preheader ], [ 0, %if.else338 ], !dbg !166
  fence syncscope("warp") release, !dbg !160
  tail call void @llvm.mxc.barrier.warp(), !dbg !167
  fence syncscope("warp") acquire, !dbg !168
  %mul384 = and i32 %.pre-phi, 4
  %xor378 = xor i32 %shr374.pre-phi, %and377.pre-phi, !dbg !169
  %mul379 = shl nuw nsw i32 %xor378, 3, !dbg !170
  %add380 = add nuw nsw i32 %mul379, %mul371.pre-phi, !dbg !171
  %add385 = or disjoint i32 %add380, %mul384, !dbg !172
  %add.ptr387 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385, !dbg !173
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr387, align 8, !dbg !174
  %xor378.1 = xor i32 %add375.1.pre-phi, %and377.pre-phi, !dbg !169
  %mul379.1 = shl nuw nsw i32 %xor378.1, 3, !dbg !170
  %add380.1 = add nuw nsw i32 %mul379.1, %mul371.pre-phi, !dbg !171
  %add385.1 = or disjoint i32 %add380.1, %mul384, !dbg !172
  %add.ptr387.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1, !dbg !173
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr387.1, align 8, !dbg !174
  %xor378.2 = xor i32 %add375.2.pre-phi, %and377.pre-phi, !dbg !169
  %mul379.2 = shl nuw nsw i32 %xor378.2, 3, !dbg !170
  %add380.2 = add nuw nsw i32 %mul379.2, %mul371.pre-phi, !dbg !171
  %add385.2 = or disjoint i32 %add380.2, %mul384, !dbg !172
  %add.ptr387.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2, !dbg !173
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr387.2, align 8, !dbg !174
  %xor378.3 = xor i32 %add375.3.pre-phi, %and377.pre-phi, !dbg !169
  %mul379.3 = shl nuw nsw i32 %xor378.3, 3, !dbg !170
  %add380.3 = add nuw nsw i32 %mul379.3, %mul371.pre-phi, !dbg !171
  %add385.3 = or disjoint i32 %add380.3, %mul384, !dbg !172
  %add.ptr387.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3, !dbg !173
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr387.3, align 8, !dbg !174
  %xor378.4 = xor i32 %add375.4.pre-phi, %and377.pre-phi, !dbg !169
  %mul379.4 = shl nuw nsw i32 %xor378.4, 3, !dbg !170
  %add380.4 = add nuw nsw i32 %mul379.4, %mul371.pre-phi, !dbg !171
  %add385.4 = or disjoint i32 %add380.4, %mul384, !dbg !172
  %add.ptr387.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.4, !dbg !173
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr387.4, align 8, !dbg !174
  %xor378.5 = xor i32 %add375.5.pre-phi, %and377.pre-phi, !dbg !169
  %mul379.5 = shl nuw nsw i32 %xor378.5, 3, !dbg !170
  %add380.5 = add nuw nsw i32 %mul379.5, %mul371.pre-phi, !dbg !171
  %add385.5 = or disjoint i32 %add380.5, %mul384, !dbg !172
  %add.ptr387.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.5, !dbg !173
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr387.5, align 8, !dbg !174
  %xor378.6 = xor i32 %add375.6.pre-phi, %and377.pre-phi, !dbg !169
  %mul379.6 = shl nuw nsw i32 %xor378.6, 3, !dbg !170
  %add380.6 = add nuw nsw i32 %mul379.6, %mul371.pre-phi, !dbg !171
  %add385.6 = or disjoint i32 %add380.6, %mul384, !dbg !172
  %add.ptr387.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.6, !dbg !173
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr387.6, align 8, !dbg !174
  %xor378.7 = xor i32 %add375.7.pre-phi, %and377.pre-phi, !dbg !169
  %mul379.7 = shl nuw nsw i32 %xor378.7, 3, !dbg !170
  %add380.7 = add nuw nsw i32 %mul379.7, %mul371.pre-phi, !dbg !171
  %add385.7 = or disjoint i32 %add380.7, %mul384, !dbg !172
  %add.ptr387.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.7, !dbg !173
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr387.7, align 8, !dbg !174
  fence syncscope("warp") release, !dbg !175
  tail call void @llvm.mxc.barrier.warp(), !dbg !178
  fence syncscope("warp") acquire, !dbg !179
  %mul398 = and i32 %.pre-phi806, 8064
  %invariant.gep555 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul398, !dbg !180
  %add417 = add nuw nsw i32 %add, %.pre-phi806
  %141 = zext nneg i32 %add417 to i64, !dbg !181
  %add.ptr410 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 %add.ptr410.idx.pre-phi, !dbg !165
  %add.ptr422 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %141, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr422, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr410, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %142 = add nuw nsw i32 %shr404.pre-phi, 4, !dbg !186
  %xor406.1 = xor i32 %142, %and377.pre-phi, !dbg !164
  %gep556.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 1024, !dbg !165
  %add.ptr410.idx.1 = shl nuw nsw i32 %xor406.1, 4, !dbg !165
  %add.ptr410.1 = getelementptr inbounds i8, ptr addrspace(3) %gep556.1, i32 %add.ptr410.idx.1, !dbg !165
  %143 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %141, !dbg !182
  %add.ptr422.1 = getelementptr inbounds i8, ptr addrspace(1) %143, i64 1024, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr422.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr410.1, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %144 = add nuw nsw i32 %shr404.pre-phi, 8, !dbg !186
  %xor406.2 = xor i32 %144, %and377.pre-phi, !dbg !164
  %gep556.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 2048, !dbg !165
  %add.ptr410.idx.2 = shl nuw nsw i32 %xor406.2, 4, !dbg !165
  %add.ptr410.2 = getelementptr inbounds i8, ptr addrspace(3) %gep556.2, i32 %add.ptr410.idx.2, !dbg !165
  %145 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %141, !dbg !182
  %add.ptr422.2 = getelementptr inbounds i8, ptr addrspace(1) %145, i64 2048, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr422.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr410.2, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
  %narrow = add nuw nsw i32 %shr404.pre-phi, 12, !dbg !186
  %xor406.3 = xor i32 %narrow, %and377.pre-phi, !dbg !164
  %gep556.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 3072, !dbg !165
  %add.ptr410.idx.3 = shl nuw nsw i32 %xor406.3, 4, !dbg !165
  %add.ptr410.3 = getelementptr inbounds i8, ptr addrspace(3) %gep556.3, i32 %add.ptr410.idx.3, !dbg !165
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %141, !dbg !182
  %add.ptr422.3 = getelementptr inbounds i8, ptr addrspace(1) %146, i64 3072, !dbg !182
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr422.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr410.3, i64 16, i1 false), !dbg !183, !tbaa.struct !184, !call_argsrelate !185
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
!1 = !DIFile(filename: "/tmp/tmpivf37iyi/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpivf37iyi/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 23, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 48, scope: !40)
!45 = !DILocation(line: 24, column: 34, scope: !40)
!46 = !DILocation(line: 26, column: 51, scope: !40)
!47 = !DILocation(line: 26, column: 59, scope: !40)
!48 = !DILocation(line: 26, column: 23, scope: !40)
!49 = !DILocation(line: 26, column: 15, scope: !40)
!50 = !DILocation(line: 27, column: 31, scope: !40)
!51 = !DILocation(line: 27, column: 59, scope: !40)
!52 = !DILocation(line: 27, column: 65, scope: !40)
!53 = !DILocation(line: 28, column: 7, scope: !40)
!54 = !DILocation(line: 30, column: 5, scope: !40)
!55 = !DILocation(line: 31, column: 53, scope: !40)
!56 = !DILocation(line: 31, column: 32, scope: !40)
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
!81 = !DILocation(line: 65, column: 53, scope: !40)
!82 = !DILocation(line: 65, column: 32, scope: !40)
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
