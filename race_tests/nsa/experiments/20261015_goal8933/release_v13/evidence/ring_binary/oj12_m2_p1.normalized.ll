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
  %cond.i.i2222 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2222, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2222.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2222.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2222.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2222.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2222.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2222.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2222.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2222.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2222.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2222.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2222.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2222.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2222.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2222.7, 4
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
  %cmp75.not = icmp sgt i32 %mul11, %1
  %or.cond2346 = or i1 %or.cond, %cmp75.not
  br i1 %or.cond2346, label %if.end, label %for.cond76.preheader

for.cond76.preheader:                             ; preds = %entry
  %mul82 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2222, 10
  %mul84 = and i32 %22, 64512
  %mul89 = shl nuw nsw i32 %18, 3
  %add85 = or disjoint i32 %mul89, %mul82
  %add87 = add nuw nsw i32 %add85, %mul84
  %23 = zext nneg i32 %add87 to i64
  %add.ptr92 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %K_ring0.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr92, align 16
  %K_ring0.sroa.10.0.add.ptr92.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr92, i64 8
  %K_ring0.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr92.sroa_idx, align 8
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %add.ptr92.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024
  %K_ring0.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr92.1, align 16
  %K_ring0.sroa.22.16.add.ptr92.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1032
  %K_ring0.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr92.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %for.cond76.preheader, %entry
  %K_ring0.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.22.16.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.14.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.14.16.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.10.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.10.0.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.0.0.copyload, %for.cond76.preheader ]
  %or.cond2347 = icmp ugt i32 %mul11.1, 1023
  %cmp106.not = icmp sgt i32 %mul11.1, %1
  %or.cond2348 = or i1 %or.cond2347, %cmp106.not
  br i1 %or.cond2348, label %if.end132, label %for.cond108.preheader

for.cond108.preheader:                            ; preds = %if.end
  %mul114 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2222.1, 10
  %mul116 = and i32 %25, 64512
  %mul121 = shl nuw nsw i32 %18, 3
  %add117 = or disjoint i32 %mul121, %mul114
  %add119 = add nuw nsw i32 %add117, %mul116
  %26 = zext nneg i32 %add119 to i64
  %add.ptr124 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %K_ring1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr124, align 16
  %K_ring1.sroa.10.0.add.ptr124.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr124, i64 8
  %K_ring1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr124.sroa_idx, align 8
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %add.ptr124.1 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024
  %K_ring1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr124.1, align 16
  %K_ring1.sroa.22.16.add.ptr124.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1032
  %K_ring1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr124.1.sroa_idx, align 8
  br label %if.end132

if.end132:                                        ; preds = %for.cond108.preheader, %if.end
  %K_ring1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.22.16.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.14.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.14.16.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.10.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.10.0.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.0.0.copyload, %for.cond108.preheader ]
  br i1 %or.cond2346, label %if.end165, label %for.cond141.preheader

for.cond141.preheader:                            ; preds = %if.end132
  %mul147 = shl nsw i32 %0, 16
  %28 = shl nsw i32 %cond.i.i2222, 10
  %mul149 = and i32 %28, 64512
  %mul154 = shl nuw nsw i32 %18, 3
  %add150 = or disjoint i32 %mul154, %mul147
  %add152 = add nuw nsw i32 %add150, %mul149
  %29 = zext nneg i32 %add152 to i64
  %add.ptr157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %29
  %V_ring0.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157, align 16
  %V_ring0.sroa.10.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr157, i64 8
  %V_ring0.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr157.sroa_idx, align 8
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %29
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1024
  %V_ring0.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157.1, align 16
  %V_ring0.sroa.22.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032
  %V_ring0.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr157.1.sroa_idx, align 8
  br label %if.end165

if.end165:                                        ; preds = %for.cond141.preheader, %if.end132
  %V_ring0.sroa.22.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.22.16.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.14.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.14.16.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.10.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.10.0.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.0.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.0.0.copyload, %for.cond141.preheader ]
  br i1 %or.cond2348, label %if.end198, label %for.cond174.preheader

for.cond174.preheader:                            ; preds = %if.end165
  %mul180 = shl nsw i32 %0, 16
  %31 = shl nsw i32 %cond.i.i2222.1, 10
  %mul182 = and i32 %31, 64512
  %mul187 = shl nuw nsw i32 %18, 3
  %add183 = or disjoint i32 %mul187, %mul180
  %add185 = add nuw nsw i32 %add183, %mul182
  %32 = zext nneg i32 %add185 to i64
  %add.ptr190 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %32
  %V_ring1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr190, align 16
  %V_ring1.sroa.10.0.add.ptr190.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr190, i64 8
  %V_ring1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr190.sroa_idx, align 8
  %33 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %32
  %add.ptr190.1 = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1024
  %V_ring1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr190.1, align 16
  %V_ring1.sroa.22.16.add.ptr190.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1032
  %V_ring1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr190.1.sroa_idx, align 8
  br label %if.end198

if.end198:                                        ; preds = %for.cond174.preheader, %if.end165
  %V_ring1.sroa.22.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring1.sroa.22.16.copyload, %for.cond174.preheader ]
  %V_ring1.sroa.14.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring1.sroa.14.16.copyload, %for.cond174.preheader ]
  %V_ring1.sroa.10.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring1.sroa.10.0.copyload, %for.cond174.preheader ]
  %V_ring1.sroa.0.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring1.sroa.0.0.copyload, %for.cond174.preheader ]
  %or.cond2353 = icmp ugt i32 %mul11, 1023
  %brmerge = or i1 %or.cond2353, %cmp75.not
  br i1 %brmerge, label %if.end265, label %if.then206

if.then206:                                       ; preds = %if.end198
  %add208 = or disjoint i32 %mul11, 15
  %cmp209 = icmp ult i32 %1, %add208
  br i1 %cmp209, label %for.cond211.preheader, label %if.end235

for.cond211.preheader:                            ; preds = %if.then206
  %34 = lshr i32 %18, 2
  %mul218 = and i32 %34, 252
  %add219 = add nuw nsw i32 %mul11, %mul218
  %cmp222.not = icmp sgt i32 %add219, %1
  %fneg. = select i1 %cmp222.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2586 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp222.not.1.not = icmp slt i32 %add219, %1
  %fneg..1 = select i1 %cmp222.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2679 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2586, float %fneg..1, i64 1
  %add220.2 = or disjoint i32 %add219, 2
  %cmp222.not.2 = icmp sgt i32 %add220.2, %1
  %fneg..2 = select i1 %cmp222.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2772 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2679, float %fneg..2, i64 2
  %add220.3 = or disjoint i32 %add219, 3
  %cmp222.not.3 = icmp sgt i32 %add220.3, %1
  %fneg..3 = select i1 %cmp222.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2865 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2772, float %fneg..3, i64 3
  br label %if.end235

if.end235:                                        ; preds = %if.then206, %for.cond211.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2865, %for.cond211.preheader ], [ zeroinitializer, %if.then206 ]
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !84
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %35), !call_argsrelate !84
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %36), !call_argsrelate !84
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %37), !call_argsrelate !84
  br label %if.end265

if.end265:                                        ; preds = %if.end198, %if.end235
  %acc_s.sroa.0.1 = phi <4 x float> [ %38, %if.end235 ], [ undef, %if.end198 ]
  %or.cond2354 = icmp ugt i32 %mul11.2, 1023
  %cmp272.not = icmp sgt i32 %mul11.2, %1
  %or.cond2355 = or i1 %or.cond2354, %cmp272.not
  br i1 %or.cond2355, label %if.end297, label %for.cond274.preheader

for.cond274.preheader:                            ; preds = %if.end265
  %mul279 = shl nsw i32 %0, 16
  %39 = shl nsw i32 %cond.i.i2222.2, 10
  %mul281 = and i32 %39, 64512
  %mul286 = shl nuw nsw i32 %18, 3
  %add282 = or disjoint i32 %mul286, %mul279
  %add284 = add nuw nsw i32 %add282, %mul281
  %40 = zext nneg i32 %add284 to i64
  %add.ptr289 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %40
  %K_ring0.sroa.0.0.copyload3018 = load <4 x half>, ptr addrspace(4) %add.ptr289, align 16
  %K_ring0.sroa.10.0.add.ptr289.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289, i64 8
  %K_ring0.sroa.10.0.copyload3021 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr289.sroa_idx, align 8
  %41 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %40
  %add.ptr289.1 = getelementptr inbounds i8, ptr addrspace(4) %41, i64 1024
  %K_ring0.sroa.14.16.copyload3030 = load <4 x half>, ptr addrspace(4) %add.ptr289.1, align 16
  %K_ring0.sroa.22.16.add.ptr289.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %41, i64 1032
  %K_ring0.sroa.22.16.copyload3033 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr289.1.sroa_idx, align 8
  br label %if.end297

if.end297:                                        ; preds = %for.cond274.preheader, %if.end265
  %K_ring0.sroa.22.1 = phi <4 x half> [ %K_ring0.sroa.22.0, %if.end265 ], [ %K_ring0.sroa.22.16.copyload3033, %for.cond274.preheader ]
  %K_ring0.sroa.14.1 = phi <4 x half> [ %K_ring0.sroa.14.0, %if.end265 ], [ %K_ring0.sroa.14.16.copyload3030, %for.cond274.preheader ]
  %K_ring0.sroa.10.1 = phi <4 x half> [ %K_ring0.sroa.10.0, %if.end265 ], [ %K_ring0.sroa.10.0.copyload3021, %for.cond274.preheader ]
  %K_ring0.sroa.0.1 = phi <4 x half> [ %K_ring0.sroa.0.0, %if.end265 ], [ %K_ring0.sroa.0.0.copyload3018, %for.cond274.preheader ]
  br i1 %or.cond2346, label %if.end363, label %for.body308.preheader

for.body308.preheader:                            ; preds = %if.end297
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 0
  %mul311 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul311, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  %acc_s.sroa.0.0.vec.insert2589 = insertelement <4 x float> poison, float %43, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 1
  %mul311.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul311.1, float 0x4024CB5EC0000000)
  %45 = tail call contract noundef float @llvm.exp.f32(float %44)
  %acc_s.sroa.0.4.vec.insert2682 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2589, float %45, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 2
  %mul311.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul311.2, float 0x4024CB5EC0000000)
  %47 = tail call contract noundef float @llvm.exp.f32(float %46)
  %acc_s.sroa.0.8.vec.insert2775 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2682, float %47, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 3
  %mul311.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul311.3, float 0x4024CB5EC0000000)
  %49 = tail call contract noundef float @llvm.exp.f32(float %48)
  %acc_s.sroa.0.12.vec.insert2868 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2775, float %49, i64 3
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %43)
  %51 = insertelement <4 x i16> poison, i16 %50, i64 0
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %45)
  %53 = insertelement <4 x i16> %51, i16 %52, i64 1
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %47)
  %55 = insertelement <4 x i16> %53, i16 %54, i64 2
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %49)
  %57 = insertelement <4 x i16> %55, i16 %56, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %57 to <4 x half>
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end363

if.end363:                                        ; preds = %for.body308.preheader, %if.end297
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end297 ], [ %61, %for.body308.preheader ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end297 ], [ %60, %for.body308.preheader ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end297 ], [ %59, %for.body308.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end297 ], [ %58, %for.body308.preheader ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end297 ], [ %49, %for.body308.preheader ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end297 ], [ %47, %for.body308.preheader ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end297 ], [ %45, %for.body308.preheader ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end297 ], [ %43, %for.body308.preheader ]
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.1, %if.end297 ], [ %acc_s.sroa.0.12.vec.insert2868, %for.body308.preheader ]
  br i1 %or.cond2355, label %if.end395, label %for.cond372.preheader

for.cond372.preheader:                            ; preds = %if.end363
  %mul377 = shl nsw i32 %0, 16
  %62 = shl nsw i32 %cond.i.i2222.2, 10
  %mul379 = and i32 %62, 64512
  %mul384 = shl nuw nsw i32 %18, 3
  %add380 = or disjoint i32 %mul384, %mul377
  %add382 = add nuw nsw i32 %add380, %mul379
  %63 = zext nneg i32 %add382 to i64
  %add.ptr387 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63
  %V_ring0.sroa.0.0.copyload2970 = load <4 x half>, ptr addrspace(4) %add.ptr387, align 16
  %V_ring0.sroa.10.0.add.ptr387.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr387, i64 8
  %V_ring0.sroa.10.0.copyload2973 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr387.sroa_idx, align 8
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63
  %add.ptr387.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024
  %V_ring0.sroa.14.16.copyload2982 = load <4 x half>, ptr addrspace(4) %add.ptr387.1, align 16
  %V_ring0.sroa.22.16.add.ptr387.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032
  %V_ring0.sroa.22.16.copyload2985 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr387.1.sroa_idx, align 8
  br label %if.end395

if.end395:                                        ; preds = %for.cond372.preheader, %if.end363
  %V_ring0.sroa.22.1 = phi <4 x half> [ %V_ring0.sroa.22.0, %if.end363 ], [ %V_ring0.sroa.22.16.copyload2985, %for.cond372.preheader ]
  %V_ring0.sroa.14.1 = phi <4 x half> [ %V_ring0.sroa.14.0, %if.end363 ], [ %V_ring0.sroa.14.16.copyload2982, %for.cond372.preheader ]
  %V_ring0.sroa.10.1 = phi <4 x half> [ %V_ring0.sroa.10.0, %if.end363 ], [ %V_ring0.sroa.10.0.copyload2973, %for.cond372.preheader ]
  %V_ring0.sroa.0.1 = phi <4 x half> [ %V_ring0.sroa.0.0, %if.end363 ], [ %V_ring0.sroa.0.0.copyload2970, %for.cond372.preheader ]
  %or.cond2360 = icmp ugt i32 %mul11.1, 1023
  %brmerge3291 = or i1 %or.cond2360, %cmp106.not
  br i1 %brmerge3291, label %if.end461, label %if.then403

if.then403:                                       ; preds = %if.end395
  %add405 = or disjoint i32 %mul11.1, 15
  %cmp406 = icmp ult i32 %1, %add405
  br i1 %cmp406, label %for.cond408.preheader, label %if.end432

for.cond408.preheader:                            ; preds = %if.then403
  %65 = lshr i32 %18, 2
  %mul414 = and i32 %65, 252
  %add415 = add nuw nsw i32 %mul11.1, %mul414
  %cmp418.not = icmp sgt i32 %add415, %1
  %fneg.2207 = select i1 %cmp418.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2595 = insertelement <4 x float> poison, float %fneg.2207, i64 0
  %cmp418.not.1.not = icmp slt i32 %add415, %1
  %fneg.2207.1 = select i1 %cmp418.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2688 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2595, float %fneg.2207.1, i64 1
  %add416.2 = or disjoint i32 %add415, 2
  %cmp418.not.2 = icmp sgt i32 %add416.2, %1
  %fneg.2207.2 = select i1 %cmp418.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2781 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2688, float %fneg.2207.2, i64 2
  %add416.3 = or disjoint i32 %add415, 3
  %cmp418.not.3 = icmp sgt i32 %add416.3, %1
  %fneg.2207.3 = select i1 %cmp418.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2874 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2781, float %fneg.2207.3, i64 3
  br label %if.end432

if.end432:                                        ; preds = %if.then403, %for.cond408.preheader
  %acc_s.sroa.0.3 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2874, %for.cond408.preheader ], [ zeroinitializer, %if.then403 ]
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.3), !call_argsrelate !84
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %66), !call_argsrelate !84
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %67), !call_argsrelate !84
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %68), !call_argsrelate !84
  br label %if.end461

if.end461:                                        ; preds = %if.end395, %if.end432
  %acc_s.sroa.0.4 = phi <4 x float> [ %69, %if.end432 ], [ %acc_s.sroa.0.2, %if.end395 ]
  %or.cond2361 = icmp ugt i32 %mul11.3, 1023
  %cmp468.not = icmp sgt i32 %mul11.3, %1
  %or.cond2362 = or i1 %or.cond2361, %cmp468.not
  br i1 %or.cond2362, label %if.end493, label %for.cond470.preheader

for.cond470.preheader:                            ; preds = %if.end461
  %mul475 = shl nsw i32 %0, 16
  %70 = shl nsw i32 %cond.i.i2222.3, 10
  %mul477 = and i32 %70, 64512
  %mul482 = shl nuw nsw i32 %18, 3
  %add478 = or disjoint i32 %mul482, %mul475
  %add480 = add nuw nsw i32 %add478, %mul477
  %71 = zext nneg i32 %add480 to i64
  %add.ptr485 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %71
  %K_ring1.sroa.0.0.copyload2994 = load <4 x half>, ptr addrspace(4) %add.ptr485, align 16
  %K_ring1.sroa.10.0.add.ptr485.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr485, i64 8
  %K_ring1.sroa.10.0.copyload2997 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr485.sroa_idx, align 8
  %72 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %71
  %add.ptr485.1 = getelementptr inbounds i8, ptr addrspace(4) %72, i64 1024
  %K_ring1.sroa.14.16.copyload3006 = load <4 x half>, ptr addrspace(4) %add.ptr485.1, align 16
  %K_ring1.sroa.22.16.add.ptr485.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %72, i64 1032
  %K_ring1.sroa.22.16.copyload3009 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr485.1.sroa_idx, align 8
  br label %if.end493

if.end493:                                        ; preds = %for.cond470.preheader, %if.end461
  %K_ring1.sroa.22.1 = phi <4 x half> [ %K_ring1.sroa.22.0, %if.end461 ], [ %K_ring1.sroa.22.16.copyload3009, %for.cond470.preheader ]
  %K_ring1.sroa.14.1 = phi <4 x half> [ %K_ring1.sroa.14.0, %if.end461 ], [ %K_ring1.sroa.14.16.copyload3006, %for.cond470.preheader ]
  %K_ring1.sroa.10.1 = phi <4 x half> [ %K_ring1.sroa.10.0, %if.end461 ], [ %K_ring1.sroa.10.0.copyload2997, %for.cond470.preheader ]
  %K_ring1.sroa.0.1 = phi <4 x half> [ %K_ring1.sroa.0.0, %if.end461 ], [ %K_ring1.sroa.0.0.copyload2994, %for.cond470.preheader ]
  br i1 %or.cond2348, label %if.end559, label %for.body504.preheader

for.body504.preheader:                            ; preds = %if.end493
  %acc_s.sroa.0.0.vec.extract2597 = extractelement <4 x float> %acc_s.sroa.0.4, i64 0
  %mul507 = fmul contract float %acc_s.sroa.0.0.vec.extract2597, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul507, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %acc_s.sroa.0.0.vec.insert2599 = insertelement <4 x float> poison, float %74, i64 0
  %acc_s.sroa.0.4.vec.extract2690 = extractelement <4 x float> %acc_s.sroa.0.4, i64 1
  %mul507.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2690, 0x3FB99999A0000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul507.1, float 0x4024CB5EC0000000)
  %76 = tail call contract noundef float @llvm.exp.f32(float %75)
  %acc_s.sroa.0.4.vec.insert2692 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2599, float %76, i64 1
  %acc_s.sroa.0.8.vec.extract2783 = extractelement <4 x float> %acc_s.sroa.0.4, i64 2
  %mul507.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2783, 0x3FB99999A0000000
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul507.2, float 0x4024CB5EC0000000)
  %78 = tail call contract noundef float @llvm.exp.f32(float %77)
  %acc_s.sroa.0.8.vec.insert2785 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2692, float %78, i64 2
  %acc_s.sroa.0.12.vec.extract2876 = extractelement <4 x float> %acc_s.sroa.0.4, i64 3
  %mul507.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2876, 0x3FB99999A0000000
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul507.3, float 0x4024CB5EC0000000)
  %80 = tail call contract noundef float @llvm.exp.f32(float %79)
  %acc_s.sroa.0.12.vec.insert2878 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2785, float %80, i64 3
  %add523 = fadd contract float %sum_acc.sroa.0.0, %74
  %add523.1 = fadd contract float %sum_acc.sroa.20.0, %76
  %add523.2 = fadd contract float %sum_acc.sroa.38.0, %78
  %add523.3 = fadd contract float %sum_acc.sroa.56.0, %80
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %82 = insertelement <4 x i16> poison, i16 %81, i64 0
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76)
  %84 = insertelement <4 x i16> %82, i16 %83, i64 1
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78)
  %86 = insertelement <4 x i16> %84, i16 %85, i64 2
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80)
  %88 = insertelement <4 x i16> %86, i16 %87, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2550 = bitcast <4 x i16> %88 to <4 x half>
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2550, <4 x float> zeroinitializer)
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2550, <4 x float> zeroinitializer)
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2550, <4 x float> zeroinitializer)
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2550, <4 x float> zeroinitializer)
  br label %if.end559

if.end559:                                        ; preds = %for.body504.preheader, %if.end493
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end493 ], [ %92, %for.body504.preheader ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end493 ], [ %91, %for.body504.preheader ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end493 ], [ %90, %for.body504.preheader ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end493 ], [ %89, %for.body504.preheader ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end493 ], [ %add523.3, %for.body504.preheader ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end493 ], [ %add523.2, %for.body504.preheader ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end493 ], [ %add523.1, %for.body504.preheader ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end493 ], [ %add523, %for.body504.preheader ]
  %acc_s.sroa.0.5 = phi <4 x float> [ %acc_s.sroa.0.4, %if.end493 ], [ %acc_s.sroa.0.12.vec.insert2878, %for.body504.preheader ]
  br i1 %or.cond2362, label %if.end591, label %for.cond568.preheader

for.cond568.preheader:                            ; preds = %if.end559
  %mul573 = shl nsw i32 %0, 16
  %93 = shl nsw i32 %cond.i.i2222.3, 10
  %mul575 = and i32 %93, 64512
  %mul580 = shl nuw nsw i32 %18, 3
  %add576 = or disjoint i32 %mul580, %mul573
  %add578 = add nuw nsw i32 %add576, %mul575
  %94 = zext nneg i32 %add578 to i64
  %add.ptr583 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %94
  %V_ring1.sroa.0.0.copyload2946 = load <4 x half>, ptr addrspace(4) %add.ptr583, align 16
  %V_ring1.sroa.10.0.add.ptr583.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr583, i64 8
  %V_ring1.sroa.10.0.copyload2949 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr583.sroa_idx, align 8
  %95 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %94
  %add.ptr583.1 = getelementptr inbounds i8, ptr addrspace(4) %95, i64 1024
  %V_ring1.sroa.14.16.copyload2958 = load <4 x half>, ptr addrspace(4) %add.ptr583.1, align 16
  %V_ring1.sroa.22.16.add.ptr583.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %95, i64 1032
  %V_ring1.sroa.22.16.copyload2961 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr583.1.sroa_idx, align 8
  br label %if.end591

if.end591:                                        ; preds = %for.cond568.preheader, %if.end559
  %V_ring1.sroa.22.1 = phi <4 x half> [ %V_ring1.sroa.22.0, %if.end559 ], [ %V_ring1.sroa.22.16.copyload2961, %for.cond568.preheader ]
  %V_ring1.sroa.14.1 = phi <4 x half> [ %V_ring1.sroa.14.0, %if.end559 ], [ %V_ring1.sroa.14.16.copyload2958, %for.cond568.preheader ]
  %V_ring1.sroa.10.1 = phi <4 x half> [ %V_ring1.sroa.10.0, %if.end559 ], [ %V_ring1.sroa.10.0.copyload2949, %for.cond568.preheader ]
  %V_ring1.sroa.0.1 = phi <4 x half> [ %V_ring1.sroa.0.0, %if.end559 ], [ %V_ring1.sroa.0.0.copyload2946, %for.cond568.preheader ]
  %or.cond2367 = icmp ugt i32 %mul11.2, 1023
  %brmerge3292 = or i1 %or.cond2367, %cmp272.not
  br i1 %brmerge3292, label %if.end657, label %if.then599

if.then599:                                       ; preds = %if.end591
  %add601 = or disjoint i32 %mul11.2, 15
  %cmp602 = icmp ult i32 %1, %add601
  br i1 %cmp602, label %for.cond604.preheader, label %if.end628

for.cond604.preheader:                            ; preds = %if.then599
  %96 = lshr i32 %18, 2
  %mul610 = and i32 %96, 252
  %add611 = add nuw nsw i32 %mul11.2, %mul610
  %cmp614.not = icmp sgt i32 %add611, %1
  %fneg.2208 = select i1 %cmp614.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2605 = insertelement <4 x float> poison, float %fneg.2208, i64 0
  %cmp614.not.1.not = icmp slt i32 %add611, %1
  %fneg.2208.1 = select i1 %cmp614.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2698 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2605, float %fneg.2208.1, i64 1
  %add612.2 = or disjoint i32 %add611, 2
  %cmp614.not.2 = icmp sgt i32 %add612.2, %1
  %fneg.2208.2 = select i1 %cmp614.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2791 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2698, float %fneg.2208.2, i64 2
  %add612.3 = or disjoint i32 %add611, 3
  %cmp614.not.3 = icmp sgt i32 %add612.3, %1
  %fneg.2208.3 = select i1 %cmp614.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2884 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2791, float %fneg.2208.3, i64 3
  br label %if.end628

if.end628:                                        ; preds = %if.then599, %for.cond604.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2884, %for.cond604.preheader ], [ zeroinitializer, %if.then599 ]
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !84
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %97), !call_argsrelate !84
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %98), !call_argsrelate !84
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %99), !call_argsrelate !84
  br label %if.end657

if.end657:                                        ; preds = %if.end591, %if.end628
  %acc_s.sroa.0.7 = phi <4 x float> [ %100, %if.end628 ], [ %acc_s.sroa.0.5, %if.end591 ]
  %or.cond2368 = icmp ugt i32 %mul11.4, 1023
  %cmp664.not = icmp sgt i32 %mul11.4, %1
  %or.cond2369 = or i1 %or.cond2368, %cmp664.not
  br i1 %or.cond2369, label %if.end689, label %for.cond666.preheader

for.cond666.preheader:                            ; preds = %if.end657
  %mul671 = shl nsw i32 %0, 16
  %101 = shl nsw i32 %cond.i.i2222.4, 10
  %mul673 = and i32 %101, 64512
  %mul678 = shl nuw nsw i32 %18, 3
  %add674 = or disjoint i32 %mul678, %mul671
  %add676 = add nuw nsw i32 %add674, %mul673
  %102 = zext nneg i32 %add676 to i64
  %add.ptr681 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %102
  %K_ring0.sroa.0.0.copyload3019 = load <4 x half>, ptr addrspace(4) %add.ptr681, align 16
  %K_ring0.sroa.10.0.add.ptr681.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr681, i64 8
  %K_ring0.sroa.10.0.copyload3022 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr681.sroa_idx, align 8
  %103 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %102
  %add.ptr681.1 = getelementptr inbounds i8, ptr addrspace(4) %103, i64 1024
  %K_ring0.sroa.14.16.copyload3031 = load <4 x half>, ptr addrspace(4) %add.ptr681.1, align 16
  %K_ring0.sroa.22.16.add.ptr681.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %103, i64 1032
  %K_ring0.sroa.22.16.copyload3034 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr681.1.sroa_idx, align 8
  br label %if.end689

if.end689:                                        ; preds = %for.cond666.preheader, %if.end657
  %K_ring0.sroa.22.2 = phi <4 x half> [ %K_ring0.sroa.22.1, %if.end657 ], [ %K_ring0.sroa.22.16.copyload3034, %for.cond666.preheader ]
  %K_ring0.sroa.14.2 = phi <4 x half> [ %K_ring0.sroa.14.1, %if.end657 ], [ %K_ring0.sroa.14.16.copyload3031, %for.cond666.preheader ]
  %K_ring0.sroa.10.2 = phi <4 x half> [ %K_ring0.sroa.10.1, %if.end657 ], [ %K_ring0.sroa.10.0.copyload3022, %for.cond666.preheader ]
  %K_ring0.sroa.0.2 = phi <4 x half> [ %K_ring0.sroa.0.1, %if.end657 ], [ %K_ring0.sroa.0.0.copyload3019, %for.cond666.preheader ]
  br i1 %or.cond2355, label %if.end755, label %for.body700.preheader

for.body700.preheader:                            ; preds = %if.end689
  %acc_s.sroa.0.0.vec.extract2607 = extractelement <4 x float> %acc_s.sroa.0.7, i64 0
  %mul703 = fmul contract float %acc_s.sroa.0.0.vec.extract2607, 0x3FB99999A0000000
  %104 = tail call contract noundef float @llvm.minnum.f32(float %mul703, float 0x4024CB5EC0000000)
  %105 = tail call contract noundef float @llvm.exp.f32(float %104)
  %acc_s.sroa.0.0.vec.insert2609 = insertelement <4 x float> poison, float %105, i64 0
  %acc_s.sroa.0.4.vec.extract2700 = extractelement <4 x float> %acc_s.sroa.0.7, i64 1
  %mul703.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2700, 0x3FB99999A0000000
  %106 = tail call contract noundef float @llvm.minnum.f32(float %mul703.1, float 0x4024CB5EC0000000)
  %107 = tail call contract noundef float @llvm.exp.f32(float %106)
  %acc_s.sroa.0.4.vec.insert2702 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2609, float %107, i64 1
  %acc_s.sroa.0.8.vec.extract2793 = extractelement <4 x float> %acc_s.sroa.0.7, i64 2
  %mul703.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2793, 0x3FB99999A0000000
  %108 = tail call contract noundef float @llvm.minnum.f32(float %mul703.2, float 0x4024CB5EC0000000)
  %109 = tail call contract noundef float @llvm.exp.f32(float %108)
  %acc_s.sroa.0.8.vec.insert2795 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2702, float %109, i64 2
  %acc_s.sroa.0.12.vec.extract2886 = extractelement <4 x float> %acc_s.sroa.0.7, i64 3
  %mul703.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2886, 0x3FB99999A0000000
  %110 = tail call contract noundef float @llvm.minnum.f32(float %mul703.3, float 0x4024CB5EC0000000)
  %111 = tail call contract noundef float @llvm.exp.f32(float %110)
  %acc_s.sroa.0.12.vec.insert2888 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2795, float %111, i64 3
  %add719 = fadd contract float %sum_acc.sroa.0.1, %105
  %add719.1 = fadd contract float %sum_acc.sroa.20.1, %107
  %add719.2 = fadd contract float %sum_acc.sroa.38.1, %109
  %add719.3 = fadd contract float %sum_acc.sroa.56.1, %111
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %105)
  %113 = insertelement <4 x i16> poison, i16 %112, i64 0
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %107)
  %115 = insertelement <4 x i16> %113, i16 %114, i64 1
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %109)
  %117 = insertelement <4 x i16> %115, i16 %116, i64 2
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %111)
  %119 = insertelement <4 x i16> %117, i16 %118, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2552 = bitcast <4 x i16> %119 to <4 x half>
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2552, <4 x float> %acc_o.sroa.0.0)
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2552, <4 x float> %acc_o.sroa.34.0)
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2552, <4 x float> %acc_o.sroa.66.0)
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2552, <4 x float> %acc_o.sroa.98.0)
  br label %if.end755

if.end755:                                        ; preds = %for.body700.preheader, %if.end689
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end689 ], [ %123, %for.body700.preheader ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end689 ], [ %122, %for.body700.preheader ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end689 ], [ %121, %for.body700.preheader ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end689 ], [ %120, %for.body700.preheader ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end689 ], [ %add719.3, %for.body700.preheader ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end689 ], [ %add719.2, %for.body700.preheader ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end689 ], [ %add719.1, %for.body700.preheader ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end689 ], [ %add719, %for.body700.preheader ]
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.7, %if.end689 ], [ %acc_s.sroa.0.12.vec.insert2888, %for.body700.preheader ]
  br i1 %or.cond2369, label %if.end787, label %for.cond764.preheader

for.cond764.preheader:                            ; preds = %if.end755
  %mul769 = shl nsw i32 %0, 16
  %124 = shl nsw i32 %cond.i.i2222.4, 10
  %mul771 = and i32 %124, 64512
  %mul776 = shl nuw nsw i32 %18, 3
  %add772 = or disjoint i32 %mul776, %mul769
  %add774 = add nuw nsw i32 %add772, %mul771
  %125 = zext nneg i32 %add774 to i64
  %add.ptr779 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125
  %V_ring0.sroa.0.0.copyload2971 = load <4 x half>, ptr addrspace(4) %add.ptr779, align 16
  %V_ring0.sroa.10.0.add.ptr779.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr779, i64 8
  %V_ring0.sroa.10.0.copyload2974 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr779.sroa_idx, align 8
  %126 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125
  %add.ptr779.1 = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1024
  %V_ring0.sroa.14.16.copyload2983 = load <4 x half>, ptr addrspace(4) %add.ptr779.1, align 16
  %V_ring0.sroa.22.16.add.ptr779.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1032
  %V_ring0.sroa.22.16.copyload2986 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr779.1.sroa_idx, align 8
  br label %if.end787

if.end787:                                        ; preds = %for.cond764.preheader, %if.end755
  %V_ring0.sroa.22.2 = phi <4 x half> [ %V_ring0.sroa.22.1, %if.end755 ], [ %V_ring0.sroa.22.16.copyload2986, %for.cond764.preheader ]
  %V_ring0.sroa.14.2 = phi <4 x half> [ %V_ring0.sroa.14.1, %if.end755 ], [ %V_ring0.sroa.14.16.copyload2983, %for.cond764.preheader ]
  %V_ring0.sroa.10.2 = phi <4 x half> [ %V_ring0.sroa.10.1, %if.end755 ], [ %V_ring0.sroa.10.0.copyload2974, %for.cond764.preheader ]
  %V_ring0.sroa.0.2 = phi <4 x half> [ %V_ring0.sroa.0.1, %if.end755 ], [ %V_ring0.sroa.0.0.copyload2971, %for.cond764.preheader ]
  %or.cond2374 = icmp ugt i32 %mul11.3, 1023
  %brmerge3293 = or i1 %or.cond2374, %cmp468.not
  br i1 %brmerge3293, label %if.end853, label %if.then795

if.then795:                                       ; preds = %if.end787
  %add797 = or disjoint i32 %mul11.3, 15
  %cmp798 = icmp ult i32 %1, %add797
  br i1 %cmp798, label %for.cond800.preheader, label %if.end824

for.cond800.preheader:                            ; preds = %if.then795
  %127 = lshr i32 %18, 2
  %mul806 = and i32 %127, 252
  %add807 = add nuw nsw i32 %mul11.3, %mul806
  %cmp810.not = icmp sgt i32 %add807, %1
  %fneg.2209 = select i1 %cmp810.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2615 = insertelement <4 x float> poison, float %fneg.2209, i64 0
  %cmp810.not.1.not = icmp slt i32 %add807, %1
  %fneg.2209.1 = select i1 %cmp810.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2708 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2615, float %fneg.2209.1, i64 1
  %add808.2 = or disjoint i32 %add807, 2
  %cmp810.not.2 = icmp sgt i32 %add808.2, %1
  %fneg.2209.2 = select i1 %cmp810.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2801 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2708, float %fneg.2209.2, i64 2
  %add808.3 = or disjoint i32 %add807, 3
  %cmp810.not.3 = icmp sgt i32 %add808.3, %1
  %fneg.2209.3 = select i1 %cmp810.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2894 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2801, float %fneg.2209.3, i64 3
  br label %if.end824

if.end824:                                        ; preds = %if.then795, %for.cond800.preheader
  %acc_s.sroa.0.9 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2894, %for.cond800.preheader ], [ zeroinitializer, %if.then795 ]
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.9), !call_argsrelate !84
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %128), !call_argsrelate !84
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %129), !call_argsrelate !84
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %130), !call_argsrelate !84
  br label %if.end853

if.end853:                                        ; preds = %if.end787, %if.end824
  %acc_s.sroa.0.10 = phi <4 x float> [ %131, %if.end824 ], [ %acc_s.sroa.0.8, %if.end787 ]
  %or.cond2375 = icmp ugt i32 %mul11.5, 1023
  %cmp860.not = icmp sgt i32 %mul11.5, %1
  %or.cond2376 = or i1 %or.cond2375, %cmp860.not
  br i1 %or.cond2376, label %if.end885, label %for.cond862.preheader

for.cond862.preheader:                            ; preds = %if.end853
  %mul867 = shl nsw i32 %0, 16
  %132 = shl nsw i32 %cond.i.i2222.5, 10
  %mul869 = and i32 %132, 64512
  %mul874 = shl nuw nsw i32 %18, 3
  %add870 = or disjoint i32 %mul874, %mul867
  %add872 = add nuw nsw i32 %add870, %mul869
  %133 = zext nneg i32 %add872 to i64
  %add.ptr877 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %133
  %K_ring1.sroa.0.0.copyload2995 = load <4 x half>, ptr addrspace(4) %add.ptr877, align 16
  %K_ring1.sroa.10.0.add.ptr877.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr877, i64 8
  %K_ring1.sroa.10.0.copyload2998 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr877.sroa_idx, align 8
  %134 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %133
  %add.ptr877.1 = getelementptr inbounds i8, ptr addrspace(4) %134, i64 1024
  %K_ring1.sroa.14.16.copyload3007 = load <4 x half>, ptr addrspace(4) %add.ptr877.1, align 16
  %K_ring1.sroa.22.16.add.ptr877.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %134, i64 1032
  %K_ring1.sroa.22.16.copyload3010 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr877.1.sroa_idx, align 8
  br label %if.end885

if.end885:                                        ; preds = %for.cond862.preheader, %if.end853
  %K_ring1.sroa.22.2 = phi <4 x half> [ %K_ring1.sroa.22.1, %if.end853 ], [ %K_ring1.sroa.22.16.copyload3010, %for.cond862.preheader ]
  %K_ring1.sroa.14.2 = phi <4 x half> [ %K_ring1.sroa.14.1, %if.end853 ], [ %K_ring1.sroa.14.16.copyload3007, %for.cond862.preheader ]
  %K_ring1.sroa.10.2 = phi <4 x half> [ %K_ring1.sroa.10.1, %if.end853 ], [ %K_ring1.sroa.10.0.copyload2998, %for.cond862.preheader ]
  %K_ring1.sroa.0.2 = phi <4 x half> [ %K_ring1.sroa.0.1, %if.end853 ], [ %K_ring1.sroa.0.0.copyload2995, %for.cond862.preheader ]
  br i1 %or.cond2362, label %if.end951, label %for.body896.preheader

for.body896.preheader:                            ; preds = %if.end885
  %acc_s.sroa.0.0.vec.extract2617 = extractelement <4 x float> %acc_s.sroa.0.10, i64 0
  %mul899 = fmul contract float %acc_s.sroa.0.0.vec.extract2617, 0x3FB99999A0000000
  %135 = tail call contract noundef float @llvm.minnum.f32(float %mul899, float 0x4024CB5EC0000000)
  %136 = tail call contract noundef float @llvm.exp.f32(float %135)
  %acc_s.sroa.0.0.vec.insert2619 = insertelement <4 x float> poison, float %136, i64 0
  %acc_s.sroa.0.4.vec.extract2710 = extractelement <4 x float> %acc_s.sroa.0.10, i64 1
  %mul899.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2710, 0x3FB99999A0000000
  %137 = tail call contract noundef float @llvm.minnum.f32(float %mul899.1, float 0x4024CB5EC0000000)
  %138 = tail call contract noundef float @llvm.exp.f32(float %137)
  %acc_s.sroa.0.4.vec.insert2712 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2619, float %138, i64 1
  %acc_s.sroa.0.8.vec.extract2803 = extractelement <4 x float> %acc_s.sroa.0.10, i64 2
  %mul899.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2803, 0x3FB99999A0000000
  %139 = tail call contract noundef float @llvm.minnum.f32(float %mul899.2, float 0x4024CB5EC0000000)
  %140 = tail call contract noundef float @llvm.exp.f32(float %139)
  %acc_s.sroa.0.8.vec.insert2805 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2712, float %140, i64 2
  %acc_s.sroa.0.12.vec.extract2896 = extractelement <4 x float> %acc_s.sroa.0.10, i64 3
  %mul899.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2896, 0x3FB99999A0000000
  %141 = tail call contract noundef float @llvm.minnum.f32(float %mul899.3, float 0x4024CB5EC0000000)
  %142 = tail call contract noundef float @llvm.exp.f32(float %141)
  %acc_s.sroa.0.12.vec.insert2898 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2805, float %142, i64 3
  %add915 = fadd contract float %sum_acc.sroa.0.2, %136
  %add915.1 = fadd contract float %sum_acc.sroa.20.2, %138
  %add915.2 = fadd contract float %sum_acc.sroa.38.2, %140
  %add915.3 = fadd contract float %sum_acc.sroa.56.2, %142
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %136)
  %144 = insertelement <4 x i16> poison, i16 %143, i64 0
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %138)
  %146 = insertelement <4 x i16> %144, i16 %145, i64 1
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %140)
  %148 = insertelement <4 x i16> %146, i16 %147, i64 2
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %142)
  %150 = insertelement <4 x i16> %148, i16 %149, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2554 = bitcast <4 x i16> %150 to <4 x half>
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2554, <4 x float> %acc_o_alt.sroa.0.0)
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2554, <4 x float> %acc_o_alt.sroa.18.0)
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2554, <4 x float> %acc_o_alt.sroa.34.0)
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2554, <4 x float> %acc_o_alt.sroa.50.0)
  br label %if.end951

if.end951:                                        ; preds = %for.body896.preheader, %if.end885
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end885 ], [ %154, %for.body896.preheader ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end885 ], [ %153, %for.body896.preheader ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end885 ], [ %152, %for.body896.preheader ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end885 ], [ %151, %for.body896.preheader ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end885 ], [ %add915.3, %for.body896.preheader ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end885 ], [ %add915.2, %for.body896.preheader ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end885 ], [ %add915.1, %for.body896.preheader ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end885 ], [ %add915, %for.body896.preheader ]
  %acc_s.sroa.0.11 = phi <4 x float> [ %acc_s.sroa.0.10, %if.end885 ], [ %acc_s.sroa.0.12.vec.insert2898, %for.body896.preheader ]
  br i1 %or.cond2376, label %if.end983, label %for.cond960.preheader

for.cond960.preheader:                            ; preds = %if.end951
  %mul965 = shl nsw i32 %0, 16
  %155 = shl nsw i32 %cond.i.i2222.5, 10
  %mul967 = and i32 %155, 64512
  %mul972 = shl nuw nsw i32 %18, 3
  %add968 = or disjoint i32 %mul972, %mul965
  %add970 = add nuw nsw i32 %add968, %mul967
  %156 = zext nneg i32 %add970 to i64
  %add.ptr975 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156
  %V_ring1.sroa.0.0.copyload2947 = load <4 x half>, ptr addrspace(4) %add.ptr975, align 16
  %V_ring1.sroa.10.0.add.ptr975.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr975, i64 8
  %V_ring1.sroa.10.0.copyload2950 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr975.sroa_idx, align 8
  %157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156
  %add.ptr975.1 = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1024
  %V_ring1.sroa.14.16.copyload2959 = load <4 x half>, ptr addrspace(4) %add.ptr975.1, align 16
  %V_ring1.sroa.22.16.add.ptr975.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1032
  %V_ring1.sroa.22.16.copyload2962 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr975.1.sroa_idx, align 8
  br label %if.end983

if.end983:                                        ; preds = %for.cond960.preheader, %if.end951
  %V_ring1.sroa.22.2 = phi <4 x half> [ %V_ring1.sroa.22.1, %if.end951 ], [ %V_ring1.sroa.22.16.copyload2962, %for.cond960.preheader ]
  %V_ring1.sroa.14.2 = phi <4 x half> [ %V_ring1.sroa.14.1, %if.end951 ], [ %V_ring1.sroa.14.16.copyload2959, %for.cond960.preheader ]
  %V_ring1.sroa.10.2 = phi <4 x half> [ %V_ring1.sroa.10.1, %if.end951 ], [ %V_ring1.sroa.10.0.copyload2950, %for.cond960.preheader ]
  %V_ring1.sroa.0.2 = phi <4 x half> [ %V_ring1.sroa.0.1, %if.end951 ], [ %V_ring1.sroa.0.0.copyload2947, %for.cond960.preheader ]
  %or.cond2381 = icmp ugt i32 %mul11.4, 1023
  %brmerge3294 = or i1 %or.cond2381, %cmp664.not
  br i1 %brmerge3294, label %if.end1049, label %if.then991

if.then991:                                       ; preds = %if.end983
  %add993 = or disjoint i32 %mul11.4, 15
  %cmp994 = icmp ult i32 %1, %add993
  br i1 %cmp994, label %for.cond996.preheader, label %if.end1020

for.cond996.preheader:                            ; preds = %if.then991
  %158 = lshr i32 %18, 2
  %mul1002 = and i32 %158, 252
  %add1003 = add nuw nsw i32 %mul11.4, %mul1002
  %cmp1006.not = icmp sgt i32 %add1003, %1
  %fneg.2210 = select i1 %cmp1006.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2625 = insertelement <4 x float> poison, float %fneg.2210, i64 0
  %cmp1006.not.1.not = icmp slt i32 %add1003, %1
  %fneg.2210.1 = select i1 %cmp1006.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2718 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2625, float %fneg.2210.1, i64 1
  %add1004.2 = or disjoint i32 %add1003, 2
  %cmp1006.not.2 = icmp sgt i32 %add1004.2, %1
  %fneg.2210.2 = select i1 %cmp1006.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2811 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2718, float %fneg.2210.2, i64 2
  %add1004.3 = or disjoint i32 %add1003, 3
  %cmp1006.not.3 = icmp sgt i32 %add1004.3, %1
  %fneg.2210.3 = select i1 %cmp1006.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2904 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2811, float %fneg.2210.3, i64 3
  br label %if.end1020

if.end1020:                                       ; preds = %if.then991, %for.cond996.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2904, %for.cond996.preheader ], [ zeroinitializer, %if.then991 ]
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !84
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %159), !call_argsrelate !84
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %160), !call_argsrelate !84
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %161), !call_argsrelate !84
  br label %if.end1049

if.end1049:                                       ; preds = %if.end983, %if.end1020
  %acc_s.sroa.0.13 = phi <4 x float> [ %162, %if.end1020 ], [ %acc_s.sroa.0.11, %if.end983 ]
  %or.cond2382 = icmp ugt i32 %mul11.6, 1023
  %cmp1056.not = icmp sgt i32 %mul11.6, %1
  %or.cond2383 = or i1 %or.cond2382, %cmp1056.not
  br i1 %or.cond2383, label %if.end1081, label %for.cond1058.preheader

for.cond1058.preheader:                           ; preds = %if.end1049
  %mul1063 = shl nsw i32 %0, 16
  %163 = shl nsw i32 %cond.i.i2222.6, 10
  %mul1065 = and i32 %163, 64512
  %mul1070 = shl nuw nsw i32 %18, 3
  %add1066 = or disjoint i32 %mul1070, %mul1063
  %add1068 = add nuw nsw i32 %add1066, %mul1065
  %164 = zext nneg i32 %add1068 to i64
  %add.ptr1073 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %164
  %K_ring0.sroa.0.0.copyload3020 = load <4 x half>, ptr addrspace(4) %add.ptr1073, align 16
  %K_ring0.sroa.10.0.add.ptr1073.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1073, i64 8
  %K_ring0.sroa.10.0.copyload3023 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr1073.sroa_idx, align 8
  %165 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %164
  %add.ptr1073.1 = getelementptr inbounds i8, ptr addrspace(4) %165, i64 1024
  %K_ring0.sroa.14.16.copyload3032 = load <4 x half>, ptr addrspace(4) %add.ptr1073.1, align 16
  %K_ring0.sroa.22.16.add.ptr1073.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %165, i64 1032
  %K_ring0.sroa.22.16.copyload3035 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr1073.1.sroa_idx, align 8
  br label %if.end1081

if.end1081:                                       ; preds = %for.cond1058.preheader, %if.end1049
  %K_ring0.sroa.22.3 = phi <4 x half> [ %K_ring0.sroa.22.2, %if.end1049 ], [ %K_ring0.sroa.22.16.copyload3035, %for.cond1058.preheader ]
  %K_ring0.sroa.14.3 = phi <4 x half> [ %K_ring0.sroa.14.2, %if.end1049 ], [ %K_ring0.sroa.14.16.copyload3032, %for.cond1058.preheader ]
  %K_ring0.sroa.10.3 = phi <4 x half> [ %K_ring0.sroa.10.2, %if.end1049 ], [ %K_ring0.sroa.10.0.copyload3023, %for.cond1058.preheader ]
  %K_ring0.sroa.0.3 = phi <4 x half> [ %K_ring0.sroa.0.2, %if.end1049 ], [ %K_ring0.sroa.0.0.copyload3020, %for.cond1058.preheader ]
  br i1 %or.cond2369, label %if.end1147, label %for.body1092.preheader

for.body1092.preheader:                           ; preds = %if.end1081
  %acc_s.sroa.0.0.vec.extract2627 = extractelement <4 x float> %acc_s.sroa.0.13, i64 0
  %mul1095 = fmul contract float %acc_s.sroa.0.0.vec.extract2627, 0x3FB99999A0000000
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul1095, float 0x4024CB5EC0000000)
  %167 = tail call contract noundef float @llvm.exp.f32(float %166)
  %acc_s.sroa.0.0.vec.insert2629 = insertelement <4 x float> poison, float %167, i64 0
  %acc_s.sroa.0.4.vec.extract2720 = extractelement <4 x float> %acc_s.sroa.0.13, i64 1
  %mul1095.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2720, 0x3FB99999A0000000
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul1095.1, float 0x4024CB5EC0000000)
  %169 = tail call contract noundef float @llvm.exp.f32(float %168)
  %acc_s.sroa.0.4.vec.insert2722 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2629, float %169, i64 1
  %acc_s.sroa.0.8.vec.extract2813 = extractelement <4 x float> %acc_s.sroa.0.13, i64 2
  %mul1095.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2813, 0x3FB99999A0000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul1095.2, float 0x4024CB5EC0000000)
  %171 = tail call contract noundef float @llvm.exp.f32(float %170)
  %acc_s.sroa.0.8.vec.insert2815 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2722, float %171, i64 2
  %acc_s.sroa.0.12.vec.extract2906 = extractelement <4 x float> %acc_s.sroa.0.13, i64 3
  %mul1095.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2906, 0x3FB99999A0000000
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul1095.3, float 0x4024CB5EC0000000)
  %173 = tail call contract noundef float @llvm.exp.f32(float %172)
  %acc_s.sroa.0.12.vec.insert2908 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2815, float %173, i64 3
  %add1111 = fadd contract float %sum_acc.sroa.0.3, %167
  %add1111.1 = fadd contract float %sum_acc.sroa.20.3, %169
  %add1111.2 = fadd contract float %sum_acc.sroa.38.3, %171
  %add1111.3 = fadd contract float %sum_acc.sroa.56.3, %173
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167)
  %175 = insertelement <4 x i16> poison, i16 %174, i64 0
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169)
  %177 = insertelement <4 x i16> %175, i16 %176, i64 1
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171)
  %179 = insertelement <4 x i16> %177, i16 %178, i64 2
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %173)
  %181 = insertelement <4 x i16> %179, i16 %180, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2556 = bitcast <4 x i16> %181 to <4 x half>
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2556, <4 x float> %acc_o.sroa.0.1)
  %183 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2556, <4 x float> %acc_o.sroa.34.1)
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2556, <4 x float> %acc_o.sroa.66.1)
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2556, <4 x float> %acc_o.sroa.98.1)
  br label %if.end1147

if.end1147:                                       ; preds = %for.body1092.preheader, %if.end1081
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end1081 ], [ %185, %for.body1092.preheader ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end1081 ], [ %184, %for.body1092.preheader ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end1081 ], [ %183, %for.body1092.preheader ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1081 ], [ %182, %for.body1092.preheader ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end1081 ], [ %add1111.3, %for.body1092.preheader ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end1081 ], [ %add1111.2, %for.body1092.preheader ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end1081 ], [ %add1111.1, %for.body1092.preheader ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end1081 ], [ %add1111, %for.body1092.preheader ]
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.13, %if.end1081 ], [ %acc_s.sroa.0.12.vec.insert2908, %for.body1092.preheader ]
  br i1 %or.cond2383, label %if.end1179, label %for.cond1156.preheader

for.cond1156.preheader:                           ; preds = %if.end1147
  %mul1161 = shl nsw i32 %0, 16
  %186 = shl nsw i32 %cond.i.i2222.6, 10
  %mul1163 = and i32 %186, 64512
  %mul1168 = shl nuw nsw i32 %18, 3
  %add1164 = or disjoint i32 %mul1168, %mul1161
  %add1166 = add nuw nsw i32 %add1164, %mul1163
  %187 = zext nneg i32 %add1166 to i64
  %add.ptr1171 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %187
  %V_ring0.sroa.0.0.copyload2972 = load <4 x half>, ptr addrspace(4) %add.ptr1171, align 16
  %V_ring0.sroa.10.0.add.ptr1171.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1171, i64 8
  %V_ring0.sroa.10.0.copyload2975 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr1171.sroa_idx, align 8
  %188 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %187
  %add.ptr1171.1 = getelementptr inbounds i8, ptr addrspace(4) %188, i64 1024
  %V_ring0.sroa.14.16.copyload2984 = load <4 x half>, ptr addrspace(4) %add.ptr1171.1, align 16
  %V_ring0.sroa.22.16.add.ptr1171.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %188, i64 1032
  %V_ring0.sroa.22.16.copyload2987 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr1171.1.sroa_idx, align 8
  br label %if.end1179

if.end1179:                                       ; preds = %for.cond1156.preheader, %if.end1147
  %V_ring0.sroa.22.3 = phi <4 x half> [ %V_ring0.sroa.22.2, %if.end1147 ], [ %V_ring0.sroa.22.16.copyload2987, %for.cond1156.preheader ]
  %V_ring0.sroa.14.3 = phi <4 x half> [ %V_ring0.sroa.14.2, %if.end1147 ], [ %V_ring0.sroa.14.16.copyload2984, %for.cond1156.preheader ]
  %V_ring0.sroa.10.3 = phi <4 x half> [ %V_ring0.sroa.10.2, %if.end1147 ], [ %V_ring0.sroa.10.0.copyload2975, %for.cond1156.preheader ]
  %V_ring0.sroa.0.3 = phi <4 x half> [ %V_ring0.sroa.0.2, %if.end1147 ], [ %V_ring0.sroa.0.0.copyload2972, %for.cond1156.preheader ]
  %or.cond2388 = icmp ugt i32 %mul11.5, 1023
  %brmerge3295 = or i1 %or.cond2388, %cmp860.not
  br i1 %brmerge3295, label %if.end1245, label %if.then1187

if.then1187:                                      ; preds = %if.end1179
  %add1189 = or disjoint i32 %mul11.5, 15
  %cmp1190 = icmp ult i32 %1, %add1189
  br i1 %cmp1190, label %for.cond1192.preheader, label %if.end1216

for.cond1192.preheader:                           ; preds = %if.then1187
  %189 = lshr i32 %18, 2
  %mul1198 = and i32 %189, 252
  %add1199 = add nuw nsw i32 %mul11.5, %mul1198
  %cmp1202.not = icmp sgt i32 %add1199, %1
  %fneg.2211 = select i1 %cmp1202.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2635 = insertelement <4 x float> poison, float %fneg.2211, i64 0
  %cmp1202.not.1.not = icmp slt i32 %add1199, %1
  %fneg.2211.1 = select i1 %cmp1202.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2728 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2635, float %fneg.2211.1, i64 1
  %add1200.2 = or disjoint i32 %add1199, 2
  %cmp1202.not.2 = icmp sgt i32 %add1200.2, %1
  %fneg.2211.2 = select i1 %cmp1202.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2821 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2728, float %fneg.2211.2, i64 2
  %add1200.3 = or disjoint i32 %add1199, 3
  %cmp1202.not.3 = icmp sgt i32 %add1200.3, %1
  %fneg.2211.3 = select i1 %cmp1202.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2914 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2821, float %fneg.2211.3, i64 3
  br label %if.end1216

if.end1216:                                       ; preds = %if.then1187, %for.cond1192.preheader
  %acc_s.sroa.0.15 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2914, %for.cond1192.preheader ], [ zeroinitializer, %if.then1187 ]
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.15), !call_argsrelate !84
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %190), !call_argsrelate !84
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %191), !call_argsrelate !84
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %192), !call_argsrelate !84
  br label %if.end1245

if.end1245:                                       ; preds = %if.end1179, %if.end1216
  %acc_s.sroa.0.16 = phi <4 x float> [ %193, %if.end1216 ], [ %acc_s.sroa.0.14, %if.end1179 ]
  %or.cond2389 = icmp ugt i32 %mul11.7, 1023
  %cmp1252.not = icmp sgt i32 %mul11.7, %1
  %or.cond2390 = or i1 %or.cond2389, %cmp1252.not
  br i1 %or.cond2390, label %if.end1277, label %for.cond1254.preheader

for.cond1254.preheader:                           ; preds = %if.end1245
  %mul1259 = shl nsw i32 %0, 16
  %194 = shl nsw i32 %cond.i.i2222.7, 10
  %mul1261 = and i32 %194, 64512
  %mul1266 = shl nuw nsw i32 %18, 3
  %add1262 = or disjoint i32 %mul1266, %mul1259
  %add1264 = add nuw nsw i32 %add1262, %mul1261
  %195 = zext nneg i32 %add1264 to i64
  %add.ptr1269 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %195
  %K_ring1.sroa.0.0.copyload2996 = load <4 x half>, ptr addrspace(4) %add.ptr1269, align 16
  %K_ring1.sroa.10.0.add.ptr1269.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1269, i64 8
  %K_ring1.sroa.10.0.copyload2999 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr1269.sroa_idx, align 8
  %196 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %195
  %add.ptr1269.1 = getelementptr inbounds i8, ptr addrspace(4) %196, i64 1024
  %K_ring1.sroa.14.16.copyload3008 = load <4 x half>, ptr addrspace(4) %add.ptr1269.1, align 16
  %K_ring1.sroa.22.16.add.ptr1269.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %196, i64 1032
  %K_ring1.sroa.22.16.copyload3011 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr1269.1.sroa_idx, align 8
  br label %if.end1277

if.end1277:                                       ; preds = %for.cond1254.preheader, %if.end1245
  %K_ring1.sroa.22.3 = phi <4 x half> [ %K_ring1.sroa.22.2, %if.end1245 ], [ %K_ring1.sroa.22.16.copyload3011, %for.cond1254.preheader ]
  %K_ring1.sroa.14.3 = phi <4 x half> [ %K_ring1.sroa.14.2, %if.end1245 ], [ %K_ring1.sroa.14.16.copyload3008, %for.cond1254.preheader ]
  %K_ring1.sroa.10.3 = phi <4 x half> [ %K_ring1.sroa.10.2, %if.end1245 ], [ %K_ring1.sroa.10.0.copyload2999, %for.cond1254.preheader ]
  %K_ring1.sroa.0.3 = phi <4 x half> [ %K_ring1.sroa.0.2, %if.end1245 ], [ %K_ring1.sroa.0.0.copyload2996, %for.cond1254.preheader ]
  br i1 %or.cond2376, label %if.end1343, label %for.body1288.preheader

for.body1288.preheader:                           ; preds = %if.end1277
  %acc_s.sroa.0.0.vec.extract2637 = extractelement <4 x float> %acc_s.sroa.0.16, i64 0
  %mul1291 = fmul contract float %acc_s.sroa.0.0.vec.extract2637, 0x3FB99999A0000000
  %197 = tail call contract noundef float @llvm.minnum.f32(float %mul1291, float 0x4024CB5EC0000000)
  %198 = tail call contract noundef float @llvm.exp.f32(float %197)
  %acc_s.sroa.0.4.vec.extract2730 = extractelement <4 x float> %acc_s.sroa.0.16, i64 1
  %mul1291.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2730, 0x3FB99999A0000000
  %199 = tail call contract noundef float @llvm.minnum.f32(float %mul1291.1, float 0x4024CB5EC0000000)
  %200 = tail call contract noundef float @llvm.exp.f32(float %199)
  %acc_s.sroa.0.8.vec.extract2823 = extractelement <4 x float> %acc_s.sroa.0.16, i64 2
  %mul1291.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2823, 0x3FB99999A0000000
  %201 = tail call contract noundef float @llvm.minnum.f32(float %mul1291.2, float 0x4024CB5EC0000000)
  %202 = tail call contract noundef float @llvm.exp.f32(float %201)
  %acc_s.sroa.0.12.vec.extract2916 = extractelement <4 x float> %acc_s.sroa.0.16, i64 3
  %mul1291.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2916, 0x3FB99999A0000000
  %203 = tail call contract noundef float @llvm.minnum.f32(float %mul1291.3, float 0x4024CB5EC0000000)
  %204 = tail call contract noundef float @llvm.exp.f32(float %203)
  %add1307 = fadd contract float %sum_acc.sroa.0.4, %198
  %add1307.1 = fadd contract float %sum_acc.sroa.20.4, %200
  %add1307.2 = fadd contract float %sum_acc.sroa.38.4, %202
  %add1307.3 = fadd contract float %sum_acc.sroa.56.4, %204
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %198)
  %206 = insertelement <4 x i16> poison, i16 %205, i64 0
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %200)
  %208 = insertelement <4 x i16> %206, i16 %207, i64 1
  %209 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %202)
  %210 = insertelement <4 x i16> %208, i16 %209, i64 2
  %211 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %204)
  %212 = insertelement <4 x i16> %210, i16 %211, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2558 = bitcast <4 x i16> %212 to <4 x half>
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2558, <4 x float> %acc_o_alt.sroa.0.1)
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2558, <4 x float> %acc_o_alt.sroa.18.1)
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2558, <4 x float> %acc_o_alt.sroa.34.1)
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2558, <4 x float> %acc_o_alt.sroa.50.1)
  br label %if.end1343

if.end1343:                                       ; preds = %for.body1288.preheader, %if.end1277
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1277 ], [ %216, %for.body1288.preheader ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end1277 ], [ %215, %for.body1288.preheader ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end1277 ], [ %214, %for.body1288.preheader ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1277 ], [ %213, %for.body1288.preheader ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end1277 ], [ %add1307.3, %for.body1288.preheader ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end1277 ], [ %add1307.2, %for.body1288.preheader ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end1277 ], [ %add1307.1, %for.body1288.preheader ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end1277 ], [ %add1307, %for.body1288.preheader ]
  br i1 %or.cond2390, label %if.end1375, label %for.cond1352.preheader

for.cond1352.preheader:                           ; preds = %if.end1343
  %mul1357 = shl nsw i32 %0, 16
  %217 = shl nsw i32 %cond.i.i2222.7, 10
  %mul1359 = and i32 %217, 64512
  %mul1364 = shl nuw nsw i32 %18, 3
  %add1360 = or disjoint i32 %mul1364, %mul1357
  %add1362 = add nuw nsw i32 %add1360, %mul1359
  %218 = zext nneg i32 %add1362 to i64
  %add.ptr1367 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218
  %V_ring1.sroa.0.0.copyload2948 = load <4 x half>, ptr addrspace(4) %add.ptr1367, align 16
  %V_ring1.sroa.10.0.add.ptr1367.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1367, i64 8
  %V_ring1.sroa.10.0.copyload2951 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr1367.sroa_idx, align 8
  %219 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218
  %add.ptr1367.1 = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1024
  %V_ring1.sroa.14.16.copyload2960 = load <4 x half>, ptr addrspace(4) %add.ptr1367.1, align 16
  %V_ring1.sroa.22.16.add.ptr1367.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1032
  %V_ring1.sroa.22.16.copyload2963 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr1367.1.sroa_idx, align 8
  br label %if.end1375

if.end1375:                                       ; preds = %for.cond1352.preheader, %if.end1343
  %V_ring1.sroa.22.3 = phi <4 x half> [ %V_ring1.sroa.22.2, %if.end1343 ], [ %V_ring1.sroa.22.16.copyload2963, %for.cond1352.preheader ]
  %V_ring1.sroa.14.3 = phi <4 x half> [ %V_ring1.sroa.14.2, %if.end1343 ], [ %V_ring1.sroa.14.16.copyload2960, %for.cond1352.preheader ]
  %V_ring1.sroa.10.3 = phi <4 x half> [ %V_ring1.sroa.10.2, %if.end1343 ], [ %V_ring1.sroa.10.0.copyload2951, %for.cond1352.preheader ]
  %V_ring1.sroa.0.3 = phi <4 x half> [ %V_ring1.sroa.0.2, %if.end1343 ], [ %V_ring1.sroa.0.0.copyload2948, %for.cond1352.preheader ]
  %or.cond2395 = icmp ult i32 %mul11.6, 1024
  br i1 %or.cond2395, label %land.lhs.true1380, label %if.end1499

land.lhs.true1380:                                ; preds = %if.end1375
  br i1 %cmp1056.not, label %if.end1499, label %if.then1383

if.then1383:                                      ; preds = %land.lhs.true1380
  %add1385 = or disjoint i32 %mul11.6, 15
  %cmp1386 = icmp ult i32 %1, %add1385
  br i1 %cmp1386, label %for.cond1388.preheader, label %if.end1412

for.cond1388.preheader:                           ; preds = %if.then1383
  %220 = lshr i32 %18, 2
  %mul1394 = and i32 %220, 252
  %add1395 = add nuw nsw i32 %mul11.6, %mul1394
  %cmp1398.not = icmp sgt i32 %add1395, %1
  %fneg.2212 = select i1 %cmp1398.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2645 = insertelement <4 x float> poison, float %fneg.2212, i64 0
  %cmp1398.not.1.not = icmp slt i32 %add1395, %1
  %fneg.2212.1 = select i1 %cmp1398.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2738 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2645, float %fneg.2212.1, i64 1
  %add1396.2 = or disjoint i32 %add1395, 2
  %cmp1398.not.2 = icmp sgt i32 %add1396.2, %1
  %fneg.2212.2 = select i1 %cmp1398.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2831 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2738, float %fneg.2212.2, i64 2
  %add1396.3 = or disjoint i32 %add1395, 3
  %cmp1398.not.3 = icmp sgt i32 %add1396.3, %1
  %fneg.2212.3 = select i1 %cmp1398.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2924 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2831, float %fneg.2212.3, i64 3
  br label %if.end1412

if.end1412:                                       ; preds = %if.then1383, %for.cond1388.preheader
  %acc_s.sroa.0.18 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2924, %for.cond1388.preheader ], [ zeroinitializer, %if.then1383 ]
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.18), !call_argsrelate !84
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %221), !call_argsrelate !84
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %222), !call_argsrelate !84
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %223), !call_argsrelate !84
  %acc_s.sroa.0.0.vec.extract2647 = extractelement <4 x float> %224, i64 0
  %mul1447 = fmul contract float %acc_s.sroa.0.0.vec.extract2647, 0x3FB99999A0000000
  %225 = tail call contract noundef float @llvm.minnum.f32(float %mul1447, float 0x4024CB5EC0000000)
  %226 = tail call contract noundef float @llvm.exp.f32(float %225)
  %acc_s.sroa.0.4.vec.extract2740 = extractelement <4 x float> %224, i64 1
  %mul1447.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2740, 0x3FB99999A0000000
  %227 = tail call contract noundef float @llvm.minnum.f32(float %mul1447.1, float 0x4024CB5EC0000000)
  %228 = tail call contract noundef float @llvm.exp.f32(float %227)
  %acc_s.sroa.0.8.vec.extract2833 = extractelement <4 x float> %224, i64 2
  %mul1447.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2833, 0x3FB99999A0000000
  %229 = tail call contract noundef float @llvm.minnum.f32(float %mul1447.2, float 0x4024CB5EC0000000)
  %230 = tail call contract noundef float @llvm.exp.f32(float %229)
  %acc_s.sroa.0.12.vec.extract2926 = extractelement <4 x float> %224, i64 3
  %mul1447.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2926, 0x3FB99999A0000000
  %231 = tail call contract noundef float @llvm.minnum.f32(float %mul1447.3, float 0x4024CB5EC0000000)
  %232 = tail call contract noundef float @llvm.exp.f32(float %231)
  %add1463 = fadd contract float %sum_acc.sroa.0.5, %226
  %add1463.1 = fadd contract float %sum_acc.sroa.20.5, %228
  %add1463.2 = fadd contract float %sum_acc.sroa.38.5, %230
  %add1463.3 = fadd contract float %sum_acc.sroa.56.5, %232
  %233 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %226)
  %234 = insertelement <4 x i16> poison, i16 %233, i64 0
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %228)
  %236 = insertelement <4 x i16> %234, i16 %235, i64 1
  %237 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %230)
  %238 = insertelement <4 x i16> %236, i16 %237, i64 2
  %239 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %232)
  %240 = insertelement <4 x i16> %238, i16 %239, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2560 = bitcast <4 x i16> %240 to <4 x half>
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2560, <4 x float> %acc_o.sroa.0.2)
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2560, <4 x float> %acc_o.sroa.34.2)
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2560, <4 x float> %acc_o.sroa.66.2)
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2560, <4 x float> %acc_o.sroa.98.2)
  br label %if.end1499

if.end1499:                                       ; preds = %if.end1412, %land.lhs.true1380, %if.end1375
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %land.lhs.true1380 ], [ %244, %if.end1412 ], [ %acc_o.sroa.98.2, %if.end1375 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %land.lhs.true1380 ], [ %243, %if.end1412 ], [ %acc_o.sroa.66.2, %if.end1375 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %land.lhs.true1380 ], [ %242, %if.end1412 ], [ %acc_o.sroa.34.2, %if.end1375 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %land.lhs.true1380 ], [ %241, %if.end1412 ], [ %acc_o.sroa.0.2, %if.end1375 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true1380 ], [ %add1463.3, %if.end1412 ], [ %sum_acc.sroa.56.5, %if.end1375 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true1380 ], [ %add1463.2, %if.end1412 ], [ %sum_acc.sroa.38.5, %if.end1375 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true1380 ], [ %add1463.1, %if.end1412 ], [ %sum_acc.sroa.20.5, %if.end1375 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true1380 ], [ %add1463, %if.end1412 ], [ %sum_acc.sroa.0.5, %if.end1375 ]
  %or.cond2396 = icmp ult i32 %mul11.7, 1024
  br i1 %or.cond2396, label %land.lhs.true1504, label %if.end1623

land.lhs.true1504:                                ; preds = %if.end1499
  br i1 %cmp1252.not, label %if.end1623, label %if.then1507

if.then1507:                                      ; preds = %land.lhs.true1504
  %add1509 = or disjoint i32 %mul11.7, 15
  %cmp1510 = icmp slt i32 %1, %add1509
  br i1 %cmp1510, label %for.cond1512.preheader, label %if.end1536

for.cond1512.preheader:                           ; preds = %if.then1507
  %245 = lshr i32 %18, 2
  %mul1518 = and i32 %245, 252
  %add1519 = add nuw nsw i32 %mul11.7, %mul1518
  %cmp1522.not = icmp sgt i32 %add1519, %1
  %fneg.2213 = select i1 %cmp1522.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2655 = insertelement <4 x float> poison, float %fneg.2213, i64 0
  %cmp1522.not.1.not = icmp slt i32 %add1519, %1
  %fneg.2213.1 = select i1 %cmp1522.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2748 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2655, float %fneg.2213.1, i64 1
  %add1520.2 = or disjoint i32 %add1519, 2
  %cmp1522.not.2 = icmp sgt i32 %add1520.2, %1
  %fneg.2213.2 = select i1 %cmp1522.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2841 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2748, float %fneg.2213.2, i64 2
  %add1520.3 = or disjoint i32 %add1519, 3
  %cmp1522.not.3 = icmp sgt i32 %add1520.3, %1
  %fneg.2213.3 = select i1 %cmp1522.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2934 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2841, float %fneg.2213.3, i64 3
  br label %if.end1536

if.end1536:                                       ; preds = %if.then1507, %for.cond1512.preheader
  %acc_s.sroa.0.20 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2934, %for.cond1512.preheader ], [ zeroinitializer, %if.then1507 ]
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.20), !call_argsrelate !84
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %246), !call_argsrelate !84
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %247), !call_argsrelate !84
  %249 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %248), !call_argsrelate !84
  %acc_s.sroa.0.0.vec.extract2657 = extractelement <4 x float> %249, i64 0
  %mul1571 = fmul contract float %acc_s.sroa.0.0.vec.extract2657, 0x3FB99999A0000000
  %250 = tail call contract noundef float @llvm.minnum.f32(float %mul1571, float 0x4024CB5EC0000000)
  %251 = tail call contract noundef float @llvm.exp.f32(float %250)
  %acc_s.sroa.0.4.vec.extract2750 = extractelement <4 x float> %249, i64 1
  %mul1571.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2750, 0x3FB99999A0000000
  %252 = tail call contract noundef float @llvm.minnum.f32(float %mul1571.1, float 0x4024CB5EC0000000)
  %253 = tail call contract noundef float @llvm.exp.f32(float %252)
  %acc_s.sroa.0.8.vec.extract2843 = extractelement <4 x float> %249, i64 2
  %mul1571.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2843, 0x3FB99999A0000000
  %254 = tail call contract noundef float @llvm.minnum.f32(float %mul1571.2, float 0x4024CB5EC0000000)
  %255 = tail call contract noundef float @llvm.exp.f32(float %254)
  %acc_s.sroa.0.12.vec.extract2936 = extractelement <4 x float> %249, i64 3
  %mul1571.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2936, 0x3FB99999A0000000
  %256 = tail call contract noundef float @llvm.minnum.f32(float %mul1571.3, float 0x4024CB5EC0000000)
  %257 = tail call contract noundef float @llvm.exp.f32(float %256)
  %add1587 = fadd contract float %sum_acc.sroa.0.6, %251
  %add1587.1 = fadd contract float %sum_acc.sroa.20.6, %253
  %add1587.2 = fadd contract float %sum_acc.sroa.38.6, %255
  %add1587.3 = fadd contract float %sum_acc.sroa.56.6, %257
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %251)
  %259 = insertelement <4 x i16> poison, i16 %258, i64 0
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %253)
  %261 = insertelement <4 x i16> %259, i16 %260, i64 1
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %255)
  %263 = insertelement <4 x i16> %261, i16 %262, i64 2
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %257)
  %265 = insertelement <4 x i16> %263, i16 %264, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2562 = bitcast <4 x i16> %265 to <4 x half>
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2562, <4 x float> %acc_o_alt.sroa.0.2)
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2562, <4 x float> %acc_o_alt.sroa.18.2)
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2562, <4 x float> %acc_o_alt.sroa.34.2)
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2562, <4 x float> %acc_o_alt.sroa.50.2)
  br label %if.end1623

if.end1623:                                       ; preds = %if.end1536, %land.lhs.true1504, %if.end1499
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %land.lhs.true1504 ], [ %269, %if.end1536 ], [ %acc_o_alt.sroa.50.2, %if.end1499 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %land.lhs.true1504 ], [ %268, %if.end1536 ], [ %acc_o_alt.sroa.34.2, %if.end1499 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %land.lhs.true1504 ], [ %267, %if.end1536 ], [ %acc_o_alt.sroa.18.2, %if.end1499 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %land.lhs.true1504 ], [ %266, %if.end1536 ], [ %acc_o_alt.sroa.0.2, %if.end1499 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1504 ], [ %add1587.3, %if.end1536 ], [ %sum_acc.sroa.56.6, %if.end1499 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1504 ], [ %add1587.2, %if.end1536 ], [ %sum_acc.sroa.38.6, %if.end1499 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1504 ], [ %add1587.1, %if.end1536 ], [ %sum_acc.sroa.20.6, %if.end1499 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1504 ], [ %add1587, %if.end1536 ], [ %sum_acc.sroa.0.6, %if.end1499 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add1632 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add1632.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add1632.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add1632.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add1632.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add1632.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add1632.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add1632.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add1632.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add1632.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add1632.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add1632.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add1632.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add1632.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add1632.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add1632.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add1646 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1646.1 = fadd contract float %add1646, %sum_acc.sroa.20.7
  %add1646.2 = fadd contract float %add1646.1, %sum_acc.sroa.38.7
  %add1646.3 = fadd contract float %add1646.2, %sum_acc.sroa.56.7
  %270 = bitcast float %add1646.3 to i32
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11
  %xor.i.i = xor i32 %272, 32
  %273 = and i32 %272, -64
  %and.i.i = add nsw i32 %273, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2223 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %272
  %shl.i.i = shl i32 %cond.i.i2223, 2
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %270)
  %275 = bitcast i32 %274 to float
  %add.i = fadd contract float %add1646.3, %275
  %276 = bitcast float %add.i to i32
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11
  %xor.i.i2224 = xor i32 %278, 16
  %279 = and i32 %278, -64
  %and.i.i2225 = add nsw i32 %279, 64
  %cmp.not.i.i2226 = icmp slt i32 %xor.i.i2224, %and.i.i2225
  %cond.i.i2227 = select i1 %cmp.not.i.i2226, i32 %xor.i.i2224, i32 %278
  %shl.i.i2228 = shl i32 %cond.i.i2227, 2
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2228, i32 %276)
  %281 = bitcast i32 %280 to float
  %add.i.i = fadd contract float %add.i, %281
  %cmp1655 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp1655, float %div, float 0.000000e+00
  %mul1668 = fmul contract float %condval_8.0, %add1632
  %mul1668.1 = fmul contract float %condval_8.0, %add1632.1
  %mul1668.2 = fmul contract float %condval_8.0, %add1632.2
  %mul1668.3 = fmul contract float %condval_8.0, %add1632.3
  %mul1668.4 = fmul contract float %condval_8.0, %add1632.4
  %mul1668.5 = fmul contract float %condval_8.0, %add1632.5
  %mul1668.6 = fmul contract float %condval_8.0, %add1632.6
  %mul1668.7 = fmul contract float %condval_8.0, %add1632.7
  %mul1668.8 = fmul contract float %condval_8.0, %add1632.8
  %mul1668.9 = fmul contract float %condval_8.0, %add1632.9
  %mul1668.10 = fmul contract float %condval_8.0, %add1632.10
  %mul1668.11 = fmul contract float %condval_8.0, %add1632.11
  %mul1668.12 = fmul contract float %condval_8.0, %add1632.12
  %mul1668.13 = fmul contract float %condval_8.0, %add1632.13
  %mul1668.14 = fmul contract float %condval_8.0, %add1632.14
  %mul1668.15 = fmul contract float %condval_8.0, %add1632.15
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668)
  %O_reg.sroa.0.0.insert.ext = zext i16 %282 to i64
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %283 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %284 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %286 to i64
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %287 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %288 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %290 to i64
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %291 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %292 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %293 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %294 to i64
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %295 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %296 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1668.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %297 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1710 = lshr i32 %18, 5
  %and1713 = and i32 %18, 7
  %298 = lshr i32 %18, 2
  %mul1719 = and i32 %298, 4
  %xor = xor i32 %shr1710, %and1713
  %mul1714 = shl nuw nsw i32 %xor, 3
  %add1715 = add nuw nsw i32 %mul1714, %mul25
  %add1720 = or disjoint i32 %add1715, %mul1719
  %add.ptr1722 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1720
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1722, align 8
  %add1711.1 = add nuw nsw i32 %shr1710, 2
  %xor.1 = xor i32 %add1711.1, %and1713
  %mul1714.1 = shl nuw nsw i32 %xor.1, 3
  %add1715.1 = add nuw nsw i32 %mul1714.1, %mul25
  %add1720.1 = or disjoint i32 %add1715.1, %mul1719
  %add.ptr1722.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1720.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1722.1, align 8
  %add1711.2 = add nuw nsw i32 %shr1710, 4
  %xor.2 = xor i32 %add1711.2, %and1713
  %mul1714.2 = shl nuw nsw i32 %xor.2, 3
  %add1715.2 = add nuw nsw i32 %mul1714.2, %mul25
  %add1720.2 = or disjoint i32 %add1715.2, %mul1719
  %add.ptr1722.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1720.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1722.2, align 8
  %add1711.3 = add nuw nsw i32 %shr1710, 6
  %xor.3 = xor i32 %add1711.3, %and1713
  %mul1714.3 = shl nuw nsw i32 %xor.3, 3
  %add1715.3 = add nuw nsw i32 %mul1714.3, %mul25
  %add1720.3 = or disjoint i32 %add1715.3, %mul1719
  %add.ptr1722.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1720.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1722.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %299 = shl nuw nsw i32 %18, 3
  %mul1733 = and i32 %299, 8128
  %xor17392205 = and i32 %299, 56
  %call1737.masked = and i32 %18, 1016
  %mul1740 = xor i32 %xor17392205, %call1737.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1733
  %invariant.gep2343 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1740
  %add1750 = add nuw nsw i32 %add23, %299
  %300 = zext nneg i32 %add1750 to i64
  %add.ptr1755 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1755, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2343, i64 16, i1 false), !tbaa.struct !397, !call_argsrelate !398
  %gep2344.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2343, i32 1024
  %301 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  %add.ptr1755.1 = getelementptr inbounds i8, ptr addrspace(1) %301, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1755.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2344.1, i64 16, i1 false), !tbaa.struct !397, !call_argsrelate !398
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


