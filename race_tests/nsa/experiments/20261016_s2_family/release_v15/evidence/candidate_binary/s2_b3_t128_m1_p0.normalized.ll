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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 17
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 6
  %mul9 = and i32 %and, 960
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
  %mul25 = shl nsw i32 %0, 8
  %mul27 = shl nuw nsw i32 %1, 1
  %add28 = add nuw nsw i32 %mul25, %mul27
  %6 = zext nneg i32 %add28 to i64
  %arrayidx30 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx30, align 4, !tbaa !30
  %cmp32 = icmp ult i32 %7, 8
  %8 = shl nsw i32 %7, 4
  %mul33 = select i1 %cmp32, i32 %8, i32 -16
  %9 = or disjoint i64 %6, 1
  %arrayidx30.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %9
  %10 = load i32, ptr addrspace(1) %arrayidx30.1, align 4, !tbaa !30
  %cmp32.1 = icmp ult i32 %10, 8
  %11 = shl nsw i32 %10, 4
  %mul33.1 = select i1 %cmp32.1, i32 %11, i32 -16
  %shr68 = lshr i32 %2, 3
  %conv = zext nneg i32 %0 to i64
  %mul78 = shl nuw nsw i64 %conv, 13
  %12 = shl nuw nsw i32 %2, 3
  %13 = and i32 %12, 56
  %mul85 = zext nneg i32 %13 to i64
  %add64 = add nsw i32 %shr68, %mul33
  %or.cond = icmp ult i32 %add64, 128
  br i1 %or.cond, label %if.then76, label %if.then58.1

if.then76:                                        ; preds = %entry
  %14 = shl nuw nsw i32 %add64, 6
  %mul80 = zext nneg i32 %14 to i64
  %add81 = or disjoint i64 %mul78, %mul80
  %add86 = or disjoint i64 %add81, %mul85
  %add.ptr87 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr87, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87, i64 4
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87, i64 8
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87, i64 12
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx, align 4, !tbaa !30
  br label %if.then58.1

if.then58.1:                                      ; preds = %if.then76, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then76 ], [ 0, %entry ]
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then76 ], [ 0, %entry ]
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then76 ], [ 0, %entry ]
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then76 ], [ 0, %entry ]
  %add62.1 = add nuw nsw i32 %shr68, 8
  %add64.1 = add nsw i32 %add62.1, %mul33
  %or.cond.1 = icmp ult i32 %add64.1, 128
  br i1 %or.cond.1, label %if.then76.1, label %if.else65.2

if.then76.1:                                      ; preds = %if.then58.1
  %15 = shl nuw nsw i32 %add64.1, 6
  %mul80.1 = zext nneg i32 %15 to i64
  %add81.1 = or disjoint i64 %mul78, %mul80.1
  %add86.1 = or disjoint i64 %add81.1, %mul85
  %add.ptr87.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86.1
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr87.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.1, i64 4
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.1, i64 8
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.1, i64 12
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx.1, align 4, !tbaa !30
  br label %if.else65.2

if.else65.2:                                      ; preds = %if.then58.1, %if.then76.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ]
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ]
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ]
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then76.1 ], [ 0, %if.then58.1 ]
  %sub.2 = add i32 %shr68, %mul33.1
  %or.cond.2 = icmp ult i32 %sub.2, 128
  br i1 %or.cond.2, label %if.then76.2, label %if.else65.3

if.then76.2:                                      ; preds = %if.else65.2
  %16 = shl nuw nsw i32 %sub.2, 6
  %mul80.2 = zext nneg i32 %16 to i64
  %add81.2 = or disjoint i64 %mul78, %mul80.2
  %add86.2 = or disjoint i64 %add81.2, %mul85
  %add.ptr87.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86.2
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr87.2, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.2, i64 4
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx.2, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.2, i64 8
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx.2, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.2, i64 12
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx.2, align 4, !tbaa !30
  br label %if.else65.3

if.else65.3:                                      ; preds = %if.else65.2, %if.then76.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ]
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ]
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ]
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then76.2 ], [ 0, %if.else65.2 ]
  %add71.3 = add nuw nsw i32 %shr68, 8
  %sub.3 = add i32 %add71.3, %mul33.1
  %or.cond.3 = icmp ult i32 %sub.3, 128
  br i1 %or.cond.3, label %if.then76.3, label %if.then123

if.then76.3:                                      ; preds = %if.else65.3
  %17 = shl nuw nsw i32 %sub.3, 6
  %mul80.3 = zext nneg i32 %17 to i64
  %add81.3 = or disjoint i64 %mul78, %mul80.3
  %add86.3 = or disjoint i64 %add81.3, %mul85
  %add.ptr87.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add86.3
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr87.3, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr87.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.3, i64 4
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr87.sroa_idx.3, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr87.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.3, i64 8
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr87.sroa_idx.3, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr87.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr87.3, i64 12
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr87.sroa_idx.3, align 4, !tbaa !30
  br label %if.then123

if.then123:                                       ; preds = %if.else65.3, %if.then76.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ]
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ]
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ]
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then76.3 ], [ 0, %if.else65.3 ]
  %add129 = add nsw i32 %shr68, %mul33
  %or.cond761 = icmp ult i32 %add129, 128
  br i1 %or.cond761, label %if.then142, label %if.then123.1

if.then142:                                       ; preds = %if.then123
  %18 = shl nuw nsw i32 %add129, 6
  %mul147 = zext nneg i32 %18 to i64
  %add148 = or disjoint i64 %mul78, %mul147
  %add153 = or disjoint i64 %add148, %mul85
  %add.ptr154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr154, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154, i64 4
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154, i64 8
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154, i64 12
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx, align 4, !tbaa !30
  br label %if.then123.1

if.then123.1:                                     ; preds = %if.then142, %if.then123
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then142 ], [ 0, %if.then123 ]
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then142 ], [ 0, %if.then123 ]
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then142 ], [ 0, %if.then123 ]
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then142 ], [ 0, %if.then123 ]
  %add127.1 = add nuw nsw i32 %shr68, 8
  %add129.1 = add nsw i32 %add127.1, %mul33
  %or.cond761.1 = icmp ult i32 %add129.1, 128
  br i1 %or.cond761.1, label %if.then142.1, label %if.else130.2

if.then142.1:                                     ; preds = %if.then123.1
  %19 = shl nuw nsw i32 %add129.1, 6
  %mul147.1 = zext nneg i32 %19 to i64
  %add148.1 = or disjoint i64 %mul78, %mul147.1
  %add153.1 = or disjoint i64 %add148.1, %mul85
  %add.ptr154.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153.1
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr154.1, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.1, i64 4
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx.1, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.1, i64 8
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx.1, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.1, i64 12
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx.1, align 4, !tbaa !30
  br label %if.else130.2

if.else130.2:                                     ; preds = %if.then123.1, %if.then142.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ]
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ]
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ]
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then142.1 ], [ 0, %if.then123.1 ]
  %sub137.2 = add i32 %shr68, %mul33.1
  %or.cond761.2 = icmp ult i32 %sub137.2, 128
  br i1 %or.cond761.2, label %if.then142.2, label %if.else130.3

if.then142.2:                                     ; preds = %if.else130.2
  %20 = shl nuw nsw i32 %sub137.2, 6
  %mul147.2 = zext nneg i32 %20 to i64
  %add148.2 = or disjoint i64 %mul78, %mul147.2
  %add153.2 = or disjoint i64 %add148.2, %mul85
  %add.ptr154.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153.2
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr154.2, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.2, i64 4
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx.2, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.2, i64 8
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx.2, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.2, i64 12
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx.2, align 4, !tbaa !30
  br label %if.else130.3

if.else130.3:                                     ; preds = %if.else130.2, %if.then142.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ]
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ]
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ]
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then142.2 ], [ 0, %if.else130.2 ]
  %add136.3 = add nuw nsw i32 %shr68, 8
  %sub137.3 = add i32 %add136.3, %mul33.1
  %or.cond761.3 = icmp ult i32 %sub137.3, 128
  br i1 %or.cond761.3, label %if.then142.3, label %if.end178.3

if.then142.3:                                     ; preds = %if.else130.3
  %21 = shl nuw nsw i32 %sub137.3, 6
  %mul147.3 = zext nneg i32 %21 to i64
  %add148.3 = or disjoint i64 %mul78, %mul147.3
  %add153.3 = or disjoint i64 %add148.3, %mul85
  %add.ptr154.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add153.3
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr154.3, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr154.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.3, i64 4
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr154.sroa_idx.3, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr154.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.3, i64 8
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr154.sroa_idx.3, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr154.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr154.3, i64 12
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr154.sroa_idx.3, align 4, !tbaa !30
  br label %if.end178.3

if.end178.3:                                      ; preds = %if.then142.3, %if.else130.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ]
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ]
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ]
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then142.3 ], [ 0, %if.else130.3 ]
  %mul198 = and i32 %12, 8128
  %call202.masked = and i32 %2, 1016
  %mul204 = xor i32 %13, %call202.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul198
  %invariant.gep808 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul204
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep808, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep808.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 4
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep808.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep808.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 8
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep808.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep808.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 12
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep808.sroa_idx, align 4, !tbaa !30
  %gep809.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 1024
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep809.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep809.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 1028
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep809.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep809.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 1032
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep809.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep809.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 1036
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep809.1.sroa_idx, align 4, !tbaa !30
  %gep809.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 2048
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep809.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.gep809.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 2052
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep809.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.gep809.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 2056
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep809.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.gep809.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 2060
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep809.2.sroa_idx, align 4, !tbaa !30
  %gep809.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 3072
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep809.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.gep809.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 3076
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep809.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.gep809.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 3080
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep809.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.gep809.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep808, i32 3084
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep809.3.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr241 = lshr i32 %2, 4
  %and244 = and i32 %2, 7
  %xor245 = xor i32 %shr241, %and244
  %add.ptr249.idx = shl nuw nsw i32 %xor245, 4
  %invariant.gep812 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr249.idx
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep812, i32 %mul9
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8
  %add238.1 = or disjoint i32 %mul9, 1024
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep812, i32 %add238.1
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !89
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !89
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !call_argsrelate !89
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23), !call_argsrelate !89
  %add242.1 = add nuw nsw i32 %shr241, 4
  %xor245.1 = xor i32 %add242.1, %and244
  %add.ptr249.idx.1 = shl nuw nsw i32 %xor245.1, 4
  %invariant.gep812.1 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr249.idx.1
  %gep.1850 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep812.1, i32 %mul9
  %kb.sroa.0.0.copyload938 = load <4 x half>, ptr addrspace(3) %gep.1850, align 16
  %kb.sroa.6.0.gep.1850.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1850, i32 8
  %kb.sroa.6.0.copyload939 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1850.sroa_idx, align 8
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep812.1, i32 %add238.1
  %kb.sroa.8.16.copyload942 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8
  %kb.sroa.12.16.copyload943 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload938, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !call_argsrelate !89
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload942, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %25), !call_argsrelate !89
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload939, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !call_argsrelate !89
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload943, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %27), !call_argsrelate !89
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr303.idx = shl nuw nsw i32 %2, 4
  %invariant.gep817 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr303.idx
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep817, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep817.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 4
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep817.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep817.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 8
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep817.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep817.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 12
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep817.sroa_idx, align 4, !tbaa !30
  %gep818.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 1024
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep818.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep818.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 1028
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep818.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep818.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 1032
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep818.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep818.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 1036
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep818.1.sroa_idx, align 4, !tbaa !30
  %gep818.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 2048
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep818.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep818.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 2052
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep818.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep818.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 2056
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep818.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep818.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 2060
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep818.2.sroa_idx, align 4, !tbaa !30
  %gep818.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 3072
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep818.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep818.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 3076
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep818.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep818.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 3080
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep818.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep818.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep817, i32 3084
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep818.3.sroa_idx, align 4, !tbaa !30
  %30 = lshr i32 %2, 2
  %mul324 = and i32 %30, 252
  %add318 = add i32 %30, %mul33
  %add339 = add i32 %mul324, %mul33
  %add360 = add i32 %mul324, %mul33
  %cmp374 = icmp slt i32 %add318, 0
  %cmp376 = icmp sgt i32 %add339, 127
  %or.cond762.not842 = or i1 %cmp374, %cmp376
  %cmp379.not = icmp sgt i32 %add360, %1
  %or.cond802 = or i1 %or.cond762.not842, %cmp379.not
  br i1 %or.cond802, label %if.then312.1, label %if.then380

if.then380:                                       ; preds = %if.end178.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0
  %mul383 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul383, float 0x4024CB5EC0000000)
  %32 = tail call contract noundef float @llvm.exp.f32(float %31)
  br label %if.then312.1

if.then312.1:                                     ; preds = %if.then380, %if.end178.3
  %condval_5.0 = phi float [ %32, %if.then380 ], [ 0.000000e+00, %if.end178.3 ]
  %add318.1 = add i32 %30, %mul33
  %add338.1 = or disjoint i32 %mul324, 1
  %add339.1 = add i32 %add338.1, %mul33
  %add359.1 = or disjoint i32 %mul324, 1
  %add360.1 = add i32 %add359.1, %mul33
  %cmp374.1 = icmp slt i32 %add318.1, 0
  %cmp376.1 = icmp sgt i32 %add339.1, 127
  %or.cond762.not842.1 = select i1 %cmp374.1, i1 true, i1 %cmp376.1
  %cmp379.not.1 = icmp sgt i32 %add360.1, %1
  %or.cond802.1 = select i1 %or.cond762.not842.1, i1 true, i1 %cmp379.not.1
  br i1 %or.cond802.1, label %if.then312.2, label %if.then380.1

if.then380.1:                                     ; preds = %if.then312.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1
  %mul383.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul383.1, float 0x4024CB5EC0000000)
  %34 = tail call contract noundef float @llvm.exp.f32(float %33)
  br label %if.then312.2

if.then312.2:                                     ; preds = %if.then312.1, %if.then380.1
  %condval_5.0.1 = phi float [ %34, %if.then380.1 ], [ 0.000000e+00, %if.then312.1 ]
  %add318.2 = add i32 %30, %mul33
  %add338.2 = or disjoint i32 %mul324, 2
  %add339.2 = add i32 %add338.2, %mul33
  %add359.2 = or disjoint i32 %mul324, 2
  %add360.2 = add i32 %add359.2, %mul33
  %cmp374.2 = icmp slt i32 %add318.2, 0
  %cmp376.2 = icmp sgt i32 %add339.2, 127
  %or.cond762.not842.2 = select i1 %cmp374.2, i1 true, i1 %cmp376.2
  %cmp379.not.2 = icmp sgt i32 %add360.2, %1
  %or.cond802.2 = select i1 %or.cond762.not842.2, i1 true, i1 %cmp379.not.2
  br i1 %or.cond802.2, label %if.then312.3, label %if.then380.2

if.then380.2:                                     ; preds = %if.then312.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2
  %mul383.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul383.2, float 0x4024CB5EC0000000)
  %36 = tail call contract noundef float @llvm.exp.f32(float %35)
  br label %if.then312.3

if.then312.3:                                     ; preds = %if.then312.2, %if.then380.2
  %condval_5.0.2 = phi float [ %36, %if.then380.2 ], [ 0.000000e+00, %if.then312.2 ]
  %add318.3 = add i32 %30, %mul33
  %add338.3 = or i32 %30, 3
  %add339.3 = add i32 %add338.3, %mul33
  %add359.3 = or i32 %30, 3
  %add360.3 = add i32 %add359.3, %mul33
  %cmp374.3 = icmp slt i32 %add318.3, 0
  %cmp376.3 = icmp sgt i32 %add339.3, 127
  %or.cond762.not842.3 = or i1 %cmp374.3, %cmp376.3
  %cmp379.not.3 = icmp sgt i32 %add360.3, %1
  %or.cond802.3 = or i1 %or.cond762.not842.3, %cmp379.not.3
  br i1 %or.cond802.3, label %if.else319.4, label %if.then380.3

if.then380.3:                                     ; preds = %if.then312.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3
  %mul383.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul383.3, float 0x4024CB5EC0000000)
  %38 = tail call contract noundef float @llvm.exp.f32(float %37)
  br label %if.else319.4

if.else319.4:                                     ; preds = %if.then312.3, %if.then380.3
  %condval_5.0.3 = phi float [ %38, %if.then380.3 ], [ 0.000000e+00, %if.then312.3 ]
  %sub330.4 = add i32 %30, %mul33.1
  %sub351.4 = add i32 %mul324, %mul33.1
  %sub372.4 = add i32 %mul324, %mul33.1
  %cmp374.4 = icmp slt i32 %sub330.4, 0
  %cmp376.4 = icmp sgt i32 %sub351.4, 127
  %or.cond762.not842.4 = or i1 %cmp374.4, %cmp376.4
  %cmp379.not.4 = icmp sgt i32 %sub372.4, %1
  %or.cond802.4 = select i1 %or.cond762.not842.4, i1 true, i1 %cmp379.not.4
  br i1 %or.cond802.4, label %if.else319.5, label %if.then380.4

if.then380.4:                                     ; preds = %if.else319.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %29, i64 0
  %mul383.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul383.4, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  br label %if.else319.5

if.else319.5:                                     ; preds = %if.else319.4, %if.then380.4
  %condval_5.0.4 = phi float [ %40, %if.then380.4 ], [ 0.000000e+00, %if.else319.4 ]
  %sub330.5 = add i32 %30, %mul33.1
  %add350.5 = or disjoint i32 %mul324, 1
  %sub351.5 = add i32 %add350.5, %mul33.1
  %add371.5 = or disjoint i32 %mul324, 1
  %sub372.5 = add i32 %add371.5, %mul33.1
  %cmp374.5 = icmp slt i32 %sub330.5, 0
  %cmp376.5 = icmp sgt i32 %sub351.5, 127
  %or.cond762.not842.5 = select i1 %cmp374.5, i1 true, i1 %cmp376.5
  %cmp379.not.5 = icmp sgt i32 %sub372.5, %1
  %or.cond802.5 = select i1 %or.cond762.not842.5, i1 true, i1 %cmp379.not.5
  br i1 %or.cond802.5, label %if.else319.6, label %if.then380.5

if.then380.5:                                     ; preds = %if.else319.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %29, i64 1
  %mul383.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul383.5, float 0x4024CB5EC0000000)
  %42 = tail call contract noundef float @llvm.exp.f32(float %41)
  br label %if.else319.6

if.else319.6:                                     ; preds = %if.else319.5, %if.then380.5
  %condval_5.0.5 = phi float [ %42, %if.then380.5 ], [ 0.000000e+00, %if.else319.5 ]
  %sub330.6 = add i32 %30, %mul33.1
  %add350.6 = or disjoint i32 %mul324, 2
  %sub351.6 = add i32 %add350.6, %mul33.1
  %add371.6 = or disjoint i32 %mul324, 2
  %sub372.6 = add i32 %add371.6, %mul33.1
  %cmp374.6 = icmp slt i32 %sub330.6, 0
  %cmp376.6 = icmp sgt i32 %sub351.6, 127
  %or.cond762.not842.6 = select i1 %cmp374.6, i1 true, i1 %cmp376.6
  %cmp379.not.6 = icmp sgt i32 %sub372.6, %1
  %or.cond802.6 = select i1 %or.cond762.not842.6, i1 true, i1 %cmp379.not.6
  br i1 %or.cond802.6, label %if.else319.7, label %if.then380.6

if.then380.6:                                     ; preds = %if.else319.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %29, i64 2
  %mul383.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul383.6, float 0x4024CB5EC0000000)
  %44 = tail call contract noundef float @llvm.exp.f32(float %43)
  br label %if.else319.7

if.else319.7:                                     ; preds = %if.else319.6, %if.then380.6
  %condval_5.0.6 = phi float [ %44, %if.then380.6 ], [ 0.000000e+00, %if.else319.6 ]
  %sub330.7 = add i32 %30, %mul33.1
  %add350.7 = or i32 %30, 3
  %sub351.7 = add i32 %add350.7, %mul33.1
  %add371.7 = or i32 %30, 3
  %sub372.7 = add i32 %add371.7, %mul33.1
  %cmp374.7 = icmp slt i32 %sub330.7, 0
  %cmp376.7 = icmp sgt i32 %sub351.7, 127
  %or.cond762.not842.7 = or i1 %cmp374.7, %cmp376.7
  %cmp379.not.7 = icmp sgt i32 %sub372.7, %1
  %or.cond802.7 = select i1 %or.cond762.not842.7, i1 true, i1 %cmp379.not.7
  br i1 %or.cond802.7, label %if.end387.7, label %if.then380.7

if.then380.7:                                     ; preds = %if.else319.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %29, i64 3
  %mul383.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul383.7, float 0x4024CB5EC0000000)
  %46 = tail call contract noundef float @llvm.exp.f32(float %45)
  br label %if.end387.7

if.end387.7:                                      ; preds = %if.then380.7, %if.else319.7
  %condval_5.0.7 = phi float [ %46, %if.then380.7 ], [ 0.000000e+00, %if.else319.7 ]
  %add407.1 = fadd contract float %condval_5.0, %condval_5.0.1
  %add407.2 = fadd contract float %add407.1, %condval_5.0.2
  %add407.3 = fadd contract float %add407.2, %condval_5.0.3
  %add407.1856 = fadd contract float %add407.3, %condval_5.0.4
  %add407.1.1 = fadd contract float %add407.1856, %condval_5.0.5
  %add407.2.1 = fadd contract float %add407.1.1, %condval_5.0.6
  %add407.3.1 = fadd contract float %add407.2.1, %condval_5.0.7
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add407.3.1, <4 x float> zeroinitializer)
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %47, i64 0
  %cmp428 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  br i1 %cmp428, label %if.then429, label %if.end445

if.then429:                                       ; preds = %if.end387.7
  %48 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32
  %sub431 = sub i32 2129859011, %48
  %49 = bitcast i32 %sub431 to float
  %mul433 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %49
  %sub434 = fsub contract float 2.000000e+00, %mul433
  %mul435 = fmul contract float %sub434, %49
  %mul441 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul435
  %sub442 = fsub contract float 2.000000e+00, %mul441
  %mul443 = fmul contract float %mul435, %sub442
  br label %if.end445

if.end445:                                        ; preds = %if.end387.7, %if.then429
  %condval_9.0 = phi float [ %mul443, %if.then429 ], [ 0.000000e+00, %if.end387.7 ]
  %mul454 = fmul contract float %condval_9.0, %condval_5.0
  %mul454.1 = fmul contract float %condval_9.0, %condval_5.0.1
  %mul454.2 = fmul contract float %condval_9.0, %condval_5.0.2
  %mul454.3 = fmul contract float %condval_9.0, %condval_5.0.3
  %mul454.4 = fmul contract float %condval_9.0, %condval_5.0.4
  %mul454.5 = fmul contract float %condval_9.0, %condval_5.0.5
  %mul454.6 = fmul contract float %condval_9.0, %condval_5.0.6
  %mul454.7 = fmul contract float %condval_9.0, %condval_5.0.7
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454)
  %51 = insertelement <4 x i16> poison, i16 %50, i64 0
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.1)
  %53 = insertelement <4 x i16> %51, i16 %52, i64 1
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.2)
  %55 = insertelement <4 x i16> %53, i16 %54, i64 2
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.3)
  %57 = insertelement <4 x i16> %55, i16 %56, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %57 to <4 x half>
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.4)
  %59 = insertelement <4 x i16> poison, i16 %58, i64 0
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.5)
  %61 = insertelement <4 x i16> %59, i16 %60, i64 1
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.6)
  %63 = insertelement <4 x i16> %61, i16 %62, i64 2
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul454.7)
  %65 = insertelement <4 x i16> %63, i16 %64, i64 3
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %65 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul498 = and i32 %add.ptr303.idx, 16128
  %and505 = and i32 %2, 15
  %add506 = or disjoint i32 %mul498, %and505
  %arrayidx508 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506
  %66 = load half, ptr addrspace(3) %arrayidx508, align 2, !tbaa !154
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add501.1 = or disjoint i32 %mul498, %and505
  %add506.1 = or disjoint i32 %add501.1, 64
  %arrayidx508.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1
  %67 = load half, ptr addrspace(3) %arrayidx508.1, align 2, !tbaa !154
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %67, i64 1
  %add501.2 = or disjoint i32 %mul498, %and505
  %add506.2 = or disjoint i32 %add501.2, 128
  %arrayidx508.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2
  %68 = load half, ptr addrspace(3) %arrayidx508.2, align 2, !tbaa !154
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %68, i64 2
  %add501.3 = or disjoint i32 %mul498, %and505
  %add506.3 = or disjoint i32 %add501.3, 192
  %arrayidx508.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3
  %69 = load half, ptr addrspace(3) %arrayidx508.3, align 2, !tbaa !154
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %69, i64 3
  %add503.1859 = or disjoint i32 %mul498, %and505
  %add506.1860 = or disjoint i32 %add503.1859, 16
  %arrayidx508.1861 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1860
  %70 = load half, ptr addrspace(3) %arrayidx508.1861, align 2, !tbaa !154
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %70, i64 0
  %add503.1.1 = or disjoint i32 %mul498, %and505
  %add506.1.1 = or disjoint i32 %add503.1.1, 80
  %arrayidx508.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1.1
  %71 = load half, ptr addrspace(3) %arrayidx508.1.1, align 2, !tbaa !154
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %71, i64 1
  %add503.2.1 = or disjoint i32 %mul498, %and505
  %add506.2.1 = or disjoint i32 %add503.2.1, 144
  %arrayidx508.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2.1
  %72 = load half, ptr addrspace(3) %arrayidx508.2.1, align 2, !tbaa !154
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %72, i64 2
  %add503.3.1 = or disjoint i32 %mul498, %and505
  %add506.3.1 = or disjoint i32 %add503.3.1, 208
  %arrayidx508.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3.1
  %73 = load half, ptr addrspace(3) %arrayidx508.3.1, align 2, !tbaa !154
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %73, i64 3
  %add503.2863 = or disjoint i32 %mul498, %and505
  %add506.2864 = or disjoint i32 %add503.2863, 32
  %arrayidx508.2865 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2864
  %74 = load half, ptr addrspace(3) %arrayidx508.2865, align 2, !tbaa !154
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %74, i64 0
  %add503.1.2 = or disjoint i32 %mul498, %and505
  %add506.1.2 = or disjoint i32 %add503.1.2, 96
  %arrayidx508.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1.2
  %75 = load half, ptr addrspace(3) %arrayidx508.1.2, align 2, !tbaa !154
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %75, i64 1
  %add503.2.2 = or disjoint i32 %mul498, %and505
  %add506.2.2 = or disjoint i32 %add503.2.2, 160
  %arrayidx508.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2.2
  %76 = load half, ptr addrspace(3) %arrayidx508.2.2, align 2, !tbaa !154
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %76, i64 2
  %add503.3.2 = or disjoint i32 %mul498, %and505
  %add506.3.2 = or disjoint i32 %add503.3.2, 224
  %arrayidx508.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3.2
  %77 = load half, ptr addrspace(3) %arrayidx508.3.2, align 2, !tbaa !154
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %77, i64 3
  %add503.3867 = or disjoint i32 %mul498, %and505
  %add506.3868 = or disjoint i32 %add503.3867, 48
  %arrayidx508.3869 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3868
  %78 = load half, ptr addrspace(3) %arrayidx508.3869, align 2, !tbaa !154
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %78, i64 0
  %add503.1.3 = or disjoint i32 %mul498, %and505
  %add506.1.3 = or disjoint i32 %add503.1.3, 112
  %arrayidx508.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1.3
  %79 = load half, ptr addrspace(3) %arrayidx508.1.3, align 2, !tbaa !154
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %79, i64 1
  %add503.2.3 = or disjoint i32 %mul498, %and505
  %add506.2.3 = or disjoint i32 %add503.2.3, 176
  %arrayidx508.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2.3
  %80 = load half, ptr addrspace(3) %arrayidx508.2.3, align 2, !tbaa !154
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %80, i64 2
  %add503.3.3 = or disjoint i32 %add.ptr303.idx, %and505
  %add506.3.3 = or i32 %add503.3.3, 240
  %arrayidx508.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3.3
  %81 = load half, ptr addrspace(3) %arrayidx508.3.3, align 2, !tbaa !154
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %81, i64 3
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add499.1 = add nuw nsw i32 %mul498, 1024
  %add506.1871 = or disjoint i32 %add499.1, %and505
  %arrayidx508.1872 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1871
  %86 = load half, ptr addrspace(3) %arrayidx508.1872, align 2, !tbaa !154
  %vb.sroa.0.0.vec.insert898 = insertelement <4 x half> poison, half %86, i64 0
  %add501.1.1873 = add nuw nsw i32 %mul498, 1088
  %add506.1.1874 = or disjoint i32 %add501.1.1873, %and505
  %arrayidx508.1.1875 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1.1874
  %87 = load half, ptr addrspace(3) %arrayidx508.1.1875, align 2, !tbaa !154
  %vb.sroa.0.2.vec.insert900 = insertelement <4 x half> %vb.sroa.0.0.vec.insert898, half %87, i64 1
  %add501.2.1877 = add nuw nsw i32 %mul498, 1152
  %add506.2.1878 = or disjoint i32 %add501.2.1877, %and505
  %arrayidx508.2.1879 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2.1878
  %88 = load half, ptr addrspace(3) %arrayidx508.2.1879, align 2, !tbaa !154
  %vb.sroa.0.4.vec.insert902 = insertelement <4 x half> %vb.sroa.0.2.vec.insert900, half %88, i64 2
  %add501.3.1881 = add nuw nsw i32 %mul498, 1216
  %add506.3.1882 = or disjoint i32 %add501.3.1881, %and505
  %arrayidx508.3.1883 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3.1882
  %89 = load half, ptr addrspace(3) %arrayidx508.3.1883, align 2, !tbaa !154
  %vb.sroa.0.6.vec.insert904 = insertelement <4 x half> %vb.sroa.0.4.vec.insert902, half %89, i64 3
  %add503.1859.1 = add nuw nsw i32 %mul498, 1040
  %add506.1860.1 = or disjoint i32 %add503.1859.1, %and505
  %arrayidx508.1861.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1860.1
  %90 = load half, ptr addrspace(3) %arrayidx508.1861.1, align 2, !tbaa !154
  %vb.sroa.12.8.vec.insert908 = insertelement <4 x half> poison, half %90, i64 0
  %add503.1.1.1 = add nuw nsw i32 %mul498, 1104
  %add506.1.1.1 = or disjoint i32 %add503.1.1.1, %and505
  %arrayidx508.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1.1.1
  %91 = load half, ptr addrspace(3) %arrayidx508.1.1.1, align 2, !tbaa !154
  %vb.sroa.12.10.vec.insert910 = insertelement <4 x half> %vb.sroa.12.8.vec.insert908, half %91, i64 1
  %add503.2.1.1 = add nuw nsw i32 %mul498, 1168
  %add506.2.1.1 = or disjoint i32 %add503.2.1.1, %and505
  %arrayidx508.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2.1.1
  %92 = load half, ptr addrspace(3) %arrayidx508.2.1.1, align 2, !tbaa !154
  %vb.sroa.12.12.vec.insert912 = insertelement <4 x half> %vb.sroa.12.10.vec.insert910, half %92, i64 2
  %add503.3.1.1 = add nuw nsw i32 %mul498, 1232
  %add506.3.1.1 = or disjoint i32 %add503.3.1.1, %and505
  %arrayidx508.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3.1.1
  %93 = load half, ptr addrspace(3) %arrayidx508.3.1.1, align 2, !tbaa !154
  %vb.sroa.12.14.vec.insert914 = insertelement <4 x half> %vb.sroa.12.12.vec.insert912, half %93, i64 3
  %add503.2863.1 = add nuw nsw i32 %mul498, 1056
  %add506.2864.1 = or disjoint i32 %add503.2863.1, %and505
  %arrayidx508.2865.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2864.1
  %94 = load half, ptr addrspace(3) %arrayidx508.2865.1, align 2, !tbaa !154
  %vb.sroa.22.16.vec.insert918 = insertelement <4 x half> poison, half %94, i64 0
  %add503.1.2.1 = add nuw nsw i32 %mul498, 1120
  %add506.1.2.1 = or disjoint i32 %add503.1.2.1, %and505
  %arrayidx508.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1.2.1
  %95 = load half, ptr addrspace(3) %arrayidx508.1.2.1, align 2, !tbaa !154
  %vb.sroa.22.18.vec.insert920 = insertelement <4 x half> %vb.sroa.22.16.vec.insert918, half %95, i64 1
  %add503.2.2.1 = add nuw nsw i32 %mul498, 1184
  %add506.2.2.1 = or disjoint i32 %add503.2.2.1, %and505
  %arrayidx508.2.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2.2.1
  %96 = load half, ptr addrspace(3) %arrayidx508.2.2.1, align 2, !tbaa !154
  %vb.sroa.22.20.vec.insert922 = insertelement <4 x half> %vb.sroa.22.18.vec.insert920, half %96, i64 2
  %add503.3.2.1 = add nuw nsw i32 %mul498, 1248
  %add506.3.2.1 = or disjoint i32 %add503.3.2.1, %and505
  %arrayidx508.3.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3.2.1
  %97 = load half, ptr addrspace(3) %arrayidx508.3.2.1, align 2, !tbaa !154
  %vb.sroa.22.22.vec.insert924 = insertelement <4 x half> %vb.sroa.22.20.vec.insert922, half %97, i64 3
  %add503.3867.1 = add nuw nsw i32 %mul498, 1072
  %add506.3868.1 = or disjoint i32 %add503.3867.1, %and505
  %arrayidx508.3869.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3868.1
  %98 = load half, ptr addrspace(3) %arrayidx508.3869.1, align 2, !tbaa !154
  %vb.sroa.32.24.vec.insert928 = insertelement <4 x half> poison, half %98, i64 0
  %add503.1.3.1 = add nuw nsw i32 %mul498, 1136
  %add506.1.3.1 = or disjoint i32 %add503.1.3.1, %and505
  %arrayidx508.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.1.3.1
  %99 = load half, ptr addrspace(3) %arrayidx508.1.3.1, align 2, !tbaa !154
  %vb.sroa.32.26.vec.insert930 = insertelement <4 x half> %vb.sroa.32.24.vec.insert928, half %99, i64 1
  %add503.2.3.1 = add nuw nsw i32 %mul498, 1200
  %add506.2.3.1 = or disjoint i32 %add503.2.3.1, %and505
  %arrayidx508.2.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.2.3.1
  %100 = load half, ptr addrspace(3) %arrayidx508.2.3.1, align 2, !tbaa !154
  %vb.sroa.32.28.vec.insert932 = insertelement <4 x half> %vb.sroa.32.26.vec.insert930, half %100, i64 2
  %add503.3.3.1 = add nuw nsw i32 %mul498, 1264
  %add506.3.3.1 = or disjoint i32 %add503.3.3.1, %and505
  %arrayidx508.3.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add506.3.3.1
  %101 = load half, ptr addrspace(3) %arrayidx508.3.3.1, align 2, !tbaa !154
  %vb.sroa.32.30.vec.insert934 = insertelement <4 x half> %vb.sroa.32.28.vec.insert932, half %101, i64 3
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert904, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %82)
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert914, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %83)
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert924, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %84)
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert934, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %85)
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %102, i64 0
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_cast.sroa.0.0.insert.ext = zext i16 %106 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %102, i64 1
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_cast.sroa.0.2.insert.ext = zext i16 %107 to i64
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %102, i64 2
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_cast.sroa.0.4.insert.ext = zext i16 %108 to i64
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %102, i64 3
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_cast.sroa.0.6.insert.ext = zext i16 %109 to i64
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %103, i64 0
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract)
  %O_cast.sroa.7.8.insert.ext = zext i16 %110 to i64
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %103, i64 1
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract)
  %O_cast.sroa.7.10.insert.ext = zext i16 %111 to i64
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %103, i64 2
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract)
  %O_cast.sroa.7.12.insert.ext = zext i16 %112 to i64
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %103, i64 3
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract)
  %O_cast.sroa.7.14.insert.ext = zext i16 %113 to i64
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %104, i64 0
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract)
  %O_cast.sroa.12.16.insert.ext = zext i16 %114 to i64
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %104, i64 1
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract)
  %O_cast.sroa.12.18.insert.ext = zext i16 %115 to i64
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %104, i64 2
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract)
  %O_cast.sroa.12.20.insert.ext = zext i16 %116 to i64
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %104, i64 3
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract)
  %O_cast.sroa.12.22.insert.ext = zext i16 %117 to i64
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %105, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract)
  %O_cast.sroa.17.24.insert.ext = zext i16 %118 to i64
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %105, i64 1
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract)
  %O_cast.sroa.17.26.insert.ext = zext i16 %119 to i64
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %105, i64 2
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract)
  %O_cast.sroa.17.28.insert.ext = zext i16 %120 to i64
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %105, i64 3
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract)
  %O_cast.sroa.17.30.insert.ext = zext i16 %121 to i64
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr577 = lshr i32 %2, 5
  %mul587 = and i32 %30, 4
  %xor581 = xor i32 %shr577, %and244
  %mul582 = shl nuw nsw i32 %xor581, 3
  %add583 = add nuw nsw i32 %mul582, %mul9
  %add588 = or disjoint i32 %add583, %mul587
  %add.ptr590 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add588
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr590, align 8
  %add578.1 = add nuw nsw i32 %shr577, 2
  %xor581.1 = xor i32 %add578.1, %and244
  %mul582.1 = shl nuw nsw i32 %xor581.1, 3
  %add583.1 = add nuw nsw i32 %mul582.1, %mul9
  %add588.1 = or disjoint i32 %add583.1, %mul587
  %add.ptr590.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add588.1
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr590.1, align 8
  %add578.2 = add nuw nsw i32 %shr577, 4
  %xor581.2 = xor i32 %add578.2, %and244
  %mul582.2 = shl nuw nsw i32 %xor581.2, 3
  %add583.2 = add nuw nsw i32 %mul582.2, %mul9
  %add588.2 = or disjoint i32 %add583.2, %mul587
  %add.ptr590.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add588.2
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr590.2, align 8
  %add578.3 = add nuw nsw i32 %shr577, 6
  %xor581.3 = xor i32 %add578.3, %and244
  %mul582.3 = shl nuw nsw i32 %xor581.3, 3
  %add583.3 = add nuw nsw i32 %mul582.3, %mul9
  %add588.3 = or disjoint i32 %add583.3, %mul587
  %add.ptr590.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add588.3
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr590.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add618 = add nuw nsw i32 %add, %12
  %122 = zext nneg i32 %add618 to i64
  %add.ptr623 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr623, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep808, i64 16, i1 false), !tbaa.struct !184, !call_argsrelate !185
  %123 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr623.1 = getelementptr inbounds i8, ptr addrspace(1) %123, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr623.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep809.1, i64 16, i1 false), !tbaa.struct !184, !call_argsrelate !185
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare void @llvm.mxc.barrier.warp() #7

declare float @llvm.exp.f32(float) #8

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.minnum.f32(float, float) #8

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }


