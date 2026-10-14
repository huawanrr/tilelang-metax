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
  %arrayidx28 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %7 = load i32, ptr addrspace(1) %arrayidx28, align 4, !tbaa !30
  %cmp43 = icmp ugt i32 %7, 31
  %shr46 = lshr i32 %2, 4
  %cmp47.not = icmp ugt i32 %7, %shr46
  %or.cond669 = or i1 %cmp43, %cmp47.not
  br i1 %or.cond669, label %if.end362, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %8 = shl nuw nsw i32 %0, 15
  %mul61 = and i32 %8, 2147418112
  %mul62 = shl nuw nsw i32 %7, 11
  %9 = shl nuw nsw i32 %3, 4
  %mul68 = and i32 %9, 16256
  %and71 = shl i32 %0, 6
  %mul72 = and i32 %and71, 64
  %mul76 = and i32 %mul14, 56
  %add63 = or disjoint i32 %mul68, %mul61
  %add65 = or disjoint i32 %add63, %mul72
  %add69 = or disjoint i32 %add65, %mul76
  %add73 = add nuw nsw i32 %add69, %mul62
  %10 = zext nneg i32 %add73 to i64
  %add.ptr81 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr81, align 4, !tbaa !30
  %12 = or disjoint i64 %10, 2
  %add.ptr81.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr81.1, align 4, !tbaa !30
  %14 = or disjoint i64 %10, 4
  %add.ptr81.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr81.2, align 4, !tbaa !30
  %16 = or disjoint i64 %10, 6
  %add.ptr81.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr81.3, align 4, !tbaa !30
  %18 = add nuw nsw i64 %10, 1024
  %add.ptr81.1687 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr81.1687, align 4, !tbaa !30
  %20 = add nuw nsw i64 %10, 1026
  %add.ptr81.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr81.1.1, align 4, !tbaa !30
  %22 = add nuw nsw i64 %10, 1028
  %add.ptr81.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr81.2.1, align 4, !tbaa !30
  %24 = add nuw nsw i64 %10, 1030
  %add.ptr81.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr81.3.1, align 4, !tbaa !30
  %add.ptr124 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %26 = load i32, ptr addrspace(4) %add.ptr124, align 4, !tbaa !30
  %add.ptr124.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %27 = load i32, ptr addrspace(4) %add.ptr124.1, align 4, !tbaa !30
  %add.ptr124.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %28 = load i32, ptr addrspace(4) %add.ptr124.2, align 4, !tbaa !30
  %add.ptr124.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %29 = load i32, ptr addrspace(4) %add.ptr124.3, align 4, !tbaa !30
  %add.ptr124.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %30 = load i32, ptr addrspace(4) %add.ptr124.1699, align 4, !tbaa !30
  %add.ptr124.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %31 = load i32, ptr addrspace(4) %add.ptr124.1.1, align 4, !tbaa !30
  %add.ptr124.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %32 = load i32, ptr addrspace(4) %add.ptr124.2.1, align 4, !tbaa !30
  %add.ptr124.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %33 = load i32, ptr addrspace(4) %add.ptr124.3.1, align 4, !tbaa !30
  %mul148 = and i32 %mul14, 8128
  %call152.masked = and i32 %3, 1016
  %mul154 = xor i32 %mul76, %call152.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul148
  %invariant.gep637 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul154
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep637, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !61
  %gep638.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep638.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !61
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and166 = shl nuw nsw i32 %3, 6
  %mul167 = and i32 %and166, 960
  %shr170 = lshr i32 %3, 4
  %and173 = and i32 %3, 7
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul167
  %xor174 = xor i32 %shr170, %and173
  %add.ptr178.idx = shl nuw nsw i32 %xor174, 4
  %add.ptr178 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr178.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16
  %Q_reg.sroa.4.0.add.ptr178.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8
  %add171.1 = add nuw nsw i32 %shr170, 4
  %xor174.1 = xor i32 %add171.1, %and173
  %add.ptr178.idx.1 = shl nuw nsw i32 %xor174.1, 4
  %add.ptr178.1 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr178.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16
  %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %11, ptr addrspace(3) %invariant.gep637, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 4
  store i32 %13, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep642.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 8
  store i32 %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep642.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 12
  store i32 %17, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep642.sroa_idx, align 4, !tbaa !30
  store i32 %19, ptr addrspace(3) %gep638.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1028
  store i32 %21, ptr addrspace(3) %K_reg.sroa.9.16.gep643.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1032
  store i32 %23, ptr addrspace(3) %K_reg.sroa.10.16.gep643.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1036
  store i32 %25, ptr addrspace(3) %K_reg.sroa.11.16.gep643.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %35)
  %kb.sroa.0.0.copyload729 = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16
  %kb.sroa.6.0.copyload730 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload729, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %36)
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload730, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %37)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %invariant.gep650 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %9
  store i32 %26, ptr addrspace(3) %invariant.gep650, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 4
  store i32 %27, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 8
  store i32 %28, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep650.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 12
  store i32 %29, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1024
  store i32 %30, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1028
  store i32 %31, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1032
  store i32 %32, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1036
  store i32 %33, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %mul48 = shl nuw nsw i32 %7, 4
  %shr282 = shl nuw nsw i32 %7, 2
  %add283 = add nuw nsw i32 %shr282, %shr170
  %cmp284 = icmp ugt i32 %add283, 127
  %39 = lshr i32 %3, 2
  %mul288 = and i32 %39, 252
  %add290 = add nuw nsw i32 %mul48, %mul288
  %cmp293.not = icmp ugt i32 %add290, %2
  %or.cond670 = select i1 %cmp284, i1 true, i1 %cmp293.not
  br i1 %or.cond670, label %if.end, label %if.then294

if.then294:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0
  %mul297 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul297, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then294
  %condval.0 = phi float [ %41, %if.then294 ], [ 0.000000e+00, %if.then ]
  %cmp293.not.1 = icmp uge i32 %add290, %2
  %or.cond670.1 = select i1 %cmp284, i1 true, i1 %cmp293.not.1
  br i1 %or.cond670.1, label %if.end.1, label %if.then294.1

if.then294.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1
  %mul297.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul297.1, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then294.1, %if.end
  %condval.0.1 = phi float [ %43, %if.then294.1 ], [ 0.000000e+00, %if.end ]
  %add291.2 = or disjoint i32 %add290, 2
  %cmp293.not.2 = icmp ugt i32 %add291.2, %2
  %or.cond670.2 = select i1 %cmp284, i1 true, i1 %cmp293.not.2
  br i1 %or.cond670.2, label %if.end.2, label %if.then294.2

if.then294.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2
  %mul297.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul297.2, float 0x4024CB5EC0000000)
  %45 = tail call contract noundef float @llvm.exp.f32(float %44)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then294.2, %if.end.1
  %condval.0.2 = phi float [ %45, %if.then294.2 ], [ 0.000000e+00, %if.end.1 ]
  %add291.3 = or disjoint i32 %add290, 3
  %cmp293.not.3 = icmp ugt i32 %add291.3, %2
  %or.cond670.3 = select i1 %cmp284, i1 true, i1 %cmp293.not.3
  br i1 %or.cond670.3, label %if.end.3, label %if.then294.3

if.then294.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3
  %mul297.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul297.3, float 0x4024CB5EC0000000)
  %47 = tail call contract noundef float @llvm.exp.f32(float %46)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then294.3, %if.end.2
  %condval.0.3 = phi float [ %47, %if.then294.3 ], [ 0.000000e+00, %if.end.2 ]
  %add313.1 = fadd contract float %condval.0, %condval.0.1
  %add313.2 = fadd contract float %add313.1, %condval.0.2
  %add313.3 = fadd contract float %add313.2, %condval.0.3
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add313.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %48, i64 0
  %cmp331 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp331, float %div, float 0.000000e+00
  %mul344 = fmul contract float %condval_1.0, %condval.0
  %mul344.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul344.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul344.3 = fmul contract float %condval_1.0, %condval.0.3
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344)
  %50 = insertelement <4 x i16> poison, i16 %49, i64 0
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344.1)
  %52 = insertelement <4 x i16> %50, i16 %51, i64 1
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344.2)
  %54 = insertelement <4 x i16> %52, i16 %53, i64 2
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344.3)
  %56 = insertelement <4 x i16> %54, i16 %55, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %56 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end362

if.end362:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond669, label %if.end432, label %for.cond384.preheader

for.cond384.preheader:                            ; preds = %if.end362
  %57 = shl nuw nsw i32 %3, 4
  %mul394 = and i32 %57, 16128
  %and400 = and i32 %3, 15
  %add401 = or disjoint i32 %mul394, %and400
  %arrayidx403 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401
  %58 = load half, ptr addrspace(3) %arrayidx403, align 2, !tbaa !135
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %58, i64 0
  %add396.1 = or disjoint i32 %mul394, %and400
  %add401.1 = or disjoint i32 %add396.1, 64
  %arrayidx403.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1
  %59 = load half, ptr addrspace(3) %arrayidx403.1, align 2, !tbaa !135
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %59, i64 1
  %add396.2 = or disjoint i32 %mul394, %and400
  %add401.2 = or disjoint i32 %add396.2, 128
  %arrayidx403.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2
  %60 = load half, ptr addrspace(3) %arrayidx403.2, align 2, !tbaa !135
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %60, i64 2
  %add396.3 = or disjoint i32 %mul394, %and400
  %add401.3 = or disjoint i32 %add396.3, 192
  %arrayidx403.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3
  %61 = load half, ptr addrspace(3) %arrayidx403.3, align 2, !tbaa !135
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %61, i64 3
  %add398.1703 = or disjoint i32 %mul394, %and400
  %add401.1704 = or disjoint i32 %add398.1703, 16
  %arrayidx403.1705 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1704
  %62 = load half, ptr addrspace(3) %arrayidx403.1705, align 2, !tbaa !135
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %62, i64 0
  %add398.1.1 = or disjoint i32 %mul394, %and400
  %add401.1.1 = or disjoint i32 %add398.1.1, 80
  %arrayidx403.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1.1
  %63 = load half, ptr addrspace(3) %arrayidx403.1.1, align 2, !tbaa !135
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %63, i64 1
  %add398.2.1 = or disjoint i32 %mul394, %and400
  %add401.2.1 = or disjoint i32 %add398.2.1, 144
  %arrayidx403.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2.1
  %64 = load half, ptr addrspace(3) %arrayidx403.2.1, align 2, !tbaa !135
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %64, i64 2
  %add398.3.1 = or disjoint i32 %mul394, %and400
  %add401.3.1 = or disjoint i32 %add398.3.1, 208
  %arrayidx403.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3.1
  %65 = load half, ptr addrspace(3) %arrayidx403.3.1, align 2, !tbaa !135
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %65, i64 3
  %add398.2707 = or disjoint i32 %mul394, %and400
  %add401.2708 = or disjoint i32 %add398.2707, 32
  %arrayidx403.2709 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2708
  %66 = load half, ptr addrspace(3) %arrayidx403.2709, align 2, !tbaa !135
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add398.1.2 = or disjoint i32 %mul394, %and400
  %add401.1.2 = or disjoint i32 %add398.1.2, 96
  %arrayidx403.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1.2
  %67 = load half, ptr addrspace(3) %arrayidx403.1.2, align 2, !tbaa !135
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %67, i64 1
  %add398.2.2 = or disjoint i32 %mul394, %and400
  %add401.2.2 = or disjoint i32 %add398.2.2, 160
  %arrayidx403.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2.2
  %68 = load half, ptr addrspace(3) %arrayidx403.2.2, align 2, !tbaa !135
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %68, i64 2
  %add398.3.2 = or disjoint i32 %mul394, %and400
  %add401.3.2 = or disjoint i32 %add398.3.2, 224
  %arrayidx403.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3.2
  %69 = load half, ptr addrspace(3) %arrayidx403.3.2, align 2, !tbaa !135
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %69, i64 3
  %add398.3711 = or disjoint i32 %mul394, %and400
  %add401.3712 = or disjoint i32 %add398.3711, 48
  %arrayidx403.3713 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3712
  %70 = load half, ptr addrspace(3) %arrayidx403.3713, align 2, !tbaa !135
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %70, i64 0
  %add398.1.3 = or disjoint i32 %mul394, %and400
  %add401.1.3 = or disjoint i32 %add398.1.3, 112
  %arrayidx403.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1.3
  %71 = load half, ptr addrspace(3) %arrayidx403.1.3, align 2, !tbaa !135
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %71, i64 1
  %add398.2.3 = or disjoint i32 %mul394, %and400
  %add401.2.3 = or disjoint i32 %add398.2.3, 176
  %arrayidx403.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2.3
  %72 = load half, ptr addrspace(3) %arrayidx403.2.3, align 2, !tbaa !135
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %72, i64 2
  %add398.3.3 = or disjoint i32 %57, %and400
  %add401.3.3 = or i32 %add398.3.3, 240
  %arrayidx403.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3.3
  %73 = load half, ptr addrspace(3) %arrayidx403.3.3, align 2, !tbaa !135
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %73, i64 3
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end432

if.end432:                                        ; preds = %for.cond384.preheader, %if.end362
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %74, %for.cond384.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %75, %for.cond384.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %76, %for.cond384.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %77, %for.cond384.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %78 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %79 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %80 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %81 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %82 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %83 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %84 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %85 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %86 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %90 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %92 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %93 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and465 = shl nuw nsw i32 %3, 6
  %mul466 = and i32 %and465, 960
  %shr469 = lshr i32 %3, 5
  %and472 = and i32 %3, 7
  %94 = lshr i32 %3, 2
  %mul479 = and i32 %94, 4
  %xor473 = xor i32 %shr469, %and472
  %mul474 = shl nuw nsw i32 %xor473, 3
  %add475 = add nuw nsw i32 %mul474, %mul466
  %add480 = or disjoint i32 %add475, %mul479
  %add.ptr482 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr482, align 8
  %add470.1 = add nuw nsw i32 %shr469, 2
  %xor473.1 = xor i32 %add470.1, %and472
  %mul474.1 = shl nuw nsw i32 %xor473.1, 3
  %add475.1 = add nuw nsw i32 %mul474.1, %mul466
  %add480.1 = or disjoint i32 %add475.1, %mul479
  %add.ptr482.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr482.1, align 8
  %add470.2 = add nuw nsw i32 %shr469, 4
  %xor473.2 = xor i32 %add470.2, %and472
  %mul474.2 = shl nuw nsw i32 %xor473.2, 3
  %add475.2 = add nuw nsw i32 %mul474.2, %mul466
  %add480.2 = or disjoint i32 %add475.2, %mul479
  %add.ptr482.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr482.2, align 8
  %add470.3 = add nuw nsw i32 %shr469, 6
  %xor473.3 = xor i32 %add470.3, %and472
  %mul474.3 = shl nuw nsw i32 %xor473.3, 3
  %add475.3 = add nuw nsw i32 %mul474.3, %mul466
  %add480.3 = or disjoint i32 %add475.3, %mul479
  %add.ptr482.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr482.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul493 = and i32 %mul14, 8128
  %xor499623 = and i32 %mul14, 56
  %call497.masked = and i32 %3, 1016
  %mul500 = xor i32 %xor499623, %call497.masked
  %invariant.gep664 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul493
  %invariant.gep666 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep664, i32 %mul500
  %add.ptr520 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr520, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep666, i64 16, i1 false), !tbaa.struct !164, !call_argsrelate !165
  %gep667.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep666, i32 1024
  %add.ptr520.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr520.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep667.1, i64 16, i1 false), !tbaa.struct !164, !call_argsrelate !165
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp.f32(float) #7

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


