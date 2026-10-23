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
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2
  %3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %3, i64 1024
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %4 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %mul14 = shl nsw i32 %4, 4
  %cmp28 = icmp sgt i32 %4, -1
  br i1 %cmp28, label %land.lhs.true, label %if.end416

land.lhs.true:                                    ; preds = %entry
  %cmp29 = icmp ugt i32 %4, 31
  %cmp32.not = icmp sgt i32 %mul14, %0
  %or.cond = select i1 %cmp29, i1 true, i1 %cmp32.not
  br i1 %or.cond, label %if.end416, label %for.cond33.preheader

for.cond33.preheader:                             ; preds = %land.lhs.true
  %shr = lshr i32 %1, 3
  %add40 = add nuw nsw i32 %mul14, %shr
  %mul45 = shl nuw nsw i32 %4, 10
  %add46 = add nuw nsw i32 %mul45, %mul8
  %5 = zext nneg i32 %add46 to i64
  %cmp42 = icmp slt i32 %add40, 511
  br i1 %cmp42, label %if.then43, label %if.end

if.then43:                                        ; preds = %for.cond33.preheader
  %add.ptr51 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %5
  %condval.sroa.7.0.add.ptr51.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr51, i64 12
  %condval.sroa.6.0.add.ptr51.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr51, i64 8
  %condval.sroa.5.0.add.ptr51.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr51, i64 4
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr51, align 16, !tbaa !30
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr51.sroa_idx, align 4, !tbaa !30
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr51.sroa_idx, align 8, !tbaa !30
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr51.sroa_idx, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %for.cond33.preheader, %if.then43
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ]
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ]
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ]
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ]
  %cmp42.1 = icmp slt i32 %add40, 503
  br i1 %cmp42.1, label %if.then43.1, label %if.end.1

if.then43.1:                                      ; preds = %if.end
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %5
  %add.ptr51.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1024
  %condval.sroa.7.0.add.ptr51.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1036
  %condval.sroa.6.0.add.ptr51.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1032
  %condval.sroa.5.0.add.ptr51.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1028
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr51.1, align 16, !tbaa !30
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr51.sroa_idx.1, align 4, !tbaa !30
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr51.sroa_idx.1, align 8, !tbaa !30
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr51.sroa_idx.1, align 4, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.then43.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then43.1 ], [ 0, %if.end ]
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then43.1 ], [ 0, %if.end ]
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then43.1 ], [ 0, %if.end ]
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then43.1 ], [ 0, %if.end ]
  br i1 %cmp42, label %if.then90, label %if.end122

if.then90:                                        ; preds = %if.end.1
  %add.ptr98 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %5
  %condval_1.sroa.7.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 12
  %condval_1.sroa.6.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 8
  %condval_1.sroa.5.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr98, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr98.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr98.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr98.sroa_idx, align 4, !tbaa !30
  br label %if.end122

if.end122:                                        ; preds = %if.end.1, %if.then90
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then90 ], [ 0, %if.end.1 ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then90 ], [ 0, %if.end.1 ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then90 ], [ 0, %if.end.1 ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then90 ], [ 0, %if.end.1 ]
  br i1 %cmp42.1, label %if.then90.1, label %if.end122.1

if.then90.1:                                      ; preds = %if.end122
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %5
  %add.ptr98.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1024
  %condval_1.sroa.7.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1036
  %condval_1.sroa.6.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1032
  %condval_1.sroa.5.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1028
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr98.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr98.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr98.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr98.sroa_idx.1, align 4, !tbaa !30
  br label %if.end122.1

if.end122.1:                                      ; preds = %if.then90.1, %if.end122
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ]
  %mul142 = and i32 %mul8, 8128
  %xor548 = and i32 %mul8, 56
  %call145.masked = and i32 %1, 1016
  %mul147 = xor i32 %xor548, %call145.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul142
  %invariant.gep620 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul147
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep620, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !62
  %gep621.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep621.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !62
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and160 = shl nuw nsw i32 %1, 6
  %mul161 = and i32 %and160, 960
  %shr164 = lshr i32 %1, 4
  %and167 = and i32 %1, 7
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul161
  %xor168 = xor i32 %shr164, %and167
  %add.ptr172.idx = shl nuw nsw i32 %xor168, 4
  %add.ptr172 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 %add.ptr172.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr172, align 16
  %Q_reg.sroa.4.0.add.ptr172.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr172.sroa_idx, align 8
  %add165.1 = add nuw nsw i32 %shr164, 4
  %xor168.1 = xor i32 %add165.1, %and167
  %add.ptr172.idx.1 = shl nuw nsw i32 %xor168.1, 4
  %add.ptr172.1 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 %add.ptr172.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr172.1, align 16
  %Q_reg.sroa.7.16.add.ptr172.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr172.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %condval.sroa.0.0, ptr addrspace(3) %invariant.gep620, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 4
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep625.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 8
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep625.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 12
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep625.sroa_idx, align 4, !tbaa !30
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %gep621.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep626.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1028
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep626.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep626.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1032
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep626.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep626.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1036
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep626.1.sroa_idx, align 4, !tbaa !30
  %add207 = or disjoint i32 %mul14, 15
  %cmp208 = icmp slt i32 %0, %add207
  br i1 %cmp208, label %for.cond210.preheader, label %if.end236

for.cond210.preheader:                            ; preds = %if.end122.1
  %9 = lshr i32 %1, 2
  %mul217 = and i32 %9, 252
  %add218 = add nuw nsw i32 %mul14, %mul217
  %cmp221.not = icmp sgt i32 %add218, %0
  %spec.select = select i1 %cmp221.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert687 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp221.not.1.not = icmp slt i32 %add218, %0
  %spec.select.1 = select i1 %cmp221.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert700 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert687, float %spec.select.1, i64 1
  %add219.2 = or disjoint i32 %add218, 2
  %cmp221.not.2 = icmp sgt i32 %add219.2, %0
  %spec.select.2 = select i1 %cmp221.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert713 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert700, float %spec.select.2, i64 2
  %add219.3 = or disjoint i32 %add218, 3
  %cmp221.not.3 = icmp sgt i32 %add219.3, %0
  %spec.select.3 = select i1 %cmp221.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert726 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert713, float %spec.select.3, i64 3
  br label %if.end236

if.end236:                                        ; preds = %if.end122.1, %for.cond210.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert726, %for.cond210.preheader ], [ zeroinitializer, %if.end122.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr172, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr172.sroa_idx, align 8
  %10 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0)
  %11 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %10)
  %kb.sroa.0.0.copyload681 = load <4 x half>, ptr addrspace(3) %add.ptr172.1, align 16
  %kb.sroa.6.0.copyload682 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr172.1.sroa_idx, align 8
  %12 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload681, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %11)
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload682, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %12)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr293.idx = shl nuw nsw i32 %1, 4
  %invariant.gep634 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr293.idx
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep634, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep634.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep634.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep634.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract689 = extractelement <4 x float> %13, i64 0
  %mul303 = fmul contract float %acc_s.sroa.0.0.vec.extract689, 0x3FC2776C60000000
  %14 = tail call contract noundef float @llvm.minnum.f32(float %mul303, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %14, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %14, %cond.i.i
  %15 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %15
  %acc_s.sroa.0.4.vec.extract702 = extractelement <4 x float> %13, i64 1
  %mul303.1 = fmul contract float %acc_s.sroa.0.4.vec.extract702, 0x3FC2776C60000000
  %16 = tail call contract noundef float @llvm.minnum.f32(float %mul303.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %16, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %16, %cond.i.i.1
  %17 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %17
  %acc_s.sroa.0.8.vec.extract715 = extractelement <4 x float> %13, i64 2
  %mul303.2 = fmul contract float %acc_s.sroa.0.8.vec.extract715, 0x3FC2776C60000000
  %18 = tail call contract noundef float @llvm.minnum.f32(float %mul303.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %18, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %18, %cond.i.i.2
  %19 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %19
  %acc_s.sroa.0.12.vec.extract728 = extractelement <4 x float> %13, i64 3
  %mul303.3 = fmul contract float %acc_s.sroa.0.12.vec.extract728, 0x3FC2776C60000000
  %20 = tail call contract noundef float @llvm.minnum.f32(float %mul303.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %20, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %20, %cond.i.i.3
  %21 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %21
  %add319 = fadd contract float %mul.i.i, 0.000000e+00
  %add319.1 = fadd contract float %add319, %mul.i.i.1
  %add319.2 = fadd contract float %add319.1, %mul.i.i.2
  %add319.3 = fadd contract float %add319.2, %mul.i.i.3
  %22 = bitcast float %add319.3 to i32
  %23 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %24 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %23) #11
  %xor.i.i = xor i32 %24, 32
  %25 = and i32 %24, -64
  %and.i.i = add nsw i32 %25, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i582 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %24
  %shl.i.i = shl i32 %cond.i.i582, 2
  %26 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %22)
  %27 = bitcast i32 %26 to float
  %add327 = fadd contract float %add319.3, %27
  %28 = bitcast float %add327 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11
  %xor.i.i583 = xor i32 %30, 16
  %31 = and i32 %30, -64
  %and.i.i584 = add nsw i32 %31, 64
  %cmp.not.i.i585 = icmp slt i32 %xor.i.i583, %and.i.i584
  %cond.i.i586 = select i1 %cmp.not.i.i585, i32 %xor.i.i583, i32 %30
  %shl.i.i587 = shl i32 %cond.i.i586, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i587, i32 %28)
  %33 = bitcast i32 %32 to float
  %add332 = fadd contract float %add327, %33
  %cmp335 = fcmp contract ogt float %add332, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add332
  %condval_3.0 = select i1 %cmp335, float %div, float 0.000000e+00
  %mul348 = fmul contract float %condval_3.0, %mul.i.i
  %mul348.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul348.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul348.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %34 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !156
  %35 = fptrunc float %mul348 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %34), !noalias !156
  %36 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !156
  %37 = fptrunc float %mul348.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %36), !noalias !156
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %35, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %37, i64 1
  %38 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !170
  %39 = fptrunc float %mul348.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %38), !noalias !170
  %40 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !170
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %40), !noalias !170
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %39, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul378 = and i32 %add.ptr293.idx, 16128
  %and384 = and i32 %1, 15
  %add385 = or disjoint i32 %mul378, %and384
  %arrayidx387 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385
  %41 = load half, ptr addrspace(3) %arrayidx387, align 2, !tbaa !187
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %41, i64 0
  %add380.1 = or disjoint i32 %mul378, %and384
  %add385.1 = or disjoint i32 %add380.1, 64
  %arrayidx387.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1
  %42 = load half, ptr addrspace(3) %arrayidx387.1, align 2, !tbaa !187
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %42, i64 1
  %add380.2 = or disjoint i32 %mul378, %and384
  %add385.2 = or disjoint i32 %add380.2, 128
  %arrayidx387.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2
  %43 = load half, ptr addrspace(3) %arrayidx387.2, align 2, !tbaa !187
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %43, i64 2
  %add380.3 = or disjoint i32 %mul378, %and384
  %add385.3 = or disjoint i32 %add380.3, 192
  %arrayidx387.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3
  %44 = load half, ptr addrspace(3) %arrayidx387.3, align 2, !tbaa !187
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %44, i64 3
  %add382.1660 = or disjoint i32 %mul378, %and384
  %add385.1661 = or disjoint i32 %add382.1660, 16
  %arrayidx387.1662 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1661
  %45 = load half, ptr addrspace(3) %arrayidx387.1662, align 2, !tbaa !187
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %45, i64 0
  %add382.1.1 = or disjoint i32 %mul378, %and384
  %add385.1.1 = or disjoint i32 %add382.1.1, 80
  %arrayidx387.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.1
  %46 = load half, ptr addrspace(3) %arrayidx387.1.1, align 2, !tbaa !187
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %46, i64 1
  %add382.2.1 = or disjoint i32 %mul378, %and384
  %add385.2.1 = or disjoint i32 %add382.2.1, 144
  %arrayidx387.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.1
  %47 = load half, ptr addrspace(3) %arrayidx387.2.1, align 2, !tbaa !187
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %47, i64 2
  %add382.3.1 = or disjoint i32 %mul378, %and384
  %add385.3.1 = or disjoint i32 %add382.3.1, 208
  %arrayidx387.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.1
  %48 = load half, ptr addrspace(3) %arrayidx387.3.1, align 2, !tbaa !187
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %48, i64 3
  %add382.2664 = or disjoint i32 %mul378, %and384
  %add385.2665 = or disjoint i32 %add382.2664, 32
  %arrayidx387.2666 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2665
  %49 = load half, ptr addrspace(3) %arrayidx387.2666, align 2, !tbaa !187
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %49, i64 0
  %add382.1.2 = or disjoint i32 %mul378, %and384
  %add385.1.2 = or disjoint i32 %add382.1.2, 96
  %arrayidx387.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.2
  %50 = load half, ptr addrspace(3) %arrayidx387.1.2, align 2, !tbaa !187
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %50, i64 1
  %add382.2.2 = or disjoint i32 %mul378, %and384
  %add385.2.2 = or disjoint i32 %add382.2.2, 160
  %arrayidx387.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.2
  %51 = load half, ptr addrspace(3) %arrayidx387.2.2, align 2, !tbaa !187
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %51, i64 2
  %add382.3.2 = or disjoint i32 %mul378, %and384
  %add385.3.2 = or disjoint i32 %add382.3.2, 224
  %arrayidx387.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.2
  %52 = load half, ptr addrspace(3) %arrayidx387.3.2, align 2, !tbaa !187
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %52, i64 3
  %add382.3668 = or disjoint i32 %mul378, %and384
  %add385.3669 = or disjoint i32 %add382.3668, 48
  %arrayidx387.3670 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3669
  %53 = load half, ptr addrspace(3) %arrayidx387.3670, align 2, !tbaa !187
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %53, i64 0
  %add382.1.3 = or disjoint i32 %mul378, %and384
  %add385.1.3 = or disjoint i32 %add382.1.3, 112
  %arrayidx387.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.3
  %54 = load half, ptr addrspace(3) %arrayidx387.1.3, align 2, !tbaa !187
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %54, i64 1
  %add382.2.3 = or disjoint i32 %mul378, %and384
  %add385.2.3 = or disjoint i32 %add382.2.3, 176
  %arrayidx387.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.3
  %55 = load half, ptr addrspace(3) %arrayidx387.2.3, align 2, !tbaa !187
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %55, i64 2
  %add382.3.3 = or disjoint i32 %add.ptr293.idx, %and384
  %add385.3.3 = or i32 %add382.3.3, 240
  %arrayidx387.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.3
  %56 = load half, ptr addrspace(3) %arrayidx387.3.3, align 2, !tbaa !187
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %56, i64 3
  %57 = fptrunc float %mul348.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %57, i64 3
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end416

if.end416:                                        ; preds = %if.end236, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %58, %if.end236 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %59, %if.end236 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %60, %if.end236 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %61, %if.end236 ], [ zeroinitializer, %entry ]
  %and442 = shl nuw nsw i32 %1, 6
  %mul443 = and i32 %and442, 960
  %add444 = or disjoint i32 %mul443, %mul
  %62 = lshr i32 %1, 2
  %mul449 = and i32 %62, 252
  %add446 = add nuw nsw i32 %add444, %mul449
  %63 = zext nneg i32 %add446 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %64 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %65 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %64), !noalias !195
  %66 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %67 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %66), !noalias !195
  %68 = bitcast half %65 to i16
  %69 = bitcast half %67 to i16
  %70 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %71 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %70), !noalias !210
  %72 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %73 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %72), !noalias !210
  %74 = bitcast half %71 to i16
  %75 = bitcast half %73 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %75 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %74 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %69 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %68 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr452 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr452, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %76 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %77 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %76), !noalias !195
  %78 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %79 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %78), !noalias !195
  %80 = bitcast half %77 to i16
  %81 = bitcast half %79 to i16
  %82 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %83 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %82), !noalias !210
  %84 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %85 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %84), !noalias !210
  %86 = bitcast half %83 to i16
  %87 = bitcast half %85 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %87 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %86 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %81 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %80 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %88 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63
  %add.ptr452.1 = getelementptr inbounds i8, ptr addrspace(1) %88, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr452.1, align 8
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %89 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %90 = fptrunc float %acc_o.sroa.22.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %89), !noalias !195
  %91 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %92 = fptrunc float %acc_o.sroa.22.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %91), !noalias !195
  %93 = bitcast half %90 to i16
  %94 = bitcast half %92 to i16
  %95 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %96 = fptrunc float %acc_o.sroa.22.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %95), !noalias !210
  %97 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %98 = fptrunc float %acc_o.sroa.22.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %97), !noalias !210
  %99 = bitcast half %96 to i16
  %100 = bitcast half %98 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %100 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %99 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %94 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %93 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %101 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63
  %add.ptr452.2 = getelementptr inbounds i8, ptr addrspace(1) %101, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr452.2, align 8
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %103 = fptrunc float %acc_o.sroa.32.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !noalias !195
  %104 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !195
  %105 = fptrunc float %acc_o.sroa.32.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %104), !noalias !195
  %106 = bitcast half %103 to i16
  %107 = bitcast half %105 to i16
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %109 = fptrunc float %acc_o.sroa.32.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !noalias !210
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !210
  %111 = fptrunc float %acc_o.sroa.32.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !noalias !210
  %112 = bitcast half %109 to i16
  %113 = bitcast half %111 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %113 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %112 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %107 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %106 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %114 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63
  %add.ptr452.3 = getelementptr inbounds i8, ptr addrspace(1) %114, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr452.3, align 8
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


