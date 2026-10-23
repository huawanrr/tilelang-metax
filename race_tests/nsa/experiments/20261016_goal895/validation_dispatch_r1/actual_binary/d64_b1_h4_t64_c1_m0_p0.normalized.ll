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
  %4 = zext nneg i32 %add12 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %mul20 = shl nsw i32 %0, 2
  %add22 = add nuw nsw i32 %mul20, %1
  %idxprom = zext nneg i32 %add22 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %mul23 = shl nsw i32 %6, 4
  %cmp37 = icmp sgt i32 %6, -1
  br i1 %cmp37, label %land.lhs.true, label %if.end350

land.lhs.true:                                    ; preds = %entry
  %cmp38 = icmp ugt i32 %6, 3
  %cmp41.not = icmp sgt i32 %mul23, %0
  %or.cond = select i1 %cmp38, i1 true, i1 %cmp41.not
  br i1 %or.cond, label %if.end350, label %for.cond42.preheader

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
  %7 = zext nneg i32 %add61 to i64
  br i1 %cmp50, label %if.then51, label %if.end

if.then51:                                        ; preds = %for.cond42.preheader
  %add.ptr67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7
  %8 = load <4 x half>, ptr addrspace(4) %add.ptr67, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr67, i64 8
  %9 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx, align 8, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %for.cond42.preheader, %if.then51
  %10 = phi <4 x half> [ %9, %if.then51 ], [ zeroinitializer, %for.cond42.preheader ]
  %11 = phi <4 x half> [ %8, %if.then51 ], [ zeroinitializer, %for.cond42.preheader ]
  br i1 %cmp50, label %if.then51.1, label %if.end.1

if.then51.1:                                      ; preds = %if.end
  %12 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7
  %add.ptr67.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 64
  %13 = load <4 x half>, ptr addrspace(4) %add.ptr67.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %12, i64 72
  %14 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx.1, align 8, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.then51.1, %if.end
  %15 = phi <4 x half> [ %14, %if.then51.1 ], [ zeroinitializer, %if.end ]
  %16 = phi <4 x half> [ %13, %if.then51.1 ], [ zeroinitializer, %if.end ]
  %shr101 = lshr i32 %2, 3
  %add102 = add nuw nsw i32 %mul23, %shr101
  %17 = shl nuw nsw i32 %2, 5
  %mul110 = and i32 %17, 32512
  %add111 = add nuw nsw i32 %mul110, %mul58
  %and118 = shl nuw nsw i32 %2, 3
  %mul119 = and i32 %and118, 56
  %add113 = or disjoint i32 %add111, %mul119
  %add116 = add nuw nsw i32 %add113, %mul52
  %18 = zext nneg i32 %add116 to i64
  %cmp105 = icmp ult i32 %add102, 64
  br i1 %cmp105, label %if.then106, label %if.end146

for.cond158.preheader:                            ; preds = %if.end146.1
  %19 = lshr i32 %2, 2
  %mul165 = and i32 %19, 252
  %add166 = add nuw nsw i32 %mul23, %mul165
  %cmp169.not = icmp sgt i32 %add166, %0
  %spec.select = select i1 %cmp169.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert594 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp169.not.1.not = icmp slt i32 %add166, %0
  %spec.select.1 = select i1 %cmp169.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert607 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert594, float %spec.select.1, i64 1
  %add167.2 = or disjoint i32 %add166, 2
  %cmp169.not.2 = icmp sgt i32 %add167.2, %0
  %spec.select.2 = select i1 %cmp169.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert620 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert607, float %spec.select.2, i64 2
  %add167.3 = or disjoint i32 %add166, 3
  %cmp169.not.3 = icmp sgt i32 %add167.3, %0
  %spec.select.3 = select i1 %cmp169.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert633 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert620, float %spec.select.3, i64 3
  br label %if.end184

if.then106:                                       ; preds = %if.end.1
  %add.ptr122 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %18
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr122, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr122, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr122.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr122, i64 8
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr122.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr122, i64 12
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr122.sroa_idx, align 4, !tbaa !30
  br label %if.end146

if.end146:                                        ; preds = %if.end.1, %if.then106
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then106 ], [ 0, %if.end.1 ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then106 ], [ 0, %if.end.1 ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then106 ], [ 0, %if.end.1 ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then106 ], [ 0, %if.end.1 ]
  %cmp105.1 = icmp ult i32 %add102, 56
  br i1 %cmp105.1, label %if.then106.1, label %if.end146.1

if.then106.1:                                     ; preds = %if.end146
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %18
  %add.ptr122.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4096
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr122.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr122.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4100
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr122.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr122.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4104
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr122.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr122.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 4108
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr122.sroa_idx.1, align 4, !tbaa !30
  br label %if.end146.1

if.end146.1:                                      ; preds = %if.then106.1, %if.end146
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then106.1 ], [ 0, %if.end146 ]
  %add155 = or disjoint i32 %mul23, 15
  %cmp156 = icmp slt i32 %0, %add155
  br i1 %cmp156, label %for.cond158.preheader, label %if.end184

if.end184:                                        ; preds = %if.end146.1, %for.cond158.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert633, %for.cond158.preheader ], [ zeroinitializer, %if.end146.1 ]
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %11, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !74
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %10, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %21), !call_argsrelate !74
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %16, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %22), !call_argsrelate !74
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %15, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %23), !call_argsrelate !74
  %add.ptr227.idx = shl nuw nsw i32 %2, 4
  %invariant.gep = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr227.idx
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract596 = extractelement <4 x float> %24, i64 0
  %mul237 = fmul contract float %acc_s.sroa.0.0.vec.extract596, 0x3FC2776C60000000
  %25 = tail call contract noundef float @llvm.minnum.f32(float %mul237, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %25, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %25, %cond.i.i
  %26 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %26
  %acc_s.sroa.0.4.vec.extract609 = extractelement <4 x float> %24, i64 1
  %mul237.1 = fmul contract float %acc_s.sroa.0.4.vec.extract609, 0x3FC2776C60000000
  %27 = tail call contract noundef float @llvm.minnum.f32(float %mul237.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %27, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %27, %cond.i.i.1
  %28 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %28
  %acc_s.sroa.0.8.vec.extract622 = extractelement <4 x float> %24, i64 2
  %mul237.2 = fmul contract float %acc_s.sroa.0.8.vec.extract622, 0x3FC2776C60000000
  %29 = tail call contract noundef float @llvm.minnum.f32(float %mul237.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %29, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %29, %cond.i.i.2
  %30 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %30
  %acc_s.sroa.0.12.vec.extract635 = extractelement <4 x float> %24, i64 3
  %mul237.3 = fmul contract float %acc_s.sroa.0.12.vec.extract635, 0x3FC2776C60000000
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul237.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %31, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %31, %cond.i.i.3
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %32
  %add253 = fadd contract float %mul.i.i, 0.000000e+00
  %add253.1 = fadd contract float %add253, %mul.i.i.1
  %add253.2 = fadd contract float %add253.1, %mul.i.i.2
  %add253.3 = fadd contract float %add253.2, %mul.i.i.3
  %33 = bitcast float %add253.3 to i32
  %34 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %35 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %34) #10
  %xor.i.i = xor i32 %35, 32
  %36 = and i32 %35, -64
  %and.i.i = add nsw i32 %36, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i505 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %35
  %shl.i.i = shl i32 %cond.i.i505, 2
  %37 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %33)
  %38 = bitcast i32 %37 to float
  %add261 = fadd contract float %add253.3, %38
  %39 = bitcast float %add261 to i32
  %40 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %41 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %40) #10
  %xor.i.i506 = xor i32 %41, 16
  %42 = and i32 %41, -64
  %and.i.i507 = add nsw i32 %42, 64
  %cmp.not.i.i508 = icmp slt i32 %xor.i.i506, %and.i.i507
  %cond.i.i509 = select i1 %cmp.not.i.i508, i32 %xor.i.i506, i32 %41
  %shl.i.i510 = shl i32 %cond.i.i509, 2
  %43 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i510, i32 %39)
  %44 = bitcast i32 %43 to float
  %add266 = fadd contract float %add261, %44
  %cmp269 = fcmp contract ogt float %add266, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add266
  %condval_3.0 = select i1 %cmp269, float %div, float 0.000000e+00
  %mul282 = fmul contract float %condval_3.0, %mul.i.i
  %mul282.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul282.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul282.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %45 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !131
  %46 = fptrunc float %mul282 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %45), !noalias !131
  %47 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !131
  %48 = fptrunc float %mul282.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %47), !noalias !131
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %46, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %48, i64 1
  %49 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !145
  %50 = fptrunc float %mul282.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %49), !noalias !145
  %51 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !145
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %51), !noalias !145
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %50, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul312 = and i32 %add.ptr227.idx, 16128
  %add319 = or disjoint i32 %mul312, %and48
  %arrayidx321 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319
  %52 = load half, ptr addrspace(3) %arrayidx321, align 2, !tbaa !164
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %52, i64 0
  %add314.1 = or disjoint i32 %mul312, %and48
  %add319.1 = or disjoint i32 %add314.1, 64
  %arrayidx321.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1
  %53 = load half, ptr addrspace(3) %arrayidx321.1, align 2, !tbaa !164
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %53, i64 1
  %add314.2 = or disjoint i32 %mul312, %and48
  %add319.2 = or disjoint i32 %add314.2, 128
  %arrayidx321.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2
  %54 = load half, ptr addrspace(3) %arrayidx321.2, align 2, !tbaa !164
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %54, i64 2
  %add314.3 = or disjoint i32 %mul312, %and48
  %add319.3 = or disjoint i32 %add314.3, 192
  %arrayidx321.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3
  %55 = load half, ptr addrspace(3) %arrayidx321.3, align 2, !tbaa !164
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %55, i64 3
  %add316.1571 = or disjoint i32 %mul312, %and48
  %add319.1572 = or disjoint i32 %add316.1571, 16
  %arrayidx321.1573 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1572
  %56 = load half, ptr addrspace(3) %arrayidx321.1573, align 2, !tbaa !164
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %56, i64 0
  %add316.1.1 = or disjoint i32 %mul312, %and48
  %add319.1.1 = or disjoint i32 %add316.1.1, 80
  %arrayidx321.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1.1
  %57 = load half, ptr addrspace(3) %arrayidx321.1.1, align 2, !tbaa !164
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %57, i64 1
  %add316.2.1 = or disjoint i32 %mul312, %and48
  %add319.2.1 = or disjoint i32 %add316.2.1, 144
  %arrayidx321.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2.1
  %58 = load half, ptr addrspace(3) %arrayidx321.2.1, align 2, !tbaa !164
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %58, i64 2
  %add316.3.1 = or disjoint i32 %mul312, %and48
  %add319.3.1 = or disjoint i32 %add316.3.1, 208
  %arrayidx321.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3.1
  %59 = load half, ptr addrspace(3) %arrayidx321.3.1, align 2, !tbaa !164
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %59, i64 3
  %add316.2575 = or disjoint i32 %mul312, %and48
  %add319.2576 = or disjoint i32 %add316.2575, 32
  %arrayidx321.2577 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2576
  %60 = load half, ptr addrspace(3) %arrayidx321.2577, align 2, !tbaa !164
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %60, i64 0
  %add316.1.2 = or disjoint i32 %mul312, %and48
  %add319.1.2 = or disjoint i32 %add316.1.2, 96
  %arrayidx321.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1.2
  %61 = load half, ptr addrspace(3) %arrayidx321.1.2, align 2, !tbaa !164
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %61, i64 1
  %add316.2.2 = or disjoint i32 %mul312, %and48
  %add319.2.2 = or disjoint i32 %add316.2.2, 160
  %arrayidx321.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2.2
  %62 = load half, ptr addrspace(3) %arrayidx321.2.2, align 2, !tbaa !164
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %62, i64 2
  %add316.3.2 = or disjoint i32 %mul312, %and48
  %add319.3.2 = or disjoint i32 %add316.3.2, 224
  %arrayidx321.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3.2
  %63 = load half, ptr addrspace(3) %arrayidx321.3.2, align 2, !tbaa !164
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %63, i64 3
  %add316.3579 = or disjoint i32 %mul312, %and48
  %add319.3580 = or disjoint i32 %add316.3579, 48
  %arrayidx321.3581 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3580
  %64 = load half, ptr addrspace(3) %arrayidx321.3581, align 2, !tbaa !164
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %64, i64 0
  %add316.1.3 = or disjoint i32 %mul312, %and48
  %add319.1.3 = or disjoint i32 %add316.1.3, 112
  %arrayidx321.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.1.3
  %65 = load half, ptr addrspace(3) %arrayidx321.1.3, align 2, !tbaa !164
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %65, i64 1
  %add316.2.3 = or disjoint i32 %mul312, %and48
  %add319.2.3 = or disjoint i32 %add316.2.3, 176
  %arrayidx321.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.2.3
  %66 = load half, ptr addrspace(3) %arrayidx321.2.3, align 2, !tbaa !164
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %66, i64 2
  %add316.3.3 = or disjoint i32 %add.ptr227.idx, %and48
  %add319.3.3 = or i32 %add316.3.3, 240
  %arrayidx321.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add319.3.3
  %67 = load half, ptr addrspace(3) %arrayidx321.3.3, align 2, !tbaa !164
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %67, i64 3
  %68 = fptrunc float %mul282.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %68, i64 3
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end350

if.end350:                                        ; preds = %if.end184, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %69, %if.end184 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %70, %if.end184 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %71, %if.end184 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %72, %if.end184 ], [ zeroinitializer, %entry ]
  %73 = lshr i32 %2, 2
  %mul386 = and i32 %73, 252
  %add383 = add nuw nsw i32 %add10, %mul386
  %74 = zext nneg i32 %add383 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %75 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %76 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %75), !noalias !172
  %77 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %78 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %77), !noalias !172
  %79 = bitcast half %76 to i16
  %80 = bitcast half %78 to i16
  %81 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %82 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %81), !noalias !187
  %83 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %84 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %83), !noalias !187
  %85 = bitcast half %82 to i16
  %86 = bitcast half %84 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %86 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %85 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %80 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %79 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr389 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr389, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %88 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !noalias !172
  %89 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %90 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %89), !noalias !172
  %91 = bitcast half %88 to i16
  %92 = bitcast half %90 to i16
  %93 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %94 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %93), !noalias !187
  %95 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %96 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %95), !noalias !187
  %97 = bitcast half %94 to i16
  %98 = bitcast half %96 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %98 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %97 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %92 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %91 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %99 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74
  %add.ptr389.1 = getelementptr inbounds i8, ptr addrspace(1) %99, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr389.1, align 8
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %100 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %101 = fptrunc float %acc_o.sroa.22.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %100), !noalias !172
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %103 = fptrunc float %acc_o.sroa.22.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !noalias !172
  %104 = bitcast half %101 to i16
  %105 = bitcast half %103 to i16
  %106 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %107 = fptrunc float %acc_o.sroa.22.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %106), !noalias !187
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %109 = fptrunc float %acc_o.sroa.22.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !noalias !187
  %110 = bitcast half %107 to i16
  %111 = bitcast half %109 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %111 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %110 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %105 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %104 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %112 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74
  %add.ptr389.2 = getelementptr inbounds i8, ptr addrspace(1) %112, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr389.2, align 8
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %113 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %114 = fptrunc float %acc_o.sroa.32.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %113), !noalias !172
  %115 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !172
  %116 = fptrunc float %acc_o.sroa.32.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %115), !noalias !172
  %117 = bitcast half %114 to i16
  %118 = bitcast half %116 to i16
  %119 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %120 = fptrunc float %acc_o.sroa.32.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %119), !noalias !187
  %121 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !187
  %122 = fptrunc float %acc_o.sroa.32.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %121), !noalias !187
  %123 = bitcast half %120 to i16
  %124 = bitcast half %122 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %124 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %123 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %118 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %117 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %125 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %74
  %add.ptr389.3 = getelementptr inbounds i8, ptr addrspace(1) %125, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr389.3, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare void @llvm.mxc.barrier.warp() #6

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


