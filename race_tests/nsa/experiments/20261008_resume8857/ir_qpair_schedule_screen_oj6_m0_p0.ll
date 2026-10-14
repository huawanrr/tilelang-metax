; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_qpair_schedule_screen_oj6_m0_p0.cpp'
source_filename = "/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_qpair_schedule_screen_oj6_m0_p0.cpp"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@v_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Packed.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedK.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !15
  %mul = shl nsw i32 %0, 17
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %mul6 = shl nsw i32 %1, 12
  %add = add nuw nsw i32 %mul, %mul6
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !25
  %mul10 = shl nuw nsw i32 %2, 3
  %add8 = add nuw nsw i32 %add, %mul10
  %3 = zext nneg i32 %add8 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %3
  %4 = add nuw nsw i64 %3, 2048
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %4
  %5 = shl nuw nsw i32 %2, 8
  %mul30 = and i32 %5, 3072
  %and35 = shl nuw nsw i32 %2, 7
  %mul36 = and i32 %and35, 384
  %6 = lshr i32 %2, 1
  %mul40 = and i32 %6, 504
  %7 = or disjoint i32 %mul30, %mul36
  %add31 = or disjoint i32 %7, %add
  %add33 = add nuw nsw i32 %add31, %mul40
  %8 = zext nneg i32 %add33 to i64
  %add.ptr43 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %8
  tail call void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr43, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !26
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %8
  %add.ptr43.1 = getelementptr inbounds i8, ptr addrspace(1) %9, i64 1024
  tail call void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr43.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !26
  %add.ptr63 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %3
  %tile.sroa.0.0.copyload = load i64, ptr addrspace(4) %add.ptr63, align 16
  %tile.sroa.4.0.add.ptr63.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr63, i64 8
  %tile.sroa.4.0.copyload = load i64, ptr addrspace(4) %tile.sroa.4.0.add.ptr63.sroa_idx, align 8
  %add.ptr63.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %4
  %tile.sroa.5.16.copyload = load i64, ptr addrspace(4) %add.ptr63.1, align 16
  %tile.sroa.7.16.add.ptr63.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr63.1, i64 8
  %tile.sroa.7.16.copyload = load i64, ptr addrspace(4) %tile.sroa.7.16.add.ptr63.1.sroa_idx, align 8
  %mul84 = and i32 %mul10, 8064
  %and87 = shl nuw nsw i32 %2, 1
  %mul88 = and i32 %and87, 30
  %shr92 = lshr i32 %2, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @v_shared, i32 %mul84
  %xor = xor i32 %mul88, %shr92
  %add.ptr96.idx = shl nuw nsw i32 %xor, 3
  %add.ptr96 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr96.idx
  store i64 %tile.sroa.0.0.copyload, ptr addrspace(3) %add.ptr96, align 8
  %add90.1 = or disjoint i32 %mul88, 1
  %xor.1 = xor i32 %add90.1, %shr92
  %add.ptr96.idx.1 = shl nuw nsw i32 %xor.1, 3
  %add.ptr96.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr96.idx.1
  store i64 %tile.sroa.4.0.copyload, ptr addrspace(3) %add.ptr96.1, align 8
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 4096
  %add.ptr96.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr96.idx
  store i64 %tile.sroa.5.16.copyload, ptr addrspace(3) %add.ptr96.2, align 8
  %add.ptr96.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr96.idx.1
  store i64 %tile.sroa.7.16.copyload, ptr addrspace(3) %add.ptr96.3, align 8
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %10 = shl nuw nsw i32 %2, 5
  %mul110 = and i32 %10, 1536
  %11 = lshr i32 %2, 3
  %mul117 = and i32 %11, 120
  %and123 = lshr i32 %2, 2
  %shr124 = and i32 %and123, 3
  %add121 = or disjoint i32 %shr124, %mul117
  %mul129 = and i32 %and123, 12
  %and136 = and i32 %2, 3
  %xor132 = xor i32 %add121, %mul129
  %mul133 = shl nuw nsw i32 %xor132, 2
  %add134 = or disjoint i32 %and136, %mul110
  %add137 = or disjoint i32 %add134, %mul133
  %arrayidx = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137
  %12 = load i16, ptr addrspace(3) %arrayidx, align 2, !tbaa !27
  %add131.1 = or disjoint i32 %mul129, 1
  %xor132.1 = xor i32 %add121, %add131.1
  %mul133.1 = shl nuw nsw i32 %xor132.1, 2
  %add114.1 = or disjoint i32 %and136, 128
  %add134.1 = or disjoint i32 %add114.1, %mul110
  %add137.1 = add nuw nsw i32 %add134.1, %mul133.1
  %arrayidx.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.1
  %13 = load i16, ptr addrspace(3) %arrayidx.1, align 2, !tbaa !27
  %add131.2 = or disjoint i32 %mul129, 2
  %xor132.2 = xor i32 %add121, %add131.2
  %mul133.2 = shl nuw nsw i32 %xor132.2, 2
  %add114.2 = or disjoint i32 %and136, 256
  %add134.2 = or disjoint i32 %add114.2, %mul110
  %add137.2 = add nuw nsw i32 %add134.2, %mul133.2
  %arrayidx.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.2
  %14 = load i16, ptr addrspace(3) %arrayidx.2, align 2, !tbaa !27
  %add131.3 = or disjoint i32 %mul129, 3
  %xor132.3 = xor i32 %add121, %add131.3
  %mul133.3 = shl nuw nsw i32 %xor132.3, 2
  %add114.3 = or disjoint i32 %and136, 384
  %add134.3 = or disjoint i32 %add114.3, %mul110
  %add137.3 = add nuw nsw i32 %add134.3, %mul133.3
  %arrayidx.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.3
  %15 = load i16, ptr addrspace(3) %arrayidx.3, align 2, !tbaa !27
  %add125.4 = or disjoint i32 %add121, 4
  %xor132.4 = xor i32 %add125.4, %mul129
  %mul133.4 = shl nuw nsw i32 %xor132.4, 2
  %add137.4 = or disjoint i32 %add134, %mul133.4
  %arrayidx.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.4
  %16 = load i16, ptr addrspace(3) %arrayidx.4, align 2, !tbaa !27
  %xor132.5 = xor i32 %add125.4, %add131.1
  %mul133.5 = shl nuw nsw i32 %xor132.5, 2
  %add137.5 = add nuw nsw i32 %add134.1, %mul133.5
  %arrayidx.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.5
  %17 = load i16, ptr addrspace(3) %arrayidx.5, align 2, !tbaa !27
  %xor132.6 = xor i32 %add125.4, %add131.2
  %mul133.6 = shl nuw nsw i32 %xor132.6, 2
  %add137.6 = add nuw nsw i32 %add134.2, %mul133.6
  %arrayidx.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.6
  %18 = load i16, ptr addrspace(3) %arrayidx.6, align 2, !tbaa !27
  %xor132.7 = xor i32 %add125.4, %add131.3
  %mul133.7 = shl nuw nsw i32 %xor132.7, 2
  %add137.7 = add nuw nsw i32 %add134.3, %mul133.7
  %arrayidx.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.7
  %19 = load i16, ptr addrspace(3) %arrayidx.7, align 2, !tbaa !27
  %add111.8 = or disjoint i32 %mul110, 2048
  %add134.8 = or disjoint i32 %and136, %add111.8
  %add137.8 = or disjoint i32 %add134.8, %mul133
  %arrayidx.8 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.8
  %20 = load i16, ptr addrspace(3) %arrayidx.8, align 2, !tbaa !27
  %add134.9 = or disjoint i32 %add114.1, %add111.8
  %add137.9 = add nuw nsw i32 %add134.9, %mul133.1
  %arrayidx.9 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.9
  %21 = load i16, ptr addrspace(3) %arrayidx.9, align 2, !tbaa !27
  %add134.10 = or disjoint i32 %add114.2, %add111.8
  %add137.10 = add nuw nsw i32 %add134.10, %mul133.2
  %arrayidx.10 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.10
  %22 = load i16, ptr addrspace(3) %arrayidx.10, align 2, !tbaa !27
  %add134.11 = or disjoint i32 %add114.3, %add111.8
  %add137.11 = add nuw nsw i32 %add134.11, %mul133.3
  %arrayidx.11 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.11
  %23 = load i16, ptr addrspace(3) %arrayidx.11, align 2, !tbaa !27
  %add137.12 = or disjoint i32 %add134.8, %mul133.4
  %arrayidx.12 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.12
  %24 = load i16, ptr addrspace(3) %arrayidx.12, align 2, !tbaa !27
  %add137.13 = add nuw nsw i32 %add134.9, %mul133.5
  %arrayidx.13 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.13
  %25 = load i16, ptr addrspace(3) %arrayidx.13, align 2, !tbaa !27
  %add137.14 = add nuw nsw i32 %add134.10, %mul133.6
  %arrayidx.14 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.14
  %26 = load i16, ptr addrspace(3) %arrayidx.14, align 2, !tbaa !27
  %add137.15 = add nuw nsw i32 %add134.11, %mul133.7
  %arrayidx.15 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @v_shared, i32 0, i32 %add137.15
  %27 = load i16, ptr addrspace(3) %arrayidx.15, align 2, !tbaa !27
  %add.ptr163 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %3
  store i16 %12, ptr addrspace(1) %add.ptr163, align 16
  %packed_v.sroa.4.0.add.ptr163.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163, i64 2
  store i16 %13, ptr addrspace(1) %packed_v.sroa.4.0.add.ptr163.sroa_idx, align 2, !tbaa !16
  %packed_v.sroa.5.0.add.ptr163.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163, i64 4
  store i16 %14, ptr addrspace(1) %packed_v.sroa.5.0.add.ptr163.sroa_idx, align 4
  %packed_v.sroa.6.0.add.ptr163.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163, i64 6
  store i16 %15, ptr addrspace(1) %packed_v.sroa.6.0.add.ptr163.sroa_idx, align 2, !tbaa !16
  %packed_v.sroa.7.0.add.ptr163.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163, i64 8
  store i16 %16, ptr addrspace(1) %packed_v.sroa.7.0.add.ptr163.sroa_idx, align 8
  %packed_v.sroa.8.0.add.ptr163.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163, i64 10
  store i16 %17, ptr addrspace(1) %packed_v.sroa.8.0.add.ptr163.sroa_idx, align 2, !tbaa !16
  %packed_v.sroa.9.0.add.ptr163.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163, i64 12
  store i16 %18, ptr addrspace(1) %packed_v.sroa.9.0.add.ptr163.sroa_idx, align 4
  %packed_v.sroa.10.0.add.ptr163.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163, i64 14
  store i16 %19, ptr addrspace(1) %packed_v.sroa.10.0.add.ptr163.sroa_idx, align 2, !tbaa !16
  %add.ptr163.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %4
  store i16 %20, ptr addrspace(1) %add.ptr163.1, align 16
  %packed_v.sroa.13.16.add.ptr163.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163.1, i64 2
  store i16 %21, ptr addrspace(1) %packed_v.sroa.13.16.add.ptr163.1.sroa_idx, align 2, !tbaa !16
  %packed_v.sroa.14.16.add.ptr163.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163.1, i64 4
  store i16 %22, ptr addrspace(1) %packed_v.sroa.14.16.add.ptr163.1.sroa_idx, align 4
  %packed_v.sroa.15.16.add.ptr163.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163.1, i64 6
  store i16 %23, ptr addrspace(1) %packed_v.sroa.15.16.add.ptr163.1.sroa_idx, align 2, !tbaa !16
  %packed_v.sroa.16.16.add.ptr163.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163.1, i64 8
  store i16 %24, ptr addrspace(1) %packed_v.sroa.16.16.add.ptr163.1.sroa_idx, align 8
  %packed_v.sroa.17.16.add.ptr163.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163.1, i64 10
  store i16 %25, ptr addrspace(1) %packed_v.sroa.17.16.add.ptr163.1.sroa_idx, align 2, !tbaa !16
  %packed_v.sroa.18.16.add.ptr163.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163.1, i64 12
  store i16 %26, ptr addrspace(1) %packed_v.sroa.18.16.add.ptr163.1.sroa_idx, align 4
  %packed_v.sroa.19.16.add.ptr163.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr163.1, i64 14
  store i16 %27, ptr addrspace(1) %packed_v.sroa.19.16.add.ptr163.1.sroa_idx, align 2, !tbaa !16
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #4

; Function Attrs: convergent mustprogress nounwind willreturn
declare void @llvm.mxc.barrier() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #4

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #7

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="256" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { mustprogress nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { convergent mustprogress nounwind willreturn }
attributes #6 = { mustprogress nounwind willreturn }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

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
!26 = !{i32 2, i32 0, i32 -1, i32 -1}
!27 = !{!11, !11, i64 0}
