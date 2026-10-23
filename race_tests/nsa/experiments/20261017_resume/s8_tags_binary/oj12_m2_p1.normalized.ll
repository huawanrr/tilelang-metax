target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %EncodedIndices.coerce, ptr addrspace(4) noalias noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %add = add nuw nsw i32 %mul, %1
  %idxprom = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i64, ptr addrspace(1) %EncodedIndices.coerce, i64 %idxprom
  %2 = load i64, ptr addrspace(1) %arrayidx, align 8, !tbaa !17
  %3 = trunc i64 %2 to i32
  %conv8 = and i32 %3, 255
  %and13 = shl i32 %3, 4
  %mul14 = and i32 %and13, 1008
  %shr.1 = lshr i64 %2, 8
  %4 = trunc i64 %shr.1 to i32
  %conv8.1 = and i32 %4, 255
  %and13.1 = shl i32 %4, 4
  %mul14.1 = and i32 %and13.1, 1008
  %shr.2 = lshr i64 %2, 16
  %5 = trunc i64 %shr.2 to i32
  %conv8.2 = and i32 %5, 255
  %and13.2 = shl i32 %5, 4
  %mul14.2 = and i32 %and13.2, 1008
  %shr.3 = lshr i64 %2, 24
  %6 = trunc i64 %shr.3 to i32
  %conv8.3 = and i32 %6, 255
  %and13.3 = shl i32 %6, 4
  %mul14.3 = and i32 %and13.3, 1008
  %shr.4 = lshr i64 %2, 32
  %7 = trunc nuw i64 %shr.4 to i32
  %conv8.4 = and i32 %7, 255
  %and13.4 = shl i32 %7, 4
  %mul14.4 = and i32 %and13.4, 1008
  %shr.5 = lshr i64 %2, 40
  %8 = trunc nuw nsw i64 %shr.5 to i32
  %conv8.5 = and i32 %8, 255
  %and13.5 = shl nuw nsw i32 %8, 4
  %mul14.5 = and i32 %and13.5, 1008
  %shr.6 = lshr i64 %2, 48
  %9 = trunc nuw nsw i64 %shr.6 to i32
  %conv8.6 = and i32 %9, 255
  %and13.6 = shl nuw nsw i32 %9, 4
  %mul14.6 = and i32 %and13.6, 1008
  %shr.7 = lshr i64 %2, 56
  %10 = trunc nuw nsw i64 %shr.7 to i32
  %and13.7 = shl nuw nsw i32 %10, 4
  %mul14.7 = and i32 %and13.7, 1008
  %mul23 = shl nsw i32 %0, 20
  %mul25 = shl nsw i32 %1, 10
  %add26 = add nuw nsw i32 %mul23, %mul25
  %11 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %and28 = shl nuw nsw i32 %11, 6
  %mul29 = and i32 %and28, 960
  %add30 = or disjoint i32 %add26, %mul29
  %12 = lshr i32 %11, 1
  %mul35 = and i32 %12, 504
  %add32 = add nuw nsw i32 %add30, %mul35
  %13 = zext nneg i32 %add32 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %13
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %13
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %14, i64 64
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %14, i64 72
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8
  %conv107 = zext nneg i32 %0 to i64
  %15 = shl nuw nsw i32 %11, 3
  %mul118 = zext nneg i32 %15 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul118
  %invariant.gep1654 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul118
  %16 = lshr i32 %11, 2
  %mul403 = and i32 %16, 252
  %cmp98.not = icmp eq i32 %conv8, 0
  br i1 %cmp98.not, label %if.end148, label %for.cond99.preheader

for.cond99.preheader:                             ; preds = %entry
  %17 = lshr exact i32 %mul14, 4
  %shr110 = zext nneg i32 %17 to i64
  %.idx = shl nuw nsw i64 %shr110, 11
  %18 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx
  %.idx1721 = shl nuw nsw i64 %conv107, 17
  %19 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 %.idx1721
  %condval.sroa.6.0.add.ptr120.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %19, i64 8
  %20 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx, align 8, !tbaa !30
  %21 = load <4 x half>, ptr addrspace(4) %19, align 16, !tbaa !30
  %.idx.1 = shl nuw nsw i64 %shr110, 11
  %22 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1
  %.idx1721.1 = shl nuw nsw i64 %conv107, 17
  %23 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 %.idx1721.1
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1024
  %condval.sroa.6.0.add.ptr120.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1032
  %24 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx.1, align 8, !tbaa !30
  %25 = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !tbaa !30
  br label %if.end148

if.end148:                                        ; preds = %for.cond99.preheader, %entry
  %26 = phi <4 x half> [ undef, %entry ], [ %24, %for.cond99.preheader ]
  %27 = phi <4 x half> [ undef, %entry ], [ %25, %for.cond99.preheader ]
  %28 = phi <4 x half> [ undef, %entry ], [ %20, %for.cond99.preheader ]
  %29 = phi <4 x half> [ undef, %entry ], [ %21, %for.cond99.preheader ]
  %cmp153.not = icmp eq i32 %conv8.1, 0
  br i1 %cmp153.not, label %if.end209, label %for.cond155.preheader

for.cond155.preheader:                            ; preds = %if.end148
  %30 = lshr exact i32 %mul14.1, 4
  %shr167 = zext nneg i32 %30 to i64
  %.idx1722 = shl nuw nsw i64 %shr167, 11
  %31 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722
  %.idx1723 = shl nuw nsw i64 %conv107, 17
  %32 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 %.idx1723
  %condval_1.sroa.6.0.add.ptr177.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %32, i64 8
  %33 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx, align 8, !tbaa !30
  %34 = load <4 x half>, ptr addrspace(4) %32, align 16, !tbaa !30
  %.idx1722.1 = shl nuw nsw i64 %shr167, 11
  %35 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722.1
  %.idx1723.1 = shl nuw nsw i64 %conv107, 17
  %36 = getelementptr inbounds i8, ptr addrspace(4) %35, i64 %.idx1723.1
  %gep1646.1 = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1024
  %condval_1.sroa.6.0.add.ptr177.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1032
  %37 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx.1, align 8, !tbaa !30
  %38 = load <4 x half>, ptr addrspace(4) %gep1646.1, align 16, !tbaa !30
  br label %if.end209

if.end209:                                        ; preds = %for.cond155.preheader, %if.end148
  %39 = phi <4 x half> [ undef, %if.end148 ], [ %37, %for.cond155.preheader ]
  %40 = phi <4 x half> [ undef, %if.end148 ], [ %38, %for.cond155.preheader ]
  %41 = phi <4 x half> [ undef, %if.end148 ], [ %33, %for.cond155.preheader ]
  %42 = phi <4 x half> [ undef, %if.end148 ], [ %34, %for.cond155.preheader ]
  %cmp214.not = icmp eq i32 %conv8.2, 0
  br i1 %cmp214.not, label %if.end270, label %for.cond216.preheader

for.cond216.preheader:                            ; preds = %if.end209
  %43 = lshr exact i32 %mul14.2, 4
  %shr228 = zext nneg i32 %43 to i64
  %.idx1724 = shl nuw nsw i64 %shr228, 11
  %44 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724
  %.idx1725 = shl nuw nsw i64 %conv107, 17
  %45 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 %.idx1725
  %condval_2.sroa.6.0.add.ptr238.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %45, i64 8
  %46 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx, align 8, !tbaa !30
  %47 = load <4 x half>, ptr addrspace(4) %45, align 16, !tbaa !30
  %.idx1724.1 = shl nuw nsw i64 %shr228, 11
  %48 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724.1
  %.idx1725.1 = shl nuw nsw i64 %conv107, 17
  %49 = getelementptr inbounds i8, ptr addrspace(4) %48, i64 %.idx1725.1
  %gep1649.1 = getelementptr inbounds i8, ptr addrspace(4) %49, i64 1024
  %condval_2.sroa.6.0.add.ptr238.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %49, i64 1032
  %50 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx.1, align 8, !tbaa !30
  %51 = load <4 x half>, ptr addrspace(4) %gep1649.1, align 16, !tbaa !30
  br label %if.end270

if.end270:                                        ; preds = %for.cond216.preheader, %if.end209
  %52 = phi <4 x half> [ undef, %if.end209 ], [ %50, %for.cond216.preheader ]
  %53 = phi <4 x half> [ undef, %if.end209 ], [ %51, %for.cond216.preheader ]
  %54 = phi <4 x half> [ undef, %if.end209 ], [ %46, %for.cond216.preheader ]
  %55 = phi <4 x half> [ undef, %if.end209 ], [ %47, %for.cond216.preheader ]
  %cmp275.not = icmp eq i32 %conv8.3, 0
  br i1 %cmp275.not, label %if.end331, label %for.cond277.preheader

for.cond277.preheader:                            ; preds = %if.end270
  %56 = lshr exact i32 %mul14.3, 4
  %shr289 = zext nneg i32 %56 to i64
  %.idx1726 = shl nuw nsw i64 %shr289, 11
  %57 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726
  %.idx1727 = shl nuw nsw i64 %conv107, 17
  %58 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 %.idx1727
  %condval_3.sroa.6.0.add.ptr299.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %58, i64 8
  %59 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx, align 8, !tbaa !30
  %60 = load <4 x half>, ptr addrspace(4) %58, align 16, !tbaa !30
  %.idx1726.1 = shl nuw nsw i64 %shr289, 11
  %61 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726.1
  %.idx1727.1 = shl nuw nsw i64 %conv107, 17
  %62 = getelementptr inbounds i8, ptr addrspace(4) %61, i64 %.idx1727.1
  %gep1652.1 = getelementptr inbounds i8, ptr addrspace(4) %62, i64 1024
  %condval_3.sroa.6.0.add.ptr299.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %62, i64 1032
  %63 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx.1, align 8, !tbaa !30
  %64 = load <4 x half>, ptr addrspace(4) %gep1652.1, align 16, !tbaa !30
  br label %if.end331

if.end331:                                        ; preds = %for.cond277.preheader, %if.end270
  %65 = phi <4 x half> [ undef, %if.end270 ], [ %63, %for.cond277.preheader ]
  %66 = phi <4 x half> [ undef, %if.end270 ], [ %64, %for.cond277.preheader ]
  %67 = phi <4 x half> [ undef, %if.end270 ], [ %59, %for.cond277.preheader ]
  %68 = phi <4 x half> [ undef, %if.end270 ], [ %60, %for.cond277.preheader ]
  br i1 %cmp98.not, label %if.end508, label %for.cond337.preheader

for.cond337.preheader:                            ; preds = %if.end331
  %69 = lshr exact i32 %mul14, 4
  %shr349 = zext nneg i32 %69 to i64
  %.idx1728 = shl nuw nsw i64 %shr349, 11
  %70 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728
  %.idx1729 = shl nuw nsw i64 %conv107, 17
  %71 = getelementptr inbounds i8, ptr addrspace(4) %70, i64 %.idx1729
  %condval_4.sroa.6.0.add.ptr359.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %71, i64 8
  %72 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx, align 8, !tbaa !30
  %73 = load <4 x half>, ptr addrspace(4) %71, align 16, !tbaa !30
  %.idx1728.1 = shl nuw nsw i64 %shr349, 11
  %74 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728.1
  %.idx1729.1 = shl nuw nsw i64 %conv107, 17
  %75 = getelementptr inbounds i8, ptr addrspace(4) %74, i64 %.idx1729.1
  %gep1655.1 = getelementptr inbounds i8, ptr addrspace(4) %75, i64 1024
  %condval_4.sroa.6.0.add.ptr359.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %75, i64 1032
  %76 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx.1, align 8, !tbaa !30
  %77 = load <4 x half>, ptr addrspace(4) %gep1655.1, align 16, !tbaa !30
  %and394 = and i32 %3, 64
  %cmp395.not = icmp eq i32 %and394, 0
  br i1 %cmp395.not, label %if.end421, label %for.cond397.preheader

for.cond397.preheader:                            ; preds = %for.cond337.preheader
  %add404 = add nuw nsw i32 %mul14, %mul403
  %cmp407.not = icmp ugt i32 %add404, %1
  %fneg. = select i1 %cmp407.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2037 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp407.not.1.not = icmp ult i32 %add404, %1
  %fneg..1 = select i1 %cmp407.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2138 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2037, float %fneg..1, i64 1
  %add405.2 = or disjoint i32 %add404, 2
  %cmp407.not.2 = icmp ugt i32 %add405.2, %1
  %fneg..2 = select i1 %cmp407.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2231 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2138, float %fneg..2, i64 2
  %add405.3 = or disjoint i32 %add404, 3
  %cmp407.not.3 = icmp ugt i32 %add405.3, %1
  %fneg..3 = select i1 %cmp407.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2324 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2231, float %fneg..3, i64 3
  br label %if.end421

if.end421:                                        ; preds = %for.cond337.preheader, %for.cond397.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2324, %for.cond397.preheader ], [ zeroinitializer, %for.cond337.preheader ]
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !86
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %78), !call_argsrelate !86
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %79), !call_argsrelate !86
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %80), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %81, i64 0
  %mul456 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul456, float 0x4024CB5EC0000000)
  %83 = tail call contract noundef float @llvm.exp.f32(float %82)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %81, i64 1
  %mul456.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul456.1, float 0x4024CB5EC0000000)
  %85 = tail call contract noundef float @llvm.exp.f32(float %84)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %81, i64 2
  %mul456.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul456.2, float 0x4024CB5EC0000000)
  %87 = tail call contract noundef float @llvm.exp.f32(float %86)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %81, i64 3
  %mul456.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul456.3, float 0x4024CB5EC0000000)
  %89 = tail call contract noundef float @llvm.exp.f32(float %88)
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83)
  %91 = insertelement <4 x i16> poison, i16 %90, i64 0
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %85)
  %93 = insertelement <4 x i16> %91, i16 %92, i64 1
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %87)
  %95 = insertelement <4 x i16> %93, i16 %94, i64 2
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %89)
  %97 = insertelement <4 x i16> %95, i16 %96, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %97 to <4 x half>
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !107
  br label %if.end508

if.end508:                                        ; preds = %if.end421, %if.end331
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %101, %if.end421 ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %100, %if.end421 ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %99, %if.end421 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %98, %if.end421 ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end331 ], [ %89, %if.end421 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end331 ], [ %87, %if.end421 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end331 ], [ %85, %if.end421 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end331 ], [ %83, %if.end421 ]
  br i1 %cmp153.not, label %if.end687, label %for.cond515.preheader

for.cond515.preheader:                            ; preds = %if.end508
  %102 = lshr exact i32 %mul14.1, 4
  %shr527 = zext nneg i32 %102 to i64
  %.idx1730 = shl nuw nsw i64 %shr527, 11
  %103 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730
  %.idx1731 = shl nuw nsw i64 %conv107, 17
  %104 = getelementptr inbounds i8, ptr addrspace(4) %103, i64 %.idx1731
  %condval_6.sroa.6.0.add.ptr537.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 8
  %105 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx, align 8, !tbaa !30
  %106 = load <4 x half>, ptr addrspace(4) %104, align 16, !tbaa !30
  %.idx1730.1 = shl nuw nsw i64 %shr527, 11
  %107 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730.1
  %.idx1731.1 = shl nuw nsw i64 %conv107, 17
  %108 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 %.idx1731.1
  %gep1668.1 = getelementptr inbounds i8, ptr addrspace(4) %108, i64 1024
  %condval_6.sroa.6.0.add.ptr537.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %108, i64 1032
  %109 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx.1, align 8, !tbaa !30
  %110 = load <4 x half>, ptr addrspace(4) %gep1668.1, align 16, !tbaa !30
  %and573 = and i32 %4, 64
  %cmp574.not = icmp eq i32 %and573, 0
  br i1 %cmp574.not, label %if.end600, label %for.cond576.preheader

for.cond576.preheader:                            ; preds = %for.cond515.preheader
  %add583 = add nuw nsw i32 %mul14.1, %mul403
  %cmp586.not = icmp ugt i32 %add583, %1
  %fneg.1447 = select i1 %cmp586.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2046 = insertelement <4 x float> poison, float %fneg.1447, i64 0
  %cmp586.not.1.not = icmp ult i32 %add583, %1
  %fneg.1447.1 = select i1 %cmp586.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2147 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2046, float %fneg.1447.1, i64 1
  %add584.2 = or disjoint i32 %add583, 2
  %cmp586.not.2 = icmp ugt i32 %add584.2, %1
  %fneg.1447.2 = select i1 %cmp586.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2240 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2147, float %fneg.1447.2, i64 2
  %add584.3 = or disjoint i32 %add583, 3
  %cmp586.not.3 = icmp ugt i32 %add584.3, %1
  %fneg.1447.3 = select i1 %cmp586.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2333 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2240, float %fneg.1447.3, i64 3
  br label %if.end600

if.end600:                                        ; preds = %for.cond515.preheader, %for.cond576.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2333, %for.cond576.preheader ], [ zeroinitializer, %for.cond515.preheader ]
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !86
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %41, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %111), !call_argsrelate !86
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %40, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %112), !call_argsrelate !86
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %39, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %113), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2048 = extractelement <4 x float> %114, i64 0
  %mul635 = fmul contract float %acc_s.sroa.0.0.vec.extract2048, 0x3FB99999A0000000
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul635, float 0x4024CB5EC0000000)
  %116 = tail call contract noundef float @llvm.exp.f32(float %115)
  %acc_s.sroa.0.4.vec.extract2149 = extractelement <4 x float> %114, i64 1
  %mul635.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2149, 0x3FB99999A0000000
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul635.1, float 0x4024CB5EC0000000)
  %118 = tail call contract noundef float @llvm.exp.f32(float %117)
  %acc_s.sroa.0.8.vec.extract2242 = extractelement <4 x float> %114, i64 2
  %mul635.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2242, 0x3FB99999A0000000
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul635.2, float 0x4024CB5EC0000000)
  %120 = tail call contract noundef float @llvm.exp.f32(float %119)
  %acc_s.sroa.0.12.vec.extract2335 = extractelement <4 x float> %114, i64 3
  %mul635.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2335, 0x3FB99999A0000000
  %121 = tail call contract noundef float @llvm.minnum.f32(float %mul635.3, float 0x4024CB5EC0000000)
  %122 = tail call contract noundef float @llvm.exp.f32(float %121)
  %add651 = fadd contract float %sum_acc.sroa.0.0, %116
  %add651.1 = fadd contract float %sum_acc.sroa.20.0, %118
  %add651.2 = fadd contract float %sum_acc.sroa.38.0, %120
  %add651.3 = fadd contract float %sum_acc.sroa.56.0, %122
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116)
  %124 = insertelement <4 x i16> poison, i16 %123, i64 0
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118)
  %126 = insertelement <4 x i16> %124, i16 %125, i64 1
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120)
  %128 = insertelement <4 x i16> %126, i16 %127, i64 2
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %122)
  %130 = insertelement <4 x i16> %128, i16 %129, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2009 = bitcast <4 x i16> %130 to <4 x half>
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %106, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !call_argsrelate !107
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %105, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !call_argsrelate !107
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %110, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !call_argsrelate !107
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %109, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2009, <4 x float> zeroinitializer), !call_argsrelate !107
  br label %if.end687

if.end687:                                        ; preds = %if.end600, %if.end508
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %134, %if.end600 ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %133, %if.end600 ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %132, %if.end600 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end508 ], [ %131, %if.end600 ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end508 ], [ %add651.3, %if.end600 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end508 ], [ %add651.2, %if.end600 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end508 ], [ %add651.1, %if.end600 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end508 ], [ %add651, %if.end600 ]
  br i1 %cmp214.not, label %if.end866, label %for.cond694.preheader

for.cond694.preheader:                            ; preds = %if.end687
  %135 = lshr exact i32 %mul14.2, 4
  %shr706 = zext nneg i32 %135 to i64
  %.idx1732 = shl nuw nsw i64 %shr706, 11
  %136 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732
  %.idx1733 = shl nuw nsw i64 %conv107, 17
  %137 = getelementptr inbounds i8, ptr addrspace(4) %136, i64 %.idx1733
  %condval_8.sroa.6.0.add.ptr716.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 8
  %138 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx, align 8, !tbaa !30
  %139 = load <4 x half>, ptr addrspace(4) %137, align 16, !tbaa !30
  %.idx1732.1 = shl nuw nsw i64 %shr706, 11
  %140 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732.1
  %.idx1733.1 = shl nuw nsw i64 %conv107, 17
  %141 = getelementptr inbounds i8, ptr addrspace(4) %140, i64 %.idx1733.1
  %gep1682.1 = getelementptr inbounds i8, ptr addrspace(4) %141, i64 1024
  %condval_8.sroa.6.0.add.ptr716.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %141, i64 1032
  %142 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx.1, align 8, !tbaa !30
  %143 = load <4 x half>, ptr addrspace(4) %gep1682.1, align 16, !tbaa !30
  %and752 = and i32 %5, 64
  %cmp753.not = icmp eq i32 %and752, 0
  br i1 %cmp753.not, label %if.end779, label %for.cond755.preheader

for.cond755.preheader:                            ; preds = %for.cond694.preheader
  %add762 = add nuw nsw i32 %mul14.2, %mul403
  %cmp765.not = icmp ugt i32 %add762, %1
  %fneg.1448 = select i1 %cmp765.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2056 = insertelement <4 x float> poison, float %fneg.1448, i64 0
  %cmp765.not.1.not = icmp ult i32 %add762, %1
  %fneg.1448.1 = select i1 %cmp765.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2157 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2056, float %fneg.1448.1, i64 1
  %add763.2 = or disjoint i32 %add762, 2
  %cmp765.not.2 = icmp ugt i32 %add763.2, %1
  %fneg.1448.2 = select i1 %cmp765.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2250 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2157, float %fneg.1448.2, i64 2
  %add763.3 = or disjoint i32 %add762, 3
  %cmp765.not.3 = icmp ugt i32 %add763.3, %1
  %fneg.1448.3 = select i1 %cmp765.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2343 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2250, float %fneg.1448.3, i64 3
  br label %if.end779

if.end779:                                        ; preds = %for.cond694.preheader, %for.cond755.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2343, %for.cond755.preheader ], [ zeroinitializer, %for.cond694.preheader ]
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !86
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %144), !call_argsrelate !86
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %53, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %145), !call_argsrelate !86
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %52, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %146), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2058 = extractelement <4 x float> %147, i64 0
  %mul814 = fmul contract float %acc_s.sroa.0.0.vec.extract2058, 0x3FB99999A0000000
  %148 = tail call contract noundef float @llvm.minnum.f32(float %mul814, float 0x4024CB5EC0000000)
  %149 = tail call contract noundef float @llvm.exp.f32(float %148)
  %acc_s.sroa.0.4.vec.extract2159 = extractelement <4 x float> %147, i64 1
  %mul814.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2159, 0x3FB99999A0000000
  %150 = tail call contract noundef float @llvm.minnum.f32(float %mul814.1, float 0x4024CB5EC0000000)
  %151 = tail call contract noundef float @llvm.exp.f32(float %150)
  %acc_s.sroa.0.8.vec.extract2252 = extractelement <4 x float> %147, i64 2
  %mul814.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2252, 0x3FB99999A0000000
  %152 = tail call contract noundef float @llvm.minnum.f32(float %mul814.2, float 0x4024CB5EC0000000)
  %153 = tail call contract noundef float @llvm.exp.f32(float %152)
  %acc_s.sroa.0.12.vec.extract2345 = extractelement <4 x float> %147, i64 3
  %mul814.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2345, 0x3FB99999A0000000
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul814.3, float 0x4024CB5EC0000000)
  %155 = tail call contract noundef float @llvm.exp.f32(float %154)
  %add830 = fadd contract float %sum_acc.sroa.0.1, %149
  %add830.1 = fadd contract float %sum_acc.sroa.20.1, %151
  %add830.2 = fadd contract float %sum_acc.sroa.38.1, %153
  %add830.3 = fadd contract float %sum_acc.sroa.56.1, %155
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %149)
  %157 = insertelement <4 x i16> poison, i16 %156, i64 0
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %151)
  %159 = insertelement <4 x i16> %157, i16 %158, i64 1
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %153)
  %161 = insertelement <4 x i16> %159, i16 %160, i64 2
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155)
  %163 = insertelement <4 x i16> %161, i16 %162, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2011 = bitcast <4 x i16> %163 to <4 x half>
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %139, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !107
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %138, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.34.0), !call_argsrelate !107
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %143, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.66.0), !call_argsrelate !107
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %142, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2011, <4 x float> %acc_o.sroa.98.0), !call_argsrelate !107
  br label %if.end866

if.end866:                                        ; preds = %if.end779, %if.end687
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end687 ], [ %167, %if.end779 ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end687 ], [ %166, %if.end779 ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end687 ], [ %165, %if.end779 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end687 ], [ %164, %if.end779 ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end687 ], [ %add830.3, %if.end779 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end687 ], [ %add830.2, %if.end779 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end687 ], [ %add830.1, %if.end779 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end687 ], [ %add830, %if.end779 ]
  br i1 %cmp275.not, label %if.end1045, label %for.cond873.preheader

for.cond873.preheader:                            ; preds = %if.end866
  %168 = lshr exact i32 %mul14.3, 4
  %shr885 = zext nneg i32 %168 to i64
  %.idx1734 = shl nuw nsw i64 %shr885, 11
  %169 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734
  %.idx1735 = shl nuw nsw i64 %conv107, 17
  %170 = getelementptr inbounds i8, ptr addrspace(4) %169, i64 %.idx1735
  %condval_10.sroa.6.0.add.ptr895.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %170, i64 8
  %171 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx, align 8, !tbaa !30
  %172 = load <4 x half>, ptr addrspace(4) %170, align 16, !tbaa !30
  %.idx1734.1 = shl nuw nsw i64 %shr885, 11
  %173 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734.1
  %.idx1735.1 = shl nuw nsw i64 %conv107, 17
  %174 = getelementptr inbounds i8, ptr addrspace(4) %173, i64 %.idx1735.1
  %gep1696.1 = getelementptr inbounds i8, ptr addrspace(4) %174, i64 1024
  %condval_10.sroa.6.0.add.ptr895.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %174, i64 1032
  %175 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx.1, align 8, !tbaa !30
  %176 = load <4 x half>, ptr addrspace(4) %gep1696.1, align 16, !tbaa !30
  %and931 = and i32 %6, 64
  %cmp932.not = icmp eq i32 %and931, 0
  br i1 %cmp932.not, label %if.end958, label %for.cond934.preheader

for.cond934.preheader:                            ; preds = %for.cond873.preheader
  %add941 = add nuw nsw i32 %mul14.3, %mul403
  %cmp944.not = icmp ugt i32 %add941, %1
  %fneg.1449 = select i1 %cmp944.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2066 = insertelement <4 x float> poison, float %fneg.1449, i64 0
  %cmp944.not.1.not = icmp ult i32 %add941, %1
  %fneg.1449.1 = select i1 %cmp944.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2167 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2066, float %fneg.1449.1, i64 1
  %add942.2 = or disjoint i32 %add941, 2
  %cmp944.not.2 = icmp ugt i32 %add942.2, %1
  %fneg.1449.2 = select i1 %cmp944.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2260 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2167, float %fneg.1449.2, i64 2
  %add942.3 = or disjoint i32 %add941, 3
  %cmp944.not.3 = icmp ugt i32 %add942.3, %1
  %fneg.1449.3 = select i1 %cmp944.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2353 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2260, float %fneg.1449.3, i64 3
  br label %if.end958

if.end958:                                        ; preds = %for.cond873.preheader, %for.cond934.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2353, %for.cond934.preheader ], [ zeroinitializer, %for.cond873.preheader ]
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !86
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %177), !call_argsrelate !86
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %178), !call_argsrelate !86
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %65, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %179), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2068 = extractelement <4 x float> %180, i64 0
  %mul993 = fmul contract float %acc_s.sroa.0.0.vec.extract2068, 0x3FB99999A0000000
  %181 = tail call contract noundef float @llvm.minnum.f32(float %mul993, float 0x4024CB5EC0000000)
  %182 = tail call contract noundef float @llvm.exp.f32(float %181)
  %acc_s.sroa.0.4.vec.extract2169 = extractelement <4 x float> %180, i64 1
  %mul993.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2169, 0x3FB99999A0000000
  %183 = tail call contract noundef float @llvm.minnum.f32(float %mul993.1, float 0x4024CB5EC0000000)
  %184 = tail call contract noundef float @llvm.exp.f32(float %183)
  %acc_s.sroa.0.8.vec.extract2262 = extractelement <4 x float> %180, i64 2
  %mul993.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2262, 0x3FB99999A0000000
  %185 = tail call contract noundef float @llvm.minnum.f32(float %mul993.2, float 0x4024CB5EC0000000)
  %186 = tail call contract noundef float @llvm.exp.f32(float %185)
  %acc_s.sroa.0.12.vec.extract2355 = extractelement <4 x float> %180, i64 3
  %mul993.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2355, 0x3FB99999A0000000
  %187 = tail call contract noundef float @llvm.minnum.f32(float %mul993.3, float 0x4024CB5EC0000000)
  %188 = tail call contract noundef float @llvm.exp.f32(float %187)
  %add1009 = fadd contract float %sum_acc.sroa.0.2, %182
  %add1009.1 = fadd contract float %sum_acc.sroa.20.2, %184
  %add1009.2 = fadd contract float %sum_acc.sroa.38.2, %186
  %add1009.3 = fadd contract float %sum_acc.sroa.56.2, %188
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %182)
  %190 = insertelement <4 x i16> poison, i16 %189, i64 0
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %184)
  %192 = insertelement <4 x i16> %190, i16 %191, i64 1
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %186)
  %194 = insertelement <4 x i16> %192, i16 %193, i64 2
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %188)
  %196 = insertelement <4 x i16> %194, i16 %195, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2013 = bitcast <4 x i16> %196 to <4 x half>
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %172, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !107
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %171, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.18.0), !call_argsrelate !107
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %176, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.34.0), !call_argsrelate !107
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %175, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2013, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !107
  br label %if.end1045

if.end1045:                                       ; preds = %if.end958, %if.end866
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end866 ], [ %200, %if.end958 ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end866 ], [ %199, %if.end958 ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end866 ], [ %198, %if.end958 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end866 ], [ %197, %if.end958 ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end866 ], [ %add1009.3, %if.end958 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end866 ], [ %add1009.2, %if.end958 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end866 ], [ %add1009.1, %if.end958 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end866 ], [ %add1009, %if.end958 ]
  %cmp98.not.1 = icmp eq i32 %conv8.4, 0
  br i1 %cmp98.not.1, label %if.end148.1, label %for.cond99.preheader.1

for.cond99.preheader.1:                           ; preds = %if.end1045
  %201 = lshr exact i32 %mul14.4, 4
  %shr110.1 = zext nneg i32 %201 to i64
  %.idx.11770 = shl nuw nsw i64 %shr110.1, 11
  %202 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.11770
  %.idx1721.11771 = shl nuw nsw i64 %conv107, 17
  %203 = getelementptr inbounds i8, ptr addrspace(4) %202, i64 %.idx1721.11771
  %condval.sroa.6.0.add.ptr120.sroa_idx.11775 = getelementptr inbounds i8, ptr addrspace(4) %203, i64 8
  %204 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx.11775, align 8, !tbaa !30
  %205 = load <4 x half>, ptr addrspace(4) %203, align 16, !tbaa !30
  %.idx.1.1 = shl nuw nsw i64 %shr110.1, 11
  %206 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1.1
  %.idx1721.1.1 = shl nuw nsw i64 %conv107, 17
  %207 = getelementptr inbounds i8, ptr addrspace(4) %206, i64 %.idx1721.1.1
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %207, i64 1024
  %condval.sroa.6.0.add.ptr120.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %207, i64 1032
  %208 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr120.sroa_idx.1.1, align 8, !tbaa !30
  %209 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16, !tbaa !30
  br label %if.end148.1

if.end148.1:                                      ; preds = %for.cond99.preheader.1, %if.end1045
  %210 = phi <4 x half> [ %26, %if.end1045 ], [ %208, %for.cond99.preheader.1 ]
  %211 = phi <4 x half> [ %27, %if.end1045 ], [ %209, %for.cond99.preheader.1 ]
  %212 = phi <4 x half> [ %28, %if.end1045 ], [ %204, %for.cond99.preheader.1 ]
  %213 = phi <4 x half> [ %29, %if.end1045 ], [ %205, %for.cond99.preheader.1 ]
  %cmp153.not.1 = icmp eq i32 %conv8.5, 0
  br i1 %cmp153.not.1, label %if.end209.1, label %for.cond155.preheader.1

for.cond155.preheader.1:                          ; preds = %if.end148.1
  %214 = lshr exact i32 %mul14.5, 4
  %shr167.1 = zext nneg i32 %214 to i64
  %.idx1722.11789 = shl nuw nsw i64 %shr167.1, 11
  %215 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722.11789
  %.idx1723.11790 = shl nuw nsw i64 %conv107, 17
  %216 = getelementptr inbounds i8, ptr addrspace(4) %215, i64 %.idx1723.11790
  %condval_1.sroa.6.0.add.ptr177.sroa_idx.11794 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 8
  %217 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx.11794, align 8, !tbaa !30
  %218 = load <4 x half>, ptr addrspace(4) %216, align 16, !tbaa !30
  %.idx1722.1.1 = shl nuw nsw i64 %shr167.1, 11
  %219 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1722.1.1
  %.idx1723.1.1 = shl nuw nsw i64 %conv107, 17
  %220 = getelementptr inbounds i8, ptr addrspace(4) %219, i64 %.idx1723.1.1
  %gep1646.1.1 = getelementptr inbounds i8, ptr addrspace(4) %220, i64 1024
  %condval_1.sroa.6.0.add.ptr177.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %220, i64 1032
  %221 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr177.sroa_idx.1.1, align 8, !tbaa !30
  %222 = load <4 x half>, ptr addrspace(4) %gep1646.1.1, align 16, !tbaa !30
  br label %if.end209.1

if.end209.1:                                      ; preds = %for.cond155.preheader.1, %if.end148.1
  %223 = phi <4 x half> [ %39, %if.end148.1 ], [ %221, %for.cond155.preheader.1 ]
  %224 = phi <4 x half> [ %40, %if.end148.1 ], [ %222, %for.cond155.preheader.1 ]
  %225 = phi <4 x half> [ %41, %if.end148.1 ], [ %217, %for.cond155.preheader.1 ]
  %226 = phi <4 x half> [ %42, %if.end148.1 ], [ %218, %for.cond155.preheader.1 ]
  %cmp214.not.1 = icmp eq i32 %conv8.6, 0
  br i1 %cmp214.not.1, label %if.end270.1, label %for.cond216.preheader.1

for.cond216.preheader.1:                          ; preds = %if.end209.1
  %227 = lshr exact i32 %mul14.6, 4
  %shr228.1 = zext nneg i32 %227 to i64
  %.idx1724.11808 = shl nuw nsw i64 %shr228.1, 11
  %228 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724.11808
  %.idx1725.11809 = shl nuw nsw i64 %conv107, 17
  %229 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 %.idx1725.11809
  %condval_2.sroa.6.0.add.ptr238.sroa_idx.11813 = getelementptr inbounds i8, ptr addrspace(4) %229, i64 8
  %230 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx.11813, align 8, !tbaa !30
  %231 = load <4 x half>, ptr addrspace(4) %229, align 16, !tbaa !30
  %.idx1724.1.1 = shl nuw nsw i64 %shr228.1, 11
  %232 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1724.1.1
  %.idx1725.1.1 = shl nuw nsw i64 %conv107, 17
  %233 = getelementptr inbounds i8, ptr addrspace(4) %232, i64 %.idx1725.1.1
  %gep1649.1.1 = getelementptr inbounds i8, ptr addrspace(4) %233, i64 1024
  %condval_2.sroa.6.0.add.ptr238.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %233, i64 1032
  %234 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr238.sroa_idx.1.1, align 8, !tbaa !30
  %235 = load <4 x half>, ptr addrspace(4) %gep1649.1.1, align 16, !tbaa !30
  br label %if.end270.1

if.end270.1:                                      ; preds = %for.cond216.preheader.1, %if.end209.1
  %236 = phi <4 x half> [ %52, %if.end209.1 ], [ %234, %for.cond216.preheader.1 ]
  %237 = phi <4 x half> [ %53, %if.end209.1 ], [ %235, %for.cond216.preheader.1 ]
  %238 = phi <4 x half> [ %54, %if.end209.1 ], [ %230, %for.cond216.preheader.1 ]
  %239 = phi <4 x half> [ %55, %if.end209.1 ], [ %231, %for.cond216.preheader.1 ]
  %cmp275.not.1 = icmp ult i64 %2, 72057594037927936
  br i1 %cmp275.not.1, label %if.end331.1, label %for.cond277.preheader.1

for.cond277.preheader.1:                          ; preds = %if.end270.1
  %240 = lshr exact i32 %mul14.7, 4
  %shr289.1 = zext nneg i32 %240 to i64
  %.idx1726.11827 = shl nuw nsw i64 %shr289.1, 11
  %241 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726.11827
  %.idx1727.11828 = shl nuw nsw i64 %conv107, 17
  %242 = getelementptr inbounds i8, ptr addrspace(4) %241, i64 %.idx1727.11828
  %condval_3.sroa.6.0.add.ptr299.sroa_idx.11832 = getelementptr inbounds i8, ptr addrspace(4) %242, i64 8
  %243 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx.11832, align 8, !tbaa !30
  %244 = load <4 x half>, ptr addrspace(4) %242, align 16, !tbaa !30
  %.idx1726.1.1 = shl nuw nsw i64 %shr289.1, 11
  %245 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx1726.1.1
  %.idx1727.1.1 = shl nuw nsw i64 %conv107, 17
  %246 = getelementptr inbounds i8, ptr addrspace(4) %245, i64 %.idx1727.1.1
  %gep1652.1.1 = getelementptr inbounds i8, ptr addrspace(4) %246, i64 1024
  %condval_3.sroa.6.0.add.ptr299.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %246, i64 1032
  %247 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr299.sroa_idx.1.1, align 8, !tbaa !30
  %248 = load <4 x half>, ptr addrspace(4) %gep1652.1.1, align 16, !tbaa !30
  br label %if.end331.1

if.end331.1:                                      ; preds = %for.cond277.preheader.1, %if.end270.1
  %249 = phi <4 x half> [ %65, %if.end270.1 ], [ %247, %for.cond277.preheader.1 ]
  %250 = phi <4 x half> [ %66, %if.end270.1 ], [ %248, %for.cond277.preheader.1 ]
  %251 = phi <4 x half> [ %67, %if.end270.1 ], [ %243, %for.cond277.preheader.1 ]
  %252 = phi <4 x half> [ %68, %if.end270.1 ], [ %244, %for.cond277.preheader.1 ]
  br i1 %cmp98.not.1, label %if.end508.1, label %for.cond337.preheader.1

for.cond337.preheader.1:                          ; preds = %if.end331.1
  %253 = lshr exact i32 %mul14.4, 4
  %shr349.1 = zext nneg i32 %253 to i64
  %.idx1728.11846 = shl nuw nsw i64 %shr349.1, 11
  %254 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728.11846
  %.idx1729.11847 = shl nuw nsw i64 %conv107, 17
  %255 = getelementptr inbounds i8, ptr addrspace(4) %254, i64 %.idx1729.11847
  %condval_4.sroa.6.0.add.ptr359.sroa_idx.11851 = getelementptr inbounds i8, ptr addrspace(4) %255, i64 8
  %256 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx.11851, align 8, !tbaa !30
  %257 = load <4 x half>, ptr addrspace(4) %255, align 16, !tbaa !30
  %.idx1728.1.1 = shl nuw nsw i64 %shr349.1, 11
  %258 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1728.1.1
  %.idx1729.1.1 = shl nuw nsw i64 %conv107, 17
  %259 = getelementptr inbounds i8, ptr addrspace(4) %258, i64 %.idx1729.1.1
  %gep1655.1.1 = getelementptr inbounds i8, ptr addrspace(4) %259, i64 1024
  %condval_4.sroa.6.0.add.ptr359.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %259, i64 1032
  %260 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr359.sroa_idx.1.1, align 8, !tbaa !30
  %261 = load <4 x half>, ptr addrspace(4) %gep1655.1.1, align 16, !tbaa !30
  %and394.1 = and i32 %7, 64
  %cmp395.not.1 = icmp eq i32 %and394.1, 0
  br i1 %cmp395.not.1, label %if.end421.1, label %for.cond397.preheader.1

for.cond397.preheader.1:                          ; preds = %for.cond337.preheader.1
  %add404.1 = add nuw nsw i32 %mul14.4, %mul403
  %cmp407.not.11864 = icmp ugt i32 %add404.1, %1
  %fneg..11865 = select i1 %cmp407.not.11864, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2076 = insertelement <4 x float> poison, float %fneg..11865, i64 0
  %cmp407.not.1.1.not = icmp ult i32 %add404.1, %1
  %fneg..1.1 = select i1 %cmp407.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2177 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2076, float %fneg..1.1, i64 1
  %add405.2.1 = or disjoint i32 %add404.1, 2
  %cmp407.not.2.1 = icmp ugt i32 %add405.2.1, %1
  %fneg..2.1 = select i1 %cmp407.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2270 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2177, float %fneg..2.1, i64 2
  %add405.3.1 = or disjoint i32 %add404.1, 3
  %cmp407.not.3.1 = icmp ugt i32 %add405.3.1, %1
  %fneg..3.1 = select i1 %cmp407.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2363 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2270, float %fneg..3.1, i64 3
  br label %if.end421.1

if.end421.1:                                      ; preds = %for.cond337.preheader.1, %for.cond397.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2363, %for.cond397.preheader.1 ], [ zeroinitializer, %for.cond337.preheader.1 ]
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %213, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !86
  %263 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %212, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %262), !call_argsrelate !86
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %211, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %263), !call_argsrelate !86
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %210, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %264), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2080 = extractelement <4 x float> %265, i64 0
  %mul456.11869 = fmul contract float %acc_s.sroa.0.0.vec.extract2080, 0x3FB99999A0000000
  %266 = tail call contract noundef float @llvm.minnum.f32(float %mul456.11869, float 0x4024CB5EC0000000)
  %267 = tail call contract noundef float @llvm.exp.f32(float %266)
  %acc_s.sroa.0.4.vec.extract2179 = extractelement <4 x float> %265, i64 1
  %mul456.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2179, 0x3FB99999A0000000
  %268 = tail call contract noundef float @llvm.minnum.f32(float %mul456.1.1, float 0x4024CB5EC0000000)
  %269 = tail call contract noundef float @llvm.exp.f32(float %268)
  %acc_s.sroa.0.8.vec.extract2272 = extractelement <4 x float> %265, i64 2
  %mul456.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2272, 0x3FB99999A0000000
  %270 = tail call contract noundef float @llvm.minnum.f32(float %mul456.2.1, float 0x4024CB5EC0000000)
  %271 = tail call contract noundef float @llvm.exp.f32(float %270)
  %acc_s.sroa.0.12.vec.extract2365 = extractelement <4 x float> %265, i64 3
  %mul456.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2365, 0x3FB99999A0000000
  %272 = tail call contract noundef float @llvm.minnum.f32(float %mul456.3.1, float 0x4024CB5EC0000000)
  %273 = tail call contract noundef float @llvm.exp.f32(float %272)
  %add472.11870 = fadd contract float %sum_acc.sroa.0.3, %267
  %add472.1.1 = fadd contract float %sum_acc.sroa.20.3, %269
  %add472.2.1 = fadd contract float %sum_acc.sroa.38.3, %271
  %add472.3.1 = fadd contract float %sum_acc.sroa.56.3, %273
  %274 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %267)
  %275 = insertelement <4 x i16> poison, i16 %274, i64 0
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %269)
  %277 = insertelement <4 x i16> %275, i16 %276, i64 1
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %271)
  %279 = insertelement <4 x i16> %277, i16 %278, i64 2
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %273)
  %281 = insertelement <4 x i16> %279, i16 %280, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2015 = bitcast <4 x i16> %281 to <4 x half>
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %257, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.0.1), !call_argsrelate !107
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %256, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.34.1), !call_argsrelate !107
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %261, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.66.1), !call_argsrelate !107
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %260, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2015, <4 x float> %acc_o.sroa.98.1), !call_argsrelate !107
  br label %if.end508.1

if.end508.1:                                      ; preds = %if.end421.1, %if.end331.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end331.1 ], [ %285, %if.end421.1 ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end331.1 ], [ %284, %if.end421.1 ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end331.1 ], [ %283, %if.end421.1 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end331.1 ], [ %282, %if.end421.1 ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end331.1 ], [ %add472.3.1, %if.end421.1 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end331.1 ], [ %add472.2.1, %if.end421.1 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end331.1 ], [ %add472.1.1, %if.end421.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end331.1 ], [ %add472.11870, %if.end421.1 ]
  br i1 %cmp153.not.1, label %if.end687.1, label %for.cond515.preheader.1

for.cond515.preheader.1:                          ; preds = %if.end508.1
  %286 = lshr exact i32 %mul14.5, 4
  %shr527.1 = zext nneg i32 %286 to i64
  %.idx1730.11872 = shl nuw nsw i64 %shr527.1, 11
  %287 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730.11872
  %.idx1731.11873 = shl nuw nsw i64 %conv107, 17
  %288 = getelementptr inbounds i8, ptr addrspace(4) %287, i64 %.idx1731.11873
  %condval_6.sroa.6.0.add.ptr537.sroa_idx.11877 = getelementptr inbounds i8, ptr addrspace(4) %288, i64 8
  %289 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx.11877, align 8, !tbaa !30
  %290 = load <4 x half>, ptr addrspace(4) %288, align 16, !tbaa !30
  %.idx1730.1.1 = shl nuw nsw i64 %shr527.1, 11
  %291 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1730.1.1
  %.idx1731.1.1 = shl nuw nsw i64 %conv107, 17
  %292 = getelementptr inbounds i8, ptr addrspace(4) %291, i64 %.idx1731.1.1
  %gep1668.1.1 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 1024
  %condval_6.sroa.6.0.add.ptr537.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 1032
  %293 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr537.sroa_idx.1.1, align 8, !tbaa !30
  %294 = load <4 x half>, ptr addrspace(4) %gep1668.1.1, align 16, !tbaa !30
  %and573.1 = and i32 %8, 64
  %cmp574.not.1 = icmp eq i32 %and573.1, 0
  br i1 %cmp574.not.1, label %if.end600.1, label %for.cond576.preheader.1

for.cond576.preheader.1:                          ; preds = %for.cond515.preheader.1
  %add583.1 = add nuw nsw i32 %mul14.5, %mul403
  %cmp586.not.11890 = icmp ugt i32 %add583.1, %1
  %fneg.1447.11891 = select i1 %cmp586.not.11890, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2088 = insertelement <4 x float> poison, float %fneg.1447.11891, i64 0
  %cmp586.not.1.1.not = icmp ult i32 %add583.1, %1
  %fneg.1447.1.1 = select i1 %cmp586.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2187 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2088, float %fneg.1447.1.1, i64 1
  %add584.2.1 = or disjoint i32 %add583.1, 2
  %cmp586.not.2.1 = icmp ugt i32 %add584.2.1, %1
  %fneg.1447.2.1 = select i1 %cmp586.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2280 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2187, float %fneg.1447.2.1, i64 2
  %add584.3.1 = or disjoint i32 %add583.1, 3
  %cmp586.not.3.1 = icmp ugt i32 %add584.3.1, %1
  %fneg.1447.3.1 = select i1 %cmp586.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2373 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2280, float %fneg.1447.3.1, i64 3
  br label %if.end600.1

if.end600.1:                                      ; preds = %for.cond515.preheader.1, %for.cond576.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2373, %for.cond576.preheader.1 ], [ zeroinitializer, %for.cond515.preheader.1 ]
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %226, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !86
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %225, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %295), !call_argsrelate !86
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %296), !call_argsrelate !86
  %298 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %223, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %297), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2092 = extractelement <4 x float> %298, i64 0
  %mul635.11895 = fmul contract float %acc_s.sroa.0.0.vec.extract2092, 0x3FB99999A0000000
  %299 = tail call contract noundef float @llvm.minnum.f32(float %mul635.11895, float 0x4024CB5EC0000000)
  %300 = tail call contract noundef float @llvm.exp.f32(float %299)
  %acc_s.sroa.0.4.vec.extract2189 = extractelement <4 x float> %298, i64 1
  %mul635.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2189, 0x3FB99999A0000000
  %301 = tail call contract noundef float @llvm.minnum.f32(float %mul635.1.1, float 0x4024CB5EC0000000)
  %302 = tail call contract noundef float @llvm.exp.f32(float %301)
  %acc_s.sroa.0.8.vec.extract2282 = extractelement <4 x float> %298, i64 2
  %mul635.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2282, 0x3FB99999A0000000
  %303 = tail call contract noundef float @llvm.minnum.f32(float %mul635.2.1, float 0x4024CB5EC0000000)
  %304 = tail call contract noundef float @llvm.exp.f32(float %303)
  %acc_s.sroa.0.12.vec.extract2375 = extractelement <4 x float> %298, i64 3
  %mul635.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2375, 0x3FB99999A0000000
  %305 = tail call contract noundef float @llvm.minnum.f32(float %mul635.3.1, float 0x4024CB5EC0000000)
  %306 = tail call contract noundef float @llvm.exp.f32(float %305)
  %add651.11896 = fadd contract float %sum_acc.sroa.0.4, %300
  %add651.1.1 = fadd contract float %sum_acc.sroa.20.4, %302
  %add651.2.1 = fadd contract float %sum_acc.sroa.38.4, %304
  %add651.3.1 = fadd contract float %sum_acc.sroa.56.4, %306
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %300)
  %308 = insertelement <4 x i16> poison, i16 %307, i64 0
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %302)
  %310 = insertelement <4 x i16> %308, i16 %309, i64 1
  %311 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %304)
  %312 = insertelement <4 x i16> %310, i16 %311, i64 2
  %313 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %306)
  %314 = insertelement <4 x i16> %312, i16 %313, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2017 = bitcast <4 x i16> %314 to <4 x half>
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %290, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !107
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %289, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.18.1), !call_argsrelate !107
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %294, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.34.1), !call_argsrelate !107
  %318 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %293, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2017, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !107
  br label %if.end687.1

if.end687.1:                                      ; preds = %if.end600.1, %if.end508.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end508.1 ], [ %318, %if.end600.1 ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end508.1 ], [ %317, %if.end600.1 ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end508.1 ], [ %316, %if.end600.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end508.1 ], [ %315, %if.end600.1 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end508.1 ], [ %add651.3.1, %if.end600.1 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end508.1 ], [ %add651.2.1, %if.end600.1 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end508.1 ], [ %add651.1.1, %if.end600.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end508.1 ], [ %add651.11896, %if.end600.1 ]
  br i1 %cmp214.not.1, label %if.end866.1, label %for.cond694.preheader.1

for.cond694.preheader.1:                          ; preds = %if.end687.1
  %319 = lshr exact i32 %mul14.6, 4
  %shr706.1 = zext nneg i32 %319 to i64
  %.idx1732.11898 = shl nuw nsw i64 %shr706.1, 11
  %320 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732.11898
  %.idx1733.11899 = shl nuw nsw i64 %conv107, 17
  %321 = getelementptr inbounds i8, ptr addrspace(4) %320, i64 %.idx1733.11899
  %condval_8.sroa.6.0.add.ptr716.sroa_idx.11903 = getelementptr inbounds i8, ptr addrspace(4) %321, i64 8
  %322 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx.11903, align 8, !tbaa !30
  %323 = load <4 x half>, ptr addrspace(4) %321, align 16, !tbaa !30
  %.idx1732.1.1 = shl nuw nsw i64 %shr706.1, 11
  %324 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1732.1.1
  %.idx1733.1.1 = shl nuw nsw i64 %conv107, 17
  %325 = getelementptr inbounds i8, ptr addrspace(4) %324, i64 %.idx1733.1.1
  %gep1682.1.1 = getelementptr inbounds i8, ptr addrspace(4) %325, i64 1024
  %condval_8.sroa.6.0.add.ptr716.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %325, i64 1032
  %326 = load <4 x half>, ptr addrspace(4) %condval_8.sroa.6.0.add.ptr716.sroa_idx.1.1, align 8, !tbaa !30
  %327 = load <4 x half>, ptr addrspace(4) %gep1682.1.1, align 16, !tbaa !30
  %and752.1 = and i32 %9, 64
  %cmp753.not.1 = icmp eq i32 %and752.1, 0
  br i1 %cmp753.not.1, label %if.end779.1, label %for.cond755.preheader.1

for.cond755.preheader.1:                          ; preds = %for.cond694.preheader.1
  %add762.1 = add nuw nsw i32 %mul14.6, %mul403
  %cmp765.not.11916 = icmp ugt i32 %add762.1, %1
  %fneg.1448.11917 = select i1 %cmp765.not.11916, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2100 = insertelement <4 x float> poison, float %fneg.1448.11917, i64 0
  %cmp765.not.1.1.not = icmp ult i32 %add762.1, %1
  %fneg.1448.1.1 = select i1 %cmp765.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2197 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2100, float %fneg.1448.1.1, i64 1
  %add763.2.1 = or disjoint i32 %add762.1, 2
  %cmp765.not.2.1 = icmp ugt i32 %add763.2.1, %1
  %fneg.1448.2.1 = select i1 %cmp765.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2290 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2197, float %fneg.1448.2.1, i64 2
  %add763.3.1 = or disjoint i32 %add762.1, 3
  %cmp765.not.3.1 = icmp ugt i32 %add763.3.1, %1
  %fneg.1448.3.1 = select i1 %cmp765.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2383 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2290, float %fneg.1448.3.1, i64 3
  br label %if.end779.1

if.end779.1:                                      ; preds = %for.cond694.preheader.1, %for.cond755.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2383, %for.cond755.preheader.1 ], [ zeroinitializer, %for.cond694.preheader.1 ]
  %328 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %239, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !86
  %329 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %238, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %328), !call_argsrelate !86
  %330 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %237, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %329), !call_argsrelate !86
  %331 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %236, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %330), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2104 = extractelement <4 x float> %331, i64 0
  %mul814.11921 = fmul contract float %acc_s.sroa.0.0.vec.extract2104, 0x3FB99999A0000000
  %332 = tail call contract noundef float @llvm.minnum.f32(float %mul814.11921, float 0x4024CB5EC0000000)
  %333 = tail call contract noundef float @llvm.exp.f32(float %332)
  %acc_s.sroa.0.4.vec.extract2199 = extractelement <4 x float> %331, i64 1
  %mul814.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2199, 0x3FB99999A0000000
  %334 = tail call contract noundef float @llvm.minnum.f32(float %mul814.1.1, float 0x4024CB5EC0000000)
  %335 = tail call contract noundef float @llvm.exp.f32(float %334)
  %acc_s.sroa.0.8.vec.extract2292 = extractelement <4 x float> %331, i64 2
  %mul814.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2292, 0x3FB99999A0000000
  %336 = tail call contract noundef float @llvm.minnum.f32(float %mul814.2.1, float 0x4024CB5EC0000000)
  %337 = tail call contract noundef float @llvm.exp.f32(float %336)
  %acc_s.sroa.0.12.vec.extract2385 = extractelement <4 x float> %331, i64 3
  %mul814.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2385, 0x3FB99999A0000000
  %338 = tail call contract noundef float @llvm.minnum.f32(float %mul814.3.1, float 0x4024CB5EC0000000)
  %339 = tail call contract noundef float @llvm.exp.f32(float %338)
  %add830.11922 = fadd contract float %sum_acc.sroa.0.5, %333
  %add830.1.1 = fadd contract float %sum_acc.sroa.20.5, %335
  %add830.2.1 = fadd contract float %sum_acc.sroa.38.5, %337
  %add830.3.1 = fadd contract float %sum_acc.sroa.56.5, %339
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %333)
  %341 = insertelement <4 x i16> poison, i16 %340, i64 0
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %335)
  %343 = insertelement <4 x i16> %341, i16 %342, i64 1
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %337)
  %345 = insertelement <4 x i16> %343, i16 %344, i64 2
  %346 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %339)
  %347 = insertelement <4 x i16> %345, i16 %346, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2019 = bitcast <4 x i16> %347 to <4 x half>
  %348 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %323, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !107
  %349 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %322, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.34.2), !call_argsrelate !107
  %350 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %327, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.66.2), !call_argsrelate !107
  %351 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %326, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2019, <4 x float> %acc_o.sroa.98.2), !call_argsrelate !107
  br label %if.end866.1

if.end866.1:                                      ; preds = %if.end779.1, %if.end687.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end687.1 ], [ %351, %if.end779.1 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end687.1 ], [ %350, %if.end779.1 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end687.1 ], [ %349, %if.end779.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end687.1 ], [ %348, %if.end779.1 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end687.1 ], [ %add830.3.1, %if.end779.1 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end687.1 ], [ %add830.2.1, %if.end779.1 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end687.1 ], [ %add830.1.1, %if.end779.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end687.1 ], [ %add830.11922, %if.end779.1 ]
  br i1 %cmp275.not.1, label %if.end1045.1, label %for.cond873.preheader.1

for.cond873.preheader.1:                          ; preds = %if.end866.1
  %352 = lshr exact i32 %mul14.7, 4
  %shr885.1 = zext nneg i32 %352 to i64
  %.idx1734.11924 = shl nuw nsw i64 %shr885.1, 11
  %353 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734.11924
  %.idx1735.11925 = shl nuw nsw i64 %conv107, 17
  %354 = getelementptr inbounds i8, ptr addrspace(4) %353, i64 %.idx1735.11925
  %condval_10.sroa.6.0.add.ptr895.sroa_idx.11929 = getelementptr inbounds i8, ptr addrspace(4) %354, i64 8
  %355 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx.11929, align 8, !tbaa !30
  %356 = load <4 x half>, ptr addrspace(4) %354, align 16, !tbaa !30
  %.idx1734.1.1 = shl nuw nsw i64 %shr885.1, 11
  %357 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep1654, i64 %.idx1734.1.1
  %.idx1735.1.1 = shl nuw nsw i64 %conv107, 17
  %358 = getelementptr inbounds i8, ptr addrspace(4) %357, i64 %.idx1735.1.1
  %gep1696.1.1 = getelementptr inbounds i8, ptr addrspace(4) %358, i64 1024
  %condval_10.sroa.6.0.add.ptr895.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %358, i64 1032
  %359 = load <4 x half>, ptr addrspace(4) %condval_10.sroa.6.0.add.ptr895.sroa_idx.1.1, align 8, !tbaa !30
  %360 = load <4 x half>, ptr addrspace(4) %gep1696.1.1, align 16, !tbaa !30
  %and931.1 = and i32 %10, 64
  %cmp932.not.1 = icmp eq i32 %and931.1, 0
  br i1 %cmp932.not.1, label %if.end958.1, label %for.cond934.preheader.1

for.cond934.preheader.1:                          ; preds = %for.cond873.preheader.1
  %add941.1 = add nuw nsw i32 %mul14.7, %mul403
  %cmp944.not.11942 = icmp ugt i32 %add941.1, %1
  %fneg.1449.11943 = select i1 %cmp944.not.11942, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2112 = insertelement <4 x float> poison, float %fneg.1449.11943, i64 0
  %cmp944.not.1.1.not = icmp ult i32 %add941.1, %1
  %fneg.1449.1.1 = select i1 %cmp944.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2207 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2112, float %fneg.1449.1.1, i64 1
  %add942.2.1 = or disjoint i32 %add941.1, 2
  %cmp944.not.2.1 = icmp ugt i32 %add942.2.1, %1
  %fneg.1449.2.1 = select i1 %cmp944.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2300 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2207, float %fneg.1449.2.1, i64 2
  %add942.3.1 = or disjoint i32 %add941.1, 3
  %cmp944.not.3.1 = icmp ugt i32 %add942.3.1, %1
  %fneg.1449.3.1 = select i1 %cmp944.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2393 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2300, float %fneg.1449.3.1, i64 3
  br label %if.end958.1

if.end958.1:                                      ; preds = %for.cond873.preheader.1, %for.cond934.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2393, %for.cond934.preheader.1 ], [ zeroinitializer, %for.cond873.preheader.1 ]
  %361 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %252, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !86
  %362 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %251, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %361), !call_argsrelate !86
  %363 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %250, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %362), !call_argsrelate !86
  %364 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %249, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %363), !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract2116 = extractelement <4 x float> %364, i64 0
  %mul993.11947 = fmul contract float %acc_s.sroa.0.0.vec.extract2116, 0x3FB99999A0000000
  %365 = tail call contract noundef float @llvm.minnum.f32(float %mul993.11947, float 0x4024CB5EC0000000)
  %366 = tail call contract noundef float @llvm.exp.f32(float %365)
  %acc_s.sroa.0.4.vec.extract2209 = extractelement <4 x float> %364, i64 1
  %mul993.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2209, 0x3FB99999A0000000
  %367 = tail call contract noundef float @llvm.minnum.f32(float %mul993.1.1, float 0x4024CB5EC0000000)
  %368 = tail call contract noundef float @llvm.exp.f32(float %367)
  %acc_s.sroa.0.8.vec.extract2302 = extractelement <4 x float> %364, i64 2
  %mul993.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2302, 0x3FB99999A0000000
  %369 = tail call contract noundef float @llvm.minnum.f32(float %mul993.2.1, float 0x4024CB5EC0000000)
  %370 = tail call contract noundef float @llvm.exp.f32(float %369)
  %acc_s.sroa.0.12.vec.extract2395 = extractelement <4 x float> %364, i64 3
  %mul993.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract2395, 0x3FB99999A0000000
  %371 = tail call contract noundef float @llvm.minnum.f32(float %mul993.3.1, float 0x4024CB5EC0000000)
  %372 = tail call contract noundef float @llvm.exp.f32(float %371)
  %add1009.11948 = fadd contract float %sum_acc.sroa.0.6, %366
  %add1009.1.1 = fadd contract float %sum_acc.sroa.20.6, %368
  %add1009.2.1 = fadd contract float %sum_acc.sroa.38.6, %370
  %add1009.3.1 = fadd contract float %sum_acc.sroa.56.6, %372
  %373 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %366)
  %374 = insertelement <4 x i16> poison, i16 %373, i64 0
  %375 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %368)
  %376 = insertelement <4 x i16> %374, i16 %375, i64 1
  %377 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %370)
  %378 = insertelement <4 x i16> %376, i16 %377, i64 2
  %379 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %372)
  %380 = insertelement <4 x i16> %378, i16 %379, i64 3
  %acc_s_cast.sroa.0.6.vec.insert2021 = bitcast <4 x i16> %380 to <4 x half>
  %381 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %356, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !107
  %382 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %355, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.18.2), !call_argsrelate !107
  %383 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %360, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.34.2), !call_argsrelate !107
  %384 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %359, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2021, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !107
  br label %if.end1045.1

if.end1045.1:                                     ; preds = %if.end958.1, %if.end866.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end866.1 ], [ %384, %if.end958.1 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end866.1 ], [ %383, %if.end958.1 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end866.1 ], [ %382, %if.end958.1 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end866.1 ], [ %381, %if.end958.1 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end866.1 ], [ %add1009.3.1, %if.end958.1 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end866.1 ], [ %add1009.2.1, %if.end958.1 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end866.1 ], [ %add1009.1.1, %if.end958.1 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end866.1 ], [ %add1009.11948, %if.end958.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add1057 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add1057.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add1057.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add1057.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add1057.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add1057.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add1057.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add1057.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add1057.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add1057.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add1057.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add1057.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add1057.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add1057.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add1057.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add1057.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add1071 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add1071.1 = fadd contract float %add1071, %sum_acc.sroa.20.7
  %add1071.2 = fadd contract float %add1071.1, %sum_acc.sroa.38.7
  %add1071.3 = fadd contract float %add1071.2, %sum_acc.sroa.56.7
  %385 = bitcast float %add1071.3 to i32
  %386 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %387 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %386) #11
  %xor.i.i = xor i32 %387, 32
  %388 = and i32 %387, -64
  %and.i.i = add nsw i32 %388, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %387
  %shl.i.i = shl i32 %cond.i.i, 2
  %389 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %385)
  %390 = bitcast i32 %389 to float
  %add.i = fadd contract float %add1071.3, %390
  %391 = bitcast float %add.i to i32
  %392 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %393 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %392) #11
  %xor.i.i1610 = xor i32 %393, 16
  %394 = and i32 %393, -64
  %and.i.i1611 = add nsw i32 %394, 64
  %cmp.not.i.i1612 = icmp slt i32 %xor.i.i1610, %and.i.i1611
  %cond.i.i1613 = select i1 %cmp.not.i.i1612, i32 %xor.i.i1610, i32 %393
  %shl.i.i1614 = shl i32 %cond.i.i1613, 2
  %395 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1614, i32 %391)
  %396 = bitcast i32 %395 to float
  %add.i.i = fadd contract float %add.i, %396
  %cmp1080 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_12.0 = select i1 %cmp1080, float %div, float 0.000000e+00
  %mul1093 = fmul contract float %condval_12.0, %add1057
  %mul1093.1 = fmul contract float %condval_12.0, %add1057.1
  %mul1093.2 = fmul contract float %condval_12.0, %add1057.2
  %mul1093.3 = fmul contract float %condval_12.0, %add1057.3
  %mul1093.4 = fmul contract float %condval_12.0, %add1057.4
  %mul1093.5 = fmul contract float %condval_12.0, %add1057.5
  %mul1093.6 = fmul contract float %condval_12.0, %add1057.6
  %mul1093.7 = fmul contract float %condval_12.0, %add1057.7
  %mul1093.8 = fmul contract float %condval_12.0, %add1057.8
  %mul1093.9 = fmul contract float %condval_12.0, %add1057.9
  %mul1093.10 = fmul contract float %condval_12.0, %add1057.10
  %mul1093.11 = fmul contract float %condval_12.0, %add1057.11
  %mul1093.12 = fmul contract float %condval_12.0, %add1057.12
  %mul1093.13 = fmul contract float %condval_12.0, %add1057.13
  %mul1093.14 = fmul contract float %condval_12.0, %add1057.14
  %mul1093.15 = fmul contract float %condval_12.0, %add1057.15
  %397 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093)
  %O_reg.sroa.0.0.insert.ext = zext i16 %397 to i64
  %398 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %398 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %399 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %399 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %400 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %400 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %401 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %401 to i64
  %402 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %402 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %403 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %403 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %404 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %404 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %405 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %405 to i64
  %406 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %406 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %407 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %407 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %408 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %408 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %409 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %409 to i64
  %410 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %410 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %411 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %411 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %412 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1093.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %412 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr1135 = lshr i32 %11, 5
  %and1138 = and i32 %11, 7
  %mul1144 = and i32 %16, 4
  %xor = xor i32 %shr1135, %and1138
  %mul1139 = shl nuw nsw i32 %xor, 3
  %add1140 = add nuw nsw i32 %mul1139, %mul29
  %add1145 = or disjoint i32 %add1140, %mul1144
  %add.ptr1147 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1147, align 8
  %add1136.1 = add nuw nsw i32 %shr1135, 2
  %xor.1 = xor i32 %add1136.1, %and1138
  %mul1139.1 = shl nuw nsw i32 %xor.1, 3
  %add1140.1 = add nuw nsw i32 %mul1139.1, %mul29
  %add1145.1 = or disjoint i32 %add1140.1, %mul1144
  %add.ptr1147.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1147.1, align 8
  %add1136.2 = add nuw nsw i32 %shr1135, 4
  %xor.2 = xor i32 %add1136.2, %and1138
  %mul1139.2 = shl nuw nsw i32 %xor.2, 3
  %add1140.2 = add nuw nsw i32 %mul1139.2, %mul29
  %add1145.2 = or disjoint i32 %add1140.2, %mul1144
  %add.ptr1147.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1147.2, align 8
  %add1136.3 = add nuw nsw i32 %shr1135, 6
  %xor.3 = xor i32 %add1136.3, %and1138
  %mul1139.3 = shl nuw nsw i32 %xor.3, 3
  %add1140.3 = add nuw nsw i32 %mul1139.3, %mul29
  %add1145.3 = or disjoint i32 %add1140.3, %mul1144
  %add.ptr1147.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1145.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1147.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul1158 = and i32 %15, 8128
  %xor11641445 = and i32 %15, 56
  %call1162.masked = and i32 %11, 1016
  %mul1165 = xor i32 %xor11641445, %call1162.masked
  %invariant.gep1716 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1158
  %invariant.gep1718 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep1716, i32 %mul1165
  %add1175 = add nuw nsw i32 %add26, %15
  %413 = zext nneg i32 %add1175 to i64
  %add.ptr1180 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %413
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1180, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1718, i64 16, i1 false), !tbaa.struct !257, !call_argsrelate !258
  %gep1719.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1718, i32 1024
  %414 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %413
  %add.ptr1180.1 = getelementptr inbounds i8, ptr addrspace(1) %414, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1180.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1719.1, i64 16, i1 false), !tbaa.struct !257, !call_argsrelate !258
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare float @llvm.exp.f32(float) #7

declare void @llvm.mxc.barrier.warp() #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.minnum.f32(float, float) #7

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


