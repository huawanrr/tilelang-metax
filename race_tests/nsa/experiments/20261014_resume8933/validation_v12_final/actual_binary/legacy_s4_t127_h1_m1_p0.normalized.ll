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
  %indices = alloca [4 x i32], align 4, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 16, ptr addrspace(5) %indices) #11
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 2
  %1 = zext nneg i32 %mul to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %1
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp7 = icmp ult i32 %2, 8
  %3 = shl nsw i32 %2, 4
  %mul8 = select i1 %cmp7, i32 %3, i32 -16
  store i32 %mul8, ptr addrspace(5) %indices, align 4, !tbaa !30
  %4 = or disjoint i64 %1, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cmp7.1 = icmp ult i32 %5, 8
  %6 = shl nsw i32 %5, 4
  %mul8.1 = select i1 %cmp7.1, i32 %6, i32 -16
  %arrayidx10.1 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 4
  store i32 %mul8.1, ptr addrspace(5) %arrayidx10.1, align 4, !tbaa !30
  %7 = or disjoint i64 %1, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %7
  %8 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cmp7.2 = icmp ult i32 %8, 8
  %9 = shl nsw i32 %8, 4
  %mul8.2 = select i1 %cmp7.2, i32 %9, i32 -16
  %arrayidx10.2 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 8
  store i32 %mul8.2, ptr addrspace(5) %arrayidx10.2, align 4, !tbaa !30
  %10 = or disjoint i64 %1, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cmp7.3 = icmp ult i32 %11, 8
  %12 = shl nsw i32 %11, 4
  %mul8.3 = select i1 %cmp7.3, i32 %12, i32 -16
  %arrayidx10.3 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 12
  store i32 %mul8.3, ptr addrspace(5) %arrayidx10.3, align 4, !tbaa !30
  %mul17 = shl nsw i32 %0, 10
  %13 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !49
  %and = shl nuw nsw i32 %13, 6
  %mul19 = and i32 %and, 960
  %add20 = or disjoint i32 %mul19, %mul17
  %14 = lshr i32 %13, 1
  %mul24 = and i32 %14, 504
  %add22 = add nuw nsw i32 %add20, %mul24
  %15 = zext nneg i32 %add22 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %15
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %15
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %16, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %shr67 = lshr i32 %13, 3
  %mul76 = shl nuw nsw i32 %13, 3
  %mul170 = and i32 %mul76, 8128
  %xor569 = and i32 %mul76, 56
  %call174.masked = and i32 %13, 1016
  %mul176 = xor i32 %xor569, %call174.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul170
  %invariant.gep650 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul176
  %17 = lshr i32 %13, 2
  %mul191 = and i32 %17, 252
  %shr223 = lshr i32 %13, 4
  %and226 = and i32 %13, 7
  %18 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul19
  %invariant.gep662 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 2048
  %19 = shl nuw nsw i32 %13, 4
  %mul339 = and i32 %19, 16128
  %shr345 = and i32 %shr67, 1
  %mul350 = and i32 %17, 4
  %K_reg.sroa.4.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 4
  %K_reg.sroa.5.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 8
  %K_reg.sroa.6.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 12
  %gep651.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1024
  %K_reg.sroa.9.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1028
  %K_reg.sroa.10.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1032
  %K_reg.sroa.11.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1036
  %xor227 = xor i32 %shr223, %and226
  %add.ptr231.idx = shl nuw nsw i32 %xor227, 4
  %add.ptr231 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %add.ptr231.idx
  %kb.sroa.6.0.add.ptr231.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr231, i32 8
  %add224.1 = add nuw nsw i32 %shr223, 4
  %xor227.1 = xor i32 %add224.1, %and226
  %add.ptr231.idx.1 = shl nuw nsw i32 %xor227.1, 4
  %add.ptr231.1 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %add.ptr231.idx.1
  %kb.sroa.6.0.add.ptr231.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr231.1, i32 8
  %V_reg.sroa.4.0.invariant.gep662.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 2052
  %V_reg.sroa.5.0.invariant.gep662.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 2056
  %V_reg.sroa.6.0.invariant.gep662.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 3072
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 3076
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 3080
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 3084
  %xor352 = or disjoint i32 %mul350, %shr345
  %mul353 = shl nuw nsw i32 %xor352, 3
  %add354 = or disjoint i32 %mul353, %mul339
  %add357 = or disjoint i32 %add354, %and226
  %gep666 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357
  %add341.1 = or disjoint i32 %mul339, 64
  %add351.1 = or disjoint i32 %mul350, 1
  %xor352.1 = xor i32 %add351.1, %shr345
  %mul353.1 = shl nuw nsw i32 %xor352.1, 3
  %add354.1 = or disjoint i32 %mul353.1, %add341.1
  %add357.1 = or disjoint i32 %add354.1, %and226
  %gep666.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.1
  %add341.2 = or disjoint i32 %mul339, 128
  %add351.2 = or disjoint i32 %mul350, 2
  %xor352.2 = or disjoint i32 %add351.2, %shr345
  %mul353.2 = shl nuw nsw i32 %xor352.2, 3
  %add354.2 = or disjoint i32 %mul353.2, %add341.2
  %add357.2 = or disjoint i32 %add354.2, %and226
  %gep666.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.2
  %add341.3 = or disjoint i32 %mul339, 192
  %add351.3 = or disjoint i32 %mul350, 3
  %xor352.3 = xor i32 %add351.3, %shr345
  %mul353.3 = shl nuw nsw i32 %xor352.3, 3
  %add354.3 = or disjoint i32 %mul353.3, %add341.3
  %add357.3 = or disjoint i32 %add354.3, %and226
  %gep666.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.3
  %add346.1 = or disjoint i32 %shr345, 2
  %xor352.1698 = or disjoint i32 %mul350, %add346.1
  %mul353.1699 = shl nuw nsw i32 %xor352.1698, 3
  %add354.1700 = or disjoint i32 %mul353.1699, %mul339
  %add357.1701 = or disjoint i32 %add354.1700, %and226
  %gep666.1702 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.1701
  %xor352.1.1 = xor i32 %add351.1, %add346.1
  %mul353.1.1 = shl nuw nsw i32 %xor352.1.1, 3
  %add354.1.1 = or disjoint i32 %mul353.1.1, %add341.1
  %add357.1.1 = or disjoint i32 %add354.1.1, %and226
  %gep666.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.1.1
  %xor352.2.1 = xor i32 %add351.2, %add346.1
  %mul353.2.1 = shl nuw nsw i32 %xor352.2.1, 3
  %add354.2.1 = or disjoint i32 %mul353.2.1, %add341.2
  %add357.2.1 = or disjoint i32 %add354.2.1, %and226
  %gep666.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.2.1
  %xor352.3.1 = xor i32 %add351.3, %add346.1
  %mul353.3.1 = shl nuw nsw i32 %xor352.3.1, 3
  %add354.3.1 = or disjoint i32 %mul353.3.1, %add341.3
  %add357.3.1 = or disjoint i32 %add354.3.1, %and226
  %gep666.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.3.1
  %add346.2 = or disjoint i32 %shr345, 4
  %xor352.2704 = xor i32 %mul350, %add346.2
  %mul353.2705 = shl nuw nsw i32 %xor352.2704, 3
  %add354.2706 = or disjoint i32 %mul353.2705, %mul339
  %add357.2707 = or disjoint i32 %add354.2706, %and226
  %gep666.2708 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.2707
  %xor352.1.2 = xor i32 %add351.1, %add346.2
  %mul353.1.2 = shl nuw nsw i32 %xor352.1.2, 3
  %add354.1.2 = or disjoint i32 %mul353.1.2, %add341.1
  %add357.1.2 = or disjoint i32 %add354.1.2, %and226
  %gep666.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.1.2
  %xor352.2.2 = xor i32 %add351.2, %add346.2
  %mul353.2.2 = shl nuw nsw i32 %xor352.2.2, 3
  %add354.2.2 = or disjoint i32 %mul353.2.2, %add341.2
  %add357.2.2 = or disjoint i32 %add354.2.2, %and226
  %gep666.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.2.2
  %xor352.3.2 = xor i32 %add351.3, %add346.2
  %mul353.3.2 = shl nuw nsw i32 %xor352.3.2, 3
  %add354.3.2 = or disjoint i32 %mul353.3.2, %add341.3
  %add357.3.2 = or disjoint i32 %add354.3.2, %and226
  %gep666.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.3.2
  %add346.3 = or disjoint i32 %shr345, 6
  %xor352.3710 = xor i32 %mul350, %add346.3
  %mul353.3711 = shl nuw nsw i32 %xor352.3710, 3
  %add354.3712 = or disjoint i32 %mul353.3711, %mul339
  %add357.3713 = or disjoint i32 %add354.3712, %and226
  %gep666.3714 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.3713
  %xor352.1.3 = xor i32 %add351.1, %add346.3
  %mul353.1.3 = shl nuw nsw i32 %xor352.1.3, 3
  %add354.1.3 = or disjoint i32 %mul353.1.3, %add341.1
  %add357.1.3 = or disjoint i32 %add354.1.3, %and226
  %gep666.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.1.3
  %xor352.2.3 = xor i32 %add351.2, %add346.3
  %mul353.2.3 = shl nuw nsw i32 %xor352.2.3, 3
  %add354.2.3 = or disjoint i32 %mul353.2.3, %add341.2
  %add357.2.3 = or disjoint i32 %add354.2.3, %and226
  %gep666.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.2.3
  %xor352.3.3 = xor i32 %add351.3, %add346.3
  %mul353.3.3 = shl nuw nsw i32 %xor352.3.3, 3
  %add354.3.3 = or disjoint i32 %mul353.3.3, %add341.3
  %add357.3.3 = or disjoint i32 %add354.3.3, %and226
  %gep666.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add357.3.3
  br label %for.body54

for.body54:                                       ; preds = %if.end389.1, %entry
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.0.1.1, %if.end389.1 ]
  %sum_acc.sroa.6.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.6.1.1, %if.end389.1 ]
  %sum_acc.sroa.10.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.10.1.1, %if.end389.1 ]
  %sum_acc.sroa.14.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.14.1.1, %if.end389.1 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.0.1.1, %if.end389.1 ]
  %acc_o.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.20.1.1, %if.end389.1 ]
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.38.1.1, %if.end389.1 ]
  %acc_o.sroa.56.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.56.1.1, %if.end389.1 ]
  %V_reg.sroa.11.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.11.1.1, %if.end389.1 ]
  %V_reg.sroa.10.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.10.1.1, %if.end389.1 ]
  %V_reg.sroa.9.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.9.1.1, %if.end389.1 ]
  %V_reg.sroa.7.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.7.1.1, %if.end389.1 ]
  %V_reg.sroa.6.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.6.1.1, %if.end389.1 ]
  %V_reg.sroa.5.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.5.1.1, %if.end389.1 ]
  %V_reg.sroa.4.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.4.1.1, %if.end389.1 ]
  %V_reg.sroa.0.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.0.1.1, %if.end389.1 ]
  %acc_s.sroa.0.0 = phi <4 x float> [ undef, %entry ], [ %acc_s.sroa.0.2.1, %if.end389.1 ]
  %acc_s_cast.sroa.0.0672 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.1.1, %if.end389.1 ]
  %s.0671 = phi i32 [ 0, %entry ], [ %inc391.1, %if.end389.1 ]
  %arrayidx56 = getelementptr inbounds [4 x i32], ptr addrspace(5) %indices, i32 0, i32 %s.0671
  %20 = load i32, ptr addrspace(5) %arrayidx56, align 4, !tbaa !30
  %or.cond677 = icmp ult i32 %20, 127
  br i1 %or.cond677, label %for.cond61.preheader, label %if.end209

for.cond61.preheader:                             ; preds = %for.body54
  %add68 = add nuw nsw i32 %20, %shr67
  %mul73 = shl nuw nsw i32 %20, 6
  %add74 = add nuw nsw i32 %mul73, %mul76
  %21 = zext nneg i32 %add74 to i64
  %cmp70 = icmp slt i32 %add68, 127
  br i1 %cmp70, label %if.then71, label %if.end101

if.then71:                                        ; preds = %for.cond61.preheader
  %add.ptr79 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %21
  %condval_1.sroa.7.0.add.ptr79.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr79, i64 12
  %condval_1.sroa.6.0.add.ptr79.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr79, i64 8
  %condval_1.sroa.5.0.add.ptr79.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr79, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr79, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr79.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr79.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr79.sroa_idx, align 4, !tbaa !30
  br label %if.end101

if.end101:                                        ; preds = %for.cond61.preheader, %if.then71
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then71 ], [ 0, %for.cond61.preheader ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then71 ], [ 0, %for.cond61.preheader ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then71 ], [ 0, %for.cond61.preheader ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then71 ], [ 0, %for.cond61.preheader ]
  %cmp70.1 = icmp slt i32 %add68, 119
  br i1 %cmp70.1, label %if.then71.1, label %if.end101.1

if.then71.1:                                      ; preds = %if.end101
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %21
  %add.ptr79.1 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1024
  %condval_1.sroa.7.0.add.ptr79.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1036
  %condval_1.sroa.6.0.add.ptr79.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1032
  %condval_1.sroa.5.0.add.ptr79.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1028
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr79.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr79.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr79.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr79.sroa_idx.1, align 4, !tbaa !30
  br label %if.end101.1

if.end101.1:                                      ; preds = %if.then71.1, %if.end101
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then71.1 ], [ 0, %if.end101 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then71.1 ], [ 0, %if.end101 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then71.1 ], [ 0, %if.end101 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then71.1 ], [ 0, %if.end101 ]
  br i1 %cmp70, label %if.then119, label %if.end151

if.then119:                                       ; preds = %if.end101.1
  %add.ptr127 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %21
  %condval_2.sroa.7.0.add.ptr127.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr127, i64 12
  %condval_2.sroa.6.0.add.ptr127.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr127, i64 8
  %condval_2.sroa.5.0.add.ptr127.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr127, i64 4
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr127, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr127.sroa_idx, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr127.sroa_idx, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr127.sroa_idx, align 4, !tbaa !30
  br label %if.end151

if.end151:                                        ; preds = %if.end101.1, %if.then119
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then119 ], [ 0, %if.end101.1 ]
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then119 ], [ 0, %if.end101.1 ]
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then119 ], [ 0, %if.end101.1 ]
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then119 ], [ 0, %if.end101.1 ]
  br i1 %cmp70.1, label %if.then119.1, label %if.end151.1

if.then119.1:                                     ; preds = %if.end151
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %21
  %add.ptr127.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1024
  %condval_2.sroa.7.0.add.ptr127.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1036
  %condval_2.sroa.6.0.add.ptr127.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1032
  %condval_2.sroa.5.0.add.ptr127.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1028
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr127.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr127.sroa_idx.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr127.sroa_idx.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr127.sroa_idx.1, align 4, !tbaa !30
  br label %if.end151.1

if.end151.1:                                      ; preds = %if.then119.1, %if.end151
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then119.1 ], [ 0, %if.end151 ]
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then119.1 ], [ 0, %if.end151 ]
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then119.1 ], [ 0, %if.end151 ]
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then119.1 ], [ 0, %if.end151 ]
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep650, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep650.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep651.1, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep651.1.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep651.1.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep651.1.sroa_idx, align 4, !tbaa !30
  %cmp183 = icmp sgt i32 %20, 111
  br i1 %cmp183, label %for.cond185.preheader, label %if.end209

for.cond185.preheader:                            ; preds = %if.end151.1
  %add192 = add nuw nsw i32 %20, %mul191
  %cmp194 = icmp slt i32 %add192, 127
  %.fneg = select i1 %cmp194, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert734 = insertelement <4 x float> poison, float %.fneg, i64 0
  %cmp194.1 = icmp slt i32 %add192, 126
  %.fneg.1 = select i1 %cmp194.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert743 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert734, float %.fneg.1, i64 1
  %cmp194.2 = icmp slt i32 %add192, 125
  %.fneg.2 = select i1 %cmp194.2, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert752 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert743, float %.fneg.2, i64 2
  %cmp194.3 = icmp slt i32 %add192, 124
  %.fneg.3 = select i1 %cmp194.3, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert761 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert752, float %.fneg.3, i64 3
  br label %if.end209

if.end209:                                        ; preds = %if.end151.1, %for.cond185.preheader, %for.body54
  %V_reg.sroa.11.1 = phi i32 [ %condval_2.sroa.7.0.1, %for.cond185.preheader ], [ %V_reg.sroa.11.0, %for.body54 ], [ %condval_2.sroa.7.0.1, %if.end151.1 ]
  %V_reg.sroa.10.1 = phi i32 [ %condval_2.sroa.6.0.1, %for.cond185.preheader ], [ %V_reg.sroa.10.0, %for.body54 ], [ %condval_2.sroa.6.0.1, %if.end151.1 ]
  %V_reg.sroa.9.1 = phi i32 [ %condval_2.sroa.5.0.1, %for.cond185.preheader ], [ %V_reg.sroa.9.0, %for.body54 ], [ %condval_2.sroa.5.0.1, %if.end151.1 ]
  %V_reg.sroa.7.1 = phi i32 [ %condval_2.sroa.0.0.1, %for.cond185.preheader ], [ %V_reg.sroa.7.0, %for.body54 ], [ %condval_2.sroa.0.0.1, %if.end151.1 ]
  %V_reg.sroa.6.1 = phi i32 [ %condval_2.sroa.7.0, %for.cond185.preheader ], [ %V_reg.sroa.6.0, %for.body54 ], [ %condval_2.sroa.7.0, %if.end151.1 ]
  %V_reg.sroa.5.1 = phi i32 [ %condval_2.sroa.6.0, %for.cond185.preheader ], [ %V_reg.sroa.5.0, %for.body54 ], [ %condval_2.sroa.6.0, %if.end151.1 ]
  %V_reg.sroa.4.1 = phi i32 [ %condval_2.sroa.5.0, %for.cond185.preheader ], [ %V_reg.sroa.4.0, %for.body54 ], [ %condval_2.sroa.5.0, %if.end151.1 ]
  %V_reg.sroa.0.1 = phi i32 [ %condval_2.sroa.0.0, %for.cond185.preheader ], [ %V_reg.sroa.0.0, %for.body54 ], [ %condval_2.sroa.0.0, %if.end151.1 ]
  %acc_s.sroa.0.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert761, %for.cond185.preheader ], [ %acc_s.sroa.0.0, %for.body54 ], [ zeroinitializer, %if.end151.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond677, label %for.cond214.preheader, label %if.end324

for.cond214.preheader:                            ; preds = %if.end209
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr231, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr231.sroa_idx, align 8
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.1), !call_argsrelate !81
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %24), !call_argsrelate !81
  %kb.sroa.0.0.copyload728 = load <4 x half>, ptr addrspace(3) %add.ptr231.1, align 16
  %kb.sroa.6.0.copyload729 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr231.1.sroa_idx, align 8
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload728, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %25), !call_argsrelate !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload729, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !call_argsrelate !81
  store i32 %V_reg.sroa.0.1, ptr addrspace(3) %invariant.gep662, align 16, !tbaa !30
  store i32 %V_reg.sroa.4.1, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep662.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.5.1, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep662.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.6.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep662.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.7.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %V_reg.sroa.9.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.10.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.11.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract736 = extractelement <4 x float> %27, i64 0
  %mul288 = fmul contract float %acc_s.sroa.0.0.vec.extract736, 0x3FC2776C60000000
  %28 = tail call contract noundef float @llvm.minnum.f32(float %mul288, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %28, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i611 = fadd contract float %28, %cond.i.i
  %29 = tail call contract float @llvm.exp2.f32(float %add.i.i611)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %29
  %acc_s.sroa.0.0.vec.insert738 = insertelement <4 x float> poison, float %mul.i.i, i64 0
  %acc_s.sroa.0.4.vec.extract745 = extractelement <4 x float> %27, i64 1
  %mul288.1 = fmul contract float %acc_s.sroa.0.4.vec.extract745, 0x3FC2776C60000000
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul288.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %30, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.1 = fadd contract float %30, %cond.i.i.1
  %31 = tail call contract float @llvm.exp2.f32(float %add.i.i611.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %31
  %acc_s.sroa.0.4.vec.insert747 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert738, float %mul.i.i.1, i64 1
  %acc_s.sroa.0.8.vec.extract754 = extractelement <4 x float> %27, i64 2
  %mul288.2 = fmul contract float %acc_s.sroa.0.8.vec.extract754, 0x3FC2776C60000000
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul288.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %32, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.2 = fadd contract float %32, %cond.i.i.2
  %33 = tail call contract float @llvm.exp2.f32(float %add.i.i611.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %33
  %acc_s.sroa.0.8.vec.insert756 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert747, float %mul.i.i.2, i64 2
  %acc_s.sroa.0.12.vec.extract763 = extractelement <4 x float> %27, i64 3
  %mul288.3 = fmul contract float %acc_s.sroa.0.12.vec.extract763, 0x3FC2776C60000000
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul288.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %34, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.3 = fadd contract float %34, %cond.i.i.3
  %35 = tail call contract float @llvm.exp2.f32(float %add.i.i611.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %35
  %acc_s.sroa.0.12.vec.insert765 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert756, float %mul.i.i.3, i64 3
  %add304 = fadd contract float %sum_acc.sroa.0.0, %mul.i.i
  %add304.1 = fadd contract float %sum_acc.sroa.6.0, %mul.i.i.1
  %add304.2 = fadd contract float %sum_acc.sroa.10.0, %mul.i.i.2
  %add304.3 = fadd contract float %sum_acc.sroa.14.0, %mul.i.i.3
  %36 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !102
  %37 = fptrunc float %mul.i.i to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %36), !noalias !102
  %38 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !102
  %39 = fptrunc float %mul.i.i.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %38), !noalias !102
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %37, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %39, i64 1
  %40 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !116
  %41 = fptrunc float %mul.i.i.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %40), !noalias !116
  %42 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !116
  %43 = fptrunc float %mul.i.i.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %42), !noalias !116
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %41, i64 2
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %43, i64 3
  br label %if.end324

if.end324:                                        ; preds = %for.cond214.preheader, %if.end209
  %sum_acc.sroa.0.1 = phi float [ %add304, %for.cond214.preheader ], [ %sum_acc.sroa.0.0, %if.end209 ]
  %sum_acc.sroa.6.1 = phi float [ %add304.1, %for.cond214.preheader ], [ %sum_acc.sroa.6.0, %if.end209 ]
  %sum_acc.sroa.10.1 = phi float [ %add304.2, %for.cond214.preheader ], [ %sum_acc.sroa.10.0, %if.end209 ]
  %sum_acc.sroa.14.1 = phi float [ %add304.3, %for.cond214.preheader ], [ %sum_acc.sroa.14.0, %if.end209 ]
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert765, %for.cond214.preheader ], [ %acc_s.sroa.0.1, %if.end209 ]
  %acc_s_cast.sroa.0.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %for.cond214.preheader ], [ %acc_s_cast.sroa.0.0672, %if.end209 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond677, label %for.cond333.preheader.preheader, label %if.end389

for.cond333.preheader.preheader:                  ; preds = %if.end324
  %44 = load half, ptr addrspace(3) %gep666, align 2, !tbaa !133
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %44, i64 0
  %45 = load half, ptr addrspace(3) %gep666.1, align 2, !tbaa !133
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %45, i64 1
  %46 = load half, ptr addrspace(3) %gep666.2, align 2, !tbaa !133
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %46, i64 2
  %47 = load half, ptr addrspace(3) %gep666.3, align 2, !tbaa !133
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %47, i64 3
  %48 = load half, ptr addrspace(3) %gep666.1702, align 2, !tbaa !133
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %48, i64 0
  %49 = load half, ptr addrspace(3) %gep666.1.1, align 2, !tbaa !133
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %49, i64 1
  %50 = load half, ptr addrspace(3) %gep666.2.1, align 2, !tbaa !133
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %50, i64 2
  %51 = load half, ptr addrspace(3) %gep666.3.1, align 2, !tbaa !133
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %51, i64 3
  %52 = load half, ptr addrspace(3) %gep666.2708, align 2, !tbaa !133
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %52, i64 0
  %53 = load half, ptr addrspace(3) %gep666.1.2, align 2, !tbaa !133
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %53, i64 1
  %54 = load half, ptr addrspace(3) %gep666.2.2, align 2, !tbaa !133
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %54, i64 2
  %55 = load half, ptr addrspace(3) %gep666.3.2, align 2, !tbaa !133
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %55, i64 3
  %56 = load half, ptr addrspace(3) %gep666.3714, align 2, !tbaa !133
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %56, i64 0
  %57 = load half, ptr addrspace(3) %gep666.1.3, align 2, !tbaa !133
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %57, i64 1
  %58 = load half, ptr addrspace(3) %gep666.2.3, align 2, !tbaa !133
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %58, i64 2
  %59 = load half, ptr addrspace(3) %gep666.3.3, align 2, !tbaa !133
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %59, i64 3
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.0.0)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.20.0)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.38.0)
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.56.0)
  br label %if.end389

if.end389:                                        ; preds = %for.cond333.preheader.preheader, %if.end324
  %acc_o.sroa.0.1 = phi <4 x float> [ %60, %for.cond333.preheader.preheader ], [ %acc_o.sroa.0.0, %if.end324 ]
  %acc_o.sroa.20.1 = phi <4 x float> [ %61, %for.cond333.preheader.preheader ], [ %acc_o.sroa.20.0, %if.end324 ]
  %acc_o.sroa.38.1 = phi <4 x float> [ %62, %for.cond333.preheader.preheader ], [ %acc_o.sroa.38.0, %if.end324 ]
  %acc_o.sroa.56.1 = phi <4 x float> [ %63, %for.cond333.preheader.preheader ], [ %acc_o.sroa.56.0, %if.end324 ]
  %inc391 = or disjoint i32 %s.0671, 1
  %arrayidx56.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %indices, i32 0, i32 %inc391
  %64 = load i32, ptr addrspace(5) %arrayidx56.1, align 4, !tbaa !30
  %or.cond677.1 = icmp ult i32 %64, 127
  br i1 %or.cond677.1, label %for.cond61.preheader.1, label %if.end209.1

for.cond61.preheader.1:                           ; preds = %if.end389
  %add68.1 = add nuw nsw i32 %64, %shr67
  %mul73.1 = shl nuw nsw i32 %64, 6
  %add74.1 = add nuw nsw i32 %mul73.1, %mul76
  %65 = zext nneg i32 %add74.1 to i64
  %cmp70.1856 = icmp slt i32 %add68.1, 127
  br i1 %cmp70.1856, label %if.then71.1865, label %if.end101.1870

if.then71.1865:                                   ; preds = %for.cond61.preheader.1
  %add.ptr79.1857 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %65
  %condval_1.sroa.7.0.add.ptr79.sroa_idx.1858 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr79.1857, i64 12
  %condval_1.sroa.6.0.add.ptr79.sroa_idx.1859 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr79.1857, i64 8
  %condval_1.sroa.5.0.add.ptr79.sroa_idx.1860 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr79.1857, i64 4
  %condval_1.sroa.0.0.copyload.1861 = load i32, ptr addrspace(4) %add.ptr79.1857, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.1862 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr79.sroa_idx.1860, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.1863 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr79.sroa_idx.1859, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.1864 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr79.sroa_idx.1858, align 4, !tbaa !30
  br label %if.end101.1870

if.end101.1870:                                   ; preds = %if.then71.1865, %for.cond61.preheader.1
  %condval_1.sroa.0.0.1866 = phi i32 [ %condval_1.sroa.0.0.copyload.1861, %if.then71.1865 ], [ 0, %for.cond61.preheader.1 ]
  %condval_1.sroa.5.0.1867 = phi i32 [ %condval_1.sroa.5.0.copyload.1862, %if.then71.1865 ], [ 0, %for.cond61.preheader.1 ]
  %condval_1.sroa.6.0.1868 = phi i32 [ %condval_1.sroa.6.0.copyload.1863, %if.then71.1865 ], [ 0, %for.cond61.preheader.1 ]
  %condval_1.sroa.7.0.1869 = phi i32 [ %condval_1.sroa.7.0.copyload.1864, %if.then71.1865 ], [ 0, %for.cond61.preheader.1 ]
  %cmp70.1.1 = icmp slt i32 %add68.1, 119
  br i1 %cmp70.1.1, label %if.then71.1.1, label %if.end101.1.1

if.then71.1.1:                                    ; preds = %if.end101.1870
  %66 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %65
  %add.ptr79.1.1 = getelementptr inbounds i8, ptr addrspace(4) %66, i64 1024
  %condval_1.sroa.7.0.add.ptr79.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %66, i64 1036
  %condval_1.sroa.6.0.add.ptr79.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %66, i64 1032
  %condval_1.sroa.5.0.add.ptr79.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %66, i64 1028
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr79.1.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr79.sroa_idx.1.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr79.sroa_idx.1.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr79.sroa_idx.1.1, align 4, !tbaa !30
  br label %if.end101.1.1

if.end101.1.1:                                    ; preds = %if.then71.1.1, %if.end101.1870
  %condval_1.sroa.0.0.1.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1.1, %if.then71.1.1 ], [ 0, %if.end101.1870 ]
  %condval_1.sroa.5.0.1.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1.1, %if.then71.1.1 ], [ 0, %if.end101.1870 ]
  %condval_1.sroa.6.0.1.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1.1, %if.then71.1.1 ], [ 0, %if.end101.1870 ]
  %condval_1.sroa.7.0.1.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1.1, %if.then71.1.1 ], [ 0, %if.end101.1870 ]
  br i1 %cmp70.1856, label %if.then119.1879, label %if.end151.1884

if.then119.1879:                                  ; preds = %if.end101.1.1
  %add.ptr127.1871 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %65
  %condval_2.sroa.7.0.add.ptr127.sroa_idx.1872 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr127.1871, i64 12
  %condval_2.sroa.6.0.add.ptr127.sroa_idx.1873 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr127.1871, i64 8
  %condval_2.sroa.5.0.add.ptr127.sroa_idx.1874 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr127.1871, i64 4
  %condval_2.sroa.0.0.copyload.1875 = load i32, ptr addrspace(4) %add.ptr127.1871, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload.1876 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr127.sroa_idx.1874, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload.1877 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr127.sroa_idx.1873, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload.1878 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr127.sroa_idx.1872, align 4, !tbaa !30
  br label %if.end151.1884

if.end151.1884:                                   ; preds = %if.then119.1879, %if.end101.1.1
  %condval_2.sroa.0.0.1880 = phi i32 [ %condval_2.sroa.0.0.copyload.1875, %if.then119.1879 ], [ 0, %if.end101.1.1 ]
  %condval_2.sroa.5.0.1881 = phi i32 [ %condval_2.sroa.5.0.copyload.1876, %if.then119.1879 ], [ 0, %if.end101.1.1 ]
  %condval_2.sroa.6.0.1882 = phi i32 [ %condval_2.sroa.6.0.copyload.1877, %if.then119.1879 ], [ 0, %if.end101.1.1 ]
  %condval_2.sroa.7.0.1883 = phi i32 [ %condval_2.sroa.7.0.copyload.1878, %if.then119.1879 ], [ 0, %if.end101.1.1 ]
  br i1 %cmp70.1.1, label %if.then119.1.1, label %if.end151.1.1

if.then119.1.1:                                   ; preds = %if.end151.1884
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %65
  %add.ptr127.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1024
  %condval_2.sroa.7.0.add.ptr127.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1036
  %condval_2.sroa.6.0.add.ptr127.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1032
  %condval_2.sroa.5.0.add.ptr127.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1028
  %condval_2.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr127.1.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr127.sroa_idx.1.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr127.sroa_idx.1.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr127.sroa_idx.1.1, align 4, !tbaa !30
  br label %if.end151.1.1

if.end151.1.1:                                    ; preds = %if.then119.1.1, %if.end151.1884
  %condval_2.sroa.0.0.1.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1.1, %if.then119.1.1 ], [ 0, %if.end151.1884 ]
  %condval_2.sroa.5.0.1.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1.1, %if.then119.1.1 ], [ 0, %if.end151.1884 ]
  %condval_2.sroa.6.0.1.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1.1, %if.then119.1.1 ], [ 0, %if.end151.1884 ]
  %condval_2.sroa.7.0.1.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1.1, %if.then119.1.1 ], [ 0, %if.end151.1884 ]
  store i32 %condval_1.sroa.0.0.1866, ptr addrspace(3) %invariant.gep650, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0.1867, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0.1868, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep650.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0.1869, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.0.0.1.1, ptr addrspace(3) %gep651.1, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0.1.1, ptr addrspace(3) %K_reg.sroa.9.16.gep651.1.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0.1.1, ptr addrspace(3) %K_reg.sroa.10.16.gep651.1.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0.1.1, ptr addrspace(3) %K_reg.sroa.11.16.gep651.1.sroa_idx, align 4, !tbaa !30
  %cmp183.1 = icmp sgt i32 %64, 111
  br i1 %cmp183.1, label %for.cond185.preheader.1, label %if.end209.1

for.cond185.preheader.1:                          ; preds = %if.end151.1.1
  %add192.1 = add nuw nsw i32 %64, %mul191
  %cmp194.1885 = icmp slt i32 %add192.1, 127
  %.fneg.1886 = select i1 %cmp194.1885, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert734.1 = insertelement <4 x float> poison, float %.fneg.1886, i64 0
  %cmp194.1.1 = icmp slt i32 %add192.1, 126
  %.fneg.1.1 = select i1 %cmp194.1.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert743.1 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert734.1, float %.fneg.1.1, i64 1
  %cmp194.2.1 = icmp slt i32 %add192.1, 125
  %.fneg.2.1 = select i1 %cmp194.2.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert752.1 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert743.1, float %.fneg.2.1, i64 2
  %cmp194.3.1 = icmp slt i32 %add192.1, 124
  %.fneg.3.1 = select i1 %cmp194.3.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert761.1 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert752.1, float %.fneg.3.1, i64 3
  br label %if.end209.1

if.end209.1:                                      ; preds = %for.cond185.preheader.1, %if.end151.1.1, %if.end389
  %V_reg.sroa.11.1.1 = phi i32 [ %condval_2.sroa.7.0.1.1, %for.cond185.preheader.1 ], [ %V_reg.sroa.11.1, %if.end389 ], [ %condval_2.sroa.7.0.1.1, %if.end151.1.1 ]
  %V_reg.sroa.10.1.1 = phi i32 [ %condval_2.sroa.6.0.1.1, %for.cond185.preheader.1 ], [ %V_reg.sroa.10.1, %if.end389 ], [ %condval_2.sroa.6.0.1.1, %if.end151.1.1 ]
  %V_reg.sroa.9.1.1 = phi i32 [ %condval_2.sroa.5.0.1.1, %for.cond185.preheader.1 ], [ %V_reg.sroa.9.1, %if.end389 ], [ %condval_2.sroa.5.0.1.1, %if.end151.1.1 ]
  %V_reg.sroa.7.1.1 = phi i32 [ %condval_2.sroa.0.0.1.1, %for.cond185.preheader.1 ], [ %V_reg.sroa.7.1, %if.end389 ], [ %condval_2.sroa.0.0.1.1, %if.end151.1.1 ]
  %V_reg.sroa.6.1.1 = phi i32 [ %condval_2.sroa.7.0.1883, %for.cond185.preheader.1 ], [ %V_reg.sroa.6.1, %if.end389 ], [ %condval_2.sroa.7.0.1883, %if.end151.1.1 ]
  %V_reg.sroa.5.1.1 = phi i32 [ %condval_2.sroa.6.0.1882, %for.cond185.preheader.1 ], [ %V_reg.sroa.5.1, %if.end389 ], [ %condval_2.sroa.6.0.1882, %if.end151.1.1 ]
  %V_reg.sroa.4.1.1 = phi i32 [ %condval_2.sroa.5.0.1881, %for.cond185.preheader.1 ], [ %V_reg.sroa.4.1, %if.end389 ], [ %condval_2.sroa.5.0.1881, %if.end151.1.1 ]
  %V_reg.sroa.0.1.1 = phi i32 [ %condval_2.sroa.0.0.1880, %for.cond185.preheader.1 ], [ %V_reg.sroa.0.1, %if.end389 ], [ %condval_2.sroa.0.0.1880, %if.end151.1.1 ]
  %acc_s.sroa.0.1.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert761.1, %for.cond185.preheader.1 ], [ %acc_s.sroa.0.2, %if.end389 ], [ zeroinitializer, %if.end151.1.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond677.1, label %for.cond214.preheader.1, label %if.end324.1

for.cond214.preheader.1:                          ; preds = %if.end209.1
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr231, align 16
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr231.sroa_idx, align 8
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.1.1), !call_argsrelate !81
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %68), !call_argsrelate !81
  %kb.sroa.0.0.copyload728.1 = load <4 x half>, ptr addrspace(3) %add.ptr231.1, align 16
  %kb.sroa.6.0.copyload729.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr231.1.sroa_idx, align 8
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload728.1, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %69), !call_argsrelate !81
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload729.1, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %70), !call_argsrelate !81
  store i32 %V_reg.sroa.0.1.1, ptr addrspace(3) %invariant.gep662, align 16, !tbaa !30
  store i32 %V_reg.sroa.4.1.1, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep662.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.5.1.1, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep662.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.6.1.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep662.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.7.1.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %V_reg.sroa.9.1.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.10.1.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.11.1.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract736.1 = extractelement <4 x float> %71, i64 0
  %mul288.1887 = fmul contract float %acc_s.sroa.0.0.vec.extract736.1, 0x3FC2776C60000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul288.1887, float 1.500000e+01)
  %cmp.i.i.1888 = fcmp contract olt float %72, -1.260000e+02
  %cond.i.i.1889 = select contract i1 %cmp.i.i.1888, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.1890 = fadd contract float %72, %cond.i.i.1889
  %73 = tail call contract float @llvm.exp2.f32(float %add.i.i611.1890)
  %cond2.i.i.1891 = select contract i1 %cmp.i.i.1888, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1892 = fmul contract float %cond2.i.i.1891, %73
  %acc_s.sroa.0.0.vec.insert738.1 = insertelement <4 x float> poison, float %mul.i.i.1892, i64 0
  %acc_s.sroa.0.4.vec.extract745.1 = extractelement <4 x float> %71, i64 1
  %mul288.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract745.1, 0x3FC2776C60000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul288.1.1, float 1.500000e+01)
  %cmp.i.i.1.1 = fcmp contract olt float %74, -1.260000e+02
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.1.1 = fadd contract float %74, %cond.i.i.1.1
  %75 = tail call contract float @llvm.exp2.f32(float %add.i.i611.1.1)
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %75
  %acc_s.sroa.0.4.vec.insert747.1 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert738.1, float %mul.i.i.1.1, i64 1
  %acc_s.sroa.0.8.vec.extract754.1 = extractelement <4 x float> %71, i64 2
  %mul288.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract754.1, 0x3FC2776C60000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul288.2.1, float 1.500000e+01)
  %cmp.i.i.2.1 = fcmp contract olt float %76, -1.260000e+02
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.2.1 = fadd contract float %76, %cond.i.i.2.1
  %77 = tail call contract float @llvm.exp2.f32(float %add.i.i611.2.1)
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %77
  %acc_s.sroa.0.8.vec.insert756.1 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert747.1, float %mul.i.i.2.1, i64 2
  %acc_s.sroa.0.12.vec.extract763.1 = extractelement <4 x float> %71, i64 3
  %mul288.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract763.1, 0x3FC2776C60000000
  %78 = tail call contract noundef float @llvm.minnum.f32(float %mul288.3.1, float 1.500000e+01)
  %cmp.i.i.3.1 = fcmp contract olt float %78, -1.260000e+02
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.3.1 = fadd contract float %78, %cond.i.i.3.1
  %79 = tail call contract float @llvm.exp2.f32(float %add.i.i611.3.1)
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %79
  %acc_s.sroa.0.12.vec.insert765.1 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert756.1, float %mul.i.i.3.1, i64 3
  %add304.1893 = fadd contract float %sum_acc.sroa.0.1, %mul.i.i.1892
  %add304.1.1 = fadd contract float %sum_acc.sroa.6.1, %mul.i.i.1.1
  %add304.2.1 = fadd contract float %sum_acc.sroa.10.1, %mul.i.i.2.1
  %add304.3.1 = fadd contract float %sum_acc.sroa.14.1, %mul.i.i.3.1
  %80 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !102
  %81 = fptrunc float %mul.i.i.1892 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %80), !noalias !102
  %82 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !102
  %83 = fptrunc float %mul.i.i.1.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %82), !noalias !102
  %__1.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %81, i64 0
  %__1.sroa.0.2.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.0.vec.insert.1, half %83, i64 1
  %84 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !116
  %85 = fptrunc float %mul.i.i.2.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %84), !noalias !116
  %86 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !116
  %87 = fptrunc float %mul.i.i.3.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %86), !noalias !116
  %__1.sroa.0.4.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.2.vec.insert.1, half %85, i64 2
  %__1.sroa.0.6.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.4.vec.insert.1, half %87, i64 3
  br label %if.end324.1

if.end324.1:                                      ; preds = %for.cond214.preheader.1, %if.end209.1
  %sum_acc.sroa.0.1.1 = phi float [ %add304.1893, %for.cond214.preheader.1 ], [ %sum_acc.sroa.0.1, %if.end209.1 ]
  %sum_acc.sroa.6.1.1 = phi float [ %add304.1.1, %for.cond214.preheader.1 ], [ %sum_acc.sroa.6.1, %if.end209.1 ]
  %sum_acc.sroa.10.1.1 = phi float [ %add304.2.1, %for.cond214.preheader.1 ], [ %sum_acc.sroa.10.1, %if.end209.1 ]
  %sum_acc.sroa.14.1.1 = phi float [ %add304.3.1, %for.cond214.preheader.1 ], [ %sum_acc.sroa.14.1, %if.end209.1 ]
  %acc_s.sroa.0.2.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert765.1, %for.cond214.preheader.1 ], [ %acc_s.sroa.0.1.1, %if.end209.1 ]
  %acc_s_cast.sroa.0.1.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert.1, %for.cond214.preheader.1 ], [ %acc_s_cast.sroa.0.1, %if.end209.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond677.1, label %for.cond333.preheader.preheader.1, label %if.end389.1

for.cond333.preheader.preheader.1:                ; preds = %if.end324.1
  %88 = load half, ptr addrspace(3) %gep666, align 2, !tbaa !133
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %88, i64 0
  %89 = load half, ptr addrspace(3) %gep666.1, align 2, !tbaa !133
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %89, i64 1
  %90 = load half, ptr addrspace(3) %gep666.2, align 2, !tbaa !133
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %90, i64 2
  %91 = load half, ptr addrspace(3) %gep666.3, align 2, !tbaa !133
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %91, i64 3
  %92 = load half, ptr addrspace(3) %gep666.1702, align 2, !tbaa !133
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %92, i64 0
  %93 = load half, ptr addrspace(3) %gep666.1.1, align 2, !tbaa !133
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %93, i64 1
  %94 = load half, ptr addrspace(3) %gep666.2.1, align 2, !tbaa !133
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %94, i64 2
  %95 = load half, ptr addrspace(3) %gep666.3.1, align 2, !tbaa !133
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %95, i64 3
  %96 = load half, ptr addrspace(3) %gep666.2708, align 2, !tbaa !133
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %96, i64 0
  %97 = load half, ptr addrspace(3) %gep666.1.2, align 2, !tbaa !133
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %97, i64 1
  %98 = load half, ptr addrspace(3) %gep666.2.2, align 2, !tbaa !133
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %98, i64 2
  %99 = load half, ptr addrspace(3) %gep666.3.2, align 2, !tbaa !133
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %99, i64 3
  %100 = load half, ptr addrspace(3) %gep666.3714, align 2, !tbaa !133
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %100, i64 0
  %101 = load half, ptr addrspace(3) %gep666.1.3, align 2, !tbaa !133
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %101, i64 1
  %102 = load half, ptr addrspace(3) %gep666.2.3, align 2, !tbaa !133
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %102, i64 2
  %103 = load half, ptr addrspace(3) %gep666.3.3, align 2, !tbaa !133
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %103, i64 3
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.0.1)
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.20.1)
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.38.1)
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.56.1)
  br label %if.end389.1

if.end389.1:                                      ; preds = %for.cond333.preheader.preheader.1, %if.end324.1
  %acc_o.sroa.0.1.1 = phi <4 x float> [ %104, %for.cond333.preheader.preheader.1 ], [ %acc_o.sroa.0.1, %if.end324.1 ]
  %acc_o.sroa.20.1.1 = phi <4 x float> [ %105, %for.cond333.preheader.preheader.1 ], [ %acc_o.sroa.20.1, %if.end324.1 ]
  %acc_o.sroa.38.1.1 = phi <4 x float> [ %106, %for.cond333.preheader.preheader.1 ], [ %acc_o.sroa.38.1, %if.end324.1 ]
  %acc_o.sroa.56.1.1 = phi <4 x float> [ %107, %for.cond333.preheader.preheader.1 ], [ %acc_o.sroa.56.1, %if.end324.1 ]
  %inc391.1 = add nuw nsw i32 %s.0671, 2
  %exitcond.not.1 = icmp eq i32 %inc391.1, 4
  br i1 %exitcond.not.1, label %for.body397.preheader, label %for.body54, !llvm.loop !137

for.body397.preheader:                            ; preds = %if.end389.1
  %add401 = fadd contract float %sum_acc.sroa.0.1.1, 0.000000e+00
  %add401.1 = fadd contract float %add401, %sum_acc.sroa.6.1.1
  %add401.2 = fadd contract float %add401.1, %sum_acc.sroa.10.1.1
  %add401.3 = fadd contract float %add401.2, %sum_acc.sroa.14.1.1
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %108 = bitcast float %add401.3 to i32
  %109 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12
  %110 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %109) #12
  %xor.i.i = xor i32 %110, 32
  %111 = and i32 %110, -64
  %and.i.i = add nsw i32 %111, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i613 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %110
  %shl.i.i = shl i32 %cond.i.i613, 2
  %112 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %108)
  %113 = bitcast i32 %112 to float
  %add.i = fadd contract float %add401.3, %113
  %114 = bitcast float %add.i to i32
  %115 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12
  %116 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %115) #12
  %xor.i.i614 = xor i32 %116, 16
  %117 = and i32 %116, -64
  %and.i.i615 = add nsw i32 %117, 64
  %cmp.not.i.i616 = icmp slt i32 %xor.i.i614, %and.i.i615
  %cond.i.i617 = select i1 %cmp.not.i.i616, i32 %xor.i.i614, i32 %116
  %shl.i.i618 = shl i32 %cond.i.i617, 2
  %118 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i618, i32 %114)
  %119 = bitcast i32 %118 to float
  %add.i.i = fadd contract float %add.i, %119
  %cmp410 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp410, float %div, float 0.000000e+00
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 0
  %mul423 = fmul contract float %condval_4.0, %acc_o.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 1
  %mul423.1 = fmul contract float %condval_4.0, %acc_o.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 2
  %mul423.2 = fmul contract float %condval_4.0, %acc_o.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 3
  %mul423.3 = fmul contract float %condval_4.0, %acc_o.sroa.0.12.vec.extract
  %acc_o.sroa.20.16.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 0
  %mul423.4 = fmul contract float %condval_4.0, %acc_o.sroa.20.16.vec.extract
  %acc_o.sroa.20.20.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 1
  %mul423.5 = fmul contract float %condval_4.0, %acc_o.sroa.20.20.vec.extract
  %acc_o.sroa.20.24.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 2
  %mul423.6 = fmul contract float %condval_4.0, %acc_o.sroa.20.24.vec.extract
  %acc_o.sroa.20.28.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 3
  %mul423.7 = fmul contract float %condval_4.0, %acc_o.sroa.20.28.vec.extract
  %acc_o.sroa.38.32.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 0
  %mul423.8 = fmul contract float %condval_4.0, %acc_o.sroa.38.32.vec.extract
  %acc_o.sroa.38.36.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 1
  %mul423.9 = fmul contract float %condval_4.0, %acc_o.sroa.38.36.vec.extract
  %acc_o.sroa.38.40.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 2
  %mul423.10 = fmul contract float %condval_4.0, %acc_o.sroa.38.40.vec.extract
  %acc_o.sroa.38.44.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 3
  %mul423.11 = fmul contract float %condval_4.0, %acc_o.sroa.38.44.vec.extract
  %acc_o.sroa.56.48.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 0
  %mul423.12 = fmul contract float %condval_4.0, %acc_o.sroa.56.48.vec.extract
  %acc_o.sroa.56.52.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 1
  %mul423.13 = fmul contract float %condval_4.0, %acc_o.sroa.56.52.vec.extract
  %acc_o.sroa.56.56.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 2
  %mul423.14 = fmul contract float %condval_4.0, %acc_o.sroa.56.56.vec.extract
  %acc_o.sroa.56.60.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 3
  %mul423.15 = fmul contract float %condval_4.0, %acc_o.sroa.56.60.vec.extract
  %add458 = add nuw nsw i32 %add20, %mul191
  %120 = zext nneg i32 %add458 to i64
  %121 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %122 = fptrunc float %mul423 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %121), !noalias !202
  %123 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %124 = fptrunc float %mul423.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %123), !noalias !202
  %125 = bitcast half %122 to i16
  %126 = bitcast half %124 to i16
  %127 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %128 = fptrunc float %mul423.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %127), !noalias !217
  %129 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %130 = fptrunc float %mul423.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %129), !noalias !217
  %131 = bitcast half %128 to i16
  %132 = bitcast half %130 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %132 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %131 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %126 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %125 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr464 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %120
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr464, align 8
  %133 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %134 = fptrunc float %mul423.4 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %133), !noalias !202
  %135 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %136 = fptrunc float %mul423.5 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %135), !noalias !202
  %137 = bitcast half %134 to i16
  %138 = bitcast half %136 to i16
  %139 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %140 = fptrunc float %mul423.6 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %139), !noalias !217
  %141 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %142 = fptrunc float %mul423.7 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %141), !noalias !217
  %143 = bitcast half %140 to i16
  %144 = bitcast half %142 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %144 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %143 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %138 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %137 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %145 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %120
  %add.ptr464.1 = getelementptr inbounds i8, ptr addrspace(1) %145, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr464.1, align 8
  %146 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %147 = fptrunc float %mul423.8 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %146), !noalias !202
  %148 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %149 = fptrunc float %mul423.9 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %148), !noalias !202
  %150 = bitcast half %147 to i16
  %151 = bitcast half %149 to i16
  %152 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %153 = fptrunc float %mul423.10 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %152), !noalias !217
  %154 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %155 = fptrunc float %mul423.11 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %154), !noalias !217
  %156 = bitcast half %153 to i16
  %157 = bitcast half %155 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %157 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %156 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %151 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %150 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %120
  %add.ptr464.2 = getelementptr inbounds i8, ptr addrspace(1) %158, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr464.2, align 8
  %159 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %160 = fptrunc float %mul423.12 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %159), !noalias !202
  %161 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !202
  %162 = fptrunc float %mul423.13 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %161), !noalias !202
  %163 = bitcast half %160 to i16
  %164 = bitcast half %162 to i16
  %165 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %166 = fptrunc float %mul423.14 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %165), !noalias !217
  %167 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !217
  %168 = fptrunc float %mul423.15 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %167), !noalias !217
  %169 = bitcast half %166 to i16
  %170 = bitcast half %168 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %170 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %169 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %164 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %163 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %171 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %120
  %add.ptr464.3 = getelementptr inbounds i8, ptr addrspace(1) %171, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr464.3, align 8
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %indices) #11
  ret void
}

declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

declare i32 @llvm.mxc.block.id.x() #6

declare i32 @llvm.mxc.block.id.y() #6

declare i32 @llvm.mxc.block.id.z() #6

declare i32 @llvm.mxc.thread.id.x() #6

declare void @llvm.mxc.barrier() #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #5

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #6

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #6

declare i1 @llvm.mxc.is.private(ptr nocapture) #6

declare void @llvm.mxc.sleep(i32 immarg) #8

declare float @llvm.exp2.f32(float) #9

declare i32 @llvm.mxc.gethwreg(i32 immarg) #10

declare void @llvm.mxc.sethwreg(i32 immarg, i32) #8

declare float @llvm.minnum.f32(float, float) #9

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent nounwind willreturn memory(none) }
attributes #6 = { nounwind speculatable willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #11 = { nounwind }
attributes #12 = { nomerge }


