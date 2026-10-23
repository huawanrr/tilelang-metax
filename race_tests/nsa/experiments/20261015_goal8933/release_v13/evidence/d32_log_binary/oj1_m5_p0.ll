; ModuleID = 'experiments/20261015_goal8933/d32_log_binary/oj1_m5_p0.bc'
source_filename = "/tmp/tmp_icgtbnu/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !42, !range !29
  %mul = shl nsw i32 %0, 9, !dbg !46
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !dbg !47, !range !50
  %and = shl nuw nsw i32 %1, 5, !dbg !51
  %mul7 = and i32 %and, 480, !dbg !51
  %add = or disjoint i32 %mul7, %mul, !dbg !52
  %2 = lshr i32 %1, 1, !dbg !53
  %mul9 = and i32 %2, 504, !dbg !53
  %add10 = add nuw nsw i32 %add, %mul9, !dbg !54
  %idx.ext = zext nneg i32 %add10 to i64, !dbg !55
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %idx.ext, !dbg !55
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !56
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !56
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !56
  fence syncscope("warp") release, !dbg !57
  tail call void @llvm.mxc.barrier.warp(), !dbg !63
  fence syncscope("warp") acquire, !dbg !64
  %idxprom = zext nneg i32 %0 to i64, !dbg !65
  %arrayidx13 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !65
  %3 = load i32, ptr addrspace(1) %arrayidx13, align 4, !dbg !65, !tbaa !30
  %cmp20 = icmp ugt i32 %3, 3
  %shr23 = lshr i32 %0, 4
  %cmp24.not = icmp ugt i32 %3, %shr23
  %or.cond309 = or i1 %cmp20, %cmp24.not, !dbg !66
  br i1 %or.cond309, label %entry.if.end193_crit_edge, label %for.cond25.preheader, !dbg !66

entry.if.end193_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  %.pre374 = and i32 %.pre, 252
  br label %if.end193, !dbg !66

for.cond25.preheader:                             ; preds = %entry
  %mul30 = shl nuw nsw i32 %3, 9
  %4 = shl nuw nsw i32 %1, 3
  %mul33 = and i32 %4, 8064
  %add34 = add nuw nsw i32 %mul30, %mul33
  %and42 = and i32 %1, 15
  %add43 = or disjoint i32 %add34, %and42, !dbg !67
  %idxprom44 = zext nneg i32 %add43 to i64, !dbg !68
  %arrayidx45 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44, !dbg !68
  %5 = load half, ptr addrspace(4) %arrayidx45, align 2, !dbg !69, !tbaa !70
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %5, i64 0, !dbg !69
  %add37.1 = or disjoint i32 %add34, %and42, !dbg !67
  %add43.1 = or disjoint i32 %add37.1, 32, !dbg !67
  %idxprom44.1 = zext nneg i32 %add43.1 to i64, !dbg !68
  %arrayidx45.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.1, !dbg !68
  %6 = load half, ptr addrspace(4) %arrayidx45.1, align 2, !dbg !69, !tbaa !70
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %6, i64 1, !dbg !69
  %add37.2 = or disjoint i32 %add34, %and42, !dbg !67
  %add43.2 = or disjoint i32 %add37.2, 64, !dbg !67
  %idxprom44.2 = zext nneg i32 %add43.2 to i64, !dbg !68
  %arrayidx45.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.2, !dbg !68
  %7 = load half, ptr addrspace(4) %arrayidx45.2, align 2, !dbg !69, !tbaa !70
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %7, i64 2, !dbg !69
  %add37.3 = or disjoint i32 %add34, %and42, !dbg !67
  %add43.3 = or disjoint i32 %add37.3, 96, !dbg !67
  %idxprom44.3 = zext nneg i32 %add43.3 to i64, !dbg !68
  %arrayidx45.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.3, !dbg !68
  %8 = load half, ptr addrspace(4) %arrayidx45.3, align 2, !dbg !69, !tbaa !70
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %8, i64 3, !dbg !69
  %add40.4 = or disjoint i32 %add34, %and42, !dbg !67
  %add43.4 = or disjoint i32 %add40.4, 16, !dbg !67
  %idxprom44.4 = zext nneg i32 %add43.4 to i64, !dbg !68
  %arrayidx45.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.4, !dbg !68
  %9 = load half, ptr addrspace(4) %arrayidx45.4, align 2, !dbg !69, !tbaa !70
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %9, i64 0, !dbg !69
  %add40.5 = or disjoint i32 %add34, %and42, !dbg !67
  %add43.5 = or disjoint i32 %add40.5, 48, !dbg !67
  %idxprom44.5 = zext nneg i32 %add43.5 to i64, !dbg !68
  %arrayidx45.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.5, !dbg !68
  %10 = load half, ptr addrspace(4) %arrayidx45.5, align 2, !dbg !69, !tbaa !70
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %10, i64 1, !dbg !69
  %add40.6 = or disjoint i32 %add34, %and42, !dbg !67
  %add43.6 = or disjoint i32 %add40.6, 80, !dbg !67
  %idxprom44.6 = zext nneg i32 %add43.6 to i64, !dbg !68
  %arrayidx45.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.6, !dbg !68
  %11 = load half, ptr addrspace(4) %arrayidx45.6, align 2, !dbg !69, !tbaa !70
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %11, i64 2, !dbg !69
  %add40.7 = or disjoint i32 %add34, %and42, !dbg !67
  %add43.7 = or disjoint i32 %add40.7, 112, !dbg !67
  %idxprom44.7 = zext nneg i32 %add43.7 to i64, !dbg !68
  %arrayidx45.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.7, !dbg !68
  %12 = load half, ptr addrspace(4) %arrayidx45.7, align 2, !dbg !69, !tbaa !70
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %12, i64 3, !dbg !69
  %add55 = add nuw nsw i32 %mul9, %mul7, !dbg !71
  %add59 = add nuw nsw i32 %add55, %mul30, !dbg !72
  %idx.ext60 = zext nneg i32 %add59 to i64, !dbg !73
  %add.ptr61 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %idx.ext60, !dbg !73
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr61, align 16, !dbg !74
  %k.sroa.4.0.add.ptr61.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr61, i64 8, !dbg !74
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr61.sroa_idx, align 8, !dbg !74
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !75, !call_argsrelate !76
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %13), !dbg !75, !call_argsrelate !76
  %mul91 = shl nuw nsw i32 %3, 4
  %15 = lshr i32 %1, 2
  %mul94 = and i32 %15, 252
  %add95 = add nuw nsw i32 %mul91, %mul94
  %cmp98.not = icmp ugt i32 %add95, %0, !dbg !77
  %. = select i1 %cmp98.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %14, i64 0, !dbg !78
  %mul102 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !79
  %16 = tail call contract noundef float @llvm.minnum.f32(float %mul102, float 0x4024CB5EC0000000), !dbg !80
  %17 = tail call contract noundef float @llvm.exp.f32(float %16), !dbg !84
  %mul105 = fmul contract float %., %17, !dbg !87
  %cmp98.not.1.not = icmp ult i32 %add95, %0, !dbg !77
  %..1 = select i1 %cmp98.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %14, i64 1, !dbg !78
  %mul102.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !79
  %18 = tail call contract noundef float @llvm.minnum.f32(float %mul102.1, float 0x4024CB5EC0000000), !dbg !80
  %19 = tail call contract noundef float @llvm.exp.f32(float %18), !dbg !84
  %mul105.1 = fmul contract float %..1, %19, !dbg !87
  %add96.2 = or disjoint i32 %add95, 2, !dbg !88
  %cmp98.not.2 = icmp ugt i32 %add96.2, %0, !dbg !77
  %..2 = select i1 %cmp98.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %14, i64 2, !dbg !78
  %mul102.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !79
  %20 = tail call contract noundef float @llvm.minnum.f32(float %mul102.2, float 0x4024CB5EC0000000), !dbg !80
  %21 = tail call contract noundef float @llvm.exp.f32(float %20), !dbg !84
  %mul105.2 = fmul contract float %..2, %21, !dbg !87
  %add96.3 = or disjoint i32 %add95, 3, !dbg !88
  %cmp98.not.3 = icmp ugt i32 %add96.3, %0, !dbg !77
  %..3 = select i1 %cmp98.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %14, i64 3, !dbg !78
  %mul102.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !79
  %22 = tail call contract noundef float @llvm.minnum.f32(float %mul102.3, float 0x4024CB5EC0000000), !dbg !80
  %23 = tail call contract noundef float @llvm.exp.f32(float %22), !dbg !84
  %mul105.3 = fmul contract float %..3, %23, !dbg !87
  %add120 = fadd contract float %mul105, 0.000000e+00, !dbg !89
  %add120.1 = fadd contract float %add120, %mul105.1, !dbg !89
  %add120.2 = fadd contract float %add120.1, %mul105.2, !dbg !89
  %add120.3 = fadd contract float %add120.2, %mul105.3, !dbg !89
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add120.3, <4 x float> zeroinitializer), !dbg !90
  %tiny_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %24, i64 0, !dbg !91
  %cmp138 = fcmp contract ogt float %tiny_sum_out.sroa.0.0.vec.extract, 0.000000e+00, !dbg !92
  %25 = tail call contract noundef float @llvm.log.f32(float %tiny_sum_out.sroa.0.0.vec.extract)
  %mul142 = fneg contract float %25
  %26 = tail call contract noundef float @llvm.exp.f32(float %mul142)
  %condval_1.0 = select i1 %cmp138, float %26, float 0.000000e+00, !dbg !93
  %mul155 = fmul contract float %condval_1.0, %mul105, !dbg !94
  %mul155.1 = fmul contract float %condval_1.0, %mul105.1, !dbg !94
  %mul155.2 = fmul contract float %condval_1.0, %mul105.2, !dbg !94
  %mul155.3 = fmul contract float %condval_1.0, %mul105.3, !dbg !94
  %27 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul155), !dbg !95
  %28 = insertelement <4 x i16> poison, i16 %27, i64 0, !dbg !104
  %29 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul155.1), !dbg !95
  %30 = insertelement <4 x i16> %28, i16 %29, i64 1, !dbg !104
  %31 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul155.2), !dbg !95
  %32 = insertelement <4 x i16> %30, i16 %31, i64 2, !dbg !104
  %33 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul155.3), !dbg !95
  %34 = insertelement <4 x i16> %32, i16 %33, i64 3, !dbg !104
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %34 to <4 x half>, !dbg !104
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !105
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !105
  br label %if.end193, !dbg !106

if.end193:                                        ; preds = %entry.if.end193_crit_edge, %for.cond25.preheader
  %mul236.pre-phi = phi i32 [ %.pre374, %entry.if.end193_crit_edge ], [ %mul94, %for.cond25.preheader ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end193_crit_edge ], [ %35, %for.cond25.preheader ], !dbg !107
  %out.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry.if.end193_crit_edge ], [ %36, %for.cond25.preheader ], !dbg !107
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0, !dbg !108
  %37 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !109
  %result.sroa.0.0.insert.ext = zext i16 %37 to i64, !dbg !113
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1, !dbg !108
  %38 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !109
  %result.sroa.0.2.insert.ext = zext i16 %38 to i64, !dbg !113
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !113
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !113
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2, !dbg !108
  %39 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !109
  %result.sroa.0.4.insert.ext = zext i16 %39 to i64, !dbg !113
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !113
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !113
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3, !dbg !108
  %40 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !109
  %result.sroa.0.6.insert.ext = zext i16 %40 to i64, !dbg !113
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !113
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !113
  %out.sroa.12.16.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 0, !dbg !108
  %41 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.16.vec.extract), !dbg !109
  %result.sroa.7.8.insert.ext = zext i16 %41 to i64, !dbg !113
  %out.sroa.12.20.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 1, !dbg !108
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.20.vec.extract), !dbg !109
  %result.sroa.7.10.insert.ext = zext i16 %42 to i64, !dbg !113
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !113
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !113
  %out.sroa.12.24.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 2, !dbg !108
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.24.vec.extract), !dbg !109
  %result.sroa.7.12.insert.ext = zext i16 %43 to i64, !dbg !113
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !113
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !113
  %out.sroa.12.28.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 3, !dbg !108
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.28.vec.extract), !dbg !109
  %result.sroa.7.14.insert.ext = zext i16 %44 to i64, !dbg !113
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !113
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !113
  %add233 = add nuw nsw i32 %add, %mul236.pre-phi
  %45 = zext nneg i32 %add233 to i64, !dbg !114
  %add.ptr239 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %45, !dbg !115
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr239, align 8, !dbg !116
  %46 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %45, !dbg !115
  %add.ptr239.1 = getelementptr inbounds i8, ptr addrspace(1) %46, i64 32, !dbg !115
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr239.1, align 8, !dbg !116
  ret void, !dbg !117
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.log.f32(float) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #7

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #9 = { nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmp_icgtbnu/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp_icgtbnu/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 77, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 22, column: 45, scope: !40)
!46 = !DILocation(line: 22, column: 57, scope: !40)
!47 = !DILocation(line: 67, column: 3, scope: !48, inlinedAt: !49)
!48 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 67, type: !7, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!49 = distinct !DILocation(line: 22, column: 74, scope: !40)
!50 = !{i32 0, i32 1024}
!51 = !DILocation(line: 22, column: 93, scope: !40)
!52 = !DILocation(line: 22, column: 64, scope: !40)
!53 = !DILocation(line: 22, column: 129, scope: !40)
!54 = !DILocation(line: 22, column: 100, scope: !40)
!55 = !DILocation(line: 22, column: 34, scope: !40)
!56 = !DILocation(line: 22, column: 20, scope: !40)
!57 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !60)
!58 = distinct !DISubprogram(name: "__barrier_warp", scope: !59, file: !59, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!59 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!60 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !62)
!61 = distinct !DISubprogram(name: "__syncwarp", scope: !59, file: !59, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!62 = distinct !DILocation(line: 23, column: 3, scope: !40)
!63 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !60)
!64 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !60)
!65 = !DILocation(line: 24, column: 15, scope: !40)
!66 = !DILocation(line: 30, column: 21, scope: !40)
!67 = !DILocation(line: 33, column: 121, scope: !40)
!68 = !DILocation(line: 33, column: 16, scope: !40)
!69 = !DILocation(line: 33, column: 14, scope: !40)
!70 = !{!26, !26, i64 0}
!71 = !DILocation(line: 35, column: 61, scope: !40)
!72 = !DILocation(line: 35, column: 97, scope: !40)
!73 = !DILocation(line: 35, column: 43, scope: !40)
!74 = !DILocation(line: 35, column: 22, scope: !40)
!75 = !DILocation(line: 40, column: 37, scope: !40)
!76 = !{i32 1, i32 3, i32 -1}
!77 = !DILocation(line: 48, column: 69, scope: !40)
!78 = !DILocation(line: 53, column: 32, scope: !40)
!79 = !DILocation(line: 53, column: 44, scope: !40)
!80 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !83)
!81 = distinct !DISubprogram(name: "min", scope: !82, file: !82, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!82 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!83 = distinct !DILocation(line: 53, column: 27, scope: !40)
!84 = !DILocation(line: 288, column: 10, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "expf", scope: !82, file: !82, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!86 = distinct !DILocation(line: 53, column: 22, scope: !40)
!87 = !DILocation(line: 53, column: 125, scope: !40)
!88 = !DILocation(line: 48, column: 62, scope: !40)
!89 = !DILocation(line: 58, column: 34, scope: !40)
!90 = !DILocation(line: 63, column: 43, scope: !40)
!91 = !DILocation(line: 68, column: 36, scope: !40)
!92 = !DILocation(line: 68, column: 34, scope: !40)
!93 = !DILocation(line: 68, column: 9, scope: !40)
!94 = !DILocation(line: 76, column: 34, scope: !40)
!95 = !DILocation(line: 75, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !97, file: !97, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!98 = distinct !DILocation(line: 984, column: 9, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "__float2half", scope: !100, file: !100, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!101 = distinct !DILocation(line: 133, column: 53, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "__half", scope: !100, file: !100, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 80, column: 21, scope: !40)
!104 = !DILocation(line: 80, column: 18, scope: !40)
!105 = !DILocation(line: 84, column: 36, scope: !40)
!106 = !DILocation(line: 91, column: 3, scope: !40)
!107 = !DILocation(line: 0, scope: !40)
!108 = !DILocation(line: 94, column: 49, scope: !40)
!109 = !DILocation(line: 75, column: 10, scope: !96, inlinedAt: !110)
!110 = distinct !DILocation(line: 984, column: 9, scope: !99, inlinedAt: !111)
!111 = distinct !DILocation(line: 133, column: 53, scope: !102, inlinedAt: !112)
!112 = distinct !DILocation(line: 94, column: 41, scope: !40)
!113 = !DILocation(line: 94, column: 38, scope: !40)
!114 = !DILocation(line: 98, column: 3, scope: !40)
!115 = !DILocation(line: 99, column: 22, scope: !40)
!116 = !DILocation(line: 99, column: 139, scope: !40)
!117 = !DILocation(line: 101, column: 1, scope: !40)
