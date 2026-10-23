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
  br i1 %cmp20, label %land.rhs, label %if.else346

land.rhs:                                         ; preds = %entry
  %mul21 = shl nuw nsw i32 %19, 5
  %cmp23.not = icmp ugt i32 %mul21, %1
  br i1 %cmp23.not, label %if.else346, label %for.cond24.preheader

for.cond24.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul30 = shl nuw nsw i64 %conv, 18
  %20 = shl nuw nsw i32 %19, 13
  %mul32 = zext nneg i32 %20 to i64
  %21 = shl nuw nsw i32 %2, 3
  %mul39 = zext nneg i32 %21 to i64
  %add33 = or disjoint i64 %mul30, %mul39
  %add36 = or disjoint i64 %add33, %mul32
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add36
  %23 = load <4 x half>, ptr addrspace(4) %22, align 2, !tbaa !55
  %add40.4 = or disjoint i64 %add36, 4
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add40.4
  %25 = load <4 x half>, ptr addrspace(4) %24, align 2, !tbaa !55
  %arrayidx43.8 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1024
  %26 = load <4 x half>, ptr addrspace(4) %arrayidx43.8, align 2, !tbaa !55
  %arrayidx43.12 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024
  %27 = load <4 x half>, ptr addrspace(4) %arrayidx43.12, align 2, !tbaa !55
  %arrayidx43.16 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 2048
  %28 = load <4 x half>, ptr addrspace(4) %arrayidx43.16, align 2, !tbaa !55
  %arrayidx43.20 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2048
  %29 = load <4 x half>, ptr addrspace(4) %arrayidx43.20, align 2, !tbaa !55
  %arrayidx43.24 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 3072
  %30 = load <4 x half>, ptr addrspace(4) %arrayidx43.24, align 2, !tbaa !55
  %arrayidx43.28 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 3072
  %31 = load <4 x half>, ptr addrspace(4) %arrayidx43.28, align 2, !tbaa !55
  %arrayidx43.32 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 4096
  %32 = load <4 x half>, ptr addrspace(4) %arrayidx43.32, align 2, !tbaa !55
  %arrayidx43.36 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 4096
  %33 = load <4 x half>, ptr addrspace(4) %arrayidx43.36, align 2, !tbaa !55
  %arrayidx43.40 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 5120
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx43.40, align 2, !tbaa !55
  %arrayidx43.44 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 5120
  %35 = load <4 x half>, ptr addrspace(4) %arrayidx43.44, align 2, !tbaa !55
  %arrayidx43.48 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 6144
  %36 = load <4 x half>, ptr addrspace(4) %arrayidx43.48, align 2, !tbaa !55
  %arrayidx43.52 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 6144
  %37 = load <4 x half>, ptr addrspace(4) %arrayidx43.52, align 2, !tbaa !55
  %arrayidx43.56 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 7168
  %38 = load <4 x half>, ptr addrspace(4) %arrayidx43.56, align 2, !tbaa !55
  %arrayidx43.60 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 7168
  %39 = load <4 x half>, ptr addrspace(4) %arrayidx43.60, align 2, !tbaa !55
  %and65 = lshr i32 %2, 1
  %shr66 = and i32 %and65, 15
  %shr69 = lshr i32 %2, 5
  %add63 = and i32 %mul10, 3972
  %xor = xor i32 %shr69, %shr66
  %40 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add63
  %add.ptr78.idx = shl nuw nsw i32 %xor, 4
  %add.ptr78 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr78.idx
  store i64 %4, ptr addrspace(3) %add.ptr78, align 8
  %add70.1 = add nuw nsw i32 %shr69, 2
  %xor.1 = xor i32 %add70.1, %shr66
  %41 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 512
  %add.ptr78.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr78.1 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %add.ptr78.idx.1
  store i64 %6, ptr addrspace(3) %add.ptr78.1, align 8
  %add70.2 = add nuw nsw i32 %shr69, 4
  %xor.2 = xor i32 %add70.2, %shr66
  %42 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 1024
  %add.ptr78.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr78.2 = getelementptr inbounds i8, ptr addrspace(3) %42, i32 %add.ptr78.idx.2
  store i64 %8, ptr addrspace(3) %add.ptr78.2, align 8
  %add70.3 = add nuw nsw i32 %shr69, 6
  %xor.3 = xor i32 %add70.3, %shr66
  %43 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 1536
  %add.ptr78.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr78.3 = getelementptr inbounds i8, ptr addrspace(3) %43, i32 %add.ptr78.idx.3
  store i64 %10, ptr addrspace(3) %add.ptr78.3, align 8
  %add70.4 = add nuw nsw i32 %shr69, 8
  %xor.4 = xor i32 %add70.4, %shr66
  %44 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 2048
  %add.ptr78.idx.4 = shl nuw nsw i32 %xor.4, 4
  %add.ptr78.4 = getelementptr inbounds i8, ptr addrspace(3) %44, i32 %add.ptr78.idx.4
  store i64 %12, ptr addrspace(3) %add.ptr78.4, align 8
  %add70.5 = add nuw nsw i32 %shr69, 10
  %xor.5 = xor i32 %add70.5, %shr66
  %45 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 2560
  %add.ptr78.idx.5 = shl nuw nsw i32 %xor.5, 4
  %add.ptr78.5 = getelementptr inbounds i8, ptr addrspace(3) %45, i32 %add.ptr78.idx.5
  store i64 %14, ptr addrspace(3) %add.ptr78.5, align 8
  %add70.6 = add nuw nsw i32 %shr69, 12
  %xor.6 = xor i32 %add70.6, %shr66
  %46 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 3072
  %add.ptr78.idx.6 = shl nuw nsw i32 %xor.6, 4
  %add.ptr78.6 = getelementptr inbounds i8, ptr addrspace(3) %46, i32 %add.ptr78.idx.6
  store i64 %16, ptr addrspace(3) %add.ptr78.6, align 8
  %add70.7 = add nuw nsw i32 %shr69, 14
  %xor.7 = xor i32 %add70.7, %shr66
  %47 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 3584
  %add.ptr78.idx.7 = shl nuw nsw i32 %xor.7, 4
  %add.ptr78.7 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr78.idx.7
  store i64 %18, ptr addrspace(3) %add.ptr78.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and88 = shl nuw nsw i32 %2, 7
  %mul89 = and i32 %and88, 1920
  %shr92 = lshr i32 %2, 4
  %and95 = and i32 %2, 15
  %48 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul89
  %xor96 = xor i32 %shr92, %and95
  %add.ptr100.idx = shl nuw nsw i32 %xor96, 4
  %add.ptr100 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100, align 16
  %q.sroa.4.0.add.ptr100.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100, i32 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr100.sroa_idx, align 8
  %add93.1 = add nuw nsw i32 %shr92, 4
  %xor96.1 = xor i32 %add93.1, %and95
  %add.ptr100.idx.1 = shl nuw nsw i32 %xor96.1, 4
  %add.ptr100.1 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx.1
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100.1, align 16
  %q.sroa.7.16.add.ptr100.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100.1, i32 8
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr100.1.sroa_idx, align 8
  %add93.2 = add nuw nsw i32 %shr92, 8
  %xor96.2 = xor i32 %add93.2, %and95
  %add.ptr100.idx.2 = shl nuw nsw i32 %xor96.2, 4
  %add.ptr100.2 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx.2
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100.2, align 16
  %q.sroa.10.32.add.ptr100.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100.2, i32 8
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr100.2.sroa_idx, align 8
  %add93.3 = add nuw nsw i32 %shr92, 12
  %xor96.3 = xor i32 %add93.3, %and95
  %add.ptr100.idx.3 = shl nuw nsw i32 %xor96.3, 4
  %add.ptr100.3 = getelementptr inbounds i8, ptr addrspace(3) %48, i32 %add.ptr100.idx.3
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr100.3, align 16
  %q.sroa.13.48.add.ptr100.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr100.3, i32 8
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr100.3.sroa_idx, align 8
  %49 = lshr i32 %2, 2
  %mul121 = and i32 %49, 252
  %add118 = add nuw nsw i32 %mul21, %mul121
  %cmp126.not = icmp ugt i32 %add118, %1
  %spec.select = select i1 %cmp126.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp126.not.1.not = icmp ult i32 %add118, %1
  %spec.select.1 = select i1 %cmp126.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add122.2 = or disjoint i32 %add118, 2
  %cmp126.not.2 = icmp ugt i32 %add122.2, %1
  %spec.select.2 = select i1 %cmp126.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add122.3 = or disjoint i32 %add118, 3
  %cmp126.not.3 = icmp ugt i32 %add122.3, %1
  %spec.select.3 = select i1 %cmp126.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add124.4 = add nuw nsw i32 %add118, 16
  %cmp126.not.4 = icmp ugt i32 %add124.4, %1
  %spec.select.4 = select i1 %cmp126.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add124.5 = add nuw nsw i32 %add118, 17
  %cmp126.not.5 = icmp ugt i32 %add124.5, %1
  %spec.select.5 = select i1 %cmp126.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1
  %add124.6 = add nuw nsw i32 %add118, 18
  %cmp126.not.6 = icmp ugt i32 %add124.6, %1
  %spec.select.6 = select i1 %cmp126.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2
  %add124.7 = add nuw nsw i32 %add118, 19
  %cmp126.not.7 = icmp ugt i32 %add124.7, %1
  %spec.select.7 = select i1 %cmp126.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %23, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !79
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !79
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %25, <4 x half> %q.sroa.4.0.copyload, <4 x float> %50), !call_argsrelate !79
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %q.sroa.4.0.copyload, <4 x float> %51), !call_argsrelate !79
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %q.sroa.5.16.copyload, <4 x float> %52), !call_argsrelate !79
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %q.sroa.5.16.copyload, <4 x float> %53), !call_argsrelate !79
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %q.sroa.7.16.copyload, <4 x float> %54), !call_argsrelate !79
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %q.sroa.7.16.copyload, <4 x float> %55), !call_argsrelate !79
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %32, <4 x half> %q.sroa.8.32.copyload, <4 x float> %56), !call_argsrelate !79
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %q.sroa.8.32.copyload, <4 x float> %57), !call_argsrelate !79
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %q.sroa.10.32.copyload, <4 x float> %58), !call_argsrelate !79
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %q.sroa.10.32.copyload, <4 x float> %59), !call_argsrelate !79
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %q.sroa.11.48.copyload, <4 x float> %60), !call_argsrelate !79
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %38, <4 x half> %q.sroa.11.48.copyload, <4 x float> %61), !call_argsrelate !79
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %37, <4 x half> %q.sroa.13.48.copyload, <4 x float> %62), !call_argsrelate !79
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %39, <4 x half> %q.sroa.13.48.copyload, <4 x float> %63), !call_argsrelate !79
  %invariant.gep = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
  %66 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add36
  %67 = load <4 x half>, ptr addrspace(4) %66, align 2, !tbaa !55
  %68 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add40.4
  %69 = load <4 x half>, ptr addrspace(4) %68, align 2, !tbaa !55
  %gep.8 = getelementptr i8, ptr addrspace(4) %66, i64 1024
  %70 = load <4 x half>, ptr addrspace(4) %gep.8, align 2, !tbaa !55
  %gep.12 = getelementptr i8, ptr addrspace(4) %68, i64 1024
  %71 = load <4 x half>, ptr addrspace(4) %gep.12, align 2, !tbaa !55
  %gep.16 = getelementptr i8, ptr addrspace(4) %66, i64 2048
  %72 = load <4 x half>, ptr addrspace(4) %gep.16, align 2, !tbaa !55
  %gep.20 = getelementptr i8, ptr addrspace(4) %68, i64 2048
  %73 = load <4 x half>, ptr addrspace(4) %gep.20, align 2, !tbaa !55
  %gep.24 = getelementptr i8, ptr addrspace(4) %66, i64 3072
  %74 = load <4 x half>, ptr addrspace(4) %gep.24, align 2, !tbaa !55
  %gep.28 = getelementptr i8, ptr addrspace(4) %68, i64 3072
  %75 = load <4 x half>, ptr addrspace(4) %gep.28, align 2, !tbaa !55
  %gep.32 = getelementptr i8, ptr addrspace(4) %66, i64 4096
  %76 = load <4 x half>, ptr addrspace(4) %gep.32, align 2, !tbaa !55
  %gep.36 = getelementptr i8, ptr addrspace(4) %68, i64 4096
  %77 = load <4 x half>, ptr addrspace(4) %gep.36, align 2, !tbaa !55
  %gep.40 = getelementptr i8, ptr addrspace(4) %66, i64 5120
  %78 = load <4 x half>, ptr addrspace(4) %gep.40, align 2, !tbaa !55
  %gep.44 = getelementptr i8, ptr addrspace(4) %68, i64 5120
  %79 = load <4 x half>, ptr addrspace(4) %gep.44, align 2, !tbaa !55
  %gep.48 = getelementptr i8, ptr addrspace(4) %66, i64 6144
  %80 = load <4 x half>, ptr addrspace(4) %gep.48, align 2, !tbaa !55
  %gep.52 = getelementptr i8, ptr addrspace(4) %68, i64 6144
  %81 = load <4 x half>, ptr addrspace(4) %gep.52, align 2, !tbaa !55
  %gep.56 = getelementptr i8, ptr addrspace(4) %66, i64 7168
  %82 = load <4 x half>, ptr addrspace(4) %gep.56, align 2, !tbaa !55
  %gep.60 = getelementptr i8, ptr addrspace(4) %68, i64 7168
  %83 = load <4 x half>, ptr addrspace(4) %gep.60, align 2, !tbaa !55
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %64, i64 0
  %mul211 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul211, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %84, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i531 = fadd contract float %84, %cond.i.i
  %85 = tail call contract float @llvm.exp2.f32(float %add.i.i531)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %85
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %64, i64 1
  %mul211.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul211.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %86, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i531.1 = fadd contract float %86, %cond.i.i.1
  %87 = tail call contract float @llvm.exp2.f32(float %add.i.i531.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %87
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %64, i64 2
  %mul211.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul211.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %88, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i531.2 = fadd contract float %88, %cond.i.i.2
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i531.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %89
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %64, i64 3
  %mul211.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul211.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %90, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i531.3 = fadd contract float %90, %cond.i.i.3
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i531.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %91
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %65, i64 0
  %mul211.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul211.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %92, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i531.4 = fadd contract float %92, %cond.i.i.4
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i531.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %93
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %65, i64 1
  %mul211.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul211.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %94, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i531.5 = fadd contract float %94, %cond.i.i.5
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i531.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %95
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %65, i64 2
  %mul211.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul211.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %96, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i531.6 = fadd contract float %96, %cond.i.i.6
  %97 = tail call contract float @llvm.exp2.f32(float %add.i.i531.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %97
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %65, i64 3
  %mul211.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul211.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %98, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i531.7 = fadd contract float %98, %cond.i.i.7
  %99 = tail call contract float @llvm.exp2.f32(float %add.i.i531.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %99
  %add231 = fadd contract float %mul.i.i, 0.000000e+00
  %add231.1 = fadd contract float %add231, %mul.i.i.4
  %add231.2 = fadd contract float %add231.1, %mul.i.i.1
  %add231.3 = fadd contract float %add231.2, %mul.i.i.5
  %add231.4 = fadd contract float %add231.3, %mul.i.i.2
  %add231.5 = fadd contract float %add231.4, %mul.i.i.6
  %add231.6 = fadd contract float %add231.5, %mul.i.i.3
  %add231.7 = fadd contract float %add231.6, %mul.i.i.7
  %100 = bitcast float %add231.7 to i32
  %101 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %102 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %101) #11
  %xor.i.i = xor i32 %102, 32
  %103 = and i32 %102, -64
  %and.i.i = add nsw i32 %103, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i532 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %102
  %shl.i.i = shl i32 %cond.i.i532, 2
  %104 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %100)
  %105 = bitcast i32 %104 to float
  %add.i = fadd contract float %add231.7, %105
  %106 = bitcast float %add.i to i32
  %107 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %108 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %107) #11
  %xor.i.i533 = xor i32 %108, 16
  %109 = and i32 %108, -64
  %and.i.i534 = add nsw i32 %109, 64
  %cmp.not.i.i535 = icmp slt i32 %xor.i.i533, %and.i.i534
  %cond.i.i536 = select i1 %cmp.not.i.i535, i32 %xor.i.i533, i32 %108
  %shl.i.i537 = shl i32 %cond.i.i536, 2
  %110 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i537, i32 %106)
  %111 = bitcast i32 %110 to float
  %add.i.i = fadd contract float %add.i, %111
  %cmp240 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_1.0 = select i1 %cmp240, float %div, float 0.000000e+00
  %mul253 = fmul contract float %condval_1.0, %mul.i.i
  %mul253.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul253.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul253.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %mul253.4 = fmul contract float %condval_1.0, %mul.i.i.4
  %mul253.5 = fmul contract float %condval_1.0, %mul.i.i.5
  %mul253.6 = fmul contract float %condval_1.0, %mul.i.i.6
  %mul253.7 = fmul contract float %condval_1.0, %mul.i.i.7
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253)
  %113 = insertelement <4 x i16> poison, i16 %112, i64 0
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.1)
  %115 = insertelement <4 x i16> %113, i16 %114, i64 1
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.2)
  %117 = insertelement <4 x i16> %115, i16 %116, i64 2
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.3)
  %119 = insertelement <4 x i16> %117, i16 %118, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %119 to <4 x half>
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.4)
  %121 = insertelement <4 x i16> poison, i16 %120, i64 0
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.5)
  %123 = insertelement <4 x i16> %121, i16 %122, i64 1
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.6)
  %125 = insertelement <4 x i16> %123, i16 %124, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul253.7)
  %127 = insertelement <4 x i16> %125, i16 %126, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %127 to <4 x half>
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %70, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %71, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !79
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %128), !call_argsrelate !79
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %129), !call_argsrelate !79
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %78, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %130), !call_argsrelate !79
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %79, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %131), !call_argsrelate !79
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %132), !call_argsrelate !79
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %81, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %133), !call_argsrelate !79
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %82, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %134), !call_argsrelate !79
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %83, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %135), !call_argsrelate !79
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %136, i64 0
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %144 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %136, i64 1
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %145 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %136, i64 2
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %146 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert650 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %136, i64 3
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %147 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert650, %output_reg.sroa.0.6.insert.shift
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %137, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.9.8.insert.ext = zext i16 %148 to i64
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %137, i64 1
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.9.10.insert.ext = zext i16 %149 to i64
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %137, i64 2
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.9.12.insert.ext = zext i16 %150 to i64
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32
  %output_reg.sroa.9.12.insert.insert656 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %137, i64 3
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.9.14.insert.ext = zext i16 %151 to i64
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert656, %output_reg.sroa.9.14.insert.shift
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %138, i64 0
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.16.16.insert.ext = zext i16 %152 to i64
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %138, i64 1
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.16.18.insert.ext = zext i16 %153 to i64
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %138, i64 2
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.16.20.insert.ext = zext i16 %154 to i64
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32
  %output_reg.sroa.16.20.insert.insert662 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %138, i64 3
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.16.22.insert.ext = zext i16 %155 to i64
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert662, %output_reg.sroa.16.22.insert.shift
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %139, i64 0
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.23.24.insert.ext = zext i16 %156 to i64
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %139, i64 1
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.23.26.insert.ext = zext i16 %157 to i64
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %139, i64 2
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.23.28.insert.ext = zext i16 %158 to i64
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32
  %output_reg.sroa.23.28.insert.insert668 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %139, i64 3
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.23.30.insert.ext = zext i16 %159 to i64
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert668, %output_reg.sroa.23.30.insert.shift
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %140, i64 0
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.30.32.insert.ext = zext i16 %160 to i64
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %140, i64 1
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.30.34.insert.ext = zext i16 %161 to i64
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %140, i64 2
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.30.36.insert.ext = zext i16 %162 to i64
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32
  %output_reg.sroa.30.36.insert.insert674 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %140, i64 3
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.30.38.insert.ext = zext i16 %163 to i64
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert674, %output_reg.sroa.30.38.insert.shift
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %141, i64 0
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.37.40.insert.ext = zext i16 %164 to i64
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %141, i64 1
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.37.42.insert.ext = zext i16 %165 to i64
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %141, i64 2
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.37.44.insert.ext = zext i16 %166 to i64
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32
  %output_reg.sroa.37.44.insert.insert680 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %141, i64 3
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.37.46.insert.ext = zext i16 %167 to i64
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert680, %output_reg.sroa.37.46.insert.shift
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %142, i64 0
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.44.48.insert.ext = zext i16 %168 to i64
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %142, i64 1
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.44.50.insert.ext = zext i16 %169 to i64
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %142, i64 2
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.44.52.insert.ext = zext i16 %170 to i64
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32
  %output_reg.sroa.44.52.insert.insert686 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %142, i64 3
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.44.54.insert.ext = zext i16 %171 to i64
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert686, %output_reg.sroa.44.54.insert.shift
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %143, i64 0
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.51.56.insert.ext = zext i16 %172 to i64
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %143, i64 1
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.51.58.insert.ext = zext i16 %173 to i64
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %143, i64 2
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.51.60.insert.ext = zext i16 %174 to i64
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32
  %output_reg.sroa.51.60.insert.insert692 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %143, i64 3
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.51.62.insert.ext = zext i16 %175 to i64
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert692, %output_reg.sroa.51.62.insert.shift
  br label %if.end369

if.else346:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre831 = and i32 %.pre, 1920
  %.pre832 = lshr i32 %2, 5
  %.pre833 = and i32 %2, 15
  %.pre834 = lshr i32 %2, 2
  %.pre835 = add nuw nsw i32 %.pre832, 2
  %.pre836 = add nuw nsw i32 %.pre832, 4
  %.pre837 = add nuw nsw i32 %.pre832, 6
  %.pre838 = add nuw nsw i32 %.pre832, 8
  %.pre839 = add nuw nsw i32 %.pre832, 10
  %.pre840 = add nuw nsw i32 %.pre832, 12
  %.pre841 = add nuw nsw i32 %.pre832, 14
  %.pre842 = shl nuw nsw i32 %2, 3
  %.pre844 = lshr i32 %2, 4
  %.pre845 = xor i32 %.pre844, %.pre833
  %.pre846 = shl nuw nsw i32 %.pre845, 4
  br label %if.end369

if.end369:                                        ; preds = %for.cond24.preheader, %if.else346
  %add.ptr419.idx.pre-phi = phi i32 [ %add.ptr100.idx, %for.cond24.preheader ], [ %.pre846, %if.else346 ]
  %shr413.pre-phi = phi i32 [ %shr92, %for.cond24.preheader ], [ %.pre844, %if.else346 ]
  %.pre-phi843 = phi i32 [ %21, %for.cond24.preheader ], [ %.pre842, %if.else346 ]
  %add384.7.pre-phi = phi i32 [ %add70.7, %for.cond24.preheader ], [ %.pre841, %if.else346 ]
  %add384.6.pre-phi = phi i32 [ %add70.6, %for.cond24.preheader ], [ %.pre840, %if.else346 ]
  %add384.5.pre-phi = phi i32 [ %add70.5, %for.cond24.preheader ], [ %.pre839, %if.else346 ]
  %add384.4.pre-phi = phi i32 [ %add70.4, %for.cond24.preheader ], [ %.pre838, %if.else346 ]
  %add384.3.pre-phi = phi i32 [ %add70.3, %for.cond24.preheader ], [ %.pre837, %if.else346 ]
  %add384.2.pre-phi = phi i32 [ %add70.2, %for.cond24.preheader ], [ %.pre836, %if.else346 ]
  %add384.1.pre-phi = phi i32 [ %add70.1, %for.cond24.preheader ], [ %.pre835, %if.else346 ]
  %.pre-phi = phi i32 [ %49, %for.cond24.preheader ], [ %.pre834, %if.else346 ]
  %and386.pre-phi = phi i32 [ %and95, %for.cond24.preheader ], [ %.pre833, %if.else346 ]
  %shr383.pre-phi = phi i32 [ %shr69, %for.cond24.preheader ], [ %.pre832, %if.else346 ]
  %mul380.pre-phi = phi i32 [ %mul89, %for.cond24.preheader ], [ %.pre831, %if.else346 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond24.preheader ], [ 0, %if.else346 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul393 = and i32 %.pre-phi, 4
  %xor387 = xor i32 %shr383.pre-phi, %and386.pre-phi
  %mul388 = shl nuw nsw i32 %xor387, 3
  %add389 = add nuw nsw i32 %mul388, %mul380.pre-phi
  %add394 = or disjoint i32 %add389, %mul393
  %add.ptr396 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr396, align 8
  %xor387.1 = xor i32 %add384.1.pre-phi, %and386.pre-phi
  %mul388.1 = shl nuw nsw i32 %xor387.1, 3
  %add389.1 = add nuw nsw i32 %mul388.1, %mul380.pre-phi
  %add394.1 = or disjoint i32 %add389.1, %mul393
  %add.ptr396.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.1
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr396.1, align 8
  %xor387.2 = xor i32 %add384.2.pre-phi, %and386.pre-phi
  %mul388.2 = shl nuw nsw i32 %xor387.2, 3
  %add389.2 = add nuw nsw i32 %mul388.2, %mul380.pre-phi
  %add394.2 = or disjoint i32 %add389.2, %mul393
  %add.ptr396.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.2
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr396.2, align 8
  %xor387.3 = xor i32 %add384.3.pre-phi, %and386.pre-phi
  %mul388.3 = shl nuw nsw i32 %xor387.3, 3
  %add389.3 = add nuw nsw i32 %mul388.3, %mul380.pre-phi
  %add394.3 = or disjoint i32 %add389.3, %mul393
  %add.ptr396.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.3
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr396.3, align 8
  %xor387.4 = xor i32 %add384.4.pre-phi, %and386.pre-phi
  %mul388.4 = shl nuw nsw i32 %xor387.4, 3
  %add389.4 = add nuw nsw i32 %mul388.4, %mul380.pre-phi
  %add394.4 = or disjoint i32 %add389.4, %mul393
  %add.ptr396.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.4
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr396.4, align 8
  %xor387.5 = xor i32 %add384.5.pre-phi, %and386.pre-phi
  %mul388.5 = shl nuw nsw i32 %xor387.5, 3
  %add389.5 = add nuw nsw i32 %mul388.5, %mul380.pre-phi
  %add394.5 = or disjoint i32 %add389.5, %mul393
  %add.ptr396.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.5
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr396.5, align 8
  %xor387.6 = xor i32 %add384.6.pre-phi, %and386.pre-phi
  %mul388.6 = shl nuw nsw i32 %xor387.6, 3
  %add389.6 = add nuw nsw i32 %mul388.6, %mul380.pre-phi
  %add394.6 = or disjoint i32 %add389.6, %mul393
  %add.ptr396.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.6
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr396.6, align 8
  %xor387.7 = xor i32 %add384.7.pre-phi, %and386.pre-phi
  %mul388.7 = shl nuw nsw i32 %xor387.7, 3
  %add389.7 = add nuw nsw i32 %mul388.7, %mul380.pre-phi
  %add394.7 = or disjoint i32 %add389.7, %mul393
  %add.ptr396.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add394.7
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr396.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul407 = and i32 %.pre-phi843, 8064
  %invariant.gep562 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul407
  %add426 = add nuw nsw i32 %add, %.pre-phi843
  %176 = zext nneg i32 %add426 to i64
  %add.ptr419 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 %add.ptr419.idx.pre-phi
  %add.ptr431 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419, i64 16, i1 false), !tbaa.struct !184, !call_argsrelate !185
  %177 = add nuw nsw i32 %shr413.pre-phi, 4
  %xor415.1 = xor i32 %177, %and386.pre-phi
  %gep563.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 1024
  %add.ptr419.idx.1 = shl nuw nsw i32 %xor415.1, 4
  %add.ptr419.1 = getelementptr inbounds i8, ptr addrspace(3) %gep563.1, i32 %add.ptr419.idx.1
  %178 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176
  %add.ptr431.1 = getelementptr inbounds i8, ptr addrspace(1) %178, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419.1, i64 16, i1 false), !tbaa.struct !184, !call_argsrelate !185
  %179 = add nuw nsw i32 %shr413.pre-phi, 8
  %xor415.2 = xor i32 %179, %and386.pre-phi
  %gep563.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 2048
  %add.ptr419.idx.2 = shl nuw nsw i32 %xor415.2, 4
  %add.ptr419.2 = getelementptr inbounds i8, ptr addrspace(3) %gep563.2, i32 %add.ptr419.idx.2
  %180 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176
  %add.ptr431.2 = getelementptr inbounds i8, ptr addrspace(1) %180, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419.2, i64 16, i1 false), !tbaa.struct !184, !call_argsrelate !185
  %narrow = add nuw nsw i32 %shr413.pre-phi, 12
  %xor415.3 = xor i32 %narrow, %and386.pre-phi
  %gep563.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep562, i32 3072
  %add.ptr419.idx.3 = shl nuw nsw i32 %xor415.3, 4
  %add.ptr419.3 = getelementptr inbounds i8, ptr addrspace(3) %gep563.3, i32 %add.ptr419.idx.3
  %181 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %176
  %add.ptr431.3 = getelementptr inbounds i8, ptr addrspace(1) %181, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr431.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr419.3, i64 16, i1 false), !tbaa.struct !184, !call_argsrelate !185
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


