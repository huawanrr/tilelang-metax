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
  %5 = zext nneg i32 %add15 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 128
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 136
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 192
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 200
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8
  %mul24 = mul nuw nsw i32 %div, 192
  %mul26 = mul nuw nsw i32 %1, 3
  %add27 = add nuw nsw i32 %rem.decomposed, %mul26
  %add30 = add nuw nsw i32 %add27, %mul24
  %idxprom = zext nneg i32 %add30 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %9 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %mul31 = shl nsw i32 %9, 4
  %cmp45 = icmp sgt i32 %9, -1
  br i1 %cmp45, label %land.lhs.true, label %if.end412

land.lhs.true:                                    ; preds = %entry
  %cmp46 = icmp ugt i32 %9, 3
  %cmp49.not = icmp sgt i32 %mul31, %1
  %or.cond = select i1 %cmp46, i1 true, i1 %cmp49.not
  br i1 %or.cond, label %if.end412, label %for.cond50.preheader

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
  %10 = zext nneg i32 %add76 to i64
  %11 = icmp ult i32 %add57, 64
  br i1 %11, label %if.then61, label %if.end

if.then61:                                        ; preds = %for.cond50.preheader
  %add.ptr82 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr82, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr82, i64 4
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr82, i64 8
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr82, i64 12
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %for.cond50.preheader, %if.then61
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ]
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ]
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ]
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then61 ], [ 0, %for.cond50.preheader ]
  %12 = icmp ult i32 %add57, 60
  br i1 %12, label %if.then61.1, label %if.end.1

if.then61.1:                                      ; preds = %if.end
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10
  %add.ptr82.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3072
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr82.1, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3076
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx.1, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3080
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx.1, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 3084
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx.1, align 4, !tbaa !30
  br label %if.end.1

if.end.1:                                         ; preds = %if.then61.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then61.1 ], [ 0, %if.end ]
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then61.1 ], [ 0, %if.end ]
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then61.1 ], [ 0, %if.end ]
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then61.1 ], [ 0, %if.end ]
  %14 = icmp ult i32 %add57, 56
  br i1 %14, label %if.then61.2, label %if.end.2

if.then61.2:                                      ; preds = %if.end.1
  %15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10
  %add.ptr82.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6144
  %condval.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr82.2, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6148
  %condval.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx.2, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6152
  %condval.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx.2, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 6156
  %condval.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx.2, align 4, !tbaa !30
  br label %if.end.2

if.end.2:                                         ; preds = %if.then61.2, %if.end.1
  %condval.sroa.0.0.2 = phi i32 [ %condval.sroa.0.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ]
  %condval.sroa.5.0.2 = phi i32 [ %condval.sroa.5.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ]
  %condval.sroa.6.0.2 = phi i32 [ %condval.sroa.6.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ]
  %condval.sroa.7.0.2 = phi i32 [ %condval.sroa.7.0.copyload.2, %if.then61.2 ], [ 0, %if.end.1 ]
  %16 = icmp ult i32 %add57, 52
  br i1 %16, label %if.then61.3, label %if.end.3

if.then61.3:                                      ; preds = %if.end.2
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %10
  %add.ptr82.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9216
  %condval.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr82.3, align 16, !tbaa !30
  %condval.sroa.5.0.add.ptr82.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9220
  %condval.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr82.sroa_idx.3, align 4, !tbaa !30
  %condval.sroa.6.0.add.ptr82.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9224
  %condval.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr82.sroa_idx.3, align 8, !tbaa !30
  %condval.sroa.7.0.add.ptr82.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 9228
  %condval.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr82.sroa_idx.3, align 4, !tbaa !30
  br label %if.end.3

if.end.3:                                         ; preds = %if.then61.3, %if.end.2
  %condval.sroa.0.0.3 = phi i32 [ %condval.sroa.0.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ]
  %condval.sroa.5.0.3 = phi i32 [ %condval.sroa.5.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ]
  %condval.sroa.6.0.3 = phi i32 [ %condval.sroa.6.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ]
  %condval.sroa.7.0.3 = phi i32 [ %condval.sroa.7.0.copyload.3, %if.then61.3 ], [ 0, %if.end.2 ]
  br i1 %11, label %if.then121, label %if.end166

if.then121:                                       ; preds = %if.end.3
  %add.ptr142 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr142, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 8
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 12
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx, align 4, !tbaa !30
  br label %if.end166

if.end166:                                        ; preds = %if.end.3, %if.then121
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then121 ], [ 0, %if.end.3 ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then121 ], [ 0, %if.end.3 ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then121 ], [ 0, %if.end.3 ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then121 ], [ 0, %if.end.3 ]
  br i1 %12, label %if.then121.1, label %if.end166.1

if.then121.1:                                     ; preds = %if.end166
  %18 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10
  %add.ptr142.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3072
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr142.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3076
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3080
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %18, i64 3084
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx.1, align 4, !tbaa !30
  br label %if.end166.1

if.end166.1:                                      ; preds = %if.then121.1, %if.end166
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then121.1 ], [ 0, %if.end166 ]
  br i1 %14, label %if.then121.2, label %if.end166.2

if.then121.2:                                     ; preds = %if.end166.1
  %19 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10
  %add.ptr142.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6144
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr142.2, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6148
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx.2, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6152
  %condval_1.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx.2, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 6156
  %condval_1.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx.2, align 4, !tbaa !30
  br label %if.end166.2

if.end166.2:                                      ; preds = %if.then121.2, %if.end166.1
  %condval_1.sroa.0.0.2 = phi i32 [ %condval_1.sroa.0.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ]
  %condval_1.sroa.5.0.2 = phi i32 [ %condval_1.sroa.5.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ]
  %condval_1.sroa.6.0.2 = phi i32 [ %condval_1.sroa.6.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ]
  %condval_1.sroa.7.0.2 = phi i32 [ %condval_1.sroa.7.0.copyload.2, %if.then121.2 ], [ 0, %if.end166.1 ]
  br i1 %16, label %if.then121.3, label %if.end166.3

if.then121.3:                                     ; preds = %if.end166.2
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %10
  %add.ptr142.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9216
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr142.3, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr142.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9220
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr142.sroa_idx.3, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr142.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9224
  %condval_1.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr142.sroa_idx.3, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr142.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 9228
  %condval_1.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr142.sroa_idx.3, align 4, !tbaa !30
  br label %if.end166.3

if.end166.3:                                      ; preds = %if.then121.3, %if.end166.2
  %condval_1.sroa.0.0.3 = phi i32 [ %condval_1.sroa.0.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ]
  %condval_1.sroa.5.0.3 = phi i32 [ %condval_1.sroa.5.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ]
  %condval_1.sroa.6.0.3 = phi i32 [ %condval_1.sroa.6.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ]
  %condval_1.sroa.7.0.3 = phi i32 [ %condval_1.sroa.7.0.copyload.3, %if.then121.3 ], [ 0, %if.end166.2 ]
  %mul186 = and i32 %and78, 8064
  %and189 = and i32 %3, 15
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul186
  %xor = xor i32 %shr56, %and189
  %add.ptr197.idx = shl nuw nsw i32 %xor, 4
  %add.ptr197 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr197.idx
  store i32 %condval.sroa.0.0, ptr addrspace(3) %add.ptr197, align 16, !tbaa !30
  %K_reg.sroa.4.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197, i32 4
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr197.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197, i32 8
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr197.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197, i32 12
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr197.sroa_idx, align 4, !tbaa !30
  %add193.1 = add nuw nsw i32 %shr56, 4
  %xor.1 = xor i32 %add193.1, %and189
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %add.ptr197.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr197.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr197.idx.1
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %add.ptr197.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.add.ptr197.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.1, i32 4
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr197.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.add.ptr197.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.1, i32 8
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr197.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.add.ptr197.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.1, i32 12
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr197.1.sroa_idx, align 4, !tbaa !30
  %add193.2 = add nuw nsw i32 %shr56, 8
  %xor.2 = xor i32 %add193.2, %and189
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048
  %add.ptr197.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr197.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr197.idx.2
  store i32 %condval.sroa.0.0.2, ptr addrspace(3) %add.ptr197.2, align 16, !tbaa !30
  %K_reg.sroa.14.32.add.ptr197.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.2, i32 4
  store i32 %condval.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr197.2.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.15.32.add.ptr197.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.2, i32 8
  store i32 %condval.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr197.2.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.16.32.add.ptr197.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.2, i32 12
  store i32 %condval.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr197.2.sroa_idx, align 4, !tbaa !30
  %add193.3 = add nuw nsw i32 %shr56, 12
  %xor.3 = xor i32 %add193.3, %and189
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072
  %add.ptr197.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr197.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr197.idx.3
  store i32 %condval.sroa.0.0.3, ptr addrspace(3) %add.ptr197.3, align 16, !tbaa !30
  %K_reg.sroa.19.48.add.ptr197.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.3, i32 4
  store i32 %condval.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr197.3.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.20.48.add.ptr197.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.3, i32 8
  store i32 %condval.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr197.3.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.21.48.add.ptr197.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr197.3, i32 12
  store i32 %condval.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr197.3.sroa_idx, align 4, !tbaa !30
  %add202 = or disjoint i32 %mul31, 15
  %cmp203 = icmp slt i32 %1, %add202
  br i1 %cmp203, label %for.cond205.preheader, label %if.end231

for.cond205.preheader:                            ; preds = %if.end166.3
  %21 = lshr i32 %3, 2
  %mul212 = and i32 %21, 252
  %add213 = add nuw nsw i32 %mul31, %mul212
  %cmp216.not = icmp sgt i32 %add213, %1
  %spec.select = select i1 %cmp216.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert687 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp216.not.1.not = icmp slt i32 %add213, %1
  %spec.select.1 = select i1 %cmp216.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert700 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert687, float %spec.select.1, i64 1
  %add214.2 = or disjoint i32 %add213, 2
  %cmp216.not.2 = icmp sgt i32 %add214.2, %1
  %spec.select.2 = select i1 %cmp216.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert713 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert700, float %spec.select.2, i64 2
  %add214.3 = or disjoint i32 %add213, 3
  %cmp216.not.3 = icmp sgt i32 %add214.3, %1
  %spec.select.3 = select i1 %cmp216.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert726 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert713, float %spec.select.3, i64 3
  br label %if.end231

if.end231:                                        ; preds = %if.end166.3, %for.cond205.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert726, %for.cond205.preheader ], [ zeroinitializer, %if.end166.3 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul12
  %add.ptr250 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr250, align 16
  %kb.sroa.10.0.add.ptr250.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250, i32 8
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.sroa_idx, align 8
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !90
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23), !call_argsrelate !90
  %add.ptr250.1 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx.1
  %kb.sroa.0.0.copyload675 = load <4 x half>, ptr addrspace(3) %add.ptr250.1, align 16
  %kb.sroa.10.0.add.ptr250.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250.1, i32 8
  %kb.sroa.10.0.copyload678 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.1.sroa_idx, align 8
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload675, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !call_argsrelate !90
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload678, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !call_argsrelate !90
  %add.ptr250.2 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx.2
  %kb.sroa.0.0.copyload676 = load <4 x half>, ptr addrspace(3) %add.ptr250.2, align 16
  %kb.sroa.10.0.add.ptr250.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250.2, i32 8
  %kb.sroa.10.0.copyload679 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.2.sroa_idx, align 8
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload676, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %26), !call_argsrelate !90
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload679, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %27), !call_argsrelate !90
  %add.ptr250.3 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %add.ptr197.idx.3
  %kb.sroa.0.0.copyload677 = load <4 x half>, ptr addrspace(3) %add.ptr250.3, align 16
  %kb.sroa.10.0.add.ptr250.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr250.3, i32 8
  %kb.sroa.10.0.copyload680 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr250.3.sroa_idx, align 8
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload677, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %28), !call_argsrelate !90
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload680, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %29), !call_argsrelate !90
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr288.idx = shl nuw nsw i32 %3, 4
  %invariant.gep621 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr288.idx
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep621, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep621.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep621.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep621.sroa_idx, align 4, !tbaa !30
  %gep622.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep622.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep622.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep622.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep622.1.sroa_idx, align 4, !tbaa !30
  %gep622.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2048
  store i32 %condval_1.sroa.0.0.2, ptr addrspace(3) %gep622.2, align 16, !tbaa !30
  %V_reg.sroa.14.32.gep622.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2052
  store i32 %condval_1.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep622.2.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.15.32.gep622.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2056
  store i32 %condval_1.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep622.2.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.16.32.gep622.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 2060
  store i32 %condval_1.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep622.2.sroa_idx, align 4, !tbaa !30
  %gep622.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3072
  store i32 %condval_1.sroa.0.0.3, ptr addrspace(3) %gep622.3, align 16, !tbaa !30
  %V_reg.sroa.19.48.gep622.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3076
  store i32 %condval_1.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep622.3.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.20.48.gep622.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3080
  store i32 %condval_1.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep622.3.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.21.48.gep622.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 3084
  store i32 %condval_1.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep622.3.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract689 = extractelement <4 x float> %30, i64 0
  %mul298 = fmul contract float %acc_s.sroa.0.0.vec.extract689, 0x3FC2776C60000000
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul298, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %31, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %31, %cond.i.i
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %32
  %acc_s.sroa.0.4.vec.extract702 = extractelement <4 x float> %30, i64 1
  %mul298.1 = fmul contract float %acc_s.sroa.0.4.vec.extract702, 0x3FC2776C60000000
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul298.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %33, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %33, %cond.i.i.1
  %34 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %34
  %acc_s.sroa.0.8.vec.extract715 = extractelement <4 x float> %30, i64 2
  %mul298.2 = fmul contract float %acc_s.sroa.0.8.vec.extract715, 0x3FC2776C60000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul298.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %35, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %35, %cond.i.i.2
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %36
  %acc_s.sroa.0.12.vec.extract728 = extractelement <4 x float> %30, i64 3
  %mul298.3 = fmul contract float %acc_s.sroa.0.12.vec.extract728, 0x3FC2776C60000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul298.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %37, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %37, %cond.i.i.3
  %38 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %38
  %add314 = fadd contract float %mul.i.i, 0.000000e+00
  %add314.1 = fadd contract float %add314, %mul.i.i.1
  %add314.2 = fadd contract float %add314.1, %mul.i.i.2
  %add314.3 = fadd contract float %add314.2, %mul.i.i.3
  %39 = bitcast float %add314.3 to i32
  %40 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %41 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %40) #10
  %xor.i.i = xor i32 %41, 32
  %42 = and i32 %41, -64
  %and.i.i = add nsw i32 %42, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i577 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %41
  %shl.i.i = shl i32 %cond.i.i577, 2
  %43 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %39)
  %44 = bitcast i32 %43 to float
  %add322 = fadd contract float %add314.3, %44
  %45 = bitcast float %add322 to i32
  %46 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %47 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %46) #10
  %xor.i.i578 = xor i32 %47, 16
  %48 = and i32 %47, -64
  %and.i.i579 = add nsw i32 %48, 64
  %cmp.not.i.i580 = icmp slt i32 %xor.i.i578, %and.i.i579
  %cond.i.i581 = select i1 %cmp.not.i.i580, i32 %xor.i.i578, i32 %47
  %shl.i.i582 = shl i32 %cond.i.i581, 2
  %49 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i582, i32 %45)
  %50 = bitcast i32 %49 to float
  %add327 = fadd contract float %add322, %50
  %cmp330 = fcmp contract ogt float %add327, 0.000000e+00
  %div333 = fdiv contract float 1.000000e+00, %add327
  %condval_3.0 = select i1 %cmp330, float %div333, float 0.000000e+00
  %mul344 = fmul contract float %condval_3.0, %mul.i.i
  %mul344.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul344.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul344.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %51 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !151
  %52 = fptrunc float %mul344 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %51), !noalias !151
  %53 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !151
  %54 = fptrunc float %mul344.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %53), !noalias !151
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %52, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %54, i64 1
  %55 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !165
  %56 = fptrunc float %mul344.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %55), !noalias !165
  %57 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !165
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %57), !noalias !165
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %56, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %58 = shl nuw nsw i32 %3, 5
  %mul374 = and i32 %58, 32256
  %add381 = or disjoint i32 %mul374, %and189
  %arrayidx383 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381
  %59 = load half, ptr addrspace(3) %arrayidx383, align 2, !tbaa !182
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %59, i64 0
  %add376.1 = or disjoint i32 %mul374, %and189
  %add381.1 = or disjoint i32 %add376.1, 128
  %arrayidx383.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1
  %60 = load half, ptr addrspace(3) %arrayidx383.1, align 2, !tbaa !182
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %60, i64 1
  %add376.2 = or disjoint i32 %mul374, %and189
  %add381.2 = or disjoint i32 %add376.2, 256
  %arrayidx383.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2
  %61 = load half, ptr addrspace(3) %arrayidx383.2, align 2, !tbaa !182
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %61, i64 2
  %add376.3 = or disjoint i32 %mul374, %and189
  %add381.3 = or disjoint i32 %add376.3, 384
  %arrayidx383.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3
  %62 = load half, ptr addrspace(3) %arrayidx383.3, align 2, !tbaa !182
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %62, i64 3
  %add378.1648 = or disjoint i32 %mul374, %and189
  %add381.1649 = or disjoint i32 %add378.1648, 16
  %arrayidx383.1650 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1649
  %63 = load half, ptr addrspace(3) %arrayidx383.1650, align 2, !tbaa !182
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %63, i64 0
  %add378.1.1 = or disjoint i32 %mul374, %and189
  %add381.1.1 = or disjoint i32 %add378.1.1, 144
  %arrayidx383.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.1
  %64 = load half, ptr addrspace(3) %arrayidx383.1.1, align 2, !tbaa !182
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %64, i64 1
  %add378.2.1 = or disjoint i32 %mul374, %and189
  %add381.2.1 = or disjoint i32 %add378.2.1, 272
  %arrayidx383.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.1
  %65 = load half, ptr addrspace(3) %arrayidx383.2.1, align 2, !tbaa !182
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %65, i64 2
  %add378.3.1 = or disjoint i32 %mul374, %and189
  %add381.3.1 = or disjoint i32 %add378.3.1, 400
  %arrayidx383.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.1
  %66 = load half, ptr addrspace(3) %arrayidx383.3.1, align 2, !tbaa !182
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %66, i64 3
  %add378.2652 = or disjoint i32 %mul374, %and189
  %add381.2653 = or disjoint i32 %add378.2652, 32
  %arrayidx383.2654 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2653
  %67 = load half, ptr addrspace(3) %arrayidx383.2654, align 2, !tbaa !182
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %67, i64 0
  %add378.1.2 = or disjoint i32 %mul374, %and189
  %add381.1.2 = or disjoint i32 %add378.1.2, 160
  %arrayidx383.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.2
  %68 = load half, ptr addrspace(3) %arrayidx383.1.2, align 2, !tbaa !182
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %68, i64 1
  %add378.2.2 = or disjoint i32 %mul374, %and189
  %add381.2.2 = or disjoint i32 %add378.2.2, 288
  %arrayidx383.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.2
  %69 = load half, ptr addrspace(3) %arrayidx383.2.2, align 2, !tbaa !182
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %69, i64 2
  %add378.3.2 = or disjoint i32 %mul374, %and189
  %add381.3.2 = or disjoint i32 %add378.3.2, 416
  %arrayidx383.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.2
  %70 = load half, ptr addrspace(3) %arrayidx383.3.2, align 2, !tbaa !182
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %70, i64 3
  %add378.3656 = or disjoint i32 %mul374, %and189
  %add381.3657 = or disjoint i32 %add378.3656, 48
  %arrayidx383.3658 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3657
  %71 = load half, ptr addrspace(3) %arrayidx383.3658, align 2, !tbaa !182
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %71, i64 0
  %add378.1.3 = or disjoint i32 %mul374, %and189
  %add381.1.3 = or disjoint i32 %add378.1.3, 176
  %arrayidx383.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.3
  %72 = load half, ptr addrspace(3) %arrayidx383.1.3, align 2, !tbaa !182
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %72, i64 1
  %add378.2.3 = or disjoint i32 %mul374, %and189
  %add381.2.3 = or disjoint i32 %add378.2.3, 304
  %arrayidx383.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.3
  %73 = load half, ptr addrspace(3) %arrayidx383.2.3, align 2, !tbaa !182
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %73, i64 2
  %add378.3.3 = or disjoint i32 %mul374, %and189
  %add381.3.3 = or disjoint i32 %add378.3.3, 432
  %arrayidx383.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.3
  %74 = load half, ptr addrspace(3) %arrayidx383.3.3, align 2, !tbaa !182
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %74, i64 3
  %add378.4 = or disjoint i32 %mul374, %and189
  %add381.4 = or disjoint i32 %add378.4, 64
  %arrayidx383.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.4
  %75 = load half, ptr addrspace(3) %arrayidx383.4, align 2, !tbaa !182
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %75, i64 0
  %add378.1.4 = or disjoint i32 %mul374, %and189
  %add381.1.4 = or disjoint i32 %add378.1.4, 192
  %arrayidx383.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.4
  %76 = load half, ptr addrspace(3) %arrayidx383.1.4, align 2, !tbaa !182
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %76, i64 1
  %add378.2.4 = or disjoint i32 %mul374, %and189
  %add381.2.4 = or disjoint i32 %add378.2.4, 320
  %arrayidx383.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.4
  %77 = load half, ptr addrspace(3) %arrayidx383.2.4, align 2, !tbaa !182
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %77, i64 2
  %add378.3.4 = or disjoint i32 %mul374, %and189
  %add381.3.4 = or disjoint i32 %add378.3.4, 448
  %arrayidx383.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.4
  %78 = load half, ptr addrspace(3) %arrayidx383.3.4, align 2, !tbaa !182
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %78, i64 3
  %add378.5 = or disjoint i32 %mul374, %and189
  %add381.5 = or disjoint i32 %add378.5, 80
  %arrayidx383.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.5
  %79 = load half, ptr addrspace(3) %arrayidx383.5, align 2, !tbaa !182
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %79, i64 0
  %add378.1.5 = or disjoint i32 %mul374, %and189
  %add381.1.5 = or disjoint i32 %add378.1.5, 208
  %arrayidx383.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.5
  %80 = load half, ptr addrspace(3) %arrayidx383.1.5, align 2, !tbaa !182
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %80, i64 1
  %add378.2.5 = or disjoint i32 %mul374, %and189
  %add381.2.5 = or disjoint i32 %add378.2.5, 336
  %arrayidx383.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.5
  %81 = load half, ptr addrspace(3) %arrayidx383.2.5, align 2, !tbaa !182
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %81, i64 2
  %add378.3.5 = or disjoint i32 %mul374, %and189
  %add381.3.5 = or disjoint i32 %add378.3.5, 464
  %arrayidx383.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.5
  %82 = load half, ptr addrspace(3) %arrayidx383.3.5, align 2, !tbaa !182
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %82, i64 3
  %add378.6 = or disjoint i32 %mul374, %and189
  %add381.6 = or disjoint i32 %add378.6, 96
  %arrayidx383.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.6
  %83 = load half, ptr addrspace(3) %arrayidx383.6, align 2, !tbaa !182
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %83, i64 0
  %add378.1.6 = or disjoint i32 %mul374, %and189
  %add381.1.6 = or disjoint i32 %add378.1.6, 224
  %arrayidx383.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.6
  %84 = load half, ptr addrspace(3) %arrayidx383.1.6, align 2, !tbaa !182
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %84, i64 1
  %add378.2.6 = or disjoint i32 %mul374, %and189
  %add381.2.6 = or disjoint i32 %add378.2.6, 352
  %arrayidx383.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.6
  %85 = load half, ptr addrspace(3) %arrayidx383.2.6, align 2, !tbaa !182
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %85, i64 2
  %add378.3.6 = or disjoint i32 %58, %and189
  %add381.3.6 = or i32 %add378.3.6, 480
  %arrayidx383.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.6
  %86 = load half, ptr addrspace(3) %arrayidx383.3.6, align 2, !tbaa !182
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %86, i64 3
  %add378.7 = or disjoint i32 %mul374, %and189
  %add381.7 = or disjoint i32 %add378.7, 112
  %arrayidx383.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.7
  %87 = load half, ptr addrspace(3) %arrayidx383.7, align 2, !tbaa !182
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %87, i64 0
  %add378.1.7 = or disjoint i32 %mul374, %and189
  %add381.1.7 = or disjoint i32 %add378.1.7, 240
  %arrayidx383.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.1.7
  %88 = load half, ptr addrspace(3) %arrayidx383.1.7, align 2, !tbaa !182
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %88, i64 1
  %add378.2.7 = or disjoint i32 %mul374, %and189
  %add381.2.7 = or disjoint i32 %add378.2.7, 368
  %arrayidx383.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.2.7
  %89 = load half, ptr addrspace(3) %arrayidx383.2.7, align 2, !tbaa !182
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %89, i64 2
  %add378.3.7 = or disjoint i32 %58, %and189
  %add381.3.7 = or i32 %add378.3.7, 496
  %arrayidx383.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add381.3.7
  %90 = load half, ptr addrspace(3) %arrayidx383.3.7, align 2, !tbaa !182
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %90, i64 3
  %91 = fptrunc float %mul344.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %91, i64 3
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end412

if.end412:                                        ; preds = %if.end231, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %92, %if.end231 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %93, %if.end231 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %94, %if.end231 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %95, %if.end231 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %96, %if.end231 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.52.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %97, %if.end231 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.62.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %98, %if.end231 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %99, %if.end231 ], [ zeroinitializer, %entry ]
  %100 = lshr i32 %3, 2
  %mul453 = and i32 %100, 252
  %add450 = add nuw nsw i32 %add13, %mul453
  %101 = zext nneg i32 %add450 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %103 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !noalias !190
  %104 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %105 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %104), !noalias !190
  %106 = bitcast half %103 to i16
  %107 = bitcast half %105 to i16
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %109 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !noalias !205
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %111 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !noalias !205
  %112 = bitcast half %109 to i16
  %113 = bitcast half %111 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %113 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %112 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %107 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %106 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr456 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr456, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %115 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !noalias !190
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %117 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !noalias !190
  %118 = bitcast half %115 to i16
  %119 = bitcast half %117 to i16
  %120 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %121 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %120), !noalias !205
  %122 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %123 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %122), !noalias !205
  %124 = bitcast half %121 to i16
  %125 = bitcast half %123 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %125 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %124 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %119 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %118 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %126 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  %add.ptr456.1 = getelementptr inbounds i8, ptr addrspace(1) %126, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr456.1, align 8
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %127 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %128 = fptrunc float %acc_o.sroa.22.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %127), !noalias !190
  %129 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %130 = fptrunc float %acc_o.sroa.22.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %129), !noalias !190
  %131 = bitcast half %128 to i16
  %132 = bitcast half %130 to i16
  %133 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %134 = fptrunc float %acc_o.sroa.22.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %133), !noalias !205
  %135 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %136 = fptrunc float %acc_o.sroa.22.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %135), !noalias !205
  %137 = bitcast half %134 to i16
  %138 = bitcast half %136 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %138 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %137 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %132 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %131 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %139 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  %add.ptr456.2 = getelementptr inbounds i8, ptr addrspace(1) %139, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr456.2, align 8
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %140 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %141 = fptrunc float %acc_o.sroa.32.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %140), !noalias !190
  %142 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %143 = fptrunc float %acc_o.sroa.32.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %142), !noalias !190
  %144 = bitcast half %141 to i16
  %145 = bitcast half %143 to i16
  %146 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %147 = fptrunc float %acc_o.sroa.32.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %146), !noalias !205
  %148 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %149 = fptrunc float %acc_o.sroa.32.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %148), !noalias !205
  %150 = bitcast half %147 to i16
  %151 = bitcast half %149 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %151 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %150 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %145 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %144 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %152 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  %add.ptr456.3 = getelementptr inbounds i8, ptr addrspace(1) %152, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr456.3, align 8
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3
  %153 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %154 = fptrunc float %acc_o.sroa.42.64.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %153), !noalias !190
  %155 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %156 = fptrunc float %acc_o.sroa.42.68.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %155), !noalias !190
  %157 = bitcast half %154 to i16
  %158 = bitcast half %156 to i16
  %159 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %160 = fptrunc float %acc_o.sroa.42.72.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %159), !noalias !205
  %161 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %162 = fptrunc float %acc_o.sroa.42.76.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %161), !noalias !205
  %163 = bitcast half %160 to i16
  %164 = bitcast half %162 to i16
  %__2.sroa.6.0.insert.ext.4 = zext i16 %164 to i64
  %__2.sroa.6.0.insert.shift.4 = shl nuw i64 %__2.sroa.6.0.insert.ext.4, 48
  %__2.sroa.5.0.insert.ext.4 = zext i16 %163 to i64
  %__2.sroa.5.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.4, 32
  %__2.sroa.5.0.insert.insert.4 = or disjoint i64 %__2.sroa.6.0.insert.shift.4, %__2.sroa.5.0.insert.shift.4
  %__2.sroa.4.0.insert.ext.4 = zext i16 %158 to i64
  %__2.sroa.4.0.insert.shift.4 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.4, 16
  %__2.sroa.4.0.insert.insert.4 = or disjoint i64 %__2.sroa.5.0.insert.insert.4, %__2.sroa.4.0.insert.shift.4
  %__2.sroa.0.0.insert.ext.4 = zext i16 %157 to i64
  %__2.sroa.0.0.insert.insert.4 = or disjoint i64 %__2.sroa.4.0.insert.insert.4, %__2.sroa.0.0.insert.ext.4
  %165 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  %add.ptr456.4 = getelementptr inbounds i8, ptr addrspace(1) %165, i64 128
  store i64 %__2.sroa.0.0.insert.insert.4, ptr addrspace(1) %add.ptr456.4, align 8
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3
  %166 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %167 = fptrunc float %acc_o.sroa.52.80.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %166), !noalias !190
  %168 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %169 = fptrunc float %acc_o.sroa.52.84.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %168), !noalias !190
  %170 = bitcast half %167 to i16
  %171 = bitcast half %169 to i16
  %172 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %173 = fptrunc float %acc_o.sroa.52.88.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %172), !noalias !205
  %174 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %175 = fptrunc float %acc_o.sroa.52.92.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %174), !noalias !205
  %176 = bitcast half %173 to i16
  %177 = bitcast half %175 to i16
  %__2.sroa.6.0.insert.ext.5 = zext i16 %177 to i64
  %__2.sroa.6.0.insert.shift.5 = shl nuw i64 %__2.sroa.6.0.insert.ext.5, 48
  %__2.sroa.5.0.insert.ext.5 = zext i16 %176 to i64
  %__2.sroa.5.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.5, 32
  %__2.sroa.5.0.insert.insert.5 = or disjoint i64 %__2.sroa.6.0.insert.shift.5, %__2.sroa.5.0.insert.shift.5
  %__2.sroa.4.0.insert.ext.5 = zext i16 %171 to i64
  %__2.sroa.4.0.insert.shift.5 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.5, 16
  %__2.sroa.4.0.insert.insert.5 = or disjoint i64 %__2.sroa.5.0.insert.insert.5, %__2.sroa.4.0.insert.shift.5
  %__2.sroa.0.0.insert.ext.5 = zext i16 %170 to i64
  %__2.sroa.0.0.insert.insert.5 = or disjoint i64 %__2.sroa.4.0.insert.insert.5, %__2.sroa.0.0.insert.ext.5
  %178 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  %add.ptr456.5 = getelementptr inbounds i8, ptr addrspace(1) %178, i64 160
  store i64 %__2.sroa.0.0.insert.insert.5, ptr addrspace(1) %add.ptr456.5, align 8
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3
  %179 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %180 = fptrunc float %acc_o.sroa.62.96.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %179), !noalias !190
  %181 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %182 = fptrunc float %acc_o.sroa.62.100.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %181), !noalias !190
  %183 = bitcast half %180 to i16
  %184 = bitcast half %182 to i16
  %185 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %186 = fptrunc float %acc_o.sroa.62.104.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %185), !noalias !205
  %187 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %188 = fptrunc float %acc_o.sroa.62.108.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %187), !noalias !205
  %189 = bitcast half %186 to i16
  %190 = bitcast half %188 to i16
  %__2.sroa.6.0.insert.ext.6 = zext i16 %190 to i64
  %__2.sroa.6.0.insert.shift.6 = shl nuw i64 %__2.sroa.6.0.insert.ext.6, 48
  %__2.sroa.5.0.insert.ext.6 = zext i16 %189 to i64
  %__2.sroa.5.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.6, 32
  %__2.sroa.5.0.insert.insert.6 = or disjoint i64 %__2.sroa.6.0.insert.shift.6, %__2.sroa.5.0.insert.shift.6
  %__2.sroa.4.0.insert.ext.6 = zext i16 %184 to i64
  %__2.sroa.4.0.insert.shift.6 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.6, 16
  %__2.sroa.4.0.insert.insert.6 = or disjoint i64 %__2.sroa.5.0.insert.insert.6, %__2.sroa.4.0.insert.shift.6
  %__2.sroa.0.0.insert.ext.6 = zext i16 %183 to i64
  %__2.sroa.0.0.insert.insert.6 = or disjoint i64 %__2.sroa.4.0.insert.insert.6, %__2.sroa.0.0.insert.ext.6
  %191 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  %add.ptr456.6 = getelementptr inbounds i8, ptr addrspace(1) %191, i64 192
  store i64 %__2.sroa.0.0.insert.insert.6, ptr addrspace(1) %add.ptr456.6, align 8
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3
  %192 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %193 = fptrunc float %acc_o.sroa.72.112.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %192), !noalias !190
  %194 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !190
  %195 = fptrunc float %acc_o.sroa.72.116.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %194), !noalias !190
  %196 = bitcast half %193 to i16
  %197 = bitcast half %195 to i16
  %198 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %199 = fptrunc float %acc_o.sroa.72.120.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %198), !noalias !205
  %200 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !205
  %201 = fptrunc float %acc_o.sroa.72.124.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %200), !noalias !205
  %202 = bitcast half %199 to i16
  %203 = bitcast half %201 to i16
  %__2.sroa.6.0.insert.ext.7 = zext i16 %203 to i64
  %__2.sroa.6.0.insert.shift.7 = shl nuw i64 %__2.sroa.6.0.insert.ext.7, 48
  %__2.sroa.5.0.insert.ext.7 = zext i16 %202 to i64
  %__2.sroa.5.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.7, 32
  %__2.sroa.5.0.insert.insert.7 = or disjoint i64 %__2.sroa.6.0.insert.shift.7, %__2.sroa.5.0.insert.shift.7
  %__2.sroa.4.0.insert.ext.7 = zext i16 %197 to i64
  %__2.sroa.4.0.insert.shift.7 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.7, 16
  %__2.sroa.4.0.insert.insert.7 = or disjoint i64 %__2.sroa.5.0.insert.insert.7, %__2.sroa.4.0.insert.shift.7
  %__2.sroa.0.0.insert.ext.7 = zext i16 %196 to i64
  %__2.sroa.0.0.insert.insert.7 = or disjoint i64 %__2.sroa.4.0.insert.insert.7, %__2.sroa.0.0.insert.ext.7
  %204 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %101
  %add.ptr456.7 = getelementptr inbounds i8, ptr addrspace(1) %204, i64 224
  store i64 %__2.sroa.0.0.insert.insert.7, ptr addrspace(1) %add.ptr456.7, align 8
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


