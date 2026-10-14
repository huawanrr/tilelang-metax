; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_qschedule_screen_oj4_m3_p0.cpp'
source_filename = "/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_qschedule_screen_oj4_m3_p0.cpp"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_pure_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #1

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

; Function Attrs: mustprogress nounwind
define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr()
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !tbaa !2
  %2 = inttoptr i64 %1 to ptr
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !tbaa !2
  %4 = inttoptr i64 %3 to ptr
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16
  %5 = load ptr, ptr %thread_counter.i, align 8, !tbaa !6
  %cmp.not.i = icmp eq ptr %5, null
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr()
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12
  %8 = load i32, ptr addrspace(4) %7, align 4, !range !13, !invariant.load !14
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4
  %10 = load i32, ptr addrspace(4) %9, align 4, !invariant.load !14
  %conv.i14.i.i = and i32 %10, 65535
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16
  %12 = load i32, ptr addrspace(4) %11, align 4, !range !13, !invariant.load !14
  %13 = lshr i32 %10, 16
  %div.i.i.i = udiv i32 %12, %13
  %mul.i.i.i = mul i32 %div.i.i.i, %13
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !15
  %mul.i.i = mul i32 %add.i.i.i, %14
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !15
  %mul320.i.i = add i32 %mul.i.i, %15
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %add8.i.i = add i32 %add.i.i, %16
  %conv.i.i = zext i32 %add8.i.i to i64
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i)
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !tbaa !16
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
  br label %while.cond.i, !llvm.loop !17

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i)
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !tbaa !16
  %add.i37.i = add nsw i32 %21, -1
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !tbaa !16
  br label %_Z9atomicAddPii.exit38.i

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %_Z9atomicAddPii.exit38.i

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ]
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4
  %23 = load i32, ptr %call_deep.i, align 4, !tbaa !19
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
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !tbaa !20
  %25 = load i32, ptr %4, align 8, !tbaa !21
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !tbaa !6
  %idxprom.i = zext i32 %25 to i64
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !tbaa !22
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !tbaa !24
  %29 = inttoptr i64 %28 to ptr
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i)
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !tbaa !16
  %and.i.i.i = and i32 %31, 2147483647
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !tbaa !16
  br label %if.end20.i

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4
  br label %if.end20.i

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i)
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !tbaa !16
  %add.i42.i = add nsw i32 %34, -1
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !tbaa !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %__mcImplicitDeviceSynchronizeImpl.exit

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void
}

; Function Attrs: convergent mustprogress norecurse nounwind willreturn
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !15
  %mul = shl nsw i32 %0, 19
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !25
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %4 = add nuw nsw i64 %3, 512
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %mul27 = and i32 %mul11, 8128
  %xor589 = and i32 %mul11, 56
  %call30.masked = and i32 %2, 1016
  %mul32 = xor i32 %xor589, %call30.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul27
  %invariant.gep599 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul32
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep599, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !26
  %gep600.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep599, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep600.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !26
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and45 = shl nuw nsw i32 %2, 6
  %mul46 = and i32 %and45, 960
  %and52 = and i32 %2, 7
  %mul66 = shl nsw i32 %0, 9
  %add68 = add nuw nsw i32 %mul66, %1
  %idxprom = zext nneg i32 %add68 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !16
  %cmp83 = icmp ugt i32 %5, 31
  %shr86 = lshr i32 %1, 4
  %cmp87.not = icmp ugt i32 %5, %shr86
  %or.cond636 = or i1 %cmp83, %cmp87.not
  br i1 %or.cond636, label %if.end331, label %if.then

if.then:                                          ; preds = %entry
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul46
  %shr49 = lshr i32 %2, 4
  %add50.1 = add nuw nsw i32 %shr49, 4
  %xor53.1 = xor i32 %add50.1, %and52
  %add.ptr57.idx.1 = shl nuw nsw i32 %xor53.1, 4
  %add.ptr57.1 = getelementptr inbounds i8, ptr addrspace(3) %6, i32 %add.ptr57.idx.1
  %Q_reg.sroa.7.16.add.ptr57.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr57.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr57.1.sroa_idx, align 8
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr57.1, align 16
  %xor53 = xor i32 %shr49, %and52
  %add.ptr57.idx = shl nuw nsw i32 %xor53, 4
  %add.ptr57 = getelementptr inbounds i8, ptr addrspace(3) %6, i32 %add.ptr57.idx
  %Q_reg.sroa.4.0.add.ptr57.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr57, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr57.sroa_idx, align 8
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr57, align 16
  %mul100 = shl nsw i32 %0, 15
  %mul101 = shl nuw nsw i32 %5, 10
  %add102 = or disjoint i32 %mul11, %mul100
  %add104 = add nuw nsw i32 %add102, %mul101
  %7 = zext nneg i32 %add104 to i64
  %add.ptr111 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr111, align 4, !tbaa !16
  %9 = or disjoint i64 %7, 2
  %add.ptr111.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr111.1, align 4, !tbaa !16
  %11 = or disjoint i64 %7, 4
  %add.ptr111.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr111.2, align 4, !tbaa !16
  %13 = or disjoint i64 %7, 6
  %add.ptr111.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr111.3, align 4, !tbaa !16
  %15 = add nuw nsw i64 %7, 512
  %add.ptr111.1654 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr111.1654, align 4, !tbaa !16
  %17 = add nuw nsw i64 %7, 514
  %add.ptr111.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr111.1.1, align 4, !tbaa !16
  %19 = add nuw nsw i64 %7, 516
  %add.ptr111.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr111.2.1, align 4, !tbaa !16
  %21 = add nuw nsw i64 %7, 518
  %add.ptr111.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr111.3.1, align 4, !tbaa !16
  %add.ptr144 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %23 = load i32, ptr addrspace(4) %add.ptr144, align 4, !tbaa !16
  %add.ptr144.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %24 = load i32, ptr addrspace(4) %add.ptr144.1, align 4, !tbaa !16
  %add.ptr144.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %25 = load i32, ptr addrspace(4) %add.ptr144.2, align 4, !tbaa !16
  %add.ptr144.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %26 = load i32, ptr addrspace(4) %add.ptr144.3, align 4, !tbaa !16
  %add.ptr144.1666 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %27 = load i32, ptr addrspace(4) %add.ptr144.1666, align 4, !tbaa !16
  %add.ptr144.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %28 = load i32, ptr addrspace(4) %add.ptr144.1.1, align 4, !tbaa !16
  %add.ptr144.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %29 = load i32, ptr addrspace(4) %add.ptr144.2.1, align 4, !tbaa !16
  %add.ptr144.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %30 = load i32, ptr addrspace(4) %add.ptr144.3.1, align 4, !tbaa !16
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %8, ptr addrspace(3) %invariant.gep599, align 16, !tbaa !16
  %K_reg.sroa.4.0.invariant.gep609.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep599, i32 4
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep609.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.5.0.invariant.gep609.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep599, i32 8
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep609.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.6.0.invariant.gep609.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep599, i32 12
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep609.sroa_idx, align 4, !tbaa !16
  store i32 %16, ptr addrspace(3) %gep600.1, align 16, !tbaa !16
  %K_reg.sroa.9.16.gep610.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep599, i32 1028
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.gep610.1.sroa_idx, align 4, !tbaa !16
  %K_reg.sroa.10.16.gep610.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep599, i32 1032
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.gep610.1.sroa_idx, align 8, !tbaa !16
  %K_reg.sroa.11.16.gep610.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep599, i32 1036
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.gep610.1.sroa_idx, align 4, !tbaa !16
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr57, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr57.sroa_idx, align 8
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31)
  %kb.sroa.0.0.copyload696 = load <4 x half>, ptr addrspace(3) %add.ptr57.1, align 16
  %kb.sroa.6.0.copyload697 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr57.1.sroa_idx, align 8
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload696, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32)
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload697, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr241.idx = shl nuw nsw i32 %2, 4
  %invariant.gep617 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr241.idx
  store i32 %23, ptr addrspace(3) %invariant.gep617, align 16, !tbaa !16
  %V_reg.sroa.4.0.invariant.gep617.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep617, i32 4
  store i32 %24, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep617.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.5.0.invariant.gep617.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep617, i32 8
  store i32 %25, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep617.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.6.0.invariant.gep617.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep617, i32 12
  store i32 %26, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep617.sroa_idx, align 4, !tbaa !16
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep617, i32 1024
  store i32 %27, ptr addrspace(3) %gep.1, align 16, !tbaa !16
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep617, i32 1028
  store i32 %28, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !16
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep617, i32 1032
  store i32 %29, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !16
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep617, i32 1036
  store i32 %30, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !16
  %mul88 = shl nuw nsw i32 %5, 4
  %shr253 = shl nuw nsw i32 %5, 2
  %add254 = add nuw nsw i32 %shr253, %shr49
  %cmp255 = icmp ugt i32 %add254, 127
  %35 = lshr i32 %2, 2
  %mul259 = and i32 %35, 252
  %add261 = add nuw nsw i32 %mul88, %mul259
  %cmp264.not = icmp ugt i32 %add261, %1
  %or.cond637 = select i1 %cmp255, i1 true, i1 %cmp264.not
  br i1 %or.cond637, label %if.end, label %if.then265

if.then265:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %34, i64 0
  %mul268 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul268, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then265
  %condval.0 = phi float [ %37, %if.then265 ], [ 0.000000e+00, %if.then ]
  %cmp264.not.1 = icmp uge i32 %add261, %1
  %or.cond637.1 = select i1 %cmp255, i1 true, i1 %cmp264.not.1
  br i1 %or.cond637.1, label %if.end.1, label %if.then265.1

if.then265.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %34, i64 1
  %mul268.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul268.1, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then265.1, %if.end
  %condval.0.1 = phi float [ %39, %if.then265.1 ], [ 0.000000e+00, %if.end ]
  %add262.2 = or disjoint i32 %add261, 2
  %cmp264.not.2 = icmp ugt i32 %add262.2, %1
  %or.cond637.2 = select i1 %cmp255, i1 true, i1 %cmp264.not.2
  br i1 %or.cond637.2, label %if.end.2, label %if.then265.2

if.then265.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %34, i64 2
  %mul268.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul268.2, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then265.2, %if.end.1
  %condval.0.2 = phi float [ %41, %if.then265.2 ], [ 0.000000e+00, %if.end.1 ]
  %add262.3 = or disjoint i32 %add261, 3
  %cmp264.not.3 = icmp ugt i32 %add262.3, %1
  %or.cond637.3 = select i1 %cmp255, i1 true, i1 %cmp264.not.3
  br i1 %or.cond637.3, label %if.end.3, label %if.then265.3

if.then265.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %34, i64 3
  %mul268.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul268.3, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then265.3, %if.end.2
  %condval.0.3 = phi float [ %43, %if.then265.3 ], [ 0.000000e+00, %if.end.2 ]
  %add284.1 = fadd contract float %condval.0, %condval.0.1
  %add284.2 = fadd contract float %add284.1, %condval.0.2
  %add284.3 = fadd contract float %add284.2, %condval.0.3
  %44 = bitcast float %add284.3 to i32
  %45 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %46 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %45) #11
  %xor.i.i = xor i32 %46, 32
  %47 = and i32 %46, -64
  %and.i.i = add nsw i32 %47, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %46
  %shl.i.i = shl i32 %cond.i.i, 2
  %48 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %44)
  %49 = bitcast i32 %48 to float
  %add292 = fadd contract float %add284.3, %49
  %50 = bitcast float %add292 to i32
  %51 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %52 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %51) #11
  %xor.i.i591 = xor i32 %52, 16
  %53 = and i32 %52, -64
  %and.i.i592 = add nsw i32 %53, 64
  %cmp.not.i.i593 = icmp slt i32 %xor.i.i591, %and.i.i592
  %cond.i.i594 = select i1 %cmp.not.i.i593, i32 %xor.i.i591, i32 %52
  %shl.i.i595 = shl i32 %cond.i.i594, 2
  %54 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i595, i32 %50)
  %55 = bitcast i32 %54 to float
  %add297 = fadd contract float %add292, %55
  %cmp300 = fcmp contract ogt float %add297, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add297
  %condval_1.0 = select i1 %cmp300, float %div, float 0.000000e+00
  %mul313 = fmul contract float %condval_1.0, %condval.0
  %mul313.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul313.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul313.3 = fmul contract float %condval_1.0, %condval.0.3
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313)
  %57 = insertelement <4 x i16> poison, i16 %56, i64 0
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313.1)
  %59 = insertelement <4 x i16> %57, i16 %58, i64 1
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313.2)
  %61 = insertelement <4 x i16> %59, i16 %60, i64 2
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313.3)
  %63 = insertelement <4 x i16> %61, i16 %62, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %63 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end331

if.end331:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond636, label %if.end401, label %for.cond353.preheader

for.cond353.preheader:                            ; preds = %if.end331
  %64 = shl nuw nsw i32 %2, 4
  %mul363 = and i32 %64, 16128
  %and369 = and i32 %2, 15
  %add370 = or disjoint i32 %mul363, %and369
  %arrayidx372 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370
  %65 = load half, ptr addrspace(3) %arrayidx372, align 2, !tbaa !27
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %65, i64 0
  %add365.1 = or disjoint i32 %mul363, %and369
  %add370.1 = or disjoint i32 %add365.1, 64
  %arrayidx372.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.1
  %66 = load half, ptr addrspace(3) %arrayidx372.1, align 2, !tbaa !27
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %66, i64 1
  %add365.2 = or disjoint i32 %mul363, %and369
  %add370.2 = or disjoint i32 %add365.2, 128
  %arrayidx372.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.2
  %67 = load half, ptr addrspace(3) %arrayidx372.2, align 2, !tbaa !27
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %67, i64 2
  %add365.3 = or disjoint i32 %mul363, %and369
  %add370.3 = or disjoint i32 %add365.3, 192
  %arrayidx372.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.3
  %68 = load half, ptr addrspace(3) %arrayidx372.3, align 2, !tbaa !27
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %68, i64 3
  %add367.1670 = or disjoint i32 %mul363, %and369
  %add370.1671 = or disjoint i32 %add367.1670, 16
  %arrayidx372.1672 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.1671
  %69 = load half, ptr addrspace(3) %arrayidx372.1672, align 2, !tbaa !27
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %69, i64 0
  %add367.1.1 = or disjoint i32 %mul363, %and369
  %add370.1.1 = or disjoint i32 %add367.1.1, 80
  %arrayidx372.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.1.1
  %70 = load half, ptr addrspace(3) %arrayidx372.1.1, align 2, !tbaa !27
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %70, i64 1
  %add367.2.1 = or disjoint i32 %mul363, %and369
  %add370.2.1 = or disjoint i32 %add367.2.1, 144
  %arrayidx372.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.2.1
  %71 = load half, ptr addrspace(3) %arrayidx372.2.1, align 2, !tbaa !27
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %71, i64 2
  %add367.3.1 = or disjoint i32 %mul363, %and369
  %add370.3.1 = or disjoint i32 %add367.3.1, 208
  %arrayidx372.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.3.1
  %72 = load half, ptr addrspace(3) %arrayidx372.3.1, align 2, !tbaa !27
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %72, i64 3
  %add367.2674 = or disjoint i32 %mul363, %and369
  %add370.2675 = or disjoint i32 %add367.2674, 32
  %arrayidx372.2676 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.2675
  %73 = load half, ptr addrspace(3) %arrayidx372.2676, align 2, !tbaa !27
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %73, i64 0
  %add367.1.2 = or disjoint i32 %mul363, %and369
  %add370.1.2 = or disjoint i32 %add367.1.2, 96
  %arrayidx372.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.1.2
  %74 = load half, ptr addrspace(3) %arrayidx372.1.2, align 2, !tbaa !27
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %74, i64 1
  %add367.2.2 = or disjoint i32 %mul363, %and369
  %add370.2.2 = or disjoint i32 %add367.2.2, 160
  %arrayidx372.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.2.2
  %75 = load half, ptr addrspace(3) %arrayidx372.2.2, align 2, !tbaa !27
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %75, i64 2
  %add367.3.2 = or disjoint i32 %mul363, %and369
  %add370.3.2 = or disjoint i32 %add367.3.2, 224
  %arrayidx372.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.3.2
  %76 = load half, ptr addrspace(3) %arrayidx372.3.2, align 2, !tbaa !27
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %76, i64 3
  %add367.3678 = or disjoint i32 %mul363, %and369
  %add370.3679 = or disjoint i32 %add367.3678, 48
  %arrayidx372.3680 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.3679
  %77 = load half, ptr addrspace(3) %arrayidx372.3680, align 2, !tbaa !27
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %77, i64 0
  %add367.1.3 = or disjoint i32 %mul363, %and369
  %add370.1.3 = or disjoint i32 %add367.1.3, 112
  %arrayidx372.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.1.3
  %78 = load half, ptr addrspace(3) %arrayidx372.1.3, align 2, !tbaa !27
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %78, i64 1
  %add367.2.3 = or disjoint i32 %mul363, %and369
  %add370.2.3 = or disjoint i32 %add367.2.3, 176
  %arrayidx372.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.2.3
  %79 = load half, ptr addrspace(3) %arrayidx372.2.3, align 2, !tbaa !27
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %79, i64 2
  %add367.3.3 = or disjoint i32 %64, %and369
  %add370.3.3 = or i32 %add367.3.3, 240
  %arrayidx372.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add370.3.3
  %80 = load half, ptr addrspace(3) %arrayidx372.3.3, align 2, !tbaa !27
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %80, i64 3
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end401

if.end401:                                        ; preds = %for.cond353.preheader, %if.end331
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %81, %for.cond353.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %82, %for.cond353.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %83, %for.cond353.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end331 ], [ %84, %for.cond353.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %85 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %86 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %89 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %90 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %92 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %93 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %94 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %95 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %96 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %97 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %98 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %99 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %100 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr438 = lshr i32 %2, 5
  %101 = lshr i32 %2, 2
  %mul448 = and i32 %101, 4
  %xor442 = xor i32 %shr438, %and52
  %mul443 = shl nuw nsw i32 %xor442, 3
  %add444 = add nuw nsw i32 %mul443, %mul46
  %add449 = or disjoint i32 %add444, %mul448
  %add.ptr451 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add449
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr451, align 8
  %add439.1 = add nuw nsw i32 %shr438, 2
  %xor442.1 = xor i32 %add439.1, %and52
  %mul443.1 = shl nuw nsw i32 %xor442.1, 3
  %add444.1 = add nuw nsw i32 %mul443.1, %mul46
  %add449.1 = or disjoint i32 %add444.1, %mul448
  %add.ptr451.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add449.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr451.1, align 8
  %add439.2 = add nuw nsw i32 %shr438, 4
  %xor442.2 = xor i32 %add439.2, %and52
  %mul443.2 = shl nuw nsw i32 %xor442.2, 3
  %add444.2 = add nuw nsw i32 %mul443.2, %mul46
  %add449.2 = or disjoint i32 %add444.2, %mul448
  %add.ptr451.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add449.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr451.2, align 8
  %add439.3 = add nuw nsw i32 %shr438, 6
  %xor442.3 = xor i32 %add439.3, %and52
  %mul443.3 = shl nuw nsw i32 %xor442.3, 3
  %add444.3 = add nuw nsw i32 %mul443.3, %mul46
  %add449.3 = or disjoint i32 %add444.3, %mul448
  %add.ptr451.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add449.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr451.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr484 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr484, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep599, i64 16, i1 false), !tbaa.struct !28, !call_argsrelate !29
  %add.ptr484.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr484.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep600.1, i64 16, i1 false), !tbaa.struct !28, !call_argsrelate !29
  ret void
}

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: convergent mustprogress nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #8

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent mustprogress nofree nounwind willreturn memory(none) }
attributes #5 = { mustprogress nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent mustprogress nounwind willreturn }
attributes #7 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #9 = { mustprogress nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 1}
!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!7, !9, i64 16}
!7 = !{!"_ZTS21_DynamicParallMqlWrap", !8, i64 0, !8, i64 4, !8, i64 8, !8, i64 12, !9, i64 16, !9, i64 24, !10, i64 32}
!8 = !{!"int", !4, i64 0}
!9 = !{!"any pointer", !4, i64 0}
!10 = !{!"_ZTS28mxc_kernel_dispatch_packet_s", !11, i64 0, !11, i64 2, !11, i64 4, !11, i64 6, !11, i64 8, !11, i64 10, !8, i64 12, !8, i64 16, !8, i64 20, !8, i64 24, !8, i64 28, !3, i64 32, !9, i64 40, !3, i64 48, !12, i64 56}
!11 = !{!"short", !4, i64 0}
!12 = !{!"_ZTS12mxc_signal_s", !3, i64 0}
!13 = !{i32 1, i32 -2147483648}
!14 = !{}
!15 = !{i32 0, i32 2147483647}
!16 = !{!8, !8, i64 0}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.mustprogress"}
!19 = !{!7, !8, i64 4}
!20 = !{!7, !9, i64 24}
!21 = !{!7, !8, i64 0}
!22 = !{!23, !9, i64 24}
!23 = !{!"_ZTS28_DynamicParallSchedulerParam", !3, i64 0, !9, i64 8, !9, i64 16, !9, i64 24, !3, i64 32, !3, i64 40, !3, i64 48, !3, i64 56, !3, i64 64, !3, i64 72, !3, i64 80, !3, i64 88, !3, i64 96, !8, i64 104, !8, i64 108, !8, i64 112, !8, i64 116, !8, i64 120, !8, i64 124}
!24 = !{!23, !3, i64 80}
!25 = !{i32 0, i32 1024}
!26 = !{i32 1, i32 3, i32 -1, i32 -1}
!27 = !{!11, !11, i64 0}
!28 = !{i64 0, i64 4, !16, i64 4, i64 4, !16, i64 8, i64 4, !16, i64 12, i64 4, !16}
!29 = !{i32 2, i32 1, i32 -1, i32 -1}
