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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul10 = shl nsw i32 %1, 11
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 7
  %mul14 = and i32 %and, 896
  %3 = shl nuw nsw i32 %2, 2
  %mul20 = and i32 %3, 32
  %4 = lshr i32 %2, 1
  %mul24 = and i32 %4, 504
  %add21 = add nuw nsw i32 %mul, %mul10
  %5 = or disjoint i32 %mul14, %mul20
  %add12 = or disjoint i32 %5, %add21
  %add15 = add nuw nsw i32 %add12, %mul24
  %6 = zext nneg i32 %add15 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %q_words.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr, align 16, !tbaa !30
  %q_words.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 4
  %q_words.sroa.4.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.4.0.add.ptr.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q_words.sroa.5.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.5.0.add.ptr.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.6.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 12
  %q_words.sroa.6.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.6.0.add.ptr.sroa_idx, align 4, !tbaa !30
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2048
  %q_words.sroa.7.16.copyload = load i32, ptr addrspace(4) %add.ptr.1, align 16, !tbaa !30
  %q_words.sroa.9.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2052
  %q_words.sroa.9.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.9.16.add.ptr.1.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.10.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2056
  %q_words.sroa.10.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.10.16.add.ptr.1.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.11.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2060
  %q_words.sroa.11.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.11.16.add.ptr.1.sroa_idx, align 4, !tbaa !30
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.1679 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 128
  %q_words.sroa.12.32.copyload = load i32, ptr addrspace(4) %add.ptr.1679, align 16, !tbaa !30
  %q_words.sroa.14.32.add.ptr.1679.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 132
  %q_words.sroa.14.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.14.32.add.ptr.1679.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.15.32.add.ptr.1679.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 136
  %q_words.sroa.15.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.15.32.add.ptr.1679.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.16.32.add.ptr.1679.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 140
  %q_words.sroa.16.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.16.32.add.ptr.1679.sroa_idx, align 4, !tbaa !30
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.1.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2176
  %q_words.sroa.17.48.copyload = load i32, ptr addrspace(4) %add.ptr.1.1, align 16, !tbaa !30
  %q_words.sroa.19.48.add.ptr.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2180
  %q_words.sroa.19.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.19.48.add.ptr.1.1.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.20.48.add.ptr.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2184
  %q_words.sroa.20.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.20.48.add.ptr.1.1.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.21.48.add.ptr.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2188
  %q_words.sroa.21.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.21.48.add.ptr.1.1.sroa_idx, align 4, !tbaa !30
  %mul35 = shl nsw i32 %0, 10
  %add37 = add nuw nsw i32 %mul35, %1
  %idxprom = zext nneg i32 %add37 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %10 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp38 = icmp sgt i32 %10, -1
  br i1 %cmp38, label %land.lhs.true, label %land.end

land.lhs.true:                                    ; preds = %entry
  %cmp39 = icmp ult i32 %10, 32
  %mul40 = shl nsw i32 %10, 5
  %cmp42 = icmp sle i32 %mul40, %1
  %spec.select = select i1 %cmp39, i1 %cmp42, i1 false
  br label %land.end

land.end:                                         ; preds = %land.lhs.true, %entry
  %11 = phi i1 [ false, %entry ], [ %spec.select, %land.lhs.true ]
  br i1 %11, label %for.cond43.preheader, label %land.end.if.end313_crit_edge

land.end.if.end313_crit_edge:                     ; preds = %land.end
  %.pre = lshr i32 %2, 2
  %.pre1085 = shl nuw nsw i32 %2, 3
  %.pre1087 = zext nneg i32 %0 to i64
  %.pre1088 = shl nuw nsw i64 %.pre1087, 18
  %.pre1089 = sext i32 %10 to i64
  %.pre1090 = shl nsw i64 %.pre1089, 13
  %.pre1091 = add nsw i64 %.pre1090, %.pre1088
  %.pre1092 = zext nneg i32 %.pre1085 to i64
  br label %if.end313

for.cond43.preheader:                             ; preds = %land.end
  %conv = zext nneg i32 %0 to i64
  %conv49 = sext i32 %10 to i64
  %12 = shl nuw nsw i32 %2, 3
  %mul57 = zext nneg i32 %12 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul57
  %.idx665 = shl nsw i64 %conv49, 14
  %13 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx665
  %.idx666 = shl nuw nsw i64 %conv, 19
  %14 = getelementptr i8, ptr addrspace(4) %13, i64 %.idx666
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %14, align 16
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %14, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8
  %gep.1 = getelementptr i8, ptr addrspace(4) %14, i64 1024
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 1032
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8
  %gep.2 = getelementptr i8, ptr addrspace(4) %14, i64 2048
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 2056
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8
  %gep.3 = getelementptr i8, ptr addrspace(4) %14, i64 3072
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 3080
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8
  %gep.4 = getelementptr i8, ptr addrspace(4) %14, i64 4096
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 4104
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8
  %gep.5 = getelementptr i8, ptr addrspace(4) %14, i64 5120
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 5128
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8
  %gep.6 = getelementptr i8, ptr addrspace(4) %14, i64 6144
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 6152
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8
  %gep.7 = getelementptr i8, ptr addrspace(4) %14, i64 7168
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 7176
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8
  %and85 = and i32 %2, 8
  %cmp86.not.not = icmp eq i32 %and85, 0
  %. = select i1 %cmp86.not.not, i32 %q_words.sroa.7.16.copyload, i32 %q_words.sroa.0.0.copyload
  %15 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %16 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %15) #11
  %xor.i.i = xor i32 %16, 8
  %17 = and i32 %16, -64
  %and.i.i = add nsw i32 %17, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %16
  %shl.i.i = shl i32 %cond.i.i, 2
  %18 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %.)
  %condval_1.0 = select i1 %cmp86.not.not, i32 %q_words.sroa.0.0.copyload, i32 %18
  %condval_2.0 = select i1 %cmp86.not.not, i32 %18, i32 %q_words.sroa.7.16.copyload
  %..1 = select i1 %cmp86.not.not, i32 %q_words.sroa.9.16.copyload, i32 %q_words.sroa.4.0.copyload
  %19 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %20 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %19) #11
  %xor.i.i.1 = xor i32 %20, 8
  %21 = and i32 %20, -64
  %and.i.i.1 = add nsw i32 %21, 64
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1
  %cond.i.i.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %20
  %shl.i.i.1 = shl i32 %cond.i.i.1, 2
  %22 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %..1)
  %condval_1.0.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.4.0.copyload, i32 %22
  %condval_2.0.1 = select i1 %cmp86.not.not, i32 %22, i32 %q_words.sroa.9.16.copyload
  %..2 = select i1 %cmp86.not.not, i32 %q_words.sroa.10.16.copyload, i32 %q_words.sroa.5.0.copyload
  %23 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %24 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %23) #11
  %xor.i.i.2 = xor i32 %24, 8
  %25 = and i32 %24, -64
  %and.i.i.2 = add nsw i32 %25, 64
  %cmp.not.i.i.2 = icmp slt i32 %xor.i.i.2, %and.i.i.2
  %cond.i.i.2 = select i1 %cmp.not.i.i.2, i32 %xor.i.i.2, i32 %24
  %shl.i.i.2 = shl i32 %cond.i.i.2, 2
  %26 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2, i32 %..2)
  %condval_1.0.2 = select i1 %cmp86.not.not, i32 %q_words.sroa.5.0.copyload, i32 %26
  %condval_2.0.2 = select i1 %cmp86.not.not, i32 %26, i32 %q_words.sroa.10.16.copyload
  %..3 = select i1 %cmp86.not.not, i32 %q_words.sroa.11.16.copyload, i32 %q_words.sroa.6.0.copyload
  %27 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %28 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %27) #11
  %xor.i.i.3 = xor i32 %28, 8
  %29 = and i32 %28, -64
  %and.i.i.3 = add nsw i32 %29, 64
  %cmp.not.i.i.3 = icmp slt i32 %xor.i.i.3, %and.i.i.3
  %cond.i.i.3 = select i1 %cmp.not.i.i.3, i32 %xor.i.i.3, i32 %28
  %shl.i.i.3 = shl i32 %cond.i.i.3, 2
  %30 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3, i32 %..3)
  %condval_1.0.3 = select i1 %cmp86.not.not, i32 %q_words.sroa.6.0.copyload, i32 %30
  %condval_2.0.3 = select i1 %cmp86.not.not, i32 %30, i32 %q_words.sroa.11.16.copyload
  %..1686 = select i1 %cmp86.not.not, i32 %q_words.sroa.17.48.copyload, i32 %q_words.sroa.12.32.copyload
  %31 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %32 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %31) #11
  %xor.i.i.1687 = xor i32 %32, 8
  %33 = and i32 %32, -64
  %and.i.i.1688 = add nsw i32 %33, 64
  %cmp.not.i.i.1689 = icmp slt i32 %xor.i.i.1687, %and.i.i.1688
  %cond.i.i.1690 = select i1 %cmp.not.i.i.1689, i32 %xor.i.i.1687, i32 %32
  %shl.i.i.1691 = shl i32 %cond.i.i.1690, 2
  %34 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1691, i32 %..1686)
  %condval_1.0.1692 = select i1 %cmp86.not.not, i32 %q_words.sroa.12.32.copyload, i32 %34
  %condval_2.0.1694 = select i1 %cmp86.not.not, i32 %34, i32 %q_words.sroa.17.48.copyload
  %..1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.19.48.copyload, i32 %q_words.sroa.14.32.copyload
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11
  %xor.i.i.1.1 = xor i32 %36, 8
  %37 = and i32 %36, -64
  %and.i.i.1.1 = add nsw i32 %37, 64
  %cmp.not.i.i.1.1 = icmp slt i32 %xor.i.i.1.1, %and.i.i.1.1
  %cond.i.i.1.1 = select i1 %cmp.not.i.i.1.1, i32 %xor.i.i.1.1, i32 %36
  %shl.i.i.1.1 = shl i32 %cond.i.i.1.1, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1.1, i32 %..1.1)
  %condval_1.0.1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.14.32.copyload, i32 %38
  %condval_2.0.1.1 = select i1 %cmp86.not.not, i32 %38, i32 %q_words.sroa.19.48.copyload
  %..2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.20.48.copyload, i32 %q_words.sroa.15.32.copyload
  %39 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %40 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %39) #11
  %xor.i.i.2.1 = xor i32 %40, 8
  %41 = and i32 %40, -64
  %and.i.i.2.1 = add nsw i32 %41, 64
  %cmp.not.i.i.2.1 = icmp slt i32 %xor.i.i.2.1, %and.i.i.2.1
  %cond.i.i.2.1 = select i1 %cmp.not.i.i.2.1, i32 %xor.i.i.2.1, i32 %40
  %shl.i.i.2.1 = shl i32 %cond.i.i.2.1, 2
  %42 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2.1, i32 %..2.1)
  %condval_1.0.2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.15.32.copyload, i32 %42
  %condval_2.0.2.1 = select i1 %cmp86.not.not, i32 %42, i32 %q_words.sroa.20.48.copyload
  %..3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.21.48.copyload, i32 %q_words.sroa.16.32.copyload
  %43 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %44 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %43) #11
  %xor.i.i.3.1 = xor i32 %44, 8
  %45 = and i32 %44, -64
  %and.i.i.3.1 = add nsw i32 %45, 64
  %cmp.not.i.i.3.1 = icmp slt i32 %xor.i.i.3.1, %and.i.i.3.1
  %cond.i.i.3.1 = select i1 %cmp.not.i.i.3.1, i32 %xor.i.i.3.1, i32 %44
  %shl.i.i.3.1 = shl i32 %cond.i.i.3.1, 2
  %46 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3.1, i32 %..3.1)
  %condval_1.0.3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.16.32.copyload, i32 %46
  %condval_2.0.3.1 = select i1 %cmp86.not.not, i32 %46, i32 %q_words.sroa.21.48.copyload
  %47 = insertelement <2 x i32> poison, i32 %condval_1.0, i64 0
  %q.sroa.0.2.vec.insert = bitcast <2 x i32> %47 to <4 x half>
  %q_halves.sroa.5.4.extract.trunc = trunc i32 %condval_1.0.1 to i16
  %48 = bitcast i16 %q_halves.sroa.5.4.extract.trunc to half
  %q.sroa.0.4.vec.insert = insertelement <4 x half> %q.sroa.0.2.vec.insert, half %48, i64 2
  %q_halves.sroa.5.6.extract.shift = lshr i32 %condval_1.0.1, 16
  %q_halves.sroa.5.6.extract.trunc = trunc nuw i32 %q_halves.sroa.5.6.extract.shift to i16
  %49 = bitcast i16 %q_halves.sroa.5.6.extract.trunc to half
  %q.sroa.0.6.vec.insert = insertelement <4 x half> %q.sroa.0.4.vec.insert, half %49, i64 3
  %50 = insertelement <2 x i32> poison, i32 %condval_1.0.2, i64 0
  %q.sroa.7.10.vec.insert = bitcast <2 x i32> %50 to <4 x half>
  %q_halves.sroa.11.12.extract.trunc = trunc i32 %condval_1.0.3 to i16
  %51 = bitcast i16 %q_halves.sroa.11.12.extract.trunc to half
  %q.sroa.7.12.vec.insert = insertelement <4 x half> %q.sroa.7.10.vec.insert, half %51, i64 2
  %q_halves.sroa.11.14.extract.shift = lshr i32 %condval_1.0.3, 16
  %q_halves.sroa.11.14.extract.trunc = trunc nuw i32 %q_halves.sroa.11.14.extract.shift to i16
  %52 = bitcast i16 %q_halves.sroa.11.14.extract.trunc to half
  %q.sroa.7.14.vec.insert = insertelement <4 x half> %q.sroa.7.12.vec.insert, half %52, i64 3
  %53 = insertelement <2 x i32> poison, i32 %condval_2.0, i64 0
  %q.sroa.12.18.vec.insert = bitcast <2 x i32> %53 to <4 x half>
  %q_halves.sroa.17.20.extract.trunc = trunc i32 %condval_2.0.1 to i16
  %54 = bitcast i16 %q_halves.sroa.17.20.extract.trunc to half
  %q.sroa.12.20.vec.insert = insertelement <4 x half> %q.sroa.12.18.vec.insert, half %54, i64 2
  %q_halves.sroa.17.22.extract.shift = lshr i32 %condval_2.0.1, 16
  %q_halves.sroa.17.22.extract.trunc = trunc nuw i32 %q_halves.sroa.17.22.extract.shift to i16
  %55 = bitcast i16 %q_halves.sroa.17.22.extract.trunc to half
  %q.sroa.12.22.vec.insert = insertelement <4 x half> %q.sroa.12.20.vec.insert, half %55, i64 3
  %56 = insertelement <2 x i32> poison, i32 %condval_2.0.2, i64 0
  %q.sroa.17.26.vec.insert = bitcast <2 x i32> %56 to <4 x half>
  %q_halves.sroa.23.28.extract.trunc = trunc i32 %condval_2.0.3 to i16
  %57 = bitcast i16 %q_halves.sroa.23.28.extract.trunc to half
  %q.sroa.17.28.vec.insert = insertelement <4 x half> %q.sroa.17.26.vec.insert, half %57, i64 2
  %q_halves.sroa.23.30.extract.shift = lshr i32 %condval_2.0.3, 16
  %q_halves.sroa.23.30.extract.trunc = trunc nuw i32 %q_halves.sroa.23.30.extract.shift to i16
  %58 = bitcast i16 %q_halves.sroa.23.30.extract.trunc to half
  %q.sroa.17.30.vec.insert = insertelement <4 x half> %q.sroa.17.28.vec.insert, half %58, i64 3
  %59 = insertelement <2 x i32> poison, i32 %condval_1.0.1692, i64 0
  %q.sroa.22.34.vec.insert = bitcast <2 x i32> %59 to <4 x half>
  %q_halves.sroa.29.36.extract.trunc = trunc i32 %condval_1.0.1.1 to i16
  %60 = bitcast i16 %q_halves.sroa.29.36.extract.trunc to half
  %q.sroa.22.36.vec.insert = insertelement <4 x half> %q.sroa.22.34.vec.insert, half %60, i64 2
  %q_halves.sroa.29.38.extract.shift = lshr i32 %condval_1.0.1.1, 16
  %q_halves.sroa.29.38.extract.trunc = trunc nuw i32 %q_halves.sroa.29.38.extract.shift to i16
  %61 = bitcast i16 %q_halves.sroa.29.38.extract.trunc to half
  %q.sroa.22.38.vec.insert = insertelement <4 x half> %q.sroa.22.36.vec.insert, half %61, i64 3
  %62 = insertelement <2 x i32> poison, i32 %condval_1.0.2.1, i64 0
  %q.sroa.27.42.vec.insert = bitcast <2 x i32> %62 to <4 x half>
  %q_halves.sroa.35.44.extract.trunc = trunc i32 %condval_1.0.3.1 to i16
  %63 = bitcast i16 %q_halves.sroa.35.44.extract.trunc to half
  %q.sroa.27.44.vec.insert = insertelement <4 x half> %q.sroa.27.42.vec.insert, half %63, i64 2
  %q_halves.sroa.35.46.extract.shift = lshr i32 %condval_1.0.3.1, 16
  %q_halves.sroa.35.46.extract.trunc = trunc nuw i32 %q_halves.sroa.35.46.extract.shift to i16
  %64 = bitcast i16 %q_halves.sroa.35.46.extract.trunc to half
  %q.sroa.27.46.vec.insert = insertelement <4 x half> %q.sroa.27.44.vec.insert, half %64, i64 3
  %65 = insertelement <2 x i32> poison, i32 %condval_2.0.1694, i64 0
  %q.sroa.32.50.vec.insert = bitcast <2 x i32> %65 to <4 x half>
  %q_halves.sroa.41.52.extract.trunc = trunc i32 %condval_2.0.1.1 to i16
  %66 = bitcast i16 %q_halves.sroa.41.52.extract.trunc to half
  %q.sroa.32.52.vec.insert = insertelement <4 x half> %q.sroa.32.50.vec.insert, half %66, i64 2
  %q_halves.sroa.41.54.extract.shift = lshr i32 %condval_2.0.1.1, 16
  %q_halves.sroa.41.54.extract.trunc = trunc nuw i32 %q_halves.sroa.41.54.extract.shift to i16
  %67 = bitcast i16 %q_halves.sroa.41.54.extract.trunc to half
  %q.sroa.32.54.vec.insert = insertelement <4 x half> %q.sroa.32.52.vec.insert, half %67, i64 3
  %68 = insertelement <2 x i32> poison, i32 %condval_2.0.2.1, i64 0
  %q.sroa.37.58.vec.insert = bitcast <2 x i32> %68 to <4 x half>
  %q_halves.sroa.47.60.extract.trunc = trunc i32 %condval_2.0.3.1 to i16
  %69 = bitcast i16 %q_halves.sroa.47.60.extract.trunc to half
  %q.sroa.37.60.vec.insert = insertelement <4 x half> %q.sroa.37.58.vec.insert, half %69, i64 2
  %q_halves.sroa.47.62.extract.shift = lshr i32 %condval_2.0.3.1, 16
  %q_halves.sroa.47.62.extract.trunc = trunc nuw i32 %q_halves.sroa.47.62.extract.shift to i16
  %70 = bitcast i16 %q_halves.sroa.47.62.extract.trunc to half
  %q.sroa.37.62.vec.insert = insertelement <4 x half> %q.sroa.37.60.vec.insert, half %70, i64 3
  %cmp144 = icmp slt i32 %10, 32
  %71 = lshr i32 %2, 2
  br i1 %cmp144, label %for.body143.us.preheader, label %for.cond167.preheader

for.body143.us.preheader:                         ; preds = %for.cond43.preheader
  %mul146 = shl nsw i32 %10, 5
  %mul152 = and i32 %71, 252
  %add149 = add i32 %mul146, %mul152
  %cmp157.not.us = icmp sgt i32 %add149, %1
  %spec.select663 = select i1 %cmp157.not.us, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert966 = insertelement <4 x float> poison, float %spec.select663, i64 0
  %cmp157.not.us.1.not = icmp slt i32 %add149, %1
  %spec.select663.1 = select i1 %cmp157.not.us.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert979 = insertelement <4 x float> %scores.sroa.0.0.vec.insert966, float %spec.select663.1, i64 1
  %add153.us.2 = or disjoint i32 %add149, 2
  %cmp157.not.us.2 = icmp sgt i32 %add153.us.2, %1
  %spec.select663.2 = select i1 %cmp157.not.us.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert992 = insertelement <4 x float> %scores.sroa.0.4.vec.insert979, float %spec.select663.2, i64 2
  %add153.us.3 = or disjoint i32 %add149, 3
  %cmp157.not.us.3 = icmp sgt i32 %add153.us.3, %1
  %spec.select663.3 = select i1 %cmp157.not.us.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1005 = insertelement <4 x float> %scores.sroa.0.8.vec.insert992, float %spec.select663.3, i64 3
  %add155.us.4 = add i32 %add149, 16
  %cmp157.not.us.4 = icmp sgt i32 %add155.us.4, %1
  %spec.select663.4 = select i1 %cmp157.not.us.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.50.16.vec.insert1026 = insertelement <4 x float> poison, float %spec.select663.4, i64 0
  %add155.us.5 = add i32 %add149, 17
  %cmp157.not.us.5 = icmp sgt i32 %add155.us.5, %1
  %spec.select663.5 = select i1 %cmp157.not.us.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.50.20.vec.insert1039 = insertelement <4 x float> %scores.sroa.50.16.vec.insert1026, float %spec.select663.5, i64 1
  %add155.us.6 = add i32 %add149, 18
  %cmp157.not.us.6 = icmp sgt i32 %add155.us.6, %1
  %spec.select663.6 = select i1 %cmp157.not.us.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.50.24.vec.insert1052 = insertelement <4 x float> %scores.sroa.50.20.vec.insert1039, float %spec.select663.6, i64 2
  %add155.us.7 = add i32 %add149, 19
  %cmp157.not.us.7 = icmp sgt i32 %add155.us.7, %1
  %spec.select663.7 = select i1 %cmp157.not.us.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.50.28.vec.insert1065 = insertelement <4 x float> %scores.sroa.50.24.vec.insert1052, float %spec.select663.7, i64 3
  br label %for.cond167.preheader

for.cond167.preheader:                            ; preds = %for.cond43.preheader, %for.body143.us.preheader
  %scores.sroa.50.0 = phi <4 x float> [ %scores.sroa.50.28.vec.insert1065, %for.body143.us.preheader ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %for.cond43.preheader ]
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1005, %for.body143.us.preheader ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %for.cond43.preheader ]
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.0.0), !call_argsrelate !83
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.50.0), !call_argsrelate !83
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %72), !call_argsrelate !83
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %73), !call_argsrelate !83
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %74), !call_argsrelate !83
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %75), !call_argsrelate !83
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %76), !call_argsrelate !83
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %77), !call_argsrelate !83
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %78), !call_argsrelate !83
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %79), !call_argsrelate !83
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %80), !call_argsrelate !83
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %81), !call_argsrelate !83
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %82), !call_argsrelate !83
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %83), !call_argsrelate !83
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %84), !call_argsrelate !83
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %85), !call_argsrelate !83
  %mul212 = shl nuw nsw i64 %conv, 18
  %mul214 = shl nsw i64 %conv49, 13
  %add215 = add nsw i64 %mul214, %mul212
  %invariant.gep635 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192
  %gep636 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add215
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %gep636, align 16
  %v.sroa.7.0.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636, i64 8
  %v.sroa.7.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.0.gep636.sroa_idx, align 8
  %add223.1 = or disjoint i64 %add215, 512
  %gep636.1 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add223.1
  %v.sroa.9.16.copyload = load <4 x half>, ptr addrspace(4) %gep636.1, align 16
  %v.sroa.14.16.gep636.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636.1, i64 8
  %v.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.14.16.gep636.1.sroa_idx, align 8
  %add219.2 = or disjoint i64 %add215, 2048
  %gep636.2 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add219.2
  %v.sroa.16.32.copyload = load <4 x half>, ptr addrspace(4) %gep636.2, align 16
  %v.sroa.21.32.gep636.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636.2, i64 8
  %v.sroa.21.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.21.32.gep636.2.sroa_idx, align 8
  %add223.3 = or disjoint i64 %add215, 2560
  %gep636.3 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add223.3
  %v.sroa.23.48.copyload = load <4 x half>, ptr addrspace(4) %gep636.3, align 16
  %v.sroa.28.48.gep636.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636.3, i64 8
  %v.sroa.28.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.28.48.gep636.3.sroa_idx, align 8
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %86, i64 0
  %mul243 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul243, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %88, -1.260000e+02
  %cond.i.i610 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i611 = fadd contract float %88, %cond.i.i610
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i611)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %89
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %86, i64 1
  %mul243.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul243.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %90, -1.260000e+02
  %cond.i.i610.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.1 = fadd contract float %90, %cond.i.i610.1
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i611.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %91
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %86, i64 2
  %mul243.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul243.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %92, -1.260000e+02
  %cond.i.i610.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.2 = fadd contract float %92, %cond.i.i610.2
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i611.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %93
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %86, i64 3
  %mul243.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul243.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %94, -1.260000e+02
  %cond.i.i610.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.3 = fadd contract float %94, %cond.i.i610.3
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i611.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %95
  %scores.sroa.50.16.vec.extract = extractelement <4 x float> %87, i64 0
  %mul243.4 = fmul contract float %scores.sroa.50.16.vec.extract, 0x3FC2776C60000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul243.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %96, -1.260000e+02
  %cond.i.i610.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.4 = fadd contract float %96, %cond.i.i610.4
  %97 = tail call contract float @llvm.exp2.f32(float %add.i.i611.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %97
  %scores.sroa.50.20.vec.extract = extractelement <4 x float> %87, i64 1
  %mul243.5 = fmul contract float %scores.sroa.50.20.vec.extract, 0x3FC2776C60000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul243.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %98, -1.260000e+02
  %cond.i.i610.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.5 = fadd contract float %98, %cond.i.i610.5
  %99 = tail call contract float @llvm.exp2.f32(float %add.i.i611.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %99
  %scores.sroa.50.24.vec.extract = extractelement <4 x float> %87, i64 2
  %mul243.6 = fmul contract float %scores.sroa.50.24.vec.extract, 0x3FC2776C60000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul243.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %100, -1.260000e+02
  %cond.i.i610.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.6 = fadd contract float %100, %cond.i.i610.6
  %101 = tail call contract float @llvm.exp2.f32(float %add.i.i611.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %101
  %scores.sroa.50.28.vec.extract = extractelement <4 x float> %87, i64 3
  %mul243.7 = fmul contract float %scores.sroa.50.28.vec.extract, 0x3FC2776C60000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul243.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %102, -1.260000e+02
  %cond.i.i610.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i611.7 = fadd contract float %102, %cond.i.i610.7
  %103 = tail call contract float @llvm.exp2.f32(float %add.i.i611.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %103
  %add263 = fadd contract float %mul.i.i, 0.000000e+00
  %add263.1 = fadd contract float %add263, %mul.i.i.4
  %add263.2 = fadd contract float %add263.1, %mul.i.i.1
  %add263.3 = fadd contract float %add263.2, %mul.i.i.5
  %add263.4 = fadd contract float %add263.3, %mul.i.i.2
  %add263.5 = fadd contract float %add263.4, %mul.i.i.6
  %add263.6 = fadd contract float %add263.5, %mul.i.i.3
  %add263.7 = fadd contract float %add263.6, %mul.i.i.7
  %104 = bitcast float %add263.7 to i32
  %105 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %106 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %105) #11
  %xor.i.i612 = xor i32 %106, 32
  %107 = and i32 %106, -64
  %and.i.i613 = add nsw i32 %107, 64
  %cmp.not.i.i614 = icmp slt i32 %xor.i.i612, %and.i.i613
  %cond.i.i615 = select i1 %cmp.not.i.i614, i32 %xor.i.i612, i32 %106
  %shl.i.i616 = shl i32 %cond.i.i615, 2
  %108 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i616, i32 %104)
  %109 = bitcast i32 %108 to float
  %add.i = fadd contract float %add263.7, %109
  %110 = bitcast float %add.i to i32
  %111 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %112 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %111) #11
  %xor.i.i617 = xor i32 %112, 16
  %113 = and i32 %112, -64
  %and.i.i618 = add nsw i32 %113, 64
  %cmp.not.i.i619 = icmp slt i32 %xor.i.i617, %and.i.i618
  %cond.i.i620 = select i1 %cmp.not.i.i619, i32 %xor.i.i617, i32 %112
  %shl.i.i621 = shl i32 %cond.i.i620, 2
  %114 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i621, i32 %110)
  %115 = bitcast i32 %114 to float
  %add.i.i = fadd contract float %add.i, %115
  %cmp272 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp272, float %div, float 0.000000e+00
  %mul285 = fmul contract float %condval_4.0, %mul.i.i
  %mul285.1 = fmul contract float %condval_4.0, %mul.i.i.1
  %mul285.2 = fmul contract float %condval_4.0, %mul.i.i.2
  %mul285.3 = fmul contract float %condval_4.0, %mul.i.i.3
  %mul285.4 = fmul contract float %condval_4.0, %mul.i.i.4
  %mul285.5 = fmul contract float %condval_4.0, %mul.i.i.5
  %mul285.6 = fmul contract float %condval_4.0, %mul.i.i.6
  %mul285.7 = fmul contract float %condval_4.0, %mul.i.i.7
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285)
  %117 = insertelement <4 x i16> poison, i16 %116, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.1)
  %119 = insertelement <4 x i16> %117, i16 %118, i64 1
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.2)
  %121 = insertelement <4 x i16> %119, i16 %120, i64 2
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.3)
  %123 = insertelement <4 x i16> %121, i16 %122, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %123 to <4 x half>
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.4)
  %125 = insertelement <4 x i16> poison, i16 %124, i64 0
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.5)
  %127 = insertelement <4 x i16> %125, i16 %126, i64 1
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.6)
  %129 = insertelement <4 x i16> %127, i16 %128, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.7)
  %131 = insertelement <4 x i16> %129, i16 %130, i64 3
  %prob.sroa.8.14.vec.insert = bitcast <4 x i16> %131 to <4 x half>
  br label %if.end313

if.end313:                                        ; preds = %land.end.if.end313_crit_edge, %for.cond167.preheader
  %mul358.pre-phi = phi i64 [ %.pre1092, %land.end.if.end313_crit_edge ], [ %mul57, %for.cond167.preheader ]
  %add344.pre-phi = phi i64 [ %.pre1091, %land.end.if.end313_crit_edge ], [ %add215, %for.cond167.preheader ]
  %.pre-phi1086 = phi i32 [ %.pre1085, %land.end.if.end313_crit_edge ], [ %12, %for.cond167.preheader ]
  %.pre-phi = phi i32 [ %.pre, %land.end.if.end313_crit_edge ], [ %71, %for.cond167.preheader ]
  %v.sroa.28.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.28.48.copyload, %for.cond167.preheader ]
  %v.sroa.23.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.23.48.copyload, %for.cond167.preheader ]
  %v.sroa.21.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.21.32.copyload, %for.cond167.preheader ]
  %v.sroa.16.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.16.32.copyload, %for.cond167.preheader ]
  %v.sroa.14.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.14.16.copyload, %for.cond167.preheader ]
  %v.sroa.9.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.9.16.copyload, %for.cond167.preheader ]
  %v.sroa.7.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.7.0.copyload, %for.cond167.preheader ]
  %v.sroa.0.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.0.0.copyload, %for.cond167.preheader ]
  %prob.sroa.8.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %prob.sroa.8.14.vec.insert, %for.cond167.preheader ]
  %prob.sroa.0.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %prob.sroa.0.6.vec.insert, %for.cond167.preheader ]
  %invariant.gep660 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
  %and431 = shl nuw nsw i32 %2, 6
  %mul432 = and i32 %and431, 960
  %shr435 = lshr i32 %2, 5
  %and438 = and i32 %2, 7
  %mul444 = and i32 %.pre-phi, 4
  %mul458 = and i32 %.pre-phi1086, 8128
  %xor464600 = and i32 %.pre-phi1086, 56
  %call462.masked = and i32 %2, 1016
  %mul465 = xor i32 %xor464600, %call462.masked
  %invariant.gep655 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul458
  %invariant.gep657 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep655, i32 %mul465
  %132 = shl nuw nsw i32 %2, 4
  %mul478 = and i32 %132, 16256
  %add475 = add nuw nsw i32 %add21, %mul478
  %add479 = or disjoint i32 %add475, %xor464600
  %gep661 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep660, i64 %mul358.pre-phi
  %133 = zext nneg i32 %add479 to i64
  br i1 %11, label %if.end369, label %if.end398

if.end369:                                        ; preds = %if.end313
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.9.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.0, <4 x half> %prob.sroa.8.0, <4 x float> %134)
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.21.0, <4 x half> %prob.sroa.8.0, <4 x float> %135)
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.0, <4 x half> %prob.sroa.8.0, <4 x float> %136)
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.28.0, <4 x half> %prob.sroa.8.0, <4 x float> %137)
  br label %if.end398

if.end398:                                        ; preds = %if.end369, %if.end313
  %out.sroa.74.0 = phi <4 x float> [ %141, %if.end369 ], [ zeroinitializer, %if.end313 ]
  %out.sroa.50.0 = phi <4 x float> [ %140, %if.end369 ], [ zeroinitializer, %if.end313 ]
  %out.sroa.26.0 = phi <4 x float> [ %139, %if.end369 ], [ zeroinitializer, %if.end313 ]
  %out.sroa.0.0 = phi <4 x float> [ %138, %if.end369 ], [ zeroinitializer, %if.end313 ]
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %142 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %143 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %144 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %145 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert, %output_reg.sroa.0.6.insert.shift
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 0
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract)
  %output_reg.sroa.12.8.insert.ext = zext i16 %146 to i64
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 1
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract)
  %output_reg.sroa.12.10.insert.ext = zext i16 %147 to i64
  %output_reg.sroa.12.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.10.insert.ext, 16
  %output_reg.sroa.12.10.insert.insert = or disjoint i64 %output_reg.sroa.12.10.insert.shift, %output_reg.sroa.12.8.insert.ext
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 2
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract)
  %output_reg.sroa.12.12.insert.ext = zext i16 %148 to i64
  %output_reg.sroa.12.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.12.insert.ext, 32
  %output_reg.sroa.12.12.insert.insert = or disjoint i64 %output_reg.sroa.12.10.insert.insert, %output_reg.sroa.12.12.insert.shift
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 3
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract)
  %output_reg.sroa.12.14.insert.ext = zext i16 %149 to i64
  %output_reg.sroa.12.14.insert.shift = shl nuw i64 %output_reg.sroa.12.14.insert.ext, 48
  %output_reg.sroa.12.14.insert.insert = or disjoint i64 %output_reg.sroa.12.12.insert.insert, %output_reg.sroa.12.14.insert.shift
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 0
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract)
  %output_reg.sroa.22.16.insert.ext = zext i16 %150 to i64
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 1
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract)
  %output_reg.sroa.22.18.insert.ext = zext i16 %151 to i64
  %output_reg.sroa.22.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.18.insert.ext, 16
  %output_reg.sroa.22.18.insert.insert = or disjoint i64 %output_reg.sroa.22.18.insert.shift, %output_reg.sroa.22.16.insert.ext
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 2
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract)
  %output_reg.sroa.22.20.insert.ext = zext i16 %152 to i64
  %output_reg.sroa.22.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.20.insert.ext, 32
  %output_reg.sroa.22.20.insert.insert = or disjoint i64 %output_reg.sroa.22.18.insert.insert, %output_reg.sroa.22.20.insert.shift
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 3
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract)
  %output_reg.sroa.22.22.insert.ext = zext i16 %153 to i64
  %output_reg.sroa.22.22.insert.shift = shl nuw i64 %output_reg.sroa.22.22.insert.ext, 48
  %output_reg.sroa.22.22.insert.insert = or disjoint i64 %output_reg.sroa.22.20.insert.insert, %output_reg.sroa.22.22.insert.shift
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 0
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract)
  %output_reg.sroa.32.24.insert.ext = zext i16 %154 to i64
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 1
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract)
  %output_reg.sroa.32.26.insert.ext = zext i16 %155 to i64
  %output_reg.sroa.32.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.26.insert.ext, 16
  %output_reg.sroa.32.26.insert.insert = or disjoint i64 %output_reg.sroa.32.26.insert.shift, %output_reg.sroa.32.24.insert.ext
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 2
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract)
  %output_reg.sroa.32.28.insert.ext = zext i16 %156 to i64
  %output_reg.sroa.32.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.28.insert.ext, 32
  %output_reg.sroa.32.28.insert.insert = or disjoint i64 %output_reg.sroa.32.26.insert.insert, %output_reg.sroa.32.28.insert.shift
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 3
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract)
  %output_reg.sroa.32.30.insert.ext = zext i16 %157 to i64
  %output_reg.sroa.32.30.insert.shift = shl nuw i64 %output_reg.sroa.32.30.insert.ext, 48
  %output_reg.sroa.32.30.insert.insert = or disjoint i64 %output_reg.sroa.32.28.insert.insert, %output_reg.sroa.32.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor = xor i32 %shr435, %and438
  %mul439 = shl nuw nsw i32 %xor, 3
  %add440 = add nuw nsw i32 %mul439, %mul432
  %add445 = or disjoint i32 %add440, %mul444
  %add.ptr447 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445
  store i64 %output_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr447, align 8
  %add436.1 = add nuw nsw i32 %shr435, 2
  %xor.1 = xor i32 %add436.1, %and438
  %mul439.1 = shl nuw nsw i32 %xor.1, 3
  %add440.1 = add nuw nsw i32 %mul439.1, %mul432
  %add445.1 = or disjoint i32 %add440.1, %mul444
  %add.ptr447.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.1
  store i64 %output_reg.sroa.12.14.insert.insert, ptr addrspace(3) %add.ptr447.1, align 8
  %add436.2 = add nuw nsw i32 %shr435, 4
  %xor.2 = xor i32 %add436.2, %and438
  %mul439.2 = shl nuw nsw i32 %xor.2, 3
  %add440.2 = add nuw nsw i32 %mul439.2, %mul432
  %add445.2 = or disjoint i32 %add440.2, %mul444
  %add.ptr447.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.2
  store i64 %output_reg.sroa.22.22.insert.insert, ptr addrspace(3) %add.ptr447.2, align 8
  %add436.3 = add nuw nsw i32 %shr435, 6
  %xor.3 = xor i32 %add436.3, %and438
  %mul439.3 = shl nuw nsw i32 %xor.3, 3
  %add440.3 = add nuw nsw i32 %mul439.3, %mul432
  %add445.3 = or disjoint i32 %add440.3, %mul444
  %add.ptr447.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.3
  store i64 %output_reg.sroa.32.30.insert.insert, ptr addrspace(3) %add.ptr447.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr487 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %133
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep657, i64 16, i1 false), !tbaa.struct !189, !call_argsrelate !190
  %gep658.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 1024
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %133
  %add.ptr487.1 = getelementptr inbounds i8, ptr addrspace(1) %158, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep658.1, i64 16, i1 false), !tbaa.struct !189, !call_argsrelate !190
  br i1 %11, label %if.end369.1, label %if.end398.1

if.end369.1:                                      ; preds = %if.end398
  %add348.3.1 = add nuw nsw i64 %add344.pre-phi, 3072
  %add351.3.1 = or i64 %add348.3.1, 1536
  %gep648.3.1 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %add351.3.1
  %v.sroa.28.48.gep648.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep648.3.1, i64 8
  %v.sroa.28.48.copyload955 = load <4 x half>, ptr addrspace(4) %v.sroa.28.48.gep648.3.1.sroa_idx, align 8
  %v.sroa.23.48.copyload953 = load <4 x half>, ptr addrspace(4) %gep648.3.1, align 16
  %159 = or i64 %add344.pre-phi, 1024
  %160 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %159
  %v.sroa.21.32.gep648.2.1.sroa_idx = getelementptr i8, ptr addrspace(4) %160, i64 4104
  %v.sroa.21.32.copyload949 = load <4 x half>, ptr addrspace(4) %v.sroa.21.32.gep648.2.1.sroa_idx, align 8
  %gep648.2.1 = getelementptr i8, ptr addrspace(4) %160, i64 4096
  %v.sroa.16.32.copyload947 = load <4 x half>, ptr addrspace(4) %gep648.2.1, align 16
  %161 = or i64 %add344.pre-phi, 512
  %add351.1.1 = add nuw nsw i64 %161, 1024
  %add355.1.1 = or i64 %add351.1.1, 1024
  %gep648.1.1 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %add355.1.1
  %v.sroa.14.16.gep648.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep648.1.1, i64 8
  %v.sroa.14.16.copyload943 = load <4 x half>, ptr addrspace(4) %v.sroa.14.16.gep648.1.1.sroa_idx, align 8
  %v.sroa.9.16.copyload941 = load <4 x half>, ptr addrspace(4) %gep648.1.1, align 16
  %add355.1734 = or i64 %add344.pre-phi, 1024
  %gep648.1735 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %add355.1734
  %v.sroa.7.0.gep648.1735.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep648.1735, i64 8
  %v.sroa.7.0.copyload937 = load <4 x half>, ptr addrspace(4) %v.sroa.7.0.gep648.1735.sroa_idx, align 8
  %v.sroa.0.0.copyload935 = load <4 x half>, ptr addrspace(4) %gep648.1735, align 16
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload935, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !call_argsrelate !83
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0.copyload937, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !call_argsrelate !83
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.9.16.copyload941, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !call_argsrelate !83
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.16.copyload943, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !call_argsrelate !83
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.32.copyload947, <4 x half> %prob.sroa.8.0, <4 x float> %162), !call_argsrelate !83
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.21.32.copyload949, <4 x half> %prob.sroa.8.0, <4 x float> %163), !call_argsrelate !83
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.48.copyload953, <4 x half> %prob.sroa.8.0, <4 x float> %164), !call_argsrelate !83
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.28.48.copyload955, <4 x half> %prob.sroa.8.0, <4 x float> %165), !call_argsrelate !83
  br label %if.end398.1

if.end398.1:                                      ; preds = %if.end369.1, %if.end398
  %out.sroa.74.1 = phi <4 x float> [ %169, %if.end369.1 ], [ zeroinitializer, %if.end398 ]
  %out.sroa.50.1 = phi <4 x float> [ %168, %if.end369.1 ], [ zeroinitializer, %if.end398 ]
  %out.sroa.26.1 = phi <4 x float> [ %167, %if.end369.1 ], [ zeroinitializer, %if.end398 ]
  %out.sroa.0.1 = phi <4 x float> [ %166, %if.end369.1 ], [ zeroinitializer, %if.end398 ]
  %out.sroa.0.0.vec.extract841 = extractelement <4 x float> %out.sroa.0.1, i64 0
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract841)
  %output_reg.sroa.0.0.insert.ext755 = zext i16 %170 to i64
  %out.sroa.0.4.vec.extract846 = extractelement <4 x float> %out.sroa.0.1, i64 1
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract846)
  %output_reg.sroa.0.2.insert.ext759 = zext i16 %171 to i64
  %output_reg.sroa.0.2.insert.shift760 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext759, 16
  %output_reg.sroa.0.2.insert.insert762 = or disjoint i64 %output_reg.sroa.0.2.insert.shift760, %output_reg.sroa.0.0.insert.ext755
  %out.sroa.0.8.vec.extract851 = extractelement <4 x float> %out.sroa.0.1, i64 2
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract851)
  %output_reg.sroa.0.4.insert.ext764 = zext i16 %172 to i64
  %output_reg.sroa.0.4.insert.shift765 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext764, 32
  %output_reg.sroa.0.4.insert.insert767 = or disjoint i64 %output_reg.sroa.0.2.insert.insert762, %output_reg.sroa.0.4.insert.shift765
  %out.sroa.0.12.vec.extract856 = extractelement <4 x float> %out.sroa.0.1, i64 3
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract856)
  %output_reg.sroa.0.6.insert.ext769 = zext i16 %173 to i64
  %output_reg.sroa.0.6.insert.shift770 = shl nuw i64 %output_reg.sroa.0.6.insert.ext769, 48
  %output_reg.sroa.0.6.insert.insert772 = or disjoint i64 %output_reg.sroa.0.4.insert.insert767, %output_reg.sroa.0.6.insert.shift770
  %out.sroa.26.16.vec.extract865 = extractelement <4 x float> %out.sroa.26.1, i64 0
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract865)
  %output_reg.sroa.12.8.insert.ext775 = zext i16 %174 to i64
  %out.sroa.26.20.vec.extract870 = extractelement <4 x float> %out.sroa.26.1, i64 1
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract870)
  %output_reg.sroa.12.10.insert.ext779 = zext i16 %175 to i64
  %output_reg.sroa.12.10.insert.shift780 = shl nuw nsw i64 %output_reg.sroa.12.10.insert.ext779, 16
  %output_reg.sroa.12.10.insert.insert782 = or disjoint i64 %output_reg.sroa.12.10.insert.shift780, %output_reg.sroa.12.8.insert.ext775
  %out.sroa.26.24.vec.extract875 = extractelement <4 x float> %out.sroa.26.1, i64 2
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract875)
  %output_reg.sroa.12.12.insert.ext784 = zext i16 %176 to i64
  %output_reg.sroa.12.12.insert.shift785 = shl nuw nsw i64 %output_reg.sroa.12.12.insert.ext784, 32
  %output_reg.sroa.12.12.insert.insert787 = or disjoint i64 %output_reg.sroa.12.10.insert.insert782, %output_reg.sroa.12.12.insert.shift785
  %out.sroa.26.28.vec.extract880 = extractelement <4 x float> %out.sroa.26.1, i64 3
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract880)
  %output_reg.sroa.12.14.insert.ext789 = zext i16 %177 to i64
  %output_reg.sroa.12.14.insert.shift790 = shl nuw i64 %output_reg.sroa.12.14.insert.ext789, 48
  %output_reg.sroa.12.14.insert.insert792 = or disjoint i64 %output_reg.sroa.12.12.insert.insert787, %output_reg.sroa.12.14.insert.shift790
  %out.sroa.50.32.vec.extract889 = extractelement <4 x float> %out.sroa.50.1, i64 0
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract889)
  %output_reg.sroa.22.16.insert.ext795 = zext i16 %178 to i64
  %out.sroa.50.36.vec.extract894 = extractelement <4 x float> %out.sroa.50.1, i64 1
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract894)
  %output_reg.sroa.22.18.insert.ext799 = zext i16 %179 to i64
  %output_reg.sroa.22.18.insert.shift800 = shl nuw nsw i64 %output_reg.sroa.22.18.insert.ext799, 16
  %output_reg.sroa.22.18.insert.insert802 = or disjoint i64 %output_reg.sroa.22.18.insert.shift800, %output_reg.sroa.22.16.insert.ext795
  %out.sroa.50.40.vec.extract899 = extractelement <4 x float> %out.sroa.50.1, i64 2
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract899)
  %output_reg.sroa.22.20.insert.ext804 = zext i16 %180 to i64
  %output_reg.sroa.22.20.insert.shift805 = shl nuw nsw i64 %output_reg.sroa.22.20.insert.ext804, 32
  %output_reg.sroa.22.20.insert.insert807 = or disjoint i64 %output_reg.sroa.22.18.insert.insert802, %output_reg.sroa.22.20.insert.shift805
  %out.sroa.50.44.vec.extract904 = extractelement <4 x float> %out.sroa.50.1, i64 3
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract904)
  %output_reg.sroa.22.22.insert.ext809 = zext i16 %181 to i64
  %output_reg.sroa.22.22.insert.shift810 = shl nuw i64 %output_reg.sroa.22.22.insert.ext809, 48
  %output_reg.sroa.22.22.insert.insert812 = or disjoint i64 %output_reg.sroa.22.20.insert.insert807, %output_reg.sroa.22.22.insert.shift810
  %out.sroa.74.48.vec.extract913 = extractelement <4 x float> %out.sroa.74.1, i64 0
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract913)
  %output_reg.sroa.32.24.insert.ext815 = zext i16 %182 to i64
  %out.sroa.74.52.vec.extract918 = extractelement <4 x float> %out.sroa.74.1, i64 1
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract918)
  %output_reg.sroa.32.26.insert.ext819 = zext i16 %183 to i64
  %output_reg.sroa.32.26.insert.shift820 = shl nuw nsw i64 %output_reg.sroa.32.26.insert.ext819, 16
  %output_reg.sroa.32.26.insert.insert822 = or disjoint i64 %output_reg.sroa.32.26.insert.shift820, %output_reg.sroa.32.24.insert.ext815
  %out.sroa.74.56.vec.extract923 = extractelement <4 x float> %out.sroa.74.1, i64 2
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract923)
  %output_reg.sroa.32.28.insert.ext824 = zext i16 %184 to i64
  %output_reg.sroa.32.28.insert.shift825 = shl nuw nsw i64 %output_reg.sroa.32.28.insert.ext824, 32
  %output_reg.sroa.32.28.insert.insert827 = or disjoint i64 %output_reg.sroa.32.26.insert.insert822, %output_reg.sroa.32.28.insert.shift825
  %out.sroa.74.60.vec.extract928 = extractelement <4 x float> %out.sroa.74.1, i64 3
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract928)
  %output_reg.sroa.32.30.insert.ext829 = zext i16 %185 to i64
  %output_reg.sroa.32.30.insert.shift830 = shl nuw i64 %output_reg.sroa.32.30.insert.ext829, 48
  %output_reg.sroa.32.30.insert.insert832 = or disjoint i64 %output_reg.sroa.32.28.insert.insert827, %output_reg.sroa.32.30.insert.shift830
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i64 %output_reg.sroa.0.6.insert.insert772, ptr addrspace(3) %add.ptr447, align 8
  store i64 %output_reg.sroa.12.14.insert.insert792, ptr addrspace(3) %add.ptr447.1, align 8
  store i64 %output_reg.sroa.22.22.insert.insert812, ptr addrspace(3) %add.ptr447.2, align 8
  store i64 %output_reg.sroa.32.30.insert.insert832, ptr addrspace(3) %add.ptr447.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %186 = or disjoint i64 %133, 64
  %add.ptr487.1752 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %186
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487.1752, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep657, i64 16, i1 false), !tbaa.struct !189, !call_argsrelate !190
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %133
  %add.ptr487.1.1 = getelementptr inbounds i8, ptr addrspace(1) %187, i64 2176
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep658.1, i64 16, i1 false), !tbaa.struct !189, !call_argsrelate !190
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

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare void @llvm.mxc.barrier.warp() #7

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #8

declare float @llvm.exp2.f32(float) #9

declare float @llvm.minnum.f32(float, float) #9

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


