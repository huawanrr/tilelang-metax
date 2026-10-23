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
  %cond.i.i2424 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2424, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2424.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2424.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2424.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2424.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2424.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2424.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2424.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2424.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2424.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2424.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2424.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2424.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2424.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2424.7, 4
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
  %or.cond2558 = or i1 %or.cond, %cmp47.not
  br i1 %or.cond2558, label %if.end, label %for.cond48.preheader

for.cond48.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2424, 10
  %mul56 = and i32 %22, 64512
  %mul61 = shl nuw nsw i32 %18, 3
  %add57 = or disjoint i32 %mul61, %mul54
  %add59 = add nuw nsw i32 %add57, %mul56
  %23 = zext nneg i32 %add59 to i64
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64, align 16
  %K_reg.sroa.10.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 8
  %K_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr64.sroa_idx, align 8
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %add.ptr64.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024
  %K_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64.1, align 16
  %K_reg.sroa.22.16.add.ptr64.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1032
  %K_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr64.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %for.cond48.preheader, %entry
  %K_reg.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.22.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.14.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.14.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.10.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.10.0.copyload, %for.cond48.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond48.preheader ]
  %or.cond2559 = icmp ugt i32 %mul11.1, 1023
  %cmp78.not = icmp sgt i32 %mul11.1, %1
  %or.cond2560 = or i1 %or.cond2559, %cmp78.not
  br i1 %or.cond2560, label %if.end104, label %for.cond80.preheader

for.cond80.preheader:                             ; preds = %if.end
  %mul86 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2424.1, 10
  %mul88 = and i32 %25, 64512
  %mul93 = shl nuw nsw i32 %18, 3
  %add89 = or disjoint i32 %mul93, %mul86
  %add91 = add nuw nsw i32 %add89, %mul88
  %26 = zext nneg i32 %add91 to i64
  %add.ptr96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96, align 16
  %K_reg1.sroa.10.0.add.ptr96.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr96, i64 8
  %K_reg1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr96.sroa_idx, align 8
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %add.ptr96.1 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024
  %K_reg1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96.1, align 16
  %K_reg1.sroa.22.16.add.ptr96.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1032
  %K_reg1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr96.1.sroa_idx, align 8
  br label %if.end104

if.end104:                                        ; preds = %for.cond80.preheader, %if.end
  %K_reg1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.22.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.14.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.14.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.10.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.10.0.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond80.preheader ]
  %or.cond2561 = icmp ult i32 %mul11, 1024
  br i1 %or.cond2561, label %land.lhs.true108, label %if.end210

land.lhs.true108:                                 ; preds = %if.end104
  br i1 %cmp47.not, label %if.end210, label %if.then111

if.then111:                                       ; preds = %land.lhs.true108
  %add113 = or disjoint i32 %mul11, 15
  %cmp114 = icmp ult i32 %1, %add113
  br i1 %cmp114, label %for.cond116.preheader, label %if.end140

for.cond116.preheader:                            ; preds = %if.then111
  %28 = lshr i32 %18, 2
  %mul123 = and i32 %28, 252
  %add124 = add nuw nsw i32 %mul11, %mul123
  %cmp127.not = icmp sgt i32 %add124, %1
  %fneg. = select i1 %cmp127.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3138 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp127.not.1.not = icmp slt i32 %add124, %1
  %fneg..1 = select i1 %cmp127.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3231 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3138, float %fneg..1, i64 1
  %add125.2 = or disjoint i32 %add124, 2
  %cmp127.not.2 = icmp sgt i32 %add125.2, %1
  %fneg..2 = select i1 %cmp127.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3324 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3231, float %fneg..2, i64 2
  %add125.3 = or disjoint i32 %add124, 3
  %cmp127.not.3 = icmp sgt i32 %add125.3, %1
  %fneg..3 = select i1 %cmp127.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3417 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3324, float %fneg..3, i64 3
  br label %if.end140

if.end140:                                        ; preds = %if.then111, %for.cond116.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3417, %for.cond116.preheader ], [ zeroinitializer, %if.then111 ]
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !77
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %29), !call_argsrelate !77
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %30), !call_argsrelate !77
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %31), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %32, i64 0
  %mul176 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul176, float 0x4024CB5EC0000000)
  %34 = tail call contract noundef float @llvm.exp.f32(float %33)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %32, i64 1
  %mul176.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul176.1, float 0x4024CB5EC0000000)
  %36 = tail call contract noundef float @llvm.exp.f32(float %35)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %32, i64 2
  %mul176.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul176.2, float 0x4024CB5EC0000000)
  %38 = tail call contract noundef float @llvm.exp.f32(float %37)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %32, i64 3
  %mul176.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul176.3, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  %41 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %34)
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %36)
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %38)
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %40)
  br label %if.end210

if.end210:                                        ; preds = %if.end140, %land.lhs.true108, %if.end104
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %40, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %38, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %36, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %34, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %phase_weights.sroa.8.0 = phi i16 [ undef, %land.lhs.true108 ], [ %44, %if.end140 ], [ undef, %if.end104 ]
  %phase_weights.sroa.6.0 = phi i16 [ undef, %land.lhs.true108 ], [ %43, %if.end140 ], [ undef, %if.end104 ]
  %phase_weights.sroa.4.0 = phi i16 [ undef, %land.lhs.true108 ], [ %42, %if.end140 ], [ undef, %if.end104 ]
  %phase_weights.sroa.0.0 = phi i16 [ undef, %land.lhs.true108 ], [ %41, %if.end140 ], [ undef, %if.end104 ]
  %or.cond2562 = icmp ult i32 %mul11.1, 1024
  br i1 %or.cond2562, label %land.lhs.true214, label %if.end316

land.lhs.true214:                                 ; preds = %if.end210
  br i1 %cmp78.not, label %if.end316, label %if.then217

if.then217:                                       ; preds = %land.lhs.true214
  %add219 = or disjoint i32 %mul11.1, 15
  %cmp220 = icmp ult i32 %1, %add219
  br i1 %cmp220, label %for.cond222.preheader, label %if.end246

for.cond222.preheader:                            ; preds = %if.then217
  %45 = lshr i32 %18, 2
  %mul228 = and i32 %45, 252
  %add229 = add nuw nsw i32 %mul11.1, %mul228
  %cmp232.not = icmp sgt i32 %add229, %1
  %fneg.2409 = select i1 %cmp232.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3147 = insertelement <4 x float> poison, float %fneg.2409, i64 0
  %cmp232.not.1.not = icmp slt i32 %add229, %1
  %fneg.2409.1 = select i1 %cmp232.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3240 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3147, float %fneg.2409.1, i64 1
  %add230.2 = or disjoint i32 %add229, 2
  %cmp232.not.2 = icmp sgt i32 %add230.2, %1
  %fneg.2409.2 = select i1 %cmp232.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3333 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3240, float %fneg.2409.2, i64 2
  %add230.3 = or disjoint i32 %add229, 3
  %cmp232.not.3 = icmp sgt i32 %add230.3, %1
  %fneg.2409.3 = select i1 %cmp232.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3426 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3333, float %fneg.2409.3, i64 3
  br label %if.end246

if.end246:                                        ; preds = %if.then217, %for.cond222.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3426, %for.cond222.preheader ], [ zeroinitializer, %if.then217 ]
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !77
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %46), !call_argsrelate !77
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %47), !call_argsrelate !77
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %48), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3149 = extractelement <4 x float> %49, i64 0
  %mul281 = fmul contract float %acc_s.sroa.0.0.vec.extract3149, 0x3FB99999A0000000
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul281, float 0x4024CB5EC0000000)
  %51 = tail call contract noundef float @llvm.exp.f32(float %50)
  %acc_s.sroa.0.4.vec.extract3242 = extractelement <4 x float> %49, i64 1
  %mul281.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3242, 0x3FB99999A0000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul281.1, float 0x4024CB5EC0000000)
  %53 = tail call contract noundef float @llvm.exp.f32(float %52)
  %acc_s.sroa.0.8.vec.extract3335 = extractelement <4 x float> %49, i64 2
  %mul281.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3335, 0x3FB99999A0000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul281.2, float 0x4024CB5EC0000000)
  %55 = tail call contract noundef float @llvm.exp.f32(float %54)
  %acc_s.sroa.0.12.vec.extract3428 = extractelement <4 x float> %49, i64 3
  %mul281.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3428, 0x3FB99999A0000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul281.3, float 0x4024CB5EC0000000)
  %57 = tail call contract noundef float @llvm.exp.f32(float %56)
  %add297 = fadd contract float %sum_acc.sroa.0.0, %51
  %add297.1 = fadd contract float %sum_acc.sroa.20.0, %53
  %add297.2 = fadd contract float %sum_acc.sroa.38.0, %55
  %add297.3 = fadd contract float %sum_acc.sroa.56.0, %57
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51)
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53)
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55)
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57)
  br label %if.end316

if.end316:                                        ; preds = %if.end246, %land.lhs.true214, %if.end210
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true214 ], [ %add297.3, %if.end246 ], [ %sum_acc.sroa.56.0, %if.end210 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true214 ], [ %add297.2, %if.end246 ], [ %sum_acc.sroa.38.0, %if.end210 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true214 ], [ %add297.1, %if.end246 ], [ %sum_acc.sroa.20.0, %if.end210 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true214 ], [ %add297, %if.end246 ], [ %sum_acc.sroa.0.0, %if.end210 ]
  %phase_weights.sroa.16.0 = phi i16 [ undef, %land.lhs.true214 ], [ %61, %if.end246 ], [ undef, %if.end210 ]
  %phase_weights.sroa.14.0 = phi i16 [ undef, %land.lhs.true214 ], [ %60, %if.end246 ], [ undef, %if.end210 ]
  %phase_weights.sroa.12.0 = phi i16 [ undef, %land.lhs.true214 ], [ %59, %if.end246 ], [ undef, %if.end210 ]
  %phase_weights.sroa.10.0 = phi i16 [ undef, %land.lhs.true214 ], [ %58, %if.end246 ], [ undef, %if.end210 ]
  %or.cond2563 = icmp ugt i32 %mul11.2, 1023
  %cmp323.not = icmp sgt i32 %mul11.2, %1
  %or.cond2564 = or i1 %or.cond2563, %cmp323.not
  br i1 %or.cond2564, label %if.end348, label %for.cond325.preheader

for.cond325.preheader:                            ; preds = %if.end316
  %mul330 = shl nsw i32 %0, 16
  %62 = shl nsw i32 %cond.i.i2424.2, 10
  %mul332 = and i32 %62, 64512
  %mul337 = shl nuw nsw i32 %18, 3
  %add333 = or disjoint i32 %mul337, %mul330
  %add335 = add nuw nsw i32 %add333, %mul332
  %63 = zext nneg i32 %add335 to i64
  %add.ptr340 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63
  %K_reg.sroa.0.0.copyload3522 = load <4 x half>, ptr addrspace(4) %add.ptr340, align 16
  %K_reg.sroa.10.0.add.ptr340.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr340, i64 8
  %K_reg.sroa.10.0.copyload3525 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr340.sroa_idx, align 8
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63
  %add.ptr340.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024
  %K_reg.sroa.14.16.copyload3534 = load <4 x half>, ptr addrspace(4) %add.ptr340.1, align 16
  %K_reg.sroa.22.16.add.ptr340.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032
  %K_reg.sroa.22.16.copyload3537 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr340.1.sroa_idx, align 8
  br label %if.end348

if.end348:                                        ; preds = %for.cond325.preheader, %if.end316
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end316 ], [ %K_reg.sroa.22.16.copyload3537, %for.cond325.preheader ]
  %K_reg.sroa.14.1 = phi <4 x half> [ %K_reg.sroa.14.0, %if.end316 ], [ %K_reg.sroa.14.16.copyload3534, %for.cond325.preheader ]
  %K_reg.sroa.10.1 = phi <4 x half> [ %K_reg.sroa.10.0, %if.end316 ], [ %K_reg.sroa.10.0.copyload3525, %for.cond325.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end316 ], [ %K_reg.sroa.0.0.copyload3522, %for.cond325.preheader ]
  %or.cond2565 = icmp ugt i32 %mul11.3, 1023
  %cmp355.not = icmp sgt i32 %mul11.3, %1
  %or.cond2566 = or i1 %or.cond2565, %cmp355.not
  br i1 %or.cond2566, label %if.end380, label %for.cond357.preheader

for.cond357.preheader:                            ; preds = %if.end348
  %mul362 = shl nsw i32 %0, 16
  %65 = shl nsw i32 %cond.i.i2424.3, 10
  %mul364 = and i32 %65, 64512
  %mul369 = shl nuw nsw i32 %18, 3
  %add365 = or disjoint i32 %mul369, %mul362
  %add367 = add nuw nsw i32 %add365, %mul364
  %66 = zext nneg i32 %add367 to i64
  %add.ptr372 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66
  %K_reg1.sroa.0.0.copyload3498 = load <4 x half>, ptr addrspace(4) %add.ptr372, align 16
  %K_reg1.sroa.10.0.add.ptr372.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr372, i64 8
  %K_reg1.sroa.10.0.copyload3501 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr372.sroa_idx, align 8
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66
  %add.ptr372.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1024
  %K_reg1.sroa.14.16.copyload3510 = load <4 x half>, ptr addrspace(4) %add.ptr372.1, align 16
  %K_reg1.sroa.22.16.add.ptr372.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1032
  %K_reg1.sroa.22.16.copyload3513 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr372.1.sroa_idx, align 8
  br label %if.end380

if.end380:                                        ; preds = %for.cond357.preheader, %if.end348
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end348 ], [ %K_reg1.sroa.22.16.copyload3513, %for.cond357.preheader ]
  %K_reg1.sroa.14.1 = phi <4 x half> [ %K_reg1.sroa.14.0, %if.end348 ], [ %K_reg1.sroa.14.16.copyload3510, %for.cond357.preheader ]
  %K_reg1.sroa.10.1 = phi <4 x half> [ %K_reg1.sroa.10.0, %if.end348 ], [ %K_reg1.sroa.10.0.copyload3501, %for.cond357.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end348 ], [ %K_reg1.sroa.0.0.copyload3498, %for.cond357.preheader ]
  %or.cond2567 = icmp ult i32 %mul11.2, 1024
  br i1 %or.cond2567, label %land.lhs.true384, label %if.end486

land.lhs.true384:                                 ; preds = %if.end380
  br i1 %cmp323.not, label %if.end486, label %if.then387

if.then387:                                       ; preds = %land.lhs.true384
  %add389 = or disjoint i32 %mul11.2, 15
  %cmp390 = icmp ult i32 %1, %add389
  br i1 %cmp390, label %for.cond392.preheader, label %if.end416

for.cond392.preheader:                            ; preds = %if.then387
  %68 = lshr i32 %18, 2
  %mul398 = and i32 %68, 252
  %add399 = add nuw nsw i32 %mul11.2, %mul398
  %cmp402.not = icmp sgt i32 %add399, %1
  %fneg.2410 = select i1 %cmp402.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3157 = insertelement <4 x float> poison, float %fneg.2410, i64 0
  %cmp402.not.1.not = icmp slt i32 %add399, %1
  %fneg.2410.1 = select i1 %cmp402.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3250 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3157, float %fneg.2410.1, i64 1
  %add400.2 = or disjoint i32 %add399, 2
  %cmp402.not.2 = icmp sgt i32 %add400.2, %1
  %fneg.2410.2 = select i1 %cmp402.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3343 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3250, float %fneg.2410.2, i64 2
  %add400.3 = or disjoint i32 %add399, 3
  %cmp402.not.3 = icmp sgt i32 %add400.3, %1
  %fneg.2410.3 = select i1 %cmp402.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3436 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3343, float %fneg.2410.3, i64 3
  br label %if.end416

if.end416:                                        ; preds = %if.then387, %for.cond392.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3436, %for.cond392.preheader ], [ zeroinitializer, %if.then387 ]
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !77
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !call_argsrelate !77
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !call_argsrelate !77
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3159 = extractelement <4 x float> %72, i64 0
  %mul451 = fmul contract float %acc_s.sroa.0.0.vec.extract3159, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul451, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %acc_s.sroa.0.4.vec.extract3252 = extractelement <4 x float> %72, i64 1
  %mul451.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3252, 0x3FB99999A0000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul451.1, float 0x4024CB5EC0000000)
  %76 = tail call contract noundef float @llvm.exp.f32(float %75)
  %acc_s.sroa.0.8.vec.extract3345 = extractelement <4 x float> %72, i64 2
  %mul451.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3345, 0x3FB99999A0000000
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul451.2, float 0x4024CB5EC0000000)
  %78 = tail call contract noundef float @llvm.exp.f32(float %77)
  %acc_s.sroa.0.12.vec.extract3438 = extractelement <4 x float> %72, i64 3
  %mul451.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3438, 0x3FB99999A0000000
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul451.3, float 0x4024CB5EC0000000)
  %80 = tail call contract noundef float @llvm.exp.f32(float %79)
  %add467 = fadd contract float %sum_acc.sroa.0.1, %74
  %add467.1 = fadd contract float %sum_acc.sroa.20.1, %76
  %add467.2 = fadd contract float %sum_acc.sroa.38.1, %78
  %add467.3 = fadd contract float %sum_acc.sroa.56.1, %80
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76)
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78)
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80)
  br label %if.end486

if.end486:                                        ; preds = %if.end416, %land.lhs.true384, %if.end380
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true384 ], [ %add467.3, %if.end416 ], [ %sum_acc.sroa.56.1, %if.end380 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true384 ], [ %add467.2, %if.end416 ], [ %sum_acc.sroa.38.1, %if.end380 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true384 ], [ %add467.1, %if.end416 ], [ %sum_acc.sroa.20.1, %if.end380 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true384 ], [ %add467, %if.end416 ], [ %sum_acc.sroa.0.1, %if.end380 ]
  %phase_weights.sroa.24.0 = phi i16 [ undef, %land.lhs.true384 ], [ %84, %if.end416 ], [ undef, %if.end380 ]
  %phase_weights.sroa.22.0 = phi i16 [ undef, %land.lhs.true384 ], [ %83, %if.end416 ], [ undef, %if.end380 ]
  %phase_weights.sroa.20.0 = phi i16 [ undef, %land.lhs.true384 ], [ %82, %if.end416 ], [ undef, %if.end380 ]
  %phase_weights.sroa.18.0 = phi i16 [ undef, %land.lhs.true384 ], [ %81, %if.end416 ], [ undef, %if.end380 ]
  %or.cond2568 = icmp ult i32 %mul11.3, 1024
  br i1 %or.cond2568, label %land.lhs.true490, label %if.end592

land.lhs.true490:                                 ; preds = %if.end486
  br i1 %cmp355.not, label %if.end592, label %if.then493

if.then493:                                       ; preds = %land.lhs.true490
  %add495 = or disjoint i32 %mul11.3, 15
  %cmp496 = icmp ult i32 %1, %add495
  br i1 %cmp496, label %for.cond498.preheader, label %if.end522

for.cond498.preheader:                            ; preds = %if.then493
  %85 = lshr i32 %18, 2
  %mul504 = and i32 %85, 252
  %add505 = add nuw nsw i32 %mul11.3, %mul504
  %cmp508.not = icmp sgt i32 %add505, %1
  %fneg.2411 = select i1 %cmp508.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3167 = insertelement <4 x float> poison, float %fneg.2411, i64 0
  %cmp508.not.1.not = icmp slt i32 %add505, %1
  %fneg.2411.1 = select i1 %cmp508.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3260 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3167, float %fneg.2411.1, i64 1
  %add506.2 = or disjoint i32 %add505, 2
  %cmp508.not.2 = icmp sgt i32 %add506.2, %1
  %fneg.2411.2 = select i1 %cmp508.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3353 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3260, float %fneg.2411.2, i64 2
  %add506.3 = or disjoint i32 %add505, 3
  %cmp508.not.3 = icmp sgt i32 %add506.3, %1
  %fneg.2411.3 = select i1 %cmp508.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3446 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3353, float %fneg.2411.3, i64 3
  br label %if.end522

if.end522:                                        ; preds = %if.then493, %for.cond498.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3446, %for.cond498.preheader ], [ zeroinitializer, %if.then493 ]
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !77
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %86), !call_argsrelate !77
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %87), !call_argsrelate !77
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %88), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3169 = extractelement <4 x float> %89, i64 0
  %mul557 = fmul contract float %acc_s.sroa.0.0.vec.extract3169, 0x3FB99999A0000000
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul557, float 0x4024CB5EC0000000)
  %91 = tail call contract noundef float @llvm.exp.f32(float %90)
  %acc_s.sroa.0.4.vec.extract3262 = extractelement <4 x float> %89, i64 1
  %mul557.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3262, 0x3FB99999A0000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul557.1, float 0x4024CB5EC0000000)
  %93 = tail call contract noundef float @llvm.exp.f32(float %92)
  %acc_s.sroa.0.8.vec.extract3355 = extractelement <4 x float> %89, i64 2
  %mul557.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3355, 0x3FB99999A0000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul557.2, float 0x4024CB5EC0000000)
  %95 = tail call contract noundef float @llvm.exp.f32(float %94)
  %acc_s.sroa.0.12.vec.extract3448 = extractelement <4 x float> %89, i64 3
  %mul557.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3448, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul557.3, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %add573 = fadd contract float %sum_acc.sroa.0.2, %91
  %add573.1 = fadd contract float %sum_acc.sroa.20.2, %93
  %add573.2 = fadd contract float %sum_acc.sroa.38.2, %95
  %add573.3 = fadd contract float %sum_acc.sroa.56.2, %97
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91)
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93)
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95)
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  br label %if.end592

if.end592:                                        ; preds = %if.end522, %land.lhs.true490, %if.end486
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true490 ], [ %add573.3, %if.end522 ], [ %sum_acc.sroa.56.2, %if.end486 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true490 ], [ %add573.2, %if.end522 ], [ %sum_acc.sroa.38.2, %if.end486 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true490 ], [ %add573.1, %if.end522 ], [ %sum_acc.sroa.20.2, %if.end486 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true490 ], [ %add573, %if.end522 ], [ %sum_acc.sroa.0.2, %if.end486 ]
  %phase_weights.sroa.32.0 = phi i16 [ undef, %land.lhs.true490 ], [ %101, %if.end522 ], [ undef, %if.end486 ]
  %phase_weights.sroa.30.0 = phi i16 [ undef, %land.lhs.true490 ], [ %100, %if.end522 ], [ undef, %if.end486 ]
  %phase_weights.sroa.28.0 = phi i16 [ undef, %land.lhs.true490 ], [ %99, %if.end522 ], [ undef, %if.end486 ]
  %phase_weights.sroa.26.0 = phi i16 [ undef, %land.lhs.true490 ], [ %98, %if.end522 ], [ undef, %if.end486 ]
  %or.cond2569 = icmp ugt i32 %mul11.4, 1023
  %cmp599.not = icmp sgt i32 %mul11.4, %1
  %or.cond2570 = or i1 %or.cond2569, %cmp599.not
  br i1 %or.cond2570, label %if.end624, label %for.cond601.preheader

for.cond601.preheader:                            ; preds = %if.end592
  %mul606 = shl nsw i32 %0, 16
  %102 = shl nsw i32 %cond.i.i2424.4, 10
  %mul608 = and i32 %102, 64512
  %mul613 = shl nuw nsw i32 %18, 3
  %add609 = or disjoint i32 %mul613, %mul606
  %add611 = add nuw nsw i32 %add609, %mul608
  %103 = zext nneg i32 %add611 to i64
  %add.ptr616 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103
  %K_reg.sroa.0.0.copyload3523 = load <4 x half>, ptr addrspace(4) %add.ptr616, align 16
  %K_reg.sroa.10.0.add.ptr616.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr616, i64 8
  %K_reg.sroa.10.0.copyload3526 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr616.sroa_idx, align 8
  %104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103
  %add.ptr616.1 = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1024
  %K_reg.sroa.14.16.copyload3535 = load <4 x half>, ptr addrspace(4) %add.ptr616.1, align 16
  %K_reg.sroa.22.16.add.ptr616.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1032
  %K_reg.sroa.22.16.copyload3538 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr616.1.sroa_idx, align 8
  br label %if.end624

if.end624:                                        ; preds = %for.cond601.preheader, %if.end592
  %K_reg.sroa.22.2 = phi <4 x half> [ %K_reg.sroa.22.1, %if.end592 ], [ %K_reg.sroa.22.16.copyload3538, %for.cond601.preheader ]
  %K_reg.sroa.14.2 = phi <4 x half> [ %K_reg.sroa.14.1, %if.end592 ], [ %K_reg.sroa.14.16.copyload3535, %for.cond601.preheader ]
  %K_reg.sroa.10.2 = phi <4 x half> [ %K_reg.sroa.10.1, %if.end592 ], [ %K_reg.sroa.10.0.copyload3526, %for.cond601.preheader ]
  %K_reg.sroa.0.2 = phi <4 x half> [ %K_reg.sroa.0.1, %if.end592 ], [ %K_reg.sroa.0.0.copyload3523, %for.cond601.preheader ]
  %or.cond2571 = icmp ugt i32 %mul11.5, 1023
  %cmp631.not = icmp sgt i32 %mul11.5, %1
  %or.cond2572 = or i1 %or.cond2571, %cmp631.not
  br i1 %or.cond2572, label %if.end656, label %for.cond633.preheader

for.cond633.preheader:                            ; preds = %if.end624
  %mul638 = shl nsw i32 %0, 16
  %105 = shl nsw i32 %cond.i.i2424.5, 10
  %mul640 = and i32 %105, 64512
  %mul645 = shl nuw nsw i32 %18, 3
  %add641 = or disjoint i32 %mul645, %mul638
  %add643 = add nuw nsw i32 %add641, %mul640
  %106 = zext nneg i32 %add643 to i64
  %add.ptr648 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106
  %K_reg1.sroa.0.0.copyload3499 = load <4 x half>, ptr addrspace(4) %add.ptr648, align 16
  %K_reg1.sroa.10.0.add.ptr648.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr648, i64 8
  %K_reg1.sroa.10.0.copyload3502 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr648.sroa_idx, align 8
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106
  %add.ptr648.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024
  %K_reg1.sroa.14.16.copyload3511 = load <4 x half>, ptr addrspace(4) %add.ptr648.1, align 16
  %K_reg1.sroa.22.16.add.ptr648.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032
  %K_reg1.sroa.22.16.copyload3514 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr648.1.sroa_idx, align 8
  br label %if.end656

if.end656:                                        ; preds = %for.cond633.preheader, %if.end624
  %K_reg1.sroa.22.2 = phi <4 x half> [ %K_reg1.sroa.22.1, %if.end624 ], [ %K_reg1.sroa.22.16.copyload3514, %for.cond633.preheader ]
  %K_reg1.sroa.14.2 = phi <4 x half> [ %K_reg1.sroa.14.1, %if.end624 ], [ %K_reg1.sroa.14.16.copyload3511, %for.cond633.preheader ]
  %K_reg1.sroa.10.2 = phi <4 x half> [ %K_reg1.sroa.10.1, %if.end624 ], [ %K_reg1.sroa.10.0.copyload3502, %for.cond633.preheader ]
  %K_reg1.sroa.0.2 = phi <4 x half> [ %K_reg1.sroa.0.1, %if.end624 ], [ %K_reg1.sroa.0.0.copyload3499, %for.cond633.preheader ]
  %or.cond2573 = icmp ult i32 %mul11.4, 1024
  br i1 %or.cond2573, label %land.lhs.true660, label %if.end762

land.lhs.true660:                                 ; preds = %if.end656
  br i1 %cmp599.not, label %if.end762, label %if.then663

if.then663:                                       ; preds = %land.lhs.true660
  %add665 = or disjoint i32 %mul11.4, 15
  %cmp666 = icmp ult i32 %1, %add665
  br i1 %cmp666, label %for.cond668.preheader, label %if.end692

for.cond668.preheader:                            ; preds = %if.then663
  %108 = lshr i32 %18, 2
  %mul674 = and i32 %108, 252
  %add675 = add nuw nsw i32 %mul11.4, %mul674
  %cmp678.not = icmp sgt i32 %add675, %1
  %fneg.2412 = select i1 %cmp678.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3177 = insertelement <4 x float> poison, float %fneg.2412, i64 0
  %cmp678.not.1.not = icmp slt i32 %add675, %1
  %fneg.2412.1 = select i1 %cmp678.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3270 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3177, float %fneg.2412.1, i64 1
  %add676.2 = or disjoint i32 %add675, 2
  %cmp678.not.2 = icmp sgt i32 %add676.2, %1
  %fneg.2412.2 = select i1 %cmp678.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3363 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3270, float %fneg.2412.2, i64 2
  %add676.3 = or disjoint i32 %add675, 3
  %cmp678.not.3 = icmp sgt i32 %add676.3, %1
  %fneg.2412.3 = select i1 %cmp678.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3456 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3363, float %fneg.2412.3, i64 3
  br label %if.end692

if.end692:                                        ; preds = %if.then663, %for.cond668.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3456, %for.cond668.preheader ], [ zeroinitializer, %if.then663 ]
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !77
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %109), !call_argsrelate !77
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %110), !call_argsrelate !77
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %111), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3179 = extractelement <4 x float> %112, i64 0
  %mul727 = fmul contract float %acc_s.sroa.0.0.vec.extract3179, 0x3FB99999A0000000
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul727, float 0x4024CB5EC0000000)
  %114 = tail call contract noundef float @llvm.exp.f32(float %113)
  %acc_s.sroa.0.4.vec.extract3272 = extractelement <4 x float> %112, i64 1
  %mul727.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3272, 0x3FB99999A0000000
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul727.1, float 0x4024CB5EC0000000)
  %116 = tail call contract noundef float @llvm.exp.f32(float %115)
  %acc_s.sroa.0.8.vec.extract3365 = extractelement <4 x float> %112, i64 2
  %mul727.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3365, 0x3FB99999A0000000
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul727.2, float 0x4024CB5EC0000000)
  %118 = tail call contract noundef float @llvm.exp.f32(float %117)
  %acc_s.sroa.0.12.vec.extract3458 = extractelement <4 x float> %112, i64 3
  %mul727.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3458, 0x3FB99999A0000000
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul727.3, float 0x4024CB5EC0000000)
  %120 = tail call contract noundef float @llvm.exp.f32(float %119)
  %add743 = fadd contract float %sum_acc.sroa.0.3, %114
  %add743.1 = fadd contract float %sum_acc.sroa.20.3, %116
  %add743.2 = fadd contract float %sum_acc.sroa.38.3, %118
  %add743.3 = fadd contract float %sum_acc.sroa.56.3, %120
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114)
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116)
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118)
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120)
  br label %if.end762

if.end762:                                        ; preds = %if.end692, %land.lhs.true660, %if.end656
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true660 ], [ %add743.3, %if.end692 ], [ %sum_acc.sroa.56.3, %if.end656 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true660 ], [ %add743.2, %if.end692 ], [ %sum_acc.sroa.38.3, %if.end656 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true660 ], [ %add743.1, %if.end692 ], [ %sum_acc.sroa.20.3, %if.end656 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true660 ], [ %add743, %if.end692 ], [ %sum_acc.sroa.0.3, %if.end656 ]
  %phase_weights.sroa.40.0 = phi i16 [ undef, %land.lhs.true660 ], [ %124, %if.end692 ], [ undef, %if.end656 ]
  %phase_weights.sroa.38.0 = phi i16 [ undef, %land.lhs.true660 ], [ %123, %if.end692 ], [ undef, %if.end656 ]
  %phase_weights.sroa.36.0 = phi i16 [ undef, %land.lhs.true660 ], [ %122, %if.end692 ], [ undef, %if.end656 ]
  %phase_weights.sroa.34.0 = phi i16 [ undef, %land.lhs.true660 ], [ %121, %if.end692 ], [ undef, %if.end656 ]
  %or.cond2574 = icmp ult i32 %mul11.5, 1024
  br i1 %or.cond2574, label %land.lhs.true766, label %if.end868

land.lhs.true766:                                 ; preds = %if.end762
  br i1 %cmp631.not, label %if.end868, label %if.then769

if.then769:                                       ; preds = %land.lhs.true766
  %add771 = or disjoint i32 %mul11.5, 15
  %cmp772 = icmp ult i32 %1, %add771
  br i1 %cmp772, label %for.cond774.preheader, label %if.end798

for.cond774.preheader:                            ; preds = %if.then769
  %125 = lshr i32 %18, 2
  %mul780 = and i32 %125, 252
  %add781 = add nuw nsw i32 %mul11.5, %mul780
  %cmp784.not = icmp sgt i32 %add781, %1
  %fneg.2413 = select i1 %cmp784.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3187 = insertelement <4 x float> poison, float %fneg.2413, i64 0
  %cmp784.not.1.not = icmp slt i32 %add781, %1
  %fneg.2413.1 = select i1 %cmp784.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3280 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3187, float %fneg.2413.1, i64 1
  %add782.2 = or disjoint i32 %add781, 2
  %cmp784.not.2 = icmp sgt i32 %add782.2, %1
  %fneg.2413.2 = select i1 %cmp784.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3373 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3280, float %fneg.2413.2, i64 2
  %add782.3 = or disjoint i32 %add781, 3
  %cmp784.not.3 = icmp sgt i32 %add782.3, %1
  %fneg.2413.3 = select i1 %cmp784.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3466 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3373, float %fneg.2413.3, i64 3
  br label %if.end798

if.end798:                                        ; preds = %if.then769, %for.cond774.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3466, %for.cond774.preheader ], [ zeroinitializer, %if.then769 ]
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !77
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %126), !call_argsrelate !77
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %127), !call_argsrelate !77
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %128), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3189 = extractelement <4 x float> %129, i64 0
  %mul833 = fmul contract float %acc_s.sroa.0.0.vec.extract3189, 0x3FB99999A0000000
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul833, float 0x4024CB5EC0000000)
  %131 = tail call contract noundef float @llvm.exp.f32(float %130)
  %acc_s.sroa.0.4.vec.extract3282 = extractelement <4 x float> %129, i64 1
  %mul833.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3282, 0x3FB99999A0000000
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul833.1, float 0x4024CB5EC0000000)
  %133 = tail call contract noundef float @llvm.exp.f32(float %132)
  %acc_s.sroa.0.8.vec.extract3375 = extractelement <4 x float> %129, i64 2
  %mul833.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3375, 0x3FB99999A0000000
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul833.2, float 0x4024CB5EC0000000)
  %135 = tail call contract noundef float @llvm.exp.f32(float %134)
  %acc_s.sroa.0.12.vec.extract3468 = extractelement <4 x float> %129, i64 3
  %mul833.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3468, 0x3FB99999A0000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul833.3, float 0x4024CB5EC0000000)
  %137 = tail call contract noundef float @llvm.exp.f32(float %136)
  %add849 = fadd contract float %sum_acc.sroa.0.4, %131
  %add849.1 = fadd contract float %sum_acc.sroa.20.4, %133
  %add849.2 = fadd contract float %sum_acc.sroa.38.4, %135
  %add849.3 = fadd contract float %sum_acc.sroa.56.4, %137
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131)
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133)
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135)
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137)
  br label %if.end868

if.end868:                                        ; preds = %if.end798, %land.lhs.true766, %if.end762
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true766 ], [ %add849.3, %if.end798 ], [ %sum_acc.sroa.56.4, %if.end762 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true766 ], [ %add849.2, %if.end798 ], [ %sum_acc.sroa.38.4, %if.end762 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true766 ], [ %add849.1, %if.end798 ], [ %sum_acc.sroa.20.4, %if.end762 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true766 ], [ %add849, %if.end798 ], [ %sum_acc.sroa.0.4, %if.end762 ]
  %phase_weights.sroa.48.0 = phi i16 [ undef, %land.lhs.true766 ], [ %141, %if.end798 ], [ undef, %if.end762 ]
  %phase_weights.sroa.46.0 = phi i16 [ undef, %land.lhs.true766 ], [ %140, %if.end798 ], [ undef, %if.end762 ]
  %phase_weights.sroa.44.0 = phi i16 [ undef, %land.lhs.true766 ], [ %139, %if.end798 ], [ undef, %if.end762 ]
  %phase_weights.sroa.42.0 = phi i16 [ undef, %land.lhs.true766 ], [ %138, %if.end798 ], [ undef, %if.end762 ]
  %or.cond2575 = icmp ugt i32 %mul11.6, 1023
  %cmp875.not = icmp sgt i32 %mul11.6, %1
  %or.cond2576 = or i1 %or.cond2575, %cmp875.not
  br i1 %or.cond2576, label %if.end900, label %for.cond877.preheader

for.cond877.preheader:                            ; preds = %if.end868
  %mul882 = shl nsw i32 %0, 16
  %142 = shl nsw i32 %cond.i.i2424.6, 10
  %mul884 = and i32 %142, 64512
  %mul889 = shl nuw nsw i32 %18, 3
  %add885 = or disjoint i32 %mul889, %mul882
  %add887 = add nuw nsw i32 %add885, %mul884
  %143 = zext nneg i32 %add887 to i64
  %add.ptr892 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143
  %K_reg.sroa.0.0.copyload3524 = load <4 x half>, ptr addrspace(4) %add.ptr892, align 16
  %K_reg.sroa.10.0.add.ptr892.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr892, i64 8
  %K_reg.sroa.10.0.copyload3527 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr892.sroa_idx, align 8
  %144 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143
  %add.ptr892.1 = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1024
  %K_reg.sroa.14.16.copyload3536 = load <4 x half>, ptr addrspace(4) %add.ptr892.1, align 16
  %K_reg.sroa.22.16.add.ptr892.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1032
  %K_reg.sroa.22.16.copyload3539 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr892.1.sroa_idx, align 8
  br label %if.end900

if.end900:                                        ; preds = %for.cond877.preheader, %if.end868
  %K_reg.sroa.22.3 = phi <4 x half> [ %K_reg.sroa.22.2, %if.end868 ], [ %K_reg.sroa.22.16.copyload3539, %for.cond877.preheader ]
  %K_reg.sroa.14.3 = phi <4 x half> [ %K_reg.sroa.14.2, %if.end868 ], [ %K_reg.sroa.14.16.copyload3536, %for.cond877.preheader ]
  %K_reg.sroa.10.3 = phi <4 x half> [ %K_reg.sroa.10.2, %if.end868 ], [ %K_reg.sroa.10.0.copyload3527, %for.cond877.preheader ]
  %K_reg.sroa.0.3 = phi <4 x half> [ %K_reg.sroa.0.2, %if.end868 ], [ %K_reg.sroa.0.0.copyload3524, %for.cond877.preheader ]
  %or.cond2577 = icmp ugt i32 %mul11.7, 1023
  %cmp907.not = icmp sgt i32 %mul11.7, %1
  %or.cond2578 = or i1 %or.cond2577, %cmp907.not
  br i1 %or.cond2578, label %if.end932, label %for.cond909.preheader

for.cond909.preheader:                            ; preds = %if.end900
  %mul914 = shl nsw i32 %0, 16
  %145 = shl nsw i32 %cond.i.i2424.7, 10
  %mul916 = and i32 %145, 64512
  %mul921 = shl nuw nsw i32 %18, 3
  %add917 = or disjoint i32 %mul921, %mul914
  %add919 = add nuw nsw i32 %add917, %mul916
  %146 = zext nneg i32 %add919 to i64
  %add.ptr924 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146
  %K_reg1.sroa.0.0.copyload3500 = load <4 x half>, ptr addrspace(4) %add.ptr924, align 16
  %K_reg1.sroa.10.0.add.ptr924.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr924, i64 8
  %K_reg1.sroa.10.0.copyload3503 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr924.sroa_idx, align 8
  %147 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146
  %add.ptr924.1 = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1024
  %K_reg1.sroa.14.16.copyload3512 = load <4 x half>, ptr addrspace(4) %add.ptr924.1, align 16
  %K_reg1.sroa.22.16.add.ptr924.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1032
  %K_reg1.sroa.22.16.copyload3515 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr924.1.sroa_idx, align 8
  br label %if.end932

if.end932:                                        ; preds = %for.cond909.preheader, %if.end900
  %K_reg1.sroa.22.3 = phi <4 x half> [ %K_reg1.sroa.22.2, %if.end900 ], [ %K_reg1.sroa.22.16.copyload3515, %for.cond909.preheader ]
  %K_reg1.sroa.14.3 = phi <4 x half> [ %K_reg1.sroa.14.2, %if.end900 ], [ %K_reg1.sroa.14.16.copyload3512, %for.cond909.preheader ]
  %K_reg1.sroa.10.3 = phi <4 x half> [ %K_reg1.sroa.10.2, %if.end900 ], [ %K_reg1.sroa.10.0.copyload3503, %for.cond909.preheader ]
  %K_reg1.sroa.0.3 = phi <4 x half> [ %K_reg1.sroa.0.2, %if.end900 ], [ %K_reg1.sroa.0.0.copyload3500, %for.cond909.preheader ]
  %or.cond2579 = icmp ult i32 %mul11.6, 1024
  br i1 %or.cond2579, label %land.lhs.true936, label %if.end1038

land.lhs.true936:                                 ; preds = %if.end932
  br i1 %cmp875.not, label %if.end1038, label %if.then939

if.then939:                                       ; preds = %land.lhs.true936
  %add941 = or disjoint i32 %mul11.6, 15
  %cmp942 = icmp ult i32 %1, %add941
  br i1 %cmp942, label %for.cond944.preheader, label %if.end968

for.cond944.preheader:                            ; preds = %if.then939
  %148 = lshr i32 %18, 2
  %mul950 = and i32 %148, 252
  %add951 = add nuw nsw i32 %mul11.6, %mul950
  %cmp954.not = icmp sgt i32 %add951, %1
  %fneg.2414 = select i1 %cmp954.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3197 = insertelement <4 x float> poison, float %fneg.2414, i64 0
  %cmp954.not.1.not = icmp slt i32 %add951, %1
  %fneg.2414.1 = select i1 %cmp954.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3290 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3197, float %fneg.2414.1, i64 1
  %add952.2 = or disjoint i32 %add951, 2
  %cmp954.not.2 = icmp sgt i32 %add952.2, %1
  %fneg.2414.2 = select i1 %cmp954.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3383 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3290, float %fneg.2414.2, i64 2
  %add952.3 = or disjoint i32 %add951, 3
  %cmp954.not.3 = icmp sgt i32 %add952.3, %1
  %fneg.2414.3 = select i1 %cmp954.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3476 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3383, float %fneg.2414.3, i64 3
  br label %if.end968

if.end968:                                        ; preds = %if.then939, %for.cond944.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3476, %for.cond944.preheader ], [ zeroinitializer, %if.then939 ]
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !77
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %149), !call_argsrelate !77
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %150), !call_argsrelate !77
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %151), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3199 = extractelement <4 x float> %152, i64 0
  %mul1003 = fmul contract float %acc_s.sroa.0.0.vec.extract3199, 0x3FB99999A0000000
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul1003, float 0x4024CB5EC0000000)
  %154 = tail call contract noundef float @llvm.exp.f32(float %153)
  %acc_s.sroa.0.4.vec.extract3292 = extractelement <4 x float> %152, i64 1
  %mul1003.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3292, 0x3FB99999A0000000
  %155 = tail call contract noundef float @llvm.minnum.f32(float %mul1003.1, float 0x4024CB5EC0000000)
  %156 = tail call contract noundef float @llvm.exp.f32(float %155)
  %acc_s.sroa.0.8.vec.extract3385 = extractelement <4 x float> %152, i64 2
  %mul1003.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3385, 0x3FB99999A0000000
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul1003.2, float 0x4024CB5EC0000000)
  %158 = tail call contract noundef float @llvm.exp.f32(float %157)
  %acc_s.sroa.0.12.vec.extract3478 = extractelement <4 x float> %152, i64 3
  %mul1003.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3478, 0x3FB99999A0000000
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul1003.3, float 0x4024CB5EC0000000)
  %160 = tail call contract noundef float @llvm.exp.f32(float %159)
  %add1019 = fadd contract float %sum_acc.sroa.0.5, %154
  %add1019.1 = fadd contract float %sum_acc.sroa.20.5, %156
  %add1019.2 = fadd contract float %sum_acc.sroa.38.5, %158
  %add1019.3 = fadd contract float %sum_acc.sroa.56.5, %160
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154)
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %156)
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158)
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160)
  br label %if.end1038

if.end1038:                                       ; preds = %if.end968, %land.lhs.true936, %if.end932
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true936 ], [ %add1019.3, %if.end968 ], [ %sum_acc.sroa.56.5, %if.end932 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true936 ], [ %add1019.2, %if.end968 ], [ %sum_acc.sroa.38.5, %if.end932 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true936 ], [ %add1019.1, %if.end968 ], [ %sum_acc.sroa.20.5, %if.end932 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true936 ], [ %add1019, %if.end968 ], [ %sum_acc.sroa.0.5, %if.end932 ]
  %phase_weights.sroa.56.0 = phi i16 [ undef, %land.lhs.true936 ], [ %164, %if.end968 ], [ undef, %if.end932 ]
  %phase_weights.sroa.54.0 = phi i16 [ undef, %land.lhs.true936 ], [ %163, %if.end968 ], [ undef, %if.end932 ]
  %phase_weights.sroa.52.0 = phi i16 [ undef, %land.lhs.true936 ], [ %162, %if.end968 ], [ undef, %if.end932 ]
  %phase_weights.sroa.50.0 = phi i16 [ undef, %land.lhs.true936 ], [ %161, %if.end968 ], [ undef, %if.end932 ]
  %or.cond2580 = icmp ult i32 %mul11.7, 1024
  br i1 %or.cond2580, label %land.lhs.true1042, label %if.end1144

land.lhs.true1042:                                ; preds = %if.end1038
  br i1 %cmp907.not, label %if.end1144, label %if.then1045

if.then1045:                                      ; preds = %land.lhs.true1042
  %add1047 = or disjoint i32 %mul11.7, 15
  %cmp1048 = icmp slt i32 %1, %add1047
  br i1 %cmp1048, label %for.cond1050.preheader, label %if.end1074

for.cond1050.preheader:                           ; preds = %if.then1045
  %165 = lshr i32 %18, 2
  %mul1056 = and i32 %165, 252
  %add1057 = add nuw nsw i32 %mul11.7, %mul1056
  %cmp1060.not = icmp sgt i32 %add1057, %1
  %fneg.2415 = select i1 %cmp1060.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3207 = insertelement <4 x float> poison, float %fneg.2415, i64 0
  %cmp1060.not.1.not = icmp slt i32 %add1057, %1
  %fneg.2415.1 = select i1 %cmp1060.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3300 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3207, float %fneg.2415.1, i64 1
  %add1058.2 = or disjoint i32 %add1057, 2
  %cmp1060.not.2 = icmp sgt i32 %add1058.2, %1
  %fneg.2415.2 = select i1 %cmp1060.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3393 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3300, float %fneg.2415.2, i64 2
  %add1058.3 = or disjoint i32 %add1057, 3
  %cmp1060.not.3 = icmp sgt i32 %add1058.3, %1
  %fneg.2415.3 = select i1 %cmp1060.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3486 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3393, float %fneg.2415.3, i64 3
  br label %if.end1074

if.end1074:                                       ; preds = %if.then1045, %for.cond1050.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3486, %for.cond1050.preheader ], [ zeroinitializer, %if.then1045 ]
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !77
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %166), !call_argsrelate !77
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %167), !call_argsrelate !77
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %168), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3209 = extractelement <4 x float> %169, i64 0
  %mul1109 = fmul contract float %acc_s.sroa.0.0.vec.extract3209, 0x3FB99999A0000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul1109, float 0x4024CB5EC0000000)
  %171 = tail call contract noundef float @llvm.exp.f32(float %170)
  %acc_s.sroa.0.4.vec.extract3302 = extractelement <4 x float> %169, i64 1
  %mul1109.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3302, 0x3FB99999A0000000
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul1109.1, float 0x4024CB5EC0000000)
  %173 = tail call contract noundef float @llvm.exp.f32(float %172)
  %acc_s.sroa.0.8.vec.extract3395 = extractelement <4 x float> %169, i64 2
  %mul1109.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3395, 0x3FB99999A0000000
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul1109.2, float 0x4024CB5EC0000000)
  %175 = tail call contract noundef float @llvm.exp.f32(float %174)
  %acc_s.sroa.0.12.vec.extract3488 = extractelement <4 x float> %169, i64 3
  %mul1109.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3488, 0x3FB99999A0000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul1109.3, float 0x4024CB5EC0000000)
  %177 = tail call contract noundef float @llvm.exp.f32(float %176)
  %add1125 = fadd contract float %sum_acc.sroa.0.6, %171
  %add1125.1 = fadd contract float %sum_acc.sroa.20.6, %173
  %add1125.2 = fadd contract float %sum_acc.sroa.38.6, %175
  %add1125.3 = fadd contract float %sum_acc.sroa.56.6, %177
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171)
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %173)
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175)
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177)
  br label %if.end1144

if.end1144:                                       ; preds = %if.end1074, %land.lhs.true1042, %if.end1038
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1042 ], [ %add1125.3, %if.end1074 ], [ %sum_acc.sroa.56.6, %if.end1038 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1042 ], [ %add1125.2, %if.end1074 ], [ %sum_acc.sroa.38.6, %if.end1038 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1042 ], [ %add1125.1, %if.end1074 ], [ %sum_acc.sroa.20.6, %if.end1038 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1042 ], [ %add1125, %if.end1074 ], [ %sum_acc.sroa.0.6, %if.end1038 ]
  %phase_weights.sroa.64.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %181, %if.end1074 ], [ undef, %if.end1038 ]
  %phase_weights.sroa.62.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %180, %if.end1074 ], [ undef, %if.end1038 ]
  %phase_weights.sroa.60.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %179, %if.end1074 ], [ undef, %if.end1038 ]
  %phase_weights.sroa.58.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %178, %if.end1074 ], [ undef, %if.end1038 ]
  br i1 %or.cond2558, label %if.end1228, label %for.cond1205.preheader

for.cond1205.preheader:                           ; preds = %if.end1144
  %mul1210 = shl nsw i32 %0, 16
  %182 = shl nsw i32 %cond.i.i2424, 10
  %mul1212 = and i32 %182, 64512
  %mul1217 = shl nuw nsw i32 %18, 3
  %add1213 = or disjoint i32 %mul1217, %mul1210
  %add1215 = add nuw nsw i32 %add1213, %mul1212
  %183 = zext nneg i32 %add1215 to i64
  %add.ptr1220 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1220, align 16
  %V_reg.sroa.10.0.add.ptr1220.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1220, i64 8
  %V_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1220.sroa_idx, align 8
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %add.ptr1220.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024
  %V_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1220.1, align 16
  %V_reg.sroa.22.16.add.ptr1220.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032
  %V_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1220.1.sroa_idx, align 8
  br label %if.end1228

if.end1228:                                       ; preds = %for.cond1205.preheader, %if.end1144
  %V_reg.sroa.22.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.22.16.copyload, %for.cond1205.preheader ]
  %V_reg.sroa.14.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.14.16.copyload, %for.cond1205.preheader ]
  %V_reg.sroa.10.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.10.0.copyload, %for.cond1205.preheader ]
  %V_reg.sroa.0.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.0.0.copyload, %for.cond1205.preheader ]
  br i1 %or.cond2560, label %if.end1260, label %for.cond1237.preheader

for.cond1237.preheader:                           ; preds = %if.end1228
  %mul1242 = shl nsw i32 %0, 16
  %185 = shl nsw i32 %cond.i.i2424.1, 10
  %mul1244 = and i32 %185, 64512
  %mul1249 = shl nuw nsw i32 %18, 3
  %add1245 = or disjoint i32 %mul1249, %mul1242
  %add1247 = add nuw nsw i32 %add1245, %mul1244
  %186 = zext nneg i32 %add1247 to i64
  %add.ptr1252 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186
  %phase_v1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1252, align 16
  %phase_v1.sroa.10.0.add.ptr1252.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1252, i64 8
  %phase_v1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1252.sroa_idx, align 8
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186
  %add.ptr1252.1 = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1024
  %phase_v1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1252.1, align 16
  %phase_v1.sroa.22.16.add.ptr1252.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1032
  %phase_v1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1252.1.sroa_idx, align 8
  br label %if.end1260

if.end1260:                                       ; preds = %for.cond1237.preheader, %if.end1228
  %phase_v1.sroa.22.0 = phi <4 x half> [ undef, %if.end1228 ], [ %phase_v1.sroa.22.16.copyload, %for.cond1237.preheader ]
  %phase_v1.sroa.14.0 = phi <4 x half> [ undef, %if.end1228 ], [ %phase_v1.sroa.14.16.copyload, %for.cond1237.preheader ]
  %phase_v1.sroa.10.0 = phi <4 x half> [ undef, %if.end1228 ], [ %phase_v1.sroa.10.0.copyload, %for.cond1237.preheader ]
  %phase_v1.sroa.0.0 = phi <4 x half> [ undef, %if.end1228 ], [ %phase_v1.sroa.0.0.copyload, %for.cond1237.preheader ]
  br i1 %or.cond2558, label %if.end1297, label %for.body1271.preheader

for.body1271.preheader:                           ; preds = %if.end1260
  %188 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.0.0, i64 0
  %189 = insertelement <4 x i16> %188, i16 %phase_weights.sroa.4.0, i64 1
  %190 = insertelement <4 x i16> %189, i16 %phase_weights.sroa.6.0, i64 2
  %191 = insertelement <4 x i16> %190, i16 %phase_weights.sroa.8.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %191 to <4 x half>
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end1297

if.end1297:                                       ; preds = %for.body1271.preheader, %if.end1260
  %acc_o.sroa.110.0 = phi <4 x float> [ zeroinitializer, %if.end1260 ], [ %195, %for.body1271.preheader ]
  %acc_o.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1260 ], [ %194, %for.body1271.preheader ]
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1260 ], [ %193, %for.body1271.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1260 ], [ %192, %for.body1271.preheader ]
  br i1 %or.cond2560, label %if.end1335, label %for.body1308.preheader

for.body1308.preheader:                           ; preds = %if.end1297
  %196 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.10.0, i64 0
  %197 = insertelement <4 x i16> %196, i16 %phase_weights.sroa.12.0, i64 1
  %198 = insertelement <4 x i16> %197, i16 %phase_weights.sroa.14.0, i64 2
  %199 = insertelement <4 x i16> %198, i16 %phase_weights.sroa.16.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2766 = bitcast <4 x i16> %199 to <4 x half>
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2766, <4 x float> zeroinitializer)
  %201 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2766, <4 x float> zeroinitializer)
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2766, <4 x float> zeroinitializer)
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2766, <4 x float> zeroinitializer)
  br label %if.end1335

if.end1335:                                       ; preds = %for.body1308.preheader, %if.end1297
  %acc_o_1.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1297 ], [ %203, %for.body1308.preheader ]
  %acc_o_1.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1297 ], [ %202, %for.body1308.preheader ]
  %acc_o_1.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1297 ], [ %201, %for.body1308.preheader ]
  %acc_o_1.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1297 ], [ %200, %for.body1308.preheader ]
  br i1 %or.cond2564, label %if.end1367, label %for.cond1344.preheader

for.cond1344.preheader:                           ; preds = %if.end1335
  %mul1349 = shl nsw i32 %0, 16
  %204 = shl nsw i32 %cond.i.i2424.2, 10
  %mul1351 = and i32 %204, 64512
  %mul1356 = shl nuw nsw i32 %18, 3
  %add1352 = or disjoint i32 %mul1356, %mul1349
  %add1354 = add nuw nsw i32 %add1352, %mul1351
  %205 = zext nneg i32 %add1354 to i64
  %add.ptr1359 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %205
  %V_reg.sroa.0.0.copyload2806 = load <4 x half>, ptr addrspace(4) %add.ptr1359, align 16
  %V_reg.sroa.10.0.add.ptr1359.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1359, i64 8
  %V_reg.sroa.10.0.copyload2809 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1359.sroa_idx, align 8
  %206 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %205
  %add.ptr1359.1 = getelementptr inbounds i8, ptr addrspace(4) %206, i64 1024
  %V_reg.sroa.14.16.copyload2818 = load <4 x half>, ptr addrspace(4) %add.ptr1359.1, align 16
  %V_reg.sroa.22.16.add.ptr1359.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %206, i64 1032
  %V_reg.sroa.22.16.copyload2821 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1359.1.sroa_idx, align 8
  br label %if.end1367

if.end1367:                                       ; preds = %for.cond1344.preheader, %if.end1335
  %V_reg.sroa.22.1 = phi <4 x half> [ %V_reg.sroa.22.0, %if.end1335 ], [ %V_reg.sroa.22.16.copyload2821, %for.cond1344.preheader ]
  %V_reg.sroa.14.1 = phi <4 x half> [ %V_reg.sroa.14.0, %if.end1335 ], [ %V_reg.sroa.14.16.copyload2818, %for.cond1344.preheader ]
  %V_reg.sroa.10.1 = phi <4 x half> [ %V_reg.sroa.10.0, %if.end1335 ], [ %V_reg.sroa.10.0.copyload2809, %for.cond1344.preheader ]
  %V_reg.sroa.0.1 = phi <4 x half> [ %V_reg.sroa.0.0, %if.end1335 ], [ %V_reg.sroa.0.0.copyload2806, %for.cond1344.preheader ]
  br i1 %or.cond2566, label %if.end1399, label %for.cond1376.preheader

for.cond1376.preheader:                           ; preds = %if.end1367
  %mul1381 = shl nsw i32 %0, 16
  %207 = shl nsw i32 %cond.i.i2424.3, 10
  %mul1383 = and i32 %207, 64512
  %mul1388 = shl nuw nsw i32 %18, 3
  %add1384 = or disjoint i32 %mul1388, %mul1381
  %add1386 = add nuw nsw i32 %add1384, %mul1383
  %208 = zext nneg i32 %add1386 to i64
  %add.ptr1391 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %208
  %phase_v1.sroa.0.0.copyload2782 = load <4 x half>, ptr addrspace(4) %add.ptr1391, align 16
  %phase_v1.sroa.10.0.add.ptr1391.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1391, i64 8
  %phase_v1.sroa.10.0.copyload2785 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1391.sroa_idx, align 8
  %209 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %208
  %add.ptr1391.1 = getelementptr inbounds i8, ptr addrspace(4) %209, i64 1024
  %phase_v1.sroa.14.16.copyload2794 = load <4 x half>, ptr addrspace(4) %add.ptr1391.1, align 16
  %phase_v1.sroa.22.16.add.ptr1391.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %209, i64 1032
  %phase_v1.sroa.22.16.copyload2797 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1391.1.sroa_idx, align 8
  br label %if.end1399

if.end1399:                                       ; preds = %for.cond1376.preheader, %if.end1367
  %phase_v1.sroa.22.1 = phi <4 x half> [ %phase_v1.sroa.22.0, %if.end1367 ], [ %phase_v1.sroa.22.16.copyload2797, %for.cond1376.preheader ]
  %phase_v1.sroa.14.1 = phi <4 x half> [ %phase_v1.sroa.14.0, %if.end1367 ], [ %phase_v1.sroa.14.16.copyload2794, %for.cond1376.preheader ]
  %phase_v1.sroa.10.1 = phi <4 x half> [ %phase_v1.sroa.10.0, %if.end1367 ], [ %phase_v1.sroa.10.0.copyload2785, %for.cond1376.preheader ]
  %phase_v1.sroa.0.1 = phi <4 x half> [ %phase_v1.sroa.0.0, %if.end1367 ], [ %phase_v1.sroa.0.0.copyload2782, %for.cond1376.preheader ]
  br i1 %or.cond2564, label %if.end1437, label %for.body1410.preheader

for.body1410.preheader:                           ; preds = %if.end1399
  %210 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.18.0, i64 0
  %211 = insertelement <4 x i16> %210, i16 %phase_weights.sroa.20.0, i64 1
  %212 = insertelement <4 x i16> %211, i16 %phase_weights.sroa.22.0, i64 2
  %213 = insertelement <4 x i16> %212, i16 %phase_weights.sroa.24.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2768 = bitcast <4 x i16> %213 to <4 x half>
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2768, <4 x float> zeroinitializer)
  br label %if.end1437

if.end1437:                                       ; preds = %for.body1410.preheader, %if.end1399
  %acc_o_2.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1399 ], [ %217, %for.body1410.preheader ]
  %acc_o_2.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1399 ], [ %216, %for.body1410.preheader ]
  %acc_o_2.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1399 ], [ %215, %for.body1410.preheader ]
  %acc_o_2.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1399 ], [ %214, %for.body1410.preheader ]
  br i1 %or.cond2566, label %if.end1475, label %for.body1448.preheader

for.body1448.preheader:                           ; preds = %if.end1437
  %218 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.26.0, i64 0
  %219 = insertelement <4 x i16> %218, i16 %phase_weights.sroa.28.0, i64 1
  %220 = insertelement <4 x i16> %219, i16 %phase_weights.sroa.30.0, i64 2
  %221 = insertelement <4 x i16> %220, i16 %phase_weights.sroa.32.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2770 = bitcast <4 x i16> %221 to <4 x half>
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2770, <4 x float> zeroinitializer)
  br label %if.end1475

if.end1475:                                       ; preds = %for.body1448.preheader, %if.end1437
  %acc_o_3.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1437 ], [ %225, %for.body1448.preheader ]
  %acc_o_3.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1437 ], [ %224, %for.body1448.preheader ]
  %acc_o_3.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1437 ], [ %223, %for.body1448.preheader ]
  %acc_o_3.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1437 ], [ %222, %for.body1448.preheader ]
  br i1 %or.cond2570, label %if.end1507, label %for.cond1484.preheader

for.cond1484.preheader:                           ; preds = %if.end1475
  %mul1489 = shl nsw i32 %0, 16
  %226 = shl nsw i32 %cond.i.i2424.4, 10
  %mul1491 = and i32 %226, 64512
  %mul1496 = shl nuw nsw i32 %18, 3
  %add1492 = or disjoint i32 %mul1496, %mul1489
  %add1494 = add nuw nsw i32 %add1492, %mul1491
  %227 = zext nneg i32 %add1494 to i64
  %add.ptr1499 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %227
  %V_reg.sroa.0.0.copyload2807 = load <4 x half>, ptr addrspace(4) %add.ptr1499, align 16
  %V_reg.sroa.10.0.add.ptr1499.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1499, i64 8
  %V_reg.sroa.10.0.copyload2810 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1499.sroa_idx, align 8
  %228 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %227
  %add.ptr1499.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1024
  %V_reg.sroa.14.16.copyload2819 = load <4 x half>, ptr addrspace(4) %add.ptr1499.1, align 16
  %V_reg.sroa.22.16.add.ptr1499.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1032
  %V_reg.sroa.22.16.copyload2822 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1499.1.sroa_idx, align 8
  br label %if.end1507

if.end1507:                                       ; preds = %for.cond1484.preheader, %if.end1475
  %V_reg.sroa.22.2 = phi <4 x half> [ %V_reg.sroa.22.1, %if.end1475 ], [ %V_reg.sroa.22.16.copyload2822, %for.cond1484.preheader ]
  %V_reg.sroa.14.2 = phi <4 x half> [ %V_reg.sroa.14.1, %if.end1475 ], [ %V_reg.sroa.14.16.copyload2819, %for.cond1484.preheader ]
  %V_reg.sroa.10.2 = phi <4 x half> [ %V_reg.sroa.10.1, %if.end1475 ], [ %V_reg.sroa.10.0.copyload2810, %for.cond1484.preheader ]
  %V_reg.sroa.0.2 = phi <4 x half> [ %V_reg.sroa.0.1, %if.end1475 ], [ %V_reg.sroa.0.0.copyload2807, %for.cond1484.preheader ]
  br i1 %or.cond2572, label %if.end1539, label %for.cond1516.preheader

for.cond1516.preheader:                           ; preds = %if.end1507
  %mul1521 = shl nsw i32 %0, 16
  %229 = shl nsw i32 %cond.i.i2424.5, 10
  %mul1523 = and i32 %229, 64512
  %mul1528 = shl nuw nsw i32 %18, 3
  %add1524 = or disjoint i32 %mul1528, %mul1521
  %add1526 = add nuw nsw i32 %add1524, %mul1523
  %230 = zext nneg i32 %add1526 to i64
  %add.ptr1531 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230
  %phase_v1.sroa.0.0.copyload2783 = load <4 x half>, ptr addrspace(4) %add.ptr1531, align 16
  %phase_v1.sroa.10.0.add.ptr1531.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1531, i64 8
  %phase_v1.sroa.10.0.copyload2786 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1531.sroa_idx, align 8
  %231 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230
  %add.ptr1531.1 = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1024
  %phase_v1.sroa.14.16.copyload2795 = load <4 x half>, ptr addrspace(4) %add.ptr1531.1, align 16
  %phase_v1.sroa.22.16.add.ptr1531.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1032
  %phase_v1.sroa.22.16.copyload2798 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1531.1.sroa_idx, align 8
  br label %if.end1539

if.end1539:                                       ; preds = %for.cond1516.preheader, %if.end1507
  %phase_v1.sroa.22.2 = phi <4 x half> [ %phase_v1.sroa.22.1, %if.end1507 ], [ %phase_v1.sroa.22.16.copyload2798, %for.cond1516.preheader ]
  %phase_v1.sroa.14.2 = phi <4 x half> [ %phase_v1.sroa.14.1, %if.end1507 ], [ %phase_v1.sroa.14.16.copyload2795, %for.cond1516.preheader ]
  %phase_v1.sroa.10.2 = phi <4 x half> [ %phase_v1.sroa.10.1, %if.end1507 ], [ %phase_v1.sroa.10.0.copyload2786, %for.cond1516.preheader ]
  %phase_v1.sroa.0.2 = phi <4 x half> [ %phase_v1.sroa.0.1, %if.end1507 ], [ %phase_v1.sroa.0.0.copyload2783, %for.cond1516.preheader ]
  br i1 %or.cond2570, label %if.end1577, label %for.body1550.preheader

for.body1550.preheader:                           ; preds = %if.end1539
  %232 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.34.0, i64 0
  %233 = insertelement <4 x i16> %232, i16 %phase_weights.sroa.36.0, i64 1
  %234 = insertelement <4 x i16> %233, i16 %phase_weights.sroa.38.0, i64 2
  %235 = insertelement <4 x i16> %234, i16 %phase_weights.sroa.40.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2772 = bitcast <4 x i16> %235 to <4 x half>
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> %acc_o.sroa.0.0)
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> %acc_o.sroa.38.0)
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> %acc_o.sroa.74.0)
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2772, <4 x float> %acc_o.sroa.110.0)
  br label %if.end1577

if.end1577:                                       ; preds = %for.body1550.preheader, %if.end1539
  %acc_o.sroa.110.1 = phi <4 x float> [ %acc_o.sroa.110.0, %if.end1539 ], [ %239, %for.body1550.preheader ]
  %acc_o.sroa.74.1 = phi <4 x float> [ %acc_o.sroa.74.0, %if.end1539 ], [ %238, %for.body1550.preheader ]
  %acc_o.sroa.38.1 = phi <4 x float> [ %acc_o.sroa.38.0, %if.end1539 ], [ %237, %for.body1550.preheader ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1539 ], [ %236, %for.body1550.preheader ]
  br i1 %or.cond2572, label %if.end1615, label %for.body1588.preheader

for.body1588.preheader:                           ; preds = %if.end1577
  %240 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.42.0, i64 0
  %241 = insertelement <4 x i16> %240, i16 %phase_weights.sroa.44.0, i64 1
  %242 = insertelement <4 x i16> %241, i16 %phase_weights.sroa.46.0, i64 2
  %243 = insertelement <4 x i16> %242, i16 %phase_weights.sroa.48.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2774 = bitcast <4 x i16> %243 to <4 x half>
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o_1.sroa.0.0)
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o_1.sroa.14.0)
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o_1.sroa.26.0)
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2774, <4 x float> %acc_o_1.sroa.38.0)
  br label %if.end1615

if.end1615:                                       ; preds = %for.body1588.preheader, %if.end1577
  %acc_o_1.sroa.38.1 = phi <4 x float> [ %acc_o_1.sroa.38.0, %if.end1577 ], [ %247, %for.body1588.preheader ]
  %acc_o_1.sroa.26.1 = phi <4 x float> [ %acc_o_1.sroa.26.0, %if.end1577 ], [ %246, %for.body1588.preheader ]
  %acc_o_1.sroa.14.1 = phi <4 x float> [ %acc_o_1.sroa.14.0, %if.end1577 ], [ %245, %for.body1588.preheader ]
  %acc_o_1.sroa.0.1 = phi <4 x float> [ %acc_o_1.sroa.0.0, %if.end1577 ], [ %244, %for.body1588.preheader ]
  br i1 %or.cond2576, label %if.end1647, label %for.cond1624.preheader

for.cond1624.preheader:                           ; preds = %if.end1615
  %mul1629 = shl nsw i32 %0, 16
  %248 = shl nsw i32 %cond.i.i2424.6, 10
  %mul1631 = and i32 %248, 64512
  %mul1636 = shl nuw nsw i32 %18, 3
  %add1632 = or disjoint i32 %mul1636, %mul1629
  %add1634 = add nuw nsw i32 %add1632, %mul1631
  %249 = zext nneg i32 %add1634 to i64
  %add.ptr1639 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %249
  %V_reg.sroa.0.0.copyload2808 = load <4 x half>, ptr addrspace(4) %add.ptr1639, align 16
  %V_reg.sroa.10.0.add.ptr1639.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1639, i64 8
  %V_reg.sroa.10.0.copyload2811 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1639.sroa_idx, align 8
  %250 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %249
  %add.ptr1639.1 = getelementptr inbounds i8, ptr addrspace(4) %250, i64 1024
  %V_reg.sroa.14.16.copyload2820 = load <4 x half>, ptr addrspace(4) %add.ptr1639.1, align 16
  %V_reg.sroa.22.16.add.ptr1639.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %250, i64 1032
  %V_reg.sroa.22.16.copyload2823 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1639.1.sroa_idx, align 8
  br label %if.end1647

if.end1647:                                       ; preds = %for.cond1624.preheader, %if.end1615
  %V_reg.sroa.22.3 = phi <4 x half> [ %V_reg.sroa.22.2, %if.end1615 ], [ %V_reg.sroa.22.16.copyload2823, %for.cond1624.preheader ]
  %V_reg.sroa.14.3 = phi <4 x half> [ %V_reg.sroa.14.2, %if.end1615 ], [ %V_reg.sroa.14.16.copyload2820, %for.cond1624.preheader ]
  %V_reg.sroa.10.3 = phi <4 x half> [ %V_reg.sroa.10.2, %if.end1615 ], [ %V_reg.sroa.10.0.copyload2811, %for.cond1624.preheader ]
  %V_reg.sroa.0.3 = phi <4 x half> [ %V_reg.sroa.0.2, %if.end1615 ], [ %V_reg.sroa.0.0.copyload2808, %for.cond1624.preheader ]
  br i1 %or.cond2578, label %if.end1679, label %for.cond1656.preheader

for.cond1656.preheader:                           ; preds = %if.end1647
  %mul1661 = shl nsw i32 %0, 16
  %251 = shl nsw i32 %cond.i.i2424.7, 10
  %mul1663 = and i32 %251, 64512
  %mul1668 = shl nuw nsw i32 %18, 3
  %add1664 = or disjoint i32 %mul1668, %mul1661
  %add1666 = add nuw nsw i32 %add1664, %mul1663
  %252 = zext nneg i32 %add1666 to i64
  %add.ptr1671 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252
  %phase_v1.sroa.0.0.copyload2784 = load <4 x half>, ptr addrspace(4) %add.ptr1671, align 16
  %phase_v1.sroa.10.0.add.ptr1671.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1671, i64 8
  %phase_v1.sroa.10.0.copyload2787 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1671.sroa_idx, align 8
  %253 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252
  %add.ptr1671.1 = getelementptr inbounds i8, ptr addrspace(4) %253, i64 1024
  %phase_v1.sroa.14.16.copyload2796 = load <4 x half>, ptr addrspace(4) %add.ptr1671.1, align 16
  %phase_v1.sroa.22.16.add.ptr1671.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %253, i64 1032
  %phase_v1.sroa.22.16.copyload2799 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1671.1.sroa_idx, align 8
  br label %if.end1679

if.end1679:                                       ; preds = %for.cond1656.preheader, %if.end1647
  %phase_v1.sroa.22.3 = phi <4 x half> [ %phase_v1.sroa.22.2, %if.end1647 ], [ %phase_v1.sroa.22.16.copyload2799, %for.cond1656.preheader ]
  %phase_v1.sroa.14.3 = phi <4 x half> [ %phase_v1.sroa.14.2, %if.end1647 ], [ %phase_v1.sroa.14.16.copyload2796, %for.cond1656.preheader ]
  %phase_v1.sroa.10.3 = phi <4 x half> [ %phase_v1.sroa.10.2, %if.end1647 ], [ %phase_v1.sroa.10.0.copyload2787, %for.cond1656.preheader ]
  %phase_v1.sroa.0.3 = phi <4 x half> [ %phase_v1.sroa.0.2, %if.end1647 ], [ %phase_v1.sroa.0.0.copyload2784, %for.cond1656.preheader ]
  br i1 %or.cond2576, label %if.end1717, label %for.body1690.preheader

for.body1690.preheader:                           ; preds = %if.end1679
  %254 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.50.0, i64 0
  %255 = insertelement <4 x i16> %254, i16 %phase_weights.sroa.52.0, i64 1
  %256 = insertelement <4 x i16> %255, i16 %phase_weights.sroa.54.0, i64 2
  %257 = insertelement <4 x i16> %256, i16 %phase_weights.sroa.56.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2776 = bitcast <4 x i16> %257 to <4 x half>
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_2.sroa.0.0)
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_2.sroa.14.0)
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_2.sroa.26.0)
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2776, <4 x float> %acc_o_2.sroa.38.0)
  br label %if.end1717

if.end1717:                                       ; preds = %for.body1690.preheader, %if.end1679
  %acc_o_2.sroa.38.1 = phi <4 x float> [ %acc_o_2.sroa.38.0, %if.end1679 ], [ %261, %for.body1690.preheader ]
  %acc_o_2.sroa.26.1 = phi <4 x float> [ %acc_o_2.sroa.26.0, %if.end1679 ], [ %260, %for.body1690.preheader ]
  %acc_o_2.sroa.14.1 = phi <4 x float> [ %acc_o_2.sroa.14.0, %if.end1679 ], [ %259, %for.body1690.preheader ]
  %acc_o_2.sroa.0.1 = phi <4 x float> [ %acc_o_2.sroa.0.0, %if.end1679 ], [ %258, %for.body1690.preheader ]
  br i1 %or.cond2578, label %if.end1755, label %for.body1728.preheader

for.body1728.preheader:                           ; preds = %if.end1717
  %262 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.58.0, i64 0
  %263 = insertelement <4 x i16> %262, i16 %phase_weights.sroa.60.0, i64 1
  %264 = insertelement <4 x i16> %263, i16 %phase_weights.sroa.62.0, i64 2
  %265 = insertelement <4 x i16> %264, i16 %phase_weights.sroa.64.0, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2778 = bitcast <4 x i16> %265 to <4 x half>
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_3.sroa.0.0)
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_3.sroa.14.0)
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_3.sroa.26.0)
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2778, <4 x float> %acc_o_3.sroa.38.0)
  br label %if.end1755

if.end1755:                                       ; preds = %for.body1728.preheader, %if.end1717
  %acc_o_3.sroa.38.1 = phi <4 x float> [ %acc_o_3.sroa.38.0, %if.end1717 ], [ %269, %for.body1728.preheader ]
  %acc_o_3.sroa.26.1 = phi <4 x float> [ %acc_o_3.sroa.26.0, %if.end1717 ], [ %268, %for.body1728.preheader ]
  %acc_o_3.sroa.14.1 = phi <4 x float> [ %acc_o_3.sroa.14.0, %if.end1717 ], [ %267, %for.body1728.preheader ]
  %acc_o_3.sroa.0.1 = phi <4 x float> [ %acc_o_3.sroa.0.0, %if.end1717 ], [ %266, %for.body1728.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0
  %acc_o_1.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 0
  %add1764 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_1.sroa.0.0.vec.extract
  %acc_o_2.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 0
  %add1771 = fadd contract float %add1764, %acc_o_2.sroa.0.0.vec.extract
  %acc_o_3.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 0
  %add1778 = fadd contract float %add1771, %acc_o_3.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1
  %acc_o_1.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 1
  %add1764.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_1.sroa.0.4.vec.extract
  %acc_o_2.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 1
  %add1771.1 = fadd contract float %add1764.1, %acc_o_2.sroa.0.4.vec.extract
  %acc_o_3.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 1
  %add1778.1 = fadd contract float %add1771.1, %acc_o_3.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2
  %acc_o_1.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 2
  %add1764.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_1.sroa.0.8.vec.extract
  %acc_o_2.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 2
  %add1771.2 = fadd contract float %add1764.2, %acc_o_2.sroa.0.8.vec.extract
  %acc_o_3.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 2
  %add1778.2 = fadd contract float %add1771.2, %acc_o_3.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3
  %acc_o_1.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 3
  %add1764.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_1.sroa.0.12.vec.extract
  %acc_o_2.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 3
  %add1771.3 = fadd contract float %add1764.3, %acc_o_2.sroa.0.12.vec.extract
  %acc_o_3.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 3
  %add1778.3 = fadd contract float %add1771.3, %acc_o_3.sroa.0.12.vec.extract
  %acc_o.sroa.38.16.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 0
  %acc_o_1.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 0
  %add1764.4 = fadd contract float %acc_o.sroa.38.16.vec.extract, %acc_o_1.sroa.14.16.vec.extract
  %acc_o_2.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 0
  %add1771.4 = fadd contract float %add1764.4, %acc_o_2.sroa.14.16.vec.extract
  %acc_o_3.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 0
  %add1778.4 = fadd contract float %add1771.4, %acc_o_3.sroa.14.16.vec.extract
  %acc_o.sroa.38.20.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 1
  %acc_o_1.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 1
  %add1764.5 = fadd contract float %acc_o.sroa.38.20.vec.extract, %acc_o_1.sroa.14.20.vec.extract
  %acc_o_2.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 1
  %add1771.5 = fadd contract float %add1764.5, %acc_o_2.sroa.14.20.vec.extract
  %acc_o_3.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 1
  %add1778.5 = fadd contract float %add1771.5, %acc_o_3.sroa.14.20.vec.extract
  %acc_o.sroa.38.24.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 2
  %acc_o_1.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 2
  %add1764.6 = fadd contract float %acc_o.sroa.38.24.vec.extract, %acc_o_1.sroa.14.24.vec.extract
  %acc_o_2.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 2
  %add1771.6 = fadd contract float %add1764.6, %acc_o_2.sroa.14.24.vec.extract
  %acc_o_3.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 2
  %add1778.6 = fadd contract float %add1771.6, %acc_o_3.sroa.14.24.vec.extract
  %acc_o.sroa.38.28.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 3
  %acc_o_1.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 3
  %add1764.7 = fadd contract float %acc_o.sroa.38.28.vec.extract, %acc_o_1.sroa.14.28.vec.extract
  %acc_o_2.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 3
  %add1771.7 = fadd contract float %add1764.7, %acc_o_2.sroa.14.28.vec.extract
  %acc_o_3.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 3
  %add1778.7 = fadd contract float %add1771.7, %acc_o_3.sroa.14.28.vec.extract
  %acc_o.sroa.74.32.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 0
  %acc_o_1.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 0
  %add1764.8 = fadd contract float %acc_o.sroa.74.32.vec.extract, %acc_o_1.sroa.26.32.vec.extract
  %acc_o_2.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 0
  %add1771.8 = fadd contract float %add1764.8, %acc_o_2.sroa.26.32.vec.extract
  %acc_o_3.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 0
  %add1778.8 = fadd contract float %add1771.8, %acc_o_3.sroa.26.32.vec.extract
  %acc_o.sroa.74.36.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 1
  %acc_o_1.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 1
  %add1764.9 = fadd contract float %acc_o.sroa.74.36.vec.extract, %acc_o_1.sroa.26.36.vec.extract
  %acc_o_2.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 1
  %add1771.9 = fadd contract float %add1764.9, %acc_o_2.sroa.26.36.vec.extract
  %acc_o_3.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 1
  %add1778.9 = fadd contract float %add1771.9, %acc_o_3.sroa.26.36.vec.extract
  %acc_o.sroa.74.40.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 2
  %acc_o_1.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 2
  %add1764.10 = fadd contract float %acc_o.sroa.74.40.vec.extract, %acc_o_1.sroa.26.40.vec.extract
  %acc_o_2.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 2
  %add1771.10 = fadd contract float %add1764.10, %acc_o_2.sroa.26.40.vec.extract
  %acc_o_3.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 2
  %add1778.10 = fadd contract float %add1771.10, %acc_o_3.sroa.26.40.vec.extract
  %acc_o.sroa.74.44.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 3
  %acc_o_1.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 3
  %add1764.11 = fadd contract float %acc_o.sroa.74.44.vec.extract, %acc_o_1.sroa.26.44.vec.extract
  %acc_o_2.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 3
  %add1771.11 = fadd contract float %add1764.11, %acc_o_2.sroa.26.44.vec.extract
  %acc_o_3.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 3
  %add1778.11 = fadd contract float %add1771.11, %acc_o_3.sroa.26.44.vec.extract
  %acc_o.sroa.110.48.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 0
  %acc_o_1.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 0
  %add1764.12 = fadd contract float %acc_o.sroa.110.48.vec.extract, %acc_o_1.sroa.38.48.vec.extract
  %acc_o_2.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 0
  %add1771.12 = fadd contract float %add1764.12, %acc_o_2.sroa.38.48.vec.extract
  %acc_o_3.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 0
  %add1778.12 = fadd contract float %add1771.12, %acc_o_3.sroa.38.48.vec.extract
  %acc_o.sroa.110.52.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 1
  %acc_o_1.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 1
  %add1764.13 = fadd contract float %acc_o.sroa.110.52.vec.extract, %acc_o_1.sroa.38.52.vec.extract
  %acc_o_2.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 1
  %add1771.13 = fadd contract float %add1764.13, %acc_o_2.sroa.38.52.vec.extract
  %acc_o_3.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 1
  %add1778.13 = fadd contract float %add1771.13, %acc_o_3.sroa.38.52.vec.extract
  %acc_o.sroa.110.56.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 2
  %acc_o_1.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 2
  %add1764.14 = fadd contract float %acc_o.sroa.110.56.vec.extract, %acc_o_1.sroa.38.56.vec.extract
  %acc_o_2.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 2
  %add1771.14 = fadd contract float %add1764.14, %acc_o_2.sroa.38.56.vec.extract
  %acc_o_3.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 2
  %add1778.14 = fadd contract float %add1771.14, %acc_o_3.sroa.38.56.vec.extract
  %acc_o.sroa.110.60.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 3
  %acc_o_1.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 3
  %add1764.15 = fadd contract float %acc_o.sroa.110.60.vec.extract, %acc_o_1.sroa.38.60.vec.extract
  %acc_o_2.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 3
  %add1771.15 = fadd contract float %add1764.15, %acc_o_2.sroa.38.60.vec.extract
  %acc_o_3.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 3
  %add1778.15 = fadd contract float %add1771.15, %acc_o_3.sroa.38.60.vec.extract
  %add1792 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1792.1 = fadd contract float %add1792, %sum_acc.sroa.20.7
  %add1792.2 = fadd contract float %add1792.1, %sum_acc.sroa.38.7
  %add1792.3 = fadd contract float %add1792.2, %sum_acc.sroa.56.7
  %270 = bitcast float %add1792.3 to i32
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11
  %xor.i.i = xor i32 %272, 32
  %273 = and i32 %272, -64
  %and.i.i = add nsw i32 %273, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2425 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %272
  %shl.i.i = shl i32 %cond.i.i2425, 2
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %270)
  %275 = bitcast i32 %274 to float
  %add.i = fadd contract float %add1792.3, %275
  %276 = bitcast float %add.i to i32
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11
  %xor.i.i2426 = xor i32 %278, 16
  %279 = and i32 %278, -64
  %and.i.i2427 = add nsw i32 %279, 64
  %cmp.not.i.i2428 = icmp slt i32 %xor.i.i2426, %and.i.i2427
  %cond.i.i2429 = select i1 %cmp.not.i.i2428, i32 %xor.i.i2426, i32 %278
  %shl.i.i2430 = shl i32 %cond.i.i2429, 2
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2430, i32 %276)
  %281 = bitcast i32 %280 to float
  %add.i.i = fadd contract float %add.i, %281
  %cmp1801 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp1801, float %div, float 0.000000e+00
  %mul1814 = fmul contract float %condval_8.0, %add1778
  %mul1814.1 = fmul contract float %condval_8.0, %add1778.1
  %mul1814.2 = fmul contract float %condval_8.0, %add1778.2
  %mul1814.3 = fmul contract float %condval_8.0, %add1778.3
  %mul1814.4 = fmul contract float %condval_8.0, %add1778.4
  %mul1814.5 = fmul contract float %condval_8.0, %add1778.5
  %mul1814.6 = fmul contract float %condval_8.0, %add1778.6
  %mul1814.7 = fmul contract float %condval_8.0, %add1778.7
  %mul1814.8 = fmul contract float %condval_8.0, %add1778.8
  %mul1814.9 = fmul contract float %condval_8.0, %add1778.9
  %mul1814.10 = fmul contract float %condval_8.0, %add1778.10
  %mul1814.11 = fmul contract float %condval_8.0, %add1778.11
  %mul1814.12 = fmul contract float %condval_8.0, %add1778.12
  %mul1814.13 = fmul contract float %condval_8.0, %add1778.13
  %mul1814.14 = fmul contract float %condval_8.0, %add1778.14
  %mul1814.15 = fmul contract float %condval_8.0, %add1778.15
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814)
  %O_reg.sroa.0.0.insert.ext = zext i16 %282 to i64
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %283 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %284 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %286 to i64
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %287 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %288 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %290 to i64
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %291 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %292 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %293 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %294 to i64
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %295 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %296 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1814.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %297 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1856 = lshr i32 %18, 5
  %and1859 = and i32 %18, 7
  %298 = lshr i32 %18, 2
  %mul1865 = and i32 %298, 4
  %xor = xor i32 %shr1856, %and1859
  %mul1860 = shl nuw nsw i32 %xor, 3
  %add1861 = add nuw nsw i32 %mul1860, %mul25
  %add1866 = or disjoint i32 %add1861, %mul1865
  %add.ptr1868 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1866
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1868, align 8
  %add1857.1 = add nuw nsw i32 %shr1856, 2
  %xor.1 = xor i32 %add1857.1, %and1859
  %mul1860.1 = shl nuw nsw i32 %xor.1, 3
  %add1861.1 = add nuw nsw i32 %mul1860.1, %mul25
  %add1866.1 = or disjoint i32 %add1861.1, %mul1865
  %add.ptr1868.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1866.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1868.1, align 8
  %add1857.2 = add nuw nsw i32 %shr1856, 4
  %xor.2 = xor i32 %add1857.2, %and1859
  %mul1860.2 = shl nuw nsw i32 %xor.2, 3
  %add1861.2 = add nuw nsw i32 %mul1860.2, %mul25
  %add1866.2 = or disjoint i32 %add1861.2, %mul1865
  %add.ptr1868.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1866.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1868.2, align 8
  %add1857.3 = add nuw nsw i32 %shr1856, 6
  %xor.3 = xor i32 %add1857.3, %and1859
  %mul1860.3 = shl nuw nsw i32 %xor.3, 3
  %add1861.3 = add nuw nsw i32 %mul1860.3, %mul25
  %add1866.3 = or disjoint i32 %add1861.3, %mul1865
  %add.ptr1868.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1866.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1868.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %299 = shl nuw nsw i32 %18, 3
  %mul1879 = and i32 %299, 8128
  %xor18852407 = and i32 %299, 56
  %call1883.masked = and i32 %18, 1016
  %mul1886 = xor i32 %xor18852407, %call1883.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1879
  %invariant.gep2555 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1886
  %add1896 = add nuw nsw i32 %add23, %299
  %300 = zext nneg i32 %add1896 to i64
  %add.ptr1901 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1901, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2555, i64 16, i1 false), !tbaa.struct !405, !call_argsrelate !406
  %gep2556.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2555, i32 1024
  %301 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  %add.ptr1901.1 = getelementptr inbounds i8, ptr addrspace(1) %301, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1901.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2556.1, i64 16, i1 false), !tbaa.struct !405, !call_argsrelate !406
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


