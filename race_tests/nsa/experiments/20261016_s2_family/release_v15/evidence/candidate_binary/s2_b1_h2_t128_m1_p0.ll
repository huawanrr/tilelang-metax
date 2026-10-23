; ModuleID = 'experiments/20261016_s2_family/candidate_binary/s2_b1_h2_t128_m1_p0.bc'
source_filename = "/tmp/tmpnh38d1nf/tvm_kernels.maca"
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
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
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
  %mul25 = shl nsw i32 %0, 2
  %mul27 = shl nuw nsw i32 %1, 1
  %add28 = add nuw nsw i32 %mul25, %mul27
  %6 = zext nneg i32 %add28 to i64, !dbg !46
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !47
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !47, !tbaa !30
  %cmp31 = icmp ult i32 %7, 8
  %8 = shl nsw i32 %7, 4, !dbg !48
  %mul32 = select i1 %cmp31, i32 %8, i32 -16, !dbg !48
  %9 = or disjoint i64 %6, 1, !dbg !49
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %9, !dbg !47
  %10 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !47, !tbaa !30
  %cmp31.1 = icmp ult i32 %10, 8
  %11 = shl nsw i32 %10, 4, !dbg !48
  %mul32.1 = select i1 %cmp31.1, i32 %11, i32 -16, !dbg !48
  %shr67 = lshr i32 %2, 3
  %conv78 = zext nneg i32 %1 to i64
  %mul79 = shl nuw nsw i64 %conv78, 6
  %12 = shl nuw nsw i32 %2, 3
  %13 = and i32 %12, 56
  %mul84 = zext nneg i32 %13 to i64
  %add63 = add nsw i32 %shr67, %mul32, !dbg !50
  %or.cond = icmp ult i32 %add63, 128, !dbg !51
  br i1 %or.cond, label %if.then75, label %if.then57.1, !dbg !51

if.then75:                                        ; preds = %entry
  %14 = shl nuw nsw i32 %add63, 7, !dbg !52
  %mul76 = zext nneg i32 %14 to i64, !dbg !52
  %add80 = add nuw nsw i64 %mul79, %mul76, !dbg !53
  %add85 = or disjoint i64 %add80, %mul84, !dbg !54
  %add.ptr86 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85, !dbg !55
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr86, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx, align 4, !dbg !56, !tbaa !30
  br label %if.then57.1, !dbg !57

if.then57.1:                                      ; preds = %if.then75, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then75 ], [ 0, %entry ], !dbg !58
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then75 ], [ 0, %entry ], !dbg !58
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then75 ], [ 0, %entry ], !dbg !58
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then75 ], [ 0, %entry ], !dbg !58
  %add61.1 = add nuw nsw i32 %shr67, 8, !dbg !59
  %add63.1 = add nsw i32 %add61.1, %mul32, !dbg !50
  %or.cond.1 = icmp ult i32 %add63.1, 128, !dbg !51
  br i1 %or.cond.1, label %if.then75.1, label %if.else64.2, !dbg !51

if.then75.1:                                      ; preds = %if.then57.1
  %15 = shl nuw nsw i32 %add63.1, 7, !dbg !52
  %mul76.1 = zext nneg i32 %15 to i64, !dbg !52
  %add80.1 = add nuw nsw i64 %mul79, %mul76.1, !dbg !53
  %add85.1 = or disjoint i64 %add80.1, %mul84, !dbg !54
  %add.ptr86.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85.1, !dbg !55
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr86.1, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.1, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx.1, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.1, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx.1, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.1, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx.1, align 4, !dbg !56, !tbaa !30
  br label %if.else64.2, !dbg !57

if.else64.2:                                      ; preds = %if.then57.1, %if.then75.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ], !dbg !58
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ], !dbg !58
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ], !dbg !58
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ], !dbg !58
  %sub.2 = add i32 %shr67, %mul32.1, !dbg !60
  %or.cond.2 = icmp ult i32 %sub.2, 128, !dbg !51
  br i1 %or.cond.2, label %if.then75.2, label %if.else64.3, !dbg !51

if.then75.2:                                      ; preds = %if.else64.2
  %16 = shl nuw nsw i32 %sub.2, 7, !dbg !52
  %mul76.2 = zext nneg i32 %16 to i64, !dbg !52
  %add80.2 = add nuw nsw i64 %mul79, %mul76.2, !dbg !53
  %add85.2 = or disjoint i64 %add80.2, %mul84, !dbg !54
  %add.ptr86.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85.2, !dbg !55
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr86.2, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.2, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx.2, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.2, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx.2, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.2, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx.2, align 4, !dbg !56, !tbaa !30
  br label %if.else64.3, !dbg !57

if.else64.3:                                      ; preds = %if.else64.2, %if.then75.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ], !dbg !58
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ], !dbg !58
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ], !dbg !58
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ], !dbg !58
  %add70.3 = add nuw nsw i32 %shr67, 8, !dbg !61
  %sub.3 = add i32 %add70.3, %mul32.1, !dbg !60
  %or.cond.3 = icmp ult i32 %sub.3, 128, !dbg !51
  br i1 %or.cond.3, label %if.then75.3, label %if.then122, !dbg !51

if.then75.3:                                      ; preds = %if.else64.3
  %17 = shl nuw nsw i32 %sub.3, 7, !dbg !52
  %mul76.3 = zext nneg i32 %17 to i64, !dbg !52
  %add80.3 = add nuw nsw i64 %mul79, %mul76.3, !dbg !53
  %add85.3 = or disjoint i64 %add80.3, %mul84, !dbg !54
  %add.ptr86.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85.3, !dbg !55
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr86.3, align 16, !dbg !56, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.3, i64 4, !dbg !56
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx.3, align 4, !dbg !56, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.3, i64 8, !dbg !56
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx.3, align 8, !dbg !56, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.3, i64 12, !dbg !56
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx.3, align 4, !dbg !56, !tbaa !30
  br label %if.then122, !dbg !57

if.then122:                                       ; preds = %if.else64.3, %if.then75.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ], !dbg !58
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ], !dbg !58
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ], !dbg !58
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ], !dbg !58
  %add128 = add nsw i32 %shr67, %mul32, !dbg !62
  %or.cond694 = icmp ult i32 %add128, 128, !dbg !63
  br i1 %or.cond694, label %if.then141, label %if.then122.1, !dbg !63

if.then141:                                       ; preds = %if.then122
  %18 = shl nuw nsw i32 %add128, 7, !dbg !64
  %mul143 = zext nneg i32 %18 to i64, !dbg !64
  %add147 = add nuw nsw i64 %mul79, %mul143, !dbg !65
  %add152 = or disjoint i64 %add147, %mul84, !dbg !66
  %add.ptr153 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152, !dbg !67
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr153, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx, align 4, !dbg !68, !tbaa !30
  br label %if.then122.1, !dbg !69

if.then122.1:                                     ; preds = %if.then141, %if.then122
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then141 ], [ 0, %if.then122 ], !dbg !58
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then141 ], [ 0, %if.then122 ], !dbg !58
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then141 ], [ 0, %if.then122 ], !dbg !58
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then141 ], [ 0, %if.then122 ], !dbg !58
  %add126.1 = add nuw nsw i32 %shr67, 8, !dbg !70
  %add128.1 = add nsw i32 %add126.1, %mul32, !dbg !62
  %or.cond694.1 = icmp ult i32 %add128.1, 128, !dbg !63
  br i1 %or.cond694.1, label %if.then141.1, label %if.else129.2, !dbg !63

if.then141.1:                                     ; preds = %if.then122.1
  %19 = shl nuw nsw i32 %add128.1, 7, !dbg !64
  %mul143.1 = zext nneg i32 %19 to i64, !dbg !64
  %add147.1 = add nuw nsw i64 %mul79, %mul143.1, !dbg !65
  %add152.1 = or disjoint i64 %add147.1, %mul84, !dbg !66
  %add.ptr153.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152.1, !dbg !67
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr153.1, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.1, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx.1, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.1, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx.1, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.1, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx.1, align 4, !dbg !68, !tbaa !30
  br label %if.else129.2, !dbg !69

if.else129.2:                                     ; preds = %if.then122.1, %if.then141.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ], !dbg !58
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ], !dbg !58
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ], !dbg !58
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ], !dbg !58
  %sub136.2 = add i32 %shr67, %mul32.1, !dbg !71
  %or.cond694.2 = icmp ult i32 %sub136.2, 128, !dbg !63
  br i1 %or.cond694.2, label %if.then141.2, label %if.else129.3, !dbg !63

if.then141.2:                                     ; preds = %if.else129.2
  %20 = shl nuw nsw i32 %sub136.2, 7, !dbg !64
  %mul143.2 = zext nneg i32 %20 to i64, !dbg !64
  %add147.2 = add nuw nsw i64 %mul79, %mul143.2, !dbg !65
  %add152.2 = or disjoint i64 %add147.2, %mul84, !dbg !66
  %add.ptr153.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152.2, !dbg !67
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr153.2, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.2, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx.2, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.2, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx.2, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.2, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx.2, align 4, !dbg !68, !tbaa !30
  br label %if.else129.3, !dbg !69

if.else129.3:                                     ; preds = %if.else129.2, %if.then141.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ], !dbg !58
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ], !dbg !58
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ], !dbg !58
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ], !dbg !58
  %add135.3 = add nuw nsw i32 %shr67, 8, !dbg !72
  %sub136.3 = add i32 %add135.3, %mul32.1, !dbg !71
  %or.cond694.3 = icmp ult i32 %sub136.3, 128, !dbg !63
  br i1 %or.cond694.3, label %if.then141.3, label %if.end177.3, !dbg !63

if.then141.3:                                     ; preds = %if.else129.3
  %21 = shl nuw nsw i32 %sub136.3, 7, !dbg !64
  %mul143.3 = zext nneg i32 %21 to i64, !dbg !64
  %add147.3 = add nuw nsw i64 %mul79, %mul143.3, !dbg !65
  %add152.3 = or disjoint i64 %add147.3, %mul84, !dbg !66
  %add.ptr153.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152.3, !dbg !67
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr153.3, align 16, !dbg !68, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.3, i64 4, !dbg !68
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx.3, align 4, !dbg !68, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.3, i64 8, !dbg !68
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx.3, align 8, !dbg !68, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.3, i64 12, !dbg !68
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx.3, align 4, !dbg !68, !tbaa !30
  br label %if.end177.3, !dbg !69

if.end177.3:                                      ; preds = %if.then141.3, %if.else129.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ], !dbg !58
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ], !dbg !58
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ], !dbg !58
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ], !dbg !58
  %mul197 = and i32 %12, 8128
  %call201.masked = and i32 %2, 1016
  %mul203 = xor i32 %13, %call201.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul197, !dbg !73
  %invariant.gep746 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul203, !dbg !73
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep746, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep746.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 4, !dbg !74
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep746.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep746.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 8, !dbg !74
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep746.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep746.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 12, !dbg !74
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep746.sroa_idx, align 4, !dbg !74, !tbaa !30
  %gep747.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1024, !dbg !75
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep747.1, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.9.16.gep747.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1028, !dbg !74
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep747.1.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.10.16.gep747.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1032, !dbg !74
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep747.1.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.11.16.gep747.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1036, !dbg !74
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep747.1.sroa_idx, align 4, !dbg !74, !tbaa !30
  %gep747.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2048, !dbg !75
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep747.2, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.14.32.gep747.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2052, !dbg !74
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep747.2.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.15.32.gep747.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2056, !dbg !74
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep747.2.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.16.32.gep747.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2060, !dbg !74
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep747.2.sroa_idx, align 4, !dbg !74, !tbaa !30
  %gep747.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3072, !dbg !75
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep747.3, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.19.48.gep747.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3076, !dbg !74
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep747.3.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.20.48.gep747.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3080, !dbg !74
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep747.3.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.21.48.gep747.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3084, !dbg !74
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep747.3.sroa_idx, align 4, !dbg !74, !tbaa !30
  fence syncscope("block") release, !dbg !76
  tail call void @llvm.mxc.barrier(), !dbg !82
  fence syncscope("block") acquire, !dbg !83
  %shr240 = lshr i32 %2, 4
  %and243 = and i32 %2, 7
  %xor244 = xor i32 %shr240, %and243
  %add.ptr248.idx = shl nuw nsw i32 %xor244, 4
  %invariant.gep750 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr248.idx, !dbg !84
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750, i32 %mul9, !dbg !85
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16, !dbg !86
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8, !dbg !86
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8, !dbg !86
  %add237.1 = or disjoint i32 %mul9, 1024, !dbg !87
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750, i32 %add237.1, !dbg !85
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16, !dbg !86
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8, !dbg !86
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8, !dbg !86
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !88, !call_argsrelate !89
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !88, !call_argsrelate !89
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !dbg !88, !call_argsrelate !89
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23), !dbg !88, !call_argsrelate !89
  %add241.1 = add nuw nsw i32 %shr240, 4
  %xor244.1 = xor i32 %add241.1, %and243
  %add.ptr248.idx.1 = shl nuw nsw i32 %xor244.1, 4
  %invariant.gep750.1 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr248.idx.1, !dbg !84
  %gep.1783 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750.1, i32 %mul9, !dbg !85
  %kb.sroa.0.0.copyload872 = load <4 x half>, ptr addrspace(3) %gep.1783, align 16, !dbg !86
  %kb.sroa.6.0.gep.1783.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1783, i32 8, !dbg !86
  %kb.sroa.6.0.copyload873 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1783.sroa_idx, align 8, !dbg !86
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750.1, i32 %add237.1, !dbg !85
  %kb.sroa.8.16.copyload876 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16, !dbg !86
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8, !dbg !86
  %kb.sroa.12.16.copyload877 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8, !dbg !86
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload872, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !dbg !88, !call_argsrelate !89
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload876, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %25), !dbg !88, !call_argsrelate !89
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload873, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !dbg !88, !call_argsrelate !89
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload877, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %27), !dbg !88, !call_argsrelate !89
  fence syncscope("block") release, !dbg !90
  tail call void @llvm.mxc.barrier(), !dbg !93
  fence syncscope("block") acquire, !dbg !94
  %add.ptr302.idx = shl nuw nsw i32 %2, 4
  %invariant.gep755 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr302.idx, !dbg !95
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep755, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep755.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 4, !dbg !96
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep755.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep755.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 8, !dbg !96
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep755.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep755.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 12, !dbg !96
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep755.sroa_idx, align 4, !dbg !96, !tbaa !30
  %gep756.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1024, !dbg !97
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep756.1, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.9.16.gep756.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1028, !dbg !96
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep756.1.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.10.16.gep756.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1032, !dbg !96
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep756.1.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.11.16.gep756.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1036, !dbg !96
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep756.1.sroa_idx, align 4, !dbg !96, !tbaa !30
  %gep756.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2048, !dbg !97
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep756.2, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.14.32.gep756.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2052, !dbg !96
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep756.2.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.15.32.gep756.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2056, !dbg !96
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep756.2.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.16.32.gep756.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2060, !dbg !96
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep756.2.sroa_idx, align 4, !dbg !96, !tbaa !30
  %gep756.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3072, !dbg !97
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep756.3, align 16, !dbg !96, !tbaa !30
  %V_reg.sroa.19.48.gep756.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3076, !dbg !96
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep756.3.sroa_idx, align 4, !dbg !96, !tbaa !30
  %V_reg.sroa.20.48.gep756.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3080, !dbg !96
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep756.3.sroa_idx, align 8, !dbg !96, !tbaa !30
  %V_reg.sroa.21.48.gep756.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3084, !dbg !96
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep756.3.sroa_idx, align 4, !dbg !96, !tbaa !30
  %30 = lshr i32 %2, 2
  %mul323 = and i32 %30, 252
  %add317 = add i32 %30, %mul32, !dbg !98
  %add338 = add i32 %mul323, %mul32, !dbg !99
  %add359 = add i32 %mul323, %mul32, !dbg !100
  %cmp373 = icmp slt i32 %add317, 0, !dbg !101
  %cmp375 = icmp sgt i32 %add338, 127
  %or.cond695.not775 = or i1 %cmp373, %cmp375, !dbg !102
  %cmp378.not = icmp sgt i32 %add359, %0
  %or.cond740 = or i1 %or.cond695.not775, %cmp378.not, !dbg !102
  br i1 %or.cond740, label %if.then311.1, label %if.then379, !dbg !102

if.then379:                                       ; preds = %if.end177.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0, !dbg !103
  %mul382 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !104
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul382, float 0x4024CB5EC0000000), !dbg !105
  %32 = tail call contract noundef float @llvm.exp.f32(float %31), !dbg !109
  br label %if.then311.1, !dbg !112

if.then311.1:                                     ; preds = %if.then379, %if.end177.3
  %condval_5.0 = phi float [ %32, %if.then379 ], [ 0.000000e+00, %if.end177.3 ], !dbg !58
  %add317.1 = add i32 %30, %mul32, !dbg !98
  %add337.1 = or disjoint i32 %mul323, 1, !dbg !113
  %add338.1 = add i32 %add337.1, %mul32, !dbg !99
  %add358.1 = or disjoint i32 %mul323, 1, !dbg !114
  %add359.1 = add i32 %add358.1, %mul32, !dbg !100
  %cmp373.1 = icmp slt i32 %add317.1, 0, !dbg !101
  %cmp375.1 = icmp sgt i32 %add338.1, 127
  %or.cond695.not775.1 = select i1 %cmp373.1, i1 true, i1 %cmp375.1, !dbg !102
  %cmp378.not.1 = icmp sgt i32 %add359.1, %0
  %or.cond740.1 = select i1 %or.cond695.not775.1, i1 true, i1 %cmp378.not.1, !dbg !102
  br i1 %or.cond740.1, label %if.then311.2, label %if.then379.1, !dbg !102

if.then379.1:                                     ; preds = %if.then311.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1, !dbg !103
  %mul382.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !104
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul382.1, float 0x4024CB5EC0000000), !dbg !105
  %34 = tail call contract noundef float @llvm.exp.f32(float %33), !dbg !109
  br label %if.then311.2, !dbg !112

if.then311.2:                                     ; preds = %if.then311.1, %if.then379.1
  %condval_5.0.1 = phi float [ %34, %if.then379.1 ], [ 0.000000e+00, %if.then311.1 ], !dbg !58
  %add317.2 = add i32 %30, %mul32, !dbg !98
  %add337.2 = or disjoint i32 %mul323, 2, !dbg !113
  %add338.2 = add i32 %add337.2, %mul32, !dbg !99
  %add358.2 = or disjoint i32 %mul323, 2, !dbg !114
  %add359.2 = add i32 %add358.2, %mul32, !dbg !100
  %cmp373.2 = icmp slt i32 %add317.2, 0, !dbg !101
  %cmp375.2 = icmp sgt i32 %add338.2, 127
  %or.cond695.not775.2 = select i1 %cmp373.2, i1 true, i1 %cmp375.2, !dbg !102
  %cmp378.not.2 = icmp sgt i32 %add359.2, %0
  %or.cond740.2 = select i1 %or.cond695.not775.2, i1 true, i1 %cmp378.not.2, !dbg !102
  br i1 %or.cond740.2, label %if.then311.3, label %if.then379.2, !dbg !102

if.then379.2:                                     ; preds = %if.then311.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2, !dbg !103
  %mul382.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !104
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul382.2, float 0x4024CB5EC0000000), !dbg !105
  %36 = tail call contract noundef float @llvm.exp.f32(float %35), !dbg !109
  br label %if.then311.3, !dbg !112

if.then311.3:                                     ; preds = %if.then311.2, %if.then379.2
  %condval_5.0.2 = phi float [ %36, %if.then379.2 ], [ 0.000000e+00, %if.then311.2 ], !dbg !58
  %add317.3 = add i32 %30, %mul32, !dbg !98
  %add337.3 = or i32 %30, 3, !dbg !113
  %add338.3 = add i32 %add337.3, %mul32, !dbg !99
  %add358.3 = or i32 %30, 3, !dbg !114
  %add359.3 = add i32 %add358.3, %mul32, !dbg !100
  %cmp373.3 = icmp slt i32 %add317.3, 0, !dbg !101
  %cmp375.3 = icmp sgt i32 %add338.3, 127
  %or.cond695.not775.3 = or i1 %cmp373.3, %cmp375.3, !dbg !102
  %cmp378.not.3 = icmp sgt i32 %add359.3, %0
  %or.cond740.3 = or i1 %or.cond695.not775.3, %cmp378.not.3, !dbg !102
  br i1 %or.cond740.3, label %if.else318.4, label %if.then379.3, !dbg !102

if.then379.3:                                     ; preds = %if.then311.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3, !dbg !103
  %mul382.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !104
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul382.3, float 0x4024CB5EC0000000), !dbg !105
  %38 = tail call contract noundef float @llvm.exp.f32(float %37), !dbg !109
  br label %if.else318.4, !dbg !112

if.else318.4:                                     ; preds = %if.then311.3, %if.then379.3
  %condval_5.0.3 = phi float [ %38, %if.then379.3 ], [ 0.000000e+00, %if.then311.3 ], !dbg !58
  %sub329.4 = add i32 %30, %mul32.1, !dbg !115
  %sub350.4 = add i32 %mul323, %mul32.1, !dbg !116
  %sub371.4 = add i32 %mul323, %mul32.1, !dbg !117
  %cmp373.4 = icmp slt i32 %sub329.4, 0, !dbg !101
  %cmp375.4 = icmp sgt i32 %sub350.4, 127
  %or.cond695.not775.4 = or i1 %cmp373.4, %cmp375.4, !dbg !102
  %cmp378.not.4 = icmp sgt i32 %sub371.4, %0
  %or.cond740.4 = select i1 %or.cond695.not775.4, i1 true, i1 %cmp378.not.4, !dbg !102
  br i1 %or.cond740.4, label %if.else318.5, label %if.then379.4, !dbg !102

if.then379.4:                                     ; preds = %if.else318.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %29, i64 0, !dbg !103
  %mul382.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000, !dbg !104
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul382.4, float 0x4024CB5EC0000000), !dbg !105
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !109
  br label %if.else318.5, !dbg !112

if.else318.5:                                     ; preds = %if.else318.4, %if.then379.4
  %condval_5.0.4 = phi float [ %40, %if.then379.4 ], [ 0.000000e+00, %if.else318.4 ], !dbg !58
  %sub329.5 = add i32 %30, %mul32.1, !dbg !115
  %add349.5 = or disjoint i32 %mul323, 1, !dbg !118
  %sub350.5 = add i32 %add349.5, %mul32.1, !dbg !116
  %add370.5 = or disjoint i32 %mul323, 1, !dbg !119
  %sub371.5 = add i32 %add370.5, %mul32.1, !dbg !117
  %cmp373.5 = icmp slt i32 %sub329.5, 0, !dbg !101
  %cmp375.5 = icmp sgt i32 %sub350.5, 127
  %or.cond695.not775.5 = select i1 %cmp373.5, i1 true, i1 %cmp375.5, !dbg !102
  %cmp378.not.5 = icmp sgt i32 %sub371.5, %0
  %or.cond740.5 = select i1 %or.cond695.not775.5, i1 true, i1 %cmp378.not.5, !dbg !102
  br i1 %or.cond740.5, label %if.else318.6, label %if.then379.5, !dbg !102

if.then379.5:                                     ; preds = %if.else318.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %29, i64 1, !dbg !103
  %mul382.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000, !dbg !104
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul382.5, float 0x4024CB5EC0000000), !dbg !105
  %42 = tail call contract noundef float @llvm.exp.f32(float %41), !dbg !109
  br label %if.else318.6, !dbg !112

if.else318.6:                                     ; preds = %if.else318.5, %if.then379.5
  %condval_5.0.5 = phi float [ %42, %if.then379.5 ], [ 0.000000e+00, %if.else318.5 ], !dbg !58
  %sub329.6 = add i32 %30, %mul32.1, !dbg !115
  %add349.6 = or disjoint i32 %mul323, 2, !dbg !118
  %sub350.6 = add i32 %add349.6, %mul32.1, !dbg !116
  %add370.6 = or disjoint i32 %mul323, 2, !dbg !119
  %sub371.6 = add i32 %add370.6, %mul32.1, !dbg !117
  %cmp373.6 = icmp slt i32 %sub329.6, 0, !dbg !101
  %cmp375.6 = icmp sgt i32 %sub350.6, 127
  %or.cond695.not775.6 = select i1 %cmp373.6, i1 true, i1 %cmp375.6, !dbg !102
  %cmp378.not.6 = icmp sgt i32 %sub371.6, %0
  %or.cond740.6 = select i1 %or.cond695.not775.6, i1 true, i1 %cmp378.not.6, !dbg !102
  br i1 %or.cond740.6, label %if.else318.7, label %if.then379.6, !dbg !102

if.then379.6:                                     ; preds = %if.else318.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %29, i64 2, !dbg !103
  %mul382.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000, !dbg !104
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul382.6, float 0x4024CB5EC0000000), !dbg !105
  %44 = tail call contract noundef float @llvm.exp.f32(float %43), !dbg !109
  br label %if.else318.7, !dbg !112

if.else318.7:                                     ; preds = %if.else318.6, %if.then379.6
  %condval_5.0.6 = phi float [ %44, %if.then379.6 ], [ 0.000000e+00, %if.else318.6 ], !dbg !58
  %sub329.7 = add i32 %30, %mul32.1, !dbg !115
  %add349.7 = or i32 %30, 3, !dbg !118
  %sub350.7 = add i32 %add349.7, %mul32.1, !dbg !116
  %add370.7 = or i32 %30, 3, !dbg !119
  %sub371.7 = add i32 %add370.7, %mul32.1, !dbg !117
  %cmp373.7 = icmp slt i32 %sub329.7, 0, !dbg !101
  %cmp375.7 = icmp sgt i32 %sub350.7, 127
  %or.cond695.not775.7 = or i1 %cmp373.7, %cmp375.7, !dbg !102
  %cmp378.not.7 = icmp sgt i32 %sub371.7, %0
  %or.cond740.7 = select i1 %or.cond695.not775.7, i1 true, i1 %cmp378.not.7, !dbg !102
  br i1 %or.cond740.7, label %if.end386.7, label %if.then379.7, !dbg !102

if.then379.7:                                     ; preds = %if.else318.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %29, i64 3, !dbg !103
  %mul382.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000, !dbg !104
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul382.7, float 0x4024CB5EC0000000), !dbg !105
  %46 = tail call contract noundef float @llvm.exp.f32(float %45), !dbg !109
  br label %if.end386.7, !dbg !112

if.end386.7:                                      ; preds = %if.then379.7, %if.else318.7
  %condval_5.0.7 = phi float [ %46, %if.then379.7 ], [ 0.000000e+00, %if.else318.7 ], !dbg !58
  %add406.1 = fadd contract float %condval_5.0, %condval_5.0.1, !dbg !120
  %add406.2 = fadd contract float %add406.1, %condval_5.0.2, !dbg !120
  %add406.3 = fadd contract float %add406.2, %condval_5.0.3, !dbg !120
  %add406.1789 = fadd contract float %add406.3, %condval_5.0.4, !dbg !120
  %add406.1.1 = fadd contract float %add406.1789, %condval_5.0.5, !dbg !120
  %add406.2.1 = fadd contract float %add406.1.1, %condval_5.0.6, !dbg !120
  %add406.3.1 = fadd contract float %add406.2.1, %condval_5.0.7, !dbg !120
  %47 = bitcast float %add406.3.1 to i32, !dbg !121
  %48 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !124
  %49 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %48) #10, !dbg !129
  %xor.i.i = xor i32 %49, 32, !dbg !130
  %50 = and i32 %49, -64, !dbg !131
  %and.i.i = add nsw i32 %50, 64, !dbg !131
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !132
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %49, !dbg !133
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !134
  %51 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %47), !dbg !135
  %52 = bitcast i32 %51 to float, !dbg !136
  %add417 = fadd contract float %add406.3.1, %52, !dbg !137
  %53 = bitcast float %add417 to i32, !dbg !138
  %54 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !140
  %55 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %54) #10, !dbg !143
  %xor.i.i728 = xor i32 %55, 16, !dbg !144
  %56 = and i32 %55, -64, !dbg !145
  %and.i.i729 = add nsw i32 %56, 64, !dbg !145
  %cmp.not.i.i730 = icmp slt i32 %xor.i.i728, %and.i.i729, !dbg !146
  %cond.i.i731 = select i1 %cmp.not.i.i730, i32 %xor.i.i728, i32 %55, !dbg !147
  %shl.i.i732 = shl i32 %cond.i.i731, 2, !dbg !148
  %57 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i732, i32 %53), !dbg !149
  %58 = bitcast i32 %57 to float, !dbg !150
  %add422 = fadd contract float %add417, %58, !dbg !151
  %cmp425 = fcmp contract ogt float %add422, 0.000000e+00, !dbg !152
  %div = fdiv contract float 1.000000e+00, %add422, !dbg !153
  %condval_9.0 = select i1 %cmp425, float %div, float 0.000000e+00, !dbg !153
  %mul438 = fmul contract float %condval_9.0, %condval_5.0, !dbg !154
  %mul438.1 = fmul contract float %condval_9.0, %condval_5.0.1, !dbg !154
  %mul438.2 = fmul contract float %condval_9.0, %condval_5.0.2, !dbg !154
  %mul438.3 = fmul contract float %condval_9.0, %condval_5.0.3, !dbg !154
  %mul438.4 = fmul contract float %condval_9.0, %condval_5.0.4, !dbg !154
  %mul438.5 = fmul contract float %condval_9.0, %condval_5.0.5, !dbg !154
  %mul438.6 = fmul contract float %condval_9.0, %condval_5.0.6, !dbg !154
  %mul438.7 = fmul contract float %condval_9.0, %condval_5.0.7, !dbg !154
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438), !dbg !155
  %60 = insertelement <4 x i16> poison, i16 %59, i64 0, !dbg !164
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.1), !dbg !155
  %62 = insertelement <4 x i16> %60, i16 %61, i64 1, !dbg !164
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.2), !dbg !155
  %64 = insertelement <4 x i16> %62, i16 %63, i64 2, !dbg !164
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.3), !dbg !155
  %66 = insertelement <4 x i16> %64, i16 %65, i64 3, !dbg !164
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %66 to <4 x half>, !dbg !164
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.4), !dbg !155
  %68 = insertelement <4 x i16> poison, i16 %67, i64 0, !dbg !164
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.5), !dbg !155
  %70 = insertelement <4 x i16> %68, i16 %69, i64 1, !dbg !164
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.6), !dbg !155
  %72 = insertelement <4 x i16> %70, i16 %71, i64 2, !dbg !164
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.7), !dbg !155
  %74 = insertelement <4 x i16> %72, i16 %73, i64 3, !dbg !164
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %74 to <4 x half>, !dbg !164
  fence syncscope("block") release, !dbg !165
  tail call void @llvm.mxc.barrier(), !dbg !168
  fence syncscope("block") acquire, !dbg !169
  %mul482 = and i32 %add.ptr302.idx, 16128
  %and489 = and i32 %2, 15
  %add490 = or disjoint i32 %mul482, %and489, !dbg !170
  %arrayidx492 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490, !dbg !171
  %75 = load half, ptr addrspace(3) %arrayidx492, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %75, i64 0, !dbg !172
  %add485.1 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.1 = or disjoint i32 %add485.1, 64, !dbg !170
  %arrayidx492.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1, !dbg !171
  %76 = load half, ptr addrspace(3) %arrayidx492.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %76, i64 1, !dbg !172
  %add485.2 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.2 = or disjoint i32 %add485.2, 128, !dbg !170
  %arrayidx492.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2, !dbg !171
  %77 = load half, ptr addrspace(3) %arrayidx492.2, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %77, i64 2, !dbg !172
  %add485.3 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.3 = or disjoint i32 %add485.3, 192, !dbg !170
  %arrayidx492.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3, !dbg !171
  %78 = load half, ptr addrspace(3) %arrayidx492.3, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %78, i64 3, !dbg !172
  %add487.1792 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.1793 = or disjoint i32 %add487.1792, 16, !dbg !170
  %arrayidx492.1794 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1793, !dbg !171
  %79 = load half, ptr addrspace(3) %arrayidx492.1794, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %79, i64 0, !dbg !172
  %add487.1.1 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.1.1 = or disjoint i32 %add487.1.1, 80, !dbg !170
  %arrayidx492.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.1, !dbg !171
  %80 = load half, ptr addrspace(3) %arrayidx492.1.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %80, i64 1, !dbg !172
  %add487.2.1 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.2.1 = or disjoint i32 %add487.2.1, 144, !dbg !170
  %arrayidx492.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.1, !dbg !171
  %81 = load half, ptr addrspace(3) %arrayidx492.2.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %81, i64 2, !dbg !172
  %add487.3.1 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.3.1 = or disjoint i32 %add487.3.1, 208, !dbg !170
  %arrayidx492.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.1, !dbg !171
  %82 = load half, ptr addrspace(3) %arrayidx492.3.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %82, i64 3, !dbg !172
  %add487.2796 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.2797 = or disjoint i32 %add487.2796, 32, !dbg !170
  %arrayidx492.2798 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2797, !dbg !171
  %83 = load half, ptr addrspace(3) %arrayidx492.2798, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %83, i64 0, !dbg !172
  %add487.1.2 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.1.2 = or disjoint i32 %add487.1.2, 96, !dbg !170
  %arrayidx492.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.2, !dbg !171
  %84 = load half, ptr addrspace(3) %arrayidx492.1.2, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %84, i64 1, !dbg !172
  %add487.2.2 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.2.2 = or disjoint i32 %add487.2.2, 160, !dbg !170
  %arrayidx492.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.2, !dbg !171
  %85 = load half, ptr addrspace(3) %arrayidx492.2.2, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %85, i64 2, !dbg !172
  %add487.3.2 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.3.2 = or disjoint i32 %add487.3.2, 224, !dbg !170
  %arrayidx492.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.2, !dbg !171
  %86 = load half, ptr addrspace(3) %arrayidx492.3.2, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %86, i64 3, !dbg !172
  %add487.3800 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.3801 = or disjoint i32 %add487.3800, 48, !dbg !170
  %arrayidx492.3802 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3801, !dbg !171
  %87 = load half, ptr addrspace(3) %arrayidx492.3802, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %87, i64 0, !dbg !172
  %add487.1.3 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.1.3 = or disjoint i32 %add487.1.3, 112, !dbg !170
  %arrayidx492.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.3, !dbg !171
  %88 = load half, ptr addrspace(3) %arrayidx492.1.3, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %88, i64 1, !dbg !172
  %add487.2.3 = or disjoint i32 %mul482, %and489, !dbg !170
  %add490.2.3 = or disjoint i32 %add487.2.3, 176, !dbg !170
  %arrayidx492.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.3, !dbg !171
  %89 = load half, ptr addrspace(3) %arrayidx492.2.3, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %89, i64 2, !dbg !172
  %add487.3.3 = or disjoint i32 %add.ptr302.idx, %and489, !dbg !170
  %add490.3.3 = or i32 %add487.3.3, 240, !dbg !170
  %arrayidx492.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.3, !dbg !171
  %90 = load half, ptr addrspace(3) %arrayidx492.3.3, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %90, i64 3, !dbg !172
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !174
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !174
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !174
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !174
  %add483.1 = add nuw nsw i32 %mul482, 1024
  %add490.1804 = or disjoint i32 %add483.1, %and489, !dbg !170
  %arrayidx492.1805 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1804, !dbg !171
  %95 = load half, ptr addrspace(3) %arrayidx492.1805, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.0.vec.insert832 = insertelement <4 x half> poison, half %95, i64 0, !dbg !172
  %add485.1.1806 = add nuw nsw i32 %mul482, 1088, !dbg !175
  %add490.1.1807 = or disjoint i32 %add485.1.1806, %and489, !dbg !170
  %arrayidx492.1.1808 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.1807, !dbg !171
  %96 = load half, ptr addrspace(3) %arrayidx492.1.1808, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.2.vec.insert834 = insertelement <4 x half> %vb.sroa.0.0.vec.insert832, half %96, i64 1, !dbg !172
  %add485.2.1810 = add nuw nsw i32 %mul482, 1152, !dbg !175
  %add490.2.1811 = or disjoint i32 %add485.2.1810, %and489, !dbg !170
  %arrayidx492.2.1812 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.1811, !dbg !171
  %97 = load half, ptr addrspace(3) %arrayidx492.2.1812, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.4.vec.insert836 = insertelement <4 x half> %vb.sroa.0.2.vec.insert834, half %97, i64 2, !dbg !172
  %add485.3.1814 = add nuw nsw i32 %mul482, 1216, !dbg !175
  %add490.3.1815 = or disjoint i32 %add485.3.1814, %and489, !dbg !170
  %arrayidx492.3.1816 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.1815, !dbg !171
  %98 = load half, ptr addrspace(3) %arrayidx492.3.1816, align 2, !dbg !172, !tbaa !173
  %vb.sroa.0.6.vec.insert838 = insertelement <4 x half> %vb.sroa.0.4.vec.insert836, half %98, i64 3, !dbg !172
  %add487.1792.1 = add nuw nsw i32 %mul482, 1040, !dbg !176
  %add490.1793.1 = or disjoint i32 %add487.1792.1, %and489, !dbg !170
  %arrayidx492.1794.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1793.1, !dbg !171
  %99 = load half, ptr addrspace(3) %arrayidx492.1794.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.8.vec.insert842 = insertelement <4 x half> poison, half %99, i64 0, !dbg !172
  %add487.1.1.1 = add nuw nsw i32 %mul482, 1104, !dbg !176
  %add490.1.1.1 = or disjoint i32 %add487.1.1.1, %and489, !dbg !170
  %arrayidx492.1.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.1.1, !dbg !171
  %100 = load half, ptr addrspace(3) %arrayidx492.1.1.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.10.vec.insert844 = insertelement <4 x half> %vb.sroa.12.8.vec.insert842, half %100, i64 1, !dbg !172
  %add487.2.1.1 = add nuw nsw i32 %mul482, 1168, !dbg !176
  %add490.2.1.1 = or disjoint i32 %add487.2.1.1, %and489, !dbg !170
  %arrayidx492.2.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.1.1, !dbg !171
  %101 = load half, ptr addrspace(3) %arrayidx492.2.1.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.12.vec.insert846 = insertelement <4 x half> %vb.sroa.12.10.vec.insert844, half %101, i64 2, !dbg !172
  %add487.3.1.1 = add nuw nsw i32 %mul482, 1232, !dbg !176
  %add490.3.1.1 = or disjoint i32 %add487.3.1.1, %and489, !dbg !170
  %arrayidx492.3.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.1.1, !dbg !171
  %102 = load half, ptr addrspace(3) %arrayidx492.3.1.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.12.14.vec.insert848 = insertelement <4 x half> %vb.sroa.12.12.vec.insert846, half %102, i64 3, !dbg !172
  %add487.2796.1 = add nuw nsw i32 %mul482, 1056, !dbg !176
  %add490.2797.1 = or disjoint i32 %add487.2796.1, %and489, !dbg !170
  %arrayidx492.2798.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2797.1, !dbg !171
  %103 = load half, ptr addrspace(3) %arrayidx492.2798.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.16.vec.insert852 = insertelement <4 x half> poison, half %103, i64 0, !dbg !172
  %add487.1.2.1 = add nuw nsw i32 %mul482, 1120, !dbg !176
  %add490.1.2.1 = or disjoint i32 %add487.1.2.1, %and489, !dbg !170
  %arrayidx492.1.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.2.1, !dbg !171
  %104 = load half, ptr addrspace(3) %arrayidx492.1.2.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.18.vec.insert854 = insertelement <4 x half> %vb.sroa.22.16.vec.insert852, half %104, i64 1, !dbg !172
  %add487.2.2.1 = add nuw nsw i32 %mul482, 1184, !dbg !176
  %add490.2.2.1 = or disjoint i32 %add487.2.2.1, %and489, !dbg !170
  %arrayidx492.2.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.2.1, !dbg !171
  %105 = load half, ptr addrspace(3) %arrayidx492.2.2.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.20.vec.insert856 = insertelement <4 x half> %vb.sroa.22.18.vec.insert854, half %105, i64 2, !dbg !172
  %add487.3.2.1 = add nuw nsw i32 %mul482, 1248, !dbg !176
  %add490.3.2.1 = or disjoint i32 %add487.3.2.1, %and489, !dbg !170
  %arrayidx492.3.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.2.1, !dbg !171
  %106 = load half, ptr addrspace(3) %arrayidx492.3.2.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.22.22.vec.insert858 = insertelement <4 x half> %vb.sroa.22.20.vec.insert856, half %106, i64 3, !dbg !172
  %add487.3800.1 = add nuw nsw i32 %mul482, 1072, !dbg !176
  %add490.3801.1 = or disjoint i32 %add487.3800.1, %and489, !dbg !170
  %arrayidx492.3802.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3801.1, !dbg !171
  %107 = load half, ptr addrspace(3) %arrayidx492.3802.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.24.vec.insert862 = insertelement <4 x half> poison, half %107, i64 0, !dbg !172
  %add487.1.3.1 = add nuw nsw i32 %mul482, 1136, !dbg !176
  %add490.1.3.1 = or disjoint i32 %add487.1.3.1, %and489, !dbg !170
  %arrayidx492.1.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.3.1, !dbg !171
  %108 = load half, ptr addrspace(3) %arrayidx492.1.3.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.26.vec.insert864 = insertelement <4 x half> %vb.sroa.32.24.vec.insert862, half %108, i64 1, !dbg !172
  %add487.2.3.1 = add nuw nsw i32 %mul482, 1200, !dbg !176
  %add490.2.3.1 = or disjoint i32 %add487.2.3.1, %and489, !dbg !170
  %arrayidx492.2.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.3.1, !dbg !171
  %109 = load half, ptr addrspace(3) %arrayidx492.2.3.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.28.vec.insert866 = insertelement <4 x half> %vb.sroa.32.26.vec.insert864, half %109, i64 2, !dbg !172
  %add487.3.3.1 = add nuw nsw i32 %mul482, 1264, !dbg !176
  %add490.3.3.1 = or disjoint i32 %add487.3.3.1, %and489, !dbg !170
  %arrayidx492.3.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.3.1, !dbg !171
  %110 = load half, ptr addrspace(3) %arrayidx492.3.3.1, align 2, !dbg !172, !tbaa !173
  %vb.sroa.32.30.vec.insert868 = insertelement <4 x half> %vb.sroa.32.28.vec.insert866, half %110, i64 3, !dbg !172
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert838, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %91), !dbg !174
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert848, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %92), !dbg !174
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert858, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %93), !dbg !174
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert868, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %94), !dbg !174
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %111, i64 0, !dbg !177
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !178
  %O_cast.sroa.0.0.insert.ext = zext i16 %115 to i64, !dbg !182
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %111, i64 1, !dbg !177
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !178
  %O_cast.sroa.0.2.insert.ext = zext i16 %116 to i64, !dbg !182
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !182
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !182
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %111, i64 2, !dbg !177
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !178
  %O_cast.sroa.0.4.insert.ext = zext i16 %117 to i64, !dbg !182
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !182
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !182
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %111, i64 3, !dbg !177
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !178
  %O_cast.sroa.0.6.insert.ext = zext i16 %118 to i64, !dbg !182
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !182
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !182
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %112, i64 0, !dbg !177
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract), !dbg !178
  %O_cast.sroa.7.8.insert.ext = zext i16 %119 to i64, !dbg !182
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %112, i64 1, !dbg !177
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract), !dbg !178
  %O_cast.sroa.7.10.insert.ext = zext i16 %120 to i64, !dbg !182
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !182
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !182
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %112, i64 2, !dbg !177
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract), !dbg !178
  %O_cast.sroa.7.12.insert.ext = zext i16 %121 to i64, !dbg !182
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !182
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !182
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %112, i64 3, !dbg !177
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract), !dbg !178
  %O_cast.sroa.7.14.insert.ext = zext i16 %122 to i64, !dbg !182
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !182
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !182
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %113, i64 0, !dbg !177
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract), !dbg !178
  %O_cast.sroa.12.16.insert.ext = zext i16 %123 to i64, !dbg !182
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %113, i64 1, !dbg !177
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract), !dbg !178
  %O_cast.sroa.12.18.insert.ext = zext i16 %124 to i64, !dbg !182
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !182
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !182
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %113, i64 2, !dbg !177
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract), !dbg !178
  %O_cast.sroa.12.20.insert.ext = zext i16 %125 to i64, !dbg !182
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !182
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !182
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %113, i64 3, !dbg !177
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract), !dbg !178
  %O_cast.sroa.12.22.insert.ext = zext i16 %126 to i64, !dbg !182
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !182
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !182
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %114, i64 0, !dbg !177
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract), !dbg !178
  %O_cast.sroa.17.24.insert.ext = zext i16 %127 to i64, !dbg !182
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %114, i64 1, !dbg !177
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract), !dbg !178
  %O_cast.sroa.17.26.insert.ext = zext i16 %128 to i64, !dbg !182
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !182
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !182
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %114, i64 2, !dbg !177
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract), !dbg !178
  %O_cast.sroa.17.28.insert.ext = zext i16 %129 to i64, !dbg !182
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !182
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !182
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %114, i64 3, !dbg !177
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract), !dbg !178
  %O_cast.sroa.17.30.insert.ext = zext i16 %130 to i64, !dbg !182
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !182
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !182
  %add566 = add nuw nsw i32 %add10, %mul323
  %131 = zext nneg i32 %add566 to i64, !dbg !183
  %add.ptr572 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !184
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr572, align 8, !dbg !185
  %132 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !184
  %add.ptr572.1 = getelementptr inbounds i8, ptr addrspace(1) %132, i64 32, !dbg !184
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr572.1, align 8, !dbg !185
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !184
  %add.ptr572.2 = getelementptr inbounds i8, ptr addrspace(1) %133, i64 64, !dbg !184
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr572.2, align 8, !dbg !185
  %134 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !184
  %add.ptr572.3 = getelementptr inbounds i8, ptr addrspace(1) %134, i64 96, !dbg !184
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr572.3, align 8, !dbg !185
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier() #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

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
attributes #10 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpnh38d1nf/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpnh38d1nf/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 25, column: 46, scope: !40)
!45 = !DILocation(line: 25, column: 32, scope: !40)
!46 = !DILocation(line: 28, column: 3, scope: !40)
!47 = !DILocation(line: 29, column: 22, scope: !40)
!48 = !DILocation(line: 36, column: 27, scope: !40)
!49 = !DILocation(line: 29, column: 88, scope: !40)
!50 = !DILocation(line: 47, column: 60, scope: !40)
!51 = !DILocation(line: 54, column: 22, scope: !40)
!52 = !DILocation(line: 55, column: 52, scope: !40)
!53 = !DILocation(line: 55, column: 68, scope: !40)
!54 = !DILocation(line: 55, column: 116, scope: !40)
!55 = !DILocation(line: 55, column: 31, scope: !40)
!56 = !DILocation(line: 55, column: 17, scope: !40)
!57 = !DILocation(line: 56, column: 5, scope: !40)
!58 = !DILocation(line: 0, scope: !40)
!59 = !DILocation(line: 47, column: 31, scope: !40)
!60 = !DILocation(line: 49, column: 74, scope: !40)
!61 = !DILocation(line: 49, column: 61, scope: !40)
!62 = !DILocation(line: 65, column: 60, scope: !40)
!63 = !DILocation(line: 72, column: 22, scope: !40)
!64 = !DILocation(line: 73, column: 52, scope: !40)
!65 = !DILocation(line: 73, column: 68, scope: !40)
!66 = !DILocation(line: 73, column: 116, scope: !40)
!67 = !DILocation(line: 73, column: 31, scope: !40)
!68 = !DILocation(line: 73, column: 17, scope: !40)
!69 = !DILocation(line: 74, column: 5, scope: !40)
!70 = !DILocation(line: 65, column: 31, scope: !40)
!71 = !DILocation(line: 67, column: 74, scope: !40)
!72 = !DILocation(line: 67, column: 61, scope: !40)
!73 = !DILocation(line: 80, column: 3, scope: !40)
!74 = !DILocation(line: 81, column: 141, scope: !40)
!75 = !DILocation(line: 81, column: 24, scope: !40)
!76 = !DILocation(line: 60, column: 3, scope: !77, inlinedAt: !79)
!77 = distinct !DISubprogram(name: "__barrier", scope: !78, file: !78, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!78 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!79 = distinct !DILocation(line: 74, column: 3, scope: !80, inlinedAt: !81)
!80 = distinct !DISubprogram(name: "__syncthreads", scope: !78, file: !78, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!81 = distinct !DILocation(line: 88, column: 3, scope: !40)
!82 = !DILocation(line: 61, column: 3, scope: !77, inlinedAt: !79)
!83 = !DILocation(line: 62, column: 3, scope: !77, inlinedAt: !79)
!84 = !DILocation(line: 90, column: 5, scope: !40)
!85 = !DILocation(line: 91, column: 52, scope: !40)
!86 = !DILocation(line: 91, column: 31, scope: !40)
!87 = !DILocation(line: 91, column: 67, scope: !40)
!88 = !DILocation(line: 96, column: 38, scope: !40)
!89 = !{i32 -1, i32 3, i32 -1}
!90 = !DILocation(line: 60, column: 3, scope: !77, inlinedAt: !91)
!91 = distinct !DILocation(line: 74, column: 3, scope: !80, inlinedAt: !92)
!92 = distinct !DILocation(line: 103, column: 3, scope: !40)
!93 = !DILocation(line: 61, column: 3, scope: !77, inlinedAt: !91)
!94 = !DILocation(line: 62, column: 3, scope: !77, inlinedAt: !91)
!95 = !DILocation(line: 105, column: 8, scope: !40)
!96 = !DILocation(line: 106, column: 68, scope: !40)
!97 = !DILocation(line: 106, column: 24, scope: !40)
!98 = !DILocation(line: 112, column: 66, scope: !40)
!99 = !DILocation(line: 118, column: 66, scope: !40)
!100 = !DILocation(line: 124, column: 66, scope: !40)
!101 = !DILocation(line: 129, column: 14, scope: !40)
!102 = !DILocation(line: 129, column: 28, scope: !40)
!103 = !DILocation(line: 130, column: 29, scope: !40)
!104 = !DILocation(line: 130, column: 40, scope: !40)
!105 = !DILocation(line: 354, column: 10, scope: !106, inlinedAt: !108)
!106 = distinct !DISubprogram(name: "min", scope: !107, file: !107, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!108 = distinct !DILocation(line: 130, column: 24, scope: !40)
!109 = !DILocation(line: 288, column: 10, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "expf", scope: !107, file: !107, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 130, column: 19, scope: !40)
!112 = !DILocation(line: 131, column: 5, scope: !40)
!113 = !DILocation(line: 118, column: 53, scope: !40)
!114 = !DILocation(line: 124, column: 53, scope: !40)
!115 = !DILocation(line: 114, column: 102, scope: !40)
!116 = !DILocation(line: 120, column: 102, scope: !40)
!117 = !DILocation(line: 126, column: 102, scope: !40)
!118 = !DILocation(line: 120, column: 89, scope: !40)
!119 = !DILocation(line: 126, column: 89, scope: !40)
!120 = !DILocation(line: 141, column: 34, scope: !40)
!121 = !DILocation(line: 1018, column: 9, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !78, file: !78, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 144, column: 32, scope: !40)
!124 = !DILocation(line: 171, column: 37, scope: !125, inlinedAt: !126)
!125 = distinct !DISubprogram(name: "__lane_id", scope: !78, file: !78, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!126 = distinct !DILocation(line: 990, column: 14, scope: !127, inlinedAt: !128)
!127 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !78, file: !78, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!128 = distinct !DILocation(line: 1019, column: 11, scope: !122, inlinedAt: !123)
!129 = !DILocation(line: 171, column: 10, scope: !125, inlinedAt: !126)
!130 = !DILocation(line: 991, column: 20, scope: !127, inlinedAt: !128)
!131 = !DILocation(line: 992, column: 36, scope: !127, inlinedAt: !128)
!132 = !DILocation(line: 992, column: 17, scope: !127, inlinedAt: !128)
!133 = !DILocation(line: 992, column: 11, scope: !127, inlinedAt: !128)
!134 = !DILocation(line: 993, column: 43, scope: !127, inlinedAt: !128)
!135 = !DILocation(line: 993, column: 10, scope: !127, inlinedAt: !128)
!136 = !DILocation(line: 1020, column: 14, scope: !122, inlinedAt: !123)
!137 = !DILocation(line: 144, column: 30, scope: !40)
!138 = !DILocation(line: 1018, column: 9, scope: !122, inlinedAt: !139)
!139 = distinct !DILocation(line: 145, column: 32, scope: !40)
!140 = !DILocation(line: 171, column: 37, scope: !125, inlinedAt: !141)
!141 = distinct !DILocation(line: 990, column: 14, scope: !127, inlinedAt: !142)
!142 = distinct !DILocation(line: 1019, column: 11, scope: !122, inlinedAt: !139)
!143 = !DILocation(line: 171, column: 10, scope: !125, inlinedAt: !141)
!144 = !DILocation(line: 991, column: 20, scope: !127, inlinedAt: !142)
!145 = !DILocation(line: 992, column: 36, scope: !127, inlinedAt: !142)
!146 = !DILocation(line: 992, column: 17, scope: !127, inlinedAt: !142)
!147 = !DILocation(line: 992, column: 11, scope: !127, inlinedAt: !142)
!148 = !DILocation(line: 993, column: 43, scope: !127, inlinedAt: !142)
!149 = !DILocation(line: 993, column: 10, scope: !127, inlinedAt: !142)
!150 = !DILocation(line: 1020, column: 14, scope: !122, inlinedAt: !139)
!151 = !DILocation(line: 145, column: 30, scope: !40)
!152 = !DILocation(line: 147, column: 32, scope: !40)
!153 = !DILocation(line: 147, column: 7, scope: !40)
!154 = !DILocation(line: 155, column: 30, scope: !40)
!155 = !DILocation(line: 75, column: 10, scope: !156, inlinedAt: !158)
!156 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !157, file: !157, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!157 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!158 = distinct !DILocation(line: 984, column: 9, scope: !159, inlinedAt: !161)
!159 = distinct !DISubprogram(name: "__float2half", scope: !160, file: !160, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!160 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!161 = distinct !DILocation(line: 133, column: 53, scope: !162, inlinedAt: !163)
!162 = distinct !DISubprogram(name: "__half", scope: !160, file: !160, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!163 = distinct !DILocation(line: 161, column: 53, scope: !40)
!164 = !DILocation(line: 161, column: 50, scope: !40)
!165 = !DILocation(line: 60, column: 3, scope: !77, inlinedAt: !166)
!166 = distinct !DILocation(line: 74, column: 3, scope: !80, inlinedAt: !167)
!167 = distinct !DILocation(line: 164, column: 3, scope: !40)
!168 = !DILocation(line: 61, column: 3, scope: !77, inlinedAt: !166)
!169 = !DILocation(line: 62, column: 3, scope: !77, inlinedAt: !166)
!170 = !DILocation(line: 168, column: 121, scope: !40)
!171 = !DILocation(line: 168, column: 31, scope: !40)
!172 = !DILocation(line: 168, column: 29, scope: !40)
!173 = !{!26, !26, i64 0}
!174 = !DILocation(line: 173, column: 38, scope: !40)
!175 = !DILocation(line: 168, column: 95, scope: !40)
!176 = !DILocation(line: 168, column: 107, scope: !40)
!177 = !DILocation(line: 183, column: 61, scope: !40)
!178 = !DILocation(line: 75, column: 10, scope: !156, inlinedAt: !179)
!179 = distinct !DILocation(line: 984, column: 9, scope: !159, inlinedAt: !180)
!180 = distinct !DILocation(line: 133, column: 53, scope: !162, inlinedAt: !181)
!181 = distinct !DILocation(line: 183, column: 53, scope: !40)
!182 = !DILocation(line: 183, column: 50, scope: !40)
!183 = !DILocation(line: 187, column: 3, scope: !40)
!184 = !DILocation(line: 188, column: 22, scope: !40)
!185 = !DILocation(line: 188, column: 171, scope: !40)
!186 = !DILocation(line: 190, column: 1, scope: !40)
