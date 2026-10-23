; ModuleID = 'experiments/20261017_resume/window_pair_shared_binary/oj6_m3_p1.bc'
source_filename = "/tmp/tmpk7np81eg/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_pure_virtual() local_unnamed_addr #0 !dbg !5 {
entry:
  tail call void @llvm.trap(), !dbg !9
  unreachable, !dbg !10
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #1

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 !dbg !11 {
entry:
  tail call void @llvm.trap(), !dbg !12
  unreachable, !dbg !13
}

; Function Attrs: mustprogress nounwind
define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 !dbg !14 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr(), !dbg !16
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32, !dbg !16
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !dbg !16, !tbaa !17
  %2 = inttoptr i64 %1 to ptr, !dbg !16
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40, !dbg !16
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !dbg !16, !tbaa !17
  %4 = inttoptr i64 %3 to ptr, !dbg !16
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12, !dbg !16
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16, !dbg !16
  %5 = load ptr, ptr %thread_counter.i, align 8, !dbg !16, !tbaa !21
  %cmp.not.i = icmp eq ptr %5, null, !dbg !16
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i, !dbg !16

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr(), !dbg !16
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12, !dbg !16
  %8 = load i32, ptr addrspace(4) %7, align 4, !dbg !16, !range !28, !invariant.load !8
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4, !dbg !16
  %10 = load i32, ptr addrspace(4) %9, align 4, !dbg !16, !invariant.load !8
  %conv.i14.i.i = and i32 %10, 65535, !dbg !16
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i, !dbg !16
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i, !dbg !16
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i, !dbg !16
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32, !dbg !16
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i, !dbg !16
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16, !dbg !16
  %12 = load i32, ptr addrspace(4) %11, align 4, !dbg !16, !range !28, !invariant.load !8
  %13 = lshr i32 %10, 16, !dbg !16
  %div.i.i.i = udiv i32 %12, %13, !dbg !16
  %mul.i.i.i = mul i32 %div.i.i.i, %13, !dbg !16
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i, !dbg !16
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32, !dbg !16
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i, !dbg !16
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !dbg !16, !range !29
  %mul.i.i = mul i32 %add.i.i.i, %14, !dbg !16
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !16, !range !29
  %mul320.i.i = add i32 %mul.i.i, %15, !dbg !16
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i, !dbg !16
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !16, !range !29
  %add8.i.i = add i32 %add.i.i, %16, !dbg !16
  %conv.i.i = zext i32 %add8.i.i to i64, !dbg !16
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i, !dbg !16
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i), !dbg !16
  br label %while.cond.i, !dbg !16

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i, !dbg !16

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit.i, !dbg !16

if.end.i.i:                                       ; preds = %while.cond.i
  %19 = atomicrmw or ptr %arrayidx.i, i32 0 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit.i, !dbg !16

_Z9atomicAddPii.exit.i:                           ; preds = %if.end.i.i, %if.then.i.i
  %retval.0.i.i = phi i32 [ %18, %if.then.i.i ], [ %19, %if.end.i.i ], !dbg !16
  %cmp6.i = icmp sgt i32 %retval.0.i.i, 0, !dbg !16
  br i1 %cmp6.i, label %while.body.i, label %if.end.i, !dbg !16

while.body.i:                                     ; preds = %_Z9atomicAddPii.exit.i
  tail call void @llvm.mxc.sleep(i32 1), !dbg !16
  br label %while.cond.i, !dbg !16, !llvm.loop !31

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i), !dbg !16
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i, !dbg !16

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  %add.i37.i = add nsw i32 %21, -1, !dbg !16
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ], !dbg !16
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4, !dbg !16
  %23 = load i32, ptr %call_deep.i, align 4, !dbg !16, !tbaa !33
  %cmp8.i = icmp eq i32 %23, 0, !dbg !16
  br i1 %cmp8.i, label %if.then9.i, label %if.else.i, !dbg !16

if.then9.i:                                       ; preds = %_Z9atomicAddPii.exit38.i
  %cmp10.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp10.i, label %if.then11.i, label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.then11.i:                                      ; preds = %if.then9.i
  tail call void @llvm.mxc.sleep(i32 30), !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.else.i:                                        ; preds = %_Z9atomicAddPii.exit38.i
  %parent_wrap13.i = getelementptr inbounds i8, ptr %4, i64 24, !dbg !16
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !dbg !16, !tbaa !34
  %25 = load i32, ptr %4, align 8, !dbg !16, !tbaa !35
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16, !dbg !16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !dbg !16, !tbaa !21
  %idxprom.i = zext i32 %25 to i64, !dbg !16
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i, !dbg !16
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i, !dbg !16

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24, !dbg !16
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !dbg !16, !tbaa !36
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64, !dbg !16
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i, !dbg !16
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96, !dbg !16
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80, !dbg !16
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !dbg !16, !tbaa !38
  %29 = inttoptr i64 %28 to ptr, !dbg !16
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295, !dbg !16
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i, !dbg !16
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i), !dbg !16
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i, !dbg !16

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  %and.i.i.i = and i32 %31, 2147483647, !dbg !16
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  br label %if.end20.i, !dbg !16

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %if.end20.i, !dbg !16

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i), !dbg !16
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i, !dbg !16

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  %add.i42.i = add nsw i32 %34, -1, !dbg !16
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void, !dbg !39
}

; Function Attrs: convergent mustprogress norecurse nounwind willreturn
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(1) noalias nocapture noundef readonly %Schedule.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !42, !range !29
  %mul = mul nuw nsw i32 %0, 80, !dbg !46
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !47, !range !29
  %add = add nuw nsw i32 %mul, %1, !dbg !50
  %idxprom = zext nneg i32 %add to i64, !dbg !51
  %arrayidx = getelementptr inbounds i64, ptr addrspace(1) %Schedule.coerce, i64 %idxprom, !dbg !51
  %2 = load i64, ptr addrspace(1) %arrayidx, align 8, !dbg !51, !tbaa !17
  %and = and i64 %2, 65535, !dbg !52
  %cmp.not = icmp eq i64 %and, 0, !dbg !53
  br i1 %cmp.not, label %if.end585, label %for.cond.preheader, !dbg !54

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
  %conv = trunc nuw nsw i64 %and to i32, !dbg !56
  %.774 = tail call i32 @llvm.smin.i32(i32 %conv, i32 1024)
  %cmp109 = icmp slt i32 %mul108, %.774
  %or.cond701 = select i1 %or.cond, i1 %cmp109, i1 false, !dbg !57
  br i1 %or.cond701, label %for.body116.preheader, label %for.body453.preheader, !dbg !57

for.body453.preheader:                            ; preds = %for.cond.preheader
  %.pre1771 = add nuw nsw i32 %shr158, 2, !dbg !58
  %.pre1772 = add nuw nsw i32 %shr158, 4, !dbg !58
  %.pre1773 = add nuw nsw i32 %shr158, 6, !dbg !58
  %.pre1774 = add nuw nsw i32 %shr158, 8, !dbg !58
  %.pre1775 = add nuw nsw i32 %shr158, 10, !dbg !58
  %.pre1776 = add nuw nsw i32 %shr158, 12, !dbg !58
  %.pre1777 = add nuw nsw i32 %shr158, 14, !dbg !58
  %.pre1778 = xor i32 %shr180, %and183, !dbg !59
  %.pre1779 = shl nuw nsw i32 %.pre1778, 4, !dbg !60
  %.pre1780 = add nuw nsw i32 %shr180, 4, !dbg !61
  %.pre1781 = xor i32 %.pre1780, %and183, !dbg !59
  %.pre1782 = shl nuw nsw i32 %.pre1781, 4, !dbg !60
  %.pre1783 = add nuw nsw i32 %shr180, 8, !dbg !61
  %.pre1784 = xor i32 %.pre1783, %and183, !dbg !59
  %.pre1785 = shl nuw nsw i32 %.pre1784, 4, !dbg !60
  %.pre1786 = add nuw nsw i32 %shr180, 12, !dbg !61
  %.pre1787 = xor i32 %.pre1786, %and183, !dbg !59
  %.pre1788 = shl nuw nsw i32 %.pre1787, 4, !dbg !60
  br label %if.end473, !dbg !62

for.body116.preheader:                            ; preds = %for.cond.preheader
  %.idx = shl nuw nsw i64 %shr63, 22, !dbg !68
  %12 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx, !dbg !68
  %13 = getelementptr i8, ptr addrspace(4) %12, i64 -512, !dbg !68
  %14 = tail call i64 @llvm.umin.i64(i64 %and, i64 1024)
  %gep.idx = shl nuw nsw i64 %14, 12, !dbg !68
  %gep.7 = getelementptr i8, ptr addrspace(4) %13, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr inbounds i8, ptr addrspace(4) %gep.7, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.44.60.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.7 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.shift = shl nuw i64 %q_stage.sroa.44.60.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.44.56.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.7 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %q_stage.sroa.44.60.insert.shift, %q_stage.sroa.44.56.insert.ext, !dbg !70
  %15 = getelementptr i8, ptr addrspace(4) %12, i64 -1024, !dbg !68
  %gep.6 = getelementptr i8, ptr addrspace(4) %15, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr inbounds i8, ptr addrspace(4) %gep.6, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.6 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.6 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext, !dbg !70
  %16 = getelementptr i8, ptr addrspace(4) %12, i64 -1536, !dbg !68
  %gep.5 = getelementptr i8, ptr addrspace(4) %16, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr inbounds i8, ptr addrspace(4) %gep.5, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.5 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.5 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext, !dbg !70
  %17 = getelementptr i8, ptr addrspace(4) %12, i64 -2048, !dbg !68
  %gep.4 = getelementptr i8, ptr addrspace(4) %17, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr inbounds i8, ptr addrspace(4) %gep.4, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.4 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.4 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext, !dbg !70
  %18 = getelementptr i8, ptr addrspace(4) %12, i64 -2560, !dbg !68
  %gep.3 = getelementptr i8, ptr addrspace(4) %18, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %gep.3, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.3 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.3 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext, !dbg !70
  %19 = getelementptr i8, ptr addrspace(4) %12, i64 -3072, !dbg !68
  %gep.2 = getelementptr i8, ptr addrspace(4) %19, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %gep.2, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.2 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.2 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext, !dbg !70
  %20 = getelementptr i8, ptr addrspace(4) %12, i64 -3584, !dbg !68
  %gep.1 = getelementptr i8, ptr addrspace(4) %20, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext, !dbg !70
  %21 = getelementptr i8, ptr addrspace(4) %12, i64 -4096, !dbg !68
  %gep = getelementptr i8, ptr addrspace(4) %21, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0.copyload to i64, !dbg !70
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %gep, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0.copyload to i64, !dbg !70
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext, !dbg !70
  %invariant.gep771 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !71
  %mul129 = zext nneg i32 %8 to i64
  %gep772 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep771, i64 %mul129
  %invariant.gep742 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul129
  %.idx780 = shl nuw nsw i64 %shr100, 14, !dbg !72
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep742, i64 %.idx780, !dbg !72
  %.idx781 = shl nuw nsw i64 %shr63, 19, !dbg !72
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx781, !dbg !72
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %23, align 16, !dbg !73
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 8, !dbg !73
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8, !dbg !73
  %gep743.1 = getelementptr i8, ptr addrspace(4) %23, i64 1024, !dbg !72
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep743.1, align 16, !dbg !73
  %k.sroa.12.16.gep743.1.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 1032, !dbg !73
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep743.1.sroa_idx, align 8, !dbg !73
  %gep743.2 = getelementptr i8, ptr addrspace(4) %23, i64 2048, !dbg !72
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep743.2, align 16, !dbg !73
  %k.sroa.18.32.gep743.2.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 2056, !dbg !73
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep743.2.sroa_idx, align 8, !dbg !73
  %gep743.3 = getelementptr i8, ptr addrspace(4) %23, i64 3072, !dbg !72
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep743.3, align 16, !dbg !73
  %k.sroa.24.48.gep743.3.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 3080, !dbg !73
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep743.3.sroa_idx, align 8, !dbg !73
  %gep743.4 = getelementptr i8, ptr addrspace(4) %23, i64 4096, !dbg !72
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep743.4, align 16, !dbg !73
  %k.sroa.30.64.gep743.4.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 4104, !dbg !73
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep743.4.sroa_idx, align 8, !dbg !73
  %gep743.5 = getelementptr i8, ptr addrspace(4) %23, i64 5120, !dbg !72
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep743.5, align 16, !dbg !73
  %k.sroa.36.80.gep743.5.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 5128, !dbg !73
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep743.5.sroa_idx, align 8, !dbg !73
  %gep743.6 = getelementptr i8, ptr addrspace(4) %23, i64 6144, !dbg !72
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep743.6, align 16, !dbg !73
  %k.sroa.42.96.gep743.6.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 6152, !dbg !73
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep743.6.sroa_idx, align 8, !dbg !73
  %gep743.7 = getelementptr i8, ptr addrspace(4) %23, i64 7168, !dbg !72
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep743.7, align 16, !dbg !73
  %k.sroa.48.112.gep743.7.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 7176, !dbg !73
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep743.7.sroa_idx, align 8, !dbg !73
  %xor = xor i32 %shr158, %shr155, !dbg !74
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152, !dbg !75
  %add.ptr167.idx = shl nuw nsw i32 %xor, 4, !dbg !75
  %add.ptr167 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr167.idx, !dbg !75
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %add.ptr167, align 8, !dbg !76
  %add159.1 = add nuw nsw i32 %shr158, 2, !dbg !77
  %xor.1 = xor i32 %add159.1, %shr155, !dbg !74
  %25 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 512, !dbg !75
  %add.ptr167.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !75
  %add.ptr167.1 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr167.idx.1, !dbg !75
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %add.ptr167.1, align 8, !dbg !76
  %add159.2 = add nuw nsw i32 %shr158, 4, !dbg !77
  %xor.2 = xor i32 %add159.2, %shr155, !dbg !74
  %26 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1024, !dbg !75
  %add.ptr167.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !75
  %add.ptr167.2 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr167.idx.2, !dbg !75
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %add.ptr167.2, align 8, !dbg !76
  %add159.3 = add nuw nsw i32 %shr158, 6, !dbg !77
  %xor.3 = xor i32 %add159.3, %shr155, !dbg !74
  %27 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1536, !dbg !75
  %add.ptr167.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !75
  %add.ptr167.3 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr167.idx.3, !dbg !75
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %add.ptr167.3, align 8, !dbg !76
  %add159.4 = add nuw nsw i32 %shr158, 8, !dbg !77
  %xor.4 = xor i32 %add159.4, %shr155, !dbg !74
  %28 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2048, !dbg !75
  %add.ptr167.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !75
  %add.ptr167.4 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr167.idx.4, !dbg !75
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %add.ptr167.4, align 8, !dbg !76
  %add159.5 = add nuw nsw i32 %shr158, 10, !dbg !77
  %xor.5 = xor i32 %add159.5, %shr155, !dbg !74
  %29 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2560, !dbg !75
  %add.ptr167.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !75
  %add.ptr167.5 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr167.idx.5, !dbg !75
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %add.ptr167.5, align 8, !dbg !76
  %add159.6 = add nuw nsw i32 %shr158, 12, !dbg !77
  %xor.6 = xor i32 %add159.6, %shr155, !dbg !74
  %30 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3072, !dbg !75
  %add.ptr167.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !75
  %add.ptr167.6 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr167.idx.6, !dbg !75
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %add.ptr167.6, align 8, !dbg !76
  %add159.7 = add nuw nsw i32 %shr158, 14, !dbg !77
  %xor.7 = xor i32 %add159.7, %shr155, !dbg !74
  %31 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3584, !dbg !75
  %add.ptr167.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !75
  %add.ptr167.7 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr167.idx.7, !dbg !75
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %add.ptr167.7, align 8, !dbg !76
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %xor184 = xor i32 %shr180, %and183, !dbg !83
  %add.ptr188.idx = shl nuw nsw i32 %xor184, 4, !dbg !84
  %add.ptr188 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx, !dbg !84
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188, align 16, !dbg !85
  %q.sroa.6.0.add.ptr188.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188, i32 8, !dbg !85
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.sroa_idx, align 8, !dbg !85
  %add181.1 = add nuw nsw i32 %shr180, 4, !dbg !86
  %xor184.1 = xor i32 %add181.1, %and183, !dbg !83
  %add.ptr188.idx.1 = shl nuw nsw i32 %xor184.1, 4, !dbg !84
  %add.ptr188.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1, !dbg !84
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.1, align 16, !dbg !85
  %q.sroa.12.16.add.ptr188.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1, i32 8, !dbg !85
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.sroa_idx, align 8, !dbg !85
  %add181.2 = add nuw nsw i32 %shr180, 8, !dbg !86
  %xor184.2 = xor i32 %add181.2, %and183, !dbg !83
  %add.ptr188.idx.2 = shl nuw nsw i32 %xor184.2, 4, !dbg !84
  %add.ptr188.2 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2, !dbg !84
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.2, align 16, !dbg !85
  %q.sroa.18.32.add.ptr188.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2, i32 8, !dbg !85
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.sroa_idx, align 8, !dbg !85
  %add181.3 = add nuw nsw i32 %shr180, 12, !dbg !86
  %xor184.3 = xor i32 %add181.3, %and183, !dbg !83
  %add.ptr188.idx.3 = shl nuw nsw i32 %xor184.3, 4, !dbg !84
  %add.ptr188.3 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3, !dbg !84
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.3, align 16, !dbg !85
  %q.sroa.24.48.add.ptr188.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3, i32 8, !dbg !85
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.sroa_idx, align 8, !dbg !85
  %cmp229.not.not = icmp slt i32 %add222, %.774, !dbg !87
  %spec.select = select i1 %cmp229.not.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !89
  %add226.1 = or disjoint i32 %add222, 1, !dbg !90
  %cmp229.not.not.1 = icmp slt i32 %add226.1, %.774, !dbg !87
  %spec.select.1 = select i1 %cmp229.not.not.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !89
  %add226.2 = or disjoint i32 %add222, 2, !dbg !90
  %cmp229.not.not.2 = icmp slt i32 %add226.2, %.774, !dbg !87
  %spec.select.2 = select i1 %cmp229.not.not.2, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !89
  %add226.3 = or disjoint i32 %add222, 3, !dbg !90
  %cmp229.not.not.3 = icmp slt i32 %add226.3, %.774, !dbg !87
  %spec.select.3 = select i1 %cmp229.not.not.3, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !89
  %add228.4 = add nuw nsw i32 %add222, 16, !dbg !91
  %cmp229.not.not.4 = icmp slt i32 %add228.4, %.774, !dbg !87
  %spec.select.4 = select i1 %cmp229.not.not.4, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !89
  %add228.5 = add nuw nsw i32 %add222, 17, !dbg !91
  %cmp229.not.not.5 = icmp slt i32 %add228.5, %.774, !dbg !87
  %spec.select.5 = select i1 %cmp229.not.not.5, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1, !dbg !89
  %add228.6 = add nuw nsw i32 %add222, 18, !dbg !91
  %cmp229.not.not.6 = icmp slt i32 %add228.6, %.774, !dbg !87
  %spec.select.6 = select i1 %cmp229.not.not.6, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2, !dbg !89
  %add228.7 = add nuw nsw i32 %add222, 19, !dbg !91
  %cmp229.not.not.7 = icmp slt i32 %add228.7, %.774, !dbg !87
  %spec.select.7 = select i1 %cmp229.not.not.7, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3, !dbg !89
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !92, !call_argsrelate !93
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !dbg !92, !call_argsrelate !93
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %32), !dbg !92, !call_argsrelate !93
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %33), !dbg !92, !call_argsrelate !93
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %34), !dbg !92, !call_argsrelate !93
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %35), !dbg !92, !call_argsrelate !93
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %36), !dbg !92, !call_argsrelate !93
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %37), !dbg !92, !call_argsrelate !93
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %38), !dbg !92, !call_argsrelate !93
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %39), !dbg !92, !call_argsrelate !93
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %40), !dbg !92, !call_argsrelate !93
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %41), !dbg !92, !call_argsrelate !93
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %42), !dbg !92, !call_argsrelate !93
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %43), !dbg !92, !call_argsrelate !93
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %44), !dbg !92, !call_argsrelate !93
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %45), !dbg !92, !call_argsrelate !93
  %.idx786 = shl nuw nsw i64 %shr100, 14, !dbg !94
  %48 = getelementptr i8, ptr addrspace(4) %gep772, i64 %.idx786, !dbg !94
  %.idx787 = shl nuw nsw i64 %shr63, 19, !dbg !94
  %49 = getelementptr i8, ptr addrspace(4) %48, i64 %.idx787, !dbg !94
  %v.sroa.48.112.gep754.7.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 7176, !dbg !95
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep754.7.sroa_idx, align 8, !dbg !95
  %gep754.7 = getelementptr i8, ptr addrspace(4) %49, i64 7168, !dbg !94
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep754.7, align 16, !dbg !95
  %v.sroa.42.96.gep754.6.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 6152, !dbg !95
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep754.6.sroa_idx, align 8, !dbg !95
  %gep754.6 = getelementptr i8, ptr addrspace(4) %49, i64 6144, !dbg !94
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep754.6, align 16, !dbg !95
  %v.sroa.36.80.gep754.5.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 5128, !dbg !95
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep754.5.sroa_idx, align 8, !dbg !95
  %gep754.5 = getelementptr i8, ptr addrspace(4) %49, i64 5120, !dbg !94
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep754.5, align 16, !dbg !95
  %v.sroa.30.64.gep754.4.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 4104, !dbg !95
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep754.4.sroa_idx, align 8, !dbg !95
  %gep754.4 = getelementptr i8, ptr addrspace(4) %49, i64 4096, !dbg !94
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep754.4, align 16, !dbg !95
  %v.sroa.24.48.gep754.3.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 3080, !dbg !95
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep754.3.sroa_idx, align 8, !dbg !95
  %gep754.3 = getelementptr i8, ptr addrspace(4) %49, i64 3072, !dbg !94
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep754.3, align 16, !dbg !95
  %v.sroa.18.32.gep754.2.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 2056, !dbg !95
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep754.2.sroa_idx, align 8, !dbg !95
  %gep754.2 = getelementptr i8, ptr addrspace(4) %49, i64 2048, !dbg !94
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep754.2, align 16, !dbg !95
  %v.sroa.12.16.gep754.1.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 1032, !dbg !95
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep754.1.sroa_idx, align 8, !dbg !95
  %gep754.1 = getelementptr i8, ptr addrspace(4) %49, i64 1024, !dbg !94
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep754.1, align 16, !dbg !95
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %49, i64 8, !dbg !95
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8, !dbg !95
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %49, align 16, !dbg !95
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !96
  %mul314 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !97
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul314, float 1.500000e+01), !dbg !98
  %cmp.i.i = fcmp contract olt float %50, -1.260000e+02, !dbg !102
  %cond.i.i724 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725 = fadd contract float %50, %cond.i.i724, !dbg !102
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i725), !dbg !102
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i = fmul contract float %cond2.i.i, %51, !dbg !102
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1, !dbg !96
  %mul314.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !97
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.1 = fcmp contract olt float %52, -1.260000e+02, !dbg !102
  %cond.i.i724.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.1 = fadd contract float %52, %cond.i.i724.1, !dbg !102
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i725.1), !dbg !102
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %53, !dbg !102
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2, !dbg !96
  %mul314.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !97
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul314.2, float 1.500000e+01), !dbg !98
  %cmp.i.i.2 = fcmp contract olt float %54, -1.260000e+02, !dbg !102
  %cond.i.i724.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.2 = fadd contract float %54, %cond.i.i724.2, !dbg !102
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i725.2), !dbg !102
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %55, !dbg !102
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3, !dbg !96
  %mul314.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !97
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul314.3, float 1.500000e+01), !dbg !98
  %cmp.i.i.3 = fcmp contract olt float %56, -1.260000e+02, !dbg !102
  %cond.i.i724.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.3 = fadd contract float %56, %cond.i.i724.3, !dbg !102
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i725.3), !dbg !102
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %57, !dbg !102
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %47, i64 0, !dbg !96
  %mul314.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000, !dbg !97
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul314.4, float 1.500000e+01), !dbg !98
  %cmp.i.i.4 = fcmp contract olt float %58, -1.260000e+02, !dbg !102
  %cond.i.i724.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.4 = fadd contract float %58, %cond.i.i724.4, !dbg !102
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i725.4), !dbg !102
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %59, !dbg !102
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %47, i64 1, !dbg !96
  %mul314.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000, !dbg !97
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul314.5, float 1.500000e+01), !dbg !98
  %cmp.i.i.5 = fcmp contract olt float %60, -1.260000e+02, !dbg !102
  %cond.i.i724.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.5 = fadd contract float %60, %cond.i.i724.5, !dbg !102
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i725.5), !dbg !102
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %61, !dbg !102
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %47, i64 2, !dbg !96
  %mul314.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000, !dbg !97
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul314.6, float 1.500000e+01), !dbg !98
  %cmp.i.i.6 = fcmp contract olt float %62, -1.260000e+02, !dbg !102
  %cond.i.i724.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.6 = fadd contract float %62, %cond.i.i724.6, !dbg !102
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i725.6), !dbg !102
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %63, !dbg !102
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %47, i64 3, !dbg !96
  %mul314.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000, !dbg !97
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul314.7, float 1.500000e+01), !dbg !98
  %cmp.i.i.7 = fcmp contract olt float %64, -1.260000e+02, !dbg !102
  %cond.i.i724.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.7 = fadd contract float %64, %cond.i.i724.7, !dbg !102
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i725.7), !dbg !102
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %65, !dbg !102
  %add334 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !105
  %add334.1 = fadd contract float %add334, %mul.i.i.4, !dbg !105
  %add334.2 = fadd contract float %add334.1, %mul.i.i.1, !dbg !105
  %add334.3 = fadd contract float %add334.2, %mul.i.i.5, !dbg !105
  %add334.4 = fadd contract float %add334.3, %mul.i.i.2, !dbg !105
  %add334.5 = fadd contract float %add334.4, %mul.i.i.6, !dbg !105
  %add334.6 = fadd contract float %add334.5, %mul.i.i.3, !dbg !105
  %add334.7 = fadd contract float %add334.6, %mul.i.i.7, !dbg !105
  %66 = bitcast float %add334.7 to i32, !dbg !106
  %67 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !117
  %68 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %67) #11, !dbg !122
  %xor.i.i = xor i32 %68, 32, !dbg !123
  %69 = and i32 %68, -64, !dbg !124
  %and.i.i = add nsw i32 %69, 64, !dbg !124
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !125
  %cond.i.i726 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %68, !dbg !126
  %shl.i.i = shl i32 %cond.i.i726, 2, !dbg !127
  %70 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %66), !dbg !128
  %71 = bitcast i32 %70 to float, !dbg !129
  %add.i = fadd contract float %add334.7, %71, !dbg !130
  %72 = bitcast float %add.i to i32, !dbg !133
  %73 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !140
  %74 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %73) #11, !dbg !143
  %xor.i.i727 = xor i32 %74, 16, !dbg !144
  %75 = and i32 %74, -64, !dbg !145
  %and.i.i728 = add nsw i32 %75, 64, !dbg !145
  %cmp.not.i.i729 = icmp slt i32 %xor.i.i727, %and.i.i728, !dbg !146
  %cond.i.i730 = select i1 %cmp.not.i.i729, i32 %xor.i.i727, i32 %74, !dbg !147
  %shl.i.i731 = shl i32 %cond.i.i730, 2, !dbg !148
  %76 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i731, i32 %72), !dbg !149
  %77 = bitcast i32 %76 to float, !dbg !150
  %add.i.i = fadd contract float %add.i, %77, !dbg !151
  %cmp343 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !153
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !154
  %condval_8.0 = select i1 %cmp343, float %div, float 0.000000e+00, !dbg !154
  %mul356 = fmul contract float %condval_8.0, %mul.i.i, !dbg !155
  %mul356.1 = fmul contract float %condval_8.0, %mul.i.i.1, !dbg !155
  %mul356.2 = fmul contract float %condval_8.0, %mul.i.i.2, !dbg !155
  %mul356.3 = fmul contract float %condval_8.0, %mul.i.i.3, !dbg !155
  %mul356.4 = fmul contract float %condval_8.0, %mul.i.i.4, !dbg !155
  %mul356.5 = fmul contract float %condval_8.0, %mul.i.i.5, !dbg !155
  %mul356.6 = fmul contract float %condval_8.0, %mul.i.i.6, !dbg !155
  %mul356.7 = fmul contract float %condval_8.0, %mul.i.i.7, !dbg !155
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356), !dbg !156
  %79 = insertelement <4 x i16> poison, i16 %78, i64 0, !dbg !165
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.1), !dbg !156
  %81 = insertelement <4 x i16> %79, i16 %80, i64 1, !dbg !165
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.2), !dbg !156
  %83 = insertelement <4 x i16> %81, i16 %82, i64 2, !dbg !165
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.3), !dbg !156
  %85 = insertelement <4 x i16> %83, i16 %84, i64 3, !dbg !165
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %85 to <4 x half>, !dbg !165
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.4), !dbg !156
  %87 = insertelement <4 x i16> poison, i16 %86, i64 0, !dbg !165
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.5), !dbg !156
  %89 = insertelement <4 x i16> %87, i16 %88, i64 1, !dbg !165
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.6), !dbg !156
  %91 = insertelement <4 x i16> %89, i16 %90, i64 2, !dbg !165
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.7), !dbg !156
  %93 = insertelement <4 x i16> %91, i16 %92, i64 3, !dbg !165
  %prob.sroa.12.14.vec.insert = bitcast <4 x i16> %93 to <4 x half>, !dbg !165
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %94), !dbg !166, !call_argsrelate !93
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %95), !dbg !166, !call_argsrelate !93
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %96), !dbg !166, !call_argsrelate !93
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %97), !dbg !166, !call_argsrelate !93
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %98), !dbg !166, !call_argsrelate !93
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %99), !dbg !166, !call_argsrelate !93
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %100), !dbg !166, !call_argsrelate !93
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %101), !dbg !166, !call_argsrelate !93
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !167
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !168
  %output_reg.sroa.0.0.insert.ext = zext i16 %110 to i64, !dbg !172
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !167
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !168
  %output_reg.sroa.0.2.insert.ext = zext i16 %111 to i64, !dbg !172
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !172
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !172
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !167
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !168
  %output_reg.sroa.0.4.insert.ext = zext i16 %112 to i64, !dbg !172
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !172
  %output_reg.sroa.0.4.insert.insert1105 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !172
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !167
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !168
  %output_reg.sroa.0.6.insert.ext = zext i16 %113 to i64, !dbg !172
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !172
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1105, %output_reg.sroa.0.6.insert.shift, !dbg !172
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %103, i64 0, !dbg !167
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract), !dbg !168
  %output_reg.sroa.16.8.insert.ext = zext i16 %114 to i64, !dbg !172
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %103, i64 1, !dbg !167
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract), !dbg !168
  %output_reg.sroa.16.10.insert.ext = zext i16 %115 to i64, !dbg !172
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16, !dbg !172
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext, !dbg !172
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %103, i64 2, !dbg !167
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract), !dbg !168
  %output_reg.sroa.16.12.insert.ext = zext i16 %116 to i64, !dbg !172
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32, !dbg !172
  %output_reg.sroa.16.12.insert.insert1137 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift, !dbg !172
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %103, i64 3, !dbg !167
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract), !dbg !168
  %output_reg.sroa.16.14.insert.ext = zext i16 %117 to i64, !dbg !172
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48, !dbg !172
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1137, %output_reg.sroa.16.14.insert.shift, !dbg !172
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %104, i64 0, !dbg !167
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract), !dbg !168
  %output_reg.sroa.30.16.insert.ext = zext i16 %118 to i64, !dbg !172
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %104, i64 1, !dbg !167
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract), !dbg !168
  %output_reg.sroa.30.18.insert.ext = zext i16 %119 to i64, !dbg !172
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16, !dbg !172
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext, !dbg !172
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %104, i64 2, !dbg !167
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract), !dbg !168
  %output_reg.sroa.30.20.insert.ext = zext i16 %120 to i64, !dbg !172
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32, !dbg !172
  %output_reg.sroa.30.20.insert.insert1169 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift, !dbg !172
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %104, i64 3, !dbg !167
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract), !dbg !168
  %output_reg.sroa.30.22.insert.ext = zext i16 %121 to i64, !dbg !172
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48, !dbg !172
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1169, %output_reg.sroa.30.22.insert.shift, !dbg !172
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %105, i64 0, !dbg !167
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract), !dbg !168
  %output_reg.sroa.44.24.insert.ext = zext i16 %122 to i64, !dbg !172
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %105, i64 1, !dbg !167
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract), !dbg !168
  %output_reg.sroa.44.26.insert.ext = zext i16 %123 to i64, !dbg !172
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16, !dbg !172
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext, !dbg !172
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %105, i64 2, !dbg !167
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract), !dbg !168
  %output_reg.sroa.44.28.insert.ext = zext i16 %124 to i64, !dbg !172
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32, !dbg !172
  %output_reg.sroa.44.28.insert.insert1201 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift, !dbg !172
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %105, i64 3, !dbg !167
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract), !dbg !168
  %output_reg.sroa.44.30.insert.ext = zext i16 %125 to i64, !dbg !172
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48, !dbg !172
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1201, %output_reg.sroa.44.30.insert.shift, !dbg !172
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %106, i64 0, !dbg !167
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract), !dbg !168
  %output_reg.sroa.58.32.insert.ext = zext i16 %126 to i64, !dbg !172
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %106, i64 1, !dbg !167
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract), !dbg !168
  %output_reg.sroa.58.34.insert.ext = zext i16 %127 to i64, !dbg !172
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16, !dbg !172
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext, !dbg !172
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %106, i64 2, !dbg !167
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract), !dbg !168
  %output_reg.sroa.58.36.insert.ext = zext i16 %128 to i64, !dbg !172
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32, !dbg !172
  %output_reg.sroa.58.36.insert.insert1233 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift, !dbg !172
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %106, i64 3, !dbg !167
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract), !dbg !168
  %output_reg.sroa.58.38.insert.ext = zext i16 %129 to i64, !dbg !172
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48, !dbg !172
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1233, %output_reg.sroa.58.38.insert.shift, !dbg !172
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %107, i64 0, !dbg !167
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract), !dbg !168
  %output_reg.sroa.72.40.insert.ext = zext i16 %130 to i64, !dbg !172
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %107, i64 1, !dbg !167
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract), !dbg !168
  %output_reg.sroa.72.42.insert.ext = zext i16 %131 to i64, !dbg !172
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16, !dbg !172
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext, !dbg !172
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %107, i64 2, !dbg !167
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract), !dbg !168
  %output_reg.sroa.72.44.insert.ext = zext i16 %132 to i64, !dbg !172
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32, !dbg !172
  %output_reg.sroa.72.44.insert.insert1265 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift, !dbg !172
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %107, i64 3, !dbg !167
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract), !dbg !168
  %output_reg.sroa.72.46.insert.ext = zext i16 %133 to i64, !dbg !172
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48, !dbg !172
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1265, %output_reg.sroa.72.46.insert.shift, !dbg !172
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %108, i64 0, !dbg !167
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract), !dbg !168
  %output_reg.sroa.86.48.insert.ext = zext i16 %134 to i64, !dbg !172
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %108, i64 1, !dbg !167
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract), !dbg !168
  %output_reg.sroa.86.50.insert.ext = zext i16 %135 to i64, !dbg !172
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16, !dbg !172
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext, !dbg !172
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %108, i64 2, !dbg !167
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract), !dbg !168
  %output_reg.sroa.86.52.insert.ext = zext i16 %136 to i64, !dbg !172
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32, !dbg !172
  %output_reg.sroa.86.52.insert.insert1297 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift, !dbg !172
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %108, i64 3, !dbg !167
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract), !dbg !168
  %output_reg.sroa.86.54.insert.ext = zext i16 %137 to i64, !dbg !172
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48, !dbg !172
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1297, %output_reg.sroa.86.54.insert.shift, !dbg !172
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %109, i64 0, !dbg !167
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract), !dbg !168
  %output_reg.sroa.100.56.insert.ext = zext i16 %138 to i64, !dbg !172
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %109, i64 1, !dbg !167
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract), !dbg !168
  %output_reg.sroa.100.58.insert.ext = zext i16 %139 to i64, !dbg !172
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16, !dbg !172
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext, !dbg !172
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %109, i64 2, !dbg !167
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract), !dbg !168
  %output_reg.sroa.100.60.insert.ext = zext i16 %140 to i64, !dbg !172
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32, !dbg !172
  %output_reg.sroa.100.60.insert.insert1329 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift, !dbg !172
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %109, i64 3, !dbg !167
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract), !dbg !168
  %output_reg.sroa.100.62.insert.ext = zext i16 %141 to i64, !dbg !172
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48, !dbg !172
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1329, %output_reg.sroa.100.62.insert.shift, !dbg !172
  br label %if.end473, !dbg !62

if.end473:                                        ; preds = %for.body453.preheader, %for.body116.preheader
  %add.ptr564.idx.3.pre-phi = phi i32 [ %.pre1788, %for.body453.preheader ], [ %add.ptr188.idx.3, %for.body116.preheader ], !dbg !60
  %add.ptr564.idx.2.pre-phi = phi i32 [ %.pre1785, %for.body453.preheader ], [ %add.ptr188.idx.2, %for.body116.preheader ], !dbg !60
  %add.ptr564.idx.1.pre-phi = phi i32 [ %.pre1782, %for.body453.preheader ], [ %add.ptr188.idx.1, %for.body116.preheader ], !dbg !60
  %add.ptr564.idx.pre-phi = phi i32 [ %.pre1779, %for.body453.preheader ], [ %add.ptr188.idx, %for.body116.preheader ], !dbg !60
  %add488.7.pre-phi = phi i32 [ %.pre1777, %for.body453.preheader ], [ %add159.7, %for.body116.preheader ], !dbg !58
  %add488.6.pre-phi = phi i32 [ %.pre1776, %for.body453.preheader ], [ %add159.6, %for.body116.preheader ], !dbg !58
  %add488.5.pre-phi = phi i32 [ %.pre1775, %for.body453.preheader ], [ %add159.5, %for.body116.preheader ], !dbg !58
  %add488.4.pre-phi = phi i32 [ %.pre1774, %for.body453.preheader ], [ %add159.4, %for.body116.preheader ], !dbg !58
  %add488.3.pre-phi = phi i32 [ %.pre1773, %for.body453.preheader ], [ %add159.3, %for.body116.preheader ], !dbg !58
  %add488.2.pre-phi = phi i32 [ %.pre1772, %for.body453.preheader ], [ %add159.2, %for.body116.preheader ], !dbg !58
  %add488.1.pre-phi = phi i32 [ %.pre1771, %for.body453.preheader ], [ %add159.1, %for.body116.preheader ], !dbg !58
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
  %output_reg.sroa.100.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.100.62.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.86.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.86.54.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.72.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.72.46.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.58.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.58.38.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.44.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.44.30.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.30.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.30.22.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.16.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.16.14.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.0.0 = phi i64 [ 0, %for.body453.preheader ], [ %output_reg.sroa.0.6.insert.insert, %for.body116.preheader ], !dbg !173
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !174
  fence syncscope("warp") acquire, !dbg !175
  %xor491 = xor i32 %shr158, %and183, !dbg !176
  %mul492 = shl nuw nsw i32 %xor491, 3, !dbg !177
  %add493 = add nuw nsw i32 %mul492, %mul177, !dbg !178
  %add498 = or disjoint i32 %add493, %mul497, !dbg !179
  %add.ptr500 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498, !dbg !180
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr500, align 8, !dbg !181
  %xor491.1 = xor i32 %add488.1.pre-phi, %and183, !dbg !176
  %mul492.1 = shl nuw nsw i32 %xor491.1, 3, !dbg !177
  %add493.1 = add nuw nsw i32 %mul492.1, %mul177, !dbg !178
  %add498.1 = or disjoint i32 %add493.1, %mul497, !dbg !179
  %add.ptr500.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.1, !dbg !180
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr500.1, align 8, !dbg !181
  %xor491.2 = xor i32 %add488.2.pre-phi, %and183, !dbg !176
  %mul492.2 = shl nuw nsw i32 %xor491.2, 3, !dbg !177
  %add493.2 = add nuw nsw i32 %mul492.2, %mul177, !dbg !178
  %add498.2 = or disjoint i32 %add493.2, %mul497, !dbg !179
  %add.ptr500.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.2, !dbg !180
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr500.2, align 8, !dbg !181
  %xor491.3 = xor i32 %add488.3.pre-phi, %and183, !dbg !176
  %mul492.3 = shl nuw nsw i32 %xor491.3, 3, !dbg !177
  %add493.3 = add nuw nsw i32 %mul492.3, %mul177, !dbg !178
  %add498.3 = or disjoint i32 %add493.3, %mul497, !dbg !179
  %add.ptr500.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.3, !dbg !180
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr500.3, align 8, !dbg !181
  %xor491.4 = xor i32 %add488.4.pre-phi, %and183, !dbg !176
  %mul492.4 = shl nuw nsw i32 %xor491.4, 3, !dbg !177
  %add493.4 = add nuw nsw i32 %mul492.4, %mul177, !dbg !178
  %add498.4 = or disjoint i32 %add493.4, %mul497, !dbg !179
  %add.ptr500.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.4, !dbg !180
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr500.4, align 8, !dbg !181
  %xor491.5 = xor i32 %add488.5.pre-phi, %and183, !dbg !176
  %mul492.5 = shl nuw nsw i32 %xor491.5, 3, !dbg !177
  %add493.5 = add nuw nsw i32 %mul492.5, %mul177, !dbg !178
  %add498.5 = or disjoint i32 %add493.5, %mul497, !dbg !179
  %add.ptr500.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.5, !dbg !180
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr500.5, align 8, !dbg !181
  %xor491.6 = xor i32 %add488.6.pre-phi, %and183, !dbg !176
  %mul492.6 = shl nuw nsw i32 %xor491.6, 3, !dbg !177
  %add493.6 = add nuw nsw i32 %mul492.6, %mul177, !dbg !178
  %add498.6 = or disjoint i32 %add493.6, %mul497, !dbg !179
  %add.ptr500.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.6, !dbg !180
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr500.6, align 8, !dbg !181
  %xor491.7 = xor i32 %add488.7.pre-phi, %and183, !dbg !176
  %mul492.7 = shl nuw nsw i32 %xor491.7, 3, !dbg !177
  %add493.7 = add nuw nsw i32 %mul492.7, %mul177, !dbg !178
  %add498.7 = or disjoint i32 %add493.7, %mul497, !dbg !179
  %add.ptr500.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.7, !dbg !180
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr500.7, align 8, !dbg !181
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %add.ptr564 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 %add.ptr564.idx.pre-phi, !dbg !60
  %condval_11.0 = shl nuw nsw i32 %.774, 11, !dbg !187
  %add574 = add i32 %mul568, %condval_11.0, !dbg !188
  %idx.ext575 = sext i32 %add574 to i64, !dbg !189
  %add.ptr576 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep769.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1024, !dbg !60
  %add.ptr564.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.1, i32 %add.ptr564.idx.1.pre-phi, !dbg !60
  %add569.1 = add nsw i32 %mul568, 512, !dbg !193
  %add574.1 = add i32 %add569.1, %condval_11.0, !dbg !188
  %idx.ext575.1 = sext i32 %add574.1 to i64, !dbg !189
  %add.ptr576.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep769.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2048, !dbg !60
  %add.ptr564.2 = getelementptr inbounds i8, ptr addrspace(3) %gep769.2, i32 %add.ptr564.idx.2.pre-phi, !dbg !60
  %add569.2 = add nsw i32 %mul568, 1024, !dbg !193
  %add574.2 = add i32 %add569.2, %condval_11.0, !dbg !188
  %idx.ext575.2 = sext i32 %add574.2 to i64, !dbg !189
  %add.ptr576.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.2, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.2, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep769.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3072, !dbg !60
  %add.ptr564.3 = getelementptr inbounds i8, ptr addrspace(3) %gep769.3, i32 %add.ptr564.idx.3.pre-phi, !dbg !60
  %add569.3 = add nsw i32 %mul568, 1536, !dbg !193
  %add574.3 = add i32 %add569.3, %condval_11.0, !dbg !188
  %idx.ext575.3 = sext i32 %add574.3 to i64, !dbg !189
  %add.ptr576.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.3, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.3, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  fence syncscope("warp") release, !dbg !194
  tail call void @llvm.mxc.barrier.warp(), !dbg !197
  fence syncscope("warp") acquire, !dbg !198
  %cmp16.not.1 = icmp ult i32 %3, 65536, !dbg !199
  br i1 %cmp16.not.1, label %if.end585, label %if.end48.preheader.1, !dbg !200

if.end48.preheader.1:                             ; preds = %if.end473
  %.774.1 = tail call i32 @llvm.smin.i32(i32 %4, i32 1024)
  %cmp109.1 = icmp slt i32 %mul108, %.774.1
  %or.cond701.1 = select i1 %or.cond, i1 %cmp109.1, i1 false, !dbg !57
  br i1 %or.cond701.1, label %if.end139.1, label %for.body453.preheader.1, !dbg !57

for.body453.preheader.1:                          ; preds = %if.end48.preheader.1
  %.pre = add nuw nsw i32 %shr158, 2, !dbg !58
  %.pre1754 = add nuw nsw i32 %shr158, 4, !dbg !58
  %.pre1755 = add nuw nsw i32 %shr158, 6, !dbg !58
  %.pre1756 = add nuw nsw i32 %shr158, 8, !dbg !58
  %.pre1757 = add nuw nsw i32 %shr158, 10, !dbg !58
  %.pre1758 = add nuw nsw i32 %shr158, 12, !dbg !58
  %.pre1759 = add nuw nsw i32 %shr158, 14, !dbg !58
  %.pre1760 = xor i32 %shr180, %and183, !dbg !59
  %.pre1761 = shl nuw nsw i32 %.pre1760, 4, !dbg !60
  %.pre1762 = add nuw nsw i32 %shr180, 4, !dbg !61
  %.pre1763 = xor i32 %.pre1762, %and183, !dbg !59
  %.pre1764 = shl nuw nsw i32 %.pre1763, 4, !dbg !60
  %.pre1765 = add nuw nsw i32 %shr180, 8, !dbg !61
  %.pre1766 = xor i32 %.pre1765, %and183, !dbg !59
  %.pre1767 = shl nuw nsw i32 %.pre1766, 4, !dbg !60
  %.pre1768 = add nuw nsw i32 %shr180, 12, !dbg !61
  %.pre1769 = xor i32 %.pre1768, %and183, !dbg !59
  %.pre1770 = shl nuw nsw i32 %.pre1769, 4, !dbg !60
  br label %if.end473.1, !dbg !62

if.end139.1:                                      ; preds = %if.end48.preheader.1
  %.idx.1816 = shl nuw nsw i64 %shr63, 22, !dbg !68
  %142 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1816, !dbg !68
  %143 = getelementptr i8, ptr addrspace(4) %142, i64 -512, !dbg !68
  %144 = tail call i64 @llvm.umin.i64(i64 %and57, i64 1024)
  %gep.idx.1817 = shl nuw nsw i64 %144, 12, !dbg !68
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %143, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.7.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.44.60.insert.ext1750 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.shift1751 = shl nuw i64 %q_stage.sroa.44.60.insert.ext1750, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.44.56.insert.ext1746 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.insert1753 = or disjoint i64 %q_stage.sroa.44.60.insert.shift1751, %q_stage.sroa.44.56.insert.ext1746, !dbg !70
  %145 = getelementptr i8, ptr addrspace(4) %142, i64 -1024, !dbg !68
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %145, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.6.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.38.52.insert.ext1740 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.shift1741 = shl nuw i64 %q_stage.sroa.38.52.insert.ext1740, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.38.48.insert.ext1736 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.insert1743 = or disjoint i64 %q_stage.sroa.38.52.insert.shift1741, %q_stage.sroa.38.48.insert.ext1736, !dbg !70
  %146 = getelementptr i8, ptr addrspace(4) %142, i64 -1536, !dbg !68
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %146, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.5.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.32.44.insert.ext1730 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.shift1731 = shl nuw i64 %q_stage.sroa.32.44.insert.ext1730, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.32.40.insert.ext1726 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.insert1733 = or disjoint i64 %q_stage.sroa.32.44.insert.shift1731, %q_stage.sroa.32.40.insert.ext1726, !dbg !70
  %147 = getelementptr i8, ptr addrspace(4) %142, i64 -2048, !dbg !68
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %147, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.4.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.26.36.insert.ext1720 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.shift1721 = shl nuw i64 %q_stage.sroa.26.36.insert.ext1720, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.26.32.insert.ext1716 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.insert1723 = or disjoint i64 %q_stage.sroa.26.36.insert.shift1721, %q_stage.sroa.26.32.insert.ext1716, !dbg !70
  %148 = getelementptr i8, ptr addrspace(4) %142, i64 -2560, !dbg !68
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %148, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.3.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.20.28.insert.ext1710 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.shift1711 = shl nuw i64 %q_stage.sroa.20.28.insert.ext1710, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.20.24.insert.ext1706 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.insert1713 = or disjoint i64 %q_stage.sroa.20.28.insert.shift1711, %q_stage.sroa.20.24.insert.ext1706, !dbg !70
  %149 = getelementptr i8, ptr addrspace(4) %142, i64 -3072, !dbg !68
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %149, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.2.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.14.20.insert.ext1700 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.shift1701 = shl nuw i64 %q_stage.sroa.14.20.insert.ext1700, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.14.16.insert.ext1696 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.insert1703 = or disjoint i64 %q_stage.sroa.14.20.insert.shift1701, %q_stage.sroa.14.16.insert.ext1696, !dbg !70
  %150 = getelementptr i8, ptr addrspace(4) %142, i64 -3584, !dbg !68
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %150, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.8.12.insert.ext1690 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.shift1691 = shl nuw i64 %q_stage.sroa.8.12.insert.ext1690, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.8.8.insert.ext1686 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.insert1693 = or disjoint i64 %q_stage.sroa.8.12.insert.shift1691, %q_stage.sroa.8.8.insert.ext1686, !dbg !70
  %151 = getelementptr i8, ptr addrspace(4) %142, i64 -4096, !dbg !68
  %gep.1818 = getelementptr i8, ptr addrspace(4) %151, i64 %gep.idx.1817, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1819 = getelementptr inbounds i8, ptr addrspace(4) %gep.1818, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.1820 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1819, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.0.4.insert.ext1680 = zext i32 %condval_1.sroa.5.0.copyload.1820 to i64, !dbg !70
  %q_stage.sroa.0.4.insert.shift1681 = shl nuw i64 %q_stage.sroa.0.4.insert.ext1680, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.1821 = load i32, ptr addrspace(4) %gep.1818, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.0.0.insert.ext1676 = zext i32 %condval_1.sroa.0.0.copyload.1821 to i64, !dbg !70
  %q_stage.sroa.0.4.insert.insert1683 = or disjoint i64 %q_stage.sroa.0.4.insert.shift1681, %q_stage.sroa.0.0.insert.ext1676, !dbg !70
  %xor.1826 = xor i32 %shr158, %shr155, !dbg !74
  %152 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152, !dbg !75
  %add.ptr167.idx.1827 = shl nuw nsw i32 %xor.1826, 4, !dbg !75
  %add.ptr167.1828 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 %add.ptr167.idx.1827, !dbg !75
  store i64 %q_stage.sroa.0.4.insert.insert1683, ptr addrspace(3) %add.ptr167.1828, align 8, !dbg !76
  %add159.1.1 = add nuw nsw i32 %shr158, 2, !dbg !77
  %xor.1.1 = xor i32 %add159.1.1, %shr155, !dbg !74
  %153 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 512, !dbg !75
  %add.ptr167.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4, !dbg !75
  %add.ptr167.1.1 = getelementptr inbounds i8, ptr addrspace(3) %153, i32 %add.ptr167.idx.1.1, !dbg !75
  store i64 %q_stage.sroa.8.12.insert.insert1693, ptr addrspace(3) %add.ptr167.1.1, align 8, !dbg !76
  %add159.2.1 = add nuw nsw i32 %shr158, 4, !dbg !77
  %xor.2.1 = xor i32 %add159.2.1, %shr155, !dbg !74
  %154 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 1024, !dbg !75
  %add.ptr167.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4, !dbg !75
  %add.ptr167.2.1 = getelementptr inbounds i8, ptr addrspace(3) %154, i32 %add.ptr167.idx.2.1, !dbg !75
  store i64 %q_stage.sroa.14.20.insert.insert1703, ptr addrspace(3) %add.ptr167.2.1, align 8, !dbg !76
  %add159.3.1 = add nuw nsw i32 %shr158, 6, !dbg !77
  %xor.3.1 = xor i32 %add159.3.1, %shr155, !dbg !74
  %155 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 1536, !dbg !75
  %add.ptr167.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4, !dbg !75
  %add.ptr167.3.1 = getelementptr inbounds i8, ptr addrspace(3) %155, i32 %add.ptr167.idx.3.1, !dbg !75
  store i64 %q_stage.sroa.20.28.insert.insert1713, ptr addrspace(3) %add.ptr167.3.1, align 8, !dbg !76
  %add159.4.1 = add nuw nsw i32 %shr158, 8, !dbg !77
  %xor.4.1 = xor i32 %add159.4.1, %shr155, !dbg !74
  %156 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 2048, !dbg !75
  %add.ptr167.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4, !dbg !75
  %add.ptr167.4.1 = getelementptr inbounds i8, ptr addrspace(3) %156, i32 %add.ptr167.idx.4.1, !dbg !75
  store i64 %q_stage.sroa.26.36.insert.insert1723, ptr addrspace(3) %add.ptr167.4.1, align 8, !dbg !76
  %add159.5.1 = add nuw nsw i32 %shr158, 10, !dbg !77
  %xor.5.1 = xor i32 %add159.5.1, %shr155, !dbg !74
  %157 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 2560, !dbg !75
  %add.ptr167.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4, !dbg !75
  %add.ptr167.5.1 = getelementptr inbounds i8, ptr addrspace(3) %157, i32 %add.ptr167.idx.5.1, !dbg !75
  store i64 %q_stage.sroa.32.44.insert.insert1733, ptr addrspace(3) %add.ptr167.5.1, align 8, !dbg !76
  %add159.6.1 = add nuw nsw i32 %shr158, 12, !dbg !77
  %xor.6.1 = xor i32 %add159.6.1, %shr155, !dbg !74
  %158 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 3072, !dbg !75
  %add.ptr167.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4, !dbg !75
  %add.ptr167.6.1 = getelementptr inbounds i8, ptr addrspace(3) %158, i32 %add.ptr167.idx.6.1, !dbg !75
  store i64 %q_stage.sroa.38.52.insert.insert1743, ptr addrspace(3) %add.ptr167.6.1, align 8, !dbg !76
  %add159.7.1 = add nuw nsw i32 %shr158, 14, !dbg !77
  %xor.7.1 = xor i32 %add159.7.1, %shr155, !dbg !74
  %159 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 3584, !dbg !75
  %add.ptr167.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4, !dbg !75
  %add.ptr167.7.1 = getelementptr inbounds i8, ptr addrspace(3) %159, i32 %add.ptr167.idx.7.1, !dbg !75
  store i64 %q_stage.sroa.44.60.insert.insert1753, ptr addrspace(3) %add.ptr167.7.1, align 8, !dbg !76
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %xor184.1829 = xor i32 %shr180, %and183, !dbg !83
  %add.ptr188.idx.1830 = shl nuw nsw i32 %xor184.1829, 4, !dbg !84
  %add.ptr188.1831 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1830, !dbg !84
  %q.sroa.0.0.copyload1626 = load <4 x half>, ptr addrspace(3) %add.ptr188.1831, align 16, !dbg !85
  %q.sroa.6.0.add.ptr188.1831.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1831, i32 8, !dbg !85
  %q.sroa.6.0.copyload1627 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.1831.sroa_idx, align 8, !dbg !85
  %add181.1.1 = add nuw nsw i32 %shr180, 4, !dbg !86
  %xor184.1.1 = xor i32 %add181.1.1, %and183, !dbg !83
  %add.ptr188.idx.1.1 = shl nuw nsw i32 %xor184.1.1, 4, !dbg !84
  %add.ptr188.1.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1.1, !dbg !84
  %q.sroa.8.16.copyload1630 = load <4 x half>, ptr addrspace(3) %add.ptr188.1.1, align 16, !dbg !85
  %q.sroa.12.16.add.ptr188.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1.1, i32 8, !dbg !85
  %q.sroa.12.16.copyload1631 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.1.sroa_idx, align 8, !dbg !85
  %add181.2.1 = add nuw nsw i32 %shr180, 8, !dbg !86
  %xor184.2.1 = xor i32 %add181.2.1, %and183, !dbg !83
  %add.ptr188.idx.2.1 = shl nuw nsw i32 %xor184.2.1, 4, !dbg !84
  %add.ptr188.2.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2.1, !dbg !84
  %q.sroa.14.32.copyload1634 = load <4 x half>, ptr addrspace(3) %add.ptr188.2.1, align 16, !dbg !85
  %q.sroa.18.32.add.ptr188.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2.1, i32 8, !dbg !85
  %q.sroa.18.32.copyload1635 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.1.sroa_idx, align 8, !dbg !85
  %add181.3.1 = add nuw nsw i32 %shr180, 12, !dbg !86
  %xor184.3.1 = xor i32 %add181.3.1, %and183, !dbg !83
  %add.ptr188.idx.3.1 = shl nuw nsw i32 %xor184.3.1, 4, !dbg !84
  %add.ptr188.3.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3.1, !dbg !84
  %q.sroa.20.48.copyload1638 = load <4 x half>, ptr addrspace(3) %add.ptr188.3.1, align 16, !dbg !85
  %q.sroa.24.48.add.ptr188.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3.1, i32 8, !dbg !85
  %q.sroa.24.48.copyload1639 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.1.sroa_idx, align 8, !dbg !85
  %cmp229.not.not.1834 = icmp slt i32 %add222, %.774.1, !dbg !87
  %spec.select.1835 = select i1 %cmp229.not.not.1834, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.0.vec.insert1421 = insertelement <4 x float> poison, float %spec.select.1835, i64 0, !dbg !89
  %add226.1.1 = or disjoint i32 %add222, 1, !dbg !90
  %cmp229.not.not.1.1 = icmp slt i32 %add226.1.1, %.774.1, !dbg !87
  %spec.select.1.1 = select i1 %cmp229.not.not.1.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.4.vec.insert1446 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1421, float %spec.select.1.1, i64 1, !dbg !89
  %add226.2.1 = or disjoint i32 %add222, 2, !dbg !90
  %cmp229.not.not.2.1 = icmp slt i32 %add226.2.1, %.774.1, !dbg !87
  %spec.select.2.1 = select i1 %cmp229.not.not.2.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.8.vec.insert1471 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1446, float %spec.select.2.1, i64 2, !dbg !89
  %add226.3.1 = or disjoint i32 %add222, 3, !dbg !90
  %cmp229.not.not.3.1 = icmp slt i32 %add226.3.1, %.774.1, !dbg !87
  %spec.select.3.1 = select i1 %cmp229.not.not.3.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.12.vec.insert1496 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1471, float %spec.select.3.1, i64 3, !dbg !89
  %add228.4.1 = add nuw nsw i32 %add222, 16, !dbg !91
  %cmp229.not.not.4.1 = icmp slt i32 %add228.4.1, %.774.1, !dbg !87
  %spec.select.4.1 = select i1 %cmp229.not.not.4.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.16.vec.insert1537 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0, !dbg !89
  %add228.5.1 = add nuw nsw i32 %add222, 17, !dbg !91
  %cmp229.not.not.5.1 = icmp slt i32 %add228.5.1, %.774.1, !dbg !87
  %spec.select.5.1 = select i1 %cmp229.not.not.5.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.20.vec.insert1562 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1537, float %spec.select.5.1, i64 1, !dbg !89
  %add228.6.1 = add nuw nsw i32 %add222, 18, !dbg !91
  %cmp229.not.not.6.1 = icmp slt i32 %add228.6.1, %.774.1, !dbg !87
  %spec.select.6.1 = select i1 %cmp229.not.not.6.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.24.vec.insert1587 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1562, float %spec.select.6.1, i64 2, !dbg !89
  %add228.7.1 = add nuw nsw i32 %add222, 19, !dbg !91
  %cmp229.not.not.7.1 = icmp slt i32 %add228.7.1, %.774.1, !dbg !87
  %spec.select.7.1 = select i1 %cmp229.not.not.7.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.28.vec.insert1612 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1587, float %spec.select.7.1, i64 3, !dbg !89
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.1, <4 x half> %q.sroa.0.0.copyload1626, <4 x float> %scores.sroa.0.12.vec.insert1496), !dbg !92
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.1, <4 x half> %q.sroa.0.0.copyload1626, <4 x float> %scores.sroa.90.28.vec.insert1612), !dbg !92
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.1, <4 x half> %q.sroa.6.0.copyload1627, <4 x float> %160), !dbg !92
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.1, <4 x half> %q.sroa.6.0.copyload1627, <4 x float> %161), !dbg !92
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.1, <4 x half> %q.sroa.8.16.copyload1630, <4 x float> %162), !dbg !92
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.1, <4 x half> %q.sroa.8.16.copyload1630, <4 x float> %163), !dbg !92
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.1, <4 x half> %q.sroa.12.16.copyload1631, <4 x float> %164), !dbg !92
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.1, <4 x half> %q.sroa.12.16.copyload1631, <4 x float> %165), !dbg !92
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.1, <4 x half> %q.sroa.14.32.copyload1634, <4 x float> %166), !dbg !92
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.1, <4 x half> %q.sroa.14.32.copyload1634, <4 x float> %167), !dbg !92
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.1, <4 x half> %q.sroa.18.32.copyload1635, <4 x float> %168), !dbg !92
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.1, <4 x half> %q.sroa.18.32.copyload1635, <4 x float> %169), !dbg !92
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.1, <4 x half> %q.sroa.20.48.copyload1638, <4 x float> %170), !dbg !92
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.1, <4 x half> %q.sroa.20.48.copyload1638, <4 x float> %171), !dbg !92
  %174 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.1, <4 x half> %q.sroa.24.48.copyload1639, <4 x float> %172), !dbg !92
  %175 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.1, <4 x half> %q.sroa.24.48.copyload1639, <4 x float> %173), !dbg !92
  %scores.sroa.0.0.vec.extract1423 = extractelement <4 x float> %174, i64 0, !dbg !96
  %mul314.1845 = fmul contract float %scores.sroa.0.0.vec.extract1423, 0x3FC2776C60000000, !dbg !97
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1845, float 1.500000e+01), !dbg !98
  %cmp.i.i.1846 = fcmp contract olt float %176, -1.260000e+02, !dbg !102
  %cond.i.i724.1847 = select contract i1 %cmp.i.i.1846, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.1848 = fadd contract float %176, %cond.i.i724.1847, !dbg !102
  %177 = tail call contract float @llvm.exp2.f32(float %add.i.i725.1848), !dbg !102
  %cond2.i.i.1849 = select contract i1 %cmp.i.i.1846, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.1850 = fmul contract float %cond2.i.i.1849, %177, !dbg !102
  %scores.sroa.0.4.vec.extract1448 = extractelement <4 x float> %174, i64 1, !dbg !96
  %mul314.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1448, 0x3FC2776C60000000, !dbg !97
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul314.1.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.1.1 = fcmp contract olt float %178, -1.260000e+02, !dbg !102
  %cond.i.i724.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.1.1 = fadd contract float %178, %cond.i.i724.1.1, !dbg !102
  %179 = tail call contract float @llvm.exp2.f32(float %add.i.i725.1.1), !dbg !102
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %179, !dbg !102
  %scores.sroa.0.8.vec.extract1473 = extractelement <4 x float> %174, i64 2, !dbg !96
  %mul314.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1473, 0x3FC2776C60000000, !dbg !97
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul314.2.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.2.1 = fcmp contract olt float %180, -1.260000e+02, !dbg !102
  %cond.i.i724.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.2.1 = fadd contract float %180, %cond.i.i724.2.1, !dbg !102
  %181 = tail call contract float @llvm.exp2.f32(float %add.i.i725.2.1), !dbg !102
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %181, !dbg !102
  %scores.sroa.0.12.vec.extract1498 = extractelement <4 x float> %174, i64 3, !dbg !96
  %mul314.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1498, 0x3FC2776C60000000, !dbg !97
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul314.3.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.3.1 = fcmp contract olt float %182, -1.260000e+02, !dbg !102
  %cond.i.i724.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.3.1 = fadd contract float %182, %cond.i.i724.3.1, !dbg !102
  %183 = tail call contract float @llvm.exp2.f32(float %add.i.i725.3.1), !dbg !102
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %183, !dbg !102
  %scores.sroa.90.16.vec.extract1539 = extractelement <4 x float> %175, i64 0, !dbg !96
  %mul314.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1539, 0x3FC2776C60000000, !dbg !97
  %184 = tail call contract noundef float @llvm.minnum.f32(float %mul314.4.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.4.1 = fcmp contract olt float %184, -1.260000e+02, !dbg !102
  %cond.i.i724.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.4.1 = fadd contract float %184, %cond.i.i724.4.1, !dbg !102
  %185 = tail call contract float @llvm.exp2.f32(float %add.i.i725.4.1), !dbg !102
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %185, !dbg !102
  %scores.sroa.90.20.vec.extract1564 = extractelement <4 x float> %175, i64 1, !dbg !96
  %mul314.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1564, 0x3FC2776C60000000, !dbg !97
  %186 = tail call contract noundef float @llvm.minnum.f32(float %mul314.5.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.5.1 = fcmp contract olt float %186, -1.260000e+02, !dbg !102
  %cond.i.i724.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.5.1 = fadd contract float %186, %cond.i.i724.5.1, !dbg !102
  %187 = tail call contract float @llvm.exp2.f32(float %add.i.i725.5.1), !dbg !102
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %187, !dbg !102
  %scores.sroa.90.24.vec.extract1589 = extractelement <4 x float> %175, i64 2, !dbg !96
  %mul314.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1589, 0x3FC2776C60000000, !dbg !97
  %188 = tail call contract noundef float @llvm.minnum.f32(float %mul314.6.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.6.1 = fcmp contract olt float %188, -1.260000e+02, !dbg !102
  %cond.i.i724.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.6.1 = fadd contract float %188, %cond.i.i724.6.1, !dbg !102
  %189 = tail call contract float @llvm.exp2.f32(float %add.i.i725.6.1), !dbg !102
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %189, !dbg !102
  %scores.sroa.90.28.vec.extract1614 = extractelement <4 x float> %175, i64 3, !dbg !96
  %mul314.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1614, 0x3FC2776C60000000, !dbg !97
  %190 = tail call contract noundef float @llvm.minnum.f32(float %mul314.7.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.7.1 = fcmp contract olt float %190, -1.260000e+02, !dbg !102
  %cond.i.i724.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i725.7.1 = fadd contract float %190, %cond.i.i724.7.1, !dbg !102
  %191 = tail call contract float @llvm.exp2.f32(float %add.i.i725.7.1), !dbg !102
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %191, !dbg !102
  %add334.1851 = fadd contract float %mul.i.i.1850, 0.000000e+00, !dbg !105
  %add334.1.1 = fadd contract float %add334.1851, %mul.i.i.4.1, !dbg !105
  %add334.2.1 = fadd contract float %add334.1.1, %mul.i.i.1.1, !dbg !105
  %add334.3.1 = fadd contract float %add334.2.1, %mul.i.i.5.1, !dbg !105
  %add334.4.1 = fadd contract float %add334.3.1, %mul.i.i.2.1, !dbg !105
  %add334.5.1 = fadd contract float %add334.4.1, %mul.i.i.6.1, !dbg !105
  %add334.6.1 = fadd contract float %add334.5.1, %mul.i.i.3.1, !dbg !105
  %add334.7.1 = fadd contract float %add334.6.1, %mul.i.i.7.1, !dbg !105
  %192 = bitcast float %add334.7.1 to i32, !dbg !106
  %193 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !117
  %194 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %193) #11, !dbg !122
  %xor.i.i.1 = xor i32 %194, 32, !dbg !123
  %195 = and i32 %194, -64, !dbg !124
  %and.i.i.1 = add nsw i32 %195, 64, !dbg !124
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1, !dbg !125
  %cond.i.i726.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %194, !dbg !126
  %shl.i.i.1 = shl i32 %cond.i.i726.1, 2, !dbg !127
  %196 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %192), !dbg !128
  %197 = bitcast i32 %196 to float, !dbg !129
  %add.i.1 = fadd contract float %add334.7.1, %197, !dbg !130
  %198 = bitcast float %add.i.1 to i32, !dbg !133
  %199 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !140
  %200 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %199) #11, !dbg !143
  %xor.i.i727.1 = xor i32 %200, 16, !dbg !144
  %201 = and i32 %200, -64, !dbg !145
  %and.i.i728.1 = add nsw i32 %201, 64, !dbg !145
  %cmp.not.i.i729.1 = icmp slt i32 %xor.i.i727.1, %and.i.i728.1, !dbg !146
  %cond.i.i730.1 = select i1 %cmp.not.i.i729.1, i32 %xor.i.i727.1, i32 %200, !dbg !147
  %shl.i.i731.1 = shl i32 %cond.i.i730.1, 2, !dbg !148
  %202 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i731.1, i32 %198), !dbg !149
  %203 = bitcast i32 %202 to float, !dbg !150
  %add.i.i.1 = fadd contract float %add.i.1, %203, !dbg !151
  %cmp343.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00, !dbg !153
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1, !dbg !154
  %condval_8.0.1 = select i1 %cmp343.1, float %div.1, float 0.000000e+00, !dbg !154
  %mul356.1852 = fmul contract float %condval_8.0.1, %mul.i.i.1850, !dbg !155
  %mul356.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1, !dbg !155
  %mul356.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1, !dbg !155
  %mul356.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1, !dbg !155
  %mul356.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1, !dbg !155
  %mul356.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1, !dbg !155
  %mul356.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1, !dbg !155
  %mul356.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1, !dbg !155
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.1852), !dbg !156
  %205 = insertelement <4 x i16> poison, i16 %204, i64 0, !dbg !165
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.1.1), !dbg !156
  %207 = insertelement <4 x i16> %205, i16 %206, i64 1, !dbg !165
  %208 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.2.1), !dbg !156
  %209 = insertelement <4 x i16> %207, i16 %208, i64 2, !dbg !165
  %210 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.3.1), !dbg !156
  %211 = insertelement <4 x i16> %209, i16 %210, i64 3, !dbg !165
  %prob.sroa.0.6.vec.insert1349 = bitcast <4 x i16> %211 to <4 x half>, !dbg !165
  %212 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.4.1), !dbg !156
  %213 = insertelement <4 x i16> poison, i16 %212, i64 0, !dbg !165
  %214 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.5.1), !dbg !156
  %215 = insertelement <4 x i16> %213, i16 %214, i64 1, !dbg !165
  %216 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.6.1), !dbg !156
  %217 = insertelement <4 x i16> %215, i16 %216, i64 2, !dbg !165
  %218 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul356.7.1), !dbg !156
  %219 = insertelement <4 x i16> %217, i16 %218, i64 3, !dbg !165
  %prob.sroa.12.14.vec.insert1359 = bitcast <4 x i16> %219 to <4 x half>, !dbg !165
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.1, <4 x half> %prob.sroa.0.6.vec.insert1349, <4 x float> zeroinitializer), !dbg !166
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %220), !dbg !166
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %221), !dbg !166
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %222), !dbg !166
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %223), !dbg !166
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %224), !dbg !166
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %225), !dbg !166
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %226), !dbg !166
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.1, <4 x half> %prob.sroa.12.14.vec.insert1359, <4 x float> %227), !dbg !166
  %out.sroa.0.0.vec.extract900 = extractelement <4 x float> %228, i64 0, !dbg !167
  %236 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract900), !dbg !168
  %output_reg.sroa.0.0.insert.ext1092 = zext i16 %236 to i64, !dbg !172
  %out.sroa.0.4.vec.extract905 = extractelement <4 x float> %228, i64 1, !dbg !167
  %237 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract905), !dbg !168
  %output_reg.sroa.0.2.insert.ext1096 = zext i16 %237 to i64, !dbg !172
  %output_reg.sroa.0.2.insert.shift1097 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1096, 16, !dbg !172
  %output_reg.sroa.0.2.insert.insert1099 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1097, %output_reg.sroa.0.0.insert.ext1092, !dbg !172
  %out.sroa.0.8.vec.extract910 = extractelement <4 x float> %228, i64 2, !dbg !167
  %238 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract910), !dbg !168
  %output_reg.sroa.0.4.insert.ext1107 = zext i16 %238 to i64, !dbg !172
  %output_reg.sroa.0.4.insert.shift1108 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1107, 32, !dbg !172
  %output_reg.sroa.0.4.insert.insert1110 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1099, %output_reg.sroa.0.4.insert.shift1108, !dbg !172
  %out.sroa.0.12.vec.extract915 = extractelement <4 x float> %228, i64 3, !dbg !167
  %239 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract915), !dbg !168
  %output_reg.sroa.0.6.insert.ext1112 = zext i16 %239 to i64, !dbg !172
  %output_reg.sroa.0.6.insert.shift1113 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1112, 48, !dbg !172
  %output_reg.sroa.0.6.insert.insert1115 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1110, %output_reg.sroa.0.6.insert.shift1113, !dbg !172
  %out.sroa.26.16.vec.extract924 = extractelement <4 x float> %229, i64 0, !dbg !167
  %240 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract924), !dbg !168
  %output_reg.sroa.16.8.insert.ext1124 = zext i16 %240 to i64, !dbg !172
  %out.sroa.26.20.vec.extract929 = extractelement <4 x float> %229, i64 1, !dbg !167
  %241 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract929), !dbg !168
  %output_reg.sroa.16.10.insert.ext1128 = zext i16 %241 to i64, !dbg !172
  %output_reg.sroa.16.10.insert.shift1129 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1128, 16, !dbg !172
  %output_reg.sroa.16.10.insert.insert1131 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1129, %output_reg.sroa.16.8.insert.ext1124, !dbg !172
  %out.sroa.26.24.vec.extract934 = extractelement <4 x float> %229, i64 2, !dbg !167
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract934), !dbg !168
  %output_reg.sroa.16.12.insert.ext1139 = zext i16 %242 to i64, !dbg !172
  %output_reg.sroa.16.12.insert.shift1140 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1139, 32, !dbg !172
  %output_reg.sroa.16.12.insert.insert1142 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1131, %output_reg.sroa.16.12.insert.shift1140, !dbg !172
  %out.sroa.26.28.vec.extract939 = extractelement <4 x float> %229, i64 3, !dbg !167
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract939), !dbg !168
  %output_reg.sroa.16.14.insert.ext1144 = zext i16 %243 to i64, !dbg !172
  %output_reg.sroa.16.14.insert.shift1145 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1144, 48, !dbg !172
  %output_reg.sroa.16.14.insert.insert1147 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1142, %output_reg.sroa.16.14.insert.shift1145, !dbg !172
  %out.sroa.50.32.vec.extract948 = extractelement <4 x float> %230, i64 0, !dbg !167
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract948), !dbg !168
  %output_reg.sroa.30.16.insert.ext1156 = zext i16 %244 to i64, !dbg !172
  %out.sroa.50.36.vec.extract953 = extractelement <4 x float> %230, i64 1, !dbg !167
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract953), !dbg !168
  %output_reg.sroa.30.18.insert.ext1160 = zext i16 %245 to i64, !dbg !172
  %output_reg.sroa.30.18.insert.shift1161 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1160, 16, !dbg !172
  %output_reg.sroa.30.18.insert.insert1163 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1161, %output_reg.sroa.30.16.insert.ext1156, !dbg !172
  %out.sroa.50.40.vec.extract958 = extractelement <4 x float> %230, i64 2, !dbg !167
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract958), !dbg !168
  %output_reg.sroa.30.20.insert.ext1171 = zext i16 %246 to i64, !dbg !172
  %output_reg.sroa.30.20.insert.shift1172 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1171, 32, !dbg !172
  %output_reg.sroa.30.20.insert.insert1174 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1163, %output_reg.sroa.30.20.insert.shift1172, !dbg !172
  %out.sroa.50.44.vec.extract963 = extractelement <4 x float> %230, i64 3, !dbg !167
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract963), !dbg !168
  %output_reg.sroa.30.22.insert.ext1176 = zext i16 %247 to i64, !dbg !172
  %output_reg.sroa.30.22.insert.shift1177 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1176, 48, !dbg !172
  %output_reg.sroa.30.22.insert.insert1179 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1174, %output_reg.sroa.30.22.insert.shift1177, !dbg !172
  %out.sroa.74.48.vec.extract972 = extractelement <4 x float> %231, i64 0, !dbg !167
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract972), !dbg !168
  %output_reg.sroa.44.24.insert.ext1188 = zext i16 %248 to i64, !dbg !172
  %out.sroa.74.52.vec.extract977 = extractelement <4 x float> %231, i64 1, !dbg !167
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract977), !dbg !168
  %output_reg.sroa.44.26.insert.ext1192 = zext i16 %249 to i64, !dbg !172
  %output_reg.sroa.44.26.insert.shift1193 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1192, 16, !dbg !172
  %output_reg.sroa.44.26.insert.insert1195 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1193, %output_reg.sroa.44.24.insert.ext1188, !dbg !172
  %out.sroa.74.56.vec.extract982 = extractelement <4 x float> %231, i64 2, !dbg !167
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract982), !dbg !168
  %output_reg.sroa.44.28.insert.ext1203 = zext i16 %250 to i64, !dbg !172
  %output_reg.sroa.44.28.insert.shift1204 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1203, 32, !dbg !172
  %output_reg.sroa.44.28.insert.insert1206 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1195, %output_reg.sroa.44.28.insert.shift1204, !dbg !172
  %out.sroa.74.60.vec.extract987 = extractelement <4 x float> %231, i64 3, !dbg !167
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract987), !dbg !168
  %output_reg.sroa.44.30.insert.ext1208 = zext i16 %251 to i64, !dbg !172
  %output_reg.sroa.44.30.insert.shift1209 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1208, 48, !dbg !172
  %output_reg.sroa.44.30.insert.insert1211 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1206, %output_reg.sroa.44.30.insert.shift1209, !dbg !172
  %out.sroa.98.64.vec.extract996 = extractelement <4 x float> %232, i64 0, !dbg !167
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract996), !dbg !168
  %output_reg.sroa.58.32.insert.ext1220 = zext i16 %252 to i64, !dbg !172
  %out.sroa.98.68.vec.extract1001 = extractelement <4 x float> %232, i64 1, !dbg !167
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract1001), !dbg !168
  %output_reg.sroa.58.34.insert.ext1224 = zext i16 %253 to i64, !dbg !172
  %output_reg.sroa.58.34.insert.shift1225 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1224, 16, !dbg !172
  %output_reg.sroa.58.34.insert.insert1227 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1225, %output_reg.sroa.58.32.insert.ext1220, !dbg !172
  %out.sroa.98.72.vec.extract1006 = extractelement <4 x float> %232, i64 2, !dbg !167
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract1006), !dbg !168
  %output_reg.sroa.58.36.insert.ext1235 = zext i16 %254 to i64, !dbg !172
  %output_reg.sroa.58.36.insert.shift1236 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1235, 32, !dbg !172
  %output_reg.sroa.58.36.insert.insert1238 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1227, %output_reg.sroa.58.36.insert.shift1236, !dbg !172
  %out.sroa.98.76.vec.extract1011 = extractelement <4 x float> %232, i64 3, !dbg !167
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract1011), !dbg !168
  %output_reg.sroa.58.38.insert.ext1240 = zext i16 %255 to i64, !dbg !172
  %output_reg.sroa.58.38.insert.shift1241 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1240, 48, !dbg !172
  %output_reg.sroa.58.38.insert.insert1243 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1238, %output_reg.sroa.58.38.insert.shift1241, !dbg !172
  %out.sroa.122.80.vec.extract1020 = extractelement <4 x float> %233, i64 0, !dbg !167
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract1020), !dbg !168
  %output_reg.sroa.72.40.insert.ext1252 = zext i16 %256 to i64, !dbg !172
  %out.sroa.122.84.vec.extract1025 = extractelement <4 x float> %233, i64 1, !dbg !167
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract1025), !dbg !168
  %output_reg.sroa.72.42.insert.ext1256 = zext i16 %257 to i64, !dbg !172
  %output_reg.sroa.72.42.insert.shift1257 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1256, 16, !dbg !172
  %output_reg.sroa.72.42.insert.insert1259 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1257, %output_reg.sroa.72.40.insert.ext1252, !dbg !172
  %out.sroa.122.88.vec.extract1030 = extractelement <4 x float> %233, i64 2, !dbg !167
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract1030), !dbg !168
  %output_reg.sroa.72.44.insert.ext1267 = zext i16 %258 to i64, !dbg !172
  %output_reg.sroa.72.44.insert.shift1268 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1267, 32, !dbg !172
  %output_reg.sroa.72.44.insert.insert1270 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1259, %output_reg.sroa.72.44.insert.shift1268, !dbg !172
  %out.sroa.122.92.vec.extract1035 = extractelement <4 x float> %233, i64 3, !dbg !167
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract1035), !dbg !168
  %output_reg.sroa.72.46.insert.ext1272 = zext i16 %259 to i64, !dbg !172
  %output_reg.sroa.72.46.insert.shift1273 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1272, 48, !dbg !172
  %output_reg.sroa.72.46.insert.insert1275 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1270, %output_reg.sroa.72.46.insert.shift1273, !dbg !172
  %out.sroa.146.96.vec.extract1044 = extractelement <4 x float> %234, i64 0, !dbg !167
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract1044), !dbg !168
  %output_reg.sroa.86.48.insert.ext1284 = zext i16 %260 to i64, !dbg !172
  %out.sroa.146.100.vec.extract1049 = extractelement <4 x float> %234, i64 1, !dbg !167
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract1049), !dbg !168
  %output_reg.sroa.86.50.insert.ext1288 = zext i16 %261 to i64, !dbg !172
  %output_reg.sroa.86.50.insert.shift1289 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1288, 16, !dbg !172
  %output_reg.sroa.86.50.insert.insert1291 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1289, %output_reg.sroa.86.48.insert.ext1284, !dbg !172
  %out.sroa.146.104.vec.extract1054 = extractelement <4 x float> %234, i64 2, !dbg !167
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract1054), !dbg !168
  %output_reg.sroa.86.52.insert.ext1299 = zext i16 %262 to i64, !dbg !172
  %output_reg.sroa.86.52.insert.shift1300 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1299, 32, !dbg !172
  %output_reg.sroa.86.52.insert.insert1302 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1291, %output_reg.sroa.86.52.insert.shift1300, !dbg !172
  %out.sroa.146.108.vec.extract1059 = extractelement <4 x float> %234, i64 3, !dbg !167
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract1059), !dbg !168
  %output_reg.sroa.86.54.insert.ext1304 = zext i16 %263 to i64, !dbg !172
  %output_reg.sroa.86.54.insert.shift1305 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1304, 48, !dbg !172
  %output_reg.sroa.86.54.insert.insert1307 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1302, %output_reg.sroa.86.54.insert.shift1305, !dbg !172
  %out.sroa.170.112.vec.extract1068 = extractelement <4 x float> %235, i64 0, !dbg !167
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1068), !dbg !168
  %output_reg.sroa.100.56.insert.ext1316 = zext i16 %264 to i64, !dbg !172
  %out.sroa.170.116.vec.extract1073 = extractelement <4 x float> %235, i64 1, !dbg !167
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1073), !dbg !168
  %output_reg.sroa.100.58.insert.ext1320 = zext i16 %265 to i64, !dbg !172
  %output_reg.sroa.100.58.insert.shift1321 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1320, 16, !dbg !172
  %output_reg.sroa.100.58.insert.insert1323 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1321, %output_reg.sroa.100.56.insert.ext1316, !dbg !172
  %out.sroa.170.120.vec.extract1078 = extractelement <4 x float> %235, i64 2, !dbg !167
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1078), !dbg !168
  %output_reg.sroa.100.60.insert.ext1331 = zext i16 %266 to i64, !dbg !172
  %output_reg.sroa.100.60.insert.shift1332 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1331, 32, !dbg !172
  %output_reg.sroa.100.60.insert.insert1334 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1323, %output_reg.sroa.100.60.insert.shift1332, !dbg !172
  %out.sroa.170.124.vec.extract1083 = extractelement <4 x float> %235, i64 3, !dbg !167
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1083), !dbg !168
  %output_reg.sroa.100.62.insert.ext1336 = zext i16 %267 to i64, !dbg !172
  %output_reg.sroa.100.62.insert.shift1337 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1336, 48, !dbg !172
  %output_reg.sroa.100.62.insert.insert1339 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1334, %output_reg.sroa.100.62.insert.shift1337, !dbg !172
  br label %if.end473.1, !dbg !62

if.end473.1:                                      ; preds = %if.end139.1, %for.body453.preheader.1
  %add.ptr564.idx.3.1.pre-phi = phi i32 [ %add.ptr188.idx.3.1, %if.end139.1 ], [ %.pre1770, %for.body453.preheader.1 ], !dbg !60
  %add.ptr564.idx.2.1.pre-phi = phi i32 [ %add.ptr188.idx.2.1, %if.end139.1 ], [ %.pre1767, %for.body453.preheader.1 ], !dbg !60
  %add.ptr564.idx.1.1.pre-phi = phi i32 [ %add.ptr188.idx.1.1, %if.end139.1 ], [ %.pre1764, %for.body453.preheader.1 ], !dbg !60
  %add.ptr564.idx.1886.pre-phi = phi i32 [ %add.ptr188.idx.1830, %if.end139.1 ], [ %.pre1761, %for.body453.preheader.1 ], !dbg !60
  %add488.7.1.pre-phi = phi i32 [ %add159.7.1, %if.end139.1 ], [ %.pre1759, %for.body453.preheader.1 ], !dbg !58
  %add488.6.1.pre-phi = phi i32 [ %add159.6.1, %if.end139.1 ], [ %.pre1758, %for.body453.preheader.1 ], !dbg !58
  %add488.5.1.pre-phi = phi i32 [ %add159.5.1, %if.end139.1 ], [ %.pre1757, %for.body453.preheader.1 ], !dbg !58
  %add488.4.1.pre-phi = phi i32 [ %add159.4.1, %if.end139.1 ], [ %.pre1756, %for.body453.preheader.1 ], !dbg !58
  %add488.3.1.pre-phi = phi i32 [ %add159.3.1, %if.end139.1 ], [ %.pre1755, %for.body453.preheader.1 ], !dbg !58
  %add488.2.1.pre-phi = phi i32 [ %add159.2.1, %if.end139.1 ], [ %.pre1754, %for.body453.preheader.1 ], !dbg !58
  %add488.1.1.pre-phi = phi i32 [ %add159.1.1, %if.end139.1 ], [ %.pre, %for.body453.preheader.1 ], !dbg !58
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1339, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1307, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1275, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1243, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1211, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1179, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1147, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1115, %if.end139.1 ], [ 0, %for.body453.preheader.1 ], !dbg !173
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !174
  fence syncscope("warp") acquire, !dbg !175
  %xor491.1878 = xor i32 %shr158, %and183, !dbg !176
  %mul492.1879 = shl nuw nsw i32 %xor491.1878, 3, !dbg !177
  %add493.1880 = add nuw nsw i32 %mul492.1879, %mul177, !dbg !178
  %add498.1881 = or disjoint i32 %add493.1880, %mul497, !dbg !179
  %add.ptr500.1882 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.1881, !dbg !180
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr500.1882, align 8, !dbg !181
  %xor491.1.1 = xor i32 %add488.1.1.pre-phi, %and183, !dbg !176
  %mul492.1.1 = shl nuw nsw i32 %xor491.1.1, 3, !dbg !177
  %add493.1.1 = add nuw nsw i32 %mul492.1.1, %mul177, !dbg !178
  %add498.1.1 = or disjoint i32 %add493.1.1, %mul497, !dbg !179
  %add.ptr500.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.1.1, !dbg !180
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr500.1.1, align 8, !dbg !181
  %xor491.2.1 = xor i32 %add488.2.1.pre-phi, %and183, !dbg !176
  %mul492.2.1 = shl nuw nsw i32 %xor491.2.1, 3, !dbg !177
  %add493.2.1 = add nuw nsw i32 %mul492.2.1, %mul177, !dbg !178
  %add498.2.1 = or disjoint i32 %add493.2.1, %mul497, !dbg !179
  %add.ptr500.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.2.1, !dbg !180
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr500.2.1, align 8, !dbg !181
  %xor491.3.1 = xor i32 %add488.3.1.pre-phi, %and183, !dbg !176
  %mul492.3.1 = shl nuw nsw i32 %xor491.3.1, 3, !dbg !177
  %add493.3.1 = add nuw nsw i32 %mul492.3.1, %mul177, !dbg !178
  %add498.3.1 = or disjoint i32 %add493.3.1, %mul497, !dbg !179
  %add.ptr500.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.3.1, !dbg !180
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr500.3.1, align 8, !dbg !181
  %xor491.4.1 = xor i32 %add488.4.1.pre-phi, %and183, !dbg !176
  %mul492.4.1 = shl nuw nsw i32 %xor491.4.1, 3, !dbg !177
  %add493.4.1 = add nuw nsw i32 %mul492.4.1, %mul177, !dbg !178
  %add498.4.1 = or disjoint i32 %add493.4.1, %mul497, !dbg !179
  %add.ptr500.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.4.1, !dbg !180
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr500.4.1, align 8, !dbg !181
  %xor491.5.1 = xor i32 %add488.5.1.pre-phi, %and183, !dbg !176
  %mul492.5.1 = shl nuw nsw i32 %xor491.5.1, 3, !dbg !177
  %add493.5.1 = add nuw nsw i32 %mul492.5.1, %mul177, !dbg !178
  %add498.5.1 = or disjoint i32 %add493.5.1, %mul497, !dbg !179
  %add.ptr500.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.5.1, !dbg !180
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr500.5.1, align 8, !dbg !181
  %xor491.6.1 = xor i32 %add488.6.1.pre-phi, %and183, !dbg !176
  %mul492.6.1 = shl nuw nsw i32 %xor491.6.1, 3, !dbg !177
  %add493.6.1 = add nuw nsw i32 %mul492.6.1, %mul177, !dbg !178
  %add498.6.1 = or disjoint i32 %add493.6.1, %mul497, !dbg !179
  %add.ptr500.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.6.1, !dbg !180
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr500.6.1, align 8, !dbg !181
  %xor491.7.1 = xor i32 %add488.7.1.pre-phi, %and183, !dbg !176
  %mul492.7.1 = shl nuw nsw i32 %xor491.7.1, 3, !dbg !177
  %add493.7.1 = add nuw nsw i32 %mul492.7.1, %mul177, !dbg !178
  %add498.7.1 = or disjoint i32 %add493.7.1, %mul497, !dbg !179
  %add.ptr500.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add498.7.1, !dbg !180
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr500.7.1, align 8, !dbg !181
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %add.ptr564.1887 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 %add.ptr564.idx.1886.pre-phi, !dbg !60
  %condval_11.0.1888 = shl nuw nsw i32 %.774.1, 11, !dbg !187
  %add574.1889 = add i32 %mul568, %condval_11.0.1888, !dbg !188
  %idx.ext575.1890 = sext i32 %add574.1889 to i64, !dbg !189
  %add.ptr576.1891 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.1890, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.1891, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1887, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep769.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 1024, !dbg !60
  %add.ptr564.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.1.1, i32 %add.ptr564.idx.1.1.pre-phi, !dbg !60
  %add569.1.1 = add nsw i32 %mul568, 512, !dbg !193
  %add574.1.1 = add i32 %add569.1.1, %condval_11.0.1888, !dbg !188
  %idx.ext575.1.1 = sext i32 %add574.1.1 to i64, !dbg !189
  %add.ptr576.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.1.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep769.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 2048, !dbg !60
  %add.ptr564.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.2.1, i32 %add.ptr564.idx.2.1.pre-phi, !dbg !60
  %add569.2.1 = add nsw i32 %mul568, 1024, !dbg !193
  %add574.2.1 = add i32 %add569.2.1, %condval_11.0.1888, !dbg !188
  %idx.ext575.2.1 = sext i32 %add574.2.1 to i64, !dbg !189
  %add.ptr576.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.2.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.2.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep769.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep768, i32 3072, !dbg !60
  %add.ptr564.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep769.3.1, i32 %add.ptr564.idx.3.1.pre-phi, !dbg !60
  %add569.3.1 = add nsw i32 %mul568, 1536, !dbg !193
  %add574.3.1 = add i32 %add569.3.1, %condval_11.0.1888, !dbg !188
  %idx.ext575.3.1 = sext i32 %add574.3.1 to i64, !dbg !189
  %add.ptr576.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext575.3.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr576.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.3.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  fence syncscope("warp") release, !dbg !194
  tail call void @llvm.mxc.barrier.warp(), !dbg !197
  fence syncscope("warp") acquire, !dbg !198
  br label %if.end585, !dbg !201

if.end585:                                        ; preds = %if.end473, %if.end473.1, %entry
  ret void, !dbg !202
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #7

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #9

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpk7np81eg/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 8, !"PIC Level", i32 1}
!5 = distinct !DISubprogram(name: "__cxa_pure_virtual", scope: !6, file: !6, line: 38, type: !7, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!6 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_runtime_wrapper.h", directory: "")
!7 = !DISubroutineType(types: !8)
!8 = !{}
!9 = !DILocation(line: 39, column: 3, scope: !5)
!10 = !DILocation(line: 40, column: 1, scope: !5)
!11 = distinct !DISubprogram(name: "__cxa_deleted_virtual", scope: !6, file: !6, line: 43, type: !7, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!12 = !DILocation(line: 44, column: 3, scope: !11)
!13 = !DILocation(line: 45, column: 1, scope: !11)
!14 = distinct !DISubprogram(name: "__mcImplicitDeviceSynchronize", scope: !15, file: !15, line: 92, type: !7, scopeLine: 93, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!15 = !DIFile(filename: "/opt/maca/include/mckl/mc_device_runtime.h", directory: "")
!16 = !DILocation(line: 94, column: 5, scope: !14)
!17 = !{!18, !18, i64 0}
!18 = !{!"long", !19, i64 0}
!19 = !{!"omnipotent char", !20, i64 0}
!20 = !{!"Simple C++ TBAA"}
!21 = !{!22, !24, i64 16}
!22 = !{!"_ZTS21_DynamicParallMqlWrap", !23, i64 0, !23, i64 4, !23, i64 8, !23, i64 12, !24, i64 16, !24, i64 24, !25, i64 32}
!23 = !{!"int", !19, i64 0}
!24 = !{!"any pointer", !19, i64 0}
!25 = !{!"_ZTS28mxc_kernel_dispatch_packet_s", !26, i64 0, !26, i64 2, !26, i64 4, !26, i64 6, !26, i64 8, !26, i64 10, !23, i64 12, !23, i64 16, !23, i64 20, !23, i64 24, !23, i64 28, !18, i64 32, !24, i64 40, !18, i64 48, !27, i64 56}
!26 = !{!"short", !19, i64 0}
!27 = !{!"_ZTS12mxc_signal_s", !18, i64 0}
!28 = !{i32 1, i32 -2147483648}
!29 = !{i32 0, i32 2147483647}
!30 = !{!23, !23, i64 0}
!31 = distinct !{!31, !32}
!32 = !{!"llvm.loop.mustprogress"}
!33 = !{!22, !23, i64 4}
!34 = !{!22, !24, i64 24}
!35 = !{!22, !23, i64 0}
!36 = !{!37, !24, i64 24}
!37 = !{!"_ZTS28_DynamicParallSchedulerParam", !18, i64 0, !24, i64 8, !24, i64 16, !24, i64 24, !18, i64 32, !18, i64 40, !18, i64 48, !18, i64 56, !18, i64 64, !18, i64 72, !18, i64 80, !18, i64 88, !18, i64 96, !23, i64 104, !23, i64 108, !23, i64 112, !23, i64 116, !23, i64 120, !23, i64 124}
!38 = !{!37, !18, i64 80}
!39 = !DILocation(line: 95, column: 1, scope: !14)
!40 = distinct !DISubprogram(name: "kernel_kernel", scope: !41, file: !41, line: 10, type: !7, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!41 = !DIFile(filename: "/tmp/tmpk7np81eg/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 78, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_y", scope: !44, file: !44, line: 78, type: !7, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 22, column: 37, scope: !40)
!46 = !DILocation(line: 22, column: 49, scope: !40)
!47 = !DILocation(line: 77, column: 3, scope: !48, inlinedAt: !49)
!48 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!49 = distinct !DILocation(line: 22, column: 63, scope: !40)
!50 = !DILocation(line: 22, column: 55, scope: !40)
!51 = !DILocation(line: 22, column: 20, scope: !40)
!52 = !DILocation(line: 23, column: 26, scope: !40)
!53 = !DILocation(line: 23, column: 9, scope: !40)
!54 = !DILocation(line: 23, column: 7, scope: !40)
!55 = !{i32 0, i32 1024}
!56 = !DILocation(line: 23, column: 18, scope: !40)
!57 = !DILocation(line: 68, column: 62, scope: !40)
!58 = !DILocation(line: 177, column: 100, scope: !40)
!59 = !DILocation(line: 201, column: 261, scope: !40)
!60 = !DILocation(line: 201, column: 177, scope: !40)
!61 = !DILocation(line: 201, column: 275, scope: !40)
!62 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !65)
!63 = distinct !DISubprogram(name: "__barrier_warp", scope: !64, file: !64, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!64 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!65 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !67)
!66 = distinct !DISubprogram(name: "__syncwarp", scope: !64, file: !64, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!67 = distinct !DILocation(line: 174, column: 9, scope: !40)
!68 = !DILocation(line: 56, column: 37, scope: !40)
!69 = !DILocation(line: 56, column: 23, scope: !40)
!70 = !DILocation(line: 60, column: 40, scope: !40)
!71 = !DILocation(line: 25, column: 5, scope: !40)
!72 = !DILocation(line: 73, column: 61, scope: !40)
!73 = !DILocation(line: 73, column: 40, scope: !40)
!74 = !DILocation(line: 78, column: 139, scope: !40)
!75 = !DILocation(line: 78, column: 48, scope: !40)
!76 = !DILocation(line: 78, column: 223, scope: !40)
!77 = !DILocation(line: 78, column: 152, scope: !40)
!78 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !79)
!79 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !80)
!80 = distinct !DILocation(line: 80, column: 11, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !79)
!82 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !79)
!83 = !DILocation(line: 83, column: 156, scope: !40)
!84 = !DILocation(line: 83, column: 75, scope: !40)
!85 = !DILocation(line: 83, column: 38, scope: !40)
!86 = !DILocation(line: 83, column: 127, scope: !40)
!87 = !DILocation(line: 94, column: 170, scope: !40)
!88 = !DILocation(line: 94, column: 17, scope: !40)
!89 = !DILocation(line: 99, column: 25, scope: !40)
!90 = !DILocation(line: 94, column: 122, scope: !40)
!91 = !DILocation(line: 94, column: 157, scope: !40)
!92 = !DILocation(line: 105, column: 37, scope: !40)
!93 = !{i32 1, i32 -1, i32 -1}
!94 = !DILocation(line: 115, column: 61, scope: !40)
!95 = !DILocation(line: 115, column: 40, scope: !40)
!96 = !DILocation(line: 120, column: 38, scope: !40)
!97 = !DILocation(line: 120, column: 50, scope: !40)
!98 = !DILocation(line: 354, column: 10, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "min", scope: !100, file: !100, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!101 = distinct !DILocation(line: 120, column: 33, scope: !40)
!102 = !DILocation(line: 285, column: 49, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "exp2f", scope: !100, file: !100, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 120, column: 27, scope: !40)
!105 = !DILocation(line: 125, column: 34, scope: !40)
!106 = !DILocation(line: 1018, column: 9, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 396, column: 10, scope: !109, inlinedAt: !111)
!109 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !110, file: !110, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!110 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!111 = distinct !DILocation(line: 129, column: 24, scope: !112, inlinedAt: !114)
!112 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !113, file: !113, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!113 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!114 = distinct !DILocation(line: 101, column: 14, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "run<float>", scope: !113, file: !113, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!116 = distinct !DILocation(line: 127, column: 22, scope: !40)
!117 = !DILocation(line: 171, column: 37, scope: !118, inlinedAt: !119)
!118 = distinct !DISubprogram(name: "__lane_id", scope: !64, file: !64, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!119 = distinct !DILocation(line: 990, column: 14, scope: !120, inlinedAt: !121)
!120 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!121 = distinct !DILocation(line: 1019, column: 11, scope: !107, inlinedAt: !108)
!122 = !DILocation(line: 171, column: 10, scope: !118, inlinedAt: !119)
!123 = !DILocation(line: 991, column: 20, scope: !120, inlinedAt: !121)
!124 = !DILocation(line: 992, column: 36, scope: !120, inlinedAt: !121)
!125 = !DILocation(line: 992, column: 17, scope: !120, inlinedAt: !121)
!126 = !DILocation(line: 992, column: 11, scope: !120, inlinedAt: !121)
!127 = !DILocation(line: 993, column: 43, scope: !120, inlinedAt: !121)
!128 = !DILocation(line: 993, column: 10, scope: !120, inlinedAt: !121)
!129 = !DILocation(line: 1020, column: 14, scope: !107, inlinedAt: !108)
!130 = !DILocation(line: 25, column: 14, scope: !131, inlinedAt: !132)
!131 = distinct !DISubprogram(name: "operator()<float>", scope: !113, file: !113, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!132 = distinct !DILocation(line: 129, column: 11, scope: !112, inlinedAt: !114)
!133 = !DILocation(line: 1018, column: 9, scope: !107, inlinedAt: !134)
!134 = distinct !DILocation(line: 396, column: 10, scope: !109, inlinedAt: !135)
!135 = distinct !DILocation(line: 129, column: 24, scope: !136, inlinedAt: !137)
!136 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !113, file: !113, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!137 = distinct !DILocation(line: 101, column: 14, scope: !138, inlinedAt: !139)
!138 = distinct !DISubprogram(name: "run<float>", scope: !113, file: !113, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = distinct !DILocation(line: 134, column: 14, scope: !112, inlinedAt: !114)
!140 = !DILocation(line: 171, column: 37, scope: !118, inlinedAt: !141)
!141 = distinct !DILocation(line: 990, column: 14, scope: !120, inlinedAt: !142)
!142 = distinct !DILocation(line: 1019, column: 11, scope: !107, inlinedAt: !134)
!143 = !DILocation(line: 171, column: 10, scope: !118, inlinedAt: !141)
!144 = !DILocation(line: 991, column: 20, scope: !120, inlinedAt: !142)
!145 = !DILocation(line: 992, column: 36, scope: !120, inlinedAt: !142)
!146 = !DILocation(line: 992, column: 17, scope: !120, inlinedAt: !142)
!147 = !DILocation(line: 992, column: 11, scope: !120, inlinedAt: !142)
!148 = !DILocation(line: 993, column: 43, scope: !120, inlinedAt: !142)
!149 = !DILocation(line: 993, column: 10, scope: !120, inlinedAt: !142)
!150 = !DILocation(line: 1020, column: 14, scope: !107, inlinedAt: !134)
!151 = !DILocation(line: 25, column: 14, scope: !131, inlinedAt: !152)
!152 = distinct !DILocation(line: 129, column: 11, scope: !136, inlinedAt: !137)
!153 = !DILocation(line: 129, column: 40, scope: !40)
!154 = !DILocation(line: 129, column: 15, scope: !40)
!155 = !DILocation(line: 137, column: 40, scope: !40)
!156 = !DILocation(line: 75, column: 10, scope: !157, inlinedAt: !159)
!157 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !158, file: !158, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!158 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!159 = distinct !DILocation(line: 984, column: 9, scope: !160, inlinedAt: !162)
!160 = distinct !DISubprogram(name: "__float2half", scope: !161, file: !161, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!161 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!162 = distinct !DILocation(line: 133, column: 53, scope: !163, inlinedAt: !164)
!163 = distinct !DISubprogram(name: "__half", scope: !161, file: !161, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!164 = distinct !DILocation(line: 143, column: 55, scope: !40)
!165 = !DILocation(line: 143, column: 52, scope: !40)
!166 = !DILocation(line: 154, column: 36, scope: !40)
!167 = !DILocation(line: 164, column: 73, scope: !40)
!168 = !DILocation(line: 75, column: 10, scope: !157, inlinedAt: !169)
!169 = distinct !DILocation(line: 984, column: 9, scope: !160, inlinedAt: !170)
!170 = distinct !DILocation(line: 133, column: 53, scope: !163, inlinedAt: !171)
!171 = distinct !DILocation(line: 164, column: 65, scope: !40)
!172 = !DILocation(line: 164, column: 62, scope: !40)
!173 = !DILocation(line: 0, scope: !40)
!174 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !65)
!175 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !65)
!176 = !DILocation(line: 177, column: 129, scope: !40)
!177 = !DILocation(line: 177, column: 158, scope: !40)
!178 = !DILocation(line: 177, column: 84, scope: !40)
!179 = !DILocation(line: 177, column: 164, scope: !40)
!180 = !DILocation(line: 177, column: 46, scope: !40)
!181 = !DILocation(line: 177, column: 207, scope: !40)
!182 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !183)
!183 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !184)
!184 = distinct !DILocation(line: 179, column: 9, scope: !40)
!185 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !183)
!186 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !183)
!187 = !DILocation(line: 201, column: 86, scope: !40)
!188 = !DILocation(line: 201, column: 111, scope: !40)
!189 = !DILocation(line: 201, column: 30, scope: !40)
!190 = !DILocation(line: 201, column: 140, scope: !40)
!191 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!192 = !{i32 0, i32 -1, i32 -1, i32 -1}
!193 = !DILocation(line: 201, column: 72, scope: !40)
!194 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !195)
!195 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !196)
!196 = distinct !DILocation(line: 204, column: 9, scope: !40)
!197 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !195)
!198 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !195)
!199 = !DILocation(line: 32, column: 13, scope: !40)
!200 = !DILocation(line: 32, column: 11, scope: !40)
!201 = !DILocation(line: 205, column: 7, scope: !40)
!202 = !DILocation(line: 208, column: 1, scope: !40)
