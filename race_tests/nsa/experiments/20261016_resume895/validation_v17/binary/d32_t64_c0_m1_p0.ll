; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_resume895/validation_v17/binary/d32_t64_c0_m1_p0.bc'
source_filename = "/tmp/tmp1g45_x8a/tvm_kernels.maca"
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !42, !range !29
  %mul = shl nsw i32 %0, 9, !dbg !46
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !dbg !47, !range !50
  %and = shl nuw nsw i32 %1, 5, !dbg !51
  %mul7 = and i32 %and, 480, !dbg !51
  %add = or disjoint i32 %mul7, %mul, !dbg !52
  %idxprom = zext nneg i32 %0 to i64, !dbg !53
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !53
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !53, !tbaa !30
  %cmp19 = icmp ult i32 %2, 4
  br i1 %cmp19, label %if.then, label %if.end171, !dbg !54

if.then:                                          ; preds = %entry
  %3 = lshr i32 %1, 1, !dbg !55
  %mul9 = and i32 %3, 504, !dbg !55
  %add10 = add nuw nsw i32 %add, %mul9, !dbg !56
  %idx.ext = zext nneg i32 %add10 to i64, !dbg !57
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %idx.ext, !dbg !57
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !58
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !58
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !58
  %mul20 = shl nuw nsw i32 %2, 9, !dbg !59
  %add24 = add nuw nsw i32 %mul9, %mul7, !dbg !60
  %add28 = add nuw nsw i32 %add24, %mul20, !dbg !61
  %idx.ext29 = zext nneg i32 %add28 to i64, !dbg !62
  %add.ptr30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %idx.ext29, !dbg !62
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr30, align 16, !dbg !63
  %k.sroa.4.0.add.ptr30.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr30, i64 8, !dbg !63
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr30.sroa_idx, align 8, !dbg !63
  %4 = shl nuw nsw i32 %1, 3
  %mul41 = and i32 %4, 8064
  %add42 = add nuw nsw i32 %mul20, %mul41
  %and50 = and i32 %1, 15
  %add51 = or disjoint i32 %add42, %and50, !dbg !64
  %idxprom52 = zext nneg i32 %add51 to i64, !dbg !65
  %arrayidx53 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52, !dbg !65
  %5 = load half, ptr addrspace(4) %arrayidx53, align 2, !dbg !66, !tbaa !67
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %5, i64 0, !dbg !66
  %add45.1 = or disjoint i32 %add42, %and50, !dbg !64
  %add51.1 = or disjoint i32 %add45.1, 32, !dbg !64
  %idxprom52.1 = zext nneg i32 %add51.1 to i64, !dbg !65
  %arrayidx53.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52.1, !dbg !65
  %6 = load half, ptr addrspace(4) %arrayidx53.1, align 2, !dbg !66, !tbaa !67
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %6, i64 1, !dbg !66
  %add45.2 = or disjoint i32 %add42, %and50, !dbg !64
  %add51.2 = or disjoint i32 %add45.2, 64, !dbg !64
  %idxprom52.2 = zext nneg i32 %add51.2 to i64, !dbg !65
  %arrayidx53.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52.2, !dbg !65
  %7 = load half, ptr addrspace(4) %arrayidx53.2, align 2, !dbg !66, !tbaa !67
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %7, i64 2, !dbg !66
  %add45.3 = or disjoint i32 %add42, %and50, !dbg !64
  %add51.3 = or disjoint i32 %add45.3, 96, !dbg !64
  %idxprom52.3 = zext nneg i32 %add51.3 to i64, !dbg !65
  %arrayidx53.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52.3, !dbg !65
  %8 = load half, ptr addrspace(4) %arrayidx53.3, align 2, !dbg !66, !tbaa !67
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %8, i64 3, !dbg !66
  %add48.4 = or disjoint i32 %add42, %and50, !dbg !64
  %add51.4 = or disjoint i32 %add48.4, 16, !dbg !64
  %idxprom52.4 = zext nneg i32 %add51.4 to i64, !dbg !65
  %arrayidx53.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52.4, !dbg !65
  %9 = load half, ptr addrspace(4) %arrayidx53.4, align 2, !dbg !66, !tbaa !67
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %9, i64 0, !dbg !66
  %add48.5 = or disjoint i32 %add42, %and50, !dbg !64
  %add51.5 = or disjoint i32 %add48.5, 48, !dbg !64
  %idxprom52.5 = zext nneg i32 %add51.5 to i64, !dbg !65
  %arrayidx53.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52.5, !dbg !65
  %10 = load half, ptr addrspace(4) %arrayidx53.5, align 2, !dbg !66, !tbaa !67
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %10, i64 1, !dbg !66
  %add48.6 = or disjoint i32 %add42, %and50, !dbg !64
  %add51.6 = or disjoint i32 %add48.6, 80, !dbg !64
  %idxprom52.6 = zext nneg i32 %add51.6 to i64, !dbg !65
  %arrayidx53.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52.6, !dbg !65
  %11 = load half, ptr addrspace(4) %arrayidx53.6, align 2, !dbg !66, !tbaa !67
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %11, i64 2, !dbg !66
  %add48.7 = or disjoint i32 %add42, %and50, !dbg !64
  %add51.7 = or disjoint i32 %add48.7, 112, !dbg !64
  %idxprom52.7 = zext nneg i32 %add51.7 to i64, !dbg !65
  %arrayidx53.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom52.7, !dbg !65
  %12 = load half, ptr addrspace(4) %arrayidx53.7, align 2, !dbg !66, !tbaa !67
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %12, i64 3, !dbg !66
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !68, !call_argsrelate !69
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %13), !dbg !68, !call_argsrelate !69
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %14, i64 0, !dbg !70
  %mul88 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !71
  %15 = tail call contract noundef float @llvm.minnum.f32(float %mul88, float 0x4024CB5EC0000000), !dbg !72
  %16 = tail call contract noundef float @llvm.exp.f32(float %15), !dbg !76
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %14, i64 1, !dbg !70
  %mul88.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !71
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul88.1, float 0x4024CB5EC0000000), !dbg !72
  %18 = tail call contract noundef float @llvm.exp.f32(float %17), !dbg !76
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %14, i64 2, !dbg !70
  %mul88.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !71
  %19 = tail call contract noundef float @llvm.minnum.f32(float %mul88.2, float 0x4024CB5EC0000000), !dbg !72
  %20 = tail call contract noundef float @llvm.exp.f32(float %19), !dbg !76
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %14, i64 3, !dbg !70
  %mul88.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !71
  %21 = tail call contract noundef float @llvm.minnum.f32(float %mul88.3, float 0x4024CB5EC0000000), !dbg !72
  %22 = tail call contract noundef float @llvm.exp.f32(float %21), !dbg !76
  %23 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %16), !dbg !79
  %24 = insertelement <4 x i16> poison, i16 %23, i64 0, !dbg !88
  %25 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %18), !dbg !79
  %26 = insertelement <4 x i16> %24, i16 %25, i64 1, !dbg !88
  %27 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %20), !dbg !79
  %28 = insertelement <4 x i16> %26, i16 %27, i64 2, !dbg !88
  %29 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %22), !dbg !79
  %30 = insertelement <4 x i16> %28, i16 %29, i64 3, !dbg !88
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %30 to <4 x half>, !dbg !88
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !89
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !89
  %add137.1 = fadd contract float %16, %18, !dbg !90
  %add137.2 = fadd contract float %add137.1, %20, !dbg !90
  %add137.3 = fadd contract float %add137.2, %22, !dbg !90
  %33 = bitcast float %add137.3 to i32, !dbg !91
  %34 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !95
  %35 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %34) #9, !dbg !100
  %xor.i.i = xor i32 %35, 32, !dbg !101
  %36 = and i32 %35, -64, !dbg !102
  %and.i.i = add nsw i32 %36, 64, !dbg !102
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !103
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %35, !dbg !104
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !105
  %37 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %33), !dbg !106
  %38 = bitcast i32 %37 to float, !dbg !107
  %add145 = fadd contract float %add137.3, %38, !dbg !108
  %39 = bitcast float %add145 to i32, !dbg !109
  %40 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !111
  %41 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %40) #9, !dbg !114
  %xor.i.i270 = xor i32 %41, 16, !dbg !115
  %42 = and i32 %41, -64, !dbg !116
  %and.i.i271 = add nsw i32 %42, 64, !dbg !116
  %cmp.not.i.i272 = icmp slt i32 %xor.i.i270, %and.i.i271, !dbg !117
  %cond.i.i273 = select i1 %cmp.not.i.i272, i32 %xor.i.i270, i32 %41, !dbg !118
  %shl.i.i274 = shl i32 %cond.i.i273, 2, !dbg !119
  %43 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i274, i32 %39), !dbg !120
  %44 = bitcast i32 %43 to float, !dbg !121
  %add150 = fadd contract float %add145, %44, !dbg !122
  %cmp153 = fcmp contract ogt float %add150, 0.000000e+00, !dbg !123
  %div = fdiv contract float 1.000000e+00, %add150, !dbg !124
  %condval.0 = select i1 %cmp153, float %div, float 0.000000e+00, !dbg !124
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %31, i64 0, !dbg !125
  %mul165 = fmul contract float %condval.0, %out.sroa.0.0.vec.extract, !dbg !126
  %out.sroa.0.0.vec.insert328 = insertelement <4 x float> poison, float %mul165, i64 0, !dbg !127
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %31, i64 1, !dbg !125
  %mul165.1 = fmul contract float %condval.0, %out.sroa.0.4.vec.extract, !dbg !126
  %out.sroa.0.4.vec.insert333 = insertelement <4 x float> %out.sroa.0.0.vec.insert328, float %mul165.1, i64 1, !dbg !127
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %31, i64 2, !dbg !125
  %mul165.2 = fmul contract float %condval.0, %out.sroa.0.8.vec.extract, !dbg !126
  %out.sroa.0.8.vec.insert338 = insertelement <4 x float> %out.sroa.0.4.vec.insert333, float %mul165.2, i64 2, !dbg !127
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %31, i64 3, !dbg !125
  %mul165.3 = fmul contract float %condval.0, %out.sroa.0.12.vec.extract, !dbg !126
  %out.sroa.0.12.vec.insert343 = insertelement <4 x float> %out.sroa.0.8.vec.insert338, float %mul165.3, i64 3, !dbg !127
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %32, i64 0, !dbg !125
  %mul165.4 = fmul contract float %condval.0, %out.sroa.20.16.vec.extract, !dbg !126
  %out.sroa.20.16.vec.insert349 = insertelement <4 x float> poison, float %mul165.4, i64 0, !dbg !127
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %32, i64 1, !dbg !125
  %mul165.5 = fmul contract float %condval.0, %out.sroa.20.20.vec.extract, !dbg !126
  %out.sroa.20.20.vec.insert354 = insertelement <4 x float> %out.sroa.20.16.vec.insert349, float %mul165.5, i64 1, !dbg !127
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %32, i64 2, !dbg !125
  %mul165.6 = fmul contract float %condval.0, %out.sroa.20.24.vec.extract, !dbg !126
  %out.sroa.20.24.vec.insert359 = insertelement <4 x float> %out.sroa.20.20.vec.insert354, float %mul165.6, i64 2, !dbg !127
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %32, i64 3, !dbg !125
  %mul165.7 = fmul contract float %condval.0, %out.sroa.20.28.vec.extract, !dbg !126
  %out.sroa.20.28.vec.insert364 = insertelement <4 x float> %out.sroa.20.24.vec.insert359, float %mul165.7, i64 3, !dbg !127
  br label %if.end171, !dbg !128

if.end171:                                        ; preds = %if.then, %entry
  %out.sroa.0.0 = phi <4 x float> [ %out.sroa.0.12.vec.insert343, %if.then ], [ zeroinitializer, %entry ], !dbg !129
  %out.sroa.20.0 = phi <4 x float> [ %out.sroa.20.28.vec.insert364, %if.then ], [ zeroinitializer, %entry ], !dbg !129
  %out.sroa.0.0.vec.extract330 = extractelement <4 x float> %out.sroa.0.0, i64 0, !dbg !130
  %45 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract330), !dbg !131
  %result.sroa.0.0.insert.ext = zext i16 %45 to i64, !dbg !135
  %out.sroa.0.4.vec.extract335 = extractelement <4 x float> %out.sroa.0.0, i64 1, !dbg !130
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract335), !dbg !131
  %result.sroa.0.2.insert.ext = zext i16 %46 to i64, !dbg !135
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !135
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !135
  %out.sroa.0.8.vec.extract340 = extractelement <4 x float> %out.sroa.0.0, i64 2, !dbg !130
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract340), !dbg !131
  %result.sroa.0.4.insert.ext = zext i16 %47 to i64, !dbg !135
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !135
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !135
  %out.sroa.0.12.vec.extract345 = extractelement <4 x float> %out.sroa.0.0, i64 3, !dbg !130
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract345), !dbg !131
  %result.sroa.0.6.insert.ext = zext i16 %48 to i64, !dbg !135
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !135
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !135
  %out.sroa.20.16.vec.extract351 = extractelement <4 x float> %out.sroa.20.0, i64 0, !dbg !130
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.16.vec.extract351), !dbg !131
  %result.sroa.7.8.insert.ext = zext i16 %49 to i64, !dbg !135
  %out.sroa.20.20.vec.extract356 = extractelement <4 x float> %out.sroa.20.0, i64 1, !dbg !130
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.20.vec.extract356), !dbg !131
  %result.sroa.7.10.insert.ext = zext i16 %50 to i64, !dbg !135
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !135
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !135
  %out.sroa.20.24.vec.extract361 = extractelement <4 x float> %out.sroa.20.0, i64 2, !dbg !130
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.24.vec.extract361), !dbg !131
  %result.sroa.7.12.insert.ext = zext i16 %51 to i64, !dbg !135
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !135
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !135
  %out.sroa.20.28.vec.extract366 = extractelement <4 x float> %out.sroa.20.0, i64 3, !dbg !130
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.28.vec.extract366), !dbg !131
  %result.sroa.7.14.insert.ext = zext i16 %52 to i64, !dbg !135
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !135
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !135
  %53 = lshr i32 %1, 2
  %mul214 = and i32 %53, 252
  %add211 = add nuw nsw i32 %add, %mul214
  %54 = zext nneg i32 %add211 to i64, !dbg !136
  %add.ptr217 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %54, !dbg !137
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr217, align 8, !dbg !138
  %55 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %54, !dbg !137
  %add.ptr217.1 = getelementptr inbounds i8, ptr addrspace(1) %55, i64 32, !dbg !137
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr217.1, align 8, !dbg !138
  ret void, !dbg !139
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
!1 = !DIFile(filename: "/tmp/tmp1g45_x8a/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp1g45_x8a/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 77, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 19, column: 45, scope: !40)
!46 = !DILocation(line: 19, column: 57, scope: !40)
!47 = !DILocation(line: 67, column: 3, scope: !48, inlinedAt: !49)
!48 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 67, type: !7, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!49 = distinct !DILocation(line: 19, column: 74, scope: !40)
!50 = !{i32 0, i32 1024}
!51 = !DILocation(line: 19, column: 93, scope: !40)
!52 = !DILocation(line: 19, column: 64, scope: !40)
!53 = !DILocation(line: 20, column: 15, scope: !40)
!54 = !DILocation(line: 26, column: 20, scope: !40)
!55 = !DILocation(line: 19, column: 129, scope: !40)
!56 = !DILocation(line: 19, column: 100, scope: !40)
!57 = !DILocation(line: 19, column: 34, scope: !40)
!58 = !DILocation(line: 19, column: 20, scope: !40)
!59 = !DILocation(line: 27, column: 54, scope: !40)
!60 = !DILocation(line: 27, column: 61, scope: !40)
!61 = !DILocation(line: 27, column: 97, scope: !40)
!62 = !DILocation(line: 27, column: 43, scope: !40)
!63 = !DILocation(line: 27, column: 22, scope: !40)
!64 = !DILocation(line: 30, column: 121, scope: !40)
!65 = !DILocation(line: 30, column: 16, scope: !40)
!66 = !DILocation(line: 30, column: 14, scope: !40)
!67 = !{!26, !26, i64 0}
!68 = !DILocation(line: 36, column: 37, scope: !40)
!69 = !{i32 1, i32 3, i32 -1}
!70 = !DILocation(line: 43, column: 31, scope: !40)
!71 = !DILocation(line: 43, column: 43, scope: !40)
!72 = !DILocation(line: 354, column: 10, scope: !73, inlinedAt: !75)
!73 = distinct !DISubprogram(name: "min", scope: !74, file: !74, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!74 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!75 = distinct !DILocation(line: 43, column: 26, scope: !40)
!76 = !DILocation(line: 288, column: 10, scope: !77, inlinedAt: !78)
!77 = distinct !DISubprogram(name: "expf", scope: !74, file: !74, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!78 = distinct !DILocation(line: 43, column: 21, scope: !40)
!79 = !DILocation(line: 75, column: 10, scope: !80, inlinedAt: !82)
!80 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !81, file: !81, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!81 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!82 = distinct !DILocation(line: 984, column: 9, scope: !83, inlinedAt: !85)
!83 = distinct !DISubprogram(name: "__float2half", scope: !84, file: !84, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!84 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!85 = distinct !DILocation(line: 133, column: 53, scope: !86, inlinedAt: !87)
!86 = distinct !DISubprogram(name: "__half", scope: !84, file: !84, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!87 = distinct !DILocation(line: 47, column: 21, scope: !40)
!88 = !DILocation(line: 47, column: 18, scope: !40)
!89 = !DILocation(line: 51, column: 34, scope: !40)
!90 = !DILocation(line: 59, column: 34, scope: !40)
!91 = !DILocation(line: 1018, column: 9, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !93, file: !93, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!94 = distinct !DILocation(line: 61, column: 34, scope: !40)
!95 = !DILocation(line: 171, column: 37, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "__lane_id", scope: !93, file: !93, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = distinct !DILocation(line: 990, column: 14, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !93, file: !93, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 1019, column: 11, scope: !92, inlinedAt: !94)
!100 = !DILocation(line: 171, column: 10, scope: !96, inlinedAt: !97)
!101 = !DILocation(line: 991, column: 20, scope: !98, inlinedAt: !99)
!102 = !DILocation(line: 992, column: 36, scope: !98, inlinedAt: !99)
!103 = !DILocation(line: 992, column: 17, scope: !98, inlinedAt: !99)
!104 = !DILocation(line: 992, column: 11, scope: !98, inlinedAt: !99)
!105 = !DILocation(line: 993, column: 43, scope: !98, inlinedAt: !99)
!106 = !DILocation(line: 993, column: 10, scope: !98, inlinedAt: !99)
!107 = !DILocation(line: 1020, column: 14, scope: !92, inlinedAt: !94)
!108 = !DILocation(line: 61, column: 32, scope: !40)
!109 = !DILocation(line: 1018, column: 9, scope: !92, inlinedAt: !110)
!110 = distinct !DILocation(line: 62, column: 34, scope: !40)
!111 = !DILocation(line: 171, column: 37, scope: !96, inlinedAt: !112)
!112 = distinct !DILocation(line: 990, column: 14, scope: !98, inlinedAt: !113)
!113 = distinct !DILocation(line: 1019, column: 11, scope: !92, inlinedAt: !110)
!114 = !DILocation(line: 171, column: 10, scope: !96, inlinedAt: !112)
!115 = !DILocation(line: 991, column: 20, scope: !98, inlinedAt: !113)
!116 = !DILocation(line: 992, column: 36, scope: !98, inlinedAt: !113)
!117 = !DILocation(line: 992, column: 17, scope: !98, inlinedAt: !113)
!118 = !DILocation(line: 992, column: 11, scope: !98, inlinedAt: !113)
!119 = !DILocation(line: 993, column: 43, scope: !98, inlinedAt: !113)
!120 = !DILocation(line: 993, column: 10, scope: !98, inlinedAt: !113)
!121 = !DILocation(line: 1020, column: 14, scope: !92, inlinedAt: !110)
!122 = !DILocation(line: 62, column: 32, scope: !40)
!123 = !DILocation(line: 64, column: 34, scope: !40)
!124 = !DILocation(line: 64, column: 9, scope: !40)
!125 = !DILocation(line: 72, column: 19, scope: !40)
!126 = !DILocation(line: 72, column: 28, scope: !40)
!127 = !DILocation(line: 72, column: 16, scope: !40)
!128 = !DILocation(line: 76, column: 3, scope: !40)
!129 = !DILocation(line: 0, scope: !40)
!130 = !DILocation(line: 79, column: 49, scope: !40)
!131 = !DILocation(line: 75, column: 10, scope: !80, inlinedAt: !132)
!132 = distinct !DILocation(line: 984, column: 9, scope: !83, inlinedAt: !133)
!133 = distinct !DILocation(line: 133, column: 53, scope: !86, inlinedAt: !134)
!134 = distinct !DILocation(line: 79, column: 41, scope: !40)
!135 = !DILocation(line: 79, column: 38, scope: !40)
!136 = !DILocation(line: 83, column: 3, scope: !40)
!137 = !DILocation(line: 84, column: 22, scope: !40)
!138 = !DILocation(line: 84, column: 139, scope: !40)
!139 = !DILocation(line: 86, column: 1, scope: !40)
