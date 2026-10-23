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
  %mul = shl nsw i32 %0, 15
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %4 = add nuw nsw i64 %3, 512
  %5 = add nuw nsw i64 %3, 1024
  %6 = add nuw nsw i64 %3, 1536
  %mul17 = shl nsw i32 %0, 4
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx20 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %7 = load i32, ptr addrspace(1) %arrayidx20, align 4, !tbaa !30
  %cmp35 = icmp eq i32 %7, 0
  br i1 %cmp35, label %for.cond40.preheader, label %if.end335

for.cond40.preheader:                             ; preds = %entry
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul50 = shl nsw i32 %0, 11
  %add54 = add nuw nsw i32 %mul11, %mul50
  %8 = zext nneg i32 %add54 to i64
  %add.ptr61 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = load i32, ptr addrspace(4) %add.ptr61, align 4, !tbaa !30
  %10 = or disjoint i64 %8, 2
  %add.ptr61.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr61.1, align 4, !tbaa !30
  %12 = or disjoint i64 %8, 4
  %add.ptr61.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr61.2, align 4, !tbaa !30
  %14 = or disjoint i64 %8, 6
  %add.ptr61.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr61.3, align 4, !tbaa !30
  %16 = add nuw nsw i64 %8, 512
  %add.ptr61.1647 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr61.1647, align 4, !tbaa !30
  %18 = add nuw nsw i64 %8, 514
  %add.ptr61.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr61.1.1, align 4, !tbaa !30
  %20 = add nuw nsw i64 %8, 516
  %add.ptr61.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr61.2.1, align 4, !tbaa !30
  %22 = add nuw nsw i64 %8, 518
  %add.ptr61.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr61.3.1, align 4, !tbaa !30
  %24 = add nuw nsw i64 %8, 1024
  %add.ptr61.2649 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr61.2649, align 4, !tbaa !30
  %26 = add nuw nsw i64 %8, 1026
  %add.ptr61.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26
  %27 = load i32, ptr addrspace(4) %add.ptr61.1.2, align 4, !tbaa !30
  %28 = add nuw nsw i64 %8, 1028
  %add.ptr61.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28
  %29 = load i32, ptr addrspace(4) %add.ptr61.2.2, align 4, !tbaa !30
  %30 = add nuw nsw i64 %8, 1030
  %add.ptr61.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %30
  %31 = load i32, ptr addrspace(4) %add.ptr61.3.2, align 4, !tbaa !30
  %32 = add nuw nsw i64 %8, 1536
  %add.ptr61.3651 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %32
  %33 = load i32, ptr addrspace(4) %add.ptr61.3651, align 4, !tbaa !30
  %34 = add nuw nsw i64 %8, 1538
  %add.ptr61.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %34
  %35 = load i32, ptr addrspace(4) %add.ptr61.1.3, align 4, !tbaa !30
  %36 = add nuw nsw i64 %8, 1540
  %add.ptr61.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %36
  %37 = load i32, ptr addrspace(4) %add.ptr61.2.3, align 4, !tbaa !30
  %38 = add nuw nsw i64 %8, 1542
  %add.ptr61.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %38
  %39 = load i32, ptr addrspace(4) %add.ptr61.3.3, align 4, !tbaa !30
  %add.ptr94 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %40 = load i32, ptr addrspace(4) %add.ptr94, align 4, !tbaa !30
  %add.ptr94.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %41 = load i32, ptr addrspace(4) %add.ptr94.1, align 4, !tbaa !30
  %add.ptr94.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %42 = load i32, ptr addrspace(4) %add.ptr94.2, align 4, !tbaa !30
  %add.ptr94.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %43 = load i32, ptr addrspace(4) %add.ptr94.3, align 4, !tbaa !30
  %add.ptr94.1663 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %44 = load i32, ptr addrspace(4) %add.ptr94.1663, align 4, !tbaa !30
  %add.ptr94.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %45 = load i32, ptr addrspace(4) %add.ptr94.1.1, align 4, !tbaa !30
  %add.ptr94.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %46 = load i32, ptr addrspace(4) %add.ptr94.2.1, align 4, !tbaa !30
  %add.ptr94.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %47 = load i32, ptr addrspace(4) %add.ptr94.3.1, align 4, !tbaa !30
  %add.ptr94.2665 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %48 = load i32, ptr addrspace(4) %add.ptr94.2665, align 4, !tbaa !30
  %add.ptr94.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26
  %49 = load i32, ptr addrspace(4) %add.ptr94.1.2, align 4, !tbaa !30
  %add.ptr94.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28
  %50 = load i32, ptr addrspace(4) %add.ptr94.2.2, align 4, !tbaa !30
  %add.ptr94.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %30
  %51 = load i32, ptr addrspace(4) %add.ptr94.3.2, align 4, !tbaa !30
  %add.ptr94.3667 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %32
  %52 = load i32, ptr addrspace(4) %add.ptr94.3667, align 4, !tbaa !30
  %add.ptr94.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %34
  %53 = load i32, ptr addrspace(4) %add.ptr94.1.3, align 4, !tbaa !30
  %add.ptr94.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %36
  %54 = load i32, ptr addrspace(4) %add.ptr94.2.3, align 4, !tbaa !30
  %add.ptr94.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %38
  %55 = load i32, ptr addrspace(4) %add.ptr94.3.3, align 4, !tbaa !30
  %mul117 = and i32 %mul11, 8064
  %and = and i32 %2, 15
  %shr122 = lshr i32 %2, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul117
  %xor = xor i32 %shr122, %and
  %add.ptr127.idx = shl nuw nsw i32 %xor, 4
  %add.ptr127 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr127.idx
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !60
  %add123.1 = add nuw nsw i32 %shr122, 4
  %xor.1 = xor i32 %add123.1, %and
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr127.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr127.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr127.idx.1
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !60
  %add123.2 = add nuw nsw i32 %shr122, 8
  %xor.2 = xor i32 %add123.2, %and
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr127.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr127.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr127.idx.2
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !call_argsrelate !60
  %add123.3 = add nuw nsw i32 %shr122, 12
  %xor.3 = xor i32 %add123.3, %and
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr127.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr127.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr127.idx.3
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !call_argsrelate !60
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and136 = shl nuw nsw i32 %2, 7
  %mul137 = and i32 %and136, 1920
  %56 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul137
  %add.ptr148 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16
  %Q_reg.sroa.4.0.add.ptr148.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8
  %add.ptr148.1 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16
  %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8
  %add.ptr148.2 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx.2
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.2, align 16
  %Q_reg.sroa.10.32.add.ptr148.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.2, i32 8
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr148.2.sroa_idx, align 8
  %add.ptr148.3 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx.3
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.3, align 16
  %Q_reg.sroa.13.48.add.ptr148.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.3, i32 8
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr148.3.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %9, ptr addrspace(3) %add.ptr127, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr179.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127, i32 4
  store i32 %11, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr179.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr179.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127, i32 8
  store i32 %13, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr179.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr179.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127, i32 12
  store i32 %15, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr179.sroa_idx, align 4, !tbaa !30
  store i32 %17, ptr addrspace(3) %add.ptr127.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr179.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.1, i32 4
  store i32 %19, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr179.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr179.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.1, i32 8
  store i32 %21, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr179.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr179.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.1, i32 12
  store i32 %23, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr179.1.sroa_idx, align 4, !tbaa !30
  store i32 %25, ptr addrspace(3) %add.ptr127.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr179.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.2, i32 4
  store i32 %27, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr179.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr179.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.2, i32 8
  store i32 %29, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr179.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr179.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.2, i32 12
  store i32 %31, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr179.2.sroa_idx, align 4, !tbaa !30
  store i32 %33, ptr addrspace(3) %add.ptr127.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr179.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.3, i32 4
  store i32 %35, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr179.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr179.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.3, i32 8
  store i32 %37, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr179.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr179.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.3, i32 12
  store i32 %39, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr179.3.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %57)
  %kb.sroa.0.0.copyload705 = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16
  %kb.sroa.10.0.copyload708 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload705, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %58)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload708, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %59)
  %kb.sroa.0.0.copyload706 = load <4 x half>, ptr addrspace(3) %add.ptr148.2, align 16
  %kb.sroa.10.0.copyload709 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr148.2.sroa_idx, align 8
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload706, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %60)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload709, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %61)
  %kb.sroa.0.0.copyload707 = load <4 x half>, ptr addrspace(3) %add.ptr148.3, align 16
  %kb.sroa.10.0.copyload710 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr148.3.sroa_idx, align 8
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload707, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %62)
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload710, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %63)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr242.idx = shl nuw nsw i32 %2, 4
  %invariant.gep613 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr242.idx
  store i32 %40, ptr addrspace(3) %invariant.gep613, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 4
  store i32 %41, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep613.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 8
  store i32 %42, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep613.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 12
  store i32 %43, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep613.sroa_idx, align 4, !tbaa !30
  %gep614.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1024
  store i32 %44, ptr addrspace(3) %gep614.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep614.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1028
  store i32 %45, ptr addrspace(3) %V_reg.sroa.9.16.gep614.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep614.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1032
  store i32 %46, ptr addrspace(3) %V_reg.sroa.10.16.gep614.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep614.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1036
  store i32 %47, ptr addrspace(3) %V_reg.sroa.11.16.gep614.1.sroa_idx, align 4, !tbaa !30
  %gep614.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2048
  store i32 %48, ptr addrspace(3) %gep614.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep614.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2052
  store i32 %49, ptr addrspace(3) %V_reg.sroa.14.32.gep614.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep614.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2056
  store i32 %50, ptr addrspace(3) %V_reg.sroa.15.32.gep614.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep614.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2060
  store i32 %51, ptr addrspace(3) %V_reg.sroa.16.32.gep614.2.sroa_idx, align 4, !tbaa !30
  %gep614.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3072
  store i32 %52, ptr addrspace(3) %gep614.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep614.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3076
  store i32 %53, ptr addrspace(3) %V_reg.sroa.19.48.gep614.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep614.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3080
  store i32 %54, ptr addrspace(3) %V_reg.sroa.20.48.gep614.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep614.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3084
  store i32 %55, ptr addrspace(3) %V_reg.sroa.21.48.gep614.3.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %64, i64 1
  %mul252.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %65 = tail call contract noundef float @llvm.minnum.f32(float %mul252.1, float 0x4024CB5EC0000000)
  %66 = tail call contract noundef float @llvm.exp.f32(float %65)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %64, i64 2
  %mul252.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul252.2, float 0x4024CB5EC0000000)
  %68 = tail call contract noundef float @llvm.exp.f32(float %67)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %64, i64 3
  %mul252.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul252.3, float 0x4024CB5EC0000000)
  %70 = tail call contract noundef float @llvm.exp.f32(float %69)
  %71 = lshr i32 %2, 2
  %mul266 = and i32 %71, 252
  %cmp269.not = icmp ugt i32 %mul266, %1
  br i1 %cmp269.not, label %if.end, label %if.then270

if.then270:                                       ; preds = %for.cond40.preheader
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %64, i64 0
  %mul252 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul252, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  br label %if.end

if.end:                                           ; preds = %for.cond40.preheader, %if.then270
  %condval.0 = phi float [ %73, %if.then270 ], [ 0.000000e+00, %for.cond40.preheader ]
  %cmp269.not.1.not = icmp ult i32 %mul266, %1
  %spec.select = select i1 %cmp269.not.1.not, float %66, float 0.000000e+00
  %add267.2 = or disjoint i32 %mul266, 2
  %cmp269.not.2 = icmp ugt i32 %add267.2, %1
  %condval.0.2 = select i1 %cmp269.not.2, float 0.000000e+00, float %68
  %add267.3 = or i32 %71, 3
  %cmp269.not.3 = icmp ugt i32 %add267.3, %1
  %condval.0.3 = select i1 %cmp269.not.3, float 0.000000e+00, float %70
  %add286.1 = fadd contract float %condval.0, %spec.select
  %add286.2 = fadd contract float %add286.1, %condval.0.2
  %add286.3 = fadd contract float %add286.2, %condval.0.3
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add286.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %74, i64 0
  %cmp304 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp304, float %div, float 0.000000e+00
  %mul317 = fmul contract float %condval_1.0, %condval.0
  %mul317.1 = fmul contract float %condval_1.0, %spec.select
  %mul317.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul317.3 = fmul contract float %condval_1.0, %condval.0.3
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317)
  %76 = insertelement <4 x i16> poison, i16 %75, i64 0
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317.1)
  %78 = insertelement <4 x i16> %76, i16 %77, i64 1
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317.2)
  %80 = insertelement <4 x i16> %78, i16 %79, i64 2
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317.3)
  %82 = insertelement <4 x i16> %80, i16 %81, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %82 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end335

if.end335:                                        ; preds = %if.end, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end ], [ undef, %entry ]
  br i1 %cmp35, label %for.cond355.preheader, label %if.end335.if.end403_crit_edge

if.end335.if.end403_crit_edge:                    ; preds = %if.end335
  %.pre = and i32 %2, 15
  br label %if.end403

for.cond355.preheader:                            ; preds = %if.end335
  %83 = shl nuw nsw i32 %2, 5
  %mul365 = and i32 %83, 32256
  %and371 = and i32 %2, 15
  %add372 = or disjoint i32 %mul365, %and371
  %arrayidx374 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372
  %84 = load half, ptr addrspace(3) %arrayidx374, align 2, !tbaa !133
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %84, i64 0
  %add367.1 = or disjoint i32 %mul365, %and371
  %add372.1 = or disjoint i32 %add367.1, 128
  %arrayidx374.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1
  %85 = load half, ptr addrspace(3) %arrayidx374.1, align 2, !tbaa !133
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %85, i64 1
  %add367.2 = or disjoint i32 %mul365, %and371
  %add372.2 = or disjoint i32 %add367.2, 256
  %arrayidx374.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2
  %86 = load half, ptr addrspace(3) %arrayidx374.2, align 2, !tbaa !133
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %86, i64 2
  %add367.3 = or disjoint i32 %mul365, %and371
  %add372.3 = or disjoint i32 %add367.3, 384
  %arrayidx374.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3
  %87 = load half, ptr addrspace(3) %arrayidx374.3, align 2, !tbaa !133
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %87, i64 3
  %add369.1671 = or disjoint i32 %mul365, %and371
  %add372.1672 = or disjoint i32 %add369.1671, 16
  %arrayidx374.1673 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1672
  %88 = load half, ptr addrspace(3) %arrayidx374.1673, align 2, !tbaa !133
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %88, i64 0
  %add369.1.1 = or disjoint i32 %mul365, %and371
  %add372.1.1 = or disjoint i32 %add369.1.1, 144
  %arrayidx374.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.1
  %89 = load half, ptr addrspace(3) %arrayidx374.1.1, align 2, !tbaa !133
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %89, i64 1
  %add369.2.1 = or disjoint i32 %mul365, %and371
  %add372.2.1 = or disjoint i32 %add369.2.1, 272
  %arrayidx374.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.1
  %90 = load half, ptr addrspace(3) %arrayidx374.2.1, align 2, !tbaa !133
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %90, i64 2
  %add369.3.1 = or disjoint i32 %mul365, %and371
  %add372.3.1 = or disjoint i32 %add369.3.1, 400
  %arrayidx374.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.1
  %91 = load half, ptr addrspace(3) %arrayidx374.3.1, align 2, !tbaa !133
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %91, i64 3
  %add369.2675 = or disjoint i32 %mul365, %and371
  %add372.2676 = or disjoint i32 %add369.2675, 32
  %arrayidx374.2677 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2676
  %92 = load half, ptr addrspace(3) %arrayidx374.2677, align 2, !tbaa !133
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %92, i64 0
  %add369.1.2 = or disjoint i32 %mul365, %and371
  %add372.1.2 = or disjoint i32 %add369.1.2, 160
  %arrayidx374.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.2
  %93 = load half, ptr addrspace(3) %arrayidx374.1.2, align 2, !tbaa !133
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %93, i64 1
  %add369.2.2 = or disjoint i32 %mul365, %and371
  %add372.2.2 = or disjoint i32 %add369.2.2, 288
  %arrayidx374.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.2
  %94 = load half, ptr addrspace(3) %arrayidx374.2.2, align 2, !tbaa !133
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %94, i64 2
  %add369.3.2 = or disjoint i32 %mul365, %and371
  %add372.3.2 = or disjoint i32 %add369.3.2, 416
  %arrayidx374.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.2
  %95 = load half, ptr addrspace(3) %arrayidx374.3.2, align 2, !tbaa !133
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %95, i64 3
  %add369.3679 = or disjoint i32 %mul365, %and371
  %add372.3680 = or disjoint i32 %add369.3679, 48
  %arrayidx374.3681 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3680
  %96 = load half, ptr addrspace(3) %arrayidx374.3681, align 2, !tbaa !133
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %96, i64 0
  %add369.1.3 = or disjoint i32 %mul365, %and371
  %add372.1.3 = or disjoint i32 %add369.1.3, 176
  %arrayidx374.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.3
  %97 = load half, ptr addrspace(3) %arrayidx374.1.3, align 2, !tbaa !133
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %97, i64 1
  %add369.2.3 = or disjoint i32 %mul365, %and371
  %add372.2.3 = or disjoint i32 %add369.2.3, 304
  %arrayidx374.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.3
  %98 = load half, ptr addrspace(3) %arrayidx374.2.3, align 2, !tbaa !133
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %98, i64 2
  %add369.3.3 = or disjoint i32 %mul365, %and371
  %add372.3.3 = or disjoint i32 %add369.3.3, 432
  %arrayidx374.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.3
  %99 = load half, ptr addrspace(3) %arrayidx374.3.3, align 2, !tbaa !133
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %99, i64 3
  %add369.4 = or disjoint i32 %mul365, %and371
  %add372.4 = or disjoint i32 %add369.4, 64
  %arrayidx374.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.4
  %100 = load half, ptr addrspace(3) %arrayidx374.4, align 2, !tbaa !133
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %100, i64 0
  %add369.1.4 = or disjoint i32 %mul365, %and371
  %add372.1.4 = or disjoint i32 %add369.1.4, 192
  %arrayidx374.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.4
  %101 = load half, ptr addrspace(3) %arrayidx374.1.4, align 2, !tbaa !133
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %101, i64 1
  %add369.2.4 = or disjoint i32 %mul365, %and371
  %add372.2.4 = or disjoint i32 %add369.2.4, 320
  %arrayidx374.2.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.4
  %102 = load half, ptr addrspace(3) %arrayidx374.2.4, align 2, !tbaa !133
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %102, i64 2
  %add369.3.4 = or disjoint i32 %mul365, %and371
  %add372.3.4 = or disjoint i32 %add369.3.4, 448
  %arrayidx374.3.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.4
  %103 = load half, ptr addrspace(3) %arrayidx374.3.4, align 2, !tbaa !133
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %103, i64 3
  %add369.5 = or disjoint i32 %mul365, %and371
  %add372.5 = or disjoint i32 %add369.5, 80
  %arrayidx374.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.5
  %104 = load half, ptr addrspace(3) %arrayidx374.5, align 2, !tbaa !133
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %104, i64 0
  %add369.1.5 = or disjoint i32 %mul365, %and371
  %add372.1.5 = or disjoint i32 %add369.1.5, 208
  %arrayidx374.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.5
  %105 = load half, ptr addrspace(3) %arrayidx374.1.5, align 2, !tbaa !133
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %105, i64 1
  %add369.2.5 = or disjoint i32 %mul365, %and371
  %add372.2.5 = or disjoint i32 %add369.2.5, 336
  %arrayidx374.2.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.5
  %106 = load half, ptr addrspace(3) %arrayidx374.2.5, align 2, !tbaa !133
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %106, i64 2
  %add369.3.5 = or disjoint i32 %mul365, %and371
  %add372.3.5 = or disjoint i32 %add369.3.5, 464
  %arrayidx374.3.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.5
  %107 = load half, ptr addrspace(3) %arrayidx374.3.5, align 2, !tbaa !133
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %107, i64 3
  %add369.6 = or disjoint i32 %mul365, %and371
  %add372.6 = or disjoint i32 %add369.6, 96
  %arrayidx374.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.6
  %108 = load half, ptr addrspace(3) %arrayidx374.6, align 2, !tbaa !133
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %108, i64 0
  %add369.1.6 = or disjoint i32 %mul365, %and371
  %add372.1.6 = or disjoint i32 %add369.1.6, 224
  %arrayidx374.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.6
  %109 = load half, ptr addrspace(3) %arrayidx374.1.6, align 2, !tbaa !133
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %109, i64 1
  %add369.2.6 = or disjoint i32 %mul365, %and371
  %add372.2.6 = or disjoint i32 %add369.2.6, 352
  %arrayidx374.2.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.6
  %110 = load half, ptr addrspace(3) %arrayidx374.2.6, align 2, !tbaa !133
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %110, i64 2
  %add369.3.6 = or disjoint i32 %83, %and371
  %add372.3.6 = or i32 %add369.3.6, 480
  %arrayidx374.3.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.6
  %111 = load half, ptr addrspace(3) %arrayidx374.3.6, align 2, !tbaa !133
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %111, i64 3
  %add369.7 = or disjoint i32 %mul365, %and371
  %add372.7 = or disjoint i32 %add369.7, 112
  %arrayidx374.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.7
  %112 = load half, ptr addrspace(3) %arrayidx374.7, align 2, !tbaa !133
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %112, i64 0
  %add369.1.7 = or disjoint i32 %mul365, %and371
  %add372.1.7 = or disjoint i32 %add369.1.7, 240
  %arrayidx374.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.7
  %113 = load half, ptr addrspace(3) %arrayidx374.1.7, align 2, !tbaa !133
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %113, i64 1
  %add369.2.7 = or disjoint i32 %mul365, %and371
  %add372.2.7 = or disjoint i32 %add369.2.7, 368
  %arrayidx374.2.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.7
  %114 = load half, ptr addrspace(3) %arrayidx374.2.7, align 2, !tbaa !133
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %114, i64 2
  %add369.3.7 = or disjoint i32 %83, %and371
  %add372.3.7 = or i32 %add369.3.7, 496
  %arrayidx374.3.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.7
  %115 = load half, ptr addrspace(3) %arrayidx374.3.7, align 2, !tbaa !133
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %115, i64 3
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end403

if.end403:                                        ; preds = %if.end335.if.end403_crit_edge, %for.cond355.preheader
  %and443.pre-phi = phi i32 [ %.pre, %if.end335.if.end403_crit_edge ], [ %and371, %for.cond355.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %116, %for.cond355.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %117, %for.cond355.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %118, %for.cond355.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %119, %for.cond355.preheader ]
  %acc_o.sroa.58.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %120, %for.cond355.preheader ]
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %121, %for.cond355.preheader ]
  %acc_o.sroa.86.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %122, %for.cond355.preheader ]
  %acc_o.sroa.100.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %123, %for.cond355.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %124 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %125 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %126 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %127 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %128 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %129 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %130 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %131 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %132 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %133 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %134 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %135 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %136 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %137 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %138 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %139 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %acc_o.sroa.58.64.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 0
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.64.vec.extract)
  %O_reg.sroa.22.32.insert.ext = zext i16 %140 to i64
  %acc_o.sroa.58.68.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 1
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.68.vec.extract)
  %O_reg.sroa.22.34.insert.ext = zext i16 %141 to i64
  %O_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.34.insert.ext, 16
  %O_reg.sroa.22.34.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.shift, %O_reg.sroa.22.32.insert.ext
  %acc_o.sroa.58.72.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 2
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.72.vec.extract)
  %O_reg.sroa.22.36.insert.ext = zext i16 %142 to i64
  %O_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.36.insert.ext, 32
  %O_reg.sroa.22.36.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.insert, %O_reg.sroa.22.36.insert.shift
  %acc_o.sroa.58.76.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 3
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.76.vec.extract)
  %O_reg.sroa.22.38.insert.ext = zext i16 %143 to i64
  %O_reg.sroa.22.38.insert.shift = shl nuw i64 %O_reg.sroa.22.38.insert.ext, 48
  %O_reg.sroa.22.38.insert.insert = or disjoint i64 %O_reg.sroa.22.36.insert.insert, %O_reg.sroa.22.38.insert.shift
  %acc_o.sroa.72.80.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.80.vec.extract)
  %O_reg.sroa.27.40.insert.ext = zext i16 %144 to i64
  %acc_o.sroa.72.84.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.84.vec.extract)
  %O_reg.sroa.27.42.insert.ext = zext i16 %145 to i64
  %O_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.42.insert.ext, 16
  %O_reg.sroa.27.42.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.shift, %O_reg.sroa.27.40.insert.ext
  %acc_o.sroa.72.88.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.88.vec.extract)
  %O_reg.sroa.27.44.insert.ext = zext i16 %146 to i64
  %O_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.44.insert.ext, 32
  %O_reg.sroa.27.44.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.insert, %O_reg.sroa.27.44.insert.shift
  %acc_o.sroa.72.92.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.92.vec.extract)
  %O_reg.sroa.27.46.insert.ext = zext i16 %147 to i64
  %O_reg.sroa.27.46.insert.shift = shl nuw i64 %O_reg.sroa.27.46.insert.ext, 48
  %O_reg.sroa.27.46.insert.insert = or disjoint i64 %O_reg.sroa.27.44.insert.insert, %O_reg.sroa.27.46.insert.shift
  %acc_o.sroa.86.96.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.96.vec.extract)
  %O_reg.sroa.32.48.insert.ext = zext i16 %148 to i64
  %acc_o.sroa.86.100.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 1
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.100.vec.extract)
  %O_reg.sroa.32.50.insert.ext = zext i16 %149 to i64
  %O_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.50.insert.ext, 16
  %O_reg.sroa.32.50.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.shift, %O_reg.sroa.32.48.insert.ext
  %acc_o.sroa.86.104.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 2
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.104.vec.extract)
  %O_reg.sroa.32.52.insert.ext = zext i16 %150 to i64
  %O_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.52.insert.ext, 32
  %O_reg.sroa.32.52.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.insert, %O_reg.sroa.32.52.insert.shift
  %acc_o.sroa.86.108.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 3
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.108.vec.extract)
  %O_reg.sroa.32.54.insert.ext = zext i16 %151 to i64
  %O_reg.sroa.32.54.insert.shift = shl nuw i64 %O_reg.sroa.32.54.insert.ext, 48
  %O_reg.sroa.32.54.insert.insert = or disjoint i64 %O_reg.sroa.32.52.insert.insert, %O_reg.sroa.32.54.insert.shift
  %acc_o.sroa.100.112.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 0
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.112.vec.extract)
  %O_reg.sroa.37.56.insert.ext = zext i16 %152 to i64
  %acc_o.sroa.100.116.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 1
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.116.vec.extract)
  %O_reg.sroa.37.58.insert.ext = zext i16 %153 to i64
  %O_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.58.insert.ext, 16
  %O_reg.sroa.37.58.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.shift, %O_reg.sroa.37.56.insert.ext
  %acc_o.sroa.100.120.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 2
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.120.vec.extract)
  %O_reg.sroa.37.60.insert.ext = zext i16 %154 to i64
  %O_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.60.insert.ext, 32
  %O_reg.sroa.37.60.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.insert, %O_reg.sroa.37.60.insert.shift
  %acc_o.sroa.100.124.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 3
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.124.vec.extract)
  %O_reg.sroa.37.62.insert.ext = zext i16 %155 to i64
  %O_reg.sroa.37.62.insert.shift = shl nuw i64 %O_reg.sroa.37.62.insert.ext, 48
  %O_reg.sroa.37.62.insert.insert = or disjoint i64 %O_reg.sroa.37.60.insert.insert, %O_reg.sroa.37.62.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and436 = shl nuw nsw i32 %2, 7
  %mul437 = and i32 %and436, 1920
  %shr440 = lshr i32 %2, 5
  %156 = lshr i32 %2, 2
  %mul450 = and i32 %156, 4
  %xor444 = xor i32 %shr440, %and443.pre-phi
  %mul445 = shl nuw nsw i32 %xor444, 3
  %add446 = add nuw nsw i32 %mul445, %mul437
  %add451 = or disjoint i32 %add446, %mul450
  %add.ptr453 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr453, align 8
  %add441.1 = add nuw nsw i32 %shr440, 2
  %xor444.1 = xor i32 %add441.1, %and443.pre-phi
  %mul445.1 = shl nuw nsw i32 %xor444.1, 3
  %add446.1 = add nuw nsw i32 %mul445.1, %mul437
  %add451.1 = or disjoint i32 %add446.1, %mul450
  %add.ptr453.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr453.1, align 8
  %add441.2 = add nuw nsw i32 %shr440, 4
  %xor444.2 = xor i32 %add441.2, %and443.pre-phi
  %mul445.2 = shl nuw nsw i32 %xor444.2, 3
  %add446.2 = add nuw nsw i32 %mul445.2, %mul437
  %add451.2 = or disjoint i32 %add446.2, %mul450
  %add.ptr453.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr453.2, align 8
  %add441.3 = add nuw nsw i32 %shr440, 6
  %xor444.3 = xor i32 %add441.3, %and443.pre-phi
  %mul445.3 = shl nuw nsw i32 %xor444.3, 3
  %add446.3 = add nuw nsw i32 %mul445.3, %mul437
  %add451.3 = or disjoint i32 %add446.3, %mul450
  %add.ptr453.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr453.3, align 8
  %add441.4 = add nuw nsw i32 %shr440, 8
  %xor444.4 = xor i32 %add441.4, %and443.pre-phi
  %mul445.4 = shl nuw nsw i32 %xor444.4, 3
  %add446.4 = add nuw nsw i32 %mul445.4, %mul437
  %add451.4 = or disjoint i32 %add446.4, %mul450
  %add.ptr453.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.4
  store i64 %O_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr453.4, align 8
  %add441.5 = add nuw nsw i32 %shr440, 10
  %xor444.5 = xor i32 %add441.5, %and443.pre-phi
  %mul445.5 = shl nuw nsw i32 %xor444.5, 3
  %add446.5 = add nuw nsw i32 %mul445.5, %mul437
  %add451.5 = or disjoint i32 %add446.5, %mul450
  %add.ptr453.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.5
  store i64 %O_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr453.5, align 8
  %add441.6 = add nuw nsw i32 %shr440, 12
  %xor444.6 = xor i32 %add441.6, %and443.pre-phi
  %mul445.6 = shl nuw nsw i32 %xor444.6, 3
  %add446.6 = add nuw nsw i32 %mul445.6, %mul437
  %add451.6 = or disjoint i32 %add446.6, %mul450
  %add.ptr453.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.6
  store i64 %O_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr453.6, align 8
  %add441.7 = add nuw nsw i32 %shr440, 14
  %xor444.7 = xor i32 %add441.7, %and443.pre-phi
  %mul445.7 = shl nuw nsw i32 %xor444.7, 3
  %add446.7 = add nuw nsw i32 %mul445.7, %mul437
  %add451.7 = or disjoint i32 %add446.7, %mul450
  %add.ptr453.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.7
  store i64 %O_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr453.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul464 = and i32 %mul11, 8064
  %shr470 = lshr i32 %2, 4
  %invariant.gep629 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul464
  %xor472 = xor i32 %shr470, %and443.pre-phi
  %add.ptr476.idx = shl nuw nsw i32 %xor472, 4
  %add.ptr476 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 %add.ptr476.idx
  %add.ptr488 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476, i64 16, i1 false), !tbaa.struct !164, !call_argsrelate !165
  %157 = add nuw nsw i32 %shr470, 4
  %xor472.1 = xor i32 %157, %and443.pre-phi
  %gep630.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 1024
  %add.ptr476.idx.1 = shl nuw nsw i32 %xor472.1, 4
  %add.ptr476.1 = getelementptr inbounds i8, ptr addrspace(3) %gep630.1, i32 %add.ptr476.idx.1
  %add.ptr488.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476.1, i64 16, i1 false), !tbaa.struct !164, !call_argsrelate !165
  %158 = add nuw nsw i32 %shr470, 8
  %xor472.2 = xor i32 %158, %and443.pre-phi
  %gep630.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 2048
  %add.ptr476.idx.2 = shl nuw nsw i32 %xor472.2, 4
  %add.ptr476.2 = getelementptr inbounds i8, ptr addrspace(3) %gep630.2, i32 %add.ptr476.idx.2
  %add.ptr488.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476.2, i64 16, i1 false), !tbaa.struct !164, !call_argsrelate !165
  %narrow = add nuw nsw i32 %shr470, 12
  %xor472.3 = xor i32 %narrow, %and443.pre-phi
  %gep630.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 3072
  %add.ptr476.idx.3 = shl nuw nsw i32 %xor472.3, 4
  %add.ptr476.3 = getelementptr inbounds i8, ptr addrspace(3) %gep630.3, i32 %add.ptr476.idx.3
  %add.ptr488.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %6
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476.3, i64 16, i1 false), !tbaa.struct !164, !call_argsrelate !165
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


