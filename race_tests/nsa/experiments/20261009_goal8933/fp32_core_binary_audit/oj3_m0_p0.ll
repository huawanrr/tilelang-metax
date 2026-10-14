; ModuleID = 'experiments/20261009_goal8933/fp32_core_binary_audit/oj3_m0_p0.bc'
source_filename = "/tmp/tmpxtw04t7k/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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

; Function Attrs: convergent mustprogress norecurse nounwind willreturn
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
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
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 128, !dbg !44
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16, !dbg !45
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 136, !dbg !45
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8, !dbg !45
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 192, !dbg !44
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16, !dbg !45
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 200, !dbg !45
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8, !dbg !45
  %idxprom = zext nneg i32 %0 to i64, !dbg !46
  %arrayidx17 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !46
  %7 = load i32, ptr addrspace(1) %arrayidx17, align 4, !dbg !46, !tbaa !30
  %cmp32 = icmp ugt i32 %7, 15
  %shr35 = lshr i32 %0, 4
  %cmp36.not = icmp ugt i32 %7, %shr35
  %or.cond495 = or i1 %cmp32, %cmp36.not, !dbg !47
  br i1 %or.cond495, label %if.end334, label %if.then, !dbg !47

if.then:                                          ; preds = %entry
  %mul48 = shl nuw nsw i32 %7, 11
  %mul52 = shl nuw nsw i32 %1, 3
  %add50 = add nuw nsw i32 %mul48, %mul52
  %8 = zext nneg i32 %add50 to i64, !dbg !48
  %add.ptr57 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8, !dbg !49
  %9 = load i32, ptr addrspace(4) %add.ptr57, align 4, !dbg !50, !tbaa !30
  %10 = or disjoint i64 %8, 2, !dbg !51
  %add.ptr57.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !49
  %11 = load i32, ptr addrspace(4) %add.ptr57.1, align 4, !dbg !50, !tbaa !30
  %12 = or disjoint i64 %8, 4, !dbg !51
  %add.ptr57.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !49
  %13 = load i32, ptr addrspace(4) %add.ptr57.2, align 4, !dbg !50, !tbaa !30
  %14 = or disjoint i64 %8, 6, !dbg !51
  %add.ptr57.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !49
  %15 = load i32, ptr addrspace(4) %add.ptr57.3, align 4, !dbg !50, !tbaa !30
  %16 = add nuw nsw i64 %8, 512
  %add.ptr57.1510 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !49
  %17 = load i32, ptr addrspace(4) %add.ptr57.1510, align 4, !dbg !50, !tbaa !30
  %18 = add nuw nsw i64 %8, 514, !dbg !51
  %add.ptr57.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !49
  %19 = load i32, ptr addrspace(4) %add.ptr57.1.1, align 4, !dbg !50, !tbaa !30
  %20 = add nuw nsw i64 %8, 516, !dbg !51
  %add.ptr57.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !49
  %21 = load i32, ptr addrspace(4) %add.ptr57.2.1, align 4, !dbg !50, !tbaa !30
  %22 = add nuw nsw i64 %8, 518, !dbg !51
  %add.ptr57.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !49
  %23 = load i32, ptr addrspace(4) %add.ptr57.3.1, align 4, !dbg !50, !tbaa !30
  %24 = add nuw nsw i64 %8, 1024
  %add.ptr57.2512 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !49
  %25 = load i32, ptr addrspace(4) %add.ptr57.2512, align 4, !dbg !50, !tbaa !30
  %26 = add nuw nsw i64 %8, 1026, !dbg !51
  %add.ptr57.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26, !dbg !49
  %27 = load i32, ptr addrspace(4) %add.ptr57.1.2, align 4, !dbg !50, !tbaa !30
  %28 = add nuw nsw i64 %8, 1028, !dbg !51
  %add.ptr57.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28, !dbg !49
  %29 = load i32, ptr addrspace(4) %add.ptr57.2.2, align 4, !dbg !50, !tbaa !30
  %30 = add nuw nsw i64 %8, 1030, !dbg !51
  %add.ptr57.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %30, !dbg !49
  %31 = load i32, ptr addrspace(4) %add.ptr57.3.2, align 4, !dbg !50, !tbaa !30
  %32 = add nuw nsw i64 %8, 1536
  %add.ptr57.3514 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %32, !dbg !49
  %33 = load i32, ptr addrspace(4) %add.ptr57.3514, align 4, !dbg !50, !tbaa !30
  %34 = add nuw nsw i64 %8, 1538, !dbg !51
  %add.ptr57.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %34, !dbg !49
  %35 = load i32, ptr addrspace(4) %add.ptr57.1.3, align 4, !dbg !50, !tbaa !30
  %36 = add nuw nsw i64 %8, 1540, !dbg !51
  %add.ptr57.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %36, !dbg !49
  %37 = load i32, ptr addrspace(4) %add.ptr57.2.3, align 4, !dbg !50, !tbaa !30
  %38 = add nuw nsw i64 %8, 1542, !dbg !51
  %add.ptr57.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %38, !dbg !49
  %39 = load i32, ptr addrspace(4) %add.ptr57.3.3, align 4, !dbg !50, !tbaa !30
  %add.ptr87 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8, !dbg !52
  %40 = load i32, ptr addrspace(4) %add.ptr87, align 4, !dbg !53, !tbaa !30
  %add.ptr87.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !52
  %41 = load i32, ptr addrspace(4) %add.ptr87.1, align 4, !dbg !53, !tbaa !30
  %add.ptr87.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !52
  %42 = load i32, ptr addrspace(4) %add.ptr87.2, align 4, !dbg !53, !tbaa !30
  %add.ptr87.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !52
  %43 = load i32, ptr addrspace(4) %add.ptr87.3, align 4, !dbg !53, !tbaa !30
  %add.ptr87.1526 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !52
  %44 = load i32, ptr addrspace(4) %add.ptr87.1526, align 4, !dbg !53, !tbaa !30
  %add.ptr87.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !52
  %45 = load i32, ptr addrspace(4) %add.ptr87.1.1, align 4, !dbg !53, !tbaa !30
  %add.ptr87.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !52
  %46 = load i32, ptr addrspace(4) %add.ptr87.2.1, align 4, !dbg !53, !tbaa !30
  %add.ptr87.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !52
  %47 = load i32, ptr addrspace(4) %add.ptr87.3.1, align 4, !dbg !53, !tbaa !30
  %add.ptr87.2528 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !52
  %48 = load i32, ptr addrspace(4) %add.ptr87.2528, align 4, !dbg !53, !tbaa !30
  %add.ptr87.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26, !dbg !52
  %49 = load i32, ptr addrspace(4) %add.ptr87.1.2, align 4, !dbg !53, !tbaa !30
  %add.ptr87.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28, !dbg !52
  %50 = load i32, ptr addrspace(4) %add.ptr87.2.2, align 4, !dbg !53, !tbaa !30
  %add.ptr87.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %30, !dbg !52
  %51 = load i32, ptr addrspace(4) %add.ptr87.3.2, align 4, !dbg !53, !tbaa !30
  %add.ptr87.3530 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %32, !dbg !52
  %52 = load i32, ptr addrspace(4) %add.ptr87.3530, align 4, !dbg !53, !tbaa !30
  %add.ptr87.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %34, !dbg !52
  %53 = load i32, ptr addrspace(4) %add.ptr87.1.3, align 4, !dbg !53, !tbaa !30
  %add.ptr87.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %36, !dbg !52
  %54 = load i32, ptr addrspace(4) %add.ptr87.2.3, align 4, !dbg !53, !tbaa !30
  %add.ptr87.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %38, !dbg !52
  %55 = load i32, ptr addrspace(4) %add.ptr87.3.3, align 4, !dbg !53, !tbaa !30
  %mul111 = and i32 %mul52, 8064
  %and114 = and i32 %1, 15
  %shr117 = lshr i32 %1, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul111, !dbg !54
  %xor = xor i32 %shr117, %and114, !dbg !55
  %add.ptr122.idx = shl nuw nsw i32 %xor, 4, !dbg !56
  %add.ptr122 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr122.idx, !dbg !56
  store i32 %9, ptr addrspace(3) %add.ptr122, align 16, !dbg !57, !tbaa !30
  %K_reg.sroa.4.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122, i32 4, !dbg !57
  store i32 %11, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr122.sroa_idx, align 4, !dbg !57, !tbaa !30
  %K_reg.sroa.5.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122, i32 8, !dbg !57
  store i32 %13, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr122.sroa_idx, align 8, !dbg !57, !tbaa !30
  %K_reg.sroa.6.0.add.ptr122.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122, i32 12, !dbg !57
  store i32 %15, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr122.sroa_idx, align 4, !dbg !57, !tbaa !30
  %add118.1 = add nuw nsw i32 %shr117, 4, !dbg !58
  %xor.1 = xor i32 %add118.1, %and114, !dbg !55
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !56
  %add.ptr122.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !56
  %add.ptr122.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr122.idx.1, !dbg !56
  store i32 %17, ptr addrspace(3) %add.ptr122.1, align 16, !dbg !57, !tbaa !30
  %K_reg.sroa.9.16.add.ptr122.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.1, i32 4, !dbg !57
  store i32 %19, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr122.1.sroa_idx, align 4, !dbg !57, !tbaa !30
  %K_reg.sroa.10.16.add.ptr122.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.1, i32 8, !dbg !57
  store i32 %21, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr122.1.sroa_idx, align 8, !dbg !57, !tbaa !30
  %K_reg.sroa.11.16.add.ptr122.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.1, i32 12, !dbg !57
  store i32 %23, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr122.1.sroa_idx, align 4, !dbg !57, !tbaa !30
  %add118.2 = add nuw nsw i32 %shr117, 8, !dbg !58
  %xor.2 = xor i32 %add118.2, %and114, !dbg !55
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048, !dbg !56
  %add.ptr122.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !56
  %add.ptr122.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr122.idx.2, !dbg !56
  store i32 %25, ptr addrspace(3) %add.ptr122.2, align 16, !dbg !57, !tbaa !30
  %K_reg.sroa.14.32.add.ptr122.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.2, i32 4, !dbg !57
  store i32 %27, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr122.2.sroa_idx, align 4, !dbg !57, !tbaa !30
  %K_reg.sroa.15.32.add.ptr122.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.2, i32 8, !dbg !57
  store i32 %29, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr122.2.sroa_idx, align 8, !dbg !57, !tbaa !30
  %K_reg.sroa.16.32.add.ptr122.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.2, i32 12, !dbg !57
  store i32 %31, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr122.2.sroa_idx, align 4, !dbg !57, !tbaa !30
  %add118.3 = add nuw nsw i32 %shr117, 12, !dbg !58
  %xor.3 = xor i32 %add118.3, %and114, !dbg !55
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072, !dbg !56
  %add.ptr122.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !56
  %add.ptr122.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr122.idx.3, !dbg !56
  store i32 %33, ptr addrspace(3) %add.ptr122.3, align 16, !dbg !57, !tbaa !30
  %K_reg.sroa.19.48.add.ptr122.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.3, i32 4, !dbg !57
  store i32 %35, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr122.3.sroa_idx, align 4, !dbg !57, !tbaa !30
  %K_reg.sroa.20.48.add.ptr122.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.3, i32 8, !dbg !57
  store i32 %37, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr122.3.sroa_idx, align 8, !dbg !57, !tbaa !30
  %K_reg.sroa.21.48.add.ptr122.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr122.3, i32 12, !dbg !57
  store i32 %39, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr122.3.sroa_idx, align 4, !dbg !57, !tbaa !30
  %mul37 = shl nuw nsw i32 %7, 4, !dbg !59
  %add128 = or disjoint i32 %mul37, 15, !dbg !60
  %cmp129 = icmp ult i32 %0, %add128, !dbg !61
  br i1 %cmp129, label %for.cond131.preheader, label %if.end155, !dbg !62

for.cond131.preheader:                            ; preds = %if.then
  %56 = lshr i32 %1, 2
  %mul137 = and i32 %56, 252
  %add139 = add nuw nsw i32 %mul37, %mul137
  %cmp142.not = icmp ugt i32 %add139, %0, !dbg !63
  %spec.select = select i1 %cmp142.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.0.vec.insert579 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !65
  %cmp142.not.1.not = icmp ult i32 %add139, %0, !dbg !63
  %spec.select.1 = select i1 %cmp142.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !64
  %acc_s.sroa.0.4.vec.insert592 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert579, float %spec.select.1, i64 1, !dbg !65
  %add140.2 = or disjoint i32 %add139, 2, !dbg !66
  %cmp142.not.2 = icmp ugt i32 %add140.2, %0, !dbg !63
  %spec.select.2 = select i1 %cmp142.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.8.vec.insert605 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert592, float %spec.select.2, i64 2, !dbg !65
  %add140.3 = or disjoint i32 %add139, 3, !dbg !66
  %cmp142.not.3 = icmp ugt i32 %add140.3, %0, !dbg !63
  %spec.select.3 = select i1 %cmp142.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.12.vec.insert618 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert605, float %spec.select.3, i64 3, !dbg !65
  br label %if.end155, !dbg !67

if.end155:                                        ; preds = %if.then, %for.cond131.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert618, %for.cond131.preheader ], [ zeroinitializer, %if.then ], !dbg !73
  fence syncscope("warp") release, !dbg !67
  tail call void @llvm.mxc.barrier.warp(), !dbg !74
  fence syncscope("warp") acquire, !dbg !75
  %57 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul7
  %add.ptr173 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx, !dbg !76
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr173.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173, i32 8, !dbg !77
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.sroa_idx, align 8, !dbg !77
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !78, !call_argsrelate !79
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %58), !dbg !78, !call_argsrelate !79
  %add.ptr173.1 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx.1, !dbg !76
  %kb.sroa.0.0.copyload567 = load <4 x half>, ptr addrspace(3) %add.ptr173.1, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr173.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.1, i32 8, !dbg !77
  %kb.sroa.10.0.copyload570 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.1.sroa_idx, align 8, !dbg !77
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload567, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %59), !dbg !78, !call_argsrelate !79
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload570, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %60), !dbg !78, !call_argsrelate !79
  %add.ptr173.2 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx.2, !dbg !76
  %kb.sroa.0.0.copyload568 = load <4 x half>, ptr addrspace(3) %add.ptr173.2, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr173.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.2, i32 8, !dbg !77
  %kb.sroa.10.0.copyload571 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.2.sroa_idx, align 8, !dbg !77
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload568, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %61), !dbg !78, !call_argsrelate !79
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload571, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %62), !dbg !78, !call_argsrelate !79
  %add.ptr173.3 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr122.idx.3, !dbg !76
  %kb.sroa.0.0.copyload569 = load <4 x half>, ptr addrspace(3) %add.ptr173.3, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr173.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.3, i32 8, !dbg !77
  %kb.sroa.10.0.copyload572 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr173.3.sroa_idx, align 8, !dbg !77
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload569, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %63), !dbg !78, !call_argsrelate !79
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload572, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %64), !dbg !78, !call_argsrelate !79
  fence syncscope("warp") release, !dbg !80
  tail call void @llvm.mxc.barrier.warp(), !dbg !83
  fence syncscope("warp") acquire, !dbg !84
  %add.ptr211.idx = shl nuw nsw i32 %1, 4
  %invariant.gep481 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr211.idx, !dbg !85
  store i32 %40, ptr addrspace(3) %invariant.gep481, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep481.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 4, !dbg !86
  store i32 %41, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep481.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep481.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 8, !dbg !86
  store i32 %42, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep481.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep481.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 12, !dbg !86
  store i32 %43, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep481.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep482.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1024, !dbg !87
  store i32 %44, ptr addrspace(3) %gep482.1, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.9.16.gep482.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1028, !dbg !86
  store i32 %45, ptr addrspace(3) %V_reg.sroa.9.16.gep482.1.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.10.16.gep482.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1032, !dbg !86
  store i32 %46, ptr addrspace(3) %V_reg.sroa.10.16.gep482.1.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.11.16.gep482.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 1036, !dbg !86
  store i32 %47, ptr addrspace(3) %V_reg.sroa.11.16.gep482.1.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep482.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2048, !dbg !87
  store i32 %48, ptr addrspace(3) %gep482.2, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.14.32.gep482.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2052, !dbg !86
  store i32 %49, ptr addrspace(3) %V_reg.sroa.14.32.gep482.2.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.15.32.gep482.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2056, !dbg !86
  store i32 %50, ptr addrspace(3) %V_reg.sroa.15.32.gep482.2.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.16.32.gep482.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 2060, !dbg !86
  store i32 %51, ptr addrspace(3) %V_reg.sroa.16.32.gep482.2.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep482.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3072, !dbg !87
  store i32 %52, ptr addrspace(3) %gep482.3, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.19.48.gep482.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3076, !dbg !86
  store i32 %53, ptr addrspace(3) %V_reg.sroa.19.48.gep482.3.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.20.48.gep482.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3080, !dbg !86
  store i32 %54, ptr addrspace(3) %V_reg.sroa.20.48.gep482.3.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.21.48.gep482.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep481, i32 3084, !dbg !86
  store i32 %55, ptr addrspace(3) %V_reg.sroa.21.48.gep482.3.sroa_idx, align 4, !dbg !86, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %65, i64 0, !dbg !88
  %mul221 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul221, float 0x4024CB5EC0000000), !dbg !90
  %67 = tail call contract noundef float @llvm.exp.f32(float %66), !dbg !94
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %65, i64 1, !dbg !88
  %mul221.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul221.1, float 0x4024CB5EC0000000), !dbg !90
  %69 = tail call contract noundef float @llvm.exp.f32(float %68), !dbg !94
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %65, i64 2, !dbg !88
  %mul221.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul221.2, float 0x4024CB5EC0000000), !dbg !90
  %71 = tail call contract noundef float @llvm.exp.f32(float %70), !dbg !94
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %65, i64 3, !dbg !88
  %mul221.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul221.3, float 0x4024CB5EC0000000), !dbg !90
  %73 = tail call contract noundef float @llvm.exp.f32(float %72), !dbg !94
  %add237.1 = fadd contract float %67, %69, !dbg !97
  %add237.2 = fadd contract float %add237.1, %71, !dbg !97
  %add237.3 = fadd contract float %add237.2, %73, !dbg !97
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add237.3, <4 x float> zeroinitializer), !dbg !98
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %74, i64 0, !dbg !99
  %cmp255 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !100
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !101
  %condval_1.0 = select i1 %cmp255, float %div, float 0.000000e+00, !dbg !101
  %mul268 = fmul contract float %condval_1.0, %67, !dbg !102
  %mul268.1 = fmul contract float %condval_1.0, %69, !dbg !102
  %mul268.2 = fmul contract float %condval_1.0, %71, !dbg !102
  %mul268.3 = fmul contract float %condval_1.0, %73, !dbg !102
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268), !dbg !103
  %76 = insertelement <4 x i16> poison, i16 %75, i64 0, !dbg !112
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268.1), !dbg !103
  %78 = insertelement <4 x i16> %76, i16 %77, i64 1, !dbg !112
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268.2), !dbg !103
  %80 = insertelement <4 x i16> %78, i16 %79, i64 2, !dbg !112
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul268.3), !dbg !103
  %82 = insertelement <4 x i16> %80, i16 %81, i64 3, !dbg !112
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %82 to <4 x half>, !dbg !112
  fence syncscope("warp") release, !dbg !113
  tail call void @llvm.mxc.barrier.warp(), !dbg !116
  fence syncscope("warp") acquire, !dbg !117
  %83 = shl nuw nsw i32 %1, 5
  %mul296 = and i32 %83, 32256
  %add303 = or disjoint i32 %mul296, %and114, !dbg !118
  %arrayidx305 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303, !dbg !119
  %84 = load half, ptr addrspace(3) %arrayidx305, align 2, !dbg !120, !tbaa !121
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %84, i64 0, !dbg !120
  %add298.1 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1 = or disjoint i32 %add298.1, 128, !dbg !118
  %arrayidx305.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1, !dbg !119
  %85 = load half, ptr addrspace(3) %arrayidx305.1, align 2, !dbg !120, !tbaa !121
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %85, i64 1, !dbg !120
  %add298.2 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2 = or disjoint i32 %add298.2, 256, !dbg !118
  %arrayidx305.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2, !dbg !119
  %86 = load half, ptr addrspace(3) %arrayidx305.2, align 2, !dbg !120, !tbaa !121
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %86, i64 2, !dbg !120
  %add298.3 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.3 = or disjoint i32 %add298.3, 384, !dbg !118
  %arrayidx305.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3, !dbg !119
  %87 = load half, ptr addrspace(3) %arrayidx305.3, align 2, !dbg !120, !tbaa !121
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %87, i64 3, !dbg !120
  %add300.1534 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1535 = or disjoint i32 %add300.1534, 16, !dbg !118
  %arrayidx305.1536 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1535, !dbg !119
  %88 = load half, ptr addrspace(3) %arrayidx305.1536, align 2, !dbg !120, !tbaa !121
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %88, i64 0, !dbg !120
  %add300.1.1 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1.1 = or disjoint i32 %add300.1.1, 144, !dbg !118
  %arrayidx305.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.1, !dbg !119
  %89 = load half, ptr addrspace(3) %arrayidx305.1.1, align 2, !dbg !120, !tbaa !121
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %89, i64 1, !dbg !120
  %add300.2.1 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2.1 = or disjoint i32 %add300.2.1, 272, !dbg !118
  %arrayidx305.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.1, !dbg !119
  %90 = load half, ptr addrspace(3) %arrayidx305.2.1, align 2, !dbg !120, !tbaa !121
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %90, i64 2, !dbg !120
  %add300.3.1 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.3.1 = or disjoint i32 %add300.3.1, 400, !dbg !118
  %arrayidx305.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.1, !dbg !119
  %91 = load half, ptr addrspace(3) %arrayidx305.3.1, align 2, !dbg !120, !tbaa !121
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %91, i64 3, !dbg !120
  %add300.2538 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2539 = or disjoint i32 %add300.2538, 32, !dbg !118
  %arrayidx305.2540 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2539, !dbg !119
  %92 = load half, ptr addrspace(3) %arrayidx305.2540, align 2, !dbg !120, !tbaa !121
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %92, i64 0, !dbg !120
  %add300.1.2 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1.2 = or disjoint i32 %add300.1.2, 160, !dbg !118
  %arrayidx305.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.2, !dbg !119
  %93 = load half, ptr addrspace(3) %arrayidx305.1.2, align 2, !dbg !120, !tbaa !121
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %93, i64 1, !dbg !120
  %add300.2.2 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2.2 = or disjoint i32 %add300.2.2, 288, !dbg !118
  %arrayidx305.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.2, !dbg !119
  %94 = load half, ptr addrspace(3) %arrayidx305.2.2, align 2, !dbg !120, !tbaa !121
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %94, i64 2, !dbg !120
  %add300.3.2 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.3.2 = or disjoint i32 %add300.3.2, 416, !dbg !118
  %arrayidx305.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.2, !dbg !119
  %95 = load half, ptr addrspace(3) %arrayidx305.3.2, align 2, !dbg !120, !tbaa !121
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %95, i64 3, !dbg !120
  %add300.3542 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.3543 = or disjoint i32 %add300.3542, 48, !dbg !118
  %arrayidx305.3544 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3543, !dbg !119
  %96 = load half, ptr addrspace(3) %arrayidx305.3544, align 2, !dbg !120, !tbaa !121
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %96, i64 0, !dbg !120
  %add300.1.3 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1.3 = or disjoint i32 %add300.1.3, 176, !dbg !118
  %arrayidx305.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.3, !dbg !119
  %97 = load half, ptr addrspace(3) %arrayidx305.1.3, align 2, !dbg !120, !tbaa !121
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %97, i64 1, !dbg !120
  %add300.2.3 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2.3 = or disjoint i32 %add300.2.3, 304, !dbg !118
  %arrayidx305.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.3, !dbg !119
  %98 = load half, ptr addrspace(3) %arrayidx305.2.3, align 2, !dbg !120, !tbaa !121
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %98, i64 2, !dbg !120
  %add300.3.3 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.3.3 = or disjoint i32 %add300.3.3, 432, !dbg !118
  %arrayidx305.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.3, !dbg !119
  %99 = load half, ptr addrspace(3) %arrayidx305.3.3, align 2, !dbg !120, !tbaa !121
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %99, i64 3, !dbg !120
  %add300.4 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.4 = or disjoint i32 %add300.4, 64, !dbg !118
  %arrayidx305.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.4, !dbg !119
  %100 = load half, ptr addrspace(3) %arrayidx305.4, align 2, !dbg !120, !tbaa !121
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %100, i64 0, !dbg !120
  %add300.1.4 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1.4 = or disjoint i32 %add300.1.4, 192, !dbg !118
  %arrayidx305.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.4, !dbg !119
  %101 = load half, ptr addrspace(3) %arrayidx305.1.4, align 2, !dbg !120, !tbaa !121
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %101, i64 1, !dbg !120
  %add300.2.4 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2.4 = or disjoint i32 %add300.2.4, 320, !dbg !118
  %arrayidx305.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.4, !dbg !119
  %102 = load half, ptr addrspace(3) %arrayidx305.2.4, align 2, !dbg !120, !tbaa !121
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %102, i64 2, !dbg !120
  %add300.3.4 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.3.4 = or disjoint i32 %add300.3.4, 448, !dbg !118
  %arrayidx305.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.4, !dbg !119
  %103 = load half, ptr addrspace(3) %arrayidx305.3.4, align 2, !dbg !120, !tbaa !121
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %103, i64 3, !dbg !120
  %add300.5 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.5 = or disjoint i32 %add300.5, 80, !dbg !118
  %arrayidx305.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.5, !dbg !119
  %104 = load half, ptr addrspace(3) %arrayidx305.5, align 2, !dbg !120, !tbaa !121
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %104, i64 0, !dbg !120
  %add300.1.5 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1.5 = or disjoint i32 %add300.1.5, 208, !dbg !118
  %arrayidx305.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.5, !dbg !119
  %105 = load half, ptr addrspace(3) %arrayidx305.1.5, align 2, !dbg !120, !tbaa !121
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %105, i64 1, !dbg !120
  %add300.2.5 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2.5 = or disjoint i32 %add300.2.5, 336, !dbg !118
  %arrayidx305.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.5, !dbg !119
  %106 = load half, ptr addrspace(3) %arrayidx305.2.5, align 2, !dbg !120, !tbaa !121
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %106, i64 2, !dbg !120
  %add300.3.5 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.3.5 = or disjoint i32 %add300.3.5, 464, !dbg !118
  %arrayidx305.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.5, !dbg !119
  %107 = load half, ptr addrspace(3) %arrayidx305.3.5, align 2, !dbg !120, !tbaa !121
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %107, i64 3, !dbg !120
  %add300.6 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.6 = or disjoint i32 %add300.6, 96, !dbg !118
  %arrayidx305.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.6, !dbg !119
  %108 = load half, ptr addrspace(3) %arrayidx305.6, align 2, !dbg !120, !tbaa !121
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %108, i64 0, !dbg !120
  %add300.1.6 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1.6 = or disjoint i32 %add300.1.6, 224, !dbg !118
  %arrayidx305.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.6, !dbg !119
  %109 = load half, ptr addrspace(3) %arrayidx305.1.6, align 2, !dbg !120, !tbaa !121
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %109, i64 1, !dbg !120
  %add300.2.6 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2.6 = or disjoint i32 %add300.2.6, 352, !dbg !118
  %arrayidx305.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.6, !dbg !119
  %110 = load half, ptr addrspace(3) %arrayidx305.2.6, align 2, !dbg !120, !tbaa !121
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %110, i64 2, !dbg !120
  %add300.3.6 = or disjoint i32 %83, %and114, !dbg !118
  %add303.3.6 = or i32 %add300.3.6, 480, !dbg !118
  %arrayidx305.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.6, !dbg !119
  %111 = load half, ptr addrspace(3) %arrayidx305.3.6, align 2, !dbg !120, !tbaa !121
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %111, i64 3, !dbg !120
  %add300.7 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.7 = or disjoint i32 %add300.7, 112, !dbg !118
  %arrayidx305.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.7, !dbg !119
  %112 = load half, ptr addrspace(3) %arrayidx305.7, align 2, !dbg !120, !tbaa !121
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %112, i64 0, !dbg !120
  %add300.1.7 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.1.7 = or disjoint i32 %add300.1.7, 240, !dbg !118
  %arrayidx305.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.1.7, !dbg !119
  %113 = load half, ptr addrspace(3) %arrayidx305.1.7, align 2, !dbg !120, !tbaa !121
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %113, i64 1, !dbg !120
  %add300.2.7 = or disjoint i32 %mul296, %and114, !dbg !118
  %add303.2.7 = or disjoint i32 %add300.2.7, 368, !dbg !118
  %arrayidx305.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.2.7, !dbg !119
  %114 = load half, ptr addrspace(3) %arrayidx305.2.7, align 2, !dbg !120, !tbaa !121
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %114, i64 2, !dbg !120
  %add300.3.7 = or disjoint i32 %83, %and114, !dbg !118
  %add303.3.7 = or i32 %add300.3.7, 496, !dbg !118
  %arrayidx305.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add303.3.7, !dbg !119
  %115 = load half, ptr addrspace(3) %arrayidx305.3.7, align 2, !dbg !120, !tbaa !121
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %115, i64 3, !dbg !120
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  br label %if.end334, !dbg !123

if.end334:                                        ; preds = %if.end155, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %116, %if.end155 ], !dbg !73
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %117, %if.end155 ], !dbg !73
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %118, %if.end155 ], !dbg !73
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %119, %if.end155 ], !dbg !73
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %120, %if.end155 ], !dbg !73
  %acc_o.sroa.52.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %121, %if.end155 ], !dbg !73
  %acc_o.sroa.62.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %122, %if.end155 ], !dbg !73
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %123, %if.end155 ], !dbg !73
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !124
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !125
  %O_cast.sroa.0.0.insert.ext = zext i16 %124 to i64, !dbg !129
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !124
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !125
  %O_cast.sroa.0.2.insert.ext = zext i16 %125 to i64, !dbg !129
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !129
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !129
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !124
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !125
  %O_cast.sroa.0.4.insert.ext = zext i16 %126 to i64, !dbg !129
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !129
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !129
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !124
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !125
  %O_cast.sroa.0.6.insert.ext = zext i16 %127 to i64, !dbg !129
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !129
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !129
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !124
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.16.vec.extract), !dbg !125
  %O_cast.sroa.7.8.insert.ext = zext i16 %128 to i64, !dbg !129
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !124
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.20.vec.extract), !dbg !125
  %O_cast.sroa.7.10.insert.ext = zext i16 %129 to i64, !dbg !129
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !129
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !129
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !124
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.24.vec.extract), !dbg !125
  %O_cast.sroa.7.12.insert.ext = zext i16 %130 to i64, !dbg !129
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !129
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !129
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !124
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.28.vec.extract), !dbg !125
  %O_cast.sroa.7.14.insert.ext = zext i16 %131 to i64, !dbg !129
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !129
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !129
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !124
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.32.vec.extract), !dbg !125
  %O_cast.sroa.12.16.insert.ext = zext i16 %132 to i64, !dbg !129
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !124
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.36.vec.extract), !dbg !125
  %O_cast.sroa.12.18.insert.ext = zext i16 %133 to i64, !dbg !129
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !129
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !129
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !124
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.40.vec.extract), !dbg !125
  %O_cast.sroa.12.20.insert.ext = zext i16 %134 to i64, !dbg !129
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !129
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !129
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !124
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.44.vec.extract), !dbg !125
  %O_cast.sroa.12.22.insert.ext = zext i16 %135 to i64, !dbg !129
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !129
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !129
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !124
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.48.vec.extract), !dbg !125
  %O_cast.sroa.17.24.insert.ext = zext i16 %136 to i64, !dbg !129
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !124
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.52.vec.extract), !dbg !125
  %O_cast.sroa.17.26.insert.ext = zext i16 %137 to i64, !dbg !129
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !129
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !129
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !124
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.56.vec.extract), !dbg !125
  %O_cast.sroa.17.28.insert.ext = zext i16 %138 to i64, !dbg !129
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !129
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !129
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !124
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.60.vec.extract), !dbg !125
  %O_cast.sroa.17.30.insert.ext = zext i16 %139 to i64, !dbg !129
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !129
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !129
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0, !dbg !124
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.64.vec.extract), !dbg !125
  %O_cast.sroa.22.32.insert.ext = zext i16 %140 to i64, !dbg !129
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1, !dbg !124
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.68.vec.extract), !dbg !125
  %O_cast.sroa.22.34.insert.ext = zext i16 %141 to i64, !dbg !129
  %O_cast.sroa.22.34.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.34.insert.ext, 16, !dbg !129
  %O_cast.sroa.22.34.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.shift, %O_cast.sroa.22.32.insert.ext, !dbg !129
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2, !dbg !124
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.72.vec.extract), !dbg !125
  %O_cast.sroa.22.36.insert.ext = zext i16 %142 to i64, !dbg !129
  %O_cast.sroa.22.36.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.36.insert.ext, 32, !dbg !129
  %O_cast.sroa.22.36.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.insert, %O_cast.sroa.22.36.insert.shift, !dbg !129
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3, !dbg !124
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.76.vec.extract), !dbg !125
  %O_cast.sroa.22.38.insert.ext = zext i16 %143 to i64, !dbg !129
  %O_cast.sroa.22.38.insert.shift = shl nuw i64 %O_cast.sroa.22.38.insert.ext, 48, !dbg !129
  %O_cast.sroa.22.38.insert.insert = or disjoint i64 %O_cast.sroa.22.36.insert.insert, %O_cast.sroa.22.38.insert.shift, !dbg !129
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0, !dbg !124
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.80.vec.extract), !dbg !125
  %O_cast.sroa.27.40.insert.ext = zext i16 %144 to i64, !dbg !129
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1, !dbg !124
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.84.vec.extract), !dbg !125
  %O_cast.sroa.27.42.insert.ext = zext i16 %145 to i64, !dbg !129
  %O_cast.sroa.27.42.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.42.insert.ext, 16, !dbg !129
  %O_cast.sroa.27.42.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.shift, %O_cast.sroa.27.40.insert.ext, !dbg !129
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2, !dbg !124
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.88.vec.extract), !dbg !125
  %O_cast.sroa.27.44.insert.ext = zext i16 %146 to i64, !dbg !129
  %O_cast.sroa.27.44.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.44.insert.ext, 32, !dbg !129
  %O_cast.sroa.27.44.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.insert, %O_cast.sroa.27.44.insert.shift, !dbg !129
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3, !dbg !124
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.92.vec.extract), !dbg !125
  %O_cast.sroa.27.46.insert.ext = zext i16 %147 to i64, !dbg !129
  %O_cast.sroa.27.46.insert.shift = shl nuw i64 %O_cast.sroa.27.46.insert.ext, 48, !dbg !129
  %O_cast.sroa.27.46.insert.insert = or disjoint i64 %O_cast.sroa.27.44.insert.insert, %O_cast.sroa.27.46.insert.shift, !dbg !129
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0, !dbg !124
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.96.vec.extract), !dbg !125
  %O_cast.sroa.32.48.insert.ext = zext i16 %148 to i64, !dbg !129
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1, !dbg !124
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.100.vec.extract), !dbg !125
  %O_cast.sroa.32.50.insert.ext = zext i16 %149 to i64, !dbg !129
  %O_cast.sroa.32.50.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.50.insert.ext, 16, !dbg !129
  %O_cast.sroa.32.50.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.shift, %O_cast.sroa.32.48.insert.ext, !dbg !129
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2, !dbg !124
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.104.vec.extract), !dbg !125
  %O_cast.sroa.32.52.insert.ext = zext i16 %150 to i64, !dbg !129
  %O_cast.sroa.32.52.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.52.insert.ext, 32, !dbg !129
  %O_cast.sroa.32.52.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.insert, %O_cast.sroa.32.52.insert.shift, !dbg !129
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3, !dbg !124
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.108.vec.extract), !dbg !125
  %O_cast.sroa.32.54.insert.ext = zext i16 %151 to i64, !dbg !129
  %O_cast.sroa.32.54.insert.shift = shl nuw i64 %O_cast.sroa.32.54.insert.ext, 48, !dbg !129
  %O_cast.sroa.32.54.insert.insert = or disjoint i64 %O_cast.sroa.32.52.insert.insert, %O_cast.sroa.32.54.insert.shift, !dbg !129
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0, !dbg !124
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.112.vec.extract), !dbg !125
  %O_cast.sroa.37.56.insert.ext = zext i16 %152 to i64, !dbg !129
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1, !dbg !124
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.116.vec.extract), !dbg !125
  %O_cast.sroa.37.58.insert.ext = zext i16 %153 to i64, !dbg !129
  %O_cast.sroa.37.58.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.58.insert.ext, 16, !dbg !129
  %O_cast.sroa.37.58.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.shift, %O_cast.sroa.37.56.insert.ext, !dbg !129
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2, !dbg !124
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.120.vec.extract), !dbg !125
  %O_cast.sroa.37.60.insert.ext = zext i16 %154 to i64, !dbg !129
  %O_cast.sroa.37.60.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.60.insert.ext, 32, !dbg !129
  %O_cast.sroa.37.60.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.insert, %O_cast.sroa.37.60.insert.shift, !dbg !129
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3, !dbg !124
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.124.vec.extract), !dbg !125
  %O_cast.sroa.37.62.insert.ext = zext i16 %155 to i64, !dbg !129
  %O_cast.sroa.37.62.insert.shift = shl nuw i64 %O_cast.sroa.37.62.insert.ext, 48, !dbg !129
  %O_cast.sroa.37.62.insert.insert = or disjoint i64 %O_cast.sroa.37.60.insert.insert, %O_cast.sroa.37.62.insert.shift, !dbg !129
  %156 = lshr i32 %1, 2
  %mul376 = and i32 %156, 252
  %add373 = add nuw nsw i32 %add, %mul376
  %157 = zext nneg i32 %add373 to i64, !dbg !130
  %add.ptr379 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr379, align 8, !dbg !132
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  %add.ptr379.1 = getelementptr inbounds i8, ptr addrspace(1) %158, i64 32, !dbg !131
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr379.1, align 8, !dbg !132
  %159 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  %add.ptr379.2 = getelementptr inbounds i8, ptr addrspace(1) %159, i64 64, !dbg !131
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr379.2, align 8, !dbg !132
  %160 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  %add.ptr379.3 = getelementptr inbounds i8, ptr addrspace(1) %160, i64 96, !dbg !131
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr379.3, align 8, !dbg !132
  %161 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  %add.ptr379.4 = getelementptr inbounds i8, ptr addrspace(1) %161, i64 128, !dbg !131
  store i64 %O_cast.sroa.22.38.insert.insert, ptr addrspace(1) %add.ptr379.4, align 8, !dbg !132
  %162 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  %add.ptr379.5 = getelementptr inbounds i8, ptr addrspace(1) %162, i64 160, !dbg !131
  store i64 %O_cast.sroa.27.46.insert.insert, ptr addrspace(1) %add.ptr379.5, align 8, !dbg !132
  %163 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  %add.ptr379.6 = getelementptr inbounds i8, ptr addrspace(1) %163, i64 192, !dbg !131
  store i64 %O_cast.sroa.32.54.insert.insert, ptr addrspace(1) %add.ptr379.6, align 8, !dbg !132
  %164 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %157, !dbg !131
  %add.ptr379.7 = getelementptr inbounds i8, ptr addrspace(1) %164, i64 224, !dbg !131
  store i64 %O_cast.sroa.37.62.insert.insert, ptr addrspace(1) %add.ptr379.7, align 8, !dbg !132
  ret void, !dbg !133
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpxtw04t7k/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpxtw04t7k/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 27, column: 3, scope: !40)
!44 = !DILocation(line: 28, column: 46, scope: !40)
!45 = !DILocation(line: 28, column: 32, scope: !40)
!46 = !DILocation(line: 30, column: 25, scope: !40)
!47 = !DILocation(line: 36, column: 31, scope: !40)
!48 = !DILocation(line: 39, column: 5, scope: !40)
!49 = !DILocation(line: 42, column: 79, scope: !40)
!50 = !DILocation(line: 42, column: 58, scope: !40)
!51 = !DILocation(line: 42, column: 155, scope: !40)
!52 = !DILocation(line: 49, column: 79, scope: !40)
!53 = !DILocation(line: 49, column: 58, scope: !40)
!54 = !DILocation(line: 53, column: 5, scope: !40)
!55 = !DILocation(line: 54, column: 109, scope: !40)
!56 = !DILocation(line: 54, column: 26, scope: !40)
!57 = !DILocation(line: 54, column: 159, scope: !40)
!58 = !DILocation(line: 54, column: 122, scope: !40)
!59 = !DILocation(line: 37, column: 43, scope: !40)
!60 = !DILocation(line: 56, column: 49, scope: !40)
!61 = !DILocation(line: 56, column: 27, scope: !40)
!62 = !DILocation(line: 56, column: 9, scope: !40)
!63 = !DILocation(line: 60, column: 77, scope: !40)
!64 = !DILocation(line: 60, column: 13, scope: !40)
!65 = !DILocation(line: 65, column: 20, scope: !40)
!66 = !DILocation(line: 60, column: 70, scope: !40)
!67 = !DILocation(line: 68, column: 3, scope: !68, inlinedAt: !70)
!68 = distinct !DISubprogram(name: "__barrier_warp", scope: !69, file: !69, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!69 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!70 = distinct !DILocation(line: 192, column: 3, scope: !71, inlinedAt: !72)
!71 = distinct !DISubprogram(name: "__syncwarp", scope: !69, file: !69, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!72 = distinct !DILocation(line: 71, column: 5, scope: !40)
!73 = !DILocation(line: 0, scope: !40)
!74 = !DILocation(line: 69, column: 3, scope: !68, inlinedAt: !70)
!75 = !DILocation(line: 70, column: 3, scope: !68, inlinedAt: !70)
!76 = !DILocation(line: 73, column: 46, scope: !40)
!77 = !DILocation(line: 73, column: 25, scope: !40)
!78 = !DILocation(line: 76, column: 36, scope: !40)
!79 = !{i32 -1, i32 3, i32 -1}
!80 = !DILocation(line: 68, column: 3, scope: !68, inlinedAt: !81)
!81 = distinct !DILocation(line: 192, column: 3, scope: !71, inlinedAt: !82)
!82 = distinct !DILocation(line: 82, column: 5, scope: !40)
!83 = !DILocation(line: 69, column: 3, scope: !68, inlinedAt: !81)
!84 = !DILocation(line: 70, column: 3, scope: !68, inlinedAt: !81)
!85 = !DILocation(line: 84, column: 10, scope: !40)
!86 = !DILocation(line: 85, column: 70, scope: !40)
!87 = !DILocation(line: 85, column: 26, scope: !40)
!88 = !DILocation(line: 89, column: 30, scope: !40)
!89 = !DILocation(line: 89, column: 41, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "min", scope: !92, file: !92, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!93 = distinct !DILocation(line: 89, column: 25, scope: !40)
!94 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "expf", scope: !92, file: !92, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 89, column: 20, scope: !40)
!97 = !DILocation(line: 94, column: 34, scope: !40)
!98 = !DILocation(line: 99, column: 42, scope: !40)
!99 = !DILocation(line: 104, column: 36, scope: !40)
!100 = !DILocation(line: 104, column: 34, scope: !40)
!101 = !DILocation(line: 104, column: 9, scope: !40)
!102 = !DILocation(line: 112, column: 32, scope: !40)
!103 = !DILocation(line: 75, column: 10, scope: !104, inlinedAt: !106)
!104 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !105, file: !105, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!106 = distinct !DILocation(line: 984, column: 9, scope: !107, inlinedAt: !109)
!107 = distinct !DISubprogram(name: "__float2half", scope: !108, file: !108, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!109 = distinct !DILocation(line: 133, column: 53, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__half", scope: !108, file: !108, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 116, column: 32, scope: !40)
!112 = !DILocation(line: 116, column: 29, scope: !40)
!113 = !DILocation(line: 68, column: 3, scope: !68, inlinedAt: !114)
!114 = distinct !DILocation(line: 192, column: 3, scope: !71, inlinedAt: !115)
!115 = distinct !DILocation(line: 118, column: 5, scope: !40)
!116 = !DILocation(line: 69, column: 3, scope: !68, inlinedAt: !114)
!117 = !DILocation(line: 70, column: 3, scope: !68, inlinedAt: !114)
!118 = !DILocation(line: 121, column: 104, scope: !40)
!119 = !DILocation(line: 121, column: 31, scope: !40)
!120 = !DILocation(line: 121, column: 29, scope: !40)
!121 = !{!26, !26, i64 0}
!122 = !DILocation(line: 126, column: 38, scope: !40)
!123 = !DILocation(line: 133, column: 3, scope: !40)
!124 = !DILocation(line: 136, column: 61, scope: !40)
!125 = !DILocation(line: 75, column: 10, scope: !104, inlinedAt: !126)
!126 = distinct !DILocation(line: 984, column: 9, scope: !107, inlinedAt: !127)
!127 = distinct !DILocation(line: 133, column: 53, scope: !110, inlinedAt: !128)
!128 = distinct !DILocation(line: 136, column: 53, scope: !40)
!129 = !DILocation(line: 136, column: 50, scope: !40)
!130 = !DILocation(line: 140, column: 3, scope: !40)
!131 = !DILocation(line: 141, column: 22, scope: !40)
!132 = !DILocation(line: 141, column: 141, scope: !40)
!133 = !DILocation(line: 143, column: 1, scope: !40)
