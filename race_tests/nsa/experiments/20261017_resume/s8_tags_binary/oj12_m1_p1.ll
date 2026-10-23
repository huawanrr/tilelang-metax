; ModuleID = 'experiments/20261017_resume/s8_tags_binary/oj12_m1_p1.bc'
source_filename = "/tmp/tmpo4bwqp2k/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %EncodedIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
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
  %cmp13.not = icmp eq i32 %conv8, 0, !dbg !53
  %and16 = shl i32 %3, 4, !dbg !54
  %mul17 = and i32 %and16, 1008, !dbg !54
  %shr.1 = lshr i64 %2, 8, !dbg !55
  %4 = trunc i64 %shr.1 to i32, !dbg !52
  %conv8.1 = and i32 %4, 255, !dbg !52
  %cmp13.not.1 = icmp eq i32 %conv8.1, 0, !dbg !53
  %and16.1 = shl i32 %4, 4, !dbg !54
  %mul17.1 = and i32 %and16.1, 1008, !dbg !54
  %shr.2 = lshr i64 %2, 16, !dbg !55
  %5 = trunc i64 %shr.2 to i32, !dbg !52
  %conv8.2 = and i32 %5, 255, !dbg !52
  %cmp13.not.2 = icmp eq i32 %conv8.2, 0, !dbg !53
  %and16.2 = shl i32 %5, 4, !dbg !54
  %mul17.2 = and i32 %and16.2, 1008, !dbg !54
  %shr.3 = lshr i64 %2, 24, !dbg !55
  %6 = trunc i64 %shr.3 to i32, !dbg !52
  %conv8.3 = and i32 %6, 255, !dbg !52
  %cmp13.not.3 = icmp eq i32 %conv8.3, 0, !dbg !53
  %and16.3 = shl i32 %6, 4, !dbg !54
  %mul17.3 = and i32 %and16.3, 1008, !dbg !54
  %shr.4 = lshr i64 %2, 32, !dbg !55
  %7 = trunc nuw i64 %shr.4 to i32, !dbg !52
  %conv8.4 = and i32 %7, 255, !dbg !52
  %cmp13.not.4 = icmp eq i32 %conv8.4, 0, !dbg !53
  %and16.4 = shl i32 %7, 4, !dbg !54
  %mul17.4 = and i32 %and16.4, 1008, !dbg !54
  %shr.5 = lshr i64 %2, 40, !dbg !55
  %8 = trunc nuw nsw i64 %shr.5 to i32, !dbg !52
  %conv8.5 = and i32 %8, 255, !dbg !52
  %cmp13.not.5 = icmp eq i32 %conv8.5, 0, !dbg !53
  %and16.5 = shl nuw nsw i32 %8, 4, !dbg !54
  %mul17.5 = and i32 %and16.5, 1008, !dbg !54
  %shr.6 = lshr i64 %2, 48, !dbg !55
  %9 = trunc nuw nsw i64 %shr.6 to i32, !dbg !52
  %conv8.6 = and i32 %9, 255, !dbg !52
  %cmp13.not.6 = icmp eq i32 %conv8.6, 0, !dbg !53
  %and16.6 = shl nuw nsw i32 %9, 4, !dbg !54
  %mul17.6 = and i32 %and16.6, 1008, !dbg !54
  %cmp13.not.7 = icmp ult i64 %2, 72057594037927936, !dbg !53
  %sh.diff = lshr i64 %2, 52, !dbg !54
  %tr.sh.diff = trunc nuw nsw i64 %sh.diff to i32, !dbg !54
  %mul17.7 = and i32 %tr.sh.diff, 1008, !dbg !54
  %mul26 = shl nsw i32 %0, 20
  %mul28 = shl nsw i32 %1, 10
  %add29 = add nuw nsw i32 %mul26, %mul28
  %10 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !56
  %and31 = shl nuw nsw i32 %10, 6
  %mul32 = and i32 %and31, 960
  %add33 = or disjoint i32 %add29, %mul32
  %11 = lshr i32 %10, 1
  %mul38 = and i32 %11, 504
  %add35 = add nuw nsw i32 %add33, %mul38
  %12 = zext nneg i32 %add35 to i64, !dbg !57
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12, !dbg !58
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !59
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !59
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8, !dbg !59
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12, !dbg !58
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 64, !dbg !58
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !59
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %13, i64 72, !dbg !59
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8, !dbg !59
  %invariant.op = add nsw i32 %1, -15, !dbg !60
  %mul109 = shl nsw i32 %0, 16
  %mul116 = shl nuw nsw i32 %10, 3
  %add112 = or disjoint i32 %mul116, %mul109
  %14 = lshr i32 %10, 2
  %mul261 = and i32 %14, 252
  %cmp102.not2153 = icmp ugt i32 %mul17, %1
  %or.cond1260 = select i1 %cmp13.not, i1 true, i1 %cmp102.not2153, !dbg !61
  br i1 %or.cond1260, label %if.end127, label %for.cond104.preheader, !dbg !61

for.cond104.preheader:                            ; preds = %entry
  %15 = shl nuw nsw i32 %mul17, 6
  %add114 = add nuw nsw i32 %add112, %15
  %16 = zext nneg i32 %add114 to i64, !dbg !62
  %add.ptr119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %16, !dbg !63
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr119, align 16, !dbg !64
  %K_reg.sroa.6.0.add.ptr119.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119, i64 8, !dbg !64
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr119.sroa_idx, align 8, !dbg !64
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %16, !dbg !63
  %add.ptr119.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 1024, !dbg !63
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr119.1, align 16, !dbg !64
  %K_reg.sroa.12.16.add.ptr119.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %17, i64 1032, !dbg !64
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr119.1.sroa_idx, align 8, !dbg !64
  br label %if.end127, !dbg !65

if.end127:                                        ; preds = %for.cond104.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond104.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond104.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond104.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond104.preheader ]
  %cmp133.not2154 = icmp ugt i32 %mul17.1, %1
  %or.cond1262 = select i1 %cmp13.not.1, i1 true, i1 %cmp133.not2154, !dbg !65
  br i1 %or.cond1262, label %if.end158, label %for.cond135.preheader, !dbg !65

for.cond135.preheader:                            ; preds = %if.end127
  %18 = shl nuw nsw i32 %mul17.1, 6
  %add145 = add nuw nsw i32 %add112, %18
  %19 = zext nneg i32 %add145 to i64, !dbg !66
  %add.ptr150 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %19, !dbg !67
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr150, align 16, !dbg !68
  %K_reg1.sroa.6.0.add.ptr150.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr150, i64 8, !dbg !68
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr150.sroa_idx, align 8, !dbg !68
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %19, !dbg !67
  %add.ptr150.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 1024, !dbg !67
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr150.1, align 16, !dbg !68
  %K_reg1.sroa.12.16.add.ptr150.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %20, i64 1032, !dbg !68
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr150.1.sroa_idx, align 8, !dbg !68
  br label %if.end158, !dbg !69

if.end158:                                        ; preds = %for.cond135.preheader, %if.end127
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end127 ], [ %K_reg1.sroa.12.16.copyload, %for.cond135.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end127 ], [ %K_reg1.sroa.8.16.copyload, %for.cond135.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end127 ], [ %K_reg1.sroa.6.0.copyload, %for.cond135.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end127 ], [ %K_reg1.sroa.0.0.copyload, %for.cond135.preheader ]
  %cmp164.not2155 = icmp ugt i32 %mul17.2, %1
  %or.cond1264 = select i1 %cmp13.not.2, i1 true, i1 %cmp164.not2155, !dbg !69
  br i1 %or.cond1264, label %if.end189, label %for.cond166.preheader, !dbg !69

for.cond166.preheader:                            ; preds = %if.end158
  %21 = shl nuw nsw i32 %mul17.2, 6
  %add176 = add nuw nsw i32 %add112, %21
  %22 = zext nneg i32 %add176 to i64, !dbg !70
  %add.ptr181 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22, !dbg !71
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr181, align 16, !dbg !72
  %K_reg2.sroa.6.0.add.ptr181.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr181, i64 8, !dbg !72
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr181.sroa_idx, align 8, !dbg !72
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22, !dbg !71
  %add.ptr181.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1024, !dbg !71
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr181.1, align 16, !dbg !72
  %K_reg2.sroa.12.16.add.ptr181.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1032, !dbg !72
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr181.1.sroa_idx, align 8, !dbg !72
  br label %if.end189, !dbg !73

if.end189:                                        ; preds = %for.cond166.preheader, %if.end158
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end158 ], [ %K_reg2.sroa.12.16.copyload, %for.cond166.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end158 ], [ %K_reg2.sroa.8.16.copyload, %for.cond166.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end158 ], [ %K_reg2.sroa.6.0.copyload, %for.cond166.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end158 ], [ %K_reg2.sroa.0.0.copyload, %for.cond166.preheader ]
  %cmp195.not2156 = icmp ugt i32 %mul17.3, %1
  %or.cond1266 = select i1 %cmp13.not.3, i1 true, i1 %cmp195.not2156, !dbg !73
  br i1 %or.cond1266, label %if.end220, label %for.cond197.preheader, !dbg !73

for.cond197.preheader:                            ; preds = %if.end189
  %24 = shl nuw nsw i32 %mul17.3, 6
  %add207 = add nuw nsw i32 %add112, %24
  %25 = zext nneg i32 %add207 to i64, !dbg !74
  %add.ptr212 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %25, !dbg !75
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr212, align 16, !dbg !76
  %K_reg3.sroa.6.0.add.ptr212.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr212, i64 8, !dbg !76
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr212.sroa_idx, align 8, !dbg !76
  %26 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %25, !dbg !75
  %add.ptr212.1 = getelementptr inbounds i8, ptr addrspace(4) %26, i64 1024, !dbg !75
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr212.1, align 16, !dbg !76
  %K_reg3.sroa.12.16.add.ptr212.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %26, i64 1032, !dbg !76
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr212.1.sroa_idx, align 8, !dbg !76
  br label %if.end220, !dbg !77

if.end220:                                        ; preds = %for.cond197.preheader, %if.end189
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end189 ], [ %K_reg3.sroa.12.16.copyload, %for.cond197.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end189 ], [ %K_reg3.sroa.8.16.copyload, %for.cond197.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end189 ], [ %K_reg3.sroa.6.0.copyload, %for.cond197.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end189 ], [ %K_reg3.sroa.0.0.copyload, %for.cond197.preheader ]
  br i1 %or.cond1260, label %if.end366, label %for.cond228.preheader, !dbg !77

for.cond228.preheader:                            ; preds = %if.end220
  %27 = shl nuw nsw i32 %mul17, 6
  %add238 = add nuw nsw i32 %add112, %27
  %28 = zext nneg i32 %add238 to i64, !dbg !78
  %add.ptr243 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %28, !dbg !79
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr243, align 16, !dbg !80
  %V_reg.sroa.18.0.add.ptr243.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr243, i64 8, !dbg !80
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr243.sroa_idx, align 8, !dbg !80
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %28, !dbg !79
  %add.ptr243.1 = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1024, !dbg !79
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr243.1, align 16, !dbg !80
  %V_reg.sroa.42.16.add.ptr243.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1032, !dbg !80
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr243.1.sroa_idx, align 8, !dbg !80
  %cmp253 = icmp sgt i32 %mul17, %invariant.op, !dbg !81
  br i1 %cmp253, label %for.cond255.preheader, label %if.end279, !dbg !82

for.cond255.preheader:                            ; preds = %for.cond228.preheader
  %add262 = add nuw nsw i32 %mul17, %mul261
  %cmp265.not = icmp ugt i32 %add262, %1, !dbg !83
  %fneg. = select i1 %cmp265.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1448 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !84
  %cmp265.not.1.not = icmp ult i32 %add262, %1, !dbg !83
  %fneg..1 = select i1 %cmp265.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1549 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1448, float %fneg..1, i64 1, !dbg !84
  %add263.2 = or disjoint i32 %add262, 2, !dbg !85
  %cmp265.not.2 = icmp ugt i32 %add263.2, %1, !dbg !83
  %fneg..2 = select i1 %cmp265.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1642 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1549, float %fneg..2, i64 2, !dbg !84
  %add263.3 = or disjoint i32 %add262, 3, !dbg !85
  %cmp265.not.3 = icmp ugt i32 %add263.3, %1, !dbg !83
  %fneg..3 = select i1 %cmp265.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1735 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1642, float %fneg..3, i64 3, !dbg !84
  br label %if.end279

if.end279:                                        ; preds = %for.cond228.preheader, %for.cond255.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1735, %for.cond255.preheader ], [ zeroinitializer, %for.cond228.preheader ], !dbg !86
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !87, !call_argsrelate !88
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %30), !dbg !87, !call_argsrelate !88
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %31), !dbg !87, !call_argsrelate !88
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %32), !dbg !87, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0, !dbg !89
  %mul314 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !90
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul314, float 0x4024CB5EC0000000), !dbg !91
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !95
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1, !dbg !89
  %mul314.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !90
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1, float 0x4024CB5EC0000000), !dbg !91
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !95
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2, !dbg !89
  %mul314.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !90
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul314.2, float 0x4024CB5EC0000000), !dbg !91
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !95
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3, !dbg !89
  %mul314.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !90
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul314.3, float 0x4024CB5EC0000000), !dbg !91
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !95
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %35), !dbg !98
  %43 = insertelement <4 x i16> poison, i16 %42, i64 0, !dbg !107
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %37), !dbg !98
  %45 = insertelement <4 x i16> %43, i16 %44, i64 1, !dbg !107
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %39), !dbg !98
  %47 = insertelement <4 x i16> %45, i16 %46, i64 2, !dbg !107
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %41), !dbg !98
  %49 = insertelement <4 x i16> %47, i16 %48, i64 3, !dbg !107
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %49 to <4 x half>, !dbg !107
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !108, !call_argsrelate !109
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !108, !call_argsrelate !109
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !108, !call_argsrelate !109
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !108, !call_argsrelate !109
  br label %if.end366, !dbg !110

if.end366:                                        ; preds = %if.end279, %if.end220
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end220 ], [ %53, %if.end279 ], !dbg !86
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end220 ], [ %52, %if.end279 ], !dbg !86
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end220 ], [ %51, %if.end279 ], !dbg !86
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end220 ], [ %50, %if.end279 ], !dbg !86
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end220 ], [ %41, %if.end279 ], !dbg !86
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end220 ], [ %39, %if.end279 ], !dbg !86
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end220 ], [ %37, %if.end279 ], !dbg !86
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end220 ], [ %35, %if.end279 ], !dbg !86
  br i1 %or.cond1262, label %if.end512, label %for.cond374.preheader, !dbg !110

for.cond374.preheader:                            ; preds = %if.end366
  %54 = shl nuw nsw i32 %mul17.1, 6
  %add384 = add nuw nsw i32 %add112, %54
  %55 = zext nneg i32 %add384 to i64, !dbg !111
  %add.ptr389 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %55, !dbg !112
  %V_reg.sroa.0.0.copyload1820 = load <4 x half>, ptr addrspace(4) %add.ptr389, align 16, !dbg !113
  %V_reg.sroa.18.0.add.ptr389.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr389, i64 8, !dbg !113
  %V_reg.sroa.18.0.copyload1827 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr389.sroa_idx, align 8, !dbg !113
  %56 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %55, !dbg !112
  %add.ptr389.1 = getelementptr inbounds i8, ptr addrspace(4) %56, i64 1024, !dbg !112
  %V_reg.sroa.26.16.copyload1848 = load <4 x half>, ptr addrspace(4) %add.ptr389.1, align 16, !dbg !113
  %V_reg.sroa.42.16.add.ptr389.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %56, i64 1032, !dbg !113
  %V_reg.sroa.42.16.copyload1855 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr389.1.sroa_idx, align 8, !dbg !113
  %cmp399 = icmp sgt i32 %mul17.1, %invariant.op, !dbg !114
  br i1 %cmp399, label %for.cond401.preheader, label %if.end425, !dbg !115

for.cond401.preheader:                            ; preds = %for.cond374.preheader
  %add408 = add nuw nsw i32 %mul17.1, %mul261
  %cmp411.not = icmp ugt i32 %add408, %1, !dbg !116
  %fneg.1175 = select i1 %cmp411.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1457 = insertelement <4 x float> poison, float %fneg.1175, i64 0, !dbg !117
  %cmp411.not.1.not = icmp ult i32 %add408, %1, !dbg !116
  %fneg.1175.1 = select i1 %cmp411.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1558 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1457, float %fneg.1175.1, i64 1, !dbg !117
  %add409.2 = or disjoint i32 %add408, 2, !dbg !118
  %cmp411.not.2 = icmp ugt i32 %add409.2, %1, !dbg !116
  %fneg.1175.2 = select i1 %cmp411.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1651 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1558, float %fneg.1175.2, i64 2, !dbg !117
  %add409.3 = or disjoint i32 %add408, 3, !dbg !118
  %cmp411.not.3 = icmp ugt i32 %add409.3, %1, !dbg !116
  %fneg.1175.3 = select i1 %cmp411.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1744 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1651, float %fneg.1175.3, i64 3, !dbg !117
  br label %if.end425

if.end425:                                        ; preds = %for.cond374.preheader, %for.cond401.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1744, %for.cond401.preheader ], [ zeroinitializer, %for.cond374.preheader ], !dbg !86
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !119, !call_argsrelate !88
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %57), !dbg !119, !call_argsrelate !88
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %58), !dbg !119, !call_argsrelate !88
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %59), !dbg !119, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1459 = extractelement <4 x float> %60, i64 0, !dbg !120
  %mul460 = fmul contract float %acc_s.sroa.0.0.vec.extract1459, 0x3FB99999A0000000, !dbg !121
  %61 = tail call contract noundef float @llvm.minnum.f32(float %mul460, float 0x4024CB5EC0000000), !dbg !122
  %62 = tail call contract noundef float @llvm.exp.f32(float %61), !dbg !124
  %acc_s.sroa.0.4.vec.extract1560 = extractelement <4 x float> %60, i64 1, !dbg !120
  %mul460.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1560, 0x3FB99999A0000000, !dbg !121
  %63 = tail call contract noundef float @llvm.minnum.f32(float %mul460.1, float 0x4024CB5EC0000000), !dbg !122
  %64 = tail call contract noundef float @llvm.exp.f32(float %63), !dbg !124
  %acc_s.sroa.0.8.vec.extract1653 = extractelement <4 x float> %60, i64 2, !dbg !120
  %mul460.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1653, 0x3FB99999A0000000, !dbg !121
  %65 = tail call contract noundef float @llvm.minnum.f32(float %mul460.2, float 0x4024CB5EC0000000), !dbg !122
  %66 = tail call contract noundef float @llvm.exp.f32(float %65), !dbg !124
  %acc_s.sroa.0.12.vec.extract1746 = extractelement <4 x float> %60, i64 3, !dbg !120
  %mul460.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1746, 0x3FB99999A0000000, !dbg !121
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul460.3, float 0x4024CB5EC0000000), !dbg !122
  %68 = tail call contract noundef float @llvm.exp.f32(float %67), !dbg !124
  %add476 = fadd contract float %sum_acc.sroa.0.0, %62, !dbg !126
  %add476.1 = fadd contract float %sum_acc.sroa.20.0, %64, !dbg !126
  %add476.2 = fadd contract float %sum_acc.sroa.38.0, %66, !dbg !126
  %add476.3 = fadd contract float %sum_acc.sroa.56.0, %68, !dbg !126
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %62), !dbg !127
  %70 = insertelement <4 x i16> poison, i16 %69, i64 0, !dbg !131
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %64), !dbg !127
  %72 = insertelement <4 x i16> %70, i16 %71, i64 1, !dbg !131
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %66), !dbg !127
  %74 = insertelement <4 x i16> %72, i16 %73, i64 2, !dbg !131
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %68), !dbg !127
  %76 = insertelement <4 x i16> %74, i16 %75, i64 3, !dbg !131
  %acc_s_cast.sroa.0.6.vec.insert1420 = bitcast <4 x i16> %76 to <4 x half>, !dbg !131
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1820, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1420, <4 x float> zeroinitializer), !dbg !132, !call_argsrelate !109
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1827, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1420, <4 x float> zeroinitializer), !dbg !132, !call_argsrelate !109
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1848, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1420, <4 x float> zeroinitializer), !dbg !132, !call_argsrelate !109
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1855, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1420, <4 x float> zeroinitializer), !dbg !132, !call_argsrelate !109
  br label %if.end512, !dbg !133

if.end512:                                        ; preds = %if.end425, %if.end366
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end366 ], [ %80, %if.end425 ], !dbg !86
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end366 ], [ %79, %if.end425 ], !dbg !86
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end366 ], [ %78, %if.end425 ], !dbg !86
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end366 ], [ %77, %if.end425 ], !dbg !86
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end366 ], [ %add476.3, %if.end425 ], !dbg !86
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end366 ], [ %add476.2, %if.end425 ], !dbg !86
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end366 ], [ %add476.1, %if.end425 ], !dbg !86
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end366 ], [ %add476, %if.end425 ], !dbg !86
  br i1 %or.cond1264, label %if.end658, label %for.cond520.preheader, !dbg !133

for.cond520.preheader:                            ; preds = %if.end512
  %81 = shl nuw nsw i32 %mul17.2, 6
  %add530 = add nuw nsw i32 %add112, %81
  %82 = zext nneg i32 %add530 to i64, !dbg !134
  %add.ptr535 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %82, !dbg !135
  %V_reg.sroa.0.0.copyload1821 = load <4 x half>, ptr addrspace(4) %add.ptr535, align 16, !dbg !136
  %V_reg.sroa.18.0.add.ptr535.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr535, i64 8, !dbg !136
  %V_reg.sroa.18.0.copyload1828 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr535.sroa_idx, align 8, !dbg !136
  %83 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %82, !dbg !135
  %add.ptr535.1 = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1024, !dbg !135
  %V_reg.sroa.26.16.copyload1849 = load <4 x half>, ptr addrspace(4) %add.ptr535.1, align 16, !dbg !136
  %V_reg.sroa.42.16.add.ptr535.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1032, !dbg !136
  %V_reg.sroa.42.16.copyload1856 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr535.1.sroa_idx, align 8, !dbg !136
  %cmp545 = icmp sgt i32 %mul17.2, %invariant.op, !dbg !137
  br i1 %cmp545, label %for.cond547.preheader, label %if.end571, !dbg !138

for.cond547.preheader:                            ; preds = %for.cond520.preheader
  %add554 = add nuw nsw i32 %mul17.2, %mul261
  %cmp557.not = icmp ugt i32 %add554, %1, !dbg !139
  %fneg.1176 = select i1 %cmp557.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1467 = insertelement <4 x float> poison, float %fneg.1176, i64 0, !dbg !140
  %cmp557.not.1.not = icmp ult i32 %add554, %1, !dbg !139
  %fneg.1176.1 = select i1 %cmp557.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1568 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1467, float %fneg.1176.1, i64 1, !dbg !140
  %add555.2 = or disjoint i32 %add554, 2, !dbg !141
  %cmp557.not.2 = icmp ugt i32 %add555.2, %1, !dbg !139
  %fneg.1176.2 = select i1 %cmp557.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1661 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1568, float %fneg.1176.2, i64 2, !dbg !140
  %add555.3 = or disjoint i32 %add554, 3, !dbg !141
  %cmp557.not.3 = icmp ugt i32 %add555.3, %1, !dbg !139
  %fneg.1176.3 = select i1 %cmp557.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1754 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1661, float %fneg.1176.3, i64 3, !dbg !140
  br label %if.end571

if.end571:                                        ; preds = %for.cond520.preheader, %for.cond547.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1754, %for.cond547.preheader ], [ zeroinitializer, %for.cond520.preheader ], !dbg !86
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !142, !call_argsrelate !88
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %84), !dbg !142, !call_argsrelate !88
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %85), !dbg !142, !call_argsrelate !88
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %86), !dbg !142, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1469 = extractelement <4 x float> %87, i64 0, !dbg !143
  %mul606 = fmul contract float %acc_s.sroa.0.0.vec.extract1469, 0x3FB99999A0000000, !dbg !144
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul606, float 0x4024CB5EC0000000), !dbg !145
  %89 = tail call contract noundef float @llvm.exp.f32(float %88), !dbg !147
  %acc_s.sroa.0.4.vec.extract1570 = extractelement <4 x float> %87, i64 1, !dbg !143
  %mul606.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1570, 0x3FB99999A0000000, !dbg !144
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul606.1, float 0x4024CB5EC0000000), !dbg !145
  %91 = tail call contract noundef float @llvm.exp.f32(float %90), !dbg !147
  %acc_s.sroa.0.8.vec.extract1663 = extractelement <4 x float> %87, i64 2, !dbg !143
  %mul606.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1663, 0x3FB99999A0000000, !dbg !144
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul606.2, float 0x4024CB5EC0000000), !dbg !145
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !147
  %acc_s.sroa.0.12.vec.extract1756 = extractelement <4 x float> %87, i64 3, !dbg !143
  %mul606.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1756, 0x3FB99999A0000000, !dbg !144
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul606.3, float 0x4024CB5EC0000000), !dbg !145
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !147
  %add622 = fadd contract float %sum_acc.sroa.0.1, %89, !dbg !149
  %add622.1 = fadd contract float %sum_acc.sroa.20.1, %91, !dbg !149
  %add622.2 = fadd contract float %sum_acc.sroa.38.1, %93, !dbg !149
  %add622.3 = fadd contract float %sum_acc.sroa.56.1, %95, !dbg !149
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %89), !dbg !150
  %97 = insertelement <4 x i16> poison, i16 %96, i64 0, !dbg !154
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91), !dbg !150
  %99 = insertelement <4 x i16> %97, i16 %98, i64 1, !dbg !154
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !150
  %101 = insertelement <4 x i16> %99, i16 %100, i64 2, !dbg !154
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !150
  %103 = insertelement <4 x i16> %101, i16 %102, i64 3, !dbg !154
  %acc_s_cast.sroa.0.6.vec.insert1422 = bitcast <4 x i16> %103 to <4 x half>, !dbg !154
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1821, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1422, <4 x float> %acc_o.sroa.0.0), !dbg !155, !call_argsrelate !109
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1828, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1422, <4 x float> %acc_o.sroa.34.0), !dbg !155, !call_argsrelate !109
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1849, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1422, <4 x float> %acc_o.sroa.66.0), !dbg !155, !call_argsrelate !109
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1856, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1422, <4 x float> %acc_o.sroa.98.0), !dbg !155, !call_argsrelate !109
  br label %if.end658, !dbg !156

if.end658:                                        ; preds = %if.end571, %if.end512
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end512 ], [ %107, %if.end571 ], !dbg !86
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end512 ], [ %106, %if.end571 ], !dbg !86
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end512 ], [ %105, %if.end571 ], !dbg !86
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end512 ], [ %104, %if.end571 ], !dbg !86
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end512 ], [ %add622.3, %if.end571 ], !dbg !86
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end512 ], [ %add622.2, %if.end571 ], !dbg !86
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end512 ], [ %add622.1, %if.end571 ], !dbg !86
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end512 ], [ %add622, %if.end571 ], !dbg !86
  br i1 %or.cond1266, label %if.end804, label %for.cond666.preheader, !dbg !156

for.cond666.preheader:                            ; preds = %if.end658
  %108 = shl nuw nsw i32 %mul17.3, 6
  %add676 = add nuw nsw i32 %add112, %108
  %109 = zext nneg i32 %add676 to i64, !dbg !157
  %add.ptr681 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %109, !dbg !158
  %V_reg.sroa.0.0.copyload1822 = load <4 x half>, ptr addrspace(4) %add.ptr681, align 16, !dbg !159
  %V_reg.sroa.18.0.add.ptr681.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr681, i64 8, !dbg !159
  %V_reg.sroa.18.0.copyload1829 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr681.sroa_idx, align 8, !dbg !159
  %110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %109, !dbg !158
  %add.ptr681.1 = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1024, !dbg !158
  %V_reg.sroa.26.16.copyload1850 = load <4 x half>, ptr addrspace(4) %add.ptr681.1, align 16, !dbg !159
  %V_reg.sroa.42.16.add.ptr681.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1032, !dbg !159
  %V_reg.sroa.42.16.copyload1857 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr681.1.sroa_idx, align 8, !dbg !159
  %cmp691 = icmp sgt i32 %mul17.3, %invariant.op, !dbg !160
  br i1 %cmp691, label %for.cond693.preheader, label %if.end717, !dbg !161

for.cond693.preheader:                            ; preds = %for.cond666.preheader
  %add700 = add nuw nsw i32 %mul17.3, %mul261
  %cmp703.not = icmp ugt i32 %add700, %1, !dbg !162
  %fneg.1177 = select i1 %cmp703.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1477 = insertelement <4 x float> poison, float %fneg.1177, i64 0, !dbg !163
  %cmp703.not.1.not = icmp ult i32 %add700, %1, !dbg !162
  %fneg.1177.1 = select i1 %cmp703.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1578 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1477, float %fneg.1177.1, i64 1, !dbg !163
  %add701.2 = or disjoint i32 %add700, 2, !dbg !164
  %cmp703.not.2 = icmp ugt i32 %add701.2, %1, !dbg !162
  %fneg.1177.2 = select i1 %cmp703.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1671 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1578, float %fneg.1177.2, i64 2, !dbg !163
  %add701.3 = or disjoint i32 %add700, 3, !dbg !164
  %cmp703.not.3 = icmp ugt i32 %add701.3, %1, !dbg !162
  %fneg.1177.3 = select i1 %cmp703.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1764 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1671, float %fneg.1177.3, i64 3, !dbg !163
  br label %if.end717

if.end717:                                        ; preds = %for.cond666.preheader, %for.cond693.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1764, %for.cond693.preheader ], [ zeroinitializer, %for.cond666.preheader ], !dbg !86
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !165, !call_argsrelate !88
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %111), !dbg !165, !call_argsrelate !88
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %112), !dbg !165, !call_argsrelate !88
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %113), !dbg !165, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1479 = extractelement <4 x float> %114, i64 0, !dbg !166
  %mul752 = fmul contract float %acc_s.sroa.0.0.vec.extract1479, 0x3FB99999A0000000, !dbg !167
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul752, float 0x4024CB5EC0000000), !dbg !168
  %116 = tail call contract noundef float @llvm.exp.f32(float %115), !dbg !170
  %acc_s.sroa.0.4.vec.extract1580 = extractelement <4 x float> %114, i64 1, !dbg !166
  %mul752.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1580, 0x3FB99999A0000000, !dbg !167
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul752.1, float 0x4024CB5EC0000000), !dbg !168
  %118 = tail call contract noundef float @llvm.exp.f32(float %117), !dbg !170
  %acc_s.sroa.0.8.vec.extract1673 = extractelement <4 x float> %114, i64 2, !dbg !166
  %mul752.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1673, 0x3FB99999A0000000, !dbg !167
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul752.2, float 0x4024CB5EC0000000), !dbg !168
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !170
  %acc_s.sroa.0.12.vec.extract1766 = extractelement <4 x float> %114, i64 3, !dbg !166
  %mul752.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1766, 0x3FB99999A0000000, !dbg !167
  %121 = tail call contract noundef float @llvm.minnum.f32(float %mul752.3, float 0x4024CB5EC0000000), !dbg !168
  %122 = tail call contract noundef float @llvm.exp.f32(float %121), !dbg !170
  %add768 = fadd contract float %sum_acc.sroa.0.2, %116, !dbg !172
  %add768.1 = fadd contract float %sum_acc.sroa.20.2, %118, !dbg !172
  %add768.2 = fadd contract float %sum_acc.sroa.38.2, %120, !dbg !172
  %add768.3 = fadd contract float %sum_acc.sroa.56.2, %122, !dbg !172
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116), !dbg !173
  %124 = insertelement <4 x i16> poison, i16 %123, i64 0, !dbg !177
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118), !dbg !173
  %126 = insertelement <4 x i16> %124, i16 %125, i64 1, !dbg !177
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !173
  %128 = insertelement <4 x i16> %126, i16 %127, i64 2, !dbg !177
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %122), !dbg !173
  %130 = insertelement <4 x i16> %128, i16 %129, i64 3, !dbg !177
  %acc_s_cast.sroa.0.6.vec.insert1424 = bitcast <4 x i16> %130 to <4 x half>, !dbg !177
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1822, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1424, <4 x float> %acc_o_alt.sroa.0.0), !dbg !178, !call_argsrelate !109
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1829, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1424, <4 x float> %acc_o_alt.sroa.18.0), !dbg !178, !call_argsrelate !109
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1850, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1424, <4 x float> %acc_o_alt.sroa.34.0), !dbg !178, !call_argsrelate !109
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1857, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1424, <4 x float> %acc_o_alt.sroa.50.0), !dbg !178, !call_argsrelate !109
  br label %if.end804, !dbg !179

if.end804:                                        ; preds = %if.end717, %if.end658
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end658 ], [ %134, %if.end717 ], !dbg !86
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end658 ], [ %133, %if.end717 ], !dbg !86
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end658 ], [ %132, %if.end717 ], !dbg !86
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end658 ], [ %131, %if.end717 ], !dbg !86
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end658 ], [ %add768.3, %if.end717 ], !dbg !86
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end658 ], [ %add768.2, %if.end717 ], !dbg !86
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end658 ], [ %add768.1, %if.end717 ], !dbg !86
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end658 ], [ %add768, %if.end717 ], !dbg !86
  %cmp102.not.12157 = icmp ugt i32 %mul17.4, %1
  %or.cond1260.1 = select i1 %cmp13.not.4, i1 true, i1 %cmp102.not.12157, !dbg !61
  br i1 %or.cond1260.1, label %if.end127.1, label %for.cond104.preheader.1, !dbg !61

for.cond104.preheader.1:                          ; preds = %if.end804
  %135 = shl nuw nsw i32 %mul17.4, 6
  %add114.1 = add nuw nsw i32 %add112, %135
  %136 = zext nneg i32 %add114.1 to i64, !dbg !62
  %add.ptr119.11324 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136, !dbg !63
  %K_reg.sroa.0.0.copyload1894 = load <4 x half>, ptr addrspace(4) %add.ptr119.11324, align 16, !dbg !64
  %K_reg.sroa.6.0.add.ptr119.11324.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119.11324, i64 8, !dbg !64
  %K_reg.sroa.6.0.copyload1895 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr119.11324.sroa_idx, align 8, !dbg !64
  %137 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136, !dbg !63
  %add.ptr119.1.1 = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1024, !dbg !63
  %K_reg.sroa.8.16.copyload1898 = load <4 x half>, ptr addrspace(4) %add.ptr119.1.1, align 16, !dbg !64
  %K_reg.sroa.12.16.add.ptr119.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1032, !dbg !64
  %K_reg.sroa.12.16.copyload1899 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr119.1.1.sroa_idx, align 8, !dbg !64
  br label %if.end127.1, !dbg !65

if.end127.1:                                      ; preds = %for.cond104.preheader.1, %if.end804
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end804 ], [ %K_reg.sroa.12.16.copyload1899, %for.cond104.preheader.1 ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end804 ], [ %K_reg.sroa.8.16.copyload1898, %for.cond104.preheader.1 ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end804 ], [ %K_reg.sroa.6.0.copyload1895, %for.cond104.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end804 ], [ %K_reg.sroa.0.0.copyload1894, %for.cond104.preheader.1 ]
  %cmp133.not.12158 = icmp ugt i32 %mul17.5, %1
  %or.cond1262.1 = select i1 %cmp13.not.5, i1 true, i1 %cmp133.not.12158, !dbg !65
  br i1 %or.cond1262.1, label %if.end158.1, label %for.cond135.preheader.1, !dbg !65

for.cond135.preheader.1:                          ; preds = %if.end127.1
  %138 = shl nuw nsw i32 %mul17.5, 6
  %add145.1 = add nuw nsw i32 %add112, %138
  %139 = zext nneg i32 %add145.1 to i64, !dbg !66
  %add.ptr150.11325 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %139, !dbg !67
  %K_reg1.sroa.0.0.copyload1886 = load <4 x half>, ptr addrspace(4) %add.ptr150.11325, align 16, !dbg !68
  %K_reg1.sroa.6.0.add.ptr150.11325.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr150.11325, i64 8, !dbg !68
  %K_reg1.sroa.6.0.copyload1887 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr150.11325.sroa_idx, align 8, !dbg !68
  %140 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %139, !dbg !67
  %add.ptr150.1.1 = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1024, !dbg !67
  %K_reg1.sroa.8.16.copyload1890 = load <4 x half>, ptr addrspace(4) %add.ptr150.1.1, align 16, !dbg !68
  %K_reg1.sroa.12.16.add.ptr150.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1032, !dbg !68
  %K_reg1.sroa.12.16.copyload1891 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr150.1.1.sroa_idx, align 8, !dbg !68
  br label %if.end158.1, !dbg !69

if.end158.1:                                      ; preds = %for.cond135.preheader.1, %if.end127.1
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end127.1 ], [ %K_reg1.sroa.12.16.copyload1891, %for.cond135.preheader.1 ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end127.1 ], [ %K_reg1.sroa.8.16.copyload1890, %for.cond135.preheader.1 ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end127.1 ], [ %K_reg1.sroa.6.0.copyload1887, %for.cond135.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end127.1 ], [ %K_reg1.sroa.0.0.copyload1886, %for.cond135.preheader.1 ]
  %cmp164.not.12159 = icmp ugt i32 %mul17.6, %1
  %or.cond1264.1 = select i1 %cmp13.not.6, i1 true, i1 %cmp164.not.12159, !dbg !69
  br i1 %or.cond1264.1, label %if.end189.1, label %for.cond166.preheader.1, !dbg !69

for.cond166.preheader.1:                          ; preds = %if.end158.1
  %141 = shl nuw nsw i32 %9, 10
  %mul173.1 = and i32 %141, 64512
  %add176.1 = add nuw nsw i32 %add112, %mul173.1
  %142 = zext nneg i32 %add176.1 to i64, !dbg !70
  %add.ptr181.11326 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %142, !dbg !71
  %K_reg2.sroa.0.0.copyload1878 = load <4 x half>, ptr addrspace(4) %add.ptr181.11326, align 16, !dbg !72
  %K_reg2.sroa.6.0.add.ptr181.11326.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr181.11326, i64 8, !dbg !72
  %K_reg2.sroa.6.0.copyload1879 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr181.11326.sroa_idx, align 8, !dbg !72
  %143 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %142, !dbg !71
  %add.ptr181.1.1 = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1024, !dbg !71
  %K_reg2.sroa.8.16.copyload1882 = load <4 x half>, ptr addrspace(4) %add.ptr181.1.1, align 16, !dbg !72
  %K_reg2.sroa.12.16.add.ptr181.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1032, !dbg !72
  %K_reg2.sroa.12.16.copyload1883 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr181.1.1.sroa_idx, align 8, !dbg !72
  br label %if.end189.1, !dbg !73

if.end189.1:                                      ; preds = %for.cond166.preheader.1, %if.end158.1
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end158.1 ], [ %K_reg2.sroa.12.16.copyload1883, %for.cond166.preheader.1 ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end158.1 ], [ %K_reg2.sroa.8.16.copyload1882, %for.cond166.preheader.1 ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end158.1 ], [ %K_reg2.sroa.6.0.copyload1879, %for.cond166.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end158.1 ], [ %K_reg2.sroa.0.0.copyload1878, %for.cond166.preheader.1 ]
  %cmp195.not.12160 = icmp ugt i32 %mul17.7, %1
  %or.cond1266.1 = select i1 %cmp13.not.7, i1 true, i1 %cmp195.not.12160, !dbg !73
  br i1 %or.cond1266.1, label %if.end220.1, label %for.cond197.preheader.1, !dbg !73

for.cond197.preheader.1:                          ; preds = %if.end189.1
  %144 = shl nuw nsw i32 %tr.sh.diff, 6
  %mul204.1 = and i32 %144, 64512
  %add207.1 = add nuw nsw i32 %add112, %mul204.1
  %145 = zext nneg i32 %add207.1 to i64, !dbg !74
  %add.ptr212.11327 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %145, !dbg !75
  %K_reg3.sroa.0.0.copyload1870 = load <4 x half>, ptr addrspace(4) %add.ptr212.11327, align 16, !dbg !76
  %K_reg3.sroa.6.0.add.ptr212.11327.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr212.11327, i64 8, !dbg !76
  %K_reg3.sroa.6.0.copyload1871 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr212.11327.sroa_idx, align 8, !dbg !76
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %145, !dbg !75
  %add.ptr212.1.1 = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1024, !dbg !75
  %K_reg3.sroa.8.16.copyload1874 = load <4 x half>, ptr addrspace(4) %add.ptr212.1.1, align 16, !dbg !76
  %K_reg3.sroa.12.16.add.ptr212.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1032, !dbg !76
  %K_reg3.sroa.12.16.copyload1875 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr212.1.1.sroa_idx, align 8, !dbg !76
  br label %if.end220.1, !dbg !77

if.end220.1:                                      ; preds = %for.cond197.preheader.1, %if.end189.1
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end189.1 ], [ %K_reg3.sroa.12.16.copyload1875, %for.cond197.preheader.1 ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end189.1 ], [ %K_reg3.sroa.8.16.copyload1874, %for.cond197.preheader.1 ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end189.1 ], [ %K_reg3.sroa.6.0.copyload1871, %for.cond197.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end189.1 ], [ %K_reg3.sroa.0.0.copyload1870, %for.cond197.preheader.1 ]
  br i1 %or.cond1260.1, label %if.end366.1, label %for.cond228.preheader.1, !dbg !77

for.cond228.preheader.1:                          ; preds = %if.end220.1
  %147 = shl nuw nsw i32 %mul17.4, 6
  %add238.1 = add nuw nsw i32 %add112, %147
  %148 = zext nneg i32 %add238.1 to i64, !dbg !78
  %add.ptr243.11328 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %148, !dbg !79
  %V_reg.sroa.0.0.copyload1823 = load <4 x half>, ptr addrspace(4) %add.ptr243.11328, align 16, !dbg !80
  %V_reg.sroa.18.0.add.ptr243.11328.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr243.11328, i64 8, !dbg !80
  %V_reg.sroa.18.0.copyload1830 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr243.11328.sroa_idx, align 8, !dbg !80
  %149 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %148, !dbg !79
  %add.ptr243.1.1 = getelementptr inbounds i8, ptr addrspace(4) %149, i64 1024, !dbg !79
  %V_reg.sroa.26.16.copyload1851 = load <4 x half>, ptr addrspace(4) %add.ptr243.1.1, align 16, !dbg !80
  %V_reg.sroa.42.16.add.ptr243.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %149, i64 1032, !dbg !80
  %V_reg.sroa.42.16.copyload1858 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr243.1.1.sroa_idx, align 8, !dbg !80
  %cmp253.1 = icmp sgt i32 %mul17.4, %invariant.op, !dbg !81
  br i1 %cmp253.1, label %for.cond255.preheader.1, label %if.end279.1, !dbg !82

for.cond255.preheader.1:                          ; preds = %for.cond228.preheader.1
  %add262.1 = add nuw nsw i32 %mul17.4, %mul261
  %cmp265.not.11329 = icmp ugt i32 %add262.1, %1, !dbg !83
  %fneg..11330 = select i1 %cmp265.not.11329, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1489 = insertelement <4 x float> poison, float %fneg..11330, i64 0, !dbg !84
  %cmp265.not.1.1.not = icmp ult i32 %add262.1, %1, !dbg !83
  %fneg..1.1 = select i1 %cmp265.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1588 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1489, float %fneg..1.1, i64 1, !dbg !84
  %add263.2.1 = or disjoint i32 %add262.1, 2, !dbg !85
  %cmp265.not.2.1 = icmp ugt i32 %add263.2.1, %1, !dbg !83
  %fneg..2.1 = select i1 %cmp265.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1681 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1588, float %fneg..2.1, i64 2, !dbg !84
  %add263.3.1 = or disjoint i32 %add262.1, 3, !dbg !85
  %cmp265.not.3.1 = icmp ugt i32 %add263.3.1, %1, !dbg !83
  %fneg..3.1 = select i1 %cmp265.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1774 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1681, float %fneg..3.1, i64 3, !dbg !84
  br label %if.end279.1

if.end279.1:                                      ; preds = %for.cond228.preheader.1, %for.cond255.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1774, %for.cond255.preheader.1 ], [ zeroinitializer, %for.cond228.preheader.1 ], !dbg !86
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !87, !call_argsrelate !88
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %150), !dbg !87, !call_argsrelate !88
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %151), !dbg !87, !call_argsrelate !88
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %152), !dbg !87, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1491 = extractelement <4 x float> %153, i64 0, !dbg !89
  %mul314.11334 = fmul contract float %acc_s.sroa.0.0.vec.extract1491, 0x3FB99999A0000000, !dbg !90
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul314.11334, float 0x4024CB5EC0000000), !dbg !91
  %155 = tail call contract noundef float @llvm.exp.f32(float %154), !dbg !95
  %acc_s.sroa.0.4.vec.extract1590 = extractelement <4 x float> %153, i64 1, !dbg !89
  %mul314.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1590, 0x3FB99999A0000000, !dbg !90
  %156 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1.1, float 0x4024CB5EC0000000), !dbg !91
  %157 = tail call contract noundef float @llvm.exp.f32(float %156), !dbg !95
  %acc_s.sroa.0.8.vec.extract1683 = extractelement <4 x float> %153, i64 2, !dbg !89
  %mul314.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1683, 0x3FB99999A0000000, !dbg !90
  %158 = tail call contract noundef float @llvm.minnum.f32(float %mul314.2.1, float 0x4024CB5EC0000000), !dbg !91
  %159 = tail call contract noundef float @llvm.exp.f32(float %158), !dbg !95
  %acc_s.sroa.0.12.vec.extract1776 = extractelement <4 x float> %153, i64 3, !dbg !89
  %mul314.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1776, 0x3FB99999A0000000, !dbg !90
  %160 = tail call contract noundef float @llvm.minnum.f32(float %mul314.3.1, float 0x4024CB5EC0000000), !dbg !91
  %161 = tail call contract noundef float @llvm.exp.f32(float %160), !dbg !95
  %add330.11335 = fadd contract float %sum_acc.sroa.0.3, %155, !dbg !180
  %add330.1.1 = fadd contract float %sum_acc.sroa.20.3, %157, !dbg !180
  %add330.2.1 = fadd contract float %sum_acc.sroa.38.3, %159, !dbg !180
  %add330.3.1 = fadd contract float %sum_acc.sroa.56.3, %161, !dbg !180
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155), !dbg !98
  %163 = insertelement <4 x i16> poison, i16 %162, i64 0, !dbg !107
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %157), !dbg !98
  %165 = insertelement <4 x i16> %163, i16 %164, i64 1, !dbg !107
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %159), !dbg !98
  %167 = insertelement <4 x i16> %165, i16 %166, i64 2, !dbg !107
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %161), !dbg !98
  %169 = insertelement <4 x i16> %167, i16 %168, i64 3, !dbg !107
  %acc_s_cast.sroa.0.6.vec.insert1426 = bitcast <4 x i16> %169 to <4 x half>, !dbg !107
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1823, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1426, <4 x float> %acc_o.sroa.0.1), !dbg !108, !call_argsrelate !109
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1830, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1426, <4 x float> %acc_o.sroa.34.1), !dbg !108, !call_argsrelate !109
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1851, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1426, <4 x float> %acc_o.sroa.66.1), !dbg !108, !call_argsrelate !109
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1858, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1426, <4 x float> %acc_o.sroa.98.1), !dbg !108, !call_argsrelate !109
  br label %if.end366.1, !dbg !110

if.end366.1:                                      ; preds = %if.end279.1, %if.end220.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end220.1 ], [ %173, %if.end279.1 ], !dbg !86
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end220.1 ], [ %172, %if.end279.1 ], !dbg !86
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end220.1 ], [ %171, %if.end279.1 ], !dbg !86
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end220.1 ], [ %170, %if.end279.1 ], !dbg !86
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end220.1 ], [ %add330.3.1, %if.end279.1 ], !dbg !86
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end220.1 ], [ %add330.2.1, %if.end279.1 ], !dbg !86
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end220.1 ], [ %add330.1.1, %if.end279.1 ], !dbg !86
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end220.1 ], [ %add330.11335, %if.end279.1 ], !dbg !86
  br i1 %or.cond1262.1, label %if.end512.1, label %for.cond374.preheader.1, !dbg !110

for.cond374.preheader.1:                          ; preds = %if.end366.1
  %174 = shl nuw nsw i32 %mul17.5, 6
  %add384.1 = add nuw nsw i32 %add112, %174
  %175 = zext nneg i32 %add384.1 to i64, !dbg !111
  %add.ptr389.11336 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %175, !dbg !112
  %V_reg.sroa.0.0.copyload1824 = load <4 x half>, ptr addrspace(4) %add.ptr389.11336, align 16, !dbg !113
  %V_reg.sroa.18.0.add.ptr389.11336.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr389.11336, i64 8, !dbg !113
  %V_reg.sroa.18.0.copyload1831 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr389.11336.sroa_idx, align 8, !dbg !113
  %176 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %175, !dbg !112
  %add.ptr389.1.1 = getelementptr inbounds i8, ptr addrspace(4) %176, i64 1024, !dbg !112
  %V_reg.sroa.26.16.copyload1852 = load <4 x half>, ptr addrspace(4) %add.ptr389.1.1, align 16, !dbg !113
  %V_reg.sroa.42.16.add.ptr389.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %176, i64 1032, !dbg !113
  %V_reg.sroa.42.16.copyload1859 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr389.1.1.sroa_idx, align 8, !dbg !113
  %cmp399.1 = icmp sgt i32 %mul17.5, %invariant.op, !dbg !114
  br i1 %cmp399.1, label %for.cond401.preheader.1, label %if.end425.1, !dbg !115

for.cond401.preheader.1:                          ; preds = %for.cond374.preheader.1
  %add408.1 = add nuw nsw i32 %mul17.5, %mul261
  %cmp411.not.11337 = icmp ugt i32 %add408.1, %1, !dbg !116
  %fneg.1175.11338 = select i1 %cmp411.not.11337, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1501 = insertelement <4 x float> poison, float %fneg.1175.11338, i64 0, !dbg !117
  %cmp411.not.1.1.not = icmp ult i32 %add408.1, %1, !dbg !116
  %fneg.1175.1.1 = select i1 %cmp411.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1598 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1501, float %fneg.1175.1.1, i64 1, !dbg !117
  %add409.2.1 = or disjoint i32 %add408.1, 2, !dbg !118
  %cmp411.not.2.1 = icmp ugt i32 %add409.2.1, %1, !dbg !116
  %fneg.1175.2.1 = select i1 %cmp411.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1691 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1598, float %fneg.1175.2.1, i64 2, !dbg !117
  %add409.3.1 = or disjoint i32 %add408.1, 3, !dbg !118
  %cmp411.not.3.1 = icmp ugt i32 %add409.3.1, %1, !dbg !116
  %fneg.1175.3.1 = select i1 %cmp411.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1784 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1691, float %fneg.1175.3.1, i64 3, !dbg !117
  br label %if.end425.1

if.end425.1:                                      ; preds = %for.cond374.preheader.1, %for.cond401.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1784, %for.cond401.preheader.1 ], [ zeroinitializer, %for.cond374.preheader.1 ], !dbg !86
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !119, !call_argsrelate !88
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %177), !dbg !119, !call_argsrelate !88
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %178), !dbg !119, !call_argsrelate !88
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %179), !dbg !119, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1503 = extractelement <4 x float> %180, i64 0, !dbg !120
  %mul460.11342 = fmul contract float %acc_s.sroa.0.0.vec.extract1503, 0x3FB99999A0000000, !dbg !121
  %181 = tail call contract noundef float @llvm.minnum.f32(float %mul460.11342, float 0x4024CB5EC0000000), !dbg !122
  %182 = tail call contract noundef float @llvm.exp.f32(float %181), !dbg !124
  %acc_s.sroa.0.4.vec.extract1600 = extractelement <4 x float> %180, i64 1, !dbg !120
  %mul460.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1600, 0x3FB99999A0000000, !dbg !121
  %183 = tail call contract noundef float @llvm.minnum.f32(float %mul460.1.1, float 0x4024CB5EC0000000), !dbg !122
  %184 = tail call contract noundef float @llvm.exp.f32(float %183), !dbg !124
  %acc_s.sroa.0.8.vec.extract1693 = extractelement <4 x float> %180, i64 2, !dbg !120
  %mul460.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1693, 0x3FB99999A0000000, !dbg !121
  %185 = tail call contract noundef float @llvm.minnum.f32(float %mul460.2.1, float 0x4024CB5EC0000000), !dbg !122
  %186 = tail call contract noundef float @llvm.exp.f32(float %185), !dbg !124
  %acc_s.sroa.0.12.vec.extract1786 = extractelement <4 x float> %180, i64 3, !dbg !120
  %mul460.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1786, 0x3FB99999A0000000, !dbg !121
  %187 = tail call contract noundef float @llvm.minnum.f32(float %mul460.3.1, float 0x4024CB5EC0000000), !dbg !122
  %188 = tail call contract noundef float @llvm.exp.f32(float %187), !dbg !124
  %add476.11343 = fadd contract float %sum_acc.sroa.0.4, %182, !dbg !126
  %add476.1.1 = fadd contract float %sum_acc.sroa.20.4, %184, !dbg !126
  %add476.2.1 = fadd contract float %sum_acc.sroa.38.4, %186, !dbg !126
  %add476.3.1 = fadd contract float %sum_acc.sroa.56.4, %188, !dbg !126
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %182), !dbg !127
  %190 = insertelement <4 x i16> poison, i16 %189, i64 0, !dbg !131
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %184), !dbg !127
  %192 = insertelement <4 x i16> %190, i16 %191, i64 1, !dbg !131
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %186), !dbg !127
  %194 = insertelement <4 x i16> %192, i16 %193, i64 2, !dbg !131
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %188), !dbg !127
  %196 = insertelement <4 x i16> %194, i16 %195, i64 3, !dbg !131
  %acc_s_cast.sroa.0.6.vec.insert1428 = bitcast <4 x i16> %196 to <4 x half>, !dbg !131
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1824, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1428, <4 x float> %acc_o_alt.sroa.0.1), !dbg !132, !call_argsrelate !109
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1831, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1428, <4 x float> %acc_o_alt.sroa.18.1), !dbg !132, !call_argsrelate !109
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1852, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1428, <4 x float> %acc_o_alt.sroa.34.1), !dbg !132, !call_argsrelate !109
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1859, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1428, <4 x float> %acc_o_alt.sroa.50.1), !dbg !132, !call_argsrelate !109
  br label %if.end512.1, !dbg !133

if.end512.1:                                      ; preds = %if.end425.1, %if.end366.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end366.1 ], [ %200, %if.end425.1 ], !dbg !86
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end366.1 ], [ %199, %if.end425.1 ], !dbg !86
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end366.1 ], [ %198, %if.end425.1 ], !dbg !86
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end366.1 ], [ %197, %if.end425.1 ], !dbg !86
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end366.1 ], [ %add476.3.1, %if.end425.1 ], !dbg !86
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end366.1 ], [ %add476.2.1, %if.end425.1 ], !dbg !86
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end366.1 ], [ %add476.1.1, %if.end425.1 ], !dbg !86
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end366.1 ], [ %add476.11343, %if.end425.1 ], !dbg !86
  br i1 %or.cond1264.1, label %if.end658.1, label %for.cond520.preheader.1, !dbg !133

for.cond520.preheader.1:                          ; preds = %if.end512.1
  %201 = shl nuw nsw i32 %9, 10
  %mul527.1 = and i32 %201, 64512
  %add530.1 = add nuw nsw i32 %add112, %mul527.1
  %202 = zext nneg i32 %add530.1 to i64, !dbg !134
  %add.ptr535.11344 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202, !dbg !135
  %V_reg.sroa.0.0.copyload1825 = load <4 x half>, ptr addrspace(4) %add.ptr535.11344, align 16, !dbg !136
  %V_reg.sroa.18.0.add.ptr535.11344.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr535.11344, i64 8, !dbg !136
  %V_reg.sroa.18.0.copyload1832 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr535.11344.sroa_idx, align 8, !dbg !136
  %203 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202, !dbg !135
  %add.ptr535.1.1 = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1024, !dbg !135
  %V_reg.sroa.26.16.copyload1853 = load <4 x half>, ptr addrspace(4) %add.ptr535.1.1, align 16, !dbg !136
  %V_reg.sroa.42.16.add.ptr535.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1032, !dbg !136
  %V_reg.sroa.42.16.copyload1860 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr535.1.1.sroa_idx, align 8, !dbg !136
  %cmp545.1 = icmp sgt i32 %mul17.6, %invariant.op, !dbg !137
  br i1 %cmp545.1, label %for.cond547.preheader.1, label %if.end571.1, !dbg !138

for.cond547.preheader.1:                          ; preds = %for.cond520.preheader.1
  %add554.1 = add nuw nsw i32 %mul17.6, %mul261
  %cmp557.not.11345 = icmp ugt i32 %add554.1, %1, !dbg !139
  %fneg.1176.11346 = select i1 %cmp557.not.11345, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1513 = insertelement <4 x float> poison, float %fneg.1176.11346, i64 0, !dbg !140
  %cmp557.not.1.1.not = icmp ult i32 %add554.1, %1, !dbg !139
  %fneg.1176.1.1 = select i1 %cmp557.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1608 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1513, float %fneg.1176.1.1, i64 1, !dbg !140
  %add555.2.1 = or disjoint i32 %add554.1, 2, !dbg !141
  %cmp557.not.2.1 = icmp ugt i32 %add555.2.1, %1, !dbg !139
  %fneg.1176.2.1 = select i1 %cmp557.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1701 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1608, float %fneg.1176.2.1, i64 2, !dbg !140
  %add555.3.1 = or disjoint i32 %add554.1, 3, !dbg !141
  %cmp557.not.3.1 = icmp ugt i32 %add555.3.1, %1, !dbg !139
  %fneg.1176.3.1 = select i1 %cmp557.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1794 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1701, float %fneg.1176.3.1, i64 3, !dbg !140
  br label %if.end571.1

if.end571.1:                                      ; preds = %for.cond520.preheader.1, %for.cond547.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1794, %for.cond547.preheader.1 ], [ zeroinitializer, %for.cond520.preheader.1 ], !dbg !86
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !142, !call_argsrelate !88
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %204), !dbg !142, !call_argsrelate !88
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %205), !dbg !142, !call_argsrelate !88
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %206), !dbg !142, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1515 = extractelement <4 x float> %207, i64 0, !dbg !143
  %mul606.11350 = fmul contract float %acc_s.sroa.0.0.vec.extract1515, 0x3FB99999A0000000, !dbg !144
  %208 = tail call contract noundef float @llvm.minnum.f32(float %mul606.11350, float 0x4024CB5EC0000000), !dbg !145
  %209 = tail call contract noundef float @llvm.exp.f32(float %208), !dbg !147
  %acc_s.sroa.0.4.vec.extract1610 = extractelement <4 x float> %207, i64 1, !dbg !143
  %mul606.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1610, 0x3FB99999A0000000, !dbg !144
  %210 = tail call contract noundef float @llvm.minnum.f32(float %mul606.1.1, float 0x4024CB5EC0000000), !dbg !145
  %211 = tail call contract noundef float @llvm.exp.f32(float %210), !dbg !147
  %acc_s.sroa.0.8.vec.extract1703 = extractelement <4 x float> %207, i64 2, !dbg !143
  %mul606.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1703, 0x3FB99999A0000000, !dbg !144
  %212 = tail call contract noundef float @llvm.minnum.f32(float %mul606.2.1, float 0x4024CB5EC0000000), !dbg !145
  %213 = tail call contract noundef float @llvm.exp.f32(float %212), !dbg !147
  %acc_s.sroa.0.12.vec.extract1796 = extractelement <4 x float> %207, i64 3, !dbg !143
  %mul606.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1796, 0x3FB99999A0000000, !dbg !144
  %214 = tail call contract noundef float @llvm.minnum.f32(float %mul606.3.1, float 0x4024CB5EC0000000), !dbg !145
  %215 = tail call contract noundef float @llvm.exp.f32(float %214), !dbg !147
  %add622.11351 = fadd contract float %sum_acc.sroa.0.5, %209, !dbg !149
  %add622.1.1 = fadd contract float %sum_acc.sroa.20.5, %211, !dbg !149
  %add622.2.1 = fadd contract float %sum_acc.sroa.38.5, %213, !dbg !149
  %add622.3.1 = fadd contract float %sum_acc.sroa.56.5, %215, !dbg !149
  %216 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %209), !dbg !150
  %217 = insertelement <4 x i16> poison, i16 %216, i64 0, !dbg !154
  %218 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %211), !dbg !150
  %219 = insertelement <4 x i16> %217, i16 %218, i64 1, !dbg !154
  %220 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %213), !dbg !150
  %221 = insertelement <4 x i16> %219, i16 %220, i64 2, !dbg !154
  %222 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %215), !dbg !150
  %223 = insertelement <4 x i16> %221, i16 %222, i64 3, !dbg !154
  %acc_s_cast.sroa.0.6.vec.insert1430 = bitcast <4 x i16> %223 to <4 x half>, !dbg !154
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1825, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1430, <4 x float> %acc_o.sroa.0.2), !dbg !155, !call_argsrelate !109
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1832, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1430, <4 x float> %acc_o.sroa.34.2), !dbg !155, !call_argsrelate !109
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1853, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1430, <4 x float> %acc_o.sroa.66.2), !dbg !155, !call_argsrelate !109
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1860, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1430, <4 x float> %acc_o.sroa.98.2), !dbg !155, !call_argsrelate !109
  br label %if.end658.1, !dbg !156

if.end658.1:                                      ; preds = %if.end571.1, %if.end512.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end512.1 ], [ %227, %if.end571.1 ], !dbg !86
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end512.1 ], [ %226, %if.end571.1 ], !dbg !86
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end512.1 ], [ %225, %if.end571.1 ], !dbg !86
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end512.1 ], [ %224, %if.end571.1 ], !dbg !86
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end512.1 ], [ %add622.3.1, %if.end571.1 ], !dbg !86
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end512.1 ], [ %add622.2.1, %if.end571.1 ], !dbg !86
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end512.1 ], [ %add622.1.1, %if.end571.1 ], !dbg !86
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end512.1 ], [ %add622.11351, %if.end571.1 ], !dbg !86
  br i1 %or.cond1266.1, label %if.end804.1, label %for.cond666.preheader.1, !dbg !156

for.cond666.preheader.1:                          ; preds = %if.end658.1
  %228 = shl nuw nsw i32 %tr.sh.diff, 6
  %mul673.1 = and i32 %228, 64512
  %add676.1 = add nuw nsw i32 %add112, %mul673.1
  %229 = zext nneg i32 %add676.1 to i64, !dbg !157
  %add.ptr681.11352 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %229, !dbg !158
  %V_reg.sroa.0.0.copyload1826 = load <4 x half>, ptr addrspace(4) %add.ptr681.11352, align 16, !dbg !159
  %V_reg.sroa.18.0.add.ptr681.11352.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr681.11352, i64 8, !dbg !159
  %V_reg.sroa.18.0.copyload1833 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr681.11352.sroa_idx, align 8, !dbg !159
  %230 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %229, !dbg !158
  %add.ptr681.1.1 = getelementptr inbounds i8, ptr addrspace(4) %230, i64 1024, !dbg !158
  %V_reg.sroa.26.16.copyload1854 = load <4 x half>, ptr addrspace(4) %add.ptr681.1.1, align 16, !dbg !159
  %V_reg.sroa.42.16.add.ptr681.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %230, i64 1032, !dbg !159
  %V_reg.sroa.42.16.copyload1861 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr681.1.1.sroa_idx, align 8, !dbg !159
  %cmp691.1 = icmp sgt i32 %mul17.7, %invariant.op, !dbg !160
  br i1 %cmp691.1, label %for.cond693.preheader.1, label %if.end717.1, !dbg !161

for.cond693.preheader.1:                          ; preds = %for.cond666.preheader.1
  %add700.1 = add nuw nsw i32 %mul17.7, %mul261
  %cmp703.not.11353 = icmp ugt i32 %add700.1, %1, !dbg !162
  %fneg.1177.11354 = select i1 %cmp703.not.11353, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1525 = insertelement <4 x float> poison, float %fneg.1177.11354, i64 0, !dbg !163
  %cmp703.not.1.1.not = icmp ult i32 %add700.1, %1, !dbg !162
  %fneg.1177.1.1 = select i1 %cmp703.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1618 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1525, float %fneg.1177.1.1, i64 1, !dbg !163
  %add701.2.1 = or disjoint i32 %add700.1, 2, !dbg !164
  %cmp703.not.2.1 = icmp ugt i32 %add701.2.1, %1, !dbg !162
  %fneg.1177.2.1 = select i1 %cmp703.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1711 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1618, float %fneg.1177.2.1, i64 2, !dbg !163
  %add701.3.1 = or disjoint i32 %add700.1, 3, !dbg !164
  %cmp703.not.3.1 = icmp ugt i32 %add701.3.1, %1, !dbg !162
  %fneg.1177.3.1 = select i1 %cmp703.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1804 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1711, float %fneg.1177.3.1, i64 3, !dbg !163
  br label %if.end717.1

if.end717.1:                                      ; preds = %for.cond666.preheader.1, %for.cond693.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1804, %for.cond693.preheader.1 ], [ zeroinitializer, %for.cond666.preheader.1 ], !dbg !86
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !165, !call_argsrelate !88
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %231), !dbg !165, !call_argsrelate !88
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %232), !dbg !165, !call_argsrelate !88
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %233), !dbg !165, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1527 = extractelement <4 x float> %234, i64 0, !dbg !166
  %mul752.11358 = fmul contract float %acc_s.sroa.0.0.vec.extract1527, 0x3FB99999A0000000, !dbg !167
  %235 = tail call contract noundef float @llvm.minnum.f32(float %mul752.11358, float 0x4024CB5EC0000000), !dbg !168
  %236 = tail call contract noundef float @llvm.exp.f32(float %235), !dbg !170
  %acc_s.sroa.0.4.vec.extract1620 = extractelement <4 x float> %234, i64 1, !dbg !166
  %mul752.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1620, 0x3FB99999A0000000, !dbg !167
  %237 = tail call contract noundef float @llvm.minnum.f32(float %mul752.1.1, float 0x4024CB5EC0000000), !dbg !168
  %238 = tail call contract noundef float @llvm.exp.f32(float %237), !dbg !170
  %acc_s.sroa.0.8.vec.extract1713 = extractelement <4 x float> %234, i64 2, !dbg !166
  %mul752.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1713, 0x3FB99999A0000000, !dbg !167
  %239 = tail call contract noundef float @llvm.minnum.f32(float %mul752.2.1, float 0x4024CB5EC0000000), !dbg !168
  %240 = tail call contract noundef float @llvm.exp.f32(float %239), !dbg !170
  %acc_s.sroa.0.12.vec.extract1806 = extractelement <4 x float> %234, i64 3, !dbg !166
  %mul752.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1806, 0x3FB99999A0000000, !dbg !167
  %241 = tail call contract noundef float @llvm.minnum.f32(float %mul752.3.1, float 0x4024CB5EC0000000), !dbg !168
  %242 = tail call contract noundef float @llvm.exp.f32(float %241), !dbg !170
  %add768.11359 = fadd contract float %sum_acc.sroa.0.6, %236, !dbg !172
  %add768.1.1 = fadd contract float %sum_acc.sroa.20.6, %238, !dbg !172
  %add768.2.1 = fadd contract float %sum_acc.sroa.38.6, %240, !dbg !172
  %add768.3.1 = fadd contract float %sum_acc.sroa.56.6, %242, !dbg !172
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %236), !dbg !173
  %244 = insertelement <4 x i16> poison, i16 %243, i64 0, !dbg !177
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %238), !dbg !173
  %246 = insertelement <4 x i16> %244, i16 %245, i64 1, !dbg !177
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %240), !dbg !173
  %248 = insertelement <4 x i16> %246, i16 %247, i64 2, !dbg !177
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %242), !dbg !173
  %250 = insertelement <4 x i16> %248, i16 %249, i64 3, !dbg !177
  %acc_s_cast.sroa.0.6.vec.insert1432 = bitcast <4 x i16> %250 to <4 x half>, !dbg !177
  %251 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1826, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> %acc_o_alt.sroa.0.2), !dbg !178, !call_argsrelate !109
  %252 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1833, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> %acc_o_alt.sroa.18.2), !dbg !178, !call_argsrelate !109
  %253 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1854, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> %acc_o_alt.sroa.34.2), !dbg !178, !call_argsrelate !109
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1861, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> %acc_o_alt.sroa.50.2), !dbg !178, !call_argsrelate !109
  br label %if.end804.1, !dbg !179

if.end804.1:                                      ; preds = %if.end717.1, %if.end658.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end658.1 ], [ %254, %if.end717.1 ], !dbg !86
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end658.1 ], [ %253, %if.end717.1 ], !dbg !86
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end658.1 ], [ %252, %if.end717.1 ], !dbg !86
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end658.1 ], [ %251, %if.end717.1 ], !dbg !86
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end658.1 ], [ %add768.3.1, %if.end717.1 ], !dbg !86
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end658.1 ], [ %add768.2.1, %if.end717.1 ], !dbg !86
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end658.1 ], [ %add768.1.1, %if.end717.1 ], !dbg !86
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end658.1 ], [ %add768.11359, %if.end717.1 ], !dbg !86
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !181
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !182
  %add816 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !183
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !181
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !182
  %add816.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !183
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !181
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !182
  %add816.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !183
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !181
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !182
  %add816.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !183
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !181
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !182
  %add816.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !183
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !181
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !182
  %add816.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !183
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !181
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !182
  %add816.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !183
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !181
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !182
  %add816.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !183
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !181
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !182
  %add816.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !183
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !181
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !182
  %add816.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !183
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !181
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !182
  %add816.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !183
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !181
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !182
  %add816.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !183
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !181
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !182
  %add816.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !183
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !181
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !182
  %add816.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !183
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !181
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !182
  %add816.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !183
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !181
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !182
  %add816.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !183
  %add830 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !184
  %add830.1 = fadd contract float %add830, %sum_acc.sroa.20.7, !dbg !184
  %add830.2 = fadd contract float %add830.1, %sum_acc.sroa.38.7, !dbg !184
  %add830.3 = fadd contract float %add830.2, %sum_acc.sroa.56.7, !dbg !184
  %255 = bitcast float %add830.3 to i32, !dbg !185
  %256 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !197
  %257 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %256) #11, !dbg !202
  %xor.i.i = xor i32 %257, 32, !dbg !203
  %258 = and i32 %257, -64, !dbg !204
  %and.i.i = add nsw i32 %258, 64, !dbg !204
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !205
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %257, !dbg !206
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !207
  %259 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %255), !dbg !208
  %260 = bitcast i32 %259 to float, !dbg !209
  %add.i = fadd contract float %add830.3, %260, !dbg !210
  %261 = bitcast float %add.i to i32, !dbg !213
  %262 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !220
  %263 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %262) #11, !dbg !223
  %xor.i.i1186 = xor i32 %263, 16, !dbg !224
  %264 = and i32 %263, -64, !dbg !225
  %and.i.i1187 = add nsw i32 %264, 64, !dbg !225
  %cmp.not.i.i1188 = icmp slt i32 %xor.i.i1186, %and.i.i1187, !dbg !226
  %cond.i.i1189 = select i1 %cmp.not.i.i1188, i32 %xor.i.i1186, i32 %263, !dbg !227
  %shl.i.i1190 = shl i32 %cond.i.i1189, 2, !dbg !228
  %265 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1190, i32 %261), !dbg !229
  %266 = bitcast i32 %265 to float, !dbg !230
  %add.i.i = fadd contract float %add.i, %266, !dbg !231
  %cmp839 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !233
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !234
  %condval_5.0 = select i1 %cmp839, float %div, float 0.000000e+00, !dbg !234
  %mul852 = fmul contract float %condval_5.0, %add816, !dbg !235
  %mul852.1 = fmul contract float %condval_5.0, %add816.1, !dbg !235
  %mul852.2 = fmul contract float %condval_5.0, %add816.2, !dbg !235
  %mul852.3 = fmul contract float %condval_5.0, %add816.3, !dbg !235
  %mul852.4 = fmul contract float %condval_5.0, %add816.4, !dbg !235
  %mul852.5 = fmul contract float %condval_5.0, %add816.5, !dbg !235
  %mul852.6 = fmul contract float %condval_5.0, %add816.6, !dbg !235
  %mul852.7 = fmul contract float %condval_5.0, %add816.7, !dbg !235
  %mul852.8 = fmul contract float %condval_5.0, %add816.8, !dbg !235
  %mul852.9 = fmul contract float %condval_5.0, %add816.9, !dbg !235
  %mul852.10 = fmul contract float %condval_5.0, %add816.10, !dbg !235
  %mul852.11 = fmul contract float %condval_5.0, %add816.11, !dbg !235
  %mul852.12 = fmul contract float %condval_5.0, %add816.12, !dbg !235
  %mul852.13 = fmul contract float %condval_5.0, %add816.13, !dbg !235
  %mul852.14 = fmul contract float %condval_5.0, %add816.14, !dbg !235
  %mul852.15 = fmul contract float %condval_5.0, %add816.15, !dbg !235
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852), !dbg !236
  %O_reg.sroa.0.0.insert.ext = zext i16 %267 to i64, !dbg !240
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.1), !dbg !236
  %O_reg.sroa.0.2.insert.ext = zext i16 %268 to i64, !dbg !240
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !240
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !240
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.2), !dbg !236
  %O_reg.sroa.0.4.insert.ext = zext i16 %269 to i64, !dbg !240
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !240
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !240
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.3), !dbg !236
  %O_reg.sroa.0.6.insert.ext = zext i16 %270 to i64, !dbg !240
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !240
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !240
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.4), !dbg !236
  %O_reg.sroa.7.8.insert.ext = zext i16 %271 to i64, !dbg !240
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.5), !dbg !236
  %O_reg.sroa.7.10.insert.ext = zext i16 %272 to i64, !dbg !240
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !240
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !240
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.6), !dbg !236
  %O_reg.sroa.7.12.insert.ext = zext i16 %273 to i64, !dbg !240
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !240
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !240
  %274 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.7), !dbg !236
  %O_reg.sroa.7.14.insert.ext = zext i16 %274 to i64, !dbg !240
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !240
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !240
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.8), !dbg !236
  %O_reg.sroa.12.16.insert.ext = zext i16 %275 to i64, !dbg !240
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.9), !dbg !236
  %O_reg.sroa.12.18.insert.ext = zext i16 %276 to i64, !dbg !240
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !240
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !240
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.10), !dbg !236
  %O_reg.sroa.12.20.insert.ext = zext i16 %277 to i64, !dbg !240
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !240
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !240
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.11), !dbg !236
  %O_reg.sroa.12.22.insert.ext = zext i16 %278 to i64, !dbg !240
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !240
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !240
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.12), !dbg !236
  %O_reg.sroa.17.24.insert.ext = zext i16 %279 to i64, !dbg !240
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.13), !dbg !236
  %O_reg.sroa.17.26.insert.ext = zext i16 %280 to i64, !dbg !240
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !240
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !240
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.14), !dbg !236
  %O_reg.sroa.17.28.insert.ext = zext i16 %281 to i64, !dbg !240
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !240
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !240
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul852.15), !dbg !236
  %O_reg.sroa.17.30.insert.ext = zext i16 %282 to i64, !dbg !240
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !240
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !240
  %shr894 = lshr i32 %10, 5
  %and897 = and i32 %10, 7
  %mul903 = and i32 %14, 4
  %xor = xor i32 %shr894, %and897, !dbg !241
  %mul898 = shl nuw nsw i32 %xor, 3, !dbg !242
  %add899 = add nuw nsw i32 %mul898, %mul32, !dbg !243
  %add904 = or disjoint i32 %add899, %mul903, !dbg !244
  %add.ptr906 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add904, !dbg !245
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr906, align 8, !dbg !246
  %add895.1 = add nuw nsw i32 %shr894, 2, !dbg !247
  %xor.1 = xor i32 %add895.1, %and897, !dbg !241
  %mul898.1 = shl nuw nsw i32 %xor.1, 3, !dbg !242
  %add899.1 = add nuw nsw i32 %mul898.1, %mul32, !dbg !243
  %add904.1 = or disjoint i32 %add899.1, %mul903, !dbg !244
  %add.ptr906.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add904.1, !dbg !245
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr906.1, align 8, !dbg !246
  %add895.2 = add nuw nsw i32 %shr894, 4, !dbg !247
  %xor.2 = xor i32 %add895.2, %and897, !dbg !241
  %mul898.2 = shl nuw nsw i32 %xor.2, 3, !dbg !242
  %add899.2 = add nuw nsw i32 %mul898.2, %mul32, !dbg !243
  %add904.2 = or disjoint i32 %add899.2, %mul903, !dbg !244
  %add.ptr906.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add904.2, !dbg !245
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr906.2, align 8, !dbg !246
  %add895.3 = add nuw nsw i32 %shr894, 6, !dbg !247
  %xor.3 = xor i32 %add895.3, %and897, !dbg !241
  %mul898.3 = shl nuw nsw i32 %xor.3, 3, !dbg !242
  %add899.3 = add nuw nsw i32 %mul898.3, %mul32, !dbg !243
  %add904.3 = or disjoint i32 %add899.3, %mul903, !dbg !244
  %add.ptr906.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add904.3, !dbg !245
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr906.3, align 8, !dbg !246
  fence syncscope("warp") release, !dbg !248
  tail call void @llvm.mxc.barrier.warp(), !dbg !253
  fence syncscope("warp") acquire, !dbg !254
  %mul917 = and i32 %mul116, 8128
  %xor9231173 = and i32 %mul116, 56
  %call921.masked = and i32 %10, 1016
  %mul924 = xor i32 %xor9231173, %call921.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul917, !dbg !255
  %invariant.gep1257 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul924, !dbg !255
  %add934 = add nuw nsw i32 %add29, %mul116
  %283 = zext nneg i32 %add934 to i64, !dbg !256
  %add.ptr939 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %283, !dbg !257
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr939, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1257, i64 16, i1 false), !dbg !258, !tbaa.struct !259, !call_argsrelate !260
  %gep1258.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1257, i32 1024, !dbg !261
  %284 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %283, !dbg !257
  %add.ptr939.1 = getelementptr inbounds i8, ptr addrspace(1) %284, i64 1024, !dbg !257
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr939.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1258.1, i64 16, i1 false), !dbg !258, !tbaa.struct !259, !call_argsrelate !260
  ret void, !dbg !262
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

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
declare float @llvm.minnum.f32(float, float) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpo4bwqp2k/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpo4bwqp2k/tvm_kernels.maca", directory: "")
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
!53 = !DILocation(line: 34, column: 26, scope: !40)
!54 = !DILocation(line: 34, column: 9, scope: !40)
!55 = !DILocation(line: 32, column: 42, scope: !40)
!56 = !{i32 0, i32 1024}
!57 = !DILocation(line: 42, column: 3, scope: !40)
!58 = !DILocation(line: 43, column: 46, scope: !40)
!59 = !DILocation(line: 43, column: 32, scope: !40)
!60 = !DILocation(line: 58, column: 8, scope: !40)
!61 = !DILocation(line: 63, column: 22, scope: !40)
!62 = !DILocation(line: 65, column: 7, scope: !40)
!63 = !DILocation(line: 66, column: 52, scope: !40)
!64 = !DILocation(line: 66, column: 38, scope: !40)
!65 = !DILocation(line: 69, column: 22, scope: !40)
!66 = !DILocation(line: 71, column: 7, scope: !40)
!67 = !DILocation(line: 72, column: 53, scope: !40)
!68 = !DILocation(line: 72, column: 39, scope: !40)
!69 = !DILocation(line: 75, column: 22, scope: !40)
!70 = !DILocation(line: 77, column: 7, scope: !40)
!71 = !DILocation(line: 78, column: 53, scope: !40)
!72 = !DILocation(line: 78, column: 39, scope: !40)
!73 = !DILocation(line: 81, column: 22, scope: !40)
!74 = !DILocation(line: 83, column: 7, scope: !40)
!75 = !DILocation(line: 84, column: 53, scope: !40)
!76 = !DILocation(line: 84, column: 39, scope: !40)
!77 = !DILocation(line: 87, column: 22, scope: !40)
!78 = !DILocation(line: 89, column: 7, scope: !40)
!79 = !DILocation(line: 90, column: 52, scope: !40)
!80 = !DILocation(line: 90, column: 38, scope: !40)
!81 = !DILocation(line: 92, column: 29, scope: !40)
!82 = !DILocation(line: 92, column: 11, scope: !40)
!83 = !DILocation(line: 96, column: 65, scope: !40)
!84 = !DILocation(line: 101, column: 22, scope: !40)
!85 = !DILocation(line: 96, column: 58, scope: !40)
!86 = !DILocation(line: 0, scope: !40)
!87 = !DILocation(line: 110, column: 36, scope: !40)
!88 = !{i32 -1, i32 3, i32 -1}
!89 = !DILocation(line: 118, column: 32, scope: !40)
!90 = !DILocation(line: 118, column: 43, scope: !40)
!91 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "min", scope: !93, file: !93, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!94 = distinct !DILocation(line: 118, column: 27, scope: !40)
!95 = !DILocation(line: 288, column: 10, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "expf", scope: !93, file: !93, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = distinct !DILocation(line: 118, column: 22, scope: !40)
!98 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !100, file: !100, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!101 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "__float2half", scope: !103, file: !103, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!104 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__half", scope: !103, file: !103, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 126, column: 34, scope: !40)
!107 = !DILocation(line: 126, column: 31, scope: !40)
!108 = !DILocation(line: 130, column: 36, scope: !40)
!109 = !{i32 4, i32 -1, i32 -1}
!110 = !DILocation(line: 136, column: 22, scope: !40)
!111 = !DILocation(line: 138, column: 7, scope: !40)
!112 = !DILocation(line: 139, column: 53, scope: !40)
!113 = !DILocation(line: 139, column: 39, scope: !40)
!114 = !DILocation(line: 141, column: 29, scope: !40)
!115 = !DILocation(line: 141, column: 11, scope: !40)
!116 = !DILocation(line: 145, column: 66, scope: !40)
!117 = !DILocation(line: 150, column: 23, scope: !40)
!118 = !DILocation(line: 145, column: 58, scope: !40)
!119 = !DILocation(line: 159, column: 36, scope: !40)
!120 = !DILocation(line: 167, column: 33, scope: !40)
!121 = !DILocation(line: 167, column: 45, scope: !40)
!122 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !123)
!123 = distinct !DILocation(line: 167, column: 28, scope: !40)
!124 = !DILocation(line: 288, column: 10, scope: !96, inlinedAt: !125)
!125 = distinct !DILocation(line: 167, column: 23, scope: !40)
!126 = !DILocation(line: 171, column: 40, scope: !40)
!127 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !128)
!128 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !129)
!129 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !130)
!130 = distinct !DILocation(line: 175, column: 36, scope: !40)
!131 = !DILocation(line: 175, column: 33, scope: !40)
!132 = !DILocation(line: 179, column: 42, scope: !40)
!133 = !DILocation(line: 185, column: 22, scope: !40)
!134 = !DILocation(line: 187, column: 7, scope: !40)
!135 = !DILocation(line: 188, column: 53, scope: !40)
!136 = !DILocation(line: 188, column: 39, scope: !40)
!137 = !DILocation(line: 190, column: 29, scope: !40)
!138 = !DILocation(line: 190, column: 11, scope: !40)
!139 = !DILocation(line: 194, column: 66, scope: !40)
!140 = !DILocation(line: 199, column: 23, scope: !40)
!141 = !DILocation(line: 194, column: 58, scope: !40)
!142 = !DILocation(line: 208, column: 36, scope: !40)
!143 = !DILocation(line: 216, column: 33, scope: !40)
!144 = !DILocation(line: 216, column: 45, scope: !40)
!145 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !146)
!146 = distinct !DILocation(line: 216, column: 28, scope: !40)
!147 = !DILocation(line: 288, column: 10, scope: !96, inlinedAt: !148)
!148 = distinct !DILocation(line: 216, column: 23, scope: !40)
!149 = !DILocation(line: 220, column: 40, scope: !40)
!150 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !151)
!151 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !152)
!152 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !153)
!153 = distinct !DILocation(line: 224, column: 36, scope: !40)
!154 = !DILocation(line: 224, column: 33, scope: !40)
!155 = !DILocation(line: 228, column: 38, scope: !40)
!156 = !DILocation(line: 234, column: 22, scope: !40)
!157 = !DILocation(line: 236, column: 7, scope: !40)
!158 = !DILocation(line: 237, column: 53, scope: !40)
!159 = !DILocation(line: 237, column: 39, scope: !40)
!160 = !DILocation(line: 239, column: 29, scope: !40)
!161 = !DILocation(line: 239, column: 11, scope: !40)
!162 = !DILocation(line: 243, column: 66, scope: !40)
!163 = !DILocation(line: 248, column: 23, scope: !40)
!164 = !DILocation(line: 243, column: 58, scope: !40)
!165 = !DILocation(line: 257, column: 36, scope: !40)
!166 = !DILocation(line: 265, column: 33, scope: !40)
!167 = !DILocation(line: 265, column: 45, scope: !40)
!168 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !169)
!169 = distinct !DILocation(line: 265, column: 28, scope: !40)
!170 = !DILocation(line: 288, column: 10, scope: !96, inlinedAt: !171)
!171 = distinct !DILocation(line: 265, column: 23, scope: !40)
!172 = !DILocation(line: 269, column: 40, scope: !40)
!173 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !174)
!174 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !175)
!175 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !176)
!176 = distinct !DILocation(line: 273, column: 36, scope: !40)
!177 = !DILocation(line: 273, column: 33, scope: !40)
!178 = !DILocation(line: 277, column: 42, scope: !40)
!179 = !DILocation(line: 58, column: 34, scope: !40)
!180 = !DILocation(line: 122, column: 40, scope: !40)
!181 = !DILocation(line: 286, column: 20, scope: !40)
!182 = !DILocation(line: 286, column: 34, scope: !40)
!183 = !DILocation(line: 286, column: 32, scope: !40)
!184 = !DILocation(line: 291, column: 36, scope: !40)
!185 = !DILocation(line: 1018, column: 9, scope: !186, inlinedAt: !188)
!186 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !187, file: !187, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!187 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!188 = distinct !DILocation(line: 396, column: 10, scope: !189, inlinedAt: !191)
!189 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !190, file: !190, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!190 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!191 = distinct !DILocation(line: 129, column: 24, scope: !192, inlinedAt: !194)
!192 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !193, file: !193, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!193 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!194 = distinct !DILocation(line: 101, column: 14, scope: !195, inlinedAt: !196)
!195 = distinct !DISubprogram(name: "run<float>", scope: !193, file: !193, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!196 = distinct !DILocation(line: 293, column: 19, scope: !40)
!197 = !DILocation(line: 171, column: 37, scope: !198, inlinedAt: !199)
!198 = distinct !DISubprogram(name: "__lane_id", scope: !187, file: !187, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!199 = distinct !DILocation(line: 990, column: 14, scope: !200, inlinedAt: !201)
!200 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !187, file: !187, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!201 = distinct !DILocation(line: 1019, column: 11, scope: !186, inlinedAt: !188)
!202 = !DILocation(line: 171, column: 10, scope: !198, inlinedAt: !199)
!203 = !DILocation(line: 991, column: 20, scope: !200, inlinedAt: !201)
!204 = !DILocation(line: 992, column: 36, scope: !200, inlinedAt: !201)
!205 = !DILocation(line: 992, column: 17, scope: !200, inlinedAt: !201)
!206 = !DILocation(line: 992, column: 11, scope: !200, inlinedAt: !201)
!207 = !DILocation(line: 993, column: 43, scope: !200, inlinedAt: !201)
!208 = !DILocation(line: 993, column: 10, scope: !200, inlinedAt: !201)
!209 = !DILocation(line: 1020, column: 14, scope: !186, inlinedAt: !188)
!210 = !DILocation(line: 25, column: 14, scope: !211, inlinedAt: !212)
!211 = distinct !DISubprogram(name: "operator()<float>", scope: !193, file: !193, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!212 = distinct !DILocation(line: 129, column: 11, scope: !192, inlinedAt: !194)
!213 = !DILocation(line: 1018, column: 9, scope: !186, inlinedAt: !214)
!214 = distinct !DILocation(line: 396, column: 10, scope: !189, inlinedAt: !215)
!215 = distinct !DILocation(line: 129, column: 24, scope: !216, inlinedAt: !217)
!216 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !193, file: !193, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!217 = distinct !DILocation(line: 101, column: 14, scope: !218, inlinedAt: !219)
!218 = distinct !DISubprogram(name: "run<float>", scope: !193, file: !193, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!219 = distinct !DILocation(line: 134, column: 14, scope: !192, inlinedAt: !194)
!220 = !DILocation(line: 171, column: 37, scope: !198, inlinedAt: !221)
!221 = distinct !DILocation(line: 990, column: 14, scope: !200, inlinedAt: !222)
!222 = distinct !DILocation(line: 1019, column: 11, scope: !186, inlinedAt: !214)
!223 = !DILocation(line: 171, column: 10, scope: !198, inlinedAt: !221)
!224 = !DILocation(line: 991, column: 20, scope: !200, inlinedAt: !222)
!225 = !DILocation(line: 992, column: 36, scope: !200, inlinedAt: !222)
!226 = !DILocation(line: 992, column: 17, scope: !200, inlinedAt: !222)
!227 = !DILocation(line: 992, column: 11, scope: !200, inlinedAt: !222)
!228 = !DILocation(line: 993, column: 43, scope: !200, inlinedAt: !222)
!229 = !DILocation(line: 993, column: 10, scope: !200, inlinedAt: !222)
!230 = !DILocation(line: 1020, column: 14, scope: !186, inlinedAt: !214)
!231 = !DILocation(line: 25, column: 14, scope: !211, inlinedAt: !232)
!232 = distinct !DILocation(line: 129, column: 11, scope: !216, inlinedAt: !217)
!233 = !DILocation(line: 295, column: 32, scope: !40)
!234 = !DILocation(line: 295, column: 7, scope: !40)
!235 = !DILocation(line: 303, column: 32, scope: !40)
!236 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !237)
!237 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !238)
!238 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !239)
!239 = distinct !DILocation(line: 309, column: 50, scope: !40)
!240 = !DILocation(line: 309, column: 47, scope: !40)
!241 = !DILocation(line: 314, column: 122, scope: !40)
!242 = !DILocation(line: 314, column: 150, scope: !40)
!243 = !DILocation(line: 314, column: 77, scope: !40)
!244 = !DILocation(line: 314, column: 156, scope: !40)
!245 = !DILocation(line: 314, column: 40, scope: !40)
!246 = !DILocation(line: 314, column: 199, scope: !40)
!247 = !DILocation(line: 314, column: 93, scope: !40)
!248 = !DILocation(line: 68, column: 3, scope: !249, inlinedAt: !250)
!249 = distinct !DISubprogram(name: "__barrier_warp", scope: !187, file: !187, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!250 = distinct !DILocation(line: 192, column: 3, scope: !251, inlinedAt: !252)
!251 = distinct !DISubprogram(name: "__syncwarp", scope: !187, file: !187, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!252 = distinct !DILocation(line: 316, column: 3, scope: !40)
!253 = !DILocation(line: 69, column: 3, scope: !249, inlinedAt: !250)
!254 = !DILocation(line: 70, column: 3, scope: !249, inlinedAt: !250)
!255 = !DILocation(line: 318, column: 8, scope: !40)
!256 = !DILocation(line: 318, column: 3, scope: !40)
!257 = !DILocation(line: 319, column: 22, scope: !40)
!258 = !DILocation(line: 319, column: 132, scope: !40)
!259 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!260 = !{i32 2, i32 -1, i32 -1, i32 -1}
!261 = !DILocation(line: 319, column: 169, scope: !40)
!262 = !DILocation(line: 321, column: 1, scope: !40)
