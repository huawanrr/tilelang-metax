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
  %arrayidx.val = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %or.cond = icmp ult i32 %arrayidx.val, 32
  br i1 %or.cond, label %land.rhs, label %if.else347

land.rhs:                                         ; preds = %entry
  %mul22 = shl nuw nsw i32 %arrayidx.val, 5
  %cmp24.not = icmp ugt i32 %mul22, %1
  br i1 %cmp24.not, label %if.else347, label %for.cond25.preheader

for.cond25.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul31 = shl nuw nsw i64 %conv, 18
  %19 = shl nuw nsw i32 %arrayidx.val, 13
  %mul33 = zext nneg i32 %19 to i64
  %20 = shl nuw nsw i32 %2, 3
  %mul40 = zext nneg i32 %20 to i64
  %add34 = or disjoint i64 %mul31, %mul40
  %add37 = or disjoint i64 %add34, %mul33
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add37
  %22 = load <4 x half>, ptr addrspace(4) %21, align 2, !tbaa !56
  %add41.4 = or disjoint i64 %add37, 4
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add41.4
  %24 = load <4 x half>, ptr addrspace(4) %23, align 2, !tbaa !56
  %arrayidx44.8 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 1024
  %25 = load <4 x half>, ptr addrspace(4) %arrayidx44.8, align 2, !tbaa !56
  %arrayidx44.12 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1024
  %26 = load <4 x half>, ptr addrspace(4) %arrayidx44.12, align 2, !tbaa !56
  %arrayidx44.16 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 2048
  %27 = load <4 x half>, ptr addrspace(4) %arrayidx44.16, align 2, !tbaa !56
  %arrayidx44.20 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2048
  %28 = load <4 x half>, ptr addrspace(4) %arrayidx44.20, align 2, !tbaa !56
  %arrayidx44.24 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 3072
  %29 = load <4 x half>, ptr addrspace(4) %arrayidx44.24, align 2, !tbaa !56
  %arrayidx44.28 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 3072
  %30 = load <4 x half>, ptr addrspace(4) %arrayidx44.28, align 2, !tbaa !56
  %arrayidx44.32 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 4096
  %31 = load <4 x half>, ptr addrspace(4) %arrayidx44.32, align 2, !tbaa !56
  %arrayidx44.36 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 4096
  %32 = load <4 x half>, ptr addrspace(4) %arrayidx44.36, align 2, !tbaa !56
  %arrayidx44.40 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 5120
  %33 = load <4 x half>, ptr addrspace(4) %arrayidx44.40, align 2, !tbaa !56
  %arrayidx44.44 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 5120
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx44.44, align 2, !tbaa !56
  %arrayidx44.48 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 6144
  %35 = load <4 x half>, ptr addrspace(4) %arrayidx44.48, align 2, !tbaa !56
  %arrayidx44.52 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 6144
  %36 = load <4 x half>, ptr addrspace(4) %arrayidx44.52, align 2, !tbaa !56
  %arrayidx44.56 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 7168
  %37 = load <4 x half>, ptr addrspace(4) %arrayidx44.56, align 2, !tbaa !56
  %arrayidx44.60 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 7168
  %38 = load <4 x half>, ptr addrspace(4) %arrayidx44.60, align 2, !tbaa !56
  %and66 = lshr i32 %2, 1
  %shr67 = and i32 %and66, 15
  %shr70 = lshr i32 %2, 5
  %add64 = and i32 %mul10, 3972
  %xor = xor i32 %shr70, %shr67
  %39 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add64
  %add.ptr79.idx = shl nuw nsw i32 %xor, 4
  %add.ptr79 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %add.ptr79.idx
  store i64 %4, ptr addrspace(3) %add.ptr79, align 8
  %add71.1 = add nuw nsw i32 %shr70, 2
  %xor.1 = xor i32 %add71.1, %shr67
  %40 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 512
  %add.ptr79.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr79.1 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr79.idx.1
  store i64 %6, ptr addrspace(3) %add.ptr79.1, align 8
  %add71.2 = add nuw nsw i32 %shr70, 4
  %xor.2 = xor i32 %add71.2, %shr67
  %41 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 1024
  %add.ptr79.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr79.2 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %add.ptr79.idx.2
  store i64 %8, ptr addrspace(3) %add.ptr79.2, align 8
  %add71.3 = add nuw nsw i32 %shr70, 6
  %xor.3 = xor i32 %add71.3, %shr67
  %42 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 1536
  %add.ptr79.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr79.3 = getelementptr inbounds i8, ptr addrspace(3) %42, i32 %add.ptr79.idx.3
  store i64 %10, ptr addrspace(3) %add.ptr79.3, align 8
  %add71.4 = add nuw nsw i32 %shr70, 8
  %xor.4 = xor i32 %add71.4, %shr67
  %43 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 2048
  %add.ptr79.idx.4 = shl nuw nsw i32 %xor.4, 4
  %add.ptr79.4 = getelementptr inbounds i8, ptr addrspace(3) %43, i32 %add.ptr79.idx.4
  store i64 %12, ptr addrspace(3) %add.ptr79.4, align 8
  %add71.5 = add nuw nsw i32 %shr70, 10
  %xor.5 = xor i32 %add71.5, %shr67
  %44 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 2560
  %add.ptr79.idx.5 = shl nuw nsw i32 %xor.5, 4
  %add.ptr79.5 = getelementptr inbounds i8, ptr addrspace(3) %44, i32 %add.ptr79.idx.5
  store i64 %14, ptr addrspace(3) %add.ptr79.5, align 8
  %add71.6 = add nuw nsw i32 %shr70, 12
  %xor.6 = xor i32 %add71.6, %shr67
  %45 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 3072
  %add.ptr79.idx.6 = shl nuw nsw i32 %xor.6, 4
  %add.ptr79.6 = getelementptr inbounds i8, ptr addrspace(3) %45, i32 %add.ptr79.idx.6
  store i64 %16, ptr addrspace(3) %add.ptr79.6, align 8
  %add71.7 = add nuw nsw i32 %shr70, 14
  %xor.7 = xor i32 %add71.7, %shr67
  %46 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 3584
  %add.ptr79.idx.7 = shl nuw nsw i32 %xor.7, 4
  %add.ptr79.7 = getelementptr inbounds i8, ptr addrspace(3) %46, i32 %add.ptr79.idx.7
  store i64 %18, ptr addrspace(3) %add.ptr79.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and89 = shl nuw nsw i32 %2, 7
  %mul90 = and i32 %and89, 1920
  %shr93 = lshr i32 %2, 4
  %and96 = and i32 %2, 15
  %47 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul90
  %xor97 = xor i32 %shr93, %and96
  %add.ptr101.idx = shl nuw nsw i32 %xor97, 4
  %add.ptr101 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101, align 16
  %q.sroa.4.0.add.ptr101.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101, i32 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr101.sroa_idx, align 8
  %add94.1 = add nuw nsw i32 %shr93, 4
  %xor97.1 = xor i32 %add94.1, %and96
  %add.ptr101.idx.1 = shl nuw nsw i32 %xor97.1, 4
  %add.ptr101.1 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx.1
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101.1, align 16
  %q.sroa.7.16.add.ptr101.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101.1, i32 8
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr101.1.sroa_idx, align 8
  %add94.2 = add nuw nsw i32 %shr93, 8
  %xor97.2 = xor i32 %add94.2, %and96
  %add.ptr101.idx.2 = shl nuw nsw i32 %xor97.2, 4
  %add.ptr101.2 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx.2
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101.2, align 16
  %q.sroa.10.32.add.ptr101.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101.2, i32 8
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr101.2.sroa_idx, align 8
  %add94.3 = add nuw nsw i32 %shr93, 12
  %xor97.3 = xor i32 %add94.3, %and96
  %add.ptr101.idx.3 = shl nuw nsw i32 %xor97.3, 4
  %add.ptr101.3 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx.3
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101.3, align 16
  %q.sroa.13.48.add.ptr101.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101.3, i32 8
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr101.3.sroa_idx, align 8
  %48 = lshr i32 %2, 2
  %mul122 = and i32 %48, 252
  %add119 = add nuw nsw i32 %mul22, %mul122
  %cmp127.not = icmp ugt i32 %add119, %1
  %spec.select = select i1 %cmp127.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp127.not.1.not = icmp ult i32 %add119, %1
  %spec.select.1 = select i1 %cmp127.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add123.2 = or disjoint i32 %add119, 2
  %cmp127.not.2 = icmp ugt i32 %add123.2, %1
  %spec.select.2 = select i1 %cmp127.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add123.3 = or disjoint i32 %add119, 3
  %cmp127.not.3 = icmp ugt i32 %add123.3, %1
  %spec.select.3 = select i1 %cmp127.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add125.4 = add nuw nsw i32 %add119, 16
  %cmp127.not.4 = icmp ugt i32 %add125.4, %1
  %spec.select.4 = select i1 %cmp127.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add125.5 = add nuw nsw i32 %add119, 17
  %cmp127.not.5 = icmp ugt i32 %add125.5, %1
  %spec.select.5 = select i1 %cmp127.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1
  %add125.6 = add nuw nsw i32 %add119, 18
  %cmp127.not.6 = icmp ugt i32 %add125.6, %1
  %spec.select.6 = select i1 %cmp127.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2
  %add125.7 = add nuw nsw i32 %add119, 19
  %cmp127.not.7 = icmp ugt i32 %add125.7, %1
  %spec.select.7 = select i1 %cmp127.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %22, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !80
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %25, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !80
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %24, <4 x half> %q.sroa.4.0.copyload, <4 x float> %49), !call_argsrelate !80
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %q.sroa.4.0.copyload, <4 x float> %50), !call_argsrelate !80
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %q.sroa.5.16.copyload, <4 x float> %51), !call_argsrelate !80
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %q.sroa.5.16.copyload, <4 x float> %52), !call_argsrelate !80
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %q.sroa.7.16.copyload, <4 x float> %53), !call_argsrelate !80
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %q.sroa.7.16.copyload, <4 x float> %54), !call_argsrelate !80
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %q.sroa.8.32.copyload, <4 x float> %55), !call_argsrelate !80
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %q.sroa.8.32.copyload, <4 x float> %56), !call_argsrelate !80
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %32, <4 x half> %q.sroa.10.32.copyload, <4 x float> %57), !call_argsrelate !80
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %q.sroa.10.32.copyload, <4 x float> %58), !call_argsrelate !80
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %q.sroa.11.48.copyload, <4 x float> %59), !call_argsrelate !80
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %37, <4 x half> %q.sroa.11.48.copyload, <4 x float> %60), !call_argsrelate !80
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %q.sroa.13.48.copyload, <4 x float> %61), !call_argsrelate !80
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %38, <4 x half> %q.sroa.13.48.copyload, <4 x float> %62), !call_argsrelate !80
  %invariant.gep = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
  %65 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add37
  %66 = load <4 x half>, ptr addrspace(4) %65, align 2, !tbaa !56
  %67 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add41.4
  %68 = load <4 x half>, ptr addrspace(4) %67, align 2, !tbaa !56
  %gep.8 = getelementptr i8, ptr addrspace(4) %65, i64 1024
  %69 = load <4 x half>, ptr addrspace(4) %gep.8, align 2, !tbaa !56
  %gep.12 = getelementptr i8, ptr addrspace(4) %67, i64 1024
  %70 = load <4 x half>, ptr addrspace(4) %gep.12, align 2, !tbaa !56
  %gep.16 = getelementptr i8, ptr addrspace(4) %65, i64 2048
  %71 = load <4 x half>, ptr addrspace(4) %gep.16, align 2, !tbaa !56
  %gep.20 = getelementptr i8, ptr addrspace(4) %67, i64 2048
  %72 = load <4 x half>, ptr addrspace(4) %gep.20, align 2, !tbaa !56
  %gep.24 = getelementptr i8, ptr addrspace(4) %65, i64 3072
  %73 = load <4 x half>, ptr addrspace(4) %gep.24, align 2, !tbaa !56
  %gep.28 = getelementptr i8, ptr addrspace(4) %67, i64 3072
  %74 = load <4 x half>, ptr addrspace(4) %gep.28, align 2, !tbaa !56
  %gep.32 = getelementptr i8, ptr addrspace(4) %65, i64 4096
  %75 = load <4 x half>, ptr addrspace(4) %gep.32, align 2, !tbaa !56
  %gep.36 = getelementptr i8, ptr addrspace(4) %67, i64 4096
  %76 = load <4 x half>, ptr addrspace(4) %gep.36, align 2, !tbaa !56
  %gep.40 = getelementptr i8, ptr addrspace(4) %65, i64 5120
  %77 = load <4 x half>, ptr addrspace(4) %gep.40, align 2, !tbaa !56
  %gep.44 = getelementptr i8, ptr addrspace(4) %67, i64 5120
  %78 = load <4 x half>, ptr addrspace(4) %gep.44, align 2, !tbaa !56
  %gep.48 = getelementptr i8, ptr addrspace(4) %65, i64 6144
  %79 = load <4 x half>, ptr addrspace(4) %gep.48, align 2, !tbaa !56
  %gep.52 = getelementptr i8, ptr addrspace(4) %67, i64 6144
  %80 = load <4 x half>, ptr addrspace(4) %gep.52, align 2, !tbaa !56
  %gep.56 = getelementptr i8, ptr addrspace(4) %65, i64 7168
  %81 = load <4 x half>, ptr addrspace(4) %gep.56, align 2, !tbaa !56
  %gep.60 = getelementptr i8, ptr addrspace(4) %67, i64 7168
  %82 = load <4 x half>, ptr addrspace(4) %gep.60, align 2, !tbaa !56
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %63, i64 0
  %mul212 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %83 = tail call contract noundef float @llvm.minnum.f32(float %mul212, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %83, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i532 = fadd contract float %83, %cond.i.i
  %84 = tail call contract float @llvm.exp2.f32(float %add.i.i532)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %84
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %63, i64 1
  %mul212.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %85 = tail call contract noundef float @llvm.minnum.f32(float %mul212.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %85, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i532.1 = fadd contract float %85, %cond.i.i.1
  %86 = tail call contract float @llvm.exp2.f32(float %add.i.i532.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %86
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %63, i64 2
  %mul212.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %87 = tail call contract noundef float @llvm.minnum.f32(float %mul212.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %87, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i532.2 = fadd contract float %87, %cond.i.i.2
  %88 = tail call contract float @llvm.exp2.f32(float %add.i.i532.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %88
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %63, i64 3
  %mul212.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %89 = tail call contract noundef float @llvm.minnum.f32(float %mul212.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %89, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i532.3 = fadd contract float %89, %cond.i.i.3
  %90 = tail call contract float @llvm.exp2.f32(float %add.i.i532.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %90
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %64, i64 0
  %mul212.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %91 = tail call contract noundef float @llvm.minnum.f32(float %mul212.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %91, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i532.4 = fadd contract float %91, %cond.i.i.4
  %92 = tail call contract float @llvm.exp2.f32(float %add.i.i532.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %92
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %64, i64 1
  %mul212.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %93 = tail call contract noundef float @llvm.minnum.f32(float %mul212.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %93, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i532.5 = fadd contract float %93, %cond.i.i.5
  %94 = tail call contract float @llvm.exp2.f32(float %add.i.i532.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %94
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %64, i64 2
  %mul212.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %95 = tail call contract noundef float @llvm.minnum.f32(float %mul212.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %95, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i532.6 = fadd contract float %95, %cond.i.i.6
  %96 = tail call contract float @llvm.exp2.f32(float %add.i.i532.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %96
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %64, i64 3
  %mul212.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %97 = tail call contract noundef float @llvm.minnum.f32(float %mul212.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %97, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i532.7 = fadd contract float %97, %cond.i.i.7
  %98 = tail call contract float @llvm.exp2.f32(float %add.i.i532.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %98
  %add232 = fadd contract float %mul.i.i, 0.000000e+00
  %add232.1 = fadd contract float %add232, %mul.i.i.4
  %add232.2 = fadd contract float %add232.1, %mul.i.i.1
  %add232.3 = fadd contract float %add232.2, %mul.i.i.5
  %add232.4 = fadd contract float %add232.3, %mul.i.i.2
  %add232.5 = fadd contract float %add232.4, %mul.i.i.6
  %add232.6 = fadd contract float %add232.5, %mul.i.i.3
  %add232.7 = fadd contract float %add232.6, %mul.i.i.7
  %99 = bitcast float %add232.7 to i32
  %100 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %101 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %100) #11
  %xor.i.i = xor i32 %101, 32
  %102 = and i32 %101, -64
  %and.i.i = add nsw i32 %102, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i533 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %101
  %shl.i.i = shl i32 %cond.i.i533, 2
  %103 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %99)
  %104 = bitcast i32 %103 to float
  %add.i = fadd contract float %add232.7, %104
  %105 = bitcast float %add.i to i32
  %106 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %107 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %106) #11
  %xor.i.i534 = xor i32 %107, 16
  %108 = and i32 %107, -64
  %and.i.i535 = add nsw i32 %108, 64
  %cmp.not.i.i536 = icmp slt i32 %xor.i.i534, %and.i.i535
  %cond.i.i537 = select i1 %cmp.not.i.i536, i32 %xor.i.i534, i32 %107
  %shl.i.i538 = shl i32 %cond.i.i537, 2
  %109 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i538, i32 %105)
  %110 = bitcast i32 %109 to float
  %add.i.i = fadd contract float %add.i, %110
  %cmp241 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_1.0 = select i1 %cmp241, float %div, float 0.000000e+00
  %mul254 = fmul contract float %condval_1.0, %mul.i.i
  %mul254.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul254.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul254.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %mul254.4 = fmul contract float %condval_1.0, %mul.i.i.4
  %mul254.5 = fmul contract float %condval_1.0, %mul.i.i.5
  %mul254.6 = fmul contract float %condval_1.0, %mul.i.i.6
  %mul254.7 = fmul contract float %condval_1.0, %mul.i.i.7
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254)
  %112 = insertelement <4 x i16> poison, i16 %111, i64 0
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.1)
  %114 = insertelement <4 x i16> %112, i16 %113, i64 1
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.2)
  %116 = insertelement <4 x i16> %114, i16 %115, i64 2
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.3)
  %118 = insertelement <4 x i16> %116, i16 %117, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %118 to <4 x half>
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.4)
  %120 = insertelement <4 x i16> poison, i16 %119, i64 0
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.5)
  %122 = insertelement <4 x i16> %120, i16 %121, i64 1
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.6)
  %124 = insertelement <4 x i16> %122, i16 %123, i64 2
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.7)
  %126 = insertelement <4 x i16> %124, i16 %125, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %126 to <4 x half>
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %70, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %71, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %127), !call_argsrelate !80
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %128), !call_argsrelate !80
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %129), !call_argsrelate !80
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %78, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %130), !call_argsrelate !80
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %79, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %131), !call_argsrelate !80
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %132), !call_argsrelate !80
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %81, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %133), !call_argsrelate !80
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %82, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %134), !call_argsrelate !80
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %135, i64 0
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %143 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %135, i64 1
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %144 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %135, i64 2
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %145 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert651 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %135, i64 3
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %146 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert651, %output_reg.sroa.0.6.insert.shift
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %136, i64 0
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.9.8.insert.ext = zext i16 %147 to i64
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %136, i64 1
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.9.10.insert.ext = zext i16 %148 to i64
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %136, i64 2
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.9.12.insert.ext = zext i16 %149 to i64
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32
  %output_reg.sroa.9.12.insert.insert657 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %136, i64 3
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.9.14.insert.ext = zext i16 %150 to i64
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert657, %output_reg.sroa.9.14.insert.shift
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %137, i64 0
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.16.16.insert.ext = zext i16 %151 to i64
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %137, i64 1
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.16.18.insert.ext = zext i16 %152 to i64
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %137, i64 2
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.16.20.insert.ext = zext i16 %153 to i64
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32
  %output_reg.sroa.16.20.insert.insert663 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %137, i64 3
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.16.22.insert.ext = zext i16 %154 to i64
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert663, %output_reg.sroa.16.22.insert.shift
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %138, i64 0
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.23.24.insert.ext = zext i16 %155 to i64
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %138, i64 1
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.23.26.insert.ext = zext i16 %156 to i64
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %138, i64 2
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.23.28.insert.ext = zext i16 %157 to i64
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32
  %output_reg.sroa.23.28.insert.insert669 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %138, i64 3
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.23.30.insert.ext = zext i16 %158 to i64
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert669, %output_reg.sroa.23.30.insert.shift
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %139, i64 0
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.30.32.insert.ext = zext i16 %159 to i64
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %139, i64 1
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.30.34.insert.ext = zext i16 %160 to i64
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %139, i64 2
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.30.36.insert.ext = zext i16 %161 to i64
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32
  %output_reg.sroa.30.36.insert.insert675 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %139, i64 3
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.30.38.insert.ext = zext i16 %162 to i64
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert675, %output_reg.sroa.30.38.insert.shift
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %140, i64 0
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.37.40.insert.ext = zext i16 %163 to i64
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %140, i64 1
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.37.42.insert.ext = zext i16 %164 to i64
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %140, i64 2
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.37.44.insert.ext = zext i16 %165 to i64
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32
  %output_reg.sroa.37.44.insert.insert681 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %140, i64 3
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.37.46.insert.ext = zext i16 %166 to i64
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert681, %output_reg.sroa.37.46.insert.shift
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %141, i64 0
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.44.48.insert.ext = zext i16 %167 to i64
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %141, i64 1
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.44.50.insert.ext = zext i16 %168 to i64
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %141, i64 2
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.44.52.insert.ext = zext i16 %169 to i64
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32
  %output_reg.sroa.44.52.insert.insert687 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %141, i64 3
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.44.54.insert.ext = zext i16 %170 to i64
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert687, %output_reg.sroa.44.54.insert.shift
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %142, i64 0
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.51.56.insert.ext = zext i16 %171 to i64
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %142, i64 1
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.51.58.insert.ext = zext i16 %172 to i64
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %142, i64 2
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.51.60.insert.ext = zext i16 %173 to i64
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32
  %output_reg.sroa.51.60.insert.insert693 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %142, i64 3
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.51.62.insert.ext = zext i16 %174 to i64
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert693, %output_reg.sroa.51.62.insert.shift
  br label %if.end370

if.else347:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre832 = and i32 %.pre, 1920
  %.pre833 = lshr i32 %2, 5
  %.pre834 = and i32 %2, 15
  %.pre835 = lshr i32 %2, 2
  %.pre836 = add nuw nsw i32 %.pre833, 2
  %.pre837 = add nuw nsw i32 %.pre833, 4
  %.pre838 = add nuw nsw i32 %.pre833, 6
  %.pre839 = add nuw nsw i32 %.pre833, 8
  %.pre840 = add nuw nsw i32 %.pre833, 10
  %.pre841 = add nuw nsw i32 %.pre833, 12
  %.pre842 = add nuw nsw i32 %.pre833, 14
  %.pre843 = shl nuw nsw i32 %2, 3
  %.pre845 = lshr i32 %2, 4
  %.pre846 = xor i32 %.pre845, %.pre834
  %.pre847 = shl nuw nsw i32 %.pre846, 4
  br label %if.end370

if.end370:                                        ; preds = %for.cond25.preheader, %if.else347
  %add.ptr420.idx.pre-phi = phi i32 [ %add.ptr101.idx, %for.cond25.preheader ], [ %.pre847, %if.else347 ]
  %shr414.pre-phi = phi i32 [ %shr93, %for.cond25.preheader ], [ %.pre845, %if.else347 ]
  %.pre-phi844 = phi i32 [ %20, %for.cond25.preheader ], [ %.pre843, %if.else347 ]
  %add385.7.pre-phi = phi i32 [ %add71.7, %for.cond25.preheader ], [ %.pre842, %if.else347 ]
  %add385.6.pre-phi = phi i32 [ %add71.6, %for.cond25.preheader ], [ %.pre841, %if.else347 ]
  %add385.5.pre-phi = phi i32 [ %add71.5, %for.cond25.preheader ], [ %.pre840, %if.else347 ]
  %add385.4.pre-phi = phi i32 [ %add71.4, %for.cond25.preheader ], [ %.pre839, %if.else347 ]
  %add385.3.pre-phi = phi i32 [ %add71.3, %for.cond25.preheader ], [ %.pre838, %if.else347 ]
  %add385.2.pre-phi = phi i32 [ %add71.2, %for.cond25.preheader ], [ %.pre837, %if.else347 ]
  %add385.1.pre-phi = phi i32 [ %add71.1, %for.cond25.preheader ], [ %.pre836, %if.else347 ]
  %.pre-phi = phi i32 [ %48, %for.cond25.preheader ], [ %.pre835, %if.else347 ]
  %and387.pre-phi = phi i32 [ %and96, %for.cond25.preheader ], [ %.pre834, %if.else347 ]
  %shr384.pre-phi = phi i32 [ %shr70, %for.cond25.preheader ], [ %.pre833, %if.else347 ]
  %mul381.pre-phi = phi i32 [ %mul90, %for.cond25.preheader ], [ %.pre832, %if.else347 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul394 = and i32 %.pre-phi, 4
  %xor388 = xor i32 %shr384.pre-phi, %and387.pre-phi
  %mul389 = shl nuw nsw i32 %xor388, 3
  %add390 = add nuw nsw i32 %mul389, %mul381.pre-phi
  %add395 = or disjoint i32 %add390, %mul394
  %add.ptr397 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr397, align 8
  %xor388.1 = xor i32 %add385.1.pre-phi, %and387.pre-phi
  %mul389.1 = shl nuw nsw i32 %xor388.1, 3
  %add390.1 = add nuw nsw i32 %mul389.1, %mul381.pre-phi
  %add395.1 = or disjoint i32 %add390.1, %mul394
  %add.ptr397.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.1
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr397.1, align 8
  %xor388.2 = xor i32 %add385.2.pre-phi, %and387.pre-phi
  %mul389.2 = shl nuw nsw i32 %xor388.2, 3
  %add390.2 = add nuw nsw i32 %mul389.2, %mul381.pre-phi
  %add395.2 = or disjoint i32 %add390.2, %mul394
  %add.ptr397.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.2
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr397.2, align 8
  %xor388.3 = xor i32 %add385.3.pre-phi, %and387.pre-phi
  %mul389.3 = shl nuw nsw i32 %xor388.3, 3
  %add390.3 = add nuw nsw i32 %mul389.3, %mul381.pre-phi
  %add395.3 = or disjoint i32 %add390.3, %mul394
  %add.ptr397.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.3
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr397.3, align 8
  %xor388.4 = xor i32 %add385.4.pre-phi, %and387.pre-phi
  %mul389.4 = shl nuw nsw i32 %xor388.4, 3
  %add390.4 = add nuw nsw i32 %mul389.4, %mul381.pre-phi
  %add395.4 = or disjoint i32 %add390.4, %mul394
  %add.ptr397.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.4
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr397.4, align 8
  %xor388.5 = xor i32 %add385.5.pre-phi, %and387.pre-phi
  %mul389.5 = shl nuw nsw i32 %xor388.5, 3
  %add390.5 = add nuw nsw i32 %mul389.5, %mul381.pre-phi
  %add395.5 = or disjoint i32 %add390.5, %mul394
  %add.ptr397.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.5
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr397.5, align 8
  %xor388.6 = xor i32 %add385.6.pre-phi, %and387.pre-phi
  %mul389.6 = shl nuw nsw i32 %xor388.6, 3
  %add390.6 = add nuw nsw i32 %mul389.6, %mul381.pre-phi
  %add395.6 = or disjoint i32 %add390.6, %mul394
  %add.ptr397.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.6
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr397.6, align 8
  %xor388.7 = xor i32 %add385.7.pre-phi, %and387.pre-phi
  %mul389.7 = shl nuw nsw i32 %xor388.7, 3
  %add390.7 = add nuw nsw i32 %mul389.7, %mul381.pre-phi
  %add395.7 = or disjoint i32 %add390.7, %mul394
  %add.ptr397.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.7
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr397.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul408 = and i32 %.pre-phi844, 8064
  %invariant.gep563 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul408
  %add427 = add nuw nsw i32 %add, %.pre-phi844
  %175 = zext nneg i32 %add427 to i64
  %add.ptr420 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 %add.ptr420.idx.pre-phi
  %add.ptr432 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420, i64 16, i1 false), !tbaa.struct !185, !call_argsrelate !186
  %176 = add nuw nsw i32 %shr414.pre-phi, 4
  %xor416.1 = xor i32 %176, %and387.pre-phi
  %gep564.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 1024
  %add.ptr420.idx.1 = shl nuw nsw i32 %xor416.1, 4
  %add.ptr420.1 = getelementptr inbounds i8, ptr addrspace(3) %gep564.1, i32 %add.ptr420.idx.1
  %177 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175
  %add.ptr432.1 = getelementptr inbounds i8, ptr addrspace(1) %177, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420.1, i64 16, i1 false), !tbaa.struct !185, !call_argsrelate !186
  %178 = add nuw nsw i32 %shr414.pre-phi, 8
  %xor416.2 = xor i32 %178, %and387.pre-phi
  %gep564.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 2048
  %add.ptr420.idx.2 = shl nuw nsw i32 %xor416.2, 4
  %add.ptr420.2 = getelementptr inbounds i8, ptr addrspace(3) %gep564.2, i32 %add.ptr420.idx.2
  %179 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175
  %add.ptr432.2 = getelementptr inbounds i8, ptr addrspace(1) %179, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420.2, i64 16, i1 false), !tbaa.struct !185, !call_argsrelate !186
  %narrow = add nuw nsw i32 %shr414.pre-phi, 12
  %xor416.3 = xor i32 %narrow, %and387.pre-phi
  %gep564.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 3072
  %add.ptr420.idx.3 = shl nuw nsw i32 %xor416.3, 4
  %add.ptr420.3 = getelementptr inbounds i8, ptr addrspace(3) %gep564.3, i32 %add.ptr420.idx.3
  %180 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175
  %add.ptr432.3 = getelementptr inbounds i8, ptr addrspace(1) %180, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420.3, i64 16, i1 false), !tbaa.struct !185, !call_argsrelate !186
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


