; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261015_goal8933/validation_v13_final/actual_binary/oj6_m1_p1.bc'
source_filename = "/tmp/tmpbadbk9cr/tvm_kernels.maca"
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
  %cmp20 = icmp ult i32 %19, 32
  br i1 %cmp20, label %land.rhs, label %if.else337, !dbg !49

land.rhs:                                         ; preds = %entry
  %mul21 = shl nuw nsw i32 %19, 5, !dbg !50
  %cmp23.not = icmp ugt i32 %mul21, %1, !dbg !51
  br i1 %cmp23.not, label %if.else337, label %for.cond24.preheader, !dbg !52

for.cond24.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul30 = shl nuw nsw i64 %conv, 18
  %20 = shl nuw nsw i32 %19, 13
  %mul32 = zext nneg i32 %20 to i64
  %add33 = or disjoint i64 %mul30, %mul32
  %21 = shl nuw nsw i32 %2, 3
  %mul39 = zext nneg i32 %21 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul39, !dbg !53
  %22 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add33, !dbg !54
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %22, align 16, !dbg !55
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %22, i64 8, !dbg !55
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8, !dbg !55
  %gep.1 = getelementptr i8, ptr addrspace(4) %22, i64 1024, !dbg !54
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !55
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 1032, !dbg !55
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8, !dbg !55
  %gep.2 = getelementptr i8, ptr addrspace(4) %22, i64 2048, !dbg !54
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16, !dbg !55
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 2056, !dbg !55
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8, !dbg !55
  %gep.3 = getelementptr i8, ptr addrspace(4) %22, i64 3072, !dbg !54
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16, !dbg !55
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 3080, !dbg !55
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8, !dbg !55
  %gep.4 = getelementptr i8, ptr addrspace(4) %22, i64 4096, !dbg !54
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16, !dbg !55
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 4104, !dbg !55
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8, !dbg !55
  %gep.5 = getelementptr i8, ptr addrspace(4) %22, i64 5120, !dbg !54
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16, !dbg !55
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 5128, !dbg !55
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8, !dbg !55
  %gep.6 = getelementptr i8, ptr addrspace(4) %22, i64 6144, !dbg !54
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16, !dbg !55
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 6152, !dbg !55
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8, !dbg !55
  %gep.7 = getelementptr i8, ptr addrspace(4) %22, i64 7168, !dbg !54
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16, !dbg !55
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 7176, !dbg !55
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8, !dbg !55
  %and = lshr i32 %2, 1
  %shr63 = and i32 %and, 15
  %shr66 = lshr i32 %2, 5
  %add61 = and i32 %mul10, 3972
  %xor = xor i32 %shr66, %shr63, !dbg !56
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add61, !dbg !57
  %add.ptr75.idx = shl nuw nsw i32 %xor, 4, !dbg !57
  %add.ptr75 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 %add.ptr75.idx, !dbg !57
  store i64 %4, ptr addrspace(3) %add.ptr75, align 8, !dbg !58
  %add67.1 = add nuw nsw i32 %shr66, 2, !dbg !59
  %xor.1 = xor i32 %add67.1, %shr63, !dbg !56
  %24 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 512, !dbg !57
  %add.ptr75.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !57
  %add.ptr75.1 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr75.idx.1, !dbg !57
  store i64 %6, ptr addrspace(3) %add.ptr75.1, align 8, !dbg !58
  %add67.2 = add nuw nsw i32 %shr66, 4, !dbg !59
  %xor.2 = xor i32 %add67.2, %shr63, !dbg !56
  %25 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 1024, !dbg !57
  %add.ptr75.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !57
  %add.ptr75.2 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr75.idx.2, !dbg !57
  store i64 %8, ptr addrspace(3) %add.ptr75.2, align 8, !dbg !58
  %add67.3 = add nuw nsw i32 %shr66, 6, !dbg !59
  %xor.3 = xor i32 %add67.3, %shr63, !dbg !56
  %26 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 1536, !dbg !57
  %add.ptr75.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !57
  %add.ptr75.3 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr75.idx.3, !dbg !57
  store i64 %10, ptr addrspace(3) %add.ptr75.3, align 8, !dbg !58
  %add67.4 = add nuw nsw i32 %shr66, 8, !dbg !59
  %xor.4 = xor i32 %add67.4, %shr63, !dbg !56
  %27 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 2048, !dbg !57
  %add.ptr75.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !57
  %add.ptr75.4 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr75.idx.4, !dbg !57
  store i64 %12, ptr addrspace(3) %add.ptr75.4, align 8, !dbg !58
  %add67.5 = add nuw nsw i32 %shr66, 10, !dbg !59
  %xor.5 = xor i32 %add67.5, %shr63, !dbg !56
  %28 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 2560, !dbg !57
  %add.ptr75.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !57
  %add.ptr75.5 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr75.idx.5, !dbg !57
  store i64 %14, ptr addrspace(3) %add.ptr75.5, align 8, !dbg !58
  %add67.6 = add nuw nsw i32 %shr66, 12, !dbg !59
  %xor.6 = xor i32 %add67.6, %shr63, !dbg !56
  %29 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 3072, !dbg !57
  %add.ptr75.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !57
  %add.ptr75.6 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr75.idx.6, !dbg !57
  store i64 %16, ptr addrspace(3) %add.ptr75.6, align 8, !dbg !58
  %add67.7 = add nuw nsw i32 %shr66, 14, !dbg !59
  %xor.7 = xor i32 %add67.7, %shr63, !dbg !56
  %30 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 3584, !dbg !57
  %add.ptr75.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !57
  %add.ptr75.7 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr75.idx.7, !dbg !57
  store i64 %18, ptr addrspace(3) %add.ptr75.7, align 8, !dbg !58
  fence syncscope("warp") release, !dbg !60
  tail call void @llvm.mxc.barrier.warp(), !dbg !66
  fence syncscope("warp") acquire, !dbg !67
  %and85 = shl nuw nsw i32 %2, 7
  %mul86 = and i32 %and85, 1920
  %shr89 = lshr i32 %2, 4
  %and92 = and i32 %2, 15
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul86
  %xor93 = xor i32 %shr89, %and92, !dbg !68
  %add.ptr97.idx = shl nuw nsw i32 %xor93, 4, !dbg !69
  %add.ptr97 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx, !dbg !69
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97, align 16, !dbg !70
  %q.sroa.4.0.add.ptr97.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97, i32 8, !dbg !70
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr97.sroa_idx, align 8, !dbg !70
  %add90.1 = add nuw nsw i32 %shr89, 4, !dbg !71
  %xor93.1 = xor i32 %add90.1, %and92, !dbg !68
  %add.ptr97.idx.1 = shl nuw nsw i32 %xor93.1, 4, !dbg !69
  %add.ptr97.1 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx.1, !dbg !69
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.1, align 16, !dbg !70
  %q.sroa.7.16.add.ptr97.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.1, i32 8, !dbg !70
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr97.1.sroa_idx, align 8, !dbg !70
  %add90.2 = add nuw nsw i32 %shr89, 8, !dbg !71
  %xor93.2 = xor i32 %add90.2, %and92, !dbg !68
  %add.ptr97.idx.2 = shl nuw nsw i32 %xor93.2, 4, !dbg !69
  %add.ptr97.2 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx.2, !dbg !69
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.2, align 16, !dbg !70
  %q.sroa.10.32.add.ptr97.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.2, i32 8, !dbg !70
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr97.2.sroa_idx, align 8, !dbg !70
  %add90.3 = add nuw nsw i32 %shr89, 12, !dbg !71
  %xor93.3 = xor i32 %add90.3, %and92, !dbg !68
  %add.ptr97.idx.3 = shl nuw nsw i32 %xor93.3, 4, !dbg !69
  %add.ptr97.3 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx.3, !dbg !69
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.3, align 16, !dbg !70
  %q.sroa.13.48.add.ptr97.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.3, i32 8, !dbg !70
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr97.3.sroa_idx, align 8, !dbg !70
  %32 = lshr i32 %2, 2
  %mul118 = and i32 %32, 252
  %add115 = add nuw nsw i32 %mul21, %mul118
  %cmp123.not = icmp ugt i32 %add115, %1, !dbg !72
  %spec.select = select i1 %cmp123.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !74
  %cmp123.not.1.not = icmp ult i32 %add115, %1, !dbg !72
  %spec.select.1 = select i1 %cmp123.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !73
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !74
  %add119.2 = or disjoint i32 %add115, 2, !dbg !75
  %cmp123.not.2 = icmp ugt i32 %add119.2, %1, !dbg !72
  %spec.select.2 = select i1 %cmp123.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !74
  %add119.3 = or disjoint i32 %add115, 3, !dbg !75
  %cmp123.not.3 = icmp ugt i32 %add119.3, %1, !dbg !72
  %spec.select.3 = select i1 %cmp123.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !74
  %add121.4 = add nuw nsw i32 %add115, 16, !dbg !76
  %cmp123.not.4 = icmp ugt i32 %add121.4, %1, !dbg !72
  %spec.select.4 = select i1 %cmp123.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !74
  %add121.5 = add nuw nsw i32 %add115, 17, !dbg !76
  %cmp123.not.5 = icmp ugt i32 %add121.5, %1, !dbg !72
  %spec.select.5 = select i1 %cmp123.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1, !dbg !74
  %add121.6 = add nuw nsw i32 %add115, 18, !dbg !76
  %cmp123.not.6 = icmp ugt i32 %add121.6, %1, !dbg !72
  %spec.select.6 = select i1 %cmp123.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2, !dbg !74
  %add121.7 = add nuw nsw i32 %add115, 19, !dbg !76
  %cmp123.not.7 = icmp ugt i32 %add121.7, %1, !dbg !72
  %spec.select.7 = select i1 %cmp123.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3, !dbg !74
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !77, !call_argsrelate !78
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !77, !call_argsrelate !78
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %33), !dbg !77, !call_argsrelate !78
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %34), !dbg !77, !call_argsrelate !78
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %35), !dbg !77, !call_argsrelate !78
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %36), !dbg !77, !call_argsrelate !78
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %37), !dbg !77, !call_argsrelate !78
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %38), !dbg !77, !call_argsrelate !78
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %39), !dbg !77, !call_argsrelate !78
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %40), !dbg !77, !call_argsrelate !78
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %41), !dbg !77, !call_argsrelate !78
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %42), !dbg !77, !call_argsrelate !78
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %43), !dbg !77, !call_argsrelate !78
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %44), !dbg !77, !call_argsrelate !78
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %45), !dbg !77, !call_argsrelate !78
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %46), !dbg !77, !call_argsrelate !78
  %invariant.gep538 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192, !dbg !79
  %49 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep538, i64 %add33, !dbg !80
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %49, align 16, !dbg !81
  %v.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %49, i64 8, !dbg !81
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0..sroa_idx, align 8, !dbg !81
  %gep539.1 = getelementptr i8, ptr addrspace(4) %49, i64 1024, !dbg !80
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep539.1, align 16, !dbg !81
  %v.sroa.7.16.gep539.1.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 1032, !dbg !81
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.gep539.1.sroa_idx, align 8, !dbg !81
  %gep539.2 = getelementptr i8, ptr addrspace(4) %49, i64 2048, !dbg !80
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep539.2, align 16, !dbg !81
  %v.sroa.10.32.gep539.2.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 2056, !dbg !81
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.gep539.2.sroa_idx, align 8, !dbg !81
  %gep539.3 = getelementptr i8, ptr addrspace(4) %49, i64 3072, !dbg !80
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep539.3, align 16, !dbg !81
  %v.sroa.13.48.gep539.3.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 3080, !dbg !81
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.gep539.3.sroa_idx, align 8, !dbg !81
  %gep539.4 = getelementptr i8, ptr addrspace(4) %49, i64 4096, !dbg !80
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep539.4, align 16, !dbg !81
  %v.sroa.16.64.gep539.4.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 4104, !dbg !81
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.gep539.4.sroa_idx, align 8, !dbg !81
  %gep539.5 = getelementptr i8, ptr addrspace(4) %49, i64 5120, !dbg !80
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep539.5, align 16, !dbg !81
  %v.sroa.19.80.gep539.5.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 5128, !dbg !81
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.gep539.5.sroa_idx, align 8, !dbg !81
  %gep539.6 = getelementptr i8, ptr addrspace(4) %49, i64 6144, !dbg !80
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep539.6, align 16, !dbg !81
  %v.sroa.22.96.gep539.6.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 6152, !dbg !81
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.gep539.6.sroa_idx, align 8, !dbg !81
  %gep539.7 = getelementptr i8, ptr addrspace(4) %49, i64 7168, !dbg !80
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep539.7, align 16, !dbg !81
  %v.sroa.25.112.gep539.7.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 7176, !dbg !81
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.gep539.7.sroa_idx, align 8, !dbg !81
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %47, i64 0, !dbg !82
  %mul203 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !83
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul203, float 1.500000e+01), !dbg !84
  %cmp.i.i = fcmp contract olt float %50, -1.260000e+02, !dbg !88
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519 = fadd contract float %50, %cond.i.i, !dbg !88
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i519), !dbg !88
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i = fmul contract float %cond2.i.i, %51, !dbg !88
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %47, i64 1, !dbg !82
  %mul203.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !83
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul203.1, float 1.500000e+01), !dbg !84
  %cmp.i.i.1 = fcmp contract olt float %52, -1.260000e+02, !dbg !88
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519.1 = fadd contract float %52, %cond.i.i.1, !dbg !88
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i519.1), !dbg !88
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %53, !dbg !88
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %47, i64 2, !dbg !82
  %mul203.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !83
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul203.2, float 1.500000e+01), !dbg !84
  %cmp.i.i.2 = fcmp contract olt float %54, -1.260000e+02, !dbg !88
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519.2 = fadd contract float %54, %cond.i.i.2, !dbg !88
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i519.2), !dbg !88
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %55, !dbg !88
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %47, i64 3, !dbg !82
  %mul203.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !83
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul203.3, float 1.500000e+01), !dbg !84
  %cmp.i.i.3 = fcmp contract olt float %56, -1.260000e+02, !dbg !88
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519.3 = fadd contract float %56, %cond.i.i.3, !dbg !88
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i519.3), !dbg !88
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %57, !dbg !88
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %48, i64 0, !dbg !82
  %mul203.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !83
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul203.4, float 1.500000e+01), !dbg !84
  %cmp.i.i.4 = fcmp contract olt float %58, -1.260000e+02, !dbg !88
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519.4 = fadd contract float %58, %cond.i.i.4, !dbg !88
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i519.4), !dbg !88
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %59, !dbg !88
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %48, i64 1, !dbg !82
  %mul203.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !83
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul203.5, float 1.500000e+01), !dbg !84
  %cmp.i.i.5 = fcmp contract olt float %60, -1.260000e+02, !dbg !88
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519.5 = fadd contract float %60, %cond.i.i.5, !dbg !88
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i519.5), !dbg !88
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %61, !dbg !88
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %48, i64 2, !dbg !82
  %mul203.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !83
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul203.6, float 1.500000e+01), !dbg !84
  %cmp.i.i.6 = fcmp contract olt float %62, -1.260000e+02, !dbg !88
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519.6 = fadd contract float %62, %cond.i.i.6, !dbg !88
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i519.6), !dbg !88
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %63, !dbg !88
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %48, i64 3, !dbg !82
  %mul203.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !83
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul203.7, float 1.500000e+01), !dbg !84
  %cmp.i.i.7 = fcmp contract olt float %64, -1.260000e+02, !dbg !88
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !88
  %add.i.i519.7 = fadd contract float %64, %cond.i.i.7, !dbg !88
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i519.7), !dbg !88
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !88
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %65, !dbg !88
  %add223 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !91
  %add223.1 = fadd contract float %add223, %mul.i.i.4, !dbg !91
  %add223.2 = fadd contract float %add223.1, %mul.i.i.1, !dbg !91
  %add223.3 = fadd contract float %add223.2, %mul.i.i.5, !dbg !91
  %add223.4 = fadd contract float %add223.3, %mul.i.i.2, !dbg !91
  %add223.5 = fadd contract float %add223.4, %mul.i.i.6, !dbg !91
  %add223.6 = fadd contract float %add223.5, %mul.i.i.3, !dbg !91
  %add223.7 = fadd contract float %add223.6, %mul.i.i.7, !dbg !91
  %66 = bitcast float %add223.7 to i32, !dbg !92
  %67 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !103
  %68 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %67) #11, !dbg !108
  %xor.i.i = xor i32 %68, 32, !dbg !109
  %69 = and i32 %68, -64, !dbg !110
  %and.i.i = add nsw i32 %69, 64, !dbg !110
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !111
  %cond.i.i520 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %68, !dbg !112
  %shl.i.i = shl i32 %cond.i.i520, 2, !dbg !113
  %70 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %66), !dbg !114
  %71 = bitcast i32 %70 to float, !dbg !115
  %add.i = fadd contract float %add223.7, %71, !dbg !116
  %72 = bitcast float %add.i to i32, !dbg !119
  %73 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !126
  %74 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %73) #11, !dbg !129
  %xor.i.i521 = xor i32 %74, 16, !dbg !130
  %75 = and i32 %74, -64, !dbg !131
  %and.i.i522 = add nsw i32 %75, 64, !dbg !131
  %cmp.not.i.i523 = icmp slt i32 %xor.i.i521, %and.i.i522, !dbg !132
  %cond.i.i524 = select i1 %cmp.not.i.i523, i32 %xor.i.i521, i32 %74, !dbg !133
  %shl.i.i525 = shl i32 %cond.i.i524, 2, !dbg !134
  %76 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i525, i32 %72), !dbg !135
  %77 = bitcast i32 %76 to float, !dbg !136
  %add.i.i = fadd contract float %add.i, %77, !dbg !137
  %cmp232 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !139
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !140
  %condval_1.0 = select i1 %cmp232, float %div, float 0.000000e+00, !dbg !140
  %mul245 = fmul contract float %condval_1.0, %mul.i.i, !dbg !141
  %mul245.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !141
  %mul245.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !141
  %mul245.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !141
  %mul245.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !141
  %mul245.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !141
  %mul245.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !141
  %mul245.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !141
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245), !dbg !142
  %79 = insertelement <4 x i16> poison, i16 %78, i64 0, !dbg !151
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.1), !dbg !142
  %81 = insertelement <4 x i16> %79, i16 %80, i64 1, !dbg !151
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.2), !dbg !142
  %83 = insertelement <4 x i16> %81, i16 %82, i64 2, !dbg !151
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.3), !dbg !142
  %85 = insertelement <4 x i16> %83, i16 %84, i64 3, !dbg !151
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %85 to <4 x half>, !dbg !151
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.4), !dbg !142
  %87 = insertelement <4 x i16> poison, i16 %86, i64 0, !dbg !151
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.5), !dbg !142
  %89 = insertelement <4 x i16> %87, i16 %88, i64 1, !dbg !151
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.6), !dbg !142
  %91 = insertelement <4 x i16> %89, i16 %90, i64 2, !dbg !151
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.7), !dbg !142
  %93 = insertelement <4 x i16> %91, i16 %92, i64 3, !dbg !151
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %93 to <4 x half>, !dbg !151
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !78
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %94), !dbg !152, !call_argsrelate !78
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %95), !dbg !152, !call_argsrelate !78
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %96), !dbg !152, !call_argsrelate !78
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %97), !dbg !152, !call_argsrelate !78
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %98), !dbg !152, !call_argsrelate !78
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %99), !dbg !152, !call_argsrelate !78
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %100), !dbg !152, !call_argsrelate !78
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %101), !dbg !152, !call_argsrelate !78
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !153
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !154
  %output_reg.sroa.0.0.insert.ext = zext i16 %110 to i64, !dbg !158
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !153
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !154
  %output_reg.sroa.0.2.insert.ext = zext i16 %111 to i64, !dbg !158
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !158
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !158
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !153
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !154
  %output_reg.sroa.0.4.insert.ext = zext i16 %112 to i64, !dbg !158
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !158
  %output_reg.sroa.0.4.insert.insert644 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !158
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !153
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !154
  %output_reg.sroa.0.6.insert.ext = zext i16 %113 to i64, !dbg !158
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !158
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert644, %output_reg.sroa.0.6.insert.shift, !dbg !158
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %103, i64 0, !dbg !153
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !154
  %output_reg.sroa.9.8.insert.ext = zext i16 %114 to i64, !dbg !158
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %103, i64 1, !dbg !153
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !154
  %output_reg.sroa.9.10.insert.ext = zext i16 %115 to i64, !dbg !158
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16, !dbg !158
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext, !dbg !158
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %103, i64 2, !dbg !153
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !154
  %output_reg.sroa.9.12.insert.ext = zext i16 %116 to i64, !dbg !158
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32, !dbg !158
  %output_reg.sroa.9.12.insert.insert650 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift, !dbg !158
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %103, i64 3, !dbg !153
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !154
  %output_reg.sroa.9.14.insert.ext = zext i16 %117 to i64, !dbg !158
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48, !dbg !158
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert650, %output_reg.sroa.9.14.insert.shift, !dbg !158
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %104, i64 0, !dbg !153
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !154
  %output_reg.sroa.16.16.insert.ext = zext i16 %118 to i64, !dbg !158
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %104, i64 1, !dbg !153
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !154
  %output_reg.sroa.16.18.insert.ext = zext i16 %119 to i64, !dbg !158
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16, !dbg !158
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext, !dbg !158
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %104, i64 2, !dbg !153
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !154
  %output_reg.sroa.16.20.insert.ext = zext i16 %120 to i64, !dbg !158
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32, !dbg !158
  %output_reg.sroa.16.20.insert.insert656 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift, !dbg !158
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %104, i64 3, !dbg !153
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !154
  %output_reg.sroa.16.22.insert.ext = zext i16 %121 to i64, !dbg !158
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48, !dbg !158
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert656, %output_reg.sroa.16.22.insert.shift, !dbg !158
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %105, i64 0, !dbg !153
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !154
  %output_reg.sroa.23.24.insert.ext = zext i16 %122 to i64, !dbg !158
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %105, i64 1, !dbg !153
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !154
  %output_reg.sroa.23.26.insert.ext = zext i16 %123 to i64, !dbg !158
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16, !dbg !158
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext, !dbg !158
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %105, i64 2, !dbg !153
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !154
  %output_reg.sroa.23.28.insert.ext = zext i16 %124 to i64, !dbg !158
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32, !dbg !158
  %output_reg.sroa.23.28.insert.insert662 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift, !dbg !158
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %105, i64 3, !dbg !153
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !154
  %output_reg.sroa.23.30.insert.ext = zext i16 %125 to i64, !dbg !158
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48, !dbg !158
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert662, %output_reg.sroa.23.30.insert.shift, !dbg !158
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %106, i64 0, !dbg !153
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !154
  %output_reg.sroa.30.32.insert.ext = zext i16 %126 to i64, !dbg !158
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %106, i64 1, !dbg !153
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !154
  %output_reg.sroa.30.34.insert.ext = zext i16 %127 to i64, !dbg !158
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16, !dbg !158
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext, !dbg !158
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %106, i64 2, !dbg !153
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !154
  %output_reg.sroa.30.36.insert.ext = zext i16 %128 to i64, !dbg !158
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32, !dbg !158
  %output_reg.sroa.30.36.insert.insert668 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift, !dbg !158
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %106, i64 3, !dbg !153
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !154
  %output_reg.sroa.30.38.insert.ext = zext i16 %129 to i64, !dbg !158
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48, !dbg !158
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert668, %output_reg.sroa.30.38.insert.shift, !dbg !158
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %107, i64 0, !dbg !153
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !154
  %output_reg.sroa.37.40.insert.ext = zext i16 %130 to i64, !dbg !158
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %107, i64 1, !dbg !153
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !154
  %output_reg.sroa.37.42.insert.ext = zext i16 %131 to i64, !dbg !158
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16, !dbg !158
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext, !dbg !158
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %107, i64 2, !dbg !153
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !154
  %output_reg.sroa.37.44.insert.ext = zext i16 %132 to i64, !dbg !158
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32, !dbg !158
  %output_reg.sroa.37.44.insert.insert674 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift, !dbg !158
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %107, i64 3, !dbg !153
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !154
  %output_reg.sroa.37.46.insert.ext = zext i16 %133 to i64, !dbg !158
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48, !dbg !158
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert674, %output_reg.sroa.37.46.insert.shift, !dbg !158
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %108, i64 0, !dbg !153
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !154
  %output_reg.sroa.44.48.insert.ext = zext i16 %134 to i64, !dbg !158
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %108, i64 1, !dbg !153
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !154
  %output_reg.sroa.44.50.insert.ext = zext i16 %135 to i64, !dbg !158
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16, !dbg !158
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext, !dbg !158
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %108, i64 2, !dbg !153
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !154
  %output_reg.sroa.44.52.insert.ext = zext i16 %136 to i64, !dbg !158
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32, !dbg !158
  %output_reg.sroa.44.52.insert.insert680 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift, !dbg !158
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %108, i64 3, !dbg !153
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !154
  %output_reg.sroa.44.54.insert.ext = zext i16 %137 to i64, !dbg !158
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48, !dbg !158
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert680, %output_reg.sroa.44.54.insert.shift, !dbg !158
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %109, i64 0, !dbg !153
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !154
  %output_reg.sroa.51.56.insert.ext = zext i16 %138 to i64, !dbg !158
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %109, i64 1, !dbg !153
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !154
  %output_reg.sroa.51.58.insert.ext = zext i16 %139 to i64, !dbg !158
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16, !dbg !158
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext, !dbg !158
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %109, i64 2, !dbg !153
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !154
  %output_reg.sroa.51.60.insert.ext = zext i16 %140 to i64, !dbg !158
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32, !dbg !158
  %output_reg.sroa.51.60.insert.insert686 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift, !dbg !158
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %109, i64 3, !dbg !153
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !154
  %output_reg.sroa.51.62.insert.ext = zext i16 %141 to i64, !dbg !158
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48, !dbg !158
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert686, %output_reg.sroa.51.62.insert.shift, !dbg !158
  br label %if.end359, !dbg !159

if.else337:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre793 = and i32 %.pre, 1920
  %.pre794 = lshr i32 %2, 5
  %.pre795 = and i32 %2, 15
  %.pre796 = lshr i32 %2, 2
  %.pre797 = add nuw nsw i32 %.pre794, 2, !dbg !162
  %.pre798 = add nuw nsw i32 %.pre794, 4, !dbg !162
  %.pre799 = add nuw nsw i32 %.pre794, 6, !dbg !162
  %.pre800 = add nuw nsw i32 %.pre794, 8, !dbg !162
  %.pre801 = add nuw nsw i32 %.pre794, 10, !dbg !162
  %.pre802 = add nuw nsw i32 %.pre794, 12, !dbg !162
  %.pre803 = add nuw nsw i32 %.pre794, 14, !dbg !162
  %.pre804 = shl nuw nsw i32 %2, 3
  %.pre806 = lshr i32 %2, 4
  %.pre807 = xor i32 %.pre806, %.pre795, !dbg !163
  %.pre808 = shl nuw nsw i32 %.pre807, 4, !dbg !164
  br label %if.end359, !dbg !159

if.end359:                                        ; preds = %for.cond24.preheader, %if.else337
  %add.ptr409.idx.pre-phi = phi i32 [ %add.ptr97.idx, %for.cond24.preheader ], [ %.pre808, %if.else337 ], !dbg !164
  %shr403.pre-phi = phi i32 [ %shr89, %for.cond24.preheader ], [ %.pre806, %if.else337 ]
  %.pre-phi805 = phi i32 [ %21, %for.cond24.preheader ], [ %.pre804, %if.else337 ]
  %add374.7.pre-phi = phi i32 [ %add67.7, %for.cond24.preheader ], [ %.pre803, %if.else337 ], !dbg !162
  %add374.6.pre-phi = phi i32 [ %add67.6, %for.cond24.preheader ], [ %.pre802, %if.else337 ], !dbg !162
  %add374.5.pre-phi = phi i32 [ %add67.5, %for.cond24.preheader ], [ %.pre801, %if.else337 ], !dbg !162
  %add374.4.pre-phi = phi i32 [ %add67.4, %for.cond24.preheader ], [ %.pre800, %if.else337 ], !dbg !162
  %add374.3.pre-phi = phi i32 [ %add67.3, %for.cond24.preheader ], [ %.pre799, %if.else337 ], !dbg !162
  %add374.2.pre-phi = phi i32 [ %add67.2, %for.cond24.preheader ], [ %.pre798, %if.else337 ], !dbg !162
  %add374.1.pre-phi = phi i32 [ %add67.1, %for.cond24.preheader ], [ %.pre797, %if.else337 ], !dbg !162
  %.pre-phi = phi i32 [ %32, %for.cond24.preheader ], [ %.pre796, %if.else337 ]
  %and376.pre-phi = phi i32 [ %and92, %for.cond24.preheader ], [ %.pre795, %if.else337 ]
  %shr373.pre-phi = phi i32 [ %shr66, %for.cond24.preheader ], [ %.pre794, %if.else337 ]
  %mul370.pre-phi = phi i32 [ %mul86, %for.cond24.preheader ], [ %.pre793, %if.else337 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond24.preheader ], [ 0, %if.else337 ], !dbg !165
  fence syncscope("warp") release, !dbg !159
  tail call void @llvm.mxc.barrier.warp(), !dbg !166
  fence syncscope("warp") acquire, !dbg !167
  %mul383 = and i32 %.pre-phi, 4
  %xor377 = xor i32 %shr373.pre-phi, %and376.pre-phi, !dbg !168
  %mul378 = shl nuw nsw i32 %xor377, 3, !dbg !169
  %add379 = add nuw nsw i32 %mul378, %mul370.pre-phi, !dbg !170
  %add384 = or disjoint i32 %add379, %mul383, !dbg !171
  %add.ptr386 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384, !dbg !172
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr386, align 8, !dbg !173
  %xor377.1 = xor i32 %add374.1.pre-phi, %and376.pre-phi, !dbg !168
  %mul378.1 = shl nuw nsw i32 %xor377.1, 3, !dbg !169
  %add379.1 = add nuw nsw i32 %mul378.1, %mul370.pre-phi, !dbg !170
  %add384.1 = or disjoint i32 %add379.1, %mul383, !dbg !171
  %add.ptr386.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384.1, !dbg !172
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr386.1, align 8, !dbg !173
  %xor377.2 = xor i32 %add374.2.pre-phi, %and376.pre-phi, !dbg !168
  %mul378.2 = shl nuw nsw i32 %xor377.2, 3, !dbg !169
  %add379.2 = add nuw nsw i32 %mul378.2, %mul370.pre-phi, !dbg !170
  %add384.2 = or disjoint i32 %add379.2, %mul383, !dbg !171
  %add.ptr386.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384.2, !dbg !172
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr386.2, align 8, !dbg !173
  %xor377.3 = xor i32 %add374.3.pre-phi, %and376.pre-phi, !dbg !168
  %mul378.3 = shl nuw nsw i32 %xor377.3, 3, !dbg !169
  %add379.3 = add nuw nsw i32 %mul378.3, %mul370.pre-phi, !dbg !170
  %add384.3 = or disjoint i32 %add379.3, %mul383, !dbg !171
  %add.ptr386.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384.3, !dbg !172
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr386.3, align 8, !dbg !173
  %xor377.4 = xor i32 %add374.4.pre-phi, %and376.pre-phi, !dbg !168
  %mul378.4 = shl nuw nsw i32 %xor377.4, 3, !dbg !169
  %add379.4 = add nuw nsw i32 %mul378.4, %mul370.pre-phi, !dbg !170
  %add384.4 = or disjoint i32 %add379.4, %mul383, !dbg !171
  %add.ptr386.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384.4, !dbg !172
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr386.4, align 8, !dbg !173
  %xor377.5 = xor i32 %add374.5.pre-phi, %and376.pre-phi, !dbg !168
  %mul378.5 = shl nuw nsw i32 %xor377.5, 3, !dbg !169
  %add379.5 = add nuw nsw i32 %mul378.5, %mul370.pre-phi, !dbg !170
  %add384.5 = or disjoint i32 %add379.5, %mul383, !dbg !171
  %add.ptr386.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384.5, !dbg !172
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr386.5, align 8, !dbg !173
  %xor377.6 = xor i32 %add374.6.pre-phi, %and376.pre-phi, !dbg !168
  %mul378.6 = shl nuw nsw i32 %xor377.6, 3, !dbg !169
  %add379.6 = add nuw nsw i32 %mul378.6, %mul370.pre-phi, !dbg !170
  %add384.6 = or disjoint i32 %add379.6, %mul383, !dbg !171
  %add.ptr386.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384.6, !dbg !172
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr386.6, align 8, !dbg !173
  %xor377.7 = xor i32 %add374.7.pre-phi, %and376.pre-phi, !dbg !168
  %mul378.7 = shl nuw nsw i32 %xor377.7, 3, !dbg !169
  %add379.7 = add nuw nsw i32 %mul378.7, %mul370.pre-phi, !dbg !170
  %add384.7 = or disjoint i32 %add379.7, %mul383, !dbg !171
  %add.ptr386.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add384.7, !dbg !172
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr386.7, align 8, !dbg !173
  fence syncscope("warp") release, !dbg !174
  tail call void @llvm.mxc.barrier.warp(), !dbg !177
  fence syncscope("warp") acquire, !dbg !178
  %mul397 = and i32 %.pre-phi805, 8064
  %invariant.gep554 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul397, !dbg !179
  %add416 = add nuw nsw i32 %add, %.pre-phi805
  %142 = zext nneg i32 %add416 to i64, !dbg !180
  %add.ptr409 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep554, i32 %add.ptr409.idx.pre-phi, !dbg !164
  %add.ptr421 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %142, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr421, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr409, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
  %143 = add nuw nsw i32 %shr403.pre-phi, 4, !dbg !185
  %xor405.1 = xor i32 %143, %and376.pre-phi, !dbg !163
  %gep555.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep554, i32 1024, !dbg !164
  %add.ptr409.idx.1 = shl nuw nsw i32 %xor405.1, 4, !dbg !164
  %add.ptr409.1 = getelementptr inbounds i8, ptr addrspace(3) %gep555.1, i32 %add.ptr409.idx.1, !dbg !164
  %144 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %142, !dbg !181
  %add.ptr421.1 = getelementptr inbounds i8, ptr addrspace(1) %144, i64 1024, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr421.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr409.1, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
  %145 = add nuw nsw i32 %shr403.pre-phi, 8, !dbg !185
  %xor405.2 = xor i32 %145, %and376.pre-phi, !dbg !163
  %gep555.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep554, i32 2048, !dbg !164
  %add.ptr409.idx.2 = shl nuw nsw i32 %xor405.2, 4, !dbg !164
  %add.ptr409.2 = getelementptr inbounds i8, ptr addrspace(3) %gep555.2, i32 %add.ptr409.idx.2, !dbg !164
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %142, !dbg !181
  %add.ptr421.2 = getelementptr inbounds i8, ptr addrspace(1) %146, i64 2048, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr421.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr409.2, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
  %narrow = add nuw nsw i32 %shr403.pre-phi, 12, !dbg !185
  %xor405.3 = xor i32 %narrow, %and376.pre-phi, !dbg !163
  %gep555.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep554, i32 3072, !dbg !164
  %add.ptr409.idx.3 = shl nuw nsw i32 %xor405.3, 4, !dbg !164
  %add.ptr409.3 = getelementptr inbounds i8, ptr addrspace(3) %gep555.3, i32 %add.ptr409.idx.3, !dbg !164
  %147 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %142, !dbg !181
  %add.ptr421.3 = getelementptr inbounds i8, ptr addrspace(1) %147, i64 3072, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr421.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr409.3, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
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
!1 = !DIFile(filename: "/tmp/tmpbadbk9cr/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpbadbk9cr/tvm_kernels.maca", directory: "")
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
!53 = !DILocation(line: 30, column: 5, scope: !40)
!54 = !DILocation(line: 31, column: 53, scope: !40)
!55 = !DILocation(line: 31, column: 32, scope: !40)
!56 = !DILocation(line: 35, column: 133, scope: !40)
!57 = !DILocation(line: 35, column: 42, scope: !40)
!58 = !DILocation(line: 35, column: 217, scope: !40)
!59 = !DILocation(line: 35, column: 146, scope: !40)
!60 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !63)
!61 = distinct !DISubprogram(name: "__barrier_warp", scope: !62, file: !62, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!62 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!63 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !65)
!64 = distinct !DISubprogram(name: "__syncwarp", scope: !62, file: !62, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = distinct !DILocation(line: 37, column: 5, scope: !40)
!66 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !63)
!67 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !63)
!68 = !DILocation(line: 40, column: 150, scope: !40)
!69 = !DILocation(line: 40, column: 69, scope: !40)
!70 = !DILocation(line: 40, column: 32, scope: !40)
!71 = !DILocation(line: 40, column: 121, scope: !40)
!72 = !DILocation(line: 45, column: 114, scope: !40)
!73 = !DILocation(line: 45, column: 11, scope: !40)
!74 = !DILocation(line: 50, column: 19, scope: !40)
!75 = !DILocation(line: 45, column: 66, scope: !40)
!76 = !DILocation(line: 45, column: 101, scope: !40)
!77 = !DILocation(line: 56, column: 37, scope: !40)
!78 = !{i32 2, i32 -1, i32 -1}
!79 = !DILocation(line: 64, column: 5, scope: !40)
!80 = !DILocation(line: 65, column: 53, scope: !40)
!81 = !DILocation(line: 65, column: 32, scope: !40)
!82 = !DILocation(line: 69, column: 32, scope: !40)
!83 = !DILocation(line: 69, column: 44, scope: !40)
!84 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !87)
!85 = distinct !DISubprogram(name: "min", scope: !86, file: !86, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!86 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!87 = distinct !DILocation(line: 69, column: 27, scope: !40)
!88 = !DILocation(line: 285, column: 49, scope: !89, inlinedAt: !90)
!89 = distinct !DISubprogram(name: "exp2f", scope: !86, file: !86, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!90 = distinct !DILocation(line: 69, column: 21, scope: !40)
!91 = !DILocation(line: 74, column: 28, scope: !40)
!92 = !DILocation(line: 1018, column: 9, scope: !93, inlinedAt: !94)
!93 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !62, file: !62, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!94 = distinct !DILocation(line: 396, column: 10, scope: !95, inlinedAt: !97)
!95 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !96, file: !96, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!97 = distinct !DILocation(line: 129, column: 24, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !99, file: !99, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!100 = distinct !DILocation(line: 101, column: 14, scope: !101, inlinedAt: !102)
!101 = distinct !DISubprogram(name: "run<float>", scope: !99, file: !99, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = distinct !DILocation(line: 76, column: 16, scope: !40)
!103 = !DILocation(line: 171, column: 37, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "__lane_id", scope: !62, file: !62, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = distinct !DILocation(line: 990, column: 14, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !62, file: !62, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = distinct !DILocation(line: 1019, column: 11, scope: !93, inlinedAt: !94)
!108 = !DILocation(line: 171, column: 10, scope: !104, inlinedAt: !105)
!109 = !DILocation(line: 991, column: 20, scope: !106, inlinedAt: !107)
!110 = !DILocation(line: 992, column: 36, scope: !106, inlinedAt: !107)
!111 = !DILocation(line: 992, column: 17, scope: !106, inlinedAt: !107)
!112 = !DILocation(line: 992, column: 11, scope: !106, inlinedAt: !107)
!113 = !DILocation(line: 993, column: 43, scope: !106, inlinedAt: !107)
!114 = !DILocation(line: 993, column: 10, scope: !106, inlinedAt: !107)
!115 = !DILocation(line: 1020, column: 14, scope: !93, inlinedAt: !94)
!116 = !DILocation(line: 25, column: 14, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "operator()<float>", scope: !99, file: !99, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = distinct !DILocation(line: 129, column: 11, scope: !98, inlinedAt: !100)
!119 = !DILocation(line: 1018, column: 9, scope: !93, inlinedAt: !120)
!120 = distinct !DILocation(line: 396, column: 10, scope: !95, inlinedAt: !121)
!121 = distinct !DILocation(line: 129, column: 24, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !99, file: !99, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 101, column: 14, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "run<float>", scope: !99, file: !99, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = distinct !DILocation(line: 134, column: 14, scope: !98, inlinedAt: !100)
!126 = !DILocation(line: 171, column: 37, scope: !104, inlinedAt: !127)
!127 = distinct !DILocation(line: 990, column: 14, scope: !106, inlinedAt: !128)
!128 = distinct !DILocation(line: 1019, column: 11, scope: !93, inlinedAt: !120)
!129 = !DILocation(line: 171, column: 10, scope: !104, inlinedAt: !127)
!130 = !DILocation(line: 991, column: 20, scope: !106, inlinedAt: !128)
!131 = !DILocation(line: 992, column: 36, scope: !106, inlinedAt: !128)
!132 = !DILocation(line: 992, column: 17, scope: !106, inlinedAt: !128)
!133 = !DILocation(line: 992, column: 11, scope: !106, inlinedAt: !128)
!134 = !DILocation(line: 993, column: 43, scope: !106, inlinedAt: !128)
!135 = !DILocation(line: 993, column: 10, scope: !106, inlinedAt: !128)
!136 = !DILocation(line: 1020, column: 14, scope: !93, inlinedAt: !120)
!137 = !DILocation(line: 25, column: 14, scope: !117, inlinedAt: !138)
!138 = distinct !DILocation(line: 129, column: 11, scope: !122, inlinedAt: !123)
!139 = !DILocation(line: 78, column: 34, scope: !40)
!140 = !DILocation(line: 78, column: 9, scope: !40)
!141 = !DILocation(line: 86, column: 34, scope: !40)
!142 = !DILocation(line: 75, column: 10, scope: !143, inlinedAt: !145)
!143 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !144, file: !144, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!144 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!145 = distinct !DILocation(line: 984, column: 9, scope: !146, inlinedAt: !148)
!146 = distinct !DISubprogram(name: "__float2half", scope: !147, file: !147, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!147 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!148 = distinct !DILocation(line: 133, column: 53, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__half", scope: !147, file: !147, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 92, column: 49, scope: !40)
!151 = !DILocation(line: 92, column: 46, scope: !40)
!152 = !DILocation(line: 103, column: 36, scope: !40)
!153 = !DILocation(line: 113, column: 67, scope: !40)
!154 = !DILocation(line: 75, column: 10, scope: !143, inlinedAt: !155)
!155 = distinct !DILocation(line: 984, column: 9, scope: !146, inlinedAt: !156)
!156 = distinct !DILocation(line: 133, column: 53, scope: !149, inlinedAt: !157)
!157 = distinct !DILocation(line: 113, column: 59, scope: !40)
!158 = !DILocation(line: 113, column: 56, scope: !40)
!159 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !160)
!160 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !161)
!161 = distinct !DILocation(line: 123, column: 3, scope: !40)
!162 = !DILocation(line: 126, column: 94, scope: !40)
!163 = !DILocation(line: 131, column: 253, scope: !40)
!164 = !DILocation(line: 131, column: 169, scope: !40)
!165 = !DILocation(line: 0, scope: !40)
!166 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !160)
!167 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !160)
!168 = !DILocation(line: 126, column: 123, scope: !40)
!169 = !DILocation(line: 126, column: 152, scope: !40)
!170 = !DILocation(line: 126, column: 78, scope: !40)
!171 = !DILocation(line: 126, column: 158, scope: !40)
!172 = !DILocation(line: 126, column: 40, scope: !40)
!173 = !DILocation(line: 126, column: 201, scope: !40)
!174 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !175)
!175 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !176)
!176 = distinct !DILocation(line: 128, column: 3, scope: !40)
!177 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !175)
!178 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !175)
!179 = !DILocation(line: 130, column: 8, scope: !40)
!180 = !DILocation(line: 130, column: 3, scope: !40)
!181 = !DILocation(line: 131, column: 22, scope: !40)
!182 = !DILocation(line: 131, column: 132, scope: !40)
!183 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!184 = !{i32 1, i32 -1, i32 -1, i32 -1}
!185 = !DILocation(line: 131, column: 267, scope: !40)
!186 = !DILocation(line: 133, column: 1, scope: !40)
