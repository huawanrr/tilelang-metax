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
  %mul = shl nsw i32 %0, 11
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64
  %3 = add nuw nsw i64 %2, 512
  %4 = add nuw nsw i64 %2, 1024
  %5 = add nuw nsw i64 %2, 1536
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp28 = icmp ugt i32 %6, 95
  %shr = lshr i32 %0, 4
  %cmp31.not = icmp ugt i32 %6, %shr
  %or.cond630 = or i1 %cmp28, %cmp31.not
  br i1 %or.cond630, label %if.end330, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2
  %mul43 = shl nuw nsw i32 %6, 11
  %add45 = add nuw nsw i32 %mul43, %mul8
  %7 = zext nneg i32 %add45 to i64
  %add.ptr52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr52, align 4, !tbaa !30
  %9 = or disjoint i64 %7, 2
  %add.ptr52.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr52.1, align 4, !tbaa !30
  %11 = or disjoint i64 %7, 4
  %add.ptr52.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr52.2, align 4, !tbaa !30
  %13 = or disjoint i64 %7, 6
  %add.ptr52.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr52.3, align 4, !tbaa !30
  %15 = add nuw nsw i64 %7, 512
  %add.ptr52.1647 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr52.1647, align 4, !tbaa !30
  %17 = add nuw nsw i64 %7, 514
  %add.ptr52.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr52.1.1, align 4, !tbaa !30
  %19 = add nuw nsw i64 %7, 516
  %add.ptr52.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr52.2.1, align 4, !tbaa !30
  %21 = add nuw nsw i64 %7, 518
  %add.ptr52.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr52.3.1, align 4, !tbaa !30
  %23 = add nuw nsw i64 %7, 1024
  %add.ptr52.2649 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23
  %24 = load i32, ptr addrspace(4) %add.ptr52.2649, align 4, !tbaa !30
  %25 = add nuw nsw i64 %7, 1026
  %add.ptr52.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25
  %26 = load i32, ptr addrspace(4) %add.ptr52.1.2, align 4, !tbaa !30
  %27 = add nuw nsw i64 %7, 1028
  %add.ptr52.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27
  %28 = load i32, ptr addrspace(4) %add.ptr52.2.2, align 4, !tbaa !30
  %29 = add nuw nsw i64 %7, 1030
  %add.ptr52.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %29
  %30 = load i32, ptr addrspace(4) %add.ptr52.3.2, align 4, !tbaa !30
  %31 = add nuw nsw i64 %7, 1536
  %add.ptr52.3651 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %31
  %32 = load i32, ptr addrspace(4) %add.ptr52.3651, align 4, !tbaa !30
  %33 = add nuw nsw i64 %7, 1538
  %add.ptr52.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %33
  %34 = load i32, ptr addrspace(4) %add.ptr52.1.3, align 4, !tbaa !30
  %35 = add nuw nsw i64 %7, 1540
  %add.ptr52.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %35
  %36 = load i32, ptr addrspace(4) %add.ptr52.2.3, align 4, !tbaa !30
  %37 = add nuw nsw i64 %7, 1542
  %add.ptr52.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %37
  %38 = load i32, ptr addrspace(4) %add.ptr52.3.3, align 4, !tbaa !30
  %add.ptr82 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %39 = load i32, ptr addrspace(4) %add.ptr82, align 4, !tbaa !30
  %add.ptr82.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %40 = load i32, ptr addrspace(4) %add.ptr82.1, align 4, !tbaa !30
  %add.ptr82.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %41 = load i32, ptr addrspace(4) %add.ptr82.2, align 4, !tbaa !30
  %add.ptr82.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %42 = load i32, ptr addrspace(4) %add.ptr82.3, align 4, !tbaa !30
  %add.ptr82.1663 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %43 = load i32, ptr addrspace(4) %add.ptr82.1663, align 4, !tbaa !30
  %add.ptr82.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %44 = load i32, ptr addrspace(4) %add.ptr82.1.1, align 4, !tbaa !30
  %add.ptr82.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %45 = load i32, ptr addrspace(4) %add.ptr82.2.1, align 4, !tbaa !30
  %add.ptr82.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %46 = load i32, ptr addrspace(4) %add.ptr82.3.1, align 4, !tbaa !30
  %add.ptr82.2665 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23
  %47 = load i32, ptr addrspace(4) %add.ptr82.2665, align 4, !tbaa !30
  %add.ptr82.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25
  %48 = load i32, ptr addrspace(4) %add.ptr82.1.2, align 4, !tbaa !30
  %add.ptr82.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27
  %49 = load i32, ptr addrspace(4) %add.ptr82.2.2, align 4, !tbaa !30
  %add.ptr82.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %29
  %50 = load i32, ptr addrspace(4) %add.ptr82.3.2, align 4, !tbaa !30
  %add.ptr82.3667 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %31
  %51 = load i32, ptr addrspace(4) %add.ptr82.3667, align 4, !tbaa !30
  %add.ptr82.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %33
  %52 = load i32, ptr addrspace(4) %add.ptr82.1.3, align 4, !tbaa !30
  %add.ptr82.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %35
  %53 = load i32, ptr addrspace(4) %add.ptr82.2.3, align 4, !tbaa !30
  %add.ptr82.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %37
  %54 = load i32, ptr addrspace(4) %add.ptr82.3.3, align 4, !tbaa !30
  %mul106 = and i32 %mul8, 8064
  %and = and i32 %1, 15
  %shr111 = lshr i32 %1, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul106
  %xor = xor i32 %shr111, %and
  %add.ptr116.idx = shl nuw nsw i32 %xor, 4
  %add.ptr116 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr116.idx
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr116, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %add112.1 = add nuw nsw i32 %shr111, 4
  %xor.1 = xor i32 %add112.1, %and
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr116.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr116.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr116.idx.1
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr116.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
  %add112.2 = add nuw nsw i32 %shr111, 8
  %xor.2 = xor i32 %add112.2, %and
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr116.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr116.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr116.idx.2
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr116.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !call_argsrelate !58
  %add112.3 = add nuw nsw i32 %shr111, 12
  %xor.3 = xor i32 %add112.3, %and
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr116.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr116.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr116.idx.3
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr116.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !call_argsrelate !58
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and125 = shl nuw nsw i32 %1, 7
  %mul126 = and i32 %and125, 1920
  %55 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul126
  %add.ptr137 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr116.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137, align 16
  %Q_reg.sroa.4.0.add.ptr137.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr137, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr137.sroa_idx, align 8
  %add.ptr137.1 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr116.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137.1, align 16
  %Q_reg.sroa.7.16.add.ptr137.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr137.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr137.1.sroa_idx, align 8
  %add.ptr137.2 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr116.idx.2
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137.2, align 16
  %Q_reg.sroa.10.32.add.ptr137.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr137.2, i32 8
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr137.2.sroa_idx, align 8
  %add.ptr137.3 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr116.idx.3
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137.3, align 16
  %Q_reg.sroa.13.48.add.ptr137.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr137.3, i32 8
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr137.3.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %8, ptr addrspace(3) %add.ptr116, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr168.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116, i32 4
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr168.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr168.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116, i32 8
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr168.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr168.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116, i32 12
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr168.sroa_idx, align 4, !tbaa !30
  store i32 %16, ptr addrspace(3) %add.ptr116.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr168.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.1, i32 4
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr168.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr168.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.1, i32 8
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr168.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr168.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.1, i32 12
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr168.1.sroa_idx, align 4, !tbaa !30
  store i32 %24, ptr addrspace(3) %add.ptr116.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr168.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.2, i32 4
  store i32 %26, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr168.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr168.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.2, i32 8
  store i32 %28, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr168.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr168.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.2, i32 12
  store i32 %30, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr168.2.sroa_idx, align 4, !tbaa !30
  store i32 %32, ptr addrspace(3) %add.ptr116.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr168.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.3, i32 4
  store i32 %34, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr168.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr168.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.3, i32 8
  store i32 %36, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr168.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr168.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr116.3, i32 12
  store i32 %38, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr168.3.sroa_idx, align 4, !tbaa !30
  %mul32 = shl nuw nsw i32 %6, 4
  %add174 = or disjoint i32 %mul32, 15
  %cmp175 = icmp ult i32 %0, %add174
  br i1 %cmp175, label %for.cond177.preheader, label %if.end201

for.cond177.preheader:                            ; preds = %if.then
  %56 = lshr i32 %1, 2
  %mul183 = and i32 %56, 252
  %add185 = add nuw nsw i32 %mul32, %mul183
  %cmp188.not = icmp ugt i32 %add185, %0
  %spec.select = select i1 %cmp188.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert717 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp188.not.1.not = icmp ult i32 %add185, %0
  %spec.select.1 = select i1 %cmp188.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert730 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert717, float %spec.select.1, i64 1
  %add186.2 = or disjoint i32 %add185, 2
  %cmp188.not.2 = icmp ugt i32 %add186.2, %0
  %spec.select.2 = select i1 %cmp188.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert743 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert730, float %spec.select.2, i64 2
  %add186.3 = or disjoint i32 %add185, 3
  %cmp188.not.3 = icmp ugt i32 %add186.3, %0
  %spec.select.3 = select i1 %cmp188.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert756 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert743, float %spec.select.3, i64 3
  br label %if.end201

if.end201:                                        ; preds = %if.then, %for.cond177.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert756, %for.cond177.preheader ], [ zeroinitializer, %if.then ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137, align 16
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr137.sroa_idx, align 8
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0)
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %57)
  %kb.sroa.0.0.copyload705 = load <4 x half>, ptr addrspace(3) %add.ptr137.1, align 16
  %kb.sroa.10.0.copyload708 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr137.1.sroa_idx, align 8
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload705, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %58)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload708, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %59)
  %kb.sroa.0.0.copyload706 = load <4 x half>, ptr addrspace(3) %add.ptr137.2, align 16
  %kb.sroa.10.0.copyload709 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr137.2.sroa_idx, align 8
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload706, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %60)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload709, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %61)
  %kb.sroa.0.0.copyload707 = load <4 x half>, ptr addrspace(3) %add.ptr137.3, align 16
  %kb.sroa.10.0.copyload710 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr137.3.sroa_idx, align 8
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload707, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %62)
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload710, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %63)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr257.idx = shl nuw nsw i32 %1, 4
  %invariant.gep612 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr257.idx
  store i32 %39, ptr addrspace(3) %invariant.gep612, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep612.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 4
  store i32 %40, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep612.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep612.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 8
  store i32 %41, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep612.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep612.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 12
  store i32 %42, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep612.sroa_idx, align 4, !tbaa !30
  %gep613.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1024
  store i32 %43, ptr addrspace(3) %gep613.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep613.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1028
  store i32 %44, ptr addrspace(3) %V_reg.sroa.9.16.gep613.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep613.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1032
  store i32 %45, ptr addrspace(3) %V_reg.sroa.10.16.gep613.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep613.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1036
  store i32 %46, ptr addrspace(3) %V_reg.sroa.11.16.gep613.1.sroa_idx, align 4, !tbaa !30
  %gep613.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 2048
  store i32 %47, ptr addrspace(3) %gep613.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep613.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 2052
  store i32 %48, ptr addrspace(3) %V_reg.sroa.14.32.gep613.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep613.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 2056
  store i32 %49, ptr addrspace(3) %V_reg.sroa.15.32.gep613.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep613.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 2060
  store i32 %50, ptr addrspace(3) %V_reg.sroa.16.32.gep613.2.sroa_idx, align 4, !tbaa !30
  %gep613.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 3072
  store i32 %51, ptr addrspace(3) %gep613.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep613.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 3076
  store i32 %52, ptr addrspace(3) %V_reg.sroa.19.48.gep613.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep613.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 3080
  store i32 %53, ptr addrspace(3) %V_reg.sroa.20.48.gep613.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep613.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 3084
  store i32 %54, ptr addrspace(3) %V_reg.sroa.21.48.gep613.3.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %64, i64 0
  %mul267 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %65 = tail call contract noundef float @llvm.minnum.f32(float %mul267, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %65, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %65, %cond.i.i
  %66 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %66
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %64, i64 1
  %mul267.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul267.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %67, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %67, %cond.i.i.1
  %68 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %68
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %64, i64 2
  %mul267.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul267.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %69, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %69, %cond.i.i.2
  %70 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %70
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %64, i64 3
  %mul267.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul267.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %71, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %71, %cond.i.i.3
  %72 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %72
  %add283 = fadd contract float %mul.i.i, 0.000000e+00
  %add283.1 = fadd contract float %add283, %mul.i.i.1
  %add283.2 = fadd contract float %add283.1, %mul.i.i.2
  %add283.3 = fadd contract float %add283.2, %mul.i.i.3
  %73 = bitcast float %add283.3 to i32
  %74 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %75 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %74) #11
  %xor.i.i = xor i32 %75, 32
  %76 = and i32 %75, -64
  %and.i.i = add nsw i32 %76, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i587 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %75
  %shl.i.i = shl i32 %cond.i.i587, 2
  %77 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %73)
  %78 = bitcast i32 %77 to float
  %add291 = fadd contract float %add283.3, %78
  %79 = bitcast float %add291 to i32
  %80 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %81 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %80) #11
  %xor.i.i588 = xor i32 %81, 16
  %82 = and i32 %81, -64
  %and.i.i589 = add nsw i32 %82, 64
  %cmp.not.i.i590 = icmp slt i32 %xor.i.i588, %and.i.i589
  %cond.i.i591 = select i1 %cmp.not.i.i590, i32 %xor.i.i588, i32 %81
  %shl.i.i592 = shl i32 %cond.i.i591, 2
  %83 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i592, i32 %79)
  %84 = bitcast i32 %83 to float
  %add296 = fadd contract float %add291, %84
  %cmp299 = fcmp contract ogt float %add296, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add296
  %condval_1.0 = select i1 %cmp299, float %div, float 0.000000e+00
  %mul312 = fmul contract float %condval_1.0, %mul.i.i
  %mul312.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul312.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul312.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul312)
  %86 = insertelement <4 x i16> poison, i16 %85, i64 0
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul312.1)
  %88 = insertelement <4 x i16> %86, i16 %87, i64 1
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul312.2)
  %90 = insertelement <4 x i16> %88, i16 %89, i64 2
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul312.3)
  %92 = insertelement <4 x i16> %90, i16 %91, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %92 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end330

if.end330:                                        ; preds = %if.end201, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end201 ]
  br i1 %or.cond630, label %if.end330.if.end400_crit_edge, label %for.cond352.preheader

if.end330.if.end400_crit_edge:                    ; preds = %if.end330
  %.pre = and i32 %1, 15
  br label %if.end400

for.cond352.preheader:                            ; preds = %if.end330
  %93 = shl nuw nsw i32 %1, 5
  %mul362 = and i32 %93, 32256
  %and368 = and i32 %1, 15
  %add369 = or disjoint i32 %mul362, %and368
  %arrayidx371 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369
  %94 = load half, ptr addrspace(3) %arrayidx371, align 2, !tbaa !164
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %94, i64 0
  %add364.1 = or disjoint i32 %mul362, %and368
  %add369.1 = or disjoint i32 %add364.1, 128
  %arrayidx371.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1
  %95 = load half, ptr addrspace(3) %arrayidx371.1, align 2, !tbaa !164
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %95, i64 1
  %add364.2 = or disjoint i32 %mul362, %and368
  %add369.2 = or disjoint i32 %add364.2, 256
  %arrayidx371.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2
  %96 = load half, ptr addrspace(3) %arrayidx371.2, align 2, !tbaa !164
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %96, i64 2
  %add364.3 = or disjoint i32 %mul362, %and368
  %add369.3 = or disjoint i32 %add364.3, 384
  %arrayidx371.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3
  %97 = load half, ptr addrspace(3) %arrayidx371.3, align 2, !tbaa !164
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %97, i64 3
  %add366.1671 = or disjoint i32 %mul362, %and368
  %add369.1672 = or disjoint i32 %add366.1671, 16
  %arrayidx371.1673 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1672
  %98 = load half, ptr addrspace(3) %arrayidx371.1673, align 2, !tbaa !164
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %98, i64 0
  %add366.1.1 = or disjoint i32 %mul362, %and368
  %add369.1.1 = or disjoint i32 %add366.1.1, 144
  %arrayidx371.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1.1
  %99 = load half, ptr addrspace(3) %arrayidx371.1.1, align 2, !tbaa !164
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %99, i64 1
  %add366.2.1 = or disjoint i32 %mul362, %and368
  %add369.2.1 = or disjoint i32 %add366.2.1, 272
  %arrayidx371.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2.1
  %100 = load half, ptr addrspace(3) %arrayidx371.2.1, align 2, !tbaa !164
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %100, i64 2
  %add366.3.1 = or disjoint i32 %mul362, %and368
  %add369.3.1 = or disjoint i32 %add366.3.1, 400
  %arrayidx371.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3.1
  %101 = load half, ptr addrspace(3) %arrayidx371.3.1, align 2, !tbaa !164
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %101, i64 3
  %add366.2675 = or disjoint i32 %mul362, %and368
  %add369.2676 = or disjoint i32 %add366.2675, 32
  %arrayidx371.2677 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2676
  %102 = load half, ptr addrspace(3) %arrayidx371.2677, align 2, !tbaa !164
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %102, i64 0
  %add366.1.2 = or disjoint i32 %mul362, %and368
  %add369.1.2 = or disjoint i32 %add366.1.2, 160
  %arrayidx371.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1.2
  %103 = load half, ptr addrspace(3) %arrayidx371.1.2, align 2, !tbaa !164
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %103, i64 1
  %add366.2.2 = or disjoint i32 %mul362, %and368
  %add369.2.2 = or disjoint i32 %add366.2.2, 288
  %arrayidx371.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2.2
  %104 = load half, ptr addrspace(3) %arrayidx371.2.2, align 2, !tbaa !164
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %104, i64 2
  %add366.3.2 = or disjoint i32 %mul362, %and368
  %add369.3.2 = or disjoint i32 %add366.3.2, 416
  %arrayidx371.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3.2
  %105 = load half, ptr addrspace(3) %arrayidx371.3.2, align 2, !tbaa !164
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %105, i64 3
  %add366.3679 = or disjoint i32 %mul362, %and368
  %add369.3680 = or disjoint i32 %add366.3679, 48
  %arrayidx371.3681 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3680
  %106 = load half, ptr addrspace(3) %arrayidx371.3681, align 2, !tbaa !164
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %106, i64 0
  %add366.1.3 = or disjoint i32 %mul362, %and368
  %add369.1.3 = or disjoint i32 %add366.1.3, 176
  %arrayidx371.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1.3
  %107 = load half, ptr addrspace(3) %arrayidx371.1.3, align 2, !tbaa !164
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %107, i64 1
  %add366.2.3 = or disjoint i32 %mul362, %and368
  %add369.2.3 = or disjoint i32 %add366.2.3, 304
  %arrayidx371.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2.3
  %108 = load half, ptr addrspace(3) %arrayidx371.2.3, align 2, !tbaa !164
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %108, i64 2
  %add366.3.3 = or disjoint i32 %mul362, %and368
  %add369.3.3 = or disjoint i32 %add366.3.3, 432
  %arrayidx371.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3.3
  %109 = load half, ptr addrspace(3) %arrayidx371.3.3, align 2, !tbaa !164
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %109, i64 3
  %add366.4 = or disjoint i32 %mul362, %and368
  %add369.4 = or disjoint i32 %add366.4, 64
  %arrayidx371.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.4
  %110 = load half, ptr addrspace(3) %arrayidx371.4, align 2, !tbaa !164
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %110, i64 0
  %add366.1.4 = or disjoint i32 %mul362, %and368
  %add369.1.4 = or disjoint i32 %add366.1.4, 192
  %arrayidx371.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1.4
  %111 = load half, ptr addrspace(3) %arrayidx371.1.4, align 2, !tbaa !164
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %111, i64 1
  %add366.2.4 = or disjoint i32 %mul362, %and368
  %add369.2.4 = or disjoint i32 %add366.2.4, 320
  %arrayidx371.2.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2.4
  %112 = load half, ptr addrspace(3) %arrayidx371.2.4, align 2, !tbaa !164
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %112, i64 2
  %add366.3.4 = or disjoint i32 %mul362, %and368
  %add369.3.4 = or disjoint i32 %add366.3.4, 448
  %arrayidx371.3.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3.4
  %113 = load half, ptr addrspace(3) %arrayidx371.3.4, align 2, !tbaa !164
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %113, i64 3
  %add366.5 = or disjoint i32 %mul362, %and368
  %add369.5 = or disjoint i32 %add366.5, 80
  %arrayidx371.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.5
  %114 = load half, ptr addrspace(3) %arrayidx371.5, align 2, !tbaa !164
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %114, i64 0
  %add366.1.5 = or disjoint i32 %mul362, %and368
  %add369.1.5 = or disjoint i32 %add366.1.5, 208
  %arrayidx371.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1.5
  %115 = load half, ptr addrspace(3) %arrayidx371.1.5, align 2, !tbaa !164
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %115, i64 1
  %add366.2.5 = or disjoint i32 %mul362, %and368
  %add369.2.5 = or disjoint i32 %add366.2.5, 336
  %arrayidx371.2.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2.5
  %116 = load half, ptr addrspace(3) %arrayidx371.2.5, align 2, !tbaa !164
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %116, i64 2
  %add366.3.5 = or disjoint i32 %mul362, %and368
  %add369.3.5 = or disjoint i32 %add366.3.5, 464
  %arrayidx371.3.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3.5
  %117 = load half, ptr addrspace(3) %arrayidx371.3.5, align 2, !tbaa !164
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %117, i64 3
  %add366.6 = or disjoint i32 %mul362, %and368
  %add369.6 = or disjoint i32 %add366.6, 96
  %arrayidx371.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.6
  %118 = load half, ptr addrspace(3) %arrayidx371.6, align 2, !tbaa !164
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %118, i64 0
  %add366.1.6 = or disjoint i32 %mul362, %and368
  %add369.1.6 = or disjoint i32 %add366.1.6, 224
  %arrayidx371.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1.6
  %119 = load half, ptr addrspace(3) %arrayidx371.1.6, align 2, !tbaa !164
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %119, i64 1
  %add366.2.6 = or disjoint i32 %mul362, %and368
  %add369.2.6 = or disjoint i32 %add366.2.6, 352
  %arrayidx371.2.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2.6
  %120 = load half, ptr addrspace(3) %arrayidx371.2.6, align 2, !tbaa !164
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %120, i64 2
  %add366.3.6 = or disjoint i32 %93, %and368
  %add369.3.6 = or i32 %add366.3.6, 480
  %arrayidx371.3.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3.6
  %121 = load half, ptr addrspace(3) %arrayidx371.3.6, align 2, !tbaa !164
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %121, i64 3
  %add366.7 = or disjoint i32 %mul362, %and368
  %add369.7 = or disjoint i32 %add366.7, 112
  %arrayidx371.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.7
  %122 = load half, ptr addrspace(3) %arrayidx371.7, align 2, !tbaa !164
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %122, i64 0
  %add366.1.7 = or disjoint i32 %mul362, %and368
  %add369.1.7 = or disjoint i32 %add366.1.7, 240
  %arrayidx371.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.1.7
  %123 = load half, ptr addrspace(3) %arrayidx371.1.7, align 2, !tbaa !164
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %123, i64 1
  %add366.2.7 = or disjoint i32 %mul362, %and368
  %add369.2.7 = or disjoint i32 %add366.2.7, 368
  %arrayidx371.2.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.2.7
  %124 = load half, ptr addrspace(3) %arrayidx371.2.7, align 2, !tbaa !164
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %124, i64 2
  %add366.3.7 = or disjoint i32 %93, %and368
  %add369.3.7 = or i32 %add366.3.7, 496
  %arrayidx371.3.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add369.3.7
  %125 = load half, ptr addrspace(3) %arrayidx371.3.7, align 2, !tbaa !164
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %125, i64 3
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end400

if.end400:                                        ; preds = %if.end330.if.end400_crit_edge, %for.cond352.preheader
  %and440.pre-phi = phi i32 [ %.pre, %if.end330.if.end400_crit_edge ], [ %and368, %for.cond352.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %126, %for.cond352.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %127, %for.cond352.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %128, %for.cond352.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %129, %for.cond352.preheader ]
  %acc_o.sroa.58.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %130, %for.cond352.preheader ]
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %131, %for.cond352.preheader ]
  %acc_o.sroa.86.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %132, %for.cond352.preheader ]
  %acc_o.sroa.100.0 = phi <4 x float> [ zeroinitializer, %if.end330.if.end400_crit_edge ], [ %133, %for.cond352.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %134 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %135 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %136 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %137 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %138 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %139 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %140 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %141 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %142 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %143 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %144 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %145 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %146 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %147 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %148 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %149 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %acc_o.sroa.58.64.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 0
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.64.vec.extract)
  %O_reg.sroa.22.32.insert.ext = zext i16 %150 to i64
  %acc_o.sroa.58.68.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 1
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.68.vec.extract)
  %O_reg.sroa.22.34.insert.ext = zext i16 %151 to i64
  %O_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.34.insert.ext, 16
  %O_reg.sroa.22.34.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.shift, %O_reg.sroa.22.32.insert.ext
  %acc_o.sroa.58.72.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 2
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.72.vec.extract)
  %O_reg.sroa.22.36.insert.ext = zext i16 %152 to i64
  %O_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.36.insert.ext, 32
  %O_reg.sroa.22.36.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.insert, %O_reg.sroa.22.36.insert.shift
  %acc_o.sroa.58.76.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 3
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.76.vec.extract)
  %O_reg.sroa.22.38.insert.ext = zext i16 %153 to i64
  %O_reg.sroa.22.38.insert.shift = shl nuw i64 %O_reg.sroa.22.38.insert.ext, 48
  %O_reg.sroa.22.38.insert.insert = or disjoint i64 %O_reg.sroa.22.36.insert.insert, %O_reg.sroa.22.38.insert.shift
  %acc_o.sroa.72.80.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.80.vec.extract)
  %O_reg.sroa.27.40.insert.ext = zext i16 %154 to i64
  %acc_o.sroa.72.84.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.84.vec.extract)
  %O_reg.sroa.27.42.insert.ext = zext i16 %155 to i64
  %O_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.42.insert.ext, 16
  %O_reg.sroa.27.42.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.shift, %O_reg.sroa.27.40.insert.ext
  %acc_o.sroa.72.88.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.88.vec.extract)
  %O_reg.sroa.27.44.insert.ext = zext i16 %156 to i64
  %O_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.44.insert.ext, 32
  %O_reg.sroa.27.44.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.insert, %O_reg.sroa.27.44.insert.shift
  %acc_o.sroa.72.92.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.92.vec.extract)
  %O_reg.sroa.27.46.insert.ext = zext i16 %157 to i64
  %O_reg.sroa.27.46.insert.shift = shl nuw i64 %O_reg.sroa.27.46.insert.ext, 48
  %O_reg.sroa.27.46.insert.insert = or disjoint i64 %O_reg.sroa.27.44.insert.insert, %O_reg.sroa.27.46.insert.shift
  %acc_o.sroa.86.96.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 0
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.96.vec.extract)
  %O_reg.sroa.32.48.insert.ext = zext i16 %158 to i64
  %acc_o.sroa.86.100.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 1
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.100.vec.extract)
  %O_reg.sroa.32.50.insert.ext = zext i16 %159 to i64
  %O_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.50.insert.ext, 16
  %O_reg.sroa.32.50.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.shift, %O_reg.sroa.32.48.insert.ext
  %acc_o.sroa.86.104.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 2
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.104.vec.extract)
  %O_reg.sroa.32.52.insert.ext = zext i16 %160 to i64
  %O_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.52.insert.ext, 32
  %O_reg.sroa.32.52.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.insert, %O_reg.sroa.32.52.insert.shift
  %acc_o.sroa.86.108.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 3
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.108.vec.extract)
  %O_reg.sroa.32.54.insert.ext = zext i16 %161 to i64
  %O_reg.sroa.32.54.insert.shift = shl nuw i64 %O_reg.sroa.32.54.insert.ext, 48
  %O_reg.sroa.32.54.insert.insert = or disjoint i64 %O_reg.sroa.32.52.insert.insert, %O_reg.sroa.32.54.insert.shift
  %acc_o.sroa.100.112.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 0
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.112.vec.extract)
  %O_reg.sroa.37.56.insert.ext = zext i16 %162 to i64
  %acc_o.sroa.100.116.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 1
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.116.vec.extract)
  %O_reg.sroa.37.58.insert.ext = zext i16 %163 to i64
  %O_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.58.insert.ext, 16
  %O_reg.sroa.37.58.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.shift, %O_reg.sroa.37.56.insert.ext
  %acc_o.sroa.100.120.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 2
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.120.vec.extract)
  %O_reg.sroa.37.60.insert.ext = zext i16 %164 to i64
  %O_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.60.insert.ext, 32
  %O_reg.sroa.37.60.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.insert, %O_reg.sroa.37.60.insert.shift
  %acc_o.sroa.100.124.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 3
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.124.vec.extract)
  %O_reg.sroa.37.62.insert.ext = zext i16 %165 to i64
  %O_reg.sroa.37.62.insert.shift = shl nuw i64 %O_reg.sroa.37.62.insert.ext, 48
  %O_reg.sroa.37.62.insert.insert = or disjoint i64 %O_reg.sroa.37.60.insert.insert, %O_reg.sroa.37.62.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and433 = shl nuw nsw i32 %1, 7
  %mul434 = and i32 %and433, 1920
  %shr437 = lshr i32 %1, 5
  %166 = lshr i32 %1, 2
  %mul447 = and i32 %166, 4
  %xor441 = xor i32 %shr437, %and440.pre-phi
  %mul442 = shl nuw nsw i32 %xor441, 3
  %add443 = add nuw nsw i32 %mul442, %mul434
  %add448 = or disjoint i32 %add443, %mul447
  %add.ptr450 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr450, align 8
  %add438.1 = add nuw nsw i32 %shr437, 2
  %xor441.1 = xor i32 %add438.1, %and440.pre-phi
  %mul442.1 = shl nuw nsw i32 %xor441.1, 3
  %add443.1 = add nuw nsw i32 %mul442.1, %mul434
  %add448.1 = or disjoint i32 %add443.1, %mul447
  %add.ptr450.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr450.1, align 8
  %add438.2 = add nuw nsw i32 %shr437, 4
  %xor441.2 = xor i32 %add438.2, %and440.pre-phi
  %mul442.2 = shl nuw nsw i32 %xor441.2, 3
  %add443.2 = add nuw nsw i32 %mul442.2, %mul434
  %add448.2 = or disjoint i32 %add443.2, %mul447
  %add.ptr450.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr450.2, align 8
  %add438.3 = add nuw nsw i32 %shr437, 6
  %xor441.3 = xor i32 %add438.3, %and440.pre-phi
  %mul442.3 = shl nuw nsw i32 %xor441.3, 3
  %add443.3 = add nuw nsw i32 %mul442.3, %mul434
  %add448.3 = or disjoint i32 %add443.3, %mul447
  %add.ptr450.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr450.3, align 8
  %add438.4 = add nuw nsw i32 %shr437, 8
  %xor441.4 = xor i32 %add438.4, %and440.pre-phi
  %mul442.4 = shl nuw nsw i32 %xor441.4, 3
  %add443.4 = add nuw nsw i32 %mul442.4, %mul434
  %add448.4 = or disjoint i32 %add443.4, %mul447
  %add.ptr450.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448.4
  store i64 %O_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr450.4, align 8
  %add438.5 = add nuw nsw i32 %shr437, 10
  %xor441.5 = xor i32 %add438.5, %and440.pre-phi
  %mul442.5 = shl nuw nsw i32 %xor441.5, 3
  %add443.5 = add nuw nsw i32 %mul442.5, %mul434
  %add448.5 = or disjoint i32 %add443.5, %mul447
  %add.ptr450.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448.5
  store i64 %O_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr450.5, align 8
  %add438.6 = add nuw nsw i32 %shr437, 12
  %xor441.6 = xor i32 %add438.6, %and440.pre-phi
  %mul442.6 = shl nuw nsw i32 %xor441.6, 3
  %add443.6 = add nuw nsw i32 %mul442.6, %mul434
  %add448.6 = or disjoint i32 %add443.6, %mul447
  %add.ptr450.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448.6
  store i64 %O_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr450.6, align 8
  %add438.7 = add nuw nsw i32 %shr437, 14
  %xor441.7 = xor i32 %add438.7, %and440.pre-phi
  %mul442.7 = shl nuw nsw i32 %xor441.7, 3
  %add443.7 = add nuw nsw i32 %mul442.7, %mul434
  %add448.7 = or disjoint i32 %add443.7, %mul447
  %add.ptr450.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add448.7
  store i64 %O_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr450.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul461 = and i32 %mul8, 8064
  %shr467 = lshr i32 %1, 4
  %invariant.gep627 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul461
  %xor469 = xor i32 %shr467, %and440.pre-phi
  %add.ptr473.idx = shl nuw nsw i32 %xor469, 4
  %add.ptr473 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 %add.ptr473.idx
  %add.ptr482 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr482, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr473, i64 16, i1 false), !tbaa.struct !195, !call_argsrelate !196
  %167 = add nuw nsw i32 %shr467, 4
  %xor469.1 = xor i32 %167, %and440.pre-phi
  %gep628.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 1024
  %add.ptr473.idx.1 = shl nuw nsw i32 %xor469.1, 4
  %add.ptr473.1 = getelementptr inbounds i8, ptr addrspace(3) %gep628.1, i32 %add.ptr473.idx.1
  %add.ptr482.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr482.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr473.1, i64 16, i1 false), !tbaa.struct !195, !call_argsrelate !196
  %168 = add nuw nsw i32 %shr467, 8
  %xor469.2 = xor i32 %168, %and440.pre-phi
  %gep628.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 2048
  %add.ptr473.idx.2 = shl nuw nsw i32 %xor469.2, 4
  %add.ptr473.2 = getelementptr inbounds i8, ptr addrspace(3) %gep628.2, i32 %add.ptr473.idx.2
  %add.ptr482.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr482.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr473.2, i64 16, i1 false), !tbaa.struct !195, !call_argsrelate !196
  %narrow = add nuw nsw i32 %shr467, 12
  %xor469.3 = xor i32 %narrow, %and440.pre-phi
  %gep628.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 3072
  %add.ptr473.idx.3 = shl nuw nsw i32 %xor469.3, 4
  %add.ptr473.3 = getelementptr inbounds i8, ptr addrspace(3) %gep628.3, i32 %add.ptr473.idx.3
  %add.ptr482.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr482.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr473.3, i64 16, i1 false), !tbaa.struct !195, !call_argsrelate !196
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

declare i16 @llvm.convert.to.fp16.f32(float) #7

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #8

declare float @llvm.exp2.f32(float) #9

declare float @llvm.minnum.f32(float, float) #9

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


