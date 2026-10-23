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
  %cmp42 = icmp ugt i32 %7, 31
  %shr45 = lshr i32 %2, 4
  %cmp46.not = icmp ugt i32 %7, %shr45
  %or.cond669 = or i1 %cmp42, %cmp46.not
  br i1 %or.cond669, label %if.end359, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %8 = shl nuw nsw i32 %0, 15
  %mul60 = and i32 %8, 2147418112
  %mul61 = shl nuw nsw i32 %7, 11
  %9 = shl nuw nsw i32 %3, 4
  %mul67 = and i32 %9, 16256
  %and70 = shl i32 %0, 6
  %mul71 = and i32 %and70, 64
  %mul75 = and i32 %mul14, 56
  %add62 = or disjoint i32 %mul67, %mul60
  %add64 = or disjoint i32 %add62, %mul71
  %add68 = or disjoint i32 %add64, %mul75
  %add72 = add nuw nsw i32 %add68, %mul61
  %10 = zext nneg i32 %add72 to i64
  %add.ptr80 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr80, align 4, !tbaa !30
  %12 = or disjoint i64 %10, 2
  %add.ptr80.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr80.1, align 4, !tbaa !30
  %14 = or disjoint i64 %10, 4
  %add.ptr80.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr80.2, align 4, !tbaa !30
  %16 = or disjoint i64 %10, 6
  %add.ptr80.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr80.3, align 4, !tbaa !30
  %18 = add nuw nsw i64 %10, 1024
  %add.ptr80.1687 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr80.1687, align 4, !tbaa !30
  %20 = add nuw nsw i64 %10, 1026
  %add.ptr80.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr80.1.1, align 4, !tbaa !30
  %22 = add nuw nsw i64 %10, 1028
  %add.ptr80.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr80.2.1, align 4, !tbaa !30
  %24 = add nuw nsw i64 %10, 1030
  %add.ptr80.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr80.3.1, align 4, !tbaa !30
  %add.ptr123 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %26 = load i32, ptr addrspace(4) %add.ptr123, align 4, !tbaa !30
  %add.ptr123.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %27 = load i32, ptr addrspace(4) %add.ptr123.1, align 4, !tbaa !30
  %add.ptr123.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %28 = load i32, ptr addrspace(4) %add.ptr123.2, align 4, !tbaa !30
  %add.ptr123.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %29 = load i32, ptr addrspace(4) %add.ptr123.3, align 4, !tbaa !30
  %add.ptr123.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %30 = load i32, ptr addrspace(4) %add.ptr123.1699, align 4, !tbaa !30
  %add.ptr123.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %31 = load i32, ptr addrspace(4) %add.ptr123.1.1, align 4, !tbaa !30
  %add.ptr123.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %32 = load i32, ptr addrspace(4) %add.ptr123.2.1, align 4, !tbaa !30
  %add.ptr123.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %33 = load i32, ptr addrspace(4) %add.ptr123.3.1, align 4, !tbaa !30
  %mul147 = and i32 %mul14, 8128
  %call151.masked = and i32 %3, 1016
  %mul153 = xor i32 %mul75, %call151.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul147
  %invariant.gep637 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul153
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep637, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !61
  %gep638.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep638.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !61
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and165 = shl nuw nsw i32 %3, 6
  %mul166 = and i32 %and165, 960
  %shr169 = lshr i32 %3, 4
  %and172 = and i32 %3, 7
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul166
  %xor173 = xor i32 %shr169, %and172
  %add.ptr177.idx = shl nuw nsw i32 %xor173, 4
  %add.ptr177 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr177.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr177, align 16
  %Q_reg.sroa.4.0.add.ptr177.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr177, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr177.sroa_idx, align 8
  %add170.1 = add nuw nsw i32 %shr169, 4
  %xor173.1 = xor i32 %add170.1, %and172
  %add.ptr177.idx.1 = shl nuw nsw i32 %xor173.1, 4
  %add.ptr177.1 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr177.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr177.1, align 16
  %Q_reg.sroa.7.16.add.ptr177.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr177.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr177.1.sroa_idx, align 8
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
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr177, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr177.sroa_idx, align 8
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %35)
  %kb.sroa.0.0.copyload729 = load <4 x half>, ptr addrspace(3) %add.ptr177.1, align 16
  %kb.sroa.6.0.copyload730 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr177.1.sroa_idx, align 8
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
  %mul47 = shl nuw nsw i32 %7, 4
  %shr281 = shl nuw nsw i32 %7, 2
  %add282 = add nuw nsw i32 %shr281, %shr169
  %cmp283 = icmp ugt i32 %add282, 127
  %39 = lshr i32 %3, 2
  %mul287 = and i32 %39, 252
  %add289 = add nuw nsw i32 %mul47, %mul287
  %cmp292.not = icmp ugt i32 %add289, %2
  %or.cond670 = select i1 %cmp283, i1 true, i1 %cmp292.not
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0
  %mul296 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %40 = tail call contract float @llvm.minnum.f32(float %mul296, float 1.500000e+01)
  %41 = tail call contract float @llvm.exp2.f32(float %40)
  %condval.0 = select i1 %or.cond670, float 0.000000e+00, float %41
  %cmp292.not.1 = icmp uge i32 %add289, %2
  %or.cond670.1 = select i1 %cmp283, i1 true, i1 %cmp292.not.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1
  %mul296.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %42 = tail call contract float @llvm.minnum.f32(float %mul296.1, float 1.500000e+01)
  %43 = tail call contract float @llvm.exp2.f32(float %42)
  %condval.0.1 = select i1 %or.cond670.1, float 0.000000e+00, float %43
  %add290.2 = or disjoint i32 %add289, 2
  %cmp292.not.2 = icmp ugt i32 %add290.2, %2
  %or.cond670.2 = select i1 %cmp283, i1 true, i1 %cmp292.not.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2
  %mul296.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %44 = tail call contract float @llvm.minnum.f32(float %mul296.2, float 1.500000e+01)
  %45 = tail call contract float @llvm.exp2.f32(float %44)
  %condval.0.2 = select i1 %or.cond670.2, float 0.000000e+00, float %45
  %add290.3 = or disjoint i32 %add289, 3
  %cmp292.not.3 = icmp ugt i32 %add290.3, %2
  %or.cond670.3 = select i1 %cmp283, i1 true, i1 %cmp292.not.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3
  %mul296.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %46 = tail call contract float @llvm.minnum.f32(float %mul296.3, float 1.500000e+01)
  %47 = tail call contract float @llvm.exp2.f32(float %46)
  %condval.0.3 = select i1 %or.cond670.3, float 0.000000e+00, float %47
  %add312.1 = fadd contract float %condval.0, %condval.0.1
  %add312.2 = fadd contract float %add312.1, %condval.0.2
  %add312.3 = fadd contract float %add312.2, %condval.0.3
  %48 = bitcast float %add312.3 to i32
  %49 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %50 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %49) #11
  %xor.i.i = xor i32 %50, 32
  %51 = and i32 %50, -64
  %and.i.i = add nsw i32 %51, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %50
  %shl.i.i = shl i32 %cond.i.i, 2
  %52 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %48)
  %53 = bitcast i32 %52 to float
  %add320 = fadd contract float %add312.3, %53
  %54 = bitcast float %add320 to i32
  %55 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %56 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %55) #11
  %xor.i.i624 = xor i32 %56, 16
  %57 = and i32 %56, -64
  %and.i.i625 = add nsw i32 %57, 64
  %cmp.not.i.i626 = icmp slt i32 %xor.i.i624, %and.i.i625
  %cond.i.i627 = select i1 %cmp.not.i.i626, i32 %xor.i.i624, i32 %56
  %shl.i.i628 = shl i32 %cond.i.i627, 2
  %58 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i628, i32 %54)
  %59 = bitcast i32 %58 to float
  %add325 = fadd contract float %add320, %59
  %cmp328 = fcmp contract ogt float %add325, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add325
  %condval_1.0 = select i1 %cmp328, float %div, float 0.000000e+00
  %mul341 = fmul contract float %condval_1.0, %condval.0
  %mul341.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul341.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul341.3 = fmul contract float %condval_1.0, %condval.0.3
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341)
  %61 = insertelement <4 x i16> poison, i16 %60, i64 0
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341.1)
  %63 = insertelement <4 x i16> %61, i16 %62, i64 1
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341.2)
  %65 = insertelement <4 x i16> %63, i16 %64, i64 2
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341.3)
  %67 = insertelement <4 x i16> %65, i16 %66, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %67 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end359

if.end359:                                        ; preds = %if.then, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.then ]
  br i1 %or.cond669, label %if.end429, label %for.cond381.preheader

for.cond381.preheader:                            ; preds = %if.end359
  %68 = shl nuw nsw i32 %3, 4
  %mul391 = and i32 %68, 16128
  %and397 = and i32 %3, 15
  %add398 = or disjoint i32 %mul391, %and397
  %arrayidx400 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398
  %69 = load half, ptr addrspace(3) %arrayidx400, align 2, !tbaa !153
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %69, i64 0
  %add393.1 = or disjoint i32 %mul391, %and397
  %add398.1 = or disjoint i32 %add393.1, 64
  %arrayidx400.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1
  %70 = load half, ptr addrspace(3) %arrayidx400.1, align 2, !tbaa !153
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %70, i64 1
  %add393.2 = or disjoint i32 %mul391, %and397
  %add398.2 = or disjoint i32 %add393.2, 128
  %arrayidx400.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2
  %71 = load half, ptr addrspace(3) %arrayidx400.2, align 2, !tbaa !153
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %71, i64 2
  %add393.3 = or disjoint i32 %mul391, %and397
  %add398.3 = or disjoint i32 %add393.3, 192
  %arrayidx400.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3
  %72 = load half, ptr addrspace(3) %arrayidx400.3, align 2, !tbaa !153
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %72, i64 3
  %add395.1703 = or disjoint i32 %mul391, %and397
  %add398.1704 = or disjoint i32 %add395.1703, 16
  %arrayidx400.1705 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1704
  %73 = load half, ptr addrspace(3) %arrayidx400.1705, align 2, !tbaa !153
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %73, i64 0
  %add395.1.1 = or disjoint i32 %mul391, %and397
  %add398.1.1 = or disjoint i32 %add395.1.1, 80
  %arrayidx400.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1.1
  %74 = load half, ptr addrspace(3) %arrayidx400.1.1, align 2, !tbaa !153
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %74, i64 1
  %add395.2.1 = or disjoint i32 %mul391, %and397
  %add398.2.1 = or disjoint i32 %add395.2.1, 144
  %arrayidx400.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2.1
  %75 = load half, ptr addrspace(3) %arrayidx400.2.1, align 2, !tbaa !153
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %75, i64 2
  %add395.3.1 = or disjoint i32 %mul391, %and397
  %add398.3.1 = or disjoint i32 %add395.3.1, 208
  %arrayidx400.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3.1
  %76 = load half, ptr addrspace(3) %arrayidx400.3.1, align 2, !tbaa !153
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %76, i64 3
  %add395.2707 = or disjoint i32 %mul391, %and397
  %add398.2708 = or disjoint i32 %add395.2707, 32
  %arrayidx400.2709 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2708
  %77 = load half, ptr addrspace(3) %arrayidx400.2709, align 2, !tbaa !153
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %77, i64 0
  %add395.1.2 = or disjoint i32 %mul391, %and397
  %add398.1.2 = or disjoint i32 %add395.1.2, 96
  %arrayidx400.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1.2
  %78 = load half, ptr addrspace(3) %arrayidx400.1.2, align 2, !tbaa !153
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %78, i64 1
  %add395.2.2 = or disjoint i32 %mul391, %and397
  %add398.2.2 = or disjoint i32 %add395.2.2, 160
  %arrayidx400.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2.2
  %79 = load half, ptr addrspace(3) %arrayidx400.2.2, align 2, !tbaa !153
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %79, i64 2
  %add395.3.2 = or disjoint i32 %mul391, %and397
  %add398.3.2 = or disjoint i32 %add395.3.2, 224
  %arrayidx400.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3.2
  %80 = load half, ptr addrspace(3) %arrayidx400.3.2, align 2, !tbaa !153
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %80, i64 3
  %add395.3711 = or disjoint i32 %mul391, %and397
  %add398.3712 = or disjoint i32 %add395.3711, 48
  %arrayidx400.3713 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3712
  %81 = load half, ptr addrspace(3) %arrayidx400.3713, align 2, !tbaa !153
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %81, i64 0
  %add395.1.3 = or disjoint i32 %mul391, %and397
  %add398.1.3 = or disjoint i32 %add395.1.3, 112
  %arrayidx400.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1.3
  %82 = load half, ptr addrspace(3) %arrayidx400.1.3, align 2, !tbaa !153
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %82, i64 1
  %add395.2.3 = or disjoint i32 %mul391, %and397
  %add398.2.3 = or disjoint i32 %add395.2.3, 176
  %arrayidx400.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2.3
  %83 = load half, ptr addrspace(3) %arrayidx400.2.3, align 2, !tbaa !153
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %83, i64 2
  %add395.3.3 = or disjoint i32 %68, %and397
  %add398.3.3 = or i32 %add395.3.3, 240
  %arrayidx400.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3.3
  %84 = load half, ptr addrspace(3) %arrayidx400.3.3, align 2, !tbaa !153
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %84, i64 3
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end429

if.end429:                                        ; preds = %for.cond381.preheader, %if.end359
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %85, %for.cond381.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %86, %for.cond381.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %87, %for.cond381.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %88, %for.cond381.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %89 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %90 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %92 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %93 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %94 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %95 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %96 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %97 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %98 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %99 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %100 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %101 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %102 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %103 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %104 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and462 = shl nuw nsw i32 %3, 6
  %mul463 = and i32 %and462, 960
  %shr466 = lshr i32 %3, 5
  %and469 = and i32 %3, 7
  %105 = lshr i32 %3, 2
  %mul476 = and i32 %105, 4
  %xor470 = xor i32 %shr466, %and469
  %mul471 = shl nuw nsw i32 %xor470, 3
  %add472 = add nuw nsw i32 %mul471, %mul463
  %add477 = or disjoint i32 %add472, %mul476
  %add.ptr479 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr479, align 8
  %add467.1 = add nuw nsw i32 %shr466, 2
  %xor470.1 = xor i32 %add467.1, %and469
  %mul471.1 = shl nuw nsw i32 %xor470.1, 3
  %add472.1 = add nuw nsw i32 %mul471.1, %mul463
  %add477.1 = or disjoint i32 %add472.1, %mul476
  %add.ptr479.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr479.1, align 8
  %add467.2 = add nuw nsw i32 %shr466, 4
  %xor470.2 = xor i32 %add467.2, %and469
  %mul471.2 = shl nuw nsw i32 %xor470.2, 3
  %add472.2 = add nuw nsw i32 %mul471.2, %mul463
  %add477.2 = or disjoint i32 %add472.2, %mul476
  %add.ptr479.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr479.2, align 8
  %add467.3 = add nuw nsw i32 %shr466, 6
  %xor470.3 = xor i32 %add467.3, %and469
  %mul471.3 = shl nuw nsw i32 %xor470.3, 3
  %add472.3 = add nuw nsw i32 %mul471.3, %mul463
  %add477.3 = or disjoint i32 %add472.3, %mul476
  %add.ptr479.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr479.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul490 = and i32 %mul14, 8128
  %xor496618 = and i32 %mul14, 56
  %call494.masked = and i32 %3, 1016
  %mul497 = xor i32 %xor496618, %call494.masked
  %invariant.gep664 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul490
  %invariant.gep666 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep664, i32 %mul497
  %add.ptr517 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep666, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  %gep667.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep666, i32 1024
  %add.ptr517.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep667.1, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp2.f32(float) #7

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


