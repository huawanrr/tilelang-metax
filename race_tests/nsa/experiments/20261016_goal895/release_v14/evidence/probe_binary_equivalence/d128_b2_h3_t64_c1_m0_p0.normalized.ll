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
  %div = udiv i32 %0, 3
  %mul = mul nuw nsw i32 %div, 393216
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = mul nuw nsw i32 %1, 6144
  %2 = mul i32 %div, 3
  %rem.decomposed = sub i32 %0, %2
  %mul9 = shl nuw nsw i32 %rem.decomposed, 11
  %3 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul14 = shl nuw nsw i32 %3, 3
  %add = add nuw nsw i32 %mul14, %mul7
  %add10 = add nuw nsw i32 %add, %mul
  %add12 = add nuw nsw i32 %add10, %mul9
  %4 = zext nneg i32 %add12 to i64
  %5 = add nuw nsw i64 %4, 512
  %6 = add nuw nsw i64 %4, 1024
  %7 = add nuw nsw i64 %4, 1536
  %mul21 = mul nuw nsw i32 %div, 192
  %mul23 = mul nuw nsw i32 %1, 3
  %add24 = add nuw nsw i32 %rem.decomposed, %mul23
  %add27 = add nuw nsw i32 %add24, %mul21
  %idxprom = zext nneg i32 %add27 to i64
  %arrayidx28 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %8 = load i32, ptr addrspace(1) %arrayidx28, align 4, !tbaa !30
  %cmp43 = icmp ugt i32 %8, 3
  %shr = lshr i32 %1, 4
  %cmp46.not = icmp ugt i32 %8, %shr
  %or.cond = or i1 %cmp43, %cmp46.not
  br i1 %or.cond, label %if.end372, label %for.cond49.preheader

for.cond49.preheader:                             ; preds = %entry
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %7
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %mul60 = mul nuw nsw i32 %div, 24576
  %mul61 = mul nuw nsw i32 %8, 6144
  %shr66 = lshr i32 %3, 4
  %mul67 = mul nuw nsw i32 %shr66, 384
  %mul71 = shl nuw nsw i32 %rem.decomposed, 7
  %add62 = add nuw nsw i32 %mul67, %mul60
  %add64 = add nuw nsw i32 %add62, %mul71
  %mul74 = and i32 %mul14, 120
  %add68 = or disjoint i32 %add64, %mul74
  %add72 = add nuw nsw i32 %add68, %mul61
  %9 = zext nneg i32 %add72 to i64
  %add.ptr79 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr79, align 4, !tbaa !30
  %11 = or disjoint i64 %9, 2
  %add.ptr79.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr79.1, align 4, !tbaa !30
  %13 = or disjoint i64 %9, 4
  %add.ptr79.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr79.2, align 4, !tbaa !30
  %15 = or disjoint i64 %9, 6
  %add.ptr79.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr79.3, align 4, !tbaa !30
  %17 = add nuw nsw i64 %9, 1536
  %add.ptr79.1693 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr79.1693, align 4, !tbaa !30
  %19 = add nuw nsw i64 %9, 1538
  %add.ptr79.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr79.1.1, align 4, !tbaa !30
  %21 = add nuw nsw i64 %9, 1540
  %add.ptr79.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr79.2.1, align 4, !tbaa !30
  %23 = add nuw nsw i64 %9, 1542
  %add.ptr79.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23
  %24 = load i32, ptr addrspace(4) %add.ptr79.3.1, align 4, !tbaa !30
  %25 = add nuw nsw i64 %9, 3072
  %add.ptr79.2695 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25
  %26 = load i32, ptr addrspace(4) %add.ptr79.2695, align 4, !tbaa !30
  %27 = add nuw nsw i64 %9, 3074
  %add.ptr79.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27
  %28 = load i32, ptr addrspace(4) %add.ptr79.1.2, align 4, !tbaa !30
  %29 = add nuw nsw i64 %9, 3076
  %add.ptr79.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %29
  %30 = load i32, ptr addrspace(4) %add.ptr79.2.2, align 4, !tbaa !30
  %31 = add nuw nsw i64 %9, 3078
  %add.ptr79.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %31
  %32 = load i32, ptr addrspace(4) %add.ptr79.3.2, align 4, !tbaa !30
  %33 = add nuw nsw i64 %9, 4608
  %add.ptr79.3697 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %33
  %34 = load i32, ptr addrspace(4) %add.ptr79.3697, align 4, !tbaa !30
  %35 = add nuw nsw i64 %9, 4610
  %add.ptr79.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %35
  %36 = load i32, ptr addrspace(4) %add.ptr79.1.3, align 4, !tbaa !30
  %37 = add nuw nsw i64 %9, 4612
  %add.ptr79.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %37
  %38 = load i32, ptr addrspace(4) %add.ptr79.2.3, align 4, !tbaa !30
  %39 = add nuw nsw i64 %9, 4614
  %add.ptr79.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %39
  %40 = load i32, ptr addrspace(4) %add.ptr79.3.3, align 4, !tbaa !30
  %add.ptr122 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %41 = load i32, ptr addrspace(4) %add.ptr122, align 4, !tbaa !30
  %add.ptr122.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %42 = load i32, ptr addrspace(4) %add.ptr122.1, align 4, !tbaa !30
  %add.ptr122.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %43 = load i32, ptr addrspace(4) %add.ptr122.2, align 4, !tbaa !30
  %add.ptr122.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %44 = load i32, ptr addrspace(4) %add.ptr122.3, align 4, !tbaa !30
  %add.ptr122.1709 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %45 = load i32, ptr addrspace(4) %add.ptr122.1709, align 4, !tbaa !30
  %add.ptr122.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %46 = load i32, ptr addrspace(4) %add.ptr122.1.1, align 4, !tbaa !30
  %add.ptr122.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %47 = load i32, ptr addrspace(4) %add.ptr122.2.1, align 4, !tbaa !30
  %add.ptr122.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23
  %48 = load i32, ptr addrspace(4) %add.ptr122.3.1, align 4, !tbaa !30
  %add.ptr122.2711 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25
  %49 = load i32, ptr addrspace(4) %add.ptr122.2711, align 4, !tbaa !30
  %add.ptr122.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27
  %50 = load i32, ptr addrspace(4) %add.ptr122.1.2, align 4, !tbaa !30
  %add.ptr122.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %29
  %51 = load i32, ptr addrspace(4) %add.ptr122.2.2, align 4, !tbaa !30
  %add.ptr122.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %31
  %52 = load i32, ptr addrspace(4) %add.ptr122.3.2, align 4, !tbaa !30
  %add.ptr122.3713 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %33
  %53 = load i32, ptr addrspace(4) %add.ptr122.3713, align 4, !tbaa !30
  %add.ptr122.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %35
  %54 = load i32, ptr addrspace(4) %add.ptr122.1.3, align 4, !tbaa !30
  %add.ptr122.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %37
  %55 = load i32, ptr addrspace(4) %add.ptr122.2.3, align 4, !tbaa !30
  %add.ptr122.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %39
  %56 = load i32, ptr addrspace(4) %add.ptr122.3.3, align 4, !tbaa !30
  %mul146 = and i32 %mul14, 8064
  %and149 = and i32 %3, 15
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul146
  %xor = xor i32 %shr66, %and149
  %add.ptr157.idx = shl nuw nsw i32 %xor, 4
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr157.idx
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !62
  %add153.1 = add nuw nsw i32 %shr66, 4
  %xor.1 = xor i32 %add153.1, %and149
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr157.idx.1
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !62
  %add153.2 = add nuw nsw i32 %shr66, 8
  %xor.2 = xor i32 %add153.2, %and149
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr157.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr157.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr157.idx.2
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !call_argsrelate !62
  %add153.3 = add nuw nsw i32 %shr66, 12
  %xor.3 = xor i32 %add153.3, %and149
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr157.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr157.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr157.idx.3
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !call_argsrelate !62
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and166 = shl nuw nsw i32 %3, 7
  %mul167 = and i32 %and166, 1920
  %57 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul167
  %add.ptr178 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16
  %Q_reg.sroa.4.0.add.ptr178.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8
  %add.ptr178.1 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16
  %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8
  %add.ptr178.2 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx.2
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.2, align 16
  %Q_reg.sroa.10.32.add.ptr178.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.2, i32 8
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr178.2.sroa_idx, align 8
  %add.ptr178.3 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx.3
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.3, align 16
  %Q_reg.sroa.13.48.add.ptr178.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.3, i32 8
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr178.3.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %10, ptr addrspace(3) %add.ptr157, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr209.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 4
  store i32 %12, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr209.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr209.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8
  store i32 %14, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr209.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr209.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 12
  store i32 %16, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr209.sroa_idx, align 4, !tbaa !30
  store i32 %18, ptr addrspace(3) %add.ptr157.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr209.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 4
  store i32 %20, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr209.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr209.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8
  store i32 %22, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr209.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr209.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 12
  store i32 %24, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr209.1.sroa_idx, align 4, !tbaa !30
  store i32 %26, ptr addrspace(3) %add.ptr157.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr209.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 4
  store i32 %28, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr209.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr209.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 8
  store i32 %30, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr209.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr209.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 12
  store i32 %32, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr209.2.sroa_idx, align 4, !tbaa !30
  store i32 %34, ptr addrspace(3) %add.ptr157.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr209.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 4
  store i32 %36, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr209.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr209.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 8
  store i32 %38, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr209.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr209.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 12
  store i32 %40, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr209.3.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %58)
  %kb.sroa.0.0.copyload751 = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16
  %kb.sroa.10.0.copyload754 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload751, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %59)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload754, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %60)
  %kb.sroa.0.0.copyload752 = load <4 x half>, ptr addrspace(3) %add.ptr178.2, align 16
  %kb.sroa.10.0.copyload755 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr178.2.sroa_idx, align 8
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload752, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %61)
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload755, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %62)
  %kb.sroa.0.0.copyload753 = load <4 x half>, ptr addrspace(3) %add.ptr178.3, align 16
  %kb.sroa.10.0.copyload756 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr178.3.sroa_idx, align 8
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload753, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %63)
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload756, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %64)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr272.idx = shl nuw nsw i32 %3, 4
  %invariant.gep658 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr272.idx
  store i32 %41, ptr addrspace(3) %invariant.gep658, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep658.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 4
  store i32 %42, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep658.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep658.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 8
  store i32 %43, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep658.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep658.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 12
  store i32 %44, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep658.sroa_idx, align 4, !tbaa !30
  %gep659.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1024
  store i32 %45, ptr addrspace(3) %gep659.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep659.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1028
  store i32 %46, ptr addrspace(3) %V_reg.sroa.9.16.gep659.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep659.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1032
  store i32 %47, ptr addrspace(3) %V_reg.sroa.10.16.gep659.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep659.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1036
  store i32 %48, ptr addrspace(3) %V_reg.sroa.11.16.gep659.1.sroa_idx, align 4, !tbaa !30
  %gep659.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2048
  store i32 %49, ptr addrspace(3) %gep659.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep659.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2052
  store i32 %50, ptr addrspace(3) %V_reg.sroa.14.32.gep659.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep659.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2056
  store i32 %51, ptr addrspace(3) %V_reg.sroa.15.32.gep659.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep659.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2060
  store i32 %52, ptr addrspace(3) %V_reg.sroa.16.32.gep659.2.sroa_idx, align 4, !tbaa !30
  %gep659.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3072
  store i32 %53, ptr addrspace(3) %gep659.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep659.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3076
  store i32 %54, ptr addrspace(3) %V_reg.sroa.19.48.gep659.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep659.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3080
  store i32 %55, ptr addrspace(3) %V_reg.sroa.20.48.gep659.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep659.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3084
  store i32 %56, ptr addrspace(3) %V_reg.sroa.21.48.gep659.3.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %65, i64 0
  %mul282 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul282, float 0x4024CB5EC0000000)
  %67 = tail call contract noundef float @llvm.exp.f32(float %66)
  %acc_s.sroa.0.0.vec.insert764 = insertelement <4 x float> poison, float %67, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %65, i64 1
  %mul282.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1, float 0x4024CB5EC0000000)
  %69 = tail call contract noundef float @llvm.exp.f32(float %68)
  %acc_s.sroa.0.4.vec.insert779 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert764, float %69, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %65, i64 2
  %mul282.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul282.2, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %acc_s.sroa.0.8.vec.insert794 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert779, float %71, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %65, i64 3
  %mul282.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul282.3, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %acc_s.sroa.0.12.vec.insert809 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert794, float %73, i64 3
  %cmp292 = icmp eq i32 %8, %shr
  br i1 %cmp292, label %for.cond294.preheader, label %if.end313

for.cond294.preheader:                            ; preds = %for.cond49.preheader
  %74 = lshr i32 %3, 2
  %mul300 = and i32 %74, 252
  %and303 = and i32 %1, 15
  %cmp304.not = icmp ugt i32 %mul300, %and303
  %spec.select = select i1 %cmp304.not, float 0.000000e+00, float %67
  %acc_s.sroa.0.0.vec.insert768 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp304.not.1.not = icmp ult i32 %mul300, %and303
  %condval.0.1 = select i1 %cmp304.not.1.not, float %69, float 0.000000e+00
  %acc_s.sroa.0.4.vec.insert783 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert768, float %condval.0.1, i64 1
  %add301.2 = or disjoint i32 %mul300, 2
  %cmp304.not.2 = icmp ugt i32 %add301.2, %and303
  %condval.0.2 = select i1 %cmp304.not.2, float 0.000000e+00, float %71
  %acc_s.sroa.0.8.vec.insert798 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert783, float %condval.0.2, i64 2
  %add301.3 = or i32 %74, 3
  %cmp304.not.3 = icmp ugt i32 %add301.3, %and303
  %condval.0.3 = select i1 %cmp304.not.3, float 0.000000e+00, float %73
  %acc_s.sroa.0.12.vec.insert813 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert798, float %condval.0.3, i64 3
  br label %if.end313

if.end313:                                        ; preds = %for.cond294.preheader, %for.cond49.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert813, %for.cond294.preheader ], [ %acc_s.sroa.0.12.vec.insert809, %for.cond49.preheader ]
  %acc_s.sroa.0.0.vec.extract770 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0
  %add322 = fadd contract float %acc_s.sroa.0.0.vec.extract770, 0.000000e+00
  %acc_s.sroa.0.4.vec.extract785 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %add322.1 = fadd contract float %add322, %acc_s.sroa.0.4.vec.extract785
  %acc_s.sroa.0.8.vec.extract800 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %add322.2 = fadd contract float %add322.1, %acc_s.sroa.0.8.vec.extract800
  %acc_s.sroa.0.12.vec.extract815 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %add322.3 = fadd contract float %add322.2, %acc_s.sroa.0.12.vec.extract815
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add322.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %75, i64 0
  %cmp340 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div343 = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp340, float %div343, float 0.000000e+00
  %mul354 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract770
  %acc_s.sroa.0.4.vec.extract787 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %mul354.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract787
  %acc_s.sroa.0.8.vec.extract802 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %mul354.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract802
  %acc_s.sroa.0.12.vec.extract817 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %mul354.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract817
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354)
  %77 = insertelement <4 x i16> poison, i16 %76, i64 0
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354.1)
  %79 = insertelement <4 x i16> %77, i16 %78, i64 1
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354.2)
  %81 = insertelement <4 x i16> %79, i16 %80, i64 2
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354.3)
  %83 = insertelement <4 x i16> %81, i16 %82, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %83 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end372

if.end372:                                        ; preds = %entry, %if.end313
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end313 ], [ undef, %entry ]
  %cmp388 = icmp ugt i32 %8, 3
  %cmp392.not = icmp ugt i32 %8, %shr
  %or.cond678 = or i1 %cmp388, %cmp392.not
  br i1 %or.cond678, label %if.end372.if.end442_crit_edge, label %for.cond394.preheader

if.end372.if.end442_crit_edge:                    ; preds = %if.end372
  %.pre926 = and i32 %3, 15
  br label %if.end442

for.cond394.preheader:                            ; preds = %if.end372
  %84 = shl nuw nsw i32 %3, 5
  %mul404 = and i32 %84, 32256
  %and410 = and i32 %3, 15
  %add411 = or disjoint i32 %mul404, %and410
  %arrayidx413 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411
  %85 = load half, ptr addrspace(3) %arrayidx413, align 2, !tbaa !141
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %85, i64 0
  %add406.1 = or disjoint i32 %mul404, %and410
  %add411.1 = or disjoint i32 %add406.1, 128
  %arrayidx413.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1
  %86 = load half, ptr addrspace(3) %arrayidx413.1, align 2, !tbaa !141
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %86, i64 1
  %add406.2 = or disjoint i32 %mul404, %and410
  %add411.2 = or disjoint i32 %add406.2, 256
  %arrayidx413.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2
  %87 = load half, ptr addrspace(3) %arrayidx413.2, align 2, !tbaa !141
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %87, i64 2
  %add406.3 = or disjoint i32 %mul404, %and410
  %add411.3 = or disjoint i32 %add406.3, 384
  %arrayidx413.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3
  %88 = load half, ptr addrspace(3) %arrayidx413.3, align 2, !tbaa !141
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %88, i64 3
  %add408.1717 = or disjoint i32 %mul404, %and410
  %add411.1718 = or disjoint i32 %add408.1717, 16
  %arrayidx413.1719 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1718
  %89 = load half, ptr addrspace(3) %arrayidx413.1719, align 2, !tbaa !141
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %89, i64 0
  %add408.1.1 = or disjoint i32 %mul404, %and410
  %add411.1.1 = or disjoint i32 %add408.1.1, 144
  %arrayidx413.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.1
  %90 = load half, ptr addrspace(3) %arrayidx413.1.1, align 2, !tbaa !141
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %90, i64 1
  %add408.2.1 = or disjoint i32 %mul404, %and410
  %add411.2.1 = or disjoint i32 %add408.2.1, 272
  %arrayidx413.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.1
  %91 = load half, ptr addrspace(3) %arrayidx413.2.1, align 2, !tbaa !141
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %91, i64 2
  %add408.3.1 = or disjoint i32 %mul404, %and410
  %add411.3.1 = or disjoint i32 %add408.3.1, 400
  %arrayidx413.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.1
  %92 = load half, ptr addrspace(3) %arrayidx413.3.1, align 2, !tbaa !141
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %92, i64 3
  %add408.2721 = or disjoint i32 %mul404, %and410
  %add411.2722 = or disjoint i32 %add408.2721, 32
  %arrayidx413.2723 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2722
  %93 = load half, ptr addrspace(3) %arrayidx413.2723, align 2, !tbaa !141
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %93, i64 0
  %add408.1.2 = or disjoint i32 %mul404, %and410
  %add411.1.2 = or disjoint i32 %add408.1.2, 160
  %arrayidx413.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.2
  %94 = load half, ptr addrspace(3) %arrayidx413.1.2, align 2, !tbaa !141
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %94, i64 1
  %add408.2.2 = or disjoint i32 %mul404, %and410
  %add411.2.2 = or disjoint i32 %add408.2.2, 288
  %arrayidx413.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.2
  %95 = load half, ptr addrspace(3) %arrayidx413.2.2, align 2, !tbaa !141
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %95, i64 2
  %add408.3.2 = or disjoint i32 %mul404, %and410
  %add411.3.2 = or disjoint i32 %add408.3.2, 416
  %arrayidx413.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.2
  %96 = load half, ptr addrspace(3) %arrayidx413.3.2, align 2, !tbaa !141
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %96, i64 3
  %add408.3725 = or disjoint i32 %mul404, %and410
  %add411.3726 = or disjoint i32 %add408.3725, 48
  %arrayidx413.3727 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3726
  %97 = load half, ptr addrspace(3) %arrayidx413.3727, align 2, !tbaa !141
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %97, i64 0
  %add408.1.3 = or disjoint i32 %mul404, %and410
  %add411.1.3 = or disjoint i32 %add408.1.3, 176
  %arrayidx413.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.3
  %98 = load half, ptr addrspace(3) %arrayidx413.1.3, align 2, !tbaa !141
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %98, i64 1
  %add408.2.3 = or disjoint i32 %mul404, %and410
  %add411.2.3 = or disjoint i32 %add408.2.3, 304
  %arrayidx413.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.3
  %99 = load half, ptr addrspace(3) %arrayidx413.2.3, align 2, !tbaa !141
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %99, i64 2
  %add408.3.3 = or disjoint i32 %mul404, %and410
  %add411.3.3 = or disjoint i32 %add408.3.3, 432
  %arrayidx413.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.3
  %100 = load half, ptr addrspace(3) %arrayidx413.3.3, align 2, !tbaa !141
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %100, i64 3
  %add408.4 = or disjoint i32 %mul404, %and410
  %add411.4 = or disjoint i32 %add408.4, 64
  %arrayidx413.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.4
  %101 = load half, ptr addrspace(3) %arrayidx413.4, align 2, !tbaa !141
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %101, i64 0
  %add408.1.4 = or disjoint i32 %mul404, %and410
  %add411.1.4 = or disjoint i32 %add408.1.4, 192
  %arrayidx413.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.4
  %102 = load half, ptr addrspace(3) %arrayidx413.1.4, align 2, !tbaa !141
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %102, i64 1
  %add408.2.4 = or disjoint i32 %mul404, %and410
  %add411.2.4 = or disjoint i32 %add408.2.4, 320
  %arrayidx413.2.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.4
  %103 = load half, ptr addrspace(3) %arrayidx413.2.4, align 2, !tbaa !141
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %103, i64 2
  %add408.3.4 = or disjoint i32 %mul404, %and410
  %add411.3.4 = or disjoint i32 %add408.3.4, 448
  %arrayidx413.3.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.4
  %104 = load half, ptr addrspace(3) %arrayidx413.3.4, align 2, !tbaa !141
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %104, i64 3
  %add408.5 = or disjoint i32 %mul404, %and410
  %add411.5 = or disjoint i32 %add408.5, 80
  %arrayidx413.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.5
  %105 = load half, ptr addrspace(3) %arrayidx413.5, align 2, !tbaa !141
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %105, i64 0
  %add408.1.5 = or disjoint i32 %mul404, %and410
  %add411.1.5 = or disjoint i32 %add408.1.5, 208
  %arrayidx413.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.5
  %106 = load half, ptr addrspace(3) %arrayidx413.1.5, align 2, !tbaa !141
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %106, i64 1
  %add408.2.5 = or disjoint i32 %mul404, %and410
  %add411.2.5 = or disjoint i32 %add408.2.5, 336
  %arrayidx413.2.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.5
  %107 = load half, ptr addrspace(3) %arrayidx413.2.5, align 2, !tbaa !141
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %107, i64 2
  %add408.3.5 = or disjoint i32 %mul404, %and410
  %add411.3.5 = or disjoint i32 %add408.3.5, 464
  %arrayidx413.3.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.5
  %108 = load half, ptr addrspace(3) %arrayidx413.3.5, align 2, !tbaa !141
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %108, i64 3
  %add408.6 = or disjoint i32 %mul404, %and410
  %add411.6 = or disjoint i32 %add408.6, 96
  %arrayidx413.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.6
  %109 = load half, ptr addrspace(3) %arrayidx413.6, align 2, !tbaa !141
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %109, i64 0
  %add408.1.6 = or disjoint i32 %mul404, %and410
  %add411.1.6 = or disjoint i32 %add408.1.6, 224
  %arrayidx413.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.6
  %110 = load half, ptr addrspace(3) %arrayidx413.1.6, align 2, !tbaa !141
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %110, i64 1
  %add408.2.6 = or disjoint i32 %mul404, %and410
  %add411.2.6 = or disjoint i32 %add408.2.6, 352
  %arrayidx413.2.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.6
  %111 = load half, ptr addrspace(3) %arrayidx413.2.6, align 2, !tbaa !141
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %111, i64 2
  %add408.3.6 = or disjoint i32 %84, %and410
  %add411.3.6 = or i32 %add408.3.6, 480
  %arrayidx413.3.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.6
  %112 = load half, ptr addrspace(3) %arrayidx413.3.6, align 2, !tbaa !141
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %112, i64 3
  %add408.7 = or disjoint i32 %mul404, %and410
  %add411.7 = or disjoint i32 %add408.7, 112
  %arrayidx413.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.7
  %113 = load half, ptr addrspace(3) %arrayidx413.7, align 2, !tbaa !141
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %113, i64 0
  %add408.1.7 = or disjoint i32 %mul404, %and410
  %add411.1.7 = or disjoint i32 %add408.1.7, 240
  %arrayidx413.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.7
  %114 = load half, ptr addrspace(3) %arrayidx413.1.7, align 2, !tbaa !141
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %114, i64 1
  %add408.2.7 = or disjoint i32 %mul404, %and410
  %add411.2.7 = or disjoint i32 %add408.2.7, 368
  %arrayidx413.2.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.7
  %115 = load half, ptr addrspace(3) %arrayidx413.2.7, align 2, !tbaa !141
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %115, i64 2
  %add408.3.7 = or disjoint i32 %84, %and410
  %add411.3.7 = or i32 %add408.3.7, 496
  %arrayidx413.3.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.7
  %116 = load half, ptr addrspace(3) %arrayidx413.3.7, align 2, !tbaa !141
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %116, i64 3
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end442

if.end442:                                        ; preds = %if.end372.if.end442_crit_edge, %for.cond394.preheader
  %and482.pre-phi = phi i32 [ %.pre926, %if.end372.if.end442_crit_edge ], [ %and410, %for.cond394.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %117, %for.cond394.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %118, %for.cond394.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %119, %for.cond394.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %120, %for.cond394.preheader ]
  %acc_o.sroa.58.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %121, %for.cond394.preheader ]
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %122, %for.cond394.preheader ]
  %acc_o.sroa.86.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %123, %for.cond394.preheader ]
  %acc_o.sroa.100.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %124, %for.cond394.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %125 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %126 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %127 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %128 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %129 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %130 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %131 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %132 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %133 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %134 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %135 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %136 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %137 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %138 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %139 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %140 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %acc_o.sroa.58.64.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 0
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.64.vec.extract)
  %O_reg.sroa.22.32.insert.ext = zext i16 %141 to i64
  %acc_o.sroa.58.68.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 1
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.68.vec.extract)
  %O_reg.sroa.22.34.insert.ext = zext i16 %142 to i64
  %O_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.34.insert.ext, 16
  %O_reg.sroa.22.34.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.shift, %O_reg.sroa.22.32.insert.ext
  %acc_o.sroa.58.72.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 2
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.72.vec.extract)
  %O_reg.sroa.22.36.insert.ext = zext i16 %143 to i64
  %O_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.36.insert.ext, 32
  %O_reg.sroa.22.36.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.insert, %O_reg.sroa.22.36.insert.shift
  %acc_o.sroa.58.76.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 3
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.76.vec.extract)
  %O_reg.sroa.22.38.insert.ext = zext i16 %144 to i64
  %O_reg.sroa.22.38.insert.shift = shl nuw i64 %O_reg.sroa.22.38.insert.ext, 48
  %O_reg.sroa.22.38.insert.insert = or disjoint i64 %O_reg.sroa.22.36.insert.insert, %O_reg.sroa.22.38.insert.shift
  %acc_o.sroa.72.80.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.80.vec.extract)
  %O_reg.sroa.27.40.insert.ext = zext i16 %145 to i64
  %acc_o.sroa.72.84.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.84.vec.extract)
  %O_reg.sroa.27.42.insert.ext = zext i16 %146 to i64
  %O_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.42.insert.ext, 16
  %O_reg.sroa.27.42.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.shift, %O_reg.sroa.27.40.insert.ext
  %acc_o.sroa.72.88.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.88.vec.extract)
  %O_reg.sroa.27.44.insert.ext = zext i16 %147 to i64
  %O_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.44.insert.ext, 32
  %O_reg.sroa.27.44.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.insert, %O_reg.sroa.27.44.insert.shift
  %acc_o.sroa.72.92.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.92.vec.extract)
  %O_reg.sroa.27.46.insert.ext = zext i16 %148 to i64
  %O_reg.sroa.27.46.insert.shift = shl nuw i64 %O_reg.sroa.27.46.insert.ext, 48
  %O_reg.sroa.27.46.insert.insert = or disjoint i64 %O_reg.sroa.27.44.insert.insert, %O_reg.sroa.27.46.insert.shift
  %acc_o.sroa.86.96.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 0
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.96.vec.extract)
  %O_reg.sroa.32.48.insert.ext = zext i16 %149 to i64
  %acc_o.sroa.86.100.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 1
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.100.vec.extract)
  %O_reg.sroa.32.50.insert.ext = zext i16 %150 to i64
  %O_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.50.insert.ext, 16
  %O_reg.sroa.32.50.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.shift, %O_reg.sroa.32.48.insert.ext
  %acc_o.sroa.86.104.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 2
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.104.vec.extract)
  %O_reg.sroa.32.52.insert.ext = zext i16 %151 to i64
  %O_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.52.insert.ext, 32
  %O_reg.sroa.32.52.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.insert, %O_reg.sroa.32.52.insert.shift
  %acc_o.sroa.86.108.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 3
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.108.vec.extract)
  %O_reg.sroa.32.54.insert.ext = zext i16 %152 to i64
  %O_reg.sroa.32.54.insert.shift = shl nuw i64 %O_reg.sroa.32.54.insert.ext, 48
  %O_reg.sroa.32.54.insert.insert = or disjoint i64 %O_reg.sroa.32.52.insert.insert, %O_reg.sroa.32.54.insert.shift
  %acc_o.sroa.100.112.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 0
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.112.vec.extract)
  %O_reg.sroa.37.56.insert.ext = zext i16 %153 to i64
  %acc_o.sroa.100.116.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 1
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.116.vec.extract)
  %O_reg.sroa.37.58.insert.ext = zext i16 %154 to i64
  %O_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.58.insert.ext, 16
  %O_reg.sroa.37.58.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.shift, %O_reg.sroa.37.56.insert.ext
  %acc_o.sroa.100.120.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 2
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.120.vec.extract)
  %O_reg.sroa.37.60.insert.ext = zext i16 %155 to i64
  %O_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.60.insert.ext, 32
  %O_reg.sroa.37.60.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.insert, %O_reg.sroa.37.60.insert.shift
  %acc_o.sroa.100.124.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 3
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.124.vec.extract)
  %O_reg.sroa.37.62.insert.ext = zext i16 %156 to i64
  %O_reg.sroa.37.62.insert.shift = shl nuw i64 %O_reg.sroa.37.62.insert.ext, 48
  %O_reg.sroa.37.62.insert.insert = or disjoint i64 %O_reg.sroa.37.60.insert.insert, %O_reg.sroa.37.62.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and475 = shl nuw nsw i32 %3, 7
  %mul476 = and i32 %and475, 1920
  %shr479 = lshr i32 %3, 5
  %157 = lshr i32 %3, 2
  %mul489 = and i32 %157, 4
  %xor483 = xor i32 %shr479, %and482.pre-phi
  %mul484 = shl nuw nsw i32 %xor483, 3
  %add485 = add nuw nsw i32 %mul484, %mul476
  %add490 = or disjoint i32 %add485, %mul489
  %add.ptr492 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr492, align 8
  %add480.1 = add nuw nsw i32 %shr479, 2
  %xor483.1 = xor i32 %add480.1, %and482.pre-phi
  %mul484.1 = shl nuw nsw i32 %xor483.1, 3
  %add485.1 = add nuw nsw i32 %mul484.1, %mul476
  %add490.1 = or disjoint i32 %add485.1, %mul489
  %add.ptr492.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr492.1, align 8
  %add480.2 = add nuw nsw i32 %shr479, 4
  %xor483.2 = xor i32 %add480.2, %and482.pre-phi
  %mul484.2 = shl nuw nsw i32 %xor483.2, 3
  %add485.2 = add nuw nsw i32 %mul484.2, %mul476
  %add490.2 = or disjoint i32 %add485.2, %mul489
  %add.ptr492.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr492.2, align 8
  %add480.3 = add nuw nsw i32 %shr479, 6
  %xor483.3 = xor i32 %add480.3, %and482.pre-phi
  %mul484.3 = shl nuw nsw i32 %xor483.3, 3
  %add485.3 = add nuw nsw i32 %mul484.3, %mul476
  %add490.3 = or disjoint i32 %add485.3, %mul489
  %add.ptr492.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr492.3, align 8
  %add480.4 = add nuw nsw i32 %shr479, 8
  %xor483.4 = xor i32 %add480.4, %and482.pre-phi
  %mul484.4 = shl nuw nsw i32 %xor483.4, 3
  %add485.4 = add nuw nsw i32 %mul484.4, %mul476
  %add490.4 = or disjoint i32 %add485.4, %mul489
  %add.ptr492.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.4
  store i64 %O_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr492.4, align 8
  %add480.5 = add nuw nsw i32 %shr479, 10
  %xor483.5 = xor i32 %add480.5, %and482.pre-phi
  %mul484.5 = shl nuw nsw i32 %xor483.5, 3
  %add485.5 = add nuw nsw i32 %mul484.5, %mul476
  %add490.5 = or disjoint i32 %add485.5, %mul489
  %add.ptr492.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.5
  store i64 %O_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr492.5, align 8
  %add480.6 = add nuw nsw i32 %shr479, 12
  %xor483.6 = xor i32 %add480.6, %and482.pre-phi
  %mul484.6 = shl nuw nsw i32 %xor483.6, 3
  %add485.6 = add nuw nsw i32 %mul484.6, %mul476
  %add490.6 = or disjoint i32 %add485.6, %mul489
  %add.ptr492.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.6
  store i64 %O_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr492.6, align 8
  %add480.7 = add nuw nsw i32 %shr479, 14
  %xor483.7 = xor i32 %add480.7, %and482.pre-phi
  %mul484.7 = shl nuw nsw i32 %xor483.7, 3
  %add485.7 = add nuw nsw i32 %mul484.7, %mul476
  %add490.7 = or disjoint i32 %add485.7, %mul489
  %add.ptr492.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.7
  store i64 %O_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr492.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul503 = and i32 %mul14, 8064
  %shr509 = lshr i32 %3, 4
  %invariant.gep674 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul503
  %xor511 = xor i32 %shr509, %and482.pre-phi
  %add.ptr515.idx = shl nuw nsw i32 %xor511, 4
  %add.ptr515 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 %add.ptr515.idx
  %add.ptr532 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515, i64 16, i1 false), !tbaa.struct !172, !call_argsrelate !173
  %158 = add nuw nsw i32 %shr509, 4
  %xor511.1 = xor i32 %158, %and482.pre-phi
  %gep675.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 1024
  %add.ptr515.idx.1 = shl nuw nsw i32 %xor511.1, 4
  %add.ptr515.1 = getelementptr inbounds i8, ptr addrspace(3) %gep675.1, i32 %add.ptr515.idx.1
  %add.ptr532.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515.1, i64 16, i1 false), !tbaa.struct !172, !call_argsrelate !173
  %159 = add nuw nsw i32 %shr509, 8
  %xor511.2 = xor i32 %159, %and482.pre-phi
  %gep675.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 2048
  %add.ptr515.idx.2 = shl nuw nsw i32 %xor511.2, 4
  %add.ptr515.2 = getelementptr inbounds i8, ptr addrspace(3) %gep675.2, i32 %add.ptr515.idx.2
  %add.ptr532.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %6
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515.2, i64 16, i1 false), !tbaa.struct !172, !call_argsrelate !173
  %narrow = add nuw nsw i32 %shr509, 12
  %xor511.3 = xor i32 %narrow, %and482.pre-phi
  %gep675.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 3072
  %add.ptr515.idx.3 = shl nuw nsw i32 %xor511.3, 4
  %add.ptr515.3 = getelementptr inbounds i8, ptr addrspace(3) %gep675.3, i32 %add.ptr515.idx.3
  %add.ptr532.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %7
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515.3, i64 16, i1 false), !tbaa.struct !172, !call_argsrelate !173
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


