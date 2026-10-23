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
  br i1 %cmp20, label %land.rhs, label %if.else341

land.rhs:                                         ; preds = %entry
  %mul21 = shl nuw nsw i32 %19, 5
  %cmp23.not = icmp ugt i32 %mul21, %1
  br i1 %cmp23.not, label %if.else341, label %for.cond24.preheader

for.cond24.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul30 = shl nuw nsw i64 %conv, 18
  %20 = shl nuw nsw i32 %19, 13
  %mul32 = zext nneg i32 %20 to i64
  %add33 = or disjoint i64 %mul30, %mul32
  %21 = shl nuw nsw i32 %2, 3
  %mul39 = zext nneg i32 %21 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul39
  %22 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add33
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %22, align 16
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %22, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8
  %gep.1 = getelementptr i8, ptr addrspace(4) %22, i64 1024
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 1032
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8
  %gep.2 = getelementptr i8, ptr addrspace(4) %22, i64 2048
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 2056
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8
  %gep.3 = getelementptr i8, ptr addrspace(4) %22, i64 3072
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 3080
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8
  %gep.4 = getelementptr i8, ptr addrspace(4) %22, i64 4096
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 4104
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8
  %gep.5 = getelementptr i8, ptr addrspace(4) %22, i64 5120
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 5128
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8
  %gep.6 = getelementptr i8, ptr addrspace(4) %22, i64 6144
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 6152
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8
  %gep.7 = getelementptr i8, ptr addrspace(4) %22, i64 7168
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 7176
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8
  %and = lshr i32 %2, 1
  %shr63 = and i32 %and, 15
  %shr66 = lshr i32 %2, 5
  %add61 = and i32 %mul10, 3972
  %xor = xor i32 %shr66, %shr63
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add61
  %add.ptr75.idx = shl nuw nsw i32 %xor, 4
  %add.ptr75 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 %add.ptr75.idx
  store i64 %4, ptr addrspace(3) %add.ptr75, align 8
  %add67.1 = add nuw nsw i32 %shr66, 2
  %xor.1 = xor i32 %add67.1, %shr63
  %24 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 512
  %add.ptr75.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr75.1 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr75.idx.1
  store i64 %6, ptr addrspace(3) %add.ptr75.1, align 8
  %add67.2 = add nuw nsw i32 %shr66, 4
  %xor.2 = xor i32 %add67.2, %shr63
  %25 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 1024
  %add.ptr75.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr75.2 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr75.idx.2
  store i64 %8, ptr addrspace(3) %add.ptr75.2, align 8
  %add67.3 = add nuw nsw i32 %shr66, 6
  %xor.3 = xor i32 %add67.3, %shr63
  %26 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 1536
  %add.ptr75.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr75.3 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr75.idx.3
  store i64 %10, ptr addrspace(3) %add.ptr75.3, align 8
  %add67.4 = add nuw nsw i32 %shr66, 8
  %xor.4 = xor i32 %add67.4, %shr63
  %27 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 2048
  %add.ptr75.idx.4 = shl nuw nsw i32 %xor.4, 4
  %add.ptr75.4 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr75.idx.4
  store i64 %12, ptr addrspace(3) %add.ptr75.4, align 8
  %add67.5 = add nuw nsw i32 %shr66, 10
  %xor.5 = xor i32 %add67.5, %shr63
  %28 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 2560
  %add.ptr75.idx.5 = shl nuw nsw i32 %xor.5, 4
  %add.ptr75.5 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr75.idx.5
  store i64 %14, ptr addrspace(3) %add.ptr75.5, align 8
  %add67.6 = add nuw nsw i32 %shr66, 12
  %xor.6 = xor i32 %add67.6, %shr63
  %29 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 3072
  %add.ptr75.idx.6 = shl nuw nsw i32 %xor.6, 4
  %add.ptr75.6 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr75.idx.6
  store i64 %16, ptr addrspace(3) %add.ptr75.6, align 8
  %add67.7 = add nuw nsw i32 %shr66, 14
  %xor.7 = xor i32 %add67.7, %shr63
  %30 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 3584
  %add.ptr75.idx.7 = shl nuw nsw i32 %xor.7, 4
  %add.ptr75.7 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr75.idx.7
  store i64 %18, ptr addrspace(3) %add.ptr75.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and85 = shl nuw nsw i32 %2, 7
  %mul86 = and i32 %and85, 1920
  %shr89 = lshr i32 %2, 4
  %and92 = and i32 %2, 15
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul86
  %xor93 = xor i32 %shr89, %and92
  %add.ptr97.idx = shl nuw nsw i32 %xor93, 4
  %add.ptr97 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97, align 16
  %q.sroa.4.0.add.ptr97.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97, i32 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr97.sroa_idx, align 8
  %add90.1 = add nuw nsw i32 %shr89, 4
  %xor93.1 = xor i32 %add90.1, %and92
  %add.ptr97.idx.1 = shl nuw nsw i32 %xor93.1, 4
  %add.ptr97.1 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx.1
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.1, align 16
  %q.sroa.7.16.add.ptr97.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.1, i32 8
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr97.1.sroa_idx, align 8
  %add90.2 = add nuw nsw i32 %shr89, 8
  %xor93.2 = xor i32 %add90.2, %and92
  %add.ptr97.idx.2 = shl nuw nsw i32 %xor93.2, 4
  %add.ptr97.2 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx.2
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.2, align 16
  %q.sroa.10.32.add.ptr97.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.2, i32 8
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr97.2.sroa_idx, align 8
  %add90.3 = add nuw nsw i32 %shr89, 12
  %xor93.3 = xor i32 %add90.3, %and92
  %add.ptr97.idx.3 = shl nuw nsw i32 %xor93.3, 4
  %add.ptr97.3 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr97.idx.3
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr97.3, align 16
  %q.sroa.13.48.add.ptr97.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr97.3, i32 8
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr97.3.sroa_idx, align 8
  %32 = lshr i32 %2, 2
  %mul118 = and i32 %32, 252
  %add115 = add nuw nsw i32 %mul21, %mul118
  %cmp123.not = icmp ugt i32 %add115, %1
  %spec.select = select i1 %cmp123.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp123.not.1.not = icmp ult i32 %add115, %1
  %spec.select.1 = select i1 %cmp123.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add119.2 = or disjoint i32 %add115, 2
  %cmp123.not.2 = icmp ugt i32 %add119.2, %1
  %spec.select.2 = select i1 %cmp123.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add119.3 = or disjoint i32 %add115, 3
  %cmp123.not.3 = icmp ugt i32 %add119.3, %1
  %spec.select.3 = select i1 %cmp123.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add121.4 = add nuw nsw i32 %add115, 16
  %cmp123.not.4 = icmp ugt i32 %add121.4, %1
  %spec.select.4 = select i1 %cmp123.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add121.5 = add nuw nsw i32 %add115, 17
  %cmp123.not.5 = icmp ugt i32 %add121.5, %1
  %spec.select.5 = select i1 %cmp123.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1
  %add121.6 = add nuw nsw i32 %add115, 18
  %cmp123.not.6 = icmp ugt i32 %add121.6, %1
  %spec.select.6 = select i1 %cmp123.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2
  %add121.7 = add nuw nsw i32 %add115, 19
  %cmp123.not.7 = icmp ugt i32 %add121.7, %1
  %spec.select.7 = select i1 %cmp123.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !78
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !78
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %33), !call_argsrelate !78
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %34), !call_argsrelate !78
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %35), !call_argsrelate !78
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %36), !call_argsrelate !78
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %37), !call_argsrelate !78
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %38), !call_argsrelate !78
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %39), !call_argsrelate !78
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %40), !call_argsrelate !78
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %41), !call_argsrelate !78
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %42), !call_argsrelate !78
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %43), !call_argsrelate !78
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %44), !call_argsrelate !78
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %45), !call_argsrelate !78
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %46), !call_argsrelate !78
  %invariant.gep542 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192
  %49 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep542, i64 %add33
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %49, align 16
  %v.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %49, i64 8
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0..sroa_idx, align 8
  %gep543.1 = getelementptr i8, ptr addrspace(4) %49, i64 1024
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep543.1, align 16
  %v.sroa.7.16.gep543.1.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 1032
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.gep543.1.sroa_idx, align 8
  %gep543.2 = getelementptr i8, ptr addrspace(4) %49, i64 2048
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep543.2, align 16
  %v.sroa.10.32.gep543.2.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 2056
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.gep543.2.sroa_idx, align 8
  %gep543.3 = getelementptr i8, ptr addrspace(4) %49, i64 3072
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep543.3, align 16
  %v.sroa.13.48.gep543.3.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 3080
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.gep543.3.sroa_idx, align 8
  %gep543.4 = getelementptr i8, ptr addrspace(4) %49, i64 4096
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep543.4, align 16
  %v.sroa.16.64.gep543.4.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 4104
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.gep543.4.sroa_idx, align 8
  %gep543.5 = getelementptr i8, ptr addrspace(4) %49, i64 5120
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep543.5, align 16
  %v.sroa.19.80.gep543.5.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 5128
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.gep543.5.sroa_idx, align 8
  %gep543.6 = getelementptr i8, ptr addrspace(4) %49, i64 6144
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep543.6, align 16
  %v.sroa.22.96.gep543.6.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 6152
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.gep543.6.sroa_idx, align 8
  %gep543.7 = getelementptr i8, ptr addrspace(4) %49, i64 7168
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep543.7, align 16
  %v.sroa.25.112.gep543.7.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 7176
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.gep543.7.sroa_idx, align 8
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %47, i64 0
  %mul203 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul203, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %50, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i523 = fadd contract float %50, %cond.i.i
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i523)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %51
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %47, i64 1
  %mul203.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul203.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %52, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i523.1 = fadd contract float %52, %cond.i.i.1
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i523.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %53
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %47, i64 2
  %mul203.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul203.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %54, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i523.2 = fadd contract float %54, %cond.i.i.2
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i523.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %55
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %47, i64 3
  %mul203.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul203.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %56, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i523.3 = fadd contract float %56, %cond.i.i.3
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i523.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %57
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %48, i64 0
  %mul203.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul203.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %58, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i523.4 = fadd contract float %58, %cond.i.i.4
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i523.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %59
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %48, i64 1
  %mul203.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul203.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %60, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i523.5 = fadd contract float %60, %cond.i.i.5
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i523.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %61
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %48, i64 2
  %mul203.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul203.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %62, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i523.6 = fadd contract float %62, %cond.i.i.6
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i523.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %63
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %48, i64 3
  %mul203.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul203.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %64, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i523.7 = fadd contract float %64, %cond.i.i.7
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i523.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %65
  %add223 = fadd contract float %mul.i.i, 0.000000e+00
  %add223.1 = fadd contract float %add223, %mul.i.i.4
  %add223.2 = fadd contract float %add223.1, %mul.i.i.1
  %add223.3 = fadd contract float %add223.2, %mul.i.i.5
  %add223.4 = fadd contract float %add223.3, %mul.i.i.2
  %add223.5 = fadd contract float %add223.4, %mul.i.i.6
  %add223.6 = fadd contract float %add223.5, %mul.i.i.3
  %add223.7 = fadd contract float %add223.6, %mul.i.i.7
  %66 = bitcast float %add223.7 to i32
  %67 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %68 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %67) #11
  %xor.i.i = xor i32 %68, 32
  %69 = and i32 %68, -64
  %and.i.i = add nsw i32 %69, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i524 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %68
  %shl.i.i = shl i32 %cond.i.i524, 2
  %70 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %66)
  %71 = bitcast i32 %70 to float
  %add.i = fadd contract float %add223.7, %71
  %72 = bitcast float %add.i to i32
  %73 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %74 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %73) #11
  %xor.i.i525 = xor i32 %74, 16
  %75 = and i32 %74, -64
  %and.i.i526 = add nsw i32 %75, 64
  %cmp.not.i.i527 = icmp slt i32 %xor.i.i525, %and.i.i526
  %cond.i.i528 = select i1 %cmp.not.i.i527, i32 %xor.i.i525, i32 %74
  %shl.i.i529 = shl i32 %cond.i.i528, 2
  %76 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i529, i32 %72)
  %77 = bitcast i32 %76 to float
  %add.i.i = fadd contract float %add.i, %77
  %cmp232 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %78 = tail call contract noundef float @llvm.log2.f32(float %add.i.i)
  %mul237 = fmul contract float %78, 0xBFE62E4300000000
  %79 = tail call contract noundef float @llvm.exp.f32(float %mul237)
  %condval_1.0 = select i1 %cmp232, float %79, float 0.000000e+00
  %mul249 = fmul contract float %condval_1.0, %mul.i.i
  %mul249.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul249.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul249.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %mul249.4 = fmul contract float %condval_1.0, %mul.i.i.4
  %mul249.5 = fmul contract float %condval_1.0, %mul.i.i.5
  %mul249.6 = fmul contract float %condval_1.0, %mul.i.i.6
  %mul249.7 = fmul contract float %condval_1.0, %mul.i.i.7
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249)
  %81 = insertelement <4 x i16> poison, i16 %80, i64 0
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249.1)
  %83 = insertelement <4 x i16> %81, i16 %82, i64 1
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249.2)
  %85 = insertelement <4 x i16> %83, i16 %84, i64 2
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249.3)
  %87 = insertelement <4 x i16> %85, i16 %86, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %87 to <4 x half>
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249.4)
  %89 = insertelement <4 x i16> poison, i16 %88, i64 0
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249.5)
  %91 = insertelement <4 x i16> %89, i16 %90, i64 1
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249.6)
  %93 = insertelement <4 x i16> %91, i16 %92, i64 2
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul249.7)
  %95 = insertelement <4 x i16> %93, i16 %94, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %95 to <4 x half>
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !78
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %96), !call_argsrelate !78
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %97), !call_argsrelate !78
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %98), !call_argsrelate !78
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %99), !call_argsrelate !78
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %100), !call_argsrelate !78
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %101), !call_argsrelate !78
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %102), !call_argsrelate !78
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %103), !call_argsrelate !78
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %104, i64 0
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %112 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %104, i64 1
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %113 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %104, i64 2
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %114 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert648 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %104, i64 3
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %115 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert648, %output_reg.sroa.0.6.insert.shift
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %105, i64 0
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.9.8.insert.ext = zext i16 %116 to i64
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %105, i64 1
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.9.10.insert.ext = zext i16 %117 to i64
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %105, i64 2
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.9.12.insert.ext = zext i16 %118 to i64
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32
  %output_reg.sroa.9.12.insert.insert654 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %105, i64 3
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.9.14.insert.ext = zext i16 %119 to i64
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert654, %output_reg.sroa.9.14.insert.shift
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %106, i64 0
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.16.16.insert.ext = zext i16 %120 to i64
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %106, i64 1
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.16.18.insert.ext = zext i16 %121 to i64
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %106, i64 2
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.16.20.insert.ext = zext i16 %122 to i64
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32
  %output_reg.sroa.16.20.insert.insert660 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %106, i64 3
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.16.22.insert.ext = zext i16 %123 to i64
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert660, %output_reg.sroa.16.22.insert.shift
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %107, i64 0
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.23.24.insert.ext = zext i16 %124 to i64
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %107, i64 1
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.23.26.insert.ext = zext i16 %125 to i64
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %107, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.23.28.insert.ext = zext i16 %126 to i64
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32
  %output_reg.sroa.23.28.insert.insert666 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %107, i64 3
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.23.30.insert.ext = zext i16 %127 to i64
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert666, %output_reg.sroa.23.30.insert.shift
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %108, i64 0
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.30.32.insert.ext = zext i16 %128 to i64
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %108, i64 1
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.30.34.insert.ext = zext i16 %129 to i64
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %108, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.30.36.insert.ext = zext i16 %130 to i64
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32
  %output_reg.sroa.30.36.insert.insert672 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %108, i64 3
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.30.38.insert.ext = zext i16 %131 to i64
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert672, %output_reg.sroa.30.38.insert.shift
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %109, i64 0
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.37.40.insert.ext = zext i16 %132 to i64
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %109, i64 1
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.37.42.insert.ext = zext i16 %133 to i64
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %109, i64 2
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.37.44.insert.ext = zext i16 %134 to i64
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32
  %output_reg.sroa.37.44.insert.insert678 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %109, i64 3
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.37.46.insert.ext = zext i16 %135 to i64
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert678, %output_reg.sroa.37.46.insert.shift
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %110, i64 0
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.44.48.insert.ext = zext i16 %136 to i64
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %110, i64 1
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.44.50.insert.ext = zext i16 %137 to i64
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %110, i64 2
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.44.52.insert.ext = zext i16 %138 to i64
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32
  %output_reg.sroa.44.52.insert.insert684 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %110, i64 3
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.44.54.insert.ext = zext i16 %139 to i64
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert684, %output_reg.sroa.44.54.insert.shift
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %111, i64 0
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.51.56.insert.ext = zext i16 %140 to i64
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %111, i64 1
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.51.58.insert.ext = zext i16 %141 to i64
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %111, i64 2
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.51.60.insert.ext = zext i16 %142 to i64
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32
  %output_reg.sroa.51.60.insert.insert690 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %111, i64 3
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.51.62.insert.ext = zext i16 %143 to i64
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert690, %output_reg.sroa.51.62.insert.shift
  br label %if.end363

if.else341:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre797 = and i32 %.pre, 1920
  %.pre798 = lshr i32 %2, 5
  %.pre799 = and i32 %2, 15
  %.pre800 = lshr i32 %2, 2
  %.pre801 = add nuw nsw i32 %.pre798, 2
  %.pre802 = add nuw nsw i32 %.pre798, 4
  %.pre803 = add nuw nsw i32 %.pre798, 6
  %.pre804 = add nuw nsw i32 %.pre798, 8
  %.pre805 = add nuw nsw i32 %.pre798, 10
  %.pre806 = add nuw nsw i32 %.pre798, 12
  %.pre807 = add nuw nsw i32 %.pre798, 14
  %.pre808 = shl nuw nsw i32 %2, 3
  %.pre810 = lshr i32 %2, 4
  %.pre811 = xor i32 %.pre810, %.pre799
  %.pre812 = shl nuw nsw i32 %.pre811, 4
  br label %if.end363

if.end363:                                        ; preds = %for.cond24.preheader, %if.else341
  %add.ptr413.idx.pre-phi = phi i32 [ %add.ptr97.idx, %for.cond24.preheader ], [ %.pre812, %if.else341 ]
  %shr407.pre-phi = phi i32 [ %shr89, %for.cond24.preheader ], [ %.pre810, %if.else341 ]
  %.pre-phi809 = phi i32 [ %21, %for.cond24.preheader ], [ %.pre808, %if.else341 ]
  %add378.7.pre-phi = phi i32 [ %add67.7, %for.cond24.preheader ], [ %.pre807, %if.else341 ]
  %add378.6.pre-phi = phi i32 [ %add67.6, %for.cond24.preheader ], [ %.pre806, %if.else341 ]
  %add378.5.pre-phi = phi i32 [ %add67.5, %for.cond24.preheader ], [ %.pre805, %if.else341 ]
  %add378.4.pre-phi = phi i32 [ %add67.4, %for.cond24.preheader ], [ %.pre804, %if.else341 ]
  %add378.3.pre-phi = phi i32 [ %add67.3, %for.cond24.preheader ], [ %.pre803, %if.else341 ]
  %add378.2.pre-phi = phi i32 [ %add67.2, %for.cond24.preheader ], [ %.pre802, %if.else341 ]
  %add378.1.pre-phi = phi i32 [ %add67.1, %for.cond24.preheader ], [ %.pre801, %if.else341 ]
  %.pre-phi = phi i32 [ %32, %for.cond24.preheader ], [ %.pre800, %if.else341 ]
  %and380.pre-phi = phi i32 [ %and92, %for.cond24.preheader ], [ %.pre799, %if.else341 ]
  %shr377.pre-phi = phi i32 [ %shr66, %for.cond24.preheader ], [ %.pre798, %if.else341 ]
  %mul374.pre-phi = phi i32 [ %mul86, %for.cond24.preheader ], [ %.pre797, %if.else341 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond24.preheader ], [ 0, %if.else341 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul387 = and i32 %.pre-phi, 4
  %xor381 = xor i32 %shr377.pre-phi, %and380.pre-phi
  %mul382 = shl nuw nsw i32 %xor381, 3
  %add383 = add nuw nsw i32 %mul382, %mul374.pre-phi
  %add388 = or disjoint i32 %add383, %mul387
  %add.ptr390 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr390, align 8
  %xor381.1 = xor i32 %add378.1.pre-phi, %and380.pre-phi
  %mul382.1 = shl nuw nsw i32 %xor381.1, 3
  %add383.1 = add nuw nsw i32 %mul382.1, %mul374.pre-phi
  %add388.1 = or disjoint i32 %add383.1, %mul387
  %add.ptr390.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr390.1, align 8
  %xor381.2 = xor i32 %add378.2.pre-phi, %and380.pre-phi
  %mul382.2 = shl nuw nsw i32 %xor381.2, 3
  %add383.2 = add nuw nsw i32 %mul382.2, %mul374.pre-phi
  %add388.2 = or disjoint i32 %add383.2, %mul387
  %add.ptr390.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr390.2, align 8
  %xor381.3 = xor i32 %add378.3.pre-phi, %and380.pre-phi
  %mul382.3 = shl nuw nsw i32 %xor381.3, 3
  %add383.3 = add nuw nsw i32 %mul382.3, %mul374.pre-phi
  %add388.3 = or disjoint i32 %add383.3, %mul387
  %add.ptr390.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr390.3, align 8
  %xor381.4 = xor i32 %add378.4.pre-phi, %and380.pre-phi
  %mul382.4 = shl nuw nsw i32 %xor381.4, 3
  %add383.4 = add nuw nsw i32 %mul382.4, %mul374.pre-phi
  %add388.4 = or disjoint i32 %add383.4, %mul387
  %add.ptr390.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.4
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr390.4, align 8
  %xor381.5 = xor i32 %add378.5.pre-phi, %and380.pre-phi
  %mul382.5 = shl nuw nsw i32 %xor381.5, 3
  %add383.5 = add nuw nsw i32 %mul382.5, %mul374.pre-phi
  %add388.5 = or disjoint i32 %add383.5, %mul387
  %add.ptr390.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.5
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr390.5, align 8
  %xor381.6 = xor i32 %add378.6.pre-phi, %and380.pre-phi
  %mul382.6 = shl nuw nsw i32 %xor381.6, 3
  %add383.6 = add nuw nsw i32 %mul382.6, %mul374.pre-phi
  %add388.6 = or disjoint i32 %add383.6, %mul387
  %add.ptr390.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.6
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr390.6, align 8
  %xor381.7 = xor i32 %add378.7.pre-phi, %and380.pre-phi
  %mul382.7 = shl nuw nsw i32 %xor381.7, 3
  %add383.7 = add nuw nsw i32 %mul382.7, %mul374.pre-phi
  %add388.7 = or disjoint i32 %add383.7, %mul387
  %add.ptr390.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.7
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr390.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul401 = and i32 %.pre-phi809, 8064
  %invariant.gep558 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul401
  %add420 = add nuw nsw i32 %add, %.pre-phi809
  %144 = zext nneg i32 %add420 to i64
  %add.ptr413 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep558, i32 %add.ptr413.idx.pre-phi
  %add.ptr425 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %144
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr425, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr413, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  %145 = add nuw nsw i32 %shr407.pre-phi, 4
  %xor409.1 = xor i32 %145, %and380.pre-phi
  %gep559.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep558, i32 1024
  %add.ptr413.idx.1 = shl nuw nsw i32 %xor409.1, 4
  %add.ptr413.1 = getelementptr inbounds i8, ptr addrspace(3) %gep559.1, i32 %add.ptr413.idx.1
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %144
  %add.ptr425.1 = getelementptr inbounds i8, ptr addrspace(1) %146, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr425.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr413.1, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  %147 = add nuw nsw i32 %shr407.pre-phi, 8
  %xor409.2 = xor i32 %147, %and380.pre-phi
  %gep559.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep558, i32 2048
  %add.ptr413.idx.2 = shl nuw nsw i32 %xor409.2, 4
  %add.ptr413.2 = getelementptr inbounds i8, ptr addrspace(3) %gep559.2, i32 %add.ptr413.idx.2
  %148 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %144
  %add.ptr425.2 = getelementptr inbounds i8, ptr addrspace(1) %148, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr425.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr413.2, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  %narrow = add nuw nsw i32 %shr407.pre-phi, 12
  %xor409.3 = xor i32 %narrow, %and380.pre-phi
  %gep559.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep558, i32 3072
  %add.ptr413.idx.3 = shl nuw nsw i32 %xor409.3, 4
  %add.ptr413.3 = getelementptr inbounds i8, ptr addrspace(3) %gep559.3, i32 %add.ptr413.idx.3
  %149 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %144
  %add.ptr425.3 = getelementptr inbounds i8, ptr addrspace(1) %149, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr425.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr413.3, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp.f32(float) #7

declare float @llvm.log2.f32(float) #7

declare i16 @llvm.convert.to.fp16.f32(float) #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.exp2.f32(float) #7

declare float @llvm.minnum.f32(float, float) #7

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

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
attributes #11 = { nomerge }


