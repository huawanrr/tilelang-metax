; ModuleID = 'experiments/20261017_resume/packed_binary/oj6_m1_p1.bc'
source_filename = "/tmp/tmpallhxqqs/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_pure_virtual() local_unnamed_addr #0 !dbg !5 {
entry:
  tail call void @llvm.trap(), !dbg !9
  unreachable, !dbg !10
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #1

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 !dbg !11 {
entry:
  tail call void @llvm.trap(), !dbg !12
  unreachable, !dbg !13
}

; Function Attrs: mustprogress nounwind
define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 !dbg !14 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr(), !dbg !16
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32, !dbg !16
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !dbg !16, !tbaa !17
  %2 = inttoptr i64 %1 to ptr, !dbg !16
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40, !dbg !16
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !dbg !16, !tbaa !17
  %4 = inttoptr i64 %3 to ptr, !dbg !16
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12, !dbg !16
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16, !dbg !16
  %5 = load ptr, ptr %thread_counter.i, align 8, !dbg !16, !tbaa !21
  %cmp.not.i = icmp eq ptr %5, null, !dbg !16
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i, !dbg !16

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr(), !dbg !16
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12, !dbg !16
  %8 = load i32, ptr addrspace(4) %7, align 4, !dbg !16, !range !28, !invariant.load !8
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4, !dbg !16
  %10 = load i32, ptr addrspace(4) %9, align 4, !dbg !16, !invariant.load !8
  %conv.i14.i.i = and i32 %10, 65535, !dbg !16
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i, !dbg !16
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i, !dbg !16
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i, !dbg !16
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32, !dbg !16
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i, !dbg !16
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16, !dbg !16
  %12 = load i32, ptr addrspace(4) %11, align 4, !dbg !16, !range !28, !invariant.load !8
  %13 = lshr i32 %10, 16, !dbg !16
  %div.i.i.i = udiv i32 %12, %13, !dbg !16
  %mul.i.i.i = mul i32 %div.i.i.i, %13, !dbg !16
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i, !dbg !16
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32, !dbg !16
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i, !dbg !16
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !dbg !16, !range !29
  %mul.i.i = mul i32 %add.i.i.i, %14, !dbg !16
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !16, !range !29
  %mul320.i.i = add i32 %mul.i.i, %15, !dbg !16
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i, !dbg !16
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !16, !range !29
  %add8.i.i = add i32 %add.i.i, %16, !dbg !16
  %conv.i.i = zext i32 %add8.i.i to i64, !dbg !16
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i, !dbg !16
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i), !dbg !16
  br label %while.cond.i, !dbg !16

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i, !dbg !16

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit.i, !dbg !16

if.end.i.i:                                       ; preds = %while.cond.i
  %19 = atomicrmw or ptr %arrayidx.i, i32 0 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit.i, !dbg !16

_Z9atomicAddPii.exit.i:                           ; preds = %if.end.i.i, %if.then.i.i
  %retval.0.i.i = phi i32 [ %18, %if.then.i.i ], [ %19, %if.end.i.i ], !dbg !16
  %cmp6.i = icmp sgt i32 %retval.0.i.i, 0, !dbg !16
  br i1 %cmp6.i, label %while.body.i, label %if.end.i, !dbg !16

while.body.i:                                     ; preds = %_Z9atomicAddPii.exit.i
  tail call void @llvm.mxc.sleep(i32 1), !dbg !16
  br label %while.cond.i, !dbg !16, !llvm.loop !31

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i), !dbg !16
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i, !dbg !16

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  %add.i37.i = add nsw i32 %21, -1, !dbg !16
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ], !dbg !16
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4, !dbg !16
  %23 = load i32, ptr %call_deep.i, align 4, !dbg !16, !tbaa !33
  %cmp8.i = icmp eq i32 %23, 0, !dbg !16
  br i1 %cmp8.i, label %if.then9.i, label %if.else.i, !dbg !16

if.then9.i:                                       ; preds = %_Z9atomicAddPii.exit38.i
  %cmp10.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp10.i, label %if.then11.i, label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.then11.i:                                      ; preds = %if.then9.i
  tail call void @llvm.mxc.sleep(i32 30), !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.else.i:                                        ; preds = %_Z9atomicAddPii.exit38.i
  %parent_wrap13.i = getelementptr inbounds i8, ptr %4, i64 24, !dbg !16
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !dbg !16, !tbaa !34
  %25 = load i32, ptr %4, align 8, !dbg !16, !tbaa !35
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16, !dbg !16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !dbg !16, !tbaa !21
  %idxprom.i = zext i32 %25 to i64, !dbg !16
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i, !dbg !16
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i, !dbg !16

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24, !dbg !16
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !dbg !16, !tbaa !36
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64, !dbg !16
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i, !dbg !16
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96, !dbg !16
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80, !dbg !16
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !dbg !16, !tbaa !38
  %29 = inttoptr i64 %28 to ptr, !dbg !16
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295, !dbg !16
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i, !dbg !16
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i), !dbg !16
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i, !dbg !16

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  %and.i.i.i = and i32 %31, 2147483647, !dbg !16
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  br label %if.end20.i, !dbg !16

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %if.end20.i, !dbg !16

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i), !dbg !16
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i, !dbg !16

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  %add.i42.i = add nsw i32 %34, -1, !dbg !16
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void, !dbg !39
}

; Function Attrs: convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 !dbg !40 {
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
  %6 = sext i32 %add15 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %q_words.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 4, !dbg !45
  %q_words.sroa.4.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.4.0.add.ptr.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %q_words.sroa.5.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.5.0.add.ptr.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.6.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 12, !dbg !45
  %q_words.sroa.6.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.6.0.add.ptr.sroa_idx, align 4, !dbg !45, !tbaa !30
  %7 = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %add.ptr.1 = getelementptr i8, ptr addrspace(4) %7, i64 2048, !dbg !44
  %q_words.sroa.7.16.copyload = load i32, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.9.16.add.ptr.1.sroa_idx = getelementptr i8, ptr addrspace(4) %7, i64 2052, !dbg !45
  %q_words.sroa.9.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.9.16.add.ptr.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.10.16.add.ptr.1.sroa_idx = getelementptr i8, ptr addrspace(4) %7, i64 2056, !dbg !45
  %q_words.sroa.10.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.10.16.add.ptr.1.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.11.16.add.ptr.1.sroa_idx = getelementptr i8, ptr addrspace(4) %7, i64 2060, !dbg !45
  %q_words.sroa.11.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.11.16.add.ptr.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %8 = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %add.ptr.1780 = getelementptr i8, ptr addrspace(4) %8, i64 128, !dbg !44
  %q_words.sroa.12.32.copyload = load i32, ptr addrspace(4) %add.ptr.1780, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.14.32.add.ptr.1780.sroa_idx = getelementptr i8, ptr addrspace(4) %8, i64 132, !dbg !45
  %q_words.sroa.14.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.14.32.add.ptr.1780.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.15.32.add.ptr.1780.sroa_idx = getelementptr i8, ptr addrspace(4) %8, i64 136, !dbg !45
  %q_words.sroa.15.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.15.32.add.ptr.1780.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.16.32.add.ptr.1780.sroa_idx = getelementptr i8, ptr addrspace(4) %8, i64 140, !dbg !45
  %q_words.sroa.16.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.16.32.add.ptr.1780.sroa_idx, align 4, !dbg !45, !tbaa !30
  %9 = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %add.ptr.1.1 = getelementptr i8, ptr addrspace(4) %9, i64 2176, !dbg !44
  %q_words.sroa.17.48.copyload = load i32, ptr addrspace(4) %add.ptr.1.1, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.19.48.add.ptr.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %9, i64 2180, !dbg !45
  %q_words.sroa.19.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.19.48.add.ptr.1.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.20.48.add.ptr.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %9, i64 2184, !dbg !45
  %q_words.sroa.20.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.20.48.add.ptr.1.1.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.21.48.add.ptr.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %9, i64 2188, !dbg !45
  %q_words.sroa.21.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.21.48.add.ptr.1.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %mul35 = shl nsw i32 %0, 10, !dbg !46
  %add37 = add nuw nsw i32 %mul35, %1, !dbg !47
  %idxprom = zext nneg i32 %add37 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !48
  %10 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %cmp39 = icmp ult i32 %10, 32
  br i1 %cmp39, label %land.rhs, label %if.else372, !dbg !49

land.rhs:                                         ; preds = %entry
  %mul40 = shl nuw nsw i32 %10, 5, !dbg !50
  %cmp42.not = icmp ugt i32 %mul40, %1, !dbg !51
  br i1 %cmp42.not, label %if.else372, label %for.cond43.preheader, !dbg !52

for.cond43.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul48 = shl nuw nsw i64 %conv, 18
  %11 = shl nuw nsw i32 %10, 13
  %mul50 = zext nneg i32 %11 to i64
  %add51 = or disjoint i64 %mul48, %mul50
  %12 = shl nuw nsw i32 %2, 3
  %mul57 = zext nneg i32 %12 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul57, !dbg !53
  %13 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add51, !dbg !54
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %13, align 16, !dbg !55
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %13, i64 8, !dbg !55
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8, !dbg !55
  %gep.1 = getelementptr i8, ptr addrspace(4) %13, i64 1024, !dbg !54
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !55
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 1032, !dbg !55
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8, !dbg !55
  %gep.2 = getelementptr i8, ptr addrspace(4) %13, i64 2048, !dbg !54
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16, !dbg !55
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 2056, !dbg !55
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8, !dbg !55
  %gep.3 = getelementptr i8, ptr addrspace(4) %13, i64 3072, !dbg !54
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16, !dbg !55
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 3080, !dbg !55
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8, !dbg !55
  %gep.4 = getelementptr i8, ptr addrspace(4) %13, i64 4096, !dbg !54
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16, !dbg !55
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 4104, !dbg !55
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8, !dbg !55
  %gep.5 = getelementptr i8, ptr addrspace(4) %13, i64 5120, !dbg !54
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16, !dbg !55
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 5128, !dbg !55
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8, !dbg !55
  %gep.6 = getelementptr i8, ptr addrspace(4) %13, i64 6144, !dbg !54
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16, !dbg !55
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 6152, !dbg !55
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8, !dbg !55
  %gep.7 = getelementptr i8, ptr addrspace(4) %13, i64 7168, !dbg !54
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16, !dbg !55
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %13, i64 7176, !dbg !55
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8, !dbg !55
  %and85 = and i32 %2, 8
  %cmp86.not.not = icmp eq i32 %and85, 0
  %. = select i1 %cmp86.not.not, i32 %q_words.sroa.7.16.copyload, i32 %q_words.sroa.0.0.copyload
  %14 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %15 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %14) #9, !dbg !64
  %xor.i.i = xor i32 %15, 8, !dbg !65
  %16 = and i32 %15, -64, !dbg !66
  %and.i.i = add nsw i32 %16, 64, !dbg !66
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !67
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %15, !dbg !68
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !69
  %17 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %.), !dbg !70
  %condval_1.0 = select i1 %cmp86.not.not, i32 %q_words.sroa.0.0.copyload, i32 %17, !dbg !71
  %condval_2.0 = select i1 %cmp86.not.not, i32 %17, i32 %q_words.sroa.7.16.copyload, !dbg !72
  %..1 = select i1 %cmp86.not.not, i32 %q_words.sroa.9.16.copyload, i32 %q_words.sroa.4.0.copyload
  %18 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %19 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %18) #9, !dbg !64
  %xor.i.i.1 = xor i32 %19, 8, !dbg !65
  %20 = and i32 %19, -64, !dbg !66
  %and.i.i.1 = add nsw i32 %20, 64, !dbg !66
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1, !dbg !67
  %cond.i.i.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %19, !dbg !68
  %shl.i.i.1 = shl i32 %cond.i.i.1, 2, !dbg !69
  %21 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %..1), !dbg !70
  %condval_1.0.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.4.0.copyload, i32 %21, !dbg !71
  %condval_2.0.1 = select i1 %cmp86.not.not, i32 %21, i32 %q_words.sroa.9.16.copyload, !dbg !72
  %..2 = select i1 %cmp86.not.not, i32 %q_words.sroa.10.16.copyload, i32 %q_words.sroa.5.0.copyload
  %22 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %23 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %22) #9, !dbg !64
  %xor.i.i.2 = xor i32 %23, 8, !dbg !65
  %24 = and i32 %23, -64, !dbg !66
  %and.i.i.2 = add nsw i32 %24, 64, !dbg !66
  %cmp.not.i.i.2 = icmp slt i32 %xor.i.i.2, %and.i.i.2, !dbg !67
  %cond.i.i.2 = select i1 %cmp.not.i.i.2, i32 %xor.i.i.2, i32 %23, !dbg !68
  %shl.i.i.2 = shl i32 %cond.i.i.2, 2, !dbg !69
  %25 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2, i32 %..2), !dbg !70
  %condval_1.0.2 = select i1 %cmp86.not.not, i32 %q_words.sroa.5.0.copyload, i32 %25, !dbg !71
  %condval_2.0.2 = select i1 %cmp86.not.not, i32 %25, i32 %q_words.sroa.10.16.copyload, !dbg !72
  %..3 = select i1 %cmp86.not.not, i32 %q_words.sroa.11.16.copyload, i32 %q_words.sroa.6.0.copyload
  %26 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %27 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %26) #9, !dbg !64
  %xor.i.i.3 = xor i32 %27, 8, !dbg !65
  %28 = and i32 %27, -64, !dbg !66
  %and.i.i.3 = add nsw i32 %28, 64, !dbg !66
  %cmp.not.i.i.3 = icmp slt i32 %xor.i.i.3, %and.i.i.3, !dbg !67
  %cond.i.i.3 = select i1 %cmp.not.i.i.3, i32 %xor.i.i.3, i32 %27, !dbg !68
  %shl.i.i.3 = shl i32 %cond.i.i.3, 2, !dbg !69
  %29 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3, i32 %..3), !dbg !70
  %condval_1.0.3 = select i1 %cmp86.not.not, i32 %q_words.sroa.6.0.copyload, i32 %29, !dbg !71
  %condval_2.0.3 = select i1 %cmp86.not.not, i32 %29, i32 %q_words.sroa.11.16.copyload, !dbg !72
  %..1787 = select i1 %cmp86.not.not, i32 %q_words.sroa.17.48.copyload, i32 %q_words.sroa.12.32.copyload
  %30 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %31 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %30) #9, !dbg !64
  %xor.i.i.1788 = xor i32 %31, 8, !dbg !65
  %32 = and i32 %31, -64, !dbg !66
  %and.i.i.1789 = add nsw i32 %32, 64, !dbg !66
  %cmp.not.i.i.1790 = icmp slt i32 %xor.i.i.1788, %and.i.i.1789, !dbg !67
  %cond.i.i.1791 = select i1 %cmp.not.i.i.1790, i32 %xor.i.i.1788, i32 %31, !dbg !68
  %shl.i.i.1792 = shl i32 %cond.i.i.1791, 2, !dbg !69
  %33 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1792, i32 %..1787), !dbg !70
  %condval_1.0.1793 = select i1 %cmp86.not.not, i32 %q_words.sroa.12.32.copyload, i32 %33, !dbg !71
  %condval_2.0.1795 = select i1 %cmp86.not.not, i32 %33, i32 %q_words.sroa.17.48.copyload, !dbg !72
  %..1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.19.48.copyload, i32 %q_words.sroa.14.32.copyload
  %34 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %35 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %34) #9, !dbg !64
  %xor.i.i.1.1 = xor i32 %35, 8, !dbg !65
  %36 = and i32 %35, -64, !dbg !66
  %and.i.i.1.1 = add nsw i32 %36, 64, !dbg !66
  %cmp.not.i.i.1.1 = icmp slt i32 %xor.i.i.1.1, %and.i.i.1.1, !dbg !67
  %cond.i.i.1.1 = select i1 %cmp.not.i.i.1.1, i32 %xor.i.i.1.1, i32 %35, !dbg !68
  %shl.i.i.1.1 = shl i32 %cond.i.i.1.1, 2, !dbg !69
  %37 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1.1, i32 %..1.1), !dbg !70
  %condval_1.0.1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.14.32.copyload, i32 %37, !dbg !71
  %condval_2.0.1.1 = select i1 %cmp86.not.not, i32 %37, i32 %q_words.sroa.19.48.copyload, !dbg !72
  %..2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.20.48.copyload, i32 %q_words.sroa.15.32.copyload
  %38 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %39 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %38) #9, !dbg !64
  %xor.i.i.2.1 = xor i32 %39, 8, !dbg !65
  %40 = and i32 %39, -64, !dbg !66
  %and.i.i.2.1 = add nsw i32 %40, 64, !dbg !66
  %cmp.not.i.i.2.1 = icmp slt i32 %xor.i.i.2.1, %and.i.i.2.1, !dbg !67
  %cond.i.i.2.1 = select i1 %cmp.not.i.i.2.1, i32 %xor.i.i.2.1, i32 %39, !dbg !68
  %shl.i.i.2.1 = shl i32 %cond.i.i.2.1, 2, !dbg !69
  %41 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2.1, i32 %..2.1), !dbg !70
  %condval_1.0.2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.15.32.copyload, i32 %41, !dbg !71
  %condval_2.0.2.1 = select i1 %cmp86.not.not, i32 %41, i32 %q_words.sroa.20.48.copyload, !dbg !72
  %..3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.21.48.copyload, i32 %q_words.sroa.16.32.copyload
  %42 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !56
  %43 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %42) #9, !dbg !64
  %xor.i.i.3.1 = xor i32 %43, 8, !dbg !65
  %44 = and i32 %43, -64, !dbg !66
  %and.i.i.3.1 = add nsw i32 %44, 64, !dbg !66
  %cmp.not.i.i.3.1 = icmp slt i32 %xor.i.i.3.1, %and.i.i.3.1, !dbg !67
  %cond.i.i.3.1 = select i1 %cmp.not.i.i.3.1, i32 %xor.i.i.3.1, i32 %43, !dbg !68
  %shl.i.i.3.1 = shl i32 %cond.i.i.3.1, 2, !dbg !69
  %45 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3.1, i32 %..3.1), !dbg !70
  %condval_1.0.3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.16.32.copyload, i32 %45, !dbg !71
  %condval_2.0.3.1 = select i1 %cmp86.not.not, i32 %45, i32 %q_words.sroa.21.48.copyload, !dbg !72
  %46 = insertelement <2 x i32> poison, i32 %condval_1.0, i64 0, !dbg !73
  %q.sroa.0.2.vec.insert = bitcast <2 x i32> %46 to <4 x half>, !dbg !73
  %q_halves.sroa.5.4.extract.trunc = trunc i32 %condval_1.0.1 to i16, !dbg !73
  %47 = bitcast i16 %q_halves.sroa.5.4.extract.trunc to half, !dbg !73
  %q.sroa.0.4.vec.insert = insertelement <4 x half> %q.sroa.0.2.vec.insert, half %47, i64 2, !dbg !73
  %q_halves.sroa.5.6.extract.shift = lshr i32 %condval_1.0.1, 16, !dbg !73
  %q_halves.sroa.5.6.extract.trunc = trunc nuw i32 %q_halves.sroa.5.6.extract.shift to i16, !dbg !73
  %48 = bitcast i16 %q_halves.sroa.5.6.extract.trunc to half, !dbg !73
  %q.sroa.0.6.vec.insert = insertelement <4 x half> %q.sroa.0.4.vec.insert, half %48, i64 3, !dbg !73
  %49 = insertelement <2 x i32> poison, i32 %condval_1.0.2, i64 0, !dbg !73
  %q.sroa.7.10.vec.insert = bitcast <2 x i32> %49 to <4 x half>, !dbg !73
  %q_halves.sroa.11.12.extract.trunc = trunc i32 %condval_1.0.3 to i16, !dbg !73
  %50 = bitcast i16 %q_halves.sroa.11.12.extract.trunc to half, !dbg !73
  %q.sroa.7.12.vec.insert = insertelement <4 x half> %q.sroa.7.10.vec.insert, half %50, i64 2, !dbg !73
  %q_halves.sroa.11.14.extract.shift = lshr i32 %condval_1.0.3, 16, !dbg !73
  %q_halves.sroa.11.14.extract.trunc = trunc nuw i32 %q_halves.sroa.11.14.extract.shift to i16, !dbg !73
  %51 = bitcast i16 %q_halves.sroa.11.14.extract.trunc to half, !dbg !73
  %q.sroa.7.14.vec.insert = insertelement <4 x half> %q.sroa.7.12.vec.insert, half %51, i64 3, !dbg !73
  %52 = insertelement <2 x i32> poison, i32 %condval_2.0, i64 0, !dbg !73
  %q.sroa.12.18.vec.insert = bitcast <2 x i32> %52 to <4 x half>, !dbg !73
  %q_halves.sroa.17.20.extract.trunc = trunc i32 %condval_2.0.1 to i16, !dbg !73
  %53 = bitcast i16 %q_halves.sroa.17.20.extract.trunc to half, !dbg !73
  %q.sroa.12.20.vec.insert = insertelement <4 x half> %q.sroa.12.18.vec.insert, half %53, i64 2, !dbg !73
  %q_halves.sroa.17.22.extract.shift = lshr i32 %condval_2.0.1, 16, !dbg !73
  %q_halves.sroa.17.22.extract.trunc = trunc nuw i32 %q_halves.sroa.17.22.extract.shift to i16, !dbg !73
  %54 = bitcast i16 %q_halves.sroa.17.22.extract.trunc to half, !dbg !73
  %q.sroa.12.22.vec.insert = insertelement <4 x half> %q.sroa.12.20.vec.insert, half %54, i64 3, !dbg !73
  %55 = insertelement <2 x i32> poison, i32 %condval_2.0.2, i64 0, !dbg !73
  %q.sroa.17.26.vec.insert = bitcast <2 x i32> %55 to <4 x half>, !dbg !73
  %q_halves.sroa.23.28.extract.trunc = trunc i32 %condval_2.0.3 to i16, !dbg !73
  %56 = bitcast i16 %q_halves.sroa.23.28.extract.trunc to half, !dbg !73
  %q.sroa.17.28.vec.insert = insertelement <4 x half> %q.sroa.17.26.vec.insert, half %56, i64 2, !dbg !73
  %q_halves.sroa.23.30.extract.shift = lshr i32 %condval_2.0.3, 16, !dbg !73
  %q_halves.sroa.23.30.extract.trunc = trunc nuw i32 %q_halves.sroa.23.30.extract.shift to i16, !dbg !73
  %57 = bitcast i16 %q_halves.sroa.23.30.extract.trunc to half, !dbg !73
  %q.sroa.17.30.vec.insert = insertelement <4 x half> %q.sroa.17.28.vec.insert, half %57, i64 3, !dbg !73
  %58 = insertelement <2 x i32> poison, i32 %condval_1.0.1793, i64 0, !dbg !73
  %q.sroa.22.34.vec.insert = bitcast <2 x i32> %58 to <4 x half>, !dbg !73
  %q_halves.sroa.29.36.extract.trunc = trunc i32 %condval_1.0.1.1 to i16, !dbg !73
  %59 = bitcast i16 %q_halves.sroa.29.36.extract.trunc to half, !dbg !73
  %q.sroa.22.36.vec.insert = insertelement <4 x half> %q.sroa.22.34.vec.insert, half %59, i64 2, !dbg !73
  %q_halves.sroa.29.38.extract.shift = lshr i32 %condval_1.0.1.1, 16, !dbg !73
  %q_halves.sroa.29.38.extract.trunc = trunc nuw i32 %q_halves.sroa.29.38.extract.shift to i16, !dbg !73
  %60 = bitcast i16 %q_halves.sroa.29.38.extract.trunc to half, !dbg !73
  %q.sroa.22.38.vec.insert = insertelement <4 x half> %q.sroa.22.36.vec.insert, half %60, i64 3, !dbg !73
  %61 = insertelement <2 x i32> poison, i32 %condval_1.0.2.1, i64 0, !dbg !73
  %q.sroa.27.42.vec.insert = bitcast <2 x i32> %61 to <4 x half>, !dbg !73
  %q_halves.sroa.35.44.extract.trunc = trunc i32 %condval_1.0.3.1 to i16, !dbg !73
  %62 = bitcast i16 %q_halves.sroa.35.44.extract.trunc to half, !dbg !73
  %q.sroa.27.44.vec.insert = insertelement <4 x half> %q.sroa.27.42.vec.insert, half %62, i64 2, !dbg !73
  %q_halves.sroa.35.46.extract.shift = lshr i32 %condval_1.0.3.1, 16, !dbg !73
  %q_halves.sroa.35.46.extract.trunc = trunc nuw i32 %q_halves.sroa.35.46.extract.shift to i16, !dbg !73
  %63 = bitcast i16 %q_halves.sroa.35.46.extract.trunc to half, !dbg !73
  %q.sroa.27.46.vec.insert = insertelement <4 x half> %q.sroa.27.44.vec.insert, half %63, i64 3, !dbg !73
  %64 = insertelement <2 x i32> poison, i32 %condval_2.0.1795, i64 0, !dbg !73
  %q.sroa.32.50.vec.insert = bitcast <2 x i32> %64 to <4 x half>, !dbg !73
  %q_halves.sroa.41.52.extract.trunc = trunc i32 %condval_2.0.1.1 to i16, !dbg !73
  %65 = bitcast i16 %q_halves.sroa.41.52.extract.trunc to half, !dbg !73
  %q.sroa.32.52.vec.insert = insertelement <4 x half> %q.sroa.32.50.vec.insert, half %65, i64 2, !dbg !73
  %q_halves.sroa.41.54.extract.shift = lshr i32 %condval_2.0.1.1, 16, !dbg !73
  %q_halves.sroa.41.54.extract.trunc = trunc nuw i32 %q_halves.sroa.41.54.extract.shift to i16, !dbg !73
  %66 = bitcast i16 %q_halves.sroa.41.54.extract.trunc to half, !dbg !73
  %q.sroa.32.54.vec.insert = insertelement <4 x half> %q.sroa.32.52.vec.insert, half %66, i64 3, !dbg !73
  %67 = insertelement <2 x i32> poison, i32 %condval_2.0.2.1, i64 0, !dbg !73
  %q.sroa.37.58.vec.insert = bitcast <2 x i32> %67 to <4 x half>, !dbg !73
  %q_halves.sroa.47.60.extract.trunc = trunc i32 %condval_2.0.3.1 to i16, !dbg !73
  %68 = bitcast i16 %q_halves.sroa.47.60.extract.trunc to half, !dbg !73
  %q.sroa.37.60.vec.insert = insertelement <4 x half> %q.sroa.37.58.vec.insert, half %68, i64 2, !dbg !73
  %q_halves.sroa.47.62.extract.shift = lshr i32 %condval_2.0.3.1, 16, !dbg !73
  %q_halves.sroa.47.62.extract.trunc = trunc nuw i32 %q_halves.sroa.47.62.extract.shift to i16, !dbg !73
  %69 = bitcast i16 %q_halves.sroa.47.62.extract.trunc to half, !dbg !73
  %q.sroa.37.62.vec.insert = insertelement <4 x half> %q.sroa.37.60.vec.insert, half %69, i64 3, !dbg !73
  %70 = lshr i32 %2, 2
  %mul152 = and i32 %70, 252
  %add149 = add nuw nsw i32 %mul40, %mul152
  %cmp157.not = icmp ugt i32 %add149, %1, !dbg !74
  %spec.select = select i1 %cmp157.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !76
  %cmp157.not.1.not = icmp ult i32 %add149, %1, !dbg !74
  %spec.select.1 = select i1 %cmp157.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !75
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !76
  %add153.2 = or disjoint i32 %add149, 2, !dbg !77
  %cmp157.not.2 = icmp ugt i32 %add153.2, %1, !dbg !74
  %spec.select.2 = select i1 %cmp157.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !76
  %add153.3 = or disjoint i32 %add149, 3, !dbg !77
  %cmp157.not.3 = icmp ugt i32 %add153.3, %1, !dbg !74
  %spec.select.3 = select i1 %cmp157.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !76
  %add155.4 = add nuw nsw i32 %add149, 16, !dbg !78
  %cmp157.not.4 = icmp ugt i32 %add155.4, %1, !dbg !74
  %spec.select.4 = select i1 %cmp157.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !76
  %add155.5 = add nuw nsw i32 %add149, 17, !dbg !78
  %cmp157.not.5 = icmp ugt i32 %add155.5, %1, !dbg !74
  %spec.select.5 = select i1 %cmp157.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1, !dbg !76
  %add155.6 = add nuw nsw i32 %add149, 18, !dbg !78
  %cmp157.not.6 = icmp ugt i32 %add155.6, %1, !dbg !74
  %spec.select.6 = select i1 %cmp157.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2, !dbg !76
  %add155.7 = add nuw nsw i32 %add149, 19, !dbg !78
  %cmp157.not.7 = icmp ugt i32 %add155.7, %1, !dbg !74
  %spec.select.7 = select i1 %cmp157.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3, !dbg !76
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !79, !call_argsrelate !80
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !79, !call_argsrelate !80
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %71), !dbg !79, !call_argsrelate !80
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %72), !dbg !79, !call_argsrelate !80
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %73), !dbg !79, !call_argsrelate !80
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %74), !dbg !79, !call_argsrelate !80
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %75), !dbg !79, !call_argsrelate !80
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %76), !dbg !79, !call_argsrelate !80
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %77), !dbg !79, !call_argsrelate !80
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %78), !dbg !79, !call_argsrelate !80
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %79), !dbg !79, !call_argsrelate !80
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %80), !dbg !79, !call_argsrelate !80
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %81), !dbg !79, !call_argsrelate !80
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %82), !dbg !79, !call_argsrelate !80
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %83), !dbg !79, !call_argsrelate !80
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %84), !dbg !79, !call_argsrelate !80
  %invariant.gep746 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192, !dbg !81
  %87 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep746, i64 %add51, !dbg !82
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %87, align 16, !dbg !83
  %v.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %87, i64 8, !dbg !83
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0..sroa_idx, align 8, !dbg !83
  %gep747.1 = getelementptr i8, ptr addrspace(4) %87, i64 1024, !dbg !82
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep747.1, align 16, !dbg !83
  %v.sroa.7.16.gep747.1.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 1032, !dbg !83
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.gep747.1.sroa_idx, align 8, !dbg !83
  %gep747.2 = getelementptr i8, ptr addrspace(4) %87, i64 2048, !dbg !82
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep747.2, align 16, !dbg !83
  %v.sroa.10.32.gep747.2.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 2056, !dbg !83
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.gep747.2.sroa_idx, align 8, !dbg !83
  %gep747.3 = getelementptr i8, ptr addrspace(4) %87, i64 3072, !dbg !82
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep747.3, align 16, !dbg !83
  %v.sroa.13.48.gep747.3.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 3080, !dbg !83
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.gep747.3.sroa_idx, align 8, !dbg !83
  %gep747.4 = getelementptr i8, ptr addrspace(4) %87, i64 4096, !dbg !82
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep747.4, align 16, !dbg !83
  %v.sroa.16.64.gep747.4.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 4104, !dbg !83
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.gep747.4.sroa_idx, align 8, !dbg !83
  %gep747.5 = getelementptr i8, ptr addrspace(4) %87, i64 5120, !dbg !82
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep747.5, align 16, !dbg !83
  %v.sroa.19.80.gep747.5.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 5128, !dbg !83
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.gep747.5.sroa_idx, align 8, !dbg !83
  %gep747.6 = getelementptr i8, ptr addrspace(4) %87, i64 6144, !dbg !82
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep747.6, align 16, !dbg !83
  %v.sroa.22.96.gep747.6.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 6152, !dbg !83
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.gep747.6.sroa_idx, align 8, !dbg !83
  %gep747.7 = getelementptr i8, ptr addrspace(4) %87, i64 7168, !dbg !82
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep747.7, align 16, !dbg !83
  %v.sroa.25.112.gep747.7.sroa_idx = getelementptr i8, ptr addrspace(4) %87, i64 7176, !dbg !83
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.gep747.7.sroa_idx, align 8, !dbg !83
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %85, i64 0, !dbg !84
  %mul238 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !85
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul238, float 1.500000e+01), !dbg !86
  %cmp.i.i = fcmp contract olt float %88, -1.260000e+02, !dbg !90
  %cond.i.i709 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710 = fadd contract float %88, %cond.i.i709, !dbg !90
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i710), !dbg !90
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i = fmul contract float %cond2.i.i, %89, !dbg !90
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %85, i64 1, !dbg !84
  %mul238.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !85
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul238.1, float 1.500000e+01), !dbg !86
  %cmp.i.i.1 = fcmp contract olt float %90, -1.260000e+02, !dbg !90
  %cond.i.i709.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710.1 = fadd contract float %90, %cond.i.i709.1, !dbg !90
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i710.1), !dbg !90
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %91, !dbg !90
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %85, i64 2, !dbg !84
  %mul238.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !85
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul238.2, float 1.500000e+01), !dbg !86
  %cmp.i.i.2 = fcmp contract olt float %92, -1.260000e+02, !dbg !90
  %cond.i.i709.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710.2 = fadd contract float %92, %cond.i.i709.2, !dbg !90
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i710.2), !dbg !90
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %93, !dbg !90
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %85, i64 3, !dbg !84
  %mul238.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !85
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul238.3, float 1.500000e+01), !dbg !86
  %cmp.i.i.3 = fcmp contract olt float %94, -1.260000e+02, !dbg !90
  %cond.i.i709.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710.3 = fadd contract float %94, %cond.i.i709.3, !dbg !90
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i710.3), !dbg !90
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %95, !dbg !90
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %86, i64 0, !dbg !84
  %mul238.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !85
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul238.4, float 1.500000e+01), !dbg !86
  %cmp.i.i.4 = fcmp contract olt float %96, -1.260000e+02, !dbg !90
  %cond.i.i709.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710.4 = fadd contract float %96, %cond.i.i709.4, !dbg !90
  %97 = tail call contract float @llvm.exp2.f32(float %add.i.i710.4), !dbg !90
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %97, !dbg !90
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %86, i64 1, !dbg !84
  %mul238.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !85
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul238.5, float 1.500000e+01), !dbg !86
  %cmp.i.i.5 = fcmp contract olt float %98, -1.260000e+02, !dbg !90
  %cond.i.i709.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710.5 = fadd contract float %98, %cond.i.i709.5, !dbg !90
  %99 = tail call contract float @llvm.exp2.f32(float %add.i.i710.5), !dbg !90
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %99, !dbg !90
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %86, i64 2, !dbg !84
  %mul238.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !85
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul238.6, float 1.500000e+01), !dbg !86
  %cmp.i.i.6 = fcmp contract olt float %100, -1.260000e+02, !dbg !90
  %cond.i.i709.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710.6 = fadd contract float %100, %cond.i.i709.6, !dbg !90
  %101 = tail call contract float @llvm.exp2.f32(float %add.i.i710.6), !dbg !90
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %101, !dbg !90
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %86, i64 3, !dbg !84
  %mul238.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !85
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul238.7, float 1.500000e+01), !dbg !86
  %cmp.i.i.7 = fcmp contract olt float %102, -1.260000e+02, !dbg !90
  %cond.i.i709.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i710.7 = fadd contract float %102, %cond.i.i709.7, !dbg !90
  %103 = tail call contract float @llvm.exp2.f32(float %add.i.i710.7), !dbg !90
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %103, !dbg !90
  %add258 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !93
  %add258.1 = fadd contract float %add258, %mul.i.i.4, !dbg !93
  %add258.2 = fadd contract float %add258.1, %mul.i.i.1, !dbg !93
  %add258.3 = fadd contract float %add258.2, %mul.i.i.5, !dbg !93
  %add258.4 = fadd contract float %add258.3, %mul.i.i.2, !dbg !93
  %add258.5 = fadd contract float %add258.4, %mul.i.i.6, !dbg !93
  %add258.6 = fadd contract float %add258.5, %mul.i.i.3, !dbg !93
  %add258.7 = fadd contract float %add258.6, %mul.i.i.7, !dbg !93
  %104 = bitcast float %add258.7 to i32, !dbg !94
  %105 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !105
  %106 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %105) #9, !dbg !108
  %xor.i.i711 = xor i32 %106, 32, !dbg !109
  %107 = and i32 %106, -64, !dbg !110
  %and.i.i712 = add nsw i32 %107, 64, !dbg !110
  %cmp.not.i.i713 = icmp slt i32 %xor.i.i711, %and.i.i712, !dbg !111
  %cond.i.i714 = select i1 %cmp.not.i.i713, i32 %xor.i.i711, i32 %106, !dbg !112
  %shl.i.i715 = shl i32 %cond.i.i714, 2, !dbg !113
  %108 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i715, i32 %104), !dbg !114
  %109 = bitcast i32 %108 to float, !dbg !115
  %add.i = fadd contract float %add258.7, %109, !dbg !116
  %110 = bitcast float %add.i to i32, !dbg !119
  %111 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !126
  %112 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %111) #9, !dbg !129
  %xor.i.i716 = xor i32 %112, 16, !dbg !130
  %113 = and i32 %112, -64, !dbg !131
  %and.i.i717 = add nsw i32 %113, 64, !dbg !131
  %cmp.not.i.i718 = icmp slt i32 %xor.i.i716, %and.i.i717, !dbg !132
  %cond.i.i719 = select i1 %cmp.not.i.i718, i32 %xor.i.i716, i32 %112, !dbg !133
  %shl.i.i720 = shl i32 %cond.i.i719, 2, !dbg !134
  %114 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i720, i32 %110), !dbg !135
  %115 = bitcast i32 %114 to float, !dbg !136
  %add.i.i = fadd contract float %add.i, %115, !dbg !137
  %cmp267 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !139
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !140
  %condval_4.0 = select i1 %cmp267, float %div, float 0.000000e+00, !dbg !140
  %mul280 = fmul contract float %condval_4.0, %mul.i.i, !dbg !141
  %mul280.1 = fmul contract float %condval_4.0, %mul.i.i.1, !dbg !141
  %mul280.2 = fmul contract float %condval_4.0, %mul.i.i.2, !dbg !141
  %mul280.3 = fmul contract float %condval_4.0, %mul.i.i.3, !dbg !141
  %mul280.4 = fmul contract float %condval_4.0, %mul.i.i.4, !dbg !141
  %mul280.5 = fmul contract float %condval_4.0, %mul.i.i.5, !dbg !141
  %mul280.6 = fmul contract float %condval_4.0, %mul.i.i.6, !dbg !141
  %mul280.7 = fmul contract float %condval_4.0, %mul.i.i.7, !dbg !141
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280), !dbg !142
  %117 = insertelement <4 x i16> poison, i16 %116, i64 0, !dbg !151
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.1), !dbg !142
  %119 = insertelement <4 x i16> %117, i16 %118, i64 1, !dbg !151
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.2), !dbg !142
  %121 = insertelement <4 x i16> %119, i16 %120, i64 2, !dbg !151
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.3), !dbg !142
  %123 = insertelement <4 x i16> %121, i16 %122, i64 3, !dbg !151
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %123 to <4 x half>, !dbg !151
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.4), !dbg !142
  %125 = insertelement <4 x i16> poison, i16 %124, i64 0, !dbg !151
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.5), !dbg !142
  %127 = insertelement <4 x i16> %125, i16 %126, i64 1, !dbg !151
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.6), !dbg !142
  %129 = insertelement <4 x i16> %127, i16 %128, i64 2, !dbg !151
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul280.7), !dbg !142
  %131 = insertelement <4 x i16> %129, i16 %130, i64 3, !dbg !151
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %131 to <4 x half>, !dbg !151
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !80
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %132), !dbg !152, !call_argsrelate !80
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.64.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %133), !dbg !152, !call_argsrelate !80
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %134), !dbg !152, !call_argsrelate !80
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.80.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %135), !dbg !152, !call_argsrelate !80
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %136), !dbg !152, !call_argsrelate !80
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.96.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %137), !dbg !152, !call_argsrelate !80
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %138), !dbg !152, !call_argsrelate !80
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.112.copyload, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %139), !dbg !152, !call_argsrelate !80
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %140, i64 0, !dbg !153
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !154
  %output_reg.sroa.0.0.insert.ext = zext i16 %148 to i32, !dbg !158
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %140, i64 1, !dbg !153
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !154
  %output_reg.sroa.0.2.insert.ext = zext i16 %149 to i32, !dbg !158
  %output_reg.sroa.0.2.insert.shift = shl nuw i32 %output_reg.sroa.0.2.insert.ext, 16, !dbg !158
  %output_reg.sroa.0.2.insert.insert = or disjoint i32 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !158
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %140, i64 2, !dbg !153
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !154
  %output_reg.sroa.7.4.insert.ext = zext i16 %150 to i32, !dbg !158
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %140, i64 3, !dbg !153
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !154
  %output_reg.sroa.7.6.insert.ext = zext i16 %151 to i32, !dbg !158
  %output_reg.sroa.7.6.insert.shift = shl nuw i32 %output_reg.sroa.7.6.insert.ext, 16, !dbg !158
  %output_reg.sroa.7.6.insert.insert = or disjoint i32 %output_reg.sroa.7.6.insert.shift, %output_reg.sroa.7.4.insert.ext, !dbg !158
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %141, i64 0, !dbg !153
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !154
  %output_reg.sroa.12.8.insert.ext = zext i16 %152 to i32, !dbg !158
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %141, i64 1, !dbg !153
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !154
  %output_reg.sroa.12.10.insert.ext = zext i16 %153 to i32, !dbg !158
  %output_reg.sroa.12.10.insert.shift = shl nuw i32 %output_reg.sroa.12.10.insert.ext, 16, !dbg !158
  %output_reg.sroa.12.10.insert.insert = or disjoint i32 %output_reg.sroa.12.10.insert.shift, %output_reg.sroa.12.8.insert.ext, !dbg !158
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %141, i64 2, !dbg !153
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !154
  %output_reg.sroa.17.12.insert.ext = zext i16 %154 to i32, !dbg !158
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %141, i64 3, !dbg !153
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !154
  %output_reg.sroa.17.14.insert.ext = zext i16 %155 to i32, !dbg !158
  %output_reg.sroa.17.14.insert.shift = shl nuw i32 %output_reg.sroa.17.14.insert.ext, 16, !dbg !158
  %output_reg.sroa.17.14.insert.insert = or disjoint i32 %output_reg.sroa.17.14.insert.shift, %output_reg.sroa.17.12.insert.ext, !dbg !158
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %142, i64 0, !dbg !153
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !154
  %output_reg.sroa.22.16.insert.ext = zext i16 %156 to i32, !dbg !158
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %142, i64 1, !dbg !153
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !154
  %output_reg.sroa.22.18.insert.ext = zext i16 %157 to i32, !dbg !158
  %output_reg.sroa.22.18.insert.shift = shl nuw i32 %output_reg.sroa.22.18.insert.ext, 16, !dbg !158
  %output_reg.sroa.22.18.insert.insert = or disjoint i32 %output_reg.sroa.22.18.insert.shift, %output_reg.sroa.22.16.insert.ext, !dbg !158
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %142, i64 2, !dbg !153
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !154
  %output_reg.sroa.27.20.insert.ext = zext i16 %158 to i32, !dbg !158
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %142, i64 3, !dbg !153
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !154
  %output_reg.sroa.27.22.insert.ext = zext i16 %159 to i32, !dbg !158
  %output_reg.sroa.27.22.insert.shift = shl nuw i32 %output_reg.sroa.27.22.insert.ext, 16, !dbg !158
  %output_reg.sroa.27.22.insert.insert = or disjoint i32 %output_reg.sroa.27.22.insert.shift, %output_reg.sroa.27.20.insert.ext, !dbg !158
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %143, i64 0, !dbg !153
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !154
  %output_reg.sroa.32.24.insert.ext = zext i16 %160 to i32, !dbg !158
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %143, i64 1, !dbg !153
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !154
  %output_reg.sroa.32.26.insert.ext = zext i16 %161 to i32, !dbg !158
  %output_reg.sroa.32.26.insert.shift = shl nuw i32 %output_reg.sroa.32.26.insert.ext, 16, !dbg !158
  %output_reg.sroa.32.26.insert.insert = or disjoint i32 %output_reg.sroa.32.26.insert.shift, %output_reg.sroa.32.24.insert.ext, !dbg !158
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %143, i64 2, !dbg !153
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !154
  %output_reg.sroa.37.28.insert.ext = zext i16 %162 to i32, !dbg !158
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %143, i64 3, !dbg !153
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !154
  %output_reg.sroa.37.30.insert.ext = zext i16 %163 to i32, !dbg !158
  %output_reg.sroa.37.30.insert.shift = shl nuw i32 %output_reg.sroa.37.30.insert.ext, 16, !dbg !158
  %output_reg.sroa.37.30.insert.insert = or disjoint i32 %output_reg.sroa.37.30.insert.shift, %output_reg.sroa.37.28.insert.ext, !dbg !158
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %144, i64 0, !dbg !153
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !154
  %output_reg.sroa.42.32.insert.ext = zext i16 %164 to i32, !dbg !158
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %144, i64 1, !dbg !153
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !154
  %output_reg.sroa.42.34.insert.ext = zext i16 %165 to i32, !dbg !158
  %output_reg.sroa.42.34.insert.shift = shl nuw i32 %output_reg.sroa.42.34.insert.ext, 16, !dbg !158
  %output_reg.sroa.42.34.insert.insert = or disjoint i32 %output_reg.sroa.42.34.insert.shift, %output_reg.sroa.42.32.insert.ext, !dbg !158
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %144, i64 2, !dbg !153
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !154
  %output_reg.sroa.47.36.insert.ext = zext i16 %166 to i32, !dbg !158
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %144, i64 3, !dbg !153
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !154
  %output_reg.sroa.47.38.insert.ext = zext i16 %167 to i32, !dbg !158
  %output_reg.sroa.47.38.insert.shift = shl nuw i32 %output_reg.sroa.47.38.insert.ext, 16, !dbg !158
  %output_reg.sroa.47.38.insert.insert = or disjoint i32 %output_reg.sroa.47.38.insert.shift, %output_reg.sroa.47.36.insert.ext, !dbg !158
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %145, i64 0, !dbg !153
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !154
  %output_reg.sroa.52.40.insert.ext = zext i16 %168 to i32, !dbg !158
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %145, i64 1, !dbg !153
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !154
  %output_reg.sroa.52.42.insert.ext = zext i16 %169 to i32, !dbg !158
  %output_reg.sroa.52.42.insert.shift = shl nuw i32 %output_reg.sroa.52.42.insert.ext, 16, !dbg !158
  %output_reg.sroa.52.42.insert.insert = or disjoint i32 %output_reg.sroa.52.42.insert.shift, %output_reg.sroa.52.40.insert.ext, !dbg !158
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %145, i64 2, !dbg !153
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !154
  %output_reg.sroa.57.44.insert.ext = zext i16 %170 to i32, !dbg !158
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %145, i64 3, !dbg !153
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !154
  %output_reg.sroa.57.46.insert.ext = zext i16 %171 to i32, !dbg !158
  %output_reg.sroa.57.46.insert.shift = shl nuw i32 %output_reg.sroa.57.46.insert.ext, 16, !dbg !158
  %output_reg.sroa.57.46.insert.insert = or disjoint i32 %output_reg.sroa.57.46.insert.shift, %output_reg.sroa.57.44.insert.ext, !dbg !158
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %146, i64 0, !dbg !153
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !154
  %output_reg.sroa.62.48.insert.ext = zext i16 %172 to i32, !dbg !158
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %146, i64 1, !dbg !153
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !154
  %output_reg.sroa.62.50.insert.ext = zext i16 %173 to i32, !dbg !158
  %output_reg.sroa.62.50.insert.shift = shl nuw i32 %output_reg.sroa.62.50.insert.ext, 16, !dbg !158
  %output_reg.sroa.62.50.insert.insert = or disjoint i32 %output_reg.sroa.62.50.insert.shift, %output_reg.sroa.62.48.insert.ext, !dbg !158
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %146, i64 2, !dbg !153
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !154
  %output_reg.sroa.67.52.insert.ext = zext i16 %174 to i32, !dbg !158
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %146, i64 3, !dbg !153
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !154
  %output_reg.sroa.67.54.insert.ext = zext i16 %175 to i32, !dbg !158
  %output_reg.sroa.67.54.insert.shift = shl nuw i32 %output_reg.sroa.67.54.insert.ext, 16, !dbg !158
  %output_reg.sroa.67.54.insert.insert = or disjoint i32 %output_reg.sroa.67.54.insert.shift, %output_reg.sroa.67.52.insert.ext, !dbg !158
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %147, i64 0, !dbg !153
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !154
  %output_reg.sroa.72.56.insert.ext = zext i16 %176 to i32, !dbg !158
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %147, i64 1, !dbg !153
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !154
  %output_reg.sroa.72.58.insert.ext = zext i16 %177 to i32, !dbg !158
  %output_reg.sroa.72.58.insert.shift = shl nuw i32 %output_reg.sroa.72.58.insert.ext, 16, !dbg !158
  %output_reg.sroa.72.58.insert.insert = or disjoint i32 %output_reg.sroa.72.58.insert.shift, %output_reg.sroa.72.56.insert.ext, !dbg !158
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %147, i64 2, !dbg !153
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !154
  %output_reg.sroa.77.60.insert.ext = zext i16 %178 to i32, !dbg !158
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %147, i64 3, !dbg !153
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !154
  %output_reg.sroa.77.62.insert.ext = zext i16 %179 to i32, !dbg !158
  %output_reg.sroa.77.62.insert.shift = shl nuw i32 %output_reg.sroa.77.62.insert.ext, 16, !dbg !158
  %output_reg.sroa.77.62.insert.insert = or disjoint i32 %output_reg.sroa.77.62.insert.shift, %output_reg.sroa.77.60.insert.ext, !dbg !158
  br label %if.end394, !dbg !159

if.else372:                                       ; preds = %entry, %land.rhs
  %.pre = and i32 %2, 8
  %.pre1017 = shl nuw nsw i32 %2, 3
  %.pre1018 = lshr i32 %2, 2
  %.pre1020 = and i32 %.pre1018, 252
  br label %if.end394, !dbg !159

if.end394:                                        ; preds = %for.cond43.preheader, %if.else372
  %mul561.pre-phi = phi i32 [ %mul152, %for.cond43.preheader ], [ %.pre1020, %if.else372 ]
  %.pre-phi = phi i32 [ %12, %for.cond43.preheader ], [ %.pre1017, %if.else372 ]
  %and436.pre-phi = phi i32 [ %and85, %for.cond43.preheader ], [ %.pre, %if.else372 ]
  %output_reg.sroa.57.0 = phi i32 [ %output_reg.sroa.57.46.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.52.0 = phi i32 [ %output_reg.sroa.52.42.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.47.0 = phi i32 [ %output_reg.sroa.47.38.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.42.0 = phi i32 [ %output_reg.sroa.42.34.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.37.0 = phi i32 [ %output_reg.sroa.37.30.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.32.0 = phi i32 [ %output_reg.sroa.32.26.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.27.0 = phi i32 [ %output_reg.sroa.27.22.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.22.0 = phi i32 [ %output_reg.sroa.22.18.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.17.0 = phi i32 [ %output_reg.sroa.17.14.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.12.0 = phi i32 [ %output_reg.sroa.12.10.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.7.0 = phi i32 [ %output_reg.sroa.7.6.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.0.0 = phi i32 [ %output_reg.sroa.0.2.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.62.0 = phi i32 [ %output_reg.sroa.62.50.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.67.0 = phi i32 [ %output_reg.sroa.67.54.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.72.0 = phi i32 [ %output_reg.sroa.72.58.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %output_reg.sroa.77.0 = phi i32 [ %output_reg.sroa.77.62.insert.insert, %for.cond43.preheader ], [ 0, %if.else372 ], !dbg !160
  %cmp437.not.not = icmp eq i32 %and436.pre-phi, 0
  %.695 = select i1 %cmp437.not.not, i32 %output_reg.sroa.12.0, i32 %output_reg.sroa.0.0
  %180 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %181 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %180) #9, !dbg !165
  %xor.i.i721 = xor i32 %181, 8, !dbg !166
  %182 = and i32 %181, -64, !dbg !167
  %and.i.i722 = add nsw i32 %182, 64, !dbg !167
  %cmp.not.i.i723 = icmp slt i32 %xor.i.i721, %and.i.i722, !dbg !168
  %cond.i.i724 = select i1 %cmp.not.i.i723, i32 %xor.i.i721, i32 %181, !dbg !169
  %shl.i.i725 = shl i32 %cond.i.i724, 2, !dbg !170
  %183 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725, i32 %.695), !dbg !171
  %condval_6.0 = select i1 %cmp437.not.not, i32 %output_reg.sroa.0.0, i32 %183, !dbg !172
  %condval_7.0 = select i1 %cmp437.not.not, i32 %183, i32 %output_reg.sroa.12.0, !dbg !173
  %.695.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.17.0, i32 %output_reg.sroa.7.0
  %184 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %185 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %184) #9, !dbg !165
  %xor.i.i721.1 = xor i32 %185, 8, !dbg !166
  %186 = and i32 %185, -64, !dbg !167
  %and.i.i722.1 = add nsw i32 %186, 64, !dbg !167
  %cmp.not.i.i723.1 = icmp slt i32 %xor.i.i721.1, %and.i.i722.1, !dbg !168
  %cond.i.i724.1 = select i1 %cmp.not.i.i723.1, i32 %xor.i.i721.1, i32 %185, !dbg !169
  %shl.i.i725.1 = shl i32 %cond.i.i724.1, 2, !dbg !170
  %187 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1, i32 %.695.1), !dbg !171
  %condval_6.0.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.7.0, i32 %187, !dbg !172
  %condval_7.0.1 = select i1 %cmp437.not.not, i32 %187, i32 %output_reg.sroa.17.0, !dbg !173
  %.695.1832 = select i1 %cmp437.not.not, i32 %output_reg.sroa.32.0, i32 %output_reg.sroa.22.0
  %188 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %189 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %188) #9, !dbg !165
  %xor.i.i721.1833 = xor i32 %189, 8, !dbg !166
  %190 = and i32 %189, -64, !dbg !167
  %and.i.i722.1834 = add nsw i32 %190, 64, !dbg !167
  %cmp.not.i.i723.1835 = icmp slt i32 %xor.i.i721.1833, %and.i.i722.1834, !dbg !168
  %cond.i.i724.1836 = select i1 %cmp.not.i.i723.1835, i32 %xor.i.i721.1833, i32 %189, !dbg !169
  %shl.i.i725.1837 = shl i32 %cond.i.i724.1836, 2, !dbg !170
  %191 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1837, i32 %.695.1832), !dbg !171
  %condval_6.0.1838 = select i1 %cmp437.not.not, i32 %output_reg.sroa.22.0, i32 %191, !dbg !172
  %condval_7.0.1840 = select i1 %cmp437.not.not, i32 %191, i32 %output_reg.sroa.32.0, !dbg !173
  %.695.1.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.37.0, i32 %output_reg.sroa.27.0
  %192 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %193 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %192) #9, !dbg !165
  %xor.i.i721.1.1 = xor i32 %193, 8, !dbg !166
  %194 = and i32 %193, -64, !dbg !167
  %and.i.i722.1.1 = add nsw i32 %194, 64, !dbg !167
  %cmp.not.i.i723.1.1 = icmp slt i32 %xor.i.i721.1.1, %and.i.i722.1.1, !dbg !168
  %cond.i.i724.1.1 = select i1 %cmp.not.i.i723.1.1, i32 %xor.i.i721.1.1, i32 %193, !dbg !169
  %shl.i.i725.1.1 = shl i32 %cond.i.i724.1.1, 2, !dbg !170
  %195 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1.1, i32 %.695.1.1), !dbg !171
  %condval_6.0.1.1 = select i1 %cmp437.not.not, i32 %output_reg.sroa.27.0, i32 %195, !dbg !172
  %condval_7.0.1.1 = select i1 %cmp437.not.not, i32 %195, i32 %output_reg.sroa.37.0, !dbg !173
  %.695.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.52.0, i32 %output_reg.sroa.42.0
  %196 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %197 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %196) #9, !dbg !165
  %xor.i.i721.2 = xor i32 %197, 8, !dbg !166
  %198 = and i32 %197, -64, !dbg !167
  %and.i.i722.2 = add nsw i32 %198, 64, !dbg !167
  %cmp.not.i.i723.2 = icmp slt i32 %xor.i.i721.2, %and.i.i722.2, !dbg !168
  %cond.i.i724.2 = select i1 %cmp.not.i.i723.2, i32 %xor.i.i721.2, i32 %197, !dbg !169
  %shl.i.i725.2 = shl i32 %cond.i.i724.2, 2, !dbg !170
  %199 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.2, i32 %.695.2), !dbg !171
  %condval_6.0.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.42.0, i32 %199, !dbg !172
  %condval_7.0.2 = select i1 %cmp437.not.not, i32 %199, i32 %output_reg.sroa.52.0, !dbg !173
  %.695.1.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.57.0, i32 %output_reg.sroa.47.0
  %200 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %201 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %200) #9, !dbg !165
  %xor.i.i721.1.2 = xor i32 %201, 8, !dbg !166
  %202 = and i32 %201, -64, !dbg !167
  %and.i.i722.1.2 = add nsw i32 %202, 64, !dbg !167
  %cmp.not.i.i723.1.2 = icmp slt i32 %xor.i.i721.1.2, %and.i.i722.1.2, !dbg !168
  %cond.i.i724.1.2 = select i1 %cmp.not.i.i723.1.2, i32 %xor.i.i721.1.2, i32 %201, !dbg !169
  %shl.i.i725.1.2 = shl i32 %cond.i.i724.1.2, 2, !dbg !170
  %203 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1.2, i32 %.695.1.2), !dbg !171
  %condval_6.0.1.2 = select i1 %cmp437.not.not, i32 %output_reg.sroa.47.0, i32 %203, !dbg !172
  %condval_7.0.1.2 = select i1 %cmp437.not.not, i32 %203, i32 %output_reg.sroa.57.0, !dbg !173
  %.695.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.72.0, i32 %output_reg.sroa.62.0
  %204 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %205 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %204) #9, !dbg !165
  %xor.i.i721.3 = xor i32 %205, 8, !dbg !166
  %206 = and i32 %205, -64, !dbg !167
  %and.i.i722.3 = add nsw i32 %206, 64, !dbg !167
  %cmp.not.i.i723.3 = icmp slt i32 %xor.i.i721.3, %and.i.i722.3, !dbg !168
  %cond.i.i724.3 = select i1 %cmp.not.i.i723.3, i32 %xor.i.i721.3, i32 %205, !dbg !169
  %shl.i.i725.3 = shl i32 %cond.i.i724.3, 2, !dbg !170
  %207 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.3, i32 %.695.3), !dbg !171
  %condval_6.0.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.62.0, i32 %207, !dbg !172
  %condval_7.0.3 = select i1 %cmp437.not.not, i32 %207, i32 %output_reg.sroa.72.0, !dbg !173
  %.695.1.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.77.0, i32 %output_reg.sroa.67.0
  %208 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !161
  %209 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %208) #9, !dbg !165
  %xor.i.i721.1.3 = xor i32 %209, 8, !dbg !166
  %210 = and i32 %209, -64, !dbg !167
  %and.i.i722.1.3 = add nsw i32 %210, 64, !dbg !167
  %cmp.not.i.i723.1.3 = icmp slt i32 %xor.i.i721.1.3, %and.i.i722.1.3, !dbg !168
  %cond.i.i724.1.3 = select i1 %cmp.not.i.i723.1.3, i32 %xor.i.i721.1.3, i32 %209, !dbg !169
  %shl.i.i725.1.3 = shl i32 %cond.i.i724.1.3, 2, !dbg !170
  %211 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i725.1.3, i32 %.695.1.3), !dbg !171
  %condval_6.0.1.3 = select i1 %cmp437.not.not, i32 %output_reg.sroa.67.0, i32 %211, !dbg !172
  %condval_7.0.1.3 = select i1 %cmp437.not.not, i32 %211, i32 %output_reg.sroa.77.0, !dbg !173
  %and487 = and i32 %2, 4
  %cmp488.not.not = icmp eq i32 %and487, 0
  %.696 = select i1 %cmp488.not.not, i32 %condval_6.0.1838, i32 %condval_6.0
  %212 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %213 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %212) #9, !dbg !178
  %xor.i.i726 = xor i32 %213, 4, !dbg !179
  %214 = and i32 %213, -64, !dbg !180
  %and.i.i727 = add nsw i32 %214, 64, !dbg !180
  %cmp.not.i.i728 = icmp slt i32 %xor.i.i726, %and.i.i727, !dbg !181
  %cond.i.i729 = select i1 %cmp.not.i.i728, i32 %xor.i.i726, i32 %213, !dbg !182
  %shl.i.i730 = shl i32 %cond.i.i729, 2, !dbg !183
  %215 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730, i32 %.696), !dbg !184
  %condval_9.0 = select i1 %cmp488.not.not, i32 %condval_6.0, i32 %215, !dbg !185
  %output_halves.sroa.0.0.insert.ext = zext i32 %condval_9.0 to i64, !dbg !186
  %condval_10.0 = select i1 %cmp488.not.not, i32 %215, i32 %condval_6.0.1838, !dbg !187
  %output_halves.sroa.8.16.insert.ext = zext i32 %condval_10.0 to i64, !dbg !188
  %.696.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1.1, i32 %condval_6.0.1
  %216 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %217 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %216) #9, !dbg !178
  %xor.i.i726.1 = xor i32 %217, 4, !dbg !179
  %218 = and i32 %217, -64, !dbg !180
  %and.i.i727.1 = add nsw i32 %218, 64, !dbg !180
  %cmp.not.i.i728.1 = icmp slt i32 %xor.i.i726.1, %and.i.i727.1, !dbg !181
  %cond.i.i729.1 = select i1 %cmp.not.i.i728.1, i32 %xor.i.i726.1, i32 %217, !dbg !182
  %shl.i.i730.1 = shl i32 %cond.i.i729.1, 2, !dbg !183
  %219 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.1, i32 %.696.1), !dbg !184
  %condval_9.0.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1, i32 %219, !dbg !185
  %output_halves.sroa.0.4.insert.ext = zext i32 %condval_9.0.1 to i64, !dbg !186
  %output_halves.sroa.0.4.insert.shift = shl nuw i64 %output_halves.sroa.0.4.insert.ext, 32, !dbg !186
  %output_halves.sroa.0.4.insert.insert = or disjoint i64 %output_halves.sroa.0.4.insert.shift, %output_halves.sroa.0.0.insert.ext, !dbg !186
  %condval_10.0.1 = select i1 %cmp488.not.not, i32 %219, i32 %condval_6.0.1.1, !dbg !187
  %output_halves.sroa.8.20.insert.ext = zext i32 %condval_10.0.1 to i64, !dbg !188
  %output_halves.sroa.8.20.insert.shift = shl nuw i64 %output_halves.sroa.8.20.insert.ext, 32, !dbg !188
  %output_halves.sroa.8.20.insert.insert = or disjoint i64 %output_halves.sroa.8.20.insert.shift, %output_halves.sroa.8.16.insert.ext, !dbg !188
  %.696.2 = select i1 %cmp488.not.not, i32 %condval_7.0.1840, i32 %condval_7.0
  %220 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %221 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %220) #9, !dbg !178
  %xor.i.i726.2 = xor i32 %221, 4, !dbg !179
  %222 = and i32 %221, -64, !dbg !180
  %and.i.i727.2 = add nsw i32 %222, 64, !dbg !180
  %cmp.not.i.i728.2 = icmp slt i32 %xor.i.i726.2, %and.i.i727.2, !dbg !181
  %cond.i.i729.2 = select i1 %cmp.not.i.i728.2, i32 %xor.i.i726.2, i32 %221, !dbg !182
  %shl.i.i730.2 = shl i32 %cond.i.i729.2, 2, !dbg !183
  %223 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.2, i32 %.696.2), !dbg !184
  %condval_9.0.2 = select i1 %cmp488.not.not, i32 %condval_7.0, i32 %223, !dbg !185
  %output_halves.sroa.5.8.insert.ext = zext i32 %condval_9.0.2 to i64, !dbg !186
  %condval_10.0.2 = select i1 %cmp488.not.not, i32 %223, i32 %condval_7.0.1840, !dbg !187
  %output_halves.sroa.11.24.insert.ext = zext i32 %condval_10.0.2 to i64, !dbg !188
  %.696.3 = select i1 %cmp488.not.not, i32 %condval_7.0.1.1, i32 %condval_7.0.1
  %224 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %225 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %224) #9, !dbg !178
  %xor.i.i726.3 = xor i32 %225, 4, !dbg !179
  %226 = and i32 %225, -64, !dbg !180
  %and.i.i727.3 = add nsw i32 %226, 64, !dbg !180
  %cmp.not.i.i728.3 = icmp slt i32 %xor.i.i726.3, %and.i.i727.3, !dbg !181
  %cond.i.i729.3 = select i1 %cmp.not.i.i728.3, i32 %xor.i.i726.3, i32 %225, !dbg !182
  %shl.i.i730.3 = shl i32 %cond.i.i729.3, 2, !dbg !183
  %227 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.3, i32 %.696.3), !dbg !184
  %condval_9.0.3 = select i1 %cmp488.not.not, i32 %condval_7.0.1, i32 %227, !dbg !185
  %output_halves.sroa.5.12.insert.ext = zext i32 %condval_9.0.3 to i64, !dbg !186
  %output_halves.sroa.5.12.insert.shift = shl nuw i64 %output_halves.sroa.5.12.insert.ext, 32, !dbg !186
  %output_halves.sroa.5.12.insert.insert = or disjoint i64 %output_halves.sroa.5.12.insert.shift, %output_halves.sroa.5.8.insert.ext, !dbg !186
  %condval_10.0.3 = select i1 %cmp488.not.not, i32 %227, i32 %condval_7.0.1.1, !dbg !187
  %output_halves.sroa.11.28.insert.ext = zext i32 %condval_10.0.3 to i64, !dbg !188
  %output_halves.sroa.11.28.insert.shift = shl nuw i64 %output_halves.sroa.11.28.insert.ext, 32, !dbg !188
  %output_halves.sroa.11.28.insert.insert = or disjoint i64 %output_halves.sroa.11.28.insert.shift, %output_halves.sroa.11.24.insert.ext, !dbg !188
  %.696.1845 = select i1 %cmp488.not.not, i32 %condval_6.0.3, i32 %condval_6.0.2
  %228 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %229 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %228) #9, !dbg !178
  %xor.i.i726.1846 = xor i32 %229, 4, !dbg !179
  %230 = and i32 %229, -64, !dbg !180
  %and.i.i727.1847 = add nsw i32 %230, 64, !dbg !180
  %cmp.not.i.i728.1848 = icmp slt i32 %xor.i.i726.1846, %and.i.i727.1847, !dbg !181
  %cond.i.i729.1849 = select i1 %cmp.not.i.i728.1848, i32 %xor.i.i726.1846, i32 %229, !dbg !182
  %shl.i.i730.1850 = shl i32 %cond.i.i729.1849, 2, !dbg !183
  %231 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.1850, i32 %.696.1845), !dbg !184
  %condval_9.0.1851 = select i1 %cmp488.not.not, i32 %condval_6.0.2, i32 %231, !dbg !185
  %output_halves.sroa.14.32.insert.ext = zext i32 %condval_9.0.1851 to i64, !dbg !186
  %condval_10.0.1853 = select i1 %cmp488.not.not, i32 %231, i32 %condval_6.0.3, !dbg !187
  %output_halves.sroa.20.48.insert.ext = zext i32 %condval_10.0.1853 to i64, !dbg !188
  %.696.1.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1.3, i32 %condval_6.0.1.2
  %232 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %233 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %232) #9, !dbg !178
  %xor.i.i726.1.1 = xor i32 %233, 4, !dbg !179
  %234 = and i32 %233, -64, !dbg !180
  %and.i.i727.1.1 = add nsw i32 %234, 64, !dbg !180
  %cmp.not.i.i728.1.1 = icmp slt i32 %xor.i.i726.1.1, %and.i.i727.1.1, !dbg !181
  %cond.i.i729.1.1 = select i1 %cmp.not.i.i728.1.1, i32 %xor.i.i726.1.1, i32 %233, !dbg !182
  %shl.i.i730.1.1 = shl i32 %cond.i.i729.1.1, 2, !dbg !183
  %235 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.1.1, i32 %.696.1.1), !dbg !184
  %condval_9.0.1.1 = select i1 %cmp488.not.not, i32 %condval_6.0.1.2, i32 %235, !dbg !185
  %output_halves.sroa.14.36.insert.ext = zext i32 %condval_9.0.1.1 to i64, !dbg !186
  %output_halves.sroa.14.36.insert.shift = shl nuw i64 %output_halves.sroa.14.36.insert.ext, 32, !dbg !186
  %output_halves.sroa.14.36.insert.insert = or disjoint i64 %output_halves.sroa.14.36.insert.shift, %output_halves.sroa.14.32.insert.ext, !dbg !186
  %condval_10.0.1.1 = select i1 %cmp488.not.not, i32 %235, i32 %condval_6.0.1.3, !dbg !187
  %output_halves.sroa.20.52.insert.ext = zext i32 %condval_10.0.1.1 to i64, !dbg !188
  %output_halves.sroa.20.52.insert.shift = shl nuw i64 %output_halves.sroa.20.52.insert.ext, 32, !dbg !188
  %output_halves.sroa.20.52.insert.insert = or disjoint i64 %output_halves.sroa.20.52.insert.shift, %output_halves.sroa.20.48.insert.ext, !dbg !188
  %.696.2.1 = select i1 %cmp488.not.not, i32 %condval_7.0.3, i32 %condval_7.0.2
  %236 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %237 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %236) #9, !dbg !178
  %xor.i.i726.2.1 = xor i32 %237, 4, !dbg !179
  %238 = and i32 %237, -64, !dbg !180
  %and.i.i727.2.1 = add nsw i32 %238, 64, !dbg !180
  %cmp.not.i.i728.2.1 = icmp slt i32 %xor.i.i726.2.1, %and.i.i727.2.1, !dbg !181
  %cond.i.i729.2.1 = select i1 %cmp.not.i.i728.2.1, i32 %xor.i.i726.2.1, i32 %237, !dbg !182
  %shl.i.i730.2.1 = shl i32 %cond.i.i729.2.1, 2, !dbg !183
  %239 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.2.1, i32 %.696.2.1), !dbg !184
  %condval_9.0.2.1 = select i1 %cmp488.not.not, i32 %condval_7.0.2, i32 %239, !dbg !185
  %output_halves.sroa.17.40.insert.ext = zext i32 %condval_9.0.2.1 to i64, !dbg !186
  %condval_10.0.2.1 = select i1 %cmp488.not.not, i32 %239, i32 %condval_7.0.3, !dbg !187
  %output_halves.sroa.23.56.insert.ext = zext i32 %condval_10.0.2.1 to i64, !dbg !188
  %.696.3.1 = select i1 %cmp488.not.not, i32 %condval_7.0.1.3, i32 %condval_7.0.1.2
  %240 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !174
  %241 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %240) #9, !dbg !178
  %xor.i.i726.3.1 = xor i32 %241, 4, !dbg !179
  %242 = and i32 %241, -64, !dbg !180
  %and.i.i727.3.1 = add nsw i32 %242, 64, !dbg !180
  %cmp.not.i.i728.3.1 = icmp slt i32 %xor.i.i726.3.1, %and.i.i727.3.1, !dbg !181
  %cond.i.i729.3.1 = select i1 %cmp.not.i.i728.3.1, i32 %xor.i.i726.3.1, i32 %241, !dbg !182
  %shl.i.i730.3.1 = shl i32 %cond.i.i729.3.1, 2, !dbg !183
  %243 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i730.3.1, i32 %.696.3.1), !dbg !184
  %condval_9.0.3.1 = select i1 %cmp488.not.not, i32 %condval_7.0.1.2, i32 %243, !dbg !185
  %output_halves.sroa.17.44.insert.ext = zext i32 %condval_9.0.3.1 to i64, !dbg !186
  %output_halves.sroa.17.44.insert.shift = shl nuw i64 %output_halves.sroa.17.44.insert.ext, 32, !dbg !186
  %output_halves.sroa.17.44.insert.insert = or disjoint i64 %output_halves.sroa.17.44.insert.shift, %output_halves.sroa.17.40.insert.ext, !dbg !186
  %condval_10.0.3.1 = select i1 %cmp488.not.not, i32 %243, i32 %condval_7.0.1.3, !dbg !187
  %output_halves.sroa.23.60.insert.ext = zext i32 %condval_10.0.3.1 to i64, !dbg !188
  %output_halves.sroa.23.60.insert.shift = shl nuw i64 %output_halves.sroa.23.60.insert.ext, 32, !dbg !188
  %output_halves.sroa.23.60.insert.insert = or disjoint i64 %output_halves.sroa.23.60.insert.shift, %output_halves.sroa.23.56.insert.ext, !dbg !188
  %mul544 = and i32 %and, 384
  %mul552 = and i32 %.pre-phi, 32
  %244 = shl nuw nsw i32 %2, 1
  %mul557 = and i32 %244, 16
  %245 = or disjoint i32 %mul544, %mul552
  %246 = or disjoint i32 %245, %mul557
  %add537 = or disjoint i32 %246, %add21
  %add541 = add nuw nsw i32 %add537, %mul561.pre-phi
  %idx.ext563 = sext i32 %add541 to i64, !dbg !189
  %add.ptr564 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563, !dbg !189
  store i64 %output_halves.sroa.0.4.insert.insert, ptr addrspace(1) %add.ptr564, align 8, !dbg !190
  %add545.1 = or disjoint i32 %add541, 1024, !dbg !191
  %idx.ext563.1 = sext i32 %add545.1 to i64, !dbg !189
  %add.ptr564.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.1, !dbg !189
  store i64 %output_halves.sroa.5.12.insert.insert, ptr addrspace(1) %add.ptr564.1, align 8, !dbg !190
  %247 = sext i32 %add541 to i64, !dbg !189
  %248 = getelementptr %struct.__half, ptr addrspace(1) %Output.coerce, i64 %247, !dbg !189
  %add.ptr564.2 = getelementptr i8, ptr addrspace(1) %248, i64 1024, !dbg !189
  store i64 %output_halves.sroa.8.20.insert.insert, ptr addrspace(1) %add.ptr564.2, align 8, !dbg !190
  %add548.3 = add i32 %add541, 1536, !dbg !192
  %idx.ext563.3 = sext i32 %add548.3 to i64, !dbg !189
  %add.ptr564.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.3, !dbg !189
  store i64 %output_halves.sroa.11.28.insert.insert, ptr addrspace(1) %add.ptr564.3, align 8, !dbg !190
  %249 = sext i32 %add541 to i64, !dbg !189
  %250 = getelementptr %struct.__half, ptr addrspace(1) %Output.coerce, i64 %249, !dbg !189
  %add.ptr564.4 = getelementptr i8, ptr addrspace(1) %250, i64 128, !dbg !189
  store i64 %output_halves.sroa.14.36.insert.insert, ptr addrspace(1) %add.ptr564.4, align 8, !dbg !190
  %add562.5 = add i32 %add541, 1088, !dbg !193
  %idx.ext563.5 = sext i32 %add562.5 to i64, !dbg !189
  %add.ptr564.5 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.5, !dbg !189
  store i64 %output_halves.sroa.17.44.insert.insert, ptr addrspace(1) %add.ptr564.5, align 8, !dbg !190
  %251 = sext i32 %add541 to i64, !dbg !189
  %252 = getelementptr %struct.__half, ptr addrspace(1) %Output.coerce, i64 %251, !dbg !189
  %add.ptr564.6 = getelementptr i8, ptr addrspace(1) %252, i64 1152, !dbg !189
  store i64 %output_halves.sroa.20.52.insert.insert, ptr addrspace(1) %add.ptr564.6, align 8, !dbg !190
  %add562.7 = add i32 %add541, 1600, !dbg !193
  %idx.ext563.7 = sext i32 %add562.7 to i64, !dbg !189
  %add.ptr564.7 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext563.7, !dbg !189
  store i64 %output_halves.sroa.23.60.insert.insert, ptr addrspace(1) %add.ptr564.7, align 8, !dbg !190
  ret void, !dbg !194
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpallhxqqs/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 8, !"PIC Level", i32 1}
!5 = distinct !DISubprogram(name: "__cxa_pure_virtual", scope: !6, file: !6, line: 38, type: !7, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!6 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_runtime_wrapper.h", directory: "")
!7 = !DISubroutineType(types: !8)
!8 = !{}
!9 = !DILocation(line: 39, column: 3, scope: !5)
!10 = !DILocation(line: 40, column: 1, scope: !5)
!11 = distinct !DISubprogram(name: "__cxa_deleted_virtual", scope: !6, file: !6, line: 43, type: !7, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!12 = !DILocation(line: 44, column: 3, scope: !11)
!13 = !DILocation(line: 45, column: 1, scope: !11)
!14 = distinct !DISubprogram(name: "__mcImplicitDeviceSynchronize", scope: !15, file: !15, line: 92, type: !7, scopeLine: 93, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!15 = !DIFile(filename: "/opt/maca/include/mckl/mc_device_runtime.h", directory: "")
!16 = !DILocation(line: 94, column: 5, scope: !14)
!17 = !{!18, !18, i64 0}
!18 = !{!"long", !19, i64 0}
!19 = !{!"omnipotent char", !20, i64 0}
!20 = !{!"Simple C++ TBAA"}
!21 = !{!22, !24, i64 16}
!22 = !{!"_ZTS21_DynamicParallMqlWrap", !23, i64 0, !23, i64 4, !23, i64 8, !23, i64 12, !24, i64 16, !24, i64 24, !25, i64 32}
!23 = !{!"int", !19, i64 0}
!24 = !{!"any pointer", !19, i64 0}
!25 = !{!"_ZTS28mxc_kernel_dispatch_packet_s", !26, i64 0, !26, i64 2, !26, i64 4, !26, i64 6, !26, i64 8, !26, i64 10, !23, i64 12, !23, i64 16, !23, i64 20, !23, i64 24, !23, i64 28, !18, i64 32, !24, i64 40, !18, i64 48, !27, i64 56}
!26 = !{!"short", !19, i64 0}
!27 = !{!"_ZTS12mxc_signal_s", !18, i64 0}
!28 = !{i32 1, i32 -2147483648}
!29 = !{i32 0, i32 2147483647}
!30 = !{!23, !23, i64 0}
!31 = distinct !{!31, !32}
!32 = !{!"llvm.loop.mustprogress"}
!33 = !{!22, !23, i64 4}
!34 = !{!22, !24, i64 24}
!35 = !{!22, !23, i64 0}
!36 = !{!37, !24, i64 24}
!37 = !{!"_ZTS28_DynamicParallSchedulerParam", !18, i64 0, !24, i64 8, !24, i64 16, !24, i64 24, !18, i64 32, !18, i64 40, !18, i64 48, !18, i64 56, !18, i64 64, !18, i64 72, !18, i64 80, !18, i64 88, !18, i64 96, !23, i64 104, !23, i64 108, !23, i64 112, !23, i64 116, !23, i64 120, !23, i64 124}
!38 = !{!37, !18, i64 80}
!39 = !DILocation(line: 95, column: 1, scope: !14)
!40 = distinct !DISubprogram(name: "kernel_kernel", scope: !41, file: !41, line: 10, type: !7, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!41 = !DIFile(filename: "/tmp/tmpallhxqqs/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 27, column: 3, scope: !40)
!44 = !DILocation(line: 30, column: 84, scope: !40)
!45 = !DILocation(line: 30, column: 70, scope: !40)
!46 = !DILocation(line: 33, column: 43, scope: !40)
!47 = !DILocation(line: 33, column: 51, scope: !40)
!48 = !DILocation(line: 33, column: 15, scope: !40)
!49 = !DILocation(line: 34, column: 31, scope: !40)
!50 = !DILocation(line: 34, column: 59, scope: !40)
!51 = !DILocation(line: 34, column: 65, scope: !40)
!52 = !DILocation(line: 35, column: 7, scope: !40)
!53 = !DILocation(line: 37, column: 5, scope: !40)
!54 = !DILocation(line: 38, column: 51, scope: !40)
!55 = !DILocation(line: 38, column: 30, scope: !40)
!56 = !DILocation(line: 171, column: 37, scope: !57, inlinedAt: !59)
!57 = distinct !DISubprogram(name: "__lane_id", scope: !58, file: !58, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!58 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!59 = distinct !DILocation(line: 990, column: 14, scope: !60, inlinedAt: !61)
!60 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !58, file: !58, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!61 = distinct !DILocation(line: 1006, column: 11, scope: !62, inlinedAt: !63)
!62 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !58, file: !58, line: 996, type: !7, scopeLine: 999, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!63 = distinct !DILocation(line: 52, column: 21, scope: !40)
!64 = !DILocation(line: 171, column: 10, scope: !57, inlinedAt: !59)
!65 = !DILocation(line: 991, column: 20, scope: !60, inlinedAt: !61)
!66 = !DILocation(line: 992, column: 36, scope: !60, inlinedAt: !61)
!67 = !DILocation(line: 992, column: 17, scope: !60, inlinedAt: !61)
!68 = !DILocation(line: 992, column: 11, scope: !60, inlinedAt: !61)
!69 = !DILocation(line: 993, column: 43, scope: !60, inlinedAt: !61)
!70 = !DILocation(line: 993, column: 10, scope: !60, inlinedAt: !61)
!71 = !DILocation(line: 54, column: 13, scope: !40)
!72 = !DILocation(line: 61, column: 13, scope: !40)
!73 = !DILocation(line: 73, column: 37, scope: !40)
!74 = !DILocation(line: 79, column: 114, scope: !40)
!75 = !DILocation(line: 79, column: 11, scope: !40)
!76 = !DILocation(line: 84, column: 19, scope: !40)
!77 = !DILocation(line: 79, column: 66, scope: !40)
!78 = !DILocation(line: 79, column: 101, scope: !40)
!79 = !DILocation(line: 90, column: 37, scope: !40)
!80 = !{i32 2, i32 -1, i32 -1}
!81 = !DILocation(line: 98, column: 5, scope: !40)
!82 = !DILocation(line: 99, column: 53, scope: !40)
!83 = !DILocation(line: 99, column: 32, scope: !40)
!84 = !DILocation(line: 103, column: 32, scope: !40)
!85 = !DILocation(line: 103, column: 44, scope: !40)
!86 = !DILocation(line: 354, column: 10, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: "min", scope: !88, file: !88, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!89 = distinct !DILocation(line: 103, column: 27, scope: !40)
!90 = !DILocation(line: 285, column: 49, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "exp2f", scope: !88, file: !88, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = distinct !DILocation(line: 103, column: 21, scope: !40)
!93 = !DILocation(line: 108, column: 28, scope: !40)
!94 = !DILocation(line: 1018, column: 9, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !58, file: !58, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 396, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !98, file: !98, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!99 = distinct !DILocation(line: 129, column: 24, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !101, file: !101, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!102 = distinct !DILocation(line: 101, column: 14, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "run<float>", scope: !101, file: !101, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 110, column: 16, scope: !40)
!105 = !DILocation(line: 171, column: 37, scope: !57, inlinedAt: !106)
!106 = distinct !DILocation(line: 990, column: 14, scope: !60, inlinedAt: !107)
!107 = distinct !DILocation(line: 1019, column: 11, scope: !95, inlinedAt: !96)
!108 = !DILocation(line: 171, column: 10, scope: !57, inlinedAt: !106)
!109 = !DILocation(line: 991, column: 20, scope: !60, inlinedAt: !107)
!110 = !DILocation(line: 992, column: 36, scope: !60, inlinedAt: !107)
!111 = !DILocation(line: 992, column: 17, scope: !60, inlinedAt: !107)
!112 = !DILocation(line: 992, column: 11, scope: !60, inlinedAt: !107)
!113 = !DILocation(line: 993, column: 43, scope: !60, inlinedAt: !107)
!114 = !DILocation(line: 993, column: 10, scope: !60, inlinedAt: !107)
!115 = !DILocation(line: 1020, column: 14, scope: !95, inlinedAt: !96)
!116 = !DILocation(line: 25, column: 14, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "operator()<float>", scope: !101, file: !101, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = distinct !DILocation(line: 129, column: 11, scope: !100, inlinedAt: !102)
!119 = !DILocation(line: 1018, column: 9, scope: !95, inlinedAt: !120)
!120 = distinct !DILocation(line: 396, column: 10, scope: !97, inlinedAt: !121)
!121 = distinct !DILocation(line: 129, column: 24, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !101, file: !101, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 101, column: 14, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "run<float>", scope: !101, file: !101, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = distinct !DILocation(line: 134, column: 14, scope: !100, inlinedAt: !102)
!126 = !DILocation(line: 171, column: 37, scope: !57, inlinedAt: !127)
!127 = distinct !DILocation(line: 990, column: 14, scope: !60, inlinedAt: !128)
!128 = distinct !DILocation(line: 1019, column: 11, scope: !95, inlinedAt: !120)
!129 = !DILocation(line: 171, column: 10, scope: !57, inlinedAt: !127)
!130 = !DILocation(line: 991, column: 20, scope: !60, inlinedAt: !128)
!131 = !DILocation(line: 992, column: 36, scope: !60, inlinedAt: !128)
!132 = !DILocation(line: 992, column: 17, scope: !60, inlinedAt: !128)
!133 = !DILocation(line: 992, column: 11, scope: !60, inlinedAt: !128)
!134 = !DILocation(line: 993, column: 43, scope: !60, inlinedAt: !128)
!135 = !DILocation(line: 993, column: 10, scope: !60, inlinedAt: !128)
!136 = !DILocation(line: 1020, column: 14, scope: !95, inlinedAt: !120)
!137 = !DILocation(line: 25, column: 14, scope: !117, inlinedAt: !138)
!138 = distinct !DILocation(line: 129, column: 11, scope: !122, inlinedAt: !123)
!139 = !DILocation(line: 112, column: 34, scope: !40)
!140 = !DILocation(line: 112, column: 9, scope: !40)
!141 = !DILocation(line: 120, column: 34, scope: !40)
!142 = !DILocation(line: 75, column: 10, scope: !143, inlinedAt: !145)
!143 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !144, file: !144, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!144 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!145 = distinct !DILocation(line: 984, column: 9, scope: !146, inlinedAt: !148)
!146 = distinct !DISubprogram(name: "__float2half", scope: !147, file: !147, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!147 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!148 = distinct !DILocation(line: 133, column: 53, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__half", scope: !147, file: !147, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 126, column: 49, scope: !40)
!151 = !DILocation(line: 126, column: 46, scope: !40)
!152 = !DILocation(line: 137, column: 36, scope: !40)
!153 = !DILocation(line: 147, column: 67, scope: !40)
!154 = !DILocation(line: 75, column: 10, scope: !143, inlinedAt: !155)
!155 = distinct !DILocation(line: 984, column: 9, scope: !146, inlinedAt: !156)
!156 = distinct !DILocation(line: 133, column: 53, scope: !149, inlinedAt: !157)
!157 = distinct !DILocation(line: 147, column: 59, scope: !40)
!158 = !DILocation(line: 147, column: 56, scope: !40)
!159 = !DILocation(line: 158, column: 3, scope: !40)
!160 = !DILocation(line: 0, scope: !40)
!161 = !DILocation(line: 171, column: 37, scope: !57, inlinedAt: !162)
!162 = distinct !DILocation(line: 990, column: 14, scope: !60, inlinedAt: !163)
!163 = distinct !DILocation(line: 1006, column: 11, scope: !62, inlinedAt: !164)
!164 = distinct !DILocation(line: 176, column: 24, scope: !40)
!165 = !DILocation(line: 171, column: 10, scope: !57, inlinedAt: !162)
!166 = !DILocation(line: 991, column: 20, scope: !60, inlinedAt: !163)
!167 = !DILocation(line: 992, column: 36, scope: !60, inlinedAt: !163)
!168 = !DILocation(line: 992, column: 17, scope: !60, inlinedAt: !163)
!169 = !DILocation(line: 992, column: 11, scope: !60, inlinedAt: !163)
!170 = !DILocation(line: 993, column: 43, scope: !60, inlinedAt: !163)
!171 = !DILocation(line: 993, column: 10, scope: !60, inlinedAt: !163)
!172 = !DILocation(line: 178, column: 11, scope: !40)
!173 = !DILocation(line: 185, column: 11, scope: !40)
!174 = !DILocation(line: 171, column: 37, scope: !57, inlinedAt: !175)
!175 = distinct !DILocation(line: 990, column: 14, scope: !60, inlinedAt: !176)
!176 = distinct !DILocation(line: 1006, column: 11, scope: !62, inlinedAt: !177)
!177 = distinct !DILocation(line: 205, column: 26, scope: !40)
!178 = !DILocation(line: 171, column: 10, scope: !57, inlinedAt: !175)
!179 = !DILocation(line: 991, column: 20, scope: !60, inlinedAt: !176)
!180 = !DILocation(line: 992, column: 36, scope: !60, inlinedAt: !176)
!181 = !DILocation(line: 992, column: 17, scope: !60, inlinedAt: !176)
!182 = !DILocation(line: 992, column: 11, scope: !60, inlinedAt: !176)
!183 = !DILocation(line: 993, column: 43, scope: !60, inlinedAt: !176)
!184 = !DILocation(line: 993, column: 10, scope: !60, inlinedAt: !176)
!185 = !DILocation(line: 207, column: 11, scope: !40)
!186 = !DILocation(line: 212, column: 56, scope: !40)
!187 = !DILocation(line: 214, column: 11, scope: !40)
!188 = !DILocation(line: 219, column: 62, scope: !40)
!189 = !DILocation(line: 224, column: 22, scope: !40)
!190 = !DILocation(line: 224, column: 332, scope: !40)
!191 = !DILocation(line: 224, column: 150, scope: !40)
!192 = !DILocation(line: 224, column: 186, scope: !40)
!193 = !DILocation(line: 224, column: 296, scope: !40)
!194 = !DILocation(line: 226, column: 1, scope: !40)
