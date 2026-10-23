; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_goal8933/validation_v11_final/binary/s4_b1_t1536_h1_c1_m1_p0.bc'
source_filename = "/tmp/tmpsuto8p37/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
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

; Function Attrs: convergent mustprogress norecurse nounwind
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %blocks = alloca [4 x i32], align 4, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 16, ptr addrspace(5) %blocks) #12, !dbg !42, !call_argsrelate !43
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !44
  %and = shl nuw nsw i32 %1, 6
  %mul7 = and i32 %and, 960
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !45
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !46
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !47
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !47
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !47
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !46
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64, !dbg !46
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !47
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72, !dbg !47
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !47
  %mul22 = shl nsw i32 %0, 2
  %5 = zext nneg i32 %mul22 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %5, !dbg !49
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !49, !tbaa !30
  store i32 %6, ptr addrspace(5) %blocks, align 4, !dbg !50, !tbaa !30
  %7 = or disjoint i64 %5, 1, !dbg !51
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %7, !dbg !49
  %8 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !49, !tbaa !30
  %arrayidx25.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4, !dbg !52
  store i32 %8, ptr addrspace(5) %arrayidx25.1, align 4, !dbg !50, !tbaa !30
  %9 = or disjoint i64 %5, 2, !dbg !51
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %9, !dbg !49
  %10 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !49, !tbaa !30
  %arrayidx25.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8, !dbg !52
  store i32 %10, ptr addrspace(5) %arrayidx25.2, align 4, !dbg !50, !tbaa !30
  %11 = or disjoint i64 %5, 3, !dbg !51
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %11, !dbg !49
  %12 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !49, !tbaa !30
  %arrayidx25.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12, !dbg !52
  store i32 %12, ptr addrspace(5) %arrayidx25.3, align 4, !dbg !50, !tbaa !30
  %or.cond = icmp ugt i32 %6, 95, !dbg !53
  %shr34 = lshr i32 %0, 4
  %cmp35.not = icmp ugt i32 %6, %shr34
  %or.cond952 = or i1 %or.cond, %cmp35.not, !dbg !53
  br i1 %or.cond952, label %if.end, label %for.cond36.preheader, !dbg !53

for.cond36.preheader:                             ; preds = %entry
  %mul45 = shl nuw nsw i32 %6, 10
  %mul49 = shl nuw nsw i32 %1, 3
  %add47 = add nuw nsw i32 %mul45, %mul49
  %13 = zext nneg i32 %add47 to i64, !dbg !54
  %add.ptr54 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !55
  %14 = load i32, ptr addrspace(4) %add.ptr54, align 4, !dbg !56, !tbaa !30
  %15 = or disjoint i64 %13, 2, !dbg !57
  %add.ptr54.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !55
  %16 = load i32, ptr addrspace(4) %add.ptr54.1, align 4, !dbg !56, !tbaa !30
  %17 = or disjoint i64 %13, 4, !dbg !57
  %add.ptr54.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !55
  %18 = load i32, ptr addrspace(4) %add.ptr54.2, align 4, !dbg !56, !tbaa !30
  %19 = or disjoint i64 %13, 6, !dbg !57
  %add.ptr54.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !55
  %20 = load i32, ptr addrspace(4) %add.ptr54.3, align 4, !dbg !56, !tbaa !30
  %21 = add nuw nsw i64 %13, 512
  %add.ptr54.1754 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21, !dbg !55
  %22 = load i32, ptr addrspace(4) %add.ptr54.1754, align 4, !dbg !56, !tbaa !30
  %23 = add nuw nsw i64 %13, 514, !dbg !57
  %add.ptr54.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23, !dbg !55
  %24 = load i32, ptr addrspace(4) %add.ptr54.1.1, align 4, !dbg !56, !tbaa !30
  %25 = add nuw nsw i64 %13, 516, !dbg !57
  %add.ptr54.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25, !dbg !55
  %26 = load i32, ptr addrspace(4) %add.ptr54.2.1, align 4, !dbg !56, !tbaa !30
  %27 = add nuw nsw i64 %13, 518, !dbg !57
  %add.ptr54.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27, !dbg !55
  %28 = load i32, ptr addrspace(4) %add.ptr54.3.1, align 4, !dbg !56, !tbaa !30
  %add.ptr84 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !58
  %29 = load i32, ptr addrspace(4) %add.ptr84, align 4, !dbg !59, !tbaa !30
  %add.ptr84.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !58
  %30 = load i32, ptr addrspace(4) %add.ptr84.1, align 4, !dbg !59, !tbaa !30
  %add.ptr84.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !58
  %31 = load i32, ptr addrspace(4) %add.ptr84.2, align 4, !dbg !59, !tbaa !30
  %add.ptr84.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !58
  %32 = load i32, ptr addrspace(4) %add.ptr84.3, align 4, !dbg !59, !tbaa !30
  %add.ptr84.1766 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21, !dbg !58
  %33 = load i32, ptr addrspace(4) %add.ptr84.1766, align 4, !dbg !59, !tbaa !30
  %add.ptr84.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23, !dbg !58
  %34 = load i32, ptr addrspace(4) %add.ptr84.1.1, align 4, !dbg !59, !tbaa !30
  %add.ptr84.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25, !dbg !58
  %35 = load i32, ptr addrspace(4) %add.ptr84.2.1, align 4, !dbg !59, !tbaa !30
  %add.ptr84.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27, !dbg !58
  %36 = load i32, ptr addrspace(4) %add.ptr84.3.1, align 4, !dbg !59, !tbaa !30
  br label %if.end, !dbg !60

if.end:                                           ; preds = %entry, %for.cond36.preheader
  %k.sroa.18.0 = phi i32 [ %28, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.16.0 = phi i32 [ %26, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.14.0 = phi i32 [ %24, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.11.0 = phi i32 [ %22, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.9.0 = phi i32 [ %20, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.7.0 = phi i32 [ %18, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.5.0 = phi i32 [ %16, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.0.0 = phi i32 [ %14, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.18.0 = phi i32 [ %36, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.16.0 = phi i32 [ %35, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.14.0 = phi i32 [ %34, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.11.0 = phi i32 [ %33, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.9.0 = phi i32 [ %32, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.7.0 = phi i32 [ %31, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.5.0 = phi i32 [ %30, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.0.0 = phi i32 [ %29, %for.cond36.preheader ], [ undef, %entry ]
  %37 = shl nuw nsw i32 %1, 3
  %mul138 = and i32 %37, 8128
  %xor673 = and i32 %37, 56
  %call142.masked = and i32 %1, 1016
  %mul144 = xor i32 %xor673, %call142.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul138
  %invariant.gep696 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul144
  %38 = lshr i32 %1, 2
  %mul163 = and i32 %38, 252
  %shr191 = lshr i32 %1, 4
  %and194 = and i32 %1, 7
  %39 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul7
  %invariant.gep708 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2048
  %40 = shl nuw nsw i32 %1, 4
  %mul377 = and i32 %40, 16128
  %and382 = lshr i32 %1, 3
  %shr383 = and i32 %and382, 1
  %mul388 = and i32 %38, 4
  %k.sroa.5.0.invariant.gep696.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 4
  %k.sroa.7.0.invariant.gep696.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 8
  %k.sroa.9.0.invariant.gep696.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 12
  %gep697.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1024
  %k.sroa.14.16.gep697.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1028
  %k.sroa.16.16.gep697.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1032
  %k.sroa.18.16.gep697.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1036
  %xor195 = xor i32 %shr191, %and194
  %add.ptr199.idx = shl nuw nsw i32 %xor195, 4
  %add.ptr199 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %add.ptr199.idx
  %kb.sroa.6.0.add.ptr199.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr199, i32 8
  %add192.1 = add nuw nsw i32 %shr191, 4
  %xor195.1 = xor i32 %add192.1, %and194
  %add.ptr199.idx.1 = shl nuw nsw i32 %xor195.1, 4
  %add.ptr199.1 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %add.ptr199.idx.1
  %kb.sroa.6.0.add.ptr199.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr199.1, i32 8
  %v.sroa.5.0.invariant.gep708.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2052
  %v.sroa.7.0.invariant.gep708.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2056
  %v.sroa.9.0.invariant.gep708.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3072
  %v.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3076
  %v.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3080
  %v.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3084
  %xor390 = or disjoint i32 %mul388, %shr383
  %mul391 = shl nuw nsw i32 %xor390, 3
  %add392 = or disjoint i32 %mul391, %mul377
  %add395 = or disjoint i32 %add392, %and194
  %gep716 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395
  %add379.1 = or disjoint i32 %mul377, 64
  %add389.1 = or disjoint i32 %mul388, 1
  %xor390.1 = xor i32 %add389.1, %shr383
  %mul391.1 = shl nuw nsw i32 %xor390.1, 3
  %add392.1 = or disjoint i32 %mul391.1, %add379.1
  %add395.1 = or disjoint i32 %add392.1, %and194
  %gep716.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1
  %add379.2 = or disjoint i32 %mul377, 128
  %add389.2 = or disjoint i32 %mul388, 2
  %xor390.2 = or disjoint i32 %add389.2, %shr383
  %mul391.2 = shl nuw nsw i32 %xor390.2, 3
  %add392.2 = or disjoint i32 %mul391.2, %add379.2
  %add395.2 = or disjoint i32 %add392.2, %and194
  %gep716.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2
  %add379.3 = or disjoint i32 %mul377, 192
  %add389.3 = or disjoint i32 %mul388, 3
  %xor390.3 = xor i32 %add389.3, %shr383
  %mul391.3 = shl nuw nsw i32 %xor390.3, 3
  %add392.3 = or disjoint i32 %mul391.3, %add379.3
  %add395.3 = or disjoint i32 %add392.3, %and194
  %gep716.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3
  %add384.1 = or disjoint i32 %shr383, 2
  %xor390.1794 = or disjoint i32 %mul388, %add384.1
  %mul391.1795 = shl nuw nsw i32 %xor390.1794, 3
  %add392.1796 = or disjoint i32 %mul391.1795, %mul377
  %add395.1797 = or disjoint i32 %add392.1796, %and194
  %gep716.1798 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1797
  %xor390.1.1 = xor i32 %add389.1, %add384.1
  %mul391.1.1 = shl nuw nsw i32 %xor390.1.1, 3
  %add392.1.1 = or disjoint i32 %mul391.1.1, %add379.1
  %add395.1.1 = or disjoint i32 %add392.1.1, %and194
  %gep716.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1.1
  %xor390.2.1 = xor i32 %add389.2, %add384.1
  %mul391.2.1 = shl nuw nsw i32 %xor390.2.1, 3
  %add392.2.1 = or disjoint i32 %mul391.2.1, %add379.2
  %add395.2.1 = or disjoint i32 %add392.2.1, %and194
  %gep716.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2.1
  %xor390.3.1 = xor i32 %add389.3, %add384.1
  %mul391.3.1 = shl nuw nsw i32 %xor390.3.1, 3
  %add392.3.1 = or disjoint i32 %mul391.3.1, %add379.3
  %add395.3.1 = or disjoint i32 %add392.3.1, %and194
  %gep716.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3.1
  %add384.2 = or disjoint i32 %shr383, 4
  %xor390.2800 = xor i32 %mul388, %add384.2
  %mul391.2801 = shl nuw nsw i32 %xor390.2800, 3
  %add392.2802 = or disjoint i32 %mul391.2801, %mul377
  %add395.2803 = or disjoint i32 %add392.2802, %and194
  %gep716.2804 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2803
  %xor390.1.2 = xor i32 %add389.1, %add384.2
  %mul391.1.2 = shl nuw nsw i32 %xor390.1.2, 3
  %add392.1.2 = or disjoint i32 %mul391.1.2, %add379.1
  %add395.1.2 = or disjoint i32 %add392.1.2, %and194
  %gep716.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1.2
  %xor390.2.2 = xor i32 %add389.2, %add384.2
  %mul391.2.2 = shl nuw nsw i32 %xor390.2.2, 3
  %add392.2.2 = or disjoint i32 %mul391.2.2, %add379.2
  %add395.2.2 = or disjoint i32 %add392.2.2, %and194
  %gep716.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2.2
  %xor390.3.2 = xor i32 %add389.3, %add384.2
  %mul391.3.2 = shl nuw nsw i32 %xor390.3.2, 3
  %add392.3.2 = or disjoint i32 %mul391.3.2, %add379.3
  %add395.3.2 = or disjoint i32 %add392.3.2, %and194
  %gep716.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3.2
  %add384.3 = or disjoint i32 %shr383, 6
  %xor390.3806 = xor i32 %mul388, %add384.3
  %mul391.3807 = shl nuw nsw i32 %xor390.3806, 3
  %add392.3808 = or disjoint i32 %mul391.3807, %mul377
  %add395.3809 = or disjoint i32 %add392.3808, %and194
  %gep716.3810 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3809
  %xor390.1.3 = xor i32 %add389.1, %add384.3
  %mul391.1.3 = shl nuw nsw i32 %xor390.1.3, 3
  %add392.1.3 = or disjoint i32 %mul391.1.3, %add379.1
  %add395.1.3 = or disjoint i32 %add392.1.3, %and194
  %gep716.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1.3
  %xor390.2.3 = xor i32 %add389.2, %add384.3
  %mul391.2.3 = shl nuw nsw i32 %xor390.2.3, 3
  %add392.2.3 = or disjoint i32 %mul391.2.3, %add379.2
  %add395.2.3 = or disjoint i32 %add392.2.3, %and194
  %gep716.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2.3
  %xor390.3.3 = xor i32 %add389.3, %add384.3
  %mul391.3.3 = shl nuw nsw i32 %xor390.3.3, 3
  %add392.3.3 = or disjoint i32 %mul391.3.3, %add379.3
  %add395.3.3 = or disjoint i32 %add392.3.3, %and194
  %gep716.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3.3
  br label %for.body116, !dbg !61

for.body116:                                      ; preds = %if.end427.1, %if.end
  %k.sroa.18.1 = phi i32 [ %k.sroa.18.0, %if.end ], [ %k.sroa.18.2.1, %if.end427.1 ]
  %k.sroa.16.1 = phi i32 [ %k.sroa.16.0, %if.end ], [ %k.sroa.16.2.1, %if.end427.1 ]
  %k.sroa.14.1 = phi i32 [ %k.sroa.14.0, %if.end ], [ %k.sroa.14.2.1, %if.end427.1 ]
  %k.sroa.11.1 = phi i32 [ %k.sroa.11.0, %if.end ], [ %k.sroa.11.2.1, %if.end427.1 ]
  %k.sroa.9.1 = phi i32 [ %k.sroa.9.0, %if.end ], [ %k.sroa.9.2.1, %if.end427.1 ]
  %k.sroa.7.1 = phi i32 [ %k.sroa.7.0, %if.end ], [ %k.sroa.7.2.1, %if.end427.1 ]
  %k.sroa.5.1 = phi i32 [ %k.sroa.5.0, %if.end ], [ %k.sroa.5.2.1, %if.end427.1 ]
  %k.sroa.0.1 = phi i32 [ %k.sroa.0.0, %if.end ], [ %k.sroa.0.2.1, %if.end427.1 ]
  %v.sroa.18.1 = phi i32 [ %v.sroa.18.0, %if.end ], [ %v.sroa.18.2.1, %if.end427.1 ]
  %v.sroa.16.1 = phi i32 [ %v.sroa.16.0, %if.end ], [ %v.sroa.16.2.1, %if.end427.1 ]
  %v.sroa.14.1 = phi i32 [ %v.sroa.14.0, %if.end ], [ %v.sroa.14.2.1, %if.end427.1 ]
  %v.sroa.11.1 = phi i32 [ %v.sroa.11.0, %if.end ], [ %v.sroa.11.2.1, %if.end427.1 ]
  %v.sroa.9.1 = phi i32 [ %v.sroa.9.0, %if.end ], [ %v.sroa.9.2.1, %if.end427.1 ]
  %v.sroa.7.1 = phi i32 [ %v.sroa.7.0, %if.end ], [ %v.sroa.7.2.1, %if.end427.1 ]
  %v.sroa.5.1 = phi i32 [ %v.sroa.5.0, %if.end ], [ %v.sroa.5.2.1, %if.end427.1 ]
  %v.sroa.0.1 = phi i32 [ %v.sroa.0.0, %if.end ], [ %v.sroa.0.2.1, %if.end427.1 ]
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end427.1 ], !dbg !62
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end427.1 ], !dbg !62
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end427.1 ], !dbg !62
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end427.1 ], !dbg !62
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end427.1 ], !dbg !63
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end427.1 ], !dbg !63
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end427.1 ], !dbg !63
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end427.1 ], !dbg !63
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end427.1 ]
  %s_1.0720 = phi i32 [ 0, %if.end ], [ %inc429.1, %if.end427.1 ]
  %arrayidx118 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0720, !dbg !64
  %41 = load i32, ptr addrspace(5) %arrayidx118, align 4, !dbg !64, !tbaa !30
  %or.cond732 = icmp ugt i32 %41, 95, !dbg !65
  %cmp125.not = icmp sgt i32 %41, %shr34
  %or.cond733 = or i1 %or.cond732, %cmp125.not, !dbg !65
  br i1 %or.cond733, label %if.then285, label %for.body130.preheader, !dbg !65

for.body130.preheader:                            ; preds = %for.body116
  store i32 %k.sroa.0.1, ptr addrspace(3) %invariant.gep696, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.5.1, ptr addrspace(3) %k.sroa.5.0.invariant.gep696.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.7.1, ptr addrspace(3) %k.sroa.7.0.invariant.gep696.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.9.1, ptr addrspace(3) %k.sroa.9.0.invariant.gep696.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.11.1, ptr addrspace(3) %gep697.1, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.14.1, ptr addrspace(3) %k.sroa.14.16.gep697.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.16.1, ptr addrspace(3) %k.sroa.16.16.gep697.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.18.1, ptr addrspace(3) %k.sroa.18.16.gep697.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %mul152 = shl nuw nsw i32 %41, 4, !dbg !67
  %add153 = or disjoint i32 %mul152, 15, !dbg !68
  %cmp154 = icmp ult i32 %0, %add153, !dbg !69
  br i1 %cmp154, label %for.cond156.preheader, label %if.end181, !dbg !70

for.cond156.preheader:                            ; preds = %for.body130.preheader
  %add164 = add nuw nsw i32 %mul152, %mul163
  %cmp167.not = icmp ugt i32 %add164, %0, !dbg !71
  %spec.select = select i1 %cmp167.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.0.vec.insert837 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !73
  %cmp167.not.1.not = icmp ult i32 %add164, %0, !dbg !71
  %spec.select.1 = select i1 %cmp167.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !72
  %scores.sroa.0.4.vec.insert844 = insertelement <4 x float> %scores.sroa.0.0.vec.insert837, float %spec.select.1, i64 1, !dbg !73
  %add165.2 = or disjoint i32 %add164, 2, !dbg !74
  %cmp167.not.2 = icmp ugt i32 %add165.2, %0, !dbg !71
  %spec.select.2 = select i1 %cmp167.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.8.vec.insert851 = insertelement <4 x float> %scores.sroa.0.4.vec.insert844, float %spec.select.2, i64 2, !dbg !73
  %add165.3 = or disjoint i32 %add164, 3, !dbg !74
  %cmp167.not.3 = icmp ugt i32 %add165.3, %0, !dbg !71
  %spec.select.3 = select i1 %cmp167.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.12.vec.insert858 = insertelement <4 x float> %scores.sroa.0.8.vec.insert851, float %spec.select.3, i64 3, !dbg !73
  br label %if.end181, !dbg !75

if.end181:                                        ; preds = %for.body130.preheader, %for.cond156.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert858, %for.cond156.preheader ], [ zeroinitializer, %for.body130.preheader ], !dbg !81
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !82
  fence syncscope("warp") acquire, !dbg !83
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr199, align 16, !dbg !84
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.sroa_idx, align 8, !dbg !84
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !dbg !85, !call_argsrelate !86
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %42), !dbg !85, !call_argsrelate !86
  %kb.sroa.0.0.copyload827 = load <4 x half>, ptr addrspace(3) %add.ptr199.1, align 16, !dbg !84
  %kb.sroa.6.0.copyload828 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.1.sroa_idx, align 8, !dbg !84
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload827, <4 x half> %q.sroa.5.16.copyload, <4 x float> %43), !dbg !85, !call_argsrelate !86
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload828, <4 x half> %q.sroa.7.16.copyload, <4 x float> %44), !dbg !85, !call_argsrelate !86
  store i32 %v.sroa.0.1, ptr addrspace(3) %invariant.gep708, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.5.1, ptr addrspace(3) %v.sroa.5.0.invariant.gep708.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.7.1, ptr addrspace(3) %v.sroa.7.0.invariant.gep708.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.9.1, ptr addrspace(3) %v.sroa.9.0.invariant.gep708.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.11.1, ptr addrspace(3) %gep.1, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.14.1, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.16.1, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.18.1, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %45, i64 0, !dbg !88
  %mul256 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul256, float 0x4024CB5EC0000000), !dbg !90
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !94
  %add265 = fadd contract float %partial_sum.sroa.0.0, %47, !dbg !97
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %45, i64 1, !dbg !88
  %mul256.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul256.1, float 0x4024CB5EC0000000), !dbg !90
  %49 = tail call contract noundef float @llvm.exp.f32(float %48), !dbg !94
  %add265.1 = fadd contract float %partial_sum.sroa.6.0, %49, !dbg !97
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %45, i64 2, !dbg !88
  %mul256.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul256.2, float 0x4024CB5EC0000000), !dbg !90
  %51 = tail call contract noundef float @llvm.exp.f32(float %50), !dbg !94
  %add265.2 = fadd contract float %partial_sum.sroa.10.0, %51, !dbg !97
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %45, i64 3, !dbg !88
  %mul256.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul256.3, float 0x4024CB5EC0000000), !dbg !90
  %53 = tail call contract noundef float @llvm.exp.f32(float %52), !dbg !94
  %add265.3 = fadd contract float %partial_sum.sroa.14.0, %53, !dbg !97
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %47), !dbg !98
  %55 = insertelement <4 x i16> poison, i16 %54, i64 0, !dbg !107
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %49), !dbg !98
  %57 = insertelement <4 x i16> %55, i16 %56, i64 1, !dbg !107
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51), !dbg !98
  %59 = insertelement <4 x i16> %57, i16 %58, i64 2, !dbg !107
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53), !dbg !98
  %61 = insertelement <4 x i16> %59, i16 %60, i64 3, !dbg !107
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %61 to <4 x half>, !dbg !107
  fence syncscope("warp") release, !dbg !108
  tail call void @llvm.mxc.barrier.warp(), !dbg !111
  fence syncscope("warp") acquire, !dbg !112
  br label %if.then285, !dbg !113

if.then285:                                       ; preds = %for.body116, %if.end181
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body116 ], [ %add265.3, %if.end181 ], !dbg !81
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body116 ], [ %add265.2, %if.end181 ], !dbg !81
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body116 ], [ %add265.1, %if.end181 ], !dbg !81
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body116 ], [ %add265, %if.end181 ], !dbg !81
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body116 ], [ %prob.sroa.0.6.vec.insert, %if.end181 ]
  %add286 = or disjoint i32 %s_1.0720, 1, !dbg !114
  %arrayidx288 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add286, !dbg !115
  %62 = load i32, ptr addrspace(5) %arrayidx288, align 4, !dbg !115, !tbaa !30
  %or.cond734 = icmp ugt i32 %62, 95, !dbg !116
  %cmp295.not = icmp sgt i32 %62, %shr34
  %or.cond735 = or i1 %or.cond734, %cmp295.not, !dbg !116
  br i1 %or.cond735, label %if.end358, label %for.cond297.preheader, !dbg !116

for.cond297.preheader:                            ; preds = %if.then285
  %mul305 = shl nuw nsw i32 %62, 10
  %add307 = add nuw nsw i32 %mul305, %37
  %63 = zext nneg i32 %add307 to i64, !dbg !117
  %add.ptr314 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %63, !dbg !118
  %64 = load i32, ptr addrspace(4) %add.ptr314, align 4, !dbg !119, !tbaa !30
  %65 = or disjoint i64 %63, 2, !dbg !120
  %add.ptr314.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %65, !dbg !118
  %66 = load i32, ptr addrspace(4) %add.ptr314.1, align 4, !dbg !119, !tbaa !30
  %67 = or disjoint i64 %63, 4, !dbg !120
  %add.ptr314.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %67, !dbg !118
  %68 = load i32, ptr addrspace(4) %add.ptr314.2, align 4, !dbg !119, !tbaa !30
  %69 = or disjoint i64 %63, 6, !dbg !120
  %add.ptr314.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %69, !dbg !118
  %70 = load i32, ptr addrspace(4) %add.ptr314.3, align 4, !dbg !119, !tbaa !30
  %71 = add nuw nsw i64 %63, 512
  %add.ptr314.1780 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %71, !dbg !118
  %72 = load i32, ptr addrspace(4) %add.ptr314.1780, align 4, !dbg !119, !tbaa !30
  %73 = add nuw nsw i64 %63, 514, !dbg !120
  %add.ptr314.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %73, !dbg !118
  %74 = load i32, ptr addrspace(4) %add.ptr314.1.1, align 4, !dbg !119, !tbaa !30
  %75 = add nuw nsw i64 %63, 516, !dbg !120
  %add.ptr314.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %75, !dbg !118
  %76 = load i32, ptr addrspace(4) %add.ptr314.2.1, align 4, !dbg !119, !tbaa !30
  %77 = add nuw nsw i64 %63, 518, !dbg !120
  %add.ptr314.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %77, !dbg !118
  %78 = load i32, ptr addrspace(4) %add.ptr314.3.1, align 4, !dbg !119, !tbaa !30
  %add.ptr344 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %63, !dbg !121
  %79 = load i32, ptr addrspace(4) %add.ptr344, align 4, !dbg !122, !tbaa !30
  %add.ptr344.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %65, !dbg !121
  %80 = load i32, ptr addrspace(4) %add.ptr344.1, align 4, !dbg !122, !tbaa !30
  %add.ptr344.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %67, !dbg !121
  %81 = load i32, ptr addrspace(4) %add.ptr344.2, align 4, !dbg !122, !tbaa !30
  %add.ptr344.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %69, !dbg !121
  %82 = load i32, ptr addrspace(4) %add.ptr344.3, align 4, !dbg !122, !tbaa !30
  %add.ptr344.1792 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %71, !dbg !121
  %83 = load i32, ptr addrspace(4) %add.ptr344.1792, align 4, !dbg !122, !tbaa !30
  %add.ptr344.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %73, !dbg !121
  %84 = load i32, ptr addrspace(4) %add.ptr344.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr344.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %75, !dbg !121
  %85 = load i32, ptr addrspace(4) %add.ptr344.2.1, align 4, !dbg !122, !tbaa !30
  %add.ptr344.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %77, !dbg !121
  %86 = load i32, ptr addrspace(4) %add.ptr344.3.1, align 4, !dbg !122, !tbaa !30
  br label %if.end358, !dbg !123

if.end358:                                        ; preds = %for.cond297.preheader, %if.then285
  %k.sroa.18.2 = phi i32 [ %k.sroa.18.1, %if.then285 ], [ %78, %for.cond297.preheader ]
  %k.sroa.16.2 = phi i32 [ %k.sroa.16.1, %if.then285 ], [ %76, %for.cond297.preheader ]
  %k.sroa.14.2 = phi i32 [ %k.sroa.14.1, %if.then285 ], [ %74, %for.cond297.preheader ]
  %k.sroa.11.2 = phi i32 [ %k.sroa.11.1, %if.then285 ], [ %72, %for.cond297.preheader ]
  %k.sroa.9.2 = phi i32 [ %k.sroa.9.1, %if.then285 ], [ %70, %for.cond297.preheader ]
  %k.sroa.7.2 = phi i32 [ %k.sroa.7.1, %if.then285 ], [ %68, %for.cond297.preheader ]
  %k.sroa.5.2 = phi i32 [ %k.sroa.5.1, %if.then285 ], [ %66, %for.cond297.preheader ]
  %k.sroa.0.2 = phi i32 [ %k.sroa.0.1, %if.then285 ], [ %64, %for.cond297.preheader ]
  %v.sroa.18.2 = phi i32 [ %v.sroa.18.1, %if.then285 ], [ %86, %for.cond297.preheader ]
  %v.sroa.16.2 = phi i32 [ %v.sroa.16.1, %if.then285 ], [ %85, %for.cond297.preheader ]
  %v.sroa.14.2 = phi i32 [ %v.sroa.14.1, %if.then285 ], [ %84, %for.cond297.preheader ]
  %v.sroa.11.2 = phi i32 [ %v.sroa.11.1, %if.then285 ], [ %83, %for.cond297.preheader ]
  %v.sroa.9.2 = phi i32 [ %v.sroa.9.1, %if.then285 ], [ %82, %for.cond297.preheader ]
  %v.sroa.7.2 = phi i32 [ %v.sroa.7.1, %if.then285 ], [ %81, %for.cond297.preheader ]
  %v.sroa.5.2 = phi i32 [ %v.sroa.5.1, %if.then285 ], [ %80, %for.cond297.preheader ]
  %v.sroa.0.2 = phi i32 [ %v.sroa.0.1, %if.then285 ], [ %79, %for.cond297.preheader ]
  br i1 %or.cond733, label %if.end427, label %for.cond371.preheader.preheader, !dbg !123

for.cond371.preheader.preheader:                  ; preds = %if.end358
  %87 = load half, ptr addrspace(3) %gep716, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %87, i64 0, !dbg !124
  %88 = load half, ptr addrspace(3) %gep716.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %88, i64 1, !dbg !124
  %89 = load half, ptr addrspace(3) %gep716.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %89, i64 2, !dbg !124
  %90 = load half, ptr addrspace(3) %gep716.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %90, i64 3, !dbg !124
  %91 = load half, ptr addrspace(3) %gep716.1798, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %91, i64 0, !dbg !124
  %92 = load half, ptr addrspace(3) %gep716.1.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %92, i64 1, !dbg !124
  %93 = load half, ptr addrspace(3) %gep716.2.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %93, i64 2, !dbg !124
  %94 = load half, ptr addrspace(3) %gep716.3.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %94, i64 3, !dbg !124
  %95 = load half, ptr addrspace(3) %gep716.2804, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %95, i64 0, !dbg !124
  %96 = load half, ptr addrspace(3) %gep716.1.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %96, i64 1, !dbg !124
  %97 = load half, ptr addrspace(3) %gep716.2.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %97, i64 2, !dbg !124
  %98 = load half, ptr addrspace(3) %gep716.3.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %98, i64 3, !dbg !124
  %99 = load half, ptr addrspace(3) %gep716.3810, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %99, i64 0, !dbg !124
  %100 = load half, ptr addrspace(3) %gep716.1.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %100, i64 1, !dbg !124
  %101 = load half, ptr addrspace(3) %gep716.2.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %101, i64 2, !dbg !124
  %102 = load half, ptr addrspace(3) %gep716.3.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %102, i64 3, !dbg !124
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0), !dbg !126
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0), !dbg !126
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0), !dbg !126
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0), !dbg !126
  br label %if.end427, !dbg !127

if.end427:                                        ; preds = %for.cond371.preheader.preheader, %if.end358
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end358 ], [ %106, %for.cond371.preheader.preheader ], !dbg !81
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end358 ], [ %105, %for.cond371.preheader.preheader ], !dbg !81
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end358 ], [ %104, %for.cond371.preheader.preheader ], !dbg !81
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end358 ], [ %103, %for.cond371.preheader.preheader ], !dbg !81
  %inc429 = or disjoint i32 %s_1.0720, 1, !dbg !127
  %arrayidx118.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc429, !dbg !64
  %107 = load i32, ptr addrspace(5) %arrayidx118.1, align 4, !dbg !64, !tbaa !30
  %or.cond732.1 = icmp ugt i32 %107, 95, !dbg !65
  %cmp125.not.1 = icmp sgt i32 %107, %shr34
  %or.cond733.1 = or i1 %or.cond732.1, %cmp125.not.1, !dbg !65
  br i1 %or.cond733.1, label %if.end283.1, label %for.body130.preheader.1, !dbg !65

for.body130.preheader.1:                          ; preds = %if.end427
  store i32 %k.sroa.0.2, ptr addrspace(3) %invariant.gep696, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.5.2, ptr addrspace(3) %k.sroa.5.0.invariant.gep696.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.7.2, ptr addrspace(3) %k.sroa.7.0.invariant.gep696.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.9.2, ptr addrspace(3) %k.sroa.9.0.invariant.gep696.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.11.2, ptr addrspace(3) %gep697.1, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.14.2, ptr addrspace(3) %k.sroa.14.16.gep697.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.16.2, ptr addrspace(3) %k.sroa.16.16.gep697.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.18.2, ptr addrspace(3) %k.sroa.18.16.gep697.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %mul152.1 = shl nuw nsw i32 %107, 4, !dbg !67
  %add153.1 = or disjoint i32 %mul152.1, 15, !dbg !68
  %cmp154.1 = icmp ult i32 %0, %add153.1, !dbg !69
  br i1 %cmp154.1, label %for.cond156.preheader.1, label %if.end181.1, !dbg !70

for.cond156.preheader.1:                          ; preds = %for.body130.preheader.1
  %add164.1 = add nuw nsw i32 %mul152.1, %mul163
  %cmp167.not.1 = icmp ugt i32 %add164.1, %0, !dbg !71
  %spec.select.1953 = select i1 %cmp167.not.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.0.vec.insert837.1 = insertelement <4 x float> poison, float %spec.select.1953, i64 0, !dbg !73
  %cmp167.not.1.not.1 = icmp ult i32 %add164.1, %0, !dbg !71
  %spec.select.1.1 = select i1 %cmp167.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !72
  %scores.sroa.0.4.vec.insert844.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert837.1, float %spec.select.1.1, i64 1, !dbg !73
  %add165.2.1 = or disjoint i32 %add164.1, 2, !dbg !74
  %cmp167.not.2.1 = icmp ugt i32 %add165.2.1, %0, !dbg !71
  %spec.select.2.1 = select i1 %cmp167.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.8.vec.insert851.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert844.1, float %spec.select.2.1, i64 2, !dbg !73
  %add165.3.1 = or disjoint i32 %add164.1, 3, !dbg !74
  %cmp167.not.3.1 = icmp ugt i32 %add165.3.1, %0, !dbg !71
  %spec.select.3.1 = select i1 %cmp167.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.12.vec.insert858.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert851.1, float %spec.select.3.1, i64 3, !dbg !73
  br label %if.end181.1, !dbg !75

if.end181.1:                                      ; preds = %for.cond156.preheader.1, %for.body130.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert858.1, %for.cond156.preheader.1 ], [ zeroinitializer, %for.body130.preheader.1 ], !dbg !81
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !82
  fence syncscope("warp") acquire, !dbg !83
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr199, align 16, !dbg !84
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.sroa_idx, align 8, !dbg !84
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !dbg !85, !call_argsrelate !86
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %108), !dbg !85, !call_argsrelate !86
  %kb.sroa.0.0.copyload827.1 = load <4 x half>, ptr addrspace(3) %add.ptr199.1, align 16, !dbg !84
  %kb.sroa.6.0.copyload828.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.1.sroa_idx, align 8, !dbg !84
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload827.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %109), !dbg !85, !call_argsrelate !86
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload828.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %110), !dbg !85, !call_argsrelate !86
  store i32 %v.sroa.0.2, ptr addrspace(3) %invariant.gep708, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.5.2, ptr addrspace(3) %v.sroa.5.0.invariant.gep708.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.7.2, ptr addrspace(3) %v.sroa.7.0.invariant.gep708.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.9.2, ptr addrspace(3) %v.sroa.9.0.invariant.gep708.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.11.2, ptr addrspace(3) %gep.1, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.14.2, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.16.2, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.18.2, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %111, i64 0, !dbg !88
  %mul256.1954 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul256.1954, float 0x4024CB5EC0000000), !dbg !90
  %113 = tail call contract noundef float @llvm.exp.f32(float %112), !dbg !94
  %add265.1955 = fadd contract float %partial_sum.sroa.0.1, %113, !dbg !97
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %111, i64 1, !dbg !88
  %mul256.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul256.1.1, float 0x4024CB5EC0000000), !dbg !90
  %115 = tail call contract noundef float @llvm.exp.f32(float %114), !dbg !94
  %add265.1.1 = fadd contract float %partial_sum.sroa.6.1, %115, !dbg !97
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %111, i64 2, !dbg !88
  %mul256.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul256.2.1, float 0x4024CB5EC0000000), !dbg !90
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !94
  %add265.2.1 = fadd contract float %partial_sum.sroa.10.1, %117, !dbg !97
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %111, i64 3, !dbg !88
  %mul256.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul256.3.1, float 0x4024CB5EC0000000), !dbg !90
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !94
  %add265.3.1 = fadd contract float %partial_sum.sroa.14.1, %119, !dbg !97
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113), !dbg !98
  %121 = insertelement <4 x i16> poison, i16 %120, i64 0, !dbg !107
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115), !dbg !98
  %123 = insertelement <4 x i16> %121, i16 %122, i64 1, !dbg !107
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !98
  %125 = insertelement <4 x i16> %123, i16 %124, i64 2, !dbg !107
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !98
  %127 = insertelement <4 x i16> %125, i16 %126, i64 3, !dbg !107
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %127 to <4 x half>, !dbg !107
  fence syncscope("warp") release, !dbg !108
  tail call void @llvm.mxc.barrier.warp(), !dbg !111
  fence syncscope("warp") acquire, !dbg !112
  br label %if.end283.1, !dbg !113

if.end283.1:                                      ; preds = %if.end181.1, %if.end427
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end427 ], [ %add265.3.1, %if.end181.1 ], !dbg !81
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end427 ], [ %add265.2.1, %if.end181.1 ], !dbg !81
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end427 ], [ %add265.1.1, %if.end181.1 ], !dbg !81
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end427 ], [ %add265.1955, %if.end181.1 ], !dbg !81
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end427 ], [ %prob.sroa.0.6.vec.insert.1, %if.end181.1 ]
  %cmp284.not.1 = icmp eq i32 %s_1.0720, 2, !dbg !128
  br i1 %cmp284.not.1, label %if.end358.1, label %if.then285.1, !dbg !129

if.then285.1:                                     ; preds = %if.end283.1
  %add286.1 = add nuw nsw i32 %s_1.0720, 2, !dbg !114
  %arrayidx288.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add286.1, !dbg !115
  %128 = load i32, ptr addrspace(5) %arrayidx288.1, align 4, !dbg !115, !tbaa !30
  %or.cond734.1 = icmp ugt i32 %128, 95, !dbg !116
  %cmp295.not.1 = icmp sgt i32 %128, %shr34
  %or.cond735.1 = or i1 %or.cond734.1, %cmp295.not.1, !dbg !116
  br i1 %or.cond735.1, label %if.end358.1, label %for.cond297.preheader.1, !dbg !116

for.cond297.preheader.1:                          ; preds = %if.then285.1
  %mul305.1 = shl nuw nsw i32 %128, 10
  %add307.1 = add nuw nsw i32 %mul305.1, %37
  %129 = zext nneg i32 %add307.1 to i64, !dbg !117
  %add.ptr314.1956 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %129, !dbg !118
  %130 = load i32, ptr addrspace(4) %add.ptr314.1956, align 4, !dbg !119, !tbaa !30
  %131 = or disjoint i64 %129, 2, !dbg !120
  %add.ptr314.1.1957 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %131, !dbg !118
  %132 = load i32, ptr addrspace(4) %add.ptr314.1.1957, align 4, !dbg !119, !tbaa !30
  %133 = or disjoint i64 %129, 4, !dbg !120
  %add.ptr314.2.1958 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %133, !dbg !118
  %134 = load i32, ptr addrspace(4) %add.ptr314.2.1958, align 4, !dbg !119, !tbaa !30
  %135 = or disjoint i64 %129, 6, !dbg !120
  %add.ptr314.3.1959 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %135, !dbg !118
  %136 = load i32, ptr addrspace(4) %add.ptr314.3.1959, align 4, !dbg !119, !tbaa !30
  %137 = add nuw nsw i64 %129, 512
  %add.ptr314.1780.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %137, !dbg !118
  %138 = load i32, ptr addrspace(4) %add.ptr314.1780.1, align 4, !dbg !119, !tbaa !30
  %139 = add nuw nsw i64 %129, 514, !dbg !120
  %add.ptr314.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %139, !dbg !118
  %140 = load i32, ptr addrspace(4) %add.ptr314.1.1.1, align 4, !dbg !119, !tbaa !30
  %141 = add nuw nsw i64 %129, 516, !dbg !120
  %add.ptr314.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %141, !dbg !118
  %142 = load i32, ptr addrspace(4) %add.ptr314.2.1.1, align 4, !dbg !119, !tbaa !30
  %143 = add nuw nsw i64 %129, 518, !dbg !120
  %add.ptr314.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %143, !dbg !118
  %144 = load i32, ptr addrspace(4) %add.ptr314.3.1.1, align 4, !dbg !119, !tbaa !30
  %add.ptr344.1960 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %129, !dbg !121
  %145 = load i32, ptr addrspace(4) %add.ptr344.1960, align 4, !dbg !122, !tbaa !30
  %add.ptr344.1.1961 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %131, !dbg !121
  %146 = load i32, ptr addrspace(4) %add.ptr344.1.1961, align 4, !dbg !122, !tbaa !30
  %add.ptr344.2.1962 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %133, !dbg !121
  %147 = load i32, ptr addrspace(4) %add.ptr344.2.1962, align 4, !dbg !122, !tbaa !30
  %add.ptr344.3.1963 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %135, !dbg !121
  %148 = load i32, ptr addrspace(4) %add.ptr344.3.1963, align 4, !dbg !122, !tbaa !30
  %add.ptr344.1792.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %137, !dbg !121
  %149 = load i32, ptr addrspace(4) %add.ptr344.1792.1, align 4, !dbg !122, !tbaa !30
  %add.ptr344.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %139, !dbg !121
  %150 = load i32, ptr addrspace(4) %add.ptr344.1.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr344.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %141, !dbg !121
  %151 = load i32, ptr addrspace(4) %add.ptr344.2.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr344.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %143, !dbg !121
  %152 = load i32, ptr addrspace(4) %add.ptr344.3.1.1, align 4, !dbg !122, !tbaa !30
  br label %if.end358.1, !dbg !123

if.end358.1:                                      ; preds = %for.cond297.preheader.1, %if.then285.1, %if.end283.1
  %k.sroa.18.2.1 = phi i32 [ %k.sroa.18.2, %if.end283.1 ], [ %k.sroa.18.2, %if.then285.1 ], [ %144, %for.cond297.preheader.1 ]
  %k.sroa.16.2.1 = phi i32 [ %k.sroa.16.2, %if.end283.1 ], [ %k.sroa.16.2, %if.then285.1 ], [ %142, %for.cond297.preheader.1 ]
  %k.sroa.14.2.1 = phi i32 [ %k.sroa.14.2, %if.end283.1 ], [ %k.sroa.14.2, %if.then285.1 ], [ %140, %for.cond297.preheader.1 ]
  %k.sroa.11.2.1 = phi i32 [ %k.sroa.11.2, %if.end283.1 ], [ %k.sroa.11.2, %if.then285.1 ], [ %138, %for.cond297.preheader.1 ]
  %k.sroa.9.2.1 = phi i32 [ %k.sroa.9.2, %if.end283.1 ], [ %k.sroa.9.2, %if.then285.1 ], [ %136, %for.cond297.preheader.1 ]
  %k.sroa.7.2.1 = phi i32 [ %k.sroa.7.2, %if.end283.1 ], [ %k.sroa.7.2, %if.then285.1 ], [ %134, %for.cond297.preheader.1 ]
  %k.sroa.5.2.1 = phi i32 [ %k.sroa.5.2, %if.end283.1 ], [ %k.sroa.5.2, %if.then285.1 ], [ %132, %for.cond297.preheader.1 ]
  %k.sroa.0.2.1 = phi i32 [ %k.sroa.0.2, %if.end283.1 ], [ %k.sroa.0.2, %if.then285.1 ], [ %130, %for.cond297.preheader.1 ]
  %v.sroa.18.2.1 = phi i32 [ %v.sroa.18.2, %if.end283.1 ], [ %v.sroa.18.2, %if.then285.1 ], [ %152, %for.cond297.preheader.1 ]
  %v.sroa.16.2.1 = phi i32 [ %v.sroa.16.2, %if.end283.1 ], [ %v.sroa.16.2, %if.then285.1 ], [ %151, %for.cond297.preheader.1 ]
  %v.sroa.14.2.1 = phi i32 [ %v.sroa.14.2, %if.end283.1 ], [ %v.sroa.14.2, %if.then285.1 ], [ %150, %for.cond297.preheader.1 ]
  %v.sroa.11.2.1 = phi i32 [ %v.sroa.11.2, %if.end283.1 ], [ %v.sroa.11.2, %if.then285.1 ], [ %149, %for.cond297.preheader.1 ]
  %v.sroa.9.2.1 = phi i32 [ %v.sroa.9.2, %if.end283.1 ], [ %v.sroa.9.2, %if.then285.1 ], [ %148, %for.cond297.preheader.1 ]
  %v.sroa.7.2.1 = phi i32 [ %v.sroa.7.2, %if.end283.1 ], [ %v.sroa.7.2, %if.then285.1 ], [ %147, %for.cond297.preheader.1 ]
  %v.sroa.5.2.1 = phi i32 [ %v.sroa.5.2, %if.end283.1 ], [ %v.sroa.5.2, %if.then285.1 ], [ %146, %for.cond297.preheader.1 ]
  %v.sroa.0.2.1 = phi i32 [ %v.sroa.0.2, %if.end283.1 ], [ %v.sroa.0.2, %if.then285.1 ], [ %145, %for.cond297.preheader.1 ]
  br i1 %or.cond733.1, label %if.end427.1, label %for.cond371.preheader.preheader.1, !dbg !123

for.cond371.preheader.preheader.1:                ; preds = %if.end358.1
  %153 = load half, ptr addrspace(3) %gep716, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %153, i64 0, !dbg !124
  %154 = load half, ptr addrspace(3) %gep716.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %154, i64 1, !dbg !124
  %155 = load half, ptr addrspace(3) %gep716.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %155, i64 2, !dbg !124
  %156 = load half, ptr addrspace(3) %gep716.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %156, i64 3, !dbg !124
  %157 = load half, ptr addrspace(3) %gep716.1798, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %157, i64 0, !dbg !124
  %158 = load half, ptr addrspace(3) %gep716.1.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %158, i64 1, !dbg !124
  %159 = load half, ptr addrspace(3) %gep716.2.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %159, i64 2, !dbg !124
  %160 = load half, ptr addrspace(3) %gep716.3.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %160, i64 3, !dbg !124
  %161 = load half, ptr addrspace(3) %gep716.2804, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %161, i64 0, !dbg !124
  %162 = load half, ptr addrspace(3) %gep716.1.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %162, i64 1, !dbg !124
  %163 = load half, ptr addrspace(3) %gep716.2.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %163, i64 2, !dbg !124
  %164 = load half, ptr addrspace(3) %gep716.3.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %164, i64 3, !dbg !124
  %165 = load half, ptr addrspace(3) %gep716.3810, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %165, i64 0, !dbg !124
  %166 = load half, ptr addrspace(3) %gep716.1.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %166, i64 1, !dbg !124
  %167 = load half, ptr addrspace(3) %gep716.2.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %167, i64 2, !dbg !124
  %168 = load half, ptr addrspace(3) %gep716.3.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %168, i64 3, !dbg !124
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1), !dbg !126
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1), !dbg !126
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1), !dbg !126
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1), !dbg !126
  br label %if.end427.1, !dbg !127

if.end427.1:                                      ; preds = %for.cond371.preheader.preheader.1, %if.end358.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end358.1 ], [ %172, %for.cond371.preheader.preheader.1 ], !dbg !81
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end358.1 ], [ %171, %for.cond371.preheader.preheader.1 ], !dbg !81
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end358.1 ], [ %170, %for.cond371.preheader.preheader.1 ], !dbg !81
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end358.1 ], [ %169, %for.cond371.preheader.preheader.1 ], !dbg !81
  %inc429.1 = add nuw nsw i32 %s_1.0720, 2, !dbg !127
  %exitcond.not.1 = icmp eq i32 %inc429.1, 4, !dbg !130
  br i1 %exitcond.not.1, label %for.body435.preheader, label %for.body116, !dbg !61, !llvm.loop !131

for.body435.preheader:                            ; preds = %if.end427.1
  %add439 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00, !dbg !134
  %add439.1 = fadd contract float %add439, %partial_sum.sroa.6.1.1, !dbg !134
  %add439.2 = fadd contract float %add439.1, %partial_sum.sroa.10.1.1, !dbg !134
  %add439.3 = fadd contract float %add439.2, %partial_sum.sroa.14.1.1, !dbg !134
  %173 = bitcast float %add439.3 to i32, !dbg !135
  %174 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13, !dbg !146
  %175 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %174) #13, !dbg !151
  %xor.i.i = xor i32 %175, 32, !dbg !152
  %176 = and i32 %175, -64, !dbg !153
  %and.i.i = add nsw i32 %176, 64, !dbg !153
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !154
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %175, !dbg !155
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !156
  %177 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %173), !dbg !157
  %178 = bitcast i32 %177 to float, !dbg !158
  %add.i = fadd contract float %add439.3, %178, !dbg !159
  %179 = bitcast float %add.i to i32, !dbg !162
  %180 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13, !dbg !169
  %181 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %180) #13, !dbg !172
  %xor.i.i683 = xor i32 %181, 16, !dbg !173
  %182 = and i32 %181, -64, !dbg !174
  %and.i.i684 = add nsw i32 %182, 64, !dbg !174
  %cmp.not.i.i685 = icmp slt i32 %xor.i.i683, %and.i.i684, !dbg !175
  %cond.i.i686 = select i1 %cmp.not.i.i685, i32 %xor.i.i683, i32 %181, !dbg !176
  %shl.i.i687 = shl i32 %cond.i.i686, 2, !dbg !177
  %183 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i687, i32 %179), !dbg !178
  %184 = bitcast i32 %183 to float, !dbg !179
  %add.i.i = fadd contract float %add.i, %184, !dbg !180
  %cmp448 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !182
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !183
  %condval_1.0 = select i1 %cmp448, float %div, float 0.000000e+00, !dbg !183
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0, !dbg !184
  %mul461 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract, !dbg !185
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1, !dbg !184
  %mul461.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract, !dbg !185
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2, !dbg !184
  %mul461.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract, !dbg !185
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3, !dbg !184
  %mul461.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract, !dbg !185
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0, !dbg !184
  %mul461.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract, !dbg !185
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1, !dbg !184
  %mul461.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract, !dbg !185
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2, !dbg !184
  %mul461.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract, !dbg !185
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3, !dbg !184
  %mul461.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract, !dbg !185
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0, !dbg !184
  %mul461.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract, !dbg !185
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1, !dbg !184
  %mul461.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract, !dbg !185
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2, !dbg !184
  %mul461.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract, !dbg !185
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3, !dbg !184
  %mul461.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract, !dbg !185
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0, !dbg !184
  %mul461.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract, !dbg !185
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1, !dbg !184
  %mul461.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract, !dbg !185
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2, !dbg !184
  %mul461.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract, !dbg !185
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3, !dbg !184
  %mul461.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract, !dbg !185
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461), !dbg !186
  %result.sroa.0.0.insert.ext = zext i16 %185 to i64, !dbg !190
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.1), !dbg !186
  %result.sroa.0.2.insert.ext = zext i16 %186 to i64, !dbg !190
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !190
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !190
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.2), !dbg !186
  %result.sroa.0.4.insert.ext = zext i16 %187 to i64, !dbg !190
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !190
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !190
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.3), !dbg !186
  %result.sroa.0.6.insert.ext = zext i16 %188 to i64, !dbg !190
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !190
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !190
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.4), !dbg !186
  %result.sroa.7.8.insert.ext = zext i16 %189 to i64, !dbg !190
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.5), !dbg !186
  %result.sroa.7.10.insert.ext = zext i16 %190 to i64, !dbg !190
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !190
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !190
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.6), !dbg !186
  %result.sroa.7.12.insert.ext = zext i16 %191 to i64, !dbg !190
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !190
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !190
  %192 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.7), !dbg !186
  %result.sroa.7.14.insert.ext = zext i16 %192 to i64, !dbg !190
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !190
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !190
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.8), !dbg !186
  %result.sroa.12.16.insert.ext = zext i16 %193 to i64, !dbg !190
  %194 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.9), !dbg !186
  %result.sroa.12.18.insert.ext = zext i16 %194 to i64, !dbg !190
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16, !dbg !190
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext, !dbg !190
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.10), !dbg !186
  %result.sroa.12.20.insert.ext = zext i16 %195 to i64, !dbg !190
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32, !dbg !190
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift, !dbg !190
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.11), !dbg !186
  %result.sroa.12.22.insert.ext = zext i16 %196 to i64, !dbg !190
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48, !dbg !190
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift, !dbg !190
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.12), !dbg !186
  %result.sroa.17.24.insert.ext = zext i16 %197 to i64, !dbg !190
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.13), !dbg !186
  %result.sroa.17.26.insert.ext = zext i16 %198 to i64, !dbg !190
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16, !dbg !190
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext, !dbg !190
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.14), !dbg !186
  %result.sroa.17.28.insert.ext = zext i16 %199 to i64, !dbg !190
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32, !dbg !190
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift, !dbg !190
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.15), !dbg !186
  %result.sroa.17.30.insert.ext = zext i16 %200 to i64, !dbg !190
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48, !dbg !190
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift, !dbg !190
  fence syncscope("warp") release, !dbg !191
  tail call void @llvm.mxc.barrier.warp(), !dbg !194
  fence syncscope("warp") acquire, !dbg !195
  %shr503 = lshr i32 %1, 5
  %xor507 = xor i32 %shr503, %and194, !dbg !196
  %mul508 = shl nuw nsw i32 %xor507, 3, !dbg !197
  %add509 = add nuw nsw i32 %mul508, %mul7, !dbg !198
  %add514 = or disjoint i32 %add509, %mul388, !dbg !199
  %add.ptr516 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514, !dbg !200
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr516, align 8, !dbg !201
  %add504.1 = add nuw nsw i32 %shr503, 2, !dbg !202
  %xor507.1 = xor i32 %add504.1, %and194, !dbg !196
  %mul508.1 = shl nuw nsw i32 %xor507.1, 3, !dbg !197
  %add509.1 = add nuw nsw i32 %mul508.1, %mul7, !dbg !198
  %add514.1 = or disjoint i32 %add509.1, %mul388, !dbg !199
  %add.ptr516.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514.1, !dbg !200
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr516.1, align 8, !dbg !201
  %add504.2 = add nuw nsw i32 %shr503, 4, !dbg !202
  %xor507.2 = xor i32 %add504.2, %and194, !dbg !196
  %mul508.2 = shl nuw nsw i32 %xor507.2, 3, !dbg !197
  %add509.2 = add nuw nsw i32 %mul508.2, %mul7, !dbg !198
  %add514.2 = or disjoint i32 %add509.2, %mul388, !dbg !199
  %add.ptr516.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514.2, !dbg !200
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr516.2, align 8, !dbg !201
  %add504.3 = add nuw nsw i32 %shr503, 6, !dbg !202
  %xor507.3 = xor i32 %add504.3, %and194, !dbg !196
  %mul508.3 = shl nuw nsw i32 %xor507.3, 3, !dbg !197
  %add509.3 = add nuw nsw i32 %mul508.3, %mul7, !dbg !198
  %add514.3 = or disjoint i32 %add509.3, %mul388, !dbg !199
  %add.ptr516.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514.3, !dbg !200
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr516.3, align 8, !dbg !201
  fence syncscope("warp") release, !dbg !203
  tail call void @llvm.mxc.barrier.warp(), !dbg !206
  fence syncscope("warp") acquire, !dbg !207
  %add541 = add nuw nsw i32 %37, %mul
  %201 = zext nneg i32 %add541 to i64, !dbg !208
  %add.ptr546 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %201, !dbg !209
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr546, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep696, i64 16, i1 false), !dbg !210, !tbaa.struct !211, !call_argsrelate !212
  %gep730.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1024, !dbg !213
  %202 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %201, !dbg !209
  %add.ptr546.1 = getelementptr inbounds i8, ptr addrspace(1) %202, i64 1024, !dbg !209
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr546.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep730.1, i64 16, i1 false), !dbg !210, !tbaa.struct !211, !call_argsrelate !212
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !dbg !214, !call_argsrelate !43
  ret void, !dbg !214
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #6

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #9

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #6

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
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
attributes #13 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpsuto8p37/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpsuto8p37/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 13, column: 3, scope: !40)
!43 = !{i32 -1, i32 0}
!44 = !{i32 0, i32 1024}
!45 = !DILocation(line: 26, column: 3, scope: !40)
!46 = !DILocation(line: 27, column: 42, scope: !40)
!47 = !DILocation(line: 27, column: 28, scope: !40)
!48 = !DILocation(line: 30, column: 3, scope: !40)
!49 = !DILocation(line: 31, column: 17, scope: !40)
!50 = !DILocation(line: 31, column: 15, scope: !40)
!51 = !DILocation(line: 31, column: 50, scope: !40)
!52 = !DILocation(line: 31, column: 5, scope: !40)
!53 = !DILocation(line: 34, column: 27, scope: !40)
!54 = !DILocation(line: 36, column: 5, scope: !40)
!55 = !DILocation(line: 39, column: 71, scope: !40)
!56 = !DILocation(line: 39, column: 50, scope: !40)
!57 = !DILocation(line: 39, column: 141, scope: !40)
!58 = !DILocation(line: 46, column: 75, scope: !40)
!59 = !DILocation(line: 46, column: 54, scope: !40)
!60 = !DILocation(line: 51, column: 3, scope: !40)
!61 = !DILocation(line: 58, column: 3, scope: !40)
!62 = !DILocation(line: 53, column: 33, scope: !40)
!63 = !DILocation(line: 56, column: 31, scope: !40)
!64 = !DILocation(line: 59, column: 17, scope: !40)
!65 = !DILocation(line: 60, column: 23, scope: !40)
!66 = !DILocation(line: 63, column: 161, scope: !40)
!67 = !DILocation(line: 65, column: 39, scope: !40)
!68 = !DILocation(line: 65, column: 45, scope: !40)
!69 = !DILocation(line: 65, column: 29, scope: !40)
!70 = !DILocation(line: 65, column: 11, scope: !40)
!71 = !DILocation(line: 69, column: 73, scope: !40)
!72 = !DILocation(line: 69, column: 15, scope: !40)
!73 = !DILocation(line: 74, column: 23, scope: !40)
!74 = !DILocation(line: 69, column: 66, scope: !40)
!75 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !78)
!76 = distinct !DISubprogram(name: "__barrier_warp", scope: !77, file: !77, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!78 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !80)
!79 = distinct !DISubprogram(name: "__syncwarp", scope: !77, file: !77, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!80 = distinct !DILocation(line: 80, column: 7, scope: !40)
!81 = !DILocation(line: 0, scope: !40)
!82 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !78)
!83 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !78)
!84 = !DILocation(line: 82, column: 27, scope: !40)
!85 = !DILocation(line: 85, column: 37, scope: !40)
!86 = !{i32 -1, i32 3, i32 -1}
!87 = !DILocation(line: 93, column: 170, scope: !40)
!88 = !DILocation(line: 97, column: 33, scope: !40)
!89 = !DILocation(line: 97, column: 45, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "min", scope: !92, file: !92, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!93 = distinct !DILocation(line: 97, column: 28, scope: !40)
!94 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "expf", scope: !92, file: !92, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 97, column: 23, scope: !40)
!97 = !DILocation(line: 98, column: 46, scope: !40)
!98 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !100, file: !100, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!101 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "__float2half", scope: !103, file: !103, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!104 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__half", scope: !103, file: !103, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 102, column: 23, scope: !40)
!107 = !DILocation(line: 102, column: 20, scope: !40)
!108 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !109)
!109 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !110)
!110 = distinct !DILocation(line: 104, column: 7, scope: !40)
!111 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !109)
!112 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !109)
!113 = !DILocation(line: 105, column: 5, scope: !40)
!114 = !DILocation(line: 107, column: 36, scope: !40)
!115 = !DILocation(line: 107, column: 24, scope: !40)
!116 = !DILocation(line: 108, column: 30, scope: !40)
!117 = !DILocation(line: 110, column: 9, scope: !40)
!118 = !DILocation(line: 113, column: 79, scope: !40)
!119 = !DILocation(line: 113, column: 58, scope: !40)
!120 = !DILocation(line: 113, column: 150, scope: !40)
!121 = !DILocation(line: 120, column: 79, scope: !40)
!122 = !DILocation(line: 120, column: 58, scope: !40)
!123 = !DILocation(line: 125, column: 23, scope: !40)
!124 = !DILocation(line: 128, column: 36, scope: !40)
!125 = !{!26, !26, i64 0}
!126 = !DILocation(line: 133, column: 36, scope: !40)
!127 = !DILocation(line: 58, column: 30, scope: !40)
!128 = !DILocation(line: 106, column: 13, scope: !40)
!129 = !DILocation(line: 106, column: 9, scope: !40)
!130 = !DILocation(line: 58, column: 25, scope: !40)
!131 = distinct !{!131, !61, !132, !32, !133}
!132 = !DILocation(line: 139, column: 3, scope: !40)
!133 = !{!"llvm.loop.unroll.disable"}
!134 = !DILocation(line: 143, column: 26, scope: !40)
!135 = !DILocation(line: 1018, column: 9, scope: !136, inlinedAt: !137)
!136 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!137 = distinct !DILocation(line: 396, column: 10, scope: !138, inlinedAt: !140)
!138 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !139, file: !139, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!140 = distinct !DILocation(line: 129, column: 24, scope: !141, inlinedAt: !143)
!141 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !142, file: !142, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!142 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!143 = distinct !DILocation(line: 101, column: 14, scope: !144, inlinedAt: !145)
!144 = distinct !DISubprogram(name: "run<float>", scope: !142, file: !142, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = distinct !DILocation(line: 145, column: 14, scope: !40)
!146 = !DILocation(line: 171, column: 37, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "__lane_id", scope: !77, file: !77, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = distinct !DILocation(line: 990, column: 14, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 1019, column: 11, scope: !136, inlinedAt: !137)
!151 = !DILocation(line: 171, column: 10, scope: !147, inlinedAt: !148)
!152 = !DILocation(line: 991, column: 20, scope: !149, inlinedAt: !150)
!153 = !DILocation(line: 992, column: 36, scope: !149, inlinedAt: !150)
!154 = !DILocation(line: 992, column: 17, scope: !149, inlinedAt: !150)
!155 = !DILocation(line: 992, column: 11, scope: !149, inlinedAt: !150)
!156 = !DILocation(line: 993, column: 43, scope: !149, inlinedAt: !150)
!157 = !DILocation(line: 993, column: 10, scope: !149, inlinedAt: !150)
!158 = !DILocation(line: 1020, column: 14, scope: !136, inlinedAt: !137)
!159 = !DILocation(line: 25, column: 14, scope: !160, inlinedAt: !161)
!160 = distinct !DISubprogram(name: "operator()<float>", scope: !142, file: !142, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!161 = distinct !DILocation(line: 129, column: 11, scope: !141, inlinedAt: !143)
!162 = !DILocation(line: 1018, column: 9, scope: !136, inlinedAt: !163)
!163 = distinct !DILocation(line: 396, column: 10, scope: !138, inlinedAt: !164)
!164 = distinct !DILocation(line: 129, column: 24, scope: !165, inlinedAt: !166)
!165 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !142, file: !142, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!166 = distinct !DILocation(line: 101, column: 14, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "run<float>", scope: !142, file: !142, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!168 = distinct !DILocation(line: 134, column: 14, scope: !141, inlinedAt: !143)
!169 = !DILocation(line: 171, column: 37, scope: !147, inlinedAt: !170)
!170 = distinct !DILocation(line: 990, column: 14, scope: !149, inlinedAt: !171)
!171 = distinct !DILocation(line: 1019, column: 11, scope: !136, inlinedAt: !163)
!172 = !DILocation(line: 171, column: 10, scope: !147, inlinedAt: !170)
!173 = !DILocation(line: 991, column: 20, scope: !149, inlinedAt: !171)
!174 = !DILocation(line: 992, column: 36, scope: !149, inlinedAt: !171)
!175 = !DILocation(line: 992, column: 17, scope: !149, inlinedAt: !171)
!176 = !DILocation(line: 992, column: 11, scope: !149, inlinedAt: !171)
!177 = !DILocation(line: 993, column: 43, scope: !149, inlinedAt: !171)
!178 = !DILocation(line: 993, column: 10, scope: !149, inlinedAt: !171)
!179 = !DILocation(line: 1020, column: 14, scope: !136, inlinedAt: !163)
!180 = !DILocation(line: 25, column: 14, scope: !160, inlinedAt: !181)
!181 = distinct !DILocation(line: 129, column: 11, scope: !165, inlinedAt: !166)
!182 = !DILocation(line: 147, column: 32, scope: !40)
!183 = !DILocation(line: 147, column: 7, scope: !40)
!184 = !DILocation(line: 155, column: 17, scope: !40)
!185 = !DILocation(line: 155, column: 26, scope: !40)
!186 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !187)
!187 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !188)
!188 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !189)
!189 = distinct !DILocation(line: 161, column: 41, scope: !40)
!190 = !DILocation(line: 161, column: 38, scope: !40)
!191 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !192)
!192 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !193)
!193 = distinct !DILocation(line: 164, column: 3, scope: !40)
!194 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !192)
!195 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !192)
!196 = !DILocation(line: 167, column: 121, scope: !40)
!197 = !DILocation(line: 167, column: 149, scope: !40)
!198 = !DILocation(line: 167, column: 77, scope: !40)
!199 = !DILocation(line: 167, column: 155, scope: !40)
!200 = !DILocation(line: 167, column: 40, scope: !40)
!201 = !DILocation(line: 167, column: 198, scope: !40)
!202 = !DILocation(line: 167, column: 92, scope: !40)
!203 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !204)
!204 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !205)
!205 = distinct !DILocation(line: 169, column: 3, scope: !40)
!206 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !204)
!207 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !204)
!208 = !DILocation(line: 171, column: 3, scope: !40)
!209 = !DILocation(line: 172, column: 22, scope: !40)
!210 = !DILocation(line: 172, column: 97, scope: !40)
!211 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!212 = !{i32 2, i32 -1, i32 -1, i32 -1}
!213 = !DILocation(line: 172, column: 134, scope: !40)
!214 = !DILocation(line: 174, column: 1, scope: !40)
