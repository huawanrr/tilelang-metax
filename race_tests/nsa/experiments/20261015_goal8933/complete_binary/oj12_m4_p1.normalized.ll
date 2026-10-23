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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !call_argsrelate !48
  %cond.i.i2262 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2262, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2262.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2262.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2262.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2262.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2262.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2262.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2262.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2262.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2262.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2262.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2262.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2262.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2262.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2262.7, 4
  %mul20 = shl nsw i32 %0, 20
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %18 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !54
  %and = shl nuw nsw i32 %18, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %19 = lshr i32 %18, 1
  %mul30 = and i32 %19, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %20 = zext nneg i32 %add28 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.19.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.19.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.19.0.add.ptr.sroa_idx, align 8
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64
  %Q_reg.sroa.35.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.52.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72
  %Q_reg.sroa.52.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.52.16.add.ptr.1.sroa_idx, align 8
  %add94 = add nuw nsw i32 %1, 1
  %shr95 = and i32 %add94, 2147483632
  %invariant.op = add nsw i32 %1, -15
  %mul881 = shl nsw i32 %0, 16
  %mul888 = shl nuw nsw i32 %18, 3
  %add884 = or disjoint i32 %mul888, %mul881
  %22 = lshr i32 %18, 2
  %mul1033 = and i32 %22, 252
  %conv = zext nneg i32 %0 to i64
  %mul115 = zext nneg i32 %mul888 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul115
  %invariant.gep2390 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul115
  %cond.i.i.i = tail call noundef i32 @llvm.umax.i32(i32 %mul11, i32 %mul11.1)
  %cond.i.i.i2263 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.2, i32 %mul11.3)
  %cond.i.i.i2264 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i, i32 %cond.i.i.i2263)
  %cmp97 = icmp ult i32 %cond.i.i.i2264, %shr95
  br i1 %cmp97, label %for.cond98.preheader, label %if.else869

for.cond98.preheader:                             ; preds = %entry
  %cmp102 = icmp sgt i32 %3, -1
  %23 = and i32 %cond.i.i2262, 268435455
  %shr107 = zext nneg i32 %23 to i64
  br i1 %cmp102, label %if.then103, label %if.end

if.then103:                                       ; preds = %for.cond98.preheader
  %.idx = shl nuw nsw i64 %shr107, 11
  %24 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx
  %.idx2472 = shl nuw nsw i64 %conv, 17
  %25 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 %.idx2472
  %26 = load <4 x half>, ptr addrspace(4) %25, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr117.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %25, i64 8
  %27 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr117.sroa_idx, align 8, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %for.cond98.preheader, %if.then103
  %28 = phi <4 x half> [ %27, %if.then103 ], [ zeroinitializer, %for.cond98.preheader ]
  %29 = phi <4 x half> [ %26, %if.then103 ], [ zeroinitializer, %for.cond98.preheader ]
  br i1 %cmp102, label %if.then103.1, label %if.end.1

if.then103.1:                                     ; preds = %if.end
  %.idx.1 = shl nuw nsw i64 %shr107, 11
  %30 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1
  %.idx2472.1 = shl nuw nsw i64 %conv, 17
  %31 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 %.idx2472.1
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1024
  %32 = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr117.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1032
  %33 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr117.sroa_idx.1, align 8, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.then103.1, %if.end
  %34 = phi <4 x half> [ %33, %if.then103.1 ], [ zeroinitializer, %if.end ]
  %35 = phi <4 x half> [ %32, %if.then103.1 ], [ zeroinitializer, %if.end ]
  %cmp149 = icmp sgt i32 %5, -1
  %36 = and i32 %cond.i.i2262.1, 268435455
  %shr155 = zext nneg i32 %36 to i64
  br i1 %cmp149, label %if.then150, label %if.end189

if.then150:                                       ; preds = %if.end.1
  %.idx2473 = shl nuw nsw i64 %shr155, 11
  %37 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2473
  %.idx2474 = shl nuw nsw i64 %conv, 17
  %38 = getelementptr inbounds i8, ptr addrspace(4) %37, i64 %.idx2474
  %39 = load <4 x half>, ptr addrspace(4) %38, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %38, i64 8
  %40 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr165.sroa_idx, align 8, !tbaa !30
  br label %if.end189

if.end189:                                        ; preds = %if.end.1, %if.then150
  %41 = phi <4 x half> [ %40, %if.then150 ], [ zeroinitializer, %if.end.1 ]
  %42 = phi <4 x half> [ %39, %if.then150 ], [ zeroinitializer, %if.end.1 ]
  br i1 %cmp149, label %if.then150.1, label %if.end189.1

if.then150.1:                                     ; preds = %if.end189
  %.idx2473.1 = shl nuw nsw i64 %shr155, 11
  %43 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2473.1
  %.idx2474.1 = shl nuw nsw i64 %conv, 17
  %44 = getelementptr inbounds i8, ptr addrspace(4) %43, i64 %.idx2474.1
  %gep2382.1 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 1024
  %45 = load <4 x half>, ptr addrspace(4) %gep2382.1, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr165.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 1032
  %46 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr165.sroa_idx.1, align 8, !tbaa !30
  br label %if.end189.1

if.end189.1:                                      ; preds = %if.then150.1, %if.end189
  %47 = phi <4 x half> [ %46, %if.then150.1 ], [ zeroinitializer, %if.end189 ]
  %48 = phi <4 x half> [ %45, %if.then150.1 ], [ zeroinitializer, %if.end189 ]
  %cmp201 = icmp sgt i32 %7, -1
  %49 = and i32 %cond.i.i2262.2, 268435455
  %shr207 = zext nneg i32 %49 to i64
  br i1 %cmp201, label %if.then202, label %if.end241

if.then202:                                       ; preds = %if.end189.1
  %.idx2475 = shl nuw nsw i64 %shr207, 11
  %50 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2475
  %.idx2476 = shl nuw nsw i64 %conv, 17
  %51 = getelementptr inbounds i8, ptr addrspace(4) %50, i64 %.idx2476
  %52 = load <4 x half>, ptr addrspace(4) %51, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr217.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %51, i64 8
  %53 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr217.sroa_idx, align 8, !tbaa !30
  br label %if.end241

if.end241:                                        ; preds = %if.end189.1, %if.then202
  %54 = phi <4 x half> [ %53, %if.then202 ], [ zeroinitializer, %if.end189.1 ]
  %55 = phi <4 x half> [ %52, %if.then202 ], [ zeroinitializer, %if.end189.1 ]
  br i1 %cmp201, label %if.then202.1, label %if.end241.1

if.then202.1:                                     ; preds = %if.end241
  %.idx2475.1 = shl nuw nsw i64 %shr207, 11
  %56 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2475.1
  %.idx2476.1 = shl nuw nsw i64 %conv, 17
  %57 = getelementptr inbounds i8, ptr addrspace(4) %56, i64 %.idx2476.1
  %gep2385.1 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 1024
  %58 = load <4 x half>, ptr addrspace(4) %gep2385.1, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr217.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 1032
  %59 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr217.sroa_idx.1, align 8, !tbaa !30
  br label %if.end241.1

if.end241.1:                                      ; preds = %if.then202.1, %if.end241
  %60 = phi <4 x half> [ %59, %if.then202.1 ], [ zeroinitializer, %if.end241 ]
  %61 = phi <4 x half> [ %58, %if.then202.1 ], [ zeroinitializer, %if.end241 ]
  %cmp253 = icmp sgt i32 %9, -1
  %62 = and i32 %cond.i.i2262.3, 268435455
  %shr259 = zext nneg i32 %62 to i64
  br i1 %cmp253, label %if.then254, label %if.end293

if.then254:                                       ; preds = %if.end241.1
  %.idx2477 = shl nuw nsw i64 %shr259, 11
  %63 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2477
  %.idx2478 = shl nuw nsw i64 %conv, 17
  %64 = getelementptr inbounds i8, ptr addrspace(4) %63, i64 %.idx2478
  %65 = load <4 x half>, ptr addrspace(4) %64, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr269.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 8
  %66 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr269.sroa_idx, align 8, !tbaa !30
  br label %if.end293

if.end293:                                        ; preds = %if.end241.1, %if.then254
  %67 = phi <4 x half> [ %66, %if.then254 ], [ zeroinitializer, %if.end241.1 ]
  %68 = phi <4 x half> [ %65, %if.then254 ], [ zeroinitializer, %if.end241.1 ]
  br i1 %cmp253, label %if.then254.1, label %if.end293.1

if.then254.1:                                     ; preds = %if.end293
  %.idx2477.1 = shl nuw nsw i64 %shr259, 11
  %69 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2477.1
  %.idx2478.1 = shl nuw nsw i64 %conv, 17
  %70 = getelementptr inbounds i8, ptr addrspace(4) %69, i64 %.idx2478.1
  %gep2388.1 = getelementptr inbounds i8, ptr addrspace(4) %70, i64 1024
  %71 = load <4 x half>, ptr addrspace(4) %gep2388.1, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr269.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %70, i64 1032
  %72 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr269.sroa_idx.1, align 8, !tbaa !30
  br label %if.end293.1

if.end293.1:                                      ; preds = %if.then254.1, %if.end293
  %73 = phi <4 x half> [ %72, %if.then254.1 ], [ zeroinitializer, %if.end293 ]
  %74 = phi <4 x half> [ %71, %if.then254.1 ], [ zeroinitializer, %if.end293 ]
  br i1 %cmp102, label %if.then306, label %if.end345

if.then306:                                       ; preds = %if.end293.1
  %.idx2479 = shl nuw nsw i64 %shr107, 11
  %75 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2479
  %.idx2480 = shl nuw nsw i64 %conv, 17
  %76 = getelementptr inbounds i8, ptr addrspace(4) %75, i64 %.idx2480
  %77 = load <4 x half>, ptr addrspace(4) %76, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr321.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %76, i64 8
  %78 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr321.sroa_idx, align 8, !tbaa !30
  br label %if.end345

if.end345:                                        ; preds = %if.end293.1, %if.then306
  %79 = phi <4 x half> [ %78, %if.then306 ], [ zeroinitializer, %if.end293.1 ]
  %80 = phi <4 x half> [ %77, %if.then306 ], [ zeroinitializer, %if.end293.1 ]
  br i1 %cmp102, label %if.then306.1, label %if.end345.1

if.then306.1:                                     ; preds = %if.end345
  %.idx2479.1 = shl nuw nsw i64 %shr107, 11
  %81 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2479.1
  %.idx2480.1 = shl nuw nsw i64 %conv, 17
  %82 = getelementptr inbounds i8, ptr addrspace(4) %81, i64 %.idx2480.1
  %gep2391.1 = getelementptr inbounds i8, ptr addrspace(4) %82, i64 1024
  %83 = load <4 x half>, ptr addrspace(4) %gep2391.1, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr321.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %82, i64 1032
  %84 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr321.sroa_idx.1, align 8, !tbaa !30
  br label %if.end345.1

if.end345.1:                                      ; preds = %if.then306.1, %if.end345
  %85 = phi <4 x half> [ %84, %if.then306.1 ], [ zeroinitializer, %if.end345 ]
  %86 = phi <4 x half> [ %83, %if.then306.1 ], [ zeroinitializer, %if.end345 ]
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %87), !call_argsrelate !90
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %88), !call_argsrelate !90
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %89), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract2980 = extractelement <4 x float> %90, i64 0
  %mul391 = fmul contract float %acc_s.sroa.0.0.vec.extract2980, 0x3FB99999A0000000
  %91 = tail call contract noundef float @llvm.minnum.f32(float %mul391, float 0x4024CB5EC0000000)
  %92 = tail call contract noundef float @llvm.exp.f32(float %91)
  %acc_s.sroa.0.4.vec.extract3169 = extractelement <4 x float> %90, i64 1
  %mul391.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3169, 0x3FB99999A0000000
  %93 = tail call contract noundef float @llvm.minnum.f32(float %mul391.1, float 0x4024CB5EC0000000)
  %94 = tail call contract noundef float @llvm.exp.f32(float %93)
  %acc_s.sroa.0.8.vec.extract3342 = extractelement <4 x float> %90, i64 2
  %mul391.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3342, 0x3FB99999A0000000
  %95 = tail call contract noundef float @llvm.minnum.f32(float %mul391.2, float 0x4024CB5EC0000000)
  %96 = tail call contract noundef float @llvm.exp.f32(float %95)
  %acc_s.sroa.0.12.vec.extract3515 = extractelement <4 x float> %90, i64 3
  %mul391.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3515, 0x3FB99999A0000000
  %97 = tail call contract noundef float @llvm.minnum.f32(float %mul391.3, float 0x4024CB5EC0000000)
  %98 = tail call contract noundef float @llvm.exp.f32(float %97)
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %92)
  %100 = insertelement <4 x i16> poison, i16 %99, i64 0
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %94)
  %102 = insertelement <4 x i16> %100, i16 %101, i64 1
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %96)
  %104 = insertelement <4 x i16> %102, i16 %103, i64 2
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %98)
  %106 = insertelement <4 x i16> %104, i16 %105, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2887 = bitcast <4 x i16> %106 to <4 x half>
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2887, <4 x float> zeroinitializer)
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %79, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2887, <4 x float> zeroinitializer)
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %86, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2887, <4 x float> zeroinitializer)
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %85, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2887, <4 x float> zeroinitializer)
  br i1 %cmp149, label %if.then448, label %if.end487

if.then448:                                       ; preds = %if.end345.1
  %.idx2481 = shl nuw nsw i64 %shr155, 11
  %111 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2481
  %.idx2482 = shl nuw nsw i64 %conv, 17
  %112 = getelementptr inbounds i8, ptr addrspace(4) %111, i64 %.idx2482
  %113 = load <4 x half>, ptr addrspace(4) %112, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr463.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %112, i64 8
  %114 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr463.sroa_idx, align 8, !tbaa !30
  br label %if.end487

if.end487:                                        ; preds = %if.end345.1, %if.then448
  %115 = phi <4 x half> [ %114, %if.then448 ], [ zeroinitializer, %if.end345.1 ]
  %116 = phi <4 x half> [ %113, %if.then448 ], [ zeroinitializer, %if.end345.1 ]
  br i1 %cmp149, label %if.then448.1, label %if.end487.1

if.then448.1:                                     ; preds = %if.end487
  %.idx2481.1 = shl nuw nsw i64 %shr155, 11
  %117 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2481.1
  %.idx2482.1 = shl nuw nsw i64 %conv, 17
  %118 = getelementptr inbounds i8, ptr addrspace(4) %117, i64 %.idx2482.1
  %gep2404.1 = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1024
  %119 = load <4 x half>, ptr addrspace(4) %gep2404.1, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr463.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1032
  %120 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr463.sroa_idx.1, align 8, !tbaa !30
  br label %if.end487.1

if.end487.1:                                      ; preds = %if.then448.1, %if.end487
  %121 = phi <4 x half> [ %120, %if.then448.1 ], [ zeroinitializer, %if.end487 ]
  %122 = phi <4 x half> [ %119, %if.then448.1 ], [ zeroinitializer, %if.end487 ]
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %41, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %123), !call_argsrelate !90
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %124), !call_argsrelate !90
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %47, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %125), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract2988 = extractelement <4 x float> %126, i64 0
  %mul533 = fmul contract float %acc_s.sroa.0.0.vec.extract2988, 0x3FB99999A0000000
  %127 = tail call contract noundef float @llvm.minnum.f32(float %mul533, float 0x4024CB5EC0000000)
  %128 = tail call contract noundef float @llvm.exp.f32(float %127)
  %acc_s.sroa.0.4.vec.extract3177 = extractelement <4 x float> %126, i64 1
  %mul533.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3177, 0x3FB99999A0000000
  %129 = tail call contract noundef float @llvm.minnum.f32(float %mul533.1, float 0x4024CB5EC0000000)
  %130 = tail call contract noundef float @llvm.exp.f32(float %129)
  %acc_s.sroa.0.8.vec.extract3350 = extractelement <4 x float> %126, i64 2
  %mul533.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3350, 0x3FB99999A0000000
  %131 = tail call contract noundef float @llvm.minnum.f32(float %mul533.2, float 0x4024CB5EC0000000)
  %132 = tail call contract noundef float @llvm.exp.f32(float %131)
  %acc_s.sroa.0.12.vec.extract3523 = extractelement <4 x float> %126, i64 3
  %mul533.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3523, 0x3FB99999A0000000
  %133 = tail call contract noundef float @llvm.minnum.f32(float %mul533.3, float 0x4024CB5EC0000000)
  %134 = tail call contract noundef float @llvm.exp.f32(float %133)
  %add549 = fadd contract float %92, %128
  %add549.1 = fadd contract float %94, %130
  %add549.2 = fadd contract float %96, %132
  %add549.3 = fadd contract float %98, %134
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %128)
  %136 = insertelement <4 x i16> poison, i16 %135, i64 0
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %130)
  %138 = insertelement <4 x i16> %136, i16 %137, i64 1
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %132)
  %140 = insertelement <4 x i16> %138, i16 %139, i64 2
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %134)
  %142 = insertelement <4 x i16> %140, i16 %141, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2889 = bitcast <4 x i16> %142 to <4 x half>
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %116, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2889, <4 x float> zeroinitializer)
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %115, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2889, <4 x float> zeroinitializer)
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2889, <4 x float> zeroinitializer)
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %121, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2889, <4 x float> zeroinitializer)
  br i1 %cmp201, label %if.then590, label %if.end629

if.then590:                                       ; preds = %if.end487.1
  %.idx2483 = shl nuw nsw i64 %shr207, 11
  %147 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2483
  %.idx2484 = shl nuw nsw i64 %conv, 17
  %148 = getelementptr inbounds i8, ptr addrspace(4) %147, i64 %.idx2484
  %149 = load <4 x half>, ptr addrspace(4) %148, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr605.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %148, i64 8
  %150 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr605.sroa_idx, align 8, !tbaa !30
  br label %if.end629

if.end629:                                        ; preds = %if.end487.1, %if.then590
  %151 = phi <4 x half> [ %150, %if.then590 ], [ zeroinitializer, %if.end487.1 ]
  %152 = phi <4 x half> [ %149, %if.then590 ], [ zeroinitializer, %if.end487.1 ]
  br i1 %cmp201, label %if.then590.1, label %if.end629.1

if.then590.1:                                     ; preds = %if.end629
  %.idx2483.1 = shl nuw nsw i64 %shr207, 11
  %153 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2483.1
  %.idx2484.1 = shl nuw nsw i64 %conv, 17
  %154 = getelementptr inbounds i8, ptr addrspace(4) %153, i64 %.idx2484.1
  %gep2417.1 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024
  %155 = load <4 x half>, ptr addrspace(4) %gep2417.1, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr605.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1032
  %156 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr605.sroa_idx.1, align 8, !tbaa !30
  br label %if.end629.1

if.end629.1:                                      ; preds = %if.then590.1, %if.end629
  %157 = phi <4 x half> [ %156, %if.then590.1 ], [ zeroinitializer, %if.end629 ]
  %158 = phi <4 x half> [ %155, %if.then590.1 ], [ zeroinitializer, %if.end629 ]
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %159), !call_argsrelate !90
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %160), !call_argsrelate !90
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %161), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract2996 = extractelement <4 x float> %162, i64 0
  %mul675 = fmul contract float %acc_s.sroa.0.0.vec.extract2996, 0x3FB99999A0000000
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul675, float 0x4024CB5EC0000000)
  %164 = tail call contract noundef float @llvm.exp.f32(float %163)
  %acc_s.sroa.0.4.vec.extract3185 = extractelement <4 x float> %162, i64 1
  %mul675.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3185, 0x3FB99999A0000000
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul675.1, float 0x4024CB5EC0000000)
  %166 = tail call contract noundef float @llvm.exp.f32(float %165)
  %acc_s.sroa.0.8.vec.extract3358 = extractelement <4 x float> %162, i64 2
  %mul675.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3358, 0x3FB99999A0000000
  %167 = tail call contract noundef float @llvm.minnum.f32(float %mul675.2, float 0x4024CB5EC0000000)
  %168 = tail call contract noundef float @llvm.exp.f32(float %167)
  %acc_s.sroa.0.12.vec.extract3531 = extractelement <4 x float> %162, i64 3
  %mul675.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3531, 0x3FB99999A0000000
  %169 = tail call contract noundef float @llvm.minnum.f32(float %mul675.3, float 0x4024CB5EC0000000)
  %170 = tail call contract noundef float @llvm.exp.f32(float %169)
  %add691 = fadd contract float %add549, %164
  %add691.1 = fadd contract float %add549.1, %166
  %add691.2 = fadd contract float %add549.2, %168
  %add691.3 = fadd contract float %add549.3, %170
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164)
  %172 = insertelement <4 x i16> poison, i16 %171, i64 0
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166)
  %174 = insertelement <4 x i16> %172, i16 %173, i64 1
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %168)
  %176 = insertelement <4 x i16> %174, i16 %175, i64 2
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %170)
  %178 = insertelement <4 x i16> %176, i16 %177, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2891 = bitcast <4 x i16> %178 to <4 x half>
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %152, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2891, <4 x float> %107)
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %151, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2891, <4 x float> %108)
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %158, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2891, <4 x float> %109)
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %157, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2891, <4 x float> %110)
  br i1 %cmp253, label %if.then732, label %if.end771

if.then732:                                       ; preds = %if.end629.1
  %.idx2485 = shl nuw nsw i64 %shr259, 11
  %183 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2485
  %.idx2486 = shl nuw nsw i64 %conv, 17
  %184 = getelementptr inbounds i8, ptr addrspace(4) %183, i64 %.idx2486
  %185 = load <4 x half>, ptr addrspace(4) %184, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr747.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 8
  %186 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr747.sroa_idx, align 8, !tbaa !30
  br label %if.end771

if.end771:                                        ; preds = %if.end629.1, %if.then732
  %187 = phi <4 x half> [ %186, %if.then732 ], [ zeroinitializer, %if.end629.1 ]
  %188 = phi <4 x half> [ %185, %if.then732 ], [ zeroinitializer, %if.end629.1 ]
  br i1 %cmp253, label %if.then732.1, label %if.end771.1

if.then732.1:                                     ; preds = %if.end771
  %.idx2485.1 = shl nuw nsw i64 %shr259, 11
  %189 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2485.1
  %.idx2486.1 = shl nuw nsw i64 %conv, 17
  %190 = getelementptr inbounds i8, ptr addrspace(4) %189, i64 %.idx2486.1
  %gep2430.1 = getelementptr inbounds i8, ptr addrspace(4) %190, i64 1024
  %191 = load <4 x half>, ptr addrspace(4) %gep2430.1, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr747.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %190, i64 1032
  %192 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr747.sroa_idx.1, align 8, !tbaa !30
  br label %if.end771.1

if.end771.1:                                      ; preds = %if.then732.1, %if.end771
  %193 = phi <4 x half> [ %192, %if.then732.1 ], [ zeroinitializer, %if.end771 ]
  %194 = phi <4 x half> [ %191, %if.then732.1 ], [ zeroinitializer, %if.end771 ]
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %195), !call_argsrelate !90
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %196), !call_argsrelate !90
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %197), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3004 = extractelement <4 x float> %198, i64 0
  %mul817 = fmul contract float %acc_s.sroa.0.0.vec.extract3004, 0x3FB99999A0000000
  %199 = tail call contract noundef float @llvm.minnum.f32(float %mul817, float 0x4024CB5EC0000000)
  %200 = tail call contract noundef float @llvm.exp.f32(float %199)
  %acc_s.sroa.0.4.vec.extract3193 = extractelement <4 x float> %198, i64 1
  %mul817.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3193, 0x3FB99999A0000000
  %201 = tail call contract noundef float @llvm.minnum.f32(float %mul817.1, float 0x4024CB5EC0000000)
  %202 = tail call contract noundef float @llvm.exp.f32(float %201)
  %acc_s.sroa.0.8.vec.extract3366 = extractelement <4 x float> %198, i64 2
  %mul817.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3366, 0x3FB99999A0000000
  %203 = tail call contract noundef float @llvm.minnum.f32(float %mul817.2, float 0x4024CB5EC0000000)
  %204 = tail call contract noundef float @llvm.exp.f32(float %203)
  %acc_s.sroa.0.12.vec.extract3539 = extractelement <4 x float> %198, i64 3
  %mul817.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3539, 0x3FB99999A0000000
  %205 = tail call contract noundef float @llvm.minnum.f32(float %mul817.3, float 0x4024CB5EC0000000)
  %206 = tail call contract noundef float @llvm.exp.f32(float %205)
  %add833 = fadd contract float %add691, %200
  %add833.1 = fadd contract float %add691.1, %202
  %add833.2 = fadd contract float %add691.2, %204
  %add833.3 = fadd contract float %add691.3, %206
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %200)
  %208 = insertelement <4 x i16> poison, i16 %207, i64 0
  %209 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %202)
  %210 = insertelement <4 x i16> %208, i16 %209, i64 1
  %211 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %204)
  %212 = insertelement <4 x i16> %210, i16 %211, i64 2
  %213 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %206)
  %214 = insertelement <4 x i16> %212, i16 %213, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2893 = bitcast <4 x i16> %214 to <4 x half>
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %188, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2893, <4 x float> %143)
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %187, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2893, <4 x float> %144)
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %194, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2893, <4 x float> %145)
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %193, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2893, <4 x float> %146)
  br label %if.end1577

if.else869:                                       ; preds = %entry
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp874.not = icmp sgt i32 %mul11, %1
  %or.cond2457 = or i1 %or.cond, %cmp874.not
  br i1 %or.cond2457, label %if.end899, label %for.cond876.preheader

for.cond876.preheader:                            ; preds = %if.else869
  %219 = shl nsw i32 %cond.i.i2262, 10
  %mul883 = and i32 %219, 64512
  %add886 = add nuw nsw i32 %add884, %mul883
  %220 = zext nneg i32 %add886 to i64
  %add.ptr891 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %220
  %K_reg.sroa.0.0.copyload4347 = load <4 x half>, ptr addrspace(4) %add.ptr891, align 16
  %K_reg.sroa.12.0.add.ptr891.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr891, i64 8
  %K_reg.sroa.12.0.copyload4349 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr891.sroa_idx, align 8
  %221 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %220
  %add.ptr891.1 = getelementptr inbounds i8, ptr addrspace(4) %221, i64 1024
  %K_reg.sroa.20.16.copyload4351 = load <4 x half>, ptr addrspace(4) %add.ptr891.1, align 16
  %K_reg.sroa.30.16.add.ptr891.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %221, i64 1032
  %K_reg.sroa.30.16.copyload4353 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr891.1.sroa_idx, align 8
  br label %if.end899

if.end899:                                        ; preds = %for.cond876.preheader, %if.else869
  %222 = phi <4 x half> [ undef, %if.else869 ], [ %K_reg.sroa.30.16.copyload4353, %for.cond876.preheader ]
  %223 = phi <4 x half> [ undef, %if.else869 ], [ %K_reg.sroa.20.16.copyload4351, %for.cond876.preheader ]
  %224 = phi <4 x half> [ undef, %if.else869 ], [ %K_reg.sroa.12.0.copyload4349, %for.cond876.preheader ]
  %225 = phi <4 x half> [ undef, %if.else869 ], [ %K_reg.sroa.0.0.copyload4347, %for.cond876.preheader ]
  %or.cond2458 = icmp ugt i32 %mul11.1, 1023
  %cmp905.not = icmp sgt i32 %mul11.1, %1
  %or.cond2459 = or i1 %or.cond2458, %cmp905.not
  br i1 %or.cond2459, label %if.end930, label %for.cond907.preheader

for.cond907.preheader:                            ; preds = %if.end899
  %226 = shl nsw i32 %cond.i.i2262.1, 10
  %mul914 = and i32 %226, 64512
  %add917 = add nuw nsw i32 %add884, %mul914
  %227 = zext nneg i32 %add917 to i64
  %add.ptr922 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %227
  %K_reg1.sroa.0.0.copyload4355 = load <4 x half>, ptr addrspace(4) %add.ptr922, align 16
  %K_reg1.sroa.12.0.add.ptr922.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr922, i64 8
  %K_reg1.sroa.12.0.copyload4357 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr922.sroa_idx, align 8
  %228 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %227
  %add.ptr922.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1024
  %K_reg1.sroa.20.16.copyload4359 = load <4 x half>, ptr addrspace(4) %add.ptr922.1, align 16
  %K_reg1.sroa.30.16.add.ptr922.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1032
  %K_reg1.sroa.30.16.copyload4361 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr922.1.sroa_idx, align 8
  br label %if.end930

if.end930:                                        ; preds = %for.cond907.preheader, %if.end899
  %229 = phi <4 x half> [ undef, %if.end899 ], [ %K_reg1.sroa.30.16.copyload4361, %for.cond907.preheader ]
  %230 = phi <4 x half> [ undef, %if.end899 ], [ %K_reg1.sroa.20.16.copyload4359, %for.cond907.preheader ]
  %231 = phi <4 x half> [ undef, %if.end899 ], [ %K_reg1.sroa.12.0.copyload4357, %for.cond907.preheader ]
  %232 = phi <4 x half> [ undef, %if.end899 ], [ %K_reg1.sroa.0.0.copyload4355, %for.cond907.preheader ]
  %or.cond2460 = icmp ugt i32 %mul11.2, 1023
  %cmp936.not = icmp sgt i32 %mul11.2, %1
  %or.cond2461 = or i1 %or.cond2460, %cmp936.not
  br i1 %or.cond2461, label %if.end961, label %for.cond938.preheader

for.cond938.preheader:                            ; preds = %if.end930
  %233 = shl nsw i32 %cond.i.i2262.2, 10
  %mul945 = and i32 %233, 64512
  %add948 = add nuw nsw i32 %add884, %mul945
  %234 = zext nneg i32 %add948 to i64
  %add.ptr953 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %234
  %K_reg2.sroa.0.0.copyload4363 = load <4 x half>, ptr addrspace(4) %add.ptr953, align 16
  %K_reg2.sroa.12.0.add.ptr953.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr953, i64 8
  %K_reg2.sroa.12.0.copyload4365 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr953.sroa_idx, align 8
  %235 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %234
  %add.ptr953.1 = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1024
  %K_reg2.sroa.20.16.copyload4367 = load <4 x half>, ptr addrspace(4) %add.ptr953.1, align 16
  %K_reg2.sroa.30.16.add.ptr953.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1032
  %K_reg2.sroa.30.16.copyload4369 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr953.1.sroa_idx, align 8
  br label %if.end961

if.end961:                                        ; preds = %for.cond938.preheader, %if.end930
  %236 = phi <4 x half> [ undef, %if.end930 ], [ %K_reg2.sroa.30.16.copyload4369, %for.cond938.preheader ]
  %237 = phi <4 x half> [ undef, %if.end930 ], [ %K_reg2.sroa.20.16.copyload4367, %for.cond938.preheader ]
  %238 = phi <4 x half> [ undef, %if.end930 ], [ %K_reg2.sroa.12.0.copyload4365, %for.cond938.preheader ]
  %239 = phi <4 x half> [ undef, %if.end930 ], [ %K_reg2.sroa.0.0.copyload4363, %for.cond938.preheader ]
  %or.cond2462 = icmp ugt i32 %mul11.3, 1023
  %cmp967.not = icmp sgt i32 %mul11.3, %1
  %or.cond2463 = or i1 %or.cond2462, %cmp967.not
  br i1 %or.cond2463, label %if.end992, label %for.cond969.preheader

for.cond969.preheader:                            ; preds = %if.end961
  %240 = shl nsw i32 %cond.i.i2262.3, 10
  %mul976 = and i32 %240, 64512
  %add979 = add nuw nsw i32 %add884, %mul976
  %241 = zext nneg i32 %add979 to i64
  %add.ptr984 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %241
  %K_reg3.sroa.0.0.copyload4371 = load <4 x half>, ptr addrspace(4) %add.ptr984, align 16
  %K_reg3.sroa.12.0.add.ptr984.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr984, i64 8
  %K_reg3.sroa.12.0.copyload4373 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr984.sroa_idx, align 8
  %242 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %241
  %add.ptr984.1 = getelementptr inbounds i8, ptr addrspace(4) %242, i64 1024
  %K_reg3.sroa.20.16.copyload4375 = load <4 x half>, ptr addrspace(4) %add.ptr984.1, align 16
  %K_reg3.sroa.30.16.add.ptr984.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %242, i64 1032
  %K_reg3.sroa.30.16.copyload4377 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr984.1.sroa_idx, align 8
  br label %if.end992

if.end992:                                        ; preds = %for.cond969.preheader, %if.end961
  %243 = phi <4 x half> [ undef, %if.end961 ], [ %K_reg3.sroa.30.16.copyload4377, %for.cond969.preheader ]
  %244 = phi <4 x half> [ undef, %if.end961 ], [ %K_reg3.sroa.20.16.copyload4375, %for.cond969.preheader ]
  %245 = phi <4 x half> [ undef, %if.end961 ], [ %K_reg3.sroa.12.0.copyload4373, %for.cond969.preheader ]
  %246 = phi <4 x half> [ undef, %if.end961 ], [ %K_reg3.sroa.0.0.copyload4371, %for.cond969.preheader ]
  br i1 %or.cond2457, label %if.end1138, label %for.cond1000.preheader

for.cond1000.preheader:                           ; preds = %if.end992
  %247 = shl nsw i32 %cond.i.i2262, 10
  %mul1007 = and i32 %247, 64512
  %add1010 = add nuw nsw i32 %add884, %mul1007
  %248 = zext nneg i32 %add1010 to i64
  %add.ptr1015 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %248
  %V_reg.sroa.0.0.copyload4330 = load <4 x half>, ptr addrspace(4) %add.ptr1015, align 16
  %V_reg.sroa.42.0.add.ptr1015.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1015, i64 8
  %V_reg.sroa.42.0.copyload4334 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1015.sroa_idx, align 8
  %249 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %248
  %add.ptr1015.1 = getelementptr inbounds i8, ptr addrspace(4) %249, i64 1024
  %V_reg.sroa.74.16.copyload4338 = load <4 x half>, ptr addrspace(4) %add.ptr1015.1, align 16
  %V_reg.sroa.114.16.add.ptr1015.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %249, i64 1032
  %V_reg.sroa.114.16.copyload4342 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1015.1.sroa_idx, align 8
  %cmp1025 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp1025, label %for.cond1027.preheader, label %if.end1051

for.cond1027.preheader:                           ; preds = %for.cond1000.preheader
  %add1034 = add nuw nsw i32 %mul11, %mul1033
  %cmp1037.not = icmp sgt i32 %add1034, %1
  %fneg. = select i1 %cmp1037.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2941 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp1037.not.1.not = icmp slt i32 %add1034, %1
  %fneg..1 = select i1 %cmp1037.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3130 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2941, float %fneg..1, i64 1
  %add1035.2 = or disjoint i32 %add1034, 2
  %cmp1037.not.2 = icmp sgt i32 %add1035.2, %1
  %fneg..2 = select i1 %cmp1037.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3303 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3130, float %fneg..2, i64 2
  %add1035.3 = or disjoint i32 %add1034, 3
  %cmp1037.not.3 = icmp sgt i32 %add1035.3, %1
  %fneg..3 = select i1 %cmp1037.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3476 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3303, float %fneg..3, i64 3
  br label %if.end1051

if.end1051:                                       ; preds = %for.cond1000.preheader, %for.cond1027.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3476, %for.cond1027.preheader ], [ zeroinitializer, %for.cond1000.preheader ]
  %250 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %225, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !90
  %251 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %250), !call_argsrelate !90
  %252 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %223, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %251), !call_argsrelate !90
  %253 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %222, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %252), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %253, i64 0
  %mul1086 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %254 = tail call contract noundef float @llvm.minnum.f32(float %mul1086, float 0x4024CB5EC0000000)
  %255 = tail call contract noundef float @llvm.exp.f32(float %254)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %253, i64 1
  %mul1086.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %256 = tail call contract noundef float @llvm.minnum.f32(float %mul1086.1, float 0x4024CB5EC0000000)
  %257 = tail call contract noundef float @llvm.exp.f32(float %256)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %253, i64 2
  %mul1086.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %258 = tail call contract noundef float @llvm.minnum.f32(float %mul1086.2, float 0x4024CB5EC0000000)
  %259 = tail call contract noundef float @llvm.exp.f32(float %258)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %253, i64 3
  %mul1086.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %260 = tail call contract noundef float @llvm.minnum.f32(float %mul1086.3, float 0x4024CB5EC0000000)
  %261 = tail call contract noundef float @llvm.exp.f32(float %260)
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %255)
  %263 = insertelement <4 x i16> poison, i16 %262, i64 0
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %257)
  %265 = insertelement <4 x i16> %263, i16 %264, i64 1
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %259)
  %267 = insertelement <4 x i16> %265, i16 %266, i64 2
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %261)
  %269 = insertelement <4 x i16> %267, i16 %268, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %269 to <4 x half>
  %270 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload4330, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !203
  %271 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload4334, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !203
  %272 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload4338, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !203
  %273 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload4342, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !203
  br label %if.end1138

if.end1138:                                       ; preds = %if.end1051, %if.end992
  %acc_o.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end992 ], [ %273, %if.end1051 ]
  %acc_o.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end992 ], [ %272, %if.end1051 ]
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end992 ], [ %271, %if.end1051 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end992 ], [ %270, %if.end1051 ]
  %sum_acc.sroa.104.0 = phi float [ 0.000000e+00, %if.end992 ], [ %261, %if.end1051 ]
  %sum_acc.sroa.70.0 = phi float [ 0.000000e+00, %if.end992 ], [ %259, %if.end1051 ]
  %sum_acc.sroa.36.0 = phi float [ 0.000000e+00, %if.end992 ], [ %257, %if.end1051 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end992 ], [ %255, %if.end1051 ]
  br i1 %or.cond2459, label %if.end1284, label %for.cond1146.preheader

for.cond1146.preheader:                           ; preds = %if.end1138
  %274 = shl nsw i32 %cond.i.i2262.1, 10
  %mul1153 = and i32 %274, 64512
  %add1156 = add nuw nsw i32 %add884, %mul1153
  %275 = zext nneg i32 %add1156 to i64
  %add.ptr1161 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %275
  %V_reg.sroa.0.0.copyload36484331 = load <4 x half>, ptr addrspace(4) %add.ptr1161, align 16
  %V_reg.sroa.42.0.add.ptr1161.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1161, i64 8
  %V_reg.sroa.42.0.copyload36694335 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1161.sroa_idx, align 8
  %276 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %275
  %add.ptr1161.1 = getelementptr inbounds i8, ptr addrspace(4) %276, i64 1024
  %V_reg.sroa.74.16.copyload37504339 = load <4 x half>, ptr addrspace(4) %add.ptr1161.1, align 16
  %V_reg.sroa.114.16.add.ptr1161.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %276, i64 1032
  %V_reg.sroa.114.16.copyload37714343 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1161.1.sroa_idx, align 8
  %cmp1171 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp1171, label %for.cond1173.preheader, label %if.end1197

for.cond1173.preheader:                           ; preds = %for.cond1146.preheader
  %add1180 = add nuw nsw i32 %mul11.1, %mul1033
  %cmp1183.not = icmp sgt i32 %add1180, %1
  %fneg.2127 = select i1 %cmp1183.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2950 = insertelement <4 x float> poison, float %fneg.2127, i64 0
  %cmp1183.not.1.not = icmp slt i32 %add1180, %1
  %fneg.2127.1 = select i1 %cmp1183.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3139 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2950, float %fneg.2127.1, i64 1
  %add1181.2 = or disjoint i32 %add1180, 2
  %cmp1183.not.2 = icmp sgt i32 %add1181.2, %1
  %fneg.2127.2 = select i1 %cmp1183.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3312 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3139, float %fneg.2127.2, i64 2
  %add1181.3 = or disjoint i32 %add1180, 3
  %cmp1183.not.3 = icmp sgt i32 %add1181.3, %1
  %fneg.2127.3 = select i1 %cmp1183.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3485 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3312, float %fneg.2127.3, i64 3
  br label %if.end1197

if.end1197:                                       ; preds = %for.cond1146.preheader, %for.cond1173.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3485, %for.cond1173.preheader ], [ zeroinitializer, %for.cond1146.preheader ]
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %232, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !90
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %231, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %277), !call_argsrelate !90
  %279 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %230, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %278), !call_argsrelate !90
  %280 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %229, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %279), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract2952 = extractelement <4 x float> %280, i64 0
  %mul1232 = fmul contract float %acc_s.sroa.0.0.vec.extract2952, 0x3FB99999A0000000
  %281 = tail call contract noundef float @llvm.minnum.f32(float %mul1232, float 0x4024CB5EC0000000)
  %282 = tail call contract noundef float @llvm.exp.f32(float %281)
  %acc_s.sroa.0.4.vec.extract3141 = extractelement <4 x float> %280, i64 1
  %mul1232.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3141, 0x3FB99999A0000000
  %283 = tail call contract noundef float @llvm.minnum.f32(float %mul1232.1, float 0x4024CB5EC0000000)
  %284 = tail call contract noundef float @llvm.exp.f32(float %283)
  %acc_s.sroa.0.8.vec.extract3314 = extractelement <4 x float> %280, i64 2
  %mul1232.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3314, 0x3FB99999A0000000
  %285 = tail call contract noundef float @llvm.minnum.f32(float %mul1232.2, float 0x4024CB5EC0000000)
  %286 = tail call contract noundef float @llvm.exp.f32(float %285)
  %acc_s.sroa.0.12.vec.extract3487 = extractelement <4 x float> %280, i64 3
  %mul1232.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3487, 0x3FB99999A0000000
  %287 = tail call contract noundef float @llvm.minnum.f32(float %mul1232.3, float 0x4024CB5EC0000000)
  %288 = tail call contract noundef float @llvm.exp.f32(float %287)
  %add1248 = fadd contract float %sum_acc.sroa.0.0, %282
  %add1248.1 = fadd contract float %sum_acc.sroa.36.0, %284
  %add1248.2 = fadd contract float %sum_acc.sroa.70.0, %286
  %add1248.3 = fadd contract float %sum_acc.sroa.104.0, %288
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %282)
  %290 = insertelement <4 x i16> poison, i16 %289, i64 0
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %284)
  %292 = insertelement <4 x i16> %290, i16 %291, i64 1
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %286)
  %294 = insertelement <4 x i16> %292, i16 %293, i64 2
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %288)
  %296 = insertelement <4 x i16> %294, i16 %295, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2881 = bitcast <4 x i16> %296 to <4 x half>
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload36484331, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2881, <4 x float> zeroinitializer), !call_argsrelate !203
  %298 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload36694335, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2881, <4 x float> zeroinitializer), !call_argsrelate !203
  %299 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload37504339, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2881, <4 x float> zeroinitializer), !call_argsrelate !203
  %300 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload37714343, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2881, <4 x float> zeroinitializer), !call_argsrelate !203
  br label %if.end1284

if.end1284:                                       ; preds = %if.end1197, %if.end1138
  %acc_o_alt.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1138 ], [ %300, %if.end1197 ]
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1138 ], [ %299, %if.end1197 ]
  %acc_o_alt.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1138 ], [ %298, %if.end1197 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1138 ], [ %297, %if.end1197 ]
  %sum_acc.sroa.104.1 = phi float [ %sum_acc.sroa.104.0, %if.end1138 ], [ %add1248.3, %if.end1197 ]
  %sum_acc.sroa.70.1 = phi float [ %sum_acc.sroa.70.0, %if.end1138 ], [ %add1248.2, %if.end1197 ]
  %sum_acc.sroa.36.1 = phi float [ %sum_acc.sroa.36.0, %if.end1138 ], [ %add1248.1, %if.end1197 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end1138 ], [ %add1248, %if.end1197 ]
  br i1 %or.cond2461, label %if.end1430, label %for.cond1292.preheader

for.cond1292.preheader:                           ; preds = %if.end1284
  %301 = shl nsw i32 %cond.i.i2262.2, 10
  %mul1299 = and i32 %301, 64512
  %add1302 = add nuw nsw i32 %add884, %mul1299
  %302 = zext nneg i32 %add1302 to i64
  %add.ptr1307 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %302
  %V_reg.sroa.0.0.copyload36494332 = load <4 x half>, ptr addrspace(4) %add.ptr1307, align 16
  %V_reg.sroa.42.0.add.ptr1307.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1307, i64 8
  %V_reg.sroa.42.0.copyload36704336 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1307.sroa_idx, align 8
  %303 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %302
  %add.ptr1307.1 = getelementptr inbounds i8, ptr addrspace(4) %303, i64 1024
  %V_reg.sroa.74.16.copyload37514340 = load <4 x half>, ptr addrspace(4) %add.ptr1307.1, align 16
  %V_reg.sroa.114.16.add.ptr1307.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %303, i64 1032
  %V_reg.sroa.114.16.copyload37724344 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1307.1.sroa_idx, align 8
  %cmp1317 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp1317, label %for.cond1319.preheader, label %if.end1343

for.cond1319.preheader:                           ; preds = %for.cond1292.preheader
  %add1326 = add nuw nsw i32 %mul11.2, %mul1033
  %cmp1329.not = icmp sgt i32 %add1326, %1
  %fneg.2128 = select i1 %cmp1329.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2960 = insertelement <4 x float> poison, float %fneg.2128, i64 0
  %cmp1329.not.1.not = icmp slt i32 %add1326, %1
  %fneg.2128.1 = select i1 %cmp1329.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3149 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2960, float %fneg.2128.1, i64 1
  %add1327.2 = or disjoint i32 %add1326, 2
  %cmp1329.not.2 = icmp sgt i32 %add1327.2, %1
  %fneg.2128.2 = select i1 %cmp1329.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3322 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3149, float %fneg.2128.2, i64 2
  %add1327.3 = or disjoint i32 %add1326, 3
  %cmp1329.not.3 = icmp sgt i32 %add1327.3, %1
  %fneg.2128.3 = select i1 %cmp1329.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3495 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3322, float %fneg.2128.3, i64 3
  br label %if.end1343

if.end1343:                                       ; preds = %for.cond1292.preheader, %for.cond1319.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3495, %for.cond1319.preheader ], [ zeroinitializer, %for.cond1292.preheader ]
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %239, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !90
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %238, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %304), !call_argsrelate !90
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %237, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %305), !call_argsrelate !90
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %236, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %306), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract2962 = extractelement <4 x float> %307, i64 0
  %mul1378 = fmul contract float %acc_s.sroa.0.0.vec.extract2962, 0x3FB99999A0000000
  %308 = tail call contract noundef float @llvm.minnum.f32(float %mul1378, float 0x4024CB5EC0000000)
  %309 = tail call contract noundef float @llvm.exp.f32(float %308)
  %acc_s.sroa.0.4.vec.extract3151 = extractelement <4 x float> %307, i64 1
  %mul1378.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3151, 0x3FB99999A0000000
  %310 = tail call contract noundef float @llvm.minnum.f32(float %mul1378.1, float 0x4024CB5EC0000000)
  %311 = tail call contract noundef float @llvm.exp.f32(float %310)
  %acc_s.sroa.0.8.vec.extract3324 = extractelement <4 x float> %307, i64 2
  %mul1378.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3324, 0x3FB99999A0000000
  %312 = tail call contract noundef float @llvm.minnum.f32(float %mul1378.2, float 0x4024CB5EC0000000)
  %313 = tail call contract noundef float @llvm.exp.f32(float %312)
  %acc_s.sroa.0.12.vec.extract3497 = extractelement <4 x float> %307, i64 3
  %mul1378.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3497, 0x3FB99999A0000000
  %314 = tail call contract noundef float @llvm.minnum.f32(float %mul1378.3, float 0x4024CB5EC0000000)
  %315 = tail call contract noundef float @llvm.exp.f32(float %314)
  %add1394 = fadd contract float %sum_acc.sroa.0.1, %309
  %add1394.1 = fadd contract float %sum_acc.sroa.36.1, %311
  %add1394.2 = fadd contract float %sum_acc.sroa.70.1, %313
  %add1394.3 = fadd contract float %sum_acc.sroa.104.1, %315
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %309)
  %317 = insertelement <4 x i16> poison, i16 %316, i64 0
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %311)
  %319 = insertelement <4 x i16> %317, i16 %318, i64 1
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %313)
  %321 = insertelement <4 x i16> %319, i16 %320, i64 2
  %322 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %315)
  %323 = insertelement <4 x i16> %321, i16 %322, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2883 = bitcast <4 x i16> %323 to <4 x half>
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload36494332, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2883, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !203
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload36704336, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2883, <4 x float> %acc_o.sroa.42.0), !call_argsrelate !203
  %326 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload37514340, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2883, <4 x float> %acc_o.sroa.82.0), !call_argsrelate !203
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload37724344, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2883, <4 x float> %acc_o.sroa.122.0), !call_argsrelate !203
  br label %if.end1430

if.end1430:                                       ; preds = %if.end1343, %if.end1284
  %acc_o.sroa.122.1 = phi <4 x float> [ %acc_o.sroa.122.0, %if.end1284 ], [ %327, %if.end1343 ]
  %acc_o.sroa.82.1 = phi <4 x float> [ %acc_o.sroa.82.0, %if.end1284 ], [ %326, %if.end1343 ]
  %acc_o.sroa.42.1 = phi <4 x float> [ %acc_o.sroa.42.0, %if.end1284 ], [ %325, %if.end1343 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1284 ], [ %324, %if.end1343 ]
  %sum_acc.sroa.104.2 = phi float [ %sum_acc.sroa.104.1, %if.end1284 ], [ %add1394.3, %if.end1343 ]
  %sum_acc.sroa.70.2 = phi float [ %sum_acc.sroa.70.1, %if.end1284 ], [ %add1394.2, %if.end1343 ]
  %sum_acc.sroa.36.2 = phi float [ %sum_acc.sroa.36.1, %if.end1284 ], [ %add1394.1, %if.end1343 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end1284 ], [ %add1394, %if.end1343 ]
  br i1 %or.cond2463, label %if.end1577, label %for.cond1438.preheader

for.cond1438.preheader:                           ; preds = %if.end1430
  %328 = shl nsw i32 %cond.i.i2262.3, 10
  %mul1445 = and i32 %328, 64512
  %add1448 = add nuw nsw i32 %add884, %mul1445
  %329 = zext nneg i32 %add1448 to i64
  %add.ptr1453 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %329
  %V_reg.sroa.0.0.copyload36504333 = load <4 x half>, ptr addrspace(4) %add.ptr1453, align 16
  %V_reg.sroa.42.0.add.ptr1453.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1453, i64 8
  %V_reg.sroa.42.0.copyload36714337 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1453.sroa_idx, align 8
  %330 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %329
  %add.ptr1453.1 = getelementptr inbounds i8, ptr addrspace(4) %330, i64 1024
  %V_reg.sroa.74.16.copyload37524341 = load <4 x half>, ptr addrspace(4) %add.ptr1453.1, align 16
  %V_reg.sroa.114.16.add.ptr1453.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %330, i64 1032
  %V_reg.sroa.114.16.copyload37734345 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1453.1.sroa_idx, align 8
  %cmp1463 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp1463, label %for.cond1465.preheader, label %if.end1489

for.cond1465.preheader:                           ; preds = %for.cond1438.preheader
  %add1472 = add nuw nsw i32 %mul11.3, %mul1033
  %cmp1475.not = icmp sgt i32 %add1472, %1
  %fneg.2129 = select i1 %cmp1475.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2970 = insertelement <4 x float> poison, float %fneg.2129, i64 0
  %cmp1475.not.1.not = icmp slt i32 %add1472, %1
  %fneg.2129.1 = select i1 %cmp1475.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3159 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2970, float %fneg.2129.1, i64 1
  %add1473.2 = or disjoint i32 %add1472, 2
  %cmp1475.not.2 = icmp sgt i32 %add1473.2, %1
  %fneg.2129.2 = select i1 %cmp1475.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3332 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3159, float %fneg.2129.2, i64 2
  %add1473.3 = or disjoint i32 %add1472, 3
  %cmp1475.not.3 = icmp sgt i32 %add1473.3, %1
  %fneg.2129.3 = select i1 %cmp1475.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3505 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3332, float %fneg.2129.3, i64 3
  br label %if.end1489

if.end1489:                                       ; preds = %for.cond1438.preheader, %for.cond1465.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3505, %for.cond1465.preheader ], [ zeroinitializer, %for.cond1438.preheader ]
  %331 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %246, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !90
  %332 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %245, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %331), !call_argsrelate !90
  %333 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %244, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %332), !call_argsrelate !90
  %334 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %243, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %333), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract2972 = extractelement <4 x float> %334, i64 0
  %mul1524 = fmul contract float %acc_s.sroa.0.0.vec.extract2972, 0x3FB99999A0000000
  %335 = tail call contract noundef float @llvm.minnum.f32(float %mul1524, float 0x4024CB5EC0000000)
  %336 = tail call contract noundef float @llvm.exp.f32(float %335)
  %acc_s.sroa.0.4.vec.extract3161 = extractelement <4 x float> %334, i64 1
  %mul1524.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3161, 0x3FB99999A0000000
  %337 = tail call contract noundef float @llvm.minnum.f32(float %mul1524.1, float 0x4024CB5EC0000000)
  %338 = tail call contract noundef float @llvm.exp.f32(float %337)
  %acc_s.sroa.0.8.vec.extract3334 = extractelement <4 x float> %334, i64 2
  %mul1524.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3334, 0x3FB99999A0000000
  %339 = tail call contract noundef float @llvm.minnum.f32(float %mul1524.2, float 0x4024CB5EC0000000)
  %340 = tail call contract noundef float @llvm.exp.f32(float %339)
  %acc_s.sroa.0.12.vec.extract3507 = extractelement <4 x float> %334, i64 3
  %mul1524.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3507, 0x3FB99999A0000000
  %341 = tail call contract noundef float @llvm.minnum.f32(float %mul1524.3, float 0x4024CB5EC0000000)
  %342 = tail call contract noundef float @llvm.exp.f32(float %341)
  %add1540 = fadd contract float %sum_acc.sroa.0.2, %336
  %add1540.1 = fadd contract float %sum_acc.sroa.36.2, %338
  %add1540.2 = fadd contract float %sum_acc.sroa.70.2, %340
  %add1540.3 = fadd contract float %sum_acc.sroa.104.2, %342
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %336)
  %344 = insertelement <4 x i16> poison, i16 %343, i64 0
  %345 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %338)
  %346 = insertelement <4 x i16> %344, i16 %345, i64 1
  %347 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %340)
  %348 = insertelement <4 x i16> %346, i16 %347, i64 2
  %349 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %342)
  %350 = insertelement <4 x i16> %348, i16 %349, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2885 = bitcast <4 x i16> %350 to <4 x half>
  %351 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload36504333, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2885, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !203
  %352 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload36714337, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2885, <4 x float> %acc_o_alt.sroa.26.0), !call_argsrelate !203
  %353 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload37524341, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2885, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !203
  %354 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload37734345, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2885, <4 x float> %acc_o_alt.sroa.74.0), !call_argsrelate !203
  br label %if.end1577

if.end1577:                                       ; preds = %if.end1489, %if.end771.1, %if.end1430
  %acc_o.sroa.122.2 = phi <4 x float> [ %182, %if.end771.1 ], [ %acc_o.sroa.122.1, %if.end1430 ], [ %acc_o.sroa.122.1, %if.end1489 ]
  %acc_o.sroa.82.2 = phi <4 x float> [ %181, %if.end771.1 ], [ %acc_o.sroa.82.1, %if.end1430 ], [ %acc_o.sroa.82.1, %if.end1489 ]
  %acc_o.sroa.42.2 = phi <4 x float> [ %180, %if.end771.1 ], [ %acc_o.sroa.42.1, %if.end1430 ], [ %acc_o.sroa.42.1, %if.end1489 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %179, %if.end771.1 ], [ %acc_o.sroa.0.1, %if.end1430 ], [ %acc_o.sroa.0.1, %if.end1489 ]
  %acc_o_alt.sroa.74.1 = phi <4 x float> [ %218, %if.end771.1 ], [ %acc_o_alt.sroa.74.0, %if.end1430 ], [ %354, %if.end1489 ]
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %217, %if.end771.1 ], [ %acc_o_alt.sroa.50.0, %if.end1430 ], [ %353, %if.end1489 ]
  %acc_o_alt.sroa.26.1 = phi <4 x float> [ %216, %if.end771.1 ], [ %acc_o_alt.sroa.26.0, %if.end1430 ], [ %352, %if.end1489 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %215, %if.end771.1 ], [ %acc_o_alt.sroa.0.0, %if.end1430 ], [ %351, %if.end1489 ]
  %sum_acc.sroa.104.3 = phi float [ %add833.3, %if.end771.1 ], [ %sum_acc.sroa.104.2, %if.end1430 ], [ %add1540.3, %if.end1489 ]
  %sum_acc.sroa.70.3 = phi float [ %add833.2, %if.end771.1 ], [ %sum_acc.sroa.70.2, %if.end1430 ], [ %add1540.2, %if.end1489 ]
  %sum_acc.sroa.36.3 = phi float [ %add833.1, %if.end771.1 ], [ %sum_acc.sroa.36.2, %if.end1430 ], [ %add1540.1, %if.end1489 ]
  %sum_acc.sroa.0.3 = phi float [ %add833, %if.end771.1 ], [ %sum_acc.sroa.0.2, %if.end1430 ], [ %add1540, %if.end1489 ]
  %355 = phi <4 x half> [ %34, %if.end771.1 ], [ %222, %if.end1430 ], [ %222, %if.end1489 ]
  %356 = phi <4 x half> [ %35, %if.end771.1 ], [ %223, %if.end1430 ], [ %223, %if.end1489 ]
  %357 = phi <4 x half> [ %28, %if.end771.1 ], [ %224, %if.end1430 ], [ %224, %if.end1489 ]
  %358 = phi <4 x half> [ %29, %if.end771.1 ], [ %225, %if.end1430 ], [ %225, %if.end1489 ]
  %359 = phi <4 x half> [ %47, %if.end771.1 ], [ %229, %if.end1430 ], [ %229, %if.end1489 ]
  %360 = phi <4 x half> [ %48, %if.end771.1 ], [ %230, %if.end1430 ], [ %230, %if.end1489 ]
  %361 = phi <4 x half> [ %41, %if.end771.1 ], [ %231, %if.end1430 ], [ %231, %if.end1489 ]
  %362 = phi <4 x half> [ %42, %if.end771.1 ], [ %232, %if.end1430 ], [ %232, %if.end1489 ]
  %363 = phi <4 x half> [ %60, %if.end771.1 ], [ %236, %if.end1430 ], [ %236, %if.end1489 ]
  %364 = phi <4 x half> [ %61, %if.end771.1 ], [ %237, %if.end1430 ], [ %237, %if.end1489 ]
  %365 = phi <4 x half> [ %54, %if.end771.1 ], [ %238, %if.end1430 ], [ %238, %if.end1489 ]
  %366 = phi <4 x half> [ %55, %if.end771.1 ], [ %239, %if.end1430 ], [ %239, %if.end1489 ]
  %367 = phi <4 x half> [ %73, %if.end771.1 ], [ %243, %if.end1430 ], [ %243, %if.end1489 ]
  %368 = phi <4 x half> [ %74, %if.end771.1 ], [ %244, %if.end1430 ], [ %244, %if.end1489 ]
  %369 = phi <4 x half> [ %67, %if.end771.1 ], [ %245, %if.end1430 ], [ %245, %if.end1489 ]
  %370 = phi <4 x half> [ %68, %if.end771.1 ], [ %246, %if.end1430 ], [ %246, %if.end1489 ]
  %cond.i.i.i.1 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.4, i32 %mul11.5)
  %cond.i.i.i2263.1 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.6, i32 %mul11.7)
  %cond.i.i.i2264.1 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i.1, i32 %cond.i.i.i2263.1)
  %cmp97.1 = icmp ult i32 %cond.i.i.i2264.1, %shr95
  br i1 %cmp97.1, label %for.cond98.preheader.1, label %if.else869.1

if.else869.1:                                     ; preds = %if.end1577
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023
  %cmp874.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond2457.1 = or i1 %or.cond.1, %cmp874.not.1
  br i1 %or.cond2457.1, label %if.end899.1, label %for.cond876.preheader.1

for.cond876.preheader.1:                          ; preds = %if.else869.1
  %371 = shl nsw i32 %cond.i.i2262.4, 10
  %mul883.1 = and i32 %371, 64512
  %add886.1 = add nuw nsw i32 %add884, %mul883.1
  %372 = zext nneg i32 %add886.1 to i64
  %add.ptr891.12565 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %372
  %K_reg.sroa.0.0.copyload39364346 = load <4 x half>, ptr addrspace(4) %add.ptr891.12565, align 16
  %K_reg.sroa.12.0.add.ptr891.12565.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr891.12565, i64 8
  %K_reg.sroa.12.0.copyload39394348 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr891.12565.sroa_idx, align 8
  %373 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %372
  %add.ptr891.1.1 = getelementptr inbounds i8, ptr addrspace(4) %373, i64 1024
  %K_reg.sroa.20.16.copyload39544350 = load <4 x half>, ptr addrspace(4) %add.ptr891.1.1, align 16
  %K_reg.sroa.30.16.add.ptr891.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %373, i64 1032
  %K_reg.sroa.30.16.copyload39574352 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr891.1.1.sroa_idx, align 8
  br label %if.end899.1

if.end899.1:                                      ; preds = %for.cond876.preheader.1, %if.else869.1
  %374 = phi <4 x half> [ %355, %if.else869.1 ], [ %K_reg.sroa.30.16.copyload39574352, %for.cond876.preheader.1 ]
  %375 = phi <4 x half> [ %356, %if.else869.1 ], [ %K_reg.sroa.20.16.copyload39544350, %for.cond876.preheader.1 ]
  %376 = phi <4 x half> [ %357, %if.else869.1 ], [ %K_reg.sroa.12.0.copyload39394348, %for.cond876.preheader.1 ]
  %377 = phi <4 x half> [ %358, %if.else869.1 ], [ %K_reg.sroa.0.0.copyload39364346, %for.cond876.preheader.1 ]
  %or.cond2458.1 = icmp ugt i32 %mul11.5, 1023
  %cmp905.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond2459.1 = or i1 %or.cond2458.1, %cmp905.not.1
  br i1 %or.cond2459.1, label %if.end930.1, label %for.cond907.preheader.1

for.cond907.preheader.1:                          ; preds = %if.end899.1
  %378 = shl nsw i32 %cond.i.i2262.5, 10
  %mul914.1 = and i32 %378, 64512
  %add917.1 = add nuw nsw i32 %add884, %mul914.1
  %379 = zext nneg i32 %add917.1 to i64
  %add.ptr922.12566 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %379
  %K_reg1.sroa.0.0.copyload39004354 = load <4 x half>, ptr addrspace(4) %add.ptr922.12566, align 16
  %K_reg1.sroa.12.0.add.ptr922.12566.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr922.12566, i64 8
  %K_reg1.sroa.12.0.copyload39034356 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr922.12566.sroa_idx, align 8
  %380 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %379
  %add.ptr922.1.1 = getelementptr inbounds i8, ptr addrspace(4) %380, i64 1024
  %K_reg1.sroa.20.16.copyload39184358 = load <4 x half>, ptr addrspace(4) %add.ptr922.1.1, align 16
  %K_reg1.sroa.30.16.add.ptr922.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %380, i64 1032
  %K_reg1.sroa.30.16.copyload39214360 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr922.1.1.sroa_idx, align 8
  br label %if.end930.1

if.end930.1:                                      ; preds = %for.cond907.preheader.1, %if.end899.1
  %381 = phi <4 x half> [ %359, %if.end899.1 ], [ %K_reg1.sroa.30.16.copyload39214360, %for.cond907.preheader.1 ]
  %382 = phi <4 x half> [ %360, %if.end899.1 ], [ %K_reg1.sroa.20.16.copyload39184358, %for.cond907.preheader.1 ]
  %383 = phi <4 x half> [ %361, %if.end899.1 ], [ %K_reg1.sroa.12.0.copyload39034356, %for.cond907.preheader.1 ]
  %384 = phi <4 x half> [ %362, %if.end899.1 ], [ %K_reg1.sroa.0.0.copyload39004354, %for.cond907.preheader.1 ]
  %or.cond2460.1 = icmp ugt i32 %mul11.6, 1023
  %cmp936.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond2461.1 = or i1 %or.cond2460.1, %cmp936.not.1
  br i1 %or.cond2461.1, label %if.end961.1, label %for.cond938.preheader.1

for.cond938.preheader.1:                          ; preds = %if.end930.1
  %385 = shl nsw i32 %cond.i.i2262.6, 10
  %mul945.1 = and i32 %385, 64512
  %add948.1 = add nuw nsw i32 %add884, %mul945.1
  %386 = zext nneg i32 %add948.1 to i64
  %add.ptr953.12567 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %386
  %K_reg2.sroa.0.0.copyload38644362 = load <4 x half>, ptr addrspace(4) %add.ptr953.12567, align 16
  %K_reg2.sroa.12.0.add.ptr953.12567.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr953.12567, i64 8
  %K_reg2.sroa.12.0.copyload38674364 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr953.12567.sroa_idx, align 8
  %387 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %386
  %add.ptr953.1.1 = getelementptr inbounds i8, ptr addrspace(4) %387, i64 1024
  %K_reg2.sroa.20.16.copyload38824366 = load <4 x half>, ptr addrspace(4) %add.ptr953.1.1, align 16
  %K_reg2.sroa.30.16.add.ptr953.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %387, i64 1032
  %K_reg2.sroa.30.16.copyload38854368 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr953.1.1.sroa_idx, align 8
  br label %if.end961.1

if.end961.1:                                      ; preds = %for.cond938.preheader.1, %if.end930.1
  %388 = phi <4 x half> [ %363, %if.end930.1 ], [ %K_reg2.sroa.30.16.copyload38854368, %for.cond938.preheader.1 ]
  %389 = phi <4 x half> [ %364, %if.end930.1 ], [ %K_reg2.sroa.20.16.copyload38824366, %for.cond938.preheader.1 ]
  %390 = phi <4 x half> [ %365, %if.end930.1 ], [ %K_reg2.sroa.12.0.copyload38674364, %for.cond938.preheader.1 ]
  %391 = phi <4 x half> [ %366, %if.end930.1 ], [ %K_reg2.sroa.0.0.copyload38644362, %for.cond938.preheader.1 ]
  %or.cond2462.1 = icmp ugt i32 %mul11.7, 1023
  %cmp967.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond2463.1 = or i1 %or.cond2462.1, %cmp967.not.1
  br i1 %or.cond2463.1, label %if.end992.1, label %for.cond969.preheader.1

for.cond969.preheader.1:                          ; preds = %if.end961.1
  %392 = shl nsw i32 %cond.i.i2262.7, 10
  %mul976.1 = and i32 %392, 64512
  %add979.1 = add nuw nsw i32 %add884, %mul976.1
  %393 = zext nneg i32 %add979.1 to i64
  %add.ptr984.12568 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %393
  %K_reg3.sroa.0.0.copyload38284370 = load <4 x half>, ptr addrspace(4) %add.ptr984.12568, align 16
  %K_reg3.sroa.12.0.add.ptr984.12568.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr984.12568, i64 8
  %K_reg3.sroa.12.0.copyload38314372 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr984.12568.sroa_idx, align 8
  %394 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %393
  %add.ptr984.1.1 = getelementptr inbounds i8, ptr addrspace(4) %394, i64 1024
  %K_reg3.sroa.20.16.copyload38464374 = load <4 x half>, ptr addrspace(4) %add.ptr984.1.1, align 16
  %K_reg3.sroa.30.16.add.ptr984.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %394, i64 1032
  %K_reg3.sroa.30.16.copyload38494376 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr984.1.1.sroa_idx, align 8
  br label %if.end992.1

if.end992.1:                                      ; preds = %for.cond969.preheader.1, %if.end961.1
  %395 = phi <4 x half> [ %367, %if.end961.1 ], [ %K_reg3.sroa.30.16.copyload38494376, %for.cond969.preheader.1 ]
  %396 = phi <4 x half> [ %368, %if.end961.1 ], [ %K_reg3.sroa.20.16.copyload38464374, %for.cond969.preheader.1 ]
  %397 = phi <4 x half> [ %369, %if.end961.1 ], [ %K_reg3.sroa.12.0.copyload38314372, %for.cond969.preheader.1 ]
  %398 = phi <4 x half> [ %370, %if.end961.1 ], [ %K_reg3.sroa.0.0.copyload38284370, %for.cond969.preheader.1 ]
  br i1 %or.cond2457.1, label %if.end1138.1, label %for.cond1000.preheader.1

for.cond1000.preheader.1:                         ; preds = %if.end992.1
  %399 = shl nsw i32 %cond.i.i2262.4, 10
  %mul1007.1 = and i32 %399, 64512
  %add1010.1 = add nuw nsw i32 %add884, %mul1007.1
  %400 = zext nneg i32 %add1010.1 to i64
  %add.ptr1015.12569 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %400
  %V_reg.sroa.0.0.copyload36514314 = load <4 x half>, ptr addrspace(4) %add.ptr1015.12569, align 16
  %V_reg.sroa.42.0.add.ptr1015.12569.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1015.12569, i64 8
  %V_reg.sroa.42.0.copyload36724315 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1015.12569.sroa_idx, align 8
  %401 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %400
  %add.ptr1015.1.1 = getelementptr inbounds i8, ptr addrspace(4) %401, i64 1024
  %V_reg.sroa.74.16.copyload37534316 = load <4 x half>, ptr addrspace(4) %add.ptr1015.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1015.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %401, i64 1032
  %V_reg.sroa.114.16.copyload37744317 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1015.1.1.sroa_idx, align 8
  %cmp1025.1 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp1025.1, label %for.cond1027.preheader.1, label %if.end1051.1

for.cond1027.preheader.1:                         ; preds = %for.cond1000.preheader.1
  %add1034.1 = add nuw nsw i32 %mul11.4, %mul1033
  %cmp1037.not.12570 = icmp sgt i32 %add1034.1, %1
  %fneg..12571 = select i1 %cmp1037.not.12570, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3014 = insertelement <4 x float> poison, float %fneg..12571, i64 0
  %cmp1037.not.1.1.not = icmp slt i32 %add1034.1, %1
  %fneg..1.1 = select i1 %cmp1037.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3201 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3014, float %fneg..1.1, i64 1
  %add1035.2.1 = or disjoint i32 %add1034.1, 2
  %cmp1037.not.2.1 = icmp sgt i32 %add1035.2.1, %1
  %fneg..2.1 = select i1 %cmp1037.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3374 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3201, float %fneg..2.1, i64 2
  %add1035.3.1 = or disjoint i32 %add1034.1, 3
  %cmp1037.not.3.1 = icmp sgt i32 %add1035.3.1, %1
  %fneg..3.1 = select i1 %cmp1037.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3547 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3374, float %fneg..3.1, i64 3
  br label %if.end1051.1

if.end1051.1:                                     ; preds = %for.cond1000.preheader.1, %for.cond1027.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3547, %for.cond1027.preheader.1 ], [ zeroinitializer, %for.cond1000.preheader.1 ]
  %402 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %377, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !90
  %403 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %376, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %402), !call_argsrelate !90
  %404 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %375, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %403), !call_argsrelate !90
  %405 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %374, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %404), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3016 = extractelement <4 x float> %405, i64 0
  %mul1086.12575 = fmul contract float %acc_s.sroa.0.0.vec.extract3016, 0x3FB99999A0000000
  %406 = tail call contract noundef float @llvm.minnum.f32(float %mul1086.12575, float 0x4024CB5EC0000000)
  %407 = tail call contract noundef float @llvm.exp.f32(float %406)
  %acc_s.sroa.0.4.vec.extract3203 = extractelement <4 x float> %405, i64 1
  %mul1086.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3203, 0x3FB99999A0000000
  %408 = tail call contract noundef float @llvm.minnum.f32(float %mul1086.1.1, float 0x4024CB5EC0000000)
  %409 = tail call contract noundef float @llvm.exp.f32(float %408)
  %acc_s.sroa.0.8.vec.extract3376 = extractelement <4 x float> %405, i64 2
  %mul1086.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3376, 0x3FB99999A0000000
  %410 = tail call contract noundef float @llvm.minnum.f32(float %mul1086.2.1, float 0x4024CB5EC0000000)
  %411 = tail call contract noundef float @llvm.exp.f32(float %410)
  %acc_s.sroa.0.12.vec.extract3549 = extractelement <4 x float> %405, i64 3
  %mul1086.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3549, 0x3FB99999A0000000
  %412 = tail call contract noundef float @llvm.minnum.f32(float %mul1086.3.1, float 0x4024CB5EC0000000)
  %413 = tail call contract noundef float @llvm.exp.f32(float %412)
  %add1102.12576 = fadd contract float %sum_acc.sroa.0.3, %407
  %add1102.1.1 = fadd contract float %sum_acc.sroa.36.3, %409
  %add1102.2.1 = fadd contract float %sum_acc.sroa.70.3, %411
  %add1102.3.1 = fadd contract float %sum_acc.sroa.104.3, %413
  %414 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %407)
  %415 = insertelement <4 x i16> poison, i16 %414, i64 0
  %416 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %409)
  %417 = insertelement <4 x i16> %415, i16 %416, i64 1
  %418 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %411)
  %419 = insertelement <4 x i16> %417, i16 %418, i64 2
  %420 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %413)
  %421 = insertelement <4 x i16> %419, i16 %420, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2895 = bitcast <4 x i16> %421 to <4 x half>
  %422 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload36514314, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2895, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !203
  %423 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload36724315, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2895, <4 x float> %acc_o.sroa.42.2), !call_argsrelate !203
  %424 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload37534316, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2895, <4 x float> %acc_o.sroa.82.2), !call_argsrelate !203
  %425 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload37744317, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2895, <4 x float> %acc_o.sroa.122.2), !call_argsrelate !203
  br label %if.end1138.1

if.end1138.1:                                     ; preds = %if.end1051.1, %if.end992.1
  %acc_o.sroa.122.3 = phi <4 x float> [ %acc_o.sroa.122.2, %if.end992.1 ], [ %425, %if.end1051.1 ]
  %acc_o.sroa.82.3 = phi <4 x float> [ %acc_o.sroa.82.2, %if.end992.1 ], [ %424, %if.end1051.1 ]
  %acc_o.sroa.42.3 = phi <4 x float> [ %acc_o.sroa.42.2, %if.end992.1 ], [ %423, %if.end1051.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end992.1 ], [ %422, %if.end1051.1 ]
  %sum_acc.sroa.104.4 = phi float [ %sum_acc.sroa.104.3, %if.end992.1 ], [ %add1102.3.1, %if.end1051.1 ]
  %sum_acc.sroa.70.4 = phi float [ %sum_acc.sroa.70.3, %if.end992.1 ], [ %add1102.2.1, %if.end1051.1 ]
  %sum_acc.sroa.36.4 = phi float [ %sum_acc.sroa.36.3, %if.end992.1 ], [ %add1102.1.1, %if.end1051.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end992.1 ], [ %add1102.12576, %if.end1051.1 ]
  br i1 %or.cond2459.1, label %if.end1284.1, label %for.cond1146.preheader.1

for.cond1146.preheader.1:                         ; preds = %if.end1138.1
  %426 = shl nsw i32 %cond.i.i2262.5, 10
  %mul1153.1 = and i32 %426, 64512
  %add1156.1 = add nuw nsw i32 %add884, %mul1153.1
  %427 = zext nneg i32 %add1156.1 to i64
  %add.ptr1161.12577 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %427
  %V_reg.sroa.0.0.copyload36524318 = load <4 x half>, ptr addrspace(4) %add.ptr1161.12577, align 16
  %V_reg.sroa.42.0.add.ptr1161.12577.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1161.12577, i64 8
  %V_reg.sroa.42.0.copyload36734319 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1161.12577.sroa_idx, align 8
  %428 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %427
  %add.ptr1161.1.1 = getelementptr inbounds i8, ptr addrspace(4) %428, i64 1024
  %V_reg.sroa.74.16.copyload37544320 = load <4 x half>, ptr addrspace(4) %add.ptr1161.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1161.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %428, i64 1032
  %V_reg.sroa.114.16.copyload37754321 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1161.1.1.sroa_idx, align 8
  %cmp1171.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp1171.1, label %for.cond1173.preheader.1, label %if.end1197.1

for.cond1173.preheader.1:                         ; preds = %for.cond1146.preheader.1
  %add1180.1 = add nuw nsw i32 %mul11.5, %mul1033
  %cmp1183.not.12578 = icmp sgt i32 %add1180.1, %1
  %fneg.2127.12579 = select i1 %cmp1183.not.12578, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3026 = insertelement <4 x float> poison, float %fneg.2127.12579, i64 0
  %cmp1183.not.1.1.not = icmp slt i32 %add1180.1, %1
  %fneg.2127.1.1 = select i1 %cmp1183.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3211 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3026, float %fneg.2127.1.1, i64 1
  %add1181.2.1 = or disjoint i32 %add1180.1, 2
  %cmp1183.not.2.1 = icmp sgt i32 %add1181.2.1, %1
  %fneg.2127.2.1 = select i1 %cmp1183.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3384 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3211, float %fneg.2127.2.1, i64 2
  %add1181.3.1 = or disjoint i32 %add1180.1, 3
  %cmp1183.not.3.1 = icmp sgt i32 %add1181.3.1, %1
  %fneg.2127.3.1 = select i1 %cmp1183.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3557 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3384, float %fneg.2127.3.1, i64 3
  br label %if.end1197.1

if.end1197.1:                                     ; preds = %for.cond1146.preheader.1, %for.cond1173.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3557, %for.cond1173.preheader.1 ], [ zeroinitializer, %for.cond1146.preheader.1 ]
  %429 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %384, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !90
  %430 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %383, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %429), !call_argsrelate !90
  %431 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %382, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %430), !call_argsrelate !90
  %432 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %381, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %431), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3028 = extractelement <4 x float> %432, i64 0
  %mul1232.12583 = fmul contract float %acc_s.sroa.0.0.vec.extract3028, 0x3FB99999A0000000
  %433 = tail call contract noundef float @llvm.minnum.f32(float %mul1232.12583, float 0x4024CB5EC0000000)
  %434 = tail call contract noundef float @llvm.exp.f32(float %433)
  %acc_s.sroa.0.4.vec.extract3213 = extractelement <4 x float> %432, i64 1
  %mul1232.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3213, 0x3FB99999A0000000
  %435 = tail call contract noundef float @llvm.minnum.f32(float %mul1232.1.1, float 0x4024CB5EC0000000)
  %436 = tail call contract noundef float @llvm.exp.f32(float %435)
  %acc_s.sroa.0.8.vec.extract3386 = extractelement <4 x float> %432, i64 2
  %mul1232.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3386, 0x3FB99999A0000000
  %437 = tail call contract noundef float @llvm.minnum.f32(float %mul1232.2.1, float 0x4024CB5EC0000000)
  %438 = tail call contract noundef float @llvm.exp.f32(float %437)
  %acc_s.sroa.0.12.vec.extract3559 = extractelement <4 x float> %432, i64 3
  %mul1232.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3559, 0x3FB99999A0000000
  %439 = tail call contract noundef float @llvm.minnum.f32(float %mul1232.3.1, float 0x4024CB5EC0000000)
  %440 = tail call contract noundef float @llvm.exp.f32(float %439)
  %add1248.12584 = fadd contract float %sum_acc.sroa.0.4, %434
  %add1248.1.1 = fadd contract float %sum_acc.sroa.36.4, %436
  %add1248.2.1 = fadd contract float %sum_acc.sroa.70.4, %438
  %add1248.3.1 = fadd contract float %sum_acc.sroa.104.4, %440
  %441 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %434)
  %442 = insertelement <4 x i16> poison, i16 %441, i64 0
  %443 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %436)
  %444 = insertelement <4 x i16> %442, i16 %443, i64 1
  %445 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %438)
  %446 = insertelement <4 x i16> %444, i16 %445, i64 2
  %447 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %440)
  %448 = insertelement <4 x i16> %446, i16 %447, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2897 = bitcast <4 x i16> %448 to <4 x half>
  %449 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload36524318, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2897, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !203
  %450 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload36734319, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2897, <4 x float> %acc_o_alt.sroa.26.1), !call_argsrelate !203
  %451 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload37544320, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2897, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !203
  %452 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload37754321, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2897, <4 x float> %acc_o_alt.sroa.74.1), !call_argsrelate !203
  br label %if.end1284.1

if.end1284.1:                                     ; preds = %if.end1197.1, %if.end1138.1
  %acc_o_alt.sroa.74.2 = phi <4 x float> [ %acc_o_alt.sroa.74.1, %if.end1138.1 ], [ %452, %if.end1197.1 ]
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1138.1 ], [ %451, %if.end1197.1 ]
  %acc_o_alt.sroa.26.2 = phi <4 x float> [ %acc_o_alt.sroa.26.1, %if.end1138.1 ], [ %450, %if.end1197.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1138.1 ], [ %449, %if.end1197.1 ]
  %sum_acc.sroa.104.5 = phi float [ %sum_acc.sroa.104.4, %if.end1138.1 ], [ %add1248.3.1, %if.end1197.1 ]
  %sum_acc.sroa.70.5 = phi float [ %sum_acc.sroa.70.4, %if.end1138.1 ], [ %add1248.2.1, %if.end1197.1 ]
  %sum_acc.sroa.36.5 = phi float [ %sum_acc.sroa.36.4, %if.end1138.1 ], [ %add1248.1.1, %if.end1197.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end1138.1 ], [ %add1248.12584, %if.end1197.1 ]
  br i1 %or.cond2461.1, label %if.end1430.1, label %for.cond1292.preheader.1

for.cond1292.preheader.1:                         ; preds = %if.end1284.1
  %453 = shl nsw i32 %cond.i.i2262.6, 10
  %mul1299.1 = and i32 %453, 64512
  %add1302.1 = add nuw nsw i32 %add884, %mul1299.1
  %454 = zext nneg i32 %add1302.1 to i64
  %add.ptr1307.12585 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %454
  %V_reg.sroa.0.0.copyload36534322 = load <4 x half>, ptr addrspace(4) %add.ptr1307.12585, align 16
  %V_reg.sroa.42.0.add.ptr1307.12585.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1307.12585, i64 8
  %V_reg.sroa.42.0.copyload36744323 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1307.12585.sroa_idx, align 8
  %455 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %454
  %add.ptr1307.1.1 = getelementptr inbounds i8, ptr addrspace(4) %455, i64 1024
  %V_reg.sroa.74.16.copyload37554324 = load <4 x half>, ptr addrspace(4) %add.ptr1307.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1307.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %455, i64 1032
  %V_reg.sroa.114.16.copyload37764325 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1307.1.1.sroa_idx, align 8
  %cmp1317.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp1317.1, label %for.cond1319.preheader.1, label %if.end1343.1

for.cond1319.preheader.1:                         ; preds = %for.cond1292.preheader.1
  %add1326.1 = add nuw nsw i32 %mul11.6, %mul1033
  %cmp1329.not.12586 = icmp sgt i32 %add1326.1, %1
  %fneg.2128.12587 = select i1 %cmp1329.not.12586, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3038 = insertelement <4 x float> poison, float %fneg.2128.12587, i64 0
  %cmp1329.not.1.1.not = icmp slt i32 %add1326.1, %1
  %fneg.2128.1.1 = select i1 %cmp1329.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3221 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3038, float %fneg.2128.1.1, i64 1
  %add1327.2.1 = or disjoint i32 %add1326.1, 2
  %cmp1329.not.2.1 = icmp sgt i32 %add1327.2.1, %1
  %fneg.2128.2.1 = select i1 %cmp1329.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3394 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3221, float %fneg.2128.2.1, i64 2
  %add1327.3.1 = or disjoint i32 %add1326.1, 3
  %cmp1329.not.3.1 = icmp sgt i32 %add1327.3.1, %1
  %fneg.2128.3.1 = select i1 %cmp1329.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3567 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3394, float %fneg.2128.3.1, i64 3
  br label %if.end1343.1

if.end1343.1:                                     ; preds = %for.cond1292.preheader.1, %for.cond1319.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3567, %for.cond1319.preheader.1 ], [ zeroinitializer, %for.cond1292.preheader.1 ]
  %456 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %391, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !90
  %457 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %390, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %456), !call_argsrelate !90
  %458 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %389, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %457), !call_argsrelate !90
  %459 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %388, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %458), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3040 = extractelement <4 x float> %459, i64 0
  %mul1378.12591 = fmul contract float %acc_s.sroa.0.0.vec.extract3040, 0x3FB99999A0000000
  %460 = tail call contract noundef float @llvm.minnum.f32(float %mul1378.12591, float 0x4024CB5EC0000000)
  %461 = tail call contract noundef float @llvm.exp.f32(float %460)
  %acc_s.sroa.0.4.vec.extract3223 = extractelement <4 x float> %459, i64 1
  %mul1378.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3223, 0x3FB99999A0000000
  %462 = tail call contract noundef float @llvm.minnum.f32(float %mul1378.1.1, float 0x4024CB5EC0000000)
  %463 = tail call contract noundef float @llvm.exp.f32(float %462)
  %acc_s.sroa.0.8.vec.extract3396 = extractelement <4 x float> %459, i64 2
  %mul1378.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3396, 0x3FB99999A0000000
  %464 = tail call contract noundef float @llvm.minnum.f32(float %mul1378.2.1, float 0x4024CB5EC0000000)
  %465 = tail call contract noundef float @llvm.exp.f32(float %464)
  %acc_s.sroa.0.12.vec.extract3569 = extractelement <4 x float> %459, i64 3
  %mul1378.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3569, 0x3FB99999A0000000
  %466 = tail call contract noundef float @llvm.minnum.f32(float %mul1378.3.1, float 0x4024CB5EC0000000)
  %467 = tail call contract noundef float @llvm.exp.f32(float %466)
  %add1394.12592 = fadd contract float %sum_acc.sroa.0.5, %461
  %add1394.1.1 = fadd contract float %sum_acc.sroa.36.5, %463
  %add1394.2.1 = fadd contract float %sum_acc.sroa.70.5, %465
  %add1394.3.1 = fadd contract float %sum_acc.sroa.104.5, %467
  %468 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %461)
  %469 = insertelement <4 x i16> poison, i16 %468, i64 0
  %470 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %463)
  %471 = insertelement <4 x i16> %469, i16 %470, i64 1
  %472 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %465)
  %473 = insertelement <4 x i16> %471, i16 %472, i64 2
  %474 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %467)
  %475 = insertelement <4 x i16> %473, i16 %474, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2899 = bitcast <4 x i16> %475 to <4 x half>
  %476 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload36534322, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2899, <4 x float> %acc_o.sroa.0.3), !call_argsrelate !203
  %477 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload36744323, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2899, <4 x float> %acc_o.sroa.42.3), !call_argsrelate !203
  %478 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload37554324, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2899, <4 x float> %acc_o.sroa.82.3), !call_argsrelate !203
  %479 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload37764325, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2899, <4 x float> %acc_o.sroa.122.3), !call_argsrelate !203
  br label %if.end1430.1

if.end1430.1:                                     ; preds = %if.end1343.1, %if.end1284.1
  %acc_o.sroa.122.4 = phi <4 x float> [ %acc_o.sroa.122.3, %if.end1284.1 ], [ %479, %if.end1343.1 ]
  %acc_o.sroa.82.4 = phi <4 x float> [ %acc_o.sroa.82.3, %if.end1284.1 ], [ %478, %if.end1343.1 ]
  %acc_o.sroa.42.4 = phi <4 x float> [ %acc_o.sroa.42.3, %if.end1284.1 ], [ %477, %if.end1343.1 ]
  %acc_o.sroa.0.4 = phi <4 x float> [ %acc_o.sroa.0.3, %if.end1284.1 ], [ %476, %if.end1343.1 ]
  %sum_acc.sroa.104.6 = phi float [ %sum_acc.sroa.104.5, %if.end1284.1 ], [ %add1394.3.1, %if.end1343.1 ]
  %sum_acc.sroa.70.6 = phi float [ %sum_acc.sroa.70.5, %if.end1284.1 ], [ %add1394.2.1, %if.end1343.1 ]
  %sum_acc.sroa.36.6 = phi float [ %sum_acc.sroa.36.5, %if.end1284.1 ], [ %add1394.1.1, %if.end1343.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end1284.1 ], [ %add1394.12592, %if.end1343.1 ]
  br i1 %or.cond2463.1, label %if.end1577.1, label %for.cond1438.preheader.1

for.cond1438.preheader.1:                         ; preds = %if.end1430.1
  %480 = shl nsw i32 %cond.i.i2262.7, 10
  %mul1445.1 = and i32 %480, 64512
  %add1448.1 = add nuw nsw i32 %add884, %mul1445.1
  %481 = zext nneg i32 %add1448.1 to i64
  %add.ptr1453.12593 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %481
  %V_reg.sroa.0.0.copyload36544326 = load <4 x half>, ptr addrspace(4) %add.ptr1453.12593, align 16
  %V_reg.sroa.42.0.add.ptr1453.12593.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1453.12593, i64 8
  %V_reg.sroa.42.0.copyload36754327 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1453.12593.sroa_idx, align 8
  %482 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %481
  %add.ptr1453.1.1 = getelementptr inbounds i8, ptr addrspace(4) %482, i64 1024
  %V_reg.sroa.74.16.copyload37564328 = load <4 x half>, ptr addrspace(4) %add.ptr1453.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1453.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %482, i64 1032
  %V_reg.sroa.114.16.copyload37774329 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1453.1.1.sroa_idx, align 8
  %cmp1463.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp1463.1, label %for.cond1465.preheader.1, label %if.end1489.1

for.cond1465.preheader.1:                         ; preds = %for.cond1438.preheader.1
  %add1472.1 = add nuw nsw i32 %mul11.7, %mul1033
  %cmp1475.not.12594 = icmp sgt i32 %add1472.1, %1
  %fneg.2129.12595 = select i1 %cmp1475.not.12594, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3050 = insertelement <4 x float> poison, float %fneg.2129.12595, i64 0
  %cmp1475.not.1.1.not = icmp slt i32 %add1472.1, %1
  %fneg.2129.1.1 = select i1 %cmp1475.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3231 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3050, float %fneg.2129.1.1, i64 1
  %add1473.2.1 = or disjoint i32 %add1472.1, 2
  %cmp1475.not.2.1 = icmp sgt i32 %add1473.2.1, %1
  %fneg.2129.2.1 = select i1 %cmp1475.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3404 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3231, float %fneg.2129.2.1, i64 2
  %add1473.3.1 = or disjoint i32 %add1472.1, 3
  %cmp1475.not.3.1 = icmp sgt i32 %add1473.3.1, %1
  %fneg.2129.3.1 = select i1 %cmp1475.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3577 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3404, float %fneg.2129.3.1, i64 3
  br label %if.end1489.1

if.end1489.1:                                     ; preds = %for.cond1438.preheader.1, %for.cond1465.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3577, %for.cond1465.preheader.1 ], [ zeroinitializer, %for.cond1438.preheader.1 ]
  %483 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %398, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !90
  %484 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %397, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %483), !call_argsrelate !90
  %485 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %396, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %484), !call_argsrelate !90
  %486 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %395, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %485), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3052 = extractelement <4 x float> %486, i64 0
  %mul1524.12599 = fmul contract float %acc_s.sroa.0.0.vec.extract3052, 0x3FB99999A0000000
  %487 = tail call contract noundef float @llvm.minnum.f32(float %mul1524.12599, float 0x4024CB5EC0000000)
  %488 = tail call contract noundef float @llvm.exp.f32(float %487)
  %acc_s.sroa.0.4.vec.extract3233 = extractelement <4 x float> %486, i64 1
  %mul1524.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3233, 0x3FB99999A0000000
  %489 = tail call contract noundef float @llvm.minnum.f32(float %mul1524.1.1, float 0x4024CB5EC0000000)
  %490 = tail call contract noundef float @llvm.exp.f32(float %489)
  %acc_s.sroa.0.8.vec.extract3406 = extractelement <4 x float> %486, i64 2
  %mul1524.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3406, 0x3FB99999A0000000
  %491 = tail call contract noundef float @llvm.minnum.f32(float %mul1524.2.1, float 0x4024CB5EC0000000)
  %492 = tail call contract noundef float @llvm.exp.f32(float %491)
  %acc_s.sroa.0.12.vec.extract3579 = extractelement <4 x float> %486, i64 3
  %mul1524.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3579, 0x3FB99999A0000000
  %493 = tail call contract noundef float @llvm.minnum.f32(float %mul1524.3.1, float 0x4024CB5EC0000000)
  %494 = tail call contract noundef float @llvm.exp.f32(float %493)
  %add1540.12600 = fadd contract float %sum_acc.sroa.0.6, %488
  %add1540.1.1 = fadd contract float %sum_acc.sroa.36.6, %490
  %add1540.2.1 = fadd contract float %sum_acc.sroa.70.6, %492
  %add1540.3.1 = fadd contract float %sum_acc.sroa.104.6, %494
  %495 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %488)
  %496 = insertelement <4 x i16> poison, i16 %495, i64 0
  %497 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %490)
  %498 = insertelement <4 x i16> %496, i16 %497, i64 1
  %499 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %492)
  %500 = insertelement <4 x i16> %498, i16 %499, i64 2
  %501 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %494)
  %502 = insertelement <4 x i16> %500, i16 %501, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2901 = bitcast <4 x i16> %502 to <4 x half>
  %503 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload36544326, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2901, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !203
  %504 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload36754327, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2901, <4 x float> %acc_o_alt.sroa.26.2), !call_argsrelate !203
  %505 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload37564328, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2901, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !203
  %506 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload37774329, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2901, <4 x float> %acc_o_alt.sroa.74.2), !call_argsrelate !203
  br label %if.end1577.1

for.cond98.preheader.1:                           ; preds = %if.end1577
  %cmp102.1 = icmp sgt i32 %11, -1
  %507 = and i32 %cond.i.i2262.4, 268435455
  %shr107.1 = zext nneg i32 %507 to i64
  br i1 %cmp102.1, label %if.then103.12610, label %if.end.12618

if.then103.12610:                                 ; preds = %for.cond98.preheader.1
  %.idx.12601 = shl nuw nsw i64 %shr107.1, 11
  %508 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.12601
  %.idx2472.12602 = shl nuw nsw i64 %conv, 17
  %509 = getelementptr inbounds i8, ptr addrspace(4) %508, i64 %.idx2472.12602
  %510 = load <4 x half>, ptr addrspace(4) %509, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr117.sroa_idx.12606 = getelementptr inbounds i8, ptr addrspace(4) %509, i64 8
  %511 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr117.sroa_idx.12606, align 8, !tbaa !30
  br label %if.end.12618

if.end.12618:                                     ; preds = %if.then103.12610, %for.cond98.preheader.1
  %512 = phi <4 x half> [ %511, %if.then103.12610 ], [ zeroinitializer, %for.cond98.preheader.1 ]
  %513 = phi <4 x half> [ %510, %if.then103.12610 ], [ zeroinitializer, %for.cond98.preheader.1 ]
  br i1 %cmp102.1, label %if.then103.1.1, label %if.end.1.1

if.then103.1.1:                                   ; preds = %if.end.12618
  %.idx.1.1 = shl nuw nsw i64 %shr107.1, 11
  %514 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1.1
  %.idx2472.1.1 = shl nuw nsw i64 %conv, 17
  %515 = getelementptr inbounds i8, ptr addrspace(4) %514, i64 %.idx2472.1.1
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %515, i64 1024
  %516 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr117.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %515, i64 1032
  %517 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr117.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end.1.1

if.end.1.1:                                       ; preds = %if.then103.1.1, %if.end.12618
  %518 = phi <4 x half> [ %517, %if.then103.1.1 ], [ zeroinitializer, %if.end.12618 ]
  %519 = phi <4 x half> [ %516, %if.then103.1.1 ], [ zeroinitializer, %if.end.12618 ]
  %cmp149.1 = icmp sgt i32 %13, -1
  %520 = and i32 %cond.i.i2262.5, 268435455
  %shr155.1 = zext nneg i32 %520 to i64
  br i1 %cmp149.1, label %if.then150.12628, label %if.end189.12636

if.then150.12628:                                 ; preds = %if.end.1.1
  %.idx2473.12619 = shl nuw nsw i64 %shr155.1, 11
  %521 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2473.12619
  %.idx2474.12620 = shl nuw nsw i64 %conv, 17
  %522 = getelementptr inbounds i8, ptr addrspace(4) %521, i64 %.idx2474.12620
  %523 = load <4 x half>, ptr addrspace(4) %522, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr165.sroa_idx.12624 = getelementptr inbounds i8, ptr addrspace(4) %522, i64 8
  %524 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr165.sroa_idx.12624, align 8, !tbaa !30
  br label %if.end189.12636

if.end189.12636:                                  ; preds = %if.then150.12628, %if.end.1.1
  %525 = phi <4 x half> [ %524, %if.then150.12628 ], [ zeroinitializer, %if.end.1.1 ]
  %526 = phi <4 x half> [ %523, %if.then150.12628 ], [ zeroinitializer, %if.end.1.1 ]
  br i1 %cmp149.1, label %if.then150.1.1, label %if.end189.1.1

if.then150.1.1:                                   ; preds = %if.end189.12636
  %.idx2473.1.1 = shl nuw nsw i64 %shr155.1, 11
  %527 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2473.1.1
  %.idx2474.1.1 = shl nuw nsw i64 %conv, 17
  %528 = getelementptr inbounds i8, ptr addrspace(4) %527, i64 %.idx2474.1.1
  %gep2382.1.1 = getelementptr inbounds i8, ptr addrspace(4) %528, i64 1024
  %529 = load <4 x half>, ptr addrspace(4) %gep2382.1.1, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr165.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %528, i64 1032
  %530 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr165.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end189.1.1

if.end189.1.1:                                    ; preds = %if.then150.1.1, %if.end189.12636
  %531 = phi <4 x half> [ %530, %if.then150.1.1 ], [ zeroinitializer, %if.end189.12636 ]
  %532 = phi <4 x half> [ %529, %if.then150.1.1 ], [ zeroinitializer, %if.end189.12636 ]
  %cmp201.1 = icmp sgt i32 %15, -1
  %533 = and i32 %cond.i.i2262.6, 268435455
  %shr207.1 = zext nneg i32 %533 to i64
  br i1 %cmp201.1, label %if.then202.12646, label %if.end241.12654

if.then202.12646:                                 ; preds = %if.end189.1.1
  %.idx2475.12637 = shl nuw nsw i64 %shr207.1, 11
  %534 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2475.12637
  %.idx2476.12638 = shl nuw nsw i64 %conv, 17
  %535 = getelementptr inbounds i8, ptr addrspace(4) %534, i64 %.idx2476.12638
  %536 = load <4 x half>, ptr addrspace(4) %535, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr217.sroa_idx.12642 = getelementptr inbounds i8, ptr addrspace(4) %535, i64 8
  %537 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr217.sroa_idx.12642, align 8, !tbaa !30
  br label %if.end241.12654

if.end241.12654:                                  ; preds = %if.then202.12646, %if.end189.1.1
  %538 = phi <4 x half> [ %537, %if.then202.12646 ], [ zeroinitializer, %if.end189.1.1 ]
  %539 = phi <4 x half> [ %536, %if.then202.12646 ], [ zeroinitializer, %if.end189.1.1 ]
  br i1 %cmp201.1, label %if.then202.1.1, label %if.end241.1.1

if.then202.1.1:                                   ; preds = %if.end241.12654
  %.idx2475.1.1 = shl nuw nsw i64 %shr207.1, 11
  %540 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2475.1.1
  %.idx2476.1.1 = shl nuw nsw i64 %conv, 17
  %541 = getelementptr inbounds i8, ptr addrspace(4) %540, i64 %.idx2476.1.1
  %gep2385.1.1 = getelementptr inbounds i8, ptr addrspace(4) %541, i64 1024
  %542 = load <4 x half>, ptr addrspace(4) %gep2385.1.1, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr217.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %541, i64 1032
  %543 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr217.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end241.1.1

if.end241.1.1:                                    ; preds = %if.then202.1.1, %if.end241.12654
  %544 = phi <4 x half> [ %543, %if.then202.1.1 ], [ zeroinitializer, %if.end241.12654 ]
  %545 = phi <4 x half> [ %542, %if.then202.1.1 ], [ zeroinitializer, %if.end241.12654 ]
  %cmp253.1 = icmp sgt i32 %17, -1
  %546 = and i32 %cond.i.i2262.7, 268435455
  %shr259.1 = zext nneg i32 %546 to i64
  br i1 %cmp253.1, label %if.then254.12664, label %if.end293.12672

if.then254.12664:                                 ; preds = %if.end241.1.1
  %.idx2477.12655 = shl nuw nsw i64 %shr259.1, 11
  %547 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2477.12655
  %.idx2478.12656 = shl nuw nsw i64 %conv, 17
  %548 = getelementptr inbounds i8, ptr addrspace(4) %547, i64 %.idx2478.12656
  %549 = load <4 x half>, ptr addrspace(4) %548, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr269.sroa_idx.12660 = getelementptr inbounds i8, ptr addrspace(4) %548, i64 8
  %550 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr269.sroa_idx.12660, align 8, !tbaa !30
  br label %if.end293.12672

if.end293.12672:                                  ; preds = %if.then254.12664, %if.end241.1.1
  %551 = phi <4 x half> [ %550, %if.then254.12664 ], [ zeroinitializer, %if.end241.1.1 ]
  %552 = phi <4 x half> [ %549, %if.then254.12664 ], [ zeroinitializer, %if.end241.1.1 ]
  br i1 %cmp253.1, label %if.then254.1.1, label %if.end293.1.1

if.then254.1.1:                                   ; preds = %if.end293.12672
  %.idx2477.1.1 = shl nuw nsw i64 %shr259.1, 11
  %553 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2477.1.1
  %.idx2478.1.1 = shl nuw nsw i64 %conv, 17
  %554 = getelementptr inbounds i8, ptr addrspace(4) %553, i64 %.idx2478.1.1
  %gep2388.1.1 = getelementptr inbounds i8, ptr addrspace(4) %554, i64 1024
  %555 = load <4 x half>, ptr addrspace(4) %gep2388.1.1, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr269.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %554, i64 1032
  %556 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr269.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end293.1.1

if.end293.1.1:                                    ; preds = %if.then254.1.1, %if.end293.12672
  %557 = phi <4 x half> [ %556, %if.then254.1.1 ], [ zeroinitializer, %if.end293.12672 ]
  %558 = phi <4 x half> [ %555, %if.then254.1.1 ], [ zeroinitializer, %if.end293.12672 ]
  br i1 %cmp102.1, label %if.then306.12682, label %if.end345.12690

if.then306.12682:                                 ; preds = %if.end293.1.1
  %.idx2479.12673 = shl nuw nsw i64 %shr107.1, 11
  %559 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2479.12673
  %.idx2480.12674 = shl nuw nsw i64 %conv, 17
  %560 = getelementptr inbounds i8, ptr addrspace(4) %559, i64 %.idx2480.12674
  %561 = load <4 x half>, ptr addrspace(4) %560, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr321.sroa_idx.12678 = getelementptr inbounds i8, ptr addrspace(4) %560, i64 8
  %562 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr321.sroa_idx.12678, align 8, !tbaa !30
  br label %if.end345.12690

if.end345.12690:                                  ; preds = %if.then306.12682, %if.end293.1.1
  %563 = phi <4 x half> [ %562, %if.then306.12682 ], [ zeroinitializer, %if.end293.1.1 ]
  %564 = phi <4 x half> [ %561, %if.then306.12682 ], [ zeroinitializer, %if.end293.1.1 ]
  br i1 %cmp102.1, label %if.then306.1.1, label %if.end345.1.1

if.then306.1.1:                                   ; preds = %if.end345.12690
  %.idx2479.1.1 = shl nuw nsw i64 %shr107.1, 11
  %565 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2479.1.1
  %.idx2480.1.1 = shl nuw nsw i64 %conv, 17
  %566 = getelementptr inbounds i8, ptr addrspace(4) %565, i64 %.idx2480.1.1
  %gep2391.1.1 = getelementptr inbounds i8, ptr addrspace(4) %566, i64 1024
  %567 = load <4 x half>, ptr addrspace(4) %gep2391.1.1, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr321.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %566, i64 1032
  %568 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr321.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end345.1.1

if.end345.1.1:                                    ; preds = %if.then306.1.1, %if.end345.12690
  %569 = phi <4 x half> [ %568, %if.then306.1.1 ], [ zeroinitializer, %if.end345.12690 ]
  %570 = phi <4 x half> [ %567, %if.then306.1.1 ], [ zeroinitializer, %if.end345.12690 ]
  %571 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %513, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %572 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %512, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %571), !call_argsrelate !90
  %573 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %519, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %572), !call_argsrelate !90
  %574 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %518, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %573), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3062 = extractelement <4 x float> %574, i64 0
  %mul391.12694 = fmul contract float %acc_s.sroa.0.0.vec.extract3062, 0x3FB99999A0000000
  %575 = tail call contract noundef float @llvm.minnum.f32(float %mul391.12694, float 0x4024CB5EC0000000)
  %576 = tail call contract noundef float @llvm.exp.f32(float %575)
  %acc_s.sroa.0.4.vec.extract3241 = extractelement <4 x float> %574, i64 1
  %mul391.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3241, 0x3FB99999A0000000
  %577 = tail call contract noundef float @llvm.minnum.f32(float %mul391.1.1, float 0x4024CB5EC0000000)
  %578 = tail call contract noundef float @llvm.exp.f32(float %577)
  %acc_s.sroa.0.8.vec.extract3414 = extractelement <4 x float> %574, i64 2
  %mul391.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3414, 0x3FB99999A0000000
  %579 = tail call contract noundef float @llvm.minnum.f32(float %mul391.2.1, float 0x4024CB5EC0000000)
  %580 = tail call contract noundef float @llvm.exp.f32(float %579)
  %acc_s.sroa.0.12.vec.extract3587 = extractelement <4 x float> %574, i64 3
  %mul391.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3587, 0x3FB99999A0000000
  %581 = tail call contract noundef float @llvm.minnum.f32(float %mul391.3.1, float 0x4024CB5EC0000000)
  %582 = tail call contract noundef float @llvm.exp.f32(float %581)
  %add407.12695 = fadd contract float %sum_acc.sroa.0.3, %576
  %add407.1.1 = fadd contract float %sum_acc.sroa.36.3, %578
  %add407.2.1 = fadd contract float %sum_acc.sroa.70.3, %580
  %add407.3.1 = fadd contract float %sum_acc.sroa.104.3, %582
  %583 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %576)
  %584 = insertelement <4 x i16> poison, i16 %583, i64 0
  %585 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %578)
  %586 = insertelement <4 x i16> %584, i16 %585, i64 1
  %587 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %580)
  %588 = insertelement <4 x i16> %586, i16 %587, i64 2
  %589 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %582)
  %590 = insertelement <4 x i16> %588, i16 %589, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2903 = bitcast <4 x i16> %590 to <4 x half>
  %591 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %564, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2903, <4 x float> %acc_o.sroa.0.2)
  %592 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %563, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2903, <4 x float> %acc_o.sroa.42.2)
  %593 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %570, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2903, <4 x float> %acc_o.sroa.82.2)
  %594 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %569, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2903, <4 x float> %acc_o.sroa.122.2)
  br i1 %cmp149.1, label %if.then448.12705, label %if.end487.12713

if.then448.12705:                                 ; preds = %if.end345.1.1
  %.idx2481.12696 = shl nuw nsw i64 %shr155.1, 11
  %595 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2481.12696
  %.idx2482.12697 = shl nuw nsw i64 %conv, 17
  %596 = getelementptr inbounds i8, ptr addrspace(4) %595, i64 %.idx2482.12697
  %597 = load <4 x half>, ptr addrspace(4) %596, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr463.sroa_idx.12701 = getelementptr inbounds i8, ptr addrspace(4) %596, i64 8
  %598 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr463.sroa_idx.12701, align 8, !tbaa !30
  br label %if.end487.12713

if.end487.12713:                                  ; preds = %if.then448.12705, %if.end345.1.1
  %599 = phi <4 x half> [ %598, %if.then448.12705 ], [ zeroinitializer, %if.end345.1.1 ]
  %600 = phi <4 x half> [ %597, %if.then448.12705 ], [ zeroinitializer, %if.end345.1.1 ]
  br i1 %cmp149.1, label %if.then448.1.1, label %if.end487.1.1

if.then448.1.1:                                   ; preds = %if.end487.12713
  %.idx2481.1.1 = shl nuw nsw i64 %shr155.1, 11
  %601 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2481.1.1
  %.idx2482.1.1 = shl nuw nsw i64 %conv, 17
  %602 = getelementptr inbounds i8, ptr addrspace(4) %601, i64 %.idx2482.1.1
  %gep2404.1.1 = getelementptr inbounds i8, ptr addrspace(4) %602, i64 1024
  %603 = load <4 x half>, ptr addrspace(4) %gep2404.1.1, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr463.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %602, i64 1032
  %604 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr463.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end487.1.1

if.end487.1.1:                                    ; preds = %if.then448.1.1, %if.end487.12713
  %605 = phi <4 x half> [ %604, %if.then448.1.1 ], [ zeroinitializer, %if.end487.12713 ]
  %606 = phi <4 x half> [ %603, %if.then448.1.1 ], [ zeroinitializer, %if.end487.12713 ]
  %607 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %526, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %608 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %525, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %607), !call_argsrelate !90
  %609 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %532, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %608), !call_argsrelate !90
  %610 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %531, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %609), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3072 = extractelement <4 x float> %610, i64 0
  %mul533.12717 = fmul contract float %acc_s.sroa.0.0.vec.extract3072, 0x3FB99999A0000000
  %611 = tail call contract noundef float @llvm.minnum.f32(float %mul533.12717, float 0x4024CB5EC0000000)
  %612 = tail call contract noundef float @llvm.exp.f32(float %611)
  %acc_s.sroa.0.4.vec.extract3249 = extractelement <4 x float> %610, i64 1
  %mul533.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3249, 0x3FB99999A0000000
  %613 = tail call contract noundef float @llvm.minnum.f32(float %mul533.1.1, float 0x4024CB5EC0000000)
  %614 = tail call contract noundef float @llvm.exp.f32(float %613)
  %acc_s.sroa.0.8.vec.extract3422 = extractelement <4 x float> %610, i64 2
  %mul533.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3422, 0x3FB99999A0000000
  %615 = tail call contract noundef float @llvm.minnum.f32(float %mul533.2.1, float 0x4024CB5EC0000000)
  %616 = tail call contract noundef float @llvm.exp.f32(float %615)
  %acc_s.sroa.0.12.vec.extract3595 = extractelement <4 x float> %610, i64 3
  %mul533.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3595, 0x3FB99999A0000000
  %617 = tail call contract noundef float @llvm.minnum.f32(float %mul533.3.1, float 0x4024CB5EC0000000)
  %618 = tail call contract noundef float @llvm.exp.f32(float %617)
  %add549.12718 = fadd contract float %add407.12695, %612
  %add549.1.1 = fadd contract float %add407.1.1, %614
  %add549.2.1 = fadd contract float %add407.2.1, %616
  %add549.3.1 = fadd contract float %add407.3.1, %618
  %619 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %612)
  %620 = insertelement <4 x i16> poison, i16 %619, i64 0
  %621 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %614)
  %622 = insertelement <4 x i16> %620, i16 %621, i64 1
  %623 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %616)
  %624 = insertelement <4 x i16> %622, i16 %623, i64 2
  %625 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %618)
  %626 = insertelement <4 x i16> %624, i16 %625, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2905 = bitcast <4 x i16> %626 to <4 x half>
  %627 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %600, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2905, <4 x float> %acc_o_alt.sroa.0.1)
  %628 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %599, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2905, <4 x float> %acc_o_alt.sroa.26.1)
  %629 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %606, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2905, <4 x float> %acc_o_alt.sroa.50.1)
  %630 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %605, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2905, <4 x float> %acc_o_alt.sroa.74.1)
  br i1 %cmp201.1, label %if.then590.12728, label %if.end629.12736

if.then590.12728:                                 ; preds = %if.end487.1.1
  %.idx2483.12719 = shl nuw nsw i64 %shr207.1, 11
  %631 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2483.12719
  %.idx2484.12720 = shl nuw nsw i64 %conv, 17
  %632 = getelementptr inbounds i8, ptr addrspace(4) %631, i64 %.idx2484.12720
  %633 = load <4 x half>, ptr addrspace(4) %632, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr605.sroa_idx.12724 = getelementptr inbounds i8, ptr addrspace(4) %632, i64 8
  %634 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr605.sroa_idx.12724, align 8, !tbaa !30
  br label %if.end629.12736

if.end629.12736:                                  ; preds = %if.then590.12728, %if.end487.1.1
  %635 = phi <4 x half> [ %634, %if.then590.12728 ], [ zeroinitializer, %if.end487.1.1 ]
  %636 = phi <4 x half> [ %633, %if.then590.12728 ], [ zeroinitializer, %if.end487.1.1 ]
  br i1 %cmp201.1, label %if.then590.1.1, label %if.end629.1.1

if.then590.1.1:                                   ; preds = %if.end629.12736
  %.idx2483.1.1 = shl nuw nsw i64 %shr207.1, 11
  %637 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2483.1.1
  %.idx2484.1.1 = shl nuw nsw i64 %conv, 17
  %638 = getelementptr inbounds i8, ptr addrspace(4) %637, i64 %.idx2484.1.1
  %gep2417.1.1 = getelementptr inbounds i8, ptr addrspace(4) %638, i64 1024
  %639 = load <4 x half>, ptr addrspace(4) %gep2417.1.1, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr605.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %638, i64 1032
  %640 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr605.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end629.1.1

if.end629.1.1:                                    ; preds = %if.then590.1.1, %if.end629.12736
  %641 = phi <4 x half> [ %640, %if.then590.1.1 ], [ zeroinitializer, %if.end629.12736 ]
  %642 = phi <4 x half> [ %639, %if.then590.1.1 ], [ zeroinitializer, %if.end629.12736 ]
  %643 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %539, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %644 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %538, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %643), !call_argsrelate !90
  %645 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %545, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %644), !call_argsrelate !90
  %646 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %544, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %645), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3082 = extractelement <4 x float> %646, i64 0
  %mul675.12740 = fmul contract float %acc_s.sroa.0.0.vec.extract3082, 0x3FB99999A0000000
  %647 = tail call contract noundef float @llvm.minnum.f32(float %mul675.12740, float 0x4024CB5EC0000000)
  %648 = tail call contract noundef float @llvm.exp.f32(float %647)
  %acc_s.sroa.0.4.vec.extract3257 = extractelement <4 x float> %646, i64 1
  %mul675.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3257, 0x3FB99999A0000000
  %649 = tail call contract noundef float @llvm.minnum.f32(float %mul675.1.1, float 0x4024CB5EC0000000)
  %650 = tail call contract noundef float @llvm.exp.f32(float %649)
  %acc_s.sroa.0.8.vec.extract3430 = extractelement <4 x float> %646, i64 2
  %mul675.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3430, 0x3FB99999A0000000
  %651 = tail call contract noundef float @llvm.minnum.f32(float %mul675.2.1, float 0x4024CB5EC0000000)
  %652 = tail call contract noundef float @llvm.exp.f32(float %651)
  %acc_s.sroa.0.12.vec.extract3603 = extractelement <4 x float> %646, i64 3
  %mul675.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3603, 0x3FB99999A0000000
  %653 = tail call contract noundef float @llvm.minnum.f32(float %mul675.3.1, float 0x4024CB5EC0000000)
  %654 = tail call contract noundef float @llvm.exp.f32(float %653)
  %add691.12741 = fadd contract float %add549.12718, %648
  %add691.1.1 = fadd contract float %add549.1.1, %650
  %add691.2.1 = fadd contract float %add549.2.1, %652
  %add691.3.1 = fadd contract float %add549.3.1, %654
  %655 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %648)
  %656 = insertelement <4 x i16> poison, i16 %655, i64 0
  %657 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %650)
  %658 = insertelement <4 x i16> %656, i16 %657, i64 1
  %659 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %652)
  %660 = insertelement <4 x i16> %658, i16 %659, i64 2
  %661 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %654)
  %662 = insertelement <4 x i16> %660, i16 %661, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2907 = bitcast <4 x i16> %662 to <4 x half>
  %663 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %636, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2907, <4 x float> %591)
  %664 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %635, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2907, <4 x float> %592)
  %665 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %642, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2907, <4 x float> %593)
  %666 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %641, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2907, <4 x float> %594)
  br i1 %cmp253.1, label %if.then732.12751, label %if.end771.12759

if.then732.12751:                                 ; preds = %if.end629.1.1
  %.idx2485.12742 = shl nuw nsw i64 %shr259.1, 11
  %667 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2485.12742
  %.idx2486.12743 = shl nuw nsw i64 %conv, 17
  %668 = getelementptr inbounds i8, ptr addrspace(4) %667, i64 %.idx2486.12743
  %669 = load <4 x half>, ptr addrspace(4) %668, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr747.sroa_idx.12747 = getelementptr inbounds i8, ptr addrspace(4) %668, i64 8
  %670 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr747.sroa_idx.12747, align 8, !tbaa !30
  br label %if.end771.12759

if.end771.12759:                                  ; preds = %if.then732.12751, %if.end629.1.1
  %671 = phi <4 x half> [ %670, %if.then732.12751 ], [ zeroinitializer, %if.end629.1.1 ]
  %672 = phi <4 x half> [ %669, %if.then732.12751 ], [ zeroinitializer, %if.end629.1.1 ]
  br i1 %cmp253.1, label %if.then732.1.1, label %if.end771.1.1

if.then732.1.1:                                   ; preds = %if.end771.12759
  %.idx2485.1.1 = shl nuw nsw i64 %shr259.1, 11
  %673 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2390, i64 %.idx2485.1.1
  %.idx2486.1.1 = shl nuw nsw i64 %conv, 17
  %674 = getelementptr inbounds i8, ptr addrspace(4) %673, i64 %.idx2486.1.1
  %gep2430.1.1 = getelementptr inbounds i8, ptr addrspace(4) %674, i64 1024
  %675 = load <4 x half>, ptr addrspace(4) %gep2430.1.1, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr747.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %674, i64 1032
  %676 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr747.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end771.1.1

if.end771.1.1:                                    ; preds = %if.then732.1.1, %if.end771.12759
  %677 = phi <4 x half> [ %676, %if.then732.1.1 ], [ zeroinitializer, %if.end771.12759 ]
  %678 = phi <4 x half> [ %675, %if.then732.1.1 ], [ zeroinitializer, %if.end771.12759 ]
  %679 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %552, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !90
  %680 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %551, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %679), !call_argsrelate !90
  %681 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %558, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %680), !call_argsrelate !90
  %682 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %557, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %681), !call_argsrelate !90
  %acc_s.sroa.0.0.vec.extract3092 = extractelement <4 x float> %682, i64 0
  %mul817.12763 = fmul contract float %acc_s.sroa.0.0.vec.extract3092, 0x3FB99999A0000000
  %683 = tail call contract noundef float @llvm.minnum.f32(float %mul817.12763, float 0x4024CB5EC0000000)
  %684 = tail call contract noundef float @llvm.exp.f32(float %683)
  %acc_s.sroa.0.4.vec.extract3265 = extractelement <4 x float> %682, i64 1
  %mul817.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3265, 0x3FB99999A0000000
  %685 = tail call contract noundef float @llvm.minnum.f32(float %mul817.1.1, float 0x4024CB5EC0000000)
  %686 = tail call contract noundef float @llvm.exp.f32(float %685)
  %acc_s.sroa.0.8.vec.extract3438 = extractelement <4 x float> %682, i64 2
  %mul817.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3438, 0x3FB99999A0000000
  %687 = tail call contract noundef float @llvm.minnum.f32(float %mul817.2.1, float 0x4024CB5EC0000000)
  %688 = tail call contract noundef float @llvm.exp.f32(float %687)
  %acc_s.sroa.0.12.vec.extract3611 = extractelement <4 x float> %682, i64 3
  %mul817.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3611, 0x3FB99999A0000000
  %689 = tail call contract noundef float @llvm.minnum.f32(float %mul817.3.1, float 0x4024CB5EC0000000)
  %690 = tail call contract noundef float @llvm.exp.f32(float %689)
  %add833.12764 = fadd contract float %add691.12741, %684
  %add833.1.1 = fadd contract float %add691.1.1, %686
  %add833.2.1 = fadd contract float %add691.2.1, %688
  %add833.3.1 = fadd contract float %add691.3.1, %690
  %691 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %684)
  %692 = insertelement <4 x i16> poison, i16 %691, i64 0
  %693 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %686)
  %694 = insertelement <4 x i16> %692, i16 %693, i64 1
  %695 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %688)
  %696 = insertelement <4 x i16> %694, i16 %695, i64 2
  %697 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %690)
  %698 = insertelement <4 x i16> %696, i16 %697, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2909 = bitcast <4 x i16> %698 to <4 x half>
  %699 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %672, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2909, <4 x float> %627)
  %700 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %671, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2909, <4 x float> %628)
  %701 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %678, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2909, <4 x float> %629)
  %702 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %677, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2909, <4 x float> %630)
  br label %if.end1577.1

if.end1577.1:                                     ; preds = %if.end771.1.1, %if.end1489.1, %if.end1430.1
  %acc_o.sroa.122.5 = phi <4 x float> [ %666, %if.end771.1.1 ], [ %acc_o.sroa.122.4, %if.end1430.1 ], [ %acc_o.sroa.122.4, %if.end1489.1 ]
  %acc_o.sroa.82.5 = phi <4 x float> [ %665, %if.end771.1.1 ], [ %acc_o.sroa.82.4, %if.end1430.1 ], [ %acc_o.sroa.82.4, %if.end1489.1 ]
  %acc_o.sroa.42.5 = phi <4 x float> [ %664, %if.end771.1.1 ], [ %acc_o.sroa.42.4, %if.end1430.1 ], [ %acc_o.sroa.42.4, %if.end1489.1 ]
  %acc_o.sroa.0.5 = phi <4 x float> [ %663, %if.end771.1.1 ], [ %acc_o.sroa.0.4, %if.end1430.1 ], [ %acc_o.sroa.0.4, %if.end1489.1 ]
  %acc_o_alt.sroa.74.3 = phi <4 x float> [ %702, %if.end771.1.1 ], [ %acc_o_alt.sroa.74.2, %if.end1430.1 ], [ %506, %if.end1489.1 ]
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %701, %if.end771.1.1 ], [ %acc_o_alt.sroa.50.2, %if.end1430.1 ], [ %505, %if.end1489.1 ]
  %acc_o_alt.sroa.26.3 = phi <4 x float> [ %700, %if.end771.1.1 ], [ %acc_o_alt.sroa.26.2, %if.end1430.1 ], [ %504, %if.end1489.1 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %699, %if.end771.1.1 ], [ %acc_o_alt.sroa.0.2, %if.end1430.1 ], [ %503, %if.end1489.1 ]
  %sum_acc.sroa.104.7 = phi float [ %add833.3.1, %if.end771.1.1 ], [ %sum_acc.sroa.104.6, %if.end1430.1 ], [ %add1540.3.1, %if.end1489.1 ]
  %sum_acc.sroa.70.7 = phi float [ %add833.2.1, %if.end771.1.1 ], [ %sum_acc.sroa.70.6, %if.end1430.1 ], [ %add1540.2.1, %if.end1489.1 ]
  %sum_acc.sroa.36.7 = phi float [ %add833.1.1, %if.end771.1.1 ], [ %sum_acc.sroa.36.6, %if.end1430.1 ], [ %add1540.1.1, %if.end1489.1 ]
  %sum_acc.sroa.0.7 = phi float [ %add833.12764, %if.end771.1.1 ], [ %sum_acc.sroa.0.6, %if.end1430.1 ], [ %add1540.12600, %if.end1489.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add1589 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add1589.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add1589.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add1589.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.42.16.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 0
  %acc_o_alt.sroa.26.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 0
  %add1589.4 = fadd contract float %acc_o.sroa.42.16.vec.extract, %acc_o_alt.sroa.26.16.vec.extract
  %acc_o.sroa.42.20.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 1
  %acc_o_alt.sroa.26.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 1
  %add1589.5 = fadd contract float %acc_o.sroa.42.20.vec.extract, %acc_o_alt.sroa.26.20.vec.extract
  %acc_o.sroa.42.24.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 2
  %acc_o_alt.sroa.26.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 2
  %add1589.6 = fadd contract float %acc_o.sroa.42.24.vec.extract, %acc_o_alt.sroa.26.24.vec.extract
  %acc_o.sroa.42.28.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 3
  %acc_o_alt.sroa.26.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 3
  %add1589.7 = fadd contract float %acc_o.sroa.42.28.vec.extract, %acc_o_alt.sroa.26.28.vec.extract
  %acc_o.sroa.82.32.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 0
  %acc_o_alt.sroa.50.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add1589.8 = fadd contract float %acc_o.sroa.82.32.vec.extract, %acc_o_alt.sroa.50.32.vec.extract
  %acc_o.sroa.82.36.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 1
  %acc_o_alt.sroa.50.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add1589.9 = fadd contract float %acc_o.sroa.82.36.vec.extract, %acc_o_alt.sroa.50.36.vec.extract
  %acc_o.sroa.82.40.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 2
  %acc_o_alt.sroa.50.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add1589.10 = fadd contract float %acc_o.sroa.82.40.vec.extract, %acc_o_alt.sroa.50.40.vec.extract
  %acc_o.sroa.82.44.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 3
  %acc_o_alt.sroa.50.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add1589.11 = fadd contract float %acc_o.sroa.82.44.vec.extract, %acc_o_alt.sroa.50.44.vec.extract
  %acc_o.sroa.122.48.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 0
  %acc_o_alt.sroa.74.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 0
  %add1589.12 = fadd contract float %acc_o.sroa.122.48.vec.extract, %acc_o_alt.sroa.74.48.vec.extract
  %acc_o.sroa.122.52.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 1
  %acc_o_alt.sroa.74.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 1
  %add1589.13 = fadd contract float %acc_o.sroa.122.52.vec.extract, %acc_o_alt.sroa.74.52.vec.extract
  %acc_o.sroa.122.56.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 2
  %acc_o_alt.sroa.74.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 2
  %add1589.14 = fadd contract float %acc_o.sroa.122.56.vec.extract, %acc_o_alt.sroa.74.56.vec.extract
  %acc_o.sroa.122.60.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 3
  %acc_o_alt.sroa.74.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 3
  %add1589.15 = fadd contract float %acc_o.sroa.122.60.vec.extract, %acc_o_alt.sroa.74.60.vec.extract
  %add1603 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1603.1 = fadd contract float %add1603, %sum_acc.sroa.36.7
  %add1603.2 = fadd contract float %add1603.1, %sum_acc.sroa.70.7
  %add1603.3 = fadd contract float %add1603.2, %sum_acc.sroa.104.7
  %703 = bitcast float %add1603.3 to i32
  %704 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %705 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %704) #11
  %xor.i.i = xor i32 %705, 32
  %706 = and i32 %705, -64
  %and.i.i = add nsw i32 %706, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2293 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %705
  %shl.i.i = shl i32 %cond.i.i2293, 2
  %707 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %703)
  %708 = bitcast i32 %707 to float
  %add.i = fadd contract float %add1603.3, %708
  %709 = bitcast float %add.i to i32
  %710 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %711 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %710) #11
  %xor.i.i2294 = xor i32 %711, 16
  %712 = and i32 %711, -64
  %and.i.i2295 = add nsw i32 %712, 64
  %cmp.not.i.i2296 = icmp slt i32 %xor.i.i2294, %and.i.i2295
  %cond.i.i2297 = select i1 %cmp.not.i.i2296, i32 %xor.i.i2294, i32 %711
  %shl.i.i2298 = shl i32 %cond.i.i2297, 2
  %713 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2298, i32 %709)
  %714 = bitcast i32 %713 to float
  %add.i.i = fadd contract float %add.i, %714
  %cmp1612 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_12.0 = select i1 %cmp1612, float %div, float 0.000000e+00
  %mul1625 = fmul contract float %condval_12.0, %add1589
  %mul1625.1 = fmul contract float %condval_12.0, %add1589.1
  %mul1625.2 = fmul contract float %condval_12.0, %add1589.2
  %mul1625.3 = fmul contract float %condval_12.0, %add1589.3
  %mul1625.4 = fmul contract float %condval_12.0, %add1589.4
  %mul1625.5 = fmul contract float %condval_12.0, %add1589.5
  %mul1625.6 = fmul contract float %condval_12.0, %add1589.6
  %mul1625.7 = fmul contract float %condval_12.0, %add1589.7
  %mul1625.8 = fmul contract float %condval_12.0, %add1589.8
  %mul1625.9 = fmul contract float %condval_12.0, %add1589.9
  %mul1625.10 = fmul contract float %condval_12.0, %add1589.10
  %mul1625.11 = fmul contract float %condval_12.0, %add1589.11
  %mul1625.12 = fmul contract float %condval_12.0, %add1589.12
  %mul1625.13 = fmul contract float %condval_12.0, %add1589.13
  %mul1625.14 = fmul contract float %condval_12.0, %add1589.14
  %mul1625.15 = fmul contract float %condval_12.0, %add1589.15
  %715 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625)
  %O_reg.sroa.0.0.insert.ext = zext i16 %715 to i64
  %716 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %716 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %717 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %717 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %718 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %718 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %719 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %719 to i64
  %720 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %720 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %721 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %721 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %722 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %722 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %723 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %723 to i64
  %724 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %724 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %725 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %725 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %726 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %726 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %727 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %727 to i64
  %728 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %728 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %729 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %729 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %730 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1625.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %730 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1667 = lshr i32 %18, 5
  %and1670 = and i32 %18, 7
  %mul1676 = and i32 %22, 4
  %xor = xor i32 %shr1667, %and1670
  %mul1671 = shl nuw nsw i32 %xor, 3
  %add1672 = add nuw nsw i32 %mul1671, %mul25
  %add1677 = or disjoint i32 %add1672, %mul1676
  %add.ptr1679 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1677
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1679, align 8
  %add1668.1 = add nuw nsw i32 %shr1667, 2
  %xor.1 = xor i32 %add1668.1, %and1670
  %mul1671.1 = shl nuw nsw i32 %xor.1, 3
  %add1672.1 = add nuw nsw i32 %mul1671.1, %mul25
  %add1677.1 = or disjoint i32 %add1672.1, %mul1676
  %add.ptr1679.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1677.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1679.1, align 8
  %add1668.2 = add nuw nsw i32 %shr1667, 4
  %xor.2 = xor i32 %add1668.2, %and1670
  %mul1671.2 = shl nuw nsw i32 %xor.2, 3
  %add1672.2 = add nuw nsw i32 %mul1671.2, %mul25
  %add1677.2 = or disjoint i32 %add1672.2, %mul1676
  %add.ptr1679.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1677.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1679.2, align 8
  %add1668.3 = add nuw nsw i32 %shr1667, 6
  %xor.3 = xor i32 %add1668.3, %and1670
  %mul1671.3 = shl nuw nsw i32 %xor.3, 3
  %add1672.3 = add nuw nsw i32 %mul1671.3, %mul25
  %add1677.3 = or disjoint i32 %add1672.3, %mul1676
  %add.ptr1679.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1677.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1679.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul1690 = and i32 %mul888, 8128
  %xor16962125 = and i32 %mul888, 56
  %call1694.masked = and i32 %18, 1016
  %mul1697 = xor i32 %xor16962125, %call1694.masked
  %invariant.gep2452 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1690
  %invariant.gep2454 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep2452, i32 %mul1697
  %add1707 = add nuw nsw i32 %add23, %mul888
  %731 = zext nneg i32 %add1707 to i64
  %add.ptr1712 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %731
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1712, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2454, i64 16, i1 false), !tbaa.struct !354, !call_argsrelate !355
  %gep2455.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2454, i32 1024
  %732 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %731
  %add.ptr1712.1 = getelementptr inbounds i8, ptr addrspace(1) %732, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1712.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2455.1, i64 16, i1 false), !tbaa.struct !354, !call_argsrelate !355
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare float @llvm.exp.f32(float) #7

declare void @llvm.mxc.barrier.warp() #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare i32 @llvm.smax.i32(i32, i32) #7

declare i32 @llvm.umax.i32(i32, i32) #7

declare i32 @llvm.smin.i32(i32, i32) #7

declare float @llvm.minnum.f32(float, float) #7

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


