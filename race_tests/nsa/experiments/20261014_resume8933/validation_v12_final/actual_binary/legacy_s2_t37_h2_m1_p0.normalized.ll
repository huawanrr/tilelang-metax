target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

define weak void @__cxa_pure_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

declare void @llvm.trap() #1

define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr()
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !tbaa !17
  %2 = inttoptr i64 %1 to ptr
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !tbaa !17
  %4 = inttoptr i64 %3 to ptr
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16
  %5 = load ptr, ptr %thread_counter.i, align 8, !tbaa !21
  %cmp.not.i = icmp eq ptr %5, null
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr()
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12
  %8 = load i32, ptr addrspace(4) %7, align 4, !range !28, !invariant.load !8
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4
  %10 = load i32, ptr addrspace(4) %9, align 4, !invariant.load !8
  %conv.i14.i.i = and i32 %10, 65535
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16
  %12 = load i32, ptr addrspace(4) %11, align 4, !range !28, !invariant.load !8
  %13 = lshr i32 %10, 16
  %div.i.i.i = udiv i32 %12, %13
  %mul.i.i.i = mul i32 %div.i.i.i, %13
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul.i.i = mul i32 %add.i.i.i, %14
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul320.i.i = add i32 %mul.i.i, %15
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %add8.i.i = add i32 %add.i.i, %16
  %conv.i.i = zext i32 %add8.i.i to i64
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i)
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !tbaa !30
  br label %_Z9atomicAddPii.exit.i

if.end.i.i:                                       ; preds = %while.cond.i
  %19 = atomicrmw or ptr %arrayidx.i, i32 0 syncscope("device-one-as") monotonic, align 4
  br label %_Z9atomicAddPii.exit.i

_Z9atomicAddPii.exit.i:                           ; preds = %if.end.i.i, %if.then.i.i
  %retval.0.i.i = phi i32 [ %18, %if.then.i.i ], [ %19, %if.end.i.i ]
  %cmp6.i = icmp sgt i32 %retval.0.i.i, 0
  br i1 %cmp6.i, label %while.body.i, label %if.end.i

while.body.i:                                     ; preds = %_Z9atomicAddPii.exit.i
  tail call void @llvm.mxc.sleep(i32 1)
  br label %while.cond.i, !llvm.loop !31

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i)
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !tbaa !30
  %add.i37.i = add nsw i32 %21, -1
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !tbaa !30
  br label %_Z9atomicAddPii.exit38.i

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %_Z9atomicAddPii.exit38.i

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ]
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4
  %23 = load i32, ptr %call_deep.i, align 4, !tbaa !33
  %cmp8.i = icmp eq i32 %23, 0
  br i1 %cmp8.i, label %if.then9.i, label %if.else.i

if.then9.i:                                       ; preds = %_Z9atomicAddPii.exit38.i
  %cmp10.i = icmp slt i32 %retval.0.i35.i, 2
  br i1 %cmp10.i, label %if.then11.i, label %__mcImplicitDeviceSynchronizeImpl.exit

if.then11.i:                                      ; preds = %if.then9.i
  tail call void @llvm.mxc.sleep(i32 30)
  br label %__mcImplicitDeviceSynchronizeImpl.exit

if.else.i:                                        ; preds = %_Z9atomicAddPii.exit38.i
  %parent_wrap13.i = getelementptr inbounds i8, ptr %4, i64 24
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !tbaa !34
  %25 = load i32, ptr %4, align 8, !tbaa !35
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !tbaa !21
  %idxprom.i = zext i32 %25 to i64
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !tbaa !36
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !tbaa !38
  %29 = inttoptr i64 %28 to ptr
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i)
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !tbaa !30
  %and.i.i.i = and i32 %31, 2147483647
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !tbaa !30
  br label %if.end20.i

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4
  br label %if.end20.i

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i)
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !tbaa !30
  %add.i42.i = add nsw i32 %34, -1
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !tbaa !30
  br label %__mcImplicitDeviceSynchronizeImpl.exit

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %__mcImplicitDeviceSynchronizeImpl.exit

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void
}

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 2
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nuw nsw i32 %1, 1
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp10 = icmp ult i32 %3, 3
  %4 = shl nsw i32 %3, 4
  %mul11 = select i1 %cmp10, i32 %4, i32 -16
  %5 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5
  %6 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cmp10.1 = icmp ult i32 %6, 3
  %7 = shl nsw i32 %6, 4
  %mul11.1 = select i1 %cmp10.1, i32 %7, i32 -16
  %mul20 = shl nsw i32 %0, 11
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %8 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !46
  %and = shl nuw nsw i32 %8, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %9 = lshr i32 %8, 1
  %mul30 = and i32 %9, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %10 = zext nneg i32 %add28 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %10
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.5.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.5.0.add.ptr.sroa_idx, align 8
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %10
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 64
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.10.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %11, i64 72
  %Q_reg.sroa.10.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.16.add.ptr.1.sroa_idx, align 8
  %shr73 = lshr i32 %8, 3
  %12 = shl nuw nsw i32 %8, 4
  %mul81 = and i32 %12, 16256
  %mul86 = shl nsw i32 %1, 6
  %add82 = add nuw nsw i32 %mul81, %mul86
  %and89 = shl nuw nsw i32 %8, 3
  %mul90 = and i32 %and89, 56
  %add84 = or disjoint i32 %add82, %mul90
  %mul192 = and i32 %and89, 8128
  %call196.masked = and i32 %8, 1016
  %mul198 = xor i32 %mul90, %call196.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul192
  %invariant.gep675 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul198
  %13 = lshr i32 %8, 2
  %mul213 = and i32 %13, 252
  %shr245 = lshr i32 %8, 4
  %and248 = and i32 %8, 7
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul25
  %invariant.gep687 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2048
  %mul361 = and i32 %12, 16128
  %shr367 = and i32 %shr73, 1
  %mul372 = and i32 %13, 4
  %or.cond702 = icmp ult i32 %mul11, 37
  br i1 %or.cond702, label %for.cond67.preheader, label %if.end231

for.cond67.preheader:                             ; preds = %entry
  %add74 = add nuw nsw i32 %mul11, %shr73
  %mul83 = shl nuw nsw i32 %mul11, 7
  %add87 = add nuw nsw i32 %add84, %mul83
  %15 = zext nneg i32 %add87 to i64
  %cmp76 = icmp slt i32 %add74, 37
  br i1 %cmp76, label %if.then77, label %if.end115

if.then77:                                        ; preds = %for.cond67.preheader
  %add.ptr93 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %15
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr93, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 8
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 12
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx, align 4, !tbaa !30
  br label %if.end115

if.end115:                                        ; preds = %for.cond67.preheader, %if.then77
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %cmp76.1 = icmp slt i32 %add74, 29
  br i1 %cmp76.1, label %if.then77.1, label %if.end115.1

if.then77.1:                                      ; preds = %if.end115
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %15
  %add.ptr93.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2048
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr93.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2052
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2056
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2060
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1, align 4, !tbaa !30
  br label %if.end115.1

if.end115.1:                                      ; preds = %if.then77.1, %if.end115
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  br i1 %cmp76, label %if.then133, label %if.end173

if.then133:                                       ; preds = %if.end115.1
  %add.ptr149 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %15
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr149, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 4
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 8
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 12
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx, align 4, !tbaa !30
  br label %if.end173

if.end173:                                        ; preds = %if.end115.1, %if.then133
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  br i1 %cmp76.1, label %if.then133.1, label %if.end173.1

if.then133.1:                                     ; preds = %if.end173
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %15
  %add.ptr149.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2048
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr149.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2052
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2056
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2060
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1, align 4, !tbaa !30
  br label %if.end173.1

if.end173.1:                                      ; preds = %if.then133.1, %if.end173
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep675, align 16, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.8.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %K_reg.sroa.8.0.invariant.gep675.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.10.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %K_reg.sroa.10.0.invariant.gep675.sroa_idx, align 4, !tbaa !30
  %gep676.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep676.1, align 16, !tbaa !30
  %K_reg.sroa.16.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.16.16.gep676.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.18.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.18.16.gep676.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.20.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.20.16.gep676.1.sroa_idx, align 4, !tbaa !30
  %cmp205 = icmp sgt i32 %mul11, 21
  br i1 %cmp205, label %for.cond207.preheader, label %if.end231

for.cond207.preheader:                            ; preds = %if.end173.1
  %add214 = add nuw nsw i32 %mul11, %mul213
  %cmp216 = icmp slt i32 %add214, 37
  %.fneg = select i1 %cmp216, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert881 = insertelement <4 x float> poison, float %.fneg, i64 0
  %add215.1 = or disjoint i32 %add214, 1
  %cmp216.1 = icmp slt i32 %add215.1, 37
  %.fneg.1 = select i1 %cmp216.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert906 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert881, float %.fneg.1, i64 1
  %add215.2 = or disjoint i32 %add214, 2
  %cmp216.2 = icmp slt i32 %add215.2, 37
  %.fneg.2 = select i1 %cmp216.2, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert927 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert906, float %.fneg.2, i64 2
  %add215.3 = or disjoint i32 %add214, 3
  %cmp216.3 = icmp slt i32 %add215.3, 37
  %.fneg.3 = select i1 %cmp216.3, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert948 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert927, float %.fneg.3, i64 3
  br label %if.end231

if.end231:                                        ; preds = %if.end173.1, %for.cond207.preheader, %entry
  %V_reg.sroa.20.0 = phi i32 [ %condval_2.sroa.7.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.7.0.1, %if.end173.1 ]
  %V_reg.sroa.18.0 = phi i32 [ %condval_2.sroa.6.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.6.0.1, %if.end173.1 ]
  %V_reg.sroa.16.0 = phi i32 [ %condval_2.sroa.5.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.5.0.1, %if.end173.1 ]
  %V_reg.sroa.12.0 = phi i32 [ %condval_2.sroa.0.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.0.0.1, %if.end173.1 ]
  %V_reg.sroa.10.0 = phi i32 [ %condval_2.sroa.7.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.7.0, %if.end173.1 ]
  %V_reg.sroa.8.0 = phi i32 [ %condval_2.sroa.6.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.6.0, %if.end173.1 ]
  %V_reg.sroa.6.0 = phi i32 [ %condval_2.sroa.5.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.5.0, %if.end173.1 ]
  %V_reg.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.0.0, %if.end173.1 ]
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert948, %for.cond207.preheader ], [ undef, %entry ], [ zeroinitializer, %if.end173.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702, label %for.cond236.preheader, label %if.end346

for.cond236.preheader:                            ; preds = %if.end231
  %xor249 = xor i32 %shr245, %and248
  %add.ptr253.idx = shl nuw nsw i32 %xor249, 4
  %add.ptr253 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr253, align 16
  %kb.sroa.10.0.add.ptr253.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253, i32 8
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.sroa_idx, align 8
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !82
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.5.0.copyload, <4 x float> %18), !call_argsrelate !82
  %add246.1 = add nuw nsw i32 %shr245, 4
  %xor249.1 = xor i32 %add246.1, %and248
  %add.ptr253.idx.1 = shl nuw nsw i32 %xor249.1, 4
  %add.ptr253.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx.1
  %kb.sroa.0.0.copyload868 = load <4 x half>, ptr addrspace(3) %add.ptr253.1, align 16
  %kb.sroa.10.0.add.ptr253.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1, i32 8
  %kb.sroa.10.0.copyload871 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.1.sroa_idx, align 8
  %20 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload868, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %19), !call_argsrelate !82
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload871, <4 x half> %Q_reg.sroa.10.16.copyload, <4 x float> %20), !call_argsrelate !82
  store i32 %V_reg.sroa.0.0, ptr addrspace(3) %invariant.gep687, align 16, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2052
  store i32 %V_reg.sroa.6.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.8.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2056
  store i32 %V_reg.sroa.8.0, ptr addrspace(3) %V_reg.sroa.8.0.invariant.gep687.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.10.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2060
  store i32 %V_reg.sroa.10.0, ptr addrspace(3) %V_reg.sroa.10.0.invariant.gep687.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3072
  store i32 %V_reg.sroa.12.0, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3076
  store i32 %V_reg.sroa.16.0, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3080
  store i32 %V_reg.sroa.18.0, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.20.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3084
  store i32 %V_reg.sroa.20.0, ptr addrspace(3) %V_reg.sroa.20.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract883 = extractelement <4 x float> %21, i64 0
  %mul310 = fmul contract float %acc_s.sroa.0.0.vec.extract883, 0x3FC2776C60000000
  %22 = tail call contract noundef float @llvm.minnum.f32(float %mul310, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %22, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i636 = fadd contract float %22, %cond.i.i
  %23 = tail call contract float @llvm.exp2.f32(float %add.i.i636)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %23
  %acc_s.sroa.0.0.vec.insert885 = insertelement <4 x float> poison, float %mul.i.i, i64 0
  %acc_s.sroa.0.4.vec.extract908 = extractelement <4 x float> %21, i64 1
  %mul310.1 = fmul contract float %acc_s.sroa.0.4.vec.extract908, 0x3FC2776C60000000
  %24 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %24, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.1 = fadd contract float %24, %cond.i.i.1
  %25 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %25
  %acc_s.sroa.0.4.vec.insert910 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert885, float %mul.i.i.1, i64 1
  %acc_s.sroa.0.8.vec.extract929 = extractelement <4 x float> %21, i64 2
  %mul310.2 = fmul contract float %acc_s.sroa.0.8.vec.extract929, 0x3FC2776C60000000
  %26 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %26, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.2 = fadd contract float %26, %cond.i.i.2
  %27 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %27
  %acc_s.sroa.0.8.vec.insert931 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert910, float %mul.i.i.2, i64 2
  %acc_s.sroa.0.12.vec.extract950 = extractelement <4 x float> %21, i64 3
  %mul310.3 = fmul contract float %acc_s.sroa.0.12.vec.extract950, 0x3FC2776C60000000
  %28 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %28, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.3 = fadd contract float %28, %cond.i.i.3
  %29 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %29
  %acc_s.sroa.0.12.vec.insert952 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert931, float %mul.i.i.3, i64 3
  %add326 = fadd contract float %mul.i.i, 0.000000e+00
  %add326.1 = fadd contract float %mul.i.i.1, 0.000000e+00
  %add326.2 = fadd contract float %mul.i.i.2, 0.000000e+00
  %add326.3 = fadd contract float %mul.i.i.3, 0.000000e+00
  %30 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !105
  %31 = fptrunc float %mul.i.i to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %30), !noalias !105
  %32 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !105
  %33 = fptrunc float %mul.i.i.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %32), !noalias !105
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %31, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %33, i64 1
  %34 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !119
  %35 = fptrunc float %mul.i.i.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %34), !noalias !119
  %36 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !119
  %37 = fptrunc float %mul.i.i.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %36), !noalias !119
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %35, i64 2
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %37, i64 3
  br label %if.end346

if.end346:                                        ; preds = %for.cond236.preheader, %if.end231
  %sum_acc.sroa.20.0 = phi float [ %add326.3, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ]
  %sum_acc.sroa.14.0 = phi float [ %add326.2, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ]
  %sum_acc.sroa.8.0 = phi float [ %add326.1, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ]
  %sum_acc.sroa.0.0 = phi float [ %add326, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ]
  %acc_s.sroa.0.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert952, %for.cond236.preheader ], [ %acc_s.sroa.0.0, %if.end231 ]
  %acc_s_cast.sroa.0.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %for.cond236.preheader ], [ undef, %if.end231 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702, label %for.cond355.preheader.preheader, label %if.end411

for.cond355.preheader.preheader:                  ; preds = %if.end346
  %xor374 = or disjoint i32 %mul372, %shr367
  %mul375 = shl nuw nsw i32 %xor374, 3
  %add376 = or disjoint i32 %mul375, %mul361
  %add379 = or disjoint i32 %add376, %and248
  %gep691 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379
  %38 = load half, ptr addrspace(3) %gep691, align 2, !tbaa !141
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %38, i64 0
  %add363.1 = or disjoint i32 %mul361, 64
  %add373.1 = or disjoint i32 %mul372, 1
  %xor374.1 = xor i32 %add373.1, %shr367
  %mul375.1 = shl nuw nsw i32 %xor374.1, 3
  %add376.1 = or disjoint i32 %mul375.1, %add363.1
  %add379.1 = or disjoint i32 %add376.1, %and248
  %gep691.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1
  %39 = load half, ptr addrspace(3) %gep691.1, align 2, !tbaa !141
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %39, i64 1
  %add363.2 = or disjoint i32 %mul361, 128
  %add373.2 = or disjoint i32 %mul372, 2
  %xor374.2 = or disjoint i32 %add373.2, %shr367
  %mul375.2 = shl nuw nsw i32 %xor374.2, 3
  %add376.2 = or disjoint i32 %mul375.2, %add363.2
  %add379.2 = or disjoint i32 %add376.2, %and248
  %gep691.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2
  %40 = load half, ptr addrspace(3) %gep691.2, align 2, !tbaa !141
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %40, i64 2
  %add363.3 = or disjoint i32 %mul361, 192
  %add373.3 = or disjoint i32 %mul372, 3
  %xor374.3 = xor i32 %add373.3, %shr367
  %mul375.3 = shl nuw nsw i32 %xor374.3, 3
  %add376.3 = or disjoint i32 %mul375.3, %add363.3
  %add379.3 = or disjoint i32 %add376.3, %and248
  %gep691.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3
  %41 = load half, ptr addrspace(3) %gep691.3, align 2, !tbaa !141
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %41, i64 3
  %add368.1 = or disjoint i32 %shr367, 2
  %xor374.1723 = or disjoint i32 %mul372, %add368.1
  %mul375.1724 = shl nuw nsw i32 %xor374.1723, 3
  %add376.1725 = or disjoint i32 %mul375.1724, %mul361
  %add379.1726 = or disjoint i32 %add376.1725, %and248
  %gep691.1727 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1726
  %42 = load half, ptr addrspace(3) %gep691.1727, align 2, !tbaa !141
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %42, i64 0
  %xor374.1.1 = xor i32 %add373.1, %add368.1
  %mul375.1.1 = shl nuw nsw i32 %xor374.1.1, 3
  %add376.1.1 = or disjoint i32 %mul375.1.1, %add363.1
  %add379.1.1 = or disjoint i32 %add376.1.1, %and248
  %gep691.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1
  %43 = load half, ptr addrspace(3) %gep691.1.1, align 2, !tbaa !141
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %43, i64 1
  %xor374.2.1 = xor i32 %add373.2, %add368.1
  %mul375.2.1 = shl nuw nsw i32 %xor374.2.1, 3
  %add376.2.1 = or disjoint i32 %mul375.2.1, %add363.2
  %add379.2.1 = or disjoint i32 %add376.2.1, %and248
  %gep691.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1
  %44 = load half, ptr addrspace(3) %gep691.2.1, align 2, !tbaa !141
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %44, i64 2
  %xor374.3.1 = xor i32 %add373.3, %add368.1
  %mul375.3.1 = shl nuw nsw i32 %xor374.3.1, 3
  %add376.3.1 = or disjoint i32 %mul375.3.1, %add363.3
  %add379.3.1 = or disjoint i32 %add376.3.1, %and248
  %gep691.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1
  %45 = load half, ptr addrspace(3) %gep691.3.1, align 2, !tbaa !141
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %45, i64 3
  %add368.2 = or disjoint i32 %shr367, 4
  %xor374.2729 = xor i32 %mul372, %add368.2
  %mul375.2730 = shl nuw nsw i32 %xor374.2729, 3
  %add376.2731 = or disjoint i32 %mul375.2730, %mul361
  %add379.2732 = or disjoint i32 %add376.2731, %and248
  %gep691.2733 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2732
  %46 = load half, ptr addrspace(3) %gep691.2733, align 2, !tbaa !141
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %46, i64 0
  %xor374.1.2 = xor i32 %add373.1, %add368.2
  %mul375.1.2 = shl nuw nsw i32 %xor374.1.2, 3
  %add376.1.2 = or disjoint i32 %mul375.1.2, %add363.1
  %add379.1.2 = or disjoint i32 %add376.1.2, %and248
  %gep691.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.2
  %47 = load half, ptr addrspace(3) %gep691.1.2, align 2, !tbaa !141
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %47, i64 1
  %xor374.2.2 = xor i32 %add373.2, %add368.2
  %mul375.2.2 = shl nuw nsw i32 %xor374.2.2, 3
  %add376.2.2 = or disjoint i32 %mul375.2.2, %add363.2
  %add379.2.2 = or disjoint i32 %add376.2.2, %and248
  %gep691.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.2
  %48 = load half, ptr addrspace(3) %gep691.2.2, align 2, !tbaa !141
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %48, i64 2
  %xor374.3.2 = xor i32 %add373.3, %add368.2
  %mul375.3.2 = shl nuw nsw i32 %xor374.3.2, 3
  %add376.3.2 = or disjoint i32 %mul375.3.2, %add363.3
  %add379.3.2 = or disjoint i32 %add376.3.2, %and248
  %gep691.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.2
  %49 = load half, ptr addrspace(3) %gep691.3.2, align 2, !tbaa !141
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %49, i64 3
  %add368.3 = or disjoint i32 %shr367, 6
  %xor374.3735 = xor i32 %mul372, %add368.3
  %mul375.3736 = shl nuw nsw i32 %xor374.3735, 3
  %add376.3737 = or disjoint i32 %mul375.3736, %mul361
  %add379.3738 = or disjoint i32 %add376.3737, %and248
  %gep691.3739 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3738
  %50 = load half, ptr addrspace(3) %gep691.3739, align 2, !tbaa !141
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %50, i64 0
  %xor374.1.3 = xor i32 %add373.1, %add368.3
  %mul375.1.3 = shl nuw nsw i32 %xor374.1.3, 3
  %add376.1.3 = or disjoint i32 %mul375.1.3, %add363.1
  %add379.1.3 = or disjoint i32 %add376.1.3, %and248
  %gep691.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.3
  %51 = load half, ptr addrspace(3) %gep691.1.3, align 2, !tbaa !141
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %51, i64 1
  %xor374.2.3 = xor i32 %add373.2, %add368.3
  %mul375.2.3 = shl nuw nsw i32 %xor374.2.3, 3
  %add376.2.3 = or disjoint i32 %mul375.2.3, %add363.2
  %add379.2.3 = or disjoint i32 %add376.2.3, %and248
  %gep691.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.3
  %52 = load half, ptr addrspace(3) %gep691.2.3, align 2, !tbaa !141
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %52, i64 2
  %xor374.3.3 = xor i32 %add373.3, %add368.3
  %mul375.3.3 = shl nuw nsw i32 %xor374.3.3, 3
  %add376.3.3 = or disjoint i32 %mul375.3.3, %add363.3
  %add379.3.3 = or disjoint i32 %add376.3.3, %and248
  %gep691.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.3
  %53 = load half, ptr addrspace(3) %gep691.3.3, align 2, !tbaa !141
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %53, i64 3
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer)
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer)
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer)
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer)
  br label %if.end411

if.end411:                                        ; preds = %for.cond355.preheader.preheader, %if.end346
  %acc_o.sroa.62.0 = phi <4 x float> [ %57, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ]
  %acc_o.sroa.42.0 = phi <4 x float> [ %56, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ]
  %acc_o.sroa.22.0 = phi <4 x float> [ %55, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ %54, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ]
  %or.cond702.1 = icmp ult i32 %mul11.1, 37
  br i1 %or.cond702.1, label %for.cond67.preheader.1, label %if.end231.1

for.cond67.preheader.1:                           ; preds = %if.end411
  %add74.1 = add nuw nsw i32 %mul11.1, %shr73
  %mul83.1 = shl nuw nsw i32 %mul11.1, 7
  %add87.1 = add nuw nsw i32 %add84, %mul83.1
  %58 = zext nneg i32 %add87.1 to i64
  %cmp76.1741 = icmp slt i32 %add74.1, 37
  br i1 %cmp76.1741, label %if.then77.1750, label %if.end115.1758

if.then77.1750:                                   ; preds = %for.cond67.preheader.1
  %add.ptr93.1742 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %58
  %condval_1.sroa.0.0.copyload.1743 = load i32, ptr addrspace(4) %add.ptr93.1742, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1744 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1742, i64 4
  %condval_1.sroa.5.0.copyload.1745 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1744, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1746 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1742, i64 8
  %condval_1.sroa.6.0.copyload.1747 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1746, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1748 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1742, i64 12
  %condval_1.sroa.7.0.copyload.1749 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1748, align 4, !tbaa !30
  br label %if.end115.1758

if.end115.1758:                                   ; preds = %if.then77.1750, %for.cond67.preheader.1
  %condval_1.sroa.0.0.1751 = phi i32 [ %condval_1.sroa.0.0.copyload.1743, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ]
  %condval_1.sroa.5.0.1752 = phi i32 [ %condval_1.sroa.5.0.copyload.1745, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ]
  %condval_1.sroa.6.0.1753 = phi i32 [ %condval_1.sroa.6.0.copyload.1747, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ]
  %condval_1.sroa.7.0.1754 = phi i32 [ %condval_1.sroa.7.0.copyload.1749, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ]
  %cmp76.1.1 = icmp slt i32 %add74.1, 29
  br i1 %cmp76.1.1, label %if.then77.1.1, label %if.end115.1.1

if.then77.1.1:                                    ; preds = %if.end115.1758
  %59 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %58
  %add.ptr93.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2048
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr93.1.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2052
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2056
  %condval_1.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2060
  %condval_1.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1, align 4, !tbaa !30
  br label %if.end115.1.1

if.end115.1.1:                                    ; preds = %if.then77.1.1, %if.end115.1758
  %condval_1.sroa.0.0.1.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ]
  %condval_1.sroa.5.0.1.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ]
  %condval_1.sroa.6.0.1.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ]
  %condval_1.sroa.7.0.1.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ]
  br i1 %cmp76.1741, label %if.then133.1768, label %if.end173.1776

if.then133.1768:                                  ; preds = %if.end115.1.1
  %add.ptr149.1760 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %58
  %condval_2.sroa.0.0.copyload.1761 = load i32, ptr addrspace(4) %add.ptr149.1760, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1762 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1760, i64 4
  %condval_2.sroa.5.0.copyload.1763 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1762, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1764 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1760, i64 8
  %condval_2.sroa.6.0.copyload.1765 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1764, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1766 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1760, i64 12
  %condval_2.sroa.7.0.copyload.1767 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1766, align 4, !tbaa !30
  br label %if.end173.1776

if.end173.1776:                                   ; preds = %if.then133.1768, %if.end115.1.1
  %condval_2.sroa.0.0.1769 = phi i32 [ %condval_2.sroa.0.0.copyload.1761, %if.then133.1768 ], [ 0, %if.end115.1.1 ]
  %condval_2.sroa.5.0.1770 = phi i32 [ %condval_2.sroa.5.0.copyload.1763, %if.then133.1768 ], [ 0, %if.end115.1.1 ]
  %condval_2.sroa.6.0.1771 = phi i32 [ %condval_2.sroa.6.0.copyload.1765, %if.then133.1768 ], [ 0, %if.end115.1.1 ]
  %condval_2.sroa.7.0.1772 = phi i32 [ %condval_2.sroa.7.0.copyload.1767, %if.then133.1768 ], [ 0, %if.end115.1.1 ]
  br i1 %cmp76.1.1, label %if.then133.1.1, label %if.end173.1.1

if.then133.1.1:                                   ; preds = %if.end173.1776
  %60 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %58
  %add.ptr149.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2048
  %condval_2.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr149.1.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2052
  %condval_2.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2056
  %condval_2.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2060
  %condval_2.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1, align 4, !tbaa !30
  br label %if.end173.1.1

if.end173.1.1:                                    ; preds = %if.then133.1.1, %if.end173.1776
  %condval_2.sroa.0.0.1.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ]
  %condval_2.sroa.5.0.1.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ]
  %condval_2.sroa.6.0.1.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ]
  %condval_2.sroa.7.0.1.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ]
  store i32 %condval_1.sroa.0.0.1751, ptr addrspace(3) %invariant.gep675, align 16, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep675.sroa_idx975 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 4
  store i32 %condval_1.sroa.5.0.1752, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx975, align 4, !tbaa !30
  %K_reg.sroa.8.0.invariant.gep675.sroa_idx977 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 8
  store i32 %condval_1.sroa.6.0.1753, ptr addrspace(3) %K_reg.sroa.8.0.invariant.gep675.sroa_idx977, align 8, !tbaa !30
  %K_reg.sroa.10.0.invariant.gep675.sroa_idx979 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 12
  store i32 %condval_1.sroa.7.0.1754, ptr addrspace(3) %K_reg.sroa.10.0.invariant.gep675.sroa_idx979, align 4, !tbaa !30
  %gep676.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1024
  store i32 %condval_1.sroa.0.0.1.1, ptr addrspace(3) %gep676.1.1, align 16, !tbaa !30
  %K_reg.sroa.16.16.gep676.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1028
  store i32 %condval_1.sroa.5.0.1.1, ptr addrspace(3) %K_reg.sroa.16.16.gep676.1.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.18.16.gep676.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1032
  store i32 %condval_1.sroa.6.0.1.1, ptr addrspace(3) %K_reg.sroa.18.16.gep676.1.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.20.16.gep676.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1036
  store i32 %condval_1.sroa.7.0.1.1, ptr addrspace(3) %K_reg.sroa.20.16.gep676.1.1.sroa_idx, align 4, !tbaa !30
  %cmp205.1 = icmp sgt i32 %mul11.1, 21
  br i1 %cmp205.1, label %for.cond207.preheader.1, label %if.end231.1

for.cond207.preheader.1:                          ; preds = %if.end173.1.1
  %add214.1 = add nuw nsw i32 %mul11.1, %mul213
  %cmp216.1777 = icmp slt i32 %add214.1, 37
  %.fneg.1778 = select i1 %cmp216.1777, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert891 = insertelement <4 x float> poison, float %.fneg.1778, i64 0
  %add215.1.1 = or disjoint i32 %add214.1, 1
  %cmp216.1.1 = icmp slt i32 %add215.1.1, 37
  %.fneg.1.1 = select i1 %cmp216.1.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert914 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert891, float %.fneg.1.1, i64 1
  %add215.2.1 = or disjoint i32 %add214.1, 2
  %cmp216.2.1 = icmp slt i32 %add215.2.1, 37
  %.fneg.2.1 = select i1 %cmp216.2.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert935 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert914, float %.fneg.2.1, i64 2
  %add215.3.1 = or disjoint i32 %add214.1, 3
  %cmp216.3.1 = icmp slt i32 %add215.3.1, 37
  %.fneg.3.1 = select i1 %cmp216.3.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert956 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert935, float %.fneg.3.1, i64 3
  br label %if.end231.1

if.end231.1:                                      ; preds = %if.end173.1.1, %for.cond207.preheader.1, %if.end411
  %V_reg.sroa.20.1 = phi i32 [ %condval_2.sroa.7.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.20.0, %if.end411 ], [ %condval_2.sroa.7.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.18.1 = phi i32 [ %condval_2.sroa.6.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.18.0, %if.end411 ], [ %condval_2.sroa.6.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.16.1 = phi i32 [ %condval_2.sroa.5.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.16.0, %if.end411 ], [ %condval_2.sroa.5.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.12.1 = phi i32 [ %condval_2.sroa.0.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.12.0, %if.end411 ], [ %condval_2.sroa.0.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.10.1 = phi i32 [ %condval_2.sroa.7.0.1772, %for.cond207.preheader.1 ], [ %V_reg.sroa.10.0, %if.end411 ], [ %condval_2.sroa.7.0.1772, %if.end173.1.1 ]
  %V_reg.sroa.8.1 = phi i32 [ %condval_2.sroa.6.0.1771, %for.cond207.preheader.1 ], [ %V_reg.sroa.8.0, %if.end411 ], [ %condval_2.sroa.6.0.1771, %if.end173.1.1 ]
  %V_reg.sroa.6.1 = phi i32 [ %condval_2.sroa.5.0.1770, %for.cond207.preheader.1 ], [ %V_reg.sroa.6.0, %if.end411 ], [ %condval_2.sroa.5.0.1770, %if.end173.1.1 ]
  %V_reg.sroa.0.1 = phi i32 [ %condval_2.sroa.0.0.1769, %for.cond207.preheader.1 ], [ %V_reg.sroa.0.0, %if.end411 ], [ %condval_2.sroa.0.0.1769, %if.end173.1.1 ]
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert956, %for.cond207.preheader.1 ], [ %acc_s.sroa.0.1, %if.end411 ], [ zeroinitializer, %if.end173.1.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702.1, label %for.cond236.preheader.1, label %if.end346.1

for.cond236.preheader.1:                          ; preds = %if.end231.1
  %xor249.1779 = xor i32 %shr245, %and248
  %add.ptr253.idx.1780 = shl nuw nsw i32 %xor249.1779, 4
  %add.ptr253.1781 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx.1780
  %kb.sroa.0.0.copyload869 = load <4 x half>, ptr addrspace(3) %add.ptr253.1781, align 16
  %kb.sroa.10.0.add.ptr253.1781.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1781, i32 8
  %kb.sroa.10.0.copyload872 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.1781.sroa_idx, align 8
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload869, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !82
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload872, <4 x half> %Q_reg.sroa.5.0.copyload, <4 x float> %61), !call_argsrelate !82
  %add246.1.1 = add nuw nsw i32 %shr245, 4
  %xor249.1.1 = xor i32 %add246.1.1, %and248
  %add.ptr253.idx.1.1 = shl nuw nsw i32 %xor249.1.1, 4
  %add.ptr253.1.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx.1.1
  %kb.sroa.0.0.copyload870 = load <4 x half>, ptr addrspace(3) %add.ptr253.1.1, align 16
  %kb.sroa.10.0.add.ptr253.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1.1, i32 8
  %kb.sroa.10.0.copyload873 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.1.1.sroa_idx, align 8
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload870, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %62), !call_argsrelate !82
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload873, <4 x half> %Q_reg.sroa.10.16.copyload, <4 x float> %63), !call_argsrelate !82
  store i32 %V_reg.sroa.0.1, ptr addrspace(3) %invariant.gep687, align 16, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep687.sroa_idx964 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2052
  store i32 %V_reg.sroa.6.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx964, align 4, !tbaa !30
  %V_reg.sroa.8.0.invariant.gep687.sroa_idx966 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2056
  store i32 %V_reg.sroa.8.1, ptr addrspace(3) %V_reg.sroa.8.0.invariant.gep687.sroa_idx966, align 8, !tbaa !30
  %V_reg.sroa.10.0.invariant.gep687.sroa_idx968 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2060
  store i32 %V_reg.sroa.10.1, ptr addrspace(3) %V_reg.sroa.10.0.invariant.gep687.sroa_idx968, align 4, !tbaa !30
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3072
  store i32 %V_reg.sroa.12.1, ptr addrspace(3) %gep.1.1, align 16, !tbaa !30
  %V_reg.sroa.16.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3076
  store i32 %V_reg.sroa.16.1, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.18.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3080
  store i32 %V_reg.sroa.18.1, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.20.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3084
  store i32 %V_reg.sroa.20.1, ptr addrspace(3) %V_reg.sroa.20.16.gep.1.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract893 = extractelement <4 x float> %64, i64 0
  %mul310.1784 = fmul contract float %acc_s.sroa.0.0.vec.extract893, 0x3FC2776C60000000
  %65 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1784, float 1.500000e+01)
  %cmp.i.i.1785 = fcmp contract olt float %65, -1.260000e+02
  %cond.i.i.1786 = select contract i1 %cmp.i.i.1785, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.1787 = fadd contract float %65, %cond.i.i.1786
  %66 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1787)
  %cond2.i.i.1788 = select contract i1 %cmp.i.i.1785, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1789 = fmul contract float %cond2.i.i.1788, %66
  %acc_s.sroa.0.4.vec.extract916 = extractelement <4 x float> %64, i64 1
  %mul310.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract916, 0x3FC2776C60000000
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1.1, float 1.500000e+01)
  %cmp.i.i.1.1 = fcmp contract olt float %67, -1.260000e+02
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.1.1 = fadd contract float %67, %cond.i.i.1.1
  %68 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1.1)
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %68
  %acc_s.sroa.0.8.vec.extract937 = extractelement <4 x float> %64, i64 2
  %mul310.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract937, 0x3FC2776C60000000
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2.1, float 1.500000e+01)
  %cmp.i.i.2.1 = fcmp contract olt float %69, -1.260000e+02
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.2.1 = fadd contract float %69, %cond.i.i.2.1
  %70 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2.1)
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %70
  %acc_s.sroa.0.12.vec.extract958 = extractelement <4 x float> %64, i64 3
  %mul310.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract958, 0x3FC2776C60000000
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3.1, float 1.500000e+01)
  %cmp.i.i.3.1 = fcmp contract olt float %71, -1.260000e+02
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.3.1 = fadd contract float %71, %cond.i.i.3.1
  %72 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3.1)
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %72
  %add326.1790 = fadd contract float %sum_acc.sroa.0.0, %mul.i.i.1789
  %add326.1.1 = fadd contract float %sum_acc.sroa.8.0, %mul.i.i.1.1
  %add326.2.1 = fadd contract float %sum_acc.sroa.14.0, %mul.i.i.2.1
  %add326.3.1 = fadd contract float %sum_acc.sroa.20.0, %mul.i.i.3.1
  %73 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !105
  %74 = fptrunc float %mul.i.i.1789 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %73), !noalias !105
  %75 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !105
  %76 = fptrunc float %mul.i.i.1.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %75), !noalias !105
  %__1.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %74, i64 0
  %__1.sroa.0.2.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.0.vec.insert.1, half %76, i64 1
  %77 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !119
  %78 = fptrunc float %mul.i.i.2.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %77), !noalias !119
  %79 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !119
  %80 = fptrunc float %mul.i.i.3.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %79), !noalias !119
  %__1.sroa.0.4.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.2.vec.insert.1, half %78, i64 2
  %__1.sroa.0.6.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.4.vec.insert.1, half %80, i64 3
  br label %if.end346.1

if.end346.1:                                      ; preds = %for.cond236.preheader.1, %if.end231.1
  %sum_acc.sroa.20.1 = phi float [ %add326.3.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.20.0, %if.end231.1 ]
  %sum_acc.sroa.14.1 = phi float [ %add326.2.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.14.0, %if.end231.1 ]
  %sum_acc.sroa.8.1 = phi float [ %add326.1.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.8.0, %if.end231.1 ]
  %sum_acc.sroa.0.1 = phi float [ %add326.1790, %for.cond236.preheader.1 ], [ %sum_acc.sroa.0.0, %if.end231.1 ]
  %acc_s_cast.sroa.0.1.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert.1, %for.cond236.preheader.1 ], [ %acc_s_cast.sroa.0.1, %if.end231.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702.1, label %for.cond355.preheader.preheader.1, label %if.end411.1

for.cond355.preheader.preheader.1:                ; preds = %if.end346.1
  %xor374.1791 = or disjoint i32 %mul372, %shr367
  %mul375.1792 = shl nuw nsw i32 %xor374.1791, 3
  %add376.1793 = or disjoint i32 %mul375.1792, %mul361
  %add379.1794 = or disjoint i32 %add376.1793, %and248
  %gep691.1795 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1794
  %81 = load half, ptr addrspace(3) %gep691.1795, align 2, !tbaa !141
  %vb.sroa.0.0.vec.insert828 = insertelement <4 x half> poison, half %81, i64 0
  %add363.1.1796 = or disjoint i32 %mul361, 64
  %add373.1.1797 = or disjoint i32 %mul372, 1
  %xor374.1.1798 = xor i32 %add373.1.1797, %shr367
  %mul375.1.1799 = shl nuw nsw i32 %xor374.1.1798, 3
  %add376.1.1800 = or disjoint i32 %mul375.1.1799, %add363.1.1796
  %add379.1.1801 = or disjoint i32 %add376.1.1800, %and248
  %gep691.1.1802 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1801
  %82 = load half, ptr addrspace(3) %gep691.1.1802, align 2, !tbaa !141
  %vb.sroa.0.2.vec.insert830 = insertelement <4 x half> %vb.sroa.0.0.vec.insert828, half %82, i64 1
  %add363.2.1804 = or disjoint i32 %mul361, 128
  %add373.2.1805 = or disjoint i32 %mul372, 2
  %xor374.2.1806 = or disjoint i32 %add373.2.1805, %shr367
  %mul375.2.1807 = shl nuw nsw i32 %xor374.2.1806, 3
  %add376.2.1808 = or disjoint i32 %mul375.2.1807, %add363.2.1804
  %add379.2.1809 = or disjoint i32 %add376.2.1808, %and248
  %gep691.2.1810 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1809
  %83 = load half, ptr addrspace(3) %gep691.2.1810, align 2, !tbaa !141
  %vb.sroa.0.4.vec.insert832 = insertelement <4 x half> %vb.sroa.0.2.vec.insert830, half %83, i64 2
  %add363.3.1812 = or disjoint i32 %mul361, 192
  %add373.3.1813 = or disjoint i32 %mul372, 3
  %xor374.3.1814 = xor i32 %add373.3.1813, %shr367
  %mul375.3.1815 = shl nuw nsw i32 %xor374.3.1814, 3
  %add376.3.1816 = or disjoint i32 %mul375.3.1815, %add363.3.1812
  %add379.3.1817 = or disjoint i32 %add376.3.1816, %and248
  %gep691.3.1818 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1817
  %84 = load half, ptr addrspace(3) %gep691.3.1818, align 2, !tbaa !141
  %vb.sroa.0.6.vec.insert834 = insertelement <4 x half> %vb.sroa.0.4.vec.insert832, half %84, i64 3
  %add368.1.1 = or disjoint i32 %shr367, 2
  %xor374.1723.1 = or disjoint i32 %mul372, %add368.1.1
  %mul375.1724.1 = shl nuw nsw i32 %xor374.1723.1, 3
  %add376.1725.1 = or disjoint i32 %mul375.1724.1, %mul361
  %add379.1726.1 = or disjoint i32 %add376.1725.1, %and248
  %gep691.1727.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1726.1
  %85 = load half, ptr addrspace(3) %gep691.1727.1, align 2, !tbaa !141
  %vb.sroa.12.8.vec.insert838 = insertelement <4 x half> poison, half %85, i64 0
  %xor374.1.1.1 = xor i32 %add373.1.1797, %add368.1.1
  %mul375.1.1.1 = shl nuw nsw i32 %xor374.1.1.1, 3
  %add376.1.1.1 = or disjoint i32 %mul375.1.1.1, %add363.1.1796
  %add379.1.1.1 = or disjoint i32 %add376.1.1.1, %and248
  %gep691.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1.1
  %86 = load half, ptr addrspace(3) %gep691.1.1.1, align 2, !tbaa !141
  %vb.sroa.12.10.vec.insert840 = insertelement <4 x half> %vb.sroa.12.8.vec.insert838, half %86, i64 1
  %xor374.2.1.1 = xor i32 %add373.2.1805, %add368.1.1
  %mul375.2.1.1 = shl nuw nsw i32 %xor374.2.1.1, 3
  %add376.2.1.1 = or disjoint i32 %mul375.2.1.1, %add363.2.1804
  %add379.2.1.1 = or disjoint i32 %add376.2.1.1, %and248
  %gep691.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1.1
  %87 = load half, ptr addrspace(3) %gep691.2.1.1, align 2, !tbaa !141
  %vb.sroa.12.12.vec.insert842 = insertelement <4 x half> %vb.sroa.12.10.vec.insert840, half %87, i64 2
  %xor374.3.1.1 = xor i32 %add373.3.1813, %add368.1.1
  %mul375.3.1.1 = shl nuw nsw i32 %xor374.3.1.1, 3
  %add376.3.1.1 = or disjoint i32 %mul375.3.1.1, %add363.3.1812
  %add379.3.1.1 = or disjoint i32 %add376.3.1.1, %and248
  %gep691.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1.1
  %88 = load half, ptr addrspace(3) %gep691.3.1.1, align 2, !tbaa !141
  %vb.sroa.12.14.vec.insert844 = insertelement <4 x half> %vb.sroa.12.12.vec.insert842, half %88, i64 3
  %add368.2.1 = or disjoint i32 %shr367, 4
  %xor374.2729.1 = xor i32 %mul372, %add368.2.1
  %mul375.2730.1 = shl nuw nsw i32 %xor374.2729.1, 3
  %add376.2731.1 = or disjoint i32 %mul375.2730.1, %mul361
  %add379.2732.1 = or disjoint i32 %add376.2731.1, %and248
  %gep691.2733.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2732.1
  %89 = load half, ptr addrspace(3) %gep691.2733.1, align 2, !tbaa !141
  %vb.sroa.22.16.vec.insert848 = insertelement <4 x half> poison, half %89, i64 0
  %xor374.1.2.1 = xor i32 %add373.1.1797, %add368.2.1
  %mul375.1.2.1 = shl nuw nsw i32 %xor374.1.2.1, 3
  %add376.1.2.1 = or disjoint i32 %mul375.1.2.1, %add363.1.1796
  %add379.1.2.1 = or disjoint i32 %add376.1.2.1, %and248
  %gep691.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.2.1
  %90 = load half, ptr addrspace(3) %gep691.1.2.1, align 2, !tbaa !141
  %vb.sroa.22.18.vec.insert850 = insertelement <4 x half> %vb.sroa.22.16.vec.insert848, half %90, i64 1
  %xor374.2.2.1 = xor i32 %add373.2.1805, %add368.2.1
  %mul375.2.2.1 = shl nuw nsw i32 %xor374.2.2.1, 3
  %add376.2.2.1 = or disjoint i32 %mul375.2.2.1, %add363.2.1804
  %add379.2.2.1 = or disjoint i32 %add376.2.2.1, %and248
  %gep691.2.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.2.1
  %91 = load half, ptr addrspace(3) %gep691.2.2.1, align 2, !tbaa !141
  %vb.sroa.22.20.vec.insert852 = insertelement <4 x half> %vb.sroa.22.18.vec.insert850, half %91, i64 2
  %xor374.3.2.1 = xor i32 %add373.3.1813, %add368.2.1
  %mul375.3.2.1 = shl nuw nsw i32 %xor374.3.2.1, 3
  %add376.3.2.1 = or disjoint i32 %mul375.3.2.1, %add363.3.1812
  %add379.3.2.1 = or disjoint i32 %add376.3.2.1, %and248
  %gep691.3.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.2.1
  %92 = load half, ptr addrspace(3) %gep691.3.2.1, align 2, !tbaa !141
  %vb.sroa.22.22.vec.insert854 = insertelement <4 x half> %vb.sroa.22.20.vec.insert852, half %92, i64 3
  %add368.3.1 = or disjoint i32 %shr367, 6
  %xor374.3735.1 = xor i32 %mul372, %add368.3.1
  %mul375.3736.1 = shl nuw nsw i32 %xor374.3735.1, 3
  %add376.3737.1 = or disjoint i32 %mul375.3736.1, %mul361
  %add379.3738.1 = or disjoint i32 %add376.3737.1, %and248
  %gep691.3739.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3738.1
  %93 = load half, ptr addrspace(3) %gep691.3739.1, align 2, !tbaa !141
  %vb.sroa.32.24.vec.insert858 = insertelement <4 x half> poison, half %93, i64 0
  %xor374.1.3.1 = xor i32 %add373.1.1797, %add368.3.1
  %mul375.1.3.1 = shl nuw nsw i32 %xor374.1.3.1, 3
  %add376.1.3.1 = or disjoint i32 %mul375.1.3.1, %add363.1.1796
  %add379.1.3.1 = or disjoint i32 %add376.1.3.1, %and248
  %gep691.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.3.1
  %94 = load half, ptr addrspace(3) %gep691.1.3.1, align 2, !tbaa !141
  %vb.sroa.32.26.vec.insert860 = insertelement <4 x half> %vb.sroa.32.24.vec.insert858, half %94, i64 1
  %xor374.2.3.1 = xor i32 %add373.2.1805, %add368.3.1
  %mul375.2.3.1 = shl nuw nsw i32 %xor374.2.3.1, 3
  %add376.2.3.1 = or disjoint i32 %mul375.2.3.1, %add363.2.1804
  %add379.2.3.1 = or disjoint i32 %add376.2.3.1, %and248
  %gep691.2.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.3.1
  %95 = load half, ptr addrspace(3) %gep691.2.3.1, align 2, !tbaa !141
  %vb.sroa.32.28.vec.insert862 = insertelement <4 x half> %vb.sroa.32.26.vec.insert860, half %95, i64 2
  %xor374.3.3.1 = xor i32 %add373.3.1813, %add368.3.1
  %mul375.3.3.1 = shl nuw nsw i32 %xor374.3.3.1, 3
  %add376.3.3.1 = or disjoint i32 %mul375.3.3.1, %add363.3.1812
  %add379.3.3.1 = or disjoint i32 %add376.3.3.1, %and248
  %gep691.3.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.3.1
  %96 = load half, ptr addrspace(3) %gep691.3.3.1, align 2, !tbaa !141
  %vb.sroa.32.30.vec.insert864 = insertelement <4 x half> %vb.sroa.32.28.vec.insert862, half %96, i64 3
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert834, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.0.0)
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert844, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.22.0)
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert854, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.42.0)
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert864, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.62.0)
  br label %if.end411.1

if.end411.1:                                      ; preds = %for.cond355.preheader.preheader.1, %if.end346.1
  %acc_o.sroa.62.1 = phi <4 x float> [ %100, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.62.0, %if.end346.1 ]
  %acc_o.sroa.42.1 = phi <4 x float> [ %99, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.42.0, %if.end346.1 ]
  %acc_o.sroa.22.1 = phi <4 x float> [ %98, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.22.0, %if.end346.1 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %97, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.0.0, %if.end346.1 ]
  %add423 = fadd contract float %sum_acc.sroa.0.1, 0.000000e+00
  %add423.1 = fadd contract float %add423, %sum_acc.sroa.8.1
  %add423.2 = fadd contract float %add423.1, %sum_acc.sroa.14.1
  %add423.3 = fadd contract float %add423.2, %sum_acc.sroa.20.1
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %101 = bitcast float %add423.3 to i32
  %102 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %103 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %102) #10
  %xor.i.i = xor i32 %103, 32
  %104 = and i32 %103, -64
  %and.i.i = add nsw i32 %104, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i638 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %103
  %shl.i.i = shl i32 %cond.i.i638, 2
  %105 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %101)
  %106 = bitcast i32 %105 to float
  %add.i = fadd contract float %add423.3, %106
  %107 = bitcast float %add.i to i32
  %108 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %109 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %108) #10
  %xor.i.i639 = xor i32 %109, 16
  %110 = and i32 %109, -64
  %and.i.i640 = add nsw i32 %110, 64
  %cmp.not.i.i641 = icmp slt i32 %xor.i.i639, %and.i.i640
  %cond.i.i642 = select i1 %cmp.not.i.i641, i32 %xor.i.i639, i32 %109
  %shl.i.i643 = shl i32 %cond.i.i642, 2
  %111 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i643, i32 %107)
  %112 = bitcast i32 %111 to float
  %add.i.i = fadd contract float %add.i, %112
  %cmp432 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp432, float %div, float 0.000000e+00
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0
  %mul445 = fmul contract float %condval_4.0, %acc_o.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1
  %mul445.1 = fmul contract float %condval_4.0, %acc_o.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2
  %mul445.2 = fmul contract float %condval_4.0, %acc_o.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3
  %mul445.3 = fmul contract float %condval_4.0, %acc_o.sroa.0.12.vec.extract
  %acc_o.sroa.22.16.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 0
  %mul445.4 = fmul contract float %condval_4.0, %acc_o.sroa.22.16.vec.extract
  %acc_o.sroa.22.20.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 1
  %mul445.5 = fmul contract float %condval_4.0, %acc_o.sroa.22.20.vec.extract
  %acc_o.sroa.22.24.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 2
  %mul445.6 = fmul contract float %condval_4.0, %acc_o.sroa.22.24.vec.extract
  %acc_o.sroa.22.28.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 3
  %mul445.7 = fmul contract float %condval_4.0, %acc_o.sroa.22.28.vec.extract
  %acc_o.sroa.42.32.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 0
  %mul445.8 = fmul contract float %condval_4.0, %acc_o.sroa.42.32.vec.extract
  %acc_o.sroa.42.36.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 1
  %mul445.9 = fmul contract float %condval_4.0, %acc_o.sroa.42.36.vec.extract
  %acc_o.sroa.42.40.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 2
  %mul445.10 = fmul contract float %condval_4.0, %acc_o.sroa.42.40.vec.extract
  %acc_o.sroa.42.44.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 3
  %mul445.11 = fmul contract float %condval_4.0, %acc_o.sroa.42.44.vec.extract
  %acc_o.sroa.62.48.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 0
  %mul445.12 = fmul contract float %condval_4.0, %acc_o.sroa.62.48.vec.extract
  %acc_o.sroa.62.52.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 1
  %mul445.13 = fmul contract float %condval_4.0, %acc_o.sroa.62.52.vec.extract
  %acc_o.sroa.62.56.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 2
  %mul445.14 = fmul contract float %condval_4.0, %acc_o.sroa.62.56.vec.extract
  %acc_o.sroa.62.60.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 3
  %mul445.15 = fmul contract float %condval_4.0, %acc_o.sroa.62.60.vec.extract
  %add483 = add nuw nsw i32 %add26, %mul213
  %113 = zext nneg i32 %add483 to i64
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %115 = fptrunc float %mul445 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !noalias !211
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %117 = fptrunc float %mul445.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !noalias !211
  %118 = bitcast half %115 to i16
  %119 = bitcast half %117 to i16
  %120 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %121 = fptrunc float %mul445.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %120), !noalias !226
  %122 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %123 = fptrunc float %mul445.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %122), !noalias !226
  %124 = bitcast half %121 to i16
  %125 = bitcast half %123 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %125 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %124 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %119 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %118 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr489 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr489, align 8
  %126 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %127 = fptrunc float %mul445.4 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %126), !noalias !211
  %128 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %129 = fptrunc float %mul445.5 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %128), !noalias !211
  %130 = bitcast half %127 to i16
  %131 = bitcast half %129 to i16
  %132 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %133 = fptrunc float %mul445.6 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %132), !noalias !226
  %134 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %135 = fptrunc float %mul445.7 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %134), !noalias !226
  %136 = bitcast half %133 to i16
  %137 = bitcast half %135 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %137 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %136 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %131 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %130 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %138 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113
  %add.ptr489.1 = getelementptr inbounds i8, ptr addrspace(1) %138, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr489.1, align 8
  %139 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %140 = fptrunc float %mul445.8 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %139), !noalias !211
  %141 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %142 = fptrunc float %mul445.9 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %141), !noalias !211
  %143 = bitcast half %140 to i16
  %144 = bitcast half %142 to i16
  %145 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %146 = fptrunc float %mul445.10 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %145), !noalias !226
  %147 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %148 = fptrunc float %mul445.11 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %147), !noalias !226
  %149 = bitcast half %146 to i16
  %150 = bitcast half %148 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %150 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %149 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %144 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %143 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113
  %add.ptr489.2 = getelementptr inbounds i8, ptr addrspace(1) %151, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr489.2, align 8
  %152 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %153 = fptrunc float %mul445.12 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %152), !noalias !211
  %154 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !211
  %155 = fptrunc float %mul445.13 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %154), !noalias !211
  %156 = bitcast half %153 to i16
  %157 = bitcast half %155 to i16
  %158 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %159 = fptrunc float %mul445.14 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %158), !noalias !226
  %160 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !226
  %161 = fptrunc float %mul445.15 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %160), !noalias !226
  %162 = bitcast half %159 to i16
  %163 = bitcast half %161 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %163 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %162 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %157 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %156 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %164 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113
  %add.ptr489.3 = getelementptr inbounds i8, ptr addrspace(1) %164, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr489.3, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier() #6

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #7

declare float @llvm.exp2.f32(float) #8

declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

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


