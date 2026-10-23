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
  %cond.i.i2393 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2393, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2393.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2393.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2393.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2393.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2393.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2393.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2393.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2393.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2393.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2393.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2393.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2393.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2393.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2393.7, 4
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
  %or.cond2593 = icmp ult i32 %mul11, 1009
  %add76 = or disjoint i32 %mul11, 15
  %cmp78.not = icmp ule i32 %add76, %1
  %or.cond4541.not4549 = select i1 %or.cond2593, i1 %cmp78.not, i1 false
  %cmp81 = icmp sgt i32 %5, -1
  %or.cond4542 = select i1 %or.cond4541.not4549, i1 %cmp81, i1 false
  br i1 %or.cond4542, label %land.lhs.true82, label %if.else966

land.lhs.true82:                                  ; preds = %entry
  %cmp84 = icmp ult i32 %5, 64
  %add87 = or disjoint i32 %mul11.1, 15
  %cmp89.not = icmp sle i32 %add87, %1
  %or.cond.not4550 = select i1 %cmp84, i1 %cmp89.not, i1 false
  %cmp92 = icmp sgt i32 %7, -1
  %or.cond4543 = select i1 %or.cond.not4550, i1 %cmp92, i1 false
  br i1 %or.cond4543, label %land.lhs.true93, label %if.else966

land.lhs.true93:                                  ; preds = %land.lhs.true82
  %cmp95 = icmp ult i32 %7, 64
  %add98 = or disjoint i32 %mul11.2, 15
  %cmp100.not = icmp sle i32 %add98, %1
  %or.cond2452.not4551 = select i1 %cmp95, i1 %cmp100.not, i1 false
  %cmp103 = icmp sgt i32 %9, -1
  %or.cond4544 = select i1 %or.cond2452.not4551, i1 %cmp103, i1 false
  br i1 %or.cond4544, label %land.lhs.true104, label %if.else966

land.lhs.true104:                                 ; preds = %land.lhs.true93
  %cmp106 = icmp ult i32 %9, 64
  %add109 = or disjoint i32 %mul11.3, 15
  %cmp111.not = icmp sle i32 %add109, %1
  %or.cond2453.not4552 = select i1 %cmp106, i1 %cmp111.not, i1 false
  %cmp114 = icmp sgt i32 %11, -1
  %or.cond4545 = select i1 %or.cond2453.not4552, i1 %cmp114, i1 false
  br i1 %or.cond4545, label %land.lhs.true115, label %if.else966

land.lhs.true115:                                 ; preds = %land.lhs.true104
  %cmp117 = icmp ult i32 %11, 64
  %add120 = or disjoint i32 %mul11.4, 15
  %cmp122.not = icmp sle i32 %add120, %1
  %or.cond2454.not4553 = select i1 %cmp117, i1 %cmp122.not, i1 false
  %cmp125 = icmp sgt i32 %13, -1
  %or.cond4546 = select i1 %or.cond2454.not4553, i1 %cmp125, i1 false
  br i1 %or.cond4546, label %land.lhs.true126, label %if.else966

land.lhs.true126:                                 ; preds = %land.lhs.true115
  %cmp128 = icmp ult i32 %13, 64
  %add131 = or disjoint i32 %mul11.5, 15
  %cmp133.not = icmp sle i32 %add131, %1
  %or.cond2455.not4554 = select i1 %cmp128, i1 %cmp133.not, i1 false
  %cmp136 = icmp sgt i32 %15, -1
  %or.cond4547 = select i1 %or.cond2455.not4554, i1 %cmp136, i1 false
  br i1 %or.cond4547, label %land.lhs.true137, label %if.else966

land.lhs.true137:                                 ; preds = %land.lhs.true126
  %cmp139 = icmp ult i32 %15, 64
  %add142 = or disjoint i32 %mul11.6, 15
  %cmp144.not = icmp sle i32 %add142, %1
  %or.cond2456.not4555 = select i1 %cmp139, i1 %cmp144.not, i1 false
  %cmp147 = icmp sgt i32 %17, -1
  %or.cond4548 = select i1 %or.cond2456.not4555, i1 %cmp147, i1 false
  br i1 %or.cond4548, label %land.lhs.true148, label %if.else966

land.lhs.true148:                                 ; preds = %land.lhs.true137
  %cmp150 = icmp ugt i32 %17, 63
  %add153 = or disjoint i32 %mul11.7, 15
  %cmp155.not = icmp sgt i32 %add153, %1
  %or.cond2457 = select i1 %cmp150, i1 true, i1 %cmp155.not
  br i1 %or.cond2457, label %if.else966, label %for.cond156.preheader

for.cond156.preheader:                            ; preds = %land.lhs.true148
  %conv = zext nneg i32 %0 to i64
  %22 = shl nuw nsw i32 %18, 3
  %mul195 = zext nneg i32 %22 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul195
  %invariant.gep2474 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul195
  %23 = and i32 %cond.i.i2393, 268435455
  %shr187 = zext nneg i32 %23 to i64
  %.idx = shl nuw nsw i64 %shr187, 11
  %24 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx
  %.idx2610 = shl nuw nsw i64 %conv, 17
  %25 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 %.idx2610
  %26 = load <4 x half>, ptr addrspace(4) %25, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %25, i64 8
  %27 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx, align 8, !tbaa !30
  %.idx.1 = shl nuw nsw i64 %shr187, 11
  %28 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1
  %.idx2610.1 = shl nuw nsw i64 %conv, 17
  %29 = getelementptr inbounds i8, ptr addrspace(4) %28, i64 %.idx2610.1
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1024
  %30 = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1032
  %31 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx.1, align 8, !tbaa !30
  %cmp231 = icmp slt i32 %5, 64
  %shr237 = zext nneg i32 %cond.i.i2393.1 to i64
  br i1 %cmp231, label %if.then232, label %if.end271

if.then232:                                       ; preds = %for.cond156.preheader
  %.idx2611 = shl nuw nsw i64 %shr237, 11
  %32 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611
  %.idx2612 = shl nuw nsw i64 %conv, 17
  %33 = getelementptr inbounds i8, ptr addrspace(4) %32, i64 %.idx2612
  %34 = load <4 x half>, ptr addrspace(4) %33, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %33, i64 8
  %35 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx, align 8, !tbaa !30
  br label %if.end271

if.end271:                                        ; preds = %for.cond156.preheader, %if.then232
  %36 = phi <4 x half> [ %35, %if.then232 ], [ zeroinitializer, %for.cond156.preheader ]
  %37 = phi <4 x half> [ %34, %if.then232 ], [ zeroinitializer, %for.cond156.preheader ]
  br i1 %cmp231, label %if.then232.1, label %if.end271.1

if.then232.1:                                     ; preds = %if.end271
  %.idx2611.1 = shl nuw nsw i64 %shr237, 11
  %38 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611.1
  %.idx2612.1 = shl nuw nsw i64 %conv, 17
  %39 = getelementptr inbounds i8, ptr addrspace(4) %38, i64 %.idx2612.1
  %gep2466.1 = getelementptr inbounds i8, ptr addrspace(4) %39, i64 1024
  %40 = load <4 x half>, ptr addrspace(4) %gep2466.1, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %39, i64 1032
  %41 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx.1, align 8, !tbaa !30
  br label %if.end271.1

if.end271.1:                                      ; preds = %if.then232.1, %if.end271
  %42 = phi <4 x half> [ %41, %if.then232.1 ], [ zeroinitializer, %if.end271 ]
  %43 = phi <4 x half> [ %40, %if.then232.1 ], [ zeroinitializer, %if.end271 ]
  %cmp285 = icmp slt i32 %7, 64
  %shr291 = zext nneg i32 %cond.i.i2393.2 to i64
  br i1 %cmp285, label %if.then286, label %if.end325

if.then286:                                       ; preds = %if.end271.1
  %.idx2613 = shl nuw nsw i64 %shr291, 11
  %44 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613
  %.idx2614 = shl nuw nsw i64 %conv, 17
  %45 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 %.idx2614
  %46 = load <4 x half>, ptr addrspace(4) %45, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %45, i64 8
  %47 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx, align 8, !tbaa !30
  br label %if.end325

if.end325:                                        ; preds = %if.end271.1, %if.then286
  %48 = phi <4 x half> [ %47, %if.then286 ], [ zeroinitializer, %if.end271.1 ]
  %49 = phi <4 x half> [ %46, %if.then286 ], [ zeroinitializer, %if.end271.1 ]
  br i1 %cmp285, label %if.then286.1, label %if.end325.1

if.then286.1:                                     ; preds = %if.end325
  %.idx2613.1 = shl nuw nsw i64 %shr291, 11
  %50 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613.1
  %.idx2614.1 = shl nuw nsw i64 %conv, 17
  %51 = getelementptr inbounds i8, ptr addrspace(4) %50, i64 %.idx2614.1
  %gep2469.1 = getelementptr inbounds i8, ptr addrspace(4) %51, i64 1024
  %52 = load <4 x half>, ptr addrspace(4) %gep2469.1, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %51, i64 1032
  %53 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx.1, align 8, !tbaa !30
  br label %if.end325.1

if.end325.1:                                      ; preds = %if.then286.1, %if.end325
  %54 = phi <4 x half> [ %53, %if.then286.1 ], [ zeroinitializer, %if.end325 ]
  %55 = phi <4 x half> [ %52, %if.then286.1 ], [ zeroinitializer, %if.end325 ]
  %cmp339 = icmp slt i32 %9, 64
  %shr345 = zext nneg i32 %cond.i.i2393.3 to i64
  br i1 %cmp339, label %if.then340, label %if.end379

if.then340:                                       ; preds = %if.end325.1
  %.idx2615 = shl nuw nsw i64 %shr345, 11
  %56 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615
  %.idx2616 = shl nuw nsw i64 %conv, 17
  %57 = getelementptr inbounds i8, ptr addrspace(4) %56, i64 %.idx2616
  %58 = load <4 x half>, ptr addrspace(4) %57, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %57, i64 8
  %59 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx, align 8, !tbaa !30
  br label %if.end379

if.end379:                                        ; preds = %if.end325.1, %if.then340
  %60 = phi <4 x half> [ %59, %if.then340 ], [ zeroinitializer, %if.end325.1 ]
  %61 = phi <4 x half> [ %58, %if.then340 ], [ zeroinitializer, %if.end325.1 ]
  br i1 %cmp339, label %if.then340.1, label %if.end379.1

if.then340.1:                                     ; preds = %if.end379
  %.idx2615.1 = shl nuw nsw i64 %shr345, 11
  %62 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615.1
  %.idx2616.1 = shl nuw nsw i64 %conv, 17
  %63 = getelementptr inbounds i8, ptr addrspace(4) %62, i64 %.idx2616.1
  %gep2472.1 = getelementptr inbounds i8, ptr addrspace(4) %63, i64 1024
  %64 = load <4 x half>, ptr addrspace(4) %gep2472.1, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %63, i64 1032
  %65 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx.1, align 8, !tbaa !30
  br label %if.end379.1

if.end379.1:                                      ; preds = %if.then340.1, %if.end379
  %66 = phi <4 x half> [ %65, %if.then340.1 ], [ zeroinitializer, %if.end379 ]
  %67 = phi <4 x half> [ %64, %if.then340.1 ], [ zeroinitializer, %if.end379 ]
  %.idx2617 = shl nuw nsw i64 %shr187, 11
  %68 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617
  %.idx2618 = shl nuw nsw i64 %conv, 17
  %69 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 %.idx2618
  %70 = load <4 x half>, ptr addrspace(4) %69, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %69, i64 8
  %71 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx, align 8, !tbaa !30
  %.idx2617.1 = shl nuw nsw i64 %shr187, 11
  %72 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617.1
  %.idx2618.1 = shl nuw nsw i64 %conv, 17
  %73 = getelementptr inbounds i8, ptr addrspace(4) %72, i64 %.idx2618.1
  %gep2475.1 = getelementptr inbounds i8, ptr addrspace(4) %73, i64 1024
  %74 = load <4 x half>, ptr addrspace(4) %gep2475.1, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %73, i64 1032
  %75 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx.1, align 8, !tbaa !30
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !91
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %76), !call_argsrelate !91
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %77), !call_argsrelate !91
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %78), !call_argsrelate !91
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %79, i64 0
  %mul479 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul479, float 0x4024CB5EC0000000)
  %81 = tail call contract noundef float @llvm.exp.f32(float %80)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %79, i64 1
  %mul479.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul479.1, float 0x4024CB5EC0000000)
  %83 = tail call contract noundef float @llvm.exp.f32(float %82)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %79, i64 2
  %mul479.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul479.2, float 0x4024CB5EC0000000)
  %85 = tail call contract noundef float @llvm.exp.f32(float %84)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %79, i64 3
  %mul479.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul479.3, float 0x4024CB5EC0000000)
  %87 = tail call contract noundef float @llvm.exp.f32(float %86)
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81)
  %89 = insertelement <4 x i16> poison, i16 %88, i64 0
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83)
  %91 = insertelement <4 x i16> %89, i16 %90, i64 1
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %85)
  %93 = insertelement <4 x i16> %91, i16 %92, i64 2
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %87)
  %95 = insertelement <4 x i16> %93, i16 %94, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %95 to <4 x half>
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %70, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !111
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %71, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !111
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !111
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !111
  br i1 %cmp231, label %if.then538, label %if.end577

if.then538:                                       ; preds = %if.end379.1
  %.idx2619 = shl nuw nsw i64 %shr237, 11
  %100 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619
  %.idx2620 = shl nuw nsw i64 %conv, 17
  %101 = getelementptr inbounds i8, ptr addrspace(4) %100, i64 %.idx2620
  %102 = load <4 x half>, ptr addrspace(4) %101, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %101, i64 8
  %103 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx, align 8, !tbaa !30
  br label %if.end577

if.end577:                                        ; preds = %if.end379.1, %if.then538
  %104 = phi <4 x half> [ %103, %if.then538 ], [ zeroinitializer, %if.end379.1 ]
  %105 = phi <4 x half> [ %102, %if.then538 ], [ zeroinitializer, %if.end379.1 ]
  br i1 %cmp231, label %if.then538.1, label %if.end577.1

if.then538.1:                                     ; preds = %if.end577
  %.idx2619.1 = shl nuw nsw i64 %shr237, 11
  %106 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619.1
  %.idx2620.1 = shl nuw nsw i64 %conv, 17
  %107 = getelementptr inbounds i8, ptr addrspace(4) %106, i64 %.idx2620.1
  %gep2487.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024
  %108 = load <4 x half>, ptr addrspace(4) %gep2487.1, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032
  %109 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx.1, align 8, !tbaa !30
  br label %if.end577.1

if.end577.1:                                      ; preds = %if.then538.1, %if.end577
  %110 = phi <4 x half> [ %109, %if.then538.1 ], [ zeroinitializer, %if.end577 ]
  %111 = phi <4 x half> [ %108, %if.then538.1 ], [ zeroinitializer, %if.end577 ]
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %37, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !117
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %112), !call_argsrelate !117
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %43, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %113), !call_argsrelate !117
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %114), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3094 = extractelement <4 x float> %115, i64 0
  %mul623 = fmul contract float %acc_s.sroa.0.0.vec.extract3094, 0x3FB99999A0000000
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul623, float 0x4024CB5EC0000000)
  %117 = tail call contract noundef float @llvm.exp.f32(float %116)
  %acc_s.sroa.0.4.vec.extract3283 = extractelement <4 x float> %115, i64 1
  %mul623.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3283, 0x3FB99999A0000000
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1, float 0x4024CB5EC0000000)
  %119 = tail call contract noundef float @llvm.exp.f32(float %118)
  %acc_s.sroa.0.8.vec.extract3456 = extractelement <4 x float> %115, i64 2
  %mul623.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3456, 0x3FB99999A0000000
  %120 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2, float 0x4024CB5EC0000000)
  %121 = tail call contract noundef float @llvm.exp.f32(float %120)
  %acc_s.sroa.0.12.vec.extract3629 = extractelement <4 x float> %115, i64 3
  %mul623.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3629, 0x3FB99999A0000000
  %122 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3, float 0x4024CB5EC0000000)
  %123 = tail call contract noundef float @llvm.exp.f32(float %122)
  %add639 = fadd contract float %81, %117
  %add639.1 = fadd contract float %83, %119
  %add639.2 = fadd contract float %85, %121
  %add639.3 = fadd contract float %87, %123
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117)
  %125 = insertelement <4 x i16> poison, i16 %124, i64 0
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119)
  %127 = insertelement <4 x i16> %125, i16 %126, i64 1
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %121)
  %129 = insertelement <4 x i16> %127, i16 %128, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %123)
  %131 = insertelement <4 x i16> %129, i16 %130, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3027 = bitcast <4 x i16> %131 to <4 x half>
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %105, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer)
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %104, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer)
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %111, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer)
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %110, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer)
  br i1 %cmp285, label %if.then682, label %if.end721

if.then682:                                       ; preds = %if.end577.1
  %.idx2621 = shl nuw nsw i64 %shr291, 11
  %136 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621
  %.idx2622 = shl nuw nsw i64 %conv, 17
  %137 = getelementptr inbounds i8, ptr addrspace(4) %136, i64 %.idx2622
  %138 = load <4 x half>, ptr addrspace(4) %137, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 8
  %139 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx, align 8, !tbaa !30
  br label %if.end721

if.end721:                                        ; preds = %if.end577.1, %if.then682
  %140 = phi <4 x half> [ %139, %if.then682 ], [ zeroinitializer, %if.end577.1 ]
  %141 = phi <4 x half> [ %138, %if.then682 ], [ zeroinitializer, %if.end577.1 ]
  br i1 %cmp285, label %if.then682.1, label %if.end721.1

if.then682.1:                                     ; preds = %if.end721
  %.idx2621.1 = shl nuw nsw i64 %shr291, 11
  %142 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621.1
  %.idx2622.1 = shl nuw nsw i64 %conv, 17
  %143 = getelementptr inbounds i8, ptr addrspace(4) %142, i64 %.idx2622.1
  %gep2500.1 = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1024
  %144 = load <4 x half>, ptr addrspace(4) %gep2500.1, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1032
  %145 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx.1, align 8, !tbaa !30
  br label %if.end721.1

if.end721.1:                                      ; preds = %if.then682.1, %if.end721
  %146 = phi <4 x half> [ %145, %if.then682.1 ], [ zeroinitializer, %if.end721 ]
  %147 = phi <4 x half> [ %144, %if.then682.1 ], [ zeroinitializer, %if.end721 ]
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %49, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !117
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %148), !call_argsrelate !117
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %149), !call_argsrelate !117
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %150), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3102 = extractelement <4 x float> %151, i64 0
  %mul767 = fmul contract float %acc_s.sroa.0.0.vec.extract3102, 0x3FB99999A0000000
  %152 = tail call contract noundef float @llvm.minnum.f32(float %mul767, float 0x4024CB5EC0000000)
  %153 = tail call contract noundef float @llvm.exp.f32(float %152)
  %acc_s.sroa.0.4.vec.extract3291 = extractelement <4 x float> %151, i64 1
  %mul767.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3291, 0x3FB99999A0000000
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul767.1, float 0x4024CB5EC0000000)
  %155 = tail call contract noundef float @llvm.exp.f32(float %154)
  %acc_s.sroa.0.8.vec.extract3464 = extractelement <4 x float> %151, i64 2
  %mul767.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3464, 0x3FB99999A0000000
  %156 = tail call contract noundef float @llvm.minnum.f32(float %mul767.2, float 0x4024CB5EC0000000)
  %157 = tail call contract noundef float @llvm.exp.f32(float %156)
  %acc_s.sroa.0.12.vec.extract3637 = extractelement <4 x float> %151, i64 3
  %mul767.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3637, 0x3FB99999A0000000
  %158 = tail call contract noundef float @llvm.minnum.f32(float %mul767.3, float 0x4024CB5EC0000000)
  %159 = tail call contract noundef float @llvm.exp.f32(float %158)
  %add783 = fadd contract float %add639, %153
  %add783.1 = fadd contract float %add639.1, %155
  %add783.2 = fadd contract float %add639.2, %157
  %add783.3 = fadd contract float %add639.3, %159
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %153)
  %161 = insertelement <4 x i16> poison, i16 %160, i64 0
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155)
  %163 = insertelement <4 x i16> %161, i16 %162, i64 1
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %157)
  %165 = insertelement <4 x i16> %163, i16 %164, i64 2
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %159)
  %167 = insertelement <4 x i16> %165, i16 %166, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3029 = bitcast <4 x i16> %167 to <4 x half>
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %141, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %96)
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %140, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %97)
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %147, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %98)
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %146, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %99)
  br i1 %cmp339, label %if.then826, label %if.end865

if.then826:                                       ; preds = %if.end721.1
  %.idx2623 = shl nuw nsw i64 %shr345, 11
  %172 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623
  %.idx2624 = shl nuw nsw i64 %conv, 17
  %173 = getelementptr inbounds i8, ptr addrspace(4) %172, i64 %.idx2624
  %174 = load <4 x half>, ptr addrspace(4) %173, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %173, i64 8
  %175 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx, align 8, !tbaa !30
  br label %if.end865

if.end865:                                        ; preds = %if.end721.1, %if.then826
  %176 = phi <4 x half> [ %175, %if.then826 ], [ zeroinitializer, %if.end721.1 ]
  %177 = phi <4 x half> [ %174, %if.then826 ], [ zeroinitializer, %if.end721.1 ]
  br i1 %cmp339, label %if.then826.1, label %if.end865.1

if.then826.1:                                     ; preds = %if.end865
  %.idx2623.1 = shl nuw nsw i64 %shr345, 11
  %178 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623.1
  %.idx2624.1 = shl nuw nsw i64 %conv, 17
  %179 = getelementptr inbounds i8, ptr addrspace(4) %178, i64 %.idx2624.1
  %gep2513.1 = getelementptr inbounds i8, ptr addrspace(4) %179, i64 1024
  %180 = load <4 x half>, ptr addrspace(4) %gep2513.1, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %179, i64 1032
  %181 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx.1, align 8, !tbaa !30
  br label %if.end865.1

if.end865.1:                                      ; preds = %if.then826.1, %if.end865
  %182 = phi <4 x half> [ %181, %if.then826.1 ], [ zeroinitializer, %if.end865 ]
  %183 = phi <4 x half> [ %180, %if.then826.1 ], [ zeroinitializer, %if.end865 ]
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !117
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %184), !call_argsrelate !117
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %185), !call_argsrelate !117
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %186), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3110 = extractelement <4 x float> %187, i64 0
  %mul911 = fmul contract float %acc_s.sroa.0.0.vec.extract3110, 0x3FB99999A0000000
  %188 = tail call contract noundef float @llvm.minnum.f32(float %mul911, float 0x4024CB5EC0000000)
  %189 = tail call contract noundef float @llvm.exp.f32(float %188)
  %acc_s.sroa.0.4.vec.extract3299 = extractelement <4 x float> %187, i64 1
  %mul911.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3299, 0x3FB99999A0000000
  %190 = tail call contract noundef float @llvm.minnum.f32(float %mul911.1, float 0x4024CB5EC0000000)
  %191 = tail call contract noundef float @llvm.exp.f32(float %190)
  %acc_s.sroa.0.8.vec.extract3472 = extractelement <4 x float> %187, i64 2
  %mul911.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3472, 0x3FB99999A0000000
  %192 = tail call contract noundef float @llvm.minnum.f32(float %mul911.2, float 0x4024CB5EC0000000)
  %193 = tail call contract noundef float @llvm.exp.f32(float %192)
  %acc_s.sroa.0.12.vec.extract3645 = extractelement <4 x float> %187, i64 3
  %mul911.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3645, 0x3FB99999A0000000
  %194 = tail call contract noundef float @llvm.minnum.f32(float %mul911.3, float 0x4024CB5EC0000000)
  %195 = tail call contract noundef float @llvm.exp.f32(float %194)
  %add927 = fadd contract float %add783, %189
  %add927.1 = fadd contract float %add783.1, %191
  %add927.2 = fadd contract float %add783.2, %193
  %add927.3 = fadd contract float %add783.3, %195
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %189)
  %197 = insertelement <4 x i16> poison, i16 %196, i64 0
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %191)
  %199 = insertelement <4 x i16> %197, i16 %198, i64 1
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %193)
  %201 = insertelement <4 x i16> %199, i16 %200, i64 2
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %195)
  %203 = insertelement <4 x i16> %201, i16 %202, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3031 = bitcast <4 x i16> %203 to <4 x half>
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %177, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %132)
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %176, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %133)
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %183, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %134)
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %182, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %135)
  %cmp182.1 = icmp slt i32 %11, 64
  %shr187.1 = zext nneg i32 %cond.i.i2393.4 to i64
  br i1 %cmp182.1, label %if.then183.12673, label %if.end.12681

if.then183.12673:                                 ; preds = %if.end865.1
  %.idx.12664 = shl nuw nsw i64 %shr187.1, 11
  %208 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.12664
  %.idx2610.12665 = shl nuw nsw i64 %conv, 17
  %209 = getelementptr inbounds i8, ptr addrspace(4) %208, i64 %.idx2610.12665
  %210 = load <4 x half>, ptr addrspace(4) %209, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx.12669 = getelementptr inbounds i8, ptr addrspace(4) %209, i64 8
  %211 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx.12669, align 8, !tbaa !30
  br label %if.end.12681

if.end.12681:                                     ; preds = %if.then183.12673, %if.end865.1
  %212 = phi <4 x half> [ %211, %if.then183.12673 ], [ zeroinitializer, %if.end865.1 ]
  %213 = phi <4 x half> [ %210, %if.then183.12673 ], [ zeroinitializer, %if.end865.1 ]
  br i1 %cmp182.1, label %if.then183.1.1, label %if.end.1.1

if.then183.1.1:                                   ; preds = %if.end.12681
  %.idx.1.1 = shl nuw nsw i64 %shr187.1, 11
  %214 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1.1
  %.idx2610.1.1 = shl nuw nsw i64 %conv, 17
  %215 = getelementptr inbounds i8, ptr addrspace(4) %214, i64 %.idx2610.1.1
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %215, i64 1024
  %216 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %215, i64 1032
  %217 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end.1.1

if.end.1.1:                                       ; preds = %if.then183.1.1, %if.end.12681
  %218 = phi <4 x half> [ %217, %if.then183.1.1 ], [ zeroinitializer, %if.end.12681 ]
  %219 = phi <4 x half> [ %216, %if.then183.1.1 ], [ zeroinitializer, %if.end.12681 ]
  %cmp231.1 = icmp slt i32 %13, 64
  %shr237.1 = zext nneg i32 %cond.i.i2393.5 to i64
  br i1 %cmp231.1, label %if.then232.12692, label %if.end271.12700

if.then232.12692:                                 ; preds = %if.end.1.1
  %.idx2611.12683 = shl nuw nsw i64 %shr237.1, 11
  %220 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611.12683
  %.idx2612.12684 = shl nuw nsw i64 %conv, 17
  %221 = getelementptr inbounds i8, ptr addrspace(4) %220, i64 %.idx2612.12684
  %222 = load <4 x half>, ptr addrspace(4) %221, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx.12688 = getelementptr inbounds i8, ptr addrspace(4) %221, i64 8
  %223 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx.12688, align 8, !tbaa !30
  br label %if.end271.12700

if.end271.12700:                                  ; preds = %if.then232.12692, %if.end.1.1
  %224 = phi <4 x half> [ %223, %if.then232.12692 ], [ zeroinitializer, %if.end.1.1 ]
  %225 = phi <4 x half> [ %222, %if.then232.12692 ], [ zeroinitializer, %if.end.1.1 ]
  br i1 %cmp231.1, label %if.then232.1.1, label %if.end271.1.1

if.then232.1.1:                                   ; preds = %if.end271.12700
  %.idx2611.1.1 = shl nuw nsw i64 %shr237.1, 11
  %226 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611.1.1
  %.idx2612.1.1 = shl nuw nsw i64 %conv, 17
  %227 = getelementptr inbounds i8, ptr addrspace(4) %226, i64 %.idx2612.1.1
  %gep2466.1.1 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1024
  %228 = load <4 x half>, ptr addrspace(4) %gep2466.1.1, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1032
  %229 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end271.1.1

if.end271.1.1:                                    ; preds = %if.then232.1.1, %if.end271.12700
  %230 = phi <4 x half> [ %229, %if.then232.1.1 ], [ zeroinitializer, %if.end271.12700 ]
  %231 = phi <4 x half> [ %228, %if.then232.1.1 ], [ zeroinitializer, %if.end271.12700 ]
  %cmp285.1 = icmp slt i32 %15, 64
  %shr291.1 = zext nneg i32 %cond.i.i2393.6 to i64
  br i1 %cmp285.1, label %if.then286.12711, label %if.end325.12719

if.then286.12711:                                 ; preds = %if.end271.1.1
  %.idx2613.12702 = shl nuw nsw i64 %shr291.1, 11
  %232 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613.12702
  %.idx2614.12703 = shl nuw nsw i64 %conv, 17
  %233 = getelementptr inbounds i8, ptr addrspace(4) %232, i64 %.idx2614.12703
  %234 = load <4 x half>, ptr addrspace(4) %233, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx.12707 = getelementptr inbounds i8, ptr addrspace(4) %233, i64 8
  %235 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx.12707, align 8, !tbaa !30
  br label %if.end325.12719

if.end325.12719:                                  ; preds = %if.then286.12711, %if.end271.1.1
  %236 = phi <4 x half> [ %235, %if.then286.12711 ], [ zeroinitializer, %if.end271.1.1 ]
  %237 = phi <4 x half> [ %234, %if.then286.12711 ], [ zeroinitializer, %if.end271.1.1 ]
  br i1 %cmp285.1, label %if.then286.1.1, label %if.end325.1.1

if.then286.1.1:                                   ; preds = %if.end325.12719
  %.idx2613.1.1 = shl nuw nsw i64 %shr291.1, 11
  %238 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613.1.1
  %.idx2614.1.1 = shl nuw nsw i64 %conv, 17
  %239 = getelementptr inbounds i8, ptr addrspace(4) %238, i64 %.idx2614.1.1
  %gep2469.1.1 = getelementptr inbounds i8, ptr addrspace(4) %239, i64 1024
  %240 = load <4 x half>, ptr addrspace(4) %gep2469.1.1, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %239, i64 1032
  %241 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end325.1.1

if.end325.1.1:                                    ; preds = %if.then286.1.1, %if.end325.12719
  %242 = phi <4 x half> [ %241, %if.then286.1.1 ], [ zeroinitializer, %if.end325.12719 ]
  %243 = phi <4 x half> [ %240, %if.then286.1.1 ], [ zeroinitializer, %if.end325.12719 ]
  %cmp339.1 = icmp slt i32 %17, 64
  %shr345.1 = zext nneg i32 %cond.i.i2393.7 to i64
  br i1 %cmp339.1, label %if.then340.12730, label %if.end379.12738

if.then340.12730:                                 ; preds = %if.end325.1.1
  %.idx2615.12721 = shl nuw nsw i64 %shr345.1, 11
  %244 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615.12721
  %.idx2616.12722 = shl nuw nsw i64 %conv, 17
  %245 = getelementptr inbounds i8, ptr addrspace(4) %244, i64 %.idx2616.12722
  %246 = load <4 x half>, ptr addrspace(4) %245, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx.12726 = getelementptr inbounds i8, ptr addrspace(4) %245, i64 8
  %247 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx.12726, align 8, !tbaa !30
  br label %if.end379.12738

if.end379.12738:                                  ; preds = %if.then340.12730, %if.end325.1.1
  %248 = phi <4 x half> [ %247, %if.then340.12730 ], [ zeroinitializer, %if.end325.1.1 ]
  %249 = phi <4 x half> [ %246, %if.then340.12730 ], [ zeroinitializer, %if.end325.1.1 ]
  br i1 %cmp339.1, label %if.then340.1.1, label %if.end379.1.1

if.then340.1.1:                                   ; preds = %if.end379.12738
  %.idx2615.1.1 = shl nuw nsw i64 %shr345.1, 11
  %250 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615.1.1
  %.idx2616.1.1 = shl nuw nsw i64 %conv, 17
  %251 = getelementptr inbounds i8, ptr addrspace(4) %250, i64 %.idx2616.1.1
  %gep2472.1.1 = getelementptr inbounds i8, ptr addrspace(4) %251, i64 1024
  %252 = load <4 x half>, ptr addrspace(4) %gep2472.1.1, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %251, i64 1032
  %253 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end379.1.1

if.end379.1.1:                                    ; preds = %if.then340.1.1, %if.end379.12738
  %254 = phi <4 x half> [ %253, %if.then340.1.1 ], [ zeroinitializer, %if.end379.12738 ]
  %255 = phi <4 x half> [ %252, %if.then340.1.1 ], [ zeroinitializer, %if.end379.12738 ]
  br i1 %cmp182.1, label %if.then394.12749, label %if.end433.12757

if.then394.12749:                                 ; preds = %if.end379.1.1
  %.idx2617.12740 = shl nuw nsw i64 %shr187.1, 11
  %256 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617.12740
  %.idx2618.12741 = shl nuw nsw i64 %conv, 17
  %257 = getelementptr inbounds i8, ptr addrspace(4) %256, i64 %.idx2618.12741
  %258 = load <4 x half>, ptr addrspace(4) %257, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx.12745 = getelementptr inbounds i8, ptr addrspace(4) %257, i64 8
  %259 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx.12745, align 8, !tbaa !30
  br label %if.end433.12757

if.end433.12757:                                  ; preds = %if.then394.12749, %if.end379.1.1
  %260 = phi <4 x half> [ %259, %if.then394.12749 ], [ zeroinitializer, %if.end379.1.1 ]
  %261 = phi <4 x half> [ %258, %if.then394.12749 ], [ zeroinitializer, %if.end379.1.1 ]
  br i1 %cmp182.1, label %if.then394.1.1, label %if.end433.1.1

if.then394.1.1:                                   ; preds = %if.end433.12757
  %.idx2617.1.1 = shl nuw nsw i64 %shr187.1, 11
  %262 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617.1.1
  %.idx2618.1.1 = shl nuw nsw i64 %conv, 17
  %263 = getelementptr inbounds i8, ptr addrspace(4) %262, i64 %.idx2618.1.1
  %gep2475.1.1 = getelementptr inbounds i8, ptr addrspace(4) %263, i64 1024
  %264 = load <4 x half>, ptr addrspace(4) %gep2475.1.1, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %263, i64 1032
  %265 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end433.1.1

if.end433.1.1:                                    ; preds = %if.then394.1.1, %if.end433.12757
  %266 = phi <4 x half> [ %265, %if.then394.1.1 ], [ zeroinitializer, %if.end433.12757 ]
  %267 = phi <4 x half> [ %264, %if.then394.1.1 ], [ zeroinitializer, %if.end433.12757 ]
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %213, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !117
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %212, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %268), !call_argsrelate !117
  %270 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %219, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %269), !call_argsrelate !117
  %271 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %218, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %270), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3120 = extractelement <4 x float> %271, i64 0
  %mul479.12761 = fmul contract float %acc_s.sroa.0.0.vec.extract3120, 0x3FB99999A0000000
  %272 = tail call contract noundef float @llvm.minnum.f32(float %mul479.12761, float 0x4024CB5EC0000000)
  %273 = tail call contract noundef float @llvm.exp.f32(float %272)
  %acc_s.sroa.0.4.vec.extract3307 = extractelement <4 x float> %271, i64 1
  %mul479.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3307, 0x3FB99999A0000000
  %274 = tail call contract noundef float @llvm.minnum.f32(float %mul479.1.1, float 0x4024CB5EC0000000)
  %275 = tail call contract noundef float @llvm.exp.f32(float %274)
  %acc_s.sroa.0.8.vec.extract3480 = extractelement <4 x float> %271, i64 2
  %mul479.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3480, 0x3FB99999A0000000
  %276 = tail call contract noundef float @llvm.minnum.f32(float %mul479.2.1, float 0x4024CB5EC0000000)
  %277 = tail call contract noundef float @llvm.exp.f32(float %276)
  %acc_s.sroa.0.12.vec.extract3653 = extractelement <4 x float> %271, i64 3
  %mul479.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3653, 0x3FB99999A0000000
  %278 = tail call contract noundef float @llvm.minnum.f32(float %mul479.3.1, float 0x4024CB5EC0000000)
  %279 = tail call contract noundef float @llvm.exp.f32(float %278)
  %add495.12762 = fadd contract float %add927, %273
  %add495.1.1 = fadd contract float %add927.1, %275
  %add495.2.1 = fadd contract float %add927.2, %277
  %add495.3.1 = fadd contract float %add927.3, %279
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %273)
  %281 = insertelement <4 x i16> poison, i16 %280, i64 0
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %275)
  %283 = insertelement <4 x i16> %281, i16 %282, i64 1
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %277)
  %285 = insertelement <4 x i16> %283, i16 %284, i64 2
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %279)
  %287 = insertelement <4 x i16> %285, i16 %286, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3033 = bitcast <4 x i16> %287 to <4 x half>
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %261, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %168)
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %260, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %169)
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %267, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %170)
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %266, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %171)
  br i1 %cmp231.1, label %if.then538.12773, label %if.end577.12781

if.then538.12773:                                 ; preds = %if.end433.1.1
  %.idx2619.12764 = shl nuw nsw i64 %shr237.1, 11
  %292 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619.12764
  %.idx2620.12765 = shl nuw nsw i64 %conv, 17
  %293 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 %.idx2620.12765
  %294 = load <4 x half>, ptr addrspace(4) %293, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx.12769 = getelementptr inbounds i8, ptr addrspace(4) %293, i64 8
  %295 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx.12769, align 8, !tbaa !30
  br label %if.end577.12781

if.end577.12781:                                  ; preds = %if.then538.12773, %if.end433.1.1
  %296 = phi <4 x half> [ %295, %if.then538.12773 ], [ zeroinitializer, %if.end433.1.1 ]
  %297 = phi <4 x half> [ %294, %if.then538.12773 ], [ zeroinitializer, %if.end433.1.1 ]
  br i1 %cmp231.1, label %if.then538.1.1, label %if.end577.1.1

if.then538.1.1:                                   ; preds = %if.end577.12781
  %.idx2619.1.1 = shl nuw nsw i64 %shr237.1, 11
  %298 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619.1.1
  %.idx2620.1.1 = shl nuw nsw i64 %conv, 17
  %299 = getelementptr inbounds i8, ptr addrspace(4) %298, i64 %.idx2620.1.1
  %gep2487.1.1 = getelementptr inbounds i8, ptr addrspace(4) %299, i64 1024
  %300 = load <4 x half>, ptr addrspace(4) %gep2487.1.1, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %299, i64 1032
  %301 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end577.1.1

if.end577.1.1:                                    ; preds = %if.then538.1.1, %if.end577.12781
  %302 = phi <4 x half> [ %301, %if.then538.1.1 ], [ zeroinitializer, %if.end577.12781 ]
  %303 = phi <4 x half> [ %300, %if.then538.1.1 ], [ zeroinitializer, %if.end577.12781 ]
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %225, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !117
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %304), !call_argsrelate !117
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %231, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %305), !call_argsrelate !117
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %230, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %306), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3130 = extractelement <4 x float> %307, i64 0
  %mul623.12785 = fmul contract float %acc_s.sroa.0.0.vec.extract3130, 0x3FB99999A0000000
  %308 = tail call contract noundef float @llvm.minnum.f32(float %mul623.12785, float 0x4024CB5EC0000000)
  %309 = tail call contract noundef float @llvm.exp.f32(float %308)
  %acc_s.sroa.0.4.vec.extract3315 = extractelement <4 x float> %307, i64 1
  %mul623.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3315, 0x3FB99999A0000000
  %310 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1.1, float 0x4024CB5EC0000000)
  %311 = tail call contract noundef float @llvm.exp.f32(float %310)
  %acc_s.sroa.0.8.vec.extract3488 = extractelement <4 x float> %307, i64 2
  %mul623.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3488, 0x3FB99999A0000000
  %312 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2.1, float 0x4024CB5EC0000000)
  %313 = tail call contract noundef float @llvm.exp.f32(float %312)
  %acc_s.sroa.0.12.vec.extract3661 = extractelement <4 x float> %307, i64 3
  %mul623.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3661, 0x3FB99999A0000000
  %314 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3.1, float 0x4024CB5EC0000000)
  %315 = tail call contract noundef float @llvm.exp.f32(float %314)
  %add639.12786 = fadd contract float %add495.12762, %309
  %add639.1.1 = fadd contract float %add495.1.1, %311
  %add639.2.1 = fadd contract float %add495.2.1, %313
  %add639.3.1 = fadd contract float %add495.3.1, %315
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %309)
  %317 = insertelement <4 x i16> poison, i16 %316, i64 0
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %311)
  %319 = insertelement <4 x i16> %317, i16 %318, i64 1
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %313)
  %321 = insertelement <4 x i16> %319, i16 %320, i64 2
  %322 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %315)
  %323 = insertelement <4 x i16> %321, i16 %322, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3035 = bitcast <4 x i16> %323 to <4 x half>
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %297, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %204)
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %296, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %205)
  %326 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %303, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %206)
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %302, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %207)
  br i1 %cmp285.1, label %if.then682.12797, label %if.end721.12805

if.then682.12797:                                 ; preds = %if.end577.1.1
  %.idx2621.12788 = shl nuw nsw i64 %shr291.1, 11
  %328 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621.12788
  %.idx2622.12789 = shl nuw nsw i64 %conv, 17
  %329 = getelementptr inbounds i8, ptr addrspace(4) %328, i64 %.idx2622.12789
  %330 = load <4 x half>, ptr addrspace(4) %329, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx.12793 = getelementptr inbounds i8, ptr addrspace(4) %329, i64 8
  %331 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx.12793, align 8, !tbaa !30
  br label %if.end721.12805

if.end721.12805:                                  ; preds = %if.then682.12797, %if.end577.1.1
  %332 = phi <4 x half> [ %331, %if.then682.12797 ], [ zeroinitializer, %if.end577.1.1 ]
  %333 = phi <4 x half> [ %330, %if.then682.12797 ], [ zeroinitializer, %if.end577.1.1 ]
  br i1 %cmp285.1, label %if.then682.1.1, label %if.end721.1.1

if.then682.1.1:                                   ; preds = %if.end721.12805
  %.idx2621.1.1 = shl nuw nsw i64 %shr291.1, 11
  %334 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621.1.1
  %.idx2622.1.1 = shl nuw nsw i64 %conv, 17
  %335 = getelementptr inbounds i8, ptr addrspace(4) %334, i64 %.idx2622.1.1
  %gep2500.1.1 = getelementptr inbounds i8, ptr addrspace(4) %335, i64 1024
  %336 = load <4 x half>, ptr addrspace(4) %gep2500.1.1, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %335, i64 1032
  %337 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end721.1.1

if.end721.1.1:                                    ; preds = %if.then682.1.1, %if.end721.12805
  %338 = phi <4 x half> [ %337, %if.then682.1.1 ], [ zeroinitializer, %if.end721.12805 ]
  %339 = phi <4 x half> [ %336, %if.then682.1.1 ], [ zeroinitializer, %if.end721.12805 ]
  %340 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %237, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !117
  %341 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %236, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %340), !call_argsrelate !117
  %342 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %243, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %341), !call_argsrelate !117
  %343 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %242, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %342), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3140 = extractelement <4 x float> %343, i64 0
  %mul767.12809 = fmul contract float %acc_s.sroa.0.0.vec.extract3140, 0x3FB99999A0000000
  %344 = tail call contract noundef float @llvm.minnum.f32(float %mul767.12809, float 0x4024CB5EC0000000)
  %345 = tail call contract noundef float @llvm.exp.f32(float %344)
  %acc_s.sroa.0.4.vec.extract3323 = extractelement <4 x float> %343, i64 1
  %mul767.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3323, 0x3FB99999A0000000
  %346 = tail call contract noundef float @llvm.minnum.f32(float %mul767.1.1, float 0x4024CB5EC0000000)
  %347 = tail call contract noundef float @llvm.exp.f32(float %346)
  %acc_s.sroa.0.8.vec.extract3496 = extractelement <4 x float> %343, i64 2
  %mul767.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3496, 0x3FB99999A0000000
  %348 = tail call contract noundef float @llvm.minnum.f32(float %mul767.2.1, float 0x4024CB5EC0000000)
  %349 = tail call contract noundef float @llvm.exp.f32(float %348)
  %acc_s.sroa.0.12.vec.extract3669 = extractelement <4 x float> %343, i64 3
  %mul767.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3669, 0x3FB99999A0000000
  %350 = tail call contract noundef float @llvm.minnum.f32(float %mul767.3.1, float 0x4024CB5EC0000000)
  %351 = tail call contract noundef float @llvm.exp.f32(float %350)
  %add783.12810 = fadd contract float %add639.12786, %345
  %add783.1.1 = fadd contract float %add639.1.1, %347
  %add783.2.1 = fadd contract float %add639.2.1, %349
  %add783.3.1 = fadd contract float %add639.3.1, %351
  %352 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %345)
  %353 = insertelement <4 x i16> poison, i16 %352, i64 0
  %354 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %347)
  %355 = insertelement <4 x i16> %353, i16 %354, i64 1
  %356 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %349)
  %357 = insertelement <4 x i16> %355, i16 %356, i64 2
  %358 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %351)
  %359 = insertelement <4 x i16> %357, i16 %358, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3037 = bitcast <4 x i16> %359 to <4 x half>
  %360 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %333, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %288)
  %361 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %332, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %289)
  %362 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %339, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %290)
  %363 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %338, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %291)
  br i1 %cmp339.1, label %if.then826.12821, label %if.end865.12829

if.then826.12821:                                 ; preds = %if.end721.1.1
  %.idx2623.12812 = shl nuw nsw i64 %shr345.1, 11
  %364 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623.12812
  %.idx2624.12813 = shl nuw nsw i64 %conv, 17
  %365 = getelementptr inbounds i8, ptr addrspace(4) %364, i64 %.idx2624.12813
  %366 = load <4 x half>, ptr addrspace(4) %365, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx.12817 = getelementptr inbounds i8, ptr addrspace(4) %365, i64 8
  %367 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx.12817, align 8, !tbaa !30
  br label %if.end865.12829

if.end865.12829:                                  ; preds = %if.then826.12821, %if.end721.1.1
  %368 = phi <4 x half> [ %367, %if.then826.12821 ], [ zeroinitializer, %if.end721.1.1 ]
  %369 = phi <4 x half> [ %366, %if.then826.12821 ], [ zeroinitializer, %if.end721.1.1 ]
  br i1 %cmp339.1, label %if.then826.1.1, label %if.end865.1.1

if.then826.1.1:                                   ; preds = %if.end865.12829
  %.idx2623.1.1 = shl nuw nsw i64 %shr345.1, 11
  %370 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623.1.1
  %.idx2624.1.1 = shl nuw nsw i64 %conv, 17
  %371 = getelementptr inbounds i8, ptr addrspace(4) %370, i64 %.idx2624.1.1
  %gep2513.1.1 = getelementptr inbounds i8, ptr addrspace(4) %371, i64 1024
  %372 = load <4 x half>, ptr addrspace(4) %gep2513.1.1, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %371, i64 1032
  %373 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end865.1.1

if.end865.1.1:                                    ; preds = %if.then826.1.1, %if.end865.12829
  %374 = phi <4 x half> [ %373, %if.then826.1.1 ], [ zeroinitializer, %if.end865.12829 ]
  %375 = phi <4 x half> [ %372, %if.then826.1.1 ], [ zeroinitializer, %if.end865.12829 ]
  %376 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %249, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !117
  %377 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %248, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %376), !call_argsrelate !117
  %378 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %255, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %377), !call_argsrelate !117
  %379 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %254, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %378), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3150 = extractelement <4 x float> %379, i64 0
  %mul911.12833 = fmul contract float %acc_s.sroa.0.0.vec.extract3150, 0x3FB99999A0000000
  %380 = tail call contract noundef float @llvm.minnum.f32(float %mul911.12833, float 0x4024CB5EC0000000)
  %381 = tail call contract noundef float @llvm.exp.f32(float %380)
  %acc_s.sroa.0.4.vec.extract3331 = extractelement <4 x float> %379, i64 1
  %mul911.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3331, 0x3FB99999A0000000
  %382 = tail call contract noundef float @llvm.minnum.f32(float %mul911.1.1, float 0x4024CB5EC0000000)
  %383 = tail call contract noundef float @llvm.exp.f32(float %382)
  %acc_s.sroa.0.8.vec.extract3504 = extractelement <4 x float> %379, i64 2
  %mul911.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3504, 0x3FB99999A0000000
  %384 = tail call contract noundef float @llvm.minnum.f32(float %mul911.2.1, float 0x4024CB5EC0000000)
  %385 = tail call contract noundef float @llvm.exp.f32(float %384)
  %acc_s.sroa.0.12.vec.extract3677 = extractelement <4 x float> %379, i64 3
  %mul911.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3677, 0x3FB99999A0000000
  %386 = tail call contract noundef float @llvm.minnum.f32(float %mul911.3.1, float 0x4024CB5EC0000000)
  %387 = tail call contract noundef float @llvm.exp.f32(float %386)
  %add927.12834 = fadd contract float %add783.12810, %381
  %add927.1.1 = fadd contract float %add783.1.1, %383
  %add927.2.1 = fadd contract float %add783.2.1, %385
  %add927.3.1 = fadd contract float %add783.3.1, %387
  %388 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %381)
  %389 = insertelement <4 x i16> poison, i16 %388, i64 0
  %390 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %383)
  %391 = insertelement <4 x i16> %389, i16 %390, i64 1
  %392 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %385)
  %393 = insertelement <4 x i16> %391, i16 %392, i64 2
  %394 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %387)
  %395 = insertelement <4 x i16> %393, i16 %394, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3039 = bitcast <4 x i16> %395 to <4 x half>
  %396 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %369, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %324)
  %397 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %368, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %325)
  %398 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %375, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %326)
  %399 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %374, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %327)
  %.pre = lshr i32 %18, 2
  br label %if.end1697

if.else966:                                       ; preds = %land.lhs.true148, %land.lhs.true137, %land.lhs.true126, %land.lhs.true115, %land.lhs.true104, %land.lhs.true93, %land.lhs.true82, %entry
  %mul998 = shl nsw i32 %0, 16
  %mul1005 = shl nuw nsw i32 %18, 3
  %add1001 = or disjoint i32 %mul1005, %mul998
  %invariant.op = add nsw i32 %1, -15
  %400 = lshr i32 %18, 2
  %mul1150 = and i32 %400, 252
  %or.cond2594 = icmp ugt i32 %mul11, 1023
  %cmp991.not = icmp sgt i32 %mul11, %1
  %or.cond2595 = or i1 %or.cond2594, %cmp991.not
  br i1 %or.cond2595, label %if.end1016, label %for.cond993.preheader

for.cond993.preheader:                            ; preds = %if.else966
  %401 = shl nsw i32 %cond.i.i2393, 10
  %mul1000 = and i32 %401, 64512
  %add1003 = add nuw nsw i32 %add1001, %mul1000
  %402 = zext nneg i32 %add1003 to i64
  %add.ptr1008 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %402
  %K_reg.sroa.0.0.copyload4498 = load <4 x half>, ptr addrspace(4) %add.ptr1008, align 16
  %K_reg.sroa.12.0.add.ptr1008.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1008, i64 8
  %K_reg.sroa.12.0.copyload4500 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr1008.sroa_idx, align 8
  %403 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %402
  %add.ptr1008.1 = getelementptr inbounds i8, ptr addrspace(4) %403, i64 1024
  %K_reg.sroa.20.16.copyload4502 = load <4 x half>, ptr addrspace(4) %add.ptr1008.1, align 16
  %K_reg.sroa.30.16.add.ptr1008.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %403, i64 1032
  %K_reg.sroa.30.16.copyload4504 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr1008.1.sroa_idx, align 8
  br label %if.end1016

if.end1016:                                       ; preds = %for.cond993.preheader, %if.else966
  %404 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.30.16.copyload4504, %for.cond993.preheader ]
  %405 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.20.16.copyload4502, %for.cond993.preheader ]
  %406 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.12.0.copyload4500, %for.cond993.preheader ]
  %407 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.0.0.copyload4498, %for.cond993.preheader ]
  %or.cond2596 = icmp ugt i32 %mul11.1, 1023
  %cmp1022.not = icmp sgt i32 %mul11.1, %1
  %or.cond2597 = or i1 %or.cond2596, %cmp1022.not
  br i1 %or.cond2597, label %if.end1047, label %for.cond1024.preheader

for.cond1024.preheader:                           ; preds = %if.end1016
  %408 = shl nsw i32 %cond.i.i2393.1, 10
  %mul1031 = and i32 %408, 64512
  %add1034 = add nuw nsw i32 %add1001, %mul1031
  %409 = zext nneg i32 %add1034 to i64
  %add.ptr1039 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %409
  %K_reg1.sroa.0.0.copyload4510 = load <4 x half>, ptr addrspace(4) %add.ptr1039, align 16
  %K_reg1.sroa.12.0.add.ptr1039.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1039, i64 8
  %K_reg1.sroa.12.0.copyload4512 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr1039.sroa_idx, align 8
  %410 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %409
  %add.ptr1039.1 = getelementptr inbounds i8, ptr addrspace(4) %410, i64 1024
  %K_reg1.sroa.20.16.copyload4514 = load <4 x half>, ptr addrspace(4) %add.ptr1039.1, align 16
  %K_reg1.sroa.30.16.add.ptr1039.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %410, i64 1032
  %K_reg1.sroa.30.16.copyload4516 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr1039.1.sroa_idx, align 8
  br label %if.end1047

if.end1047:                                       ; preds = %for.cond1024.preheader, %if.end1016
  %411 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.30.16.copyload4516, %for.cond1024.preheader ]
  %412 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.20.16.copyload4514, %for.cond1024.preheader ]
  %413 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.12.0.copyload4512, %for.cond1024.preheader ]
  %414 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.0.0.copyload4510, %for.cond1024.preheader ]
  %or.cond2598 = icmp ugt i32 %mul11.2, 1023
  %cmp1053.not = icmp sgt i32 %mul11.2, %1
  %or.cond2599 = or i1 %or.cond2598, %cmp1053.not
  br i1 %or.cond2599, label %if.end1078, label %for.cond1055.preheader

for.cond1055.preheader:                           ; preds = %if.end1047
  %415 = shl nsw i32 %cond.i.i2393.2, 10
  %mul1062 = and i32 %415, 64512
  %add1065 = add nuw nsw i32 %add1001, %mul1062
  %416 = zext nneg i32 %add1065 to i64
  %add.ptr1070 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %416
  %K_reg2.sroa.0.0.copyload4522 = load <4 x half>, ptr addrspace(4) %add.ptr1070, align 16
  %K_reg2.sroa.12.0.add.ptr1070.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1070, i64 8
  %K_reg2.sroa.12.0.copyload4524 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1070.sroa_idx, align 8
  %417 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %416
  %add.ptr1070.1 = getelementptr inbounds i8, ptr addrspace(4) %417, i64 1024
  %K_reg2.sroa.20.16.copyload4526 = load <4 x half>, ptr addrspace(4) %add.ptr1070.1, align 16
  %K_reg2.sroa.30.16.add.ptr1070.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %417, i64 1032
  %K_reg2.sroa.30.16.copyload4528 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1070.1.sroa_idx, align 8
  br label %if.end1078

if.end1078:                                       ; preds = %for.cond1055.preheader, %if.end1047
  %418 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.30.16.copyload4528, %for.cond1055.preheader ]
  %419 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.20.16.copyload4526, %for.cond1055.preheader ]
  %420 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.12.0.copyload4524, %for.cond1055.preheader ]
  %421 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.0.0.copyload4522, %for.cond1055.preheader ]
  %or.cond2600 = icmp ugt i32 %mul11.3, 1023
  %cmp1084.not = icmp sgt i32 %mul11.3, %1
  %or.cond2601 = or i1 %or.cond2600, %cmp1084.not
  br i1 %or.cond2601, label %if.end1109, label %for.cond1086.preheader

for.cond1086.preheader:                           ; preds = %if.end1078
  %422 = shl nsw i32 %cond.i.i2393.3, 10
  %mul1093 = and i32 %422, 64512
  %add1096 = add nuw nsw i32 %add1001, %mul1093
  %423 = zext nneg i32 %add1096 to i64
  %add.ptr1101 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %423
  %K_reg3.sroa.0.0.copyload4534 = load <4 x half>, ptr addrspace(4) %add.ptr1101, align 16
  %K_reg3.sroa.12.0.add.ptr1101.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1101, i64 8
  %K_reg3.sroa.12.0.copyload4536 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1101.sroa_idx, align 8
  %424 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %423
  %add.ptr1101.1 = getelementptr inbounds i8, ptr addrspace(4) %424, i64 1024
  %K_reg3.sroa.20.16.copyload4538 = load <4 x half>, ptr addrspace(4) %add.ptr1101.1, align 16
  %K_reg3.sroa.30.16.add.ptr1101.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %424, i64 1032
  %K_reg3.sroa.30.16.copyload4540 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1101.1.sroa_idx, align 8
  br label %if.end1109

if.end1109:                                       ; preds = %for.cond1086.preheader, %if.end1078
  %425 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.30.16.copyload4540, %for.cond1086.preheader ]
  %426 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.20.16.copyload4538, %for.cond1086.preheader ]
  %427 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.12.0.copyload4536, %for.cond1086.preheader ]
  %428 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.0.0.copyload4534, %for.cond1086.preheader ]
  br i1 %or.cond2595, label %if.end1255, label %for.cond1117.preheader

for.cond1117.preheader:                           ; preds = %if.end1109
  %429 = shl nsw i32 %cond.i.i2393, 10
  %mul1124 = and i32 %429, 64512
  %add1127 = add nuw nsw i32 %add1001, %mul1124
  %430 = zext nneg i32 %add1127 to i64
  %add.ptr1132 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %430
  %V_reg.sroa.0.0.copyload4477 = load <4 x half>, ptr addrspace(4) %add.ptr1132, align 16
  %V_reg.sroa.42.0.add.ptr1132.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1132, i64 8
  %V_reg.sroa.42.0.copyload4478 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1132.sroa_idx, align 8
  %431 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %430
  %add.ptr1132.1 = getelementptr inbounds i8, ptr addrspace(4) %431, i64 1024
  %V_reg.sroa.74.16.copyload4479 = load <4 x half>, ptr addrspace(4) %add.ptr1132.1, align 16
  %V_reg.sroa.114.16.add.ptr1132.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %431, i64 1032
  %V_reg.sroa.114.16.copyload4480 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1132.1.sroa_idx, align 8
  %cmp1142 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp1142, label %for.cond1144.preheader, label %if.end1168

for.cond1144.preheader:                           ; preds = %for.cond1117.preheader
  %add1151 = add nuw nsw i32 %mul11, %mul1150
  %cmp1154.not = icmp sgt i32 %add1151, %1
  %fneg. = select i1 %cmp1154.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3158 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp1154.not.1.not = icmp slt i32 %add1151, %1
  %fneg..1 = select i1 %cmp1154.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3339 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3158, float %fneg..1, i64 1
  %add1152.2 = or disjoint i32 %add1151, 2
  %cmp1154.not.2 = icmp sgt i32 %add1152.2, %1
  %fneg..2 = select i1 %cmp1154.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3512 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3339, float %fneg..2, i64 2
  %add1152.3 = or disjoint i32 %add1151, 3
  %cmp1154.not.3 = icmp sgt i32 %add1152.3, %1
  %fneg..3 = select i1 %cmp1154.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3685 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3512, float %fneg..3, i64 3
  br label %if.end1168

if.end1168:                                       ; preds = %for.cond1117.preheader, %for.cond1144.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3685, %for.cond1144.preheader ], [ zeroinitializer, %for.cond1117.preheader ]
  %432 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %407, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !117
  %433 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %406, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %432), !call_argsrelate !117
  %434 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %405, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %433), !call_argsrelate !117
  %435 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %404, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %434), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3160 = extractelement <4 x float> %435, i64 0
  %mul1203 = fmul contract float %acc_s.sroa.0.0.vec.extract3160, 0x3FB99999A0000000
  %436 = tail call contract noundef float @llvm.minnum.f32(float %mul1203, float 0x4024CB5EC0000000)
  %437 = tail call contract noundef float @llvm.exp.f32(float %436)
  %acc_s.sroa.0.4.vec.extract3341 = extractelement <4 x float> %435, i64 1
  %mul1203.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3341, 0x3FB99999A0000000
  %438 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.1, float 0x4024CB5EC0000000)
  %439 = tail call contract noundef float @llvm.exp.f32(float %438)
  %acc_s.sroa.0.8.vec.extract3514 = extractelement <4 x float> %435, i64 2
  %mul1203.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3514, 0x3FB99999A0000000
  %440 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.2, float 0x4024CB5EC0000000)
  %441 = tail call contract noundef float @llvm.exp.f32(float %440)
  %acc_s.sroa.0.12.vec.extract3687 = extractelement <4 x float> %435, i64 3
  %mul1203.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3687, 0x3FB99999A0000000
  %442 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.3, float 0x4024CB5EC0000000)
  %443 = tail call contract noundef float @llvm.exp.f32(float %442)
  %444 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %437)
  %445 = insertelement <4 x i16> poison, i16 %444, i64 0
  %446 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %439)
  %447 = insertelement <4 x i16> %445, i16 %446, i64 1
  %448 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %441)
  %449 = insertelement <4 x i16> %447, i16 %448, i64 2
  %450 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %443)
  %451 = insertelement <4 x i16> %449, i16 %450, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3041 = bitcast <4 x i16> %451 to <4 x half>
  %452 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload4477, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !call_argsrelate !111
  %453 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload4478, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !call_argsrelate !111
  %454 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload4479, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !call_argsrelate !111
  %455 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload4480, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !call_argsrelate !111
  br label %if.end1255

if.end1255:                                       ; preds = %if.end1168, %if.end1109
  %acc_o.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %455, %if.end1168 ]
  %acc_o.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %454, %if.end1168 ]
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %453, %if.end1168 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %452, %if.end1168 ]
  %sum_acc.sroa.104.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %443, %if.end1168 ]
  %sum_acc.sroa.70.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %441, %if.end1168 ]
  %sum_acc.sroa.36.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %439, %if.end1168 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %437, %if.end1168 ]
  br i1 %or.cond2597, label %if.end1401, label %for.cond1263.preheader

for.cond1263.preheader:                           ; preds = %if.end1255
  %456 = shl nsw i32 %cond.i.i2393.1, 10
  %mul1270 = and i32 %456, 64512
  %add1273 = add nuw nsw i32 %add1001, %mul1270
  %457 = zext nneg i32 %add1273 to i64
  %add.ptr1278 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %457
  %V_reg.sroa.0.0.copyload37944481 = load <4 x half>, ptr addrspace(4) %add.ptr1278, align 16
  %V_reg.sroa.42.0.add.ptr1278.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1278, i64 8
  %V_reg.sroa.42.0.copyload38154482 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1278.sroa_idx, align 8
  %458 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %457
  %add.ptr1278.1 = getelementptr inbounds i8, ptr addrspace(4) %458, i64 1024
  %V_reg.sroa.74.16.copyload38964483 = load <4 x half>, ptr addrspace(4) %add.ptr1278.1, align 16
  %V_reg.sroa.114.16.add.ptr1278.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %458, i64 1032
  %V_reg.sroa.114.16.copyload39174484 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1278.1.sroa_idx, align 8
  %cmp1288 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp1288, label %for.cond1290.preheader, label %if.end1314

for.cond1290.preheader:                           ; preds = %for.cond1263.preheader
  %add1297 = add nuw nsw i32 %mul11.1, %mul1150
  %cmp1300.not = icmp sgt i32 %add1297, %1
  %fneg.2258 = select i1 %cmp1300.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3168 = insertelement <4 x float> poison, float %fneg.2258, i64 0
  %cmp1300.not.1.not = icmp slt i32 %add1297, %1
  %fneg.2258.1 = select i1 %cmp1300.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3349 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3168, float %fneg.2258.1, i64 1
  %add1298.2 = or disjoint i32 %add1297, 2
  %cmp1300.not.2 = icmp sgt i32 %add1298.2, %1
  %fneg.2258.2 = select i1 %cmp1300.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3522 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3349, float %fneg.2258.2, i64 2
  %add1298.3 = or disjoint i32 %add1297, 3
  %cmp1300.not.3 = icmp sgt i32 %add1298.3, %1
  %fneg.2258.3 = select i1 %cmp1300.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3695 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3522, float %fneg.2258.3, i64 3
  br label %if.end1314

if.end1314:                                       ; preds = %for.cond1263.preheader, %for.cond1290.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3695, %for.cond1290.preheader ], [ zeroinitializer, %for.cond1263.preheader ]
  %459 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %414, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !117
  %460 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %413, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %459), !call_argsrelate !117
  %461 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %412, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %460), !call_argsrelate !117
  %462 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %411, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %461), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3170 = extractelement <4 x float> %462, i64 0
  %mul1349 = fmul contract float %acc_s.sroa.0.0.vec.extract3170, 0x3FB99999A0000000
  %463 = tail call contract noundef float @llvm.minnum.f32(float %mul1349, float 0x4024CB5EC0000000)
  %464 = tail call contract noundef float @llvm.exp.f32(float %463)
  %acc_s.sroa.0.4.vec.extract3351 = extractelement <4 x float> %462, i64 1
  %mul1349.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3351, 0x3FB99999A0000000
  %465 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.1, float 0x4024CB5EC0000000)
  %466 = tail call contract noundef float @llvm.exp.f32(float %465)
  %acc_s.sroa.0.8.vec.extract3524 = extractelement <4 x float> %462, i64 2
  %mul1349.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3524, 0x3FB99999A0000000
  %467 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.2, float 0x4024CB5EC0000000)
  %468 = tail call contract noundef float @llvm.exp.f32(float %467)
  %acc_s.sroa.0.12.vec.extract3697 = extractelement <4 x float> %462, i64 3
  %mul1349.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3697, 0x3FB99999A0000000
  %469 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.3, float 0x4024CB5EC0000000)
  %470 = tail call contract noundef float @llvm.exp.f32(float %469)
  %add1365 = fadd contract float %sum_acc.sroa.0.0, %464
  %add1365.1 = fadd contract float %sum_acc.sroa.36.0, %466
  %add1365.2 = fadd contract float %sum_acc.sroa.70.0, %468
  %add1365.3 = fadd contract float %sum_acc.sroa.104.0, %470
  %471 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %464)
  %472 = insertelement <4 x i16> poison, i16 %471, i64 0
  %473 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %466)
  %474 = insertelement <4 x i16> %472, i16 %473, i64 1
  %475 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %468)
  %476 = insertelement <4 x i16> %474, i16 %475, i64 2
  %477 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %470)
  %478 = insertelement <4 x i16> %476, i16 %477, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3043 = bitcast <4 x i16> %478 to <4 x half>
  %479 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37944481, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !call_argsrelate !111
  %480 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38154482, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !call_argsrelate !111
  %481 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38964483, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !call_argsrelate !111
  %482 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39174484, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !call_argsrelate !111
  br label %if.end1401

if.end1401:                                       ; preds = %if.end1314, %if.end1255
  %acc_o_alt.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %482, %if.end1314 ]
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %481, %if.end1314 ]
  %acc_o_alt.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %480, %if.end1314 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %479, %if.end1314 ]
  %sum_acc.sroa.104.1 = phi float [ %sum_acc.sroa.104.0, %if.end1255 ], [ %add1365.3, %if.end1314 ]
  %sum_acc.sroa.70.1 = phi float [ %sum_acc.sroa.70.0, %if.end1255 ], [ %add1365.2, %if.end1314 ]
  %sum_acc.sroa.36.1 = phi float [ %sum_acc.sroa.36.0, %if.end1255 ], [ %add1365.1, %if.end1314 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end1255 ], [ %add1365, %if.end1314 ]
  br i1 %or.cond2599, label %if.end1547, label %for.cond1409.preheader

for.cond1409.preheader:                           ; preds = %if.end1401
  %483 = shl nsw i32 %cond.i.i2393.2, 10
  %mul1416 = and i32 %483, 64512
  %add1419 = add nuw nsw i32 %add1001, %mul1416
  %484 = zext nneg i32 %add1419 to i64
  %add.ptr1424 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %484
  %V_reg.sroa.0.0.copyload37954485 = load <4 x half>, ptr addrspace(4) %add.ptr1424, align 16
  %V_reg.sroa.42.0.add.ptr1424.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1424, i64 8
  %V_reg.sroa.42.0.copyload38164486 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1424.sroa_idx, align 8
  %485 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %484
  %add.ptr1424.1 = getelementptr inbounds i8, ptr addrspace(4) %485, i64 1024
  %V_reg.sroa.74.16.copyload38974487 = load <4 x half>, ptr addrspace(4) %add.ptr1424.1, align 16
  %V_reg.sroa.114.16.add.ptr1424.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %485, i64 1032
  %V_reg.sroa.114.16.copyload39184488 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1424.1.sroa_idx, align 8
  %cmp1434 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp1434, label %for.cond1436.preheader, label %if.end1460

for.cond1436.preheader:                           ; preds = %for.cond1409.preheader
  %add1443 = add nuw nsw i32 %mul11.2, %mul1150
  %cmp1446.not = icmp sgt i32 %add1443, %1
  %fneg.2259 = select i1 %cmp1446.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3178 = insertelement <4 x float> poison, float %fneg.2259, i64 0
  %cmp1446.not.1.not = icmp slt i32 %add1443, %1
  %fneg.2259.1 = select i1 %cmp1446.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3359 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3178, float %fneg.2259.1, i64 1
  %add1444.2 = or disjoint i32 %add1443, 2
  %cmp1446.not.2 = icmp sgt i32 %add1444.2, %1
  %fneg.2259.2 = select i1 %cmp1446.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3532 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3359, float %fneg.2259.2, i64 2
  %add1444.3 = or disjoint i32 %add1443, 3
  %cmp1446.not.3 = icmp sgt i32 %add1444.3, %1
  %fneg.2259.3 = select i1 %cmp1446.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3705 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3532, float %fneg.2259.3, i64 3
  br label %if.end1460

if.end1460:                                       ; preds = %for.cond1409.preheader, %for.cond1436.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3705, %for.cond1436.preheader ], [ zeroinitializer, %for.cond1409.preheader ]
  %486 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %421, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !117
  %487 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %420, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %486), !call_argsrelate !117
  %488 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %419, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %487), !call_argsrelate !117
  %489 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %418, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %488), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3180 = extractelement <4 x float> %489, i64 0
  %mul1495 = fmul contract float %acc_s.sroa.0.0.vec.extract3180, 0x3FB99999A0000000
  %490 = tail call contract noundef float @llvm.minnum.f32(float %mul1495, float 0x4024CB5EC0000000)
  %491 = tail call contract noundef float @llvm.exp.f32(float %490)
  %acc_s.sroa.0.4.vec.extract3361 = extractelement <4 x float> %489, i64 1
  %mul1495.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3361, 0x3FB99999A0000000
  %492 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.1, float 0x4024CB5EC0000000)
  %493 = tail call contract noundef float @llvm.exp.f32(float %492)
  %acc_s.sroa.0.8.vec.extract3534 = extractelement <4 x float> %489, i64 2
  %mul1495.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3534, 0x3FB99999A0000000
  %494 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.2, float 0x4024CB5EC0000000)
  %495 = tail call contract noundef float @llvm.exp.f32(float %494)
  %acc_s.sroa.0.12.vec.extract3707 = extractelement <4 x float> %489, i64 3
  %mul1495.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3707, 0x3FB99999A0000000
  %496 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.3, float 0x4024CB5EC0000000)
  %497 = tail call contract noundef float @llvm.exp.f32(float %496)
  %add1511 = fadd contract float %sum_acc.sroa.0.1, %491
  %add1511.1 = fadd contract float %sum_acc.sroa.36.1, %493
  %add1511.2 = fadd contract float %sum_acc.sroa.70.1, %495
  %add1511.3 = fadd contract float %sum_acc.sroa.104.1, %497
  %498 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %491)
  %499 = insertelement <4 x i16> poison, i16 %498, i64 0
  %500 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %493)
  %501 = insertelement <4 x i16> %499, i16 %500, i64 1
  %502 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %495)
  %503 = insertelement <4 x i16> %501, i16 %502, i64 2
  %504 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %497)
  %505 = insertelement <4 x i16> %503, i16 %504, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3045 = bitcast <4 x i16> %505 to <4 x half>
  %506 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37954485, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !111
  %507 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38164486, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.42.0), !call_argsrelate !111
  %508 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38974487, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.82.0), !call_argsrelate !111
  %509 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39184488, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.122.0), !call_argsrelate !111
  br label %if.end1547

if.end1547:                                       ; preds = %if.end1460, %if.end1401
  %acc_o.sroa.122.1 = phi <4 x float> [ %acc_o.sroa.122.0, %if.end1401 ], [ %509, %if.end1460 ]
  %acc_o.sroa.82.1 = phi <4 x float> [ %acc_o.sroa.82.0, %if.end1401 ], [ %508, %if.end1460 ]
  %acc_o.sroa.42.1 = phi <4 x float> [ %acc_o.sroa.42.0, %if.end1401 ], [ %507, %if.end1460 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1401 ], [ %506, %if.end1460 ]
  %sum_acc.sroa.104.2 = phi float [ %sum_acc.sroa.104.1, %if.end1401 ], [ %add1511.3, %if.end1460 ]
  %sum_acc.sroa.70.2 = phi float [ %sum_acc.sroa.70.1, %if.end1401 ], [ %add1511.2, %if.end1460 ]
  %sum_acc.sroa.36.2 = phi float [ %sum_acc.sroa.36.1, %if.end1401 ], [ %add1511.1, %if.end1460 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end1401 ], [ %add1511, %if.end1460 ]
  br i1 %or.cond2601, label %if.end1693, label %for.cond1555.preheader

for.cond1555.preheader:                           ; preds = %if.end1547
  %510 = shl nsw i32 %cond.i.i2393.3, 10
  %mul1562 = and i32 %510, 64512
  %add1565 = add nuw nsw i32 %add1001, %mul1562
  %511 = zext nneg i32 %add1565 to i64
  %add.ptr1570 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %511
  %V_reg.sroa.0.0.copyload37964489 = load <4 x half>, ptr addrspace(4) %add.ptr1570, align 16
  %V_reg.sroa.42.0.add.ptr1570.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1570, i64 8
  %V_reg.sroa.42.0.copyload38174490 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1570.sroa_idx, align 8
  %512 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %511
  %add.ptr1570.1 = getelementptr inbounds i8, ptr addrspace(4) %512, i64 1024
  %V_reg.sroa.74.16.copyload38984491 = load <4 x half>, ptr addrspace(4) %add.ptr1570.1, align 16
  %V_reg.sroa.114.16.add.ptr1570.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %512, i64 1032
  %V_reg.sroa.114.16.copyload39194492 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1570.1.sroa_idx, align 8
  %cmp1580 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp1580, label %for.cond1582.preheader, label %if.end1606

for.cond1582.preheader:                           ; preds = %for.cond1555.preheader
  %add1589 = add nuw nsw i32 %mul11.3, %mul1150
  %cmp1592.not = icmp sgt i32 %add1589, %1
  %fneg.2260 = select i1 %cmp1592.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3188 = insertelement <4 x float> poison, float %fneg.2260, i64 0
  %cmp1592.not.1.not = icmp slt i32 %add1589, %1
  %fneg.2260.1 = select i1 %cmp1592.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3369 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3188, float %fneg.2260.1, i64 1
  %add1590.2 = or disjoint i32 %add1589, 2
  %cmp1592.not.2 = icmp sgt i32 %add1590.2, %1
  %fneg.2260.2 = select i1 %cmp1592.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3542 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3369, float %fneg.2260.2, i64 2
  %add1590.3 = or disjoint i32 %add1589, 3
  %cmp1592.not.3 = icmp sgt i32 %add1590.3, %1
  %fneg.2260.3 = select i1 %cmp1592.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3715 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3542, float %fneg.2260.3, i64 3
  br label %if.end1606

if.end1606:                                       ; preds = %for.cond1555.preheader, %for.cond1582.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3715, %for.cond1582.preheader ], [ zeroinitializer, %for.cond1555.preheader ]
  %513 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %428, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !117
  %514 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %427, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %513), !call_argsrelate !117
  %515 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %426, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %514), !call_argsrelate !117
  %516 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %425, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %515), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3190 = extractelement <4 x float> %516, i64 0
  %mul1641 = fmul contract float %acc_s.sroa.0.0.vec.extract3190, 0x3FB99999A0000000
  %517 = tail call contract noundef float @llvm.minnum.f32(float %mul1641, float 0x4024CB5EC0000000)
  %518 = tail call contract noundef float @llvm.exp.f32(float %517)
  %acc_s.sroa.0.4.vec.extract3371 = extractelement <4 x float> %516, i64 1
  %mul1641.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3371, 0x3FB99999A0000000
  %519 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.1, float 0x4024CB5EC0000000)
  %520 = tail call contract noundef float @llvm.exp.f32(float %519)
  %acc_s.sroa.0.8.vec.extract3544 = extractelement <4 x float> %516, i64 2
  %mul1641.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3544, 0x3FB99999A0000000
  %521 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.2, float 0x4024CB5EC0000000)
  %522 = tail call contract noundef float @llvm.exp.f32(float %521)
  %acc_s.sroa.0.12.vec.extract3717 = extractelement <4 x float> %516, i64 3
  %mul1641.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3717, 0x3FB99999A0000000
  %523 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.3, float 0x4024CB5EC0000000)
  %524 = tail call contract noundef float @llvm.exp.f32(float %523)
  %add1657 = fadd contract float %sum_acc.sroa.0.2, %518
  %add1657.1 = fadd contract float %sum_acc.sroa.36.2, %520
  %add1657.2 = fadd contract float %sum_acc.sroa.70.2, %522
  %add1657.3 = fadd contract float %sum_acc.sroa.104.2, %524
  %525 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %518)
  %526 = insertelement <4 x i16> poison, i16 %525, i64 0
  %527 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %520)
  %528 = insertelement <4 x i16> %526, i16 %527, i64 1
  %529 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %522)
  %530 = insertelement <4 x i16> %528, i16 %529, i64 2
  %531 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %524)
  %532 = insertelement <4 x i16> %530, i16 %531, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3047 = bitcast <4 x i16> %532 to <4 x half>
  %533 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37964489, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !111
  %534 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38174490, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.26.0), !call_argsrelate !111
  %535 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38984491, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !111
  %536 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39194492, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.74.0), !call_argsrelate !111
  br label %if.end1693

if.end1693:                                       ; preds = %if.end1606, %if.end1547
  %acc_o_alt.sroa.74.1 = phi <4 x float> [ %acc_o_alt.sroa.74.0, %if.end1547 ], [ %536, %if.end1606 ]
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1547 ], [ %535, %if.end1606 ]
  %acc_o_alt.sroa.26.1 = phi <4 x float> [ %acc_o_alt.sroa.26.0, %if.end1547 ], [ %534, %if.end1606 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1547 ], [ %533, %if.end1606 ]
  %sum_acc.sroa.104.3 = phi float [ %sum_acc.sroa.104.2, %if.end1547 ], [ %add1657.3, %if.end1606 ]
  %sum_acc.sroa.70.3 = phi float [ %sum_acc.sroa.70.2, %if.end1547 ], [ %add1657.2, %if.end1606 ]
  %sum_acc.sroa.36.3 = phi float [ %sum_acc.sroa.36.2, %if.end1547 ], [ %add1657.1, %if.end1606 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end1547 ], [ %add1657, %if.end1606 ]
  %or.cond2594.1 = icmp ugt i32 %mul11.4, 1023
  %cmp991.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond2595.1 = or i1 %or.cond2594.1, %cmp991.not.1
  br i1 %or.cond2595.1, label %if.end1016.1, label %for.cond993.preheader.1

for.cond993.preheader.1:                          ; preds = %if.end1693
  %537 = shl nsw i32 %cond.i.i2393.4, 10
  %mul1000.1 = and i32 %537, 64512
  %add1003.1 = add nuw nsw i32 %add1001, %mul1000.1
  %538 = zext nneg i32 %add1003.1 to i64
  %add.ptr1008.12875 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %538
  %K_reg.sroa.0.0.copyload40824497 = load <4 x half>, ptr addrspace(4) %add.ptr1008.12875, align 16
  %K_reg.sroa.12.0.add.ptr1008.12875.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1008.12875, i64 8
  %K_reg.sroa.12.0.copyload40854499 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr1008.12875.sroa_idx, align 8
  %539 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %538
  %add.ptr1008.1.1 = getelementptr inbounds i8, ptr addrspace(4) %539, i64 1024
  %K_reg.sroa.20.16.copyload41004501 = load <4 x half>, ptr addrspace(4) %add.ptr1008.1.1, align 16
  %K_reg.sroa.30.16.add.ptr1008.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %539, i64 1032
  %K_reg.sroa.30.16.copyload41034503 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr1008.1.1.sroa_idx, align 8
  br label %if.end1016.1

if.end1016.1:                                     ; preds = %for.cond993.preheader.1, %if.end1693
  %540 = phi <4 x half> [ %404, %if.end1693 ], [ %K_reg.sroa.30.16.copyload41034503, %for.cond993.preheader.1 ]
  %541 = phi <4 x half> [ %405, %if.end1693 ], [ %K_reg.sroa.20.16.copyload41004501, %for.cond993.preheader.1 ]
  %542 = phi <4 x half> [ %406, %if.end1693 ], [ %K_reg.sroa.12.0.copyload40854499, %for.cond993.preheader.1 ]
  %543 = phi <4 x half> [ %407, %if.end1693 ], [ %K_reg.sroa.0.0.copyload40824497, %for.cond993.preheader.1 ]
  %or.cond2596.1 = icmp ugt i32 %mul11.5, 1023
  %cmp1022.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond2597.1 = or i1 %or.cond2596.1, %cmp1022.not.1
  br i1 %or.cond2597.1, label %if.end1047.1, label %for.cond1024.preheader.1

for.cond1024.preheader.1:                         ; preds = %if.end1016.1
  %544 = shl nsw i32 %cond.i.i2393.5, 10
  %mul1031.1 = and i32 %544, 64512
  %add1034.1 = add nuw nsw i32 %add1001, %mul1031.1
  %545 = zext nneg i32 %add1034.1 to i64
  %add.ptr1039.12876 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %545
  %K_reg1.sroa.0.0.copyload40464509 = load <4 x half>, ptr addrspace(4) %add.ptr1039.12876, align 16
  %K_reg1.sroa.12.0.add.ptr1039.12876.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1039.12876, i64 8
  %K_reg1.sroa.12.0.copyload40494511 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr1039.12876.sroa_idx, align 8
  %546 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %545
  %add.ptr1039.1.1 = getelementptr inbounds i8, ptr addrspace(4) %546, i64 1024
  %K_reg1.sroa.20.16.copyload40644513 = load <4 x half>, ptr addrspace(4) %add.ptr1039.1.1, align 16
  %K_reg1.sroa.30.16.add.ptr1039.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %546, i64 1032
  %K_reg1.sroa.30.16.copyload40674515 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr1039.1.1.sroa_idx, align 8
  br label %if.end1047.1

if.end1047.1:                                     ; preds = %for.cond1024.preheader.1, %if.end1016.1
  %547 = phi <4 x half> [ %411, %if.end1016.1 ], [ %K_reg1.sroa.30.16.copyload40674515, %for.cond1024.preheader.1 ]
  %548 = phi <4 x half> [ %412, %if.end1016.1 ], [ %K_reg1.sroa.20.16.copyload40644513, %for.cond1024.preheader.1 ]
  %549 = phi <4 x half> [ %413, %if.end1016.1 ], [ %K_reg1.sroa.12.0.copyload40494511, %for.cond1024.preheader.1 ]
  %550 = phi <4 x half> [ %414, %if.end1016.1 ], [ %K_reg1.sroa.0.0.copyload40464509, %for.cond1024.preheader.1 ]
  %or.cond2598.1 = icmp ugt i32 %mul11.6, 1023
  %cmp1053.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond2599.1 = or i1 %or.cond2598.1, %cmp1053.not.1
  br i1 %or.cond2599.1, label %if.end1078.1, label %for.cond1055.preheader.1

for.cond1055.preheader.1:                         ; preds = %if.end1047.1
  %551 = shl nsw i32 %cond.i.i2393.6, 10
  %mul1062.1 = and i32 %551, 64512
  %add1065.1 = add nuw nsw i32 %add1001, %mul1062.1
  %552 = zext nneg i32 %add1065.1 to i64
  %add.ptr1070.12877 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %552
  %K_reg2.sroa.0.0.copyload40104521 = load <4 x half>, ptr addrspace(4) %add.ptr1070.12877, align 16
  %K_reg2.sroa.12.0.add.ptr1070.12877.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1070.12877, i64 8
  %K_reg2.sroa.12.0.copyload40134523 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1070.12877.sroa_idx, align 8
  %553 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %552
  %add.ptr1070.1.1 = getelementptr inbounds i8, ptr addrspace(4) %553, i64 1024
  %K_reg2.sroa.20.16.copyload40284525 = load <4 x half>, ptr addrspace(4) %add.ptr1070.1.1, align 16
  %K_reg2.sroa.30.16.add.ptr1070.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %553, i64 1032
  %K_reg2.sroa.30.16.copyload40314527 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1070.1.1.sroa_idx, align 8
  br label %if.end1078.1

if.end1078.1:                                     ; preds = %for.cond1055.preheader.1, %if.end1047.1
  %554 = phi <4 x half> [ %418, %if.end1047.1 ], [ %K_reg2.sroa.30.16.copyload40314527, %for.cond1055.preheader.1 ]
  %555 = phi <4 x half> [ %419, %if.end1047.1 ], [ %K_reg2.sroa.20.16.copyload40284525, %for.cond1055.preheader.1 ]
  %556 = phi <4 x half> [ %420, %if.end1047.1 ], [ %K_reg2.sroa.12.0.copyload40134523, %for.cond1055.preheader.1 ]
  %557 = phi <4 x half> [ %421, %if.end1047.1 ], [ %K_reg2.sroa.0.0.copyload40104521, %for.cond1055.preheader.1 ]
  %or.cond2600.1 = icmp ugt i32 %mul11.7, 1023
  %cmp1084.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond2601.1 = or i1 %or.cond2600.1, %cmp1084.not.1
  br i1 %or.cond2601.1, label %if.end1109.1, label %for.cond1086.preheader.1

for.cond1086.preheader.1:                         ; preds = %if.end1078.1
  %558 = shl nsw i32 %cond.i.i2393.7, 10
  %mul1093.1 = and i32 %558, 64512
  %add1096.1 = add nuw nsw i32 %add1001, %mul1093.1
  %559 = zext nneg i32 %add1096.1 to i64
  %add.ptr1101.12878 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %559
  %K_reg3.sroa.0.0.copyload39744533 = load <4 x half>, ptr addrspace(4) %add.ptr1101.12878, align 16
  %K_reg3.sroa.12.0.add.ptr1101.12878.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1101.12878, i64 8
  %K_reg3.sroa.12.0.copyload39774535 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1101.12878.sroa_idx, align 8
  %560 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %559
  %add.ptr1101.1.1 = getelementptr inbounds i8, ptr addrspace(4) %560, i64 1024
  %K_reg3.sroa.20.16.copyload39924537 = load <4 x half>, ptr addrspace(4) %add.ptr1101.1.1, align 16
  %K_reg3.sroa.30.16.add.ptr1101.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %560, i64 1032
  %K_reg3.sroa.30.16.copyload39954539 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1101.1.1.sroa_idx, align 8
  br label %if.end1109.1

if.end1109.1:                                     ; preds = %for.cond1086.preheader.1, %if.end1078.1
  %561 = phi <4 x half> [ %425, %if.end1078.1 ], [ %K_reg3.sroa.30.16.copyload39954539, %for.cond1086.preheader.1 ]
  %562 = phi <4 x half> [ %426, %if.end1078.1 ], [ %K_reg3.sroa.20.16.copyload39924537, %for.cond1086.preheader.1 ]
  %563 = phi <4 x half> [ %427, %if.end1078.1 ], [ %K_reg3.sroa.12.0.copyload39774535, %for.cond1086.preheader.1 ]
  %564 = phi <4 x half> [ %428, %if.end1078.1 ], [ %K_reg3.sroa.0.0.copyload39744533, %for.cond1086.preheader.1 ]
  br i1 %or.cond2595.1, label %if.end1255.1, label %for.cond1117.preheader.1

for.cond1117.preheader.1:                         ; preds = %if.end1109.1
  %565 = shl nsw i32 %cond.i.i2393.4, 10
  %mul1124.1 = and i32 %565, 64512
  %add1127.1 = add nuw nsw i32 %add1001, %mul1124.1
  %566 = zext nneg i32 %add1127.1 to i64
  %add.ptr1132.12879 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %566
  %V_reg.sroa.0.0.copyload37974493 = load <4 x half>, ptr addrspace(4) %add.ptr1132.12879, align 16
  %V_reg.sroa.42.0.add.ptr1132.12879.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1132.12879, i64 8
  %V_reg.sroa.42.0.copyload38184494 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1132.12879.sroa_idx, align 8
  %567 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %566
  %add.ptr1132.1.1 = getelementptr inbounds i8, ptr addrspace(4) %567, i64 1024
  %V_reg.sroa.74.16.copyload38994495 = load <4 x half>, ptr addrspace(4) %add.ptr1132.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1132.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %567, i64 1032
  %V_reg.sroa.114.16.copyload39204496 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1132.1.1.sroa_idx, align 8
  %cmp1142.1 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp1142.1, label %for.cond1144.preheader.1, label %if.end1168.1

for.cond1144.preheader.1:                         ; preds = %for.cond1117.preheader.1
  %add1151.1 = add nuw nsw i32 %mul11.4, %mul1150
  %cmp1154.not.12880 = icmp sgt i32 %add1151.1, %1
  %fneg..12881 = select i1 %cmp1154.not.12880, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3200 = insertelement <4 x float> poison, float %fneg..12881, i64 0
  %cmp1154.not.1.1.not = icmp slt i32 %add1151.1, %1
  %fneg..1.1 = select i1 %cmp1154.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3379 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3200, float %fneg..1.1, i64 1
  %add1152.2.1 = or disjoint i32 %add1151.1, 2
  %cmp1154.not.2.1 = icmp sgt i32 %add1152.2.1, %1
  %fneg..2.1 = select i1 %cmp1154.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3552 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3379, float %fneg..2.1, i64 2
  %add1152.3.1 = or disjoint i32 %add1151.1, 3
  %cmp1154.not.3.1 = icmp sgt i32 %add1152.3.1, %1
  %fneg..3.1 = select i1 %cmp1154.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3725 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3552, float %fneg..3.1, i64 3
  br label %if.end1168.1

if.end1168.1:                                     ; preds = %for.cond1117.preheader.1, %for.cond1144.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3725, %for.cond1144.preheader.1 ], [ zeroinitializer, %for.cond1117.preheader.1 ]
  %568 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %543, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !117
  %569 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %542, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %568), !call_argsrelate !117
  %570 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %541, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %569), !call_argsrelate !117
  %571 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %540, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %570), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3202 = extractelement <4 x float> %571, i64 0
  %mul1203.12885 = fmul contract float %acc_s.sroa.0.0.vec.extract3202, 0x3FB99999A0000000
  %572 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.12885, float 0x4024CB5EC0000000)
  %573 = tail call contract noundef float @llvm.exp.f32(float %572)
  %acc_s.sroa.0.4.vec.extract3381 = extractelement <4 x float> %571, i64 1
  %mul1203.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3381, 0x3FB99999A0000000
  %574 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.1.1, float 0x4024CB5EC0000000)
  %575 = tail call contract noundef float @llvm.exp.f32(float %574)
  %acc_s.sroa.0.8.vec.extract3554 = extractelement <4 x float> %571, i64 2
  %mul1203.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3554, 0x3FB99999A0000000
  %576 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.2.1, float 0x4024CB5EC0000000)
  %577 = tail call contract noundef float @llvm.exp.f32(float %576)
  %acc_s.sroa.0.12.vec.extract3727 = extractelement <4 x float> %571, i64 3
  %mul1203.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3727, 0x3FB99999A0000000
  %578 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.3.1, float 0x4024CB5EC0000000)
  %579 = tail call contract noundef float @llvm.exp.f32(float %578)
  %add1219.12886 = fadd contract float %sum_acc.sroa.0.3, %573
  %add1219.1.1 = fadd contract float %sum_acc.sroa.36.3, %575
  %add1219.2.1 = fadd contract float %sum_acc.sroa.70.3, %577
  %add1219.3.1 = fadd contract float %sum_acc.sroa.104.3, %579
  %580 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %573)
  %581 = insertelement <4 x i16> poison, i16 %580, i64 0
  %582 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %575)
  %583 = insertelement <4 x i16> %581, i16 %582, i64 1
  %584 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %577)
  %585 = insertelement <4 x i16> %583, i16 %584, i64 2
  %586 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %579)
  %587 = insertelement <4 x i16> %585, i16 %586, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3049 = bitcast <4 x i16> %587 to <4 x half>
  %588 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37974493, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.0.1), !call_argsrelate !111
  %589 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38184494, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.42.1), !call_argsrelate !111
  %590 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38994495, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.82.1), !call_argsrelate !111
  %591 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39204496, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.122.1), !call_argsrelate !111
  br label %if.end1255.1

if.end1255.1:                                     ; preds = %if.end1168.1, %if.end1109.1
  %acc_o.sroa.122.2 = phi <4 x float> [ %acc_o.sroa.122.1, %if.end1109.1 ], [ %591, %if.end1168.1 ]
  %acc_o.sroa.82.2 = phi <4 x float> [ %acc_o.sroa.82.1, %if.end1109.1 ], [ %590, %if.end1168.1 ]
  %acc_o.sroa.42.2 = phi <4 x float> [ %acc_o.sroa.42.1, %if.end1109.1 ], [ %589, %if.end1168.1 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1109.1 ], [ %588, %if.end1168.1 ]
  %sum_acc.sroa.104.4 = phi float [ %sum_acc.sroa.104.3, %if.end1109.1 ], [ %add1219.3.1, %if.end1168.1 ]
  %sum_acc.sroa.70.4 = phi float [ %sum_acc.sroa.70.3, %if.end1109.1 ], [ %add1219.2.1, %if.end1168.1 ]
  %sum_acc.sroa.36.4 = phi float [ %sum_acc.sroa.36.3, %if.end1109.1 ], [ %add1219.1.1, %if.end1168.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end1109.1 ], [ %add1219.12886, %if.end1168.1 ]
  br i1 %or.cond2597.1, label %if.end1401.1, label %for.cond1263.preheader.1

for.cond1263.preheader.1:                         ; preds = %if.end1255.1
  %592 = shl nsw i32 %cond.i.i2393.5, 10
  %mul1270.1 = and i32 %592, 64512
  %add1273.1 = add nuw nsw i32 %add1001, %mul1270.1
  %593 = zext nneg i32 %add1273.1 to i64
  %add.ptr1278.12887 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %593
  %V_reg.sroa.0.0.copyload37984505 = load <4 x half>, ptr addrspace(4) %add.ptr1278.12887, align 16
  %V_reg.sroa.42.0.add.ptr1278.12887.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1278.12887, i64 8
  %V_reg.sroa.42.0.copyload38194506 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1278.12887.sroa_idx, align 8
  %594 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %593
  %add.ptr1278.1.1 = getelementptr inbounds i8, ptr addrspace(4) %594, i64 1024
  %V_reg.sroa.74.16.copyload39004507 = load <4 x half>, ptr addrspace(4) %add.ptr1278.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1278.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %594, i64 1032
  %V_reg.sroa.114.16.copyload39214508 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1278.1.1.sroa_idx, align 8
  %cmp1288.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp1288.1, label %for.cond1290.preheader.1, label %if.end1314.1

for.cond1290.preheader.1:                         ; preds = %for.cond1263.preheader.1
  %add1297.1 = add nuw nsw i32 %mul11.5, %mul1150
  %cmp1300.not.12888 = icmp sgt i32 %add1297.1, %1
  %fneg.2258.12889 = select i1 %cmp1300.not.12888, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3212 = insertelement <4 x float> poison, float %fneg.2258.12889, i64 0
  %cmp1300.not.1.1.not = icmp slt i32 %add1297.1, %1
  %fneg.2258.1.1 = select i1 %cmp1300.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3389 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3212, float %fneg.2258.1.1, i64 1
  %add1298.2.1 = or disjoint i32 %add1297.1, 2
  %cmp1300.not.2.1 = icmp sgt i32 %add1298.2.1, %1
  %fneg.2258.2.1 = select i1 %cmp1300.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3562 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3389, float %fneg.2258.2.1, i64 2
  %add1298.3.1 = or disjoint i32 %add1297.1, 3
  %cmp1300.not.3.1 = icmp sgt i32 %add1298.3.1, %1
  %fneg.2258.3.1 = select i1 %cmp1300.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3735 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3562, float %fneg.2258.3.1, i64 3
  br label %if.end1314.1

if.end1314.1:                                     ; preds = %for.cond1263.preheader.1, %for.cond1290.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3735, %for.cond1290.preheader.1 ], [ zeroinitializer, %for.cond1263.preheader.1 ]
  %595 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %550, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !117
  %596 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %549, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %595), !call_argsrelate !117
  %597 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %548, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %596), !call_argsrelate !117
  %598 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %547, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %597), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3214 = extractelement <4 x float> %598, i64 0
  %mul1349.12893 = fmul contract float %acc_s.sroa.0.0.vec.extract3214, 0x3FB99999A0000000
  %599 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.12893, float 0x4024CB5EC0000000)
  %600 = tail call contract noundef float @llvm.exp.f32(float %599)
  %acc_s.sroa.0.4.vec.extract3391 = extractelement <4 x float> %598, i64 1
  %mul1349.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3391, 0x3FB99999A0000000
  %601 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.1.1, float 0x4024CB5EC0000000)
  %602 = tail call contract noundef float @llvm.exp.f32(float %601)
  %acc_s.sroa.0.8.vec.extract3564 = extractelement <4 x float> %598, i64 2
  %mul1349.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3564, 0x3FB99999A0000000
  %603 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.2.1, float 0x4024CB5EC0000000)
  %604 = tail call contract noundef float @llvm.exp.f32(float %603)
  %acc_s.sroa.0.12.vec.extract3737 = extractelement <4 x float> %598, i64 3
  %mul1349.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3737, 0x3FB99999A0000000
  %605 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.3.1, float 0x4024CB5EC0000000)
  %606 = tail call contract noundef float @llvm.exp.f32(float %605)
  %add1365.12894 = fadd contract float %sum_acc.sroa.0.4, %600
  %add1365.1.1 = fadd contract float %sum_acc.sroa.36.4, %602
  %add1365.2.1 = fadd contract float %sum_acc.sroa.70.4, %604
  %add1365.3.1 = fadd contract float %sum_acc.sroa.104.4, %606
  %607 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %600)
  %608 = insertelement <4 x i16> poison, i16 %607, i64 0
  %609 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %602)
  %610 = insertelement <4 x i16> %608, i16 %609, i64 1
  %611 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %604)
  %612 = insertelement <4 x i16> %610, i16 %611, i64 2
  %613 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %606)
  %614 = insertelement <4 x i16> %612, i16 %613, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3051 = bitcast <4 x i16> %614 to <4 x half>
  %615 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37984505, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !111
  %616 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38194506, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.26.1), !call_argsrelate !111
  %617 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload39004507, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !111
  %618 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39214508, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.74.1), !call_argsrelate !111
  br label %if.end1401.1

if.end1401.1:                                     ; preds = %if.end1314.1, %if.end1255.1
  %acc_o_alt.sroa.74.2 = phi <4 x float> [ %acc_o_alt.sroa.74.1, %if.end1255.1 ], [ %618, %if.end1314.1 ]
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1255.1 ], [ %617, %if.end1314.1 ]
  %acc_o_alt.sroa.26.2 = phi <4 x float> [ %acc_o_alt.sroa.26.1, %if.end1255.1 ], [ %616, %if.end1314.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1255.1 ], [ %615, %if.end1314.1 ]
  %sum_acc.sroa.104.5 = phi float [ %sum_acc.sroa.104.4, %if.end1255.1 ], [ %add1365.3.1, %if.end1314.1 ]
  %sum_acc.sroa.70.5 = phi float [ %sum_acc.sroa.70.4, %if.end1255.1 ], [ %add1365.2.1, %if.end1314.1 ]
  %sum_acc.sroa.36.5 = phi float [ %sum_acc.sroa.36.4, %if.end1255.1 ], [ %add1365.1.1, %if.end1314.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end1255.1 ], [ %add1365.12894, %if.end1314.1 ]
  br i1 %or.cond2599.1, label %if.end1547.1, label %for.cond1409.preheader.1

for.cond1409.preheader.1:                         ; preds = %if.end1401.1
  %619 = shl nsw i32 %cond.i.i2393.6, 10
  %mul1416.1 = and i32 %619, 64512
  %add1419.1 = add nuw nsw i32 %add1001, %mul1416.1
  %620 = zext nneg i32 %add1419.1 to i64
  %add.ptr1424.12895 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %620
  %V_reg.sroa.0.0.copyload37994517 = load <4 x half>, ptr addrspace(4) %add.ptr1424.12895, align 16
  %V_reg.sroa.42.0.add.ptr1424.12895.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1424.12895, i64 8
  %V_reg.sroa.42.0.copyload38204518 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1424.12895.sroa_idx, align 8
  %621 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %620
  %add.ptr1424.1.1 = getelementptr inbounds i8, ptr addrspace(4) %621, i64 1024
  %V_reg.sroa.74.16.copyload39014519 = load <4 x half>, ptr addrspace(4) %add.ptr1424.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1424.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %621, i64 1032
  %V_reg.sroa.114.16.copyload39224520 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1424.1.1.sroa_idx, align 8
  %cmp1434.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp1434.1, label %for.cond1436.preheader.1, label %if.end1460.1

for.cond1436.preheader.1:                         ; preds = %for.cond1409.preheader.1
  %add1443.1 = add nuw nsw i32 %mul11.6, %mul1150
  %cmp1446.not.12896 = icmp sgt i32 %add1443.1, %1
  %fneg.2259.12897 = select i1 %cmp1446.not.12896, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3224 = insertelement <4 x float> poison, float %fneg.2259.12897, i64 0
  %cmp1446.not.1.1.not = icmp slt i32 %add1443.1, %1
  %fneg.2259.1.1 = select i1 %cmp1446.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3399 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3224, float %fneg.2259.1.1, i64 1
  %add1444.2.1 = or disjoint i32 %add1443.1, 2
  %cmp1446.not.2.1 = icmp sgt i32 %add1444.2.1, %1
  %fneg.2259.2.1 = select i1 %cmp1446.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3572 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3399, float %fneg.2259.2.1, i64 2
  %add1444.3.1 = or disjoint i32 %add1443.1, 3
  %cmp1446.not.3.1 = icmp sgt i32 %add1444.3.1, %1
  %fneg.2259.3.1 = select i1 %cmp1446.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3745 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3572, float %fneg.2259.3.1, i64 3
  br label %if.end1460.1

if.end1460.1:                                     ; preds = %for.cond1409.preheader.1, %for.cond1436.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3745, %for.cond1436.preheader.1 ], [ zeroinitializer, %for.cond1409.preheader.1 ]
  %622 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %557, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !117
  %623 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %556, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %622), !call_argsrelate !117
  %624 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %555, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %623), !call_argsrelate !117
  %625 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %554, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %624), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3226 = extractelement <4 x float> %625, i64 0
  %mul1495.12901 = fmul contract float %acc_s.sroa.0.0.vec.extract3226, 0x3FB99999A0000000
  %626 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.12901, float 0x4024CB5EC0000000)
  %627 = tail call contract noundef float @llvm.exp.f32(float %626)
  %acc_s.sroa.0.4.vec.extract3401 = extractelement <4 x float> %625, i64 1
  %mul1495.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3401, 0x3FB99999A0000000
  %628 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.1.1, float 0x4024CB5EC0000000)
  %629 = tail call contract noundef float @llvm.exp.f32(float %628)
  %acc_s.sroa.0.8.vec.extract3574 = extractelement <4 x float> %625, i64 2
  %mul1495.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3574, 0x3FB99999A0000000
  %630 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.2.1, float 0x4024CB5EC0000000)
  %631 = tail call contract noundef float @llvm.exp.f32(float %630)
  %acc_s.sroa.0.12.vec.extract3747 = extractelement <4 x float> %625, i64 3
  %mul1495.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3747, 0x3FB99999A0000000
  %632 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.3.1, float 0x4024CB5EC0000000)
  %633 = tail call contract noundef float @llvm.exp.f32(float %632)
  %add1511.12902 = fadd contract float %sum_acc.sroa.0.5, %627
  %add1511.1.1 = fadd contract float %sum_acc.sroa.36.5, %629
  %add1511.2.1 = fadd contract float %sum_acc.sroa.70.5, %631
  %add1511.3.1 = fadd contract float %sum_acc.sroa.104.5, %633
  %634 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %627)
  %635 = insertelement <4 x i16> poison, i16 %634, i64 0
  %636 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %629)
  %637 = insertelement <4 x i16> %635, i16 %636, i64 1
  %638 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %631)
  %639 = insertelement <4 x i16> %637, i16 %638, i64 2
  %640 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %633)
  %641 = insertelement <4 x i16> %639, i16 %640, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3053 = bitcast <4 x i16> %641 to <4 x half>
  %642 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37994517, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !111
  %643 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38204518, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.42.2), !call_argsrelate !111
  %644 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload39014519, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.82.2), !call_argsrelate !111
  %645 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39224520, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.122.2), !call_argsrelate !111
  br label %if.end1547.1

if.end1547.1:                                     ; preds = %if.end1460.1, %if.end1401.1
  %acc_o.sroa.122.3 = phi <4 x float> [ %acc_o.sroa.122.2, %if.end1401.1 ], [ %645, %if.end1460.1 ]
  %acc_o.sroa.82.3 = phi <4 x float> [ %acc_o.sroa.82.2, %if.end1401.1 ], [ %644, %if.end1460.1 ]
  %acc_o.sroa.42.3 = phi <4 x float> [ %acc_o.sroa.42.2, %if.end1401.1 ], [ %643, %if.end1460.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end1401.1 ], [ %642, %if.end1460.1 ]
  %sum_acc.sroa.104.6 = phi float [ %sum_acc.sroa.104.5, %if.end1401.1 ], [ %add1511.3.1, %if.end1460.1 ]
  %sum_acc.sroa.70.6 = phi float [ %sum_acc.sroa.70.5, %if.end1401.1 ], [ %add1511.2.1, %if.end1460.1 ]
  %sum_acc.sroa.36.6 = phi float [ %sum_acc.sroa.36.5, %if.end1401.1 ], [ %add1511.1.1, %if.end1460.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end1401.1 ], [ %add1511.12902, %if.end1460.1 ]
  br i1 %or.cond2601.1, label %if.end1697, label %for.cond1555.preheader.1

for.cond1555.preheader.1:                         ; preds = %if.end1547.1
  %646 = shl nsw i32 %cond.i.i2393.7, 10
  %mul1562.1 = and i32 %646, 64512
  %add1565.1 = add nuw nsw i32 %add1001, %mul1562.1
  %647 = zext nneg i32 %add1565.1 to i64
  %add.ptr1570.12903 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %647
  %V_reg.sroa.0.0.copyload38004529 = load <4 x half>, ptr addrspace(4) %add.ptr1570.12903, align 16
  %V_reg.sroa.42.0.add.ptr1570.12903.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1570.12903, i64 8
  %V_reg.sroa.42.0.copyload38214530 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1570.12903.sroa_idx, align 8
  %648 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %647
  %add.ptr1570.1.1 = getelementptr inbounds i8, ptr addrspace(4) %648, i64 1024
  %V_reg.sroa.74.16.copyload39024531 = load <4 x half>, ptr addrspace(4) %add.ptr1570.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1570.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %648, i64 1032
  %V_reg.sroa.114.16.copyload39234532 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1570.1.1.sroa_idx, align 8
  %cmp1580.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp1580.1, label %for.cond1582.preheader.1, label %if.end1606.1

for.cond1582.preheader.1:                         ; preds = %for.cond1555.preheader.1
  %add1589.1 = add nuw nsw i32 %mul11.7, %mul1150
  %cmp1592.not.12904 = icmp sgt i32 %add1589.1, %1
  %fneg.2260.12905 = select i1 %cmp1592.not.12904, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3236 = insertelement <4 x float> poison, float %fneg.2260.12905, i64 0
  %cmp1592.not.1.1.not = icmp slt i32 %add1589.1, %1
  %fneg.2260.1.1 = select i1 %cmp1592.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3409 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3236, float %fneg.2260.1.1, i64 1
  %add1590.2.1 = or disjoint i32 %add1589.1, 2
  %cmp1592.not.2.1 = icmp sgt i32 %add1590.2.1, %1
  %fneg.2260.2.1 = select i1 %cmp1592.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3582 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3409, float %fneg.2260.2.1, i64 2
  %add1590.3.1 = or disjoint i32 %add1589.1, 3
  %cmp1592.not.3.1 = icmp sgt i32 %add1590.3.1, %1
  %fneg.2260.3.1 = select i1 %cmp1592.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3755 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3582, float %fneg.2260.3.1, i64 3
  br label %if.end1606.1

if.end1606.1:                                     ; preds = %for.cond1555.preheader.1, %for.cond1582.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3755, %for.cond1582.preheader.1 ], [ zeroinitializer, %for.cond1555.preheader.1 ]
  %649 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %564, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !117
  %650 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %563, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %649), !call_argsrelate !117
  %651 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %562, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %650), !call_argsrelate !117
  %652 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %561, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %651), !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3238 = extractelement <4 x float> %652, i64 0
  %mul1641.12909 = fmul contract float %acc_s.sroa.0.0.vec.extract3238, 0x3FB99999A0000000
  %653 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.12909, float 0x4024CB5EC0000000)
  %654 = tail call contract noundef float @llvm.exp.f32(float %653)
  %acc_s.sroa.0.4.vec.extract3411 = extractelement <4 x float> %652, i64 1
  %mul1641.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3411, 0x3FB99999A0000000
  %655 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.1.1, float 0x4024CB5EC0000000)
  %656 = tail call contract noundef float @llvm.exp.f32(float %655)
  %acc_s.sroa.0.8.vec.extract3584 = extractelement <4 x float> %652, i64 2
  %mul1641.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3584, 0x3FB99999A0000000
  %657 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.2.1, float 0x4024CB5EC0000000)
  %658 = tail call contract noundef float @llvm.exp.f32(float %657)
  %acc_s.sroa.0.12.vec.extract3757 = extractelement <4 x float> %652, i64 3
  %mul1641.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3757, 0x3FB99999A0000000
  %659 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.3.1, float 0x4024CB5EC0000000)
  %660 = tail call contract noundef float @llvm.exp.f32(float %659)
  %add1657.12910 = fadd contract float %sum_acc.sroa.0.6, %654
  %add1657.1.1 = fadd contract float %sum_acc.sroa.36.6, %656
  %add1657.2.1 = fadd contract float %sum_acc.sroa.70.6, %658
  %add1657.3.1 = fadd contract float %sum_acc.sroa.104.6, %660
  %661 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %654)
  %662 = insertelement <4 x i16> poison, i16 %661, i64 0
  %663 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %656)
  %664 = insertelement <4 x i16> %662, i16 %663, i64 1
  %665 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %658)
  %666 = insertelement <4 x i16> %664, i16 %665, i64 2
  %667 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %660)
  %668 = insertelement <4 x i16> %666, i16 %667, i64 3
  %acc_s_cast.sroa.0.6.vec.insert3055 = bitcast <4 x i16> %668 to <4 x half>
  %669 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload38004529, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !111
  %670 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38214530, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.26.2), !call_argsrelate !111
  %671 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload39024531, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !111
  %672 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39234532, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.74.2), !call_argsrelate !111
  br label %if.end1697

if.end1697:                                       ; preds = %if.end1547.1, %if.end1606.1, %if.end865.1.1
  %.pre-phi4476 = phi i32 [ %22, %if.end865.1.1 ], [ %mul1005, %if.end1606.1 ], [ %mul1005, %if.end1547.1 ]
  %.pre-phi = phi i32 [ %.pre, %if.end865.1.1 ], [ %400, %if.end1606.1 ], [ %400, %if.end1547.1 ]
  %acc_o.sroa.122.4 = phi <4 x float> [ %363, %if.end865.1.1 ], [ %acc_o.sroa.122.3, %if.end1606.1 ], [ %acc_o.sroa.122.3, %if.end1547.1 ]
  %acc_o.sroa.82.4 = phi <4 x float> [ %362, %if.end865.1.1 ], [ %acc_o.sroa.82.3, %if.end1606.1 ], [ %acc_o.sroa.82.3, %if.end1547.1 ]
  %acc_o.sroa.42.4 = phi <4 x float> [ %361, %if.end865.1.1 ], [ %acc_o.sroa.42.3, %if.end1606.1 ], [ %acc_o.sroa.42.3, %if.end1547.1 ]
  %acc_o.sroa.0.4 = phi <4 x float> [ %360, %if.end865.1.1 ], [ %acc_o.sroa.0.3, %if.end1606.1 ], [ %acc_o.sroa.0.3, %if.end1547.1 ]
  %acc_o_alt.sroa.74.4 = phi <4 x float> [ %399, %if.end865.1.1 ], [ %672, %if.end1606.1 ], [ %acc_o_alt.sroa.74.2, %if.end1547.1 ]
  %acc_o_alt.sroa.50.4 = phi <4 x float> [ %398, %if.end865.1.1 ], [ %671, %if.end1606.1 ], [ %acc_o_alt.sroa.50.2, %if.end1547.1 ]
  %acc_o_alt.sroa.26.4 = phi <4 x float> [ %397, %if.end865.1.1 ], [ %670, %if.end1606.1 ], [ %acc_o_alt.sroa.26.2, %if.end1547.1 ]
  %acc_o_alt.sroa.0.4 = phi <4 x float> [ %396, %if.end865.1.1 ], [ %669, %if.end1606.1 ], [ %acc_o_alt.sroa.0.2, %if.end1547.1 ]
  %sum_acc.sroa.104.8 = phi float [ %add927.3.1, %if.end865.1.1 ], [ %add1657.3.1, %if.end1606.1 ], [ %sum_acc.sroa.104.6, %if.end1547.1 ]
  %sum_acc.sroa.70.8 = phi float [ %add927.2.1, %if.end865.1.1 ], [ %add1657.2.1, %if.end1606.1 ], [ %sum_acc.sroa.70.6, %if.end1547.1 ]
  %sum_acc.sroa.36.8 = phi float [ %add927.1.1, %if.end865.1.1 ], [ %add1657.1.1, %if.end1606.1 ], [ %sum_acc.sroa.36.6, %if.end1547.1 ]
  %sum_acc.sroa.0.8 = phi float [ %add927.12834, %if.end865.1.1 ], [ %add1657.12910, %if.end1606.1 ], [ %sum_acc.sroa.0.6, %if.end1547.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 0
  %add1706 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 1
  %add1706.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 2
  %add1706.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 3
  %add1706.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.42.16.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 0
  %acc_o_alt.sroa.26.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 0
  %add1706.4 = fadd contract float %acc_o.sroa.42.16.vec.extract, %acc_o_alt.sroa.26.16.vec.extract
  %acc_o.sroa.42.20.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 1
  %acc_o_alt.sroa.26.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 1
  %add1706.5 = fadd contract float %acc_o.sroa.42.20.vec.extract, %acc_o_alt.sroa.26.20.vec.extract
  %acc_o.sroa.42.24.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 2
  %acc_o_alt.sroa.26.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 2
  %add1706.6 = fadd contract float %acc_o.sroa.42.24.vec.extract, %acc_o_alt.sroa.26.24.vec.extract
  %acc_o.sroa.42.28.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 3
  %acc_o_alt.sroa.26.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 3
  %add1706.7 = fadd contract float %acc_o.sroa.42.28.vec.extract, %acc_o_alt.sroa.26.28.vec.extract
  %acc_o.sroa.82.32.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 0
  %acc_o_alt.sroa.50.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 0
  %add1706.8 = fadd contract float %acc_o.sroa.82.32.vec.extract, %acc_o_alt.sroa.50.32.vec.extract
  %acc_o.sroa.82.36.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 1
  %acc_o_alt.sroa.50.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 1
  %add1706.9 = fadd contract float %acc_o.sroa.82.36.vec.extract, %acc_o_alt.sroa.50.36.vec.extract
  %acc_o.sroa.82.40.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 2
  %acc_o_alt.sroa.50.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 2
  %add1706.10 = fadd contract float %acc_o.sroa.82.40.vec.extract, %acc_o_alt.sroa.50.40.vec.extract
  %acc_o.sroa.82.44.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 3
  %acc_o_alt.sroa.50.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 3
  %add1706.11 = fadd contract float %acc_o.sroa.82.44.vec.extract, %acc_o_alt.sroa.50.44.vec.extract
  %acc_o.sroa.122.48.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 0
  %acc_o_alt.sroa.74.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 0
  %add1706.12 = fadd contract float %acc_o.sroa.122.48.vec.extract, %acc_o_alt.sroa.74.48.vec.extract
  %acc_o.sroa.122.52.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 1
  %acc_o_alt.sroa.74.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 1
  %add1706.13 = fadd contract float %acc_o.sroa.122.52.vec.extract, %acc_o_alt.sroa.74.52.vec.extract
  %acc_o.sroa.122.56.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 2
  %acc_o_alt.sroa.74.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 2
  %add1706.14 = fadd contract float %acc_o.sroa.122.56.vec.extract, %acc_o_alt.sroa.74.56.vec.extract
  %acc_o.sroa.122.60.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 3
  %acc_o_alt.sroa.74.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 3
  %add1706.15 = fadd contract float %acc_o.sroa.122.60.vec.extract, %acc_o_alt.sroa.74.60.vec.extract
  %add1720 = fadd contract float %sum_acc.sroa.0.8, 0.000000e+00
  %add1720.1 = fadd contract float %add1720, %sum_acc.sroa.36.8
  %add1720.2 = fadd contract float %add1720.1, %sum_acc.sroa.70.8
  %add1720.3 = fadd contract float %add1720.2, %sum_acc.sroa.104.8
  %673 = bitcast float %add1720.3 to i32
  %674 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %675 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %674) #11
  %xor.i.i = xor i32 %675, 32
  %676 = and i32 %675, -64
  %and.i.i = add nsw i32 %676, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2422 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %675
  %shl.i.i = shl i32 %cond.i.i2422, 2
  %677 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %673)
  %678 = bitcast i32 %677 to float
  %add.i = fadd contract float %add1720.3, %678
  %679 = bitcast float %add.i to i32
  %680 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %681 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %680) #11
  %xor.i.i2423 = xor i32 %681, 16
  %682 = and i32 %681, -64
  %and.i.i2424 = add nsw i32 %682, 64
  %cmp.not.i.i2425 = icmp slt i32 %xor.i.i2423, %and.i.i2424
  %cond.i.i2426 = select i1 %cmp.not.i.i2425, i32 %xor.i.i2423, i32 %681
  %shl.i.i2427 = shl i32 %cond.i.i2426, 2
  %683 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2427, i32 %679)
  %684 = bitcast i32 %683 to float
  %add.i.i = fadd contract float %add.i, %684
  %cmp1729 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_12.0 = select i1 %cmp1729, float %div, float 0.000000e+00
  %mul1742 = fmul contract float %condval_12.0, %add1706
  %mul1742.1 = fmul contract float %condval_12.0, %add1706.1
  %mul1742.2 = fmul contract float %condval_12.0, %add1706.2
  %mul1742.3 = fmul contract float %condval_12.0, %add1706.3
  %mul1742.4 = fmul contract float %condval_12.0, %add1706.4
  %mul1742.5 = fmul contract float %condval_12.0, %add1706.5
  %mul1742.6 = fmul contract float %condval_12.0, %add1706.6
  %mul1742.7 = fmul contract float %condval_12.0, %add1706.7
  %mul1742.8 = fmul contract float %condval_12.0, %add1706.8
  %mul1742.9 = fmul contract float %condval_12.0, %add1706.9
  %mul1742.10 = fmul contract float %condval_12.0, %add1706.10
  %mul1742.11 = fmul contract float %condval_12.0, %add1706.11
  %mul1742.12 = fmul contract float %condval_12.0, %add1706.12
  %mul1742.13 = fmul contract float %condval_12.0, %add1706.13
  %mul1742.14 = fmul contract float %condval_12.0, %add1706.14
  %mul1742.15 = fmul contract float %condval_12.0, %add1706.15
  %685 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742)
  %O_reg.sroa.0.0.insert.ext = zext i16 %685 to i64
  %686 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %686 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %687 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %687 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %688 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %688 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %689 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %689 to i64
  %690 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %690 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %691 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %691 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %692 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %692 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %693 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %693 to i64
  %694 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %694 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %695 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %695 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %696 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %696 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %697 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %697 to i64
  %698 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %698 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %699 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %699 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %700 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %700 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1784 = lshr i32 %18, 5
  %and1787 = and i32 %18, 7
  %mul1793 = and i32 %.pre-phi, 4
  %xor = xor i32 %shr1784, %and1787
  %mul1788 = shl nuw nsw i32 %xor, 3
  %add1789 = add nuw nsw i32 %mul1788, %mul25
  %add1794 = or disjoint i32 %add1789, %mul1793
  %add.ptr1796 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1796, align 8
  %add1785.1 = add nuw nsw i32 %shr1784, 2
  %xor.1 = xor i32 %add1785.1, %and1787
  %mul1788.1 = shl nuw nsw i32 %xor.1, 3
  %add1789.1 = add nuw nsw i32 %mul1788.1, %mul25
  %add1794.1 = or disjoint i32 %add1789.1, %mul1793
  %add.ptr1796.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1796.1, align 8
  %add1785.2 = add nuw nsw i32 %shr1784, 4
  %xor.2 = xor i32 %add1785.2, %and1787
  %mul1788.2 = shl nuw nsw i32 %xor.2, 3
  %add1789.2 = add nuw nsw i32 %mul1788.2, %mul25
  %add1794.2 = or disjoint i32 %add1789.2, %mul1793
  %add.ptr1796.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1796.2, align 8
  %add1785.3 = add nuw nsw i32 %shr1784, 6
  %xor.3 = xor i32 %add1785.3, %and1787
  %mul1788.3 = shl nuw nsw i32 %xor.3, 3
  %add1789.3 = add nuw nsw i32 %mul1788.3, %mul25
  %add1794.3 = or disjoint i32 %add1789.3, %mul1793
  %add.ptr1796.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1796.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul1807 = and i32 %.pre-phi4476, 8128
  %xor18132256 = and i32 %.pre-phi4476, 56
  %call1811.masked = and i32 %18, 1016
  %mul1814 = xor i32 %xor18132256, %call1811.masked
  %invariant.gep2588 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1807
  %invariant.gep2590 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep2588, i32 %mul1814
  %add1824 = add nuw nsw i32 %add23, %.pre-phi4476
  %701 = zext nneg i32 %add1824 to i64
  %add.ptr1829 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %701
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1829, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2590, i64 16, i1 false), !tbaa.struct !361, !call_argsrelate !362
  %gep2591.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2590, i32 1024
  %702 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %701
  %add.ptr1829.1 = getelementptr inbounds i8, ptr addrspace(1) %702, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1829.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2591.1, i64 16, i1 false), !tbaa.struct !361, !call_argsrelate !362
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


