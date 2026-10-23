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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 {
entry:
  %blocks = alloca [4 x i32], align 4, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 16, ptr addrspace(5) %blocks) #12, !call_argsrelate !43
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 19
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !44
  %and = shl nuw nsw i32 %2, 6
  %mul9 = and i32 %and, 960
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %mul25 = shl nsw i32 %0, 11
  %mul27 = shl nsw i32 %1, 2
  %add28 = add nuw nsw i32 %mul25, %mul27
  %6 = zext nneg i32 %add28 to i64
  %arrayidx30 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx30, align 4, !tbaa !30
  store i32 %7, ptr addrspace(5) %blocks, align 4, !tbaa !30
  %8 = or disjoint i64 %6, 1
  %arrayidx30.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx30.1, align 4, !tbaa !30
  %arrayidx32.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4
  store i32 %9, ptr addrspace(5) %arrayidx32.1, align 4, !tbaa !30
  %10 = or disjoint i64 %6, 2
  %arrayidx30.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx30.2, align 4, !tbaa !30
  %arrayidx32.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8
  store i32 %11, ptr addrspace(5) %arrayidx32.2, align 4, !tbaa !30
  %12 = or disjoint i64 %6, 3
  %arrayidx30.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx30.3, align 4, !tbaa !30
  %arrayidx32.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12
  store i32 %13, ptr addrspace(5) %arrayidx32.3, align 4, !tbaa !30
  %or.cond = icmp ugt i32 %7, 31
  %shr41 = lshr i32 %1, 4
  %cmp42.not = icmp ugt i32 %7, %shr41
  %or.cond1092 = or i1 %or.cond, %cmp42.not
  br i1 %or.cond1092, label %if.end, label %for.cond43.preheader

for.cond43.preheader:                             ; preds = %entry
  %mul57 = shl nsw i32 %0, 15
  %mul58 = shl nuw nsw i32 %7, 10
  %mul63 = shl nuw nsw i32 %2, 3
  %add59 = or disjoint i32 %mul63, %mul57
  %add61 = add nuw nsw i32 %add59, %mul58
  %14 = zext nneg i32 %add61 to i64
  %arrayidx69 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx69, align 2, !tbaa !57
  %16 = or disjoint i64 %14, 2
  %arrayidx69.1855 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx69.1855, align 2, !tbaa !57
  %18 = or disjoint i64 %14, 4
  %arrayidx69.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx69.2, align 2, !tbaa !57
  %20 = or disjoint i64 %14, 6
  %arrayidx69.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load <2 x i16>, ptr addrspace(4) %arrayidx69.3, align 2, !tbaa !57
  %22 = add nuw nsw i64 %14, 512
  %arrayidx69.1862 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load <2 x i16>, ptr addrspace(4) %arrayidx69.1862, align 2, !tbaa !57
  %24 = add nuw nsw i64 %14, 514
  %arrayidx69.1855.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load <2 x i16>, ptr addrspace(4) %arrayidx69.1855.1, align 2, !tbaa !57
  %26 = add nuw nsw i64 %14, 516
  %arrayidx69.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx69.2.1, align 2, !tbaa !57
  %28 = add nuw nsw i64 %14, 518
  %arrayidx69.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx69.3.1, align 2, !tbaa !57
  %arrayidx112 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx112, align 2, !tbaa !57
  %arrayidx112.1876 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx112.1876, align 2, !tbaa !57
  %arrayidx112.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx112.2, align 2, !tbaa !57
  %arrayidx112.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %33 = load <2 x i16>, ptr addrspace(4) %arrayidx112.3, align 2, !tbaa !57
  %arrayidx112.1883 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %34 = load <2 x i16>, ptr addrspace(4) %arrayidx112.1883, align 2, !tbaa !57
  %arrayidx112.1876.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %35 = load <2 x i16>, ptr addrspace(4) %arrayidx112.1876.1, align 2, !tbaa !57
  %arrayidx112.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26
  %36 = load <2 x i16>, ptr addrspace(4) %arrayidx112.2.1, align 2, !tbaa !57
  %arrayidx112.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28
  %37 = load <2 x i16>, ptr addrspace(4) %arrayidx112.3.1, align 2, !tbaa !57
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond43.preheader
  %38 = phi <2 x i16> [ %30, %for.cond43.preheader ], [ undef, %entry ]
  %39 = phi <2 x i16> [ %31, %for.cond43.preheader ], [ undef, %entry ]
  %40 = phi <2 x i16> [ %32, %for.cond43.preheader ], [ undef, %entry ]
  %41 = phi <2 x i16> [ %33, %for.cond43.preheader ], [ undef, %entry ]
  %42 = phi <2 x i16> [ %34, %for.cond43.preheader ], [ undef, %entry ]
  %43 = phi <2 x i16> [ %35, %for.cond43.preheader ], [ undef, %entry ]
  %44 = phi <2 x i16> [ %36, %for.cond43.preheader ], [ undef, %entry ]
  %45 = phi <2 x i16> [ %37, %for.cond43.preheader ], [ undef, %entry ]
  %46 = phi <2 x i16> [ %15, %for.cond43.preheader ], [ undef, %entry ]
  %47 = phi <2 x i16> [ %17, %for.cond43.preheader ], [ undef, %entry ]
  %48 = phi <2 x i16> [ %19, %for.cond43.preheader ], [ undef, %entry ]
  %49 = phi <2 x i16> [ %21, %for.cond43.preheader ], [ undef, %entry ]
  %50 = phi <2 x i16> [ %23, %for.cond43.preheader ], [ undef, %entry ]
  %51 = phi <2 x i16> [ %25, %for.cond43.preheader ], [ undef, %entry ]
  %52 = phi <2 x i16> [ %27, %for.cond43.preheader ], [ undef, %entry ]
  %53 = phi <2 x i16> [ %29, %for.cond43.preheader ], [ undef, %entry ]
  %54 = shl nuw nsw i32 %2, 3
  %mul172 = and i32 %54, 8128
  %xor786 = and i32 %54, 56
  %call176.masked = and i32 %2, 1016
  %mul178 = xor i32 %xor786, %call176.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul172
  %invariant.gep798 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul178
  %55 = lshr i32 %2, 2
  %mul197 = and i32 %55, 252
  %shr225 = lshr i32 %2, 4
  %and228 = and i32 %2, 7
  %56 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul9
  %invariant.gep810 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 2048
  %mul345 = shl nsw i32 %0, 15
  %add347 = or disjoint i32 %54, %mul345
  %57 = shl nuw nsw i32 %2, 4
  %mul439 = and i32 %57, 16128
  %and444 = lshr i32 %2, 3
  %shr445 = and i32 %and444, 1
  %mul450 = and i32 %55, 4
  %k.sroa.7.0.invariant.gep798.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 4
  %k.sroa.11.0.invariant.gep798.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 8
  %k.sroa.15.0.invariant.gep798.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 12
  %gep799.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 1024
  %k.sroa.24.16.gep799.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 1028
  %k.sroa.28.16.gep799.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 1032
  %k.sroa.32.16.gep799.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 1036
  %xor229 = xor i32 %shr225, %and228
  %add.ptr233.idx = shl nuw nsw i32 %xor229, 4
  %add.ptr233 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr233.idx
  %kb.sroa.6.0.add.ptr233.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr233, i32 8
  %add226.1 = add nuw nsw i32 %shr225, 4
  %xor229.1 = xor i32 %add226.1, %and228
  %add.ptr233.idx.1 = shl nuw nsw i32 %xor229.1, 4
  %add.ptr233.1 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr233.idx.1
  %kb.sroa.6.0.add.ptr233.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr233.1, i32 8
  %v.sroa.7.0.invariant.gep810.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 2052
  %v.sroa.11.0.invariant.gep810.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 2056
  %v.sroa.15.0.invariant.gep810.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 3072
  %v.sroa.24.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 3076
  %v.sroa.28.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 3080
  %v.sroa.32.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 3084
  %xor452 = or disjoint i32 %mul450, %shr445
  %mul453 = shl nuw nsw i32 %xor452, 3
  %add454 = or disjoint i32 %mul453, %mul439
  %add457 = or disjoint i32 %add454, %and228
  %gep820 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457
  %add441.1 = or disjoint i32 %mul439, 64
  %add451.1 = or disjoint i32 %mul450, 1
  %xor452.1 = xor i32 %add451.1, %shr445
  %mul453.1 = shl nuw nsw i32 %xor452.1, 3
  %add454.1 = or disjoint i32 %mul453.1, %add441.1
  %add457.1 = or disjoint i32 %add454.1, %and228
  %gep820.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.1
  %add441.2 = or disjoint i32 %mul439, 128
  %add451.2 = or disjoint i32 %mul450, 2
  %xor452.2 = or disjoint i32 %add451.2, %shr445
  %mul453.2 = shl nuw nsw i32 %xor452.2, 3
  %add454.2 = or disjoint i32 %mul453.2, %add441.2
  %add457.2 = or disjoint i32 %add454.2, %and228
  %gep820.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.2
  %add441.3 = or disjoint i32 %mul439, 192
  %add451.3 = or disjoint i32 %mul450, 3
  %xor452.3 = xor i32 %add451.3, %shr445
  %mul453.3 = shl nuw nsw i32 %xor452.3, 3
  %add454.3 = or disjoint i32 %mul453.3, %add441.3
  %add457.3 = or disjoint i32 %add454.3, %and228
  %gep820.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.3
  %add446.1 = or disjoint i32 %shr445, 2
  %xor452.1934 = or disjoint i32 %mul450, %add446.1
  %mul453.1935 = shl nuw nsw i32 %xor452.1934, 3
  %add454.1936 = or disjoint i32 %mul453.1935, %mul439
  %add457.1937 = or disjoint i32 %add454.1936, %and228
  %gep820.1938 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.1937
  %xor452.1.1 = xor i32 %add451.1, %add446.1
  %mul453.1.1 = shl nuw nsw i32 %xor452.1.1, 3
  %add454.1.1 = or disjoint i32 %mul453.1.1, %add441.1
  %add457.1.1 = or disjoint i32 %add454.1.1, %and228
  %gep820.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.1.1
  %xor452.2.1 = xor i32 %add451.2, %add446.1
  %mul453.2.1 = shl nuw nsw i32 %xor452.2.1, 3
  %add454.2.1 = or disjoint i32 %mul453.2.1, %add441.2
  %add457.2.1 = or disjoint i32 %add454.2.1, %and228
  %gep820.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.2.1
  %xor452.3.1 = xor i32 %add451.3, %add446.1
  %mul453.3.1 = shl nuw nsw i32 %xor452.3.1, 3
  %add454.3.1 = or disjoint i32 %mul453.3.1, %add441.3
  %add457.3.1 = or disjoint i32 %add454.3.1, %and228
  %gep820.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.3.1
  %add446.2 = or disjoint i32 %shr445, 4
  %xor452.2940 = xor i32 %mul450, %add446.2
  %mul453.2941 = shl nuw nsw i32 %xor452.2940, 3
  %add454.2942 = or disjoint i32 %mul453.2941, %mul439
  %add457.2943 = or disjoint i32 %add454.2942, %and228
  %gep820.2944 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.2943
  %xor452.1.2 = xor i32 %add451.1, %add446.2
  %mul453.1.2 = shl nuw nsw i32 %xor452.1.2, 3
  %add454.1.2 = or disjoint i32 %mul453.1.2, %add441.1
  %add457.1.2 = or disjoint i32 %add454.1.2, %and228
  %gep820.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.1.2
  %xor452.2.2 = xor i32 %add451.2, %add446.2
  %mul453.2.2 = shl nuw nsw i32 %xor452.2.2, 3
  %add454.2.2 = or disjoint i32 %mul453.2.2, %add441.2
  %add457.2.2 = or disjoint i32 %add454.2.2, %and228
  %gep820.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.2.2
  %xor452.3.2 = xor i32 %add451.3, %add446.2
  %mul453.3.2 = shl nuw nsw i32 %xor452.3.2, 3
  %add454.3.2 = or disjoint i32 %mul453.3.2, %add441.3
  %add457.3.2 = or disjoint i32 %add454.3.2, %and228
  %gep820.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.3.2
  %add446.3 = or disjoint i32 %shr445, 6
  %xor452.3946 = xor i32 %mul450, %add446.3
  %mul453.3947 = shl nuw nsw i32 %xor452.3946, 3
  %add454.3948 = or disjoint i32 %mul453.3947, %mul439
  %add457.3949 = or disjoint i32 %add454.3948, %and228
  %gep820.3950 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.3949
  %xor452.1.3 = xor i32 %add451.1, %add446.3
  %mul453.1.3 = shl nuw nsw i32 %xor452.1.3, 3
  %add454.1.3 = or disjoint i32 %mul453.1.3, %add441.1
  %add457.1.3 = or disjoint i32 %add454.1.3, %and228
  %gep820.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.1.3
  %xor452.2.3 = xor i32 %add451.2, %add446.3
  %mul453.2.3 = shl nuw nsw i32 %xor452.2.3, 3
  %add454.2.3 = or disjoint i32 %mul453.2.3, %add441.2
  %add457.2.3 = or disjoint i32 %add454.2.3, %and228
  %gep820.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.2.3
  %xor452.3.3 = xor i32 %add451.3, %add446.3
  %mul453.3.3 = shl nuw nsw i32 %xor452.3.3, 3
  %add454.3.3 = or disjoint i32 %mul453.3.3, %add441.3
  %add457.3.3 = or disjoint i32 %add454.3.3, %and228
  %gep820.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add457.3.3
  br label %for.body150

for.body150:                                      ; preds = %if.end489.1, %if.end
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end489.1 ]
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end489.1 ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end489.1 ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end489.1 ]
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end489.1 ]
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end489.1 ]
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end489.1 ]
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end489.1 ]
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end489.1 ]
  %s_1.0824 = phi i32 [ 0, %if.end ], [ %inc491.1, %if.end489.1 ]
  %58 = phi <2 x i16> [ %38, %if.end ], [ %202, %if.end489.1 ]
  %59 = phi <2 x i16> [ %39, %if.end ], [ %203, %if.end489.1 ]
  %60 = phi <2 x i16> [ %40, %if.end ], [ %204, %if.end489.1 ]
  %61 = phi <2 x i16> [ %41, %if.end ], [ %205, %if.end489.1 ]
  %62 = phi <2 x i16> [ %42, %if.end ], [ %206, %if.end489.1 ]
  %63 = phi <2 x i16> [ %43, %if.end ], [ %207, %if.end489.1 ]
  %64 = phi <2 x i16> [ %44, %if.end ], [ %208, %if.end489.1 ]
  %65 = phi <2 x i16> [ %45, %if.end ], [ %209, %if.end489.1 ]
  %66 = phi <2 x i16> [ %46, %if.end ], [ %210, %if.end489.1 ]
  %67 = phi <2 x i16> [ %47, %if.end ], [ %211, %if.end489.1 ]
  %68 = phi <2 x i16> [ %48, %if.end ], [ %212, %if.end489.1 ]
  %69 = phi <2 x i16> [ %49, %if.end ], [ %213, %if.end489.1 ]
  %70 = phi <2 x i16> [ %50, %if.end ], [ %214, %if.end489.1 ]
  %71 = phi <2 x i16> [ %51, %if.end ], [ %215, %if.end489.1 ]
  %72 = phi <2 x i16> [ %52, %if.end ], [ %216, %if.end489.1 ]
  %73 = phi <2 x i16> [ %53, %if.end ], [ %217, %if.end489.1 ]
  %arrayidx152 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0824
  %74 = load i32, ptr addrspace(5) %arrayidx152, align 4, !tbaa !30
  %or.cond836 = icmp ugt i32 %74, 31
  %cmp159.not = icmp sgt i32 %74, %shr41
  %or.cond837 = or i1 %or.cond836, %cmp159.not
  br i1 %or.cond837, label %if.then319, label %for.body164.preheader

for.body164.preheader:                            ; preds = %for.body150
  store <2 x i16> %66, ptr addrspace(3) %invariant.gep798, align 16
  store <2 x i16> %67, ptr addrspace(3) %k.sroa.7.0.invariant.gep798.sroa_idx, align 4
  store <2 x i16> %68, ptr addrspace(3) %k.sroa.11.0.invariant.gep798.sroa_idx, align 8
  store <2 x i16> %69, ptr addrspace(3) %k.sroa.15.0.invariant.gep798.sroa_idx, align 4
  store <2 x i16> %70, ptr addrspace(3) %gep799.1, align 16
  store <2 x i16> %71, ptr addrspace(3) %k.sroa.24.16.gep799.1.sroa_idx, align 4
  store <2 x i16> %72, ptr addrspace(3) %k.sroa.28.16.gep799.1.sroa_idx, align 8
  store <2 x i16> %73, ptr addrspace(3) %k.sroa.32.16.gep799.1.sroa_idx, align 4
  %mul186 = shl nuw nsw i32 %74, 4
  %add187 = or disjoint i32 %mul186, 15
  %cmp188 = icmp ult i32 %1, %add187
  br i1 %cmp188, label %for.cond190.preheader, label %if.end215

for.cond190.preheader:                            ; preds = %for.body164.preheader
  %add198 = add nuw nsw i32 %mul186, %mul197
  %cmp201.not = icmp ugt i32 %add198, %1
  %spec.select = select i1 %cmp201.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert977 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp201.not.1.not = icmp ult i32 %add198, %1
  %spec.select.1 = select i1 %cmp201.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert984 = insertelement <4 x float> %scores.sroa.0.0.vec.insert977, float %spec.select.1, i64 1
  %add199.2 = or disjoint i32 %add198, 2
  %cmp201.not.2 = icmp ugt i32 %add199.2, %1
  %spec.select.2 = select i1 %cmp201.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert991 = insertelement <4 x float> %scores.sroa.0.4.vec.insert984, float %spec.select.2, i64 2
  %add199.3 = or disjoint i32 %add198, 3
  %cmp201.not.3 = icmp ugt i32 %add199.3, %1
  %spec.select.3 = select i1 %cmp201.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert998 = insertelement <4 x float> %scores.sroa.0.8.vec.insert991, float %spec.select.3, i64 3
  br label %if.end215

if.end215:                                        ; preds = %for.body164.preheader, %for.cond190.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert998, %for.cond190.preheader ], [ zeroinitializer, %for.body164.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr233, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr233.sroa_idx, align 8
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !call_argsrelate !86
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %75), !call_argsrelate !86
  %kb.sroa.0.0.copyload967 = load <4 x half>, ptr addrspace(3) %add.ptr233.1, align 16
  %kb.sroa.6.0.copyload968 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr233.1.sroa_idx, align 8
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload967, <4 x half> %q.sroa.5.16.copyload, <4 x float> %76), !call_argsrelate !86
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload968, <4 x half> %q.sroa.7.16.copyload, <4 x float> %77), !call_argsrelate !86
  store <2 x i16> %58, ptr addrspace(3) %invariant.gep810, align 16
  store <2 x i16> %59, ptr addrspace(3) %v.sroa.7.0.invariant.gep810.sroa_idx, align 4
  store <2 x i16> %60, ptr addrspace(3) %v.sroa.11.0.invariant.gep810.sroa_idx, align 8
  store <2 x i16> %61, ptr addrspace(3) %v.sroa.15.0.invariant.gep810.sroa_idx, align 4
  store <2 x i16> %62, ptr addrspace(3) %gep.1, align 16
  store <2 x i16> %63, ptr addrspace(3) %v.sroa.24.16.gep.1.sroa_idx, align 4
  store <2 x i16> %64, ptr addrspace(3) %v.sroa.28.16.gep.1.sroa_idx, align 8
  store <2 x i16> %65, ptr addrspace(3) %v.sroa.32.16.gep.1.sroa_idx, align 4
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %78, i64 0
  %mul290 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul290, float 0x4024CB5EC0000000)
  %80 = tail call contract noundef float @llvm.exp.f32(float %79)
  %add299 = fadd contract float %partial_sum.sroa.0.0, %80
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %78, i64 1
  %mul290.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %81 = tail call contract noundef float @llvm.minnum.f32(float %mul290.1, float 0x4024CB5EC0000000)
  %82 = tail call contract noundef float @llvm.exp.f32(float %81)
  %add299.1 = fadd contract float %partial_sum.sroa.6.0, %82
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %78, i64 2
  %mul290.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %83 = tail call contract noundef float @llvm.minnum.f32(float %mul290.2, float 0x4024CB5EC0000000)
  %84 = tail call contract noundef float @llvm.exp.f32(float %83)
  %add299.2 = fadd contract float %partial_sum.sroa.10.0, %84
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %78, i64 3
  %mul290.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %85 = tail call contract noundef float @llvm.minnum.f32(float %mul290.3, float 0x4024CB5EC0000000)
  %86 = tail call contract noundef float @llvm.exp.f32(float %85)
  %add299.3 = fadd contract float %partial_sum.sroa.14.0, %86
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80)
  %88 = insertelement <4 x i16> poison, i16 %87, i64 0
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %82)
  %90 = insertelement <4 x i16> %88, i16 %89, i64 1
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %84)
  %92 = insertelement <4 x i16> %90, i16 %91, i64 2
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %86)
  %94 = insertelement <4 x i16> %92, i16 %93, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %94 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.then319

if.then319:                                       ; preds = %for.body150, %if.end215
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body150 ], [ %add299.3, %if.end215 ]
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body150 ], [ %add299.2, %if.end215 ]
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body150 ], [ %add299.1, %if.end215 ]
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body150 ], [ %add299, %if.end215 ]
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body150 ], [ %prob.sroa.0.6.vec.insert, %if.end215 ]
  %add320 = or disjoint i32 %s_1.0824, 1
  %arrayidx322 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add320
  %95 = load i32, ptr addrspace(5) %arrayidx322, align 4, !tbaa !30
  %or.cond838 = icmp ugt i32 %95, 31
  %cmp329.not = icmp sgt i32 %95, %shr41
  %or.cond839 = or i1 %or.cond838, %cmp329.not
  br i1 %or.cond839, label %if.end420, label %for.cond331.preheader

for.cond331.preheader:                            ; preds = %if.then319
  %mul346 = shl nuw nsw i32 %95, 10
  %add349 = add nuw nsw i32 %add347, %mul346
  %96 = zext nneg i32 %add349 to i64
  %arrayidx357 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %96
  %97 = load <2 x i16>, ptr addrspace(4) %arrayidx357, align 2, !tbaa !57
  %98 = or disjoint i64 %96, 2
  %arrayidx357.1899 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %98
  %99 = load <2 x i16>, ptr addrspace(4) %arrayidx357.1899, align 2, !tbaa !57
  %100 = or disjoint i64 %96, 4
  %arrayidx357.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %100
  %101 = load <2 x i16>, ptr addrspace(4) %arrayidx357.2, align 2, !tbaa !57
  %102 = or disjoint i64 %96, 6
  %arrayidx357.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %102
  %103 = load <2 x i16>, ptr addrspace(4) %arrayidx357.3, align 2, !tbaa !57
  %104 = add nuw nsw i64 %96, 512
  %arrayidx357.1906 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %104
  %105 = load <2 x i16>, ptr addrspace(4) %arrayidx357.1906, align 2, !tbaa !57
  %106 = add nuw nsw i64 %96, 514
  %arrayidx357.1899.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %106
  %107 = load <2 x i16>, ptr addrspace(4) %arrayidx357.1899.1, align 2, !tbaa !57
  %108 = add nuw nsw i64 %96, 516
  %arrayidx357.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %108
  %109 = load <2 x i16>, ptr addrspace(4) %arrayidx357.2.1, align 2, !tbaa !57
  %110 = add nuw nsw i64 %96, 518
  %arrayidx357.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %110
  %111 = load <2 x i16>, ptr addrspace(4) %arrayidx357.3.1, align 2, !tbaa !57
  %arrayidx401 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %96
  %112 = load <2 x i16>, ptr addrspace(4) %arrayidx401, align 2, !tbaa !57
  %arrayidx401.1920 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %98
  %113 = load <2 x i16>, ptr addrspace(4) %arrayidx401.1920, align 2, !tbaa !57
  %arrayidx401.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %100
  %114 = load <2 x i16>, ptr addrspace(4) %arrayidx401.2, align 2, !tbaa !57
  %arrayidx401.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %102
  %115 = load <2 x i16>, ptr addrspace(4) %arrayidx401.3, align 2, !tbaa !57
  %arrayidx401.1927 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %104
  %116 = load <2 x i16>, ptr addrspace(4) %arrayidx401.1927, align 2, !tbaa !57
  %arrayidx401.1920.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %106
  %117 = load <2 x i16>, ptr addrspace(4) %arrayidx401.1920.1, align 2, !tbaa !57
  %arrayidx401.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %108
  %118 = load <2 x i16>, ptr addrspace(4) %arrayidx401.2.1, align 2, !tbaa !57
  %arrayidx401.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %110
  %119 = load <2 x i16>, ptr addrspace(4) %arrayidx401.3.1, align 2, !tbaa !57
  br label %if.end420

if.end420:                                        ; preds = %for.cond331.preheader, %if.then319
  %120 = phi <2 x i16> [ %58, %if.then319 ], [ %112, %for.cond331.preheader ]
  %121 = phi <2 x i16> [ %59, %if.then319 ], [ %113, %for.cond331.preheader ]
  %122 = phi <2 x i16> [ %60, %if.then319 ], [ %114, %for.cond331.preheader ]
  %123 = phi <2 x i16> [ %61, %if.then319 ], [ %115, %for.cond331.preheader ]
  %124 = phi <2 x i16> [ %62, %if.then319 ], [ %116, %for.cond331.preheader ]
  %125 = phi <2 x i16> [ %63, %if.then319 ], [ %117, %for.cond331.preheader ]
  %126 = phi <2 x i16> [ %64, %if.then319 ], [ %118, %for.cond331.preheader ]
  %127 = phi <2 x i16> [ %65, %if.then319 ], [ %119, %for.cond331.preheader ]
  %128 = phi <2 x i16> [ %66, %if.then319 ], [ %97, %for.cond331.preheader ]
  %129 = phi <2 x i16> [ %67, %if.then319 ], [ %99, %for.cond331.preheader ]
  %130 = phi <2 x i16> [ %68, %if.then319 ], [ %101, %for.cond331.preheader ]
  %131 = phi <2 x i16> [ %69, %if.then319 ], [ %103, %for.cond331.preheader ]
  %132 = phi <2 x i16> [ %70, %if.then319 ], [ %105, %for.cond331.preheader ]
  %133 = phi <2 x i16> [ %71, %if.then319 ], [ %107, %for.cond331.preheader ]
  %134 = phi <2 x i16> [ %72, %if.then319 ], [ %109, %for.cond331.preheader ]
  %135 = phi <2 x i16> [ %73, %if.then319 ], [ %111, %for.cond331.preheader ]
  br i1 %or.cond837, label %if.end489, label %for.cond433.preheader.preheader

for.cond433.preheader.preheader:                  ; preds = %if.end420
  %136 = load half, ptr addrspace(3) %gep820, align 2, !tbaa !57
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %136, i64 0
  %137 = load half, ptr addrspace(3) %gep820.1, align 2, !tbaa !57
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %137, i64 1
  %138 = load half, ptr addrspace(3) %gep820.2, align 2, !tbaa !57
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %138, i64 2
  %139 = load half, ptr addrspace(3) %gep820.3, align 2, !tbaa !57
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %139, i64 3
  %140 = load half, ptr addrspace(3) %gep820.1938, align 2, !tbaa !57
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %140, i64 0
  %141 = load half, ptr addrspace(3) %gep820.1.1, align 2, !tbaa !57
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %141, i64 1
  %142 = load half, ptr addrspace(3) %gep820.2.1, align 2, !tbaa !57
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %142, i64 2
  %143 = load half, ptr addrspace(3) %gep820.3.1, align 2, !tbaa !57
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %143, i64 3
  %144 = load half, ptr addrspace(3) %gep820.2944, align 2, !tbaa !57
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %144, i64 0
  %145 = load half, ptr addrspace(3) %gep820.1.2, align 2, !tbaa !57
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %145, i64 1
  %146 = load half, ptr addrspace(3) %gep820.2.2, align 2, !tbaa !57
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %146, i64 2
  %147 = load half, ptr addrspace(3) %gep820.3.2, align 2, !tbaa !57
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %147, i64 3
  %148 = load half, ptr addrspace(3) %gep820.3950, align 2, !tbaa !57
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %148, i64 0
  %149 = load half, ptr addrspace(3) %gep820.1.3, align 2, !tbaa !57
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %149, i64 1
  %150 = load half, ptr addrspace(3) %gep820.2.3, align 2, !tbaa !57
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %150, i64 2
  %151 = load half, ptr addrspace(3) %gep820.3.3, align 2, !tbaa !57
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %151, i64 3
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0)
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0)
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0)
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0)
  br label %if.end489

if.end489:                                        ; preds = %for.cond433.preheader.preheader, %if.end420
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end420 ], [ %155, %for.cond433.preheader.preheader ]
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end420 ], [ %154, %for.cond433.preheader.preheader ]
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end420 ], [ %153, %for.cond433.preheader.preheader ]
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end420 ], [ %152, %for.cond433.preheader.preheader ]
  %inc491 = or disjoint i32 %s_1.0824, 1
  %arrayidx152.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc491
  %156 = load i32, ptr addrspace(5) %arrayidx152.1, align 4, !tbaa !30
  %or.cond836.1 = icmp ugt i32 %156, 31
  %cmp159.not.1 = icmp sgt i32 %156, %shr41
  %or.cond837.1 = or i1 %or.cond836.1, %cmp159.not.1
  br i1 %or.cond837.1, label %if.end317.1, label %for.body164.preheader.1

for.body164.preheader.1:                          ; preds = %if.end489
  store <2 x i16> %128, ptr addrspace(3) %invariant.gep798, align 16
  store <2 x i16> %129, ptr addrspace(3) %k.sroa.7.0.invariant.gep798.sroa_idx, align 4
  store <2 x i16> %130, ptr addrspace(3) %k.sroa.11.0.invariant.gep798.sroa_idx, align 8
  store <2 x i16> %131, ptr addrspace(3) %k.sroa.15.0.invariant.gep798.sroa_idx, align 4
  store <2 x i16> %132, ptr addrspace(3) %gep799.1, align 16
  store <2 x i16> %133, ptr addrspace(3) %k.sroa.24.16.gep799.1.sroa_idx, align 4
  store <2 x i16> %134, ptr addrspace(3) %k.sroa.28.16.gep799.1.sroa_idx, align 8
  store <2 x i16> %135, ptr addrspace(3) %k.sroa.32.16.gep799.1.sroa_idx, align 4
  %mul186.1 = shl nuw nsw i32 %156, 4
  %add187.1 = or disjoint i32 %mul186.1, 15
  %cmp188.1 = icmp ult i32 %1, %add187.1
  br i1 %cmp188.1, label %for.cond190.preheader.1, label %if.end215.1

for.cond190.preheader.1:                          ; preds = %for.body164.preheader.1
  %add198.1 = add nuw nsw i32 %mul186.1, %mul197
  %cmp201.not.1 = icmp ugt i32 %add198.1, %1
  %spec.select.11093 = select i1 %cmp201.not.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert977.1 = insertelement <4 x float> poison, float %spec.select.11093, i64 0
  %cmp201.not.1.not.1 = icmp ult i32 %add198.1, %1
  %spec.select.1.1 = select i1 %cmp201.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert984.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert977.1, float %spec.select.1.1, i64 1
  %add199.2.1 = or disjoint i32 %add198.1, 2
  %cmp201.not.2.1 = icmp ugt i32 %add199.2.1, %1
  %spec.select.2.1 = select i1 %cmp201.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert991.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert984.1, float %spec.select.2.1, i64 2
  %add199.3.1 = or disjoint i32 %add198.1, 3
  %cmp201.not.3.1 = icmp ugt i32 %add199.3.1, %1
  %spec.select.3.1 = select i1 %cmp201.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert998.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert991.1, float %spec.select.3.1, i64 3
  br label %if.end215.1

if.end215.1:                                      ; preds = %for.cond190.preheader.1, %for.body164.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert998.1, %for.cond190.preheader.1 ], [ zeroinitializer, %for.body164.preheader.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr233, align 16
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr233.sroa_idx, align 8
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !call_argsrelate !86
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %157), !call_argsrelate !86
  %kb.sroa.0.0.copyload967.1 = load <4 x half>, ptr addrspace(3) %add.ptr233.1, align 16
  %kb.sroa.6.0.copyload968.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr233.1.sroa_idx, align 8
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload967.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %158), !call_argsrelate !86
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload968.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %159), !call_argsrelate !86
  store <2 x i16> %120, ptr addrspace(3) %invariant.gep810, align 16
  store <2 x i16> %121, ptr addrspace(3) %v.sroa.7.0.invariant.gep810.sroa_idx, align 4
  store <2 x i16> %122, ptr addrspace(3) %v.sroa.11.0.invariant.gep810.sroa_idx, align 8
  store <2 x i16> %123, ptr addrspace(3) %v.sroa.15.0.invariant.gep810.sroa_idx, align 4
  store <2 x i16> %124, ptr addrspace(3) %gep.1, align 16
  store <2 x i16> %125, ptr addrspace(3) %v.sroa.24.16.gep.1.sroa_idx, align 4
  store <2 x i16> %126, ptr addrspace(3) %v.sroa.28.16.gep.1.sroa_idx, align 8
  store <2 x i16> %127, ptr addrspace(3) %v.sroa.32.16.gep.1.sroa_idx, align 4
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %160, i64 0
  %mul290.11094 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000
  %161 = tail call contract noundef float @llvm.minnum.f32(float %mul290.11094, float 0x4024CB5EC0000000)
  %162 = tail call contract noundef float @llvm.exp.f32(float %161)
  %add299.11095 = fadd contract float %partial_sum.sroa.0.1, %162
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %160, i64 1
  %mul290.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul290.1.1, float 0x4024CB5EC0000000)
  %164 = tail call contract noundef float @llvm.exp.f32(float %163)
  %add299.1.1 = fadd contract float %partial_sum.sroa.6.1, %164
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %160, i64 2
  %mul290.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul290.2.1, float 0x4024CB5EC0000000)
  %166 = tail call contract noundef float @llvm.exp.f32(float %165)
  %add299.2.1 = fadd contract float %partial_sum.sroa.10.1, %166
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %160, i64 3
  %mul290.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000
  %167 = tail call contract noundef float @llvm.minnum.f32(float %mul290.3.1, float 0x4024CB5EC0000000)
  %168 = tail call contract noundef float @llvm.exp.f32(float %167)
  %add299.3.1 = fadd contract float %partial_sum.sroa.14.1, %168
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %162)
  %170 = insertelement <4 x i16> poison, i16 %169, i64 0
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164)
  %172 = insertelement <4 x i16> %170, i16 %171, i64 1
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166)
  %174 = insertelement <4 x i16> %172, i16 %173, i64 2
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %168)
  %176 = insertelement <4 x i16> %174, i16 %175, i64 3
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %176 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end317.1

if.end317.1:                                      ; preds = %if.end215.1, %if.end489
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end489 ], [ %add299.3.1, %if.end215.1 ]
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end489 ], [ %add299.2.1, %if.end215.1 ]
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end489 ], [ %add299.1.1, %if.end215.1 ]
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end489 ], [ %add299.11095, %if.end215.1 ]
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end489 ], [ %prob.sroa.0.6.vec.insert.1, %if.end215.1 ]
  %cmp318.not.1 = icmp eq i32 %s_1.0824, 2
  br i1 %cmp318.not.1, label %if.end420.1, label %if.then319.1

if.then319.1:                                     ; preds = %if.end317.1
  %add320.1 = add nuw nsw i32 %s_1.0824, 2
  %arrayidx322.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add320.1
  %177 = load i32, ptr addrspace(5) %arrayidx322.1, align 4, !tbaa !30
  %or.cond838.1 = icmp ugt i32 %177, 31
  %cmp329.not.1 = icmp sgt i32 %177, %shr41
  %or.cond839.1 = or i1 %or.cond838.1, %cmp329.not.1
  br i1 %or.cond839.1, label %if.end420.1, label %for.cond331.preheader.1

for.cond331.preheader.1:                          ; preds = %if.then319.1
  %mul346.1 = shl nuw nsw i32 %177, 10
  %add349.1 = add nuw nsw i32 %add347, %mul346.1
  %178 = zext nneg i32 %add349.1 to i64
  %arrayidx357.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %178
  %179 = load <2 x i16>, ptr addrspace(4) %arrayidx357.1, align 2, !tbaa !57
  %180 = or disjoint i64 %178, 2
  %arrayidx357.1899.11096 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %180
  %181 = load <2 x i16>, ptr addrspace(4) %arrayidx357.1899.11096, align 2, !tbaa !57
  %182 = or disjoint i64 %178, 4
  %arrayidx357.2.11097 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %182
  %183 = load <2 x i16>, ptr addrspace(4) %arrayidx357.2.11097, align 2, !tbaa !57
  %184 = or disjoint i64 %178, 6
  %arrayidx357.3.11098 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %184
  %185 = load <2 x i16>, ptr addrspace(4) %arrayidx357.3.11098, align 2, !tbaa !57
  %186 = add nuw nsw i64 %178, 512
  %arrayidx357.1906.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %186
  %187 = load <2 x i16>, ptr addrspace(4) %arrayidx357.1906.1, align 2, !tbaa !57
  %188 = add nuw nsw i64 %178, 514
  %arrayidx357.1899.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %188
  %189 = load <2 x i16>, ptr addrspace(4) %arrayidx357.1899.1.1, align 2, !tbaa !57
  %190 = add nuw nsw i64 %178, 516
  %arrayidx357.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %190
  %191 = load <2 x i16>, ptr addrspace(4) %arrayidx357.2.1.1, align 2, !tbaa !57
  %192 = add nuw nsw i64 %178, 518
  %arrayidx357.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %192
  %193 = load <2 x i16>, ptr addrspace(4) %arrayidx357.3.1.1, align 2, !tbaa !57
  %arrayidx401.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %178
  %194 = load <2 x i16>, ptr addrspace(4) %arrayidx401.1, align 2, !tbaa !57
  %arrayidx401.1920.11099 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %180
  %195 = load <2 x i16>, ptr addrspace(4) %arrayidx401.1920.11099, align 2, !tbaa !57
  %arrayidx401.2.11100 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %182
  %196 = load <2 x i16>, ptr addrspace(4) %arrayidx401.2.11100, align 2, !tbaa !57
  %arrayidx401.3.11101 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %184
  %197 = load <2 x i16>, ptr addrspace(4) %arrayidx401.3.11101, align 2, !tbaa !57
  %arrayidx401.1927.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %186
  %198 = load <2 x i16>, ptr addrspace(4) %arrayidx401.1927.1, align 2, !tbaa !57
  %arrayidx401.1920.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %188
  %199 = load <2 x i16>, ptr addrspace(4) %arrayidx401.1920.1.1, align 2, !tbaa !57
  %arrayidx401.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %190
  %200 = load <2 x i16>, ptr addrspace(4) %arrayidx401.2.1.1, align 2, !tbaa !57
  %arrayidx401.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %192
  %201 = load <2 x i16>, ptr addrspace(4) %arrayidx401.3.1.1, align 2, !tbaa !57
  br label %if.end420.1

if.end420.1:                                      ; preds = %for.cond331.preheader.1, %if.then319.1, %if.end317.1
  %202 = phi <2 x i16> [ %120, %if.end317.1 ], [ %120, %if.then319.1 ], [ %194, %for.cond331.preheader.1 ]
  %203 = phi <2 x i16> [ %121, %if.end317.1 ], [ %121, %if.then319.1 ], [ %195, %for.cond331.preheader.1 ]
  %204 = phi <2 x i16> [ %122, %if.end317.1 ], [ %122, %if.then319.1 ], [ %196, %for.cond331.preheader.1 ]
  %205 = phi <2 x i16> [ %123, %if.end317.1 ], [ %123, %if.then319.1 ], [ %197, %for.cond331.preheader.1 ]
  %206 = phi <2 x i16> [ %124, %if.end317.1 ], [ %124, %if.then319.1 ], [ %198, %for.cond331.preheader.1 ]
  %207 = phi <2 x i16> [ %125, %if.end317.1 ], [ %125, %if.then319.1 ], [ %199, %for.cond331.preheader.1 ]
  %208 = phi <2 x i16> [ %126, %if.end317.1 ], [ %126, %if.then319.1 ], [ %200, %for.cond331.preheader.1 ]
  %209 = phi <2 x i16> [ %127, %if.end317.1 ], [ %127, %if.then319.1 ], [ %201, %for.cond331.preheader.1 ]
  %210 = phi <2 x i16> [ %128, %if.end317.1 ], [ %128, %if.then319.1 ], [ %179, %for.cond331.preheader.1 ]
  %211 = phi <2 x i16> [ %129, %if.end317.1 ], [ %129, %if.then319.1 ], [ %181, %for.cond331.preheader.1 ]
  %212 = phi <2 x i16> [ %130, %if.end317.1 ], [ %130, %if.then319.1 ], [ %183, %for.cond331.preheader.1 ]
  %213 = phi <2 x i16> [ %131, %if.end317.1 ], [ %131, %if.then319.1 ], [ %185, %for.cond331.preheader.1 ]
  %214 = phi <2 x i16> [ %132, %if.end317.1 ], [ %132, %if.then319.1 ], [ %187, %for.cond331.preheader.1 ]
  %215 = phi <2 x i16> [ %133, %if.end317.1 ], [ %133, %if.then319.1 ], [ %189, %for.cond331.preheader.1 ]
  %216 = phi <2 x i16> [ %134, %if.end317.1 ], [ %134, %if.then319.1 ], [ %191, %for.cond331.preheader.1 ]
  %217 = phi <2 x i16> [ %135, %if.end317.1 ], [ %135, %if.then319.1 ], [ %193, %for.cond331.preheader.1 ]
  br i1 %or.cond837.1, label %if.end489.1, label %for.cond433.preheader.preheader.1

for.cond433.preheader.preheader.1:                ; preds = %if.end420.1
  %218 = load half, ptr addrspace(3) %gep820, align 2, !tbaa !57
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %218, i64 0
  %219 = load half, ptr addrspace(3) %gep820.1, align 2, !tbaa !57
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %219, i64 1
  %220 = load half, ptr addrspace(3) %gep820.2, align 2, !tbaa !57
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %220, i64 2
  %221 = load half, ptr addrspace(3) %gep820.3, align 2, !tbaa !57
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %221, i64 3
  %222 = load half, ptr addrspace(3) %gep820.1938, align 2, !tbaa !57
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %222, i64 0
  %223 = load half, ptr addrspace(3) %gep820.1.1, align 2, !tbaa !57
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %223, i64 1
  %224 = load half, ptr addrspace(3) %gep820.2.1, align 2, !tbaa !57
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %224, i64 2
  %225 = load half, ptr addrspace(3) %gep820.3.1, align 2, !tbaa !57
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %225, i64 3
  %226 = load half, ptr addrspace(3) %gep820.2944, align 2, !tbaa !57
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %226, i64 0
  %227 = load half, ptr addrspace(3) %gep820.1.2, align 2, !tbaa !57
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %227, i64 1
  %228 = load half, ptr addrspace(3) %gep820.2.2, align 2, !tbaa !57
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %228, i64 2
  %229 = load half, ptr addrspace(3) %gep820.3.2, align 2, !tbaa !57
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %229, i64 3
  %230 = load half, ptr addrspace(3) %gep820.3950, align 2, !tbaa !57
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %230, i64 0
  %231 = load half, ptr addrspace(3) %gep820.1.3, align 2, !tbaa !57
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %231, i64 1
  %232 = load half, ptr addrspace(3) %gep820.2.3, align 2, !tbaa !57
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %232, i64 2
  %233 = load half, ptr addrspace(3) %gep820.3.3, align 2, !tbaa !57
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %233, i64 3
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1)
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1)
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1)
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1)
  br label %if.end489.1

if.end489.1:                                      ; preds = %for.cond433.preheader.preheader.1, %if.end420.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end420.1 ], [ %237, %for.cond433.preheader.preheader.1 ]
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end420.1 ], [ %236, %for.cond433.preheader.preheader.1 ]
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end420.1 ], [ %235, %for.cond433.preheader.preheader.1 ]
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end420.1 ], [ %234, %for.cond433.preheader.preheader.1 ]
  %inc491.1 = add nuw nsw i32 %s_1.0824, 2
  %exitcond.not.1 = icmp eq i32 %inc491.1, 4
  br i1 %exitcond.not.1, label %for.body497.preheader, label %for.body150, !llvm.loop !129

for.body497.preheader:                            ; preds = %if.end489.1
  %add501 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00
  %add501.1 = fadd contract float %add501, %partial_sum.sroa.6.1.1
  %add501.2 = fadd contract float %add501.1, %partial_sum.sroa.10.1.1
  %add501.3 = fadd contract float %add501.2, %partial_sum.sroa.14.1.1
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add501.3, <4 x float> zeroinitializer)
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %238, i64 0
  %cmp519 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  br i1 %cmp519, label %if.then520, label %if.end535

if.then520:                                       ; preds = %for.body497.preheader
  %239 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32
  %sub = sub i32 2129859011, %239
  %240 = bitcast i32 %sub to float
  %mul523 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %240
  %sub524 = fsub contract float 2.000000e+00, %mul523
  %mul525 = fmul contract float %sub524, %240
  %mul531 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul525
  %sub532 = fsub contract float 2.000000e+00, %mul531
  %mul533 = fmul contract float %mul525, %sub532
  br label %if.end535

if.end535:                                        ; preds = %for.body497.preheader, %if.then520
  %condval_1.0 = phi float [ %mul533, %if.then520 ], [ 0.000000e+00, %for.body497.preheader ]
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0
  %mul544 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1
  %mul544.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2
  %mul544.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3
  %mul544.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0
  %mul544.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1
  %mul544.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2
  %mul544.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3
  %mul544.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0
  %mul544.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1
  %mul544.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2
  %mul544.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3
  %mul544.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0
  %mul544.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1
  %mul544.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2
  %mul544.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3
  %mul544.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract
  %241 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544)
  %result.sroa.0.0.insert.ext = zext i16 %241 to i64
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.1)
  %result.sroa.0.2.insert.ext = zext i16 %242 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.2)
  %result.sroa.0.4.insert.ext = zext i16 %243 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.3)
  %result.sroa.0.6.insert.ext = zext i16 %244 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.4)
  %result.sroa.7.8.insert.ext = zext i16 %245 to i64
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.5)
  %result.sroa.7.10.insert.ext = zext i16 %246 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.6)
  %result.sroa.7.12.insert.ext = zext i16 %247 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.7)
  %result.sroa.7.14.insert.ext = zext i16 %248 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.8)
  %result.sroa.12.16.insert.ext = zext i16 %249 to i64
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.9)
  %result.sroa.12.18.insert.ext = zext i16 %250 to i64
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.10)
  %result.sroa.12.20.insert.ext = zext i16 %251 to i64
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.11)
  %result.sroa.12.22.insert.ext = zext i16 %252 to i64
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.12)
  %result.sroa.17.24.insert.ext = zext i16 %253 to i64
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.13)
  %result.sroa.17.26.insert.ext = zext i16 %254 to i64
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.14)
  %result.sroa.17.28.insert.ext = zext i16 %255 to i64
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul544.15)
  %result.sroa.17.30.insert.ext = zext i16 %256 to i64
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr586 = lshr i32 %2, 5
  %xor590 = xor i32 %shr586, %and228
  %mul591 = shl nuw nsw i32 %xor590, 3
  %add592 = add nuw nsw i32 %mul591, %mul9
  %add597 = or disjoint i32 %add592, %mul450
  %add.ptr599 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add597
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr599, align 8
  %add587.1 = add nuw nsw i32 %shr586, 2
  %xor590.1 = xor i32 %add587.1, %and228
  %mul591.1 = shl nuw nsw i32 %xor590.1, 3
  %add592.1 = add nuw nsw i32 %mul591.1, %mul9
  %add597.1 = or disjoint i32 %add592.1, %mul450
  %add.ptr599.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add597.1
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr599.1, align 8
  %add587.2 = add nuw nsw i32 %shr586, 4
  %xor590.2 = xor i32 %add587.2, %and228
  %mul591.2 = shl nuw nsw i32 %xor590.2, 3
  %add592.2 = add nuw nsw i32 %mul591.2, %mul9
  %add597.2 = or disjoint i32 %add592.2, %mul450
  %add.ptr599.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add597.2
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr599.2, align 8
  %add587.3 = add nuw nsw i32 %shr586, 6
  %xor590.3 = xor i32 %add587.3, %and228
  %mul591.3 = shl nuw nsw i32 %xor590.3, 3
  %add592.3 = add nuw nsw i32 %mul591.3, %mul9
  %add597.3 = or disjoint i32 %add592.3, %mul450
  %add.ptr599.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add597.3
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr599.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add627 = add nuw nsw i32 %add, %54
  %257 = zext nneg i32 %add627 to i64
  %add.ptr632 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %257
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr632, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep798, i64 16, i1 false), !tbaa.struct !174, !call_argsrelate !175
  %gep834.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep798, i32 1024
  %258 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %257
  %add.ptr632.1 = getelementptr inbounds i8, ptr addrspace(1) %258, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr632.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep834.1, i64 16, i1 false), !tbaa.struct !174, !call_argsrelate !175
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !call_argsrelate !43
  ret void
}

declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #5

declare i32 @llvm.mxc.block.id.x() #6

declare i32 @llvm.mxc.block.id.y() #6

declare i32 @llvm.mxc.block.id.z() #6

declare i32 @llvm.mxc.thread.id.x() #6

declare void @llvm.mxc.barrier.warp() #7

declare float @llvm.exp.f32(float) #8

declare i16 @llvm.convert.to.fp16.f32(float) #9

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #6

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #6

declare i1 @llvm.mxc.is.private(ptr nocapture) #6

declare void @llvm.mxc.sleep(i32 immarg) #10

declare float @llvm.minnum.f32(float, float) #8

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #11

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent nounwind willreturn memory(none) }
attributes #6 = { nounwind speculatable willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #10 = { nounwind willreturn }
attributes #11 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #12 = { nounwind }


