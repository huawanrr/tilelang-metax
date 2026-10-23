target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %1, 6
  %mul7 = and i32 %and, 960
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp31 = icmp ult i32 %5, 16
  br i1 %cmp31, label %for.cond32.preheader, label %if.end201

for.cond32.preheader:                             ; preds = %entry
  %mul37 = shl nuw nsw i32 %5, 10
  %add41 = add nuw nsw i32 %mul11, %mul7
  %add43 = add nuw nsw i32 %add41, %mul37
  %6 = zext nneg i32 %add43 to i64
  %add.ptr49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49, align 16
  %k.sroa.4.0.add.ptr49.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr49.sroa_idx, align 8
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %add.ptr49.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 64
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.1, align 16
  %k.sroa.7.16.add.ptr49.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 72
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.add.ptr49.1.sroa_idx, align 8
  %8 = shl nuw nsw i32 %1, 4
  %mul65 = and i32 %8, 16128
  %add66 = add nuw nsw i32 %mul37, %mul65
  %and74 = and i32 %1, 15
  %add75 = or disjoint i32 %add66, %and74
  %idxprom76 = zext nneg i32 %add75 to i64
  %arrayidx77 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76
  %9 = load half, ptr addrspace(4) %arrayidx77, align 2, !tbaa !62
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %9, i64 0
  %add69.1 = or disjoint i32 %add66, %and74
  %add75.1 = or disjoint i32 %add69.1, 64
  %idxprom76.1 = zext nneg i32 %add75.1 to i64
  %arrayidx77.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.1
  %10 = load half, ptr addrspace(4) %arrayidx77.1, align 2, !tbaa !62
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %10, i64 1
  %add69.2 = or disjoint i32 %add66, %and74
  %add75.2 = or disjoint i32 %add69.2, 128
  %idxprom76.2 = zext nneg i32 %add75.2 to i64
  %arrayidx77.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.2
  %11 = load half, ptr addrspace(4) %arrayidx77.2, align 2, !tbaa !62
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %11, i64 2
  %add69.3 = or disjoint i32 %add66, %and74
  %add75.3 = or disjoint i32 %add69.3, 192
  %idxprom76.3 = zext nneg i32 %add75.3 to i64
  %arrayidx77.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.3
  %12 = load half, ptr addrspace(4) %arrayidx77.3, align 2, !tbaa !62
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %12, i64 3
  %add72.4 = or disjoint i32 %add66, %and74
  %add75.4 = or disjoint i32 %add72.4, 16
  %idxprom76.4 = zext nneg i32 %add75.4 to i64
  %arrayidx77.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.4
  %13 = load half, ptr addrspace(4) %arrayidx77.4, align 2, !tbaa !62
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %13, i64 0
  %add72.5 = or disjoint i32 %add66, %and74
  %add75.5 = or disjoint i32 %add72.5, 80
  %idxprom76.5 = zext nneg i32 %add75.5 to i64
  %arrayidx77.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.5
  %14 = load half, ptr addrspace(4) %arrayidx77.5, align 2, !tbaa !62
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %14, i64 1
  %add72.6 = or disjoint i32 %add66, %and74
  %add75.6 = or disjoint i32 %add72.6, 144
  %idxprom76.6 = zext nneg i32 %add75.6 to i64
  %arrayidx77.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.6
  %15 = load half, ptr addrspace(4) %arrayidx77.6, align 2, !tbaa !62
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %15, i64 2
  %add72.7 = or disjoint i32 %add66, %and74
  %add75.7 = or disjoint i32 %add72.7, 208
  %idxprom76.7 = zext nneg i32 %add75.7 to i64
  %arrayidx77.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.7
  %16 = load half, ptr addrspace(4) %arrayidx77.7, align 2, !tbaa !62
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %16, i64 3
  %add72.8 = or disjoint i32 %add66, %and74
  %add75.8 = or disjoint i32 %add72.8, 32
  %idxprom76.8 = zext nneg i32 %add75.8 to i64
  %arrayidx77.8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.8
  %17 = load half, ptr addrspace(4) %arrayidx77.8, align 2, !tbaa !62
  %v.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %17, i64 0
  %add72.9 = or disjoint i32 %add66, %and74
  %add75.9 = or disjoint i32 %add72.9, 96
  %idxprom76.9 = zext nneg i32 %add75.9 to i64
  %arrayidx77.9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.9
  %18 = load half, ptr addrspace(4) %arrayidx77.9, align 2, !tbaa !62
  %v.sroa.12.18.vec.insert = insertelement <4 x half> %v.sroa.12.16.vec.insert, half %18, i64 1
  %add72.10 = or disjoint i32 %add66, %and74
  %add75.10 = or disjoint i32 %add72.10, 160
  %idxprom76.10 = zext nneg i32 %add75.10 to i64
  %arrayidx77.10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.10
  %19 = load half, ptr addrspace(4) %arrayidx77.10, align 2, !tbaa !62
  %v.sroa.12.20.vec.insert = insertelement <4 x half> %v.sroa.12.18.vec.insert, half %19, i64 2
  %add72.11 = or disjoint i32 %add66, %and74
  %add75.11 = or disjoint i32 %add72.11, 224
  %idxprom76.11 = zext nneg i32 %add75.11 to i64
  %arrayidx77.11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.11
  %20 = load half, ptr addrspace(4) %arrayidx77.11, align 2, !tbaa !62
  %v.sroa.12.22.vec.insert = insertelement <4 x half> %v.sroa.12.20.vec.insert, half %20, i64 3
  %add72.12 = or disjoint i32 %add66, %and74
  %add75.12 = or disjoint i32 %add72.12, 48
  %idxprom76.12 = zext nneg i32 %add75.12 to i64
  %arrayidx77.12 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.12
  %21 = load half, ptr addrspace(4) %arrayidx77.12, align 2, !tbaa !62
  %v.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %21, i64 0
  %add72.13 = or disjoint i32 %add66, %and74
  %add75.13 = or disjoint i32 %add72.13, 112
  %idxprom76.13 = zext nneg i32 %add75.13 to i64
  %arrayidx77.13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.13
  %22 = load half, ptr addrspace(4) %arrayidx77.13, align 2, !tbaa !62
  %v.sroa.17.26.vec.insert = insertelement <4 x half> %v.sroa.17.24.vec.insert, half %22, i64 1
  %add72.14 = or disjoint i32 %add66, %and74
  %add75.14 = or disjoint i32 %add72.14, 176
  %idxprom76.14 = zext nneg i32 %add75.14 to i64
  %arrayidx77.14 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.14
  %23 = load half, ptr addrspace(4) %arrayidx77.14, align 2, !tbaa !62
  %v.sroa.17.28.vec.insert = insertelement <4 x half> %v.sroa.17.26.vec.insert, half %23, i64 2
  %add72.15 = or disjoint i32 %add66, %and74
  %add75.15 = or disjoint i32 %add72.15, 240
  %idxprom76.15 = zext nneg i32 %add75.15 to i64
  %arrayidx77.15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom76.15
  %24 = load half, ptr addrspace(4) %arrayidx77.15, align 2, !tbaa !62
  %v.sroa.17.30.vec.insert = insertelement <4 x half> %v.sroa.17.28.vec.insert, half %24, i64 3
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !64
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %25), !call_argsrelate !64
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %26), !call_argsrelate !64
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %27), !call_argsrelate !64
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0
  %mul122 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %29 = tail call contract noundef float @llvm.minnum.f32(float %mul122, float 0x4024CB5EC0000000)
  %30 = tail call contract noundef float @llvm.exp.f32(float %29)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1
  %mul122.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul122.1, float 0x4024CB5EC0000000)
  %32 = tail call contract noundef float @llvm.exp.f32(float %31)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2
  %mul122.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul122.2, float 0x4024CB5EC0000000)
  %34 = tail call contract noundef float @llvm.exp.f32(float %33)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3
  %mul122.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul122.3, float 0x4024CB5EC0000000)
  %36 = tail call contract noundef float @llvm.exp.f32(float %35)
  %add138.1 = fadd contract float %30, %32
  %add138.2 = fadd contract float %add138.1, %34
  %add138.3 = fadd contract float %add138.2, %36
  %37 = bitcast float %add138.3 to i32
  %38 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %39 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %38) #10
  %xor.i.i = xor i32 %39, 32
  %40 = and i32 %39, -64
  %and.i.i = add nsw i32 %40, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %39
  %shl.i.i = shl i32 %cond.i.i, 2
  %41 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %37)
  %42 = bitcast i32 %41 to float
  %add146 = fadd contract float %add138.3, %42
  %43 = bitcast float %add146 to i32
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #10
  %xor.i.i308 = xor i32 %45, 16
  %46 = and i32 %45, -64
  %and.i.i309 = add nsw i32 %46, 64
  %cmp.not.i.i310 = icmp slt i32 %xor.i.i308, %and.i.i309
  %cond.i.i311 = select i1 %cmp.not.i.i310, i32 %xor.i.i308, i32 %45
  %shl.i.i312 = shl i32 %cond.i.i311, 2
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i312, i32 %43)
  %48 = bitcast i32 %47 to float
  %add151 = fadd contract float %add146, %48
  %cmp154 = fcmp contract ogt float %add151, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add151
  %condval.0 = select i1 %cmp154, float %div, float 0.000000e+00
  %mul165 = fmul contract float %condval.0, %30
  %mul165.1 = fmul contract float %condval.0, %32
  %mul165.2 = fmul contract float %condval.0, %34
  %mul165.3 = fmul contract float %condval.0, %36
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul165)
  %50 = insertelement <4 x i16> poison, i16 %49, i64 0
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul165.1)
  %52 = insertelement <4 x i16> %50, i16 %51, i64 1
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul165.2)
  %54 = insertelement <4 x i16> %52, i16 %53, i64 2
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul165.3)
  %56 = insertelement <4 x i16> %54, i16 %55, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %56 to <4 x half>
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end201

if.end201:                                        ; preds = %for.cond32.preheader, %entry
  %out.sroa.0.0 = phi <4 x float> [ %57, %for.cond32.preheader ], [ zeroinitializer, %entry ]
  %out.sroa.12.0 = phi <4 x float> [ %58, %for.cond32.preheader ], [ zeroinitializer, %entry ]
  %out.sroa.22.0 = phi <4 x float> [ %59, %for.cond32.preheader ], [ zeroinitializer, %entry ]
  %out.sroa.32.0 = phi <4 x float> [ %60, %for.cond32.preheader ], [ zeroinitializer, %entry ]
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %result.sroa.0.0.insert.ext = zext i16 %61 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %result.sroa.0.2.insert.ext = zext i16 %62 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %result.sroa.0.4.insert.ext = zext i16 %63 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %result.sroa.0.6.insert.ext = zext i16 %64 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %out.sroa.12.16.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 0
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.16.vec.extract)
  %result.sroa.7.8.insert.ext = zext i16 %65 to i64
  %out.sroa.12.20.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 1
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.20.vec.extract)
  %result.sroa.7.10.insert.ext = zext i16 %66 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %out.sroa.12.24.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 2
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.24.vec.extract)
  %result.sroa.7.12.insert.ext = zext i16 %67 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %out.sroa.12.28.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 3
  %68 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.28.vec.extract)
  %result.sroa.7.14.insert.ext = zext i16 %68 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %out.sroa.22.32.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 0
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.32.vec.extract)
  %result.sroa.12.16.insert.ext = zext i16 %69 to i64
  %out.sroa.22.36.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 1
  %70 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.36.vec.extract)
  %result.sroa.12.18.insert.ext = zext i16 %70 to i64
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext
  %out.sroa.22.40.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 2
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.40.vec.extract)
  %result.sroa.12.20.insert.ext = zext i16 %71 to i64
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift
  %out.sroa.22.44.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 3
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.44.vec.extract)
  %result.sroa.12.22.insert.ext = zext i16 %72 to i64
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift
  %out.sroa.32.48.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 0
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.48.vec.extract)
  %result.sroa.17.24.insert.ext = zext i16 %73 to i64
  %out.sroa.32.52.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 1
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.52.vec.extract)
  %result.sroa.17.26.insert.ext = zext i16 %74 to i64
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext
  %out.sroa.32.56.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 2
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.56.vec.extract)
  %result.sroa.17.28.insert.ext = zext i16 %75 to i64
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift
  %out.sroa.32.60.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 3
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.60.vec.extract)
  %result.sroa.17.30.insert.ext = zext i16 %76 to i64
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift
  %77 = lshr i32 %1, 2
  %mul243 = and i32 %77, 252
  %add240 = add nuw nsw i32 %add, %mul243
  %78 = zext nneg i32 %add240 to i64
  %add.ptr246 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr246, align 8
  %79 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78
  %add.ptr246.1 = getelementptr inbounds i8, ptr addrspace(1) %79, i64 32
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr246.1, align 8
  %80 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78
  %add.ptr246.2 = getelementptr inbounds i8, ptr addrspace(1) %80, i64 64
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr246.2, align 8
  %81 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78
  %add.ptr246.3 = getelementptr inbounds i8, ptr addrspace(1) %81, i64 96
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr246.3, align 8
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


