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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !call_argsrelate !48
  %cond.i.i796 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i796, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i796.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i796.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i796.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i796.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i796.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i796.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i796.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i796.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i796.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i796.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i796.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i796.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i796.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i796.7, 4
  %mul20 = shl nsw i32 %0, 20
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %18 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !54
  %and = shl nuw nsw i32 %18, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %19 = lshr i32 %18, 1
  %mul30 = and i32 %19, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %20 = zext nneg i32 %add28 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20
  %qr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %qr.sroa.7.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %qr.sroa.7.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.7.0.add.ptr.sroa_idx, align 8
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64
  %qr.sroa.11.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %qr.sroa.16.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72
  %qr.sroa.16.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.16.16.add.ptr.1.sroa_idx, align 8
  %mul103 = shl nsw i32 %0, 16
  %mul110 = shl nuw nsw i32 %18, 3
  %add108 = or disjoint i32 %mul110, %mul103
  %invariant.op = add nsw i32 %1, -15
  %22 = lshr i32 %18, 2
  %mul175 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp101.not = icmp sgt i32 %mul11, %1
  %or.cond854 = or i1 %or.cond, %cmp101.not
  br i1 %or.cond854, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %23 = shl nsw i32 %cond.i.i796, 10
  %mul105 = and i32 %23, 64512
  %add111 = add nuw nsw i32 %add108, %mul105
  %idx.ext112 = zext nneg i32 %add111 to i64
  %add.ptr113 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112
  %kr.sroa.0.0.copyload2327 = load <4 x half>, ptr addrspace(4) %add.ptr113, align 16
  %kr.sroa.18.0.add.ptr113.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113, i64 8
  %kr.sroa.18.0.copyload2328 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  %24 = phi <4 x half> [ %kr.sroa.18.0.copyload2328, %if.then ], [ zeroinitializer, %entry ]
  %25 = phi <4 x half> [ %kr.sroa.0.0.copyload2327, %if.then ], [ zeroinitializer, %entry ]
  %or.cond.1 = icmp ugt i32 %mul11.1, 1023
  %cmp101.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond854.1 = or i1 %or.cond.1, %cmp101.not.1
  br i1 %or.cond854.1, label %if.end.1, label %if.then.1

if.then.1:                                        ; preds = %if.end
  %26 = shl nsw i32 %cond.i.i796.1, 10
  %mul105.1 = and i32 %26, 64512
  %add111.1 = add nuw nsw i32 %add108, %mul105.1
  %idx.ext112.1 = zext nneg i32 %add111.1 to i64
  %add.ptr113.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1
  %kr.sroa.30.16.copyload2329 = load <4 x half>, ptr addrspace(4) %add.ptr113.1, align 16
  %kr.sroa.46.16.add.ptr113.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1, i64 8
  %kr.sroa.46.16.copyload2330 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.sroa_idx, align 8
  br label %if.end.1

if.end.1:                                         ; preds = %if.end, %if.then.1
  %27 = phi <4 x half> [ %kr.sroa.46.16.copyload2330, %if.then.1 ], [ zeroinitializer, %if.end ]
  %28 = phi <4 x half> [ %kr.sroa.30.16.copyload2329, %if.then.1 ], [ zeroinitializer, %if.end ]
  %add106.1 = add nuw nsw i32 %add108, 512
  br i1 %or.cond854, label %if.end.1895, label %if.then.1888

if.then.1888:                                     ; preds = %if.end.1
  %29 = shl nsw i32 %cond.i.i796, 10
  %mul105.1882 = and i32 %29, 64512
  %add111.1883 = add nuw nsw i32 %add106.1, %mul105.1882
  %idx.ext112.1884 = zext nneg i32 %add111.1883 to i64
  %add.ptr113.1885 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884
  %kr.sroa.58.32.copyload2331 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885, align 16
  %kr.sroa.74.32.add.ptr113.1885.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885, i64 8
  %kr.sroa.74.32.copyload2332 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.sroa_idx, align 8
  br label %if.end.1895

if.end.1895:                                      ; preds = %if.end.1, %if.then.1888
  %30 = phi <4 x half> [ %kr.sroa.74.32.copyload2332, %if.then.1888 ], [ zeroinitializer, %if.end.1 ]
  %31 = phi <4 x half> [ %kr.sroa.58.32.copyload2331, %if.then.1888 ], [ zeroinitializer, %if.end.1 ]
  br i1 %or.cond854.1, label %if.end.1.1, label %if.then.1.1

if.then.1.1:                                      ; preds = %if.end.1895
  %32 = shl nsw i32 %cond.i.i796.1, 10
  %mul105.1.1 = and i32 %32, 64512
  %add111.1.1 = add nuw nsw i32 %add106.1, %mul105.1.1
  %idx.ext112.1.1 = zext nneg i32 %add111.1.1 to i64
  %add.ptr113.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1
  %kr.sroa.86.48.copyload2333 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1, align 16
  %kr.sroa.102.48.add.ptr113.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1, i64 8
  %kr.sroa.102.48.copyload2334 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.sroa_idx, align 8
  br label %if.end.1.1

if.end.1.1:                                       ; preds = %if.end.1895, %if.then.1.1
  %33 = phi <4 x half> [ %kr.sroa.102.48.copyload2334, %if.then.1.1 ], [ zeroinitializer, %if.end.1895 ]
  %34 = phi <4 x half> [ %kr.sroa.86.48.copyload2333, %if.then.1.1 ], [ zeroinitializer, %if.end.1895 ]
  br i1 %or.cond854, label %if.end218, label %if.then164

if.then164:                                       ; preds = %if.end.1.1
  %cmp167 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp167, label %for.cond169.preheader, label %if.end218

for.cond169.preheader:                            ; preds = %if.then164
  %add176 = add nuw nsw i32 %mul11, %mul175
  %cmp179.not = icmp sgt i32 %add176, %1
  %spec.select = select i1 %cmp179.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1422 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp179.not.1.not = icmp slt i32 %add176, %1
  %spec.select.1 = select i1 %cmp179.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1475 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1422, float %spec.select.1, i64 1
  %add177.2 = or disjoint i32 %add176, 2
  %cmp179.not.2 = icmp sgt i32 %add177.2, %1
  %spec.select.2 = select i1 %cmp179.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1528 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1475, float %spec.select.2, i64 2
  %add177.3 = or disjoint i32 %add176, 3
  %cmp179.not.3 = icmp sgt i32 %add177.3, %1
  %spec.select.3 = select i1 %cmp179.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1581 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1528, float %spec.select.3, i64 3
  br label %if.end218

if.end218:                                        ; preds = %if.end.1.1, %if.then164, %for.cond169.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1581, %for.cond169.preheader ], [ zeroinitializer, %if.then164 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1 ]
  br i1 %or.cond854.1, label %if.end218.1, label %if.then164.1

if.then164.1:                                     ; preds = %if.end218
  %cmp167.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp167.1, label %for.cond169.preheader.1, label %if.end218.1

for.cond169.preheader.1:                          ; preds = %if.then164.1
  %add176.1 = add nuw nsw i32 %mul11.1, %mul175
  %cmp179.not.1897 = icmp sgt i32 %add176.1, %1
  %spec.select.1898 = select i1 %cmp179.not.1897, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.16.vec.insert1650 = insertelement <4 x float> poison, float %spec.select.1898, i64 0
  %cmp179.not.1.1.not = icmp slt i32 %add176.1, %1
  %spec.select.1.1 = select i1 %cmp179.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.146.20.vec.insert1703 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1650, float %spec.select.1.1, i64 1
  %add177.2.1 = or disjoint i32 %add176.1, 2
  %cmp179.not.2.1 = icmp sgt i32 %add177.2.1, %1
  %spec.select.2.1 = select i1 %cmp179.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.24.vec.insert1756 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1703, float %spec.select.2.1, i64 2
  %add177.3.1 = or disjoint i32 %add176.1, 3
  %cmp179.not.3.1 = icmp sgt i32 %add177.3.1, %1
  %spec.select.3.1 = select i1 %cmp179.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.28.vec.insert1809 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1756, float %spec.select.3.1, i64 3
  br label %if.end218.1

if.end218.1:                                      ; preds = %if.end218, %if.then164.1, %for.cond169.preheader.1
  %scores.sroa.146.0 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1809, %for.cond169.preheader.1 ], [ zeroinitializer, %if.then164.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218 ]
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %25, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.0), !call_argsrelate !74
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.0), !call_argsrelate !74
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %24, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %35), !call_argsrelate !74
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %36), !call_argsrelate !74
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %37), !call_argsrelate !74
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %38), !call_argsrelate !74
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %39), !call_argsrelate !74
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %40), !call_argsrelate !74
  br i1 %or.cond854, label %if.end335, label %for.cond274.preheader

for.cond274.preheader:                            ; preds = %if.end218.1
  %43 = shl nsw i32 %cond.i.i796, 10
  %mul281 = and i32 %43, 64512
  %add284 = add nuw nsw i32 %add108, %mul281
  %44 = zext nneg i32 %add284 to i64
  %add.ptr289 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %44
  %vr.sroa.0.0.copyload2335 = load <4 x half>, ptr addrspace(4) %add.ptr289, align 16
  %vr.sroa.22.0.add.ptr289.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289, i64 8
  %vr.sroa.22.0.copyload2336 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.sroa_idx, align 8
  %45 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %44
  %add.ptr289.1 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1024
  %vr.sroa.38.16.copyload2337 = load <4 x half>, ptr addrspace(4) %add.ptr289.1, align 16
  %vr.sroa.58.16.add.ptr289.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1032
  %vr.sroa.58.16.copyload2338 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.sroa_idx, align 8
  br label %if.end335

if.end335:                                        ; preds = %if.end218.1, %for.cond274.preheader
  %46 = phi <4 x half> [ %vr.sroa.58.16.copyload2338, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ]
  %47 = phi <4 x half> [ %vr.sroa.38.16.copyload2337, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ]
  %48 = phi <4 x half> [ %vr.sroa.22.0.copyload2336, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ]
  %49 = phi <4 x half> [ %vr.sroa.0.0.copyload2335, %for.cond274.preheader ], [ zeroinitializer, %if.end218.1 ]
  br i1 %or.cond854.1, label %if.end335.1, label %for.cond274.preheader.1

for.cond274.preheader.1:                          ; preds = %if.end335
  %50 = shl nsw i32 %cond.i.i796.1, 10
  %mul281.1 = and i32 %50, 64512
  %add284.1 = add nuw nsw i32 %add108, %mul281.1
  %51 = zext nneg i32 %add284.1 to i64
  %add.ptr289.1913 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %51
  %vr.sroa.74.32.copyload2339 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913, align 16
  %vr.sroa.94.32.add.ptr289.1913.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913, i64 8
  %vr.sroa.94.32.copyload2340 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.sroa_idx, align 8
  %52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %51
  %add.ptr289.1.1 = getelementptr inbounds i8, ptr addrspace(4) %52, i64 1024
  %vr.sroa.110.48.copyload2341 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1, align 16
  %vr.sroa.130.48.add.ptr289.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %52, i64 1032
  %vr.sroa.130.48.copyload2342 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.sroa_idx, align 8
  br label %if.end335.1

if.end335.1:                                      ; preds = %if.end335, %for.cond274.preheader.1
  %53 = phi <4 x half> [ %vr.sroa.130.48.copyload2342, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ]
  %54 = phi <4 x half> [ %vr.sroa.110.48.copyload2341, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ]
  %55 = phi <4 x half> [ %vr.sroa.94.32.copyload2340, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ]
  %56 = phi <4 x half> [ %vr.sroa.74.32.copyload2339, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ]
  br i1 %or.cond854, label %if.end415, label %for.cond352.preheader

for.cond352.preheader:                            ; preds = %if.end335.1
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %41, i64 0
  %mul360 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %57 = tail call contract noundef float @llvm.minnum.f32(float %mul360, float 0x4024CB5EC0000000)
  %58 = tail call contract noundef float @llvm.exp.f32(float %57)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %41, i64 1
  %mul360.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %59 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1, float 0x4024CB5EC0000000)
  %60 = tail call contract noundef float @llvm.exp.f32(float %59)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %41, i64 2
  %mul360.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %61 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2, float 0x4024CB5EC0000000)
  %62 = tail call contract noundef float @llvm.exp.f32(float %61)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %41, i64 3
  %mul360.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %63 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3, float 0x4024CB5EC0000000)
  %64 = tail call contract noundef float @llvm.exp.f32(float %63)
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %58)
  %66 = insertelement <4 x i16> poison, i16 %65, i64 0
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %60)
  %68 = insertelement <4 x i16> %66, i16 %67, i64 1
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %62)
  %70 = insertelement <4 x i16> %68, i16 %69, i64 2
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %64)
  %72 = insertelement <4 x i16> %70, i16 %71, i64 3
  %probs.sroa.0.6.vec.insert = bitcast <4 x i16> %72 to <4 x half>
  br label %if.end415

if.end415:                                        ; preds = %if.end335.1, %for.cond352.preheader
  %sums.sroa.56.0 = phi float [ %64, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ]
  %sums.sroa.38.0 = phi float [ %62, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ]
  %sums.sroa.20.0 = phi float [ %60, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ]
  %sums.sroa.0.0 = phi float [ %58, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.1 ]
  %probs.sroa.0.0 = phi <4 x half> [ %probs.sroa.0.6.vec.insert, %for.cond352.preheader ], [ zeroinitializer, %if.end335.1 ]
  br i1 %or.cond854.1, label %if.end415.1, label %for.cond352.preheader.1

for.cond352.preheader.1:                          ; preds = %if.end415
  %scores.sroa.146.16.vec.extract = extractelement <4 x float> %42, i64 0
  %mul360.1922 = fmul contract float %scores.sroa.146.16.vec.extract, 0x3FB99999A0000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922, float 0x4024CB5EC0000000)
  %74 = tail call contract noundef float @llvm.exp.f32(float %73)
  %scores.sroa.146.20.vec.extract = extractelement <4 x float> %42, i64 1
  %mul360.1.1 = fmul contract float %scores.sroa.146.20.vec.extract, 0x3FB99999A0000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1, float 0x4024CB5EC0000000)
  %76 = tail call contract noundef float @llvm.exp.f32(float %75)
  %scores.sroa.146.24.vec.extract = extractelement <4 x float> %42, i64 2
  %mul360.2.1 = fmul contract float %scores.sroa.146.24.vec.extract, 0x3FB99999A0000000
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1, float 0x4024CB5EC0000000)
  %78 = tail call contract noundef float @llvm.exp.f32(float %77)
  %scores.sroa.146.28.vec.extract = extractelement <4 x float> %42, i64 3
  %mul360.3.1 = fmul contract float %scores.sroa.146.28.vec.extract, 0x3FB99999A0000000
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1, float 0x4024CB5EC0000000)
  %80 = tail call contract noundef float @llvm.exp.f32(float %79)
  %add380.1924 = fadd contract float %sums.sroa.0.0, %74
  %add380.1.1 = fadd contract float %sums.sroa.20.0, %76
  %add380.2.1 = fadd contract float %sums.sroa.38.0, %78
  %add380.3.1 = fadd contract float %sums.sroa.56.0, %80
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74)
  %82 = insertelement <4 x i16> poison, i16 %81, i64 0
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76)
  %84 = insertelement <4 x i16> %82, i16 %83, i64 1
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78)
  %86 = insertelement <4 x i16> %84, i16 %85, i64 2
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80)
  %88 = insertelement <4 x i16> %86, i16 %87, i64 3
  %probs.sroa.46.14.vec.insert = bitcast <4 x i16> %88 to <4 x half>
  br label %if.end415.1

if.end415.1:                                      ; preds = %if.end415, %for.cond352.preheader.1
  %sums.sroa.56.1 = phi float [ %add380.3.1, %for.cond352.preheader.1 ], [ %sums.sroa.56.0, %if.end415 ]
  %sums.sroa.38.1 = phi float [ %add380.2.1, %for.cond352.preheader.1 ], [ %sums.sroa.38.0, %if.end415 ]
  %sums.sroa.20.1 = phi float [ %add380.1.1, %for.cond352.preheader.1 ], [ %sums.sroa.20.0, %if.end415 ]
  %sums.sroa.0.1 = phi float [ %add380.1924, %for.cond352.preheader.1 ], [ %sums.sroa.0.0, %if.end415 ]
  %probs.sroa.46.0 = phi <4 x half> [ %probs.sroa.46.14.vec.insert, %for.cond352.preheader.1 ], [ zeroinitializer, %if.end415 ]
  br i1 %or.cond854, label %if.end477, label %for.cond434.preheader

for.cond434.preheader:                            ; preds = %if.end415.1
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %49, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer)
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer)
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %47, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer)
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %46, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end477

if.end477:                                        ; preds = %for.cond434.preheader, %if.end415.1
  %out.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %92, %for.cond434.preheader ]
  %out.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %91, %for.cond434.preheader ]
  %out.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %90, %for.cond434.preheader ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end415.1 ], [ %89, %for.cond434.preheader ]
  br i1 %or.cond854.1, label %if.end477.1, label %for.cond455.preheader.1

for.cond455.preheader.1:                          ; preds = %if.end477
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer)
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer)
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %53, <4 x half> %probs.sroa.46.0, <4 x float> zeroinitializer)
  br label %if.end477.1

if.end477.1:                                      ; preds = %for.cond455.preheader.1, %if.end477
  %out_1.sroa.74.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %96, %for.cond455.preheader.1 ]
  %out_1.sroa.50.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %95, %for.cond455.preheader.1 ]
  %out_1.sroa.26.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %94, %for.cond455.preheader.1 ]
  %out_1.sroa.0.1 = phi <4 x float> [ zeroinitializer, %if.end477 ], [ %93, %for.cond455.preheader.1 ]
  %or.cond.1930 = icmp ugt i32 %mul11.2, 1023
  %cmp101.not.1931 = icmp sgt i32 %mul11.2, %1
  %or.cond854.1932 = or i1 %or.cond.1930, %cmp101.not.1931
  br i1 %or.cond854.1932, label %if.end.1947, label %if.then.1938

if.then.1938:                                     ; preds = %if.end477.1
  %97 = shl nsw i32 %cond.i.i796.2, 10
  %mul105.1934 = and i32 %97, 64512
  %add111.1935 = add nuw nsw i32 %add108, %mul105.1934
  %idx.ext112.1936 = zext nneg i32 %add111.1935 to i64
  %add.ptr113.1937 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1936
  %kr.sroa.0.0.copyload18712343 = load <4 x half>, ptr addrspace(4) %add.ptr113.1937, align 16
  %kr.sroa.18.0.add.ptr113.1937.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1937, i64 8
  %kr.sroa.18.0.copyload18802344 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.1937.sroa_idx, align 8
  br label %if.end.1947

if.end.1947:                                      ; preds = %if.end477.1, %if.then.1938
  %98 = phi <4 x half> [ %kr.sroa.18.0.copyload18802344, %if.then.1938 ], [ zeroinitializer, %if.end477.1 ]
  %99 = phi <4 x half> [ %kr.sroa.0.0.copyload18712343, %if.then.1938 ], [ zeroinitializer, %if.end477.1 ]
  %or.cond.1.1944 = icmp ugt i32 %mul11.3, 1023
  %cmp101.not.1.1945 = icmp sgt i32 %mul11.3, %1
  %or.cond854.1.1946 = or i1 %or.cond.1.1944, %cmp101.not.1.1945
  br i1 %or.cond854.1.1946, label %if.end.1.1957, label %if.then.1.1952

if.then.1.1952:                                   ; preds = %if.end.1947
  %100 = shl nsw i32 %cond.i.i796.3, 10
  %mul105.1.1948 = and i32 %100, 64512
  %add111.1.1949 = add nuw nsw i32 %add108, %mul105.1.1948
  %idx.ext112.1.1950 = zext nneg i32 %add111.1.1949 to i64
  %add.ptr113.1.1951 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1950
  %kr.sroa.30.16.copyload19092345 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1951, align 16
  %kr.sroa.46.16.add.ptr113.1.1951.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1951, i64 8
  %kr.sroa.46.16.copyload19182346 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.1951.sroa_idx, align 8
  br label %if.end.1.1957

if.end.1.1957:                                    ; preds = %if.end.1947, %if.then.1.1952
  %101 = phi <4 x half> [ %kr.sroa.46.16.copyload19182346, %if.then.1.1952 ], [ zeroinitializer, %if.end.1947 ]
  %102 = phi <4 x half> [ %kr.sroa.30.16.copyload19092345, %if.then.1.1952 ], [ zeroinitializer, %if.end.1947 ]
  br i1 %or.cond854.1932, label %if.end.1895.1, label %if.then.1888.1

if.then.1888.1:                                   ; preds = %if.end.1.1957
  %103 = shl nsw i32 %cond.i.i796.2, 10
  %mul105.1882.1 = and i32 %103, 64512
  %add111.1883.1 = add nuw nsw i32 %add106.1, %mul105.1882.1
  %idx.ext112.1884.1 = zext nneg i32 %add111.1883.1 to i64
  %add.ptr113.1885.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884.1
  %kr.sroa.58.32.copyload19472347 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885.1, align 16
  %kr.sroa.74.32.add.ptr113.1885.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885.1, i64 8
  %kr.sroa.74.32.copyload19562348 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.1.sroa_idx, align 8
  br label %if.end.1895.1

if.end.1895.1:                                    ; preds = %if.end.1.1957, %if.then.1888.1
  %104 = phi <4 x half> [ %kr.sroa.74.32.copyload19562348, %if.then.1888.1 ], [ zeroinitializer, %if.end.1.1957 ]
  %105 = phi <4 x half> [ %kr.sroa.58.32.copyload19472347, %if.then.1888.1 ], [ zeroinitializer, %if.end.1.1957 ]
  br i1 %or.cond854.1.1946, label %if.end.1.1.1, label %if.then.1.1.1

if.then.1.1.1:                                    ; preds = %if.end.1895.1
  %106 = shl nsw i32 %cond.i.i796.3, 10
  %mul105.1.1.1 = and i32 %106, 64512
  %add111.1.1.1 = add nuw nsw i32 %add106.1, %mul105.1.1.1
  %idx.ext112.1.1.1 = zext nneg i32 %add111.1.1.1 to i64
  %add.ptr113.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1.1
  %kr.sroa.86.48.copyload19852349 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1.1, align 16
  %kr.sroa.102.48.add.ptr113.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1.1, i64 8
  %kr.sroa.102.48.copyload19942350 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.1.sroa_idx, align 8
  br label %if.end.1.1.1

if.end.1.1.1:                                     ; preds = %if.end.1895.1, %if.then.1.1.1
  %107 = phi <4 x half> [ %kr.sroa.102.48.copyload19942350, %if.then.1.1.1 ], [ zeroinitializer, %if.end.1895.1 ]
  %108 = phi <4 x half> [ %kr.sroa.86.48.copyload19852349, %if.then.1.1.1 ], [ zeroinitializer, %if.end.1895.1 ]
  br i1 %or.cond854.1932, label %if.end218.1990, label %if.then164.1962

if.then164.1962:                                  ; preds = %if.end.1.1.1
  %cmp167.1961 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp167.1961, label %for.cond169.preheader.1969, label %if.end218.1990

for.cond169.preheader.1969:                       ; preds = %if.then164.1962
  %add176.1968 = add nuw nsw i32 %mul11.2, %mul175
  %cmp179.not.1970 = icmp sgt i32 %add176.1968, %1
  %spec.select.1971 = select i1 %cmp179.not.1970, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1435 = insertelement <4 x float> poison, float %spec.select.1971, i64 0
  %cmp179.not.1.1973.not = icmp slt i32 %add176.1968, %1
  %spec.select.1.1974 = select i1 %cmp179.not.1.1973.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1488 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1435, float %spec.select.1.1974, i64 1
  %add177.2.1976 = or disjoint i32 %add176.1968, 2
  %cmp179.not.2.1977 = icmp sgt i32 %add177.2.1976, %1
  %spec.select.2.1978 = select i1 %cmp179.not.2.1977, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1541 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1488, float %spec.select.2.1978, i64 2
  %add177.3.1980 = or disjoint i32 %add176.1968, 3
  %cmp179.not.3.1981 = icmp sgt i32 %add177.3.1980, %1
  %spec.select.3.1982 = select i1 %cmp179.not.3.1981, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1594 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1541, float %spec.select.3.1982, i64 3
  br label %if.end218.1990

if.end218.1990:                                   ; preds = %if.end.1.1.1, %if.then164.1962, %for.cond169.preheader.1969
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1594, %for.cond169.preheader.1969 ], [ zeroinitializer, %if.then164.1962 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1.1 ]
  br i1 %or.cond854.1.1946, label %if.end218.1.1, label %if.then164.1.1

if.then164.1.1:                                   ; preds = %if.end218.1990
  %cmp167.1.1 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp167.1.1, label %for.cond169.preheader.1.1, label %if.end218.1.1

for.cond169.preheader.1.1:                        ; preds = %if.then164.1.1
  %add176.1.1 = add nuw nsw i32 %mul11.3, %mul175
  %cmp179.not.1897.1 = icmp sgt i32 %add176.1.1, %1
  %spec.select.1898.1 = select i1 %cmp179.not.1897.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.16.vec.insert1663 = insertelement <4 x float> poison, float %spec.select.1898.1, i64 0
  %cmp179.not.1.1.1.not = icmp slt i32 %add176.1.1, %1
  %spec.select.1.1.1 = select i1 %cmp179.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.146.20.vec.insert1716 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1663, float %spec.select.1.1.1, i64 1
  %add177.2.1.1 = or disjoint i32 %add176.1.1, 2
  %cmp179.not.2.1.1 = icmp sgt i32 %add177.2.1.1, %1
  %spec.select.2.1.1 = select i1 %cmp179.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.24.vec.insert1769 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1716, float %spec.select.2.1.1, i64 2
  %add177.3.1.1 = or disjoint i32 %add176.1.1, 3
  %cmp179.not.3.1.1 = icmp sgt i32 %add177.3.1.1, %1
  %spec.select.3.1.1 = select i1 %cmp179.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.28.vec.insert1822 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1769, float %spec.select.3.1.1, i64 3
  br label %if.end218.1.1

if.end218.1.1:                                    ; preds = %if.end218.1990, %if.then164.1.1, %for.cond169.preheader.1.1
  %scores.sroa.146.2 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1822, %for.cond169.preheader.1.1 ], [ zeroinitializer, %if.then164.1.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.1990 ]
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %99, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.2), !call_argsrelate !74
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %102, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.2), !call_argsrelate !74
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %98, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %109), !call_argsrelate !74
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %101, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %110), !call_argsrelate !74
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %105, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %111), !call_argsrelate !74
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %108, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %112), !call_argsrelate !74
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %104, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %113), !call_argsrelate !74
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %107, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %114), !call_argsrelate !74
  br i1 %or.cond854.1932, label %if.end335.11015, label %for.cond274.preheader.11003

for.cond274.preheader.11003:                      ; preds = %if.end218.1.1
  %117 = shl nsw i32 %cond.i.i796.2, 10
  %mul281.11001 = and i32 %117, 64512
  %add284.11002 = add nuw nsw i32 %add108, %mul281.11001
  %118 = zext nneg i32 %add284.11002 to i64
  %add.ptr289.11004 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118
  %vr.sroa.0.0.copyload12352351 = load <4 x half>, ptr addrspace(4) %add.ptr289.11004, align 16
  %vr.sroa.22.0.add.ptr289.11004.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.11004, i64 8
  %vr.sroa.22.0.copyload12442352 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.11004.sroa_idx, align 8
  %119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118
  %add.ptr289.1.11005 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1024
  %vr.sroa.38.16.copyload12812353 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.11005, align 16
  %vr.sroa.58.16.add.ptr289.1.11005.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1032
  %vr.sroa.58.16.copyload12902354 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.11005.sroa_idx, align 8
  br label %if.end335.11015

if.end335.11015:                                  ; preds = %if.end218.1.1, %for.cond274.preheader.11003
  %120 = phi <4 x half> [ %vr.sroa.58.16.copyload12902354, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ]
  %121 = phi <4 x half> [ %vr.sroa.38.16.copyload12812353, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ]
  %122 = phi <4 x half> [ %vr.sroa.22.0.copyload12442352, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ]
  %123 = phi <4 x half> [ %vr.sroa.0.0.copyload12352351, %for.cond274.preheader.11003 ], [ zeroinitializer, %if.end218.1.1 ]
  br i1 %or.cond854.1.1946, label %if.end335.1.1, label %for.cond274.preheader.1.1

for.cond274.preheader.1.1:                        ; preds = %if.end335.11015
  %124 = shl nsw i32 %cond.i.i796.3, 10
  %mul281.1.1 = and i32 %124, 64512
  %add284.1.1 = add nuw nsw i32 %add108, %mul281.1.1
  %125 = zext nneg i32 %add284.1.1 to i64
  %add.ptr289.1913.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125
  %vr.sroa.74.32.copyload13272355 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913.1, align 16
  %vr.sroa.94.32.add.ptr289.1913.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913.1, i64 8
  %vr.sroa.94.32.copyload13362356 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.1.sroa_idx, align 8
  %126 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %125
  %add.ptr289.1.1.1 = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1024
  %vr.sroa.110.48.copyload13732357 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1.1, align 16
  %vr.sroa.130.48.add.ptr289.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %126, i64 1032
  %vr.sroa.130.48.copyload13822358 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.1.sroa_idx, align 8
  br label %if.end335.1.1

if.end335.1.1:                                    ; preds = %if.end335.11015, %for.cond274.preheader.1.1
  %127 = phi <4 x half> [ %vr.sroa.130.48.copyload13822358, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ]
  %128 = phi <4 x half> [ %vr.sroa.110.48.copyload13732357, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ]
  %129 = phi <4 x half> [ %vr.sroa.94.32.copyload13362356, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ]
  %130 = phi <4 x half> [ %vr.sroa.74.32.copyload13272355, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11015 ]
  br i1 %or.cond854.1932, label %if.end415.11051, label %for.cond352.preheader.11019

for.cond352.preheader.11019:                      ; preds = %if.end335.1.1
  %scores.sroa.0.0.vec.extract1439 = extractelement <4 x float> %115, i64 0
  %mul360.11020 = fmul contract float %scores.sroa.0.0.vec.extract1439, 0x3FB99999A0000000
  %131 = tail call contract noundef float @llvm.minnum.f32(float %mul360.11020, float 0x4024CB5EC0000000)
  %132 = tail call contract noundef float @llvm.exp.f32(float %131)
  %scores.sroa.0.4.vec.extract1492 = extractelement <4 x float> %115, i64 1
  %mul360.1.11022 = fmul contract float %scores.sroa.0.4.vec.extract1492, 0x3FB99999A0000000
  %133 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.11022, float 0x4024CB5EC0000000)
  %134 = tail call contract noundef float @llvm.exp.f32(float %133)
  %scores.sroa.0.8.vec.extract1545 = extractelement <4 x float> %115, i64 2
  %mul360.2.11024 = fmul contract float %scores.sroa.0.8.vec.extract1545, 0x3FB99999A0000000
  %135 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.11024, float 0x4024CB5EC0000000)
  %136 = tail call contract noundef float @llvm.exp.f32(float %135)
  %scores.sroa.0.12.vec.extract1598 = extractelement <4 x float> %115, i64 3
  %mul360.3.11026 = fmul contract float %scores.sroa.0.12.vec.extract1598, 0x3FB99999A0000000
  %137 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.11026, float 0x4024CB5EC0000000)
  %138 = tail call contract noundef float @llvm.exp.f32(float %137)
  %add380.11028 = fadd contract float %sums.sroa.0.1, %132
  %add380.1.11031 = fadd contract float %sums.sroa.20.1, %134
  %add380.2.11034 = fadd contract float %sums.sroa.38.1, %136
  %add380.3.11037 = fadd contract float %sums.sroa.56.1, %138
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %132)
  %140 = insertelement <4 x i16> poison, i16 %139, i64 0
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %134)
  %142 = insertelement <4 x i16> %140, i16 %141, i64 1
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %136)
  %144 = insertelement <4 x i16> %142, i16 %143, i64 2
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %138)
  %146 = insertelement <4 x i16> %144, i16 %145, i64 3
  %probs.sroa.0.6.vec.insert1150 = bitcast <4 x i16> %146 to <4 x half>
  br label %if.end415.11051

if.end415.11051:                                  ; preds = %if.end335.1.1, %for.cond352.preheader.11019
  %sums.sroa.56.2 = phi float [ %add380.3.11037, %for.cond352.preheader.11019 ], [ %sums.sroa.56.1, %if.end335.1.1 ]
  %sums.sroa.38.2 = phi float [ %add380.2.11034, %for.cond352.preheader.11019 ], [ %sums.sroa.38.1, %if.end335.1.1 ]
  %sums.sroa.20.2 = phi float [ %add380.1.11031, %for.cond352.preheader.11019 ], [ %sums.sroa.20.1, %if.end335.1.1 ]
  %sums.sroa.0.2 = phi float [ %add380.11028, %for.cond352.preheader.11019 ], [ %sums.sroa.0.1, %if.end335.1.1 ]
  %probs.sroa.0.1 = phi <4 x half> [ %probs.sroa.0.6.vec.insert1150, %for.cond352.preheader.11019 ], [ zeroinitializer, %if.end335.1.1 ]
  br i1 %or.cond854.1.1946, label %if.end415.1.1, label %for.cond352.preheader.1.1

for.cond352.preheader.1.1:                        ; preds = %if.end415.11051
  %scores.sroa.146.16.vec.extract1667 = extractelement <4 x float> %116, i64 0
  %mul360.1922.1 = fmul contract float %scores.sroa.146.16.vec.extract1667, 0x3FB99999A0000000
  %147 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922.1, float 0x4024CB5EC0000000)
  %148 = tail call contract noundef float @llvm.exp.f32(float %147)
  %scores.sroa.146.20.vec.extract1720 = extractelement <4 x float> %116, i64 1
  %mul360.1.1.1 = fmul contract float %scores.sroa.146.20.vec.extract1720, 0x3FB99999A0000000
  %149 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1.1, float 0x4024CB5EC0000000)
  %150 = tail call contract noundef float @llvm.exp.f32(float %149)
  %scores.sroa.146.24.vec.extract1773 = extractelement <4 x float> %116, i64 2
  %mul360.2.1.1 = fmul contract float %scores.sroa.146.24.vec.extract1773, 0x3FB99999A0000000
  %151 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1.1, float 0x4024CB5EC0000000)
  %152 = tail call contract noundef float @llvm.exp.f32(float %151)
  %scores.sroa.146.28.vec.extract1826 = extractelement <4 x float> %116, i64 3
  %mul360.3.1.1 = fmul contract float %scores.sroa.146.28.vec.extract1826, 0x3FB99999A0000000
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1.1, float 0x4024CB5EC0000000)
  %154 = tail call contract noundef float @llvm.exp.f32(float %153)
  %add380.1924.1 = fadd contract float %sums.sroa.0.2, %148
  %add380.1.1.1 = fadd contract float %sums.sroa.20.2, %150
  %add380.2.1.1 = fadd contract float %sums.sroa.38.2, %152
  %add380.3.1.1 = fadd contract float %sums.sroa.56.2, %154
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %148)
  %156 = insertelement <4 x i16> poison, i16 %155, i64 0
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %150)
  %158 = insertelement <4 x i16> %156, i16 %157, i64 1
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %152)
  %160 = insertelement <4 x i16> %158, i16 %159, i64 2
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154)
  %162 = insertelement <4 x i16> %160, i16 %161, i64 3
  %probs.sroa.46.14.vec.insert1210 = bitcast <4 x i16> %162 to <4 x half>
  br label %if.end415.1.1

if.end415.1.1:                                    ; preds = %if.end415.11051, %for.cond352.preheader.1.1
  %sums.sroa.56.3 = phi float [ %add380.3.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.56.2, %if.end415.11051 ]
  %sums.sroa.38.3 = phi float [ %add380.2.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.38.2, %if.end415.11051 ]
  %sums.sroa.20.3 = phi float [ %add380.1.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.20.2, %if.end415.11051 ]
  %sums.sroa.0.3 = phi float [ %add380.1924.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.0.2, %if.end415.11051 ]
  %probs.sroa.46.1 = phi <4 x half> [ %probs.sroa.46.14.vec.insert1210, %for.cond352.preheader.1.1 ], [ zeroinitializer, %if.end415.11051 ]
  br i1 %or.cond854.1932, label %if.end477.11073, label %for.cond434.preheader.11065

for.cond434.preheader.11065:                      ; preds = %if.end415.1.1
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %123, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.0.0)
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.42.0)
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %121, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.82.0)
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %120, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.122.0)
  br label %if.end477.11073

if.end477.11073:                                  ; preds = %for.cond434.preheader.11065, %if.end415.1.1
  %out.sroa.122.2 = phi <4 x float> [ %out.sroa.122.0, %if.end415.1.1 ], [ %166, %for.cond434.preheader.11065 ]
  %out.sroa.82.2 = phi <4 x float> [ %out.sroa.82.0, %if.end415.1.1 ], [ %165, %for.cond434.preheader.11065 ]
  %out.sroa.42.2 = phi <4 x float> [ %out.sroa.42.0, %if.end415.1.1 ], [ %164, %for.cond434.preheader.11065 ]
  %out.sroa.0.2 = phi <4 x float> [ %out.sroa.0.0, %if.end415.1.1 ], [ %163, %for.cond434.preheader.11065 ]
  br i1 %or.cond854.1.1946, label %if.end477.1.1, label %for.cond455.preheader.1.1

for.cond455.preheader.1.1:                        ; preds = %if.end477.11073
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %130, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.0.1)
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %129, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.26.1)
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %128, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.50.1)
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %127, <4 x half> %probs.sroa.46.1, <4 x float> %out_1.sroa.74.1)
  br label %if.end477.1.1

if.end477.1.1:                                    ; preds = %for.cond455.preheader.1.1, %if.end477.11073
  %out_1.sroa.74.3 = phi <4 x float> [ %out_1.sroa.74.1, %if.end477.11073 ], [ %170, %for.cond455.preheader.1.1 ]
  %out_1.sroa.50.3 = phi <4 x float> [ %out_1.sroa.50.1, %if.end477.11073 ], [ %169, %for.cond455.preheader.1.1 ]
  %out_1.sroa.26.3 = phi <4 x float> [ %out_1.sroa.26.1, %if.end477.11073 ], [ %168, %for.cond455.preheader.1.1 ]
  %out_1.sroa.0.3 = phi <4 x float> [ %out_1.sroa.0.1, %if.end477.11073 ], [ %167, %for.cond455.preheader.1.1 ]
  %or.cond.2 = icmp ugt i32 %mul11.4, 1023
  %cmp101.not.2 = icmp sgt i32 %mul11.4, %1
  %or.cond854.2 = or i1 %or.cond.2, %cmp101.not.2
  br i1 %or.cond854.2, label %if.end.2, label %if.then.2

if.then.2:                                        ; preds = %if.end477.1.1
  %171 = shl nsw i32 %cond.i.i796.4, 10
  %mul105.2 = and i32 %171, 64512
  %add111.2 = add nuw nsw i32 %add108, %mul105.2
  %idx.ext112.2 = zext nneg i32 %add111.2 to i64
  %add.ptr113.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.2
  %kr.sroa.0.0.copyload18722359 = load <4 x half>, ptr addrspace(4) %add.ptr113.2, align 16
  %kr.sroa.18.0.add.ptr113.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.2, i64 8
  %kr.sroa.18.0.copyload18812360 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.2.sroa_idx, align 8
  br label %if.end.2

if.end.2:                                         ; preds = %if.end477.1.1, %if.then.2
  %172 = phi <4 x half> [ %kr.sroa.18.0.copyload18812360, %if.then.2 ], [ zeroinitializer, %if.end477.1.1 ]
  %173 = phi <4 x half> [ %kr.sroa.0.0.copyload18722359, %if.then.2 ], [ zeroinitializer, %if.end477.1.1 ]
  %or.cond.1.2 = icmp ugt i32 %mul11.5, 1023
  %cmp101.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond854.1.2 = or i1 %or.cond.1.2, %cmp101.not.1.2
  br i1 %or.cond854.1.2, label %if.end.1.2, label %if.then.1.2

if.then.1.2:                                      ; preds = %if.end.2
  %174 = shl nsw i32 %cond.i.i796.5, 10
  %mul105.1.2 = and i32 %174, 64512
  %add111.1.2 = add nuw nsw i32 %add108, %mul105.1.2
  %idx.ext112.1.2 = zext nneg i32 %add111.1.2 to i64
  %add.ptr113.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.2
  %kr.sroa.30.16.copyload19102361 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.2, align 16
  %kr.sroa.46.16.add.ptr113.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.2, i64 8
  %kr.sroa.46.16.copyload19192362 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.2.sroa_idx, align 8
  br label %if.end.1.2

if.end.1.2:                                       ; preds = %if.end.2, %if.then.1.2
  %175 = phi <4 x half> [ %kr.sroa.46.16.copyload19192362, %if.then.1.2 ], [ zeroinitializer, %if.end.2 ]
  %176 = phi <4 x half> [ %kr.sroa.30.16.copyload19102361, %if.then.1.2 ], [ zeroinitializer, %if.end.2 ]
  br i1 %or.cond854.2, label %if.end.1895.2, label %if.then.1888.2

if.then.1888.2:                                   ; preds = %if.end.1.2
  %177 = shl nsw i32 %cond.i.i796.4, 10
  %mul105.1882.2 = and i32 %177, 64512
  %add111.1883.2 = add nuw nsw i32 %add106.1, %mul105.1882.2
  %idx.ext112.1884.2 = zext nneg i32 %add111.1883.2 to i64
  %add.ptr113.1885.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884.2
  %kr.sroa.58.32.copyload19482363 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885.2, align 16
  %kr.sroa.74.32.add.ptr113.1885.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885.2, i64 8
  %kr.sroa.74.32.copyload19572364 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.2.sroa_idx, align 8
  br label %if.end.1895.2

if.end.1895.2:                                    ; preds = %if.end.1.2, %if.then.1888.2
  %178 = phi <4 x half> [ %kr.sroa.74.32.copyload19572364, %if.then.1888.2 ], [ zeroinitializer, %if.end.1.2 ]
  %179 = phi <4 x half> [ %kr.sroa.58.32.copyload19482363, %if.then.1888.2 ], [ zeroinitializer, %if.end.1.2 ]
  br i1 %or.cond854.1.2, label %if.end.1.1.2, label %if.then.1.1.2

if.then.1.1.2:                                    ; preds = %if.end.1895.2
  %180 = shl nsw i32 %cond.i.i796.5, 10
  %mul105.1.1.2 = and i32 %180, 64512
  %add111.1.1.2 = add nuw nsw i32 %add106.1, %mul105.1.1.2
  %idx.ext112.1.1.2 = zext nneg i32 %add111.1.1.2 to i64
  %add.ptr113.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1.2
  %kr.sroa.86.48.copyload19862365 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1.2, align 16
  %kr.sroa.102.48.add.ptr113.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1.2, i64 8
  %kr.sroa.102.48.copyload19952366 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.2.sroa_idx, align 8
  br label %if.end.1.1.2

if.end.1.1.2:                                     ; preds = %if.end.1895.2, %if.then.1.1.2
  %181 = phi <4 x half> [ %kr.sroa.102.48.copyload19952366, %if.then.1.1.2 ], [ zeroinitializer, %if.end.1895.2 ]
  %182 = phi <4 x half> [ %kr.sroa.86.48.copyload19862365, %if.then.1.1.2 ], [ zeroinitializer, %if.end.1895.2 ]
  br i1 %or.cond854.2, label %if.end218.2, label %if.then164.2

if.then164.2:                                     ; preds = %if.end.1.1.2
  %cmp167.2 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp167.2, label %for.cond169.preheader.2, label %if.end218.2

for.cond169.preheader.2:                          ; preds = %if.then164.2
  %add176.2 = add nuw nsw i32 %mul11.4, %mul175
  %cmp179.not.21074 = icmp sgt i32 %add176.2, %1
  %spec.select.21075 = select i1 %cmp179.not.21074, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1449 = insertelement <4 x float> poison, float %spec.select.21075, i64 0
  %cmp179.not.1.2.not = icmp slt i32 %add176.2, %1
  %spec.select.1.2 = select i1 %cmp179.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1502 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1449, float %spec.select.1.2, i64 1
  %add177.2.2 = or disjoint i32 %add176.2, 2
  %cmp179.not.2.2 = icmp sgt i32 %add177.2.2, %1
  %spec.select.2.2 = select i1 %cmp179.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1555 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1502, float %spec.select.2.2, i64 2
  %add177.3.2 = or disjoint i32 %add176.2, 3
  %cmp179.not.3.2 = icmp sgt i32 %add177.3.2, %1
  %spec.select.3.2 = select i1 %cmp179.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1608 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1555, float %spec.select.3.2, i64 3
  br label %if.end218.2

if.end218.2:                                      ; preds = %if.end.1.1.2, %if.then164.2, %for.cond169.preheader.2
  %scores.sroa.0.4 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1608, %for.cond169.preheader.2 ], [ zeroinitializer, %if.then164.2 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1.2 ]
  br i1 %or.cond854.1.2, label %if.end218.1.2, label %if.then164.1.2

if.then164.1.2:                                   ; preds = %if.end218.2
  %cmp167.1.2 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp167.1.2, label %for.cond169.preheader.1.2, label %if.end218.1.2

for.cond169.preheader.1.2:                        ; preds = %if.then164.1.2
  %add176.1.2 = add nuw nsw i32 %mul11.5, %mul175
  %cmp179.not.1897.2 = icmp sgt i32 %add176.1.2, %1
  %spec.select.1898.2 = select i1 %cmp179.not.1897.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.16.vec.insert1677 = insertelement <4 x float> poison, float %spec.select.1898.2, i64 0
  %cmp179.not.1.1.2.not = icmp slt i32 %add176.1.2, %1
  %spec.select.1.1.2 = select i1 %cmp179.not.1.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.146.20.vec.insert1730 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1677, float %spec.select.1.1.2, i64 1
  %add177.2.1.2 = or disjoint i32 %add176.1.2, 2
  %cmp179.not.2.1.2 = icmp sgt i32 %add177.2.1.2, %1
  %spec.select.2.1.2 = select i1 %cmp179.not.2.1.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.24.vec.insert1783 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1730, float %spec.select.2.1.2, i64 2
  %add177.3.1.2 = or disjoint i32 %add176.1.2, 3
  %cmp179.not.3.1.2 = icmp sgt i32 %add177.3.1.2, %1
  %spec.select.3.1.2 = select i1 %cmp179.not.3.1.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.28.vec.insert1836 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1783, float %spec.select.3.1.2, i64 3
  br label %if.end218.1.2

if.end218.1.2:                                    ; preds = %if.end218.2, %if.then164.1.2, %for.cond169.preheader.1.2
  %scores.sroa.146.4 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1836, %for.cond169.preheader.1.2 ], [ zeroinitializer, %if.then164.1.2 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.2 ]
  %183 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %173, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.4), !call_argsrelate !74
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %176, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.4), !call_argsrelate !74
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %172, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %183), !call_argsrelate !74
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %175, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %184), !call_argsrelate !74
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %179, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %185), !call_argsrelate !74
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %182, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %186), !call_argsrelate !74
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %178, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %187), !call_argsrelate !74
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %181, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %188), !call_argsrelate !74
  br i1 %or.cond854.2, label %if.end335.2, label %for.cond274.preheader.2

for.cond274.preheader.2:                          ; preds = %if.end218.1.2
  %191 = shl nsw i32 %cond.i.i796.4, 10
  %mul281.2 = and i32 %191, 64512
  %add284.2 = add nuw nsw i32 %add108, %mul281.2
  %192 = zext nneg i32 %add284.2 to i64
  %add.ptr289.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %192
  %vr.sroa.0.0.copyload12362375 = load <4 x half>, ptr addrspace(4) %add.ptr289.2, align 16
  %vr.sroa.22.0.add.ptr289.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.2, i64 8
  %vr.sroa.22.0.copyload12452376 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.2.sroa_idx, align 8
  %193 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %192
  %add.ptr289.1.2 = getelementptr inbounds i8, ptr addrspace(4) %193, i64 1024
  %vr.sroa.38.16.copyload12822377 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.2, align 16
  %vr.sroa.58.16.add.ptr289.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %193, i64 1032
  %vr.sroa.58.16.copyload12912378 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.2.sroa_idx, align 8
  br label %if.end335.2

if.end335.2:                                      ; preds = %if.end218.1.2, %for.cond274.preheader.2
  %194 = phi <4 x half> [ %vr.sroa.58.16.copyload12912378, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ]
  %195 = phi <4 x half> [ %vr.sroa.38.16.copyload12822377, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ]
  %196 = phi <4 x half> [ %vr.sroa.22.0.copyload12452376, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ]
  %197 = phi <4 x half> [ %vr.sroa.0.0.copyload12362375, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end218.1.2 ]
  br i1 %or.cond854.1.2, label %if.end335.1.2, label %for.cond274.preheader.1.2

for.cond274.preheader.1.2:                        ; preds = %if.end335.2
  %198 = shl nsw i32 %cond.i.i796.5, 10
  %mul281.1.2 = and i32 %198, 64512
  %add284.1.2 = add nuw nsw i32 %add108, %mul281.1.2
  %199 = zext nneg i32 %add284.1.2 to i64
  %add.ptr289.1913.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199
  %vr.sroa.74.32.copyload13282379 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913.2, align 16
  %vr.sroa.94.32.add.ptr289.1913.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913.2, i64 8
  %vr.sroa.94.32.copyload13372380 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.2.sroa_idx, align 8
  %200 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199
  %add.ptr289.1.1.2 = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1024
  %vr.sroa.110.48.copyload13742381 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1.2, align 16
  %vr.sroa.130.48.add.ptr289.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1032
  %vr.sroa.130.48.copyload13832382 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.2.sroa_idx, align 8
  br label %if.end335.1.2

if.end335.1.2:                                    ; preds = %if.end335.2, %for.cond274.preheader.1.2
  %201 = phi <4 x half> [ %vr.sroa.130.48.copyload13832382, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ]
  %202 = phi <4 x half> [ %vr.sroa.110.48.copyload13742381, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ]
  %203 = phi <4 x half> [ %vr.sroa.94.32.copyload13372380, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ]
  %204 = phi <4 x half> [ %vr.sroa.74.32.copyload13282379, %for.cond274.preheader.1.2 ], [ zeroinitializer, %if.end335.2 ]
  br i1 %or.cond854.2, label %if.end415.2, label %for.cond352.preheader.2

for.cond352.preheader.2:                          ; preds = %if.end335.1.2
  %scores.sroa.0.0.vec.extract1453 = extractelement <4 x float> %189, i64 0
  %mul360.21076 = fmul contract float %scores.sroa.0.0.vec.extract1453, 0x3FB99999A0000000
  %205 = tail call contract noundef float @llvm.minnum.f32(float %mul360.21076, float 0x4024CB5EC0000000)
  %206 = tail call contract noundef float @llvm.exp.f32(float %205)
  %scores.sroa.0.4.vec.extract1506 = extractelement <4 x float> %189, i64 1
  %mul360.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1506, 0x3FB99999A0000000
  %207 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.2, float 0x4024CB5EC0000000)
  %208 = tail call contract noundef float @llvm.exp.f32(float %207)
  %scores.sroa.0.8.vec.extract1559 = extractelement <4 x float> %189, i64 2
  %mul360.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1559, 0x3FB99999A0000000
  %209 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.2, float 0x4024CB5EC0000000)
  %210 = tail call contract noundef float @llvm.exp.f32(float %209)
  %scores.sroa.0.12.vec.extract1612 = extractelement <4 x float> %189, i64 3
  %mul360.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1612, 0x3FB99999A0000000
  %211 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.2, float 0x4024CB5EC0000000)
  %212 = tail call contract noundef float @llvm.exp.f32(float %211)
  %add380.21077 = fadd contract float %sums.sroa.0.3, %206
  %add380.1.2 = fadd contract float %sums.sroa.20.3, %208
  %add380.2.2 = fadd contract float %sums.sroa.38.3, %210
  %add380.3.2 = fadd contract float %sums.sroa.56.3, %212
  %213 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %206)
  %214 = insertelement <4 x i16> poison, i16 %213, i64 0
  %215 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %208)
  %216 = insertelement <4 x i16> %214, i16 %215, i64 1
  %217 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %210)
  %218 = insertelement <4 x i16> %216, i16 %217, i64 2
  %219 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %212)
  %220 = insertelement <4 x i16> %218, i16 %219, i64 3
  %probs.sroa.0.6.vec.insert1154 = bitcast <4 x i16> %220 to <4 x half>
  br label %if.end415.2

if.end415.2:                                      ; preds = %if.end335.1.2, %for.cond352.preheader.2
  %sums.sroa.56.4 = phi float [ %add380.3.2, %for.cond352.preheader.2 ], [ %sums.sroa.56.3, %if.end335.1.2 ]
  %sums.sroa.38.4 = phi float [ %add380.2.2, %for.cond352.preheader.2 ], [ %sums.sroa.38.3, %if.end335.1.2 ]
  %sums.sroa.20.4 = phi float [ %add380.1.2, %for.cond352.preheader.2 ], [ %sums.sroa.20.3, %if.end335.1.2 ]
  %sums.sroa.0.4 = phi float [ %add380.21077, %for.cond352.preheader.2 ], [ %sums.sroa.0.3, %if.end335.1.2 ]
  %probs.sroa.0.2 = phi <4 x half> [ %probs.sroa.0.6.vec.insert1154, %for.cond352.preheader.2 ], [ zeroinitializer, %if.end335.1.2 ]
  br i1 %or.cond854.1.2, label %if.end415.1.2, label %for.cond352.preheader.1.2

for.cond352.preheader.1.2:                        ; preds = %if.end415.2
  %scores.sroa.146.16.vec.extract1681 = extractelement <4 x float> %190, i64 0
  %mul360.1922.2 = fmul contract float %scores.sroa.146.16.vec.extract1681, 0x3FB99999A0000000
  %221 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922.2, float 0x4024CB5EC0000000)
  %222 = tail call contract noundef float @llvm.exp.f32(float %221)
  %scores.sroa.146.20.vec.extract1734 = extractelement <4 x float> %190, i64 1
  %mul360.1.1.2 = fmul contract float %scores.sroa.146.20.vec.extract1734, 0x3FB99999A0000000
  %223 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1.2, float 0x4024CB5EC0000000)
  %224 = tail call contract noundef float @llvm.exp.f32(float %223)
  %scores.sroa.146.24.vec.extract1787 = extractelement <4 x float> %190, i64 2
  %mul360.2.1.2 = fmul contract float %scores.sroa.146.24.vec.extract1787, 0x3FB99999A0000000
  %225 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1.2, float 0x4024CB5EC0000000)
  %226 = tail call contract noundef float @llvm.exp.f32(float %225)
  %scores.sroa.146.28.vec.extract1840 = extractelement <4 x float> %190, i64 3
  %mul360.3.1.2 = fmul contract float %scores.sroa.146.28.vec.extract1840, 0x3FB99999A0000000
  %227 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1.2, float 0x4024CB5EC0000000)
  %228 = tail call contract noundef float @llvm.exp.f32(float %227)
  %add380.1924.2 = fadd contract float %sums.sroa.0.4, %222
  %add380.1.1.2 = fadd contract float %sums.sroa.20.4, %224
  %add380.2.1.2 = fadd contract float %sums.sroa.38.4, %226
  %add380.3.1.2 = fadd contract float %sums.sroa.56.4, %228
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %222)
  %230 = insertelement <4 x i16> poison, i16 %229, i64 0
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %224)
  %232 = insertelement <4 x i16> %230, i16 %231, i64 1
  %233 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %226)
  %234 = insertelement <4 x i16> %232, i16 %233, i64 2
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %228)
  %236 = insertelement <4 x i16> %234, i16 %235, i64 3
  %probs.sroa.46.14.vec.insert1214 = bitcast <4 x i16> %236 to <4 x half>
  br label %if.end415.1.2

if.end415.1.2:                                    ; preds = %if.end415.2, %for.cond352.preheader.1.2
  %sums.sroa.56.5 = phi float [ %add380.3.1.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.56.4, %if.end415.2 ]
  %sums.sroa.38.5 = phi float [ %add380.2.1.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.38.4, %if.end415.2 ]
  %sums.sroa.20.5 = phi float [ %add380.1.1.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.20.4, %if.end415.2 ]
  %sums.sroa.0.5 = phi float [ %add380.1924.2, %for.cond352.preheader.1.2 ], [ %sums.sroa.0.4, %if.end415.2 ]
  %probs.sroa.46.2 = phi <4 x half> [ %probs.sroa.46.14.vec.insert1214, %for.cond352.preheader.1.2 ], [ zeroinitializer, %if.end415.2 ]
  br i1 %or.cond854.2, label %if.end477.2, label %for.cond434.preheader.2

for.cond434.preheader.2:                          ; preds = %if.end415.1.2
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %197, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.0.2)
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %196, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.42.2)
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %195, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.82.2)
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %194, <4 x half> %probs.sroa.0.2, <4 x float> %out.sroa.122.2)
  br label %if.end477.2

if.end477.2:                                      ; preds = %for.cond434.preheader.2, %if.end415.1.2
  %out.sroa.122.4 = phi <4 x float> [ %out.sroa.122.2, %if.end415.1.2 ], [ %240, %for.cond434.preheader.2 ]
  %out.sroa.82.4 = phi <4 x float> [ %out.sroa.82.2, %if.end415.1.2 ], [ %239, %for.cond434.preheader.2 ]
  %out.sroa.42.4 = phi <4 x float> [ %out.sroa.42.2, %if.end415.1.2 ], [ %238, %for.cond434.preheader.2 ]
  %out.sroa.0.4 = phi <4 x float> [ %out.sroa.0.2, %if.end415.1.2 ], [ %237, %for.cond434.preheader.2 ]
  br i1 %or.cond854.1.2, label %if.end477.1.2, label %for.cond455.preheader.1.2

for.cond455.preheader.1.2:                        ; preds = %if.end477.2
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %204, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.0.3)
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %203, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.26.3)
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %202, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.50.3)
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %201, <4 x half> %probs.sroa.46.2, <4 x float> %out_1.sroa.74.3)
  br label %if.end477.1.2

if.end477.1.2:                                    ; preds = %for.cond455.preheader.1.2, %if.end477.2
  %out_1.sroa.74.5 = phi <4 x float> [ %out_1.sroa.74.3, %if.end477.2 ], [ %244, %for.cond455.preheader.1.2 ]
  %out_1.sroa.50.5 = phi <4 x float> [ %out_1.sroa.50.3, %if.end477.2 ], [ %243, %for.cond455.preheader.1.2 ]
  %out_1.sroa.26.5 = phi <4 x float> [ %out_1.sroa.26.3, %if.end477.2 ], [ %242, %for.cond455.preheader.1.2 ]
  %out_1.sroa.0.5 = phi <4 x float> [ %out_1.sroa.0.3, %if.end477.2 ], [ %241, %for.cond455.preheader.1.2 ]
  %or.cond.3 = icmp ugt i32 %mul11.6, 1023
  %cmp101.not.3 = icmp sgt i32 %mul11.6, %1
  %or.cond854.3 = or i1 %or.cond.3, %cmp101.not.3
  br i1 %or.cond854.3, label %if.end.3, label %if.then.3

if.then.3:                                        ; preds = %if.end477.1.2
  %245 = shl nsw i32 %cond.i.i796.6, 10
  %mul105.3 = and i32 %245, 64512
  %add111.3 = add nuw nsw i32 %add108, %mul105.3
  %idx.ext112.3 = zext nneg i32 %add111.3 to i64
  %add.ptr113.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.3
  %kr.sroa.0.0.copyload18732367 = load <4 x half>, ptr addrspace(4) %add.ptr113.3, align 16
  %kr.sroa.18.0.add.ptr113.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.3, i64 8
  %kr.sroa.18.0.copyload18822369 = load <4 x half>, ptr addrspace(4) %kr.sroa.18.0.add.ptr113.3.sroa_idx, align 8
  br label %if.end.3

if.end.3:                                         ; preds = %if.end477.1.2, %if.then.3
  %246 = phi <4 x half> [ %kr.sroa.18.0.copyload18822369, %if.then.3 ], [ zeroinitializer, %if.end477.1.2 ]
  %247 = phi <4 x half> [ %kr.sroa.0.0.copyload18732367, %if.then.3 ], [ zeroinitializer, %if.end477.1.2 ]
  %or.cond.1.3 = icmp ugt i32 %mul11.7, 1023
  %cmp101.not.1.3 = icmp sgt i32 %mul11.7, %1
  %or.cond854.1.3 = or i1 %or.cond.1.3, %cmp101.not.1.3
  br i1 %or.cond854.1.3, label %if.end.1.3, label %if.then.1.3

if.then.1.3:                                      ; preds = %if.end.3
  %248 = shl nsw i32 %cond.i.i796.7, 10
  %mul105.1.3 = and i32 %248, 64512
  %add111.1.3 = add nuw nsw i32 %add108, %mul105.1.3
  %idx.ext112.1.3 = zext nneg i32 %add111.1.3 to i64
  %add.ptr113.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.3
  %kr.sroa.30.16.copyload19112368 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.3, align 16
  %kr.sroa.46.16.add.ptr113.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.3, i64 8
  %kr.sroa.46.16.copyload19202370 = load <4 x half>, ptr addrspace(4) %kr.sroa.46.16.add.ptr113.1.3.sroa_idx, align 8
  br label %if.end.1.3

if.end.1.3:                                       ; preds = %if.end.3, %if.then.1.3
  %249 = phi <4 x half> [ %kr.sroa.46.16.copyload19202370, %if.then.1.3 ], [ zeroinitializer, %if.end.3 ]
  %250 = phi <4 x half> [ %kr.sroa.30.16.copyload19112368, %if.then.1.3 ], [ zeroinitializer, %if.end.3 ]
  br i1 %or.cond854.3, label %if.end.1895.3, label %if.then.1888.3

if.then.1888.3:                                   ; preds = %if.end.1.3
  %251 = shl nsw i32 %cond.i.i796.6, 10
  %mul105.1882.3 = and i32 %251, 64512
  %add111.1883.3 = add nuw nsw i32 %add106.1, %mul105.1882.3
  %idx.ext112.1884.3 = zext nneg i32 %add111.1883.3 to i64
  %add.ptr113.1885.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1884.3
  %kr.sroa.58.32.copyload19492371 = load <4 x half>, ptr addrspace(4) %add.ptr113.1885.3, align 16
  %kr.sroa.74.32.add.ptr113.1885.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1885.3, i64 8
  %kr.sroa.74.32.copyload19582373 = load <4 x half>, ptr addrspace(4) %kr.sroa.74.32.add.ptr113.1885.3.sroa_idx, align 8
  br label %if.end.1895.3

if.end.1895.3:                                    ; preds = %if.end.1.3, %if.then.1888.3
  %252 = phi <4 x half> [ %kr.sroa.74.32.copyload19582373, %if.then.1888.3 ], [ zeroinitializer, %if.end.1.3 ]
  %253 = phi <4 x half> [ %kr.sroa.58.32.copyload19492371, %if.then.1888.3 ], [ zeroinitializer, %if.end.1.3 ]
  br i1 %or.cond854.1.3, label %if.end.1.1.3, label %if.then.1.1.3

if.then.1.1.3:                                    ; preds = %if.end.1895.3
  %254 = shl nsw i32 %cond.i.i796.7, 10
  %mul105.1.1.3 = and i32 %254, 64512
  %add111.1.1.3 = add nuw nsw i32 %add106.1, %mul105.1.1.3
  %idx.ext112.1.1.3 = zext nneg i32 %add111.1.1.3 to i64
  %add.ptr113.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1.3
  %kr.sroa.86.48.copyload19872372 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1.3, align 16
  %kr.sroa.102.48.add.ptr113.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1.3, i64 8
  %kr.sroa.102.48.copyload19962374 = load <4 x half>, ptr addrspace(4) %kr.sroa.102.48.add.ptr113.1.1.3.sroa_idx, align 8
  br label %if.end.1.1.3

if.end.1.1.3:                                     ; preds = %if.end.1895.3, %if.then.1.1.3
  %255 = phi <4 x half> [ %kr.sroa.102.48.copyload19962374, %if.then.1.1.3 ], [ zeroinitializer, %if.end.1895.3 ]
  %256 = phi <4 x half> [ %kr.sroa.86.48.copyload19872372, %if.then.1.1.3 ], [ zeroinitializer, %if.end.1895.3 ]
  br i1 %or.cond854.3, label %if.end218.3, label %if.then164.3

if.then164.3:                                     ; preds = %if.end.1.1.3
  %cmp167.3 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp167.3, label %for.cond169.preheader.3, label %if.end218.3

for.cond169.preheader.3:                          ; preds = %if.then164.3
  %add176.3 = add nuw nsw i32 %mul11.6, %mul175
  %cmp179.not.31079 = icmp sgt i32 %add176.3, %1
  %spec.select.31080 = select i1 %cmp179.not.31079, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1463 = insertelement <4 x float> poison, float %spec.select.31080, i64 0
  %cmp179.not.1.3.not = icmp slt i32 %add176.3, %1
  %spec.select.1.3 = select i1 %cmp179.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1516 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1463, float %spec.select.1.3, i64 1
  %add177.2.3 = or disjoint i32 %add176.3, 2
  %cmp179.not.2.3 = icmp sgt i32 %add177.2.3, %1
  %spec.select.2.3 = select i1 %cmp179.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1569 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1516, float %spec.select.2.3, i64 2
  %add177.3.3 = or disjoint i32 %add176.3, 3
  %cmp179.not.3.3 = icmp sgt i32 %add177.3.3, %1
  %spec.select.3.3 = select i1 %cmp179.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1622 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1569, float %spec.select.3.3, i64 3
  br label %if.end218.3

if.end218.3:                                      ; preds = %if.end.1.1.3, %if.then164.3, %for.cond169.preheader.3
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1622, %for.cond169.preheader.3 ], [ zeroinitializer, %if.then164.3 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.1.1.3 ]
  br i1 %or.cond854.1.3, label %if.end218.1.3, label %if.then164.1.3

if.then164.1.3:                                   ; preds = %if.end218.3
  %cmp167.1.3 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp167.1.3, label %for.cond169.preheader.1.3, label %if.end218.1.3

for.cond169.preheader.1.3:                        ; preds = %if.then164.1.3
  %add176.1.3 = add nuw nsw i32 %mul11.7, %mul175
  %cmp179.not.1897.3 = icmp sgt i32 %add176.1.3, %1
  %spec.select.1898.3 = select i1 %cmp179.not.1897.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.16.vec.insert1691 = insertelement <4 x float> poison, float %spec.select.1898.3, i64 0
  %cmp179.not.1.1.3.not = icmp slt i32 %add176.1.3, %1
  %spec.select.1.1.3 = select i1 %cmp179.not.1.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.146.20.vec.insert1744 = insertelement <4 x float> %scores.sroa.146.16.vec.insert1691, float %spec.select.1.1.3, i64 1
  %add177.2.1.3 = or disjoint i32 %add176.1.3, 2
  %cmp179.not.2.1.3 = icmp sgt i32 %add177.2.1.3, %1
  %spec.select.2.1.3 = select i1 %cmp179.not.2.1.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.24.vec.insert1797 = insertelement <4 x float> %scores.sroa.146.20.vec.insert1744, float %spec.select.2.1.3, i64 2
  %add177.3.1.3 = or disjoint i32 %add176.1.3, 3
  %cmp179.not.3.1.3 = icmp sgt i32 %add177.3.1.3, %1
  %spec.select.3.1.3 = select i1 %cmp179.not.3.1.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.146.28.vec.insert1850 = insertelement <4 x float> %scores.sroa.146.24.vec.insert1797, float %spec.select.3.1.3, i64 3
  br label %if.end218.1.3

if.end218.1.3:                                    ; preds = %if.end218.3, %if.then164.1.3, %for.cond169.preheader.1.3
  %scores.sroa.146.6 = phi <4 x float> [ %scores.sroa.146.28.vec.insert1850, %for.cond169.preheader.1.3 ], [ zeroinitializer, %if.then164.1.3 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.3 ]
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %247, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.6), !call_argsrelate !74
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %250, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.6), !call_argsrelate !74
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %246, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %257), !call_argsrelate !74
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %249, <4 x half> %qr.sroa.7.0.copyload, <4 x float> %258), !call_argsrelate !74
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %253, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %259), !call_argsrelate !74
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %256, <4 x half> %qr.sroa.11.16.copyload, <4 x float> %260), !call_argsrelate !74
  %263 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %252, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %261), !call_argsrelate !74
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %255, <4 x half> %qr.sroa.16.16.copyload, <4 x float> %262), !call_argsrelate !74
  br i1 %or.cond854.3, label %if.end335.3, label %for.cond274.preheader.3

for.cond274.preheader.3:                          ; preds = %if.end218.1.3
  %265 = shl nsw i32 %cond.i.i796.6, 10
  %mul281.3 = and i32 %265, 64512
  %add284.3 = add nuw nsw i32 %add108, %mul281.3
  %266 = zext nneg i32 %add284.3 to i64
  %add.ptr289.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %266
  %vr.sroa.0.0.copyload12372383 = load <4 x half>, ptr addrspace(4) %add.ptr289.3, align 16
  %vr.sroa.22.0.add.ptr289.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.3, i64 8
  %vr.sroa.22.0.copyload12462384 = load <4 x half>, ptr addrspace(4) %vr.sroa.22.0.add.ptr289.3.sroa_idx, align 8
  %267 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %266
  %add.ptr289.1.3 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1024
  %vr.sroa.38.16.copyload12832385 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.3, align 16
  %vr.sroa.58.16.add.ptr289.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1032
  %vr.sroa.58.16.copyload12922386 = load <4 x half>, ptr addrspace(4) %vr.sroa.58.16.add.ptr289.1.3.sroa_idx, align 8
  br label %if.end335.3

if.end335.3:                                      ; preds = %if.end218.1.3, %for.cond274.preheader.3
  %268 = phi <4 x half> [ %vr.sroa.58.16.copyload12922386, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ]
  %269 = phi <4 x half> [ %vr.sroa.38.16.copyload12832385, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ]
  %270 = phi <4 x half> [ %vr.sroa.22.0.copyload12462384, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ]
  %271 = phi <4 x half> [ %vr.sroa.0.0.copyload12372383, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end218.1.3 ]
  br i1 %or.cond854.1.3, label %if.end335.1.3, label %for.cond274.preheader.1.3

for.cond274.preheader.1.3:                        ; preds = %if.end335.3
  %272 = shl nsw i32 %cond.i.i796.7, 10
  %mul281.1.3 = and i32 %272, 64512
  %add284.1.3 = add nuw nsw i32 %add108, %mul281.1.3
  %273 = zext nneg i32 %add284.1.3 to i64
  %add.ptr289.1913.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %vr.sroa.74.32.copyload13292387 = load <4 x half>, ptr addrspace(4) %add.ptr289.1913.3, align 16
  %vr.sroa.94.32.add.ptr289.1913.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1913.3, i64 8
  %vr.sroa.94.32.copyload13382388 = load <4 x half>, ptr addrspace(4) %vr.sroa.94.32.add.ptr289.1913.3.sroa_idx, align 8
  %274 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %add.ptr289.1.1.3 = getelementptr inbounds i8, ptr addrspace(4) %274, i64 1024
  %vr.sroa.110.48.copyload13752389 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1.3, align 16
  %vr.sroa.130.48.add.ptr289.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %274, i64 1032
  %vr.sroa.130.48.copyload13842390 = load <4 x half>, ptr addrspace(4) %vr.sroa.130.48.add.ptr289.1.1.3.sroa_idx, align 8
  br label %if.end335.1.3

if.end335.1.3:                                    ; preds = %if.end335.3, %for.cond274.preheader.1.3
  %275 = phi <4 x half> [ %vr.sroa.130.48.copyload13842390, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ]
  %276 = phi <4 x half> [ %vr.sroa.110.48.copyload13752389, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ]
  %277 = phi <4 x half> [ %vr.sroa.94.32.copyload13382388, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ]
  %278 = phi <4 x half> [ %vr.sroa.74.32.copyload13292387, %for.cond274.preheader.1.3 ], [ zeroinitializer, %if.end335.3 ]
  br i1 %or.cond854.3, label %if.end415.3, label %for.cond352.preheader.3

for.cond352.preheader.3:                          ; preds = %if.end335.1.3
  %scores.sroa.0.0.vec.extract1467 = extractelement <4 x float> %263, i64 0
  %mul360.31081 = fmul contract float %scores.sroa.0.0.vec.extract1467, 0x3FB99999A0000000
  %279 = tail call contract noundef float @llvm.minnum.f32(float %mul360.31081, float 0x4024CB5EC0000000)
  %280 = tail call contract noundef float @llvm.exp.f32(float %279)
  %scores.sroa.0.4.vec.extract1520 = extractelement <4 x float> %263, i64 1
  %mul360.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1520, 0x3FB99999A0000000
  %281 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.3, float 0x4024CB5EC0000000)
  %282 = tail call contract noundef float @llvm.exp.f32(float %281)
  %scores.sroa.0.8.vec.extract1573 = extractelement <4 x float> %263, i64 2
  %mul360.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1573, 0x3FB99999A0000000
  %283 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.3, float 0x4024CB5EC0000000)
  %284 = tail call contract noundef float @llvm.exp.f32(float %283)
  %scores.sroa.0.12.vec.extract1626 = extractelement <4 x float> %263, i64 3
  %mul360.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1626, 0x3FB99999A0000000
  %285 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.3, float 0x4024CB5EC0000000)
  %286 = tail call contract noundef float @llvm.exp.f32(float %285)
  %add380.31082 = fadd contract float %sums.sroa.0.5, %280
  %add380.1.3 = fadd contract float %sums.sroa.20.5, %282
  %add380.2.3 = fadd contract float %sums.sroa.38.5, %284
  %add380.3.3 = fadd contract float %sums.sroa.56.5, %286
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %280)
  %288 = insertelement <4 x i16> poison, i16 %287, i64 0
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %282)
  %290 = insertelement <4 x i16> %288, i16 %289, i64 1
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %284)
  %292 = insertelement <4 x i16> %290, i16 %291, i64 2
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %286)
  %294 = insertelement <4 x i16> %292, i16 %293, i64 3
  %probs.sroa.0.6.vec.insert1158 = bitcast <4 x i16> %294 to <4 x half>
  br label %if.end415.3

if.end415.3:                                      ; preds = %if.end335.1.3, %for.cond352.preheader.3
  %sums.sroa.56.6 = phi float [ %add380.3.3, %for.cond352.preheader.3 ], [ %sums.sroa.56.5, %if.end335.1.3 ]
  %sums.sroa.38.6 = phi float [ %add380.2.3, %for.cond352.preheader.3 ], [ %sums.sroa.38.5, %if.end335.1.3 ]
  %sums.sroa.20.6 = phi float [ %add380.1.3, %for.cond352.preheader.3 ], [ %sums.sroa.20.5, %if.end335.1.3 ]
  %sums.sroa.0.6 = phi float [ %add380.31082, %for.cond352.preheader.3 ], [ %sums.sroa.0.5, %if.end335.1.3 ]
  %probs.sroa.0.3 = phi <4 x half> [ %probs.sroa.0.6.vec.insert1158, %for.cond352.preheader.3 ], [ zeroinitializer, %if.end335.1.3 ]
  br i1 %or.cond854.1.3, label %if.end415.1.3, label %for.cond352.preheader.1.3

for.cond352.preheader.1.3:                        ; preds = %if.end415.3
  %scores.sroa.146.16.vec.extract1695 = extractelement <4 x float> %264, i64 0
  %mul360.1922.3 = fmul contract float %scores.sroa.146.16.vec.extract1695, 0x3FB99999A0000000
  %295 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1922.3, float 0x4024CB5EC0000000)
  %296 = tail call contract noundef float @llvm.exp.f32(float %295)
  %scores.sroa.146.20.vec.extract1748 = extractelement <4 x float> %264, i64 1
  %mul360.1.1.3 = fmul contract float %scores.sroa.146.20.vec.extract1748, 0x3FB99999A0000000
  %297 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1.3, float 0x4024CB5EC0000000)
  %298 = tail call contract noundef float @llvm.exp.f32(float %297)
  %scores.sroa.146.24.vec.extract1801 = extractelement <4 x float> %264, i64 2
  %mul360.2.1.3 = fmul contract float %scores.sroa.146.24.vec.extract1801, 0x3FB99999A0000000
  %299 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1.3, float 0x4024CB5EC0000000)
  %300 = tail call contract noundef float @llvm.exp.f32(float %299)
  %scores.sroa.146.28.vec.extract1854 = extractelement <4 x float> %264, i64 3
  %mul360.3.1.3 = fmul contract float %scores.sroa.146.28.vec.extract1854, 0x3FB99999A0000000
  %301 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1.3, float 0x4024CB5EC0000000)
  %302 = tail call contract noundef float @llvm.exp.f32(float %301)
  %add380.1924.3 = fadd contract float %sums.sroa.0.6, %296
  %add380.1.1.3 = fadd contract float %sums.sroa.20.6, %298
  %add380.2.1.3 = fadd contract float %sums.sroa.38.6, %300
  %add380.3.1.3 = fadd contract float %sums.sroa.56.6, %302
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %296)
  %304 = insertelement <4 x i16> poison, i16 %303, i64 0
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %298)
  %306 = insertelement <4 x i16> %304, i16 %305, i64 1
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %300)
  %308 = insertelement <4 x i16> %306, i16 %307, i64 2
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %302)
  %310 = insertelement <4 x i16> %308, i16 %309, i64 3
  %probs.sroa.46.14.vec.insert1218 = bitcast <4 x i16> %310 to <4 x half>
  br label %if.end415.1.3

if.end415.1.3:                                    ; preds = %if.end415.3, %for.cond352.preheader.1.3
  %sums.sroa.56.7 = phi float [ %add380.3.1.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.56.6, %if.end415.3 ]
  %sums.sroa.38.7 = phi float [ %add380.2.1.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.38.6, %if.end415.3 ]
  %sums.sroa.20.7 = phi float [ %add380.1.1.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.20.6, %if.end415.3 ]
  %sums.sroa.0.7 = phi float [ %add380.1924.3, %for.cond352.preheader.1.3 ], [ %sums.sroa.0.6, %if.end415.3 ]
  %probs.sroa.46.3 = phi <4 x half> [ %probs.sroa.46.14.vec.insert1218, %for.cond352.preheader.1.3 ], [ zeroinitializer, %if.end415.3 ]
  br i1 %or.cond854.3, label %if.end477.3, label %for.cond434.preheader.3

for.cond434.preheader.3:                          ; preds = %if.end415.1.3
  %311 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %271, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.0.4)
  %312 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %270, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.42.4)
  %313 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %269, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.82.4)
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %268, <4 x half> %probs.sroa.0.3, <4 x float> %out.sroa.122.4)
  br label %if.end477.3

if.end477.3:                                      ; preds = %for.cond434.preheader.3, %if.end415.1.3
  %out.sroa.122.6 = phi <4 x float> [ %out.sroa.122.4, %if.end415.1.3 ], [ %314, %for.cond434.preheader.3 ]
  %out.sroa.82.6 = phi <4 x float> [ %out.sroa.82.4, %if.end415.1.3 ], [ %313, %for.cond434.preheader.3 ]
  %out.sroa.42.6 = phi <4 x float> [ %out.sroa.42.4, %if.end415.1.3 ], [ %312, %for.cond434.preheader.3 ]
  %out.sroa.0.6 = phi <4 x float> [ %out.sroa.0.4, %if.end415.1.3 ], [ %311, %for.cond434.preheader.3 ]
  br i1 %or.cond854.1.3, label %if.end477.1.3, label %for.cond455.preheader.1.3

for.cond455.preheader.1.3:                        ; preds = %if.end477.3
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %278, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.0.5)
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %277, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.26.5)
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %276, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.50.5)
  %318 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %275, <4 x half> %probs.sroa.46.3, <4 x float> %out_1.sroa.74.5)
  br label %if.end477.1.3

if.end477.1.3:                                    ; preds = %for.cond455.preheader.1.3, %if.end477.3
  %out_1.sroa.74.7 = phi <4 x float> [ %out_1.sroa.74.5, %if.end477.3 ], [ %318, %for.cond455.preheader.1.3 ]
  %out_1.sroa.50.7 = phi <4 x float> [ %out_1.sroa.50.5, %if.end477.3 ], [ %317, %for.cond455.preheader.1.3 ]
  %out_1.sroa.26.7 = phi <4 x float> [ %out_1.sroa.26.5, %if.end477.3 ], [ %316, %for.cond455.preheader.1.3 ]
  %out_1.sroa.0.7 = phi <4 x float> [ %out_1.sroa.0.5, %if.end477.3 ], [ %315, %for.cond455.preheader.1.3 ]
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 0
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 0
  %add492 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 1
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 1
  %add492.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 2
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 2
  %add492.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 3
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 3
  %add492.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract
  %out.sroa.42.16.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 0
  %out_1.sroa.26.16.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 0
  %add492.4 = fadd contract float %out.sroa.42.16.vec.extract, %out_1.sroa.26.16.vec.extract
  %out.sroa.42.20.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 1
  %out_1.sroa.26.20.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 1
  %add492.5 = fadd contract float %out.sroa.42.20.vec.extract, %out_1.sroa.26.20.vec.extract
  %out.sroa.42.24.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 2
  %out_1.sroa.26.24.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 2
  %add492.6 = fadd contract float %out.sroa.42.24.vec.extract, %out_1.sroa.26.24.vec.extract
  %out.sroa.42.28.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 3
  %out_1.sroa.26.28.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 3
  %add492.7 = fadd contract float %out.sroa.42.28.vec.extract, %out_1.sroa.26.28.vec.extract
  %out.sroa.82.32.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 0
  %out_1.sroa.50.32.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 0
  %add492.8 = fadd contract float %out.sroa.82.32.vec.extract, %out_1.sroa.50.32.vec.extract
  %out.sroa.82.36.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 1
  %out_1.sroa.50.36.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 1
  %add492.9 = fadd contract float %out.sroa.82.36.vec.extract, %out_1.sroa.50.36.vec.extract
  %out.sroa.82.40.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 2
  %out_1.sroa.50.40.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 2
  %add492.10 = fadd contract float %out.sroa.82.40.vec.extract, %out_1.sroa.50.40.vec.extract
  %out.sroa.82.44.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 3
  %out_1.sroa.50.44.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 3
  %add492.11 = fadd contract float %out.sroa.82.44.vec.extract, %out_1.sroa.50.44.vec.extract
  %out.sroa.122.48.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 0
  %out_1.sroa.74.48.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 0
  %add492.12 = fadd contract float %out.sroa.122.48.vec.extract, %out_1.sroa.74.48.vec.extract
  %out.sroa.122.52.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 1
  %out_1.sroa.74.52.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 1
  %add492.13 = fadd contract float %out.sroa.122.52.vec.extract, %out_1.sroa.74.52.vec.extract
  %out.sroa.122.56.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 2
  %out_1.sroa.74.56.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 2
  %add492.14 = fadd contract float %out.sroa.122.56.vec.extract, %out_1.sroa.74.56.vec.extract
  %out.sroa.122.60.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 3
  %out_1.sroa.74.60.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 3
  %add492.15 = fadd contract float %out.sroa.122.60.vec.extract, %out_1.sroa.74.60.vec.extract
  %add506 = fadd contract float %sums.sroa.0.7, 0.000000e+00
  %add506.1 = fadd contract float %add506, %sums.sroa.20.7
  %add506.2 = fadd contract float %add506.1, %sums.sroa.38.7
  %add506.3 = fadd contract float %add506.2, %sums.sroa.56.7
  %319 = bitcast float %add506.3 to i32
  %320 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %321 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %320) #11
  %xor.i.i = xor i32 %321, 32
  %322 = and i32 %321, -64
  %and.i.i = add nsw i32 %322, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i801 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %321
  %shl.i.i = shl i32 %cond.i.i801, 2
  %323 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %319)
  %324 = bitcast i32 %323 to float
  %add.i = fadd contract float %add506.3, %324
  %325 = bitcast float %add.i to i32
  %326 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %327 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %326) #11
  %xor.i.i802 = xor i32 %327, 16
  %328 = and i32 %327, -64
  %and.i.i803 = add nsw i32 %328, 64
  %cmp.not.i.i804 = icmp slt i32 %xor.i.i802, %and.i.i803
  %cond.i.i805 = select i1 %cmp.not.i.i804, i32 %xor.i.i802, i32 %327
  %shl.i.i806 = shl i32 %cond.i.i805, 2
  %329 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i806, i32 %325)
  %330 = bitcast i32 %329 to float
  %add.i.i = fadd contract float %add.i, %330
  %cmp515 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_1.0 = select i1 %cmp515, float %div, float 0.000000e+00
  %mul528 = fmul contract float %condval_1.0, %add492
  %mul528.1 = fmul contract float %condval_1.0, %add492.1
  %mul528.2 = fmul contract float %condval_1.0, %add492.2
  %mul528.3 = fmul contract float %condval_1.0, %add492.3
  %mul528.4 = fmul contract float %condval_1.0, %add492.4
  %mul528.5 = fmul contract float %condval_1.0, %add492.5
  %mul528.6 = fmul contract float %condval_1.0, %add492.6
  %mul528.7 = fmul contract float %condval_1.0, %add492.7
  %mul528.8 = fmul contract float %condval_1.0, %add492.8
  %mul528.9 = fmul contract float %condval_1.0, %add492.9
  %mul528.10 = fmul contract float %condval_1.0, %add492.10
  %mul528.11 = fmul contract float %condval_1.0, %add492.11
  %mul528.12 = fmul contract float %condval_1.0, %add492.12
  %mul528.13 = fmul contract float %condval_1.0, %add492.13
  %mul528.14 = fmul contract float %condval_1.0, %add492.14
  %mul528.15 = fmul contract float %condval_1.0, %add492.15
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528)
  %O_reg.sroa.0.0.insert.ext = zext i16 %331 to i64
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %332 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %333 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %333 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %334 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %335 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %335 to i64
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %336 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %337 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %337 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %338 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %339 to i64
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %340 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %341 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %342 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %343 to i64
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %344 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %345 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %345 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %346 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul528.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %346 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr570 = lshr i32 %18, 5
  %and573 = and i32 %18, 7
  %mul579 = and i32 %22, 4
  %xor = xor i32 %shr570, %and573
  %mul574 = shl nuw nsw i32 %xor, 3
  %add575 = add nuw nsw i32 %mul574, %mul25
  %add580 = or disjoint i32 %add575, %mul579
  %add.ptr582 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr582, align 8
  %add571.1 = add nuw nsw i32 %shr570, 2
  %xor.1 = xor i32 %add571.1, %and573
  %mul574.1 = shl nuw nsw i32 %xor.1, 3
  %add575.1 = add nuw nsw i32 %mul574.1, %mul25
  %add580.1 = or disjoint i32 %add575.1, %mul579
  %add.ptr582.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr582.1, align 8
  %add571.2 = add nuw nsw i32 %shr570, 4
  %xor.2 = xor i32 %add571.2, %and573
  %mul574.2 = shl nuw nsw i32 %xor.2, 3
  %add575.2 = add nuw nsw i32 %mul574.2, %mul25
  %add580.2 = or disjoint i32 %add575.2, %mul579
  %add.ptr582.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr582.2, align 8
  %add571.3 = add nuw nsw i32 %shr570, 6
  %xor.3 = xor i32 %add571.3, %and573
  %mul574.3 = shl nuw nsw i32 %xor.3, 3
  %add575.3 = add nuw nsw i32 %mul574.3, %mul25
  %add580.3 = or disjoint i32 %add575.3, %mul579
  %add.ptr582.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add580.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr582.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul593 = and i32 %mul110, 8128
  %xor599758 = and i32 %mul110, 56
  %call597.masked = and i32 %18, 1016
  %mul600 = xor i32 %xor599758, %call597.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul593
  %invariant.gep851 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul600
  %add610 = add nuw nsw i32 %add23, %mul110
  %347 = zext nneg i32 %add610 to i64
  %add.ptr615 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr615, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep851, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  %gep852.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep851, i32 1024
  %348 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347
  %add.ptr615.1 = getelementptr inbounds i8, ptr addrspace(1) %348, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr615.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep852.1, i64 16, i1 false), !tbaa.struct !183, !call_argsrelate !184
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare float @llvm.exp.f32(float) #7

declare void @llvm.mxc.barrier.warp() #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare i32 @llvm.smax.i32(i32, i32) #7

declare i32 @llvm.smin.i32(i32, i32) #7

declare float @llvm.minnum.f32(float, float) #7

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


