target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %1, 6
  %mul7 = and i32 %and, 960
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %mul22 = shl nuw nsw i32 %0, 1
  %5 = zext nneg i32 %mul22 to i64
  %arrayidx24 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5
  %6 = load i32, ptr addrspace(1) %arrayidx24, align 4, !tbaa !30
  %cmp26 = icmp ult i32 %6, 25
  %7 = shl nsw i32 %6, 4
  %mul27 = select i1 %cmp26, i32 %7, i32 -16
  %8 = or disjoint i64 %5, 1
  %arrayidx24.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx24.1, align 4, !tbaa !30
  %cmp26.1 = icmp ult i32 %9, 25
  %10 = shl nsw i32 %9, 4
  %mul27.1 = select i1 %cmp26.1, i32 %10, i32 -16
  %shr62 = lshr i32 %1, 3
  %11 = shl nuw nsw i32 %1, 3
  %12 = and i32 %11, 56
  %add58 = add nsw i32 %shr62, %mul27
  %or.cond = icmp ult i32 %add58, 400
  br i1 %or.cond, label %if.then70, label %if.then52.1

if.then70:                                        ; preds = %entry
  %13 = shl nuw nsw i32 %add58, 6
  %add76779 = or disjoint i32 %13, %12
  %add76 = zext nneg i32 %add76779 to i64
  %add.ptr77 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76
  %condval_2.sroa.7.0.add.ptr77.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77, i64 4
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr77, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx, align 4, !tbaa !30
  br label %if.then52.1

if.then52.1:                                      ; preds = %if.then70, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then70 ], [ 0, %entry ]
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then70 ], [ 0, %entry ]
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then70 ], [ 0, %entry ]
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then70 ], [ 0, %entry ]
  %add56.1 = add nuw nsw i32 %shr62, 8
  %add58.1 = add nsw i32 %add56.1, %mul27
  %or.cond.1 = icmp ult i32 %add58.1, 400
  br i1 %or.cond.1, label %if.then70.1, label %if.else59.2

if.then70.1:                                      ; preds = %if.then52.1
  %14 = shl nuw nsw i32 %add58.1, 6
  %add76779.1 = or disjoint i32 %14, %12
  %add76.1 = zext nneg i32 %add76779.1 to i64
  %add.ptr77.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76.1
  %condval_2.sroa.7.0.add.ptr77.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.1, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.1, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.1, i64 4
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr77.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx.1, align 4, !tbaa !30
  br label %if.else59.2

if.else59.2:                                      ; preds = %if.then52.1, %if.then70.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ]
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ]
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ]
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ]
  %sub.2 = add i32 %shr62, %mul27.1
  %or.cond.2 = icmp ult i32 %sub.2, 400
  br i1 %or.cond.2, label %if.then70.2, label %if.else59.3

if.then70.2:                                      ; preds = %if.else59.2
  %15 = shl nuw nsw i32 %sub.2, 6
  %add76779.2 = or disjoint i32 %15, %12
  %add76.2 = zext nneg i32 %add76779.2 to i64
  %add.ptr77.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76.2
  %condval_2.sroa.7.0.add.ptr77.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.2, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.2, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.2, i64 4
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr77.2, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx.2, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx.2, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx.2, align 4, !tbaa !30
  br label %if.else59.3

if.else59.3:                                      ; preds = %if.else59.2, %if.then70.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ]
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ]
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ]
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ]
  %add65.3 = add nuw nsw i32 %shr62, 8
  %sub.3 = add i32 %add65.3, %mul27.1
  %or.cond.3 = icmp ult i32 %sub.3, 400
  br i1 %or.cond.3, label %if.then70.3, label %if.then113

if.then70.3:                                      ; preds = %if.else59.3
  %16 = shl nuw nsw i32 %sub.3, 6
  %add76779.3 = or disjoint i32 %16, %12
  %add76.3 = zext nneg i32 %add76779.3 to i64
  %add.ptr77.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76.3
  %condval_2.sroa.7.0.add.ptr77.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.3, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.3, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.3, i64 4
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr77.3, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx.3, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx.3, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx.3, align 4, !tbaa !30
  br label %if.then113

if.then113:                                       ; preds = %if.else59.3, %if.then70.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ]
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ]
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ]
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ]
  %add119 = add nsw i32 %shr62, %mul27
  %or.cond704 = icmp ult i32 %add119, 400
  br i1 %or.cond704, label %if.then132, label %if.then113.1

if.then132:                                       ; preds = %if.then113
  %17 = shl nuw nsw i32 %add119, 6
  %add139780 = or disjoint i32 %17, %12
  %add139 = zext nneg i32 %add139780 to i64
  %add.ptr140 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139
  %condval_4.sroa.7.0.add.ptr140.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140, i64 4
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr140, align 16, !tbaa !30
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx, align 4, !tbaa !30
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx, align 8, !tbaa !30
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx, align 4, !tbaa !30
  br label %if.then113.1

if.then113.1:                                     ; preds = %if.then132, %if.then113
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then132 ], [ 0, %if.then113 ]
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then132 ], [ 0, %if.then113 ]
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then132 ], [ 0, %if.then113 ]
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then132 ], [ 0, %if.then113 ]
  %add117.1 = add nuw nsw i32 %shr62, 8
  %add119.1 = add nsw i32 %add117.1, %mul27
  %or.cond704.1 = icmp ult i32 %add119.1, 400
  br i1 %or.cond704.1, label %if.then132.1, label %if.else120.2

if.then132.1:                                     ; preds = %if.then113.1
  %18 = shl nuw nsw i32 %add119.1, 6
  %add139780.1 = or disjoint i32 %18, %12
  %add139.1 = zext nneg i32 %add139780.1 to i64
  %add.ptr140.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139.1
  %condval_4.sroa.7.0.add.ptr140.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.1, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.1, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.1, i64 4
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr140.1, align 16, !tbaa !30
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx.1, align 4, !tbaa !30
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx.1, align 8, !tbaa !30
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx.1, align 4, !tbaa !30
  br label %if.else120.2

if.else120.2:                                     ; preds = %if.then113.1, %if.then132.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ]
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ]
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ]
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ]
  %sub127.2 = add i32 %shr62, %mul27.1
  %or.cond704.2 = icmp ult i32 %sub127.2, 400
  br i1 %or.cond704.2, label %if.then132.2, label %if.else120.3

if.then132.2:                                     ; preds = %if.else120.2
  %19 = shl nuw nsw i32 %sub127.2, 6
  %add139780.2 = or disjoint i32 %19, %12
  %add139.2 = zext nneg i32 %add139780.2 to i64
  %add.ptr140.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139.2
  %condval_4.sroa.7.0.add.ptr140.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.2, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.2, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.2, i64 4
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr140.2, align 16, !tbaa !30
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx.2, align 4, !tbaa !30
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx.2, align 8, !tbaa !30
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx.2, align 4, !tbaa !30
  br label %if.else120.3

if.else120.3:                                     ; preds = %if.else120.2, %if.then132.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ]
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ]
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ]
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ]
  %add126.3 = add nuw nsw i32 %shr62, 8
  %sub127.3 = add i32 %add126.3, %mul27.1
  %or.cond704.3 = icmp ult i32 %sub127.3, 400
  br i1 %or.cond704.3, label %if.then132.3, label %if.end164.3

if.then132.3:                                     ; preds = %if.else120.3
  %20 = shl nuw nsw i32 %sub127.3, 6
  %add139780.3 = or disjoint i32 %20, %12
  %add139.3 = zext nneg i32 %add139780.3 to i64
  %add.ptr140.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139.3
  %condval_4.sroa.7.0.add.ptr140.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.3, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.3, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.3, i64 4
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr140.3, align 16, !tbaa !30
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx.3, align 4, !tbaa !30
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx.3, align 8, !tbaa !30
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx.3, align 4, !tbaa !30
  br label %if.end164.3

if.end164.3:                                      ; preds = %if.then132.3, %if.else120.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ]
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ]
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ]
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ]
  %mul184 = and i32 %11, 8128
  %call188.masked = and i32 %1, 1016
  %mul190 = xor i32 %12, %call188.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul184
  %invariant.gep751 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul190
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep751, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep751.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 4
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep751.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep751.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 8
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep751.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep751.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 12
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep751.sroa_idx, align 4, !tbaa !30
  %gep752.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 1024
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep752.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep752.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 1028
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep752.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep752.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 1032
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep752.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep752.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 1036
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep752.1.sroa_idx, align 4, !tbaa !30
  %gep752.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 2048
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep752.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.gep752.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 2052
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep752.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.gep752.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 2056
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep752.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.gep752.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 2060
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep752.2.sroa_idx, align 4, !tbaa !30
  %gep752.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 3072
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep752.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.gep752.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 3076
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep752.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.gep752.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 3080
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep752.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.gep752.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep751, i32 3084
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep752.3.sroa_idx, align 4, !tbaa !30
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %shr227 = lshr i32 %1, 4
  %and230 = and i32 %1, 7
  %xor231 = xor i32 %shr227, %and230
  %add.ptr235.idx = shl nuw nsw i32 %xor231, 4
  %invariant.gep755 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr235.idx
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep755, i32 %mul7
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8
  %add224.1 = or disjoint i32 %mul7, 1024
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep755, i32 %add224.1
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !81
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !81
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %21), !call_argsrelate !81
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !call_argsrelate !81
  %add228.1 = add nuw nsw i32 %shr227, 4
  %xor231.1 = xor i32 %add228.1, %and230
  %add.ptr235.idx.1 = shl nuw nsw i32 %xor231.1, 4
  %invariant.gep755.1 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr235.idx.1
  %gep.1790 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep755.1, i32 %mul7
  %kb.sroa.0.0.copyload879 = load <4 x half>, ptr addrspace(3) %gep.1790, align 16
  %kb.sroa.6.0.gep.1790.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1790, i32 8
  %kb.sroa.6.0.copyload880 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1790.sroa_idx, align 8
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep755.1, i32 %add224.1
  %kb.sroa.8.16.copyload883 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8
  %kb.sroa.12.16.copyload884 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload879, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23), !call_argsrelate !81
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload883, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !call_argsrelate !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload880, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !call_argsrelate !81
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload884, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !call_argsrelate !81
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %add.ptr289.idx = shl nuw nsw i32 %1, 4
  %invariant.gep760 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr289.idx
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep760, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep760.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 4
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep760.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep760.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 8
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep760.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep760.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 12
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep760.sroa_idx, align 4, !tbaa !30
  %gep761.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 1024
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep761.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep761.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 1028
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep761.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep761.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 1032
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep761.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep761.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 1036
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep761.1.sroa_idx, align 4, !tbaa !30
  %gep761.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 2048
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep761.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep761.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 2052
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep761.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep761.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 2056
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep761.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep761.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 2060
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep761.2.sroa_idx, align 4, !tbaa !30
  %gep761.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 3072
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep761.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep761.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 3076
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep761.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep761.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 3080
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep761.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep761.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep760, i32 3084
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep761.3.sroa_idx, align 4, !tbaa !30
  %29 = lshr i32 %1, 2
  %mul310 = and i32 %29, 252
  %add304 = add i32 %29, %mul27
  %add325 = add i32 %mul310, %mul27
  %add346 = add i32 %mul310, %mul27
  %cmp360 = icmp slt i32 %add304, 0
  %cmp362 = icmp sgt i32 %add325, 399
  %or.cond705.not782 = or i1 %cmp360, %cmp362
  %cmp365.not = icmp sgt i32 %add346, %0
  %or.cond745 = or i1 %or.cond705.not782, %cmp365.not
  br i1 %or.cond745, label %if.then298.1, label %if.then366

if.then366:                                       ; preds = %if.end164.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %27, i64 0
  %mul369 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul369, float 0x4024CB5EC0000000)
  %31 = tail call contract noundef float @llvm.exp.f32(float %30)
  br label %if.then298.1

if.then298.1:                                     ; preds = %if.then366, %if.end164.3
  %condval_5.0 = phi float [ %31, %if.then366 ], [ 0.000000e+00, %if.end164.3 ]
  %add304.1 = add i32 %29, %mul27
  %add324.1 = or disjoint i32 %mul310, 1
  %add325.1 = add i32 %add324.1, %mul27
  %add345.1 = or disjoint i32 %mul310, 1
  %add346.1 = add i32 %add345.1, %mul27
  %cmp360.1 = icmp slt i32 %add304.1, 0
  %cmp362.1 = icmp sgt i32 %add325.1, 399
  %or.cond705.not782.1 = select i1 %cmp360.1, i1 true, i1 %cmp362.1
  %cmp365.not.1 = icmp sgt i32 %add346.1, %0
  %or.cond745.1 = select i1 %or.cond705.not782.1, i1 true, i1 %cmp365.not.1
  br i1 %or.cond745.1, label %if.then298.2, label %if.then366.1

if.then366.1:                                     ; preds = %if.then298.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %27, i64 1
  %mul369.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul369.1, float 0x4024CB5EC0000000)
  %33 = tail call contract noundef float @llvm.exp.f32(float %32)
  br label %if.then298.2

if.then298.2:                                     ; preds = %if.then298.1, %if.then366.1
  %condval_5.0.1 = phi float [ %33, %if.then366.1 ], [ 0.000000e+00, %if.then298.1 ]
  %add304.2 = add i32 %29, %mul27
  %add324.2 = or disjoint i32 %mul310, 2
  %add325.2 = add i32 %add324.2, %mul27
  %add345.2 = or disjoint i32 %mul310, 2
  %add346.2 = add i32 %add345.2, %mul27
  %cmp360.2 = icmp slt i32 %add304.2, 0
  %cmp362.2 = icmp sgt i32 %add325.2, 399
  %or.cond705.not782.2 = select i1 %cmp360.2, i1 true, i1 %cmp362.2
  %cmp365.not.2 = icmp sgt i32 %add346.2, %0
  %or.cond745.2 = select i1 %or.cond705.not782.2, i1 true, i1 %cmp365.not.2
  br i1 %or.cond745.2, label %if.then298.3, label %if.then366.2

if.then366.2:                                     ; preds = %if.then298.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %27, i64 2
  %mul369.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul369.2, float 0x4024CB5EC0000000)
  %35 = tail call contract noundef float @llvm.exp.f32(float %34)
  br label %if.then298.3

if.then298.3:                                     ; preds = %if.then298.2, %if.then366.2
  %condval_5.0.2 = phi float [ %35, %if.then366.2 ], [ 0.000000e+00, %if.then298.2 ]
  %add304.3 = add i32 %29, %mul27
  %add324.3 = or i32 %29, 3
  %add325.3 = add i32 %add324.3, %mul27
  %add345.3 = or i32 %29, 3
  %add346.3 = add i32 %add345.3, %mul27
  %cmp360.3 = icmp slt i32 %add304.3, 0
  %cmp362.3 = icmp sgt i32 %add325.3, 399
  %or.cond705.not782.3 = or i1 %cmp360.3, %cmp362.3
  %cmp365.not.3 = icmp sgt i32 %add346.3, %0
  %or.cond745.3 = or i1 %or.cond705.not782.3, %cmp365.not.3
  br i1 %or.cond745.3, label %if.else305.4, label %if.then366.3

if.then366.3:                                     ; preds = %if.then298.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %27, i64 3
  %mul369.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul369.3, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  br label %if.else305.4

if.else305.4:                                     ; preds = %if.then298.3, %if.then366.3
  %condval_5.0.3 = phi float [ %37, %if.then366.3 ], [ 0.000000e+00, %if.then298.3 ]
  %sub316.4 = add i32 %29, %mul27.1
  %sub337.4 = add i32 %mul310, %mul27.1
  %sub358.4 = add i32 %mul310, %mul27.1
  %cmp360.4 = icmp slt i32 %sub316.4, 0
  %cmp362.4 = icmp sgt i32 %sub337.4, 399
  %or.cond705.not782.4 = or i1 %cmp360.4, %cmp362.4
  %cmp365.not.4 = icmp sgt i32 %sub358.4, %0
  %or.cond745.4 = select i1 %or.cond705.not782.4, i1 true, i1 %cmp365.not.4
  br i1 %or.cond745.4, label %if.else305.5, label %if.then366.4

if.then366.4:                                     ; preds = %if.else305.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %28, i64 0
  %mul369.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul369.4, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  br label %if.else305.5

if.else305.5:                                     ; preds = %if.else305.4, %if.then366.4
  %condval_5.0.4 = phi float [ %39, %if.then366.4 ], [ 0.000000e+00, %if.else305.4 ]
  %sub316.5 = add i32 %29, %mul27.1
  %add336.5 = or disjoint i32 %mul310, 1
  %sub337.5 = add i32 %add336.5, %mul27.1
  %add357.5 = or disjoint i32 %mul310, 1
  %sub358.5 = add i32 %add357.5, %mul27.1
  %cmp360.5 = icmp slt i32 %sub316.5, 0
  %cmp362.5 = icmp sgt i32 %sub337.5, 399
  %or.cond705.not782.5 = select i1 %cmp360.5, i1 true, i1 %cmp362.5
  %cmp365.not.5 = icmp sgt i32 %sub358.5, %0
  %or.cond745.5 = select i1 %or.cond705.not782.5, i1 true, i1 %cmp365.not.5
  br i1 %or.cond745.5, label %if.else305.6, label %if.then366.5

if.then366.5:                                     ; preds = %if.else305.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %28, i64 1
  %mul369.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul369.5, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.else305.6

if.else305.6:                                     ; preds = %if.else305.5, %if.then366.5
  %condval_5.0.5 = phi float [ %41, %if.then366.5 ], [ 0.000000e+00, %if.else305.5 ]
  %sub316.6 = add i32 %29, %mul27.1
  %add336.6 = or disjoint i32 %mul310, 2
  %sub337.6 = add i32 %add336.6, %mul27.1
  %add357.6 = or disjoint i32 %mul310, 2
  %sub358.6 = add i32 %add357.6, %mul27.1
  %cmp360.6 = icmp slt i32 %sub316.6, 0
  %cmp362.6 = icmp sgt i32 %sub337.6, 399
  %or.cond705.not782.6 = select i1 %cmp360.6, i1 true, i1 %cmp362.6
  %cmp365.not.6 = icmp sgt i32 %sub358.6, %0
  %or.cond745.6 = select i1 %or.cond705.not782.6, i1 true, i1 %cmp365.not.6
  br i1 %or.cond745.6, label %if.else305.7, label %if.then366.6

if.then366.6:                                     ; preds = %if.else305.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %28, i64 2
  %mul369.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul369.6, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.else305.7

if.else305.7:                                     ; preds = %if.else305.6, %if.then366.6
  %condval_5.0.6 = phi float [ %43, %if.then366.6 ], [ 0.000000e+00, %if.else305.6 ]
  %sub316.7 = add i32 %29, %mul27.1
  %add336.7 = or i32 %29, 3
  %sub337.7 = add i32 %add336.7, %mul27.1
  %add357.7 = or i32 %29, 3
  %sub358.7 = add i32 %add357.7, %mul27.1
  %cmp360.7 = icmp slt i32 %sub316.7, 0
  %cmp362.7 = icmp sgt i32 %sub337.7, 399
  %or.cond705.not782.7 = or i1 %cmp360.7, %cmp362.7
  %cmp365.not.7 = icmp sgt i32 %sub358.7, %0
  %or.cond745.7 = select i1 %or.cond705.not782.7, i1 true, i1 %cmp365.not.7
  br i1 %or.cond745.7, label %if.end373.7, label %if.then366.7

if.then366.7:                                     ; preds = %if.else305.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %28, i64 3
  %mul369.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul369.7, float 0x4024CB5EC0000000)
  %45 = tail call contract noundef float @llvm.exp.f32(float %44)
  br label %if.end373.7

if.end373.7:                                      ; preds = %if.then366.7, %if.else305.7
  %condval_5.0.7 = phi float [ %45, %if.then366.7 ], [ 0.000000e+00, %if.else305.7 ]
  %add393.1 = fadd contract float %condval_5.0, %condval_5.0.1
  %add393.2 = fadd contract float %add393.1, %condval_5.0.2
  %add393.3 = fadd contract float %add393.2, %condval_5.0.3
  %add393.1796 = fadd contract float %add393.3, %condval_5.0.4
  %add393.1.1 = fadd contract float %add393.1796, %condval_5.0.5
  %add393.2.1 = fadd contract float %add393.1.1, %condval_5.0.6
  %add393.3.1 = fadd contract float %add393.2.1, %condval_5.0.7
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add393.3.1, <4 x float> zeroinitializer)
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0
  %cmp414 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  br i1 %cmp414, label %if.then415, label %if.end431

if.then415:                                       ; preds = %if.end373.7
  %47 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32
  %sub417 = sub i32 2129859011, %47
  %48 = bitcast i32 %sub417 to float
  %mul419 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %48
  %sub420 = fsub contract float 2.000000e+00, %mul419
  %mul421 = fmul contract float %sub420, %48
  %mul427 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul421
  %sub428 = fsub contract float 2.000000e+00, %mul427
  %mul429 = fmul contract float %mul421, %sub428
  br label %if.end431

if.end431:                                        ; preds = %if.end373.7, %if.then415
  %condval_9.0 = phi float [ %mul429, %if.then415 ], [ 0.000000e+00, %if.end373.7 ]
  %mul440 = fmul contract float %condval_9.0, %condval_5.0
  %mul440.1 = fmul contract float %condval_9.0, %condval_5.0.1
  %mul440.2 = fmul contract float %condval_9.0, %condval_5.0.2
  %mul440.3 = fmul contract float %condval_9.0, %condval_5.0.3
  %mul440.4 = fmul contract float %condval_9.0, %condval_5.0.4
  %mul440.5 = fmul contract float %condval_9.0, %condval_5.0.5
  %mul440.6 = fmul contract float %condval_9.0, %condval_5.0.6
  %mul440.7 = fmul contract float %condval_9.0, %condval_5.0.7
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440)
  %50 = insertelement <4 x i16> poison, i16 %49, i64 0
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.1)
  %52 = insertelement <4 x i16> %50, i16 %51, i64 1
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.2)
  %54 = insertelement <4 x i16> %52, i16 %53, i64 2
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.3)
  %56 = insertelement <4 x i16> %54, i16 %55, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %56 to <4 x half>
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.4)
  %58 = insertelement <4 x i16> poison, i16 %57, i64 0
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.5)
  %60 = insertelement <4 x i16> %58, i16 %59, i64 1
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.6)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 2
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.7)
  %64 = insertelement <4 x i16> %62, i16 %63, i64 3
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %64 to <4 x half>
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %mul484 = and i32 %add.ptr289.idx, 16128
  %and491 = and i32 %1, 15
  %add492 = or disjoint i32 %mul484, %and491
  %arrayidx494 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492
  %65 = load half, ptr addrspace(3) %arrayidx494, align 2, !tbaa !146
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %65, i64 0
  %add487.1 = or disjoint i32 %mul484, %and491
  %add492.1 = or disjoint i32 %add487.1, 64
  %arrayidx494.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1
  %66 = load half, ptr addrspace(3) %arrayidx494.1, align 2, !tbaa !146
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %66, i64 1
  %add487.2 = or disjoint i32 %mul484, %and491
  %add492.2 = or disjoint i32 %add487.2, 128
  %arrayidx494.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2
  %67 = load half, ptr addrspace(3) %arrayidx494.2, align 2, !tbaa !146
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %67, i64 2
  %add487.3 = or disjoint i32 %mul484, %and491
  %add492.3 = or disjoint i32 %add487.3, 192
  %arrayidx494.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3
  %68 = load half, ptr addrspace(3) %arrayidx494.3, align 2, !tbaa !146
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %68, i64 3
  %add489.1799 = or disjoint i32 %mul484, %and491
  %add492.1800 = or disjoint i32 %add489.1799, 16
  %arrayidx494.1801 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1800
  %69 = load half, ptr addrspace(3) %arrayidx494.1801, align 2, !tbaa !146
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %69, i64 0
  %add489.1.1 = or disjoint i32 %mul484, %and491
  %add492.1.1 = or disjoint i32 %add489.1.1, 80
  %arrayidx494.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1.1
  %70 = load half, ptr addrspace(3) %arrayidx494.1.1, align 2, !tbaa !146
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %70, i64 1
  %add489.2.1 = or disjoint i32 %mul484, %and491
  %add492.2.1 = or disjoint i32 %add489.2.1, 144
  %arrayidx494.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2.1
  %71 = load half, ptr addrspace(3) %arrayidx494.2.1, align 2, !tbaa !146
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %71, i64 2
  %add489.3.1 = or disjoint i32 %mul484, %and491
  %add492.3.1 = or disjoint i32 %add489.3.1, 208
  %arrayidx494.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3.1
  %72 = load half, ptr addrspace(3) %arrayidx494.3.1, align 2, !tbaa !146
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %72, i64 3
  %add489.2803 = or disjoint i32 %mul484, %and491
  %add492.2804 = or disjoint i32 %add489.2803, 32
  %arrayidx494.2805 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2804
  %73 = load half, ptr addrspace(3) %arrayidx494.2805, align 2, !tbaa !146
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %73, i64 0
  %add489.1.2 = or disjoint i32 %mul484, %and491
  %add492.1.2 = or disjoint i32 %add489.1.2, 96
  %arrayidx494.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1.2
  %74 = load half, ptr addrspace(3) %arrayidx494.1.2, align 2, !tbaa !146
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %74, i64 1
  %add489.2.2 = or disjoint i32 %mul484, %and491
  %add492.2.2 = or disjoint i32 %add489.2.2, 160
  %arrayidx494.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2.2
  %75 = load half, ptr addrspace(3) %arrayidx494.2.2, align 2, !tbaa !146
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %75, i64 2
  %add489.3.2 = or disjoint i32 %mul484, %and491
  %add492.3.2 = or disjoint i32 %add489.3.2, 224
  %arrayidx494.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3.2
  %76 = load half, ptr addrspace(3) %arrayidx494.3.2, align 2, !tbaa !146
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %76, i64 3
  %add489.3807 = or disjoint i32 %mul484, %and491
  %add492.3808 = or disjoint i32 %add489.3807, 48
  %arrayidx494.3809 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3808
  %77 = load half, ptr addrspace(3) %arrayidx494.3809, align 2, !tbaa !146
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %77, i64 0
  %add489.1.3 = or disjoint i32 %mul484, %and491
  %add492.1.3 = or disjoint i32 %add489.1.3, 112
  %arrayidx494.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1.3
  %78 = load half, ptr addrspace(3) %arrayidx494.1.3, align 2, !tbaa !146
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %78, i64 1
  %add489.2.3 = or disjoint i32 %mul484, %and491
  %add492.2.3 = or disjoint i32 %add489.2.3, 176
  %arrayidx494.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2.3
  %79 = load half, ptr addrspace(3) %arrayidx494.2.3, align 2, !tbaa !146
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %79, i64 2
  %add489.3.3 = or disjoint i32 %add.ptr289.idx, %and491
  %add492.3.3 = or i32 %add489.3.3, 240
  %arrayidx494.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3.3
  %80 = load half, ptr addrspace(3) %arrayidx494.3.3, align 2, !tbaa !146
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %80, i64 3
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add485.1 = add nuw nsw i32 %mul484, 1024
  %add492.1811 = or disjoint i32 %add485.1, %and491
  %arrayidx494.1812 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1811
  %85 = load half, ptr addrspace(3) %arrayidx494.1812, align 2, !tbaa !146
  %vb.sroa.0.0.vec.insert839 = insertelement <4 x half> poison, half %85, i64 0
  %add487.1.1813 = add nuw nsw i32 %mul484, 1088
  %add492.1.1814 = or disjoint i32 %add487.1.1813, %and491
  %arrayidx494.1.1815 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1.1814
  %86 = load half, ptr addrspace(3) %arrayidx494.1.1815, align 2, !tbaa !146
  %vb.sroa.0.2.vec.insert841 = insertelement <4 x half> %vb.sroa.0.0.vec.insert839, half %86, i64 1
  %add487.2.1817 = add nuw nsw i32 %mul484, 1152
  %add492.2.1818 = or disjoint i32 %add487.2.1817, %and491
  %arrayidx494.2.1819 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2.1818
  %87 = load half, ptr addrspace(3) %arrayidx494.2.1819, align 2, !tbaa !146
  %vb.sroa.0.4.vec.insert843 = insertelement <4 x half> %vb.sroa.0.2.vec.insert841, half %87, i64 2
  %add487.3.1821 = add nuw nsw i32 %mul484, 1216
  %add492.3.1822 = or disjoint i32 %add487.3.1821, %and491
  %arrayidx494.3.1823 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3.1822
  %88 = load half, ptr addrspace(3) %arrayidx494.3.1823, align 2, !tbaa !146
  %vb.sroa.0.6.vec.insert845 = insertelement <4 x half> %vb.sroa.0.4.vec.insert843, half %88, i64 3
  %add489.1799.1 = add nuw nsw i32 %mul484, 1040
  %add492.1800.1 = or disjoint i32 %add489.1799.1, %and491
  %arrayidx494.1801.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1800.1
  %89 = load half, ptr addrspace(3) %arrayidx494.1801.1, align 2, !tbaa !146
  %vb.sroa.12.8.vec.insert849 = insertelement <4 x half> poison, half %89, i64 0
  %add489.1.1.1 = add nuw nsw i32 %mul484, 1104
  %add492.1.1.1 = or disjoint i32 %add489.1.1.1, %and491
  %arrayidx494.1.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1.1.1
  %90 = load half, ptr addrspace(3) %arrayidx494.1.1.1, align 2, !tbaa !146
  %vb.sroa.12.10.vec.insert851 = insertelement <4 x half> %vb.sroa.12.8.vec.insert849, half %90, i64 1
  %add489.2.1.1 = add nuw nsw i32 %mul484, 1168
  %add492.2.1.1 = or disjoint i32 %add489.2.1.1, %and491
  %arrayidx494.2.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2.1.1
  %91 = load half, ptr addrspace(3) %arrayidx494.2.1.1, align 2, !tbaa !146
  %vb.sroa.12.12.vec.insert853 = insertelement <4 x half> %vb.sroa.12.10.vec.insert851, half %91, i64 2
  %add489.3.1.1 = add nuw nsw i32 %mul484, 1232
  %add492.3.1.1 = or disjoint i32 %add489.3.1.1, %and491
  %arrayidx494.3.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3.1.1
  %92 = load half, ptr addrspace(3) %arrayidx494.3.1.1, align 2, !tbaa !146
  %vb.sroa.12.14.vec.insert855 = insertelement <4 x half> %vb.sroa.12.12.vec.insert853, half %92, i64 3
  %add489.2803.1 = add nuw nsw i32 %mul484, 1056
  %add492.2804.1 = or disjoint i32 %add489.2803.1, %and491
  %arrayidx494.2805.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2804.1
  %93 = load half, ptr addrspace(3) %arrayidx494.2805.1, align 2, !tbaa !146
  %vb.sroa.22.16.vec.insert859 = insertelement <4 x half> poison, half %93, i64 0
  %add489.1.2.1 = add nuw nsw i32 %mul484, 1120
  %add492.1.2.1 = or disjoint i32 %add489.1.2.1, %and491
  %arrayidx494.1.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1.2.1
  %94 = load half, ptr addrspace(3) %arrayidx494.1.2.1, align 2, !tbaa !146
  %vb.sroa.22.18.vec.insert861 = insertelement <4 x half> %vb.sroa.22.16.vec.insert859, half %94, i64 1
  %add489.2.2.1 = add nuw nsw i32 %mul484, 1184
  %add492.2.2.1 = or disjoint i32 %add489.2.2.1, %and491
  %arrayidx494.2.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2.2.1
  %95 = load half, ptr addrspace(3) %arrayidx494.2.2.1, align 2, !tbaa !146
  %vb.sroa.22.20.vec.insert863 = insertelement <4 x half> %vb.sroa.22.18.vec.insert861, half %95, i64 2
  %add489.3.2.1 = add nuw nsw i32 %mul484, 1248
  %add492.3.2.1 = or disjoint i32 %add489.3.2.1, %and491
  %arrayidx494.3.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3.2.1
  %96 = load half, ptr addrspace(3) %arrayidx494.3.2.1, align 2, !tbaa !146
  %vb.sroa.22.22.vec.insert865 = insertelement <4 x half> %vb.sroa.22.20.vec.insert863, half %96, i64 3
  %add489.3807.1 = add nuw nsw i32 %mul484, 1072
  %add492.3808.1 = or disjoint i32 %add489.3807.1, %and491
  %arrayidx494.3809.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3808.1
  %97 = load half, ptr addrspace(3) %arrayidx494.3809.1, align 2, !tbaa !146
  %vb.sroa.32.24.vec.insert869 = insertelement <4 x half> poison, half %97, i64 0
  %add489.1.3.1 = add nuw nsw i32 %mul484, 1136
  %add492.1.3.1 = or disjoint i32 %add489.1.3.1, %and491
  %arrayidx494.1.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.1.3.1
  %98 = load half, ptr addrspace(3) %arrayidx494.1.3.1, align 2, !tbaa !146
  %vb.sroa.32.26.vec.insert871 = insertelement <4 x half> %vb.sroa.32.24.vec.insert869, half %98, i64 1
  %add489.2.3.1 = add nuw nsw i32 %mul484, 1200
  %add492.2.3.1 = or disjoint i32 %add489.2.3.1, %and491
  %arrayidx494.2.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.2.3.1
  %99 = load half, ptr addrspace(3) %arrayidx494.2.3.1, align 2, !tbaa !146
  %vb.sroa.32.28.vec.insert873 = insertelement <4 x half> %vb.sroa.32.26.vec.insert871, half %99, i64 2
  %add489.3.3.1 = add nuw nsw i32 %mul484, 1264
  %add492.3.3.1 = or disjoint i32 %add489.3.3.1, %and491
  %arrayidx494.3.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add492.3.3.1
  %100 = load half, ptr addrspace(3) %arrayidx494.3.3.1, align 2, !tbaa !146
  %vb.sroa.32.30.vec.insert875 = insertelement <4 x half> %vb.sroa.32.28.vec.insert873, half %100, i64 3
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert845, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %81)
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert855, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %82)
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert865, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %83)
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert875, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %84)
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %101, i64 0
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_cast.sroa.0.0.insert.ext = zext i16 %105 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %101, i64 1
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_cast.sroa.0.2.insert.ext = zext i16 %106 to i64
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %101, i64 2
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_cast.sroa.0.4.insert.ext = zext i16 %107 to i64
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %101, i64 3
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_cast.sroa.0.6.insert.ext = zext i16 %108 to i64
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %102, i64 0
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract)
  %O_cast.sroa.7.8.insert.ext = zext i16 %109 to i64
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %102, i64 1
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract)
  %O_cast.sroa.7.10.insert.ext = zext i16 %110 to i64
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %102, i64 2
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract)
  %O_cast.sroa.7.12.insert.ext = zext i16 %111 to i64
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %102, i64 3
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract)
  %O_cast.sroa.7.14.insert.ext = zext i16 %112 to i64
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %103, i64 0
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract)
  %O_cast.sroa.12.16.insert.ext = zext i16 %113 to i64
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %103, i64 1
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract)
  %O_cast.sroa.12.18.insert.ext = zext i16 %114 to i64
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %103, i64 2
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract)
  %O_cast.sroa.12.20.insert.ext = zext i16 %115 to i64
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %103, i64 3
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract)
  %O_cast.sroa.12.22.insert.ext = zext i16 %116 to i64
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %104, i64 0
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract)
  %O_cast.sroa.17.24.insert.ext = zext i16 %117 to i64
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %104, i64 1
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract)
  %O_cast.sroa.17.26.insert.ext = zext i16 %118 to i64
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %104, i64 2
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract)
  %O_cast.sroa.17.28.insert.ext = zext i16 %119 to i64
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %104, i64 3
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract)
  %O_cast.sroa.17.30.insert.ext = zext i16 %120 to i64
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift
  %add565 = add nuw nsw i32 %add, %mul310
  %121 = zext nneg i32 %add565 to i64
  %add.ptr571 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr571, align 8
  %122 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  %add.ptr571.1 = getelementptr inbounds i8, ptr addrspace(1) %122, i64 32
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr571.1, align 8
  %123 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  %add.ptr571.2 = getelementptr inbounds i8, ptr addrspace(1) %123, i64 64
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr571.2, align 8
  %124 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  %add.ptr571.3 = getelementptr inbounds i8, ptr addrspace(1) %124, i64 96
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr571.3, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare void @llvm.mxc.barrier() #7

declare float @llvm.exp.f32(float) #8

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

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


