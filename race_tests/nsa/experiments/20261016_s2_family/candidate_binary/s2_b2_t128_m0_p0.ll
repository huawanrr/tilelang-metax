; ModuleID = 'experiments/20261016_s2_family/candidate_binary/s2_b2_t128_m0_p0.bc'
source_filename = "/tmp/tmpekk0zitc/tvm_kernels.maca"
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 17
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 6
  %mul9 = and i32 %and, 960
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %mul25 = shl nsw i32 %0, 8
  %mul27 = shl nuw nsw i32 %1, 1
  %add28 = add nuw nsw i32 %mul25, %mul27
  %6 = zext nneg i32 %add28 to i64, !dbg !46
  %arrayidx30 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !47
  %7 = load i32, ptr addrspace(1) %arrayidx30, align 4, !dbg !47, !tbaa !30
  %cmp32 = icmp ult i32 %7, 8
  %8 = shl nsw i32 %7, 4, !dbg !48
  %mul33 = select i1 %cmp32, i32 %8, i32 -16, !dbg !48
  %9 = or disjoint i64 %6, 1, !dbg !49
  %arrayidx30.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %9, !dbg !47
  %10 = load i32, ptr addrspace(1) %arrayidx30.1, align 4, !dbg !47, !tbaa !30
  %cmp32.1 = icmp ult i32 %10, 8
  %11 = shl nsw i32 %10, 4, !dbg !48
  %mul33.1 = select i1 %cmp32.1, i32 %11, i32 -16, !dbg !48
  %shr68 = lshr i32 %2, 3
  %conv = zext nneg i32 %0 to i64
  %mul78 = shl nuw nsw i64 %conv, 13
  %12 = shl nuw nsw i32 %2, 3
  %13 = and i32 %12, 56
  %mul85 = zext nneg i32 %13 to i64
  %add64 = add nsw i32 %shr68, %mul33, !dbg !50
  %or.cond = icmp ult i32 %add64, 128, !dbg !51
  br i1 %or.cond, label %if.then76, label %if.then58.1, !dbg !51

if.then76:                                        ; preds = %entry
  %14 = shl nuw nsw i32 %add64, 6, !dbg !52
  %mul80 = zext nneg i32 %14 to i64, !dbg !52
  %add81 = or disjoint i64 %mul78, %mul80, !dbg !53
  %add86 = or disjoint i64 %add81, %mul85, !dbg !54
  %add.ptr87 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86, !dbg !55
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr87, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx, align 4, !dbg !56, !tbaa !30
  br label %if.then58.1, !dbg !57

if.then58.1:                                      ; preds = %if.then76, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then76 ], [ 0, %entry ], !dbg !58
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then76 ], [ 0, %entry ], !dbg !58
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then76 ], [ 0, %entry ], !dbg !58
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then76 ], [ 0, %entry ], !dbg !58
  %add62.1 = add nuw nsw i32 %shr68, 8, !dbg !59
  %add64.1 = add nsw i32 %add62.1, %mul33, !dbg !50
  %or.cond.1 = icmp ult i32 %add64.1, 128, !dbg !51
  br i1 %or.cond.1, label %if.then76.1, label %if.else65.2, !dbg !51

if.then76.1:                                      ; preds = %if.then58.1
  %15 = shl nuw nsw i32 %add64.1, 6, !dbg !52
  %mul80.1 = zext nneg i32 %15 to i64, !dbg !52
  %add81.1 = or disjoint i64 %mul78, %mul80.1, !dbg !53
  %add86.1 = or disjoint i64 %add81.1, %mul85, !dbg !54
  %add.ptr87.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86.1, !dbg !55
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr87.1, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.1, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx.1, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.1, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx.1, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.1, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx.1, align 4, !dbg !56, !tbaa !30
  br label %if.else65.2, !dbg !57

if.else65.2:                                      ; preds = %if.then58.1, %if.then76.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ], !dbg !58
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ], !dbg !58
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ], !dbg !58
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ], !dbg !58
  %sub.2 = add i32 %shr68, %mul33.1, !dbg !60
  %or.cond.2 = icmp ult i32 %sub.2, 128, !dbg !51
  br i1 %or.cond.2, label %if.then76.2, label %if.else65.3, !dbg !51

if.then76.2:                                      ; preds = %if.else65.2
  %16 = shl nuw nsw i32 %sub.2, 6, !dbg !52
  %mul80.2 = zext nneg i32 %16 to i64, !dbg !52
  %add81.2 = or disjoint i64 %mul78, %mul80.2, !dbg !53
  %add86.2 = or disjoint i64 %add81.2, %mul85, !dbg !54
  %add.ptr87.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86.2, !dbg !55
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr87.2, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.2, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx.2, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.2, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx.2, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.2, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx.2, align 4, !dbg !56, !tbaa !30
  br label %if.else65.3, !dbg !57

if.else65.3:                                      ; preds = %if.else65.2, %if.then76.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ], !dbg !58
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ], !dbg !58
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ], !dbg !58
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ], !dbg !58
  %add71.3 = add nuw nsw i32 %shr68, 8, !dbg !61
  %sub.3 = add i32 %add71.3, %mul33.1, !dbg !60
  %or.cond.3 = icmp ult i32 %sub.3, 128, !dbg !51
  br i1 %or.cond.3, label %if.then76.3, label %if.then123, !dbg !51

if.then76.3:                                      ; preds = %if.else65.3
  %17 = shl nuw nsw i32 %sub.3, 6, !dbg !52
  %mul80.3 = zext nneg i32 %17 to i64, !dbg !52
  %add81.3 = or disjoint i64 %mul78, %mul80.3, !dbg !53
  %add86.3 = or disjoint i64 %add81.3, %mul85, !dbg !54
  %add.ptr87.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86.3, !dbg !55
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr87.3, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.3, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx.3, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.3, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx.3, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.3, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx.3, align 4, !dbg !56, !tbaa !30
  br label %if.then123, !dbg !57

if.then123:                                       ; preds = %if.else65.3, %if.then76.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ], !dbg !58
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ], !dbg !58
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ], !dbg !58
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ], !dbg !58
  %add129 = add nsw i32 %shr68, %mul33, !dbg !62
  %or.cond721 = icmp ult i32 %add129, 128, !dbg !63
  br i1 %or.cond721, label %if.then142, label %if.then123.1, !dbg !63

if.then142:                                       ; preds = %if.then123
  %18 = shl nuw nsw i32 %add129, 6, !dbg !64
  %mul147 = zext nneg i32 %18 to i64, !dbg !64
  %add148 = or disjoint i64 %mul78, %mul147, !dbg !65
  %add153 = or disjoint i64 %add148, %mul85, !dbg !66
  %add.ptr154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153, !dbg !67
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr154, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx, align 4, !dbg !68, !tbaa !30
  br label %if.then123.1, !dbg !69

if.then123.1:                                     ; preds = %if.then142, %if.then123
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then142 ], [ 0, %if.then123 ], !dbg !58
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then142 ], [ 0, %if.then123 ], !dbg !58
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then142 ], [ 0, %if.then123 ], !dbg !58
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then142 ], [ 0, %if.then123 ], !dbg !58
  %add127.1 = add nuw nsw i32 %shr68, 8, !dbg !70
  %add129.1 = add nsw i32 %add127.1, %mul33, !dbg !62
  %or.cond721.1 = icmp ult i32 %add129.1, 128, !dbg !63
  br i1 %or.cond721.1, label %if.then142.1, label %if.else130.2, !dbg !63

if.then142.1:                                     ; preds = %if.then123.1
  %19 = shl nuw nsw i32 %add129.1, 6, !dbg !64
  %mul147.1 = zext nneg i32 %19 to i64, !dbg !64
  %add148.1 = or disjoint i64 %mul78, %mul147.1, !dbg !65
  %add153.1 = or disjoint i64 %add148.1, %mul85, !dbg !66
  %add.ptr154.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153.1, !dbg !67
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr154.1, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.1, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx.1, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.1, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx.1, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.1, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx.1, align 4, !dbg !68, !tbaa !30
  br label %if.else130.2, !dbg !69

if.else130.2:                                     ; preds = %if.then123.1, %if.then142.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ], !dbg !58
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ], !dbg !58
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ], !dbg !58
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ], !dbg !58
  %sub137.2 = add i32 %shr68, %mul33.1, !dbg !71
  %or.cond721.2 = icmp ult i32 %sub137.2, 128, !dbg !63
  br i1 %or.cond721.2, label %if.then142.2, label %if.else130.3, !dbg !63

if.then142.2:                                     ; preds = %if.else130.2
  %20 = shl nuw nsw i32 %sub137.2, 6, !dbg !64
  %mul147.2 = zext nneg i32 %20 to i64, !dbg !64
  %add148.2 = or disjoint i64 %mul78, %mul147.2, !dbg !65
  %add153.2 = or disjoint i64 %add148.2, %mul85, !dbg !66
  %add.ptr154.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153.2, !dbg !67
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr154.2, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.2, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx.2, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.2, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx.2, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.2, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx.2, align 4, !dbg !68, !tbaa !30
  br label %if.else130.3, !dbg !69

if.else130.3:                                     ; preds = %if.else130.2, %if.then142.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ], !dbg !58
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ], !dbg !58
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ], !dbg !58
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ], !dbg !58
  %add136.3 = add nuw nsw i32 %shr68, 8, !dbg !72
  %sub137.3 = add i32 %add136.3, %mul33.1, !dbg !71
  %or.cond721.3 = icmp ult i32 %sub137.3, 128, !dbg !63
  br i1 %or.cond721.3, label %if.then142.3, label %if.end178.3, !dbg !63

if.then142.3:                                     ; preds = %if.else130.3
  %21 = shl nuw nsw i32 %sub137.3, 6, !dbg !64
  %mul147.3 = zext nneg i32 %21 to i64, !dbg !64
  %add148.3 = or disjoint i64 %mul78, %mul147.3, !dbg !65
  %add153.3 = or disjoint i64 %add148.3, %mul85, !dbg !66
  %add.ptr154.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153.3, !dbg !67
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr154.3, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.3, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx.3, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.3, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx.3, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.3, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx.3, align 4, !dbg !68, !tbaa !30
  br label %if.end178.3, !dbg !69

if.end178.3:                                      ; preds = %if.then142.3, %if.else130.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ], !dbg !58
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ], !dbg !58
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ], !dbg !58
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ], !dbg !58
  %mul198 = and i32 %12, 8128
  %call202.masked = and i32 %2, 1016
  %mul204 = xor i32 %13, %call202.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul198, !dbg !73
  %invariant.gep768 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul204, !dbg !73
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep768, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep768.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 4, !dbg !74
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep768.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep768.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 8, !dbg !74
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep768.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep768.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 12, !dbg !74
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep768.sroa_idx, align 4, !dbg !74, !tbaa !30
  %gep769.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1024, !dbg !75
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep769.1, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.9.16.gep769.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1028, !dbg !74
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep769.1.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.10.16.gep769.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1032, !dbg !74
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep769.1.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.11.16.gep769.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1036, !dbg !74
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep769.1.sroa_idx, align 4, !dbg !74, !tbaa !30
  %gep769.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2048, !dbg !75
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep769.2, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.14.32.gep769.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2052, !dbg !74
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep769.2.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.15.32.gep769.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2056, !dbg !74
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep769.2.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.16.32.gep769.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2060, !dbg !74
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep769.2.sroa_idx, align 4, !dbg !74, !tbaa !30
  %gep769.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3072, !dbg !75
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep769.3, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.19.48.gep769.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3076, !dbg !74
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep769.3.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.20.48.gep769.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3080, !dbg !74
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep769.3.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.21.48.gep769.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3084, !dbg !74
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep769.3.sroa_idx, align 4, !dbg !74, !tbaa !30
  fence syncscope("block") release, !dbg !76
  tail call void @llvm.mxc.barrier(), !dbg !82
  fence syncscope("block") acquire, !dbg !83
  %shr241 = lshr i32 %2, 4
  %and244 = and i32 %2, 7
  %xor245 = xor i32 %shr241, %and244
  %add.ptr249.idx = shl nuw nsw i32 %xor245, 4
  %invariant.gep772 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr249.idx, !dbg !84
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep772, i32 %mul9, !dbg !85
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16, !dbg !86
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8, !dbg !86
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8, !dbg !86
  %add238.1 = or disjoint i32 %mul9, 1024, !dbg !87
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep772, i32 %add238.1, !dbg !85
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16, !dbg !86
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8, !dbg !86
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8, !dbg !86
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !88, !call_argsrelate !89
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !88, !call_argsrelate !89
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !dbg !88, !call_argsrelate !89
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23), !dbg !88, !call_argsrelate !89
  %add242.1 = add nuw nsw i32 %shr241, 4
  %xor245.1 = xor i32 %add242.1, %and244
  %add.ptr249.idx.1 = shl nuw nsw i32 %xor245.1, 4
  %invariant.gep772.1 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr249.idx.1, !dbg !84
  %gep.1805 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep772.1, i32 %mul9, !dbg !85
  %kb.sroa.0.0.copyload894 = load <4 x half>, ptr addrspace(3) %gep.1805, align 16, !dbg !86
  %kb.sroa.6.0.gep.1805.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1805, i32 8, !dbg !86
  %kb.sroa.6.0.copyload895 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1805.sroa_idx, align 8, !dbg !86
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep772.1, i32 %add238.1, !dbg !85
  %kb.sroa.8.16.copyload898 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16, !dbg !86
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8, !dbg !86
  %kb.sroa.12.16.copyload899 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8, !dbg !86
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload894, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !dbg !88, !call_argsrelate !89
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload898, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %25), !dbg !88, !call_argsrelate !89
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload895, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !dbg !88, !call_argsrelate !89
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload899, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %27), !dbg !88, !call_argsrelate !89
  fence syncscope("block") release, !dbg !90
  tail call void @llvm.mxc.barrier(), !dbg !93
  fence syncscope("block") acquire, !dbg !94
  %add.ptr303.idx = shl nuw nsw i32 %2, 4
  %invariant.gep777 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr303.idx, !dbg !95
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep777, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep777.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 4, !dbg !96
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep777.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep777.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 8, !dbg !96
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep777.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep777.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 12, !dbg !96
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep777.sroa_idx, align 4, !dbg !96, !tbaa !30
  %gep778.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 1024, !dbg !97
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep778.1, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.9.16.gep778.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 1028, !dbg !96
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep778.1.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.10.16.gep778.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 1032, !dbg !96
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep778.1.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.11.16.gep778.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 1036, !dbg !96
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep778.1.sroa_idx, align 4, !dbg !96, !tbaa !30
  %gep778.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 2048, !dbg !97
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep778.2, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.14.32.gep778.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 2052, !dbg !96
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep778.2.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.15.32.gep778.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 2056, !dbg !96
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep778.2.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.16.32.gep778.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 2060, !dbg !96
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep778.2.sroa_idx, align 4, !dbg !96, !tbaa !30
  %gep778.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 3072, !dbg !97
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep778.3, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.19.48.gep778.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 3076, !dbg !96
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep778.3.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.20.48.gep778.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 3080, !dbg !96
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep778.3.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.21.48.gep778.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep777, i32 3084, !dbg !96
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep778.3.sroa_idx, align 4, !dbg !96, !tbaa !30
  %30 = lshr i32 %2, 2
  %mul324 = and i32 %30, 252
  %add318 = add i32 %30, %mul33, !dbg !98
  %add339 = add i32 %mul324, %mul33, !dbg !99
  %add360 = add i32 %mul324, %mul33, !dbg !100
  %cmp374 = icmp slt i32 %add318, 0, !dbg !101
  %cmp376 = icmp sgt i32 %add339, 127
  %or.cond722.not797 = or i1 %cmp374, %cmp376, !dbg !102
  %cmp379.not = icmp sgt i32 %add360, %1
  %or.cond762 = or i1 %or.cond722.not797, %cmp379.not, !dbg !102
  br i1 %or.cond762, label %if.then312.1, label %if.then380, !dbg !102

if.then380:                                       ; preds = %if.end178.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0, !dbg !103
  %mul383 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !104
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul383, float 0x4024CB5EC0000000), !dbg !105
  %32 = tail call contract noundef float @llvm.exp.f32(float %31), !dbg !109
  br label %if.then312.1, !dbg !112

if.then312.1:                                     ; preds = %if.then380, %if.end178.3
  %condval_5.0 = phi float [ %32, %if.then380 ], [ 0.000000e+00, %if.end178.3 ], !dbg !58
  %add318.1 = add i32 %30, %mul33, !dbg !98
  %add338.1 = or disjoint i32 %mul324, 1, !dbg !113
  %add339.1 = add i32 %add338.1, %mul33, !dbg !99
  %add359.1 = or disjoint i32 %mul324, 1, !dbg !114
  %add360.1 = add i32 %add359.1, %mul33, !dbg !100
  %cmp374.1 = icmp slt i32 %add318.1, 0, !dbg !101
  %cmp376.1 = icmp sgt i32 %add339.1, 127
  %or.cond722.not797.1 = select i1 %cmp374.1, i1 true, i1 %cmp376.1, !dbg !102
  %cmp379.not.1 = icmp sgt i32 %add360.1, %1
  %or.cond762.1 = select i1 %or.cond722.not797.1, i1 true, i1 %cmp379.not.1, !dbg !102
  br i1 %or.cond762.1, label %if.then312.2, label %if.then380.1, !dbg !102

if.then380.1:                                     ; preds = %if.then312.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1, !dbg !103
  %mul383.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !104
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul383.1, float 0x4024CB5EC0000000), !dbg !105
  %34 = tail call contract noundef float @llvm.exp.f32(float %33), !dbg !109
  br label %if.then312.2, !dbg !112

if.then312.2:                                     ; preds = %if.then312.1, %if.then380.1
  %condval_5.0.1 = phi float [ %34, %if.then380.1 ], [ 0.000000e+00, %if.then312.1 ], !dbg !58
  %add318.2 = add i32 %30, %mul33, !dbg !98
  %add338.2 = or disjoint i32 %mul324, 2, !dbg !113
  %add339.2 = add i32 %add338.2, %mul33, !dbg !99
  %add359.2 = or disjoint i32 %mul324, 2, !dbg !114
  %add360.2 = add i32 %add359.2, %mul33, !dbg !100
  %cmp374.2 = icmp slt i32 %add318.2, 0, !dbg !101
  %cmp376.2 = icmp sgt i32 %add339.2, 127
  %or.cond722.not797.2 = select i1 %cmp374.2, i1 true, i1 %cmp376.2, !dbg !102
  %cmp379.not.2 = icmp sgt i32 %add360.2, %1
  %or.cond762.2 = select i1 %or.cond722.not797.2, i1 true, i1 %cmp379.not.2, !dbg !102
  br i1 %or.cond762.2, label %if.then312.3, label %if.then380.2, !dbg !102

if.then380.2:                                     ; preds = %if.then312.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2, !dbg !103
  %mul383.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !104
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul383.2, float 0x4024CB5EC0000000), !dbg !105
  %36 = tail call contract noundef float @llvm.exp.f32(float %35), !dbg !109
  br label %if.then312.3, !dbg !112

if.then312.3:                                     ; preds = %if.then312.2, %if.then380.2
  %condval_5.0.2 = phi float [ %36, %if.then380.2 ], [ 0.000000e+00, %if.then312.2 ], !dbg !58
  %add318.3 = add i32 %30, %mul33, !dbg !98
  %add338.3 = or i32 %30, 3, !dbg !113
  %add339.3 = add i32 %add338.3, %mul33, !dbg !99
  %add359.3 = or i32 %30, 3, !dbg !114
  %add360.3 = add i32 %add359.3, %mul33, !dbg !100
  %cmp374.3 = icmp slt i32 %add318.3, 0, !dbg !101
  %cmp376.3 = icmp sgt i32 %add339.3, 127
  %or.cond722.not797.3 = or i1 %cmp374.3, %cmp376.3, !dbg !102
  %cmp379.not.3 = icmp sgt i32 %add360.3, %1
  %or.cond762.3 = or i1 %or.cond722.not797.3, %cmp379.not.3, !dbg !102
  br i1 %or.cond762.3, label %if.else319.4, label %if.then380.3, !dbg !102

if.then380.3:                                     ; preds = %if.then312.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3, !dbg !103
  %mul383.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !104
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul383.3, float 0x4024CB5EC0000000), !dbg !105
  %38 = tail call contract noundef float @llvm.exp.f32(float %37), !dbg !109
  br label %if.else319.4, !dbg !112

if.else319.4:                                     ; preds = %if.then312.3, %if.then380.3
  %condval_5.0.3 = phi float [ %38, %if.then380.3 ], [ 0.000000e+00, %if.then312.3 ], !dbg !58
  %sub330.4 = add i32 %30, %mul33.1, !dbg !115
  %sub351.4 = add i32 %mul324, %mul33.1, !dbg !116
  %sub372.4 = add i32 %mul324, %mul33.1, !dbg !117
  %cmp374.4 = icmp slt i32 %sub330.4, 0, !dbg !101
  %cmp376.4 = icmp sgt i32 %sub351.4, 127
  %or.cond722.not797.4 = or i1 %cmp374.4, %cmp376.4, !dbg !102
  %cmp379.not.4 = icmp sgt i32 %sub372.4, %1
  %or.cond762.4 = select i1 %or.cond722.not797.4, i1 true, i1 %cmp379.not.4, !dbg !102
  br i1 %or.cond762.4, label %if.else319.5, label %if.then380.4, !dbg !102

if.then380.4:                                     ; preds = %if.else319.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %29, i64 0, !dbg !103
  %mul383.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000, !dbg !104
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul383.4, float 0x4024CB5EC0000000), !dbg !105
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !109
  br label %if.else319.5, !dbg !112

if.else319.5:                                     ; preds = %if.else319.4, %if.then380.4
  %condval_5.0.4 = phi float [ %40, %if.then380.4 ], [ 0.000000e+00, %if.else319.4 ], !dbg !58
  %sub330.5 = add i32 %30, %mul33.1, !dbg !115
  %add350.5 = or disjoint i32 %mul324, 1, !dbg !118
  %sub351.5 = add i32 %add350.5, %mul33.1, !dbg !116
  %add371.5 = or disjoint i32 %mul324, 1, !dbg !119
  %sub372.5 = add i32 %add371.5, %mul33.1, !dbg !117
  %cmp374.5 = icmp slt i32 %sub330.5, 0, !dbg !101
  %cmp376.5 = icmp sgt i32 %sub351.5, 127
  %or.cond722.not797.5 = select i1 %cmp374.5, i1 true, i1 %cmp376.5, !dbg !102
  %cmp379.not.5 = icmp sgt i32 %sub372.5, %1
  %or.cond762.5 = select i1 %or.cond722.not797.5, i1 true, i1 %cmp379.not.5, !dbg !102
  br i1 %or.cond762.5, label %if.else319.6, label %if.then380.5, !dbg !102

if.then380.5:                                     ; preds = %if.else319.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %29, i64 1, !dbg !103
  %mul383.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000, !dbg !104
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul383.5, float 0x4024CB5EC0000000), !dbg !105
  %42 = tail call contract noundef float @llvm.exp.f32(float %41), !dbg !109
  br label %if.else319.6, !dbg !112

if.else319.6:                                     ; preds = %if.else319.5, %if.then380.5
  %condval_5.0.5 = phi float [ %42, %if.then380.5 ], [ 0.000000e+00, %if.else319.5 ], !dbg !58
  %sub330.6 = add i32 %30, %mul33.1, !dbg !115
  %add350.6 = or disjoint i32 %mul324, 2, !dbg !118
  %sub351.6 = add i32 %add350.6, %mul33.1, !dbg !116
  %add371.6 = or disjoint i32 %mul324, 2, !dbg !119
  %sub372.6 = add i32 %add371.6, %mul33.1, !dbg !117
  %cmp374.6 = icmp slt i32 %sub330.6, 0, !dbg !101
  %cmp376.6 = icmp sgt i32 %sub351.6, 127
  %or.cond722.not797.6 = select i1 %cmp374.6, i1 true, i1 %cmp376.6, !dbg !102
  %cmp379.not.6 = icmp sgt i32 %sub372.6, %1
  %or.cond762.6 = select i1 %or.cond722.not797.6, i1 true, i1 %cmp379.not.6, !dbg !102
  br i1 %or.cond762.6, label %if.else319.7, label %if.then380.6, !dbg !102

if.then380.6:                                     ; preds = %if.else319.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %29, i64 2, !dbg !103
  %mul383.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000, !dbg !104
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul383.6, float 0x4024CB5EC0000000), !dbg !105
  %44 = tail call contract noundef float @llvm.exp.f32(float %43), !dbg !109
  br label %if.else319.7, !dbg !112

if.else319.7:                                     ; preds = %if.else319.6, %if.then380.6
  %condval_5.0.6 = phi float [ %44, %if.then380.6 ], [ 0.000000e+00, %if.else319.6 ], !dbg !58
  %sub330.7 = add i32 %30, %mul33.1, !dbg !115
  %add350.7 = or i32 %30, 3, !dbg !118
  %sub351.7 = add i32 %add350.7, %mul33.1, !dbg !116
  %add371.7 = or i32 %30, 3, !dbg !119
  %sub372.7 = add i32 %add371.7, %mul33.1, !dbg !117
  %cmp374.7 = icmp slt i32 %sub330.7, 0, !dbg !101
  %cmp376.7 = icmp sgt i32 %sub351.7, 127
  %or.cond722.not797.7 = or i1 %cmp374.7, %cmp376.7, !dbg !102
  %cmp379.not.7 = icmp sgt i32 %sub372.7, %1
  %or.cond762.7 = select i1 %or.cond722.not797.7, i1 true, i1 %cmp379.not.7, !dbg !102
  br i1 %or.cond762.7, label %if.end387.7, label %if.then380.7, !dbg !102

if.then380.7:                                     ; preds = %if.else319.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %29, i64 3, !dbg !103
  %mul383.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000, !dbg !104
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul383.7, float 0x4024CB5EC0000000), !dbg !105
  %46 = tail call contract noundef float @llvm.exp.f32(float %45), !dbg !109
  br label %if.end387.7, !dbg !112

if.end387.7:                                      ; preds = %if.then380.7, %if.else319.7
  %condval_5.0.7 = phi float [ %46, %if.then380.7 ], [ 0.000000e+00, %if.else319.7 ], !dbg !58
  %add407.1 = fadd contract float %condval_5.0, %condval_5.0.1, !dbg !120
  %add407.2 = fadd contract float %add407.1, %condval_5.0.2, !dbg !120
  %add407.3 = fadd contract float %add407.2, %condval_5.0.3, !dbg !120
  %add407.1811 = fadd contract float %add407.3, %condval_5.0.4, !dbg !120
  %add407.1.1 = fadd contract float %add407.1811, %condval_5.0.5, !dbg !120
  %add407.2.1 = fadd contract float %add407.1.1, %condval_5.0.6, !dbg !120
  %add407.3.1 = fadd contract float %add407.2.1, %condval_5.0.7, !dbg !120
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add407.3.1, <4 x float> zeroinitializer), !dbg !121
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %47, i64 0, !dbg !122
  %cmp428 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00, !dbg !123
  br i1 %cmp428, label %if.then429, label %if.end445, !dbg !124

if.then429:                                       ; preds = %if.end387.7
  %48 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32, !dbg !125
  %sub431 = sub i32 2129859011, %48, !dbg !126
  %49 = bitcast i32 %sub431 to float, !dbg !127
  %mul433 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %49, !dbg !128
  %sub434 = fsub contract float 2.000000e+00, %mul433, !dbg !129
  %mul435 = fmul contract float %sub434, %49, !dbg !130
  %mul441 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul435, !dbg !131
  %sub442 = fsub contract float 2.000000e+00, %mul441, !dbg !132
  %mul443 = fmul contract float %mul435, %sub442, !dbg !133
  br label %if.end445, !dbg !134

if.end445:                                        ; preds = %if.end387.7, %if.then429
  %condval_9.0 = phi float [ %mul443, %if.then429 ], [ 0.000000e+00, %if.end387.7 ], !dbg !58
  %mul454 = fmul contract float %condval_9.0, %condval_5.0, !dbg !135
  %mul454.1 = fmul contract float %condval_9.0, %condval_5.0.1, !dbg !135
  %mul454.2 = fmul contract float %condval_9.0, %condval_5.0.2, !dbg !135
  %mul454.3 = fmul contract float %condval_9.0, %condval_5.0.3, !dbg !135
  %mul454.4 = fmul contract float %condval_9.0, %condval_5.0.4, !dbg !135
  %mul454.5 = fmul contract float %condval_9.0, %condval_5.0.5, !dbg !135
  %mul454.6 = fmul contract float %condval_9.0, %condval_5.0.6, !dbg !135
  %mul454.7 = fmul contract float %condval_9.0, %condval_5.0.7, !dbg !135
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454), !dbg !136
  %51 = insertelement <4 x i16> poison, i16 %50, i64 0, !dbg !145
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.1), !dbg !136
  %53 = insertelement <4 x i16> %51, i16 %52, i64 1, !dbg !145
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.2), !dbg !136
  %55 = insertelement <4 x i16> %53, i16 %54, i64 2, !dbg !145
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.3), !dbg !136
  %57 = insertelement <4 x i16> %55, i16 %56, i64 3, !dbg !145
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %57 to <4 x half>, !dbg !145
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.4), !dbg !136
  %59 = insertelement <4 x i16> poison, i16 %58, i64 0, !dbg !145
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.5), !dbg !136
  %61 = insertelement <4 x i16> %59, i16 %60, i64 1, !dbg !145
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.6), !dbg !136
  %63 = insertelement <4 x i16> %61, i16 %62, i64 2, !dbg !145
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.7), !dbg !136
  %65 = insertelement <4 x i16> %63, i16 %64, i64 3, !dbg !145
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %65 to <4 x half>, !dbg !145
  fence syncscope("block") release, !dbg !146
  tail call void @llvm.mxc.barrier(), !dbg !149
  fence syncscope("block") acquire, !dbg !150
  %mul498 = and i32 %add.ptr303.idx, 16128
  %and505 = and i32 %2, 15
  %add506 = or disjoint i32 %mul498, %and505, !dbg !151
  %arrayidx508 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506, !dbg !152
  %66 = load half, ptr addrspace(3) %arrayidx508, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %66, i64 0, !dbg !153
  %add501.1 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.1 = or disjoint i32 %add501.1, 64, !dbg !151
  %arrayidx508.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1, !dbg !152
  %67 = load half, ptr addrspace(3) %arrayidx508.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %67, i64 1, !dbg !153
  %add501.2 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.2 = or disjoint i32 %add501.2, 128, !dbg !151
  %arrayidx508.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2, !dbg !152
  %68 = load half, ptr addrspace(3) %arrayidx508.2, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %68, i64 2, !dbg !153
  %add501.3 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.3 = or disjoint i32 %add501.3, 192, !dbg !151
  %arrayidx508.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3, !dbg !152
  %69 = load half, ptr addrspace(3) %arrayidx508.3, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %69, i64 3, !dbg !153
  %add503.1814 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.1815 = or disjoint i32 %add503.1814, 16, !dbg !151
  %arrayidx508.1816 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1815, !dbg !152
  %70 = load half, ptr addrspace(3) %arrayidx508.1816, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %70, i64 0, !dbg !153
  %add503.1.1 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.1.1 = or disjoint i32 %add503.1.1, 80, !dbg !151
  %arrayidx508.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1.1, !dbg !152
  %71 = load half, ptr addrspace(3) %arrayidx508.1.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %71, i64 1, !dbg !153
  %add503.2.1 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.2.1 = or disjoint i32 %add503.2.1, 144, !dbg !151
  %arrayidx508.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2.1, !dbg !152
  %72 = load half, ptr addrspace(3) %arrayidx508.2.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %72, i64 2, !dbg !153
  %add503.3.1 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.3.1 = or disjoint i32 %add503.3.1, 208, !dbg !151
  %arrayidx508.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3.1, !dbg !152
  %73 = load half, ptr addrspace(3) %arrayidx508.3.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %73, i64 3, !dbg !153
  %add503.2818 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.2819 = or disjoint i32 %add503.2818, 32, !dbg !151
  %arrayidx508.2820 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2819, !dbg !152
  %74 = load half, ptr addrspace(3) %arrayidx508.2820, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %74, i64 0, !dbg !153
  %add503.1.2 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.1.2 = or disjoint i32 %add503.1.2, 96, !dbg !151
  %arrayidx508.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1.2, !dbg !152
  %75 = load half, ptr addrspace(3) %arrayidx508.1.2, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %75, i64 1, !dbg !153
  %add503.2.2 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.2.2 = or disjoint i32 %add503.2.2, 160, !dbg !151
  %arrayidx508.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2.2, !dbg !152
  %76 = load half, ptr addrspace(3) %arrayidx508.2.2, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %76, i64 2, !dbg !153
  %add503.3.2 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.3.2 = or disjoint i32 %add503.3.2, 224, !dbg !151
  %arrayidx508.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3.2, !dbg !152
  %77 = load half, ptr addrspace(3) %arrayidx508.3.2, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %77, i64 3, !dbg !153
  %add503.3822 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.3823 = or disjoint i32 %add503.3822, 48, !dbg !151
  %arrayidx508.3824 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3823, !dbg !152
  %78 = load half, ptr addrspace(3) %arrayidx508.3824, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %78, i64 0, !dbg !153
  %add503.1.3 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.1.3 = or disjoint i32 %add503.1.3, 112, !dbg !151
  %arrayidx508.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1.3, !dbg !152
  %79 = load half, ptr addrspace(3) %arrayidx508.1.3, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %79, i64 1, !dbg !153
  %add503.2.3 = or disjoint i32 %mul498, %and505, !dbg !151
  %add506.2.3 = or disjoint i32 %add503.2.3, 176, !dbg !151
  %arrayidx508.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2.3, !dbg !152
  %80 = load half, ptr addrspace(3) %arrayidx508.2.3, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %80, i64 2, !dbg !153
  %add503.3.3 = or disjoint i32 %add.ptr303.idx, %and505, !dbg !151
  %add506.3.3 = or i32 %add503.3.3, 240, !dbg !151
  %arrayidx508.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3.3, !dbg !152
  %81 = load half, ptr addrspace(3) %arrayidx508.3.3, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %81, i64 3, !dbg !153
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !155
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !155
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !155
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !155
  %add499.1 = add nuw nsw i32 %mul498, 1024
  %add506.1826 = or disjoint i32 %add499.1, %and505, !dbg !151
  %arrayidx508.1827 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1826, !dbg !152
  %86 = load half, ptr addrspace(3) %arrayidx508.1827, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.0.vec.insert854 = insertelement <4 x half> poison, half %86, i64 0, !dbg !153
  %add501.1.1828 = add nuw nsw i32 %mul498, 1088, !dbg !156
  %add506.1.1829 = or disjoint i32 %add501.1.1828, %and505, !dbg !151
  %arrayidx508.1.1830 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1.1829, !dbg !152
  %87 = load half, ptr addrspace(3) %arrayidx508.1.1830, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.2.vec.insert856 = insertelement <4 x half> %vb.sroa.0.0.vec.insert854, half %87, i64 1, !dbg !153
  %add501.2.1832 = add nuw nsw i32 %mul498, 1152, !dbg !156
  %add506.2.1833 = or disjoint i32 %add501.2.1832, %and505, !dbg !151
  %arrayidx508.2.1834 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2.1833, !dbg !152
  %88 = load half, ptr addrspace(3) %arrayidx508.2.1834, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.4.vec.insert858 = insertelement <4 x half> %vb.sroa.0.2.vec.insert856, half %88, i64 2, !dbg !153
  %add501.3.1836 = add nuw nsw i32 %mul498, 1216, !dbg !156
  %add506.3.1837 = or disjoint i32 %add501.3.1836, %and505, !dbg !151
  %arrayidx508.3.1838 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3.1837, !dbg !152
  %89 = load half, ptr addrspace(3) %arrayidx508.3.1838, align 2, !dbg !153, !tbaa !154
  %vb.sroa.0.6.vec.insert860 = insertelement <4 x half> %vb.sroa.0.4.vec.insert858, half %89, i64 3, !dbg !153
  %add503.1814.1 = add nuw nsw i32 %mul498, 1040, !dbg !157
  %add506.1815.1 = or disjoint i32 %add503.1814.1, %and505, !dbg !151
  %arrayidx508.1816.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1815.1, !dbg !152
  %90 = load half, ptr addrspace(3) %arrayidx508.1816.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.8.vec.insert864 = insertelement <4 x half> poison, half %90, i64 0, !dbg !153
  %add503.1.1.1 = add nuw nsw i32 %mul498, 1104, !dbg !157
  %add506.1.1.1 = or disjoint i32 %add503.1.1.1, %and505, !dbg !151
  %arrayidx508.1.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1.1.1, !dbg !152
  %91 = load half, ptr addrspace(3) %arrayidx508.1.1.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.10.vec.insert866 = insertelement <4 x half> %vb.sroa.12.8.vec.insert864, half %91, i64 1, !dbg !153
  %add503.2.1.1 = add nuw nsw i32 %mul498, 1168, !dbg !157
  %add506.2.1.1 = or disjoint i32 %add503.2.1.1, %and505, !dbg !151
  %arrayidx508.2.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2.1.1, !dbg !152
  %92 = load half, ptr addrspace(3) %arrayidx508.2.1.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.12.vec.insert868 = insertelement <4 x half> %vb.sroa.12.10.vec.insert866, half %92, i64 2, !dbg !153
  %add503.3.1.1 = add nuw nsw i32 %mul498, 1232, !dbg !157
  %add506.3.1.1 = or disjoint i32 %add503.3.1.1, %and505, !dbg !151
  %arrayidx508.3.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3.1.1, !dbg !152
  %93 = load half, ptr addrspace(3) %arrayidx508.3.1.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.12.14.vec.insert870 = insertelement <4 x half> %vb.sroa.12.12.vec.insert868, half %93, i64 3, !dbg !153
  %add503.2818.1 = add nuw nsw i32 %mul498, 1056, !dbg !157
  %add506.2819.1 = or disjoint i32 %add503.2818.1, %and505, !dbg !151
  %arrayidx508.2820.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2819.1, !dbg !152
  %94 = load half, ptr addrspace(3) %arrayidx508.2820.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.16.vec.insert874 = insertelement <4 x half> poison, half %94, i64 0, !dbg !153
  %add503.1.2.1 = add nuw nsw i32 %mul498, 1120, !dbg !157
  %add506.1.2.1 = or disjoint i32 %add503.1.2.1, %and505, !dbg !151
  %arrayidx508.1.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1.2.1, !dbg !152
  %95 = load half, ptr addrspace(3) %arrayidx508.1.2.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.18.vec.insert876 = insertelement <4 x half> %vb.sroa.22.16.vec.insert874, half %95, i64 1, !dbg !153
  %add503.2.2.1 = add nuw nsw i32 %mul498, 1184, !dbg !157
  %add506.2.2.1 = or disjoint i32 %add503.2.2.1, %and505, !dbg !151
  %arrayidx508.2.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2.2.1, !dbg !152
  %96 = load half, ptr addrspace(3) %arrayidx508.2.2.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.20.vec.insert878 = insertelement <4 x half> %vb.sroa.22.18.vec.insert876, half %96, i64 2, !dbg !153
  %add503.3.2.1 = add nuw nsw i32 %mul498, 1248, !dbg !157
  %add506.3.2.1 = or disjoint i32 %add503.3.2.1, %and505, !dbg !151
  %arrayidx508.3.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3.2.1, !dbg !152
  %97 = load half, ptr addrspace(3) %arrayidx508.3.2.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.22.22.vec.insert880 = insertelement <4 x half> %vb.sroa.22.20.vec.insert878, half %97, i64 3, !dbg !153
  %add503.3822.1 = add nuw nsw i32 %mul498, 1072, !dbg !157
  %add506.3823.1 = or disjoint i32 %add503.3822.1, %and505, !dbg !151
  %arrayidx508.3824.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3823.1, !dbg !152
  %98 = load half, ptr addrspace(3) %arrayidx508.3824.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.24.vec.insert884 = insertelement <4 x half> poison, half %98, i64 0, !dbg !153
  %add503.1.3.1 = add nuw nsw i32 %mul498, 1136, !dbg !157
  %add506.1.3.1 = or disjoint i32 %add503.1.3.1, %and505, !dbg !151
  %arrayidx508.1.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.1.3.1, !dbg !152
  %99 = load half, ptr addrspace(3) %arrayidx508.1.3.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.26.vec.insert886 = insertelement <4 x half> %vb.sroa.32.24.vec.insert884, half %99, i64 1, !dbg !153
  %add503.2.3.1 = add nuw nsw i32 %mul498, 1200, !dbg !157
  %add506.2.3.1 = or disjoint i32 %add503.2.3.1, %and505, !dbg !151
  %arrayidx508.2.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.2.3.1, !dbg !152
  %100 = load half, ptr addrspace(3) %arrayidx508.2.3.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.28.vec.insert888 = insertelement <4 x half> %vb.sroa.32.26.vec.insert886, half %100, i64 2, !dbg !153
  %add503.3.3.1 = add nuw nsw i32 %mul498, 1264, !dbg !157
  %add506.3.3.1 = or disjoint i32 %add503.3.3.1, %and505, !dbg !151
  %arrayidx508.3.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add506.3.3.1, !dbg !152
  %101 = load half, ptr addrspace(3) %arrayidx508.3.3.1, align 2, !dbg !153, !tbaa !154
  %vb.sroa.32.30.vec.insert890 = insertelement <4 x half> %vb.sroa.32.28.vec.insert888, half %101, i64 3, !dbg !153
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert860, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %82), !dbg !155
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert870, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %83), !dbg !155
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert880, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %84), !dbg !155
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert890, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %85), !dbg !155
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !158
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !159
  %O_cast.sroa.0.0.insert.ext = zext i16 %106 to i64, !dbg !163
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !158
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !159
  %O_cast.sroa.0.2.insert.ext = zext i16 %107 to i64, !dbg !163
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !163
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !163
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !158
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !159
  %O_cast.sroa.0.4.insert.ext = zext i16 %108 to i64, !dbg !163
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !163
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !163
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !158
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !159
  %O_cast.sroa.0.6.insert.ext = zext i16 %109 to i64, !dbg !163
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !163
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !163
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %103, i64 0, !dbg !158
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract), !dbg !159
  %O_cast.sroa.7.8.insert.ext = zext i16 %110 to i64, !dbg !163
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %103, i64 1, !dbg !158
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract), !dbg !159
  %O_cast.sroa.7.10.insert.ext = zext i16 %111 to i64, !dbg !163
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !163
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !163
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %103, i64 2, !dbg !158
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract), !dbg !159
  %O_cast.sroa.7.12.insert.ext = zext i16 %112 to i64, !dbg !163
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !163
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !163
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %103, i64 3, !dbg !158
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract), !dbg !159
  %O_cast.sroa.7.14.insert.ext = zext i16 %113 to i64, !dbg !163
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !163
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !163
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %104, i64 0, !dbg !158
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract), !dbg !159
  %O_cast.sroa.12.16.insert.ext = zext i16 %114 to i64, !dbg !163
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %104, i64 1, !dbg !158
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract), !dbg !159
  %O_cast.sroa.12.18.insert.ext = zext i16 %115 to i64, !dbg !163
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !163
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !163
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %104, i64 2, !dbg !158
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract), !dbg !159
  %O_cast.sroa.12.20.insert.ext = zext i16 %116 to i64, !dbg !163
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !163
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !163
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %104, i64 3, !dbg !158
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract), !dbg !159
  %O_cast.sroa.12.22.insert.ext = zext i16 %117 to i64, !dbg !163
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !163
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !163
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %105, i64 0, !dbg !158
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract), !dbg !159
  %O_cast.sroa.17.24.insert.ext = zext i16 %118 to i64, !dbg !163
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %105, i64 1, !dbg !158
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract), !dbg !159
  %O_cast.sroa.17.26.insert.ext = zext i16 %119 to i64, !dbg !163
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !163
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !163
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %105, i64 2, !dbg !158
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract), !dbg !159
  %O_cast.sroa.17.28.insert.ext = zext i16 %120 to i64, !dbg !163
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !163
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !163
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %105, i64 3, !dbg !158
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract), !dbg !159
  %O_cast.sroa.17.30.insert.ext = zext i16 %121 to i64, !dbg !163
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !163
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !163
  %add582 = add nuw nsw i32 %add10, %mul324
  %122 = zext nneg i32 %add582 to i64, !dbg !164
  %add.ptr588 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122, !dbg !165
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr588, align 8, !dbg !166
  %123 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122, !dbg !165
  %add.ptr588.1 = getelementptr inbounds i8, ptr addrspace(1) %123, i64 32, !dbg !165
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr588.1, align 8, !dbg !166
  %124 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122, !dbg !165
  %add.ptr588.2 = getelementptr inbounds i8, ptr addrspace(1) %124, i64 64, !dbg !165
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr588.2, align 8, !dbg !166
  %125 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122, !dbg !165
  %add.ptr588.3 = getelementptr inbounds i8, ptr addrspace(1) %125, i64 96, !dbg !165
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr588.3, align 8, !dbg !166
  ret void, !dbg !167
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

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

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier() #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpekk0zitc/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpekk0zitc/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 27, column: 3, scope: !40)
!44 = !DILocation(line: 28, column: 46, scope: !40)
!45 = !DILocation(line: 28, column: 32, scope: !40)
!46 = !DILocation(line: 31, column: 3, scope: !40)
!47 = !DILocation(line: 32, column: 22, scope: !40)
!48 = !DILocation(line: 39, column: 27, scope: !40)
!49 = !DILocation(line: 32, column: 90, scope: !40)
!50 = !DILocation(line: 50, column: 60, scope: !40)
!51 = !DILocation(line: 57, column: 22, scope: !40)
!52 = !DILocation(line: 58, column: 101, scope: !40)
!53 = !DILocation(line: 58, column: 82, scope: !40)
!54 = !DILocation(line: 58, column: 117, scope: !40)
!55 = !DILocation(line: 58, column: 31, scope: !40)
!56 = !DILocation(line: 58, column: 17, scope: !40)
!57 = !DILocation(line: 59, column: 5, scope: !40)
!58 = !DILocation(line: 0, scope: !40)
!59 = !DILocation(line: 50, column: 31, scope: !40)
!60 = !DILocation(line: 52, column: 74, scope: !40)
!61 = !DILocation(line: 52, column: 61, scope: !40)
!62 = !DILocation(line: 68, column: 60, scope: !40)
!63 = !DILocation(line: 75, column: 22, scope: !40)
!64 = !DILocation(line: 76, column: 101, scope: !40)
!65 = !DILocation(line: 76, column: 82, scope: !40)
!66 = !DILocation(line: 76, column: 117, scope: !40)
!67 = !DILocation(line: 76, column: 31, scope: !40)
!68 = !DILocation(line: 76, column: 17, scope: !40)
!69 = !DILocation(line: 77, column: 5, scope: !40)
!70 = !DILocation(line: 68, column: 31, scope: !40)
!71 = !DILocation(line: 70, column: 74, scope: !40)
!72 = !DILocation(line: 70, column: 61, scope: !40)
!73 = !DILocation(line: 83, column: 3, scope: !40)
!74 = !DILocation(line: 84, column: 141, scope: !40)
!75 = !DILocation(line: 84, column: 24, scope: !40)
!76 = !DILocation(line: 60, column: 3, scope: !77, inlinedAt: !79)
!77 = distinct !DISubprogram(name: "__barrier", scope: !78, file: !78, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!78 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!79 = distinct !DILocation(line: 74, column: 3, scope: !80, inlinedAt: !81)
!80 = distinct !DISubprogram(name: "__syncthreads", scope: !78, file: !78, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!81 = distinct !DILocation(line: 91, column: 3, scope: !40)
!82 = !DILocation(line: 61, column: 3, scope: !77, inlinedAt: !79)
!83 = !DILocation(line: 62, column: 3, scope: !77, inlinedAt: !79)
!84 = !DILocation(line: 93, column: 5, scope: !40)
!85 = !DILocation(line: 94, column: 52, scope: !40)
!86 = !DILocation(line: 94, column: 31, scope: !40)
!87 = !DILocation(line: 94, column: 67, scope: !40)
!88 = !DILocation(line: 99, column: 38, scope: !40)
!89 = !{i32 -1, i32 3, i32 -1}
!90 = !DILocation(line: 60, column: 3, scope: !77, inlinedAt: !91)
!91 = distinct !DILocation(line: 74, column: 3, scope: !80, inlinedAt: !92)
!92 = distinct !DILocation(line: 106, column: 3, scope: !40)
!93 = !DILocation(line: 61, column: 3, scope: !77, inlinedAt: !91)
!94 = !DILocation(line: 62, column: 3, scope: !77, inlinedAt: !91)
!95 = !DILocation(line: 108, column: 8, scope: !40)
!96 = !DILocation(line: 109, column: 68, scope: !40)
!97 = !DILocation(line: 109, column: 24, scope: !40)
!98 = !DILocation(line: 115, column: 66, scope: !40)
!99 = !DILocation(line: 121, column: 66, scope: !40)
!100 = !DILocation(line: 127, column: 66, scope: !40)
!101 = !DILocation(line: 132, column: 14, scope: !40)
!102 = !DILocation(line: 132, column: 28, scope: !40)
!103 = !DILocation(line: 133, column: 29, scope: !40)
!104 = !DILocation(line: 133, column: 40, scope: !40)
!105 = !DILocation(line: 354, column: 10, scope: !106, inlinedAt: !108)
!106 = distinct !DISubprogram(name: "min", scope: !107, file: !107, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!108 = distinct !DILocation(line: 133, column: 24, scope: !40)
!109 = !DILocation(line: 288, column: 10, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "expf", scope: !107, file: !107, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 133, column: 19, scope: !40)
!112 = !DILocation(line: 134, column: 5, scope: !40)
!113 = !DILocation(line: 121, column: 53, scope: !40)
!114 = !DILocation(line: 127, column: 53, scope: !40)
!115 = !DILocation(line: 117, column: 102, scope: !40)
!116 = !DILocation(line: 123, column: 102, scope: !40)
!117 = !DILocation(line: 129, column: 102, scope: !40)
!118 = !DILocation(line: 123, column: 89, scope: !40)
!119 = !DILocation(line: 129, column: 89, scope: !40)
!120 = !DILocation(line: 144, column: 34, scope: !40)
!121 = !DILocation(line: 150, column: 44, scope: !40)
!122 = !DILocation(line: 155, column: 34, scope: !40)
!123 = !DILocation(line: 155, column: 32, scope: !40)
!124 = !DILocation(line: 155, column: 7, scope: !40)
!125 = !DILocation(line: 157, column: 37, scope: !40)
!126 = !DILocation(line: 157, column: 34, scope: !40)
!127 = !DILocation(line: 158, column: 20, scope: !40)
!128 = !DILocation(line: 158, column: 88, scope: !40)
!129 = !DILocation(line: 158, column: 68, scope: !40)
!130 = !DILocation(line: 158, column: 41, scope: !40)
!131 = !DILocation(line: 158, column: 162, scope: !40)
!132 = !DILocation(line: 158, column: 142, scope: !40)
!133 = !DILocation(line: 158, column: 115, scope: !40)
!134 = !DILocation(line: 159, column: 3, scope: !40)
!135 = !DILocation(line: 165, column: 30, scope: !40)
!136 = !DILocation(line: 75, column: 10, scope: !137, inlinedAt: !139)
!137 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !138, file: !138, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!138 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!139 = distinct !DILocation(line: 984, column: 9, scope: !140, inlinedAt: !142)
!140 = distinct !DISubprogram(name: "__float2half", scope: !141, file: !141, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!141 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!142 = distinct !DILocation(line: 133, column: 53, scope: !143, inlinedAt: !144)
!143 = distinct !DISubprogram(name: "__half", scope: !141, file: !141, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!144 = distinct !DILocation(line: 171, column: 53, scope: !40)
!145 = !DILocation(line: 171, column: 50, scope: !40)
!146 = !DILocation(line: 60, column: 3, scope: !77, inlinedAt: !147)
!147 = distinct !DILocation(line: 74, column: 3, scope: !80, inlinedAt: !148)
!148 = distinct !DILocation(line: 174, column: 3, scope: !40)
!149 = !DILocation(line: 61, column: 3, scope: !77, inlinedAt: !147)
!150 = !DILocation(line: 62, column: 3, scope: !77, inlinedAt: !147)
!151 = !DILocation(line: 178, column: 121, scope: !40)
!152 = !DILocation(line: 178, column: 31, scope: !40)
!153 = !DILocation(line: 178, column: 29, scope: !40)
!154 = !{!26, !26, i64 0}
!155 = !DILocation(line: 183, column: 38, scope: !40)
!156 = !DILocation(line: 178, column: 95, scope: !40)
!157 = !DILocation(line: 178, column: 107, scope: !40)
!158 = !DILocation(line: 193, column: 61, scope: !40)
!159 = !DILocation(line: 75, column: 10, scope: !137, inlinedAt: !160)
!160 = distinct !DILocation(line: 984, column: 9, scope: !140, inlinedAt: !161)
!161 = distinct !DILocation(line: 133, column: 53, scope: !143, inlinedAt: !162)
!162 = distinct !DILocation(line: 193, column: 53, scope: !40)
!163 = !DILocation(line: 193, column: 50, scope: !40)
!164 = !DILocation(line: 197, column: 3, scope: !40)
!165 = !DILocation(line: 198, column: 22, scope: !40)
!166 = !DILocation(line: 198, column: 173, scope: !40)
!167 = !DILocation(line: 200, column: 1, scope: !40)
