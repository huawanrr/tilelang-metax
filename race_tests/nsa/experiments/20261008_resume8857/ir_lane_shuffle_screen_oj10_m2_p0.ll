; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_lane_shuffle_screen_oj10_m2_p0.cpp'
source_filename = "/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_lane_shuffle_screen_oj10_m2_p0.cpp"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_pure_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #1

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

; Function Attrs: mustprogress nounwind
define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr()
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !tbaa !2
  %2 = inttoptr i64 %1 to ptr
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !tbaa !2
  %4 = inttoptr i64 %3 to ptr
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16
  %5 = load ptr, ptr %thread_counter.i, align 8, !tbaa !6
  %cmp.not.i = icmp eq ptr %5, null
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr()
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12
  %8 = load i32, ptr addrspace(4) %7, align 4, !range !13, !invariant.load !14
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4
  %10 = load i32, ptr addrspace(4) %9, align 4, !invariant.load !14
  %conv.i14.i.i = and i32 %10, 65535
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16
  %12 = load i32, ptr addrspace(4) %11, align 4, !range !13, !invariant.load !14
  %13 = lshr i32 %10, 16
  %div.i.i.i = udiv i32 %12, %13
  %mul.i.i.i = mul i32 %div.i.i.i, %13
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !15
  %mul.i.i = mul i32 %add.i.i.i, %14
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !15
  %mul320.i.i = add i32 %mul.i.i, %15
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %add8.i.i = add i32 %add.i.i, %16
  %conv.i.i = zext i32 %add8.i.i to i64
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i)
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !tbaa !16
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
  br label %while.cond.i, !llvm.loop !17

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i)
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !tbaa !16
  %add.i37.i = add nsw i32 %21, -1
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !tbaa !16
  br label %_Z9atomicAddPii.exit38.i

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %_Z9atomicAddPii.exit38.i

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ]
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4
  %23 = load i32, ptr %call_deep.i, align 4, !tbaa !19
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
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !tbaa !20
  %25 = load i32, ptr %4, align 8, !tbaa !21
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !tbaa !6
  %idxprom.i = zext i32 %25 to i64
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !tbaa !22
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !tbaa !24
  %29 = inttoptr i64 %28 to ptr
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i)
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !tbaa !16
  %and.i.i.i = and i32 %31, 2147483647
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !tbaa !16
  br label %if.end20.i

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4
  br label %if.end20.i

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i)
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !tbaa !16
  %add.i42.i = add nsw i32 %34, -1
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !tbaa !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %__mcImplicitDeviceSynchronizeImpl.exit

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void
}

; Function Attrs: convergent mustprogress norecurse nounwind willreturn
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !25
  %and = shl nuw nsw i32 %1, 6
  %mul7 = and i32 %and, 960
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %mul22 = shl nuw nsw i32 %0, 1
  %5 = zext nneg i32 %mul22 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !16
  %cmp25 = icmp ult i32 %6, 16
  %7 = shl nsw i32 %6, 4
  %mul26 = select i1 %cmp25, i32 %7, i32 -16
  %8 = or disjoint i64 %5, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !16
  %cmp25.1 = icmp ult i32 %9, 16
  %10 = shl nsw i32 %9, 4
  %mul26.1 = select i1 %cmp25.1, i32 %10, i32 -16
  %shr61 = lshr i32 %1, 3
  %11 = shl nuw nsw i32 %1, 3
  %12 = and i32 %11, 56
  %add57 = add nsw i32 %shr61, %mul26
  %or.cond = icmp ult i32 %add57, 256
  br i1 %or.cond, label %if.then69, label %if.then51.1

if.then69:                                        ; preds = %entry
  %13 = shl nuw nsw i32 %add57, 6
  %add75760 = or disjoint i32 %13, %12
  %add75 = zext nneg i32 %add75760 to i64
  %add.ptr76 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75
  %condval_2.sroa.7.0.add.ptr76.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76, i64 4
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr76, align 16, !tbaa !16
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx, align 4, !tbaa !16
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx, align 8, !tbaa !16
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx, align 4, !tbaa !16
  br label %if.then51.1

if.then51.1:                                      ; preds = %if.then69, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then69 ], [ 0, %entry ]
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then69 ], [ 0, %entry ]
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then69 ], [ 0, %entry ]
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then69 ], [ 0, %entry ]
  %add55.1 = add nuw nsw i32 %shr61, 8
  %add57.1 = add nsw i32 %add55.1, %mul26
  %or.cond.1 = icmp ult i32 %add57.1, 256
  br i1 %or.cond.1, label %if.then69.1, label %if.else58.2

if.then69.1:                                      ; preds = %if.then51.1
  %14 = shl nuw nsw i32 %add57.1, 6
  %add75760.1 = or disjoint i32 %14, %12
  %add75.1 = zext nneg i32 %add75760.1 to i64
  %add.ptr76.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75.1
  %condval_2.sroa.7.0.add.ptr76.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.1, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.1, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.1, i64 4
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr76.1, align 16, !tbaa !16
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx.1, align 4, !tbaa !16
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx.1, align 8, !tbaa !16
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx.1, align 4, !tbaa !16
  br label %if.else58.2

if.else58.2:                                      ; preds = %if.then51.1, %if.then69.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ]
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ]
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ]
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ]
  %sub.2 = add i32 %shr61, %mul26.1
  %or.cond.2 = icmp ult i32 %sub.2, 256
  br i1 %or.cond.2, label %if.then69.2, label %if.else58.3

if.then69.2:                                      ; preds = %if.else58.2
  %15 = shl nuw nsw i32 %sub.2, 6
  %add75760.2 = or disjoint i32 %15, %12
  %add75.2 = zext nneg i32 %add75760.2 to i64
  %add.ptr76.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75.2
  %condval_2.sroa.7.0.add.ptr76.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.2, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.2, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.2, i64 4
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr76.2, align 16, !tbaa !16
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx.2, align 4, !tbaa !16
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx.2, align 8, !tbaa !16
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx.2, align 4, !tbaa !16
  br label %if.else58.3

if.else58.3:                                      ; preds = %if.else58.2, %if.then69.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ]
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ]
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ]
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ]
  %add64.3 = add nuw nsw i32 %shr61, 8
  %sub.3 = add i32 %add64.3, %mul26.1
  %or.cond.3 = icmp ult i32 %sub.3, 256
  br i1 %or.cond.3, label %if.then69.3, label %if.then112

if.then69.3:                                      ; preds = %if.else58.3
  %16 = shl nuw nsw i32 %sub.3, 6
  %add75760.3 = or disjoint i32 %16, %12
  %add75.3 = zext nneg i32 %add75760.3 to i64
  %add.ptr76.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75.3
  %condval_2.sroa.7.0.add.ptr76.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.3, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.3, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.3, i64 4
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr76.3, align 16, !tbaa !16
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx.3, align 4, !tbaa !16
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx.3, align 8, !tbaa !16
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx.3, align 4, !tbaa !16
  br label %if.then112

if.then112:                                       ; preds = %if.else58.3, %if.then69.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ]
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ]
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ]
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ]
  %add118 = add nsw i32 %shr61, %mul26
  %or.cond681 = icmp ult i32 %add118, 256
  br i1 %or.cond681, label %if.then131, label %if.then112.1

if.then131:                                       ; preds = %if.then112
  %17 = shl nuw nsw i32 %add118, 6
  %add138761 = or disjoint i32 %17, %12
  %add138 = zext nneg i32 %add138761 to i64
  %add.ptr139 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138
  %condval_4.sroa.7.0.add.ptr139.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139, i64 4
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr139, align 16, !tbaa !16
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx, align 4, !tbaa !16
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx, align 8, !tbaa !16
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx, align 4, !tbaa !16
  br label %if.then112.1

if.then112.1:                                     ; preds = %if.then131, %if.then112
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then131 ], [ 0, %if.then112 ]
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then131 ], [ 0, %if.then112 ]
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then131 ], [ 0, %if.then112 ]
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then131 ], [ 0, %if.then112 ]
  %add116.1 = add nuw nsw i32 %shr61, 8
  %add118.1 = add nsw i32 %add116.1, %mul26
  %or.cond681.1 = icmp ult i32 %add118.1, 256
  br i1 %or.cond681.1, label %if.then131.1, label %if.else119.2

if.then131.1:                                     ; preds = %if.then112.1
  %18 = shl nuw nsw i32 %add118.1, 6
  %add138761.1 = or disjoint i32 %18, %12
  %add138.1 = zext nneg i32 %add138761.1 to i64
  %add.ptr139.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138.1
  %condval_4.sroa.7.0.add.ptr139.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.1, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.1, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.1, i64 4
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr139.1, align 16, !tbaa !16
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx.1, align 4, !tbaa !16
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx.1, align 8, !tbaa !16
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx.1, align 4, !tbaa !16
  br label %if.else119.2

if.else119.2:                                     ; preds = %if.then112.1, %if.then131.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ]
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ]
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ]
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ]
  %sub126.2 = add i32 %shr61, %mul26.1
  %or.cond681.2 = icmp ult i32 %sub126.2, 256
  br i1 %or.cond681.2, label %if.then131.2, label %if.else119.3

if.then131.2:                                     ; preds = %if.else119.2
  %19 = shl nuw nsw i32 %sub126.2, 6
  %add138761.2 = or disjoint i32 %19, %12
  %add138.2 = zext nneg i32 %add138761.2 to i64
  %add.ptr139.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138.2
  %condval_4.sroa.7.0.add.ptr139.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.2, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.2, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.2, i64 4
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr139.2, align 16, !tbaa !16
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx.2, align 4, !tbaa !16
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx.2, align 8, !tbaa !16
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx.2, align 4, !tbaa !16
  br label %if.else119.3

if.else119.3:                                     ; preds = %if.else119.2, %if.then131.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ]
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ]
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ]
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ]
  %add125.3 = add nuw nsw i32 %shr61, 8
  %sub126.3 = add i32 %add125.3, %mul26.1
  %or.cond681.3 = icmp ult i32 %sub126.3, 256
  br i1 %or.cond681.3, label %if.then131.3, label %if.end163.3

if.then131.3:                                     ; preds = %if.else119.3
  %20 = shl nuw nsw i32 %sub126.3, 6
  %add138761.3 = or disjoint i32 %20, %12
  %add138.3 = zext nneg i32 %add138761.3 to i64
  %add.ptr139.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138.3
  %condval_4.sroa.7.0.add.ptr139.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.3, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.3, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.3, i64 4
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr139.3, align 16, !tbaa !16
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx.3, align 4, !tbaa !16
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx.3, align 8, !tbaa !16
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx.3, align 4, !tbaa !16
  br label %if.end163.3

if.end163.3:                                      ; preds = %if.then131.3, %if.else119.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ]
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ]
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ]
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ]
  %mul183 = and i32 %11, 8128
  %call187.masked = and i32 %1, 1016
  %mul189 = xor i32 %12, %call187.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul183
  %invariant.gep732 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul189
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep732, align 16, !tbaa !16
  %K_reg.sroa.4.0.invariant.gep732.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 4
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep732.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.5.0.invariant.gep732.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 8
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep732.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.6.0.invariant.gep732.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 12
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep732.sroa_idx, align 4, !tbaa !16
  %gep733.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1024
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep733.1, align 16, !tbaa !16
  %K_reg.sroa.9.16.gep733.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1028
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep733.1.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.10.16.gep733.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1032
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep733.1.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.11.16.gep733.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1036
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep733.1.sroa_idx, align 4, !tbaa !16
  %gep733.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2048
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep733.2, align 16, !tbaa !16
  %K_reg.sroa.14.32.gep733.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2052
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep733.2.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.15.32.gep733.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2056
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep733.2.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.16.32.gep733.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2060
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep733.2.sroa_idx, align 4, !tbaa !16
  %gep733.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3072
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep733.3, align 16, !tbaa !16
  %K_reg.sroa.19.48.gep733.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3076
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep733.3.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.20.48.gep733.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3080
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep733.3.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.21.48.gep733.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3084
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep733.3.sroa_idx, align 4, !tbaa !16
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %shr226 = lshr i32 %1, 4
  %and229 = and i32 %1, 7
  %xor230 = xor i32 %shr226, %and229
  %add.ptr234.idx = shl nuw nsw i32 %xor230, 4
  %invariant.gep736 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr234.idx
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736, i32 %mul7
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8
  %add223.1 = or disjoint i32 %mul7, 1024
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736, i32 %add223.1
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !26
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !26
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %21), !call_argsrelate !26
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !call_argsrelate !26
  %add227.1 = add nuw nsw i32 %shr226, 4
  %xor230.1 = xor i32 %add227.1, %and229
  %add.ptr234.idx.1 = shl nuw nsw i32 %xor230.1, 4
  %invariant.gep736.1 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr234.idx.1
  %gep.1771 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736.1, i32 %mul7
  %kb.sroa.0.0.copyload860 = load <4 x half>, ptr addrspace(3) %gep.1771, align 16
  %kb.sroa.6.0.gep.1771.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1771, i32 8
  %kb.sroa.6.0.copyload861 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1771.sroa_idx, align 8
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736.1, i32 %add223.1
  %kb.sroa.8.16.copyload864 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8
  %kb.sroa.12.16.copyload865 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload860, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23), !call_argsrelate !26
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload864, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !call_argsrelate !26
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload861, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !call_argsrelate !26
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload865, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !call_argsrelate !26
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %add.ptr288.idx = shl nuw nsw i32 %1, 4
  %invariant.gep741 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr288.idx
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep741, align 16, !tbaa !16
  %V_reg.sroa.4.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 4
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep741.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.5.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 8
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep741.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.6.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 12
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep741.sroa_idx, align 4, !tbaa !16
  %gep742.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1024
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep742.1, align 16, !tbaa !16
  %V_reg.sroa.9.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1028
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep742.1.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.10.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1032
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep742.1.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.11.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1036
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep742.1.sroa_idx, align 4, !tbaa !16
  %gep742.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2048
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep742.2, align 16, !tbaa !16
  %V_reg.sroa.14.32.gep742.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2052
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep742.2.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.15.32.gep742.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2056
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep742.2.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.16.32.gep742.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2060
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep742.2.sroa_idx, align 4, !tbaa !16
  %gep742.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3072
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep742.3, align 16, !tbaa !16
  %V_reg.sroa.19.48.gep742.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3076
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep742.3.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.20.48.gep742.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3080
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep742.3.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.21.48.gep742.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3084
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep742.3.sroa_idx, align 4, !tbaa !16
  %29 = lshr i32 %1, 2
  %mul309 = and i32 %29, 252
  %add303 = add i32 %29, %mul26
  %add324 = add i32 %mul309, %mul26
  %add345 = add i32 %mul309, %mul26
  %cmp359 = icmp slt i32 %add303, 0
  %cmp361 = icmp sgt i32 %add324, 255
  %or.cond682.not763 = or i1 %cmp359, %cmp361
  %cmp364.not = icmp sgt i32 %add345, %0
  %or.cond726 = or i1 %or.cond682.not763, %cmp364.not
  br i1 %or.cond726, label %if.then297.1, label %if.then365

if.then365:                                       ; preds = %if.end163.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %27, i64 0
  %mul368 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul368, float 0x4024CB5EC0000000)
  %31 = tail call contract noundef float @llvm.exp.f32(float %30)
  br label %if.then297.1

if.then297.1:                                     ; preds = %if.then365, %if.end163.3
  %condval_5.0 = phi float [ %31, %if.then365 ], [ 0.000000e+00, %if.end163.3 ]
  %add303.1 = add i32 %29, %mul26
  %add323.1 = or disjoint i32 %mul309, 1
  %add324.1 = add i32 %add323.1, %mul26
  %add344.1 = or disjoint i32 %mul309, 1
  %add345.1 = add i32 %add344.1, %mul26
  %cmp359.1 = icmp slt i32 %add303.1, 0
  %cmp361.1 = icmp sgt i32 %add324.1, 255
  %or.cond682.not763.1 = select i1 %cmp359.1, i1 true, i1 %cmp361.1
  %cmp364.not.1 = icmp sgt i32 %add345.1, %0
  %or.cond726.1 = select i1 %or.cond682.not763.1, i1 true, i1 %cmp364.not.1
  br i1 %or.cond726.1, label %if.then297.2, label %if.then365.1

if.then365.1:                                     ; preds = %if.then297.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %27, i64 1
  %mul368.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul368.1, float 0x4024CB5EC0000000)
  %33 = tail call contract noundef float @llvm.exp.f32(float %32)
  br label %if.then297.2

if.then297.2:                                     ; preds = %if.then297.1, %if.then365.1
  %condval_5.0.1 = phi float [ %33, %if.then365.1 ], [ 0.000000e+00, %if.then297.1 ]
  %add303.2 = add i32 %29, %mul26
  %add323.2 = or disjoint i32 %mul309, 2
  %add324.2 = add i32 %add323.2, %mul26
  %add344.2 = or disjoint i32 %mul309, 2
  %add345.2 = add i32 %add344.2, %mul26
  %cmp359.2 = icmp slt i32 %add303.2, 0
  %cmp361.2 = icmp sgt i32 %add324.2, 255
  %or.cond682.not763.2 = select i1 %cmp359.2, i1 true, i1 %cmp361.2
  %cmp364.not.2 = icmp sgt i32 %add345.2, %0
  %or.cond726.2 = select i1 %or.cond682.not763.2, i1 true, i1 %cmp364.not.2
  br i1 %or.cond726.2, label %if.then297.3, label %if.then365.2

if.then365.2:                                     ; preds = %if.then297.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %27, i64 2
  %mul368.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul368.2, float 0x4024CB5EC0000000)
  %35 = tail call contract noundef float @llvm.exp.f32(float %34)
  br label %if.then297.3

if.then297.3:                                     ; preds = %if.then297.2, %if.then365.2
  %condval_5.0.2 = phi float [ %35, %if.then365.2 ], [ 0.000000e+00, %if.then297.2 ]
  %add303.3 = add i32 %29, %mul26
  %add323.3 = or i32 %29, 3
  %add324.3 = add i32 %add323.3, %mul26
  %add344.3 = or i32 %29, 3
  %add345.3 = add i32 %add344.3, %mul26
  %cmp359.3 = icmp slt i32 %add303.3, 0
  %cmp361.3 = icmp sgt i32 %add324.3, 255
  %or.cond682.not763.3 = or i1 %cmp359.3, %cmp361.3
  %cmp364.not.3 = icmp sgt i32 %add345.3, %0
  %or.cond726.3 = or i1 %or.cond682.not763.3, %cmp364.not.3
  br i1 %or.cond726.3, label %if.else304.4, label %if.then365.3

if.then365.3:                                     ; preds = %if.then297.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %27, i64 3
  %mul368.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul368.3, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  br label %if.else304.4

if.else304.4:                                     ; preds = %if.then297.3, %if.then365.3
  %condval_5.0.3 = phi float [ %37, %if.then365.3 ], [ 0.000000e+00, %if.then297.3 ]
  %sub315.4 = add i32 %29, %mul26.1
  %sub336.4 = add i32 %mul309, %mul26.1
  %sub357.4 = add i32 %mul309, %mul26.1
  %cmp359.4 = icmp slt i32 %sub315.4, 0
  %cmp361.4 = icmp sgt i32 %sub336.4, 255
  %or.cond682.not763.4 = or i1 %cmp359.4, %cmp361.4
  %cmp364.not.4 = icmp sgt i32 %sub357.4, %0
  %or.cond726.4 = select i1 %or.cond682.not763.4, i1 true, i1 %cmp364.not.4
  br i1 %or.cond726.4, label %if.else304.5, label %if.then365.4

if.then365.4:                                     ; preds = %if.else304.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %28, i64 0
  %mul368.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul368.4, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  br label %if.else304.5

if.else304.5:                                     ; preds = %if.else304.4, %if.then365.4
  %condval_5.0.4 = phi float [ %39, %if.then365.4 ], [ 0.000000e+00, %if.else304.4 ]
  %sub315.5 = add i32 %29, %mul26.1
  %add335.5 = or disjoint i32 %mul309, 1
  %sub336.5 = add i32 %add335.5, %mul26.1
  %add356.5 = or disjoint i32 %mul309, 1
  %sub357.5 = add i32 %add356.5, %mul26.1
  %cmp359.5 = icmp slt i32 %sub315.5, 0
  %cmp361.5 = icmp sgt i32 %sub336.5, 255
  %or.cond682.not763.5 = select i1 %cmp359.5, i1 true, i1 %cmp361.5
  %cmp364.not.5 = icmp sgt i32 %sub357.5, %0
  %or.cond726.5 = select i1 %or.cond682.not763.5, i1 true, i1 %cmp364.not.5
  br i1 %or.cond726.5, label %if.else304.6, label %if.then365.5

if.then365.5:                                     ; preds = %if.else304.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %28, i64 1
  %mul368.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul368.5, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.else304.6

if.else304.6:                                     ; preds = %if.else304.5, %if.then365.5
  %condval_5.0.5 = phi float [ %41, %if.then365.5 ], [ 0.000000e+00, %if.else304.5 ]
  %sub315.6 = add i32 %29, %mul26.1
  %add335.6 = or disjoint i32 %mul309, 2
  %sub336.6 = add i32 %add335.6, %mul26.1
  %add356.6 = or disjoint i32 %mul309, 2
  %sub357.6 = add i32 %add356.6, %mul26.1
  %cmp359.6 = icmp slt i32 %sub315.6, 0
  %cmp361.6 = icmp sgt i32 %sub336.6, 255
  %or.cond682.not763.6 = select i1 %cmp359.6, i1 true, i1 %cmp361.6
  %cmp364.not.6 = icmp sgt i32 %sub357.6, %0
  %or.cond726.6 = select i1 %or.cond682.not763.6, i1 true, i1 %cmp364.not.6
  br i1 %or.cond726.6, label %if.else304.7, label %if.then365.6

if.then365.6:                                     ; preds = %if.else304.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %28, i64 2
  %mul368.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul368.6, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.else304.7

if.else304.7:                                     ; preds = %if.else304.6, %if.then365.6
  %condval_5.0.6 = phi float [ %43, %if.then365.6 ], [ 0.000000e+00, %if.else304.6 ]
  %sub315.7 = add i32 %29, %mul26.1
  %add335.7 = or i32 %29, 3
  %sub336.7 = add i32 %add335.7, %mul26.1
  %add356.7 = or i32 %29, 3
  %sub357.7 = add i32 %add356.7, %mul26.1
  %cmp359.7 = icmp slt i32 %sub315.7, 0
  %cmp361.7 = icmp sgt i32 %sub336.7, 255
  %or.cond682.not763.7 = or i1 %cmp359.7, %cmp361.7
  %cmp364.not.7 = icmp sgt i32 %sub357.7, %0
  %or.cond726.7 = select i1 %or.cond682.not763.7, i1 true, i1 %cmp364.not.7
  br i1 %or.cond726.7, label %if.end372.7, label %if.then365.7

if.then365.7:                                     ; preds = %if.else304.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %28, i64 3
  %mul368.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul368.7, float 0x4024CB5EC0000000)
  %45 = tail call contract noundef float @llvm.exp.f32(float %44)
  br label %if.end372.7

if.end372.7:                                      ; preds = %if.then365.7, %if.else304.7
  %condval_5.0.7 = phi float [ %45, %if.then365.7 ], [ 0.000000e+00, %if.else304.7 ]
  %add392.1 = fadd contract float %condval_5.0, %condval_5.0.1
  %add392.2 = fadd contract float %add392.1, %condval_5.0.2
  %add392.3 = fadd contract float %add392.2, %condval_5.0.3
  %add392.1777 = fadd contract float %add392.3, %condval_5.0.4
  %add392.1.1 = fadd contract float %add392.1777, %condval_5.0.5
  %add392.2.1 = fadd contract float %add392.1.1, %condval_5.0.6
  %add392.3.1 = fadd contract float %add392.2.1, %condval_5.0.7
  %46 = bitcast float %add392.3.1 to i32
  %47 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %48 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %47) #10
  %xor403 = and i32 %1, 63
  %and.i.i = and i32 %48, 1073741760
  %49 = or disjoint i32 %and.i.i, %xor403
  %add.i.i = shl nuw i32 %49, 2
  %shl.i.i = xor i32 %add.i.i, 128
  %50 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %46)
  %51 = bitcast i32 %50 to float
  %add405 = fadd contract float %add392.3.1, %51
  %52 = bitcast float %add405 to i32
  %53 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %54 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %53) #10
  %and.i.i716 = and i32 %54, 1073741760
  %55 = or disjoint i32 %and.i.i716, %xor403
  %add.i.i717 = shl nuw i32 %55, 2
  %shl.i.i718 = xor i32 %add.i.i717, 64
  %56 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i718, i32 %52)
  %57 = bitcast i32 %56 to float
  %add412 = fadd contract float %add405, %57
  %cmp415 = fcmp contract ogt float %add412, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add412
  %condval_9.0 = select i1 %cmp415, float %div, float 0.000000e+00
  %mul428 = fmul contract float %condval_9.0, %condval_5.0
  %mul428.1 = fmul contract float %condval_9.0, %condval_5.0.1
  %mul428.2 = fmul contract float %condval_9.0, %condval_5.0.2
  %mul428.3 = fmul contract float %condval_9.0, %condval_5.0.3
  %mul428.4 = fmul contract float %condval_9.0, %condval_5.0.4
  %mul428.5 = fmul contract float %condval_9.0, %condval_5.0.5
  %mul428.6 = fmul contract float %condval_9.0, %condval_5.0.6
  %mul428.7 = fmul contract float %condval_9.0, %condval_5.0.7
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428)
  %59 = insertelement <4 x i16> poison, i16 %58, i64 0
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428.1)
  %61 = insertelement <4 x i16> %59, i16 %60, i64 1
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428.2)
  %63 = insertelement <4 x i16> %61, i16 %62, i64 2
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428.3)
  %65 = insertelement <4 x i16> %63, i16 %64, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %65 to <4 x half>
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428.4)
  %67 = insertelement <4 x i16> poison, i16 %66, i64 0
  %68 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428.5)
  %69 = insertelement <4 x i16> %67, i16 %68, i64 1
  %70 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428.6)
  %71 = insertelement <4 x i16> %69, i16 %70, i64 2
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul428.7)
  %73 = insertelement <4 x i16> %71, i16 %72, i64 3
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %73 to <4 x half>
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %mul472 = and i32 %add.ptr288.idx, 16128
  %and479 = and i32 %1, 15
  %add480 = or disjoint i32 %mul472, %and479
  %arrayidx482 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480
  %74 = load half, ptr addrspace(3) %arrayidx482, align 2, !tbaa !27
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %74, i64 0
  %add475.1 = or disjoint i32 %mul472, %and479
  %add480.1 = or disjoint i32 %add475.1, 64
  %arrayidx482.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1
  %75 = load half, ptr addrspace(3) %arrayidx482.1, align 2, !tbaa !27
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %75, i64 1
  %add475.2 = or disjoint i32 %mul472, %and479
  %add480.2 = or disjoint i32 %add475.2, 128
  %arrayidx482.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2
  %76 = load half, ptr addrspace(3) %arrayidx482.2, align 2, !tbaa !27
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %76, i64 2
  %add475.3 = or disjoint i32 %mul472, %and479
  %add480.3 = or disjoint i32 %add475.3, 192
  %arrayidx482.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3
  %77 = load half, ptr addrspace(3) %arrayidx482.3, align 2, !tbaa !27
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %77, i64 3
  %add477.1780 = or disjoint i32 %mul472, %and479
  %add480.1781 = or disjoint i32 %add477.1780, 16
  %arrayidx482.1782 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1781
  %78 = load half, ptr addrspace(3) %arrayidx482.1782, align 2, !tbaa !27
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %78, i64 0
  %add477.1.1 = or disjoint i32 %mul472, %and479
  %add480.1.1 = or disjoint i32 %add477.1.1, 80
  %arrayidx482.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1.1
  %79 = load half, ptr addrspace(3) %arrayidx482.1.1, align 2, !tbaa !27
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %79, i64 1
  %add477.2.1 = or disjoint i32 %mul472, %and479
  %add480.2.1 = or disjoint i32 %add477.2.1, 144
  %arrayidx482.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2.1
  %80 = load half, ptr addrspace(3) %arrayidx482.2.1, align 2, !tbaa !27
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %80, i64 2
  %add477.3.1 = or disjoint i32 %mul472, %and479
  %add480.3.1 = or disjoint i32 %add477.3.1, 208
  %arrayidx482.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3.1
  %81 = load half, ptr addrspace(3) %arrayidx482.3.1, align 2, !tbaa !27
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %81, i64 3
  %add477.2784 = or disjoint i32 %mul472, %and479
  %add480.2785 = or disjoint i32 %add477.2784, 32
  %arrayidx482.2786 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2785
  %82 = load half, ptr addrspace(3) %arrayidx482.2786, align 2, !tbaa !27
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %82, i64 0
  %add477.1.2 = or disjoint i32 %mul472, %and479
  %add480.1.2 = or disjoint i32 %add477.1.2, 96
  %arrayidx482.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1.2
  %83 = load half, ptr addrspace(3) %arrayidx482.1.2, align 2, !tbaa !27
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %83, i64 1
  %add477.2.2 = or disjoint i32 %mul472, %and479
  %add480.2.2 = or disjoint i32 %add477.2.2, 160
  %arrayidx482.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2.2
  %84 = load half, ptr addrspace(3) %arrayidx482.2.2, align 2, !tbaa !27
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %84, i64 2
  %add477.3.2 = or disjoint i32 %mul472, %and479
  %add480.3.2 = or disjoint i32 %add477.3.2, 224
  %arrayidx482.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3.2
  %85 = load half, ptr addrspace(3) %arrayidx482.3.2, align 2, !tbaa !27
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %85, i64 3
  %add477.3788 = or disjoint i32 %mul472, %and479
  %add480.3789 = or disjoint i32 %add477.3788, 48
  %arrayidx482.3790 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3789
  %86 = load half, ptr addrspace(3) %arrayidx482.3790, align 2, !tbaa !27
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %86, i64 0
  %add477.1.3 = or disjoint i32 %mul472, %and479
  %add480.1.3 = or disjoint i32 %add477.1.3, 112
  %arrayidx482.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1.3
  %87 = load half, ptr addrspace(3) %arrayidx482.1.3, align 2, !tbaa !27
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %87, i64 1
  %add477.2.3 = or disjoint i32 %mul472, %and479
  %add480.2.3 = or disjoint i32 %add477.2.3, 176
  %arrayidx482.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2.3
  %88 = load half, ptr addrspace(3) %arrayidx482.2.3, align 2, !tbaa !27
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %88, i64 2
  %add477.3.3 = or disjoint i32 %add.ptr288.idx, %and479
  %add480.3.3 = or i32 %add477.3.3, 240
  %arrayidx482.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3.3
  %89 = load half, ptr addrspace(3) %arrayidx482.3.3, align 2, !tbaa !27
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %89, i64 3
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add473.1 = add nuw nsw i32 %mul472, 1024
  %add480.1792 = or disjoint i32 %add473.1, %and479
  %arrayidx482.1793 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1792
  %94 = load half, ptr addrspace(3) %arrayidx482.1793, align 2, !tbaa !27
  %vb.sroa.0.0.vec.insert820 = insertelement <4 x half> poison, half %94, i64 0
  %add475.1.1794 = add nuw nsw i32 %mul472, 1088
  %add480.1.1795 = or disjoint i32 %add475.1.1794, %and479
  %arrayidx482.1.1796 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1.1795
  %95 = load half, ptr addrspace(3) %arrayidx482.1.1796, align 2, !tbaa !27
  %vb.sroa.0.2.vec.insert822 = insertelement <4 x half> %vb.sroa.0.0.vec.insert820, half %95, i64 1
  %add475.2.1798 = add nuw nsw i32 %mul472, 1152
  %add480.2.1799 = or disjoint i32 %add475.2.1798, %and479
  %arrayidx482.2.1800 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2.1799
  %96 = load half, ptr addrspace(3) %arrayidx482.2.1800, align 2, !tbaa !27
  %vb.sroa.0.4.vec.insert824 = insertelement <4 x half> %vb.sroa.0.2.vec.insert822, half %96, i64 2
  %add475.3.1802 = add nuw nsw i32 %mul472, 1216
  %add480.3.1803 = or disjoint i32 %add475.3.1802, %and479
  %arrayidx482.3.1804 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3.1803
  %97 = load half, ptr addrspace(3) %arrayidx482.3.1804, align 2, !tbaa !27
  %vb.sroa.0.6.vec.insert826 = insertelement <4 x half> %vb.sroa.0.4.vec.insert824, half %97, i64 3
  %add477.1780.1 = add nuw nsw i32 %mul472, 1040
  %add480.1781.1 = or disjoint i32 %add477.1780.1, %and479
  %arrayidx482.1782.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1781.1
  %98 = load half, ptr addrspace(3) %arrayidx482.1782.1, align 2, !tbaa !27
  %vb.sroa.12.8.vec.insert830 = insertelement <4 x half> poison, half %98, i64 0
  %add477.1.1.1 = add nuw nsw i32 %mul472, 1104
  %add480.1.1.1 = or disjoint i32 %add477.1.1.1, %and479
  %arrayidx482.1.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1.1.1
  %99 = load half, ptr addrspace(3) %arrayidx482.1.1.1, align 2, !tbaa !27
  %vb.sroa.12.10.vec.insert832 = insertelement <4 x half> %vb.sroa.12.8.vec.insert830, half %99, i64 1
  %add477.2.1.1 = add nuw nsw i32 %mul472, 1168
  %add480.2.1.1 = or disjoint i32 %add477.2.1.1, %and479
  %arrayidx482.2.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2.1.1
  %100 = load half, ptr addrspace(3) %arrayidx482.2.1.1, align 2, !tbaa !27
  %vb.sroa.12.12.vec.insert834 = insertelement <4 x half> %vb.sroa.12.10.vec.insert832, half %100, i64 2
  %add477.3.1.1 = add nuw nsw i32 %mul472, 1232
  %add480.3.1.1 = or disjoint i32 %add477.3.1.1, %and479
  %arrayidx482.3.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3.1.1
  %101 = load half, ptr addrspace(3) %arrayidx482.3.1.1, align 2, !tbaa !27
  %vb.sroa.12.14.vec.insert836 = insertelement <4 x half> %vb.sroa.12.12.vec.insert834, half %101, i64 3
  %add477.2784.1 = add nuw nsw i32 %mul472, 1056
  %add480.2785.1 = or disjoint i32 %add477.2784.1, %and479
  %arrayidx482.2786.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2785.1
  %102 = load half, ptr addrspace(3) %arrayidx482.2786.1, align 2, !tbaa !27
  %vb.sroa.22.16.vec.insert840 = insertelement <4 x half> poison, half %102, i64 0
  %add477.1.2.1 = add nuw nsw i32 %mul472, 1120
  %add480.1.2.1 = or disjoint i32 %add477.1.2.1, %and479
  %arrayidx482.1.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1.2.1
  %103 = load half, ptr addrspace(3) %arrayidx482.1.2.1, align 2, !tbaa !27
  %vb.sroa.22.18.vec.insert842 = insertelement <4 x half> %vb.sroa.22.16.vec.insert840, half %103, i64 1
  %add477.2.2.1 = add nuw nsw i32 %mul472, 1184
  %add480.2.2.1 = or disjoint i32 %add477.2.2.1, %and479
  %arrayidx482.2.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2.2.1
  %104 = load half, ptr addrspace(3) %arrayidx482.2.2.1, align 2, !tbaa !27
  %vb.sroa.22.20.vec.insert844 = insertelement <4 x half> %vb.sroa.22.18.vec.insert842, half %104, i64 2
  %add477.3.2.1 = add nuw nsw i32 %mul472, 1248
  %add480.3.2.1 = or disjoint i32 %add477.3.2.1, %and479
  %arrayidx482.3.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3.2.1
  %105 = load half, ptr addrspace(3) %arrayidx482.3.2.1, align 2, !tbaa !27
  %vb.sroa.22.22.vec.insert846 = insertelement <4 x half> %vb.sroa.22.20.vec.insert844, half %105, i64 3
  %add477.3788.1 = add nuw nsw i32 %mul472, 1072
  %add480.3789.1 = or disjoint i32 %add477.3788.1, %and479
  %arrayidx482.3790.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3789.1
  %106 = load half, ptr addrspace(3) %arrayidx482.3790.1, align 2, !tbaa !27
  %vb.sroa.32.24.vec.insert850 = insertelement <4 x half> poison, half %106, i64 0
  %add477.1.3.1 = add nuw nsw i32 %mul472, 1136
  %add480.1.3.1 = or disjoint i32 %add477.1.3.1, %and479
  %arrayidx482.1.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.1.3.1
  %107 = load half, ptr addrspace(3) %arrayidx482.1.3.1, align 2, !tbaa !27
  %vb.sroa.32.26.vec.insert852 = insertelement <4 x half> %vb.sroa.32.24.vec.insert850, half %107, i64 1
  %add477.2.3.1 = add nuw nsw i32 %mul472, 1200
  %add480.2.3.1 = or disjoint i32 %add477.2.3.1, %and479
  %arrayidx482.2.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.2.3.1
  %108 = load half, ptr addrspace(3) %arrayidx482.2.3.1, align 2, !tbaa !27
  %vb.sroa.32.28.vec.insert854 = insertelement <4 x half> %vb.sroa.32.26.vec.insert852, half %108, i64 2
  %add477.3.3.1 = add nuw nsw i32 %mul472, 1264
  %add480.3.3.1 = or disjoint i32 %add477.3.3.1, %and479
  %arrayidx482.3.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add480.3.3.1
  %109 = load half, ptr addrspace(3) %arrayidx482.3.3.1, align 2, !tbaa !27
  %vb.sroa.32.30.vec.insert856 = insertelement <4 x half> %vb.sroa.32.28.vec.insert854, half %109, i64 3
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert826, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %90)
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert836, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %91)
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert846, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %92)
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert856, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %93)
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %110, i64 0
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_cast.sroa.0.0.insert.ext = zext i16 %114 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %110, i64 1
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_cast.sroa.0.2.insert.ext = zext i16 %115 to i64
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %110, i64 2
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_cast.sroa.0.4.insert.ext = zext i16 %116 to i64
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %110, i64 3
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_cast.sroa.0.6.insert.ext = zext i16 %117 to i64
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %111, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract)
  %O_cast.sroa.7.8.insert.ext = zext i16 %118 to i64
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %111, i64 1
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract)
  %O_cast.sroa.7.10.insert.ext = zext i16 %119 to i64
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %111, i64 2
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract)
  %O_cast.sroa.7.12.insert.ext = zext i16 %120 to i64
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %111, i64 3
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract)
  %O_cast.sroa.7.14.insert.ext = zext i16 %121 to i64
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %112, i64 0
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract)
  %O_cast.sroa.12.16.insert.ext = zext i16 %122 to i64
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %112, i64 1
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract)
  %O_cast.sroa.12.18.insert.ext = zext i16 %123 to i64
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %112, i64 2
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract)
  %O_cast.sroa.12.20.insert.ext = zext i16 %124 to i64
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %112, i64 3
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract)
  %O_cast.sroa.12.22.insert.ext = zext i16 %125 to i64
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %113, i64 0
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract)
  %O_cast.sroa.17.24.insert.ext = zext i16 %126 to i64
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %113, i64 1
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract)
  %O_cast.sroa.17.26.insert.ext = zext i16 %127 to i64
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %113, i64 2
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract)
  %O_cast.sroa.17.28.insert.ext = zext i16 %128 to i64
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %113, i64 3
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract)
  %O_cast.sroa.17.30.insert.ext = zext i16 %129 to i64
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift
  %add553 = add nuw nsw i32 %add, %mul309
  %130 = zext nneg i32 %add553 to i64
  %add.ptr559 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr559, align 8
  %131 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130
  %add.ptr559.1 = getelementptr inbounds i8, ptr addrspace(1) %131, i64 32
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr559.1, align 8
  %132 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130
  %add.ptr559.2 = getelementptr inbounds i8, ptr addrspace(1) %132, i64 64
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr559.2, align 8
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130
  %add.ptr559.3 = getelementptr inbounds i8, ptr addrspace(1) %133, i64 96
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr559.3, align 8
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: convergent mustprogress nounwind willreturn
declare void @llvm.mxc.barrier() #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent mustprogress nofree nounwind willreturn memory(none) }
attributes #5 = { mustprogress nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { convergent mustprogress nounwind willreturn }
attributes #8 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { mustprogress nounwind willreturn }
attributes #10 = { nomerge }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 1}
!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!7, !9, i64 16}
!7 = !{!"_ZTS21_DynamicParallMqlWrap", !8, i64 0, !8, i64 4, !8, i64 8, !8, i64 12, !9, i64 16, !9, i64 24, !10, i64 32}
!8 = !{!"int", !4, i64 0}
!9 = !{!"any pointer", !4, i64 0}
!10 = !{!"_ZTS28mxc_kernel_dispatch_packet_s", !11, i64 0, !11, i64 2, !11, i64 4, !11, i64 6, !11, i64 8, !11, i64 10, !8, i64 12, !8, i64 16, !8, i64 20, !8, i64 24, !8, i64 28, !3, i64 32, !9, i64 40, !3, i64 48, !12, i64 56}
!11 = !{!"short", !4, i64 0}
!12 = !{!"_ZTS12mxc_signal_s", !3, i64 0}
!13 = !{i32 1, i32 -2147483648}
!14 = !{}
!15 = !{i32 0, i32 2147483647}
!16 = !{!8, !8, i64 0}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.mustprogress"}
!19 = !{!7, !8, i64 4}
!20 = !{!7, !9, i64 24}
!21 = !{!7, !8, i64 0}
!22 = !{!23, !9, i64 24}
!23 = !{!"_ZTS28_DynamicParallSchedulerParam", !3, i64 0, !9, i64 8, !9, i64 16, !9, i64 24, !3, i64 32, !3, i64 40, !3, i64 48, !3, i64 56, !3, i64 64, !3, i64 72, !3, i64 80, !3, i64 88, !3, i64 96, !8, i64 104, !8, i64 108, !8, i64 112, !8, i64 116, !8, i64 120, !8, i64 124}
!24 = !{!23, !3, i64 80}
!25 = !{i32 0, i32 1024}
!26 = !{i32 -1, i32 3, i32 -1}
!27 = !{!11, !11, i64 0}
