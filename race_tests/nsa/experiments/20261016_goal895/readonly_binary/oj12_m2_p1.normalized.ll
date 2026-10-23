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
  %cond.i.i1211 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i1211, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i1211.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i1211.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i1211.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i1211.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i1211.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i1211.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i1211.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i1211.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i1211.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i1211.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i1211.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i1211.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i1211.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i1211.7, 4
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
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8
  %mul101 = shl nsw i32 %0, 16
  %mul109 = shl nuw nsw i32 %18, 3
  %add104 = or disjoint i32 %mul109, %mul101
  %invariant.op = add nsw i32 %1, -15
  %22 = lshr i32 %18, 2
  %mul270 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp94.not = icmp sgt i32 %mul11, %1
  %or.cond1287 = or i1 %or.cond, %cmp94.not
  br i1 %or.cond1287, label %if.end, label %for.cond95.preheader

for.cond95.preheader:                             ; preds = %entry
  %23 = shl nsw i32 %cond.i.i1211, 10
  %mul103 = and i32 %23, 64512
  %add107 = add nuw nsw i32 %add104, %mul103
  %idxprom113 = zext nneg i32 %add107 to i64
  %arrayidx114 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113
  %24 = load <4 x half>, ptr addrspace(4) %arrayidx114, align 2, !tbaa !62
  %add110.4 = or disjoint i32 %add107, 4
  %idxprom113.4 = zext nneg i32 %add110.4 to i64
  %arrayidx114.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113.4
  %25 = load <4 x half>, ptr addrspace(4) %arrayidx114.4, align 2, !tbaa !62
  %26 = zext nneg i32 %add107 to i64
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %arrayidx114.8 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024
  %28 = load <4 x half>, ptr addrspace(4) %arrayidx114.8, align 2, !tbaa !62
  %29 = zext nneg i32 %add107 to i64
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29
  %arrayidx114.12 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032
  %31 = load <4 x half>, ptr addrspace(4) %arrayidx114.12, align 2, !tbaa !62
  br label %if.end

if.end:                                           ; preds = %for.cond95.preheader, %entry
  %K_reg.sroa.32.0 = phi <4 x half> [ undef, %entry ], [ %31, %for.cond95.preheader ]
  %K_reg.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %28, %for.cond95.preheader ]
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %25, %for.cond95.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %24, %for.cond95.preheader ]
  %or.cond1288 = icmp ugt i32 %mul11.1, 1023
  %cmp126.not = icmp sgt i32 %mul11.1, %1
  %or.cond1289 = or i1 %or.cond1288, %cmp126.not
  br i1 %or.cond1289, label %if.end155, label %for.cond128.preheader

for.cond128.preheader:                            ; preds = %if.end
  %32 = shl nsw i32 %cond.i.i1211.1, 10
  %mul136 = and i32 %32, 64512
  %add140 = add nuw nsw i32 %add104, %mul136
  %idxprom146 = zext nneg i32 %add140 to i64
  %arrayidx147 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146
  %33 = load <4 x half>, ptr addrspace(4) %arrayidx147, align 2, !tbaa !62
  %add143.4 = or disjoint i32 %add140, 4
  %idxprom146.4 = zext nneg i32 %add143.4 to i64
  %arrayidx147.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146.4
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx147.4, align 2, !tbaa !62
  %35 = zext nneg i32 %add140 to i64
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %35
  %arrayidx147.8 = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1024
  %37 = load <4 x half>, ptr addrspace(4) %arrayidx147.8, align 2, !tbaa !62
  %38 = zext nneg i32 %add140 to i64
  %39 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %38
  %arrayidx147.12 = getelementptr inbounds i8, ptr addrspace(4) %39, i64 1032
  %40 = load <4 x half>, ptr addrspace(4) %arrayidx147.12, align 2, !tbaa !62
  br label %if.end155

if.end155:                                        ; preds = %for.cond128.preheader, %if.end
  %K_reg1.sroa.32.0 = phi <4 x half> [ undef, %if.end ], [ %40, %for.cond128.preheader ]
  %K_reg1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %37, %for.cond128.preheader ]
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %34, %for.cond128.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %33, %for.cond128.preheader ]
  %or.cond1290 = icmp ugt i32 %mul11.2, 1023
  %cmp161.not = icmp sgt i32 %mul11.2, %1
  %or.cond1291 = or i1 %or.cond1290, %cmp161.not
  br i1 %or.cond1291, label %if.end190, label %for.cond163.preheader

for.cond163.preheader:                            ; preds = %if.end155
  %41 = shl nsw i32 %cond.i.i1211.2, 10
  %mul171 = and i32 %41, 64512
  %add175 = add nuw nsw i32 %add104, %mul171
  %idxprom181 = zext nneg i32 %add175 to i64
  %arrayidx182 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181
  %42 = load <4 x half>, ptr addrspace(4) %arrayidx182, align 2, !tbaa !62
  %add178.4 = or disjoint i32 %add175, 4
  %idxprom181.4 = zext nneg i32 %add178.4 to i64
  %arrayidx182.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181.4
  %43 = load <4 x half>, ptr addrspace(4) %arrayidx182.4, align 2, !tbaa !62
  %44 = zext nneg i32 %add175 to i64
  %45 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44
  %arrayidx182.8 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1024
  %46 = load <4 x half>, ptr addrspace(4) %arrayidx182.8, align 2, !tbaa !62
  %47 = zext nneg i32 %add175 to i64
  %48 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %47
  %arrayidx182.12 = getelementptr inbounds i8, ptr addrspace(4) %48, i64 1032
  %49 = load <4 x half>, ptr addrspace(4) %arrayidx182.12, align 2, !tbaa !62
  br label %if.end190

if.end190:                                        ; preds = %for.cond163.preheader, %if.end155
  %K_reg2.sroa.32.0 = phi <4 x half> [ undef, %if.end155 ], [ %49, %for.cond163.preheader ]
  %K_reg2.sroa.22.0 = phi <4 x half> [ undef, %if.end155 ], [ %46, %for.cond163.preheader ]
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end155 ], [ %43, %for.cond163.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end155 ], [ %42, %for.cond163.preheader ]
  %or.cond1292 = icmp ugt i32 %mul11.3, 1023
  %cmp196.not = icmp sgt i32 %mul11.3, %1
  %or.cond1293 = or i1 %or.cond1292, %cmp196.not
  br i1 %or.cond1293, label %if.end225, label %for.cond198.preheader

for.cond198.preheader:                            ; preds = %if.end190
  %50 = shl nsw i32 %cond.i.i1211.3, 10
  %mul206 = and i32 %50, 64512
  %add210 = add nuw nsw i32 %add104, %mul206
  %idxprom216 = zext nneg i32 %add210 to i64
  %arrayidx217 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216
  %51 = load <4 x half>, ptr addrspace(4) %arrayidx217, align 2, !tbaa !62
  %add213.4 = or disjoint i32 %add210, 4
  %idxprom216.4 = zext nneg i32 %add213.4 to i64
  %arrayidx217.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216.4
  %52 = load <4 x half>, ptr addrspace(4) %arrayidx217.4, align 2, !tbaa !62
  %53 = zext nneg i32 %add210 to i64
  %54 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %53
  %arrayidx217.8 = getelementptr inbounds i8, ptr addrspace(4) %54, i64 1024
  %55 = load <4 x half>, ptr addrspace(4) %arrayidx217.8, align 2, !tbaa !62
  %56 = zext nneg i32 %add210 to i64
  %57 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %56
  %arrayidx217.12 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 1032
  %58 = load <4 x half>, ptr addrspace(4) %arrayidx217.12, align 2, !tbaa !62
  br label %if.end225

if.end225:                                        ; preds = %for.cond198.preheader, %if.end190
  %K_reg3.sroa.32.0 = phi <4 x half> [ undef, %if.end190 ], [ %58, %for.cond198.preheader ]
  %K_reg3.sroa.22.0 = phi <4 x half> [ undef, %if.end190 ], [ %55, %for.cond198.preheader ]
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end190 ], [ %52, %for.cond198.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end190 ], [ %51, %for.cond198.preheader ]
  br i1 %or.cond1287, label %if.end374, label %for.cond233.preheader

for.cond233.preheader:                            ; preds = %if.end225
  %59 = shl nsw i32 %cond.i.i1211, 10
  %mul241 = and i32 %59, 64512
  %add245 = add nuw nsw i32 %add104, %mul241
  %idxprom251 = zext nneg i32 %add245 to i64
  %arrayidx252 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251
  %60 = load <4 x half>, ptr addrspace(4) %arrayidx252, align 2, !tbaa !62
  %add248.4 = or disjoint i32 %add245, 4
  %idxprom251.4 = zext nneg i32 %add248.4 to i64
  %arrayidx252.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251.4
  %61 = load <4 x half>, ptr addrspace(4) %arrayidx252.4, align 2, !tbaa !62
  %62 = zext nneg i32 %add245 to i64
  %63 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %62
  %arrayidx252.8 = getelementptr inbounds i8, ptr addrspace(4) %63, i64 1024
  %64 = load <4 x half>, ptr addrspace(4) %arrayidx252.8, align 2, !tbaa !62
  %65 = zext nneg i32 %add245 to i64
  %66 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %65
  %arrayidx252.12 = getelementptr inbounds i8, ptr addrspace(4) %66, i64 1032
  %67 = load <4 x half>, ptr addrspace(4) %arrayidx252.12, align 2, !tbaa !62
  %cmp262 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp262, label %for.cond264.preheader, label %if.end287

for.cond264.preheader:                            ; preds = %for.cond233.preheader
  %add271 = add nuw nsw i32 %mul11, %mul270
  %cmp274.not = icmp sgt i32 %add271, %1
  %fneg. = select i1 %cmp274.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1459 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp274.not.1.not = icmp slt i32 %add271, %1
  %fneg..1 = select i1 %cmp274.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1560 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1459, float %fneg..1, i64 1
  %add272.2 = or disjoint i32 %add271, 2
  %cmp274.not.2 = icmp sgt i32 %add272.2, %1
  %fneg..2 = select i1 %cmp274.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1653 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1560, float %fneg..2, i64 2
  %add272.3 = or disjoint i32 %add271, 3
  %cmp274.not.3 = icmp sgt i32 %add272.3, %1
  %fneg..3 = select i1 %cmp274.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1746 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1653, float %fneg..3, i64 3
  br label %if.end287

if.end287:                                        ; preds = %for.cond233.preheader, %for.cond264.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1746, %for.cond264.preheader ], [ zeroinitializer, %for.cond233.preheader ]
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !87
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %68), !call_argsrelate !87
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %69), !call_argsrelate !87
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %70), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %71, i64 0
  %mul322 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul322, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %71, i64 1
  %mul322.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul322.1, float 0x4024CB5EC0000000)
  %75 = tail call contract noundef float @llvm.exp.f32(float %74)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %71, i64 2
  %mul322.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul322.2, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %71, i64 3
  %mul322.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %78 = tail call contract noundef float @llvm.minnum.f32(float %mul322.3, float 0x4024CB5EC0000000)
  %79 = tail call contract noundef float @llvm.exp.f32(float %78)
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73)
  %81 = insertelement <4 x i16> poison, i16 %80, i64 0
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75)
  %83 = insertelement <4 x i16> %81, i16 %82, i64 1
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %85 = insertelement <4 x i16> %83, i16 %84, i64 2
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %79)
  %87 = insertelement <4 x i16> %85, i16 %86, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %87 to <4 x half>
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %64, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  br label %if.end374

if.end374:                                        ; preds = %if.end287, %if.end225
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %91, %if.end287 ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %90, %if.end287 ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %89, %if.end287 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %88, %if.end287 ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end225 ], [ %79, %if.end287 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end225 ], [ %77, %if.end287 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end225 ], [ %75, %if.end287 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end225 ], [ %73, %if.end287 ]
  br i1 %or.cond1289, label %if.end524, label %for.cond382.preheader

for.cond382.preheader:                            ; preds = %if.end374
  %92 = shl nsw i32 %cond.i.i1211.1, 10
  %mul390 = and i32 %92, 64512
  %add394 = add nuw nsw i32 %add104, %mul390
  %idxprom400 = zext nneg i32 %add394 to i64
  %arrayidx401 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400
  %93 = load <4 x half>, ptr addrspace(4) %arrayidx401, align 2, !tbaa !62
  %add397.4 = or disjoint i32 %add394, 4
  %idxprom400.4 = zext nneg i32 %add397.4 to i64
  %arrayidx401.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400.4
  %94 = load <4 x half>, ptr addrspace(4) %arrayidx401.4, align 2, !tbaa !62
  %95 = zext nneg i32 %add394 to i64
  %96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %95
  %arrayidx401.8 = getelementptr inbounds i8, ptr addrspace(4) %96, i64 1024
  %97 = load <4 x half>, ptr addrspace(4) %arrayidx401.8, align 2, !tbaa !62
  %98 = zext nneg i32 %add394 to i64
  %99 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %98
  %arrayidx401.12 = getelementptr inbounds i8, ptr addrspace(4) %99, i64 1032
  %100 = load <4 x half>, ptr addrspace(4) %arrayidx401.12, align 2, !tbaa !62
  %cmp411 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp411, label %for.cond413.preheader, label %if.end437

for.cond413.preheader:                            ; preds = %for.cond382.preheader
  %add420 = add nuw nsw i32 %mul11.1, %mul270
  %cmp423.not = icmp sgt i32 %add420, %1
  %fneg.1200 = select i1 %cmp423.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1468 = insertelement <4 x float> poison, float %fneg.1200, i64 0
  %cmp423.not.1.not = icmp slt i32 %add420, %1
  %fneg.1200.1 = select i1 %cmp423.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1569 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1468, float %fneg.1200.1, i64 1
  %add421.2 = or disjoint i32 %add420, 2
  %cmp423.not.2 = icmp sgt i32 %add421.2, %1
  %fneg.1200.2 = select i1 %cmp423.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1662 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1569, float %fneg.1200.2, i64 2
  %add421.3 = or disjoint i32 %add420, 3
  %cmp423.not.3 = icmp sgt i32 %add421.3, %1
  %fneg.1200.3 = select i1 %cmp423.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1755 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1662, float %fneg.1200.3, i64 3
  br label %if.end437

if.end437:                                        ; preds = %for.cond382.preheader, %for.cond413.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1755, %for.cond413.preheader ], [ zeroinitializer, %for.cond382.preheader ]
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !87
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %101), !call_argsrelate !87
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %102), !call_argsrelate !87
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %103), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1470 = extractelement <4 x float> %104, i64 0
  %mul472 = fmul contract float %acc_s.sroa.0.0.vec.extract1470, 0x3FB99999A0000000
  %105 = tail call contract noundef float @llvm.minnum.f32(float %mul472, float 0x4024CB5EC0000000)
  %106 = tail call contract noundef float @llvm.exp.f32(float %105)
  %acc_s.sroa.0.4.vec.extract1571 = extractelement <4 x float> %104, i64 1
  %mul472.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1571, 0x3FB99999A0000000
  %107 = tail call contract noundef float @llvm.minnum.f32(float %mul472.1, float 0x4024CB5EC0000000)
  %108 = tail call contract noundef float @llvm.exp.f32(float %107)
  %acc_s.sroa.0.8.vec.extract1664 = extractelement <4 x float> %104, i64 2
  %mul472.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1664, 0x3FB99999A0000000
  %109 = tail call contract noundef float @llvm.minnum.f32(float %mul472.2, float 0x4024CB5EC0000000)
  %110 = tail call contract noundef float @llvm.exp.f32(float %109)
  %acc_s.sroa.0.12.vec.extract1757 = extractelement <4 x float> %104, i64 3
  %mul472.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1757, 0x3FB99999A0000000
  %111 = tail call contract noundef float @llvm.minnum.f32(float %mul472.3, float 0x4024CB5EC0000000)
  %112 = tail call contract noundef float @llvm.exp.f32(float %111)
  %add488 = fadd contract float %sum_acc.sroa.0.0, %106
  %add488.1 = fadd contract float %sum_acc.sroa.20.0, %108
  %add488.2 = fadd contract float %sum_acc.sroa.38.0, %110
  %add488.3 = fadd contract float %sum_acc.sroa.56.0, %112
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %106)
  %114 = insertelement <4 x i16> poison, i16 %113, i64 0
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %108)
  %116 = insertelement <4 x i16> %114, i16 %115, i64 1
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %110)
  %118 = insertelement <4 x i16> %116, i16 %117, i64 2
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %112)
  %120 = insertelement <4 x i16> %118, i16 %119, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1431 = bitcast <4 x i16> %120 to <4 x half>
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %93, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !call_argsrelate !107
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %94, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !call_argsrelate !107
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %97, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !call_argsrelate !107
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %100, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !call_argsrelate !107
  br label %if.end524

if.end524:                                        ; preds = %if.end437, %if.end374
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %124, %if.end437 ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %123, %if.end437 ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %122, %if.end437 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %121, %if.end437 ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end374 ], [ %add488.3, %if.end437 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end374 ], [ %add488.2, %if.end437 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end374 ], [ %add488.1, %if.end437 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end374 ], [ %add488, %if.end437 ]
  br i1 %or.cond1291, label %if.end674, label %for.cond532.preheader

for.cond532.preheader:                            ; preds = %if.end524
  %125 = shl nsw i32 %cond.i.i1211.2, 10
  %mul540 = and i32 %125, 64512
  %add544 = add nuw nsw i32 %add104, %mul540
  %idxprom550 = zext nneg i32 %add544 to i64
  %arrayidx551 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550
  %126 = load <4 x half>, ptr addrspace(4) %arrayidx551, align 2, !tbaa !62
  %add547.4 = or disjoint i32 %add544, 4
  %idxprom550.4 = zext nneg i32 %add547.4 to i64
  %arrayidx551.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550.4
  %127 = load <4 x half>, ptr addrspace(4) %arrayidx551.4, align 2, !tbaa !62
  %128 = zext nneg i32 %add544 to i64
  %129 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %128
  %arrayidx551.8 = getelementptr inbounds i8, ptr addrspace(4) %129, i64 1024
  %130 = load <4 x half>, ptr addrspace(4) %arrayidx551.8, align 2, !tbaa !62
  %131 = zext nneg i32 %add544 to i64
  %132 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %131
  %arrayidx551.12 = getelementptr inbounds i8, ptr addrspace(4) %132, i64 1032
  %133 = load <4 x half>, ptr addrspace(4) %arrayidx551.12, align 2, !tbaa !62
  %cmp561 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp561, label %for.cond563.preheader, label %if.end587

for.cond563.preheader:                            ; preds = %for.cond532.preheader
  %add570 = add nuw nsw i32 %mul11.2, %mul270
  %cmp573.not = icmp sgt i32 %add570, %1
  %fneg.1201 = select i1 %cmp573.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1478 = insertelement <4 x float> poison, float %fneg.1201, i64 0
  %cmp573.not.1.not = icmp slt i32 %add570, %1
  %fneg.1201.1 = select i1 %cmp573.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1579 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1478, float %fneg.1201.1, i64 1
  %add571.2 = or disjoint i32 %add570, 2
  %cmp573.not.2 = icmp sgt i32 %add571.2, %1
  %fneg.1201.2 = select i1 %cmp573.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1672 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1579, float %fneg.1201.2, i64 2
  %add571.3 = or disjoint i32 %add570, 3
  %cmp573.not.3 = icmp sgt i32 %add571.3, %1
  %fneg.1201.3 = select i1 %cmp573.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1765 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1672, float %fneg.1201.3, i64 3
  br label %if.end587

if.end587:                                        ; preds = %for.cond532.preheader, %for.cond563.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1765, %for.cond563.preheader ], [ zeroinitializer, %for.cond532.preheader ]
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !87
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %134), !call_argsrelate !87
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %135), !call_argsrelate !87
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %136), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1480 = extractelement <4 x float> %137, i64 0
  %mul622 = fmul contract float %acc_s.sroa.0.0.vec.extract1480, 0x3FB99999A0000000
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul622, float 0x4024CB5EC0000000)
  %139 = tail call contract noundef float @llvm.exp.f32(float %138)
  %acc_s.sroa.0.4.vec.extract1581 = extractelement <4 x float> %137, i64 1
  %mul622.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1581, 0x3FB99999A0000000
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul622.1, float 0x4024CB5EC0000000)
  %141 = tail call contract noundef float @llvm.exp.f32(float %140)
  %acc_s.sroa.0.8.vec.extract1674 = extractelement <4 x float> %137, i64 2
  %mul622.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1674, 0x3FB99999A0000000
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul622.2, float 0x4024CB5EC0000000)
  %143 = tail call contract noundef float @llvm.exp.f32(float %142)
  %acc_s.sroa.0.12.vec.extract1767 = extractelement <4 x float> %137, i64 3
  %mul622.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1767, 0x3FB99999A0000000
  %144 = tail call contract noundef float @llvm.minnum.f32(float %mul622.3, float 0x4024CB5EC0000000)
  %145 = tail call contract noundef float @llvm.exp.f32(float %144)
  %add638 = fadd contract float %sum_acc.sroa.0.1, %139
  %add638.1 = fadd contract float %sum_acc.sroa.20.1, %141
  %add638.2 = fadd contract float %sum_acc.sroa.38.1, %143
  %add638.3 = fadd contract float %sum_acc.sroa.56.1, %145
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139)
  %147 = insertelement <4 x i16> poison, i16 %146, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141)
  %149 = insertelement <4 x i16> %147, i16 %148, i64 1
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143)
  %151 = insertelement <4 x i16> %149, i16 %150, i64 2
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %145)
  %153 = insertelement <4 x i16> %151, i16 %152, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1433 = bitcast <4 x i16> %153 to <4 x half>
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %126, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !107
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %127, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.34.0), !call_argsrelate !107
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %130, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.66.0), !call_argsrelate !107
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %133, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.98.0), !call_argsrelate !107
  br label %if.end674

if.end674:                                        ; preds = %if.end587, %if.end524
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end524 ], [ %157, %if.end587 ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end524 ], [ %156, %if.end587 ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end524 ], [ %155, %if.end587 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end524 ], [ %154, %if.end587 ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end524 ], [ %add638.3, %if.end587 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end524 ], [ %add638.2, %if.end587 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end524 ], [ %add638.1, %if.end587 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end524 ], [ %add638, %if.end587 ]
  br i1 %or.cond1293, label %if.end824, label %for.cond682.preheader

for.cond682.preheader:                            ; preds = %if.end674
  %158 = shl nsw i32 %cond.i.i1211.3, 10
  %mul690 = and i32 %158, 64512
  %add694 = add nuw nsw i32 %add104, %mul690
  %idxprom700 = zext nneg i32 %add694 to i64
  %arrayidx701 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700
  %159 = load <4 x half>, ptr addrspace(4) %arrayidx701, align 2, !tbaa !62
  %add697.4 = or disjoint i32 %add694, 4
  %idxprom700.4 = zext nneg i32 %add697.4 to i64
  %arrayidx701.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700.4
  %160 = load <4 x half>, ptr addrspace(4) %arrayidx701.4, align 2, !tbaa !62
  %161 = zext nneg i32 %add694 to i64
  %162 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %161
  %arrayidx701.8 = getelementptr inbounds i8, ptr addrspace(4) %162, i64 1024
  %163 = load <4 x half>, ptr addrspace(4) %arrayidx701.8, align 2, !tbaa !62
  %164 = zext nneg i32 %add694 to i64
  %165 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %164
  %arrayidx701.12 = getelementptr inbounds i8, ptr addrspace(4) %165, i64 1032
  %166 = load <4 x half>, ptr addrspace(4) %arrayidx701.12, align 2, !tbaa !62
  %cmp711 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp711, label %for.cond713.preheader, label %if.end737

for.cond713.preheader:                            ; preds = %for.cond682.preheader
  %add720 = add nuw nsw i32 %mul11.3, %mul270
  %cmp723.not = icmp sgt i32 %add720, %1
  %fneg.1202 = select i1 %cmp723.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1488 = insertelement <4 x float> poison, float %fneg.1202, i64 0
  %cmp723.not.1.not = icmp slt i32 %add720, %1
  %fneg.1202.1 = select i1 %cmp723.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1589 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1488, float %fneg.1202.1, i64 1
  %add721.2 = or disjoint i32 %add720, 2
  %cmp723.not.2 = icmp sgt i32 %add721.2, %1
  %fneg.1202.2 = select i1 %cmp723.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1682 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1589, float %fneg.1202.2, i64 2
  %add721.3 = or disjoint i32 %add720, 3
  %cmp723.not.3 = icmp sgt i32 %add721.3, %1
  %fneg.1202.3 = select i1 %cmp723.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1775 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1682, float %fneg.1202.3, i64 3
  br label %if.end737

if.end737:                                        ; preds = %for.cond682.preheader, %for.cond713.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1775, %for.cond713.preheader ], [ zeroinitializer, %for.cond682.preheader ]
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !87
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %167), !call_argsrelate !87
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %168), !call_argsrelate !87
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %169), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1490 = extractelement <4 x float> %170, i64 0
  %mul772 = fmul contract float %acc_s.sroa.0.0.vec.extract1490, 0x3FB99999A0000000
  %171 = tail call contract noundef float @llvm.minnum.f32(float %mul772, float 0x4024CB5EC0000000)
  %172 = tail call contract noundef float @llvm.exp.f32(float %171)
  %acc_s.sroa.0.4.vec.extract1591 = extractelement <4 x float> %170, i64 1
  %mul772.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1591, 0x3FB99999A0000000
  %173 = tail call contract noundef float @llvm.minnum.f32(float %mul772.1, float 0x4024CB5EC0000000)
  %174 = tail call contract noundef float @llvm.exp.f32(float %173)
  %acc_s.sroa.0.8.vec.extract1684 = extractelement <4 x float> %170, i64 2
  %mul772.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1684, 0x3FB99999A0000000
  %175 = tail call contract noundef float @llvm.minnum.f32(float %mul772.2, float 0x4024CB5EC0000000)
  %176 = tail call contract noundef float @llvm.exp.f32(float %175)
  %acc_s.sroa.0.12.vec.extract1777 = extractelement <4 x float> %170, i64 3
  %mul772.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1777, 0x3FB99999A0000000
  %177 = tail call contract noundef float @llvm.minnum.f32(float %mul772.3, float 0x4024CB5EC0000000)
  %178 = tail call contract noundef float @llvm.exp.f32(float %177)
  %add788 = fadd contract float %sum_acc.sroa.0.2, %172
  %add788.1 = fadd contract float %sum_acc.sroa.20.2, %174
  %add788.2 = fadd contract float %sum_acc.sroa.38.2, %176
  %add788.3 = fadd contract float %sum_acc.sroa.56.2, %178
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %172)
  %180 = insertelement <4 x i16> poison, i16 %179, i64 0
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %174)
  %182 = insertelement <4 x i16> %180, i16 %181, i64 1
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %176)
  %184 = insertelement <4 x i16> %182, i16 %183, i64 2
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %178)
  %186 = insertelement <4 x i16> %184, i16 %185, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1435 = bitcast <4 x i16> %186 to <4 x half>
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %159, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !107
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %160, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.18.0), !call_argsrelate !107
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %163, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.34.0), !call_argsrelate !107
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %166, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !107
  br label %if.end824

if.end824:                                        ; preds = %if.end737, %if.end674
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end674 ], [ %190, %if.end737 ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end674 ], [ %189, %if.end737 ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end674 ], [ %188, %if.end737 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end674 ], [ %187, %if.end737 ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end674 ], [ %add788.3, %if.end737 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end674 ], [ %add788.2, %if.end737 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end674 ], [ %add788.1, %if.end737 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end674 ], [ %add788, %if.end737 ]
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023
  %cmp94.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond1287.1 = or i1 %or.cond.1, %cmp94.not.1
  br i1 %or.cond1287.1, label %if.end.1, label %for.cond95.preheader.1

for.cond95.preheader.1:                           ; preds = %if.end824
  %191 = shl nsw i32 %cond.i.i1211.4, 10
  %mul103.1 = and i32 %191, 64512
  %add107.1 = add nuw nsw i32 %add104, %mul103.1
  %idxprom113.11319 = zext nneg i32 %add107.1 to i64
  %arrayidx114.11320 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113.11319
  %192 = load <4 x half>, ptr addrspace(4) %arrayidx114.11320, align 2, !tbaa !62
  %add110.4.1 = or disjoint i32 %add107.1, 4
  %idxprom113.4.1 = zext nneg i32 %add110.4.1 to i64
  %arrayidx114.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113.4.1
  %193 = load <4 x half>, ptr addrspace(4) %arrayidx114.4.1, align 2, !tbaa !62
  %194 = zext nneg i32 %add107.1 to i64
  %195 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %194
  %arrayidx114.8.1 = getelementptr inbounds i8, ptr addrspace(4) %195, i64 1024
  %196 = load <4 x half>, ptr addrspace(4) %arrayidx114.8.1, align 2, !tbaa !62
  %197 = zext nneg i32 %add107.1 to i64
  %198 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %197
  %arrayidx114.12.1 = getelementptr inbounds i8, ptr addrspace(4) %198, i64 1032
  %199 = load <4 x half>, ptr addrspace(4) %arrayidx114.12.1, align 2, !tbaa !62
  br label %if.end.1

if.end.1:                                         ; preds = %for.cond95.preheader.1, %if.end824
  %K_reg.sroa.32.1 = phi <4 x half> [ %K_reg.sroa.32.0, %if.end824 ], [ %199, %for.cond95.preheader.1 ]
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end824 ], [ %196, %for.cond95.preheader.1 ]
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end824 ], [ %193, %for.cond95.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end824 ], [ %192, %for.cond95.preheader.1 ]
  %or.cond1288.1 = icmp ugt i32 %mul11.5, 1023
  %cmp126.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond1289.1 = or i1 %or.cond1288.1, %cmp126.not.1
  br i1 %or.cond1289.1, label %if.end155.1, label %for.cond128.preheader.1

for.cond128.preheader.1:                          ; preds = %if.end.1
  %200 = shl nsw i32 %cond.i.i1211.5, 10
  %mul136.1 = and i32 %200, 64512
  %add140.1 = add nuw nsw i32 %add104, %mul136.1
  %idxprom146.11322 = zext nneg i32 %add140.1 to i64
  %arrayidx147.11323 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146.11322
  %201 = load <4 x half>, ptr addrspace(4) %arrayidx147.11323, align 2, !tbaa !62
  %add143.4.1 = or disjoint i32 %add140.1, 4
  %idxprom146.4.1 = zext nneg i32 %add143.4.1 to i64
  %arrayidx147.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146.4.1
  %202 = load <4 x half>, ptr addrspace(4) %arrayidx147.4.1, align 2, !tbaa !62
  %203 = zext nneg i32 %add140.1 to i64
  %204 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %203
  %arrayidx147.8.1 = getelementptr inbounds i8, ptr addrspace(4) %204, i64 1024
  %205 = load <4 x half>, ptr addrspace(4) %arrayidx147.8.1, align 2, !tbaa !62
  %206 = zext nneg i32 %add140.1 to i64
  %207 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %206
  %arrayidx147.12.1 = getelementptr inbounds i8, ptr addrspace(4) %207, i64 1032
  %208 = load <4 x half>, ptr addrspace(4) %arrayidx147.12.1, align 2, !tbaa !62
  br label %if.end155.1

if.end155.1:                                      ; preds = %for.cond128.preheader.1, %if.end.1
  %K_reg1.sroa.32.1 = phi <4 x half> [ %K_reg1.sroa.32.0, %if.end.1 ], [ %208, %for.cond128.preheader.1 ]
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end.1 ], [ %205, %for.cond128.preheader.1 ]
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %202, %for.cond128.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %201, %for.cond128.preheader.1 ]
  %or.cond1290.1 = icmp ugt i32 %mul11.6, 1023
  %cmp161.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond1291.1 = or i1 %or.cond1290.1, %cmp161.not.1
  br i1 %or.cond1291.1, label %if.end190.1, label %for.cond163.preheader.1

for.cond163.preheader.1:                          ; preds = %if.end155.1
  %209 = shl nsw i32 %cond.i.i1211.6, 10
  %mul171.1 = and i32 %209, 64512
  %add175.1 = add nuw nsw i32 %add104, %mul171.1
  %idxprom181.11325 = zext nneg i32 %add175.1 to i64
  %arrayidx182.11326 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181.11325
  %210 = load <4 x half>, ptr addrspace(4) %arrayidx182.11326, align 2, !tbaa !62
  %add178.4.1 = or disjoint i32 %add175.1, 4
  %idxprom181.4.1 = zext nneg i32 %add178.4.1 to i64
  %arrayidx182.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181.4.1
  %211 = load <4 x half>, ptr addrspace(4) %arrayidx182.4.1, align 2, !tbaa !62
  %212 = zext nneg i32 %add175.1 to i64
  %213 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %212
  %arrayidx182.8.1 = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1024
  %214 = load <4 x half>, ptr addrspace(4) %arrayidx182.8.1, align 2, !tbaa !62
  %215 = zext nneg i32 %add175.1 to i64
  %216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %215
  %arrayidx182.12.1 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1032
  %217 = load <4 x half>, ptr addrspace(4) %arrayidx182.12.1, align 2, !tbaa !62
  br label %if.end190.1

if.end190.1:                                      ; preds = %for.cond163.preheader.1, %if.end155.1
  %K_reg2.sroa.32.1 = phi <4 x half> [ %K_reg2.sroa.32.0, %if.end155.1 ], [ %217, %for.cond163.preheader.1 ]
  %K_reg2.sroa.22.1 = phi <4 x half> [ %K_reg2.sroa.22.0, %if.end155.1 ], [ %214, %for.cond163.preheader.1 ]
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end155.1 ], [ %211, %for.cond163.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end155.1 ], [ %210, %for.cond163.preheader.1 ]
  %or.cond1292.1 = icmp ugt i32 %mul11.7, 1023
  %cmp196.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond1293.1 = or i1 %or.cond1292.1, %cmp196.not.1
  br i1 %or.cond1293.1, label %if.end225.1, label %for.cond198.preheader.1

for.cond198.preheader.1:                          ; preds = %if.end190.1
  %218 = shl nsw i32 %cond.i.i1211.7, 10
  %mul206.1 = and i32 %218, 64512
  %add210.1 = add nuw nsw i32 %add104, %mul206.1
  %idxprom216.11328 = zext nneg i32 %add210.1 to i64
  %arrayidx217.11329 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216.11328
  %219 = load <4 x half>, ptr addrspace(4) %arrayidx217.11329, align 2, !tbaa !62
  %add213.4.1 = or disjoint i32 %add210.1, 4
  %idxprom216.4.1 = zext nneg i32 %add213.4.1 to i64
  %arrayidx217.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216.4.1
  %220 = load <4 x half>, ptr addrspace(4) %arrayidx217.4.1, align 2, !tbaa !62
  %221 = zext nneg i32 %add210.1 to i64
  %222 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %221
  %arrayidx217.8.1 = getelementptr inbounds i8, ptr addrspace(4) %222, i64 1024
  %223 = load <4 x half>, ptr addrspace(4) %arrayidx217.8.1, align 2, !tbaa !62
  %224 = zext nneg i32 %add210.1 to i64
  %225 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %224
  %arrayidx217.12.1 = getelementptr inbounds i8, ptr addrspace(4) %225, i64 1032
  %226 = load <4 x half>, ptr addrspace(4) %arrayidx217.12.1, align 2, !tbaa !62
  br label %if.end225.1

if.end225.1:                                      ; preds = %for.cond198.preheader.1, %if.end190.1
  %K_reg3.sroa.32.1 = phi <4 x half> [ %K_reg3.sroa.32.0, %if.end190.1 ], [ %226, %for.cond198.preheader.1 ]
  %K_reg3.sroa.22.1 = phi <4 x half> [ %K_reg3.sroa.22.0, %if.end190.1 ], [ %223, %for.cond198.preheader.1 ]
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end190.1 ], [ %220, %for.cond198.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end190.1 ], [ %219, %for.cond198.preheader.1 ]
  br i1 %or.cond1287.1, label %if.end374.1, label %for.cond233.preheader.1

for.cond233.preheader.1:                          ; preds = %if.end225.1
  %227 = shl nsw i32 %cond.i.i1211.4, 10
  %mul241.1 = and i32 %227, 64512
  %add245.1 = add nuw nsw i32 %add104, %mul241.1
  %idxprom251.11331 = zext nneg i32 %add245.1 to i64
  %arrayidx252.11332 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251.11331
  %228 = load <4 x half>, ptr addrspace(4) %arrayidx252.11332, align 2, !tbaa !62
  %add248.4.1 = or disjoint i32 %add245.1, 4
  %idxprom251.4.1 = zext nneg i32 %add248.4.1 to i64
  %arrayidx252.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251.4.1
  %229 = load <4 x half>, ptr addrspace(4) %arrayidx252.4.1, align 2, !tbaa !62
  %230 = zext nneg i32 %add245.1 to i64
  %231 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230
  %arrayidx252.8.1 = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1024
  %232 = load <4 x half>, ptr addrspace(4) %arrayidx252.8.1, align 2, !tbaa !62
  %233 = zext nneg i32 %add245.1 to i64
  %234 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %233
  %arrayidx252.12.1 = getelementptr inbounds i8, ptr addrspace(4) %234, i64 1032
  %235 = load <4 x half>, ptr addrspace(4) %arrayidx252.12.1, align 2, !tbaa !62
  %cmp262.1 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp262.1, label %for.cond264.preheader.1, label %if.end287.1

for.cond264.preheader.1:                          ; preds = %for.cond233.preheader.1
  %add271.1 = add nuw nsw i32 %mul11.4, %mul270
  %cmp274.not.11334 = icmp sgt i32 %add271.1, %1
  %fneg..11335 = select i1 %cmp274.not.11334, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1500 = insertelement <4 x float> poison, float %fneg..11335, i64 0
  %cmp274.not.1.1.not = icmp slt i32 %add271.1, %1
  %fneg..1.1 = select i1 %cmp274.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1599 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1500, float %fneg..1.1, i64 1
  %add272.2.1 = or disjoint i32 %add271.1, 2
  %cmp274.not.2.1 = icmp sgt i32 %add272.2.1, %1
  %fneg..2.1 = select i1 %cmp274.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1692 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1599, float %fneg..2.1, i64 2
  %add272.3.1 = or disjoint i32 %add271.1, 3
  %cmp274.not.3.1 = icmp sgt i32 %add272.3.1, %1
  %fneg..3.1 = select i1 %cmp274.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1785 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1692, float %fneg..3.1, i64 3
  br label %if.end287.1

if.end287.1:                                      ; preds = %for.cond233.preheader.1, %for.cond264.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1785, %for.cond264.preheader.1 ], [ zeroinitializer, %for.cond233.preheader.1 ]
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !87
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %236), !call_argsrelate !87
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %237), !call_argsrelate !87
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %238), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1502 = extractelement <4 x float> %239, i64 0
  %mul322.11339 = fmul contract float %acc_s.sroa.0.0.vec.extract1502, 0x3FB99999A0000000
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul322.11339, float 0x4024CB5EC0000000)
  %241 = tail call contract noundef float @llvm.exp.f32(float %240)
  %acc_s.sroa.0.4.vec.extract1601 = extractelement <4 x float> %239, i64 1
  %mul322.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1601, 0x3FB99999A0000000
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul322.1.1, float 0x4024CB5EC0000000)
  %243 = tail call contract noundef float @llvm.exp.f32(float %242)
  %acc_s.sroa.0.8.vec.extract1694 = extractelement <4 x float> %239, i64 2
  %mul322.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1694, 0x3FB99999A0000000
  %244 = tail call contract noundef float @llvm.minnum.f32(float %mul322.2.1, float 0x4024CB5EC0000000)
  %245 = tail call contract noundef float @llvm.exp.f32(float %244)
  %acc_s.sroa.0.12.vec.extract1787 = extractelement <4 x float> %239, i64 3
  %mul322.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1787, 0x3FB99999A0000000
  %246 = tail call contract noundef float @llvm.minnum.f32(float %mul322.3.1, float 0x4024CB5EC0000000)
  %247 = tail call contract noundef float @llvm.exp.f32(float %246)
  %add338.11340 = fadd contract float %sum_acc.sroa.0.3, %241
  %add338.1.1 = fadd contract float %sum_acc.sroa.20.3, %243
  %add338.2.1 = fadd contract float %sum_acc.sroa.38.3, %245
  %add338.3.1 = fadd contract float %sum_acc.sroa.56.3, %247
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241)
  %249 = insertelement <4 x i16> poison, i16 %248, i64 0
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243)
  %251 = insertelement <4 x i16> %249, i16 %250, i64 1
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %245)
  %253 = insertelement <4 x i16> %251, i16 %252, i64 2
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %247)
  %255 = insertelement <4 x i16> %253, i16 %254, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1437 = bitcast <4 x i16> %255 to <4 x half>
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %228, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.0.1), !call_argsrelate !107
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %229, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.34.1), !call_argsrelate !107
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %232, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.66.1), !call_argsrelate !107
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %235, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.98.1), !call_argsrelate !107
  br label %if.end374.1

if.end374.1:                                      ; preds = %if.end287.1, %if.end225.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end225.1 ], [ %259, %if.end287.1 ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end225.1 ], [ %258, %if.end287.1 ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end225.1 ], [ %257, %if.end287.1 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end225.1 ], [ %256, %if.end287.1 ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end225.1 ], [ %add338.3.1, %if.end287.1 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end225.1 ], [ %add338.2.1, %if.end287.1 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end225.1 ], [ %add338.1.1, %if.end287.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end225.1 ], [ %add338.11340, %if.end287.1 ]
  br i1 %or.cond1289.1, label %if.end524.1, label %for.cond382.preheader.1

for.cond382.preheader.1:                          ; preds = %if.end374.1
  %260 = shl nsw i32 %cond.i.i1211.5, 10
  %mul390.1 = and i32 %260, 64512
  %add394.1 = add nuw nsw i32 %add104, %mul390.1
  %idxprom400.11341 = zext nneg i32 %add394.1 to i64
  %arrayidx401.11342 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400.11341
  %261 = load <4 x half>, ptr addrspace(4) %arrayidx401.11342, align 2, !tbaa !62
  %add397.4.1 = or disjoint i32 %add394.1, 4
  %idxprom400.4.1 = zext nneg i32 %add397.4.1 to i64
  %arrayidx401.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400.4.1
  %262 = load <4 x half>, ptr addrspace(4) %arrayidx401.4.1, align 2, !tbaa !62
  %263 = zext nneg i32 %add394.1 to i64
  %264 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263
  %arrayidx401.8.1 = getelementptr inbounds i8, ptr addrspace(4) %264, i64 1024
  %265 = load <4 x half>, ptr addrspace(4) %arrayidx401.8.1, align 2, !tbaa !62
  %266 = zext nneg i32 %add394.1 to i64
  %267 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %266
  %arrayidx401.12.1 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1032
  %268 = load <4 x half>, ptr addrspace(4) %arrayidx401.12.1, align 2, !tbaa !62
  %cmp411.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp411.1, label %for.cond413.preheader.1, label %if.end437.1

for.cond413.preheader.1:                          ; preds = %for.cond382.preheader.1
  %add420.1 = add nuw nsw i32 %mul11.5, %mul270
  %cmp423.not.11344 = icmp sgt i32 %add420.1, %1
  %fneg.1200.11345 = select i1 %cmp423.not.11344, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1512 = insertelement <4 x float> poison, float %fneg.1200.11345, i64 0
  %cmp423.not.1.1.not = icmp slt i32 %add420.1, %1
  %fneg.1200.1.1 = select i1 %cmp423.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1609 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1512, float %fneg.1200.1.1, i64 1
  %add421.2.1 = or disjoint i32 %add420.1, 2
  %cmp423.not.2.1 = icmp sgt i32 %add421.2.1, %1
  %fneg.1200.2.1 = select i1 %cmp423.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1702 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1609, float %fneg.1200.2.1, i64 2
  %add421.3.1 = or disjoint i32 %add420.1, 3
  %cmp423.not.3.1 = icmp sgt i32 %add421.3.1, %1
  %fneg.1200.3.1 = select i1 %cmp423.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1795 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1702, float %fneg.1200.3.1, i64 3
  br label %if.end437.1

if.end437.1:                                      ; preds = %for.cond382.preheader.1, %for.cond413.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1795, %for.cond413.preheader.1 ], [ zeroinitializer, %for.cond382.preheader.1 ]
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !87
  %270 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %269), !call_argsrelate !87
  %271 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %270), !call_argsrelate !87
  %272 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %271), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1514 = extractelement <4 x float> %272, i64 0
  %mul472.11349 = fmul contract float %acc_s.sroa.0.0.vec.extract1514, 0x3FB99999A0000000
  %273 = tail call contract noundef float @llvm.minnum.f32(float %mul472.11349, float 0x4024CB5EC0000000)
  %274 = tail call contract noundef float @llvm.exp.f32(float %273)
  %acc_s.sroa.0.4.vec.extract1611 = extractelement <4 x float> %272, i64 1
  %mul472.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1611, 0x3FB99999A0000000
  %275 = tail call contract noundef float @llvm.minnum.f32(float %mul472.1.1, float 0x4024CB5EC0000000)
  %276 = tail call contract noundef float @llvm.exp.f32(float %275)
  %acc_s.sroa.0.8.vec.extract1704 = extractelement <4 x float> %272, i64 2
  %mul472.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1704, 0x3FB99999A0000000
  %277 = tail call contract noundef float @llvm.minnum.f32(float %mul472.2.1, float 0x4024CB5EC0000000)
  %278 = tail call contract noundef float @llvm.exp.f32(float %277)
  %acc_s.sroa.0.12.vec.extract1797 = extractelement <4 x float> %272, i64 3
  %mul472.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1797, 0x3FB99999A0000000
  %279 = tail call contract noundef float @llvm.minnum.f32(float %mul472.3.1, float 0x4024CB5EC0000000)
  %280 = tail call contract noundef float @llvm.exp.f32(float %279)
  %add488.11350 = fadd contract float %sum_acc.sroa.0.4, %274
  %add488.1.1 = fadd contract float %sum_acc.sroa.20.4, %276
  %add488.2.1 = fadd contract float %sum_acc.sroa.38.4, %278
  %add488.3.1 = fadd contract float %sum_acc.sroa.56.4, %280
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %274)
  %282 = insertelement <4 x i16> poison, i16 %281, i64 0
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %276)
  %284 = insertelement <4 x i16> %282, i16 %283, i64 1
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %278)
  %286 = insertelement <4 x i16> %284, i16 %285, i64 2
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %280)
  %288 = insertelement <4 x i16> %286, i16 %287, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1439 = bitcast <4 x i16> %288 to <4 x half>
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %261, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !107
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %262, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.18.1), !call_argsrelate !107
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %265, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.34.1), !call_argsrelate !107
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %268, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !107
  br label %if.end524.1

if.end524.1:                                      ; preds = %if.end437.1, %if.end374.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end374.1 ], [ %292, %if.end437.1 ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end374.1 ], [ %291, %if.end437.1 ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end374.1 ], [ %290, %if.end437.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end374.1 ], [ %289, %if.end437.1 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end374.1 ], [ %add488.3.1, %if.end437.1 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end374.1 ], [ %add488.2.1, %if.end437.1 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end374.1 ], [ %add488.1.1, %if.end437.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end374.1 ], [ %add488.11350, %if.end437.1 ]
  br i1 %or.cond1291.1, label %if.end674.1, label %for.cond532.preheader.1

for.cond532.preheader.1:                          ; preds = %if.end524.1
  %293 = shl nsw i32 %cond.i.i1211.6, 10
  %mul540.1 = and i32 %293, 64512
  %add544.1 = add nuw nsw i32 %add104, %mul540.1
  %idxprom550.11351 = zext nneg i32 %add544.1 to i64
  %arrayidx551.11352 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550.11351
  %294 = load <4 x half>, ptr addrspace(4) %arrayidx551.11352, align 2, !tbaa !62
  %add547.4.1 = or disjoint i32 %add544.1, 4
  %idxprom550.4.1 = zext nneg i32 %add547.4.1 to i64
  %arrayidx551.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550.4.1
  %295 = load <4 x half>, ptr addrspace(4) %arrayidx551.4.1, align 2, !tbaa !62
  %296 = zext nneg i32 %add544.1 to i64
  %297 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %296
  %arrayidx551.8.1 = getelementptr inbounds i8, ptr addrspace(4) %297, i64 1024
  %298 = load <4 x half>, ptr addrspace(4) %arrayidx551.8.1, align 2, !tbaa !62
  %299 = zext nneg i32 %add544.1 to i64
  %300 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %299
  %arrayidx551.12.1 = getelementptr inbounds i8, ptr addrspace(4) %300, i64 1032
  %301 = load <4 x half>, ptr addrspace(4) %arrayidx551.12.1, align 2, !tbaa !62
  %cmp561.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp561.1, label %for.cond563.preheader.1, label %if.end587.1

for.cond563.preheader.1:                          ; preds = %for.cond532.preheader.1
  %add570.1 = add nuw nsw i32 %mul11.6, %mul270
  %cmp573.not.11354 = icmp sgt i32 %add570.1, %1
  %fneg.1201.11355 = select i1 %cmp573.not.11354, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1524 = insertelement <4 x float> poison, float %fneg.1201.11355, i64 0
  %cmp573.not.1.1.not = icmp slt i32 %add570.1, %1
  %fneg.1201.1.1 = select i1 %cmp573.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1619 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1524, float %fneg.1201.1.1, i64 1
  %add571.2.1 = or disjoint i32 %add570.1, 2
  %cmp573.not.2.1 = icmp sgt i32 %add571.2.1, %1
  %fneg.1201.2.1 = select i1 %cmp573.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1712 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1619, float %fneg.1201.2.1, i64 2
  %add571.3.1 = or disjoint i32 %add570.1, 3
  %cmp573.not.3.1 = icmp sgt i32 %add571.3.1, %1
  %fneg.1201.3.1 = select i1 %cmp573.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1805 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1712, float %fneg.1201.3.1, i64 3
  br label %if.end587.1

if.end587.1:                                      ; preds = %for.cond532.preheader.1, %for.cond563.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1805, %for.cond563.preheader.1 ], [ zeroinitializer, %for.cond532.preheader.1 ]
  %302 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !87
  %303 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %302), !call_argsrelate !87
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %303), !call_argsrelate !87
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %304), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1526 = extractelement <4 x float> %305, i64 0
  %mul622.11359 = fmul contract float %acc_s.sroa.0.0.vec.extract1526, 0x3FB99999A0000000
  %306 = tail call contract noundef float @llvm.minnum.f32(float %mul622.11359, float 0x4024CB5EC0000000)
  %307 = tail call contract noundef float @llvm.exp.f32(float %306)
  %acc_s.sroa.0.4.vec.extract1621 = extractelement <4 x float> %305, i64 1
  %mul622.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1621, 0x3FB99999A0000000
  %308 = tail call contract noundef float @llvm.minnum.f32(float %mul622.1.1, float 0x4024CB5EC0000000)
  %309 = tail call contract noundef float @llvm.exp.f32(float %308)
  %acc_s.sroa.0.8.vec.extract1714 = extractelement <4 x float> %305, i64 2
  %mul622.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1714, 0x3FB99999A0000000
  %310 = tail call contract noundef float @llvm.minnum.f32(float %mul622.2.1, float 0x4024CB5EC0000000)
  %311 = tail call contract noundef float @llvm.exp.f32(float %310)
  %acc_s.sroa.0.12.vec.extract1807 = extractelement <4 x float> %305, i64 3
  %mul622.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1807, 0x3FB99999A0000000
  %312 = tail call contract noundef float @llvm.minnum.f32(float %mul622.3.1, float 0x4024CB5EC0000000)
  %313 = tail call contract noundef float @llvm.exp.f32(float %312)
  %add638.11360 = fadd contract float %sum_acc.sroa.0.5, %307
  %add638.1.1 = fadd contract float %sum_acc.sroa.20.5, %309
  %add638.2.1 = fadd contract float %sum_acc.sroa.38.5, %311
  %add638.3.1 = fadd contract float %sum_acc.sroa.56.5, %313
  %314 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %307)
  %315 = insertelement <4 x i16> poison, i16 %314, i64 0
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %309)
  %317 = insertelement <4 x i16> %315, i16 %316, i64 1
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %311)
  %319 = insertelement <4 x i16> %317, i16 %318, i64 2
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %313)
  %321 = insertelement <4 x i16> %319, i16 %320, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1441 = bitcast <4 x i16> %321 to <4 x half>
  %322 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %294, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !107
  %323 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %295, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.34.2), !call_argsrelate !107
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %298, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.66.2), !call_argsrelate !107
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %301, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.98.2), !call_argsrelate !107
  br label %if.end674.1

if.end674.1:                                      ; preds = %if.end587.1, %if.end524.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end524.1 ], [ %325, %if.end587.1 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end524.1 ], [ %324, %if.end587.1 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end524.1 ], [ %323, %if.end587.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end524.1 ], [ %322, %if.end587.1 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end524.1 ], [ %add638.3.1, %if.end587.1 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end524.1 ], [ %add638.2.1, %if.end587.1 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end524.1 ], [ %add638.1.1, %if.end587.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end524.1 ], [ %add638.11360, %if.end587.1 ]
  br i1 %or.cond1293.1, label %if.end824.1, label %for.cond682.preheader.1

for.cond682.preheader.1:                          ; preds = %if.end674.1
  %326 = shl nsw i32 %cond.i.i1211.7, 10
  %mul690.1 = and i32 %326, 64512
  %add694.1 = add nuw nsw i32 %add104, %mul690.1
  %idxprom700.11361 = zext nneg i32 %add694.1 to i64
  %arrayidx701.11362 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700.11361
  %327 = load <4 x half>, ptr addrspace(4) %arrayidx701.11362, align 2, !tbaa !62
  %add697.4.1 = or disjoint i32 %add694.1, 4
  %idxprom700.4.1 = zext nneg i32 %add697.4.1 to i64
  %arrayidx701.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700.4.1
  %328 = load <4 x half>, ptr addrspace(4) %arrayidx701.4.1, align 2, !tbaa !62
  %329 = zext nneg i32 %add694.1 to i64
  %330 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %329
  %arrayidx701.8.1 = getelementptr inbounds i8, ptr addrspace(4) %330, i64 1024
  %331 = load <4 x half>, ptr addrspace(4) %arrayidx701.8.1, align 2, !tbaa !62
  %332 = zext nneg i32 %add694.1 to i64
  %333 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %332
  %arrayidx701.12.1 = getelementptr inbounds i8, ptr addrspace(4) %333, i64 1032
  %334 = load <4 x half>, ptr addrspace(4) %arrayidx701.12.1, align 2, !tbaa !62
  %cmp711.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp711.1, label %for.cond713.preheader.1, label %if.end737.1

for.cond713.preheader.1:                          ; preds = %for.cond682.preheader.1
  %add720.1 = add nuw nsw i32 %mul11.7, %mul270
  %cmp723.not.11364 = icmp sgt i32 %add720.1, %1
  %fneg.1202.11365 = select i1 %cmp723.not.11364, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1536 = insertelement <4 x float> poison, float %fneg.1202.11365, i64 0
  %cmp723.not.1.1.not = icmp slt i32 %add720.1, %1
  %fneg.1202.1.1 = select i1 %cmp723.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1629 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1536, float %fneg.1202.1.1, i64 1
  %add721.2.1 = or disjoint i32 %add720.1, 2
  %cmp723.not.2.1 = icmp sgt i32 %add721.2.1, %1
  %fneg.1202.2.1 = select i1 %cmp723.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1722 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1629, float %fneg.1202.2.1, i64 2
  %add721.3.1 = or disjoint i32 %add720.1, 3
  %cmp723.not.3.1 = icmp sgt i32 %add721.3.1, %1
  %fneg.1202.3.1 = select i1 %cmp723.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1815 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1722, float %fneg.1202.3.1, i64 3
  br label %if.end737.1

if.end737.1:                                      ; preds = %for.cond682.preheader.1, %for.cond713.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1815, %for.cond713.preheader.1 ], [ zeroinitializer, %for.cond682.preheader.1 ]
  %335 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !87
  %336 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %335), !call_argsrelate !87
  %337 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %336), !call_argsrelate !87
  %338 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %337), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1538 = extractelement <4 x float> %338, i64 0
  %mul772.11369 = fmul contract float %acc_s.sroa.0.0.vec.extract1538, 0x3FB99999A0000000
  %339 = tail call contract noundef float @llvm.minnum.f32(float %mul772.11369, float 0x4024CB5EC0000000)
  %340 = tail call contract noundef float @llvm.exp.f32(float %339)
  %acc_s.sroa.0.4.vec.extract1631 = extractelement <4 x float> %338, i64 1
  %mul772.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1631, 0x3FB99999A0000000
  %341 = tail call contract noundef float @llvm.minnum.f32(float %mul772.1.1, float 0x4024CB5EC0000000)
  %342 = tail call contract noundef float @llvm.exp.f32(float %341)
  %acc_s.sroa.0.8.vec.extract1724 = extractelement <4 x float> %338, i64 2
  %mul772.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1724, 0x3FB99999A0000000
  %343 = tail call contract noundef float @llvm.minnum.f32(float %mul772.2.1, float 0x4024CB5EC0000000)
  %344 = tail call contract noundef float @llvm.exp.f32(float %343)
  %acc_s.sroa.0.12.vec.extract1817 = extractelement <4 x float> %338, i64 3
  %mul772.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1817, 0x3FB99999A0000000
  %345 = tail call contract noundef float @llvm.minnum.f32(float %mul772.3.1, float 0x4024CB5EC0000000)
  %346 = tail call contract noundef float @llvm.exp.f32(float %345)
  %add788.11370 = fadd contract float %sum_acc.sroa.0.6, %340
  %add788.1.1 = fadd contract float %sum_acc.sroa.20.6, %342
  %add788.2.1 = fadd contract float %sum_acc.sroa.38.6, %344
  %add788.3.1 = fadd contract float %sum_acc.sroa.56.6, %346
  %347 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %340)
  %348 = insertelement <4 x i16> poison, i16 %347, i64 0
  %349 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %342)
  %350 = insertelement <4 x i16> %348, i16 %349, i64 1
  %351 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %344)
  %352 = insertelement <4 x i16> %350, i16 %351, i64 2
  %353 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %346)
  %354 = insertelement <4 x i16> %352, i16 %353, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1443 = bitcast <4 x i16> %354 to <4 x half>
  %355 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %327, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !107
  %356 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %328, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.18.2), !call_argsrelate !107
  %357 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %331, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.34.2), !call_argsrelate !107
  %358 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %334, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !107
  br label %if.end824.1

if.end824.1:                                      ; preds = %if.end737.1, %if.end674.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end674.1 ], [ %358, %if.end737.1 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end674.1 ], [ %357, %if.end737.1 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end674.1 ], [ %356, %if.end737.1 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end674.1 ], [ %355, %if.end737.1 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end674.1 ], [ %add788.3.1, %if.end737.1 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end674.1 ], [ %add788.2.1, %if.end737.1 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end674.1 ], [ %add788.1.1, %if.end737.1 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end674.1 ], [ %add788.11370, %if.end737.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add836 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add836.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add836.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add836.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add836.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add836.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add836.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add836.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add836.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add836.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add836.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add836.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add836.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add836.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add836.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add836.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add850 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add850.1 = fadd contract float %add850, %sum_acc.sroa.20.7
  %add850.2 = fadd contract float %add850.1, %sum_acc.sroa.38.7
  %add850.3 = fadd contract float %add850.2, %sum_acc.sroa.56.7
  %359 = bitcast float %add850.3 to i32
  %360 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %361 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %360) #11
  %xor.i.i = xor i32 %361, 32
  %362 = and i32 %361, -64
  %and.i.i = add nsw i32 %362, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i1212 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %361
  %shl.i.i = shl i32 %cond.i.i1212, 2
  %363 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %359)
  %364 = bitcast i32 %363 to float
  %add.i = fadd contract float %add850.3, %364
  %365 = bitcast float %add.i to i32
  %366 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %367 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %366) #11
  %xor.i.i1213 = xor i32 %367, 16
  %368 = and i32 %367, -64
  %and.i.i1214 = add nsw i32 %368, 64
  %cmp.not.i.i1215 = icmp slt i32 %xor.i.i1213, %and.i.i1214
  %cond.i.i1216 = select i1 %cmp.not.i.i1215, i32 %xor.i.i1213, i32 %367
  %shl.i.i1217 = shl i32 %cond.i.i1216, 2
  %369 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1217, i32 %365)
  %370 = bitcast i32 %369 to float
  %add.i.i = fadd contract float %add.i, %370
  %cmp859 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp859, float %div, float 0.000000e+00
  %mul872 = fmul contract float %condval_4.0, %add836
  %mul872.1 = fmul contract float %condval_4.0, %add836.1
  %mul872.2 = fmul contract float %condval_4.0, %add836.2
  %mul872.3 = fmul contract float %condval_4.0, %add836.3
  %mul872.4 = fmul contract float %condval_4.0, %add836.4
  %mul872.5 = fmul contract float %condval_4.0, %add836.5
  %mul872.6 = fmul contract float %condval_4.0, %add836.6
  %mul872.7 = fmul contract float %condval_4.0, %add836.7
  %mul872.8 = fmul contract float %condval_4.0, %add836.8
  %mul872.9 = fmul contract float %condval_4.0, %add836.9
  %mul872.10 = fmul contract float %condval_4.0, %add836.10
  %mul872.11 = fmul contract float %condval_4.0, %add836.11
  %mul872.12 = fmul contract float %condval_4.0, %add836.12
  %mul872.13 = fmul contract float %condval_4.0, %add836.13
  %mul872.14 = fmul contract float %condval_4.0, %add836.14
  %mul872.15 = fmul contract float %condval_4.0, %add836.15
  %371 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872)
  %O_reg.sroa.0.0.insert.ext = zext i16 %371 to i64
  %372 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %372 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %373 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %373 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %374 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %374 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %375 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %375 to i64
  %376 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %376 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %377 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %377 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %378 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %378 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %379 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %379 to i64
  %380 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %380 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %381 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %381 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %382 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %382 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %383 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %383 to i64
  %384 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %384 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %385 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %385 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %386 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %386 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr914 = lshr i32 %18, 5
  %and917 = and i32 %18, 7
  %mul923 = and i32 %22, 4
  %xor = xor i32 %shr914, %and917
  %mul918 = shl nuw nsw i32 %xor, 3
  %add919 = add nuw nsw i32 %mul918, %mul25
  %add924 = or disjoint i32 %add919, %mul923
  %add.ptr926 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr926, align 8
  %add915.1 = add nuw nsw i32 %shr914, 2
  %xor.1 = xor i32 %add915.1, %and917
  %mul918.1 = shl nuw nsw i32 %xor.1, 3
  %add919.1 = add nuw nsw i32 %mul918.1, %mul25
  %add924.1 = or disjoint i32 %add919.1, %mul923
  %add.ptr926.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr926.1, align 8
  %add915.2 = add nuw nsw i32 %shr914, 4
  %xor.2 = xor i32 %add915.2, %and917
  %mul918.2 = shl nuw nsw i32 %xor.2, 3
  %add919.2 = add nuw nsw i32 %mul918.2, %mul25
  %add924.2 = or disjoint i32 %add919.2, %mul923
  %add.ptr926.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr926.2, align 8
  %add915.3 = add nuw nsw i32 %shr914, 6
  %xor.3 = xor i32 %add915.3, %and917
  %mul918.3 = shl nuw nsw i32 %xor.3, 3
  %add919.3 = add nuw nsw i32 %mul918.3, %mul25
  %add924.3 = or disjoint i32 %add919.3, %mul923
  %add.ptr926.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr926.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul937 = and i32 %mul109, 8128
  %xor9431198 = and i32 %mul109, 56
  %call941.masked = and i32 %18, 1016
  %mul944 = xor i32 %xor9431198, %call941.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul937
  %invariant.gep1284 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul944
  %add954 = add nuw nsw i32 %add23, %mul109
  %387 = zext nneg i32 %add954 to i64
  %add.ptr959 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %387
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr959, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1284, i64 16, i1 false), !tbaa.struct !257, !call_argsrelate !258
  %gep1285.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1284, i32 1024
  %388 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %387
  %add.ptr959.1 = getelementptr inbounds i8, ptr addrspace(1) %388, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr959.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1285.1, i64 16, i1 false), !tbaa.struct !257, !call_argsrelate !258
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare float @llvm.exp.f32(float) #6

declare i16 @llvm.convert.to.fp16.f32(float) #7

declare void @llvm.mxc.barrier.warp() #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare i32 @llvm.smax.i32(i32, i32) #6

declare i32 @llvm.smin.i32(i32, i32) #6

declare float @llvm.minnum.f32(float, float) #6

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


