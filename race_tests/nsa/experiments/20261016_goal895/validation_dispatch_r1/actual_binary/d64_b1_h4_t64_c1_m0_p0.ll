; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d64_b1_h4_t64_c1_m0_p0.bc'
source_filename = "/tmp/tmpyvxrjucj/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 12
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 6
  %mul9 = and i32 %and, 960
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %mul20 = shl nsw i32 %0, 2, !dbg !46
  %add22 = add nuw nsw i32 %mul20, %1, !dbg !47
  %idxprom = zext nneg i32 %add22 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !48
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %mul23 = shl nsw i32 %6, 4, !dbg !49
  %cmp37 = icmp sgt i32 %6, -1, !dbg !50
  br i1 %cmp37, label %land.lhs.true, label %if.end350, !dbg !51

land.lhs.true:                                    ; preds = %entry
  %cmp38 = icmp ugt i32 %6, 3, !dbg !52
  %cmp41.not = icmp sgt i32 %mul23, %0
  %or.cond = select i1 %cmp38, i1 true, i1 %cmp41.not, !dbg !53
  br i1 %or.cond, label %if.end350, label %for.cond42.preheader, !dbg !53

for.cond42.preheader:                             ; preds = %land.lhs.true
  %and48 = and i32 %2, 15
  %add49 = or disjoint i32 %mul23, %and48
  %cmp50 = icmp slt i32 %add49, 64
  %mul52 = shl nuw nsw i32 %6, 12
  %and54 = shl nuw nsw i32 %2, 8
  %mul55 = and i32 %and54, 3840
  %mul58 = shl nsw i32 %1, 6
  %add56 = add nuw nsw i32 %mul55, %mul58
  %add59 = add nuw nsw i32 %add56, %mul14
  %add61 = add nuw nsw i32 %add59, %mul52
  %7 = zext nneg i32 %add61 to i64, !dbg !54
  br i1 %cmp50, label %if.then51, label %if.end, !dbg !55

if.then51:                                        ; preds = %for.cond42.preheader
  %add.ptr67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7, !dbg !56
  %8 = load <4 x half>, ptr addrspace(4) %add.ptr67, align 16, !dbg !57, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr67, i64 8, !dbg !57
  %9 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx, align 8, !dbg !57, !tbaa !30
  br label %if.end, !dbg !58

if.end:                                           ; preds = %for.cond42.preheader, %if.then51
  %10 = phi <4 x half> [ %9, %if.then51 ], [ zeroinitializer, %for.cond42.preheader ], !dbg !59
  %11 = phi <4 x half> [ %8, %if.then51 ], [ zeroinitializer, %for.cond42.preheader ], !dbg !59
  br i1 %cmp50, label %if.then51.1, label %if.end.1, !dbg !55

if.then51.1:                                      ; preds = %if.end
  %12 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7, !dbg !56
  %add.ptr67.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 64, !dbg !56
  %13 = load <4 x half>, ptr addrspace(4) %add.ptr67.1, align 16, !dbg !57, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 72, !dbg !57
  %14 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx.1, align 8, !dbg !57, !tbaa !30
  br label %if.end.1, !dbg !58

if.end.1:                                         ; preds = %if.then51.1, %if.end
  %15 = phi <4 x half> [ %14, %if.then51.1 ], [ zeroinitializer, %if.end ], !dbg !59
  %16 = phi <4 x half> [ %13, %if.then51.1 ], [ zeroinitializer, %if.end ], !dbg !59
  %shr101 = lshr i32 %2, 3
  %add102 = add nuw nsw i32 %mul23, %shr101
  %17 = shl nuw nsw i32 %2, 5
  %mul110 = and i32 %17, 32512
  %add111 = add nuw nsw i32 %mul110, %mul58
  %and118 = shl nuw nsw i32 %2, 3
  %mul119 = and i32 %and118, 56
  %add113 = or disjoint i32 %add111, %mul119
  %add116 = add nuw nsw i32 %add113, %mul52
  %18 = zext nneg i32 %add116 to i64, !dbg !60
  %cmp105 = icmp ult i32 %add102, 64, !dbg !61
  br i1 %cmp105, label %if.then106, label %if.end146, !dbg !62

for.cond158.preheader:                            ; preds = %if.end146.1
  %19 = lshr i32 %2, 2
  %mul165 = and i32 %19, 252
  %add166 = add nuw nsw i32 %mul23, %mul165
  %cmp169.not = icmp sgt i32 %add166, %0, !dbg !63
  %spec.select = select i1 %cmp169.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.0.vec.insert594 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !65
  %cmp169.not.1.not = icmp slt i32 %add166, %0, !dbg !63
  %spec.select.1 = select i1 %cmp169.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !64
  %acc_s.sroa.0.4.vec.insert607 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert594, float %spec.select.1, i64 1, !dbg !65
  %add167.2 = or disjoint i32 %add166, 2, !dbg !66
  %cmp169.not.2 = icmp sgt i32 %add167.2, %0, !dbg !63
  %spec.select.2 = select i1 %cmp169.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.8.vec.insert620 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert607, float %spec.select.2, i64 2, !dbg !65
  %add167.3 = or disjoint i32 %add166, 3, !dbg !66
  %cmp169.not.3 = icmp sgt i32 %add167.3, %0, !dbg !63
  %spec.select.3 = select i1 %cmp169.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.12.vec.insert633 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert620, float %spec.select.3, i64 3, !dbg !65
  br label %if.end184

if.then106:                                       ; preds = %if.end.1
  %add.ptr122 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %18, !dbg !67
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr122, align 16, !dbg !68, !tbaa !30
  %condval_1.sroa.5.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr122, i64 4, !dbg !68
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr122.sroa_idx, align 4, !dbg !68, !tbaa !30
  %condval_1.sroa.6.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr122, i64 8, !dbg !68
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr122.sroa_idx, align 8, !dbg !68, !tbaa !30
  %condval_1.sroa.7.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr122, i64 12, !dbg !68
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr122.sroa_idx, align 4, !dbg !68, !tbaa !30
  br label %if.end146, !dbg !69

if.end146:                                        ; preds = %if.end.1, %if.then106
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then106 ], [ 0, %if.end.1 ], !dbg !59
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then106 ], [ 0, %if.end.1 ], !dbg !59
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then106 ], [ 0, %if.end.1 ], !dbg !59
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then106 ], [ 0, %if.end.1 ], !dbg !59
  %cmp105.1 = icmp ult i32 %add102, 56, !dbg !61
  br i1 %cmp105.1, label %if.then106.1, label %if.end146.1, !dbg !62

if.then106.1:                                     ; preds = %if.end146
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %18, !dbg !67
  %add.ptr122.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4096, !dbg !67
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr122.1, align 16, !dbg !68, !tbaa !30
  %condval_1.sroa.5.0.add.ptr122.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4100, !dbg !68
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr122.sroa_idx.1, align 4, !dbg !68, !tbaa !30
  %condval_1.sroa.6.0.add.ptr122.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4104, !dbg !68
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr122.sroa_idx.1, align 8, !dbg !68, !tbaa !30
  %condval_1.sroa.7.0.add.ptr122.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4108, !dbg !68
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr122.sroa_idx.1, align 4, !dbg !68, !tbaa !30
  br label %if.end146.1, !dbg !69

if.end146.1:                                      ; preds = %if.then106.1, %if.end146
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ], !dbg !59
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ], !dbg !59
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ], !dbg !59
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ], !dbg !59
  %add155 = or disjoint i32 %mul23, 15, !dbg !70
  %cmp156 = icmp slt i32 %0, %add155, !dbg !71
  br i1 %cmp156, label %for.cond158.preheader, label %if.end184, !dbg !72

if.end184:                                        ; preds = %if.end146.1, %for.cond158.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert633, %for.cond158.preheader ], [ zeroinitializer, %if.end146.1 ], !dbg !59
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %11, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !73, !call_argsrelate !74
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %10, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %21), !dbg !73, !call_argsrelate !74
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %16, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %22), !dbg !73, !call_argsrelate !74
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %15, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %23), !dbg !73, !call_argsrelate !74
  %add.ptr227.idx = shl nuw nsw i32 %2, 4
  %invariant.gep = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr227.idx, !dbg !75
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep, align 16, !dbg !76, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 4, !dbg !76
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep.sroa_idx, align 4, !dbg !76, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 8, !dbg !76
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep.sroa_idx, align 8, !dbg !76, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 12, !dbg !76
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep.sroa_idx, align 4, !dbg !76, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !77
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !dbg !76, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1028, !dbg !76
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !76, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1032, !dbg !76
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !76, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1036, !dbg !76
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !76, !tbaa !30
  %acc_s.sroa.0.0.vec.extract596 = extractelement <4 x float> %24, i64 0, !dbg !78
  %mul237 = fmul contract float %acc_s.sroa.0.0.vec.extract596, 0x3FC2776C60000000, !dbg !79
  %25 = tail call contract noundef float @llvm.minnum.f32(float %mul237, float 1.500000e+01), !dbg !80
  %cmp.i.i = fcmp contract olt float %25, -1.260000e+02, !dbg !84
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !84
  %add.i.i = fadd contract float %25, %cond.i.i, !dbg !84
  %26 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !84
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !84
  %mul.i.i = fmul contract float %cond2.i.i, %26, !dbg !84
  %acc_s.sroa.0.4.vec.extract609 = extractelement <4 x float> %24, i64 1, !dbg !78
  %mul237.1 = fmul contract float %acc_s.sroa.0.4.vec.extract609, 0x3FC2776C60000000, !dbg !79
  %27 = tail call contract noundef float @llvm.minnum.f32(float %mul237.1, float 1.500000e+01), !dbg !80
  %cmp.i.i.1 = fcmp contract olt float %27, -1.260000e+02, !dbg !84
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !84
  %add.i.i.1 = fadd contract float %27, %cond.i.i.1, !dbg !84
  %28 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !84
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !84
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %28, !dbg !84
  %acc_s.sroa.0.8.vec.extract622 = extractelement <4 x float> %24, i64 2, !dbg !78
  %mul237.2 = fmul contract float %acc_s.sroa.0.8.vec.extract622, 0x3FC2776C60000000, !dbg !79
  %29 = tail call contract noundef float @llvm.minnum.f32(float %mul237.2, float 1.500000e+01), !dbg !80
  %cmp.i.i.2 = fcmp contract olt float %29, -1.260000e+02, !dbg !84
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !84
  %add.i.i.2 = fadd contract float %29, %cond.i.i.2, !dbg !84
  %30 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !84
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !84
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %30, !dbg !84
  %acc_s.sroa.0.12.vec.extract635 = extractelement <4 x float> %24, i64 3, !dbg !78
  %mul237.3 = fmul contract float %acc_s.sroa.0.12.vec.extract635, 0x3FC2776C60000000, !dbg !79
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul237.3, float 1.500000e+01), !dbg !80
  %cmp.i.i.3 = fcmp contract olt float %31, -1.260000e+02, !dbg !84
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !84
  %add.i.i.3 = fadd contract float %31, %cond.i.i.3, !dbg !84
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !84
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !84
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %32, !dbg !84
  %add253 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !87
  %add253.1 = fadd contract float %add253, %mul.i.i.1, !dbg !87
  %add253.2 = fadd contract float %add253.1, %mul.i.i.2, !dbg !87
  %add253.3 = fadd contract float %add253.2, %mul.i.i.3, !dbg !87
  %33 = bitcast float %add253.3 to i32, !dbg !88
  %34 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !92
  %35 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %34) #10, !dbg !97
  %xor.i.i = xor i32 %35, 32, !dbg !98
  %36 = and i32 %35, -64, !dbg !99
  %and.i.i = add nsw i32 %36, 64, !dbg !99
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !100
  %cond.i.i505 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %35, !dbg !101
  %shl.i.i = shl i32 %cond.i.i505, 2, !dbg !102
  %37 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %33), !dbg !103
  %38 = bitcast i32 %37 to float, !dbg !104
  %add261 = fadd contract float %add253.3, %38, !dbg !105
  %39 = bitcast float %add261 to i32, !dbg !106
  %40 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !108
  %41 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %40) #10, !dbg !111
  %xor.i.i506 = xor i32 %41, 16, !dbg !112
  %42 = and i32 %41, -64, !dbg !113
  %and.i.i507 = add nsw i32 %42, 64, !dbg !113
  %cmp.not.i.i508 = icmp slt i32 %xor.i.i506, %and.i.i507, !dbg !114
  %cond.i.i509 = select i1 %cmp.not.i.i508, i32 %xor.i.i506, i32 %41, !dbg !115
  %shl.i.i510 = shl i32 %cond.i.i509, 2, !dbg !116
  %43 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i510, i32 %39), !dbg !117
  %44 = bitcast i32 %43 to float, !dbg !118
  %add266 = fadd contract float %add261, %44, !dbg !119
  %cmp269 = fcmp contract ogt float %add266, 0.000000e+00, !dbg !120
  %div = fdiv contract float 1.000000e+00, %add266, !dbg !121
  %condval_3.0 = select i1 %cmp269, float %div, float 0.000000e+00, !dbg !121
  %mul282 = fmul contract float %condval_3.0, %mul.i.i, !dbg !122
  %mul282.1 = fmul contract float %condval_3.0, %mul.i.i.1, !dbg !122
  %mul282.2 = fmul contract float %condval_3.0, %mul.i.i.2, !dbg !122
  %mul282.3 = fmul contract float %condval_3.0, %mul.i.i.3, !dbg !122
  %45 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !123
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !123, !noalias !131
  %46 = fptrunc float %mul282 to half, !dbg !123
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %45), !dbg !123, !noalias !131
  %47 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !136
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !136, !noalias !131
  %48 = fptrunc float %mul282.1 to half, !dbg !136
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %47), !dbg !136, !noalias !131
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %46, i64 0, !dbg !138
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %48, i64 1, !dbg !138
  %49 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !141
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !141, !noalias !145
  %50 = fptrunc float %mul282.2 to half, !dbg !141
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %49), !dbg !141, !noalias !145
  %51 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !150
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !150, !noalias !145
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %51), !dbg !150, !noalias !145
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %50, i64 2, !dbg !152
  fence syncscope("warp") release, !dbg !154
  tail call void @llvm.mxc.barrier.warp(), !dbg !159
  fence syncscope("warp") acquire, !dbg !160
  %mul312 = and i32 %add.ptr227.idx, 16128
  %add319 = or disjoint i32 %mul312, %and48, !dbg !161
  %arrayidx321 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319, !dbg !162
  %52 = load half, ptr addrspace(3) %arrayidx321, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %52, i64 0, !dbg !163
  %add314.1 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.1 = or disjoint i32 %add314.1, 64, !dbg !161
  %arrayidx321.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1, !dbg !162
  %53 = load half, ptr addrspace(3) %arrayidx321.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %53, i64 1, !dbg !163
  %add314.2 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.2 = or disjoint i32 %add314.2, 128, !dbg !161
  %arrayidx321.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2, !dbg !162
  %54 = load half, ptr addrspace(3) %arrayidx321.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %54, i64 2, !dbg !163
  %add314.3 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.3 = or disjoint i32 %add314.3, 192, !dbg !161
  %arrayidx321.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3, !dbg !162
  %55 = load half, ptr addrspace(3) %arrayidx321.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %55, i64 3, !dbg !163
  %add316.1571 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.1572 = or disjoint i32 %add316.1571, 16, !dbg !161
  %arrayidx321.1573 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1572, !dbg !162
  %56 = load half, ptr addrspace(3) %arrayidx321.1573, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %56, i64 0, !dbg !163
  %add316.1.1 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.1.1 = or disjoint i32 %add316.1.1, 80, !dbg !161
  %arrayidx321.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1.1, !dbg !162
  %57 = load half, ptr addrspace(3) %arrayidx321.1.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %57, i64 1, !dbg !163
  %add316.2.1 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.2.1 = or disjoint i32 %add316.2.1, 144, !dbg !161
  %arrayidx321.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2.1, !dbg !162
  %58 = load half, ptr addrspace(3) %arrayidx321.2.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %58, i64 2, !dbg !163
  %add316.3.1 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.3.1 = or disjoint i32 %add316.3.1, 208, !dbg !161
  %arrayidx321.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3.1, !dbg !162
  %59 = load half, ptr addrspace(3) %arrayidx321.3.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %59, i64 3, !dbg !163
  %add316.2575 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.2576 = or disjoint i32 %add316.2575, 32, !dbg !161
  %arrayidx321.2577 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2576, !dbg !162
  %60 = load half, ptr addrspace(3) %arrayidx321.2577, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %60, i64 0, !dbg !163
  %add316.1.2 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.1.2 = or disjoint i32 %add316.1.2, 96, !dbg !161
  %arrayidx321.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1.2, !dbg !162
  %61 = load half, ptr addrspace(3) %arrayidx321.1.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %61, i64 1, !dbg !163
  %add316.2.2 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.2.2 = or disjoint i32 %add316.2.2, 160, !dbg !161
  %arrayidx321.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2.2, !dbg !162
  %62 = load half, ptr addrspace(3) %arrayidx321.2.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %62, i64 2, !dbg !163
  %add316.3.2 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.3.2 = or disjoint i32 %add316.3.2, 224, !dbg !161
  %arrayidx321.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3.2, !dbg !162
  %63 = load half, ptr addrspace(3) %arrayidx321.3.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %63, i64 3, !dbg !163
  %add316.3579 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.3580 = or disjoint i32 %add316.3579, 48, !dbg !161
  %arrayidx321.3581 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3580, !dbg !162
  %64 = load half, ptr addrspace(3) %arrayidx321.3581, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !163
  %add316.1.3 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.1.3 = or disjoint i32 %add316.1.3, 112, !dbg !161
  %arrayidx321.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1.3, !dbg !162
  %65 = load half, ptr addrspace(3) %arrayidx321.1.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %65, i64 1, !dbg !163
  %add316.2.3 = or disjoint i32 %mul312, %and48, !dbg !161
  %add319.2.3 = or disjoint i32 %add316.2.3, 176, !dbg !161
  %arrayidx321.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2.3, !dbg !162
  %66 = load half, ptr addrspace(3) %arrayidx321.2.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %66, i64 2, !dbg !163
  %add316.3.3 = or disjoint i32 %add.ptr227.idx, %and48, !dbg !161
  %add319.3.3 = or i32 %add316.3.3, 240, !dbg !161
  %arrayidx321.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3.3, !dbg !162
  %67 = load half, ptr addrspace(3) %arrayidx321.3.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %67, i64 3, !dbg !163
  %68 = fptrunc float %mul282.3 to half, !dbg !150
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %68, i64 3, !dbg !152
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !165
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !165
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !165
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !165
  br label %if.end350

if.end350:                                        ; preds = %if.end184, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %69, %if.end184 ], [ zeroinitializer, %entry ], !dbg !59
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %70, %if.end184 ], [ zeroinitializer, %entry ], !dbg !59
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %71, %if.end184 ], [ zeroinitializer, %entry ], !dbg !59
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %72, %if.end184 ], [ zeroinitializer, %entry ], !dbg !59
  %73 = lshr i32 %2, 2
  %mul386 = and i32 %73, 252
  %add383 = add nuw nsw i32 %add10, %mul386
  %74 = zext nneg i32 %add383 to i64, !dbg !166
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !167
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !167
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !167
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !167
  %75 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !168, !noalias !172
  %76 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %75), !dbg !168, !noalias !172
  %77 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !177, !noalias !172
  %78 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %77), !dbg !177, !noalias !172
  %79 = bitcast half %76 to i16, !dbg !179
  %80 = bitcast half %78 to i16, !dbg !182
  %81 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !183, !noalias !187
  %82 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %81), !dbg !183, !noalias !187
  %83 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !192, !noalias !187
  %84 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %83), !dbg !192, !noalias !187
  %85 = bitcast half %82 to i16, !dbg !194
  %86 = bitcast half %84 to i16, !dbg !196
  %__2.sroa.6.0.insert.ext = zext i16 %86 to i64, !dbg !197
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !197
  %__2.sroa.5.0.insert.ext = zext i16 %85 to i64, !dbg !197
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !197
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !197
  %__2.sroa.4.0.insert.ext = zext i16 %80 to i64, !dbg !197
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !197
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !197
  %__2.sroa.0.0.insert.ext = zext i16 %79 to i64, !dbg !197
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !197
  %add.ptr389 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74, !dbg !198
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr389, align 8, !dbg !199
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !167
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !167
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !167
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !167
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !168, !noalias !172
  %88 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !dbg !168, !noalias !172
  %89 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !177, !noalias !172
  %90 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %89), !dbg !177, !noalias !172
  %91 = bitcast half %88 to i16, !dbg !179
  %92 = bitcast half %90 to i16, !dbg !182
  %93 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !183, !noalias !187
  %94 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %93), !dbg !183, !noalias !187
  %95 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !192, !noalias !187
  %96 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %95), !dbg !192, !noalias !187
  %97 = bitcast half %94 to i16, !dbg !194
  %98 = bitcast half %96 to i16, !dbg !196
  %__2.sroa.6.0.insert.ext.1 = zext i16 %98 to i64, !dbg !197
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !197
  %__2.sroa.5.0.insert.ext.1 = zext i16 %97 to i64, !dbg !197
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !197
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !197
  %__2.sroa.4.0.insert.ext.1 = zext i16 %92 to i64, !dbg !197
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !197
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !197
  %__2.sroa.0.0.insert.ext.1 = zext i16 %91 to i64, !dbg !197
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !197
  %99 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74, !dbg !198
  %add.ptr389.1 = getelementptr inbounds i8, ptr addrspace(1) %99, i64 32, !dbg !198
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr389.1, align 8, !dbg !199
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !167
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !167
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !167
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !167
  %100 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !168, !noalias !172
  %101 = fptrunc float %acc_o.sroa.22.32.vec.extract to half, !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %100), !dbg !168, !noalias !172
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !177, !noalias !172
  %103 = fptrunc float %acc_o.sroa.22.36.vec.extract to half, !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !dbg !177, !noalias !172
  %104 = bitcast half %101 to i16, !dbg !179
  %105 = bitcast half %103 to i16, !dbg !182
  %106 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !183, !noalias !187
  %107 = fptrunc float %acc_o.sroa.22.40.vec.extract to half, !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %106), !dbg !183, !noalias !187
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !192, !noalias !187
  %109 = fptrunc float %acc_o.sroa.22.44.vec.extract to half, !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !dbg !192, !noalias !187
  %110 = bitcast half %107 to i16, !dbg !194
  %111 = bitcast half %109 to i16, !dbg !196
  %__2.sroa.6.0.insert.ext.2 = zext i16 %111 to i64, !dbg !197
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !197
  %__2.sroa.5.0.insert.ext.2 = zext i16 %110 to i64, !dbg !197
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !197
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !197
  %__2.sroa.4.0.insert.ext.2 = zext i16 %105 to i64, !dbg !197
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !197
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !197
  %__2.sroa.0.0.insert.ext.2 = zext i16 %104 to i64, !dbg !197
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !197
  %112 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74, !dbg !198
  %add.ptr389.2 = getelementptr inbounds i8, ptr addrspace(1) %112, i64 64, !dbg !198
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr389.2, align 8, !dbg !199
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !167
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !167
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !167
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !167
  %113 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !168, !noalias !172
  %114 = fptrunc float %acc_o.sroa.32.48.vec.extract to half, !dbg !168
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %113), !dbg !168, !noalias !172
  %115 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !177, !noalias !172
  %116 = fptrunc float %acc_o.sroa.32.52.vec.extract to half, !dbg !177
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %115), !dbg !177, !noalias !172
  %117 = bitcast half %114 to i16, !dbg !179
  %118 = bitcast half %116 to i16, !dbg !182
  %119 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !183, !noalias !187
  %120 = fptrunc float %acc_o.sroa.32.56.vec.extract to half, !dbg !183
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %119), !dbg !183, !noalias !187
  %121 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !192, !noalias !187
  %122 = fptrunc float %acc_o.sroa.32.60.vec.extract to half, !dbg !192
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %121), !dbg !192, !noalias !187
  %123 = bitcast half %120 to i16, !dbg !194
  %124 = bitcast half %122 to i16, !dbg !196
  %__2.sroa.6.0.insert.ext.3 = zext i16 %124 to i64, !dbg !197
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !197
  %__2.sroa.5.0.insert.ext.3 = zext i16 %123 to i64, !dbg !197
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !197
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !197
  %__2.sroa.4.0.insert.ext.3 = zext i16 %118 to i64, !dbg !197
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !197
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !197
  %__2.sroa.0.0.insert.ext.3 = zext i16 %117 to i64, !dbg !197
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !197
  %125 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74, !dbg !198
  %add.ptr389.3 = getelementptr inbounds i8, ptr addrspace(1) %125, i64 96, !dbg !198
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr389.3, align 8, !dbg !199
  ret void, !dbg !200
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

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(inaccessiblemem: read)
declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

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
attributes #10 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpyvxrjucj/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpyvxrjucj/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 22, column: 3, scope: !40)
!44 = !DILocation(line: 23, column: 46, scope: !40)
!45 = !DILocation(line: 23, column: 32, scope: !40)
!46 = !DILocation(line: 25, column: 47, scope: !40)
!47 = !DILocation(line: 25, column: 52, scope: !40)
!48 = !DILocation(line: 25, column: 14, scope: !40)
!49 = !DILocation(line: 25, column: 74, scope: !40)
!50 = !DILocation(line: 31, column: 11, scope: !40)
!51 = !DILocation(line: 31, column: 19, scope: !40)
!52 = !DILocation(line: 31, column: 27, scope: !40)
!53 = !DILocation(line: 31, column: 34, scope: !40)
!54 = !DILocation(line: 33, column: 5, scope: !40)
!55 = !DILocation(line: 36, column: 11, scope: !40)
!56 = !DILocation(line: 37, column: 31, scope: !40)
!57 = !DILocation(line: 37, column: 17, scope: !40)
!58 = !DILocation(line: 38, column: 7, scope: !40)
!59 = !DILocation(line: 0, scope: !40)
!60 = !DILocation(line: 44, column: 5, scope: !40)
!61 = !DILocation(line: 47, column: 61, scope: !40)
!62 = !DILocation(line: 47, column: 11, scope: !40)
!63 = !DILocation(line: 58, column: 62, scope: !40)
!64 = !DILocation(line: 58, column: 13, scope: !40)
!65 = !DILocation(line: 63, column: 20, scope: !40)
!66 = !DILocation(line: 58, column: 55, scope: !40)
!67 = !DILocation(line: 48, column: 33, scope: !40)
!68 = !DILocation(line: 48, column: 19, scope: !40)
!69 = !DILocation(line: 49, column: 7, scope: !40)
!70 = !DILocation(line: 54, column: 34, scope: !40)
!71 = !DILocation(line: 54, column: 27, scope: !40)
!72 = !DILocation(line: 54, column: 9, scope: !40)
!73 = !DILocation(line: 72, column: 36, scope: !40)
!74 = !{i32 -1, i32 3, i32 -1}
!75 = !DILocation(line: 79, column: 5, scope: !40)
!76 = !DILocation(line: 80, column: 70, scope: !40)
!77 = !DILocation(line: 80, column: 26, scope: !40)
!78 = !DILocation(line: 84, column: 31, scope: !40)
!79 = !DILocation(line: 84, column: 42, scope: !40)
!80 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !83)
!81 = distinct !DISubprogram(name: "min", scope: !82, file: !82, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!82 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!83 = distinct !DILocation(line: 84, column: 26, scope: !40)
!84 = !DILocation(line: 285, column: 49, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "exp2f", scope: !82, file: !82, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!86 = distinct !DILocation(line: 84, column: 20, scope: !40)
!87 = !DILocation(line: 89, column: 34, scope: !40)
!88 = !DILocation(line: 1018, column: 9, scope: !89, inlinedAt: !91)
!89 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !90, file: !90, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!90 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!91 = distinct !DILocation(line: 91, column: 34, scope: !40)
!92 = !DILocation(line: 171, column: 37, scope: !93, inlinedAt: !94)
!93 = distinct !DISubprogram(name: "__lane_id", scope: !90, file: !90, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!94 = distinct !DILocation(line: 990, column: 14, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !90, file: !90, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 1019, column: 11, scope: !89, inlinedAt: !91)
!97 = !DILocation(line: 171, column: 10, scope: !93, inlinedAt: !94)
!98 = !DILocation(line: 991, column: 20, scope: !95, inlinedAt: !96)
!99 = !DILocation(line: 992, column: 36, scope: !95, inlinedAt: !96)
!100 = !DILocation(line: 992, column: 17, scope: !95, inlinedAt: !96)
!101 = !DILocation(line: 992, column: 11, scope: !95, inlinedAt: !96)
!102 = !DILocation(line: 993, column: 43, scope: !95, inlinedAt: !96)
!103 = !DILocation(line: 993, column: 10, scope: !95, inlinedAt: !96)
!104 = !DILocation(line: 1020, column: 14, scope: !89, inlinedAt: !91)
!105 = !DILocation(line: 91, column: 32, scope: !40)
!106 = !DILocation(line: 1018, column: 9, scope: !89, inlinedAt: !107)
!107 = distinct !DILocation(line: 92, column: 34, scope: !40)
!108 = !DILocation(line: 171, column: 37, scope: !93, inlinedAt: !109)
!109 = distinct !DILocation(line: 990, column: 14, scope: !95, inlinedAt: !110)
!110 = distinct !DILocation(line: 1019, column: 11, scope: !89, inlinedAt: !107)
!111 = !DILocation(line: 171, column: 10, scope: !93, inlinedAt: !109)
!112 = !DILocation(line: 991, column: 20, scope: !95, inlinedAt: !110)
!113 = !DILocation(line: 992, column: 36, scope: !95, inlinedAt: !110)
!114 = !DILocation(line: 992, column: 17, scope: !95, inlinedAt: !110)
!115 = !DILocation(line: 992, column: 11, scope: !95, inlinedAt: !110)
!116 = !DILocation(line: 993, column: 43, scope: !95, inlinedAt: !110)
!117 = !DILocation(line: 993, column: 10, scope: !95, inlinedAt: !110)
!118 = !DILocation(line: 1020, column: 14, scope: !89, inlinedAt: !107)
!119 = !DILocation(line: 92, column: 32, scope: !40)
!120 = !DILocation(line: 94, column: 34, scope: !40)
!121 = !DILocation(line: 94, column: 9, scope: !40)
!122 = !DILocation(line: 102, column: 32, scope: !40)
!123 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !126)
!124 = distinct !DISubprogram(name: "__float2half_rn", scope: !125, file: !125, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!126 = distinct !DILocation(line: 1077, column: 18, scope: !127, inlinedAt: !128)
!127 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !125, file: !125, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!128 = distinct !DILocation(line: 1295, column: 23, scope: !129, inlinedAt: !130)
!129 = distinct !DISubprogram(name: "__float22half2_rn", scope: !125, file: !125, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!130 = distinct !DILocation(line: 106, column: 27, scope: !40)
!131 = !{!132, !134}
!132 = distinct !{!132, !133, !"_ZL17__floats2half2_rnff: %agg.result"}
!133 = distinct !{!133, !"_ZL17__floats2half2_rnff"}
!134 = distinct !{!134, !135, !"_ZL17__float22half2_rn6float2: %agg.result"}
!135 = distinct !{!135, !"_ZL17__float22half2_rn6float2"}
!136 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !137)
!137 = distinct !DILocation(line: 1077, column: 38, scope: !127, inlinedAt: !128)
!138 = !DILocation(line: 593, column: 26, scope: !139, inlinedAt: !140)
!139 = distinct !DISubprogram(name: "operator=", scope: !125, file: !125, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!140 = distinct !DILocation(line: 106, column: 25, scope: !40)
!141 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !142)
!142 = distinct !DILocation(line: 1077, column: 18, scope: !127, inlinedAt: !143)
!143 = distinct !DILocation(line: 1295, column: 23, scope: !129, inlinedAt: !144)
!144 = distinct !DILocation(line: 107, column: 27, scope: !40)
!145 = !{!146, !148}
!146 = distinct !{!146, !147, !"_ZL17__floats2half2_rnff: %agg.result"}
!147 = distinct !{!147, !"_ZL17__floats2half2_rnff"}
!148 = distinct !{!148, !149, !"_ZL17__float22half2_rn6float2: %agg.result"}
!149 = distinct !{!149, !"_ZL17__float22half2_rn6float2"}
!150 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !151)
!151 = distinct !DILocation(line: 1077, column: 38, scope: !127, inlinedAt: !143)
!152 = !DILocation(line: 593, column: 26, scope: !139, inlinedAt: !153)
!153 = distinct !DILocation(line: 107, column: 25, scope: !40)
!154 = !DILocation(line: 68, column: 3, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "__barrier_warp", scope: !90, file: !90, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!156 = distinct !DILocation(line: 192, column: 3, scope: !157, inlinedAt: !158)
!157 = distinct !DISubprogram(name: "__syncwarp", scope: !90, file: !90, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!158 = distinct !DILocation(line: 109, column: 5, scope: !40)
!159 = !DILocation(line: 69, column: 3, scope: !155, inlinedAt: !156)
!160 = !DILocation(line: 70, column: 3, scope: !155, inlinedAt: !156)
!161 = !DILocation(line: 112, column: 103, scope: !40)
!162 = !DILocation(line: 112, column: 31, scope: !40)
!163 = !DILocation(line: 112, column: 29, scope: !40)
!164 = !{!26, !26, i64 0}
!165 = !DILocation(line: 117, column: 38, scope: !40)
!166 = !DILocation(line: 124, column: 3, scope: !40)
!167 = !DILocation(line: 126, column: 19, scope: !40)
!168 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !169)
!169 = distinct !DILocation(line: 1077, column: 18, scope: !127, inlinedAt: !170)
!170 = distinct !DILocation(line: 1295, column: 23, scope: !129, inlinedAt: !171)
!171 = distinct !DILocation(line: 127, column: 27, scope: !40)
!172 = !{!173, !175}
!173 = distinct !{!173, !174, !"_ZL17__floats2half2_rnff: %agg.result"}
!174 = distinct !{!174, !"_ZL17__floats2half2_rnff"}
!175 = distinct !{!175, !176, !"_ZL17__float22half2_rn6float2: %agg.result"}
!176 = distinct !{!176, !"_ZL17__float22half2_rn6float2"}
!177 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !178)
!178 = distinct !DILocation(line: 1077, column: 38, scope: !127, inlinedAt: !170)
!179 = !DILocation(line: 596, column: 67, scope: !180, inlinedAt: !181)
!180 = distinct !DISubprogram(name: "__half2", scope: !125, file: !125, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!181 = distinct !DILocation(line: 1077, column: 10, scope: !127, inlinedAt: !170)
!182 = !DILocation(line: 596, column: 73, scope: !180, inlinedAt: !181)
!183 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !184)
!184 = distinct !DILocation(line: 1077, column: 18, scope: !127, inlinedAt: !185)
!185 = distinct !DILocation(line: 1295, column: 23, scope: !129, inlinedAt: !186)
!186 = distinct !DILocation(line: 128, column: 27, scope: !40)
!187 = !{!188, !190}
!188 = distinct !{!188, !189, !"_ZL17__floats2half2_rnff: %agg.result"}
!189 = distinct !{!189, !"_ZL17__floats2half2_rnff"}
!190 = distinct !{!190, !191, !"_ZL17__float22half2_rn6float2: %agg.result"}
!191 = distinct !{!191, !"_ZL17__float22half2_rn6float2"}
!192 = !DILocation(line: 1007, column: 10, scope: !124, inlinedAt: !193)
!193 = distinct !DILocation(line: 1077, column: 38, scope: !127, inlinedAt: !185)
!194 = !DILocation(line: 596, column: 67, scope: !180, inlinedAt: !195)
!195 = distinct !DILocation(line: 1077, column: 10, scope: !127, inlinedAt: !185)
!196 = !DILocation(line: 596, column: 73, scope: !180, inlinedAt: !195)
!197 = !DILocation(line: 129, column: 38, scope: !40)
!198 = !DILocation(line: 130, column: 22, scope: !40)
!199 = !DILocation(line: 130, column: 171, scope: !40)
!200 = !DILocation(line: 132, column: 1, scope: !40)
