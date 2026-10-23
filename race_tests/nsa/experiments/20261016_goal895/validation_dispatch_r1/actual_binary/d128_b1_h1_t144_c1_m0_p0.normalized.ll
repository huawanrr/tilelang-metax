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
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp31 = icmp ugt i32 %7, 8
  %shr34 = lshr i32 %0, 4
  %cmp35.not = icmp ugt i32 %7, %shr34
  %or.cond495 = or i1 %cmp31, %cmp35.not
  br i1 %or.cond495, label %if.end331, label %if.then

if.then:                                          ; preds = %entry
  %mul47 = shl nuw nsw i32 %7, 11
  %mul51 = shl nuw nsw i32 %1, 3
  %add49 = add nuw nsw i32 %mul47, %mul51
  %8 = zext nneg i32 %add49 to i64
  %add.ptr56 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = load i32, ptr addrspace(4) %add.ptr56, align 4, !tbaa !30
  %10 = or disjoint i64 %8, 2
  %add.ptr56.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr56.1, align 4, !tbaa !30
  %12 = or disjoint i64 %8, 4
  %add.ptr56.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr56.2, align 4, !tbaa !30
  %14 = or disjoint i64 %8, 6
  %add.ptr56.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr56.3, align 4, !tbaa !30
  %16 = add nuw nsw i64 %8, 512
  %add.ptr56.1510 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr56.1510, align 4, !tbaa !30
  %18 = add nuw nsw i64 %8, 514
  %add.ptr56.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr56.1.1, align 4, !tbaa !30
  %20 = add nuw nsw i64 %8, 516
  %add.ptr56.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr56.2.1, align 4, !tbaa !30
  %22 = add nuw nsw i64 %8, 518
  %add.ptr56.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr56.3.1, align 4, !tbaa !30
  %24 = add nuw nsw i64 %8, 1024
  %add.ptr56.2512 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr56.2512, align 4, !tbaa !30
  %26 = add nuw nsw i64 %8, 1026
  %add.ptr56.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26
  %27 = load i32, ptr addrspace(4) %add.ptr56.1.2, align 4, !tbaa !30
  %28 = add nuw nsw i64 %8, 1028
  %add.ptr56.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28
  %29 = load i32, ptr addrspace(4) %add.ptr56.2.2, align 4, !tbaa !30
  %30 = add nuw nsw i64 %8, 1030
  %add.ptr56.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %30
  %31 = load i32, ptr addrspace(4) %add.ptr56.3.2, align 4, !tbaa !30
  %32 = add nuw nsw i64 %8, 1536
  %add.ptr56.3514 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %32
  %33 = load i32, ptr addrspace(4) %add.ptr56.3514, align 4, !tbaa !30
  %34 = add nuw nsw i64 %8, 1538
  %add.ptr56.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %34
  %35 = load i32, ptr addrspace(4) %add.ptr56.1.3, align 4, !tbaa !30
  %36 = add nuw nsw i64 %8, 1540
  %add.ptr56.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %36
  %37 = load i32, ptr addrspace(4) %add.ptr56.2.3, align 4, !tbaa !30
  %38 = add nuw nsw i64 %8, 1542
  %add.ptr56.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %38
  %39 = load i32, ptr addrspace(4) %add.ptr56.3.3, align 4, !tbaa !30
  %add.ptr86 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %40 = load i32, ptr addrspace(4) %add.ptr86, align 4, !tbaa !30
  %add.ptr86.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %41 = load i32, ptr addrspace(4) %add.ptr86.1, align 4, !tbaa !30
  %add.ptr86.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %42 = load i32, ptr addrspace(4) %add.ptr86.2, align 4, !tbaa !30
  %add.ptr86.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %43 = load i32, ptr addrspace(4) %add.ptr86.3, align 4, !tbaa !30
  %add.ptr86.1526 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %44 = load i32, ptr addrspace(4) %add.ptr86.1526, align 4, !tbaa !30
  %add.ptr86.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %45 = load i32, ptr addrspace(4) %add.ptr86.1.1, align 4, !tbaa !30
  %add.ptr86.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %46 = load i32, ptr addrspace(4) %add.ptr86.2.1, align 4, !tbaa !30
  %add.ptr86.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %47 = load i32, ptr addrspace(4) %add.ptr86.3.1, align 4, !tbaa !30
  %add.ptr86.2528 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %48 = load i32, ptr addrspace(4) %add.ptr86.2528, align 4, !tbaa !30
  %add.ptr86.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26
  %49 = load i32, ptr addrspace(4) %add.ptr86.1.2, align 4, !tbaa !30
  %add.ptr86.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28
  %50 = load i32, ptr addrspace(4) %add.ptr86.2.2, align 4, !tbaa !30
  %add.ptr86.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %30
  %51 = load i32, ptr addrspace(4) %add.ptr86.3.2, align 4, !tbaa !30
  %add.ptr86.3530 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %32
  %52 = load i32, ptr addrspace(4) %add.ptr86.3530, align 4, !tbaa !30
  %add.ptr86.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %34
  %53 = load i32, ptr addrspace(4) %add.ptr86.1.3, align 4, !tbaa !30
  %add.ptr86.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %36
  %54 = load i32, ptr addrspace(4) %add.ptr86.2.3, align 4, !tbaa !30
  %add.ptr86.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %38
  %55 = load i32, ptr addrspace(4) %add.ptr86.3.3, align 4, !tbaa !30
  %mul110 = and i32 %mul51, 8064
  %and113 = and i32 %1, 15
  %shr116 = lshr i32 %1, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul110
  %xor = xor i32 %shr116, %and113
  %add.ptr121.idx = shl nuw nsw i32 %xor, 4
  %add.ptr121 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr121.idx
  store i32 %9, ptr addrspace(3) %add.ptr121, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr121.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121, i32 4
  store i32 %11, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr121.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr121.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121, i32 8
  store i32 %13, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr121.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr121.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121, i32 12
  store i32 %15, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr121.sroa_idx, align 4, !tbaa !30
  %add117.1 = add nuw nsw i32 %shr116, 4
  %xor.1 = xor i32 %add117.1, %and113
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr121.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr121.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr121.idx.1
  store i32 %17, ptr addrspace(3) %add.ptr121.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr121.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.1, i32 4
  store i32 %19, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr121.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr121.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.1, i32 8
  store i32 %21, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr121.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr121.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.1, i32 12
  store i32 %23, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr121.1.sroa_idx, align 4, !tbaa !30
  %add117.2 = add nuw nsw i32 %shr116, 8
  %xor.2 = xor i32 %add117.2, %and113
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr121.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr121.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr121.idx.2
  store i32 %25, ptr addrspace(3) %add.ptr121.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr121.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.2, i32 4
  store i32 %27, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr121.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr121.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.2, i32 8
  store i32 %29, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr121.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr121.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.2, i32 12
  store i32 %31, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr121.2.sroa_idx, align 4, !tbaa !30
  %add117.3 = add nuw nsw i32 %shr116, 12
  %xor.3 = xor i32 %add117.3, %and113
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr121.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr121.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr121.idx.3
  store i32 %33, ptr addrspace(3) %add.ptr121.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr121.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.3, i32 4
  store i32 %35, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr121.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr121.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.3, i32 8
  store i32 %37, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr121.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr121.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr121.3, i32 12
  store i32 %39, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr121.3.sroa_idx, align 4, !tbaa !30
  %mul36 = shl nuw nsw i32 %7, 4
  %add127 = or disjoint i32 %mul36, 15
  %cmp128 = icmp ult i32 %0, %add127
  br i1 %cmp128, label %for.cond130.preheader, label %if.end154

for.cond130.preheader:                            ; preds = %if.then
  %56 = lshr i32 %1, 2
  %mul136 = and i32 %56, 252
  %add138 = add nuw nsw i32 %mul36, %mul136
  %cmp141.not = icmp ugt i32 %add138, %0
  %spec.select = select i1 %cmp141.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert579 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp141.not.1.not = icmp ult i32 %add138, %0
  %spec.select.1 = select i1 %cmp141.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert592 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert579, float %spec.select.1, i64 1
  %add139.2 = or disjoint i32 %add138, 2
  %cmp141.not.2 = icmp ugt i32 %add139.2, %0
  %spec.select.2 = select i1 %cmp141.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert605 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert592, float %spec.select.2, i64 2
  %add139.3 = or disjoint i32 %add138, 3
  %cmp141.not.3 = icmp ugt i32 %add139.3, %0
  %spec.select.3 = select i1 %cmp141.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert618 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert605, float %spec.select.3, i64 3
  br label %if.end154

if.end154:                                        ; preds = %if.then, %for.cond130.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert618, %for.cond130.preheader ], [ zeroinitializer, %if.then ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %57 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul7
  %add.ptr172 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr121.idx
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr172, align 16
  %kb.sroa.10.0.add.ptr172.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172, i32 8
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr172.sroa_idx, align 8
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !79
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %58), !call_argsrelate !79
  %add.ptr172.1 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr121.idx.1
  %kb.sroa.0.0.copyload567 = load <4 x half>, ptr addrspace(3) %add.ptr172.1, align 16
  %kb.sroa.10.0.add.ptr172.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172.1, i32 8
  %kb.sroa.10.0.copyload570 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr172.1.sroa_idx, align 8
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload567, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %59), !call_argsrelate !79
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload570, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %60), !call_argsrelate !79
  %add.ptr172.2 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr121.idx.2
  %kb.sroa.0.0.copyload568 = load <4 x half>, ptr addrspace(3) %add.ptr172.2, align 16
  %kb.sroa.10.0.add.ptr172.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172.2, i32 8
  %kb.sroa.10.0.copyload571 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr172.2.sroa_idx, align 8
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload568, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %61), !call_argsrelate !79
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload571, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %62), !call_argsrelate !79
  %add.ptr172.3 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr121.idx.3
  %kb.sroa.0.0.copyload569 = load <4 x half>, ptr addrspace(3) %add.ptr172.3, align 16
  %kb.sroa.10.0.add.ptr172.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172.3, i32 8
  %kb.sroa.10.0.copyload572 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr172.3.sroa_idx, align 8
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload569, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %63), !call_argsrelate !79
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload572, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %64), !call_argsrelate !79
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr210.idx = shl nuw nsw i32 %1, 4
  %invariant.gep481 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr210.idx
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
  %mul220 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul220, float 0x4024CB5EC0000000)
  %67 = tail call contract noundef float @llvm.exp.f32(float %66)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %65, i64 1
  %mul220.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul220.1, float 0x4024CB5EC0000000)
  %69 = tail call contract noundef float @llvm.exp.f32(float %68)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %65, i64 2
  %mul220.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul220.2, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %65, i64 3
  %mul220.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul220.3, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %add236.1 = fadd contract float %67, %69
  %add236.2 = fadd contract float %add236.1, %71
  %add236.3 = fadd contract float %add236.2, %73
  %74 = bitcast float %add236.3 to i32
  %75 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %76 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %75) #10
  %xor.i.i = xor i32 %76, 32
  %77 = and i32 %76, -64
  %and.i.i = add nsw i32 %77, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %76
  %shl.i.i = shl i32 %cond.i.i, 2
  %78 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %74)
  %79 = bitcast i32 %78 to float
  %add244 = fadd contract float %add236.3, %79
  %80 = bitcast float %add244 to i32
  %81 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %82 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %81) #10
  %xor.i.i462 = xor i32 %82, 16
  %83 = and i32 %82, -64
  %and.i.i463 = add nsw i32 %83, 64
  %cmp.not.i.i464 = icmp slt i32 %xor.i.i462, %and.i.i463
  %cond.i.i465 = select i1 %cmp.not.i.i464, i32 %xor.i.i462, i32 %82
  %shl.i.i466 = shl i32 %cond.i.i465, 2
  %84 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i466, i32 %80)
  %85 = bitcast i32 %84 to float
  %add249 = fadd contract float %add244, %85
  %cmp252 = fcmp contract ogt float %add249, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add249
  %condval_1.0 = select i1 %cmp252, float %div, float 0.000000e+00
  %mul265 = fmul contract float %condval_1.0, %67
  %mul265.1 = fmul contract float %condval_1.0, %69
  %mul265.2 = fmul contract float %condval_1.0, %71
  %mul265.3 = fmul contract float %condval_1.0, %73
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul265)
  %87 = insertelement <4 x i16> poison, i16 %86, i64 0
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul265.1)
  %89 = insertelement <4 x i16> %87, i16 %88, i64 1
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul265.2)
  %91 = insertelement <4 x i16> %89, i16 %90, i64 2
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul265.3)
  %93 = insertelement <4 x i16> %91, i16 %92, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %93 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %94 = shl nuw nsw i32 %1, 5
  %mul293 = and i32 %94, 32256
  %add300 = or disjoint i32 %mul293, %and113
  %arrayidx302 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300
  %95 = load half, ptr addrspace(3) %arrayidx302, align 2, !tbaa !150
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %95, i64 0
  %add295.1 = or disjoint i32 %mul293, %and113
  %add300.1 = or disjoint i32 %add295.1, 128
  %arrayidx302.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1
  %96 = load half, ptr addrspace(3) %arrayidx302.1, align 2, !tbaa !150
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %96, i64 1
  %add295.2 = or disjoint i32 %mul293, %and113
  %add300.2 = or disjoint i32 %add295.2, 256
  %arrayidx302.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2
  %97 = load half, ptr addrspace(3) %arrayidx302.2, align 2, !tbaa !150
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %97, i64 2
  %add295.3 = or disjoint i32 %mul293, %and113
  %add300.3 = or disjoint i32 %add295.3, 384
  %arrayidx302.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3
  %98 = load half, ptr addrspace(3) %arrayidx302.3, align 2, !tbaa !150
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %98, i64 3
  %add297.1534 = or disjoint i32 %mul293, %and113
  %add300.1535 = or disjoint i32 %add297.1534, 16
  %arrayidx302.1536 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1535
  %99 = load half, ptr addrspace(3) %arrayidx302.1536, align 2, !tbaa !150
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %99, i64 0
  %add297.1.1 = or disjoint i32 %mul293, %and113
  %add300.1.1 = or disjoint i32 %add297.1.1, 144
  %arrayidx302.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1.1
  %100 = load half, ptr addrspace(3) %arrayidx302.1.1, align 2, !tbaa !150
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %100, i64 1
  %add297.2.1 = or disjoint i32 %mul293, %and113
  %add300.2.1 = or disjoint i32 %add297.2.1, 272
  %arrayidx302.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2.1
  %101 = load half, ptr addrspace(3) %arrayidx302.2.1, align 2, !tbaa !150
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %101, i64 2
  %add297.3.1 = or disjoint i32 %mul293, %and113
  %add300.3.1 = or disjoint i32 %add297.3.1, 400
  %arrayidx302.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3.1
  %102 = load half, ptr addrspace(3) %arrayidx302.3.1, align 2, !tbaa !150
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %102, i64 3
  %add297.2538 = or disjoint i32 %mul293, %and113
  %add300.2539 = or disjoint i32 %add297.2538, 32
  %arrayidx302.2540 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2539
  %103 = load half, ptr addrspace(3) %arrayidx302.2540, align 2, !tbaa !150
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %103, i64 0
  %add297.1.2 = or disjoint i32 %mul293, %and113
  %add300.1.2 = or disjoint i32 %add297.1.2, 160
  %arrayidx302.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1.2
  %104 = load half, ptr addrspace(3) %arrayidx302.1.2, align 2, !tbaa !150
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %104, i64 1
  %add297.2.2 = or disjoint i32 %mul293, %and113
  %add300.2.2 = or disjoint i32 %add297.2.2, 288
  %arrayidx302.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2.2
  %105 = load half, ptr addrspace(3) %arrayidx302.2.2, align 2, !tbaa !150
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %105, i64 2
  %add297.3.2 = or disjoint i32 %mul293, %and113
  %add300.3.2 = or disjoint i32 %add297.3.2, 416
  %arrayidx302.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3.2
  %106 = load half, ptr addrspace(3) %arrayidx302.3.2, align 2, !tbaa !150
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %106, i64 3
  %add297.3542 = or disjoint i32 %mul293, %and113
  %add300.3543 = or disjoint i32 %add297.3542, 48
  %arrayidx302.3544 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3543
  %107 = load half, ptr addrspace(3) %arrayidx302.3544, align 2, !tbaa !150
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %107, i64 0
  %add297.1.3 = or disjoint i32 %mul293, %and113
  %add300.1.3 = or disjoint i32 %add297.1.3, 176
  %arrayidx302.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1.3
  %108 = load half, ptr addrspace(3) %arrayidx302.1.3, align 2, !tbaa !150
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %108, i64 1
  %add297.2.3 = or disjoint i32 %mul293, %and113
  %add300.2.3 = or disjoint i32 %add297.2.3, 304
  %arrayidx302.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2.3
  %109 = load half, ptr addrspace(3) %arrayidx302.2.3, align 2, !tbaa !150
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %109, i64 2
  %add297.3.3 = or disjoint i32 %mul293, %and113
  %add300.3.3 = or disjoint i32 %add297.3.3, 432
  %arrayidx302.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3.3
  %110 = load half, ptr addrspace(3) %arrayidx302.3.3, align 2, !tbaa !150
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %110, i64 3
  %add297.4 = or disjoint i32 %mul293, %and113
  %add300.4 = or disjoint i32 %add297.4, 64
  %arrayidx302.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.4
  %111 = load half, ptr addrspace(3) %arrayidx302.4, align 2, !tbaa !150
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %111, i64 0
  %add297.1.4 = or disjoint i32 %mul293, %and113
  %add300.1.4 = or disjoint i32 %add297.1.4, 192
  %arrayidx302.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1.4
  %112 = load half, ptr addrspace(3) %arrayidx302.1.4, align 2, !tbaa !150
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %112, i64 1
  %add297.2.4 = or disjoint i32 %mul293, %and113
  %add300.2.4 = or disjoint i32 %add297.2.4, 320
  %arrayidx302.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2.4
  %113 = load half, ptr addrspace(3) %arrayidx302.2.4, align 2, !tbaa !150
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %113, i64 2
  %add297.3.4 = or disjoint i32 %mul293, %and113
  %add300.3.4 = or disjoint i32 %add297.3.4, 448
  %arrayidx302.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3.4
  %114 = load half, ptr addrspace(3) %arrayidx302.3.4, align 2, !tbaa !150
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %114, i64 3
  %add297.5 = or disjoint i32 %mul293, %and113
  %add300.5 = or disjoint i32 %add297.5, 80
  %arrayidx302.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.5
  %115 = load half, ptr addrspace(3) %arrayidx302.5, align 2, !tbaa !150
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %115, i64 0
  %add297.1.5 = or disjoint i32 %mul293, %and113
  %add300.1.5 = or disjoint i32 %add297.1.5, 208
  %arrayidx302.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1.5
  %116 = load half, ptr addrspace(3) %arrayidx302.1.5, align 2, !tbaa !150
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %116, i64 1
  %add297.2.5 = or disjoint i32 %mul293, %and113
  %add300.2.5 = or disjoint i32 %add297.2.5, 336
  %arrayidx302.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2.5
  %117 = load half, ptr addrspace(3) %arrayidx302.2.5, align 2, !tbaa !150
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %117, i64 2
  %add297.3.5 = or disjoint i32 %mul293, %and113
  %add300.3.5 = or disjoint i32 %add297.3.5, 464
  %arrayidx302.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3.5
  %118 = load half, ptr addrspace(3) %arrayidx302.3.5, align 2, !tbaa !150
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %118, i64 3
  %add297.6 = or disjoint i32 %mul293, %and113
  %add300.6 = or disjoint i32 %add297.6, 96
  %arrayidx302.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.6
  %119 = load half, ptr addrspace(3) %arrayidx302.6, align 2, !tbaa !150
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %119, i64 0
  %add297.1.6 = or disjoint i32 %mul293, %and113
  %add300.1.6 = or disjoint i32 %add297.1.6, 224
  %arrayidx302.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1.6
  %120 = load half, ptr addrspace(3) %arrayidx302.1.6, align 2, !tbaa !150
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %120, i64 1
  %add297.2.6 = or disjoint i32 %mul293, %and113
  %add300.2.6 = or disjoint i32 %add297.2.6, 352
  %arrayidx302.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2.6
  %121 = load half, ptr addrspace(3) %arrayidx302.2.6, align 2, !tbaa !150
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %121, i64 2
  %add297.3.6 = or disjoint i32 %94, %and113
  %add300.3.6 = or i32 %add297.3.6, 480
  %arrayidx302.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3.6
  %122 = load half, ptr addrspace(3) %arrayidx302.3.6, align 2, !tbaa !150
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %122, i64 3
  %add297.7 = or disjoint i32 %mul293, %and113
  %add300.7 = or disjoint i32 %add297.7, 112
  %arrayidx302.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.7
  %123 = load half, ptr addrspace(3) %arrayidx302.7, align 2, !tbaa !150
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %123, i64 0
  %add297.1.7 = or disjoint i32 %mul293, %and113
  %add300.1.7 = or disjoint i32 %add297.1.7, 240
  %arrayidx302.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.1.7
  %124 = load half, ptr addrspace(3) %arrayidx302.1.7, align 2, !tbaa !150
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %124, i64 1
  %add297.2.7 = or disjoint i32 %mul293, %and113
  %add300.2.7 = or disjoint i32 %add297.2.7, 368
  %arrayidx302.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.2.7
  %125 = load half, ptr addrspace(3) %arrayidx302.2.7, align 2, !tbaa !150
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %125, i64 2
  %add297.3.7 = or disjoint i32 %94, %and113
  %add300.3.7 = or i32 %add297.3.7, 496
  %arrayidx302.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add300.3.7
  %126 = load half, ptr addrspace(3) %arrayidx302.3.7, align 2, !tbaa !150
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %126, i64 3
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end331

if.end331:                                        ; preds = %if.end154, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %127, %if.end154 ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %128, %if.end154 ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %129, %if.end154 ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %130, %if.end154 ]
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %131, %if.end154 ]
  %acc_o.sroa.52.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %132, %if.end154 ]
  %acc_o.sroa.62.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %133, %if.end154 ]
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %134, %if.end154 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_cast.sroa.0.0.insert.ext = zext i16 %135 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_cast.sroa.0.2.insert.ext = zext i16 %136 to i64
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_cast.sroa.0.4.insert.ext = zext i16 %137 to i64
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_cast.sroa.0.6.insert.ext = zext i16 %138 to i64
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.16.vec.extract)
  %O_cast.sroa.7.8.insert.ext = zext i16 %139 to i64
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.20.vec.extract)
  %O_cast.sroa.7.10.insert.ext = zext i16 %140 to i64
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.24.vec.extract)
  %O_cast.sroa.7.12.insert.ext = zext i16 %141 to i64
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.28.vec.extract)
  %O_cast.sroa.7.14.insert.ext = zext i16 %142 to i64
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.32.vec.extract)
  %O_cast.sroa.12.16.insert.ext = zext i16 %143 to i64
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.36.vec.extract)
  %O_cast.sroa.12.18.insert.ext = zext i16 %144 to i64
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.40.vec.extract)
  %O_cast.sroa.12.20.insert.ext = zext i16 %145 to i64
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.44.vec.extract)
  %O_cast.sroa.12.22.insert.ext = zext i16 %146 to i64
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.48.vec.extract)
  %O_cast.sroa.17.24.insert.ext = zext i16 %147 to i64
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.52.vec.extract)
  %O_cast.sroa.17.26.insert.ext = zext i16 %148 to i64
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.56.vec.extract)
  %O_cast.sroa.17.28.insert.ext = zext i16 %149 to i64
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.60.vec.extract)
  %O_cast.sroa.17.30.insert.ext = zext i16 %150 to i64
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.64.vec.extract)
  %O_cast.sroa.22.32.insert.ext = zext i16 %151 to i64
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.68.vec.extract)
  %O_cast.sroa.22.34.insert.ext = zext i16 %152 to i64
  %O_cast.sroa.22.34.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.34.insert.ext, 16
  %O_cast.sroa.22.34.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.shift, %O_cast.sroa.22.32.insert.ext
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.72.vec.extract)
  %O_cast.sroa.22.36.insert.ext = zext i16 %153 to i64
  %O_cast.sroa.22.36.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.36.insert.ext, 32
  %O_cast.sroa.22.36.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.insert, %O_cast.sroa.22.36.insert.shift
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.76.vec.extract)
  %O_cast.sroa.22.38.insert.ext = zext i16 %154 to i64
  %O_cast.sroa.22.38.insert.shift = shl nuw i64 %O_cast.sroa.22.38.insert.ext, 48
  %O_cast.sroa.22.38.insert.insert = or disjoint i64 %O_cast.sroa.22.36.insert.insert, %O_cast.sroa.22.38.insert.shift
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.80.vec.extract)
  %O_cast.sroa.27.40.insert.ext = zext i16 %155 to i64
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.84.vec.extract)
  %O_cast.sroa.27.42.insert.ext = zext i16 %156 to i64
  %O_cast.sroa.27.42.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.42.insert.ext, 16
  %O_cast.sroa.27.42.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.shift, %O_cast.sroa.27.40.insert.ext
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.88.vec.extract)
  %O_cast.sroa.27.44.insert.ext = zext i16 %157 to i64
  %O_cast.sroa.27.44.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.44.insert.ext, 32
  %O_cast.sroa.27.44.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.insert, %O_cast.sroa.27.44.insert.shift
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.92.vec.extract)
  %O_cast.sroa.27.46.insert.ext = zext i16 %158 to i64
  %O_cast.sroa.27.46.insert.shift = shl nuw i64 %O_cast.sroa.27.46.insert.ext, 48
  %O_cast.sroa.27.46.insert.insert = or disjoint i64 %O_cast.sroa.27.44.insert.insert, %O_cast.sroa.27.46.insert.shift
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.96.vec.extract)
  %O_cast.sroa.32.48.insert.ext = zext i16 %159 to i64
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.100.vec.extract)
  %O_cast.sroa.32.50.insert.ext = zext i16 %160 to i64
  %O_cast.sroa.32.50.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.50.insert.ext, 16
  %O_cast.sroa.32.50.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.shift, %O_cast.sroa.32.48.insert.ext
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.104.vec.extract)
  %O_cast.sroa.32.52.insert.ext = zext i16 %161 to i64
  %O_cast.sroa.32.52.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.52.insert.ext, 32
  %O_cast.sroa.32.52.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.insert, %O_cast.sroa.32.52.insert.shift
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.108.vec.extract)
  %O_cast.sroa.32.54.insert.ext = zext i16 %162 to i64
  %O_cast.sroa.32.54.insert.shift = shl nuw i64 %O_cast.sroa.32.54.insert.ext, 48
  %O_cast.sroa.32.54.insert.insert = or disjoint i64 %O_cast.sroa.32.52.insert.insert, %O_cast.sroa.32.54.insert.shift
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.112.vec.extract)
  %O_cast.sroa.37.56.insert.ext = zext i16 %163 to i64
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.116.vec.extract)
  %O_cast.sroa.37.58.insert.ext = zext i16 %164 to i64
  %O_cast.sroa.37.58.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.58.insert.ext, 16
  %O_cast.sroa.37.58.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.shift, %O_cast.sroa.37.56.insert.ext
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.120.vec.extract)
  %O_cast.sroa.37.60.insert.ext = zext i16 %165 to i64
  %O_cast.sroa.37.60.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.60.insert.ext, 32
  %O_cast.sroa.37.60.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.insert, %O_cast.sroa.37.60.insert.shift
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.124.vec.extract)
  %O_cast.sroa.37.62.insert.ext = zext i16 %166 to i64
  %O_cast.sroa.37.62.insert.shift = shl nuw i64 %O_cast.sroa.37.62.insert.ext, 48
  %O_cast.sroa.37.62.insert.insert = or disjoint i64 %O_cast.sroa.37.60.insert.insert, %O_cast.sroa.37.62.insert.shift
  %167 = lshr i32 %1, 2
  %mul373 = and i32 %167, 252
  %add370 = add nuw nsw i32 %add, %mul373
  %168 = zext nneg i32 %add370 to i64
  %add.ptr376 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr376, align 8
  %169 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  %add.ptr376.1 = getelementptr inbounds i8, ptr addrspace(1) %169, i64 32
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr376.1, align 8
  %170 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  %add.ptr376.2 = getelementptr inbounds i8, ptr addrspace(1) %170, i64 64
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr376.2, align 8
  %171 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  %add.ptr376.3 = getelementptr inbounds i8, ptr addrspace(1) %171, i64 96
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr376.3, align 8
  %172 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  %add.ptr376.4 = getelementptr inbounds i8, ptr addrspace(1) %172, i64 128
  store i64 %O_cast.sroa.22.38.insert.insert, ptr addrspace(1) %add.ptr376.4, align 8
  %173 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  %add.ptr376.5 = getelementptr inbounds i8, ptr addrspace(1) %173, i64 160
  store i64 %O_cast.sroa.27.46.insert.insert, ptr addrspace(1) %add.ptr376.5, align 8
  %174 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  %add.ptr376.6 = getelementptr inbounds i8, ptr addrspace(1) %174, i64 192
  store i64 %O_cast.sroa.32.54.insert.insert, ptr addrspace(1) %add.ptr376.6, align 8
  %175 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %168
  %add.ptr376.7 = getelementptr inbounds i8, ptr addrspace(1) %175, i64 224
  store i64 %O_cast.sroa.37.62.insert.insert, ptr addrspace(1) %add.ptr376.7, align 8
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
attributes #10 = { nomerge }


