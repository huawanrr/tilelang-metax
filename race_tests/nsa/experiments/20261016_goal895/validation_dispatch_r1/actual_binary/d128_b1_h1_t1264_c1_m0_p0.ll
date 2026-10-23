; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d128_b1_h1_t1264_c1_m0_p0.bc'
source_filename = "/tmp/tmpd8z8wfvs/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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
  %mul = shl nsw i32 %0, 11
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %1, 7
  %mul7 = and i32 %and, 1920
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 128, !dbg !44
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16, !dbg !45
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 136, !dbg !45
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8, !dbg !45
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 192, !dbg !44
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16, !dbg !45
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 200, !dbg !45
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8, !dbg !45
  %idxprom = zext nneg i32 %0 to i64, !dbg !46
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !46
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !46, !tbaa !30
  %mul17 = shl nsw i32 %7, 4, !dbg !47
  %cmp31 = icmp sgt i32 %7, -1, !dbg !48
  br i1 %cmp31, label %land.lhs.true, label %if.end371, !dbg !49

land.lhs.true:                                    ; preds = %entry
  %cmp32 = icmp ugt i32 %7, 78, !dbg !50
  %cmp35.not = icmp sgt i32 %mul17, %0
  %or.cond = select i1 %cmp32, i1 true, i1 %cmp35.not, !dbg !51
  br i1 %or.cond, label %if.end371, label %for.cond36.preheader, !dbg !51

for.cond36.preheader:                             ; preds = %land.lhs.true
  %shr42 = lshr i32 %1, 4
  %add43 = add nuw nsw i32 %mul17, %shr42
  %mul49 = shl nuw nsw i32 %7, 11
  %mul52 = shl nuw nsw i32 %1, 3
  %add50 = add nuw nsw i32 %mul49, %mul52
  %8 = zext nneg i32 %add50 to i64, !dbg !52
  %cmp46 = icmp ult i32 %add43, 1264, !dbg !53
  br i1 %cmp46, label %if.then47, label %if.end, !dbg !54

if.then47:                                        ; preds = %for.cond36.preheader
  %add.ptr55 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %condval.sroa.7.0.add.ptr55.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr55, i64 12
  %condval.sroa.6.0.add.ptr55.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr55, i64 8
  %condval.sroa.5.0.add.ptr55.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr55, i64 4
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr55, align 16, !dbg !55, !tbaa !30
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx, align 4, !dbg !55, !tbaa !30
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx, align 8, !dbg !55, !tbaa !30
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx, align 4, !dbg !55, !tbaa !30
  br label %if.end, !dbg !56

if.end:                                           ; preds = %for.cond36.preheader, %if.then47
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ], !dbg !57
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ], !dbg !57
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ], !dbg !57
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ], !dbg !57
  %cmp46.1 = icmp ult i32 %add43, 1260, !dbg !53
  br i1 %cmp46.1, label %if.then47.1, label %if.end.1, !dbg !54

if.then47.1:                                      ; preds = %if.end
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %add.ptr55.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1024
  %condval.sroa.7.0.add.ptr55.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1036
  %condval.sroa.6.0.add.ptr55.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1032
  %condval.sroa.5.0.add.ptr55.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1028
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr55.1, align 16, !dbg !55, !tbaa !30
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx.1, align 4, !dbg !55, !tbaa !30
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx.1, align 8, !dbg !55, !tbaa !30
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx.1, align 4, !dbg !55, !tbaa !30
  br label %if.end.1, !dbg !56

if.end.1:                                         ; preds = %if.then47.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then47.1 ], [ 0, %if.end ], !dbg !57
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then47.1 ], [ 0, %if.end ], !dbg !57
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then47.1 ], [ 0, %if.end ], !dbg !57
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then47.1 ], [ 0, %if.end ], !dbg !57
  %cmp46.2 = icmp ult i32 %add43, 1256, !dbg !53
  br i1 %cmp46.2, label %if.then47.2, label %if.end.2, !dbg !54

if.then47.2:                                      ; preds = %if.end.1
  %10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %add.ptr55.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2048
  %condval.sroa.7.0.add.ptr55.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2060
  %condval.sroa.6.0.add.ptr55.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2056
  %condval.sroa.5.0.add.ptr55.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2052
  %condval.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr55.2, align 16, !dbg !55, !tbaa !30
  %condval.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx.2, align 4, !dbg !55, !tbaa !30
  %condval.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx.2, align 8, !dbg !55, !tbaa !30
  %condval.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx.2, align 4, !dbg !55, !tbaa !30
  br label %if.end.2, !dbg !56

if.end.2:                                         ; preds = %if.then47.2, %if.end.1
  %condval.sroa.0.0.2 = phi i32 [ %condval.sroa.0.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ], !dbg !57
  %condval.sroa.5.0.2 = phi i32 [ %condval.sroa.5.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ], !dbg !57
  %condval.sroa.6.0.2 = phi i32 [ %condval.sroa.6.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ], !dbg !57
  %condval.sroa.7.0.2 = phi i32 [ %condval.sroa.7.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ], !dbg !57
  %cmp46.3 = icmp ult i32 %add43, 1252, !dbg !53
  br i1 %cmp46.3, label %if.then47.3, label %if.end.3, !dbg !54

if.then47.3:                                      ; preds = %if.end.2
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %add.ptr55.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3072
  %condval.sroa.7.0.add.ptr55.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3084
  %condval.sroa.6.0.add.ptr55.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3080
  %condval.sroa.5.0.add.ptr55.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3076
  %condval.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr55.3, align 16, !dbg !55, !tbaa !30
  %condval.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx.3, align 4, !dbg !55, !tbaa !30
  %condval.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx.3, align 8, !dbg !55, !tbaa !30
  %condval.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx.3, align 4, !dbg !55, !tbaa !30
  br label %if.end.3, !dbg !56

if.end.3:                                         ; preds = %if.then47.3, %if.end.2
  %condval.sroa.0.0.3 = phi i32 [ %condval.sroa.0.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ], !dbg !57
  %condval.sroa.5.0.3 = phi i32 [ %condval.sroa.5.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ], !dbg !57
  %condval.sroa.6.0.3 = phi i32 [ %condval.sroa.6.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ], !dbg !57
  %condval.sroa.7.0.3 = phi i32 [ %condval.sroa.7.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ], !dbg !57
  br i1 %cmp46, label %if.then94, label %if.end126, !dbg !58

if.then94:                                        ; preds = %if.end.3
  %add.ptr102 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %condval_1.sroa.7.0.add.ptr102.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr102, i64 12
  %condval_1.sroa.6.0.add.ptr102.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr102, i64 8
  %condval_1.sroa.5.0.add.ptr102.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr102, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr102, align 16, !dbg !59, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx, align 4, !dbg !59, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx, align 8, !dbg !59, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx, align 4, !dbg !59, !tbaa !30
  br label %if.end126, !dbg !60

if.end126:                                        ; preds = %if.end.3, %if.then94
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then94 ], [ 0, %if.end.3 ], !dbg !57
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then94 ], [ 0, %if.end.3 ], !dbg !57
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then94 ], [ 0, %if.end.3 ], !dbg !57
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then94 ], [ 0, %if.end.3 ], !dbg !57
  br i1 %cmp46.1, label %if.then94.1, label %if.end126.1, !dbg !58

if.then94.1:                                      ; preds = %if.end126
  %12 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %add.ptr102.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1024
  %condval_1.sroa.7.0.add.ptr102.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1036
  %condval_1.sroa.6.0.add.ptr102.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1032
  %condval_1.sroa.5.0.add.ptr102.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1028
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr102.1, align 16, !dbg !59, !tbaa !30
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx.1, align 4, !dbg !59, !tbaa !30
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx.1, align 8, !dbg !59, !tbaa !30
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx.1, align 4, !dbg !59, !tbaa !30
  br label %if.end126.1, !dbg !60

if.end126.1:                                      ; preds = %if.then94.1, %if.end126
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ], !dbg !57
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ], !dbg !57
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ], !dbg !57
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ], !dbg !57
  br i1 %cmp46.2, label %if.then94.2, label %if.end126.2, !dbg !58

if.then94.2:                                      ; preds = %if.end126.1
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %add.ptr102.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2048
  %condval_1.sroa.7.0.add.ptr102.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2060
  %condval_1.sroa.6.0.add.ptr102.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2056
  %condval_1.sroa.5.0.add.ptr102.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2052
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr102.2, align 16, !dbg !59, !tbaa !30
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx.2, align 4, !dbg !59, !tbaa !30
  %condval_1.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx.2, align 8, !dbg !59, !tbaa !30
  %condval_1.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx.2, align 4, !dbg !59, !tbaa !30
  br label %if.end126.2, !dbg !60

if.end126.2:                                      ; preds = %if.then94.2, %if.end126.1
  %condval_1.sroa.0.0.2 = phi i32 [ %condval_1.sroa.0.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ], !dbg !57
  %condval_1.sroa.5.0.2 = phi i32 [ %condval_1.sroa.5.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ], !dbg !57
  %condval_1.sroa.6.0.2 = phi i32 [ %condval_1.sroa.6.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ], !dbg !57
  %condval_1.sroa.7.0.2 = phi i32 [ %condval_1.sroa.7.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ], !dbg !57
  br i1 %cmp46.3, label %if.then94.3, label %if.end126.3, !dbg !58

if.then94.3:                                      ; preds = %if.end126.2
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %add.ptr102.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3072
  %condval_1.sroa.7.0.add.ptr102.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3084
  %condval_1.sroa.6.0.add.ptr102.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3080
  %condval_1.sroa.5.0.add.ptr102.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3076
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr102.3, align 16, !dbg !59, !tbaa !30
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx.3, align 4, !dbg !59, !tbaa !30
  %condval_1.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx.3, align 8, !dbg !59, !tbaa !30
  %condval_1.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx.3, align 4, !dbg !59, !tbaa !30
  br label %if.end126.3, !dbg !60

if.end126.3:                                      ; preds = %if.then94.3, %if.end126.2
  %condval_1.sroa.0.0.3 = phi i32 [ %condval_1.sroa.0.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ], !dbg !57
  %condval_1.sroa.5.0.3 = phi i32 [ %condval_1.sroa.5.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ], !dbg !57
  %condval_1.sroa.6.0.3 = phi i32 [ %condval_1.sroa.6.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ], !dbg !57
  %condval_1.sroa.7.0.3 = phi i32 [ %condval_1.sroa.7.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ], !dbg !57
  %mul146 = and i32 %mul52, 8064
  %and149 = and i32 %1, 15
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul146, !dbg !61
  %xor = xor i32 %shr42, %and149, !dbg !62
  %add.ptr157.idx = shl nuw nsw i32 %xor, 4, !dbg !63
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr157.idx, !dbg !63
  store i32 %condval.sroa.0.0, ptr addrspace(3) %add.ptr157, align 16, !dbg !64, !tbaa !30
  %K_reg.sroa.4.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 4, !dbg !64
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr157.sroa_idx, align 4, !dbg !64, !tbaa !30
  %K_reg.sroa.5.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8, !dbg !64
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr157.sroa_idx, align 8, !dbg !64, !tbaa !30
  %K_reg.sroa.6.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 12, !dbg !64
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr157.sroa_idx, align 4, !dbg !64, !tbaa !30
  %add153.1 = add nuw nsw i32 %shr42, 4, !dbg !65
  %xor.1 = xor i32 %add153.1, %and149, !dbg !62
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !63
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !63
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr157.idx.1, !dbg !63
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %add.ptr157.1, align 16, !dbg !64, !tbaa !30
  %K_reg.sroa.9.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 4, !dbg !64
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr157.1.sroa_idx, align 4, !dbg !64, !tbaa !30
  %K_reg.sroa.10.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8, !dbg !64
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr157.1.sroa_idx, align 8, !dbg !64, !tbaa !30
  %K_reg.sroa.11.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 12, !dbg !64
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr157.1.sroa_idx, align 4, !dbg !64, !tbaa !30
  %add153.2 = add nuw nsw i32 %shr42, 8, !dbg !65
  %xor.2 = xor i32 %add153.2, %and149, !dbg !62
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048, !dbg !63
  %add.ptr157.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !63
  %add.ptr157.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr157.idx.2, !dbg !63
  store i32 %condval.sroa.0.0.2, ptr addrspace(3) %add.ptr157.2, align 16, !dbg !64, !tbaa !30
  %K_reg.sroa.14.32.add.ptr157.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 4, !dbg !64
  store i32 %condval.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr157.2.sroa_idx, align 4, !dbg !64, !tbaa !30
  %K_reg.sroa.15.32.add.ptr157.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 8, !dbg !64
  store i32 %condval.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr157.2.sroa_idx, align 8, !dbg !64, !tbaa !30
  %K_reg.sroa.16.32.add.ptr157.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 12, !dbg !64
  store i32 %condval.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr157.2.sroa_idx, align 4, !dbg !64, !tbaa !30
  %add153.3 = add nuw nsw i32 %shr42, 12, !dbg !65
  %xor.3 = xor i32 %add153.3, %and149, !dbg !62
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072, !dbg !63
  %add.ptr157.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !63
  %add.ptr157.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr157.idx.3, !dbg !63
  store i32 %condval.sroa.0.0.3, ptr addrspace(3) %add.ptr157.3, align 16, !dbg !64, !tbaa !30
  %K_reg.sroa.19.48.add.ptr157.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 4, !dbg !64
  store i32 %condval.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr157.3.sroa_idx, align 4, !dbg !64, !tbaa !30
  %K_reg.sroa.20.48.add.ptr157.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 8, !dbg !64
  store i32 %condval.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr157.3.sroa_idx, align 8, !dbg !64, !tbaa !30
  %K_reg.sroa.21.48.add.ptr157.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 12, !dbg !64
  store i32 %condval.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr157.3.sroa_idx, align 4, !dbg !64, !tbaa !30
  %add162 = or disjoint i32 %mul17, 15, !dbg !66
  %cmp163 = icmp slt i32 %0, %add162, !dbg !67
  br i1 %cmp163, label %for.cond165.preheader, label %if.end191, !dbg !68

for.cond165.preheader:                            ; preds = %if.end126.3
  %15 = lshr i32 %1, 2
  %mul172 = and i32 %15, 252
  %add173 = add nuw nsw i32 %mul17, %mul172
  %cmp176.not = icmp sgt i32 %add173, %0, !dbg !69
  %spec.select = select i1 %cmp176.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %acc_s.sroa.0.0.vec.insert638 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !71
  %cmp176.not.1.not = icmp slt i32 %add173, %0, !dbg !69
  %spec.select.1 = select i1 %cmp176.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !70
  %acc_s.sroa.0.4.vec.insert651 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert638, float %spec.select.1, i64 1, !dbg !71
  %add174.2 = or disjoint i32 %add173, 2, !dbg !72
  %cmp176.not.2 = icmp sgt i32 %add174.2, %0, !dbg !69
  %spec.select.2 = select i1 %cmp176.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %acc_s.sroa.0.8.vec.insert664 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert651, float %spec.select.2, i64 2, !dbg !71
  %add174.3 = or disjoint i32 %add173, 3, !dbg !72
  %cmp176.not.3 = icmp sgt i32 %add174.3, %0, !dbg !69
  %spec.select.3 = select i1 %cmp176.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !70
  %acc_s.sroa.0.12.vec.insert677 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert664, float %spec.select.3, i64 3, !dbg !71
  br label %if.end191, !dbg !73

if.end191:                                        ; preds = %if.end126.3, %for.cond165.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert677, %for.cond165.preheader ], [ zeroinitializer, %if.end126.3 ], !dbg !57
  fence syncscope("warp") release, !dbg !73
  tail call void @llvm.mxc.barrier.warp(), !dbg !79
  fence syncscope("warp") acquire, !dbg !80
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul7
  %add.ptr210 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx, !dbg !81
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr210, align 16, !dbg !82
  %kb.sroa.10.0.add.ptr210.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210, i32 8, !dbg !82
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.sroa_idx, align 8, !dbg !82
  %17 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !83, !call_argsrelate !84
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %17), !dbg !83, !call_argsrelate !84
  %add.ptr210.1 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx.1, !dbg !81
  %kb.sroa.0.0.copyload626 = load <4 x half>, ptr addrspace(3) %add.ptr210.1, align 16, !dbg !82
  %kb.sroa.10.0.add.ptr210.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210.1, i32 8, !dbg !82
  %kb.sroa.10.0.copyload629 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.1.sroa_idx, align 8, !dbg !82
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload626, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %18), !dbg !83, !call_argsrelate !84
  %20 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload629, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %19), !dbg !83, !call_argsrelate !84
  %add.ptr210.2 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx.2, !dbg !81
  %kb.sroa.0.0.copyload627 = load <4 x half>, ptr addrspace(3) %add.ptr210.2, align 16, !dbg !82
  %kb.sroa.10.0.add.ptr210.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210.2, i32 8, !dbg !82
  %kb.sroa.10.0.copyload630 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.2.sroa_idx, align 8, !dbg !82
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload627, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %20), !dbg !83, !call_argsrelate !84
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload630, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %21), !dbg !83, !call_argsrelate !84
  %add.ptr210.3 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx.3, !dbg !81
  %kb.sroa.0.0.copyload628 = load <4 x half>, ptr addrspace(3) %add.ptr210.3, align 16, !dbg !82
  %kb.sroa.10.0.add.ptr210.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210.3, i32 8, !dbg !82
  %kb.sroa.10.0.copyload631 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.3.sroa_idx, align 8, !dbg !82
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload628, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %22), !dbg !83, !call_argsrelate !84
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload631, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %23), !dbg !83, !call_argsrelate !84
  fence syncscope("warp") release, !dbg !85
  tail call void @llvm.mxc.barrier.warp(), !dbg !88
  fence syncscope("warp") acquire, !dbg !89
  %add.ptr248.idx = shl nuw nsw i32 %1, 4
  %invariant.gep572 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr248.idx, !dbg !90
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep572, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep572.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 4, !dbg !91
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep572.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep572.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 8, !dbg !91
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep572.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep572.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 12, !dbg !91
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep572.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep573.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1024, !dbg !92
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep573.1, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.9.16.gep573.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1028, !dbg !91
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep573.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.10.16.gep573.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1032, !dbg !91
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep573.1.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.11.16.gep573.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1036, !dbg !91
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep573.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep573.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2048, !dbg !92
  store i32 %condval_1.sroa.0.0.2, ptr addrspace(3) %gep573.2, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.14.32.gep573.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2052, !dbg !91
  store i32 %condval_1.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep573.2.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.15.32.gep573.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2056, !dbg !91
  store i32 %condval_1.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep573.2.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.16.32.gep573.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2060, !dbg !91
  store i32 %condval_1.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep573.2.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep573.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3072, !dbg !92
  store i32 %condval_1.sroa.0.0.3, ptr addrspace(3) %gep573.3, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.19.48.gep573.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3076, !dbg !91
  store i32 %condval_1.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep573.3.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.20.48.gep573.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3080, !dbg !91
  store i32 %condval_1.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep573.3.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.21.48.gep573.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3084, !dbg !91
  store i32 %condval_1.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep573.3.sroa_idx, align 4, !dbg !91, !tbaa !30
  %acc_s.sroa.0.0.vec.extract640 = extractelement <4 x float> %24, i64 0, !dbg !93
  %mul258 = fmul contract float %acc_s.sroa.0.0.vec.extract640, 0x3FC2776C60000000, !dbg !94
  %25 = tail call contract noundef float @llvm.minnum.f32(float %mul258, float 1.500000e+01), !dbg !95
  %cmp.i.i = fcmp contract olt float %25, -1.260000e+02, !dbg !99
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i = fadd contract float %25, %cond.i.i, !dbg !99
  %26 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !99
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i = fmul contract float %cond2.i.i, %26, !dbg !99
  %acc_s.sroa.0.4.vec.extract653 = extractelement <4 x float> %24, i64 1, !dbg !93
  %mul258.1 = fmul contract float %acc_s.sroa.0.4.vec.extract653, 0x3FC2776C60000000, !dbg !94
  %27 = tail call contract noundef float @llvm.minnum.f32(float %mul258.1, float 1.500000e+01), !dbg !95
  %cmp.i.i.1 = fcmp contract olt float %27, -1.260000e+02, !dbg !99
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i.1 = fadd contract float %27, %cond.i.i.1, !dbg !99
  %28 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !99
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %28, !dbg !99
  %acc_s.sroa.0.8.vec.extract666 = extractelement <4 x float> %24, i64 2, !dbg !93
  %mul258.2 = fmul contract float %acc_s.sroa.0.8.vec.extract666, 0x3FC2776C60000000, !dbg !94
  %29 = tail call contract noundef float @llvm.minnum.f32(float %mul258.2, float 1.500000e+01), !dbg !95
  %cmp.i.i.2 = fcmp contract olt float %29, -1.260000e+02, !dbg !99
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i.2 = fadd contract float %29, %cond.i.i.2, !dbg !99
  %30 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !99
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %30, !dbg !99
  %acc_s.sroa.0.12.vec.extract679 = extractelement <4 x float> %24, i64 3, !dbg !93
  %mul258.3 = fmul contract float %acc_s.sroa.0.12.vec.extract679, 0x3FC2776C60000000, !dbg !94
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul258.3, float 1.500000e+01), !dbg !95
  %cmp.i.i.3 = fcmp contract olt float %31, -1.260000e+02, !dbg !99
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i.3 = fadd contract float %31, %cond.i.i.3, !dbg !99
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !99
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %32, !dbg !99
  %add274 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !102
  %add274.1 = fadd contract float %add274, %mul.i.i.1, !dbg !102
  %add274.2 = fadd contract float %add274.1, %mul.i.i.2, !dbg !102
  %add274.3 = fadd contract float %add274.2, %mul.i.i.3, !dbg !102
  %33 = bitcast float %add274.3 to i32, !dbg !103
  %34 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !106
  %35 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %34) #10, !dbg !111
  %xor.i.i = xor i32 %35, 32, !dbg !112
  %36 = and i32 %35, -64, !dbg !113
  %and.i.i = add nsw i32 %36, 64, !dbg !113
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !114
  %cond.i.i528 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %35, !dbg !115
  %shl.i.i = shl i32 %cond.i.i528, 2, !dbg !116
  %37 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %33), !dbg !117
  %38 = bitcast i32 %37 to float, !dbg !118
  %add282 = fadd contract float %add274.3, %38, !dbg !119
  %39 = bitcast float %add282 to i32, !dbg !120
  %40 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !122
  %41 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %40) #10, !dbg !125
  %xor.i.i529 = xor i32 %41, 16, !dbg !126
  %42 = and i32 %41, -64, !dbg !127
  %and.i.i530 = add nsw i32 %42, 64, !dbg !127
  %cmp.not.i.i531 = icmp slt i32 %xor.i.i529, %and.i.i530, !dbg !128
  %cond.i.i532 = select i1 %cmp.not.i.i531, i32 %xor.i.i529, i32 %41, !dbg !129
  %shl.i.i533 = shl i32 %cond.i.i532, 2, !dbg !130
  %43 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i533, i32 %39), !dbg !131
  %44 = bitcast i32 %43 to float, !dbg !132
  %add287 = fadd contract float %add282, %44, !dbg !133
  %cmp290 = fcmp contract ogt float %add287, 0.000000e+00, !dbg !134
  %div = fdiv contract float 1.000000e+00, %add287, !dbg !135
  %condval_3.0 = select i1 %cmp290, float %div, float 0.000000e+00, !dbg !135
  %mul303 = fmul contract float %condval_3.0, %mul.i.i, !dbg !136
  %mul303.1 = fmul contract float %condval_3.0, %mul.i.i.1, !dbg !136
  %mul303.2 = fmul contract float %condval_3.0, %mul.i.i.2, !dbg !136
  %mul303.3 = fmul contract float %condval_3.0, %mul.i.i.3, !dbg !136
  %45 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !137
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !137, !noalias !145
  %46 = fptrunc float %mul303 to half, !dbg !137
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %45), !dbg !137, !noalias !145
  %47 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !150
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !150, !noalias !145
  %48 = fptrunc float %mul303.1 to half, !dbg !150
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %47), !dbg !150, !noalias !145
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %46, i64 0, !dbg !152
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %48, i64 1, !dbg !152
  %49 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !155
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !155, !noalias !159
  %50 = fptrunc float %mul303.2 to half, !dbg !155
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %49), !dbg !155, !noalias !159
  %51 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !164
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !164, !noalias !159
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %51), !dbg !164, !noalias !159
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %50, i64 2, !dbg !166
  fence syncscope("warp") release, !dbg !168
  tail call void @llvm.mxc.barrier.warp(), !dbg !171
  fence syncscope("warp") acquire, !dbg !172
  %52 = shl nuw nsw i32 %1, 5
  %mul333 = and i32 %52, 32256
  %add340 = or disjoint i32 %mul333, %and149, !dbg !173
  %arrayidx342 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340, !dbg !174
  %53 = load half, ptr addrspace(3) %arrayidx342, align 2, !dbg !175, !tbaa !176
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %53, i64 0, !dbg !175
  %add335.1 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1 = or disjoint i32 %add335.1, 128, !dbg !173
  %arrayidx342.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1, !dbg !174
  %54 = load half, ptr addrspace(3) %arrayidx342.1, align 2, !dbg !175, !tbaa !176
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %54, i64 1, !dbg !175
  %add335.2 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2 = or disjoint i32 %add335.2, 256, !dbg !173
  %arrayidx342.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2, !dbg !174
  %55 = load half, ptr addrspace(3) %arrayidx342.2, align 2, !dbg !175, !tbaa !176
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %55, i64 2, !dbg !175
  %add335.3 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.3 = or disjoint i32 %add335.3, 384, !dbg !173
  %arrayidx342.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3, !dbg !174
  %56 = load half, ptr addrspace(3) %arrayidx342.3, align 2, !dbg !175, !tbaa !176
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %56, i64 3, !dbg !175
  %add337.1599 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1600 = or disjoint i32 %add337.1599, 16, !dbg !173
  %arrayidx342.1601 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1600, !dbg !174
  %57 = load half, ptr addrspace(3) %arrayidx342.1601, align 2, !dbg !175, !tbaa !176
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %57, i64 0, !dbg !175
  %add337.1.1 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1.1 = or disjoint i32 %add337.1.1, 144, !dbg !173
  %arrayidx342.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.1, !dbg !174
  %58 = load half, ptr addrspace(3) %arrayidx342.1.1, align 2, !dbg !175, !tbaa !176
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %58, i64 1, !dbg !175
  %add337.2.1 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2.1 = or disjoint i32 %add337.2.1, 272, !dbg !173
  %arrayidx342.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.1, !dbg !174
  %59 = load half, ptr addrspace(3) %arrayidx342.2.1, align 2, !dbg !175, !tbaa !176
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %59, i64 2, !dbg !175
  %add337.3.1 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.3.1 = or disjoint i32 %add337.3.1, 400, !dbg !173
  %arrayidx342.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.1, !dbg !174
  %60 = load half, ptr addrspace(3) %arrayidx342.3.1, align 2, !dbg !175, !tbaa !176
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %60, i64 3, !dbg !175
  %add337.2603 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2604 = or disjoint i32 %add337.2603, 32, !dbg !173
  %arrayidx342.2605 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2604, !dbg !174
  %61 = load half, ptr addrspace(3) %arrayidx342.2605, align 2, !dbg !175, !tbaa !176
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %61, i64 0, !dbg !175
  %add337.1.2 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1.2 = or disjoint i32 %add337.1.2, 160, !dbg !173
  %arrayidx342.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.2, !dbg !174
  %62 = load half, ptr addrspace(3) %arrayidx342.1.2, align 2, !dbg !175, !tbaa !176
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %62, i64 1, !dbg !175
  %add337.2.2 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2.2 = or disjoint i32 %add337.2.2, 288, !dbg !173
  %arrayidx342.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.2, !dbg !174
  %63 = load half, ptr addrspace(3) %arrayidx342.2.2, align 2, !dbg !175, !tbaa !176
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %63, i64 2, !dbg !175
  %add337.3.2 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.3.2 = or disjoint i32 %add337.3.2, 416, !dbg !173
  %arrayidx342.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.2, !dbg !174
  %64 = load half, ptr addrspace(3) %arrayidx342.3.2, align 2, !dbg !175, !tbaa !176
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %64, i64 3, !dbg !175
  %add337.3607 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.3608 = or disjoint i32 %add337.3607, 48, !dbg !173
  %arrayidx342.3609 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3608, !dbg !174
  %65 = load half, ptr addrspace(3) %arrayidx342.3609, align 2, !dbg !175, !tbaa !176
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %65, i64 0, !dbg !175
  %add337.1.3 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1.3 = or disjoint i32 %add337.1.3, 176, !dbg !173
  %arrayidx342.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.3, !dbg !174
  %66 = load half, ptr addrspace(3) %arrayidx342.1.3, align 2, !dbg !175, !tbaa !176
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %66, i64 1, !dbg !175
  %add337.2.3 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2.3 = or disjoint i32 %add337.2.3, 304, !dbg !173
  %arrayidx342.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.3, !dbg !174
  %67 = load half, ptr addrspace(3) %arrayidx342.2.3, align 2, !dbg !175, !tbaa !176
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %67, i64 2, !dbg !175
  %add337.3.3 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.3.3 = or disjoint i32 %add337.3.3, 432, !dbg !173
  %arrayidx342.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.3, !dbg !174
  %68 = load half, ptr addrspace(3) %arrayidx342.3.3, align 2, !dbg !175, !tbaa !176
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %68, i64 3, !dbg !175
  %add337.4 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.4 = or disjoint i32 %add337.4, 64, !dbg !173
  %arrayidx342.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.4, !dbg !174
  %69 = load half, ptr addrspace(3) %arrayidx342.4, align 2, !dbg !175, !tbaa !176
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %69, i64 0, !dbg !175
  %add337.1.4 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1.4 = or disjoint i32 %add337.1.4, 192, !dbg !173
  %arrayidx342.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.4, !dbg !174
  %70 = load half, ptr addrspace(3) %arrayidx342.1.4, align 2, !dbg !175, !tbaa !176
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %70, i64 1, !dbg !175
  %add337.2.4 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2.4 = or disjoint i32 %add337.2.4, 320, !dbg !173
  %arrayidx342.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.4, !dbg !174
  %71 = load half, ptr addrspace(3) %arrayidx342.2.4, align 2, !dbg !175, !tbaa !176
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %71, i64 2, !dbg !175
  %add337.3.4 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.3.4 = or disjoint i32 %add337.3.4, 448, !dbg !173
  %arrayidx342.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.4, !dbg !174
  %72 = load half, ptr addrspace(3) %arrayidx342.3.4, align 2, !dbg !175, !tbaa !176
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %72, i64 3, !dbg !175
  %add337.5 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.5 = or disjoint i32 %add337.5, 80, !dbg !173
  %arrayidx342.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.5, !dbg !174
  %73 = load half, ptr addrspace(3) %arrayidx342.5, align 2, !dbg !175, !tbaa !176
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %73, i64 0, !dbg !175
  %add337.1.5 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1.5 = or disjoint i32 %add337.1.5, 208, !dbg !173
  %arrayidx342.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.5, !dbg !174
  %74 = load half, ptr addrspace(3) %arrayidx342.1.5, align 2, !dbg !175, !tbaa !176
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %74, i64 1, !dbg !175
  %add337.2.5 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2.5 = or disjoint i32 %add337.2.5, 336, !dbg !173
  %arrayidx342.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.5, !dbg !174
  %75 = load half, ptr addrspace(3) %arrayidx342.2.5, align 2, !dbg !175, !tbaa !176
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %75, i64 2, !dbg !175
  %add337.3.5 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.3.5 = or disjoint i32 %add337.3.5, 464, !dbg !173
  %arrayidx342.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.5, !dbg !174
  %76 = load half, ptr addrspace(3) %arrayidx342.3.5, align 2, !dbg !175, !tbaa !176
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %76, i64 3, !dbg !175
  %add337.6 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.6 = or disjoint i32 %add337.6, 96, !dbg !173
  %arrayidx342.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.6, !dbg !174
  %77 = load half, ptr addrspace(3) %arrayidx342.6, align 2, !dbg !175, !tbaa !176
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %77, i64 0, !dbg !175
  %add337.1.6 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1.6 = or disjoint i32 %add337.1.6, 224, !dbg !173
  %arrayidx342.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.6, !dbg !174
  %78 = load half, ptr addrspace(3) %arrayidx342.1.6, align 2, !dbg !175, !tbaa !176
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %78, i64 1, !dbg !175
  %add337.2.6 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2.6 = or disjoint i32 %add337.2.6, 352, !dbg !173
  %arrayidx342.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.6, !dbg !174
  %79 = load half, ptr addrspace(3) %arrayidx342.2.6, align 2, !dbg !175, !tbaa !176
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %79, i64 2, !dbg !175
  %add337.3.6 = or disjoint i32 %52, %and149, !dbg !173
  %add340.3.6 = or i32 %add337.3.6, 480, !dbg !173
  %arrayidx342.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.6, !dbg !174
  %80 = load half, ptr addrspace(3) %arrayidx342.3.6, align 2, !dbg !175, !tbaa !176
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %80, i64 3, !dbg !175
  %add337.7 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.7 = or disjoint i32 %add337.7, 112, !dbg !173
  %arrayidx342.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.7, !dbg !174
  %81 = load half, ptr addrspace(3) %arrayidx342.7, align 2, !dbg !175, !tbaa !176
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %81, i64 0, !dbg !175
  %add337.1.7 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.1.7 = or disjoint i32 %add337.1.7, 240, !dbg !173
  %arrayidx342.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.7, !dbg !174
  %82 = load half, ptr addrspace(3) %arrayidx342.1.7, align 2, !dbg !175, !tbaa !176
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %82, i64 1, !dbg !175
  %add337.2.7 = or disjoint i32 %mul333, %and149, !dbg !173
  %add340.2.7 = or disjoint i32 %add337.2.7, 368, !dbg !173
  %arrayidx342.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.7, !dbg !174
  %83 = load half, ptr addrspace(3) %arrayidx342.2.7, align 2, !dbg !175, !tbaa !176
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %83, i64 2, !dbg !175
  %add337.3.7 = or disjoint i32 %52, %and149, !dbg !173
  %add340.3.7 = or i32 %add337.3.7, 496, !dbg !173
  %arrayidx342.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.7, !dbg !174
  %84 = load half, ptr addrspace(3) %arrayidx342.3.7, align 2, !dbg !175, !tbaa !176
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %84, i64 3, !dbg !175
  %85 = fptrunc float %mul303.3 to half, !dbg !164
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %85, i64 3, !dbg !166
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !177
  br label %if.end371

if.end371:                                        ; preds = %if.end191, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %86, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %87, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %88, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %89, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %90, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %acc_o.sroa.52.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %91, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %acc_o.sroa.62.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %92, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %93, %if.end191 ], [ zeroinitializer, %entry ], !dbg !57
  %94 = lshr i32 %1, 2
  %mul404 = and i32 %94, 252
  %add401 = add nuw nsw i32 %add, %mul404
  %95 = zext nneg i32 %add401 to i64, !dbg !178
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !179
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !179
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !179
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !179
  %96 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %97 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %96), !dbg !180, !noalias !184
  %98 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %99 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %98), !dbg !189, !noalias !184
  %100 = bitcast half %97 to i16, !dbg !191
  %101 = bitcast half %99 to i16, !dbg !194
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %103 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !dbg !195, !noalias !199
  %104 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %105 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %104), !dbg !204, !noalias !199
  %106 = bitcast half %103 to i16, !dbg !206
  %107 = bitcast half %105 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext = zext i16 %107 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !209
  %__2.sroa.5.0.insert.ext = zext i16 %106 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !209
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !209
  %__2.sroa.4.0.insert.ext = zext i16 %101 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !209
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !209
  %__2.sroa.0.0.insert.ext = zext i16 %100 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !209
  %add.ptr407 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr407, align 8, !dbg !211
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !179
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !179
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !179
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !179
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %109 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !dbg !180, !noalias !184
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %111 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !dbg !189, !noalias !184
  %112 = bitcast half %109 to i16, !dbg !191
  %113 = bitcast half %111 to i16, !dbg !194
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %115 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !dbg !195, !noalias !199
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %117 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !dbg !204, !noalias !199
  %118 = bitcast half %115 to i16, !dbg !206
  %119 = bitcast half %117 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext.1 = zext i16 %119 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !209
  %__2.sroa.5.0.insert.ext.1 = zext i16 %118 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !209
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !209
  %__2.sroa.4.0.insert.ext.1 = zext i16 %113 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !209
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !209
  %__2.sroa.0.0.insert.ext.1 = zext i16 %112 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !209
  %120 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  %add.ptr407.1 = getelementptr inbounds i8, ptr addrspace(1) %120, i64 32, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr407.1, align 8, !dbg !211
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !179
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !179
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !179
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !179
  %121 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %122 = fptrunc float %acc_o.sroa.22.32.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %121), !dbg !180, !noalias !184
  %123 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %124 = fptrunc float %acc_o.sroa.22.36.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %123), !dbg !189, !noalias !184
  %125 = bitcast half %122 to i16, !dbg !191
  %126 = bitcast half %124 to i16, !dbg !194
  %127 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %128 = fptrunc float %acc_o.sroa.22.40.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %127), !dbg !195, !noalias !199
  %129 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %130 = fptrunc float %acc_o.sroa.22.44.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %129), !dbg !204, !noalias !199
  %131 = bitcast half %128 to i16, !dbg !206
  %132 = bitcast half %130 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext.2 = zext i16 %132 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !209
  %__2.sroa.5.0.insert.ext.2 = zext i16 %131 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !209
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !209
  %__2.sroa.4.0.insert.ext.2 = zext i16 %126 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !209
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !209
  %__2.sroa.0.0.insert.ext.2 = zext i16 %125 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !209
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  %add.ptr407.2 = getelementptr inbounds i8, ptr addrspace(1) %133, i64 64, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr407.2, align 8, !dbg !211
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !179
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !179
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !179
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !179
  %134 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %135 = fptrunc float %acc_o.sroa.32.48.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %134), !dbg !180, !noalias !184
  %136 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %137 = fptrunc float %acc_o.sroa.32.52.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %136), !dbg !189, !noalias !184
  %138 = bitcast half %135 to i16, !dbg !191
  %139 = bitcast half %137 to i16, !dbg !194
  %140 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %141 = fptrunc float %acc_o.sroa.32.56.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %140), !dbg !195, !noalias !199
  %142 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %143 = fptrunc float %acc_o.sroa.32.60.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %142), !dbg !204, !noalias !199
  %144 = bitcast half %141 to i16, !dbg !206
  %145 = bitcast half %143 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext.3 = zext i16 %145 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !209
  %__2.sroa.5.0.insert.ext.3 = zext i16 %144 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !209
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !209
  %__2.sroa.4.0.insert.ext.3 = zext i16 %139 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !209
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !209
  %__2.sroa.0.0.insert.ext.3 = zext i16 %138 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !209
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  %add.ptr407.3 = getelementptr inbounds i8, ptr addrspace(1) %146, i64 96, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr407.3, align 8, !dbg !211
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0, !dbg !179
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1, !dbg !179
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2, !dbg !179
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3, !dbg !179
  %147 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %148 = fptrunc float %acc_o.sroa.42.64.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %147), !dbg !180, !noalias !184
  %149 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %150 = fptrunc float %acc_o.sroa.42.68.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %149), !dbg !189, !noalias !184
  %151 = bitcast half %148 to i16, !dbg !191
  %152 = bitcast half %150 to i16, !dbg !194
  %153 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %154 = fptrunc float %acc_o.sroa.42.72.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %153), !dbg !195, !noalias !199
  %155 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %156 = fptrunc float %acc_o.sroa.42.76.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %155), !dbg !204, !noalias !199
  %157 = bitcast half %154 to i16, !dbg !206
  %158 = bitcast half %156 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext.4 = zext i16 %158 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift.4 = shl nuw i64 %__2.sroa.6.0.insert.ext.4, 48, !dbg !209
  %__2.sroa.5.0.insert.ext.4 = zext i16 %157 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.4, 32, !dbg !209
  %__2.sroa.5.0.insert.insert.4 = or disjoint i64 %__2.sroa.6.0.insert.shift.4, %__2.sroa.5.0.insert.shift.4, !dbg !209
  %__2.sroa.4.0.insert.ext.4 = zext i16 %152 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.4, 16, !dbg !209
  %__2.sroa.4.0.insert.insert.4 = or disjoint i64 %__2.sroa.5.0.insert.insert.4, %__2.sroa.4.0.insert.shift.4, !dbg !209
  %__2.sroa.0.0.insert.ext.4 = zext i16 %151 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert.4 = or disjoint i64 %__2.sroa.4.0.insert.insert.4, %__2.sroa.0.0.insert.ext.4, !dbg !209
  %159 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  %add.ptr407.4 = getelementptr inbounds i8, ptr addrspace(1) %159, i64 128, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert.4, ptr addrspace(1) %add.ptr407.4, align 8, !dbg !211
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0, !dbg !179
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1, !dbg !179
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2, !dbg !179
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3, !dbg !179
  %160 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %161 = fptrunc float %acc_o.sroa.52.80.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %160), !dbg !180, !noalias !184
  %162 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %163 = fptrunc float %acc_o.sroa.52.84.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %162), !dbg !189, !noalias !184
  %164 = bitcast half %161 to i16, !dbg !191
  %165 = bitcast half %163 to i16, !dbg !194
  %166 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %167 = fptrunc float %acc_o.sroa.52.88.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %166), !dbg !195, !noalias !199
  %168 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %169 = fptrunc float %acc_o.sroa.52.92.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %168), !dbg !204, !noalias !199
  %170 = bitcast half %167 to i16, !dbg !206
  %171 = bitcast half %169 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext.5 = zext i16 %171 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift.5 = shl nuw i64 %__2.sroa.6.0.insert.ext.5, 48, !dbg !209
  %__2.sroa.5.0.insert.ext.5 = zext i16 %170 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.5, 32, !dbg !209
  %__2.sroa.5.0.insert.insert.5 = or disjoint i64 %__2.sroa.6.0.insert.shift.5, %__2.sroa.5.0.insert.shift.5, !dbg !209
  %__2.sroa.4.0.insert.ext.5 = zext i16 %165 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.5, 16, !dbg !209
  %__2.sroa.4.0.insert.insert.5 = or disjoint i64 %__2.sroa.5.0.insert.insert.5, %__2.sroa.4.0.insert.shift.5, !dbg !209
  %__2.sroa.0.0.insert.ext.5 = zext i16 %164 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert.5 = or disjoint i64 %__2.sroa.4.0.insert.insert.5, %__2.sroa.0.0.insert.ext.5, !dbg !209
  %172 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  %add.ptr407.5 = getelementptr inbounds i8, ptr addrspace(1) %172, i64 160, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert.5, ptr addrspace(1) %add.ptr407.5, align 8, !dbg !211
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0, !dbg !179
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1, !dbg !179
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2, !dbg !179
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3, !dbg !179
  %173 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %174 = fptrunc float %acc_o.sroa.62.96.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %173), !dbg !180, !noalias !184
  %175 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %176 = fptrunc float %acc_o.sroa.62.100.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %175), !dbg !189, !noalias !184
  %177 = bitcast half %174 to i16, !dbg !191
  %178 = bitcast half %176 to i16, !dbg !194
  %179 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %180 = fptrunc float %acc_o.sroa.62.104.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %179), !dbg !195, !noalias !199
  %181 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %182 = fptrunc float %acc_o.sroa.62.108.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %181), !dbg !204, !noalias !199
  %183 = bitcast half %180 to i16, !dbg !206
  %184 = bitcast half %182 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext.6 = zext i16 %184 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift.6 = shl nuw i64 %__2.sroa.6.0.insert.ext.6, 48, !dbg !209
  %__2.sroa.5.0.insert.ext.6 = zext i16 %183 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.6, 32, !dbg !209
  %__2.sroa.5.0.insert.insert.6 = or disjoint i64 %__2.sroa.6.0.insert.shift.6, %__2.sroa.5.0.insert.shift.6, !dbg !209
  %__2.sroa.4.0.insert.ext.6 = zext i16 %178 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.6, 16, !dbg !209
  %__2.sroa.4.0.insert.insert.6 = or disjoint i64 %__2.sroa.5.0.insert.insert.6, %__2.sroa.4.0.insert.shift.6, !dbg !209
  %__2.sroa.0.0.insert.ext.6 = zext i16 %177 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert.6 = or disjoint i64 %__2.sroa.4.0.insert.insert.6, %__2.sroa.0.0.insert.ext.6, !dbg !209
  %185 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  %add.ptr407.6 = getelementptr inbounds i8, ptr addrspace(1) %185, i64 192, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert.6, ptr addrspace(1) %add.ptr407.6, align 8, !dbg !211
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0, !dbg !179
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1, !dbg !179
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2, !dbg !179
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3, !dbg !179
  %186 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !180, !noalias !184
  %187 = fptrunc float %acc_o.sroa.72.112.vec.extract to half, !dbg !180
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %186), !dbg !180, !noalias !184
  %188 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !189, !noalias !184
  %189 = fptrunc float %acc_o.sroa.72.116.vec.extract to half, !dbg !189
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %188), !dbg !189, !noalias !184
  %190 = bitcast half %187 to i16, !dbg !191
  %191 = bitcast half %189 to i16, !dbg !194
  %192 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %193 = fptrunc float %acc_o.sroa.72.120.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %192), !dbg !195, !noalias !199
  %194 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %195 = fptrunc float %acc_o.sroa.72.124.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %194), !dbg !204, !noalias !199
  %196 = bitcast half %193 to i16, !dbg !206
  %197 = bitcast half %195 to i16, !dbg !208
  %__2.sroa.6.0.insert.ext.7 = zext i16 %197 to i64, !dbg !209
  %__2.sroa.6.0.insert.shift.7 = shl nuw i64 %__2.sroa.6.0.insert.ext.7, 48, !dbg !209
  %__2.sroa.5.0.insert.ext.7 = zext i16 %196 to i64, !dbg !209
  %__2.sroa.5.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.7, 32, !dbg !209
  %__2.sroa.5.0.insert.insert.7 = or disjoint i64 %__2.sroa.6.0.insert.shift.7, %__2.sroa.5.0.insert.shift.7, !dbg !209
  %__2.sroa.4.0.insert.ext.7 = zext i16 %191 to i64, !dbg !209
  %__2.sroa.4.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.7, 16, !dbg !209
  %__2.sroa.4.0.insert.insert.7 = or disjoint i64 %__2.sroa.5.0.insert.insert.7, %__2.sroa.4.0.insert.shift.7, !dbg !209
  %__2.sroa.0.0.insert.ext.7 = zext i16 %190 to i64, !dbg !209
  %__2.sroa.0.0.insert.insert.7 = or disjoint i64 %__2.sroa.4.0.insert.insert.7, %__2.sroa.0.0.insert.ext.7, !dbg !209
  %198 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95, !dbg !210
  %add.ptr407.7 = getelementptr inbounds i8, ptr addrspace(1) %198, i64 224, !dbg !210
  store i64 %__2.sroa.0.0.insert.insert.7, ptr addrspace(1) %add.ptr407.7, align 8, !dbg !211
  ret void, !dbg !212
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

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(inaccessiblemem: read)
declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #10 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpd8z8wfvs/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpd8z8wfvs/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 23, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 46, scope: !40)
!45 = !DILocation(line: 24, column: 32, scope: !40)
!46 = !DILocation(line: 26, column: 14, scope: !40)
!47 = !DILocation(line: 26, column: 46, scope: !40)
!48 = !DILocation(line: 32, column: 11, scope: !40)
!49 = !DILocation(line: 32, column: 19, scope: !40)
!50 = !DILocation(line: 32, column: 27, scope: !40)
!51 = !DILocation(line: 32, column: 36, scope: !40)
!52 = !DILocation(line: 34, column: 5, scope: !40)
!53 = !DILocation(line: 37, column: 61, scope: !40)
!54 = !DILocation(line: 37, column: 11, scope: !40)
!55 = !DILocation(line: 38, column: 17, scope: !40)
!56 = !DILocation(line: 39, column: 7, scope: !40)
!57 = !DILocation(line: 0, scope: !40)
!58 = !DILocation(line: 48, column: 11, scope: !40)
!59 = !DILocation(line: 49, column: 19, scope: !40)
!60 = !DILocation(line: 50, column: 7, scope: !40)
!61 = !DILocation(line: 56, column: 5, scope: !40)
!62 = !DILocation(line: 57, column: 109, scope: !40)
!63 = !DILocation(line: 57, column: 26, scope: !40)
!64 = !DILocation(line: 57, column: 159, scope: !40)
!65 = !DILocation(line: 57, column: 122, scope: !40)
!66 = !DILocation(line: 59, column: 34, scope: !40)
!67 = !DILocation(line: 59, column: 27, scope: !40)
!68 = !DILocation(line: 59, column: 9, scope: !40)
!69 = !DILocation(line: 63, column: 62, scope: !40)
!70 = !DILocation(line: 63, column: 13, scope: !40)
!71 = !DILocation(line: 68, column: 20, scope: !40)
!72 = !DILocation(line: 63, column: 55, scope: !40)
!73 = !DILocation(line: 68, column: 3, scope: !74, inlinedAt: !76)
!74 = distinct !DISubprogram(name: "__barrier_warp", scope: !75, file: !75, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!75 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!76 = distinct !DILocation(line: 192, column: 3, scope: !77, inlinedAt: !78)
!77 = distinct !DISubprogram(name: "__syncwarp", scope: !75, file: !75, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!78 = distinct !DILocation(line: 74, column: 5, scope: !40)
!79 = !DILocation(line: 69, column: 3, scope: !74, inlinedAt: !76)
!80 = !DILocation(line: 70, column: 3, scope: !74, inlinedAt: !76)
!81 = !DILocation(line: 76, column: 46, scope: !40)
!82 = !DILocation(line: 76, column: 25, scope: !40)
!83 = !DILocation(line: 79, column: 36, scope: !40)
!84 = !{i32 -1, i32 3, i32 -1}
!85 = !DILocation(line: 68, column: 3, scope: !74, inlinedAt: !86)
!86 = distinct !DILocation(line: 192, column: 3, scope: !77, inlinedAt: !87)
!87 = distinct !DILocation(line: 85, column: 5, scope: !40)
!88 = !DILocation(line: 69, column: 3, scope: !74, inlinedAt: !86)
!89 = !DILocation(line: 70, column: 3, scope: !74, inlinedAt: !86)
!90 = !DILocation(line: 87, column: 10, scope: !40)
!91 = !DILocation(line: 88, column: 70, scope: !40)
!92 = !DILocation(line: 88, column: 26, scope: !40)
!93 = !DILocation(line: 92, column: 31, scope: !40)
!94 = !DILocation(line: 92, column: 42, scope: !40)
!95 = !DILocation(line: 354, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "min", scope: !97, file: !97, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!98 = distinct !DILocation(line: 92, column: 26, scope: !40)
!99 = !DILocation(line: 285, column: 49, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "exp2f", scope: !97, file: !97, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 92, column: 20, scope: !40)
!102 = !DILocation(line: 97, column: 34, scope: !40)
!103 = !DILocation(line: 1018, column: 9, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !75, file: !75, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = distinct !DILocation(line: 99, column: 34, scope: !40)
!106 = !DILocation(line: 171, column: 37, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "__lane_id", scope: !75, file: !75, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 990, column: 14, scope: !109, inlinedAt: !110)
!109 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !75, file: !75, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!110 = distinct !DILocation(line: 1019, column: 11, scope: !104, inlinedAt: !105)
!111 = !DILocation(line: 171, column: 10, scope: !107, inlinedAt: !108)
!112 = !DILocation(line: 991, column: 20, scope: !109, inlinedAt: !110)
!113 = !DILocation(line: 992, column: 36, scope: !109, inlinedAt: !110)
!114 = !DILocation(line: 992, column: 17, scope: !109, inlinedAt: !110)
!115 = !DILocation(line: 992, column: 11, scope: !109, inlinedAt: !110)
!116 = !DILocation(line: 993, column: 43, scope: !109, inlinedAt: !110)
!117 = !DILocation(line: 993, column: 10, scope: !109, inlinedAt: !110)
!118 = !DILocation(line: 1020, column: 14, scope: !104, inlinedAt: !105)
!119 = !DILocation(line: 99, column: 32, scope: !40)
!120 = !DILocation(line: 1018, column: 9, scope: !104, inlinedAt: !121)
!121 = distinct !DILocation(line: 100, column: 34, scope: !40)
!122 = !DILocation(line: 171, column: 37, scope: !107, inlinedAt: !123)
!123 = distinct !DILocation(line: 990, column: 14, scope: !109, inlinedAt: !124)
!124 = distinct !DILocation(line: 1019, column: 11, scope: !104, inlinedAt: !121)
!125 = !DILocation(line: 171, column: 10, scope: !107, inlinedAt: !123)
!126 = !DILocation(line: 991, column: 20, scope: !109, inlinedAt: !124)
!127 = !DILocation(line: 992, column: 36, scope: !109, inlinedAt: !124)
!128 = !DILocation(line: 992, column: 17, scope: !109, inlinedAt: !124)
!129 = !DILocation(line: 992, column: 11, scope: !109, inlinedAt: !124)
!130 = !DILocation(line: 993, column: 43, scope: !109, inlinedAt: !124)
!131 = !DILocation(line: 993, column: 10, scope: !109, inlinedAt: !124)
!132 = !DILocation(line: 1020, column: 14, scope: !104, inlinedAt: !121)
!133 = !DILocation(line: 100, column: 32, scope: !40)
!134 = !DILocation(line: 102, column: 34, scope: !40)
!135 = !DILocation(line: 102, column: 9, scope: !40)
!136 = !DILocation(line: 110, column: 32, scope: !40)
!137 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !140)
!138 = distinct !DISubprogram(name: "__float2half_rn", scope: !139, file: !139, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!140 = distinct !DILocation(line: 1077, column: 18, scope: !141, inlinedAt: !142)
!141 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !139, file: !139, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!142 = distinct !DILocation(line: 1295, column: 23, scope: !143, inlinedAt: !144)
!143 = distinct !DISubprogram(name: "__float22half2_rn", scope: !139, file: !139, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!144 = distinct !DILocation(line: 114, column: 27, scope: !40)
!145 = !{!146, !148}
!146 = distinct !{!146, !147, !"_ZL17__floats2half2_rnff: %agg.result"}
!147 = distinct !{!147, !"_ZL17__floats2half2_rnff"}
!148 = distinct !{!148, !149, !"_ZL17__float22half2_rn6float2: %agg.result"}
!149 = distinct !{!149, !"_ZL17__float22half2_rn6float2"}
!150 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !151)
!151 = distinct !DILocation(line: 1077, column: 38, scope: !141, inlinedAt: !142)
!152 = !DILocation(line: 593, column: 26, scope: !153, inlinedAt: !154)
!153 = distinct !DISubprogram(name: "operator=", scope: !139, file: !139, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!154 = distinct !DILocation(line: 114, column: 25, scope: !40)
!155 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !156)
!156 = distinct !DILocation(line: 1077, column: 18, scope: !141, inlinedAt: !157)
!157 = distinct !DILocation(line: 1295, column: 23, scope: !143, inlinedAt: !158)
!158 = distinct !DILocation(line: 115, column: 27, scope: !40)
!159 = !{!160, !162}
!160 = distinct !{!160, !161, !"_ZL17__floats2half2_rnff: %agg.result"}
!161 = distinct !{!161, !"_ZL17__floats2half2_rnff"}
!162 = distinct !{!162, !163, !"_ZL17__float22half2_rn6float2: %agg.result"}
!163 = distinct !{!163, !"_ZL17__float22half2_rn6float2"}
!164 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !165)
!165 = distinct !DILocation(line: 1077, column: 38, scope: !141, inlinedAt: !157)
!166 = !DILocation(line: 593, column: 26, scope: !153, inlinedAt: !167)
!167 = distinct !DILocation(line: 115, column: 25, scope: !40)
!168 = !DILocation(line: 68, column: 3, scope: !74, inlinedAt: !169)
!169 = distinct !DILocation(line: 192, column: 3, scope: !77, inlinedAt: !170)
!170 = distinct !DILocation(line: 117, column: 5, scope: !40)
!171 = !DILocation(line: 69, column: 3, scope: !74, inlinedAt: !169)
!172 = !DILocation(line: 70, column: 3, scope: !74, inlinedAt: !169)
!173 = !DILocation(line: 120, column: 104, scope: !40)
!174 = !DILocation(line: 120, column: 31, scope: !40)
!175 = !DILocation(line: 120, column: 29, scope: !40)
!176 = !{!26, !26, i64 0}
!177 = !DILocation(line: 125, column: 38, scope: !40)
!178 = !DILocation(line: 132, column: 3, scope: !40)
!179 = !DILocation(line: 134, column: 19, scope: !40)
!180 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !181)
!181 = distinct !DILocation(line: 1077, column: 18, scope: !141, inlinedAt: !182)
!182 = distinct !DILocation(line: 1295, column: 23, scope: !143, inlinedAt: !183)
!183 = distinct !DILocation(line: 135, column: 27, scope: !40)
!184 = !{!185, !187}
!185 = distinct !{!185, !186, !"_ZL17__floats2half2_rnff: %agg.result"}
!186 = distinct !{!186, !"_ZL17__floats2half2_rnff"}
!187 = distinct !{!187, !188, !"_ZL17__float22half2_rn6float2: %agg.result"}
!188 = distinct !{!188, !"_ZL17__float22half2_rn6float2"}
!189 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !190)
!190 = distinct !DILocation(line: 1077, column: 38, scope: !141, inlinedAt: !182)
!191 = !DILocation(line: 596, column: 67, scope: !192, inlinedAt: !193)
!192 = distinct !DISubprogram(name: "__half2", scope: !139, file: !139, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!193 = distinct !DILocation(line: 1077, column: 10, scope: !141, inlinedAt: !182)
!194 = !DILocation(line: 596, column: 73, scope: !192, inlinedAt: !193)
!195 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !196)
!196 = distinct !DILocation(line: 1077, column: 18, scope: !141, inlinedAt: !197)
!197 = distinct !DILocation(line: 1295, column: 23, scope: !143, inlinedAt: !198)
!198 = distinct !DILocation(line: 136, column: 27, scope: !40)
!199 = !{!200, !202}
!200 = distinct !{!200, !201, !"_ZL17__floats2half2_rnff: %agg.result"}
!201 = distinct !{!201, !"_ZL17__floats2half2_rnff"}
!202 = distinct !{!202, !203, !"_ZL17__float22half2_rn6float2: %agg.result"}
!203 = distinct !{!203, !"_ZL17__float22half2_rn6float2"}
!204 = !DILocation(line: 1007, column: 10, scope: !138, inlinedAt: !205)
!205 = distinct !DILocation(line: 1077, column: 38, scope: !141, inlinedAt: !197)
!206 = !DILocation(line: 596, column: 67, scope: !192, inlinedAt: !207)
!207 = distinct !DILocation(line: 1077, column: 10, scope: !141, inlinedAt: !197)
!208 = !DILocation(line: 596, column: 73, scope: !192, inlinedAt: !207)
!209 = !DILocation(line: 137, column: 38, scope: !40)
!210 = !DILocation(line: 138, column: 22, scope: !40)
!211 = !DILocation(line: 138, column: 141, scope: !40)
!212 = !DILocation(line: 140, column: 1, scope: !40)
