; ModuleID = 'experiments/20261002_goal885/coalesced_register_q0k0_43.cpp'
source_filename = "experiments/20261002_goal885/coalesced_register_q0k0_43.cpp"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !15
  %mul = shl nsw i32 %0, 20
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !25
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %4 = add nuw nsw i64 %3, 512
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %mul17 = shl nsw i32 %0, 10
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !16
  %cmp34 = icmp ugt i32 %5, 63
  %shr = lshr i32 %1, 4
  %cmp37.not = icmp ugt i32 %5, %shr
  %or.cond831 = or i1 %cmp34, %cmp37.not
  br i1 %or.cond831, label %if.end441, label %if.then

if.then:                                          ; preds = %entry
  %mul38 = shl nuw nsw i32 %5, 4
  %shr46 = lshr i32 %2, 3
  %add48 = add nuw nsw i32 %mul38, %shr46
  %conv = zext nneg i32 %0 to i64
  %mul78 = shl nuw nsw i64 %conv, 16
  %mul88 = zext nneg i32 %mul11 to i64
  %6 = shl nuw nsw i32 %5, 11
  %.idx722 = zext nneg i32 %6 to i64
  %invariant.gep = getelementptr inbounds i8, ptr addrspace(4) %K.coerce, i64 %.idx722
  %invariant.gep793 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %mul88
  %cmp51 = icmp ult i32 %add48, 1024
  br i1 %cmp51, label %if.then76, label %if.end

if.then76:                                        ; preds = %if.then
  %gep794 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep793, i64 %mul78
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %gep794, align 16, !tbaa !16
  %condval.sroa.5.0.add.ptr90.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep794, i64 4
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr90.sroa_idx, align 4, !tbaa !16
  %condval.sroa.6.0.add.ptr90.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep794, i64 8
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr90.sroa_idx, align 8, !tbaa !16
  %condval.sroa.7.0.add.ptr90.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep794, i64 12
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr90.sroa_idx, align 4, !tbaa !16
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then76
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then76 ], [ 0, %if.then ]
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then76 ], [ 0, %if.then ]
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then76 ], [ 0, %if.then ]
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then76 ], [ 0, %if.then ]
  %cmp51.1 = icmp ult i32 %add48, 1016
  br i1 %cmp51.1, label %if.then76.1, label %if.end.1

if.then76.1:                                      ; preds = %if.end
  %add81.1 = or disjoint i64 %mul78, 512
  %gep794.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep793, i64 %add81.1
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep794.1, align 16, !tbaa !16
  %condval.sroa.5.0.add.ptr90.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep794.1, i64 4
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr90.sroa_idx.1, align 4, !tbaa !16
  %condval.sroa.6.0.add.ptr90.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep794.1, i64 8
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr90.sroa_idx.1, align 8, !tbaa !16
  %condval.sroa.7.0.add.ptr90.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep794.1, i64 12
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr90.sroa_idx.1, align 4, !tbaa !16
  br label %if.end.1

if.end.1:                                         ; preds = %if.then76.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then76.1 ], [ 0, %if.end ]
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then76.1 ], [ 0, %if.end ]
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then76.1 ], [ 0, %if.end ]
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then76.1 ], [ 0, %if.end ]
  %invariant.gep796 = getelementptr inbounds i8, ptr addrspace(4) %V.coerce, i64 %.idx722
  %invariant.gep797 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep796, i64 %mul88
  br i1 %cmp51, label %if.then154, label %if.end193

if.then154:                                       ; preds = %if.end.1
  %gep798 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep797, i64 %mul78
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %gep798, align 16, !tbaa !16
  %condval_1.sroa.5.0.add.ptr169.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep798, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr169.sroa_idx, align 4, !tbaa !16
  %condval_1.sroa.6.0.add.ptr169.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep798, i64 8
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr169.sroa_idx, align 8, !tbaa !16
  %condval_1.sroa.7.0.add.ptr169.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep798, i64 12
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr169.sroa_idx, align 4, !tbaa !16
  br label %if.end193

if.end193:                                        ; preds = %if.end.1, %if.then154
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then154 ], [ 0, %if.end.1 ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then154 ], [ 0, %if.end.1 ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then154 ], [ 0, %if.end.1 ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then154 ], [ 0, %if.end.1 ]
  br i1 %cmp51.1, label %if.then154.1, label %if.end193.1

if.then154.1:                                     ; preds = %if.end193
  %add160.1 = or disjoint i64 %mul78, 512
  %gep798.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep797, i64 %add160.1
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep798.1, align 16, !tbaa !16
  %condval_1.sroa.5.0.add.ptr169.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep798.1, i64 4
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr169.sroa_idx.1, align 4, !tbaa !16
  %condval_1.sroa.6.0.add.ptr169.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep798.1, i64 8
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr169.sroa_idx.1, align 8, !tbaa !16
  %condval_1.sroa.7.0.add.ptr169.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep798.1, i64 12
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr169.sroa_idx.1, align 4, !tbaa !16
  br label %if.end193.1

if.end193.1:                                      ; preds = %if.then154.1, %if.end193
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then154.1 ], [ 0, %if.end193 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then154.1 ], [ 0, %if.end193 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then154.1 ], [ 0, %if.end193 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then154.1 ], [ 0, %if.end193 ]
  %mul213 = and i32 %mul11, 8128
  %xor720 = and i32 %mul11, 56
  %call216.masked = and i32 %2, 1016
  %mul218 = xor i32 %xor720, %call216.masked
  %invariant.gep799 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul213
  %invariant.gep800 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep799, i32 %mul218
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep800, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !26
  %gep801.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep800, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep801.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !26
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and231 = shl nuw nsw i32 %2, 6
  %mul232 = and i32 %and231, 960
  %shr235 = lshr i32 %2, 4
  %and238 = and i32 %2, 7
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul232
  %xor239 = xor i32 %shr235, %and238
  %add.ptr243.idx = shl nuw nsw i32 %xor239, 4
  %add.ptr243 = getelementptr inbounds i8, ptr addrspace(3) %7, i32 %add.ptr243.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr243, align 16
  %Q_reg.sroa.4.0.add.ptr243.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr243, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr243.sroa_idx, align 8
  %add236.1 = add nuw nsw i32 %shr235, 4
  %xor239.1 = xor i32 %add236.1, %and238
  %add.ptr243.idx.1 = shl nuw nsw i32 %xor239.1, 4
  %add.ptr243.1 = getelementptr inbounds i8, ptr addrspace(3) %7, i32 %add.ptr243.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr243.1, align 16
  %Q_reg.sroa.7.16.add.ptr243.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr243.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr243.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %condval.sroa.0.0, ptr addrspace(3) %invariant.gep800, align 16, !tbaa !16
  %K_reg.sroa.4.0.invariant.gep805.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep800, i32 4
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep805.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.5.0.invariant.gep805.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep800, i32 8
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep805.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.6.0.invariant.gep805.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep800, i32 12
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep805.sroa_idx, align 4, !tbaa !16
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %gep801.1, align 16, !tbaa !16
  %K_reg.sroa.9.16.gep806.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep800, i32 1028
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep806.1.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.10.16.gep806.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep800, i32 1032
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep806.1.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.11.16.gep806.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep800, i32 1036
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep806.1.sroa_idx, align 4, !tbaa !16
  %add279 = or disjoint i32 %mul38, 15
  %cmp280 = icmp ult i32 %1, %add279
  br i1 %cmp280, label %for.cond282.preheader, label %if.end309

for.cond282.preheader:                            ; preds = %if.end193.1
  %8 = lshr i32 %2, 2
  %mul289 = and i32 %8, 252
  %add291 = add nuw nsw i32 %mul38, %mul289
  %cmp294.not = icmp ugt i32 %add291, %1
  %spec.select = select i1 %cmp294.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert872 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp294.not.1.not = icmp ult i32 %add291, %1
  %spec.select.1 = select i1 %cmp294.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert885 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert872, float %spec.select.1, i64 1
  %add292.2 = or disjoint i32 %add291, 2
  %cmp294.not.2 = icmp ugt i32 %add292.2, %1
  %spec.select.2 = select i1 %cmp294.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert898 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert885, float %spec.select.2, i64 2
  %add292.3 = or disjoint i32 %add291, 3
  %cmp294.not.3 = icmp ugt i32 %add292.3, %1
  %spec.select.3 = select i1 %cmp294.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert911 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert898, float %spec.select.3, i64 3
  br label %if.end309

if.end309:                                        ; preds = %if.end193.1, %for.cond282.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert911, %for.cond282.preheader ], [ zeroinitializer, %if.end193.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr243, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr243.sroa_idx, align 8
  %9 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0)
  %10 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %9)
  %kb.sroa.0.0.copyload866 = load <4 x half>, ptr addrspace(3) %add.ptr243.1, align 16
  %kb.sroa.6.0.copyload867 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr243.1.sroa_idx, align 8
  %11 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload866, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %10)
  %12 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload867, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %11)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr366.idx = shl nuw nsw i32 %2, 4
  %invariant.gep814 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr366.idx
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep814, align 16, !tbaa !16
  %V_reg.sroa.4.0.invariant.gep814.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep814, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep814.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.5.0.invariant.gep814.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep814, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep814.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.6.0.invariant.gep814.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep814, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep814.sroa_idx, align 4, !tbaa !16
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep814, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !tbaa !16
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep814, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep814, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep814, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !16
  %acc_s.sroa.0.0.vec.extract874 = extractelement <4 x float> %12, i64 0
  %mul376 = fmul contract float %acc_s.sroa.0.0.vec.extract874, 0x3FC2776C60000000
  %13 = tail call contract noundef float @llvm.minnum.f32(float %mul376, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %13, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %13, %cond.i.i
  %14 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %14
  %acc_s.sroa.0.4.vec.extract887 = extractelement <4 x float> %12, i64 1
  %mul376.1 = fmul contract float %acc_s.sroa.0.4.vec.extract887, 0x3FC2776C60000000
  %15 = tail call contract noundef float @llvm.minnum.f32(float %mul376.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %15, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %15, %cond.i.i.1
  %16 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %16
  %acc_s.sroa.0.8.vec.extract900 = extractelement <4 x float> %12, i64 2
  %mul376.2 = fmul contract float %acc_s.sroa.0.8.vec.extract900, 0x3FC2776C60000000
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul376.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %17, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %17, %cond.i.i.2
  %18 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %18
  %acc_s.sroa.0.12.vec.extract913 = extractelement <4 x float> %12, i64 3
  %mul376.3 = fmul contract float %acc_s.sroa.0.12.vec.extract913, 0x3FC2776C60000000
  %19 = tail call contract noundef float @llvm.minnum.f32(float %mul376.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %19, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %19, %cond.i.i.3
  %20 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %20
  %add392 = fadd contract float %mul.i.i, 0.000000e+00
  %add392.1 = fadd contract float %add392, %mul.i.i.1
  %add392.2 = fadd contract float %add392.1, %mul.i.i.2
  %add392.3 = fadd contract float %add392.2, %mul.i.i.3
  %21 = bitcast float %add392.3 to i32
  %22 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %23 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %22) #11
  %xor.i.i = xor i32 %23, 32
  %24 = and i32 %23, -64
  %and.i.i = add nsw i32 %24, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i755 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %23
  %shl.i.i = shl i32 %cond.i.i755, 2
  %25 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %21)
  %26 = bitcast i32 %25 to float
  %add400 = fadd contract float %add392.3, %26
  %27 = bitcast float %add400 to i32
  %28 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %29 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %28) #11
  %xor.i.i756 = xor i32 %29, 16
  %30 = and i32 %29, -64
  %and.i.i757 = add nsw i32 %30, 64
  %cmp.not.i.i758 = icmp slt i32 %xor.i.i756, %and.i.i757
  %cond.i.i759 = select i1 %cmp.not.i.i758, i32 %xor.i.i756, i32 %29
  %shl.i.i760 = shl i32 %cond.i.i759, 2
  %31 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i760, i32 %27)
  %32 = bitcast i32 %31 to float
  %add405 = fadd contract float %add400, %32
  %cmp408 = fcmp contract ogt float %add405, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add405
  %condval_3.0 = select i1 %cmp408, float %div, float 0.000000e+00
  %mul421 = fmul contract float %condval_3.0, %mul.i.i
  %mul421.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul421.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul421.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %33 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !27
  %34 = fptrunc float %mul421 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %33), !noalias !27
  %35 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !27
  %36 = fptrunc float %mul421.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %35), !noalias !27
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %34, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %36, i64 1
  %37 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !32
  %38 = fptrunc float %mul421.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %37), !noalias !32
  %39 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !32
  %40 = fptrunc float %mul421.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %39), !noalias !32
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %38, i64 2
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %40, i64 3
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end441

if.end441:                                        ; preds = %if.end309, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %if.end309 ], [ undef, %entry ]
  br i1 %or.cond831, label %if.end511, label %for.cond463.preheader

for.cond463.preheader:                            ; preds = %if.end441
  %41 = shl nuw nsw i32 %2, 4
  %mul473 = and i32 %41, 16128
  %and479 = and i32 %2, 15
  %add480 = or disjoint i32 %mul473, %and479
  %arrayidx482 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480
  %42 = load half, ptr addrspace(3) %arrayidx482, align 2, !tbaa !37
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %42, i64 0
  %add475.1 = or disjoint i32 %mul473, %and479
  %add480.1 = or disjoint i32 %add475.1, 64
  %arrayidx482.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.1
  %43 = load half, ptr addrspace(3) %arrayidx482.1, align 2, !tbaa !37
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %43, i64 1
  %add475.2 = or disjoint i32 %mul473, %and479
  %add480.2 = or disjoint i32 %add475.2, 128
  %arrayidx482.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.2
  %44 = load half, ptr addrspace(3) %arrayidx482.2, align 2, !tbaa !37
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %44, i64 2
  %add475.3 = or disjoint i32 %mul473, %and479
  %add480.3 = or disjoint i32 %add475.3, 192
  %arrayidx482.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.3
  %45 = load half, ptr addrspace(3) %arrayidx482.3, align 2, !tbaa !37
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %45, i64 3
  %add477.1846 = or disjoint i32 %mul473, %and479
  %add480.1847 = or disjoint i32 %add477.1846, 16
  %arrayidx482.1848 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.1847
  %46 = load half, ptr addrspace(3) %arrayidx482.1848, align 2, !tbaa !37
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %46, i64 0
  %add477.1.1 = or disjoint i32 %mul473, %and479
  %add480.1.1 = or disjoint i32 %add477.1.1, 80
  %arrayidx482.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.1.1
  %47 = load half, ptr addrspace(3) %arrayidx482.1.1, align 2, !tbaa !37
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %47, i64 1
  %add477.2.1 = or disjoint i32 %mul473, %and479
  %add480.2.1 = or disjoint i32 %add477.2.1, 144
  %arrayidx482.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.2.1
  %48 = load half, ptr addrspace(3) %arrayidx482.2.1, align 2, !tbaa !37
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %48, i64 2
  %add477.3.1 = or disjoint i32 %mul473, %and479
  %add480.3.1 = or disjoint i32 %add477.3.1, 208
  %arrayidx482.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.3.1
  %49 = load half, ptr addrspace(3) %arrayidx482.3.1, align 2, !tbaa !37
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %49, i64 3
  %add477.2850 = or disjoint i32 %mul473, %and479
  %add480.2851 = or disjoint i32 %add477.2850, 32
  %arrayidx482.2852 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.2851
  %50 = load half, ptr addrspace(3) %arrayidx482.2852, align 2, !tbaa !37
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %50, i64 0
  %add477.1.2 = or disjoint i32 %mul473, %and479
  %add480.1.2 = or disjoint i32 %add477.1.2, 96
  %arrayidx482.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.1.2
  %51 = load half, ptr addrspace(3) %arrayidx482.1.2, align 2, !tbaa !37
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %51, i64 1
  %add477.2.2 = or disjoint i32 %mul473, %and479
  %add480.2.2 = or disjoint i32 %add477.2.2, 160
  %arrayidx482.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.2.2
  %52 = load half, ptr addrspace(3) %arrayidx482.2.2, align 2, !tbaa !37
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %52, i64 2
  %add477.3.2 = or disjoint i32 %mul473, %and479
  %add480.3.2 = or disjoint i32 %add477.3.2, 224
  %arrayidx482.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.3.2
  %53 = load half, ptr addrspace(3) %arrayidx482.3.2, align 2, !tbaa !37
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %53, i64 3
  %add477.3854 = or disjoint i32 %mul473, %and479
  %add480.3855 = or disjoint i32 %add477.3854, 48
  %arrayidx482.3856 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.3855
  %54 = load half, ptr addrspace(3) %arrayidx482.3856, align 2, !tbaa !37
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %54, i64 0
  %add477.1.3 = or disjoint i32 %mul473, %and479
  %add480.1.3 = or disjoint i32 %add477.1.3, 112
  %arrayidx482.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.1.3
  %55 = load half, ptr addrspace(3) %arrayidx482.1.3, align 2, !tbaa !37
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %55, i64 1
  %add477.2.3 = or disjoint i32 %mul473, %and479
  %add480.2.3 = or disjoint i32 %add477.2.3, 176
  %arrayidx482.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.2.3
  %56 = load half, ptr addrspace(3) %arrayidx482.2.3, align 2, !tbaa !37
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %56, i64 2
  %add477.3.3 = or disjoint i32 %41, %and479
  %add480.3.3 = or i32 %add477.3.3, 240
  %arrayidx482.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.3.3
  %57 = load half, ptr addrspace(3) %arrayidx482.3.3, align 2, !tbaa !37
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %57, i64 3
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end511

if.end511:                                        ; preds = %for.cond463.preheader, %if.end441
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end441 ], [ %58, %for.cond463.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end441 ], [ %59, %for.cond463.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end441 ], [ %60, %for.cond463.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end441 ], [ %61, %for.cond463.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %62 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %63 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %62), !noalias !38
  %64 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %65 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %64), !noalias !38
  %66 = bitcast half %63 to i16
  %67 = bitcast half %65 to i16
  %68 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %69 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %68), !noalias !43
  %70 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %71 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %70), !noalias !43
  %72 = bitcast half %69 to i16
  %73 = bitcast half %71 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %73 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %72 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %67 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %66 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %74 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %75 = fptrunc float %acc_o.sroa.16.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %74), !noalias !38
  %76 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %77 = fptrunc float %acc_o.sroa.16.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %76), !noalias !38
  %78 = bitcast half %75 to i16
  %79 = bitcast half %77 to i16
  %80 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %81 = fptrunc float %acc_o.sroa.16.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %80), !noalias !43
  %82 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %83 = fptrunc float %acc_o.sroa.16.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %82), !noalias !43
  %84 = bitcast half %81 to i16
  %85 = bitcast half %83 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %85 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %84 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %79 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %78 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %86 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %87 = fptrunc float %acc_o.sroa.30.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %86), !noalias !38
  %88 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %89 = fptrunc float %acc_o.sroa.30.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %88), !noalias !38
  %90 = bitcast half %87 to i16
  %91 = bitcast half %89 to i16
  %92 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %93 = fptrunc float %acc_o.sroa.30.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %92), !noalias !43
  %94 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %95 = fptrunc float %acc_o.sroa.30.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %94), !noalias !43
  %96 = bitcast half %93 to i16
  %97 = bitcast half %95 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %97 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %96 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %91 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %90 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %98 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %99 = fptrunc float %acc_o.sroa.44.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %98), !noalias !38
  %100 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %101 = fptrunc float %acc_o.sroa.44.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %100), !noalias !38
  %102 = bitcast half %99 to i16
  %103 = bitcast half %101 to i16
  %104 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %105 = fptrunc float %acc_o.sroa.44.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %104), !noalias !43
  %106 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %107 = fptrunc float %acc_o.sroa.44.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %106), !noalias !43
  %108 = bitcast half %105 to i16
  %109 = bitcast half %107 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %109 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %108 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %103 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %102 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and546 = shl nuw nsw i32 %2, 6
  %mul547 = and i32 %and546, 960
  %shr550 = lshr i32 %2, 5
  %and553 = and i32 %2, 7
  %110 = lshr i32 %2, 2
  %mul560 = and i32 %110, 4
  %xor554 = xor i32 %shr550, %and553
  %mul555 = shl nuw nsw i32 %xor554, 3
  %add556 = add nuw nsw i32 %mul555, %mul547
  %add561 = or disjoint i32 %add556, %mul560
  %add.ptr563 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add561
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(3) %add.ptr563, align 8
  %add551.1 = add nuw nsw i32 %shr550, 2
  %xor554.1 = xor i32 %add551.1, %and553
  %mul555.1 = shl nuw nsw i32 %xor554.1, 3
  %add556.1 = add nuw nsw i32 %mul555.1, %mul547
  %add561.1 = or disjoint i32 %add556.1, %mul560
  %add.ptr563.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add561.1
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(3) %add.ptr563.1, align 8
  %add551.2 = add nuw nsw i32 %shr550, 4
  %xor554.2 = xor i32 %add551.2, %and553
  %mul555.2 = shl nuw nsw i32 %xor554.2, 3
  %add556.2 = add nuw nsw i32 %mul555.2, %mul547
  %add561.2 = or disjoint i32 %add556.2, %mul560
  %add.ptr563.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add561.2
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(3) %add.ptr563.2, align 8
  %add551.3 = add nuw nsw i32 %shr550, 6
  %xor554.3 = xor i32 %add551.3, %and553
  %mul555.3 = shl nuw nsw i32 %xor554.3, 3
  %add556.3 = add nuw nsw i32 %mul555.3, %mul547
  %add561.3 = or disjoint i32 %add556.3, %mul560
  %add.ptr563.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add561.3
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(3) %add.ptr563.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul574 = and i32 %mul11, 8128
  %xor580716 = and i32 %mul11, 56
  %call578.masked = and i32 %2, 1016
  %mul581 = xor i32 %xor580716, %call578.masked
  %invariant.gep826 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul574
  %invariant.gep828 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep826, i32 %mul581
  %add.ptr596 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr596, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep828, i64 16, i1 false), !tbaa.struct !48, !call_argsrelate !49
  %gep829.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep828, i32 1024
  %add.ptr596.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr596.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep829.1, i64 16, i1 false), !tbaa.struct !48, !call_argsrelate !49
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

; Function Attrs: convergent mustprogress nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

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
declare void @llvm.mxc.sleep(i32 immarg) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #8

; Function Attrs: mustprogress nofree nounwind speculatable willreturn memory(inaccessiblemem: read)
declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent mustprogress nofree nounwind willreturn memory(none) }
attributes #5 = { mustprogress nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent mustprogress nounwind willreturn }
attributes #7 = { mustprogress nounwind willreturn }
attributes #8 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { mustprogress nofree nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

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
!26 = !{i32 -1, i32 3, i32 -1, i32 -1}
!27 = !{!28, !30}
!28 = distinct !{!28, !29, !"_ZL17__floats2half2_rnff: %agg.result"}
!29 = distinct !{!29, !"_ZL17__floats2half2_rnff"}
!30 = distinct !{!30, !31, !"_ZL17__float22half2_rn6float2: %agg.result"}
!31 = distinct !{!31, !"_ZL17__float22half2_rn6float2"}
!32 = !{!33, !35}
!33 = distinct !{!33, !34, !"_ZL17__floats2half2_rnff: %agg.result"}
!34 = distinct !{!34, !"_ZL17__floats2half2_rnff"}
!35 = distinct !{!35, !36, !"_ZL17__float22half2_rn6float2: %agg.result"}
!36 = distinct !{!36, !"_ZL17__float22half2_rn6float2"}
!37 = !{!11, !11, i64 0}
!38 = !{!39, !41}
!39 = distinct !{!39, !40, !"_ZL17__floats2half2_rnff: %agg.result"}
!40 = distinct !{!40, !"_ZL17__floats2half2_rnff"}
!41 = distinct !{!41, !42, !"_ZL17__float22half2_rn6float2: %agg.result"}
!42 = distinct !{!42, !"_ZL17__float22half2_rn6float2"}
!43 = !{!44, !46}
!44 = distinct !{!44, !45, !"_ZL17__floats2half2_rnff: %agg.result"}
!45 = distinct !{!45, !"_ZL17__floats2half2_rnff"}
!46 = distinct !{!46, !47, !"_ZL17__float22half2_rn6float2: %agg.result"}
!47 = distinct !{!47, !"_ZL17__float22half2_rn6float2"}
!48 = !{i64 0, i64 4, !16, i64 4, i64 4, !16, i64 8, i64 4, !16, i64 12, i64 4, !16}
!49 = !{i32 2, i32 -1, i32 -1, i32 -1}
