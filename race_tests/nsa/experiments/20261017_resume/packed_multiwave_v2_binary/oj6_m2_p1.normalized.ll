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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul6 = shl nsw i32 %1, 12
  %add = add nuw nsw i32 %mul, %mul6
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %3 = shl nuw nsw i32 %2, 5
  %mul8 = and i32 %3, 30720
  %add9 = add nuw nsw i32 %add, %mul8
  %and = shl nuw nsw i32 %2, 3
  %mul13 = and i32 %and, 504
  %add11 = or disjoint i32 %add9, %mul13
  %4 = zext nneg i32 %add11 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %5 = or disjoint i64 %4, 512
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %6 = or disjoint i64 %4, 1024
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %7 = or disjoint i64 %4, 1536
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %7
  %mul19 = shl nsw i32 %0, 10
  %mul21 = shl nuw nsw i32 %1, 1
  %shr24 = lshr i32 %2, 6
  %add22 = add nuw nsw i32 %shr24, %mul21
  %add25 = add nuw nsw i32 %add22, %mul19
  %idxprom = zext nneg i32 %add25 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %8 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp26 = icmp sgt i32 %8, -1
  br i1 %cmp26, label %land.lhs.true, label %if.else371

land.lhs.true:                                    ; preds = %entry
  %cmp27 = icmp slt i32 %8, 32
  %mul29 = shl nsw i32 %8, 4
  %cmp30 = icmp sge i32 %1, %mul29
  %or.cond = select i1 %cmp27, i1 %cmp30, i1 false
  br i1 %or.cond, label %for.cond31.preheader, label %if.else371

for.cond31.preheader:                             ; preds = %land.lhs.true
  %conv = zext nneg i32 %0 to i64
  %mul37 = shl nuw nsw i64 %conv, 18
  %conv38 = zext nneg i32 %8 to i64
  %mul39 = shl nuw nsw i64 %conv38, 13
  %add40 = add nuw nsw i64 %mul39, %mul37
  %mul47 = zext nneg i32 %mul13 to i64
  %add48 = or disjoint i64 %add40, %mul47
  %add.ptr49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49, align 16
  %k.sroa.4.0.add.ptr49.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr49.sroa_idx, align 8
  %add43.1 = or disjoint i64 %add40, %mul47
  %add48.1 = or disjoint i64 %add43.1, 512
  %add.ptr49.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.1
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.1, align 16
  %k.sroa.7.16.add.ptr49.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.add.ptr49.1.sroa_idx, align 8
  %add43.2 = or disjoint i64 %add40, %mul47
  %add48.2 = or disjoint i64 %add43.2, 1024
  %add.ptr49.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.2
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.2, align 16
  %k.sroa.10.32.add.ptr49.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.add.ptr49.2.sroa_idx, align 8
  %add43.3 = or disjoint i64 %add40, %mul47
  %add48.3 = or disjoint i64 %add43.3, 1536
  %add.ptr49.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.3
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.3, align 16
  %k.sroa.13.48.add.ptr49.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.add.ptr49.3.sroa_idx, align 8
  %add43.4 = or disjoint i64 %add40, %mul47
  %add48.4 = or disjoint i64 %add43.4, 2048
  %add.ptr49.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.4
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.4, align 16
  %k.sroa.16.64.add.ptr49.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.add.ptr49.4.sroa_idx, align 8
  %add43.5 = or disjoint i64 %add40, %mul47
  %add48.5 = or disjoint i64 %add43.5, 2560
  %add.ptr49.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.5
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.5, align 16
  %k.sroa.19.80.add.ptr49.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.add.ptr49.5.sroa_idx, align 8
  %add43.6 = or disjoint i64 %add40, %mul47
  %add48.6 = or disjoint i64 %add43.6, 3072
  %add.ptr49.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.6
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.6, align 16
  %k.sroa.22.96.add.ptr49.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.add.ptr49.6.sroa_idx, align 8
  %add43.7 = or disjoint i64 %add40, %mul47
  %add48.7 = or disjoint i64 %add43.7, 3584
  %add.ptr49.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add48.7
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr49.7, align 16
  %k.sroa.25.112.add.ptr49.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.add.ptr49.7.sroa_idx, align 8
  %mul74 = and i32 %and, 384
  %and77 = and i32 %2, 15
  %and80 = lshr i32 %2, 4
  %shr81 = and i32 %and80, 3
  %add75 = or disjoint i32 %mul8, %mul74
  %xor = xor i32 %shr81, %and77
  %.idx = shl nuw nsw i32 %xor, 4
  %9 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx
  %add.ptr86 = getelementptr inbounds %struct.__half, ptr addrspace(3) %9, i32 %add75
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !63
  %add70.1 = or disjoint i32 %mul8, %mul74
  %add75.1 = or disjoint i32 %add70.1, 512
  %add82.1 = or disjoint i32 %shr81, 4
  %xor.1 = xor i32 %add82.1, %and77
  %.idx.1 = shl nuw nsw i32 %xor.1, 4
  %10 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.1
  %add.ptr86.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %10, i32 %add75.1
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !63
  %add70.2 = or disjoint i32 %mul8, %mul74
  %add75.2 = or disjoint i32 %add70.2, 1024
  %add82.2 = or disjoint i32 %shr81, 8
  %xor.2 = xor i32 %add82.2, %and77
  %.idx.2 = shl nuw nsw i32 %xor.2, 4
  %11 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.2
  %add.ptr86.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %11, i32 %add75.2
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !call_argsrelate !63
  %add70.3 = or disjoint i32 %mul8, %mul74
  %add75.3 = or disjoint i32 %add70.3, 1536
  %add82.3 = or disjoint i32 %shr81, 12
  %xor.3 = xor i32 %add82.3, %and77
  %.idx.3 = shl nuw nsw i32 %xor.3, 4
  %12 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.3
  %add.ptr86.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %12, i32 %add75.3
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr86.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !call_argsrelate !63
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and99 = shl nuw nsw i32 %2, 7
  %mul100 = and i32 %and99, 1920
  %add101 = or disjoint i32 %mul8, %mul100
  %add.ptr113 = getelementptr inbounds %struct.__half, ptr addrspace(3) %9, i32 %add101
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113, align 16
  %q.sroa.4.0.add.ptr113.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113, i32 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr113.sroa_idx, align 8
  %add.ptr113.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %10, i32 %add101
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113.1, align 16
  %q.sroa.7.16.add.ptr113.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.1, i32 8
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr113.1.sroa_idx, align 8
  %add.ptr113.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %11, i32 %add101
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113.2, align 16
  %q.sroa.10.32.add.ptr113.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.2, i32 8
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr113.2.sroa_idx, align 8
  %add.ptr113.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %12, i32 %add101
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr113.3, align 16
  %q.sroa.13.48.add.ptr113.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.3, i32 8
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr113.3.sroa_idx, align 8
  %mul128 = shl nsw i32 %8, 5
  %13 = lshr i32 %2, 2
  %mul135 = and i32 %13, 12
  %add136 = or disjoint i32 %mul128, %mul135
  %cmp144.not = icmp sgt i32 %add136, %add22
  %spec.select = select i1 %cmp144.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp144.not.1.not = icmp slt i32 %add136, %add22
  %spec.select.1 = select i1 %cmp144.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add138.2 = or disjoint i32 %add136, 2
  %cmp144.not.2 = icmp sgt i32 %add138.2, %add22
  %spec.select.2 = select i1 %cmp144.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add138.3 = or disjoint i32 %add136, 3
  %cmp144.not.3 = icmp sgt i32 %add138.3, %add22
  %spec.select.3 = select i1 %cmp144.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add131.4 = or disjoint i32 %mul128, %mul135
  %add136.4 = or disjoint i32 %add131.4, 16
  %cmp144.not.4 = icmp sgt i32 %add136.4, %add22
  %spec.select.4 = select i1 %cmp144.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add138.5 = or disjoint i32 %add131.4, 17
  %cmp144.not.5 = icmp sgt i32 %add138.5, %add22
  %spec.select.5 = select i1 %cmp144.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1
  %add138.6 = or disjoint i32 %add131.4, 18
  %cmp144.not.6 = icmp sgt i32 %add138.6, %add22
  %spec.select.6 = select i1 %cmp144.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2
  %add138.7 = or disjoint i32 %add131.4, 19
  %cmp144.not.7 = icmp sgt i32 %add138.7, %add22
  %spec.select.7 = select i1 %cmp144.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !81
  %15 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !81
  %16 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %14), !call_argsrelate !81
  %17 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %15), !call_argsrelate !81
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %16), !call_argsrelate !81
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %17), !call_argsrelate !81
  %20 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %18), !call_argsrelate !81
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %19), !call_argsrelate !81
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %20), !call_argsrelate !81
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %21), !call_argsrelate !81
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %22), !call_argsrelate !81
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %23), !call_argsrelate !81
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %24), !call_argsrelate !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %25), !call_argsrelate !81
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %26), !call_argsrelate !81
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %27), !call_argsrelate !81
  %add.ptr211 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8192
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211, align 16
  %v.sroa.4.0.add.ptr211.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8200
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0.add.ptr211.sroa_idx, align 8
  %add.ptr211.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8192
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.1, align 16
  %v.sroa.7.16.add.ptr211.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8200
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.add.ptr211.1.sroa_idx, align 8
  %add.ptr211.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8192
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.2, align 16
  %v.sroa.10.32.add.ptr211.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8200
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.add.ptr211.2.sroa_idx, align 8
  %add.ptr211.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8192
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.3, align 16
  %v.sroa.13.48.add.ptr211.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8200
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.add.ptr211.3.sroa_idx, align 8
  %add.ptr211.4 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8192
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.4, align 16
  %v.sroa.16.64.add.ptr211.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8200
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.add.ptr211.4.sroa_idx, align 8
  %add.ptr211.5 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8192
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.5, align 16
  %v.sroa.19.80.add.ptr211.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8200
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.add.ptr211.5.sroa_idx, align 8
  %add.ptr211.6 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8192
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.6, align 16
  %v.sroa.22.96.add.ptr211.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8200
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.add.ptr211.6.sroa_idx, align 8
  %add.ptr211.7 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8192
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr211.7, align 16
  %v.sroa.25.112.add.ptr211.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8200
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.add.ptr211.7.sroa_idx, align 8
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0
  %mul225 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul225, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %30, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %30, %cond.i.i
  %31 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %31
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1
  %mul225.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul225.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %32, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %32, %cond.i.i.1
  %33 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %33
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2
  %mul225.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul225.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %34, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %34, %cond.i.i.2
  %35 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %35
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3
  %mul225.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul225.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %36, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %36, %cond.i.i.3
  %37 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %37
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %29, i64 0
  %mul225.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul225.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %38, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i.4 = fadd contract float %38, %cond.i.i.4
  %39 = tail call contract float @llvm.exp2.f32(float %add.i.i.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %39
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %29, i64 1
  %mul225.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul225.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %40, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i.5 = fadd contract float %40, %cond.i.i.5
  %41 = tail call contract float @llvm.exp2.f32(float %add.i.i.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %41
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %29, i64 2
  %mul225.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul225.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %42, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i.6 = fadd contract float %42, %cond.i.i.6
  %43 = tail call contract float @llvm.exp2.f32(float %add.i.i.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %43
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %29, i64 3
  %mul225.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul225.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %44, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i.7 = fadd contract float %44, %cond.i.i.7
  %45 = tail call contract float @llvm.exp2.f32(float %add.i.i.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %45
  %add247 = fadd contract float %mul.i.i, 0.000000e+00
  %add247.1 = fadd contract float %add247, %mul.i.i.4
  %add247.1640 = fadd contract float %add247.1, %mul.i.i.1
  %add247.1.1 = fadd contract float %add247.1640, %mul.i.i.5
  %add247.2 = fadd contract float %add247.1.1, %mul.i.i.2
  %add247.1.2 = fadd contract float %add247.2, %mul.i.i.6
  %add247.3 = fadd contract float %add247.1.2, %mul.i.i.3
  %add247.1.3 = fadd contract float %add247.3, %mul.i.i.7
  %46 = bitcast float %add247.1.3 to i32
  %47 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %48 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %47) #11
  %xor.i.i = xor i32 %48, 32
  %49 = and i32 %48, -64
  %and.i.i = add nsw i32 %49, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i584 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %48
  %shl.i.i = shl i32 %cond.i.i584, 2
  %50 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %46)
  %51 = bitcast i32 %50 to float
  %add258 = fadd contract float %add247.1.3, %51
  %52 = bitcast float %add258 to i32
  %53 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %54 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %53) #11
  %xor.i.i585 = xor i32 %54, 16
  %55 = and i32 %54, -64
  %and.i.i586 = add nsw i32 %55, 64
  %cmp.not.i.i587 = icmp slt i32 %xor.i.i585, %and.i.i586
  %cond.i.i588 = select i1 %cmp.not.i.i587, i32 %xor.i.i585, i32 %54
  %shl.i.i589 = shl i32 %cond.i.i588, 2
  %56 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i589, i32 %52)
  %57 = bitcast i32 %56 to float
  %add263 = fadd contract float %add258, %57
  %cmp266 = fcmp contract ogt float %add263, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add263
  %condval_1.0 = select i1 %cmp266, float %div, float 0.000000e+00
  %mul279 = fmul contract float %condval_1.0, %mul.i.i
  %mul279.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul279.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul279.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %mul279.4 = fmul contract float %condval_1.0, %mul.i.i.4
  %mul279.5 = fmul contract float %condval_1.0, %mul.i.i.5
  %mul279.6 = fmul contract float %condval_1.0, %mul.i.i.6
  %mul279.7 = fmul contract float %condval_1.0, %mul.i.i.7
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279)
  %59 = insertelement <4 x i16> poison, i16 %58, i64 0
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.1)
  %61 = insertelement <4 x i16> %59, i16 %60, i64 1
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.2)
  %63 = insertelement <4 x i16> %61, i16 %62, i64 2
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.3)
  %65 = insertelement <4 x i16> %63, i16 %64, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %65 to <4 x half>
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.4)
  %67 = insertelement <4 x i16> poison, i16 %66, i64 0
  %68 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.5)
  %69 = insertelement <4 x i16> %67, i16 %68, i64 1
  %70 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.6)
  %71 = insertelement <4 x i16> %69, i16 %70, i64 2
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.7)
  %73 = insertelement <4 x i16> %71, i16 %72, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %73 to <4 x half>
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !81
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %74), !call_argsrelate !81
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %75), !call_argsrelate !81
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %76), !call_argsrelate !81
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %77), !call_argsrelate !81
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %78), !call_argsrelate !81
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %79), !call_argsrelate !81
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %80), !call_argsrelate !81
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %81), !call_argsrelate !81
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %82, i64 0
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %90 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %82, i64 1
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %91 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %82, i64 2
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %92 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert660 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %82, i64 3
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %93 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert660, %output_reg.sroa.0.6.insert.shift
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %83, i64 0
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.9.8.insert.ext = zext i16 %94 to i64
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %83, i64 1
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.9.10.insert.ext = zext i16 %95 to i64
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %83, i64 2
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.9.12.insert.ext = zext i16 %96 to i64
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32
  %output_reg.sroa.9.12.insert.insert666 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %83, i64 3
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.9.14.insert.ext = zext i16 %97 to i64
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert666, %output_reg.sroa.9.14.insert.shift
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %84, i64 0
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.16.16.insert.ext = zext i16 %98 to i64
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %84, i64 1
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.16.18.insert.ext = zext i16 %99 to i64
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %84, i64 2
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.16.20.insert.ext = zext i16 %100 to i64
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32
  %output_reg.sroa.16.20.insert.insert672 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %84, i64 3
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.16.22.insert.ext = zext i16 %101 to i64
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert672, %output_reg.sroa.16.22.insert.shift
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %85, i64 0
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.23.24.insert.ext = zext i16 %102 to i64
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %85, i64 1
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.23.26.insert.ext = zext i16 %103 to i64
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %85, i64 2
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.23.28.insert.ext = zext i16 %104 to i64
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32
  %output_reg.sroa.23.28.insert.insert678 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %85, i64 3
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.23.30.insert.ext = zext i16 %105 to i64
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert678, %output_reg.sroa.23.30.insert.shift
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %86, i64 0
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.30.32.insert.ext = zext i16 %106 to i64
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %86, i64 1
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.30.34.insert.ext = zext i16 %107 to i64
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %86, i64 2
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.30.36.insert.ext = zext i16 %108 to i64
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32
  %output_reg.sroa.30.36.insert.insert684 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %86, i64 3
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.30.38.insert.ext = zext i16 %109 to i64
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert684, %output_reg.sroa.30.38.insert.shift
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %87, i64 0
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.37.40.insert.ext = zext i16 %110 to i64
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %87, i64 1
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.37.42.insert.ext = zext i16 %111 to i64
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %87, i64 2
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.37.44.insert.ext = zext i16 %112 to i64
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32
  %output_reg.sroa.37.44.insert.insert690 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %87, i64 3
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.37.46.insert.ext = zext i16 %113 to i64
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert690, %output_reg.sroa.37.46.insert.shift
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %88, i64 0
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.44.48.insert.ext = zext i16 %114 to i64
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %88, i64 1
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.44.50.insert.ext = zext i16 %115 to i64
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %88, i64 2
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.44.52.insert.ext = zext i16 %116 to i64
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32
  %output_reg.sroa.44.52.insert.insert696 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %88, i64 3
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.44.54.insert.ext = zext i16 %117 to i64
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert696, %output_reg.sroa.44.54.insert.shift
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %89, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.51.56.insert.ext = zext i16 %118 to i64
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %89, i64 1
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.51.58.insert.ext = zext i16 %119 to i64
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %89, i64 2
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.51.60.insert.ext = zext i16 %120 to i64
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32
  %output_reg.sroa.51.60.insert.insert702 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %89, i64 3
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.51.62.insert.ext = zext i16 %121 to i64
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert702, %output_reg.sroa.51.62.insert.shift
  br label %if.end393

if.else371:                                       ; preds = %land.lhs.true, %entry
  %.pre = shl nuw nsw i32 %2, 7
  %.pre857 = and i32 %.pre, 1920
  %.pre858 = or disjoint i32 %mul8, %.pre857
  %.pre859 = and i32 %2, 15
  %.pre860 = lshr i32 %2, 2
  %.pre861 = and i32 %and, 384
  %.pre862 = lshr i32 %2, 4
  %.pre863 = and i32 %.pre862, 3
  %.pre864 = or disjoint i32 %mul8, %.pre861
  %.pre865 = xor i32 %.pre863, %.pre859
  %.pre866 = shl nuw nsw i32 %.pre865, 4
  %.pre867 = or disjoint i32 %mul8, %.pre861
  %.pre868 = or disjoint i32 %.pre867, 512
  %.pre869 = or disjoint i32 %.pre863, 4
  %.pre870 = xor i32 %.pre869, %.pre859
  %.pre871 = shl nuw nsw i32 %.pre870, 4
  %.pre872 = or disjoint i32 %mul8, %.pre861
  %.pre873 = or disjoint i32 %.pre872, 1024
  %.pre874 = or disjoint i32 %.pre863, 8
  %.pre875 = xor i32 %.pre874, %.pre859
  %.pre876 = shl nuw nsw i32 %.pre875, 4
  %.pre877 = or disjoint i32 %mul8, %.pre861
  %.pre878 = or disjoint i32 %.pre877, 1536
  %.pre879 = or disjoint i32 %.pre863, 12
  %.pre880 = xor i32 %.pre879, %.pre859
  %.pre881 = shl nuw nsw i32 %.pre880, 4
  br label %if.end393

if.end393:                                        ; preds = %if.else371, %for.cond31.preheader
  %.idx621.3.pre-phi = phi i32 [ %.pre881, %if.else371 ], [ %.idx.3, %for.cond31.preheader ]
  %add442.3.pre-phi = phi i32 [ %.pre878, %if.else371 ], [ %add75.3, %for.cond31.preheader ]
  %.idx621.2.pre-phi = phi i32 [ %.pre876, %if.else371 ], [ %.idx.2, %for.cond31.preheader ]
  %add442.2.pre-phi = phi i32 [ %.pre873, %if.else371 ], [ %add75.2, %for.cond31.preheader ]
  %.idx621.1.pre-phi = phi i32 [ %.pre871, %if.else371 ], [ %.idx.1, %for.cond31.preheader ]
  %add442.1.pre-phi = phi i32 [ %.pre868, %if.else371 ], [ %add75.1, %for.cond31.preheader ]
  %.idx621.pre-phi = phi i32 [ %.pre866, %if.else371 ], [ %.idx, %for.cond31.preheader ]
  %add442.pre-phi = phi i32 [ %.pre864, %if.else371 ], [ %add75, %for.cond31.preheader ]
  %.pre-phi = phi i32 [ %.pre860, %if.else371 ], [ %13, %for.cond31.preheader ]
  %and415.pre-phi = phi i32 [ %.pre859, %if.else371 ], [ %and77, %for.cond31.preheader ]
  %add408.pre-phi = phi i32 [ %.pre858, %if.else371 ], [ %add101, %for.cond31.preheader ]
  %output_reg.sroa.51.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.51.62.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.44.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.44.54.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.37.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.37.46.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.30.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.30.38.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.23.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.23.30.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.16.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.16.22.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.9.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.9.14.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.0.0 = phi i64 [ 0, %if.else371 ], [ %output_reg.sroa.0.6.insert.insert, %for.cond31.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and411 = lshr i32 %2, 5
  %shr412 = and i32 %and411, 1
  %mul422 = and i32 %.pre-phi, 4
  %xor416 = xor i32 %shr412, %and415.pre-phi
  %mul417 = shl nuw nsw i32 %xor416, 3
  %add418 = add nuw nsw i32 %mul417, %add408.pre-phi
  %add423 = or disjoint i32 %add418, %mul422
  %add.ptr425 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr425, align 8
  %add413.1 = or disjoint i32 %shr412, 2
  %xor416.1 = xor i32 %add413.1, %and415.pre-phi
  %mul417.1 = shl nuw nsw i32 %xor416.1, 3
  %add418.1 = add nuw nsw i32 %mul417.1, %add408.pre-phi
  %add423.1 = or disjoint i32 %add418.1, %mul422
  %add.ptr425.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.1
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr425.1, align 8
  %add413.2 = or disjoint i32 %shr412, 4
  %xor416.2 = xor i32 %add413.2, %and415.pre-phi
  %mul417.2 = shl nuw nsw i32 %xor416.2, 3
  %add418.2 = add nuw nsw i32 %mul417.2, %add408.pre-phi
  %add423.2 = or disjoint i32 %add418.2, %mul422
  %add.ptr425.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.2
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr425.2, align 8
  %add413.3 = or disjoint i32 %shr412, 6
  %xor416.3 = xor i32 %add413.3, %and415.pre-phi
  %mul417.3 = shl nuw nsw i32 %xor416.3, 3
  %add418.3 = add nuw nsw i32 %mul417.3, %add408.pre-phi
  %add423.3 = or disjoint i32 %add418.3, %mul422
  %add.ptr425.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.3
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr425.3, align 8
  %add413.4 = or disjoint i32 %shr412, 8
  %xor416.4 = xor i32 %add413.4, %and415.pre-phi
  %mul417.4 = shl nuw nsw i32 %xor416.4, 3
  %add418.4 = add nuw nsw i32 %mul417.4, %add408.pre-phi
  %add423.4 = or disjoint i32 %add418.4, %mul422
  %add.ptr425.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.4
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr425.4, align 8
  %add413.5 = or disjoint i32 %shr412, 10
  %xor416.5 = xor i32 %add413.5, %and415.pre-phi
  %mul417.5 = shl nuw nsw i32 %xor416.5, 3
  %add418.5 = add nuw nsw i32 %mul417.5, %add408.pre-phi
  %add423.5 = or disjoint i32 %add418.5, %mul422
  %add.ptr425.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.5
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr425.5, align 8
  %add413.6 = or disjoint i32 %shr412, 12
  %xor416.6 = xor i32 %add413.6, %and415.pre-phi
  %mul417.6 = shl nuw nsw i32 %xor416.6, 3
  %add418.6 = add nuw nsw i32 %mul417.6, %add408.pre-phi
  %add423.6 = or disjoint i32 %add418.6, %mul422
  %add.ptr425.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.6
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr425.6, align 8
  %add413.7 = or disjoint i32 %shr412, 14
  %xor416.7 = xor i32 %add413.7, %and415.pre-phi
  %mul417.7 = shl nuw nsw i32 %xor416.7, 3
  %add418.7 = add nuw nsw i32 %mul417.7, %add408.pre-phi
  %add423.7 = or disjoint i32 %add418.7, %mul422
  %add.ptr425.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add423.7
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr425.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %122 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.pre-phi
  %add.ptr454 = getelementptr inbounds %struct.__half, ptr addrspace(3) %122, i32 %add442.pre-phi
  %123 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.1.pre-phi
  %add.ptr454.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %123, i32 %add442.1.pre-phi
  %124 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.2.pre-phi
  %add.ptr454.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %124, i32 %add442.2.pre-phi
  %125 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx621.3.pre-phi
  %add.ptr454.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %125, i32 %add442.3.pre-phi
  %add.ptr486 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454, i64 16, i1 false), !call_argsrelate !169
  %add.ptr486.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454.1, i64 16, i1 false), !call_argsrelate !169
  %add.ptr486.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %6
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454.2, i64 16, i1 false), !call_argsrelate !169
  %add.ptr486.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %7
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr454.3, i64 16, i1 false), !call_argsrelate !169
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

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="128" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


