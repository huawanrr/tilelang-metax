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
  %cond.i.i2211 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2211, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2211.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2211.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2211.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2211.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2211.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2211.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2211.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2211.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2211.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2211.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2211.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2211.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2211.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2211.7, 4
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
  %or.cond2335 = or i1 %or.cond, %cmp75.not
  br i1 %or.cond2335, label %if.end, label %for.cond76.preheader

for.cond76.preheader:                             ; preds = %entry
  %mul82 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2211, 10
  %mul84 = and i32 %22, 64512
  %mul89 = shl nuw nsw i32 %18, 3
  %add85 = or disjoint i32 %mul89, %mul82
  %add87 = add nuw nsw i32 %add85, %mul84
  %23 = zext nneg i32 %add87 to i64
  %add.ptr92 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %K_ring0.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr92, align 16
  %K_ring0.sroa.8.0.add.ptr92.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr92, i64 8
  %K_ring0.sroa.8.0.copyload = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.8.0.add.ptr92.sroa_idx, align 8
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23
  %add.ptr92.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024
  %K_ring0.sroa.11.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr92.1, align 16
  %K_ring0.sroa.17.16.add.ptr92.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1032
  %K_ring0.sroa.17.16.copyload = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.17.16.add.ptr92.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %for.cond76.preheader, %entry
  %K_ring0.sroa.17.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.17.16.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.11.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.11.16.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.8.0.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.0.0.copyload, %for.cond76.preheader ]
  %or.cond2336 = icmp ugt i32 %mul11.1, 1023
  %cmp106.not = icmp sgt i32 %mul11.1, %1
  %or.cond2337 = or i1 %or.cond2336, %cmp106.not
  br i1 %or.cond2337, label %if.end132, label %for.cond108.preheader

for.cond108.preheader:                            ; preds = %if.end
  %mul114 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2211.1, 10
  %mul116 = and i32 %25, 64512
  %mul121 = shl nuw nsw i32 %18, 3
  %add117 = or disjoint i32 %mul121, %mul114
  %add119 = add nuw nsw i32 %add117, %mul116
  %26 = zext nneg i32 %add119 to i64
  %add.ptr124 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %K_ring1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr124, align 16
  %K_ring1.sroa.8.0.add.ptr124.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr124, i64 8
  %K_ring1.sroa.8.0.copyload = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.8.0.add.ptr124.sroa_idx, align 8
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26
  %add.ptr124.1 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024
  %K_ring1.sroa.11.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr124.1, align 16
  %K_ring1.sroa.17.16.add.ptr124.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1032
  %K_ring1.sroa.17.16.copyload = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.17.16.add.ptr124.1.sroa_idx, align 8
  br label %if.end132

if.end132:                                        ; preds = %for.cond108.preheader, %if.end
  %K_ring1.sroa.17.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.17.16.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.11.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.11.16.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.8.0.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.0.0.copyload, %for.cond108.preheader ]
  %or.cond2338 = icmp ugt i32 %mul11.2, 1023
  %cmp139.not = icmp sgt i32 %mul11.2, %1
  %or.cond2339 = or i1 %or.cond2338, %cmp139.not
  br i1 %or.cond2339, label %if.end165, label %for.cond141.preheader

for.cond141.preheader:                            ; preds = %if.end132
  %mul147 = shl nsw i32 %0, 16
  %28 = shl nsw i32 %cond.i.i2211.2, 10
  %mul149 = and i32 %28, 64512
  %mul154 = shl nuw nsw i32 %18, 3
  %add150 = or disjoint i32 %mul154, %mul147
  %add152 = add nuw nsw i32 %add150, %mul149
  %29 = zext nneg i32 %add152 to i64
  %add.ptr157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29
  %K_ring2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157, align 16
  %K_ring2.sroa.6.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr157, i64 8
  %K_ring2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_ring2.sroa.6.0.add.ptr157.sroa_idx, align 8
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1024
  %K_ring2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157.1, align 16
  %K_ring2.sroa.12.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032
  %K_ring2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_ring2.sroa.12.16.add.ptr157.1.sroa_idx, align 8
  br label %if.end165

if.end165:                                        ; preds = %for.cond141.preheader, %if.end132
  %K_ring2.sroa.12.0 = phi <4 x half> [ undef, %if.end132 ], [ %K_ring2.sroa.12.16.copyload, %for.cond141.preheader ]
  %K_ring2.sroa.8.0 = phi <4 x half> [ undef, %if.end132 ], [ %K_ring2.sroa.8.16.copyload, %for.cond141.preheader ]
  %K_ring2.sroa.6.0 = phi <4 x half> [ undef, %if.end132 ], [ %K_ring2.sroa.6.0.copyload, %for.cond141.preheader ]
  %K_ring2.sroa.0.0 = phi <4 x half> [ undef, %if.end132 ], [ %K_ring2.sroa.0.0.copyload, %for.cond141.preheader ]
  br i1 %or.cond2335, label %if.end198, label %for.cond174.preheader

for.cond174.preheader:                            ; preds = %if.end165
  %mul180 = shl nsw i32 %0, 16
  %31 = shl nsw i32 %cond.i.i2211, 10
  %mul182 = and i32 %31, 64512
  %mul187 = shl nuw nsw i32 %18, 3
  %add183 = or disjoint i32 %mul187, %mul180
  %add185 = add nuw nsw i32 %add183, %mul182
  %32 = zext nneg i32 %add185 to i64
  %add.ptr190 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %32
  %V_ring0.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr190, align 16
  %V_ring0.sroa.10.0.add.ptr190.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr190, i64 8
  %V_ring0.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr190.sroa_idx, align 8
  %33 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %32
  %add.ptr190.1 = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1024
  %V_ring0.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr190.1, align 16
  %V_ring0.sroa.22.16.add.ptr190.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1032
  %V_ring0.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr190.1.sroa_idx, align 8
  br label %if.end198

if.end198:                                        ; preds = %for.cond174.preheader, %if.end165
  %V_ring0.sroa.22.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring0.sroa.22.16.copyload, %for.cond174.preheader ]
  %V_ring0.sroa.14.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring0.sroa.14.16.copyload, %for.cond174.preheader ]
  %V_ring0.sroa.10.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring0.sroa.10.0.copyload, %for.cond174.preheader ]
  %V_ring0.sroa.0.0 = phi <4 x half> [ undef, %if.end165 ], [ %V_ring0.sroa.0.0.copyload, %for.cond174.preheader ]
  br i1 %or.cond2337, label %if.end231, label %for.cond207.preheader

for.cond207.preheader:                            ; preds = %if.end198
  %mul213 = shl nsw i32 %0, 16
  %34 = shl nsw i32 %cond.i.i2211.1, 10
  %mul215 = and i32 %34, 64512
  %mul220 = shl nuw nsw i32 %18, 3
  %add216 = or disjoint i32 %mul220, %mul213
  %add218 = add nuw nsw i32 %add216, %mul215
  %35 = zext nneg i32 %add218 to i64
  %add.ptr223 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %35
  %V_ring1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr223, align 16
  %V_ring1.sroa.10.0.add.ptr223.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr223, i64 8
  %V_ring1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr223.sroa_idx, align 8
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %35
  %add.ptr223.1 = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1024
  %V_ring1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr223.1, align 16
  %V_ring1.sroa.22.16.add.ptr223.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1032
  %V_ring1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr223.1.sroa_idx, align 8
  br label %if.end231

if.end231:                                        ; preds = %for.cond207.preheader, %if.end198
  %V_ring1.sroa.22.0 = phi <4 x half> [ undef, %if.end198 ], [ %V_ring1.sroa.22.16.copyload, %for.cond207.preheader ]
  %V_ring1.sroa.14.0 = phi <4 x half> [ undef, %if.end198 ], [ %V_ring1.sroa.14.16.copyload, %for.cond207.preheader ]
  %V_ring1.sroa.10.0 = phi <4 x half> [ undef, %if.end198 ], [ %V_ring1.sroa.10.0.copyload, %for.cond207.preheader ]
  %V_ring1.sroa.0.0 = phi <4 x half> [ undef, %if.end198 ], [ %V_ring1.sroa.0.0.copyload, %for.cond207.preheader ]
  %or.cond2344 = icmp ugt i32 %mul11, 1023
  %brmerge = or i1 %or.cond2344, %cmp75.not
  br i1 %brmerge, label %if.end298, label %if.then239

if.then239:                                       ; preds = %if.end231
  %add241 = or disjoint i32 %mul11, 15
  %cmp242 = icmp ult i32 %1, %add241
  br i1 %cmp242, label %for.cond244.preheader, label %if.end268

for.cond244.preheader:                            ; preds = %if.then239
  %37 = lshr i32 %18, 2
  %mul251 = and i32 %37, 252
  %add252 = add nuw nsw i32 %mul11, %mul251
  %cmp255.not = icmp sgt i32 %add252, %1
  %fneg. = select i1 %cmp255.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2573 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp255.not.1.not = icmp slt i32 %add252, %1
  %fneg..1 = select i1 %cmp255.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2666 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2573, float %fneg..1, i64 1
  %add253.2 = or disjoint i32 %add252, 2
  %cmp255.not.2 = icmp sgt i32 %add253.2, %1
  %fneg..2 = select i1 %cmp255.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2759 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2666, float %fneg..2, i64 2
  %add253.3 = or disjoint i32 %add252, 3
  %cmp255.not.3 = icmp sgt i32 %add253.3, %1
  %fneg..3 = select i1 %cmp255.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2852 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2759, float %fneg..3, i64 3
  br label %if.end268

if.end268:                                        ; preds = %if.then239, %for.cond244.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2852, %for.cond244.preheader ], [ zeroinitializer, %if.then239 ]
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !89
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.8.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %38), !call_argsrelate !89
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.11.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %39), !call_argsrelate !89
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.17.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %40), !call_argsrelate !89
  br label %if.end298

if.end298:                                        ; preds = %if.end231, %if.end268
  %acc_s.sroa.0.1 = phi <4 x float> [ %41, %if.end268 ], [ undef, %if.end231 ]
  %or.cond2345 = icmp ugt i32 %mul11.3, 1023
  %cmp305.not = icmp sgt i32 %mul11.3, %1
  %or.cond2346 = or i1 %or.cond2345, %cmp305.not
  br i1 %or.cond2346, label %if.end330, label %for.cond307.preheader

for.cond307.preheader:                            ; preds = %if.end298
  %mul312 = shl nsw i32 %0, 16
  %42 = shl nsw i32 %cond.i.i2211.3, 10
  %mul314 = and i32 %42, 64512
  %mul319 = shl nuw nsw i32 %18, 3
  %add315 = or disjoint i32 %mul319, %mul312
  %add317 = add nuw nsw i32 %add315, %mul314
  %43 = zext nneg i32 %add317 to i64
  %add.ptr322 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %43
  %K_ring0.sroa.0.0.copyload3004 = load <4 x half>, ptr addrspace(4) %add.ptr322, align 16
  %K_ring0.sroa.8.0.add.ptr322.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr322, i64 8
  %K_ring0.sroa.8.0.copyload3006 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.8.0.add.ptr322.sroa_idx, align 8
  %44 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %43
  %add.ptr322.1 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 1024
  %K_ring0.sroa.11.16.copyload3012 = load <4 x half>, ptr addrspace(4) %add.ptr322.1, align 16
  %K_ring0.sroa.17.16.add.ptr322.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %44, i64 1032
  %K_ring0.sroa.17.16.copyload3014 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.17.16.add.ptr322.1.sroa_idx, align 8
  br label %if.end330

if.end330:                                        ; preds = %for.cond307.preheader, %if.end298
  %K_ring0.sroa.17.1 = phi <4 x half> [ %K_ring0.sroa.17.0, %if.end298 ], [ %K_ring0.sroa.17.16.copyload3014, %for.cond307.preheader ]
  %K_ring0.sroa.11.1 = phi <4 x half> [ %K_ring0.sroa.11.0, %if.end298 ], [ %K_ring0.sroa.11.16.copyload3012, %for.cond307.preheader ]
  %K_ring0.sroa.8.1 = phi <4 x half> [ %K_ring0.sroa.8.0, %if.end298 ], [ %K_ring0.sroa.8.0.copyload3006, %for.cond307.preheader ]
  %K_ring0.sroa.0.1 = phi <4 x half> [ %K_ring0.sroa.0.0, %if.end298 ], [ %K_ring0.sroa.0.0.copyload3004, %for.cond307.preheader ]
  br i1 %or.cond2335, label %if.end396, label %for.body341.preheader

for.body341.preheader:                            ; preds = %if.end330
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 0
  %mul344 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul344, float 0x4024CB5EC0000000)
  %46 = tail call contract noundef float @llvm.exp.f32(float %45)
  %acc_s.sroa.0.0.vec.insert2576 = insertelement <4 x float> poison, float %46, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 1
  %mul344.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %47 = tail call contract noundef float @llvm.minnum.f32(float %mul344.1, float 0x4024CB5EC0000000)
  %48 = tail call contract noundef float @llvm.exp.f32(float %47)
  %acc_s.sroa.0.4.vec.insert2669 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2576, float %48, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 2
  %mul344.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul344.2, float 0x4024CB5EC0000000)
  %50 = tail call contract noundef float @llvm.exp.f32(float %49)
  %acc_s.sroa.0.8.vec.insert2762 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2669, float %50, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %acc_s.sroa.0.1, i64 3
  %mul344.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %51 = tail call contract noundef float @llvm.minnum.f32(float %mul344.3, float 0x4024CB5EC0000000)
  %52 = tail call contract noundef float @llvm.exp.f32(float %51)
  %acc_s.sroa.0.12.vec.insert2855 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2762, float %52, i64 3
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %46)
  %54 = insertelement <4 x i16> poison, i16 %53, i64 0
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %48)
  %56 = insertelement <4 x i16> %54, i16 %55, i64 1
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %50)
  %58 = insertelement <4 x i16> %56, i16 %57, i64 2
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %52)
  %60 = insertelement <4 x i16> %58, i16 %59, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %60 to <4 x half>
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end396

if.end396:                                        ; preds = %for.body341.preheader, %if.end330
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end330 ], [ %64, %for.body341.preheader ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end330 ], [ %63, %for.body341.preheader ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end330 ], [ %62, %for.body341.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end330 ], [ %61, %for.body341.preheader ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end330 ], [ %52, %for.body341.preheader ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end330 ], [ %50, %for.body341.preheader ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end330 ], [ %48, %for.body341.preheader ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end330 ], [ %46, %for.body341.preheader ]
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.1, %if.end330 ], [ %acc_s.sroa.0.12.vec.insert2855, %for.body341.preheader ]
  br i1 %or.cond2339, label %if.end428, label %for.cond405.preheader

for.cond405.preheader:                            ; preds = %if.end396
  %mul410 = shl nsw i32 %0, 16
  %65 = shl nsw i32 %cond.i.i2211.2, 10
  %mul412 = and i32 %65, 64512
  %mul417 = shl nuw nsw i32 %18, 3
  %add413 = or disjoint i32 %mul417, %mul410
  %add415 = add nuw nsw i32 %add413, %mul412
  %66 = zext nneg i32 %add415 to i64
  %add.ptr420 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %66
  %V_ring0.sroa.0.0.copyload2957 = load <4 x half>, ptr addrspace(4) %add.ptr420, align 16
  %V_ring0.sroa.10.0.add.ptr420.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr420, i64 8
  %V_ring0.sroa.10.0.copyload2960 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr420.sroa_idx, align 8
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %66
  %add.ptr420.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1024
  %V_ring0.sroa.14.16.copyload2969 = load <4 x half>, ptr addrspace(4) %add.ptr420.1, align 16
  %V_ring0.sroa.22.16.add.ptr420.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1032
  %V_ring0.sroa.22.16.copyload2972 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr420.1.sroa_idx, align 8
  br label %if.end428

if.end428:                                        ; preds = %for.cond405.preheader, %if.end396
  %V_ring0.sroa.22.1 = phi <4 x half> [ %V_ring0.sroa.22.0, %if.end396 ], [ %V_ring0.sroa.22.16.copyload2972, %for.cond405.preheader ]
  %V_ring0.sroa.14.1 = phi <4 x half> [ %V_ring0.sroa.14.0, %if.end396 ], [ %V_ring0.sroa.14.16.copyload2969, %for.cond405.preheader ]
  %V_ring0.sroa.10.1 = phi <4 x half> [ %V_ring0.sroa.10.0, %if.end396 ], [ %V_ring0.sroa.10.0.copyload2960, %for.cond405.preheader ]
  %V_ring0.sroa.0.1 = phi <4 x half> [ %V_ring0.sroa.0.0, %if.end396 ], [ %V_ring0.sroa.0.0.copyload2957, %for.cond405.preheader ]
  %or.cond2351 = icmp ugt i32 %mul11.1, 1023
  %brmerge3270 = or i1 %or.cond2351, %cmp106.not
  br i1 %brmerge3270, label %if.end494, label %if.then436

if.then436:                                       ; preds = %if.end428
  %add438 = or disjoint i32 %mul11.1, 15
  %cmp439 = icmp ult i32 %1, %add438
  br i1 %cmp439, label %for.cond441.preheader, label %if.end465

for.cond441.preheader:                            ; preds = %if.then436
  %68 = lshr i32 %18, 2
  %mul447 = and i32 %68, 252
  %add448 = add nuw nsw i32 %mul11.1, %mul447
  %cmp451.not = icmp sgt i32 %add448, %1
  %fneg.2196 = select i1 %cmp451.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2582 = insertelement <4 x float> poison, float %fneg.2196, i64 0
  %cmp451.not.1.not = icmp slt i32 %add448, %1
  %fneg.2196.1 = select i1 %cmp451.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2675 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2582, float %fneg.2196.1, i64 1
  %add449.2 = or disjoint i32 %add448, 2
  %cmp451.not.2 = icmp sgt i32 %add449.2, %1
  %fneg.2196.2 = select i1 %cmp451.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2768 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2675, float %fneg.2196.2, i64 2
  %add449.3 = or disjoint i32 %add448, 3
  %cmp451.not.3 = icmp sgt i32 %add449.3, %1
  %fneg.2196.3 = select i1 %cmp451.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2861 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2768, float %fneg.2196.3, i64 3
  br label %if.end465

if.end465:                                        ; preds = %if.then436, %for.cond441.preheader
  %acc_s.sroa.0.3 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2861, %for.cond441.preheader ], [ zeroinitializer, %if.then436 ]
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.3), !call_argsrelate !89
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.8.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !call_argsrelate !89
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.11.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !call_argsrelate !89
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.17.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !call_argsrelate !89
  br label %if.end494

if.end494:                                        ; preds = %if.end428, %if.end465
  %acc_s.sroa.0.4 = phi <4 x float> [ %72, %if.end465 ], [ %acc_s.sroa.0.2, %if.end428 ]
  %or.cond2352 = icmp ugt i32 %mul11.4, 1023
  %cmp501.not = icmp sgt i32 %mul11.4, %1
  %or.cond2353 = or i1 %or.cond2352, %cmp501.not
  br i1 %or.cond2353, label %if.end526, label %for.cond503.preheader

for.cond503.preheader:                            ; preds = %if.end494
  %mul508 = shl nsw i32 %0, 16
  %73 = shl nsw i32 %cond.i.i2211.4, 10
  %mul510 = and i32 %73, 64512
  %mul515 = shl nuw nsw i32 %18, 3
  %add511 = or disjoint i32 %mul515, %mul508
  %add513 = add nuw nsw i32 %add511, %mul510
  %74 = zext nneg i32 %add513 to i64
  %add.ptr518 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %74
  %K_ring1.sroa.0.0.copyload2988 = load <4 x half>, ptr addrspace(4) %add.ptr518, align 16
  %K_ring1.sroa.8.0.add.ptr518.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr518, i64 8
  %K_ring1.sroa.8.0.copyload2990 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.8.0.add.ptr518.sroa_idx, align 8
  %75 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %74
  %add.ptr518.1 = getelementptr inbounds i8, ptr addrspace(4) %75, i64 1024
  %K_ring1.sroa.11.16.copyload2996 = load <4 x half>, ptr addrspace(4) %add.ptr518.1, align 16
  %K_ring1.sroa.17.16.add.ptr518.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %75, i64 1032
  %K_ring1.sroa.17.16.copyload2998 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.17.16.add.ptr518.1.sroa_idx, align 8
  br label %if.end526

if.end526:                                        ; preds = %for.cond503.preheader, %if.end494
  %K_ring1.sroa.17.1 = phi <4 x half> [ %K_ring1.sroa.17.0, %if.end494 ], [ %K_ring1.sroa.17.16.copyload2998, %for.cond503.preheader ]
  %K_ring1.sroa.11.1 = phi <4 x half> [ %K_ring1.sroa.11.0, %if.end494 ], [ %K_ring1.sroa.11.16.copyload2996, %for.cond503.preheader ]
  %K_ring1.sroa.8.1 = phi <4 x half> [ %K_ring1.sroa.8.0, %if.end494 ], [ %K_ring1.sroa.8.0.copyload2990, %for.cond503.preheader ]
  %K_ring1.sroa.0.1 = phi <4 x half> [ %K_ring1.sroa.0.0, %if.end494 ], [ %K_ring1.sroa.0.0.copyload2988, %for.cond503.preheader ]
  br i1 %or.cond2337, label %if.end592, label %for.body537.preheader

for.body537.preheader:                            ; preds = %if.end526
  %acc_s.sroa.0.0.vec.extract2584 = extractelement <4 x float> %acc_s.sroa.0.4, i64 0
  %mul540 = fmul contract float %acc_s.sroa.0.0.vec.extract2584, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul540, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %acc_s.sroa.0.0.vec.insert2586 = insertelement <4 x float> poison, float %77, i64 0
  %acc_s.sroa.0.4.vec.extract2677 = extractelement <4 x float> %acc_s.sroa.0.4, i64 1
  %mul540.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2677, 0x3FB99999A0000000
  %78 = tail call contract noundef float @llvm.minnum.f32(float %mul540.1, float 0x4024CB5EC0000000)
  %79 = tail call contract noundef float @llvm.exp.f32(float %78)
  %acc_s.sroa.0.4.vec.insert2679 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2586, float %79, i64 1
  %acc_s.sroa.0.8.vec.extract2770 = extractelement <4 x float> %acc_s.sroa.0.4, i64 2
  %mul540.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2770, 0x3FB99999A0000000
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul540.2, float 0x4024CB5EC0000000)
  %81 = tail call contract noundef float @llvm.exp.f32(float %80)
  %acc_s.sroa.0.8.vec.insert2772 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2679, float %81, i64 2
  %acc_s.sroa.0.12.vec.extract2863 = extractelement <4 x float> %acc_s.sroa.0.4, i64 3
  %mul540.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2863, 0x3FB99999A0000000
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul540.3, float 0x4024CB5EC0000000)
  %83 = tail call contract noundef float @llvm.exp.f32(float %82)
  %acc_s.sroa.0.12.vec.insert2865 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2772, float %83, i64 3
  %add556 = fadd contract float %sum_acc.sroa.0.0, %77
  %add556.1 = fadd contract float %sum_acc.sroa.20.0, %79
  %add556.2 = fadd contract float %sum_acc.sroa.38.0, %81
  %add556.3 = fadd contract float %sum_acc.sroa.56.0, %83
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %85 = insertelement <4 x i16> poison, i16 %84, i64 0
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %79)
  %87 = insertelement <4 x i16> %85, i16 %86, i64 1
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81)
  %89 = insertelement <4 x i16> %87, i16 %88, i64 2
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83)
  %91 = insertelement <4 x i16> %89, i16 %90, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2537 = bitcast <4 x i16> %91 to <4 x half>
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2537, <4 x float> zeroinitializer)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2537, <4 x float> zeroinitializer)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2537, <4 x float> zeroinitializer)
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2537, <4 x float> zeroinitializer)
  br label %if.end592

if.end592:                                        ; preds = %for.body537.preheader, %if.end526
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end526 ], [ %95, %for.body537.preheader ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end526 ], [ %94, %for.body537.preheader ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end526 ], [ %93, %for.body537.preheader ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end526 ], [ %92, %for.body537.preheader ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end526 ], [ %add556.3, %for.body537.preheader ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end526 ], [ %add556.2, %for.body537.preheader ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end526 ], [ %add556.1, %for.body537.preheader ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end526 ], [ %add556, %for.body537.preheader ]
  %acc_s.sroa.0.5 = phi <4 x float> [ %acc_s.sroa.0.4, %if.end526 ], [ %acc_s.sroa.0.12.vec.insert2865, %for.body537.preheader ]
  br i1 %or.cond2346, label %if.end624, label %for.cond601.preheader

for.cond601.preheader:                            ; preds = %if.end592
  %mul606 = shl nsw i32 %0, 16
  %96 = shl nsw i32 %cond.i.i2211.3, 10
  %mul608 = and i32 %96, 64512
  %mul613 = shl nuw nsw i32 %18, 3
  %add609 = or disjoint i32 %mul613, %mul606
  %add611 = add nuw nsw i32 %add609, %mul608
  %97 = zext nneg i32 %add611 to i64
  %add.ptr616 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %97
  %V_ring1.sroa.0.0.copyload2933 = load <4 x half>, ptr addrspace(4) %add.ptr616, align 16
  %V_ring1.sroa.10.0.add.ptr616.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr616, i64 8
  %V_ring1.sroa.10.0.copyload2936 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr616.sroa_idx, align 8
  %98 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %97
  %add.ptr616.1 = getelementptr inbounds i8, ptr addrspace(4) %98, i64 1024
  %V_ring1.sroa.14.16.copyload2945 = load <4 x half>, ptr addrspace(4) %add.ptr616.1, align 16
  %V_ring1.sroa.22.16.add.ptr616.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %98, i64 1032
  %V_ring1.sroa.22.16.copyload2948 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr616.1.sroa_idx, align 8
  br label %if.end624

if.end624:                                        ; preds = %for.cond601.preheader, %if.end592
  %V_ring1.sroa.22.1 = phi <4 x half> [ %V_ring1.sroa.22.0, %if.end592 ], [ %V_ring1.sroa.22.16.copyload2948, %for.cond601.preheader ]
  %V_ring1.sroa.14.1 = phi <4 x half> [ %V_ring1.sroa.14.0, %if.end592 ], [ %V_ring1.sroa.14.16.copyload2945, %for.cond601.preheader ]
  %V_ring1.sroa.10.1 = phi <4 x half> [ %V_ring1.sroa.10.0, %if.end592 ], [ %V_ring1.sroa.10.0.copyload2936, %for.cond601.preheader ]
  %V_ring1.sroa.0.1 = phi <4 x half> [ %V_ring1.sroa.0.0, %if.end592 ], [ %V_ring1.sroa.0.0.copyload2933, %for.cond601.preheader ]
  %or.cond2358 = icmp ugt i32 %mul11.2, 1023
  %brmerge3271 = or i1 %or.cond2358, %cmp139.not
  br i1 %brmerge3271, label %if.end690, label %if.then632

if.then632:                                       ; preds = %if.end624
  %add634 = or disjoint i32 %mul11.2, 15
  %cmp635 = icmp ult i32 %1, %add634
  br i1 %cmp635, label %for.cond637.preheader, label %if.end661

for.cond637.preheader:                            ; preds = %if.then632
  %99 = lshr i32 %18, 2
  %mul643 = and i32 %99, 252
  %add644 = add nuw nsw i32 %mul11.2, %mul643
  %cmp647.not = icmp sgt i32 %add644, %1
  %fneg.2197 = select i1 %cmp647.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2592 = insertelement <4 x float> poison, float %fneg.2197, i64 0
  %cmp647.not.1.not = icmp slt i32 %add644, %1
  %fneg.2197.1 = select i1 %cmp647.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2685 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2592, float %fneg.2197.1, i64 1
  %add645.2 = or disjoint i32 %add644, 2
  %cmp647.not.2 = icmp sgt i32 %add645.2, %1
  %fneg.2197.2 = select i1 %cmp647.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2778 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2685, float %fneg.2197.2, i64 2
  %add645.3 = or disjoint i32 %add644, 3
  %cmp647.not.3 = icmp sgt i32 %add645.3, %1
  %fneg.2197.3 = select i1 %cmp647.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2871 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2778, float %fneg.2197.3, i64 3
  br label %if.end661

if.end661:                                        ; preds = %if.then632, %for.cond637.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2871, %for.cond637.preheader ], [ zeroinitializer, %if.then632 ]
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !89
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %100), !call_argsrelate !89
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %101), !call_argsrelate !89
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %102), !call_argsrelate !89
  br label %if.end690

if.end690:                                        ; preds = %if.end624, %if.end661
  %acc_s.sroa.0.7 = phi <4 x float> [ %103, %if.end661 ], [ %acc_s.sroa.0.5, %if.end624 ]
  %or.cond2359 = icmp ugt i32 %mul11.5, 1023
  %cmp697.not = icmp sgt i32 %mul11.5, %1
  %or.cond2360 = or i1 %or.cond2359, %cmp697.not
  br i1 %or.cond2360, label %if.end722, label %for.cond699.preheader

for.cond699.preheader:                            ; preds = %if.end690
  %mul704 = shl nsw i32 %0, 16
  %104 = shl nsw i32 %cond.i.i2211.5, 10
  %mul706 = and i32 %104, 64512
  %mul711 = shl nuw nsw i32 %18, 3
  %add707 = or disjoint i32 %mul711, %mul704
  %add709 = add nuw nsw i32 %add707, %mul706
  %105 = zext nneg i32 %add709 to i64
  %add.ptr714 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %105
  %K_ring2.sroa.0.0.copyload2979 = load <4 x half>, ptr addrspace(4) %add.ptr714, align 16
  %K_ring2.sroa.6.0.add.ptr714.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr714, i64 8
  %K_ring2.sroa.6.0.copyload2980 = load <4 x half>, ptr addrspace(4) %K_ring2.sroa.6.0.add.ptr714.sroa_idx, align 8
  %106 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %105
  %add.ptr714.1 = getelementptr inbounds i8, ptr addrspace(4) %106, i64 1024
  %K_ring2.sroa.8.16.copyload2983 = load <4 x half>, ptr addrspace(4) %add.ptr714.1, align 16
  %K_ring2.sroa.12.16.add.ptr714.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %106, i64 1032
  %K_ring2.sroa.12.16.copyload2984 = load <4 x half>, ptr addrspace(4) %K_ring2.sroa.12.16.add.ptr714.1.sroa_idx, align 8
  br label %if.end722

if.end722:                                        ; preds = %for.cond699.preheader, %if.end690
  %K_ring2.sroa.12.1 = phi <4 x half> [ %K_ring2.sroa.12.0, %if.end690 ], [ %K_ring2.sroa.12.16.copyload2984, %for.cond699.preheader ]
  %K_ring2.sroa.8.1 = phi <4 x half> [ %K_ring2.sroa.8.0, %if.end690 ], [ %K_ring2.sroa.8.16.copyload2983, %for.cond699.preheader ]
  %K_ring2.sroa.6.1 = phi <4 x half> [ %K_ring2.sroa.6.0, %if.end690 ], [ %K_ring2.sroa.6.0.copyload2980, %for.cond699.preheader ]
  %K_ring2.sroa.0.1 = phi <4 x half> [ %K_ring2.sroa.0.0, %if.end690 ], [ %K_ring2.sroa.0.0.copyload2979, %for.cond699.preheader ]
  br i1 %or.cond2339, label %if.end788, label %for.body733.preheader

for.body733.preheader:                            ; preds = %if.end722
  %acc_s.sroa.0.0.vec.extract2594 = extractelement <4 x float> %acc_s.sroa.0.7, i64 0
  %mul736 = fmul contract float %acc_s.sroa.0.0.vec.extract2594, 0x3FB99999A0000000
  %107 = tail call contract noundef float @llvm.minnum.f32(float %mul736, float 0x4024CB5EC0000000)
  %108 = tail call contract noundef float @llvm.exp.f32(float %107)
  %acc_s.sroa.0.0.vec.insert2596 = insertelement <4 x float> poison, float %108, i64 0
  %acc_s.sroa.0.4.vec.extract2687 = extractelement <4 x float> %acc_s.sroa.0.7, i64 1
  %mul736.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2687, 0x3FB99999A0000000
  %109 = tail call contract noundef float @llvm.minnum.f32(float %mul736.1, float 0x4024CB5EC0000000)
  %110 = tail call contract noundef float @llvm.exp.f32(float %109)
  %acc_s.sroa.0.4.vec.insert2689 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2596, float %110, i64 1
  %acc_s.sroa.0.8.vec.extract2780 = extractelement <4 x float> %acc_s.sroa.0.7, i64 2
  %mul736.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2780, 0x3FB99999A0000000
  %111 = tail call contract noundef float @llvm.minnum.f32(float %mul736.2, float 0x4024CB5EC0000000)
  %112 = tail call contract noundef float @llvm.exp.f32(float %111)
  %acc_s.sroa.0.8.vec.insert2782 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2689, float %112, i64 2
  %acc_s.sroa.0.12.vec.extract2873 = extractelement <4 x float> %acc_s.sroa.0.7, i64 3
  %mul736.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2873, 0x3FB99999A0000000
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul736.3, float 0x4024CB5EC0000000)
  %114 = tail call contract noundef float @llvm.exp.f32(float %113)
  %acc_s.sroa.0.12.vec.insert2875 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2782, float %114, i64 3
  %add752 = fadd contract float %sum_acc.sroa.0.1, %108
  %add752.1 = fadd contract float %sum_acc.sroa.20.1, %110
  %add752.2 = fadd contract float %sum_acc.sroa.38.1, %112
  %add752.3 = fadd contract float %sum_acc.sroa.56.1, %114
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %108)
  %116 = insertelement <4 x i16> poison, i16 %115, i64 0
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %110)
  %118 = insertelement <4 x i16> %116, i16 %117, i64 1
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %112)
  %120 = insertelement <4 x i16> %118, i16 %119, i64 2
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114)
  %122 = insertelement <4 x i16> %120, i16 %121, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2539 = bitcast <4 x i16> %122 to <4 x half>
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2539, <4 x float> %acc_o.sroa.0.0)
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2539, <4 x float> %acc_o.sroa.34.0)
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2539, <4 x float> %acc_o.sroa.66.0)
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2539, <4 x float> %acc_o.sroa.98.0)
  br label %if.end788

if.end788:                                        ; preds = %for.body733.preheader, %if.end722
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end722 ], [ %126, %for.body733.preheader ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end722 ], [ %125, %for.body733.preheader ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end722 ], [ %124, %for.body733.preheader ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end722 ], [ %123, %for.body733.preheader ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end722 ], [ %add752.3, %for.body733.preheader ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end722 ], [ %add752.2, %for.body733.preheader ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end722 ], [ %add752.1, %for.body733.preheader ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end722 ], [ %add752, %for.body733.preheader ]
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.7, %if.end722 ], [ %acc_s.sroa.0.12.vec.insert2875, %for.body733.preheader ]
  br i1 %or.cond2353, label %if.end820, label %for.cond797.preheader

for.cond797.preheader:                            ; preds = %if.end788
  %mul802 = shl nsw i32 %0, 16
  %127 = shl nsw i32 %cond.i.i2211.4, 10
  %mul804 = and i32 %127, 64512
  %mul809 = shl nuw nsw i32 %18, 3
  %add805 = or disjoint i32 %mul809, %mul802
  %add807 = add nuw nsw i32 %add805, %mul804
  %128 = zext nneg i32 %add807 to i64
  %add.ptr812 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %128
  %V_ring0.sroa.0.0.copyload2958 = load <4 x half>, ptr addrspace(4) %add.ptr812, align 16
  %V_ring0.sroa.10.0.add.ptr812.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr812, i64 8
  %V_ring0.sroa.10.0.copyload2961 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr812.sroa_idx, align 8
  %129 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %128
  %add.ptr812.1 = getelementptr inbounds i8, ptr addrspace(4) %129, i64 1024
  %V_ring0.sroa.14.16.copyload2970 = load <4 x half>, ptr addrspace(4) %add.ptr812.1, align 16
  %V_ring0.sroa.22.16.add.ptr812.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %129, i64 1032
  %V_ring0.sroa.22.16.copyload2973 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr812.1.sroa_idx, align 8
  br label %if.end820

if.end820:                                        ; preds = %for.cond797.preheader, %if.end788
  %V_ring0.sroa.22.2 = phi <4 x half> [ %V_ring0.sroa.22.1, %if.end788 ], [ %V_ring0.sroa.22.16.copyload2973, %for.cond797.preheader ]
  %V_ring0.sroa.14.2 = phi <4 x half> [ %V_ring0.sroa.14.1, %if.end788 ], [ %V_ring0.sroa.14.16.copyload2970, %for.cond797.preheader ]
  %V_ring0.sroa.10.2 = phi <4 x half> [ %V_ring0.sroa.10.1, %if.end788 ], [ %V_ring0.sroa.10.0.copyload2961, %for.cond797.preheader ]
  %V_ring0.sroa.0.2 = phi <4 x half> [ %V_ring0.sroa.0.1, %if.end788 ], [ %V_ring0.sroa.0.0.copyload2958, %for.cond797.preheader ]
  %or.cond2365 = icmp ugt i32 %mul11.3, 1023
  %brmerge3272 = or i1 %or.cond2365, %cmp305.not
  br i1 %brmerge3272, label %if.end886, label %if.then828

if.then828:                                       ; preds = %if.end820
  %add830 = or disjoint i32 %mul11.3, 15
  %cmp831 = icmp ult i32 %1, %add830
  br i1 %cmp831, label %for.cond833.preheader, label %if.end857

for.cond833.preheader:                            ; preds = %if.then828
  %130 = lshr i32 %18, 2
  %mul839 = and i32 %130, 252
  %add840 = add nuw nsw i32 %mul11.3, %mul839
  %cmp843.not = icmp sgt i32 %add840, %1
  %fneg.2198 = select i1 %cmp843.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2602 = insertelement <4 x float> poison, float %fneg.2198, i64 0
  %cmp843.not.1.not = icmp slt i32 %add840, %1
  %fneg.2198.1 = select i1 %cmp843.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2695 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2602, float %fneg.2198.1, i64 1
  %add841.2 = or disjoint i32 %add840, 2
  %cmp843.not.2 = icmp sgt i32 %add841.2, %1
  %fneg.2198.2 = select i1 %cmp843.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2788 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2695, float %fneg.2198.2, i64 2
  %add841.3 = or disjoint i32 %add840, 3
  %cmp843.not.3 = icmp sgt i32 %add841.3, %1
  %fneg.2198.3 = select i1 %cmp843.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2881 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2788, float %fneg.2198.3, i64 3
  br label %if.end857

if.end857:                                        ; preds = %if.then828, %for.cond833.preheader
  %acc_s.sroa.0.9 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2881, %for.cond833.preheader ], [ zeroinitializer, %if.then828 ]
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.9), !call_argsrelate !89
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.8.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %131), !call_argsrelate !89
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.11.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %132), !call_argsrelate !89
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.17.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %133), !call_argsrelate !89
  br label %if.end886

if.end886:                                        ; preds = %if.end820, %if.end857
  %acc_s.sroa.0.10 = phi <4 x float> [ %134, %if.end857 ], [ %acc_s.sroa.0.8, %if.end820 ]
  %or.cond2366 = icmp ugt i32 %mul11.6, 1023
  %cmp893.not = icmp sgt i32 %mul11.6, %1
  %or.cond2367 = or i1 %or.cond2366, %cmp893.not
  br i1 %or.cond2367, label %if.end918, label %for.cond895.preheader

for.cond895.preheader:                            ; preds = %if.end886
  %mul900 = shl nsw i32 %0, 16
  %135 = shl nsw i32 %cond.i.i2211.6, 10
  %mul902 = and i32 %135, 64512
  %mul907 = shl nuw nsw i32 %18, 3
  %add903 = or disjoint i32 %mul907, %mul900
  %add905 = add nuw nsw i32 %add903, %mul902
  %136 = zext nneg i32 %add905 to i64
  %add.ptr910 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136
  %K_ring0.sroa.0.0.copyload3005 = load <4 x half>, ptr addrspace(4) %add.ptr910, align 16
  %K_ring0.sroa.8.0.add.ptr910.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr910, i64 8
  %K_ring0.sroa.8.0.copyload3007 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.8.0.add.ptr910.sroa_idx, align 8
  %137 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136
  %add.ptr910.1 = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1024
  %K_ring0.sroa.11.16.copyload3013 = load <4 x half>, ptr addrspace(4) %add.ptr910.1, align 16
  %K_ring0.sroa.17.16.add.ptr910.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1032
  %K_ring0.sroa.17.16.copyload3015 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.17.16.add.ptr910.1.sroa_idx, align 8
  br label %if.end918

if.end918:                                        ; preds = %for.cond895.preheader, %if.end886
  %K_ring0.sroa.17.2 = phi <4 x half> [ %K_ring0.sroa.17.1, %if.end886 ], [ %K_ring0.sroa.17.16.copyload3015, %for.cond895.preheader ]
  %K_ring0.sroa.11.2 = phi <4 x half> [ %K_ring0.sroa.11.1, %if.end886 ], [ %K_ring0.sroa.11.16.copyload3013, %for.cond895.preheader ]
  %K_ring0.sroa.8.2 = phi <4 x half> [ %K_ring0.sroa.8.1, %if.end886 ], [ %K_ring0.sroa.8.0.copyload3007, %for.cond895.preheader ]
  %K_ring0.sroa.0.2 = phi <4 x half> [ %K_ring0.sroa.0.1, %if.end886 ], [ %K_ring0.sroa.0.0.copyload3005, %for.cond895.preheader ]
  br i1 %or.cond2346, label %if.end984, label %for.body929.preheader

for.body929.preheader:                            ; preds = %if.end918
  %acc_s.sroa.0.0.vec.extract2604 = extractelement <4 x float> %acc_s.sroa.0.10, i64 0
  %mul932 = fmul contract float %acc_s.sroa.0.0.vec.extract2604, 0x3FB99999A0000000
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul932, float 0x4024CB5EC0000000)
  %139 = tail call contract noundef float @llvm.exp.f32(float %138)
  %acc_s.sroa.0.0.vec.insert2606 = insertelement <4 x float> poison, float %139, i64 0
  %acc_s.sroa.0.4.vec.extract2697 = extractelement <4 x float> %acc_s.sroa.0.10, i64 1
  %mul932.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2697, 0x3FB99999A0000000
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul932.1, float 0x4024CB5EC0000000)
  %141 = tail call contract noundef float @llvm.exp.f32(float %140)
  %acc_s.sroa.0.4.vec.insert2699 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2606, float %141, i64 1
  %acc_s.sroa.0.8.vec.extract2790 = extractelement <4 x float> %acc_s.sroa.0.10, i64 2
  %mul932.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2790, 0x3FB99999A0000000
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul932.2, float 0x4024CB5EC0000000)
  %143 = tail call contract noundef float @llvm.exp.f32(float %142)
  %acc_s.sroa.0.8.vec.insert2792 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2699, float %143, i64 2
  %acc_s.sroa.0.12.vec.extract2883 = extractelement <4 x float> %acc_s.sroa.0.10, i64 3
  %mul932.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2883, 0x3FB99999A0000000
  %144 = tail call contract noundef float @llvm.minnum.f32(float %mul932.3, float 0x4024CB5EC0000000)
  %145 = tail call contract noundef float @llvm.exp.f32(float %144)
  %acc_s.sroa.0.12.vec.insert2885 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2792, float %145, i64 3
  %add948 = fadd contract float %sum_acc.sroa.0.2, %139
  %add948.1 = fadd contract float %sum_acc.sroa.20.2, %141
  %add948.2 = fadd contract float %sum_acc.sroa.38.2, %143
  %add948.3 = fadd contract float %sum_acc.sroa.56.2, %145
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139)
  %147 = insertelement <4 x i16> poison, i16 %146, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141)
  %149 = insertelement <4 x i16> %147, i16 %148, i64 1
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143)
  %151 = insertelement <4 x i16> %149, i16 %150, i64 2
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %145)
  %153 = insertelement <4 x i16> %151, i16 %152, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2541 = bitcast <4 x i16> %153 to <4 x half>
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2541, <4 x float> %acc_o_alt.sroa.0.0)
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2541, <4 x float> %acc_o_alt.sroa.18.0)
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2541, <4 x float> %acc_o_alt.sroa.34.0)
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2541, <4 x float> %acc_o_alt.sroa.50.0)
  br label %if.end984

if.end984:                                        ; preds = %for.body929.preheader, %if.end918
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end918 ], [ %157, %for.body929.preheader ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end918 ], [ %156, %for.body929.preheader ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end918 ], [ %155, %for.body929.preheader ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end918 ], [ %154, %for.body929.preheader ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end918 ], [ %add948.3, %for.body929.preheader ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end918 ], [ %add948.2, %for.body929.preheader ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end918 ], [ %add948.1, %for.body929.preheader ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end918 ], [ %add948, %for.body929.preheader ]
  %acc_s.sroa.0.11 = phi <4 x float> [ %acc_s.sroa.0.10, %if.end918 ], [ %acc_s.sroa.0.12.vec.insert2885, %for.body929.preheader ]
  br i1 %or.cond2360, label %if.end1016, label %for.cond993.preheader

for.cond993.preheader:                            ; preds = %if.end984
  %mul998 = shl nsw i32 %0, 16
  %158 = shl nsw i32 %cond.i.i2211.5, 10
  %mul1000 = and i32 %158, 64512
  %mul1005 = shl nuw nsw i32 %18, 3
  %add1001 = or disjoint i32 %mul1005, %mul998
  %add1003 = add nuw nsw i32 %add1001, %mul1000
  %159 = zext nneg i32 %add1003 to i64
  %add.ptr1008 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %159
  %V_ring1.sroa.0.0.copyload2934 = load <4 x half>, ptr addrspace(4) %add.ptr1008, align 16
  %V_ring1.sroa.10.0.add.ptr1008.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1008, i64 8
  %V_ring1.sroa.10.0.copyload2937 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr1008.sroa_idx, align 8
  %160 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %159
  %add.ptr1008.1 = getelementptr inbounds i8, ptr addrspace(4) %160, i64 1024
  %V_ring1.sroa.14.16.copyload2946 = load <4 x half>, ptr addrspace(4) %add.ptr1008.1, align 16
  %V_ring1.sroa.22.16.add.ptr1008.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %160, i64 1032
  %V_ring1.sroa.22.16.copyload2949 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr1008.1.sroa_idx, align 8
  br label %if.end1016

if.end1016:                                       ; preds = %for.cond993.preheader, %if.end984
  %V_ring1.sroa.22.2 = phi <4 x half> [ %V_ring1.sroa.22.1, %if.end984 ], [ %V_ring1.sroa.22.16.copyload2949, %for.cond993.preheader ]
  %V_ring1.sroa.14.2 = phi <4 x half> [ %V_ring1.sroa.14.1, %if.end984 ], [ %V_ring1.sroa.14.16.copyload2946, %for.cond993.preheader ]
  %V_ring1.sroa.10.2 = phi <4 x half> [ %V_ring1.sroa.10.1, %if.end984 ], [ %V_ring1.sroa.10.0.copyload2937, %for.cond993.preheader ]
  %V_ring1.sroa.0.2 = phi <4 x half> [ %V_ring1.sroa.0.1, %if.end984 ], [ %V_ring1.sroa.0.0.copyload2934, %for.cond993.preheader ]
  %or.cond2372 = icmp ugt i32 %mul11.4, 1023
  %brmerge3273 = or i1 %or.cond2372, %cmp501.not
  br i1 %brmerge3273, label %if.end1082, label %if.then1024

if.then1024:                                      ; preds = %if.end1016
  %add1026 = or disjoint i32 %mul11.4, 15
  %cmp1027 = icmp ult i32 %1, %add1026
  br i1 %cmp1027, label %for.cond1029.preheader, label %if.end1053

for.cond1029.preheader:                           ; preds = %if.then1024
  %161 = lshr i32 %18, 2
  %mul1035 = and i32 %161, 252
  %add1036 = add nuw nsw i32 %mul11.4, %mul1035
  %cmp1039.not = icmp sgt i32 %add1036, %1
  %fneg.2199 = select i1 %cmp1039.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2612 = insertelement <4 x float> poison, float %fneg.2199, i64 0
  %cmp1039.not.1.not = icmp slt i32 %add1036, %1
  %fneg.2199.1 = select i1 %cmp1039.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2705 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2612, float %fneg.2199.1, i64 1
  %add1037.2 = or disjoint i32 %add1036, 2
  %cmp1039.not.2 = icmp sgt i32 %add1037.2, %1
  %fneg.2199.2 = select i1 %cmp1039.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2798 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2705, float %fneg.2199.2, i64 2
  %add1037.3 = or disjoint i32 %add1036, 3
  %cmp1039.not.3 = icmp sgt i32 %add1037.3, %1
  %fneg.2199.3 = select i1 %cmp1039.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2891 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2798, float %fneg.2199.3, i64 3
  br label %if.end1053

if.end1053:                                       ; preds = %if.then1024, %for.cond1029.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2891, %for.cond1029.preheader ], [ zeroinitializer, %if.then1024 ]
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !89
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.8.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %162), !call_argsrelate !89
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.11.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %163), !call_argsrelate !89
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.17.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %164), !call_argsrelate !89
  br label %if.end1082

if.end1082:                                       ; preds = %if.end1016, %if.end1053
  %acc_s.sroa.0.13 = phi <4 x float> [ %165, %if.end1053 ], [ %acc_s.sroa.0.11, %if.end1016 ]
  %or.cond2373 = icmp ugt i32 %mul11.7, 1023
  %cmp1089.not = icmp sgt i32 %mul11.7, %1
  %or.cond2374 = or i1 %or.cond2373, %cmp1089.not
  br i1 %or.cond2374, label %if.end1114, label %for.cond1091.preheader

for.cond1091.preheader:                           ; preds = %if.end1082
  %mul1096 = shl nsw i32 %0, 16
  %166 = shl nsw i32 %cond.i.i2211.7, 10
  %mul1098 = and i32 %166, 64512
  %mul1103 = shl nuw nsw i32 %18, 3
  %add1099 = or disjoint i32 %mul1103, %mul1096
  %add1101 = add nuw nsw i32 %add1099, %mul1098
  %167 = zext nneg i32 %add1101 to i64
  %add.ptr1106 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %167
  %K_ring1.sroa.0.0.copyload2989 = load <4 x half>, ptr addrspace(4) %add.ptr1106, align 16
  %K_ring1.sroa.8.0.add.ptr1106.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1106, i64 8
  %K_ring1.sroa.8.0.copyload2991 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.8.0.add.ptr1106.sroa_idx, align 8
  %168 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %167
  %add.ptr1106.1 = getelementptr inbounds i8, ptr addrspace(4) %168, i64 1024
  %K_ring1.sroa.11.16.copyload2997 = load <4 x half>, ptr addrspace(4) %add.ptr1106.1, align 16
  %K_ring1.sroa.17.16.add.ptr1106.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %168, i64 1032
  %K_ring1.sroa.17.16.copyload2999 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.17.16.add.ptr1106.1.sroa_idx, align 8
  br label %if.end1114

if.end1114:                                       ; preds = %for.cond1091.preheader, %if.end1082
  %K_ring1.sroa.17.2 = phi <4 x half> [ %K_ring1.sroa.17.1, %if.end1082 ], [ %K_ring1.sroa.17.16.copyload2999, %for.cond1091.preheader ]
  %K_ring1.sroa.11.2 = phi <4 x half> [ %K_ring1.sroa.11.1, %if.end1082 ], [ %K_ring1.sroa.11.16.copyload2997, %for.cond1091.preheader ]
  %K_ring1.sroa.8.2 = phi <4 x half> [ %K_ring1.sroa.8.1, %if.end1082 ], [ %K_ring1.sroa.8.0.copyload2991, %for.cond1091.preheader ]
  %K_ring1.sroa.0.2 = phi <4 x half> [ %K_ring1.sroa.0.1, %if.end1082 ], [ %K_ring1.sroa.0.0.copyload2989, %for.cond1091.preheader ]
  br i1 %or.cond2353, label %if.end1180, label %for.body1125.preheader

for.body1125.preheader:                           ; preds = %if.end1114
  %acc_s.sroa.0.0.vec.extract2614 = extractelement <4 x float> %acc_s.sroa.0.13, i64 0
  %mul1128 = fmul contract float %acc_s.sroa.0.0.vec.extract2614, 0x3FB99999A0000000
  %169 = tail call contract noundef float @llvm.minnum.f32(float %mul1128, float 0x4024CB5EC0000000)
  %170 = tail call contract noundef float @llvm.exp.f32(float %169)
  %acc_s.sroa.0.4.vec.extract2707 = extractelement <4 x float> %acc_s.sroa.0.13, i64 1
  %mul1128.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2707, 0x3FB99999A0000000
  %171 = tail call contract noundef float @llvm.minnum.f32(float %mul1128.1, float 0x4024CB5EC0000000)
  %172 = tail call contract noundef float @llvm.exp.f32(float %171)
  %acc_s.sroa.0.8.vec.extract2800 = extractelement <4 x float> %acc_s.sroa.0.13, i64 2
  %mul1128.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2800, 0x3FB99999A0000000
  %173 = tail call contract noundef float @llvm.minnum.f32(float %mul1128.2, float 0x4024CB5EC0000000)
  %174 = tail call contract noundef float @llvm.exp.f32(float %173)
  %acc_s.sroa.0.12.vec.extract2893 = extractelement <4 x float> %acc_s.sroa.0.13, i64 3
  %mul1128.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2893, 0x3FB99999A0000000
  %175 = tail call contract noundef float @llvm.minnum.f32(float %mul1128.3, float 0x4024CB5EC0000000)
  %176 = tail call contract noundef float @llvm.exp.f32(float %175)
  %add1144 = fadd contract float %sum_acc.sroa.0.3, %170
  %add1144.1 = fadd contract float %sum_acc.sroa.20.3, %172
  %add1144.2 = fadd contract float %sum_acc.sroa.38.3, %174
  %add1144.3 = fadd contract float %sum_acc.sroa.56.3, %176
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %170)
  %178 = insertelement <4 x i16> poison, i16 %177, i64 0
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %172)
  %180 = insertelement <4 x i16> %178, i16 %179, i64 1
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %174)
  %182 = insertelement <4 x i16> %180, i16 %181, i64 2
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %176)
  %184 = insertelement <4 x i16> %182, i16 %183, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2543 = bitcast <4 x i16> %184 to <4 x half>
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2543, <4 x float> %acc_o.sroa.0.1)
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2543, <4 x float> %acc_o.sroa.34.1)
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2543, <4 x float> %acc_o.sroa.66.1)
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2543, <4 x float> %acc_o.sroa.98.1)
  br label %if.end1180

if.end1180:                                       ; preds = %for.body1125.preheader, %if.end1114
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end1114 ], [ %188, %for.body1125.preheader ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end1114 ], [ %187, %for.body1125.preheader ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end1114 ], [ %186, %for.body1125.preheader ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1114 ], [ %185, %for.body1125.preheader ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end1114 ], [ %add1144.3, %for.body1125.preheader ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end1114 ], [ %add1144.2, %for.body1125.preheader ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end1114 ], [ %add1144.1, %for.body1125.preheader ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end1114 ], [ %add1144, %for.body1125.preheader ]
  br i1 %or.cond2367, label %if.end1212, label %for.cond1189.preheader

for.cond1189.preheader:                           ; preds = %if.end1180
  %mul1194 = shl nsw i32 %0, 16
  %189 = shl nsw i32 %cond.i.i2211.6, 10
  %mul1196 = and i32 %189, 64512
  %mul1201 = shl nuw nsw i32 %18, 3
  %add1197 = or disjoint i32 %mul1201, %mul1194
  %add1199 = add nuw nsw i32 %add1197, %mul1196
  %190 = zext nneg i32 %add1199 to i64
  %add.ptr1204 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %190
  %V_ring0.sroa.0.0.copyload2959 = load <4 x half>, ptr addrspace(4) %add.ptr1204, align 16
  %V_ring0.sroa.10.0.add.ptr1204.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1204, i64 8
  %V_ring0.sroa.10.0.copyload2962 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.10.0.add.ptr1204.sroa_idx, align 8
  %191 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %190
  %add.ptr1204.1 = getelementptr inbounds i8, ptr addrspace(4) %191, i64 1024
  %V_ring0.sroa.14.16.copyload2971 = load <4 x half>, ptr addrspace(4) %add.ptr1204.1, align 16
  %V_ring0.sroa.22.16.add.ptr1204.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %191, i64 1032
  %V_ring0.sroa.22.16.copyload2974 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.22.16.add.ptr1204.1.sroa_idx, align 8
  br label %if.end1212

if.end1212:                                       ; preds = %for.cond1189.preheader, %if.end1180
  %V_ring0.sroa.22.3 = phi <4 x half> [ %V_ring0.sroa.22.2, %if.end1180 ], [ %V_ring0.sroa.22.16.copyload2974, %for.cond1189.preheader ]
  %V_ring0.sroa.14.3 = phi <4 x half> [ %V_ring0.sroa.14.2, %if.end1180 ], [ %V_ring0.sroa.14.16.copyload2971, %for.cond1189.preheader ]
  %V_ring0.sroa.10.3 = phi <4 x half> [ %V_ring0.sroa.10.2, %if.end1180 ], [ %V_ring0.sroa.10.0.copyload2962, %for.cond1189.preheader ]
  %V_ring0.sroa.0.3 = phi <4 x half> [ %V_ring0.sroa.0.2, %if.end1180 ], [ %V_ring0.sroa.0.0.copyload2959, %for.cond1189.preheader ]
  %or.cond2379 = icmp ult i32 %mul11.5, 1024
  br i1 %or.cond2379, label %land.lhs.true1217, label %if.end1336

land.lhs.true1217:                                ; preds = %if.end1212
  br i1 %cmp697.not, label %if.end1336, label %if.then1220

if.then1220:                                      ; preds = %land.lhs.true1217
  %add1222 = or disjoint i32 %mul11.5, 15
  %cmp1223 = icmp ult i32 %1, %add1222
  br i1 %cmp1223, label %for.cond1225.preheader, label %if.end1249

for.cond1225.preheader:                           ; preds = %if.then1220
  %192 = lshr i32 %18, 2
  %mul1231 = and i32 %192, 252
  %add1232 = add nuw nsw i32 %mul11.5, %mul1231
  %cmp1235.not = icmp sgt i32 %add1232, %1
  %fneg.2200 = select i1 %cmp1235.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2622 = insertelement <4 x float> poison, float %fneg.2200, i64 0
  %cmp1235.not.1.not = icmp slt i32 %add1232, %1
  %fneg.2200.1 = select i1 %cmp1235.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2715 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2622, float %fneg.2200.1, i64 1
  %add1233.2 = or disjoint i32 %add1232, 2
  %cmp1235.not.2 = icmp sgt i32 %add1233.2, %1
  %fneg.2200.2 = select i1 %cmp1235.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2808 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2715, float %fneg.2200.2, i64 2
  %add1233.3 = or disjoint i32 %add1232, 3
  %cmp1235.not.3 = icmp sgt i32 %add1233.3, %1
  %fneg.2200.3 = select i1 %cmp1235.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2901 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2808, float %fneg.2200.3, i64 3
  br label %if.end1249

if.end1249:                                       ; preds = %if.then1220, %for.cond1225.preheader
  %acc_s.sroa.0.15 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2901, %for.cond1225.preheader ], [ zeroinitializer, %if.then1220 ]
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.15), !call_argsrelate !89
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %193), !call_argsrelate !89
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %194), !call_argsrelate !89
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %195), !call_argsrelate !89
  %acc_s.sroa.0.0.vec.extract2624 = extractelement <4 x float> %196, i64 0
  %mul1284 = fmul contract float %acc_s.sroa.0.0.vec.extract2624, 0x3FB99999A0000000
  %197 = tail call contract noundef float @llvm.minnum.f32(float %mul1284, float 0x4024CB5EC0000000)
  %198 = tail call contract noundef float @llvm.exp.f32(float %197)
  %acc_s.sroa.0.4.vec.extract2717 = extractelement <4 x float> %196, i64 1
  %mul1284.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2717, 0x3FB99999A0000000
  %199 = tail call contract noundef float @llvm.minnum.f32(float %mul1284.1, float 0x4024CB5EC0000000)
  %200 = tail call contract noundef float @llvm.exp.f32(float %199)
  %acc_s.sroa.0.8.vec.extract2810 = extractelement <4 x float> %196, i64 2
  %mul1284.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2810, 0x3FB99999A0000000
  %201 = tail call contract noundef float @llvm.minnum.f32(float %mul1284.2, float 0x4024CB5EC0000000)
  %202 = tail call contract noundef float @llvm.exp.f32(float %201)
  %acc_s.sroa.0.12.vec.extract2903 = extractelement <4 x float> %196, i64 3
  %mul1284.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2903, 0x3FB99999A0000000
  %203 = tail call contract noundef float @llvm.minnum.f32(float %mul1284.3, float 0x4024CB5EC0000000)
  %204 = tail call contract noundef float @llvm.exp.f32(float %203)
  %add1300 = fadd contract float %sum_acc.sroa.0.4, %198
  %add1300.1 = fadd contract float %sum_acc.sroa.20.4, %200
  %add1300.2 = fadd contract float %sum_acc.sroa.38.4, %202
  %add1300.3 = fadd contract float %sum_acc.sroa.56.4, %204
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %198)
  %206 = insertelement <4 x i16> poison, i16 %205, i64 0
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %200)
  %208 = insertelement <4 x i16> %206, i16 %207, i64 1
  %209 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %202)
  %210 = insertelement <4 x i16> %208, i16 %209, i64 2
  %211 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %204)
  %212 = insertelement <4 x i16> %210, i16 %211, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2545 = bitcast <4 x i16> %212 to <4 x half>
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2545, <4 x float> %acc_o_alt.sroa.0.1)
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2545, <4 x float> %acc_o_alt.sroa.18.1)
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2545, <4 x float> %acc_o_alt.sroa.34.1)
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2545, <4 x float> %acc_o_alt.sroa.50.1)
  br label %if.end1336

if.end1336:                                       ; preds = %if.end1249, %land.lhs.true1217, %if.end1212
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %land.lhs.true1217 ], [ %216, %if.end1249 ], [ %acc_o_alt.sroa.50.1, %if.end1212 ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %land.lhs.true1217 ], [ %215, %if.end1249 ], [ %acc_o_alt.sroa.34.1, %if.end1212 ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %land.lhs.true1217 ], [ %214, %if.end1249 ], [ %acc_o_alt.sroa.18.1, %if.end1212 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %land.lhs.true1217 ], [ %213, %if.end1249 ], [ %acc_o_alt.sroa.0.1, %if.end1212 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true1217 ], [ %add1300.3, %if.end1249 ], [ %sum_acc.sroa.56.4, %if.end1212 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true1217 ], [ %add1300.2, %if.end1249 ], [ %sum_acc.sroa.38.4, %if.end1212 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true1217 ], [ %add1300.1, %if.end1249 ], [ %sum_acc.sroa.20.4, %if.end1212 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true1217 ], [ %add1300, %if.end1249 ], [ %sum_acc.sroa.0.4, %if.end1212 ]
  br i1 %or.cond2374, label %if.end1368, label %for.cond1345.preheader

for.cond1345.preheader:                           ; preds = %if.end1336
  %mul1350 = shl nsw i32 %0, 16
  %217 = shl nsw i32 %cond.i.i2211.7, 10
  %mul1352 = and i32 %217, 64512
  %mul1357 = shl nuw nsw i32 %18, 3
  %add1353 = or disjoint i32 %mul1357, %mul1350
  %add1355 = add nuw nsw i32 %add1353, %mul1352
  %218 = zext nneg i32 %add1355 to i64
  %add.ptr1360 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218
  %V_ring1.sroa.0.0.copyload2935 = load <4 x half>, ptr addrspace(4) %add.ptr1360, align 16
  %V_ring1.sroa.10.0.add.ptr1360.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1360, i64 8
  %V_ring1.sroa.10.0.copyload2938 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.10.0.add.ptr1360.sroa_idx, align 8
  %219 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218
  %add.ptr1360.1 = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1024
  %V_ring1.sroa.14.16.copyload2947 = load <4 x half>, ptr addrspace(4) %add.ptr1360.1, align 16
  %V_ring1.sroa.22.16.add.ptr1360.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1032
  %V_ring1.sroa.22.16.copyload2950 = load <4 x half>, ptr addrspace(4) %V_ring1.sroa.22.16.add.ptr1360.1.sroa_idx, align 8
  br label %if.end1368

if.end1368:                                       ; preds = %for.cond1345.preheader, %if.end1336
  %V_ring1.sroa.22.3 = phi <4 x half> [ %V_ring1.sroa.22.2, %if.end1336 ], [ %V_ring1.sroa.22.16.copyload2950, %for.cond1345.preheader ]
  %V_ring1.sroa.14.3 = phi <4 x half> [ %V_ring1.sroa.14.2, %if.end1336 ], [ %V_ring1.sroa.14.16.copyload2947, %for.cond1345.preheader ]
  %V_ring1.sroa.10.3 = phi <4 x half> [ %V_ring1.sroa.10.2, %if.end1336 ], [ %V_ring1.sroa.10.0.copyload2938, %for.cond1345.preheader ]
  %V_ring1.sroa.0.3 = phi <4 x half> [ %V_ring1.sroa.0.2, %if.end1336 ], [ %V_ring1.sroa.0.0.copyload2935, %for.cond1345.preheader ]
  %or.cond2382 = icmp ult i32 %mul11.6, 1024
  br i1 %or.cond2382, label %land.lhs.true1373, label %if.end1492

land.lhs.true1373:                                ; preds = %if.end1368
  br i1 %cmp893.not, label %if.end1492, label %if.then1376

if.then1376:                                      ; preds = %land.lhs.true1373
  %add1378 = or disjoint i32 %mul11.6, 15
  %cmp1379 = icmp ult i32 %1, %add1378
  br i1 %cmp1379, label %for.cond1381.preheader, label %if.end1405

for.cond1381.preheader:                           ; preds = %if.then1376
  %220 = lshr i32 %18, 2
  %mul1387 = and i32 %220, 252
  %add1388 = add nuw nsw i32 %mul11.6, %mul1387
  %cmp1391.not = icmp sgt i32 %add1388, %1
  %fneg.2201 = select i1 %cmp1391.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2632 = insertelement <4 x float> poison, float %fneg.2201, i64 0
  %cmp1391.not.1.not = icmp slt i32 %add1388, %1
  %fneg.2201.1 = select i1 %cmp1391.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2725 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2632, float %fneg.2201.1, i64 1
  %add1389.2 = or disjoint i32 %add1388, 2
  %cmp1391.not.2 = icmp sgt i32 %add1389.2, %1
  %fneg.2201.2 = select i1 %cmp1391.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2818 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2725, float %fneg.2201.2, i64 2
  %add1389.3 = or disjoint i32 %add1388, 3
  %cmp1391.not.3 = icmp sgt i32 %add1389.3, %1
  %fneg.2201.3 = select i1 %cmp1391.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2911 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2818, float %fneg.2201.3, i64 3
  br label %if.end1405

if.end1405:                                       ; preds = %if.then1376, %for.cond1381.preheader
  %acc_s.sroa.0.17 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2911, %for.cond1381.preheader ], [ zeroinitializer, %if.then1376 ]
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.17), !call_argsrelate !89
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.8.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %221), !call_argsrelate !89
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.11.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %222), !call_argsrelate !89
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.17.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %223), !call_argsrelate !89
  %acc_s.sroa.0.0.vec.extract2634 = extractelement <4 x float> %224, i64 0
  %mul1440 = fmul contract float %acc_s.sroa.0.0.vec.extract2634, 0x3FB99999A0000000
  %225 = tail call contract noundef float @llvm.minnum.f32(float %mul1440, float 0x4024CB5EC0000000)
  %226 = tail call contract noundef float @llvm.exp.f32(float %225)
  %acc_s.sroa.0.4.vec.extract2727 = extractelement <4 x float> %224, i64 1
  %mul1440.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2727, 0x3FB99999A0000000
  %227 = tail call contract noundef float @llvm.minnum.f32(float %mul1440.1, float 0x4024CB5EC0000000)
  %228 = tail call contract noundef float @llvm.exp.f32(float %227)
  %acc_s.sroa.0.8.vec.extract2820 = extractelement <4 x float> %224, i64 2
  %mul1440.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2820, 0x3FB99999A0000000
  %229 = tail call contract noundef float @llvm.minnum.f32(float %mul1440.2, float 0x4024CB5EC0000000)
  %230 = tail call contract noundef float @llvm.exp.f32(float %229)
  %acc_s.sroa.0.12.vec.extract2913 = extractelement <4 x float> %224, i64 3
  %mul1440.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2913, 0x3FB99999A0000000
  %231 = tail call contract noundef float @llvm.minnum.f32(float %mul1440.3, float 0x4024CB5EC0000000)
  %232 = tail call contract noundef float @llvm.exp.f32(float %231)
  %add1456 = fadd contract float %sum_acc.sroa.0.5, %226
  %add1456.1 = fadd contract float %sum_acc.sroa.20.5, %228
  %add1456.2 = fadd contract float %sum_acc.sroa.38.5, %230
  %add1456.3 = fadd contract float %sum_acc.sroa.56.5, %232
  %233 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %226)
  %234 = insertelement <4 x i16> poison, i16 %233, i64 0
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %228)
  %236 = insertelement <4 x i16> %234, i16 %235, i64 1
  %237 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %230)
  %238 = insertelement <4 x i16> %236, i16 %237, i64 2
  %239 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %232)
  %240 = insertelement <4 x i16> %238, i16 %239, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2547 = bitcast <4 x i16> %240 to <4 x half>
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2547, <4 x float> %acc_o.sroa.0.2)
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2547, <4 x float> %acc_o.sroa.34.2)
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2547, <4 x float> %acc_o.sroa.66.2)
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2547, <4 x float> %acc_o.sroa.98.2)
  br label %if.end1492

if.end1492:                                       ; preds = %if.end1405, %land.lhs.true1373, %if.end1368
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %land.lhs.true1373 ], [ %244, %if.end1405 ], [ %acc_o.sroa.98.2, %if.end1368 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %land.lhs.true1373 ], [ %243, %if.end1405 ], [ %acc_o.sroa.66.2, %if.end1368 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %land.lhs.true1373 ], [ %242, %if.end1405 ], [ %acc_o.sroa.34.2, %if.end1368 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %land.lhs.true1373 ], [ %241, %if.end1405 ], [ %acc_o.sroa.0.2, %if.end1368 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true1373 ], [ %add1456.3, %if.end1405 ], [ %sum_acc.sroa.56.5, %if.end1368 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true1373 ], [ %add1456.2, %if.end1405 ], [ %sum_acc.sroa.38.5, %if.end1368 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true1373 ], [ %add1456.1, %if.end1405 ], [ %sum_acc.sroa.20.5, %if.end1368 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true1373 ], [ %add1456, %if.end1405 ], [ %sum_acc.sroa.0.5, %if.end1368 ]
  %or.cond2383 = icmp ult i32 %mul11.7, 1024
  br i1 %or.cond2383, label %land.lhs.true1497, label %if.end1616

land.lhs.true1497:                                ; preds = %if.end1492
  br i1 %cmp1089.not, label %if.end1616, label %if.then1500

if.then1500:                                      ; preds = %land.lhs.true1497
  %add1502 = or disjoint i32 %mul11.7, 15
  %cmp1503 = icmp slt i32 %1, %add1502
  br i1 %cmp1503, label %for.cond1505.preheader, label %if.end1529

for.cond1505.preheader:                           ; preds = %if.then1500
  %245 = lshr i32 %18, 2
  %mul1511 = and i32 %245, 252
  %add1512 = add nuw nsw i32 %mul11.7, %mul1511
  %cmp1515.not = icmp sgt i32 %add1512, %1
  %fneg.2202 = select i1 %cmp1515.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2642 = insertelement <4 x float> poison, float %fneg.2202, i64 0
  %cmp1515.not.1.not = icmp slt i32 %add1512, %1
  %fneg.2202.1 = select i1 %cmp1515.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2735 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2642, float %fneg.2202.1, i64 1
  %add1513.2 = or disjoint i32 %add1512, 2
  %cmp1515.not.2 = icmp sgt i32 %add1513.2, %1
  %fneg.2202.2 = select i1 %cmp1515.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2828 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2735, float %fneg.2202.2, i64 2
  %add1513.3 = or disjoint i32 %add1512, 3
  %cmp1515.not.3 = icmp sgt i32 %add1513.3, %1
  %fneg.2202.3 = select i1 %cmp1515.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2921 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2828, float %fneg.2202.3, i64 3
  br label %if.end1529

if.end1529:                                       ; preds = %if.then1500, %for.cond1505.preheader
  %acc_s.sroa.0.19 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2921, %for.cond1505.preheader ], [ zeroinitializer, %if.then1500 ]
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.19), !call_argsrelate !89
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.8.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %246), !call_argsrelate !89
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.11.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %247), !call_argsrelate !89
  %249 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.17.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %248), !call_argsrelate !89
  %acc_s.sroa.0.0.vec.extract2644 = extractelement <4 x float> %249, i64 0
  %mul1564 = fmul contract float %acc_s.sroa.0.0.vec.extract2644, 0x3FB99999A0000000
  %250 = tail call contract noundef float @llvm.minnum.f32(float %mul1564, float 0x4024CB5EC0000000)
  %251 = tail call contract noundef float @llvm.exp.f32(float %250)
  %acc_s.sroa.0.4.vec.extract2737 = extractelement <4 x float> %249, i64 1
  %mul1564.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2737, 0x3FB99999A0000000
  %252 = tail call contract noundef float @llvm.minnum.f32(float %mul1564.1, float 0x4024CB5EC0000000)
  %253 = tail call contract noundef float @llvm.exp.f32(float %252)
  %acc_s.sroa.0.8.vec.extract2830 = extractelement <4 x float> %249, i64 2
  %mul1564.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2830, 0x3FB99999A0000000
  %254 = tail call contract noundef float @llvm.minnum.f32(float %mul1564.2, float 0x4024CB5EC0000000)
  %255 = tail call contract noundef float @llvm.exp.f32(float %254)
  %acc_s.sroa.0.12.vec.extract2923 = extractelement <4 x float> %249, i64 3
  %mul1564.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2923, 0x3FB99999A0000000
  %256 = tail call contract noundef float @llvm.minnum.f32(float %mul1564.3, float 0x4024CB5EC0000000)
  %257 = tail call contract noundef float @llvm.exp.f32(float %256)
  %add1580 = fadd contract float %sum_acc.sroa.0.6, %251
  %add1580.1 = fadd contract float %sum_acc.sroa.20.6, %253
  %add1580.2 = fadd contract float %sum_acc.sroa.38.6, %255
  %add1580.3 = fadd contract float %sum_acc.sroa.56.6, %257
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %251)
  %259 = insertelement <4 x i16> poison, i16 %258, i64 0
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %253)
  %261 = insertelement <4 x i16> %259, i16 %260, i64 1
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %255)
  %263 = insertelement <4 x i16> %261, i16 %262, i64 2
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %257)
  %265 = insertelement <4 x i16> %263, i16 %264, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2549 = bitcast <4 x i16> %265 to <4 x half>
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2549, <4 x float> %acc_o_alt.sroa.0.2)
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2549, <4 x float> %acc_o_alt.sroa.18.2)
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2549, <4 x float> %acc_o_alt.sroa.34.2)
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring1.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2549, <4 x float> %acc_o_alt.sroa.50.2)
  br label %if.end1616

if.end1616:                                       ; preds = %if.end1529, %land.lhs.true1497, %if.end1492
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %land.lhs.true1497 ], [ %269, %if.end1529 ], [ %acc_o_alt.sroa.50.2, %if.end1492 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %land.lhs.true1497 ], [ %268, %if.end1529 ], [ %acc_o_alt.sroa.34.2, %if.end1492 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %land.lhs.true1497 ], [ %267, %if.end1529 ], [ %acc_o_alt.sroa.18.2, %if.end1492 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %land.lhs.true1497 ], [ %266, %if.end1529 ], [ %acc_o_alt.sroa.0.2, %if.end1492 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1497 ], [ %add1580.3, %if.end1529 ], [ %sum_acc.sroa.56.6, %if.end1492 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1497 ], [ %add1580.2, %if.end1529 ], [ %sum_acc.sroa.38.6, %if.end1492 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1497 ], [ %add1580.1, %if.end1529 ], [ %sum_acc.sroa.20.6, %if.end1492 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1497 ], [ %add1580, %if.end1529 ], [ %sum_acc.sroa.0.6, %if.end1492 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add1625 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add1625.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add1625.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add1625.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add1625.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add1625.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add1625.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add1625.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add1625.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add1625.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add1625.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add1625.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add1625.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add1625.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add1625.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add1625.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add1639 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1639.1 = fadd contract float %add1639, %sum_acc.sroa.20.7
  %add1639.2 = fadd contract float %add1639.1, %sum_acc.sroa.38.7
  %add1639.3 = fadd contract float %add1639.2, %sum_acc.sroa.56.7
  %270 = bitcast float %add1639.3 to i32
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11
  %xor.i.i = xor i32 %272, 32
  %273 = and i32 %272, -64
  %and.i.i = add nsw i32 %273, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2212 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %272
  %shl.i.i = shl i32 %cond.i.i2212, 2
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %270)
  %275 = bitcast i32 %274 to float
  %add.i = fadd contract float %add1639.3, %275
  %276 = bitcast float %add.i to i32
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11
  %xor.i.i2213 = xor i32 %278, 16
  %279 = and i32 %278, -64
  %and.i.i2214 = add nsw i32 %279, 64
  %cmp.not.i.i2215 = icmp slt i32 %xor.i.i2213, %and.i.i2214
  %cond.i.i2216 = select i1 %cmp.not.i.i2215, i32 %xor.i.i2213, i32 %278
  %shl.i.i2217 = shl i32 %cond.i.i2216, 2
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2217, i32 %276)
  %281 = bitcast i32 %280 to float
  %add.i.i = fadd contract float %add.i, %281
  %cmp1648 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp1648, float %div, float 0.000000e+00
  %mul1661 = fmul contract float %condval_8.0, %add1625
  %mul1661.1 = fmul contract float %condval_8.0, %add1625.1
  %mul1661.2 = fmul contract float %condval_8.0, %add1625.2
  %mul1661.3 = fmul contract float %condval_8.0, %add1625.3
  %mul1661.4 = fmul contract float %condval_8.0, %add1625.4
  %mul1661.5 = fmul contract float %condval_8.0, %add1625.5
  %mul1661.6 = fmul contract float %condval_8.0, %add1625.6
  %mul1661.7 = fmul contract float %condval_8.0, %add1625.7
  %mul1661.8 = fmul contract float %condval_8.0, %add1625.8
  %mul1661.9 = fmul contract float %condval_8.0, %add1625.9
  %mul1661.10 = fmul contract float %condval_8.0, %add1625.10
  %mul1661.11 = fmul contract float %condval_8.0, %add1625.11
  %mul1661.12 = fmul contract float %condval_8.0, %add1625.12
  %mul1661.13 = fmul contract float %condval_8.0, %add1625.13
  %mul1661.14 = fmul contract float %condval_8.0, %add1625.14
  %mul1661.15 = fmul contract float %condval_8.0, %add1625.15
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661)
  %O_reg.sroa.0.0.insert.ext = zext i16 %282 to i64
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %283 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %284 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %286 to i64
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %287 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %288 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %290 to i64
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %291 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %292 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %293 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %294 to i64
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %295 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %296 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1661.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %297 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1703 = lshr i32 %18, 5
  %and1706 = and i32 %18, 7
  %298 = lshr i32 %18, 2
  %mul1712 = and i32 %298, 4
  %xor = xor i32 %shr1703, %and1706
  %mul1707 = shl nuw nsw i32 %xor, 3
  %add1708 = add nuw nsw i32 %mul1707, %mul25
  %add1713 = or disjoint i32 %add1708, %mul1712
  %add.ptr1715 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1713
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1715, align 8
  %add1704.1 = add nuw nsw i32 %shr1703, 2
  %xor.1 = xor i32 %add1704.1, %and1706
  %mul1707.1 = shl nuw nsw i32 %xor.1, 3
  %add1708.1 = add nuw nsw i32 %mul1707.1, %mul25
  %add1713.1 = or disjoint i32 %add1708.1, %mul1712
  %add.ptr1715.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1713.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1715.1, align 8
  %add1704.2 = add nuw nsw i32 %shr1703, 4
  %xor.2 = xor i32 %add1704.2, %and1706
  %mul1707.2 = shl nuw nsw i32 %xor.2, 3
  %add1708.2 = add nuw nsw i32 %mul1707.2, %mul25
  %add1713.2 = or disjoint i32 %add1708.2, %mul1712
  %add.ptr1715.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1713.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1715.2, align 8
  %add1704.3 = add nuw nsw i32 %shr1703, 6
  %xor.3 = xor i32 %add1704.3, %and1706
  %mul1707.3 = shl nuw nsw i32 %xor.3, 3
  %add1708.3 = add nuw nsw i32 %mul1707.3, %mul25
  %add1713.3 = or disjoint i32 %add1708.3, %mul1712
  %add.ptr1715.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1713.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1715.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %299 = shl nuw nsw i32 %18, 3
  %mul1726 = and i32 %299, 8128
  %xor17322194 = and i32 %299, 56
  %call1730.masked = and i32 %18, 1016
  %mul1733 = xor i32 %xor17322194, %call1730.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1726
  %invariant.gep2332 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1733
  %add1743 = add nuw nsw i32 %add23, %299
  %300 = zext nneg i32 %add1743 to i64
  %add.ptr1748 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1748, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2332, i64 16, i1 false), !tbaa.struct !396, !call_argsrelate !397
  %gep2333.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2332, i32 1024
  %301 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300
  %add.ptr1748.1 = getelementptr inbounds i8, ptr addrspace(1) %301, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1748.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2333.1, i64 16, i1 false), !tbaa.struct !396, !call_argsrelate !397
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


