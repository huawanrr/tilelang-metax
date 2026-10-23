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
  %cond.i.i2416 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2416, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2416.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2416.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2416.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2416.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2416.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2416.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2416.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2416.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2416.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2416.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2416.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2416.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2416.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2416.7, 4
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
  %or.cond2562 = or i1 %or.cond, %cmp47.not
  br i1 %or.cond2562, label %if.end, label %for.cond48.preheader

for.cond48.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2416, 10
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
  %or.cond2563 = icmp ugt i32 %mul11.1, 1023
  %cmp78.not = icmp sgt i32 %mul11.1, %1
  %or.cond2564 = or i1 %or.cond2563, %cmp78.not
  br i1 %or.cond2564, label %if.end104, label %for.cond80.preheader

for.cond80.preheader:                             ; preds = %if.end
  %mul86 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2416.1, 10
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
  %or.cond2565 = icmp ult i32 %mul11, 1024
  br i1 %or.cond2565, label %land.lhs.true108, label %if.end213

land.lhs.true108:                                 ; preds = %if.end104
  br i1 %cmp47.not, label %if.end213, label %if.then111

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
  %acc_s.sroa.0.0.vec.insert3046 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp127.not.1.not = icmp slt i32 %add124, %1
  %fneg..1 = select i1 %cmp127.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3139 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3046, float %fneg..1, i64 1
  %add125.2 = or disjoint i32 %add124, 2
  %cmp127.not.2 = icmp sgt i32 %add125.2, %1
  %fneg..2 = select i1 %cmp127.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3232 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3139, float %fneg..2, i64 2
  %add125.3 = or disjoint i32 %add124, 3
  %cmp127.not.3 = icmp sgt i32 %add125.3, %1
  %fneg..3 = select i1 %cmp127.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3325 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3232, float %fneg..3, i64 3
  br label %if.end140

if.end140:                                        ; preds = %if.then111, %for.cond116.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3325, %for.cond116.preheader ], [ zeroinitializer, %if.then111 ]
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
  %arrayidx209.idx = shl nuw nsw i32 %18, 3
  %arrayidx209 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %arrayidx209.idx
  store i16 %41, ptr addrspace(3) %arrayidx209, align 8, !tbaa !97
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %36)
  %arrayidx209.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2), i32 %arrayidx209.idx
  store i16 %42, ptr addrspace(3) %arrayidx209.1, align 2, !tbaa !97
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %38)
  %arrayidx209.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4), i32 %arrayidx209.idx
  store i16 %43, ptr addrspace(3) %arrayidx209.2, align 4, !tbaa !97
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %40)
  %arrayidx209.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 6), i32 %arrayidx209.idx
  store i16 %44, ptr addrspace(3) %arrayidx209.3, align 2, !tbaa !97
  br label %if.end213

if.end213:                                        ; preds = %if.end140, %land.lhs.true108, %if.end104
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %40, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %38, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %36, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %34, %if.end140 ], [ 0.000000e+00, %if.end104 ]
  %or.cond2566 = icmp ult i32 %mul11.1, 1024
  br i1 %or.cond2566, label %land.lhs.true217, label %if.end322

land.lhs.true217:                                 ; preds = %if.end213
  br i1 %cmp78.not, label %if.end322, label %if.then220

if.then220:                                       ; preds = %land.lhs.true217
  %add222 = or disjoint i32 %mul11.1, 15
  %cmp223 = icmp ult i32 %1, %add222
  br i1 %cmp223, label %for.cond225.preheader, label %if.end249

for.cond225.preheader:                            ; preds = %if.then220
  %45 = lshr i32 %18, 2
  %mul231 = and i32 %45, 252
  %add232 = add nuw nsw i32 %mul11.1, %mul231
  %cmp235.not = icmp sgt i32 %add232, %1
  %fneg.2401 = select i1 %cmp235.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3055 = insertelement <4 x float> poison, float %fneg.2401, i64 0
  %cmp235.not.1.not = icmp slt i32 %add232, %1
  %fneg.2401.1 = select i1 %cmp235.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3148 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3055, float %fneg.2401.1, i64 1
  %add233.2 = or disjoint i32 %add232, 2
  %cmp235.not.2 = icmp sgt i32 %add233.2, %1
  %fneg.2401.2 = select i1 %cmp235.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3241 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3148, float %fneg.2401.2, i64 2
  %add233.3 = or disjoint i32 %add232, 3
  %cmp235.not.3 = icmp sgt i32 %add233.3, %1
  %fneg.2401.3 = select i1 %cmp235.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3334 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3241, float %fneg.2401.3, i64 3
  br label %if.end249

if.end249:                                        ; preds = %if.then220, %for.cond225.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3334, %for.cond225.preheader ], [ zeroinitializer, %if.then220 ]
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !77
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %46), !call_argsrelate !77
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %47), !call_argsrelate !77
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %48), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3057 = extractelement <4 x float> %49, i64 0
  %mul284 = fmul contract float %acc_s.sroa.0.0.vec.extract3057, 0x3FB99999A0000000
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul284, float 0x4024CB5EC0000000)
  %51 = tail call contract noundef float @llvm.exp.f32(float %50)
  %acc_s.sroa.0.4.vec.extract3150 = extractelement <4 x float> %49, i64 1
  %mul284.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3150, 0x3FB99999A0000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul284.1, float 0x4024CB5EC0000000)
  %53 = tail call contract noundef float @llvm.exp.f32(float %52)
  %acc_s.sroa.0.8.vec.extract3243 = extractelement <4 x float> %49, i64 2
  %mul284.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3243, 0x3FB99999A0000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul284.2, float 0x4024CB5EC0000000)
  %55 = tail call contract noundef float @llvm.exp.f32(float %54)
  %acc_s.sroa.0.12.vec.extract3336 = extractelement <4 x float> %49, i64 3
  %mul284.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3336, 0x3FB99999A0000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul284.3, float 0x4024CB5EC0000000)
  %57 = tail call contract noundef float @llvm.exp.f32(float %56)
  %add300 = fadd contract float %sum_acc.sroa.0.0, %51
  %add300.1 = fadd contract float %sum_acc.sroa.20.0, %53
  %add300.2 = fadd contract float %sum_acc.sroa.38.0, %55
  %add300.3 = fadd contract float %sum_acc.sroa.56.0, %57
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51)
  %gep.idx = shl nuw nsw i32 %18, 3
  %gep = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 512), i32 %gep.idx
  store i16 %58, ptr addrspace(3) %gep, align 8, !tbaa !97
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53)
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 514), i32 %gep.idx
  store i16 %59, ptr addrspace(3) %gep.1, align 2, !tbaa !97
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55)
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 516), i32 %gep.idx
  store i16 %60, ptr addrspace(3) %gep.2, align 4, !tbaa !97
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57)
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 518), i32 %gep.idx
  store i16 %61, ptr addrspace(3) %gep.3, align 2, !tbaa !97
  br label %if.end322

if.end322:                                        ; preds = %if.end249, %land.lhs.true217, %if.end213
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true217 ], [ %add300.3, %if.end249 ], [ %sum_acc.sroa.56.0, %if.end213 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true217 ], [ %add300.2, %if.end249 ], [ %sum_acc.sroa.38.0, %if.end213 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true217 ], [ %add300.1, %if.end249 ], [ %sum_acc.sroa.20.0, %if.end213 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true217 ], [ %add300, %if.end249 ], [ %sum_acc.sroa.0.0, %if.end213 ]
  %or.cond2567 = icmp ugt i32 %mul11.2, 1023
  %cmp329.not = icmp sgt i32 %mul11.2, %1
  %or.cond2568 = or i1 %or.cond2567, %cmp329.not
  br i1 %or.cond2568, label %if.end354, label %for.cond331.preheader

for.cond331.preheader:                            ; preds = %if.end322
  %mul336 = shl nsw i32 %0, 16
  %62 = shl nsw i32 %cond.i.i2416.2, 10
  %mul338 = and i32 %62, 64512
  %mul343 = shl nuw nsw i32 %18, 3
  %add339 = or disjoint i32 %mul343, %mul336
  %add341 = add nuw nsw i32 %add339, %mul338
  %63 = zext nneg i32 %add341 to i64
  %add.ptr346 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63
  %K_reg.sroa.0.0.copyload3430 = load <4 x half>, ptr addrspace(4) %add.ptr346, align 16
  %K_reg.sroa.10.0.add.ptr346.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr346, i64 8
  %K_reg.sroa.10.0.copyload3433 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr346.sroa_idx, align 8
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63
  %add.ptr346.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024
  %K_reg.sroa.14.16.copyload3442 = load <4 x half>, ptr addrspace(4) %add.ptr346.1, align 16
  %K_reg.sroa.22.16.add.ptr346.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032
  %K_reg.sroa.22.16.copyload3445 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr346.1.sroa_idx, align 8
  br label %if.end354

if.end354:                                        ; preds = %for.cond331.preheader, %if.end322
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end322 ], [ %K_reg.sroa.22.16.copyload3445, %for.cond331.preheader ]
  %K_reg.sroa.14.1 = phi <4 x half> [ %K_reg.sroa.14.0, %if.end322 ], [ %K_reg.sroa.14.16.copyload3442, %for.cond331.preheader ]
  %K_reg.sroa.10.1 = phi <4 x half> [ %K_reg.sroa.10.0, %if.end322 ], [ %K_reg.sroa.10.0.copyload3433, %for.cond331.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end322 ], [ %K_reg.sroa.0.0.copyload3430, %for.cond331.preheader ]
  %or.cond2569 = icmp ugt i32 %mul11.3, 1023
  %cmp361.not = icmp sgt i32 %mul11.3, %1
  %or.cond2570 = or i1 %or.cond2569, %cmp361.not
  br i1 %or.cond2570, label %if.end386, label %for.cond363.preheader

for.cond363.preheader:                            ; preds = %if.end354
  %mul368 = shl nsw i32 %0, 16
  %65 = shl nsw i32 %cond.i.i2416.3, 10
  %mul370 = and i32 %65, 64512
  %mul375 = shl nuw nsw i32 %18, 3
  %add371 = or disjoint i32 %mul375, %mul368
  %add373 = add nuw nsw i32 %add371, %mul370
  %66 = zext nneg i32 %add373 to i64
  %add.ptr378 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66
  %K_reg1.sroa.0.0.copyload3406 = load <4 x half>, ptr addrspace(4) %add.ptr378, align 16
  %K_reg1.sroa.10.0.add.ptr378.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr378, i64 8
  %K_reg1.sroa.10.0.copyload3409 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr378.sroa_idx, align 8
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66
  %add.ptr378.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1024
  %K_reg1.sroa.14.16.copyload3418 = load <4 x half>, ptr addrspace(4) %add.ptr378.1, align 16
  %K_reg1.sroa.22.16.add.ptr378.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1032
  %K_reg1.sroa.22.16.copyload3421 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr378.1.sroa_idx, align 8
  br label %if.end386

if.end386:                                        ; preds = %for.cond363.preheader, %if.end354
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end354 ], [ %K_reg1.sroa.22.16.copyload3421, %for.cond363.preheader ]
  %K_reg1.sroa.14.1 = phi <4 x half> [ %K_reg1.sroa.14.0, %if.end354 ], [ %K_reg1.sroa.14.16.copyload3418, %for.cond363.preheader ]
  %K_reg1.sroa.10.1 = phi <4 x half> [ %K_reg1.sroa.10.0, %if.end354 ], [ %K_reg1.sroa.10.0.copyload3409, %for.cond363.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end354 ], [ %K_reg1.sroa.0.0.copyload3406, %for.cond363.preheader ]
  %or.cond2571 = icmp ult i32 %mul11.2, 1024
  br i1 %or.cond2571, label %land.lhs.true390, label %if.end495

land.lhs.true390:                                 ; preds = %if.end386
  br i1 %cmp329.not, label %if.end495, label %if.then393

if.then393:                                       ; preds = %land.lhs.true390
  %add395 = or disjoint i32 %mul11.2, 15
  %cmp396 = icmp ult i32 %1, %add395
  br i1 %cmp396, label %for.cond398.preheader, label %if.end422

for.cond398.preheader:                            ; preds = %if.then393
  %68 = lshr i32 %18, 2
  %mul404 = and i32 %68, 252
  %add405 = add nuw nsw i32 %mul11.2, %mul404
  %cmp408.not = icmp sgt i32 %add405, %1
  %fneg.2402 = select i1 %cmp408.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3065 = insertelement <4 x float> poison, float %fneg.2402, i64 0
  %cmp408.not.1.not = icmp slt i32 %add405, %1
  %fneg.2402.1 = select i1 %cmp408.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3158 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3065, float %fneg.2402.1, i64 1
  %add406.2 = or disjoint i32 %add405, 2
  %cmp408.not.2 = icmp sgt i32 %add406.2, %1
  %fneg.2402.2 = select i1 %cmp408.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3251 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3158, float %fneg.2402.2, i64 2
  %add406.3 = or disjoint i32 %add405, 3
  %cmp408.not.3 = icmp sgt i32 %add406.3, %1
  %fneg.2402.3 = select i1 %cmp408.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3344 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3251, float %fneg.2402.3, i64 3
  br label %if.end422

if.end422:                                        ; preds = %if.then393, %for.cond398.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3344, %for.cond398.preheader ], [ zeroinitializer, %if.then393 ]
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !77
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !call_argsrelate !77
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !call_argsrelate !77
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3067 = extractelement <4 x float> %72, i64 0
  %mul457 = fmul contract float %acc_s.sroa.0.0.vec.extract3067, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul457, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %acc_s.sroa.0.4.vec.extract3160 = extractelement <4 x float> %72, i64 1
  %mul457.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3160, 0x3FB99999A0000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul457.1, float 0x4024CB5EC0000000)
  %76 = tail call contract noundef float @llvm.exp.f32(float %75)
  %acc_s.sroa.0.8.vec.extract3253 = extractelement <4 x float> %72, i64 2
  %mul457.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3253, 0x3FB99999A0000000
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul457.2, float 0x4024CB5EC0000000)
  %78 = tail call contract noundef float @llvm.exp.f32(float %77)
  %acc_s.sroa.0.12.vec.extract3346 = extractelement <4 x float> %72, i64 3
  %mul457.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3346, 0x3FB99999A0000000
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul457.3, float 0x4024CB5EC0000000)
  %80 = tail call contract noundef float @llvm.exp.f32(float %79)
  %add473 = fadd contract float %sum_acc.sroa.0.1, %74
  %add473.1 = fadd contract float %sum_acc.sroa.20.1, %76
  %add473.2 = fadd contract float %sum_acc.sroa.38.1, %78
  %add473.3 = fadd contract float %sum_acc.sroa.56.1, %80
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %gep2457.idx = shl nuw nsw i32 %18, 3
  %gep2457 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1024), i32 %gep2457.idx
  store i16 %81, ptr addrspace(3) %gep2457, align 8, !tbaa !97
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76)
  %gep2457.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1026), i32 %gep2457.idx
  store i16 %82, ptr addrspace(3) %gep2457.1, align 2, !tbaa !97
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78)
  %gep2457.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1028), i32 %gep2457.idx
  store i16 %83, ptr addrspace(3) %gep2457.2, align 4, !tbaa !97
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80)
  %gep2457.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1030), i32 %gep2457.idx
  store i16 %84, ptr addrspace(3) %gep2457.3, align 2, !tbaa !97
  br label %if.end495

if.end495:                                        ; preds = %if.end422, %land.lhs.true390, %if.end386
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true390 ], [ %add473.3, %if.end422 ], [ %sum_acc.sroa.56.1, %if.end386 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true390 ], [ %add473.2, %if.end422 ], [ %sum_acc.sroa.38.1, %if.end386 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true390 ], [ %add473.1, %if.end422 ], [ %sum_acc.sroa.20.1, %if.end386 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true390 ], [ %add473, %if.end422 ], [ %sum_acc.sroa.0.1, %if.end386 ]
  %or.cond2572 = icmp ult i32 %mul11.3, 1024
  br i1 %or.cond2572, label %land.lhs.true499, label %if.end604

land.lhs.true499:                                 ; preds = %if.end495
  br i1 %cmp361.not, label %if.end604, label %if.then502

if.then502:                                       ; preds = %land.lhs.true499
  %add504 = or disjoint i32 %mul11.3, 15
  %cmp505 = icmp ult i32 %1, %add504
  br i1 %cmp505, label %for.cond507.preheader, label %if.end531

for.cond507.preheader:                            ; preds = %if.then502
  %85 = lshr i32 %18, 2
  %mul513 = and i32 %85, 252
  %add514 = add nuw nsw i32 %mul11.3, %mul513
  %cmp517.not = icmp sgt i32 %add514, %1
  %fneg.2403 = select i1 %cmp517.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3075 = insertelement <4 x float> poison, float %fneg.2403, i64 0
  %cmp517.not.1.not = icmp slt i32 %add514, %1
  %fneg.2403.1 = select i1 %cmp517.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3168 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3075, float %fneg.2403.1, i64 1
  %add515.2 = or disjoint i32 %add514, 2
  %cmp517.not.2 = icmp sgt i32 %add515.2, %1
  %fneg.2403.2 = select i1 %cmp517.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3261 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3168, float %fneg.2403.2, i64 2
  %add515.3 = or disjoint i32 %add514, 3
  %cmp517.not.3 = icmp sgt i32 %add515.3, %1
  %fneg.2403.3 = select i1 %cmp517.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3354 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3261, float %fneg.2403.3, i64 3
  br label %if.end531

if.end531:                                        ; preds = %if.then502, %for.cond507.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3354, %for.cond507.preheader ], [ zeroinitializer, %if.then502 ]
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !77
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %86), !call_argsrelate !77
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %87), !call_argsrelate !77
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %88), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3077 = extractelement <4 x float> %89, i64 0
  %mul566 = fmul contract float %acc_s.sroa.0.0.vec.extract3077, 0x3FB99999A0000000
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul566, float 0x4024CB5EC0000000)
  %91 = tail call contract noundef float @llvm.exp.f32(float %90)
  %acc_s.sroa.0.4.vec.extract3170 = extractelement <4 x float> %89, i64 1
  %mul566.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3170, 0x3FB99999A0000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul566.1, float 0x4024CB5EC0000000)
  %93 = tail call contract noundef float @llvm.exp.f32(float %92)
  %acc_s.sroa.0.8.vec.extract3263 = extractelement <4 x float> %89, i64 2
  %mul566.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3263, 0x3FB99999A0000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul566.2, float 0x4024CB5EC0000000)
  %95 = tail call contract noundef float @llvm.exp.f32(float %94)
  %acc_s.sroa.0.12.vec.extract3356 = extractelement <4 x float> %89, i64 3
  %mul566.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3356, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul566.3, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %add582 = fadd contract float %sum_acc.sroa.0.2, %91
  %add582.1 = fadd contract float %sum_acc.sroa.20.2, %93
  %add582.2 = fadd contract float %sum_acc.sroa.38.2, %95
  %add582.3 = fadd contract float %sum_acc.sroa.56.2, %97
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91)
  %gep2468.idx = shl nuw nsw i32 %18, 3
  %gep2468 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1536), i32 %gep2468.idx
  store i16 %98, ptr addrspace(3) %gep2468, align 8, !tbaa !97
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93)
  %gep2468.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1538), i32 %gep2468.idx
  store i16 %99, ptr addrspace(3) %gep2468.1, align 2, !tbaa !97
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95)
  %gep2468.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1540), i32 %gep2468.idx
  store i16 %100, ptr addrspace(3) %gep2468.2, align 4, !tbaa !97
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %gep2468.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1542), i32 %gep2468.idx
  store i16 %101, ptr addrspace(3) %gep2468.3, align 2, !tbaa !97
  br label %if.end604

if.end604:                                        ; preds = %if.end531, %land.lhs.true499, %if.end495
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true499 ], [ %add582.3, %if.end531 ], [ %sum_acc.sroa.56.2, %if.end495 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true499 ], [ %add582.2, %if.end531 ], [ %sum_acc.sroa.38.2, %if.end495 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true499 ], [ %add582.1, %if.end531 ], [ %sum_acc.sroa.20.2, %if.end495 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true499 ], [ %add582, %if.end531 ], [ %sum_acc.sroa.0.2, %if.end495 ]
  %or.cond2573 = icmp ugt i32 %mul11.4, 1023
  %cmp611.not = icmp sgt i32 %mul11.4, %1
  %or.cond2574 = or i1 %or.cond2573, %cmp611.not
  br i1 %or.cond2574, label %if.end636, label %for.cond613.preheader

for.cond613.preheader:                            ; preds = %if.end604
  %mul618 = shl nsw i32 %0, 16
  %102 = shl nsw i32 %cond.i.i2416.4, 10
  %mul620 = and i32 %102, 64512
  %mul625 = shl nuw nsw i32 %18, 3
  %add621 = or disjoint i32 %mul625, %mul618
  %add623 = add nuw nsw i32 %add621, %mul620
  %103 = zext nneg i32 %add623 to i64
  %add.ptr628 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103
  %K_reg.sroa.0.0.copyload3431 = load <4 x half>, ptr addrspace(4) %add.ptr628, align 16
  %K_reg.sroa.10.0.add.ptr628.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr628, i64 8
  %K_reg.sroa.10.0.copyload3434 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr628.sroa_idx, align 8
  %104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103
  %add.ptr628.1 = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1024
  %K_reg.sroa.14.16.copyload3443 = load <4 x half>, ptr addrspace(4) %add.ptr628.1, align 16
  %K_reg.sroa.22.16.add.ptr628.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1032
  %K_reg.sroa.22.16.copyload3446 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr628.1.sroa_idx, align 8
  br label %if.end636

if.end636:                                        ; preds = %for.cond613.preheader, %if.end604
  %K_reg.sroa.22.2 = phi <4 x half> [ %K_reg.sroa.22.1, %if.end604 ], [ %K_reg.sroa.22.16.copyload3446, %for.cond613.preheader ]
  %K_reg.sroa.14.2 = phi <4 x half> [ %K_reg.sroa.14.1, %if.end604 ], [ %K_reg.sroa.14.16.copyload3443, %for.cond613.preheader ]
  %K_reg.sroa.10.2 = phi <4 x half> [ %K_reg.sroa.10.1, %if.end604 ], [ %K_reg.sroa.10.0.copyload3434, %for.cond613.preheader ]
  %K_reg.sroa.0.2 = phi <4 x half> [ %K_reg.sroa.0.1, %if.end604 ], [ %K_reg.sroa.0.0.copyload3431, %for.cond613.preheader ]
  %or.cond2575 = icmp ugt i32 %mul11.5, 1023
  %cmp643.not = icmp sgt i32 %mul11.5, %1
  %or.cond2576 = or i1 %or.cond2575, %cmp643.not
  br i1 %or.cond2576, label %if.end668, label %for.cond645.preheader

for.cond645.preheader:                            ; preds = %if.end636
  %mul650 = shl nsw i32 %0, 16
  %105 = shl nsw i32 %cond.i.i2416.5, 10
  %mul652 = and i32 %105, 64512
  %mul657 = shl nuw nsw i32 %18, 3
  %add653 = or disjoint i32 %mul657, %mul650
  %add655 = add nuw nsw i32 %add653, %mul652
  %106 = zext nneg i32 %add655 to i64
  %add.ptr660 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106
  %K_reg1.sroa.0.0.copyload3407 = load <4 x half>, ptr addrspace(4) %add.ptr660, align 16
  %K_reg1.sroa.10.0.add.ptr660.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr660, i64 8
  %K_reg1.sroa.10.0.copyload3410 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr660.sroa_idx, align 8
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106
  %add.ptr660.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024
  %K_reg1.sroa.14.16.copyload3419 = load <4 x half>, ptr addrspace(4) %add.ptr660.1, align 16
  %K_reg1.sroa.22.16.add.ptr660.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032
  %K_reg1.sroa.22.16.copyload3422 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr660.1.sroa_idx, align 8
  br label %if.end668

if.end668:                                        ; preds = %for.cond645.preheader, %if.end636
  %K_reg1.sroa.22.2 = phi <4 x half> [ %K_reg1.sroa.22.1, %if.end636 ], [ %K_reg1.sroa.22.16.copyload3422, %for.cond645.preheader ]
  %K_reg1.sroa.14.2 = phi <4 x half> [ %K_reg1.sroa.14.1, %if.end636 ], [ %K_reg1.sroa.14.16.copyload3419, %for.cond645.preheader ]
  %K_reg1.sroa.10.2 = phi <4 x half> [ %K_reg1.sroa.10.1, %if.end636 ], [ %K_reg1.sroa.10.0.copyload3410, %for.cond645.preheader ]
  %K_reg1.sroa.0.2 = phi <4 x half> [ %K_reg1.sroa.0.1, %if.end636 ], [ %K_reg1.sroa.0.0.copyload3407, %for.cond645.preheader ]
  %or.cond2577 = icmp ult i32 %mul11.4, 1024
  br i1 %or.cond2577, label %land.lhs.true672, label %if.end777

land.lhs.true672:                                 ; preds = %if.end668
  br i1 %cmp611.not, label %if.end777, label %if.then675

if.then675:                                       ; preds = %land.lhs.true672
  %add677 = or disjoint i32 %mul11.4, 15
  %cmp678 = icmp ult i32 %1, %add677
  br i1 %cmp678, label %for.cond680.preheader, label %if.end704

for.cond680.preheader:                            ; preds = %if.then675
  %108 = lshr i32 %18, 2
  %mul686 = and i32 %108, 252
  %add687 = add nuw nsw i32 %mul11.4, %mul686
  %cmp690.not = icmp sgt i32 %add687, %1
  %fneg.2404 = select i1 %cmp690.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3085 = insertelement <4 x float> poison, float %fneg.2404, i64 0
  %cmp690.not.1.not = icmp slt i32 %add687, %1
  %fneg.2404.1 = select i1 %cmp690.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3178 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3085, float %fneg.2404.1, i64 1
  %add688.2 = or disjoint i32 %add687, 2
  %cmp690.not.2 = icmp sgt i32 %add688.2, %1
  %fneg.2404.2 = select i1 %cmp690.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3271 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3178, float %fneg.2404.2, i64 2
  %add688.3 = or disjoint i32 %add687, 3
  %cmp690.not.3 = icmp sgt i32 %add688.3, %1
  %fneg.2404.3 = select i1 %cmp690.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3364 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3271, float %fneg.2404.3, i64 3
  br label %if.end704

if.end704:                                        ; preds = %if.then675, %for.cond680.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3364, %for.cond680.preheader ], [ zeroinitializer, %if.then675 ]
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !77
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %109), !call_argsrelate !77
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %110), !call_argsrelate !77
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %111), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3087 = extractelement <4 x float> %112, i64 0
  %mul739 = fmul contract float %acc_s.sroa.0.0.vec.extract3087, 0x3FB99999A0000000
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul739, float 0x4024CB5EC0000000)
  %114 = tail call contract noundef float @llvm.exp.f32(float %113)
  %acc_s.sroa.0.4.vec.extract3180 = extractelement <4 x float> %112, i64 1
  %mul739.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3180, 0x3FB99999A0000000
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul739.1, float 0x4024CB5EC0000000)
  %116 = tail call contract noundef float @llvm.exp.f32(float %115)
  %acc_s.sroa.0.8.vec.extract3273 = extractelement <4 x float> %112, i64 2
  %mul739.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3273, 0x3FB99999A0000000
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul739.2, float 0x4024CB5EC0000000)
  %118 = tail call contract noundef float @llvm.exp.f32(float %117)
  %acc_s.sroa.0.12.vec.extract3366 = extractelement <4 x float> %112, i64 3
  %mul739.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3366, 0x3FB99999A0000000
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul739.3, float 0x4024CB5EC0000000)
  %120 = tail call contract noundef float @llvm.exp.f32(float %119)
  %add755 = fadd contract float %sum_acc.sroa.0.3, %114
  %add755.1 = fadd contract float %sum_acc.sroa.20.3, %116
  %add755.2 = fadd contract float %sum_acc.sroa.38.3, %118
  %add755.3 = fadd contract float %sum_acc.sroa.56.3, %120
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114)
  %gep2481.idx = shl nuw nsw i32 %18, 3
  %gep2481 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %gep2481.idx
  store i16 %121, ptr addrspace(3) %gep2481, align 8, !tbaa !97
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116)
  %gep2481.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2050), i32 %gep2481.idx
  store i16 %122, ptr addrspace(3) %gep2481.1, align 2, !tbaa !97
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118)
  %gep2481.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2052), i32 %gep2481.idx
  store i16 %123, ptr addrspace(3) %gep2481.2, align 4, !tbaa !97
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120)
  %gep2481.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2054), i32 %gep2481.idx
  store i16 %124, ptr addrspace(3) %gep2481.3, align 2, !tbaa !97
  br label %if.end777

if.end777:                                        ; preds = %if.end704, %land.lhs.true672, %if.end668
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true672 ], [ %add755.3, %if.end704 ], [ %sum_acc.sroa.56.3, %if.end668 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true672 ], [ %add755.2, %if.end704 ], [ %sum_acc.sroa.38.3, %if.end668 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true672 ], [ %add755.1, %if.end704 ], [ %sum_acc.sroa.20.3, %if.end668 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true672 ], [ %add755, %if.end704 ], [ %sum_acc.sroa.0.3, %if.end668 ]
  %or.cond2578 = icmp ult i32 %mul11.5, 1024
  br i1 %or.cond2578, label %land.lhs.true781, label %if.end886

land.lhs.true781:                                 ; preds = %if.end777
  br i1 %cmp643.not, label %if.end886, label %if.then784

if.then784:                                       ; preds = %land.lhs.true781
  %add786 = or disjoint i32 %mul11.5, 15
  %cmp787 = icmp ult i32 %1, %add786
  br i1 %cmp787, label %for.cond789.preheader, label %if.end813

for.cond789.preheader:                            ; preds = %if.then784
  %125 = lshr i32 %18, 2
  %mul795 = and i32 %125, 252
  %add796 = add nuw nsw i32 %mul11.5, %mul795
  %cmp799.not = icmp sgt i32 %add796, %1
  %fneg.2405 = select i1 %cmp799.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3095 = insertelement <4 x float> poison, float %fneg.2405, i64 0
  %cmp799.not.1.not = icmp slt i32 %add796, %1
  %fneg.2405.1 = select i1 %cmp799.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3188 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3095, float %fneg.2405.1, i64 1
  %add797.2 = or disjoint i32 %add796, 2
  %cmp799.not.2 = icmp sgt i32 %add797.2, %1
  %fneg.2405.2 = select i1 %cmp799.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3281 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3188, float %fneg.2405.2, i64 2
  %add797.3 = or disjoint i32 %add796, 3
  %cmp799.not.3 = icmp sgt i32 %add797.3, %1
  %fneg.2405.3 = select i1 %cmp799.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3374 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3281, float %fneg.2405.3, i64 3
  br label %if.end813

if.end813:                                        ; preds = %if.then784, %for.cond789.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3374, %for.cond789.preheader ], [ zeroinitializer, %if.then784 ]
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !77
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %126), !call_argsrelate !77
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %127), !call_argsrelate !77
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %128), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3097 = extractelement <4 x float> %129, i64 0
  %mul848 = fmul contract float %acc_s.sroa.0.0.vec.extract3097, 0x3FB99999A0000000
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul848, float 0x4024CB5EC0000000)
  %131 = tail call contract noundef float @llvm.exp.f32(float %130)
  %acc_s.sroa.0.4.vec.extract3190 = extractelement <4 x float> %129, i64 1
  %mul848.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3190, 0x3FB99999A0000000
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul848.1, float 0x4024CB5EC0000000)
  %133 = tail call contract noundef float @llvm.exp.f32(float %132)
  %acc_s.sroa.0.8.vec.extract3283 = extractelement <4 x float> %129, i64 2
  %mul848.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3283, 0x3FB99999A0000000
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul848.2, float 0x4024CB5EC0000000)
  %135 = tail call contract noundef float @llvm.exp.f32(float %134)
  %acc_s.sroa.0.12.vec.extract3376 = extractelement <4 x float> %129, i64 3
  %mul848.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3376, 0x3FB99999A0000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul848.3, float 0x4024CB5EC0000000)
  %137 = tail call contract noundef float @llvm.exp.f32(float %136)
  %add864 = fadd contract float %sum_acc.sroa.0.4, %131
  %add864.1 = fadd contract float %sum_acc.sroa.20.4, %133
  %add864.2 = fadd contract float %sum_acc.sroa.38.4, %135
  %add864.3 = fadd contract float %sum_acc.sroa.56.4, %137
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131)
  %gep2492.idx = shl nuw nsw i32 %18, 3
  %gep2492 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2560), i32 %gep2492.idx
  store i16 %138, ptr addrspace(3) %gep2492, align 8, !tbaa !97
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133)
  %gep2492.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2562), i32 %gep2492.idx
  store i16 %139, ptr addrspace(3) %gep2492.1, align 2, !tbaa !97
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135)
  %gep2492.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2564), i32 %gep2492.idx
  store i16 %140, ptr addrspace(3) %gep2492.2, align 4, !tbaa !97
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137)
  %gep2492.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2566), i32 %gep2492.idx
  store i16 %141, ptr addrspace(3) %gep2492.3, align 2, !tbaa !97
  br label %if.end886

if.end886:                                        ; preds = %if.end813, %land.lhs.true781, %if.end777
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true781 ], [ %add864.3, %if.end813 ], [ %sum_acc.sroa.56.4, %if.end777 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true781 ], [ %add864.2, %if.end813 ], [ %sum_acc.sroa.38.4, %if.end777 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true781 ], [ %add864.1, %if.end813 ], [ %sum_acc.sroa.20.4, %if.end777 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true781 ], [ %add864, %if.end813 ], [ %sum_acc.sroa.0.4, %if.end777 ]
  %or.cond2579 = icmp ugt i32 %mul11.6, 1023
  %cmp893.not = icmp sgt i32 %mul11.6, %1
  %or.cond2580 = or i1 %or.cond2579, %cmp893.not
  br i1 %or.cond2580, label %if.end918, label %for.cond895.preheader

for.cond895.preheader:                            ; preds = %if.end886
  %mul900 = shl nsw i32 %0, 16
  %142 = shl nsw i32 %cond.i.i2416.6, 10
  %mul902 = and i32 %142, 64512
  %mul907 = shl nuw nsw i32 %18, 3
  %add903 = or disjoint i32 %mul907, %mul900
  %add905 = add nuw nsw i32 %add903, %mul902
  %143 = zext nneg i32 %add905 to i64
  %add.ptr910 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143
  %K_reg.sroa.0.0.copyload3432 = load <4 x half>, ptr addrspace(4) %add.ptr910, align 16
  %K_reg.sroa.10.0.add.ptr910.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr910, i64 8
  %K_reg.sroa.10.0.copyload3435 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr910.sroa_idx, align 8
  %144 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143
  %add.ptr910.1 = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1024
  %K_reg.sroa.14.16.copyload3444 = load <4 x half>, ptr addrspace(4) %add.ptr910.1, align 16
  %K_reg.sroa.22.16.add.ptr910.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1032
  %K_reg.sroa.22.16.copyload3447 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr910.1.sroa_idx, align 8
  br label %if.end918

if.end918:                                        ; preds = %for.cond895.preheader, %if.end886
  %K_reg.sroa.22.3 = phi <4 x half> [ %K_reg.sroa.22.2, %if.end886 ], [ %K_reg.sroa.22.16.copyload3447, %for.cond895.preheader ]
  %K_reg.sroa.14.3 = phi <4 x half> [ %K_reg.sroa.14.2, %if.end886 ], [ %K_reg.sroa.14.16.copyload3444, %for.cond895.preheader ]
  %K_reg.sroa.10.3 = phi <4 x half> [ %K_reg.sroa.10.2, %if.end886 ], [ %K_reg.sroa.10.0.copyload3435, %for.cond895.preheader ]
  %K_reg.sroa.0.3 = phi <4 x half> [ %K_reg.sroa.0.2, %if.end886 ], [ %K_reg.sroa.0.0.copyload3432, %for.cond895.preheader ]
  %or.cond2581 = icmp ugt i32 %mul11.7, 1023
  %cmp925.not = icmp sgt i32 %mul11.7, %1
  %or.cond2582 = or i1 %or.cond2581, %cmp925.not
  br i1 %or.cond2582, label %if.end950, label %for.cond927.preheader

for.cond927.preheader:                            ; preds = %if.end918
  %mul932 = shl nsw i32 %0, 16
  %145 = shl nsw i32 %cond.i.i2416.7, 10
  %mul934 = and i32 %145, 64512
  %mul939 = shl nuw nsw i32 %18, 3
  %add935 = or disjoint i32 %mul939, %mul932
  %add937 = add nuw nsw i32 %add935, %mul934
  %146 = zext nneg i32 %add937 to i64
  %add.ptr942 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146
  %K_reg1.sroa.0.0.copyload3408 = load <4 x half>, ptr addrspace(4) %add.ptr942, align 16
  %K_reg1.sroa.10.0.add.ptr942.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr942, i64 8
  %K_reg1.sroa.10.0.copyload3411 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr942.sroa_idx, align 8
  %147 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146
  %add.ptr942.1 = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1024
  %K_reg1.sroa.14.16.copyload3420 = load <4 x half>, ptr addrspace(4) %add.ptr942.1, align 16
  %K_reg1.sroa.22.16.add.ptr942.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1032
  %K_reg1.sroa.22.16.copyload3423 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr942.1.sroa_idx, align 8
  br label %if.end950

if.end950:                                        ; preds = %for.cond927.preheader, %if.end918
  %K_reg1.sroa.22.3 = phi <4 x half> [ %K_reg1.sroa.22.2, %if.end918 ], [ %K_reg1.sroa.22.16.copyload3423, %for.cond927.preheader ]
  %K_reg1.sroa.14.3 = phi <4 x half> [ %K_reg1.sroa.14.2, %if.end918 ], [ %K_reg1.sroa.14.16.copyload3420, %for.cond927.preheader ]
  %K_reg1.sroa.10.3 = phi <4 x half> [ %K_reg1.sroa.10.2, %if.end918 ], [ %K_reg1.sroa.10.0.copyload3411, %for.cond927.preheader ]
  %K_reg1.sroa.0.3 = phi <4 x half> [ %K_reg1.sroa.0.2, %if.end918 ], [ %K_reg1.sroa.0.0.copyload3408, %for.cond927.preheader ]
  %or.cond2583 = icmp ult i32 %mul11.6, 1024
  br i1 %or.cond2583, label %land.lhs.true954, label %if.end1059

land.lhs.true954:                                 ; preds = %if.end950
  br i1 %cmp893.not, label %if.end1059, label %if.then957

if.then957:                                       ; preds = %land.lhs.true954
  %add959 = or disjoint i32 %mul11.6, 15
  %cmp960 = icmp ult i32 %1, %add959
  br i1 %cmp960, label %for.cond962.preheader, label %if.end986

for.cond962.preheader:                            ; preds = %if.then957
  %148 = lshr i32 %18, 2
  %mul968 = and i32 %148, 252
  %add969 = add nuw nsw i32 %mul11.6, %mul968
  %cmp972.not = icmp sgt i32 %add969, %1
  %fneg.2406 = select i1 %cmp972.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3105 = insertelement <4 x float> poison, float %fneg.2406, i64 0
  %cmp972.not.1.not = icmp slt i32 %add969, %1
  %fneg.2406.1 = select i1 %cmp972.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3198 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3105, float %fneg.2406.1, i64 1
  %add970.2 = or disjoint i32 %add969, 2
  %cmp972.not.2 = icmp sgt i32 %add970.2, %1
  %fneg.2406.2 = select i1 %cmp972.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3291 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3198, float %fneg.2406.2, i64 2
  %add970.3 = or disjoint i32 %add969, 3
  %cmp972.not.3 = icmp sgt i32 %add970.3, %1
  %fneg.2406.3 = select i1 %cmp972.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3384 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3291, float %fneg.2406.3, i64 3
  br label %if.end986

if.end986:                                        ; preds = %if.then957, %for.cond962.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3384, %for.cond962.preheader ], [ zeroinitializer, %if.then957 ]
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !77
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %149), !call_argsrelate !77
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %150), !call_argsrelate !77
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %151), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3107 = extractelement <4 x float> %152, i64 0
  %mul1021 = fmul contract float %acc_s.sroa.0.0.vec.extract3107, 0x3FB99999A0000000
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul1021, float 0x4024CB5EC0000000)
  %154 = tail call contract noundef float @llvm.exp.f32(float %153)
  %acc_s.sroa.0.4.vec.extract3200 = extractelement <4 x float> %152, i64 1
  %mul1021.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3200, 0x3FB99999A0000000
  %155 = tail call contract noundef float @llvm.minnum.f32(float %mul1021.1, float 0x4024CB5EC0000000)
  %156 = tail call contract noundef float @llvm.exp.f32(float %155)
  %acc_s.sroa.0.8.vec.extract3293 = extractelement <4 x float> %152, i64 2
  %mul1021.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3293, 0x3FB99999A0000000
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul1021.2, float 0x4024CB5EC0000000)
  %158 = tail call contract noundef float @llvm.exp.f32(float %157)
  %acc_s.sroa.0.12.vec.extract3386 = extractelement <4 x float> %152, i64 3
  %mul1021.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3386, 0x3FB99999A0000000
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul1021.3, float 0x4024CB5EC0000000)
  %160 = tail call contract noundef float @llvm.exp.f32(float %159)
  %add1037 = fadd contract float %sum_acc.sroa.0.5, %154
  %add1037.1 = fadd contract float %sum_acc.sroa.20.5, %156
  %add1037.2 = fadd contract float %sum_acc.sroa.38.5, %158
  %add1037.3 = fadd contract float %sum_acc.sroa.56.5, %160
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154)
  %gep2505.idx = shl nuw nsw i32 %18, 3
  %gep2505 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3072), i32 %gep2505.idx
  store i16 %161, ptr addrspace(3) %gep2505, align 8, !tbaa !97
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %156)
  %gep2505.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3074), i32 %gep2505.idx
  store i16 %162, ptr addrspace(3) %gep2505.1, align 2, !tbaa !97
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158)
  %gep2505.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3076), i32 %gep2505.idx
  store i16 %163, ptr addrspace(3) %gep2505.2, align 4, !tbaa !97
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160)
  %gep2505.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3078), i32 %gep2505.idx
  store i16 %164, ptr addrspace(3) %gep2505.3, align 2, !tbaa !97
  br label %if.end1059

if.end1059:                                       ; preds = %if.end986, %land.lhs.true954, %if.end950
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true954 ], [ %add1037.3, %if.end986 ], [ %sum_acc.sroa.56.5, %if.end950 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true954 ], [ %add1037.2, %if.end986 ], [ %sum_acc.sroa.38.5, %if.end950 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true954 ], [ %add1037.1, %if.end986 ], [ %sum_acc.sroa.20.5, %if.end950 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true954 ], [ %add1037, %if.end986 ], [ %sum_acc.sroa.0.5, %if.end950 ]
  %or.cond2584 = icmp ult i32 %mul11.7, 1024
  br i1 %or.cond2584, label %land.lhs.true1063, label %if.end1168

land.lhs.true1063:                                ; preds = %if.end1059
  br i1 %cmp925.not, label %if.end1168, label %if.then1066

if.then1066:                                      ; preds = %land.lhs.true1063
  %add1068 = or disjoint i32 %mul11.7, 15
  %cmp1069 = icmp slt i32 %1, %add1068
  br i1 %cmp1069, label %for.cond1071.preheader, label %if.end1095

for.cond1071.preheader:                           ; preds = %if.then1066
  %165 = lshr i32 %18, 2
  %mul1077 = and i32 %165, 252
  %add1078 = add nuw nsw i32 %mul11.7, %mul1077
  %cmp1081.not = icmp sgt i32 %add1078, %1
  %fneg.2407 = select i1 %cmp1081.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3115 = insertelement <4 x float> poison, float %fneg.2407, i64 0
  %cmp1081.not.1.not = icmp slt i32 %add1078, %1
  %fneg.2407.1 = select i1 %cmp1081.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3208 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3115, float %fneg.2407.1, i64 1
  %add1079.2 = or disjoint i32 %add1078, 2
  %cmp1081.not.2 = icmp sgt i32 %add1079.2, %1
  %fneg.2407.2 = select i1 %cmp1081.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3301 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3208, float %fneg.2407.2, i64 2
  %add1079.3 = or disjoint i32 %add1078, 3
  %cmp1081.not.3 = icmp sgt i32 %add1079.3, %1
  %fneg.2407.3 = select i1 %cmp1081.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3394 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3301, float %fneg.2407.3, i64 3
  br label %if.end1095

if.end1095:                                       ; preds = %if.then1066, %for.cond1071.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3394, %for.cond1071.preheader ], [ zeroinitializer, %if.then1066 ]
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !77
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %166), !call_argsrelate !77
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %167), !call_argsrelate !77
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %168), !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3117 = extractelement <4 x float> %169, i64 0
  %mul1130 = fmul contract float %acc_s.sroa.0.0.vec.extract3117, 0x3FB99999A0000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul1130, float 0x4024CB5EC0000000)
  %171 = tail call contract noundef float @llvm.exp.f32(float %170)
  %acc_s.sroa.0.4.vec.extract3210 = extractelement <4 x float> %169, i64 1
  %mul1130.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3210, 0x3FB99999A0000000
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul1130.1, float 0x4024CB5EC0000000)
  %173 = tail call contract noundef float @llvm.exp.f32(float %172)
  %acc_s.sroa.0.8.vec.extract3303 = extractelement <4 x float> %169, i64 2
  %mul1130.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3303, 0x3FB99999A0000000
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul1130.2, float 0x4024CB5EC0000000)
  %175 = tail call contract noundef float @llvm.exp.f32(float %174)
  %acc_s.sroa.0.12.vec.extract3396 = extractelement <4 x float> %169, i64 3
  %mul1130.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3396, 0x3FB99999A0000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul1130.3, float 0x4024CB5EC0000000)
  %177 = tail call contract noundef float @llvm.exp.f32(float %176)
  %add1146 = fadd contract float %sum_acc.sroa.0.6, %171
  %add1146.1 = fadd contract float %sum_acc.sroa.20.6, %173
  %add1146.2 = fadd contract float %sum_acc.sroa.38.6, %175
  %add1146.3 = fadd contract float %sum_acc.sroa.56.6, %177
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171)
  %gep2516.idx = shl nuw nsw i32 %18, 3
  %gep2516 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3584), i32 %gep2516.idx
  store i16 %178, ptr addrspace(3) %gep2516, align 8, !tbaa !97
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %173)
  %gep2516.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3586), i32 %gep2516.idx
  store i16 %179, ptr addrspace(3) %gep2516.1, align 2, !tbaa !97
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175)
  %gep2516.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3588), i32 %gep2516.idx
  store i16 %180, ptr addrspace(3) %gep2516.2, align 4, !tbaa !97
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177)
  %gep2516.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3590), i32 %gep2516.idx
  store i16 %181, ptr addrspace(3) %gep2516.3, align 2, !tbaa !97
  br label %if.end1168

if.end1168:                                       ; preds = %if.end1095, %land.lhs.true1063, %if.end1059
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1063 ], [ %add1146.3, %if.end1095 ], [ %sum_acc.sroa.56.6, %if.end1059 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1063 ], [ %add1146.2, %if.end1095 ], [ %sum_acc.sroa.38.6, %if.end1059 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1063 ], [ %add1146.1, %if.end1095 ], [ %sum_acc.sroa.20.6, %if.end1059 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1063 ], [ %add1146, %if.end1095 ], [ %sum_acc.sroa.0.6, %if.end1059 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br i1 %or.cond2562, label %if.end1226, label %for.cond1203.preheader

for.cond1203.preheader:                           ; preds = %if.end1168
  %mul1208 = shl nsw i32 %0, 16
  %182 = shl nsw i32 %cond.i.i2416, 10
  %mul1210 = and i32 %182, 64512
  %mul1215 = shl nuw nsw i32 %18, 3
  %add1211 = or disjoint i32 %mul1215, %mul1208
  %add1213 = add nuw nsw i32 %add1211, %mul1210
  %183 = zext nneg i32 %add1213 to i64
  %add.ptr1218 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1218, align 16
  %V_reg.sroa.10.0.add.ptr1218.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1218, i64 8
  %V_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1218.sroa_idx, align 8
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %add.ptr1218.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024
  %V_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1218.1, align 16
  %V_reg.sroa.22.16.add.ptr1218.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032
  %V_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1218.1.sroa_idx, align 8
  br label %if.end1226

if.end1226:                                       ; preds = %for.cond1203.preheader, %if.end1168
  %V_reg.sroa.22.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.22.16.copyload, %for.cond1203.preheader ]
  %V_reg.sroa.14.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.14.16.copyload, %for.cond1203.preheader ]
  %V_reg.sroa.10.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.10.0.copyload, %for.cond1203.preheader ]
  %V_reg.sroa.0.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.0.0.copyload, %for.cond1203.preheader ]
  br i1 %or.cond2564, label %if.end1258, label %for.cond1235.preheader

for.cond1235.preheader:                           ; preds = %if.end1226
  %mul1240 = shl nsw i32 %0, 16
  %185 = shl nsw i32 %cond.i.i2416.1, 10
  %mul1242 = and i32 %185, 64512
  %mul1247 = shl nuw nsw i32 %18, 3
  %add1243 = or disjoint i32 %mul1247, %mul1240
  %add1245 = add nuw nsw i32 %add1243, %mul1242
  %186 = zext nneg i32 %add1245 to i64
  %add.ptr1250 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186
  %phase_v1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1250, align 16
  %phase_v1.sroa.10.0.add.ptr1250.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1250, i64 8
  %phase_v1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1250.sroa_idx, align 8
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186
  %add.ptr1250.1 = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1024
  %phase_v1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1250.1, align 16
  %phase_v1.sroa.22.16.add.ptr1250.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1032
  %phase_v1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1250.1.sroa_idx, align 8
  br label %if.end1258

if.end1258:                                       ; preds = %for.cond1235.preheader, %if.end1226
  %phase_v1.sroa.22.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.22.16.copyload, %for.cond1235.preheader ]
  %phase_v1.sroa.14.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.14.16.copyload, %for.cond1235.preheader ]
  %phase_v1.sroa.10.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.10.0.copyload, %for.cond1235.preheader ]
  %phase_v1.sroa.0.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.0.0.copyload, %for.cond1235.preheader ]
  br i1 %or.cond2562, label %if.end1298, label %for.cond1266.preheader

for.cond1266.preheader:                           ; preds = %if.end1258
  %arrayidx1274.idx = shl nuw nsw i32 %18, 3
  %arrayidx1274 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %arrayidx1274.idx
  %188 = load <4 x half>, ptr addrspace(3) %arrayidx1274, align 8, !tbaa !97
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0, <4 x half> %188, <4 x float> zeroinitializer)
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.0, <4 x half> %188, <4 x float> zeroinitializer)
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.0, <4 x half> %188, <4 x float> zeroinitializer)
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.0, <4 x half> %188, <4 x float> zeroinitializer)
  br label %if.end1298

if.end1298:                                       ; preds = %for.cond1266.preheader, %if.end1258
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %192, %for.cond1266.preheader ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %191, %for.cond1266.preheader ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %190, %for.cond1266.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %189, %for.cond1266.preheader ]
  br i1 %or.cond2564, label %if.end1339, label %for.cond1306.preheader

for.cond1306.preheader:                           ; preds = %if.end1298
  %gep2524.idx = shl nuw nsw i32 %18, 3
  %gep2524 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 512), i32 %gep2524.idx
  %193 = load <4 x half>, ptr addrspace(3) %gep2524, align 8, !tbaa !97
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.0, <4 x half> %193, <4 x float> zeroinitializer)
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.0, <4 x half> %193, <4 x float> zeroinitializer)
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.0, <4 x half> %193, <4 x float> zeroinitializer)
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.0, <4 x half> %193, <4 x float> zeroinitializer)
  br label %if.end1339

if.end1339:                                       ; preds = %for.cond1306.preheader, %if.end1298
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %197, %for.cond1306.preheader ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %196, %for.cond1306.preheader ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %195, %for.cond1306.preheader ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %194, %for.cond1306.preheader ]
  br i1 %or.cond2568, label %if.end1371, label %for.cond1348.preheader

for.cond1348.preheader:                           ; preds = %if.end1339
  %mul1353 = shl nsw i32 %0, 16
  %198 = shl nsw i32 %cond.i.i2416.2, 10
  %mul1355 = and i32 %198, 64512
  %mul1360 = shl nuw nsw i32 %18, 3
  %add1356 = or disjoint i32 %mul1360, %mul1353
  %add1358 = add nuw nsw i32 %add1356, %mul1355
  %199 = zext nneg i32 %add1358 to i64
  %add.ptr1363 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199
  %V_reg.sroa.0.0.copyload2810 = load <4 x half>, ptr addrspace(4) %add.ptr1363, align 16
  %V_reg.sroa.10.0.add.ptr1363.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1363, i64 8
  %V_reg.sroa.10.0.copyload2813 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1363.sroa_idx, align 8
  %200 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199
  %add.ptr1363.1 = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1024
  %V_reg.sroa.14.16.copyload2822 = load <4 x half>, ptr addrspace(4) %add.ptr1363.1, align 16
  %V_reg.sroa.22.16.add.ptr1363.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1032
  %V_reg.sroa.22.16.copyload2825 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1363.1.sroa_idx, align 8
  br label %if.end1371

if.end1371:                                       ; preds = %for.cond1348.preheader, %if.end1339
  %V_reg.sroa.22.1 = phi <4 x half> [ %V_reg.sroa.22.0, %if.end1339 ], [ %V_reg.sroa.22.16.copyload2825, %for.cond1348.preheader ]
  %V_reg.sroa.14.1 = phi <4 x half> [ %V_reg.sroa.14.0, %if.end1339 ], [ %V_reg.sroa.14.16.copyload2822, %for.cond1348.preheader ]
  %V_reg.sroa.10.1 = phi <4 x half> [ %V_reg.sroa.10.0, %if.end1339 ], [ %V_reg.sroa.10.0.copyload2813, %for.cond1348.preheader ]
  %V_reg.sroa.0.1 = phi <4 x half> [ %V_reg.sroa.0.0, %if.end1339 ], [ %V_reg.sroa.0.0.copyload2810, %for.cond1348.preheader ]
  br i1 %or.cond2570, label %if.end1403, label %for.cond1380.preheader

for.cond1380.preheader:                           ; preds = %if.end1371
  %mul1385 = shl nsw i32 %0, 16
  %201 = shl nsw i32 %cond.i.i2416.3, 10
  %mul1387 = and i32 %201, 64512
  %mul1392 = shl nuw nsw i32 %18, 3
  %add1388 = or disjoint i32 %mul1392, %mul1385
  %add1390 = add nuw nsw i32 %add1388, %mul1387
  %202 = zext nneg i32 %add1390 to i64
  %add.ptr1395 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202
  %phase_v1.sroa.0.0.copyload2786 = load <4 x half>, ptr addrspace(4) %add.ptr1395, align 16
  %phase_v1.sroa.10.0.add.ptr1395.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1395, i64 8
  %phase_v1.sroa.10.0.copyload2789 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1395.sroa_idx, align 8
  %203 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202
  %add.ptr1395.1 = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1024
  %phase_v1.sroa.14.16.copyload2798 = load <4 x half>, ptr addrspace(4) %add.ptr1395.1, align 16
  %phase_v1.sroa.22.16.add.ptr1395.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1032
  %phase_v1.sroa.22.16.copyload2801 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1395.1.sroa_idx, align 8
  br label %if.end1403

if.end1403:                                       ; preds = %for.cond1380.preheader, %if.end1371
  %phase_v1.sroa.22.1 = phi <4 x half> [ %phase_v1.sroa.22.0, %if.end1371 ], [ %phase_v1.sroa.22.16.copyload2801, %for.cond1380.preheader ]
  %phase_v1.sroa.14.1 = phi <4 x half> [ %phase_v1.sroa.14.0, %if.end1371 ], [ %phase_v1.sroa.14.16.copyload2798, %for.cond1380.preheader ]
  %phase_v1.sroa.10.1 = phi <4 x half> [ %phase_v1.sroa.10.0, %if.end1371 ], [ %phase_v1.sroa.10.0.copyload2789, %for.cond1380.preheader ]
  %phase_v1.sroa.0.1 = phi <4 x half> [ %phase_v1.sroa.0.0, %if.end1371 ], [ %phase_v1.sroa.0.0.copyload2786, %for.cond1380.preheader ]
  br i1 %or.cond2568, label %if.end1444, label %for.cond1411.preheader

for.cond1411.preheader:                           ; preds = %if.end1403
  %gep2529.idx = shl nuw nsw i32 %18, 3
  %gep2529 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1024), i32 %gep2529.idx
  %204 = load <4 x half>, ptr addrspace(3) %gep2529, align 8, !tbaa !97
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.1, <4 x half> %204, <4 x float> %acc_o.sroa.0.0)
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.1, <4 x half> %204, <4 x float> %acc_o.sroa.34.0)
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.1, <4 x half> %204, <4 x float> %acc_o.sroa.66.0)
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.1, <4 x half> %204, <4 x float> %acc_o.sroa.98.0)
  br label %if.end1444

if.end1444:                                       ; preds = %for.cond1411.preheader, %if.end1403
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end1403 ], [ %208, %for.cond1411.preheader ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end1403 ], [ %207, %for.cond1411.preheader ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end1403 ], [ %206, %for.cond1411.preheader ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1403 ], [ %205, %for.cond1411.preheader ]
  br i1 %or.cond2570, label %if.end1485, label %for.cond1452.preheader

for.cond1452.preheader:                           ; preds = %if.end1444
  %gep2532.idx = shl nuw nsw i32 %18, 3
  %gep2532 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1536), i32 %gep2532.idx
  %209 = load <4 x half>, ptr addrspace(3) %gep2532, align 8, !tbaa !97
  %210 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.0.0)
  %211 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.18.0)
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.34.0)
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.50.0)
  br label %if.end1485

if.end1485:                                       ; preds = %for.cond1452.preheader, %if.end1444
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1444 ], [ %213, %for.cond1452.preheader ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end1444 ], [ %212, %for.cond1452.preheader ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end1444 ], [ %211, %for.cond1452.preheader ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1444 ], [ %210, %for.cond1452.preheader ]
  br i1 %or.cond2574, label %if.end1517, label %for.cond1494.preheader

for.cond1494.preheader:                           ; preds = %if.end1485
  %mul1499 = shl nsw i32 %0, 16
  %214 = shl nsw i32 %cond.i.i2416.4, 10
  %mul1501 = and i32 %214, 64512
  %mul1506 = shl nuw nsw i32 %18, 3
  %add1502 = or disjoint i32 %mul1506, %mul1499
  %add1504 = add nuw nsw i32 %add1502, %mul1501
  %215 = zext nneg i32 %add1504 to i64
  %add.ptr1509 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215
  %V_reg.sroa.0.0.copyload2811 = load <4 x half>, ptr addrspace(4) %add.ptr1509, align 16
  %V_reg.sroa.10.0.add.ptr1509.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1509, i64 8
  %V_reg.sroa.10.0.copyload2814 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1509.sroa_idx, align 8
  %216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215
  %add.ptr1509.1 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1024
  %V_reg.sroa.14.16.copyload2823 = load <4 x half>, ptr addrspace(4) %add.ptr1509.1, align 16
  %V_reg.sroa.22.16.add.ptr1509.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1032
  %V_reg.sroa.22.16.copyload2826 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1509.1.sroa_idx, align 8
  br label %if.end1517

if.end1517:                                       ; preds = %for.cond1494.preheader, %if.end1485
  %V_reg.sroa.22.2 = phi <4 x half> [ %V_reg.sroa.22.1, %if.end1485 ], [ %V_reg.sroa.22.16.copyload2826, %for.cond1494.preheader ]
  %V_reg.sroa.14.2 = phi <4 x half> [ %V_reg.sroa.14.1, %if.end1485 ], [ %V_reg.sroa.14.16.copyload2823, %for.cond1494.preheader ]
  %V_reg.sroa.10.2 = phi <4 x half> [ %V_reg.sroa.10.1, %if.end1485 ], [ %V_reg.sroa.10.0.copyload2814, %for.cond1494.preheader ]
  %V_reg.sroa.0.2 = phi <4 x half> [ %V_reg.sroa.0.1, %if.end1485 ], [ %V_reg.sroa.0.0.copyload2811, %for.cond1494.preheader ]
  br i1 %or.cond2576, label %if.end1549, label %for.cond1526.preheader

for.cond1526.preheader:                           ; preds = %if.end1517
  %mul1531 = shl nsw i32 %0, 16
  %217 = shl nsw i32 %cond.i.i2416.5, 10
  %mul1533 = and i32 %217, 64512
  %mul1538 = shl nuw nsw i32 %18, 3
  %add1534 = or disjoint i32 %mul1538, %mul1531
  %add1536 = add nuw nsw i32 %add1534, %mul1533
  %218 = zext nneg i32 %add1536 to i64
  %add.ptr1541 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218
  %phase_v1.sroa.0.0.copyload2787 = load <4 x half>, ptr addrspace(4) %add.ptr1541, align 16
  %phase_v1.sroa.10.0.add.ptr1541.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1541, i64 8
  %phase_v1.sroa.10.0.copyload2790 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1541.sroa_idx, align 8
  %219 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218
  %add.ptr1541.1 = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1024
  %phase_v1.sroa.14.16.copyload2799 = load <4 x half>, ptr addrspace(4) %add.ptr1541.1, align 16
  %phase_v1.sroa.22.16.add.ptr1541.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1032
  %phase_v1.sroa.22.16.copyload2802 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1541.1.sroa_idx, align 8
  br label %if.end1549

if.end1549:                                       ; preds = %for.cond1526.preheader, %if.end1517
  %phase_v1.sroa.22.2 = phi <4 x half> [ %phase_v1.sroa.22.1, %if.end1517 ], [ %phase_v1.sroa.22.16.copyload2802, %for.cond1526.preheader ]
  %phase_v1.sroa.14.2 = phi <4 x half> [ %phase_v1.sroa.14.1, %if.end1517 ], [ %phase_v1.sroa.14.16.copyload2799, %for.cond1526.preheader ]
  %phase_v1.sroa.10.2 = phi <4 x half> [ %phase_v1.sroa.10.1, %if.end1517 ], [ %phase_v1.sroa.10.0.copyload2790, %for.cond1526.preheader ]
  %phase_v1.sroa.0.2 = phi <4 x half> [ %phase_v1.sroa.0.1, %if.end1517 ], [ %phase_v1.sroa.0.0.copyload2787, %for.cond1526.preheader ]
  br i1 %or.cond2574, label %if.end1590, label %for.cond1557.preheader

for.cond1557.preheader:                           ; preds = %if.end1549
  %gep2537.idx = shl nuw nsw i32 %18, 3
  %gep2537 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %gep2537.idx
  %220 = load <4 x half>, ptr addrspace(3) %gep2537, align 8, !tbaa !97
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.2, <4 x half> %220, <4 x float> %acc_o.sroa.0.1)
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.2, <4 x half> %220, <4 x float> %acc_o.sroa.34.1)
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.2, <4 x half> %220, <4 x float> %acc_o.sroa.66.1)
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.2, <4 x half> %220, <4 x float> %acc_o.sroa.98.1)
  br label %if.end1590

if.end1590:                                       ; preds = %for.cond1557.preheader, %if.end1549
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end1549 ], [ %224, %for.cond1557.preheader ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end1549 ], [ %223, %for.cond1557.preheader ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end1549 ], [ %222, %for.cond1557.preheader ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1549 ], [ %221, %for.cond1557.preheader ]
  br i1 %or.cond2576, label %if.end1631, label %for.cond1598.preheader

for.cond1598.preheader:                           ; preds = %if.end1590
  %gep2540.idx = shl nuw nsw i32 %18, 3
  %gep2540 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2560), i32 %gep2540.idx
  %225 = load <4 x half>, ptr addrspace(3) %gep2540, align 8, !tbaa !97
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.0.1)
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.18.1)
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.34.1)
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.50.1)
  br label %if.end1631

if.end1631:                                       ; preds = %for.cond1598.preheader, %if.end1590
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1590 ], [ %229, %for.cond1598.preheader ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end1590 ], [ %228, %for.cond1598.preheader ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end1590 ], [ %227, %for.cond1598.preheader ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1590 ], [ %226, %for.cond1598.preheader ]
  br i1 %or.cond2580, label %if.end1663, label %for.cond1640.preheader

for.cond1640.preheader:                           ; preds = %if.end1631
  %mul1645 = shl nsw i32 %0, 16
  %230 = shl nsw i32 %cond.i.i2416.6, 10
  %mul1647 = and i32 %230, 64512
  %mul1652 = shl nuw nsw i32 %18, 3
  %add1648 = or disjoint i32 %mul1652, %mul1645
  %add1650 = add nuw nsw i32 %add1648, %mul1647
  %231 = zext nneg i32 %add1650 to i64
  %add.ptr1655 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %231
  %V_reg.sroa.0.0.copyload2812 = load <4 x half>, ptr addrspace(4) %add.ptr1655, align 16
  %V_reg.sroa.10.0.add.ptr1655.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1655, i64 8
  %V_reg.sroa.10.0.copyload2815 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1655.sroa_idx, align 8
  %232 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %231
  %add.ptr1655.1 = getelementptr inbounds i8, ptr addrspace(4) %232, i64 1024
  %V_reg.sroa.14.16.copyload2824 = load <4 x half>, ptr addrspace(4) %add.ptr1655.1, align 16
  %V_reg.sroa.22.16.add.ptr1655.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %232, i64 1032
  %V_reg.sroa.22.16.copyload2827 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1655.1.sroa_idx, align 8
  br label %if.end1663

if.end1663:                                       ; preds = %for.cond1640.preheader, %if.end1631
  %V_reg.sroa.22.3 = phi <4 x half> [ %V_reg.sroa.22.2, %if.end1631 ], [ %V_reg.sroa.22.16.copyload2827, %for.cond1640.preheader ]
  %V_reg.sroa.14.3 = phi <4 x half> [ %V_reg.sroa.14.2, %if.end1631 ], [ %V_reg.sroa.14.16.copyload2824, %for.cond1640.preheader ]
  %V_reg.sroa.10.3 = phi <4 x half> [ %V_reg.sroa.10.2, %if.end1631 ], [ %V_reg.sroa.10.0.copyload2815, %for.cond1640.preheader ]
  %V_reg.sroa.0.3 = phi <4 x half> [ %V_reg.sroa.0.2, %if.end1631 ], [ %V_reg.sroa.0.0.copyload2812, %for.cond1640.preheader ]
  br i1 %or.cond2582, label %if.end1695, label %for.cond1672.preheader

for.cond1672.preheader:                           ; preds = %if.end1663
  %mul1677 = shl nsw i32 %0, 16
  %233 = shl nsw i32 %cond.i.i2416.7, 10
  %mul1679 = and i32 %233, 64512
  %mul1684 = shl nuw nsw i32 %18, 3
  %add1680 = or disjoint i32 %mul1684, %mul1677
  %add1682 = add nuw nsw i32 %add1680, %mul1679
  %234 = zext nneg i32 %add1682 to i64
  %add.ptr1687 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %234
  %phase_v1.sroa.0.0.copyload2788 = load <4 x half>, ptr addrspace(4) %add.ptr1687, align 16
  %phase_v1.sroa.10.0.add.ptr1687.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1687, i64 8
  %phase_v1.sroa.10.0.copyload2791 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1687.sroa_idx, align 8
  %235 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %234
  %add.ptr1687.1 = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1024
  %phase_v1.sroa.14.16.copyload2800 = load <4 x half>, ptr addrspace(4) %add.ptr1687.1, align 16
  %phase_v1.sroa.22.16.add.ptr1687.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1032
  %phase_v1.sroa.22.16.copyload2803 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1687.1.sroa_idx, align 8
  br label %if.end1695

if.end1695:                                       ; preds = %for.cond1672.preheader, %if.end1663
  %phase_v1.sroa.22.3 = phi <4 x half> [ %phase_v1.sroa.22.2, %if.end1663 ], [ %phase_v1.sroa.22.16.copyload2803, %for.cond1672.preheader ]
  %phase_v1.sroa.14.3 = phi <4 x half> [ %phase_v1.sroa.14.2, %if.end1663 ], [ %phase_v1.sroa.14.16.copyload2800, %for.cond1672.preheader ]
  %phase_v1.sroa.10.3 = phi <4 x half> [ %phase_v1.sroa.10.2, %if.end1663 ], [ %phase_v1.sroa.10.0.copyload2791, %for.cond1672.preheader ]
  %phase_v1.sroa.0.3 = phi <4 x half> [ %phase_v1.sroa.0.2, %if.end1663 ], [ %phase_v1.sroa.0.0.copyload2788, %for.cond1672.preheader ]
  br i1 %or.cond2580, label %if.end1736, label %for.cond1703.preheader

for.cond1703.preheader:                           ; preds = %if.end1695
  %gep2545.idx = shl nuw nsw i32 %18, 3
  %gep2545 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3072), i32 %gep2545.idx
  %236 = load <4 x half>, ptr addrspace(3) %gep2545, align 8, !tbaa !97
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.3, <4 x half> %236, <4 x float> %acc_o.sroa.0.2)
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.3, <4 x half> %236, <4 x float> %acc_o.sroa.34.2)
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.3, <4 x half> %236, <4 x float> %acc_o.sroa.66.2)
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.3, <4 x half> %236, <4 x float> %acc_o.sroa.98.2)
  br label %if.end1736

if.end1736:                                       ; preds = %for.cond1703.preheader, %if.end1695
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end1695 ], [ %240, %for.cond1703.preheader ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end1695 ], [ %239, %for.cond1703.preheader ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end1695 ], [ %238, %for.cond1703.preheader ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end1695 ], [ %237, %for.cond1703.preheader ]
  %.pre = shl nuw nsw i32 %18, 3
  br i1 %or.cond2582, label %if.end1777, label %for.cond1744.preheader

for.cond1744.preheader:                           ; preds = %if.end1736
  %gep2548 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3584), i32 %.pre
  %241 = load <4 x half>, ptr addrspace(3) %gep2548, align 8, !tbaa !97
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.0.2)
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.18.2)
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.34.2)
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.50.2)
  br label %if.end1777

if.end1777:                                       ; preds = %if.end1736, %for.cond1744.preheader
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %245, %for.cond1744.preheader ], [ %acc_o_alt.sroa.50.2, %if.end1736 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %244, %for.cond1744.preheader ], [ %acc_o_alt.sroa.34.2, %if.end1736 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %243, %for.cond1744.preheader ], [ %acc_o_alt.sroa.18.2, %if.end1736 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %242, %for.cond1744.preheader ], [ %acc_o_alt.sroa.0.2, %if.end1736 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add1786 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add1786.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add1786.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add1786.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add1786.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add1786.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add1786.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add1786.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add1786.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add1786.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add1786.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add1786.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add1786.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add1786.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add1786.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add1786.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add1800 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1800.1 = fadd contract float %add1800, %sum_acc.sroa.20.7
  %add1800.2 = fadd contract float %add1800.1, %sum_acc.sroa.38.7
  %add1800.3 = fadd contract float %add1800.2, %sum_acc.sroa.56.7
  %246 = bitcast float %add1800.3 to i32
  %247 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %248 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %247) #11
  %xor.i.i = xor i32 %248, 32
  %249 = and i32 %248, -64
  %and.i.i = add nsw i32 %249, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2417 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %248
  %shl.i.i = shl i32 %cond.i.i2417, 2
  %250 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %246)
  %251 = bitcast i32 %250 to float
  %add.i = fadd contract float %add1800.3, %251
  %252 = bitcast float %add.i to i32
  %253 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %254 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %253) #11
  %xor.i.i2418 = xor i32 %254, 16
  %255 = and i32 %254, -64
  %and.i.i2419 = add nsw i32 %255, 64
  %cmp.not.i.i2420 = icmp slt i32 %xor.i.i2418, %and.i.i2419
  %cond.i.i2421 = select i1 %cmp.not.i.i2420, i32 %xor.i.i2418, i32 %254
  %shl.i.i2422 = shl i32 %cond.i.i2421, 2
  %256 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2422, i32 %252)
  %257 = bitcast i32 %256 to float
  %add.i.i = fadd contract float %add.i, %257
  %cmp1809 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp1809, float %div, float 0.000000e+00
  %mul1822 = fmul contract float %condval_8.0, %add1786
  %mul1822.1 = fmul contract float %condval_8.0, %add1786.1
  %mul1822.2 = fmul contract float %condval_8.0, %add1786.2
  %mul1822.3 = fmul contract float %condval_8.0, %add1786.3
  %mul1822.4 = fmul contract float %condval_8.0, %add1786.4
  %mul1822.5 = fmul contract float %condval_8.0, %add1786.5
  %mul1822.6 = fmul contract float %condval_8.0, %add1786.6
  %mul1822.7 = fmul contract float %condval_8.0, %add1786.7
  %mul1822.8 = fmul contract float %condval_8.0, %add1786.8
  %mul1822.9 = fmul contract float %condval_8.0, %add1786.9
  %mul1822.10 = fmul contract float %condval_8.0, %add1786.10
  %mul1822.11 = fmul contract float %condval_8.0, %add1786.11
  %mul1822.12 = fmul contract float %condval_8.0, %add1786.12
  %mul1822.13 = fmul contract float %condval_8.0, %add1786.13
  %mul1822.14 = fmul contract float %condval_8.0, %add1786.14
  %mul1822.15 = fmul contract float %condval_8.0, %add1786.15
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822)
  %O_reg.sroa.0.0.insert.ext = zext i16 %258 to i64
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %259 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %260 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %261 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %262 to i64
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %263 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %264 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %265 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %266 to i64
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %267 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %268 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %269 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %270 to i64
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %271 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %272 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %273 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1864 = lshr i32 %18, 5
  %and1867 = and i32 %18, 7
  %274 = lshr i32 %18, 2
  %mul1873 = and i32 %274, 4
  %xor = xor i32 %shr1864, %and1867
  %mul1868 = shl nuw nsw i32 %xor, 3
  %add1869 = add nuw nsw i32 %mul1868, %mul25
  %add1874 = or disjoint i32 %add1869, %mul1873
  %add.ptr1876 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1876, align 8
  %add1865.1 = add nuw nsw i32 %shr1864, 2
  %xor.1 = xor i32 %add1865.1, %and1867
  %mul1868.1 = shl nuw nsw i32 %xor.1, 3
  %add1869.1 = add nuw nsw i32 %mul1868.1, %mul25
  %add1874.1 = or disjoint i32 %add1869.1, %mul1873
  %add.ptr1876.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1876.1, align 8
  %add1865.2 = add nuw nsw i32 %shr1864, 4
  %xor.2 = xor i32 %add1865.2, %and1867
  %mul1868.2 = shl nuw nsw i32 %xor.2, 3
  %add1869.2 = add nuw nsw i32 %mul1868.2, %mul25
  %add1874.2 = or disjoint i32 %add1869.2, %mul1873
  %add.ptr1876.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1876.2, align 8
  %add1865.3 = add nuw nsw i32 %shr1864, 6
  %xor.3 = xor i32 %add1865.3, %and1867
  %mul1868.3 = shl nuw nsw i32 %xor.3, 3
  %add1869.3 = add nuw nsw i32 %mul1868.3, %mul25
  %add1874.3 = or disjoint i32 %add1869.3, %mul1873
  %add.ptr1876.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1876.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul1887 = and i32 %.pre, 8128
  %xor18932399 = and i32 %.pre, 56
  %call1891.masked = and i32 %18, 1016
  %mul1894 = xor i32 %xor18932399, %call1891.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1887
  %invariant.gep2559 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1894
  %add1904 = add nuw nsw i32 %add23, %.pre
  %275 = zext nneg i32 %add1904 to i64
  %add.ptr1909 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %275
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1909, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2559, i64 16, i1 false), !tbaa.struct !442, !call_argsrelate !443
  %gep2560.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2559, i32 1024
  %276 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %275
  %add.ptr1909.1 = getelementptr inbounds i8, ptr addrspace(1) %276, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1909.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2560.1, i64 16, i1 false), !tbaa.struct !442, !call_argsrelate !443
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


