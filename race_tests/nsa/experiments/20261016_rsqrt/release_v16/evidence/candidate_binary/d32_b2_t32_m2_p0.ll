; ModuleID = 'experiments/20261016_rsqrt/candidate_binary/d32_b2_t32_m2_p0.bc'
source_filename = "/tmp/tmpnhlxviaw/tvm_kernels.maca"
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

; Function Attrs: convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !42, !range !29
  %mul = shl nsw i32 %0, 14, !dbg !46
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !47, !range !29
  %mul7 = shl nsw i32 %1, 9, !dbg !50
  %add = add nuw nsw i32 %mul, %mul7, !dbg !51
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !dbg !52, !range !55
  %and = shl nuw nsw i32 %2, 5, !dbg !56
  %mul9 = and i32 %and, 480, !dbg !56
  %add10 = or disjoint i32 %add, %mul9, !dbg !57
  %mul16 = shl nsw i32 %0, 5, !dbg !58
  %add18 = add nuw nsw i32 %mul16, %1, !dbg !59
  %idxprom = zext nneg i32 %add18 to i64, !dbg !60
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !60
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !60, !tbaa !30
  %cmp25 = icmp ugt i32 %3, 1
  %shr28 = lshr i32 %1, 4
  %cmp29.not = icmp ugt i32 %3, %shr28
  %or.cond321 = or i1 %cmp25, %cmp29.not, !dbg !61
  br i1 %or.cond321, label %entry.if.end199_crit_edge, label %if.then, !dbg !61

entry.if.end199_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %2, 2
  %.pre402 = and i32 %.pre, 252
  br label %if.end199, !dbg !61

if.then:                                          ; preds = %entry
  %4 = lshr i32 %2, 1, !dbg !62
  %mul12 = and i32 %4, 504, !dbg !62
  %add13 = add nuw nsw i32 %add10, %mul12, !dbg !63
  %idx.ext = zext nneg i32 %add13 to i64, !dbg !64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %idx.ext, !dbg !64
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !65
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !65
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !65
  %mul31 = shl nsw i32 %0, 10, !dbg !66
  %mul32 = shl nuw nsw i32 %3, 9, !dbg !67
  %add33 = or disjoint i32 %mul32, %mul31, !dbg !68
  %add37 = add nuw nsw i32 %mul12, %mul9, !dbg !69
  %add41 = add nuw nsw i32 %add37, %add33, !dbg !70
  %idx.ext42 = zext nneg i32 %add41 to i64, !dbg !71
  %add.ptr43 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %idx.ext42, !dbg !71
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr43, align 16, !dbg !72
  %k.sroa.4.0.add.ptr43.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr43, i64 8, !dbg !72
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr43.sroa_idx, align 8, !dbg !72
  %5 = shl nuw nsw i32 %2, 3
  %mul57 = and i32 %5, 8064
  %add58 = add nuw nsw i32 %add33, %mul57
  %and66 = and i32 %2, 15
  %add67 = or disjoint i32 %add58, %and66, !dbg !73
  %idxprom68 = zext nneg i32 %add67 to i64, !dbg !74
  %arrayidx69 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68, !dbg !74
  %6 = load half, ptr addrspace(4) %arrayidx69, align 2, !dbg !75, !tbaa !76
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %6, i64 0, !dbg !75
  %add61.1 = or disjoint i32 %add58, %and66, !dbg !73
  %add67.1 = or disjoint i32 %add61.1, 32, !dbg !73
  %idxprom68.1 = zext nneg i32 %add67.1 to i64, !dbg !74
  %arrayidx69.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.1, !dbg !74
  %7 = load half, ptr addrspace(4) %arrayidx69.1, align 2, !dbg !75, !tbaa !76
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %7, i64 1, !dbg !75
  %add61.2 = or disjoint i32 %add58, %and66, !dbg !73
  %add67.2 = or disjoint i32 %add61.2, 64, !dbg !73
  %idxprom68.2 = zext nneg i32 %add67.2 to i64, !dbg !74
  %arrayidx69.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.2, !dbg !74
  %8 = load half, ptr addrspace(4) %arrayidx69.2, align 2, !dbg !75, !tbaa !76
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %8, i64 2, !dbg !75
  %add61.3 = or disjoint i32 %add58, %and66, !dbg !73
  %add67.3 = or disjoint i32 %add61.3, 96, !dbg !73
  %idxprom68.3 = zext nneg i32 %add67.3 to i64, !dbg !74
  %arrayidx69.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.3, !dbg !74
  %9 = load half, ptr addrspace(4) %arrayidx69.3, align 2, !dbg !75, !tbaa !76
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %9, i64 3, !dbg !75
  %add64.4 = or disjoint i32 %add58, %and66, !dbg !73
  %add67.4 = or disjoint i32 %add64.4, 16, !dbg !73
  %idxprom68.4 = zext nneg i32 %add67.4 to i64, !dbg !74
  %arrayidx69.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.4, !dbg !74
  %10 = load half, ptr addrspace(4) %arrayidx69.4, align 2, !dbg !75, !tbaa !76
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %10, i64 0, !dbg !75
  %add64.5 = or disjoint i32 %add58, %and66, !dbg !73
  %add67.5 = or disjoint i32 %add64.5, 48, !dbg !73
  %idxprom68.5 = zext nneg i32 %add67.5 to i64, !dbg !74
  %arrayidx69.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.5, !dbg !74
  %11 = load half, ptr addrspace(4) %arrayidx69.5, align 2, !dbg !75, !tbaa !76
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %11, i64 1, !dbg !75
  %add64.6 = or disjoint i32 %add58, %and66, !dbg !73
  %add67.6 = or disjoint i32 %add64.6, 80, !dbg !73
  %idxprom68.6 = zext nneg i32 %add67.6 to i64, !dbg !74
  %arrayidx69.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.6, !dbg !74
  %12 = load half, ptr addrspace(4) %arrayidx69.6, align 2, !dbg !75, !tbaa !76
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %12, i64 2, !dbg !75
  %add64.7 = or disjoint i32 %add58, %and66, !dbg !73
  %add67.7 = or disjoint i32 %add64.7, 112, !dbg !73
  %idxprom68.7 = zext nneg i32 %add67.7 to i64, !dbg !74
  %arrayidx69.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.7, !dbg !74
  %13 = load half, ptr addrspace(4) %arrayidx69.7, align 2, !dbg !75, !tbaa !76
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %13, i64 3, !dbg !75
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !77, !call_argsrelate !78
  %15 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %14), !dbg !77, !call_argsrelate !78
  %mul102 = shl nuw nsw i32 %3, 4
  %16 = lshr i32 %2, 2
  %mul105 = and i32 %16, 252
  %add106 = add nuw nsw i32 %mul102, %mul105
  %cmp109.not = icmp ugt i32 %add106, %1, !dbg !79
  %. = select i1 %cmp109.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %15, i64 0, !dbg !80
  %mul113 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !81
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul113, float 0x4024CB5EC0000000), !dbg !82
  %18 = tail call contract noundef float @llvm.exp.f32(float %17), !dbg !86
  %mul116 = fmul contract float %., %18, !dbg !89
  %cmp109.not.1.not = icmp ult i32 %add106, %1, !dbg !79
  %..1 = select i1 %cmp109.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %15, i64 1, !dbg !80
  %mul113.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !81
  %19 = tail call contract noundef float @llvm.minnum.f32(float %mul113.1, float 0x4024CB5EC0000000), !dbg !82
  %20 = tail call contract noundef float @llvm.exp.f32(float %19), !dbg !86
  %mul116.1 = fmul contract float %..1, %20, !dbg !89
  %add107.2 = or disjoint i32 %add106, 2, !dbg !90
  %cmp109.not.2 = icmp ugt i32 %add107.2, %1, !dbg !79
  %..2 = select i1 %cmp109.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %15, i64 2, !dbg !80
  %mul113.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !81
  %21 = tail call contract noundef float @llvm.minnum.f32(float %mul113.2, float 0x4024CB5EC0000000), !dbg !82
  %22 = tail call contract noundef float @llvm.exp.f32(float %21), !dbg !86
  %mul116.2 = fmul contract float %..2, %22, !dbg !89
  %add107.3 = or disjoint i32 %add106, 3, !dbg !90
  %cmp109.not.3 = icmp ugt i32 %add107.3, %1, !dbg !79
  %..3 = select i1 %cmp109.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %15, i64 3, !dbg !80
  %mul113.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !81
  %23 = tail call contract noundef float @llvm.minnum.f32(float %mul113.3, float 0x4024CB5EC0000000), !dbg !82
  %24 = tail call contract noundef float @llvm.exp.f32(float %23), !dbg !86
  %mul116.3 = fmul contract float %..3, %24, !dbg !89
  %25 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116), !dbg !91
  %26 = insertelement <4 x i16> poison, i16 %25, i64 0, !dbg !100
  %27 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116.1), !dbg !91
  %28 = insertelement <4 x i16> %26, i16 %27, i64 1, !dbg !100
  %29 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116.2), !dbg !91
  %30 = insertelement <4 x i16> %28, i16 %29, i64 2, !dbg !100
  %31 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116.3), !dbg !91
  %32 = insertelement <4 x i16> %30, i16 %31, i64 3, !dbg !100
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %32 to <4 x half>, !dbg !100
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !101
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !101
  %add163 = fadd contract float %mul116, 0.000000e+00, !dbg !102
  %add163.1 = fadd contract float %add163, %mul116.1, !dbg !102
  %add163.2 = fadd contract float %add163.1, %mul116.2, !dbg !102
  %add163.3 = fadd contract float %add163.2, %mul116.3, !dbg !102
  %35 = bitcast float %add163.3 to i32, !dbg !103
  %36 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !107
  %37 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %36) #9, !dbg !112
  %xor.i.i = xor i32 %37, 32, !dbg !113
  %38 = and i32 %37, -64, !dbg !114
  %and.i.i = add nsw i32 %38, 64, !dbg !114
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !115
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %37, !dbg !116
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !117
  %39 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %35), !dbg !118
  %40 = bitcast i32 %39 to float, !dbg !119
  %add171 = fadd contract float %add163.3, %40, !dbg !120
  %41 = bitcast float %add171 to i32, !dbg !121
  %42 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !123
  %43 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %42) #9, !dbg !126
  %xor.i.i304 = xor i32 %43, 16, !dbg !127
  %44 = and i32 %43, -64, !dbg !128
  %and.i.i305 = add nsw i32 %44, 64, !dbg !128
  %cmp.not.i.i306 = icmp slt i32 %xor.i.i304, %and.i.i305, !dbg !129
  %cond.i.i307 = select i1 %cmp.not.i.i306, i32 %xor.i.i304, i32 %43, !dbg !130
  %shl.i.i308 = shl i32 %cond.i.i307, 2, !dbg !131
  %45 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i308, i32 %41), !dbg !132
  %46 = bitcast i32 %45 to float, !dbg !133
  %add176 = fadd contract float %add171, %46, !dbg !134
  %cmp179 = fcmp contract ogt float %add176, 0.000000e+00, !dbg !135
  %div = fdiv contract float 1.000000e+00, %add176, !dbg !136
  %condval_1.0 = select i1 %cmp179, float %div, float 0.000000e+00, !dbg !136
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0, !dbg !137
  %mul193 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract, !dbg !138
  %out.sroa.0.0.vec.insert363 = insertelement <4 x float> poison, float %mul193, i64 0, !dbg !139
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1, !dbg !137
  %mul193.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract, !dbg !138
  %out.sroa.0.4.vec.insert368 = insertelement <4 x float> %out.sroa.0.0.vec.insert363, float %mul193.1, i64 1, !dbg !139
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2, !dbg !137
  %mul193.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract, !dbg !138
  %out.sroa.0.8.vec.insert373 = insertelement <4 x float> %out.sroa.0.4.vec.insert368, float %mul193.2, i64 2, !dbg !139
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3, !dbg !137
  %mul193.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract, !dbg !138
  %out.sroa.0.12.vec.insert378 = insertelement <4 x float> %out.sroa.0.8.vec.insert373, float %mul193.3, i64 3, !dbg !139
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %34, i64 0, !dbg !137
  %mul193.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract, !dbg !138
  %out.sroa.20.16.vec.insert384 = insertelement <4 x float> poison, float %mul193.4, i64 0, !dbg !139
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %34, i64 1, !dbg !137
  %mul193.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract, !dbg !138
  %out.sroa.20.20.vec.insert389 = insertelement <4 x float> %out.sroa.20.16.vec.insert384, float %mul193.5, i64 1, !dbg !139
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %34, i64 2, !dbg !137
  %mul193.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract, !dbg !138
  %out.sroa.20.24.vec.insert394 = insertelement <4 x float> %out.sroa.20.20.vec.insert389, float %mul193.6, i64 2, !dbg !139
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %34, i64 3, !dbg !137
  %mul193.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract, !dbg !138
  %out.sroa.20.28.vec.insert399 = insertelement <4 x float> %out.sroa.20.24.vec.insert394, float %mul193.7, i64 3, !dbg !139
  br label %if.end199, !dbg !140

if.end199:                                        ; preds = %entry.if.end199_crit_edge, %if.then
  %mul245.pre-phi = phi i32 [ %.pre402, %entry.if.end199_crit_edge ], [ %mul105, %if.then ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end199_crit_edge ], [ %out.sroa.0.12.vec.insert378, %if.then ], !dbg !141
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry.if.end199_crit_edge ], [ %out.sroa.20.28.vec.insert399, %if.then ], !dbg !141
  %out.sroa.0.0.vec.extract365 = extractelement <4 x float> %out.sroa.0.0, i64 0, !dbg !142
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract365), !dbg !143
  %result.sroa.0.0.insert.ext = zext i16 %47 to i64, !dbg !147
  %out.sroa.0.4.vec.extract370 = extractelement <4 x float> %out.sroa.0.0, i64 1, !dbg !142
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract370), !dbg !143
  %result.sroa.0.2.insert.ext = zext i16 %48 to i64, !dbg !147
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !147
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !147
  %out.sroa.0.8.vec.extract375 = extractelement <4 x float> %out.sroa.0.0, i64 2, !dbg !142
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract375), !dbg !143
  %result.sroa.0.4.insert.ext = zext i16 %49 to i64, !dbg !147
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !147
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !147
  %out.sroa.0.12.vec.extract380 = extractelement <4 x float> %out.sroa.0.0, i64 3, !dbg !142
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract380), !dbg !143
  %result.sroa.0.6.insert.ext = zext i16 %50 to i64, !dbg !147
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !147
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !147
  %out.sroa.20.16.vec.extract386 = extractelement <4 x float> %out.sroa.20.0, i64 0, !dbg !142
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.16.vec.extract386), !dbg !143
  %result.sroa.7.8.insert.ext = zext i16 %51 to i64, !dbg !147
  %out.sroa.20.20.vec.extract391 = extractelement <4 x float> %out.sroa.20.0, i64 1, !dbg !142
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.20.vec.extract391), !dbg !143
  %result.sroa.7.10.insert.ext = zext i16 %52 to i64, !dbg !147
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !147
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !147
  %out.sroa.20.24.vec.extract396 = extractelement <4 x float> %out.sroa.20.0, i64 2, !dbg !142
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.24.vec.extract396), !dbg !143
  %result.sroa.7.12.insert.ext = zext i16 %53 to i64, !dbg !147
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !147
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !147
  %out.sroa.20.28.vec.extract401 = extractelement <4 x float> %out.sroa.20.0, i64 3, !dbg !142
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.28.vec.extract401), !dbg !143
  %result.sroa.7.14.insert.ext = zext i16 %54 to i64, !dbg !147
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !147
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !147
  %add242 = add nuw nsw i32 %add10, %mul245.pre-phi
  %55 = zext nneg i32 %add242 to i64, !dbg !148
  %add.ptr248 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %55, !dbg !149
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr248, align 8, !dbg !150
  %56 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %55, !dbg !149
  %add.ptr248.1 = getelementptr inbounds i8, ptr addrspace(1) %56, i64 32, !dbg !149
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr248.1, align 8, !dbg !150
  ret void, !dbg !151
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

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
declare float @llvm.minnum.f32(float, float) #6

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpnhlxviaw/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpnhlxviaw/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 78, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_y", scope: !44, file: !44, line: 78, type: !7, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 19, column: 46, scope: !40)
!46 = !DILocation(line: 19, column: 58, scope: !40)
!47 = !DILocation(line: 77, column: 3, scope: !48, inlinedAt: !49)
!48 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!49 = distinct !DILocation(line: 19, column: 76, scope: !40)
!50 = !DILocation(line: 19, column: 88, scope: !40)
!51 = !DILocation(line: 19, column: 67, scope: !40)
!52 = !DILocation(line: 67, column: 3, scope: !53, inlinedAt: !54)
!53 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 67, type: !7, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!54 = distinct !DILocation(line: 19, column: 106, scope: !40)
!55 = !{i32 0, i32 1024}
!56 = !DILocation(line: 19, column: 125, scope: !40)
!57 = !DILocation(line: 19, column: 96, scope: !40)
!58 = !DILocation(line: 20, column: 43, scope: !40)
!59 = !DILocation(line: 20, column: 49, scope: !40)
!60 = !DILocation(line: 20, column: 15, scope: !40)
!61 = !DILocation(line: 26, column: 21, scope: !40)
!62 = !DILocation(line: 19, column: 161, scope: !40)
!63 = !DILocation(line: 19, column: 132, scope: !40)
!64 = !DILocation(line: 19, column: 34, scope: !40)
!65 = !DILocation(line: 19, column: 20, scope: !40)
!66 = !DILocation(line: 27, column: 67, scope: !40)
!67 = !DILocation(line: 27, column: 84, scope: !40)
!68 = !DILocation(line: 27, column: 75, scope: !40)
!69 = !DILocation(line: 27, column: 92, scope: !40)
!70 = !DILocation(line: 27, column: 128, scope: !40)
!71 = !DILocation(line: 27, column: 43, scope: !40)
!72 = !DILocation(line: 27, column: 22, scope: !40)
!73 = !DILocation(line: 30, column: 152, scope: !40)
!74 = !DILocation(line: 30, column: 16, scope: !40)
!75 = !DILocation(line: 30, column: 14, scope: !40)
!76 = !{!26, !26, i64 0}
!77 = !DILocation(line: 36, column: 37, scope: !40)
!78 = !{i32 1, i32 3, i32 -1}
!79 = !DILocation(line: 44, column: 69, scope: !40)
!80 = !DILocation(line: 49, column: 32, scope: !40)
!81 = !DILocation(line: 49, column: 44, scope: !40)
!82 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !85)
!83 = distinct !DISubprogram(name: "min", scope: !84, file: !84, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!84 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!85 = distinct !DILocation(line: 49, column: 27, scope: !40)
!86 = !DILocation(line: 288, column: 10, scope: !87, inlinedAt: !88)
!87 = distinct !DISubprogram(name: "expf", scope: !84, file: !84, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = distinct !DILocation(line: 49, column: 22, scope: !40)
!89 = !DILocation(line: 49, column: 125, scope: !40)
!90 = !DILocation(line: 44, column: 62, scope: !40)
!91 = !DILocation(line: 75, column: 10, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !93, file: !93, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!94 = distinct !DILocation(line: 984, column: 9, scope: !95, inlinedAt: !97)
!95 = distinct !DISubprogram(name: "__float2half", scope: !96, file: !96, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!97 = distinct !DILocation(line: 133, column: 53, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "__half", scope: !96, file: !96, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 53, column: 21, scope: !40)
!100 = !DILocation(line: 53, column: 18, scope: !40)
!101 = !DILocation(line: 57, column: 34, scope: !40)
!102 = !DILocation(line: 65, column: 34, scope: !40)
!103 = !DILocation(line: 1018, column: 9, scope: !104, inlinedAt: !106)
!104 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !105, file: !105, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!106 = distinct !DILocation(line: 67, column: 34, scope: !40)
!107 = !DILocation(line: 171, column: 37, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "__lane_id", scope: !105, file: !105, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!109 = distinct !DILocation(line: 990, column: 14, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !105, file: !105, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 1019, column: 11, scope: !104, inlinedAt: !106)
!112 = !DILocation(line: 171, column: 10, scope: !108, inlinedAt: !109)
!113 = !DILocation(line: 991, column: 20, scope: !110, inlinedAt: !111)
!114 = !DILocation(line: 992, column: 36, scope: !110, inlinedAt: !111)
!115 = !DILocation(line: 992, column: 17, scope: !110, inlinedAt: !111)
!116 = !DILocation(line: 992, column: 11, scope: !110, inlinedAt: !111)
!117 = !DILocation(line: 993, column: 43, scope: !110, inlinedAt: !111)
!118 = !DILocation(line: 993, column: 10, scope: !110, inlinedAt: !111)
!119 = !DILocation(line: 1020, column: 14, scope: !104, inlinedAt: !106)
!120 = !DILocation(line: 67, column: 32, scope: !40)
!121 = !DILocation(line: 1018, column: 9, scope: !104, inlinedAt: !122)
!122 = distinct !DILocation(line: 68, column: 34, scope: !40)
!123 = !DILocation(line: 171, column: 37, scope: !108, inlinedAt: !124)
!124 = distinct !DILocation(line: 990, column: 14, scope: !110, inlinedAt: !125)
!125 = distinct !DILocation(line: 1019, column: 11, scope: !104, inlinedAt: !122)
!126 = !DILocation(line: 171, column: 10, scope: !108, inlinedAt: !124)
!127 = !DILocation(line: 991, column: 20, scope: !110, inlinedAt: !125)
!128 = !DILocation(line: 992, column: 36, scope: !110, inlinedAt: !125)
!129 = !DILocation(line: 992, column: 17, scope: !110, inlinedAt: !125)
!130 = !DILocation(line: 992, column: 11, scope: !110, inlinedAt: !125)
!131 = !DILocation(line: 993, column: 43, scope: !110, inlinedAt: !125)
!132 = !DILocation(line: 993, column: 10, scope: !110, inlinedAt: !125)
!133 = !DILocation(line: 1020, column: 14, scope: !104, inlinedAt: !122)
!134 = !DILocation(line: 68, column: 32, scope: !40)
!135 = !DILocation(line: 70, column: 34, scope: !40)
!136 = !DILocation(line: 70, column: 9, scope: !40)
!137 = !DILocation(line: 78, column: 19, scope: !40)
!138 = !DILocation(line: 78, column: 28, scope: !40)
!139 = !DILocation(line: 78, column: 16, scope: !40)
!140 = !DILocation(line: 82, column: 3, scope: !40)
!141 = !DILocation(line: 0, scope: !40)
!142 = !DILocation(line: 85, column: 49, scope: !40)
!143 = !DILocation(line: 75, column: 10, scope: !92, inlinedAt: !144)
!144 = distinct !DILocation(line: 984, column: 9, scope: !95, inlinedAt: !145)
!145 = distinct !DILocation(line: 133, column: 53, scope: !98, inlinedAt: !146)
!146 = distinct !DILocation(line: 85, column: 41, scope: !40)
!147 = !DILocation(line: 85, column: 38, scope: !40)
!148 = !DILocation(line: 89, column: 3, scope: !40)
!149 = !DILocation(line: 90, column: 22, scope: !40)
!150 = !DILocation(line: 90, column: 171, scope: !40)
!151 = !DILocation(line: 92, column: 1, scope: !40)
