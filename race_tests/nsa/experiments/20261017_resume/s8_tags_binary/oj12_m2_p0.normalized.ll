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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %EncodedIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Packed.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedK.coerce, ptr addrspace(1) noalias nocapture noundef readonly %RawIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 16
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul8 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul8
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %mul10 = shl nuw nsw i32 %2, 3
  %add11 = add nuw nsw i32 %add, %mul10
  %idx.ext = zext nneg i32 %add11 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext
  %and = shl nuw nsw i32 %2, 7
  %mul21 = and i32 %and, 896
  %shr = and i32 %2, 1016
  %add22 = add nuw nsw i32 %mul21, %shr
  %add25 = add nuw nsw i32 %add22, %add
  %idx.ext26 = zext nneg i32 %add25 to i64
  %add.ptr27 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %idx.ext26
  tail call void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr27, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !65
  %add.ptr37 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idx.ext
  %tile.sroa.0.0.copyload = load i16, ptr addrspace(4) %add.ptr37, align 16
  %tile.sroa.4.0.add.ptr37.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr37, i64 2
  %tile.sroa.4.0.copyload = load i16, ptr addrspace(4) %tile.sroa.4.0.add.ptr37.sroa_idx, align 2, !tbaa !30
  %tile.sroa.5.0.add.ptr37.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr37, i64 4
  %tile.sroa.5.0.copyload = load i16, ptr addrspace(4) %tile.sroa.5.0.add.ptr37.sroa_idx, align 4
  %tile.sroa.6.0.add.ptr37.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr37, i64 6
  %tile.sroa.6.0.copyload = load i16, ptr addrspace(4) %tile.sroa.6.0.add.ptr37.sroa_idx, align 2, !tbaa !30
  %tile.sroa.7.0.add.ptr37.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr37, i64 8
  %tile.sroa.7.0.copyload = load i16, ptr addrspace(4) %tile.sroa.7.0.add.ptr37.sroa_idx, align 8
  %tile.sroa.8.0.add.ptr37.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr37, i64 10
  %tile.sroa.8.0.copyload = load i16, ptr addrspace(4) %tile.sroa.8.0.add.ptr37.sroa_idx, align 2, !tbaa !30
  %tile.sroa.9.0.add.ptr37.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr37, i64 12
  %tile.sroa.9.0.copyload = load i16, ptr addrspace(4) %tile.sroa.9.0.add.ptr37.sroa_idx, align 4
  %tile.sroa.10.0.add.ptr37.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr37, i64 14
  %tile.sroa.10.0.copyload = load i16, ptr addrspace(4) %tile.sroa.10.0.add.ptr37.sroa_idx, align 2, !tbaa !30
  %mul48 = and i32 %and, 512
  %3 = shl nuw nsw i32 %2, 2
  %mul52 = and i32 %3, 3968
  %and55 = shl nuw nsw i32 %2, 6
  %mul56 = and i32 %and55, 64
  %4 = shl nuw nsw i32 %2, 1
  %mul63 = and i32 %4, 4
  %and66 = lshr i32 %2, 3
  %shr67 = and i32 %and66, 3
  %add64 = or disjoint i32 %add, %mul48
  %add49 = add nuw i32 %add64, %mul52
  %add53 = or disjoint i32 %add49, %mul56
  %add57 = or disjoint i32 %add53, %mul63
  %add59 = or disjoint i32 %add57, %shr67
  %idxprom69 = sext i32 %add59 to i64
  %arrayidx70 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69
  store i16 %tile.sroa.0.0.copyload, ptr addrspace(1) %arrayidx70, align 2, !tbaa !70
  %add68.1 = add i32 %add59, 8
  %idxprom69.1 = sext i32 %add68.1 to i64
  %arrayidx70.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69.1
  store i16 %tile.sroa.4.0.copyload, ptr addrspace(1) %arrayidx70.1, align 2, !tbaa !70
  %add68.2 = add i32 %add59, 16
  %idxprom69.2 = sext i32 %add68.2 to i64
  %arrayidx70.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69.2
  store i16 %tile.sroa.5.0.copyload, ptr addrspace(1) %arrayidx70.2, align 2, !tbaa !70
  %add68.3 = add i32 %add59, 24
  %idxprom69.3 = sext i32 %add68.3 to i64
  %arrayidx70.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69.3
  store i16 %tile.sroa.6.0.copyload, ptr addrspace(1) %arrayidx70.3, align 2, !tbaa !70
  %add68.4 = add i32 %add59, 32
  %idxprom69.4 = sext i32 %add68.4 to i64
  %arrayidx70.4 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69.4
  store i16 %tile.sroa.7.0.copyload, ptr addrspace(1) %arrayidx70.4, align 2, !tbaa !70
  %add68.5 = add i32 %add59, 40
  %idxprom69.5 = sext i32 %add68.5 to i64
  %arrayidx70.5 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69.5
  store i16 %tile.sroa.8.0.copyload, ptr addrspace(1) %arrayidx70.5, align 2, !tbaa !70
  %add68.6 = add i32 %add59, 48
  %idxprom69.6 = sext i32 %add68.6 to i64
  %arrayidx70.6 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69.6
  store i16 %tile.sroa.9.0.copyload, ptr addrspace(1) %arrayidx70.6, align 2, !tbaa !70
  %add68.7 = add i32 %add59, 56
  %idxprom69.7 = sext i32 %add68.7 to i64
  %arrayidx70.7 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom69.7
  store i16 %tile.sroa.10.0.copyload, ptr addrspace(1) %arrayidx70.7, align 2, !tbaa !70
  %mul72 = shl nsw i32 %0, 13
  %mul74 = shl nsw i32 %1, 7
  %add75 = add nuw nsw i32 %mul74, %2
  %add77 = add nuw nsw i32 %add75, %mul72
  %idxprom78 = zext nneg i32 %add77 to i64
  %arrayidx79 = getelementptr inbounds i32, ptr addrspace(1) %RawIndices.coerce, i64 %idxprom78
  %5 = load i32, ptr addrspace(1) %arrayidx79, align 4, !tbaa !30
  %cmp80 = icmp sgt i32 %5, -1
  br i1 %cmp80, label %land.lhs.true, label %land.end

land.lhs.true:                                    ; preds = %entry
  %cmp81 = icmp slt i32 %5, 64
  %cmp83 = icmp sle i32 %5, %1
  %spec.select = and i1 %cmp81, %cmp83
  br label %land.end

land.end:                                         ; preds = %land.lhs.true, %entry
  %6 = phi i1 [ false, %entry ], [ %spec.select, %land.lhs.true ]
  %cmp84 = icmp slt i32 %5, 64
  %add87 = add nuw nsw i32 %2, 8
  %shr88 = lshr i32 %add87, 7
  %add90 = add nuw nsw i32 %shr88, %1
  %cmp91 = icmp slt i32 %5, %add90
  %spec.select182 = select i1 %cmp84, i1 %cmp91, i1 false
  %condval_1.0 = select i1 %spec.select182, i32 128, i32 64
  %and96 = and i32 %5, 63
  %or = or disjoint i32 %condval_1.0, %and96
  %7 = zext nneg i32 %or to i64
  %condval.0 = select i1 %6, i64 %7, i64 0
  %mul101 = and i32 %mul10, 56
  %conv102 = zext nneg i32 %mul101 to i64
  %shl = shl nuw i64 %condval.0, %conv102
  %var.addr.sroa.0.0.extract.trunc.i = trunc i64 %shl to i32
  %var.addr.sroa.2.0.extract.shift.i = lshr i64 %shl, 32
  %var.addr.sroa.2.0.extract.trunc.i = trunc nuw i64 %var.addr.sroa.2.0.extract.shift.i to i32
  %8 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #8
  %9 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %8) #8
  %xor.i.i.i = xor i32 %9, 1
  %10 = and i32 %9, -64
  %and.i.i.i = add nsw i32 %10, 64
  %cmp.not.i.i.i = icmp slt i32 %xor.i.i.i, %and.i.i.i
  %cond.i.i.i = select i1 %cmp.not.i.i.i, i32 %xor.i.i.i, i32 %9
  %shl.i.i.i = shl i32 %cond.i.i.i, 2
  %11 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.i, i32 %var.addr.sroa.0.0.extract.trunc.i)
  %12 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #8
  %13 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %12) #8
  %xor.i.i13.i = xor i32 %13, 1
  %14 = and i32 %13, -64
  %and.i.i14.i = add nsw i32 %14, 64
  %cmp.not.i.i15.i = icmp slt i32 %xor.i.i13.i, %and.i.i14.i
  %cond.i.i16.i = select i1 %cmp.not.i.i15.i, i32 %xor.i.i13.i, i32 %13
  %shl.i.i17.i = shl i32 %cond.i.i16.i, 2
  %15 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i17.i, i32 %var.addr.sroa.2.0.extract.trunc.i)
  %conv.i = zext i32 %15 to i64
  %shl.i = shl nuw i64 %conv.i, 32
  %conv7.i = zext i32 %11 to i64
  %or.i = or disjoint i64 %shl.i, %conv7.i
  %or107 = or i64 %or.i, %shl
  %var.addr.sroa.0.0.extract.trunc.i148 = trunc i64 %or107 to i32
  %var.addr.sroa.2.0.extract.shift.i149 = lshr i64 %or107, 32
  %var.addr.sroa.2.0.extract.trunc.i150 = trunc nuw i64 %var.addr.sroa.2.0.extract.shift.i149 to i32
  %16 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #8
  %17 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %16) #8
  %xor.i.i.i151 = xor i32 %17, 2
  %18 = and i32 %17, -64
  %and.i.i.i152 = add nsw i32 %18, 64
  %cmp.not.i.i.i153 = icmp slt i32 %xor.i.i.i151, %and.i.i.i152
  %cond.i.i.i154 = select i1 %cmp.not.i.i.i153, i32 %xor.i.i.i151, i32 %17
  %shl.i.i.i155 = shl i32 %cond.i.i.i154, 2
  %19 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.i155, i32 %var.addr.sroa.0.0.extract.trunc.i148)
  %20 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #8
  %21 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %20) #8
  %xor.i.i13.i156 = xor i32 %21, 2
  %22 = and i32 %21, -64
  %and.i.i14.i157 = add nsw i32 %22, 64
  %cmp.not.i.i15.i158 = icmp slt i32 %xor.i.i13.i156, %and.i.i14.i157
  %cond.i.i16.i159 = select i1 %cmp.not.i.i15.i158, i32 %xor.i.i13.i156, i32 %21
  %shl.i.i17.i160 = shl i32 %cond.i.i16.i159, 2
  %23 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i17.i160, i32 %var.addr.sroa.2.0.extract.trunc.i150)
  %conv.i161 = zext i32 %23 to i64
  %shl.i162 = shl nuw i64 %conv.i161, 32
  %conv7.i163 = zext i32 %19 to i64
  %or.i164 = or disjoint i64 %shl.i162, %conv7.i163
  %or112 = or i64 %or.i164, %or107
  %var.addr.sroa.0.0.extract.trunc.i165 = trunc i64 %or112 to i32
  %var.addr.sroa.2.0.extract.shift.i166 = lshr i64 %or112, 32
  %var.addr.sroa.2.0.extract.trunc.i167 = trunc nuw i64 %var.addr.sroa.2.0.extract.shift.i166 to i32
  %24 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #8
  %25 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %24) #8
  %xor.i.i.i168 = xor i32 %25, 4
  %26 = and i32 %25, -64
  %and.i.i.i169 = add nsw i32 %26, 64
  %cmp.not.i.i.i170 = icmp slt i32 %xor.i.i.i168, %and.i.i.i169
  %cond.i.i.i171 = select i1 %cmp.not.i.i.i170, i32 %xor.i.i.i168, i32 %25
  %shl.i.i.i172 = shl i32 %cond.i.i.i171, 2
  %27 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.i172, i32 %var.addr.sroa.0.0.extract.trunc.i165)
  %28 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #8
  %29 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %28) #8
  %xor.i.i13.i173 = xor i32 %29, 4
  %30 = and i32 %29, -64
  %and.i.i14.i174 = add nsw i32 %30, 64
  %cmp.not.i.i15.i175 = icmp slt i32 %xor.i.i13.i173, %and.i.i14.i174
  %cond.i.i16.i176 = select i1 %cmp.not.i.i15.i175, i32 %xor.i.i13.i173, i32 %29
  %shl.i.i17.i177 = shl i32 %cond.i.i16.i176, 2
  %31 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i17.i177, i32 %var.addr.sroa.2.0.extract.trunc.i167)
  %rem = and i32 %2, 7
  %cmp120 = icmp eq i32 %rem, 0
  br i1 %cmp120, label %if.then121, label %if.end133

if.then121:                                       ; preds = %land.end
  %mul124 = shl nsw i32 %0, 10
  %mul126 = shl nsw i32 %1, 4
  %add127 = add nuw nsw i32 %mul124, %mul126
  %add130 = add nuw nsw i32 %add127, %and66
  %idxprom131 = zext nneg i32 %add130 to i64
  %arrayidx132 = getelementptr inbounds i64, ptr addrspace(1) %EncodedIndices.coerce, i64 %idxprom131
  %conv.i178 = zext i32 %31 to i64
  %shl.i179 = shl nuw i64 %conv.i178, 32
  %conv7.i180 = zext i32 %27 to i64
  %or.i181 = or disjoint i64 %shl.i179, %conv7.i180
  %or117 = or i64 %or.i181, %or112
  store i64 %or117, ptr addrspace(1) %arrayidx132, align 8, !tbaa !17
  br label %if.end133

if.end133:                                        ; preds = %if.then121, %land.end
  ret void
}

declare i32 @llvm.mxc.block.id.x() #4

declare i32 @llvm.mxc.block.id.y() #4

declare i32 @llvm.mxc.block.id.z() #4

declare i32 @llvm.mxc.thread.id.x() #4

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #5

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

declare i1 @llvm.mxc.is.private(ptr nocapture) #4

declare void @llvm.mxc.sleep(i32 immarg) #6

declare void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #7

attributes #0 = { mustprogress noreturn nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="128" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nounwind speculatable willreturn memory(none) }
attributes #5 = { convergent nounwind willreturn memory(none) }
attributes #6 = { nounwind willreturn }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #8 = { nomerge }


