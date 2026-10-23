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
  %and = shl nuw nsw i32 %2, 2
  %mul13 = and i32 %and, 252
  %add11 = or disjoint i32 %add9, %mul13
  %4 = zext nneg i32 %add11 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %5 = load i64, ptr addrspace(4) %add.ptr, align 8
  %6 = or disjoint i64 %4, 256
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %7 = load i64, ptr addrspace(4) %add.ptr.1, align 8
  %8 = or disjoint i64 %4, 512
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %8
  %9 = load i64, ptr addrspace(4) %add.ptr.2, align 8
  %10 = or disjoint i64 %4, 768
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %10
  %11 = load i64, ptr addrspace(4) %add.ptr.3, align 8
  %12 = or disjoint i64 %4, 1024
  %add.ptr.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12
  %13 = load i64, ptr addrspace(4) %add.ptr.4, align 8
  %14 = or disjoint i64 %4, 1280
  %add.ptr.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %14
  %15 = load i64, ptr addrspace(4) %add.ptr.5, align 8
  %16 = or disjoint i64 %4, 1536
  %add.ptr.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %16
  %17 = load i64, ptr addrspace(4) %add.ptr.6, align 8
  %18 = or disjoint i64 %4, 1792
  %add.ptr.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %18
  %19 = load i64, ptr addrspace(4) %add.ptr.7, align 8
  %mul19 = shl nsw i32 %0, 10
  %mul21 = shl nuw nsw i32 %1, 1
  %shr24 = lshr i32 %2, 6
  %add22 = add nuw nsw i32 %shr24, %mul21
  %add25 = add nuw nsw i32 %add22, %mul19
  %idxprom = zext nneg i32 %add25 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %20 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp26 = icmp sgt i32 %20, -1
  br i1 %cmp26, label %land.lhs.true, label %if.else364

land.lhs.true:                                    ; preds = %entry
  %cmp27 = icmp slt i32 %20, 32
  %mul29 = shl nsw i32 %20, 4
  %cmp30 = icmp sge i32 %1, %mul29
  %or.cond = select i1 %cmp27, i1 %cmp30, i1 false
  br i1 %or.cond, label %for.cond31.preheader, label %if.else364

for.cond31.preheader:                             ; preds = %land.lhs.true
  %conv = zext nneg i32 %0 to i64
  %mul37 = shl nuw nsw i64 %conv, 18
  %conv38 = zext nneg i32 %20 to i64
  %mul39 = shl nuw nsw i64 %conv38, 13
  %add40 = add nuw nsw i64 %mul39, %mul37
  %21 = shl nuw nsw i32 %2, 3
  %22 = and i32 %21, 504
  %mul47 = zext nneg i32 %22 to i64
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
  %mul74 = and i32 %and, 128
  %and77 = lshr i32 %2, 1
  %shr78 = and i32 %and77, 15
  %and81 = lshr i32 %2, 5
  %shr82 = and i32 %and81, 1
  %mul88 = and i32 %and, 4
  %xor = xor i32 %shr82, %shr78
  %mul84 = shl nuw nsw i32 %xor, 3
  %23 = or disjoint i32 %mul74, %mul84
  %add85 = or disjoint i32 %23, %mul8
  %add89 = or disjoint i32 %add85, %mul88
  %add.ptr91 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89
  store i64 %5, ptr addrspace(3) %add.ptr91, align 8
  %add70.1 = or disjoint i32 %mul8, %mul74
  %add75.1 = or disjoint i32 %add70.1, 256
  %add83.1 = or disjoint i32 %shr82, 2
  %xor.1 = xor i32 %add83.1, %shr78
  %mul84.1 = shl nuw nsw i32 %xor.1, 3
  %add85.1 = or disjoint i32 %mul84.1, %add75.1
  %add89.1 = or disjoint i32 %add85.1, %mul88
  %add.ptr91.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89.1
  store i64 %7, ptr addrspace(3) %add.ptr91.1, align 8
  %add70.2 = or disjoint i32 %mul8, 512
  %add83.2 = or disjoint i32 %shr82, 4
  %xor.2 = xor i32 %add83.2, %shr78
  %mul84.2 = shl nuw nsw i32 %xor.2, 3
  %24 = or disjoint i32 %mul74, %mul84.2
  %add85.2 = or disjoint i32 %24, %add70.2
  %add89.2 = or disjoint i32 %add85.2, %mul88
  %add.ptr91.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89.2
  store i64 %9, ptr addrspace(3) %add.ptr91.2, align 8
  %add70.3 = or disjoint i32 %mul8, %mul74
  %add75.3 = or disjoint i32 %add70.3, 768
  %add83.3 = or disjoint i32 %shr82, 6
  %xor.3 = xor i32 %add83.3, %shr78
  %mul84.3 = shl nuw nsw i32 %xor.3, 3
  %add85.3 = or disjoint i32 %mul84.3, %add75.3
  %add89.3 = or disjoint i32 %add85.3, %mul88
  %add.ptr91.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89.3
  store i64 %11, ptr addrspace(3) %add.ptr91.3, align 8
  %add70.4 = or disjoint i32 %mul8, 1024
  %add83.4 = or disjoint i32 %shr82, 8
  %xor.4 = xor i32 %add83.4, %shr78
  %mul84.4 = shl nuw nsw i32 %xor.4, 3
  %25 = or disjoint i32 %mul74, %mul84.4
  %add85.4 = or disjoint i32 %25, %add70.4
  %add89.4 = or disjoint i32 %add85.4, %mul88
  %add.ptr91.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89.4
  store i64 %13, ptr addrspace(3) %add.ptr91.4, align 8
  %add70.5 = or disjoint i32 %mul8, %mul74
  %add75.5 = or disjoint i32 %add70.5, 1280
  %add83.5 = or disjoint i32 %shr82, 10
  %xor.5 = xor i32 %add83.5, %shr78
  %mul84.5 = shl nuw nsw i32 %xor.5, 3
  %add85.5 = or disjoint i32 %mul84.5, %add75.5
  %add89.5 = or disjoint i32 %add85.5, %mul88
  %add.ptr91.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89.5
  store i64 %15, ptr addrspace(3) %add.ptr91.5, align 8
  %add70.6 = or disjoint i32 %mul8, 1536
  %add83.6 = or disjoint i32 %shr82, 12
  %xor.6 = xor i32 %add83.6, %shr78
  %mul84.6 = shl nuw nsw i32 %xor.6, 3
  %26 = or disjoint i32 %mul74, %mul84.6
  %add85.6 = or disjoint i32 %26, %add70.6
  %add89.6 = or disjoint i32 %add85.6, %mul88
  %add.ptr91.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89.6
  store i64 %17, ptr addrspace(3) %add.ptr91.6, align 8
  %add70.7 = or disjoint i32 %mul8, %mul74
  %add75.7 = or disjoint i32 %add70.7, 1792
  %add83.7 = or disjoint i32 %shr82, 14
  %xor.7 = xor i32 %add83.7, %shr78
  %mul84.7 = shl nuw nsw i32 %xor.7, 3
  %add85.7 = or disjoint i32 %mul84.7, %add75.7
  %add89.7 = or disjoint i32 %add85.7, %mul88
  %add.ptr91.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add89.7
  store i64 %19, ptr addrspace(3) %add.ptr91.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and104 = shl nuw nsw i32 %2, 7
  %mul105 = and i32 %and104, 1920
  %add106 = or disjoint i32 %mul8, %mul105
  %and109 = lshr i32 %2, 4
  %shr110 = and i32 %and109, 3
  %and113 = and i32 %2, 15
  %xor114 = xor i32 %shr110, %and113
  %.idx = shl nuw nsw i32 %xor114, 4
  %27 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx
  %add.ptr118 = getelementptr inbounds %struct.__half, ptr addrspace(3) %27, i32 %add106
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr118, align 16
  %q.sroa.4.0.add.ptr118.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr118, i32 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr118.sroa_idx, align 8
  %add111.1 = or disjoint i32 %shr110, 4
  %xor114.1 = xor i32 %add111.1, %and113
  %.idx.1 = shl nuw nsw i32 %xor114.1, 4
  %28 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.1
  %add.ptr118.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %28, i32 %add106
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr118.1, align 16
  %q.sroa.7.16.add.ptr118.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr118.1, i32 8
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr118.1.sroa_idx, align 8
  %add111.2 = or disjoint i32 %shr110, 8
  %xor114.2 = xor i32 %add111.2, %and113
  %.idx.2 = shl nuw nsw i32 %xor114.2, 4
  %29 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.2
  %add.ptr118.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %29, i32 %add106
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr118.2, align 16
  %q.sroa.10.32.add.ptr118.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr118.2, i32 8
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr118.2.sroa_idx, align 8
  %add111.3 = or disjoint i32 %shr110, 12
  %xor114.3 = xor i32 %add111.3, %and113
  %.idx.3 = shl nuw nsw i32 %xor114.3, 4
  %30 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx.3
  %add.ptr118.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %30, i32 %add106
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr118.3, align 16
  %q.sroa.13.48.add.ptr118.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr118.3, i32 8
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr118.3.sroa_idx, align 8
  %mul133 = shl nsw i32 %20, 5
  %31 = lshr i32 %2, 2
  %mul140 = and i32 %31, 12
  %add141 = or disjoint i32 %mul133, %mul140
  %cmp149.not = icmp sgt i32 %add141, %add22
  %spec.select = select i1 %cmp149.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp149.not.1.not = icmp slt i32 %add141, %add22
  %spec.select.1 = select i1 %cmp149.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add143.2 = or disjoint i32 %add141, 2
  %cmp149.not.2 = icmp sgt i32 %add143.2, %add22
  %spec.select.2 = select i1 %cmp149.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add143.3 = or disjoint i32 %add141, 3
  %cmp149.not.3 = icmp sgt i32 %add143.3, %add22
  %spec.select.3 = select i1 %cmp149.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add136.4 = or disjoint i32 %mul133, %mul140
  %add141.4 = or disjoint i32 %add136.4, 16
  %cmp149.not.4 = icmp sgt i32 %add141.4, %add22
  %spec.select.4 = select i1 %cmp149.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add143.5 = or disjoint i32 %add136.4, 17
  %cmp149.not.5 = icmp sgt i32 %add143.5, %add22
  %spec.select.5 = select i1 %cmp149.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1
  %add143.6 = or disjoint i32 %add136.4, 18
  %cmp149.not.6 = icmp sgt i32 %add143.6, %add22
  %spec.select.6 = select i1 %cmp149.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2
  %add143.7 = or disjoint i32 %add136.4, 19
  %cmp149.not.7 = icmp sgt i32 %add143.7, %add22
  %spec.select.7 = select i1 %cmp149.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !87
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !87
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %32), !call_argsrelate !87
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %33), !call_argsrelate !87
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %34), !call_argsrelate !87
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %35), !call_argsrelate !87
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %36), !call_argsrelate !87
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %37), !call_argsrelate !87
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %38), !call_argsrelate !87
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %39), !call_argsrelate !87
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %40), !call_argsrelate !87
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %41), !call_argsrelate !87
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %42), !call_argsrelate !87
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %43), !call_argsrelate !87
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %44), !call_argsrelate !87
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %45), !call_argsrelate !87
  %add.ptr216 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8192
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216, align 16
  %v.sroa.4.0.add.ptr216.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8200
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0.add.ptr216.sroa_idx, align 8
  %add.ptr216.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8192
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216.1, align 16
  %v.sroa.7.16.add.ptr216.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8200
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.add.ptr216.1.sroa_idx, align 8
  %add.ptr216.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8192
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216.2, align 16
  %v.sroa.10.32.add.ptr216.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.2, i64 8200
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.add.ptr216.2.sroa_idx, align 8
  %add.ptr216.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8192
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216.3, align 16
  %v.sroa.13.48.add.ptr216.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.3, i64 8200
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.add.ptr216.3.sroa_idx, align 8
  %add.ptr216.4 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8192
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216.4, align 16
  %v.sroa.16.64.add.ptr216.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.4, i64 8200
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.add.ptr216.4.sroa_idx, align 8
  %add.ptr216.5 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8192
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216.5, align 16
  %v.sroa.19.80.add.ptr216.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.5, i64 8200
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.add.ptr216.5.sroa_idx, align 8
  %add.ptr216.6 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8192
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216.6, align 16
  %v.sroa.22.96.add.ptr216.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.6, i64 8200
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.add.ptr216.6.sroa_idx, align 8
  %add.ptr216.7 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8192
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr216.7, align 16
  %v.sroa.25.112.add.ptr216.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.7, i64 8200
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.add.ptr216.7.sroa_idx, align 8
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0
  %mul230 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul230, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %48, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i580 = fadd contract float %48, %cond.i.i
  %49 = tail call contract float @llvm.exp2.f32(float %add.i.i580)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %49
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1
  %mul230.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul230.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %50, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i580.1 = fadd contract float %50, %cond.i.i.1
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i580.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %51
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2
  %mul230.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul230.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %52, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i580.2 = fadd contract float %52, %cond.i.i.2
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i580.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %53
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3
  %mul230.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul230.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %54, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i580.3 = fadd contract float %54, %cond.i.i.3
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i580.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %55
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %47, i64 0
  %mul230.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul230.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %56, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i580.4 = fadd contract float %56, %cond.i.i.4
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i580.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %57
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %47, i64 1
  %mul230.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul230.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %58, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i580.5 = fadd contract float %58, %cond.i.i.5
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i580.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %59
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %47, i64 2
  %mul230.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul230.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %60, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i580.6 = fadd contract float %60, %cond.i.i.6
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i580.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %61
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %47, i64 3
  %mul230.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul230.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %62, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i580.7 = fadd contract float %62, %cond.i.i.7
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i580.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %63
  %add250 = fadd contract float %mul.i.i, 0.000000e+00
  %add250.1 = fadd contract float %add250, %mul.i.i.4
  %add250.2 = fadd contract float %add250.1, %mul.i.i.1
  %add250.3 = fadd contract float %add250.2, %mul.i.i.5
  %add250.4 = fadd contract float %add250.3, %mul.i.i.2
  %add250.5 = fadd contract float %add250.4, %mul.i.i.6
  %add250.6 = fadd contract float %add250.5, %mul.i.i.3
  %add250.7 = fadd contract float %add250.6, %mul.i.i.7
  %64 = bitcast float %add250.7 to i32
  %65 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %66 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %65) #11
  %xor.i.i = xor i32 %66, 32
  %67 = and i32 %66, -64
  %and.i.i = add nsw i32 %67, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i581 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %66
  %shl.i.i = shl i32 %cond.i.i581, 2
  %68 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %64)
  %69 = bitcast i32 %68 to float
  %add.i = fadd contract float %add250.7, %69
  %70 = bitcast float %add.i to i32
  %71 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %72 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %71) #11
  %xor.i.i582 = xor i32 %72, 16
  %73 = and i32 %72, -64
  %and.i.i583 = add nsw i32 %73, 64
  %cmp.not.i.i584 = icmp slt i32 %xor.i.i582, %and.i.i583
  %cond.i.i585 = select i1 %cmp.not.i.i584, i32 %xor.i.i582, i32 %72
  %shl.i.i586 = shl i32 %cond.i.i585, 2
  %74 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i586, i32 %70)
  %75 = bitcast i32 %74 to float
  %add.i.i = fadd contract float %add.i, %75
  %cmp259 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_1.0 = select i1 %cmp259, float %div, float 0.000000e+00
  %mul272 = fmul contract float %condval_1.0, %mul.i.i
  %mul272.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul272.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul272.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %mul272.4 = fmul contract float %condval_1.0, %mul.i.i.4
  %mul272.5 = fmul contract float %condval_1.0, %mul.i.i.5
  %mul272.6 = fmul contract float %condval_1.0, %mul.i.i.6
  %mul272.7 = fmul contract float %condval_1.0, %mul.i.i.7
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272)
  %77 = insertelement <4 x i16> poison, i16 %76, i64 0
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272.1)
  %79 = insertelement <4 x i16> %77, i16 %78, i64 1
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272.2)
  %81 = insertelement <4 x i16> %79, i16 %80, i64 2
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272.3)
  %83 = insertelement <4 x i16> %81, i16 %82, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %83 to <4 x half>
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272.4)
  %85 = insertelement <4 x i16> poison, i16 %84, i64 0
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272.5)
  %87 = insertelement <4 x i16> %85, i16 %86, i64 1
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272.6)
  %89 = insertelement <4 x i16> %87, i16 %88, i64 2
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul272.7)
  %91 = insertelement <4 x i16> %89, i16 %90, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %91 to <4 x half>
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !87
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %92), !call_argsrelate !87
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %93), !call_argsrelate !87
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %94), !call_argsrelate !87
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %95), !call_argsrelate !87
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %96), !call_argsrelate !87
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %97), !call_argsrelate !87
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %98), !call_argsrelate !87
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %99), !call_argsrelate !87
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %100, i64 0
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %108 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %100, i64 1
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %109 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %100, i64 2
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %110 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert652 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %100, i64 3
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %111 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert652, %output_reg.sroa.0.6.insert.shift
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %101, i64 0
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.9.8.insert.ext = zext i16 %112 to i64
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %101, i64 1
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.9.10.insert.ext = zext i16 %113 to i64
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %101, i64 2
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.9.12.insert.ext = zext i16 %114 to i64
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32
  %output_reg.sroa.9.12.insert.insert658 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %101, i64 3
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.9.14.insert.ext = zext i16 %115 to i64
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert658, %output_reg.sroa.9.14.insert.shift
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %102, i64 0
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.16.16.insert.ext = zext i16 %116 to i64
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %102, i64 1
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.16.18.insert.ext = zext i16 %117 to i64
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %102, i64 2
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.16.20.insert.ext = zext i16 %118 to i64
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32
  %output_reg.sroa.16.20.insert.insert664 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %102, i64 3
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.16.22.insert.ext = zext i16 %119 to i64
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert664, %output_reg.sroa.16.22.insert.shift
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %103, i64 0
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.23.24.insert.ext = zext i16 %120 to i64
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %103, i64 1
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.23.26.insert.ext = zext i16 %121 to i64
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %103, i64 2
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.23.28.insert.ext = zext i16 %122 to i64
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32
  %output_reg.sroa.23.28.insert.insert670 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %103, i64 3
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.23.30.insert.ext = zext i16 %123 to i64
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert670, %output_reg.sroa.23.30.insert.shift
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %104, i64 0
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.30.32.insert.ext = zext i16 %124 to i64
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %104, i64 1
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.30.34.insert.ext = zext i16 %125 to i64
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %104, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.30.36.insert.ext = zext i16 %126 to i64
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32
  %output_reg.sroa.30.36.insert.insert676 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %104, i64 3
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.30.38.insert.ext = zext i16 %127 to i64
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert676, %output_reg.sroa.30.38.insert.shift
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %105, i64 0
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.37.40.insert.ext = zext i16 %128 to i64
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %105, i64 1
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.37.42.insert.ext = zext i16 %129 to i64
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %105, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.37.44.insert.ext = zext i16 %130 to i64
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32
  %output_reg.sroa.37.44.insert.insert682 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %105, i64 3
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.37.46.insert.ext = zext i16 %131 to i64
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert682, %output_reg.sroa.37.46.insert.shift
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %106, i64 0
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.44.48.insert.ext = zext i16 %132 to i64
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %106, i64 1
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.44.50.insert.ext = zext i16 %133 to i64
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %106, i64 2
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.44.52.insert.ext = zext i16 %134 to i64
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32
  %output_reg.sroa.44.52.insert.insert688 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %106, i64 3
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.44.54.insert.ext = zext i16 %135 to i64
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert688, %output_reg.sroa.44.54.insert.shift
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %107, i64 0
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.51.56.insert.ext = zext i16 %136 to i64
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %107, i64 1
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.51.58.insert.ext = zext i16 %137 to i64
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %107, i64 2
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.51.60.insert.ext = zext i16 %138 to i64
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32
  %output_reg.sroa.51.60.insert.insert694 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %107, i64 3
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.51.62.insert.ext = zext i16 %139 to i64
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert694, %output_reg.sroa.51.62.insert.shift
  br label %if.end386

if.else364:                                       ; preds = %land.lhs.true, %entry
  %.pre = shl nuw nsw i32 %2, 7
  %.pre849 = and i32 %.pre, 1920
  %.pre850 = or disjoint i32 %mul8, %.pre849
  %.pre851 = lshr i32 %2, 5
  %.pre852 = and i32 %.pre851, 1
  %.pre853 = and i32 %2, 15
  %.pre854 = lshr i32 %2, 2
  %.pre855 = or disjoint i32 %.pre852, 2
  %.pre856 = or disjoint i32 %.pre852, 4
  %.pre857 = or disjoint i32 %.pre852, 6
  %.pre858 = or disjoint i32 %.pre852, 8
  %.pre859 = or disjoint i32 %.pre852, 10
  %.pre860 = or disjoint i32 %.pre852, 12
  %.pre861 = or disjoint i32 %.pre852, 14
  %.pre862 = shl nuw nsw i32 %2, 3
  %.pre864 = lshr i32 %2, 4
  %.pre865 = and i32 %.pre864, 3
  %.pre866 = xor i32 %.pre865, %.pre853
  %.pre867 = shl nuw nsw i32 %.pre866, 4
  %.pre868 = or disjoint i32 %mul8, 512
  %.pre869 = or disjoint i32 %.pre865, 4
  %.pre870 = xor i32 %.pre869, %.pre853
  %.pre871 = shl nuw nsw i32 %.pre870, 4
  %.pre872 = or disjoint i32 %mul8, 1024
  %.pre873 = or disjoint i32 %.pre865, 8
  %.pre874 = xor i32 %.pre873, %.pre853
  %.pre875 = shl nuw nsw i32 %.pre874, 4
  %.pre876 = or disjoint i32 %mul8, 1536
  %.pre877 = or disjoint i32 %.pre865, 12
  %.pre878 = xor i32 %.pre877, %.pre853
  %.pre879 = shl nuw nsw i32 %.pre878, 4
  %.pre880 = and i32 %.pre862, 504
  br label %if.end386

if.end386:                                        ; preds = %if.else364, %for.cond31.preheader
  %mul476.pre-phi = phi i32 [ %.pre880, %if.else364 ], [ %22, %for.cond31.preheader ]
  %.idx615.3.pre-phi = phi i32 [ %.pre879, %if.else364 ], [ %.idx.3, %for.cond31.preheader ]
  %add430.3.pre-phi = phi i32 [ %.pre876, %if.else364 ], [ %add70.6, %for.cond31.preheader ]
  %.idx615.2.pre-phi = phi i32 [ %.pre875, %if.else364 ], [ %.idx.2, %for.cond31.preheader ]
  %add430.2.pre-phi = phi i32 [ %.pre872, %if.else364 ], [ %add70.4, %for.cond31.preheader ]
  %.idx615.1.pre-phi = phi i32 [ %.pre871, %if.else364 ], [ %.idx.1, %for.cond31.preheader ]
  %add430.1.pre-phi = phi i32 [ %.pre868, %if.else364 ], [ %add70.2, %for.cond31.preheader ]
  %.idx615.pre-phi = phi i32 [ %.pre867, %if.else364 ], [ %.idx, %for.cond31.preheader ]
  %.pre-phi863 = phi i32 [ %.pre862, %if.else364 ], [ %21, %for.cond31.preheader ]
  %add406.7.pre-phi = phi i32 [ %.pre861, %if.else364 ], [ %add83.7, %for.cond31.preheader ]
  %add406.6.pre-phi = phi i32 [ %.pre860, %if.else364 ], [ %add83.6, %for.cond31.preheader ]
  %add406.5.pre-phi = phi i32 [ %.pre859, %if.else364 ], [ %add83.5, %for.cond31.preheader ]
  %add406.4.pre-phi = phi i32 [ %.pre858, %if.else364 ], [ %add83.4, %for.cond31.preheader ]
  %add406.3.pre-phi = phi i32 [ %.pre857, %if.else364 ], [ %add83.3, %for.cond31.preheader ]
  %add406.2.pre-phi = phi i32 [ %.pre856, %if.else364 ], [ %add83.2, %for.cond31.preheader ]
  %add406.1.pre-phi = phi i32 [ %.pre855, %if.else364 ], [ %add83.1, %for.cond31.preheader ]
  %.pre-phi = phi i32 [ %.pre854, %if.else364 ], [ %31, %for.cond31.preheader ]
  %and408.pre-phi = phi i32 [ %.pre853, %if.else364 ], [ %and113, %for.cond31.preheader ]
  %shr405.pre-phi = phi i32 [ %.pre852, %if.else364 ], [ %shr82, %for.cond31.preheader ]
  %add401.pre-phi = phi i32 [ %.pre850, %if.else364 ], [ %add106, %for.cond31.preheader ]
  %output_reg.sroa.51.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.51.62.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.44.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.44.54.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.37.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.37.46.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.30.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.30.38.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.23.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.23.30.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.16.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.16.22.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.9.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.9.14.insert.insert, %for.cond31.preheader ]
  %output_reg.sroa.0.0 = phi i64 [ 0, %if.else364 ], [ %output_reg.sroa.0.6.insert.insert, %for.cond31.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul415 = and i32 %.pre-phi, 4
  %xor409 = xor i32 %shr405.pre-phi, %and408.pre-phi
  %mul410 = shl nuw nsw i32 %xor409, 3
  %add411 = add nuw nsw i32 %mul410, %add401.pre-phi
  %add416 = or disjoint i32 %add411, %mul415
  %add.ptr418 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr418, align 8
  %xor409.1 = xor i32 %add406.1.pre-phi, %and408.pre-phi
  %mul410.1 = shl nuw nsw i32 %xor409.1, 3
  %add411.1 = add nuw nsw i32 %mul410.1, %add401.pre-phi
  %add416.1 = or disjoint i32 %add411.1, %mul415
  %add.ptr418.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416.1
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr418.1, align 8
  %xor409.2 = xor i32 %add406.2.pre-phi, %and408.pre-phi
  %mul410.2 = shl nuw nsw i32 %xor409.2, 3
  %add411.2 = add nuw nsw i32 %mul410.2, %add401.pre-phi
  %add416.2 = or disjoint i32 %add411.2, %mul415
  %add.ptr418.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416.2
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr418.2, align 8
  %xor409.3 = xor i32 %add406.3.pre-phi, %and408.pre-phi
  %mul410.3 = shl nuw nsw i32 %xor409.3, 3
  %add411.3 = add nuw nsw i32 %mul410.3, %add401.pre-phi
  %add416.3 = or disjoint i32 %add411.3, %mul415
  %add.ptr418.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416.3
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr418.3, align 8
  %xor409.4 = xor i32 %add406.4.pre-phi, %and408.pre-phi
  %mul410.4 = shl nuw nsw i32 %xor409.4, 3
  %add411.4 = add nuw nsw i32 %mul410.4, %add401.pre-phi
  %add416.4 = or disjoint i32 %add411.4, %mul415
  %add.ptr418.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416.4
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr418.4, align 8
  %xor409.5 = xor i32 %add406.5.pre-phi, %and408.pre-phi
  %mul410.5 = shl nuw nsw i32 %xor409.5, 3
  %add411.5 = add nuw nsw i32 %mul410.5, %add401.pre-phi
  %add416.5 = or disjoint i32 %add411.5, %mul415
  %add.ptr418.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416.5
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr418.5, align 8
  %xor409.6 = xor i32 %add406.6.pre-phi, %and408.pre-phi
  %mul410.6 = shl nuw nsw i32 %xor409.6, 3
  %add411.6 = add nuw nsw i32 %mul410.6, %add401.pre-phi
  %add416.6 = or disjoint i32 %add411.6, %mul415
  %add.ptr418.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416.6
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr418.6, align 8
  %xor409.7 = xor i32 %add406.7.pre-phi, %and408.pre-phi
  %mul410.7 = shl nuw nsw i32 %xor409.7, 3
  %add411.7 = add nuw nsw i32 %mul410.7, %add401.pre-phi
  %add416.7 = or disjoint i32 %add411.7, %mul415
  %add.ptr418.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add416.7
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr418.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul434 = and i32 %.pre-phi863, 384
  %add435 = or disjoint i32 %mul8, %mul434
  %140 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx615.pre-phi
  %add.ptr447 = getelementptr inbounds %struct.__half, ptr addrspace(3) %140, i32 %add435
  %add435.1 = or disjoint i32 %add430.1.pre-phi, %mul434
  %141 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx615.1.pre-phi
  %add.ptr447.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %141, i32 %add435.1
  %add435.2 = or disjoint i32 %add430.2.pre-phi, %mul434
  %142 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx615.2.pre-phi
  %add.ptr447.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) %142, i32 %add435.2
  %add435.3 = or disjoint i32 %add430.3.pre-phi, %mul434
  %143 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx615.3.pre-phi
  %add.ptr447.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) %143, i32 %add435.3
  %add473 = or disjoint i32 %add9, %mul476.pre-phi
  %144 = zext nneg i32 %add473 to i64
  %add.ptr479 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %144
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr479, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr447, i64 16, i1 false), !call_argsrelate !193
  %145 = or disjoint i64 %144, 512
  %add.ptr479.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %145
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr479.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr447.1, i64 16, i1 false), !call_argsrelate !193
  %146 = or disjoint i64 %144, 1024
  %add.ptr479.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr479.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr447.2, i64 16, i1 false), !call_argsrelate !193
  %147 = or disjoint i64 %144, 1536
  %add.ptr479.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %147
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr479.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr447.3, i64 16, i1 false), !call_argsrelate !193
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare i16 @llvm.convert.to.fp16.f32(float) #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #8

declare float @llvm.exp2.f32(float) #9

declare float @llvm.minnum.f32(float, float) #9

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


