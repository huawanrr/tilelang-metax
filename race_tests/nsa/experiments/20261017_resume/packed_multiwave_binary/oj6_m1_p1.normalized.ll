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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul6 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul6
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul10 = shl nuw nsw i32 %2, 2
  %add8 = add nuw nsw i32 %add, %mul10
  %3 = zext nneg i32 %add8 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %4 = load i64, ptr addrspace(4) %add.ptr, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 512
  %6 = load i64, ptr addrspace(4) %add.ptr.1, align 8
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1024
  %8 = load i64, ptr addrspace(4) %add.ptr.2, align 8
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1536
  %10 = load i64, ptr addrspace(4) %add.ptr.3, align 8
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.4 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 2048
  %12 = load i64, ptr addrspace(4) %add.ptr.4, align 8
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.5 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2560
  %14 = load i64, ptr addrspace(4) %add.ptr.5, align 8
  %15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.6 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 3072
  %16 = load i64, ptr addrspace(4) %add.ptr.6, align 8
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.7 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 3584
  %18 = load i64, ptr addrspace(4) %add.ptr.7, align 8
  %mul16 = shl nsw i32 %0, 10
  %add18 = add nuw nsw i32 %mul16, %1
  %idxprom = zext nneg i32 %add18 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %19 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp20 = icmp ult i32 %19, 32
  br i1 %cmp20, label %land.rhs, label %if.else366

land.rhs:                                         ; preds = %entry
  %mul21 = shl nuw nsw i32 %19, 5
  %cmp23.not = icmp ugt i32 %mul21, %1
  br i1 %cmp23.not, label %if.else366, label %for.cond24.preheader

for.cond24.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul30 = shl nuw nsw i64 %conv, 18
  %20 = shl nuw nsw i32 %19, 13
  %mul32 = zext nneg i32 %20 to i64
  %add33 = or disjoint i64 %mul30, %mul32
  %21 = shl nuw nsw i32 %2, 3
  %mul42 = zext nneg i32 %21 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul42
  %gep = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add33
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %gep, align 16
  %k.sroa.4.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.gep.sroa_idx, align 8
  %add36.1 = or disjoint i64 %add33, 1024
  %gep.1 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36.1
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16
  %k.sroa.10.32.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.1, i64 8
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.1.sroa_idx, align 8
  %add36.2 = or disjoint i64 %add33, 2048
  %gep.2 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36.2
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16
  %k.sroa.16.64.gep.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.2, i64 8
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.2.sroa_idx, align 8
  %add36.3 = or disjoint i64 %add33, 3072
  %gep.3 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36.3
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16
  %k.sroa.22.96.gep.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.3, i64 8
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.3.sroa_idx, align 8
  %add39.4 = or disjoint i64 %add33, 512
  %gep.4 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.4
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16
  %k.sroa.7.16.gep.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.4, i64 8
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.4.sroa_idx, align 8
  %add39.5 = or disjoint i64 %add33, 1536
  %gep.5 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.5
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16
  %k.sroa.13.48.gep.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.5, i64 8
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.5.sroa_idx, align 8
  %add39.6 = or disjoint i64 %add33, 2560
  %gep.6 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.6
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16
  %k.sroa.19.80.gep.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.6, i64 8
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.6.sroa_idx, align 8
  %add39.7 = or disjoint i64 %add33, 3584
  %gep.7 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add39.7
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep.7, i64 8
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8
  %and71 = lshr i32 %2, 1
  %shr72 = and i32 %and71, 15
  %shr75 = lshr i32 %2, 5
  %add69 = and i32 %mul10, 3972
  %xor = xor i32 %shr75, %shr72
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add69
  %add.ptr84.idx = shl nuw nsw i32 %xor, 4
  %add.ptr84 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr84.idx
  store i64 %4, ptr addrspace(3) %add.ptr84, align 8
  %add76.1 = add nuw nsw i32 %shr75, 2
  %xor.1 = xor i32 %add76.1, %shr72
  %23 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 512
  %add.ptr84.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr84.1 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 %add.ptr84.idx.1
  store i64 %6, ptr addrspace(3) %add.ptr84.1, align 8
  %add76.2 = add nuw nsw i32 %shr75, 4
  %xor.2 = xor i32 %add76.2, %shr72
  %24 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 1024
  %add.ptr84.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr84.2 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr84.idx.2
  store i64 %8, ptr addrspace(3) %add.ptr84.2, align 8
  %add76.3 = add nuw nsw i32 %shr75, 6
  %xor.3 = xor i32 %add76.3, %shr72
  %25 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 1536
  %add.ptr84.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr84.3 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr84.idx.3
  store i64 %10, ptr addrspace(3) %add.ptr84.3, align 8
  %add76.4 = add nuw nsw i32 %shr75, 8
  %xor.4 = xor i32 %add76.4, %shr72
  %26 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 2048
  %add.ptr84.idx.4 = shl nuw nsw i32 %xor.4, 4
  %add.ptr84.4 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr84.idx.4
  store i64 %12, ptr addrspace(3) %add.ptr84.4, align 8
  %add76.5 = add nuw nsw i32 %shr75, 10
  %xor.5 = xor i32 %add76.5, %shr72
  %27 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 2560
  %add.ptr84.idx.5 = shl nuw nsw i32 %xor.5, 4
  %add.ptr84.5 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr84.idx.5
  store i64 %14, ptr addrspace(3) %add.ptr84.5, align 8
  %add76.6 = add nuw nsw i32 %shr75, 12
  %xor.6 = xor i32 %add76.6, %shr72
  %28 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 3072
  %add.ptr84.idx.6 = shl nuw nsw i32 %xor.6, 4
  %add.ptr84.6 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr84.idx.6
  store i64 %16, ptr addrspace(3) %add.ptr84.6, align 8
  %add76.7 = add nuw nsw i32 %shr75, 14
  %xor.7 = xor i32 %add76.7, %shr72
  %29 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 3584
  %add.ptr84.idx.7 = shl nuw nsw i32 %xor.7, 4
  %add.ptr84.7 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr84.idx.7
  store i64 %18, ptr addrspace(3) %add.ptr84.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and94 = shl nuw nsw i32 %2, 7
  %mul95 = and i32 %and94, 1920
  %shr98 = lshr i32 %2, 4
  %and101 = and i32 %2, 15
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul95
  %xor102 = xor i32 %shr98, %and101
  %add.ptr106.idx = shl nuw nsw i32 %xor102, 4
  %add.ptr106 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106, align 16
  %q.sroa.4.0.add.ptr106.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106, i32 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr106.sroa_idx, align 8
  %add99.1 = add nuw nsw i32 %shr98, 4
  %xor102.1 = xor i32 %add99.1, %and101
  %add.ptr106.idx.1 = shl nuw nsw i32 %xor102.1, 4
  %add.ptr106.1 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx.1
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106.1, align 16
  %q.sroa.7.16.add.ptr106.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106.1, i32 8
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr106.1.sroa_idx, align 8
  %add99.2 = add nuw nsw i32 %shr98, 8
  %xor102.2 = xor i32 %add99.2, %and101
  %add.ptr106.idx.2 = shl nuw nsw i32 %xor102.2, 4
  %add.ptr106.2 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx.2
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106.2, align 16
  %q.sroa.10.32.add.ptr106.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106.2, i32 8
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr106.2.sroa_idx, align 8
  %add99.3 = add nuw nsw i32 %shr98, 12
  %xor102.3 = xor i32 %add99.3, %and101
  %add.ptr106.idx.3 = shl nuw nsw i32 %xor102.3, 4
  %add.ptr106.3 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr106.idx.3
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr106.3, align 16
  %q.sroa.13.48.add.ptr106.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr106.3, i32 8
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr106.3.sroa_idx, align 8
  %31 = lshr i32 %2, 2
  %mul127 = and i32 %31, 252
  %add124 = add nuw nsw i32 %mul21, %mul127
  %cmp132.not = icmp ugt i32 %add124, %1
  %spec.select = select i1 %cmp132.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp132.not.1.not = icmp ult i32 %add124, %1
  %spec.select.1 = select i1 %cmp132.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add128.2 = or disjoint i32 %add124, 2
  %cmp132.not.2 = icmp ugt i32 %add128.2, %1
  %spec.select.2 = select i1 %cmp132.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add128.3 = or disjoint i32 %add124, 3
  %cmp132.not.3 = icmp ugt i32 %add128.3, %1
  %spec.select.3 = select i1 %cmp132.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add130.4 = add nuw nsw i32 %add124, 16
  %cmp132.not.4 = icmp ugt i32 %add130.4, %1
  %spec.select.4 = select i1 %cmp132.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add130.5 = add nuw nsw i32 %add124, 17
  %cmp132.not.5 = icmp ugt i32 %add130.5, %1
  %spec.select.5 = select i1 %cmp132.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1
  %add130.6 = add nuw nsw i32 %add124, 18
  %cmp132.not.6 = icmp ugt i32 %add130.6, %1
  %spec.select.6 = select i1 %cmp132.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2
  %add130.7 = add nuw nsw i32 %add124, 19
  %cmp132.not.7 = icmp ugt i32 %add130.7, %1
  %spec.select.7 = select i1 %cmp132.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !80
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !80
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %32), !call_argsrelate !80
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %33), !call_argsrelate !80
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %34), !call_argsrelate !80
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %35), !call_argsrelate !80
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %36), !call_argsrelate !80
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %37), !call_argsrelate !80
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %38), !call_argsrelate !80
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %39), !call_argsrelate !80
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %40), !call_argsrelate !80
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %41), !call_argsrelate !80
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %42), !call_argsrelate !80
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %43), !call_argsrelate !80
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %44), !call_argsrelate !80
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %45), !call_argsrelate !80
  %add198 = or disjoint i64 %mul30, %mul42
  %add189 = or disjoint i64 %add198, %mul32
  %invariant.gep590 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
  %48 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add189
  %add206.1 = or disjoint i64 %add189, 4
  %49 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.1
  %add202.2 = add nuw nsw i64 %add189, 512
  %50 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.2
  %add206.3 = or disjoint i64 %add202.2, 4
  %51 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.3
  %add202.4 = add nuw nsw i64 %add189, 1024
  %52 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.4
  %add206.5 = or disjoint i64 %add202.4, 4
  %53 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.5
  %add202.6 = add nuw nsw i64 %add189, 1536
  %54 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.6
  %add206.7 = or disjoint i64 %add202.6, 4
  %55 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.7
  %56 = load <4 x half>, ptr addrspace(4) %48, align 2, !tbaa !86
  %57 = load <4 x half>, ptr addrspace(4) %49, align 2, !tbaa !86
  %58 = load <4 x half>, ptr addrspace(4) %50, align 2, !tbaa !86
  %59 = load <4 x half>, ptr addrspace(4) %51, align 2, !tbaa !86
  %60 = load <4 x half>, ptr addrspace(4) %52, align 2, !tbaa !86
  %61 = load <4 x half>, ptr addrspace(4) %53, align 2, !tbaa !86
  %62 = load <4 x half>, ptr addrspace(4) %54, align 2, !tbaa !86
  %63 = load <4 x half>, ptr addrspace(4) %55, align 2, !tbaa !86
  %add193.32 = add nuw nsw i64 %add189, 2048
  %64 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add193.32
  %add206.33 = or disjoint i64 %add193.32, 4
  %65 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.33
  %add202.34 = add nuw nsw i64 %add189, 2560
  %66 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.34
  %add206.35 = or disjoint i64 %add202.34, 4
  %67 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.35
  %add202.36 = add nuw nsw i64 %add189, 3072
  %68 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.36
  %add206.37 = or disjoint i64 %add202.36, 4
  %69 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.37
  %add202.38 = add nuw nsw i64 %add189, 3584
  %70 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add202.38
  %add206.39 = or disjoint i64 %add202.38, 4
  %71 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep590, i64 %add206.39
  %72 = load <4 x half>, ptr addrspace(4) %64, align 2, !tbaa !86
  %73 = load <4 x half>, ptr addrspace(4) %65, align 2, !tbaa !86
  %74 = load <4 x half>, ptr addrspace(4) %66, align 2, !tbaa !86
  %75 = load <4 x half>, ptr addrspace(4) %67, align 2, !tbaa !86
  %76 = load <4 x half>, ptr addrspace(4) %68, align 2, !tbaa !86
  %77 = load <4 x half>, ptr addrspace(4) %69, align 2, !tbaa !86
  %78 = load <4 x half>, ptr addrspace(4) %70, align 2, !tbaa !86
  %79 = load <4 x half>, ptr addrspace(4) %71, align 2, !tbaa !86
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0
  %mul232 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul232, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %80, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i573 = fadd contract float %80, %cond.i.i
  %81 = tail call contract float @llvm.exp2.f32(float %add.i.i573)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %81
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1
  %mul232.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul232.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %82, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i573.1 = fadd contract float %82, %cond.i.i.1
  %83 = tail call contract float @llvm.exp2.f32(float %add.i.i573.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %83
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2
  %mul232.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul232.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %84, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i573.2 = fadd contract float %84, %cond.i.i.2
  %85 = tail call contract float @llvm.exp2.f32(float %add.i.i573.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %85
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3
  %mul232.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul232.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %86, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i573.3 = fadd contract float %86, %cond.i.i.3
  %87 = tail call contract float @llvm.exp2.f32(float %add.i.i573.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %87
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %47, i64 0
  %mul232.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul232.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %88, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i573.4 = fadd contract float %88, %cond.i.i.4
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i573.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %89
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %47, i64 1
  %mul232.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul232.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %90, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i573.5 = fadd contract float %90, %cond.i.i.5
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i573.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %91
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %47, i64 2
  %mul232.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul232.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %92, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i573.6 = fadd contract float %92, %cond.i.i.6
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i573.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %93
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %47, i64 3
  %mul232.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul232.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %94, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i573.7 = fadd contract float %94, %cond.i.i.7
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i573.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %95
  %add252 = fadd contract float %mul.i.i, 0.000000e+00
  %add252.1 = fadd contract float %add252, %mul.i.i.4
  %add252.2 = fadd contract float %add252.1, %mul.i.i.1
  %add252.3 = fadd contract float %add252.2, %mul.i.i.5
  %add252.4 = fadd contract float %add252.3, %mul.i.i.2
  %add252.5 = fadd contract float %add252.4, %mul.i.i.6
  %add252.6 = fadd contract float %add252.5, %mul.i.i.3
  %add252.7 = fadd contract float %add252.6, %mul.i.i.7
  %96 = bitcast float %add252.7 to i32
  %97 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %98 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %97) #11
  %xor.i.i = xor i32 %98, 32
  %99 = and i32 %98, -64
  %and.i.i = add nsw i32 %99, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i574 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %98
  %shl.i.i = shl i32 %cond.i.i574, 2
  %100 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %96)
  %101 = bitcast i32 %100 to float
  %add.i = fadd contract float %add252.7, %101
  %102 = bitcast float %add.i to i32
  %103 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %104 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %103) #11
  %xor.i.i575 = xor i32 %104, 16
  %105 = and i32 %104, -64
  %and.i.i576 = add nsw i32 %105, 64
  %cmp.not.i.i577 = icmp slt i32 %xor.i.i575, %and.i.i576
  %cond.i.i578 = select i1 %cmp.not.i.i577, i32 %xor.i.i575, i32 %104
  %shl.i.i579 = shl i32 %cond.i.i578, 2
  %106 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i579, i32 %102)
  %107 = bitcast i32 %106 to float
  %add.i.i = fadd contract float %add.i, %107
  %cmp261 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_1.0 = select i1 %cmp261, float %div, float 0.000000e+00
  %mul274 = fmul contract float %condval_1.0, %mul.i.i
  %mul274.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul274.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul274.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %mul274.4 = fmul contract float %condval_1.0, %mul.i.i.4
  %mul274.5 = fmul contract float %condval_1.0, %mul.i.i.5
  %mul274.6 = fmul contract float %condval_1.0, %mul.i.i.6
  %mul274.7 = fmul contract float %condval_1.0, %mul.i.i.7
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274)
  %109 = insertelement <4 x i16> poison, i16 %108, i64 0
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.1)
  %111 = insertelement <4 x i16> %109, i16 %110, i64 1
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.2)
  %113 = insertelement <4 x i16> %111, i16 %112, i64 2
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.3)
  %115 = insertelement <4 x i16> %113, i16 %114, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %115 to <4 x half>
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.4)
  %117 = insertelement <4 x i16> poison, i16 %116, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.5)
  %119 = insertelement <4 x i16> %117, i16 %118, i64 1
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.6)
  %121 = insertelement <4 x i16> %119, i16 %120, i64 2
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul274.7)
  %123 = insertelement <4 x i16> %121, i16 %122, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %123 to <4 x half>
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %57, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %58, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %59, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %62, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %63, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %124), !call_argsrelate !80
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %125), !call_argsrelate !80
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %126), !call_argsrelate !80
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %127), !call_argsrelate !80
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %128), !call_argsrelate !80
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %129), !call_argsrelate !80
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %78, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %130), !call_argsrelate !80
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %79, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %131), !call_argsrelate !80
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %132, i64 0
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %140 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %132, i64 1
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %141 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %132, i64 2
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %142 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert649 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %132, i64 3
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %143 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert649, %output_reg.sroa.0.6.insert.shift
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %133, i64 0
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.9.8.insert.ext = zext i16 %144 to i64
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %133, i64 1
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.9.10.insert.ext = zext i16 %145 to i64
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %133, i64 2
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.9.12.insert.ext = zext i16 %146 to i64
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32
  %output_reg.sroa.9.12.insert.insert655 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %133, i64 3
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.9.14.insert.ext = zext i16 %147 to i64
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert655, %output_reg.sroa.9.14.insert.shift
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %134, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.16.16.insert.ext = zext i16 %148 to i64
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %134, i64 1
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.16.18.insert.ext = zext i16 %149 to i64
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %134, i64 2
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.16.20.insert.ext = zext i16 %150 to i64
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32
  %output_reg.sroa.16.20.insert.insert661 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %134, i64 3
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.16.22.insert.ext = zext i16 %151 to i64
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert661, %output_reg.sroa.16.22.insert.shift
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %135, i64 0
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.23.24.insert.ext = zext i16 %152 to i64
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %135, i64 1
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.23.26.insert.ext = zext i16 %153 to i64
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %135, i64 2
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.23.28.insert.ext = zext i16 %154 to i64
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32
  %output_reg.sroa.23.28.insert.insert667 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %135, i64 3
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.23.30.insert.ext = zext i16 %155 to i64
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert667, %output_reg.sroa.23.30.insert.shift
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %136, i64 0
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.30.32.insert.ext = zext i16 %156 to i64
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %136, i64 1
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.30.34.insert.ext = zext i16 %157 to i64
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %136, i64 2
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.30.36.insert.ext = zext i16 %158 to i64
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32
  %output_reg.sroa.30.36.insert.insert673 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %136, i64 3
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.30.38.insert.ext = zext i16 %159 to i64
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert673, %output_reg.sroa.30.38.insert.shift
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %137, i64 0
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.37.40.insert.ext = zext i16 %160 to i64
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %137, i64 1
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.37.42.insert.ext = zext i16 %161 to i64
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %137, i64 2
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.37.44.insert.ext = zext i16 %162 to i64
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32
  %output_reg.sroa.37.44.insert.insert679 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %137, i64 3
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.37.46.insert.ext = zext i16 %163 to i64
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert679, %output_reg.sroa.37.46.insert.shift
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %138, i64 0
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.44.48.insert.ext = zext i16 %164 to i64
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %138, i64 1
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.44.50.insert.ext = zext i16 %165 to i64
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %138, i64 2
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.44.52.insert.ext = zext i16 %166 to i64
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32
  %output_reg.sroa.44.52.insert.insert685 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %138, i64 3
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.44.54.insert.ext = zext i16 %167 to i64
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert685, %output_reg.sroa.44.54.insert.shift
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %139, i64 0
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.51.56.insert.ext = zext i16 %168 to i64
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %139, i64 1
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.51.58.insert.ext = zext i16 %169 to i64
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %139, i64 2
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.51.60.insert.ext = zext i16 %170 to i64
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32
  %output_reg.sroa.51.60.insert.insert691 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %139, i64 3
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.51.62.insert.ext = zext i16 %171 to i64
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert691, %output_reg.sroa.51.62.insert.shift
  br label %if.end388

if.else366:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre862 = and i32 %.pre, 1920
  %.pre863 = lshr i32 %2, 5
  %.pre864 = and i32 %2, 15
  %.pre865 = lshr i32 %2, 2
  %.pre866 = add nuw nsw i32 %.pre863, 2
  %.pre867 = add nuw nsw i32 %.pre863, 4
  %.pre868 = add nuw nsw i32 %.pre863, 6
  %.pre869 = add nuw nsw i32 %.pre863, 8
  %.pre870 = add nuw nsw i32 %.pre863, 10
  %.pre871 = add nuw nsw i32 %.pre863, 12
  %.pre872 = add nuw nsw i32 %.pre863, 14
  %.pre873 = shl nuw nsw i32 %2, 3
  %.pre875 = lshr i32 %2, 4
  %.pre876 = xor i32 %.pre875, %.pre864
  %.pre877 = shl nuw nsw i32 %.pre876, 4
  %.pre878 = add nuw nsw i32 %.pre875, 4
  %.pre879 = xor i32 %.pre878, %.pre864
  %.pre880 = shl nuw nsw i32 %.pre879, 4
  %.pre881 = add nuw nsw i32 %.pre875, 8
  %.pre882 = xor i32 %.pre881, %.pre864
  %.pre883 = shl nuw nsw i32 %.pre882, 4
  %.pre884 = add nuw nsw i32 %.pre875, 12
  %.pre885 = xor i32 %.pre884, %.pre864
  %.pre886 = shl nuw nsw i32 %.pre885, 4
  br label %if.end388

if.end388:                                        ; preds = %for.cond24.preheader, %if.else366
  %add.ptr438.idx.3.pre-phi = phi i32 [ %add.ptr106.idx.3, %for.cond24.preheader ], [ %.pre886, %if.else366 ]
  %add.ptr438.idx.2.pre-phi = phi i32 [ %add.ptr106.idx.2, %for.cond24.preheader ], [ %.pre883, %if.else366 ]
  %add.ptr438.idx.1.pre-phi = phi i32 [ %add.ptr106.idx.1, %for.cond24.preheader ], [ %.pre880, %if.else366 ]
  %add.ptr438.idx.pre-phi = phi i32 [ %add.ptr106.idx, %for.cond24.preheader ], [ %.pre877, %if.else366 ]
  %.pre-phi874 = phi i32 [ %21, %for.cond24.preheader ], [ %.pre873, %if.else366 ]
  %add403.7.pre-phi = phi i32 [ %add76.7, %for.cond24.preheader ], [ %.pre872, %if.else366 ]
  %add403.6.pre-phi = phi i32 [ %add76.6, %for.cond24.preheader ], [ %.pre871, %if.else366 ]
  %add403.5.pre-phi = phi i32 [ %add76.5, %for.cond24.preheader ], [ %.pre870, %if.else366 ]
  %add403.4.pre-phi = phi i32 [ %add76.4, %for.cond24.preheader ], [ %.pre869, %if.else366 ]
  %add403.3.pre-phi = phi i32 [ %add76.3, %for.cond24.preheader ], [ %.pre868, %if.else366 ]
  %add403.2.pre-phi = phi i32 [ %add76.2, %for.cond24.preheader ], [ %.pre867, %if.else366 ]
  %add403.1.pre-phi = phi i32 [ %add76.1, %for.cond24.preheader ], [ %.pre866, %if.else366 ]
  %.pre-phi = phi i32 [ %31, %for.cond24.preheader ], [ %.pre865, %if.else366 ]
  %and405.pre-phi = phi i32 [ %and101, %for.cond24.preheader ], [ %.pre864, %if.else366 ]
  %shr402.pre-phi = phi i32 [ %shr75, %for.cond24.preheader ], [ %.pre863, %if.else366 ]
  %mul399.pre-phi = phi i32 [ %mul95, %for.cond24.preheader ], [ %.pre862, %if.else366 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond24.preheader ], [ 0, %if.else366 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul412 = and i32 %.pre-phi, 4
  %xor406 = xor i32 %shr402.pre-phi, %and405.pre-phi
  %mul407 = shl nuw nsw i32 %xor406, 3
  %add408 = add nuw nsw i32 %mul407, %mul399.pre-phi
  %add413 = or disjoint i32 %add408, %mul412
  %add.ptr415 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr415, align 8
  %xor406.1 = xor i32 %add403.1.pre-phi, %and405.pre-phi
  %mul407.1 = shl nuw nsw i32 %xor406.1, 3
  %add408.1 = add nuw nsw i32 %mul407.1, %mul399.pre-phi
  %add413.1 = or disjoint i32 %add408.1, %mul412
  %add.ptr415.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.1
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr415.1, align 8
  %xor406.2 = xor i32 %add403.2.pre-phi, %and405.pre-phi
  %mul407.2 = shl nuw nsw i32 %xor406.2, 3
  %add408.2 = add nuw nsw i32 %mul407.2, %mul399.pre-phi
  %add413.2 = or disjoint i32 %add408.2, %mul412
  %add.ptr415.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.2
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr415.2, align 8
  %xor406.3 = xor i32 %add403.3.pre-phi, %and405.pre-phi
  %mul407.3 = shl nuw nsw i32 %xor406.3, 3
  %add408.3 = add nuw nsw i32 %mul407.3, %mul399.pre-phi
  %add413.3 = or disjoint i32 %add408.3, %mul412
  %add.ptr415.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.3
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr415.3, align 8
  %xor406.4 = xor i32 %add403.4.pre-phi, %and405.pre-phi
  %mul407.4 = shl nuw nsw i32 %xor406.4, 3
  %add408.4 = add nuw nsw i32 %mul407.4, %mul399.pre-phi
  %add413.4 = or disjoint i32 %add408.4, %mul412
  %add.ptr415.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.4
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr415.4, align 8
  %xor406.5 = xor i32 %add403.5.pre-phi, %and405.pre-phi
  %mul407.5 = shl nuw nsw i32 %xor406.5, 3
  %add408.5 = add nuw nsw i32 %mul407.5, %mul399.pre-phi
  %add413.5 = or disjoint i32 %add408.5, %mul412
  %add.ptr415.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.5
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr415.5, align 8
  %xor406.6 = xor i32 %add403.6.pre-phi, %and405.pre-phi
  %mul407.6 = shl nuw nsw i32 %xor406.6, 3
  %add408.6 = add nuw nsw i32 %mul407.6, %mul399.pre-phi
  %add413.6 = or disjoint i32 %add408.6, %mul412
  %add.ptr415.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.6
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr415.6, align 8
  %xor406.7 = xor i32 %add403.7.pre-phi, %and405.pre-phi
  %mul407.7 = shl nuw nsw i32 %xor406.7, 3
  %add408.7 = add nuw nsw i32 %mul407.7, %mul399.pre-phi
  %add413.7 = or disjoint i32 %add408.7, %mul412
  %add.ptr415.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add413.7
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr415.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul426 = and i32 %.pre-phi874, 8064
  %invariant.gep606 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul426
  %add.ptr438 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 %add.ptr438.idx.pre-phi
  %gep607.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 1024
  %add.ptr438.1 = getelementptr inbounds i8, ptr addrspace(3) %gep607.1, i32 %add.ptr438.idx.1.pre-phi
  %gep607.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 2048
  %add.ptr438.2 = getelementptr inbounds i8, ptr addrspace(3) %gep607.2, i32 %add.ptr438.idx.2.pre-phi
  %gep607.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep606, i32 3072
  %add.ptr438.3 = getelementptr inbounds i8, ptr addrspace(3) %gep607.3, i32 %add.ptr438.idx.3.pre-phi
  %add460 = add nuw nsw i32 %add, %.pre-phi874
  %172 = zext nneg i32 %add460 to i64
  %add.ptr465 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438, i64 16, i1 false), !call_argsrelate !190
  %173 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172
  %add.ptr465.1 = getelementptr inbounds i8, ptr addrspace(1) %173, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438.1, i64 16, i1 false), !call_argsrelate !190
  %174 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172
  %add.ptr465.2 = getelementptr inbounds i8, ptr addrspace(1) %174, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438.2, i64 16, i1 false), !call_argsrelate !190
  %175 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %172
  %add.ptr465.3 = getelementptr inbounds i8, ptr addrspace(1) %175, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr465.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr438.3, i64 16, i1 false), !call_argsrelate !190
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
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


