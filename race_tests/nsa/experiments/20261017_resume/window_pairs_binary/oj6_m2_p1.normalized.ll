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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(1) noalias nocapture noundef readonly %Schedule.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = mul nuw nsw i32 %1, 241
  %idxprom = zext nneg i32 %mul to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Schedule.coerce, i64 %idxprom
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp = icmp slt i32 %0, %2
  br i1 %cmp, label %if.then, label %if.end526

if.then:                                          ; preds = %entry
  %mul9 = mul nuw nsw i32 %0, 3
  %add = add nuw nsw i32 %mul, %mul9
  %3 = zext nneg i32 %add to i64
  %4 = getelementptr inbounds i32, ptr addrspace(1) %Schedule.coerce, i64 %3
  %arrayidx12 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 4
  %5 = load i32, ptr addrspace(1) %arrayidx12, align 4, !tbaa !30
  %arrayidx20 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 8
  %6 = load i32, ptr addrspace(1) %arrayidx20, align 4, !tbaa !30
  %arrayidx28 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 12
  %7 = load i32, ptr addrspace(1) %arrayidx28, align 4, !tbaa !30
  %invariant.gep714 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
  %8 = lshr i32 %1, 3
  %shr = zext nneg i32 %8 to i64
  %9 = tail call range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !59
  %10 = shl nuw nsw i32 %9, 2
  %mul67 = zext nneg i32 %10 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %mul67
  %cmp87 = icmp ult i32 %5, 32
  %mul88 = shl nsw i32 %5, 5
  %11 = shl nuw nsw i32 %5, 13
  %mul102 = zext nneg i32 %11 to i64
  %12 = shl nuw nsw i32 %9, 3
  %mul109 = zext nneg i32 %12 to i64
  %invariant.gep681 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul109
  %and = lshr i32 %9, 1
  %shr134 = and i32 %and, 15
  %shr137 = lshr i32 %9, 5
  %add132 = and i32 %10, 3972
  %and156 = shl nuw nsw i32 %9, 7
  %mul157 = and i32 %and156, 1920
  %shr160 = lshr i32 %9, 4
  %and163 = and i32 %9, 15
  %gep713 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %mul157
  %13 = lshr i32 %9, 2
  %mul193 = and i32 %13, 252
  %add190 = add nuw nsw i32 %mul88, %mul193
  %gep715 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep714, i64 %mul109
  %mul465 = and i32 %13, 4
  %mul493 = and i32 %12, 8064
  %invariant.gep711 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul493
  %14 = shl nuw nsw i32 %1, 18
  %mul508 = and i32 %14, 2145386496
  %add510 = or disjoint i32 %mul508, %12
  %cmp32 = icmp sgt i32 %6, -1
  br i1 %cmp32, label %for.cond34.preheader, label %if.end522

for.cond34.preheader:                             ; preds = %if.then
  %cmp42 = icmp ult i32 %6, 1024
  %condval_4.0 = zext nneg i32 %6 to i64
  br i1 %cmp42, label %if.then43, label %if.end79

for.body421.preheader:                            ; preds = %if.end79.7
  %.pre = add nuw nsw i32 %shr137, 2
  %.pre1689 = add nuw nsw i32 %shr137, 4
  %.pre1690 = add nuw nsw i32 %shr137, 6
  %.pre1691 = add nuw nsw i32 %shr137, 8
  %.pre1692 = add nuw nsw i32 %shr137, 10
  %.pre1693 = add nuw nsw i32 %shr137, 12
  %.pre1694 = add nuw nsw i32 %shr137, 14
  br label %if.end441

if.then43:                                        ; preds = %for.cond34.preheader
  %.idx718 = shl nuw nsw i64 %condval_4.0, 12
  %15 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718
  %.idx719 = shl nuw nsw i64 %shr, 22
  %16 = getelementptr i8, ptr addrspace(4) %15, i64 %.idx719
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %16, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %16, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !tbaa !30
  br label %if.end79

if.end79:                                         ; preds = %for.cond34.preheader, %if.then43
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then43 ], [ 0, %for.cond34.preheader ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then43 ], [ 0, %for.cond34.preheader ]
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0 to i64
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0 to i64
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext
  br i1 %cmp42, label %if.then43.1, label %if.end79.1

if.then43.1:                                      ; preds = %if.end79
  %.idx718.1 = shl nuw nsw i64 %condval_4.0, 12
  %17 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.1
  %.idx719.1 = shl nuw nsw i64 %shr, 22
  %18 = getelementptr i8, ptr addrspace(4) %17, i64 %.idx719.1
  %gep.1 = getelementptr i8, ptr addrspace(4) %18, i64 512
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr i8, ptr addrspace(4) %18, i64 516
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !tbaa !30
  br label %if.end79.1

if.end79.1:                                       ; preds = %if.then43.1, %if.end79
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then43.1 ], [ 0, %if.end79 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then43.1 ], [ 0, %if.end79 ]
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.1 to i64
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.1 to i64
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext
  br i1 %cmp42, label %if.then43.2, label %if.end79.2

if.then43.2:                                      ; preds = %if.end79.1
  %.idx718.2 = shl nuw nsw i64 %condval_4.0, 12
  %19 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.2
  %.idx719.2 = shl nuw nsw i64 %shr, 22
  %20 = getelementptr i8, ptr addrspace(4) %19, i64 %.idx719.2
  %gep.2 = getelementptr i8, ptr addrspace(4) %20, i64 1024
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr i8, ptr addrspace(4) %20, i64 1028
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !tbaa !30
  br label %if.end79.2

if.end79.2:                                       ; preds = %if.then43.2, %if.end79.1
  %condval_1.sroa.0.0.2 = phi i32 [ %condval_1.sroa.0.0.copyload.2, %if.then43.2 ], [ 0, %if.end79.1 ]
  %condval_1.sroa.5.0.2 = phi i32 [ %condval_1.sroa.5.0.copyload.2, %if.then43.2 ], [ 0, %if.end79.1 ]
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.2 to i64
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.2 to i64
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext
  br i1 %cmp42, label %if.then43.3, label %if.end79.3

if.then43.3:                                      ; preds = %if.end79.2
  %.idx718.3 = shl nuw nsw i64 %condval_4.0, 12
  %21 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.3
  %.idx719.3 = shl nuw nsw i64 %shr, 22
  %22 = getelementptr i8, ptr addrspace(4) %21, i64 %.idx719.3
  %gep.3 = getelementptr i8, ptr addrspace(4) %22, i64 1536
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr i8, ptr addrspace(4) %22, i64 1540
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !tbaa !30
  br label %if.end79.3

if.end79.3:                                       ; preds = %if.then43.3, %if.end79.2
  %condval_1.sroa.0.0.3 = phi i32 [ %condval_1.sroa.0.0.copyload.3, %if.then43.3 ], [ 0, %if.end79.2 ]
  %condval_1.sroa.5.0.3 = phi i32 [ %condval_1.sroa.5.0.copyload.3, %if.then43.3 ], [ 0, %if.end79.2 ]
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.3 to i64
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.3 to i64
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext
  br i1 %cmp42, label %if.then43.4, label %if.end79.4

if.then43.4:                                      ; preds = %if.end79.3
  %.idx718.4 = shl nuw nsw i64 %condval_4.0, 12
  %23 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.4
  %.idx719.4 = shl nuw nsw i64 %shr, 22
  %24 = getelementptr i8, ptr addrspace(4) %23, i64 %.idx719.4
  %gep.4 = getelementptr i8, ptr addrspace(4) %24, i64 2048
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr i8, ptr addrspace(4) %24, i64 2052
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !tbaa !30
  br label %if.end79.4

if.end79.4:                                       ; preds = %if.then43.4, %if.end79.3
  %condval_1.sroa.0.0.4 = phi i32 [ %condval_1.sroa.0.0.copyload.4, %if.then43.4 ], [ 0, %if.end79.3 ]
  %condval_1.sroa.5.0.4 = phi i32 [ %condval_1.sroa.5.0.copyload.4, %if.then43.4 ], [ 0, %if.end79.3 ]
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.4 to i64
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.4 to i64
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext
  br i1 %cmp42, label %if.then43.5, label %if.end79.5

if.then43.5:                                      ; preds = %if.end79.4
  %.idx718.5 = shl nuw nsw i64 %condval_4.0, 12
  %25 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.5
  %.idx719.5 = shl nuw nsw i64 %shr, 22
  %26 = getelementptr i8, ptr addrspace(4) %25, i64 %.idx719.5
  %gep.5 = getelementptr i8, ptr addrspace(4) %26, i64 2560
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr i8, ptr addrspace(4) %26, i64 2564
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !tbaa !30
  br label %if.end79.5

if.end79.5:                                       ; preds = %if.then43.5, %if.end79.4
  %condval_1.sroa.0.0.5 = phi i32 [ %condval_1.sroa.0.0.copyload.5, %if.then43.5 ], [ 0, %if.end79.4 ]
  %condval_1.sroa.5.0.5 = phi i32 [ %condval_1.sroa.5.0.copyload.5, %if.then43.5 ], [ 0, %if.end79.4 ]
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.5 to i64
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.5 to i64
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext
  br i1 %cmp42, label %if.then43.6, label %if.end79.6

if.then43.6:                                      ; preds = %if.end79.5
  %.idx718.6 = shl nuw nsw i64 %condval_4.0, 12
  %27 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.6
  %.idx719.6 = shl nuw nsw i64 %shr, 22
  %28 = getelementptr i8, ptr addrspace(4) %27, i64 %.idx719.6
  %gep.6 = getelementptr i8, ptr addrspace(4) %28, i64 3072
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr i8, ptr addrspace(4) %28, i64 3076
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !tbaa !30
  br label %if.end79.6

if.end79.6:                                       ; preds = %if.then43.6, %if.end79.5
  %condval_1.sroa.0.0.6 = phi i32 [ %condval_1.sroa.0.0.copyload.6, %if.then43.6 ], [ 0, %if.end79.5 ]
  %condval_1.sroa.5.0.6 = phi i32 [ %condval_1.sroa.5.0.copyload.6, %if.then43.6 ], [ 0, %if.end79.5 ]
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.6 to i64
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.6 to i64
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext
  br i1 %cmp42, label %if.then43.7, label %if.end79.7

if.then43.7:                                      ; preds = %if.end79.6
  %.idx718.7 = shl nuw nsw i64 %condval_4.0, 12
  %29 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.7
  %.idx719.7 = shl nuw nsw i64 %shr, 22
  %30 = getelementptr i8, ptr addrspace(4) %29, i64 %.idx719.7
  %gep.7 = getelementptr i8, ptr addrspace(4) %30, i64 3584
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr i8, ptr addrspace(4) %30, i64 3588
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !tbaa !30
  %31 = zext i32 %condval_1.sroa.0.0.copyload.7 to i64
  %32 = zext i32 %condval_1.sroa.5.0.copyload.7 to i64
  %33 = shl nuw i64 %32, 32
  br label %if.end79.7

if.end79.7:                                       ; preds = %if.then43.7, %if.end79.6
  %condval_1.sroa.0.0.7 = phi i64 [ %31, %if.then43.7 ], [ 0, %if.end79.6 ]
  %condval_1.sroa.5.0.7 = phi i64 [ %33, %if.then43.7 ], [ 0, %if.end79.6 ]
  %cmp89 = icmp sle i32 %mul88, %6
  %or.cond717 = select i1 %cmp87, i1 %cmp89, i1 false
  br i1 %or.cond717, label %for.body96.preheader, label %for.body421.preheader

for.body96.preheader:                             ; preds = %if.end79.7
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %condval_1.sroa.5.0.7, %condval_1.sroa.0.0.7
  %.idx720 = shl nuw nsw i64 %shr, 19
  %34 = getelementptr i8, ptr addrspace(4) %invariant.gep681, i64 %.idx720
  %35 = getelementptr %struct.__half, ptr addrspace(4) %34, i64 %mul102
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %35, align 16
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %35, i64 8
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8
  %gep682.1 = getelementptr i8, ptr addrspace(4) %35, i64 1024
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep682.1, align 16
  %k.sroa.12.16.gep682.1.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 1032
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep682.1.sroa_idx, align 8
  %gep682.2 = getelementptr i8, ptr addrspace(4) %35, i64 2048
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep682.2, align 16
  %k.sroa.18.32.gep682.2.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 2056
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep682.2.sroa_idx, align 8
  %gep682.3 = getelementptr i8, ptr addrspace(4) %35, i64 3072
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep682.3, align 16
  %k.sroa.24.48.gep682.3.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 3080
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep682.3.sroa_idx, align 8
  %gep682.4 = getelementptr i8, ptr addrspace(4) %35, i64 4096
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep682.4, align 16
  %k.sroa.30.64.gep682.4.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 4104
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep682.4.sroa_idx, align 8
  %gep682.5 = getelementptr i8, ptr addrspace(4) %35, i64 5120
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep682.5, align 16
  %k.sroa.36.80.gep682.5.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 5128
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep682.5.sroa_idx, align 8
  %gep682.6 = getelementptr i8, ptr addrspace(4) %35, i64 6144
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep682.6, align 16
  %k.sroa.42.96.gep682.6.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 6152
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep682.6.sroa_idx, align 8
  %gep682.7 = getelementptr i8, ptr addrspace(4) %35, i64 7168
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep682.7, align 16
  %k.sroa.48.112.gep682.7.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 7176
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep682.7.sroa_idx, align 8
  %xor = xor i32 %shr137, %shr134
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132
  %gep684.idx = shl nuw nsw i32 %xor, 4
  %gep684 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 %gep684.idx
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %gep684, align 8
  %add138.1 = add nuw nsw i32 %shr137, 2
  %xor.1 = xor i32 %add138.1, %shr134
  %37 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 512
  %gep684.idx.1 = shl nuw nsw i32 %xor.1, 4
  %gep684.1 = getelementptr inbounds i8, ptr addrspace(3) %37, i32 %gep684.idx.1
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %gep684.1, align 8
  %add138.2 = add nuw nsw i32 %shr137, 4
  %xor.2 = xor i32 %add138.2, %shr134
  %38 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 1024
  %gep684.idx.2 = shl nuw nsw i32 %xor.2, 4
  %gep684.2 = getelementptr inbounds i8, ptr addrspace(3) %38, i32 %gep684.idx.2
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %gep684.2, align 8
  %add138.3 = add nuw nsw i32 %shr137, 6
  %xor.3 = xor i32 %add138.3, %shr134
  %39 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 1536
  %gep684.idx.3 = shl nuw nsw i32 %xor.3, 4
  %gep684.3 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %gep684.idx.3
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %gep684.3, align 8
  %add138.4 = add nuw nsw i32 %shr137, 8
  %xor.4 = xor i32 %add138.4, %shr134
  %40 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 2048
  %gep684.idx.4 = shl nuw nsw i32 %xor.4, 4
  %gep684.4 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %gep684.idx.4
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %gep684.4, align 8
  %add138.5 = add nuw nsw i32 %shr137, 10
  %xor.5 = xor i32 %add138.5, %shr134
  %41 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 2560
  %gep684.idx.5 = shl nuw nsw i32 %xor.5, 4
  %gep684.5 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %gep684.idx.5
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %gep684.5, align 8
  %add138.6 = add nuw nsw i32 %shr137, 12
  %xor.6 = xor i32 %add138.6, %shr134
  %42 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 3072
  %gep684.idx.6 = shl nuw nsw i32 %xor.6, 4
  %gep684.6 = getelementptr inbounds i8, ptr addrspace(3) %42, i32 %gep684.idx.6
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %gep684.6, align 8
  %add138.7 = add nuw nsw i32 %shr137, 14
  %xor.7 = xor i32 %add138.7, %shr134
  %43 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 3584
  %gep684.idx.7 = shl nuw nsw i32 %xor.7, 4
  %gep684.7 = getelementptr inbounds i8, ptr addrspace(3) %43, i32 %gep684.idx.7
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %gep684.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor164 = xor i32 %shr160, %and163
  %.idx = shl nuw nsw i32 %xor164, 4
  %gep687 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep687, align 16
  %q.sroa.6.0.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687, i32 8
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep687.sroa_idx, align 8
  %add161.1 = add nuw nsw i32 %shr160, 4
  %xor164.1 = xor i32 %add161.1, %and163
  %.idx.1 = shl nuw nsw i32 %xor164.1, 4
  %gep687.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.1
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep687.1, align 16
  %q.sroa.12.16.gep687.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.1, i32 8
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep687.1.sroa_idx, align 8
  %add161.2 = add nuw nsw i32 %shr160, 8
  %xor164.2 = xor i32 %add161.2, %and163
  %.idx.2 = shl nuw nsw i32 %xor164.2, 4
  %gep687.2 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.2
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %gep687.2, align 16
  %q.sroa.18.32.gep687.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.2, i32 8
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep687.2.sroa_idx, align 8
  %add161.3 = add nuw nsw i32 %shr160, 12
  %xor164.3 = xor i32 %add161.3, %and163
  %.idx.3 = shl nuw nsw i32 %xor164.3, 4
  %gep687.3 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.3
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %gep687.3, align 16
  %q.sroa.24.48.gep687.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.3, i32 8
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep687.3.sroa_idx, align 8
  %cmp197.not = icmp sgt i32 %add190, %6
  %spec.select = select i1 %cmp197.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp197.not.1.not = icmp slt i32 %add190, %6
  %spec.select.1 = select i1 %cmp197.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add194.2 = or disjoint i32 %add190, 2
  %cmp197.not.2 = icmp sgt i32 %add194.2, %6
  %spec.select.2 = select i1 %cmp197.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add194.3 = or disjoint i32 %add190, 3
  %cmp197.not.3 = icmp sgt i32 %add194.3, %6
  %spec.select.3 = select i1 %cmp197.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add196.4 = add nuw nsw i32 %add190, 16
  %cmp197.not.4 = icmp sgt i32 %add196.4, %6
  %spec.select.4 = select i1 %cmp197.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add196.5 = add nuw nsw i32 %add190, 17
  %cmp197.not.5 = icmp sgt i32 %add196.5, %6
  %spec.select.5 = select i1 %cmp197.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1
  %add196.6 = add nuw nsw i32 %add190, 18
  %cmp197.not.6 = icmp sgt i32 %add196.6, %6
  %spec.select.6 = select i1 %cmp197.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2
  %add196.7 = add nuw nsw i32 %add190, 19
  %cmp197.not.7 = icmp sgt i32 %add196.7, %6
  %spec.select.7 = select i1 %cmp197.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !97
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !call_argsrelate !97
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %44), !call_argsrelate !97
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %45), !call_argsrelate !97
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %46), !call_argsrelate !97
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %47), !call_argsrelate !97
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %48), !call_argsrelate !97
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %49), !call_argsrelate !97
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %50), !call_argsrelate !97
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %51), !call_argsrelate !97
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %52), !call_argsrelate !97
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %53), !call_argsrelate !97
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %54), !call_argsrelate !97
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %55), !call_argsrelate !97
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %56), !call_argsrelate !97
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %57), !call_argsrelate !97
  %.idx724 = shl nuw nsw i64 %shr, 19
  %60 = getelementptr i8, ptr addrspace(4) %gep715, i64 %.idx724
  %61 = getelementptr %struct.__half, ptr addrspace(4) %60, i64 %mul102
  %v.sroa.48.112.gep696.7.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 7176
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep696.7.sroa_idx, align 8
  %gep696.7 = getelementptr i8, ptr addrspace(4) %61, i64 7168
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep696.7, align 16
  %v.sroa.42.96.gep696.6.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 6152
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep696.6.sroa_idx, align 8
  %gep696.6 = getelementptr i8, ptr addrspace(4) %61, i64 6144
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep696.6, align 16
  %v.sroa.36.80.gep696.5.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 5128
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep696.5.sroa_idx, align 8
  %gep696.5 = getelementptr i8, ptr addrspace(4) %61, i64 5120
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep696.5, align 16
  %v.sroa.30.64.gep696.4.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 4104
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep696.4.sroa_idx, align 8
  %gep696.4 = getelementptr i8, ptr addrspace(4) %61, i64 4096
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep696.4, align 16
  %v.sroa.24.48.gep696.3.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 3080
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep696.3.sroa_idx, align 8
  %gep696.3 = getelementptr i8, ptr addrspace(4) %61, i64 3072
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep696.3, align 16
  %v.sroa.18.32.gep696.2.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 2056
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep696.2.sroa_idx, align 8
  %gep696.2 = getelementptr i8, ptr addrspace(4) %61, i64 2048
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep696.2, align 16
  %v.sroa.12.16.gep696.1.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 1032
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep696.1.sroa_idx, align 8
  %gep696.1 = getelementptr i8, ptr addrspace(4) %61, i64 1024
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep696.1, align 16
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %61, i64 8
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %61, align 16
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %58, i64 0
  %mul282 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul282, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %62, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i667 = fadd contract float %62, %cond.i.i
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i667)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %63
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %58, i64 1
  %mul282.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %64, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.1 = fadd contract float %64, %cond.i.i.1
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i667.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %65
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %58, i64 2
  %mul282.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul282.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %66, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.2 = fadd contract float %66, %cond.i.i.2
  %67 = tail call contract float @llvm.exp2.f32(float %add.i.i667.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %67
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %58, i64 3
  %mul282.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul282.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %68, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.3 = fadd contract float %68, %cond.i.i.3
  %69 = tail call contract float @llvm.exp2.f32(float %add.i.i667.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %69
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %59, i64 0
  %mul282.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul282.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %70, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.4 = fadd contract float %70, %cond.i.i.4
  %71 = tail call contract float @llvm.exp2.f32(float %add.i.i667.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %71
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %59, i64 1
  %mul282.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul282.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %72, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.5 = fadd contract float %72, %cond.i.i.5
  %73 = tail call contract float @llvm.exp2.f32(float %add.i.i667.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %73
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %59, i64 2
  %mul282.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul282.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %74, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.6 = fadd contract float %74, %cond.i.i.6
  %75 = tail call contract float @llvm.exp2.f32(float %add.i.i667.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %75
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %59, i64 3
  %mul282.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul282.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %76, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.7 = fadd contract float %76, %cond.i.i.7
  %77 = tail call contract float @llvm.exp2.f32(float %add.i.i667.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %77
  %add302 = fadd contract float %mul.i.i, 0.000000e+00
  %add302.1 = fadd contract float %add302, %mul.i.i.4
  %add302.2 = fadd contract float %add302.1, %mul.i.i.1
  %add302.3 = fadd contract float %add302.2, %mul.i.i.5
  %add302.4 = fadd contract float %add302.3, %mul.i.i.2
  %add302.5 = fadd contract float %add302.4, %mul.i.i.6
  %add302.6 = fadd contract float %add302.5, %mul.i.i.3
  %add302.7 = fadd contract float %add302.6, %mul.i.i.7
  %78 = bitcast float %add302.7 to i32
  %79 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %80 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %79) #11
  %xor.i.i = xor i32 %80, 32
  %81 = and i32 %80, -64
  %and.i.i = add nsw i32 %81, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i668 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %80
  %shl.i.i = shl i32 %cond.i.i668, 2
  %82 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %78)
  %83 = bitcast i32 %82 to float
  %add.i = fadd contract float %add302.7, %83
  %84 = bitcast float %add.i to i32
  %85 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %86 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %85) #11
  %xor.i.i669 = xor i32 %86, 16
  %87 = and i32 %86, -64
  %and.i.i670 = add nsw i32 %87, 64
  %cmp.not.i.i671 = icmp slt i32 %xor.i.i669, %and.i.i670
  %cond.i.i672 = select i1 %cmp.not.i.i671, i32 %xor.i.i669, i32 %86
  %shl.i.i673 = shl i32 %cond.i.i672, 2
  %88 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i673, i32 %84)
  %89 = bitcast i32 %88 to float
  %add.i.i = fadd contract float %add.i, %89
  %cmp311 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp311, float %div, float 0.000000e+00
  %mul324 = fmul contract float %condval_8.0, %mul.i.i
  %mul324.1 = fmul contract float %condval_8.0, %mul.i.i.1
  %mul324.2 = fmul contract float %condval_8.0, %mul.i.i.2
  %mul324.3 = fmul contract float %condval_8.0, %mul.i.i.3
  %mul324.4 = fmul contract float %condval_8.0, %mul.i.i.4
  %mul324.5 = fmul contract float %condval_8.0, %mul.i.i.5
  %mul324.6 = fmul contract float %condval_8.0, %mul.i.i.6
  %mul324.7 = fmul contract float %condval_8.0, %mul.i.i.7
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324)
  %91 = insertelement <4 x i16> poison, i16 %90, i64 0
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.1)
  %93 = insertelement <4 x i16> %91, i16 %92, i64 1
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.2)
  %95 = insertelement <4 x i16> %93, i16 %94, i64 2
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.3)
  %97 = insertelement <4 x i16> %95, i16 %96, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %97 to <4 x half>
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.4)
  %99 = insertelement <4 x i16> poison, i16 %98, i64 0
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.5)
  %101 = insertelement <4 x i16> %99, i16 %100, i64 1
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.6)
  %103 = insertelement <4 x i16> %101, i16 %102, i64 2
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.7)
  %105 = insertelement <4 x i16> %103, i16 %104, i64 3
  %prob.sroa.12.14.vec.insert = bitcast <4 x i16> %105 to <4 x half>
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !97
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %106), !call_argsrelate !97
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %107), !call_argsrelate !97
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %108), !call_argsrelate !97
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %109), !call_argsrelate !97
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %110), !call_argsrelate !97
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %111), !call_argsrelate !97
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %112), !call_argsrelate !97
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %113), !call_argsrelate !97
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %114, i64 0
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %122 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %114, i64 1
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %123 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %114, i64 2
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %124 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert1040 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %114, i64 3
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %125 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1040, %output_reg.sroa.0.6.insert.shift
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %115, i64 0
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract)
  %output_reg.sroa.16.8.insert.ext = zext i16 %126 to i64
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %115, i64 1
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract)
  %output_reg.sroa.16.10.insert.ext = zext i16 %127 to i64
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %115, i64 2
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract)
  %output_reg.sroa.16.12.insert.ext = zext i16 %128 to i64
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32
  %output_reg.sroa.16.12.insert.insert1072 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %115, i64 3
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract)
  %output_reg.sroa.16.14.insert.ext = zext i16 %129 to i64
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1072, %output_reg.sroa.16.14.insert.shift
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %116, i64 0
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract)
  %output_reg.sroa.30.16.insert.ext = zext i16 %130 to i64
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %116, i64 1
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract)
  %output_reg.sroa.30.18.insert.ext = zext i16 %131 to i64
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %116, i64 2
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract)
  %output_reg.sroa.30.20.insert.ext = zext i16 %132 to i64
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32
  %output_reg.sroa.30.20.insert.insert1104 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %116, i64 3
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract)
  %output_reg.sroa.30.22.insert.ext = zext i16 %133 to i64
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1104, %output_reg.sroa.30.22.insert.shift
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %117, i64 0
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract)
  %output_reg.sroa.44.24.insert.ext = zext i16 %134 to i64
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %117, i64 1
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract)
  %output_reg.sroa.44.26.insert.ext = zext i16 %135 to i64
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %117, i64 2
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract)
  %output_reg.sroa.44.28.insert.ext = zext i16 %136 to i64
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32
  %output_reg.sroa.44.28.insert.insert1136 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %117, i64 3
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract)
  %output_reg.sroa.44.30.insert.ext = zext i16 %137 to i64
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1136, %output_reg.sroa.44.30.insert.shift
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %118, i64 0
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract)
  %output_reg.sroa.58.32.insert.ext = zext i16 %138 to i64
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %118, i64 1
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract)
  %output_reg.sroa.58.34.insert.ext = zext i16 %139 to i64
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %118, i64 2
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract)
  %output_reg.sroa.58.36.insert.ext = zext i16 %140 to i64
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32
  %output_reg.sroa.58.36.insert.insert1168 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %118, i64 3
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract)
  %output_reg.sroa.58.38.insert.ext = zext i16 %141 to i64
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1168, %output_reg.sroa.58.38.insert.shift
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %119, i64 0
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract)
  %output_reg.sroa.72.40.insert.ext = zext i16 %142 to i64
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %119, i64 1
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract)
  %output_reg.sroa.72.42.insert.ext = zext i16 %143 to i64
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %119, i64 2
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract)
  %output_reg.sroa.72.44.insert.ext = zext i16 %144 to i64
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32
  %output_reg.sroa.72.44.insert.insert1200 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %119, i64 3
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract)
  %output_reg.sroa.72.46.insert.ext = zext i16 %145 to i64
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1200, %output_reg.sroa.72.46.insert.shift
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %120, i64 0
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract)
  %output_reg.sroa.86.48.insert.ext = zext i16 %146 to i64
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %120, i64 1
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract)
  %output_reg.sroa.86.50.insert.ext = zext i16 %147 to i64
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %120, i64 2
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract)
  %output_reg.sroa.86.52.insert.ext = zext i16 %148 to i64
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32
  %output_reg.sroa.86.52.insert.insert1232 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %120, i64 3
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract)
  %output_reg.sroa.86.54.insert.ext = zext i16 %149 to i64
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1232, %output_reg.sroa.86.54.insert.shift
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %121, i64 0
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract)
  %output_reg.sroa.100.56.insert.ext = zext i16 %150 to i64
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %121, i64 1
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract)
  %output_reg.sroa.100.58.insert.ext = zext i16 %151 to i64
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %121, i64 2
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract)
  %output_reg.sroa.100.60.insert.ext = zext i16 %152 to i64
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32
  %output_reg.sroa.100.60.insert.insert1264 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %121, i64 3
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract)
  %output_reg.sroa.100.62.insert.ext = zext i16 %153 to i64
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1264, %output_reg.sroa.100.62.insert.shift
  br label %if.end441

if.end441:                                        ; preds = %for.body421.preheader, %for.body96.preheader
  %add456.7.pre-phi = phi i32 [ %.pre1694, %for.body421.preheader ], [ %add138.7, %for.body96.preheader ]
  %add456.6.pre-phi = phi i32 [ %.pre1693, %for.body421.preheader ], [ %add138.6, %for.body96.preheader ]
  %add456.5.pre-phi = phi i32 [ %.pre1692, %for.body421.preheader ], [ %add138.5, %for.body96.preheader ]
  %add456.4.pre-phi = phi i32 [ %.pre1691, %for.body421.preheader ], [ %add138.4, %for.body96.preheader ]
  %add456.3.pre-phi = phi i32 [ %.pre1690, %for.body421.preheader ], [ %add138.3, %for.body96.preheader ]
  %add456.2.pre-phi = phi i32 [ %.pre1689, %for.body421.preheader ], [ %add138.2, %for.body96.preheader ]
  %add456.1.pre-phi = phi i32 [ %.pre, %for.body421.preheader ], [ %add138.1, %for.body96.preheader ]
  %k.sroa.48.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.48.112.copyload, %for.body96.preheader ]
  %k.sroa.44.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.44.112.copyload, %for.body96.preheader ]
  %k.sroa.42.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.42.96.copyload, %for.body96.preheader ]
  %k.sroa.38.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.38.96.copyload, %for.body96.preheader ]
  %k.sroa.36.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.36.80.copyload, %for.body96.preheader ]
  %k.sroa.32.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.32.80.copyload, %for.body96.preheader ]
  %k.sroa.30.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.30.64.copyload, %for.body96.preheader ]
  %k.sroa.26.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.26.64.copyload, %for.body96.preheader ]
  %k.sroa.24.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.24.48.copyload, %for.body96.preheader ]
  %k.sroa.20.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.20.48.copyload, %for.body96.preheader ]
  %k.sroa.18.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.18.32.copyload, %for.body96.preheader ]
  %k.sroa.14.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.14.32.copyload, %for.body96.preheader ]
  %k.sroa.12.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.12.16.copyload, %for.body96.preheader ]
  %k.sroa.8.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.8.16.copyload, %for.body96.preheader ]
  %k.sroa.6.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.6.0.copyload, %for.body96.preheader ]
  %k.sroa.0.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.0.0.copyload, %for.body96.preheader ]
  %v.sroa.48.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.48.112.copyload, %for.body96.preheader ]
  %v.sroa.44.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.44.112.copyload, %for.body96.preheader ]
  %v.sroa.42.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.42.96.copyload, %for.body96.preheader ]
  %v.sroa.38.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.38.96.copyload, %for.body96.preheader ]
  %v.sroa.36.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.36.80.copyload, %for.body96.preheader ]
  %v.sroa.32.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.32.80.copyload, %for.body96.preheader ]
  %v.sroa.30.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.30.64.copyload, %for.body96.preheader ]
  %v.sroa.26.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.26.64.copyload, %for.body96.preheader ]
  %v.sroa.24.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.24.48.copyload, %for.body96.preheader ]
  %v.sroa.20.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.20.48.copyload, %for.body96.preheader ]
  %v.sroa.18.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.18.32.copyload, %for.body96.preheader ]
  %v.sroa.14.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.14.32.copyload, %for.body96.preheader ]
  %v.sroa.12.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.12.16.copyload, %for.body96.preheader ]
  %v.sroa.8.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.8.16.copyload, %for.body96.preheader ]
  %v.sroa.6.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.6.0.copyload, %for.body96.preheader ]
  %v.sroa.0.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.0.0.copyload, %for.body96.preheader ]
  %output_reg.sroa.100.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.100.62.insert.insert, %for.body96.preheader ]
  %output_reg.sroa.86.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.86.54.insert.insert, %for.body96.preheader ]
  %output_reg.sroa.72.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.72.46.insert.insert, %for.body96.preheader ]
  %output_reg.sroa.58.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.58.38.insert.insert, %for.body96.preheader ]
  %output_reg.sroa.44.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.44.30.insert.insert, %for.body96.preheader ]
  %output_reg.sroa.30.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.30.22.insert.insert, %for.body96.preheader ]
  %output_reg.sroa.16.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.16.14.insert.insert, %for.body96.preheader ]
  %output_reg.sroa.0.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.0.6.insert.insert, %for.body96.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor459 = xor i32 %shr137, %and163
  %mul460 = shl nuw nsw i32 %xor459, 3
  %add461 = add nuw nsw i32 %mul460, %mul157
  %add466 = or disjoint i32 %add461, %mul465
  %add.ptr468 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr468, align 8
  %xor459.1 = xor i32 %add456.1.pre-phi, %and163
  %mul460.1 = shl nuw nsw i32 %xor459.1, 3
  %add461.1 = add nuw nsw i32 %mul460.1, %mul157
  %add466.1 = or disjoint i32 %add461.1, %mul465
  %add.ptr468.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr468.1, align 8
  %xor459.2 = xor i32 %add456.2.pre-phi, %and163
  %mul460.2 = shl nuw nsw i32 %xor459.2, 3
  %add461.2 = add nuw nsw i32 %mul460.2, %mul157
  %add466.2 = or disjoint i32 %add461.2, %mul465
  %add.ptr468.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.2
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr468.2, align 8
  %xor459.3 = xor i32 %add456.3.pre-phi, %and163
  %mul460.3 = shl nuw nsw i32 %xor459.3, 3
  %add461.3 = add nuw nsw i32 %mul460.3, %mul157
  %add466.3 = or disjoint i32 %add461.3, %mul465
  %add.ptr468.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.3
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr468.3, align 8
  %xor459.4 = xor i32 %add456.4.pre-phi, %and163
  %mul460.4 = shl nuw nsw i32 %xor459.4, 3
  %add461.4 = add nuw nsw i32 %mul460.4, %mul157
  %add466.4 = or disjoint i32 %add461.4, %mul465
  %add.ptr468.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.4
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr468.4, align 8
  %xor459.5 = xor i32 %add456.5.pre-phi, %and163
  %mul460.5 = shl nuw nsw i32 %xor459.5, 3
  %add461.5 = add nuw nsw i32 %mul460.5, %mul157
  %add466.5 = or disjoint i32 %add461.5, %mul465
  %add.ptr468.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.5
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr468.5, align 8
  %xor459.6 = xor i32 %add456.6.pre-phi, %and163
  %mul460.6 = shl nuw nsw i32 %xor459.6, 3
  %add461.6 = add nuw nsw i32 %mul460.6, %mul157
  %add466.6 = or disjoint i32 %add461.6, %mul465
  %add.ptr468.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.6
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr468.6, align 8
  %xor459.7 = xor i32 %add456.7.pre-phi, %and163
  %mul460.7 = shl nuw nsw i32 %xor459.7, 3
  %add461.7 = add nuw nsw i32 %mul460.7, %mul157
  %add466.7 = or disjoint i32 %add461.7, %mul465
  %add.ptr468.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.7
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr468.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br i1 %cmp42, label %if.end485, label %if.end518.3

if.end485:                                        ; preds = %if.end441
  %mul509 = shl nuw nsw i32 %6, 11
  %add512 = add nuw nsw i32 %add510, %mul509
  %154 = zext nneg i32 %add512 to i64
  %xor501 = xor i32 %shr160, %and163
  %add.ptr505.idx = shl nuw nsw i32 %xor501, 4
  %add.ptr505 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 %add.ptr505.idx
  %add.ptr517 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  %155 = add nuw nsw i32 %shr160, 4
  %xor501.1 = xor i32 %155, %and163
  %gep712.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 1024
  %add.ptr505.idx.1 = shl nuw nsw i32 %xor501.1, 4
  %add.ptr505.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.1, i32 %add.ptr505.idx.1
  %156 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154
  %add.ptr517.1 = getelementptr inbounds i8, ptr addrspace(1) %156, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.1, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  %157 = add nuw nsw i32 %shr160, 8
  %xor501.2 = xor i32 %157, %and163
  %gep712.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 2048
  %add.ptr505.idx.2 = shl nuw nsw i32 %xor501.2, 4
  %add.ptr505.2 = getelementptr inbounds i8, ptr addrspace(3) %gep712.2, i32 %add.ptr505.idx.2
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154
  %add.ptr517.2 = getelementptr inbounds i8, ptr addrspace(1) %158, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.2, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  %159 = add nuw nsw i32 %shr160, 12
  %xor501.3 = xor i32 %159, %and163
  %gep712.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 3072
  %add.ptr505.idx.3 = shl nuw nsw i32 %xor501.3, 4
  %add.ptr505.3 = getelementptr inbounds i8, ptr addrspace(3) %gep712.3, i32 %add.ptr505.idx.3
  %160 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154
  %add.ptr517.3 = getelementptr inbounds i8, ptr addrspace(1) %160, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.3, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  br label %if.end518.3

if.end518.3:                                      ; preds = %if.end441, %if.end485
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end522

if.end522:                                        ; preds = %if.end518.3, %if.then
  %k.sroa.48.2 = phi <4 x half> [ %k.sroa.48.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.44.2 = phi <4 x half> [ %k.sroa.44.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.42.2 = phi <4 x half> [ %k.sroa.42.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.38.2 = phi <4 x half> [ %k.sroa.38.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.36.2 = phi <4 x half> [ %k.sroa.36.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.32.2 = phi <4 x half> [ %k.sroa.32.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.30.2 = phi <4 x half> [ %k.sroa.30.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.26.2 = phi <4 x half> [ %k.sroa.26.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.24.2 = phi <4 x half> [ %k.sroa.24.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.20.2 = phi <4 x half> [ %k.sroa.20.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.18.2 = phi <4 x half> [ %k.sroa.18.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.14.2 = phi <4 x half> [ %k.sroa.14.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.12.2 = phi <4 x half> [ %k.sroa.12.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.8.2 = phi <4 x half> [ %k.sroa.8.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.6.2 = phi <4 x half> [ %k.sroa.6.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.0.2 = phi <4 x half> [ %k.sroa.0.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.48.2 = phi <4 x half> [ %v.sroa.48.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.44.2 = phi <4 x half> [ %v.sroa.44.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.42.2 = phi <4 x half> [ %v.sroa.42.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.38.2 = phi <4 x half> [ %v.sroa.38.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.36.2 = phi <4 x half> [ %v.sroa.36.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.32.2 = phi <4 x half> [ %v.sroa.32.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.30.2 = phi <4 x half> [ %v.sroa.30.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.26.2 = phi <4 x half> [ %v.sroa.26.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.24.2 = phi <4 x half> [ %v.sroa.24.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.20.2 = phi <4 x half> [ %v.sroa.20.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.18.2 = phi <4 x half> [ %v.sroa.18.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.14.2 = phi <4 x half> [ %v.sroa.14.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.12.2 = phi <4 x half> [ %v.sroa.12.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.8.2 = phi <4 x half> [ %v.sroa.8.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.6.2 = phi <4 x half> [ %v.sroa.6.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.0.2 = phi <4 x half> [ %v.sroa.0.1, %if.end518.3 ], [ undef, %if.then ]
  %cmp32.1 = icmp sgt i32 %7, -1
  br i1 %cmp32.1, label %for.cond34.preheader.1, label %if.end526

for.cond34.preheader.1:                           ; preds = %if.end522
  %cmp42.1 = icmp ult i32 %7, 1024
  %condval_4.0.1 = zext nneg i32 %7 to i64
  br i1 %cmp42.1, label %if.then43.1760, label %if.end79.1764

if.then43.1760:                                   ; preds = %for.cond34.preheader.1
  %.idx718.1755 = shl nuw nsw i64 %condval_4.0.1, 12
  %161 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.1755
  %.idx719.1756 = shl nuw nsw i64 %shr, 22
  %162 = getelementptr i8, ptr addrspace(4) %161, i64 %.idx719.1756
  %condval_1.sroa.0.0.copyload.1757 = load i32, ptr addrspace(4) %162, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1758 = getelementptr inbounds i8, ptr addrspace(4) %162, i64 4
  %condval_1.sroa.5.0.copyload.1759 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1758, align 4, !tbaa !30
  %163 = zext i32 %condval_1.sroa.0.0.copyload.1757 to i64
  %164 = zext i32 %condval_1.sroa.5.0.copyload.1759 to i64
  %165 = shl nuw i64 %164, 32
  %166 = or disjoint i64 %165, %163
  br label %if.end79.1764

if.end79.1764:                                    ; preds = %if.then43.1760, %for.cond34.preheader.1
  %q_stage.sroa.0.4.insert.insert1618 = phi i64 [ %166, %if.then43.1760 ], [ 0, %for.cond34.preheader.1 ]
  br i1 %cmp42.1, label %if.then43.1.1, label %if.end79.1.1

if.then43.1.1:                                    ; preds = %if.end79.1764
  %.idx718.1.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %167 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.1.1
  %.idx719.1.1 = shl nuw nsw i64 %shr, 22
  %168 = getelementptr i8, ptr addrspace(4) %167, i64 %.idx719.1.1
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %168, i64 512
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr i8, ptr addrspace(4) %168, i64 516
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !tbaa !30
  %169 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64
  %170 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64
  %171 = shl nuw i64 %170, 32
  %172 = or disjoint i64 %171, %169
  br label %if.end79.1.1

if.end79.1.1:                                     ; preds = %if.then43.1.1, %if.end79.1764
  %q_stage.sroa.8.12.insert.insert1628 = phi i64 [ %172, %if.then43.1.1 ], [ 0, %if.end79.1764 ]
  br i1 %cmp42.1, label %if.then43.2.1, label %if.end79.2.1

if.then43.2.1:                                    ; preds = %if.end79.1.1
  %.idx718.2.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %173 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.2.1
  %.idx719.2.1 = shl nuw nsw i64 %shr, 22
  %174 = getelementptr i8, ptr addrspace(4) %173, i64 %.idx719.2.1
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %174, i64 1024
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr i8, ptr addrspace(4) %174, i64 1028
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !tbaa !30
  %175 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64
  %176 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64
  %177 = shl nuw i64 %176, 32
  %178 = or disjoint i64 %177, %175
  br label %if.end79.2.1

if.end79.2.1:                                     ; preds = %if.then43.2.1, %if.end79.1.1
  %q_stage.sroa.14.20.insert.insert1638 = phi i64 [ %178, %if.then43.2.1 ], [ 0, %if.end79.1.1 ]
  br i1 %cmp42.1, label %if.then43.3.1, label %if.end79.3.1

if.then43.3.1:                                    ; preds = %if.end79.2.1
  %.idx718.3.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %179 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.3.1
  %.idx719.3.1 = shl nuw nsw i64 %shr, 22
  %180 = getelementptr i8, ptr addrspace(4) %179, i64 %.idx719.3.1
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %180, i64 1536
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr i8, ptr addrspace(4) %180, i64 1540
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !tbaa !30
  %181 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64
  %182 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64
  %183 = shl nuw i64 %182, 32
  %184 = or disjoint i64 %183, %181
  br label %if.end79.3.1

if.end79.3.1:                                     ; preds = %if.then43.3.1, %if.end79.2.1
  %q_stage.sroa.20.28.insert.insert1648 = phi i64 [ %184, %if.then43.3.1 ], [ 0, %if.end79.2.1 ]
  br i1 %cmp42.1, label %if.then43.4.1, label %if.end79.4.1

if.then43.4.1:                                    ; preds = %if.end79.3.1
  %.idx718.4.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %185 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.4.1
  %.idx719.4.1 = shl nuw nsw i64 %shr, 22
  %186 = getelementptr i8, ptr addrspace(4) %185, i64 %.idx719.4.1
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %186, i64 2048
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr i8, ptr addrspace(4) %186, i64 2052
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !tbaa !30
  %187 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64
  %188 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64
  %189 = shl nuw i64 %188, 32
  %190 = or disjoint i64 %189, %187
  br label %if.end79.4.1

if.end79.4.1:                                     ; preds = %if.then43.4.1, %if.end79.3.1
  %q_stage.sroa.26.36.insert.insert1658 = phi i64 [ %190, %if.then43.4.1 ], [ 0, %if.end79.3.1 ]
  br i1 %cmp42.1, label %if.then43.5.1, label %if.end79.5.1

if.then43.5.1:                                    ; preds = %if.end79.4.1
  %.idx718.5.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %191 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.5.1
  %.idx719.5.1 = shl nuw nsw i64 %shr, 22
  %192 = getelementptr i8, ptr addrspace(4) %191, i64 %.idx719.5.1
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %192, i64 2560
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr i8, ptr addrspace(4) %192, i64 2564
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !tbaa !30
  %193 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64
  %194 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64
  %195 = shl nuw i64 %194, 32
  %196 = or disjoint i64 %195, %193
  br label %if.end79.5.1

if.end79.5.1:                                     ; preds = %if.then43.5.1, %if.end79.4.1
  %q_stage.sroa.32.44.insert.insert1668 = phi i64 [ %196, %if.then43.5.1 ], [ 0, %if.end79.4.1 ]
  br i1 %cmp42.1, label %if.then43.6.1, label %if.end79.6.1

if.then43.6.1:                                    ; preds = %if.end79.5.1
  %.idx718.6.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %197 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.6.1
  %.idx719.6.1 = shl nuw nsw i64 %shr, 22
  %198 = getelementptr i8, ptr addrspace(4) %197, i64 %.idx719.6.1
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %198, i64 3072
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr i8, ptr addrspace(4) %198, i64 3076
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !tbaa !30
  %199 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64
  %200 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64
  %201 = shl nuw i64 %200, 32
  %202 = or disjoint i64 %201, %199
  br label %if.end79.6.1

if.end79.6.1:                                     ; preds = %if.then43.6.1, %if.end79.5.1
  %q_stage.sroa.38.52.insert.insert1678 = phi i64 [ %202, %if.then43.6.1 ], [ 0, %if.end79.5.1 ]
  br i1 %cmp42.1, label %if.then43.7.1, label %if.end79.7.1

if.then43.7.1:                                    ; preds = %if.end79.6.1
  %.idx718.7.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %203 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.7.1
  %.idx719.7.1 = shl nuw nsw i64 %shr, 22
  %204 = getelementptr i8, ptr addrspace(4) %203, i64 %.idx719.7.1
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %204, i64 3584
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr i8, ptr addrspace(4) %204, i64 3588
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !tbaa !30
  %205 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64
  %206 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64
  %207 = shl nuw i64 %206, 32
  %208 = or disjoint i64 %207, %205
  br label %if.end79.7.1

if.end79.7.1:                                     ; preds = %if.then43.7.1, %if.end79.6.1
  %q_stage.sroa.44.60.insert.insert1688 = phi i64 [ %208, %if.then43.7.1 ], [ 0, %if.end79.6.1 ]
  %cmp89.1 = icmp sle i32 %mul88, %7
  %or.cond717.1 = select i1 %cmp87, i1 %cmp89.1, i1 false
  br i1 %or.cond717.1, label %if.end119.1, label %for.body421.preheader.1

for.body421.preheader.1:                          ; preds = %if.end79.7.1
  %.pre1695 = add nuw nsw i32 %shr137, 2
  %.pre1696 = add nuw nsw i32 %shr137, 4
  %.pre1697 = add nuw nsw i32 %shr137, 6
  %.pre1698 = add nuw nsw i32 %shr137, 8
  %.pre1699 = add nuw nsw i32 %shr137, 10
  %.pre1700 = add nuw nsw i32 %shr137, 12
  %.pre1701 = add nuw nsw i32 %shr137, 14
  br label %if.end441.1

if.end119.1:                                      ; preds = %if.end79.7.1
  %xor.1767 = xor i32 %shr137, %shr134
  %209 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132
  %gep684.idx.1768 = shl nuw nsw i32 %xor.1767, 4
  %gep684.1769 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 %gep684.idx.1768
  store i64 %q_stage.sroa.0.4.insert.insert1618, ptr addrspace(3) %gep684.1769, align 8
  %add138.1.1 = add nuw nsw i32 %shr137, 2
  %xor.1.1 = xor i32 %add138.1.1, %shr134
  %210 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 512
  %gep684.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4
  %gep684.1.1 = getelementptr inbounds i8, ptr addrspace(3) %210, i32 %gep684.idx.1.1
  store i64 %q_stage.sroa.8.12.insert.insert1628, ptr addrspace(3) %gep684.1.1, align 8
  %add138.2.1 = add nuw nsw i32 %shr137, 4
  %xor.2.1 = xor i32 %add138.2.1, %shr134
  %211 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 1024
  %gep684.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4
  %gep684.2.1 = getelementptr inbounds i8, ptr addrspace(3) %211, i32 %gep684.idx.2.1
  store i64 %q_stage.sroa.14.20.insert.insert1638, ptr addrspace(3) %gep684.2.1, align 8
  %add138.3.1 = add nuw nsw i32 %shr137, 6
  %xor.3.1 = xor i32 %add138.3.1, %shr134
  %212 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 1536
  %gep684.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4
  %gep684.3.1 = getelementptr inbounds i8, ptr addrspace(3) %212, i32 %gep684.idx.3.1
  store i64 %q_stage.sroa.20.28.insert.insert1648, ptr addrspace(3) %gep684.3.1, align 8
  %add138.4.1 = add nuw nsw i32 %shr137, 8
  %xor.4.1 = xor i32 %add138.4.1, %shr134
  %213 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 2048
  %gep684.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4
  %gep684.4.1 = getelementptr inbounds i8, ptr addrspace(3) %213, i32 %gep684.idx.4.1
  store i64 %q_stage.sroa.26.36.insert.insert1658, ptr addrspace(3) %gep684.4.1, align 8
  %add138.5.1 = add nuw nsw i32 %shr137, 10
  %xor.5.1 = xor i32 %add138.5.1, %shr134
  %214 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 2560
  %gep684.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4
  %gep684.5.1 = getelementptr inbounds i8, ptr addrspace(3) %214, i32 %gep684.idx.5.1
  store i64 %q_stage.sroa.32.44.insert.insert1668, ptr addrspace(3) %gep684.5.1, align 8
  %add138.6.1 = add nuw nsw i32 %shr137, 12
  %xor.6.1 = xor i32 %add138.6.1, %shr134
  %215 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 3072
  %gep684.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4
  %gep684.6.1 = getelementptr inbounds i8, ptr addrspace(3) %215, i32 %gep684.idx.6.1
  store i64 %q_stage.sroa.38.52.insert.insert1678, ptr addrspace(3) %gep684.6.1, align 8
  %add138.7.1 = add nuw nsw i32 %shr137, 14
  %xor.7.1 = xor i32 %add138.7.1, %shr134
  %216 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 3584
  %gep684.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4
  %gep684.7.1 = getelementptr inbounds i8, ptr addrspace(3) %216, i32 %gep684.idx.7.1
  store i64 %q_stage.sroa.44.60.insert.insert1688, ptr addrspace(3) %gep684.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor164.1770 = xor i32 %shr160, %and163
  %.idx.1771 = shl nuw nsw i32 %xor164.1770, 4
  %gep687.1772 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.1771
  %q.sroa.0.0.copyload1561 = load <4 x half>, ptr addrspace(3) %gep687.1772, align 16
  %q.sroa.6.0.gep687.1772.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.1772, i32 8
  %q.sroa.6.0.copyload1562 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep687.1772.sroa_idx, align 8
  %add161.1.1 = add nuw nsw i32 %shr160, 4
  %xor164.1.1 = xor i32 %add161.1.1, %and163
  %.idx.1.1 = shl nuw nsw i32 %xor164.1.1, 4
  %gep687.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.1.1
  %q.sroa.8.16.copyload1565 = load <4 x half>, ptr addrspace(3) %gep687.1.1, align 16
  %q.sroa.12.16.gep687.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.1.1, i32 8
  %q.sroa.12.16.copyload1566 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep687.1.1.sroa_idx, align 8
  %add161.2.1 = add nuw nsw i32 %shr160, 8
  %xor164.2.1 = xor i32 %add161.2.1, %and163
  %.idx.2.1 = shl nuw nsw i32 %xor164.2.1, 4
  %gep687.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.2.1
  %q.sroa.14.32.copyload1569 = load <4 x half>, ptr addrspace(3) %gep687.2.1, align 16
  %q.sroa.18.32.gep687.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.2.1, i32 8
  %q.sroa.18.32.copyload1570 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep687.2.1.sroa_idx, align 8
  %add161.3.1 = add nuw nsw i32 %shr160, 12
  %xor164.3.1 = xor i32 %add161.3.1, %and163
  %.idx.3.1 = shl nuw nsw i32 %xor164.3.1, 4
  %gep687.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.3.1
  %q.sroa.20.48.copyload1573 = load <4 x half>, ptr addrspace(3) %gep687.3.1, align 16
  %q.sroa.24.48.gep687.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.3.1, i32 8
  %q.sroa.24.48.copyload1574 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep687.3.1.sroa_idx, align 8
  %cmp197.not.1773 = icmp sgt i32 %add190, %7
  %spec.select.1774 = select i1 %cmp197.not.1773, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1356 = insertelement <4 x float> poison, float %spec.select.1774, i64 0
  %cmp197.not.1.1.not = icmp slt i32 %add190, %7
  %spec.select.1.1 = select i1 %cmp197.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1381 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1356, float %spec.select.1.1, i64 1
  %add194.2.1 = or disjoint i32 %add190, 2
  %cmp197.not.2.1 = icmp sgt i32 %add194.2.1, %7
  %spec.select.2.1 = select i1 %cmp197.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1406 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1381, float %spec.select.2.1, i64 2
  %add194.3.1 = or disjoint i32 %add190, 3
  %cmp197.not.3.1 = icmp sgt i32 %add194.3.1, %7
  %spec.select.3.1 = select i1 %cmp197.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1431 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1406, float %spec.select.3.1, i64 3
  %add196.4.1 = add nuw nsw i32 %add190, 16
  %cmp197.not.4.1 = icmp sgt i32 %add196.4.1, %7
  %spec.select.4.1 = select i1 %cmp197.not.4.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.16.vec.insert1472 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0
  %add196.5.1 = add nuw nsw i32 %add190, 17
  %cmp197.not.5.1 = icmp sgt i32 %add196.5.1, %7
  %spec.select.5.1 = select i1 %cmp197.not.5.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.20.vec.insert1497 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1472, float %spec.select.5.1, i64 1
  %add196.6.1 = add nuw nsw i32 %add190, 18
  %cmp197.not.6.1 = icmp sgt i32 %add196.6.1, %7
  %spec.select.6.1 = select i1 %cmp197.not.6.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.24.vec.insert1522 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1497, float %spec.select.6.1, i64 2
  %add196.7.1 = add nuw nsw i32 %add190, 19
  %cmp197.not.7.1 = icmp sgt i32 %add196.7.1, %7
  %spec.select.7.1 = select i1 %cmp197.not.7.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.28.vec.insert1547 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1522, float %spec.select.7.1, i64 3
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.2, <4 x half> %q.sroa.0.0.copyload1561, <4 x float> %scores.sroa.0.12.vec.insert1431)
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.2, <4 x half> %q.sroa.0.0.copyload1561, <4 x float> %scores.sroa.90.28.vec.insert1547)
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.2, <4 x half> %q.sroa.6.0.copyload1562, <4 x float> %217)
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.2, <4 x half> %q.sroa.6.0.copyload1562, <4 x float> %218)
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.2, <4 x half> %q.sroa.8.16.copyload1565, <4 x float> %219)
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.2, <4 x half> %q.sroa.8.16.copyload1565, <4 x float> %220)
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.2, <4 x half> %q.sroa.12.16.copyload1566, <4 x float> %221)
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.2, <4 x half> %q.sroa.12.16.copyload1566, <4 x float> %222)
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.2, <4 x half> %q.sroa.14.32.copyload1569, <4 x float> %223)
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.2, <4 x half> %q.sroa.14.32.copyload1569, <4 x float> %224)
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.2, <4 x half> %q.sroa.18.32.copyload1570, <4 x float> %225)
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.2, <4 x half> %q.sroa.18.32.copyload1570, <4 x float> %226)
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.2, <4 x half> %q.sroa.20.48.copyload1573, <4 x float> %227)
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.2, <4 x half> %q.sroa.20.48.copyload1573, <4 x float> %228)
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.2, <4 x half> %q.sroa.24.48.copyload1574, <4 x float> %229)
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.2, <4 x half> %q.sroa.24.48.copyload1574, <4 x float> %230)
  %scores.sroa.0.0.vec.extract1358 = extractelement <4 x float> %231, i64 0
  %mul282.1783 = fmul contract float %scores.sroa.0.0.vec.extract1358, 0x3FC2776C60000000
  %233 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1783, float 1.500000e+01)
  %cmp.i.i.1784 = fcmp contract olt float %233, -1.260000e+02
  %cond.i.i.1785 = select contract i1 %cmp.i.i.1784, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.1786 = fadd contract float %233, %cond.i.i.1785
  %234 = tail call contract float @llvm.exp2.f32(float %add.i.i667.1786)
  %cond2.i.i.1787 = select contract i1 %cmp.i.i.1784, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1788 = fmul contract float %cond2.i.i.1787, %234
  %scores.sroa.0.4.vec.extract1383 = extractelement <4 x float> %231, i64 1
  %mul282.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1383, 0x3FC2776C60000000
  %235 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1.1, float 1.500000e+01)
  %cmp.i.i.1.1 = fcmp contract olt float %235, -1.260000e+02
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.1.1 = fadd contract float %235, %cond.i.i.1.1
  %236 = tail call contract float @llvm.exp2.f32(float %add.i.i667.1.1)
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %236
  %scores.sroa.0.8.vec.extract1408 = extractelement <4 x float> %231, i64 2
  %mul282.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1408, 0x3FC2776C60000000
  %237 = tail call contract noundef float @llvm.minnum.f32(float %mul282.2.1, float 1.500000e+01)
  %cmp.i.i.2.1 = fcmp contract olt float %237, -1.260000e+02
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.2.1 = fadd contract float %237, %cond.i.i.2.1
  %238 = tail call contract float @llvm.exp2.f32(float %add.i.i667.2.1)
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %238
  %scores.sroa.0.12.vec.extract1433 = extractelement <4 x float> %231, i64 3
  %mul282.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1433, 0x3FC2776C60000000
  %239 = tail call contract noundef float @llvm.minnum.f32(float %mul282.3.1, float 1.500000e+01)
  %cmp.i.i.3.1 = fcmp contract olt float %239, -1.260000e+02
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.3.1 = fadd contract float %239, %cond.i.i.3.1
  %240 = tail call contract float @llvm.exp2.f32(float %add.i.i667.3.1)
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %240
  %scores.sroa.90.16.vec.extract1474 = extractelement <4 x float> %232, i64 0
  %mul282.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1474, 0x3FC2776C60000000
  %241 = tail call contract noundef float @llvm.minnum.f32(float %mul282.4.1, float 1.500000e+01)
  %cmp.i.i.4.1 = fcmp contract olt float %241, -1.260000e+02
  %cond.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.4.1 = fadd contract float %241, %cond.i.i.4.1
  %242 = tail call contract float @llvm.exp2.f32(float %add.i.i667.4.1)
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %242
  %scores.sroa.90.20.vec.extract1499 = extractelement <4 x float> %232, i64 1
  %mul282.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1499, 0x3FC2776C60000000
  %243 = tail call contract noundef float @llvm.minnum.f32(float %mul282.5.1, float 1.500000e+01)
  %cmp.i.i.5.1 = fcmp contract olt float %243, -1.260000e+02
  %cond.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.5.1 = fadd contract float %243, %cond.i.i.5.1
  %244 = tail call contract float @llvm.exp2.f32(float %add.i.i667.5.1)
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %244
  %scores.sroa.90.24.vec.extract1524 = extractelement <4 x float> %232, i64 2
  %mul282.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1524, 0x3FC2776C60000000
  %245 = tail call contract noundef float @llvm.minnum.f32(float %mul282.6.1, float 1.500000e+01)
  %cmp.i.i.6.1 = fcmp contract olt float %245, -1.260000e+02
  %cond.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.6.1 = fadd contract float %245, %cond.i.i.6.1
  %246 = tail call contract float @llvm.exp2.f32(float %add.i.i667.6.1)
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %246
  %scores.sroa.90.28.vec.extract1549 = extractelement <4 x float> %232, i64 3
  %mul282.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1549, 0x3FC2776C60000000
  %247 = tail call contract noundef float @llvm.minnum.f32(float %mul282.7.1, float 1.500000e+01)
  %cmp.i.i.7.1 = fcmp contract olt float %247, -1.260000e+02
  %cond.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i667.7.1 = fadd contract float %247, %cond.i.i.7.1
  %248 = tail call contract float @llvm.exp2.f32(float %add.i.i667.7.1)
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %248
  %add302.1789 = fadd contract float %mul.i.i.1788, 0.000000e+00
  %add302.1.1 = fadd contract float %add302.1789, %mul.i.i.4.1
  %add302.2.1 = fadd contract float %add302.1.1, %mul.i.i.1.1
  %add302.3.1 = fadd contract float %add302.2.1, %mul.i.i.5.1
  %add302.4.1 = fadd contract float %add302.3.1, %mul.i.i.2.1
  %add302.5.1 = fadd contract float %add302.4.1, %mul.i.i.6.1
  %add302.6.1 = fadd contract float %add302.5.1, %mul.i.i.3.1
  %add302.7.1 = fadd contract float %add302.6.1, %mul.i.i.7.1
  %249 = bitcast float %add302.7.1 to i32
  %250 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %251 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %250) #11
  %xor.i.i.1 = xor i32 %251, 32
  %252 = and i32 %251, -64
  %and.i.i.1 = add nsw i32 %252, 64
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1
  %cond.i.i668.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %251
  %shl.i.i.1 = shl i32 %cond.i.i668.1, 2
  %253 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %249)
  %254 = bitcast i32 %253 to float
  %add.i.1 = fadd contract float %add302.7.1, %254
  %255 = bitcast float %add.i.1 to i32
  %256 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %257 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %256) #11
  %xor.i.i669.1 = xor i32 %257, 16
  %258 = and i32 %257, -64
  %and.i.i670.1 = add nsw i32 %258, 64
  %cmp.not.i.i671.1 = icmp slt i32 %xor.i.i669.1, %and.i.i670.1
  %cond.i.i672.1 = select i1 %cmp.not.i.i671.1, i32 %xor.i.i669.1, i32 %257
  %shl.i.i673.1 = shl i32 %cond.i.i672.1, 2
  %259 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i673.1, i32 %255)
  %260 = bitcast i32 %259 to float
  %add.i.i.1 = fadd contract float %add.i.1, %260
  %cmp311.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1
  %condval_8.0.1 = select i1 %cmp311.1, float %div.1, float 0.000000e+00
  %mul324.1790 = fmul contract float %condval_8.0.1, %mul.i.i.1788
  %mul324.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1
  %mul324.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1
  %mul324.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1
  %mul324.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1
  %mul324.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1
  %mul324.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1
  %mul324.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.1790)
  %262 = insertelement <4 x i16> poison, i16 %261, i64 0
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.1.1)
  %264 = insertelement <4 x i16> %262, i16 %263, i64 1
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.2.1)
  %266 = insertelement <4 x i16> %264, i16 %265, i64 2
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.3.1)
  %268 = insertelement <4 x i16> %266, i16 %267, i64 3
  %prob.sroa.0.6.vec.insert1284 = bitcast <4 x i16> %268 to <4 x half>
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.4.1)
  %270 = insertelement <4 x i16> poison, i16 %269, i64 0
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.5.1)
  %272 = insertelement <4 x i16> %270, i16 %271, i64 1
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.6.1)
  %274 = insertelement <4 x i16> %272, i16 %273, i64 2
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.7.1)
  %276 = insertelement <4 x i16> %274, i16 %275, i64 3
  %prob.sroa.12.14.vec.insert1294 = bitcast <4 x i16> %276 to <4 x half>
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %279 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %280 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %281 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer)
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %277)
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %278)
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %279)
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %280)
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %281)
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %282)
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %283)
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %284)
  %out.sroa.0.0.vec.extract835 = extractelement <4 x float> %285, i64 0
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract835)
  %output_reg.sroa.0.0.insert.ext1027 = zext i16 %293 to i64
  %out.sroa.0.4.vec.extract840 = extractelement <4 x float> %285, i64 1
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract840)
  %output_reg.sroa.0.2.insert.ext1031 = zext i16 %294 to i64
  %output_reg.sroa.0.2.insert.shift1032 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1031, 16
  %output_reg.sroa.0.2.insert.insert1034 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1032, %output_reg.sroa.0.0.insert.ext1027
  %out.sroa.0.8.vec.extract845 = extractelement <4 x float> %285, i64 2
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract845)
  %output_reg.sroa.0.4.insert.ext1042 = zext i16 %295 to i64
  %output_reg.sroa.0.4.insert.shift1043 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1042, 32
  %output_reg.sroa.0.4.insert.insert1045 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1034, %output_reg.sroa.0.4.insert.shift1043
  %out.sroa.0.12.vec.extract850 = extractelement <4 x float> %285, i64 3
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract850)
  %output_reg.sroa.0.6.insert.ext1047 = zext i16 %296 to i64
  %output_reg.sroa.0.6.insert.shift1048 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1047, 48
  %output_reg.sroa.0.6.insert.insert1050 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1045, %output_reg.sroa.0.6.insert.shift1048
  %out.sroa.26.16.vec.extract859 = extractelement <4 x float> %286, i64 0
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract859)
  %output_reg.sroa.16.8.insert.ext1059 = zext i16 %297 to i64
  %out.sroa.26.20.vec.extract864 = extractelement <4 x float> %286, i64 1
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract864)
  %output_reg.sroa.16.10.insert.ext1063 = zext i16 %298 to i64
  %output_reg.sroa.16.10.insert.shift1064 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1063, 16
  %output_reg.sroa.16.10.insert.insert1066 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1064, %output_reg.sroa.16.8.insert.ext1059
  %out.sroa.26.24.vec.extract869 = extractelement <4 x float> %286, i64 2
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract869)
  %output_reg.sroa.16.12.insert.ext1074 = zext i16 %299 to i64
  %output_reg.sroa.16.12.insert.shift1075 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1074, 32
  %output_reg.sroa.16.12.insert.insert1077 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1066, %output_reg.sroa.16.12.insert.shift1075
  %out.sroa.26.28.vec.extract874 = extractelement <4 x float> %286, i64 3
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract874)
  %output_reg.sroa.16.14.insert.ext1079 = zext i16 %300 to i64
  %output_reg.sroa.16.14.insert.shift1080 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1079, 48
  %output_reg.sroa.16.14.insert.insert1082 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1077, %output_reg.sroa.16.14.insert.shift1080
  %out.sroa.50.32.vec.extract883 = extractelement <4 x float> %287, i64 0
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract883)
  %output_reg.sroa.30.16.insert.ext1091 = zext i16 %301 to i64
  %out.sroa.50.36.vec.extract888 = extractelement <4 x float> %287, i64 1
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract888)
  %output_reg.sroa.30.18.insert.ext1095 = zext i16 %302 to i64
  %output_reg.sroa.30.18.insert.shift1096 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1095, 16
  %output_reg.sroa.30.18.insert.insert1098 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1096, %output_reg.sroa.30.16.insert.ext1091
  %out.sroa.50.40.vec.extract893 = extractelement <4 x float> %287, i64 2
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract893)
  %output_reg.sroa.30.20.insert.ext1106 = zext i16 %303 to i64
  %output_reg.sroa.30.20.insert.shift1107 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1106, 32
  %output_reg.sroa.30.20.insert.insert1109 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1098, %output_reg.sroa.30.20.insert.shift1107
  %out.sroa.50.44.vec.extract898 = extractelement <4 x float> %287, i64 3
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract898)
  %output_reg.sroa.30.22.insert.ext1111 = zext i16 %304 to i64
  %output_reg.sroa.30.22.insert.shift1112 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1111, 48
  %output_reg.sroa.30.22.insert.insert1114 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1109, %output_reg.sroa.30.22.insert.shift1112
  %out.sroa.74.48.vec.extract907 = extractelement <4 x float> %288, i64 0
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract907)
  %output_reg.sroa.44.24.insert.ext1123 = zext i16 %305 to i64
  %out.sroa.74.52.vec.extract912 = extractelement <4 x float> %288, i64 1
  %306 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract912)
  %output_reg.sroa.44.26.insert.ext1127 = zext i16 %306 to i64
  %output_reg.sroa.44.26.insert.shift1128 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1127, 16
  %output_reg.sroa.44.26.insert.insert1130 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1128, %output_reg.sroa.44.24.insert.ext1123
  %out.sroa.74.56.vec.extract917 = extractelement <4 x float> %288, i64 2
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract917)
  %output_reg.sroa.44.28.insert.ext1138 = zext i16 %307 to i64
  %output_reg.sroa.44.28.insert.shift1139 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1138, 32
  %output_reg.sroa.44.28.insert.insert1141 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1130, %output_reg.sroa.44.28.insert.shift1139
  %out.sroa.74.60.vec.extract922 = extractelement <4 x float> %288, i64 3
  %308 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract922)
  %output_reg.sroa.44.30.insert.ext1143 = zext i16 %308 to i64
  %output_reg.sroa.44.30.insert.shift1144 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1143, 48
  %output_reg.sroa.44.30.insert.insert1146 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1141, %output_reg.sroa.44.30.insert.shift1144
  %out.sroa.98.64.vec.extract931 = extractelement <4 x float> %289, i64 0
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract931)
  %output_reg.sroa.58.32.insert.ext1155 = zext i16 %309 to i64
  %out.sroa.98.68.vec.extract936 = extractelement <4 x float> %289, i64 1
  %310 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract936)
  %output_reg.sroa.58.34.insert.ext1159 = zext i16 %310 to i64
  %output_reg.sroa.58.34.insert.shift1160 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1159, 16
  %output_reg.sroa.58.34.insert.insert1162 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1160, %output_reg.sroa.58.32.insert.ext1155
  %out.sroa.98.72.vec.extract941 = extractelement <4 x float> %289, i64 2
  %311 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract941)
  %output_reg.sroa.58.36.insert.ext1170 = zext i16 %311 to i64
  %output_reg.sroa.58.36.insert.shift1171 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1170, 32
  %output_reg.sroa.58.36.insert.insert1173 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1162, %output_reg.sroa.58.36.insert.shift1171
  %out.sroa.98.76.vec.extract946 = extractelement <4 x float> %289, i64 3
  %312 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract946)
  %output_reg.sroa.58.38.insert.ext1175 = zext i16 %312 to i64
  %output_reg.sroa.58.38.insert.shift1176 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1175, 48
  %output_reg.sroa.58.38.insert.insert1178 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1173, %output_reg.sroa.58.38.insert.shift1176
  %out.sroa.122.80.vec.extract955 = extractelement <4 x float> %290, i64 0
  %313 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract955)
  %output_reg.sroa.72.40.insert.ext1187 = zext i16 %313 to i64
  %out.sroa.122.84.vec.extract960 = extractelement <4 x float> %290, i64 1
  %314 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract960)
  %output_reg.sroa.72.42.insert.ext1191 = zext i16 %314 to i64
  %output_reg.sroa.72.42.insert.shift1192 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1191, 16
  %output_reg.sroa.72.42.insert.insert1194 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1192, %output_reg.sroa.72.40.insert.ext1187
  %out.sroa.122.88.vec.extract965 = extractelement <4 x float> %290, i64 2
  %315 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract965)
  %output_reg.sroa.72.44.insert.ext1202 = zext i16 %315 to i64
  %output_reg.sroa.72.44.insert.shift1203 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1202, 32
  %output_reg.sroa.72.44.insert.insert1205 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1194, %output_reg.sroa.72.44.insert.shift1203
  %out.sroa.122.92.vec.extract970 = extractelement <4 x float> %290, i64 3
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract970)
  %output_reg.sroa.72.46.insert.ext1207 = zext i16 %316 to i64
  %output_reg.sroa.72.46.insert.shift1208 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1207, 48
  %output_reg.sroa.72.46.insert.insert1210 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1205, %output_reg.sroa.72.46.insert.shift1208
  %out.sroa.146.96.vec.extract979 = extractelement <4 x float> %291, i64 0
  %317 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract979)
  %output_reg.sroa.86.48.insert.ext1219 = zext i16 %317 to i64
  %out.sroa.146.100.vec.extract984 = extractelement <4 x float> %291, i64 1
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract984)
  %output_reg.sroa.86.50.insert.ext1223 = zext i16 %318 to i64
  %output_reg.sroa.86.50.insert.shift1224 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1223, 16
  %output_reg.sroa.86.50.insert.insert1226 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1224, %output_reg.sroa.86.48.insert.ext1219
  %out.sroa.146.104.vec.extract989 = extractelement <4 x float> %291, i64 2
  %319 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract989)
  %output_reg.sroa.86.52.insert.ext1234 = zext i16 %319 to i64
  %output_reg.sroa.86.52.insert.shift1235 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1234, 32
  %output_reg.sroa.86.52.insert.insert1237 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1226, %output_reg.sroa.86.52.insert.shift1235
  %out.sroa.146.108.vec.extract994 = extractelement <4 x float> %291, i64 3
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract994)
  %output_reg.sroa.86.54.insert.ext1239 = zext i16 %320 to i64
  %output_reg.sroa.86.54.insert.shift1240 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1239, 48
  %output_reg.sroa.86.54.insert.insert1242 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1237, %output_reg.sroa.86.54.insert.shift1240
  %out.sroa.170.112.vec.extract1003 = extractelement <4 x float> %292, i64 0
  %321 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1003)
  %output_reg.sroa.100.56.insert.ext1251 = zext i16 %321 to i64
  %out.sroa.170.116.vec.extract1008 = extractelement <4 x float> %292, i64 1
  %322 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1008)
  %output_reg.sroa.100.58.insert.ext1255 = zext i16 %322 to i64
  %output_reg.sroa.100.58.insert.shift1256 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1255, 16
  %output_reg.sroa.100.58.insert.insert1258 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1256, %output_reg.sroa.100.56.insert.ext1251
  %out.sroa.170.120.vec.extract1013 = extractelement <4 x float> %292, i64 2
  %323 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1013)
  %output_reg.sroa.100.60.insert.ext1266 = zext i16 %323 to i64
  %output_reg.sroa.100.60.insert.shift1267 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1266, 32
  %output_reg.sroa.100.60.insert.insert1269 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1258, %output_reg.sroa.100.60.insert.shift1267
  %out.sroa.170.124.vec.extract1018 = extractelement <4 x float> %292, i64 3
  %324 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1018)
  %output_reg.sroa.100.62.insert.ext1271 = zext i16 %324 to i64
  %output_reg.sroa.100.62.insert.shift1272 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1271, 48
  %output_reg.sroa.100.62.insert.insert1274 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1269, %output_reg.sroa.100.62.insert.shift1272
  br label %if.end441.1

if.end441.1:                                      ; preds = %if.end119.1, %for.body421.preheader.1
  %add456.7.1.pre-phi = phi i32 [ %add138.7.1, %if.end119.1 ], [ %.pre1701, %for.body421.preheader.1 ]
  %add456.6.1.pre-phi = phi i32 [ %add138.6.1, %if.end119.1 ], [ %.pre1700, %for.body421.preheader.1 ]
  %add456.5.1.pre-phi = phi i32 [ %add138.5.1, %if.end119.1 ], [ %.pre1699, %for.body421.preheader.1 ]
  %add456.4.1.pre-phi = phi i32 [ %add138.4.1, %if.end119.1 ], [ %.pre1698, %for.body421.preheader.1 ]
  %add456.3.1.pre-phi = phi i32 [ %add138.3.1, %if.end119.1 ], [ %.pre1697, %for.body421.preheader.1 ]
  %add456.2.1.pre-phi = phi i32 [ %add138.2.1, %if.end119.1 ], [ %.pre1696, %for.body421.preheader.1 ]
  %add456.1.1.pre-phi = phi i32 [ %add138.1.1, %if.end119.1 ], [ %.pre1695, %for.body421.preheader.1 ]
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1274, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1242, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1210, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1178, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1146, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1114, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1082, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1050, %if.end119.1 ], [ 0, %for.body421.preheader.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor459.1816 = xor i32 %shr137, %and163
  %mul460.1817 = shl nuw nsw i32 %xor459.1816, 3
  %add461.1818 = add nuw nsw i32 %mul460.1817, %mul157
  %add466.1819 = or disjoint i32 %add461.1818, %mul465
  %add.ptr468.1820 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1819
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr468.1820, align 8
  %xor459.1.1 = xor i32 %add456.1.1.pre-phi, %and163
  %mul460.1.1 = shl nuw nsw i32 %xor459.1.1, 3
  %add461.1.1 = add nuw nsw i32 %mul460.1.1, %mul157
  %add466.1.1 = or disjoint i32 %add461.1.1, %mul465
  %add.ptr468.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1.1
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr468.1.1, align 8
  %xor459.2.1 = xor i32 %add456.2.1.pre-phi, %and163
  %mul460.2.1 = shl nuw nsw i32 %xor459.2.1, 3
  %add461.2.1 = add nuw nsw i32 %mul460.2.1, %mul157
  %add466.2.1 = or disjoint i32 %add461.2.1, %mul465
  %add.ptr468.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.2.1
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr468.2.1, align 8
  %xor459.3.1 = xor i32 %add456.3.1.pre-phi, %and163
  %mul460.3.1 = shl nuw nsw i32 %xor459.3.1, 3
  %add461.3.1 = add nuw nsw i32 %mul460.3.1, %mul157
  %add466.3.1 = or disjoint i32 %add461.3.1, %mul465
  %add.ptr468.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.3.1
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr468.3.1, align 8
  %xor459.4.1 = xor i32 %add456.4.1.pre-phi, %and163
  %mul460.4.1 = shl nuw nsw i32 %xor459.4.1, 3
  %add461.4.1 = add nuw nsw i32 %mul460.4.1, %mul157
  %add466.4.1 = or disjoint i32 %add461.4.1, %mul465
  %add.ptr468.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.4.1
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr468.4.1, align 8
  %xor459.5.1 = xor i32 %add456.5.1.pre-phi, %and163
  %mul460.5.1 = shl nuw nsw i32 %xor459.5.1, 3
  %add461.5.1 = add nuw nsw i32 %mul460.5.1, %mul157
  %add466.5.1 = or disjoint i32 %add461.5.1, %mul465
  %add.ptr468.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.5.1
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr468.5.1, align 8
  %xor459.6.1 = xor i32 %add456.6.1.pre-phi, %and163
  %mul460.6.1 = shl nuw nsw i32 %xor459.6.1, 3
  %add461.6.1 = add nuw nsw i32 %mul460.6.1, %mul157
  %add466.6.1 = or disjoint i32 %add461.6.1, %mul465
  %add.ptr468.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.6.1
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr468.6.1, align 8
  %xor459.7.1 = xor i32 %add456.7.1.pre-phi, %and163
  %mul460.7.1 = shl nuw nsw i32 %xor459.7.1, 3
  %add461.7.1 = add nuw nsw i32 %mul460.7.1, %mul157
  %add466.7.1 = or disjoint i32 %add461.7.1, %mul465
  %add.ptr468.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.7.1
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr468.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br i1 %cmp42.1, label %if.end485.1825, label %if.end518.3.1

if.end485.1825:                                   ; preds = %if.end441.1
  %mul509.1 = shl nuw nsw i32 %7, 11
  %add512.1 = add nuw nsw i32 %add510, %mul509.1
  %325 = zext nneg i32 %add512.1 to i64
  %xor501.1821 = xor i32 %shr160, %and163
  %add.ptr505.idx.1822 = shl nuw nsw i32 %xor501.1821, 4
  %add.ptr505.1823 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 %add.ptr505.idx.1822
  %add.ptr517.1824 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1824, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.1823, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  %326 = add nuw nsw i32 %shr160, 4
  %xor501.1.1 = xor i32 %326, %and163
  %gep712.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 1024
  %add.ptr505.idx.1.1 = shl nuw nsw i32 %xor501.1.1, 4
  %add.ptr505.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.1.1, i32 %add.ptr505.idx.1.1
  %327 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325
  %add.ptr517.1.1 = getelementptr inbounds i8, ptr addrspace(1) %327, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.1.1, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  %328 = add nuw nsw i32 %shr160, 8
  %xor501.2.1 = xor i32 %328, %and163
  %gep712.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 2048
  %add.ptr505.idx.2.1 = shl nuw nsw i32 %xor501.2.1, 4
  %add.ptr505.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.2.1, i32 %add.ptr505.idx.2.1
  %329 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325
  %add.ptr517.2.1 = getelementptr inbounds i8, ptr addrspace(1) %329, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.2.1, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  %narrow = add nuw nsw i32 %shr160, 12
  %xor501.3.1 = xor i32 %narrow, %and163
  %gep712.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 3072
  %add.ptr505.idx.3.1 = shl nuw nsw i32 %xor501.3.1, 4
  %add.ptr505.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.3.1, i32 %add.ptr505.idx.3.1
  %330 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325
  %add.ptr517.3.1 = getelementptr inbounds i8, ptr addrspace(1) %330, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.3.1, i64 16, i1 false), !tbaa.struct !196, !call_argsrelate !197
  br label %if.end518.3.1

if.end518.3.1:                                    ; preds = %if.end441.1, %if.end485.1825
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end526

if.end526:                                        ; preds = %if.end522, %if.end518.3.1, %entry
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare void @llvm.mxc.barrier.warp() #7

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
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


