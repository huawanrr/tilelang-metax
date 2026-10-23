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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(1) noalias nocapture noundef readonly %Schedule.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = mul nuw nsw i32 %1, 241
  %idxprom = zext nneg i32 %mul to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Schedule.coerce, i64 %idxprom
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp = icmp slt i32 %0, %2
  br i1 %cmp, label %if.then, label %if.end571

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
  %invariant.gep768 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
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
  %invariant.gep744 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul109
  %and = lshr i32 %9, 1
  %shr134 = and i32 %and, 15
  %shr137 = lshr i32 %9, 5
  %add132 = and i32 %10, 3972
  %and156 = shl nuw nsw i32 %9, 7
  %mul157 = and i32 %and156, 1920
  %shr160 = lshr i32 %9, 4
  %and163 = and i32 %9, 15
  %gep767 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %mul157
  %13 = lshr i32 %9, 2
  %mul193 = and i32 %13, 252
  %add190 = add nuw nsw i32 %mul88, %mul193
  %cmp247 = icmp slt i32 %7, 0
  %gep769 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep768, i64 %mul109
  %cmp32 = icmp sgt i32 %6, -1
  br i1 %cmp32, label %for.cond34.preheader, label %if.end357

for.cond34.preheader:                             ; preds = %if.then
  %cmp42 = icmp ult i32 %6, 1024
  %condval_4.0 = zext nneg i32 %6 to i64
  br i1 %cmp42, label %if.then43, label %if.end79

if.then43:                                        ; preds = %for.cond34.preheader
  %.idx787 = shl nuw nsw i64 %condval_4.0, 12
  %14 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787
  %.idx788 = shl nuw nsw i64 %shr, 22
  %15 = getelementptr i8, ptr addrspace(4) %14, i64 %.idx788
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %15, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %15, i64 4
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
  %.idx787.1 = shl nuw nsw i64 %condval_4.0, 12
  %16 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.1
  %.idx788.1 = shl nuw nsw i64 %shr, 22
  %17 = getelementptr i8, ptr addrspace(4) %16, i64 %.idx788.1
  %gep.1 = getelementptr i8, ptr addrspace(4) %17, i64 512
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr i8, ptr addrspace(4) %17, i64 516
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
  %.idx787.2 = shl nuw nsw i64 %condval_4.0, 12
  %18 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.2
  %.idx788.2 = shl nuw nsw i64 %shr, 22
  %19 = getelementptr i8, ptr addrspace(4) %18, i64 %.idx788.2
  %gep.2 = getelementptr i8, ptr addrspace(4) %19, i64 1024
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr i8, ptr addrspace(4) %19, i64 1028
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
  %.idx787.3 = shl nuw nsw i64 %condval_4.0, 12
  %20 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.3
  %.idx788.3 = shl nuw nsw i64 %shr, 22
  %21 = getelementptr i8, ptr addrspace(4) %20, i64 %.idx788.3
  %gep.3 = getelementptr i8, ptr addrspace(4) %21, i64 1536
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr i8, ptr addrspace(4) %21, i64 1540
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
  %.idx787.4 = shl nuw nsw i64 %condval_4.0, 12
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.4
  %.idx788.4 = shl nuw nsw i64 %shr, 22
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx788.4
  %gep.4 = getelementptr i8, ptr addrspace(4) %23, i64 2048
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr i8, ptr addrspace(4) %23, i64 2052
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
  %.idx787.5 = shl nuw nsw i64 %condval_4.0, 12
  %24 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.5
  %.idx788.5 = shl nuw nsw i64 %shr, 22
  %25 = getelementptr i8, ptr addrspace(4) %24, i64 %.idx788.5
  %gep.5 = getelementptr i8, ptr addrspace(4) %25, i64 2560
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr i8, ptr addrspace(4) %25, i64 2564
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
  %.idx787.6 = shl nuw nsw i64 %condval_4.0, 12
  %26 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.6
  %.idx788.6 = shl nuw nsw i64 %shr, 22
  %27 = getelementptr i8, ptr addrspace(4) %26, i64 %.idx788.6
  %gep.6 = getelementptr i8, ptr addrspace(4) %27, i64 3072
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr i8, ptr addrspace(4) %27, i64 3076
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
  %.idx787.7 = shl nuw nsw i64 %condval_4.0, 12
  %28 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.7
  %.idx788.7 = shl nuw nsw i64 %shr, 22
  %29 = getelementptr i8, ptr addrspace(4) %28, i64 %.idx788.7
  %gep.7 = getelementptr i8, ptr addrspace(4) %29, i64 3584
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr i8, ptr addrspace(4) %29, i64 3588
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !tbaa !30
  br label %if.end79.7

if.end79.7:                                       ; preds = %if.then43.7, %if.end79.6
  %condval_1.sroa.0.0.7 = phi i32 [ %condval_1.sroa.0.0.copyload.7, %if.then43.7 ], [ 0, %if.end79.6 ]
  %condval_1.sroa.5.0.7 = phi i32 [ %condval_1.sroa.5.0.copyload.7, %if.then43.7 ], [ 0, %if.end79.6 ]
  %cmp89 = icmp sle i32 %mul88, %6
  %or.cond785 = select i1 %cmp87, i1 %cmp89, i1 false
  br i1 %or.cond785, label %for.body96.preheader, label %if.end357

for.body96.preheader:                             ; preds = %if.end79.7
  %q_stage.sroa.44.60.insert.ext = zext i32 %condval_1.sroa.5.0.7 to i64
  %q_stage.sroa.44.60.insert.shift = shl nuw i64 %q_stage.sroa.44.60.insert.ext, 32
  %q_stage.sroa.44.56.insert.ext = zext i32 %condval_1.sroa.0.0.7 to i64
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %q_stage.sroa.44.60.insert.shift, %q_stage.sroa.44.56.insert.ext
  %.idx789 = shl nuw nsw i64 %shr, 19
  %30 = getelementptr i8, ptr addrspace(4) %invariant.gep744, i64 %.idx789
  %31 = getelementptr %struct.__half, ptr addrspace(4) %30, i64 %mul102
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %31, align 16
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %31, i64 8
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8
  %gep745.1 = getelementptr i8, ptr addrspace(4) %31, i64 1024
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep745.1, align 16
  %k.sroa.12.16.gep745.1.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 1032
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep745.1.sroa_idx, align 8
  %gep745.2 = getelementptr i8, ptr addrspace(4) %31, i64 2048
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep745.2, align 16
  %k.sroa.18.32.gep745.2.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 2056
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep745.2.sroa_idx, align 8
  %gep745.3 = getelementptr i8, ptr addrspace(4) %31, i64 3072
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep745.3, align 16
  %k.sroa.24.48.gep745.3.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 3080
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep745.3.sroa_idx, align 8
  %gep745.4 = getelementptr i8, ptr addrspace(4) %31, i64 4096
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep745.4, align 16
  %k.sroa.30.64.gep745.4.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 4104
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep745.4.sroa_idx, align 8
  %gep745.5 = getelementptr i8, ptr addrspace(4) %31, i64 5120
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep745.5, align 16
  %k.sroa.36.80.gep745.5.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 5128
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep745.5.sroa_idx, align 8
  %gep745.6 = getelementptr i8, ptr addrspace(4) %31, i64 6144
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep745.6, align 16
  %k.sroa.42.96.gep745.6.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 6152
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep745.6.sroa_idx, align 8
  %gep745.7 = getelementptr i8, ptr addrspace(4) %31, i64 7168
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep745.7, align 16
  %k.sroa.48.112.gep745.7.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 7176
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep745.7.sroa_idx, align 8
  %xor = xor i32 %shr137, %shr134
  %32 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132
  %gep747.idx = shl nuw nsw i32 %xor, 4
  %gep747 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %gep747.idx
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %gep747, align 8
  %add138.1 = add nuw nsw i32 %shr137, 2
  %xor.1 = xor i32 %add138.1, %shr134
  %33 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 512
  %gep747.idx.1 = shl nuw nsw i32 %xor.1, 4
  %gep747.1 = getelementptr inbounds i8, ptr addrspace(3) %33, i32 %gep747.idx.1
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %gep747.1, align 8
  %add138.2 = add nuw nsw i32 %shr137, 4
  %xor.2 = xor i32 %add138.2, %shr134
  %34 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 1024
  %gep747.idx.2 = shl nuw nsw i32 %xor.2, 4
  %gep747.2 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %gep747.idx.2
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %gep747.2, align 8
  %add138.3 = add nuw nsw i32 %shr137, 6
  %xor.3 = xor i32 %add138.3, %shr134
  %35 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 1536
  %gep747.idx.3 = shl nuw nsw i32 %xor.3, 4
  %gep747.3 = getelementptr inbounds i8, ptr addrspace(3) %35, i32 %gep747.idx.3
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %gep747.3, align 8
  %add138.4 = add nuw nsw i32 %shr137, 8
  %xor.4 = xor i32 %add138.4, %shr134
  %36 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 2048
  %gep747.idx.4 = shl nuw nsw i32 %xor.4, 4
  %gep747.4 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 %gep747.idx.4
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %gep747.4, align 8
  %add138.5 = add nuw nsw i32 %shr137, 10
  %xor.5 = xor i32 %add138.5, %shr134
  %37 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 2560
  %gep747.idx.5 = shl nuw nsw i32 %xor.5, 4
  %gep747.5 = getelementptr inbounds i8, ptr addrspace(3) %37, i32 %gep747.idx.5
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %gep747.5, align 8
  %add138.6 = add nuw nsw i32 %shr137, 12
  %xor.6 = xor i32 %add138.6, %shr134
  %38 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 3072
  %gep747.idx.6 = shl nuw nsw i32 %xor.6, 4
  %gep747.6 = getelementptr inbounds i8, ptr addrspace(3) %38, i32 %gep747.idx.6
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %gep747.6, align 8
  %add138.7 = add nuw nsw i32 %shr137, 14
  %xor.7 = xor i32 %add138.7, %shr134
  %39 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 3584
  %gep747.idx.7 = shl nuw nsw i32 %xor.7, 4
  %gep747.7 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %gep747.idx.7
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %gep747.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor164 = xor i32 %shr160, %and163
  %.idx = shl nuw nsw i32 %xor164, 4
  %gep750 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep750, align 16
  %q.sroa.6.0.gep750.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750, i32 8
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep750.sroa_idx, align 8
  %add161.1 = add nuw nsw i32 %shr160, 4
  %xor164.1 = xor i32 %add161.1, %and163
  %.idx.1 = shl nuw nsw i32 %xor164.1, 4
  %gep750.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.1
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep750.1, align 16
  %q.sroa.12.16.gep750.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1, i32 8
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep750.1.sroa_idx, align 8
  %add161.2 = add nuw nsw i32 %shr160, 8
  %xor164.2 = xor i32 %add161.2, %and163
  %.idx.2 = shl nuw nsw i32 %xor164.2, 4
  %gep750.2 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.2
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %gep750.2, align 16
  %q.sroa.18.32.gep750.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.2, i32 8
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep750.2.sroa_idx, align 8
  %add161.3 = add nuw nsw i32 %shr160, 12
  %xor164.3 = xor i32 %add161.3, %and163
  %.idx.3 = shl nuw nsw i32 %xor164.3, 4
  %gep750.3 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.3
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %gep750.3, align 16
  %q.sroa.24.48.gep750.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.3, i32 8
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep750.3.sroa_idx, align 8
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
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !93
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !call_argsrelate !93
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %40), !call_argsrelate !93
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %41), !call_argsrelate !93
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %42), !call_argsrelate !93
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %43), !call_argsrelate !93
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %44), !call_argsrelate !93
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %45), !call_argsrelate !93
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %46), !call_argsrelate !93
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %47), !call_argsrelate !93
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %48), !call_argsrelate !93
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %49), !call_argsrelate !93
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %50), !call_argsrelate !93
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %51), !call_argsrelate !93
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %52), !call_argsrelate !93
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %53), !call_argsrelate !93
  br i1 %cmp247, label %for.body252.preheader, label %if.end276

for.body252.preheader:                            ; preds = %for.body96.preheader
  %.idx793 = shl nuw nsw i64 %shr, 19
  %56 = getelementptr i8, ptr addrspace(4) %gep769, i64 %.idx793
  %57 = getelementptr %struct.__half, ptr addrspace(4) %56, i64 %mul102
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %57, align 16
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %57, i64 8
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8
  %gep759.1 = getelementptr i8, ptr addrspace(4) %57, i64 1024
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep759.1, align 16
  %v.sroa.12.16.gep759.1.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 1032
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep759.1.sroa_idx, align 8
  %gep759.2 = getelementptr i8, ptr addrspace(4) %57, i64 2048
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep759.2, align 16
  %v.sroa.18.32.gep759.2.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 2056
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep759.2.sroa_idx, align 8
  %gep759.3 = getelementptr i8, ptr addrspace(4) %57, i64 3072
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep759.3, align 16
  %v.sroa.24.48.gep759.3.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 3080
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep759.3.sroa_idx, align 8
  %gep759.4 = getelementptr i8, ptr addrspace(4) %57, i64 4096
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep759.4, align 16
  %v.sroa.30.64.gep759.4.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 4104
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep759.4.sroa_idx, align 8
  %gep759.5 = getelementptr i8, ptr addrspace(4) %57, i64 5120
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep759.5, align 16
  %v.sroa.36.80.gep759.5.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 5128
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep759.5.sroa_idx, align 8
  %gep759.6 = getelementptr i8, ptr addrspace(4) %57, i64 6144
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep759.6, align 16
  %v.sroa.42.96.gep759.6.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 6152
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep759.6.sroa_idx, align 8
  %gep759.7 = getelementptr i8, ptr addrspace(4) %57, i64 7168
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep759.7, align 16
  %v.sroa.48.112.gep759.7.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 7176
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep759.7.sroa_idx, align 8
  br label %if.end276

if.end276:                                        ; preds = %for.body252.preheader, %for.body96.preheader
  %v.sroa.48.0 = phi <4 x half> [ %v.sroa.48.112.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.44.0 = phi <4 x half> [ %v.sroa.44.112.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.42.0 = phi <4 x half> [ %v.sroa.42.96.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.38.0 = phi <4 x half> [ %v.sroa.38.96.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.36.0 = phi <4 x half> [ %v.sroa.36.80.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.32.0 = phi <4 x half> [ %v.sroa.32.80.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.30.0 = phi <4 x half> [ %v.sroa.30.64.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.26.0 = phi <4 x half> [ %v.sroa.26.64.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.24.0 = phi <4 x half> [ %v.sroa.24.48.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.20.0 = phi <4 x half> [ %v.sroa.20.48.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.18.0 = phi <4 x half> [ %v.sroa.18.32.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.14.0 = phi <4 x half> [ %v.sroa.14.32.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.12.0 = phi <4 x half> [ %v.sroa.12.16.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.8.0 = phi <4 x half> [ %v.sroa.8.16.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.6.0 = phi <4 x half> [ %v.sroa.6.0.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.0.0 = phi <4 x half> [ %v.sroa.0.0.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %54, i64 0
  %mul283 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul283, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %58, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i730 = fadd contract float %58, %cond.i.i
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i730)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %59
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %54, i64 1
  %mul283.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul283.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %60, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.1 = fadd contract float %60, %cond.i.i.1
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i730.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %61
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %54, i64 2
  %mul283.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul283.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %62, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.2 = fadd contract float %62, %cond.i.i.2
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i730.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %63
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %54, i64 3
  %mul283.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul283.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %64, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.3 = fadd contract float %64, %cond.i.i.3
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i730.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %65
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %55, i64 0
  %mul283.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul283.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %66, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.4 = fadd contract float %66, %cond.i.i.4
  %67 = tail call contract float @llvm.exp2.f32(float %add.i.i730.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %67
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %55, i64 1
  %mul283.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul283.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %68, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.5 = fadd contract float %68, %cond.i.i.5
  %69 = tail call contract float @llvm.exp2.f32(float %add.i.i730.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %69
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %55, i64 2
  %mul283.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul283.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %70, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.6 = fadd contract float %70, %cond.i.i.6
  %71 = tail call contract float @llvm.exp2.f32(float %add.i.i730.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %71
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %55, i64 3
  %mul283.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul283.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %72, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.7 = fadd contract float %72, %cond.i.i.7
  %73 = tail call contract float @llvm.exp2.f32(float %add.i.i730.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %73
  %add303 = fadd contract float %mul.i.i, 0.000000e+00
  %add303.1 = fadd contract float %add303, %mul.i.i.4
  %add303.2 = fadd contract float %add303.1, %mul.i.i.1
  %add303.3 = fadd contract float %add303.2, %mul.i.i.5
  %add303.4 = fadd contract float %add303.3, %mul.i.i.2
  %add303.5 = fadd contract float %add303.4, %mul.i.i.6
  %add303.6 = fadd contract float %add303.5, %mul.i.i.3
  %add303.7 = fadd contract float %add303.6, %mul.i.i.7
  %74 = bitcast float %add303.7 to i32
  %75 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %76 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %75) #11
  %xor.i.i = xor i32 %76, 32
  %77 = and i32 %76, -64
  %and.i.i = add nsw i32 %77, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i731 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %76
  %shl.i.i = shl i32 %cond.i.i731, 2
  %78 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %74)
  %79 = bitcast i32 %78 to float
  %add.i = fadd contract float %add303.7, %79
  %80 = bitcast float %add.i to i32
  %81 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %82 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %81) #11
  %xor.i.i732 = xor i32 %82, 16
  %83 = and i32 %82, -64
  %and.i.i733 = add nsw i32 %83, 64
  %cmp.not.i.i734 = icmp slt i32 %xor.i.i732, %and.i.i733
  %cond.i.i735 = select i1 %cmp.not.i.i734, i32 %xor.i.i732, i32 %82
  %shl.i.i736 = shl i32 %cond.i.i735, 2
  %84 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i736, i32 %80)
  %85 = bitcast i32 %84 to float
  %add.i.i = fadd contract float %add.i, %85
  %cmp312 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp312, float %div, float 0.000000e+00
  %mul325 = fmul contract float %condval_8.0, %mul.i.i
  %mul325.1 = fmul contract float %condval_8.0, %mul.i.i.1
  %mul325.2 = fmul contract float %condval_8.0, %mul.i.i.2
  %mul325.3 = fmul contract float %condval_8.0, %mul.i.i.3
  %mul325.4 = fmul contract float %condval_8.0, %mul.i.i.4
  %mul325.5 = fmul contract float %condval_8.0, %mul.i.i.5
  %mul325.6 = fmul contract float %condval_8.0, %mul.i.i.6
  %mul325.7 = fmul contract float %condval_8.0, %mul.i.i.7
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325)
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.1)
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.2)
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.3)
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.4)
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.5)
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.6)
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.7)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end357

if.end357:                                        ; preds = %if.end276, %if.end79.7, %if.then
  %v.sroa.48.1 = phi <4 x half> [ %v.sroa.48.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.44.1 = phi <4 x half> [ %v.sroa.44.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.42.1 = phi <4 x half> [ %v.sroa.42.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.38.1 = phi <4 x half> [ %v.sroa.38.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.36.1 = phi <4 x half> [ %v.sroa.36.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.32.1 = phi <4 x half> [ %v.sroa.32.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.30.1 = phi <4 x half> [ %v.sroa.30.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.26.1 = phi <4 x half> [ %v.sroa.26.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.24.1 = phi <4 x half> [ %v.sroa.24.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.20.1 = phi <4 x half> [ %v.sroa.20.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.18.1 = phi <4 x half> [ %v.sroa.18.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.14.1 = phi <4 x half> [ %v.sroa.14.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.12.1 = phi <4 x half> [ %v.sroa.12.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.8.1 = phi <4 x half> [ %v.sroa.8.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.6.1 = phi <4 x half> [ %v.sroa.6.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.0.1 = phi <4 x half> [ %v.sroa.0.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.16.0 = phi i16 [ %93, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.14.0 = phi i16 [ %92, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.12.0 = phi i16 [ %91, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.10.0 = phi i16 [ %90, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.8.0 = phi i16 [ %89, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.6.0 = phi i16 [ %88, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.4.0 = phi i16 [ %87, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.0.0 = phi i16 [ %86, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.48.1 = phi <4 x half> [ %k.sroa.48.112.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.44.1 = phi <4 x half> [ %k.sroa.44.112.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.42.1 = phi <4 x half> [ %k.sroa.42.96.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.38.1 = phi <4 x half> [ %k.sroa.38.96.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.36.1 = phi <4 x half> [ %k.sroa.36.80.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.32.1 = phi <4 x half> [ %k.sroa.32.80.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.30.1 = phi <4 x half> [ %k.sroa.30.64.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.26.1 = phi <4 x half> [ %k.sroa.26.64.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.24.1 = phi <4 x half> [ %k.sroa.24.48.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.20.1 = phi <4 x half> [ %k.sroa.20.48.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.18.1 = phi <4 x half> [ %k.sroa.18.32.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.14.1 = phi <4 x half> [ %k.sroa.14.32.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.12.1 = phi <4 x half> [ %k.sroa.12.16.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.8.1 = phi <4 x half> [ %k.sroa.8.16.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.6.1 = phi <4 x half> [ %k.sroa.6.0.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.0.1 = phi <4 x half> [ %k.sroa.0.0.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %cmp32.1 = icmp sgt i32 %7, -1
  br i1 %cmp32.1, label %for.cond34.preheader.1, label %if.end357.1

for.cond34.preheader.1:                           ; preds = %if.end357
  %cmp42.1 = icmp ult i32 %7, 1024
  %condval_4.0.1 = zext nneg i32 %7 to i64
  br i1 %cmp42.1, label %if.then43.1817, label %if.end79.1821

if.then43.1817:                                   ; preds = %for.cond34.preheader.1
  %.idx787.1812 = shl nuw nsw i64 %condval_4.0.1, 12
  %94 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.1812
  %.idx788.1813 = shl nuw nsw i64 %shr, 22
  %95 = getelementptr i8, ptr addrspace(4) %94, i64 %.idx788.1813
  %condval_1.sroa.0.0.copyload.1814 = load i32, ptr addrspace(4) %95, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1815 = getelementptr inbounds i8, ptr addrspace(4) %95, i64 4
  %condval_1.sroa.5.0.copyload.1816 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1815, align 4, !tbaa !30
  %96 = zext i32 %condval_1.sroa.0.0.copyload.1814 to i64
  %97 = zext i32 %condval_1.sroa.5.0.copyload.1816 to i64
  %98 = shl nuw i64 %97, 32
  %99 = or disjoint i64 %98, %96
  br label %if.end79.1821

if.end79.1821:                                    ; preds = %if.then43.1817, %for.cond34.preheader.1
  %q_stage.sroa.0.4.insert.insert1658 = phi i64 [ %99, %if.then43.1817 ], [ 0, %for.cond34.preheader.1 ]
  br i1 %cmp42.1, label %if.then43.1.1, label %if.end79.1.1

if.then43.1.1:                                    ; preds = %if.end79.1821
  %.idx787.1.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %100 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.1.1
  %.idx788.1.1 = shl nuw nsw i64 %shr, 22
  %101 = getelementptr i8, ptr addrspace(4) %100, i64 %.idx788.1.1
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %101, i64 512
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr i8, ptr addrspace(4) %101, i64 516
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !tbaa !30
  %102 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64
  %103 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64
  %104 = shl nuw i64 %103, 32
  %105 = or disjoint i64 %104, %102
  br label %if.end79.1.1

if.end79.1.1:                                     ; preds = %if.then43.1.1, %if.end79.1821
  %q_stage.sroa.8.12.insert.insert1668 = phi i64 [ %105, %if.then43.1.1 ], [ 0, %if.end79.1821 ]
  br i1 %cmp42.1, label %if.then43.2.1, label %if.end79.2.1

if.then43.2.1:                                    ; preds = %if.end79.1.1
  %.idx787.2.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %106 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.2.1
  %.idx788.2.1 = shl nuw nsw i64 %shr, 22
  %107 = getelementptr i8, ptr addrspace(4) %106, i64 %.idx788.2.1
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %107, i64 1024
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr i8, ptr addrspace(4) %107, i64 1028
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !tbaa !30
  %108 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64
  %109 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64
  %110 = shl nuw i64 %109, 32
  %111 = or disjoint i64 %110, %108
  br label %if.end79.2.1

if.end79.2.1:                                     ; preds = %if.then43.2.1, %if.end79.1.1
  %q_stage.sroa.14.20.insert.insert1678 = phi i64 [ %111, %if.then43.2.1 ], [ 0, %if.end79.1.1 ]
  br i1 %cmp42.1, label %if.then43.3.1, label %if.end79.3.1

if.then43.3.1:                                    ; preds = %if.end79.2.1
  %.idx787.3.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %112 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.3.1
  %.idx788.3.1 = shl nuw nsw i64 %shr, 22
  %113 = getelementptr i8, ptr addrspace(4) %112, i64 %.idx788.3.1
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %113, i64 1536
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr i8, ptr addrspace(4) %113, i64 1540
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !tbaa !30
  %114 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64
  %115 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64
  %116 = shl nuw i64 %115, 32
  %117 = or disjoint i64 %116, %114
  br label %if.end79.3.1

if.end79.3.1:                                     ; preds = %if.then43.3.1, %if.end79.2.1
  %q_stage.sroa.20.28.insert.insert1688 = phi i64 [ %117, %if.then43.3.1 ], [ 0, %if.end79.2.1 ]
  br i1 %cmp42.1, label %if.then43.4.1, label %if.end79.4.1

if.then43.4.1:                                    ; preds = %if.end79.3.1
  %.idx787.4.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %118 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.4.1
  %.idx788.4.1 = shl nuw nsw i64 %shr, 22
  %119 = getelementptr i8, ptr addrspace(4) %118, i64 %.idx788.4.1
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %119, i64 2048
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr i8, ptr addrspace(4) %119, i64 2052
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !tbaa !30
  %120 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64
  %121 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64
  %122 = shl nuw i64 %121, 32
  %123 = or disjoint i64 %122, %120
  br label %if.end79.4.1

if.end79.4.1:                                     ; preds = %if.then43.4.1, %if.end79.3.1
  %q_stage.sroa.26.36.insert.insert1698 = phi i64 [ %123, %if.then43.4.1 ], [ 0, %if.end79.3.1 ]
  br i1 %cmp42.1, label %if.then43.5.1, label %if.end79.5.1

if.then43.5.1:                                    ; preds = %if.end79.4.1
  %.idx787.5.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %124 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.5.1
  %.idx788.5.1 = shl nuw nsw i64 %shr, 22
  %125 = getelementptr i8, ptr addrspace(4) %124, i64 %.idx788.5.1
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %125, i64 2560
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr i8, ptr addrspace(4) %125, i64 2564
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !tbaa !30
  %126 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64
  %127 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64
  %128 = shl nuw i64 %127, 32
  %129 = or disjoint i64 %128, %126
  br label %if.end79.5.1

if.end79.5.1:                                     ; preds = %if.then43.5.1, %if.end79.4.1
  %q_stage.sroa.32.44.insert.insert1708 = phi i64 [ %129, %if.then43.5.1 ], [ 0, %if.end79.4.1 ]
  br i1 %cmp42.1, label %if.then43.6.1, label %if.end79.6.1

if.then43.6.1:                                    ; preds = %if.end79.5.1
  %.idx787.6.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %130 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.6.1
  %.idx788.6.1 = shl nuw nsw i64 %shr, 22
  %131 = getelementptr i8, ptr addrspace(4) %130, i64 %.idx788.6.1
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %131, i64 3072
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr i8, ptr addrspace(4) %131, i64 3076
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !tbaa !30
  %132 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64
  %133 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64
  %134 = shl nuw i64 %133, 32
  %135 = or disjoint i64 %134, %132
  br label %if.end79.6.1

if.end79.6.1:                                     ; preds = %if.then43.6.1, %if.end79.5.1
  %q_stage.sroa.38.52.insert.insert1718 = phi i64 [ %135, %if.then43.6.1 ], [ 0, %if.end79.5.1 ]
  br i1 %cmp42.1, label %if.then43.7.1, label %if.end79.7.1

if.then43.7.1:                                    ; preds = %if.end79.6.1
  %.idx787.7.1 = shl nuw nsw i64 %condval_4.0.1, 12
  %136 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.7.1
  %.idx788.7.1 = shl nuw nsw i64 %shr, 22
  %137 = getelementptr i8, ptr addrspace(4) %136, i64 %.idx788.7.1
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %137, i64 3584
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr i8, ptr addrspace(4) %137, i64 3588
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !tbaa !30
  %138 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64
  %139 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64
  %140 = shl nuw i64 %139, 32
  %141 = or disjoint i64 %140, %138
  br label %if.end79.7.1

if.end79.7.1:                                     ; preds = %if.then43.7.1, %if.end79.6.1
  %q_stage.sroa.44.60.insert.insert1728 = phi i64 [ %141, %if.then43.7.1 ], [ 0, %if.end79.6.1 ]
  %cmp89.1 = icmp sle i32 %mul88, %7
  %or.cond785.1 = select i1 %cmp87, i1 %cmp89.1, i1 false
  br i1 %or.cond785.1, label %if.end119.1, label %if.end357.1

if.end119.1:                                      ; preds = %if.end79.7.1
  %xor.1823 = xor i32 %shr137, %shr134
  %142 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132
  %gep747.idx.1824 = shl nuw nsw i32 %xor.1823, 4
  %gep747.1825 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 %gep747.idx.1824
  store i64 %q_stage.sroa.0.4.insert.insert1658, ptr addrspace(3) %gep747.1825, align 8
  %add138.1.1 = add nuw nsw i32 %shr137, 2
  %xor.1.1 = xor i32 %add138.1.1, %shr134
  %143 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 512
  %gep747.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4
  %gep747.1.1 = getelementptr inbounds i8, ptr addrspace(3) %143, i32 %gep747.idx.1.1
  store i64 %q_stage.sroa.8.12.insert.insert1668, ptr addrspace(3) %gep747.1.1, align 8
  %add138.2.1 = add nuw nsw i32 %shr137, 4
  %xor.2.1 = xor i32 %add138.2.1, %shr134
  %144 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 1024
  %gep747.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4
  %gep747.2.1 = getelementptr inbounds i8, ptr addrspace(3) %144, i32 %gep747.idx.2.1
  store i64 %q_stage.sroa.14.20.insert.insert1678, ptr addrspace(3) %gep747.2.1, align 8
  %add138.3.1 = add nuw nsw i32 %shr137, 6
  %xor.3.1 = xor i32 %add138.3.1, %shr134
  %145 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 1536
  %gep747.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4
  %gep747.3.1 = getelementptr inbounds i8, ptr addrspace(3) %145, i32 %gep747.idx.3.1
  store i64 %q_stage.sroa.20.28.insert.insert1688, ptr addrspace(3) %gep747.3.1, align 8
  %add138.4.1 = add nuw nsw i32 %shr137, 8
  %xor.4.1 = xor i32 %add138.4.1, %shr134
  %146 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 2048
  %gep747.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4
  %gep747.4.1 = getelementptr inbounds i8, ptr addrspace(3) %146, i32 %gep747.idx.4.1
  store i64 %q_stage.sroa.26.36.insert.insert1698, ptr addrspace(3) %gep747.4.1, align 8
  %add138.5.1 = add nuw nsw i32 %shr137, 10
  %xor.5.1 = xor i32 %add138.5.1, %shr134
  %147 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 2560
  %gep747.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4
  %gep747.5.1 = getelementptr inbounds i8, ptr addrspace(3) %147, i32 %gep747.idx.5.1
  store i64 %q_stage.sroa.32.44.insert.insert1708, ptr addrspace(3) %gep747.5.1, align 8
  %add138.6.1 = add nuw nsw i32 %shr137, 12
  %xor.6.1 = xor i32 %add138.6.1, %shr134
  %148 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 3072
  %gep747.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4
  %gep747.6.1 = getelementptr inbounds i8, ptr addrspace(3) %148, i32 %gep747.idx.6.1
  store i64 %q_stage.sroa.38.52.insert.insert1718, ptr addrspace(3) %gep747.6.1, align 8
  %add138.7.1 = add nuw nsw i32 %shr137, 14
  %xor.7.1 = xor i32 %add138.7.1, %shr134
  %149 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 3584
  %gep747.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4
  %gep747.7.1 = getelementptr inbounds i8, ptr addrspace(3) %149, i32 %gep747.idx.7.1
  store i64 %q_stage.sroa.44.60.insert.insert1728, ptr addrspace(3) %gep747.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor164.1826 = xor i32 %shr160, %and163
  %.idx.1827 = shl nuw nsw i32 %xor164.1826, 4
  %gep750.1828 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.1827
  %q.sroa.0.0.copyload1601 = load <4 x half>, ptr addrspace(3) %gep750.1828, align 16
  %q.sroa.6.0.gep750.1828.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1828, i32 8
  %q.sroa.6.0.copyload1602 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep750.1828.sroa_idx, align 8
  %add161.1.1 = add nuw nsw i32 %shr160, 4
  %xor164.1.1 = xor i32 %add161.1.1, %and163
  %.idx.1.1 = shl nuw nsw i32 %xor164.1.1, 4
  %gep750.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.1.1
  %q.sroa.8.16.copyload1605 = load <4 x half>, ptr addrspace(3) %gep750.1.1, align 16
  %q.sroa.12.16.gep750.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1.1, i32 8
  %q.sroa.12.16.copyload1606 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep750.1.1.sroa_idx, align 8
  %add161.2.1 = add nuw nsw i32 %shr160, 8
  %xor164.2.1 = xor i32 %add161.2.1, %and163
  %.idx.2.1 = shl nuw nsw i32 %xor164.2.1, 4
  %gep750.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.2.1
  %q.sroa.14.32.copyload1609 = load <4 x half>, ptr addrspace(3) %gep750.2.1, align 16
  %q.sroa.18.32.gep750.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.2.1, i32 8
  %q.sroa.18.32.copyload1610 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep750.2.1.sroa_idx, align 8
  %add161.3.1 = add nuw nsw i32 %shr160, 12
  %xor164.3.1 = xor i32 %add161.3.1, %and163
  %.idx.3.1 = shl nuw nsw i32 %xor164.3.1, 4
  %gep750.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.3.1
  %q.sroa.20.48.copyload1613 = load <4 x half>, ptr addrspace(3) %gep750.3.1, align 16
  %q.sroa.24.48.gep750.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.3.1, i32 8
  %q.sroa.24.48.copyload1614 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep750.3.1.sroa_idx, align 8
  %cmp197.not.1829 = icmp sgt i32 %add190, %7
  %spec.select.1830 = select i1 %cmp197.not.1829, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1396 = insertelement <4 x float> poison, float %spec.select.1830, i64 0
  %cmp197.not.1.1.not = icmp slt i32 %add190, %7
  %spec.select.1.1 = select i1 %cmp197.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1421 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1396, float %spec.select.1.1, i64 1
  %add194.2.1 = or disjoint i32 %add190, 2
  %cmp197.not.2.1 = icmp sgt i32 %add194.2.1, %7
  %spec.select.2.1 = select i1 %cmp197.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1446 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1421, float %spec.select.2.1, i64 2
  %add194.3.1 = or disjoint i32 %add190, 3
  %cmp197.not.3.1 = icmp sgt i32 %add194.3.1, %7
  %spec.select.3.1 = select i1 %cmp197.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1471 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1446, float %spec.select.3.1, i64 3
  %add196.4.1 = add nuw nsw i32 %add190, 16
  %cmp197.not.4.1 = icmp sgt i32 %add196.4.1, %7
  %spec.select.4.1 = select i1 %cmp197.not.4.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.16.vec.insert1512 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0
  %add196.5.1 = add nuw nsw i32 %add190, 17
  %cmp197.not.5.1 = icmp sgt i32 %add196.5.1, %7
  %spec.select.5.1 = select i1 %cmp197.not.5.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.20.vec.insert1537 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1512, float %spec.select.5.1, i64 1
  %add196.6.1 = add nuw nsw i32 %add190, 18
  %cmp197.not.6.1 = icmp sgt i32 %add196.6.1, %7
  %spec.select.6.1 = select i1 %cmp197.not.6.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.24.vec.insert1562 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1537, float %spec.select.6.1, i64 2
  %add196.7.1 = add nuw nsw i32 %add190, 19
  %cmp197.not.7.1 = icmp sgt i32 %add196.7.1, %7
  %spec.select.7.1 = select i1 %cmp197.not.7.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.90.28.vec.insert1587 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1562, float %spec.select.7.1, i64 3
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.1, <4 x half> %q.sroa.0.0.copyload1601, <4 x float> %scores.sroa.0.12.vec.insert1471)
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.1, <4 x half> %q.sroa.0.0.copyload1601, <4 x float> %scores.sroa.90.28.vec.insert1587)
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.1, <4 x half> %q.sroa.6.0.copyload1602, <4 x float> %150)
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.1, <4 x half> %q.sroa.6.0.copyload1602, <4 x float> %151)
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.1, <4 x half> %q.sroa.8.16.copyload1605, <4 x float> %152)
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.1, <4 x half> %q.sroa.8.16.copyload1605, <4 x float> %153)
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.1, <4 x half> %q.sroa.12.16.copyload1606, <4 x float> %154)
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.1, <4 x half> %q.sroa.12.16.copyload1606, <4 x float> %155)
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.1, <4 x half> %q.sroa.14.32.copyload1609, <4 x float> %156)
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.1, <4 x half> %q.sroa.14.32.copyload1609, <4 x float> %157)
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.1, <4 x half> %q.sroa.18.32.copyload1610, <4 x float> %158)
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.1, <4 x half> %q.sroa.18.32.copyload1610, <4 x float> %159)
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.1, <4 x half> %q.sroa.20.48.copyload1613, <4 x float> %160)
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.1, <4 x half> %q.sroa.20.48.copyload1613, <4 x float> %161)
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.1, <4 x half> %q.sroa.24.48.copyload1614, <4 x float> %162)
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.1, <4 x half> %q.sroa.24.48.copyload1614, <4 x float> %163)
  %.idx793.1838 = shl nuw nsw i64 %shr, 19
  %166 = getelementptr i8, ptr addrspace(4) %gep769, i64 %.idx793.1838
  %167 = getelementptr %struct.__half, ptr addrspace(4) %166, i64 %mul102
  %v.sroa.48.112.gep759.7.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 7176
  %v.sroa.48.112.copyload1760 = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep759.7.1.sroa_idx, align 8
  %gep759.7.1 = getelementptr i8, ptr addrspace(4) %167, i64 7168
  %v.sroa.44.112.copyload1759 = load <4 x half>, ptr addrspace(4) %gep759.7.1, align 16
  %v.sroa.42.96.gep759.6.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 6152
  %v.sroa.42.96.copyload1756 = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep759.6.1.sroa_idx, align 8
  %gep759.6.1 = getelementptr i8, ptr addrspace(4) %167, i64 6144
  %v.sroa.38.96.copyload1755 = load <4 x half>, ptr addrspace(4) %gep759.6.1, align 16
  %v.sroa.36.80.gep759.5.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 5128
  %v.sroa.36.80.copyload1752 = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep759.5.1.sroa_idx, align 8
  %gep759.5.1 = getelementptr i8, ptr addrspace(4) %167, i64 5120
  %v.sroa.32.80.copyload1751 = load <4 x half>, ptr addrspace(4) %gep759.5.1, align 16
  %v.sroa.30.64.gep759.4.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 4104
  %v.sroa.30.64.copyload1748 = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep759.4.1.sroa_idx, align 8
  %gep759.4.1 = getelementptr i8, ptr addrspace(4) %167, i64 4096
  %v.sroa.26.64.copyload1747 = load <4 x half>, ptr addrspace(4) %gep759.4.1, align 16
  %v.sroa.24.48.gep759.3.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 3080
  %v.sroa.24.48.copyload1744 = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep759.3.1.sroa_idx, align 8
  %gep759.3.1 = getelementptr i8, ptr addrspace(4) %167, i64 3072
  %v.sroa.20.48.copyload1743 = load <4 x half>, ptr addrspace(4) %gep759.3.1, align 16
  %v.sroa.18.32.gep759.2.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 2056
  %v.sroa.18.32.copyload1740 = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep759.2.1.sroa_idx, align 8
  %gep759.2.1 = getelementptr i8, ptr addrspace(4) %167, i64 2048
  %v.sroa.14.32.copyload1739 = load <4 x half>, ptr addrspace(4) %gep759.2.1, align 16
  %v.sroa.12.16.gep759.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 1032
  %v.sroa.12.16.copyload1736 = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep759.1.1.sroa_idx, align 8
  %gep759.1.1 = getelementptr i8, ptr addrspace(4) %167, i64 1024
  %v.sroa.8.16.copyload1735 = load <4 x half>, ptr addrspace(4) %gep759.1.1, align 16
  %v.sroa.6.0..sroa_idx1731 = getelementptr inbounds i8, ptr addrspace(4) %167, i64 8
  %v.sroa.6.0.copyload1732 = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx1731, align 8
  %v.sroa.0.0.copyload1730 = load <4 x half>, ptr addrspace(4) %167, align 16
  %scores.sroa.0.0.vec.extract1398 = extractelement <4 x float> %164, i64 0
  %mul283.1839 = fmul contract float %scores.sroa.0.0.vec.extract1398, 0x3FC2776C60000000
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul283.1839, float 1.500000e+01)
  %cmp.i.i.1840 = fcmp contract olt float %168, -1.260000e+02
  %cond.i.i.1841 = select contract i1 %cmp.i.i.1840, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.1842 = fadd contract float %168, %cond.i.i.1841
  %169 = tail call contract float @llvm.exp2.f32(float %add.i.i730.1842)
  %cond2.i.i.1843 = select contract i1 %cmp.i.i.1840, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1844 = fmul contract float %cond2.i.i.1843, %169
  %scores.sroa.0.4.vec.extract1423 = extractelement <4 x float> %164, i64 1
  %mul283.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1423, 0x3FC2776C60000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul283.1.1, float 1.500000e+01)
  %cmp.i.i.1.1 = fcmp contract olt float %170, -1.260000e+02
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.1.1 = fadd contract float %170, %cond.i.i.1.1
  %171 = tail call contract float @llvm.exp2.f32(float %add.i.i730.1.1)
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %171
  %scores.sroa.0.8.vec.extract1448 = extractelement <4 x float> %164, i64 2
  %mul283.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1448, 0x3FC2776C60000000
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul283.2.1, float 1.500000e+01)
  %cmp.i.i.2.1 = fcmp contract olt float %172, -1.260000e+02
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.2.1 = fadd contract float %172, %cond.i.i.2.1
  %173 = tail call contract float @llvm.exp2.f32(float %add.i.i730.2.1)
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %173
  %scores.sroa.0.12.vec.extract1473 = extractelement <4 x float> %164, i64 3
  %mul283.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1473, 0x3FC2776C60000000
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul283.3.1, float 1.500000e+01)
  %cmp.i.i.3.1 = fcmp contract olt float %174, -1.260000e+02
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.3.1 = fadd contract float %174, %cond.i.i.3.1
  %175 = tail call contract float @llvm.exp2.f32(float %add.i.i730.3.1)
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %175
  %scores.sroa.90.16.vec.extract1514 = extractelement <4 x float> %165, i64 0
  %mul283.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1514, 0x3FC2776C60000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul283.4.1, float 1.500000e+01)
  %cmp.i.i.4.1 = fcmp contract olt float %176, -1.260000e+02
  %cond.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.4.1 = fadd contract float %176, %cond.i.i.4.1
  %177 = tail call contract float @llvm.exp2.f32(float %add.i.i730.4.1)
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %177
  %scores.sroa.90.20.vec.extract1539 = extractelement <4 x float> %165, i64 1
  %mul283.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1539, 0x3FC2776C60000000
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul283.5.1, float 1.500000e+01)
  %cmp.i.i.5.1 = fcmp contract olt float %178, -1.260000e+02
  %cond.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.5.1 = fadd contract float %178, %cond.i.i.5.1
  %179 = tail call contract float @llvm.exp2.f32(float %add.i.i730.5.1)
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %179
  %scores.sroa.90.24.vec.extract1564 = extractelement <4 x float> %165, i64 2
  %mul283.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1564, 0x3FC2776C60000000
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul283.6.1, float 1.500000e+01)
  %cmp.i.i.6.1 = fcmp contract olt float %180, -1.260000e+02
  %cond.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.6.1 = fadd contract float %180, %cond.i.i.6.1
  %181 = tail call contract float @llvm.exp2.f32(float %add.i.i730.6.1)
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %181
  %scores.sroa.90.28.vec.extract1589 = extractelement <4 x float> %165, i64 3
  %mul283.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1589, 0x3FC2776C60000000
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul283.7.1, float 1.500000e+01)
  %cmp.i.i.7.1 = fcmp contract olt float %182, -1.260000e+02
  %cond.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i730.7.1 = fadd contract float %182, %cond.i.i.7.1
  %183 = tail call contract float @llvm.exp2.f32(float %add.i.i730.7.1)
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %183
  %add303.1845 = fadd contract float %mul.i.i.1844, 0.000000e+00
  %add303.1.1 = fadd contract float %add303.1845, %mul.i.i.4.1
  %add303.2.1 = fadd contract float %add303.1.1, %mul.i.i.1.1
  %add303.3.1 = fadd contract float %add303.2.1, %mul.i.i.5.1
  %add303.4.1 = fadd contract float %add303.3.1, %mul.i.i.2.1
  %add303.5.1 = fadd contract float %add303.4.1, %mul.i.i.6.1
  %add303.6.1 = fadd contract float %add303.5.1, %mul.i.i.3.1
  %add303.7.1 = fadd contract float %add303.6.1, %mul.i.i.7.1
  %184 = bitcast float %add303.7.1 to i32
  %185 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %186 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %185) #11
  %xor.i.i.1 = xor i32 %186, 32
  %187 = and i32 %186, -64
  %and.i.i.1 = add nsw i32 %187, 64
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1
  %cond.i.i731.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %186
  %shl.i.i.1 = shl i32 %cond.i.i731.1, 2
  %188 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %184)
  %189 = bitcast i32 %188 to float
  %add.i.1 = fadd contract float %add303.7.1, %189
  %190 = bitcast float %add.i.1 to i32
  %191 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %192 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %191) #11
  %xor.i.i732.1 = xor i32 %192, 16
  %193 = and i32 %192, -64
  %and.i.i733.1 = add nsw i32 %193, 64
  %cmp.not.i.i734.1 = icmp slt i32 %xor.i.i732.1, %and.i.i733.1
  %cond.i.i735.1 = select i1 %cmp.not.i.i734.1, i32 %xor.i.i732.1, i32 %192
  %shl.i.i736.1 = shl i32 %cond.i.i735.1, 2
  %194 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i736.1, i32 %190)
  %195 = bitcast i32 %194 to float
  %add.i.i.1 = fadd contract float %add.i.1, %195
  %cmp312.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1
  %condval_8.0.1 = select i1 %cmp312.1, float %div.1, float 0.000000e+00
  %mul325.1846 = fmul contract float %condval_8.0.1, %mul.i.i.1844
  %mul325.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1
  %mul325.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1
  %mul325.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1
  %mul325.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1
  %mul325.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1
  %mul325.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1
  %mul325.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.1846)
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.1.1)
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.2.1)
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.3.1)
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.4.1)
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.5.1)
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.6.1)
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.7.1)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %204 = insertelement <4 x i16> poison, i16 %196, i64 0
  %205 = insertelement <4 x i16> %204, i16 %197, i64 1
  %206 = insertelement <4 x i16> %205, i16 %198, i64 2
  %207 = insertelement <4 x i16> %206, i16 %199, i64 3
  %208 = bitcast <4 x i16> %207 to <4 x half>
  %209 = insertelement <4 x i16> poison, i16 %200, i64 0
  %210 = insertelement <4 x i16> %209, i16 %201, i64 1
  %211 = insertelement <4 x i16> %210, i16 %202, i64 2
  %212 = insertelement <4 x i16> %211, i16 %203, i64 3
  %213 = bitcast <4 x i16> %212 to <4 x half>
  br label %if.end357.1

if.end357.1:                                      ; preds = %if.end119.1, %if.end79.7.1, %if.end357
  %v.sroa.48.3 = phi <4 x half> [ %v.sroa.48.112.copyload1760, %if.end119.1 ], [ %v.sroa.48.1, %if.end79.7.1 ], [ %v.sroa.48.1, %if.end357 ]
  %v.sroa.44.3 = phi <4 x half> [ %v.sroa.44.112.copyload1759, %if.end119.1 ], [ %v.sroa.44.1, %if.end79.7.1 ], [ %v.sroa.44.1, %if.end357 ]
  %v.sroa.42.3 = phi <4 x half> [ %v.sroa.42.96.copyload1756, %if.end119.1 ], [ %v.sroa.42.1, %if.end79.7.1 ], [ %v.sroa.42.1, %if.end357 ]
  %v.sroa.38.3 = phi <4 x half> [ %v.sroa.38.96.copyload1755, %if.end119.1 ], [ %v.sroa.38.1, %if.end79.7.1 ], [ %v.sroa.38.1, %if.end357 ]
  %v.sroa.36.3 = phi <4 x half> [ %v.sroa.36.80.copyload1752, %if.end119.1 ], [ %v.sroa.36.1, %if.end79.7.1 ], [ %v.sroa.36.1, %if.end357 ]
  %v.sroa.32.3 = phi <4 x half> [ %v.sroa.32.80.copyload1751, %if.end119.1 ], [ %v.sroa.32.1, %if.end79.7.1 ], [ %v.sroa.32.1, %if.end357 ]
  %v.sroa.30.3 = phi <4 x half> [ %v.sroa.30.64.copyload1748, %if.end119.1 ], [ %v.sroa.30.1, %if.end79.7.1 ], [ %v.sroa.30.1, %if.end357 ]
  %v.sroa.26.3 = phi <4 x half> [ %v.sroa.26.64.copyload1747, %if.end119.1 ], [ %v.sroa.26.1, %if.end79.7.1 ], [ %v.sroa.26.1, %if.end357 ]
  %v.sroa.24.3 = phi <4 x half> [ %v.sroa.24.48.copyload1744, %if.end119.1 ], [ %v.sroa.24.1, %if.end79.7.1 ], [ %v.sroa.24.1, %if.end357 ]
  %v.sroa.20.3 = phi <4 x half> [ %v.sroa.20.48.copyload1743, %if.end119.1 ], [ %v.sroa.20.1, %if.end79.7.1 ], [ %v.sroa.20.1, %if.end357 ]
  %v.sroa.18.3 = phi <4 x half> [ %v.sroa.18.32.copyload1740, %if.end119.1 ], [ %v.sroa.18.1, %if.end79.7.1 ], [ %v.sroa.18.1, %if.end357 ]
  %v.sroa.14.3 = phi <4 x half> [ %v.sroa.14.32.copyload1739, %if.end119.1 ], [ %v.sroa.14.1, %if.end79.7.1 ], [ %v.sroa.14.1, %if.end357 ]
  %v.sroa.12.3 = phi <4 x half> [ %v.sroa.12.16.copyload1736, %if.end119.1 ], [ %v.sroa.12.1, %if.end79.7.1 ], [ %v.sroa.12.1, %if.end357 ]
  %v.sroa.8.3 = phi <4 x half> [ %v.sroa.8.16.copyload1735, %if.end119.1 ], [ %v.sroa.8.1, %if.end79.7.1 ], [ %v.sroa.8.1, %if.end357 ]
  %v.sroa.6.3 = phi <4 x half> [ %v.sroa.6.0.copyload1732, %if.end119.1 ], [ %v.sroa.6.1, %if.end79.7.1 ], [ %v.sroa.6.1, %if.end357 ]
  %v.sroa.0.3 = phi <4 x half> [ %v.sroa.0.0.copyload1730, %if.end119.1 ], [ %v.sroa.0.1, %if.end79.7.1 ], [ %v.sroa.0.1, %if.end357 ]
  %214 = phi <4 x half> [ %213, %if.end119.1 ], [ undef, %if.end79.7.1 ], [ undef, %if.end357 ]
  %215 = phi <4 x half> [ %208, %if.end119.1 ], [ undef, %if.end79.7.1 ], [ undef, %if.end357 ]
  %mul510 = and i32 %13, 4
  %mul538 = and i32 %12, 8064
  %invariant.gep780 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul538
  %216 = shl nuw nsw i32 %1, 18
  %mul553 = and i32 %216, 2145386496
  %add555 = or disjoint i32 %mul553, %12
  br i1 %cmp32, label %if.then370, label %if.end567

if.then370:                                       ; preds = %if.end357.1
  %cmp380 = icmp ule i32 %mul88, %6
  %or.cond786 = select i1 %cmp87, i1 %cmp380, i1 false
  br i1 %or.cond786, label %for.cond385.preheader, label %if.end486

for.cond385.preheader:                            ; preds = %if.then370
  %217 = insertelement <4 x i16> poison, i16 %pair_prob.sroa.0.0, i64 0
  %218 = insertelement <4 x i16> %217, i16 %pair_prob.sroa.4.0, i64 1
  %219 = insertelement <4 x i16> %218, i16 %pair_prob.sroa.6.0, i64 2
  %220 = insertelement <4 x i16> %219, i16 %pair_prob.sroa.8.0, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %220 to <4 x half>
  %221 = insertelement <4 x i16> poison, i16 %pair_prob.sroa.10.0, i64 0
  %222 = insertelement <4 x i16> %221, i16 %pair_prob.sroa.12.0, i64 1
  %223 = insertelement <4 x i16> %222, i16 %pair_prob.sroa.14.0, i64 2
  %224 = insertelement <4 x i16> %223, i16 %pair_prob.sroa.16.0, i64 3
  %prob.sroa.12.14.vec.insert = bitcast <4 x i16> %224 to <4 x half>
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %225)
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %226)
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %227)
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %228)
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %229)
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %230)
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %231)
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %232)
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %233, i64 0
  %241 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %241 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %233, i64 1
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %242 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %233, i64 2
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %243 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert1113 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %233, i64 3
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %244 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1113, %output_reg.sroa.0.6.insert.shift
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %234, i64 0
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract)
  %output_reg.sroa.16.8.insert.ext = zext i16 %245 to i64
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %234, i64 1
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract)
  %output_reg.sroa.16.10.insert.ext = zext i16 %246 to i64
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %234, i64 2
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract)
  %output_reg.sroa.16.12.insert.ext = zext i16 %247 to i64
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32
  %output_reg.sroa.16.12.insert.insert1145 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %234, i64 3
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract)
  %output_reg.sroa.16.14.insert.ext = zext i16 %248 to i64
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1145, %output_reg.sroa.16.14.insert.shift
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %235, i64 0
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract)
  %output_reg.sroa.30.16.insert.ext = zext i16 %249 to i64
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %235, i64 1
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract)
  %output_reg.sroa.30.18.insert.ext = zext i16 %250 to i64
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %235, i64 2
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract)
  %output_reg.sroa.30.20.insert.ext = zext i16 %251 to i64
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32
  %output_reg.sroa.30.20.insert.insert1177 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %235, i64 3
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract)
  %output_reg.sroa.30.22.insert.ext = zext i16 %252 to i64
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1177, %output_reg.sroa.30.22.insert.shift
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %236, i64 0
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract)
  %output_reg.sroa.44.24.insert.ext = zext i16 %253 to i64
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %236, i64 1
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract)
  %output_reg.sroa.44.26.insert.ext = zext i16 %254 to i64
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %236, i64 2
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract)
  %output_reg.sroa.44.28.insert.ext = zext i16 %255 to i64
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32
  %output_reg.sroa.44.28.insert.insert1209 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %236, i64 3
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract)
  %output_reg.sroa.44.30.insert.ext = zext i16 %256 to i64
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1209, %output_reg.sroa.44.30.insert.shift
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %237, i64 0
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract)
  %output_reg.sroa.58.32.insert.ext = zext i16 %257 to i64
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %237, i64 1
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract)
  %output_reg.sroa.58.34.insert.ext = zext i16 %258 to i64
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %237, i64 2
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract)
  %output_reg.sroa.58.36.insert.ext = zext i16 %259 to i64
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32
  %output_reg.sroa.58.36.insert.insert1241 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %237, i64 3
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract)
  %output_reg.sroa.58.38.insert.ext = zext i16 %260 to i64
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1241, %output_reg.sroa.58.38.insert.shift
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %238, i64 0
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract)
  %output_reg.sroa.72.40.insert.ext = zext i16 %261 to i64
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %238, i64 1
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract)
  %output_reg.sroa.72.42.insert.ext = zext i16 %262 to i64
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %238, i64 2
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract)
  %output_reg.sroa.72.44.insert.ext = zext i16 %263 to i64
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32
  %output_reg.sroa.72.44.insert.insert1273 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %238, i64 3
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract)
  %output_reg.sroa.72.46.insert.ext = zext i16 %264 to i64
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1273, %output_reg.sroa.72.46.insert.shift
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %239, i64 0
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract)
  %output_reg.sroa.86.48.insert.ext = zext i16 %265 to i64
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %239, i64 1
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract)
  %output_reg.sroa.86.50.insert.ext = zext i16 %266 to i64
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %239, i64 2
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract)
  %output_reg.sroa.86.52.insert.ext = zext i16 %267 to i64
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32
  %output_reg.sroa.86.52.insert.insert1305 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %239, i64 3
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract)
  %output_reg.sroa.86.54.insert.ext = zext i16 %268 to i64
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1305, %output_reg.sroa.86.54.insert.shift
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %240, i64 0
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract)
  %output_reg.sroa.100.56.insert.ext = zext i16 %269 to i64
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %240, i64 1
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract)
  %output_reg.sroa.100.58.insert.ext = zext i16 %270 to i64
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %240, i64 2
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract)
  %output_reg.sroa.100.60.insert.ext = zext i16 %271 to i64
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32
  %output_reg.sroa.100.60.insert.insert1337 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %240, i64 3
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract)
  %output_reg.sroa.100.62.insert.ext = zext i16 %272 to i64
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1337, %output_reg.sroa.100.62.insert.shift
  br label %if.end486

if.end486:                                        ; preds = %if.then370, %for.cond385.preheader
  %output_reg.sroa.100.0 = phi i64 [ %output_reg.sroa.100.62.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  %output_reg.sroa.86.0 = phi i64 [ %output_reg.sroa.86.54.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  %output_reg.sroa.72.0 = phi i64 [ %output_reg.sroa.72.46.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  %output_reg.sroa.58.0 = phi i64 [ %output_reg.sroa.58.38.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.30.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.22.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.14.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor504 = xor i32 %shr137, %and163
  %mul505 = shl nuw nsw i32 %xor504, 3
  %add506 = add nuw nsw i32 %mul505, %mul157
  %add511 = or disjoint i32 %add506, %mul510
  %add.ptr513 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr513, align 8
  %add501.1 = add nuw nsw i32 %shr137, 2
  %xor504.1 = xor i32 %add501.1, %and163
  %mul505.1 = shl nuw nsw i32 %xor504.1, 3
  %add506.1 = add nuw nsw i32 %mul505.1, %mul157
  %add511.1 = or disjoint i32 %add506.1, %mul510
  %add.ptr513.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.1
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr513.1, align 8
  %add501.2 = add nuw nsw i32 %shr137, 4
  %xor504.2 = xor i32 %add501.2, %and163
  %mul505.2 = shl nuw nsw i32 %xor504.2, 3
  %add506.2 = add nuw nsw i32 %mul505.2, %mul157
  %add511.2 = or disjoint i32 %add506.2, %mul510
  %add.ptr513.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.2
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr513.2, align 8
  %add501.3 = add nuw nsw i32 %shr137, 6
  %xor504.3 = xor i32 %add501.3, %and163
  %mul505.3 = shl nuw nsw i32 %xor504.3, 3
  %add506.3 = add nuw nsw i32 %mul505.3, %mul157
  %add511.3 = or disjoint i32 %add506.3, %mul510
  %add.ptr513.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.3
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr513.3, align 8
  %add501.4 = add nuw nsw i32 %shr137, 8
  %xor504.4 = xor i32 %add501.4, %and163
  %mul505.4 = shl nuw nsw i32 %xor504.4, 3
  %add506.4 = add nuw nsw i32 %mul505.4, %mul157
  %add511.4 = or disjoint i32 %add506.4, %mul510
  %add.ptr513.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.4
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr513.4, align 8
  %add501.5 = add nuw nsw i32 %shr137, 10
  %xor504.5 = xor i32 %add501.5, %and163
  %mul505.5 = shl nuw nsw i32 %xor504.5, 3
  %add506.5 = add nuw nsw i32 %mul505.5, %mul157
  %add511.5 = or disjoint i32 %add506.5, %mul510
  %add.ptr513.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.5
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr513.5, align 8
  %add501.6 = add nuw nsw i32 %shr137, 12
  %xor504.6 = xor i32 %add501.6, %and163
  %mul505.6 = shl nuw nsw i32 %xor504.6, 3
  %add506.6 = add nuw nsw i32 %mul505.6, %mul157
  %add511.6 = or disjoint i32 %add506.6, %mul510
  %add.ptr513.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.6
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr513.6, align 8
  %add501.7 = add nuw nsw i32 %shr137, 14
  %xor504.7 = xor i32 %add501.7, %and163
  %mul505.7 = shl nuw nsw i32 %xor504.7, 3
  %add506.7 = add nuw nsw i32 %mul505.7, %mul157
  %add511.7 = or disjoint i32 %add506.7, %mul510
  %add.ptr513.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.7
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr513.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %cmp525 = icmp slt i32 %6, 1024
  br i1 %cmp525, label %for.body520.us.preheader, label %for.cond.cleanup519

for.body520.us.preheader:                         ; preds = %if.end486
  %mul554 = shl nuw nsw i32 %6, 11
  %add557 = add nuw nsw i32 %add555, %mul554
  %273 = zext nneg i32 %add557 to i64
  %xor546.us = xor i32 %shr160, %and163
  %add.ptr550.idx.us = shl nuw nsw i32 %xor546.us, 4
  %add.ptr550.us = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 %add.ptr550.idx.us
  %add.ptr562.us = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  %274 = add nuw nsw i32 %shr160, 4
  %xor546.us.1 = xor i32 %274, %and163
  %gep781.us.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1024
  %add.ptr550.idx.us.1 = shl nuw nsw i32 %xor546.us.1, 4
  %add.ptr550.us.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.1, i32 %add.ptr550.idx.us.1
  %275 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273
  %add.ptr562.us.1 = getelementptr inbounds i8, ptr addrspace(1) %275, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.1, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  %276 = add nuw nsw i32 %shr160, 8
  %xor546.us.2 = xor i32 %276, %and163
  %gep781.us.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2048
  %add.ptr550.idx.us.2 = shl nuw nsw i32 %xor546.us.2, 4
  %add.ptr550.us.2 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.2, i32 %add.ptr550.idx.us.2
  %277 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273
  %add.ptr562.us.2 = getelementptr inbounds i8, ptr addrspace(1) %277, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.2, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  %278 = add nuw nsw i32 %shr160, 12
  %xor546.us.3 = xor i32 %278, %and163
  %gep781.us.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3072
  %add.ptr550.idx.us.3 = shl nuw nsw i32 %xor546.us.3, 4
  %add.ptr550.us.3 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.3, i32 %add.ptr550.idx.us.3
  %279 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273
  %add.ptr562.us.3 = getelementptr inbounds i8, ptr addrspace(1) %279, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.3, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  br label %for.cond.cleanup519

for.cond.cleanup519:                              ; preds = %if.end486, %for.body520.us.preheader
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end567

if.end567:                                        ; preds = %for.cond.cleanup519, %if.end357.1
  br i1 %cmp32.1, label %if.then370.1, label %if.end571

if.then370.1:                                     ; preds = %if.end567
  %cmp380.1 = icmp ule i32 %mul88, %7
  %or.cond786.1 = select i1 %cmp87, i1 %cmp380.1, i1 false
  br i1 %or.cond786.1, label %for.cond385.preheader.1, label %if.end486.1

for.cond385.preheader.1:                          ; preds = %if.then370.1
  %280 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %215, <4 x float> zeroinitializer)
  %281 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %215, <4 x float> zeroinitializer)
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %215, <4 x float> zeroinitializer)
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %215, <4 x float> zeroinitializer)
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %215, <4 x float> zeroinitializer)
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %215, <4 x float> zeroinitializer)
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %215, <4 x float> zeroinitializer)
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %215, <4 x float> zeroinitializer)
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %214, <4 x float> %280)
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %214, <4 x float> %281)
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %214, <4 x float> %282)
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %214, <4 x float> %283)
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %214, <4 x float> %284)
  %293 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %214, <4 x float> %285)
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %214, <4 x float> %286)
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %214, <4 x float> %287)
  %out.sroa.0.0.vec.extract908 = extractelement <4 x float> %288, i64 0
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract908)
  %output_reg.sroa.0.0.insert.ext1100 = zext i16 %296 to i64
  %out.sroa.0.4.vec.extract913 = extractelement <4 x float> %288, i64 1
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract913)
  %output_reg.sroa.0.2.insert.ext1104 = zext i16 %297 to i64
  %output_reg.sroa.0.2.insert.shift1105 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1104, 16
  %output_reg.sroa.0.2.insert.insert1107 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1105, %output_reg.sroa.0.0.insert.ext1100
  %out.sroa.0.8.vec.extract918 = extractelement <4 x float> %288, i64 2
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract918)
  %output_reg.sroa.0.4.insert.ext1115 = zext i16 %298 to i64
  %output_reg.sroa.0.4.insert.shift1116 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1115, 32
  %output_reg.sroa.0.4.insert.insert1118 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1107, %output_reg.sroa.0.4.insert.shift1116
  %out.sroa.0.12.vec.extract923 = extractelement <4 x float> %288, i64 3
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract923)
  %output_reg.sroa.0.6.insert.ext1120 = zext i16 %299 to i64
  %output_reg.sroa.0.6.insert.shift1121 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1120, 48
  %output_reg.sroa.0.6.insert.insert1123 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1118, %output_reg.sroa.0.6.insert.shift1121
  %out.sroa.26.16.vec.extract932 = extractelement <4 x float> %289, i64 0
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract932)
  %output_reg.sroa.16.8.insert.ext1132 = zext i16 %300 to i64
  %out.sroa.26.20.vec.extract937 = extractelement <4 x float> %289, i64 1
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract937)
  %output_reg.sroa.16.10.insert.ext1136 = zext i16 %301 to i64
  %output_reg.sroa.16.10.insert.shift1137 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1136, 16
  %output_reg.sroa.16.10.insert.insert1139 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1137, %output_reg.sroa.16.8.insert.ext1132
  %out.sroa.26.24.vec.extract942 = extractelement <4 x float> %289, i64 2
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract942)
  %output_reg.sroa.16.12.insert.ext1147 = zext i16 %302 to i64
  %output_reg.sroa.16.12.insert.shift1148 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1147, 32
  %output_reg.sroa.16.12.insert.insert1150 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1139, %output_reg.sroa.16.12.insert.shift1148
  %out.sroa.26.28.vec.extract947 = extractelement <4 x float> %289, i64 3
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract947)
  %output_reg.sroa.16.14.insert.ext1152 = zext i16 %303 to i64
  %output_reg.sroa.16.14.insert.shift1153 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1152, 48
  %output_reg.sroa.16.14.insert.insert1155 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1150, %output_reg.sroa.16.14.insert.shift1153
  %out.sroa.50.32.vec.extract956 = extractelement <4 x float> %290, i64 0
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract956)
  %output_reg.sroa.30.16.insert.ext1164 = zext i16 %304 to i64
  %out.sroa.50.36.vec.extract961 = extractelement <4 x float> %290, i64 1
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract961)
  %output_reg.sroa.30.18.insert.ext1168 = zext i16 %305 to i64
  %output_reg.sroa.30.18.insert.shift1169 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1168, 16
  %output_reg.sroa.30.18.insert.insert1171 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1169, %output_reg.sroa.30.16.insert.ext1164
  %out.sroa.50.40.vec.extract966 = extractelement <4 x float> %290, i64 2
  %306 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract966)
  %output_reg.sroa.30.20.insert.ext1179 = zext i16 %306 to i64
  %output_reg.sroa.30.20.insert.shift1180 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1179, 32
  %output_reg.sroa.30.20.insert.insert1182 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1171, %output_reg.sroa.30.20.insert.shift1180
  %out.sroa.50.44.vec.extract971 = extractelement <4 x float> %290, i64 3
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract971)
  %output_reg.sroa.30.22.insert.ext1184 = zext i16 %307 to i64
  %output_reg.sroa.30.22.insert.shift1185 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1184, 48
  %output_reg.sroa.30.22.insert.insert1187 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1182, %output_reg.sroa.30.22.insert.shift1185
  %out.sroa.74.48.vec.extract980 = extractelement <4 x float> %291, i64 0
  %308 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract980)
  %output_reg.sroa.44.24.insert.ext1196 = zext i16 %308 to i64
  %out.sroa.74.52.vec.extract985 = extractelement <4 x float> %291, i64 1
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract985)
  %output_reg.sroa.44.26.insert.ext1200 = zext i16 %309 to i64
  %output_reg.sroa.44.26.insert.shift1201 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1200, 16
  %output_reg.sroa.44.26.insert.insert1203 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1201, %output_reg.sroa.44.24.insert.ext1196
  %out.sroa.74.56.vec.extract990 = extractelement <4 x float> %291, i64 2
  %310 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract990)
  %output_reg.sroa.44.28.insert.ext1211 = zext i16 %310 to i64
  %output_reg.sroa.44.28.insert.shift1212 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1211, 32
  %output_reg.sroa.44.28.insert.insert1214 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1203, %output_reg.sroa.44.28.insert.shift1212
  %out.sroa.74.60.vec.extract995 = extractelement <4 x float> %291, i64 3
  %311 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract995)
  %output_reg.sroa.44.30.insert.ext1216 = zext i16 %311 to i64
  %output_reg.sroa.44.30.insert.shift1217 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1216, 48
  %output_reg.sroa.44.30.insert.insert1219 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1214, %output_reg.sroa.44.30.insert.shift1217
  %out.sroa.98.64.vec.extract1004 = extractelement <4 x float> %292, i64 0
  %312 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract1004)
  %output_reg.sroa.58.32.insert.ext1228 = zext i16 %312 to i64
  %out.sroa.98.68.vec.extract1009 = extractelement <4 x float> %292, i64 1
  %313 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract1009)
  %output_reg.sroa.58.34.insert.ext1232 = zext i16 %313 to i64
  %output_reg.sroa.58.34.insert.shift1233 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1232, 16
  %output_reg.sroa.58.34.insert.insert1235 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1233, %output_reg.sroa.58.32.insert.ext1228
  %out.sroa.98.72.vec.extract1014 = extractelement <4 x float> %292, i64 2
  %314 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract1014)
  %output_reg.sroa.58.36.insert.ext1243 = zext i16 %314 to i64
  %output_reg.sroa.58.36.insert.shift1244 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1243, 32
  %output_reg.sroa.58.36.insert.insert1246 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1235, %output_reg.sroa.58.36.insert.shift1244
  %out.sroa.98.76.vec.extract1019 = extractelement <4 x float> %292, i64 3
  %315 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract1019)
  %output_reg.sroa.58.38.insert.ext1248 = zext i16 %315 to i64
  %output_reg.sroa.58.38.insert.shift1249 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1248, 48
  %output_reg.sroa.58.38.insert.insert1251 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1246, %output_reg.sroa.58.38.insert.shift1249
  %out.sroa.122.80.vec.extract1028 = extractelement <4 x float> %293, i64 0
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract1028)
  %output_reg.sroa.72.40.insert.ext1260 = zext i16 %316 to i64
  %out.sroa.122.84.vec.extract1033 = extractelement <4 x float> %293, i64 1
  %317 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract1033)
  %output_reg.sroa.72.42.insert.ext1264 = zext i16 %317 to i64
  %output_reg.sroa.72.42.insert.shift1265 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1264, 16
  %output_reg.sroa.72.42.insert.insert1267 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1265, %output_reg.sroa.72.40.insert.ext1260
  %out.sroa.122.88.vec.extract1038 = extractelement <4 x float> %293, i64 2
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract1038)
  %output_reg.sroa.72.44.insert.ext1275 = zext i16 %318 to i64
  %output_reg.sroa.72.44.insert.shift1276 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1275, 32
  %output_reg.sroa.72.44.insert.insert1278 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1267, %output_reg.sroa.72.44.insert.shift1276
  %out.sroa.122.92.vec.extract1043 = extractelement <4 x float> %293, i64 3
  %319 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract1043)
  %output_reg.sroa.72.46.insert.ext1280 = zext i16 %319 to i64
  %output_reg.sroa.72.46.insert.shift1281 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1280, 48
  %output_reg.sroa.72.46.insert.insert1283 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1278, %output_reg.sroa.72.46.insert.shift1281
  %out.sroa.146.96.vec.extract1052 = extractelement <4 x float> %294, i64 0
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract1052)
  %output_reg.sroa.86.48.insert.ext1292 = zext i16 %320 to i64
  %out.sroa.146.100.vec.extract1057 = extractelement <4 x float> %294, i64 1
  %321 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract1057)
  %output_reg.sroa.86.50.insert.ext1296 = zext i16 %321 to i64
  %output_reg.sroa.86.50.insert.shift1297 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1296, 16
  %output_reg.sroa.86.50.insert.insert1299 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1297, %output_reg.sroa.86.48.insert.ext1292
  %out.sroa.146.104.vec.extract1062 = extractelement <4 x float> %294, i64 2
  %322 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract1062)
  %output_reg.sroa.86.52.insert.ext1307 = zext i16 %322 to i64
  %output_reg.sroa.86.52.insert.shift1308 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1307, 32
  %output_reg.sroa.86.52.insert.insert1310 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1299, %output_reg.sroa.86.52.insert.shift1308
  %out.sroa.146.108.vec.extract1067 = extractelement <4 x float> %294, i64 3
  %323 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract1067)
  %output_reg.sroa.86.54.insert.ext1312 = zext i16 %323 to i64
  %output_reg.sroa.86.54.insert.shift1313 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1312, 48
  %output_reg.sroa.86.54.insert.insert1315 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1310, %output_reg.sroa.86.54.insert.shift1313
  %out.sroa.170.112.vec.extract1076 = extractelement <4 x float> %295, i64 0
  %324 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1076)
  %output_reg.sroa.100.56.insert.ext1324 = zext i16 %324 to i64
  %out.sroa.170.116.vec.extract1081 = extractelement <4 x float> %295, i64 1
  %325 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1081)
  %output_reg.sroa.100.58.insert.ext1328 = zext i16 %325 to i64
  %output_reg.sroa.100.58.insert.shift1329 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1328, 16
  %output_reg.sroa.100.58.insert.insert1331 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1329, %output_reg.sroa.100.56.insert.ext1324
  %out.sroa.170.120.vec.extract1086 = extractelement <4 x float> %295, i64 2
  %326 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1086)
  %output_reg.sroa.100.60.insert.ext1339 = zext i16 %326 to i64
  %output_reg.sroa.100.60.insert.shift1340 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1339, 32
  %output_reg.sroa.100.60.insert.insert1342 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1331, %output_reg.sroa.100.60.insert.shift1340
  %out.sroa.170.124.vec.extract1091 = extractelement <4 x float> %295, i64 3
  %327 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1091)
  %output_reg.sroa.100.62.insert.ext1344 = zext i16 %327 to i64
  %output_reg.sroa.100.62.insert.shift1345 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1344, 48
  %output_reg.sroa.100.62.insert.insert1347 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1342, %output_reg.sroa.100.62.insert.shift1345
  br label %if.end486.1

if.end486.1:                                      ; preds = %if.then370.1, %for.cond385.preheader.1
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1347, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1315, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1283, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1251, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1219, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1187, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1155, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1123, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor504.1891 = xor i32 %shr137, %and163
  %mul505.1892 = shl nuw nsw i32 %xor504.1891, 3
  %add506.1893 = add nuw nsw i32 %mul505.1892, %mul157
  %add511.1894 = or disjoint i32 %add506.1893, %mul510
  %add.ptr513.1895 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.1894
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr513.1895, align 8
  %add501.1.1 = add nuw nsw i32 %shr137, 2
  %xor504.1.1 = xor i32 %add501.1.1, %and163
  %mul505.1.1 = shl nuw nsw i32 %xor504.1.1, 3
  %add506.1.1 = add nuw nsw i32 %mul505.1.1, %mul157
  %add511.1.1 = or disjoint i32 %add506.1.1, %mul510
  %add.ptr513.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.1.1
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr513.1.1, align 8
  %add501.2.1 = add nuw nsw i32 %shr137, 4
  %xor504.2.1 = xor i32 %add501.2.1, %and163
  %mul505.2.1 = shl nuw nsw i32 %xor504.2.1, 3
  %add506.2.1 = add nuw nsw i32 %mul505.2.1, %mul157
  %add511.2.1 = or disjoint i32 %add506.2.1, %mul510
  %add.ptr513.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.2.1
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr513.2.1, align 8
  %add501.3.1 = add nuw nsw i32 %shr137, 6
  %xor504.3.1 = xor i32 %add501.3.1, %and163
  %mul505.3.1 = shl nuw nsw i32 %xor504.3.1, 3
  %add506.3.1 = add nuw nsw i32 %mul505.3.1, %mul157
  %add511.3.1 = or disjoint i32 %add506.3.1, %mul510
  %add.ptr513.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.3.1
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr513.3.1, align 8
  %add501.4.1 = add nuw nsw i32 %shr137, 8
  %xor504.4.1 = xor i32 %add501.4.1, %and163
  %mul505.4.1 = shl nuw nsw i32 %xor504.4.1, 3
  %add506.4.1 = add nuw nsw i32 %mul505.4.1, %mul157
  %add511.4.1 = or disjoint i32 %add506.4.1, %mul510
  %add.ptr513.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.4.1
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr513.4.1, align 8
  %add501.5.1 = add nuw nsw i32 %shr137, 10
  %xor504.5.1 = xor i32 %add501.5.1, %and163
  %mul505.5.1 = shl nuw nsw i32 %xor504.5.1, 3
  %add506.5.1 = add nuw nsw i32 %mul505.5.1, %mul157
  %add511.5.1 = or disjoint i32 %add506.5.1, %mul510
  %add.ptr513.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.5.1
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr513.5.1, align 8
  %add501.6.1 = add nuw nsw i32 %shr137, 12
  %xor504.6.1 = xor i32 %add501.6.1, %and163
  %mul505.6.1 = shl nuw nsw i32 %xor504.6.1, 3
  %add506.6.1 = add nuw nsw i32 %mul505.6.1, %mul157
  %add511.6.1 = or disjoint i32 %add506.6.1, %mul510
  %add.ptr513.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.6.1
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr513.6.1, align 8
  %add501.7.1 = add nuw nsw i32 %shr137, 14
  %xor504.7.1 = xor i32 %add501.7.1, %and163
  %mul505.7.1 = shl nuw nsw i32 %xor504.7.1, 3
  %add506.7.1 = add nuw nsw i32 %mul505.7.1, %mul157
  %add511.7.1 = or disjoint i32 %add506.7.1, %mul510
  %add.ptr513.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.7.1
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr513.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %cmp525.1 = icmp slt i32 %7, 1024
  br i1 %cmp525.1, label %for.body520.us.preheader.1, label %for.cond.cleanup519.1

for.body520.us.preheader.1:                       ; preds = %if.end486.1
  %mul554.1 = shl nuw nsw i32 %7, 11
  %add557.1 = add nuw nsw i32 %add555, %mul554.1
  %328 = zext nneg i32 %add557.1 to i64
  %xor546.us.1896 = xor i32 %shr160, %and163
  %add.ptr550.idx.us.1897 = shl nuw nsw i32 %xor546.us.1896, 4
  %add.ptr550.us.1898 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 %add.ptr550.idx.us.1897
  %add.ptr562.us.1899 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.1899, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.1898, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  %329 = add nuw nsw i32 %shr160, 4
  %xor546.us.1.1 = xor i32 %329, %and163
  %gep781.us.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1024
  %add.ptr550.idx.us.1.1 = shl nuw nsw i32 %xor546.us.1.1, 4
  %add.ptr550.us.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.1.1, i32 %add.ptr550.idx.us.1.1
  %330 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328
  %add.ptr562.us.1.1 = getelementptr inbounds i8, ptr addrspace(1) %330, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.1.1, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  %331 = add nuw nsw i32 %shr160, 8
  %xor546.us.2.1 = xor i32 %331, %and163
  %gep781.us.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2048
  %add.ptr550.idx.us.2.1 = shl nuw nsw i32 %xor546.us.2.1, 4
  %add.ptr550.us.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.2.1, i32 %add.ptr550.idx.us.2.1
  %332 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328
  %add.ptr562.us.2.1 = getelementptr inbounds i8, ptr addrspace(1) %332, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.2.1, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  %narrow = add nuw nsw i32 %shr160, 12
  %xor546.us.3.1 = xor i32 %narrow, %and163
  %gep781.us.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3072
  %add.ptr550.idx.us.3.1 = shl nuw nsw i32 %xor546.us.3.1, 4
  %add.ptr550.us.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.3.1, i32 %add.ptr550.idx.us.3.1
  %333 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328
  %add.ptr562.us.3.1 = getelementptr inbounds i8, ptr addrspace(1) %333, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.3.1, i64 16, i1 false), !tbaa.struct !205, !call_argsrelate !206
  br label %for.cond.cleanup519.1

for.cond.cleanup519.1:                            ; preds = %if.end486.1, %for.body520.us.preheader.1
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end571

if.end571:                                        ; preds = %if.end567, %for.cond.cleanup519.1, %entry
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


