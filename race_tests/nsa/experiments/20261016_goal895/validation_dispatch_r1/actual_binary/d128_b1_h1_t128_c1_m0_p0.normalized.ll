target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 {
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
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 128
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16
  %q.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 136
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.10.32.add.ptr.2.sroa_idx, align 8
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 192
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16
  %q.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 200
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.13.48.add.ptr.3.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp31 = icmp ugt i32 %7, 7
  %shr34 = lshr i32 %0, 4
  %cmp35.not = icmp ugt i32 %7, %shr34
  %or.cond350 = or i1 %cmp31, %cmp35.not
  br i1 %or.cond350, label %entry.if.end217_crit_edge, label %for.cond36.preheader

entry.if.end217_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  %.pre465 = and i32 %.pre, 252
  br label %if.end217

for.cond36.preheader:                             ; preds = %entry
  %mul41 = shl nuw nsw i32 %7, 11
  %add45 = add nuw nsw i32 %mul11, %mul7
  %add47 = add nuw nsw i32 %add45, %mul41
  %8 = zext nneg i32 %add47 to i64
  %add.ptr53 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr53, align 16
  %k.sroa.4.0.add.ptr53.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr53, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr53.sroa_idx, align 8
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %add.ptr53.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 64
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr53.1, align 16
  %k.sroa.7.16.add.ptr53.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %9, i64 72
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.add.ptr53.1.sroa_idx, align 8
  %10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %add.ptr53.2 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 128
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr53.2, align 16
  %k.sroa.10.32.add.ptr53.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %10, i64 136
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.add.ptr53.2.sroa_idx, align 8
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %add.ptr53.3 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 192
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr53.3, align 16
  %k.sroa.13.48.add.ptr53.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %11, i64 200
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.add.ptr53.3.sroa_idx, align 8
  %12 = shl nuw nsw i32 %1, 5
  %mul69 = and i32 %12, 32256
  %add70 = add nuw nsw i32 %mul41, %mul69
  %and78 = and i32 %1, 15
  %add79 = or disjoint i32 %add70, %and78
  %idxprom80 = zext nneg i32 %add79 to i64
  %arrayidx81 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80
  %13 = load half, ptr addrspace(4) %arrayidx81, align 2, !tbaa !62
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %13, i64 0
  %add73.1 = or disjoint i32 %add70, %and78
  %add79.1 = or disjoint i32 %add73.1, 128
  %idxprom80.1 = zext nneg i32 %add79.1 to i64
  %arrayidx81.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.1
  %14 = load half, ptr addrspace(4) %arrayidx81.1, align 2, !tbaa !62
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %14, i64 1
  %add73.2 = or disjoint i32 %add70, %and78
  %add79.2 = or disjoint i32 %add73.2, 256
  %idxprom80.2 = zext nneg i32 %add79.2 to i64
  %arrayidx81.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.2
  %15 = load half, ptr addrspace(4) %arrayidx81.2, align 2, !tbaa !62
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %15, i64 2
  %add73.3 = or disjoint i32 %add70, %and78
  %add79.3 = or disjoint i32 %add73.3, 384
  %idxprom80.3 = zext nneg i32 %add79.3 to i64
  %arrayidx81.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.3
  %16 = load half, ptr addrspace(4) %arrayidx81.3, align 2, !tbaa !62
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %16, i64 3
  %add76.4 = or disjoint i32 %add70, %and78
  %add79.4 = or disjoint i32 %add76.4, 16
  %idxprom80.4 = zext nneg i32 %add79.4 to i64
  %arrayidx81.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.4
  %17 = load half, ptr addrspace(4) %arrayidx81.4, align 2, !tbaa !62
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %17, i64 0
  %add76.5 = or disjoint i32 %add70, %and78
  %add79.5 = or disjoint i32 %add76.5, 144
  %idxprom80.5 = zext nneg i32 %add79.5 to i64
  %arrayidx81.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.5
  %18 = load half, ptr addrspace(4) %arrayidx81.5, align 2, !tbaa !62
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %18, i64 1
  %add76.6 = or disjoint i32 %add70, %and78
  %add79.6 = or disjoint i32 %add76.6, 272
  %idxprom80.6 = zext nneg i32 %add79.6 to i64
  %arrayidx81.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.6
  %19 = load half, ptr addrspace(4) %arrayidx81.6, align 2, !tbaa !62
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %19, i64 2
  %add76.7 = or disjoint i32 %add70, %and78
  %add79.7 = or disjoint i32 %add76.7, 400
  %idxprom80.7 = zext nneg i32 %add79.7 to i64
  %arrayidx81.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.7
  %20 = load half, ptr addrspace(4) %arrayidx81.7, align 2, !tbaa !62
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %20, i64 3
  %add76.8 = or disjoint i32 %add70, %and78
  %add79.8 = or disjoint i32 %add76.8, 32
  %idxprom80.8 = zext nneg i32 %add79.8 to i64
  %arrayidx81.8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.8
  %21 = load half, ptr addrspace(4) %arrayidx81.8, align 2, !tbaa !62
  %v.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %21, i64 0
  %add76.9 = or disjoint i32 %add70, %and78
  %add79.9 = or disjoint i32 %add76.9, 160
  %idxprom80.9 = zext nneg i32 %add79.9 to i64
  %arrayidx81.9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.9
  %22 = load half, ptr addrspace(4) %arrayidx81.9, align 2, !tbaa !62
  %v.sroa.12.18.vec.insert = insertelement <4 x half> %v.sroa.12.16.vec.insert, half %22, i64 1
  %add76.10 = or disjoint i32 %add70, %and78
  %add79.10 = or disjoint i32 %add76.10, 288
  %idxprom80.10 = zext nneg i32 %add79.10 to i64
  %arrayidx81.10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.10
  %23 = load half, ptr addrspace(4) %arrayidx81.10, align 2, !tbaa !62
  %v.sroa.12.20.vec.insert = insertelement <4 x half> %v.sroa.12.18.vec.insert, half %23, i64 2
  %add76.11 = or disjoint i32 %add70, %and78
  %add79.11 = or disjoint i32 %add76.11, 416
  %idxprom80.11 = zext nneg i32 %add79.11 to i64
  %arrayidx81.11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.11
  %24 = load half, ptr addrspace(4) %arrayidx81.11, align 2, !tbaa !62
  %v.sroa.12.22.vec.insert = insertelement <4 x half> %v.sroa.12.20.vec.insert, half %24, i64 3
  %add76.12 = or disjoint i32 %add70, %and78
  %add79.12 = or disjoint i32 %add76.12, 48
  %idxprom80.12 = zext nneg i32 %add79.12 to i64
  %arrayidx81.12 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.12
  %25 = load half, ptr addrspace(4) %arrayidx81.12, align 2, !tbaa !62
  %v.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %25, i64 0
  %add76.13 = or disjoint i32 %add70, %and78
  %add79.13 = or disjoint i32 %add76.13, 176
  %idxprom80.13 = zext nneg i32 %add79.13 to i64
  %arrayidx81.13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.13
  %26 = load half, ptr addrspace(4) %arrayidx81.13, align 2, !tbaa !62
  %v.sroa.17.26.vec.insert = insertelement <4 x half> %v.sroa.17.24.vec.insert, half %26, i64 1
  %add76.14 = or disjoint i32 %add70, %and78
  %add79.14 = or disjoint i32 %add76.14, 304
  %idxprom80.14 = zext nneg i32 %add79.14 to i64
  %arrayidx81.14 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.14
  %27 = load half, ptr addrspace(4) %arrayidx81.14, align 2, !tbaa !62
  %v.sroa.17.28.vec.insert = insertelement <4 x half> %v.sroa.17.26.vec.insert, half %27, i64 2
  %add76.15 = or disjoint i32 %add70, %and78
  %add79.15 = or disjoint i32 %add76.15, 432
  %idxprom80.15 = zext nneg i32 %add79.15 to i64
  %arrayidx81.15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.15
  %28 = load half, ptr addrspace(4) %arrayidx81.15, align 2, !tbaa !62
  %v.sroa.17.30.vec.insert = insertelement <4 x half> %v.sroa.17.28.vec.insert, half %28, i64 3
  %add76.16 = or disjoint i32 %add70, %and78
  %add79.16 = or disjoint i32 %add76.16, 64
  %idxprom80.16 = zext nneg i32 %add79.16 to i64
  %arrayidx81.16 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.16
  %29 = load half, ptr addrspace(4) %arrayidx81.16, align 2, !tbaa !62
  %v.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %29, i64 0
  %add76.17 = or disjoint i32 %add70, %and78
  %add79.17 = or disjoint i32 %add76.17, 192
  %idxprom80.17 = zext nneg i32 %add79.17 to i64
  %arrayidx81.17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.17
  %30 = load half, ptr addrspace(4) %arrayidx81.17, align 2, !tbaa !62
  %v.sroa.22.34.vec.insert = insertelement <4 x half> %v.sroa.22.32.vec.insert, half %30, i64 1
  %add76.18 = or disjoint i32 %add70, %and78
  %add79.18 = or disjoint i32 %add76.18, 320
  %idxprom80.18 = zext nneg i32 %add79.18 to i64
  %arrayidx81.18 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.18
  %31 = load half, ptr addrspace(4) %arrayidx81.18, align 2, !tbaa !62
  %v.sroa.22.36.vec.insert = insertelement <4 x half> %v.sroa.22.34.vec.insert, half %31, i64 2
  %add76.19 = or disjoint i32 %add70, %and78
  %add79.19 = or disjoint i32 %add76.19, 448
  %idxprom80.19 = zext nneg i32 %add79.19 to i64
  %arrayidx81.19 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.19
  %32 = load half, ptr addrspace(4) %arrayidx81.19, align 2, !tbaa !62
  %v.sroa.22.38.vec.insert = insertelement <4 x half> %v.sroa.22.36.vec.insert, half %32, i64 3
  %add76.20 = or disjoint i32 %add70, %and78
  %add79.20 = or disjoint i32 %add76.20, 80
  %idxprom80.20 = zext nneg i32 %add79.20 to i64
  %arrayidx81.20 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.20
  %33 = load half, ptr addrspace(4) %arrayidx81.20, align 2, !tbaa !62
  %v.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %33, i64 0
  %add76.21 = or disjoint i32 %add70, %and78
  %add79.21 = or disjoint i32 %add76.21, 208
  %idxprom80.21 = zext nneg i32 %add79.21 to i64
  %arrayidx81.21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.21
  %34 = load half, ptr addrspace(4) %arrayidx81.21, align 2, !tbaa !62
  %v.sroa.27.42.vec.insert = insertelement <4 x half> %v.sroa.27.40.vec.insert, half %34, i64 1
  %add76.22 = or disjoint i32 %add70, %and78
  %add79.22 = or disjoint i32 %add76.22, 336
  %idxprom80.22 = zext nneg i32 %add79.22 to i64
  %arrayidx81.22 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.22
  %35 = load half, ptr addrspace(4) %arrayidx81.22, align 2, !tbaa !62
  %v.sroa.27.44.vec.insert = insertelement <4 x half> %v.sroa.27.42.vec.insert, half %35, i64 2
  %add76.23 = or disjoint i32 %add70, %and78
  %add79.23 = or disjoint i32 %add76.23, 464
  %idxprom80.23 = zext nneg i32 %add79.23 to i64
  %arrayidx81.23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.23
  %36 = load half, ptr addrspace(4) %arrayidx81.23, align 2, !tbaa !62
  %v.sroa.27.46.vec.insert = insertelement <4 x half> %v.sroa.27.44.vec.insert, half %36, i64 3
  %add76.24 = or disjoint i32 %add70, %and78
  %add79.24 = or disjoint i32 %add76.24, 96
  %idxprom80.24 = zext nneg i32 %add79.24 to i64
  %arrayidx81.24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.24
  %37 = load half, ptr addrspace(4) %arrayidx81.24, align 2, !tbaa !62
  %v.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %37, i64 0
  %add76.25 = or disjoint i32 %add70, %and78
  %add79.25 = or disjoint i32 %add76.25, 224
  %idxprom80.25 = zext nneg i32 %add79.25 to i64
  %arrayidx81.25 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.25
  %38 = load half, ptr addrspace(4) %arrayidx81.25, align 2, !tbaa !62
  %v.sroa.32.50.vec.insert = insertelement <4 x half> %v.sroa.32.48.vec.insert, half %38, i64 1
  %add76.26 = or disjoint i32 %add70, %and78
  %add79.26 = or disjoint i32 %add76.26, 352
  %idxprom80.26 = zext nneg i32 %add79.26 to i64
  %arrayidx81.26 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.26
  %39 = load half, ptr addrspace(4) %arrayidx81.26, align 2, !tbaa !62
  %v.sroa.32.52.vec.insert = insertelement <4 x half> %v.sroa.32.50.vec.insert, half %39, i64 2
  %add76.27 = or disjoint i32 %add70, %and78
  %add79.27 = or disjoint i32 %add76.27, 480
  %idxprom80.27 = zext nneg i32 %add79.27 to i64
  %arrayidx81.27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.27
  %40 = load half, ptr addrspace(4) %arrayidx81.27, align 2, !tbaa !62
  %v.sroa.32.54.vec.insert = insertelement <4 x half> %v.sroa.32.52.vec.insert, half %40, i64 3
  %add76.28 = or disjoint i32 %add70, %and78
  %add79.28 = or disjoint i32 %add76.28, 112
  %idxprom80.28 = zext nneg i32 %add79.28 to i64
  %arrayidx81.28 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.28
  %41 = load half, ptr addrspace(4) %arrayidx81.28, align 2, !tbaa !62
  %v.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %41, i64 0
  %add76.29 = or disjoint i32 %add70, %and78
  %add79.29 = or disjoint i32 %add76.29, 240
  %idxprom80.29 = zext nneg i32 %add79.29 to i64
  %arrayidx81.29 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.29
  %42 = load half, ptr addrspace(4) %arrayidx81.29, align 2, !tbaa !62
  %v.sroa.37.58.vec.insert = insertelement <4 x half> %v.sroa.37.56.vec.insert, half %42, i64 1
  %add76.30 = or disjoint i32 %add70, %and78
  %add79.30 = or disjoint i32 %add76.30, 368
  %idxprom80.30 = zext nneg i32 %add79.30 to i64
  %arrayidx81.30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.30
  %43 = load half, ptr addrspace(4) %arrayidx81.30, align 2, !tbaa !62
  %v.sroa.37.60.vec.insert = insertelement <4 x half> %v.sroa.37.58.vec.insert, half %43, i64 2
  %add76.31 = or disjoint i32 %add70, %and78
  %add79.31 = or disjoint i32 %add76.31, 496
  %idxprom80.31 = zext nneg i32 %add79.31 to i64
  %arrayidx81.31 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.31
  %44 = load half, ptr addrspace(4) %arrayidx81.31, align 2, !tbaa !62
  %v.sroa.37.62.vec.insert = insertelement <4 x half> %v.sroa.37.60.vec.insert, half %44, i64 3
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !64
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %45), !call_argsrelate !64
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %46), !call_argsrelate !64
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %47), !call_argsrelate !64
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %48), !call_argsrelate !64
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %49), !call_argsrelate !64
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %50), !call_argsrelate !64
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %51), !call_argsrelate !64
  %mul124 = shl nuw nsw i32 %7, 4
  %53 = lshr i32 %1, 2
  %mul127 = and i32 %53, 252
  %add128 = add nuw nsw i32 %mul124, %mul127
  %cmp131.not = icmp ugt i32 %add128, %0
  %. = select i1 %cmp131.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %52, i64 0
  %mul135 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul135, float 0x4024CB5EC0000000)
  %55 = tail call contract noundef float @llvm.exp.f32(float %54)
  %mul138 = fmul contract float %., %55
  %cmp131.not.1.not = icmp ult i32 %add128, %0
  %..1 = select i1 %cmp131.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %52, i64 1
  %mul135.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul135.1, float 0x4024CB5EC0000000)
  %57 = tail call contract noundef float @llvm.exp.f32(float %56)
  %mul138.1 = fmul contract float %..1, %57
  %add129.2 = or disjoint i32 %add128, 2
  %cmp131.not.2 = icmp ugt i32 %add129.2, %0
  %..2 = select i1 %cmp131.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %52, i64 2
  %mul135.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul135.2, float 0x4024CB5EC0000000)
  %59 = tail call contract noundef float @llvm.exp.f32(float %58)
  %mul138.2 = fmul contract float %..2, %59
  %add129.3 = or disjoint i32 %add128, 3
  %cmp131.not.3 = icmp ugt i32 %add129.3, %0
  %..3 = select i1 %cmp131.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %52, i64 3
  %mul135.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul135.3, float 0x4024CB5EC0000000)
  %61 = tail call contract noundef float @llvm.exp.f32(float %60)
  %mul138.3 = fmul contract float %..3, %61
  %add152 = fadd contract float %mul138, 0.000000e+00
  %add152.1 = fadd contract float %add152, %mul138.1
  %add152.2 = fadd contract float %add152.1, %mul138.2
  %add152.3 = fadd contract float %add152.2, %mul138.3
  %62 = bitcast float %add152.3 to i32
  %63 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %64 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %63) #10
  %xor.i.i = xor i32 %64, 32
  %65 = and i32 %64, -64
  %and.i.i = add nsw i32 %65, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %64
  %shl.i.i = shl i32 %cond.i.i, 2
  %66 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %62)
  %67 = bitcast i32 %66 to float
  %add160 = fadd contract float %add152.3, %67
  %68 = bitcast float %add160 to i32
  %69 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %70 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %69) #10
  %xor.i.i327 = xor i32 %70, 16
  %71 = and i32 %70, -64
  %and.i.i328 = add nsw i32 %71, 64
  %cmp.not.i.i329 = icmp slt i32 %xor.i.i327, %and.i.i328
  %cond.i.i330 = select i1 %cmp.not.i.i329, i32 %xor.i.i327, i32 %70
  %shl.i.i331 = shl i32 %cond.i.i330, 2
  %72 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i331, i32 %68)
  %73 = bitcast i32 %72 to float
  %add165 = fadd contract float %add160, %73
  %cmp168 = fcmp contract ogt float %add165, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add165
  %condval_1.0 = select i1 %cmp168, float %div, float 0.000000e+00
  %mul181 = fmul contract float %condval_1.0, %mul138
  %mul181.1 = fmul contract float %condval_1.0, %mul138.1
  %mul181.2 = fmul contract float %condval_1.0, %mul138.2
  %mul181.3 = fmul contract float %condval_1.0, %mul138.3
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181)
  %75 = insertelement <4 x i16> poison, i16 %74, i64 0
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181.1)
  %77 = insertelement <4 x i16> %75, i16 %76, i64 1
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181.2)
  %79 = insertelement <4 x i16> %77, i16 %78, i64 2
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181.3)
  %81 = insertelement <4 x i16> %79, i16 %80, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %81 to <4 x half>
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.38.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.27.46.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.54.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.37.62.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end217

if.end217:                                        ; preds = %entry.if.end217_crit_edge, %for.cond36.preheader
  %mul259.pre-phi = phi i32 [ %.pre465, %entry.if.end217_crit_edge ], [ %mul127, %for.cond36.preheader ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %82, %for.cond36.preheader ]
  %out.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %83, %for.cond36.preheader ]
  %out.sroa.22.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %84, %for.cond36.preheader ]
  %out.sroa.32.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %85, %for.cond36.preheader ]
  %out.sroa.42.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %86, %for.cond36.preheader ]
  %out.sroa.52.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %87, %for.cond36.preheader ]
  %out.sroa.62.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %88, %for.cond36.preheader ]
  %out.sroa.72.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %89, %for.cond36.preheader ]
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %result.sroa.0.0.insert.ext = zext i16 %90 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %result.sroa.0.2.insert.ext = zext i16 %91 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %result.sroa.0.4.insert.ext = zext i16 %92 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %result.sroa.0.6.insert.ext = zext i16 %93 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %out.sroa.12.16.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 0
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.16.vec.extract)
  %result.sroa.7.8.insert.ext = zext i16 %94 to i64
  %out.sroa.12.20.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 1
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.20.vec.extract)
  %result.sroa.7.10.insert.ext = zext i16 %95 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %out.sroa.12.24.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 2
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.24.vec.extract)
  %result.sroa.7.12.insert.ext = zext i16 %96 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %out.sroa.12.28.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 3
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.28.vec.extract)
  %result.sroa.7.14.insert.ext = zext i16 %97 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %out.sroa.22.32.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 0
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.32.vec.extract)
  %result.sroa.12.16.insert.ext = zext i16 %98 to i64
  %out.sroa.22.36.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 1
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.36.vec.extract)
  %result.sroa.12.18.insert.ext = zext i16 %99 to i64
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext
  %out.sroa.22.40.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 2
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.40.vec.extract)
  %result.sroa.12.20.insert.ext = zext i16 %100 to i64
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift
  %out.sroa.22.44.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 3
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.44.vec.extract)
  %result.sroa.12.22.insert.ext = zext i16 %101 to i64
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift
  %out.sroa.32.48.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 0
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.48.vec.extract)
  %result.sroa.17.24.insert.ext = zext i16 %102 to i64
  %out.sroa.32.52.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 1
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.52.vec.extract)
  %result.sroa.17.26.insert.ext = zext i16 %103 to i64
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext
  %out.sroa.32.56.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 2
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.56.vec.extract)
  %result.sroa.17.28.insert.ext = zext i16 %104 to i64
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift
  %out.sroa.32.60.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 3
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.60.vec.extract)
  %result.sroa.17.30.insert.ext = zext i16 %105 to i64
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift
  %out.sroa.42.64.vec.extract = extractelement <4 x float> %out.sroa.42.0, i64 0
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.42.64.vec.extract)
  %result.sroa.22.32.insert.ext = zext i16 %106 to i64
  %out.sroa.42.68.vec.extract = extractelement <4 x float> %out.sroa.42.0, i64 1
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.42.68.vec.extract)
  %result.sroa.22.34.insert.ext = zext i16 %107 to i64
  %result.sroa.22.34.insert.shift = shl nuw nsw i64 %result.sroa.22.34.insert.ext, 16
  %result.sroa.22.34.insert.insert = or disjoint i64 %result.sroa.22.34.insert.shift, %result.sroa.22.32.insert.ext
  %out.sroa.42.72.vec.extract = extractelement <4 x float> %out.sroa.42.0, i64 2
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.42.72.vec.extract)
  %result.sroa.22.36.insert.ext = zext i16 %108 to i64
  %result.sroa.22.36.insert.shift = shl nuw nsw i64 %result.sroa.22.36.insert.ext, 32
  %result.sroa.22.36.insert.insert = or disjoint i64 %result.sroa.22.34.insert.insert, %result.sroa.22.36.insert.shift
  %out.sroa.42.76.vec.extract = extractelement <4 x float> %out.sroa.42.0, i64 3
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.42.76.vec.extract)
  %result.sroa.22.38.insert.ext = zext i16 %109 to i64
  %result.sroa.22.38.insert.shift = shl nuw i64 %result.sroa.22.38.insert.ext, 48
  %result.sroa.22.38.insert.insert = or disjoint i64 %result.sroa.22.36.insert.insert, %result.sroa.22.38.insert.shift
  %out.sroa.52.80.vec.extract = extractelement <4 x float> %out.sroa.52.0, i64 0
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.52.80.vec.extract)
  %result.sroa.27.40.insert.ext = zext i16 %110 to i64
  %out.sroa.52.84.vec.extract = extractelement <4 x float> %out.sroa.52.0, i64 1
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.52.84.vec.extract)
  %result.sroa.27.42.insert.ext = zext i16 %111 to i64
  %result.sroa.27.42.insert.shift = shl nuw nsw i64 %result.sroa.27.42.insert.ext, 16
  %result.sroa.27.42.insert.insert = or disjoint i64 %result.sroa.27.42.insert.shift, %result.sroa.27.40.insert.ext
  %out.sroa.52.88.vec.extract = extractelement <4 x float> %out.sroa.52.0, i64 2
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.52.88.vec.extract)
  %result.sroa.27.44.insert.ext = zext i16 %112 to i64
  %result.sroa.27.44.insert.shift = shl nuw nsw i64 %result.sroa.27.44.insert.ext, 32
  %result.sroa.27.44.insert.insert = or disjoint i64 %result.sroa.27.42.insert.insert, %result.sroa.27.44.insert.shift
  %out.sroa.52.92.vec.extract = extractelement <4 x float> %out.sroa.52.0, i64 3
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.52.92.vec.extract)
  %result.sroa.27.46.insert.ext = zext i16 %113 to i64
  %result.sroa.27.46.insert.shift = shl nuw i64 %result.sroa.27.46.insert.ext, 48
  %result.sroa.27.46.insert.insert = or disjoint i64 %result.sroa.27.44.insert.insert, %result.sroa.27.46.insert.shift
  %out.sroa.62.96.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 0
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.96.vec.extract)
  %result.sroa.32.48.insert.ext = zext i16 %114 to i64
  %out.sroa.62.100.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 1
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.100.vec.extract)
  %result.sroa.32.50.insert.ext = zext i16 %115 to i64
  %result.sroa.32.50.insert.shift = shl nuw nsw i64 %result.sroa.32.50.insert.ext, 16
  %result.sroa.32.50.insert.insert = or disjoint i64 %result.sroa.32.50.insert.shift, %result.sroa.32.48.insert.ext
  %out.sroa.62.104.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 2
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.104.vec.extract)
  %result.sroa.32.52.insert.ext = zext i16 %116 to i64
  %result.sroa.32.52.insert.shift = shl nuw nsw i64 %result.sroa.32.52.insert.ext, 32
  %result.sroa.32.52.insert.insert = or disjoint i64 %result.sroa.32.50.insert.insert, %result.sroa.32.52.insert.shift
  %out.sroa.62.108.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 3
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.108.vec.extract)
  %result.sroa.32.54.insert.ext = zext i16 %117 to i64
  %result.sroa.32.54.insert.shift = shl nuw i64 %result.sroa.32.54.insert.ext, 48
  %result.sroa.32.54.insert.insert = or disjoint i64 %result.sroa.32.52.insert.insert, %result.sroa.32.54.insert.shift
  %out.sroa.72.112.vec.extract = extractelement <4 x float> %out.sroa.72.0, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.72.112.vec.extract)
  %result.sroa.37.56.insert.ext = zext i16 %118 to i64
  %out.sroa.72.116.vec.extract = extractelement <4 x float> %out.sroa.72.0, i64 1
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.72.116.vec.extract)
  %result.sroa.37.58.insert.ext = zext i16 %119 to i64
  %result.sroa.37.58.insert.shift = shl nuw nsw i64 %result.sroa.37.58.insert.ext, 16
  %result.sroa.37.58.insert.insert = or disjoint i64 %result.sroa.37.58.insert.shift, %result.sroa.37.56.insert.ext
  %out.sroa.72.120.vec.extract = extractelement <4 x float> %out.sroa.72.0, i64 2
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.72.120.vec.extract)
  %result.sroa.37.60.insert.ext = zext i16 %120 to i64
  %result.sroa.37.60.insert.shift = shl nuw nsw i64 %result.sroa.37.60.insert.ext, 32
  %result.sroa.37.60.insert.insert = or disjoint i64 %result.sroa.37.58.insert.insert, %result.sroa.37.60.insert.shift
  %out.sroa.72.124.vec.extract = extractelement <4 x float> %out.sroa.72.0, i64 3
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.72.124.vec.extract)
  %result.sroa.37.62.insert.ext = zext i16 %121 to i64
  %result.sroa.37.62.insert.shift = shl nuw i64 %result.sroa.37.62.insert.ext, 48
  %result.sroa.37.62.insert.insert = or disjoint i64 %result.sroa.37.60.insert.insert, %result.sroa.37.62.insert.shift
  %add256 = add nuw nsw i32 %add, %mul259.pre-phi
  %122 = zext nneg i32 %add256 to i64
  %add.ptr262 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr262, align 8
  %123 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr262.1 = getelementptr inbounds i8, ptr addrspace(1) %123, i64 32
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr262.1, align 8
  %124 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr262.2 = getelementptr inbounds i8, ptr addrspace(1) %124, i64 64
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr262.2, align 8
  %125 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr262.3 = getelementptr inbounds i8, ptr addrspace(1) %125, i64 96
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr262.3, align 8
  %126 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr262.4 = getelementptr inbounds i8, ptr addrspace(1) %126, i64 128
  store i64 %result.sroa.22.38.insert.insert, ptr addrspace(1) %add.ptr262.4, align 8
  %127 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr262.5 = getelementptr inbounds i8, ptr addrspace(1) %127, i64 160
  store i64 %result.sroa.27.46.insert.insert, ptr addrspace(1) %add.ptr262.5, align 8
  %128 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr262.6 = getelementptr inbounds i8, ptr addrspace(1) %128, i64 192
  store i64 %result.sroa.32.54.insert.insert, ptr addrspace(1) %add.ptr262.6, align 8
  %129 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %122
  %add.ptr262.7 = getelementptr inbounds i8, ptr addrspace(1) %129, i64 224
  store i64 %result.sroa.37.62.insert.insert, ptr addrspace(1) %add.ptr262.7, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp.f32(float) #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare i16 @llvm.convert.to.fp16.f32(float) #8

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.minnum.f32(float, float) #7

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #9 = { nounwind willreturn }
attributes #10 = { nomerge }


