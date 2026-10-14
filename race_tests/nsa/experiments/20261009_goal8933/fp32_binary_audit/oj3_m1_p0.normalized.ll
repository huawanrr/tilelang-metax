target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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
  %and = shl nuw nsw i32 %1, 7
  %mul7 = and i32 %and, 1920
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 128
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 136
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 192
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 200
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx17 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %7 = load i32, ptr addrspace(1) %arrayidx17, align 4, !tbaa !30
  %cmp32 = icmp ugt i32 %7, 15
  %shr35 = lshr i32 %0, 4
  %cmp36.not = icmp ugt i32 %7, %shr35
  %or.cond495 = or i1 %cmp32, %cmp36.not
  br i1 %or.cond495, label %if.end334, label %if.then

if.then:                                          ; preds = %entry
  %mul48 = shl nuw nsw i32 %7, 11
  %mul52 = shl nuw nsw i32 %1, 3
  %add50 = add nuw nsw i32 %mul48, %mul52
  %8 = zext nneg i32 %add50 to i64
  %add.ptr57 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = load i32, ptr addrspace(4) %add.ptr57, align 4, !tbaa !30
  %10 = or disjoint i64 %8, 2
  %add.ptr57.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr57.1, align 4, !tbaa !30
  %12 = or disjoint i64 %8, 4
  %add.ptr57.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr57.2, align 4, !tbaa !30
  %14 = or disjoint i64 %8, 6
  %add.ptr57.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr57.3, align 4, !tbaa !30
  %16 = add nuw nsw i64 %8, 512
  %add.ptr57.1510 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr57.1510, align 4, !tbaa !30
  %18 = add nuw nsw i64 %8, 514
  %add.ptr57.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr57.1.1, align 4, !tbaa !30
  %20 = add nuw nsw i64 %8, 516
  %add.ptr57.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr57.2.1, align 4, !tbaa !30
  %22 = add nuw nsw i64 %8, 518
  %add.ptr57.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr57.3.1, align 4, !tbaa !30
  %24 = add nuw nsw i64 %8, 1024
  %add.ptr57.2512 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr57.2512, align 4, !tbaa !30
  %26 = add nuw nsw i64 %8, 1026
  %add.ptr57.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26
  %27 = load i32, ptr addrspace(4) %add.ptr57.1.2, align 4, !tbaa !30
  %28 = add nuw nsw i64 %8, 1028
  %add.ptr57.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28
  %29 = load i32, ptr addrspace(4) %add.ptr57.2.2, align 4, !tbaa !30
  %30 = add nuw nsw i64 %8, 1030
  %add.ptr57.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %30
  %31 = load i32, ptr addrspace(4) %add.ptr57.3.2, align 4, !tbaa !30
  %32 = add nuw nsw i64 %8, 1536
  %add.ptr57.3514 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %32
  %33 = load i32, ptr addrspace(4) %add.ptr57.3514, align 4, !tbaa !30
  %34 = add nuw nsw i64 %8, 1538
  %add.ptr57.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %34
  %35 = load i32, ptr addrspace(4) %add.ptr57.1.3, align 4, !tbaa !30
  %36 = add nuw nsw i64 %8, 1540
  %add.ptr57.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %36
  %37 = load i32, ptr addrspace(4) %add.ptr57.2.3, align 4, !tbaa !30
  %38 = add nuw nsw i64 %8, 1542
  %add.ptr57.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %38
  %39 = load i32, ptr addrspace(4) %add.ptr57.3.3, align 4, !tbaa !30
  %add.ptr87 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %40 = load i32, ptr addrspace(4) %add.ptr87, align 4, !tbaa !30
  %add.ptr87.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %41 = load i32, ptr addrspace(4) %add.ptr87.1, align 4, !tbaa !30
  %add.ptr87.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %42 = load i32, ptr addrspace(4) %add.ptr87.2, align 4, !tbaa !30
  %add.ptr87.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %43 = load i32, ptr addrspace(4) %add.ptr87.3, align 4, !tbaa !30
  %add.ptr87.1526 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %44 = load i32, ptr addrspace(4) %add.ptr87.1526, align 4, !tbaa !30
  %add.ptr87.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %45 = load i32, ptr addrspace(4) %add.ptr87.1.1, align 4, !tbaa !30
  %add.ptr87.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %46 = load i32, ptr addrspace(4) %add.ptr87.2.1, align 4, !tbaa !30
  %add.ptr87.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %47 = load i32, ptr addrspace(4) %add.ptr87.3.1, align 4, !tbaa !30
  %add.ptr87.2528 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %48 = load i32, ptr addrspace(4) %add.ptr87.2528, align 4, !tbaa !30
  %add.ptr87.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26
  %49 = load i32, ptr addrspace(4) %add.ptr87.1.2, align 4, !tbaa !30
  %add.ptr87.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28
  %50 = load i32, ptr addrspace(4) %add.ptr87.2.2, align 4, !tbaa !30
  %add.ptr87.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %30
  %51 = load i32, ptr addrspace(4) %add.ptr87.3.2, align 4, !tbaa !30
  %add.ptr87.3530 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %32
  %52 = load i32, ptr addrspace(4) %add.ptr87.3530, align 4, !tbaa !30
  %add.ptr87.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %34
  %53 = load i32, ptr addrspace(4) %add.ptr87.1.3, align 4, !tbaa !30
  %add.ptr87.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %36
  %54 = load i32, ptr addrspace(4) %add.ptr87.2.3, align 4, !tbaa !30
  %add.ptr87.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %38
  %55 = load i32, ptr addrspace(4) %add.ptr87.3.3, align 4, !tbaa !30
  %mul111 = and i32 %mul52, 8064
  %and114 = and i32 %1, 15
  %shr117 = lshr i32 %1, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul111
  %xor = xor i32 %shr117, %and114
  %add.ptr122.idx = shl nuw nsw i32 %xor, 4
  %add.ptr122 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr122.idx
  store i32 %9, ptr addrspace(3) %add.ptr122, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122, i32 4
  store i32 %11, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr122.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122, i32 8
  store i32 %13, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr122.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122, i32 12
  store i32 %15, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr122.sroa_idx, align 4, !tbaa !30
  %add118.1 = add nuw nsw i32 %shr117, 4
  %xor.1 = xor i32 %add118.1, %and114
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr122.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr122.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr122.idx.1
  store i32 %17, ptr addrspace(3) %add.ptr122.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr122.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.1, i32 4
  store i32 %19, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr122.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr122.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.1, i32 8
  store i32 %21, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr122.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr122.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.1, i32 12
  store i32 %23, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr122.1.sroa_idx, align 4, !tbaa !30
  %add118.2 = add nuw nsw i32 %shr117, 8
  %xor.2 = xor i32 %add118.2, %and114
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr122.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr122.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr122.idx.2
  store i32 %25, ptr addrspace(3) %add.ptr122.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr122.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.2, i32 4
  store i32 %27, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr122.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr122.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.2, i32 8
  store i32 %29, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr122.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr122.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.2, i32 12
  store i32 %31, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr122.2.sroa_idx, align 4, !tbaa !30
  %add118.3 = add nuw nsw i32 %shr117, 12
  %xor.3 = xor i32 %add118.3, %and114
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr122.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr122.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr122.idx.3
  store i32 %33, ptr addrspace(3) %add.ptr122.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr122.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.3, i32 4
  store i32 %35, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr122.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr122.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.3, i32 8
  store i32 %37, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr122.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr122.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.3, i32 12
  store i32 %39, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr122.3.sroa_idx, align 4, !tbaa !30
  %mul37 = shl nuw nsw i32 %7, 4
  %add128 = or disjoint i32 %mul37, 15
  %cmp129 = icmp ult i32 %0, %add128
  br i1 %cmp129, label %for.cond131.preheader, label %if.end155

for.cond131.preheader:                            ; preds = %if.then
  %56 = lshr i32 %1, 2
  %mul137 = and i32 %56, 252
  %add139 = add nuw nsw i32 %mul37, %mul137
  %cmp142.not = icmp ugt i32 %add139, %0
  %spec.select = select i1 %cmp142.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert579 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp142.not.1.not = icmp ult i32 %add139, %0
  %spec.select.1 = select i1 %cmp142.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert592 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert579, float %spec.select.1, i64 1
  %add140.2 = or disjoint i32 %add139, 2
  %cmp142.not.2 = icmp ugt i32 %add140.2, %0
  %spec.select.2 = select i1 %cmp142.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert605 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert592, float %spec.select.2, i64 2
  %add140.3 = or disjoint i32 %add139, 3
  %cmp142.not.3 = icmp ugt i32 %add140.3, %0
  %spec.select.3 = select i1 %cmp142.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert618 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert605, float %spec.select.3, i64 3
  br label %if.end155

if.end155:                                        ; preds = %if.then, %for.cond131.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert618, %for.cond131.preheader ], [ zeroinitializer, %if.then ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %57 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul7
  %add.ptr173 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173, align 16
  %kb.sroa.10.0.add.ptr173.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173, i32 8
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.sroa_idx, align 8
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !79
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %58), !call_argsrelate !79
  %add.ptr173.1 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx.1
  %kb.sroa.0.0.copyload567 = load <4 x half>, ptr addrspace(3) %add.ptr173.1, align 16
  %kb.sroa.10.0.add.ptr173.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.1, i32 8
  %kb.sroa.10.0.copyload570 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.1.sroa_idx, align 8
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload567, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %59), !call_argsrelate !79
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload570, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %60), !call_argsrelate !79
  %add.ptr173.2 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx.2
  %kb.sroa.0.0.copyload568 = load <4 x half>, ptr addrspace(3) %add.ptr173.2, align 16
  %kb.sroa.10.0.add.ptr173.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.2, i32 8
  %kb.sroa.10.0.copyload571 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.2.sroa_idx, align 8
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload568, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %61), !call_argsrelate !79
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload571, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %62), !call_argsrelate !79
  %add.ptr173.3 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx.3
  %kb.sroa.0.0.copyload569 = load <4 x half>, ptr addrspace(3) %add.ptr173.3, align 16
  %kb.sroa.10.0.add.ptr173.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.3, i32 8
  %kb.sroa.10.0.copyload572 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.3.sroa_idx, align 8
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload569, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %63), !call_argsrelate !79
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload572, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %64), !call_argsrelate !79
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr211.idx = shl nuw nsw i32 %1, 4
  %invariant.gep481 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr211.idx
  store i32 %40, ptr addrspace(3) %invariant.gep481, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep481.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 4
  store i32 %41, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep481.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep481.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 8
  store i32 %42, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep481.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep481.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 12
  store i32 %43, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep481.sroa_idx, align 4, !tbaa !30
  %gep482.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1024
  store i32 %44, ptr addrspace(3) %gep482.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep482.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1028
  store i32 %45, ptr addrspace(3) %V_reg.sroa.9.16.gep482.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep482.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1032
  store i32 %46, ptr addrspace(3) %V_reg.sroa.10.16.gep482.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep482.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1036
  store i32 %47, ptr addrspace(3) %V_reg.sroa.11.16.gep482.1.sroa_idx, align 4, !tbaa !30
  %gep482.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2048
  store i32 %48, ptr addrspace(3) %gep482.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep482.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2052
  store i32 %49, ptr addrspace(3) %V_reg.sroa.14.32.gep482.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep482.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2056
  store i32 %50, ptr addrspace(3) %V_reg.sroa.15.32.gep482.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep482.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2060
  store i32 %51, ptr addrspace(3) %V_reg.sroa.16.32.gep482.2.sroa_idx, align 4, !tbaa !30
  %gep482.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3072
  store i32 %52, ptr addrspace(3) %gep482.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep482.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3076
  store i32 %53, ptr addrspace(3) %V_reg.sroa.19.48.gep482.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep482.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3080
  store i32 %54, ptr addrspace(3) %V_reg.sroa.20.48.gep482.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep482.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3084
  store i32 %55, ptr addrspace(3) %V_reg.sroa.21.48.gep482.3.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %65, i64 0
  %mul221 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul221, float 0x4024CB5EC0000000)
  %67 = tail call contract noundef float @llvm.exp.f32(float %66)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %65, i64 1
  %mul221.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul221.1, float 0x4024CB5EC0000000)
  %69 = tail call contract noundef float @llvm.exp.f32(float %68)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %65, i64 2
  %mul221.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul221.2, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %65, i64 3
  %mul221.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul221.3, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %add237.1 = fadd contract float %67, %69
  %add237.2 = fadd contract float %add237.1, %71
  %add237.3 = fadd contract float %add237.2, %73
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add237.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %74, i64 0
  %cmp255 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp255, float %div, float 0.000000e+00
  %mul268 = fmul contract float %condval_1.0, %67
  %mul268.1 = fmul contract float %condval_1.0, %69
  %mul268.2 = fmul contract float %condval_1.0, %71
  %mul268.3 = fmul contract float %condval_1.0, %73
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268)
  %76 = insertelement <4 x i16> poison, i16 %75, i64 0
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268.1)
  %78 = insertelement <4 x i16> %76, i16 %77, i64 1
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268.2)
  %80 = insertelement <4 x i16> %78, i16 %79, i64 2
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268.3)
  %82 = insertelement <4 x i16> %80, i16 %81, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %82 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %83 = shl nuw nsw i32 %1, 5
  %mul296 = and i32 %83, 32256
  %add303 = or disjoint i32 %mul296, %and114
  %arrayidx305 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303
  %84 = load half, ptr addrspace(3) %arrayidx305, align 2, !tbaa !121
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %84, i64 0
  %add298.1 = or disjoint i32 %mul296, %and114
  %add303.1 = or disjoint i32 %add298.1, 128
  %arrayidx305.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1
  %85 = load half, ptr addrspace(3) %arrayidx305.1, align 2, !tbaa !121
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %85, i64 1
  %add298.2 = or disjoint i32 %mul296, %and114
  %add303.2 = or disjoint i32 %add298.2, 256
  %arrayidx305.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2
  %86 = load half, ptr addrspace(3) %arrayidx305.2, align 2, !tbaa !121
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %86, i64 2
  %add298.3 = or disjoint i32 %mul296, %and114
  %add303.3 = or disjoint i32 %add298.3, 384
  %arrayidx305.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3
  %87 = load half, ptr addrspace(3) %arrayidx305.3, align 2, !tbaa !121
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %87, i64 3
  %add300.1534 = or disjoint i32 %mul296, %and114
  %add303.1535 = or disjoint i32 %add300.1534, 16
  %arrayidx305.1536 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1535
  %88 = load half, ptr addrspace(3) %arrayidx305.1536, align 2, !tbaa !121
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %88, i64 0
  %add300.1.1 = or disjoint i32 %mul296, %and114
  %add303.1.1 = or disjoint i32 %add300.1.1, 144
  %arrayidx305.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.1
  %89 = load half, ptr addrspace(3) %arrayidx305.1.1, align 2, !tbaa !121
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %89, i64 1
  %add300.2.1 = or disjoint i32 %mul296, %and114
  %add303.2.1 = or disjoint i32 %add300.2.1, 272
  %arrayidx305.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.1
  %90 = load half, ptr addrspace(3) %arrayidx305.2.1, align 2, !tbaa !121
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %90, i64 2
  %add300.3.1 = or disjoint i32 %mul296, %and114
  %add303.3.1 = or disjoint i32 %add300.3.1, 400
  %arrayidx305.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.1
  %91 = load half, ptr addrspace(3) %arrayidx305.3.1, align 2, !tbaa !121
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %91, i64 3
  %add300.2538 = or disjoint i32 %mul296, %and114
  %add303.2539 = or disjoint i32 %add300.2538, 32
  %arrayidx305.2540 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2539
  %92 = load half, ptr addrspace(3) %arrayidx305.2540, align 2, !tbaa !121
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %92, i64 0
  %add300.1.2 = or disjoint i32 %mul296, %and114
  %add303.1.2 = or disjoint i32 %add300.1.2, 160
  %arrayidx305.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.2
  %93 = load half, ptr addrspace(3) %arrayidx305.1.2, align 2, !tbaa !121
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %93, i64 1
  %add300.2.2 = or disjoint i32 %mul296, %and114
  %add303.2.2 = or disjoint i32 %add300.2.2, 288
  %arrayidx305.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.2
  %94 = load half, ptr addrspace(3) %arrayidx305.2.2, align 2, !tbaa !121
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %94, i64 2
  %add300.3.2 = or disjoint i32 %mul296, %and114
  %add303.3.2 = or disjoint i32 %add300.3.2, 416
  %arrayidx305.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.2
  %95 = load half, ptr addrspace(3) %arrayidx305.3.2, align 2, !tbaa !121
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %95, i64 3
  %add300.3542 = or disjoint i32 %mul296, %and114
  %add303.3543 = or disjoint i32 %add300.3542, 48
  %arrayidx305.3544 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3543
  %96 = load half, ptr addrspace(3) %arrayidx305.3544, align 2, !tbaa !121
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %96, i64 0
  %add300.1.3 = or disjoint i32 %mul296, %and114
  %add303.1.3 = or disjoint i32 %add300.1.3, 176
  %arrayidx305.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.3
  %97 = load half, ptr addrspace(3) %arrayidx305.1.3, align 2, !tbaa !121
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %97, i64 1
  %add300.2.3 = or disjoint i32 %mul296, %and114
  %add303.2.3 = or disjoint i32 %add300.2.3, 304
  %arrayidx305.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.3
  %98 = load half, ptr addrspace(3) %arrayidx305.2.3, align 2, !tbaa !121
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %98, i64 2
  %add300.3.3 = or disjoint i32 %mul296, %and114
  %add303.3.3 = or disjoint i32 %add300.3.3, 432
  %arrayidx305.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.3
  %99 = load half, ptr addrspace(3) %arrayidx305.3.3, align 2, !tbaa !121
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %99, i64 3
  %add300.4 = or disjoint i32 %mul296, %and114
  %add303.4 = or disjoint i32 %add300.4, 64
  %arrayidx305.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.4
  %100 = load half, ptr addrspace(3) %arrayidx305.4, align 2, !tbaa !121
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %100, i64 0
  %add300.1.4 = or disjoint i32 %mul296, %and114
  %add303.1.4 = or disjoint i32 %add300.1.4, 192
  %arrayidx305.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.4
  %101 = load half, ptr addrspace(3) %arrayidx305.1.4, align 2, !tbaa !121
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %101, i64 1
  %add300.2.4 = or disjoint i32 %mul296, %and114
  %add303.2.4 = or disjoint i32 %add300.2.4, 320
  %arrayidx305.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.4
  %102 = load half, ptr addrspace(3) %arrayidx305.2.4, align 2, !tbaa !121
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %102, i64 2
  %add300.3.4 = or disjoint i32 %mul296, %and114
  %add303.3.4 = or disjoint i32 %add300.3.4, 448
  %arrayidx305.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.4
  %103 = load half, ptr addrspace(3) %arrayidx305.3.4, align 2, !tbaa !121
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %103, i64 3
  %add300.5 = or disjoint i32 %mul296, %and114
  %add303.5 = or disjoint i32 %add300.5, 80
  %arrayidx305.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.5
  %104 = load half, ptr addrspace(3) %arrayidx305.5, align 2, !tbaa !121
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %104, i64 0
  %add300.1.5 = or disjoint i32 %mul296, %and114
  %add303.1.5 = or disjoint i32 %add300.1.5, 208
  %arrayidx305.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.5
  %105 = load half, ptr addrspace(3) %arrayidx305.1.5, align 2, !tbaa !121
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %105, i64 1
  %add300.2.5 = or disjoint i32 %mul296, %and114
  %add303.2.5 = or disjoint i32 %add300.2.5, 336
  %arrayidx305.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.5
  %106 = load half, ptr addrspace(3) %arrayidx305.2.5, align 2, !tbaa !121
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %106, i64 2
  %add300.3.5 = or disjoint i32 %mul296, %and114
  %add303.3.5 = or disjoint i32 %add300.3.5, 464
  %arrayidx305.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.5
  %107 = load half, ptr addrspace(3) %arrayidx305.3.5, align 2, !tbaa !121
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %107, i64 3
  %add300.6 = or disjoint i32 %mul296, %and114
  %add303.6 = or disjoint i32 %add300.6, 96
  %arrayidx305.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.6
  %108 = load half, ptr addrspace(3) %arrayidx305.6, align 2, !tbaa !121
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %108, i64 0
  %add300.1.6 = or disjoint i32 %mul296, %and114
  %add303.1.6 = or disjoint i32 %add300.1.6, 224
  %arrayidx305.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.6
  %109 = load half, ptr addrspace(3) %arrayidx305.1.6, align 2, !tbaa !121
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %109, i64 1
  %add300.2.6 = or disjoint i32 %mul296, %and114
  %add303.2.6 = or disjoint i32 %add300.2.6, 352
  %arrayidx305.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.6
  %110 = load half, ptr addrspace(3) %arrayidx305.2.6, align 2, !tbaa !121
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %110, i64 2
  %add300.3.6 = or disjoint i32 %83, %and114
  %add303.3.6 = or i32 %add300.3.6, 480
  %arrayidx305.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.6
  %111 = load half, ptr addrspace(3) %arrayidx305.3.6, align 2, !tbaa !121
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %111, i64 3
  %add300.7 = or disjoint i32 %mul296, %and114
  %add303.7 = or disjoint i32 %add300.7, 112
  %arrayidx305.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.7
  %112 = load half, ptr addrspace(3) %arrayidx305.7, align 2, !tbaa !121
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %112, i64 0
  %add300.1.7 = or disjoint i32 %mul296, %and114
  %add303.1.7 = or disjoint i32 %add300.1.7, 240
  %arrayidx305.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.7
  %113 = load half, ptr addrspace(3) %arrayidx305.1.7, align 2, !tbaa !121
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %113, i64 1
  %add300.2.7 = or disjoint i32 %mul296, %and114
  %add303.2.7 = or disjoint i32 %add300.2.7, 368
  %arrayidx305.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.7
  %114 = load half, ptr addrspace(3) %arrayidx305.2.7, align 2, !tbaa !121
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %114, i64 2
  %add300.3.7 = or disjoint i32 %83, %and114
  %add303.3.7 = or i32 %add300.3.7, 496
  %arrayidx305.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.7
  %115 = load half, ptr addrspace(3) %arrayidx305.3.7, align 2, !tbaa !121
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %115, i64 3
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end334

if.end334:                                        ; preds = %if.end155, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %116, %if.end155 ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %117, %if.end155 ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %118, %if.end155 ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %119, %if.end155 ]
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %120, %if.end155 ]
  %acc_o.sroa.52.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %121, %if.end155 ]
  %acc_o.sroa.62.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %122, %if.end155 ]
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %123, %if.end155 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_cast.sroa.0.0.insert.ext = zext i16 %124 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_cast.sroa.0.2.insert.ext = zext i16 %125 to i64
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_cast.sroa.0.4.insert.ext = zext i16 %126 to i64
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_cast.sroa.0.6.insert.ext = zext i16 %127 to i64
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.16.vec.extract)
  %O_cast.sroa.7.8.insert.ext = zext i16 %128 to i64
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.20.vec.extract)
  %O_cast.sroa.7.10.insert.ext = zext i16 %129 to i64
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.24.vec.extract)
  %O_cast.sroa.7.12.insert.ext = zext i16 %130 to i64
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.28.vec.extract)
  %O_cast.sroa.7.14.insert.ext = zext i16 %131 to i64
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.32.vec.extract)
  %O_cast.sroa.12.16.insert.ext = zext i16 %132 to i64
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.36.vec.extract)
  %O_cast.sroa.12.18.insert.ext = zext i16 %133 to i64
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.40.vec.extract)
  %O_cast.sroa.12.20.insert.ext = zext i16 %134 to i64
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.44.vec.extract)
  %O_cast.sroa.12.22.insert.ext = zext i16 %135 to i64
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.48.vec.extract)
  %O_cast.sroa.17.24.insert.ext = zext i16 %136 to i64
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.52.vec.extract)
  %O_cast.sroa.17.26.insert.ext = zext i16 %137 to i64
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.56.vec.extract)
  %O_cast.sroa.17.28.insert.ext = zext i16 %138 to i64
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.60.vec.extract)
  %O_cast.sroa.17.30.insert.ext = zext i16 %139 to i64
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.64.vec.extract)
  %O_cast.sroa.22.32.insert.ext = zext i16 %140 to i64
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.68.vec.extract)
  %O_cast.sroa.22.34.insert.ext = zext i16 %141 to i64
  %O_cast.sroa.22.34.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.34.insert.ext, 16
  %O_cast.sroa.22.34.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.shift, %O_cast.sroa.22.32.insert.ext
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.72.vec.extract)
  %O_cast.sroa.22.36.insert.ext = zext i16 %142 to i64
  %O_cast.sroa.22.36.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.36.insert.ext, 32
  %O_cast.sroa.22.36.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.insert, %O_cast.sroa.22.36.insert.shift
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.76.vec.extract)
  %O_cast.sroa.22.38.insert.ext = zext i16 %143 to i64
  %O_cast.sroa.22.38.insert.shift = shl nuw i64 %O_cast.sroa.22.38.insert.ext, 48
  %O_cast.sroa.22.38.insert.insert = or disjoint i64 %O_cast.sroa.22.36.insert.insert, %O_cast.sroa.22.38.insert.shift
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.80.vec.extract)
  %O_cast.sroa.27.40.insert.ext = zext i16 %144 to i64
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.84.vec.extract)
  %O_cast.sroa.27.42.insert.ext = zext i16 %145 to i64
  %O_cast.sroa.27.42.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.42.insert.ext, 16
  %O_cast.sroa.27.42.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.shift, %O_cast.sroa.27.40.insert.ext
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.88.vec.extract)
  %O_cast.sroa.27.44.insert.ext = zext i16 %146 to i64
  %O_cast.sroa.27.44.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.44.insert.ext, 32
  %O_cast.sroa.27.44.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.insert, %O_cast.sroa.27.44.insert.shift
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.92.vec.extract)
  %O_cast.sroa.27.46.insert.ext = zext i16 %147 to i64
  %O_cast.sroa.27.46.insert.shift = shl nuw i64 %O_cast.sroa.27.46.insert.ext, 48
  %O_cast.sroa.27.46.insert.insert = or disjoint i64 %O_cast.sroa.27.44.insert.insert, %O_cast.sroa.27.46.insert.shift
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.96.vec.extract)
  %O_cast.sroa.32.48.insert.ext = zext i16 %148 to i64
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.100.vec.extract)
  %O_cast.sroa.32.50.insert.ext = zext i16 %149 to i64
  %O_cast.sroa.32.50.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.50.insert.ext, 16
  %O_cast.sroa.32.50.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.shift, %O_cast.sroa.32.48.insert.ext
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.104.vec.extract)
  %O_cast.sroa.32.52.insert.ext = zext i16 %150 to i64
  %O_cast.sroa.32.52.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.52.insert.ext, 32
  %O_cast.sroa.32.52.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.insert, %O_cast.sroa.32.52.insert.shift
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.108.vec.extract)
  %O_cast.sroa.32.54.insert.ext = zext i16 %151 to i64
  %O_cast.sroa.32.54.insert.shift = shl nuw i64 %O_cast.sroa.32.54.insert.ext, 48
  %O_cast.sroa.32.54.insert.insert = or disjoint i64 %O_cast.sroa.32.52.insert.insert, %O_cast.sroa.32.54.insert.shift
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.112.vec.extract)
  %O_cast.sroa.37.56.insert.ext = zext i16 %152 to i64
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.116.vec.extract)
  %O_cast.sroa.37.58.insert.ext = zext i16 %153 to i64
  %O_cast.sroa.37.58.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.58.insert.ext, 16
  %O_cast.sroa.37.58.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.shift, %O_cast.sroa.37.56.insert.ext
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.120.vec.extract)
  %O_cast.sroa.37.60.insert.ext = zext i16 %154 to i64
  %O_cast.sroa.37.60.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.60.insert.ext, 32
  %O_cast.sroa.37.60.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.insert, %O_cast.sroa.37.60.insert.shift
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.124.vec.extract)
  %O_cast.sroa.37.62.insert.ext = zext i16 %155 to i64
  %O_cast.sroa.37.62.insert.shift = shl nuw i64 %O_cast.sroa.37.62.insert.ext, 48
  %O_cast.sroa.37.62.insert.insert = or disjoint i64 %O_cast.sroa.37.60.insert.insert, %O_cast.sroa.37.62.insert.shift
  %156 = lshr i32 %1, 2
  %mul376 = and i32 %156, 252
  %add373 = add nuw nsw i32 %add, %mul376
  %157 = zext nneg i32 %add373 to i64
  %add.ptr379 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr379, align 8
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  %add.ptr379.1 = getelementptr inbounds i8, ptr addrspace(1) %158, i64 32
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr379.1, align 8
  %159 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  %add.ptr379.2 = getelementptr inbounds i8, ptr addrspace(1) %159, i64 64
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr379.2, align 8
  %160 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  %add.ptr379.3 = getelementptr inbounds i8, ptr addrspace(1) %160, i64 96
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr379.3, align 8
  %161 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  %add.ptr379.4 = getelementptr inbounds i8, ptr addrspace(1) %161, i64 128
  store i64 %O_cast.sroa.22.38.insert.insert, ptr addrspace(1) %add.ptr379.4, align 8
  %162 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  %add.ptr379.5 = getelementptr inbounds i8, ptr addrspace(1) %162, i64 160
  store i64 %O_cast.sroa.27.46.insert.insert, ptr addrspace(1) %add.ptr379.5, align 8
  %163 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  %add.ptr379.6 = getelementptr inbounds i8, ptr addrspace(1) %163, i64 192
  store i64 %O_cast.sroa.32.54.insert.insert, ptr addrspace(1) %add.ptr379.6, align 8
  %164 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157
  %add.ptr379.7 = getelementptr inbounds i8, ptr addrspace(1) %164, i64 224
  store i64 %O_cast.sroa.37.62.insert.insert, ptr addrspace(1) %add.ptr379.7, align 8
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


