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
  %cond.i.i2318 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i2318, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i2318.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i2318.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i2318.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i2318.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i2318.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i2318.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i2318.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i2318.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i2318.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i2318.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i2318.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i2318.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i2318.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i2318.7, 4
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
  %cond.i.i.i = tail call noundef i32 @llvm.umax.i32(i32 %mul11, i32 %mul11.1)
  %cond.i.i.i2319 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.2, i32 %mul11.3)
  %cond.i.i.i2320 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i, i32 %cond.i.i.i2319)
  %cond.i.i.i2321 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.4, i32 %mul11.5)
  %cond.i.i.i2322 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.6, i32 %mul11.7)
  %cond.i.i.i2323 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i2321, i32 %cond.i.i.i2322)
  %cond.i.i.i2324 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i2320, i32 %cond.i.i.i2323)
  %add86 = add nuw nsw i32 %1, 1
  %shr87 = and i32 %add86, 2147483632
  %cmp89 = icmp ult i32 %cond.i.i.i2324, %shr87
  br i1 %cmp89, label %for.cond90.preheader, label %for.cond900.preheader

for.cond900.preheader:                            ; preds = %entry
  %invariant.op = add nsw i32 %1, -15
  %mul931 = shl nsw i32 %0, 16
  %mul938 = shl nuw nsw i32 %18, 3
  %add934 = or disjoint i32 %mul938, %mul931
  %22 = lshr i32 %18, 2
  %mul1083 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp924.not = icmp sgt i32 %mul11, %1
  %or.cond2518 = or i1 %or.cond, %cmp924.not
  br i1 %or.cond2518, label %if.end949, label %for.cond926.preheader

for.cond90.preheader:                             ; preds = %entry
  %conv = zext nneg i32 %0 to i64
  %23 = shl nuw nsw i32 %18, 3
  %mul128 = zext nneg i32 %23 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul128
  %invariant.gep2454 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul128
  %cmp114 = icmp sgt i32 %3, -1
  %cmp115 = icmp slt i32 %3, 64
  %24 = and i32 %cond.i.i2318, 268435455
  %shr120 = zext nneg i32 %24 to i64
  %cmp114.not = xor i1 %cmp114, true
  %cmp115.not = xor i1 %cmp115, true
  %brmerge = or i1 %cmp114.not, %cmp115.not
  br i1 %brmerge, label %if.end, label %if.then116

if.then116:                                       ; preds = %for.cond90.preheader
  %.idx = shl nuw nsw i64 %shr120, 11
  %25 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx
  %.idx2533 = shl nuw nsw i64 %conv, 17
  %26 = getelementptr inbounds i8, ptr addrspace(4) %25, i64 %.idx2533
  %27 = load <4 x half>, ptr addrspace(4) %26, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %26, i64 8
  %28 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx, align 8, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %for.cond90.preheader, %if.then116
  %29 = phi <4 x half> [ %28, %if.then116 ], [ zeroinitializer, %for.cond90.preheader ]
  %30 = phi <4 x half> [ %27, %if.then116 ], [ zeroinitializer, %for.cond90.preheader ]
  %cmp114.not4464 = xor i1 %cmp114, true
  %cmp115.not4465 = xor i1 %cmp115, true
  %brmerge4466 = or i1 %cmp114.not4464, %cmp115.not4465
  br i1 %brmerge4466, label %if.end.1, label %if.then116.1

if.then116.1:                                     ; preds = %if.end
  %.idx.1 = shl nuw nsw i64 %shr120, 11
  %31 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1
  %.idx2533.1 = shl nuw nsw i64 %conv, 17
  %32 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 %.idx2533.1
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %32, i64 1024
  %33 = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %32, i64 1032
  %34 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx.1, align 8, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.end, %if.then116.1
  %35 = phi <4 x half> [ %34, %if.then116.1 ], [ zeroinitializer, %if.end ]
  %36 = phi <4 x half> [ %33, %if.then116.1 ], [ zeroinitializer, %if.end ]
  %cmp162 = icmp sgt i32 %5, -1
  %cmp164 = icmp slt i32 %5, 64
  %37 = and i32 %cond.i.i2318.1, 268435455
  %shr170 = zext nneg i32 %37 to i64
  %cmp162.not = xor i1 %cmp162, true
  %cmp164.not = xor i1 %cmp164, true
  %brmerge4467 = or i1 %cmp162.not, %cmp164.not
  br i1 %brmerge4467, label %if.end204, label %if.then165

if.then165:                                       ; preds = %if.end.1
  %.idx2534 = shl nuw nsw i64 %shr170, 11
  %38 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534
  %.idx2535 = shl nuw nsw i64 %conv, 17
  %39 = getelementptr inbounds i8, ptr addrspace(4) %38, i64 %.idx2535
  %40 = load <4 x half>, ptr addrspace(4) %39, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %39, i64 8
  %41 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx, align 8, !tbaa !30
  br label %if.end204

if.end204:                                        ; preds = %if.end.1, %if.then165
  %42 = phi <4 x half> [ %41, %if.then165 ], [ zeroinitializer, %if.end.1 ]
  %43 = phi <4 x half> [ %40, %if.then165 ], [ zeroinitializer, %if.end.1 ]
  %cmp162.not4468 = xor i1 %cmp162, true
  %cmp164.not4469 = xor i1 %cmp164, true
  %brmerge4470 = or i1 %cmp162.not4468, %cmp164.not4469
  br i1 %brmerge4470, label %if.end204.1, label %if.then165.1

if.then165.1:                                     ; preds = %if.end204
  %.idx2534.1 = shl nuw nsw i64 %shr170, 11
  %44 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534.1
  %.idx2535.1 = shl nuw nsw i64 %conv, 17
  %45 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 %.idx2535.1
  %gep2446.1 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1024
  %46 = load <4 x half>, ptr addrspace(4) %gep2446.1, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1032
  %47 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx.1, align 8, !tbaa !30
  br label %if.end204.1

if.end204.1:                                      ; preds = %if.end204, %if.then165.1
  %48 = phi <4 x half> [ %47, %if.then165.1 ], [ zeroinitializer, %if.end204 ]
  %49 = phi <4 x half> [ %46, %if.then165.1 ], [ zeroinitializer, %if.end204 ]
  %cmp216 = icmp sgt i32 %7, -1
  %cmp218 = icmp slt i32 %7, 64
  %50 = and i32 %cond.i.i2318.2, 268435455
  %shr224 = zext nneg i32 %50 to i64
  %cmp216.not = xor i1 %cmp216, true
  %cmp218.not = xor i1 %cmp218, true
  %brmerge4471 = or i1 %cmp216.not, %cmp218.not
  br i1 %brmerge4471, label %if.end258, label %if.then219

if.then219:                                       ; preds = %if.end204.1
  %.idx2536 = shl nuw nsw i64 %shr224, 11
  %51 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536
  %.idx2537 = shl nuw nsw i64 %conv, 17
  %52 = getelementptr inbounds i8, ptr addrspace(4) %51, i64 %.idx2537
  %53 = load <4 x half>, ptr addrspace(4) %52, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %52, i64 8
  %54 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx, align 8, !tbaa !30
  br label %if.end258

if.end258:                                        ; preds = %if.end204.1, %if.then219
  %55 = phi <4 x half> [ %54, %if.then219 ], [ zeroinitializer, %if.end204.1 ]
  %56 = phi <4 x half> [ %53, %if.then219 ], [ zeroinitializer, %if.end204.1 ]
  %cmp216.not4472 = xor i1 %cmp216, true
  %cmp218.not4473 = xor i1 %cmp218, true
  %brmerge4474 = or i1 %cmp216.not4472, %cmp218.not4473
  br i1 %brmerge4474, label %if.end258.1, label %if.then219.1

if.then219.1:                                     ; preds = %if.end258
  %.idx2536.1 = shl nuw nsw i64 %shr224, 11
  %57 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536.1
  %.idx2537.1 = shl nuw nsw i64 %conv, 17
  %58 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 %.idx2537.1
  %gep2449.1 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1024
  %59 = load <4 x half>, ptr addrspace(4) %gep2449.1, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1032
  %60 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx.1, align 8, !tbaa !30
  br label %if.end258.1

if.end258.1:                                      ; preds = %if.end258, %if.then219.1
  %61 = phi <4 x half> [ %60, %if.then219.1 ], [ zeroinitializer, %if.end258 ]
  %62 = phi <4 x half> [ %59, %if.then219.1 ], [ zeroinitializer, %if.end258 ]
  %cmp270 = icmp sgt i32 %9, -1
  %cmp272 = icmp slt i32 %9, 64
  %63 = and i32 %cond.i.i2318.3, 268435455
  %shr278 = zext nneg i32 %63 to i64
  %cmp270.not = xor i1 %cmp270, true
  %cmp272.not = xor i1 %cmp272, true
  %brmerge4475 = or i1 %cmp270.not, %cmp272.not
  br i1 %brmerge4475, label %if.end312, label %if.then273

if.then273:                                       ; preds = %if.end258.1
  %.idx2538 = shl nuw nsw i64 %shr278, 11
  %64 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538
  %.idx2539 = shl nuw nsw i64 %conv, 17
  %65 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 %.idx2539
  %66 = load <4 x half>, ptr addrspace(4) %65, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %65, i64 8
  %67 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx, align 8, !tbaa !30
  br label %if.end312

if.end312:                                        ; preds = %if.end258.1, %if.then273
  %68 = phi <4 x half> [ %67, %if.then273 ], [ zeroinitializer, %if.end258.1 ]
  %69 = phi <4 x half> [ %66, %if.then273 ], [ zeroinitializer, %if.end258.1 ]
  %cmp270.not4476 = xor i1 %cmp270, true
  %cmp272.not4477 = xor i1 %cmp272, true
  %brmerge4478 = or i1 %cmp270.not4476, %cmp272.not4477
  br i1 %brmerge4478, label %if.end312.1, label %if.then273.1

if.then273.1:                                     ; preds = %if.end312
  %.idx2538.1 = shl nuw nsw i64 %shr278, 11
  %70 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538.1
  %.idx2539.1 = shl nuw nsw i64 %conv, 17
  %71 = getelementptr inbounds i8, ptr addrspace(4) %70, i64 %.idx2539.1
  %gep2452.1 = getelementptr inbounds i8, ptr addrspace(4) %71, i64 1024
  %72 = load <4 x half>, ptr addrspace(4) %gep2452.1, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %71, i64 1032
  %73 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx.1, align 8, !tbaa !30
  br label %if.end312.1

if.end312.1:                                      ; preds = %if.end312, %if.then273.1
  %74 = phi <4 x half> [ %73, %if.then273.1 ], [ zeroinitializer, %if.end312 ]
  %75 = phi <4 x half> [ %72, %if.then273.1 ], [ zeroinitializer, %if.end312 ]
  %cmp114.not4479 = xor i1 %cmp114, true
  %cmp115.not4480 = xor i1 %cmp115, true
  %brmerge4481 = or i1 %cmp114.not4479, %cmp115.not4480
  br i1 %brmerge4481, label %if.end366, label %if.then327

if.then327:                                       ; preds = %if.end312.1
  %.idx2540 = shl nuw nsw i64 %shr120, 11
  %76 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540
  %.idx2541 = shl nuw nsw i64 %conv, 17
  %77 = getelementptr inbounds i8, ptr addrspace(4) %76, i64 %.idx2541
  %78 = load <4 x half>, ptr addrspace(4) %77, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %77, i64 8
  %79 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx, align 8, !tbaa !30
  br label %if.end366

if.end366:                                        ; preds = %if.end312.1, %if.then327
  %80 = phi <4 x half> [ %79, %if.then327 ], [ zeroinitializer, %if.end312.1 ]
  %81 = phi <4 x half> [ %78, %if.then327 ], [ zeroinitializer, %if.end312.1 ]
  %cmp114.not4482 = xor i1 %cmp114, true
  %cmp115.not4483 = xor i1 %cmp115, true
  %brmerge4484 = or i1 %cmp114.not4482, %cmp115.not4483
  br i1 %brmerge4484, label %if.end366.1, label %if.then327.1

if.then327.1:                                     ; preds = %if.end366
  %.idx2540.1 = shl nuw nsw i64 %shr120, 11
  %82 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540.1
  %.idx2541.1 = shl nuw nsw i64 %conv, 17
  %83 = getelementptr inbounds i8, ptr addrspace(4) %82, i64 %.idx2541.1
  %gep2455.1 = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1024
  %84 = load <4 x half>, ptr addrspace(4) %gep2455.1, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1032
  %85 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx.1, align 8, !tbaa !30
  br label %if.end366.1

if.end366.1:                                      ; preds = %if.end366, %if.then327.1
  %86 = phi <4 x half> [ %85, %if.then327.1 ], [ zeroinitializer, %if.end366 ]
  %87 = phi <4 x half> [ %84, %if.then327.1 ], [ zeroinitializer, %if.end366 ]
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %88), !call_argsrelate !101
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %89), !call_argsrelate !101
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %90), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3097 = extractelement <4 x float> %91, i64 0
  %mul412 = fmul contract float %acc_s.sroa.0.0.vec.extract3097, 0x3FB99999A0000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul412, float 0x4024CB5EC0000000)
  %93 = tail call contract noundef float @llvm.exp.f32(float %92)
  %acc_s.sroa.0.4.vec.extract3278 = extractelement <4 x float> %91, i64 1
  %mul412.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3278, 0x3FB99999A0000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul412.1, float 0x4024CB5EC0000000)
  %95 = tail call contract noundef float @llvm.exp.f32(float %94)
  %acc_s.sroa.0.8.vec.extract3451 = extractelement <4 x float> %91, i64 2
  %mul412.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3451, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul412.2, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %acc_s.sroa.0.12.vec.extract3624 = extractelement <4 x float> %91, i64 3
  %mul412.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3624, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul412.3, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93)
  %101 = insertelement <4 x i16> poison, i16 %100, i64 0
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95)
  %103 = insertelement <4 x i16> %101, i16 %102, i64 1
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %105 = insertelement <4 x i16> %103, i16 %104, i64 2
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %107 = insertelement <4 x i16> %105, i16 %106, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2964 = bitcast <4 x i16> %107 to <4 x half>
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %81, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer)
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer)
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %87, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer)
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %86, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer)
  %cmp162.not4485 = xor i1 %cmp162, true
  %cmp164.not4486 = xor i1 %cmp164, true
  %brmerge4487 = or i1 %cmp162.not4485, %cmp164.not4486
  br i1 %brmerge4487, label %if.end510, label %if.then471

if.then471:                                       ; preds = %if.end366.1
  %.idx2542 = shl nuw nsw i64 %shr170, 11
  %112 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542
  %.idx2543 = shl nuw nsw i64 %conv, 17
  %113 = getelementptr inbounds i8, ptr addrspace(4) %112, i64 %.idx2543
  %114 = load <4 x half>, ptr addrspace(4) %113, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %113, i64 8
  %115 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx, align 8, !tbaa !30
  br label %if.end510

if.end510:                                        ; preds = %if.end366.1, %if.then471
  %116 = phi <4 x half> [ %115, %if.then471 ], [ zeroinitializer, %if.end366.1 ]
  %117 = phi <4 x half> [ %114, %if.then471 ], [ zeroinitializer, %if.end366.1 ]
  %cmp162.not4488 = xor i1 %cmp162, true
  %cmp164.not4489 = xor i1 %cmp164, true
  %brmerge4490 = or i1 %cmp162.not4488, %cmp164.not4489
  br i1 %brmerge4490, label %if.end510.1, label %if.then471.1

if.then471.1:                                     ; preds = %if.end510
  %.idx2542.1 = shl nuw nsw i64 %shr170, 11
  %118 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542.1
  %.idx2543.1 = shl nuw nsw i64 %conv, 17
  %119 = getelementptr inbounds i8, ptr addrspace(4) %118, i64 %.idx2543.1
  %gep2468.1 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1024
  %120 = load <4 x half>, ptr addrspace(4) %gep2468.1, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1032
  %121 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx.1, align 8, !tbaa !30
  br label %if.end510.1

if.end510.1:                                      ; preds = %if.end510, %if.then471.1
  %122 = phi <4 x half> [ %121, %if.then471.1 ], [ zeroinitializer, %if.end510 ]
  %123 = phi <4 x half> [ %120, %if.then471.1 ], [ zeroinitializer, %if.end510 ]
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %43, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %124), !call_argsrelate !101
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %49, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %125), !call_argsrelate !101
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %126), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3105 = extractelement <4 x float> %127, i64 0
  %mul556 = fmul contract float %acc_s.sroa.0.0.vec.extract3105, 0x3FB99999A0000000
  %128 = tail call contract noundef float @llvm.minnum.f32(float %mul556, float 0x4024CB5EC0000000)
  %129 = tail call contract noundef float @llvm.exp.f32(float %128)
  %acc_s.sroa.0.4.vec.extract3286 = extractelement <4 x float> %127, i64 1
  %mul556.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3286, 0x3FB99999A0000000
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul556.1, float 0x4024CB5EC0000000)
  %131 = tail call contract noundef float @llvm.exp.f32(float %130)
  %acc_s.sroa.0.8.vec.extract3459 = extractelement <4 x float> %127, i64 2
  %mul556.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3459, 0x3FB99999A0000000
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul556.2, float 0x4024CB5EC0000000)
  %133 = tail call contract noundef float @llvm.exp.f32(float %132)
  %acc_s.sroa.0.12.vec.extract3632 = extractelement <4 x float> %127, i64 3
  %mul556.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3632, 0x3FB99999A0000000
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul556.3, float 0x4024CB5EC0000000)
  %135 = tail call contract noundef float @llvm.exp.f32(float %134)
  %add572 = fadd contract float %93, %129
  %add572.1 = fadd contract float %95, %131
  %add572.2 = fadd contract float %97, %133
  %add572.3 = fadd contract float %99, %135
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %129)
  %137 = insertelement <4 x i16> poison, i16 %136, i64 0
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131)
  %139 = insertelement <4 x i16> %137, i16 %138, i64 1
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133)
  %141 = insertelement <4 x i16> %139, i16 %140, i64 2
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135)
  %143 = insertelement <4 x i16> %141, i16 %142, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2966 = bitcast <4 x i16> %143 to <4 x half>
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %117, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer)
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %116, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer)
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %123, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer)
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer)
  %cmp216.not4491 = xor i1 %cmp216, true
  %cmp218.not4492 = xor i1 %cmp218, true
  %brmerge4493 = or i1 %cmp216.not4491, %cmp218.not4492
  br i1 %brmerge4493, label %if.end654, label %if.then615

if.then615:                                       ; preds = %if.end510.1
  %.idx2544 = shl nuw nsw i64 %shr224, 11
  %148 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544
  %.idx2545 = shl nuw nsw i64 %conv, 17
  %149 = getelementptr inbounds i8, ptr addrspace(4) %148, i64 %.idx2545
  %150 = load <4 x half>, ptr addrspace(4) %149, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %149, i64 8
  %151 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx, align 8, !tbaa !30
  br label %if.end654

if.end654:                                        ; preds = %if.end510.1, %if.then615
  %152 = phi <4 x half> [ %151, %if.then615 ], [ zeroinitializer, %if.end510.1 ]
  %153 = phi <4 x half> [ %150, %if.then615 ], [ zeroinitializer, %if.end510.1 ]
  %cmp216.not4494 = xor i1 %cmp216, true
  %cmp218.not4495 = xor i1 %cmp218, true
  %brmerge4496 = or i1 %cmp216.not4494, %cmp218.not4495
  br i1 %brmerge4496, label %if.end654.1, label %if.then615.1

if.then615.1:                                     ; preds = %if.end654
  %.idx2544.1 = shl nuw nsw i64 %shr224, 11
  %154 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544.1
  %.idx2545.1 = shl nuw nsw i64 %conv, 17
  %155 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 %.idx2545.1
  %gep2481.1 = getelementptr inbounds i8, ptr addrspace(4) %155, i64 1024
  %156 = load <4 x half>, ptr addrspace(4) %gep2481.1, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %155, i64 1032
  %157 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx.1, align 8, !tbaa !30
  br label %if.end654.1

if.end654.1:                                      ; preds = %if.end654, %if.then615.1
  %158 = phi <4 x half> [ %157, %if.then615.1 ], [ zeroinitializer, %if.end654 ]
  %159 = phi <4 x half> [ %156, %if.then615.1 ], [ zeroinitializer, %if.end654 ]
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %160), !call_argsrelate !101
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %62, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %161), !call_argsrelate !101
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %162), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3113 = extractelement <4 x float> %163, i64 0
  %mul700 = fmul contract float %acc_s.sroa.0.0.vec.extract3113, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul700, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %acc_s.sroa.0.4.vec.extract3294 = extractelement <4 x float> %163, i64 1
  %mul700.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3294, 0x3FB99999A0000000
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul700.1, float 0x4024CB5EC0000000)
  %167 = tail call contract noundef float @llvm.exp.f32(float %166)
  %acc_s.sroa.0.8.vec.extract3467 = extractelement <4 x float> %163, i64 2
  %mul700.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3467, 0x3FB99999A0000000
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul700.2, float 0x4024CB5EC0000000)
  %169 = tail call contract noundef float @llvm.exp.f32(float %168)
  %acc_s.sroa.0.12.vec.extract3640 = extractelement <4 x float> %163, i64 3
  %mul700.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3640, 0x3FB99999A0000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul700.3, float 0x4024CB5EC0000000)
  %171 = tail call contract noundef float @llvm.exp.f32(float %170)
  %add716 = fadd contract float %add572, %165
  %add716.1 = fadd contract float %add572.1, %167
  %add716.2 = fadd contract float %add572.2, %169
  %add716.3 = fadd contract float %add572.3, %171
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %173 = insertelement <4 x i16> poison, i16 %172, i64 0
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167)
  %175 = insertelement <4 x i16> %173, i16 %174, i64 1
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169)
  %177 = insertelement <4 x i16> %175, i16 %176, i64 2
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171)
  %179 = insertelement <4 x i16> %177, i16 %178, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2968 = bitcast <4 x i16> %179 to <4 x half>
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %153, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %108)
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %152, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %109)
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %159, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %110)
  %183 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %158, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %111)
  %cmp270.not4497 = xor i1 %cmp270, true
  %cmp272.not4498 = xor i1 %cmp272, true
  %brmerge4499 = or i1 %cmp270.not4497, %cmp272.not4498
  br i1 %brmerge4499, label %if.end798, label %if.then759

if.then759:                                       ; preds = %if.end654.1
  %.idx2546 = shl nuw nsw i64 %shr278, 11
  %184 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546
  %.idx2547 = shl nuw nsw i64 %conv, 17
  %185 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 %.idx2547
  %186 = load <4 x half>, ptr addrspace(4) %185, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %185, i64 8
  %187 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx, align 8, !tbaa !30
  br label %if.end798

if.end798:                                        ; preds = %if.end654.1, %if.then759
  %188 = phi <4 x half> [ %187, %if.then759 ], [ zeroinitializer, %if.end654.1 ]
  %189 = phi <4 x half> [ %186, %if.then759 ], [ zeroinitializer, %if.end654.1 ]
  %cmp270.not4500 = xor i1 %cmp270, true
  %cmp272.not4501 = xor i1 %cmp272, true
  %brmerge4502 = or i1 %cmp270.not4500, %cmp272.not4501
  br i1 %brmerge4502, label %if.end798.1, label %if.then759.1

if.then759.1:                                     ; preds = %if.end798
  %.idx2546.1 = shl nuw nsw i64 %shr278, 11
  %190 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546.1
  %.idx2547.1 = shl nuw nsw i64 %conv, 17
  %191 = getelementptr inbounds i8, ptr addrspace(4) %190, i64 %.idx2547.1
  %gep2494.1 = getelementptr inbounds i8, ptr addrspace(4) %191, i64 1024
  %192 = load <4 x half>, ptr addrspace(4) %gep2494.1, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %191, i64 1032
  %193 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx.1, align 8, !tbaa !30
  br label %if.end798.1

if.end798.1:                                      ; preds = %if.end798, %if.then759.1
  %194 = phi <4 x half> [ %193, %if.then759.1 ], [ zeroinitializer, %if.end798 ]
  %195 = phi <4 x half> [ %192, %if.then759.1 ], [ zeroinitializer, %if.end798 ]
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %196), !call_argsrelate !101
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %197), !call_argsrelate !101
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %198), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3121 = extractelement <4 x float> %199, i64 0
  %mul844 = fmul contract float %acc_s.sroa.0.0.vec.extract3121, 0x3FB99999A0000000
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul844, float 0x4024CB5EC0000000)
  %201 = tail call contract noundef float @llvm.exp.f32(float %200)
  %acc_s.sroa.0.4.vec.extract3302 = extractelement <4 x float> %199, i64 1
  %mul844.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3302, 0x3FB99999A0000000
  %202 = tail call contract noundef float @llvm.minnum.f32(float %mul844.1, float 0x4024CB5EC0000000)
  %203 = tail call contract noundef float @llvm.exp.f32(float %202)
  %acc_s.sroa.0.8.vec.extract3475 = extractelement <4 x float> %199, i64 2
  %mul844.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3475, 0x3FB99999A0000000
  %204 = tail call contract noundef float @llvm.minnum.f32(float %mul844.2, float 0x4024CB5EC0000000)
  %205 = tail call contract noundef float @llvm.exp.f32(float %204)
  %acc_s.sroa.0.12.vec.extract3648 = extractelement <4 x float> %199, i64 3
  %mul844.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3648, 0x3FB99999A0000000
  %206 = tail call contract noundef float @llvm.minnum.f32(float %mul844.3, float 0x4024CB5EC0000000)
  %207 = tail call contract noundef float @llvm.exp.f32(float %206)
  %add860 = fadd contract float %add716, %201
  %add860.1 = fadd contract float %add716.1, %203
  %add860.2 = fadd contract float %add716.2, %205
  %add860.3 = fadd contract float %add716.3, %207
  %208 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201)
  %209 = insertelement <4 x i16> poison, i16 %208, i64 0
  %210 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %203)
  %211 = insertelement <4 x i16> %209, i16 %210, i64 1
  %212 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %205)
  %213 = insertelement <4 x i16> %211, i16 %212, i64 2
  %214 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %207)
  %215 = insertelement <4 x i16> %213, i16 %214, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2970 = bitcast <4 x i16> %215 to <4 x half>
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %189, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %144)
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %188, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %145)
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %195, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %146)
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %194, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %147)
  %cmp114.1 = icmp sgt i32 %11, -1
  %cmp115.1 = icmp slt i32 %11, 64
  %220 = and i32 %cond.i.i2318.4, 268435455
  %shr120.1 = zext nneg i32 %220 to i64
  %cmp114.1.not = xor i1 %cmp114.1, true
  %cmp115.1.not = xor i1 %cmp115.1, true
  %brmerge4503 = or i1 %cmp114.1.not, %cmp115.1.not
  br i1 %brmerge4503, label %if.end.12680, label %if.then116.12672

if.then116.12672:                                 ; preds = %if.end798.1
  %.idx.12663 = shl nuw nsw i64 %shr120.1, 11
  %221 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.12663
  %.idx2533.12664 = shl nuw nsw i64 %conv, 17
  %222 = getelementptr inbounds i8, ptr addrspace(4) %221, i64 %.idx2533.12664
  %223 = load <4 x half>, ptr addrspace(4) %222, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx.12668 = getelementptr inbounds i8, ptr addrspace(4) %222, i64 8
  %224 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx.12668, align 8, !tbaa !30
  br label %if.end.12680

if.end.12680:                                     ; preds = %if.end798.1, %if.then116.12672
  %225 = phi <4 x half> [ %224, %if.then116.12672 ], [ zeroinitializer, %if.end798.1 ]
  %226 = phi <4 x half> [ %223, %if.then116.12672 ], [ zeroinitializer, %if.end798.1 ]
  %cmp114.1.not4504 = xor i1 %cmp114.1, true
  %cmp115.1.not4505 = xor i1 %cmp115.1, true
  %brmerge4506 = or i1 %cmp114.1.not4504, %cmp115.1.not4505
  br i1 %brmerge4506, label %if.end.1.1, label %if.then116.1.1

if.then116.1.1:                                   ; preds = %if.end.12680
  %.idx.1.1 = shl nuw nsw i64 %shr120.1, 11
  %227 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1.1
  %.idx2533.1.1 = shl nuw nsw i64 %conv, 17
  %228 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 %.idx2533.1.1
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1024
  %229 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1032
  %230 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end.1.1

if.end.1.1:                                       ; preds = %if.end.12680, %if.then116.1.1
  %231 = phi <4 x half> [ %230, %if.then116.1.1 ], [ zeroinitializer, %if.end.12680 ]
  %232 = phi <4 x half> [ %229, %if.then116.1.1 ], [ zeroinitializer, %if.end.12680 ]
  %cmp162.1 = icmp sgt i32 %13, -1
  %cmp164.1 = icmp slt i32 %13, 64
  %233 = and i32 %cond.i.i2318.5, 268435455
  %shr170.1 = zext nneg i32 %233 to i64
  %cmp162.1.not = xor i1 %cmp162.1, true
  %cmp164.1.not = xor i1 %cmp164.1, true
  %brmerge4507 = or i1 %cmp162.1.not, %cmp164.1.not
  br i1 %brmerge4507, label %if.end204.12699, label %if.then165.12691

if.then165.12691:                                 ; preds = %if.end.1.1
  %.idx2534.12682 = shl nuw nsw i64 %shr170.1, 11
  %234 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534.12682
  %.idx2535.12683 = shl nuw nsw i64 %conv, 17
  %235 = getelementptr inbounds i8, ptr addrspace(4) %234, i64 %.idx2535.12683
  %236 = load <4 x half>, ptr addrspace(4) %235, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx.12687 = getelementptr inbounds i8, ptr addrspace(4) %235, i64 8
  %237 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx.12687, align 8, !tbaa !30
  br label %if.end204.12699

if.end204.12699:                                  ; preds = %if.end.1.1, %if.then165.12691
  %238 = phi <4 x half> [ %237, %if.then165.12691 ], [ zeroinitializer, %if.end.1.1 ]
  %239 = phi <4 x half> [ %236, %if.then165.12691 ], [ zeroinitializer, %if.end.1.1 ]
  %cmp162.1.not4508 = xor i1 %cmp162.1, true
  %cmp164.1.not4509 = xor i1 %cmp164.1, true
  %brmerge4510 = or i1 %cmp162.1.not4508, %cmp164.1.not4509
  br i1 %brmerge4510, label %if.end204.1.1, label %if.then165.1.1

if.then165.1.1:                                   ; preds = %if.end204.12699
  %.idx2534.1.1 = shl nuw nsw i64 %shr170.1, 11
  %240 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534.1.1
  %.idx2535.1.1 = shl nuw nsw i64 %conv, 17
  %241 = getelementptr inbounds i8, ptr addrspace(4) %240, i64 %.idx2535.1.1
  %gep2446.1.1 = getelementptr inbounds i8, ptr addrspace(4) %241, i64 1024
  %242 = load <4 x half>, ptr addrspace(4) %gep2446.1.1, align 16, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %241, i64 1032
  %243 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end204.1.1

if.end204.1.1:                                    ; preds = %if.end204.12699, %if.then165.1.1
  %244 = phi <4 x half> [ %243, %if.then165.1.1 ], [ zeroinitializer, %if.end204.12699 ]
  %245 = phi <4 x half> [ %242, %if.then165.1.1 ], [ zeroinitializer, %if.end204.12699 ]
  %cmp216.1 = icmp sgt i32 %15, -1
  %cmp218.1 = icmp slt i32 %15, 64
  %246 = and i32 %cond.i.i2318.6, 268435455
  %shr224.1 = zext nneg i32 %246 to i64
  %cmp216.1.not = xor i1 %cmp216.1, true
  %cmp218.1.not = xor i1 %cmp218.1, true
  %brmerge4511 = or i1 %cmp216.1.not, %cmp218.1.not
  br i1 %brmerge4511, label %if.end258.12718, label %if.then219.12710

if.then219.12710:                                 ; preds = %if.end204.1.1
  %.idx2536.12701 = shl nuw nsw i64 %shr224.1, 11
  %247 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536.12701
  %.idx2537.12702 = shl nuw nsw i64 %conv, 17
  %248 = getelementptr inbounds i8, ptr addrspace(4) %247, i64 %.idx2537.12702
  %249 = load <4 x half>, ptr addrspace(4) %248, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx.12706 = getelementptr inbounds i8, ptr addrspace(4) %248, i64 8
  %250 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx.12706, align 8, !tbaa !30
  br label %if.end258.12718

if.end258.12718:                                  ; preds = %if.end204.1.1, %if.then219.12710
  %251 = phi <4 x half> [ %250, %if.then219.12710 ], [ zeroinitializer, %if.end204.1.1 ]
  %252 = phi <4 x half> [ %249, %if.then219.12710 ], [ zeroinitializer, %if.end204.1.1 ]
  %cmp216.1.not4512 = xor i1 %cmp216.1, true
  %cmp218.1.not4513 = xor i1 %cmp218.1, true
  %brmerge4514 = or i1 %cmp216.1.not4512, %cmp218.1.not4513
  br i1 %brmerge4514, label %if.end258.1.1, label %if.then219.1.1

if.then219.1.1:                                   ; preds = %if.end258.12718
  %.idx2536.1.1 = shl nuw nsw i64 %shr224.1, 11
  %253 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536.1.1
  %.idx2537.1.1 = shl nuw nsw i64 %conv, 17
  %254 = getelementptr inbounds i8, ptr addrspace(4) %253, i64 %.idx2537.1.1
  %gep2449.1.1 = getelementptr inbounds i8, ptr addrspace(4) %254, i64 1024
  %255 = load <4 x half>, ptr addrspace(4) %gep2449.1.1, align 16, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %254, i64 1032
  %256 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end258.1.1

if.end258.1.1:                                    ; preds = %if.end258.12718, %if.then219.1.1
  %257 = phi <4 x half> [ %256, %if.then219.1.1 ], [ zeroinitializer, %if.end258.12718 ]
  %258 = phi <4 x half> [ %255, %if.then219.1.1 ], [ zeroinitializer, %if.end258.12718 ]
  %cmp270.1 = icmp sgt i32 %17, -1
  %cmp272.1 = icmp slt i32 %17, 64
  %259 = and i32 %cond.i.i2318.7, 268435455
  %shr278.1 = zext nneg i32 %259 to i64
  %cmp270.1.not = xor i1 %cmp270.1, true
  %cmp272.1.not = xor i1 %cmp272.1, true
  %brmerge4515 = or i1 %cmp270.1.not, %cmp272.1.not
  br i1 %brmerge4515, label %if.end312.12737, label %if.then273.12729

if.then273.12729:                                 ; preds = %if.end258.1.1
  %.idx2538.12720 = shl nuw nsw i64 %shr278.1, 11
  %260 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538.12720
  %.idx2539.12721 = shl nuw nsw i64 %conv, 17
  %261 = getelementptr inbounds i8, ptr addrspace(4) %260, i64 %.idx2539.12721
  %262 = load <4 x half>, ptr addrspace(4) %261, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx.12725 = getelementptr inbounds i8, ptr addrspace(4) %261, i64 8
  %263 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx.12725, align 8, !tbaa !30
  br label %if.end312.12737

if.end312.12737:                                  ; preds = %if.end258.1.1, %if.then273.12729
  %264 = phi <4 x half> [ %263, %if.then273.12729 ], [ zeroinitializer, %if.end258.1.1 ]
  %265 = phi <4 x half> [ %262, %if.then273.12729 ], [ zeroinitializer, %if.end258.1.1 ]
  %cmp270.1.not4516 = xor i1 %cmp270.1, true
  %cmp272.1.not4517 = xor i1 %cmp272.1, true
  %brmerge4518 = or i1 %cmp270.1.not4516, %cmp272.1.not4517
  br i1 %brmerge4518, label %if.end312.1.1, label %if.then273.1.1

if.then273.1.1:                                   ; preds = %if.end312.12737
  %.idx2538.1.1 = shl nuw nsw i64 %shr278.1, 11
  %266 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538.1.1
  %.idx2539.1.1 = shl nuw nsw i64 %conv, 17
  %267 = getelementptr inbounds i8, ptr addrspace(4) %266, i64 %.idx2539.1.1
  %gep2452.1.1 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1024
  %268 = load <4 x half>, ptr addrspace(4) %gep2452.1.1, align 16, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1032
  %269 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end312.1.1

if.end312.1.1:                                    ; preds = %if.end312.12737, %if.then273.1.1
  %270 = phi <4 x half> [ %269, %if.then273.1.1 ], [ zeroinitializer, %if.end312.12737 ]
  %271 = phi <4 x half> [ %268, %if.then273.1.1 ], [ zeroinitializer, %if.end312.12737 ]
  %cmp114.1.not4519 = xor i1 %cmp114.1, true
  %cmp115.1.not4520 = xor i1 %cmp115.1, true
  %brmerge4521 = or i1 %cmp114.1.not4519, %cmp115.1.not4520
  br i1 %brmerge4521, label %if.end366.12756, label %if.then327.12748

if.then327.12748:                                 ; preds = %if.end312.1.1
  %.idx2540.12739 = shl nuw nsw i64 %shr120.1, 11
  %272 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540.12739
  %.idx2541.12740 = shl nuw nsw i64 %conv, 17
  %273 = getelementptr inbounds i8, ptr addrspace(4) %272, i64 %.idx2541.12740
  %274 = load <4 x half>, ptr addrspace(4) %273, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx.12744 = getelementptr inbounds i8, ptr addrspace(4) %273, i64 8
  %275 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx.12744, align 8, !tbaa !30
  br label %if.end366.12756

if.end366.12756:                                  ; preds = %if.end312.1.1, %if.then327.12748
  %276 = phi <4 x half> [ %275, %if.then327.12748 ], [ zeroinitializer, %if.end312.1.1 ]
  %277 = phi <4 x half> [ %274, %if.then327.12748 ], [ zeroinitializer, %if.end312.1.1 ]
  %cmp114.1.not4522 = xor i1 %cmp114.1, true
  %cmp115.1.not4523 = xor i1 %cmp115.1, true
  %brmerge4524 = or i1 %cmp114.1.not4522, %cmp115.1.not4523
  br i1 %brmerge4524, label %if.end366.1.1, label %if.then327.1.1

if.then327.1.1:                                   ; preds = %if.end366.12756
  %.idx2540.1.1 = shl nuw nsw i64 %shr120.1, 11
  %278 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540.1.1
  %.idx2541.1.1 = shl nuw nsw i64 %conv, 17
  %279 = getelementptr inbounds i8, ptr addrspace(4) %278, i64 %.idx2541.1.1
  %gep2455.1.1 = getelementptr inbounds i8, ptr addrspace(4) %279, i64 1024
  %280 = load <4 x half>, ptr addrspace(4) %gep2455.1.1, align 16, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %279, i64 1032
  %281 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end366.1.1

if.end366.1.1:                                    ; preds = %if.end366.12756, %if.then327.1.1
  %282 = phi <4 x half> [ %281, %if.then327.1.1 ], [ zeroinitializer, %if.end366.12756 ]
  %283 = phi <4 x half> [ %280, %if.then327.1.1 ], [ zeroinitializer, %if.end366.12756 ]
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %226, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %225, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %284), !call_argsrelate !101
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %232, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %285), !call_argsrelate !101
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %231, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %286), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3131 = extractelement <4 x float> %287, i64 0
  %mul412.12760 = fmul contract float %acc_s.sroa.0.0.vec.extract3131, 0x3FB99999A0000000
  %288 = tail call contract noundef float @llvm.minnum.f32(float %mul412.12760, float 0x4024CB5EC0000000)
  %289 = tail call contract noundef float @llvm.exp.f32(float %288)
  %acc_s.sroa.0.4.vec.extract3310 = extractelement <4 x float> %287, i64 1
  %mul412.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3310, 0x3FB99999A0000000
  %290 = tail call contract noundef float @llvm.minnum.f32(float %mul412.1.1, float 0x4024CB5EC0000000)
  %291 = tail call contract noundef float @llvm.exp.f32(float %290)
  %acc_s.sroa.0.8.vec.extract3483 = extractelement <4 x float> %287, i64 2
  %mul412.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3483, 0x3FB99999A0000000
  %292 = tail call contract noundef float @llvm.minnum.f32(float %mul412.2.1, float 0x4024CB5EC0000000)
  %293 = tail call contract noundef float @llvm.exp.f32(float %292)
  %acc_s.sroa.0.12.vec.extract3656 = extractelement <4 x float> %287, i64 3
  %mul412.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3656, 0x3FB99999A0000000
  %294 = tail call contract noundef float @llvm.minnum.f32(float %mul412.3.1, float 0x4024CB5EC0000000)
  %295 = tail call contract noundef float @llvm.exp.f32(float %294)
  %add428.12761 = fadd contract float %add860, %289
  %add428.1.1 = fadd contract float %add860.1, %291
  %add428.2.1 = fadd contract float %add860.2, %293
  %add428.3.1 = fadd contract float %add860.3, %295
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %289)
  %297 = insertelement <4 x i16> poison, i16 %296, i64 0
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %291)
  %299 = insertelement <4 x i16> %297, i16 %298, i64 1
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %293)
  %301 = insertelement <4 x i16> %299, i16 %300, i64 2
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %295)
  %303 = insertelement <4 x i16> %301, i16 %302, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2972 = bitcast <4 x i16> %303 to <4 x half>
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %277, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %180)
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %276, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %181)
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %283, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %182)
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %282, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %183)
  %cmp162.1.not4525 = xor i1 %cmp162.1, true
  %cmp164.1.not4526 = xor i1 %cmp164.1, true
  %brmerge4527 = or i1 %cmp162.1.not4525, %cmp164.1.not4526
  br i1 %brmerge4527, label %if.end510.12780, label %if.then471.12772

if.then471.12772:                                 ; preds = %if.end366.1.1
  %.idx2542.12763 = shl nuw nsw i64 %shr170.1, 11
  %308 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542.12763
  %.idx2543.12764 = shl nuw nsw i64 %conv, 17
  %309 = getelementptr inbounds i8, ptr addrspace(4) %308, i64 %.idx2543.12764
  %310 = load <4 x half>, ptr addrspace(4) %309, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx.12768 = getelementptr inbounds i8, ptr addrspace(4) %309, i64 8
  %311 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx.12768, align 8, !tbaa !30
  br label %if.end510.12780

if.end510.12780:                                  ; preds = %if.end366.1.1, %if.then471.12772
  %312 = phi <4 x half> [ %311, %if.then471.12772 ], [ zeroinitializer, %if.end366.1.1 ]
  %313 = phi <4 x half> [ %310, %if.then471.12772 ], [ zeroinitializer, %if.end366.1.1 ]
  %cmp162.1.not4528 = xor i1 %cmp162.1, true
  %cmp164.1.not4529 = xor i1 %cmp164.1, true
  %brmerge4530 = or i1 %cmp162.1.not4528, %cmp164.1.not4529
  br i1 %brmerge4530, label %if.end510.1.1, label %if.then471.1.1

if.then471.1.1:                                   ; preds = %if.end510.12780
  %.idx2542.1.1 = shl nuw nsw i64 %shr170.1, 11
  %314 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542.1.1
  %.idx2543.1.1 = shl nuw nsw i64 %conv, 17
  %315 = getelementptr inbounds i8, ptr addrspace(4) %314, i64 %.idx2543.1.1
  %gep2468.1.1 = getelementptr inbounds i8, ptr addrspace(4) %315, i64 1024
  %316 = load <4 x half>, ptr addrspace(4) %gep2468.1.1, align 16, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %315, i64 1032
  %317 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end510.1.1

if.end510.1.1:                                    ; preds = %if.end510.12780, %if.then471.1.1
  %318 = phi <4 x half> [ %317, %if.then471.1.1 ], [ zeroinitializer, %if.end510.12780 ]
  %319 = phi <4 x half> [ %316, %if.then471.1.1 ], [ zeroinitializer, %if.end510.12780 ]
  %320 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %239, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %321 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %238, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %320), !call_argsrelate !101
  %322 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %245, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %321), !call_argsrelate !101
  %323 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %244, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %322), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3141 = extractelement <4 x float> %323, i64 0
  %mul556.12784 = fmul contract float %acc_s.sroa.0.0.vec.extract3141, 0x3FB99999A0000000
  %324 = tail call contract noundef float @llvm.minnum.f32(float %mul556.12784, float 0x4024CB5EC0000000)
  %325 = tail call contract noundef float @llvm.exp.f32(float %324)
  %acc_s.sroa.0.4.vec.extract3318 = extractelement <4 x float> %323, i64 1
  %mul556.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3318, 0x3FB99999A0000000
  %326 = tail call contract noundef float @llvm.minnum.f32(float %mul556.1.1, float 0x4024CB5EC0000000)
  %327 = tail call contract noundef float @llvm.exp.f32(float %326)
  %acc_s.sroa.0.8.vec.extract3491 = extractelement <4 x float> %323, i64 2
  %mul556.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3491, 0x3FB99999A0000000
  %328 = tail call contract noundef float @llvm.minnum.f32(float %mul556.2.1, float 0x4024CB5EC0000000)
  %329 = tail call contract noundef float @llvm.exp.f32(float %328)
  %acc_s.sroa.0.12.vec.extract3664 = extractelement <4 x float> %323, i64 3
  %mul556.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3664, 0x3FB99999A0000000
  %330 = tail call contract noundef float @llvm.minnum.f32(float %mul556.3.1, float 0x4024CB5EC0000000)
  %331 = tail call contract noundef float @llvm.exp.f32(float %330)
  %add572.12785 = fadd contract float %add428.12761, %325
  %add572.1.1 = fadd contract float %add428.1.1, %327
  %add572.2.1 = fadd contract float %add428.2.1, %329
  %add572.3.1 = fadd contract float %add428.3.1, %331
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %325)
  %333 = insertelement <4 x i16> poison, i16 %332, i64 0
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %327)
  %335 = insertelement <4 x i16> %333, i16 %334, i64 1
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %329)
  %337 = insertelement <4 x i16> %335, i16 %336, i64 2
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %331)
  %339 = insertelement <4 x i16> %337, i16 %338, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2974 = bitcast <4 x i16> %339 to <4 x half>
  %340 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %313, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %216)
  %341 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %312, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %217)
  %342 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %319, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %218)
  %343 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %318, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %219)
  %cmp216.1.not4531 = xor i1 %cmp216.1, true
  %cmp218.1.not4532 = xor i1 %cmp218.1, true
  %brmerge4533 = or i1 %cmp216.1.not4531, %cmp218.1.not4532
  br i1 %brmerge4533, label %if.end654.12804, label %if.then615.12796

if.then615.12796:                                 ; preds = %if.end510.1.1
  %.idx2544.12787 = shl nuw nsw i64 %shr224.1, 11
  %344 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544.12787
  %.idx2545.12788 = shl nuw nsw i64 %conv, 17
  %345 = getelementptr inbounds i8, ptr addrspace(4) %344, i64 %.idx2545.12788
  %346 = load <4 x half>, ptr addrspace(4) %345, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx.12792 = getelementptr inbounds i8, ptr addrspace(4) %345, i64 8
  %347 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx.12792, align 8, !tbaa !30
  br label %if.end654.12804

if.end654.12804:                                  ; preds = %if.end510.1.1, %if.then615.12796
  %348 = phi <4 x half> [ %347, %if.then615.12796 ], [ zeroinitializer, %if.end510.1.1 ]
  %349 = phi <4 x half> [ %346, %if.then615.12796 ], [ zeroinitializer, %if.end510.1.1 ]
  %cmp216.1.not4534 = xor i1 %cmp216.1, true
  %cmp218.1.not4535 = xor i1 %cmp218.1, true
  %brmerge4536 = or i1 %cmp216.1.not4534, %cmp218.1.not4535
  br i1 %brmerge4536, label %if.end654.1.1, label %if.then615.1.1

if.then615.1.1:                                   ; preds = %if.end654.12804
  %.idx2544.1.1 = shl nuw nsw i64 %shr224.1, 11
  %350 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544.1.1
  %.idx2545.1.1 = shl nuw nsw i64 %conv, 17
  %351 = getelementptr inbounds i8, ptr addrspace(4) %350, i64 %.idx2545.1.1
  %gep2481.1.1 = getelementptr inbounds i8, ptr addrspace(4) %351, i64 1024
  %352 = load <4 x half>, ptr addrspace(4) %gep2481.1.1, align 16, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %351, i64 1032
  %353 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end654.1.1

if.end654.1.1:                                    ; preds = %if.end654.12804, %if.then615.1.1
  %354 = phi <4 x half> [ %353, %if.then615.1.1 ], [ zeroinitializer, %if.end654.12804 ]
  %355 = phi <4 x half> [ %352, %if.then615.1.1 ], [ zeroinitializer, %if.end654.12804 ]
  %356 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %252, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %357 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %251, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %356), !call_argsrelate !101
  %358 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %258, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %357), !call_argsrelate !101
  %359 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %257, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %358), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3151 = extractelement <4 x float> %359, i64 0
  %mul700.12808 = fmul contract float %acc_s.sroa.0.0.vec.extract3151, 0x3FB99999A0000000
  %360 = tail call contract noundef float @llvm.minnum.f32(float %mul700.12808, float 0x4024CB5EC0000000)
  %361 = tail call contract noundef float @llvm.exp.f32(float %360)
  %acc_s.sroa.0.4.vec.extract3326 = extractelement <4 x float> %359, i64 1
  %mul700.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3326, 0x3FB99999A0000000
  %362 = tail call contract noundef float @llvm.minnum.f32(float %mul700.1.1, float 0x4024CB5EC0000000)
  %363 = tail call contract noundef float @llvm.exp.f32(float %362)
  %acc_s.sroa.0.8.vec.extract3499 = extractelement <4 x float> %359, i64 2
  %mul700.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3499, 0x3FB99999A0000000
  %364 = tail call contract noundef float @llvm.minnum.f32(float %mul700.2.1, float 0x4024CB5EC0000000)
  %365 = tail call contract noundef float @llvm.exp.f32(float %364)
  %acc_s.sroa.0.12.vec.extract3672 = extractelement <4 x float> %359, i64 3
  %mul700.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3672, 0x3FB99999A0000000
  %366 = tail call contract noundef float @llvm.minnum.f32(float %mul700.3.1, float 0x4024CB5EC0000000)
  %367 = tail call contract noundef float @llvm.exp.f32(float %366)
  %add716.12809 = fadd contract float %add572.12785, %361
  %add716.1.1 = fadd contract float %add572.1.1, %363
  %add716.2.1 = fadd contract float %add572.2.1, %365
  %add716.3.1 = fadd contract float %add572.3.1, %367
  %368 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %361)
  %369 = insertelement <4 x i16> poison, i16 %368, i64 0
  %370 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %363)
  %371 = insertelement <4 x i16> %369, i16 %370, i64 1
  %372 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %365)
  %373 = insertelement <4 x i16> %371, i16 %372, i64 2
  %374 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %367)
  %375 = insertelement <4 x i16> %373, i16 %374, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2976 = bitcast <4 x i16> %375 to <4 x half>
  %376 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %349, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %304)
  %377 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %348, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %305)
  %378 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %355, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %306)
  %379 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %354, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %307)
  %cmp270.1.not4537 = xor i1 %cmp270.1, true
  %cmp272.1.not4538 = xor i1 %cmp272.1, true
  %brmerge4539 = or i1 %cmp270.1.not4537, %cmp272.1.not4538
  br i1 %brmerge4539, label %if.end798.12828, label %if.then759.12820

if.then759.12820:                                 ; preds = %if.end654.1.1
  %.idx2546.12811 = shl nuw nsw i64 %shr278.1, 11
  %380 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546.12811
  %.idx2547.12812 = shl nuw nsw i64 %conv, 17
  %381 = getelementptr inbounds i8, ptr addrspace(4) %380, i64 %.idx2547.12812
  %382 = load <4 x half>, ptr addrspace(4) %381, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx.12816 = getelementptr inbounds i8, ptr addrspace(4) %381, i64 8
  %383 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx.12816, align 8, !tbaa !30
  br label %if.end798.12828

if.end798.12828:                                  ; preds = %if.end654.1.1, %if.then759.12820
  %384 = phi <4 x half> [ %383, %if.then759.12820 ], [ zeroinitializer, %if.end654.1.1 ]
  %385 = phi <4 x half> [ %382, %if.then759.12820 ], [ zeroinitializer, %if.end654.1.1 ]
  %cmp270.1.not4540 = xor i1 %cmp270.1, true
  %cmp272.1.not4541 = xor i1 %cmp272.1, true
  %brmerge4542 = or i1 %cmp270.1.not4540, %cmp272.1.not4541
  br i1 %brmerge4542, label %if.end798.1.1, label %if.then759.1.1

if.then759.1.1:                                   ; preds = %if.end798.12828
  %.idx2546.1.1 = shl nuw nsw i64 %shr278.1, 11
  %386 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546.1.1
  %.idx2547.1.1 = shl nuw nsw i64 %conv, 17
  %387 = getelementptr inbounds i8, ptr addrspace(4) %386, i64 %.idx2547.1.1
  %gep2494.1.1 = getelementptr inbounds i8, ptr addrspace(4) %387, i64 1024
  %388 = load <4 x half>, ptr addrspace(4) %gep2494.1.1, align 16, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %387, i64 1032
  %389 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx.1.1, align 8, !tbaa !30
  br label %if.end798.1.1

if.end798.1.1:                                    ; preds = %if.end798.12828, %if.then759.1.1
  %390 = phi <4 x half> [ %389, %if.then759.1.1 ], [ zeroinitializer, %if.end798.12828 ]
  %391 = phi <4 x half> [ %388, %if.then759.1.1 ], [ zeroinitializer, %if.end798.12828 ]
  %392 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %265, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !101
  %393 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %264, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %392), !call_argsrelate !101
  %394 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %271, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %393), !call_argsrelate !101
  %395 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %270, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %394), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3161 = extractelement <4 x float> %395, i64 0
  %mul844.12832 = fmul contract float %acc_s.sroa.0.0.vec.extract3161, 0x3FB99999A0000000
  %396 = tail call contract noundef float @llvm.minnum.f32(float %mul844.12832, float 0x4024CB5EC0000000)
  %397 = tail call contract noundef float @llvm.exp.f32(float %396)
  %acc_s.sroa.0.4.vec.extract3334 = extractelement <4 x float> %395, i64 1
  %mul844.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3334, 0x3FB99999A0000000
  %398 = tail call contract noundef float @llvm.minnum.f32(float %mul844.1.1, float 0x4024CB5EC0000000)
  %399 = tail call contract noundef float @llvm.exp.f32(float %398)
  %acc_s.sroa.0.8.vec.extract3507 = extractelement <4 x float> %395, i64 2
  %mul844.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3507, 0x3FB99999A0000000
  %400 = tail call contract noundef float @llvm.minnum.f32(float %mul844.2.1, float 0x4024CB5EC0000000)
  %401 = tail call contract noundef float @llvm.exp.f32(float %400)
  %acc_s.sroa.0.12.vec.extract3680 = extractelement <4 x float> %395, i64 3
  %mul844.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3680, 0x3FB99999A0000000
  %402 = tail call contract noundef float @llvm.minnum.f32(float %mul844.3.1, float 0x4024CB5EC0000000)
  %403 = tail call contract noundef float @llvm.exp.f32(float %402)
  %add860.12833 = fadd contract float %add716.12809, %397
  %add860.1.1 = fadd contract float %add716.1.1, %399
  %add860.2.1 = fadd contract float %add716.2.1, %401
  %add860.3.1 = fadd contract float %add716.3.1, %403
  %404 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %397)
  %405 = insertelement <4 x i16> poison, i16 %404, i64 0
  %406 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %399)
  %407 = insertelement <4 x i16> %405, i16 %406, i64 1
  %408 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %401)
  %409 = insertelement <4 x i16> %407, i16 %408, i64 2
  %410 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %403)
  %411 = insertelement <4 x i16> %409, i16 %410, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2978 = bitcast <4 x i16> %411 to <4 x half>
  %412 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %385, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %340)
  %413 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %384, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %341)
  %414 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %391, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %342)
  %415 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %390, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %343)
  %.pre = lshr i32 %18, 2
  br label %if.end1630

for.cond926.preheader:                            ; preds = %for.cond900.preheader
  %416 = shl nsw i32 %cond.i.i2318, 10
  %mul933 = and i32 %416, 64512
  %add936 = add nuw nsw i32 %add934, %mul933
  %417 = zext nneg i32 %add936 to i64
  %add.ptr941 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %417
  %K_reg.sroa.0.0.copyload4421 = load <4 x half>, ptr addrspace(4) %add.ptr941, align 16
  %K_reg.sroa.12.0.add.ptr941.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr941, i64 8
  %K_reg.sroa.12.0.copyload4423 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr941.sroa_idx, align 8
  %418 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %417
  %add.ptr941.1 = getelementptr inbounds i8, ptr addrspace(4) %418, i64 1024
  %K_reg.sroa.20.16.copyload4425 = load <4 x half>, ptr addrspace(4) %add.ptr941.1, align 16
  %K_reg.sroa.30.16.add.ptr941.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %418, i64 1032
  %K_reg.sroa.30.16.copyload4427 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr941.1.sroa_idx, align 8
  br label %if.end949

if.end949:                                        ; preds = %for.cond926.preheader, %for.cond900.preheader
  %419 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.30.16.copyload4427, %for.cond926.preheader ]
  %420 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.20.16.copyload4425, %for.cond926.preheader ]
  %421 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.12.0.copyload4423, %for.cond926.preheader ]
  %422 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.0.0.copyload4421, %for.cond926.preheader ]
  %or.cond2519 = icmp ugt i32 %mul11.1, 1023
  %cmp955.not = icmp sgt i32 %mul11.1, %1
  %or.cond2520 = or i1 %or.cond2519, %cmp955.not
  br i1 %or.cond2520, label %if.end980, label %for.cond957.preheader

for.cond957.preheader:                            ; preds = %if.end949
  %423 = shl nsw i32 %cond.i.i2318.1, 10
  %mul964 = and i32 %423, 64512
  %add967 = add nuw nsw i32 %add934, %mul964
  %424 = zext nneg i32 %add967 to i64
  %add.ptr972 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %424
  %K_reg1.sroa.0.0.copyload4433 = load <4 x half>, ptr addrspace(4) %add.ptr972, align 16
  %K_reg1.sroa.12.0.add.ptr972.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr972, i64 8
  %K_reg1.sroa.12.0.copyload4435 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr972.sroa_idx, align 8
  %425 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %424
  %add.ptr972.1 = getelementptr inbounds i8, ptr addrspace(4) %425, i64 1024
  %K_reg1.sroa.20.16.copyload4437 = load <4 x half>, ptr addrspace(4) %add.ptr972.1, align 16
  %K_reg1.sroa.30.16.add.ptr972.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %425, i64 1032
  %K_reg1.sroa.30.16.copyload4439 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr972.1.sroa_idx, align 8
  br label %if.end980

if.end980:                                        ; preds = %for.cond957.preheader, %if.end949
  %426 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.30.16.copyload4439, %for.cond957.preheader ]
  %427 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.20.16.copyload4437, %for.cond957.preheader ]
  %428 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.12.0.copyload4435, %for.cond957.preheader ]
  %429 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.0.0.copyload4433, %for.cond957.preheader ]
  %or.cond2521 = icmp ugt i32 %mul11.2, 1023
  %cmp986.not = icmp sgt i32 %mul11.2, %1
  %or.cond2522 = or i1 %or.cond2521, %cmp986.not
  br i1 %or.cond2522, label %if.end1011, label %for.cond988.preheader

for.cond988.preheader:                            ; preds = %if.end980
  %430 = shl nsw i32 %cond.i.i2318.2, 10
  %mul995 = and i32 %430, 64512
  %add998 = add nuw nsw i32 %add934, %mul995
  %431 = zext nneg i32 %add998 to i64
  %add.ptr1003 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %431
  %K_reg2.sroa.0.0.copyload4445 = load <4 x half>, ptr addrspace(4) %add.ptr1003, align 16
  %K_reg2.sroa.12.0.add.ptr1003.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1003, i64 8
  %K_reg2.sroa.12.0.copyload4447 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1003.sroa_idx, align 8
  %432 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %431
  %add.ptr1003.1 = getelementptr inbounds i8, ptr addrspace(4) %432, i64 1024
  %K_reg2.sroa.20.16.copyload4449 = load <4 x half>, ptr addrspace(4) %add.ptr1003.1, align 16
  %K_reg2.sroa.30.16.add.ptr1003.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %432, i64 1032
  %K_reg2.sroa.30.16.copyload4451 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1003.1.sroa_idx, align 8
  br label %if.end1011

if.end1011:                                       ; preds = %for.cond988.preheader, %if.end980
  %433 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.30.16.copyload4451, %for.cond988.preheader ]
  %434 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.20.16.copyload4449, %for.cond988.preheader ]
  %435 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.12.0.copyload4447, %for.cond988.preheader ]
  %436 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.0.0.copyload4445, %for.cond988.preheader ]
  %or.cond2523 = icmp ugt i32 %mul11.3, 1023
  %cmp1017.not = icmp sgt i32 %mul11.3, %1
  %or.cond2524 = or i1 %or.cond2523, %cmp1017.not
  br i1 %or.cond2524, label %if.end1042, label %for.cond1019.preheader

for.cond1019.preheader:                           ; preds = %if.end1011
  %437 = shl nsw i32 %cond.i.i2318.3, 10
  %mul1026 = and i32 %437, 64512
  %add1029 = add nuw nsw i32 %add934, %mul1026
  %438 = zext nneg i32 %add1029 to i64
  %add.ptr1034 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %438
  %K_reg3.sroa.0.0.copyload4457 = load <4 x half>, ptr addrspace(4) %add.ptr1034, align 16
  %K_reg3.sroa.12.0.add.ptr1034.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1034, i64 8
  %K_reg3.sroa.12.0.copyload4459 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1034.sroa_idx, align 8
  %439 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %438
  %add.ptr1034.1 = getelementptr inbounds i8, ptr addrspace(4) %439, i64 1024
  %K_reg3.sroa.20.16.copyload4461 = load <4 x half>, ptr addrspace(4) %add.ptr1034.1, align 16
  %K_reg3.sroa.30.16.add.ptr1034.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %439, i64 1032
  %K_reg3.sroa.30.16.copyload4463 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1034.1.sroa_idx, align 8
  br label %if.end1042

if.end1042:                                       ; preds = %for.cond1019.preheader, %if.end1011
  %440 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.30.16.copyload4463, %for.cond1019.preheader ]
  %441 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.20.16.copyload4461, %for.cond1019.preheader ]
  %442 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.12.0.copyload4459, %for.cond1019.preheader ]
  %443 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.0.0.copyload4457, %for.cond1019.preheader ]
  br i1 %or.cond2518, label %if.end1188, label %for.cond1050.preheader

for.cond1050.preheader:                           ; preds = %if.end1042
  %444 = shl nsw i32 %cond.i.i2318, 10
  %mul1057 = and i32 %444, 64512
  %add1060 = add nuw nsw i32 %add934, %mul1057
  %445 = zext nneg i32 %add1060 to i64
  %add.ptr1065 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %445
  %V_reg.sroa.0.0.copyload4400 = load <4 x half>, ptr addrspace(4) %add.ptr1065, align 16
  %V_reg.sroa.42.0.add.ptr1065.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1065, i64 8
  %V_reg.sroa.42.0.copyload4401 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1065.sroa_idx, align 8
  %446 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %445
  %add.ptr1065.1 = getelementptr inbounds i8, ptr addrspace(4) %446, i64 1024
  %V_reg.sroa.74.16.copyload4402 = load <4 x half>, ptr addrspace(4) %add.ptr1065.1, align 16
  %V_reg.sroa.114.16.add.ptr1065.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %446, i64 1032
  %V_reg.sroa.114.16.copyload4403 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1065.1.sroa_idx, align 8
  %cmp1075 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp1075, label %for.cond1077.preheader, label %if.end1101

for.cond1077.preheader:                           ; preds = %for.cond1050.preheader
  %add1084 = add nuw nsw i32 %mul11, %mul1083
  %cmp1087.not = icmp sgt i32 %add1084, %1
  %fneg. = select i1 %cmp1087.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3010 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp1087.not.1.not = icmp slt i32 %add1084, %1
  %fneg..1 = select i1 %cmp1087.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3199 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3010, float %fneg..1, i64 1
  %add1085.2 = or disjoint i32 %add1084, 2
  %cmp1087.not.2 = icmp sgt i32 %add1085.2, %1
  %fneg..2 = select i1 %cmp1087.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3372 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3199, float %fneg..2, i64 2
  %add1085.3 = or disjoint i32 %add1084, 3
  %cmp1087.not.3 = icmp sgt i32 %add1085.3, %1
  %fneg..3 = select i1 %cmp1087.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3545 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3372, float %fneg..3, i64 3
  br label %if.end1101

if.end1101:                                       ; preds = %for.cond1050.preheader, %for.cond1077.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3545, %for.cond1077.preheader ], [ zeroinitializer, %for.cond1050.preheader ]
  %447 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %422, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !101
  %448 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %421, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %447), !call_argsrelate !101
  %449 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %420, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %448), !call_argsrelate !101
  %450 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %419, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %449), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %450, i64 0
  %mul1136 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %451 = tail call contract noundef float @llvm.minnum.f32(float %mul1136, float 0x4024CB5EC0000000)
  %452 = tail call contract noundef float @llvm.exp.f32(float %451)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %450, i64 1
  %mul1136.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %453 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.1, float 0x4024CB5EC0000000)
  %454 = tail call contract noundef float @llvm.exp.f32(float %453)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %450, i64 2
  %mul1136.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %455 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.2, float 0x4024CB5EC0000000)
  %456 = tail call contract noundef float @llvm.exp.f32(float %455)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %450, i64 3
  %mul1136.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %457 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.3, float 0x4024CB5EC0000000)
  %458 = tail call contract noundef float @llvm.exp.f32(float %457)
  %459 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %452)
  %460 = insertelement <4 x i16> poison, i16 %459, i64 0
  %461 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %454)
  %462 = insertelement <4 x i16> %460, i16 %461, i64 1
  %463 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %456)
  %464 = insertelement <4 x i16> %462, i16 %463, i64 2
  %465 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %458)
  %466 = insertelement <4 x i16> %464, i16 %465, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %466 to <4 x half>
  %467 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload4400, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !214
  %468 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload4401, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !214
  %469 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload4402, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !214
  %470 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload4403, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !214
  br label %if.end1188

if.end1188:                                       ; preds = %if.end1101, %if.end1042
  %acc_o.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %470, %if.end1101 ]
  %acc_o.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %469, %if.end1101 ]
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %468, %if.end1101 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %467, %if.end1101 ]
  %sum_acc.sroa.104.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %458, %if.end1101 ]
  %sum_acc.sroa.70.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %456, %if.end1101 ]
  %sum_acc.sroa.36.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %454, %if.end1101 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %452, %if.end1101 ]
  br i1 %or.cond2520, label %if.end1334, label %for.cond1196.preheader

for.cond1196.preheader:                           ; preds = %if.end1188
  %471 = shl nsw i32 %cond.i.i2318.1, 10
  %mul1203 = and i32 %471, 64512
  %add1206 = add nuw nsw i32 %add934, %mul1203
  %472 = zext nneg i32 %add1206 to i64
  %add.ptr1211 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %472
  %V_reg.sroa.0.0.copyload37174404 = load <4 x half>, ptr addrspace(4) %add.ptr1211, align 16
  %V_reg.sroa.42.0.add.ptr1211.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1211, i64 8
  %V_reg.sroa.42.0.copyload37384405 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1211.sroa_idx, align 8
  %473 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %472
  %add.ptr1211.1 = getelementptr inbounds i8, ptr addrspace(4) %473, i64 1024
  %V_reg.sroa.74.16.copyload38194406 = load <4 x half>, ptr addrspace(4) %add.ptr1211.1, align 16
  %V_reg.sroa.114.16.add.ptr1211.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %473, i64 1032
  %V_reg.sroa.114.16.copyload38404407 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1211.1.sroa_idx, align 8
  %cmp1221 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp1221, label %for.cond1223.preheader, label %if.end1247

for.cond1223.preheader:                           ; preds = %for.cond1196.preheader
  %add1230 = add nuw nsw i32 %mul11.1, %mul1083
  %cmp1233.not = icmp sgt i32 %add1230, %1
  %fneg.2183 = select i1 %cmp1233.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3019 = insertelement <4 x float> poison, float %fneg.2183, i64 0
  %cmp1233.not.1.not = icmp slt i32 %add1230, %1
  %fneg.2183.1 = select i1 %cmp1233.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3208 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3019, float %fneg.2183.1, i64 1
  %add1231.2 = or disjoint i32 %add1230, 2
  %cmp1233.not.2 = icmp sgt i32 %add1231.2, %1
  %fneg.2183.2 = select i1 %cmp1233.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3381 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3208, float %fneg.2183.2, i64 2
  %add1231.3 = or disjoint i32 %add1230, 3
  %cmp1233.not.3 = icmp sgt i32 %add1231.3, %1
  %fneg.2183.3 = select i1 %cmp1233.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3554 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3381, float %fneg.2183.3, i64 3
  br label %if.end1247

if.end1247:                                       ; preds = %for.cond1196.preheader, %for.cond1223.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3554, %for.cond1223.preheader ], [ zeroinitializer, %for.cond1196.preheader ]
  %474 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %429, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !101
  %475 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %428, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %474), !call_argsrelate !101
  %476 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %427, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %475), !call_argsrelate !101
  %477 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %426, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %476), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3021 = extractelement <4 x float> %477, i64 0
  %mul1282 = fmul contract float %acc_s.sroa.0.0.vec.extract3021, 0x3FB99999A0000000
  %478 = tail call contract noundef float @llvm.minnum.f32(float %mul1282, float 0x4024CB5EC0000000)
  %479 = tail call contract noundef float @llvm.exp.f32(float %478)
  %acc_s.sroa.0.4.vec.extract3210 = extractelement <4 x float> %477, i64 1
  %mul1282.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3210, 0x3FB99999A0000000
  %480 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.1, float 0x4024CB5EC0000000)
  %481 = tail call contract noundef float @llvm.exp.f32(float %480)
  %acc_s.sroa.0.8.vec.extract3383 = extractelement <4 x float> %477, i64 2
  %mul1282.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3383, 0x3FB99999A0000000
  %482 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.2, float 0x4024CB5EC0000000)
  %483 = tail call contract noundef float @llvm.exp.f32(float %482)
  %acc_s.sroa.0.12.vec.extract3556 = extractelement <4 x float> %477, i64 3
  %mul1282.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3556, 0x3FB99999A0000000
  %484 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.3, float 0x4024CB5EC0000000)
  %485 = tail call contract noundef float @llvm.exp.f32(float %484)
  %add1298 = fadd contract float %sum_acc.sroa.0.0, %479
  %add1298.1 = fadd contract float %sum_acc.sroa.36.0, %481
  %add1298.2 = fadd contract float %sum_acc.sroa.70.0, %483
  %add1298.3 = fadd contract float %sum_acc.sroa.104.0, %485
  %486 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %479)
  %487 = insertelement <4 x i16> poison, i16 %486, i64 0
  %488 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %481)
  %489 = insertelement <4 x i16> %487, i16 %488, i64 1
  %490 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %483)
  %491 = insertelement <4 x i16> %489, i16 %490, i64 2
  %492 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %485)
  %493 = insertelement <4 x i16> %491, i16 %492, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2950 = bitcast <4 x i16> %493 to <4 x half>
  %494 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37174404, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !call_argsrelate !214
  %495 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37384405, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !call_argsrelate !214
  %496 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38194406, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !call_argsrelate !214
  %497 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38404407, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !call_argsrelate !214
  br label %if.end1334

if.end1334:                                       ; preds = %if.end1247, %if.end1188
  %acc_o_alt.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %497, %if.end1247 ]
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %496, %if.end1247 ]
  %acc_o_alt.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %495, %if.end1247 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %494, %if.end1247 ]
  %sum_acc.sroa.104.1 = phi float [ %sum_acc.sroa.104.0, %if.end1188 ], [ %add1298.3, %if.end1247 ]
  %sum_acc.sroa.70.1 = phi float [ %sum_acc.sroa.70.0, %if.end1188 ], [ %add1298.2, %if.end1247 ]
  %sum_acc.sroa.36.1 = phi float [ %sum_acc.sroa.36.0, %if.end1188 ], [ %add1298.1, %if.end1247 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end1188 ], [ %add1298, %if.end1247 ]
  br i1 %or.cond2522, label %if.end1480, label %for.cond1342.preheader

for.cond1342.preheader:                           ; preds = %if.end1334
  %498 = shl nsw i32 %cond.i.i2318.2, 10
  %mul1349 = and i32 %498, 64512
  %add1352 = add nuw nsw i32 %add934, %mul1349
  %499 = zext nneg i32 %add1352 to i64
  %add.ptr1357 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %499
  %V_reg.sroa.0.0.copyload37184408 = load <4 x half>, ptr addrspace(4) %add.ptr1357, align 16
  %V_reg.sroa.42.0.add.ptr1357.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1357, i64 8
  %V_reg.sroa.42.0.copyload37394409 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1357.sroa_idx, align 8
  %500 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %499
  %add.ptr1357.1 = getelementptr inbounds i8, ptr addrspace(4) %500, i64 1024
  %V_reg.sroa.74.16.copyload38204410 = load <4 x half>, ptr addrspace(4) %add.ptr1357.1, align 16
  %V_reg.sroa.114.16.add.ptr1357.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %500, i64 1032
  %V_reg.sroa.114.16.copyload38414411 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1357.1.sroa_idx, align 8
  %cmp1367 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp1367, label %for.cond1369.preheader, label %if.end1393

for.cond1369.preheader:                           ; preds = %for.cond1342.preheader
  %add1376 = add nuw nsw i32 %mul11.2, %mul1083
  %cmp1379.not = icmp sgt i32 %add1376, %1
  %fneg.2184 = select i1 %cmp1379.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3029 = insertelement <4 x float> poison, float %fneg.2184, i64 0
  %cmp1379.not.1.not = icmp slt i32 %add1376, %1
  %fneg.2184.1 = select i1 %cmp1379.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3218 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3029, float %fneg.2184.1, i64 1
  %add1377.2 = or disjoint i32 %add1376, 2
  %cmp1379.not.2 = icmp sgt i32 %add1377.2, %1
  %fneg.2184.2 = select i1 %cmp1379.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3391 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3218, float %fneg.2184.2, i64 2
  %add1377.3 = or disjoint i32 %add1376, 3
  %cmp1379.not.3 = icmp sgt i32 %add1377.3, %1
  %fneg.2184.3 = select i1 %cmp1379.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3564 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3391, float %fneg.2184.3, i64 3
  br label %if.end1393

if.end1393:                                       ; preds = %for.cond1342.preheader, %for.cond1369.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3564, %for.cond1369.preheader ], [ zeroinitializer, %for.cond1342.preheader ]
  %501 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %436, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !101
  %502 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %435, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %501), !call_argsrelate !101
  %503 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %434, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %502), !call_argsrelate !101
  %504 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %433, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %503), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3031 = extractelement <4 x float> %504, i64 0
  %mul1428 = fmul contract float %acc_s.sroa.0.0.vec.extract3031, 0x3FB99999A0000000
  %505 = tail call contract noundef float @llvm.minnum.f32(float %mul1428, float 0x4024CB5EC0000000)
  %506 = tail call contract noundef float @llvm.exp.f32(float %505)
  %acc_s.sroa.0.4.vec.extract3220 = extractelement <4 x float> %504, i64 1
  %mul1428.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3220, 0x3FB99999A0000000
  %507 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.1, float 0x4024CB5EC0000000)
  %508 = tail call contract noundef float @llvm.exp.f32(float %507)
  %acc_s.sroa.0.8.vec.extract3393 = extractelement <4 x float> %504, i64 2
  %mul1428.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3393, 0x3FB99999A0000000
  %509 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.2, float 0x4024CB5EC0000000)
  %510 = tail call contract noundef float @llvm.exp.f32(float %509)
  %acc_s.sroa.0.12.vec.extract3566 = extractelement <4 x float> %504, i64 3
  %mul1428.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3566, 0x3FB99999A0000000
  %511 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.3, float 0x4024CB5EC0000000)
  %512 = tail call contract noundef float @llvm.exp.f32(float %511)
  %add1444 = fadd contract float %sum_acc.sroa.0.1, %506
  %add1444.1 = fadd contract float %sum_acc.sroa.36.1, %508
  %add1444.2 = fadd contract float %sum_acc.sroa.70.1, %510
  %add1444.3 = fadd contract float %sum_acc.sroa.104.1, %512
  %513 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %506)
  %514 = insertelement <4 x i16> poison, i16 %513, i64 0
  %515 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %508)
  %516 = insertelement <4 x i16> %514, i16 %515, i64 1
  %517 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %510)
  %518 = insertelement <4 x i16> %516, i16 %517, i64 2
  %519 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %512)
  %520 = insertelement <4 x i16> %518, i16 %519, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2952 = bitcast <4 x i16> %520 to <4 x half>
  %521 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37184408, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !214
  %522 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37394409, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.42.0), !call_argsrelate !214
  %523 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38204410, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.82.0), !call_argsrelate !214
  %524 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38414411, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.122.0), !call_argsrelate !214
  br label %if.end1480

if.end1480:                                       ; preds = %if.end1393, %if.end1334
  %acc_o.sroa.122.1 = phi <4 x float> [ %acc_o.sroa.122.0, %if.end1334 ], [ %524, %if.end1393 ]
  %acc_o.sroa.82.1 = phi <4 x float> [ %acc_o.sroa.82.0, %if.end1334 ], [ %523, %if.end1393 ]
  %acc_o.sroa.42.1 = phi <4 x float> [ %acc_o.sroa.42.0, %if.end1334 ], [ %522, %if.end1393 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1334 ], [ %521, %if.end1393 ]
  %sum_acc.sroa.104.2 = phi float [ %sum_acc.sroa.104.1, %if.end1334 ], [ %add1444.3, %if.end1393 ]
  %sum_acc.sroa.70.2 = phi float [ %sum_acc.sroa.70.1, %if.end1334 ], [ %add1444.2, %if.end1393 ]
  %sum_acc.sroa.36.2 = phi float [ %sum_acc.sroa.36.1, %if.end1334 ], [ %add1444.1, %if.end1393 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end1334 ], [ %add1444, %if.end1393 ]
  br i1 %or.cond2524, label %if.end1626, label %for.cond1488.preheader

for.cond1488.preheader:                           ; preds = %if.end1480
  %525 = shl nsw i32 %cond.i.i2318.3, 10
  %mul1495 = and i32 %525, 64512
  %add1498 = add nuw nsw i32 %add934, %mul1495
  %526 = zext nneg i32 %add1498 to i64
  %add.ptr1503 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %526
  %V_reg.sroa.0.0.copyload37194412 = load <4 x half>, ptr addrspace(4) %add.ptr1503, align 16
  %V_reg.sroa.42.0.add.ptr1503.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1503, i64 8
  %V_reg.sroa.42.0.copyload37404413 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1503.sroa_idx, align 8
  %527 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %526
  %add.ptr1503.1 = getelementptr inbounds i8, ptr addrspace(4) %527, i64 1024
  %V_reg.sroa.74.16.copyload38214414 = load <4 x half>, ptr addrspace(4) %add.ptr1503.1, align 16
  %V_reg.sroa.114.16.add.ptr1503.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %527, i64 1032
  %V_reg.sroa.114.16.copyload38424415 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1503.1.sroa_idx, align 8
  %cmp1513 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp1513, label %for.cond1515.preheader, label %if.end1539

for.cond1515.preheader:                           ; preds = %for.cond1488.preheader
  %add1522 = add nuw nsw i32 %mul11.3, %mul1083
  %cmp1525.not = icmp sgt i32 %add1522, %1
  %fneg.2185 = select i1 %cmp1525.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3039 = insertelement <4 x float> poison, float %fneg.2185, i64 0
  %cmp1525.not.1.not = icmp slt i32 %add1522, %1
  %fneg.2185.1 = select i1 %cmp1525.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3228 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3039, float %fneg.2185.1, i64 1
  %add1523.2 = or disjoint i32 %add1522, 2
  %cmp1525.not.2 = icmp sgt i32 %add1523.2, %1
  %fneg.2185.2 = select i1 %cmp1525.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3401 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3228, float %fneg.2185.2, i64 2
  %add1523.3 = or disjoint i32 %add1522, 3
  %cmp1525.not.3 = icmp sgt i32 %add1523.3, %1
  %fneg.2185.3 = select i1 %cmp1525.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3574 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3401, float %fneg.2185.3, i64 3
  br label %if.end1539

if.end1539:                                       ; preds = %for.cond1488.preheader, %for.cond1515.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3574, %for.cond1515.preheader ], [ zeroinitializer, %for.cond1488.preheader ]
  %528 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %443, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !101
  %529 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %442, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %528), !call_argsrelate !101
  %530 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %441, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %529), !call_argsrelate !101
  %531 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %440, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %530), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3041 = extractelement <4 x float> %531, i64 0
  %mul1574 = fmul contract float %acc_s.sroa.0.0.vec.extract3041, 0x3FB99999A0000000
  %532 = tail call contract noundef float @llvm.minnum.f32(float %mul1574, float 0x4024CB5EC0000000)
  %533 = tail call contract noundef float @llvm.exp.f32(float %532)
  %acc_s.sroa.0.4.vec.extract3230 = extractelement <4 x float> %531, i64 1
  %mul1574.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3230, 0x3FB99999A0000000
  %534 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.1, float 0x4024CB5EC0000000)
  %535 = tail call contract noundef float @llvm.exp.f32(float %534)
  %acc_s.sroa.0.8.vec.extract3403 = extractelement <4 x float> %531, i64 2
  %mul1574.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3403, 0x3FB99999A0000000
  %536 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.2, float 0x4024CB5EC0000000)
  %537 = tail call contract noundef float @llvm.exp.f32(float %536)
  %acc_s.sroa.0.12.vec.extract3576 = extractelement <4 x float> %531, i64 3
  %mul1574.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3576, 0x3FB99999A0000000
  %538 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.3, float 0x4024CB5EC0000000)
  %539 = tail call contract noundef float @llvm.exp.f32(float %538)
  %add1590 = fadd contract float %sum_acc.sroa.0.2, %533
  %add1590.1 = fadd contract float %sum_acc.sroa.36.2, %535
  %add1590.2 = fadd contract float %sum_acc.sroa.70.2, %537
  %add1590.3 = fadd contract float %sum_acc.sroa.104.2, %539
  %540 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %533)
  %541 = insertelement <4 x i16> poison, i16 %540, i64 0
  %542 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %535)
  %543 = insertelement <4 x i16> %541, i16 %542, i64 1
  %544 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %537)
  %545 = insertelement <4 x i16> %543, i16 %544, i64 2
  %546 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %539)
  %547 = insertelement <4 x i16> %545, i16 %546, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2954 = bitcast <4 x i16> %547 to <4 x half>
  %548 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37194412, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !214
  %549 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37404413, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.26.0), !call_argsrelate !214
  %550 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38214414, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !214
  %551 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38424415, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.74.0), !call_argsrelate !214
  br label %if.end1626

if.end1626:                                       ; preds = %if.end1539, %if.end1480
  %acc_o_alt.sroa.74.1 = phi <4 x float> [ %acc_o_alt.sroa.74.0, %if.end1480 ], [ %551, %if.end1539 ]
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1480 ], [ %550, %if.end1539 ]
  %acc_o_alt.sroa.26.1 = phi <4 x float> [ %acc_o_alt.sroa.26.0, %if.end1480 ], [ %549, %if.end1539 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1480 ], [ %548, %if.end1539 ]
  %sum_acc.sroa.104.3 = phi float [ %sum_acc.sroa.104.2, %if.end1480 ], [ %add1590.3, %if.end1539 ]
  %sum_acc.sroa.70.3 = phi float [ %sum_acc.sroa.70.2, %if.end1480 ], [ %add1590.2, %if.end1539 ]
  %sum_acc.sroa.36.3 = phi float [ %sum_acc.sroa.36.2, %if.end1480 ], [ %add1590.1, %if.end1539 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end1480 ], [ %add1590, %if.end1539 ]
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023
  %cmp924.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond2518.1 = or i1 %or.cond.1, %cmp924.not.1
  br i1 %or.cond2518.1, label %if.end949.1, label %for.cond926.preheader.1

for.cond926.preheader.1:                          ; preds = %if.end1626
  %552 = shl nsw i32 %cond.i.i2318.4, 10
  %mul933.1 = and i32 %552, 64512
  %add936.1 = add nuw nsw i32 %add934, %mul933.1
  %553 = zext nneg i32 %add936.1 to i64
  %add.ptr941.12602 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %553
  %K_reg.sroa.0.0.copyload40054420 = load <4 x half>, ptr addrspace(4) %add.ptr941.12602, align 16
  %K_reg.sroa.12.0.add.ptr941.12602.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr941.12602, i64 8
  %K_reg.sroa.12.0.copyload40084422 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr941.12602.sroa_idx, align 8
  %554 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %553
  %add.ptr941.1.1 = getelementptr inbounds i8, ptr addrspace(4) %554, i64 1024
  %K_reg.sroa.20.16.copyload40234424 = load <4 x half>, ptr addrspace(4) %add.ptr941.1.1, align 16
  %K_reg.sroa.30.16.add.ptr941.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %554, i64 1032
  %K_reg.sroa.30.16.copyload40264426 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr941.1.1.sroa_idx, align 8
  br label %if.end949.1

if.end949.1:                                      ; preds = %for.cond926.preheader.1, %if.end1626
  %555 = phi <4 x half> [ %419, %if.end1626 ], [ %K_reg.sroa.30.16.copyload40264426, %for.cond926.preheader.1 ]
  %556 = phi <4 x half> [ %420, %if.end1626 ], [ %K_reg.sroa.20.16.copyload40234424, %for.cond926.preheader.1 ]
  %557 = phi <4 x half> [ %421, %if.end1626 ], [ %K_reg.sroa.12.0.copyload40084422, %for.cond926.preheader.1 ]
  %558 = phi <4 x half> [ %422, %if.end1626 ], [ %K_reg.sroa.0.0.copyload40054420, %for.cond926.preheader.1 ]
  %or.cond2519.1 = icmp ugt i32 %mul11.5, 1023
  %cmp955.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond2520.1 = or i1 %or.cond2519.1, %cmp955.not.1
  br i1 %or.cond2520.1, label %if.end980.1, label %for.cond957.preheader.1

for.cond957.preheader.1:                          ; preds = %if.end949.1
  %559 = shl nsw i32 %cond.i.i2318.5, 10
  %mul964.1 = and i32 %559, 64512
  %add967.1 = add nuw nsw i32 %add934, %mul964.1
  %560 = zext nneg i32 %add967.1 to i64
  %add.ptr972.12603 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %560
  %K_reg1.sroa.0.0.copyload39694432 = load <4 x half>, ptr addrspace(4) %add.ptr972.12603, align 16
  %K_reg1.sroa.12.0.add.ptr972.12603.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr972.12603, i64 8
  %K_reg1.sroa.12.0.copyload39724434 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr972.12603.sroa_idx, align 8
  %561 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %560
  %add.ptr972.1.1 = getelementptr inbounds i8, ptr addrspace(4) %561, i64 1024
  %K_reg1.sroa.20.16.copyload39874436 = load <4 x half>, ptr addrspace(4) %add.ptr972.1.1, align 16
  %K_reg1.sroa.30.16.add.ptr972.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %561, i64 1032
  %K_reg1.sroa.30.16.copyload39904438 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr972.1.1.sroa_idx, align 8
  br label %if.end980.1

if.end980.1:                                      ; preds = %for.cond957.preheader.1, %if.end949.1
  %562 = phi <4 x half> [ %426, %if.end949.1 ], [ %K_reg1.sroa.30.16.copyload39904438, %for.cond957.preheader.1 ]
  %563 = phi <4 x half> [ %427, %if.end949.1 ], [ %K_reg1.sroa.20.16.copyload39874436, %for.cond957.preheader.1 ]
  %564 = phi <4 x half> [ %428, %if.end949.1 ], [ %K_reg1.sroa.12.0.copyload39724434, %for.cond957.preheader.1 ]
  %565 = phi <4 x half> [ %429, %if.end949.1 ], [ %K_reg1.sroa.0.0.copyload39694432, %for.cond957.preheader.1 ]
  %or.cond2521.1 = icmp ugt i32 %mul11.6, 1023
  %cmp986.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond2522.1 = or i1 %or.cond2521.1, %cmp986.not.1
  br i1 %or.cond2522.1, label %if.end1011.1, label %for.cond988.preheader.1

for.cond988.preheader.1:                          ; preds = %if.end980.1
  %566 = shl nsw i32 %cond.i.i2318.6, 10
  %mul995.1 = and i32 %566, 64512
  %add998.1 = add nuw nsw i32 %add934, %mul995.1
  %567 = zext nneg i32 %add998.1 to i64
  %add.ptr1003.12604 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %567
  %K_reg2.sroa.0.0.copyload39334444 = load <4 x half>, ptr addrspace(4) %add.ptr1003.12604, align 16
  %K_reg2.sroa.12.0.add.ptr1003.12604.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1003.12604, i64 8
  %K_reg2.sroa.12.0.copyload39364446 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1003.12604.sroa_idx, align 8
  %568 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %567
  %add.ptr1003.1.1 = getelementptr inbounds i8, ptr addrspace(4) %568, i64 1024
  %K_reg2.sroa.20.16.copyload39514448 = load <4 x half>, ptr addrspace(4) %add.ptr1003.1.1, align 16
  %K_reg2.sroa.30.16.add.ptr1003.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %568, i64 1032
  %K_reg2.sroa.30.16.copyload39544450 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1003.1.1.sroa_idx, align 8
  br label %if.end1011.1

if.end1011.1:                                     ; preds = %for.cond988.preheader.1, %if.end980.1
  %569 = phi <4 x half> [ %433, %if.end980.1 ], [ %K_reg2.sroa.30.16.copyload39544450, %for.cond988.preheader.1 ]
  %570 = phi <4 x half> [ %434, %if.end980.1 ], [ %K_reg2.sroa.20.16.copyload39514448, %for.cond988.preheader.1 ]
  %571 = phi <4 x half> [ %435, %if.end980.1 ], [ %K_reg2.sroa.12.0.copyload39364446, %for.cond988.preheader.1 ]
  %572 = phi <4 x half> [ %436, %if.end980.1 ], [ %K_reg2.sroa.0.0.copyload39334444, %for.cond988.preheader.1 ]
  %or.cond2523.1 = icmp ugt i32 %mul11.7, 1023
  %cmp1017.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond2524.1 = or i1 %or.cond2523.1, %cmp1017.not.1
  br i1 %or.cond2524.1, label %if.end1042.1, label %for.cond1019.preheader.1

for.cond1019.preheader.1:                         ; preds = %if.end1011.1
  %573 = shl nsw i32 %cond.i.i2318.7, 10
  %mul1026.1 = and i32 %573, 64512
  %add1029.1 = add nuw nsw i32 %add934, %mul1026.1
  %574 = zext nneg i32 %add1029.1 to i64
  %add.ptr1034.12605 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %574
  %K_reg3.sroa.0.0.copyload38974456 = load <4 x half>, ptr addrspace(4) %add.ptr1034.12605, align 16
  %K_reg3.sroa.12.0.add.ptr1034.12605.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1034.12605, i64 8
  %K_reg3.sroa.12.0.copyload39004458 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1034.12605.sroa_idx, align 8
  %575 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %574
  %add.ptr1034.1.1 = getelementptr inbounds i8, ptr addrspace(4) %575, i64 1024
  %K_reg3.sroa.20.16.copyload39154460 = load <4 x half>, ptr addrspace(4) %add.ptr1034.1.1, align 16
  %K_reg3.sroa.30.16.add.ptr1034.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %575, i64 1032
  %K_reg3.sroa.30.16.copyload39184462 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1034.1.1.sroa_idx, align 8
  br label %if.end1042.1

if.end1042.1:                                     ; preds = %for.cond1019.preheader.1, %if.end1011.1
  %576 = phi <4 x half> [ %440, %if.end1011.1 ], [ %K_reg3.sroa.30.16.copyload39184462, %for.cond1019.preheader.1 ]
  %577 = phi <4 x half> [ %441, %if.end1011.1 ], [ %K_reg3.sroa.20.16.copyload39154460, %for.cond1019.preheader.1 ]
  %578 = phi <4 x half> [ %442, %if.end1011.1 ], [ %K_reg3.sroa.12.0.copyload39004458, %for.cond1019.preheader.1 ]
  %579 = phi <4 x half> [ %443, %if.end1011.1 ], [ %K_reg3.sroa.0.0.copyload38974456, %for.cond1019.preheader.1 ]
  br i1 %or.cond2518.1, label %if.end1188.1, label %for.cond1050.preheader.1

for.cond1050.preheader.1:                         ; preds = %if.end1042.1
  %580 = shl nsw i32 %cond.i.i2318.4, 10
  %mul1057.1 = and i32 %580, 64512
  %add1060.1 = add nuw nsw i32 %add934, %mul1057.1
  %581 = zext nneg i32 %add1060.1 to i64
  %add.ptr1065.12606 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %581
  %V_reg.sroa.0.0.copyload37204416 = load <4 x half>, ptr addrspace(4) %add.ptr1065.12606, align 16
  %V_reg.sroa.42.0.add.ptr1065.12606.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1065.12606, i64 8
  %V_reg.sroa.42.0.copyload37414417 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1065.12606.sroa_idx, align 8
  %582 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %581
  %add.ptr1065.1.1 = getelementptr inbounds i8, ptr addrspace(4) %582, i64 1024
  %V_reg.sroa.74.16.copyload38224418 = load <4 x half>, ptr addrspace(4) %add.ptr1065.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1065.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %582, i64 1032
  %V_reg.sroa.114.16.copyload38434419 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1065.1.1.sroa_idx, align 8
  %cmp1075.1 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp1075.1, label %for.cond1077.preheader.1, label %if.end1101.1

for.cond1077.preheader.1:                         ; preds = %for.cond1050.preheader.1
  %add1084.1 = add nuw nsw i32 %mul11.4, %mul1083
  %cmp1087.not.12607 = icmp sgt i32 %add1084.1, %1
  %fneg..12608 = select i1 %cmp1087.not.12607, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3051 = insertelement <4 x float> poison, float %fneg..12608, i64 0
  %cmp1087.not.1.1.not = icmp slt i32 %add1084.1, %1
  %fneg..1.1 = select i1 %cmp1087.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3238 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3051, float %fneg..1.1, i64 1
  %add1085.2.1 = or disjoint i32 %add1084.1, 2
  %cmp1087.not.2.1 = icmp sgt i32 %add1085.2.1, %1
  %fneg..2.1 = select i1 %cmp1087.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3411 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3238, float %fneg..2.1, i64 2
  %add1085.3.1 = or disjoint i32 %add1084.1, 3
  %cmp1087.not.3.1 = icmp sgt i32 %add1085.3.1, %1
  %fneg..3.1 = select i1 %cmp1087.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3584 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3411, float %fneg..3.1, i64 3
  br label %if.end1101.1

if.end1101.1:                                     ; preds = %for.cond1050.preheader.1, %for.cond1077.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3584, %for.cond1077.preheader.1 ], [ zeroinitializer, %for.cond1050.preheader.1 ]
  %583 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %558, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !101
  %584 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %557, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %583), !call_argsrelate !101
  %585 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %556, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %584), !call_argsrelate !101
  %586 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %555, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %585), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3053 = extractelement <4 x float> %586, i64 0
  %mul1136.12612 = fmul contract float %acc_s.sroa.0.0.vec.extract3053, 0x3FB99999A0000000
  %587 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.12612, float 0x4024CB5EC0000000)
  %588 = tail call contract noundef float @llvm.exp.f32(float %587)
  %acc_s.sroa.0.4.vec.extract3240 = extractelement <4 x float> %586, i64 1
  %mul1136.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3240, 0x3FB99999A0000000
  %589 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.1.1, float 0x4024CB5EC0000000)
  %590 = tail call contract noundef float @llvm.exp.f32(float %589)
  %acc_s.sroa.0.8.vec.extract3413 = extractelement <4 x float> %586, i64 2
  %mul1136.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3413, 0x3FB99999A0000000
  %591 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.2.1, float 0x4024CB5EC0000000)
  %592 = tail call contract noundef float @llvm.exp.f32(float %591)
  %acc_s.sroa.0.12.vec.extract3586 = extractelement <4 x float> %586, i64 3
  %mul1136.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3586, 0x3FB99999A0000000
  %593 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.3.1, float 0x4024CB5EC0000000)
  %594 = tail call contract noundef float @llvm.exp.f32(float %593)
  %add1152.12613 = fadd contract float %sum_acc.sroa.0.3, %588
  %add1152.1.1 = fadd contract float %sum_acc.sroa.36.3, %590
  %add1152.2.1 = fadd contract float %sum_acc.sroa.70.3, %592
  %add1152.3.1 = fadd contract float %sum_acc.sroa.104.3, %594
  %595 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %588)
  %596 = insertelement <4 x i16> poison, i16 %595, i64 0
  %597 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %590)
  %598 = insertelement <4 x i16> %596, i16 %597, i64 1
  %599 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %592)
  %600 = insertelement <4 x i16> %598, i16 %599, i64 2
  %601 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %594)
  %602 = insertelement <4 x i16> %600, i16 %601, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2956 = bitcast <4 x i16> %602 to <4 x half>
  %603 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37204416, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.0.1), !call_argsrelate !214
  %604 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37414417, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.42.1), !call_argsrelate !214
  %605 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38224418, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.82.1), !call_argsrelate !214
  %606 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38434419, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.122.1), !call_argsrelate !214
  br label %if.end1188.1

if.end1188.1:                                     ; preds = %if.end1101.1, %if.end1042.1
  %acc_o.sroa.122.2 = phi <4 x float> [ %acc_o.sroa.122.1, %if.end1042.1 ], [ %606, %if.end1101.1 ]
  %acc_o.sroa.82.2 = phi <4 x float> [ %acc_o.sroa.82.1, %if.end1042.1 ], [ %605, %if.end1101.1 ]
  %acc_o.sroa.42.2 = phi <4 x float> [ %acc_o.sroa.42.1, %if.end1042.1 ], [ %604, %if.end1101.1 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1042.1 ], [ %603, %if.end1101.1 ]
  %sum_acc.sroa.104.4 = phi float [ %sum_acc.sroa.104.3, %if.end1042.1 ], [ %add1152.3.1, %if.end1101.1 ]
  %sum_acc.sroa.70.4 = phi float [ %sum_acc.sroa.70.3, %if.end1042.1 ], [ %add1152.2.1, %if.end1101.1 ]
  %sum_acc.sroa.36.4 = phi float [ %sum_acc.sroa.36.3, %if.end1042.1 ], [ %add1152.1.1, %if.end1101.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end1042.1 ], [ %add1152.12613, %if.end1101.1 ]
  br i1 %or.cond2520.1, label %if.end1334.1, label %for.cond1196.preheader.1

for.cond1196.preheader.1:                         ; preds = %if.end1188.1
  %607 = shl nsw i32 %cond.i.i2318.5, 10
  %mul1203.1 = and i32 %607, 64512
  %add1206.1 = add nuw nsw i32 %add934, %mul1203.1
  %608 = zext nneg i32 %add1206.1 to i64
  %add.ptr1211.12614 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %608
  %V_reg.sroa.0.0.copyload37214428 = load <4 x half>, ptr addrspace(4) %add.ptr1211.12614, align 16
  %V_reg.sroa.42.0.add.ptr1211.12614.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1211.12614, i64 8
  %V_reg.sroa.42.0.copyload37424429 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1211.12614.sroa_idx, align 8
  %609 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %608
  %add.ptr1211.1.1 = getelementptr inbounds i8, ptr addrspace(4) %609, i64 1024
  %V_reg.sroa.74.16.copyload38234430 = load <4 x half>, ptr addrspace(4) %add.ptr1211.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1211.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %609, i64 1032
  %V_reg.sroa.114.16.copyload38444431 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1211.1.1.sroa_idx, align 8
  %cmp1221.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp1221.1, label %for.cond1223.preheader.1, label %if.end1247.1

for.cond1223.preheader.1:                         ; preds = %for.cond1196.preheader.1
  %add1230.1 = add nuw nsw i32 %mul11.5, %mul1083
  %cmp1233.not.12615 = icmp sgt i32 %add1230.1, %1
  %fneg.2183.12616 = select i1 %cmp1233.not.12615, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3063 = insertelement <4 x float> poison, float %fneg.2183.12616, i64 0
  %cmp1233.not.1.1.not = icmp slt i32 %add1230.1, %1
  %fneg.2183.1.1 = select i1 %cmp1233.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3248 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3063, float %fneg.2183.1.1, i64 1
  %add1231.2.1 = or disjoint i32 %add1230.1, 2
  %cmp1233.not.2.1 = icmp sgt i32 %add1231.2.1, %1
  %fneg.2183.2.1 = select i1 %cmp1233.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3421 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3248, float %fneg.2183.2.1, i64 2
  %add1231.3.1 = or disjoint i32 %add1230.1, 3
  %cmp1233.not.3.1 = icmp sgt i32 %add1231.3.1, %1
  %fneg.2183.3.1 = select i1 %cmp1233.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3594 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3421, float %fneg.2183.3.1, i64 3
  br label %if.end1247.1

if.end1247.1:                                     ; preds = %for.cond1196.preheader.1, %for.cond1223.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3594, %for.cond1223.preheader.1 ], [ zeroinitializer, %for.cond1196.preheader.1 ]
  %610 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %565, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !101
  %611 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %564, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %610), !call_argsrelate !101
  %612 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %563, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %611), !call_argsrelate !101
  %613 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %562, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %612), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3065 = extractelement <4 x float> %613, i64 0
  %mul1282.12620 = fmul contract float %acc_s.sroa.0.0.vec.extract3065, 0x3FB99999A0000000
  %614 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.12620, float 0x4024CB5EC0000000)
  %615 = tail call contract noundef float @llvm.exp.f32(float %614)
  %acc_s.sroa.0.4.vec.extract3250 = extractelement <4 x float> %613, i64 1
  %mul1282.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3250, 0x3FB99999A0000000
  %616 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.1.1, float 0x4024CB5EC0000000)
  %617 = tail call contract noundef float @llvm.exp.f32(float %616)
  %acc_s.sroa.0.8.vec.extract3423 = extractelement <4 x float> %613, i64 2
  %mul1282.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3423, 0x3FB99999A0000000
  %618 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.2.1, float 0x4024CB5EC0000000)
  %619 = tail call contract noundef float @llvm.exp.f32(float %618)
  %acc_s.sroa.0.12.vec.extract3596 = extractelement <4 x float> %613, i64 3
  %mul1282.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3596, 0x3FB99999A0000000
  %620 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.3.1, float 0x4024CB5EC0000000)
  %621 = tail call contract noundef float @llvm.exp.f32(float %620)
  %add1298.12621 = fadd contract float %sum_acc.sroa.0.4, %615
  %add1298.1.1 = fadd contract float %sum_acc.sroa.36.4, %617
  %add1298.2.1 = fadd contract float %sum_acc.sroa.70.4, %619
  %add1298.3.1 = fadd contract float %sum_acc.sroa.104.4, %621
  %622 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %615)
  %623 = insertelement <4 x i16> poison, i16 %622, i64 0
  %624 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %617)
  %625 = insertelement <4 x i16> %623, i16 %624, i64 1
  %626 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %619)
  %627 = insertelement <4 x i16> %625, i16 %626, i64 2
  %628 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %621)
  %629 = insertelement <4 x i16> %627, i16 %628, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2958 = bitcast <4 x i16> %629 to <4 x half>
  %630 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37214428, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !214
  %631 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37424429, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.26.1), !call_argsrelate !214
  %632 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38234430, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !214
  %633 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38444431, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.74.1), !call_argsrelate !214
  br label %if.end1334.1

if.end1334.1:                                     ; preds = %if.end1247.1, %if.end1188.1
  %acc_o_alt.sroa.74.2 = phi <4 x float> [ %acc_o_alt.sroa.74.1, %if.end1188.1 ], [ %633, %if.end1247.1 ]
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1188.1 ], [ %632, %if.end1247.1 ]
  %acc_o_alt.sroa.26.2 = phi <4 x float> [ %acc_o_alt.sroa.26.1, %if.end1188.1 ], [ %631, %if.end1247.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1188.1 ], [ %630, %if.end1247.1 ]
  %sum_acc.sroa.104.5 = phi float [ %sum_acc.sroa.104.4, %if.end1188.1 ], [ %add1298.3.1, %if.end1247.1 ]
  %sum_acc.sroa.70.5 = phi float [ %sum_acc.sroa.70.4, %if.end1188.1 ], [ %add1298.2.1, %if.end1247.1 ]
  %sum_acc.sroa.36.5 = phi float [ %sum_acc.sroa.36.4, %if.end1188.1 ], [ %add1298.1.1, %if.end1247.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end1188.1 ], [ %add1298.12621, %if.end1247.1 ]
  br i1 %or.cond2522.1, label %if.end1480.1, label %for.cond1342.preheader.1

for.cond1342.preheader.1:                         ; preds = %if.end1334.1
  %634 = shl nsw i32 %cond.i.i2318.6, 10
  %mul1349.1 = and i32 %634, 64512
  %add1352.1 = add nuw nsw i32 %add934, %mul1349.1
  %635 = zext nneg i32 %add1352.1 to i64
  %add.ptr1357.12622 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %635
  %V_reg.sroa.0.0.copyload37224440 = load <4 x half>, ptr addrspace(4) %add.ptr1357.12622, align 16
  %V_reg.sroa.42.0.add.ptr1357.12622.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1357.12622, i64 8
  %V_reg.sroa.42.0.copyload37434441 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1357.12622.sroa_idx, align 8
  %636 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %635
  %add.ptr1357.1.1 = getelementptr inbounds i8, ptr addrspace(4) %636, i64 1024
  %V_reg.sroa.74.16.copyload38244442 = load <4 x half>, ptr addrspace(4) %add.ptr1357.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1357.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %636, i64 1032
  %V_reg.sroa.114.16.copyload38454443 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1357.1.1.sroa_idx, align 8
  %cmp1367.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp1367.1, label %for.cond1369.preheader.1, label %if.end1393.1

for.cond1369.preheader.1:                         ; preds = %for.cond1342.preheader.1
  %add1376.1 = add nuw nsw i32 %mul11.6, %mul1083
  %cmp1379.not.12623 = icmp sgt i32 %add1376.1, %1
  %fneg.2184.12624 = select i1 %cmp1379.not.12623, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3075 = insertelement <4 x float> poison, float %fneg.2184.12624, i64 0
  %cmp1379.not.1.1.not = icmp slt i32 %add1376.1, %1
  %fneg.2184.1.1 = select i1 %cmp1379.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3258 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3075, float %fneg.2184.1.1, i64 1
  %add1377.2.1 = or disjoint i32 %add1376.1, 2
  %cmp1379.not.2.1 = icmp sgt i32 %add1377.2.1, %1
  %fneg.2184.2.1 = select i1 %cmp1379.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3431 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3258, float %fneg.2184.2.1, i64 2
  %add1377.3.1 = or disjoint i32 %add1376.1, 3
  %cmp1379.not.3.1 = icmp sgt i32 %add1377.3.1, %1
  %fneg.2184.3.1 = select i1 %cmp1379.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3604 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3431, float %fneg.2184.3.1, i64 3
  br label %if.end1393.1

if.end1393.1:                                     ; preds = %for.cond1342.preheader.1, %for.cond1369.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3604, %for.cond1369.preheader.1 ], [ zeroinitializer, %for.cond1342.preheader.1 ]
  %637 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %572, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !101
  %638 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %571, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %637), !call_argsrelate !101
  %639 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %570, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %638), !call_argsrelate !101
  %640 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %569, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %639), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3077 = extractelement <4 x float> %640, i64 0
  %mul1428.12628 = fmul contract float %acc_s.sroa.0.0.vec.extract3077, 0x3FB99999A0000000
  %641 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.12628, float 0x4024CB5EC0000000)
  %642 = tail call contract noundef float @llvm.exp.f32(float %641)
  %acc_s.sroa.0.4.vec.extract3260 = extractelement <4 x float> %640, i64 1
  %mul1428.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3260, 0x3FB99999A0000000
  %643 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.1.1, float 0x4024CB5EC0000000)
  %644 = tail call contract noundef float @llvm.exp.f32(float %643)
  %acc_s.sroa.0.8.vec.extract3433 = extractelement <4 x float> %640, i64 2
  %mul1428.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3433, 0x3FB99999A0000000
  %645 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.2.1, float 0x4024CB5EC0000000)
  %646 = tail call contract noundef float @llvm.exp.f32(float %645)
  %acc_s.sroa.0.12.vec.extract3606 = extractelement <4 x float> %640, i64 3
  %mul1428.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3606, 0x3FB99999A0000000
  %647 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.3.1, float 0x4024CB5EC0000000)
  %648 = tail call contract noundef float @llvm.exp.f32(float %647)
  %add1444.12629 = fadd contract float %sum_acc.sroa.0.5, %642
  %add1444.1.1 = fadd contract float %sum_acc.sroa.36.5, %644
  %add1444.2.1 = fadd contract float %sum_acc.sroa.70.5, %646
  %add1444.3.1 = fadd contract float %sum_acc.sroa.104.5, %648
  %649 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %642)
  %650 = insertelement <4 x i16> poison, i16 %649, i64 0
  %651 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %644)
  %652 = insertelement <4 x i16> %650, i16 %651, i64 1
  %653 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %646)
  %654 = insertelement <4 x i16> %652, i16 %653, i64 2
  %655 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %648)
  %656 = insertelement <4 x i16> %654, i16 %655, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2960 = bitcast <4 x i16> %656 to <4 x half>
  %657 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37224440, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !214
  %658 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37434441, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.42.2), !call_argsrelate !214
  %659 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38244442, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.82.2), !call_argsrelate !214
  %660 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38454443, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.122.2), !call_argsrelate !214
  br label %if.end1480.1

if.end1480.1:                                     ; preds = %if.end1393.1, %if.end1334.1
  %acc_o.sroa.122.3 = phi <4 x float> [ %acc_o.sroa.122.2, %if.end1334.1 ], [ %660, %if.end1393.1 ]
  %acc_o.sroa.82.3 = phi <4 x float> [ %acc_o.sroa.82.2, %if.end1334.1 ], [ %659, %if.end1393.1 ]
  %acc_o.sroa.42.3 = phi <4 x float> [ %acc_o.sroa.42.2, %if.end1334.1 ], [ %658, %if.end1393.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end1334.1 ], [ %657, %if.end1393.1 ]
  %sum_acc.sroa.104.6 = phi float [ %sum_acc.sroa.104.5, %if.end1334.1 ], [ %add1444.3.1, %if.end1393.1 ]
  %sum_acc.sroa.70.6 = phi float [ %sum_acc.sroa.70.5, %if.end1334.1 ], [ %add1444.2.1, %if.end1393.1 ]
  %sum_acc.sroa.36.6 = phi float [ %sum_acc.sroa.36.5, %if.end1334.1 ], [ %add1444.1.1, %if.end1393.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end1334.1 ], [ %add1444.12629, %if.end1393.1 ]
  br i1 %or.cond2524.1, label %if.end1630, label %for.cond1488.preheader.1

for.cond1488.preheader.1:                         ; preds = %if.end1480.1
  %661 = shl nsw i32 %cond.i.i2318.7, 10
  %mul1495.1 = and i32 %661, 64512
  %add1498.1 = add nuw nsw i32 %add934, %mul1495.1
  %662 = zext nneg i32 %add1498.1 to i64
  %add.ptr1503.12630 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %662
  %V_reg.sroa.0.0.copyload37234452 = load <4 x half>, ptr addrspace(4) %add.ptr1503.12630, align 16
  %V_reg.sroa.42.0.add.ptr1503.12630.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1503.12630, i64 8
  %V_reg.sroa.42.0.copyload37444453 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1503.12630.sroa_idx, align 8
  %663 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %662
  %add.ptr1503.1.1 = getelementptr inbounds i8, ptr addrspace(4) %663, i64 1024
  %V_reg.sroa.74.16.copyload38254454 = load <4 x half>, ptr addrspace(4) %add.ptr1503.1.1, align 16
  %V_reg.sroa.114.16.add.ptr1503.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %663, i64 1032
  %V_reg.sroa.114.16.copyload38464455 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1503.1.1.sroa_idx, align 8
  %cmp1513.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp1513.1, label %for.cond1515.preheader.1, label %if.end1539.1

for.cond1515.preheader.1:                         ; preds = %for.cond1488.preheader.1
  %add1522.1 = add nuw nsw i32 %mul11.7, %mul1083
  %cmp1525.not.12631 = icmp sgt i32 %add1522.1, %1
  %fneg.2185.12632 = select i1 %cmp1525.not.12631, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3087 = insertelement <4 x float> poison, float %fneg.2185.12632, i64 0
  %cmp1525.not.1.1.not = icmp slt i32 %add1522.1, %1
  %fneg.2185.1.1 = select i1 %cmp1525.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3268 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3087, float %fneg.2185.1.1, i64 1
  %add1523.2.1 = or disjoint i32 %add1522.1, 2
  %cmp1525.not.2.1 = icmp sgt i32 %add1523.2.1, %1
  %fneg.2185.2.1 = select i1 %cmp1525.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3441 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3268, float %fneg.2185.2.1, i64 2
  %add1523.3.1 = or disjoint i32 %add1522.1, 3
  %cmp1525.not.3.1 = icmp sgt i32 %add1523.3.1, %1
  %fneg.2185.3.1 = select i1 %cmp1525.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3614 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3441, float %fneg.2185.3.1, i64 3
  br label %if.end1539.1

if.end1539.1:                                     ; preds = %for.cond1488.preheader.1, %for.cond1515.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3614, %for.cond1515.preheader.1 ], [ zeroinitializer, %for.cond1488.preheader.1 ]
  %664 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %579, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !101
  %665 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %578, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %664), !call_argsrelate !101
  %666 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %577, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %665), !call_argsrelate !101
  %667 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %576, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %666), !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3089 = extractelement <4 x float> %667, i64 0
  %mul1574.12636 = fmul contract float %acc_s.sroa.0.0.vec.extract3089, 0x3FB99999A0000000
  %668 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.12636, float 0x4024CB5EC0000000)
  %669 = tail call contract noundef float @llvm.exp.f32(float %668)
  %acc_s.sroa.0.4.vec.extract3270 = extractelement <4 x float> %667, i64 1
  %mul1574.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3270, 0x3FB99999A0000000
  %670 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.1.1, float 0x4024CB5EC0000000)
  %671 = tail call contract noundef float @llvm.exp.f32(float %670)
  %acc_s.sroa.0.8.vec.extract3443 = extractelement <4 x float> %667, i64 2
  %mul1574.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3443, 0x3FB99999A0000000
  %672 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.2.1, float 0x4024CB5EC0000000)
  %673 = tail call contract noundef float @llvm.exp.f32(float %672)
  %acc_s.sroa.0.12.vec.extract3616 = extractelement <4 x float> %667, i64 3
  %mul1574.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3616, 0x3FB99999A0000000
  %674 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.3.1, float 0x4024CB5EC0000000)
  %675 = tail call contract noundef float @llvm.exp.f32(float %674)
  %add1590.12637 = fadd contract float %sum_acc.sroa.0.6, %669
  %add1590.1.1 = fadd contract float %sum_acc.sroa.36.6, %671
  %add1590.2.1 = fadd contract float %sum_acc.sroa.70.6, %673
  %add1590.3.1 = fadd contract float %sum_acc.sroa.104.6, %675
  %676 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %669)
  %677 = insertelement <4 x i16> poison, i16 %676, i64 0
  %678 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %671)
  %679 = insertelement <4 x i16> %677, i16 %678, i64 1
  %680 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %673)
  %681 = insertelement <4 x i16> %679, i16 %680, i64 2
  %682 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %675)
  %683 = insertelement <4 x i16> %681, i16 %682, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2962 = bitcast <4 x i16> %683 to <4 x half>
  %684 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37234452, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !214
  %685 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37444453, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.26.2), !call_argsrelate !214
  %686 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38254454, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !214
  %687 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38464455, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.74.2), !call_argsrelate !214
  br label %if.end1630

if.end1630:                                       ; preds = %if.end1480.1, %if.end1539.1, %if.end798.1.1
  %.pre-phi4399 = phi i32 [ %23, %if.end798.1.1 ], [ %mul938, %if.end1539.1 ], [ %mul938, %if.end1480.1 ]
  %.pre-phi = phi i32 [ %.pre, %if.end798.1.1 ], [ %22, %if.end1539.1 ], [ %22, %if.end1480.1 ]
  %acc_o.sroa.122.4 = phi <4 x float> [ %379, %if.end798.1.1 ], [ %acc_o.sroa.122.3, %if.end1539.1 ], [ %acc_o.sroa.122.3, %if.end1480.1 ]
  %acc_o.sroa.82.4 = phi <4 x float> [ %378, %if.end798.1.1 ], [ %acc_o.sroa.82.3, %if.end1539.1 ], [ %acc_o.sroa.82.3, %if.end1480.1 ]
  %acc_o.sroa.42.4 = phi <4 x float> [ %377, %if.end798.1.1 ], [ %acc_o.sroa.42.3, %if.end1539.1 ], [ %acc_o.sroa.42.3, %if.end1480.1 ]
  %acc_o.sroa.0.4 = phi <4 x float> [ %376, %if.end798.1.1 ], [ %acc_o.sroa.0.3, %if.end1539.1 ], [ %acc_o.sroa.0.3, %if.end1480.1 ]
  %acc_o_alt.sroa.74.4 = phi <4 x float> [ %415, %if.end798.1.1 ], [ %687, %if.end1539.1 ], [ %acc_o_alt.sroa.74.2, %if.end1480.1 ]
  %acc_o_alt.sroa.50.4 = phi <4 x float> [ %414, %if.end798.1.1 ], [ %686, %if.end1539.1 ], [ %acc_o_alt.sroa.50.2, %if.end1480.1 ]
  %acc_o_alt.sroa.26.4 = phi <4 x float> [ %413, %if.end798.1.1 ], [ %685, %if.end1539.1 ], [ %acc_o_alt.sroa.26.2, %if.end1480.1 ]
  %acc_o_alt.sroa.0.4 = phi <4 x float> [ %412, %if.end798.1.1 ], [ %684, %if.end1539.1 ], [ %acc_o_alt.sroa.0.2, %if.end1480.1 ]
  %sum_acc.sroa.104.8 = phi float [ %add860.3.1, %if.end798.1.1 ], [ %add1590.3.1, %if.end1539.1 ], [ %sum_acc.sroa.104.6, %if.end1480.1 ]
  %sum_acc.sroa.70.8 = phi float [ %add860.2.1, %if.end798.1.1 ], [ %add1590.2.1, %if.end1539.1 ], [ %sum_acc.sroa.70.6, %if.end1480.1 ]
  %sum_acc.sroa.36.8 = phi float [ %add860.1.1, %if.end798.1.1 ], [ %add1590.1.1, %if.end1539.1 ], [ %sum_acc.sroa.36.6, %if.end1480.1 ]
  %sum_acc.sroa.0.8 = phi float [ %add860.12833, %if.end798.1.1 ], [ %add1590.12637, %if.end1539.1 ], [ %sum_acc.sroa.0.6, %if.end1480.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 0
  %add1639 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 1
  %add1639.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 2
  %add1639.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 3
  %add1639.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.42.16.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 0
  %acc_o_alt.sroa.26.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 0
  %add1639.4 = fadd contract float %acc_o.sroa.42.16.vec.extract, %acc_o_alt.sroa.26.16.vec.extract
  %acc_o.sroa.42.20.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 1
  %acc_o_alt.sroa.26.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 1
  %add1639.5 = fadd contract float %acc_o.sroa.42.20.vec.extract, %acc_o_alt.sroa.26.20.vec.extract
  %acc_o.sroa.42.24.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 2
  %acc_o_alt.sroa.26.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 2
  %add1639.6 = fadd contract float %acc_o.sroa.42.24.vec.extract, %acc_o_alt.sroa.26.24.vec.extract
  %acc_o.sroa.42.28.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 3
  %acc_o_alt.sroa.26.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 3
  %add1639.7 = fadd contract float %acc_o.sroa.42.28.vec.extract, %acc_o_alt.sroa.26.28.vec.extract
  %acc_o.sroa.82.32.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 0
  %acc_o_alt.sroa.50.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 0
  %add1639.8 = fadd contract float %acc_o.sroa.82.32.vec.extract, %acc_o_alt.sroa.50.32.vec.extract
  %acc_o.sroa.82.36.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 1
  %acc_o_alt.sroa.50.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 1
  %add1639.9 = fadd contract float %acc_o.sroa.82.36.vec.extract, %acc_o_alt.sroa.50.36.vec.extract
  %acc_o.sroa.82.40.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 2
  %acc_o_alt.sroa.50.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 2
  %add1639.10 = fadd contract float %acc_o.sroa.82.40.vec.extract, %acc_o_alt.sroa.50.40.vec.extract
  %acc_o.sroa.82.44.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 3
  %acc_o_alt.sroa.50.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 3
  %add1639.11 = fadd contract float %acc_o.sroa.82.44.vec.extract, %acc_o_alt.sroa.50.44.vec.extract
  %acc_o.sroa.122.48.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 0
  %acc_o_alt.sroa.74.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 0
  %add1639.12 = fadd contract float %acc_o.sroa.122.48.vec.extract, %acc_o_alt.sroa.74.48.vec.extract
  %acc_o.sroa.122.52.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 1
  %acc_o_alt.sroa.74.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 1
  %add1639.13 = fadd contract float %acc_o.sroa.122.52.vec.extract, %acc_o_alt.sroa.74.52.vec.extract
  %acc_o.sroa.122.56.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 2
  %acc_o_alt.sroa.74.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 2
  %add1639.14 = fadd contract float %acc_o.sroa.122.56.vec.extract, %acc_o_alt.sroa.74.56.vec.extract
  %acc_o.sroa.122.60.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 3
  %acc_o_alt.sroa.74.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 3
  %add1639.15 = fadd contract float %acc_o.sroa.122.60.vec.extract, %acc_o_alt.sroa.74.60.vec.extract
  %add1653 = fadd contract float %sum_acc.sroa.0.8, 0.000000e+00
  %add1653.1 = fadd contract float %add1653, %sum_acc.sroa.36.8
  %add1653.2 = fadd contract float %add1653.1, %sum_acc.sroa.70.8
  %add1653.3 = fadd contract float %add1653.2, %sum_acc.sroa.104.8
  %688 = bitcast float %add1653.3 to i32
  %689 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %690 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %689) #11
  %xor.i.i = xor i32 %690, 32
  %691 = and i32 %690, -64
  %and.i.i = add nsw i32 %691, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i2353 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %690
  %shl.i.i = shl i32 %cond.i.i2353, 2
  %692 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %688)
  %693 = bitcast i32 %692 to float
  %add.i = fadd contract float %add1653.3, %693
  %694 = bitcast float %add.i to i32
  %695 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %696 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %695) #11
  %xor.i.i2354 = xor i32 %696, 16
  %697 = and i32 %696, -64
  %and.i.i2355 = add nsw i32 %697, 64
  %cmp.not.i.i2356 = icmp slt i32 %xor.i.i2354, %and.i.i2355
  %cond.i.i2357 = select i1 %cmp.not.i.i2356, i32 %xor.i.i2354, i32 %696
  %shl.i.i2358 = shl i32 %cond.i.i2357, 2
  %698 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2358, i32 %694)
  %699 = bitcast i32 %698 to float
  %add.i.i = fadd contract float %add.i, %699
  %cmp1662 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_12.0 = select i1 %cmp1662, float %div, float 0.000000e+00
  %mul1675 = fmul contract float %condval_12.0, %add1639
  %mul1675.1 = fmul contract float %condval_12.0, %add1639.1
  %mul1675.2 = fmul contract float %condval_12.0, %add1639.2
  %mul1675.3 = fmul contract float %condval_12.0, %add1639.3
  %mul1675.4 = fmul contract float %condval_12.0, %add1639.4
  %mul1675.5 = fmul contract float %condval_12.0, %add1639.5
  %mul1675.6 = fmul contract float %condval_12.0, %add1639.6
  %mul1675.7 = fmul contract float %condval_12.0, %add1639.7
  %mul1675.8 = fmul contract float %condval_12.0, %add1639.8
  %mul1675.9 = fmul contract float %condval_12.0, %add1639.9
  %mul1675.10 = fmul contract float %condval_12.0, %add1639.10
  %mul1675.11 = fmul contract float %condval_12.0, %add1639.11
  %mul1675.12 = fmul contract float %condval_12.0, %add1639.12
  %mul1675.13 = fmul contract float %condval_12.0, %add1639.13
  %mul1675.14 = fmul contract float %condval_12.0, %add1639.14
  %mul1675.15 = fmul contract float %condval_12.0, %add1639.15
  %700 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675)
  %O_reg.sroa.0.0.insert.ext = zext i16 %700 to i64
  %701 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %701 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %702 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %702 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %703 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %703 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %704 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %704 to i64
  %705 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %705 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %706 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %706 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %707 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %707 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %708 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %708 to i64
  %709 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %709 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %710 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %710 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %711 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %711 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %712 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %712 to i64
  %713 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %713 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %714 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %714 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %715 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %715 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1717 = lshr i32 %18, 5
  %and1720 = and i32 %18, 7
  %mul1726 = and i32 %.pre-phi, 4
  %xor = xor i32 %shr1717, %and1720
  %mul1721 = shl nuw nsw i32 %xor, 3
  %add1722 = add nuw nsw i32 %mul1721, %mul25
  %add1727 = or disjoint i32 %add1722, %mul1726
  %add.ptr1729 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1729, align 8
  %add1718.1 = add nuw nsw i32 %shr1717, 2
  %xor.1 = xor i32 %add1718.1, %and1720
  %mul1721.1 = shl nuw nsw i32 %xor.1, 3
  %add1722.1 = add nuw nsw i32 %mul1721.1, %mul25
  %add1727.1 = or disjoint i32 %add1722.1, %mul1726
  %add.ptr1729.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1729.1, align 8
  %add1718.2 = add nuw nsw i32 %shr1717, 4
  %xor.2 = xor i32 %add1718.2, %and1720
  %mul1721.2 = shl nuw nsw i32 %xor.2, 3
  %add1722.2 = add nuw nsw i32 %mul1721.2, %mul25
  %add1727.2 = or disjoint i32 %add1722.2, %mul1726
  %add.ptr1729.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1729.2, align 8
  %add1718.3 = add nuw nsw i32 %shr1717, 6
  %xor.3 = xor i32 %add1718.3, %and1720
  %mul1721.3 = shl nuw nsw i32 %xor.3, 3
  %add1722.3 = add nuw nsw i32 %mul1721.3, %mul25
  %add1727.3 = or disjoint i32 %add1722.3, %mul1726
  %add.ptr1729.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1729.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul1740 = and i32 %.pre-phi4399, 8128
  %xor17462181 = and i32 %.pre-phi4399, 56
  %call1744.masked = and i32 %18, 1016
  %mul1747 = xor i32 %xor17462181, %call1744.masked
  %invariant.gep2513 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1740
  %invariant.gep2515 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep2513, i32 %mul1747
  %add1757 = add nuw nsw i32 %add23, %.pre-phi4399
  %716 = zext nneg i32 %add1757 to i64
  %add.ptr1762 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %716
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1762, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2515, i64 16, i1 false), !tbaa.struct !364, !call_argsrelate !365
  %gep2516.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2515, i32 1024
  %717 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %716
  %add.ptr1762.1 = getelementptr inbounds i8, ptr addrspace(1) %717, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1762.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2516.1, i64 16, i1 false), !tbaa.struct !364, !call_argsrelate !365
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

declare i32 @llvm.umax.i32(i32, i32) #7

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


