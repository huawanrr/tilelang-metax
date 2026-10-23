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
  %add21 = add nuw i32 %mul, %mul10
  %5 = or disjoint i32 %mul14, %mul20
  %add12 = or disjoint i32 %5, %add21
  %add15 = add nuw nsw i32 %add12, %mul24
  %6 = sext i32 %add15 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %q_words.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr, align 16, !tbaa !30
  %q_words.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 4
  %q_words.sroa.4.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.4.0.add.ptr.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q_words.sroa.5.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.5.0.add.ptr.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.6.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 12
  %q_words.sroa.6.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.6.0.add.ptr.sroa_idx, align 4, !tbaa !30
  %7 = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.1 = getelementptr i8, ptr addrspace(4) %7, i64 2048
  %q_words.sroa.7.16.copyload = load i32, ptr addrspace(4) %add.ptr.1, align 16, !tbaa !30
  %q_words.sroa.9.16.add.ptr.1.sroa_idx = getelementptr i8, ptr addrspace(4) %7, i64 2052
  %q_words.sroa.9.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.9.16.add.ptr.1.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.10.16.add.ptr.1.sroa_idx = getelementptr i8, ptr addrspace(4) %7, i64 2056
  %q_words.sroa.10.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.10.16.add.ptr.1.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.11.16.add.ptr.1.sroa_idx = getelementptr i8, ptr addrspace(4) %7, i64 2060
  %q_words.sroa.11.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.11.16.add.ptr.1.sroa_idx, align 4, !tbaa !30
  %8 = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.1780 = getelementptr i8, ptr addrspace(4) %8, i64 128
  %q_words.sroa.12.32.copyload = load i32, ptr addrspace(4) %add.ptr.1780, align 16, !tbaa !30
  %q_words.sroa.14.32.add.ptr.1780.sroa_idx = getelementptr i8, ptr addrspace(4) %8, i64 132
  %q_words.sroa.14.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.14.32.add.ptr.1780.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.15.32.add.ptr.1780.sroa_idx = getelementptr i8, ptr addrspace(4) %8, i64 136
  %q_words.sroa.15.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.15.32.add.ptr.1780.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.16.32.add.ptr.1780.sroa_idx = getelementptr i8, ptr addrspace(4) %8, i64 140
  %q_words.sroa.16.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.16.32.add.ptr.1780.sroa_idx, align 4, !tbaa !30
  %9 = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6
  %add.ptr.1.1 = getelementptr i8, ptr addrspace(4) %9, i64 2176
  %q_words.sroa.17.48.copyload = load i32, ptr addrspace(4) %add.ptr.1.1, align 16, !tbaa !30
  %q_words.sroa.19.48.add.ptr.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %9, i64 2180
  %q_words.sroa.19.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.19.48.add.ptr.1.1.sroa_idx, align 4, !tbaa !30
  %q_words.sroa.20.48.add.ptr.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %9, i64 2184
  %q_words.sroa.20.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.20.48.add.ptr.1.1.sroa_idx, align 8, !tbaa !30
  %q_words.sroa.21.48.add.ptr.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %9, i64 2188
  %q_words.sroa.21.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.21.48.add.ptr.1.1.sroa_idx, align 4, !tbaa !30
  %mul35 = shl nsw i32 %0, 10
  %add37 = add nuw nsw i32 %mul35, %1
  %idxprom = zext nneg i32 %add37 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %10 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp39 = icmp ult i32 %10, 32
  br i1 %cmp39, label %land.rhs, label %if.else372

land.rhs:                                         ; preds = %entry
  %mul40 = shl nuw nsw i32 %10, 5
  %cmp42.not = icmp ugt i32 %mul40, %1
  br i1 %cmp42.not, label %if.else372, label %for.cond43.preheader

for.cond43.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul48 = shl nuw nsw i64 %conv, 18
  %11 = shl nuw nsw i32 %10, 13
  %mul50 = zext nneg i32 %11 to i64
  %add51 = or disjoint i64 %mul48, %mul50
  %12 = shl nuw nsw i32 %2, 3
  %mul57 = zext nneg i32 %12 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul57
  %13 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add51
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %13, align 16
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %13, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8
  %gep.1 = getelementptr i8, ptr addrspace(4) %13, i64 1024
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 1032
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8
  %gep.2 = getelementptr i8, ptr addrspace(4) %13, i64 2048
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 2056
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8
  %gep.3 = getelementptr i8, ptr addrspace(4) %13, i64 3072
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 3080
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8
  %gep.4 = getelementptr i8, ptr addrspace(4) %13, i64 4096
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 4104
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8
  %gep.5 = getelementptr i8, ptr addrspace(4) %13, i64 5120
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 5128
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8
  %gep.6 = getelementptr i8, ptr addrspace(4) %13, i64 6144
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 6152
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8
  %gep.7 = getelementptr i8, ptr addrspace(4) %13, i64 7168
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 7176
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8
  %and85 = and i32 %2, 8
  %cmp86.not.not = icmp eq i32 %and85, 0
  %. = select i1 %cmp86.not.not, i32 %q_words.sroa.7.16.copyload, i32 %q_words.sroa.0.0.copyload
  %14 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %15 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %14) #9
  %xor.i.i = xor i32 %15, 8
  %16 = and i32 %15, -64
  %and.i.i = add nsw i32 %16, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %15
  %shl.i.i = shl i32 %cond.i.i, 2
  %17 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %.)
  %condval_1.0 = select i1 %cmp86.not.not, i32 %q_words.sroa.0.0.copyload, i32 %17
  %condval_2.0 = select i1 %cmp86.not.not, i32 %17, i32 %q_words.sroa.7.16.copyload
  %..1 = select i1 %cmp86.not.not, i32 %q_words.sroa.9.16.copyload, i32 %q_words.sroa.4.0.copyload
  %18 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %19 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %18) #9
  %xor.i.i.1 = xor i32 %19, 8
  %20 = and i32 %19, -64
  %and.i.i.1 = add nsw i32 %20, 64
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1
  %cond.i.i.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %19
  %shl.i.i.1 = shl i32 %cond.i.i.1, 2
  %21 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %..1)
  %condval_1.0.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.4.0.copyload, i32 %21
  %condval_2.0.1 = select i1 %cmp86.not.not, i32 %21, i32 %q_words.sroa.9.16.copyload
  %..2 = select i1 %cmp86.not.not, i32 %q_words.sroa.10.16.copyload, i32 %q_words.sroa.5.0.copyload
  %22 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %23 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %22) #9
  %xor.i.i.2 = xor i32 %23, 8
  %24 = and i32 %23, -64
  %and.i.i.2 = add nsw i32 %24, 64
  %cmp.not.i.i.2 = icmp slt i32 %xor.i.i.2, %and.i.i.2
  %cond.i.i.2 = select i1 %cmp.not.i.i.2, i32 %xor.i.i.2, i32 %23
  %shl.i.i.2 = shl i32 %cond.i.i.2, 2
  %25 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2, i32 %..2)
  %condval_1.0.2 = select i1 %cmp86.not.not, i32 %q_words.sroa.5.0.copyload, i32 %25
  %condval_2.0.2 = select i1 %cmp86.not.not, i32 %25, i32 %q_words.sroa.10.16.copyload
  %..3 = select i1 %cmp86.not.not, i32 %q_words.sroa.11.16.copyload, i32 %q_words.sroa.6.0.copyload
  %26 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %27 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %26) #9
  %xor.i.i.3 = xor i32 %27, 8
  %28 = and i32 %27, -64
  %and.i.i.3 = add nsw i32 %28, 64
  %cmp.not.i.i.3 = icmp slt i32 %xor.i.i.3, %and.i.i.3
  %cond.i.i.3 = select i1 %cmp.not.i.i.3, i32 %xor.i.i.3, i32 %27
  %shl.i.i.3 = shl i32 %cond.i.i.3, 2
  %29 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3, i32 %..3)
  %condval_1.0.3 = select i1 %cmp86.not.not, i32 %q_words.sroa.6.0.copyload, i32 %29
  %condval_2.0.3 = select i1 %cmp86.not.not, i32 %29, i32 %q_words.sroa.11.16.copyload
  %..1787 = select i1 %cmp86.not.not, i32 %q_words.sroa.17.48.copyload, i32 %q_words.sroa.12.32.copyload
  %30 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %31 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %30) #9
  %xor.i.i.1788 = xor i32 %31, 8
  %32 = and i32 %31, -64
  %and.i.i.1789 = add nsw i32 %32, 64
  %cmp.not.i.i.1790 = icmp slt i32 %xor.i.i.1788, %and.i.i.1789
  %cond.i.i.1791 = select i1 %cmp.not.i.i.1790, i32 %xor.i.i.1788, i32 %31
  %shl.i.i.1792 = shl i32 %cond.i.i.1791, 2
  %33 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1792, i32 %..1787)
  %condval_1.0.1793 = select i1 %cmp86.not.not, i32 %q_words.sroa.12.32.copyload, i32 %33
  %condval_2.0.1795 = select i1 %cmp86.not.not, i32 %33, i32 %q_words.sroa.17.48.copyload
  %..1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.19.48.copyload, i32 %q_words.sroa.14.32.copyload
  %34 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %35 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %34) #9
  %xor.i.i.1.1 = xor i32 %35, 8
  %36 = and i32 %35, -64
  %and.i.i.1.1 = add nsw i32 %36, 64
  %cmp.not.i.i.1.1 = icmp slt i32 %xor.i.i.1.1, %and.i.i.1.1
  %cond.i.i.1.1 = select i1 %cmp.not.i.i.1.1, i32 %xor.i.i.1.1, i32 %35
  %shl.i.i.1.1 = shl i32 %cond.i.i.1.1, 2
  %37 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1.1, i32 %..1.1)
  %condval_1.0.1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.14.32.copyload, i32 %37
  %condval_2.0.1.1 = select i1 %cmp86.not.not, i32 %37, i32 %q_words.sroa.19.48.copyload
  %..2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.20.48.copyload, i32 %q_words.sroa.15.32.copyload
  %38 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %39 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %38) #9
  %xor.i.i.2.1 = xor i32 %39, 8
  %40 = and i32 %39, -64
  %and.i.i.2.1 = add nsw i32 %40, 64
  %cmp.not.i.i.2.1 = icmp slt i32 %xor.i.i.2.1, %and.i.i.2.1
  %cond.i.i.2.1 = select i1 %cmp.not.i.i.2.1, i32 %xor.i.i.2.1, i32 %39
  %shl.i.i.2.1 = shl i32 %cond.i.i.2.1, 2
  %41 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2.1, i32 %..2.1)
  %condval_1.0.2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.15.32.copyload, i32 %41
  %condval_2.0.2.1 = select i1 %cmp86.not.not, i32 %41, i32 %q_words.sroa.20.48.copyload
  %..3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.21.48.copyload, i32 %q_words.sroa.16.32.copyload
  %42 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %43 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %42) #9
  %xor.i.i.3.1 = xor i32 %43, 8
  %44 = and i32 %43, -64
  %and.i.i.3.1 = add nsw i32 %44, 64
  %cmp.not.i.i.3.1 = icmp slt i32 %xor.i.i.3.1, %and.i.i.3.1
  %cond.i.i.3.1 = select i1 %cmp.not.i.i.3.1, i32 %xor.i.i.3.1, i32 %43
  %shl.i.i.3.1 = shl i32 %cond.i.i.3.1, 2
  %45 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3.1, i32 %..3.1)
  %condval_1.0.3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.16.32.copyload, i32 %45
  %condval_2.0.3.1 = select i1 %cmp86.not.not, i32 %45, i32 %q_words.sroa.21.48.copyload
  %46 = insertelement <2 x i32> poison, i32 %condval_1.0, i64 0
  %q.sroa.0.2.vec.insert = bitcast <2 x i32> %46 to <4 x half>
  %q_halves.sroa.5.4.extract.trunc = trunc i32 %condval_1.0.1 to i16
  %47 = bitcast i16 %q_halves.sroa.5.4.extract.trunc to half
  %q.sroa.0.4.vec.insert = insertelement <4 x half> %q.sroa.0.2.vec.insert, half %47, i64 2
  %q_halves.sroa.5.6.extract.shift = lshr i32 %condval_1.0.1, 16
  %q_halves.sroa.5.6.extract.trunc = trunc nuw i32 %q_halves.sroa.5.6.extract.shift to i16
  %48 = bitcast i16 %q_halves.sroa.5.6.extract.trunc to half
  %q.sroa.0.6.vec.insert = insertelement <4 x half> %q.sroa.0.4.vec.insert, half %48, i64 3
  %49 = insertelement <2 x i32> poison, i32 %condval_1.0.2, i64 0
  %q.sroa.7.10.vec.insert = bitcast <2 x i32> %49 to <4 x half>
  %q_halves.sroa.11.12.extract.trunc = trunc i32 %condval_1.0.3 to i16
  %50 = bitcast i16 %q_halves.sroa.11.12.extract.trunc to half
  %q.sroa.7.12.vec.insert = insertelement <4 x half> %q.sroa.7.10.vec.insert, half %50, i64 2
  %q_halves.sroa.11.14.extract.shift = lshr i32 %condval_1.0.3, 16
  %q_halves.sroa.11.14.extract.trunc = trunc nuw i32 %q_halves.sroa.11.14.extract.shift to i16
  %51 = bitcast i16 %q_halves.sroa.11.14.extract.trunc to half
  %q.sroa.7.14.vec.insert = insertelement <4 x half> %q.sroa.7.12.vec.insert, half %51, i64 3
  %52 = insertelement <2 x i32> poison, i32 %condval_2.0, i64 0
  %q.sroa.12.18.vec.insert = bitcast <2 x i32> %52 to <4 x half>
  %q_halves.sroa.17.20.extract.trunc = trunc i32 %condval_2.0.1 to i16
  %53 = bitcast i16 %q_halves.sroa.17.20.extract.trunc to half
  %q.sroa.12.20.vec.insert = insertelement <4 x half> %q.sroa.12.18.vec.insert, half %53, i64 2
  %q_halves.sroa.17.22.extract.shift = lshr i32 %condval_2.0.1, 16
  %q_halves.sroa.17.22.extract.trunc = trunc nuw i32 %q_halves.sroa.17.22.extract.shift to i16
  %54 = bitcast i16 %q_halves.sroa.17.22.extract.trunc to half
  %q.sroa.12.22.vec.insert = insertelement <4 x half> %q.sroa.12.20.vec.insert, half %54, i64 3
  %55 = insertelement <2 x i32> poison, i32 %condval_2.0.2, i64 0
  %q.sroa.17.26.vec.insert = bitcast <2 x i32> %55 to <4 x half>
  %q_halves.sroa.23.28.extract.trunc = trunc i32 %condval_2.0.3 to i16
  %56 = bitcast i16 %q_halves.sroa.23.28.extract.trunc to half
  %q.sroa.17.28.vec.insert = insertelement <4 x half> %q.sroa.17.26.vec.insert, half %56, i64 2
  %q_halves.sroa.23.30.extract.shift = lshr i32 %condval_2.0.3, 16
  %q_halves.sroa.23.30.extract.trunc = trunc nuw i32 %q_halves.sroa.23.30.extract.shift to i16
  %57 = bitcast i16 %q_halves.sroa.23.30.extract.trunc to half
  %q.sroa.17.30.vec.insert = insertelement <4 x half> %q.sroa.17.28.vec.insert, half %57, i64 3
  %58 = insertelement <2 x i32> poison, i32 %condval_1.0.1793, i64 0
  %q.sroa.22.34.vec.insert = bitcast <2 x i32> %58 to <4 x half>
  %q_halves.sroa.29.36.extract.trunc = trunc i32 %condval_1.0.1.1 to i16
  %59 = bitcast i16 %q_halves.sroa.29.36.extract.trunc to half
  %q.sroa.22.36.vec.insert = insertelement <4 x half> %q.sroa.22.34.vec.insert, half %59, i64 2
  %q_halves.sroa.29.38.extract.shift = lshr i32 %condval_1.0.1.1, 16
  %q_halves.sroa.29.38.extract.trunc = trunc nuw i32 %q_halves.sroa.29.38.extract.shift to i16
  %60 = bitcast i16 %q_halves.sroa.29.38.extract.trunc to half
  %q.sroa.22.38.vec.insert = insertelement <4 x half> %q.sroa.22.36.vec.insert, half %60, i64 3
  %61 = insertelement <2 x i32> poison, i32 %condval_1.0.2.1, i64 0
  %q.sroa.27.42.vec.insert = bitcast <2 x i32> %61 to <4 x half>
  %q_halves.sroa.35.44.extract.trunc = trunc i32 %condval_1.0.3.1 to i16
  %62 = bitcast i16 %q_halves.sroa.35.44.extract.trunc to half
  %q.sroa.27.44.vec.insert = insertelement <4 x half> %q.sroa.27.42.vec.insert, half %62, i64 2
  %q_halves.sroa.35.46.extract.shift = lshr i32 %condval_1.0.3.1, 16
  %q_halves.sroa.35.46.extract.trunc = trunc nuw i32 %q_halves.sroa.35.46.extract.shift to i16
  %63 = bitcast i16 %q_halves.sroa.35.46.extract.trunc to half
  %q.sroa.27.46.vec.insert = insertelement <4 x half> %q.sroa.27.44.vec.insert, half %63, i64 3
  %64 = insertelement <2 x i32> poison, i32 %condval_2.0.1795, i64 0
  %q.sroa.32.50.vec.insert = bitcast <2 x i32> %64 to <4 x half>
  %q_halves.sroa.41.52.extract.trunc = trunc i32 %condval_2.0.1.1 to i16
  %65 = bitcast i16 %q_halves.sroa.41.52.extract.trunc to half
  %q.sroa.32.52.vec.insert = insertelement <4 x half> %q.sroa.32.50.vec.insert, half %65, i64 2
  %q_halves.sroa.41.54.extract.shift = lshr i32 %condval_2.0.1.1, 16
  %q_halves.sroa.41.54.extract.trunc = trunc nuw i32 %q_halves.sroa.41.54.extract.shift to i16
  %66 = bitcast i16 %q_halves.sroa.41.54.extract.trunc to half
  %q.sroa.32.54.vec.insert = insertelement <4 x half> %q.sroa.32.52.vec.insert, half %66, i64 3
  %67 = insertelement <2 x i32> poison, i32 %condval_2.0.2.1, i64 0
  %q.sroa.37.58.vec.insert = bitcast <2 x i32> %67 to <4 x half>
  %q_halves.sroa.47.60.extract.trunc = trunc i32 %condval_2.0.3.1 to i16
  %68 = bitcast i16 %q_halves.sroa.47.60.extract.trunc to half
  %q.sroa.37.60.vec.insert = insertelement <4 x half> %q.sroa.37.58.vec.insert, half %68, i64 2
  %q_halves.sroa.47.62.extract.shift = lshr i32 %condval_2.0.3.1, 16
  %q_halves.sroa.47.62.extract.trunc = trunc nuw i32 %q_halves.sroa.47.62.extract.shift to i16
  %69 = bitcast i16 %q_halves.sroa.47.62.extract.trunc to half
  %q.sroa.37.62.vec.insert = insertelement <4 x half> %q.sroa.37.60.vec.insert, half %69, i64 3
  %70 = lshr i32 %2, 2
  %mul152 = and i32 %70, 252
  %add149 = add nuw nsw i32 %mul40, %mul152
  %cmp157.not = icmp ugt i32 %add149, %1
  %spec.select = select i1 %cmp157.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp157.not.1.not = icmp ult i32 %add149, %1
  %spec.select.1 = select i1 %cmp157.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add153.2 = or disjoint i32 %add149, 2
  %cmp157.not.2 = icmp ugt i32 %add153.2, %1
  %spec.select.2 = select i1 %cmp157.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add153.3 = or disjoint i32 %add149, 3
  %cmp157.not.3 = icmp ugt i32 %add153.3, %1
  %spec.select.3 = select i1 %cmp157.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add155.4 = add nuw nsw i32 %add149, 16
  %cmp157.not.4 = icmp ugt i32 %add155.4, %1
  %spec.select.4 = select i1 %cmp157.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add155.5 = add nuw nsw i32 %add149, 17
  %cmp157.not.5 = icmp ugt i32 %add155.5, %1
  %spec.select.5 = select i1 %cmp157.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1
  %add155.6 = add nuw nsw i32 %add149, 18
  %cmp157.not.6 = icmp ugt i32 %add155.6, %1
  %spec.select.6 = select i1 %cmp157.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2
  %add155.7 = add nuw nsw i32 %add149, 19
  %cmp157.not.7 = icmp ugt i32 %add155.7, %1
  %spec.select.7 = select i1 %cmp157.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !80
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !80
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %71), !call_argsrelate !80
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %72), !call_argsrelate !80
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %73), !call_argsrelate !80
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %74), !call_argsrelate !80
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %75), !call_argsrelate !80
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %76), !call_argsrelate !80
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %77), !call_argsrelate !80
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %78), !call_argsrelate !80
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %79), !call_argsrelate !80
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %80), !call_argsrelate !80
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %81), !call_argsrelate !80
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %82), !call_argsrelate !80
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %83), !call_argsrelate !80
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %84), !call_argsrelate !80
  %invariant.gep746 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192
  %87 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep746, i64 %add51
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %87, align 16
  %v.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %87, i64 8
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0..sroa_idx, align 8
  %gep747.1 = getelementptr i8, ptr addrspace(4) %87, i64 1024
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep747.1, align 16
  %v.sroa.7.16.gep747.1.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 1032
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.gep747.1.sroa_idx, align 8
  %gep747.2 = getelementptr i8, ptr addrspace(4) %87, i64 2048
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep747.2, align 16
  %v.sroa.10.32.gep747.2.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 2056
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.gep747.2.sroa_idx, align 8
  %gep747.3 = getelementptr i8, ptr addrspace(4) %87, i64 3072
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep747.3, align 16
  %v.sroa.13.48.gep747.3.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 3080
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.gep747.3.sroa_idx, align 8
  %gep747.4 = getelementptr i8, ptr addrspace(4) %87, i64 4096
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep747.4, align 16
  %v.sroa.16.64.gep747.4.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 4104
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.gep747.4.sroa_idx, align 8
  %gep747.5 = getelementptr i8, ptr addrspace(4) %87, i64 5120
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep747.5, align 16
  %v.sroa.19.80.gep747.5.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 5128
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.gep747.5.sroa_idx, align 8
  %gep747.6 = getelementptr i8, ptr addrspace(4) %87, i64 6144
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep747.6, align 16
  %v.sroa.22.96.gep747.6.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 6152
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.gep747.6.sroa_idx, align 8
  %gep747.7 = getelementptr i8, ptr addrspace(4) %87, i64 7168
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep747.7, align 16
  %v.sroa.25.112.gep747.7.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 7176
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.gep747.7.sroa_idx, align 8
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %85, i64 0
  %mul238 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul238, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %88, -1.260000e+02
  %cond.i.i709 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i710 = fadd contract float %88, %cond.i.i709
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i710)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %89
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %85, i64 1
  %mul238.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul238.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %90, -1.260000e+02
  %cond.i.i709.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i710.1 = fadd contract float %90, %cond.i.i709.1
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i710.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %91
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %85, i64 2
  %mul238.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul238.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %92, -1.260000e+02
  %cond.i.i709.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i710.2 = fadd contract float %92, %cond.i.i709.2
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i710.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %93
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %85, i64 3
  %mul238.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul238.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %94, -1.260000e+02
  %cond.i.i709.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i710.3 = fadd contract float %94, %cond.i.i709.3
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i710.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %95
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %86, i64 0
  %mul238.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul238.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %96, -1.260000e+02
  %cond.i.i709.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i710.4 = fadd contract float %96, %cond.i.i709.4
  %97 = tail call contract float @llvm.exp2.f32(float %add.i.i710.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %97
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %86, i64 1
  %mul238.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul238.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %98, -1.260000e+02
  %cond.i.i709.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i710.5 = fadd contract float %98, %cond.i.i709.5
  %99 = tail call contract float @llvm.exp2.f32(float %add.i.i710.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %99
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %86, i64 2
  %mul238.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul238.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %100, -1.260000e+02
  %cond.i.i709.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i710.6 = fadd contract float %100, %cond.i.i709.6
  %101 = tail call contract float @llvm.exp2.f32(float %add.i.i710.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %101
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %86, i64 3
  %mul238.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul238.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %102, -1.260000e+02
  %cond.i.i709.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i710.7 = fadd contract float %102, %cond.i.i709.7
  %103 = tail call contract float @llvm.exp2.f32(float %add.i.i710.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %103
  %add258 = fadd contract float %mul.i.i, 0.000000e+00
  %add258.1 = fadd contract float %add258, %mul.i.i.4
  %add258.2 = fadd contract float %add258.1, %mul.i.i.1
  %add258.3 = fadd contract float %add258.2, %mul.i.i.5
  %add258.4 = fadd contract float %add258.3, %mul.i.i.2
  %add258.5 = fadd contract float %add258.4, %mul.i.i.6
  %add258.6 = fadd contract float %add258.5, %mul.i.i.3
  %add258.7 = fadd contract float %add258.6, %mul.i.i.7
  %104 = bitcast float %add258.7 to i32
  %105 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %106 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %105) #9
  %xor.i.i711 = xor i32 %106, 32
  %107 = and i32 %106, -64
  %and.i.i712 = add nsw i32 %107, 64
  %cmp.not.i.i713 = icmp slt i32 %xor.i.i711, %and.i.i712
  %cond.i.i714 = select i1 %cmp.not.i.i713, i32 %xor.i.i711, i32 %106
  %shl.i.i715 = shl i32 %cond.i.i714, 2
  %108 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i715, i32 %104)
  %109 = bitcast i32 %108 to float
  %add.i = fadd contract float %add258.7, %109
  %110 = bitcast float %add.i to i32
  %111 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %112 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %111) #9
  %xor.i.i716 = xor i32 %112, 16
  %113 = and i32 %112, -64
  %and.i.i717 = add nsw i32 %113, 64
  %cmp.not.i.i718 = icmp slt i32 %xor.i.i716, %and.i.i717
  %cond.i.i719 = select i1 %cmp.not.i.i718, i32 %xor.i.i716, i32 %112
  %shl.i.i720 = shl i32 %cond.i.i719, 2
  %114 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i720, i32 %110)
  %115 = bitcast i32 %114 to float
  %add.i.i = fadd contract float %add.i, %115
  %cmp267 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp267, float %div, float 0.000000e+00
  %mul280 = fmul contract float %condval_4.0, %mul.i.i
  %mul280.1 = fmul contract float %condval_4.0, %mul.i.i.1
  %mul280.2 = fmul contract float %condval_4.0, %mul.i.i.2
  %mul280.3 = fmul contract float %condval_4.0, %mul.i.i.3
  %mul280.4 = fmul contract float %condval_4.0, %mul.i.i.4
  %mul280.5 = fmul contract float %condval_4.0, %mul.i.i.5
  %mul280.6 = fmul contract float %condval_4.0, %mul.i.i.6
  %mul280.7 = fmul contract float %condval_4.0, %mul.i.i.7
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280)
  %117 = insertelement <4 x i16> poison, i16 %116, i64 0
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.1)
  %119 = insertelement <4 x i16> %117, i16 %118, i64 1
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.2)
  %121 = insertelement <4 x i16> %119, i16 %120, i64 2
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.3)
  %123 = insertelement <4 x i16> %121, i16 %122, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %123 to <4 x half>
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.4)
  %125 = insertelement <4 x i16> poison, i16 %124, i64 0
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.5)
  %127 = insertelement <4 x i16> %125, i16 %126, i64 1
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.6)
  %129 = insertelement <4 x i16> %127, i16 %128, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.7)
  %131 = insertelement <4 x i16> %129, i16 %130, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %131 to <4 x half>
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !80
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %132), !call_argsrelate !80
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %133), !call_argsrelate !80
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %134), !call_argsrelate !80
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %135), !call_argsrelate !80
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %136), !call_argsrelate !80
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %137), !call_argsrelate !80
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %138), !call_argsrelate !80
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %139), !call_argsrelate !80
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %140, i64 0
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %148 to i32
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %140, i64 1
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %149 to i32
  %output_reg.sroa.0.2.insert.shift = shl nuw i32 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i32 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %140, i64 2
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.7.4.insert.ext = zext i16 %150 to i32
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %140, i64 3
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.7.6.insert.ext = zext i16 %151 to i32
  %output_reg.sroa.7.6.insert.shift = shl nuw i32 %output_reg.sroa.7.6.insert.ext, 16
  %output_reg.sroa.7.6.insert.insert = or disjoint i32 %output_reg.sroa.7.6.insert.shift, %output_reg.sroa.7.4.insert.ext
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %141, i64 0
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.12.8.insert.ext = zext i16 %152 to i32
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %141, i64 1
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.12.10.insert.ext = zext i16 %153 to i32
  %output_reg.sroa.12.10.insert.shift = shl nuw i32 %output_reg.sroa.12.10.insert.ext, 16
  %output_reg.sroa.12.10.insert.insert = or disjoint i32 %output_reg.sroa.12.10.insert.shift, %output_reg.sroa.12.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %141, i64 2
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.17.12.insert.ext = zext i16 %154 to i32
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %141, i64 3
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.17.14.insert.ext = zext i16 %155 to i32
  %output_reg.sroa.17.14.insert.shift = shl nuw i32 %output_reg.sroa.17.14.insert.ext, 16
  %output_reg.sroa.17.14.insert.insert = or disjoint i32 %output_reg.sroa.17.14.insert.shift, %output_reg.sroa.17.12.insert.ext
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %142, i64 0
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.22.16.insert.ext = zext i16 %156 to i32
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %142, i64 1
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.22.18.insert.ext = zext i16 %157 to i32
  %output_reg.sroa.22.18.insert.shift = shl nuw i32 %output_reg.sroa.22.18.insert.ext, 16
  %output_reg.sroa.22.18.insert.insert = or disjoint i32 %output_reg.sroa.22.18.insert.shift, %output_reg.sroa.22.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %142, i64 2
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.27.20.insert.ext = zext i16 %158 to i32
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %142, i64 3
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.27.22.insert.ext = zext i16 %159 to i32
  %output_reg.sroa.27.22.insert.shift = shl nuw i32 %output_reg.sroa.27.22.insert.ext, 16
  %output_reg.sroa.27.22.insert.insert = or disjoint i32 %output_reg.sroa.27.22.insert.shift, %output_reg.sroa.27.20.insert.ext
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %143, i64 0
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.32.24.insert.ext = zext i16 %160 to i32
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %143, i64 1
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.32.26.insert.ext = zext i16 %161 to i32
  %output_reg.sroa.32.26.insert.shift = shl nuw i32 %output_reg.sroa.32.26.insert.ext, 16
  %output_reg.sroa.32.26.insert.insert = or disjoint i32 %output_reg.sroa.32.26.insert.shift, %output_reg.sroa.32.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %143, i64 2
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.37.28.insert.ext = zext i16 %162 to i32
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %143, i64 3
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.37.30.insert.ext = zext i16 %163 to i32
  %output_reg.sroa.37.30.insert.shift = shl nuw i32 %output_reg.sroa.37.30.insert.ext, 16
  %output_reg.sroa.37.30.insert.insert = or disjoint i32 %output_reg.sroa.37.30.insert.shift, %output_reg.sroa.37.28.insert.ext
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %144, i64 0
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.42.32.insert.ext = zext i16 %164 to i32
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %144, i64 1
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.42.34.insert.ext = zext i16 %165 to i32
  %output_reg.sroa.42.34.insert.shift = shl nuw i32 %output_reg.sroa.42.34.insert.ext, 16
  %output_reg.sroa.42.34.insert.insert = or disjoint i32 %output_reg.sroa.42.34.insert.shift, %output_reg.sroa.42.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %144, i64 2
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.47.36.insert.ext = zext i16 %166 to i32
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %144, i64 3
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.47.38.insert.ext = zext i16 %167 to i32
  %output_reg.sroa.47.38.insert.shift = shl nuw i32 %output_reg.sroa.47.38.insert.ext, 16
  %output_reg.sroa.47.38.insert.insert = or disjoint i32 %output_reg.sroa.47.38.insert.shift, %output_reg.sroa.47.36.insert.ext
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %145, i64 0
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.52.40.insert.ext = zext i16 %168 to i32
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %145, i64 1
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.52.42.insert.ext = zext i16 %169 to i32
  %output_reg.sroa.52.42.insert.shift = shl nuw i32 %output_reg.sroa.52.42.insert.ext, 16
  %output_reg.sroa.52.42.insert.insert = or disjoint i32 %output_reg.sroa.52.42.insert.shift, %output_reg.sroa.52.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %145, i64 2
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.57.44.insert.ext = zext i16 %170 to i32
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %145, i64 3
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.57.46.insert.ext = zext i16 %171 to i32
  %output_reg.sroa.57.46.insert.shift = shl nuw i32 %output_reg.sroa.57.46.insert.ext, 16
  %output_reg.sroa.57.46.insert.insert = or disjoint i32 %output_reg.sroa.57.46.insert.shift, %output_reg.sroa.57.44.insert.ext
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %146, i64 0
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.62.48.insert.ext = zext i16 %172 to i32
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %146, i64 1
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.62.50.insert.ext = zext i16 %173 to i32
  %output_reg.sroa.62.50.insert.shift = shl nuw i32 %output_reg.sroa.62.50.insert.ext, 16
  %output_reg.sroa.62.50.insert.insert = or disjoint i32 %output_reg.sroa.62.50.insert.shift, %output_reg.sroa.62.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %146, i64 2
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.67.52.insert.ext = zext i16 %174 to i32
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %146, i64 3
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.67.54.insert.ext = zext i16 %175 to i32
  %output_reg.sroa.67.54.insert.shift = shl nuw i32 %output_reg.sroa.67.54.insert.ext, 16
  %output_reg.sroa.67.54.insert.insert = or disjoint i32 %output_reg.sroa.67.54.insert.shift, %output_reg.sroa.67.52.insert.ext
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %147, i64 0
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.72.56.insert.ext = zext i16 %176 to i32
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %147, i64 1
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.72.58.insert.ext = zext i16 %177 to i32
  %output_reg.sroa.72.58.insert.shift = shl nuw i32 %output_reg.sroa.72.58.insert.ext, 16
  %output_reg.sroa.72.58.insert.insert = or disjoint i32 %output_reg.sroa.72.58.insert.shift, %output_reg.sroa.72.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %147, i64 2
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.77.60.insert.ext = zext i16 %178 to i32
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %147, i64 3
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.77.62.insert.ext = zext i16 %179 to i32
  %output_reg.sroa.77.62.insert.shift = shl nuw i32 %output_reg.sroa.77.62.insert.ext, 16
  %output_reg.sroa.77.62.insert.insert = or disjoint i32 %output_reg.sroa.77.62.insert.shift, %output_reg.sroa.77.60.insert.ext
  br label %if.end394

if.else372:                                       ; preds = %entry, %land.rhs
  %.pre = and i32 %2, 8
  %.pre1017 = shl nuw nsw i32 %2, 3
  %.pre1018 = lshr i32 %2, 2
  %.pre1020 = and i32 %.pre1018, 252
  br label %if.end394

if.end394:                                        ; preds = %for.cond43.preheader, %if.else372
  %mul561.pre-phi = phi i32 [ %mul152, %for.cond43.preheader ], [ %.pre1020, %if.else372 ]
  %.pre-phi = phi i32 [ %12, %for.cond43.preheader ], [ %.pre1017, %if.else372 ]
  %and436.pre-phi = phi i32 [ %and85, %for.cond43.preheader ], [ %.pre, %if.else372 ]
  %output_reg.sroa.57.0 = phi i32 [ %output_reg.sroa.57.46.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.52.0 = phi i32 [ %output_reg.sroa.52.42.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.47.0 = phi i32 [ %output_reg.sroa.47.38.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.42.0 = phi i32 [ %output_reg.sroa.42.34.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.37.0 = phi i32 [ %output_reg.sroa.37.30.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.32.0 = phi i32 [ %output_reg.sroa.32.26.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.27.0 = phi i32 [ %output_reg.sroa.27.22.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.22.0 = phi i32 [ %output_reg.sroa.22.18.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.17.0 = phi i32 [ %output_reg.sroa.17.14.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.12.0 = phi i32 [ %output_reg.sroa.12.10.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.7.0 = phi i32 [ %output_reg.sroa.7.6.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.0.0 = phi i32 [ %output_reg.sroa.0.2.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.62.0 = phi i32 [ %output_reg.sroa.62.50.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.67.0 = phi i32 [ %output_reg.sroa.67.54.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.72.0 = phi i32 [ %output_reg.sroa.72.58.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %output_reg.sroa.77.0 = phi i32 [ %output_reg.sroa.77.62.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ]
  %cmp437.not.not = icmp eq i32 %and436.pre-phi, 0
  %.695 = select i1 %cmp437.not.not, i32 %output_reg.sroa.12.0, i32 %output_reg.sroa.0.0
  %180 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %181 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %180) #9
  %xor.i.i721 = xor i32 %181, 8
  %182 = and i32 %181, -64
  %and.i.i722 = add nsw i32 %182, 64
  %cmp.not.i.i723 = icmp slt i32 %xor.i.i721, %and.i.i722
  %cond.i.i724 = select i1 %cmp.not.i.i723, i32 %xor.i.i721, i32 %181
  %shl.i.i725 = shl i32 %cond.i.i724, 2
  %183 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725, i32 %.695)
  %condval_6.0 = select i1 %cmp437.not.not, i32 %output_reg.sroa.0.0, i32 %183
  %condval_7.0 = select i1 %cmp437.not.not, i32 %183, i32 %output_reg.sroa.12.0
  %.695.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.17.0, i32 %output_reg.sroa.7.0
  %184 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %185 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %184) #9
  %xor.i.i721.1 = xor i32 %185, 8
  %186 = and i32 %185, -64
  %and.i.i722.1 = add nsw i32 %186, 64
  %cmp.not.i.i723.1 = icmp slt i32 %xor.i.i721.1, %and.i.i722.1
  %cond.i.i724.1 = select i1 %cmp.not.i.i723.1, i32 %xor.i.i721.1, i32 %185
  %shl.i.i725.1 = shl i32 %cond.i.i724.1, 2
  %187 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1, i32 %.695.1)
  %condval_6.0.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.7.0, i32 %187
  %condval_7.0.1 = select i1 %cmp437.not.not, i32 %187, i32 %output_reg.sroa.17.0
  %.695.1832 = select i1 %cmp437.not.not, i32 %output_reg.sroa.32.0, i32 %output_reg.sroa.22.0
  %188 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %189 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %188) #9
  %xor.i.i721.1833 = xor i32 %189, 8
  %190 = and i32 %189, -64
  %and.i.i722.1834 = add nsw i32 %190, 64
  %cmp.not.i.i723.1835 = icmp slt i32 %xor.i.i721.1833, %and.i.i722.1834
  %cond.i.i724.1836 = select i1 %cmp.not.i.i723.1835, i32 %xor.i.i721.1833, i32 %189
  %shl.i.i725.1837 = shl i32 %cond.i.i724.1836, 2
  %191 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1837, i32 %.695.1832)
  %condval_6.0.1838 = select i1 %cmp437.not.not, i32 %output_reg.sroa.22.0, i32 %191
  %condval_7.0.1840 = select i1 %cmp437.not.not, i32 %191, i32 %output_reg.sroa.32.0
  %.695.1.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.37.0, i32 %output_reg.sroa.27.0
  %192 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %193 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %192) #9
  %xor.i.i721.1.1 = xor i32 %193, 8
  %194 = and i32 %193, -64
  %and.i.i722.1.1 = add nsw i32 %194, 64
  %cmp.not.i.i723.1.1 = icmp slt i32 %xor.i.i721.1.1, %and.i.i722.1.1
  %cond.i.i724.1.1 = select i1 %cmp.not.i.i723.1.1, i32 %xor.i.i721.1.1, i32 %193
  %shl.i.i725.1.1 = shl i32 %cond.i.i724.1.1, 2
  %195 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1.1, i32 %.695.1.1)
  %condval_6.0.1.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.27.0, i32 %195
  %condval_7.0.1.1 = select i1 %cmp437.not.not, i32 %195, i32 %output_reg.sroa.37.0
  %.695.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.52.0, i32 %output_reg.sroa.42.0
  %196 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %197 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %196) #9
  %xor.i.i721.2 = xor i32 %197, 8
  %198 = and i32 %197, -64
  %and.i.i722.2 = add nsw i32 %198, 64
  %cmp.not.i.i723.2 = icmp slt i32 %xor.i.i721.2, %and.i.i722.2
  %cond.i.i724.2 = select i1 %cmp.not.i.i723.2, i32 %xor.i.i721.2, i32 %197
  %shl.i.i725.2 = shl i32 %cond.i.i724.2, 2
  %199 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.2, i32 %.695.2)
  %condval_6.0.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.42.0, i32 %199
  %condval_7.0.2 = select i1 %cmp437.not.not, i32 %199, i32 %output_reg.sroa.52.0
  %.695.1.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.57.0, i32 %output_reg.sroa.47.0
  %200 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %201 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %200) #9
  %xor.i.i721.1.2 = xor i32 %201, 8
  %202 = and i32 %201, -64
  %and.i.i722.1.2 = add nsw i32 %202, 64
  %cmp.not.i.i723.1.2 = icmp slt i32 %xor.i.i721.1.2, %and.i.i722.1.2
  %cond.i.i724.1.2 = select i1 %cmp.not.i.i723.1.2, i32 %xor.i.i721.1.2, i32 %201
  %shl.i.i725.1.2 = shl i32 %cond.i.i724.1.2, 2
  %203 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1.2, i32 %.695.1.2)
  %condval_6.0.1.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.47.0, i32 %203
  %condval_7.0.1.2 = select i1 %cmp437.not.not, i32 %203, i32 %output_reg.sroa.57.0
  %.695.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.72.0, i32 %output_reg.sroa.62.0
  %204 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %205 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %204) #9
  %xor.i.i721.3 = xor i32 %205, 8
  %206 = and i32 %205, -64
  %and.i.i722.3 = add nsw i32 %206, 64
  %cmp.not.i.i723.3 = icmp slt i32 %xor.i.i721.3, %and.i.i722.3
  %cond.i.i724.3 = select i1 %cmp.not.i.i723.3, i32 %xor.i.i721.3, i32 %205
  %shl.i.i725.3 = shl i32 %cond.i.i724.3, 2
  %207 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.3, i32 %.695.3)
  %condval_6.0.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.62.0, i32 %207
  %condval_7.0.3 = select i1 %cmp437.not.not, i32 %207, i32 %output_reg.sroa.72.0
  %.695.1.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.77.0, i32 %output_reg.sroa.67.0
  %208 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %209 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %208) #9
  %xor.i.i721.1.3 = xor i32 %209, 8
  %210 = and i32 %209, -64
  %and.i.i722.1.3 = add nsw i32 %210, 64
  %cmp.not.i.i723.1.3 = icmp slt i32 %xor.i.i721.1.3, %and.i.i722.1.3
  %cond.i.i724.1.3 = select i1 %cmp.not.i.i723.1.3, i32 %xor.i.i721.1.3, i32 %209
  %shl.i.i725.1.3 = shl i32 %cond.i.i724.1.3, 2
  %211 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1.3, i32 %.695.1.3)
  %condval_6.0.1.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.67.0, i32 %211
  %condval_7.0.1.3 = select i1 %cmp437.not.not, i32 %211, i32 %output_reg.sroa.77.0
  %and487 = and i32 %2, 4
  %cmp488.not.not = icmp eq i32 %and487, 0
  %.696 = select i1 %cmp488.not.not, i32 %condval_6.0.1838, i32 %condval_6.0
  %212 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %213 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %212) #9
  %xor.i.i726 = xor i32 %213, 4
  %214 = and i32 %213, -64
  %and.i.i727 = add nsw i32 %214, 64
  %cmp.not.i.i728 = icmp slt i32 %xor.i.i726, %and.i.i727
  %cond.i.i729 = select i1 %cmp.not.i.i728, i32 %xor.i.i726, i32 %213
  %shl.i.i730 = shl i32 %cond.i.i729, 2
  %215 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730, i32 %.696)
  %condval_9.0 = select i1 %cmp488.not.not, i32 %condval_6.0, i32 %215
  %output_halves.sroa.0.0.insert.ext = zext i32 %condval_9.0 to i64
  %condval_10.0 = select i1 %cmp488.not.not, i32 %215, i32 %condval_6.0.1838
  %output_halves.sroa.8.16.insert.ext = zext i32 %condval_10.0 to i64
  %.696.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1.1, i32 %condval_6.0.1
  %216 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %217 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %216) #9
  %xor.i.i726.1 = xor i32 %217, 4
  %218 = and i32 %217, -64
  %and.i.i727.1 = add nsw i32 %218, 64
  %cmp.not.i.i728.1 = icmp slt i32 %xor.i.i726.1, %and.i.i727.1
  %cond.i.i729.1 = select i1 %cmp.not.i.i728.1, i32 %xor.i.i726.1, i32 %217
  %shl.i.i730.1 = shl i32 %cond.i.i729.1, 2
  %219 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.1, i32 %.696.1)
  %condval_9.0.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1, i32 %219
  %output_halves.sroa.0.4.insert.ext = zext i32 %condval_9.0.1 to i64
  %output_halves.sroa.0.4.insert.shift = shl nuw i64 %output_halves.sroa.0.4.insert.ext, 32
  %output_halves.sroa.0.4.insert.insert = or disjoint i64 %output_halves.sroa.0.4.insert.shift, %output_halves.sroa.0.0.insert.ext
  %condval_10.0.1 = select i1 %cmp488.not.not, i32 %219, i32 %condval_6.0.1.1
  %output_halves.sroa.8.20.insert.ext = zext i32 %condval_10.0.1 to i64
  %output_halves.sroa.8.20.insert.shift = shl nuw i64 %output_halves.sroa.8.20.insert.ext, 32
  %output_halves.sroa.8.20.insert.insert = or disjoint i64 %output_halves.sroa.8.20.insert.shift, %output_halves.sroa.8.16.insert.ext
  %.696.2 = select i1 %cmp488.not.not, i32 %condval_7.0.1840, i32 %condval_7.0
  %220 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %221 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %220) #9
  %xor.i.i726.2 = xor i32 %221, 4
  %222 = and i32 %221, -64
  %and.i.i727.2 = add nsw i32 %222, 64
  %cmp.not.i.i728.2 = icmp slt i32 %xor.i.i726.2, %and.i.i727.2
  %cond.i.i729.2 = select i1 %cmp.not.i.i728.2, i32 %xor.i.i726.2, i32 %221
  %shl.i.i730.2 = shl i32 %cond.i.i729.2, 2
  %223 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.2, i32 %.696.2)
  %condval_9.0.2 = select i1 %cmp488.not.not, i32 %condval_7.0, i32 %223
  %output_halves.sroa.5.8.insert.ext = zext i32 %condval_9.0.2 to i64
  %condval_10.0.2 = select i1 %cmp488.not.not, i32 %223, i32 %condval_7.0.1840
  %output_halves.sroa.11.24.insert.ext = zext i32 %condval_10.0.2 to i64
  %.696.3 = select i1 %cmp488.not.not, i32 %condval_7.0.1.1, i32 %condval_7.0.1
  %224 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %225 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %224) #9
  %xor.i.i726.3 = xor i32 %225, 4
  %226 = and i32 %225, -64
  %and.i.i727.3 = add nsw i32 %226, 64
  %cmp.not.i.i728.3 = icmp slt i32 %xor.i.i726.3, %and.i.i727.3
  %cond.i.i729.3 = select i1 %cmp.not.i.i728.3, i32 %xor.i.i726.3, i32 %225
  %shl.i.i730.3 = shl i32 %cond.i.i729.3, 2
  %227 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.3, i32 %.696.3)
  %condval_9.0.3 = select i1 %cmp488.not.not, i32 %condval_7.0.1, i32 %227
  %output_halves.sroa.5.12.insert.ext = zext i32 %condval_9.0.3 to i64
  %output_halves.sroa.5.12.insert.shift = shl nuw i64 %output_halves.sroa.5.12.insert.ext, 32
  %output_halves.sroa.5.12.insert.insert = or disjoint i64 %output_halves.sroa.5.12.insert.shift, %output_halves.sroa.5.8.insert.ext
  %condval_10.0.3 = select i1 %cmp488.not.not, i32 %227, i32 %condval_7.0.1.1
  %output_halves.sroa.11.28.insert.ext = zext i32 %condval_10.0.3 to i64
  %output_halves.sroa.11.28.insert.shift = shl nuw i64 %output_halves.sroa.11.28.insert.ext, 32
  %output_halves.sroa.11.28.insert.insert = or disjoint i64 %output_halves.sroa.11.28.insert.shift, %output_halves.sroa.11.24.insert.ext
  %.696.1845 = select i1 %cmp488.not.not, i32 %condval_6.0.3, i32 %condval_6.0.2
  %228 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %229 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %228) #9
  %xor.i.i726.1846 = xor i32 %229, 4
  %230 = and i32 %229, -64
  %and.i.i727.1847 = add nsw i32 %230, 64
  %cmp.not.i.i728.1848 = icmp slt i32 %xor.i.i726.1846, %and.i.i727.1847
  %cond.i.i729.1849 = select i1 %cmp.not.i.i728.1848, i32 %xor.i.i726.1846, i32 %229
  %shl.i.i730.1850 = shl i32 %cond.i.i729.1849, 2
  %231 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.1850, i32 %.696.1845)
  %condval_9.0.1851 = select i1 %cmp488.not.not, i32 %condval_6.0.2, i32 %231
  %output_halves.sroa.14.32.insert.ext = zext i32 %condval_9.0.1851 to i64
  %condval_10.0.1853 = select i1 %cmp488.not.not, i32 %231, i32 %condval_6.0.3
  %output_halves.sroa.20.48.insert.ext = zext i32 %condval_10.0.1853 to i64
  %.696.1.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1.3, i32 %condval_6.0.1.2
  %232 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %233 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %232) #9
  %xor.i.i726.1.1 = xor i32 %233, 4
  %234 = and i32 %233, -64
  %and.i.i727.1.1 = add nsw i32 %234, 64
  %cmp.not.i.i728.1.1 = icmp slt i32 %xor.i.i726.1.1, %and.i.i727.1.1
  %cond.i.i729.1.1 = select i1 %cmp.not.i.i728.1.1, i32 %xor.i.i726.1.1, i32 %233
  %shl.i.i730.1.1 = shl i32 %cond.i.i729.1.1, 2
  %235 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.1.1, i32 %.696.1.1)
  %condval_9.0.1.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1.2, i32 %235
  %output_halves.sroa.14.36.insert.ext = zext i32 %condval_9.0.1.1 to i64
  %output_halves.sroa.14.36.insert.shift = shl nuw i64 %output_halves.sroa.14.36.insert.ext, 32
  %output_halves.sroa.14.36.insert.insert = or disjoint i64 %output_halves.sroa.14.36.insert.shift, %output_halves.sroa.14.32.insert.ext
  %condval_10.0.1.1 = select i1 %cmp488.not.not, i32 %235, i32 %condval_6.0.1.3
  %output_halves.sroa.20.52.insert.ext = zext i32 %condval_10.0.1.1 to i64
  %output_halves.sroa.20.52.insert.shift = shl nuw i64 %output_halves.sroa.20.52.insert.ext, 32
  %output_halves.sroa.20.52.insert.insert = or disjoint i64 %output_halves.sroa.20.52.insert.shift, %output_halves.sroa.20.48.insert.ext
  %.696.2.1 = select i1 %cmp488.not.not, i32 %condval_7.0.3, i32 %condval_7.0.2
  %236 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %237 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %236) #9
  %xor.i.i726.2.1 = xor i32 %237, 4
  %238 = and i32 %237, -64
  %and.i.i727.2.1 = add nsw i32 %238, 64
  %cmp.not.i.i728.2.1 = icmp slt i32 %xor.i.i726.2.1, %and.i.i727.2.1
  %cond.i.i729.2.1 = select i1 %cmp.not.i.i728.2.1, i32 %xor.i.i726.2.1, i32 %237
  %shl.i.i730.2.1 = shl i32 %cond.i.i729.2.1, 2
  %239 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.2.1, i32 %.696.2.1)
  %condval_9.0.2.1 = select i1 %cmp488.not.not, i32 %condval_7.0.2, i32 %239
  %output_halves.sroa.17.40.insert.ext = zext i32 %condval_9.0.2.1 to i64
  %condval_10.0.2.1 = select i1 %cmp488.not.not, i32 %239, i32 %condval_7.0.3
  %output_halves.sroa.23.56.insert.ext = zext i32 %condval_10.0.2.1 to i64
  %.696.3.1 = select i1 %cmp488.not.not, i32 %condval_7.0.1.3, i32 %condval_7.0.1.2
  %240 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %241 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %240) #9
  %xor.i.i726.3.1 = xor i32 %241, 4
  %242 = and i32 %241, -64
  %and.i.i727.3.1 = add nsw i32 %242, 64
  %cmp.not.i.i728.3.1 = icmp slt i32 %xor.i.i726.3.1, %and.i.i727.3.1
  %cond.i.i729.3.1 = select i1 %cmp.not.i.i728.3.1, i32 %xor.i.i726.3.1, i32 %241
  %shl.i.i730.3.1 = shl i32 %cond.i.i729.3.1, 2
  %243 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.3.1, i32 %.696.3.1)
  %condval_9.0.3.1 = select i1 %cmp488.not.not, i32 %condval_7.0.1.2, i32 %243
  %output_halves.sroa.17.44.insert.ext = zext i32 %condval_9.0.3.1 to i64
  %output_halves.sroa.17.44.insert.shift = shl nuw i64 %output_halves.sroa.17.44.insert.ext, 32
  %output_halves.sroa.17.44.insert.insert = or disjoint i64 %output_halves.sroa.17.44.insert.shift, %output_halves.sroa.17.40.insert.ext
  %condval_10.0.3.1 = select i1 %cmp488.not.not, i32 %243, i32 %condval_7.0.1.3
  %output_halves.sroa.23.60.insert.ext = zext i32 %condval_10.0.3.1 to i64
  %output_halves.sroa.23.60.insert.shift = shl nuw i64 %output_halves.sroa.23.60.insert.ext, 32
  %output_halves.sroa.23.60.insert.insert = or disjoint i64 %output_halves.sroa.23.60.insert.shift, %output_halves.sroa.23.56.insert.ext
  %mul544 = and i32 %and, 384
  %mul552 = and i32 %.pre-phi, 32
  %244 = shl nuw nsw i32 %2, 1
  %mul557 = and i32 %244, 16
  %245 = or disjoint i32 %mul544, %mul552
  %246 = or disjoint i32 %245, %mul557
  %add537 = or disjoint i32 %246, %add21
  %add541 = add nuw nsw i32 %add537, %mul561.pre-phi
  %idx.ext563 = sext i32 %add541 to i64
  %add.ptr564 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563
  store i64 %output_halves.sroa.0.4.insert.insert, ptr addrspace(1) %add.ptr564, align 8
  %add545.1 = or disjoint i32 %add541, 1024
  %idx.ext563.1 = sext i32 %add545.1 to i64
  %add.ptr564.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.1
  store i64 %output_halves.sroa.5.12.insert.insert, ptr addrspace(1) %add.ptr564.1, align 8
  %247 = sext i32 %add541 to i64
  %248 = getelementptr %struct.__half, ptr addrspace(1) %Output.coerce, i64 %247
  %add.ptr564.2 = getelementptr i8, ptr addrspace(1) %248, i64 1024
  store i64 %output_halves.sroa.8.20.insert.insert, ptr addrspace(1) %add.ptr564.2, align 8
  %add548.3 = add i32 %add541, 1536
  %idx.ext563.3 = sext i32 %add548.3 to i64
  %add.ptr564.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.3
  store i64 %output_halves.sroa.11.28.insert.insert, ptr addrspace(1) %add.ptr564.3, align 8
  %249 = sext i32 %add541 to i64
  %250 = getelementptr %struct.__half, ptr addrspace(1) %Output.coerce, i64 %249
  %add.ptr564.4 = getelementptr i8, ptr addrspace(1) %250, i64 128
  store i64 %output_halves.sroa.14.36.insert.insert, ptr addrspace(1) %add.ptr564.4, align 8
  %add562.5 = add i32 %add541, 1088
  %idx.ext563.5 = sext i32 %add562.5 to i64
  %add.ptr564.5 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.5
  store i64 %output_halves.sroa.17.44.insert.insert, ptr addrspace(1) %add.ptr564.5, align 8
  %251 = sext i32 %add541 to i64
  %252 = getelementptr %struct.__half, ptr addrspace(1) %Output.coerce, i64 %251
  %add.ptr564.6 = getelementptr i8, ptr addrspace(1) %252, i64 1152
  store i64 %output_halves.sroa.20.52.insert.insert, ptr addrspace(1) %add.ptr564.6, align 8
  %add562.7 = add i32 %add541, 1600
  %idx.ext563.7 = sext i32 %add562.7 to i64
  %add.ptr564.7 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.7
  store i64 %output_halves.sroa.23.60.insert.insert, ptr addrspace(1) %add.ptr564.7, align 8
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

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #7

declare float @llvm.exp2.f32(float) #8

declare float @llvm.minnum.f32(float, float) #8

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nomerge }


