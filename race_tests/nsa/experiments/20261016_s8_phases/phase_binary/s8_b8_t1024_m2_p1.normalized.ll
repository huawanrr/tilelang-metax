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
  %cond.i.i2426 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2426, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2426.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2426.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2426.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2426.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2426.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2426.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2426.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2426.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2426.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2426.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2426.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2426.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2426.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2426.7, 4
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
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp47.not = icmp sgt i32 %mul11, %1
  %or.cond2560 = or i1 %or.cond, %cmp47.not
  br i1 %or.cond2560, label %if.end, label %for.cond48.preheader

for.cond48.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2426, 10
  %mul56 = and i32 %22, 64512
  %mul61 = shl nuw nsw i32 %18, 3
  %add57 = or disjoint i32 %mul61, %mul54
  %add59 = add nuw nsw i32 %add57, %mul56
  %23 = zext nneg i32 %add59 to i64
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64, align 16
  %K_reg.sroa.6.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 8
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr64.sroa_idx, align 8
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %add.ptr64.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64.1, align 16
  %K_reg.sroa.12.16.add.ptr64.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1032
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr64.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %for.cond48.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond48.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond48.preheader ]
  %or.cond2561 = icmp ugt i32 %mul11.1, 1023
  %cmp78.not = icmp sgt i32 %mul11.1, %1
  %or.cond2562 = or i1 %or.cond2561, %cmp78.not
  br i1 %or.cond2562, label %if.end104, label %for.cond80.preheader

for.cond80.preheader:                             ; preds = %if.end
  %mul86 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2426.1, 10
  %mul88 = and i32 %25, 64512
  %mul93 = shl nuw nsw i32 %18, 3
  %add89 = or disjoint i32 %mul93, %mul86
  %add91 = add nuw nsw i32 %add89, %mul88
  %26 = zext nneg i32 %add91 to i64
  %add.ptr96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96, align 16
  %K_reg1.sroa.6.0.add.ptr96.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr96, i64 8
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr96.sroa_idx, align 8
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %add.ptr96.1 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96.1, align 16
  %K_reg1.sroa.12.16.add.ptr96.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1032
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr96.1.sroa_idx, align 8
  br label %if.end104

if.end104:                                        ; preds = %for.cond80.preheader, %if.end
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.12.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.8.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.6.0.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond80.preheader ]
  %or.cond2563 = icmp ugt i32 %mul11.2, 1023
  %cmp111.not = icmp sgt i32 %mul11.2, %1
  %or.cond2564 = or i1 %or.cond2563, %cmp111.not
  br i1 %or.cond2564, label %if.end137, label %for.cond113.preheader

for.cond113.preheader:                            ; preds = %if.end104
  %mul119 = shl nsw i32 %0, 16
  %28 = shl nsw i32 %cond.i.i2426.2, 10
  %mul121 = and i32 %28, 64512
  %mul126 = shl nuw nsw i32 %18, 3
  %add122 = or disjoint i32 %mul126, %mul119
  %add124 = add nuw nsw i32 %add122, %mul121
  %29 = zext nneg i32 %add124 to i64
  %add.ptr129 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr129, align 16
  %K_reg2.sroa.6.0.add.ptr129.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr129, i64 8
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr129.sroa_idx, align 8
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29
  %add.ptr129.1 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1024
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr129.1, align 16
  %K_reg2.sroa.12.16.add.ptr129.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr129.1.sroa_idx, align 8
  br label %if.end137

if.end137:                                        ; preds = %for.cond113.preheader, %if.end104
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.12.16.copyload, %for.cond113.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.8.16.copyload, %for.cond113.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.6.0.copyload, %for.cond113.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.0.0.copyload, %for.cond113.preheader ]
  %or.cond2565 = icmp ugt i32 %mul11.3, 1023
  %cmp144.not = icmp sgt i32 %mul11.3, %1
  %or.cond2566 = or i1 %or.cond2565, %cmp144.not
  br i1 %or.cond2566, label %if.end170, label %for.cond146.preheader

for.cond146.preheader:                            ; preds = %if.end137
  %mul152 = shl nsw i32 %0, 16
  %31 = shl nsw i32 %cond.i.i2426.3, 10
  %mul154 = and i32 %31, 64512
  %mul159 = shl nuw nsw i32 %18, 3
  %add155 = or disjoint i32 %mul159, %mul152
  %add157 = add nuw nsw i32 %add155, %mul154
  %32 = zext nneg i32 %add157 to i64
  %add.ptr162 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %32
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr162, align 16
  %K_reg3.sroa.6.0.add.ptr162.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr162, i64 8
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr162.sroa_idx, align 8
  %33 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %32
  %add.ptr162.1 = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1024
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr162.1, align 16
  %K_reg3.sroa.12.16.add.ptr162.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1032
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr162.1.sroa_idx, align 8
  br label %if.end170

if.end170:                                        ; preds = %for.cond146.preheader, %if.end137
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.12.16.copyload, %for.cond146.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.8.16.copyload, %for.cond146.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.6.0.copyload, %for.cond146.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.0.0.copyload, %for.cond146.preheader ]
  %or.cond2567 = icmp ult i32 %mul11, 1024
  br i1 %or.cond2567, label %land.lhs.true174, label %if.end276

land.lhs.true174:                                 ; preds = %if.end170
  br i1 %cmp47.not, label %if.end276, label %if.then177

if.then177:                                       ; preds = %land.lhs.true174
  %add179 = or disjoint i32 %mul11, 15
  %cmp180 = icmp ult i32 %1, %add179
  br i1 %cmp180, label %for.cond182.preheader, label %if.end206

for.cond182.preheader:                            ; preds = %if.then177
  %34 = lshr i32 %18, 2
  %mul189 = and i32 %34, 252
  %add190 = add nuw nsw i32 %mul11, %mul189
  %cmp193.not = icmp sgt i32 %add190, %1
  %fneg. = select i1 %cmp193.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3140 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp193.not.1.not = icmp slt i32 %add190, %1
  %fneg..1 = select i1 %cmp193.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3233 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3140, float %fneg..1, i64 1
  %add191.2 = or disjoint i32 %add190, 2
  %cmp193.not.2 = icmp sgt i32 %add191.2, %1
  %fneg..2 = select i1 %cmp193.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3326 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3233, float %fneg..2, i64 2
  %add191.3 = or disjoint i32 %add190, 3
  %cmp193.not.3 = icmp sgt i32 %add191.3, %1
  %fneg..3 = select i1 %cmp193.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3419 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3326, float %fneg..3, i64 3
  br label %if.end206

if.end206:                                        ; preds = %if.then177, %for.cond182.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3419, %for.cond182.preheader ], [ zeroinitializer, %if.then177 ]
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !87
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %35), !call_argsrelate !87
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %36), !call_argsrelate !87
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %37), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0
  %mul242 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul242, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1
  %mul242.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul242.1, float 0x4024CB5EC0000000)
  %42 = tail call contract noundef float @llvm.exp.f32(float %41)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2
  %mul242.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul242.2, float 0x4024CB5EC0000000)
  %44 = tail call contract noundef float @llvm.exp.f32(float %43)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3
  %mul242.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul242.3, float 0x4024CB5EC0000000)
  %46 = tail call contract noundef float @llvm.exp.f32(float %45)
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %40)
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %42)
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %44)
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %46)
  br label %if.end276

if.end276:                                        ; preds = %if.end206, %land.lhs.true174, %if.end170
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %46, %if.end206 ], [ 0.000000e+00, %if.end170 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %44, %if.end206 ], [ 0.000000e+00, %if.end170 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %42, %if.end206 ], [ 0.000000e+00, %if.end170 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %40, %if.end206 ], [ 0.000000e+00, %if.end170 ]
  %phase_weights.sroa.8.0 = phi i16 [ undef, %land.lhs.true174 ], [ %50, %if.end206 ], [ undef, %if.end170 ]
  %phase_weights.sroa.6.0 = phi i16 [ undef, %land.lhs.true174 ], [ %49, %if.end206 ], [ undef, %if.end170 ]
  %phase_weights.sroa.4.0 = phi i16 [ undef, %land.lhs.true174 ], [ %48, %if.end206 ], [ undef, %if.end170 ]
  %phase_weights.sroa.0.0 = phi i16 [ undef, %land.lhs.true174 ], [ %47, %if.end206 ], [ undef, %if.end170 ]
  %or.cond2568 = icmp ult i32 %mul11.1, 1024
  br i1 %or.cond2568, label %land.lhs.true280, label %if.end382

land.lhs.true280:                                 ; preds = %if.end276
  br i1 %cmp78.not, label %if.end382, label %if.then283

if.then283:                                       ; preds = %land.lhs.true280
  %add285 = or disjoint i32 %mul11.1, 15
  %cmp286 = icmp ult i32 %1, %add285
  br i1 %cmp286, label %for.cond288.preheader, label %if.end312

for.cond288.preheader:                            ; preds = %if.then283
  %51 = lshr i32 %18, 2
  %mul294 = and i32 %51, 252
  %add295 = add nuw nsw i32 %mul11.1, %mul294
  %cmp298.not = icmp sgt i32 %add295, %1
  %fneg.2411 = select i1 %cmp298.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3149 = insertelement <4 x float> poison, float %fneg.2411, i64 0
  %cmp298.not.1.not = icmp slt i32 %add295, %1
  %fneg.2411.1 = select i1 %cmp298.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3242 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3149, float %fneg.2411.1, i64 1
  %add296.2 = or disjoint i32 %add295, 2
  %cmp298.not.2 = icmp sgt i32 %add296.2, %1
  %fneg.2411.2 = select i1 %cmp298.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3335 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3242, float %fneg.2411.2, i64 2
  %add296.3 = or disjoint i32 %add295, 3
  %cmp298.not.3 = icmp sgt i32 %add296.3, %1
  %fneg.2411.3 = select i1 %cmp298.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3428 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3335, float %fneg.2411.3, i64 3
  br label %if.end312

if.end312:                                        ; preds = %if.then283, %for.cond288.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3428, %for.cond288.preheader ], [ zeroinitializer, %if.then283 ]
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !87
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %52), !call_argsrelate !87
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %53), !call_argsrelate !87
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %54), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3151 = extractelement <4 x float> %55, i64 0
  %mul347 = fmul contract float %acc_s.sroa.0.0.vec.extract3151, 0x3FB99999A0000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul347, float 0x4024CB5EC0000000)
  %57 = tail call contract noundef float @llvm.exp.f32(float %56)
  %acc_s.sroa.0.4.vec.extract3244 = extractelement <4 x float> %55, i64 1
  %mul347.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3244, 0x3FB99999A0000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul347.1, float 0x4024CB5EC0000000)
  %59 = tail call contract noundef float @llvm.exp.f32(float %58)
  %acc_s.sroa.0.8.vec.extract3337 = extractelement <4 x float> %55, i64 2
  %mul347.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3337, 0x3FB99999A0000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul347.2, float 0x4024CB5EC0000000)
  %61 = tail call contract noundef float @llvm.exp.f32(float %60)
  %acc_s.sroa.0.12.vec.extract3430 = extractelement <4 x float> %55, i64 3
  %mul347.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3430, 0x3FB99999A0000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul347.3, float 0x4024CB5EC0000000)
  %63 = tail call contract noundef float @llvm.exp.f32(float %62)
  %add363 = fadd contract float %sum_acc.sroa.0.0, %57
  %add363.1 = fadd contract float %sum_acc.sroa.20.0, %59
  %add363.2 = fadd contract float %sum_acc.sroa.38.0, %61
  %add363.3 = fadd contract float %sum_acc.sroa.56.0, %63
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57)
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %59)
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %61)
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %63)
  br label %if.end382

if.end382:                                        ; preds = %if.end312, %land.lhs.true280, %if.end276
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true280 ], [ %add363.3, %if.end312 ], [ %sum_acc.sroa.56.0, %if.end276 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true280 ], [ %add363.2, %if.end312 ], [ %sum_acc.sroa.38.0, %if.end276 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true280 ], [ %add363.1, %if.end312 ], [ %sum_acc.sroa.20.0, %if.end276 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true280 ], [ %add363, %if.end312 ], [ %sum_acc.sroa.0.0, %if.end276 ]
  %phase_weights.sroa.16.0 = phi i16 [ undef, %land.lhs.true280 ], [ %67, %if.end312 ], [ undef, %if.end276 ]
  %phase_weights.sroa.14.0 = phi i16 [ undef, %land.lhs.true280 ], [ %66, %if.end312 ], [ undef, %if.end276 ]
  %phase_weights.sroa.12.0 = phi i16 [ undef, %land.lhs.true280 ], [ %65, %if.end312 ], [ undef, %if.end276 ]
  %phase_weights.sroa.10.0 = phi i16 [ undef, %land.lhs.true280 ], [ %64, %if.end312 ], [ undef, %if.end276 ]
  %or.cond2569 = icmp ult i32 %mul11.2, 1024
  br i1 %or.cond2569, label %land.lhs.true386, label %if.end488

land.lhs.true386:                                 ; preds = %if.end382
  br i1 %cmp111.not, label %if.end488, label %if.then389

if.then389:                                       ; preds = %land.lhs.true386
  %add391 = or disjoint i32 %mul11.2, 15
  %cmp392 = icmp ult i32 %1, %add391
  br i1 %cmp392, label %for.cond394.preheader, label %if.end418

for.cond394.preheader:                            ; preds = %if.then389
  %68 = lshr i32 %18, 2
  %mul400 = and i32 %68, 252
  %add401 = add nuw nsw i32 %mul11.2, %mul400
  %cmp404.not = icmp sgt i32 %add401, %1
  %fneg.2412 = select i1 %cmp404.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3159 = insertelement <4 x float> poison, float %fneg.2412, i64 0
  %cmp404.not.1.not = icmp slt i32 %add401, %1
  %fneg.2412.1 = select i1 %cmp404.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3252 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3159, float %fneg.2412.1, i64 1
  %add402.2 = or disjoint i32 %add401, 2
  %cmp404.not.2 = icmp sgt i32 %add402.2, %1
  %fneg.2412.2 = select i1 %cmp404.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3345 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3252, float %fneg.2412.2, i64 2
  %add402.3 = or disjoint i32 %add401, 3
  %cmp404.not.3 = icmp sgt i32 %add402.3, %1
  %fneg.2412.3 = select i1 %cmp404.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3438 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3345, float %fneg.2412.3, i64 3
  br label %if.end418

if.end418:                                        ; preds = %if.then389, %for.cond394.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3438, %for.cond394.preheader ], [ zeroinitializer, %if.then389 ]
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !87
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !call_argsrelate !87
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !call_argsrelate !87
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3161 = extractelement <4 x float> %72, i64 0
  %mul453 = fmul contract float %acc_s.sroa.0.0.vec.extract3161, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul453, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %acc_s.sroa.0.4.vec.extract3254 = extractelement <4 x float> %72, i64 1
  %mul453.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3254, 0x3FB99999A0000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul453.1, float 0x4024CB5EC0000000)
  %76 = tail call contract noundef float @llvm.exp.f32(float %75)
  %acc_s.sroa.0.8.vec.extract3347 = extractelement <4 x float> %72, i64 2
  %mul453.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3347, 0x3FB99999A0000000
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul453.2, float 0x4024CB5EC0000000)
  %78 = tail call contract noundef float @llvm.exp.f32(float %77)
  %acc_s.sroa.0.12.vec.extract3440 = extractelement <4 x float> %72, i64 3
  %mul453.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3440, 0x3FB99999A0000000
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul453.3, float 0x4024CB5EC0000000)
  %80 = tail call contract noundef float @llvm.exp.f32(float %79)
  %add469 = fadd contract float %sum_acc.sroa.0.1, %74
  %add469.1 = fadd contract float %sum_acc.sroa.20.1, %76
  %add469.2 = fadd contract float %sum_acc.sroa.38.1, %78
  %add469.3 = fadd contract float %sum_acc.sroa.56.1, %80
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76)
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78)
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80)
  br label %if.end488

if.end488:                                        ; preds = %if.end418, %land.lhs.true386, %if.end382
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true386 ], [ %add469.3, %if.end418 ], [ %sum_acc.sroa.56.1, %if.end382 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true386 ], [ %add469.2, %if.end418 ], [ %sum_acc.sroa.38.1, %if.end382 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true386 ], [ %add469.1, %if.end418 ], [ %sum_acc.sroa.20.1, %if.end382 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true386 ], [ %add469, %if.end418 ], [ %sum_acc.sroa.0.1, %if.end382 ]
  %phase_weights.sroa.24.0 = phi i16 [ undef, %land.lhs.true386 ], [ %84, %if.end418 ], [ undef, %if.end382 ]
  %phase_weights.sroa.22.0 = phi i16 [ undef, %land.lhs.true386 ], [ %83, %if.end418 ], [ undef, %if.end382 ]
  %phase_weights.sroa.20.0 = phi i16 [ undef, %land.lhs.true386 ], [ %82, %if.end418 ], [ undef, %if.end382 ]
  %phase_weights.sroa.18.0 = phi i16 [ undef, %land.lhs.true386 ], [ %81, %if.end418 ], [ undef, %if.end382 ]
  %or.cond2570 = icmp ult i32 %mul11.3, 1024
  br i1 %or.cond2570, label %land.lhs.true492, label %if.end594

land.lhs.true492:                                 ; preds = %if.end488
  br i1 %cmp144.not, label %if.end594, label %if.then495

if.then495:                                       ; preds = %land.lhs.true492
  %add497 = or disjoint i32 %mul11.3, 15
  %cmp498 = icmp ult i32 %1, %add497
  br i1 %cmp498, label %for.cond500.preheader, label %if.end524

for.cond500.preheader:                            ; preds = %if.then495
  %85 = lshr i32 %18, 2
  %mul506 = and i32 %85, 252
  %add507 = add nuw nsw i32 %mul11.3, %mul506
  %cmp510.not = icmp sgt i32 %add507, %1
  %fneg.2413 = select i1 %cmp510.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3169 = insertelement <4 x float> poison, float %fneg.2413, i64 0
  %cmp510.not.1.not = icmp slt i32 %add507, %1
  %fneg.2413.1 = select i1 %cmp510.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3262 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3169, float %fneg.2413.1, i64 1
  %add508.2 = or disjoint i32 %add507, 2
  %cmp510.not.2 = icmp sgt i32 %add508.2, %1
  %fneg.2413.2 = select i1 %cmp510.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3355 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3262, float %fneg.2413.2, i64 2
  %add508.3 = or disjoint i32 %add507, 3
  %cmp510.not.3 = icmp sgt i32 %add508.3, %1
  %fneg.2413.3 = select i1 %cmp510.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3448 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3355, float %fneg.2413.3, i64 3
  br label %if.end524

if.end524:                                        ; preds = %if.then495, %for.cond500.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3448, %for.cond500.preheader ], [ zeroinitializer, %if.then495 ]
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !87
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %86), !call_argsrelate !87
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %87), !call_argsrelate !87
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %88), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3171 = extractelement <4 x float> %89, i64 0
  %mul559 = fmul contract float %acc_s.sroa.0.0.vec.extract3171, 0x3FB99999A0000000
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul559, float 0x4024CB5EC0000000)
  %91 = tail call contract noundef float @llvm.exp.f32(float %90)
  %acc_s.sroa.0.4.vec.extract3264 = extractelement <4 x float> %89, i64 1
  %mul559.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3264, 0x3FB99999A0000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul559.1, float 0x4024CB5EC0000000)
  %93 = tail call contract noundef float @llvm.exp.f32(float %92)
  %acc_s.sroa.0.8.vec.extract3357 = extractelement <4 x float> %89, i64 2
  %mul559.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3357, 0x3FB99999A0000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul559.2, float 0x4024CB5EC0000000)
  %95 = tail call contract noundef float @llvm.exp.f32(float %94)
  %acc_s.sroa.0.12.vec.extract3450 = extractelement <4 x float> %89, i64 3
  %mul559.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3450, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul559.3, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %add575 = fadd contract float %sum_acc.sroa.0.2, %91
  %add575.1 = fadd contract float %sum_acc.sroa.20.2, %93
  %add575.2 = fadd contract float %sum_acc.sroa.38.2, %95
  %add575.3 = fadd contract float %sum_acc.sroa.56.2, %97
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91)
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93)
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95)
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  br label %if.end594

if.end594:                                        ; preds = %if.end524, %land.lhs.true492, %if.end488
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true492 ], [ %add575.3, %if.end524 ], [ %sum_acc.sroa.56.2, %if.end488 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true492 ], [ %add575.2, %if.end524 ], [ %sum_acc.sroa.38.2, %if.end488 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true492 ], [ %add575.1, %if.end524 ], [ %sum_acc.sroa.20.2, %if.end488 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true492 ], [ %add575, %if.end524 ], [ %sum_acc.sroa.0.2, %if.end488 ]
  %phase_weights.sroa.32.0 = phi i16 [ undef, %land.lhs.true492 ], [ %101, %if.end524 ], [ undef, %if.end488 ]
  %phase_weights.sroa.30.0 = phi i16 [ undef, %land.lhs.true492 ], [ %100, %if.end524 ], [ undef, %if.end488 ]
  %phase_weights.sroa.28.0 = phi i16 [ undef, %land.lhs.true492 ], [ %99, %if.end524 ], [ undef, %if.end488 ]
  %phase_weights.sroa.26.0 = phi i16 [ undef, %land.lhs.true492 ], [ %98, %if.end524 ], [ undef, %if.end488 ]
  %or.cond2571 = icmp ugt i32 %mul11.4, 1023
  %cmp601.not = icmp sgt i32 %mul11.4, %1
  %or.cond2572 = or i1 %or.cond2571, %cmp601.not
  br i1 %or.cond2572, label %if.end626, label %for.cond603.preheader

for.cond603.preheader:                            ; preds = %if.end594
  %mul608 = shl nsw i32 %0, 16
  %102 = shl nsw i32 %cond.i.i2426.4, 10
  %mul610 = and i32 %102, 64512
  %mul615 = shl nuw nsw i32 %18, 3
  %add611 = or disjoint i32 %mul615, %mul608
  %add613 = add nuw nsw i32 %add611, %mul610
  %103 = zext nneg i32 %add613 to i64
  %add.ptr618 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103
  %K_reg.sroa.0.0.copyload3522 = load <4 x half>, ptr addrspace(4) %add.ptr618, align 16
  %K_reg.sroa.6.0.add.ptr618.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr618, i64 8
  %K_reg.sroa.6.0.copyload3523 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr618.sroa_idx, align 8
  %104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103
  %add.ptr618.1 = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1024
  %K_reg.sroa.8.16.copyload3526 = load <4 x half>, ptr addrspace(4) %add.ptr618.1, align 16
  %K_reg.sroa.12.16.add.ptr618.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1032
  %K_reg.sroa.12.16.copyload3527 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr618.1.sroa_idx, align 8
  br label %if.end626

if.end626:                                        ; preds = %for.cond603.preheader, %if.end594
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end594 ], [ %K_reg.sroa.12.16.copyload3527, %for.cond603.preheader ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end594 ], [ %K_reg.sroa.8.16.copyload3526, %for.cond603.preheader ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end594 ], [ %K_reg.sroa.6.0.copyload3523, %for.cond603.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end594 ], [ %K_reg.sroa.0.0.copyload3522, %for.cond603.preheader ]
  %or.cond2573 = icmp ugt i32 %mul11.5, 1023
  %cmp633.not = icmp sgt i32 %mul11.5, %1
  %or.cond2574 = or i1 %or.cond2573, %cmp633.not
  br i1 %or.cond2574, label %if.end658, label %for.cond635.preheader

for.cond635.preheader:                            ; preds = %if.end626
  %mul640 = shl nsw i32 %0, 16
  %105 = shl nsw i32 %cond.i.i2426.5, 10
  %mul642 = and i32 %105, 64512
  %mul647 = shl nuw nsw i32 %18, 3
  %add643 = or disjoint i32 %mul647, %mul640
  %add645 = add nuw nsw i32 %add643, %mul642
  %106 = zext nneg i32 %add645 to i64
  %add.ptr650 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106
  %K_reg1.sroa.0.0.copyload3514 = load <4 x half>, ptr addrspace(4) %add.ptr650, align 16
  %K_reg1.sroa.6.0.add.ptr650.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr650, i64 8
  %K_reg1.sroa.6.0.copyload3515 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr650.sroa_idx, align 8
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106
  %add.ptr650.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024
  %K_reg1.sroa.8.16.copyload3518 = load <4 x half>, ptr addrspace(4) %add.ptr650.1, align 16
  %K_reg1.sroa.12.16.add.ptr650.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032
  %K_reg1.sroa.12.16.copyload3519 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr650.1.sroa_idx, align 8
  br label %if.end658

if.end658:                                        ; preds = %for.cond635.preheader, %if.end626
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end626 ], [ %K_reg1.sroa.12.16.copyload3519, %for.cond635.preheader ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end626 ], [ %K_reg1.sroa.8.16.copyload3518, %for.cond635.preheader ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end626 ], [ %K_reg1.sroa.6.0.copyload3515, %for.cond635.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end626 ], [ %K_reg1.sroa.0.0.copyload3514, %for.cond635.preheader ]
  %or.cond2575 = icmp ugt i32 %mul11.6, 1023
  %cmp665.not = icmp sgt i32 %mul11.6, %1
  %or.cond2576 = or i1 %or.cond2575, %cmp665.not
  br i1 %or.cond2576, label %if.end690, label %for.cond667.preheader

for.cond667.preheader:                            ; preds = %if.end658
  %mul672 = shl nsw i32 %0, 16
  %108 = shl nsw i32 %cond.i.i2426.6, 10
  %mul674 = and i32 %108, 64512
  %mul679 = shl nuw nsw i32 %18, 3
  %add675 = or disjoint i32 %mul679, %mul672
  %add677 = add nuw nsw i32 %add675, %mul674
  %109 = zext nneg i32 %add677 to i64
  %add.ptr682 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %109
  %K_reg2.sroa.0.0.copyload3506 = load <4 x half>, ptr addrspace(4) %add.ptr682, align 16
  %K_reg2.sroa.6.0.add.ptr682.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr682, i64 8
  %K_reg2.sroa.6.0.copyload3507 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr682.sroa_idx, align 8
  %110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %109
  %add.ptr682.1 = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1024
  %K_reg2.sroa.8.16.copyload3510 = load <4 x half>, ptr addrspace(4) %add.ptr682.1, align 16
  %K_reg2.sroa.12.16.add.ptr682.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1032
  %K_reg2.sroa.12.16.copyload3511 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr682.1.sroa_idx, align 8
  br label %if.end690

if.end690:                                        ; preds = %for.cond667.preheader, %if.end658
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end658 ], [ %K_reg2.sroa.12.16.copyload3511, %for.cond667.preheader ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end658 ], [ %K_reg2.sroa.8.16.copyload3510, %for.cond667.preheader ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end658 ], [ %K_reg2.sroa.6.0.copyload3507, %for.cond667.preheader ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end658 ], [ %K_reg2.sroa.0.0.copyload3506, %for.cond667.preheader ]
  %or.cond2577 = icmp ugt i32 %mul11.7, 1023
  %cmp697.not = icmp sgt i32 %mul11.7, %1
  %or.cond2578 = or i1 %or.cond2577, %cmp697.not
  br i1 %or.cond2578, label %if.end722, label %for.cond699.preheader

for.cond699.preheader:                            ; preds = %if.end690
  %mul704 = shl nsw i32 %0, 16
  %111 = shl nsw i32 %cond.i.i2426.7, 10
  %mul706 = and i32 %111, 64512
  %mul711 = shl nuw nsw i32 %18, 3
  %add707 = or disjoint i32 %mul711, %mul704
  %add709 = add nuw nsw i32 %add707, %mul706
  %112 = zext nneg i32 %add709 to i64
  %add.ptr714 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %112
  %K_reg3.sroa.0.0.copyload3498 = load <4 x half>, ptr addrspace(4) %add.ptr714, align 16
  %K_reg3.sroa.6.0.add.ptr714.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr714, i64 8
  %K_reg3.sroa.6.0.copyload3499 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr714.sroa_idx, align 8
  %113 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %112
  %add.ptr714.1 = getelementptr inbounds i8, ptr addrspace(4) %113, i64 1024
  %K_reg3.sroa.8.16.copyload3502 = load <4 x half>, ptr addrspace(4) %add.ptr714.1, align 16
  %K_reg3.sroa.12.16.add.ptr714.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %113, i64 1032
  %K_reg3.sroa.12.16.copyload3503 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr714.1.sroa_idx, align 8
  br label %if.end722

if.end722:                                        ; preds = %for.cond699.preheader, %if.end690
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end690 ], [ %K_reg3.sroa.12.16.copyload3503, %for.cond699.preheader ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end690 ], [ %K_reg3.sroa.8.16.copyload3502, %for.cond699.preheader ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end690 ], [ %K_reg3.sroa.6.0.copyload3499, %for.cond699.preheader ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end690 ], [ %K_reg3.sroa.0.0.copyload3498, %for.cond699.preheader ]
  %or.cond2579 = icmp ult i32 %mul11.4, 1024
  br i1 %or.cond2579, label %land.lhs.true726, label %if.end828

land.lhs.true726:                                 ; preds = %if.end722
  br i1 %cmp601.not, label %if.end828, label %if.then729

if.then729:                                       ; preds = %land.lhs.true726
  %add731 = or disjoint i32 %mul11.4, 15
  %cmp732 = icmp ult i32 %1, %add731
  br i1 %cmp732, label %for.cond734.preheader, label %if.end758

for.cond734.preheader:                            ; preds = %if.then729
  %114 = lshr i32 %18, 2
  %mul740 = and i32 %114, 252
  %add741 = add nuw nsw i32 %mul11.4, %mul740
  %cmp744.not = icmp sgt i32 %add741, %1
  %fneg.2414 = select i1 %cmp744.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3179 = insertelement <4 x float> poison, float %fneg.2414, i64 0
  %cmp744.not.1.not = icmp slt i32 %add741, %1
  %fneg.2414.1 = select i1 %cmp744.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3272 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3179, float %fneg.2414.1, i64 1
  %add742.2 = or disjoint i32 %add741, 2
  %cmp744.not.2 = icmp sgt i32 %add742.2, %1
  %fneg.2414.2 = select i1 %cmp744.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3365 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3272, float %fneg.2414.2, i64 2
  %add742.3 = or disjoint i32 %add741, 3
  %cmp744.not.3 = icmp sgt i32 %add742.3, %1
  %fneg.2414.3 = select i1 %cmp744.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3458 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3365, float %fneg.2414.3, i64 3
  br label %if.end758

if.end758:                                        ; preds = %if.then729, %for.cond734.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3458, %for.cond734.preheader ], [ zeroinitializer, %if.then729 ]
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !87
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %115), !call_argsrelate !87
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %116), !call_argsrelate !87
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %117), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3181 = extractelement <4 x float> %118, i64 0
  %mul793 = fmul contract float %acc_s.sroa.0.0.vec.extract3181, 0x3FB99999A0000000
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul793, float 0x4024CB5EC0000000)
  %120 = tail call contract noundef float @llvm.exp.f32(float %119)
  %acc_s.sroa.0.4.vec.extract3274 = extractelement <4 x float> %118, i64 1
  %mul793.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3274, 0x3FB99999A0000000
  %121 = tail call contract noundef float @llvm.minnum.f32(float %mul793.1, float 0x4024CB5EC0000000)
  %122 = tail call contract noundef float @llvm.exp.f32(float %121)
  %acc_s.sroa.0.8.vec.extract3367 = extractelement <4 x float> %118, i64 2
  %mul793.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3367, 0x3FB99999A0000000
  %123 = tail call contract noundef float @llvm.minnum.f32(float %mul793.2, float 0x4024CB5EC0000000)
  %124 = tail call contract noundef float @llvm.exp.f32(float %123)
  %acc_s.sroa.0.12.vec.extract3460 = extractelement <4 x float> %118, i64 3
  %mul793.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3460, 0x3FB99999A0000000
  %125 = tail call contract noundef float @llvm.minnum.f32(float %mul793.3, float 0x4024CB5EC0000000)
  %126 = tail call contract noundef float @llvm.exp.f32(float %125)
  %add809 = fadd contract float %sum_acc.sroa.0.3, %120
  %add809.1 = fadd contract float %sum_acc.sroa.20.3, %122
  %add809.2 = fadd contract float %sum_acc.sroa.38.3, %124
  %add809.3 = fadd contract float %sum_acc.sroa.56.3, %126
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120)
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %122)
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %124)
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %126)
  br label %if.end828

if.end828:                                        ; preds = %if.end758, %land.lhs.true726, %if.end722
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true726 ], [ %add809.3, %if.end758 ], [ %sum_acc.sroa.56.3, %if.end722 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true726 ], [ %add809.2, %if.end758 ], [ %sum_acc.sroa.38.3, %if.end722 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true726 ], [ %add809.1, %if.end758 ], [ %sum_acc.sroa.20.3, %if.end722 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true726 ], [ %add809, %if.end758 ], [ %sum_acc.sroa.0.3, %if.end722 ]
  %phase_weights.sroa.40.0 = phi i16 [ undef, %land.lhs.true726 ], [ %130, %if.end758 ], [ undef, %if.end722 ]
  %phase_weights.sroa.38.0 = phi i16 [ undef, %land.lhs.true726 ], [ %129, %if.end758 ], [ undef, %if.end722 ]
  %phase_weights.sroa.36.0 = phi i16 [ undef, %land.lhs.true726 ], [ %128, %if.end758 ], [ undef, %if.end722 ]
  %phase_weights.sroa.34.0 = phi i16 [ undef, %land.lhs.true726 ], [ %127, %if.end758 ], [ undef, %if.end722 ]
  %or.cond2580 = icmp ult i32 %mul11.5, 1024
  br i1 %or.cond2580, label %land.lhs.true832, label %if.end934

land.lhs.true832:                                 ; preds = %if.end828
  br i1 %cmp633.not, label %if.end934, label %if.then835

if.then835:                                       ; preds = %land.lhs.true832
  %add837 = or disjoint i32 %mul11.5, 15
  %cmp838 = icmp ult i32 %1, %add837
  br i1 %cmp838, label %for.cond840.preheader, label %if.end864

for.cond840.preheader:                            ; preds = %if.then835
  %131 = lshr i32 %18, 2
  %mul846 = and i32 %131, 252
  %add847 = add nuw nsw i32 %mul11.5, %mul846
  %cmp850.not = icmp sgt i32 %add847, %1
  %fneg.2415 = select i1 %cmp850.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3189 = insertelement <4 x float> poison, float %fneg.2415, i64 0
  %cmp850.not.1.not = icmp slt i32 %add847, %1
  %fneg.2415.1 = select i1 %cmp850.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3282 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3189, float %fneg.2415.1, i64 1
  %add848.2 = or disjoint i32 %add847, 2
  %cmp850.not.2 = icmp sgt i32 %add848.2, %1
  %fneg.2415.2 = select i1 %cmp850.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3375 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3282, float %fneg.2415.2, i64 2
  %add848.3 = or disjoint i32 %add847, 3
  %cmp850.not.3 = icmp sgt i32 %add848.3, %1
  %fneg.2415.3 = select i1 %cmp850.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3468 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3375, float %fneg.2415.3, i64 3
  br label %if.end864

if.end864:                                        ; preds = %if.then835, %for.cond840.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3468, %for.cond840.preheader ], [ zeroinitializer, %if.then835 ]
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !87
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %132), !call_argsrelate !87
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %133), !call_argsrelate !87
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %134), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3191 = extractelement <4 x float> %135, i64 0
  %mul899 = fmul contract float %acc_s.sroa.0.0.vec.extract3191, 0x3FB99999A0000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul899, float 0x4024CB5EC0000000)
  %137 = tail call contract noundef float @llvm.exp.f32(float %136)
  %acc_s.sroa.0.4.vec.extract3284 = extractelement <4 x float> %135, i64 1
  %mul899.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3284, 0x3FB99999A0000000
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul899.1, float 0x4024CB5EC0000000)
  %139 = tail call contract noundef float @llvm.exp.f32(float %138)
  %acc_s.sroa.0.8.vec.extract3377 = extractelement <4 x float> %135, i64 2
  %mul899.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3377, 0x3FB99999A0000000
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul899.2, float 0x4024CB5EC0000000)
  %141 = tail call contract noundef float @llvm.exp.f32(float %140)
  %acc_s.sroa.0.12.vec.extract3470 = extractelement <4 x float> %135, i64 3
  %mul899.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3470, 0x3FB99999A0000000
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul899.3, float 0x4024CB5EC0000000)
  %143 = tail call contract noundef float @llvm.exp.f32(float %142)
  %add915 = fadd contract float %sum_acc.sroa.0.4, %137
  %add915.1 = fadd contract float %sum_acc.sroa.20.4, %139
  %add915.2 = fadd contract float %sum_acc.sroa.38.4, %141
  %add915.3 = fadd contract float %sum_acc.sroa.56.4, %143
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137)
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139)
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141)
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143)
  br label %if.end934

if.end934:                                        ; preds = %if.end864, %land.lhs.true832, %if.end828
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true832 ], [ %add915.3, %if.end864 ], [ %sum_acc.sroa.56.4, %if.end828 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true832 ], [ %add915.2, %if.end864 ], [ %sum_acc.sroa.38.4, %if.end828 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true832 ], [ %add915.1, %if.end864 ], [ %sum_acc.sroa.20.4, %if.end828 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true832 ], [ %add915, %if.end864 ], [ %sum_acc.sroa.0.4, %if.end828 ]
  %phase_weights.sroa.48.0 = phi i16 [ undef, %land.lhs.true832 ], [ %147, %if.end864 ], [ undef, %if.end828 ]
  %phase_weights.sroa.46.0 = phi i16 [ undef, %land.lhs.true832 ], [ %146, %if.end864 ], [ undef, %if.end828 ]
  %phase_weights.sroa.44.0 = phi i16 [ undef, %land.lhs.true832 ], [ %145, %if.end864 ], [ undef, %if.end828 ]
  %phase_weights.sroa.42.0 = phi i16 [ undef, %land.lhs.true832 ], [ %144, %if.end864 ], [ undef, %if.end828 ]
  %or.cond2581 = icmp ult i32 %mul11.6, 1024
  br i1 %or.cond2581, label %land.lhs.true938, label %if.end1040

land.lhs.true938:                                 ; preds = %if.end934
  br i1 %cmp665.not, label %if.end1040, label %if.then941

if.then941:                                       ; preds = %land.lhs.true938
  %add943 = or disjoint i32 %mul11.6, 15
  %cmp944 = icmp ult i32 %1, %add943
  br i1 %cmp944, label %for.cond946.preheader, label %if.end970

for.cond946.preheader:                            ; preds = %if.then941
  %148 = lshr i32 %18, 2
  %mul952 = and i32 %148, 252
  %add953 = add nuw nsw i32 %mul11.6, %mul952
  %cmp956.not = icmp sgt i32 %add953, %1
  %fneg.2416 = select i1 %cmp956.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3199 = insertelement <4 x float> poison, float %fneg.2416, i64 0
  %cmp956.not.1.not = icmp slt i32 %add953, %1
  %fneg.2416.1 = select i1 %cmp956.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3292 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3199, float %fneg.2416.1, i64 1
  %add954.2 = or disjoint i32 %add953, 2
  %cmp956.not.2 = icmp sgt i32 %add954.2, %1
  %fneg.2416.2 = select i1 %cmp956.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3385 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3292, float %fneg.2416.2, i64 2
  %add954.3 = or disjoint i32 %add953, 3
  %cmp956.not.3 = icmp sgt i32 %add954.3, %1
  %fneg.2416.3 = select i1 %cmp956.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3478 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3385, float %fneg.2416.3, i64 3
  br label %if.end970

if.end970:                                        ; preds = %if.then941, %for.cond946.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3478, %for.cond946.preheader ], [ zeroinitializer, %if.then941 ]
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !87
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %149), !call_argsrelate !87
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %150), !call_argsrelate !87
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %151), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3201 = extractelement <4 x float> %152, i64 0
  %mul1005 = fmul contract float %acc_s.sroa.0.0.vec.extract3201, 0x3FB99999A0000000
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul1005, float 0x4024CB5EC0000000)
  %154 = tail call contract noundef float @llvm.exp.f32(float %153)
  %acc_s.sroa.0.4.vec.extract3294 = extractelement <4 x float> %152, i64 1
  %mul1005.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3294, 0x3FB99999A0000000
  %155 = tail call contract noundef float @llvm.minnum.f32(float %mul1005.1, float 0x4024CB5EC0000000)
  %156 = tail call contract noundef float @llvm.exp.f32(float %155)
  %acc_s.sroa.0.8.vec.extract3387 = extractelement <4 x float> %152, i64 2
  %mul1005.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3387, 0x3FB99999A0000000
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul1005.2, float 0x4024CB5EC0000000)
  %158 = tail call contract noundef float @llvm.exp.f32(float %157)
  %acc_s.sroa.0.12.vec.extract3480 = extractelement <4 x float> %152, i64 3
  %mul1005.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3480, 0x3FB99999A0000000
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul1005.3, float 0x4024CB5EC0000000)
  %160 = tail call contract noundef float @llvm.exp.f32(float %159)
  %add1021 = fadd contract float %sum_acc.sroa.0.5, %154
  %add1021.1 = fadd contract float %sum_acc.sroa.20.5, %156
  %add1021.2 = fadd contract float %sum_acc.sroa.38.5, %158
  %add1021.3 = fadd contract float %sum_acc.sroa.56.5, %160
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154)
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %156)
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158)
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160)
  br label %if.end1040

if.end1040:                                       ; preds = %if.end970, %land.lhs.true938, %if.end934
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true938 ], [ %add1021.3, %if.end970 ], [ %sum_acc.sroa.56.5, %if.end934 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true938 ], [ %add1021.2, %if.end970 ], [ %sum_acc.sroa.38.5, %if.end934 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true938 ], [ %add1021.1, %if.end970 ], [ %sum_acc.sroa.20.5, %if.end934 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true938 ], [ %add1021, %if.end970 ], [ %sum_acc.sroa.0.5, %if.end934 ]
  %phase_weights.sroa.56.0 = phi i16 [ undef, %land.lhs.true938 ], [ %164, %if.end970 ], [ undef, %if.end934 ]
  %phase_weights.sroa.54.0 = phi i16 [ undef, %land.lhs.true938 ], [ %163, %if.end970 ], [ undef, %if.end934 ]
  %phase_weights.sroa.52.0 = phi i16 [ undef, %land.lhs.true938 ], [ %162, %if.end970 ], [ undef, %if.end934 ]
  %phase_weights.sroa.50.0 = phi i16 [ undef, %land.lhs.true938 ], [ %161, %if.end970 ], [ undef, %if.end934 ]
  %or.cond2582 = icmp ult i32 %mul11.7, 1024
  br i1 %or.cond2582, label %land.lhs.true1044, label %if.end1146

land.lhs.true1044:                                ; preds = %if.end1040
  br i1 %cmp697.not, label %if.end1146, label %if.then1047

if.then1047:                                      ; preds = %land.lhs.true1044
  %add1049 = or disjoint i32 %mul11.7, 15
  %cmp1050 = icmp slt i32 %1, %add1049
  br i1 %cmp1050, label %for.cond1052.preheader, label %if.end1076

for.cond1052.preheader:                           ; preds = %if.then1047
  %165 = lshr i32 %18, 2
  %mul1058 = and i32 %165, 252
  %add1059 = add nuw nsw i32 %mul11.7, %mul1058
  %cmp1062.not = icmp sgt i32 %add1059, %1
  %fneg.2417 = select i1 %cmp1062.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3209 = insertelement <4 x float> poison, float %fneg.2417, i64 0
  %cmp1062.not.1.not = icmp slt i32 %add1059, %1
  %fneg.2417.1 = select i1 %cmp1062.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3302 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3209, float %fneg.2417.1, i64 1
  %add1060.2 = or disjoint i32 %add1059, 2
  %cmp1062.not.2 = icmp sgt i32 %add1060.2, %1
  %fneg.2417.2 = select i1 %cmp1062.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3395 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3302, float %fneg.2417.2, i64 2
  %add1060.3 = or disjoint i32 %add1059, 3
  %cmp1062.not.3 = icmp sgt i32 %add1060.3, %1
  %fneg.2417.3 = select i1 %cmp1062.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3488 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3395, float %fneg.2417.3, i64 3
  br label %if.end1076

if.end1076:                                       ; preds = %if.then1047, %for.cond1052.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3488, %for.cond1052.preheader ], [ zeroinitializer, %if.then1047 ]
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !87
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %166), !call_argsrelate !87
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %167), !call_argsrelate !87
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %168), !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3211 = extractelement <4 x float> %169, i64 0
  %mul1111 = fmul contract float %acc_s.sroa.0.0.vec.extract3211, 0x3FB99999A0000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul1111, float 0x4024CB5EC0000000)
  %171 = tail call contract noundef float @llvm.exp.f32(float %170)
  %acc_s.sroa.0.4.vec.extract3304 = extractelement <4 x float> %169, i64 1
  %mul1111.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3304, 0x3FB99999A0000000
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul1111.1, float 0x4024CB5EC0000000)
  %173 = tail call contract noundef float @llvm.exp.f32(float %172)
  %acc_s.sroa.0.8.vec.extract3397 = extractelement <4 x float> %169, i64 2
  %mul1111.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3397, 0x3FB99999A0000000
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul1111.2, float 0x4024CB5EC0000000)
  %175 = tail call contract noundef float @llvm.exp.f32(float %174)
  %acc_s.sroa.0.12.vec.extract3490 = extractelement <4 x float> %169, i64 3
  %mul1111.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3490, 0x3FB99999A0000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul1111.3, float 0x4024CB5EC0000000)
  %177 = tail call contract noundef float @llvm.exp.f32(float %176)
  %add1127 = fadd contract float %sum_acc.sroa.0.6, %171
  %add1127.1 = fadd contract float %sum_acc.sroa.20.6, %173
  %add1127.2 = fadd contract float %sum_acc.sroa.38.6, %175
  %add1127.3 = fadd contract float %sum_acc.sroa.56.6, %177
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171)
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %173)
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175)
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177)
  br label %if.end1146

if.end1146:                                       ; preds = %if.end1076, %land.lhs.true1044, %if.end1040
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1044 ], [ %add1127.3, %if.end1076 ], [ %sum_acc.sroa.56.6, %if.end1040 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1044 ], [ %add1127.2, %if.end1076 ], [ %sum_acc.sroa.38.6, %if.end1040 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1044 ], [ %add1127.1, %if.end1076 ], [ %sum_acc.sroa.20.6, %if.end1040 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1044 ], [ %add1127, %if.end1076 ], [ %sum_acc.sroa.0.6, %if.end1040 ]
  %phase_weights.sroa.64.0 = phi i16 [ undef, %land.lhs.true1044 ], [ %181, %if.end1076 ], [ undef, %if.end1040 ]
  %phase_weights.sroa.62.0 = phi i16 [ undef, %land.lhs.true1044 ], [ %180, %if.end1076 ], [ undef, %if.end1040 ]
  %phase_weights.sroa.60.0 = phi i16 [ undef, %land.lhs.true1044 ], [ %179, %if.end1076 ], [ undef, %if.end1040 ]
  %phase_weights.sroa.58.0 = phi i16 [ undef, %land.lhs.true1044 ], [ %178, %if.end1076 ], [ undef, %if.end1040 ]
  br i1 %or.cond2560, label %if.end1230, label %for.cond1207.preheader

for.cond1207.preheader:                           ; preds = %if.end1146
  %mul1212 = shl nsw i32 %0, 16
  %182 = shl nsw i32 %cond.i.i2426, 10
  %mul1214 = and i32 %182, 64512
  %mul1219 = shl nuw nsw i32 %18, 3
  %add1215 = or disjoint i32 %mul1219, %mul1212
  %add1217 = add nuw nsw i32 %add1215, %mul1214
  %183 = zext nneg i32 %add1217 to i64
  %add.ptr1222 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1222, align 16
  %V_reg.sroa.10.0.add.ptr1222.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1222, i64 8
  %V_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1222.sroa_idx, align 8
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %add.ptr1222.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024
  %V_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1222.1, align 16
  %V_reg.sroa.22.16.add.ptr1222.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032
  %V_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1222.1.sroa_idx, align 8
  br label %if.end1230

if.end1230:                                       ; preds = %for.cond1207.preheader, %if.end1146
  %V_reg.sroa.22.0 = phi <4 x half> [ undef, %if.end1146 ], [ %V_reg.sroa.22.16.copyload, %for.cond1207.preheader ]
  %V_reg.sroa.14.0 = phi <4 x half> [ undef, %if.end1146 ], [ %V_reg.sroa.14.16.copyload, %for.cond1207.preheader ]
  %V_reg.sroa.10.0 = phi <4 x half> [ undef, %if.end1146 ], [ %V_reg.sroa.10.0.copyload, %for.cond1207.preheader ]
  %V_reg.sroa.0.0 = phi <4 x half> [ undef, %if.end1146 ], [ %V_reg.sroa.0.0.copyload, %for.cond1207.preheader ]
  br i1 %or.cond2562, label %if.end1262, label %for.cond1239.preheader

for.cond1239.preheader:                           ; preds = %if.end1230
  %mul1244 = shl nsw i32 %0, 16
  %185 = shl nsw i32 %cond.i.i2426.1, 10
  %mul1246 = and i32 %185, 64512
  %mul1251 = shl nuw nsw i32 %18, 3
  %add1247 = or disjoint i32 %mul1251, %mul1244
  %add1249 = add nuw nsw i32 %add1247, %mul1246
  %186 = zext nneg i32 %add1249 to i64
  %add.ptr1254 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186
  %phase_v1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1254, align 16
  %phase_v1.sroa.10.0.add.ptr1254.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1254, i64 8
  %phase_v1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1254.sroa_idx, align 8
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186
  %add.ptr1254.1 = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1024
  %phase_v1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1254.1, align 16
  %phase_v1.sroa.22.16.add.ptr1254.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1032
  %phase_v1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1254.1.sroa_idx, align 8
  br label %if.end1262

if.end1262:                                       ; preds = %for.cond1239.preheader, %if.end1230
  %phase_v1.sroa.22.0 = phi <4 x half> [ undef, %if.end1230 ], [ %phase_v1.sroa.22.16.copyload, %for.cond1239.preheader ]
  %phase_v1.sroa.14.0 = phi <4 x half> [ undef, %if.end1230 ], [ %phase_v1.sroa.14.16.copyload, %for.cond1239.preheader ]
  %phase_v1.sroa.10.0 = phi <4 x half> [ undef, %if.end1230 ], [ %phase_v1.sroa.10.0.copyload, %for.cond1239.preheader ]
  %phase_v1.sroa.0.0 = phi <4 x half> [ undef, %if.end1230 ], [ %phase_v1.sroa.0.0.copyload, %for.cond1239.preheader ]
  br i1 %or.cond2560, label %if.end1299, label %for.body1273.preheader

for.body1273.preheader:                           ; preds = %if.end1262
  %188 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.0.0, i64 0
  %189 = insertelement <4 x i16> %188, i16 %phase_weights.sroa.4.0, i64 1
  %190 = insertelement <4 x i16> %189, i16 %phase_weights.sroa.6.0, i64 2
  %191 = insertelement <4 x i16> %190, i16 %phase_weights.sroa.8.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %191 to <4 x half>
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end1299

if.end1299:                                       ; preds = %for.body1273.preheader, %if.end1262
  %acc_o.sroa.110.0 = phi <4 x float> [ zeroinitializer, %if.end1262 ], [ %195, %for.body1273.preheader ]
  %acc_o.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1262 ], [ %194, %for.body1273.preheader ]
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1262 ], [ %193, %for.body1273.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1262 ], [ %192, %for.body1273.preheader ]
  br i1 %or.cond2562, label %if.end1337, label %for.body1310.preheader

for.body1310.preheader:                           ; preds = %if.end1299
  %196 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.10.0, i64 0
  %197 = insertelement <4 x i16> %196, i16 %phase_weights.sroa.12.0, i64 1
  %198 = insertelement <4 x i16> %197, i16 %phase_weights.sroa.14.0, i64 2
  %199 = insertelement <4 x i16> %198, i16 %phase_weights.sroa.16.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2768 = bitcast <4 x i16> %199 to <4 x half>
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  %201 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  br label %if.end1337

if.end1337:                                       ; preds = %for.body1310.preheader, %if.end1299
  %acc_o_1.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1299 ], [ %203, %for.body1310.preheader ]
  %acc_o_1.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1299 ], [ %202, %for.body1310.preheader ]
  %acc_o_1.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1299 ], [ %201, %for.body1310.preheader ]
  %acc_o_1.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1299 ], [ %200, %for.body1310.preheader ]
  br i1 %or.cond2564, label %if.end1369, label %for.cond1346.preheader

for.cond1346.preheader:                           ; preds = %if.end1337
  %mul1351 = shl nsw i32 %0, 16
  %204 = shl nsw i32 %cond.i.i2426.2, 10
  %mul1353 = and i32 %204, 64512
  %mul1358 = shl nuw nsw i32 %18, 3
  %add1354 = or disjoint i32 %mul1358, %mul1351
  %add1356 = add nuw nsw i32 %add1354, %mul1353
  %205 = zext nneg i32 %add1356 to i64
  %add.ptr1361 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %205
  %V_reg.sroa.0.0.copyload2808 = load <4 x half>, ptr addrspace(4) %add.ptr1361, align 16
  %V_reg.sroa.10.0.add.ptr1361.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1361, i64 8
  %V_reg.sroa.10.0.copyload2811 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1361.sroa_idx, align 8
  %206 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %205
  %add.ptr1361.1 = getelementptr inbounds i8, ptr addrspace(4) %206, i64 1024
  %V_reg.sroa.14.16.copyload2820 = load <4 x half>, ptr addrspace(4) %add.ptr1361.1, align 16
  %V_reg.sroa.22.16.add.ptr1361.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %206, i64 1032
  %V_reg.sroa.22.16.copyload2823 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1361.1.sroa_idx, align 8
  br label %if.end1369

if.end1369:                                       ; preds = %for.cond1346.preheader, %if.end1337
  %V_reg.sroa.22.1 = phi <4 x half> [ %V_reg.sroa.22.0, %if.end1337 ], [ %V_reg.sroa.22.16.copyload2823, %for.cond1346.preheader ]
  %V_reg.sroa.14.1 = phi <4 x half> [ %V_reg.sroa.14.0, %if.end1337 ], [ %V_reg.sroa.14.16.copyload2820, %for.cond1346.preheader ]
  %V_reg.sroa.10.1 = phi <4 x half> [ %V_reg.sroa.10.0, %if.end1337 ], [ %V_reg.sroa.10.0.copyload2811, %for.cond1346.preheader ]
  %V_reg.sroa.0.1 = phi <4 x half> [ %V_reg.sroa.0.0, %if.end1337 ], [ %V_reg.sroa.0.0.copyload2808, %for.cond1346.preheader ]
  br i1 %or.cond2566, label %if.end1401, label %for.cond1378.preheader

for.cond1378.preheader:                           ; preds = %if.end1369
  %mul1383 = shl nsw i32 %0, 16
  %207 = shl nsw i32 %cond.i.i2426.3, 10
  %mul1385 = and i32 %207, 64512
  %mul1390 = shl nuw nsw i32 %18, 3
  %add1386 = or disjoint i32 %mul1390, %mul1383
  %add1388 = add nuw nsw i32 %add1386, %mul1385
  %208 = zext nneg i32 %add1388 to i64
  %add.ptr1393 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %208
  %phase_v1.sroa.0.0.copyload2784 = load <4 x half>, ptr addrspace(4) %add.ptr1393, align 16
  %phase_v1.sroa.10.0.add.ptr1393.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1393, i64 8
  %phase_v1.sroa.10.0.copyload2787 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1393.sroa_idx, align 8
  %209 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %208
  %add.ptr1393.1 = getelementptr inbounds i8, ptr addrspace(4) %209, i64 1024
  %phase_v1.sroa.14.16.copyload2796 = load <4 x half>, ptr addrspace(4) %add.ptr1393.1, align 16
  %phase_v1.sroa.22.16.add.ptr1393.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %209, i64 1032
  %phase_v1.sroa.22.16.copyload2799 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1393.1.sroa_idx, align 8
  br label %if.end1401

if.end1401:                                       ; preds = %for.cond1378.preheader, %if.end1369
  %phase_v1.sroa.22.1 = phi <4 x half> [ %phase_v1.sroa.22.0, %if.end1369 ], [ %phase_v1.sroa.22.16.copyload2799, %for.cond1378.preheader ]
  %phase_v1.sroa.14.1 = phi <4 x half> [ %phase_v1.sroa.14.0, %if.end1369 ], [ %phase_v1.sroa.14.16.copyload2796, %for.cond1378.preheader ]
  %phase_v1.sroa.10.1 = phi <4 x half> [ %phase_v1.sroa.10.0, %if.end1369 ], [ %phase_v1.sroa.10.0.copyload2787, %for.cond1378.preheader ]
  %phase_v1.sroa.0.1 = phi <4 x half> [ %phase_v1.sroa.0.0, %if.end1369 ], [ %phase_v1.sroa.0.0.copyload2784, %for.cond1378.preheader ]
  br i1 %or.cond2564, label %if.end1439, label %for.body1412.preheader

for.body1412.preheader:                           ; preds = %if.end1401
  %210 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.18.0, i64 0
  %211 = insertelement <4 x i16> %210, i16 %phase_weights.sroa.20.0, i64 1
  %212 = insertelement <4 x i16> %211, i16 %phase_weights.sroa.22.0, i64 2
  %213 = insertelement <4 x i16> %212, i16 %phase_weights.sroa.24.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2770 = bitcast <4 x i16> %213 to <4 x half>
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  br label %if.end1439

if.end1439:                                       ; preds = %for.body1412.preheader, %if.end1401
  %acc_o_2.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1401 ], [ %217, %for.body1412.preheader ]
  %acc_o_2.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1401 ], [ %216, %for.body1412.preheader ]
  %acc_o_2.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1401 ], [ %215, %for.body1412.preheader ]
  %acc_o_2.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1401 ], [ %214, %for.body1412.preheader ]
  br i1 %or.cond2566, label %if.end1477, label %for.body1450.preheader

for.body1450.preheader:                           ; preds = %if.end1439
  %218 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.26.0, i64 0
  %219 = insertelement <4 x i16> %218, i16 %phase_weights.sroa.28.0, i64 1
  %220 = insertelement <4 x i16> %219, i16 %phase_weights.sroa.30.0, i64 2
  %221 = insertelement <4 x i16> %220, i16 %phase_weights.sroa.32.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2772 = bitcast <4 x i16> %221 to <4 x half>
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> zeroinitializer)
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> zeroinitializer)
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> zeroinitializer)
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> zeroinitializer)
  br label %if.end1477

if.end1477:                                       ; preds = %for.body1450.preheader, %if.end1439
  %acc_o_3.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1439 ], [ %225, %for.body1450.preheader ]
  %acc_o_3.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1439 ], [ %224, %for.body1450.preheader ]
  %acc_o_3.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1439 ], [ %223, %for.body1450.preheader ]
  %acc_o_3.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1439 ], [ %222, %for.body1450.preheader ]
  br i1 %or.cond2572, label %if.end1509, label %for.cond1486.preheader

for.cond1486.preheader:                           ; preds = %if.end1477
  %mul1491 = shl nsw i32 %0, 16
  %226 = shl nsw i32 %cond.i.i2426.4, 10
  %mul1493 = and i32 %226, 64512
  %mul1498 = shl nuw nsw i32 %18, 3
  %add1494 = or disjoint i32 %mul1498, %mul1491
  %add1496 = add nuw nsw i32 %add1494, %mul1493
  %227 = zext nneg i32 %add1496 to i64
  %add.ptr1501 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %227
  %V_reg.sroa.0.0.copyload2809 = load <4 x half>, ptr addrspace(4) %add.ptr1501, align 16
  %V_reg.sroa.10.0.add.ptr1501.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1501, i64 8
  %V_reg.sroa.10.0.copyload2812 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1501.sroa_idx, align 8
  %228 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %227
  %add.ptr1501.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1024
  %V_reg.sroa.14.16.copyload2821 = load <4 x half>, ptr addrspace(4) %add.ptr1501.1, align 16
  %V_reg.sroa.22.16.add.ptr1501.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1032
  %V_reg.sroa.22.16.copyload2824 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1501.1.sroa_idx, align 8
  br label %if.end1509

if.end1509:                                       ; preds = %for.cond1486.preheader, %if.end1477
  %V_reg.sroa.22.2 = phi <4 x half> [ %V_reg.sroa.22.1, %if.end1477 ], [ %V_reg.sroa.22.16.copyload2824, %for.cond1486.preheader ]
  %V_reg.sroa.14.2 = phi <4 x half> [ %V_reg.sroa.14.1, %if.end1477 ], [ %V_reg.sroa.14.16.copyload2821, %for.cond1486.preheader ]
  %V_reg.sroa.10.2 = phi <4 x half> [ %V_reg.sroa.10.1, %if.end1477 ], [ %V_reg.sroa.10.0.copyload2812, %for.cond1486.preheader ]
  %V_reg.sroa.0.2 = phi <4 x half> [ %V_reg.sroa.0.1, %if.end1477 ], [ %V_reg.sroa.0.0.copyload2809, %for.cond1486.preheader ]
  br i1 %or.cond2574, label %if.end1541, label %for.cond1518.preheader

for.cond1518.preheader:                           ; preds = %if.end1509
  %mul1523 = shl nsw i32 %0, 16
  %229 = shl nsw i32 %cond.i.i2426.5, 10
  %mul1525 = and i32 %229, 64512
  %mul1530 = shl nuw nsw i32 %18, 3
  %add1526 = or disjoint i32 %mul1530, %mul1523
  %add1528 = add nuw nsw i32 %add1526, %mul1525
  %230 = zext nneg i32 %add1528 to i64
  %add.ptr1533 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230
  %phase_v1.sroa.0.0.copyload2785 = load <4 x half>, ptr addrspace(4) %add.ptr1533, align 16
  %phase_v1.sroa.10.0.add.ptr1533.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1533, i64 8
  %phase_v1.sroa.10.0.copyload2788 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1533.sroa_idx, align 8
  %231 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230
  %add.ptr1533.1 = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1024
  %phase_v1.sroa.14.16.copyload2797 = load <4 x half>, ptr addrspace(4) %add.ptr1533.1, align 16
  %phase_v1.sroa.22.16.add.ptr1533.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1032
  %phase_v1.sroa.22.16.copyload2800 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1533.1.sroa_idx, align 8
  br label %if.end1541

if.end1541:                                       ; preds = %for.cond1518.preheader, %if.end1509
  %phase_v1.sroa.22.2 = phi <4 x half> [ %phase_v1.sroa.22.1, %if.end1509 ], [ %phase_v1.sroa.22.16.copyload2800, %for.cond1518.preheader ]
  %phase_v1.sroa.14.2 = phi <4 x half> [ %phase_v1.sroa.14.1, %if.end1509 ], [ %phase_v1.sroa.14.16.copyload2797, %for.cond1518.preheader ]
  %phase_v1.sroa.10.2 = phi <4 x half> [ %phase_v1.sroa.10.1, %if.end1509 ], [ %phase_v1.sroa.10.0.copyload2788, %for.cond1518.preheader ]
  %phase_v1.sroa.0.2 = phi <4 x half> [ %phase_v1.sroa.0.1, %if.end1509 ], [ %phase_v1.sroa.0.0.copyload2785, %for.cond1518.preheader ]
  br i1 %or.cond2572, label %if.end1579, label %for.body1552.preheader

for.body1552.preheader:                           ; preds = %if.end1541
  %232 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.34.0, i64 0
  %233 = insertelement <4 x i16> %232, i16 %phase_weights.sroa.36.0, i64 1
  %234 = insertelement <4 x i16> %233, i16 %phase_weights.sroa.38.0, i64 2
  %235 = insertelement <4 x i16> %234, i16 %phase_weights.sroa.40.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2774 = bitcast <4 x i16> %235 to <4 x half>
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o.sroa.0.0)
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o.sroa.38.0)
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o.sroa.74.0)
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o.sroa.110.0)
  br label %if.end1579

if.end1579:                                       ; preds = %for.body1552.preheader, %if.end1541
  %acc_o.sroa.110.1 = phi <4 x float> [ %acc_o.sroa.110.0, %if.end1541 ], [ %239, %for.body1552.preheader ]
  %acc_o.sroa.74.1 = phi <4 x float> [ %acc_o.sroa.74.0, %if.end1541 ], [ %238, %for.body1552.preheader ]
  %acc_o.sroa.38.1 = phi <4 x float> [ %acc_o.sroa.38.0, %if.end1541 ], [ %237, %for.body1552.preheader ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1541 ], [ %236, %for.body1552.preheader ]
  br i1 %or.cond2574, label %if.end1617, label %for.body1590.preheader

for.body1590.preheader:                           ; preds = %if.end1579
  %240 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.42.0, i64 0
  %241 = insertelement <4 x i16> %240, i16 %phase_weights.sroa.44.0, i64 1
  %242 = insertelement <4 x i16> %241, i16 %phase_weights.sroa.46.0, i64 2
  %243 = insertelement <4 x i16> %242, i16 %phase_weights.sroa.48.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2776 = bitcast <4 x i16> %243 to <4 x half>
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_1.sroa.0.0)
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_1.sroa.14.0)
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_1.sroa.26.0)
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_1.sroa.38.0)
  br label %if.end1617

if.end1617:                                       ; preds = %for.body1590.preheader, %if.end1579
  %acc_o_1.sroa.38.1 = phi <4 x float> [ %acc_o_1.sroa.38.0, %if.end1579 ], [ %247, %for.body1590.preheader ]
  %acc_o_1.sroa.26.1 = phi <4 x float> [ %acc_o_1.sroa.26.0, %if.end1579 ], [ %246, %for.body1590.preheader ]
  %acc_o_1.sroa.14.1 = phi <4 x float> [ %acc_o_1.sroa.14.0, %if.end1579 ], [ %245, %for.body1590.preheader ]
  %acc_o_1.sroa.0.1 = phi <4 x float> [ %acc_o_1.sroa.0.0, %if.end1579 ], [ %244, %for.body1590.preheader ]
  br i1 %or.cond2576, label %if.end1649, label %for.cond1626.preheader

for.cond1626.preheader:                           ; preds = %if.end1617
  %mul1631 = shl nsw i32 %0, 16
  %248 = shl nsw i32 %cond.i.i2426.6, 10
  %mul1633 = and i32 %248, 64512
  %mul1638 = shl nuw nsw i32 %18, 3
  %add1634 = or disjoint i32 %mul1638, %mul1631
  %add1636 = add nuw nsw i32 %add1634, %mul1633
  %249 = zext nneg i32 %add1636 to i64
  %add.ptr1641 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %249
  %V_reg.sroa.0.0.copyload2810 = load <4 x half>, ptr addrspace(4) %add.ptr1641, align 16
  %V_reg.sroa.10.0.add.ptr1641.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1641, i64 8
  %V_reg.sroa.10.0.copyload2813 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1641.sroa_idx, align 8
  %250 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %249
  %add.ptr1641.1 = getelementptr inbounds i8, ptr addrspace(4) %250, i64 1024
  %V_reg.sroa.14.16.copyload2822 = load <4 x half>, ptr addrspace(4) %add.ptr1641.1, align 16
  %V_reg.sroa.22.16.add.ptr1641.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %250, i64 1032
  %V_reg.sroa.22.16.copyload2825 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1641.1.sroa_idx, align 8
  br label %if.end1649

if.end1649:                                       ; preds = %for.cond1626.preheader, %if.end1617
  %V_reg.sroa.22.3 = phi <4 x half> [ %V_reg.sroa.22.2, %if.end1617 ], [ %V_reg.sroa.22.16.copyload2825, %for.cond1626.preheader ]
  %V_reg.sroa.14.3 = phi <4 x half> [ %V_reg.sroa.14.2, %if.end1617 ], [ %V_reg.sroa.14.16.copyload2822, %for.cond1626.preheader ]
  %V_reg.sroa.10.3 = phi <4 x half> [ %V_reg.sroa.10.2, %if.end1617 ], [ %V_reg.sroa.10.0.copyload2813, %for.cond1626.preheader ]
  %V_reg.sroa.0.3 = phi <4 x half> [ %V_reg.sroa.0.2, %if.end1617 ], [ %V_reg.sroa.0.0.copyload2810, %for.cond1626.preheader ]
  br i1 %or.cond2578, label %if.end1681, label %for.cond1658.preheader

for.cond1658.preheader:                           ; preds = %if.end1649
  %mul1663 = shl nsw i32 %0, 16
  %251 = shl nsw i32 %cond.i.i2426.7, 10
  %mul1665 = and i32 %251, 64512
  %mul1670 = shl nuw nsw i32 %18, 3
  %add1666 = or disjoint i32 %mul1670, %mul1663
  %add1668 = add nuw nsw i32 %add1666, %mul1665
  %252 = zext nneg i32 %add1668 to i64
  %add.ptr1673 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252
  %phase_v1.sroa.0.0.copyload2786 = load <4 x half>, ptr addrspace(4) %add.ptr1673, align 16
  %phase_v1.sroa.10.0.add.ptr1673.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1673, i64 8
  %phase_v1.sroa.10.0.copyload2789 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1673.sroa_idx, align 8
  %253 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252
  %add.ptr1673.1 = getelementptr inbounds i8, ptr addrspace(4) %253, i64 1024
  %phase_v1.sroa.14.16.copyload2798 = load <4 x half>, ptr addrspace(4) %add.ptr1673.1, align 16
  %phase_v1.sroa.22.16.add.ptr1673.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %253, i64 1032
  %phase_v1.sroa.22.16.copyload2801 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1673.1.sroa_idx, align 8
  br label %if.end1681

if.end1681:                                       ; preds = %for.cond1658.preheader, %if.end1649
  %phase_v1.sroa.22.3 = phi <4 x half> [ %phase_v1.sroa.22.2, %if.end1649 ], [ %phase_v1.sroa.22.16.copyload2801, %for.cond1658.preheader ]
  %phase_v1.sroa.14.3 = phi <4 x half> [ %phase_v1.sroa.14.2, %if.end1649 ], [ %phase_v1.sroa.14.16.copyload2798, %for.cond1658.preheader ]
  %phase_v1.sroa.10.3 = phi <4 x half> [ %phase_v1.sroa.10.2, %if.end1649 ], [ %phase_v1.sroa.10.0.copyload2789, %for.cond1658.preheader ]
  %phase_v1.sroa.0.3 = phi <4 x half> [ %phase_v1.sroa.0.2, %if.end1649 ], [ %phase_v1.sroa.0.0.copyload2786, %for.cond1658.preheader ]
  br i1 %or.cond2576, label %if.end1719, label %for.body1692.preheader

for.body1692.preheader:                           ; preds = %if.end1681
  %254 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.50.0, i64 0
  %255 = insertelement <4 x i16> %254, i16 %phase_weights.sroa.52.0, i64 1
  %256 = insertelement <4 x i16> %255, i16 %phase_weights.sroa.54.0, i64 2
  %257 = insertelement <4 x i16> %256, i16 %phase_weights.sroa.56.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2778 = bitcast <4 x i16> %257 to <4 x half>
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_2.sroa.0.0)
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_2.sroa.14.0)
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_2.sroa.26.0)
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_2.sroa.38.0)
  br label %if.end1719

if.end1719:                                       ; preds = %for.body1692.preheader, %if.end1681
  %acc_o_2.sroa.38.1 = phi <4 x float> [ %acc_o_2.sroa.38.0, %if.end1681 ], [ %261, %for.body1692.preheader ]
  %acc_o_2.sroa.26.1 = phi <4 x float> [ %acc_o_2.sroa.26.0, %if.end1681 ], [ %260, %for.body1692.preheader ]
  %acc_o_2.sroa.14.1 = phi <4 x float> [ %acc_o_2.sroa.14.0, %if.end1681 ], [ %259, %for.body1692.preheader ]
  %acc_o_2.sroa.0.1 = phi <4 x float> [ %acc_o_2.sroa.0.0, %if.end1681 ], [ %258, %for.body1692.preheader ]
  br i1 %or.cond2578, label %if.end1757, label %for.body1730.preheader

for.body1730.preheader:                           ; preds = %if.end1719
  %262 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.58.0, i64 0
  %263 = insertelement <4 x i16> %262, i16 %phase_weights.sroa.60.0, i64 1
  %264 = insertelement <4 x i16> %263, i16 %phase_weights.sroa.62.0, i64 2
  %265 = insertelement <4 x i16> %264, i16 %phase_weights.sroa.64.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2780 = bitcast <4 x i16> %265 to <4 x half>
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2780, <4 x float> %acc_o_3.sroa.0.0)
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2780, <4 x float> %acc_o_3.sroa.14.0)
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2780, <4 x float> %acc_o_3.sroa.26.0)
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2780, <4 x float> %acc_o_3.sroa.38.0)
  br label %if.end1757

if.end1757:                                       ; preds = %for.body1730.preheader, %if.end1719
  %acc_o_3.sroa.38.1 = phi <4 x float> [ %acc_o_3.sroa.38.0, %if.end1719 ], [ %269, %for.body1730.preheader ]
  %acc_o_3.sroa.26.1 = phi <4 x float> [ %acc_o_3.sroa.26.0, %if.end1719 ], [ %268, %for.body1730.preheader ]
  %acc_o_3.sroa.14.1 = phi <4 x float> [ %acc_o_3.sroa.14.0, %if.end1719 ], [ %267, %for.body1730.preheader ]
  %acc_o_3.sroa.0.1 = phi <4 x float> [ %acc_o_3.sroa.0.0, %if.end1719 ], [ %266, %for.body1730.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0
  %acc_o_1.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 0
  %add1766 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_1.sroa.0.0.vec.extract
  %acc_o_2.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 0
  %add1773 = fadd contract float %add1766, %acc_o_2.sroa.0.0.vec.extract
  %acc_o_3.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 0
  %add1780 = fadd contract float %add1773, %acc_o_3.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1
  %acc_o_1.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 1
  %add1766.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_1.sroa.0.4.vec.extract
  %acc_o_2.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 1
  %add1773.1 = fadd contract float %add1766.1, %acc_o_2.sroa.0.4.vec.extract
  %acc_o_3.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 1
  %add1780.1 = fadd contract float %add1773.1, %acc_o_3.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2
  %acc_o_1.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 2
  %add1766.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_1.sroa.0.8.vec.extract
  %acc_o_2.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 2
  %add1773.2 = fadd contract float %add1766.2, %acc_o_2.sroa.0.8.vec.extract
  %acc_o_3.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 2
  %add1780.2 = fadd contract float %add1773.2, %acc_o_3.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3
  %acc_o_1.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 3
  %add1766.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_1.sroa.0.12.vec.extract
  %acc_o_2.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 3
  %add1773.3 = fadd contract float %add1766.3, %acc_o_2.sroa.0.12.vec.extract
  %acc_o_3.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 3
  %add1780.3 = fadd contract float %add1773.3, %acc_o_3.sroa.0.12.vec.extract
  %acc_o.sroa.38.16.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 0
  %acc_o_1.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 0
  %add1766.4 = fadd contract float %acc_o.sroa.38.16.vec.extract, %acc_o_1.sroa.14.16.vec.extract
  %acc_o_2.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 0
  %add1773.4 = fadd contract float %add1766.4, %acc_o_2.sroa.14.16.vec.extract
  %acc_o_3.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 0
  %add1780.4 = fadd contract float %add1773.4, %acc_o_3.sroa.14.16.vec.extract
  %acc_o.sroa.38.20.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 1
  %acc_o_1.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 1
  %add1766.5 = fadd contract float %acc_o.sroa.38.20.vec.extract, %acc_o_1.sroa.14.20.vec.extract
  %acc_o_2.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 1
  %add1773.5 = fadd contract float %add1766.5, %acc_o_2.sroa.14.20.vec.extract
  %acc_o_3.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 1
  %add1780.5 = fadd contract float %add1773.5, %acc_o_3.sroa.14.20.vec.extract
  %acc_o.sroa.38.24.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 2
  %acc_o_1.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 2
  %add1766.6 = fadd contract float %acc_o.sroa.38.24.vec.extract, %acc_o_1.sroa.14.24.vec.extract
  %acc_o_2.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 2
  %add1773.6 = fadd contract float %add1766.6, %acc_o_2.sroa.14.24.vec.extract
  %acc_o_3.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 2
  %add1780.6 = fadd contract float %add1773.6, %acc_o_3.sroa.14.24.vec.extract
  %acc_o.sroa.38.28.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 3
  %acc_o_1.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 3
  %add1766.7 = fadd contract float %acc_o.sroa.38.28.vec.extract, %acc_o_1.sroa.14.28.vec.extract
  %acc_o_2.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 3
  %add1773.7 = fadd contract float %add1766.7, %acc_o_2.sroa.14.28.vec.extract
  %acc_o_3.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 3
  %add1780.7 = fadd contract float %add1773.7, %acc_o_3.sroa.14.28.vec.extract
  %acc_o.sroa.74.32.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 0
  %acc_o_1.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 0
  %add1766.8 = fadd contract float %acc_o.sroa.74.32.vec.extract, %acc_o_1.sroa.26.32.vec.extract
  %acc_o_2.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 0
  %add1773.8 = fadd contract float %add1766.8, %acc_o_2.sroa.26.32.vec.extract
  %acc_o_3.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 0
  %add1780.8 = fadd contract float %add1773.8, %acc_o_3.sroa.26.32.vec.extract
  %acc_o.sroa.74.36.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 1
  %acc_o_1.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 1
  %add1766.9 = fadd contract float %acc_o.sroa.74.36.vec.extract, %acc_o_1.sroa.26.36.vec.extract
  %acc_o_2.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 1
  %add1773.9 = fadd contract float %add1766.9, %acc_o_2.sroa.26.36.vec.extract
  %acc_o_3.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 1
  %add1780.9 = fadd contract float %add1773.9, %acc_o_3.sroa.26.36.vec.extract
  %acc_o.sroa.74.40.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 2
  %acc_o_1.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 2
  %add1766.10 = fadd contract float %acc_o.sroa.74.40.vec.extract, %acc_o_1.sroa.26.40.vec.extract
  %acc_o_2.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 2
  %add1773.10 = fadd contract float %add1766.10, %acc_o_2.sroa.26.40.vec.extract
  %acc_o_3.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 2
  %add1780.10 = fadd contract float %add1773.10, %acc_o_3.sroa.26.40.vec.extract
  %acc_o.sroa.74.44.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 3
  %acc_o_1.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 3
  %add1766.11 = fadd contract float %acc_o.sroa.74.44.vec.extract, %acc_o_1.sroa.26.44.vec.extract
  %acc_o_2.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 3
  %add1773.11 = fadd contract float %add1766.11, %acc_o_2.sroa.26.44.vec.extract
  %acc_o_3.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 3
  %add1780.11 = fadd contract float %add1773.11, %acc_o_3.sroa.26.44.vec.extract
  %acc_o.sroa.110.48.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 0
  %acc_o_1.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 0
  %add1766.12 = fadd contract float %acc_o.sroa.110.48.vec.extract, %acc_o_1.sroa.38.48.vec.extract
  %acc_o_2.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 0
  %add1773.12 = fadd contract float %add1766.12, %acc_o_2.sroa.38.48.vec.extract
  %acc_o_3.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 0
  %add1780.12 = fadd contract float %add1773.12, %acc_o_3.sroa.38.48.vec.extract
  %acc_o.sroa.110.52.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 1
  %acc_o_1.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 1
  %add1766.13 = fadd contract float %acc_o.sroa.110.52.vec.extract, %acc_o_1.sroa.38.52.vec.extract
  %acc_o_2.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 1
  %add1773.13 = fadd contract float %add1766.13, %acc_o_2.sroa.38.52.vec.extract
  %acc_o_3.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 1
  %add1780.13 = fadd contract float %add1773.13, %acc_o_3.sroa.38.52.vec.extract
  %acc_o.sroa.110.56.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 2
  %acc_o_1.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 2
  %add1766.14 = fadd contract float %acc_o.sroa.110.56.vec.extract, %acc_o_1.sroa.38.56.vec.extract
  %acc_o_2.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 2
  %add1773.14 = fadd contract float %add1766.14, %acc_o_2.sroa.38.56.vec.extract
  %acc_o_3.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 2
  %add1780.14 = fadd contract float %add1773.14, %acc_o_3.sroa.38.56.vec.extract
  %acc_o.sroa.110.60.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 3
  %acc_o_1.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 3
  %add1766.15 = fadd contract float %acc_o.sroa.110.60.vec.extract, %acc_o_1.sroa.38.60.vec.extract
  %acc_o_2.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 3
  %add1773.15 = fadd contract float %add1766.15, %acc_o_2.sroa.38.60.vec.extract
  %acc_o_3.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 3
  %add1780.15 = fadd contract float %add1773.15, %acc_o_3.sroa.38.60.vec.extract
  %add1794 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1794.1 = fadd contract float %add1794, %sum_acc.sroa.20.7
  %add1794.2 = fadd contract float %add1794.1, %sum_acc.sroa.38.7
  %add1794.3 = fadd contract float %add1794.2, %sum_acc.sroa.56.7
  %270 = bitcast float %add1794.3 to i32
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11
  %xor.i.i = xor i32 %272, 32
  %273 = and i32 %272, -64
  %and.i.i = add nsw i32 %273, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2427 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %272
  %shl.i.i = shl i32 %cond.i.i2427, 2
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %270)
  %275 = bitcast i32 %274 to float
  %add.i = fadd contract float %add1794.3, %275
  %276 = bitcast float %add.i to i32
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11
  %xor.i.i2428 = xor i32 %278, 16
  %279 = and i32 %278, -64
  %and.i.i2429 = add nsw i32 %279, 64
  %cmp.not.i.i2430 = icmp slt i32 %xor.i.i2428, %and.i.i2429
  %cond.i.i2431 = select i1 %cmp.not.i.i2430, i32 %xor.i.i2428, i32 %278
  %shl.i.i2432 = shl i32 %cond.i.i2431, 2
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2432, i32 %276)
  %281 = bitcast i32 %280 to float
  %add.i.i = fadd contract float %add.i, %281
  %cmp1803 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp1803, float %div, float 0.000000e+00
  %mul1816 = fmul contract float %condval_8.0, %add1780
  %mul1816.1 = fmul contract float %condval_8.0, %add1780.1
  %mul1816.2 = fmul contract float %condval_8.0, %add1780.2
  %mul1816.3 = fmul contract float %condval_8.0, %add1780.3
  %mul1816.4 = fmul contract float %condval_8.0, %add1780.4
  %mul1816.5 = fmul contract float %condval_8.0, %add1780.5
  %mul1816.6 = fmul contract float %condval_8.0, %add1780.6
  %mul1816.7 = fmul contract float %condval_8.0, %add1780.7
  %mul1816.8 = fmul contract float %condval_8.0, %add1780.8
  %mul1816.9 = fmul contract float %condval_8.0, %add1780.9
  %mul1816.10 = fmul contract float %condval_8.0, %add1780.10
  %mul1816.11 = fmul contract float %condval_8.0, %add1780.11
  %mul1816.12 = fmul contract float %condval_8.0, %add1780.12
  %mul1816.13 = fmul contract float %condval_8.0, %add1780.13
  %mul1816.14 = fmul contract float %condval_8.0, %add1780.14
  %mul1816.15 = fmul contract float %condval_8.0, %add1780.15
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816)
  %O_reg.sroa.0.0.insert.ext = zext i16 %282 to i64
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %283 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %284 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %286 to i64
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %287 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %288 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %290 to i64
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %291 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %292 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %293 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %294 to i64
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %295 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %296 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1816.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %297 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1858 = lshr i32 %18, 5
  %and1861 = and i32 %18, 7
  %298 = lshr i32 %18, 2
  %mul1867 = and i32 %298, 4
  %xor = xor i32 %shr1858, %and1861
  %mul1862 = shl nuw nsw i32 %xor, 3
  %add1863 = add nuw nsw i32 %mul1862, %mul25
  %add1868 = or disjoint i32 %add1863, %mul1867
  %add.ptr1870 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1868
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1870, align 8
  %add1859.1 = add nuw nsw i32 %shr1858, 2
  %xor.1 = xor i32 %add1859.1, %and1861
  %mul1862.1 = shl nuw nsw i32 %xor.1, 3
  %add1863.1 = add nuw nsw i32 %mul1862.1, %mul25
  %add1868.1 = or disjoint i32 %add1863.1, %mul1867
  %add.ptr1870.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1868.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1870.1, align 8
  %add1859.2 = add nuw nsw i32 %shr1858, 4
  %xor.2 = xor i32 %add1859.2, %and1861
  %mul1862.2 = shl nuw nsw i32 %xor.2, 3
  %add1863.2 = add nuw nsw i32 %mul1862.2, %mul25
  %add1868.2 = or disjoint i32 %add1863.2, %mul1867
  %add.ptr1870.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1868.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1870.2, align 8
  %add1859.3 = add nuw nsw i32 %shr1858, 6
  %xor.3 = xor i32 %add1859.3, %and1861
  %mul1862.3 = shl nuw nsw i32 %xor.3, 3
  %add1863.3 = add nuw nsw i32 %mul1862.3, %mul25
  %add1868.3 = or disjoint i32 %add1863.3, %mul1867
  %add.ptr1870.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1868.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1870.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %299 = shl nuw nsw i32 %18, 3
  %mul1881 = and i32 %299, 8128
  %xor18872409 = and i32 %299, 56
  %call1885.masked = and i32 %18, 1016
  %mul1888 = xor i32 %xor18872409, %call1885.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1881
  %invariant.gep2557 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1888
  %add1898 = add nuw nsw i32 %add23, %299
  %300 = zext nneg i32 %add1898 to i64
  %add.ptr1903 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1903, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2557, i64 16, i1 false), !tbaa.struct !407, !call_argsrelate !408
  %gep2558.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2557, i32 1024
  %301 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  %add.ptr1903.1 = getelementptr inbounds i8, ptr addrspace(1) %301, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1903.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2558.1, i64 16, i1 false), !tbaa.struct !407, !call_argsrelate !408
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


