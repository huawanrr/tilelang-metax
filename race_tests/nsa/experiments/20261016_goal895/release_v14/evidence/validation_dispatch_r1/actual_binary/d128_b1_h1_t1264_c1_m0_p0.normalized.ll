target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

define weak void @__cxa_pure_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

declare void @llvm.trap() #1

define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr()
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !tbaa !17
  %2 = inttoptr i64 %1 to ptr
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !tbaa !17
  %4 = inttoptr i64 %3 to ptr
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16
  %5 = load ptr, ptr %thread_counter.i, align 8, !tbaa !21
  %cmp.not.i = icmp eq ptr %5, null
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr()
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12
  %8 = load i32, ptr addrspace(4) %7, align 4, !range !28, !invariant.load !8
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4
  %10 = load i32, ptr addrspace(4) %9, align 4, !invariant.load !8
  %conv.i14.i.i = and i32 %10, 65535
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16
  %12 = load i32, ptr addrspace(4) %11, align 4, !range !28, !invariant.load !8
  %13 = lshr i32 %10, 16
  %div.i.i.i = udiv i32 %12, %13
  %mul.i.i.i = mul i32 %div.i.i.i, %13
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul.i.i = mul i32 %add.i.i.i, %14
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul320.i.i = add i32 %mul.i.i, %15
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %add8.i.i = add i32 %add.i.i, %16
  %conv.i.i = zext i32 %add8.i.i to i64
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i)
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !tbaa !30
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
  br label %while.cond.i, !llvm.loop !31

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i)
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !tbaa !30
  %add.i37.i = add nsw i32 %21, -1
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !tbaa !30
  br label %_Z9atomicAddPii.exit38.i

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %_Z9atomicAddPii.exit38.i

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ]
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4
  %23 = load i32, ptr %call_deep.i, align 4, !tbaa !33
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
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !tbaa !34
  %25 = load i32, ptr %4, align 8, !tbaa !35
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !tbaa !21
  %idxprom.i = zext i32 %25 to i64
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !tbaa !36
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !tbaa !38
  %29 = inttoptr i64 %28 to ptr
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i)
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !tbaa !30
  %and.i.i.i = and i32 %31, 2147483647
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !tbaa !30
  br label %if.end20.i

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4
  br label %if.end20.i

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i)
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !tbaa !30
  %add.i42.i = add nsw i32 %34, -1
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !tbaa !30
  br label %__mcImplicitDeviceSynchronizeImpl.exit

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %__mcImplicitDeviceSynchronizeImpl.exit

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void
}

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 11
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %1, 7
  %mul7 = and i32 %and, 1920
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
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 128
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 136
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 192
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 200
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %mul17 = shl nsw i32 %7, 4
  %cmp31 = icmp sgt i32 %7, -1
  br i1 %cmp31, label %land.lhs.true, label %if.end371

land.lhs.true:                                    ; preds = %entry
  %cmp32 = icmp ugt i32 %7, 78
  %cmp35.not = icmp sgt i32 %mul17, %0
  %or.cond = select i1 %cmp32, i1 true, i1 %cmp35.not
  br i1 %or.cond, label %if.end371, label %for.cond36.preheader

for.cond36.preheader:                             ; preds = %land.lhs.true
  %shr42 = lshr i32 %1, 4
  %add43 = add nuw nsw i32 %mul17, %shr42
  %mul49 = shl nuw nsw i32 %7, 11
  %mul52 = shl nuw nsw i32 %1, 3
  %add50 = add nuw nsw i32 %mul49, %mul52
  %8 = zext nneg i32 %add50 to i64
  %cmp46 = icmp ult i32 %add43, 1264
  br i1 %cmp46, label %if.then47, label %if.end

if.then47:                                        ; preds = %for.cond36.preheader
  %add.ptr55 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %condval.sroa.7.0.add.ptr55.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr55, i64 12
  %condval.sroa.6.0.add.ptr55.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr55, i64 8
  %condval.sroa.5.0.add.ptr55.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr55, i64 4
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr55, align 16, !tbaa !30
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx, align 4, !tbaa !30
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx, align 8, !tbaa !30
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %for.cond36.preheader, %if.then47
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ]
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ]
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ]
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then47 ], [ 0, %for.cond36.preheader ]
  %cmp46.1 = icmp ult i32 %add43, 1260
  br i1 %cmp46.1, label %if.then47.1, label %if.end.1

if.then47.1:                                      ; preds = %if.end
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %add.ptr55.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1024
  %condval.sroa.7.0.add.ptr55.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1036
  %condval.sroa.6.0.add.ptr55.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1032
  %condval.sroa.5.0.add.ptr55.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1028
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr55.1, align 16, !tbaa !30
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx.1, align 4, !tbaa !30
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx.1, align 8, !tbaa !30
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx.1, align 4, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.then47.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then47.1 ], [ 0, %if.end ]
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then47.1 ], [ 0, %if.end ]
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then47.1 ], [ 0, %if.end ]
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then47.1 ], [ 0, %if.end ]
  %cmp46.2 = icmp ult i32 %add43, 1256
  br i1 %cmp46.2, label %if.then47.2, label %if.end.2

if.then47.2:                                      ; preds = %if.end.1
  %10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %add.ptr55.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2048
  %condval.sroa.7.0.add.ptr55.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2060
  %condval.sroa.6.0.add.ptr55.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2056
  %condval.sroa.5.0.add.ptr55.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 2052
  %condval.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr55.2, align 16, !tbaa !30
  %condval.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx.2, align 4, !tbaa !30
  %condval.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx.2, align 8, !tbaa !30
  %condval.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx.2, align 4, !tbaa !30
  br label %if.end.2

if.end.2:                                         ; preds = %if.then47.2, %if.end.1
  %condval.sroa.0.0.2 = phi i32 [ %condval.sroa.0.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ]
  %condval.sroa.5.0.2 = phi i32 [ %condval.sroa.5.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ]
  %condval.sroa.6.0.2 = phi i32 [ %condval.sroa.6.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ]
  %condval.sroa.7.0.2 = phi i32 [ %condval.sroa.7.0.copyload.2, %if.then47.2 ], [ 0, %if.end.1 ]
  %cmp46.3 = icmp ult i32 %add43, 1252
  br i1 %cmp46.3, label %if.then47.3, label %if.end.3

if.then47.3:                                      ; preds = %if.end.2
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %add.ptr55.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3072
  %condval.sroa.7.0.add.ptr55.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3084
  %condval.sroa.6.0.add.ptr55.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3080
  %condval.sroa.5.0.add.ptr55.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 3076
  %condval.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr55.3, align 16, !tbaa !30
  %condval.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr55.sroa_idx.3, align 4, !tbaa !30
  %condval.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr55.sroa_idx.3, align 8, !tbaa !30
  %condval.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr55.sroa_idx.3, align 4, !tbaa !30
  br label %if.end.3

if.end.3:                                         ; preds = %if.then47.3, %if.end.2
  %condval.sroa.0.0.3 = phi i32 [ %condval.sroa.0.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ]
  %condval.sroa.5.0.3 = phi i32 [ %condval.sroa.5.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ]
  %condval.sroa.6.0.3 = phi i32 [ %condval.sroa.6.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ]
  %condval.sroa.7.0.3 = phi i32 [ %condval.sroa.7.0.copyload.3, %if.then47.3 ], [ 0, %if.end.2 ]
  br i1 %cmp46, label %if.then94, label %if.end126

if.then94:                                        ; preds = %if.end.3
  %add.ptr102 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %condval_1.sroa.7.0.add.ptr102.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr102, i64 12
  %condval_1.sroa.6.0.add.ptr102.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr102, i64 8
  %condval_1.sroa.5.0.add.ptr102.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr102, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr102, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx, align 4, !tbaa !30
  br label %if.end126

if.end126:                                        ; preds = %if.end.3, %if.then94
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then94 ], [ 0, %if.end.3 ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then94 ], [ 0, %if.end.3 ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then94 ], [ 0, %if.end.3 ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then94 ], [ 0, %if.end.3 ]
  br i1 %cmp46.1, label %if.then94.1, label %if.end126.1

if.then94.1:                                      ; preds = %if.end126
  %12 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %add.ptr102.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1024
  %condval_1.sroa.7.0.add.ptr102.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1036
  %condval_1.sroa.6.0.add.ptr102.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1032
  %condval_1.sroa.5.0.add.ptr102.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 1028
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr102.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx.1, align 4, !tbaa !30
  br label %if.end126.1

if.end126.1:                                      ; preds = %if.then94.1, %if.end126
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then94.1 ], [ 0, %if.end126 ]
  br i1 %cmp46.2, label %if.then94.2, label %if.end126.2

if.then94.2:                                      ; preds = %if.end126.1
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %add.ptr102.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2048
  %condval_1.sroa.7.0.add.ptr102.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2060
  %condval_1.sroa.6.0.add.ptr102.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2056
  %condval_1.sroa.5.0.add.ptr102.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2052
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr102.2, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx.2, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx.2, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx.2, align 4, !tbaa !30
  br label %if.end126.2

if.end126.2:                                      ; preds = %if.then94.2, %if.end126.1
  %condval_1.sroa.0.0.2 = phi i32 [ %condval_1.sroa.0.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ]
  %condval_1.sroa.5.0.2 = phi i32 [ %condval_1.sroa.5.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ]
  %condval_1.sroa.6.0.2 = phi i32 [ %condval_1.sroa.6.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ]
  %condval_1.sroa.7.0.2 = phi i32 [ %condval_1.sroa.7.0.copyload.2, %if.then94.2 ], [ 0, %if.end126.1 ]
  br i1 %cmp46.3, label %if.then94.3, label %if.end126.3

if.then94.3:                                      ; preds = %if.end126.2
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %add.ptr102.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3072
  %condval_1.sroa.7.0.add.ptr102.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3084
  %condval_1.sroa.6.0.add.ptr102.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3080
  %condval_1.sroa.5.0.add.ptr102.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 3076
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr102.3, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr102.sroa_idx.3, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr102.sroa_idx.3, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr102.sroa_idx.3, align 4, !tbaa !30
  br label %if.end126.3

if.end126.3:                                      ; preds = %if.then94.3, %if.end126.2
  %condval_1.sroa.0.0.3 = phi i32 [ %condval_1.sroa.0.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ]
  %condval_1.sroa.5.0.3 = phi i32 [ %condval_1.sroa.5.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ]
  %condval_1.sroa.6.0.3 = phi i32 [ %condval_1.sroa.6.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ]
  %condval_1.sroa.7.0.3 = phi i32 [ %condval_1.sroa.7.0.copyload.3, %if.then94.3 ], [ 0, %if.end126.2 ]
  %mul146 = and i32 %mul52, 8064
  %and149 = and i32 %1, 15
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul146
  %xor = xor i32 %shr42, %and149
  %add.ptr157.idx = shl nuw nsw i32 %xor, 4
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr157.idx
  store i32 %condval.sroa.0.0, ptr addrspace(3) %add.ptr157, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 4
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr157.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr157.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 12
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr157.sroa_idx, align 4, !tbaa !30
  %add153.1 = add nuw nsw i32 %shr42, 4
  %xor.1 = xor i32 %add153.1, %and149
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr157.idx.1
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %add.ptr157.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 4
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr157.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr157.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 12
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr157.1.sroa_idx, align 4, !tbaa !30
  %add153.2 = add nuw nsw i32 %shr42, 8
  %xor.2 = xor i32 %add153.2, %and149
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr157.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr157.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr157.idx.2
  store i32 %condval.sroa.0.0.2, ptr addrspace(3) %add.ptr157.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr157.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 4
  store i32 %condval.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr157.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr157.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 8
  store i32 %condval.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr157.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr157.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 12
  store i32 %condval.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr157.2.sroa_idx, align 4, !tbaa !30
  %add153.3 = add nuw nsw i32 %shr42, 12
  %xor.3 = xor i32 %add153.3, %and149
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr157.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr157.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr157.idx.3
  store i32 %condval.sroa.0.0.3, ptr addrspace(3) %add.ptr157.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr157.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 4
  store i32 %condval.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr157.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr157.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 8
  store i32 %condval.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr157.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr157.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 12
  store i32 %condval.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr157.3.sroa_idx, align 4, !tbaa !30
  %add162 = or disjoint i32 %mul17, 15
  %cmp163 = icmp slt i32 %0, %add162
  br i1 %cmp163, label %for.cond165.preheader, label %if.end191

for.cond165.preheader:                            ; preds = %if.end126.3
  %15 = lshr i32 %1, 2
  %mul172 = and i32 %15, 252
  %add173 = add nuw nsw i32 %mul17, %mul172
  %cmp176.not = icmp sgt i32 %add173, %0
  %spec.select = select i1 %cmp176.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert638 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp176.not.1.not = icmp slt i32 %add173, %0
  %spec.select.1 = select i1 %cmp176.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert651 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert638, float %spec.select.1, i64 1
  %add174.2 = or disjoint i32 %add173, 2
  %cmp176.not.2 = icmp sgt i32 %add174.2, %0
  %spec.select.2 = select i1 %cmp176.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert664 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert651, float %spec.select.2, i64 2
  %add174.3 = or disjoint i32 %add173, 3
  %cmp176.not.3 = icmp sgt i32 %add174.3, %0
  %spec.select.3 = select i1 %cmp176.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert677 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert664, float %spec.select.3, i64 3
  br label %if.end191

if.end191:                                        ; preds = %if.end126.3, %for.cond165.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert677, %for.cond165.preheader ], [ zeroinitializer, %if.end126.3 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul7
  %add.ptr210 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr210, align 16
  %kb.sroa.10.0.add.ptr210.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210, i32 8
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.sroa_idx, align 8
  %17 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !84
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %17), !call_argsrelate !84
  %add.ptr210.1 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx.1
  %kb.sroa.0.0.copyload626 = load <4 x half>, ptr addrspace(3) %add.ptr210.1, align 16
  %kb.sroa.10.0.add.ptr210.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210.1, i32 8
  %kb.sroa.10.0.copyload629 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.1.sroa_idx, align 8
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload626, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %18), !call_argsrelate !84
  %20 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload629, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %19), !call_argsrelate !84
  %add.ptr210.2 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx.2
  %kb.sroa.0.0.copyload627 = load <4 x half>, ptr addrspace(3) %add.ptr210.2, align 16
  %kb.sroa.10.0.add.ptr210.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210.2, i32 8
  %kb.sroa.10.0.copyload630 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.2.sroa_idx, align 8
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload627, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %20), !call_argsrelate !84
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload630, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %21), !call_argsrelate !84
  %add.ptr210.3 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr157.idx.3
  %kb.sroa.0.0.copyload628 = load <4 x half>, ptr addrspace(3) %add.ptr210.3, align 16
  %kb.sroa.10.0.add.ptr210.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr210.3, i32 8
  %kb.sroa.10.0.copyload631 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr210.3.sroa_idx, align 8
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload628, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %22), !call_argsrelate !84
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload631, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %23), !call_argsrelate !84
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr248.idx = shl nuw nsw i32 %1, 4
  %invariant.gep572 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr248.idx
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep572, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep572.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep572.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep572.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep572.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep572.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep572.sroa_idx, align 4, !tbaa !30
  %gep573.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep573.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep573.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep573.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep573.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep573.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep573.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep573.1.sroa_idx, align 4, !tbaa !30
  %gep573.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2048
  store i32 %condval_1.sroa.0.0.2, ptr addrspace(3) %gep573.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep573.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2052
  store i32 %condval_1.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep573.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep573.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2056
  store i32 %condval_1.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep573.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep573.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 2060
  store i32 %condval_1.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep573.2.sroa_idx, align 4, !tbaa !30
  %gep573.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3072
  store i32 %condval_1.sroa.0.0.3, ptr addrspace(3) %gep573.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep573.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3076
  store i32 %condval_1.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep573.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep573.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3080
  store i32 %condval_1.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep573.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep573.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep572, i32 3084
  store i32 %condval_1.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep573.3.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract640 = extractelement <4 x float> %24, i64 0
  %mul258 = fmul contract float %acc_s.sroa.0.0.vec.extract640, 0x3FC2776C60000000
  %25 = tail call contract noundef float @llvm.minnum.f32(float %mul258, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %25, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %25, %cond.i.i
  %26 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %26
  %acc_s.sroa.0.4.vec.extract653 = extractelement <4 x float> %24, i64 1
  %mul258.1 = fmul contract float %acc_s.sroa.0.4.vec.extract653, 0x3FC2776C60000000
  %27 = tail call contract noundef float @llvm.minnum.f32(float %mul258.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %27, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %27, %cond.i.i.1
  %28 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %28
  %acc_s.sroa.0.8.vec.extract666 = extractelement <4 x float> %24, i64 2
  %mul258.2 = fmul contract float %acc_s.sroa.0.8.vec.extract666, 0x3FC2776C60000000
  %29 = tail call contract noundef float @llvm.minnum.f32(float %mul258.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %29, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %29, %cond.i.i.2
  %30 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %30
  %acc_s.sroa.0.12.vec.extract679 = extractelement <4 x float> %24, i64 3
  %mul258.3 = fmul contract float %acc_s.sroa.0.12.vec.extract679, 0x3FC2776C60000000
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul258.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %31, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %31, %cond.i.i.3
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %32
  %add274 = fadd contract float %mul.i.i, 0.000000e+00
  %add274.1 = fadd contract float %add274, %mul.i.i.1
  %add274.2 = fadd contract float %add274.1, %mul.i.i.2
  %add274.3 = fadd contract float %add274.2, %mul.i.i.3
  %33 = bitcast float %add274.3 to i32
  %34 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %35 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %34) #10
  %xor.i.i = xor i32 %35, 32
  %36 = and i32 %35, -64
  %and.i.i = add nsw i32 %36, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i528 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %35
  %shl.i.i = shl i32 %cond.i.i528, 2
  %37 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %33)
  %38 = bitcast i32 %37 to float
  %add282 = fadd contract float %add274.3, %38
  %39 = bitcast float %add282 to i32
  %40 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %41 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %40) #10
  %xor.i.i529 = xor i32 %41, 16
  %42 = and i32 %41, -64
  %and.i.i530 = add nsw i32 %42, 64
  %cmp.not.i.i531 = icmp slt i32 %xor.i.i529, %and.i.i530
  %cond.i.i532 = select i1 %cmp.not.i.i531, i32 %xor.i.i529, i32 %41
  %shl.i.i533 = shl i32 %cond.i.i532, 2
  %43 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i533, i32 %39)
  %44 = bitcast i32 %43 to float
  %add287 = fadd contract float %add282, %44
  %cmp290 = fcmp contract ogt float %add287, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add287
  %condval_3.0 = select i1 %cmp290, float %div, float 0.000000e+00
  %mul303 = fmul contract float %condval_3.0, %mul.i.i
  %mul303.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul303.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul303.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %45 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !145
  %46 = fptrunc float %mul303 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %45), !noalias !145
  %47 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !145
  %48 = fptrunc float %mul303.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %47), !noalias !145
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %46, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %48, i64 1
  %49 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !159
  %50 = fptrunc float %mul303.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %49), !noalias !159
  %51 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !159
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %51), !noalias !159
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %50, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %52 = shl nuw nsw i32 %1, 5
  %mul333 = and i32 %52, 32256
  %add340 = or disjoint i32 %mul333, %and149
  %arrayidx342 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340
  %53 = load half, ptr addrspace(3) %arrayidx342, align 2, !tbaa !176
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %53, i64 0
  %add335.1 = or disjoint i32 %mul333, %and149
  %add340.1 = or disjoint i32 %add335.1, 128
  %arrayidx342.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1
  %54 = load half, ptr addrspace(3) %arrayidx342.1, align 2, !tbaa !176
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %54, i64 1
  %add335.2 = or disjoint i32 %mul333, %and149
  %add340.2 = or disjoint i32 %add335.2, 256
  %arrayidx342.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2
  %55 = load half, ptr addrspace(3) %arrayidx342.2, align 2, !tbaa !176
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %55, i64 2
  %add335.3 = or disjoint i32 %mul333, %and149
  %add340.3 = or disjoint i32 %add335.3, 384
  %arrayidx342.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3
  %56 = load half, ptr addrspace(3) %arrayidx342.3, align 2, !tbaa !176
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %56, i64 3
  %add337.1599 = or disjoint i32 %mul333, %and149
  %add340.1600 = or disjoint i32 %add337.1599, 16
  %arrayidx342.1601 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1600
  %57 = load half, ptr addrspace(3) %arrayidx342.1601, align 2, !tbaa !176
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %57, i64 0
  %add337.1.1 = or disjoint i32 %mul333, %and149
  %add340.1.1 = or disjoint i32 %add337.1.1, 144
  %arrayidx342.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.1
  %58 = load half, ptr addrspace(3) %arrayidx342.1.1, align 2, !tbaa !176
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %58, i64 1
  %add337.2.1 = or disjoint i32 %mul333, %and149
  %add340.2.1 = or disjoint i32 %add337.2.1, 272
  %arrayidx342.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.1
  %59 = load half, ptr addrspace(3) %arrayidx342.2.1, align 2, !tbaa !176
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %59, i64 2
  %add337.3.1 = or disjoint i32 %mul333, %and149
  %add340.3.1 = or disjoint i32 %add337.3.1, 400
  %arrayidx342.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.1
  %60 = load half, ptr addrspace(3) %arrayidx342.3.1, align 2, !tbaa !176
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %60, i64 3
  %add337.2603 = or disjoint i32 %mul333, %and149
  %add340.2604 = or disjoint i32 %add337.2603, 32
  %arrayidx342.2605 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2604
  %61 = load half, ptr addrspace(3) %arrayidx342.2605, align 2, !tbaa !176
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %61, i64 0
  %add337.1.2 = or disjoint i32 %mul333, %and149
  %add340.1.2 = or disjoint i32 %add337.1.2, 160
  %arrayidx342.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.2
  %62 = load half, ptr addrspace(3) %arrayidx342.1.2, align 2, !tbaa !176
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %62, i64 1
  %add337.2.2 = or disjoint i32 %mul333, %and149
  %add340.2.2 = or disjoint i32 %add337.2.2, 288
  %arrayidx342.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.2
  %63 = load half, ptr addrspace(3) %arrayidx342.2.2, align 2, !tbaa !176
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %63, i64 2
  %add337.3.2 = or disjoint i32 %mul333, %and149
  %add340.3.2 = or disjoint i32 %add337.3.2, 416
  %arrayidx342.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.2
  %64 = load half, ptr addrspace(3) %arrayidx342.3.2, align 2, !tbaa !176
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %64, i64 3
  %add337.3607 = or disjoint i32 %mul333, %and149
  %add340.3608 = or disjoint i32 %add337.3607, 48
  %arrayidx342.3609 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3608
  %65 = load half, ptr addrspace(3) %arrayidx342.3609, align 2, !tbaa !176
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %65, i64 0
  %add337.1.3 = or disjoint i32 %mul333, %and149
  %add340.1.3 = or disjoint i32 %add337.1.3, 176
  %arrayidx342.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.3
  %66 = load half, ptr addrspace(3) %arrayidx342.1.3, align 2, !tbaa !176
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %66, i64 1
  %add337.2.3 = or disjoint i32 %mul333, %and149
  %add340.2.3 = or disjoint i32 %add337.2.3, 304
  %arrayidx342.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.3
  %67 = load half, ptr addrspace(3) %arrayidx342.2.3, align 2, !tbaa !176
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %67, i64 2
  %add337.3.3 = or disjoint i32 %mul333, %and149
  %add340.3.3 = or disjoint i32 %add337.3.3, 432
  %arrayidx342.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.3
  %68 = load half, ptr addrspace(3) %arrayidx342.3.3, align 2, !tbaa !176
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %68, i64 3
  %add337.4 = or disjoint i32 %mul333, %and149
  %add340.4 = or disjoint i32 %add337.4, 64
  %arrayidx342.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.4
  %69 = load half, ptr addrspace(3) %arrayidx342.4, align 2, !tbaa !176
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %69, i64 0
  %add337.1.4 = or disjoint i32 %mul333, %and149
  %add340.1.4 = or disjoint i32 %add337.1.4, 192
  %arrayidx342.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.4
  %70 = load half, ptr addrspace(3) %arrayidx342.1.4, align 2, !tbaa !176
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %70, i64 1
  %add337.2.4 = or disjoint i32 %mul333, %and149
  %add340.2.4 = or disjoint i32 %add337.2.4, 320
  %arrayidx342.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.4
  %71 = load half, ptr addrspace(3) %arrayidx342.2.4, align 2, !tbaa !176
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %71, i64 2
  %add337.3.4 = or disjoint i32 %mul333, %and149
  %add340.3.4 = or disjoint i32 %add337.3.4, 448
  %arrayidx342.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.4
  %72 = load half, ptr addrspace(3) %arrayidx342.3.4, align 2, !tbaa !176
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %72, i64 3
  %add337.5 = or disjoint i32 %mul333, %and149
  %add340.5 = or disjoint i32 %add337.5, 80
  %arrayidx342.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.5
  %73 = load half, ptr addrspace(3) %arrayidx342.5, align 2, !tbaa !176
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %73, i64 0
  %add337.1.5 = or disjoint i32 %mul333, %and149
  %add340.1.5 = or disjoint i32 %add337.1.5, 208
  %arrayidx342.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.5
  %74 = load half, ptr addrspace(3) %arrayidx342.1.5, align 2, !tbaa !176
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %74, i64 1
  %add337.2.5 = or disjoint i32 %mul333, %and149
  %add340.2.5 = or disjoint i32 %add337.2.5, 336
  %arrayidx342.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.5
  %75 = load half, ptr addrspace(3) %arrayidx342.2.5, align 2, !tbaa !176
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %75, i64 2
  %add337.3.5 = or disjoint i32 %mul333, %and149
  %add340.3.5 = or disjoint i32 %add337.3.5, 464
  %arrayidx342.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.5
  %76 = load half, ptr addrspace(3) %arrayidx342.3.5, align 2, !tbaa !176
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %76, i64 3
  %add337.6 = or disjoint i32 %mul333, %and149
  %add340.6 = or disjoint i32 %add337.6, 96
  %arrayidx342.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.6
  %77 = load half, ptr addrspace(3) %arrayidx342.6, align 2, !tbaa !176
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %77, i64 0
  %add337.1.6 = or disjoint i32 %mul333, %and149
  %add340.1.6 = or disjoint i32 %add337.1.6, 224
  %arrayidx342.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.6
  %78 = load half, ptr addrspace(3) %arrayidx342.1.6, align 2, !tbaa !176
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %78, i64 1
  %add337.2.6 = or disjoint i32 %mul333, %and149
  %add340.2.6 = or disjoint i32 %add337.2.6, 352
  %arrayidx342.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.6
  %79 = load half, ptr addrspace(3) %arrayidx342.2.6, align 2, !tbaa !176
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %79, i64 2
  %add337.3.6 = or disjoint i32 %52, %and149
  %add340.3.6 = or i32 %add337.3.6, 480
  %arrayidx342.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.6
  %80 = load half, ptr addrspace(3) %arrayidx342.3.6, align 2, !tbaa !176
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %80, i64 3
  %add337.7 = or disjoint i32 %mul333, %and149
  %add340.7 = or disjoint i32 %add337.7, 112
  %arrayidx342.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.7
  %81 = load half, ptr addrspace(3) %arrayidx342.7, align 2, !tbaa !176
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %81, i64 0
  %add337.1.7 = or disjoint i32 %mul333, %and149
  %add340.1.7 = or disjoint i32 %add337.1.7, 240
  %arrayidx342.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.1.7
  %82 = load half, ptr addrspace(3) %arrayidx342.1.7, align 2, !tbaa !176
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %82, i64 1
  %add337.2.7 = or disjoint i32 %mul333, %and149
  %add340.2.7 = or disjoint i32 %add337.2.7, 368
  %arrayidx342.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.2.7
  %83 = load half, ptr addrspace(3) %arrayidx342.2.7, align 2, !tbaa !176
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %83, i64 2
  %add337.3.7 = or disjoint i32 %52, %and149
  %add340.3.7 = or i32 %add337.3.7, 496
  %arrayidx342.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add340.3.7
  %84 = load half, ptr addrspace(3) %arrayidx342.3.7, align 2, !tbaa !176
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %84, i64 3
  %85 = fptrunc float %mul303.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %85, i64 3
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end371

if.end371:                                        ; preds = %if.end191, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %86, %if.end191 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %87, %if.end191 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %88, %if.end191 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %89, %if.end191 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %90, %if.end191 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.52.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %91, %if.end191 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.62.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %92, %if.end191 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %93, %if.end191 ], [ zeroinitializer, %entry ]
  %94 = lshr i32 %1, 2
  %mul404 = and i32 %94, 252
  %add401 = add nuw nsw i32 %add, %mul404
  %95 = zext nneg i32 %add401 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %96 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %97 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %96), !noalias !184
  %98 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %99 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %98), !noalias !184
  %100 = bitcast half %97 to i16
  %101 = bitcast half %99 to i16
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %103 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !noalias !199
  %104 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %105 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %104), !noalias !199
  %106 = bitcast half %103 to i16
  %107 = bitcast half %105 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %107 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %106 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %101 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %100 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr407 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr407, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %109 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !noalias !184
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %111 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !noalias !184
  %112 = bitcast half %109 to i16
  %113 = bitcast half %111 to i16
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %115 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !noalias !199
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %117 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !noalias !199
  %118 = bitcast half %115 to i16
  %119 = bitcast half %117 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %119 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %118 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %113 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %112 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %120 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  %add.ptr407.1 = getelementptr inbounds i8, ptr addrspace(1) %120, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr407.1, align 8
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %121 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %122 = fptrunc float %acc_o.sroa.22.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %121), !noalias !184
  %123 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %124 = fptrunc float %acc_o.sroa.22.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %123), !noalias !184
  %125 = bitcast half %122 to i16
  %126 = bitcast half %124 to i16
  %127 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %128 = fptrunc float %acc_o.sroa.22.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %127), !noalias !199
  %129 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %130 = fptrunc float %acc_o.sroa.22.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %129), !noalias !199
  %131 = bitcast half %128 to i16
  %132 = bitcast half %130 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %132 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %131 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %126 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %125 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  %add.ptr407.2 = getelementptr inbounds i8, ptr addrspace(1) %133, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr407.2, align 8
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %134 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %135 = fptrunc float %acc_o.sroa.32.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %134), !noalias !184
  %136 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %137 = fptrunc float %acc_o.sroa.32.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %136), !noalias !184
  %138 = bitcast half %135 to i16
  %139 = bitcast half %137 to i16
  %140 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %141 = fptrunc float %acc_o.sroa.32.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %140), !noalias !199
  %142 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %143 = fptrunc float %acc_o.sroa.32.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %142), !noalias !199
  %144 = bitcast half %141 to i16
  %145 = bitcast half %143 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %145 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %144 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %139 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %138 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  %add.ptr407.3 = getelementptr inbounds i8, ptr addrspace(1) %146, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr407.3, align 8
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3
  %147 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %148 = fptrunc float %acc_o.sroa.42.64.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %147), !noalias !184
  %149 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %150 = fptrunc float %acc_o.sroa.42.68.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %149), !noalias !184
  %151 = bitcast half %148 to i16
  %152 = bitcast half %150 to i16
  %153 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %154 = fptrunc float %acc_o.sroa.42.72.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %153), !noalias !199
  %155 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %156 = fptrunc float %acc_o.sroa.42.76.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %155), !noalias !199
  %157 = bitcast half %154 to i16
  %158 = bitcast half %156 to i16
  %__2.sroa.6.0.insert.ext.4 = zext i16 %158 to i64
  %__2.sroa.6.0.insert.shift.4 = shl nuw i64 %__2.sroa.6.0.insert.ext.4, 48
  %__2.sroa.5.0.insert.ext.4 = zext i16 %157 to i64
  %__2.sroa.5.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.4, 32
  %__2.sroa.5.0.insert.insert.4 = or disjoint i64 %__2.sroa.6.0.insert.shift.4, %__2.sroa.5.0.insert.shift.4
  %__2.sroa.4.0.insert.ext.4 = zext i16 %152 to i64
  %__2.sroa.4.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.4, 16
  %__2.sroa.4.0.insert.insert.4 = or disjoint i64 %__2.sroa.5.0.insert.insert.4, %__2.sroa.4.0.insert.shift.4
  %__2.sroa.0.0.insert.ext.4 = zext i16 %151 to i64
  %__2.sroa.0.0.insert.insert.4 = or disjoint i64 %__2.sroa.4.0.insert.insert.4, %__2.sroa.0.0.insert.ext.4
  %159 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  %add.ptr407.4 = getelementptr inbounds i8, ptr addrspace(1) %159, i64 128
  store i64 %__2.sroa.0.0.insert.insert.4, ptr addrspace(1) %add.ptr407.4, align 8
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3
  %160 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %161 = fptrunc float %acc_o.sroa.52.80.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %160), !noalias !184
  %162 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %163 = fptrunc float %acc_o.sroa.52.84.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %162), !noalias !184
  %164 = bitcast half %161 to i16
  %165 = bitcast half %163 to i16
  %166 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %167 = fptrunc float %acc_o.sroa.52.88.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %166), !noalias !199
  %168 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %169 = fptrunc float %acc_o.sroa.52.92.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %168), !noalias !199
  %170 = bitcast half %167 to i16
  %171 = bitcast half %169 to i16
  %__2.sroa.6.0.insert.ext.5 = zext i16 %171 to i64
  %__2.sroa.6.0.insert.shift.5 = shl nuw i64 %__2.sroa.6.0.insert.ext.5, 48
  %__2.sroa.5.0.insert.ext.5 = zext i16 %170 to i64
  %__2.sroa.5.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.5, 32
  %__2.sroa.5.0.insert.insert.5 = or disjoint i64 %__2.sroa.6.0.insert.shift.5, %__2.sroa.5.0.insert.shift.5
  %__2.sroa.4.0.insert.ext.5 = zext i16 %165 to i64
  %__2.sroa.4.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.5, 16
  %__2.sroa.4.0.insert.insert.5 = or disjoint i64 %__2.sroa.5.0.insert.insert.5, %__2.sroa.4.0.insert.shift.5
  %__2.sroa.0.0.insert.ext.5 = zext i16 %164 to i64
  %__2.sroa.0.0.insert.insert.5 = or disjoint i64 %__2.sroa.4.0.insert.insert.5, %__2.sroa.0.0.insert.ext.5
  %172 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  %add.ptr407.5 = getelementptr inbounds i8, ptr addrspace(1) %172, i64 160
  store i64 %__2.sroa.0.0.insert.insert.5, ptr addrspace(1) %add.ptr407.5, align 8
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3
  %173 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %174 = fptrunc float %acc_o.sroa.62.96.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %173), !noalias !184
  %175 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %176 = fptrunc float %acc_o.sroa.62.100.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %175), !noalias !184
  %177 = bitcast half %174 to i16
  %178 = bitcast half %176 to i16
  %179 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %180 = fptrunc float %acc_o.sroa.62.104.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %179), !noalias !199
  %181 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %182 = fptrunc float %acc_o.sroa.62.108.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %181), !noalias !199
  %183 = bitcast half %180 to i16
  %184 = bitcast half %182 to i16
  %__2.sroa.6.0.insert.ext.6 = zext i16 %184 to i64
  %__2.sroa.6.0.insert.shift.6 = shl nuw i64 %__2.sroa.6.0.insert.ext.6, 48
  %__2.sroa.5.0.insert.ext.6 = zext i16 %183 to i64
  %__2.sroa.5.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.6, 32
  %__2.sroa.5.0.insert.insert.6 = or disjoint i64 %__2.sroa.6.0.insert.shift.6, %__2.sroa.5.0.insert.shift.6
  %__2.sroa.4.0.insert.ext.6 = zext i16 %178 to i64
  %__2.sroa.4.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.6, 16
  %__2.sroa.4.0.insert.insert.6 = or disjoint i64 %__2.sroa.5.0.insert.insert.6, %__2.sroa.4.0.insert.shift.6
  %__2.sroa.0.0.insert.ext.6 = zext i16 %177 to i64
  %__2.sroa.0.0.insert.insert.6 = or disjoint i64 %__2.sroa.4.0.insert.insert.6, %__2.sroa.0.0.insert.ext.6
  %185 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  %add.ptr407.6 = getelementptr inbounds i8, ptr addrspace(1) %185, i64 192
  store i64 %__2.sroa.0.0.insert.insert.6, ptr addrspace(1) %add.ptr407.6, align 8
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %186 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %187 = fptrunc float %acc_o.sroa.72.112.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %186), !noalias !184
  %188 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !184
  %189 = fptrunc float %acc_o.sroa.72.116.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %188), !noalias !184
  %190 = bitcast half %187 to i16
  %191 = bitcast half %189 to i16
  %192 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %193 = fptrunc float %acc_o.sroa.72.120.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %192), !noalias !199
  %194 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !199
  %195 = fptrunc float %acc_o.sroa.72.124.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %194), !noalias !199
  %196 = bitcast half %193 to i16
  %197 = bitcast half %195 to i16
  %__2.sroa.6.0.insert.ext.7 = zext i16 %197 to i64
  %__2.sroa.6.0.insert.shift.7 = shl nuw i64 %__2.sroa.6.0.insert.ext.7, 48
  %__2.sroa.5.0.insert.ext.7 = zext i16 %196 to i64
  %__2.sroa.5.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.7, 32
  %__2.sroa.5.0.insert.insert.7 = or disjoint i64 %__2.sroa.6.0.insert.shift.7, %__2.sroa.5.0.insert.shift.7
  %__2.sroa.4.0.insert.ext.7 = zext i16 %191 to i64
  %__2.sroa.4.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.7, 16
  %__2.sroa.4.0.insert.insert.7 = or disjoint i64 %__2.sroa.5.0.insert.insert.7, %__2.sroa.4.0.insert.shift.7
  %__2.sroa.0.0.insert.ext.7 = zext i16 %190 to i64
  %__2.sroa.0.0.insert.insert.7 = or disjoint i64 %__2.sroa.4.0.insert.insert.7, %__2.sroa.0.0.insert.ext.7
  %198 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %95
  %add.ptr407.7 = getelementptr inbounds i8, ptr addrspace(1) %198, i64 224
  store i64 %__2.sroa.0.0.insert.insert.7, ptr addrspace(1) %add.ptr407.7, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #7

declare float @llvm.exp2.f32(float) #8

declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

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


