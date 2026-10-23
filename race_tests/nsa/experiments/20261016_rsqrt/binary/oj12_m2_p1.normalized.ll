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
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !call_argsrelate !48
  %cond.i.i1177 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i1177, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i1177.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i1177.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i1177.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i1177.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i1177.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i1177.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i1177.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i1177.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i1177.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i1177.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i1177.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i1177.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i1177.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i1177.7, 4
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
  %mul100 = shl nsw i32 %0, 16
  %mul107 = shl nuw nsw i32 %18, 3
  %add103 = or disjoint i32 %mul107, %mul100
  %invariant.op = add nsw i32 %1, -15
  %22 = lshr i32 %18, 2
  %mul251 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp94.not = icmp sgt i32 %mul11, %1
  %or.cond1253 = or i1 %or.cond, %cmp94.not
  br i1 %or.cond1253, label %if.end, label %for.cond95.preheader

for.cond95.preheader:                             ; preds = %entry
  %23 = shl nsw i32 %cond.i.i1177, 10
  %mul102 = and i32 %23, 64512
  %add105 = add nuw nsw i32 %add103, %mul102
  %24 = zext nneg i32 %add105 to i64
  %add.ptr110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %24
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr110, align 16
  %K_reg.sroa.6.0.add.ptr110.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr110, i64 8
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr110.sroa_idx, align 8
  %25 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %24
  %add.ptr110.1 = getelementptr inbounds i8, ptr addrspace(4) %25, i64 1024
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr110.1, align 16
  %K_reg.sroa.12.16.add.ptr110.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %25, i64 1032
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr110.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %for.cond95.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond95.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond95.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond95.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond95.preheader ]
  %or.cond1254 = icmp ugt i32 %mul11.1, 1023
  %cmp123.not = icmp sgt i32 %mul11.1, %1
  %or.cond1255 = or i1 %or.cond1254, %cmp123.not
  br i1 %or.cond1255, label %if.end148, label %for.cond125.preheader

for.cond125.preheader:                            ; preds = %if.end
  %26 = shl nsw i32 %cond.i.i1177.1, 10
  %mul132 = and i32 %26, 64512
  %add135 = add nuw nsw i32 %add103, %mul132
  %27 = zext nneg i32 %add135 to i64
  %add.ptr140 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr140, align 16
  %K_reg1.sroa.6.0.add.ptr140.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140, i64 8
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr140.sroa_idx, align 8
  %28 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27
  %add.ptr140.1 = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1024
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr140.1, align 16
  %K_reg1.sroa.12.16.add.ptr140.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1032
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr140.1.sroa_idx, align 8
  br label %if.end148

if.end148:                                        ; preds = %for.cond125.preheader, %if.end
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.12.16.copyload, %for.cond125.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.8.16.copyload, %for.cond125.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.6.0.copyload, %for.cond125.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond125.preheader ]
  %or.cond1256 = icmp ugt i32 %mul11.2, 1023
  %cmp154.not = icmp sgt i32 %mul11.2, %1
  %or.cond1257 = or i1 %or.cond1256, %cmp154.not
  br i1 %or.cond1257, label %if.end179, label %for.cond156.preheader

for.cond156.preheader:                            ; preds = %if.end148
  %29 = shl nsw i32 %cond.i.i1177.2, 10
  %mul163 = and i32 %29, 64512
  %add166 = add nuw nsw i32 %add103, %mul163
  %30 = zext nneg i32 %add166 to i64
  %add.ptr171 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr171, align 16
  %K_reg2.sroa.6.0.add.ptr171.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr171, i64 8
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr171.sroa_idx, align 8
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30
  %add.ptr171.1 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1024
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr171.1, align 16
  %K_reg2.sroa.12.16.add.ptr171.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1032
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr171.1.sroa_idx, align 8
  br label %if.end179

if.end179:                                        ; preds = %for.cond156.preheader, %if.end148
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end148 ], [ %K_reg2.sroa.12.16.copyload, %for.cond156.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end148 ], [ %K_reg2.sroa.8.16.copyload, %for.cond156.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end148 ], [ %K_reg2.sroa.6.0.copyload, %for.cond156.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end148 ], [ %K_reg2.sroa.0.0.copyload, %for.cond156.preheader ]
  %or.cond1258 = icmp ugt i32 %mul11.3, 1023
  %cmp185.not = icmp sgt i32 %mul11.3, %1
  %or.cond1259 = or i1 %or.cond1258, %cmp185.not
  br i1 %or.cond1259, label %if.end210, label %for.cond187.preheader

for.cond187.preheader:                            ; preds = %if.end179
  %32 = shl nsw i32 %cond.i.i1177.3, 10
  %mul194 = and i32 %32, 64512
  %add197 = add nuw nsw i32 %add103, %mul194
  %33 = zext nneg i32 %add197 to i64
  %add.ptr202 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %33
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr202, align 16
  %K_reg3.sroa.6.0.add.ptr202.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr202, i64 8
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr202.sroa_idx, align 8
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %33
  %add.ptr202.1 = getelementptr inbounds i8, ptr addrspace(4) %34, i64 1024
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr202.1, align 16
  %K_reg3.sroa.12.16.add.ptr202.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %34, i64 1032
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr202.1.sroa_idx, align 8
  br label %if.end210

if.end210:                                        ; preds = %for.cond187.preheader, %if.end179
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end179 ], [ %K_reg3.sroa.12.16.copyload, %for.cond187.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end179 ], [ %K_reg3.sroa.8.16.copyload, %for.cond187.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end179 ], [ %K_reg3.sroa.6.0.copyload, %for.cond187.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end179 ], [ %K_reg3.sroa.0.0.copyload, %for.cond187.preheader ]
  br i1 %or.cond1253, label %if.end355, label %for.cond218.preheader

for.cond218.preheader:                            ; preds = %if.end210
  %35 = shl nsw i32 %cond.i.i1177, 10
  %mul225 = and i32 %35, 64512
  %add228 = add nuw nsw i32 %add103, %mul225
  %36 = zext nneg i32 %add228 to i64
  %add.ptr233 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %36
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr233, align 16
  %V_reg.sroa.18.0.add.ptr233.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr233, i64 8
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr233.sroa_idx, align 8
  %37 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %36
  %add.ptr233.1 = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1024
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr233.1, align 16
  %V_reg.sroa.42.16.add.ptr233.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1032
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr233.1.sroa_idx, align 8
  %cmp243 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp243, label %for.cond245.preheader, label %if.end268

for.cond245.preheader:                            ; preds = %for.cond218.preheader
  %add252 = add nuw nsw i32 %mul11, %mul251
  %cmp255.not = icmp sgt i32 %add252, %1
  %fneg. = select i1 %cmp255.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1441 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp255.not.1.not = icmp slt i32 %add252, %1
  %fneg..1 = select i1 %cmp255.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1542 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1441, float %fneg..1, i64 1
  %add253.2 = or disjoint i32 %add252, 2
  %cmp255.not.2 = icmp sgt i32 %add253.2, %1
  %fneg..2 = select i1 %cmp255.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1635 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1542, float %fneg..2, i64 2
  %add253.3 = or disjoint i32 %add252, 3
  %cmp255.not.3 = icmp sgt i32 %add253.3, %1
  %fneg..3 = select i1 %cmp255.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1728 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1635, float %fneg..3, i64 3
  br label %if.end268

if.end268:                                        ; preds = %for.cond218.preheader, %for.cond245.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1728, %for.cond245.preheader ], [ zeroinitializer, %for.cond218.preheader ]
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !86
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %38), !call_argsrelate !86
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %39), !call_argsrelate !86
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %40), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %41, i64 0
  %mul303 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul303, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %41, i64 1
  %mul303.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul303.1, float 0x4024CB5EC0000000)
  %45 = tail call contract noundef float @llvm.exp.f32(float %44)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %41, i64 2
  %mul303.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul303.2, float 0x4024CB5EC0000000)
  %47 = tail call contract noundef float @llvm.exp.f32(float %46)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %41, i64 3
  %mul303.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul303.3, float 0x4024CB5EC0000000)
  %49 = tail call contract noundef float @llvm.exp.f32(float %48)
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %43)
  %51 = insertelement <4 x i16> poison, i16 %50, i64 0
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %45)
  %53 = insertelement <4 x i16> %51, i16 %52, i64 1
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %47)
  %55 = insertelement <4 x i16> %53, i16 %54, i64 2
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %49)
  %57 = insertelement <4 x i16> %55, i16 %56, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %57 to <4 x half>
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !106
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !106
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !106
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !106
  br label %if.end355

if.end355:                                        ; preds = %if.end268, %if.end210
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end210 ], [ %61, %if.end268 ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end210 ], [ %60, %if.end268 ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end210 ], [ %59, %if.end268 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end210 ], [ %58, %if.end268 ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end210 ], [ %49, %if.end268 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end210 ], [ %47, %if.end268 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end210 ], [ %45, %if.end268 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end210 ], [ %43, %if.end268 ]
  br i1 %or.cond1255, label %if.end501, label %for.cond363.preheader

for.cond363.preheader:                            ; preds = %if.end355
  %62 = shl nsw i32 %cond.i.i1177.1, 10
  %mul370 = and i32 %62, 64512
  %add373 = add nuw nsw i32 %add103, %mul370
  %63 = zext nneg i32 %add373 to i64
  %add.ptr378 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63
  %V_reg.sroa.0.0.copyload1813 = load <4 x half>, ptr addrspace(4) %add.ptr378, align 16
  %V_reg.sroa.18.0.add.ptr378.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr378, i64 8
  %V_reg.sroa.18.0.copyload1820 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr378.sroa_idx, align 8
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63
  %add.ptr378.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024
  %V_reg.sroa.26.16.copyload1841 = load <4 x half>, ptr addrspace(4) %add.ptr378.1, align 16
  %V_reg.sroa.42.16.add.ptr378.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032
  %V_reg.sroa.42.16.copyload1848 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr378.1.sroa_idx, align 8
  %cmp388 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp388, label %for.cond390.preheader, label %if.end414

for.cond390.preheader:                            ; preds = %for.cond363.preheader
  %add397 = add nuw nsw i32 %mul11.1, %mul251
  %cmp400.not = icmp sgt i32 %add397, %1
  %fneg.1166 = select i1 %cmp400.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1450 = insertelement <4 x float> poison, float %fneg.1166, i64 0
  %cmp400.not.1.not = icmp slt i32 %add397, %1
  %fneg.1166.1 = select i1 %cmp400.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1551 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1450, float %fneg.1166.1, i64 1
  %add398.2 = or disjoint i32 %add397, 2
  %cmp400.not.2 = icmp sgt i32 %add398.2, %1
  %fneg.1166.2 = select i1 %cmp400.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1644 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1551, float %fneg.1166.2, i64 2
  %add398.3 = or disjoint i32 %add397, 3
  %cmp400.not.3 = icmp sgt i32 %add398.3, %1
  %fneg.1166.3 = select i1 %cmp400.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1737 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1644, float %fneg.1166.3, i64 3
  br label %if.end414

if.end414:                                        ; preds = %for.cond363.preheader, %for.cond390.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1737, %for.cond390.preheader ], [ zeroinitializer, %for.cond363.preheader ]
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !86
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %65), !call_argsrelate !86
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %66), !call_argsrelate !86
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %67), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1452 = extractelement <4 x float> %68, i64 0
  %mul449 = fmul contract float %acc_s.sroa.0.0.vec.extract1452, 0x3FB99999A0000000
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul449, float 0x4024CB5EC0000000)
  %70 = tail call contract noundef float @llvm.exp.f32(float %69)
  %acc_s.sroa.0.4.vec.extract1553 = extractelement <4 x float> %68, i64 1
  %mul449.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1553, 0x3FB99999A0000000
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul449.1, float 0x4024CB5EC0000000)
  %72 = tail call contract noundef float @llvm.exp.f32(float %71)
  %acc_s.sroa.0.8.vec.extract1646 = extractelement <4 x float> %68, i64 2
  %mul449.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1646, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul449.2, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %acc_s.sroa.0.12.vec.extract1739 = extractelement <4 x float> %68, i64 3
  %mul449.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1739, 0x3FB99999A0000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul449.3, float 0x4024CB5EC0000000)
  %76 = tail call contract noundef float @llvm.exp.f32(float %75)
  %add465 = fadd contract float %sum_acc.sroa.0.0, %70
  %add465.1 = fadd contract float %sum_acc.sroa.20.0, %72
  %add465.2 = fadd contract float %sum_acc.sroa.38.0, %74
  %add465.3 = fadd contract float %sum_acc.sroa.56.0, %76
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %70)
  %78 = insertelement <4 x i16> poison, i16 %77, i64 0
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %72)
  %80 = insertelement <4 x i16> %78, i16 %79, i64 1
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %82 = insertelement <4 x i16> %80, i16 %81, i64 2
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76)
  %84 = insertelement <4 x i16> %82, i16 %83, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1413 = bitcast <4 x i16> %84 to <4 x half>
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1813, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> zeroinitializer), !call_argsrelate !106
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1820, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> zeroinitializer), !call_argsrelate !106
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1841, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> zeroinitializer), !call_argsrelate !106
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1848, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> zeroinitializer), !call_argsrelate !106
  br label %if.end501

if.end501:                                        ; preds = %if.end414, %if.end355
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end355 ], [ %88, %if.end414 ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end355 ], [ %87, %if.end414 ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end355 ], [ %86, %if.end414 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end355 ], [ %85, %if.end414 ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end355 ], [ %add465.3, %if.end414 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end355 ], [ %add465.2, %if.end414 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end355 ], [ %add465.1, %if.end414 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end355 ], [ %add465, %if.end414 ]
  br i1 %or.cond1257, label %if.end647, label %for.cond509.preheader

for.cond509.preheader:                            ; preds = %if.end501
  %89 = shl nsw i32 %cond.i.i1177.2, 10
  %mul516 = and i32 %89, 64512
  %add519 = add nuw nsw i32 %add103, %mul516
  %90 = zext nneg i32 %add519 to i64
  %add.ptr524 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90
  %V_reg.sroa.0.0.copyload1814 = load <4 x half>, ptr addrspace(4) %add.ptr524, align 16
  %V_reg.sroa.18.0.add.ptr524.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr524, i64 8
  %V_reg.sroa.18.0.copyload1821 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr524.sroa_idx, align 8
  %91 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90
  %add.ptr524.1 = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1024
  %V_reg.sroa.26.16.copyload1842 = load <4 x half>, ptr addrspace(4) %add.ptr524.1, align 16
  %V_reg.sroa.42.16.add.ptr524.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1032
  %V_reg.sroa.42.16.copyload1849 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr524.1.sroa_idx, align 8
  %cmp534 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp534, label %for.cond536.preheader, label %if.end560

for.cond536.preheader:                            ; preds = %for.cond509.preheader
  %add543 = add nuw nsw i32 %mul11.2, %mul251
  %cmp546.not = icmp sgt i32 %add543, %1
  %fneg.1167 = select i1 %cmp546.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1460 = insertelement <4 x float> poison, float %fneg.1167, i64 0
  %cmp546.not.1.not = icmp slt i32 %add543, %1
  %fneg.1167.1 = select i1 %cmp546.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1561 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1460, float %fneg.1167.1, i64 1
  %add544.2 = or disjoint i32 %add543, 2
  %cmp546.not.2 = icmp sgt i32 %add544.2, %1
  %fneg.1167.2 = select i1 %cmp546.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1654 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1561, float %fneg.1167.2, i64 2
  %add544.3 = or disjoint i32 %add543, 3
  %cmp546.not.3 = icmp sgt i32 %add544.3, %1
  %fneg.1167.3 = select i1 %cmp546.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1747 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1654, float %fneg.1167.3, i64 3
  br label %if.end560

if.end560:                                        ; preds = %for.cond509.preheader, %for.cond536.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1747, %for.cond536.preheader ], [ zeroinitializer, %for.cond509.preheader ]
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !86
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %92), !call_argsrelate !86
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %93), !call_argsrelate !86
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %94), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1462 = extractelement <4 x float> %95, i64 0
  %mul595 = fmul contract float %acc_s.sroa.0.0.vec.extract1462, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul595, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %acc_s.sroa.0.4.vec.extract1563 = extractelement <4 x float> %95, i64 1
  %mul595.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1563, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul595.1, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %acc_s.sroa.0.8.vec.extract1656 = extractelement <4 x float> %95, i64 2
  %mul595.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1656, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul595.2, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %acc_s.sroa.0.12.vec.extract1749 = extractelement <4 x float> %95, i64 3
  %mul595.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1749, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul595.3, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %add611 = fadd contract float %sum_acc.sroa.0.1, %97
  %add611.1 = fadd contract float %sum_acc.sroa.20.1, %99
  %add611.2 = fadd contract float %sum_acc.sroa.38.1, %101
  %add611.3 = fadd contract float %sum_acc.sroa.56.1, %103
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %105 = insertelement <4 x i16> poison, i16 %104, i64 0
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %107 = insertelement <4 x i16> %105, i16 %106, i64 1
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %109 = insertelement <4 x i16> %107, i16 %108, i64 2
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %111 = insertelement <4 x i16> %109, i16 %110, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1415 = bitcast <4 x i16> %111 to <4 x half>
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1814, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !106
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1821, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.34.0), !call_argsrelate !106
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1842, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.66.0), !call_argsrelate !106
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1849, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.98.0), !call_argsrelate !106
  br label %if.end647

if.end647:                                        ; preds = %if.end560, %if.end501
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end501 ], [ %115, %if.end560 ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end501 ], [ %114, %if.end560 ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end501 ], [ %113, %if.end560 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end501 ], [ %112, %if.end560 ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end501 ], [ %add611.3, %if.end560 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end501 ], [ %add611.2, %if.end560 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end501 ], [ %add611.1, %if.end560 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end501 ], [ %add611, %if.end560 ]
  br i1 %or.cond1259, label %if.end793, label %for.cond655.preheader

for.cond655.preheader:                            ; preds = %if.end647
  %116 = shl nsw i32 %cond.i.i1177.3, 10
  %mul662 = and i32 %116, 64512
  %add665 = add nuw nsw i32 %add103, %mul662
  %117 = zext nneg i32 %add665 to i64
  %add.ptr670 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117
  %V_reg.sroa.0.0.copyload1815 = load <4 x half>, ptr addrspace(4) %add.ptr670, align 16
  %V_reg.sroa.18.0.add.ptr670.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr670, i64 8
  %V_reg.sroa.18.0.copyload1822 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr670.sroa_idx, align 8
  %118 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117
  %add.ptr670.1 = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1024
  %V_reg.sroa.26.16.copyload1843 = load <4 x half>, ptr addrspace(4) %add.ptr670.1, align 16
  %V_reg.sroa.42.16.add.ptr670.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1032
  %V_reg.sroa.42.16.copyload1850 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr670.1.sroa_idx, align 8
  %cmp680 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp680, label %for.cond682.preheader, label %if.end706

for.cond682.preheader:                            ; preds = %for.cond655.preheader
  %add689 = add nuw nsw i32 %mul11.3, %mul251
  %cmp692.not = icmp sgt i32 %add689, %1
  %fneg.1168 = select i1 %cmp692.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1470 = insertelement <4 x float> poison, float %fneg.1168, i64 0
  %cmp692.not.1.not = icmp slt i32 %add689, %1
  %fneg.1168.1 = select i1 %cmp692.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1571 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1470, float %fneg.1168.1, i64 1
  %add690.2 = or disjoint i32 %add689, 2
  %cmp692.not.2 = icmp sgt i32 %add690.2, %1
  %fneg.1168.2 = select i1 %cmp692.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1664 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1571, float %fneg.1168.2, i64 2
  %add690.3 = or disjoint i32 %add689, 3
  %cmp692.not.3 = icmp sgt i32 %add690.3, %1
  %fneg.1168.3 = select i1 %cmp692.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1757 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1664, float %fneg.1168.3, i64 3
  br label %if.end706

if.end706:                                        ; preds = %for.cond655.preheader, %for.cond682.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1757, %for.cond682.preheader ], [ zeroinitializer, %for.cond655.preheader ]
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !86
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %119), !call_argsrelate !86
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %120), !call_argsrelate !86
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %121), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1472 = extractelement <4 x float> %122, i64 0
  %mul741 = fmul contract float %acc_s.sroa.0.0.vec.extract1472, 0x3FB99999A0000000
  %123 = tail call contract noundef float @llvm.minnum.f32(float %mul741, float 0x4024CB5EC0000000)
  %124 = tail call contract noundef float @llvm.exp.f32(float %123)
  %acc_s.sroa.0.4.vec.extract1573 = extractelement <4 x float> %122, i64 1
  %mul741.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1573, 0x3FB99999A0000000
  %125 = tail call contract noundef float @llvm.minnum.f32(float %mul741.1, float 0x4024CB5EC0000000)
  %126 = tail call contract noundef float @llvm.exp.f32(float %125)
  %acc_s.sroa.0.8.vec.extract1666 = extractelement <4 x float> %122, i64 2
  %mul741.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1666, 0x3FB99999A0000000
  %127 = tail call contract noundef float @llvm.minnum.f32(float %mul741.2, float 0x4024CB5EC0000000)
  %128 = tail call contract noundef float @llvm.exp.f32(float %127)
  %acc_s.sroa.0.12.vec.extract1759 = extractelement <4 x float> %122, i64 3
  %mul741.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1759, 0x3FB99999A0000000
  %129 = tail call contract noundef float @llvm.minnum.f32(float %mul741.3, float 0x4024CB5EC0000000)
  %130 = tail call contract noundef float @llvm.exp.f32(float %129)
  %add757 = fadd contract float %sum_acc.sroa.0.2, %124
  %add757.1 = fadd contract float %sum_acc.sroa.20.2, %126
  %add757.2 = fadd contract float %sum_acc.sroa.38.2, %128
  %add757.3 = fadd contract float %sum_acc.sroa.56.2, %130
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %124)
  %132 = insertelement <4 x i16> poison, i16 %131, i64 0
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %126)
  %134 = insertelement <4 x i16> %132, i16 %133, i64 1
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %128)
  %136 = insertelement <4 x i16> %134, i16 %135, i64 2
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %130)
  %138 = insertelement <4 x i16> %136, i16 %137, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1417 = bitcast <4 x i16> %138 to <4 x half>
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1815, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !106
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1822, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.18.0), !call_argsrelate !106
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1843, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.34.0), !call_argsrelate !106
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1850, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !106
  br label %if.end793

if.end793:                                        ; preds = %if.end706, %if.end647
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end647 ], [ %142, %if.end706 ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end647 ], [ %141, %if.end706 ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end647 ], [ %140, %if.end706 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end647 ], [ %139, %if.end706 ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end647 ], [ %add757.3, %if.end706 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end647 ], [ %add757.2, %if.end706 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end647 ], [ %add757.1, %if.end706 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end647 ], [ %add757, %if.end706 ]
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023
  %cmp94.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond1253.1 = or i1 %or.cond.1, %cmp94.not.1
  br i1 %or.cond1253.1, label %if.end.1, label %for.cond95.preheader.1

for.cond95.preheader.1:                           ; preds = %if.end793
  %143 = shl nsw i32 %cond.i.i1177.4, 10
  %mul102.1 = and i32 %143, 64512
  %add105.1 = add nuw nsw i32 %add103, %mul102.1
  %144 = zext nneg i32 %add105.1 to i64
  %add.ptr110.11317 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %144
  %K_reg.sroa.0.0.copyload1887 = load <4 x half>, ptr addrspace(4) %add.ptr110.11317, align 16
  %K_reg.sroa.6.0.add.ptr110.11317.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr110.11317, i64 8
  %K_reg.sroa.6.0.copyload1888 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr110.11317.sroa_idx, align 8
  %145 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %144
  %add.ptr110.1.1 = getelementptr inbounds i8, ptr addrspace(4) %145, i64 1024
  %K_reg.sroa.8.16.copyload1891 = load <4 x half>, ptr addrspace(4) %add.ptr110.1.1, align 16
  %K_reg.sroa.12.16.add.ptr110.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %145, i64 1032
  %K_reg.sroa.12.16.copyload1892 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr110.1.1.sroa_idx, align 8
  br label %if.end.1

if.end.1:                                         ; preds = %for.cond95.preheader.1, %if.end793
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end793 ], [ %K_reg.sroa.12.16.copyload1892, %for.cond95.preheader.1 ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end793 ], [ %K_reg.sroa.8.16.copyload1891, %for.cond95.preheader.1 ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end793 ], [ %K_reg.sroa.6.0.copyload1888, %for.cond95.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end793 ], [ %K_reg.sroa.0.0.copyload1887, %for.cond95.preheader.1 ]
  %or.cond1254.1 = icmp ugt i32 %mul11.5, 1023
  %cmp123.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond1255.1 = or i1 %or.cond1254.1, %cmp123.not.1
  br i1 %or.cond1255.1, label %if.end148.1, label %for.cond125.preheader.1

for.cond125.preheader.1:                          ; preds = %if.end.1
  %146 = shl nsw i32 %cond.i.i1177.5, 10
  %mul132.1 = and i32 %146, 64512
  %add135.1 = add nuw nsw i32 %add103, %mul132.1
  %147 = zext nneg i32 %add135.1 to i64
  %add.ptr140.11318 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %147
  %K_reg1.sroa.0.0.copyload1879 = load <4 x half>, ptr addrspace(4) %add.ptr140.11318, align 16
  %K_reg1.sroa.6.0.add.ptr140.11318.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.11318, i64 8
  %K_reg1.sroa.6.0.copyload1880 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr140.11318.sroa_idx, align 8
  %148 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %147
  %add.ptr140.1.1 = getelementptr inbounds i8, ptr addrspace(4) %148, i64 1024
  %K_reg1.sroa.8.16.copyload1883 = load <4 x half>, ptr addrspace(4) %add.ptr140.1.1, align 16
  %K_reg1.sroa.12.16.add.ptr140.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %148, i64 1032
  %K_reg1.sroa.12.16.copyload1884 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr140.1.1.sroa_idx, align 8
  br label %if.end148.1

if.end148.1:                                      ; preds = %for.cond125.preheader.1, %if.end.1
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %K_reg1.sroa.12.16.copyload1884, %for.cond125.preheader.1 ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end.1 ], [ %K_reg1.sroa.8.16.copyload1883, %for.cond125.preheader.1 ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end.1 ], [ %K_reg1.sroa.6.0.copyload1880, %for.cond125.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %K_reg1.sroa.0.0.copyload1879, %for.cond125.preheader.1 ]
  %or.cond1256.1 = icmp ugt i32 %mul11.6, 1023
  %cmp154.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond1257.1 = or i1 %or.cond1256.1, %cmp154.not.1
  br i1 %or.cond1257.1, label %if.end179.1, label %for.cond156.preheader.1

for.cond156.preheader.1:                          ; preds = %if.end148.1
  %149 = shl nsw i32 %cond.i.i1177.6, 10
  %mul163.1 = and i32 %149, 64512
  %add166.1 = add nuw nsw i32 %add103, %mul163.1
  %150 = zext nneg i32 %add166.1 to i64
  %add.ptr171.11319 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150
  %K_reg2.sroa.0.0.copyload1871 = load <4 x half>, ptr addrspace(4) %add.ptr171.11319, align 16
  %K_reg2.sroa.6.0.add.ptr171.11319.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr171.11319, i64 8
  %K_reg2.sroa.6.0.copyload1872 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr171.11319.sroa_idx, align 8
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150
  %add.ptr171.1.1 = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1024
  %K_reg2.sroa.8.16.copyload1875 = load <4 x half>, ptr addrspace(4) %add.ptr171.1.1, align 16
  %K_reg2.sroa.12.16.add.ptr171.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1032
  %K_reg2.sroa.12.16.copyload1876 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr171.1.1.sroa_idx, align 8
  br label %if.end179.1

if.end179.1:                                      ; preds = %for.cond156.preheader.1, %if.end148.1
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end148.1 ], [ %K_reg2.sroa.12.16.copyload1876, %for.cond156.preheader.1 ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end148.1 ], [ %K_reg2.sroa.8.16.copyload1875, %for.cond156.preheader.1 ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end148.1 ], [ %K_reg2.sroa.6.0.copyload1872, %for.cond156.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end148.1 ], [ %K_reg2.sroa.0.0.copyload1871, %for.cond156.preheader.1 ]
  %or.cond1258.1 = icmp ugt i32 %mul11.7, 1023
  %cmp185.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond1259.1 = or i1 %or.cond1258.1, %cmp185.not.1
  br i1 %or.cond1259.1, label %if.end210.1, label %for.cond187.preheader.1

for.cond187.preheader.1:                          ; preds = %if.end179.1
  %152 = shl nsw i32 %cond.i.i1177.7, 10
  %mul194.1 = and i32 %152, 64512
  %add197.1 = add nuw nsw i32 %add103, %mul194.1
  %153 = zext nneg i32 %add197.1 to i64
  %add.ptr202.11320 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153
  %K_reg3.sroa.0.0.copyload1863 = load <4 x half>, ptr addrspace(4) %add.ptr202.11320, align 16
  %K_reg3.sroa.6.0.add.ptr202.11320.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr202.11320, i64 8
  %K_reg3.sroa.6.0.copyload1864 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr202.11320.sroa_idx, align 8
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153
  %add.ptr202.1.1 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024
  %K_reg3.sroa.8.16.copyload1867 = load <4 x half>, ptr addrspace(4) %add.ptr202.1.1, align 16
  %K_reg3.sroa.12.16.add.ptr202.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1032
  %K_reg3.sroa.12.16.copyload1868 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr202.1.1.sroa_idx, align 8
  br label %if.end210.1

if.end210.1:                                      ; preds = %for.cond187.preheader.1, %if.end179.1
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end179.1 ], [ %K_reg3.sroa.12.16.copyload1868, %for.cond187.preheader.1 ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end179.1 ], [ %K_reg3.sroa.8.16.copyload1867, %for.cond187.preheader.1 ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end179.1 ], [ %K_reg3.sroa.6.0.copyload1864, %for.cond187.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end179.1 ], [ %K_reg3.sroa.0.0.copyload1863, %for.cond187.preheader.1 ]
  br i1 %or.cond1253.1, label %if.end355.1, label %for.cond218.preheader.1

for.cond218.preheader.1:                          ; preds = %if.end210.1
  %155 = shl nsw i32 %cond.i.i1177.4, 10
  %mul225.1 = and i32 %155, 64512
  %add228.1 = add nuw nsw i32 %add103, %mul225.1
  %156 = zext nneg i32 %add228.1 to i64
  %add.ptr233.11321 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156
  %V_reg.sroa.0.0.copyload1816 = load <4 x half>, ptr addrspace(4) %add.ptr233.11321, align 16
  %V_reg.sroa.18.0.add.ptr233.11321.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr233.11321, i64 8
  %V_reg.sroa.18.0.copyload1823 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr233.11321.sroa_idx, align 8
  %157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156
  %add.ptr233.1.1 = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1024
  %V_reg.sroa.26.16.copyload1844 = load <4 x half>, ptr addrspace(4) %add.ptr233.1.1, align 16
  %V_reg.sroa.42.16.add.ptr233.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1032
  %V_reg.sroa.42.16.copyload1851 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr233.1.1.sroa_idx, align 8
  %cmp243.1 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp243.1, label %for.cond245.preheader.1, label %if.end268.1

for.cond245.preheader.1:                          ; preds = %for.cond218.preheader.1
  %add252.1 = add nuw nsw i32 %mul11.4, %mul251
  %cmp255.not.11322 = icmp sgt i32 %add252.1, %1
  %fneg..11323 = select i1 %cmp255.not.11322, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1482 = insertelement <4 x float> poison, float %fneg..11323, i64 0
  %cmp255.not.1.1.not = icmp slt i32 %add252.1, %1
  %fneg..1.1 = select i1 %cmp255.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1581 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1482, float %fneg..1.1, i64 1
  %add253.2.1 = or disjoint i32 %add252.1, 2
  %cmp255.not.2.1 = icmp sgt i32 %add253.2.1, %1
  %fneg..2.1 = select i1 %cmp255.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1674 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1581, float %fneg..2.1, i64 2
  %add253.3.1 = or disjoint i32 %add252.1, 3
  %cmp255.not.3.1 = icmp sgt i32 %add253.3.1, %1
  %fneg..3.1 = select i1 %cmp255.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1767 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1674, float %fneg..3.1, i64 3
  br label %if.end268.1

if.end268.1:                                      ; preds = %for.cond218.preheader.1, %for.cond245.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1767, %for.cond245.preheader.1 ], [ zeroinitializer, %for.cond218.preheader.1 ]
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !86
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %158), !call_argsrelate !86
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %159), !call_argsrelate !86
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %160), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1484 = extractelement <4 x float> %161, i64 0
  %mul303.11327 = fmul contract float %acc_s.sroa.0.0.vec.extract1484, 0x3FB99999A0000000
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul303.11327, float 0x4024CB5EC0000000)
  %163 = tail call contract noundef float @llvm.exp.f32(float %162)
  %acc_s.sroa.0.4.vec.extract1583 = extractelement <4 x float> %161, i64 1
  %mul303.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1583, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul303.1.1, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %acc_s.sroa.0.8.vec.extract1676 = extractelement <4 x float> %161, i64 2
  %mul303.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1676, 0x3FB99999A0000000
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul303.2.1, float 0x4024CB5EC0000000)
  %167 = tail call contract noundef float @llvm.exp.f32(float %166)
  %acc_s.sroa.0.12.vec.extract1769 = extractelement <4 x float> %161, i64 3
  %mul303.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1769, 0x3FB99999A0000000
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul303.3.1, float 0x4024CB5EC0000000)
  %169 = tail call contract noundef float @llvm.exp.f32(float %168)
  %add319.11328 = fadd contract float %sum_acc.sroa.0.3, %163
  %add319.1.1 = fadd contract float %sum_acc.sroa.20.3, %165
  %add319.2.1 = fadd contract float %sum_acc.sroa.38.3, %167
  %add319.3.1 = fadd contract float %sum_acc.sroa.56.3, %169
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163)
  %171 = insertelement <4 x i16> poison, i16 %170, i64 0
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %173 = insertelement <4 x i16> %171, i16 %172, i64 1
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167)
  %175 = insertelement <4 x i16> %173, i16 %174, i64 2
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169)
  %177 = insertelement <4 x i16> %175, i16 %176, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1419 = bitcast <4 x i16> %177 to <4 x half>
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1816, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.0.1), !call_argsrelate !106
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1823, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.34.1), !call_argsrelate !106
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1844, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.66.1), !call_argsrelate !106
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1851, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.98.1), !call_argsrelate !106
  br label %if.end355.1

if.end355.1:                                      ; preds = %if.end268.1, %if.end210.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end210.1 ], [ %181, %if.end268.1 ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end210.1 ], [ %180, %if.end268.1 ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end210.1 ], [ %179, %if.end268.1 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end210.1 ], [ %178, %if.end268.1 ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end210.1 ], [ %add319.3.1, %if.end268.1 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end210.1 ], [ %add319.2.1, %if.end268.1 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end210.1 ], [ %add319.1.1, %if.end268.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end210.1 ], [ %add319.11328, %if.end268.1 ]
  br i1 %or.cond1255.1, label %if.end501.1, label %for.cond363.preheader.1

for.cond363.preheader.1:                          ; preds = %if.end355.1
  %182 = shl nsw i32 %cond.i.i1177.5, 10
  %mul370.1 = and i32 %182, 64512
  %add373.1 = add nuw nsw i32 %add103, %mul370.1
  %183 = zext nneg i32 %add373.1 to i64
  %add.ptr378.11329 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %V_reg.sroa.0.0.copyload1817 = load <4 x half>, ptr addrspace(4) %add.ptr378.11329, align 16
  %V_reg.sroa.18.0.add.ptr378.11329.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr378.11329, i64 8
  %V_reg.sroa.18.0.copyload1824 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr378.11329.sroa_idx, align 8
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %add.ptr378.1.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024
  %V_reg.sroa.26.16.copyload1845 = load <4 x half>, ptr addrspace(4) %add.ptr378.1.1, align 16
  %V_reg.sroa.42.16.add.ptr378.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032
  %V_reg.sroa.42.16.copyload1852 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr378.1.1.sroa_idx, align 8
  %cmp388.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp388.1, label %for.cond390.preheader.1, label %if.end414.1

for.cond390.preheader.1:                          ; preds = %for.cond363.preheader.1
  %add397.1 = add nuw nsw i32 %mul11.5, %mul251
  %cmp400.not.11330 = icmp sgt i32 %add397.1, %1
  %fneg.1166.11331 = select i1 %cmp400.not.11330, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1494 = insertelement <4 x float> poison, float %fneg.1166.11331, i64 0
  %cmp400.not.1.1.not = icmp slt i32 %add397.1, %1
  %fneg.1166.1.1 = select i1 %cmp400.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1591 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1494, float %fneg.1166.1.1, i64 1
  %add398.2.1 = or disjoint i32 %add397.1, 2
  %cmp400.not.2.1 = icmp sgt i32 %add398.2.1, %1
  %fneg.1166.2.1 = select i1 %cmp400.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1684 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1591, float %fneg.1166.2.1, i64 2
  %add398.3.1 = or disjoint i32 %add397.1, 3
  %cmp400.not.3.1 = icmp sgt i32 %add398.3.1, %1
  %fneg.1166.3.1 = select i1 %cmp400.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1777 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1684, float %fneg.1166.3.1, i64 3
  br label %if.end414.1

if.end414.1:                                      ; preds = %for.cond363.preheader.1, %for.cond390.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1777, %for.cond390.preheader.1 ], [ zeroinitializer, %for.cond363.preheader.1 ]
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !86
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %185), !call_argsrelate !86
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %186), !call_argsrelate !86
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %187), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1496 = extractelement <4 x float> %188, i64 0
  %mul449.11335 = fmul contract float %acc_s.sroa.0.0.vec.extract1496, 0x3FB99999A0000000
  %189 = tail call contract noundef float @llvm.minnum.f32(float %mul449.11335, float 0x4024CB5EC0000000)
  %190 = tail call contract noundef float @llvm.exp.f32(float %189)
  %acc_s.sroa.0.4.vec.extract1593 = extractelement <4 x float> %188, i64 1
  %mul449.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1593, 0x3FB99999A0000000
  %191 = tail call contract noundef float @llvm.minnum.f32(float %mul449.1.1, float 0x4024CB5EC0000000)
  %192 = tail call contract noundef float @llvm.exp.f32(float %191)
  %acc_s.sroa.0.8.vec.extract1686 = extractelement <4 x float> %188, i64 2
  %mul449.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1686, 0x3FB99999A0000000
  %193 = tail call contract noundef float @llvm.minnum.f32(float %mul449.2.1, float 0x4024CB5EC0000000)
  %194 = tail call contract noundef float @llvm.exp.f32(float %193)
  %acc_s.sroa.0.12.vec.extract1779 = extractelement <4 x float> %188, i64 3
  %mul449.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1779, 0x3FB99999A0000000
  %195 = tail call contract noundef float @llvm.minnum.f32(float %mul449.3.1, float 0x4024CB5EC0000000)
  %196 = tail call contract noundef float @llvm.exp.f32(float %195)
  %add465.11336 = fadd contract float %sum_acc.sroa.0.4, %190
  %add465.1.1 = fadd contract float %sum_acc.sroa.20.4, %192
  %add465.2.1 = fadd contract float %sum_acc.sroa.38.4, %194
  %add465.3.1 = fadd contract float %sum_acc.sroa.56.4, %196
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %190)
  %198 = insertelement <4 x i16> poison, i16 %197, i64 0
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %192)
  %200 = insertelement <4 x i16> %198, i16 %199, i64 1
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %194)
  %202 = insertelement <4 x i16> %200, i16 %201, i64 2
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %196)
  %204 = insertelement <4 x i16> %202, i16 %203, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1421 = bitcast <4 x i16> %204 to <4 x half>
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1817, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !106
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1824, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.18.1), !call_argsrelate !106
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1845, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.34.1), !call_argsrelate !106
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1852, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !106
  br label %if.end501.1

if.end501.1:                                      ; preds = %if.end414.1, %if.end355.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end355.1 ], [ %208, %if.end414.1 ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end355.1 ], [ %207, %if.end414.1 ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end355.1 ], [ %206, %if.end414.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end355.1 ], [ %205, %if.end414.1 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end355.1 ], [ %add465.3.1, %if.end414.1 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end355.1 ], [ %add465.2.1, %if.end414.1 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end355.1 ], [ %add465.1.1, %if.end414.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end355.1 ], [ %add465.11336, %if.end414.1 ]
  br i1 %or.cond1257.1, label %if.end647.1, label %for.cond509.preheader.1

for.cond509.preheader.1:                          ; preds = %if.end501.1
  %209 = shl nsw i32 %cond.i.i1177.6, 10
  %mul516.1 = and i32 %209, 64512
  %add519.1 = add nuw nsw i32 %add103, %mul516.1
  %210 = zext nneg i32 %add519.1 to i64
  %add.ptr524.11337 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210
  %V_reg.sroa.0.0.copyload1818 = load <4 x half>, ptr addrspace(4) %add.ptr524.11337, align 16
  %V_reg.sroa.18.0.add.ptr524.11337.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr524.11337, i64 8
  %V_reg.sroa.18.0.copyload1825 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr524.11337.sroa_idx, align 8
  %211 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210
  %add.ptr524.1.1 = getelementptr inbounds i8, ptr addrspace(4) %211, i64 1024
  %V_reg.sroa.26.16.copyload1846 = load <4 x half>, ptr addrspace(4) %add.ptr524.1.1, align 16
  %V_reg.sroa.42.16.add.ptr524.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %211, i64 1032
  %V_reg.sroa.42.16.copyload1853 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr524.1.1.sroa_idx, align 8
  %cmp534.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp534.1, label %for.cond536.preheader.1, label %if.end560.1

for.cond536.preheader.1:                          ; preds = %for.cond509.preheader.1
  %add543.1 = add nuw nsw i32 %mul11.6, %mul251
  %cmp546.not.11338 = icmp sgt i32 %add543.1, %1
  %fneg.1167.11339 = select i1 %cmp546.not.11338, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1506 = insertelement <4 x float> poison, float %fneg.1167.11339, i64 0
  %cmp546.not.1.1.not = icmp slt i32 %add543.1, %1
  %fneg.1167.1.1 = select i1 %cmp546.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1601 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1506, float %fneg.1167.1.1, i64 1
  %add544.2.1 = or disjoint i32 %add543.1, 2
  %cmp546.not.2.1 = icmp sgt i32 %add544.2.1, %1
  %fneg.1167.2.1 = select i1 %cmp546.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1694 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1601, float %fneg.1167.2.1, i64 2
  %add544.3.1 = or disjoint i32 %add543.1, 3
  %cmp546.not.3.1 = icmp sgt i32 %add544.3.1, %1
  %fneg.1167.3.1 = select i1 %cmp546.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1787 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1694, float %fneg.1167.3.1, i64 3
  br label %if.end560.1

if.end560.1:                                      ; preds = %for.cond509.preheader.1, %for.cond536.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1787, %for.cond536.preheader.1 ], [ zeroinitializer, %for.cond509.preheader.1 ]
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !86
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %212), !call_argsrelate !86
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %213), !call_argsrelate !86
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %214), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1508 = extractelement <4 x float> %215, i64 0
  %mul595.11343 = fmul contract float %acc_s.sroa.0.0.vec.extract1508, 0x3FB99999A0000000
  %216 = tail call contract noundef float @llvm.minnum.f32(float %mul595.11343, float 0x4024CB5EC0000000)
  %217 = tail call contract noundef float @llvm.exp.f32(float %216)
  %acc_s.sroa.0.4.vec.extract1603 = extractelement <4 x float> %215, i64 1
  %mul595.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1603, 0x3FB99999A0000000
  %218 = tail call contract noundef float @llvm.minnum.f32(float %mul595.1.1, float 0x4024CB5EC0000000)
  %219 = tail call contract noundef float @llvm.exp.f32(float %218)
  %acc_s.sroa.0.8.vec.extract1696 = extractelement <4 x float> %215, i64 2
  %mul595.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1696, 0x3FB99999A0000000
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul595.2.1, float 0x4024CB5EC0000000)
  %221 = tail call contract noundef float @llvm.exp.f32(float %220)
  %acc_s.sroa.0.12.vec.extract1789 = extractelement <4 x float> %215, i64 3
  %mul595.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1789, 0x3FB99999A0000000
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul595.3.1, float 0x4024CB5EC0000000)
  %223 = tail call contract noundef float @llvm.exp.f32(float %222)
  %add611.11344 = fadd contract float %sum_acc.sroa.0.5, %217
  %add611.1.1 = fadd contract float %sum_acc.sroa.20.5, %219
  %add611.2.1 = fadd contract float %sum_acc.sroa.38.5, %221
  %add611.3.1 = fadd contract float %sum_acc.sroa.56.5, %223
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %217)
  %225 = insertelement <4 x i16> poison, i16 %224, i64 0
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %219)
  %227 = insertelement <4 x i16> %225, i16 %226, i64 1
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221)
  %229 = insertelement <4 x i16> %227, i16 %228, i64 2
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223)
  %231 = insertelement <4 x i16> %229, i16 %230, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1423 = bitcast <4 x i16> %231 to <4 x half>
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1818, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !106
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1825, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> %acc_o.sroa.34.2), !call_argsrelate !106
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1846, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> %acc_o.sroa.66.2), !call_argsrelate !106
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1853, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> %acc_o.sroa.98.2), !call_argsrelate !106
  br label %if.end647.1

if.end647.1:                                      ; preds = %if.end560.1, %if.end501.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end501.1 ], [ %235, %if.end560.1 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end501.1 ], [ %234, %if.end560.1 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end501.1 ], [ %233, %if.end560.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end501.1 ], [ %232, %if.end560.1 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end501.1 ], [ %add611.3.1, %if.end560.1 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end501.1 ], [ %add611.2.1, %if.end560.1 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end501.1 ], [ %add611.1.1, %if.end560.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end501.1 ], [ %add611.11344, %if.end560.1 ]
  br i1 %or.cond1259.1, label %if.end793.1, label %for.cond655.preheader.1

for.cond655.preheader.1:                          ; preds = %if.end647.1
  %236 = shl nsw i32 %cond.i.i1177.7, 10
  %mul662.1 = and i32 %236, 64512
  %add665.1 = add nuw nsw i32 %add103, %mul662.1
  %237 = zext nneg i32 %add665.1 to i64
  %add.ptr670.11345 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %237
  %V_reg.sroa.0.0.copyload1819 = load <4 x half>, ptr addrspace(4) %add.ptr670.11345, align 16
  %V_reg.sroa.18.0.add.ptr670.11345.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr670.11345, i64 8
  %V_reg.sroa.18.0.copyload1826 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr670.11345.sroa_idx, align 8
  %238 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %237
  %add.ptr670.1.1 = getelementptr inbounds i8, ptr addrspace(4) %238, i64 1024
  %V_reg.sroa.26.16.copyload1847 = load <4 x half>, ptr addrspace(4) %add.ptr670.1.1, align 16
  %V_reg.sroa.42.16.add.ptr670.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %238, i64 1032
  %V_reg.sroa.42.16.copyload1854 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr670.1.1.sroa_idx, align 8
  %cmp680.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp680.1, label %for.cond682.preheader.1, label %if.end706.1

for.cond682.preheader.1:                          ; preds = %for.cond655.preheader.1
  %add689.1 = add nuw nsw i32 %mul11.7, %mul251
  %cmp692.not.11346 = icmp sgt i32 %add689.1, %1
  %fneg.1168.11347 = select i1 %cmp692.not.11346, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1518 = insertelement <4 x float> poison, float %fneg.1168.11347, i64 0
  %cmp692.not.1.1.not = icmp slt i32 %add689.1, %1
  %fneg.1168.1.1 = select i1 %cmp692.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1611 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1518, float %fneg.1168.1.1, i64 1
  %add690.2.1 = or disjoint i32 %add689.1, 2
  %cmp692.not.2.1 = icmp sgt i32 %add690.2.1, %1
  %fneg.1168.2.1 = select i1 %cmp692.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1704 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1611, float %fneg.1168.2.1, i64 2
  %add690.3.1 = or disjoint i32 %add689.1, 3
  %cmp692.not.3.1 = icmp sgt i32 %add690.3.1, %1
  %fneg.1168.3.1 = select i1 %cmp692.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1797 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1704, float %fneg.1168.3.1, i64 3
  br label %if.end706.1

if.end706.1:                                      ; preds = %for.cond655.preheader.1, %for.cond682.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1797, %for.cond682.preheader.1 ], [ zeroinitializer, %for.cond655.preheader.1 ]
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !86
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %239), !call_argsrelate !86
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %240), !call_argsrelate !86
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %241), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1520 = extractelement <4 x float> %242, i64 0
  %mul741.11351 = fmul contract float %acc_s.sroa.0.0.vec.extract1520, 0x3FB99999A0000000
  %243 = tail call contract noundef float @llvm.minnum.f32(float %mul741.11351, float 0x4024CB5EC0000000)
  %244 = tail call contract noundef float @llvm.exp.f32(float %243)
  %acc_s.sroa.0.4.vec.extract1613 = extractelement <4 x float> %242, i64 1
  %mul741.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1613, 0x3FB99999A0000000
  %245 = tail call contract noundef float @llvm.minnum.f32(float %mul741.1.1, float 0x4024CB5EC0000000)
  %246 = tail call contract noundef float @llvm.exp.f32(float %245)
  %acc_s.sroa.0.8.vec.extract1706 = extractelement <4 x float> %242, i64 2
  %mul741.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1706, 0x3FB99999A0000000
  %247 = tail call contract noundef float @llvm.minnum.f32(float %mul741.2.1, float 0x4024CB5EC0000000)
  %248 = tail call contract noundef float @llvm.exp.f32(float %247)
  %acc_s.sroa.0.12.vec.extract1799 = extractelement <4 x float> %242, i64 3
  %mul741.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1799, 0x3FB99999A0000000
  %249 = tail call contract noundef float @llvm.minnum.f32(float %mul741.3.1, float 0x4024CB5EC0000000)
  %250 = tail call contract noundef float @llvm.exp.f32(float %249)
  %add757.11352 = fadd contract float %sum_acc.sroa.0.6, %244
  %add757.1.1 = fadd contract float %sum_acc.sroa.20.6, %246
  %add757.2.1 = fadd contract float %sum_acc.sroa.38.6, %248
  %add757.3.1 = fadd contract float %sum_acc.sroa.56.6, %250
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %244)
  %252 = insertelement <4 x i16> poison, i16 %251, i64 0
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %246)
  %254 = insertelement <4 x i16> %252, i16 %253, i64 1
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %248)
  %256 = insertelement <4 x i16> %254, i16 %255, i64 2
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %250)
  %258 = insertelement <4 x i16> %256, i16 %257, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1425 = bitcast <4 x i16> %258 to <4 x half>
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1819, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !106
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1826, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o_alt.sroa.18.2), !call_argsrelate !106
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1847, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o_alt.sroa.34.2), !call_argsrelate !106
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1854, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !106
  br label %if.end793.1

if.end793.1:                                      ; preds = %if.end706.1, %if.end647.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end647.1 ], [ %262, %if.end706.1 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end647.1 ], [ %261, %if.end706.1 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end647.1 ], [ %260, %if.end706.1 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end647.1 ], [ %259, %if.end706.1 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end647.1 ], [ %add757.3.1, %if.end706.1 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end647.1 ], [ %add757.2.1, %if.end706.1 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end647.1 ], [ %add757.1.1, %if.end706.1 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end647.1 ], [ %add757.11352, %if.end706.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add805 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add805.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add805.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add805.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add805.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add805.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add805.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add805.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add805.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add805.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add805.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add805.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add805.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add805.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add805.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add805.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add819 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add819.1 = fadd contract float %add819, %sum_acc.sroa.20.7
  %add819.2 = fadd contract float %add819.1, %sum_acc.sroa.38.7
  %add819.3 = fadd contract float %add819.2, %sum_acc.sroa.56.7
  %263 = bitcast float %add819.3 to i32
  %264 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %265 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %264) #11
  %xor.i.i = xor i32 %265, 32
  %266 = and i32 %265, -64
  %and.i.i = add nsw i32 %266, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i1178 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %265
  %shl.i.i = shl i32 %cond.i.i1178, 2
  %267 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %263)
  %268 = bitcast i32 %267 to float
  %add.i = fadd contract float %add819.3, %268
  %269 = bitcast float %add.i to i32
  %270 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %271 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %270) #11
  %xor.i.i1179 = xor i32 %271, 16
  %272 = and i32 %271, -64
  %and.i.i1180 = add nsw i32 %272, 64
  %cmp.not.i.i1181 = icmp slt i32 %xor.i.i1179, %and.i.i1180
  %cond.i.i1182 = select i1 %cmp.not.i.i1181, i32 %xor.i.i1179, i32 %271
  %shl.i.i1183 = shl i32 %cond.i.i1182, 2
  %273 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1183, i32 %269)
  %274 = bitcast i32 %273 to float
  %add.i.i = fadd contract float %add.i, %274
  %cmp828 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %275 = tail call contract noundef float @llvm.mxc.rsq.f32(float %add.i.i)
  %mul834 = fmul contract float %275, %275
  %condval_4.0 = select i1 %cmp828, float %mul834, float 0.000000e+00
  %mul845 = fmul contract float %condval_4.0, %add805
  %mul845.1 = fmul contract float %condval_4.0, %add805.1
  %mul845.2 = fmul contract float %condval_4.0, %add805.2
  %mul845.3 = fmul contract float %condval_4.0, %add805.3
  %mul845.4 = fmul contract float %condval_4.0, %add805.4
  %mul845.5 = fmul contract float %condval_4.0, %add805.5
  %mul845.6 = fmul contract float %condval_4.0, %add805.6
  %mul845.7 = fmul contract float %condval_4.0, %add805.7
  %mul845.8 = fmul contract float %condval_4.0, %add805.8
  %mul845.9 = fmul contract float %condval_4.0, %add805.9
  %mul845.10 = fmul contract float %condval_4.0, %add805.10
  %mul845.11 = fmul contract float %condval_4.0, %add805.11
  %mul845.12 = fmul contract float %condval_4.0, %add805.12
  %mul845.13 = fmul contract float %condval_4.0, %add805.13
  %mul845.14 = fmul contract float %condval_4.0, %add805.14
  %mul845.15 = fmul contract float %condval_4.0, %add805.15
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845)
  %O_reg.sroa.0.0.insert.ext = zext i16 %276 to i64
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %277 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %278 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %279 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %280 to i64
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %281 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %282 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %283 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %284 to i64
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %286 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %287 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %288 to i64
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %290 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul845.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %291 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr887 = lshr i32 %18, 5
  %and890 = and i32 %18, 7
  %mul896 = and i32 %22, 4
  %xor = xor i32 %shr887, %and890
  %mul891 = shl nuw nsw i32 %xor, 3
  %add892 = add nuw nsw i32 %mul891, %mul25
  %add897 = or disjoint i32 %add892, %mul896
  %add.ptr899 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add897
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr899, align 8
  %add888.1 = add nuw nsw i32 %shr887, 2
  %xor.1 = xor i32 %add888.1, %and890
  %mul891.1 = shl nuw nsw i32 %xor.1, 3
  %add892.1 = add nuw nsw i32 %mul891.1, %mul25
  %add897.1 = or disjoint i32 %add892.1, %mul896
  %add.ptr899.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add897.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr899.1, align 8
  %add888.2 = add nuw nsw i32 %shr887, 4
  %xor.2 = xor i32 %add888.2, %and890
  %mul891.2 = shl nuw nsw i32 %xor.2, 3
  %add892.2 = add nuw nsw i32 %mul891.2, %mul25
  %add897.2 = or disjoint i32 %add892.2, %mul896
  %add.ptr899.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add897.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr899.2, align 8
  %add888.3 = add nuw nsw i32 %shr887, 6
  %xor.3 = xor i32 %add888.3, %and890
  %mul891.3 = shl nuw nsw i32 %xor.3, 3
  %add892.3 = add nuw nsw i32 %mul891.3, %mul25
  %add897.3 = or disjoint i32 %add892.3, %mul896
  %add.ptr899.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add897.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr899.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul910 = and i32 %mul107, 8128
  %xor9161164 = and i32 %mul107, 56
  %call914.masked = and i32 %18, 1016
  %mul917 = xor i32 %xor9161164, %call914.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul910
  %invariant.gep1250 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul917
  %add927 = add nuw nsw i32 %add23, %mul107
  %292 = zext nneg i32 %add927 to i64
  %add.ptr932 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %292
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr932, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1250, i64 16, i1 false), !tbaa.struct !256, !call_argsrelate !257
  %gep1251.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1250, i32 1024
  %293 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %292
  %add.ptr932.1 = getelementptr inbounds i8, ptr addrspace(1) %293, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr932.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1251.1, i64 16, i1 false), !tbaa.struct !256, !call_argsrelate !257
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare float @llvm.exp.f32(float) #6

declare i16 @llvm.convert.to.fp16.f32(float) #7

declare float @llvm.mxc.rsq.f32(float) #5

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


