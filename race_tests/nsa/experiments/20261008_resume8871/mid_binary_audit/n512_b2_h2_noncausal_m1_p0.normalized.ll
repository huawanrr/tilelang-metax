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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %1 = shl nuw nsw i32 %0, 19
  %mul = and i32 %1, 2146435072
  %2 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %2, 11
  %and = shl i32 %0, 10
  %mul9 = and i32 %and, 1024
  %3 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul14 = shl nuw nsw i32 %3, 3
  %add = add nuw nsw i32 %mul14, %mul7
  %add10 = add nuw nsw i32 %add, %mul
  %add12 = add nuw nsw i32 %add10, %mul9
  %4 = zext nneg i32 %add12 to i64
  %5 = add nuw nsw i64 %4, 512
  %6 = shl nuw nsw i32 %0, 9
  %mul21 = and i32 %6, 2147482624
  %mul23 = shl nuw nsw i32 %2, 1
  %add24 = add nuw nsw i32 %mul21, %mul23
  %and26 = and i32 %0, 1
  %add27 = or disjoint i32 %add24, %and26
  %idxprom = zext nneg i32 %add27 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp42 = icmp ult i32 %7, 32
  br i1 %cmp42, label %for.cond45.preheader, label %if.end336

for.cond45.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %8 = shl nuw nsw i32 %0, 15
  %mul56 = and i32 %8, 2147418112
  %mul57 = shl nuw nsw i32 %7, 11
  %9 = shl nuw nsw i32 %3, 4
  %mul63 = and i32 %9, 16256
  %and66 = shl i32 %0, 6
  %mul67 = and i32 %and66, 64
  %mul71 = and i32 %mul14, 56
  %add58 = or disjoint i32 %mul63, %mul56
  %add60 = or disjoint i32 %add58, %mul67
  %add64 = or disjoint i32 %add60, %mul71
  %add68 = add nuw nsw i32 %add64, %mul57
  %10 = zext nneg i32 %add68 to i64
  %add.ptr76 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr76, align 4, !tbaa !30
  %12 = or disjoint i64 %10, 2
  %add.ptr76.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr76.1, align 4, !tbaa !30
  %14 = or disjoint i64 %10, 4
  %add.ptr76.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr76.2, align 4, !tbaa !30
  %16 = or disjoint i64 %10, 6
  %add.ptr76.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr76.3, align 4, !tbaa !30
  %18 = add nuw nsw i64 %10, 1024
  %add.ptr76.1652 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr76.1652, align 4, !tbaa !30
  %20 = add nuw nsw i64 %10, 1026
  %add.ptr76.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr76.1.1, align 4, !tbaa !30
  %22 = add nuw nsw i64 %10, 1028
  %add.ptr76.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr76.2.1, align 4, !tbaa !30
  %24 = add nuw nsw i64 %10, 1030
  %add.ptr76.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr76.3.1, align 4, !tbaa !30
  %add.ptr119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %26 = load i32, ptr addrspace(4) %add.ptr119, align 4, !tbaa !30
  %add.ptr119.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %27 = load i32, ptr addrspace(4) %add.ptr119.1, align 4, !tbaa !30
  %add.ptr119.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %28 = load i32, ptr addrspace(4) %add.ptr119.2, align 4, !tbaa !30
  %add.ptr119.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %29 = load i32, ptr addrspace(4) %add.ptr119.3, align 4, !tbaa !30
  %add.ptr119.1664 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %30 = load i32, ptr addrspace(4) %add.ptr119.1664, align 4, !tbaa !30
  %add.ptr119.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %31 = load i32, ptr addrspace(4) %add.ptr119.1.1, align 4, !tbaa !30
  %add.ptr119.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %32 = load i32, ptr addrspace(4) %add.ptr119.2.1, align 4, !tbaa !30
  %add.ptr119.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %33 = load i32, ptr addrspace(4) %add.ptr119.3.1, align 4, !tbaa !30
  %mul143 = and i32 %mul14, 8128
  %call147.masked = and i32 %3, 1016
  %mul149 = xor i32 %mul71, %call147.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul143
  %invariant.gep605 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul149
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep605, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !61
  %gep606.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep606.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !61
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and161 = shl nuw nsw i32 %3, 6
  %mul162 = and i32 %and161, 960
  %shr165 = lshr i32 %3, 4
  %and168 = and i32 %3, 7
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul162
  %xor169 = xor i32 %shr165, %and168
  %add.ptr173.idx = shl nuw nsw i32 %xor169, 4
  %add.ptr173 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr173.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173, align 16
  %Q_reg.sroa.4.0.add.ptr173.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr173.sroa_idx, align 8
  %add166.1 = add nuw nsw i32 %shr165, 4
  %xor169.1 = xor i32 %add166.1, %and168
  %add.ptr173.idx.1 = shl nuw nsw i32 %xor169.1, 4
  %add.ptr173.1 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr173.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173.1, align 16
  %Q_reg.sroa.7.16.add.ptr173.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr173.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %11, ptr addrspace(3) %invariant.gep605, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep610.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 4
  store i32 %13, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep610.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep610.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 8
  store i32 %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep610.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep610.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 12
  store i32 %17, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep610.sroa_idx, align 4, !tbaa !30
  store i32 %19, ptr addrspace(3) %gep606.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep611.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1028
  store i32 %21, ptr addrspace(3) %K_reg.sroa.9.16.gep611.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep611.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1032
  store i32 %23, ptr addrspace(3) %K_reg.sroa.10.16.gep611.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep611.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1036
  store i32 %25, ptr addrspace(3) %K_reg.sroa.11.16.gep611.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr173.sroa_idx, align 8
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %35)
  %kb.sroa.0.0.copyload694 = load <4 x half>, ptr addrspace(3) %add.ptr173.1, align 16
  %kb.sroa.6.0.copyload695 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr173.1.sroa_idx, align 8
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload694, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %36)
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload695, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %37)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %invariant.gep618 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %9
  store i32 %26, ptr addrspace(3) %invariant.gep618, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 4
  store i32 %27, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep618.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 8
  store i32 %28, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep618.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 12
  store i32 %29, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep618.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1024
  store i32 %30, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1028
  store i32 %31, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1032
  store i32 %32, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1036
  store i32 %33, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0
  %mul275 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul275, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1
  %mul275.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul275.1, float 0x4024CB5EC0000000)
  %42 = tail call contract noundef float @llvm.exp.f32(float %41)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2
  %mul275.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul275.2, float 0x4024CB5EC0000000)
  %44 = tail call contract noundef float @llvm.exp.f32(float %43)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3
  %mul275.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul275.3, float 0x4024CB5EC0000000)
  %46 = tail call contract noundef float @llvm.exp.f32(float %45)
  %add291.1 = fadd contract float %40, %42
  %add291.2 = fadd contract float %add291.1, %44
  %add291.3 = fadd contract float %add291.2, %46
  %47 = bitcast float %add291.3 to i32
  %48 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %49 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %48) #11
  %xor.i.i = xor i32 %49, 32
  %50 = and i32 %49, -64
  %and.i.i = add nsw i32 %50, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %49
  %shl.i.i = shl i32 %cond.i.i, 2
  %51 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %47)
  %52 = bitcast i32 %51 to float
  %add299 = fadd contract float %add291.3, %52
  %53 = bitcast float %add299 to i32
  %54 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %55 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %54) #11
  %xor.i.i592 = xor i32 %55, 16
  %56 = and i32 %55, -64
  %and.i.i593 = add nsw i32 %56, 64
  %cmp.not.i.i594 = icmp slt i32 %xor.i.i592, %and.i.i593
  %cond.i.i595 = select i1 %cmp.not.i.i594, i32 %xor.i.i592, i32 %55
  %shl.i.i596 = shl i32 %cond.i.i595, 2
  %57 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i596, i32 %53)
  %58 = bitcast i32 %57 to float
  %add304 = fadd contract float %add299, %58
  %cmp307 = fcmp contract ogt float %add304, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add304
  %condval.0 = select i1 %cmp307, float %div, float 0.000000e+00
  %mul318 = fmul contract float %condval.0, %40
  %mul318.1 = fmul contract float %condval.0, %42
  %mul318.2 = fmul contract float %condval.0, %44
  %mul318.3 = fmul contract float %condval.0, %46
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318)
  %60 = insertelement <4 x i16> poison, i16 %59, i64 0
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318.1)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 1
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318.2)
  %64 = insertelement <4 x i16> %62, i16 %63, i64 2
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318.3)
  %66 = insertelement <4 x i16> %64, i16 %65, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %66 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end336

if.end336:                                        ; preds = %for.cond45.preheader, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %for.cond45.preheader ], [ undef, %entry ]
  br i1 %cmp42, label %for.cond354.preheader, label %if.end402

for.cond354.preheader:                            ; preds = %if.end336
  %67 = shl nuw nsw i32 %3, 4
  %mul364 = and i32 %67, 16128
  %and370 = and i32 %3, 15
  %add371 = or disjoint i32 %mul364, %and370
  %arrayidx373 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371
  %68 = load half, ptr addrspace(3) %arrayidx373, align 2, !tbaa !160
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %68, i64 0
  %add366.1 = or disjoint i32 %mul364, %and370
  %add371.1 = or disjoint i32 %add366.1, 64
  %arrayidx373.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1
  %69 = load half, ptr addrspace(3) %arrayidx373.1, align 2, !tbaa !160
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %69, i64 1
  %add366.2 = or disjoint i32 %mul364, %and370
  %add371.2 = or disjoint i32 %add366.2, 128
  %arrayidx373.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2
  %70 = load half, ptr addrspace(3) %arrayidx373.2, align 2, !tbaa !160
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %70, i64 2
  %add366.3 = or disjoint i32 %mul364, %and370
  %add371.3 = or disjoint i32 %add366.3, 192
  %arrayidx373.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3
  %71 = load half, ptr addrspace(3) %arrayidx373.3, align 2, !tbaa !160
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %71, i64 3
  %add368.1668 = or disjoint i32 %mul364, %and370
  %add371.1669 = or disjoint i32 %add368.1668, 16
  %arrayidx373.1670 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1669
  %72 = load half, ptr addrspace(3) %arrayidx373.1670, align 2, !tbaa !160
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %72, i64 0
  %add368.1.1 = or disjoint i32 %mul364, %and370
  %add371.1.1 = or disjoint i32 %add368.1.1, 80
  %arrayidx373.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.1
  %73 = load half, ptr addrspace(3) %arrayidx373.1.1, align 2, !tbaa !160
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %73, i64 1
  %add368.2.1 = or disjoint i32 %mul364, %and370
  %add371.2.1 = or disjoint i32 %add368.2.1, 144
  %arrayidx373.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.1
  %74 = load half, ptr addrspace(3) %arrayidx373.2.1, align 2, !tbaa !160
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %74, i64 2
  %add368.3.1 = or disjoint i32 %mul364, %and370
  %add371.3.1 = or disjoint i32 %add368.3.1, 208
  %arrayidx373.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.1
  %75 = load half, ptr addrspace(3) %arrayidx373.3.1, align 2, !tbaa !160
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %75, i64 3
  %add368.2672 = or disjoint i32 %mul364, %and370
  %add371.2673 = or disjoint i32 %add368.2672, 32
  %arrayidx373.2674 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2673
  %76 = load half, ptr addrspace(3) %arrayidx373.2674, align 2, !tbaa !160
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %76, i64 0
  %add368.1.2 = or disjoint i32 %mul364, %and370
  %add371.1.2 = or disjoint i32 %add368.1.2, 96
  %arrayidx373.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.2
  %77 = load half, ptr addrspace(3) %arrayidx373.1.2, align 2, !tbaa !160
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %77, i64 1
  %add368.2.2 = or disjoint i32 %mul364, %and370
  %add371.2.2 = or disjoint i32 %add368.2.2, 160
  %arrayidx373.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.2
  %78 = load half, ptr addrspace(3) %arrayidx373.2.2, align 2, !tbaa !160
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %78, i64 2
  %add368.3.2 = or disjoint i32 %mul364, %and370
  %add371.3.2 = or disjoint i32 %add368.3.2, 224
  %arrayidx373.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.2
  %79 = load half, ptr addrspace(3) %arrayidx373.3.2, align 2, !tbaa !160
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %79, i64 3
  %add368.3676 = or disjoint i32 %mul364, %and370
  %add371.3677 = or disjoint i32 %add368.3676, 48
  %arrayidx373.3678 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3677
  %80 = load half, ptr addrspace(3) %arrayidx373.3678, align 2, !tbaa !160
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %80, i64 0
  %add368.1.3 = or disjoint i32 %mul364, %and370
  %add371.1.3 = or disjoint i32 %add368.1.3, 112
  %arrayidx373.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.3
  %81 = load half, ptr addrspace(3) %arrayidx373.1.3, align 2, !tbaa !160
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %81, i64 1
  %add368.2.3 = or disjoint i32 %mul364, %and370
  %add371.2.3 = or disjoint i32 %add368.2.3, 176
  %arrayidx373.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.3
  %82 = load half, ptr addrspace(3) %arrayidx373.2.3, align 2, !tbaa !160
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %82, i64 2
  %add368.3.3 = or disjoint i32 %67, %and370
  %add371.3.3 = or i32 %add368.3.3, 240
  %arrayidx373.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.3
  %83 = load half, ptr addrspace(3) %arrayidx373.3.3, align 2, !tbaa !160
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %83, i64 3
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end402

if.end402:                                        ; preds = %for.cond354.preheader, %if.end336
  %acc_o.sroa.0.0 = phi <4 x float> [ %84, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ]
  %acc_o.sroa.16.0 = phi <4 x float> [ %85, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ]
  %acc_o.sroa.30.0 = phi <4 x float> [ %86, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ]
  %acc_o.sroa.44.0 = phi <4 x float> [ %87, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %88 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %90 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %92 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %93 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %94 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %95 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %96 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %97 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %98 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %99 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %100 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %101 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %102 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %103 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and435 = shl nuw nsw i32 %3, 6
  %mul436 = and i32 %and435, 960
  %shr439 = lshr i32 %3, 5
  %and442 = and i32 %3, 7
  %104 = lshr i32 %3, 2
  %mul449 = and i32 %104, 4
  %xor443 = xor i32 %shr439, %and442
  %mul444 = shl nuw nsw i32 %xor443, 3
  %add445 = add nuw nsw i32 %mul444, %mul436
  %add450 = or disjoint i32 %add445, %mul449
  %add.ptr452 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr452, align 8
  %add440.1 = add nuw nsw i32 %shr439, 2
  %xor443.1 = xor i32 %add440.1, %and442
  %mul444.1 = shl nuw nsw i32 %xor443.1, 3
  %add445.1 = add nuw nsw i32 %mul444.1, %mul436
  %add450.1 = or disjoint i32 %add445.1, %mul449
  %add.ptr452.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr452.1, align 8
  %add440.2 = add nuw nsw i32 %shr439, 4
  %xor443.2 = xor i32 %add440.2, %and442
  %mul444.2 = shl nuw nsw i32 %xor443.2, 3
  %add445.2 = add nuw nsw i32 %mul444.2, %mul436
  %add450.2 = or disjoint i32 %add445.2, %mul449
  %add.ptr452.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr452.2, align 8
  %add440.3 = add nuw nsw i32 %shr439, 6
  %xor443.3 = xor i32 %add440.3, %and442
  %mul444.3 = shl nuw nsw i32 %xor443.3, 3
  %add445.3 = add nuw nsw i32 %mul444.3, %mul436
  %add450.3 = or disjoint i32 %add445.3, %mul449
  %add.ptr452.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr452.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul463 = and i32 %mul14, 8128
  %xor469586 = and i32 %mul14, 56
  %call467.masked = and i32 %3, 1016
  %mul470 = xor i32 %xor469586, %call467.masked
  %invariant.gep632 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul463
  %invariant.gep634 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep632, i32 %mul470
  %add.ptr490 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr490, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep634, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
  %gep635.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1024
  %add.ptr490.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr490.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep635.1, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp.f32(float) #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare i16 @llvm.convert.to.fp16.f32(float) #8

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.minnum.f32(float, float) #7

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


