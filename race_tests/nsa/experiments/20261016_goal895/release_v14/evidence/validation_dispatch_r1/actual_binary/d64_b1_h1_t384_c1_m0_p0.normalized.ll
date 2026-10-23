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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp28 = icmp ugt i32 %2, 23
  %shr = lshr i32 %0, 4
  %cmp31.not = icmp ugt i32 %2, %shr
  %or.cond561 = or i1 %cmp28, %cmp31.not
  br i1 %or.cond561, label %entry.if.end375_crit_edge, label %if.then

entry.if.end375_crit_edge:                        ; preds = %entry
  %.pre = shl nuw nsw i32 %1, 6
  %.pre689 = and i32 %.pre, 960
  br label %if.end375

if.then:                                          ; preds = %entry
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %3 = zext nneg i32 %add to i64
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 1024
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul43 = shl nuw nsw i32 %2, 10
  %add45 = add nuw nsw i32 %mul43, %mul8
  %5 = zext nneg i32 %add45 to i64
  %add.ptr52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5
  %6 = load i32, ptr addrspace(4) %add.ptr52, align 4, !tbaa !30
  %7 = or disjoint i64 %5, 2
  %add.ptr52.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr52.1, align 4, !tbaa !30
  %9 = or disjoint i64 %5, 4
  %add.ptr52.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr52.2, align 4, !tbaa !30
  %11 = or disjoint i64 %5, 6
  %add.ptr52.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr52.3, align 4, !tbaa !30
  %13 = add nuw nsw i64 %5, 512
  %add.ptr52.1576 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr52.1576, align 4, !tbaa !30
  %15 = add nuw nsw i64 %5, 514
  %add.ptr52.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr52.1.1, align 4, !tbaa !30
  %17 = add nuw nsw i64 %5, 516
  %add.ptr52.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr52.2.1, align 4, !tbaa !30
  %19 = add nuw nsw i64 %5, 518
  %add.ptr52.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr52.3.1, align 4, !tbaa !30
  %add.ptr82 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5
  %21 = load i32, ptr addrspace(4) %add.ptr82, align 4, !tbaa !30
  %add.ptr82.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %22 = load i32, ptr addrspace(4) %add.ptr82.1, align 4, !tbaa !30
  %add.ptr82.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %23 = load i32, ptr addrspace(4) %add.ptr82.2, align 4, !tbaa !30
  %add.ptr82.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %24 = load i32, ptr addrspace(4) %add.ptr82.3, align 4, !tbaa !30
  %add.ptr82.1588 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %25 = load i32, ptr addrspace(4) %add.ptr82.1588, align 4, !tbaa !30
  %add.ptr82.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %26 = load i32, ptr addrspace(4) %add.ptr82.1.1, align 4, !tbaa !30
  %add.ptr82.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %27 = load i32, ptr addrspace(4) %add.ptr82.2.1, align 4, !tbaa !30
  %add.ptr82.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %28 = load i32, ptr addrspace(4) %add.ptr82.3.1, align 4, !tbaa !30
  %mul106 = and i32 %mul8, 8128
  %xor501 = and i32 %mul8, 56
  %call109.masked = and i32 %1, 1016
  %mul111 = xor i32 %xor501, %call109.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul106
  %invariant.gep537 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul111
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep537, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !55
  %gep538.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep538.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !55
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and123 = shl nuw nsw i32 %1, 6
  %mul124 = and i32 %and123, 960
  %shr127 = lshr i32 %1, 4
  %and130 = and i32 %1, 7
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul124
  %xor131 = xor i32 %shr127, %and130
  %add.ptr135.idx = shl nuw nsw i32 %xor131, 4
  %add.ptr135 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr135.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135, align 16
  %Q_reg.sroa.4.0.add.ptr135.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr135, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr135.sroa_idx, align 8
  %add128.1 = add nuw nsw i32 %shr127, 4
  %xor131.1 = xor i32 %add128.1, %and130
  %add.ptr135.idx.1 = shl nuw nsw i32 %xor131.1, 4
  %add.ptr135.1 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr135.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135.1, align 16
  %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr135.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %6, ptr addrspace(3) %invariant.gep537, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep542.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 4
  store i32 %8, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep542.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep542.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 8
  store i32 %10, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep542.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep542.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 12
  store i32 %12, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep542.sroa_idx, align 4, !tbaa !30
  store i32 %14, ptr addrspace(3) %gep538.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep543.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1028
  store i32 %16, ptr addrspace(3) %K_reg.sroa.9.16.gep543.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep543.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1032
  store i32 %18, ptr addrspace(3) %K_reg.sroa.10.16.gep543.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep543.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1036
  store i32 %20, ptr addrspace(3) %K_reg.sroa.11.16.gep543.1.sroa_idx, align 4, !tbaa !30
  %mul32 = shl nuw nsw i32 %2, 4
  %add170 = or disjoint i32 %mul32, 15
  %cmp171 = icmp ult i32 %0, %add170
  br i1 %cmp171, label %for.cond173.preheader, label %if.end197

for.cond173.preheader:                            ; preds = %if.then
  %30 = lshr i32 %1, 2
  %mul179 = and i32 %30, 252
  %add181 = add nuw nsw i32 %mul32, %mul179
  %cmp184.not = icmp ugt i32 %add181, %0
  %spec.select = select i1 %cmp184.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert619 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp184.not.1.not = icmp ult i32 %add181, %0
  %spec.select.1 = select i1 %cmp184.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert632 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert619, float %spec.select.1, i64 1
  %add182.2 = or disjoint i32 %add181, 2
  %cmp184.not.2 = icmp ugt i32 %add182.2, %0
  %spec.select.2 = select i1 %cmp184.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert645 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert632, float %spec.select.2, i64 2
  %add182.3 = or disjoint i32 %add181, 3
  %cmp184.not.3 = icmp ugt i32 %add182.3, %0
  %spec.select.3 = select i1 %cmp184.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert658 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert645, float %spec.select.3, i64 3
  br label %if.end197

if.end197:                                        ; preds = %if.then, %for.cond173.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert658, %for.cond173.preheader ], [ zeroinitializer, %if.then ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr135.sroa_idx, align 8
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0)
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31)
  %kb.sroa.0.0.copyload613 = load <4 x half>, ptr addrspace(3) %add.ptr135.1, align 16
  %kb.sroa.6.0.copyload614 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx, align 8
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload613, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32)
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload614, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr253.idx = shl nuw nsw i32 %1, 4
  %invariant.gep551 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr253.idx
  store i32 %21, ptr addrspace(3) %invariant.gep551, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep551.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 4
  store i32 %22, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep551.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep551.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 8
  store i32 %23, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep551.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep551.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 12
  store i32 %24, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep551.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1024
  store i32 %25, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1028
  store i32 %26, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1032
  store i32 %27, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1036
  store i32 %28, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract621 = extractelement <4 x float> %34, i64 0
  %mul263 = fmul contract float %acc_s.sroa.0.0.vec.extract621, 0x3FC2776C60000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul263, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %35, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %35, %cond.i.i
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %36
  %acc_s.sroa.0.4.vec.extract634 = extractelement <4 x float> %34, i64 1
  %mul263.1 = fmul contract float %acc_s.sroa.0.4.vec.extract634, 0x3FC2776C60000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul263.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %37, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %37, %cond.i.i.1
  %38 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %38
  %acc_s.sroa.0.8.vec.extract647 = extractelement <4 x float> %34, i64 2
  %mul263.2 = fmul contract float %acc_s.sroa.0.8.vec.extract647, 0x3FC2776C60000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul263.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %39, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %39, %cond.i.i.2
  %40 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %40
  %acc_s.sroa.0.12.vec.extract660 = extractelement <4 x float> %34, i64 3
  %mul263.3 = fmul contract float %acc_s.sroa.0.12.vec.extract660, 0x3FC2776C60000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul263.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %41, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %41, %cond.i.i.3
  %42 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %42
  %add279 = fadd contract float %mul.i.i, 0.000000e+00
  %add279.1 = fadd contract float %add279, %mul.i.i.1
  %add279.2 = fadd contract float %add279.1, %mul.i.i.2
  %add279.3 = fadd contract float %add279.2, %mul.i.i.3
  %43 = bitcast float %add279.3 to i32
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #11
  %xor.i.i = xor i32 %45, 32
  %46 = and i32 %45, -64
  %and.i.i = add nsw i32 %46, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i503 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %45
  %shl.i.i = shl i32 %cond.i.i503, 2
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %43)
  %48 = bitcast i32 %47 to float
  %add287 = fadd contract float %add279.3, %48
  %49 = bitcast float %add287 to i32
  %50 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %51 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %50) #11
  %xor.i.i504 = xor i32 %51, 16
  %52 = and i32 %51, -64
  %and.i.i505 = add nsw i32 %52, 64
  %cmp.not.i.i506 = icmp slt i32 %xor.i.i504, %and.i.i505
  %cond.i.i507 = select i1 %cmp.not.i.i506, i32 %xor.i.i504, i32 %51
  %shl.i.i508 = shl i32 %cond.i.i507, 2
  %53 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i508, i32 %49)
  %54 = bitcast i32 %53 to float
  %add292 = fadd contract float %add287, %54
  %cmp295 = fcmp contract ogt float %add292, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add292
  %condval_1.0 = select i1 %cmp295, float %div, float 0.000000e+00
  %mul308 = fmul contract float %condval_1.0, %mul.i.i
  %mul308.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul308.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul308.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %55 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !151
  %56 = fptrunc float %mul308 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %55), !noalias !151
  %57 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !151
  %58 = fptrunc float %mul308.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %57), !noalias !151
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %56, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %58, i64 1
  %59 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !165
  %60 = fptrunc float %mul308.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %59), !noalias !165
  %61 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !165
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %61), !noalias !165
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %60, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul337 = and i32 %add.ptr253.idx, 16128
  %and343 = and i32 %1, 15
  %add344 = or disjoint i32 %mul337, %and343
  %arrayidx346 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344
  %62 = load half, ptr addrspace(3) %arrayidx346, align 2, !tbaa !182
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %62, i64 0
  %add339.1 = or disjoint i32 %mul337, %and343
  %add344.1 = or disjoint i32 %add339.1, 64
  %arrayidx346.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1
  %63 = load half, ptr addrspace(3) %arrayidx346.1, align 2, !tbaa !182
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %63, i64 1
  %add339.2 = or disjoint i32 %mul337, %and343
  %add344.2 = or disjoint i32 %add339.2, 128
  %arrayidx346.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2
  %64 = load half, ptr addrspace(3) %arrayidx346.2, align 2, !tbaa !182
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %64, i64 2
  %add339.3 = or disjoint i32 %mul337, %and343
  %add344.3 = or disjoint i32 %add339.3, 192
  %arrayidx346.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3
  %65 = load half, ptr addrspace(3) %arrayidx346.3, align 2, !tbaa !182
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %65, i64 3
  %add341.1592 = or disjoint i32 %mul337, %and343
  %add344.1593 = or disjoint i32 %add341.1592, 16
  %arrayidx346.1594 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1593
  %66 = load half, ptr addrspace(3) %arrayidx346.1594, align 2, !tbaa !182
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add341.1.1 = or disjoint i32 %mul337, %and343
  %add344.1.1 = or disjoint i32 %add341.1.1, 80
  %arrayidx346.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1.1
  %67 = load half, ptr addrspace(3) %arrayidx346.1.1, align 2, !tbaa !182
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %67, i64 1
  %add341.2.1 = or disjoint i32 %mul337, %and343
  %add344.2.1 = or disjoint i32 %add341.2.1, 144
  %arrayidx346.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2.1
  %68 = load half, ptr addrspace(3) %arrayidx346.2.1, align 2, !tbaa !182
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %68, i64 2
  %add341.3.1 = or disjoint i32 %mul337, %and343
  %add344.3.1 = or disjoint i32 %add341.3.1, 208
  %arrayidx346.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3.1
  %69 = load half, ptr addrspace(3) %arrayidx346.3.1, align 2, !tbaa !182
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %69, i64 3
  %add341.2596 = or disjoint i32 %mul337, %and343
  %add344.2597 = or disjoint i32 %add341.2596, 32
  %arrayidx346.2598 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2597
  %70 = load half, ptr addrspace(3) %arrayidx346.2598, align 2, !tbaa !182
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %70, i64 0
  %add341.1.2 = or disjoint i32 %mul337, %and343
  %add344.1.2 = or disjoint i32 %add341.1.2, 96
  %arrayidx346.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1.2
  %71 = load half, ptr addrspace(3) %arrayidx346.1.2, align 2, !tbaa !182
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %71, i64 1
  %add341.2.2 = or disjoint i32 %mul337, %and343
  %add344.2.2 = or disjoint i32 %add341.2.2, 160
  %arrayidx346.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2.2
  %72 = load half, ptr addrspace(3) %arrayidx346.2.2, align 2, !tbaa !182
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %72, i64 2
  %add341.3.2 = or disjoint i32 %mul337, %and343
  %add344.3.2 = or disjoint i32 %add341.3.2, 224
  %arrayidx346.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3.2
  %73 = load half, ptr addrspace(3) %arrayidx346.3.2, align 2, !tbaa !182
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %73, i64 3
  %add341.3600 = or disjoint i32 %mul337, %and343
  %add344.3601 = or disjoint i32 %add341.3600, 48
  %arrayidx346.3602 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3601
  %74 = load half, ptr addrspace(3) %arrayidx346.3602, align 2, !tbaa !182
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %74, i64 0
  %add341.1.3 = or disjoint i32 %mul337, %and343
  %add344.1.3 = or disjoint i32 %add341.1.3, 112
  %arrayidx346.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1.3
  %75 = load half, ptr addrspace(3) %arrayidx346.1.3, align 2, !tbaa !182
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %75, i64 1
  %add341.2.3 = or disjoint i32 %mul337, %and343
  %add344.2.3 = or disjoint i32 %add341.2.3, 176
  %arrayidx346.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2.3
  %76 = load half, ptr addrspace(3) %arrayidx346.2.3, align 2, !tbaa !182
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %76, i64 2
  %add341.3.3 = or disjoint i32 %add.ptr253.idx, %and343
  %add344.3.3 = or i32 %add341.3.3, 240
  %arrayidx346.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3.3
  %77 = load half, ptr addrspace(3) %arrayidx346.3.3, align 2, !tbaa !182
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %77, i64 3
  %78 = fptrunc float %mul308.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %78, i64 3
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end375

if.end375:                                        ; preds = %entry.if.end375_crit_edge, %if.end197
  %mul402.pre-phi = phi i32 [ %.pre689, %entry.if.end375_crit_edge ], [ %mul124, %if.end197 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %79, %if.end197 ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %80, %if.end197 ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %81, %if.end197 ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %82, %if.end197 ]
  %add403 = or disjoint i32 %mul402.pre-phi, %mul
  %83 = lshr i32 %1, 2
  %mul408 = and i32 %83, 252
  %add405 = add nuw nsw i32 %add403, %mul408
  %84 = zext nneg i32 %add405 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %85 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %86 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %85), !noalias !190
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %88 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !noalias !190
  %89 = bitcast half %86 to i16
  %90 = bitcast half %88 to i16
  %91 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %92 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %91), !noalias !205
  %93 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %94 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %93), !noalias !205
  %95 = bitcast half %92 to i16
  %96 = bitcast half %94 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %96 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %95 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %90 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %89 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr411 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr411, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %97 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %98 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %97), !noalias !190
  %99 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %100 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %99), !noalias !190
  %101 = bitcast half %98 to i16
  %102 = bitcast half %100 to i16
  %103 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %104 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %103), !noalias !205
  %105 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %106 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %105), !noalias !205
  %107 = bitcast half %104 to i16
  %108 = bitcast half %106 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %108 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %107 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %102 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %101 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %109 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84
  %add.ptr411.1 = getelementptr inbounds i8, ptr addrspace(1) %109, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr411.1, align 8
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %111 = fptrunc float %acc_o.sroa.22.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !noalias !190
  %112 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %113 = fptrunc float %acc_o.sroa.22.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %112), !noalias !190
  %114 = bitcast half %111 to i16
  %115 = bitcast half %113 to i16
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %117 = fptrunc float %acc_o.sroa.22.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !noalias !205
  %118 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %119 = fptrunc float %acc_o.sroa.22.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %118), !noalias !205
  %120 = bitcast half %117 to i16
  %121 = bitcast half %119 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %121 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %120 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %115 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %114 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %122 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84
  %add.ptr411.2 = getelementptr inbounds i8, ptr addrspace(1) %122, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr411.2, align 8
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %123 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %124 = fptrunc float %acc_o.sroa.32.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %123), !noalias !190
  %125 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %126 = fptrunc float %acc_o.sroa.32.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %125), !noalias !190
  %127 = bitcast half %124 to i16
  %128 = bitcast half %126 to i16
  %129 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %130 = fptrunc float %acc_o.sroa.32.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %129), !noalias !205
  %131 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %132 = fptrunc float %acc_o.sroa.32.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %131), !noalias !205
  %133 = bitcast half %130 to i16
  %134 = bitcast half %132 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %134 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %133 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %128 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %127 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %135 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84
  %add.ptr411.3 = getelementptr inbounds i8, ptr addrspace(1) %135, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr411.3, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #7

declare float @llvm.exp2.f32(float) #8

declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

declare float @llvm.minnum.f32(float, float) #8

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


