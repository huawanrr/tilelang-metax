; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d128_b2_h3_t64_c1_m0_p0.bc'
source_filename = "/tmp/tmpwxptc6b8/tvm_kernels.maca"
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %div = udiv i32 %0, 3
  %mul = mul nuw nsw i32 %div, 393216
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = mul nuw nsw i32 %1, 6144
  %add = add nuw nsw i32 %mul, %mul7
  %2 = mul i32 %div, 3
  %rem.decomposed = sub i32 %0, %2
  %mul9 = shl nuw nsw i32 %rem.decomposed, 11
  %add10 = add nuw nsw i32 %add, %mul9
  %3 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %3, 7
  %mul12 = and i32 %and, 1920
  %add13 = or disjoint i32 %add10, %mul12
  %4 = lshr i32 %3, 1
  %mul17 = and i32 %4, 504
  %add15 = add nuw nsw i32 %add13, %mul17
  %5 = zext nneg i32 %add15 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !44
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 128, !dbg !44
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16, !dbg !45
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 136, !dbg !45
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8, !dbg !45
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !44
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 192, !dbg !44
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16, !dbg !45
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 200, !dbg !45
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8, !dbg !45
  %mul24 = mul nuw nsw i32 %div, 192, !dbg !46
  %mul26 = mul nuw nsw i32 %1, 3, !dbg !47
  %add27 = add nuw nsw i32 %rem.decomposed, %mul26, !dbg !48
  %add30 = add nuw nsw i32 %add27, %mul24, !dbg !49
  %idxprom = zext nneg i32 %add30 to i64, !dbg !50
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !50
  %9 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !50, !tbaa !30
  %mul31 = shl nsw i32 %9, 4, !dbg !51
  %cmp45 = icmp sgt i32 %9, -1, !dbg !52
  br i1 %cmp45, label %land.lhs.true, label %if.end412, !dbg !53

land.lhs.true:                                    ; preds = %entry
  %cmp46 = icmp ugt i32 %9, 3, !dbg !54
  %cmp49.not = icmp sgt i32 %mul31, %1
  %or.cond = select i1 %cmp46, i1 true, i1 %cmp49.not, !dbg !55
  br i1 %or.cond, label %if.end412, label %for.cond50.preheader, !dbg !55

for.cond50.preheader:                             ; preds = %land.lhs.true
  %shr56 = lshr i32 %3, 4
  %add57 = add nuw nsw i32 %mul31, %shr56
  %mul64 = mul nuw nsw i32 %div, 24576
  %mul69 = mul nuw nsw i32 %shr56, 384
  %mul71 = mul nuw nsw i32 %9, 6144
  %mul75 = shl nuw nsw i32 %rem.decomposed, 7
  %add66 = add nuw nsw i32 %mul69, %mul64
  %add70 = add nuw nsw i32 %add66, %mul75
  %and78 = shl nuw nsw i32 %3, 3
  %mul79 = and i32 %and78, 120
  %add72 = or disjoint i32 %add70, %mul79
  %add76 = add nuw nsw i32 %add72, %mul71
  %10 = zext nneg i32 %add76 to i64, !dbg !56
  %11 = icmp ult i32 %add57, 64, !dbg !57
  br i1 %11, label %if.then61, label %if.end, !dbg !58

if.then61:                                        ; preds = %for.cond50.preheader
  %add.ptr82 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10, !dbg !59
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr82, align 16, !dbg !60, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr82, i64 4, !dbg !60
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx, align 4, !dbg !60, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr82, i64 8, !dbg !60
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx, align 8, !dbg !60, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr82, i64 12, !dbg !60
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx, align 4, !dbg !60, !tbaa !30
  br label %if.end, !dbg !61

if.end:                                           ; preds = %for.cond50.preheader, %if.then61
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ], !dbg !62
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ], !dbg !62
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ], !dbg !62
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ], !dbg !62
  %12 = icmp ult i32 %add57, 60, !dbg !57
  br i1 %12, label %if.then61.1, label %if.end.1, !dbg !58

if.then61.1:                                      ; preds = %if.end
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10, !dbg !59
  %add.ptr82.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3072, !dbg !59
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr82.1, align 16, !dbg !60, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3076, !dbg !60
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3080, !dbg !60
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx.1, align 8, !dbg !60, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3084, !dbg !60
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  br label %if.end.1, !dbg !61

if.end.1:                                         ; preds = %if.then61.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then61.1 ], [ 0, %if.end ], !dbg !62
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then61.1 ], [ 0, %if.end ], !dbg !62
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then61.1 ], [ 0, %if.end ], !dbg !62
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then61.1 ], [ 0, %if.end ], !dbg !62
  %14 = icmp ult i32 %add57, 56, !dbg !57
  br i1 %14, label %if.then61.2, label %if.end.2, !dbg !58

if.then61.2:                                      ; preds = %if.end.1
  %15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10, !dbg !59
  %add.ptr82.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6144, !dbg !59
  %condval.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr82.2, align 16, !dbg !60, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6148, !dbg !60
  %condval.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6152, !dbg !60
  %condval.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx.2, align 8, !dbg !60, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6156, !dbg !60
  %condval.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  br label %if.end.2, !dbg !61

if.end.2:                                         ; preds = %if.then61.2, %if.end.1
  %condval.sroa.0.0.2 = phi i32 [ %condval.sroa.0.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ], !dbg !62
  %condval.sroa.5.0.2 = phi i32 [ %condval.sroa.5.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ], !dbg !62
  %condval.sroa.6.0.2 = phi i32 [ %condval.sroa.6.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ], !dbg !62
  %condval.sroa.7.0.2 = phi i32 [ %condval.sroa.7.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ], !dbg !62
  %16 = icmp ult i32 %add57, 52, !dbg !57
  br i1 %16, label %if.then61.3, label %if.end.3, !dbg !58

if.then61.3:                                      ; preds = %if.end.2
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10, !dbg !59
  %add.ptr82.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9216, !dbg !59
  %condval.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr82.3, align 16, !dbg !60, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9220, !dbg !60
  %condval.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9224, !dbg !60
  %condval.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx.3, align 8, !dbg !60, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9228, !dbg !60
  %condval.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  br label %if.end.3, !dbg !61

if.end.3:                                         ; preds = %if.then61.3, %if.end.2
  %condval.sroa.0.0.3 = phi i32 [ %condval.sroa.0.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ], !dbg !62
  %condval.sroa.5.0.3 = phi i32 [ %condval.sroa.5.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ], !dbg !62
  %condval.sroa.6.0.3 = phi i32 [ %condval.sroa.6.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ], !dbg !62
  %condval.sroa.7.0.3 = phi i32 [ %condval.sroa.7.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ], !dbg !62
  br i1 %11, label %if.then121, label %if.end166, !dbg !63

if.then121:                                       ; preds = %if.end.3
  %add.ptr142 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10, !dbg !64
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr142, align 16, !dbg !65, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 4, !dbg !65
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx, align 4, !dbg !65, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 8, !dbg !65
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx, align 8, !dbg !65, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 12, !dbg !65
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx, align 4, !dbg !65, !tbaa !30
  br label %if.end166, !dbg !66

if.end166:                                        ; preds = %if.end.3, %if.then121
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then121 ], [ 0, %if.end.3 ], !dbg !62
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then121 ], [ 0, %if.end.3 ], !dbg !62
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then121 ], [ 0, %if.end.3 ], !dbg !62
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then121 ], [ 0, %if.end.3 ], !dbg !62
  br i1 %12, label %if.then121.1, label %if.end166.1, !dbg !63

if.then121.1:                                     ; preds = %if.end166
  %18 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10, !dbg !64
  %add.ptr142.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3072, !dbg !64
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr142.1, align 16, !dbg !65, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3076, !dbg !65
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx.1, align 4, !dbg !65, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3080, !dbg !65
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx.1, align 8, !dbg !65, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3084, !dbg !65
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx.1, align 4, !dbg !65, !tbaa !30
  br label %if.end166.1, !dbg !66

if.end166.1:                                      ; preds = %if.then121.1, %if.end166
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ], !dbg !62
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ], !dbg !62
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ], !dbg !62
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ], !dbg !62
  br i1 %14, label %if.then121.2, label %if.end166.2, !dbg !63

if.then121.2:                                     ; preds = %if.end166.1
  %19 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10, !dbg !64
  %add.ptr142.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6144, !dbg !64
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr142.2, align 16, !dbg !65, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6148, !dbg !65
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx.2, align 4, !dbg !65, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6152, !dbg !65
  %condval_1.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx.2, align 8, !dbg !65, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6156, !dbg !65
  %condval_1.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx.2, align 4, !dbg !65, !tbaa !30
  br label %if.end166.2, !dbg !66

if.end166.2:                                      ; preds = %if.then121.2, %if.end166.1
  %condval_1.sroa.0.0.2 = phi i32 [ %condval_1.sroa.0.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ], !dbg !62
  %condval_1.sroa.5.0.2 = phi i32 [ %condval_1.sroa.5.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ], !dbg !62
  %condval_1.sroa.6.0.2 = phi i32 [ %condval_1.sroa.6.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ], !dbg !62
  %condval_1.sroa.7.0.2 = phi i32 [ %condval_1.sroa.7.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ], !dbg !62
  br i1 %16, label %if.then121.3, label %if.end166.3, !dbg !63

if.then121.3:                                     ; preds = %if.end166.2
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10, !dbg !64
  %add.ptr142.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9216, !dbg !64
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr142.3, align 16, !dbg !65, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9220, !dbg !65
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx.3, align 4, !dbg !65, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9224, !dbg !65
  %condval_1.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx.3, align 8, !dbg !65, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9228, !dbg !65
  %condval_1.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx.3, align 4, !dbg !65, !tbaa !30
  br label %if.end166.3, !dbg !66

if.end166.3:                                      ; preds = %if.then121.3, %if.end166.2
  %condval_1.sroa.0.0.3 = phi i32 [ %condval_1.sroa.0.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ], !dbg !62
  %condval_1.sroa.5.0.3 = phi i32 [ %condval_1.sroa.5.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ], !dbg !62
  %condval_1.sroa.6.0.3 = phi i32 [ %condval_1.sroa.6.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ], !dbg !62
  %condval_1.sroa.7.0.3 = phi i32 [ %condval_1.sroa.7.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ], !dbg !62
  %mul186 = and i32 %and78, 8064
  %and189 = and i32 %3, 15
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul186, !dbg !67
  %xor = xor i32 %shr56, %and189, !dbg !68
  %add.ptr197.idx = shl nuw nsw i32 %xor, 4, !dbg !69
  %add.ptr197 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr197.idx, !dbg !69
  store i32 %condval.sroa.0.0, ptr addrspace(3) %add.ptr197, align 16, !dbg !70, !tbaa !30
  %K_reg.sroa.4.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197, i32 4, !dbg !70
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr197.sroa_idx, align 4, !dbg !70, !tbaa !30
  %K_reg.sroa.5.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197, i32 8, !dbg !70
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr197.sroa_idx, align 8, !dbg !70, !tbaa !30
  %K_reg.sroa.6.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197, i32 12, !dbg !70
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr197.sroa_idx, align 4, !dbg !70, !tbaa !30
  %add193.1 = add nuw nsw i32 %shr56, 4, !dbg !71
  %xor.1 = xor i32 %add193.1, %and189, !dbg !68
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !69
  %add.ptr197.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !69
  %add.ptr197.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr197.idx.1, !dbg !69
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %add.ptr197.1, align 16, !dbg !70, !tbaa !30
  %K_reg.sroa.9.16.add.ptr197.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.1, i32 4, !dbg !70
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr197.1.sroa_idx, align 4, !dbg !70, !tbaa !30
  %K_reg.sroa.10.16.add.ptr197.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.1, i32 8, !dbg !70
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr197.1.sroa_idx, align 8, !dbg !70, !tbaa !30
  %K_reg.sroa.11.16.add.ptr197.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.1, i32 12, !dbg !70
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr197.1.sroa_idx, align 4, !dbg !70, !tbaa !30
  %add193.2 = add nuw nsw i32 %shr56, 8, !dbg !71
  %xor.2 = xor i32 %add193.2, %and189, !dbg !68
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048, !dbg !69
  %add.ptr197.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !69
  %add.ptr197.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr197.idx.2, !dbg !69
  store i32 %condval.sroa.0.0.2, ptr addrspace(3) %add.ptr197.2, align 16, !dbg !70, !tbaa !30
  %K_reg.sroa.14.32.add.ptr197.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.2, i32 4, !dbg !70
  store i32 %condval.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr197.2.sroa_idx, align 4, !dbg !70, !tbaa !30
  %K_reg.sroa.15.32.add.ptr197.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.2, i32 8, !dbg !70
  store i32 %condval.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr197.2.sroa_idx, align 8, !dbg !70, !tbaa !30
  %K_reg.sroa.16.32.add.ptr197.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.2, i32 12, !dbg !70
  store i32 %condval.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr197.2.sroa_idx, align 4, !dbg !70, !tbaa !30
  %add193.3 = add nuw nsw i32 %shr56, 12, !dbg !71
  %xor.3 = xor i32 %add193.3, %and189, !dbg !68
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072, !dbg !69
  %add.ptr197.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !69
  %add.ptr197.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr197.idx.3, !dbg !69
  store i32 %condval.sroa.0.0.3, ptr addrspace(3) %add.ptr197.3, align 16, !dbg !70, !tbaa !30
  %K_reg.sroa.19.48.add.ptr197.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.3, i32 4, !dbg !70
  store i32 %condval.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr197.3.sroa_idx, align 4, !dbg !70, !tbaa !30
  %K_reg.sroa.20.48.add.ptr197.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.3, i32 8, !dbg !70
  store i32 %condval.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr197.3.sroa_idx, align 8, !dbg !70, !tbaa !30
  %K_reg.sroa.21.48.add.ptr197.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.3, i32 12, !dbg !70
  store i32 %condval.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr197.3.sroa_idx, align 4, !dbg !70, !tbaa !30
  %add202 = or disjoint i32 %mul31, 15, !dbg !72
  %cmp203 = icmp slt i32 %1, %add202, !dbg !73
  br i1 %cmp203, label %for.cond205.preheader, label %if.end231, !dbg !74

for.cond205.preheader:                            ; preds = %if.end166.3
  %21 = lshr i32 %3, 2
  %mul212 = and i32 %21, 252
  %add213 = add nuw nsw i32 %mul31, %mul212
  %cmp216.not = icmp sgt i32 %add213, %1, !dbg !75
  %spec.select = select i1 %cmp216.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !76
  %acc_s.sroa.0.0.vec.insert687 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !77
  %cmp216.not.1.not = icmp slt i32 %add213, %1, !dbg !75
  %spec.select.1 = select i1 %cmp216.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !76
  %acc_s.sroa.0.4.vec.insert700 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert687, float %spec.select.1, i64 1, !dbg !77
  %add214.2 = or disjoint i32 %add213, 2, !dbg !78
  %cmp216.not.2 = icmp sgt i32 %add214.2, %1, !dbg !75
  %spec.select.2 = select i1 %cmp216.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !76
  %acc_s.sroa.0.8.vec.insert713 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert700, float %spec.select.2, i64 2, !dbg !77
  %add214.3 = or disjoint i32 %add213, 3, !dbg !78
  %cmp216.not.3 = icmp sgt i32 %add214.3, %1, !dbg !75
  %spec.select.3 = select i1 %cmp216.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !76
  %acc_s.sroa.0.12.vec.insert726 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert713, float %spec.select.3, i64 3, !dbg !77
  br label %if.end231, !dbg !79

if.end231:                                        ; preds = %if.end166.3, %for.cond205.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert726, %for.cond205.preheader ], [ zeroinitializer, %if.end166.3 ], !dbg !62
  fence syncscope("warp") release, !dbg !79
  tail call void @llvm.mxc.barrier.warp(), !dbg !85
  fence syncscope("warp") acquire, !dbg !86
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul12
  %add.ptr250 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx, !dbg !87
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr250, align 16, !dbg !88
  %kb.sroa.10.0.add.ptr250.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250, i32 8, !dbg !88
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.sroa_idx, align 8, !dbg !88
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !89, !call_argsrelate !90
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23), !dbg !89, !call_argsrelate !90
  %add.ptr250.1 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx.1, !dbg !87
  %kb.sroa.0.0.copyload675 = load <4 x half>, ptr addrspace(3) %add.ptr250.1, align 16, !dbg !88
  %kb.sroa.10.0.add.ptr250.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250.1, i32 8, !dbg !88
  %kb.sroa.10.0.copyload678 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.1.sroa_idx, align 8, !dbg !88
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload675, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !dbg !89, !call_argsrelate !90
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload678, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !dbg !89, !call_argsrelate !90
  %add.ptr250.2 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx.2, !dbg !87
  %kb.sroa.0.0.copyload676 = load <4 x half>, ptr addrspace(3) %add.ptr250.2, align 16, !dbg !88
  %kb.sroa.10.0.add.ptr250.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250.2, i32 8, !dbg !88
  %kb.sroa.10.0.copyload679 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.2.sroa_idx, align 8, !dbg !88
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload676, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %26), !dbg !89, !call_argsrelate !90
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload679, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %27), !dbg !89, !call_argsrelate !90
  %add.ptr250.3 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx.3, !dbg !87
  %kb.sroa.0.0.copyload677 = load <4 x half>, ptr addrspace(3) %add.ptr250.3, align 16, !dbg !88
  %kb.sroa.10.0.add.ptr250.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250.3, i32 8, !dbg !88
  %kb.sroa.10.0.copyload680 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.3.sroa_idx, align 8, !dbg !88
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload677, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %28), !dbg !89, !call_argsrelate !90
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload680, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %29), !dbg !89, !call_argsrelate !90
  fence syncscope("warp") release, !dbg !91
  tail call void @llvm.mxc.barrier.warp(), !dbg !94
  fence syncscope("warp") acquire, !dbg !95
  %add.ptr288.idx = shl nuw nsw i32 %3, 4
  %invariant.gep621 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr288.idx, !dbg !96
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep621, align 16, !dbg !97, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 4, !dbg !97
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep621.sroa_idx, align 4, !dbg !97, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 8, !dbg !97
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep621.sroa_idx, align 8, !dbg !97, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 12, !dbg !97
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep621.sroa_idx, align 4, !dbg !97, !tbaa !30
  %gep622.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1024, !dbg !98
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep622.1, align 16, !dbg !97, !tbaa !30
  %V_reg.sroa.9.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1028, !dbg !97
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep622.1.sroa_idx, align 4, !dbg !97, !tbaa !30
  %V_reg.sroa.10.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1032, !dbg !97
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep622.1.sroa_idx, align 8, !dbg !97, !tbaa !30
  %V_reg.sroa.11.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1036, !dbg !97
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep622.1.sroa_idx, align 4, !dbg !97, !tbaa !30
  %gep622.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2048, !dbg !98
  store i32 %condval_1.sroa.0.0.2, ptr addrspace(3) %gep622.2, align 16, !dbg !97, !tbaa !30
  %V_reg.sroa.14.32.gep622.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2052, !dbg !97
  store i32 %condval_1.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep622.2.sroa_idx, align 4, !dbg !97, !tbaa !30
  %V_reg.sroa.15.32.gep622.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2056, !dbg !97
  store i32 %condval_1.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep622.2.sroa_idx, align 8, !dbg !97, !tbaa !30
  %V_reg.sroa.16.32.gep622.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2060, !dbg !97
  store i32 %condval_1.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep622.2.sroa_idx, align 4, !dbg !97, !tbaa !30
  %gep622.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3072, !dbg !98
  store i32 %condval_1.sroa.0.0.3, ptr addrspace(3) %gep622.3, align 16, !dbg !97, !tbaa !30
  %V_reg.sroa.19.48.gep622.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3076, !dbg !97
  store i32 %condval_1.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep622.3.sroa_idx, align 4, !dbg !97, !tbaa !30
  %V_reg.sroa.20.48.gep622.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3080, !dbg !97
  store i32 %condval_1.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep622.3.sroa_idx, align 8, !dbg !97, !tbaa !30
  %V_reg.sroa.21.48.gep622.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3084, !dbg !97
  store i32 %condval_1.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep622.3.sroa_idx, align 4, !dbg !97, !tbaa !30
  %acc_s.sroa.0.0.vec.extract689 = extractelement <4 x float> %30, i64 0, !dbg !99
  %mul298 = fmul contract float %acc_s.sroa.0.0.vec.extract689, 0x3FC2776C60000000, !dbg !100
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul298, float 1.500000e+01), !dbg !101
  %cmp.i.i = fcmp contract olt float %31, -1.260000e+02, !dbg !105
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i = fadd contract float %31, %cond.i.i, !dbg !105
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !105
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i = fmul contract float %cond2.i.i, %32, !dbg !105
  %acc_s.sroa.0.4.vec.extract702 = extractelement <4 x float> %30, i64 1, !dbg !99
  %mul298.1 = fmul contract float %acc_s.sroa.0.4.vec.extract702, 0x3FC2776C60000000, !dbg !100
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul298.1, float 1.500000e+01), !dbg !101
  %cmp.i.i.1 = fcmp contract olt float %33, -1.260000e+02, !dbg !105
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i.1 = fadd contract float %33, %cond.i.i.1, !dbg !105
  %34 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !105
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %34, !dbg !105
  %acc_s.sroa.0.8.vec.extract715 = extractelement <4 x float> %30, i64 2, !dbg !99
  %mul298.2 = fmul contract float %acc_s.sroa.0.8.vec.extract715, 0x3FC2776C60000000, !dbg !100
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul298.2, float 1.500000e+01), !dbg !101
  %cmp.i.i.2 = fcmp contract olt float %35, -1.260000e+02, !dbg !105
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i.2 = fadd contract float %35, %cond.i.i.2, !dbg !105
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !105
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %36, !dbg !105
  %acc_s.sroa.0.12.vec.extract728 = extractelement <4 x float> %30, i64 3, !dbg !99
  %mul298.3 = fmul contract float %acc_s.sroa.0.12.vec.extract728, 0x3FC2776C60000000, !dbg !100
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul298.3, float 1.500000e+01), !dbg !101
  %cmp.i.i.3 = fcmp contract olt float %37, -1.260000e+02, !dbg !105
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i.3 = fadd contract float %37, %cond.i.i.3, !dbg !105
  %38 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !105
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %38, !dbg !105
  %add314 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !108
  %add314.1 = fadd contract float %add314, %mul.i.i.1, !dbg !108
  %add314.2 = fadd contract float %add314.1, %mul.i.i.2, !dbg !108
  %add314.3 = fadd contract float %add314.2, %mul.i.i.3, !dbg !108
  %39 = bitcast float %add314.3 to i32, !dbg !109
  %40 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !112
  %41 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %40) #10, !dbg !117
  %xor.i.i = xor i32 %41, 32, !dbg !118
  %42 = and i32 %41, -64, !dbg !119
  %and.i.i = add nsw i32 %42, 64, !dbg !119
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !120
  %cond.i.i577 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %41, !dbg !121
  %shl.i.i = shl i32 %cond.i.i577, 2, !dbg !122
  %43 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %39), !dbg !123
  %44 = bitcast i32 %43 to float, !dbg !124
  %add322 = fadd contract float %add314.3, %44, !dbg !125
  %45 = bitcast float %add322 to i32, !dbg !126
  %46 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !128
  %47 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %46) #10, !dbg !131
  %xor.i.i578 = xor i32 %47, 16, !dbg !132
  %48 = and i32 %47, -64, !dbg !133
  %and.i.i579 = add nsw i32 %48, 64, !dbg !133
  %cmp.not.i.i580 = icmp slt i32 %xor.i.i578, %and.i.i579, !dbg !134
  %cond.i.i581 = select i1 %cmp.not.i.i580, i32 %xor.i.i578, i32 %47, !dbg !135
  %shl.i.i582 = shl i32 %cond.i.i581, 2, !dbg !136
  %49 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i582, i32 %45), !dbg !137
  %50 = bitcast i32 %49 to float, !dbg !138
  %add327 = fadd contract float %add322, %50, !dbg !139
  %cmp330 = fcmp contract ogt float %add327, 0.000000e+00, !dbg !140
  %div333 = fdiv contract float 1.000000e+00, %add327, !dbg !141
  %condval_3.0 = select i1 %cmp330, float %div333, float 0.000000e+00, !dbg !141
  %mul344 = fmul contract float %condval_3.0, %mul.i.i, !dbg !142
  %mul344.1 = fmul contract float %condval_3.0, %mul.i.i.1, !dbg !142
  %mul344.2 = fmul contract float %condval_3.0, %mul.i.i.2, !dbg !142
  %mul344.3 = fmul contract float %condval_3.0, %mul.i.i.3, !dbg !142
  %51 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !143
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !143, !noalias !151
  %52 = fptrunc float %mul344 to half, !dbg !143
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %51), !dbg !143, !noalias !151
  %53 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !156
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !156, !noalias !151
  %54 = fptrunc float %mul344.1 to half, !dbg !156
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %53), !dbg !156, !noalias !151
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %52, i64 0, !dbg !158
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %54, i64 1, !dbg !158
  %55 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !161
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !161, !noalias !165
  %56 = fptrunc float %mul344.2 to half, !dbg !161
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %55), !dbg !161, !noalias !165
  %57 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !170
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !170, !noalias !165
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %57), !dbg !170, !noalias !165
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %56, i64 2, !dbg !172
  fence syncscope("warp") release, !dbg !174
  tail call void @llvm.mxc.barrier.warp(), !dbg !177
  fence syncscope("warp") acquire, !dbg !178
  %58 = shl nuw nsw i32 %3, 5
  %mul374 = and i32 %58, 32256
  %add381 = or disjoint i32 %mul374, %and189, !dbg !179
  %arrayidx383 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381, !dbg !180
  %59 = load half, ptr addrspace(3) %arrayidx383, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %59, i64 0, !dbg !181
  %add376.1 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1 = or disjoint i32 %add376.1, 128, !dbg !179
  %arrayidx383.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1, !dbg !180
  %60 = load half, ptr addrspace(3) %arrayidx383.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %60, i64 1, !dbg !181
  %add376.2 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2 = or disjoint i32 %add376.2, 256, !dbg !179
  %arrayidx383.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2, !dbg !180
  %61 = load half, ptr addrspace(3) %arrayidx383.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %61, i64 2, !dbg !181
  %add376.3 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.3 = or disjoint i32 %add376.3, 384, !dbg !179
  %arrayidx383.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3, !dbg !180
  %62 = load half, ptr addrspace(3) %arrayidx383.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %62, i64 3, !dbg !181
  %add378.1648 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1649 = or disjoint i32 %add378.1648, 16, !dbg !179
  %arrayidx383.1650 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1649, !dbg !180
  %63 = load half, ptr addrspace(3) %arrayidx383.1650, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %63, i64 0, !dbg !181
  %add378.1.1 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1.1 = or disjoint i32 %add378.1.1, 144, !dbg !179
  %arrayidx383.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.1, !dbg !180
  %64 = load half, ptr addrspace(3) %arrayidx383.1.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %64, i64 1, !dbg !181
  %add378.2.1 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2.1 = or disjoint i32 %add378.2.1, 272, !dbg !179
  %arrayidx383.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.1, !dbg !180
  %65 = load half, ptr addrspace(3) %arrayidx383.2.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %65, i64 2, !dbg !181
  %add378.3.1 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.3.1 = or disjoint i32 %add378.3.1, 400, !dbg !179
  %arrayidx383.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.1, !dbg !180
  %66 = load half, ptr addrspace(3) %arrayidx383.3.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %66, i64 3, !dbg !181
  %add378.2652 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2653 = or disjoint i32 %add378.2652, 32, !dbg !179
  %arrayidx383.2654 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2653, !dbg !180
  %67 = load half, ptr addrspace(3) %arrayidx383.2654, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %67, i64 0, !dbg !181
  %add378.1.2 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1.2 = or disjoint i32 %add378.1.2, 160, !dbg !179
  %arrayidx383.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.2, !dbg !180
  %68 = load half, ptr addrspace(3) %arrayidx383.1.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %68, i64 1, !dbg !181
  %add378.2.2 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2.2 = or disjoint i32 %add378.2.2, 288, !dbg !179
  %arrayidx383.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.2, !dbg !180
  %69 = load half, ptr addrspace(3) %arrayidx383.2.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %69, i64 2, !dbg !181
  %add378.3.2 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.3.2 = or disjoint i32 %add378.3.2, 416, !dbg !179
  %arrayidx383.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.2, !dbg !180
  %70 = load half, ptr addrspace(3) %arrayidx383.3.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %70, i64 3, !dbg !181
  %add378.3656 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.3657 = or disjoint i32 %add378.3656, 48, !dbg !179
  %arrayidx383.3658 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3657, !dbg !180
  %71 = load half, ptr addrspace(3) %arrayidx383.3658, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %71, i64 0, !dbg !181
  %add378.1.3 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1.3 = or disjoint i32 %add378.1.3, 176, !dbg !179
  %arrayidx383.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.3, !dbg !180
  %72 = load half, ptr addrspace(3) %arrayidx383.1.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %72, i64 1, !dbg !181
  %add378.2.3 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2.3 = or disjoint i32 %add378.2.3, 304, !dbg !179
  %arrayidx383.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.3, !dbg !180
  %73 = load half, ptr addrspace(3) %arrayidx383.2.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %73, i64 2, !dbg !181
  %add378.3.3 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.3.3 = or disjoint i32 %add378.3.3, 432, !dbg !179
  %arrayidx383.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.3, !dbg !180
  %74 = load half, ptr addrspace(3) %arrayidx383.3.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %74, i64 3, !dbg !181
  %add378.4 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.4 = or disjoint i32 %add378.4, 64, !dbg !179
  %arrayidx383.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.4, !dbg !180
  %75 = load half, ptr addrspace(3) %arrayidx383.4, align 2, !dbg !181, !tbaa !182
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %75, i64 0, !dbg !181
  %add378.1.4 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1.4 = or disjoint i32 %add378.1.4, 192, !dbg !179
  %arrayidx383.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.4, !dbg !180
  %76 = load half, ptr addrspace(3) %arrayidx383.1.4, align 2, !dbg !181, !tbaa !182
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %76, i64 1, !dbg !181
  %add378.2.4 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2.4 = or disjoint i32 %add378.2.4, 320, !dbg !179
  %arrayidx383.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.4, !dbg !180
  %77 = load half, ptr addrspace(3) %arrayidx383.2.4, align 2, !dbg !181, !tbaa !182
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %77, i64 2, !dbg !181
  %add378.3.4 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.3.4 = or disjoint i32 %add378.3.4, 448, !dbg !179
  %arrayidx383.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.4, !dbg !180
  %78 = load half, ptr addrspace(3) %arrayidx383.3.4, align 2, !dbg !181, !tbaa !182
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %78, i64 3, !dbg !181
  %add378.5 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.5 = or disjoint i32 %add378.5, 80, !dbg !179
  %arrayidx383.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.5, !dbg !180
  %79 = load half, ptr addrspace(3) %arrayidx383.5, align 2, !dbg !181, !tbaa !182
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %79, i64 0, !dbg !181
  %add378.1.5 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1.5 = or disjoint i32 %add378.1.5, 208, !dbg !179
  %arrayidx383.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.5, !dbg !180
  %80 = load half, ptr addrspace(3) %arrayidx383.1.5, align 2, !dbg !181, !tbaa !182
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %80, i64 1, !dbg !181
  %add378.2.5 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2.5 = or disjoint i32 %add378.2.5, 336, !dbg !179
  %arrayidx383.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.5, !dbg !180
  %81 = load half, ptr addrspace(3) %arrayidx383.2.5, align 2, !dbg !181, !tbaa !182
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %81, i64 2, !dbg !181
  %add378.3.5 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.3.5 = or disjoint i32 %add378.3.5, 464, !dbg !179
  %arrayidx383.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.5, !dbg !180
  %82 = load half, ptr addrspace(3) %arrayidx383.3.5, align 2, !dbg !181, !tbaa !182
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %82, i64 3, !dbg !181
  %add378.6 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.6 = or disjoint i32 %add378.6, 96, !dbg !179
  %arrayidx383.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.6, !dbg !180
  %83 = load half, ptr addrspace(3) %arrayidx383.6, align 2, !dbg !181, !tbaa !182
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %83, i64 0, !dbg !181
  %add378.1.6 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1.6 = or disjoint i32 %add378.1.6, 224, !dbg !179
  %arrayidx383.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.6, !dbg !180
  %84 = load half, ptr addrspace(3) %arrayidx383.1.6, align 2, !dbg !181, !tbaa !182
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %84, i64 1, !dbg !181
  %add378.2.6 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2.6 = or disjoint i32 %add378.2.6, 352, !dbg !179
  %arrayidx383.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.6, !dbg !180
  %85 = load half, ptr addrspace(3) %arrayidx383.2.6, align 2, !dbg !181, !tbaa !182
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %85, i64 2, !dbg !181
  %add378.3.6 = or disjoint i32 %58, %and189, !dbg !179
  %add381.3.6 = or i32 %add378.3.6, 480, !dbg !179
  %arrayidx383.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.6, !dbg !180
  %86 = load half, ptr addrspace(3) %arrayidx383.3.6, align 2, !dbg !181, !tbaa !182
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %86, i64 3, !dbg !181
  %add378.7 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.7 = or disjoint i32 %add378.7, 112, !dbg !179
  %arrayidx383.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.7, !dbg !180
  %87 = load half, ptr addrspace(3) %arrayidx383.7, align 2, !dbg !181, !tbaa !182
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %87, i64 0, !dbg !181
  %add378.1.7 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.1.7 = or disjoint i32 %add378.1.7, 240, !dbg !179
  %arrayidx383.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.7, !dbg !180
  %88 = load half, ptr addrspace(3) %arrayidx383.1.7, align 2, !dbg !181, !tbaa !182
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %88, i64 1, !dbg !181
  %add378.2.7 = or disjoint i32 %mul374, %and189, !dbg !179
  %add381.2.7 = or disjoint i32 %add378.2.7, 368, !dbg !179
  %arrayidx383.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.7, !dbg !180
  %89 = load half, ptr addrspace(3) %arrayidx383.2.7, align 2, !dbg !181, !tbaa !182
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %89, i64 2, !dbg !181
  %add378.3.7 = or disjoint i32 %58, %and189, !dbg !179
  %add381.3.7 = or i32 %add378.3.7, 496, !dbg !179
  %arrayidx383.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.7, !dbg !180
  %90 = load half, ptr addrspace(3) %arrayidx383.3.7, align 2, !dbg !181, !tbaa !182
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %90, i64 3, !dbg !181
  %91 = fptrunc float %mul344.3 to half, !dbg !170
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %91, i64 3, !dbg !172
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  br label %if.end412

if.end412:                                        ; preds = %if.end231, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %92, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %93, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %94, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %95, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %96, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.52.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %97, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.62.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %98, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %99, %if.end231 ], [ zeroinitializer, %entry ], !dbg !62
  %100 = lshr i32 %3, 2
  %mul453 = and i32 %100, 252
  %add450 = add nuw nsw i32 %add13, %mul453
  %101 = zext nneg i32 %add450 to i64, !dbg !184
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !185
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !185
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !185
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !185
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %103 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !dbg !186, !noalias !190
  %104 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %105 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %104), !dbg !195, !noalias !190
  %106 = bitcast half %103 to i16, !dbg !197
  %107 = bitcast half %105 to i16, !dbg !200
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %109 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !dbg !201, !noalias !205
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %111 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !dbg !210, !noalias !205
  %112 = bitcast half %109 to i16, !dbg !212
  %113 = bitcast half %111 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext = zext i16 %113 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !215
  %__2.sroa.5.0.insert.ext = zext i16 %112 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !215
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !215
  %__2.sroa.4.0.insert.ext = zext i16 %107 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !215
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !215
  %__2.sroa.0.0.insert.ext = zext i16 %106 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !215
  %add.ptr456 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr456, align 8, !dbg !217
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !185
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !185
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !185
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !185
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %115 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !dbg !186, !noalias !190
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %117 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !dbg !195, !noalias !190
  %118 = bitcast half %115 to i16, !dbg !197
  %119 = bitcast half %117 to i16, !dbg !200
  %120 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %121 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %120), !dbg !201, !noalias !205
  %122 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %123 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %122), !dbg !210, !noalias !205
  %124 = bitcast half %121 to i16, !dbg !212
  %125 = bitcast half %123 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.1 = zext i16 %125 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.1 = zext i16 %124 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !215
  %__2.sroa.4.0.insert.ext.1 = zext i16 %119 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !215
  %__2.sroa.0.0.insert.ext.1 = zext i16 %118 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !215
  %126 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  %add.ptr456.1 = getelementptr inbounds i8, ptr addrspace(1) %126, i64 32, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr456.1, align 8, !dbg !217
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !185
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !185
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !185
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !185
  %127 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %128 = fptrunc float %acc_o.sroa.22.32.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %127), !dbg !186, !noalias !190
  %129 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %130 = fptrunc float %acc_o.sroa.22.36.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %129), !dbg !195, !noalias !190
  %131 = bitcast half %128 to i16, !dbg !197
  %132 = bitcast half %130 to i16, !dbg !200
  %133 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %134 = fptrunc float %acc_o.sroa.22.40.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %133), !dbg !201, !noalias !205
  %135 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %136 = fptrunc float %acc_o.sroa.22.44.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %135), !dbg !210, !noalias !205
  %137 = bitcast half %134 to i16, !dbg !212
  %138 = bitcast half %136 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.2 = zext i16 %138 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.2 = zext i16 %137 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !215
  %__2.sroa.4.0.insert.ext.2 = zext i16 %132 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !215
  %__2.sroa.0.0.insert.ext.2 = zext i16 %131 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !215
  %139 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  %add.ptr456.2 = getelementptr inbounds i8, ptr addrspace(1) %139, i64 64, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr456.2, align 8, !dbg !217
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !185
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !185
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !185
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !185
  %140 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %141 = fptrunc float %acc_o.sroa.32.48.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %140), !dbg !186, !noalias !190
  %142 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %143 = fptrunc float %acc_o.sroa.32.52.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %142), !dbg !195, !noalias !190
  %144 = bitcast half %141 to i16, !dbg !197
  %145 = bitcast half %143 to i16, !dbg !200
  %146 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %147 = fptrunc float %acc_o.sroa.32.56.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %146), !dbg !201, !noalias !205
  %148 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %149 = fptrunc float %acc_o.sroa.32.60.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %148), !dbg !210, !noalias !205
  %150 = bitcast half %147 to i16, !dbg !212
  %151 = bitcast half %149 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.3 = zext i16 %151 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.3 = zext i16 %150 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !215
  %__2.sroa.4.0.insert.ext.3 = zext i16 %145 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !215
  %__2.sroa.0.0.insert.ext.3 = zext i16 %144 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !215
  %152 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  %add.ptr456.3 = getelementptr inbounds i8, ptr addrspace(1) %152, i64 96, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr456.3, align 8, !dbg !217
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0, !dbg !185
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1, !dbg !185
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2, !dbg !185
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3, !dbg !185
  %153 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %154 = fptrunc float %acc_o.sroa.42.64.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %153), !dbg !186, !noalias !190
  %155 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %156 = fptrunc float %acc_o.sroa.42.68.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %155), !dbg !195, !noalias !190
  %157 = bitcast half %154 to i16, !dbg !197
  %158 = bitcast half %156 to i16, !dbg !200
  %159 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %160 = fptrunc float %acc_o.sroa.42.72.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %159), !dbg !201, !noalias !205
  %161 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %162 = fptrunc float %acc_o.sroa.42.76.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %161), !dbg !210, !noalias !205
  %163 = bitcast half %160 to i16, !dbg !212
  %164 = bitcast half %162 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.4 = zext i16 %164 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.4 = shl nuw i64 %__2.sroa.6.0.insert.ext.4, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.4 = zext i16 %163 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.4, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.4 = or disjoint i64 %__2.sroa.6.0.insert.shift.4, %__2.sroa.5.0.insert.shift.4, !dbg !215
  %__2.sroa.4.0.insert.ext.4 = zext i16 %158 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.4, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.4 = or disjoint i64 %__2.sroa.5.0.insert.insert.4, %__2.sroa.4.0.insert.shift.4, !dbg !215
  %__2.sroa.0.0.insert.ext.4 = zext i16 %157 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.4 = or disjoint i64 %__2.sroa.4.0.insert.insert.4, %__2.sroa.0.0.insert.ext.4, !dbg !215
  %165 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  %add.ptr456.4 = getelementptr inbounds i8, ptr addrspace(1) %165, i64 128, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.4, ptr addrspace(1) %add.ptr456.4, align 8, !dbg !217
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0, !dbg !185
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1, !dbg !185
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2, !dbg !185
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3, !dbg !185
  %166 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %167 = fptrunc float %acc_o.sroa.52.80.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %166), !dbg !186, !noalias !190
  %168 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %169 = fptrunc float %acc_o.sroa.52.84.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %168), !dbg !195, !noalias !190
  %170 = bitcast half %167 to i16, !dbg !197
  %171 = bitcast half %169 to i16, !dbg !200
  %172 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %173 = fptrunc float %acc_o.sroa.52.88.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %172), !dbg !201, !noalias !205
  %174 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %175 = fptrunc float %acc_o.sroa.52.92.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %174), !dbg !210, !noalias !205
  %176 = bitcast half %173 to i16, !dbg !212
  %177 = bitcast half %175 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.5 = zext i16 %177 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.5 = shl nuw i64 %__2.sroa.6.0.insert.ext.5, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.5 = zext i16 %176 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.5, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.5 = or disjoint i64 %__2.sroa.6.0.insert.shift.5, %__2.sroa.5.0.insert.shift.5, !dbg !215
  %__2.sroa.4.0.insert.ext.5 = zext i16 %171 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.5, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.5 = or disjoint i64 %__2.sroa.5.0.insert.insert.5, %__2.sroa.4.0.insert.shift.5, !dbg !215
  %__2.sroa.0.0.insert.ext.5 = zext i16 %170 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.5 = or disjoint i64 %__2.sroa.4.0.insert.insert.5, %__2.sroa.0.0.insert.ext.5, !dbg !215
  %178 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  %add.ptr456.5 = getelementptr inbounds i8, ptr addrspace(1) %178, i64 160, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.5, ptr addrspace(1) %add.ptr456.5, align 8, !dbg !217
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0, !dbg !185
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1, !dbg !185
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2, !dbg !185
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3, !dbg !185
  %179 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %180 = fptrunc float %acc_o.sroa.62.96.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %179), !dbg !186, !noalias !190
  %181 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %182 = fptrunc float %acc_o.sroa.62.100.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %181), !dbg !195, !noalias !190
  %183 = bitcast half %180 to i16, !dbg !197
  %184 = bitcast half %182 to i16, !dbg !200
  %185 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %186 = fptrunc float %acc_o.sroa.62.104.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %185), !dbg !201, !noalias !205
  %187 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %188 = fptrunc float %acc_o.sroa.62.108.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %187), !dbg !210, !noalias !205
  %189 = bitcast half %186 to i16, !dbg !212
  %190 = bitcast half %188 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.6 = zext i16 %190 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.6 = shl nuw i64 %__2.sroa.6.0.insert.ext.6, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.6 = zext i16 %189 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.6, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.6 = or disjoint i64 %__2.sroa.6.0.insert.shift.6, %__2.sroa.5.0.insert.shift.6, !dbg !215
  %__2.sroa.4.0.insert.ext.6 = zext i16 %184 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.6, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.6 = or disjoint i64 %__2.sroa.5.0.insert.insert.6, %__2.sroa.4.0.insert.shift.6, !dbg !215
  %__2.sroa.0.0.insert.ext.6 = zext i16 %183 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.6 = or disjoint i64 %__2.sroa.4.0.insert.insert.6, %__2.sroa.0.0.insert.ext.6, !dbg !215
  %191 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  %add.ptr456.6 = getelementptr inbounds i8, ptr addrspace(1) %191, i64 192, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.6, ptr addrspace(1) %add.ptr456.6, align 8, !dbg !217
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0, !dbg !185
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1, !dbg !185
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2, !dbg !185
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3, !dbg !185
  %192 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %193 = fptrunc float %acc_o.sroa.72.112.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %192), !dbg !186, !noalias !190
  %194 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %195 = fptrunc float %acc_o.sroa.72.116.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %194), !dbg !195, !noalias !190
  %196 = bitcast half %193 to i16, !dbg !197
  %197 = bitcast half %195 to i16, !dbg !200
  %198 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %199 = fptrunc float %acc_o.sroa.72.120.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %198), !dbg !201, !noalias !205
  %200 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %201 = fptrunc float %acc_o.sroa.72.124.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %200), !dbg !210, !noalias !205
  %202 = bitcast half %199 to i16, !dbg !212
  %203 = bitcast half %201 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.7 = zext i16 %203 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.7 = shl nuw i64 %__2.sroa.6.0.insert.ext.7, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.7 = zext i16 %202 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.7, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.7 = or disjoint i64 %__2.sroa.6.0.insert.shift.7, %__2.sroa.5.0.insert.shift.7, !dbg !215
  %__2.sroa.4.0.insert.ext.7 = zext i16 %197 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.7, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.7 = or disjoint i64 %__2.sroa.5.0.insert.insert.7, %__2.sroa.4.0.insert.shift.7, !dbg !215
  %__2.sroa.0.0.insert.ext.7 = zext i16 %196 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.7 = or disjoint i64 %__2.sroa.4.0.insert.insert.7, %__2.sroa.0.0.insert.ext.7, !dbg !215
  %204 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101, !dbg !216
  %add.ptr456.7 = getelementptr inbounds i8, ptr addrspace(1) %204, i64 224, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.7, ptr addrspace(1) %add.ptr456.7, align 8, !dbg !217
  ret void, !dbg !218
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

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

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
!1 = !DIFile(filename: "/tmp/tmpwxptc6b8/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpwxptc6b8/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 23, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 46, scope: !40)
!45 = !DILocation(line: 24, column: 32, scope: !40)
!46 = !DILocation(line: 26, column: 54, scope: !40)
!47 = !DILocation(line: 26, column: 82, scope: !40)
!48 = !DILocation(line: 26, column: 61, scope: !40)
!49 = !DILocation(line: 26, column: 88, scope: !40)
!50 = !DILocation(line: 26, column: 14, scope: !40)
!51 = !DILocation(line: 26, column: 116, scope: !40)
!52 = !DILocation(line: 32, column: 11, scope: !40)
!53 = !DILocation(line: 32, column: 19, scope: !40)
!54 = !DILocation(line: 32, column: 27, scope: !40)
!55 = !DILocation(line: 32, column: 34, scope: !40)
!56 = !DILocation(line: 34, column: 5, scope: !40)
!57 = !DILocation(line: 37, column: 61, scope: !40)
!58 = !DILocation(line: 37, column: 11, scope: !40)
!59 = !DILocation(line: 38, column: 31, scope: !40)
!60 = !DILocation(line: 38, column: 17, scope: !40)
!61 = !DILocation(line: 39, column: 7, scope: !40)
!62 = !DILocation(line: 0, scope: !40)
!63 = !DILocation(line: 48, column: 11, scope: !40)
!64 = !DILocation(line: 49, column: 33, scope: !40)
!65 = !DILocation(line: 49, column: 19, scope: !40)
!66 = !DILocation(line: 50, column: 7, scope: !40)
!67 = !DILocation(line: 56, column: 5, scope: !40)
!68 = !DILocation(line: 57, column: 109, scope: !40)
!69 = !DILocation(line: 57, column: 26, scope: !40)
!70 = !DILocation(line: 57, column: 159, scope: !40)
!71 = !DILocation(line: 57, column: 122, scope: !40)
!72 = !DILocation(line: 59, column: 34, scope: !40)
!73 = !DILocation(line: 59, column: 27, scope: !40)
!74 = !DILocation(line: 59, column: 9, scope: !40)
!75 = !DILocation(line: 63, column: 62, scope: !40)
!76 = !DILocation(line: 63, column: 13, scope: !40)
!77 = !DILocation(line: 68, column: 20, scope: !40)
!78 = !DILocation(line: 63, column: 55, scope: !40)
!79 = !DILocation(line: 68, column: 3, scope: !80, inlinedAt: !82)
!80 = distinct !DISubprogram(name: "__barrier_warp", scope: !81, file: !81, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!81 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!82 = distinct !DILocation(line: 192, column: 3, scope: !83, inlinedAt: !84)
!83 = distinct !DISubprogram(name: "__syncwarp", scope: !81, file: !81, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!84 = distinct !DILocation(line: 74, column: 5, scope: !40)
!85 = !DILocation(line: 69, column: 3, scope: !80, inlinedAt: !82)
!86 = !DILocation(line: 70, column: 3, scope: !80, inlinedAt: !82)
!87 = !DILocation(line: 76, column: 46, scope: !40)
!88 = !DILocation(line: 76, column: 25, scope: !40)
!89 = !DILocation(line: 79, column: 36, scope: !40)
!90 = !{i32 -1, i32 3, i32 -1}
!91 = !DILocation(line: 68, column: 3, scope: !80, inlinedAt: !92)
!92 = distinct !DILocation(line: 192, column: 3, scope: !83, inlinedAt: !93)
!93 = distinct !DILocation(line: 85, column: 5, scope: !40)
!94 = !DILocation(line: 69, column: 3, scope: !80, inlinedAt: !92)
!95 = !DILocation(line: 70, column: 3, scope: !80, inlinedAt: !92)
!96 = !DILocation(line: 87, column: 10, scope: !40)
!97 = !DILocation(line: 88, column: 70, scope: !40)
!98 = !DILocation(line: 88, column: 26, scope: !40)
!99 = !DILocation(line: 92, column: 31, scope: !40)
!100 = !DILocation(line: 92, column: 42, scope: !40)
!101 = !DILocation(line: 354, column: 10, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "min", scope: !103, file: !103, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!104 = distinct !DILocation(line: 92, column: 26, scope: !40)
!105 = !DILocation(line: 285, column: 49, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "exp2f", scope: !103, file: !103, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = distinct !DILocation(line: 92, column: 20, scope: !40)
!108 = !DILocation(line: 97, column: 34, scope: !40)
!109 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !81, file: !81, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 99, column: 34, scope: !40)
!112 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "__lane_id", scope: !81, file: !81, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !81, file: !81, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!116 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !111)
!117 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !114)
!118 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !116)
!119 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !116)
!120 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !116)
!121 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !116)
!122 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !116)
!123 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !116)
!124 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !111)
!125 = !DILocation(line: 99, column: 32, scope: !40)
!126 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !127)
!127 = distinct !DILocation(line: 100, column: 34, scope: !40)
!128 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !129)
!129 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !130)
!130 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !127)
!131 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !129)
!132 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !130)
!133 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !130)
!134 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !130)
!135 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !130)
!136 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !130)
!137 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !130)
!138 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !127)
!139 = !DILocation(line: 100, column: 32, scope: !40)
!140 = !DILocation(line: 102, column: 34, scope: !40)
!141 = !DILocation(line: 102, column: 9, scope: !40)
!142 = !DILocation(line: 110, column: 32, scope: !40)
!143 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !146)
!144 = distinct !DISubprogram(name: "__float2half_rn", scope: !145, file: !145, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!146 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !145, file: !145, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__float22half2_rn", scope: !145, file: !145, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 114, column: 27, scope: !40)
!151 = !{!152, !154}
!152 = distinct !{!152, !153, !"_ZL17__floats2half2_rnff: %agg.result"}
!153 = distinct !{!153, !"_ZL17__floats2half2_rnff"}
!154 = distinct !{!154, !155, !"_ZL17__float22half2_rn6float2: %agg.result"}
!155 = distinct !{!155, !"_ZL17__float22half2_rn6float2"}
!156 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !157)
!157 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !148)
!158 = !DILocation(line: 593, column: 26, scope: !159, inlinedAt: !160)
!159 = distinct !DISubprogram(name: "operator=", scope: !145, file: !145, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!160 = distinct !DILocation(line: 114, column: 25, scope: !40)
!161 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !162)
!162 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !163)
!163 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !164)
!164 = distinct !DILocation(line: 115, column: 27, scope: !40)
!165 = !{!166, !168}
!166 = distinct !{!166, !167, !"_ZL17__floats2half2_rnff: %agg.result"}
!167 = distinct !{!167, !"_ZL17__floats2half2_rnff"}
!168 = distinct !{!168, !169, !"_ZL17__float22half2_rn6float2: %agg.result"}
!169 = distinct !{!169, !"_ZL17__float22half2_rn6float2"}
!170 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !171)
!171 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !163)
!172 = !DILocation(line: 593, column: 26, scope: !159, inlinedAt: !173)
!173 = distinct !DILocation(line: 115, column: 25, scope: !40)
!174 = !DILocation(line: 68, column: 3, scope: !80, inlinedAt: !175)
!175 = distinct !DILocation(line: 192, column: 3, scope: !83, inlinedAt: !176)
!176 = distinct !DILocation(line: 117, column: 5, scope: !40)
!177 = !DILocation(line: 69, column: 3, scope: !80, inlinedAt: !175)
!178 = !DILocation(line: 70, column: 3, scope: !80, inlinedAt: !175)
!179 = !DILocation(line: 120, column: 104, scope: !40)
!180 = !DILocation(line: 120, column: 31, scope: !40)
!181 = !DILocation(line: 120, column: 29, scope: !40)
!182 = !{!26, !26, i64 0}
!183 = !DILocation(line: 125, column: 38, scope: !40)
!184 = !DILocation(line: 132, column: 3, scope: !40)
!185 = !DILocation(line: 134, column: 19, scope: !40)
!186 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !187)
!187 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !188)
!188 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !189)
!189 = distinct !DILocation(line: 135, column: 27, scope: !40)
!190 = !{!191, !193}
!191 = distinct !{!191, !192, !"_ZL17__floats2half2_rnff: %agg.result"}
!192 = distinct !{!192, !"_ZL17__floats2half2_rnff"}
!193 = distinct !{!193, !194, !"_ZL17__float22half2_rn6float2: %agg.result"}
!194 = distinct !{!194, !"_ZL17__float22half2_rn6float2"}
!195 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !196)
!196 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !188)
!197 = !DILocation(line: 596, column: 67, scope: !198, inlinedAt: !199)
!198 = distinct !DISubprogram(name: "__half2", scope: !145, file: !145, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!199 = distinct !DILocation(line: 1077, column: 10, scope: !147, inlinedAt: !188)
!200 = !DILocation(line: 596, column: 73, scope: !198, inlinedAt: !199)
!201 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !202)
!202 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !203)
!203 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !204)
!204 = distinct !DILocation(line: 136, column: 27, scope: !40)
!205 = !{!206, !208}
!206 = distinct !{!206, !207, !"_ZL17__floats2half2_rnff: %agg.result"}
!207 = distinct !{!207, !"_ZL17__floats2half2_rnff"}
!208 = distinct !{!208, !209, !"_ZL17__float22half2_rn6float2: %agg.result"}
!209 = distinct !{!209, !"_ZL17__float22half2_rn6float2"}
!210 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !211)
!211 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !203)
!212 = !DILocation(line: 596, column: 67, scope: !198, inlinedAt: !213)
!213 = distinct !DILocation(line: 1077, column: 10, scope: !147, inlinedAt: !203)
!214 = !DILocation(line: 596, column: 73, scope: !198, inlinedAt: !213)
!215 = !DILocation(line: 137, column: 38, scope: !40)
!216 = !DILocation(line: 138, column: 22, scope: !40)
!217 = !DILocation(line: 138, column: 217, scope: !40)
!218 = !DILocation(line: 140, column: 1, scope: !40)
