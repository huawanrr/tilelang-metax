; ModuleID = 'experiments/20261017_resume/window_pair_shared_binary/oj6_m4_p1.bc'
source_filename = "/tmp/tmp86m3krnm/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(1) noalias nocapture noundef readonly %Schedule.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !42, !range !29
  %mul = mul nuw nsw i32 %0, 80, !dbg !46
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !47, !range !29
  %add = add nuw nsw i32 %mul, %1, !dbg !50
  %idxprom = zext nneg i32 %add to i64, !dbg !51
  %arrayidx = getelementptr inbounds i64, ptr addrspace(1) %Schedule.coerce, i64 %idxprom, !dbg !51
  %2 = load i64, ptr addrspace(1) %arrayidx, align 8, !dbg !51, !tbaa !17
  %and = and i64 %2, 65535, !dbg !52
  %conv = trunc nuw nsw i64 %and to i32, !dbg !53
  %cmp.not = icmp eq i64 %and, 0, !dbg !54
  br i1 %cmp.not, label %if.end657, label %for.cond.preheader, !dbg !55

for.cond.preheader:                               ; preds = %entry
  %invariant.gep856 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !56
  %3 = trunc i64 %2 to i32
  %4 = lshr i32 %3, 16
  %5 = tail call range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !57
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
  %mul129 = zext nneg i32 %8 to i64
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
  %gep857 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep856, i64 %mul129
  %.872 = tail call i32 @llvm.smin.i32(i32 %conv, i32 1024)
  %cmp109 = icmp slt i32 %mul108, %.872
  %or.cond791 = select i1 %or.cond, i1 %cmp109, i1 false, !dbg !58
  br i1 %or.cond791, label %for.body116.preheader, label %if.end392, !dbg !58

for.body116.preheader:                            ; preds = %for.cond.preheader
  %.idx = shl nuw nsw i64 %shr63, 22, !dbg !59
  %11 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx, !dbg !59
  %12 = getelementptr i8, ptr addrspace(4) %11, i64 -512, !dbg !59
  %13 = tail call i64 @llvm.umin.i64(i64 %and, i64 1024)
  %gep.idx = shl nuw nsw i64 %13, 12, !dbg !59
  %gep.7 = getelementptr i8, ptr addrspace(4) %12, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr inbounds i8, ptr addrspace(4) %gep.7, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.44.60.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.7 to i64, !dbg !61
  %q_stage.sroa.44.60.insert.shift = shl nuw i64 %q_stage.sroa.44.60.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.44.56.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.7 to i64, !dbg !61
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %q_stage.sroa.44.60.insert.shift, %q_stage.sroa.44.56.insert.ext, !dbg !61
  %14 = getelementptr i8, ptr addrspace(4) %11, i64 -1024, !dbg !59
  %gep.6 = getelementptr i8, ptr addrspace(4) %14, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr inbounds i8, ptr addrspace(4) %gep.6, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.6 to i64, !dbg !61
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.6 to i64, !dbg !61
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext, !dbg !61
  %15 = getelementptr i8, ptr addrspace(4) %11, i64 -1536, !dbg !59
  %gep.5 = getelementptr i8, ptr addrspace(4) %15, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr inbounds i8, ptr addrspace(4) %gep.5, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.5 to i64, !dbg !61
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.5 to i64, !dbg !61
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext, !dbg !61
  %16 = getelementptr i8, ptr addrspace(4) %11, i64 -2048, !dbg !59
  %gep.4 = getelementptr i8, ptr addrspace(4) %16, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr inbounds i8, ptr addrspace(4) %gep.4, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.4 to i64, !dbg !61
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.4 to i64, !dbg !61
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext, !dbg !61
  %17 = getelementptr i8, ptr addrspace(4) %11, i64 -2560, !dbg !59
  %gep.3 = getelementptr i8, ptr addrspace(4) %17, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %gep.3, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.3 to i64, !dbg !61
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.3 to i64, !dbg !61
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext, !dbg !61
  %18 = getelementptr i8, ptr addrspace(4) %11, i64 -3072, !dbg !59
  %gep.2 = getelementptr i8, ptr addrspace(4) %18, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %gep.2, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.2 to i64, !dbg !61
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.2 to i64, !dbg !61
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext, !dbg !61
  %19 = getelementptr i8, ptr addrspace(4) %11, i64 -3584, !dbg !59
  %gep.1 = getelementptr i8, ptr addrspace(4) %19, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.1 to i64, !dbg !61
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.1 to i64, !dbg !61
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext, !dbg !61
  %20 = getelementptr i8, ptr addrspace(4) %11, i64 -4096, !dbg !59
  %gep = getelementptr i8, ptr addrspace(4) %20, i64 %gep.idx, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0.copyload to i64, !dbg !61
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32, !dbg !61
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %gep, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0.copyload to i64, !dbg !61
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext, !dbg !61
  %21 = and i64 %2, 4294901760
  %cmp282 = icmp eq i64 %21, 0
  %invariant.gep836 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul129
  %.idx880 = shl nuw nsw i64 %shr100, 14, !dbg !62
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep836, i64 %.idx880, !dbg !62
  %.idx881 = shl nuw nsw i64 %shr63, 19, !dbg !62
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx881, !dbg !62
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %23, align 16, !dbg !63
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 8, !dbg !63
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8, !dbg !63
  %gep837.1 = getelementptr i8, ptr addrspace(4) %23, i64 1024, !dbg !62
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep837.1, align 16, !dbg !63
  %k.sroa.12.16.gep837.1.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 1032, !dbg !63
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep837.1.sroa_idx, align 8, !dbg !63
  %gep837.2 = getelementptr i8, ptr addrspace(4) %23, i64 2048, !dbg !62
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep837.2, align 16, !dbg !63
  %k.sroa.18.32.gep837.2.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 2056, !dbg !63
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep837.2.sroa_idx, align 8, !dbg !63
  %gep837.3 = getelementptr i8, ptr addrspace(4) %23, i64 3072, !dbg !62
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep837.3, align 16, !dbg !63
  %k.sroa.24.48.gep837.3.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 3080, !dbg !63
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep837.3.sroa_idx, align 8, !dbg !63
  %gep837.4 = getelementptr i8, ptr addrspace(4) %23, i64 4096, !dbg !62
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep837.4, align 16, !dbg !63
  %k.sroa.30.64.gep837.4.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 4104, !dbg !63
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep837.4.sroa_idx, align 8, !dbg !63
  %gep837.5 = getelementptr i8, ptr addrspace(4) %23, i64 5120, !dbg !62
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep837.5, align 16, !dbg !63
  %k.sroa.36.80.gep837.5.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 5128, !dbg !63
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep837.5.sroa_idx, align 8, !dbg !63
  %gep837.6 = getelementptr i8, ptr addrspace(4) %23, i64 6144, !dbg !62
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep837.6, align 16, !dbg !63
  %k.sroa.42.96.gep837.6.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 6152, !dbg !63
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep837.6.sroa_idx, align 8, !dbg !63
  %gep837.7 = getelementptr i8, ptr addrspace(4) %23, i64 7168, !dbg !62
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep837.7, align 16, !dbg !63
  %k.sroa.48.112.gep837.7.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 7176, !dbg !63
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep837.7.sroa_idx, align 8, !dbg !63
  %xor = xor i32 %shr158, %shr155, !dbg !64
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152, !dbg !65
  %add.ptr167.idx = shl nuw nsw i32 %xor, 4, !dbg !65
  %add.ptr167 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr167.idx, !dbg !65
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %add.ptr167, align 8, !dbg !66
  %add159.1 = add nuw nsw i32 %shr158, 2, !dbg !67
  %xor.1 = xor i32 %add159.1, %shr155, !dbg !64
  %25 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 512, !dbg !65
  %add.ptr167.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !65
  %add.ptr167.1 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr167.idx.1, !dbg !65
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %add.ptr167.1, align 8, !dbg !66
  %add159.2 = add nuw nsw i32 %shr158, 4, !dbg !67
  %xor.2 = xor i32 %add159.2, %shr155, !dbg !64
  %26 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1024, !dbg !65
  %add.ptr167.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !65
  %add.ptr167.2 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr167.idx.2, !dbg !65
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %add.ptr167.2, align 8, !dbg !66
  %add159.3 = add nuw nsw i32 %shr158, 6, !dbg !67
  %xor.3 = xor i32 %add159.3, %shr155, !dbg !64
  %27 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1536, !dbg !65
  %add.ptr167.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !65
  %add.ptr167.3 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr167.idx.3, !dbg !65
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %add.ptr167.3, align 8, !dbg !66
  %add159.4 = add nuw nsw i32 %shr158, 8, !dbg !67
  %xor.4 = xor i32 %add159.4, %shr155, !dbg !64
  %28 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2048, !dbg !65
  %add.ptr167.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !65
  %add.ptr167.4 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr167.idx.4, !dbg !65
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %add.ptr167.4, align 8, !dbg !66
  %add159.5 = add nuw nsw i32 %shr158, 10, !dbg !67
  %xor.5 = xor i32 %add159.5, %shr155, !dbg !64
  %29 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2560, !dbg !65
  %add.ptr167.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !65
  %add.ptr167.5 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr167.idx.5, !dbg !65
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %add.ptr167.5, align 8, !dbg !66
  %add159.6 = add nuw nsw i32 %shr158, 12, !dbg !67
  %xor.6 = xor i32 %add159.6, %shr155, !dbg !64
  %30 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3072, !dbg !65
  %add.ptr167.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !65
  %add.ptr167.6 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr167.idx.6, !dbg !65
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %add.ptr167.6, align 8, !dbg !66
  %add159.7 = add nuw nsw i32 %shr158, 14, !dbg !67
  %xor.7 = xor i32 %add159.7, %shr155, !dbg !64
  %31 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3584, !dbg !65
  %add.ptr167.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !65
  %add.ptr167.7 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr167.idx.7, !dbg !65
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %add.ptr167.7, align 8, !dbg !66
  fence syncscope("warp") release, !dbg !68
  tail call void @llvm.mxc.barrier.warp(), !dbg !74
  fence syncscope("warp") acquire, !dbg !75
  %xor184 = xor i32 %shr180, %and183, !dbg !76
  %add.ptr188.idx = shl nuw nsw i32 %xor184, 4, !dbg !77
  %add.ptr188 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx, !dbg !77
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188, align 16, !dbg !78
  %q.sroa.6.0.add.ptr188.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188, i32 8, !dbg !78
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.sroa_idx, align 8, !dbg !78
  %add181.1 = add nuw nsw i32 %shr180, 4, !dbg !79
  %xor184.1 = xor i32 %add181.1, %and183, !dbg !76
  %add.ptr188.idx.1 = shl nuw nsw i32 %xor184.1, 4, !dbg !77
  %add.ptr188.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1, !dbg !77
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.1, align 16, !dbg !78
  %q.sroa.12.16.add.ptr188.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1, i32 8, !dbg !78
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.sroa_idx, align 8, !dbg !78
  %add181.2 = add nuw nsw i32 %shr180, 8, !dbg !79
  %xor184.2 = xor i32 %add181.2, %and183, !dbg !76
  %add.ptr188.idx.2 = shl nuw nsw i32 %xor184.2, 4, !dbg !77
  %add.ptr188.2 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2, !dbg !77
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.2, align 16, !dbg !78
  %q.sroa.18.32.add.ptr188.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2, i32 8, !dbg !78
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.sroa_idx, align 8, !dbg !78
  %add181.3 = add nuw nsw i32 %shr180, 12, !dbg !79
  %xor184.3 = xor i32 %add181.3, %and183, !dbg !76
  %add.ptr188.idx.3 = shl nuw nsw i32 %xor184.3, 4, !dbg !77
  %add.ptr188.3 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3, !dbg !77
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.3, align 16, !dbg !78
  %q.sroa.24.48.add.ptr188.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3, i32 8, !dbg !78
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.sroa_idx, align 8, !dbg !78
  %cmp229.not.not = icmp slt i32 %add222, %.872, !dbg !80
  %spec.select = select i1 %cmp229.not.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !82
  %add226.1 = or disjoint i32 %add222, 1, !dbg !83
  %cmp229.not.not.1 = icmp slt i32 %add226.1, %.872, !dbg !80
  %spec.select.1 = select i1 %cmp229.not.not.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !82
  %add226.2 = or disjoint i32 %add222, 2, !dbg !83
  %cmp229.not.not.2 = icmp slt i32 %add226.2, %.872, !dbg !80
  %spec.select.2 = select i1 %cmp229.not.not.2, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !82
  %add226.3 = or disjoint i32 %add222, 3, !dbg !83
  %cmp229.not.not.3 = icmp slt i32 %add226.3, %.872, !dbg !80
  %spec.select.3 = select i1 %cmp229.not.not.3, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !82
  %add228.4 = add nuw nsw i32 %add222, 16, !dbg !84
  %cmp229.not.not.4 = icmp slt i32 %add228.4, %.872, !dbg !80
  %spec.select.4 = select i1 %cmp229.not.not.4, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !82
  %add228.5 = add nuw nsw i32 %add222, 17, !dbg !84
  %cmp229.not.not.5 = icmp slt i32 %add228.5, %.872, !dbg !80
  %spec.select.5 = select i1 %cmp229.not.not.5, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1, !dbg !82
  %add228.6 = add nuw nsw i32 %add222, 18, !dbg !84
  %cmp229.not.not.6 = icmp slt i32 %add228.6, %.872, !dbg !80
  %spec.select.6 = select i1 %cmp229.not.not.6, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2, !dbg !82
  %add228.7 = add nuw nsw i32 %add222, 19, !dbg !84
  %cmp229.not.not.7 = icmp slt i32 %add228.7, %.872, !dbg !80
  %spec.select.7 = select i1 %cmp229.not.not.7, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3, !dbg !82
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !85, !call_argsrelate !86
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !dbg !85, !call_argsrelate !86
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %32), !dbg !85, !call_argsrelate !86
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %33), !dbg !85, !call_argsrelate !86
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %34), !dbg !85, !call_argsrelate !86
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %35), !dbg !85, !call_argsrelate !86
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %36), !dbg !85, !call_argsrelate !86
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %37), !dbg !85, !call_argsrelate !86
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %38), !dbg !85, !call_argsrelate !86
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %39), !dbg !85, !call_argsrelate !86
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %40), !dbg !85, !call_argsrelate !86
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %41), !dbg !85, !call_argsrelate !86
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %42), !dbg !85, !call_argsrelate !86
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %43), !dbg !85, !call_argsrelate !86
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %44), !dbg !85, !call_argsrelate !86
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %45), !dbg !85, !call_argsrelate !86
  br i1 %cmp282, label %for.body287.preheader, label %if.end311, !dbg !87

for.body287.preheader:                            ; preds = %for.body116.preheader
  %.idx886 = shl nuw nsw i64 %shr100, 14, !dbg !88
  %48 = getelementptr i8, ptr addrspace(4) %gep857, i64 %.idx886, !dbg !88
  %.idx887 = shl nuw nsw i64 %shr63, 19, !dbg !88
  %49 = getelementptr i8, ptr addrspace(4) %48, i64 %.idx887, !dbg !88
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %49, align 16, !dbg !89
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %49, i64 8, !dbg !89
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8, !dbg !89
  %gep848.1 = getelementptr i8, ptr addrspace(4) %49, i64 1024, !dbg !88
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep848.1, align 16, !dbg !89
  %v.sroa.12.16.gep848.1.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 1032, !dbg !89
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep848.1.sroa_idx, align 8, !dbg !89
  %gep848.2 = getelementptr i8, ptr addrspace(4) %49, i64 2048, !dbg !88
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep848.2, align 16, !dbg !89
  %v.sroa.18.32.gep848.2.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 2056, !dbg !89
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep848.2.sroa_idx, align 8, !dbg !89
  %gep848.3 = getelementptr i8, ptr addrspace(4) %49, i64 3072, !dbg !88
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep848.3, align 16, !dbg !89
  %v.sroa.24.48.gep848.3.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 3080, !dbg !89
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep848.3.sroa_idx, align 8, !dbg !89
  %gep848.4 = getelementptr i8, ptr addrspace(4) %49, i64 4096, !dbg !88
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep848.4, align 16, !dbg !89
  %v.sroa.30.64.gep848.4.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 4104, !dbg !89
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep848.4.sroa_idx, align 8, !dbg !89
  %gep848.5 = getelementptr i8, ptr addrspace(4) %49, i64 5120, !dbg !88
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep848.5, align 16, !dbg !89
  %v.sroa.36.80.gep848.5.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 5128, !dbg !89
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep848.5.sroa_idx, align 8, !dbg !89
  %gep848.6 = getelementptr i8, ptr addrspace(4) %49, i64 6144, !dbg !88
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep848.6, align 16, !dbg !89
  %v.sroa.42.96.gep848.6.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 6152, !dbg !89
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep848.6.sroa_idx, align 8, !dbg !89
  %gep848.7 = getelementptr i8, ptr addrspace(4) %49, i64 7168, !dbg !88
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep848.7, align 16, !dbg !89
  %v.sroa.48.112.gep848.7.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 7176, !dbg !89
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep848.7.sroa_idx, align 8, !dbg !89
  br label %if.end311, !dbg !90

if.end311:                                        ; preds = %for.body287.preheader, %for.body116.preheader
  %v.sroa.48.0 = phi <4 x half> [ %v.sroa.48.112.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.44.0 = phi <4 x half> [ %v.sroa.44.112.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.42.0 = phi <4 x half> [ %v.sroa.42.96.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.38.0 = phi <4 x half> [ %v.sroa.38.96.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.36.0 = phi <4 x half> [ %v.sroa.36.80.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.32.0 = phi <4 x half> [ %v.sroa.32.80.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.30.0 = phi <4 x half> [ %v.sroa.30.64.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.26.0 = phi <4 x half> [ %v.sroa.26.64.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.24.0 = phi <4 x half> [ %v.sroa.24.48.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.20.0 = phi <4 x half> [ %v.sroa.20.48.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.18.0 = phi <4 x half> [ %v.sroa.18.32.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.14.0 = phi <4 x half> [ %v.sroa.14.32.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.12.0 = phi <4 x half> [ %v.sroa.12.16.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.8.0 = phi <4 x half> [ %v.sroa.8.16.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.6.0 = phi <4 x half> [ %v.sroa.6.0.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.0.0 = phi <4 x half> [ %v.sroa.0.0.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !91
  %mul318 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !92
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul318, float 1.500000e+01), !dbg !93
  %cmp.i.i = fcmp contract olt float %50, -1.260000e+02, !dbg !97
  %cond.i.i814 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815 = fadd contract float %50, %cond.i.i814, !dbg !97
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i815), !dbg !97
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i = fmul contract float %cond2.i.i, %51, !dbg !97
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1, !dbg !91
  %mul318.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !92
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul318.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.1 = fcmp contract olt float %52, -1.260000e+02, !dbg !97
  %cond.i.i814.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.1 = fadd contract float %52, %cond.i.i814.1, !dbg !97
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i815.1), !dbg !97
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %53, !dbg !97
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2, !dbg !91
  %mul318.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !92
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul318.2, float 1.500000e+01), !dbg !93
  %cmp.i.i.2 = fcmp contract olt float %54, -1.260000e+02, !dbg !97
  %cond.i.i814.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.2 = fadd contract float %54, %cond.i.i814.2, !dbg !97
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i815.2), !dbg !97
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %55, !dbg !97
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3, !dbg !91
  %mul318.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !92
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul318.3, float 1.500000e+01), !dbg !93
  %cmp.i.i.3 = fcmp contract olt float %56, -1.260000e+02, !dbg !97
  %cond.i.i814.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.3 = fadd contract float %56, %cond.i.i814.3, !dbg !97
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i815.3), !dbg !97
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %57, !dbg !97
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %47, i64 0, !dbg !91
  %mul318.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000, !dbg !92
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul318.4, float 1.500000e+01), !dbg !93
  %cmp.i.i.4 = fcmp contract olt float %58, -1.260000e+02, !dbg !97
  %cond.i.i814.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.4 = fadd contract float %58, %cond.i.i814.4, !dbg !97
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i815.4), !dbg !97
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %59, !dbg !97
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %47, i64 1, !dbg !91
  %mul318.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000, !dbg !92
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul318.5, float 1.500000e+01), !dbg !93
  %cmp.i.i.5 = fcmp contract olt float %60, -1.260000e+02, !dbg !97
  %cond.i.i814.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.5 = fadd contract float %60, %cond.i.i814.5, !dbg !97
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i815.5), !dbg !97
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %61, !dbg !97
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %47, i64 2, !dbg !91
  %mul318.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000, !dbg !92
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul318.6, float 1.500000e+01), !dbg !93
  %cmp.i.i.6 = fcmp contract olt float %62, -1.260000e+02, !dbg !97
  %cond.i.i814.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.6 = fadd contract float %62, %cond.i.i814.6, !dbg !97
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i815.6), !dbg !97
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %63, !dbg !97
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %47, i64 3, !dbg !91
  %mul318.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000, !dbg !92
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul318.7, float 1.500000e+01), !dbg !93
  %cmp.i.i.7 = fcmp contract olt float %64, -1.260000e+02, !dbg !97
  %cond.i.i814.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.7 = fadd contract float %64, %cond.i.i814.7, !dbg !97
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i815.7), !dbg !97
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %65, !dbg !97
  %add338 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !100
  %add338.1 = fadd contract float %add338, %mul.i.i.4, !dbg !100
  %add338.2 = fadd contract float %add338.1, %mul.i.i.1, !dbg !100
  %add338.3 = fadd contract float %add338.2, %mul.i.i.5, !dbg !100
  %add338.4 = fadd contract float %add338.3, %mul.i.i.2, !dbg !100
  %add338.5 = fadd contract float %add338.4, %mul.i.i.6, !dbg !100
  %add338.6 = fadd contract float %add338.5, %mul.i.i.3, !dbg !100
  %add338.7 = fadd contract float %add338.6, %mul.i.i.7, !dbg !100
  %66 = bitcast float %add338.7 to i32, !dbg !101
  %67 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !112
  %68 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %67) #11, !dbg !117
  %xor.i.i = xor i32 %68, 32, !dbg !118
  %69 = and i32 %68, -64, !dbg !119
  %and.i.i = add nsw i32 %69, 64, !dbg !119
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !120
  %cond.i.i816 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %68, !dbg !121
  %shl.i.i = shl i32 %cond.i.i816, 2, !dbg !122
  %70 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %66), !dbg !123
  %71 = bitcast i32 %70 to float, !dbg !124
  %add.i = fadd contract float %add338.7, %71, !dbg !125
  %72 = bitcast float %add.i to i32, !dbg !128
  %73 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !135
  %74 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %73) #11, !dbg !138
  %xor.i.i817 = xor i32 %74, 16, !dbg !139
  %75 = and i32 %74, -64, !dbg !140
  %and.i.i818 = add nsw i32 %75, 64, !dbg !140
  %cmp.not.i.i819 = icmp slt i32 %xor.i.i817, %and.i.i818, !dbg !141
  %cond.i.i820 = select i1 %cmp.not.i.i819, i32 %xor.i.i817, i32 %74, !dbg !142
  %shl.i.i821 = shl i32 %cond.i.i820, 2, !dbg !143
  %76 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i821, i32 %72), !dbg !144
  %77 = bitcast i32 %76 to float, !dbg !145
  %add.i.i = fadd contract float %add.i, %77, !dbg !146
  %cmp347 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !148
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !149
  %condval_8.0 = select i1 %cmp347, float %div, float 0.000000e+00, !dbg !149
  %mul360 = fmul contract float %condval_8.0, %mul.i.i, !dbg !150
  %mul360.1 = fmul contract float %condval_8.0, %mul.i.i.1, !dbg !150
  %mul360.2 = fmul contract float %condval_8.0, %mul.i.i.2, !dbg !150
  %mul360.3 = fmul contract float %condval_8.0, %mul.i.i.3, !dbg !150
  %mul360.4 = fmul contract float %condval_8.0, %mul.i.i.4, !dbg !150
  %mul360.5 = fmul contract float %condval_8.0, %mul.i.i.5, !dbg !150
  %mul360.6 = fmul contract float %condval_8.0, %mul.i.i.6, !dbg !150
  %mul360.7 = fmul contract float %condval_8.0, %mul.i.i.7, !dbg !150
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360), !dbg !151
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.1), !dbg !151
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.2), !dbg !151
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.3), !dbg !151
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.4), !dbg !151
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.5), !dbg !151
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.6), !dbg !151
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.7), !dbg !151
  fence syncscope("warp") release, !dbg !160
  tail call void @llvm.mxc.barrier.warp(), !dbg !163
  fence syncscope("warp") acquire, !dbg !164
  %86 = insertelement <4 x i16> poison, i16 %78, i64 0, !dbg !165
  %87 = insertelement <4 x i16> %86, i16 %79, i64 1, !dbg !165
  %88 = insertelement <4 x i16> %87, i16 %80, i64 2, !dbg !165
  %89 = insertelement <4 x i16> %88, i16 %81, i64 3, !dbg !165
  %90 = bitcast <4 x i16> %89 to <4 x half>, !dbg !165
  %91 = insertelement <4 x i16> poison, i16 %82, i64 0, !dbg !165
  %92 = insertelement <4 x i16> %91, i16 %83, i64 1, !dbg !165
  %93 = insertelement <4 x i16> %92, i16 %84, i64 2, !dbg !165
  %94 = insertelement <4 x i16> %93, i16 %85, i64 3, !dbg !165
  %95 = bitcast <4 x i16> %94 to <4 x half>, !dbg !165
  br label %if.end392, !dbg !166

if.end392:                                        ; preds = %if.end311, %for.cond.preheader
  %v.sroa.48.1 = phi <4 x half> [ %v.sroa.48.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.44.1 = phi <4 x half> [ %v.sroa.44.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.42.1 = phi <4 x half> [ %v.sroa.42.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.38.1 = phi <4 x half> [ %v.sroa.38.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.36.1 = phi <4 x half> [ %v.sroa.36.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.32.1 = phi <4 x half> [ %v.sroa.32.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.30.1 = phi <4 x half> [ %v.sroa.30.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.26.1 = phi <4 x half> [ %v.sroa.26.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.24.1 = phi <4 x half> [ %v.sroa.24.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.20.1 = phi <4 x half> [ %v.sroa.20.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.18.1 = phi <4 x half> [ %v.sroa.18.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.14.1 = phi <4 x half> [ %v.sroa.14.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.12.1 = phi <4 x half> [ %v.sroa.12.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.8.1 = phi <4 x half> [ %v.sroa.8.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.6.1 = phi <4 x half> [ %v.sroa.6.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.0.1 = phi <4 x half> [ %v.sroa.0.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.48.1 = phi <4 x half> [ %k.sroa.48.112.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.44.1 = phi <4 x half> [ %k.sroa.44.112.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.42.1 = phi <4 x half> [ %k.sroa.42.96.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.38.1 = phi <4 x half> [ %k.sroa.38.96.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.36.1 = phi <4 x half> [ %k.sroa.36.80.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.32.1 = phi <4 x half> [ %k.sroa.32.80.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.30.1 = phi <4 x half> [ %k.sroa.30.64.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.26.1 = phi <4 x half> [ %k.sroa.26.64.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.24.1 = phi <4 x half> [ %k.sroa.24.48.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.20.1 = phi <4 x half> [ %k.sroa.20.48.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.18.1 = phi <4 x half> [ %k.sroa.18.32.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.14.1 = phi <4 x half> [ %k.sroa.14.32.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.12.1 = phi <4 x half> [ %k.sroa.12.16.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.8.1 = phi <4 x half> [ %k.sroa.8.16.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.6.1 = phi <4 x half> [ %k.sroa.6.0.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.0.1 = phi <4 x half> [ %k.sroa.0.0.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %96 = phi <4 x half> [ %95, %if.end311 ], [ undef, %for.cond.preheader ]
  %97 = phi <4 x half> [ %90, %if.end311 ], [ undef, %for.cond.preheader ]
  %cmp16.not.1 = icmp ult i32 %3, 65536, !dbg !167
  br i1 %cmp16.not.1, label %if.end392.1, label %if.end48.preheader.1, !dbg !168

if.end48.preheader.1:                             ; preds = %if.end392
  %.872.1 = tail call i32 @llvm.smin.i32(i32 %4, i32 1024)
  %cmp109.1 = icmp slt i32 %mul108, %.872.1
  %or.cond791.1 = select i1 %or.cond, i1 %cmp109.1, i1 false, !dbg !58
  br i1 %or.cond791.1, label %if.end139.1, label %if.end392.1, !dbg !58

if.end139.1:                                      ; preds = %if.end48.preheader.1
  %.idx.1910 = shl nuw nsw i64 %shr63, 22, !dbg !59
  %98 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1910, !dbg !59
  %99 = getelementptr i8, ptr addrspace(4) %98, i64 -512, !dbg !59
  %100 = tail call i64 @llvm.umin.i64(i64 %and57, i64 1024)
  %gep.idx.1911 = shl nuw nsw i64 %100, 12, !dbg !59
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %99, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.7.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.44.60.insert.ext1824 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64, !dbg !61
  %q_stage.sroa.44.60.insert.shift1825 = shl nuw i64 %q_stage.sroa.44.60.insert.ext1824, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.44.56.insert.ext1820 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64, !dbg !61
  %q_stage.sroa.44.60.insert.insert1827 = or disjoint i64 %q_stage.sroa.44.60.insert.shift1825, %q_stage.sroa.44.56.insert.ext1820, !dbg !61
  %101 = getelementptr i8, ptr addrspace(4) %98, i64 -1024, !dbg !59
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %101, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.6.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.38.52.insert.ext1814 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64, !dbg !61
  %q_stage.sroa.38.52.insert.shift1815 = shl nuw i64 %q_stage.sroa.38.52.insert.ext1814, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.38.48.insert.ext1810 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64, !dbg !61
  %q_stage.sroa.38.52.insert.insert1817 = or disjoint i64 %q_stage.sroa.38.52.insert.shift1815, %q_stage.sroa.38.48.insert.ext1810, !dbg !61
  %102 = getelementptr i8, ptr addrspace(4) %98, i64 -1536, !dbg !59
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %102, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.5.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.32.44.insert.ext1804 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64, !dbg !61
  %q_stage.sroa.32.44.insert.shift1805 = shl nuw i64 %q_stage.sroa.32.44.insert.ext1804, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.32.40.insert.ext1800 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64, !dbg !61
  %q_stage.sroa.32.44.insert.insert1807 = or disjoint i64 %q_stage.sroa.32.44.insert.shift1805, %q_stage.sroa.32.40.insert.ext1800, !dbg !61
  %103 = getelementptr i8, ptr addrspace(4) %98, i64 -2048, !dbg !59
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %103, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.4.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.26.36.insert.ext1794 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64, !dbg !61
  %q_stage.sroa.26.36.insert.shift1795 = shl nuw i64 %q_stage.sroa.26.36.insert.ext1794, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.26.32.insert.ext1790 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64, !dbg !61
  %q_stage.sroa.26.36.insert.insert1797 = or disjoint i64 %q_stage.sroa.26.36.insert.shift1795, %q_stage.sroa.26.32.insert.ext1790, !dbg !61
  %104 = getelementptr i8, ptr addrspace(4) %98, i64 -2560, !dbg !59
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %104, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.3.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.20.28.insert.ext1784 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64, !dbg !61
  %q_stage.sroa.20.28.insert.shift1785 = shl nuw i64 %q_stage.sroa.20.28.insert.ext1784, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.20.24.insert.ext1780 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64, !dbg !61
  %q_stage.sroa.20.28.insert.insert1787 = or disjoint i64 %q_stage.sroa.20.28.insert.shift1785, %q_stage.sroa.20.24.insert.ext1780, !dbg !61
  %105 = getelementptr i8, ptr addrspace(4) %98, i64 -3072, !dbg !59
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %105, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.2.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.14.20.insert.ext1774 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64, !dbg !61
  %q_stage.sroa.14.20.insert.shift1775 = shl nuw i64 %q_stage.sroa.14.20.insert.ext1774, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.14.16.insert.ext1770 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64, !dbg !61
  %q_stage.sroa.14.20.insert.insert1777 = or disjoint i64 %q_stage.sroa.14.20.insert.shift1775, %q_stage.sroa.14.16.insert.ext1770, !dbg !61
  %106 = getelementptr i8, ptr addrspace(4) %98, i64 -3584, !dbg !59
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %106, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1.1, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.8.12.insert.ext1764 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64, !dbg !61
  %q_stage.sroa.8.12.insert.shift1765 = shl nuw i64 %q_stage.sroa.8.12.insert.ext1764, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.8.8.insert.ext1760 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64, !dbg !61
  %q_stage.sroa.8.12.insert.insert1767 = or disjoint i64 %q_stage.sroa.8.12.insert.shift1765, %q_stage.sroa.8.8.insert.ext1760, !dbg !61
  %107 = getelementptr i8, ptr addrspace(4) %98, i64 -4096, !dbg !59
  %gep.1912 = getelementptr i8, ptr addrspace(4) %107, i64 %gep.idx.1911, !dbg !59
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1913 = getelementptr inbounds i8, ptr addrspace(4) %gep.1912, i64 4, !dbg !60
  %condval_1.sroa.5.0.copyload.1914 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1913, align 4, !dbg !60, !tbaa !30
  %q_stage.sroa.0.4.insert.ext1754 = zext i32 %condval_1.sroa.5.0.copyload.1914 to i64, !dbg !61
  %q_stage.sroa.0.4.insert.shift1755 = shl nuw i64 %q_stage.sroa.0.4.insert.ext1754, 32, !dbg !61
  %condval_1.sroa.0.0.copyload.1915 = load i32, ptr addrspace(4) %gep.1912, align 8, !dbg !60, !tbaa !30
  %q_stage.sroa.0.0.insert.ext1750 = zext i32 %condval_1.sroa.0.0.copyload.1915 to i64, !dbg !61
  %q_stage.sroa.0.4.insert.insert1757 = or disjoint i64 %q_stage.sroa.0.4.insert.shift1755, %q_stage.sroa.0.0.insert.ext1750, !dbg !61
  %xor.1919 = xor i32 %shr158, %shr155, !dbg !64
  %108 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152, !dbg !65
  %add.ptr167.idx.1920 = shl nuw nsw i32 %xor.1919, 4, !dbg !65
  %add.ptr167.1921 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 %add.ptr167.idx.1920, !dbg !65
  store i64 %q_stage.sroa.0.4.insert.insert1757, ptr addrspace(3) %add.ptr167.1921, align 8, !dbg !66
  %add159.1.1 = add nuw nsw i32 %shr158, 2, !dbg !67
  %xor.1.1 = xor i32 %add159.1.1, %shr155, !dbg !64
  %109 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 512, !dbg !65
  %add.ptr167.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4, !dbg !65
  %add.ptr167.1.1 = getelementptr inbounds i8, ptr addrspace(3) %109, i32 %add.ptr167.idx.1.1, !dbg !65
  store i64 %q_stage.sroa.8.12.insert.insert1767, ptr addrspace(3) %add.ptr167.1.1, align 8, !dbg !66
  %add159.2.1 = add nuw nsw i32 %shr158, 4, !dbg !67
  %xor.2.1 = xor i32 %add159.2.1, %shr155, !dbg !64
  %110 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 1024, !dbg !65
  %add.ptr167.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4, !dbg !65
  %add.ptr167.2.1 = getelementptr inbounds i8, ptr addrspace(3) %110, i32 %add.ptr167.idx.2.1, !dbg !65
  store i64 %q_stage.sroa.14.20.insert.insert1777, ptr addrspace(3) %add.ptr167.2.1, align 8, !dbg !66
  %add159.3.1 = add nuw nsw i32 %shr158, 6, !dbg !67
  %xor.3.1 = xor i32 %add159.3.1, %shr155, !dbg !64
  %111 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 1536, !dbg !65
  %add.ptr167.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4, !dbg !65
  %add.ptr167.3.1 = getelementptr inbounds i8, ptr addrspace(3) %111, i32 %add.ptr167.idx.3.1, !dbg !65
  store i64 %q_stage.sroa.20.28.insert.insert1787, ptr addrspace(3) %add.ptr167.3.1, align 8, !dbg !66
  %add159.4.1 = add nuw nsw i32 %shr158, 8, !dbg !67
  %xor.4.1 = xor i32 %add159.4.1, %shr155, !dbg !64
  %112 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 2048, !dbg !65
  %add.ptr167.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4, !dbg !65
  %add.ptr167.4.1 = getelementptr inbounds i8, ptr addrspace(3) %112, i32 %add.ptr167.idx.4.1, !dbg !65
  store i64 %q_stage.sroa.26.36.insert.insert1797, ptr addrspace(3) %add.ptr167.4.1, align 8, !dbg !66
  %add159.5.1 = add nuw nsw i32 %shr158, 10, !dbg !67
  %xor.5.1 = xor i32 %add159.5.1, %shr155, !dbg !64
  %113 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 2560, !dbg !65
  %add.ptr167.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4, !dbg !65
  %add.ptr167.5.1 = getelementptr inbounds i8, ptr addrspace(3) %113, i32 %add.ptr167.idx.5.1, !dbg !65
  store i64 %q_stage.sroa.32.44.insert.insert1807, ptr addrspace(3) %add.ptr167.5.1, align 8, !dbg !66
  %add159.6.1 = add nuw nsw i32 %shr158, 12, !dbg !67
  %xor.6.1 = xor i32 %add159.6.1, %shr155, !dbg !64
  %114 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 3072, !dbg !65
  %add.ptr167.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4, !dbg !65
  %add.ptr167.6.1 = getelementptr inbounds i8, ptr addrspace(3) %114, i32 %add.ptr167.idx.6.1, !dbg !65
  store i64 %q_stage.sroa.38.52.insert.insert1817, ptr addrspace(3) %add.ptr167.6.1, align 8, !dbg !66
  %add159.7.1 = add nuw nsw i32 %shr158, 14, !dbg !67
  %xor.7.1 = xor i32 %add159.7.1, %shr155, !dbg !64
  %115 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 3584, !dbg !65
  %add.ptr167.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4, !dbg !65
  %add.ptr167.7.1 = getelementptr inbounds i8, ptr addrspace(3) %115, i32 %add.ptr167.idx.7.1, !dbg !65
  store i64 %q_stage.sroa.44.60.insert.insert1827, ptr addrspace(3) %add.ptr167.7.1, align 8, !dbg !66
  fence syncscope("warp") release, !dbg !68
  tail call void @llvm.mxc.barrier.warp(), !dbg !74
  fence syncscope("warp") acquire, !dbg !75
  %xor184.1922 = xor i32 %shr180, %and183, !dbg !76
  %add.ptr188.idx.1923 = shl nuw nsw i32 %xor184.1922, 4, !dbg !77
  %add.ptr188.1924 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1923, !dbg !77
  %q.sroa.0.0.copyload1700 = load <4 x half>, ptr addrspace(3) %add.ptr188.1924, align 16, !dbg !78
  %q.sroa.6.0.add.ptr188.1924.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1924, i32 8, !dbg !78
  %q.sroa.6.0.copyload1701 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.1924.sroa_idx, align 8, !dbg !78
  %add181.1.1 = add nuw nsw i32 %shr180, 4, !dbg !79
  %xor184.1.1 = xor i32 %add181.1.1, %and183, !dbg !76
  %add.ptr188.idx.1.1 = shl nuw nsw i32 %xor184.1.1, 4, !dbg !77
  %add.ptr188.1.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1.1, !dbg !77
  %q.sroa.8.16.copyload1704 = load <4 x half>, ptr addrspace(3) %add.ptr188.1.1, align 16, !dbg !78
  %q.sroa.12.16.add.ptr188.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1.1, i32 8, !dbg !78
  %q.sroa.12.16.copyload1705 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.1.sroa_idx, align 8, !dbg !78
  %add181.2.1 = add nuw nsw i32 %shr180, 8, !dbg !79
  %xor184.2.1 = xor i32 %add181.2.1, %and183, !dbg !76
  %add.ptr188.idx.2.1 = shl nuw nsw i32 %xor184.2.1, 4, !dbg !77
  %add.ptr188.2.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2.1, !dbg !77
  %q.sroa.14.32.copyload1708 = load <4 x half>, ptr addrspace(3) %add.ptr188.2.1, align 16, !dbg !78
  %q.sroa.18.32.add.ptr188.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2.1, i32 8, !dbg !78
  %q.sroa.18.32.copyload1709 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.1.sroa_idx, align 8, !dbg !78
  %add181.3.1 = add nuw nsw i32 %shr180, 12, !dbg !79
  %xor184.3.1 = xor i32 %add181.3.1, %and183, !dbg !76
  %add.ptr188.idx.3.1 = shl nuw nsw i32 %xor184.3.1, 4, !dbg !77
  %add.ptr188.3.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3.1, !dbg !77
  %q.sroa.20.48.copyload1712 = load <4 x half>, ptr addrspace(3) %add.ptr188.3.1, align 16, !dbg !78
  %q.sroa.24.48.add.ptr188.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3.1, i32 8, !dbg !78
  %q.sroa.24.48.copyload1713 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.1.sroa_idx, align 8, !dbg !78
  %cmp229.not.not.1927 = icmp slt i32 %add222, %.872.1, !dbg !80
  %spec.select.1928 = select i1 %cmp229.not.not.1927, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.0.vec.insert1495 = insertelement <4 x float> poison, float %spec.select.1928, i64 0, !dbg !82
  %add226.1.1 = or disjoint i32 %add222, 1, !dbg !83
  %cmp229.not.not.1.1 = icmp slt i32 %add226.1.1, %.872.1, !dbg !80
  %spec.select.1.1 = select i1 %cmp229.not.not.1.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.4.vec.insert1520 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1495, float %spec.select.1.1, i64 1, !dbg !82
  %add226.2.1 = or disjoint i32 %add222, 2, !dbg !83
  %cmp229.not.not.2.1 = icmp slt i32 %add226.2.1, %.872.1, !dbg !80
  %spec.select.2.1 = select i1 %cmp229.not.not.2.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.8.vec.insert1545 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1520, float %spec.select.2.1, i64 2, !dbg !82
  %add226.3.1 = or disjoint i32 %add222, 3, !dbg !83
  %cmp229.not.not.3.1 = icmp slt i32 %add226.3.1, %.872.1, !dbg !80
  %spec.select.3.1 = select i1 %cmp229.not.not.3.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.0.12.vec.insert1570 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1545, float %spec.select.3.1, i64 3, !dbg !82
  %add228.4.1 = add nuw nsw i32 %add222, 16, !dbg !84
  %cmp229.not.not.4.1 = icmp slt i32 %add228.4.1, %.872.1, !dbg !80
  %spec.select.4.1 = select i1 %cmp229.not.not.4.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.16.vec.insert1611 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0, !dbg !82
  %add228.5.1 = add nuw nsw i32 %add222, 17, !dbg !84
  %cmp229.not.not.5.1 = icmp slt i32 %add228.5.1, %.872.1, !dbg !80
  %spec.select.5.1 = select i1 %cmp229.not.not.5.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.20.vec.insert1636 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1611, float %spec.select.5.1, i64 1, !dbg !82
  %add228.6.1 = add nuw nsw i32 %add222, 18, !dbg !84
  %cmp229.not.not.6.1 = icmp slt i32 %add228.6.1, %.872.1, !dbg !80
  %spec.select.6.1 = select i1 %cmp229.not.not.6.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.24.vec.insert1661 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1636, float %spec.select.6.1, i64 2, !dbg !82
  %add228.7.1 = add nuw nsw i32 %add222, 19, !dbg !84
  %cmp229.not.not.7.1 = icmp slt i32 %add228.7.1, %.872.1, !dbg !80
  %spec.select.7.1 = select i1 %cmp229.not.not.7.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %scores.sroa.90.28.vec.insert1686 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1661, float %spec.select.7.1, i64 3, !dbg !82
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.1, <4 x half> %q.sroa.0.0.copyload1700, <4 x float> %scores.sroa.0.12.vec.insert1570), !dbg !85
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.1, <4 x half> %q.sroa.0.0.copyload1700, <4 x float> %scores.sroa.90.28.vec.insert1686), !dbg !85
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.1, <4 x half> %q.sroa.6.0.copyload1701, <4 x float> %116), !dbg !85
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.1, <4 x half> %q.sroa.6.0.copyload1701, <4 x float> %117), !dbg !85
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.1, <4 x half> %q.sroa.8.16.copyload1704, <4 x float> %118), !dbg !85
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.1, <4 x half> %q.sroa.8.16.copyload1704, <4 x float> %119), !dbg !85
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.1, <4 x half> %q.sroa.12.16.copyload1705, <4 x float> %120), !dbg !85
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.1, <4 x half> %q.sroa.12.16.copyload1705, <4 x float> %121), !dbg !85
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.1, <4 x half> %q.sroa.14.32.copyload1708, <4 x float> %122), !dbg !85
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.1, <4 x half> %q.sroa.14.32.copyload1708, <4 x float> %123), !dbg !85
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.1, <4 x half> %q.sroa.18.32.copyload1709, <4 x float> %124), !dbg !85
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.1, <4 x half> %q.sroa.18.32.copyload1709, <4 x float> %125), !dbg !85
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.1, <4 x half> %q.sroa.20.48.copyload1712, <4 x float> %126), !dbg !85
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.1, <4 x half> %q.sroa.20.48.copyload1712, <4 x float> %127), !dbg !85
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.1, <4 x half> %q.sroa.24.48.copyload1713, <4 x float> %128), !dbg !85
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.1, <4 x half> %q.sroa.24.48.copyload1713, <4 x float> %129), !dbg !85
  %.idx886.1936 = shl nuw nsw i64 %shr100, 14, !dbg !88
  %132 = getelementptr i8, ptr addrspace(4) %gep857, i64 %.idx886.1936, !dbg !88
  %.idx887.1937 = shl nuw nsw i64 %shr63, 19, !dbg !88
  %133 = getelementptr i8, ptr addrspace(4) %132, i64 %.idx887.1937, !dbg !88
  %v.sroa.48.112.gep848.7.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 7176, !dbg !89
  %v.sroa.48.112.copyload1859 = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep848.7.1.sroa_idx, align 8, !dbg !89
  %gep848.7.1 = getelementptr i8, ptr addrspace(4) %133, i64 7168, !dbg !88
  %v.sroa.44.112.copyload1858 = load <4 x half>, ptr addrspace(4) %gep848.7.1, align 16, !dbg !89
  %v.sroa.42.96.gep848.6.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 6152, !dbg !89
  %v.sroa.42.96.copyload1855 = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep848.6.1.sroa_idx, align 8, !dbg !89
  %gep848.6.1 = getelementptr i8, ptr addrspace(4) %133, i64 6144, !dbg !88
  %v.sroa.38.96.copyload1854 = load <4 x half>, ptr addrspace(4) %gep848.6.1, align 16, !dbg !89
  %v.sroa.36.80.gep848.5.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 5128, !dbg !89
  %v.sroa.36.80.copyload1851 = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep848.5.1.sroa_idx, align 8, !dbg !89
  %gep848.5.1 = getelementptr i8, ptr addrspace(4) %133, i64 5120, !dbg !88
  %v.sroa.32.80.copyload1850 = load <4 x half>, ptr addrspace(4) %gep848.5.1, align 16, !dbg !89
  %v.sroa.30.64.gep848.4.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 4104, !dbg !89
  %v.sroa.30.64.copyload1847 = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep848.4.1.sroa_idx, align 8, !dbg !89
  %gep848.4.1 = getelementptr i8, ptr addrspace(4) %133, i64 4096, !dbg !88
  %v.sroa.26.64.copyload1846 = load <4 x half>, ptr addrspace(4) %gep848.4.1, align 16, !dbg !89
  %v.sroa.24.48.gep848.3.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 3080, !dbg !89
  %v.sroa.24.48.copyload1843 = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep848.3.1.sroa_idx, align 8, !dbg !89
  %gep848.3.1 = getelementptr i8, ptr addrspace(4) %133, i64 3072, !dbg !88
  %v.sroa.20.48.copyload1842 = load <4 x half>, ptr addrspace(4) %gep848.3.1, align 16, !dbg !89
  %v.sroa.18.32.gep848.2.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 2056, !dbg !89
  %v.sroa.18.32.copyload1839 = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep848.2.1.sroa_idx, align 8, !dbg !89
  %gep848.2.1 = getelementptr i8, ptr addrspace(4) %133, i64 2048, !dbg !88
  %v.sroa.14.32.copyload1838 = load <4 x half>, ptr addrspace(4) %gep848.2.1, align 16, !dbg !89
  %v.sroa.12.16.gep848.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 1032, !dbg !89
  %v.sroa.12.16.copyload1835 = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep848.1.1.sroa_idx, align 8, !dbg !89
  %gep848.1.1 = getelementptr i8, ptr addrspace(4) %133, i64 1024, !dbg !88
  %v.sroa.8.16.copyload1834 = load <4 x half>, ptr addrspace(4) %gep848.1.1, align 16, !dbg !89
  %v.sroa.6.0..sroa_idx1830 = getelementptr inbounds i8, ptr addrspace(4) %133, i64 8, !dbg !89
  %v.sroa.6.0.copyload1831 = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx1830, align 8, !dbg !89
  %v.sroa.0.0.copyload1829 = load <4 x half>, ptr addrspace(4) %133, align 16, !dbg !89
  %scores.sroa.0.0.vec.extract1497 = extractelement <4 x float> %130, i64 0, !dbg !91
  %mul318.1938 = fmul contract float %scores.sroa.0.0.vec.extract1497, 0x3FC2776C60000000, !dbg !92
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul318.1938, float 1.500000e+01), !dbg !93
  %cmp.i.i.1939 = fcmp contract olt float %134, -1.260000e+02, !dbg !97
  %cond.i.i814.1940 = select contract i1 %cmp.i.i.1939, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.1941 = fadd contract float %134, %cond.i.i814.1940, !dbg !97
  %135 = tail call contract float @llvm.exp2.f32(float %add.i.i815.1941), !dbg !97
  %cond2.i.i.1942 = select contract i1 %cmp.i.i.1939, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.1943 = fmul contract float %cond2.i.i.1942, %135, !dbg !97
  %scores.sroa.0.4.vec.extract1522 = extractelement <4 x float> %130, i64 1, !dbg !91
  %mul318.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1522, 0x3FC2776C60000000, !dbg !92
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul318.1.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.1.1 = fcmp contract olt float %136, -1.260000e+02, !dbg !97
  %cond.i.i814.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.1.1 = fadd contract float %136, %cond.i.i814.1.1, !dbg !97
  %137 = tail call contract float @llvm.exp2.f32(float %add.i.i815.1.1), !dbg !97
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %137, !dbg !97
  %scores.sroa.0.8.vec.extract1547 = extractelement <4 x float> %130, i64 2, !dbg !91
  %mul318.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1547, 0x3FC2776C60000000, !dbg !92
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul318.2.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.2.1 = fcmp contract olt float %138, -1.260000e+02, !dbg !97
  %cond.i.i814.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.2.1 = fadd contract float %138, %cond.i.i814.2.1, !dbg !97
  %139 = tail call contract float @llvm.exp2.f32(float %add.i.i815.2.1), !dbg !97
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %139, !dbg !97
  %scores.sroa.0.12.vec.extract1572 = extractelement <4 x float> %130, i64 3, !dbg !91
  %mul318.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1572, 0x3FC2776C60000000, !dbg !92
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul318.3.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.3.1 = fcmp contract olt float %140, -1.260000e+02, !dbg !97
  %cond.i.i814.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.3.1 = fadd contract float %140, %cond.i.i814.3.1, !dbg !97
  %141 = tail call contract float @llvm.exp2.f32(float %add.i.i815.3.1), !dbg !97
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %141, !dbg !97
  %scores.sroa.90.16.vec.extract1613 = extractelement <4 x float> %131, i64 0, !dbg !91
  %mul318.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1613, 0x3FC2776C60000000, !dbg !92
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul318.4.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.4.1 = fcmp contract olt float %142, -1.260000e+02, !dbg !97
  %cond.i.i814.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.4.1 = fadd contract float %142, %cond.i.i814.4.1, !dbg !97
  %143 = tail call contract float @llvm.exp2.f32(float %add.i.i815.4.1), !dbg !97
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %143, !dbg !97
  %scores.sroa.90.20.vec.extract1638 = extractelement <4 x float> %131, i64 1, !dbg !91
  %mul318.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1638, 0x3FC2776C60000000, !dbg !92
  %144 = tail call contract noundef float @llvm.minnum.f32(float %mul318.5.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.5.1 = fcmp contract olt float %144, -1.260000e+02, !dbg !97
  %cond.i.i814.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.5.1 = fadd contract float %144, %cond.i.i814.5.1, !dbg !97
  %145 = tail call contract float @llvm.exp2.f32(float %add.i.i815.5.1), !dbg !97
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %145, !dbg !97
  %scores.sroa.90.24.vec.extract1663 = extractelement <4 x float> %131, i64 2, !dbg !91
  %mul318.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1663, 0x3FC2776C60000000, !dbg !92
  %146 = tail call contract noundef float @llvm.minnum.f32(float %mul318.6.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.6.1 = fcmp contract olt float %146, -1.260000e+02, !dbg !97
  %cond.i.i814.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.6.1 = fadd contract float %146, %cond.i.i814.6.1, !dbg !97
  %147 = tail call contract float @llvm.exp2.f32(float %add.i.i815.6.1), !dbg !97
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %147, !dbg !97
  %scores.sroa.90.28.vec.extract1688 = extractelement <4 x float> %131, i64 3, !dbg !91
  %mul318.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1688, 0x3FC2776C60000000, !dbg !92
  %148 = tail call contract noundef float @llvm.minnum.f32(float %mul318.7.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.7.1 = fcmp contract olt float %148, -1.260000e+02, !dbg !97
  %cond.i.i814.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i815.7.1 = fadd contract float %148, %cond.i.i814.7.1, !dbg !97
  %149 = tail call contract float @llvm.exp2.f32(float %add.i.i815.7.1), !dbg !97
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %149, !dbg !97
  %add338.1944 = fadd contract float %mul.i.i.1943, 0.000000e+00, !dbg !100
  %add338.1.1 = fadd contract float %add338.1944, %mul.i.i.4.1, !dbg !100
  %add338.2.1 = fadd contract float %add338.1.1, %mul.i.i.1.1, !dbg !100
  %add338.3.1 = fadd contract float %add338.2.1, %mul.i.i.5.1, !dbg !100
  %add338.4.1 = fadd contract float %add338.3.1, %mul.i.i.2.1, !dbg !100
  %add338.5.1 = fadd contract float %add338.4.1, %mul.i.i.6.1, !dbg !100
  %add338.6.1 = fadd contract float %add338.5.1, %mul.i.i.3.1, !dbg !100
  %add338.7.1 = fadd contract float %add338.6.1, %mul.i.i.7.1, !dbg !100
  %150 = bitcast float %add338.7.1 to i32, !dbg !101
  %151 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !112
  %152 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %151) #11, !dbg !117
  %xor.i.i.1 = xor i32 %152, 32, !dbg !118
  %153 = and i32 %152, -64, !dbg !119
  %and.i.i.1 = add nsw i32 %153, 64, !dbg !119
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1, !dbg !120
  %cond.i.i816.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %152, !dbg !121
  %shl.i.i.1 = shl i32 %cond.i.i816.1, 2, !dbg !122
  %154 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %150), !dbg !123
  %155 = bitcast i32 %154 to float, !dbg !124
  %add.i.1 = fadd contract float %add338.7.1, %155, !dbg !125
  %156 = bitcast float %add.i.1 to i32, !dbg !128
  %157 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !135
  %158 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %157) #11, !dbg !138
  %xor.i.i817.1 = xor i32 %158, 16, !dbg !139
  %159 = and i32 %158, -64, !dbg !140
  %and.i.i818.1 = add nsw i32 %159, 64, !dbg !140
  %cmp.not.i.i819.1 = icmp slt i32 %xor.i.i817.1, %and.i.i818.1, !dbg !141
  %cond.i.i820.1 = select i1 %cmp.not.i.i819.1, i32 %xor.i.i817.1, i32 %158, !dbg !142
  %shl.i.i821.1 = shl i32 %cond.i.i820.1, 2, !dbg !143
  %160 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i821.1, i32 %156), !dbg !144
  %161 = bitcast i32 %160 to float, !dbg !145
  %add.i.i.1 = fadd contract float %add.i.1, %161, !dbg !146
  %cmp347.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00, !dbg !148
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1, !dbg !149
  %condval_8.0.1 = select i1 %cmp347.1, float %div.1, float 0.000000e+00, !dbg !149
  %mul360.1945 = fmul contract float %condval_8.0.1, %mul.i.i.1943, !dbg !150
  %mul360.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1, !dbg !150
  %mul360.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1, !dbg !150
  %mul360.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1, !dbg !150
  %mul360.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1, !dbg !150
  %mul360.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1, !dbg !150
  %mul360.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1, !dbg !150
  %mul360.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1, !dbg !150
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.1945), !dbg !151
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.1.1), !dbg !151
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.2.1), !dbg !151
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.3.1), !dbg !151
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.4.1), !dbg !151
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.5.1), !dbg !151
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.6.1), !dbg !151
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.7.1), !dbg !151
  fence syncscope("warp") release, !dbg !160
  tail call void @llvm.mxc.barrier.warp(), !dbg !163
  fence syncscope("warp") acquire, !dbg !164
  %170 = insertelement <4 x i16> poison, i16 %162, i64 0, !dbg !165
  %171 = insertelement <4 x i16> %170, i16 %163, i64 1, !dbg !165
  %172 = insertelement <4 x i16> %171, i16 %164, i64 2, !dbg !165
  %173 = insertelement <4 x i16> %172, i16 %165, i64 3, !dbg !165
  %174 = bitcast <4 x i16> %173 to <4 x half>, !dbg !165
  %175 = insertelement <4 x i16> poison, i16 %166, i64 0, !dbg !165
  %176 = insertelement <4 x i16> %175, i16 %167, i64 1, !dbg !165
  %177 = insertelement <4 x i16> %176, i16 %168, i64 2, !dbg !165
  %178 = insertelement <4 x i16> %177, i16 %169, i64 3, !dbg !165
  %179 = bitcast <4 x i16> %178 to <4 x half>, !dbg !165
  br label %if.end392.1, !dbg !166

if.end392.1:                                      ; preds = %if.end139.1, %if.end48.preheader.1, %if.end392
  %v.sroa.48.3 = phi <4 x half> [ %v.sroa.48.1, %if.end392 ], [ %v.sroa.48.112.copyload1859, %if.end139.1 ], [ %v.sroa.48.1, %if.end48.preheader.1 ]
  %v.sroa.44.3 = phi <4 x half> [ %v.sroa.44.1, %if.end392 ], [ %v.sroa.44.112.copyload1858, %if.end139.1 ], [ %v.sroa.44.1, %if.end48.preheader.1 ]
  %v.sroa.42.3 = phi <4 x half> [ %v.sroa.42.1, %if.end392 ], [ %v.sroa.42.96.copyload1855, %if.end139.1 ], [ %v.sroa.42.1, %if.end48.preheader.1 ]
  %v.sroa.38.3 = phi <4 x half> [ %v.sroa.38.1, %if.end392 ], [ %v.sroa.38.96.copyload1854, %if.end139.1 ], [ %v.sroa.38.1, %if.end48.preheader.1 ]
  %v.sroa.36.3 = phi <4 x half> [ %v.sroa.36.1, %if.end392 ], [ %v.sroa.36.80.copyload1851, %if.end139.1 ], [ %v.sroa.36.1, %if.end48.preheader.1 ]
  %v.sroa.32.3 = phi <4 x half> [ %v.sroa.32.1, %if.end392 ], [ %v.sroa.32.80.copyload1850, %if.end139.1 ], [ %v.sroa.32.1, %if.end48.preheader.1 ]
  %v.sroa.30.3 = phi <4 x half> [ %v.sroa.30.1, %if.end392 ], [ %v.sroa.30.64.copyload1847, %if.end139.1 ], [ %v.sroa.30.1, %if.end48.preheader.1 ]
  %v.sroa.26.3 = phi <4 x half> [ %v.sroa.26.1, %if.end392 ], [ %v.sroa.26.64.copyload1846, %if.end139.1 ], [ %v.sroa.26.1, %if.end48.preheader.1 ]
  %v.sroa.24.3 = phi <4 x half> [ %v.sroa.24.1, %if.end392 ], [ %v.sroa.24.48.copyload1843, %if.end139.1 ], [ %v.sroa.24.1, %if.end48.preheader.1 ]
  %v.sroa.20.3 = phi <4 x half> [ %v.sroa.20.1, %if.end392 ], [ %v.sroa.20.48.copyload1842, %if.end139.1 ], [ %v.sroa.20.1, %if.end48.preheader.1 ]
  %v.sroa.18.3 = phi <4 x half> [ %v.sroa.18.1, %if.end392 ], [ %v.sroa.18.32.copyload1839, %if.end139.1 ], [ %v.sroa.18.1, %if.end48.preheader.1 ]
  %v.sroa.14.3 = phi <4 x half> [ %v.sroa.14.1, %if.end392 ], [ %v.sroa.14.32.copyload1838, %if.end139.1 ], [ %v.sroa.14.1, %if.end48.preheader.1 ]
  %v.sroa.12.3 = phi <4 x half> [ %v.sroa.12.1, %if.end392 ], [ %v.sroa.12.16.copyload1835, %if.end139.1 ], [ %v.sroa.12.1, %if.end48.preheader.1 ]
  %v.sroa.8.3 = phi <4 x half> [ %v.sroa.8.1, %if.end392 ], [ %v.sroa.8.16.copyload1834, %if.end139.1 ], [ %v.sroa.8.1, %if.end48.preheader.1 ]
  %v.sroa.6.3 = phi <4 x half> [ %v.sroa.6.1, %if.end392 ], [ %v.sroa.6.0.copyload1831, %if.end139.1 ], [ %v.sroa.6.1, %if.end48.preheader.1 ]
  %v.sroa.0.3 = phi <4 x half> [ %v.sroa.0.1, %if.end392 ], [ %v.sroa.0.0.copyload1829, %if.end139.1 ], [ %v.sroa.0.1, %if.end48.preheader.1 ]
  %180 = phi <4 x half> [ undef, %if.end392 ], [ %179, %if.end139.1 ], [ undef, %if.end48.preheader.1 ]
  %181 = phi <4 x half> [ undef, %if.end392 ], [ %174, %if.end139.1 ], [ undef, %if.end48.preheader.1 ]
  %shr428 = lshr i64 %2, 32
  %conv429 = trunc nuw i64 %shr428 to i32
  %cmp430 = icmp sgt i64 %2, -1
  %cmp434 = icmp slt i32 %conv429, 32
  %or.cond790 = select i1 %cmp430, i1 %cmp434, i1 false
  %mul438 = shl nsw i32 %conv429, 5
  %mul569 = and i32 %10, 4
  %mul624 = and i32 %8, 8064
  %invariant.gep867 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul624
  %182 = shl nuw nsw i32 %0, 18
  %mul639 = and i32 %182, 2145386496
  %add643 = add nsw i32 %8, -2048
  %mul640 = add nsw i32 %add643, %mul639
  %183 = tail call i32 @llvm.umin.i32(i32 %conv, i32 1024)
  %cmp439 = icmp slt i32 %mul438, %183
  %or.cond833 = select i1 %or.cond790, i1 %cmp439, i1 false, !dbg !169
  br i1 %or.cond833, label %for.cond444.preheader, label %if.end545, !dbg !169

for.cond444.preheader:                            ; preds = %if.end392.1
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %97, <4 x float> zeroinitializer), !dbg !170
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %96, <4 x float> %184), !dbg !170
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %96, <4 x float> %185), !dbg !170
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %96, <4 x float> %186), !dbg !170
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %96, <4 x float> %187), !dbg !170
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %96, <4 x float> %188), !dbg !170
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %96, <4 x float> %189), !dbg !170
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %96, <4 x float> %190), !dbg !170
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %96, <4 x float> %191), !dbg !170
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %192, i64 0, !dbg !171
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !172
  %output_reg.sroa.0.0.insert.ext = zext i16 %200 to i64, !dbg !176
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %192, i64 1, !dbg !171
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !172
  %output_reg.sroa.0.2.insert.ext = zext i16 %201 to i64, !dbg !176
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !176
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !176
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %192, i64 2, !dbg !171
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !172
  %output_reg.sroa.0.4.insert.ext = zext i16 %202 to i64, !dbg !176
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !176
  %output_reg.sroa.0.4.insert.insert1212 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !176
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %192, i64 3, !dbg !171
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !172
  %output_reg.sroa.0.6.insert.ext = zext i16 %203 to i64, !dbg !176
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !176
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1212, %output_reg.sroa.0.6.insert.shift, !dbg !176
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %193, i64 0, !dbg !171
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract), !dbg !172
  %output_reg.sroa.16.8.insert.ext = zext i16 %204 to i64, !dbg !176
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %193, i64 1, !dbg !171
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract), !dbg !172
  %output_reg.sroa.16.10.insert.ext = zext i16 %205 to i64, !dbg !176
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16, !dbg !176
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext, !dbg !176
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %193, i64 2, !dbg !171
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract), !dbg !172
  %output_reg.sroa.16.12.insert.ext = zext i16 %206 to i64, !dbg !176
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32, !dbg !176
  %output_reg.sroa.16.12.insert.insert1244 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift, !dbg !176
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %193, i64 3, !dbg !171
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract), !dbg !172
  %output_reg.sroa.16.14.insert.ext = zext i16 %207 to i64, !dbg !176
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48, !dbg !176
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1244, %output_reg.sroa.16.14.insert.shift, !dbg !176
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %194, i64 0, !dbg !171
  %208 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract), !dbg !172
  %output_reg.sroa.30.16.insert.ext = zext i16 %208 to i64, !dbg !176
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %194, i64 1, !dbg !171
  %209 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract), !dbg !172
  %output_reg.sroa.30.18.insert.ext = zext i16 %209 to i64, !dbg !176
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16, !dbg !176
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext, !dbg !176
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %194, i64 2, !dbg !171
  %210 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract), !dbg !172
  %output_reg.sroa.30.20.insert.ext = zext i16 %210 to i64, !dbg !176
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32, !dbg !176
  %output_reg.sroa.30.20.insert.insert1276 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift, !dbg !176
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %194, i64 3, !dbg !171
  %211 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract), !dbg !172
  %output_reg.sroa.30.22.insert.ext = zext i16 %211 to i64, !dbg !176
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48, !dbg !176
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1276, %output_reg.sroa.30.22.insert.shift, !dbg !176
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %195, i64 0, !dbg !171
  %212 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract), !dbg !172
  %output_reg.sroa.44.24.insert.ext = zext i16 %212 to i64, !dbg !176
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %195, i64 1, !dbg !171
  %213 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract), !dbg !172
  %output_reg.sroa.44.26.insert.ext = zext i16 %213 to i64, !dbg !176
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16, !dbg !176
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext, !dbg !176
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %195, i64 2, !dbg !171
  %214 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract), !dbg !172
  %output_reg.sroa.44.28.insert.ext = zext i16 %214 to i64, !dbg !176
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32, !dbg !176
  %output_reg.sroa.44.28.insert.insert1308 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift, !dbg !176
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %195, i64 3, !dbg !171
  %215 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract), !dbg !172
  %output_reg.sroa.44.30.insert.ext = zext i16 %215 to i64, !dbg !176
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48, !dbg !176
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1308, %output_reg.sroa.44.30.insert.shift, !dbg !176
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %196, i64 0, !dbg !171
  %216 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract), !dbg !172
  %output_reg.sroa.58.32.insert.ext = zext i16 %216 to i64, !dbg !176
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %196, i64 1, !dbg !171
  %217 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract), !dbg !172
  %output_reg.sroa.58.34.insert.ext = zext i16 %217 to i64, !dbg !176
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16, !dbg !176
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext, !dbg !176
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %196, i64 2, !dbg !171
  %218 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract), !dbg !172
  %output_reg.sroa.58.36.insert.ext = zext i16 %218 to i64, !dbg !176
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32, !dbg !176
  %output_reg.sroa.58.36.insert.insert1340 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift, !dbg !176
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %196, i64 3, !dbg !171
  %219 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract), !dbg !172
  %output_reg.sroa.58.38.insert.ext = zext i16 %219 to i64, !dbg !176
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48, !dbg !176
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1340, %output_reg.sroa.58.38.insert.shift, !dbg !176
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %197, i64 0, !dbg !171
  %220 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract), !dbg !172
  %output_reg.sroa.72.40.insert.ext = zext i16 %220 to i64, !dbg !176
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %197, i64 1, !dbg !171
  %221 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract), !dbg !172
  %output_reg.sroa.72.42.insert.ext = zext i16 %221 to i64, !dbg !176
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16, !dbg !176
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext, !dbg !176
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %197, i64 2, !dbg !171
  %222 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract), !dbg !172
  %output_reg.sroa.72.44.insert.ext = zext i16 %222 to i64, !dbg !176
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32, !dbg !176
  %output_reg.sroa.72.44.insert.insert1372 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift, !dbg !176
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %197, i64 3, !dbg !171
  %223 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract), !dbg !172
  %output_reg.sroa.72.46.insert.ext = zext i16 %223 to i64, !dbg !176
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48, !dbg !176
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1372, %output_reg.sroa.72.46.insert.shift, !dbg !176
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %198, i64 0, !dbg !171
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract), !dbg !172
  %output_reg.sroa.86.48.insert.ext = zext i16 %224 to i64, !dbg !176
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %198, i64 1, !dbg !171
  %225 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract), !dbg !172
  %output_reg.sroa.86.50.insert.ext = zext i16 %225 to i64, !dbg !176
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16, !dbg !176
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext, !dbg !176
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %198, i64 2, !dbg !171
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract), !dbg !172
  %output_reg.sroa.86.52.insert.ext = zext i16 %226 to i64, !dbg !176
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32, !dbg !176
  %output_reg.sroa.86.52.insert.insert1404 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift, !dbg !176
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %198, i64 3, !dbg !171
  %227 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract), !dbg !172
  %output_reg.sroa.86.54.insert.ext = zext i16 %227 to i64, !dbg !176
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48, !dbg !176
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1404, %output_reg.sroa.86.54.insert.shift, !dbg !176
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %199, i64 0, !dbg !171
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract), !dbg !172
  %output_reg.sroa.100.56.insert.ext = zext i16 %228 to i64, !dbg !176
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %199, i64 1, !dbg !171
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract), !dbg !172
  %output_reg.sroa.100.58.insert.ext = zext i16 %229 to i64, !dbg !176
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16, !dbg !176
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext, !dbg !176
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %199, i64 2, !dbg !171
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract), !dbg !172
  %output_reg.sroa.100.60.insert.ext = zext i16 %230 to i64, !dbg !176
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32, !dbg !176
  %output_reg.sroa.100.60.insert.insert1436 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift, !dbg !176
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %199, i64 3, !dbg !171
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract), !dbg !172
  %output_reg.sroa.100.62.insert.ext = zext i16 %231 to i64, !dbg !176
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48, !dbg !176
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1436, %output_reg.sroa.100.62.insert.shift, !dbg !176
  br label %if.end545, !dbg !177

if.end545:                                        ; preds = %if.end392.1, %for.cond444.preheader
  %output_reg.sroa.100.0 = phi i64 [ %output_reg.sroa.100.62.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  %output_reg.sroa.86.0 = phi i64 [ %output_reg.sroa.86.54.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  %output_reg.sroa.72.0 = phi i64 [ %output_reg.sroa.72.46.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  %output_reg.sroa.58.0 = phi i64 [ %output_reg.sroa.58.38.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.30.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.22.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.14.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ], !dbg !180
  fence syncscope("warp") release, !dbg !177
  tail call void @llvm.mxc.barrier.warp(), !dbg !181
  fence syncscope("warp") acquire, !dbg !182
  %xor563 = xor i32 %shr158, %and183, !dbg !183
  %mul564 = shl nuw nsw i32 %xor563, 3, !dbg !184
  %add565 = add nuw nsw i32 %mul564, %mul177, !dbg !185
  %add570 = or disjoint i32 %add565, %mul569, !dbg !186
  %add.ptr572 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570, !dbg !187
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr572, align 8, !dbg !188
  %add560.1 = add nuw nsw i32 %shr158, 2, !dbg !189
  %xor563.1 = xor i32 %add560.1, %and183, !dbg !183
  %mul564.1 = shl nuw nsw i32 %xor563.1, 3, !dbg !184
  %add565.1 = add nuw nsw i32 %mul564.1, %mul177, !dbg !185
  %add570.1 = or disjoint i32 %add565.1, %mul569, !dbg !186
  %add.ptr572.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.1, !dbg !187
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr572.1, align 8, !dbg !188
  %add560.2 = add nuw nsw i32 %shr158, 4, !dbg !189
  %xor563.2 = xor i32 %add560.2, %and183, !dbg !183
  %mul564.2 = shl nuw nsw i32 %xor563.2, 3, !dbg !184
  %add565.2 = add nuw nsw i32 %mul564.2, %mul177, !dbg !185
  %add570.2 = or disjoint i32 %add565.2, %mul569, !dbg !186
  %add.ptr572.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.2, !dbg !187
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr572.2, align 8, !dbg !188
  %add560.3 = add nuw nsw i32 %shr158, 6, !dbg !189
  %xor563.3 = xor i32 %add560.3, %and183, !dbg !183
  %mul564.3 = shl nuw nsw i32 %xor563.3, 3, !dbg !184
  %add565.3 = add nuw nsw i32 %mul564.3, %mul177, !dbg !185
  %add570.3 = or disjoint i32 %add565.3, %mul569, !dbg !186
  %add.ptr572.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.3, !dbg !187
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr572.3, align 8, !dbg !188
  %add560.4 = add nuw nsw i32 %shr158, 8, !dbg !189
  %xor563.4 = xor i32 %add560.4, %and183, !dbg !183
  %mul564.4 = shl nuw nsw i32 %xor563.4, 3, !dbg !184
  %add565.4 = add nuw nsw i32 %mul564.4, %mul177, !dbg !185
  %add570.4 = or disjoint i32 %add565.4, %mul569, !dbg !186
  %add.ptr572.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.4, !dbg !187
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr572.4, align 8, !dbg !188
  %add560.5 = add nuw nsw i32 %shr158, 10, !dbg !189
  %xor563.5 = xor i32 %add560.5, %and183, !dbg !183
  %mul564.5 = shl nuw nsw i32 %xor563.5, 3, !dbg !184
  %add565.5 = add nuw nsw i32 %mul564.5, %mul177, !dbg !185
  %add570.5 = or disjoint i32 %add565.5, %mul569, !dbg !186
  %add.ptr572.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.5, !dbg !187
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr572.5, align 8, !dbg !188
  %add560.6 = add nuw nsw i32 %shr158, 12, !dbg !189
  %xor563.6 = xor i32 %add560.6, %and183, !dbg !183
  %mul564.6 = shl nuw nsw i32 %xor563.6, 3, !dbg !184
  %add565.6 = add nuw nsw i32 %mul564.6, %mul177, !dbg !185
  %add570.6 = or disjoint i32 %add565.6, %mul569, !dbg !186
  %add.ptr572.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.6, !dbg !187
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr572.6, align 8, !dbg !188
  %add560.7 = add nuw nsw i32 %shr158, 14, !dbg !189
  %xor563.7 = xor i32 %add560.7, %and183, !dbg !183
  %mul564.7 = shl nuw nsw i32 %xor563.7, 3, !dbg !184
  %add565.7 = add nuw nsw i32 %mul564.7, %mul177, !dbg !185
  %add570.7 = or disjoint i32 %add565.7, %mul569, !dbg !186
  %add.ptr572.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.7, !dbg !187
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr572.7, align 8, !dbg !188
  fence syncscope("warp") release, !dbg !190
  tail call void @llvm.mxc.barrier.warp(), !dbg !193
  fence syncscope("warp") acquire, !dbg !194
  %xor632 = xor i32 %shr180, %and183, !dbg !195
  %add.ptr636.idx = shl nuw nsw i32 %xor632, 4, !dbg !196
  %add.ptr636 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 %add.ptr636.idx, !dbg !196
  %condval_13.0 = shl nuw nsw i32 %183, 11, !dbg !197
  %add646 = add i32 %mul640, %condval_13.0, !dbg !198
  %idx.ext647 = sext i32 %add646 to i64, !dbg !199
  %add.ptr648 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  %add631.1 = add nuw nsw i32 %shr180, 4, !dbg !203
  %xor632.1 = xor i32 %add631.1, %and183, !dbg !195
  %gep868.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 1024, !dbg !196
  %add.ptr636.idx.1 = shl nuw nsw i32 %xor632.1, 4, !dbg !196
  %add.ptr636.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.1, i32 %add.ptr636.idx.1, !dbg !196
  %add641.1 = add nsw i32 %mul640, 512, !dbg !204
  %add646.1 = add i32 %add641.1, %condval_13.0, !dbg !198
  %idx.ext647.1 = sext i32 %add646.1 to i64, !dbg !199
  %add.ptr648.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.1, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.1, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  %add631.2 = add nuw nsw i32 %shr180, 8, !dbg !203
  %xor632.2 = xor i32 %add631.2, %and183, !dbg !195
  %gep868.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 2048, !dbg !196
  %add.ptr636.idx.2 = shl nuw nsw i32 %xor632.2, 4, !dbg !196
  %add.ptr636.2 = getelementptr inbounds i8, ptr addrspace(3) %gep868.2, i32 %add.ptr636.idx.2, !dbg !196
  %add641.2 = add nsw i32 %mul640, 1024, !dbg !204
  %add646.2 = add i32 %add641.2, %condval_13.0, !dbg !198
  %idx.ext647.2 = sext i32 %add646.2 to i64, !dbg !199
  %add.ptr648.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.2, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.2, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  %add631.3 = add nuw nsw i32 %shr180, 12, !dbg !203
  %xor632.3 = xor i32 %add631.3, %and183, !dbg !195
  %gep868.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 3072, !dbg !196
  %add.ptr636.idx.3 = shl nuw nsw i32 %xor632.3, 4, !dbg !196
  %add.ptr636.3 = getelementptr inbounds i8, ptr addrspace(3) %gep868.3, i32 %add.ptr636.idx.3, !dbg !196
  %add641.3 = add nsw i32 %mul640, 1536, !dbg !204
  %add646.3 = add i32 %add641.3, %condval_13.0, !dbg !198
  %idx.ext647.3 = sext i32 %add646.3 to i64, !dbg !199
  %add.ptr648.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.3, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.3, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  fence syncscope("warp") release, !dbg !205
  tail call void @llvm.mxc.barrier.warp(), !dbg !208
  fence syncscope("warp") acquire, !dbg !209
  br i1 %cmp16.not.1, label %if.end657, label %if.then414.1, !dbg !210

if.then414.1:                                     ; preds = %if.end545
  %232 = tail call i32 @llvm.umin.i32(i32 %4, i32 1024)
  %cmp439.1 = icmp slt i32 %mul438, %232
  %or.cond833.1 = select i1 %or.cond790, i1 %cmp439.1, i1 false, !dbg !169
  br i1 %or.cond833.1, label %for.cond444.preheader.1, label %if.end545.1, !dbg !169

for.cond444.preheader.1:                          ; preds = %if.then414.1
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %181, <4 x float> zeroinitializer), !dbg !170
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %180, <4 x float> %233), !dbg !170
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %180, <4 x float> %234), !dbg !170
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %180, <4 x float> %235), !dbg !170
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %180, <4 x float> %236), !dbg !170
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %180, <4 x float> %237), !dbg !170
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %180, <4 x float> %238), !dbg !170
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %180, <4 x float> %239), !dbg !170
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %180, <4 x float> %240), !dbg !170
  %out.sroa.0.0.vec.extract1007 = extractelement <4 x float> %241, i64 0, !dbg !171
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract1007), !dbg !172
  %output_reg.sroa.0.0.insert.ext1199 = zext i16 %249 to i64, !dbg !176
  %out.sroa.0.4.vec.extract1012 = extractelement <4 x float> %241, i64 1, !dbg !171
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract1012), !dbg !172
  %output_reg.sroa.0.2.insert.ext1203 = zext i16 %250 to i64, !dbg !176
  %output_reg.sroa.0.2.insert.shift1204 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1203, 16, !dbg !176
  %output_reg.sroa.0.2.insert.insert1206 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1204, %output_reg.sroa.0.0.insert.ext1199, !dbg !176
  %out.sroa.0.8.vec.extract1017 = extractelement <4 x float> %241, i64 2, !dbg !171
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract1017), !dbg !172
  %output_reg.sroa.0.4.insert.ext1214 = zext i16 %251 to i64, !dbg !176
  %output_reg.sroa.0.4.insert.shift1215 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1214, 32, !dbg !176
  %output_reg.sroa.0.4.insert.insert1217 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1206, %output_reg.sroa.0.4.insert.shift1215, !dbg !176
  %out.sroa.0.12.vec.extract1022 = extractelement <4 x float> %241, i64 3, !dbg !171
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract1022), !dbg !172
  %output_reg.sroa.0.6.insert.ext1219 = zext i16 %252 to i64, !dbg !176
  %output_reg.sroa.0.6.insert.shift1220 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1219, 48, !dbg !176
  %output_reg.sroa.0.6.insert.insert1222 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1217, %output_reg.sroa.0.6.insert.shift1220, !dbg !176
  %out.sroa.26.16.vec.extract1031 = extractelement <4 x float> %242, i64 0, !dbg !171
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract1031), !dbg !172
  %output_reg.sroa.16.8.insert.ext1231 = zext i16 %253 to i64, !dbg !176
  %out.sroa.26.20.vec.extract1036 = extractelement <4 x float> %242, i64 1, !dbg !171
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract1036), !dbg !172
  %output_reg.sroa.16.10.insert.ext1235 = zext i16 %254 to i64, !dbg !176
  %output_reg.sroa.16.10.insert.shift1236 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1235, 16, !dbg !176
  %output_reg.sroa.16.10.insert.insert1238 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1236, %output_reg.sroa.16.8.insert.ext1231, !dbg !176
  %out.sroa.26.24.vec.extract1041 = extractelement <4 x float> %242, i64 2, !dbg !171
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract1041), !dbg !172
  %output_reg.sroa.16.12.insert.ext1246 = zext i16 %255 to i64, !dbg !176
  %output_reg.sroa.16.12.insert.shift1247 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1246, 32, !dbg !176
  %output_reg.sroa.16.12.insert.insert1249 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1238, %output_reg.sroa.16.12.insert.shift1247, !dbg !176
  %out.sroa.26.28.vec.extract1046 = extractelement <4 x float> %242, i64 3, !dbg !171
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract1046), !dbg !172
  %output_reg.sroa.16.14.insert.ext1251 = zext i16 %256 to i64, !dbg !176
  %output_reg.sroa.16.14.insert.shift1252 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1251, 48, !dbg !176
  %output_reg.sroa.16.14.insert.insert1254 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1249, %output_reg.sroa.16.14.insert.shift1252, !dbg !176
  %out.sroa.50.32.vec.extract1055 = extractelement <4 x float> %243, i64 0, !dbg !171
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract1055), !dbg !172
  %output_reg.sroa.30.16.insert.ext1263 = zext i16 %257 to i64, !dbg !176
  %out.sroa.50.36.vec.extract1060 = extractelement <4 x float> %243, i64 1, !dbg !171
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract1060), !dbg !172
  %output_reg.sroa.30.18.insert.ext1267 = zext i16 %258 to i64, !dbg !176
  %output_reg.sroa.30.18.insert.shift1268 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1267, 16, !dbg !176
  %output_reg.sroa.30.18.insert.insert1270 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1268, %output_reg.sroa.30.16.insert.ext1263, !dbg !176
  %out.sroa.50.40.vec.extract1065 = extractelement <4 x float> %243, i64 2, !dbg !171
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract1065), !dbg !172
  %output_reg.sroa.30.20.insert.ext1278 = zext i16 %259 to i64, !dbg !176
  %output_reg.sroa.30.20.insert.shift1279 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1278, 32, !dbg !176
  %output_reg.sroa.30.20.insert.insert1281 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1270, %output_reg.sroa.30.20.insert.shift1279, !dbg !176
  %out.sroa.50.44.vec.extract1070 = extractelement <4 x float> %243, i64 3, !dbg !171
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract1070), !dbg !172
  %output_reg.sroa.30.22.insert.ext1283 = zext i16 %260 to i64, !dbg !176
  %output_reg.sroa.30.22.insert.shift1284 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1283, 48, !dbg !176
  %output_reg.sroa.30.22.insert.insert1286 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1281, %output_reg.sroa.30.22.insert.shift1284, !dbg !176
  %out.sroa.74.48.vec.extract1079 = extractelement <4 x float> %244, i64 0, !dbg !171
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract1079), !dbg !172
  %output_reg.sroa.44.24.insert.ext1295 = zext i16 %261 to i64, !dbg !176
  %out.sroa.74.52.vec.extract1084 = extractelement <4 x float> %244, i64 1, !dbg !171
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract1084), !dbg !172
  %output_reg.sroa.44.26.insert.ext1299 = zext i16 %262 to i64, !dbg !176
  %output_reg.sroa.44.26.insert.shift1300 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1299, 16, !dbg !176
  %output_reg.sroa.44.26.insert.insert1302 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1300, %output_reg.sroa.44.24.insert.ext1295, !dbg !176
  %out.sroa.74.56.vec.extract1089 = extractelement <4 x float> %244, i64 2, !dbg !171
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract1089), !dbg !172
  %output_reg.sroa.44.28.insert.ext1310 = zext i16 %263 to i64, !dbg !176
  %output_reg.sroa.44.28.insert.shift1311 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1310, 32, !dbg !176
  %output_reg.sroa.44.28.insert.insert1313 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1302, %output_reg.sroa.44.28.insert.shift1311, !dbg !176
  %out.sroa.74.60.vec.extract1094 = extractelement <4 x float> %244, i64 3, !dbg !171
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract1094), !dbg !172
  %output_reg.sroa.44.30.insert.ext1315 = zext i16 %264 to i64, !dbg !176
  %output_reg.sroa.44.30.insert.shift1316 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1315, 48, !dbg !176
  %output_reg.sroa.44.30.insert.insert1318 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1313, %output_reg.sroa.44.30.insert.shift1316, !dbg !176
  %out.sroa.98.64.vec.extract1103 = extractelement <4 x float> %245, i64 0, !dbg !171
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract1103), !dbg !172
  %output_reg.sroa.58.32.insert.ext1327 = zext i16 %265 to i64, !dbg !176
  %out.sroa.98.68.vec.extract1108 = extractelement <4 x float> %245, i64 1, !dbg !171
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract1108), !dbg !172
  %output_reg.sroa.58.34.insert.ext1331 = zext i16 %266 to i64, !dbg !176
  %output_reg.sroa.58.34.insert.shift1332 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1331, 16, !dbg !176
  %output_reg.sroa.58.34.insert.insert1334 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1332, %output_reg.sroa.58.32.insert.ext1327, !dbg !176
  %out.sroa.98.72.vec.extract1113 = extractelement <4 x float> %245, i64 2, !dbg !171
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract1113), !dbg !172
  %output_reg.sroa.58.36.insert.ext1342 = zext i16 %267 to i64, !dbg !176
  %output_reg.sroa.58.36.insert.shift1343 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1342, 32, !dbg !176
  %output_reg.sroa.58.36.insert.insert1345 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1334, %output_reg.sroa.58.36.insert.shift1343, !dbg !176
  %out.sroa.98.76.vec.extract1118 = extractelement <4 x float> %245, i64 3, !dbg !171
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract1118), !dbg !172
  %output_reg.sroa.58.38.insert.ext1347 = zext i16 %268 to i64, !dbg !176
  %output_reg.sroa.58.38.insert.shift1348 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1347, 48, !dbg !176
  %output_reg.sroa.58.38.insert.insert1350 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1345, %output_reg.sroa.58.38.insert.shift1348, !dbg !176
  %out.sroa.122.80.vec.extract1127 = extractelement <4 x float> %246, i64 0, !dbg !171
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract1127), !dbg !172
  %output_reg.sroa.72.40.insert.ext1359 = zext i16 %269 to i64, !dbg !176
  %out.sroa.122.84.vec.extract1132 = extractelement <4 x float> %246, i64 1, !dbg !171
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract1132), !dbg !172
  %output_reg.sroa.72.42.insert.ext1363 = zext i16 %270 to i64, !dbg !176
  %output_reg.sroa.72.42.insert.shift1364 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1363, 16, !dbg !176
  %output_reg.sroa.72.42.insert.insert1366 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1364, %output_reg.sroa.72.40.insert.ext1359, !dbg !176
  %out.sroa.122.88.vec.extract1137 = extractelement <4 x float> %246, i64 2, !dbg !171
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract1137), !dbg !172
  %output_reg.sroa.72.44.insert.ext1374 = zext i16 %271 to i64, !dbg !176
  %output_reg.sroa.72.44.insert.shift1375 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1374, 32, !dbg !176
  %output_reg.sroa.72.44.insert.insert1377 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1366, %output_reg.sroa.72.44.insert.shift1375, !dbg !176
  %out.sroa.122.92.vec.extract1142 = extractelement <4 x float> %246, i64 3, !dbg !171
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract1142), !dbg !172
  %output_reg.sroa.72.46.insert.ext1379 = zext i16 %272 to i64, !dbg !176
  %output_reg.sroa.72.46.insert.shift1380 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1379, 48, !dbg !176
  %output_reg.sroa.72.46.insert.insert1382 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1377, %output_reg.sroa.72.46.insert.shift1380, !dbg !176
  %out.sroa.146.96.vec.extract1151 = extractelement <4 x float> %247, i64 0, !dbg !171
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract1151), !dbg !172
  %output_reg.sroa.86.48.insert.ext1391 = zext i16 %273 to i64, !dbg !176
  %out.sroa.146.100.vec.extract1156 = extractelement <4 x float> %247, i64 1, !dbg !171
  %274 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract1156), !dbg !172
  %output_reg.sroa.86.50.insert.ext1395 = zext i16 %274 to i64, !dbg !176
  %output_reg.sroa.86.50.insert.shift1396 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1395, 16, !dbg !176
  %output_reg.sroa.86.50.insert.insert1398 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1396, %output_reg.sroa.86.48.insert.ext1391, !dbg !176
  %out.sroa.146.104.vec.extract1161 = extractelement <4 x float> %247, i64 2, !dbg !171
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract1161), !dbg !172
  %output_reg.sroa.86.52.insert.ext1406 = zext i16 %275 to i64, !dbg !176
  %output_reg.sroa.86.52.insert.shift1407 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1406, 32, !dbg !176
  %output_reg.sroa.86.52.insert.insert1409 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1398, %output_reg.sroa.86.52.insert.shift1407, !dbg !176
  %out.sroa.146.108.vec.extract1166 = extractelement <4 x float> %247, i64 3, !dbg !171
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract1166), !dbg !172
  %output_reg.sroa.86.54.insert.ext1411 = zext i16 %276 to i64, !dbg !176
  %output_reg.sroa.86.54.insert.shift1412 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1411, 48, !dbg !176
  %output_reg.sroa.86.54.insert.insert1414 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1409, %output_reg.sroa.86.54.insert.shift1412, !dbg !176
  %out.sroa.170.112.vec.extract1175 = extractelement <4 x float> %248, i64 0, !dbg !171
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1175), !dbg !172
  %output_reg.sroa.100.56.insert.ext1423 = zext i16 %277 to i64, !dbg !176
  %out.sroa.170.116.vec.extract1180 = extractelement <4 x float> %248, i64 1, !dbg !171
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1180), !dbg !172
  %output_reg.sroa.100.58.insert.ext1427 = zext i16 %278 to i64, !dbg !176
  %output_reg.sroa.100.58.insert.shift1428 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1427, 16, !dbg !176
  %output_reg.sroa.100.58.insert.insert1430 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1428, %output_reg.sroa.100.56.insert.ext1423, !dbg !176
  %out.sroa.170.120.vec.extract1185 = extractelement <4 x float> %248, i64 2, !dbg !171
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1185), !dbg !172
  %output_reg.sroa.100.60.insert.ext1438 = zext i16 %279 to i64, !dbg !176
  %output_reg.sroa.100.60.insert.shift1439 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1438, 32, !dbg !176
  %output_reg.sroa.100.60.insert.insert1441 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1430, %output_reg.sroa.100.60.insert.shift1439, !dbg !176
  %out.sroa.170.124.vec.extract1190 = extractelement <4 x float> %248, i64 3, !dbg !171
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1190), !dbg !172
  %output_reg.sroa.100.62.insert.ext1443 = zext i16 %280 to i64, !dbg !176
  %output_reg.sroa.100.62.insert.shift1444 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1443, 48, !dbg !176
  %output_reg.sroa.100.62.insert.insert1446 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1441, %output_reg.sroa.100.62.insert.shift1444, !dbg !176
  br label %if.end545.1, !dbg !177

if.end545.1:                                      ; preds = %if.then414.1, %for.cond444.preheader.1
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1446, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1414, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1382, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1350, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1318, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1286, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1254, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1222, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ], !dbg !180
  fence syncscope("warp") release, !dbg !177
  tail call void @llvm.mxc.barrier.warp(), !dbg !181
  fence syncscope("warp") acquire, !dbg !182
  %xor563.1985 = xor i32 %shr158, %and183, !dbg !183
  %mul564.1986 = shl nuw nsw i32 %xor563.1985, 3, !dbg !184
  %add565.1987 = add nuw nsw i32 %mul564.1986, %mul177, !dbg !185
  %add570.1988 = or disjoint i32 %add565.1987, %mul569, !dbg !186
  %add.ptr572.1989 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.1988, !dbg !187
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr572.1989, align 8, !dbg !188
  %add560.1.1 = add nuw nsw i32 %shr158, 2, !dbg !189
  %xor563.1.1 = xor i32 %add560.1.1, %and183, !dbg !183
  %mul564.1.1 = shl nuw nsw i32 %xor563.1.1, 3, !dbg !184
  %add565.1.1 = add nuw nsw i32 %mul564.1.1, %mul177, !dbg !185
  %add570.1.1 = or disjoint i32 %add565.1.1, %mul569, !dbg !186
  %add.ptr572.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.1.1, !dbg !187
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr572.1.1, align 8, !dbg !188
  %add560.2.1 = add nuw nsw i32 %shr158, 4, !dbg !189
  %xor563.2.1 = xor i32 %add560.2.1, %and183, !dbg !183
  %mul564.2.1 = shl nuw nsw i32 %xor563.2.1, 3, !dbg !184
  %add565.2.1 = add nuw nsw i32 %mul564.2.1, %mul177, !dbg !185
  %add570.2.1 = or disjoint i32 %add565.2.1, %mul569, !dbg !186
  %add.ptr572.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.2.1, !dbg !187
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr572.2.1, align 8, !dbg !188
  %add560.3.1 = add nuw nsw i32 %shr158, 6, !dbg !189
  %xor563.3.1 = xor i32 %add560.3.1, %and183, !dbg !183
  %mul564.3.1 = shl nuw nsw i32 %xor563.3.1, 3, !dbg !184
  %add565.3.1 = add nuw nsw i32 %mul564.3.1, %mul177, !dbg !185
  %add570.3.1 = or disjoint i32 %add565.3.1, %mul569, !dbg !186
  %add.ptr572.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.3.1, !dbg !187
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr572.3.1, align 8, !dbg !188
  %add560.4.1 = add nuw nsw i32 %shr158, 8, !dbg !189
  %xor563.4.1 = xor i32 %add560.4.1, %and183, !dbg !183
  %mul564.4.1 = shl nuw nsw i32 %xor563.4.1, 3, !dbg !184
  %add565.4.1 = add nuw nsw i32 %mul564.4.1, %mul177, !dbg !185
  %add570.4.1 = or disjoint i32 %add565.4.1, %mul569, !dbg !186
  %add.ptr572.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.4.1, !dbg !187
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr572.4.1, align 8, !dbg !188
  %add560.5.1 = add nuw nsw i32 %shr158, 10, !dbg !189
  %xor563.5.1 = xor i32 %add560.5.1, %and183, !dbg !183
  %mul564.5.1 = shl nuw nsw i32 %xor563.5.1, 3, !dbg !184
  %add565.5.1 = add nuw nsw i32 %mul564.5.1, %mul177, !dbg !185
  %add570.5.1 = or disjoint i32 %add565.5.1, %mul569, !dbg !186
  %add.ptr572.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.5.1, !dbg !187
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr572.5.1, align 8, !dbg !188
  %add560.6.1 = add nuw nsw i32 %shr158, 12, !dbg !189
  %xor563.6.1 = xor i32 %add560.6.1, %and183, !dbg !183
  %mul564.6.1 = shl nuw nsw i32 %xor563.6.1, 3, !dbg !184
  %add565.6.1 = add nuw nsw i32 %mul564.6.1, %mul177, !dbg !185
  %add570.6.1 = or disjoint i32 %add565.6.1, %mul569, !dbg !186
  %add.ptr572.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.6.1, !dbg !187
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr572.6.1, align 8, !dbg !188
  %add560.7.1 = add nuw nsw i32 %shr158, 14, !dbg !189
  %xor563.7.1 = xor i32 %add560.7.1, %and183, !dbg !183
  %mul564.7.1 = shl nuw nsw i32 %xor563.7.1, 3, !dbg !184
  %add565.7.1 = add nuw nsw i32 %mul564.7.1, %mul177, !dbg !185
  %add570.7.1 = or disjoint i32 %add565.7.1, %mul569, !dbg !186
  %add.ptr572.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.7.1, !dbg !187
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr572.7.1, align 8, !dbg !188
  fence syncscope("warp") release, !dbg !190
  tail call void @llvm.mxc.barrier.warp(), !dbg !193
  fence syncscope("warp") acquire, !dbg !194
  %xor632.1992 = xor i32 %shr180, %and183, !dbg !195
  %add.ptr636.idx.1993 = shl nuw nsw i32 %xor632.1992, 4, !dbg !196
  %add.ptr636.1994 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 %add.ptr636.idx.1993, !dbg !196
  %condval_13.0.1995 = shl nuw nsw i32 %232, 11, !dbg !197
  %add646.1996 = add i32 %mul640, %condval_13.0.1995, !dbg !198
  %idx.ext647.1997 = sext i32 %add646.1996 to i64, !dbg !199
  %add.ptr648.1998 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.1997, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.1998, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.1994, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  %add631.1.1 = add nuw nsw i32 %shr180, 4, !dbg !203
  %xor632.1.1 = xor i32 %add631.1.1, %and183, !dbg !195
  %gep868.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 1024, !dbg !196
  %add.ptr636.idx.1.1 = shl nuw nsw i32 %xor632.1.1, 4, !dbg !196
  %add.ptr636.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.1.1, i32 %add.ptr636.idx.1.1, !dbg !196
  %add641.1.1 = add nsw i32 %mul640, 512, !dbg !204
  %add646.1.1 = add i32 %add641.1.1, %condval_13.0.1995, !dbg !198
  %idx.ext647.1.1 = sext i32 %add646.1.1 to i64, !dbg !199
  %add.ptr648.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.1.1, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.1.1, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  %add631.2.1 = add nuw nsw i32 %shr180, 8, !dbg !203
  %xor632.2.1 = xor i32 %add631.2.1, %and183, !dbg !195
  %gep868.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 2048, !dbg !196
  %add.ptr636.idx.2.1 = shl nuw nsw i32 %xor632.2.1, 4, !dbg !196
  %add.ptr636.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.2.1, i32 %add.ptr636.idx.2.1, !dbg !196
  %add641.2.1 = add nsw i32 %mul640, 1024, !dbg !204
  %add646.2.1 = add i32 %add641.2.1, %condval_13.0.1995, !dbg !198
  %idx.ext647.2.1 = sext i32 %add646.2.1 to i64, !dbg !199
  %add.ptr648.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.2.1, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.2.1, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  %add631.3.1 = add nuw nsw i32 %shr180, 12, !dbg !203
  %xor632.3.1 = xor i32 %add631.3.1, %and183, !dbg !195
  %gep868.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 3072, !dbg !196
  %add.ptr636.idx.3.1 = shl nuw nsw i32 %xor632.3.1, 4, !dbg !196
  %add.ptr636.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.3.1, i32 %add.ptr636.idx.3.1, !dbg !196
  %add641.3.1 = add nsw i32 %mul640, 1536, !dbg !204
  %add646.3.1 = add i32 %add641.3.1, %condval_13.0.1995, !dbg !198
  %idx.ext647.3.1 = sext i32 %add646.3.1 to i64, !dbg !199
  %add.ptr648.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.3.1, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.3.1, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  fence syncscope("warp") release, !dbg !205
  tail call void @llvm.mxc.barrier.warp(), !dbg !208
  fence syncscope("warp") acquire, !dbg !209
  br label %if.end657, !dbg !211

if.end657:                                        ; preds = %if.end545, %if.end545.1, %entry
  ret void, !dbg !212
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #9

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
!1 = !DIFile(filename: "/tmp/tmp86m3krnm/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp86m3krnm/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 78, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_y", scope: !44, file: !44, line: 78, type: !7, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 23, column: 37, scope: !40)
!46 = !DILocation(line: 23, column: 49, scope: !40)
!47 = !DILocation(line: 77, column: 3, scope: !48, inlinedAt: !49)
!48 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!49 = distinct !DILocation(line: 23, column: 63, scope: !40)
!50 = !DILocation(line: 23, column: 55, scope: !40)
!51 = !DILocation(line: 23, column: 20, scope: !40)
!52 = !DILocation(line: 24, column: 26, scope: !40)
!53 = !DILocation(line: 24, column: 18, scope: !40)
!54 = !DILocation(line: 24, column: 9, scope: !40)
!55 = !DILocation(line: 24, column: 7, scope: !40)
!56 = !DILocation(line: 26, column: 5, scope: !40)
!57 = !{i32 0, i32 1024}
!58 = !DILocation(line: 69, column: 62, scope: !40)
!59 = !DILocation(line: 57, column: 37, scope: !40)
!60 = !DILocation(line: 57, column: 23, scope: !40)
!61 = !DILocation(line: 61, column: 40, scope: !40)
!62 = !DILocation(line: 74, column: 61, scope: !40)
!63 = !DILocation(line: 74, column: 40, scope: !40)
!64 = !DILocation(line: 79, column: 139, scope: !40)
!65 = !DILocation(line: 79, column: 48, scope: !40)
!66 = !DILocation(line: 79, column: 223, scope: !40)
!67 = !DILocation(line: 79, column: 152, scope: !40)
!68 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "__barrier_warp", scope: !70, file: !70, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!70 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!71 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !73)
!72 = distinct !DISubprogram(name: "__syncwarp", scope: !70, file: !70, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!73 = distinct !DILocation(line: 81, column: 11, scope: !40)
!74 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !71)
!75 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !71)
!76 = !DILocation(line: 84, column: 156, scope: !40)
!77 = !DILocation(line: 84, column: 75, scope: !40)
!78 = !DILocation(line: 84, column: 38, scope: !40)
!79 = !DILocation(line: 84, column: 127, scope: !40)
!80 = !DILocation(line: 95, column: 170, scope: !40)
!81 = !DILocation(line: 95, column: 17, scope: !40)
!82 = !DILocation(line: 100, column: 25, scope: !40)
!83 = !DILocation(line: 95, column: 122, scope: !40)
!84 = !DILocation(line: 95, column: 157, scope: !40)
!85 = !DILocation(line: 106, column: 37, scope: !40)
!86 = !{i32 1, i32 -1, i32 -1}
!87 = !DILocation(line: 113, column: 33, scope: !40)
!88 = !DILocation(line: 116, column: 61, scope: !40)
!89 = !DILocation(line: 116, column: 40, scope: !40)
!90 = !DILocation(line: 120, column: 11, scope: !40)
!91 = !DILocation(line: 121, column: 38, scope: !40)
!92 = !DILocation(line: 121, column: 50, scope: !40)
!93 = !DILocation(line: 354, column: 10, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "min", scope: !95, file: !95, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!96 = distinct !DILocation(line: 121, column: 33, scope: !40)
!97 = !DILocation(line: 285, column: 49, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "exp2f", scope: !95, file: !95, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 121, column: 27, scope: !40)
!100 = !DILocation(line: 126, column: 34, scope: !40)
!101 = !DILocation(line: 1018, column: 9, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !70, file: !70, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 396, column: 10, scope: !104, inlinedAt: !106)
!104 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !105, file: !105, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!106 = distinct !DILocation(line: 129, column: 24, scope: !107, inlinedAt: !109)
!107 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !108, file: !108, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!109 = distinct !DILocation(line: 101, column: 14, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "run<float>", scope: !108, file: !108, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 128, column: 22, scope: !40)
!112 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "__lane_id", scope: !70, file: !70, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !70, file: !70, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!116 = distinct !DILocation(line: 1019, column: 11, scope: !102, inlinedAt: !103)
!117 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !114)
!118 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !116)
!119 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !116)
!120 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !116)
!121 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !116)
!122 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !116)
!123 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !116)
!124 = !DILocation(line: 1020, column: 14, scope: !102, inlinedAt: !103)
!125 = !DILocation(line: 25, column: 14, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "operator()<float>", scope: !108, file: !108, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!127 = distinct !DILocation(line: 129, column: 11, scope: !107, inlinedAt: !109)
!128 = !DILocation(line: 1018, column: 9, scope: !102, inlinedAt: !129)
!129 = distinct !DILocation(line: 396, column: 10, scope: !104, inlinedAt: !130)
!130 = distinct !DILocation(line: 129, column: 24, scope: !131, inlinedAt: !132)
!131 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !108, file: !108, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!132 = distinct !DILocation(line: 101, column: 14, scope: !133, inlinedAt: !134)
!133 = distinct !DISubprogram(name: "run<float>", scope: !108, file: !108, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!134 = distinct !DILocation(line: 134, column: 14, scope: !107, inlinedAt: !109)
!135 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !136)
!136 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !137)
!137 = distinct !DILocation(line: 1019, column: 11, scope: !102, inlinedAt: !129)
!138 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !136)
!139 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !137)
!140 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !137)
!141 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !137)
!142 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !137)
!143 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !137)
!144 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !137)
!145 = !DILocation(line: 1020, column: 14, scope: !102, inlinedAt: !129)
!146 = !DILocation(line: 25, column: 14, scope: !126, inlinedAt: !147)
!147 = distinct !DILocation(line: 129, column: 11, scope: !131, inlinedAt: !132)
!148 = !DILocation(line: 130, column: 40, scope: !40)
!149 = !DILocation(line: 130, column: 15, scope: !40)
!150 = !DILocation(line: 138, column: 40, scope: !40)
!151 = !DILocation(line: 75, column: 10, scope: !152, inlinedAt: !154)
!152 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !153, file: !153, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!153 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!154 = distinct !DILocation(line: 984, column: 9, scope: !155, inlinedAt: !157)
!155 = distinct !DISubprogram(name: "__float2half", scope: !156, file: !156, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!156 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!157 = distinct !DILocation(line: 133, column: 53, scope: !158, inlinedAt: !159)
!158 = distinct !DISubprogram(name: "__half", scope: !156, file: !156, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!159 = distinct !DILocation(line: 144, column: 81, scope: !40)
!160 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !161)
!161 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !162)
!162 = distinct !DILocation(line: 147, column: 11, scope: !40)
!163 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !161)
!164 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !161)
!165 = !DILocation(line: 170, column: 23, scope: !40)
!166 = !DILocation(line: 148, column: 9, scope: !40)
!167 = !DILocation(line: 33, column: 13, scope: !40)
!168 = !DILocation(line: 33, column: 11, scope: !40)
!169 = !DILocation(line: 166, column: 64, scope: !40)
!170 = !DILocation(line: 180, column: 36, scope: !40)
!171 = !DILocation(line: 190, column: 73, scope: !40)
!172 = !DILocation(line: 75, column: 10, scope: !152, inlinedAt: !173)
!173 = distinct !DILocation(line: 984, column: 9, scope: !155, inlinedAt: !174)
!174 = distinct !DILocation(line: 133, column: 53, scope: !158, inlinedAt: !175)
!175 = distinct !DILocation(line: 190, column: 65, scope: !40)
!176 = !DILocation(line: 190, column: 62, scope: !40)
!177 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !178)
!178 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !179)
!179 = distinct !DILocation(line: 200, column: 9, scope: !40)
!180 = !DILocation(line: 0, scope: !40)
!181 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !178)
!182 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !178)
!183 = !DILocation(line: 203, column: 129, scope: !40)
!184 = !DILocation(line: 203, column: 158, scope: !40)
!185 = !DILocation(line: 203, column: 84, scope: !40)
!186 = !DILocation(line: 203, column: 164, scope: !40)
!187 = !DILocation(line: 203, column: 46, scope: !40)
!188 = !DILocation(line: 203, column: 207, scope: !40)
!189 = !DILocation(line: 203, column: 100, scope: !40)
!190 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !191)
!191 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !192)
!192 = distinct !DILocation(line: 205, column: 9, scope: !40)
!193 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !191)
!194 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !191)
!195 = !DILocation(line: 227, column: 261, scope: !40)
!196 = !DILocation(line: 227, column: 177, scope: !40)
!197 = !DILocation(line: 227, column: 86, scope: !40)
!198 = !DILocation(line: 227, column: 111, scope: !40)
!199 = !DILocation(line: 227, column: 30, scope: !40)
!200 = !DILocation(line: 227, column: 140, scope: !40)
!201 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!202 = !{i32 0, i32 -1, i32 -1, i32 -1}
!203 = !DILocation(line: 227, column: 275, scope: !40)
!204 = !DILocation(line: 227, column: 72, scope: !40)
!205 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !206)
!206 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !207)
!207 = distinct !DILocation(line: 230, column: 9, scope: !40)
!208 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !206)
!209 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !206)
!210 = !DILocation(line: 159, column: 11, scope: !40)
!211 = !DILocation(line: 231, column: 7, scope: !40)
!212 = !DILocation(line: 234, column: 1, scope: !40)
