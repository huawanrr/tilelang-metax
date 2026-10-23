target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@v_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 5
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %shr = lshr i32 %1, 4
  %add = add nuw nsw i32 %shr, %mul
  %2 = tail call range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul9 = mul nuw nsw i32 %2, 131200
  %mul11 = shl nsw i32 %0, 12
  %add12 = add nuw nsw i32 %mul9, %mul11
  %mul16 = shl nuw nsw i32 %1, 3
  %add14 = add nuw nsw i32 %add12, %mul16
  %3 = zext nneg i32 %add14 to i64
  %cmp7 = icmp ult i32 %add, 1025
  br i1 %cmp7, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %3
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 4
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr.sroa_idx, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr.sroa_idx, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 12
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr.sroa_idx, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then ], [ 0, %entry ]
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then ], [ 0, %entry ]
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then ], [ 0, %entry ]
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then ], [ 0, %entry ]
  %cmp7.1 = icmp ult i32 %add, 1009
  br i1 %cmp7.1, label %if.then.1, label %if.end.1

if.then.1:                                        ; preds = %if.end
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 4096
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr.1, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 4100
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr.sroa_idx.1, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 4104
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr.sroa_idx.1, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 4108
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr.sroa_idx.1, align 4, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.then.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then.1 ], [ 0, %if.end ]
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then.1 ], [ 0, %if.end ]
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then.1 ], [ 0, %if.end ]
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then.1 ], [ 0, %if.end ]
  %mul50 = mul nuw nsw i32 %2, 270336
  %mul52 = shl nsw i32 %0, 13
  %5 = shl nuw nsw i32 %1, 8
  %mul56 = and i32 %5, 3072
  %and61 = shl nuw nsw i32 %1, 7
  %mul62 = and i32 %and61, 384
  %6 = lshr i32 %1, 1
  %mul66 = and i32 %6, 504
  %add63 = add nuw nsw i32 %mul50, %mul52
  %7 = or disjoint i32 %mul56, %mul62
  %add57 = or disjoint i32 %7, %add63
  %add59 = add nuw nsw i32 %add57, %mul66
  %8 = zext nneg i32 %add59 to i64
  %add.ptr69 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedKV.coerce, i64 %8
  store i32 %condval.sroa.0.0, ptr addrspace(1) %add.ptr69, align 16, !tbaa !30
  %ktile.sroa.4.0.add.ptr69.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr69, i64 4
  store i32 %condval.sroa.5.0, ptr addrspace(1) %ktile.sroa.4.0.add.ptr69.sroa_idx, align 4, !tbaa !30
  %ktile.sroa.5.0.add.ptr69.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr69, i64 8
  store i32 %condval.sroa.6.0, ptr addrspace(1) %ktile.sroa.5.0.add.ptr69.sroa_idx, align 8, !tbaa !30
  %ktile.sroa.6.0.add.ptr69.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr69, i64 12
  store i32 %condval.sroa.7.0, ptr addrspace(1) %ktile.sroa.6.0.add.ptr69.sroa_idx, align 4, !tbaa !30
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedKV.coerce, i64 %8
  %add.ptr69.1 = getelementptr inbounds i8, ptr addrspace(1) %9, i64 1024
  store i32 %condval.sroa.0.0.1, ptr addrspace(1) %add.ptr69.1, align 16, !tbaa !30
  %ktile.sroa.9.16.add.ptr69.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %9, i64 1028
  store i32 %condval.sroa.5.0.1, ptr addrspace(1) %ktile.sroa.9.16.add.ptr69.1.sroa_idx, align 4, !tbaa !30
  %ktile.sroa.10.16.add.ptr69.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %9, i64 1032
  store i32 %condval.sroa.6.0.1, ptr addrspace(1) %ktile.sroa.10.16.add.ptr69.1.sroa_idx, align 8, !tbaa !30
  %ktile.sroa.11.16.add.ptr69.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %9, i64 1036
  store i32 %condval.sroa.7.0.1, ptr addrspace(1) %ktile.sroa.11.16.add.ptr69.1.sroa_idx, align 4, !tbaa !30
  br i1 %cmp7, label %if.then86, label %if.end122

if.then86:                                        ; preds = %if.end.1
  %add.ptr98 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %3
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr98, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr98.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 8
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr98.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 12
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr98.sroa_idx, align 4, !tbaa !30
  %10 = zext i32 %condval_1.sroa.0.0.copyload to i64
  %11 = zext i32 %condval_1.sroa.5.0.copyload to i64
  %12 = shl nuw i64 %11, 32
  %13 = zext i32 %condval_1.sroa.6.0.copyload to i64
  %14 = zext i32 %condval_1.sroa.7.0.copyload to i64
  %15 = shl nuw i64 %14, 32
  br label %if.end122

if.end122:                                        ; preds = %if.end.1, %if.then86
  %condval_1.sroa.0.0 = phi i64 [ %10, %if.then86 ], [ 0, %if.end.1 ]
  %condval_1.sroa.5.0 = phi i64 [ %12, %if.then86 ], [ 0, %if.end.1 ]
  %condval_1.sroa.6.0 = phi i64 [ %13, %if.then86 ], [ 0, %if.end.1 ]
  %condval_1.sroa.7.0 = phi i64 [ %15, %if.then86 ], [ 0, %if.end.1 ]
  br i1 %cmp7.1, label %if.then86.1, label %if.end122.1

if.then86.1:                                      ; preds = %if.end122
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %3
  %add.ptr98.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 4096
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr98.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 4100
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr98.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 4104
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr98.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 4108
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr98.sroa_idx.1, align 4, !tbaa !30
  %17 = zext i32 %condval_1.sroa.0.0.copyload.1 to i64
  %18 = zext i32 %condval_1.sroa.5.0.copyload.1 to i64
  %19 = shl nuw i64 %18, 32
  %20 = or disjoint i64 %19, %17
  %21 = zext i32 %condval_1.sroa.6.0.copyload.1 to i64
  %22 = zext i32 %condval_1.sroa.7.0.copyload.1 to i64
  %23 = shl nuw i64 %22, 32
  %24 = or disjoint i64 %23, %21
  br label %if.end122.1

if.end122.1:                                      ; preds = %if.then86.1, %if.end122
  %tile.sroa.8.20.insert.insert = phi i64 [ %20, %if.then86.1 ], [ 0, %if.end122 ]
  %tile.sroa.11.28.insert.insert = phi i64 [ %24, %if.then86.1 ], [ 0, %if.end122 ]
  %tile.sroa.5.12.insert.insert = or disjoint i64 %condval_1.sroa.6.0, %condval_1.sroa.7.0
  %tile.sroa.0.4.insert.insert = or disjoint i64 %condval_1.sroa.0.0, %condval_1.sroa.5.0
  %mul143 = and i32 %mul16, 8064
  %and146 = shl nuw nsw i32 %1, 1
  %mul147 = and i32 %and146, 30
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @v_shared, i32 %mul143
  %xor = xor i32 %mul147, %shr
  %add.ptr155.idx = shl nuw nsw i32 %xor, 3
  %add.ptr155 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr155.idx
  store i64 %tile.sroa.0.4.insert.insert, ptr addrspace(3) %add.ptr155, align 8
  %add149.1 = or disjoint i32 %mul147, 1
  %xor.1 = xor i32 %add149.1, %shr
  %add.ptr155.idx.1 = shl nuw nsw i32 %xor.1, 3
  %add.ptr155.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr155.idx.1
  store i64 %tile.sroa.5.12.insert.insert, ptr addrspace(3) %add.ptr155.1, align 8
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 4096
  %add.ptr155.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr155.idx
  store i64 %tile.sroa.8.20.insert.insert, ptr addrspace(3) %add.ptr155.2, align 8
  %add.ptr155.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr155.idx.1
  store i64 %tile.sroa.11.28.insert.insert, ptr addrspace(3) %add.ptr155.3, align 8
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %25 = shl nuw nsw i32 %1, 5
  %mul169 = and i32 %25, 1536
  %26 = lshr i32 %1, 3
  %mul176 = and i32 %26, 120
  %and182 = lshr i32 %1, 2
  %shr183 = and i32 %and182, 3
  %add180 = or disjoint i32 %shr183, %mul176
  %mul188 = and i32 %and182, 12
  %and195 = and i32 %1, 3
  %xor191 = xor i32 %add180, %mul188
  %mul192 = shl nuw nsw i32 %xor191, 2
  %add193 = or disjoint i32 %and195, %mul169
  %add196 = or disjoint i32 %add193, %mul192
  %arrayidx = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196
  %27 = load i16, ptr addrspace(3) %arrayidx, align 2, !tbaa !77
  %add190.1 = or disjoint i32 %mul188, 1
  %xor191.1 = xor i32 %add180, %add190.1
  %mul192.1 = shl nuw nsw i32 %xor191.1, 2
  %add173.1 = or disjoint i32 %and195, 128
  %add193.1 = or disjoint i32 %add173.1, %mul169
  %add196.1 = add nuw nsw i32 %add193.1, %mul192.1
  %arrayidx.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.1
  %28 = load i16, ptr addrspace(3) %arrayidx.1, align 2, !tbaa !77
  %add190.2 = or disjoint i32 %mul188, 2
  %xor191.2 = xor i32 %add180, %add190.2
  %mul192.2 = shl nuw nsw i32 %xor191.2, 2
  %add173.2 = or disjoint i32 %and195, 256
  %add193.2 = or disjoint i32 %add173.2, %mul169
  %add196.2 = add nuw nsw i32 %add193.2, %mul192.2
  %arrayidx.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.2
  %29 = load i16, ptr addrspace(3) %arrayidx.2, align 2, !tbaa !77
  %add190.3 = or disjoint i32 %mul188, 3
  %xor191.3 = xor i32 %add180, %add190.3
  %mul192.3 = shl nuw nsw i32 %xor191.3, 2
  %add173.3 = or disjoint i32 %and195, 384
  %add193.3 = or disjoint i32 %add173.3, %mul169
  %add196.3 = add nuw nsw i32 %add193.3, %mul192.3
  %arrayidx.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.3
  %30 = load i16, ptr addrspace(3) %arrayidx.3, align 2, !tbaa !77
  %add184.4 = or disjoint i32 %add180, 4
  %xor191.4 = xor i32 %add184.4, %mul188
  %mul192.4 = shl nuw nsw i32 %xor191.4, 2
  %add196.4 = or disjoint i32 %add193, %mul192.4
  %arrayidx.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.4
  %31 = load i16, ptr addrspace(3) %arrayidx.4, align 2, !tbaa !77
  %xor191.5 = xor i32 %add184.4, %add190.1
  %mul192.5 = shl nuw nsw i32 %xor191.5, 2
  %add196.5 = add nuw nsw i32 %add193.1, %mul192.5
  %arrayidx.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.5
  %32 = load i16, ptr addrspace(3) %arrayidx.5, align 2, !tbaa !77
  %xor191.6 = xor i32 %add184.4, %add190.2
  %mul192.6 = shl nuw nsw i32 %xor191.6, 2
  %add196.6 = add nuw nsw i32 %add193.2, %mul192.6
  %arrayidx.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.6
  %33 = load i16, ptr addrspace(3) %arrayidx.6, align 2, !tbaa !77
  %xor191.7 = xor i32 %add184.4, %add190.3
  %mul192.7 = shl nuw nsw i32 %xor191.7, 2
  %add196.7 = add nuw nsw i32 %add193.3, %mul192.7
  %arrayidx.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.7
  %34 = load i16, ptr addrspace(3) %arrayidx.7, align 2, !tbaa !77
  %add170.8 = or disjoint i32 %mul169, 2048
  %add193.8 = or disjoint i32 %and195, %add170.8
  %add196.8 = or disjoint i32 %add193.8, %mul192
  %arrayidx.8 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.8
  %35 = load i16, ptr addrspace(3) %arrayidx.8, align 2, !tbaa !77
  %add193.9 = or disjoint i32 %add173.1, %add170.8
  %add196.9 = add nuw nsw i32 %add193.9, %mul192.1
  %arrayidx.9 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.9
  %36 = load i16, ptr addrspace(3) %arrayidx.9, align 2, !tbaa !77
  %add193.10 = or disjoint i32 %add173.2, %add170.8
  %add196.10 = add nuw nsw i32 %add193.10, %mul192.2
  %arrayidx.10 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.10
  %37 = load i16, ptr addrspace(3) %arrayidx.10, align 2, !tbaa !77
  %add193.11 = or disjoint i32 %add173.3, %add170.8
  %add196.11 = add nuw nsw i32 %add193.11, %mul192.3
  %arrayidx.11 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.11
  %38 = load i16, ptr addrspace(3) %arrayidx.11, align 2, !tbaa !77
  %add196.12 = or disjoint i32 %add193.8, %mul192.4
  %arrayidx.12 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.12
  %39 = load i16, ptr addrspace(3) %arrayidx.12, align 2, !tbaa !77
  %add196.13 = add nuw nsw i32 %add193.9, %mul192.5
  %arrayidx.13 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.13
  %40 = load i16, ptr addrspace(3) %arrayidx.13, align 2, !tbaa !77
  %add196.14 = add nuw nsw i32 %add193.10, %mul192.6
  %arrayidx.14 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.14
  %41 = load i16, ptr addrspace(3) %arrayidx.14, align 2, !tbaa !77
  %add196.15 = add nuw nsw i32 %add193.11, %mul192.7
  %arrayidx.15 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add196.15
  %42 = load i16, ptr addrspace(3) %arrayidx.15, align 2, !tbaa !77
  %add217 = or disjoint i32 %add63, %mul16
  %invariant.gep303 = getelementptr inbounds i8, ptr addrspace(1) %PackedKV.coerce, i64 8192
  %43 = zext nneg i32 %add217 to i64
  %gep304 = getelementptr inbounds %struct.__half, ptr addrspace(1) %invariant.gep303, i64 %43
  store i16 %27, ptr addrspace(1) %gep304, align 16
  %packed_v.sroa.4.0.gep304.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep304, i64 2
  store i16 %28, ptr addrspace(1) %packed_v.sroa.4.0.gep304.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.5.0.gep304.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep304, i64 4
  store i16 %29, ptr addrspace(1) %packed_v.sroa.5.0.gep304.sroa_idx, align 4
  %packed_v.sroa.6.0.gep304.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep304, i64 6
  store i16 %30, ptr addrspace(1) %packed_v.sroa.6.0.gep304.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.7.0.gep304.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep304, i64 8
  store i16 %31, ptr addrspace(1) %packed_v.sroa.7.0.gep304.sroa_idx, align 8
  %packed_v.sroa.8.0.gep304.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep304, i64 10
  store i16 %32, ptr addrspace(1) %packed_v.sroa.8.0.gep304.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.9.0.gep304.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep304, i64 12
  store i16 %33, ptr addrspace(1) %packed_v.sroa.9.0.gep304.sroa_idx, align 4
  %packed_v.sroa.10.0.gep304.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep304, i64 14
  store i16 %34, ptr addrspace(1) %packed_v.sroa.10.0.gep304.sroa_idx, align 2, !tbaa !30
  %44 = getelementptr inbounds %struct.__half, ptr addrspace(1) %invariant.gep303, i64 %43
  %gep304.1 = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4096
  store i16 %35, ptr addrspace(1) %gep304.1, align 16
  %packed_v.sroa.13.16.gep304.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4098
  store i16 %36, ptr addrspace(1) %packed_v.sroa.13.16.gep304.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.14.16.gep304.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4100
  store i16 %37, ptr addrspace(1) %packed_v.sroa.14.16.gep304.1.sroa_idx, align 4
  %packed_v.sroa.15.16.gep304.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4102
  store i16 %38, ptr addrspace(1) %packed_v.sroa.15.16.gep304.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.16.16.gep304.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4104
  store i16 %39, ptr addrspace(1) %packed_v.sroa.16.16.gep304.1.sroa_idx, align 8
  %packed_v.sroa.17.16.gep304.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4106
  store i16 %40, ptr addrspace(1) %packed_v.sroa.17.16.gep304.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.18.16.gep304.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4108
  store i16 %41, ptr addrspace(1) %packed_v.sroa.18.16.gep304.1.sroa_idx, align 4
  %packed_v.sroa.19.16.gep304.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %44, i64 4110
  store i16 %42, ptr addrspace(1) %packed_v.sroa.19.16.gep304.1.sroa_idx, align 2, !tbaa !30
  ret void
}

declare i32 @llvm.mxc.block.id.x() #4

declare i32 @llvm.mxc.block.id.y() #4

declare i32 @llvm.mxc.block.id.z() #4

declare i32 @llvm.mxc.thread.id.x() #4

declare void @llvm.mxc.barrier() #5

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

declare i1 @llvm.mxc.is.private(ptr nocapture) #4

declare void @llvm.mxc.sleep(i32 immarg) #6

attributes #0 = { mustprogress noreturn nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="256" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nounwind speculatable willreturn memory(none) }
attributes #5 = { convergent nounwind willreturn }
attributes #6 = { nounwind willreturn }


