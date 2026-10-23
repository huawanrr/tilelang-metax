; ModuleID = 'experiments/20261017_resume/s8_tags_binary/oj12_m2_p1.bc'
source_filename = "/tmp/tmprm_m1elu/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %EncodedIndices.coerce, ptr addrspace(4) noalias noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !42, !range !29
  %mul = shl nsw i32 %0, 10, !dbg !46
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !dbg !47, !range !29
  %add = add nuw nsw i32 %mul, %1, !dbg !50
  %idxprom = zext nneg i32 %add to i64, !dbg !51
  %arrayidx = getelementptr inbounds i64, ptr addrspace(1) %EncodedIndices.coerce, i64 %idxprom, !dbg !51
  %2 = load i64, ptr addrspace(1) %arrayidx, align 8, !dbg !51, !tbaa !17
  %3 = trunc i64 %2 to i32, !dbg !52
  %conv8 = and i32 %3, 255, !dbg !52
  %and13 = shl i32 %3, 4, !dbg !53
  %mul14 = and i32 %and13, 1008, !dbg !53
  %shr.1 = lshr i64 %2, 8, !dbg !54
  %4 = trunc i64 %shr.1 to i32, !dbg !52
  %conv8.1 = and i32 %4, 255, !dbg !52
  %and13.1 = shl i32 %4, 4, !dbg !53
  %mul14.1 = and i32 %and13.1, 1008, !dbg !53
  %shr.2 = lshr i64 %2, 16, !dbg !54
  %5 = trunc i64 %shr.2 to i32, !dbg !52
  %conv8.2 = and i32 %5, 255, !dbg !52
  %and13.2 = shl i32 %5, 4, !dbg !53
  %mul14.2 = and i32 %and13.2, 1008, !dbg !53
  %shr.3 = lshr i64 %2, 24, !dbg !54
  %6 = trunc i64 %shr.3 to i32, !dbg !52
  %conv8.3 = and i32 %6, 255, !dbg !52
  %and13.3 = shl i32 %6, 4, !dbg !53
  %mul14.3 = and i32 %and13.3, 1008, !dbg !53
  %shr.4 = lshr i64 %2, 32, !dbg !54
  %7 = trunc nuw i64 %shr.4 to i32, !dbg !52
  %conv8.4 = and i32 %7, 255, !dbg !52
  %and13.4 = shl i32 %7, 4, !dbg !53
  %mul14.4 = and i32 %and13.4, 1008, !dbg !53
  %shr.5 = lshr i64 %2, 40, !dbg !54
  %8 = trunc nuw nsw i64 %shr.5 to i32, !dbg !52
  %conv8.5 = and i32 %8, 255, !dbg !52
  %and13.5 = shl nuw nsw i32 %8, 4, !dbg !53
  %mul14.5 = and i32 %and13.5, 1008, !dbg !53
  %shr.6 = lshr i64 %2, 48, !dbg !54
  %9 = trunc nuw nsw i64 %shr.6 to i32, !dbg !52
  %conv8.6 = and i32 %9, 255, !dbg !52
  %and13.6 = shl nuw nsw i32 %9, 4, !dbg !53
  %mul14.6 = and i32 %and13.6, 1008, !dbg !53
  %shr.7 = lshr i64 %2, 56, !dbg !54
  %10 = trunc nuw nsw i64 %shr.7 to i32, !dbg !52
  %and13.7 = shl nuw nsw i32 %10, 4, !dbg !53
  %mul14.7 = and i32 %and13.7, 1008, !dbg !53
  %mul23 = shl nsw i32 %0, 20
  %mul25 = shl nsw i32 %1, 10
  %add26 = add nuw nsw i32 %mul23, %mul25
  %11 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %and28 = shl nuw nsw i32 %11, 6
  %mul29 = and i32 %and28, 960
  %add30 = or disjoint i32 %add26, %mul29
  %12 = lshr i32 %11, 1
  %mul35 = and i32 %12, 504
  %add32 = add nuw nsw i32 %add30, %mul35
  %13 = zext nneg i32 %add32 to i64, !dbg !56
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %13, !dbg !57
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !58
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !58
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8, !dbg !58
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %13, !dbg !57
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 64, !dbg !57
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !58
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %14, i64 72, !dbg !58
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8, !dbg !58
  %conv107 = zext nneg i32 %0 to i64
  %15 = shl nuw nsw i32 %11, 3
  %mul118 = zext nneg i32 %15 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul118
  %invariant.gep1654 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul118
  %16 = lshr i32 %11, 2
  %mul403 = and i32 %16, 252
  %cmp98.not = icmp eq i32 %conv8, 0, !dbg !59
  br i1 %cmp98.not, label %if.end148, label %for.cond99.preheader, !dbg !60

for.cond99.preheader:                             ; preds = %entry
  %17 = lshr exact i32 %mul14, 4
  %shr110 = zext nneg i32 %17 to i64
  %.idx = shl nuw nsw i64 %shr110, 11, !dbg !61
  %18 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx, !dbg !61
  %.idx1721 = shl nuw nsw i64 %conv107, 17, !dbg !61
  %19 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 %.idx1721, !dbg !61
  %condval.sroa.6.0.add.ptr120.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %19, i64 8, !dbg !62
  %20 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx, align 8, !dbg !62, !tbaa !30
  %21 = load <4 x half>, ptr addrspace(4) %19, align 16, !dbg !62, !tbaa !30
  %.idx.1 = shl nuw nsw i64 %shr110, 11, !dbg !61
  %22 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1, !dbg !61
  %.idx1721.1 = shl nuw nsw i64 %conv107, 17, !dbg !61
  %23 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 %.idx1721.1, !dbg !61
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1024, !dbg !61
  %condval.sroa.6.0.add.ptr120.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1032, !dbg !62
  %24 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx.1, align 8, !dbg !62, !tbaa !30
  %25 = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !62, !tbaa !30
  br label %if.end148, !dbg !63

if.end148:                                        ; preds = %for.cond99.preheader, %entry
  %26 = phi <4 x half> [ undef, %entry ], [ %24, %for.cond99.preheader ]
  %27 = phi <4 x half> [ undef, %entry ], [ %25, %for.cond99.preheader ]
  %28 = phi <4 x half> [ undef, %entry ], [ %20, %for.cond99.preheader ]
  %29 = phi <4 x half> [ undef, %entry ], [ %21, %for.cond99.preheader ]
  %cmp153.not = icmp eq i32 %conv8.1, 0, !dbg !64
  br i1 %cmp153.not, label %if.end209, label %for.cond155.preheader, !dbg !63

for.cond155.preheader:                            ; preds = %if.end148
  %30 = lshr exact i32 %mul14.1, 4
  %shr167 = zext nneg i32 %30 to i64
  %.idx1722 = shl nuw nsw i64 %shr167, 11, !dbg !65
  %31 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722, !dbg !65
  %.idx1723 = shl nuw nsw i64 %conv107, 17, !dbg !65
  %32 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 %.idx1723, !dbg !65
  %condval_1.sroa.6.0.add.ptr177.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %32, i64 8, !dbg !66
  %33 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx, align 8, !dbg !66, !tbaa !30
  %34 = load <4 x half>, ptr addrspace(4) %32, align 16, !dbg !66, !tbaa !30
  %.idx1722.1 = shl nuw nsw i64 %shr167, 11, !dbg !65
  %35 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722.1, !dbg !65
  %.idx1723.1 = shl nuw nsw i64 %conv107, 17, !dbg !65
  %36 = getelementptr inbounds i8, ptr addrspace(4) %35, i64 %.idx1723.1, !dbg !65
  %gep1646.1 = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1024, !dbg !65
  %condval_1.sroa.6.0.add.ptr177.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1032, !dbg !66
  %37 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx.1, align 8, !dbg !66, !tbaa !30
  %38 = load <4 x half>, ptr addrspace(4) %gep1646.1, align 16, !dbg !66, !tbaa !30
  br label %if.end209, !dbg !67

if.end209:                                        ; preds = %for.cond155.preheader, %if.end148
  %39 = phi <4 x half> [ undef, %if.end148 ], [ %37, %for.cond155.preheader ]
  %40 = phi <4 x half> [ undef, %if.end148 ], [ %38, %for.cond155.preheader ]
  %41 = phi <4 x half> [ undef, %if.end148 ], [ %33, %for.cond155.preheader ]
  %42 = phi <4 x half> [ undef, %if.end148 ], [ %34, %for.cond155.preheader ]
  %cmp214.not = icmp eq i32 %conv8.2, 0, !dbg !68
  br i1 %cmp214.not, label %if.end270, label %for.cond216.preheader, !dbg !67

for.cond216.preheader:                            ; preds = %if.end209
  %43 = lshr exact i32 %mul14.2, 4
  %shr228 = zext nneg i32 %43 to i64
  %.idx1724 = shl nuw nsw i64 %shr228, 11, !dbg !69
  %44 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724, !dbg !69
  %.idx1725 = shl nuw nsw i64 %conv107, 17, !dbg !69
  %45 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 %.idx1725, !dbg !69
  %condval_2.sroa.6.0.add.ptr238.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %45, i64 8, !dbg !70
  %46 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx, align 8, !dbg !70, !tbaa !30
  %47 = load <4 x half>, ptr addrspace(4) %45, align 16, !dbg !70, !tbaa !30
  %.idx1724.1 = shl nuw nsw i64 %shr228, 11, !dbg !69
  %48 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724.1, !dbg !69
  %.idx1725.1 = shl nuw nsw i64 %conv107, 17, !dbg !69
  %49 = getelementptr inbounds i8, ptr addrspace(4) %48, i64 %.idx1725.1, !dbg !69
  %gep1649.1 = getelementptr inbounds i8, ptr addrspace(4) %49, i64 1024, !dbg !69
  %condval_2.sroa.6.0.add.ptr238.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %49, i64 1032, !dbg !70
  %50 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx.1, align 8, !dbg !70, !tbaa !30
  %51 = load <4 x half>, ptr addrspace(4) %gep1649.1, align 16, !dbg !70, !tbaa !30
  br label %if.end270, !dbg !71

if.end270:                                        ; preds = %for.cond216.preheader, %if.end209
  %52 = phi <4 x half> [ undef, %if.end209 ], [ %50, %for.cond216.preheader ]
  %53 = phi <4 x half> [ undef, %if.end209 ], [ %51, %for.cond216.preheader ]
  %54 = phi <4 x half> [ undef, %if.end209 ], [ %46, %for.cond216.preheader ]
  %55 = phi <4 x half> [ undef, %if.end209 ], [ %47, %for.cond216.preheader ]
  %cmp275.not = icmp eq i32 %conv8.3, 0, !dbg !72
  br i1 %cmp275.not, label %if.end331, label %for.cond277.preheader, !dbg !71

for.cond277.preheader:                            ; preds = %if.end270
  %56 = lshr exact i32 %mul14.3, 4
  %shr289 = zext nneg i32 %56 to i64
  %.idx1726 = shl nuw nsw i64 %shr289, 11, !dbg !73
  %57 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726, !dbg !73
  %.idx1727 = shl nuw nsw i64 %conv107, 17, !dbg !73
  %58 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 %.idx1727, !dbg !73
  %condval_3.sroa.6.0.add.ptr299.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %58, i64 8, !dbg !74
  %59 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx, align 8, !dbg !74, !tbaa !30
  %60 = load <4 x half>, ptr addrspace(4) %58, align 16, !dbg !74, !tbaa !30
  %.idx1726.1 = shl nuw nsw i64 %shr289, 11, !dbg !73
  %61 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726.1, !dbg !73
  %.idx1727.1 = shl nuw nsw i64 %conv107, 17, !dbg !73
  %62 = getelementptr inbounds i8, ptr addrspace(4) %61, i64 %.idx1727.1, !dbg !73
  %gep1652.1 = getelementptr inbounds i8, ptr addrspace(4) %62, i64 1024, !dbg !73
  %condval_3.sroa.6.0.add.ptr299.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %62, i64 1032, !dbg !74
  %63 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx.1, align 8, !dbg !74, !tbaa !30
  %64 = load <4 x half>, ptr addrspace(4) %gep1652.1, align 16, !dbg !74, !tbaa !30
  br label %if.end331, !dbg !75

if.end331:                                        ; preds = %for.cond277.preheader, %if.end270
  %65 = phi <4 x half> [ undef, %if.end270 ], [ %63, %for.cond277.preheader ]
  %66 = phi <4 x half> [ undef, %if.end270 ], [ %64, %for.cond277.preheader ]
  %67 = phi <4 x half> [ undef, %if.end270 ], [ %59, %for.cond277.preheader ]
  %68 = phi <4 x half> [ undef, %if.end270 ], [ %60, %for.cond277.preheader ]
  br i1 %cmp98.not, label %if.end508, label %for.cond337.preheader, !dbg !75

for.cond337.preheader:                            ; preds = %if.end331
  %69 = lshr exact i32 %mul14, 4
  %shr349 = zext nneg i32 %69 to i64
  %.idx1728 = shl nuw nsw i64 %shr349, 11, !dbg !76
  %70 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728, !dbg !76
  %.idx1729 = shl nuw nsw i64 %conv107, 17, !dbg !76
  %71 = getelementptr inbounds i8, ptr addrspace(4) %70, i64 %.idx1729, !dbg !76
  %condval_4.sroa.6.0.add.ptr359.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %71, i64 8, !dbg !77
  %72 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx, align 8, !dbg !77, !tbaa !30
  %73 = load <4 x half>, ptr addrspace(4) %71, align 16, !dbg !77, !tbaa !30
  %.idx1728.1 = shl nuw nsw i64 %shr349, 11, !dbg !76
  %74 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728.1, !dbg !76
  %.idx1729.1 = shl nuw nsw i64 %conv107, 17, !dbg !76
  %75 = getelementptr inbounds i8, ptr addrspace(4) %74, i64 %.idx1729.1, !dbg !76
  %gep1655.1 = getelementptr inbounds i8, ptr addrspace(4) %75, i64 1024, !dbg !76
  %condval_4.sroa.6.0.add.ptr359.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %75, i64 1032, !dbg !77
  %76 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx.1, align 8, !dbg !77, !tbaa !30
  %77 = load <4 x half>, ptr addrspace(4) %gep1655.1, align 16, !dbg !77, !tbaa !30
  %and394 = and i32 %3, 64, !dbg !78
  %cmp395.not = icmp eq i32 %and394, 0, !dbg !79
  br i1 %cmp395.not, label %if.end421, label %for.cond397.preheader, !dbg !80

for.cond397.preheader:                            ; preds = %for.cond337.preheader
  %add404 = add nuw nsw i32 %mul14, %mul403
  %cmp407.not = icmp ugt i32 %add404, %1, !dbg !81
  %fneg. = select i1 %cmp407.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2037 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !82
  %cmp407.not.1.not = icmp ult i32 %add404, %1, !dbg !81
  %fneg..1 = select i1 %cmp407.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2138 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2037, float %fneg..1, i64 1, !dbg !82
  %add405.2 = or disjoint i32 %add404, 2, !dbg !83
  %cmp407.not.2 = icmp ugt i32 %add405.2, %1, !dbg !81
  %fneg..2 = select i1 %cmp407.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2231 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2138, float %fneg..2, i64 2, !dbg !82
  %add405.3 = or disjoint i32 %add404, 3, !dbg !83
  %cmp407.not.3 = icmp ugt i32 %add405.3, %1, !dbg !81
  %fneg..3 = select i1 %cmp407.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2324 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2231, float %fneg..3, i64 3, !dbg !82
  br label %if.end421

if.end421:                                        ; preds = %for.cond337.preheader, %for.cond397.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2324, %for.cond397.preheader ], [ zeroinitializer, %for.cond337.preheader ], !dbg !84
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !85, !call_argsrelate !86
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %78), !dbg !85, !call_argsrelate !86
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %79), !dbg !85, !call_argsrelate !86
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %80), !dbg !85, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %81, i64 0, !dbg !87
  %mul456 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !88
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul456, float 0x4024CB5EC0000000), !dbg !89
  %83 = tail call contract noundef float @llvm.exp.f32(float %82), !dbg !93
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %81, i64 1, !dbg !87
  %mul456.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !88
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul456.1, float 0x4024CB5EC0000000), !dbg !89
  %85 = tail call contract noundef float @llvm.exp.f32(float %84), !dbg !93
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %81, i64 2, !dbg !87
  %mul456.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !88
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul456.2, float 0x4024CB5EC0000000), !dbg !89
  %87 = tail call contract noundef float @llvm.exp.f32(float %86), !dbg !93
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %81, i64 3, !dbg !87
  %mul456.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !88
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul456.3, float 0x4024CB5EC0000000), !dbg !89
  %89 = tail call contract noundef float @llvm.exp.f32(float %88), !dbg !93
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83), !dbg !96
  %91 = insertelement <4 x i16> poison, i16 %90, i64 0, !dbg !105
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %85), !dbg !96
  %93 = insertelement <4 x i16> %91, i16 %92, i64 1, !dbg !105
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %87), !dbg !96
  %95 = insertelement <4 x i16> %93, i16 %94, i64 2, !dbg !105
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %89), !dbg !96
  %97 = insertelement <4 x i16> %95, i16 %96, i64 3, !dbg !105
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %97 to <4 x half>, !dbg !105
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  br label %if.end508, !dbg !108

if.end508:                                        ; preds = %if.end421, %if.end331
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %101, %if.end421 ], !dbg !84
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %100, %if.end421 ], !dbg !84
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %99, %if.end421 ], !dbg !84
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %98, %if.end421 ], !dbg !84
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end331 ], [ %89, %if.end421 ], !dbg !84
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end331 ], [ %87, %if.end421 ], !dbg !84
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end331 ], [ %85, %if.end421 ], !dbg !84
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end331 ], [ %83, %if.end421 ], !dbg !84
  br i1 %cmp153.not, label %if.end687, label %for.cond515.preheader, !dbg !108

for.cond515.preheader:                            ; preds = %if.end508
  %102 = lshr exact i32 %mul14.1, 4
  %shr527 = zext nneg i32 %102 to i64
  %.idx1730 = shl nuw nsw i64 %shr527, 11, !dbg !109
  %103 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730, !dbg !109
  %.idx1731 = shl nuw nsw i64 %conv107, 17, !dbg !109
  %104 = getelementptr inbounds i8, ptr addrspace(4) %103, i64 %.idx1731, !dbg !109
  %condval_6.sroa.6.0.add.ptr537.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 8, !dbg !110
  %105 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx, align 8, !dbg !110, !tbaa !30
  %106 = load <4 x half>, ptr addrspace(4) %104, align 16, !dbg !110, !tbaa !30
  %.idx1730.1 = shl nuw nsw i64 %shr527, 11, !dbg !109
  %107 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730.1, !dbg !109
  %.idx1731.1 = shl nuw nsw i64 %conv107, 17, !dbg !109
  %108 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 %.idx1731.1, !dbg !109
  %gep1668.1 = getelementptr inbounds i8, ptr addrspace(4) %108, i64 1024, !dbg !109
  %condval_6.sroa.6.0.add.ptr537.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %108, i64 1032, !dbg !110
  %109 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx.1, align 8, !dbg !110, !tbaa !30
  %110 = load <4 x half>, ptr addrspace(4) %gep1668.1, align 16, !dbg !110, !tbaa !30
  %and573 = and i32 %4, 64, !dbg !111
  %cmp574.not = icmp eq i32 %and573, 0, !dbg !112
  br i1 %cmp574.not, label %if.end600, label %for.cond576.preheader, !dbg !113

for.cond576.preheader:                            ; preds = %for.cond515.preheader
  %add583 = add nuw nsw i32 %mul14.1, %mul403
  %cmp586.not = icmp ugt i32 %add583, %1, !dbg !114
  %fneg.1447 = select i1 %cmp586.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2046 = insertelement <4 x float> poison, float %fneg.1447, i64 0, !dbg !115
  %cmp586.not.1.not = icmp ult i32 %add583, %1, !dbg !114
  %fneg.1447.1 = select i1 %cmp586.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2147 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2046, float %fneg.1447.1, i64 1, !dbg !115
  %add584.2 = or disjoint i32 %add583, 2, !dbg !116
  %cmp586.not.2 = icmp ugt i32 %add584.2, %1, !dbg !114
  %fneg.1447.2 = select i1 %cmp586.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2240 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2147, float %fneg.1447.2, i64 2, !dbg !115
  %add584.3 = or disjoint i32 %add583, 3, !dbg !116
  %cmp586.not.3 = icmp ugt i32 %add584.3, %1, !dbg !114
  %fneg.1447.3 = select i1 %cmp586.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2333 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2240, float %fneg.1447.3, i64 3, !dbg !115
  br label %if.end600

if.end600:                                        ; preds = %for.cond515.preheader, %for.cond576.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2333, %for.cond576.preheader ], [ zeroinitializer, %for.cond515.preheader ], !dbg !84
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !117, !call_argsrelate !86
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %41, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %111), !dbg !117, !call_argsrelate !86
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %40, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %112), !dbg !117, !call_argsrelate !86
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %39, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %113), !dbg !117, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2048 = extractelement <4 x float> %114, i64 0, !dbg !118
  %mul635 = fmul contract float %acc_s.sroa.0.0.vec.extract2048, 0x3FB99999A0000000, !dbg !119
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul635, float 0x4024CB5EC0000000), !dbg !120
  %116 = tail call contract noundef float @llvm.exp.f32(float %115), !dbg !122
  %acc_s.sroa.0.4.vec.extract2149 = extractelement <4 x float> %114, i64 1, !dbg !118
  %mul635.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2149, 0x3FB99999A0000000, !dbg !119
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul635.1, float 0x4024CB5EC0000000), !dbg !120
  %118 = tail call contract noundef float @llvm.exp.f32(float %117), !dbg !122
  %acc_s.sroa.0.8.vec.extract2242 = extractelement <4 x float> %114, i64 2, !dbg !118
  %mul635.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2242, 0x3FB99999A0000000, !dbg !119
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul635.2, float 0x4024CB5EC0000000), !dbg !120
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !122
  %acc_s.sroa.0.12.vec.extract2335 = extractelement <4 x float> %114, i64 3, !dbg !118
  %mul635.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2335, 0x3FB99999A0000000, !dbg !119
  %121 = tail call contract noundef float @llvm.minnum.f32(float %mul635.3, float 0x4024CB5EC0000000), !dbg !120
  %122 = tail call contract noundef float @llvm.exp.f32(float %121), !dbg !122
  %add651 = fadd contract float %sum_acc.sroa.0.0, %116, !dbg !124
  %add651.1 = fadd contract float %sum_acc.sroa.20.0, %118, !dbg !124
  %add651.2 = fadd contract float %sum_acc.sroa.38.0, %120, !dbg !124
  %add651.3 = fadd contract float %sum_acc.sroa.56.0, %122, !dbg !124
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116), !dbg !125
  %124 = insertelement <4 x i16> poison, i16 %123, i64 0, !dbg !129
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118), !dbg !125
  %126 = insertelement <4 x i16> %124, i16 %125, i64 1, !dbg !129
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !125
  %128 = insertelement <4 x i16> %126, i16 %127, i64 2, !dbg !129
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %122), !dbg !125
  %130 = insertelement <4 x i16> %128, i16 %129, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert2009 = bitcast <4 x i16> %130 to <4 x half>, !dbg !129
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %106, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %105, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %110, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %109, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  br label %if.end687, !dbg !131

if.end687:                                        ; preds = %if.end600, %if.end508
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %134, %if.end600 ], !dbg !84
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %133, %if.end600 ], !dbg !84
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %132, %if.end600 ], !dbg !84
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %131, %if.end600 ], !dbg !84
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end508 ], [ %add651.3, %if.end600 ], !dbg !84
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end508 ], [ %add651.2, %if.end600 ], !dbg !84
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end508 ], [ %add651.1, %if.end600 ], !dbg !84
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end508 ], [ %add651, %if.end600 ], !dbg !84
  br i1 %cmp214.not, label %if.end866, label %for.cond694.preheader, !dbg !131

for.cond694.preheader:                            ; preds = %if.end687
  %135 = lshr exact i32 %mul14.2, 4
  %shr706 = zext nneg i32 %135 to i64
  %.idx1732 = shl nuw nsw i64 %shr706, 11, !dbg !132
  %136 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732, !dbg !132
  %.idx1733 = shl nuw nsw i64 %conv107, 17, !dbg !132
  %137 = getelementptr inbounds i8, ptr addrspace(4) %136, i64 %.idx1733, !dbg !132
  %condval_8.sroa.6.0.add.ptr716.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 8, !dbg !133
  %138 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx, align 8, !dbg !133, !tbaa !30
  %139 = load <4 x half>, ptr addrspace(4) %137, align 16, !dbg !133, !tbaa !30
  %.idx1732.1 = shl nuw nsw i64 %shr706, 11, !dbg !132
  %140 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732.1, !dbg !132
  %.idx1733.1 = shl nuw nsw i64 %conv107, 17, !dbg !132
  %141 = getelementptr inbounds i8, ptr addrspace(4) %140, i64 %.idx1733.1, !dbg !132
  %gep1682.1 = getelementptr inbounds i8, ptr addrspace(4) %141, i64 1024, !dbg !132
  %condval_8.sroa.6.0.add.ptr716.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %141, i64 1032, !dbg !133
  %142 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx.1, align 8, !dbg !133, !tbaa !30
  %143 = load <4 x half>, ptr addrspace(4) %gep1682.1, align 16, !dbg !133, !tbaa !30
  %and752 = and i32 %5, 64, !dbg !134
  %cmp753.not = icmp eq i32 %and752, 0, !dbg !135
  br i1 %cmp753.not, label %if.end779, label %for.cond755.preheader, !dbg !136

for.cond755.preheader:                            ; preds = %for.cond694.preheader
  %add762 = add nuw nsw i32 %mul14.2, %mul403
  %cmp765.not = icmp ugt i32 %add762, %1, !dbg !137
  %fneg.1448 = select i1 %cmp765.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2056 = insertelement <4 x float> poison, float %fneg.1448, i64 0, !dbg !138
  %cmp765.not.1.not = icmp ult i32 %add762, %1, !dbg !137
  %fneg.1448.1 = select i1 %cmp765.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2157 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2056, float %fneg.1448.1, i64 1, !dbg !138
  %add763.2 = or disjoint i32 %add762, 2, !dbg !139
  %cmp765.not.2 = icmp ugt i32 %add763.2, %1, !dbg !137
  %fneg.1448.2 = select i1 %cmp765.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2250 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2157, float %fneg.1448.2, i64 2, !dbg !138
  %add763.3 = or disjoint i32 %add762, 3, !dbg !139
  %cmp765.not.3 = icmp ugt i32 %add763.3, %1, !dbg !137
  %fneg.1448.3 = select i1 %cmp765.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2343 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2250, float %fneg.1448.3, i64 3, !dbg !138
  br label %if.end779

if.end779:                                        ; preds = %for.cond694.preheader, %for.cond755.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2343, %for.cond755.preheader ], [ zeroinitializer, %for.cond694.preheader ], !dbg !84
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !140, !call_argsrelate !86
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %144), !dbg !140, !call_argsrelate !86
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %53, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %145), !dbg !140, !call_argsrelate !86
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %52, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %146), !dbg !140, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2058 = extractelement <4 x float> %147, i64 0, !dbg !141
  %mul814 = fmul contract float %acc_s.sroa.0.0.vec.extract2058, 0x3FB99999A0000000, !dbg !142
  %148 = tail call contract noundef float @llvm.minnum.f32(float %mul814, float 0x4024CB5EC0000000), !dbg !143
  %149 = tail call contract noundef float @llvm.exp.f32(float %148), !dbg !145
  %acc_s.sroa.0.4.vec.extract2159 = extractelement <4 x float> %147, i64 1, !dbg !141
  %mul814.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2159, 0x3FB99999A0000000, !dbg !142
  %150 = tail call contract noundef float @llvm.minnum.f32(float %mul814.1, float 0x4024CB5EC0000000), !dbg !143
  %151 = tail call contract noundef float @llvm.exp.f32(float %150), !dbg !145
  %acc_s.sroa.0.8.vec.extract2252 = extractelement <4 x float> %147, i64 2, !dbg !141
  %mul814.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2252, 0x3FB99999A0000000, !dbg !142
  %152 = tail call contract noundef float @llvm.minnum.f32(float %mul814.2, float 0x4024CB5EC0000000), !dbg !143
  %153 = tail call contract noundef float @llvm.exp.f32(float %152), !dbg !145
  %acc_s.sroa.0.12.vec.extract2345 = extractelement <4 x float> %147, i64 3, !dbg !141
  %mul814.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2345, 0x3FB99999A0000000, !dbg !142
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul814.3, float 0x4024CB5EC0000000), !dbg !143
  %155 = tail call contract noundef float @llvm.exp.f32(float %154), !dbg !145
  %add830 = fadd contract float %sum_acc.sroa.0.1, %149, !dbg !147
  %add830.1 = fadd contract float %sum_acc.sroa.20.1, %151, !dbg !147
  %add830.2 = fadd contract float %sum_acc.sroa.38.1, %153, !dbg !147
  %add830.3 = fadd contract float %sum_acc.sroa.56.1, %155, !dbg !147
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %149), !dbg !148
  %157 = insertelement <4 x i16> poison, i16 %156, i64 0, !dbg !152
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %151), !dbg !148
  %159 = insertelement <4 x i16> %157, i16 %158, i64 1, !dbg !152
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %153), !dbg !148
  %161 = insertelement <4 x i16> %159, i16 %160, i64 2, !dbg !152
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155), !dbg !148
  %163 = insertelement <4 x i16> %161, i16 %162, i64 3, !dbg !152
  %acc_s_cast.sroa.0.6.vec.insert2011 = bitcast <4 x i16> %163 to <4 x half>, !dbg !152
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %139, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.0.0), !dbg !153, !call_argsrelate !107
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %138, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.34.0), !dbg !153, !call_argsrelate !107
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %143, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.66.0), !dbg !153, !call_argsrelate !107
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %142, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.98.0), !dbg !153, !call_argsrelate !107
  br label %if.end866, !dbg !154

if.end866:                                        ; preds = %if.end779, %if.end687
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end687 ], [ %167, %if.end779 ], !dbg !84
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end687 ], [ %166, %if.end779 ], !dbg !84
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end687 ], [ %165, %if.end779 ], !dbg !84
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end687 ], [ %164, %if.end779 ], !dbg !84
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end687 ], [ %add830.3, %if.end779 ], !dbg !84
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end687 ], [ %add830.2, %if.end779 ], !dbg !84
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end687 ], [ %add830.1, %if.end779 ], !dbg !84
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end687 ], [ %add830, %if.end779 ], !dbg !84
  br i1 %cmp275.not, label %if.end1045, label %for.cond873.preheader, !dbg !154

for.cond873.preheader:                            ; preds = %if.end866
  %168 = lshr exact i32 %mul14.3, 4
  %shr885 = zext nneg i32 %168 to i64
  %.idx1734 = shl nuw nsw i64 %shr885, 11, !dbg !155
  %169 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734, !dbg !155
  %.idx1735 = shl nuw nsw i64 %conv107, 17, !dbg !155
  %170 = getelementptr inbounds i8, ptr addrspace(4) %169, i64 %.idx1735, !dbg !155
  %condval_10.sroa.6.0.add.ptr895.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %170, i64 8, !dbg !156
  %171 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx, align 8, !dbg !156, !tbaa !30
  %172 = load <4 x half>, ptr addrspace(4) %170, align 16, !dbg !156, !tbaa !30
  %.idx1734.1 = shl nuw nsw i64 %shr885, 11, !dbg !155
  %173 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734.1, !dbg !155
  %.idx1735.1 = shl nuw nsw i64 %conv107, 17, !dbg !155
  %174 = getelementptr inbounds i8, ptr addrspace(4) %173, i64 %.idx1735.1, !dbg !155
  %gep1696.1 = getelementptr inbounds i8, ptr addrspace(4) %174, i64 1024, !dbg !155
  %condval_10.sroa.6.0.add.ptr895.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %174, i64 1032, !dbg !156
  %175 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx.1, align 8, !dbg !156, !tbaa !30
  %176 = load <4 x half>, ptr addrspace(4) %gep1696.1, align 16, !dbg !156, !tbaa !30
  %and931 = and i32 %6, 64, !dbg !157
  %cmp932.not = icmp eq i32 %and931, 0, !dbg !158
  br i1 %cmp932.not, label %if.end958, label %for.cond934.preheader, !dbg !159

for.cond934.preheader:                            ; preds = %for.cond873.preheader
  %add941 = add nuw nsw i32 %mul14.3, %mul403
  %cmp944.not = icmp ugt i32 %add941, %1, !dbg !160
  %fneg.1449 = select i1 %cmp944.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2066 = insertelement <4 x float> poison, float %fneg.1449, i64 0, !dbg !161
  %cmp944.not.1.not = icmp ult i32 %add941, %1, !dbg !160
  %fneg.1449.1 = select i1 %cmp944.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2167 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2066, float %fneg.1449.1, i64 1, !dbg !161
  %add942.2 = or disjoint i32 %add941, 2, !dbg !162
  %cmp944.not.2 = icmp ugt i32 %add942.2, %1, !dbg !160
  %fneg.1449.2 = select i1 %cmp944.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2260 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2167, float %fneg.1449.2, i64 2, !dbg !161
  %add942.3 = or disjoint i32 %add941, 3, !dbg !162
  %cmp944.not.3 = icmp ugt i32 %add942.3, %1, !dbg !160
  %fneg.1449.3 = select i1 %cmp944.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2353 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2260, float %fneg.1449.3, i64 3, !dbg !161
  br label %if.end958

if.end958:                                        ; preds = %for.cond873.preheader, %for.cond934.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2353, %for.cond934.preheader ], [ zeroinitializer, %for.cond873.preheader ], !dbg !84
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !163, !call_argsrelate !86
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %177), !dbg !163, !call_argsrelate !86
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %178), !dbg !163, !call_argsrelate !86
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %65, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %179), !dbg !163, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2068 = extractelement <4 x float> %180, i64 0, !dbg !164
  %mul993 = fmul contract float %acc_s.sroa.0.0.vec.extract2068, 0x3FB99999A0000000, !dbg !165
  %181 = tail call contract noundef float @llvm.minnum.f32(float %mul993, float 0x4024CB5EC0000000), !dbg !166
  %182 = tail call contract noundef float @llvm.exp.f32(float %181), !dbg !168
  %acc_s.sroa.0.4.vec.extract2169 = extractelement <4 x float> %180, i64 1, !dbg !164
  %mul993.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2169, 0x3FB99999A0000000, !dbg !165
  %183 = tail call contract noundef float @llvm.minnum.f32(float %mul993.1, float 0x4024CB5EC0000000), !dbg !166
  %184 = tail call contract noundef float @llvm.exp.f32(float %183), !dbg !168
  %acc_s.sroa.0.8.vec.extract2262 = extractelement <4 x float> %180, i64 2, !dbg !164
  %mul993.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2262, 0x3FB99999A0000000, !dbg !165
  %185 = tail call contract noundef float @llvm.minnum.f32(float %mul993.2, float 0x4024CB5EC0000000), !dbg !166
  %186 = tail call contract noundef float @llvm.exp.f32(float %185), !dbg !168
  %acc_s.sroa.0.12.vec.extract2355 = extractelement <4 x float> %180, i64 3, !dbg !164
  %mul993.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2355, 0x3FB99999A0000000, !dbg !165
  %187 = tail call contract noundef float @llvm.minnum.f32(float %mul993.3, float 0x4024CB5EC0000000), !dbg !166
  %188 = tail call contract noundef float @llvm.exp.f32(float %187), !dbg !168
  %add1009 = fadd contract float %sum_acc.sroa.0.2, %182, !dbg !170
  %add1009.1 = fadd contract float %sum_acc.sroa.20.2, %184, !dbg !170
  %add1009.2 = fadd contract float %sum_acc.sroa.38.2, %186, !dbg !170
  %add1009.3 = fadd contract float %sum_acc.sroa.56.2, %188, !dbg !170
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %182), !dbg !171
  %190 = insertelement <4 x i16> poison, i16 %189, i64 0, !dbg !175
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %184), !dbg !171
  %192 = insertelement <4 x i16> %190, i16 %191, i64 1, !dbg !175
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %186), !dbg !171
  %194 = insertelement <4 x i16> %192, i16 %193, i64 2, !dbg !175
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %188), !dbg !171
  %196 = insertelement <4 x i16> %194, i16 %195, i64 3, !dbg !175
  %acc_s_cast.sroa.0.6.vec.insert2013 = bitcast <4 x i16> %196 to <4 x half>, !dbg !175
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %172, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.0.0), !dbg !176, !call_argsrelate !107
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %171, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.18.0), !dbg !176, !call_argsrelate !107
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %176, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.34.0), !dbg !176, !call_argsrelate !107
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %175, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.50.0), !dbg !176, !call_argsrelate !107
  br label %if.end1045, !dbg !177

if.end1045:                                       ; preds = %if.end958, %if.end866
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end866 ], [ %200, %if.end958 ], !dbg !84
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end866 ], [ %199, %if.end958 ], !dbg !84
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end866 ], [ %198, %if.end958 ], !dbg !84
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end866 ], [ %197, %if.end958 ], !dbg !84
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end866 ], [ %add1009.3, %if.end958 ], !dbg !84
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end866 ], [ %add1009.2, %if.end958 ], !dbg !84
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end866 ], [ %add1009.1, %if.end958 ], !dbg !84
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end866 ], [ %add1009, %if.end958 ], !dbg !84
  %cmp98.not.1 = icmp eq i32 %conv8.4, 0, !dbg !59
  br i1 %cmp98.not.1, label %if.end148.1, label %for.cond99.preheader.1, !dbg !60

for.cond99.preheader.1:                           ; preds = %if.end1045
  %201 = lshr exact i32 %mul14.4, 4
  %shr110.1 = zext nneg i32 %201 to i64
  %.idx.11770 = shl nuw nsw i64 %shr110.1, 11, !dbg !61
  %202 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.11770, !dbg !61
  %.idx1721.11771 = shl nuw nsw i64 %conv107, 17, !dbg !61
  %203 = getelementptr inbounds i8, ptr addrspace(4) %202, i64 %.idx1721.11771, !dbg !61
  %condval.sroa.6.0.add.ptr120.sroa_idx.11775 = getelementptr inbounds i8, ptr addrspace(4) %203, i64 8, !dbg !62
  %204 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx.11775, align 8, !dbg !62, !tbaa !30
  %205 = load <4 x half>, ptr addrspace(4) %203, align 16, !dbg !62, !tbaa !30
  %.idx.1.1 = shl nuw nsw i64 %shr110.1, 11, !dbg !61
  %206 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1.1, !dbg !61
  %.idx1721.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !61
  %207 = getelementptr inbounds i8, ptr addrspace(4) %206, i64 %.idx1721.1.1, !dbg !61
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %207, i64 1024, !dbg !61
  %condval.sroa.6.0.add.ptr120.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %207, i64 1032, !dbg !62
  %208 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx.1.1, align 8, !dbg !62, !tbaa !30
  %209 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16, !dbg !62, !tbaa !30
  br label %if.end148.1, !dbg !63

if.end148.1:                                      ; preds = %for.cond99.preheader.1, %if.end1045
  %210 = phi <4 x half> [ %26, %if.end1045 ], [ %208, %for.cond99.preheader.1 ]
  %211 = phi <4 x half> [ %27, %if.end1045 ], [ %209, %for.cond99.preheader.1 ]
  %212 = phi <4 x half> [ %28, %if.end1045 ], [ %204, %for.cond99.preheader.1 ]
  %213 = phi <4 x half> [ %29, %if.end1045 ], [ %205, %for.cond99.preheader.1 ]
  %cmp153.not.1 = icmp eq i32 %conv8.5, 0, !dbg !64
  br i1 %cmp153.not.1, label %if.end209.1, label %for.cond155.preheader.1, !dbg !63

for.cond155.preheader.1:                          ; preds = %if.end148.1
  %214 = lshr exact i32 %mul14.5, 4
  %shr167.1 = zext nneg i32 %214 to i64
  %.idx1722.11789 = shl nuw nsw i64 %shr167.1, 11, !dbg !65
  %215 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722.11789, !dbg !65
  %.idx1723.11790 = shl nuw nsw i64 %conv107, 17, !dbg !65
  %216 = getelementptr inbounds i8, ptr addrspace(4) %215, i64 %.idx1723.11790, !dbg !65
  %condval_1.sroa.6.0.add.ptr177.sroa_idx.11794 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 8, !dbg !66
  %217 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx.11794, align 8, !dbg !66, !tbaa !30
  %218 = load <4 x half>, ptr addrspace(4) %216, align 16, !dbg !66, !tbaa !30
  %.idx1722.1.1 = shl nuw nsw i64 %shr167.1, 11, !dbg !65
  %219 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722.1.1, !dbg !65
  %.idx1723.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !65
  %220 = getelementptr inbounds i8, ptr addrspace(4) %219, i64 %.idx1723.1.1, !dbg !65
  %gep1646.1.1 = getelementptr inbounds i8, ptr addrspace(4) %220, i64 1024, !dbg !65
  %condval_1.sroa.6.0.add.ptr177.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %220, i64 1032, !dbg !66
  %221 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx.1.1, align 8, !dbg !66, !tbaa !30
  %222 = load <4 x half>, ptr addrspace(4) %gep1646.1.1, align 16, !dbg !66, !tbaa !30
  br label %if.end209.1, !dbg !67

if.end209.1:                                      ; preds = %for.cond155.preheader.1, %if.end148.1
  %223 = phi <4 x half> [ %39, %if.end148.1 ], [ %221, %for.cond155.preheader.1 ]
  %224 = phi <4 x half> [ %40, %if.end148.1 ], [ %222, %for.cond155.preheader.1 ]
  %225 = phi <4 x half> [ %41, %if.end148.1 ], [ %217, %for.cond155.preheader.1 ]
  %226 = phi <4 x half> [ %42, %if.end148.1 ], [ %218, %for.cond155.preheader.1 ]
  %cmp214.not.1 = icmp eq i32 %conv8.6, 0, !dbg !68
  br i1 %cmp214.not.1, label %if.end270.1, label %for.cond216.preheader.1, !dbg !67

for.cond216.preheader.1:                          ; preds = %if.end209.1
  %227 = lshr exact i32 %mul14.6, 4
  %shr228.1 = zext nneg i32 %227 to i64
  %.idx1724.11808 = shl nuw nsw i64 %shr228.1, 11, !dbg !69
  %228 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724.11808, !dbg !69
  %.idx1725.11809 = shl nuw nsw i64 %conv107, 17, !dbg !69
  %229 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 %.idx1725.11809, !dbg !69
  %condval_2.sroa.6.0.add.ptr238.sroa_idx.11813 = getelementptr inbounds i8, ptr addrspace(4) %229, i64 8, !dbg !70
  %230 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx.11813, align 8, !dbg !70, !tbaa !30
  %231 = load <4 x half>, ptr addrspace(4) %229, align 16, !dbg !70, !tbaa !30
  %.idx1724.1.1 = shl nuw nsw i64 %shr228.1, 11, !dbg !69
  %232 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724.1.1, !dbg !69
  %.idx1725.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !69
  %233 = getelementptr inbounds i8, ptr addrspace(4) %232, i64 %.idx1725.1.1, !dbg !69
  %gep1649.1.1 = getelementptr inbounds i8, ptr addrspace(4) %233, i64 1024, !dbg !69
  %condval_2.sroa.6.0.add.ptr238.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %233, i64 1032, !dbg !70
  %234 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx.1.1, align 8, !dbg !70, !tbaa !30
  %235 = load <4 x half>, ptr addrspace(4) %gep1649.1.1, align 16, !dbg !70, !tbaa !30
  br label %if.end270.1, !dbg !71

if.end270.1:                                      ; preds = %for.cond216.preheader.1, %if.end209.1
  %236 = phi <4 x half> [ %52, %if.end209.1 ], [ %234, %for.cond216.preheader.1 ]
  %237 = phi <4 x half> [ %53, %if.end209.1 ], [ %235, %for.cond216.preheader.1 ]
  %238 = phi <4 x half> [ %54, %if.end209.1 ], [ %230, %for.cond216.preheader.1 ]
  %239 = phi <4 x half> [ %55, %if.end209.1 ], [ %231, %for.cond216.preheader.1 ]
  %cmp275.not.1 = icmp ult i64 %2, 72057594037927936, !dbg !72
  br i1 %cmp275.not.1, label %if.end331.1, label %for.cond277.preheader.1, !dbg !71

for.cond277.preheader.1:                          ; preds = %if.end270.1
  %240 = lshr exact i32 %mul14.7, 4
  %shr289.1 = zext nneg i32 %240 to i64
  %.idx1726.11827 = shl nuw nsw i64 %shr289.1, 11, !dbg !73
  %241 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726.11827, !dbg !73
  %.idx1727.11828 = shl nuw nsw i64 %conv107, 17, !dbg !73
  %242 = getelementptr inbounds i8, ptr addrspace(4) %241, i64 %.idx1727.11828, !dbg !73
  %condval_3.sroa.6.0.add.ptr299.sroa_idx.11832 = getelementptr inbounds i8, ptr addrspace(4) %242, i64 8, !dbg !74
  %243 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx.11832, align 8, !dbg !74, !tbaa !30
  %244 = load <4 x half>, ptr addrspace(4) %242, align 16, !dbg !74, !tbaa !30
  %.idx1726.1.1 = shl nuw nsw i64 %shr289.1, 11, !dbg !73
  %245 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726.1.1, !dbg !73
  %.idx1727.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !73
  %246 = getelementptr inbounds i8, ptr addrspace(4) %245, i64 %.idx1727.1.1, !dbg !73
  %gep1652.1.1 = getelementptr inbounds i8, ptr addrspace(4) %246, i64 1024, !dbg !73
  %condval_3.sroa.6.0.add.ptr299.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %246, i64 1032, !dbg !74
  %247 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx.1.1, align 8, !dbg !74, !tbaa !30
  %248 = load <4 x half>, ptr addrspace(4) %gep1652.1.1, align 16, !dbg !74, !tbaa !30
  br label %if.end331.1, !dbg !75

if.end331.1:                                      ; preds = %for.cond277.preheader.1, %if.end270.1
  %249 = phi <4 x half> [ %65, %if.end270.1 ], [ %247, %for.cond277.preheader.1 ]
  %250 = phi <4 x half> [ %66, %if.end270.1 ], [ %248, %for.cond277.preheader.1 ]
  %251 = phi <4 x half> [ %67, %if.end270.1 ], [ %243, %for.cond277.preheader.1 ]
  %252 = phi <4 x half> [ %68, %if.end270.1 ], [ %244, %for.cond277.preheader.1 ]
  br i1 %cmp98.not.1, label %if.end508.1, label %for.cond337.preheader.1, !dbg !75

for.cond337.preheader.1:                          ; preds = %if.end331.1
  %253 = lshr exact i32 %mul14.4, 4
  %shr349.1 = zext nneg i32 %253 to i64
  %.idx1728.11846 = shl nuw nsw i64 %shr349.1, 11, !dbg !76
  %254 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728.11846, !dbg !76
  %.idx1729.11847 = shl nuw nsw i64 %conv107, 17, !dbg !76
  %255 = getelementptr inbounds i8, ptr addrspace(4) %254, i64 %.idx1729.11847, !dbg !76
  %condval_4.sroa.6.0.add.ptr359.sroa_idx.11851 = getelementptr inbounds i8, ptr addrspace(4) %255, i64 8, !dbg !77
  %256 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx.11851, align 8, !dbg !77, !tbaa !30
  %257 = load <4 x half>, ptr addrspace(4) %255, align 16, !dbg !77, !tbaa !30
  %.idx1728.1.1 = shl nuw nsw i64 %shr349.1, 11, !dbg !76
  %258 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728.1.1, !dbg !76
  %.idx1729.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !76
  %259 = getelementptr inbounds i8, ptr addrspace(4) %258, i64 %.idx1729.1.1, !dbg !76
  %gep1655.1.1 = getelementptr inbounds i8, ptr addrspace(4) %259, i64 1024, !dbg !76
  %condval_4.sroa.6.0.add.ptr359.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %259, i64 1032, !dbg !77
  %260 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx.1.1, align 8, !dbg !77, !tbaa !30
  %261 = load <4 x half>, ptr addrspace(4) %gep1655.1.1, align 16, !dbg !77, !tbaa !30
  %and394.1 = and i32 %7, 64, !dbg !78
  %cmp395.not.1 = icmp eq i32 %and394.1, 0, !dbg !79
  br i1 %cmp395.not.1, label %if.end421.1, label %for.cond397.preheader.1, !dbg !80

for.cond397.preheader.1:                          ; preds = %for.cond337.preheader.1
  %add404.1 = add nuw nsw i32 %mul14.4, %mul403
  %cmp407.not.11864 = icmp ugt i32 %add404.1, %1, !dbg !81
  %fneg..11865 = select i1 %cmp407.not.11864, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2076 = insertelement <4 x float> poison, float %fneg..11865, i64 0, !dbg !82
  %cmp407.not.1.1.not = icmp ult i32 %add404.1, %1, !dbg !81
  %fneg..1.1 = select i1 %cmp407.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2177 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2076, float %fneg..1.1, i64 1, !dbg !82
  %add405.2.1 = or disjoint i32 %add404.1, 2, !dbg !83
  %cmp407.not.2.1 = icmp ugt i32 %add405.2.1, %1, !dbg !81
  %fneg..2.1 = select i1 %cmp407.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2270 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2177, float %fneg..2.1, i64 2, !dbg !82
  %add405.3.1 = or disjoint i32 %add404.1, 3, !dbg !83
  %cmp407.not.3.1 = icmp ugt i32 %add405.3.1, %1, !dbg !81
  %fneg..3.1 = select i1 %cmp407.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2363 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2270, float %fneg..3.1, i64 3, !dbg !82
  br label %if.end421.1

if.end421.1:                                      ; preds = %for.cond337.preheader.1, %for.cond397.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2363, %for.cond397.preheader.1 ], [ zeroinitializer, %for.cond337.preheader.1 ], !dbg !84
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %213, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !85, !call_argsrelate !86
  %263 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %212, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %262), !dbg !85, !call_argsrelate !86
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %211, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %263), !dbg !85, !call_argsrelate !86
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %210, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %264), !dbg !85, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2080 = extractelement <4 x float> %265, i64 0, !dbg !87
  %mul456.11869 = fmul contract float %acc_s.sroa.0.0.vec.extract2080, 0x3FB99999A0000000, !dbg !88
  %266 = tail call contract noundef float @llvm.minnum.f32(float %mul456.11869, float 0x4024CB5EC0000000), !dbg !89
  %267 = tail call contract noundef float @llvm.exp.f32(float %266), !dbg !93
  %acc_s.sroa.0.4.vec.extract2179 = extractelement <4 x float> %265, i64 1, !dbg !87
  %mul456.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2179, 0x3FB99999A0000000, !dbg !88
  %268 = tail call contract noundef float @llvm.minnum.f32(float %mul456.1.1, float 0x4024CB5EC0000000), !dbg !89
  %269 = tail call contract noundef float @llvm.exp.f32(float %268), !dbg !93
  %acc_s.sroa.0.8.vec.extract2272 = extractelement <4 x float> %265, i64 2, !dbg !87
  %mul456.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2272, 0x3FB99999A0000000, !dbg !88
  %270 = tail call contract noundef float @llvm.minnum.f32(float %mul456.2.1, float 0x4024CB5EC0000000), !dbg !89
  %271 = tail call contract noundef float @llvm.exp.f32(float %270), !dbg !93
  %acc_s.sroa.0.12.vec.extract2365 = extractelement <4 x float> %265, i64 3, !dbg !87
  %mul456.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2365, 0x3FB99999A0000000, !dbg !88
  %272 = tail call contract noundef float @llvm.minnum.f32(float %mul456.3.1, float 0x4024CB5EC0000000), !dbg !89
  %273 = tail call contract noundef float @llvm.exp.f32(float %272), !dbg !93
  %add472.11870 = fadd contract float %sum_acc.sroa.0.3, %267, !dbg !178
  %add472.1.1 = fadd contract float %sum_acc.sroa.20.3, %269, !dbg !178
  %add472.2.1 = fadd contract float %sum_acc.sroa.38.3, %271, !dbg !178
  %add472.3.1 = fadd contract float %sum_acc.sroa.56.3, %273, !dbg !178
  %274 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %267), !dbg !96
  %275 = insertelement <4 x i16> poison, i16 %274, i64 0, !dbg !105
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %269), !dbg !96
  %277 = insertelement <4 x i16> %275, i16 %276, i64 1, !dbg !105
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %271), !dbg !96
  %279 = insertelement <4 x i16> %277, i16 %278, i64 2, !dbg !105
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %273), !dbg !96
  %281 = insertelement <4 x i16> %279, i16 %280, i64 3, !dbg !105
  %acc_s_cast.sroa.0.6.vec.insert2015 = bitcast <4 x i16> %281 to <4 x half>, !dbg !105
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %257, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.0.1), !dbg !106, !call_argsrelate !107
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %256, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.34.1), !dbg !106, !call_argsrelate !107
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %261, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.66.1), !dbg !106, !call_argsrelate !107
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %260, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.98.1), !dbg !106, !call_argsrelate !107
  br label %if.end508.1, !dbg !108

if.end508.1:                                      ; preds = %if.end421.1, %if.end331.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end331.1 ], [ %285, %if.end421.1 ], !dbg !84
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end331.1 ], [ %284, %if.end421.1 ], !dbg !84
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end331.1 ], [ %283, %if.end421.1 ], !dbg !84
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end331.1 ], [ %282, %if.end421.1 ], !dbg !84
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end331.1 ], [ %add472.3.1, %if.end421.1 ], !dbg !84
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end331.1 ], [ %add472.2.1, %if.end421.1 ], !dbg !84
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end331.1 ], [ %add472.1.1, %if.end421.1 ], !dbg !84
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end331.1 ], [ %add472.11870, %if.end421.1 ], !dbg !84
  br i1 %cmp153.not.1, label %if.end687.1, label %for.cond515.preheader.1, !dbg !108

for.cond515.preheader.1:                          ; preds = %if.end508.1
  %286 = lshr exact i32 %mul14.5, 4
  %shr527.1 = zext nneg i32 %286 to i64
  %.idx1730.11872 = shl nuw nsw i64 %shr527.1, 11, !dbg !109
  %287 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730.11872, !dbg !109
  %.idx1731.11873 = shl nuw nsw i64 %conv107, 17, !dbg !109
  %288 = getelementptr inbounds i8, ptr addrspace(4) %287, i64 %.idx1731.11873, !dbg !109
  %condval_6.sroa.6.0.add.ptr537.sroa_idx.11877 = getelementptr inbounds i8, ptr addrspace(4) %288, i64 8, !dbg !110
  %289 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx.11877, align 8, !dbg !110, !tbaa !30
  %290 = load <4 x half>, ptr addrspace(4) %288, align 16, !dbg !110, !tbaa !30
  %.idx1730.1.1 = shl nuw nsw i64 %shr527.1, 11, !dbg !109
  %291 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730.1.1, !dbg !109
  %.idx1731.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !109
  %292 = getelementptr inbounds i8, ptr addrspace(4) %291, i64 %.idx1731.1.1, !dbg !109
  %gep1668.1.1 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 1024, !dbg !109
  %condval_6.sroa.6.0.add.ptr537.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 1032, !dbg !110
  %293 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx.1.1, align 8, !dbg !110, !tbaa !30
  %294 = load <4 x half>, ptr addrspace(4) %gep1668.1.1, align 16, !dbg !110, !tbaa !30
  %and573.1 = and i32 %8, 64, !dbg !111
  %cmp574.not.1 = icmp eq i32 %and573.1, 0, !dbg !112
  br i1 %cmp574.not.1, label %if.end600.1, label %for.cond576.preheader.1, !dbg !113

for.cond576.preheader.1:                          ; preds = %for.cond515.preheader.1
  %add583.1 = add nuw nsw i32 %mul14.5, %mul403
  %cmp586.not.11890 = icmp ugt i32 %add583.1, %1, !dbg !114
  %fneg.1447.11891 = select i1 %cmp586.not.11890, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2088 = insertelement <4 x float> poison, float %fneg.1447.11891, i64 0, !dbg !115
  %cmp586.not.1.1.not = icmp ult i32 %add583.1, %1, !dbg !114
  %fneg.1447.1.1 = select i1 %cmp586.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2187 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2088, float %fneg.1447.1.1, i64 1, !dbg !115
  %add584.2.1 = or disjoint i32 %add583.1, 2, !dbg !116
  %cmp586.not.2.1 = icmp ugt i32 %add584.2.1, %1, !dbg !114
  %fneg.1447.2.1 = select i1 %cmp586.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2280 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2187, float %fneg.1447.2.1, i64 2, !dbg !115
  %add584.3.1 = or disjoint i32 %add583.1, 3, !dbg !116
  %cmp586.not.3.1 = icmp ugt i32 %add584.3.1, %1, !dbg !114
  %fneg.1447.3.1 = select i1 %cmp586.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2373 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2280, float %fneg.1447.3.1, i64 3, !dbg !115
  br label %if.end600.1

if.end600.1:                                      ; preds = %for.cond515.preheader.1, %for.cond576.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2373, %for.cond576.preheader.1 ], [ zeroinitializer, %for.cond515.preheader.1 ], !dbg !84
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %226, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !117, !call_argsrelate !86
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %225, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %295), !dbg !117, !call_argsrelate !86
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %296), !dbg !117, !call_argsrelate !86
  %298 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %223, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %297), !dbg !117, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2092 = extractelement <4 x float> %298, i64 0, !dbg !118
  %mul635.11895 = fmul contract float %acc_s.sroa.0.0.vec.extract2092, 0x3FB99999A0000000, !dbg !119
  %299 = tail call contract noundef float @llvm.minnum.f32(float %mul635.11895, float 0x4024CB5EC0000000), !dbg !120
  %300 = tail call contract noundef float @llvm.exp.f32(float %299), !dbg !122
  %acc_s.sroa.0.4.vec.extract2189 = extractelement <4 x float> %298, i64 1, !dbg !118
  %mul635.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2189, 0x3FB99999A0000000, !dbg !119
  %301 = tail call contract noundef float @llvm.minnum.f32(float %mul635.1.1, float 0x4024CB5EC0000000), !dbg !120
  %302 = tail call contract noundef float @llvm.exp.f32(float %301), !dbg !122
  %acc_s.sroa.0.8.vec.extract2282 = extractelement <4 x float> %298, i64 2, !dbg !118
  %mul635.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2282, 0x3FB99999A0000000, !dbg !119
  %303 = tail call contract noundef float @llvm.minnum.f32(float %mul635.2.1, float 0x4024CB5EC0000000), !dbg !120
  %304 = tail call contract noundef float @llvm.exp.f32(float %303), !dbg !122
  %acc_s.sroa.0.12.vec.extract2375 = extractelement <4 x float> %298, i64 3, !dbg !118
  %mul635.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2375, 0x3FB99999A0000000, !dbg !119
  %305 = tail call contract noundef float @llvm.minnum.f32(float %mul635.3.1, float 0x4024CB5EC0000000), !dbg !120
  %306 = tail call contract noundef float @llvm.exp.f32(float %305), !dbg !122
  %add651.11896 = fadd contract float %sum_acc.sroa.0.4, %300, !dbg !124
  %add651.1.1 = fadd contract float %sum_acc.sroa.20.4, %302, !dbg !124
  %add651.2.1 = fadd contract float %sum_acc.sroa.38.4, %304, !dbg !124
  %add651.3.1 = fadd contract float %sum_acc.sroa.56.4, %306, !dbg !124
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %300), !dbg !125
  %308 = insertelement <4 x i16> poison, i16 %307, i64 0, !dbg !129
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %302), !dbg !125
  %310 = insertelement <4 x i16> %308, i16 %309, i64 1, !dbg !129
  %311 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %304), !dbg !125
  %312 = insertelement <4 x i16> %310, i16 %311, i64 2, !dbg !129
  %313 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %306), !dbg !125
  %314 = insertelement <4 x i16> %312, i16 %313, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert2017 = bitcast <4 x i16> %314 to <4 x half>, !dbg !129
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %290, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.0.1), !dbg !130, !call_argsrelate !107
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %289, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.18.1), !dbg !130, !call_argsrelate !107
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %294, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.34.1), !dbg !130, !call_argsrelate !107
  %318 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %293, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.50.1), !dbg !130, !call_argsrelate !107
  br label %if.end687.1, !dbg !131

if.end687.1:                                      ; preds = %if.end600.1, %if.end508.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end508.1 ], [ %318, %if.end600.1 ], !dbg !84
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end508.1 ], [ %317, %if.end600.1 ], !dbg !84
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end508.1 ], [ %316, %if.end600.1 ], !dbg !84
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end508.1 ], [ %315, %if.end600.1 ], !dbg !84
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end508.1 ], [ %add651.3.1, %if.end600.1 ], !dbg !84
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end508.1 ], [ %add651.2.1, %if.end600.1 ], !dbg !84
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end508.1 ], [ %add651.1.1, %if.end600.1 ], !dbg !84
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end508.1 ], [ %add651.11896, %if.end600.1 ], !dbg !84
  br i1 %cmp214.not.1, label %if.end866.1, label %for.cond694.preheader.1, !dbg !131

for.cond694.preheader.1:                          ; preds = %if.end687.1
  %319 = lshr exact i32 %mul14.6, 4
  %shr706.1 = zext nneg i32 %319 to i64
  %.idx1732.11898 = shl nuw nsw i64 %shr706.1, 11, !dbg !132
  %320 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732.11898, !dbg !132
  %.idx1733.11899 = shl nuw nsw i64 %conv107, 17, !dbg !132
  %321 = getelementptr inbounds i8, ptr addrspace(4) %320, i64 %.idx1733.11899, !dbg !132
  %condval_8.sroa.6.0.add.ptr716.sroa_idx.11903 = getelementptr inbounds i8, ptr addrspace(4) %321, i64 8, !dbg !133
  %322 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx.11903, align 8, !dbg !133, !tbaa !30
  %323 = load <4 x half>, ptr addrspace(4) %321, align 16, !dbg !133, !tbaa !30
  %.idx1732.1.1 = shl nuw nsw i64 %shr706.1, 11, !dbg !132
  %324 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732.1.1, !dbg !132
  %.idx1733.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !132
  %325 = getelementptr inbounds i8, ptr addrspace(4) %324, i64 %.idx1733.1.1, !dbg !132
  %gep1682.1.1 = getelementptr inbounds i8, ptr addrspace(4) %325, i64 1024, !dbg !132
  %condval_8.sroa.6.0.add.ptr716.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %325, i64 1032, !dbg !133
  %326 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx.1.1, align 8, !dbg !133, !tbaa !30
  %327 = load <4 x half>, ptr addrspace(4) %gep1682.1.1, align 16, !dbg !133, !tbaa !30
  %and752.1 = and i32 %9, 64, !dbg !134
  %cmp753.not.1 = icmp eq i32 %and752.1, 0, !dbg !135
  br i1 %cmp753.not.1, label %if.end779.1, label %for.cond755.preheader.1, !dbg !136

for.cond755.preheader.1:                          ; preds = %for.cond694.preheader.1
  %add762.1 = add nuw nsw i32 %mul14.6, %mul403
  %cmp765.not.11916 = icmp ugt i32 %add762.1, %1, !dbg !137
  %fneg.1448.11917 = select i1 %cmp765.not.11916, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2100 = insertelement <4 x float> poison, float %fneg.1448.11917, i64 0, !dbg !138
  %cmp765.not.1.1.not = icmp ult i32 %add762.1, %1, !dbg !137
  %fneg.1448.1.1 = select i1 %cmp765.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2197 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2100, float %fneg.1448.1.1, i64 1, !dbg !138
  %add763.2.1 = or disjoint i32 %add762.1, 2, !dbg !139
  %cmp765.not.2.1 = icmp ugt i32 %add763.2.1, %1, !dbg !137
  %fneg.1448.2.1 = select i1 %cmp765.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2290 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2197, float %fneg.1448.2.1, i64 2, !dbg !138
  %add763.3.1 = or disjoint i32 %add762.1, 3, !dbg !139
  %cmp765.not.3.1 = icmp ugt i32 %add763.3.1, %1, !dbg !137
  %fneg.1448.3.1 = select i1 %cmp765.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2383 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2290, float %fneg.1448.3.1, i64 3, !dbg !138
  br label %if.end779.1

if.end779.1:                                      ; preds = %for.cond694.preheader.1, %for.cond755.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2383, %for.cond755.preheader.1 ], [ zeroinitializer, %for.cond694.preheader.1 ], !dbg !84
  %328 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %239, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !140, !call_argsrelate !86
  %329 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %238, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %328), !dbg !140, !call_argsrelate !86
  %330 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %237, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %329), !dbg !140, !call_argsrelate !86
  %331 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %236, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %330), !dbg !140, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2104 = extractelement <4 x float> %331, i64 0, !dbg !141
  %mul814.11921 = fmul contract float %acc_s.sroa.0.0.vec.extract2104, 0x3FB99999A0000000, !dbg !142
  %332 = tail call contract noundef float @llvm.minnum.f32(float %mul814.11921, float 0x4024CB5EC0000000), !dbg !143
  %333 = tail call contract noundef float @llvm.exp.f32(float %332), !dbg !145
  %acc_s.sroa.0.4.vec.extract2199 = extractelement <4 x float> %331, i64 1, !dbg !141
  %mul814.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2199, 0x3FB99999A0000000, !dbg !142
  %334 = tail call contract noundef float @llvm.minnum.f32(float %mul814.1.1, float 0x4024CB5EC0000000), !dbg !143
  %335 = tail call contract noundef float @llvm.exp.f32(float %334), !dbg !145
  %acc_s.sroa.0.8.vec.extract2292 = extractelement <4 x float> %331, i64 2, !dbg !141
  %mul814.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2292, 0x3FB99999A0000000, !dbg !142
  %336 = tail call contract noundef float @llvm.minnum.f32(float %mul814.2.1, float 0x4024CB5EC0000000), !dbg !143
  %337 = tail call contract noundef float @llvm.exp.f32(float %336), !dbg !145
  %acc_s.sroa.0.12.vec.extract2385 = extractelement <4 x float> %331, i64 3, !dbg !141
  %mul814.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2385, 0x3FB99999A0000000, !dbg !142
  %338 = tail call contract noundef float @llvm.minnum.f32(float %mul814.3.1, float 0x4024CB5EC0000000), !dbg !143
  %339 = tail call contract noundef float @llvm.exp.f32(float %338), !dbg !145
  %add830.11922 = fadd contract float %sum_acc.sroa.0.5, %333, !dbg !147
  %add830.1.1 = fadd contract float %sum_acc.sroa.20.5, %335, !dbg !147
  %add830.2.1 = fadd contract float %sum_acc.sroa.38.5, %337, !dbg !147
  %add830.3.1 = fadd contract float %sum_acc.sroa.56.5, %339, !dbg !147
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %333), !dbg !148
  %341 = insertelement <4 x i16> poison, i16 %340, i64 0, !dbg !152
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %335), !dbg !148
  %343 = insertelement <4 x i16> %341, i16 %342, i64 1, !dbg !152
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %337), !dbg !148
  %345 = insertelement <4 x i16> %343, i16 %344, i64 2, !dbg !152
  %346 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %339), !dbg !148
  %347 = insertelement <4 x i16> %345, i16 %346, i64 3, !dbg !152
  %acc_s_cast.sroa.0.6.vec.insert2019 = bitcast <4 x i16> %347 to <4 x half>, !dbg !152
  %348 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %323, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.0.2), !dbg !153, !call_argsrelate !107
  %349 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %322, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.34.2), !dbg !153, !call_argsrelate !107
  %350 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %327, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.66.2), !dbg !153, !call_argsrelate !107
  %351 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %326, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.98.2), !dbg !153, !call_argsrelate !107
  br label %if.end866.1, !dbg !154

if.end866.1:                                      ; preds = %if.end779.1, %if.end687.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end687.1 ], [ %351, %if.end779.1 ], !dbg !84
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end687.1 ], [ %350, %if.end779.1 ], !dbg !84
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end687.1 ], [ %349, %if.end779.1 ], !dbg !84
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end687.1 ], [ %348, %if.end779.1 ], !dbg !84
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end687.1 ], [ %add830.3.1, %if.end779.1 ], !dbg !84
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end687.1 ], [ %add830.2.1, %if.end779.1 ], !dbg !84
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end687.1 ], [ %add830.1.1, %if.end779.1 ], !dbg !84
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end687.1 ], [ %add830.11922, %if.end779.1 ], !dbg !84
  br i1 %cmp275.not.1, label %if.end1045.1, label %for.cond873.preheader.1, !dbg !154

for.cond873.preheader.1:                          ; preds = %if.end866.1
  %352 = lshr exact i32 %mul14.7, 4
  %shr885.1 = zext nneg i32 %352 to i64
  %.idx1734.11924 = shl nuw nsw i64 %shr885.1, 11, !dbg !155
  %353 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734.11924, !dbg !155
  %.idx1735.11925 = shl nuw nsw i64 %conv107, 17, !dbg !155
  %354 = getelementptr inbounds i8, ptr addrspace(4) %353, i64 %.idx1735.11925, !dbg !155
  %condval_10.sroa.6.0.add.ptr895.sroa_idx.11929 = getelementptr inbounds i8, ptr addrspace(4) %354, i64 8, !dbg !156
  %355 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx.11929, align 8, !dbg !156, !tbaa !30
  %356 = load <4 x half>, ptr addrspace(4) %354, align 16, !dbg !156, !tbaa !30
  %.idx1734.1.1 = shl nuw nsw i64 %shr885.1, 11, !dbg !155
  %357 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734.1.1, !dbg !155
  %.idx1735.1.1 = shl nuw nsw i64 %conv107, 17, !dbg !155
  %358 = getelementptr inbounds i8, ptr addrspace(4) %357, i64 %.idx1735.1.1, !dbg !155
  %gep1696.1.1 = getelementptr inbounds i8, ptr addrspace(4) %358, i64 1024, !dbg !155
  %condval_10.sroa.6.0.add.ptr895.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %358, i64 1032, !dbg !156
  %359 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx.1.1, align 8, !dbg !156, !tbaa !30
  %360 = load <4 x half>, ptr addrspace(4) %gep1696.1.1, align 16, !dbg !156, !tbaa !30
  %and931.1 = and i32 %10, 64, !dbg !157
  %cmp932.not.1 = icmp eq i32 %and931.1, 0, !dbg !158
  br i1 %cmp932.not.1, label %if.end958.1, label %for.cond934.preheader.1, !dbg !159

for.cond934.preheader.1:                          ; preds = %for.cond873.preheader.1
  %add941.1 = add nuw nsw i32 %mul14.7, %mul403
  %cmp944.not.11942 = icmp ugt i32 %add941.1, %1, !dbg !160
  %fneg.1449.11943 = select i1 %cmp944.not.11942, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2112 = insertelement <4 x float> poison, float %fneg.1449.11943, i64 0, !dbg !161
  %cmp944.not.1.1.not = icmp ult i32 %add941.1, %1, !dbg !160
  %fneg.1449.1.1 = select i1 %cmp944.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2207 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2112, float %fneg.1449.1.1, i64 1, !dbg !161
  %add942.2.1 = or disjoint i32 %add941.1, 2, !dbg !162
  %cmp944.not.2.1 = icmp ugt i32 %add942.2.1, %1, !dbg !160
  %fneg.1449.2.1 = select i1 %cmp944.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2300 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2207, float %fneg.1449.2.1, i64 2, !dbg !161
  %add942.3.1 = or disjoint i32 %add941.1, 3, !dbg !162
  %cmp944.not.3.1 = icmp ugt i32 %add942.3.1, %1, !dbg !160
  %fneg.1449.3.1 = select i1 %cmp944.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2393 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2300, float %fneg.1449.3.1, i64 3, !dbg !161
  br label %if.end958.1

if.end958.1:                                      ; preds = %for.cond873.preheader.1, %for.cond934.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2393, %for.cond934.preheader.1 ], [ zeroinitializer, %for.cond873.preheader.1 ], !dbg !84
  %361 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %252, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !163, !call_argsrelate !86
  %362 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %251, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %361), !dbg !163, !call_argsrelate !86
  %363 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %250, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %362), !dbg !163, !call_argsrelate !86
  %364 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %249, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %363), !dbg !163, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2116 = extractelement <4 x float> %364, i64 0, !dbg !164
  %mul993.11947 = fmul contract float %acc_s.sroa.0.0.vec.extract2116, 0x3FB99999A0000000, !dbg !165
  %365 = tail call contract noundef float @llvm.minnum.f32(float %mul993.11947, float 0x4024CB5EC0000000), !dbg !166
  %366 = tail call contract noundef float @llvm.exp.f32(float %365), !dbg !168
  %acc_s.sroa.0.4.vec.extract2209 = extractelement <4 x float> %364, i64 1, !dbg !164
  %mul993.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2209, 0x3FB99999A0000000, !dbg !165
  %367 = tail call contract noundef float @llvm.minnum.f32(float %mul993.1.1, float 0x4024CB5EC0000000), !dbg !166
  %368 = tail call contract noundef float @llvm.exp.f32(float %367), !dbg !168
  %acc_s.sroa.0.8.vec.extract2302 = extractelement <4 x float> %364, i64 2, !dbg !164
  %mul993.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2302, 0x3FB99999A0000000, !dbg !165
  %369 = tail call contract noundef float @llvm.minnum.f32(float %mul993.2.1, float 0x4024CB5EC0000000), !dbg !166
  %370 = tail call contract noundef float @llvm.exp.f32(float %369), !dbg !168
  %acc_s.sroa.0.12.vec.extract2395 = extractelement <4 x float> %364, i64 3, !dbg !164
  %mul993.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2395, 0x3FB99999A0000000, !dbg !165
  %371 = tail call contract noundef float @llvm.minnum.f32(float %mul993.3.1, float 0x4024CB5EC0000000), !dbg !166
  %372 = tail call contract noundef float @llvm.exp.f32(float %371), !dbg !168
  %add1009.11948 = fadd contract float %sum_acc.sroa.0.6, %366, !dbg !170
  %add1009.1.1 = fadd contract float %sum_acc.sroa.20.6, %368, !dbg !170
  %add1009.2.1 = fadd contract float %sum_acc.sroa.38.6, %370, !dbg !170
  %add1009.3.1 = fadd contract float %sum_acc.sroa.56.6, %372, !dbg !170
  %373 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %366), !dbg !171
  %374 = insertelement <4 x i16> poison, i16 %373, i64 0, !dbg !175
  %375 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %368), !dbg !171
  %376 = insertelement <4 x i16> %374, i16 %375, i64 1, !dbg !175
  %377 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %370), !dbg !171
  %378 = insertelement <4 x i16> %376, i16 %377, i64 2, !dbg !175
  %379 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %372), !dbg !171
  %380 = insertelement <4 x i16> %378, i16 %379, i64 3, !dbg !175
  %acc_s_cast.sroa.0.6.vec.insert2021 = bitcast <4 x i16> %380 to <4 x half>, !dbg !175
  %381 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %356, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.0.2), !dbg !176, !call_argsrelate !107
  %382 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %355, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.18.2), !dbg !176, !call_argsrelate !107
  %383 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %360, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.34.2), !dbg !176, !call_argsrelate !107
  %384 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %359, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.50.2), !dbg !176, !call_argsrelate !107
  br label %if.end1045.1, !dbg !177

if.end1045.1:                                     ; preds = %if.end958.1, %if.end866.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end866.1 ], [ %384, %if.end958.1 ], !dbg !84
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end866.1 ], [ %383, %if.end958.1 ], !dbg !84
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end866.1 ], [ %382, %if.end958.1 ], !dbg !84
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end866.1 ], [ %381, %if.end958.1 ], !dbg !84
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end866.1 ], [ %add1009.3.1, %if.end958.1 ], !dbg !84
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end866.1 ], [ %add1009.2.1, %if.end958.1 ], !dbg !84
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end866.1 ], [ %add1009.1.1, %if.end958.1 ], !dbg !84
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end866.1 ], [ %add1009.11948, %if.end958.1 ], !dbg !84
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !179
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !180
  %add1057 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !181
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !179
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !180
  %add1057.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !181
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !179
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !180
  %add1057.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !181
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !179
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !180
  %add1057.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !181
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !179
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !180
  %add1057.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !181
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !179
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !180
  %add1057.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !181
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !179
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !180
  %add1057.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !181
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !179
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !180
  %add1057.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !181
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !179
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !180
  %add1057.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !181
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !179
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !180
  %add1057.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !181
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !179
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !180
  %add1057.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !181
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !179
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !180
  %add1057.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !181
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !179
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !180
  %add1057.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !181
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !179
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !180
  %add1057.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !181
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !179
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !180
  %add1057.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !181
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !179
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !180
  %add1057.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !181
  %add1071 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !182
  %add1071.1 = fadd contract float %add1071, %sum_acc.sroa.20.7, !dbg !182
  %add1071.2 = fadd contract float %add1071.1, %sum_acc.sroa.38.7, !dbg !182
  %add1071.3 = fadd contract float %add1071.2, %sum_acc.sroa.56.7, !dbg !182
  %385 = bitcast float %add1071.3 to i32, !dbg !183
  %386 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !195
  %387 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %386) #11, !dbg !200
  %xor.i.i = xor i32 %387, 32, !dbg !201
  %388 = and i32 %387, -64, !dbg !202
  %and.i.i = add nsw i32 %388, 64, !dbg !202
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !203
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %387, !dbg !204
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !205
  %389 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %385), !dbg !206
  %390 = bitcast i32 %389 to float, !dbg !207
  %add.i = fadd contract float %add1071.3, %390, !dbg !208
  %391 = bitcast float %add.i to i32, !dbg !211
  %392 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !218
  %393 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %392) #11, !dbg !221
  %xor.i.i1610 = xor i32 %393, 16, !dbg !222
  %394 = and i32 %393, -64, !dbg !223
  %and.i.i1611 = add nsw i32 %394, 64, !dbg !223
  %cmp.not.i.i1612 = icmp slt i32 %xor.i.i1610, %and.i.i1611, !dbg !224
  %cond.i.i1613 = select i1 %cmp.not.i.i1612, i32 %xor.i.i1610, i32 %393, !dbg !225
  %shl.i.i1614 = shl i32 %cond.i.i1613, 2, !dbg !226
  %395 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1614, i32 %391), !dbg !227
  %396 = bitcast i32 %395 to float, !dbg !228
  %add.i.i = fadd contract float %add.i, %396, !dbg !229
  %cmp1080 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !231
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !232
  %condval_12.0 = select i1 %cmp1080, float %div, float 0.000000e+00, !dbg !232
  %mul1093 = fmul contract float %condval_12.0, %add1057, !dbg !233
  %mul1093.1 = fmul contract float %condval_12.0, %add1057.1, !dbg !233
  %mul1093.2 = fmul contract float %condval_12.0, %add1057.2, !dbg !233
  %mul1093.3 = fmul contract float %condval_12.0, %add1057.3, !dbg !233
  %mul1093.4 = fmul contract float %condval_12.0, %add1057.4, !dbg !233
  %mul1093.5 = fmul contract float %condval_12.0, %add1057.5, !dbg !233
  %mul1093.6 = fmul contract float %condval_12.0, %add1057.6, !dbg !233
  %mul1093.7 = fmul contract float %condval_12.0, %add1057.7, !dbg !233
  %mul1093.8 = fmul contract float %condval_12.0, %add1057.8, !dbg !233
  %mul1093.9 = fmul contract float %condval_12.0, %add1057.9, !dbg !233
  %mul1093.10 = fmul contract float %condval_12.0, %add1057.10, !dbg !233
  %mul1093.11 = fmul contract float %condval_12.0, %add1057.11, !dbg !233
  %mul1093.12 = fmul contract float %condval_12.0, %add1057.12, !dbg !233
  %mul1093.13 = fmul contract float %condval_12.0, %add1057.13, !dbg !233
  %mul1093.14 = fmul contract float %condval_12.0, %add1057.14, !dbg !233
  %mul1093.15 = fmul contract float %condval_12.0, %add1057.15, !dbg !233
  %397 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093), !dbg !234
  %O_reg.sroa.0.0.insert.ext = zext i16 %397 to i64, !dbg !238
  %398 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.1), !dbg !234
  %O_reg.sroa.0.2.insert.ext = zext i16 %398 to i64, !dbg !238
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !238
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !238
  %399 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.2), !dbg !234
  %O_reg.sroa.0.4.insert.ext = zext i16 %399 to i64, !dbg !238
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !238
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !238
  %400 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.3), !dbg !234
  %O_reg.sroa.0.6.insert.ext = zext i16 %400 to i64, !dbg !238
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !238
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !238
  %401 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.4), !dbg !234
  %O_reg.sroa.7.8.insert.ext = zext i16 %401 to i64, !dbg !238
  %402 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.5), !dbg !234
  %O_reg.sroa.7.10.insert.ext = zext i16 %402 to i64, !dbg !238
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !238
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !238
  %403 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.6), !dbg !234
  %O_reg.sroa.7.12.insert.ext = zext i16 %403 to i64, !dbg !238
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !238
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !238
  %404 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.7), !dbg !234
  %O_reg.sroa.7.14.insert.ext = zext i16 %404 to i64, !dbg !238
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !238
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !238
  %405 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.8), !dbg !234
  %O_reg.sroa.12.16.insert.ext = zext i16 %405 to i64, !dbg !238
  %406 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.9), !dbg !234
  %O_reg.sroa.12.18.insert.ext = zext i16 %406 to i64, !dbg !238
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !238
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !238
  %407 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.10), !dbg !234
  %O_reg.sroa.12.20.insert.ext = zext i16 %407 to i64, !dbg !238
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !238
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !238
  %408 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.11), !dbg !234
  %O_reg.sroa.12.22.insert.ext = zext i16 %408 to i64, !dbg !238
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !238
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !238
  %409 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.12), !dbg !234
  %O_reg.sroa.17.24.insert.ext = zext i16 %409 to i64, !dbg !238
  %410 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.13), !dbg !234
  %O_reg.sroa.17.26.insert.ext = zext i16 %410 to i64, !dbg !238
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !238
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !238
  %411 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.14), !dbg !234
  %O_reg.sroa.17.28.insert.ext = zext i16 %411 to i64, !dbg !238
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !238
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !238
  %412 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.15), !dbg !234
  %O_reg.sroa.17.30.insert.ext = zext i16 %412 to i64, !dbg !238
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !238
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !238
  %shr1135 = lshr i32 %11, 5
  %and1138 = and i32 %11, 7
  %mul1144 = and i32 %16, 4
  %xor = xor i32 %shr1135, %and1138, !dbg !239
  %mul1139 = shl nuw nsw i32 %xor, 3, !dbg !240
  %add1140 = add nuw nsw i32 %mul1139, %mul29, !dbg !241
  %add1145 = or disjoint i32 %add1140, %mul1144, !dbg !242
  %add.ptr1147 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145, !dbg !243
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1147, align 8, !dbg !244
  %add1136.1 = add nuw nsw i32 %shr1135, 2, !dbg !245
  %xor.1 = xor i32 %add1136.1, %and1138, !dbg !239
  %mul1139.1 = shl nuw nsw i32 %xor.1, 3, !dbg !240
  %add1140.1 = add nuw nsw i32 %mul1139.1, %mul29, !dbg !241
  %add1145.1 = or disjoint i32 %add1140.1, %mul1144, !dbg !242
  %add.ptr1147.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145.1, !dbg !243
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1147.1, align 8, !dbg !244
  %add1136.2 = add nuw nsw i32 %shr1135, 4, !dbg !245
  %xor.2 = xor i32 %add1136.2, %and1138, !dbg !239
  %mul1139.2 = shl nuw nsw i32 %xor.2, 3, !dbg !240
  %add1140.2 = add nuw nsw i32 %mul1139.2, %mul29, !dbg !241
  %add1145.2 = or disjoint i32 %add1140.2, %mul1144, !dbg !242
  %add.ptr1147.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145.2, !dbg !243
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1147.2, align 8, !dbg !244
  %add1136.3 = add nuw nsw i32 %shr1135, 6, !dbg !245
  %xor.3 = xor i32 %add1136.3, %and1138, !dbg !239
  %mul1139.3 = shl nuw nsw i32 %xor.3, 3, !dbg !240
  %add1140.3 = add nuw nsw i32 %mul1139.3, %mul29, !dbg !241
  %add1145.3 = or disjoint i32 %add1140.3, %mul1144, !dbg !242
  %add.ptr1147.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145.3, !dbg !243
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1147.3, align 8, !dbg !244
  fence syncscope("warp") release, !dbg !246
  tail call void @llvm.mxc.barrier.warp(), !dbg !251
  fence syncscope("warp") acquire, !dbg !252
  %mul1158 = and i32 %15, 8128
  %xor11641445 = and i32 %15, 56
  %call1162.masked = and i32 %11, 1016
  %mul1165 = xor i32 %xor11641445, %call1162.masked
  %invariant.gep1716 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1158, !dbg !253
  %invariant.gep1718 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep1716, i32 %mul1165, !dbg !253
  %add1175 = add nuw nsw i32 %add26, %15
  %413 = zext nneg i32 %add1175 to i64, !dbg !254
  %add.ptr1180 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %413, !dbg !255
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1180, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1718, i64 16, i1 false), !dbg !256, !tbaa.struct !257, !call_argsrelate !258
  %gep1719.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1718, i32 1024, !dbg !259
  %414 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %413, !dbg !255
  %add.ptr1180.1 = getelementptr inbounds i8, ptr addrspace(1) %414, i64 1024, !dbg !255
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1180.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1719.1, i64 16, i1 false), !dbg !256, !tbaa.struct !257, !call_argsrelate !258
  ret void, !dbg !260
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #8

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
declare float @llvm.minnum.f32(float, float) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmprm_m1elu/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmprm_m1elu/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 77, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 28, column: 39, scope: !40)
!46 = !DILocation(line: 28, column: 51, scope: !40)
!47 = !DILocation(line: 79, column: 3, scope: !48, inlinedAt: !49)
!48 = distinct !DISubprogram(name: "__fetch_builtin_z", scope: !44, file: !44, line: 79, type: !7, scopeLine: 79, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!49 = distinct !DILocation(line: 28, column: 67, scope: !40)
!50 = !DILocation(line: 28, column: 59, scope: !40)
!51 = !DILocation(line: 28, column: 16, scope: !40)
!52 = !DILocation(line: 32, column: 29, scope: !40)
!53 = !DILocation(line: 33, column: 43, scope: !40)
!54 = !DILocation(line: 32, column: 42, scope: !40)
!55 = !{i32 0, i32 1024}
!56 = !DILocation(line: 36, column: 3, scope: !40)
!57 = !DILocation(line: 37, column: 46, scope: !40)
!58 = !DILocation(line: 37, column: 32, scope: !40)
!59 = !DILocation(line: 57, column: 34, scope: !40)
!60 = !DILocation(line: 57, column: 9, scope: !40)
!61 = !DILocation(line: 63, column: 33, scope: !40)
!62 = !DILocation(line: 63, column: 19, scope: !40)
!63 = !DILocation(line: 70, column: 9, scope: !40)
!64 = !DILocation(line: 70, column: 40, scope: !40)
!65 = !DILocation(line: 76, column: 35, scope: !40)
!66 = !DILocation(line: 76, column: 21, scope: !40)
!67 = !DILocation(line: 83, column: 9, scope: !40)
!68 = !DILocation(line: 83, column: 40, scope: !40)
!69 = !DILocation(line: 89, column: 35, scope: !40)
!70 = !DILocation(line: 89, column: 21, scope: !40)
!71 = !DILocation(line: 96, column: 9, scope: !40)
!72 = !DILocation(line: 96, column: 40, scope: !40)
!73 = !DILocation(line: 102, column: 35, scope: !40)
!74 = !DILocation(line: 102, column: 21, scope: !40)
!75 = !DILocation(line: 109, column: 9, scope: !40)
!76 = !DILocation(line: 115, column: 35, scope: !40)
!77 = !DILocation(line: 115, column: 21, scope: !40)
!78 = !DILocation(line: 121, column: 41, scope: !40)
!79 = !DILocation(line: 121, column: 13, scope: !40)
!80 = !DILocation(line: 121, column: 11, scope: !40)
!81 = !DILocation(line: 125, column: 65, scope: !40)
!82 = !DILocation(line: 130, column: 22, scope: !40)
!83 = !DILocation(line: 125, column: 58, scope: !40)
!84 = !DILocation(line: 0, scope: !40)
!85 = !DILocation(line: 139, column: 36, scope: !40)
!86 = !{i32 -1, i32 3, i32 -1}
!87 = !DILocation(line: 147, column: 32, scope: !40)
!88 = !DILocation(line: 147, column: 43, scope: !40)
!89 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "min", scope: !91, file: !91, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!92 = distinct !DILocation(line: 147, column: 27, scope: !40)
!93 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "expf", scope: !91, file: !91, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 147, column: 22, scope: !40)
!96 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !98, file: !98, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!99 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "__float2half", scope: !101, file: !101, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!102 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "__half", scope: !101, file: !101, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 155, column: 34, scope: !40)
!105 = !DILocation(line: 155, column: 31, scope: !40)
!106 = !DILocation(line: 159, column: 36, scope: !40)
!107 = !{i32 4, i32 -1, i32 -1}
!108 = !DILocation(line: 165, column: 9, scope: !40)
!109 = !DILocation(line: 171, column: 35, scope: !40)
!110 = !DILocation(line: 171, column: 21, scope: !40)
!111 = !DILocation(line: 177, column: 47, scope: !40)
!112 = !DILocation(line: 177, column: 13, scope: !40)
!113 = !DILocation(line: 177, column: 11, scope: !40)
!114 = !DILocation(line: 181, column: 66, scope: !40)
!115 = !DILocation(line: 186, column: 23, scope: !40)
!116 = !DILocation(line: 181, column: 58, scope: !40)
!117 = !DILocation(line: 195, column: 36, scope: !40)
!118 = !DILocation(line: 203, column: 33, scope: !40)
!119 = !DILocation(line: 203, column: 45, scope: !40)
!120 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !121)
!121 = distinct !DILocation(line: 203, column: 28, scope: !40)
!122 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !123)
!123 = distinct !DILocation(line: 203, column: 23, scope: !40)
!124 = !DILocation(line: 207, column: 40, scope: !40)
!125 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !126)
!126 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !127)
!127 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !128)
!128 = distinct !DILocation(line: 211, column: 36, scope: !40)
!129 = !DILocation(line: 211, column: 33, scope: !40)
!130 = !DILocation(line: 215, column: 42, scope: !40)
!131 = !DILocation(line: 221, column: 9, scope: !40)
!132 = !DILocation(line: 227, column: 35, scope: !40)
!133 = !DILocation(line: 227, column: 21, scope: !40)
!134 = !DILocation(line: 233, column: 47, scope: !40)
!135 = !DILocation(line: 233, column: 13, scope: !40)
!136 = !DILocation(line: 233, column: 11, scope: !40)
!137 = !DILocation(line: 237, column: 66, scope: !40)
!138 = !DILocation(line: 242, column: 23, scope: !40)
!139 = !DILocation(line: 237, column: 58, scope: !40)
!140 = !DILocation(line: 251, column: 36, scope: !40)
!141 = !DILocation(line: 259, column: 33, scope: !40)
!142 = !DILocation(line: 259, column: 45, scope: !40)
!143 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !144)
!144 = distinct !DILocation(line: 259, column: 28, scope: !40)
!145 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !146)
!146 = distinct !DILocation(line: 259, column: 23, scope: !40)
!147 = !DILocation(line: 263, column: 40, scope: !40)
!148 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !149)
!149 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !150)
!150 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !151)
!151 = distinct !DILocation(line: 267, column: 36, scope: !40)
!152 = !DILocation(line: 267, column: 33, scope: !40)
!153 = !DILocation(line: 271, column: 38, scope: !40)
!154 = !DILocation(line: 277, column: 9, scope: !40)
!155 = !DILocation(line: 283, column: 36, scope: !40)
!156 = !DILocation(line: 283, column: 22, scope: !40)
!157 = !DILocation(line: 289, column: 47, scope: !40)
!158 = !DILocation(line: 289, column: 13, scope: !40)
!159 = !DILocation(line: 289, column: 11, scope: !40)
!160 = !DILocation(line: 293, column: 66, scope: !40)
!161 = !DILocation(line: 298, column: 23, scope: !40)
!162 = !DILocation(line: 293, column: 58, scope: !40)
!163 = !DILocation(line: 307, column: 36, scope: !40)
!164 = !DILocation(line: 315, column: 33, scope: !40)
!165 = !DILocation(line: 315, column: 45, scope: !40)
!166 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !167)
!167 = distinct !DILocation(line: 315, column: 28, scope: !40)
!168 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !169)
!169 = distinct !DILocation(line: 315, column: 23, scope: !40)
!170 = !DILocation(line: 319, column: 40, scope: !40)
!171 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !172)
!172 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !173)
!173 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !174)
!174 = distinct !DILocation(line: 323, column: 36, scope: !40)
!175 = !DILocation(line: 323, column: 33, scope: !40)
!176 = !DILocation(line: 327, column: 42, scope: !40)
!177 = !DILocation(line: 52, column: 34, scope: !40)
!178 = !DILocation(line: 151, column: 40, scope: !40)
!179 = !DILocation(line: 336, column: 20, scope: !40)
!180 = !DILocation(line: 336, column: 34, scope: !40)
!181 = !DILocation(line: 336, column: 32, scope: !40)
!182 = !DILocation(line: 341, column: 36, scope: !40)
!183 = !DILocation(line: 1018, column: 9, scope: !184, inlinedAt: !186)
!184 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !185, file: !185, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!185 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!186 = distinct !DILocation(line: 396, column: 10, scope: !187, inlinedAt: !189)
!187 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !188, file: !188, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!188 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!189 = distinct !DILocation(line: 129, column: 24, scope: !190, inlinedAt: !192)
!190 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !191, file: !191, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!191 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!192 = distinct !DILocation(line: 101, column: 14, scope: !193, inlinedAt: !194)
!193 = distinct !DISubprogram(name: "run<float>", scope: !191, file: !191, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!194 = distinct !DILocation(line: 343, column: 19, scope: !40)
!195 = !DILocation(line: 171, column: 37, scope: !196, inlinedAt: !197)
!196 = distinct !DISubprogram(name: "__lane_id", scope: !185, file: !185, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!197 = distinct !DILocation(line: 990, column: 14, scope: !198, inlinedAt: !199)
!198 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !185, file: !185, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!199 = distinct !DILocation(line: 1019, column: 11, scope: !184, inlinedAt: !186)
!200 = !DILocation(line: 171, column: 10, scope: !196, inlinedAt: !197)
!201 = !DILocation(line: 991, column: 20, scope: !198, inlinedAt: !199)
!202 = !DILocation(line: 992, column: 36, scope: !198, inlinedAt: !199)
!203 = !DILocation(line: 992, column: 17, scope: !198, inlinedAt: !199)
!204 = !DILocation(line: 992, column: 11, scope: !198, inlinedAt: !199)
!205 = !DILocation(line: 993, column: 43, scope: !198, inlinedAt: !199)
!206 = !DILocation(line: 993, column: 10, scope: !198, inlinedAt: !199)
!207 = !DILocation(line: 1020, column: 14, scope: !184, inlinedAt: !186)
!208 = !DILocation(line: 25, column: 14, scope: !209, inlinedAt: !210)
!209 = distinct !DISubprogram(name: "operator()<float>", scope: !191, file: !191, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!210 = distinct !DILocation(line: 129, column: 11, scope: !190, inlinedAt: !192)
!211 = !DILocation(line: 1018, column: 9, scope: !184, inlinedAt: !212)
!212 = distinct !DILocation(line: 396, column: 10, scope: !187, inlinedAt: !213)
!213 = distinct !DILocation(line: 129, column: 24, scope: !214, inlinedAt: !215)
!214 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !191, file: !191, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!215 = distinct !DILocation(line: 101, column: 14, scope: !216, inlinedAt: !217)
!216 = distinct !DISubprogram(name: "run<float>", scope: !191, file: !191, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!217 = distinct !DILocation(line: 134, column: 14, scope: !190, inlinedAt: !192)
!218 = !DILocation(line: 171, column: 37, scope: !196, inlinedAt: !219)
!219 = distinct !DILocation(line: 990, column: 14, scope: !198, inlinedAt: !220)
!220 = distinct !DILocation(line: 1019, column: 11, scope: !184, inlinedAt: !212)
!221 = !DILocation(line: 171, column: 10, scope: !196, inlinedAt: !219)
!222 = !DILocation(line: 991, column: 20, scope: !198, inlinedAt: !220)
!223 = !DILocation(line: 992, column: 36, scope: !198, inlinedAt: !220)
!224 = !DILocation(line: 992, column: 17, scope: !198, inlinedAt: !220)
!225 = !DILocation(line: 992, column: 11, scope: !198, inlinedAt: !220)
!226 = !DILocation(line: 993, column: 43, scope: !198, inlinedAt: !220)
!227 = !DILocation(line: 993, column: 10, scope: !198, inlinedAt: !220)
!228 = !DILocation(line: 1020, column: 14, scope: !184, inlinedAt: !212)
!229 = !DILocation(line: 25, column: 14, scope: !209, inlinedAt: !230)
!230 = distinct !DILocation(line: 129, column: 11, scope: !214, inlinedAt: !215)
!231 = !DILocation(line: 345, column: 32, scope: !40)
!232 = !DILocation(line: 345, column: 7, scope: !40)
!233 = !DILocation(line: 353, column: 32, scope: !40)
!234 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !235)
!235 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !236)
!236 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !237)
!237 = distinct !DILocation(line: 359, column: 50, scope: !40)
!238 = !DILocation(line: 359, column: 47, scope: !40)
!239 = !DILocation(line: 364, column: 122, scope: !40)
!240 = !DILocation(line: 364, column: 150, scope: !40)
!241 = !DILocation(line: 364, column: 77, scope: !40)
!242 = !DILocation(line: 364, column: 156, scope: !40)
!243 = !DILocation(line: 364, column: 40, scope: !40)
!244 = !DILocation(line: 364, column: 199, scope: !40)
!245 = !DILocation(line: 364, column: 93, scope: !40)
!246 = !DILocation(line: 68, column: 3, scope: !247, inlinedAt: !248)
!247 = distinct !DISubprogram(name: "__barrier_warp", scope: !185, file: !185, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!248 = distinct !DILocation(line: 192, column: 3, scope: !249, inlinedAt: !250)
!249 = distinct !DISubprogram(name: "__syncwarp", scope: !185, file: !185, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!250 = distinct !DILocation(line: 366, column: 3, scope: !40)
!251 = !DILocation(line: 69, column: 3, scope: !247, inlinedAt: !248)
!252 = !DILocation(line: 70, column: 3, scope: !247, inlinedAt: !248)
!253 = !DILocation(line: 368, column: 8, scope: !40)
!254 = !DILocation(line: 368, column: 3, scope: !40)
!255 = !DILocation(line: 369, column: 22, scope: !40)
!256 = !DILocation(line: 369, column: 132, scope: !40)
!257 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!258 = !{i32 2, i32 -1, i32 -1, i32 -1}
!259 = !DILocation(line: 369, column: 169, scope: !40)
!260 = !DILocation(line: 371, column: 1, scope: !40)
