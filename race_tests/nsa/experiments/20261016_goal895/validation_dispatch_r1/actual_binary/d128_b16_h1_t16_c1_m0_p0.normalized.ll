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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 15
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 7
  %mul9 = and i32 %and, 1920
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 128
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 136
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 192
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 200
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8
  %mul20 = shl nsw i32 %0, 4
  %add22 = add nuw nsw i32 %mul20, %1
  %idxprom = zext nneg i32 %add22 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %8 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp37 = icmp eq i32 %8, 0
  br i1 %cmp37, label %for.cond42.preheader, label %if.end341

for.cond42.preheader:                             ; preds = %entry
  %mul52 = shl nsw i32 %0, 11
  %mul58 = shl nuw nsw i32 %2, 3
  %add56 = add nuw nsw i32 %mul58, %mul52
  %9 = zext nneg i32 %add56 to i64
  %add.ptr63 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr63, align 4, !tbaa !30
  %11 = or disjoint i64 %9, 2
  %add.ptr63.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr63.1, align 4, !tbaa !30
  %13 = or disjoint i64 %9, 4
  %add.ptr63.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr63.2, align 4, !tbaa !30
  %15 = or disjoint i64 %9, 6
  %add.ptr63.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr63.3, align 4, !tbaa !30
  %17 = add nuw nsw i64 %9, 512
  %add.ptr63.1522 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr63.1522, align 4, !tbaa !30
  %19 = add nuw nsw i64 %9, 514
  %add.ptr63.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr63.1.1, align 4, !tbaa !30
  %21 = add nuw nsw i64 %9, 516
  %add.ptr63.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr63.2.1, align 4, !tbaa !30
  %23 = add nuw nsw i64 %9, 518
  %add.ptr63.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23
  %24 = load i32, ptr addrspace(4) %add.ptr63.3.1, align 4, !tbaa !30
  %25 = add nuw nsw i64 %9, 1024
  %add.ptr63.2524 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25
  %26 = load i32, ptr addrspace(4) %add.ptr63.2524, align 4, !tbaa !30
  %27 = add nuw nsw i64 %9, 1026
  %add.ptr63.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27
  %28 = load i32, ptr addrspace(4) %add.ptr63.1.2, align 4, !tbaa !30
  %29 = add nuw nsw i64 %9, 1028
  %add.ptr63.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %29
  %30 = load i32, ptr addrspace(4) %add.ptr63.2.2, align 4, !tbaa !30
  %31 = add nuw nsw i64 %9, 1030
  %add.ptr63.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %31
  %32 = load i32, ptr addrspace(4) %add.ptr63.3.2, align 4, !tbaa !30
  %33 = add nuw nsw i64 %9, 1536
  %add.ptr63.3526 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %33
  %34 = load i32, ptr addrspace(4) %add.ptr63.3526, align 4, !tbaa !30
  %35 = add nuw nsw i64 %9, 1538
  %add.ptr63.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %35
  %36 = load i32, ptr addrspace(4) %add.ptr63.1.3, align 4, !tbaa !30
  %37 = add nuw nsw i64 %9, 1540
  %add.ptr63.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %37
  %38 = load i32, ptr addrspace(4) %add.ptr63.2.3, align 4, !tbaa !30
  %39 = add nuw nsw i64 %9, 1542
  %add.ptr63.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %39
  %40 = load i32, ptr addrspace(4) %add.ptr63.3.3, align 4, !tbaa !30
  %add.ptr96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %41 = load i32, ptr addrspace(4) %add.ptr96, align 4, !tbaa !30
  %add.ptr96.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %42 = load i32, ptr addrspace(4) %add.ptr96.1, align 4, !tbaa !30
  %add.ptr96.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %43 = load i32, ptr addrspace(4) %add.ptr96.2, align 4, !tbaa !30
  %add.ptr96.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %44 = load i32, ptr addrspace(4) %add.ptr96.3, align 4, !tbaa !30
  %add.ptr96.1538 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %45 = load i32, ptr addrspace(4) %add.ptr96.1538, align 4, !tbaa !30
  %add.ptr96.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %46 = load i32, ptr addrspace(4) %add.ptr96.1.1, align 4, !tbaa !30
  %add.ptr96.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %47 = load i32, ptr addrspace(4) %add.ptr96.2.1, align 4, !tbaa !30
  %add.ptr96.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23
  %48 = load i32, ptr addrspace(4) %add.ptr96.3.1, align 4, !tbaa !30
  %add.ptr96.2540 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25
  %49 = load i32, ptr addrspace(4) %add.ptr96.2540, align 4, !tbaa !30
  %add.ptr96.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27
  %50 = load i32, ptr addrspace(4) %add.ptr96.1.2, align 4, !tbaa !30
  %add.ptr96.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %29
  %51 = load i32, ptr addrspace(4) %add.ptr96.2.2, align 4, !tbaa !30
  %add.ptr96.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %31
  %52 = load i32, ptr addrspace(4) %add.ptr96.3.2, align 4, !tbaa !30
  %add.ptr96.3542 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %33
  %53 = load i32, ptr addrspace(4) %add.ptr96.3542, align 4, !tbaa !30
  %add.ptr96.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %35
  %54 = load i32, ptr addrspace(4) %add.ptr96.1.3, align 4, !tbaa !30
  %add.ptr96.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %37
  %55 = load i32, ptr addrspace(4) %add.ptr96.2.3, align 4, !tbaa !30
  %add.ptr96.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %39
  %56 = load i32, ptr addrspace(4) %add.ptr96.3.3, align 4, !tbaa !30
  %mul120 = and i32 %mul58, 8064
  %and123 = and i32 %2, 15
  %shr126 = lshr i32 %2, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul120
  %xor = xor i32 %shr126, %and123
  %add.ptr131.idx = shl nuw nsw i32 %xor, 4
  %add.ptr131 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr131.idx
  store i32 %10, ptr addrspace(3) %add.ptr131, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 4
  store i32 %12, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr131.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 8
  store i32 %14, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr131.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 12
  store i32 %16, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr131.sroa_idx, align 4, !tbaa !30
  %add127.1 = add nuw nsw i32 %shr126, 4
  %xor.1 = xor i32 %add127.1, %and123
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr131.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr131.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr131.idx.1
  store i32 %18, ptr addrspace(3) %add.ptr131.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 4
  store i32 %20, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr131.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 8
  store i32 %22, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr131.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 12
  store i32 %24, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr131.1.sroa_idx, align 4, !tbaa !30
  %add127.2 = add nuw nsw i32 %shr126, 8
  %xor.2 = xor i32 %add127.2, %and123
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr131.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr131.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr131.idx.2
  store i32 %26, ptr addrspace(3) %add.ptr131.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr131.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.2, i32 4
  store i32 %28, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr131.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr131.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.2, i32 8
  store i32 %30, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr131.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr131.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.2, i32 12
  store i32 %32, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr131.2.sroa_idx, align 4, !tbaa !30
  %add127.3 = add nuw nsw i32 %shr126, 12
  %xor.3 = xor i32 %add127.3, %and123
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr131.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr131.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr131.idx.3
  store i32 %34, ptr addrspace(3) %add.ptr131.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr131.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.3, i32 4
  store i32 %36, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr131.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr131.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.3, i32 8
  store i32 %38, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr131.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr131.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.3, i32 12
  store i32 %40, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr131.3.sroa_idx, align 4, !tbaa !30
  %cmp138 = icmp ult i32 %1, 15
  br i1 %cmp138, label %for.cond140.preheader, label %if.end164

for.cond140.preheader:                            ; preds = %for.cond42.preheader
  %57 = lshr i32 %2, 2
  %mul146 = and i32 %57, 252
  %cmp151.not = icmp ugt i32 %mul146, %1
  %spec.select = select i1 %cmp151.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert591 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp151.not.1.not = icmp ult i32 %mul146, %1
  %spec.select.1 = select i1 %cmp151.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert604 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert591, float %spec.select.1, i64 1
  %add149.2 = or disjoint i32 %mul146, 2
  %cmp151.not.2 = icmp ugt i32 %add149.2, %1
  %spec.select.2 = select i1 %cmp151.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert617 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert604, float %spec.select.2, i64 2
  %add149.3 = or i32 %57, 3
  %cmp151.not.3 = icmp ugt i32 %add149.3, %1
  %spec.select.3 = select i1 %cmp151.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert630 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert617, float %spec.select.3, i64 3
  br label %if.end164

if.end164:                                        ; preds = %for.cond42.preheader, %for.cond140.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert630, %for.cond140.preheader ], [ zeroinitializer, %for.cond42.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %58 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul9
  %add.ptr182 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr182, align 16
  %kb.sroa.10.0.add.ptr182.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182, i32 8
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.sroa_idx, align 8
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !79
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %59), !call_argsrelate !79
  %add.ptr182.1 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx.1
  %kb.sroa.0.0.copyload579 = load <4 x half>, ptr addrspace(3) %add.ptr182.1, align 16
  %kb.sroa.10.0.add.ptr182.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182.1, i32 8
  %kb.sroa.10.0.copyload582 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.1.sroa_idx, align 8
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload579, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %60), !call_argsrelate !79
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload582, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %61), !call_argsrelate !79
  %add.ptr182.2 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx.2
  %kb.sroa.0.0.copyload580 = load <4 x half>, ptr addrspace(3) %add.ptr182.2, align 16
  %kb.sroa.10.0.add.ptr182.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182.2, i32 8
  %kb.sroa.10.0.copyload583 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.2.sroa_idx, align 8
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload580, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %62), !call_argsrelate !79
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload583, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %63), !call_argsrelate !79
  %add.ptr182.3 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx.3
  %kb.sroa.0.0.copyload581 = load <4 x half>, ptr addrspace(3) %add.ptr182.3, align 16
  %kb.sroa.10.0.add.ptr182.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182.3, i32 8
  %kb.sroa.10.0.copyload584 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.3.sroa_idx, align 8
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload581, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %64), !call_argsrelate !79
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload584, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %65), !call_argsrelate !79
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr220.idx = shl nuw nsw i32 %2, 4
  %invariant.gep494 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr220.idx
  store i32 %41, ptr addrspace(3) %invariant.gep494, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep494.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 4
  store i32 %42, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep494.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep494.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 8
  store i32 %43, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep494.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep494.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 12
  store i32 %44, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep494.sroa_idx, align 4, !tbaa !30
  %gep495.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1024
  store i32 %45, ptr addrspace(3) %gep495.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep495.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1028
  store i32 %46, ptr addrspace(3) %V_reg.sroa.9.16.gep495.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep495.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1032
  store i32 %47, ptr addrspace(3) %V_reg.sroa.10.16.gep495.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep495.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1036
  store i32 %48, ptr addrspace(3) %V_reg.sroa.11.16.gep495.1.sroa_idx, align 4, !tbaa !30
  %gep495.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2048
  store i32 %49, ptr addrspace(3) %gep495.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep495.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2052
  store i32 %50, ptr addrspace(3) %V_reg.sroa.14.32.gep495.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep495.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2056
  store i32 %51, ptr addrspace(3) %V_reg.sroa.15.32.gep495.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep495.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2060
  store i32 %52, ptr addrspace(3) %V_reg.sroa.16.32.gep495.2.sroa_idx, align 4, !tbaa !30
  %gep495.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3072
  store i32 %53, ptr addrspace(3) %gep495.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep495.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3076
  store i32 %54, ptr addrspace(3) %V_reg.sroa.19.48.gep495.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep495.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3080
  store i32 %55, ptr addrspace(3) %V_reg.sroa.20.48.gep495.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep495.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3084
  store i32 %56, ptr addrspace(3) %V_reg.sroa.21.48.gep495.3.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %66, i64 0
  %mul230 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul230, float 0x4024CB5EC0000000)
  %68 = tail call contract noundef float @llvm.exp.f32(float %67)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %66, i64 1
  %mul230.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul230.1, float 0x4024CB5EC0000000)
  %70 = tail call contract noundef float @llvm.exp.f32(float %69)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %66, i64 2
  %mul230.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul230.2, float 0x4024CB5EC0000000)
  %72 = tail call contract noundef float @llvm.exp.f32(float %71)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %66, i64 3
  %mul230.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul230.3, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %add246.1 = fadd contract float %68, %70
  %add246.2 = fadd contract float %add246.1, %72
  %add246.3 = fadd contract float %add246.2, %74
  %75 = bitcast float %add246.3 to i32
  %76 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %77 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %76) #10
  %xor.i.i = xor i32 %77, 32
  %78 = and i32 %77, -64
  %and.i.i = add nsw i32 %78, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %77
  %shl.i.i = shl i32 %cond.i.i, 2
  %79 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %75)
  %80 = bitcast i32 %79 to float
  %add254 = fadd contract float %add246.3, %80
  %81 = bitcast float %add254 to i32
  %82 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %83 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %82) #10
  %xor.i.i475 = xor i32 %83, 16
  %84 = and i32 %83, -64
  %and.i.i476 = add nsw i32 %84, 64
  %cmp.not.i.i477 = icmp slt i32 %xor.i.i475, %and.i.i476
  %cond.i.i478 = select i1 %cmp.not.i.i477, i32 %xor.i.i475, i32 %83
  %shl.i.i479 = shl i32 %cond.i.i478, 2
  %85 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i479, i32 %81)
  %86 = bitcast i32 %85 to float
  %add259 = fadd contract float %add254, %86
  %cmp262 = fcmp contract ogt float %add259, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add259
  %condval_1.0 = select i1 %cmp262, float %div, float 0.000000e+00
  %mul275 = fmul contract float %condval_1.0, %68
  %mul275.1 = fmul contract float %condval_1.0, %70
  %mul275.2 = fmul contract float %condval_1.0, %72
  %mul275.3 = fmul contract float %condval_1.0, %74
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275)
  %88 = insertelement <4 x i16> poison, i16 %87, i64 0
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275.1)
  %90 = insertelement <4 x i16> %88, i16 %89, i64 1
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275.2)
  %92 = insertelement <4 x i16> %90, i16 %91, i64 2
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275.3)
  %94 = insertelement <4 x i16> %92, i16 %93, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %94 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %95 = shl nuw nsw i32 %2, 5
  %mul303 = and i32 %95, 32256
  %add310 = or disjoint i32 %mul303, %and123
  %arrayidx312 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310
  %96 = load half, ptr addrspace(3) %arrayidx312, align 2, !tbaa !150
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %96, i64 0
  %add305.1 = or disjoint i32 %mul303, %and123
  %add310.1 = or disjoint i32 %add305.1, 128
  %arrayidx312.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1
  %97 = load half, ptr addrspace(3) %arrayidx312.1, align 2, !tbaa !150
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %97, i64 1
  %add305.2 = or disjoint i32 %mul303, %and123
  %add310.2 = or disjoint i32 %add305.2, 256
  %arrayidx312.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2
  %98 = load half, ptr addrspace(3) %arrayidx312.2, align 2, !tbaa !150
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %98, i64 2
  %add305.3 = or disjoint i32 %mul303, %and123
  %add310.3 = or disjoint i32 %add305.3, 384
  %arrayidx312.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3
  %99 = load half, ptr addrspace(3) %arrayidx312.3, align 2, !tbaa !150
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %99, i64 3
  %add307.1546 = or disjoint i32 %mul303, %and123
  %add310.1547 = or disjoint i32 %add307.1546, 16
  %arrayidx312.1548 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1547
  %100 = load half, ptr addrspace(3) %arrayidx312.1548, align 2, !tbaa !150
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %100, i64 0
  %add307.1.1 = or disjoint i32 %mul303, %and123
  %add310.1.1 = or disjoint i32 %add307.1.1, 144
  %arrayidx312.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.1
  %101 = load half, ptr addrspace(3) %arrayidx312.1.1, align 2, !tbaa !150
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %101, i64 1
  %add307.2.1 = or disjoint i32 %mul303, %and123
  %add310.2.1 = or disjoint i32 %add307.2.1, 272
  %arrayidx312.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.1
  %102 = load half, ptr addrspace(3) %arrayidx312.2.1, align 2, !tbaa !150
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %102, i64 2
  %add307.3.1 = or disjoint i32 %mul303, %and123
  %add310.3.1 = or disjoint i32 %add307.3.1, 400
  %arrayidx312.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.1
  %103 = load half, ptr addrspace(3) %arrayidx312.3.1, align 2, !tbaa !150
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %103, i64 3
  %add307.2550 = or disjoint i32 %mul303, %and123
  %add310.2551 = or disjoint i32 %add307.2550, 32
  %arrayidx312.2552 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2551
  %104 = load half, ptr addrspace(3) %arrayidx312.2552, align 2, !tbaa !150
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %104, i64 0
  %add307.1.2 = or disjoint i32 %mul303, %and123
  %add310.1.2 = or disjoint i32 %add307.1.2, 160
  %arrayidx312.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.2
  %105 = load half, ptr addrspace(3) %arrayidx312.1.2, align 2, !tbaa !150
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %105, i64 1
  %add307.2.2 = or disjoint i32 %mul303, %and123
  %add310.2.2 = or disjoint i32 %add307.2.2, 288
  %arrayidx312.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.2
  %106 = load half, ptr addrspace(3) %arrayidx312.2.2, align 2, !tbaa !150
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %106, i64 2
  %add307.3.2 = or disjoint i32 %mul303, %and123
  %add310.3.2 = or disjoint i32 %add307.3.2, 416
  %arrayidx312.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.2
  %107 = load half, ptr addrspace(3) %arrayidx312.3.2, align 2, !tbaa !150
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %107, i64 3
  %add307.3554 = or disjoint i32 %mul303, %and123
  %add310.3555 = or disjoint i32 %add307.3554, 48
  %arrayidx312.3556 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3555
  %108 = load half, ptr addrspace(3) %arrayidx312.3556, align 2, !tbaa !150
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %108, i64 0
  %add307.1.3 = or disjoint i32 %mul303, %and123
  %add310.1.3 = or disjoint i32 %add307.1.3, 176
  %arrayidx312.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.3
  %109 = load half, ptr addrspace(3) %arrayidx312.1.3, align 2, !tbaa !150
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %109, i64 1
  %add307.2.3 = or disjoint i32 %mul303, %and123
  %add310.2.3 = or disjoint i32 %add307.2.3, 304
  %arrayidx312.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.3
  %110 = load half, ptr addrspace(3) %arrayidx312.2.3, align 2, !tbaa !150
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %110, i64 2
  %add307.3.3 = or disjoint i32 %mul303, %and123
  %add310.3.3 = or disjoint i32 %add307.3.3, 432
  %arrayidx312.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.3
  %111 = load half, ptr addrspace(3) %arrayidx312.3.3, align 2, !tbaa !150
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %111, i64 3
  %add307.4 = or disjoint i32 %mul303, %and123
  %add310.4 = or disjoint i32 %add307.4, 64
  %arrayidx312.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.4
  %112 = load half, ptr addrspace(3) %arrayidx312.4, align 2, !tbaa !150
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %112, i64 0
  %add307.1.4 = or disjoint i32 %mul303, %and123
  %add310.1.4 = or disjoint i32 %add307.1.4, 192
  %arrayidx312.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.4
  %113 = load half, ptr addrspace(3) %arrayidx312.1.4, align 2, !tbaa !150
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %113, i64 1
  %add307.2.4 = or disjoint i32 %mul303, %and123
  %add310.2.4 = or disjoint i32 %add307.2.4, 320
  %arrayidx312.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.4
  %114 = load half, ptr addrspace(3) %arrayidx312.2.4, align 2, !tbaa !150
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %114, i64 2
  %add307.3.4 = or disjoint i32 %mul303, %and123
  %add310.3.4 = or disjoint i32 %add307.3.4, 448
  %arrayidx312.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.4
  %115 = load half, ptr addrspace(3) %arrayidx312.3.4, align 2, !tbaa !150
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %115, i64 3
  %add307.5 = or disjoint i32 %mul303, %and123
  %add310.5 = or disjoint i32 %add307.5, 80
  %arrayidx312.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.5
  %116 = load half, ptr addrspace(3) %arrayidx312.5, align 2, !tbaa !150
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %116, i64 0
  %add307.1.5 = or disjoint i32 %mul303, %and123
  %add310.1.5 = or disjoint i32 %add307.1.5, 208
  %arrayidx312.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.5
  %117 = load half, ptr addrspace(3) %arrayidx312.1.5, align 2, !tbaa !150
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %117, i64 1
  %add307.2.5 = or disjoint i32 %mul303, %and123
  %add310.2.5 = or disjoint i32 %add307.2.5, 336
  %arrayidx312.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.5
  %118 = load half, ptr addrspace(3) %arrayidx312.2.5, align 2, !tbaa !150
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %118, i64 2
  %add307.3.5 = or disjoint i32 %mul303, %and123
  %add310.3.5 = or disjoint i32 %add307.3.5, 464
  %arrayidx312.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.5
  %119 = load half, ptr addrspace(3) %arrayidx312.3.5, align 2, !tbaa !150
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %119, i64 3
  %add307.6 = or disjoint i32 %mul303, %and123
  %add310.6 = or disjoint i32 %add307.6, 96
  %arrayidx312.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.6
  %120 = load half, ptr addrspace(3) %arrayidx312.6, align 2, !tbaa !150
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %120, i64 0
  %add307.1.6 = or disjoint i32 %mul303, %and123
  %add310.1.6 = or disjoint i32 %add307.1.6, 224
  %arrayidx312.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.6
  %121 = load half, ptr addrspace(3) %arrayidx312.1.6, align 2, !tbaa !150
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %121, i64 1
  %add307.2.6 = or disjoint i32 %mul303, %and123
  %add310.2.6 = or disjoint i32 %add307.2.6, 352
  %arrayidx312.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.6
  %122 = load half, ptr addrspace(3) %arrayidx312.2.6, align 2, !tbaa !150
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %122, i64 2
  %add307.3.6 = or disjoint i32 %95, %and123
  %add310.3.6 = or i32 %add307.3.6, 480
  %arrayidx312.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.6
  %123 = load half, ptr addrspace(3) %arrayidx312.3.6, align 2, !tbaa !150
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %123, i64 3
  %add307.7 = or disjoint i32 %mul303, %and123
  %add310.7 = or disjoint i32 %add307.7, 112
  %arrayidx312.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.7
  %124 = load half, ptr addrspace(3) %arrayidx312.7, align 2, !tbaa !150
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %124, i64 0
  %add307.1.7 = or disjoint i32 %mul303, %and123
  %add310.1.7 = or disjoint i32 %add307.1.7, 240
  %arrayidx312.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.7
  %125 = load half, ptr addrspace(3) %arrayidx312.1.7, align 2, !tbaa !150
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %125, i64 1
  %add307.2.7 = or disjoint i32 %mul303, %and123
  %add310.2.7 = or disjoint i32 %add307.2.7, 368
  %arrayidx312.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.7
  %126 = load half, ptr addrspace(3) %arrayidx312.2.7, align 2, !tbaa !150
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %126, i64 2
  %add307.3.7 = or disjoint i32 %95, %and123
  %add310.3.7 = or i32 %add307.3.7, 496
  %arrayidx312.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.7
  %127 = load half, ptr addrspace(3) %arrayidx312.3.7, align 2, !tbaa !150
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %127, i64 3
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end341

if.end341:                                        ; preds = %if.end164, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ %128, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.12.0 = phi <4 x float> [ %129, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.22.0 = phi <4 x float> [ %130, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.32.0 = phi <4 x float> [ %131, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.42.0 = phi <4 x float> [ %132, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.52.0 = phi <4 x float> [ %133, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.62.0 = phi <4 x float> [ %134, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.72.0 = phi <4 x float> [ %135, %if.end164 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_cast.sroa.0.0.insert.ext = zext i16 %136 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_cast.sroa.0.2.insert.ext = zext i16 %137 to i64
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_cast.sroa.0.4.insert.ext = zext i16 %138 to i64
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_cast.sroa.0.6.insert.ext = zext i16 %139 to i64
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.16.vec.extract)
  %O_cast.sroa.7.8.insert.ext = zext i16 %140 to i64
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.20.vec.extract)
  %O_cast.sroa.7.10.insert.ext = zext i16 %141 to i64
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.24.vec.extract)
  %O_cast.sroa.7.12.insert.ext = zext i16 %142 to i64
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.28.vec.extract)
  %O_cast.sroa.7.14.insert.ext = zext i16 %143 to i64
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.32.vec.extract)
  %O_cast.sroa.12.16.insert.ext = zext i16 %144 to i64
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.36.vec.extract)
  %O_cast.sroa.12.18.insert.ext = zext i16 %145 to i64
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.40.vec.extract)
  %O_cast.sroa.12.20.insert.ext = zext i16 %146 to i64
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.44.vec.extract)
  %O_cast.sroa.12.22.insert.ext = zext i16 %147 to i64
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.48.vec.extract)
  %O_cast.sroa.17.24.insert.ext = zext i16 %148 to i64
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.52.vec.extract)
  %O_cast.sroa.17.26.insert.ext = zext i16 %149 to i64
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.56.vec.extract)
  %O_cast.sroa.17.28.insert.ext = zext i16 %150 to i64
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.60.vec.extract)
  %O_cast.sroa.17.30.insert.ext = zext i16 %151 to i64
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.64.vec.extract)
  %O_cast.sroa.22.32.insert.ext = zext i16 %152 to i64
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.68.vec.extract)
  %O_cast.sroa.22.34.insert.ext = zext i16 %153 to i64
  %O_cast.sroa.22.34.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.34.insert.ext, 16
  %O_cast.sroa.22.34.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.shift, %O_cast.sroa.22.32.insert.ext
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.72.vec.extract)
  %O_cast.sroa.22.36.insert.ext = zext i16 %154 to i64
  %O_cast.sroa.22.36.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.36.insert.ext, 32
  %O_cast.sroa.22.36.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.insert, %O_cast.sroa.22.36.insert.shift
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.76.vec.extract)
  %O_cast.sroa.22.38.insert.ext = zext i16 %155 to i64
  %O_cast.sroa.22.38.insert.shift = shl nuw i64 %O_cast.sroa.22.38.insert.ext, 48
  %O_cast.sroa.22.38.insert.insert = or disjoint i64 %O_cast.sroa.22.36.insert.insert, %O_cast.sroa.22.38.insert.shift
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.80.vec.extract)
  %O_cast.sroa.27.40.insert.ext = zext i16 %156 to i64
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.84.vec.extract)
  %O_cast.sroa.27.42.insert.ext = zext i16 %157 to i64
  %O_cast.sroa.27.42.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.42.insert.ext, 16
  %O_cast.sroa.27.42.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.shift, %O_cast.sroa.27.40.insert.ext
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.88.vec.extract)
  %O_cast.sroa.27.44.insert.ext = zext i16 %158 to i64
  %O_cast.sroa.27.44.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.44.insert.ext, 32
  %O_cast.sroa.27.44.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.insert, %O_cast.sroa.27.44.insert.shift
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.92.vec.extract)
  %O_cast.sroa.27.46.insert.ext = zext i16 %159 to i64
  %O_cast.sroa.27.46.insert.shift = shl nuw i64 %O_cast.sroa.27.46.insert.ext, 48
  %O_cast.sroa.27.46.insert.insert = or disjoint i64 %O_cast.sroa.27.44.insert.insert, %O_cast.sroa.27.46.insert.shift
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.96.vec.extract)
  %O_cast.sroa.32.48.insert.ext = zext i16 %160 to i64
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.100.vec.extract)
  %O_cast.sroa.32.50.insert.ext = zext i16 %161 to i64
  %O_cast.sroa.32.50.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.50.insert.ext, 16
  %O_cast.sroa.32.50.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.shift, %O_cast.sroa.32.48.insert.ext
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.104.vec.extract)
  %O_cast.sroa.32.52.insert.ext = zext i16 %162 to i64
  %O_cast.sroa.32.52.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.52.insert.ext, 32
  %O_cast.sroa.32.52.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.insert, %O_cast.sroa.32.52.insert.shift
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.108.vec.extract)
  %O_cast.sroa.32.54.insert.ext = zext i16 %163 to i64
  %O_cast.sroa.32.54.insert.shift = shl nuw i64 %O_cast.sroa.32.54.insert.ext, 48
  %O_cast.sroa.32.54.insert.insert = or disjoint i64 %O_cast.sroa.32.52.insert.insert, %O_cast.sroa.32.54.insert.shift
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.112.vec.extract)
  %O_cast.sroa.37.56.insert.ext = zext i16 %164 to i64
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.116.vec.extract)
  %O_cast.sroa.37.58.insert.ext = zext i16 %165 to i64
  %O_cast.sroa.37.58.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.58.insert.ext, 16
  %O_cast.sroa.37.58.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.shift, %O_cast.sroa.37.56.insert.ext
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.120.vec.extract)
  %O_cast.sroa.37.60.insert.ext = zext i16 %166 to i64
  %O_cast.sroa.37.60.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.60.insert.ext, 32
  %O_cast.sroa.37.60.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.insert, %O_cast.sroa.37.60.insert.shift
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.124.vec.extract)
  %O_cast.sroa.37.62.insert.ext = zext i16 %167 to i64
  %O_cast.sroa.37.62.insert.shift = shl nuw i64 %O_cast.sroa.37.62.insert.ext, 48
  %O_cast.sroa.37.62.insert.insert = or disjoint i64 %O_cast.sroa.37.60.insert.insert, %O_cast.sroa.37.62.insert.shift
  %168 = lshr i32 %2, 2
  %mul386 = and i32 %168, 252
  %add383 = add nuw nsw i32 %add10, %mul386
  %169 = zext nneg i32 %add383 to i64
  %add.ptr389 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr389, align 8
  %170 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  %add.ptr389.1 = getelementptr inbounds i8, ptr addrspace(1) %170, i64 32
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr389.1, align 8
  %171 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  %add.ptr389.2 = getelementptr inbounds i8, ptr addrspace(1) %171, i64 64
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr389.2, align 8
  %172 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  %add.ptr389.3 = getelementptr inbounds i8, ptr addrspace(1) %172, i64 96
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr389.3, align 8
  %173 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  %add.ptr389.4 = getelementptr inbounds i8, ptr addrspace(1) %173, i64 128
  store i64 %O_cast.sroa.22.38.insert.insert, ptr addrspace(1) %add.ptr389.4, align 8
  %174 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  %add.ptr389.5 = getelementptr inbounds i8, ptr addrspace(1) %174, i64 160
  store i64 %O_cast.sroa.27.46.insert.insert, ptr addrspace(1) %add.ptr389.5, align 8
  %175 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  %add.ptr389.6 = getelementptr inbounds i8, ptr addrspace(1) %175, i64 192
  store i64 %O_cast.sroa.32.54.insert.insert, ptr addrspace(1) %add.ptr389.6, align 8
  %176 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169
  %add.ptr389.7 = getelementptr inbounds i8, ptr addrspace(1) %176, i64 224
  store i64 %O_cast.sroa.37.62.insert.insert, ptr addrspace(1) %add.ptr389.7, align 8
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


