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
  %cond.i.i2150 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2150, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2150.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2150.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2150.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2150.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2150.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2150.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2150.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2150.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2150.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2150.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2150.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2150.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2150.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2150.7, 4
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
  %or.cond2274 = or i1 %or.cond, %cmp75.not
  br i1 %or.cond2274, label %if.end, label %for.cond76.preheader

for.cond76.preheader:                             ; preds = %entry
  %mul82 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2150, 10
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
  %or.cond2275 = icmp ugt i32 %mul11.1, 1023
  %cmp106.not = icmp sgt i32 %mul11.1, %1
  %or.cond2276 = or i1 %or.cond2275, %cmp106.not
  br i1 %or.cond2276, label %if.end132, label %for.cond108.preheader

for.cond108.preheader:                            ; preds = %if.end
  %mul114 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2150.1, 10
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
  br i1 %or.cond2274, label %if.end165, label %for.cond141.preheader

for.cond141.preheader:                            ; preds = %if.end132
  %mul147 = shl nsw i32 %0, 16
  %28 = shl nsw i32 %cond.i.i2150, 10
  %mul149 = and i32 %28, 64512
  %mul154 = shl nuw nsw i32 %18, 3
  %add150 = or disjoint i32 %mul154, %mul147
  %add152 = add nuw nsw i32 %add150, %mul149
  %29 = zext nneg i32 %add152 to i64
  %add.ptr157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %29
  %V_ring0.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157, align 16
  %V_ring0.sroa.18.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr157, i64 8
  %V_ring0.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr157.sroa_idx, align 8
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %29
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1024
  %V_ring0.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157.1, align 16
  %V_ring0.sroa.42.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032
  %V_ring0.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr157.1.sroa_idx, align 8
  br label %if.end165

if.end165:                                        ; preds = %for.cond141.preheader, %if.end132
  %V_ring0.sroa.42.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.42.16.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.26.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.26.16.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.18.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.18.0.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.0.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.0.0.copyload, %for.cond141.preheader ]
  %or.cond2279 = icmp ult i32 %mul11, 1024
  br i1 %or.cond2279, label %land.lhs.true170, label %if.end290

land.lhs.true170:                                 ; preds = %if.end165
  br i1 %cmp75.not, label %if.end290, label %if.then173

if.then173:                                       ; preds = %land.lhs.true170
  %add175 = or disjoint i32 %mul11, 15
  %cmp176 = icmp ult i32 %1, %add175
  br i1 %cmp176, label %for.cond178.preheader, label %if.end202

for.cond178.preheader:                            ; preds = %if.then173
  %31 = lshr i32 %18, 2
  %mul185 = and i32 %31, 252
  %add186 = add nuw nsw i32 %mul11, %mul185
  %cmp189.not = icmp sgt i32 %add186, %1
  %fneg. = select i1 %cmp189.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2502 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp189.not.1.not = icmp slt i32 %add186, %1
  %fneg..1 = select i1 %cmp189.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2595 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2502, float %fneg..1, i64 1
  %add187.2 = or disjoint i32 %add186, 2
  %cmp189.not.2 = icmp sgt i32 %add187.2, %1
  %fneg..2 = select i1 %cmp189.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2688 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2595, float %fneg..2, i64 2
  %add187.3 = or disjoint i32 %add186, 3
  %cmp189.not.3 = icmp sgt i32 %add187.3, %1
  %fneg..3 = select i1 %cmp189.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2781 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2688, float %fneg..3, i64 3
  br label %if.end202

if.end202:                                        ; preds = %if.then173, %for.cond178.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2781, %for.cond178.preheader ], [ zeroinitializer, %if.then173 ]
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !81
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %32), !call_argsrelate !81
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %33), !call_argsrelate !81
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %34), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %35, i64 0
  %mul238 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul238, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1
  %mul238.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul238.1, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2
  %mul238.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul238.2, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3
  %mul238.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul238.3, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %37)
  %45 = insertelement <4 x i16> poison, i16 %44, i64 0
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %39)
  %47 = insertelement <4 x i16> %45, i16 %46, i64 1
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %41)
  %49 = insertelement <4 x i16> %47, i16 %48, i64 2
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %43)
  %51 = insertelement <4 x i16> %49, i16 %50, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %51 to <4 x half>
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end290

if.end290:                                        ; preds = %if.end202, %land.lhs.true170, %if.end165
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %55, %if.end202 ], [ zeroinitializer, %if.end165 ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %54, %if.end202 ], [ zeroinitializer, %if.end165 ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %53, %if.end202 ], [ zeroinitializer, %if.end165 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %52, %if.end202 ], [ zeroinitializer, %if.end165 ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %43, %if.end202 ], [ 0.000000e+00, %if.end165 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %41, %if.end202 ], [ 0.000000e+00, %if.end165 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %39, %if.end202 ], [ 0.000000e+00, %if.end165 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %37, %if.end202 ], [ 0.000000e+00, %if.end165 ]
  %or.cond2280 = icmp ugt i32 %mul11.2, 1023
  %cmp297.not = icmp sgt i32 %mul11.2, %1
  %or.cond2281 = or i1 %or.cond2280, %cmp297.not
  br i1 %or.cond2281, label %if.end322, label %for.cond299.preheader

for.cond299.preheader:                            ; preds = %if.end290
  %mul304 = shl nsw i32 %0, 16
  %56 = shl nsw i32 %cond.i.i2150.2, 10
  %mul306 = and i32 %56, 64512
  %mul311 = shl nuw nsw i32 %18, 3
  %add307 = or disjoint i32 %mul311, %mul304
  %add309 = add nuw nsw i32 %add307, %mul306
  %57 = zext nneg i32 %add309 to i64
  %add.ptr314 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57
  %K_ring0.sroa.0.0.copyload2942 = load <4 x half>, ptr addrspace(4) %add.ptr314, align 16
  %K_ring0.sroa.10.0.add.ptr314.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr314, i64 8
  %K_ring0.sroa.10.0.copyload2945 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr314.sroa_idx, align 8
  %58 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57
  %add.ptr314.1 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1024
  %K_ring0.sroa.14.16.copyload2954 = load <4 x half>, ptr addrspace(4) %add.ptr314.1, align 16
  %K_ring0.sroa.22.16.add.ptr314.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1032
  %K_ring0.sroa.22.16.copyload2957 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr314.1.sroa_idx, align 8
  br label %if.end322

if.end322:                                        ; preds = %for.cond299.preheader, %if.end290
  %K_ring0.sroa.22.1 = phi <4 x half> [ %K_ring0.sroa.22.0, %if.end290 ], [ %K_ring0.sroa.22.16.copyload2957, %for.cond299.preheader ]
  %K_ring0.sroa.14.1 = phi <4 x half> [ %K_ring0.sroa.14.0, %if.end290 ], [ %K_ring0.sroa.14.16.copyload2954, %for.cond299.preheader ]
  %K_ring0.sroa.10.1 = phi <4 x half> [ %K_ring0.sroa.10.0, %if.end290 ], [ %K_ring0.sroa.10.0.copyload2945, %for.cond299.preheader ]
  %K_ring0.sroa.0.1 = phi <4 x half> [ %K_ring0.sroa.0.0, %if.end290 ], [ %K_ring0.sroa.0.0.copyload2942, %for.cond299.preheader ]
  br i1 %or.cond2276, label %if.end354, label %for.cond331.preheader

for.cond331.preheader:                            ; preds = %if.end322
  %mul336 = shl nsw i32 %0, 16
  %59 = shl nsw i32 %cond.i.i2150.1, 10
  %mul338 = and i32 %59, 64512
  %mul343 = shl nuw nsw i32 %18, 3
  %add339 = or disjoint i32 %mul343, %mul336
  %add341 = add nuw nsw i32 %add339, %mul338
  %60 = zext nneg i32 %add341 to i64
  %add.ptr346 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %60
  %V_ring0.sroa.0.0.copyload2866 = load <4 x half>, ptr addrspace(4) %add.ptr346, align 16
  %V_ring0.sroa.18.0.add.ptr346.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr346, i64 8
  %V_ring0.sroa.18.0.copyload2873 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr346.sroa_idx, align 8
  %61 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %60
  %add.ptr346.1 = getelementptr inbounds i8, ptr addrspace(4) %61, i64 1024
  %V_ring0.sroa.26.16.copyload2894 = load <4 x half>, ptr addrspace(4) %add.ptr346.1, align 16
  %V_ring0.sroa.42.16.add.ptr346.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %61, i64 1032
  %V_ring0.sroa.42.16.copyload2901 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr346.1.sroa_idx, align 8
  br label %if.end354

if.end354:                                        ; preds = %for.cond331.preheader, %if.end322
  %V_ring0.sroa.42.1 = phi <4 x half> [ %V_ring0.sroa.42.0, %if.end322 ], [ %V_ring0.sroa.42.16.copyload2901, %for.cond331.preheader ]
  %V_ring0.sroa.26.1 = phi <4 x half> [ %V_ring0.sroa.26.0, %if.end322 ], [ %V_ring0.sroa.26.16.copyload2894, %for.cond331.preheader ]
  %V_ring0.sroa.18.1 = phi <4 x half> [ %V_ring0.sroa.18.0, %if.end322 ], [ %V_ring0.sroa.18.0.copyload2873, %for.cond331.preheader ]
  %V_ring0.sroa.0.1 = phi <4 x half> [ %V_ring0.sroa.0.0, %if.end322 ], [ %V_ring0.sroa.0.0.copyload2866, %for.cond331.preheader ]
  %or.cond2284 = icmp ult i32 %mul11.1, 1024
  br i1 %or.cond2284, label %land.lhs.true359, label %if.end478

land.lhs.true359:                                 ; preds = %if.end354
  br i1 %cmp106.not, label %if.end478, label %if.then362

if.then362:                                       ; preds = %land.lhs.true359
  %add364 = or disjoint i32 %mul11.1, 15
  %cmp365 = icmp ult i32 %1, %add364
  br i1 %cmp365, label %for.cond367.preheader, label %if.end391

for.cond367.preheader:                            ; preds = %if.then362
  %62 = lshr i32 %18, 2
  %mul373 = and i32 %62, 252
  %add374 = add nuw nsw i32 %mul11.1, %mul373
  %cmp377.not = icmp sgt i32 %add374, %1
  %fneg.2135 = select i1 %cmp377.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2511 = insertelement <4 x float> poison, float %fneg.2135, i64 0
  %cmp377.not.1.not = icmp slt i32 %add374, %1
  %fneg.2135.1 = select i1 %cmp377.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2604 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2511, float %fneg.2135.1, i64 1
  %add375.2 = or disjoint i32 %add374, 2
  %cmp377.not.2 = icmp sgt i32 %add375.2, %1
  %fneg.2135.2 = select i1 %cmp377.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2697 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2604, float %fneg.2135.2, i64 2
  %add375.3 = or disjoint i32 %add374, 3
  %cmp377.not.3 = icmp sgt i32 %add375.3, %1
  %fneg.2135.3 = select i1 %cmp377.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2790 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2697, float %fneg.2135.3, i64 3
  br label %if.end391

if.end391:                                        ; preds = %if.then362, %for.cond367.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2790, %for.cond367.preheader ], [ zeroinitializer, %if.then362 ]
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !81
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %63), !call_argsrelate !81
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %64), !call_argsrelate !81
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %65), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2513 = extractelement <4 x float> %66, i64 0
  %mul426 = fmul contract float %acc_s.sroa.0.0.vec.extract2513, 0x3FB99999A0000000
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul426, float 0x4024CB5EC0000000)
  %68 = tail call contract noundef float @llvm.exp.f32(float %67)
  %acc_s.sroa.0.4.vec.extract2606 = extractelement <4 x float> %66, i64 1
  %mul426.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2606, 0x3FB99999A0000000
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul426.1, float 0x4024CB5EC0000000)
  %70 = tail call contract noundef float @llvm.exp.f32(float %69)
  %acc_s.sroa.0.8.vec.extract2699 = extractelement <4 x float> %66, i64 2
  %mul426.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2699, 0x3FB99999A0000000
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul426.2, float 0x4024CB5EC0000000)
  %72 = tail call contract noundef float @llvm.exp.f32(float %71)
  %acc_s.sroa.0.12.vec.extract2792 = extractelement <4 x float> %66, i64 3
  %mul426.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2792, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul426.3, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %add442 = fadd contract float %sum_acc.sroa.0.0, %68
  %add442.1 = fadd contract float %sum_acc.sroa.20.0, %70
  %add442.2 = fadd contract float %sum_acc.sroa.38.0, %72
  %add442.3 = fadd contract float %sum_acc.sroa.56.0, %74
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %68)
  %76 = insertelement <4 x i16> poison, i16 %75, i64 0
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %70)
  %78 = insertelement <4 x i16> %76, i16 %77, i64 1
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %72)
  %80 = insertelement <4 x i16> %78, i16 %79, i64 2
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %82 = insertelement <4 x i16> %80, i16 %81, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2466 = bitcast <4 x i16> %82 to <4 x half>
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer)
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer)
  br label %if.end478

if.end478:                                        ; preds = %if.end391, %land.lhs.true359, %if.end354
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %86, %if.end391 ], [ zeroinitializer, %if.end354 ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %85, %if.end391 ], [ zeroinitializer, %if.end354 ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %84, %if.end391 ], [ zeroinitializer, %if.end354 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %83, %if.end391 ], [ zeroinitializer, %if.end354 ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true359 ], [ %add442.3, %if.end391 ], [ %sum_acc.sroa.56.0, %if.end354 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true359 ], [ %add442.2, %if.end391 ], [ %sum_acc.sroa.38.0, %if.end354 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true359 ], [ %add442.1, %if.end391 ], [ %sum_acc.sroa.20.0, %if.end354 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true359 ], [ %add442, %if.end391 ], [ %sum_acc.sroa.0.0, %if.end354 ]
  %or.cond2285 = icmp ugt i32 %mul11.3, 1023
  %cmp485.not = icmp sgt i32 %mul11.3, %1
  %or.cond2286 = or i1 %or.cond2285, %cmp485.not
  br i1 %or.cond2286, label %if.end510, label %for.cond487.preheader

for.cond487.preheader:                            ; preds = %if.end478
  %mul492 = shl nsw i32 %0, 16
  %87 = shl nsw i32 %cond.i.i2150.3, 10
  %mul494 = and i32 %87, 64512
  %mul499 = shl nuw nsw i32 %18, 3
  %add495 = or disjoint i32 %mul499, %mul492
  %add497 = add nuw nsw i32 %add495, %mul494
  %88 = zext nneg i32 %add497 to i64
  %add.ptr502 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %88
  %K_ring1.sroa.0.0.copyload2918 = load <4 x half>, ptr addrspace(4) %add.ptr502, align 16
  %K_ring1.sroa.10.0.add.ptr502.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr502, i64 8
  %K_ring1.sroa.10.0.copyload2921 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr502.sroa_idx, align 8
  %89 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %88
  %add.ptr502.1 = getelementptr inbounds i8, ptr addrspace(4) %89, i64 1024
  %K_ring1.sroa.14.16.copyload2930 = load <4 x half>, ptr addrspace(4) %add.ptr502.1, align 16
  %K_ring1.sroa.22.16.add.ptr502.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %89, i64 1032
  %K_ring1.sroa.22.16.copyload2933 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr502.1.sroa_idx, align 8
  br label %if.end510

if.end510:                                        ; preds = %for.cond487.preheader, %if.end478
  %K_ring1.sroa.22.1 = phi <4 x half> [ %K_ring1.sroa.22.0, %if.end478 ], [ %K_ring1.sroa.22.16.copyload2933, %for.cond487.preheader ]
  %K_ring1.sroa.14.1 = phi <4 x half> [ %K_ring1.sroa.14.0, %if.end478 ], [ %K_ring1.sroa.14.16.copyload2930, %for.cond487.preheader ]
  %K_ring1.sroa.10.1 = phi <4 x half> [ %K_ring1.sroa.10.0, %if.end478 ], [ %K_ring1.sroa.10.0.copyload2921, %for.cond487.preheader ]
  %K_ring1.sroa.0.1 = phi <4 x half> [ %K_ring1.sroa.0.0, %if.end478 ], [ %K_ring1.sroa.0.0.copyload2918, %for.cond487.preheader ]
  br i1 %or.cond2281, label %if.end542, label %for.cond519.preheader

for.cond519.preheader:                            ; preds = %if.end510
  %mul524 = shl nsw i32 %0, 16
  %90 = shl nsw i32 %cond.i.i2150.2, 10
  %mul526 = and i32 %90, 64512
  %mul531 = shl nuw nsw i32 %18, 3
  %add527 = or disjoint i32 %mul531, %mul524
  %add529 = add nuw nsw i32 %add527, %mul526
  %91 = zext nneg i32 %add529 to i64
  %add.ptr534 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %91
  %V_ring0.sroa.0.0.copyload2867 = load <4 x half>, ptr addrspace(4) %add.ptr534, align 16
  %V_ring0.sroa.18.0.add.ptr534.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr534, i64 8
  %V_ring0.sroa.18.0.copyload2874 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr534.sroa_idx, align 8
  %92 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %91
  %add.ptr534.1 = getelementptr inbounds i8, ptr addrspace(4) %92, i64 1024
  %V_ring0.sroa.26.16.copyload2895 = load <4 x half>, ptr addrspace(4) %add.ptr534.1, align 16
  %V_ring0.sroa.42.16.add.ptr534.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %92, i64 1032
  %V_ring0.sroa.42.16.copyload2902 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr534.1.sroa_idx, align 8
  br label %if.end542

if.end542:                                        ; preds = %for.cond519.preheader, %if.end510
  %V_ring0.sroa.42.2 = phi <4 x half> [ %V_ring0.sroa.42.1, %if.end510 ], [ %V_ring0.sroa.42.16.copyload2902, %for.cond519.preheader ]
  %V_ring0.sroa.26.2 = phi <4 x half> [ %V_ring0.sroa.26.1, %if.end510 ], [ %V_ring0.sroa.26.16.copyload2895, %for.cond519.preheader ]
  %V_ring0.sroa.18.2 = phi <4 x half> [ %V_ring0.sroa.18.1, %if.end510 ], [ %V_ring0.sroa.18.0.copyload2874, %for.cond519.preheader ]
  %V_ring0.sroa.0.2 = phi <4 x half> [ %V_ring0.sroa.0.1, %if.end510 ], [ %V_ring0.sroa.0.0.copyload2867, %for.cond519.preheader ]
  %or.cond2289 = icmp ult i32 %mul11.2, 1024
  br i1 %or.cond2289, label %land.lhs.true547, label %if.end666

land.lhs.true547:                                 ; preds = %if.end542
  br i1 %cmp297.not, label %if.end666, label %if.then550

if.then550:                                       ; preds = %land.lhs.true547
  %add552 = or disjoint i32 %mul11.2, 15
  %cmp553 = icmp ult i32 %1, %add552
  br i1 %cmp553, label %for.cond555.preheader, label %if.end579

for.cond555.preheader:                            ; preds = %if.then550
  %93 = lshr i32 %18, 2
  %mul561 = and i32 %93, 252
  %add562 = add nuw nsw i32 %mul11.2, %mul561
  %cmp565.not = icmp sgt i32 %add562, %1
  %fneg.2136 = select i1 %cmp565.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2521 = insertelement <4 x float> poison, float %fneg.2136, i64 0
  %cmp565.not.1.not = icmp slt i32 %add562, %1
  %fneg.2136.1 = select i1 %cmp565.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2614 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2521, float %fneg.2136.1, i64 1
  %add563.2 = or disjoint i32 %add562, 2
  %cmp565.not.2 = icmp sgt i32 %add563.2, %1
  %fneg.2136.2 = select i1 %cmp565.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2707 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2614, float %fneg.2136.2, i64 2
  %add563.3 = or disjoint i32 %add562, 3
  %cmp565.not.3 = icmp sgt i32 %add563.3, %1
  %fneg.2136.3 = select i1 %cmp565.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2800 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2707, float %fneg.2136.3, i64 3
  br label %if.end579

if.end579:                                        ; preds = %if.then550, %for.cond555.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2800, %for.cond555.preheader ], [ zeroinitializer, %if.then550 ]
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !81
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %94), !call_argsrelate !81
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %95), !call_argsrelate !81
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %96), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2523 = extractelement <4 x float> %97, i64 0
  %mul614 = fmul contract float %acc_s.sroa.0.0.vec.extract2523, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul614, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %acc_s.sroa.0.4.vec.extract2616 = extractelement <4 x float> %97, i64 1
  %mul614.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2616, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul614.1, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %acc_s.sroa.0.8.vec.extract2709 = extractelement <4 x float> %97, i64 2
  %mul614.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2709, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul614.2, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %acc_s.sroa.0.12.vec.extract2802 = extractelement <4 x float> %97, i64 3
  %mul614.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2802, 0x3FB99999A0000000
  %104 = tail call contract noundef float @llvm.minnum.f32(float %mul614.3, float 0x4024CB5EC0000000)
  %105 = tail call contract noundef float @llvm.exp.f32(float %104)
  %add630 = fadd contract float %sum_acc.sroa.0.1, %99
  %add630.1 = fadd contract float %sum_acc.sroa.20.1, %101
  %add630.2 = fadd contract float %sum_acc.sroa.38.1, %103
  %add630.3 = fadd contract float %sum_acc.sroa.56.1, %105
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %107 = insertelement <4 x i16> poison, i16 %106, i64 0
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %109 = insertelement <4 x i16> %107, i16 %108, i64 1
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %111 = insertelement <4 x i16> %109, i16 %110, i64 2
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %105)
  %113 = insertelement <4 x i16> %111, i16 %112, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2468 = bitcast <4 x i16> %113 to <4 x half>
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.0.0)
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.34.0)
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.66.0)
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.98.0)
  br label %if.end666

if.end666:                                        ; preds = %if.end579, %land.lhs.true547, %if.end542
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %land.lhs.true547 ], [ %117, %if.end579 ], [ %acc_o.sroa.98.0, %if.end542 ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %land.lhs.true547 ], [ %116, %if.end579 ], [ %acc_o.sroa.66.0, %if.end542 ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %land.lhs.true547 ], [ %115, %if.end579 ], [ %acc_o.sroa.34.0, %if.end542 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %land.lhs.true547 ], [ %114, %if.end579 ], [ %acc_o.sroa.0.0, %if.end542 ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true547 ], [ %add630.3, %if.end579 ], [ %sum_acc.sroa.56.1, %if.end542 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true547 ], [ %add630.2, %if.end579 ], [ %sum_acc.sroa.38.1, %if.end542 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true547 ], [ %add630.1, %if.end579 ], [ %sum_acc.sroa.20.1, %if.end542 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true547 ], [ %add630, %if.end579 ], [ %sum_acc.sroa.0.1, %if.end542 ]
  %or.cond2290 = icmp ugt i32 %mul11.4, 1023
  %cmp673.not = icmp sgt i32 %mul11.4, %1
  %or.cond2291 = or i1 %or.cond2290, %cmp673.not
  br i1 %or.cond2291, label %if.end698, label %for.cond675.preheader

for.cond675.preheader:                            ; preds = %if.end666
  %mul680 = shl nsw i32 %0, 16
  %118 = shl nsw i32 %cond.i.i2150.4, 10
  %mul682 = and i32 %118, 64512
  %mul687 = shl nuw nsw i32 %18, 3
  %add683 = or disjoint i32 %mul687, %mul680
  %add685 = add nuw nsw i32 %add683, %mul682
  %119 = zext nneg i32 %add685 to i64
  %add.ptr690 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %119
  %K_ring0.sroa.0.0.copyload2943 = load <4 x half>, ptr addrspace(4) %add.ptr690, align 16
  %K_ring0.sroa.10.0.add.ptr690.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr690, i64 8
  %K_ring0.sroa.10.0.copyload2946 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr690.sroa_idx, align 8
  %120 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %119
  %add.ptr690.1 = getelementptr inbounds i8, ptr addrspace(4) %120, i64 1024
  %K_ring0.sroa.14.16.copyload2955 = load <4 x half>, ptr addrspace(4) %add.ptr690.1, align 16
  %K_ring0.sroa.22.16.add.ptr690.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %120, i64 1032
  %K_ring0.sroa.22.16.copyload2958 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr690.1.sroa_idx, align 8
  br label %if.end698

if.end698:                                        ; preds = %for.cond675.preheader, %if.end666
  %K_ring0.sroa.22.2 = phi <4 x half> [ %K_ring0.sroa.22.1, %if.end666 ], [ %K_ring0.sroa.22.16.copyload2958, %for.cond675.preheader ]
  %K_ring0.sroa.14.2 = phi <4 x half> [ %K_ring0.sroa.14.1, %if.end666 ], [ %K_ring0.sroa.14.16.copyload2955, %for.cond675.preheader ]
  %K_ring0.sroa.10.2 = phi <4 x half> [ %K_ring0.sroa.10.1, %if.end666 ], [ %K_ring0.sroa.10.0.copyload2946, %for.cond675.preheader ]
  %K_ring0.sroa.0.2 = phi <4 x half> [ %K_ring0.sroa.0.1, %if.end666 ], [ %K_ring0.sroa.0.0.copyload2943, %for.cond675.preheader ]
  br i1 %or.cond2286, label %if.end730, label %for.cond707.preheader

for.cond707.preheader:                            ; preds = %if.end698
  %mul712 = shl nsw i32 %0, 16
  %121 = shl nsw i32 %cond.i.i2150.3, 10
  %mul714 = and i32 %121, 64512
  %mul719 = shl nuw nsw i32 %18, 3
  %add715 = or disjoint i32 %mul719, %mul712
  %add717 = add nuw nsw i32 %add715, %mul714
  %122 = zext nneg i32 %add717 to i64
  %add.ptr722 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %122
  %V_ring0.sroa.0.0.copyload2868 = load <4 x half>, ptr addrspace(4) %add.ptr722, align 16
  %V_ring0.sroa.18.0.add.ptr722.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr722, i64 8
  %V_ring0.sroa.18.0.copyload2875 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr722.sroa_idx, align 8
  %123 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %122
  %add.ptr722.1 = getelementptr inbounds i8, ptr addrspace(4) %123, i64 1024
  %V_ring0.sroa.26.16.copyload2896 = load <4 x half>, ptr addrspace(4) %add.ptr722.1, align 16
  %V_ring0.sroa.42.16.add.ptr722.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %123, i64 1032
  %V_ring0.sroa.42.16.copyload2903 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr722.1.sroa_idx, align 8
  br label %if.end730

if.end730:                                        ; preds = %for.cond707.preheader, %if.end698
  %V_ring0.sroa.42.3 = phi <4 x half> [ %V_ring0.sroa.42.2, %if.end698 ], [ %V_ring0.sroa.42.16.copyload2903, %for.cond707.preheader ]
  %V_ring0.sroa.26.3 = phi <4 x half> [ %V_ring0.sroa.26.2, %if.end698 ], [ %V_ring0.sroa.26.16.copyload2896, %for.cond707.preheader ]
  %V_ring0.sroa.18.3 = phi <4 x half> [ %V_ring0.sroa.18.2, %if.end698 ], [ %V_ring0.sroa.18.0.copyload2875, %for.cond707.preheader ]
  %V_ring0.sroa.0.3 = phi <4 x half> [ %V_ring0.sroa.0.2, %if.end698 ], [ %V_ring0.sroa.0.0.copyload2868, %for.cond707.preheader ]
  %or.cond2294 = icmp ult i32 %mul11.3, 1024
  br i1 %or.cond2294, label %land.lhs.true735, label %if.end854

land.lhs.true735:                                 ; preds = %if.end730
  br i1 %cmp485.not, label %if.end854, label %if.then738

if.then738:                                       ; preds = %land.lhs.true735
  %add740 = or disjoint i32 %mul11.3, 15
  %cmp741 = icmp ult i32 %1, %add740
  br i1 %cmp741, label %for.cond743.preheader, label %if.end767

for.cond743.preheader:                            ; preds = %if.then738
  %124 = lshr i32 %18, 2
  %mul749 = and i32 %124, 252
  %add750 = add nuw nsw i32 %mul11.3, %mul749
  %cmp753.not = icmp sgt i32 %add750, %1
  %fneg.2137 = select i1 %cmp753.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2531 = insertelement <4 x float> poison, float %fneg.2137, i64 0
  %cmp753.not.1.not = icmp slt i32 %add750, %1
  %fneg.2137.1 = select i1 %cmp753.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2624 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2531, float %fneg.2137.1, i64 1
  %add751.2 = or disjoint i32 %add750, 2
  %cmp753.not.2 = icmp sgt i32 %add751.2, %1
  %fneg.2137.2 = select i1 %cmp753.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2717 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2624, float %fneg.2137.2, i64 2
  %add751.3 = or disjoint i32 %add750, 3
  %cmp753.not.3 = icmp sgt i32 %add751.3, %1
  %fneg.2137.3 = select i1 %cmp753.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2810 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2717, float %fneg.2137.3, i64 3
  br label %if.end767

if.end767:                                        ; preds = %if.then738, %for.cond743.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2810, %for.cond743.preheader ], [ zeroinitializer, %if.then738 ]
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !81
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %125), !call_argsrelate !81
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %126), !call_argsrelate !81
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %127), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2533 = extractelement <4 x float> %128, i64 0
  %mul802 = fmul contract float %acc_s.sroa.0.0.vec.extract2533, 0x3FB99999A0000000
  %129 = tail call contract noundef float @llvm.minnum.f32(float %mul802, float 0x4024CB5EC0000000)
  %130 = tail call contract noundef float @llvm.exp.f32(float %129)
  %acc_s.sroa.0.4.vec.extract2626 = extractelement <4 x float> %128, i64 1
  %mul802.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2626, 0x3FB99999A0000000
  %131 = tail call contract noundef float @llvm.minnum.f32(float %mul802.1, float 0x4024CB5EC0000000)
  %132 = tail call contract noundef float @llvm.exp.f32(float %131)
  %acc_s.sroa.0.8.vec.extract2719 = extractelement <4 x float> %128, i64 2
  %mul802.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2719, 0x3FB99999A0000000
  %133 = tail call contract noundef float @llvm.minnum.f32(float %mul802.2, float 0x4024CB5EC0000000)
  %134 = tail call contract noundef float @llvm.exp.f32(float %133)
  %acc_s.sroa.0.12.vec.extract2812 = extractelement <4 x float> %128, i64 3
  %mul802.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2812, 0x3FB99999A0000000
  %135 = tail call contract noundef float @llvm.minnum.f32(float %mul802.3, float 0x4024CB5EC0000000)
  %136 = tail call contract noundef float @llvm.exp.f32(float %135)
  %add818 = fadd contract float %sum_acc.sroa.0.2, %130
  %add818.1 = fadd contract float %sum_acc.sroa.20.2, %132
  %add818.2 = fadd contract float %sum_acc.sroa.38.2, %134
  %add818.3 = fadd contract float %sum_acc.sroa.56.2, %136
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %130)
  %138 = insertelement <4 x i16> poison, i16 %137, i64 0
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %132)
  %140 = insertelement <4 x i16> %138, i16 %139, i64 1
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %134)
  %142 = insertelement <4 x i16> %140, i16 %141, i64 2
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %136)
  %144 = insertelement <4 x i16> %142, i16 %143, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2470 = bitcast <4 x i16> %144 to <4 x half>
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.0.0)
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.18.0)
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.34.0)
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.50.0)
  br label %if.end854

if.end854:                                        ; preds = %if.end767, %land.lhs.true735, %if.end730
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %land.lhs.true735 ], [ %148, %if.end767 ], [ %acc_o_alt.sroa.50.0, %if.end730 ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %land.lhs.true735 ], [ %147, %if.end767 ], [ %acc_o_alt.sroa.34.0, %if.end730 ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %land.lhs.true735 ], [ %146, %if.end767 ], [ %acc_o_alt.sroa.18.0, %if.end730 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %land.lhs.true735 ], [ %145, %if.end767 ], [ %acc_o_alt.sroa.0.0, %if.end730 ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true735 ], [ %add818.3, %if.end767 ], [ %sum_acc.sroa.56.2, %if.end730 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true735 ], [ %add818.2, %if.end767 ], [ %sum_acc.sroa.38.2, %if.end730 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true735 ], [ %add818.1, %if.end767 ], [ %sum_acc.sroa.20.2, %if.end730 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true735 ], [ %add818, %if.end767 ], [ %sum_acc.sroa.0.2, %if.end730 ]
  %or.cond2295 = icmp ugt i32 %mul11.5, 1023
  %cmp861.not = icmp sgt i32 %mul11.5, %1
  %or.cond2296 = or i1 %or.cond2295, %cmp861.not
  br i1 %or.cond2296, label %if.end886, label %for.cond863.preheader

for.cond863.preheader:                            ; preds = %if.end854
  %mul868 = shl nsw i32 %0, 16
  %149 = shl nsw i32 %cond.i.i2150.5, 10
  %mul870 = and i32 %149, 64512
  %mul875 = shl nuw nsw i32 %18, 3
  %add871 = or disjoint i32 %mul875, %mul868
  %add873 = add nuw nsw i32 %add871, %mul870
  %150 = zext nneg i32 %add873 to i64
  %add.ptr878 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150
  %K_ring1.sroa.0.0.copyload2919 = load <4 x half>, ptr addrspace(4) %add.ptr878, align 16
  %K_ring1.sroa.10.0.add.ptr878.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr878, i64 8
  %K_ring1.sroa.10.0.copyload2922 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr878.sroa_idx, align 8
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150
  %add.ptr878.1 = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1024
  %K_ring1.sroa.14.16.copyload2931 = load <4 x half>, ptr addrspace(4) %add.ptr878.1, align 16
  %K_ring1.sroa.22.16.add.ptr878.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1032
  %K_ring1.sroa.22.16.copyload2934 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr878.1.sroa_idx, align 8
  br label %if.end886

if.end886:                                        ; preds = %for.cond863.preheader, %if.end854
  %K_ring1.sroa.22.2 = phi <4 x half> [ %K_ring1.sroa.22.1, %if.end854 ], [ %K_ring1.sroa.22.16.copyload2934, %for.cond863.preheader ]
  %K_ring1.sroa.14.2 = phi <4 x half> [ %K_ring1.sroa.14.1, %if.end854 ], [ %K_ring1.sroa.14.16.copyload2931, %for.cond863.preheader ]
  %K_ring1.sroa.10.2 = phi <4 x half> [ %K_ring1.sroa.10.1, %if.end854 ], [ %K_ring1.sroa.10.0.copyload2922, %for.cond863.preheader ]
  %K_ring1.sroa.0.2 = phi <4 x half> [ %K_ring1.sroa.0.1, %if.end854 ], [ %K_ring1.sroa.0.0.copyload2919, %for.cond863.preheader ]
  br i1 %or.cond2291, label %if.end918, label %for.cond895.preheader

for.cond895.preheader:                            ; preds = %if.end886
  %mul900 = shl nsw i32 %0, 16
  %152 = shl nsw i32 %cond.i.i2150.4, 10
  %mul902 = and i32 %152, 64512
  %mul907 = shl nuw nsw i32 %18, 3
  %add903 = or disjoint i32 %mul907, %mul900
  %add905 = add nuw nsw i32 %add903, %mul902
  %153 = zext nneg i32 %add905 to i64
  %add.ptr910 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153
  %V_ring0.sroa.0.0.copyload2869 = load <4 x half>, ptr addrspace(4) %add.ptr910, align 16
  %V_ring0.sroa.18.0.add.ptr910.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr910, i64 8
  %V_ring0.sroa.18.0.copyload2876 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr910.sroa_idx, align 8
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153
  %add.ptr910.1 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024
  %V_ring0.sroa.26.16.copyload2897 = load <4 x half>, ptr addrspace(4) %add.ptr910.1, align 16
  %V_ring0.sroa.42.16.add.ptr910.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1032
  %V_ring0.sroa.42.16.copyload2904 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr910.1.sroa_idx, align 8
  br label %if.end918

if.end918:                                        ; preds = %for.cond895.preheader, %if.end886
  %V_ring0.sroa.42.4 = phi <4 x half> [ %V_ring0.sroa.42.3, %if.end886 ], [ %V_ring0.sroa.42.16.copyload2904, %for.cond895.preheader ]
  %V_ring0.sroa.26.4 = phi <4 x half> [ %V_ring0.sroa.26.3, %if.end886 ], [ %V_ring0.sroa.26.16.copyload2897, %for.cond895.preheader ]
  %V_ring0.sroa.18.4 = phi <4 x half> [ %V_ring0.sroa.18.3, %if.end886 ], [ %V_ring0.sroa.18.0.copyload2876, %for.cond895.preheader ]
  %V_ring0.sroa.0.4 = phi <4 x half> [ %V_ring0.sroa.0.3, %if.end886 ], [ %V_ring0.sroa.0.0.copyload2869, %for.cond895.preheader ]
  %or.cond2299 = icmp ult i32 %mul11.4, 1024
  br i1 %or.cond2299, label %land.lhs.true923, label %if.end1042

land.lhs.true923:                                 ; preds = %if.end918
  br i1 %cmp673.not, label %if.end1042, label %if.then926

if.then926:                                       ; preds = %land.lhs.true923
  %add928 = or disjoint i32 %mul11.4, 15
  %cmp929 = icmp ult i32 %1, %add928
  br i1 %cmp929, label %for.cond931.preheader, label %if.end955

for.cond931.preheader:                            ; preds = %if.then926
  %155 = lshr i32 %18, 2
  %mul937 = and i32 %155, 252
  %add938 = add nuw nsw i32 %mul11.4, %mul937
  %cmp941.not = icmp sgt i32 %add938, %1
  %fneg.2138 = select i1 %cmp941.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2541 = insertelement <4 x float> poison, float %fneg.2138, i64 0
  %cmp941.not.1.not = icmp slt i32 %add938, %1
  %fneg.2138.1 = select i1 %cmp941.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2634 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2541, float %fneg.2138.1, i64 1
  %add939.2 = or disjoint i32 %add938, 2
  %cmp941.not.2 = icmp sgt i32 %add939.2, %1
  %fneg.2138.2 = select i1 %cmp941.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2727 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2634, float %fneg.2138.2, i64 2
  %add939.3 = or disjoint i32 %add938, 3
  %cmp941.not.3 = icmp sgt i32 %add939.3, %1
  %fneg.2138.3 = select i1 %cmp941.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2820 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2727, float %fneg.2138.3, i64 3
  br label %if.end955

if.end955:                                        ; preds = %if.then926, %for.cond931.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2820, %for.cond931.preheader ], [ zeroinitializer, %if.then926 ]
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !81
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %156), !call_argsrelate !81
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %157), !call_argsrelate !81
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %158), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2543 = extractelement <4 x float> %159, i64 0
  %mul990 = fmul contract float %acc_s.sroa.0.0.vec.extract2543, 0x3FB99999A0000000
  %160 = tail call contract noundef float @llvm.minnum.f32(float %mul990, float 0x4024CB5EC0000000)
  %161 = tail call contract noundef float @llvm.exp.f32(float %160)
  %acc_s.sroa.0.4.vec.extract2636 = extractelement <4 x float> %159, i64 1
  %mul990.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2636, 0x3FB99999A0000000
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul990.1, float 0x4024CB5EC0000000)
  %163 = tail call contract noundef float @llvm.exp.f32(float %162)
  %acc_s.sroa.0.8.vec.extract2729 = extractelement <4 x float> %159, i64 2
  %mul990.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2729, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul990.2, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %acc_s.sroa.0.12.vec.extract2822 = extractelement <4 x float> %159, i64 3
  %mul990.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2822, 0x3FB99999A0000000
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul990.3, float 0x4024CB5EC0000000)
  %167 = tail call contract noundef float @llvm.exp.f32(float %166)
  %add1006 = fadd contract float %sum_acc.sroa.0.3, %161
  %add1006.1 = fadd contract float %sum_acc.sroa.20.3, %163
  %add1006.2 = fadd contract float %sum_acc.sroa.38.3, %165
  %add1006.3 = fadd contract float %sum_acc.sroa.56.3, %167
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %161)
  %169 = insertelement <4 x i16> poison, i16 %168, i64 0
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163)
  %171 = insertelement <4 x i16> %169, i16 %170, i64 1
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %173 = insertelement <4 x i16> %171, i16 %172, i64 2
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167)
  %175 = insertelement <4 x i16> %173, i16 %174, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2472 = bitcast <4 x i16> %175 to <4 x half>
  %176 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.0.1)
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.34.1)
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.66.1)
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.98.1)
  br label %if.end1042

if.end1042:                                       ; preds = %if.end955, %land.lhs.true923, %if.end918
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %land.lhs.true923 ], [ %179, %if.end955 ], [ %acc_o.sroa.98.1, %if.end918 ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %land.lhs.true923 ], [ %178, %if.end955 ], [ %acc_o.sroa.66.1, %if.end918 ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %land.lhs.true923 ], [ %177, %if.end955 ], [ %acc_o.sroa.34.1, %if.end918 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %land.lhs.true923 ], [ %176, %if.end955 ], [ %acc_o.sroa.0.1, %if.end918 ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true923 ], [ %add1006.3, %if.end955 ], [ %sum_acc.sroa.56.3, %if.end918 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true923 ], [ %add1006.2, %if.end955 ], [ %sum_acc.sroa.38.3, %if.end918 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true923 ], [ %add1006.1, %if.end955 ], [ %sum_acc.sroa.20.3, %if.end918 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true923 ], [ %add1006, %if.end955 ], [ %sum_acc.sroa.0.3, %if.end918 ]
  %or.cond2300 = icmp ugt i32 %mul11.6, 1023
  %cmp1049.not = icmp sgt i32 %mul11.6, %1
  %or.cond2301 = or i1 %or.cond2300, %cmp1049.not
  br i1 %or.cond2301, label %if.end1074, label %for.cond1051.preheader

for.cond1051.preheader:                           ; preds = %if.end1042
  %mul1056 = shl nsw i32 %0, 16
  %180 = shl nsw i32 %cond.i.i2150.6, 10
  %mul1058 = and i32 %180, 64512
  %mul1063 = shl nuw nsw i32 %18, 3
  %add1059 = or disjoint i32 %mul1063, %mul1056
  %add1061 = add nuw nsw i32 %add1059, %mul1058
  %181 = zext nneg i32 %add1061 to i64
  %add.ptr1066 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %181
  %K_ring0.sroa.0.0.copyload2944 = load <4 x half>, ptr addrspace(4) %add.ptr1066, align 16
  %K_ring0.sroa.10.0.add.ptr1066.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1066, i64 8
  %K_ring0.sroa.10.0.copyload2947 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr1066.sroa_idx, align 8
  %182 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %181
  %add.ptr1066.1 = getelementptr inbounds i8, ptr addrspace(4) %182, i64 1024
  %K_ring0.sroa.14.16.copyload2956 = load <4 x half>, ptr addrspace(4) %add.ptr1066.1, align 16
  %K_ring0.sroa.22.16.add.ptr1066.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %182, i64 1032
  %K_ring0.sroa.22.16.copyload2959 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr1066.1.sroa_idx, align 8
  br label %if.end1074

if.end1074:                                       ; preds = %for.cond1051.preheader, %if.end1042
  %K_ring0.sroa.22.3 = phi <4 x half> [ %K_ring0.sroa.22.2, %if.end1042 ], [ %K_ring0.sroa.22.16.copyload2959, %for.cond1051.preheader ]
  %K_ring0.sroa.14.3 = phi <4 x half> [ %K_ring0.sroa.14.2, %if.end1042 ], [ %K_ring0.sroa.14.16.copyload2956, %for.cond1051.preheader ]
  %K_ring0.sroa.10.3 = phi <4 x half> [ %K_ring0.sroa.10.2, %if.end1042 ], [ %K_ring0.sroa.10.0.copyload2947, %for.cond1051.preheader ]
  %K_ring0.sroa.0.3 = phi <4 x half> [ %K_ring0.sroa.0.2, %if.end1042 ], [ %K_ring0.sroa.0.0.copyload2944, %for.cond1051.preheader ]
  br i1 %or.cond2296, label %if.end1106, label %for.cond1083.preheader

for.cond1083.preheader:                           ; preds = %if.end1074
  %mul1088 = shl nsw i32 %0, 16
  %183 = shl nsw i32 %cond.i.i2150.5, 10
  %mul1090 = and i32 %183, 64512
  %mul1095 = shl nuw nsw i32 %18, 3
  %add1091 = or disjoint i32 %mul1095, %mul1088
  %add1093 = add nuw nsw i32 %add1091, %mul1090
  %184 = zext nneg i32 %add1093 to i64
  %add.ptr1098 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %184
  %V_ring0.sroa.0.0.copyload2870 = load <4 x half>, ptr addrspace(4) %add.ptr1098, align 16
  %V_ring0.sroa.18.0.add.ptr1098.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1098, i64 8
  %V_ring0.sroa.18.0.copyload2877 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr1098.sroa_idx, align 8
  %185 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %184
  %add.ptr1098.1 = getelementptr inbounds i8, ptr addrspace(4) %185, i64 1024
  %V_ring0.sroa.26.16.copyload2898 = load <4 x half>, ptr addrspace(4) %add.ptr1098.1, align 16
  %V_ring0.sroa.42.16.add.ptr1098.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %185, i64 1032
  %V_ring0.sroa.42.16.copyload2905 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr1098.1.sroa_idx, align 8
  br label %if.end1106

if.end1106:                                       ; preds = %for.cond1083.preheader, %if.end1074
  %V_ring0.sroa.42.5 = phi <4 x half> [ %V_ring0.sroa.42.4, %if.end1074 ], [ %V_ring0.sroa.42.16.copyload2905, %for.cond1083.preheader ]
  %V_ring0.sroa.26.5 = phi <4 x half> [ %V_ring0.sroa.26.4, %if.end1074 ], [ %V_ring0.sroa.26.16.copyload2898, %for.cond1083.preheader ]
  %V_ring0.sroa.18.5 = phi <4 x half> [ %V_ring0.sroa.18.4, %if.end1074 ], [ %V_ring0.sroa.18.0.copyload2877, %for.cond1083.preheader ]
  %V_ring0.sroa.0.5 = phi <4 x half> [ %V_ring0.sroa.0.4, %if.end1074 ], [ %V_ring0.sroa.0.0.copyload2870, %for.cond1083.preheader ]
  %or.cond2304 = icmp ult i32 %mul11.5, 1024
  br i1 %or.cond2304, label %land.lhs.true1111, label %if.end1230

land.lhs.true1111:                                ; preds = %if.end1106
  br i1 %cmp861.not, label %if.end1230, label %if.then1114

if.then1114:                                      ; preds = %land.lhs.true1111
  %add1116 = or disjoint i32 %mul11.5, 15
  %cmp1117 = icmp ult i32 %1, %add1116
  br i1 %cmp1117, label %for.cond1119.preheader, label %if.end1143

for.cond1119.preheader:                           ; preds = %if.then1114
  %186 = lshr i32 %18, 2
  %mul1125 = and i32 %186, 252
  %add1126 = add nuw nsw i32 %mul11.5, %mul1125
  %cmp1129.not = icmp sgt i32 %add1126, %1
  %fneg.2139 = select i1 %cmp1129.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2551 = insertelement <4 x float> poison, float %fneg.2139, i64 0
  %cmp1129.not.1.not = icmp slt i32 %add1126, %1
  %fneg.2139.1 = select i1 %cmp1129.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2644 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2551, float %fneg.2139.1, i64 1
  %add1127.2 = or disjoint i32 %add1126, 2
  %cmp1129.not.2 = icmp sgt i32 %add1127.2, %1
  %fneg.2139.2 = select i1 %cmp1129.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2737 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2644, float %fneg.2139.2, i64 2
  %add1127.3 = or disjoint i32 %add1126, 3
  %cmp1129.not.3 = icmp sgt i32 %add1127.3, %1
  %fneg.2139.3 = select i1 %cmp1129.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2830 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2737, float %fneg.2139.3, i64 3
  br label %if.end1143

if.end1143:                                       ; preds = %if.then1114, %for.cond1119.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2830, %for.cond1119.preheader ], [ zeroinitializer, %if.then1114 ]
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !81
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %187), !call_argsrelate !81
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %188), !call_argsrelate !81
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %189), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2553 = extractelement <4 x float> %190, i64 0
  %mul1178 = fmul contract float %acc_s.sroa.0.0.vec.extract2553, 0x3FB99999A0000000
  %191 = tail call contract noundef float @llvm.minnum.f32(float %mul1178, float 0x4024CB5EC0000000)
  %192 = tail call contract noundef float @llvm.exp.f32(float %191)
  %acc_s.sroa.0.4.vec.extract2646 = extractelement <4 x float> %190, i64 1
  %mul1178.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2646, 0x3FB99999A0000000
  %193 = tail call contract noundef float @llvm.minnum.f32(float %mul1178.1, float 0x4024CB5EC0000000)
  %194 = tail call contract noundef float @llvm.exp.f32(float %193)
  %acc_s.sroa.0.8.vec.extract2739 = extractelement <4 x float> %190, i64 2
  %mul1178.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2739, 0x3FB99999A0000000
  %195 = tail call contract noundef float @llvm.minnum.f32(float %mul1178.2, float 0x4024CB5EC0000000)
  %196 = tail call contract noundef float @llvm.exp.f32(float %195)
  %acc_s.sroa.0.12.vec.extract2832 = extractelement <4 x float> %190, i64 3
  %mul1178.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2832, 0x3FB99999A0000000
  %197 = tail call contract noundef float @llvm.minnum.f32(float %mul1178.3, float 0x4024CB5EC0000000)
  %198 = tail call contract noundef float @llvm.exp.f32(float %197)
  %add1194 = fadd contract float %sum_acc.sroa.0.4, %192
  %add1194.1 = fadd contract float %sum_acc.sroa.20.4, %194
  %add1194.2 = fadd contract float %sum_acc.sroa.38.4, %196
  %add1194.3 = fadd contract float %sum_acc.sroa.56.4, %198
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %192)
  %200 = insertelement <4 x i16> poison, i16 %199, i64 0
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %194)
  %202 = insertelement <4 x i16> %200, i16 %201, i64 1
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %196)
  %204 = insertelement <4 x i16> %202, i16 %203, i64 2
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %198)
  %206 = insertelement <4 x i16> %204, i16 %205, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2474 = bitcast <4 x i16> %206 to <4 x half>
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.0.1)
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.18.1)
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.34.1)
  %210 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.50.1)
  br label %if.end1230

if.end1230:                                       ; preds = %if.end1143, %land.lhs.true1111, %if.end1106
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %land.lhs.true1111 ], [ %210, %if.end1143 ], [ %acc_o_alt.sroa.50.1, %if.end1106 ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %land.lhs.true1111 ], [ %209, %if.end1143 ], [ %acc_o_alt.sroa.34.1, %if.end1106 ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %land.lhs.true1111 ], [ %208, %if.end1143 ], [ %acc_o_alt.sroa.18.1, %if.end1106 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %land.lhs.true1111 ], [ %207, %if.end1143 ], [ %acc_o_alt.sroa.0.1, %if.end1106 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true1111 ], [ %add1194.3, %if.end1143 ], [ %sum_acc.sroa.56.4, %if.end1106 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true1111 ], [ %add1194.2, %if.end1143 ], [ %sum_acc.sroa.38.4, %if.end1106 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true1111 ], [ %add1194.1, %if.end1143 ], [ %sum_acc.sroa.20.4, %if.end1106 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true1111 ], [ %add1194, %if.end1143 ], [ %sum_acc.sroa.0.4, %if.end1106 ]
  %or.cond2305 = icmp ugt i32 %mul11.7, 1023
  %cmp1237.not = icmp sgt i32 %mul11.7, %1
  %or.cond2306 = or i1 %or.cond2305, %cmp1237.not
  br i1 %or.cond2306, label %if.end1262, label %for.cond1239.preheader

for.cond1239.preheader:                           ; preds = %if.end1230
  %mul1244 = shl nsw i32 %0, 16
  %211 = shl nsw i32 %cond.i.i2150.7, 10
  %mul1246 = and i32 %211, 64512
  %mul1251 = shl nuw nsw i32 %18, 3
  %add1247 = or disjoint i32 %mul1251, %mul1244
  %add1249 = add nuw nsw i32 %add1247, %mul1246
  %212 = zext nneg i32 %add1249 to i64
  %add.ptr1254 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %212
  %K_ring1.sroa.0.0.copyload2920 = load <4 x half>, ptr addrspace(4) %add.ptr1254, align 16
  %K_ring1.sroa.10.0.add.ptr1254.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1254, i64 8
  %K_ring1.sroa.10.0.copyload2923 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr1254.sroa_idx, align 8
  %213 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %212
  %add.ptr1254.1 = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1024
  %K_ring1.sroa.14.16.copyload2932 = load <4 x half>, ptr addrspace(4) %add.ptr1254.1, align 16
  %K_ring1.sroa.22.16.add.ptr1254.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1032
  %K_ring1.sroa.22.16.copyload2935 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr1254.1.sroa_idx, align 8
  br label %if.end1262

if.end1262:                                       ; preds = %for.cond1239.preheader, %if.end1230
  %K_ring1.sroa.22.3 = phi <4 x half> [ %K_ring1.sroa.22.2, %if.end1230 ], [ %K_ring1.sroa.22.16.copyload2935, %for.cond1239.preheader ]
  %K_ring1.sroa.14.3 = phi <4 x half> [ %K_ring1.sroa.14.2, %if.end1230 ], [ %K_ring1.sroa.14.16.copyload2932, %for.cond1239.preheader ]
  %K_ring1.sroa.10.3 = phi <4 x half> [ %K_ring1.sroa.10.2, %if.end1230 ], [ %K_ring1.sroa.10.0.copyload2923, %for.cond1239.preheader ]
  %K_ring1.sroa.0.3 = phi <4 x half> [ %K_ring1.sroa.0.2, %if.end1230 ], [ %K_ring1.sroa.0.0.copyload2920, %for.cond1239.preheader ]
  br i1 %or.cond2301, label %if.end1294, label %for.cond1271.preheader

for.cond1271.preheader:                           ; preds = %if.end1262
  %mul1276 = shl nsw i32 %0, 16
  %214 = shl nsw i32 %cond.i.i2150.6, 10
  %mul1278 = and i32 %214, 64512
  %mul1283 = shl nuw nsw i32 %18, 3
  %add1279 = or disjoint i32 %mul1283, %mul1276
  %add1281 = add nuw nsw i32 %add1279, %mul1278
  %215 = zext nneg i32 %add1281 to i64
  %add.ptr1286 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215
  %V_ring0.sroa.0.0.copyload2871 = load <4 x half>, ptr addrspace(4) %add.ptr1286, align 16
  %V_ring0.sroa.18.0.add.ptr1286.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1286, i64 8
  %V_ring0.sroa.18.0.copyload2878 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr1286.sroa_idx, align 8
  %216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215
  %add.ptr1286.1 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1024
  %V_ring0.sroa.26.16.copyload2899 = load <4 x half>, ptr addrspace(4) %add.ptr1286.1, align 16
  %V_ring0.sroa.42.16.add.ptr1286.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1032
  %V_ring0.sroa.42.16.copyload2906 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr1286.1.sroa_idx, align 8
  br label %if.end1294

if.end1294:                                       ; preds = %for.cond1271.preheader, %if.end1262
  %V_ring0.sroa.42.6 = phi <4 x half> [ %V_ring0.sroa.42.5, %if.end1262 ], [ %V_ring0.sroa.42.16.copyload2906, %for.cond1271.preheader ]
  %V_ring0.sroa.26.6 = phi <4 x half> [ %V_ring0.sroa.26.5, %if.end1262 ], [ %V_ring0.sroa.26.16.copyload2899, %for.cond1271.preheader ]
  %V_ring0.sroa.18.6 = phi <4 x half> [ %V_ring0.sroa.18.5, %if.end1262 ], [ %V_ring0.sroa.18.0.copyload2878, %for.cond1271.preheader ]
  %V_ring0.sroa.0.6 = phi <4 x half> [ %V_ring0.sroa.0.5, %if.end1262 ], [ %V_ring0.sroa.0.0.copyload2871, %for.cond1271.preheader ]
  %or.cond2309 = icmp ult i32 %mul11.6, 1024
  br i1 %or.cond2309, label %land.lhs.true1299, label %if.end1418

land.lhs.true1299:                                ; preds = %if.end1294
  br i1 %cmp1049.not, label %if.end1418, label %if.then1302

if.then1302:                                      ; preds = %land.lhs.true1299
  %add1304 = or disjoint i32 %mul11.6, 15
  %cmp1305 = icmp ult i32 %1, %add1304
  br i1 %cmp1305, label %for.cond1307.preheader, label %if.end1331

for.cond1307.preheader:                           ; preds = %if.then1302
  %217 = lshr i32 %18, 2
  %mul1313 = and i32 %217, 252
  %add1314 = add nuw nsw i32 %mul11.6, %mul1313
  %cmp1317.not = icmp sgt i32 %add1314, %1
  %fneg.2140 = select i1 %cmp1317.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2561 = insertelement <4 x float> poison, float %fneg.2140, i64 0
  %cmp1317.not.1.not = icmp slt i32 %add1314, %1
  %fneg.2140.1 = select i1 %cmp1317.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2654 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2561, float %fneg.2140.1, i64 1
  %add1315.2 = or disjoint i32 %add1314, 2
  %cmp1317.not.2 = icmp sgt i32 %add1315.2, %1
  %fneg.2140.2 = select i1 %cmp1317.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2747 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2654, float %fneg.2140.2, i64 2
  %add1315.3 = or disjoint i32 %add1314, 3
  %cmp1317.not.3 = icmp sgt i32 %add1315.3, %1
  %fneg.2140.3 = select i1 %cmp1317.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2840 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2747, float %fneg.2140.3, i64 3
  br label %if.end1331

if.end1331:                                       ; preds = %if.then1302, %for.cond1307.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2840, %for.cond1307.preheader ], [ zeroinitializer, %if.then1302 ]
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !81
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %218), !call_argsrelate !81
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %219), !call_argsrelate !81
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %220), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2563 = extractelement <4 x float> %221, i64 0
  %mul1366 = fmul contract float %acc_s.sroa.0.0.vec.extract2563, 0x3FB99999A0000000
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul1366, float 0x4024CB5EC0000000)
  %223 = tail call contract noundef float @llvm.exp.f32(float %222)
  %acc_s.sroa.0.4.vec.extract2656 = extractelement <4 x float> %221, i64 1
  %mul1366.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2656, 0x3FB99999A0000000
  %224 = tail call contract noundef float @llvm.minnum.f32(float %mul1366.1, float 0x4024CB5EC0000000)
  %225 = tail call contract noundef float @llvm.exp.f32(float %224)
  %acc_s.sroa.0.8.vec.extract2749 = extractelement <4 x float> %221, i64 2
  %mul1366.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2749, 0x3FB99999A0000000
  %226 = tail call contract noundef float @llvm.minnum.f32(float %mul1366.2, float 0x4024CB5EC0000000)
  %227 = tail call contract noundef float @llvm.exp.f32(float %226)
  %acc_s.sroa.0.12.vec.extract2842 = extractelement <4 x float> %221, i64 3
  %mul1366.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2842, 0x3FB99999A0000000
  %228 = tail call contract noundef float @llvm.minnum.f32(float %mul1366.3, float 0x4024CB5EC0000000)
  %229 = tail call contract noundef float @llvm.exp.f32(float %228)
  %add1382 = fadd contract float %sum_acc.sroa.0.5, %223
  %add1382.1 = fadd contract float %sum_acc.sroa.20.5, %225
  %add1382.2 = fadd contract float %sum_acc.sroa.38.5, %227
  %add1382.3 = fadd contract float %sum_acc.sroa.56.5, %229
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223)
  %231 = insertelement <4 x i16> poison, i16 %230, i64 0
  %232 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %225)
  %233 = insertelement <4 x i16> %231, i16 %232, i64 1
  %234 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %227)
  %235 = insertelement <4 x i16> %233, i16 %234, i64 2
  %236 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %229)
  %237 = insertelement <4 x i16> %235, i16 %236, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2476 = bitcast <4 x i16> %237 to <4 x half>
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.0.2)
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.34.2)
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.66.2)
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.98.2)
  br label %if.end1418

if.end1418:                                       ; preds = %if.end1331, %land.lhs.true1299, %if.end1294
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %land.lhs.true1299 ], [ %241, %if.end1331 ], [ %acc_o.sroa.98.2, %if.end1294 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %land.lhs.true1299 ], [ %240, %if.end1331 ], [ %acc_o.sroa.66.2, %if.end1294 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %land.lhs.true1299 ], [ %239, %if.end1331 ], [ %acc_o.sroa.34.2, %if.end1294 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %land.lhs.true1299 ], [ %238, %if.end1331 ], [ %acc_o.sroa.0.2, %if.end1294 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true1299 ], [ %add1382.3, %if.end1331 ], [ %sum_acc.sroa.56.5, %if.end1294 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true1299 ], [ %add1382.2, %if.end1331 ], [ %sum_acc.sroa.38.5, %if.end1294 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true1299 ], [ %add1382.1, %if.end1331 ], [ %sum_acc.sroa.20.5, %if.end1294 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true1299 ], [ %add1382, %if.end1331 ], [ %sum_acc.sroa.0.5, %if.end1294 ]
  br i1 %or.cond2306, label %if.end1450, label %for.cond1427.preheader

for.cond1427.preheader:                           ; preds = %if.end1418
  %mul1432 = shl nsw i32 %0, 16
  %242 = shl nsw i32 %cond.i.i2150.7, 10
  %mul1434 = and i32 %242, 64512
  %mul1439 = shl nuw nsw i32 %18, 3
  %add1435 = or disjoint i32 %mul1439, %mul1432
  %add1437 = add nuw nsw i32 %add1435, %mul1434
  %243 = zext nneg i32 %add1437 to i64
  %add.ptr1442 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %243
  %V_ring0.sroa.0.0.copyload2872 = load <4 x half>, ptr addrspace(4) %add.ptr1442, align 16
  %V_ring0.sroa.18.0.add.ptr1442.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1442, i64 8
  %V_ring0.sroa.18.0.copyload2879 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr1442.sroa_idx, align 8
  %244 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %243
  %add.ptr1442.1 = getelementptr inbounds i8, ptr addrspace(4) %244, i64 1024
  %V_ring0.sroa.26.16.copyload2900 = load <4 x half>, ptr addrspace(4) %add.ptr1442.1, align 16
  %V_ring0.sroa.42.16.add.ptr1442.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %244, i64 1032
  %V_ring0.sroa.42.16.copyload2907 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr1442.1.sroa_idx, align 8
  br label %if.end1450

if.end1450:                                       ; preds = %for.cond1427.preheader, %if.end1418
  %V_ring0.sroa.42.7 = phi <4 x half> [ %V_ring0.sroa.42.6, %if.end1418 ], [ %V_ring0.sroa.42.16.copyload2907, %for.cond1427.preheader ]
  %V_ring0.sroa.26.7 = phi <4 x half> [ %V_ring0.sroa.26.6, %if.end1418 ], [ %V_ring0.sroa.26.16.copyload2900, %for.cond1427.preheader ]
  %V_ring0.sroa.18.7 = phi <4 x half> [ %V_ring0.sroa.18.6, %if.end1418 ], [ %V_ring0.sroa.18.0.copyload2879, %for.cond1427.preheader ]
  %V_ring0.sroa.0.7 = phi <4 x half> [ %V_ring0.sroa.0.6, %if.end1418 ], [ %V_ring0.sroa.0.0.copyload2872, %for.cond1427.preheader ]
  %or.cond2312 = icmp ult i32 %mul11.7, 1024
  br i1 %or.cond2312, label %land.lhs.true1455, label %if.end1574

land.lhs.true1455:                                ; preds = %if.end1450
  br i1 %cmp1237.not, label %if.end1574, label %if.then1458

if.then1458:                                      ; preds = %land.lhs.true1455
  %add1460 = or disjoint i32 %mul11.7, 15
  %cmp1461 = icmp slt i32 %1, %add1460
  br i1 %cmp1461, label %for.cond1463.preheader, label %if.end1487

for.cond1463.preheader:                           ; preds = %if.then1458
  %245 = lshr i32 %18, 2
  %mul1469 = and i32 %245, 252
  %add1470 = add nuw nsw i32 %mul11.7, %mul1469
  %cmp1473.not = icmp sgt i32 %add1470, %1
  %fneg.2141 = select i1 %cmp1473.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2571 = insertelement <4 x float> poison, float %fneg.2141, i64 0
  %cmp1473.not.1.not = icmp slt i32 %add1470, %1
  %fneg.2141.1 = select i1 %cmp1473.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2664 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2571, float %fneg.2141.1, i64 1
  %add1471.2 = or disjoint i32 %add1470, 2
  %cmp1473.not.2 = icmp sgt i32 %add1471.2, %1
  %fneg.2141.2 = select i1 %cmp1473.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2757 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2664, float %fneg.2141.2, i64 2
  %add1471.3 = or disjoint i32 %add1470, 3
  %cmp1473.not.3 = icmp sgt i32 %add1471.3, %1
  %fneg.2141.3 = select i1 %cmp1473.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2850 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2757, float %fneg.2141.3, i64 3
  br label %if.end1487

if.end1487:                                       ; preds = %if.then1458, %for.cond1463.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2850, %for.cond1463.preheader ], [ zeroinitializer, %if.then1458 ]
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !81
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %246), !call_argsrelate !81
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %247), !call_argsrelate !81
  %249 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %248), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2573 = extractelement <4 x float> %249, i64 0
  %mul1522 = fmul contract float %acc_s.sroa.0.0.vec.extract2573, 0x3FB99999A0000000
  %250 = tail call contract noundef float @llvm.minnum.f32(float %mul1522, float 0x4024CB5EC0000000)
  %251 = tail call contract noundef float @llvm.exp.f32(float %250)
  %acc_s.sroa.0.4.vec.extract2666 = extractelement <4 x float> %249, i64 1
  %mul1522.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2666, 0x3FB99999A0000000
  %252 = tail call contract noundef float @llvm.minnum.f32(float %mul1522.1, float 0x4024CB5EC0000000)
  %253 = tail call contract noundef float @llvm.exp.f32(float %252)
  %acc_s.sroa.0.8.vec.extract2759 = extractelement <4 x float> %249, i64 2
  %mul1522.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2759, 0x3FB99999A0000000
  %254 = tail call contract noundef float @llvm.minnum.f32(float %mul1522.2, float 0x4024CB5EC0000000)
  %255 = tail call contract noundef float @llvm.exp.f32(float %254)
  %acc_s.sroa.0.12.vec.extract2852 = extractelement <4 x float> %249, i64 3
  %mul1522.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2852, 0x3FB99999A0000000
  %256 = tail call contract noundef float @llvm.minnum.f32(float %mul1522.3, float 0x4024CB5EC0000000)
  %257 = tail call contract noundef float @llvm.exp.f32(float %256)
  %add1538 = fadd contract float %sum_acc.sroa.0.6, %251
  %add1538.1 = fadd contract float %sum_acc.sroa.20.6, %253
  %add1538.2 = fadd contract float %sum_acc.sroa.38.6, %255
  %add1538.3 = fadd contract float %sum_acc.sroa.56.6, %257
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %251)
  %259 = insertelement <4 x i16> poison, i16 %258, i64 0
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %253)
  %261 = insertelement <4 x i16> %259, i16 %260, i64 1
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %255)
  %263 = insertelement <4 x i16> %261, i16 %262, i64 2
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %257)
  %265 = insertelement <4 x i16> %263, i16 %264, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2478 = bitcast <4 x i16> %265 to <4 x half>
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.0.2)
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.18.2)
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.34.2)
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.50.2)
  br label %if.end1574

if.end1574:                                       ; preds = %if.end1487, %land.lhs.true1455, %if.end1450
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %land.lhs.true1455 ], [ %269, %if.end1487 ], [ %acc_o_alt.sroa.50.2, %if.end1450 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %land.lhs.true1455 ], [ %268, %if.end1487 ], [ %acc_o_alt.sroa.34.2, %if.end1450 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %land.lhs.true1455 ], [ %267, %if.end1487 ], [ %acc_o_alt.sroa.18.2, %if.end1450 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %land.lhs.true1455 ], [ %266, %if.end1487 ], [ %acc_o_alt.sroa.0.2, %if.end1450 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1455 ], [ %add1538.3, %if.end1487 ], [ %sum_acc.sroa.56.6, %if.end1450 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1455 ], [ %add1538.2, %if.end1487 ], [ %sum_acc.sroa.38.6, %if.end1450 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1455 ], [ %add1538.1, %if.end1487 ], [ %sum_acc.sroa.20.6, %if.end1450 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1455 ], [ %add1538, %if.end1487 ], [ %sum_acc.sroa.0.6, %if.end1450 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add1583 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add1583.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add1583.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add1583.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add1583.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add1583.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add1583.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add1583.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add1583.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add1583.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add1583.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add1583.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add1583.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add1583.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add1583.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add1583.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add1597 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1597.1 = fadd contract float %add1597, %sum_acc.sroa.20.7
  %add1597.2 = fadd contract float %add1597.1, %sum_acc.sroa.38.7
  %add1597.3 = fadd contract float %add1597.2, %sum_acc.sroa.56.7
  %270 = bitcast float %add1597.3 to i32
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11
  %xor.i.i = xor i32 %272, 32
  %273 = and i32 %272, -64
  %and.i.i = add nsw i32 %273, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2151 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %272
  %shl.i.i = shl i32 %cond.i.i2151, 2
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %270)
  %275 = bitcast i32 %274 to float
  %add.i = fadd contract float %add1597.3, %275
  %276 = bitcast float %add.i to i32
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11
  %xor.i.i2152 = xor i32 %278, 16
  %279 = and i32 %278, -64
  %and.i.i2153 = add nsw i32 %279, 64
  %cmp.not.i.i2154 = icmp slt i32 %xor.i.i2152, %and.i.i2153
  %cond.i.i2155 = select i1 %cmp.not.i.i2154, i32 %xor.i.i2152, i32 %278
  %shl.i.i2156 = shl i32 %cond.i.i2155, 2
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2156, i32 %276)
  %281 = bitcast i32 %280 to float
  %add.i.i = fadd contract float %add.i, %281
  %cmp1606 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp1606, float %div, float 0.000000e+00
  %mul1619 = fmul contract float %condval_8.0, %add1583
  %mul1619.1 = fmul contract float %condval_8.0, %add1583.1
  %mul1619.2 = fmul contract float %condval_8.0, %add1583.2
  %mul1619.3 = fmul contract float %condval_8.0, %add1583.3
  %mul1619.4 = fmul contract float %condval_8.0, %add1583.4
  %mul1619.5 = fmul contract float %condval_8.0, %add1583.5
  %mul1619.6 = fmul contract float %condval_8.0, %add1583.6
  %mul1619.7 = fmul contract float %condval_8.0, %add1583.7
  %mul1619.8 = fmul contract float %condval_8.0, %add1583.8
  %mul1619.9 = fmul contract float %condval_8.0, %add1583.9
  %mul1619.10 = fmul contract float %condval_8.0, %add1583.10
  %mul1619.11 = fmul contract float %condval_8.0, %add1583.11
  %mul1619.12 = fmul contract float %condval_8.0, %add1583.12
  %mul1619.13 = fmul contract float %condval_8.0, %add1583.13
  %mul1619.14 = fmul contract float %condval_8.0, %add1583.14
  %mul1619.15 = fmul contract float %condval_8.0, %add1583.15
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619)
  %O_reg.sroa.0.0.insert.ext = zext i16 %282 to i64
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %283 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %284 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %286 to i64
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %287 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %288 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %290 to i64
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %291 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %292 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %293 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %294 to i64
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %295 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %296 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %297 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1661 = lshr i32 %18, 5
  %and1664 = and i32 %18, 7
  %298 = lshr i32 %18, 2
  %mul1670 = and i32 %298, 4
  %xor = xor i32 %shr1661, %and1664
  %mul1665 = shl nuw nsw i32 %xor, 3
  %add1666 = add nuw nsw i32 %mul1665, %mul25
  %add1671 = or disjoint i32 %add1666, %mul1670
  %add.ptr1673 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1673, align 8
  %add1662.1 = add nuw nsw i32 %shr1661, 2
  %xor.1 = xor i32 %add1662.1, %and1664
  %mul1665.1 = shl nuw nsw i32 %xor.1, 3
  %add1666.1 = add nuw nsw i32 %mul1665.1, %mul25
  %add1671.1 = or disjoint i32 %add1666.1, %mul1670
  %add.ptr1673.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1673.1, align 8
  %add1662.2 = add nuw nsw i32 %shr1661, 4
  %xor.2 = xor i32 %add1662.2, %and1664
  %mul1665.2 = shl nuw nsw i32 %xor.2, 3
  %add1666.2 = add nuw nsw i32 %mul1665.2, %mul25
  %add1671.2 = or disjoint i32 %add1666.2, %mul1670
  %add.ptr1673.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1673.2, align 8
  %add1662.3 = add nuw nsw i32 %shr1661, 6
  %xor.3 = xor i32 %add1662.3, %and1664
  %mul1665.3 = shl nuw nsw i32 %xor.3, 3
  %add1666.3 = add nuw nsw i32 %mul1665.3, %mul25
  %add1671.3 = or disjoint i32 %add1666.3, %mul1670
  %add.ptr1673.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1673.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %299 = shl nuw nsw i32 %18, 3
  %mul1684 = and i32 %299, 8128
  %xor16902133 = and i32 %299, 56
  %call1688.masked = and i32 %18, 1016
  %mul1691 = xor i32 %xor16902133, %call1688.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1684
  %invariant.gep2271 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1691
  %add1701 = add nuw nsw i32 %add23, %299
  %300 = zext nneg i32 %add1701 to i64
  %add.ptr1706 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1706, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2271, i64 16, i1 false), !tbaa.struct !392, !call_argsrelate !393
  %gep2272.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2271, i32 1024
  %301 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  %add.ptr1706.1 = getelementptr inbounds i8, ptr addrspace(1) %301, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1706.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2272.1, i64 16, i1 false), !tbaa.struct !392, !call_argsrelate !393
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


