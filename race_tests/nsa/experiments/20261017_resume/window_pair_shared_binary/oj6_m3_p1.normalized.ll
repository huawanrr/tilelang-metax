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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = mul nuw nsw i32 %0, 80
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %add = add nuw nsw i32 %mul, %1
  %idxprom = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i64, ptr addrspace(1) %Schedule.coerce, i64 %idxprom
  %2 = load i64, ptr addrspace(1) %arrayidx, align 8, !tbaa !17
  %and = and i64 %2, 65535
  %cmp.not = icmp eq i64 %and, 0
  br i1 %cmp.not, label %if.end585, label %for.cond.preheader

for.cond.preheader:                               ; preds = %entry
  %3 = trunc i64 %2 to i32
  %4 = lshr i32 %3, 16
  %5 = tail call range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %6 = lshr i32 %0, 3
  %shr63 = zext nneg i32 %6 to i64
  %7 = shl nuw nsw i32 %5, 2
  %mul72 = zext nneg i32 %7 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %mul72
  %shr56 = lshr i64 %2, 16
  %and57 = and i64 %shr56, 65535
  %shr100 = ashr i64 %2, 32
  %conv101 = trunc nsw i64 %shr100 to i32
  %or.cond = icmp ult i64 %shr100, 32
  %mul108 = shl nsw i32 %conv101, 5
  %8 = shl nuw nsw i32 %5, 3
  %and154 = lshr i32 %5, 1
  %shr155 = and i32 %and154, 15
  %shr158 = lshr i32 %5, 5
  %add152 = and i32 %7, 3972
  %and176 = shl nuw nsw i32 %5, 7
  %mul177 = and i32 %and176, 1920
  %shr180 = lshr i32 %5, 4
  %and183 = and i32 %5, 15
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul177
  %10 = lshr i32 %5, 2
  %mul225 = and i32 %10, 252
  %add222 = add nuw nsw i32 %mul108, %mul225
  %mul497 = and i32 %10, 4
  %mul552 = and i32 %8, 8064
  %invariant.gep768 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul552
  %11 = shl nuw nsw i32 %0, 18
  %mul567 = and i32 %11, 2145386496
  %add571 = add nsw i32 %8, -2048
  %mul568 = add nsw i32 %add571, %mul567
  %conv = trunc nuw nsw i64 %and to i32
  %.774 = tail call i32 @llvm.smin.i32(i32 %conv, i32 1024)
  %cmp109 = icmp slt i32 %mul108, %.774
  %or.cond701 = select i1 %or.cond, i1 %cmp109, i1 false
  br i1 %or.cond701, label %for.body116.preheader, label %for.body453.preheader

for.body453.preheader:                            ; preds = %for.cond.preheader
  %.pre1771 = add nuw nsw i32 %shr158, 2
  %.pre1772 = add nuw nsw i32 %shr158, 4
  %.pre1773 = add nuw nsw i32 %shr158, 6
  %.pre1774 = add nuw nsw i32 %shr158, 8
  %.pre1775 = add nuw nsw i32 %shr158, 10
  %.pre1776 = add nuw nsw i32 %shr158, 12
  %.pre1777 = add nuw nsw i32 %shr158, 14
  %.pre1778 = xor i32 %shr180, %and183
  %.pre1779 = shl nuw nsw i32 %.pre1778, 4
  %.pre1780 = add nuw nsw i32 %shr180, 4
  %.pre1781 = xor i32 %.pre1780, %and183
  %.pre1782 = shl nuw nsw i32 %.pre1781, 4
  %.pre1783 = add nuw nsw i32 %shr180, 8
  %.pre1784 = xor i32 %.pre1783, %and183
  %.pre1785 = shl nuw nsw i32 %.pre1784, 4
  %.pre1786 = add nuw nsw i32 %shr180, 12
  %.pre1787 = xor i32 %.pre1786, %and183
  %.pre1788 = shl nuw nsw i32 %.pre1787, 4
  br label %if.end473

for.body116.preheader:                            ; preds = %for.cond.preheader
  %.idx = shl nuw nsw i64 %shr63, 22
  %12 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx
  %13 = getelementptr i8, ptr addrspace(4) %12, i64 -512
  %14 = tail call i64 @llvm.umin.i64(i64 %and, i64 1024)
  %gep.idx = shl nuw nsw i64 %14, 12
  %gep.7 = getelementptr i8, ptr addrspace(4) %13, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr inbounds i8, ptr addrspace(4) %gep.7, i64 4
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !tbaa !30
  %q_stage.sroa.44.60.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.7 to i64
  %q_stage.sroa.44.60.insert.shift = shl nuw i64 %q_stage.sroa.44.60.insert.ext, 32
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !tbaa !30
  %q_stage.sroa.44.56.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.7 to i64
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %q_stage.sroa.44.60.insert.shift, %q_stage.sroa.44.56.insert.ext
  %15 = getelementptr i8, ptr addrspace(4) %12, i64 -1024
  %gep.6 = getelementptr i8, ptr addrspace(4) %15, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr inbounds i8, ptr addrspace(4) %gep.6, i64 4
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !tbaa !30
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.6 to i64
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !tbaa !30
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.6 to i64
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext
  %16 = getelementptr i8, ptr addrspace(4) %12, i64 -1536
  %gep.5 = getelementptr i8, ptr addrspace(4) %16, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr inbounds i8, ptr addrspace(4) %gep.5, i64 4
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !tbaa !30
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.5 to i64
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !tbaa !30
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.5 to i64
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext
  %17 = getelementptr i8, ptr addrspace(4) %12, i64 -2048
  %gep.4 = getelementptr i8, ptr addrspace(4) %17, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr inbounds i8, ptr addrspace(4) %gep.4, i64 4
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !tbaa !30
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.4 to i64
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !tbaa !30
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.4 to i64
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext
  %18 = getelementptr i8, ptr addrspace(4) %12, i64 -2560
  %gep.3 = getelementptr i8, ptr addrspace(4) %18, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %gep.3, i64 4
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !tbaa !30
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.3 to i64
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !tbaa !30
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.3 to i64
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext
  %19 = getelementptr i8, ptr addrspace(4) %12, i64 -3072
  %gep.2 = getelementptr i8, ptr addrspace(4) %19, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %gep.2, i64 4
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !tbaa !30
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.2 to i64
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !tbaa !30
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.2 to i64
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext
  %20 = getelementptr i8, ptr addrspace(4) %12, i64 -3584
  %gep.1 = getelementptr i8, ptr addrspace(4) %20, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1, i64 4
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !tbaa !30
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.1 to i64
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !tbaa !30
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.1 to i64
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext
  %21 = getelementptr i8, ptr addrspace(4) %12, i64 -4096
  %gep = getelementptr i8, ptr addrspace(4) %21, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !tbaa !30
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0.copyload to i64
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %gep, align 8, !tbaa !30
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0.copyload to i64
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext
  %invariant.gep771 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
  %mul129 = zext nneg i32 %8 to i64
  %gep772 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep771, i64 %mul129
  %invariant.gep742 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul129
  %.idx780 = shl nuw nsw i64 %shr100, 14
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep742, i64 %.idx780
  %.idx781 = shl nuw nsw i64 %shr63, 19
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx781
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %23, align 16
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 8
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8
  %gep743.1 = getelementptr i8, ptr addrspace(4) %23, i64 1024
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep743.1, align 16
  %k.sroa.12.16.gep743.1.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 1032
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep743.1.sroa_idx, align 8
  %gep743.2 = getelementptr i8, ptr addrspace(4) %23, i64 2048
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep743.2, align 16
  %k.sroa.18.32.gep743.2.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 2056
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep743.2.sroa_idx, align 8
  %gep743.3 = getelementptr i8, ptr addrspace(4) %23, i64 3072
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep743.3, align 16
  %k.sroa.24.48.gep743.3.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 3080
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep743.3.sroa_idx, align 8
  %gep743.4 = getelementptr i8, ptr addrspace(4) %23, i64 4096
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep743.4, align 16
  %k.sroa.30.64.gep743.4.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 4104
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep743.4.sroa_idx, align 8
  %gep743.5 = getelementptr i8, ptr addrspace(4) %23, i64 5120
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep743.5, align 16
  %k.sroa.36.80.gep743.5.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 5128
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep743.5.sroa_idx, align 8
  %gep743.6 = getelementptr i8, ptr addrspace(4) %23, i64 6144
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep743.6, align 16
  %k.sroa.42.96.gep743.6.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 6152
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep743.6.sroa_idx, align 8
  %gep743.7 = getelementptr i8, ptr addrspace(4) %23, i64 7168
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep743.7, align 16
  %k.sroa.48.112.gep743.7.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 7176
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep743.7.sroa_idx, align 8
  %xor = xor i32 %shr158, %shr155
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152
  %add.ptr167.idx = shl nuw nsw i32 %xor, 4
  %add.ptr167 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr167.idx
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %add.ptr167, align 8
  %add159.1 = add nuw nsw i32 %shr158, 2
  %xor.1 = xor i32 %add159.1, %shr155
  %25 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 512
  %add.ptr167.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr167.1 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr167.idx.1
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %add.ptr167.1, align 8
  %add159.2 = add nuw nsw i32 %shr158, 4
  %xor.2 = xor i32 %add159.2, %shr155
  %26 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1024
  %add.ptr167.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr167.2 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr167.idx.2
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %add.ptr167.2, align 8
  %add159.3 = add nuw nsw i32 %shr158, 6
  %xor.3 = xor i32 %add159.3, %shr155
  %27 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1536
  %add.ptr167.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr167.3 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr167.idx.3
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %add.ptr167.3, align 8
  %add159.4 = add nuw nsw i32 %shr158, 8
  %xor.4 = xor i32 %add159.4, %shr155
  %28 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2048
  %add.ptr167.idx.4 = shl nuw nsw i32 %xor.4, 4
  %add.ptr167.4 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr167.idx.4
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %add.ptr167.4, align 8
  %add159.5 = add nuw nsw i32 %shr158, 10
  %xor.5 = xor i32 %add159.5, %shr155
  %29 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2560
  %add.ptr167.idx.5 = shl nuw nsw i32 %xor.5, 4
  %add.ptr167.5 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr167.idx.5
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %add.ptr167.5, align 8
  %add159.6 = add nuw nsw i32 %shr158, 12
  %xor.6 = xor i32 %add159.6, %shr155
  %30 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3072
  %add.ptr167.idx.6 = shl nuw nsw i32 %xor.6, 4
  %add.ptr167.6 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr167.idx.6
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %add.ptr167.6, align 8
  %add159.7 = add nuw nsw i32 %shr158, 14
  %xor.7 = xor i32 %add159.7, %shr155
  %31 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3584
  %add.ptr167.idx.7 = shl nuw nsw i32 %xor.7, 4
  %add.ptr167.7 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr167.idx.7
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %add.ptr167.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor184 = xor i32 %shr180, %and183
  %add.ptr188.idx = shl nuw nsw i32 %xor184, 4
  %add.ptr188 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188, align 16
  %q.sroa.6.0.add.ptr188.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188, i32 8
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.sroa_idx, align 8
  %add181.1 = add nuw nsw i32 %shr180, 4
  %xor184.1 = xor i32 %add181.1, %and183
  %add.ptr188.idx.1 = shl nuw nsw i32 %xor184.1, 4
  %add.ptr188.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.1, align 16
  %q.sroa.12.16.add.ptr188.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1, i32 8
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.sroa_idx, align 8
  %add181.2 = add nuw nsw i32 %shr180, 8
  %xor184.2 = xor i32 %add181.2, %and183
  %add.ptr188.idx.2 = shl nuw nsw i32 %xor184.2, 4
  %add.ptr188.2 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.2, align 16
  %q.sroa.18.32.add.ptr188.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2, i32 8
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.sroa_idx, align 8
  %add181.3 = add nuw nsw i32 %shr180, 12
  %xor184.3 = xor i32 %add181.3, %and183
  %add.ptr188.idx.3 = shl nuw nsw i32 %xor184.3, 4
  %add.ptr188.3 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.3, align 16
  %q.sroa.24.48.add.ptr188.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3, i32 8
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.sroa_idx, align 8
  %cmp229.not.not = icmp slt i32 %add222, %.774
  %spec.select = select i1 %cmp229.not.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %add226.1 = or disjoint i32 %add222, 1
  %cmp229.not.not.1 = icmp slt i32 %add226.1, %.774
  %spec.select.1 = select i1 %cmp229.not.not.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add226.2 = or disjoint i32 %add222, 2
  %cmp229.not.not.2 = icmp slt i32 %add226.2, %.774
  %spec.select.2 = select i1 %cmp229.not.not.2, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add226.3 = or disjoint i32 %add222, 3
  %cmp229.not.not.3 = icmp slt i32 %add226.3, %.774
  %spec.select.3 = select i1 %cmp229.not.not.3, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add228.4 = add nuw nsw i32 %add222, 16
  %cmp229.not.not.4 = icmp slt i32 %add228.4, %.774
  %spec.select.4 = select i1 %cmp229.not.not.4, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add228.5 = add nuw nsw i32 %add222, 17
  %cmp229.not.not.5 = icmp slt i32 %add228.5, %.774
  %spec.select.5 = select i1 %cmp229.not.not.5, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1
  %add228.6 = add nuw nsw i32 %add222, 18
  %cmp229.not.not.6 = icmp slt i32 %add228.6, %.774
  %spec.select.6 = select i1 %cmp229.not.not.6, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2
  %add228.7 = add nuw nsw i32 %add222, 19
  %cmp229.not.not.7 = icmp slt i32 %add228.7, %.774
  %spec.select.7 = select i1 %cmp229.not.not.7, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !93
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !call_argsrelate !93
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %32), !call_argsrelate !93
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %33), !call_argsrelate !93
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %34), !call_argsrelate !93
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %35), !call_argsrelate !93
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %36), !call_argsrelate !93
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %37), !call_argsrelate !93
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %38), !call_argsrelate !93
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %39), !call_argsrelate !93
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %40), !call_argsrelate !93
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %41), !call_argsrelate !93
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %42), !call_argsrelate !93
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %43), !call_argsrelate !93
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %44), !call_argsrelate !93
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %45), !call_argsrelate !93
  %.idx786 = shl nuw nsw i64 %shr100, 14
  %48 = getelementptr i8, ptr addrspace(4) %gep772, i64 %.idx786
  %.idx787 = shl nuw nsw i64 %shr63, 19
  %49 = getelementptr i8, ptr addrspace(4) %48, i64 %.idx787
  %v.sroa.48.112.gep754.7.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 7176
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep754.7.sroa_idx, align 8
  %gep754.7 = getelementptr i8, ptr addrspace(4) %49, i64 7168
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep754.7, align 16
  %v.sroa.42.96.gep754.6.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 6152
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep754.6.sroa_idx, align 8
  %gep754.6 = getelementptr i8, ptr addrspace(4) %49, i64 6144
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep754.6, align 16
  %v.sroa.36.80.gep754.5.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 5128
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep754.5.sroa_idx, align 8
  %gep754.5 = getelementptr i8, ptr addrspace(4) %49, i64 5120
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep754.5, align 16
  %v.sroa.30.64.gep754.4.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 4104
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep754.4.sroa_idx, align 8
  %gep754.4 = getelementptr i8, ptr addrspace(4) %49, i64 4096
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep754.4, align 16
  %v.sroa.24.48.gep754.3.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 3080
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep754.3.sroa_idx, align 8
  %gep754.3 = getelementptr i8, ptr addrspace(4) %49, i64 3072
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep754.3, align 16
  %v.sroa.18.32.gep754.2.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 2056
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep754.2.sroa_idx, align 8
  %gep754.2 = getelementptr i8, ptr addrspace(4) %49, i64 2048
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep754.2, align 16
  %v.sroa.12.16.gep754.1.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 1032
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep754.1.sroa_idx, align 8
  %gep754.1 = getelementptr i8, ptr addrspace(4) %49, i64 1024
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep754.1, align 16
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %49, i64 8
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %49, align 16
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0
  %mul314 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul314, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %50, -1.260000e+02
  %cond.i.i724 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i725 = fadd contract float %50, %cond.i.i724
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i725)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %51
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1
  %mul314.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %52, -1.260000e+02
  %cond.i.i724.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.1 = fadd contract float %52, %cond.i.i724.1
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i725.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %53
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2
  %mul314.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul314.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %54, -1.260000e+02
  %cond.i.i724.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.2 = fadd contract float %54, %cond.i.i724.2
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i725.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %55
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3
  %mul314.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul314.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %56, -1.260000e+02
  %cond.i.i724.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.3 = fadd contract float %56, %cond.i.i724.3
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i725.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %57
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %47, i64 0
  %mul314.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul314.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %58, -1.260000e+02
  %cond.i.i724.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.4 = fadd contract float %58, %cond.i.i724.4
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i725.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %59
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %47, i64 1
  %mul314.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul314.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %60, -1.260000e+02
  %cond.i.i724.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.5 = fadd contract float %60, %cond.i.i724.5
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i725.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %61
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %47, i64 2
  %mul314.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul314.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %62, -1.260000e+02
  %cond.i.i724.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.6 = fadd contract float %62, %cond.i.i724.6
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i725.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %63
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %47, i64 3
  %mul314.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul314.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %64, -1.260000e+02
  %cond.i.i724.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.7 = fadd contract float %64, %cond.i.i724.7
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i725.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %65
  %add334 = fadd contract float %mul.i.i, 0.000000e+00
  %add334.1 = fadd contract float %add334, %mul.i.i.4
  %add334.2 = fadd contract float %add334.1, %mul.i.i.1
  %add334.3 = fadd contract float %add334.2, %mul.i.i.5
  %add334.4 = fadd contract float %add334.3, %mul.i.i.2
  %add334.5 = fadd contract float %add334.4, %mul.i.i.6
  %add334.6 = fadd contract float %add334.5, %mul.i.i.3
  %add334.7 = fadd contract float %add334.6, %mul.i.i.7
  %66 = bitcast float %add334.7 to i32
  %67 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %68 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %67) #11
  %xor.i.i = xor i32 %68, 32
  %69 = and i32 %68, -64
  %and.i.i = add nsw i32 %69, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i726 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %68
  %shl.i.i = shl i32 %cond.i.i726, 2
  %70 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %66)
  %71 = bitcast i32 %70 to float
  %add.i = fadd contract float %add334.7, %71
  %72 = bitcast float %add.i to i32
  %73 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %74 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %73) #11
  %xor.i.i727 = xor i32 %74, 16
  %75 = and i32 %74, -64
  %and.i.i728 = add nsw i32 %75, 64
  %cmp.not.i.i729 = icmp slt i32 %xor.i.i727, %and.i.i728
  %cond.i.i730 = select i1 %cmp.not.i.i729, i32 %xor.i.i727, i32 %74
  %shl.i.i731 = shl i32 %cond.i.i730, 2
  %76 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i731, i32 %72)
  %77 = bitcast i32 %76 to float
  %add.i.i = fadd contract float %add.i, %77
  %cmp343 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp343, float %div, float 0.000000e+00
  %mul356 = fmul contract float %condval_8.0, %mul.i.i
  %mul356.1 = fmul contract float %condval_8.0, %mul.i.i.1
  %mul356.2 = fmul contract float %condval_8.0, %mul.i.i.2
  %mul356.3 = fmul contract float %condval_8.0, %mul.i.i.3
  %mul356.4 = fmul contract float %condval_8.0, %mul.i.i.4
  %mul356.5 = fmul contract float %condval_8.0, %mul.i.i.5
  %mul356.6 = fmul contract float %condval_8.0, %mul.i.i.6
  %mul356.7 = fmul contract float %condval_8.0, %mul.i.i.7
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356)
  %79 = insertelement <4 x i16> poison, i16 %78, i64 0
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.1)
  %81 = insertelement <4 x i16> %79, i16 %80, i64 1
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.2)
  %83 = insertelement <4 x i16> %81, i16 %82, i64 2
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.3)
  %85 = insertelement <4 x i16> %83, i16 %84, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %85 to <4 x half>
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.4)
  %87 = insertelement <4 x i16> poison, i16 %86, i64 0
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.5)
  %89 = insertelement <4 x i16> %87, i16 %88, i64 1
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.6)
  %91 = insertelement <4 x i16> %89, i16 %90, i64 2
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.7)
  %93 = insertelement <4 x i16> %91, i16 %92, i64 3
  %prob.sroa.12.14.vec.insert = bitcast <4 x i16> %93 to <4 x half>
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !93
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %94), !call_argsrelate !93
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %95), !call_argsrelate !93
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %96), !call_argsrelate !93
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %97), !call_argsrelate !93
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %98), !call_argsrelate !93
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %99), !call_argsrelate !93
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %100), !call_argsrelate !93
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %101), !call_argsrelate !93
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %102, i64 0
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %110 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %102, i64 1
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %111 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %102, i64 2
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %112 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert1105 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %102, i64 3
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %113 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1105, %output_reg.sroa.0.6.insert.shift
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %103, i64 0
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract)
  %output_reg.sroa.16.8.insert.ext = zext i16 %114 to i64
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %103, i64 1
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract)
  %output_reg.sroa.16.10.insert.ext = zext i16 %115 to i64
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %103, i64 2
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract)
  %output_reg.sroa.16.12.insert.ext = zext i16 %116 to i64
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32
  %output_reg.sroa.16.12.insert.insert1137 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %103, i64 3
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract)
  %output_reg.sroa.16.14.insert.ext = zext i16 %117 to i64
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1137, %output_reg.sroa.16.14.insert.shift
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %104, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract)
  %output_reg.sroa.30.16.insert.ext = zext i16 %118 to i64
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %104, i64 1
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract)
  %output_reg.sroa.30.18.insert.ext = zext i16 %119 to i64
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %104, i64 2
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract)
  %output_reg.sroa.30.20.insert.ext = zext i16 %120 to i64
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32
  %output_reg.sroa.30.20.insert.insert1169 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %104, i64 3
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract)
  %output_reg.sroa.30.22.insert.ext = zext i16 %121 to i64
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1169, %output_reg.sroa.30.22.insert.shift
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %105, i64 0
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract)
  %output_reg.sroa.44.24.insert.ext = zext i16 %122 to i64
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %105, i64 1
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract)
  %output_reg.sroa.44.26.insert.ext = zext i16 %123 to i64
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %105, i64 2
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract)
  %output_reg.sroa.44.28.insert.ext = zext i16 %124 to i64
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32
  %output_reg.sroa.44.28.insert.insert1201 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %105, i64 3
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract)
  %output_reg.sroa.44.30.insert.ext = zext i16 %125 to i64
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1201, %output_reg.sroa.44.30.insert.shift
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %106, i64 0
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract)
  %output_reg.sroa.58.32.insert.ext = zext i16 %126 to i64
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %106, i64 1
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract)
  %output_reg.sroa.58.34.insert.ext = zext i16 %127 to i64
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %106, i64 2
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract)
  %output_reg.sroa.58.36.insert.ext = zext i16 %128 to i64
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32
  %output_reg.sroa.58.36.insert.insert1233 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %106, i64 3
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract)
  %output_reg.sroa.58.38.insert.ext = zext i16 %129 to i64
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1233, %output_reg.sroa.58.38.insert.shift
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %107, i64 0
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract)
  %output_reg.sroa.72.40.insert.ext = zext i16 %130 to i64
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %107, i64 1
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract)
  %output_reg.sroa.72.42.insert.ext = zext i16 %131 to i64
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %107, i64 2
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract)
  %output_reg.sroa.72.44.insert.ext = zext i16 %132 to i64
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32
  %output_reg.sroa.72.44.insert.insert1265 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %107, i64 3
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract)
  %output_reg.sroa.72.46.insert.ext = zext i16 %133 to i64
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1265, %output_reg.sroa.72.46.insert.shift
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %108, i64 0
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract)
  %output_reg.sroa.86.48.insert.ext = zext i16 %134 to i64
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %108, i64 1
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract)
  %output_reg.sroa.86.50.insert.ext = zext i16 %135 to i64
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %108, i64 2
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract)
  %output_reg.sroa.86.52.insert.ext = zext i16 %136 to i64
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32
  %output_reg.sroa.86.52.insert.insert1297 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %108, i64 3
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract)
  %output_reg.sroa.86.54.insert.ext = zext i16 %137 to i64
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1297, %output_reg.sroa.86.54.insert.shift
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %109, i64 0
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract)
  %output_reg.sroa.100.56.insert.ext = zext i16 %138 to i64
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %109, i64 1
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract)
  %output_reg.sroa.100.58.insert.ext = zext i16 %139 to i64
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %109, i64 2
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract)
  %output_reg.sroa.100.60.insert.ext = zext i16 %140 to i64
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32
  %output_reg.sroa.100.60.insert.insert1329 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %109, i64 3
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract)
  %output_reg.sroa.100.62.insert.ext = zext i16 %141 to i64
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1329, %output_reg.sroa.100.62.insert.shift
  br label %if.end473

if.end473:                                        ; preds = %for.body453.preheader, %for.body116.preheader
  %add.ptr564.idx.3.pre-phi = phi i32 [ %.pre1788, %for.body453.preheader ], [ %add.ptr188.idx.3, %for.body116.preheader ]
  %add.ptr564.idx.2.pre-phi = phi i32 [ %.pre1785, %for.body453.preheader ], [ %add.ptr188.idx.2, %for.body116.preheader ]
  %add.ptr564.idx.1.pre-phi = phi i32 [ %.pre1782, %for.body453.preheader ], [ %add.ptr188.idx.1, %for.body116.preheader ]
  %add.ptr564.idx.pre-phi = phi i32 [ %.pre1779, %for.body453.preheader ], [ %add.ptr188.idx, %for.body116.preheader ]
  %add488.7.pre-phi = phi i32 [ %.pre1777, %for.body453.preheader ], [ %add159.7, %for.body116.preheader ]
  %add488.6.pre-phi = phi i32 [ %.pre1776, %for.body453.preheader ], [ %add159.6, %for.body116.preheader ]
  %add488.5.pre-phi = phi i32 [ %.pre1775, %for.body453.preheader ], [ %add159.5, %for.body116.preheader ]
  %add488.4.pre-phi = phi i32 [ %.pre1774, %for.body453.preheader ], [ %add159.4, %for.body116.preheader ]
  %add488.3.pre-phi = phi i32 [ %.pre1773, %for.body453.preheader ], [ %add159.3, %for.body116.preheader ]
  %add488.2.pre-phi = phi i32 [ %.pre1772, %for.body453.preheader ], [ %add159.2, %for.body116.preheader ]
  %add488.1.pre-phi = phi i32 [ %.pre1771, %for.body453.preheader ], [ %add159.1, %for.body116.preheader ]
  %k.sroa.48.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.48.112.copyload, %for.body116.preheader ]
  %k.sroa.44.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.44.112.copyload, %for.body116.preheader ]
  %k.sroa.42.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.42.96.copyload, %for.body116.preheader ]
  %k.sroa.38.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.38.96.copyload, %for.body116.preheader ]
  %k.sroa.36.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.36.80.copyload, %for.body116.preheader ]
  %k.sroa.32.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.32.80.copyload, %for.body116.preheader ]
  %k.sroa.30.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.30.64.copyload, %for.body116.preheader ]
  %k.sroa.26.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.26.64.copyload, %for.body116.preheader ]
  %k.sroa.24.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.24.48.copyload, %for.body116.preheader ]
  %k.sroa.20.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.20.48.copyload, %for.body116.preheader ]
  %k.sroa.18.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.18.32.copyload, %for.body116.preheader ]
  %k.sroa.14.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.14.32.copyload, %for.body116.preheader ]
  %k.sroa.12.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.12.16.copyload, %for.body116.preheader ]
  %k.sroa.8.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.8.16.copyload, %for.body116.preheader ]
  %k.sroa.6.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.6.0.copyload, %for.body116.preheader ]
  %k.sroa.0.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %k.sroa.0.0.copyload, %for.body116.preheader ]
  %v.sroa.48.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.48.112.copyload, %for.body116.preheader ]
  %v.sroa.44.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.44.112.copyload, %for.body116.preheader ]
  %v.sroa.42.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.42.96.copyload, %for.body116.preheader ]
  %v.sroa.38.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.38.96.copyload, %for.body116.preheader ]
  %v.sroa.36.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.36.80.copyload, %for.body116.preheader ]
  %v.sroa.32.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.32.80.copyload, %for.body116.preheader ]
  %v.sroa.30.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.30.64.copyload, %for.body116.preheader ]
  %v.sroa.26.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.26.64.copyload, %for.body116.preheader ]
  %v.sroa.24.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.24.48.copyload, %for.body116.preheader ]
  %v.sroa.20.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.20.48.copyload, %for.body116.preheader ]
  %v.sroa.18.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.18.32.copyload, %for.body116.preheader ]
  %v.sroa.14.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.14.32.copyload, %for.body116.preheader ]
  %v.sroa.12.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.12.16.copyload, %for.body116.preheader ]
  %v.sroa.8.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.8.16.copyload, %for.body116.preheader ]
  %v.sroa.6.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.6.0.copyload, %for.body116.preheader ]
  %v.sroa.0.1 = phi <4 x half> [ undef, %for.body453.preheader ], [ %v.sroa.0.0.copyload, %for.body116.preheader ]
  %output_reg.sroa.100.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.100.62.insert.insert, %for.body116.preheader ]
  %output_reg.sroa.86.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.86.54.insert.insert, %for.body116.preheader ]
  %output_reg.sroa.72.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.72.46.insert.insert, %for.body116.preheader ]
  %output_reg.sroa.58.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.58.38.insert.insert, %for.body116.preheader ]
  %output_reg.sroa.44.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.44.30.insert.insert, %for.body116.preheader ]
  %output_reg.sroa.30.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.30.22.insert.insert, %for.body116.preheader ]
  %output_reg.sroa.16.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.16.14.insert.insert, %for.body116.preheader ]
  %output_reg.sroa.0.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.0.6.insert.insert, %for.body116.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor491 = xor i32 %shr158, %and183
  %mul492 = shl nuw nsw i32 %xor491, 3
  %add493 = add nuw nsw i32 %mul492, %mul177
  %add498 = or disjoint i32 %add493, %mul497
  %add.ptr500 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr500, align 8
  %xor491.1 = xor i32 %add488.1.pre-phi, %and183
  %mul492.1 = shl nuw nsw i32 %xor491.1, 3
  %add493.1 = add nuw nsw i32 %mul492.1, %mul177
  %add498.1 = or disjoint i32 %add493.1, %mul497
  %add.ptr500.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.1
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr500.1, align 8
  %xor491.2 = xor i32 %add488.2.pre-phi, %and183
  %mul492.2 = shl nuw nsw i32 %xor491.2, 3
  %add493.2 = add nuw nsw i32 %mul492.2, %mul177
  %add498.2 = or disjoint i32 %add493.2, %mul497
  %add.ptr500.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.2
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr500.2, align 8
  %xor491.3 = xor i32 %add488.3.pre-phi, %and183
  %mul492.3 = shl nuw nsw i32 %xor491.3, 3
  %add493.3 = add nuw nsw i32 %mul492.3, %mul177
  %add498.3 = or disjoint i32 %add493.3, %mul497
  %add.ptr500.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.3
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr500.3, align 8
  %xor491.4 = xor i32 %add488.4.pre-phi, %and183
  %mul492.4 = shl nuw nsw i32 %xor491.4, 3
  %add493.4 = add nuw nsw i32 %mul492.4, %mul177
  %add498.4 = or disjoint i32 %add493.4, %mul497
  %add.ptr500.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.4
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr500.4, align 8
  %xor491.5 = xor i32 %add488.5.pre-phi, %and183
  %mul492.5 = shl nuw nsw i32 %xor491.5, 3
  %add493.5 = add nuw nsw i32 %mul492.5, %mul177
  %add498.5 = or disjoint i32 %add493.5, %mul497
  %add.ptr500.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.5
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr500.5, align 8
  %xor491.6 = xor i32 %add488.6.pre-phi, %and183
  %mul492.6 = shl nuw nsw i32 %xor491.6, 3
  %add493.6 = add nuw nsw i32 %mul492.6, %mul177
  %add498.6 = or disjoint i32 %add493.6, %mul497
  %add.ptr500.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.6
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr500.6, align 8
  %xor491.7 = xor i32 %add488.7.pre-phi, %and183
  %mul492.7 = shl nuw nsw i32 %xor491.7, 3
  %add493.7 = add nuw nsw i32 %mul492.7, %mul177
  %add498.7 = or disjoint i32 %add493.7, %mul497
  %add.ptr500.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.7
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr500.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr564 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 %add.ptr564.idx.pre-phi
  %condval_11.0 = shl nuw nsw i32 %.774, 11
  %add574 = add i32 %mul568, %condval_11.0
  %idx.ext575 = sext i32 %add574 to i64
  %add.ptr576 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  %gep769.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1024
  %add.ptr564.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.1, i32 %add.ptr564.idx.1.pre-phi
  %add569.1 = add nsw i32 %mul568, 512
  %add574.1 = add i32 %add569.1, %condval_11.0
  %idx.ext575.1 = sext i32 %add574.1 to i64
  %add.ptr576.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  %gep769.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2048
  %add.ptr564.2 = getelementptr inbounds i8, ptr addrspace(3) %gep769.2, i32 %add.ptr564.idx.2.pre-phi
  %add569.2 = add nsw i32 %mul568, 1024
  %add574.2 = add i32 %add569.2, %condval_11.0
  %idx.ext575.2 = sext i32 %add574.2 to i64
  %add.ptr576.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.2
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.2, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  %gep769.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3072
  %add.ptr564.3 = getelementptr inbounds i8, ptr addrspace(3) %gep769.3, i32 %add.ptr564.idx.3.pre-phi
  %add569.3 = add nsw i32 %mul568, 1536
  %add574.3 = add i32 %add569.3, %condval_11.0
  %idx.ext575.3 = sext i32 %add574.3 to i64
  %add.ptr576.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.3, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %cmp16.not.1 = icmp ult i32 %3, 65536
  br i1 %cmp16.not.1, label %if.end585, label %if.end48.preheader.1

if.end48.preheader.1:                             ; preds = %if.end473
  %.774.1 = tail call i32 @llvm.smin.i32(i32 %4, i32 1024)
  %cmp109.1 = icmp slt i32 %mul108, %.774.1
  %or.cond701.1 = select i1 %or.cond, i1 %cmp109.1, i1 false
  br i1 %or.cond701.1, label %if.end139.1, label %for.body453.preheader.1

for.body453.preheader.1:                          ; preds = %if.end48.preheader.1
  %.pre = add nuw nsw i32 %shr158, 2
  %.pre1754 = add nuw nsw i32 %shr158, 4
  %.pre1755 = add nuw nsw i32 %shr158, 6
  %.pre1756 = add nuw nsw i32 %shr158, 8
  %.pre1757 = add nuw nsw i32 %shr158, 10
  %.pre1758 = add nuw nsw i32 %shr158, 12
  %.pre1759 = add nuw nsw i32 %shr158, 14
  %.pre1760 = xor i32 %shr180, %and183
  %.pre1761 = shl nuw nsw i32 %.pre1760, 4
  %.pre1762 = add nuw nsw i32 %shr180, 4
  %.pre1763 = xor i32 %.pre1762, %and183
  %.pre1764 = shl nuw nsw i32 %.pre1763, 4
  %.pre1765 = add nuw nsw i32 %shr180, 8
  %.pre1766 = xor i32 %.pre1765, %and183
  %.pre1767 = shl nuw nsw i32 %.pre1766, 4
  %.pre1768 = add nuw nsw i32 %shr180, 12
  %.pre1769 = xor i32 %.pre1768, %and183
  %.pre1770 = shl nuw nsw i32 %.pre1769, 4
  br label %if.end473.1

if.end139.1:                                      ; preds = %if.end48.preheader.1
  %.idx.1816 = shl nuw nsw i64 %shr63, 22
  %142 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1816
  %143 = getelementptr i8, ptr addrspace(4) %142, i64 -512
  %144 = tail call i64 @llvm.umin.i64(i64 %and57, i64 1024)
  %gep.idx.1817 = shl nuw nsw i64 %144, 12
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %143, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.7.1, i64 4
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !tbaa !30
  %q_stage.sroa.44.60.insert.ext1750 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64
  %q_stage.sroa.44.60.insert.shift1751 = shl nuw i64 %q_stage.sroa.44.60.insert.ext1750, 32
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !tbaa !30
  %q_stage.sroa.44.56.insert.ext1746 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64
  %q_stage.sroa.44.60.insert.insert1753 = or disjoint i64 %q_stage.sroa.44.60.insert.shift1751, %q_stage.sroa.44.56.insert.ext1746
  %145 = getelementptr i8, ptr addrspace(4) %142, i64 -1024
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %145, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.6.1, i64 4
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !tbaa !30
  %q_stage.sroa.38.52.insert.ext1740 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64
  %q_stage.sroa.38.52.insert.shift1741 = shl nuw i64 %q_stage.sroa.38.52.insert.ext1740, 32
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !tbaa !30
  %q_stage.sroa.38.48.insert.ext1736 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64
  %q_stage.sroa.38.52.insert.insert1743 = or disjoint i64 %q_stage.sroa.38.52.insert.shift1741, %q_stage.sroa.38.48.insert.ext1736
  %146 = getelementptr i8, ptr addrspace(4) %142, i64 -1536
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %146, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.5.1, i64 4
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !tbaa !30
  %q_stage.sroa.32.44.insert.ext1730 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64
  %q_stage.sroa.32.44.insert.shift1731 = shl nuw i64 %q_stage.sroa.32.44.insert.ext1730, 32
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !tbaa !30
  %q_stage.sroa.32.40.insert.ext1726 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64
  %q_stage.sroa.32.44.insert.insert1733 = or disjoint i64 %q_stage.sroa.32.44.insert.shift1731, %q_stage.sroa.32.40.insert.ext1726
  %147 = getelementptr i8, ptr addrspace(4) %142, i64 -2048
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %147, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.4.1, i64 4
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !tbaa !30
  %q_stage.sroa.26.36.insert.ext1720 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64
  %q_stage.sroa.26.36.insert.shift1721 = shl nuw i64 %q_stage.sroa.26.36.insert.ext1720, 32
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !tbaa !30
  %q_stage.sroa.26.32.insert.ext1716 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64
  %q_stage.sroa.26.36.insert.insert1723 = or disjoint i64 %q_stage.sroa.26.36.insert.shift1721, %q_stage.sroa.26.32.insert.ext1716
  %148 = getelementptr i8, ptr addrspace(4) %142, i64 -2560
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %148, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.3.1, i64 4
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !tbaa !30
  %q_stage.sroa.20.28.insert.ext1710 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64
  %q_stage.sroa.20.28.insert.shift1711 = shl nuw i64 %q_stage.sroa.20.28.insert.ext1710, 32
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !tbaa !30
  %q_stage.sroa.20.24.insert.ext1706 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64
  %q_stage.sroa.20.28.insert.insert1713 = or disjoint i64 %q_stage.sroa.20.28.insert.shift1711, %q_stage.sroa.20.24.insert.ext1706
  %149 = getelementptr i8, ptr addrspace(4) %142, i64 -3072
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %149, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.2.1, i64 4
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !tbaa !30
  %q_stage.sroa.14.20.insert.ext1700 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64
  %q_stage.sroa.14.20.insert.shift1701 = shl nuw i64 %q_stage.sroa.14.20.insert.ext1700, 32
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !tbaa !30
  %q_stage.sroa.14.16.insert.ext1696 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64
  %q_stage.sroa.14.20.insert.insert1703 = or disjoint i64 %q_stage.sroa.14.20.insert.shift1701, %q_stage.sroa.14.16.insert.ext1696
  %150 = getelementptr i8, ptr addrspace(4) %142, i64 -3584
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %150, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1.1, i64 4
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !tbaa !30
  %q_stage.sroa.8.12.insert.ext1690 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64
  %q_stage.sroa.8.12.insert.shift1691 = shl nuw i64 %q_stage.sroa.8.12.insert.ext1690, 32
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !tbaa !30
  %q_stage.sroa.8.8.insert.ext1686 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64
  %q_stage.sroa.8.12.insert.insert1693 = or disjoint i64 %q_stage.sroa.8.12.insert.shift1691, %q_stage.sroa.8.8.insert.ext1686
  %151 = getelementptr i8, ptr addrspace(4) %142, i64 -4096
  %gep.1818 = getelementptr i8, ptr addrspace(4) %151, i64 %gep.idx.1817
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1819 = getelementptr inbounds i8, ptr addrspace(4) %gep.1818, i64 4
  %condval_1.sroa.5.0.copyload.1820 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1819, align 4, !tbaa !30
  %q_stage.sroa.0.4.insert.ext1680 = zext i32 %condval_1.sroa.5.0.copyload.1820 to i64
  %q_stage.sroa.0.4.insert.shift1681 = shl nuw i64 %q_stage.sroa.0.4.insert.ext1680, 32
  %condval_1.sroa.0.0.copyload.1821 = load i32, ptr addrspace(4) %gep.1818, align 8, !tbaa !30
  %q_stage.sroa.0.0.insert.ext1676 = zext i32 %condval_1.sroa.0.0.copyload.1821 to i64
  %q_stage.sroa.0.4.insert.insert1683 = or disjoint i64 %q_stage.sroa.0.4.insert.shift1681, %q_stage.sroa.0.0.insert.ext1676
  %xor.1826 = xor i32 %shr158, %shr155
  %152 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152
  %add.ptr167.idx.1827 = shl nuw nsw i32 %xor.1826, 4
  %add.ptr167.1828 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 %add.ptr167.idx.1827
  store i64 %q_stage.sroa.0.4.insert.insert1683, ptr addrspace(3) %add.ptr167.1828, align 8
  %add159.1.1 = add nuw nsw i32 %shr158, 2
  %xor.1.1 = xor i32 %add159.1.1, %shr155
  %153 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 512
  %add.ptr167.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4
  %add.ptr167.1.1 = getelementptr inbounds i8, ptr addrspace(3) %153, i32 %add.ptr167.idx.1.1
  store i64 %q_stage.sroa.8.12.insert.insert1693, ptr addrspace(3) %add.ptr167.1.1, align 8
  %add159.2.1 = add nuw nsw i32 %shr158, 4
  %xor.2.1 = xor i32 %add159.2.1, %shr155
  %154 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 1024
  %add.ptr167.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4
  %add.ptr167.2.1 = getelementptr inbounds i8, ptr addrspace(3) %154, i32 %add.ptr167.idx.2.1
  store i64 %q_stage.sroa.14.20.insert.insert1703, ptr addrspace(3) %add.ptr167.2.1, align 8
  %add159.3.1 = add nuw nsw i32 %shr158, 6
  %xor.3.1 = xor i32 %add159.3.1, %shr155
  %155 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 1536
  %add.ptr167.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4
  %add.ptr167.3.1 = getelementptr inbounds i8, ptr addrspace(3) %155, i32 %add.ptr167.idx.3.1
  store i64 %q_stage.sroa.20.28.insert.insert1713, ptr addrspace(3) %add.ptr167.3.1, align 8
  %add159.4.1 = add nuw nsw i32 %shr158, 8
  %xor.4.1 = xor i32 %add159.4.1, %shr155
  %156 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 2048
  %add.ptr167.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4
  %add.ptr167.4.1 = getelementptr inbounds i8, ptr addrspace(3) %156, i32 %add.ptr167.idx.4.1
  store i64 %q_stage.sroa.26.36.insert.insert1723, ptr addrspace(3) %add.ptr167.4.1, align 8
  %add159.5.1 = add nuw nsw i32 %shr158, 10
  %xor.5.1 = xor i32 %add159.5.1, %shr155
  %157 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 2560
  %add.ptr167.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4
  %add.ptr167.5.1 = getelementptr inbounds i8, ptr addrspace(3) %157, i32 %add.ptr167.idx.5.1
  store i64 %q_stage.sroa.32.44.insert.insert1733, ptr addrspace(3) %add.ptr167.5.1, align 8
  %add159.6.1 = add nuw nsw i32 %shr158, 12
  %xor.6.1 = xor i32 %add159.6.1, %shr155
  %158 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 3072
  %add.ptr167.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4
  %add.ptr167.6.1 = getelementptr inbounds i8, ptr addrspace(3) %158, i32 %add.ptr167.idx.6.1
  store i64 %q_stage.sroa.38.52.insert.insert1743, ptr addrspace(3) %add.ptr167.6.1, align 8
  %add159.7.1 = add nuw nsw i32 %shr158, 14
  %xor.7.1 = xor i32 %add159.7.1, %shr155
  %159 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 3584
  %add.ptr167.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4
  %add.ptr167.7.1 = getelementptr inbounds i8, ptr addrspace(3) %159, i32 %add.ptr167.idx.7.1
  store i64 %q_stage.sroa.44.60.insert.insert1753, ptr addrspace(3) %add.ptr167.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor184.1829 = xor i32 %shr180, %and183
  %add.ptr188.idx.1830 = shl nuw nsw i32 %xor184.1829, 4
  %add.ptr188.1831 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1830
  %q.sroa.0.0.copyload1626 = load <4 x half>, ptr addrspace(3) %add.ptr188.1831, align 16
  %q.sroa.6.0.add.ptr188.1831.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1831, i32 8
  %q.sroa.6.0.copyload1627 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.1831.sroa_idx, align 8
  %add181.1.1 = add nuw nsw i32 %shr180, 4
  %xor184.1.1 = xor i32 %add181.1.1, %and183
  %add.ptr188.idx.1.1 = shl nuw nsw i32 %xor184.1.1, 4
  %add.ptr188.1.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1.1
  %q.sroa.8.16.copyload1630 = load <4 x half>, ptr addrspace(3) %add.ptr188.1.1, align 16
  %q.sroa.12.16.add.ptr188.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1.1, i32 8
  %q.sroa.12.16.copyload1631 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.1.sroa_idx, align 8
  %add181.2.1 = add nuw nsw i32 %shr180, 8
  %xor184.2.1 = xor i32 %add181.2.1, %and183
  %add.ptr188.idx.2.1 = shl nuw nsw i32 %xor184.2.1, 4
  %add.ptr188.2.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2.1
  %q.sroa.14.32.copyload1634 = load <4 x half>, ptr addrspace(3) %add.ptr188.2.1, align 16
  %q.sroa.18.32.add.ptr188.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2.1, i32 8
  %q.sroa.18.32.copyload1635 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.1.sroa_idx, align 8
  %add181.3.1 = add nuw nsw i32 %shr180, 12
  %xor184.3.1 = xor i32 %add181.3.1, %and183
  %add.ptr188.idx.3.1 = shl nuw nsw i32 %xor184.3.1, 4
  %add.ptr188.3.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3.1
  %q.sroa.20.48.copyload1638 = load <4 x half>, ptr addrspace(3) %add.ptr188.3.1, align 16
  %q.sroa.24.48.add.ptr188.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3.1, i32 8
  %q.sroa.24.48.copyload1639 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.1.sroa_idx, align 8
  %cmp229.not.not.1834 = icmp slt i32 %add222, %.774.1
  %spec.select.1835 = select i1 %cmp229.not.not.1834, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.0.vec.insert1421 = insertelement <4 x float> poison, float %spec.select.1835, i64 0
  %add226.1.1 = or disjoint i32 %add222, 1
  %cmp229.not.not.1.1 = icmp slt i32 %add226.1.1, %.774.1
  %spec.select.1.1 = select i1 %cmp229.not.not.1.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1446 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1421, float %spec.select.1.1, i64 1
  %add226.2.1 = or disjoint i32 %add222, 2
  %cmp229.not.not.2.1 = icmp slt i32 %add226.2.1, %.774.1
  %spec.select.2.1 = select i1 %cmp229.not.not.2.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.8.vec.insert1471 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1446, float %spec.select.2.1, i64 2
  %add226.3.1 = or disjoint i32 %add222, 3
  %cmp229.not.not.3.1 = icmp slt i32 %add226.3.1, %.774.1
  %spec.select.3.1 = select i1 %cmp229.not.not.3.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.12.vec.insert1496 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1471, float %spec.select.3.1, i64 3
  %add228.4.1 = add nuw nsw i32 %add222, 16
  %cmp229.not.not.4.1 = icmp slt i32 %add228.4.1, %.774.1
  %spec.select.4.1 = select i1 %cmp229.not.not.4.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.16.vec.insert1537 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0
  %add228.5.1 = add nuw nsw i32 %add222, 17
  %cmp229.not.not.5.1 = icmp slt i32 %add228.5.1, %.774.1
  %spec.select.5.1 = select i1 %cmp229.not.not.5.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.20.vec.insert1562 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1537, float %spec.select.5.1, i64 1
  %add228.6.1 = add nuw nsw i32 %add222, 18
  %cmp229.not.not.6.1 = icmp slt i32 %add228.6.1, %.774.1
  %spec.select.6.1 = select i1 %cmp229.not.not.6.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.24.vec.insert1587 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1562, float %spec.select.6.1, i64 2
  %add228.7.1 = add nuw nsw i32 %add222, 19
  %cmp229.not.not.7.1 = icmp slt i32 %add228.7.1, %.774.1
  %spec.select.7.1 = select i1 %cmp229.not.not.7.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.28.vec.insert1612 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1587, float %spec.select.7.1, i64 3
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.1, <4 x half> %q.sroa.0.0.copyload1626, <4 x float> %scores.sroa.0.12.vec.insert1496)
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.1, <4 x half> %q.sroa.0.0.copyload1626, <4 x float> %scores.sroa.90.28.vec.insert1612)
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.1, <4 x half> %q.sroa.6.0.copyload1627, <4 x float> %160)
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.1, <4 x half> %q.sroa.6.0.copyload1627, <4 x float> %161)
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.1, <4 x half> %q.sroa.8.16.copyload1630, <4 x float> %162)
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.1, <4 x half> %q.sroa.8.16.copyload1630, <4 x float> %163)
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.1, <4 x half> %q.sroa.12.16.copyload1631, <4 x float> %164)
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.1, <4 x half> %q.sroa.12.16.copyload1631, <4 x float> %165)
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.1, <4 x half> %q.sroa.14.32.copyload1634, <4 x float> %166)
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.1, <4 x half> %q.sroa.14.32.copyload1634, <4 x float> %167)
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.1, <4 x half> %q.sroa.18.32.copyload1635, <4 x float> %168)
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.1, <4 x half> %q.sroa.18.32.copyload1635, <4 x float> %169)
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.1, <4 x half> %q.sroa.20.48.copyload1638, <4 x float> %170)
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.1, <4 x half> %q.sroa.20.48.copyload1638, <4 x float> %171)
  %174 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.1, <4 x half> %q.sroa.24.48.copyload1639, <4 x float> %172)
  %175 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.1, <4 x half> %q.sroa.24.48.copyload1639, <4 x float> %173)
  %scores.sroa.0.0.vec.extract1423 = extractelement <4 x float> %174, i64 0
  %mul314.1845 = fmul contract float %scores.sroa.0.0.vec.extract1423, 0x3FC2776C60000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1845, float 1.500000e+01)
  %cmp.i.i.1846 = fcmp contract olt float %176, -1.260000e+02
  %cond.i.i724.1847 = select contract i1 %cmp.i.i.1846, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.1848 = fadd contract float %176, %cond.i.i724.1847
  %177 = tail call contract float @llvm.exp2.f32(float %add.i.i725.1848)
  %cond2.i.i.1849 = select contract i1 %cmp.i.i.1846, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1850 = fmul contract float %cond2.i.i.1849, %177
  %scores.sroa.0.4.vec.extract1448 = extractelement <4 x float> %174, i64 1
  %mul314.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1448, 0x3FC2776C60000000
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1.1, float 1.500000e+01)
  %cmp.i.i.1.1 = fcmp contract olt float %178, -1.260000e+02
  %cond.i.i724.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.1.1 = fadd contract float %178, %cond.i.i724.1.1
  %179 = tail call contract float @llvm.exp2.f32(float %add.i.i725.1.1)
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %179
  %scores.sroa.0.8.vec.extract1473 = extractelement <4 x float> %174, i64 2
  %mul314.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1473, 0x3FC2776C60000000
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul314.2.1, float 1.500000e+01)
  %cmp.i.i.2.1 = fcmp contract olt float %180, -1.260000e+02
  %cond.i.i724.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.2.1 = fadd contract float %180, %cond.i.i724.2.1
  %181 = tail call contract float @llvm.exp2.f32(float %add.i.i725.2.1)
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %181
  %scores.sroa.0.12.vec.extract1498 = extractelement <4 x float> %174, i64 3
  %mul314.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1498, 0x3FC2776C60000000
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul314.3.1, float 1.500000e+01)
  %cmp.i.i.3.1 = fcmp contract olt float %182, -1.260000e+02
  %cond.i.i724.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.3.1 = fadd contract float %182, %cond.i.i724.3.1
  %183 = tail call contract float @llvm.exp2.f32(float %add.i.i725.3.1)
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %183
  %scores.sroa.90.16.vec.extract1539 = extractelement <4 x float> %175, i64 0
  %mul314.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1539, 0x3FC2776C60000000
  %184 = tail call contract noundef float @llvm.minnum.f32(float %mul314.4.1, float 1.500000e+01)
  %cmp.i.i.4.1 = fcmp contract olt float %184, -1.260000e+02
  %cond.i.i724.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.4.1 = fadd contract float %184, %cond.i.i724.4.1
  %185 = tail call contract float @llvm.exp2.f32(float %add.i.i725.4.1)
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %185
  %scores.sroa.90.20.vec.extract1564 = extractelement <4 x float> %175, i64 1
  %mul314.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1564, 0x3FC2776C60000000
  %186 = tail call contract noundef float @llvm.minnum.f32(float %mul314.5.1, float 1.500000e+01)
  %cmp.i.i.5.1 = fcmp contract olt float %186, -1.260000e+02
  %cond.i.i724.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.5.1 = fadd contract float %186, %cond.i.i724.5.1
  %187 = tail call contract float @llvm.exp2.f32(float %add.i.i725.5.1)
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %187
  %scores.sroa.90.24.vec.extract1589 = extractelement <4 x float> %175, i64 2
  %mul314.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1589, 0x3FC2776C60000000
  %188 = tail call contract noundef float @llvm.minnum.f32(float %mul314.6.1, float 1.500000e+01)
  %cmp.i.i.6.1 = fcmp contract olt float %188, -1.260000e+02
  %cond.i.i724.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.6.1 = fadd contract float %188, %cond.i.i724.6.1
  %189 = tail call contract float @llvm.exp2.f32(float %add.i.i725.6.1)
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %189
  %scores.sroa.90.28.vec.extract1614 = extractelement <4 x float> %175, i64 3
  %mul314.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1614, 0x3FC2776C60000000
  %190 = tail call contract noundef float @llvm.minnum.f32(float %mul314.7.1, float 1.500000e+01)
  %cmp.i.i.7.1 = fcmp contract olt float %190, -1.260000e+02
  %cond.i.i724.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i725.7.1 = fadd contract float %190, %cond.i.i724.7.1
  %191 = tail call contract float @llvm.exp2.f32(float %add.i.i725.7.1)
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %191
  %add334.1851 = fadd contract float %mul.i.i.1850, 0.000000e+00
  %add334.1.1 = fadd contract float %add334.1851, %mul.i.i.4.1
  %add334.2.1 = fadd contract float %add334.1.1, %mul.i.i.1.1
  %add334.3.1 = fadd contract float %add334.2.1, %mul.i.i.5.1
  %add334.4.1 = fadd contract float %add334.3.1, %mul.i.i.2.1
  %add334.5.1 = fadd contract float %add334.4.1, %mul.i.i.6.1
  %add334.6.1 = fadd contract float %add334.5.1, %mul.i.i.3.1
  %add334.7.1 = fadd contract float %add334.6.1, %mul.i.i.7.1
  %192 = bitcast float %add334.7.1 to i32
  %193 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %194 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %193) #11
  %xor.i.i.1 = xor i32 %194, 32
  %195 = and i32 %194, -64
  %and.i.i.1 = add nsw i32 %195, 64
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1
  %cond.i.i726.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %194
  %shl.i.i.1 = shl i32 %cond.i.i726.1, 2
  %196 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %192)
  %197 = bitcast i32 %196 to float
  %add.i.1 = fadd contract float %add334.7.1, %197
  %198 = bitcast float %add.i.1 to i32
  %199 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %200 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %199) #11
  %xor.i.i727.1 = xor i32 %200, 16
  %201 = and i32 %200, -64
  %and.i.i728.1 = add nsw i32 %201, 64
  %cmp.not.i.i729.1 = icmp slt i32 %xor.i.i727.1, %and.i.i728.1
  %cond.i.i730.1 = select i1 %cmp.not.i.i729.1, i32 %xor.i.i727.1, i32 %200
  %shl.i.i731.1 = shl i32 %cond.i.i730.1, 2
  %202 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i731.1, i32 %198)
  %203 = bitcast i32 %202 to float
  %add.i.i.1 = fadd contract float %add.i.1, %203
  %cmp343.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1
  %condval_8.0.1 = select i1 %cmp343.1, float %div.1, float 0.000000e+00
  %mul356.1852 = fmul contract float %condval_8.0.1, %mul.i.i.1850
  %mul356.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1
  %mul356.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1
  %mul356.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1
  %mul356.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1
  %mul356.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1
  %mul356.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1
  %mul356.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.1852)
  %205 = insertelement <4 x i16> poison, i16 %204, i64 0
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.1.1)
  %207 = insertelement <4 x i16> %205, i16 %206, i64 1
  %208 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.2.1)
  %209 = insertelement <4 x i16> %207, i16 %208, i64 2
  %210 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.3.1)
  %211 = insertelement <4 x i16> %209, i16 %210, i64 3
  %prob.sroa.0.6.vec.insert1349 = bitcast <4 x i16> %211 to <4 x half>
  %212 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.4.1)
  %213 = insertelement <4 x i16> poison, i16 %212, i64 0
  %214 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.5.1)
  %215 = insertelement <4 x i16> %213, i16 %214, i64 1
  %216 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.6.1)
  %217 = insertelement <4 x i16> %215, i16 %216, i64 2
  %218 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.7.1)
  %219 = insertelement <4 x i16> %217, i16 %218, i64 3
  %prob.sroa.12.14.vec.insert1359 = bitcast <4 x i16> %219 to <4 x half>
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer)
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %220)
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %221)
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %222)
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %223)
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %224)
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %225)
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %226)
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %227)
  %out.sroa.0.0.vec.extract900 = extractelement <4 x float> %228, i64 0
  %236 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract900)
  %output_reg.sroa.0.0.insert.ext1092 = zext i16 %236 to i64
  %out.sroa.0.4.vec.extract905 = extractelement <4 x float> %228, i64 1
  %237 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract905)
  %output_reg.sroa.0.2.insert.ext1096 = zext i16 %237 to i64
  %output_reg.sroa.0.2.insert.shift1097 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1096, 16
  %output_reg.sroa.0.2.insert.insert1099 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1097, %output_reg.sroa.0.0.insert.ext1092
  %out.sroa.0.8.vec.extract910 = extractelement <4 x float> %228, i64 2
  %238 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract910)
  %output_reg.sroa.0.4.insert.ext1107 = zext i16 %238 to i64
  %output_reg.sroa.0.4.insert.shift1108 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1107, 32
  %output_reg.sroa.0.4.insert.insert1110 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1099, %output_reg.sroa.0.4.insert.shift1108
  %out.sroa.0.12.vec.extract915 = extractelement <4 x float> %228, i64 3
  %239 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract915)
  %output_reg.sroa.0.6.insert.ext1112 = zext i16 %239 to i64
  %output_reg.sroa.0.6.insert.shift1113 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1112, 48
  %output_reg.sroa.0.6.insert.insert1115 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1110, %output_reg.sroa.0.6.insert.shift1113
  %out.sroa.26.16.vec.extract924 = extractelement <4 x float> %229, i64 0
  %240 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract924)
  %output_reg.sroa.16.8.insert.ext1124 = zext i16 %240 to i64
  %out.sroa.26.20.vec.extract929 = extractelement <4 x float> %229, i64 1
  %241 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract929)
  %output_reg.sroa.16.10.insert.ext1128 = zext i16 %241 to i64
  %output_reg.sroa.16.10.insert.shift1129 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1128, 16
  %output_reg.sroa.16.10.insert.insert1131 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1129, %output_reg.sroa.16.8.insert.ext1124
  %out.sroa.26.24.vec.extract934 = extractelement <4 x float> %229, i64 2
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract934)
  %output_reg.sroa.16.12.insert.ext1139 = zext i16 %242 to i64
  %output_reg.sroa.16.12.insert.shift1140 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1139, 32
  %output_reg.sroa.16.12.insert.insert1142 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1131, %output_reg.sroa.16.12.insert.shift1140
  %out.sroa.26.28.vec.extract939 = extractelement <4 x float> %229, i64 3
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract939)
  %output_reg.sroa.16.14.insert.ext1144 = zext i16 %243 to i64
  %output_reg.sroa.16.14.insert.shift1145 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1144, 48
  %output_reg.sroa.16.14.insert.insert1147 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1142, %output_reg.sroa.16.14.insert.shift1145
  %out.sroa.50.32.vec.extract948 = extractelement <4 x float> %230, i64 0
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract948)
  %output_reg.sroa.30.16.insert.ext1156 = zext i16 %244 to i64
  %out.sroa.50.36.vec.extract953 = extractelement <4 x float> %230, i64 1
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract953)
  %output_reg.sroa.30.18.insert.ext1160 = zext i16 %245 to i64
  %output_reg.sroa.30.18.insert.shift1161 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1160, 16
  %output_reg.sroa.30.18.insert.insert1163 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1161, %output_reg.sroa.30.16.insert.ext1156
  %out.sroa.50.40.vec.extract958 = extractelement <4 x float> %230, i64 2
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract958)
  %output_reg.sroa.30.20.insert.ext1171 = zext i16 %246 to i64
  %output_reg.sroa.30.20.insert.shift1172 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1171, 32
  %output_reg.sroa.30.20.insert.insert1174 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1163, %output_reg.sroa.30.20.insert.shift1172
  %out.sroa.50.44.vec.extract963 = extractelement <4 x float> %230, i64 3
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract963)
  %output_reg.sroa.30.22.insert.ext1176 = zext i16 %247 to i64
  %output_reg.sroa.30.22.insert.shift1177 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1176, 48
  %output_reg.sroa.30.22.insert.insert1179 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1174, %output_reg.sroa.30.22.insert.shift1177
  %out.sroa.74.48.vec.extract972 = extractelement <4 x float> %231, i64 0
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract972)
  %output_reg.sroa.44.24.insert.ext1188 = zext i16 %248 to i64
  %out.sroa.74.52.vec.extract977 = extractelement <4 x float> %231, i64 1
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract977)
  %output_reg.sroa.44.26.insert.ext1192 = zext i16 %249 to i64
  %output_reg.sroa.44.26.insert.shift1193 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1192, 16
  %output_reg.sroa.44.26.insert.insert1195 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1193, %output_reg.sroa.44.24.insert.ext1188
  %out.sroa.74.56.vec.extract982 = extractelement <4 x float> %231, i64 2
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract982)
  %output_reg.sroa.44.28.insert.ext1203 = zext i16 %250 to i64
  %output_reg.sroa.44.28.insert.shift1204 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1203, 32
  %output_reg.sroa.44.28.insert.insert1206 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1195, %output_reg.sroa.44.28.insert.shift1204
  %out.sroa.74.60.vec.extract987 = extractelement <4 x float> %231, i64 3
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract987)
  %output_reg.sroa.44.30.insert.ext1208 = zext i16 %251 to i64
  %output_reg.sroa.44.30.insert.shift1209 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1208, 48
  %output_reg.sroa.44.30.insert.insert1211 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1206, %output_reg.sroa.44.30.insert.shift1209
  %out.sroa.98.64.vec.extract996 = extractelement <4 x float> %232, i64 0
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract996)
  %output_reg.sroa.58.32.insert.ext1220 = zext i16 %252 to i64
  %out.sroa.98.68.vec.extract1001 = extractelement <4 x float> %232, i64 1
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract1001)
  %output_reg.sroa.58.34.insert.ext1224 = zext i16 %253 to i64
  %output_reg.sroa.58.34.insert.shift1225 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1224, 16
  %output_reg.sroa.58.34.insert.insert1227 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1225, %output_reg.sroa.58.32.insert.ext1220
  %out.sroa.98.72.vec.extract1006 = extractelement <4 x float> %232, i64 2
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract1006)
  %output_reg.sroa.58.36.insert.ext1235 = zext i16 %254 to i64
  %output_reg.sroa.58.36.insert.shift1236 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1235, 32
  %output_reg.sroa.58.36.insert.insert1238 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1227, %output_reg.sroa.58.36.insert.shift1236
  %out.sroa.98.76.vec.extract1011 = extractelement <4 x float> %232, i64 3
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract1011)
  %output_reg.sroa.58.38.insert.ext1240 = zext i16 %255 to i64
  %output_reg.sroa.58.38.insert.shift1241 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1240, 48
  %output_reg.sroa.58.38.insert.insert1243 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1238, %output_reg.sroa.58.38.insert.shift1241
  %out.sroa.122.80.vec.extract1020 = extractelement <4 x float> %233, i64 0
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract1020)
  %output_reg.sroa.72.40.insert.ext1252 = zext i16 %256 to i64
  %out.sroa.122.84.vec.extract1025 = extractelement <4 x float> %233, i64 1
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract1025)
  %output_reg.sroa.72.42.insert.ext1256 = zext i16 %257 to i64
  %output_reg.sroa.72.42.insert.shift1257 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1256, 16
  %output_reg.sroa.72.42.insert.insert1259 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1257, %output_reg.sroa.72.40.insert.ext1252
  %out.sroa.122.88.vec.extract1030 = extractelement <4 x float> %233, i64 2
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract1030)
  %output_reg.sroa.72.44.insert.ext1267 = zext i16 %258 to i64
  %output_reg.sroa.72.44.insert.shift1268 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1267, 32
  %output_reg.sroa.72.44.insert.insert1270 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1259, %output_reg.sroa.72.44.insert.shift1268
  %out.sroa.122.92.vec.extract1035 = extractelement <4 x float> %233, i64 3
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract1035)
  %output_reg.sroa.72.46.insert.ext1272 = zext i16 %259 to i64
  %output_reg.sroa.72.46.insert.shift1273 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1272, 48
  %output_reg.sroa.72.46.insert.insert1275 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1270, %output_reg.sroa.72.46.insert.shift1273
  %out.sroa.146.96.vec.extract1044 = extractelement <4 x float> %234, i64 0
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract1044)
  %output_reg.sroa.86.48.insert.ext1284 = zext i16 %260 to i64
  %out.sroa.146.100.vec.extract1049 = extractelement <4 x float> %234, i64 1
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract1049)
  %output_reg.sroa.86.50.insert.ext1288 = zext i16 %261 to i64
  %output_reg.sroa.86.50.insert.shift1289 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1288, 16
  %output_reg.sroa.86.50.insert.insert1291 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1289, %output_reg.sroa.86.48.insert.ext1284
  %out.sroa.146.104.vec.extract1054 = extractelement <4 x float> %234, i64 2
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract1054)
  %output_reg.sroa.86.52.insert.ext1299 = zext i16 %262 to i64
  %output_reg.sroa.86.52.insert.shift1300 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1299, 32
  %output_reg.sroa.86.52.insert.insert1302 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1291, %output_reg.sroa.86.52.insert.shift1300
  %out.sroa.146.108.vec.extract1059 = extractelement <4 x float> %234, i64 3
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract1059)
  %output_reg.sroa.86.54.insert.ext1304 = zext i16 %263 to i64
  %output_reg.sroa.86.54.insert.shift1305 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1304, 48
  %output_reg.sroa.86.54.insert.insert1307 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1302, %output_reg.sroa.86.54.insert.shift1305
  %out.sroa.170.112.vec.extract1068 = extractelement <4 x float> %235, i64 0
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1068)
  %output_reg.sroa.100.56.insert.ext1316 = zext i16 %264 to i64
  %out.sroa.170.116.vec.extract1073 = extractelement <4 x float> %235, i64 1
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1073)
  %output_reg.sroa.100.58.insert.ext1320 = zext i16 %265 to i64
  %output_reg.sroa.100.58.insert.shift1321 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1320, 16
  %output_reg.sroa.100.58.insert.insert1323 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1321, %output_reg.sroa.100.56.insert.ext1316
  %out.sroa.170.120.vec.extract1078 = extractelement <4 x float> %235, i64 2
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1078)
  %output_reg.sroa.100.60.insert.ext1331 = zext i16 %266 to i64
  %output_reg.sroa.100.60.insert.shift1332 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1331, 32
  %output_reg.sroa.100.60.insert.insert1334 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1323, %output_reg.sroa.100.60.insert.shift1332
  %out.sroa.170.124.vec.extract1083 = extractelement <4 x float> %235, i64 3
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1083)
  %output_reg.sroa.100.62.insert.ext1336 = zext i16 %267 to i64
  %output_reg.sroa.100.62.insert.shift1337 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1336, 48
  %output_reg.sroa.100.62.insert.insert1339 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1334, %output_reg.sroa.100.62.insert.shift1337
  br label %if.end473.1

if.end473.1:                                      ; preds = %if.end139.1, %for.body453.preheader.1
  %add.ptr564.idx.3.1.pre-phi = phi i32 [ %add.ptr188.idx.3.1, %if.end139.1 ], [ %.pre1770, %for.body453.preheader.1 ]
  %add.ptr564.idx.2.1.pre-phi = phi i32 [ %add.ptr188.idx.2.1, %if.end139.1 ], [ %.pre1767, %for.body453.preheader.1 ]
  %add.ptr564.idx.1.1.pre-phi = phi i32 [ %add.ptr188.idx.1.1, %if.end139.1 ], [ %.pre1764, %for.body453.preheader.1 ]
  %add.ptr564.idx.1886.pre-phi = phi i32 [ %add.ptr188.idx.1830, %if.end139.1 ], [ %.pre1761, %for.body453.preheader.1 ]
  %add488.7.1.pre-phi = phi i32 [ %add159.7.1, %if.end139.1 ], [ %.pre1759, %for.body453.preheader.1 ]
  %add488.6.1.pre-phi = phi i32 [ %add159.6.1, %if.end139.1 ], [ %.pre1758, %for.body453.preheader.1 ]
  %add488.5.1.pre-phi = phi i32 [ %add159.5.1, %if.end139.1 ], [ %.pre1757, %for.body453.preheader.1 ]
  %add488.4.1.pre-phi = phi i32 [ %add159.4.1, %if.end139.1 ], [ %.pre1756, %for.body453.preheader.1 ]
  %add488.3.1.pre-phi = phi i32 [ %add159.3.1, %if.end139.1 ], [ %.pre1755, %for.body453.preheader.1 ]
  %add488.2.1.pre-phi = phi i32 [ %add159.2.1, %if.end139.1 ], [ %.pre1754, %for.body453.preheader.1 ]
  %add488.1.1.pre-phi = phi i32 [ %add159.1.1, %if.end139.1 ], [ %.pre, %for.body453.preheader.1 ]
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1339, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1307, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1275, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1243, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1211, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1179, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1147, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1115, %if.end139.1 ], [ 0, %for.body453.preheader.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor491.1878 = xor i32 %shr158, %and183
  %mul492.1879 = shl nuw nsw i32 %xor491.1878, 3
  %add493.1880 = add nuw nsw i32 %mul492.1879, %mul177
  %add498.1881 = or disjoint i32 %add493.1880, %mul497
  %add.ptr500.1882 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.1881
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr500.1882, align 8
  %xor491.1.1 = xor i32 %add488.1.1.pre-phi, %and183
  %mul492.1.1 = shl nuw nsw i32 %xor491.1.1, 3
  %add493.1.1 = add nuw nsw i32 %mul492.1.1, %mul177
  %add498.1.1 = or disjoint i32 %add493.1.1, %mul497
  %add.ptr500.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.1.1
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr500.1.1, align 8
  %xor491.2.1 = xor i32 %add488.2.1.pre-phi, %and183
  %mul492.2.1 = shl nuw nsw i32 %xor491.2.1, 3
  %add493.2.1 = add nuw nsw i32 %mul492.2.1, %mul177
  %add498.2.1 = or disjoint i32 %add493.2.1, %mul497
  %add.ptr500.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.2.1
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr500.2.1, align 8
  %xor491.3.1 = xor i32 %add488.3.1.pre-phi, %and183
  %mul492.3.1 = shl nuw nsw i32 %xor491.3.1, 3
  %add493.3.1 = add nuw nsw i32 %mul492.3.1, %mul177
  %add498.3.1 = or disjoint i32 %add493.3.1, %mul497
  %add.ptr500.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.3.1
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr500.3.1, align 8
  %xor491.4.1 = xor i32 %add488.4.1.pre-phi, %and183
  %mul492.4.1 = shl nuw nsw i32 %xor491.4.1, 3
  %add493.4.1 = add nuw nsw i32 %mul492.4.1, %mul177
  %add498.4.1 = or disjoint i32 %add493.4.1, %mul497
  %add.ptr500.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.4.1
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr500.4.1, align 8
  %xor491.5.1 = xor i32 %add488.5.1.pre-phi, %and183
  %mul492.5.1 = shl nuw nsw i32 %xor491.5.1, 3
  %add493.5.1 = add nuw nsw i32 %mul492.5.1, %mul177
  %add498.5.1 = or disjoint i32 %add493.5.1, %mul497
  %add.ptr500.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.5.1
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr500.5.1, align 8
  %xor491.6.1 = xor i32 %add488.6.1.pre-phi, %and183
  %mul492.6.1 = shl nuw nsw i32 %xor491.6.1, 3
  %add493.6.1 = add nuw nsw i32 %mul492.6.1, %mul177
  %add498.6.1 = or disjoint i32 %add493.6.1, %mul497
  %add.ptr500.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.6.1
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr500.6.1, align 8
  %xor491.7.1 = xor i32 %add488.7.1.pre-phi, %and183
  %mul492.7.1 = shl nuw nsw i32 %xor491.7.1, 3
  %add493.7.1 = add nuw nsw i32 %mul492.7.1, %mul177
  %add498.7.1 = or disjoint i32 %add493.7.1, %mul497
  %add.ptr500.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.7.1
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr500.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr564.1887 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 %add.ptr564.idx.1886.pre-phi
  %condval_11.0.1888 = shl nuw nsw i32 %.774.1, 11
  %add574.1889 = add i32 %mul568, %condval_11.0.1888
  %idx.ext575.1890 = sext i32 %add574.1889 to i64
  %add.ptr576.1891 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.1890
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.1891, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1887, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  %gep769.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1024
  %add.ptr564.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.1.1, i32 %add.ptr564.idx.1.1.pre-phi
  %add569.1.1 = add nsw i32 %mul568, 512
  %add574.1.1 = add i32 %add569.1.1, %condval_11.0.1888
  %idx.ext575.1.1 = sext i32 %add574.1.1 to i64
  %add.ptr576.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.1.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1.1, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  %gep769.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2048
  %add.ptr564.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.2.1, i32 %add.ptr564.idx.2.1.pre-phi
  %add569.2.1 = add nsw i32 %mul568, 1024
  %add574.2.1 = add i32 %add569.2.1, %condval_11.0.1888
  %idx.ext575.2.1 = sext i32 %add574.2.1 to i64
  %add.ptr576.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.2.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.2.1, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  %gep769.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3072
  %add.ptr564.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.3.1, i32 %add.ptr564.idx.3.1.pre-phi
  %add569.3.1 = add nsw i32 %mul568, 1536
  %add574.3.1 = add i32 %add569.3.1, %condval_11.0.1888
  %idx.ext575.3.1 = sext i32 %add574.3.1 to i64
  %add.ptr576.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.3.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.3.1, i64 16, i1 false), !tbaa.struct !191, !call_argsrelate !192
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end585

if.end585:                                        ; preds = %if.end473, %if.end473.1, %entry
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

declare i32 @llvm.smin.i32(i32, i32) #9

declare float @llvm.minnum.f32(float, float) #9

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

declare i64 @llvm.umin.i64(i64, i64) #9

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


