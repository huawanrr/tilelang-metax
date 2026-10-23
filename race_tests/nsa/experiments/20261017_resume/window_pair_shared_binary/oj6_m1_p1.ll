; ModuleID = 'experiments/20261017_resume/window_pair_shared_binary/oj6_m1_p1.bc'
source_filename = "/tmp/tmpbgl_l5zi/tvm_kernels.maca"
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
  br i1 %cmp.not, label %if.end587, label %for.cond.preheader, !dbg !54

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
  %and177 = shl nuw nsw i32 %5, 7
  %mul178 = and i32 %and177, 1920
  %shr181 = lshr i32 %5, 4
  %and184 = and i32 %5, 15
  %gep776 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %mul178
  %9 = lshr i32 %5, 2
  %mul227 = and i32 %9, 252
  %add224 = add nuw nsw i32 %mul108, %mul227
  %mul499 = and i32 %9, 4
  %mul554 = and i32 %8, 8064
  %invariant.gep773 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul554
  %10 = shl nuw nsw i32 %0, 18
  %mul569 = and i32 %10, 2145386496
  %add573 = add nsw i32 %8, -2048
  %mul570 = add nsw i32 %add573, %mul569
  %conv = trunc nuw nsw i64 %and to i32, !dbg !56
  %.780 = tail call i32 @llvm.smin.i32(i32 %conv, i32 1024)
  %cmp109 = icmp slt i32 %mul108, %.780
  %or.cond703 = select i1 %or.cond, i1 %cmp109, i1 false, !dbg !57
  br i1 %or.cond703, label %for.body116.preheader, label %for.body455.preheader, !dbg !57

for.body455.preheader:                            ; preds = %for.cond.preheader
  %.pre1778 = add nuw nsw i32 %shr158, 2, !dbg !58
  %.pre1779 = add nuw nsw i32 %shr158, 4, !dbg !58
  %.pre1780 = add nuw nsw i32 %shr158, 6, !dbg !58
  %.pre1781 = add nuw nsw i32 %shr158, 8, !dbg !58
  %.pre1782 = add nuw nsw i32 %shr158, 10, !dbg !58
  %.pre1783 = add nuw nsw i32 %shr158, 12, !dbg !58
  %.pre1784 = add nuw nsw i32 %shr158, 14, !dbg !58
  %.pre1785 = xor i32 %shr181, %and184, !dbg !59
  %.pre1786 = shl nuw nsw i32 %.pre1785, 4, !dbg !60
  %.pre1787 = add nuw nsw i32 %shr181, 4, !dbg !61
  %.pre1788 = xor i32 %.pre1787, %and184, !dbg !59
  %.pre1789 = shl nuw nsw i32 %.pre1788, 4, !dbg !60
  %.pre1790 = add nuw nsw i32 %shr181, 8, !dbg !61
  %.pre1791 = xor i32 %.pre1790, %and184, !dbg !59
  %.pre1792 = shl nuw nsw i32 %.pre1791, 4, !dbg !60
  %.pre1793 = add nuw nsw i32 %shr181, 12, !dbg !61
  %.pre1794 = xor i32 %.pre1793, %and184, !dbg !59
  %.pre1795 = shl nuw nsw i32 %.pre1794, 4, !dbg !60
  br label %if.end475, !dbg !62

for.body116.preheader:                            ; preds = %for.cond.preheader
  %.idx785 = shl nuw nsw i64 %shr63, 22, !dbg !68
  %11 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx785, !dbg !68
  %12 = getelementptr i8, ptr addrspace(4) %11, i64 -512, !dbg !68
  %13 = tail call i64 @llvm.umin.i64(i64 %and, i64 1024)
  %gep.idx = shl nuw nsw i64 %13, 12, !dbg !68
  %gep.7 = getelementptr i8, ptr addrspace(4) %12, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr inbounds i8, ptr addrspace(4) %gep.7, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.44.60.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.7 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.shift = shl nuw i64 %q_stage.sroa.44.60.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.44.56.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.7 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %q_stage.sroa.44.60.insert.shift, %q_stage.sroa.44.56.insert.ext, !dbg !70
  %14 = getelementptr i8, ptr addrspace(4) %11, i64 -1024, !dbg !68
  %gep.6 = getelementptr i8, ptr addrspace(4) %14, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr inbounds i8, ptr addrspace(4) %gep.6, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.6 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.6 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext, !dbg !70
  %15 = getelementptr i8, ptr addrspace(4) %11, i64 -1536, !dbg !68
  %gep.5 = getelementptr i8, ptr addrspace(4) %15, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr inbounds i8, ptr addrspace(4) %gep.5, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.5 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.5 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext, !dbg !70
  %16 = getelementptr i8, ptr addrspace(4) %11, i64 -2048, !dbg !68
  %gep.4 = getelementptr i8, ptr addrspace(4) %16, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr inbounds i8, ptr addrspace(4) %gep.4, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.4 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.4 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext, !dbg !70
  %17 = getelementptr i8, ptr addrspace(4) %11, i64 -2560, !dbg !68
  %gep.3 = getelementptr i8, ptr addrspace(4) %17, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %gep.3, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.3 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.3 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext, !dbg !70
  %18 = getelementptr i8, ptr addrspace(4) %11, i64 -3072, !dbg !68
  %gep.2 = getelementptr i8, ptr addrspace(4) %18, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %gep.2, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.2 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.2 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext, !dbg !70
  %19 = getelementptr i8, ptr addrspace(4) %11, i64 -3584, !dbg !68
  %gep.1 = getelementptr i8, ptr addrspace(4) %19, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext, !dbg !70
  %20 = getelementptr i8, ptr addrspace(4) %11, i64 -4096, !dbg !68
  %gep = getelementptr i8, ptr addrspace(4) %20, i64 %gep.idx, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0.copyload to i64, !dbg !70
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32, !dbg !70
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %gep, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0.copyload to i64, !dbg !70
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext, !dbg !70
  %invariant.gep777 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !71
  %mul129 = zext nneg i32 %8 to i64
  %gep778 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep777, i64 %mul129
  %invariant.gep744 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul129
  %.idx787 = shl nuw nsw i64 %shr100, 14, !dbg !72
  %21 = getelementptr i8, ptr addrspace(4) %invariant.gep744, i64 %.idx787, !dbg !72
  %.idx788 = shl nuw nsw i64 %shr63, 19, !dbg !72
  %22 = getelementptr i8, ptr addrspace(4) %21, i64 %.idx788, !dbg !72
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %22, align 16, !dbg !73
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %22, i64 8, !dbg !73
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8, !dbg !73
  %gep745.1 = getelementptr i8, ptr addrspace(4) %22, i64 1024, !dbg !72
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep745.1, align 16, !dbg !73
  %k.sroa.12.16.gep745.1.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 1032, !dbg !73
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep745.1.sroa_idx, align 8, !dbg !73
  %gep745.2 = getelementptr i8, ptr addrspace(4) %22, i64 2048, !dbg !72
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep745.2, align 16, !dbg !73
  %k.sroa.18.32.gep745.2.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 2056, !dbg !73
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep745.2.sroa_idx, align 8, !dbg !73
  %gep745.3 = getelementptr i8, ptr addrspace(4) %22, i64 3072, !dbg !72
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep745.3, align 16, !dbg !73
  %k.sroa.24.48.gep745.3.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 3080, !dbg !73
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep745.3.sroa_idx, align 8, !dbg !73
  %gep745.4 = getelementptr i8, ptr addrspace(4) %22, i64 4096, !dbg !72
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep745.4, align 16, !dbg !73
  %k.sroa.30.64.gep745.4.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 4104, !dbg !73
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep745.4.sroa_idx, align 8, !dbg !73
  %gep745.5 = getelementptr i8, ptr addrspace(4) %22, i64 5120, !dbg !72
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep745.5, align 16, !dbg !73
  %k.sroa.36.80.gep745.5.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 5128, !dbg !73
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep745.5.sroa_idx, align 8, !dbg !73
  %gep745.6 = getelementptr i8, ptr addrspace(4) %22, i64 6144, !dbg !72
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep745.6, align 16, !dbg !73
  %k.sroa.42.96.gep745.6.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 6152, !dbg !73
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep745.6.sroa_idx, align 8, !dbg !73
  %gep745.7 = getelementptr i8, ptr addrspace(4) %22, i64 7168, !dbg !72
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep745.7, align 16, !dbg !73
  %k.sroa.48.112.gep745.7.sroa_idx = getelementptr i8, ptr addrspace(4) %22, i64 7176, !dbg !73
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep745.7.sroa_idx, align 8, !dbg !73
  %xor = xor i32 %shr158, %shr155, !dbg !74
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add152, !dbg !75
  %gep747.idx = shl nuw nsw i32 %xor, 4, !dbg !75
  %gep747 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 %gep747.idx, !dbg !75
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %gep747, align 8, !dbg !76
  %add159.1 = add nuw nsw i32 %shr158, 2, !dbg !77
  %xor.1 = xor i32 %add159.1, %shr155, !dbg !74
  %24 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 512, !dbg !75
  %gep747.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !75
  %gep747.1 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep747.idx.1, !dbg !75
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %gep747.1, align 8, !dbg !76
  %add159.2 = add nuw nsw i32 %shr158, 4, !dbg !77
  %xor.2 = xor i32 %add159.2, %shr155, !dbg !74
  %25 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 1024, !dbg !75
  %gep747.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !75
  %gep747.2 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %gep747.idx.2, !dbg !75
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %gep747.2, align 8, !dbg !76
  %add159.3 = add nuw nsw i32 %shr158, 6, !dbg !77
  %xor.3 = xor i32 %add159.3, %shr155, !dbg !74
  %26 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 1536, !dbg !75
  %gep747.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !75
  %gep747.3 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %gep747.idx.3, !dbg !75
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %gep747.3, align 8, !dbg !76
  %add159.4 = add nuw nsw i32 %shr158, 8, !dbg !77
  %xor.4 = xor i32 %add159.4, %shr155, !dbg !74
  %27 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 2048, !dbg !75
  %gep747.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !75
  %gep747.4 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %gep747.idx.4, !dbg !75
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %gep747.4, align 8, !dbg !76
  %add159.5 = add nuw nsw i32 %shr158, 10, !dbg !77
  %xor.5 = xor i32 %add159.5, %shr155, !dbg !74
  %28 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 2560, !dbg !75
  %gep747.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !75
  %gep747.5 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %gep747.idx.5, !dbg !75
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %gep747.5, align 8, !dbg !76
  %add159.6 = add nuw nsw i32 %shr158, 12, !dbg !77
  %xor.6 = xor i32 %add159.6, %shr155, !dbg !74
  %29 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 3072, !dbg !75
  %gep747.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !75
  %gep747.6 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %gep747.idx.6, !dbg !75
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %gep747.6, align 8, !dbg !76
  %add159.7 = add nuw nsw i32 %shr158, 14, !dbg !77
  %xor.7 = xor i32 %add159.7, %shr155, !dbg !74
  %30 = getelementptr inbounds i8, ptr addrspace(3) %23, i32 3584, !dbg !75
  %gep747.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !75
  %gep747.7 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %gep747.idx.7, !dbg !75
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %gep747.7, align 8, !dbg !76
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %xor185 = xor i32 %shr181, %and184, !dbg !83
  %.idx = shl nuw nsw i32 %xor185, 4, !dbg !84
  %gep750 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx, !dbg !84
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep750, align 16, !dbg !85
  %q.sroa.6.0.gep750.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750, i32 8, !dbg !85
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep750.sroa_idx, align 8, !dbg !85
  %add182.1 = add nuw nsw i32 %shr181, 4, !dbg !86
  %xor185.1 = xor i32 %add182.1, %and184, !dbg !83
  %.idx.1 = shl nuw nsw i32 %xor185.1, 4, !dbg !84
  %gep750.1 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx.1, !dbg !84
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep750.1, align 16, !dbg !85
  %q.sroa.12.16.gep750.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1, i32 8, !dbg !85
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep750.1.sroa_idx, align 8, !dbg !85
  %add182.2 = add nuw nsw i32 %shr181, 8, !dbg !86
  %xor185.2 = xor i32 %add182.2, %and184, !dbg !83
  %.idx.2 = shl nuw nsw i32 %xor185.2, 4, !dbg !84
  %gep750.2 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx.2, !dbg !84
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %gep750.2, align 16, !dbg !85
  %q.sroa.18.32.gep750.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.2, i32 8, !dbg !85
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep750.2.sroa_idx, align 8, !dbg !85
  %add182.3 = add nuw nsw i32 %shr181, 12, !dbg !86
  %xor185.3 = xor i32 %add182.3, %and184, !dbg !83
  %.idx.3 = shl nuw nsw i32 %xor185.3, 4, !dbg !84
  %gep750.3 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx.3, !dbg !84
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %gep750.3, align 16, !dbg !85
  %q.sroa.24.48.gep750.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.3, i32 8, !dbg !85
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep750.3.sroa_idx, align 8, !dbg !85
  %cmp231.not.not = icmp slt i32 %add224, %.780, !dbg !87
  %spec.select = select i1 %cmp231.not.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !89
  %add228.1 = or disjoint i32 %add224, 1, !dbg !90
  %cmp231.not.not.1 = icmp slt i32 %add228.1, %.780, !dbg !87
  %spec.select.1 = select i1 %cmp231.not.not.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !89
  %add228.2 = or disjoint i32 %add224, 2, !dbg !90
  %cmp231.not.not.2 = icmp slt i32 %add228.2, %.780, !dbg !87
  %spec.select.2 = select i1 %cmp231.not.not.2, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !89
  %add228.3 = or disjoint i32 %add224, 3, !dbg !90
  %cmp231.not.not.3 = icmp slt i32 %add228.3, %.780, !dbg !87
  %spec.select.3 = select i1 %cmp231.not.not.3, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !89
  %add230.4 = add nuw nsw i32 %add224, 16, !dbg !91
  %cmp231.not.not.4 = icmp slt i32 %add230.4, %.780, !dbg !87
  %spec.select.4 = select i1 %cmp231.not.not.4, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !89
  %add230.5 = add nuw nsw i32 %add224, 17, !dbg !91
  %cmp231.not.not.5 = icmp slt i32 %add230.5, %.780, !dbg !87
  %spec.select.5 = select i1 %cmp231.not.not.5, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1, !dbg !89
  %add230.6 = add nuw nsw i32 %add224, 18, !dbg !91
  %cmp231.not.not.6 = icmp slt i32 %add230.6, %.780, !dbg !87
  %spec.select.6 = select i1 %cmp231.not.not.6, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2, !dbg !89
  %add230.7 = add nuw nsw i32 %add224, 19, !dbg !91
  %cmp231.not.not.7 = icmp slt i32 %add230.7, %.780, !dbg !87
  %spec.select.7 = select i1 %cmp231.not.not.7, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3, !dbg !89
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !92, !call_argsrelate !93
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !dbg !92, !call_argsrelate !93
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %31), !dbg !92, !call_argsrelate !93
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %32), !dbg !92, !call_argsrelate !93
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %33), !dbg !92, !call_argsrelate !93
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %34), !dbg !92, !call_argsrelate !93
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %35), !dbg !92, !call_argsrelate !93
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %36), !dbg !92, !call_argsrelate !93
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %37), !dbg !92, !call_argsrelate !93
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %38), !dbg !92, !call_argsrelate !93
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %39), !dbg !92, !call_argsrelate !93
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %40), !dbg !92, !call_argsrelate !93
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %41), !dbg !92, !call_argsrelate !93
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %42), !dbg !92, !call_argsrelate !93
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %43), !dbg !92, !call_argsrelate !93
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %44), !dbg !92, !call_argsrelate !93
  %.idx793 = shl nuw nsw i64 %shr100, 14, !dbg !94
  %47 = getelementptr i8, ptr addrspace(4) %gep778, i64 %.idx793, !dbg !94
  %.idx794 = shl nuw nsw i64 %shr63, 19, !dbg !94
  %48 = getelementptr i8, ptr addrspace(4) %47, i64 %.idx794, !dbg !94
  %v.sroa.48.112.gep759.7.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 7176, !dbg !95
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep759.7.sroa_idx, align 8, !dbg !95
  %gep759.7 = getelementptr i8, ptr addrspace(4) %48, i64 7168, !dbg !94
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep759.7, align 16, !dbg !95
  %v.sroa.42.96.gep759.6.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 6152, !dbg !95
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep759.6.sroa_idx, align 8, !dbg !95
  %gep759.6 = getelementptr i8, ptr addrspace(4) %48, i64 6144, !dbg !94
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep759.6, align 16, !dbg !95
  %v.sroa.36.80.gep759.5.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 5128, !dbg !95
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep759.5.sroa_idx, align 8, !dbg !95
  %gep759.5 = getelementptr i8, ptr addrspace(4) %48, i64 5120, !dbg !94
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep759.5, align 16, !dbg !95
  %v.sroa.30.64.gep759.4.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 4104, !dbg !95
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep759.4.sroa_idx, align 8, !dbg !95
  %gep759.4 = getelementptr i8, ptr addrspace(4) %48, i64 4096, !dbg !94
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep759.4, align 16, !dbg !95
  %v.sroa.24.48.gep759.3.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 3080, !dbg !95
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep759.3.sroa_idx, align 8, !dbg !95
  %gep759.3 = getelementptr i8, ptr addrspace(4) %48, i64 3072, !dbg !94
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep759.3, align 16, !dbg !95
  %v.sroa.18.32.gep759.2.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 2056, !dbg !95
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep759.2.sroa_idx, align 8, !dbg !95
  %gep759.2 = getelementptr i8, ptr addrspace(4) %48, i64 2048, !dbg !94
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep759.2, align 16, !dbg !95
  %v.sroa.12.16.gep759.1.sroa_idx = getelementptr i8, ptr addrspace(4) %48, i64 1032, !dbg !95
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep759.1.sroa_idx, align 8, !dbg !95
  %gep759.1 = getelementptr i8, ptr addrspace(4) %48, i64 1024, !dbg !94
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep759.1, align 16, !dbg !95
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %48, i64 8, !dbg !95
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8, !dbg !95
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %48, align 16, !dbg !95
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %45, i64 0, !dbg !96
  %mul316 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !97
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul316, float 1.500000e+01), !dbg !98
  %cmp.i.i = fcmp contract olt float %49, -1.260000e+02, !dbg !102
  %cond.i.i726 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727 = fadd contract float %49, %cond.i.i726, !dbg !102
  %50 = tail call contract float @llvm.exp2.f32(float %add.i.i727), !dbg !102
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i = fmul contract float %cond2.i.i, %50, !dbg !102
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %45, i64 1, !dbg !96
  %mul316.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !97
  %51 = tail call contract noundef float @llvm.minnum.f32(float %mul316.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.1 = fcmp contract olt float %51, -1.260000e+02, !dbg !102
  %cond.i.i726.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.1 = fadd contract float %51, %cond.i.i726.1, !dbg !102
  %52 = tail call contract float @llvm.exp2.f32(float %add.i.i727.1), !dbg !102
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %52, !dbg !102
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %45, i64 2, !dbg !96
  %mul316.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !97
  %53 = tail call contract noundef float @llvm.minnum.f32(float %mul316.2, float 1.500000e+01), !dbg !98
  %cmp.i.i.2 = fcmp contract olt float %53, -1.260000e+02, !dbg !102
  %cond.i.i726.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.2 = fadd contract float %53, %cond.i.i726.2, !dbg !102
  %54 = tail call contract float @llvm.exp2.f32(float %add.i.i727.2), !dbg !102
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %54, !dbg !102
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %45, i64 3, !dbg !96
  %mul316.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !97
  %55 = tail call contract noundef float @llvm.minnum.f32(float %mul316.3, float 1.500000e+01), !dbg !98
  %cmp.i.i.3 = fcmp contract olt float %55, -1.260000e+02, !dbg !102
  %cond.i.i726.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.3 = fadd contract float %55, %cond.i.i726.3, !dbg !102
  %56 = tail call contract float @llvm.exp2.f32(float %add.i.i727.3), !dbg !102
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %56, !dbg !102
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !96
  %mul316.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000, !dbg !97
  %57 = tail call contract noundef float @llvm.minnum.f32(float %mul316.4, float 1.500000e+01), !dbg !98
  %cmp.i.i.4 = fcmp contract olt float %57, -1.260000e+02, !dbg !102
  %cond.i.i726.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.4 = fadd contract float %57, %cond.i.i726.4, !dbg !102
  %58 = tail call contract float @llvm.exp2.f32(float %add.i.i727.4), !dbg !102
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %58, !dbg !102
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %46, i64 1, !dbg !96
  %mul316.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000, !dbg !97
  %59 = tail call contract noundef float @llvm.minnum.f32(float %mul316.5, float 1.500000e+01), !dbg !98
  %cmp.i.i.5 = fcmp contract olt float %59, -1.260000e+02, !dbg !102
  %cond.i.i726.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.5 = fadd contract float %59, %cond.i.i726.5, !dbg !102
  %60 = tail call contract float @llvm.exp2.f32(float %add.i.i727.5), !dbg !102
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %60, !dbg !102
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %46, i64 2, !dbg !96
  %mul316.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000, !dbg !97
  %61 = tail call contract noundef float @llvm.minnum.f32(float %mul316.6, float 1.500000e+01), !dbg !98
  %cmp.i.i.6 = fcmp contract olt float %61, -1.260000e+02, !dbg !102
  %cond.i.i726.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.6 = fadd contract float %61, %cond.i.i726.6, !dbg !102
  %62 = tail call contract float @llvm.exp2.f32(float %add.i.i727.6), !dbg !102
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %62, !dbg !102
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %46, i64 3, !dbg !96
  %mul316.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000, !dbg !97
  %63 = tail call contract noundef float @llvm.minnum.f32(float %mul316.7, float 1.500000e+01), !dbg !98
  %cmp.i.i.7 = fcmp contract olt float %63, -1.260000e+02, !dbg !102
  %cond.i.i726.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.7 = fadd contract float %63, %cond.i.i726.7, !dbg !102
  %64 = tail call contract float @llvm.exp2.f32(float %add.i.i727.7), !dbg !102
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %64, !dbg !102
  %add336 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !105
  %add336.1 = fadd contract float %add336, %mul.i.i.4, !dbg !105
  %add336.2 = fadd contract float %add336.1, %mul.i.i.1, !dbg !105
  %add336.3 = fadd contract float %add336.2, %mul.i.i.5, !dbg !105
  %add336.4 = fadd contract float %add336.3, %mul.i.i.2, !dbg !105
  %add336.5 = fadd contract float %add336.4, %mul.i.i.6, !dbg !105
  %add336.6 = fadd contract float %add336.5, %mul.i.i.3, !dbg !105
  %add336.7 = fadd contract float %add336.6, %mul.i.i.7, !dbg !105
  %65 = bitcast float %add336.7 to i32, !dbg !106
  %66 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !117
  %67 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %66) #11, !dbg !122
  %xor.i.i = xor i32 %67, 32, !dbg !123
  %68 = and i32 %67, -64, !dbg !124
  %and.i.i = add nsw i32 %68, 64, !dbg !124
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !125
  %cond.i.i728 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %67, !dbg !126
  %shl.i.i = shl i32 %cond.i.i728, 2, !dbg !127
  %69 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %65), !dbg !128
  %70 = bitcast i32 %69 to float, !dbg !129
  %add.i = fadd contract float %add336.7, %70, !dbg !130
  %71 = bitcast float %add.i to i32, !dbg !133
  %72 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !140
  %73 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %72) #11, !dbg !143
  %xor.i.i729 = xor i32 %73, 16, !dbg !144
  %74 = and i32 %73, -64, !dbg !145
  %and.i.i730 = add nsw i32 %74, 64, !dbg !145
  %cmp.not.i.i731 = icmp slt i32 %xor.i.i729, %and.i.i730, !dbg !146
  %cond.i.i732 = select i1 %cmp.not.i.i731, i32 %xor.i.i729, i32 %73, !dbg !147
  %shl.i.i733 = shl i32 %cond.i.i732, 2, !dbg !148
  %75 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i733, i32 %71), !dbg !149
  %76 = bitcast i32 %75 to float, !dbg !150
  %add.i.i = fadd contract float %add.i, %76, !dbg !151
  %cmp345 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !153
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !154
  %condval_8.0 = select i1 %cmp345, float %div, float 0.000000e+00, !dbg !154
  %mul358 = fmul contract float %condval_8.0, %mul.i.i, !dbg !155
  %mul358.1 = fmul contract float %condval_8.0, %mul.i.i.1, !dbg !155
  %mul358.2 = fmul contract float %condval_8.0, %mul.i.i.2, !dbg !155
  %mul358.3 = fmul contract float %condval_8.0, %mul.i.i.3, !dbg !155
  %mul358.4 = fmul contract float %condval_8.0, %mul.i.i.4, !dbg !155
  %mul358.5 = fmul contract float %condval_8.0, %mul.i.i.5, !dbg !155
  %mul358.6 = fmul contract float %condval_8.0, %mul.i.i.6, !dbg !155
  %mul358.7 = fmul contract float %condval_8.0, %mul.i.i.7, !dbg !155
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358), !dbg !156
  %78 = insertelement <4 x i16> poison, i16 %77, i64 0, !dbg !165
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.1), !dbg !156
  %80 = insertelement <4 x i16> %78, i16 %79, i64 1, !dbg !165
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.2), !dbg !156
  %82 = insertelement <4 x i16> %80, i16 %81, i64 2, !dbg !165
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.3), !dbg !156
  %84 = insertelement <4 x i16> %82, i16 %83, i64 3, !dbg !165
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %84 to <4 x half>, !dbg !165
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.4), !dbg !156
  %86 = insertelement <4 x i16> poison, i16 %85, i64 0, !dbg !165
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.5), !dbg !156
  %88 = insertelement <4 x i16> %86, i16 %87, i64 1, !dbg !165
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.6), !dbg !156
  %90 = insertelement <4 x i16> %88, i16 %89, i64 2, !dbg !165
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.7), !dbg !156
  %92 = insertelement <4 x i16> %90, i16 %91, i64 3, !dbg !165
  %prob.sroa.12.14.vec.insert = bitcast <4 x i16> %92 to <4 x half>, !dbg !165
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166, !call_argsrelate !93
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %93), !dbg !166, !call_argsrelate !93
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %94), !dbg !166, !call_argsrelate !93
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %95), !dbg !166, !call_argsrelate !93
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %96), !dbg !166, !call_argsrelate !93
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %97), !dbg !166, !call_argsrelate !93
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %98), !dbg !166, !call_argsrelate !93
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %99), !dbg !166, !call_argsrelate !93
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %100), !dbg !166, !call_argsrelate !93
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %101, i64 0, !dbg !167
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !168
  %output_reg.sroa.0.0.insert.ext = zext i16 %109 to i64, !dbg !172
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %101, i64 1, !dbg !167
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !168
  %output_reg.sroa.0.2.insert.ext = zext i16 %110 to i64, !dbg !172
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !172
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !172
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %101, i64 2, !dbg !167
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !168
  %output_reg.sroa.0.4.insert.ext = zext i16 %111 to i64, !dbg !172
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !172
  %output_reg.sroa.0.4.insert.insert1112 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !172
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %101, i64 3, !dbg !167
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !168
  %output_reg.sroa.0.6.insert.ext = zext i16 %112 to i64, !dbg !172
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !172
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1112, %output_reg.sroa.0.6.insert.shift, !dbg !172
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !167
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract), !dbg !168
  %output_reg.sroa.16.8.insert.ext = zext i16 %113 to i64, !dbg !172
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !167
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract), !dbg !168
  %output_reg.sroa.16.10.insert.ext = zext i16 %114 to i64, !dbg !172
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16, !dbg !172
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext, !dbg !172
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !167
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract), !dbg !168
  %output_reg.sroa.16.12.insert.ext = zext i16 %115 to i64, !dbg !172
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32, !dbg !172
  %output_reg.sroa.16.12.insert.insert1144 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift, !dbg !172
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !167
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract), !dbg !168
  %output_reg.sroa.16.14.insert.ext = zext i16 %116 to i64, !dbg !172
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48, !dbg !172
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1144, %output_reg.sroa.16.14.insert.shift, !dbg !172
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %103, i64 0, !dbg !167
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract), !dbg !168
  %output_reg.sroa.30.16.insert.ext = zext i16 %117 to i64, !dbg !172
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %103, i64 1, !dbg !167
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract), !dbg !168
  %output_reg.sroa.30.18.insert.ext = zext i16 %118 to i64, !dbg !172
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16, !dbg !172
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext, !dbg !172
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %103, i64 2, !dbg !167
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract), !dbg !168
  %output_reg.sroa.30.20.insert.ext = zext i16 %119 to i64, !dbg !172
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32, !dbg !172
  %output_reg.sroa.30.20.insert.insert1176 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift, !dbg !172
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %103, i64 3, !dbg !167
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract), !dbg !168
  %output_reg.sroa.30.22.insert.ext = zext i16 %120 to i64, !dbg !172
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48, !dbg !172
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1176, %output_reg.sroa.30.22.insert.shift, !dbg !172
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %104, i64 0, !dbg !167
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract), !dbg !168
  %output_reg.sroa.44.24.insert.ext = zext i16 %121 to i64, !dbg !172
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %104, i64 1, !dbg !167
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract), !dbg !168
  %output_reg.sroa.44.26.insert.ext = zext i16 %122 to i64, !dbg !172
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16, !dbg !172
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext, !dbg !172
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %104, i64 2, !dbg !167
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract), !dbg !168
  %output_reg.sroa.44.28.insert.ext = zext i16 %123 to i64, !dbg !172
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32, !dbg !172
  %output_reg.sroa.44.28.insert.insert1208 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift, !dbg !172
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %104, i64 3, !dbg !167
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract), !dbg !168
  %output_reg.sroa.44.30.insert.ext = zext i16 %124 to i64, !dbg !172
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48, !dbg !172
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1208, %output_reg.sroa.44.30.insert.shift, !dbg !172
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %105, i64 0, !dbg !167
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract), !dbg !168
  %output_reg.sroa.58.32.insert.ext = zext i16 %125 to i64, !dbg !172
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %105, i64 1, !dbg !167
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract), !dbg !168
  %output_reg.sroa.58.34.insert.ext = zext i16 %126 to i64, !dbg !172
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16, !dbg !172
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext, !dbg !172
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %105, i64 2, !dbg !167
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract), !dbg !168
  %output_reg.sroa.58.36.insert.ext = zext i16 %127 to i64, !dbg !172
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32, !dbg !172
  %output_reg.sroa.58.36.insert.insert1240 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift, !dbg !172
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %105, i64 3, !dbg !167
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract), !dbg !168
  %output_reg.sroa.58.38.insert.ext = zext i16 %128 to i64, !dbg !172
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48, !dbg !172
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1240, %output_reg.sroa.58.38.insert.shift, !dbg !172
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %106, i64 0, !dbg !167
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract), !dbg !168
  %output_reg.sroa.72.40.insert.ext = zext i16 %129 to i64, !dbg !172
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %106, i64 1, !dbg !167
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract), !dbg !168
  %output_reg.sroa.72.42.insert.ext = zext i16 %130 to i64, !dbg !172
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16, !dbg !172
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext, !dbg !172
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %106, i64 2, !dbg !167
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract), !dbg !168
  %output_reg.sroa.72.44.insert.ext = zext i16 %131 to i64, !dbg !172
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32, !dbg !172
  %output_reg.sroa.72.44.insert.insert1272 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift, !dbg !172
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %106, i64 3, !dbg !167
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract), !dbg !168
  %output_reg.sroa.72.46.insert.ext = zext i16 %132 to i64, !dbg !172
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48, !dbg !172
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1272, %output_reg.sroa.72.46.insert.shift, !dbg !172
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %107, i64 0, !dbg !167
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract), !dbg !168
  %output_reg.sroa.86.48.insert.ext = zext i16 %133 to i64, !dbg !172
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %107, i64 1, !dbg !167
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract), !dbg !168
  %output_reg.sroa.86.50.insert.ext = zext i16 %134 to i64, !dbg !172
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16, !dbg !172
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext, !dbg !172
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %107, i64 2, !dbg !167
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract), !dbg !168
  %output_reg.sroa.86.52.insert.ext = zext i16 %135 to i64, !dbg !172
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32, !dbg !172
  %output_reg.sroa.86.52.insert.insert1304 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift, !dbg !172
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %107, i64 3, !dbg !167
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract), !dbg !168
  %output_reg.sroa.86.54.insert.ext = zext i16 %136 to i64, !dbg !172
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48, !dbg !172
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1304, %output_reg.sroa.86.54.insert.shift, !dbg !172
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %108, i64 0, !dbg !167
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract), !dbg !168
  %output_reg.sroa.100.56.insert.ext = zext i16 %137 to i64, !dbg !172
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %108, i64 1, !dbg !167
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract), !dbg !168
  %output_reg.sroa.100.58.insert.ext = zext i16 %138 to i64, !dbg !172
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16, !dbg !172
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext, !dbg !172
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %108, i64 2, !dbg !167
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract), !dbg !168
  %output_reg.sroa.100.60.insert.ext = zext i16 %139 to i64, !dbg !172
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32, !dbg !172
  %output_reg.sroa.100.60.insert.insert1336 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift, !dbg !172
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %108, i64 3, !dbg !167
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract), !dbg !168
  %output_reg.sroa.100.62.insert.ext = zext i16 %140 to i64, !dbg !172
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48, !dbg !172
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1336, %output_reg.sroa.100.62.insert.shift, !dbg !172
  br label %if.end475, !dbg !62

if.end475:                                        ; preds = %for.body455.preheader, %for.body116.preheader
  %add.ptr566.idx.3.pre-phi = phi i32 [ %.pre1795, %for.body455.preheader ], [ %.idx.3, %for.body116.preheader ], !dbg !60
  %add.ptr566.idx.2.pre-phi = phi i32 [ %.pre1792, %for.body455.preheader ], [ %.idx.2, %for.body116.preheader ], !dbg !60
  %add.ptr566.idx.1.pre-phi = phi i32 [ %.pre1789, %for.body455.preheader ], [ %.idx.1, %for.body116.preheader ], !dbg !60
  %add.ptr566.idx.pre-phi = phi i32 [ %.pre1786, %for.body455.preheader ], [ %.idx, %for.body116.preheader ], !dbg !60
  %add490.7.pre-phi = phi i32 [ %.pre1784, %for.body455.preheader ], [ %add159.7, %for.body116.preheader ], !dbg !58
  %add490.6.pre-phi = phi i32 [ %.pre1783, %for.body455.preheader ], [ %add159.6, %for.body116.preheader ], !dbg !58
  %add490.5.pre-phi = phi i32 [ %.pre1782, %for.body455.preheader ], [ %add159.5, %for.body116.preheader ], !dbg !58
  %add490.4.pre-phi = phi i32 [ %.pre1781, %for.body455.preheader ], [ %add159.4, %for.body116.preheader ], !dbg !58
  %add490.3.pre-phi = phi i32 [ %.pre1780, %for.body455.preheader ], [ %add159.3, %for.body116.preheader ], !dbg !58
  %add490.2.pre-phi = phi i32 [ %.pre1779, %for.body455.preheader ], [ %add159.2, %for.body116.preheader ], !dbg !58
  %add490.1.pre-phi = phi i32 [ %.pre1778, %for.body455.preheader ], [ %add159.1, %for.body116.preheader ], !dbg !58
  %k.sroa.48.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.48.112.copyload, %for.body116.preheader ]
  %k.sroa.44.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.44.112.copyload, %for.body116.preheader ]
  %k.sroa.42.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.42.96.copyload, %for.body116.preheader ]
  %k.sroa.38.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.38.96.copyload, %for.body116.preheader ]
  %k.sroa.36.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.36.80.copyload, %for.body116.preheader ]
  %k.sroa.32.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.32.80.copyload, %for.body116.preheader ]
  %k.sroa.30.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.30.64.copyload, %for.body116.preheader ]
  %k.sroa.26.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.26.64.copyload, %for.body116.preheader ]
  %k.sroa.24.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.24.48.copyload, %for.body116.preheader ]
  %k.sroa.20.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.20.48.copyload, %for.body116.preheader ]
  %k.sroa.18.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.18.32.copyload, %for.body116.preheader ]
  %k.sroa.14.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.14.32.copyload, %for.body116.preheader ]
  %k.sroa.12.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.12.16.copyload, %for.body116.preheader ]
  %k.sroa.8.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.8.16.copyload, %for.body116.preheader ]
  %k.sroa.6.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.6.0.copyload, %for.body116.preheader ]
  %k.sroa.0.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %k.sroa.0.0.copyload, %for.body116.preheader ]
  %v.sroa.48.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.48.112.copyload, %for.body116.preheader ]
  %v.sroa.44.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.44.112.copyload, %for.body116.preheader ]
  %v.sroa.42.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.42.96.copyload, %for.body116.preheader ]
  %v.sroa.38.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.38.96.copyload, %for.body116.preheader ]
  %v.sroa.36.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.36.80.copyload, %for.body116.preheader ]
  %v.sroa.32.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.32.80.copyload, %for.body116.preheader ]
  %v.sroa.30.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.30.64.copyload, %for.body116.preheader ]
  %v.sroa.26.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.26.64.copyload, %for.body116.preheader ]
  %v.sroa.24.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.24.48.copyload, %for.body116.preheader ]
  %v.sroa.20.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.20.48.copyload, %for.body116.preheader ]
  %v.sroa.18.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.18.32.copyload, %for.body116.preheader ]
  %v.sroa.14.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.14.32.copyload, %for.body116.preheader ]
  %v.sroa.12.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.12.16.copyload, %for.body116.preheader ]
  %v.sroa.8.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.8.16.copyload, %for.body116.preheader ]
  %v.sroa.6.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.6.0.copyload, %for.body116.preheader ]
  %v.sroa.0.1 = phi <4 x half> [ undef, %for.body455.preheader ], [ %v.sroa.0.0.copyload, %for.body116.preheader ]
  %output_reg.sroa.100.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.100.62.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.86.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.86.54.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.72.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.72.46.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.58.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.58.38.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.44.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.44.30.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.30.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.30.22.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.16.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.16.14.insert.insert, %for.body116.preheader ], !dbg !173
  %output_reg.sroa.0.0 = phi i64 [ 0, %for.body455.preheader ], [ %output_reg.sroa.0.6.insert.insert, %for.body116.preheader ], !dbg !173
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !174
  fence syncscope("warp") acquire, !dbg !175
  %xor493 = xor i32 %shr158, %and184, !dbg !176
  %mul494 = shl nuw nsw i32 %xor493, 3, !dbg !177
  %add495 = add nuw nsw i32 %mul494, %mul178, !dbg !178
  %add500 = or disjoint i32 %add495, %mul499, !dbg !179
  %add.ptr502 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500, !dbg !180
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr502, align 8, !dbg !181
  %xor493.1 = xor i32 %add490.1.pre-phi, %and184, !dbg !176
  %mul494.1 = shl nuw nsw i32 %xor493.1, 3, !dbg !177
  %add495.1 = add nuw nsw i32 %mul494.1, %mul178, !dbg !178
  %add500.1 = or disjoint i32 %add495.1, %mul499, !dbg !179
  %add.ptr502.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.1, !dbg !180
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr502.1, align 8, !dbg !181
  %xor493.2 = xor i32 %add490.2.pre-phi, %and184, !dbg !176
  %mul494.2 = shl nuw nsw i32 %xor493.2, 3, !dbg !177
  %add495.2 = add nuw nsw i32 %mul494.2, %mul178, !dbg !178
  %add500.2 = or disjoint i32 %add495.2, %mul499, !dbg !179
  %add.ptr502.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.2, !dbg !180
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr502.2, align 8, !dbg !181
  %xor493.3 = xor i32 %add490.3.pre-phi, %and184, !dbg !176
  %mul494.3 = shl nuw nsw i32 %xor493.3, 3, !dbg !177
  %add495.3 = add nuw nsw i32 %mul494.3, %mul178, !dbg !178
  %add500.3 = or disjoint i32 %add495.3, %mul499, !dbg !179
  %add.ptr502.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.3, !dbg !180
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr502.3, align 8, !dbg !181
  %xor493.4 = xor i32 %add490.4.pre-phi, %and184, !dbg !176
  %mul494.4 = shl nuw nsw i32 %xor493.4, 3, !dbg !177
  %add495.4 = add nuw nsw i32 %mul494.4, %mul178, !dbg !178
  %add500.4 = or disjoint i32 %add495.4, %mul499, !dbg !179
  %add.ptr502.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.4, !dbg !180
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr502.4, align 8, !dbg !181
  %xor493.5 = xor i32 %add490.5.pre-phi, %and184, !dbg !176
  %mul494.5 = shl nuw nsw i32 %xor493.5, 3, !dbg !177
  %add495.5 = add nuw nsw i32 %mul494.5, %mul178, !dbg !178
  %add500.5 = or disjoint i32 %add495.5, %mul499, !dbg !179
  %add.ptr502.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.5, !dbg !180
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr502.5, align 8, !dbg !181
  %xor493.6 = xor i32 %add490.6.pre-phi, %and184, !dbg !176
  %mul494.6 = shl nuw nsw i32 %xor493.6, 3, !dbg !177
  %add495.6 = add nuw nsw i32 %mul494.6, %mul178, !dbg !178
  %add500.6 = or disjoint i32 %add495.6, %mul499, !dbg !179
  %add.ptr502.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.6, !dbg !180
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr502.6, align 8, !dbg !181
  %xor493.7 = xor i32 %add490.7.pre-phi, %and184, !dbg !176
  %mul494.7 = shl nuw nsw i32 %xor493.7, 3, !dbg !177
  %add495.7 = add nuw nsw i32 %mul494.7, %mul178, !dbg !178
  %add500.7 = or disjoint i32 %add495.7, %mul499, !dbg !179
  %add.ptr502.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.7, !dbg !180
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr502.7, align 8, !dbg !181
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %add.ptr566 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 %add.ptr566.idx.pre-phi, !dbg !60
  %condval_11.0 = shl nuw nsw i32 %.780, 11, !dbg !187
  %add576 = add i32 %mul570, %condval_11.0, !dbg !188
  %idx.ext577 = sext i32 %add576 to i64, !dbg !189
  %add.ptr578 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep774.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 1024, !dbg !60
  %add.ptr566.1 = getelementptr inbounds i8, ptr addrspace(3) %gep774.1, i32 %add.ptr566.idx.1.pre-phi, !dbg !60
  %add571.1 = add nsw i32 %mul570, 512, !dbg !193
  %add576.1 = add i32 %add571.1, %condval_11.0, !dbg !188
  %idx.ext577.1 = sext i32 %add576.1 to i64, !dbg !189
  %add.ptr578.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep774.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 2048, !dbg !60
  %add.ptr566.2 = getelementptr inbounds i8, ptr addrspace(3) %gep774.2, i32 %add.ptr566.idx.2.pre-phi, !dbg !60
  %add571.2 = add nsw i32 %mul570, 1024, !dbg !193
  %add576.2 = add i32 %add571.2, %condval_11.0, !dbg !188
  %idx.ext577.2 = sext i32 %add576.2 to i64, !dbg !189
  %add.ptr578.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577.2, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566.2, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep774.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 3072, !dbg !60
  %add.ptr566.3 = getelementptr inbounds i8, ptr addrspace(3) %gep774.3, i32 %add.ptr566.idx.3.pre-phi, !dbg !60
  %add571.3 = add nsw i32 %mul570, 1536, !dbg !193
  %add576.3 = add i32 %add571.3, %condval_11.0, !dbg !188
  %idx.ext577.3 = sext i32 %add576.3 to i64, !dbg !189
  %add.ptr578.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577.3, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566.3, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  fence syncscope("warp") release, !dbg !194
  tail call void @llvm.mxc.barrier.warp(), !dbg !197
  fence syncscope("warp") acquire, !dbg !198
  %cmp16.not.1 = icmp ult i32 %3, 65536, !dbg !199
  br i1 %cmp16.not.1, label %if.end587, label %if.end48.preheader.1, !dbg !200

if.end48.preheader.1:                             ; preds = %if.end475
  %.780.1 = tail call i32 @llvm.smin.i32(i32 %4, i32 1024)
  %cmp109.1 = icmp slt i32 %mul108, %.780.1
  %or.cond703.1 = select i1 %or.cond, i1 %cmp109.1, i1 false, !dbg !57
  br i1 %or.cond703.1, label %if.end139.1, label %for.body455.preheader.1, !dbg !57

for.body455.preheader.1:                          ; preds = %if.end48.preheader.1
  %.pre = add nuw nsw i32 %shr158, 2, !dbg !58
  %.pre1761 = add nuw nsw i32 %shr158, 4, !dbg !58
  %.pre1762 = add nuw nsw i32 %shr158, 6, !dbg !58
  %.pre1763 = add nuw nsw i32 %shr158, 8, !dbg !58
  %.pre1764 = add nuw nsw i32 %shr158, 10, !dbg !58
  %.pre1765 = add nuw nsw i32 %shr158, 12, !dbg !58
  %.pre1766 = add nuw nsw i32 %shr158, 14, !dbg !58
  %.pre1767 = xor i32 %shr181, %and184, !dbg !59
  %.pre1768 = shl nuw nsw i32 %.pre1767, 4, !dbg !60
  %.pre1769 = add nuw nsw i32 %shr181, 4, !dbg !61
  %.pre1770 = xor i32 %.pre1769, %and184, !dbg !59
  %.pre1771 = shl nuw nsw i32 %.pre1770, 4, !dbg !60
  %.pre1772 = add nuw nsw i32 %shr181, 8, !dbg !61
  %.pre1773 = xor i32 %.pre1772, %and184, !dbg !59
  %.pre1774 = shl nuw nsw i32 %.pre1773, 4, !dbg !60
  %.pre1775 = add nuw nsw i32 %shr181, 12, !dbg !61
  %.pre1776 = xor i32 %.pre1775, %and184, !dbg !59
  %.pre1777 = shl nuw nsw i32 %.pre1776, 4, !dbg !60
  br label %if.end475.1, !dbg !62

if.end139.1:                                      ; preds = %if.end48.preheader.1
  %.idx785.1823 = shl nuw nsw i64 %shr63, 22, !dbg !68
  %141 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx785.1823, !dbg !68
  %142 = getelementptr i8, ptr addrspace(4) %141, i64 -512, !dbg !68
  %143 = tail call i64 @llvm.umin.i64(i64 %and57, i64 1024)
  %gep.idx.1824 = shl nuw nsw i64 %143, 12, !dbg !68
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %142, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.7.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.44.60.insert.ext1757 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.shift1758 = shl nuw i64 %q_stage.sroa.44.60.insert.ext1757, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.44.56.insert.ext1753 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64, !dbg !70
  %q_stage.sroa.44.60.insert.insert1760 = or disjoint i64 %q_stage.sroa.44.60.insert.shift1758, %q_stage.sroa.44.56.insert.ext1753, !dbg !70
  %144 = getelementptr i8, ptr addrspace(4) %141, i64 -1024, !dbg !68
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %144, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.6.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.38.52.insert.ext1747 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.shift1748 = shl nuw i64 %q_stage.sroa.38.52.insert.ext1747, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.38.48.insert.ext1743 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64, !dbg !70
  %q_stage.sroa.38.52.insert.insert1750 = or disjoint i64 %q_stage.sroa.38.52.insert.shift1748, %q_stage.sroa.38.48.insert.ext1743, !dbg !70
  %145 = getelementptr i8, ptr addrspace(4) %141, i64 -1536, !dbg !68
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %145, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.5.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.32.44.insert.ext1737 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.shift1738 = shl nuw i64 %q_stage.sroa.32.44.insert.ext1737, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.32.40.insert.ext1733 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64, !dbg !70
  %q_stage.sroa.32.44.insert.insert1740 = or disjoint i64 %q_stage.sroa.32.44.insert.shift1738, %q_stage.sroa.32.40.insert.ext1733, !dbg !70
  %146 = getelementptr i8, ptr addrspace(4) %141, i64 -2048, !dbg !68
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %146, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.4.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.26.36.insert.ext1727 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.shift1728 = shl nuw i64 %q_stage.sroa.26.36.insert.ext1727, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.26.32.insert.ext1723 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64, !dbg !70
  %q_stage.sroa.26.36.insert.insert1730 = or disjoint i64 %q_stage.sroa.26.36.insert.shift1728, %q_stage.sroa.26.32.insert.ext1723, !dbg !70
  %147 = getelementptr i8, ptr addrspace(4) %141, i64 -2560, !dbg !68
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %147, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.3.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.20.28.insert.ext1717 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.shift1718 = shl nuw i64 %q_stage.sroa.20.28.insert.ext1717, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.20.24.insert.ext1713 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64, !dbg !70
  %q_stage.sroa.20.28.insert.insert1720 = or disjoint i64 %q_stage.sroa.20.28.insert.shift1718, %q_stage.sroa.20.24.insert.ext1713, !dbg !70
  %148 = getelementptr i8, ptr addrspace(4) %141, i64 -3072, !dbg !68
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %148, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.2.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.14.20.insert.ext1707 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.shift1708 = shl nuw i64 %q_stage.sroa.14.20.insert.ext1707, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.14.16.insert.ext1703 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64, !dbg !70
  %q_stage.sroa.14.20.insert.insert1710 = or disjoint i64 %q_stage.sroa.14.20.insert.shift1708, %q_stage.sroa.14.16.insert.ext1703, !dbg !70
  %149 = getelementptr i8, ptr addrspace(4) %141, i64 -3584, !dbg !68
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %149, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1.1, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.8.12.insert.ext1697 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.shift1698 = shl nuw i64 %q_stage.sroa.8.12.insert.ext1697, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.8.8.insert.ext1693 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64, !dbg !70
  %q_stage.sroa.8.12.insert.insert1700 = or disjoint i64 %q_stage.sroa.8.12.insert.shift1698, %q_stage.sroa.8.8.insert.ext1693, !dbg !70
  %150 = getelementptr i8, ptr addrspace(4) %141, i64 -4096, !dbg !68
  %gep.1825 = getelementptr i8, ptr addrspace(4) %150, i64 %gep.idx.1824, !dbg !68
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1826 = getelementptr inbounds i8, ptr addrspace(4) %gep.1825, i64 4, !dbg !69
  %condval_1.sroa.5.0.copyload.1827 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1826, align 4, !dbg !69, !tbaa !30
  %q_stage.sroa.0.4.insert.ext1687 = zext i32 %condval_1.sroa.5.0.copyload.1827 to i64, !dbg !70
  %q_stage.sroa.0.4.insert.shift1688 = shl nuw i64 %q_stage.sroa.0.4.insert.ext1687, 32, !dbg !70
  %condval_1.sroa.0.0.copyload.1828 = load i32, ptr addrspace(4) %gep.1825, align 8, !dbg !69, !tbaa !30
  %q_stage.sroa.0.0.insert.ext1683 = zext i32 %condval_1.sroa.0.0.copyload.1828 to i64, !dbg !70
  %q_stage.sroa.0.4.insert.insert1690 = or disjoint i64 %q_stage.sroa.0.4.insert.shift1688, %q_stage.sroa.0.0.insert.ext1683, !dbg !70
  %xor.1833 = xor i32 %shr158, %shr155, !dbg !74
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add152, !dbg !75
  %gep747.idx.1834 = shl nuw nsw i32 %xor.1833, 4, !dbg !75
  %gep747.1835 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 %gep747.idx.1834, !dbg !75
  store i64 %q_stage.sroa.0.4.insert.insert1690, ptr addrspace(3) %gep747.1835, align 8, !dbg !76
  %add159.1.1 = add nuw nsw i32 %shr158, 2, !dbg !77
  %xor.1.1 = xor i32 %add159.1.1, %shr155, !dbg !74
  %152 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 512, !dbg !75
  %gep747.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4, !dbg !75
  %gep747.1.1 = getelementptr inbounds i8, ptr addrspace(3) %152, i32 %gep747.idx.1.1, !dbg !75
  store i64 %q_stage.sroa.8.12.insert.insert1700, ptr addrspace(3) %gep747.1.1, align 8, !dbg !76
  %add159.2.1 = add nuw nsw i32 %shr158, 4, !dbg !77
  %xor.2.1 = xor i32 %add159.2.1, %shr155, !dbg !74
  %153 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 1024, !dbg !75
  %gep747.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4, !dbg !75
  %gep747.2.1 = getelementptr inbounds i8, ptr addrspace(3) %153, i32 %gep747.idx.2.1, !dbg !75
  store i64 %q_stage.sroa.14.20.insert.insert1710, ptr addrspace(3) %gep747.2.1, align 8, !dbg !76
  %add159.3.1 = add nuw nsw i32 %shr158, 6, !dbg !77
  %xor.3.1 = xor i32 %add159.3.1, %shr155, !dbg !74
  %154 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 1536, !dbg !75
  %gep747.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4, !dbg !75
  %gep747.3.1 = getelementptr inbounds i8, ptr addrspace(3) %154, i32 %gep747.idx.3.1, !dbg !75
  store i64 %q_stage.sroa.20.28.insert.insert1720, ptr addrspace(3) %gep747.3.1, align 8, !dbg !76
  %add159.4.1 = add nuw nsw i32 %shr158, 8, !dbg !77
  %xor.4.1 = xor i32 %add159.4.1, %shr155, !dbg !74
  %155 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 2048, !dbg !75
  %gep747.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4, !dbg !75
  %gep747.4.1 = getelementptr inbounds i8, ptr addrspace(3) %155, i32 %gep747.idx.4.1, !dbg !75
  store i64 %q_stage.sroa.26.36.insert.insert1730, ptr addrspace(3) %gep747.4.1, align 8, !dbg !76
  %add159.5.1 = add nuw nsw i32 %shr158, 10, !dbg !77
  %xor.5.1 = xor i32 %add159.5.1, %shr155, !dbg !74
  %156 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 2560, !dbg !75
  %gep747.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4, !dbg !75
  %gep747.5.1 = getelementptr inbounds i8, ptr addrspace(3) %156, i32 %gep747.idx.5.1, !dbg !75
  store i64 %q_stage.sroa.32.44.insert.insert1740, ptr addrspace(3) %gep747.5.1, align 8, !dbg !76
  %add159.6.1 = add nuw nsw i32 %shr158, 12, !dbg !77
  %xor.6.1 = xor i32 %add159.6.1, %shr155, !dbg !74
  %157 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 3072, !dbg !75
  %gep747.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4, !dbg !75
  %gep747.6.1 = getelementptr inbounds i8, ptr addrspace(3) %157, i32 %gep747.idx.6.1, !dbg !75
  store i64 %q_stage.sroa.38.52.insert.insert1750, ptr addrspace(3) %gep747.6.1, align 8, !dbg !76
  %add159.7.1 = add nuw nsw i32 %shr158, 14, !dbg !77
  %xor.7.1 = xor i32 %add159.7.1, %shr155, !dbg !74
  %158 = getelementptr inbounds i8, ptr addrspace(3) %151, i32 3584, !dbg !75
  %gep747.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4, !dbg !75
  %gep747.7.1 = getelementptr inbounds i8, ptr addrspace(3) %158, i32 %gep747.idx.7.1, !dbg !75
  store i64 %q_stage.sroa.44.60.insert.insert1760, ptr addrspace(3) %gep747.7.1, align 8, !dbg !76
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %xor185.1836 = xor i32 %shr181, %and184, !dbg !83
  %.idx.1837 = shl nuw nsw i32 %xor185.1836, 4, !dbg !84
  %gep750.1838 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx.1837, !dbg !84
  %q.sroa.0.0.copyload1633 = load <4 x half>, ptr addrspace(3) %gep750.1838, align 16, !dbg !85
  %q.sroa.6.0.gep750.1838.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1838, i32 8, !dbg !85
  %q.sroa.6.0.copyload1634 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep750.1838.sroa_idx, align 8, !dbg !85
  %add182.1.1 = add nuw nsw i32 %shr181, 4, !dbg !86
  %xor185.1.1 = xor i32 %add182.1.1, %and184, !dbg !83
  %.idx.1.1 = shl nuw nsw i32 %xor185.1.1, 4, !dbg !84
  %gep750.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx.1.1, !dbg !84
  %q.sroa.8.16.copyload1637 = load <4 x half>, ptr addrspace(3) %gep750.1.1, align 16, !dbg !85
  %q.sroa.12.16.gep750.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1.1, i32 8, !dbg !85
  %q.sroa.12.16.copyload1638 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep750.1.1.sroa_idx, align 8, !dbg !85
  %add182.2.1 = add nuw nsw i32 %shr181, 8, !dbg !86
  %xor185.2.1 = xor i32 %add182.2.1, %and184, !dbg !83
  %.idx.2.1 = shl nuw nsw i32 %xor185.2.1, 4, !dbg !84
  %gep750.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx.2.1, !dbg !84
  %q.sroa.14.32.copyload1641 = load <4 x half>, ptr addrspace(3) %gep750.2.1, align 16, !dbg !85
  %q.sroa.18.32.gep750.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.2.1, i32 8, !dbg !85
  %q.sroa.18.32.copyload1642 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep750.2.1.sroa_idx, align 8, !dbg !85
  %add182.3.1 = add nuw nsw i32 %shr181, 12, !dbg !86
  %xor185.3.1 = xor i32 %add182.3.1, %and184, !dbg !83
  %.idx.3.1 = shl nuw nsw i32 %xor185.3.1, 4, !dbg !84
  %gep750.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep776, i32 %.idx.3.1, !dbg !84
  %q.sroa.20.48.copyload1645 = load <4 x half>, ptr addrspace(3) %gep750.3.1, align 16, !dbg !85
  %q.sroa.24.48.gep750.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.3.1, i32 8, !dbg !85
  %q.sroa.24.48.copyload1646 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep750.3.1.sroa_idx, align 8, !dbg !85
  %cmp231.not.not.1841 = icmp slt i32 %add224, %.780.1, !dbg !87
  %spec.select.1842 = select i1 %cmp231.not.not.1841, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.0.vec.insert1428 = insertelement <4 x float> poison, float %spec.select.1842, i64 0, !dbg !89
  %add228.1.1 = or disjoint i32 %add224, 1, !dbg !90
  %cmp231.not.not.1.1 = icmp slt i32 %add228.1.1, %.780.1, !dbg !87
  %spec.select.1.1 = select i1 %cmp231.not.not.1.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.4.vec.insert1453 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1428, float %spec.select.1.1, i64 1, !dbg !89
  %add228.2.1 = or disjoint i32 %add224, 2, !dbg !90
  %cmp231.not.not.2.1 = icmp slt i32 %add228.2.1, %.780.1, !dbg !87
  %spec.select.2.1 = select i1 %cmp231.not.not.2.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.8.vec.insert1478 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1453, float %spec.select.2.1, i64 2, !dbg !89
  %add228.3.1 = or disjoint i32 %add224, 3, !dbg !90
  %cmp231.not.not.3.1 = icmp slt i32 %add228.3.1, %.780.1, !dbg !87
  %spec.select.3.1 = select i1 %cmp231.not.not.3.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.12.vec.insert1503 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1478, float %spec.select.3.1, i64 3, !dbg !89
  %add230.4.1 = add nuw nsw i32 %add224, 16, !dbg !91
  %cmp231.not.not.4.1 = icmp slt i32 %add230.4.1, %.780.1, !dbg !87
  %spec.select.4.1 = select i1 %cmp231.not.not.4.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.16.vec.insert1544 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0, !dbg !89
  %add230.5.1 = add nuw nsw i32 %add224, 17, !dbg !91
  %cmp231.not.not.5.1 = icmp slt i32 %add230.5.1, %.780.1, !dbg !87
  %spec.select.5.1 = select i1 %cmp231.not.not.5.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.20.vec.insert1569 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1544, float %spec.select.5.1, i64 1, !dbg !89
  %add230.6.1 = add nuw nsw i32 %add224, 18, !dbg !91
  %cmp231.not.not.6.1 = icmp slt i32 %add230.6.1, %.780.1, !dbg !87
  %spec.select.6.1 = select i1 %cmp231.not.not.6.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.24.vec.insert1594 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1569, float %spec.select.6.1, i64 2, !dbg !89
  %add230.7.1 = add nuw nsw i32 %add224, 19, !dbg !91
  %cmp231.not.not.7.1 = icmp slt i32 %add230.7.1, %.780.1, !dbg !87
  %spec.select.7.1 = select i1 %cmp231.not.not.7.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.90.28.vec.insert1619 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1594, float %spec.select.7.1, i64 3, !dbg !89
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.1, <4 x half> %q.sroa.0.0.copyload1633, <4 x float> %scores.sroa.0.12.vec.insert1503), !dbg !92
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.1, <4 x half> %q.sroa.0.0.copyload1633, <4 x float> %scores.sroa.90.28.vec.insert1619), !dbg !92
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.1, <4 x half> %q.sroa.6.0.copyload1634, <4 x float> %159), !dbg !92
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.1, <4 x half> %q.sroa.6.0.copyload1634, <4 x float> %160), !dbg !92
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.1, <4 x half> %q.sroa.8.16.copyload1637, <4 x float> %161), !dbg !92
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.1, <4 x half> %q.sroa.8.16.copyload1637, <4 x float> %162), !dbg !92
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.1, <4 x half> %q.sroa.12.16.copyload1638, <4 x float> %163), !dbg !92
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.1, <4 x half> %q.sroa.12.16.copyload1638, <4 x float> %164), !dbg !92
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.1, <4 x half> %q.sroa.14.32.copyload1641, <4 x float> %165), !dbg !92
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.1, <4 x half> %q.sroa.14.32.copyload1641, <4 x float> %166), !dbg !92
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.1, <4 x half> %q.sroa.18.32.copyload1642, <4 x float> %167), !dbg !92
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.1, <4 x half> %q.sroa.18.32.copyload1642, <4 x float> %168), !dbg !92
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.1, <4 x half> %q.sroa.20.48.copyload1645, <4 x float> %169), !dbg !92
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.1, <4 x half> %q.sroa.20.48.copyload1645, <4 x float> %170), !dbg !92
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.1, <4 x half> %q.sroa.24.48.copyload1646, <4 x float> %171), !dbg !92
  %174 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.1, <4 x half> %q.sroa.24.48.copyload1646, <4 x float> %172), !dbg !92
  %scores.sroa.0.0.vec.extract1430 = extractelement <4 x float> %173, i64 0, !dbg !96
  %mul316.1852 = fmul contract float %scores.sroa.0.0.vec.extract1430, 0x3FC2776C60000000, !dbg !97
  %175 = tail call contract noundef float @llvm.minnum.f32(float %mul316.1852, float 1.500000e+01), !dbg !98
  %cmp.i.i.1853 = fcmp contract olt float %175, -1.260000e+02, !dbg !102
  %cond.i.i726.1854 = select contract i1 %cmp.i.i.1853, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.1855 = fadd contract float %175, %cond.i.i726.1854, !dbg !102
  %176 = tail call contract float @llvm.exp2.f32(float %add.i.i727.1855), !dbg !102
  %cond2.i.i.1856 = select contract i1 %cmp.i.i.1853, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.1857 = fmul contract float %cond2.i.i.1856, %176, !dbg !102
  %scores.sroa.0.4.vec.extract1455 = extractelement <4 x float> %173, i64 1, !dbg !96
  %mul316.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1455, 0x3FC2776C60000000, !dbg !97
  %177 = tail call contract noundef float @llvm.minnum.f32(float %mul316.1.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.1.1 = fcmp contract olt float %177, -1.260000e+02, !dbg !102
  %cond.i.i726.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.1.1 = fadd contract float %177, %cond.i.i726.1.1, !dbg !102
  %178 = tail call contract float @llvm.exp2.f32(float %add.i.i727.1.1), !dbg !102
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %178, !dbg !102
  %scores.sroa.0.8.vec.extract1480 = extractelement <4 x float> %173, i64 2, !dbg !96
  %mul316.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1480, 0x3FC2776C60000000, !dbg !97
  %179 = tail call contract noundef float @llvm.minnum.f32(float %mul316.2.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.2.1 = fcmp contract olt float %179, -1.260000e+02, !dbg !102
  %cond.i.i726.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.2.1 = fadd contract float %179, %cond.i.i726.2.1, !dbg !102
  %180 = tail call contract float @llvm.exp2.f32(float %add.i.i727.2.1), !dbg !102
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %180, !dbg !102
  %scores.sroa.0.12.vec.extract1505 = extractelement <4 x float> %173, i64 3, !dbg !96
  %mul316.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1505, 0x3FC2776C60000000, !dbg !97
  %181 = tail call contract noundef float @llvm.minnum.f32(float %mul316.3.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.3.1 = fcmp contract olt float %181, -1.260000e+02, !dbg !102
  %cond.i.i726.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.3.1 = fadd contract float %181, %cond.i.i726.3.1, !dbg !102
  %182 = tail call contract float @llvm.exp2.f32(float %add.i.i727.3.1), !dbg !102
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %182, !dbg !102
  %scores.sroa.90.16.vec.extract1546 = extractelement <4 x float> %174, i64 0, !dbg !96
  %mul316.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1546, 0x3FC2776C60000000, !dbg !97
  %183 = tail call contract noundef float @llvm.minnum.f32(float %mul316.4.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.4.1 = fcmp contract olt float %183, -1.260000e+02, !dbg !102
  %cond.i.i726.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.4.1 = fadd contract float %183, %cond.i.i726.4.1, !dbg !102
  %184 = tail call contract float @llvm.exp2.f32(float %add.i.i727.4.1), !dbg !102
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %184, !dbg !102
  %scores.sroa.90.20.vec.extract1571 = extractelement <4 x float> %174, i64 1, !dbg !96
  %mul316.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1571, 0x3FC2776C60000000, !dbg !97
  %185 = tail call contract noundef float @llvm.minnum.f32(float %mul316.5.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.5.1 = fcmp contract olt float %185, -1.260000e+02, !dbg !102
  %cond.i.i726.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.5.1 = fadd contract float %185, %cond.i.i726.5.1, !dbg !102
  %186 = tail call contract float @llvm.exp2.f32(float %add.i.i727.5.1), !dbg !102
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %186, !dbg !102
  %scores.sroa.90.24.vec.extract1596 = extractelement <4 x float> %174, i64 2, !dbg !96
  %mul316.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1596, 0x3FC2776C60000000, !dbg !97
  %187 = tail call contract noundef float @llvm.minnum.f32(float %mul316.6.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.6.1 = fcmp contract olt float %187, -1.260000e+02, !dbg !102
  %cond.i.i726.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.6.1 = fadd contract float %187, %cond.i.i726.6.1, !dbg !102
  %188 = tail call contract float @llvm.exp2.f32(float %add.i.i727.6.1), !dbg !102
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %188, !dbg !102
  %scores.sroa.90.28.vec.extract1621 = extractelement <4 x float> %174, i64 3, !dbg !96
  %mul316.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1621, 0x3FC2776C60000000, !dbg !97
  %189 = tail call contract noundef float @llvm.minnum.f32(float %mul316.7.1, float 1.500000e+01), !dbg !98
  %cmp.i.i.7.1 = fcmp contract olt float %189, -1.260000e+02, !dbg !102
  %cond.i.i726.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00, !dbg !102
  %add.i.i727.7.1 = fadd contract float %189, %cond.i.i726.7.1, !dbg !102
  %190 = tail call contract float @llvm.exp2.f32(float %add.i.i727.7.1), !dbg !102
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !102
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %190, !dbg !102
  %add336.1858 = fadd contract float %mul.i.i.1857, 0.000000e+00, !dbg !105
  %add336.1.1 = fadd contract float %add336.1858, %mul.i.i.4.1, !dbg !105
  %add336.2.1 = fadd contract float %add336.1.1, %mul.i.i.1.1, !dbg !105
  %add336.3.1 = fadd contract float %add336.2.1, %mul.i.i.5.1, !dbg !105
  %add336.4.1 = fadd contract float %add336.3.1, %mul.i.i.2.1, !dbg !105
  %add336.5.1 = fadd contract float %add336.4.1, %mul.i.i.6.1, !dbg !105
  %add336.6.1 = fadd contract float %add336.5.1, %mul.i.i.3.1, !dbg !105
  %add336.7.1 = fadd contract float %add336.6.1, %mul.i.i.7.1, !dbg !105
  %191 = bitcast float %add336.7.1 to i32, !dbg !106
  %192 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !117
  %193 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %192) #11, !dbg !122
  %xor.i.i.1 = xor i32 %193, 32, !dbg !123
  %194 = and i32 %193, -64, !dbg !124
  %and.i.i.1 = add nsw i32 %194, 64, !dbg !124
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1, !dbg !125
  %cond.i.i728.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %193, !dbg !126
  %shl.i.i.1 = shl i32 %cond.i.i728.1, 2, !dbg !127
  %195 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %191), !dbg !128
  %196 = bitcast i32 %195 to float, !dbg !129
  %add.i.1 = fadd contract float %add336.7.1, %196, !dbg !130
  %197 = bitcast float %add.i.1 to i32, !dbg !133
  %198 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !140
  %199 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %198) #11, !dbg !143
  %xor.i.i729.1 = xor i32 %199, 16, !dbg !144
  %200 = and i32 %199, -64, !dbg !145
  %and.i.i730.1 = add nsw i32 %200, 64, !dbg !145
  %cmp.not.i.i731.1 = icmp slt i32 %xor.i.i729.1, %and.i.i730.1, !dbg !146
  %cond.i.i732.1 = select i1 %cmp.not.i.i731.1, i32 %xor.i.i729.1, i32 %199, !dbg !147
  %shl.i.i733.1 = shl i32 %cond.i.i732.1, 2, !dbg !148
  %201 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i733.1, i32 %197), !dbg !149
  %202 = bitcast i32 %201 to float, !dbg !150
  %add.i.i.1 = fadd contract float %add.i.1, %202, !dbg !151
  %cmp345.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00, !dbg !153
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1, !dbg !154
  %condval_8.0.1 = select i1 %cmp345.1, float %div.1, float 0.000000e+00, !dbg !154
  %mul358.1859 = fmul contract float %condval_8.0.1, %mul.i.i.1857, !dbg !155
  %mul358.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1, !dbg !155
  %mul358.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1, !dbg !155
  %mul358.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1, !dbg !155
  %mul358.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1, !dbg !155
  %mul358.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1, !dbg !155
  %mul358.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1, !dbg !155
  %mul358.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1, !dbg !155
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.1859), !dbg !156
  %204 = insertelement <4 x i16> poison, i16 %203, i64 0, !dbg !165
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.1.1), !dbg !156
  %206 = insertelement <4 x i16> %204, i16 %205, i64 1, !dbg !165
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.2.1), !dbg !156
  %208 = insertelement <4 x i16> %206, i16 %207, i64 2, !dbg !165
  %209 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.3.1), !dbg !156
  %210 = insertelement <4 x i16> %208, i16 %209, i64 3, !dbg !165
  %prob.sroa.0.6.vec.insert1356 = bitcast <4 x i16> %210 to <4 x half>, !dbg !165
  %211 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.4.1), !dbg !156
  %212 = insertelement <4 x i16> poison, i16 %211, i64 0, !dbg !165
  %213 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.5.1), !dbg !156
  %214 = insertelement <4 x i16> %212, i16 %213, i64 1, !dbg !165
  %215 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.6.1), !dbg !156
  %216 = insertelement <4 x i16> %214, i16 %215, i64 2, !dbg !165
  %217 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul358.7.1), !dbg !156
  %218 = insertelement <4 x i16> %216, i16 %217, i64 3, !dbg !165
  %prob.sroa.12.14.vec.insert1366 = bitcast <4 x i16> %218 to <4 x half>, !dbg !165
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.1, <4 x half> %prob.sroa.0.6.vec.insert1356, <4 x float> zeroinitializer), !dbg !166
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %219), !dbg !166
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %220), !dbg !166
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %221), !dbg !166
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %222), !dbg !166
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %223), !dbg !166
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %224), !dbg !166
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %225), !dbg !166
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.1, <4 x half> %prob.sroa.12.14.vec.insert1366, <4 x float> %226), !dbg !166
  %out.sroa.0.0.vec.extract907 = extractelement <4 x float> %227, i64 0, !dbg !167
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract907), !dbg !168
  %output_reg.sroa.0.0.insert.ext1099 = zext i16 %235 to i64, !dbg !172
  %out.sroa.0.4.vec.extract912 = extractelement <4 x float> %227, i64 1, !dbg !167
  %236 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract912), !dbg !168
  %output_reg.sroa.0.2.insert.ext1103 = zext i16 %236 to i64, !dbg !172
  %output_reg.sroa.0.2.insert.shift1104 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1103, 16, !dbg !172
  %output_reg.sroa.0.2.insert.insert1106 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1104, %output_reg.sroa.0.0.insert.ext1099, !dbg !172
  %out.sroa.0.8.vec.extract917 = extractelement <4 x float> %227, i64 2, !dbg !167
  %237 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract917), !dbg !168
  %output_reg.sroa.0.4.insert.ext1114 = zext i16 %237 to i64, !dbg !172
  %output_reg.sroa.0.4.insert.shift1115 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1114, 32, !dbg !172
  %output_reg.sroa.0.4.insert.insert1117 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1106, %output_reg.sroa.0.4.insert.shift1115, !dbg !172
  %out.sroa.0.12.vec.extract922 = extractelement <4 x float> %227, i64 3, !dbg !167
  %238 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract922), !dbg !168
  %output_reg.sroa.0.6.insert.ext1119 = zext i16 %238 to i64, !dbg !172
  %output_reg.sroa.0.6.insert.shift1120 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1119, 48, !dbg !172
  %output_reg.sroa.0.6.insert.insert1122 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1117, %output_reg.sroa.0.6.insert.shift1120, !dbg !172
  %out.sroa.26.16.vec.extract931 = extractelement <4 x float> %228, i64 0, !dbg !167
  %239 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract931), !dbg !168
  %output_reg.sroa.16.8.insert.ext1131 = zext i16 %239 to i64, !dbg !172
  %out.sroa.26.20.vec.extract936 = extractelement <4 x float> %228, i64 1, !dbg !167
  %240 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract936), !dbg !168
  %output_reg.sroa.16.10.insert.ext1135 = zext i16 %240 to i64, !dbg !172
  %output_reg.sroa.16.10.insert.shift1136 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1135, 16, !dbg !172
  %output_reg.sroa.16.10.insert.insert1138 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1136, %output_reg.sroa.16.8.insert.ext1131, !dbg !172
  %out.sroa.26.24.vec.extract941 = extractelement <4 x float> %228, i64 2, !dbg !167
  %241 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract941), !dbg !168
  %output_reg.sroa.16.12.insert.ext1146 = zext i16 %241 to i64, !dbg !172
  %output_reg.sroa.16.12.insert.shift1147 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1146, 32, !dbg !172
  %output_reg.sroa.16.12.insert.insert1149 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1138, %output_reg.sroa.16.12.insert.shift1147, !dbg !172
  %out.sroa.26.28.vec.extract946 = extractelement <4 x float> %228, i64 3, !dbg !167
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract946), !dbg !168
  %output_reg.sroa.16.14.insert.ext1151 = zext i16 %242 to i64, !dbg !172
  %output_reg.sroa.16.14.insert.shift1152 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1151, 48, !dbg !172
  %output_reg.sroa.16.14.insert.insert1154 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1149, %output_reg.sroa.16.14.insert.shift1152, !dbg !172
  %out.sroa.50.32.vec.extract955 = extractelement <4 x float> %229, i64 0, !dbg !167
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract955), !dbg !168
  %output_reg.sroa.30.16.insert.ext1163 = zext i16 %243 to i64, !dbg !172
  %out.sroa.50.36.vec.extract960 = extractelement <4 x float> %229, i64 1, !dbg !167
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract960), !dbg !168
  %output_reg.sroa.30.18.insert.ext1167 = zext i16 %244 to i64, !dbg !172
  %output_reg.sroa.30.18.insert.shift1168 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1167, 16, !dbg !172
  %output_reg.sroa.30.18.insert.insert1170 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1168, %output_reg.sroa.30.16.insert.ext1163, !dbg !172
  %out.sroa.50.40.vec.extract965 = extractelement <4 x float> %229, i64 2, !dbg !167
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract965), !dbg !168
  %output_reg.sroa.30.20.insert.ext1178 = zext i16 %245 to i64, !dbg !172
  %output_reg.sroa.30.20.insert.shift1179 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1178, 32, !dbg !172
  %output_reg.sroa.30.20.insert.insert1181 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1170, %output_reg.sroa.30.20.insert.shift1179, !dbg !172
  %out.sroa.50.44.vec.extract970 = extractelement <4 x float> %229, i64 3, !dbg !167
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract970), !dbg !168
  %output_reg.sroa.30.22.insert.ext1183 = zext i16 %246 to i64, !dbg !172
  %output_reg.sroa.30.22.insert.shift1184 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1183, 48, !dbg !172
  %output_reg.sroa.30.22.insert.insert1186 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1181, %output_reg.sroa.30.22.insert.shift1184, !dbg !172
  %out.sroa.74.48.vec.extract979 = extractelement <4 x float> %230, i64 0, !dbg !167
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract979), !dbg !168
  %output_reg.sroa.44.24.insert.ext1195 = zext i16 %247 to i64, !dbg !172
  %out.sroa.74.52.vec.extract984 = extractelement <4 x float> %230, i64 1, !dbg !167
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract984), !dbg !168
  %output_reg.sroa.44.26.insert.ext1199 = zext i16 %248 to i64, !dbg !172
  %output_reg.sroa.44.26.insert.shift1200 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1199, 16, !dbg !172
  %output_reg.sroa.44.26.insert.insert1202 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1200, %output_reg.sroa.44.24.insert.ext1195, !dbg !172
  %out.sroa.74.56.vec.extract989 = extractelement <4 x float> %230, i64 2, !dbg !167
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract989), !dbg !168
  %output_reg.sroa.44.28.insert.ext1210 = zext i16 %249 to i64, !dbg !172
  %output_reg.sroa.44.28.insert.shift1211 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1210, 32, !dbg !172
  %output_reg.sroa.44.28.insert.insert1213 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1202, %output_reg.sroa.44.28.insert.shift1211, !dbg !172
  %out.sroa.74.60.vec.extract994 = extractelement <4 x float> %230, i64 3, !dbg !167
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract994), !dbg !168
  %output_reg.sroa.44.30.insert.ext1215 = zext i16 %250 to i64, !dbg !172
  %output_reg.sroa.44.30.insert.shift1216 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1215, 48, !dbg !172
  %output_reg.sroa.44.30.insert.insert1218 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1213, %output_reg.sroa.44.30.insert.shift1216, !dbg !172
  %out.sroa.98.64.vec.extract1003 = extractelement <4 x float> %231, i64 0, !dbg !167
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract1003), !dbg !168
  %output_reg.sroa.58.32.insert.ext1227 = zext i16 %251 to i64, !dbg !172
  %out.sroa.98.68.vec.extract1008 = extractelement <4 x float> %231, i64 1, !dbg !167
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract1008), !dbg !168
  %output_reg.sroa.58.34.insert.ext1231 = zext i16 %252 to i64, !dbg !172
  %output_reg.sroa.58.34.insert.shift1232 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1231, 16, !dbg !172
  %output_reg.sroa.58.34.insert.insert1234 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1232, %output_reg.sroa.58.32.insert.ext1227, !dbg !172
  %out.sroa.98.72.vec.extract1013 = extractelement <4 x float> %231, i64 2, !dbg !167
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract1013), !dbg !168
  %output_reg.sroa.58.36.insert.ext1242 = zext i16 %253 to i64, !dbg !172
  %output_reg.sroa.58.36.insert.shift1243 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1242, 32, !dbg !172
  %output_reg.sroa.58.36.insert.insert1245 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1234, %output_reg.sroa.58.36.insert.shift1243, !dbg !172
  %out.sroa.98.76.vec.extract1018 = extractelement <4 x float> %231, i64 3, !dbg !167
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract1018), !dbg !168
  %output_reg.sroa.58.38.insert.ext1247 = zext i16 %254 to i64, !dbg !172
  %output_reg.sroa.58.38.insert.shift1248 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1247, 48, !dbg !172
  %output_reg.sroa.58.38.insert.insert1250 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1245, %output_reg.sroa.58.38.insert.shift1248, !dbg !172
  %out.sroa.122.80.vec.extract1027 = extractelement <4 x float> %232, i64 0, !dbg !167
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract1027), !dbg !168
  %output_reg.sroa.72.40.insert.ext1259 = zext i16 %255 to i64, !dbg !172
  %out.sroa.122.84.vec.extract1032 = extractelement <4 x float> %232, i64 1, !dbg !167
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract1032), !dbg !168
  %output_reg.sroa.72.42.insert.ext1263 = zext i16 %256 to i64, !dbg !172
  %output_reg.sroa.72.42.insert.shift1264 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1263, 16, !dbg !172
  %output_reg.sroa.72.42.insert.insert1266 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1264, %output_reg.sroa.72.40.insert.ext1259, !dbg !172
  %out.sroa.122.88.vec.extract1037 = extractelement <4 x float> %232, i64 2, !dbg !167
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract1037), !dbg !168
  %output_reg.sroa.72.44.insert.ext1274 = zext i16 %257 to i64, !dbg !172
  %output_reg.sroa.72.44.insert.shift1275 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1274, 32, !dbg !172
  %output_reg.sroa.72.44.insert.insert1277 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1266, %output_reg.sroa.72.44.insert.shift1275, !dbg !172
  %out.sroa.122.92.vec.extract1042 = extractelement <4 x float> %232, i64 3, !dbg !167
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract1042), !dbg !168
  %output_reg.sroa.72.46.insert.ext1279 = zext i16 %258 to i64, !dbg !172
  %output_reg.sroa.72.46.insert.shift1280 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1279, 48, !dbg !172
  %output_reg.sroa.72.46.insert.insert1282 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1277, %output_reg.sroa.72.46.insert.shift1280, !dbg !172
  %out.sroa.146.96.vec.extract1051 = extractelement <4 x float> %233, i64 0, !dbg !167
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract1051), !dbg !168
  %output_reg.sroa.86.48.insert.ext1291 = zext i16 %259 to i64, !dbg !172
  %out.sroa.146.100.vec.extract1056 = extractelement <4 x float> %233, i64 1, !dbg !167
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract1056), !dbg !168
  %output_reg.sroa.86.50.insert.ext1295 = zext i16 %260 to i64, !dbg !172
  %output_reg.sroa.86.50.insert.shift1296 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1295, 16, !dbg !172
  %output_reg.sroa.86.50.insert.insert1298 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1296, %output_reg.sroa.86.48.insert.ext1291, !dbg !172
  %out.sroa.146.104.vec.extract1061 = extractelement <4 x float> %233, i64 2, !dbg !167
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract1061), !dbg !168
  %output_reg.sroa.86.52.insert.ext1306 = zext i16 %261 to i64, !dbg !172
  %output_reg.sroa.86.52.insert.shift1307 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1306, 32, !dbg !172
  %output_reg.sroa.86.52.insert.insert1309 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1298, %output_reg.sroa.86.52.insert.shift1307, !dbg !172
  %out.sroa.146.108.vec.extract1066 = extractelement <4 x float> %233, i64 3, !dbg !167
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract1066), !dbg !168
  %output_reg.sroa.86.54.insert.ext1311 = zext i16 %262 to i64, !dbg !172
  %output_reg.sroa.86.54.insert.shift1312 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1311, 48, !dbg !172
  %output_reg.sroa.86.54.insert.insert1314 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1309, %output_reg.sroa.86.54.insert.shift1312, !dbg !172
  %out.sroa.170.112.vec.extract1075 = extractelement <4 x float> %234, i64 0, !dbg !167
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1075), !dbg !168
  %output_reg.sroa.100.56.insert.ext1323 = zext i16 %263 to i64, !dbg !172
  %out.sroa.170.116.vec.extract1080 = extractelement <4 x float> %234, i64 1, !dbg !167
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1080), !dbg !168
  %output_reg.sroa.100.58.insert.ext1327 = zext i16 %264 to i64, !dbg !172
  %output_reg.sroa.100.58.insert.shift1328 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1327, 16, !dbg !172
  %output_reg.sroa.100.58.insert.insert1330 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1328, %output_reg.sroa.100.56.insert.ext1323, !dbg !172
  %out.sroa.170.120.vec.extract1085 = extractelement <4 x float> %234, i64 2, !dbg !167
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1085), !dbg !168
  %output_reg.sroa.100.60.insert.ext1338 = zext i16 %265 to i64, !dbg !172
  %output_reg.sroa.100.60.insert.shift1339 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1338, 32, !dbg !172
  %output_reg.sroa.100.60.insert.insert1341 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1330, %output_reg.sroa.100.60.insert.shift1339, !dbg !172
  %out.sroa.170.124.vec.extract1090 = extractelement <4 x float> %234, i64 3, !dbg !167
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1090), !dbg !168
  %output_reg.sroa.100.62.insert.ext1343 = zext i16 %266 to i64, !dbg !172
  %output_reg.sroa.100.62.insert.shift1344 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1343, 48, !dbg !172
  %output_reg.sroa.100.62.insert.insert1346 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1341, %output_reg.sroa.100.62.insert.shift1344, !dbg !172
  br label %if.end475.1, !dbg !62

if.end475.1:                                      ; preds = %if.end139.1, %for.body455.preheader.1
  %add.ptr566.idx.3.1.pre-phi = phi i32 [ %.idx.3.1, %if.end139.1 ], [ %.pre1777, %for.body455.preheader.1 ], !dbg !60
  %add.ptr566.idx.2.1.pre-phi = phi i32 [ %.idx.2.1, %if.end139.1 ], [ %.pre1774, %for.body455.preheader.1 ], !dbg !60
  %add.ptr566.idx.1.1.pre-phi = phi i32 [ %.idx.1.1, %if.end139.1 ], [ %.pre1771, %for.body455.preheader.1 ], !dbg !60
  %add.ptr566.idx.1893.pre-phi = phi i32 [ %.idx.1837, %if.end139.1 ], [ %.pre1768, %for.body455.preheader.1 ], !dbg !60
  %add490.7.1.pre-phi = phi i32 [ %add159.7.1, %if.end139.1 ], [ %.pre1766, %for.body455.preheader.1 ], !dbg !58
  %add490.6.1.pre-phi = phi i32 [ %add159.6.1, %if.end139.1 ], [ %.pre1765, %for.body455.preheader.1 ], !dbg !58
  %add490.5.1.pre-phi = phi i32 [ %add159.5.1, %if.end139.1 ], [ %.pre1764, %for.body455.preheader.1 ], !dbg !58
  %add490.4.1.pre-phi = phi i32 [ %add159.4.1, %if.end139.1 ], [ %.pre1763, %for.body455.preheader.1 ], !dbg !58
  %add490.3.1.pre-phi = phi i32 [ %add159.3.1, %if.end139.1 ], [ %.pre1762, %for.body455.preheader.1 ], !dbg !58
  %add490.2.1.pre-phi = phi i32 [ %add159.2.1, %if.end139.1 ], [ %.pre1761, %for.body455.preheader.1 ], !dbg !58
  %add490.1.1.pre-phi = phi i32 [ %add159.1.1, %if.end139.1 ], [ %.pre, %for.body455.preheader.1 ], !dbg !58
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1346, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1314, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1282, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1250, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1218, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1186, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1154, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1122, %if.end139.1 ], [ 0, %for.body455.preheader.1 ], !dbg !173
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !174
  fence syncscope("warp") acquire, !dbg !175
  %xor493.1885 = xor i32 %shr158, %and184, !dbg !176
  %mul494.1886 = shl nuw nsw i32 %xor493.1885, 3, !dbg !177
  %add495.1887 = add nuw nsw i32 %mul494.1886, %mul178, !dbg !178
  %add500.1888 = or disjoint i32 %add495.1887, %mul499, !dbg !179
  %add.ptr502.1889 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.1888, !dbg !180
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr502.1889, align 8, !dbg !181
  %xor493.1.1 = xor i32 %add490.1.1.pre-phi, %and184, !dbg !176
  %mul494.1.1 = shl nuw nsw i32 %xor493.1.1, 3, !dbg !177
  %add495.1.1 = add nuw nsw i32 %mul494.1.1, %mul178, !dbg !178
  %add500.1.1 = or disjoint i32 %add495.1.1, %mul499, !dbg !179
  %add.ptr502.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.1.1, !dbg !180
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr502.1.1, align 8, !dbg !181
  %xor493.2.1 = xor i32 %add490.2.1.pre-phi, %and184, !dbg !176
  %mul494.2.1 = shl nuw nsw i32 %xor493.2.1, 3, !dbg !177
  %add495.2.1 = add nuw nsw i32 %mul494.2.1, %mul178, !dbg !178
  %add500.2.1 = or disjoint i32 %add495.2.1, %mul499, !dbg !179
  %add.ptr502.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.2.1, !dbg !180
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr502.2.1, align 8, !dbg !181
  %xor493.3.1 = xor i32 %add490.3.1.pre-phi, %and184, !dbg !176
  %mul494.3.1 = shl nuw nsw i32 %xor493.3.1, 3, !dbg !177
  %add495.3.1 = add nuw nsw i32 %mul494.3.1, %mul178, !dbg !178
  %add500.3.1 = or disjoint i32 %add495.3.1, %mul499, !dbg !179
  %add.ptr502.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.3.1, !dbg !180
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr502.3.1, align 8, !dbg !181
  %xor493.4.1 = xor i32 %add490.4.1.pre-phi, %and184, !dbg !176
  %mul494.4.1 = shl nuw nsw i32 %xor493.4.1, 3, !dbg !177
  %add495.4.1 = add nuw nsw i32 %mul494.4.1, %mul178, !dbg !178
  %add500.4.1 = or disjoint i32 %add495.4.1, %mul499, !dbg !179
  %add.ptr502.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.4.1, !dbg !180
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr502.4.1, align 8, !dbg !181
  %xor493.5.1 = xor i32 %add490.5.1.pre-phi, %and184, !dbg !176
  %mul494.5.1 = shl nuw nsw i32 %xor493.5.1, 3, !dbg !177
  %add495.5.1 = add nuw nsw i32 %mul494.5.1, %mul178, !dbg !178
  %add500.5.1 = or disjoint i32 %add495.5.1, %mul499, !dbg !179
  %add.ptr502.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.5.1, !dbg !180
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr502.5.1, align 8, !dbg !181
  %xor493.6.1 = xor i32 %add490.6.1.pre-phi, %and184, !dbg !176
  %mul494.6.1 = shl nuw nsw i32 %xor493.6.1, 3, !dbg !177
  %add495.6.1 = add nuw nsw i32 %mul494.6.1, %mul178, !dbg !178
  %add500.6.1 = or disjoint i32 %add495.6.1, %mul499, !dbg !179
  %add.ptr502.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.6.1, !dbg !180
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr502.6.1, align 8, !dbg !181
  %xor493.7.1 = xor i32 %add490.7.1.pre-phi, %and184, !dbg !176
  %mul494.7.1 = shl nuw nsw i32 %xor493.7.1, 3, !dbg !177
  %add495.7.1 = add nuw nsw i32 %mul494.7.1, %mul178, !dbg !178
  %add500.7.1 = or disjoint i32 %add495.7.1, %mul499, !dbg !179
  %add.ptr502.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add500.7.1, !dbg !180
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr502.7.1, align 8, !dbg !181
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %add.ptr566.1894 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 %add.ptr566.idx.1893.pre-phi, !dbg !60
  %condval_11.0.1895 = shl nuw nsw i32 %.780.1, 11, !dbg !187
  %add576.1896 = add i32 %mul570, %condval_11.0.1895, !dbg !188
  %idx.ext577.1897 = sext i32 %add576.1896 to i64, !dbg !189
  %add.ptr578.1898 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577.1897, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578.1898, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566.1894, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep774.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 1024, !dbg !60
  %add.ptr566.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep774.1.1, i32 %add.ptr566.idx.1.1.pre-phi, !dbg !60
  %add571.1.1 = add nsw i32 %mul570, 512, !dbg !193
  %add576.1.1 = add i32 %add571.1.1, %condval_11.0.1895, !dbg !188
  %idx.ext577.1.1 = sext i32 %add576.1.1 to i64, !dbg !189
  %add.ptr578.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577.1.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566.1.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep774.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 2048, !dbg !60
  %add.ptr566.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep774.2.1, i32 %add.ptr566.idx.2.1.pre-phi, !dbg !60
  %add571.2.1 = add nsw i32 %mul570, 1024, !dbg !193
  %add576.2.1 = add i32 %add571.2.1, %condval_11.0.1895, !dbg !188
  %idx.ext577.2.1 = sext i32 %add576.2.1 to i64, !dbg !189
  %add.ptr578.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577.2.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566.2.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  %gep774.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep773, i32 3072, !dbg !60
  %add.ptr566.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep774.3.1, i32 %add.ptr566.idx.3.1.pre-phi, !dbg !60
  %add571.3.1 = add nsw i32 %mul570, 1536, !dbg !193
  %add576.3.1 = add i32 %add571.3.1, %condval_11.0.1895, !dbg !188
  %idx.ext577.3.1 = sext i32 %add576.3.1 to i64, !dbg !189
  %add.ptr578.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext577.3.1, !dbg !189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr578.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr566.3.1, i64 16, i1 false), !dbg !190, !tbaa.struct !191, !call_argsrelate !192
  fence syncscope("warp") release, !dbg !194
  tail call void @llvm.mxc.barrier.warp(), !dbg !197
  fence syncscope("warp") acquire, !dbg !198
  br label %if.end587, !dbg !201

if.end587:                                        ; preds = %if.end475, %if.end475.1, %entry
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
!1 = !DIFile(filename: "/tmp/tmpbgl_l5zi/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpbgl_l5zi/tvm_kernels.maca", directory: "")
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
!74 = !DILocation(line: 78, column: 140, scope: !40)
!75 = !DILocation(line: 78, column: 48, scope: !40)
!76 = !DILocation(line: 78, column: 232, scope: !40)
!77 = !DILocation(line: 78, column: 153, scope: !40)
!78 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !79)
!79 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !80)
!80 = distinct !DILocation(line: 80, column: 11, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !79)
!82 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !79)
!83 = !DILocation(line: 83, column: 157, scope: !40)
!84 = !DILocation(line: 83, column: 75, scope: !40)
!85 = !DILocation(line: 83, column: 38, scope: !40)
!86 = !DILocation(line: 83, column: 128, scope: !40)
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
