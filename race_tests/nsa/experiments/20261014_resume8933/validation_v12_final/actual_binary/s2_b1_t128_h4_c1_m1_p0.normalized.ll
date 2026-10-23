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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 12
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
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
  %mul25 = shl nsw i32 %0, 3
  %mul27 = shl nuw nsw i32 %1, 1
  %add28 = add nuw nsw i32 %mul25, %mul27
  %6 = zext nneg i32 %add28 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp31 = icmp ult i32 %7, 8
  %8 = shl nsw i32 %7, 4
  %mul32 = select i1 %cmp31, i32 %8, i32 -16
  %9 = or disjoint i64 %6, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %9
  %10 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cmp31.1 = icmp ult i32 %10, 8
  %11 = shl nsw i32 %10, 4
  %mul32.1 = select i1 %cmp31.1, i32 %11, i32 -16
  %shr67 = lshr i32 %2, 3
  %conv78 = zext nneg i32 %1 to i64
  %mul79 = shl nuw nsw i64 %conv78, 6
  %12 = shl nuw nsw i32 %2, 3
  %13 = and i32 %12, 56
  %mul84 = zext nneg i32 %13 to i64
  %add63 = add nsw i32 %shr67, %mul32
  %or.cond = icmp ult i32 %add63, 128
  br i1 %or.cond, label %if.then75, label %if.then57.1

if.then75:                                        ; preds = %entry
  %14 = shl nuw nsw i32 %add63, 8
  %mul76 = zext nneg i32 %14 to i64
  %add80 = add nuw nsw i64 %mul79, %mul76
  %add85 = or disjoint i64 %add80, %mul84
  %add.ptr86 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr86, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86, i64 4
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86, i64 8
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86, i64 12
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx, align 4, !tbaa !30
  br label %if.then57.1

if.then57.1:                                      ; preds = %if.then75, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then75 ], [ 0, %entry ]
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then75 ], [ 0, %entry ]
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then75 ], [ 0, %entry ]
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then75 ], [ 0, %entry ]
  %add61.1 = add nuw nsw i32 %shr67, 8
  %add63.1 = add nsw i32 %add61.1, %mul32
  %or.cond.1 = icmp ult i32 %add63.1, 128
  br i1 %or.cond.1, label %if.then75.1, label %if.else64.2

if.then75.1:                                      ; preds = %if.then57.1
  %15 = shl nuw nsw i32 %add63.1, 8
  %mul76.1 = zext nneg i32 %15 to i64
  %add80.1 = add nuw nsw i64 %mul79, %mul76.1
  %add85.1 = or disjoint i64 %add80.1, %mul84
  %add.ptr86.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85.1
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr86.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.1, i64 4
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.1, i64 8
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.1, i64 12
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx.1, align 4, !tbaa !30
  br label %if.else64.2

if.else64.2:                                      ; preds = %if.then57.1, %if.then75.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ]
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ]
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ]
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then75.1 ], [ 0, %if.then57.1 ]
  %sub.2 = add i32 %shr67, %mul32.1
  %or.cond.2 = icmp ult i32 %sub.2, 128
  br i1 %or.cond.2, label %if.then75.2, label %if.else64.3

if.then75.2:                                      ; preds = %if.else64.2
  %16 = shl nuw nsw i32 %sub.2, 8
  %mul76.2 = zext nneg i32 %16 to i64
  %add80.2 = add nuw nsw i64 %mul79, %mul76.2
  %add85.2 = or disjoint i64 %add80.2, %mul84
  %add.ptr86.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85.2
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr86.2, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.2, i64 4
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx.2, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.2, i64 8
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx.2, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.2, i64 12
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx.2, align 4, !tbaa !30
  br label %if.else64.3

if.else64.3:                                      ; preds = %if.else64.2, %if.then75.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ]
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ]
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ]
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then75.2 ], [ 0, %if.else64.2 ]
  %add70.3 = add nuw nsw i32 %shr67, 8
  %sub.3 = add i32 %add70.3, %mul32.1
  %or.cond.3 = icmp ult i32 %sub.3, 128
  br i1 %or.cond.3, label %if.then75.3, label %if.then122

if.then75.3:                                      ; preds = %if.else64.3
  %17 = shl nuw nsw i32 %sub.3, 8
  %mul76.3 = zext nneg i32 %17 to i64
  %add80.3 = add nuw nsw i64 %mul79, %mul76.3
  %add85.3 = or disjoint i64 %add80.3, %mul84
  %add.ptr86.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add85.3
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr86.3, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr86.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.3, i64 4
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr86.sroa_idx.3, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr86.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.3, i64 8
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr86.sroa_idx.3, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr86.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr86.3, i64 12
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr86.sroa_idx.3, align 4, !tbaa !30
  br label %if.then122

if.then122:                                       ; preds = %if.else64.3, %if.then75.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ]
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ]
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ]
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then75.3 ], [ 0, %if.else64.3 ]
  %add128 = add nsw i32 %shr67, %mul32
  %or.cond694 = icmp ult i32 %add128, 128
  br i1 %or.cond694, label %if.then141, label %if.then122.1

if.then141:                                       ; preds = %if.then122
  %18 = shl nuw nsw i32 %add128, 8
  %mul143 = zext nneg i32 %18 to i64
  %add147 = add nuw nsw i64 %mul79, %mul143
  %add152 = or disjoint i64 %add147, %mul84
  %add.ptr153 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr153, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153, i64 4
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153, i64 8
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153, i64 12
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx, align 4, !tbaa !30
  br label %if.then122.1

if.then122.1:                                     ; preds = %if.then141, %if.then122
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then141 ], [ 0, %if.then122 ]
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then141 ], [ 0, %if.then122 ]
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then141 ], [ 0, %if.then122 ]
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then141 ], [ 0, %if.then122 ]
  %add126.1 = add nuw nsw i32 %shr67, 8
  %add128.1 = add nsw i32 %add126.1, %mul32
  %or.cond694.1 = icmp ult i32 %add128.1, 128
  br i1 %or.cond694.1, label %if.then141.1, label %if.else129.2

if.then141.1:                                     ; preds = %if.then122.1
  %19 = shl nuw nsw i32 %add128.1, 8
  %mul143.1 = zext nneg i32 %19 to i64
  %add147.1 = add nuw nsw i64 %mul79, %mul143.1
  %add152.1 = or disjoint i64 %add147.1, %mul84
  %add.ptr153.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152.1
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr153.1, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.1, i64 4
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx.1, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.1, i64 8
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx.1, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.1, i64 12
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx.1, align 4, !tbaa !30
  br label %if.else129.2

if.else129.2:                                     ; preds = %if.then122.1, %if.then141.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ]
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ]
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ]
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then141.1 ], [ 0, %if.then122.1 ]
  %sub136.2 = add i32 %shr67, %mul32.1
  %or.cond694.2 = icmp ult i32 %sub136.2, 128
  br i1 %or.cond694.2, label %if.then141.2, label %if.else129.3

if.then141.2:                                     ; preds = %if.else129.2
  %20 = shl nuw nsw i32 %sub136.2, 8
  %mul143.2 = zext nneg i32 %20 to i64
  %add147.2 = add nuw nsw i64 %mul79, %mul143.2
  %add152.2 = or disjoint i64 %add147.2, %mul84
  %add.ptr153.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152.2
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr153.2, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.2, i64 4
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx.2, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.2, i64 8
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx.2, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.2, i64 12
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx.2, align 4, !tbaa !30
  br label %if.else129.3

if.else129.3:                                     ; preds = %if.else129.2, %if.then141.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ]
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ]
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ]
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then141.2 ], [ 0, %if.else129.2 ]
  %add135.3 = add nuw nsw i32 %shr67, 8
  %sub136.3 = add i32 %add135.3, %mul32.1
  %or.cond694.3 = icmp ult i32 %sub136.3, 128
  br i1 %or.cond694.3, label %if.then141.3, label %if.end177.3

if.then141.3:                                     ; preds = %if.else129.3
  %21 = shl nuw nsw i32 %sub136.3, 8
  %mul143.3 = zext nneg i32 %21 to i64
  %add147.3 = add nuw nsw i64 %mul79, %mul143.3
  %add152.3 = or disjoint i64 %add147.3, %mul84
  %add.ptr153.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add152.3
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr153.3, align 16, !tbaa !30
  %condval_4.sroa.5.0.add.ptr153.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.3, i64 4
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr153.sroa_idx.3, align 4, !tbaa !30
  %condval_4.sroa.6.0.add.ptr153.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.3, i64 8
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr153.sroa_idx.3, align 8, !tbaa !30
  %condval_4.sroa.7.0.add.ptr153.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr153.3, i64 12
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr153.sroa_idx.3, align 4, !tbaa !30
  br label %if.end177.3

if.end177.3:                                      ; preds = %if.then141.3, %if.else129.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ]
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ]
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ]
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then141.3 ], [ 0, %if.else129.3 ]
  %mul197 = and i32 %12, 8128
  %call201.masked = and i32 %2, 1016
  %mul203 = xor i32 %13, %call201.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul197
  %invariant.gep746 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul203
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep746, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep746.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 4
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep746.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep746.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 8
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep746.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep746.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 12
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep746.sroa_idx, align 4, !tbaa !30
  %gep747.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1024
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep747.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep747.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1028
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep747.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep747.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1032
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep747.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep747.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 1036
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep747.1.sroa_idx, align 4, !tbaa !30
  %gep747.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2048
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep747.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.gep747.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2052
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep747.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.gep747.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2056
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep747.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.gep747.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 2060
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep747.2.sroa_idx, align 4, !tbaa !30
  %gep747.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3072
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep747.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.gep747.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3076
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep747.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.gep747.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3080
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep747.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.gep747.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep746, i32 3084
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep747.3.sroa_idx, align 4, !tbaa !30
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %shr240 = lshr i32 %2, 4
  %and243 = and i32 %2, 7
  %xor244 = xor i32 %shr240, %and243
  %add.ptr248.idx = shl nuw nsw i32 %xor244, 4
  %invariant.gep750 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr248.idx
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750, i32 %mul9
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8
  %add237.1 = or disjoint i32 %mul9, 1024
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750, i32 %add237.1
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !89
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !89
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !call_argsrelate !89
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23), !call_argsrelate !89
  %add241.1 = add nuw nsw i32 %shr240, 4
  %xor244.1 = xor i32 %add241.1, %and243
  %add.ptr248.idx.1 = shl nuw nsw i32 %xor244.1, 4
  %invariant.gep750.1 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr248.idx.1
  %gep.1783 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750.1, i32 %mul9
  %kb.sroa.0.0.copyload872 = load <4 x half>, ptr addrspace(3) %gep.1783, align 16
  %kb.sroa.6.0.gep.1783.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1783, i32 8
  %kb.sroa.6.0.copyload873 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1783.sroa_idx, align 8
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep750.1, i32 %add237.1
  %kb.sroa.8.16.copyload876 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8
  %kb.sroa.12.16.copyload877 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload872, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !call_argsrelate !89
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload876, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %25), !call_argsrelate !89
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload873, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !call_argsrelate !89
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload877, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %27), !call_argsrelate !89
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %add.ptr302.idx = shl nuw nsw i32 %2, 4
  %invariant.gep755 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr302.idx
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep755, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep755.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 4
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep755.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep755.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 8
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep755.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep755.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 12
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep755.sroa_idx, align 4, !tbaa !30
  %gep756.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1024
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep756.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep756.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1028
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep756.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep756.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1032
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep756.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep756.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 1036
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep756.1.sroa_idx, align 4, !tbaa !30
  %gep756.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2048
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep756.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep756.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2052
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep756.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep756.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2056
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep756.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep756.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 2060
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep756.2.sroa_idx, align 4, !tbaa !30
  %gep756.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3072
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep756.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep756.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3076
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep756.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep756.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3080
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep756.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep756.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep755, i32 3084
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep756.3.sroa_idx, align 4, !tbaa !30
  %30 = lshr i32 %2, 2
  %mul323 = and i32 %30, 252
  %add317 = add i32 %30, %mul32
  %add338 = add i32 %mul323, %mul32
  %add359 = add i32 %mul323, %mul32
  %cmp373 = icmp slt i32 %add317, 0
  %cmp375 = icmp sgt i32 %add338, 127
  %or.cond695.not775 = or i1 %cmp373, %cmp375
  %cmp378.not = icmp sgt i32 %add359, %0
  %or.cond740 = or i1 %or.cond695.not775, %cmp378.not
  br i1 %or.cond740, label %if.then311.1, label %if.then379

if.then379:                                       ; preds = %if.end177.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0
  %mul382 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul382, float 0x4024CB5EC0000000)
  %32 = tail call contract noundef float @llvm.exp.f32(float %31)
  br label %if.then311.1

if.then311.1:                                     ; preds = %if.then379, %if.end177.3
  %condval_5.0 = phi float [ %32, %if.then379 ], [ 0.000000e+00, %if.end177.3 ]
  %add317.1 = add i32 %30, %mul32
  %add337.1 = or disjoint i32 %mul323, 1
  %add338.1 = add i32 %add337.1, %mul32
  %add358.1 = or disjoint i32 %mul323, 1
  %add359.1 = add i32 %add358.1, %mul32
  %cmp373.1 = icmp slt i32 %add317.1, 0
  %cmp375.1 = icmp sgt i32 %add338.1, 127
  %or.cond695.not775.1 = select i1 %cmp373.1, i1 true, i1 %cmp375.1
  %cmp378.not.1 = icmp sgt i32 %add359.1, %0
  %or.cond740.1 = select i1 %or.cond695.not775.1, i1 true, i1 %cmp378.not.1
  br i1 %or.cond740.1, label %if.then311.2, label %if.then379.1

if.then379.1:                                     ; preds = %if.then311.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1
  %mul382.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul382.1, float 0x4024CB5EC0000000)
  %34 = tail call contract noundef float @llvm.exp.f32(float %33)
  br label %if.then311.2

if.then311.2:                                     ; preds = %if.then311.1, %if.then379.1
  %condval_5.0.1 = phi float [ %34, %if.then379.1 ], [ 0.000000e+00, %if.then311.1 ]
  %add317.2 = add i32 %30, %mul32
  %add337.2 = or disjoint i32 %mul323, 2
  %add338.2 = add i32 %add337.2, %mul32
  %add358.2 = or disjoint i32 %mul323, 2
  %add359.2 = add i32 %add358.2, %mul32
  %cmp373.2 = icmp slt i32 %add317.2, 0
  %cmp375.2 = icmp sgt i32 %add338.2, 127
  %or.cond695.not775.2 = select i1 %cmp373.2, i1 true, i1 %cmp375.2
  %cmp378.not.2 = icmp sgt i32 %add359.2, %0
  %or.cond740.2 = select i1 %or.cond695.not775.2, i1 true, i1 %cmp378.not.2
  br i1 %or.cond740.2, label %if.then311.3, label %if.then379.2

if.then379.2:                                     ; preds = %if.then311.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2
  %mul382.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul382.2, float 0x4024CB5EC0000000)
  %36 = tail call contract noundef float @llvm.exp.f32(float %35)
  br label %if.then311.3

if.then311.3:                                     ; preds = %if.then311.2, %if.then379.2
  %condval_5.0.2 = phi float [ %36, %if.then379.2 ], [ 0.000000e+00, %if.then311.2 ]
  %add317.3 = add i32 %30, %mul32
  %add337.3 = or i32 %30, 3
  %add338.3 = add i32 %add337.3, %mul32
  %add358.3 = or i32 %30, 3
  %add359.3 = add i32 %add358.3, %mul32
  %cmp373.3 = icmp slt i32 %add317.3, 0
  %cmp375.3 = icmp sgt i32 %add338.3, 127
  %or.cond695.not775.3 = or i1 %cmp373.3, %cmp375.3
  %cmp378.not.3 = icmp sgt i32 %add359.3, %0
  %or.cond740.3 = or i1 %or.cond695.not775.3, %cmp378.not.3
  br i1 %or.cond740.3, label %if.else318.4, label %if.then379.3

if.then379.3:                                     ; preds = %if.then311.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3
  %mul382.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul382.3, float 0x4024CB5EC0000000)
  %38 = tail call contract noundef float @llvm.exp.f32(float %37)
  br label %if.else318.4

if.else318.4:                                     ; preds = %if.then311.3, %if.then379.3
  %condval_5.0.3 = phi float [ %38, %if.then379.3 ], [ 0.000000e+00, %if.then311.3 ]
  %sub329.4 = add i32 %30, %mul32.1
  %sub350.4 = add i32 %mul323, %mul32.1
  %sub371.4 = add i32 %mul323, %mul32.1
  %cmp373.4 = icmp slt i32 %sub329.4, 0
  %cmp375.4 = icmp sgt i32 %sub350.4, 127
  %or.cond695.not775.4 = or i1 %cmp373.4, %cmp375.4
  %cmp378.not.4 = icmp sgt i32 %sub371.4, %0
  %or.cond740.4 = select i1 %or.cond695.not775.4, i1 true, i1 %cmp378.not.4
  br i1 %or.cond740.4, label %if.else318.5, label %if.then379.4

if.then379.4:                                     ; preds = %if.else318.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %29, i64 0
  %mul382.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul382.4, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  br label %if.else318.5

if.else318.5:                                     ; preds = %if.else318.4, %if.then379.4
  %condval_5.0.4 = phi float [ %40, %if.then379.4 ], [ 0.000000e+00, %if.else318.4 ]
  %sub329.5 = add i32 %30, %mul32.1
  %add349.5 = or disjoint i32 %mul323, 1
  %sub350.5 = add i32 %add349.5, %mul32.1
  %add370.5 = or disjoint i32 %mul323, 1
  %sub371.5 = add i32 %add370.5, %mul32.1
  %cmp373.5 = icmp slt i32 %sub329.5, 0
  %cmp375.5 = icmp sgt i32 %sub350.5, 127
  %or.cond695.not775.5 = select i1 %cmp373.5, i1 true, i1 %cmp375.5
  %cmp378.not.5 = icmp sgt i32 %sub371.5, %0
  %or.cond740.5 = select i1 %or.cond695.not775.5, i1 true, i1 %cmp378.not.5
  br i1 %or.cond740.5, label %if.else318.6, label %if.then379.5

if.then379.5:                                     ; preds = %if.else318.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %29, i64 1
  %mul382.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul382.5, float 0x4024CB5EC0000000)
  %42 = tail call contract noundef float @llvm.exp.f32(float %41)
  br label %if.else318.6

if.else318.6:                                     ; preds = %if.else318.5, %if.then379.5
  %condval_5.0.5 = phi float [ %42, %if.then379.5 ], [ 0.000000e+00, %if.else318.5 ]
  %sub329.6 = add i32 %30, %mul32.1
  %add349.6 = or disjoint i32 %mul323, 2
  %sub350.6 = add i32 %add349.6, %mul32.1
  %add370.6 = or disjoint i32 %mul323, 2
  %sub371.6 = add i32 %add370.6, %mul32.1
  %cmp373.6 = icmp slt i32 %sub329.6, 0
  %cmp375.6 = icmp sgt i32 %sub350.6, 127
  %or.cond695.not775.6 = select i1 %cmp373.6, i1 true, i1 %cmp375.6
  %cmp378.not.6 = icmp sgt i32 %sub371.6, %0
  %or.cond740.6 = select i1 %or.cond695.not775.6, i1 true, i1 %cmp378.not.6
  br i1 %or.cond740.6, label %if.else318.7, label %if.then379.6

if.then379.6:                                     ; preds = %if.else318.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %29, i64 2
  %mul382.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul382.6, float 0x4024CB5EC0000000)
  %44 = tail call contract noundef float @llvm.exp.f32(float %43)
  br label %if.else318.7

if.else318.7:                                     ; preds = %if.else318.6, %if.then379.6
  %condval_5.0.6 = phi float [ %44, %if.then379.6 ], [ 0.000000e+00, %if.else318.6 ]
  %sub329.7 = add i32 %30, %mul32.1
  %add349.7 = or i32 %30, 3
  %sub350.7 = add i32 %add349.7, %mul32.1
  %add370.7 = or i32 %30, 3
  %sub371.7 = add i32 %add370.7, %mul32.1
  %cmp373.7 = icmp slt i32 %sub329.7, 0
  %cmp375.7 = icmp sgt i32 %sub350.7, 127
  %or.cond695.not775.7 = or i1 %cmp373.7, %cmp375.7
  %cmp378.not.7 = icmp sgt i32 %sub371.7, %0
  %or.cond740.7 = select i1 %or.cond695.not775.7, i1 true, i1 %cmp378.not.7
  br i1 %or.cond740.7, label %if.end386.7, label %if.then379.7

if.then379.7:                                     ; preds = %if.else318.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %29, i64 3
  %mul382.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul382.7, float 0x4024CB5EC0000000)
  %46 = tail call contract noundef float @llvm.exp.f32(float %45)
  br label %if.end386.7

if.end386.7:                                      ; preds = %if.then379.7, %if.else318.7
  %condval_5.0.7 = phi float [ %46, %if.then379.7 ], [ 0.000000e+00, %if.else318.7 ]
  %add406.1 = fadd contract float %condval_5.0, %condval_5.0.1
  %add406.2 = fadd contract float %add406.1, %condval_5.0.2
  %add406.3 = fadd contract float %add406.2, %condval_5.0.3
  %add406.1789 = fadd contract float %add406.3, %condval_5.0.4
  %add406.1.1 = fadd contract float %add406.1789, %condval_5.0.5
  %add406.2.1 = fadd contract float %add406.1.1, %condval_5.0.6
  %add406.3.1 = fadd contract float %add406.2.1, %condval_5.0.7
  %47 = bitcast float %add406.3.1 to i32
  %48 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %49 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %48) #10
  %xor.i.i = xor i32 %49, 32
  %50 = and i32 %49, -64
  %and.i.i = add nsw i32 %50, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %49
  %shl.i.i = shl i32 %cond.i.i, 2
  %51 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %47)
  %52 = bitcast i32 %51 to float
  %add417 = fadd contract float %add406.3.1, %52
  %53 = bitcast float %add417 to i32
  %54 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %55 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %54) #10
  %xor.i.i728 = xor i32 %55, 16
  %56 = and i32 %55, -64
  %and.i.i729 = add nsw i32 %56, 64
  %cmp.not.i.i730 = icmp slt i32 %xor.i.i728, %and.i.i729
  %cond.i.i731 = select i1 %cmp.not.i.i730, i32 %xor.i.i728, i32 %55
  %shl.i.i732 = shl i32 %cond.i.i731, 2
  %57 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i732, i32 %53)
  %58 = bitcast i32 %57 to float
  %add422 = fadd contract float %add417, %58
  %cmp425 = fcmp contract ogt float %add422, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add422
  %condval_9.0 = select i1 %cmp425, float %div, float 0.000000e+00
  %mul438 = fmul contract float %condval_9.0, %condval_5.0
  %mul438.1 = fmul contract float %condval_9.0, %condval_5.0.1
  %mul438.2 = fmul contract float %condval_9.0, %condval_5.0.2
  %mul438.3 = fmul contract float %condval_9.0, %condval_5.0.3
  %mul438.4 = fmul contract float %condval_9.0, %condval_5.0.4
  %mul438.5 = fmul contract float %condval_9.0, %condval_5.0.5
  %mul438.6 = fmul contract float %condval_9.0, %condval_5.0.6
  %mul438.7 = fmul contract float %condval_9.0, %condval_5.0.7
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438)
  %60 = insertelement <4 x i16> poison, i16 %59, i64 0
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.1)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 1
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.2)
  %64 = insertelement <4 x i16> %62, i16 %63, i64 2
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.3)
  %66 = insertelement <4 x i16> %64, i16 %65, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %66 to <4 x half>
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.4)
  %68 = insertelement <4 x i16> poison, i16 %67, i64 0
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.5)
  %70 = insertelement <4 x i16> %68, i16 %69, i64 1
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.6)
  %72 = insertelement <4 x i16> %70, i16 %71, i64 2
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul438.7)
  %74 = insertelement <4 x i16> %72, i16 %73, i64 3
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %74 to <4 x half>
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %mul482 = and i32 %add.ptr302.idx, 16128
  %and489 = and i32 %2, 15
  %add490 = or disjoint i32 %mul482, %and489
  %arrayidx492 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490
  %75 = load half, ptr addrspace(3) %arrayidx492, align 2, !tbaa !173
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %75, i64 0
  %add485.1 = or disjoint i32 %mul482, %and489
  %add490.1 = or disjoint i32 %add485.1, 64
  %arrayidx492.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1
  %76 = load half, ptr addrspace(3) %arrayidx492.1, align 2, !tbaa !173
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %76, i64 1
  %add485.2 = or disjoint i32 %mul482, %and489
  %add490.2 = or disjoint i32 %add485.2, 128
  %arrayidx492.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2
  %77 = load half, ptr addrspace(3) %arrayidx492.2, align 2, !tbaa !173
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %77, i64 2
  %add485.3 = or disjoint i32 %mul482, %and489
  %add490.3 = or disjoint i32 %add485.3, 192
  %arrayidx492.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3
  %78 = load half, ptr addrspace(3) %arrayidx492.3, align 2, !tbaa !173
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %78, i64 3
  %add487.1792 = or disjoint i32 %mul482, %and489
  %add490.1793 = or disjoint i32 %add487.1792, 16
  %arrayidx492.1794 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1793
  %79 = load half, ptr addrspace(3) %arrayidx492.1794, align 2, !tbaa !173
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %79, i64 0
  %add487.1.1 = or disjoint i32 %mul482, %and489
  %add490.1.1 = or disjoint i32 %add487.1.1, 80
  %arrayidx492.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.1
  %80 = load half, ptr addrspace(3) %arrayidx492.1.1, align 2, !tbaa !173
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %80, i64 1
  %add487.2.1 = or disjoint i32 %mul482, %and489
  %add490.2.1 = or disjoint i32 %add487.2.1, 144
  %arrayidx492.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.1
  %81 = load half, ptr addrspace(3) %arrayidx492.2.1, align 2, !tbaa !173
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %81, i64 2
  %add487.3.1 = or disjoint i32 %mul482, %and489
  %add490.3.1 = or disjoint i32 %add487.3.1, 208
  %arrayidx492.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.1
  %82 = load half, ptr addrspace(3) %arrayidx492.3.1, align 2, !tbaa !173
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %82, i64 3
  %add487.2796 = or disjoint i32 %mul482, %and489
  %add490.2797 = or disjoint i32 %add487.2796, 32
  %arrayidx492.2798 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2797
  %83 = load half, ptr addrspace(3) %arrayidx492.2798, align 2, !tbaa !173
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %83, i64 0
  %add487.1.2 = or disjoint i32 %mul482, %and489
  %add490.1.2 = or disjoint i32 %add487.1.2, 96
  %arrayidx492.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.2
  %84 = load half, ptr addrspace(3) %arrayidx492.1.2, align 2, !tbaa !173
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %84, i64 1
  %add487.2.2 = or disjoint i32 %mul482, %and489
  %add490.2.2 = or disjoint i32 %add487.2.2, 160
  %arrayidx492.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.2
  %85 = load half, ptr addrspace(3) %arrayidx492.2.2, align 2, !tbaa !173
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %85, i64 2
  %add487.3.2 = or disjoint i32 %mul482, %and489
  %add490.3.2 = or disjoint i32 %add487.3.2, 224
  %arrayidx492.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.2
  %86 = load half, ptr addrspace(3) %arrayidx492.3.2, align 2, !tbaa !173
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %86, i64 3
  %add487.3800 = or disjoint i32 %mul482, %and489
  %add490.3801 = or disjoint i32 %add487.3800, 48
  %arrayidx492.3802 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3801
  %87 = load half, ptr addrspace(3) %arrayidx492.3802, align 2, !tbaa !173
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %87, i64 0
  %add487.1.3 = or disjoint i32 %mul482, %and489
  %add490.1.3 = or disjoint i32 %add487.1.3, 112
  %arrayidx492.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.3
  %88 = load half, ptr addrspace(3) %arrayidx492.1.3, align 2, !tbaa !173
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %88, i64 1
  %add487.2.3 = or disjoint i32 %mul482, %and489
  %add490.2.3 = or disjoint i32 %add487.2.3, 176
  %arrayidx492.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.3
  %89 = load half, ptr addrspace(3) %arrayidx492.2.3, align 2, !tbaa !173
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %89, i64 2
  %add487.3.3 = or disjoint i32 %add.ptr302.idx, %and489
  %add490.3.3 = or i32 %add487.3.3, 240
  %arrayidx492.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.3
  %90 = load half, ptr addrspace(3) %arrayidx492.3.3, align 2, !tbaa !173
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %90, i64 3
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add483.1 = add nuw nsw i32 %mul482, 1024
  %add490.1804 = or disjoint i32 %add483.1, %and489
  %arrayidx492.1805 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1804
  %95 = load half, ptr addrspace(3) %arrayidx492.1805, align 2, !tbaa !173
  %vb.sroa.0.0.vec.insert832 = insertelement <4 x half> poison, half %95, i64 0
  %add485.1.1806 = add nuw nsw i32 %mul482, 1088
  %add490.1.1807 = or disjoint i32 %add485.1.1806, %and489
  %arrayidx492.1.1808 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.1807
  %96 = load half, ptr addrspace(3) %arrayidx492.1.1808, align 2, !tbaa !173
  %vb.sroa.0.2.vec.insert834 = insertelement <4 x half> %vb.sroa.0.0.vec.insert832, half %96, i64 1
  %add485.2.1810 = add nuw nsw i32 %mul482, 1152
  %add490.2.1811 = or disjoint i32 %add485.2.1810, %and489
  %arrayidx492.2.1812 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.1811
  %97 = load half, ptr addrspace(3) %arrayidx492.2.1812, align 2, !tbaa !173
  %vb.sroa.0.4.vec.insert836 = insertelement <4 x half> %vb.sroa.0.2.vec.insert834, half %97, i64 2
  %add485.3.1814 = add nuw nsw i32 %mul482, 1216
  %add490.3.1815 = or disjoint i32 %add485.3.1814, %and489
  %arrayidx492.3.1816 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.1815
  %98 = load half, ptr addrspace(3) %arrayidx492.3.1816, align 2, !tbaa !173
  %vb.sroa.0.6.vec.insert838 = insertelement <4 x half> %vb.sroa.0.4.vec.insert836, half %98, i64 3
  %add487.1792.1 = add nuw nsw i32 %mul482, 1040
  %add490.1793.1 = or disjoint i32 %add487.1792.1, %and489
  %arrayidx492.1794.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1793.1
  %99 = load half, ptr addrspace(3) %arrayidx492.1794.1, align 2, !tbaa !173
  %vb.sroa.12.8.vec.insert842 = insertelement <4 x half> poison, half %99, i64 0
  %add487.1.1.1 = add nuw nsw i32 %mul482, 1104
  %add490.1.1.1 = or disjoint i32 %add487.1.1.1, %and489
  %arrayidx492.1.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.1.1
  %100 = load half, ptr addrspace(3) %arrayidx492.1.1.1, align 2, !tbaa !173
  %vb.sroa.12.10.vec.insert844 = insertelement <4 x half> %vb.sroa.12.8.vec.insert842, half %100, i64 1
  %add487.2.1.1 = add nuw nsw i32 %mul482, 1168
  %add490.2.1.1 = or disjoint i32 %add487.2.1.1, %and489
  %arrayidx492.2.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.1.1
  %101 = load half, ptr addrspace(3) %arrayidx492.2.1.1, align 2, !tbaa !173
  %vb.sroa.12.12.vec.insert846 = insertelement <4 x half> %vb.sroa.12.10.vec.insert844, half %101, i64 2
  %add487.3.1.1 = add nuw nsw i32 %mul482, 1232
  %add490.3.1.1 = or disjoint i32 %add487.3.1.1, %and489
  %arrayidx492.3.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.1.1
  %102 = load half, ptr addrspace(3) %arrayidx492.3.1.1, align 2, !tbaa !173
  %vb.sroa.12.14.vec.insert848 = insertelement <4 x half> %vb.sroa.12.12.vec.insert846, half %102, i64 3
  %add487.2796.1 = add nuw nsw i32 %mul482, 1056
  %add490.2797.1 = or disjoint i32 %add487.2796.1, %and489
  %arrayidx492.2798.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2797.1
  %103 = load half, ptr addrspace(3) %arrayidx492.2798.1, align 2, !tbaa !173
  %vb.sroa.22.16.vec.insert852 = insertelement <4 x half> poison, half %103, i64 0
  %add487.1.2.1 = add nuw nsw i32 %mul482, 1120
  %add490.1.2.1 = or disjoint i32 %add487.1.2.1, %and489
  %arrayidx492.1.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.2.1
  %104 = load half, ptr addrspace(3) %arrayidx492.1.2.1, align 2, !tbaa !173
  %vb.sroa.22.18.vec.insert854 = insertelement <4 x half> %vb.sroa.22.16.vec.insert852, half %104, i64 1
  %add487.2.2.1 = add nuw nsw i32 %mul482, 1184
  %add490.2.2.1 = or disjoint i32 %add487.2.2.1, %and489
  %arrayidx492.2.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.2.1
  %105 = load half, ptr addrspace(3) %arrayidx492.2.2.1, align 2, !tbaa !173
  %vb.sroa.22.20.vec.insert856 = insertelement <4 x half> %vb.sroa.22.18.vec.insert854, half %105, i64 2
  %add487.3.2.1 = add nuw nsw i32 %mul482, 1248
  %add490.3.2.1 = or disjoint i32 %add487.3.2.1, %and489
  %arrayidx492.3.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.2.1
  %106 = load half, ptr addrspace(3) %arrayidx492.3.2.1, align 2, !tbaa !173
  %vb.sroa.22.22.vec.insert858 = insertelement <4 x half> %vb.sroa.22.20.vec.insert856, half %106, i64 3
  %add487.3800.1 = add nuw nsw i32 %mul482, 1072
  %add490.3801.1 = or disjoint i32 %add487.3800.1, %and489
  %arrayidx492.3802.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3801.1
  %107 = load half, ptr addrspace(3) %arrayidx492.3802.1, align 2, !tbaa !173
  %vb.sroa.32.24.vec.insert862 = insertelement <4 x half> poison, half %107, i64 0
  %add487.1.3.1 = add nuw nsw i32 %mul482, 1136
  %add490.1.3.1 = or disjoint i32 %add487.1.3.1, %and489
  %arrayidx492.1.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.1.3.1
  %108 = load half, ptr addrspace(3) %arrayidx492.1.3.1, align 2, !tbaa !173
  %vb.sroa.32.26.vec.insert864 = insertelement <4 x half> %vb.sroa.32.24.vec.insert862, half %108, i64 1
  %add487.2.3.1 = add nuw nsw i32 %mul482, 1200
  %add490.2.3.1 = or disjoint i32 %add487.2.3.1, %and489
  %arrayidx492.2.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.2.3.1
  %109 = load half, ptr addrspace(3) %arrayidx492.2.3.1, align 2, !tbaa !173
  %vb.sroa.32.28.vec.insert866 = insertelement <4 x half> %vb.sroa.32.26.vec.insert864, half %109, i64 2
  %add487.3.3.1 = add nuw nsw i32 %mul482, 1264
  %add490.3.3.1 = or disjoint i32 %add487.3.3.1, %and489
  %arrayidx492.3.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add490.3.3.1
  %110 = load half, ptr addrspace(3) %arrayidx492.3.3.1, align 2, !tbaa !173
  %vb.sroa.32.30.vec.insert868 = insertelement <4 x half> %vb.sroa.32.28.vec.insert866, half %110, i64 3
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert838, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %91)
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert848, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %92)
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert858, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %93)
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert868, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %94)
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %111, i64 0
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_cast.sroa.0.0.insert.ext = zext i16 %115 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %111, i64 1
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_cast.sroa.0.2.insert.ext = zext i16 %116 to i64
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %111, i64 2
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_cast.sroa.0.4.insert.ext = zext i16 %117 to i64
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %111, i64 3
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_cast.sroa.0.6.insert.ext = zext i16 %118 to i64
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %112, i64 0
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract)
  %O_cast.sroa.7.8.insert.ext = zext i16 %119 to i64
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %112, i64 1
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract)
  %O_cast.sroa.7.10.insert.ext = zext i16 %120 to i64
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %112, i64 2
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract)
  %O_cast.sroa.7.12.insert.ext = zext i16 %121 to i64
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %112, i64 3
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract)
  %O_cast.sroa.7.14.insert.ext = zext i16 %122 to i64
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %113, i64 0
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract)
  %O_cast.sroa.12.16.insert.ext = zext i16 %123 to i64
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %113, i64 1
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract)
  %O_cast.sroa.12.18.insert.ext = zext i16 %124 to i64
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %113, i64 2
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract)
  %O_cast.sroa.12.20.insert.ext = zext i16 %125 to i64
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %113, i64 3
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract)
  %O_cast.sroa.12.22.insert.ext = zext i16 %126 to i64
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %114, i64 0
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract)
  %O_cast.sroa.17.24.insert.ext = zext i16 %127 to i64
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %114, i64 1
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract)
  %O_cast.sroa.17.26.insert.ext = zext i16 %128 to i64
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %114, i64 2
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract)
  %O_cast.sroa.17.28.insert.ext = zext i16 %129 to i64
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %114, i64 3
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract)
  %O_cast.sroa.17.30.insert.ext = zext i16 %130 to i64
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift
  %add566 = add nuw nsw i32 %add10, %mul323
  %131 = zext nneg i32 %add566 to i64
  %add.ptr572 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr572, align 8
  %132 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131
  %add.ptr572.1 = getelementptr inbounds i8, ptr addrspace(1) %132, i64 32
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr572.1, align 8
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131
  %add.ptr572.2 = getelementptr inbounds i8, ptr addrspace(1) %133, i64 64
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr572.2, align 8
  %134 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131
  %add.ptr572.3 = getelementptr inbounds i8, ptr addrspace(1) %134, i64 96
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr572.3, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare void @llvm.mxc.barrier() #7

declare float @llvm.exp.f32(float) #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.minnum.f32(float, float) #8

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
attributes #10 = { nomerge }


