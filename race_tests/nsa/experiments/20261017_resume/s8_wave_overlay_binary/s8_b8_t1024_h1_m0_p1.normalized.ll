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
  %cond.i.i1230 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i1230, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i1230.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i1230.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i1230.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i1230.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i1230.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i1230.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i1230.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i1230.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i1230.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i1230.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i1230.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i1230.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i1230.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i1230.7, 4
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
  %mul128 = shl nsw i32 %0, 16
  %mul135 = shl nuw nsw i32 %18, 3
  %add131 = or disjoint i32 %mul135, %mul128
  %invariant.op = add nsw i32 %1, -15
  %22 = lshr i32 %18, 2
  %mul279 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp122.not = icmp sgt i32 %mul11, %1
  %or.cond1308 = or i1 %or.cond, %cmp122.not
  br i1 %or.cond1308, label %if.end, label %for.cond123.preheader

for.cond123.preheader:                            ; preds = %entry
  %23 = shl nsw i32 %cond.i.i1230, 10
  %mul130 = and i32 %23, 64512
  %add133 = add nuw nsw i32 %add131, %mul130
  %24 = zext nneg i32 %add133 to i64
  %add.ptr138 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %24
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr138, align 16
  %K_reg.sroa.6.0.add.ptr138.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr138, i64 8
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr138.sroa_idx, align 8
  %25 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %24
  %add.ptr138.1 = getelementptr inbounds i8, ptr addrspace(4) %25, i64 1024
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr138.1, align 16
  %K_reg.sroa.12.16.add.ptr138.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %25, i64 1032
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr138.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %for.cond123.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond123.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond123.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond123.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond123.preheader ]
  %or.cond1309 = icmp ugt i32 %mul11.1, 1023
  %cmp151.not = icmp sgt i32 %mul11.1, %1
  %or.cond1310 = or i1 %or.cond1309, %cmp151.not
  br i1 %or.cond1310, label %if.end176, label %for.cond153.preheader

for.cond153.preheader:                            ; preds = %if.end
  %26 = shl nsw i32 %cond.i.i1230.1, 10
  %mul160 = and i32 %26, 64512
  %add163 = add nuw nsw i32 %add131, %mul160
  %27 = zext nneg i32 %add163 to i64
  %add.ptr168 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr168, align 16
  %K_reg1.sroa.6.0.add.ptr168.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr168, i64 8
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr168.sroa_idx, align 8
  %28 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27
  %add.ptr168.1 = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1024
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr168.1, align 16
  %K_reg1.sroa.12.16.add.ptr168.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1032
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr168.1.sroa_idx, align 8
  br label %if.end176

if.end176:                                        ; preds = %for.cond153.preheader, %if.end
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.12.16.copyload, %for.cond153.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.8.16.copyload, %for.cond153.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.6.0.copyload, %for.cond153.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond153.preheader ]
  %or.cond1311 = icmp ugt i32 %mul11.2, 1023
  %cmp182.not = icmp sgt i32 %mul11.2, %1
  %or.cond1312 = or i1 %or.cond1311, %cmp182.not
  br i1 %or.cond1312, label %if.end207, label %for.cond184.preheader

for.cond184.preheader:                            ; preds = %if.end176
  %29 = shl nsw i32 %cond.i.i1230.2, 10
  %mul191 = and i32 %29, 64512
  %add194 = add nuw nsw i32 %add131, %mul191
  %30 = zext nneg i32 %add194 to i64
  %add.ptr199 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr199, align 16
  %K_reg2.sroa.6.0.add.ptr199.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr199, i64 8
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr199.sroa_idx, align 8
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30
  %add.ptr199.1 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1024
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr199.1, align 16
  %K_reg2.sroa.12.16.add.ptr199.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1032
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr199.1.sroa_idx, align 8
  br label %if.end207

if.end207:                                        ; preds = %for.cond184.preheader, %if.end176
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.12.16.copyload, %for.cond184.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.8.16.copyload, %for.cond184.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.6.0.copyload, %for.cond184.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.0.0.copyload, %for.cond184.preheader ]
  %or.cond1313 = icmp ugt i32 %mul11.3, 1023
  %cmp213.not = icmp sgt i32 %mul11.3, %1
  %or.cond1314 = or i1 %or.cond1313, %cmp213.not
  br i1 %or.cond1314, label %if.end238, label %for.cond215.preheader

for.cond215.preheader:                            ; preds = %if.end207
  %32 = shl nsw i32 %cond.i.i1230.3, 10
  %mul222 = and i32 %32, 64512
  %add225 = add nuw nsw i32 %add131, %mul222
  %33 = zext nneg i32 %add225 to i64
  %add.ptr230 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %33
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr230, align 16
  %K_reg3.sroa.6.0.add.ptr230.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr230, i64 8
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr230.sroa_idx, align 8
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %33
  %add.ptr230.1 = getelementptr inbounds i8, ptr addrspace(4) %34, i64 1024
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr230.1, align 16
  %K_reg3.sroa.12.16.add.ptr230.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %34, i64 1032
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr230.1.sroa_idx, align 8
  br label %if.end238

if.end238:                                        ; preds = %for.cond215.preheader, %if.end207
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.12.16.copyload, %for.cond215.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.8.16.copyload, %for.cond215.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.6.0.copyload, %for.cond215.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.0.0.copyload, %for.cond215.preheader ]
  br i1 %or.cond1308, label %if.end383, label %for.cond246.preheader

for.cond246.preheader:                            ; preds = %if.end238
  %35 = shl nsw i32 %cond.i.i1230, 10
  %mul253 = and i32 %35, 64512
  %add256 = add nuw nsw i32 %add131, %mul253
  %36 = zext nneg i32 %add256 to i64
  %add.ptr261 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %36
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr261, align 16
  %V_reg.sroa.18.0.add.ptr261.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr261, i64 8
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr261.sroa_idx, align 8
  %37 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %36
  %add.ptr261.1 = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1024
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr261.1, align 16
  %V_reg.sroa.42.16.add.ptr261.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1032
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr261.1.sroa_idx, align 8
  %cmp271 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp271, label %for.cond273.preheader, label %if.end296

for.cond273.preheader:                            ; preds = %for.cond246.preheader
  %add280 = add nuw nsw i32 %mul11, %mul279
  %cmp283.not = icmp sgt i32 %add280, %1
  %fneg. = select i1 %cmp283.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1496 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp283.not.1.not = icmp slt i32 %add280, %1
  %fneg..1 = select i1 %cmp283.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1597 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1496, float %fneg..1, i64 1
  %add281.2 = or disjoint i32 %add280, 2
  %cmp283.not.2 = icmp sgt i32 %add281.2, %1
  %fneg..2 = select i1 %cmp283.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1690 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1597, float %fneg..2, i64 2
  %add281.3 = or disjoint i32 %add280, 3
  %cmp283.not.3 = icmp sgt i32 %add281.3, %1
  %fneg..3 = select i1 %cmp283.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1783 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1690, float %fneg..3, i64 3
  br label %if.end296

if.end296:                                        ; preds = %for.cond246.preheader, %for.cond273.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1783, %for.cond273.preheader ], [ zeroinitializer, %for.cond246.preheader ]
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !86
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %38), !call_argsrelate !86
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %39), !call_argsrelate !86
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %40), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %41, i64 0
  %mul331 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul331, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %41, i64 1
  %mul331.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul331.1, float 0x4024CB5EC0000000)
  %45 = tail call contract noundef float @llvm.exp.f32(float %44)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %41, i64 2
  %mul331.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul331.2, float 0x4024CB5EC0000000)
  %47 = tail call contract noundef float @llvm.exp.f32(float %46)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %41, i64 3
  %mul331.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul331.3, float 0x4024CB5EC0000000)
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
  br label %if.end383

if.end383:                                        ; preds = %if.end296, %if.end238
  %acc_o.sroa.110.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %61, %if.end296 ]
  %acc_o.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %60, %if.end296 ]
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %59, %if.end296 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %58, %if.end296 ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end238 ], [ %49, %if.end296 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end238 ], [ %47, %if.end296 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end238 ], [ %45, %if.end296 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end238 ], [ %43, %if.end296 ]
  br i1 %or.cond1310, label %if.end529, label %for.cond391.preheader

for.cond391.preheader:                            ; preds = %if.end383
  %62 = shl nsw i32 %cond.i.i1230.1, 10
  %mul398 = and i32 %62, 64512
  %add401 = add nuw nsw i32 %add131, %mul398
  %63 = zext nneg i32 %add401 to i64
  %add.ptr406 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63
  %V_reg.sroa.0.0.copyload1868 = load <4 x half>, ptr addrspace(4) %add.ptr406, align 16
  %V_reg.sroa.18.0.add.ptr406.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr406, i64 8
  %V_reg.sroa.18.0.copyload1875 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr406.sroa_idx, align 8
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63
  %add.ptr406.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024
  %V_reg.sroa.26.16.copyload1896 = load <4 x half>, ptr addrspace(4) %add.ptr406.1, align 16
  %V_reg.sroa.42.16.add.ptr406.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032
  %V_reg.sroa.42.16.copyload1903 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr406.1.sroa_idx, align 8
  %cmp416 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp416, label %for.cond418.preheader, label %if.end442

for.cond418.preheader:                            ; preds = %for.cond391.preheader
  %add425 = add nuw nsw i32 %mul11.1, %mul279
  %cmp428.not = icmp sgt i32 %add425, %1
  %fneg.1219 = select i1 %cmp428.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1505 = insertelement <4 x float> poison, float %fneg.1219, i64 0
  %cmp428.not.1.not = icmp slt i32 %add425, %1
  %fneg.1219.1 = select i1 %cmp428.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1606 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1505, float %fneg.1219.1, i64 1
  %add426.2 = or disjoint i32 %add425, 2
  %cmp428.not.2 = icmp sgt i32 %add426.2, %1
  %fneg.1219.2 = select i1 %cmp428.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1699 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1606, float %fneg.1219.2, i64 2
  %add426.3 = or disjoint i32 %add425, 3
  %cmp428.not.3 = icmp sgt i32 %add426.3, %1
  %fneg.1219.3 = select i1 %cmp428.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1792 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1699, float %fneg.1219.3, i64 3
  br label %if.end442

if.end442:                                        ; preds = %for.cond391.preheader, %for.cond418.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1792, %for.cond418.preheader ], [ zeroinitializer, %for.cond391.preheader ]
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !86
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %65), !call_argsrelate !86
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %66), !call_argsrelate !86
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %67), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1507 = extractelement <4 x float> %68, i64 0
  %mul477 = fmul contract float %acc_s.sroa.0.0.vec.extract1507, 0x3FB99999A0000000
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul477, float 0x4024CB5EC0000000)
  %70 = tail call contract noundef float @llvm.exp.f32(float %69)
  %acc_s.sroa.0.4.vec.extract1608 = extractelement <4 x float> %68, i64 1
  %mul477.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1608, 0x3FB99999A0000000
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul477.1, float 0x4024CB5EC0000000)
  %72 = tail call contract noundef float @llvm.exp.f32(float %71)
  %acc_s.sroa.0.8.vec.extract1701 = extractelement <4 x float> %68, i64 2
  %mul477.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1701, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul477.2, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %acc_s.sroa.0.12.vec.extract1794 = extractelement <4 x float> %68, i64 3
  %mul477.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1794, 0x3FB99999A0000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul477.3, float 0x4024CB5EC0000000)
  %76 = tail call contract noundef float @llvm.exp.f32(float %75)
  %add493 = fadd contract float %sum_acc.sroa.0.0, %70
  %add493.1 = fadd contract float %sum_acc.sroa.20.0, %72
  %add493.2 = fadd contract float %sum_acc.sroa.38.0, %74
  %add493.3 = fadd contract float %sum_acc.sroa.56.0, %76
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %70)
  %78 = insertelement <4 x i16> poison, i16 %77, i64 0
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %72)
  %80 = insertelement <4 x i16> %78, i16 %79, i64 1
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %82 = insertelement <4 x i16> %80, i16 %81, i64 2
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76)
  %84 = insertelement <4 x i16> %82, i16 %83, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1468 = bitcast <4 x i16> %84 to <4 x half>
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1868, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !call_argsrelate !106
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1875, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !call_argsrelate !106
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1896, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !call_argsrelate !106
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1903, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !call_argsrelate !106
  br label %if.end529

if.end529:                                        ; preds = %if.end442, %if.end383
  %acc_o_1.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %88, %if.end442 ]
  %acc_o_1.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %87, %if.end442 ]
  %acc_o_1.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %86, %if.end442 ]
  %acc_o_1.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %85, %if.end442 ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end383 ], [ %add493.3, %if.end442 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end383 ], [ %add493.2, %if.end442 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end383 ], [ %add493.1, %if.end442 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end383 ], [ %add493, %if.end442 ]
  br i1 %or.cond1312, label %if.end675, label %for.cond537.preheader

for.cond537.preheader:                            ; preds = %if.end529
  %89 = shl nsw i32 %cond.i.i1230.2, 10
  %mul544 = and i32 %89, 64512
  %add547 = add nuw nsw i32 %add131, %mul544
  %90 = zext nneg i32 %add547 to i64
  %add.ptr552 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90
  %V_reg.sroa.0.0.copyload1869 = load <4 x half>, ptr addrspace(4) %add.ptr552, align 16
  %V_reg.sroa.18.0.add.ptr552.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr552, i64 8
  %V_reg.sroa.18.0.copyload1876 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr552.sroa_idx, align 8
  %91 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90
  %add.ptr552.1 = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1024
  %V_reg.sroa.26.16.copyload1897 = load <4 x half>, ptr addrspace(4) %add.ptr552.1, align 16
  %V_reg.sroa.42.16.add.ptr552.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1032
  %V_reg.sroa.42.16.copyload1904 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr552.1.sroa_idx, align 8
  %cmp562 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp562, label %for.cond564.preheader, label %if.end588

for.cond564.preheader:                            ; preds = %for.cond537.preheader
  %add571 = add nuw nsw i32 %mul11.2, %mul279
  %cmp574.not = icmp sgt i32 %add571, %1
  %fneg.1220 = select i1 %cmp574.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1515 = insertelement <4 x float> poison, float %fneg.1220, i64 0
  %cmp574.not.1.not = icmp slt i32 %add571, %1
  %fneg.1220.1 = select i1 %cmp574.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1616 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1515, float %fneg.1220.1, i64 1
  %add572.2 = or disjoint i32 %add571, 2
  %cmp574.not.2 = icmp sgt i32 %add572.2, %1
  %fneg.1220.2 = select i1 %cmp574.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1709 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1616, float %fneg.1220.2, i64 2
  %add572.3 = or disjoint i32 %add571, 3
  %cmp574.not.3 = icmp sgt i32 %add572.3, %1
  %fneg.1220.3 = select i1 %cmp574.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1802 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1709, float %fneg.1220.3, i64 3
  br label %if.end588

if.end588:                                        ; preds = %for.cond537.preheader, %for.cond564.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1802, %for.cond564.preheader ], [ zeroinitializer, %for.cond537.preheader ]
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !86
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %92), !call_argsrelate !86
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %93), !call_argsrelate !86
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %94), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1517 = extractelement <4 x float> %95, i64 0
  %mul623 = fmul contract float %acc_s.sroa.0.0.vec.extract1517, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul623, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %acc_s.sroa.0.4.vec.extract1618 = extractelement <4 x float> %95, i64 1
  %mul623.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1618, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %acc_s.sroa.0.8.vec.extract1711 = extractelement <4 x float> %95, i64 2
  %mul623.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1711, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %acc_s.sroa.0.12.vec.extract1804 = extractelement <4 x float> %95, i64 3
  %mul623.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1804, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %add639 = fadd contract float %sum_acc.sroa.0.1, %97
  %add639.1 = fadd contract float %sum_acc.sroa.20.1, %99
  %add639.2 = fadd contract float %sum_acc.sroa.38.1, %101
  %add639.3 = fadd contract float %sum_acc.sroa.56.1, %103
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %105 = insertelement <4 x i16> poison, i16 %104, i64 0
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %107 = insertelement <4 x i16> %105, i16 %106, i64 1
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %109 = insertelement <4 x i16> %107, i16 %108, i64 2
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %111 = insertelement <4 x i16> %109, i16 %110, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1470 = bitcast <4 x i16> %111 to <4 x half>
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1869, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !call_argsrelate !106
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1876, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !call_argsrelate !106
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1897, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !call_argsrelate !106
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1904, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !call_argsrelate !106
  br label %if.end675

if.end675:                                        ; preds = %if.end588, %if.end529
  %acc_o_2.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %115, %if.end588 ]
  %acc_o_2.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %114, %if.end588 ]
  %acc_o_2.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %113, %if.end588 ]
  %acc_o_2.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %112, %if.end588 ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end529 ], [ %add639.3, %if.end588 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end529 ], [ %add639.2, %if.end588 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end529 ], [ %add639.1, %if.end588 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end529 ], [ %add639, %if.end588 ]
  br i1 %or.cond1314, label %if.end821, label %for.cond683.preheader

for.cond683.preheader:                            ; preds = %if.end675
  %116 = shl nsw i32 %cond.i.i1230.3, 10
  %mul690 = and i32 %116, 64512
  %add693 = add nuw nsw i32 %add131, %mul690
  %117 = zext nneg i32 %add693 to i64
  %add.ptr698 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117
  %V_reg.sroa.0.0.copyload1870 = load <4 x half>, ptr addrspace(4) %add.ptr698, align 16
  %V_reg.sroa.18.0.add.ptr698.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr698, i64 8
  %V_reg.sroa.18.0.copyload1877 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr698.sroa_idx, align 8
  %118 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117
  %add.ptr698.1 = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1024
  %V_reg.sroa.26.16.copyload1898 = load <4 x half>, ptr addrspace(4) %add.ptr698.1, align 16
  %V_reg.sroa.42.16.add.ptr698.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1032
  %V_reg.sroa.42.16.copyload1905 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr698.1.sroa_idx, align 8
  %cmp708 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp708, label %for.cond710.preheader, label %if.end734

for.cond710.preheader:                            ; preds = %for.cond683.preheader
  %add717 = add nuw nsw i32 %mul11.3, %mul279
  %cmp720.not = icmp sgt i32 %add717, %1
  %fneg.1221 = select i1 %cmp720.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1525 = insertelement <4 x float> poison, float %fneg.1221, i64 0
  %cmp720.not.1.not = icmp slt i32 %add717, %1
  %fneg.1221.1 = select i1 %cmp720.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1626 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1525, float %fneg.1221.1, i64 1
  %add718.2 = or disjoint i32 %add717, 2
  %cmp720.not.2 = icmp sgt i32 %add718.2, %1
  %fneg.1221.2 = select i1 %cmp720.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1719 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1626, float %fneg.1221.2, i64 2
  %add718.3 = or disjoint i32 %add717, 3
  %cmp720.not.3 = icmp sgt i32 %add718.3, %1
  %fneg.1221.3 = select i1 %cmp720.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1812 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1719, float %fneg.1221.3, i64 3
  br label %if.end734

if.end734:                                        ; preds = %for.cond683.preheader, %for.cond710.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1812, %for.cond710.preheader ], [ zeroinitializer, %for.cond683.preheader ]
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !86
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %119), !call_argsrelate !86
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %120), !call_argsrelate !86
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %121), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1527 = extractelement <4 x float> %122, i64 0
  %mul769 = fmul contract float %acc_s.sroa.0.0.vec.extract1527, 0x3FB99999A0000000
  %123 = tail call contract noundef float @llvm.minnum.f32(float %mul769, float 0x4024CB5EC0000000)
  %124 = tail call contract noundef float @llvm.exp.f32(float %123)
  %acc_s.sroa.0.4.vec.extract1628 = extractelement <4 x float> %122, i64 1
  %mul769.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1628, 0x3FB99999A0000000
  %125 = tail call contract noundef float @llvm.minnum.f32(float %mul769.1, float 0x4024CB5EC0000000)
  %126 = tail call contract noundef float @llvm.exp.f32(float %125)
  %acc_s.sroa.0.8.vec.extract1721 = extractelement <4 x float> %122, i64 2
  %mul769.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1721, 0x3FB99999A0000000
  %127 = tail call contract noundef float @llvm.minnum.f32(float %mul769.2, float 0x4024CB5EC0000000)
  %128 = tail call contract noundef float @llvm.exp.f32(float %127)
  %acc_s.sroa.0.12.vec.extract1814 = extractelement <4 x float> %122, i64 3
  %mul769.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1814, 0x3FB99999A0000000
  %129 = tail call contract noundef float @llvm.minnum.f32(float %mul769.3, float 0x4024CB5EC0000000)
  %130 = tail call contract noundef float @llvm.exp.f32(float %129)
  %add785 = fadd contract float %sum_acc.sroa.0.2, %124
  %add785.1 = fadd contract float %sum_acc.sroa.20.2, %126
  %add785.2 = fadd contract float %sum_acc.sroa.38.2, %128
  %add785.3 = fadd contract float %sum_acc.sroa.56.2, %130
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %124)
  %132 = insertelement <4 x i16> poison, i16 %131, i64 0
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %126)
  %134 = insertelement <4 x i16> %132, i16 %133, i64 1
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %128)
  %136 = insertelement <4 x i16> %134, i16 %135, i64 2
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %130)
  %138 = insertelement <4 x i16> %136, i16 %137, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1472 = bitcast <4 x i16> %138 to <4 x half>
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1870, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !call_argsrelate !106
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1877, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !call_argsrelate !106
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1898, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !call_argsrelate !106
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1905, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !call_argsrelate !106
  br label %if.end821

if.end821:                                        ; preds = %if.end734, %if.end675
  %acc_o_3.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %142, %if.end734 ]
  %acc_o_3.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %141, %if.end734 ]
  %acc_o_3.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %140, %if.end734 ]
  %acc_o_3.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %139, %if.end734 ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end675 ], [ %add785.3, %if.end734 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end675 ], [ %add785.2, %if.end734 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end675 ], [ %add785.1, %if.end734 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end675 ], [ %add785, %if.end734 ]
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023
  %cmp122.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond1308.1 = or i1 %or.cond.1, %cmp122.not.1
  br i1 %or.cond1308.1, label %if.end.1, label %for.cond123.preheader.1

for.cond123.preheader.1:                          ; preds = %if.end821
  %143 = shl nsw i32 %cond.i.i1230.4, 10
  %mul130.1 = and i32 %143, 64512
  %add133.1 = add nuw nsw i32 %add131, %mul130.1
  %144 = zext nneg i32 %add133.1 to i64
  %add.ptr138.11372 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %144
  %K_reg.sroa.0.0.copyload1942 = load <4 x half>, ptr addrspace(4) %add.ptr138.11372, align 16
  %K_reg.sroa.6.0.add.ptr138.11372.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr138.11372, i64 8
  %K_reg.sroa.6.0.copyload1943 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr138.11372.sroa_idx, align 8
  %145 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %144
  %add.ptr138.1.1 = getelementptr inbounds i8, ptr addrspace(4) %145, i64 1024
  %K_reg.sroa.8.16.copyload1946 = load <4 x half>, ptr addrspace(4) %add.ptr138.1.1, align 16
  %K_reg.sroa.12.16.add.ptr138.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %145, i64 1032
  %K_reg.sroa.12.16.copyload1947 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr138.1.1.sroa_idx, align 8
  br label %if.end.1

if.end.1:                                         ; preds = %for.cond123.preheader.1, %if.end821
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end821 ], [ %K_reg.sroa.12.16.copyload1947, %for.cond123.preheader.1 ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end821 ], [ %K_reg.sroa.8.16.copyload1946, %for.cond123.preheader.1 ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end821 ], [ %K_reg.sroa.6.0.copyload1943, %for.cond123.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end821 ], [ %K_reg.sroa.0.0.copyload1942, %for.cond123.preheader.1 ]
  %or.cond1309.1 = icmp ugt i32 %mul11.5, 1023
  %cmp151.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond1310.1 = or i1 %or.cond1309.1, %cmp151.not.1
  br i1 %or.cond1310.1, label %if.end176.1, label %for.cond153.preheader.1

for.cond153.preheader.1:                          ; preds = %if.end.1
  %146 = shl nsw i32 %cond.i.i1230.5, 10
  %mul160.1 = and i32 %146, 64512
  %add163.1 = add nuw nsw i32 %add131, %mul160.1
  %147 = zext nneg i32 %add163.1 to i64
  %add.ptr168.11373 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %147
  %K_reg1.sroa.0.0.copyload1934 = load <4 x half>, ptr addrspace(4) %add.ptr168.11373, align 16
  %K_reg1.sroa.6.0.add.ptr168.11373.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr168.11373, i64 8
  %K_reg1.sroa.6.0.copyload1935 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr168.11373.sroa_idx, align 8
  %148 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %147
  %add.ptr168.1.1 = getelementptr inbounds i8, ptr addrspace(4) %148, i64 1024
  %K_reg1.sroa.8.16.copyload1938 = load <4 x half>, ptr addrspace(4) %add.ptr168.1.1, align 16
  %K_reg1.sroa.12.16.add.ptr168.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %148, i64 1032
  %K_reg1.sroa.12.16.copyload1939 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr168.1.1.sroa_idx, align 8
  br label %if.end176.1

if.end176.1:                                      ; preds = %for.cond153.preheader.1, %if.end.1
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %K_reg1.sroa.12.16.copyload1939, %for.cond153.preheader.1 ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end.1 ], [ %K_reg1.sroa.8.16.copyload1938, %for.cond153.preheader.1 ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end.1 ], [ %K_reg1.sroa.6.0.copyload1935, %for.cond153.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %K_reg1.sroa.0.0.copyload1934, %for.cond153.preheader.1 ]
  %or.cond1311.1 = icmp ugt i32 %mul11.6, 1023
  %cmp182.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond1312.1 = or i1 %or.cond1311.1, %cmp182.not.1
  br i1 %or.cond1312.1, label %if.end207.1, label %for.cond184.preheader.1

for.cond184.preheader.1:                          ; preds = %if.end176.1
  %149 = shl nsw i32 %cond.i.i1230.6, 10
  %mul191.1 = and i32 %149, 64512
  %add194.1 = add nuw nsw i32 %add131, %mul191.1
  %150 = zext nneg i32 %add194.1 to i64
  %add.ptr199.11374 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150
  %K_reg2.sroa.0.0.copyload1926 = load <4 x half>, ptr addrspace(4) %add.ptr199.11374, align 16
  %K_reg2.sroa.6.0.add.ptr199.11374.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr199.11374, i64 8
  %K_reg2.sroa.6.0.copyload1927 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr199.11374.sroa_idx, align 8
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150
  %add.ptr199.1.1 = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1024
  %K_reg2.sroa.8.16.copyload1930 = load <4 x half>, ptr addrspace(4) %add.ptr199.1.1, align 16
  %K_reg2.sroa.12.16.add.ptr199.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1032
  %K_reg2.sroa.12.16.copyload1931 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr199.1.1.sroa_idx, align 8
  br label %if.end207.1

if.end207.1:                                      ; preds = %for.cond184.preheader.1, %if.end176.1
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end176.1 ], [ %K_reg2.sroa.12.16.copyload1931, %for.cond184.preheader.1 ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end176.1 ], [ %K_reg2.sroa.8.16.copyload1930, %for.cond184.preheader.1 ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end176.1 ], [ %K_reg2.sroa.6.0.copyload1927, %for.cond184.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end176.1 ], [ %K_reg2.sroa.0.0.copyload1926, %for.cond184.preheader.1 ]
  %or.cond1313.1 = icmp ugt i32 %mul11.7, 1023
  %cmp213.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond1314.1 = or i1 %or.cond1313.1, %cmp213.not.1
  br i1 %or.cond1314.1, label %if.end238.1, label %for.cond215.preheader.1

for.cond215.preheader.1:                          ; preds = %if.end207.1
  %152 = shl nsw i32 %cond.i.i1230.7, 10
  %mul222.1 = and i32 %152, 64512
  %add225.1 = add nuw nsw i32 %add131, %mul222.1
  %153 = zext nneg i32 %add225.1 to i64
  %add.ptr230.11375 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153
  %K_reg3.sroa.0.0.copyload1918 = load <4 x half>, ptr addrspace(4) %add.ptr230.11375, align 16
  %K_reg3.sroa.6.0.add.ptr230.11375.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr230.11375, i64 8
  %K_reg3.sroa.6.0.copyload1919 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr230.11375.sroa_idx, align 8
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153
  %add.ptr230.1.1 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024
  %K_reg3.sroa.8.16.copyload1922 = load <4 x half>, ptr addrspace(4) %add.ptr230.1.1, align 16
  %K_reg3.sroa.12.16.add.ptr230.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1032
  %K_reg3.sroa.12.16.copyload1923 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr230.1.1.sroa_idx, align 8
  br label %if.end238.1

if.end238.1:                                      ; preds = %for.cond215.preheader.1, %if.end207.1
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end207.1 ], [ %K_reg3.sroa.12.16.copyload1923, %for.cond215.preheader.1 ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end207.1 ], [ %K_reg3.sroa.8.16.copyload1922, %for.cond215.preheader.1 ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end207.1 ], [ %K_reg3.sroa.6.0.copyload1919, %for.cond215.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end207.1 ], [ %K_reg3.sroa.0.0.copyload1918, %for.cond215.preheader.1 ]
  br i1 %or.cond1308.1, label %if.end383.1, label %for.cond246.preheader.1

for.cond246.preheader.1:                          ; preds = %if.end238.1
  %155 = shl nsw i32 %cond.i.i1230.4, 10
  %mul253.1 = and i32 %155, 64512
  %add256.1 = add nuw nsw i32 %add131, %mul253.1
  %156 = zext nneg i32 %add256.1 to i64
  %add.ptr261.11376 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156
  %V_reg.sroa.0.0.copyload1871 = load <4 x half>, ptr addrspace(4) %add.ptr261.11376, align 16
  %V_reg.sroa.18.0.add.ptr261.11376.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr261.11376, i64 8
  %V_reg.sroa.18.0.copyload1878 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr261.11376.sroa_idx, align 8
  %157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156
  %add.ptr261.1.1 = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1024
  %V_reg.sroa.26.16.copyload1899 = load <4 x half>, ptr addrspace(4) %add.ptr261.1.1, align 16
  %V_reg.sroa.42.16.add.ptr261.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1032
  %V_reg.sroa.42.16.copyload1906 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr261.1.1.sroa_idx, align 8
  %cmp271.1 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp271.1, label %for.cond273.preheader.1, label %if.end296.1

for.cond273.preheader.1:                          ; preds = %for.cond246.preheader.1
  %add280.1 = add nuw nsw i32 %mul11.4, %mul279
  %cmp283.not.11377 = icmp sgt i32 %add280.1, %1
  %fneg..11378 = select i1 %cmp283.not.11377, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1537 = insertelement <4 x float> poison, float %fneg..11378, i64 0
  %cmp283.not.1.1.not = icmp slt i32 %add280.1, %1
  %fneg..1.1 = select i1 %cmp283.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1636 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1537, float %fneg..1.1, i64 1
  %add281.2.1 = or disjoint i32 %add280.1, 2
  %cmp283.not.2.1 = icmp sgt i32 %add281.2.1, %1
  %fneg..2.1 = select i1 %cmp283.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1729 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1636, float %fneg..2.1, i64 2
  %add281.3.1 = or disjoint i32 %add280.1, 3
  %cmp283.not.3.1 = icmp sgt i32 %add281.3.1, %1
  %fneg..3.1 = select i1 %cmp283.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1822 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1729, float %fneg..3.1, i64 3
  br label %if.end296.1

if.end296.1:                                      ; preds = %for.cond246.preheader.1, %for.cond273.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1822, %for.cond273.preheader.1 ], [ zeroinitializer, %for.cond246.preheader.1 ]
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !86
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %158), !call_argsrelate !86
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %159), !call_argsrelate !86
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %160), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1539 = extractelement <4 x float> %161, i64 0
  %mul331.11382 = fmul contract float %acc_s.sroa.0.0.vec.extract1539, 0x3FB99999A0000000
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul331.11382, float 0x4024CB5EC0000000)
  %163 = tail call contract noundef float @llvm.exp.f32(float %162)
  %acc_s.sroa.0.4.vec.extract1638 = extractelement <4 x float> %161, i64 1
  %mul331.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1638, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul331.1.1, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %acc_s.sroa.0.8.vec.extract1731 = extractelement <4 x float> %161, i64 2
  %mul331.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1731, 0x3FB99999A0000000
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul331.2.1, float 0x4024CB5EC0000000)
  %167 = tail call contract noundef float @llvm.exp.f32(float %166)
  %acc_s.sroa.0.12.vec.extract1824 = extractelement <4 x float> %161, i64 3
  %mul331.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1824, 0x3FB99999A0000000
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul331.3.1, float 0x4024CB5EC0000000)
  %169 = tail call contract noundef float @llvm.exp.f32(float %168)
  %add347.11383 = fadd contract float %sum_acc.sroa.0.3, %163
  %add347.1.1 = fadd contract float %sum_acc.sroa.20.3, %165
  %add347.2.1 = fadd contract float %sum_acc.sroa.38.3, %167
  %add347.3.1 = fadd contract float %sum_acc.sroa.56.3, %169
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163)
  %171 = insertelement <4 x i16> poison, i16 %170, i64 0
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %173 = insertelement <4 x i16> %171, i16 %172, i64 1
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167)
  %175 = insertelement <4 x i16> %173, i16 %174, i64 2
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169)
  %177 = insertelement <4 x i16> %175, i16 %176, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1474 = bitcast <4 x i16> %177 to <4 x half>
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1871, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !106
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1878, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.38.0), !call_argsrelate !106
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1899, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.74.0), !call_argsrelate !106
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1906, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.110.0), !call_argsrelate !106
  br label %if.end383.1

if.end383.1:                                      ; preds = %if.end296.1, %if.end238.1
  %acc_o.sroa.110.1 = phi <4 x float> [ %acc_o.sroa.110.0, %if.end238.1 ], [ %181, %if.end296.1 ]
  %acc_o.sroa.74.1 = phi <4 x float> [ %acc_o.sroa.74.0, %if.end238.1 ], [ %180, %if.end296.1 ]
  %acc_o.sroa.38.1 = phi <4 x float> [ %acc_o.sroa.38.0, %if.end238.1 ], [ %179, %if.end296.1 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end238.1 ], [ %178, %if.end296.1 ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end238.1 ], [ %add347.3.1, %if.end296.1 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end238.1 ], [ %add347.2.1, %if.end296.1 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end238.1 ], [ %add347.1.1, %if.end296.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end238.1 ], [ %add347.11383, %if.end296.1 ]
  br i1 %or.cond1310.1, label %if.end529.1, label %for.cond391.preheader.1

for.cond391.preheader.1:                          ; preds = %if.end383.1
  %182 = shl nsw i32 %cond.i.i1230.5, 10
  %mul398.1 = and i32 %182, 64512
  %add401.1 = add nuw nsw i32 %add131, %mul398.1
  %183 = zext nneg i32 %add401.1 to i64
  %add.ptr406.11384 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %V_reg.sroa.0.0.copyload1872 = load <4 x half>, ptr addrspace(4) %add.ptr406.11384, align 16
  %V_reg.sroa.18.0.add.ptr406.11384.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr406.11384, i64 8
  %V_reg.sroa.18.0.copyload1879 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr406.11384.sroa_idx, align 8
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183
  %add.ptr406.1.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024
  %V_reg.sroa.26.16.copyload1900 = load <4 x half>, ptr addrspace(4) %add.ptr406.1.1, align 16
  %V_reg.sroa.42.16.add.ptr406.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032
  %V_reg.sroa.42.16.copyload1907 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr406.1.1.sroa_idx, align 8
  %cmp416.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp416.1, label %for.cond418.preheader.1, label %if.end442.1

for.cond418.preheader.1:                          ; preds = %for.cond391.preheader.1
  %add425.1 = add nuw nsw i32 %mul11.5, %mul279
  %cmp428.not.11385 = icmp sgt i32 %add425.1, %1
  %fneg.1219.11386 = select i1 %cmp428.not.11385, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1549 = insertelement <4 x float> poison, float %fneg.1219.11386, i64 0
  %cmp428.not.1.1.not = icmp slt i32 %add425.1, %1
  %fneg.1219.1.1 = select i1 %cmp428.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1646 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1549, float %fneg.1219.1.1, i64 1
  %add426.2.1 = or disjoint i32 %add425.1, 2
  %cmp428.not.2.1 = icmp sgt i32 %add426.2.1, %1
  %fneg.1219.2.1 = select i1 %cmp428.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1739 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1646, float %fneg.1219.2.1, i64 2
  %add426.3.1 = or disjoint i32 %add425.1, 3
  %cmp428.not.3.1 = icmp sgt i32 %add426.3.1, %1
  %fneg.1219.3.1 = select i1 %cmp428.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1832 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1739, float %fneg.1219.3.1, i64 3
  br label %if.end442.1

if.end442.1:                                      ; preds = %for.cond391.preheader.1, %for.cond418.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1832, %for.cond418.preheader.1 ], [ zeroinitializer, %for.cond391.preheader.1 ]
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !86
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %185), !call_argsrelate !86
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %186), !call_argsrelate !86
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %187), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1551 = extractelement <4 x float> %188, i64 0
  %mul477.11390 = fmul contract float %acc_s.sroa.0.0.vec.extract1551, 0x3FB99999A0000000
  %189 = tail call contract noundef float @llvm.minnum.f32(float %mul477.11390, float 0x4024CB5EC0000000)
  %190 = tail call contract noundef float @llvm.exp.f32(float %189)
  %acc_s.sroa.0.4.vec.extract1648 = extractelement <4 x float> %188, i64 1
  %mul477.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1648, 0x3FB99999A0000000
  %191 = tail call contract noundef float @llvm.minnum.f32(float %mul477.1.1, float 0x4024CB5EC0000000)
  %192 = tail call contract noundef float @llvm.exp.f32(float %191)
  %acc_s.sroa.0.8.vec.extract1741 = extractelement <4 x float> %188, i64 2
  %mul477.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1741, 0x3FB99999A0000000
  %193 = tail call contract noundef float @llvm.minnum.f32(float %mul477.2.1, float 0x4024CB5EC0000000)
  %194 = tail call contract noundef float @llvm.exp.f32(float %193)
  %acc_s.sroa.0.12.vec.extract1834 = extractelement <4 x float> %188, i64 3
  %mul477.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1834, 0x3FB99999A0000000
  %195 = tail call contract noundef float @llvm.minnum.f32(float %mul477.3.1, float 0x4024CB5EC0000000)
  %196 = tail call contract noundef float @llvm.exp.f32(float %195)
  %add493.11391 = fadd contract float %sum_acc.sroa.0.4, %190
  %add493.1.1 = fadd contract float %sum_acc.sroa.20.4, %192
  %add493.2.1 = fadd contract float %sum_acc.sroa.38.4, %194
  %add493.3.1 = fadd contract float %sum_acc.sroa.56.4, %196
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %190)
  %198 = insertelement <4 x i16> poison, i16 %197, i64 0
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %192)
  %200 = insertelement <4 x i16> %198, i16 %199, i64 1
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %194)
  %202 = insertelement <4 x i16> %200, i16 %201, i64 2
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %196)
  %204 = insertelement <4 x i16> %202, i16 %203, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1476 = bitcast <4 x i16> %204 to <4 x half>
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1872, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.0.0), !call_argsrelate !106
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1879, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.14.0), !call_argsrelate !106
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1900, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.26.0), !call_argsrelate !106
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1907, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.38.0), !call_argsrelate !106
  br label %if.end529.1

if.end529.1:                                      ; preds = %if.end442.1, %if.end383.1
  %acc_o_1.sroa.38.1 = phi <4 x float> [ %acc_o_1.sroa.38.0, %if.end383.1 ], [ %208, %if.end442.1 ]
  %acc_o_1.sroa.26.1 = phi <4 x float> [ %acc_o_1.sroa.26.0, %if.end383.1 ], [ %207, %if.end442.1 ]
  %acc_o_1.sroa.14.1 = phi <4 x float> [ %acc_o_1.sroa.14.0, %if.end383.1 ], [ %206, %if.end442.1 ]
  %acc_o_1.sroa.0.1 = phi <4 x float> [ %acc_o_1.sroa.0.0, %if.end383.1 ], [ %205, %if.end442.1 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end383.1 ], [ %add493.3.1, %if.end442.1 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end383.1 ], [ %add493.2.1, %if.end442.1 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end383.1 ], [ %add493.1.1, %if.end442.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end383.1 ], [ %add493.11391, %if.end442.1 ]
  br i1 %or.cond1312.1, label %if.end675.1, label %for.cond537.preheader.1

for.cond537.preheader.1:                          ; preds = %if.end529.1
  %209 = shl nsw i32 %cond.i.i1230.6, 10
  %mul544.1 = and i32 %209, 64512
  %add547.1 = add nuw nsw i32 %add131, %mul544.1
  %210 = zext nneg i32 %add547.1 to i64
  %add.ptr552.11392 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210
  %V_reg.sroa.0.0.copyload1873 = load <4 x half>, ptr addrspace(4) %add.ptr552.11392, align 16
  %V_reg.sroa.18.0.add.ptr552.11392.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr552.11392, i64 8
  %V_reg.sroa.18.0.copyload1880 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr552.11392.sroa_idx, align 8
  %211 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210
  %add.ptr552.1.1 = getelementptr inbounds i8, ptr addrspace(4) %211, i64 1024
  %V_reg.sroa.26.16.copyload1901 = load <4 x half>, ptr addrspace(4) %add.ptr552.1.1, align 16
  %V_reg.sroa.42.16.add.ptr552.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %211, i64 1032
  %V_reg.sroa.42.16.copyload1908 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr552.1.1.sroa_idx, align 8
  %cmp562.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp562.1, label %for.cond564.preheader.1, label %if.end588.1

for.cond564.preheader.1:                          ; preds = %for.cond537.preheader.1
  %add571.1 = add nuw nsw i32 %mul11.6, %mul279
  %cmp574.not.11393 = icmp sgt i32 %add571.1, %1
  %fneg.1220.11394 = select i1 %cmp574.not.11393, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1561 = insertelement <4 x float> poison, float %fneg.1220.11394, i64 0
  %cmp574.not.1.1.not = icmp slt i32 %add571.1, %1
  %fneg.1220.1.1 = select i1 %cmp574.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1656 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1561, float %fneg.1220.1.1, i64 1
  %add572.2.1 = or disjoint i32 %add571.1, 2
  %cmp574.not.2.1 = icmp sgt i32 %add572.2.1, %1
  %fneg.1220.2.1 = select i1 %cmp574.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1749 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1656, float %fneg.1220.2.1, i64 2
  %add572.3.1 = or disjoint i32 %add571.1, 3
  %cmp574.not.3.1 = icmp sgt i32 %add572.3.1, %1
  %fneg.1220.3.1 = select i1 %cmp574.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1842 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1749, float %fneg.1220.3.1, i64 3
  br label %if.end588.1

if.end588.1:                                      ; preds = %for.cond537.preheader.1, %for.cond564.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1842, %for.cond564.preheader.1 ], [ zeroinitializer, %for.cond537.preheader.1 ]
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !86
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %212), !call_argsrelate !86
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %213), !call_argsrelate !86
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %214), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1563 = extractelement <4 x float> %215, i64 0
  %mul623.11398 = fmul contract float %acc_s.sroa.0.0.vec.extract1563, 0x3FB99999A0000000
  %216 = tail call contract noundef float @llvm.minnum.f32(float %mul623.11398, float 0x4024CB5EC0000000)
  %217 = tail call contract noundef float @llvm.exp.f32(float %216)
  %acc_s.sroa.0.4.vec.extract1658 = extractelement <4 x float> %215, i64 1
  %mul623.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1658, 0x3FB99999A0000000
  %218 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1.1, float 0x4024CB5EC0000000)
  %219 = tail call contract noundef float @llvm.exp.f32(float %218)
  %acc_s.sroa.0.8.vec.extract1751 = extractelement <4 x float> %215, i64 2
  %mul623.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1751, 0x3FB99999A0000000
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2.1, float 0x4024CB5EC0000000)
  %221 = tail call contract noundef float @llvm.exp.f32(float %220)
  %acc_s.sroa.0.12.vec.extract1844 = extractelement <4 x float> %215, i64 3
  %mul623.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1844, 0x3FB99999A0000000
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3.1, float 0x4024CB5EC0000000)
  %223 = tail call contract noundef float @llvm.exp.f32(float %222)
  %add639.11399 = fadd contract float %sum_acc.sroa.0.5, %217
  %add639.1.1 = fadd contract float %sum_acc.sroa.20.5, %219
  %add639.2.1 = fadd contract float %sum_acc.sroa.38.5, %221
  %add639.3.1 = fadd contract float %sum_acc.sroa.56.5, %223
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %217)
  %225 = insertelement <4 x i16> poison, i16 %224, i64 0
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %219)
  %227 = insertelement <4 x i16> %225, i16 %226, i64 1
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221)
  %229 = insertelement <4 x i16> %227, i16 %228, i64 2
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223)
  %231 = insertelement <4 x i16> %229, i16 %230, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1478 = bitcast <4 x i16> %231 to <4 x half>
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1873, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.0.0), !call_argsrelate !106
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1880, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.14.0), !call_argsrelate !106
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1901, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.26.0), !call_argsrelate !106
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1908, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.38.0), !call_argsrelate !106
  br label %if.end675.1

if.end675.1:                                      ; preds = %if.end588.1, %if.end529.1
  %acc_o_2.sroa.38.1 = phi <4 x float> [ %acc_o_2.sroa.38.0, %if.end529.1 ], [ %235, %if.end588.1 ]
  %acc_o_2.sroa.26.1 = phi <4 x float> [ %acc_o_2.sroa.26.0, %if.end529.1 ], [ %234, %if.end588.1 ]
  %acc_o_2.sroa.14.1 = phi <4 x float> [ %acc_o_2.sroa.14.0, %if.end529.1 ], [ %233, %if.end588.1 ]
  %acc_o_2.sroa.0.1 = phi <4 x float> [ %acc_o_2.sroa.0.0, %if.end529.1 ], [ %232, %if.end588.1 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end529.1 ], [ %add639.3.1, %if.end588.1 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end529.1 ], [ %add639.2.1, %if.end588.1 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end529.1 ], [ %add639.1.1, %if.end588.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end529.1 ], [ %add639.11399, %if.end588.1 ]
  br i1 %or.cond1314.1, label %if.end821.1, label %for.cond683.preheader.1

for.cond683.preheader.1:                          ; preds = %if.end675.1
  %236 = shl nsw i32 %cond.i.i1230.7, 10
  %mul690.1 = and i32 %236, 64512
  %add693.1 = add nuw nsw i32 %add131, %mul690.1
  %237 = zext nneg i32 %add693.1 to i64
  %add.ptr698.11400 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %237
  %V_reg.sroa.0.0.copyload1874 = load <4 x half>, ptr addrspace(4) %add.ptr698.11400, align 16
  %V_reg.sroa.18.0.add.ptr698.11400.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr698.11400, i64 8
  %V_reg.sroa.18.0.copyload1881 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr698.11400.sroa_idx, align 8
  %238 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %237
  %add.ptr698.1.1 = getelementptr inbounds i8, ptr addrspace(4) %238, i64 1024
  %V_reg.sroa.26.16.copyload1902 = load <4 x half>, ptr addrspace(4) %add.ptr698.1.1, align 16
  %V_reg.sroa.42.16.add.ptr698.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %238, i64 1032
  %V_reg.sroa.42.16.copyload1909 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr698.1.1.sroa_idx, align 8
  %cmp708.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp708.1, label %for.cond710.preheader.1, label %if.end734.1

for.cond710.preheader.1:                          ; preds = %for.cond683.preheader.1
  %add717.1 = add nuw nsw i32 %mul11.7, %mul279
  %cmp720.not.11401 = icmp sgt i32 %add717.1, %1
  %fneg.1221.11402 = select i1 %cmp720.not.11401, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1573 = insertelement <4 x float> poison, float %fneg.1221.11402, i64 0
  %cmp720.not.1.1.not = icmp slt i32 %add717.1, %1
  %fneg.1221.1.1 = select i1 %cmp720.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1666 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1573, float %fneg.1221.1.1, i64 1
  %add718.2.1 = or disjoint i32 %add717.1, 2
  %cmp720.not.2.1 = icmp sgt i32 %add718.2.1, %1
  %fneg.1221.2.1 = select i1 %cmp720.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1759 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1666, float %fneg.1221.2.1, i64 2
  %add718.3.1 = or disjoint i32 %add717.1, 3
  %cmp720.not.3.1 = icmp sgt i32 %add718.3.1, %1
  %fneg.1221.3.1 = select i1 %cmp720.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1852 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1759, float %fneg.1221.3.1, i64 3
  br label %if.end734.1

if.end734.1:                                      ; preds = %for.cond683.preheader.1, %for.cond710.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1852, %for.cond710.preheader.1 ], [ zeroinitializer, %for.cond683.preheader.1 ]
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !86
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %239), !call_argsrelate !86
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %240), !call_argsrelate !86
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %241), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1575 = extractelement <4 x float> %242, i64 0
  %mul769.11406 = fmul contract float %acc_s.sroa.0.0.vec.extract1575, 0x3FB99999A0000000
  %243 = tail call contract noundef float @llvm.minnum.f32(float %mul769.11406, float 0x4024CB5EC0000000)
  %244 = tail call contract noundef float @llvm.exp.f32(float %243)
  %acc_s.sroa.0.4.vec.extract1668 = extractelement <4 x float> %242, i64 1
  %mul769.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1668, 0x3FB99999A0000000
  %245 = tail call contract noundef float @llvm.minnum.f32(float %mul769.1.1, float 0x4024CB5EC0000000)
  %246 = tail call contract noundef float @llvm.exp.f32(float %245)
  %acc_s.sroa.0.8.vec.extract1761 = extractelement <4 x float> %242, i64 2
  %mul769.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1761, 0x3FB99999A0000000
  %247 = tail call contract noundef float @llvm.minnum.f32(float %mul769.2.1, float 0x4024CB5EC0000000)
  %248 = tail call contract noundef float @llvm.exp.f32(float %247)
  %acc_s.sroa.0.12.vec.extract1854 = extractelement <4 x float> %242, i64 3
  %mul769.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1854, 0x3FB99999A0000000
  %249 = tail call contract noundef float @llvm.minnum.f32(float %mul769.3.1, float 0x4024CB5EC0000000)
  %250 = tail call contract noundef float @llvm.exp.f32(float %249)
  %add785.11407 = fadd contract float %sum_acc.sroa.0.6, %244
  %add785.1.1 = fadd contract float %sum_acc.sroa.20.6, %246
  %add785.2.1 = fadd contract float %sum_acc.sroa.38.6, %248
  %add785.3.1 = fadd contract float %sum_acc.sroa.56.6, %250
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %244)
  %252 = insertelement <4 x i16> poison, i16 %251, i64 0
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %246)
  %254 = insertelement <4 x i16> %252, i16 %253, i64 1
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %248)
  %256 = insertelement <4 x i16> %254, i16 %255, i64 2
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %250)
  %258 = insertelement <4 x i16> %256, i16 %257, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1480 = bitcast <4 x i16> %258 to <4 x half>
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1874, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.0.0), !call_argsrelate !106
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1881, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.14.0), !call_argsrelate !106
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1902, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.26.0), !call_argsrelate !106
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1909, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.38.0), !call_argsrelate !106
  br label %if.end821.1

if.end821.1:                                      ; preds = %if.end734.1, %if.end675.1
  %acc_o_3.sroa.38.1 = phi <4 x float> [ %acc_o_3.sroa.38.0, %if.end675.1 ], [ %262, %if.end734.1 ]
  %acc_o_3.sroa.26.1 = phi <4 x float> [ %acc_o_3.sroa.26.0, %if.end675.1 ], [ %261, %if.end734.1 ]
  %acc_o_3.sroa.14.1 = phi <4 x float> [ %acc_o_3.sroa.14.0, %if.end675.1 ], [ %260, %if.end734.1 ]
  %acc_o_3.sroa.0.1 = phi <4 x float> [ %acc_o_3.sroa.0.0, %if.end675.1 ], [ %259, %if.end734.1 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end675.1 ], [ %add785.3.1, %if.end734.1 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end675.1 ], [ %add785.2.1, %if.end734.1 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end675.1 ], [ %add785.1.1, %if.end734.1 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end675.1 ], [ %add785.11407, %if.end734.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0
  %acc_o_1.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 0
  %add833 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_1.sroa.0.0.vec.extract
  %acc_o_2.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 0
  %add840 = fadd contract float %add833, %acc_o_2.sroa.0.0.vec.extract
  %acc_o_3.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 0
  %add847 = fadd contract float %add840, %acc_o_3.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1
  %acc_o_1.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 1
  %add833.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_1.sroa.0.4.vec.extract
  %acc_o_2.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 1
  %add840.1 = fadd contract float %add833.1, %acc_o_2.sroa.0.4.vec.extract
  %acc_o_3.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 1
  %add847.1 = fadd contract float %add840.1, %acc_o_3.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2
  %acc_o_1.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 2
  %add833.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_1.sroa.0.8.vec.extract
  %acc_o_2.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 2
  %add840.2 = fadd contract float %add833.2, %acc_o_2.sroa.0.8.vec.extract
  %acc_o_3.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 2
  %add847.2 = fadd contract float %add840.2, %acc_o_3.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3
  %acc_o_1.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 3
  %add833.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_1.sroa.0.12.vec.extract
  %acc_o_2.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 3
  %add840.3 = fadd contract float %add833.3, %acc_o_2.sroa.0.12.vec.extract
  %acc_o_3.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 3
  %add847.3 = fadd contract float %add840.3, %acc_o_3.sroa.0.12.vec.extract
  %acc_o.sroa.38.16.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 0
  %acc_o_1.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 0
  %add833.4 = fadd contract float %acc_o.sroa.38.16.vec.extract, %acc_o_1.sroa.14.16.vec.extract
  %acc_o_2.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 0
  %add840.4 = fadd contract float %add833.4, %acc_o_2.sroa.14.16.vec.extract
  %acc_o_3.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 0
  %add847.4 = fadd contract float %add840.4, %acc_o_3.sroa.14.16.vec.extract
  %acc_o.sroa.38.20.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 1
  %acc_o_1.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 1
  %add833.5 = fadd contract float %acc_o.sroa.38.20.vec.extract, %acc_o_1.sroa.14.20.vec.extract
  %acc_o_2.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 1
  %add840.5 = fadd contract float %add833.5, %acc_o_2.sroa.14.20.vec.extract
  %acc_o_3.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 1
  %add847.5 = fadd contract float %add840.5, %acc_o_3.sroa.14.20.vec.extract
  %acc_o.sroa.38.24.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 2
  %acc_o_1.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 2
  %add833.6 = fadd contract float %acc_o.sroa.38.24.vec.extract, %acc_o_1.sroa.14.24.vec.extract
  %acc_o_2.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 2
  %add840.6 = fadd contract float %add833.6, %acc_o_2.sroa.14.24.vec.extract
  %acc_o_3.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 2
  %add847.6 = fadd contract float %add840.6, %acc_o_3.sroa.14.24.vec.extract
  %acc_o.sroa.38.28.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 3
  %acc_o_1.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 3
  %add833.7 = fadd contract float %acc_o.sroa.38.28.vec.extract, %acc_o_1.sroa.14.28.vec.extract
  %acc_o_2.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 3
  %add840.7 = fadd contract float %add833.7, %acc_o_2.sroa.14.28.vec.extract
  %acc_o_3.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 3
  %add847.7 = fadd contract float %add840.7, %acc_o_3.sroa.14.28.vec.extract
  %acc_o.sroa.74.32.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 0
  %acc_o_1.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 0
  %add833.8 = fadd contract float %acc_o.sroa.74.32.vec.extract, %acc_o_1.sroa.26.32.vec.extract
  %acc_o_2.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 0
  %add840.8 = fadd contract float %add833.8, %acc_o_2.sroa.26.32.vec.extract
  %acc_o_3.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 0
  %add847.8 = fadd contract float %add840.8, %acc_o_3.sroa.26.32.vec.extract
  %acc_o.sroa.74.36.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 1
  %acc_o_1.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 1
  %add833.9 = fadd contract float %acc_o.sroa.74.36.vec.extract, %acc_o_1.sroa.26.36.vec.extract
  %acc_o_2.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 1
  %add840.9 = fadd contract float %add833.9, %acc_o_2.sroa.26.36.vec.extract
  %acc_o_3.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 1
  %add847.9 = fadd contract float %add840.9, %acc_o_3.sroa.26.36.vec.extract
  %acc_o.sroa.74.40.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 2
  %acc_o_1.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 2
  %add833.10 = fadd contract float %acc_o.sroa.74.40.vec.extract, %acc_o_1.sroa.26.40.vec.extract
  %acc_o_2.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 2
  %add840.10 = fadd contract float %add833.10, %acc_o_2.sroa.26.40.vec.extract
  %acc_o_3.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 2
  %add847.10 = fadd contract float %add840.10, %acc_o_3.sroa.26.40.vec.extract
  %acc_o.sroa.74.44.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 3
  %acc_o_1.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 3
  %add833.11 = fadd contract float %acc_o.sroa.74.44.vec.extract, %acc_o_1.sroa.26.44.vec.extract
  %acc_o_2.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 3
  %add840.11 = fadd contract float %add833.11, %acc_o_2.sroa.26.44.vec.extract
  %acc_o_3.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 3
  %add847.11 = fadd contract float %add840.11, %acc_o_3.sroa.26.44.vec.extract
  %acc_o.sroa.110.48.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 0
  %acc_o_1.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 0
  %add833.12 = fadd contract float %acc_o.sroa.110.48.vec.extract, %acc_o_1.sroa.38.48.vec.extract
  %acc_o_2.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 0
  %add840.12 = fadd contract float %add833.12, %acc_o_2.sroa.38.48.vec.extract
  %acc_o_3.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 0
  %add847.12 = fadd contract float %add840.12, %acc_o_3.sroa.38.48.vec.extract
  %acc_o.sroa.110.52.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 1
  %acc_o_1.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 1
  %add833.13 = fadd contract float %acc_o.sroa.110.52.vec.extract, %acc_o_1.sroa.38.52.vec.extract
  %acc_o_2.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 1
  %add840.13 = fadd contract float %add833.13, %acc_o_2.sroa.38.52.vec.extract
  %acc_o_3.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 1
  %add847.13 = fadd contract float %add840.13, %acc_o_3.sroa.38.52.vec.extract
  %acc_o.sroa.110.56.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 2
  %acc_o_1.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 2
  %add833.14 = fadd contract float %acc_o.sroa.110.56.vec.extract, %acc_o_1.sroa.38.56.vec.extract
  %acc_o_2.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 2
  %add840.14 = fadd contract float %add833.14, %acc_o_2.sroa.38.56.vec.extract
  %acc_o_3.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 2
  %add847.14 = fadd contract float %add840.14, %acc_o_3.sroa.38.56.vec.extract
  %acc_o.sroa.110.60.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 3
  %acc_o_1.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 3
  %add833.15 = fadd contract float %acc_o.sroa.110.60.vec.extract, %acc_o_1.sroa.38.60.vec.extract
  %acc_o_2.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 3
  %add840.15 = fadd contract float %add833.15, %acc_o_2.sroa.38.60.vec.extract
  %acc_o_3.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 3
  %add847.15 = fadd contract float %add840.15, %acc_o_3.sroa.38.60.vec.extract
  %add861 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add861.1 = fadd contract float %add861, %sum_acc.sroa.20.7
  %add861.2 = fadd contract float %add861.1, %sum_acc.sroa.38.7
  %add861.3 = fadd contract float %add861.2, %sum_acc.sroa.56.7
  %263 = bitcast float %add861.3 to i32
  %264 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %265 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %264) #11
  %xor.i.i = xor i32 %265, 32
  %266 = and i32 %265, -64
  %and.i.i = add nsw i32 %266, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i1231 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %265
  %shl.i.i = shl i32 %cond.i.i1231, 2
  %267 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %263)
  %268 = bitcast i32 %267 to float
  %add.i = fadd contract float %add861.3, %268
  %269 = bitcast float %add.i to i32
  %270 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %271 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %270) #11
  %xor.i.i1232 = xor i32 %271, 16
  %272 = and i32 %271, -64
  %and.i.i1233 = add nsw i32 %272, 64
  %cmp.not.i.i1234 = icmp slt i32 %xor.i.i1232, %and.i.i1233
  %cond.i.i1235 = select i1 %cmp.not.i.i1234, i32 %xor.i.i1232, i32 %271
  %shl.i.i1236 = shl i32 %cond.i.i1235, 2
  %273 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1236, i32 %269)
  %274 = bitcast i32 %273 to float
  %add.i.i = fadd contract float %add.i, %274
  %cmp870 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp870, float %div, float 0.000000e+00
  %mul883 = fmul contract float %condval_4.0, %add847
  %mul883.1 = fmul contract float %condval_4.0, %add847.1
  %mul883.2 = fmul contract float %condval_4.0, %add847.2
  %mul883.3 = fmul contract float %condval_4.0, %add847.3
  %mul883.4 = fmul contract float %condval_4.0, %add847.4
  %mul883.5 = fmul contract float %condval_4.0, %add847.5
  %mul883.6 = fmul contract float %condval_4.0, %add847.6
  %mul883.7 = fmul contract float %condval_4.0, %add847.7
  %mul883.8 = fmul contract float %condval_4.0, %add847.8
  %mul883.9 = fmul contract float %condval_4.0, %add847.9
  %mul883.10 = fmul contract float %condval_4.0, %add847.10
  %mul883.11 = fmul contract float %condval_4.0, %add847.11
  %mul883.12 = fmul contract float %condval_4.0, %add847.12
  %mul883.13 = fmul contract float %condval_4.0, %add847.13
  %mul883.14 = fmul contract float %condval_4.0, %add847.14
  %mul883.15 = fmul contract float %condval_4.0, %add847.15
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883)
  %O_reg.sroa.0.0.insert.ext = zext i16 %275 to i64
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %276 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %277 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %278 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %279 to i64
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %280 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %281 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %282 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %283 to i64
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %284 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %286 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %287 to i64
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %288 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %290 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr925 = lshr i32 %18, 5
  %and928 = and i32 %18, 7
  %mul934 = and i32 %22, 4
  %xor = xor i32 %shr925, %and928
  %mul929 = shl nuw nsw i32 %xor, 3
  %add930 = add nuw nsw i32 %mul929, %mul25
  %add935 = or disjoint i32 %add930, %mul934
  %add.ptr937 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr937, align 8
  %add926.1 = add nuw nsw i32 %shr925, 2
  %xor.1 = xor i32 %add926.1, %and928
  %mul929.1 = shl nuw nsw i32 %xor.1, 3
  %add930.1 = add nuw nsw i32 %mul929.1, %mul25
  %add935.1 = or disjoint i32 %add930.1, %mul934
  %add.ptr937.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr937.1, align 8
  %add926.2 = add nuw nsw i32 %shr925, 4
  %xor.2 = xor i32 %add926.2, %and928
  %mul929.2 = shl nuw nsw i32 %xor.2, 3
  %add930.2 = add nuw nsw i32 %mul929.2, %mul25
  %add935.2 = or disjoint i32 %add930.2, %mul934
  %add.ptr937.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr937.2, align 8
  %add926.3 = add nuw nsw i32 %shr925, 6
  %xor.3 = xor i32 %add926.3, %and928
  %mul929.3 = shl nuw nsw i32 %xor.3, 3
  %add930.3 = add nuw nsw i32 %mul929.3, %mul25
  %add935.3 = or disjoint i32 %add930.3, %mul934
  %add.ptr937.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr937.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul948 = and i32 %mul135, 8128
  %xor9541217 = and i32 %mul135, 56
  %call952.masked = and i32 %18, 1016
  %mul955 = xor i32 %xor9541217, %call952.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul948
  %invariant.gep1305 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul955
  %add965 = add nuw nsw i32 %add23, %mul135
  %291 = zext nneg i32 %add965 to i64
  %add.ptr970 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %291
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr970, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1305, i64 16, i1 false), !tbaa.struct !260, !call_argsrelate !261
  %gep1306.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1305, i32 1024
  %292 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %291
  %add.ptr970.1 = getelementptr inbounds i8, ptr addrspace(1) %292, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr970.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1306.1, i64 16, i1 false), !tbaa.struct !260, !call_argsrelate !261
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


