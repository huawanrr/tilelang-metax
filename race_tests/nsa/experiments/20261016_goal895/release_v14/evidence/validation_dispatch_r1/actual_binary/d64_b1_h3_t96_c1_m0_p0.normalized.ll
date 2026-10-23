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
  %mul = mul nuw nsw i32 %0, 3072
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 1024
  %mul17 = mul nuw nsw i32 %0, 3
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %mul20 = shl nsw i32 %5, 4
  %cmp34 = icmp sgt i32 %5, -1
  br i1 %cmp34, label %land.lhs.true, label %if.end438

land.lhs.true:                                    ; preds = %entry
  %cmp35 = icmp ugt i32 %5, 5
  %cmp38.not = icmp sgt i32 %mul20, %0
  %or.cond = select i1 %cmp35, i1 true, i1 %cmp38.not
  br i1 %or.cond, label %if.end438, label %for.cond39.preheader

for.cond39.preheader:                             ; preds = %land.lhs.true
  %shr = lshr i32 %2, 3
  %add45 = add nuw nsw i32 %mul20, %shr
  %mul53 = mul nuw nsw i32 %shr, 192
  %mul55 = mul nuw nsw i32 %5, 3072
  %mul58 = shl nsw i32 %1, 6
  %add54 = add nuw nsw i32 %mul53, %mul58
  %mul61 = and i32 %mul11, 56
  %add56 = or disjoint i32 %add54, %mul61
  %add59 = add nuw nsw i32 %add56, %mul55
  %6 = zext nneg i32 %add59 to i64
  %cmp48 = icmp ult i32 %add45, 96
  br i1 %cmp48, label %if.then49, label %if.end

if.then49:                                        ; preds = %for.cond39.preheader
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %6
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr64, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 4
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr64.sroa_idx, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 8
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr64.sroa_idx, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 12
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr64.sroa_idx, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %for.cond39.preheader, %if.then49
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ]
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ]
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ]
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ]
  %cmp48.1 = icmp ult i32 %add45, 88
  br i1 %cmp48.1, label %if.then49.1, label %if.end.1

if.then49.1:                                      ; preds = %if.end
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %6
  %add.ptr64.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3072
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr64.1, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr64.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3076
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr64.sroa_idx.1, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr64.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3080
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr64.sroa_idx.1, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr64.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3084
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr64.sroa_idx.1, align 4, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.then49.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then49.1 ], [ 0, %if.end ]
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then49.1 ], [ 0, %if.end ]
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then49.1 ], [ 0, %if.end ]
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then49.1 ], [ 0, %if.end ]
  br i1 %cmp48, label %if.then103, label %if.end143

if.then103:                                       ; preds = %if.end.1
  %add.ptr119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %6
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr119, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr119.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr119.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr119.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119, i64 8
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr119.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr119.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119, i64 12
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr119.sroa_idx, align 4, !tbaa !30
  br label %if.end143

if.end143:                                        ; preds = %if.end.1, %if.then103
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then103 ], [ 0, %if.end.1 ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then103 ], [ 0, %if.end.1 ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then103 ], [ 0, %if.end.1 ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then103 ], [ 0, %if.end.1 ]
  br i1 %cmp48.1, label %if.then103.1, label %if.end143.1

if.then103.1:                                     ; preds = %if.end143
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %6
  %add.ptr119.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3072
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr119.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr119.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3076
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr119.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr119.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3080
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr119.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr119.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3084
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr119.sroa_idx.1, align 4, !tbaa !30
  br label %if.end143.1

if.end143.1:                                      ; preds = %if.then103.1, %if.end143
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ]
  %mul163 = and i32 %mul11, 8128
  %call167.masked = and i32 %2, 1016
  %mul169 = xor i32 %mul61, %call167.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul163
  %invariant.gep645 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul169
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep645, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !66
  %gep646.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep646.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !66
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and182 = shl nuw nsw i32 %2, 6
  %mul183 = and i32 %and182, 960
  %shr186 = lshr i32 %2, 4
  %and189 = and i32 %2, 7
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul183
  %xor190 = xor i32 %shr186, %and189
  %add.ptr194.idx = shl nuw nsw i32 %xor190, 4
  %add.ptr194 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr194.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr194, align 16
  %Q_reg.sroa.4.0.add.ptr194.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr194, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr194.sroa_idx, align 8
  %add187.1 = add nuw nsw i32 %shr186, 4
  %xor190.1 = xor i32 %add187.1, %and189
  %add.ptr194.idx.1 = shl nuw nsw i32 %xor190.1, 4
  %add.ptr194.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr194.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr194.1, align 16
  %Q_reg.sroa.7.16.add.ptr194.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr194.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr194.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %condval.sroa.0.0, ptr addrspace(3) %invariant.gep645, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 4
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 8
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep650.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 12
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep650.sroa_idx, align 4, !tbaa !30
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %gep646.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1028
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep651.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1032
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep651.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1036
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep651.1.sroa_idx, align 4, !tbaa !30
  %add229 = or disjoint i32 %mul20, 15
  %cmp230 = icmp slt i32 %0, %add229
  br i1 %cmp230, label %for.cond232.preheader, label %if.end258

for.cond232.preheader:                            ; preds = %if.end143.1
  %10 = lshr i32 %2, 2
  %mul239 = and i32 %10, 252
  %add240 = add nuw nsw i32 %mul20, %mul239
  %cmp243.not = icmp sgt i32 %add240, %0
  %spec.select = select i1 %cmp243.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert712 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp243.not.1.not = icmp slt i32 %add240, %0
  %spec.select.1 = select i1 %cmp243.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert725 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert712, float %spec.select.1, i64 1
  %add241.2 = or disjoint i32 %add240, 2
  %cmp243.not.2 = icmp sgt i32 %add241.2, %0
  %spec.select.2 = select i1 %cmp243.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert738 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert725, float %spec.select.2, i64 2
  %add241.3 = or disjoint i32 %add240, 3
  %cmp243.not.3 = icmp sgt i32 %add241.3, %0
  %spec.select.3 = select i1 %cmp243.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert751 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert738, float %spec.select.3, i64 3
  br label %if.end258

if.end258:                                        ; preds = %if.end143.1, %for.cond232.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert751, %for.cond232.preheader ], [ zeroinitializer, %if.end143.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr194, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr194.sroa_idx, align 8
  %11 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0)
  %12 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %11)
  %kb.sroa.0.0.copyload706 = load <4 x half>, ptr addrspace(3) %add.ptr194.1, align 16
  %kb.sroa.6.0.copyload707 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr194.1.sroa_idx, align 8
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload706, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %12)
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload707, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %13)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr315.idx = shl nuw nsw i32 %2, 4
  %invariant.gep659 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr315.idx
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep659, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep659.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep659.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep659.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep659.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep659.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep659.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract714 = extractelement <4 x float> %14, i64 0
  %mul325 = fmul contract float %acc_s.sroa.0.0.vec.extract714, 0x3FC2776C60000000
  %15 = tail call contract noundef float @llvm.minnum.f32(float %mul325, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %15, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %15, %cond.i.i
  %16 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %16
  %acc_s.sroa.0.4.vec.extract727 = extractelement <4 x float> %14, i64 1
  %mul325.1 = fmul contract float %acc_s.sroa.0.4.vec.extract727, 0x3FC2776C60000000
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul325.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %17, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %17, %cond.i.i.1
  %18 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %18
  %acc_s.sroa.0.8.vec.extract740 = extractelement <4 x float> %14, i64 2
  %mul325.2 = fmul contract float %acc_s.sroa.0.8.vec.extract740, 0x3FC2776C60000000
  %19 = tail call contract noundef float @llvm.minnum.f32(float %mul325.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %19, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %19, %cond.i.i.2
  %20 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %20
  %acc_s.sroa.0.12.vec.extract753 = extractelement <4 x float> %14, i64 3
  %mul325.3 = fmul contract float %acc_s.sroa.0.12.vec.extract753, 0x3FC2776C60000000
  %21 = tail call contract noundef float @llvm.minnum.f32(float %mul325.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %21, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %21, %cond.i.i.3
  %22 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %22
  %add341 = fadd contract float %mul.i.i, 0.000000e+00
  %add341.1 = fadd contract float %add341, %mul.i.i.1
  %add341.2 = fadd contract float %add341.1, %mul.i.i.2
  %add341.3 = fadd contract float %add341.2, %mul.i.i.3
  %23 = bitcast float %add341.3 to i32
  %24 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %25 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %24) #11
  %xor.i.i = xor i32 %25, 32
  %26 = and i32 %25, -64
  %and.i.i = add nsw i32 %26, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i607 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %25
  %shl.i.i = shl i32 %cond.i.i607, 2
  %27 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %23)
  %28 = bitcast i32 %27 to float
  %add349 = fadd contract float %add341.3, %28
  %29 = bitcast float %add349 to i32
  %30 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %31 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %30) #11
  %xor.i.i608 = xor i32 %31, 16
  %32 = and i32 %31, -64
  %and.i.i609 = add nsw i32 %32, 64
  %cmp.not.i.i610 = icmp slt i32 %xor.i.i608, %and.i.i609
  %cond.i.i611 = select i1 %cmp.not.i.i610, i32 %xor.i.i608, i32 %31
  %shl.i.i612 = shl i32 %cond.i.i611, 2
  %33 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i612, i32 %29)
  %34 = bitcast i32 %33 to float
  %add354 = fadd contract float %add349, %34
  %cmp357 = fcmp contract ogt float %add354, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add354
  %condval_3.0 = select i1 %cmp357, float %div, float 0.000000e+00
  %mul370 = fmul contract float %condval_3.0, %mul.i.i
  %mul370.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul370.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul370.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %35 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !160
  %36 = fptrunc float %mul370 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %35), !noalias !160
  %37 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !160
  %38 = fptrunc float %mul370.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %37), !noalias !160
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %36, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %38, i64 1
  %39 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !174
  %40 = fptrunc float %mul370.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %39), !noalias !174
  %41 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !174
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %41), !noalias !174
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %40, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul400 = and i32 %add.ptr315.idx, 16128
  %and406 = and i32 %2, 15
  %add407 = or disjoint i32 %mul400, %and406
  %arrayidx409 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407
  %42 = load half, ptr addrspace(3) %arrayidx409, align 2, !tbaa !191
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %42, i64 0
  %add402.1 = or disjoint i32 %mul400, %and406
  %add407.1 = or disjoint i32 %add402.1, 64
  %arrayidx409.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1
  %43 = load half, ptr addrspace(3) %arrayidx409.1, align 2, !tbaa !191
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %43, i64 1
  %add402.2 = or disjoint i32 %mul400, %and406
  %add407.2 = or disjoint i32 %add402.2, 128
  %arrayidx409.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2
  %44 = load half, ptr addrspace(3) %arrayidx409.2, align 2, !tbaa !191
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %44, i64 2
  %add402.3 = or disjoint i32 %mul400, %and406
  %add407.3 = or disjoint i32 %add402.3, 192
  %arrayidx409.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3
  %45 = load half, ptr addrspace(3) %arrayidx409.3, align 2, !tbaa !191
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %45, i64 3
  %add404.1685 = or disjoint i32 %mul400, %and406
  %add407.1686 = or disjoint i32 %add404.1685, 16
  %arrayidx409.1687 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1686
  %46 = load half, ptr addrspace(3) %arrayidx409.1687, align 2, !tbaa !191
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %46, i64 0
  %add404.1.1 = or disjoint i32 %mul400, %and406
  %add407.1.1 = or disjoint i32 %add404.1.1, 80
  %arrayidx409.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1.1
  %47 = load half, ptr addrspace(3) %arrayidx409.1.1, align 2, !tbaa !191
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %47, i64 1
  %add404.2.1 = or disjoint i32 %mul400, %and406
  %add407.2.1 = or disjoint i32 %add404.2.1, 144
  %arrayidx409.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2.1
  %48 = load half, ptr addrspace(3) %arrayidx409.2.1, align 2, !tbaa !191
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %48, i64 2
  %add404.3.1 = or disjoint i32 %mul400, %and406
  %add407.3.1 = or disjoint i32 %add404.3.1, 208
  %arrayidx409.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3.1
  %49 = load half, ptr addrspace(3) %arrayidx409.3.1, align 2, !tbaa !191
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %49, i64 3
  %add404.2689 = or disjoint i32 %mul400, %and406
  %add407.2690 = or disjoint i32 %add404.2689, 32
  %arrayidx409.2691 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2690
  %50 = load half, ptr addrspace(3) %arrayidx409.2691, align 2, !tbaa !191
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %50, i64 0
  %add404.1.2 = or disjoint i32 %mul400, %and406
  %add407.1.2 = or disjoint i32 %add404.1.2, 96
  %arrayidx409.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1.2
  %51 = load half, ptr addrspace(3) %arrayidx409.1.2, align 2, !tbaa !191
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %51, i64 1
  %add404.2.2 = or disjoint i32 %mul400, %and406
  %add407.2.2 = or disjoint i32 %add404.2.2, 160
  %arrayidx409.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2.2
  %52 = load half, ptr addrspace(3) %arrayidx409.2.2, align 2, !tbaa !191
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %52, i64 2
  %add404.3.2 = or disjoint i32 %mul400, %and406
  %add407.3.2 = or disjoint i32 %add404.3.2, 224
  %arrayidx409.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3.2
  %53 = load half, ptr addrspace(3) %arrayidx409.3.2, align 2, !tbaa !191
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %53, i64 3
  %add404.3693 = or disjoint i32 %mul400, %and406
  %add407.3694 = or disjoint i32 %add404.3693, 48
  %arrayidx409.3695 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3694
  %54 = load half, ptr addrspace(3) %arrayidx409.3695, align 2, !tbaa !191
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %54, i64 0
  %add404.1.3 = or disjoint i32 %mul400, %and406
  %add407.1.3 = or disjoint i32 %add404.1.3, 112
  %arrayidx409.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1.3
  %55 = load half, ptr addrspace(3) %arrayidx409.1.3, align 2, !tbaa !191
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %55, i64 1
  %add404.2.3 = or disjoint i32 %mul400, %and406
  %add407.2.3 = or disjoint i32 %add404.2.3, 176
  %arrayidx409.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2.3
  %56 = load half, ptr addrspace(3) %arrayidx409.2.3, align 2, !tbaa !191
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %56, i64 2
  %add404.3.3 = or disjoint i32 %add.ptr315.idx, %and406
  %add407.3.3 = or i32 %add404.3.3, 240
  %arrayidx409.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3.3
  %57 = load half, ptr addrspace(3) %arrayidx409.3.3, align 2, !tbaa !191
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %57, i64 3
  %58 = fptrunc float %mul370.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %58, i64 3
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end438

if.end438:                                        ; preds = %if.end258, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %59, %if.end258 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %60, %if.end258 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %61, %if.end258 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %62, %if.end258 ], [ zeroinitializer, %entry ]
  %and467 = shl nuw nsw i32 %2, 6
  %mul468 = and i32 %and467, 960
  %add469 = or disjoint i32 %add, %mul468
  %63 = lshr i32 %2, 2
  %mul474 = and i32 %63, 252
  %add471 = add nuw nsw i32 %add469, %mul474
  %64 = zext nneg i32 %add471 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %65 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %66 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %65), !noalias !199
  %67 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %68 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %67), !noalias !199
  %69 = bitcast half %66 to i16
  %70 = bitcast half %68 to i16
  %71 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %72 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %71), !noalias !214
  %73 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %74 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %73), !noalias !214
  %75 = bitcast half %72 to i16
  %76 = bitcast half %74 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %76 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %75 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %70 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %69 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr477 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr477, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %77 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %78 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %77), !noalias !199
  %79 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %80 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %79), !noalias !199
  %81 = bitcast half %78 to i16
  %82 = bitcast half %80 to i16
  %83 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %84 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %83), !noalias !214
  %85 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %86 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %85), !noalias !214
  %87 = bitcast half %84 to i16
  %88 = bitcast half %86 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %88 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %87 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %82 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %81 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %89 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64
  %add.ptr477.1 = getelementptr inbounds i8, ptr addrspace(1) %89, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr477.1, align 8
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %90 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %91 = fptrunc float %acc_o.sroa.22.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %90), !noalias !199
  %92 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %93 = fptrunc float %acc_o.sroa.22.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %92), !noalias !199
  %94 = bitcast half %91 to i16
  %95 = bitcast half %93 to i16
  %96 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %97 = fptrunc float %acc_o.sroa.22.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %96), !noalias !214
  %98 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %99 = fptrunc float %acc_o.sroa.22.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %98), !noalias !214
  %100 = bitcast half %97 to i16
  %101 = bitcast half %99 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %101 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %100 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %95 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %94 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %102 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64
  %add.ptr477.2 = getelementptr inbounds i8, ptr addrspace(1) %102, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr477.2, align 8
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %103 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %104 = fptrunc float %acc_o.sroa.32.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %103), !noalias !199
  %105 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %106 = fptrunc float %acc_o.sroa.32.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %105), !noalias !199
  %107 = bitcast half %104 to i16
  %108 = bitcast half %106 to i16
  %109 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %110 = fptrunc float %acc_o.sroa.32.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %109), !noalias !214
  %111 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !214
  %112 = fptrunc float %acc_o.sroa.32.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %111), !noalias !214
  %113 = bitcast half %110 to i16
  %114 = bitcast half %112 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %114 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %113 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %108 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %107 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %115 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64
  %add.ptr477.3 = getelementptr inbounds i8, ptr addrspace(1) %115, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr477.3, align 8
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

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #7

declare float @llvm.exp2.f32(float) #8

declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

declare float @llvm.minnum.f32(float, float) #8

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


