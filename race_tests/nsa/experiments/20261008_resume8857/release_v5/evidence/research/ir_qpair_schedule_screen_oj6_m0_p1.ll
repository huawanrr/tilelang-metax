; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_qpair_schedule_screen_oj6_m0_p1.cpp'
source_filename = "/data/tilelang-metax/race_tests/nsa/experiments/20261008_resume8857/ir_qpair_schedule_screen_oj6_m0_p1.cpp"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !15
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %mul7 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !25
  %mul11 = shl nuw nsw i32 %2, 2
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %4 = load i64, ptr addrspace(4) %add.ptr, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 512
  %6 = load i64, ptr addrspace(4) %add.ptr.1, align 8
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1024
  %8 = load i64, ptr addrspace(4) %add.ptr.2, align 8
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1536
  %10 = load i64, ptr addrspace(4) %add.ptr.3, align 8
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.4 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 2048
  %12 = load i64, ptr addrspace(4) %add.ptr.4, align 8
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.5 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2560
  %14 = load i64, ptr addrspace(4) %add.ptr.5, align 8
  %15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.6 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 3072
  %16 = load i64, ptr addrspace(4) %add.ptr.6, align 8
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.7 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 3584
  %18 = load i64, ptr addrspace(4) %add.ptr.7, align 8
  %mul17 = shl nsw i32 %0, 10
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %19 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !16
  %cmp20 = icmp sgt i32 %19, -1
  br i1 %cmp20, label %land.lhs.true, label %land.end

land.lhs.true:                                    ; preds = %entry
  %cmp21 = icmp ult i32 %19, 32
  %mul22 = shl nsw i32 %19, 5
  %cmp24 = icmp sle i32 %mul22, %1
  %spec.select = select i1 %cmp21, i1 %cmp24, i1 false
  br label %land.end

land.end:                                         ; preds = %land.lhs.true, %entry
  %20 = phi i1 [ false, %entry ], [ %spec.select, %land.lhs.true ]
  br i1 %20, label %for.cond25.preheader, label %if.end273

for.cond25.preheader:                             ; preds = %land.end
  %conv = zext nneg i32 %0 to i64
  %conv32 = sext i32 %19 to i64
  %21 = shl nuw nsw i32 %2, 3
  %mul40 = zext nneg i32 %21 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul40
  %.idx = shl nsw i64 %conv32, 13
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx
  %.idx527 = shl nuw nsw i64 %conv, 18
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx527
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %23, align 16
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8
  %gep.1 = getelementptr i8, ptr addrspace(4) %23, i64 1024
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 1032
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8
  %gep.2 = getelementptr i8, ptr addrspace(4) %23, i64 2048
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 2056
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8
  %gep.3 = getelementptr i8, ptr addrspace(4) %23, i64 3072
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 3080
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8
  %gep.4 = getelementptr i8, ptr addrspace(4) %23, i64 4096
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 4104
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8
  %gep.5 = getelementptr i8, ptr addrspace(4) %23, i64 5120
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 5128
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8
  %gep.6 = getelementptr i8, ptr addrspace(4) %23, i64 6144
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 6152
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8
  %gep.7 = getelementptr i8, ptr addrspace(4) %23, i64 7168
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 7176
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8
  %and = lshr i32 %2, 1
  %shr64 = and i32 %and, 15
  %shr67 = lshr i32 %2, 5
  %add62 = and i32 %mul11, 3972
  %xor = xor i32 %shr67, %shr64
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add62
  %add.ptr76.idx = shl nuw nsw i32 %xor, 4
  %add.ptr76 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr76.idx
  store i64 %4, ptr addrspace(3) %add.ptr76, align 8
  %add68.1 = add nuw nsw i32 %shr67, 2
  %xor.1 = xor i32 %add68.1, %shr64
  %25 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 512
  %add.ptr76.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr76.1 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr76.idx.1
  store i64 %6, ptr addrspace(3) %add.ptr76.1, align 8
  %add68.2 = add nuw nsw i32 %shr67, 4
  %xor.2 = xor i32 %add68.2, %shr64
  %26 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1024
  %add.ptr76.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr76.2 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr76.idx.2
  store i64 %8, ptr addrspace(3) %add.ptr76.2, align 8
  %add68.3 = add nuw nsw i32 %shr67, 6
  %xor.3 = xor i32 %add68.3, %shr64
  %27 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1536
  %add.ptr76.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr76.3 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr76.idx.3
  store i64 %10, ptr addrspace(3) %add.ptr76.3, align 8
  %add68.4 = add nuw nsw i32 %shr67, 8
  %xor.4 = xor i32 %add68.4, %shr64
  %28 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2048
  %add.ptr76.idx.4 = shl nuw nsw i32 %xor.4, 4
  %add.ptr76.4 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr76.idx.4
  store i64 %12, ptr addrspace(3) %add.ptr76.4, align 8
  %add68.5 = add nuw nsw i32 %shr67, 10
  %xor.5 = xor i32 %add68.5, %shr64
  %29 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2560
  %add.ptr76.idx.5 = shl nuw nsw i32 %xor.5, 4
  %add.ptr76.5 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr76.idx.5
  store i64 %14, ptr addrspace(3) %add.ptr76.5, align 8
  %add68.6 = add nuw nsw i32 %shr67, 12
  %xor.6 = xor i32 %add68.6, %shr64
  %30 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3072
  %add.ptr76.idx.6 = shl nuw nsw i32 %xor.6, 4
  %add.ptr76.6 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr76.idx.6
  store i64 %16, ptr addrspace(3) %add.ptr76.6, align 8
  %add68.7 = add nuw nsw i32 %shr67, 14
  %xor.7 = xor i32 %add68.7, %shr64
  %31 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3584
  %add.ptr76.idx.7 = shl nuw nsw i32 %xor.7, 4
  %add.ptr76.7 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr76.idx.7
  store i64 %18, ptr addrspace(3) %add.ptr76.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and86 = shl nuw nsw i32 %2, 7
  %mul87 = and i32 %and86, 1920
  %shr90 = lshr i32 %2, 4
  %and93 = and i32 %2, 15
  %32 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul87
  %xor94 = xor i32 %shr90, %and93
  %add.ptr98.idx = shl nuw nsw i32 %xor94, 4
  %add.ptr98 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98, align 16
  %q.sroa.4.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98, i32 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr98.sroa_idx, align 8
  %add91.1 = add nuw nsw i32 %shr90, 4
  %xor94.1 = xor i32 %add91.1, %and93
  %add.ptr98.idx.1 = shl nuw nsw i32 %xor94.1, 4
  %add.ptr98.1 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx.1
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.1, align 16
  %q.sroa.7.16.add.ptr98.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.1, i32 8
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr98.1.sroa_idx, align 8
  %add91.2 = add nuw nsw i32 %shr90, 8
  %xor94.2 = xor i32 %add91.2, %and93
  %add.ptr98.idx.2 = shl nuw nsw i32 %xor94.2, 4
  %add.ptr98.2 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx.2
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.2, align 16
  %q.sroa.10.32.add.ptr98.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.2, i32 8
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr98.2.sroa_idx, align 8
  %add91.3 = add nuw nsw i32 %shr90, 12
  %xor94.3 = xor i32 %add91.3, %and93
  %add.ptr98.idx.3 = shl nuw nsw i32 %xor94.3, 4
  %add.ptr98.3 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %add.ptr98.idx.3
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr98.3, align 16
  %q.sroa.13.48.add.ptr98.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr98.3, i32 8
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr98.3.sroa_idx, align 8
  %cmp111 = icmp slt i32 %19, 32
  %mul113 = shl nsw i32 %19, 5
  %33 = lshr i32 %2, 2
  %mul119 = and i32 %33, 252
  %add116 = add i32 %mul113, %mul119
  %cmp124.not = icmp sle i32 %add116, %1
  %or.cond.not = select i1 %cmp111, i1 %cmp124.not, i1 false
  %condval.0 = select i1 %or.cond.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %condval.0, i64 0
  %cmp124.not.1.not = icmp slt i32 %add116, %1
  %or.cond718 = select i1 %cmp111, i1 %cmp124.not.1.not, i1 false
  %condval.0.1 = select i1 %or.cond718, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %condval.0.1, i64 1
  %add120.2 = or disjoint i32 %add116, 2
  %cmp124.not.2 = icmp sle i32 %add120.2, %1
  %or.cond720.not = select i1 %cmp111, i1 %cmp124.not.2, i1 false
  %condval.0.2 = select i1 %or.cond720.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %condval.0.2, i64 2
  %add120.3 = or disjoint i32 %add116, 3
  %cmp124.not.3 = icmp sle i32 %add120.3, %1
  %or.cond722.not = select i1 %cmp111, i1 %cmp124.not.3, i1 false
  %condval.0.3 = select i1 %or.cond722.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %condval.0.3, i64 3
  %add122.4 = add i32 %add116, 16
  %cmp124.not.4 = icmp sle i32 %add122.4, %1
  %or.cond724.not = select i1 %cmp111, i1 %cmp124.not.4, i1 false
  %condval.0.4 = select i1 %or.cond724.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %condval.0.4, i64 0
  %add122.5 = add i32 %add116, 17
  %cmp124.not.5 = icmp sle i32 %add122.5, %1
  %or.cond726.not = select i1 %cmp111, i1 %cmp124.not.5, i1 false
  %condval.0.5 = select i1 %or.cond726.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %condval.0.5, i64 1
  %add122.6 = add i32 %add116, 18
  %cmp124.not.6 = icmp sle i32 %add122.6, %1
  %or.cond728.not = select i1 %cmp111, i1 %cmp124.not.6, i1 false
  %condval.0.6 = select i1 %or.cond728.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %condval.0.6, i64 2
  %add122.7 = add i32 %add116, 19
  %cmp124.not.7 = icmp sle i32 %add122.7, %1
  %or.cond730.not = select i1 %cmp111, i1 %cmp124.not.7, i1 false
  %condval.0.7 = select i1 %or.cond730.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %condval.0.7, i64 3
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !26
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !call_argsrelate !26
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %34), !call_argsrelate !26
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %35), !call_argsrelate !26
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %36), !call_argsrelate !26
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %37), !call_argsrelate !26
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %38), !call_argsrelate !26
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %39), !call_argsrelate !26
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %40), !call_argsrelate !26
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.8.32.copyload, <4 x float> %41), !call_argsrelate !26
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %42), !call_argsrelate !26
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.10.32.copyload, <4 x float> %43), !call_argsrelate !26
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %44), !call_argsrelate !26
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.11.48.copyload, <4 x float> %45), !call_argsrelate !26
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %46), !call_argsrelate !26
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.13.48.copyload, <4 x float> %47), !call_argsrelate !26
  %invariant.gep509 = getelementptr %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul40
  %50 = getelementptr i8, ptr addrspace(4) %invariant.gep509, i64 %.idx
  %51 = getelementptr i8, ptr addrspace(4) %50, i64 %.idx527
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %51, align 16
  %v.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %51, i64 8
  %v.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.4.0..sroa_idx, align 8
  %gep510.1 = getelementptr i8, ptr addrspace(4) %51, i64 1024
  %v.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep510.1, align 16
  %v.sroa.7.16.gep510.1.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 1032
  %v.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.16.gep510.1.sroa_idx, align 8
  %gep510.2 = getelementptr i8, ptr addrspace(4) %51, i64 2048
  %v.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep510.2, align 16
  %v.sroa.10.32.gep510.2.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 2056
  %v.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.10.32.gep510.2.sroa_idx, align 8
  %gep510.3 = getelementptr i8, ptr addrspace(4) %51, i64 3072
  %v.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep510.3, align 16
  %v.sroa.13.48.gep510.3.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 3080
  %v.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.13.48.gep510.3.sroa_idx, align 8
  %gep510.4 = getelementptr i8, ptr addrspace(4) %51, i64 4096
  %v.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep510.4, align 16
  %v.sroa.16.64.gep510.4.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 4104
  %v.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.16.64.gep510.4.sroa_idx, align 8
  %gep510.5 = getelementptr i8, ptr addrspace(4) %51, i64 5120
  %v.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep510.5, align 16
  %v.sroa.19.80.gep510.5.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 5128
  %v.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.19.80.gep510.5.sroa_idx, align 8
  %gep510.6 = getelementptr i8, ptr addrspace(4) %51, i64 6144
  %v.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep510.6, align 16
  %v.sroa.22.96.gep510.6.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 6152
  %v.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.22.96.gep510.6.sroa_idx, align 8
  %gep510.7 = getelementptr i8, ptr addrspace(4) %51, i64 7168
  %v.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep510.7, align 16
  %v.sroa.25.112.gep510.7.sroa_idx = getelementptr i8, ptr addrspace(4) %51, i64 7176
  %v.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.25.112.gep510.7.sroa_idx, align 8
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %48, i64 0
  %mul203 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul203, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %52, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i494 = fadd contract float %52, %cond.i.i
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i494)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %53
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %48, i64 1
  %mul203.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul203.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %54, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i494.1 = fadd contract float %54, %cond.i.i.1
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i494.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %55
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %48, i64 2
  %mul203.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul203.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %56, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i494.2 = fadd contract float %56, %cond.i.i.2
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i494.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %57
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %48, i64 3
  %mul203.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul203.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %58, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i494.3 = fadd contract float %58, %cond.i.i.3
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i494.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %59
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %49, i64 0
  %mul203.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul203.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %60, -1.260000e+02
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i494.4 = fadd contract float %60, %cond.i.i.4
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i494.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %61
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %49, i64 1
  %mul203.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul203.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %62, -1.260000e+02
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i494.5 = fadd contract float %62, %cond.i.i.5
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i494.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %63
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %49, i64 2
  %mul203.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul203.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %64, -1.260000e+02
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i494.6 = fadd contract float %64, %cond.i.i.6
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i494.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %65
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %49, i64 3
  %mul203.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul203.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %66, -1.260000e+02
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i494.7 = fadd contract float %66, %cond.i.i.7
  %67 = tail call contract float @llvm.exp2.f32(float %add.i.i494.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %67
  %add223 = fadd contract float %mul.i.i, 0.000000e+00
  %add223.1 = fadd contract float %add223, %mul.i.i.4
  %add223.2 = fadd contract float %add223.1, %mul.i.i.1
  %add223.3 = fadd contract float %add223.2, %mul.i.i.5
  %add223.4 = fadd contract float %add223.3, %mul.i.i.2
  %add223.5 = fadd contract float %add223.4, %mul.i.i.6
  %add223.6 = fadd contract float %add223.5, %mul.i.i.3
  %add223.7 = fadd contract float %add223.6, %mul.i.i.7
  %68 = bitcast float %add223.7 to i32
  %69 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %70 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %69) #11
  %xor.i.i = xor i32 %70, 32
  %71 = and i32 %70, -64
  %and.i.i = add nsw i32 %71, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i495 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %70
  %shl.i.i = shl i32 %cond.i.i495, 2
  %72 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %68)
  %73 = bitcast i32 %72 to float
  %add.i = fadd contract float %add223.7, %73
  %74 = bitcast float %add.i to i32
  %75 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %76 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %75) #11
  %xor.i.i496 = xor i32 %76, 16
  %77 = and i32 %76, -64
  %and.i.i497 = add nsw i32 %77, 64
  %cmp.not.i.i498 = icmp slt i32 %xor.i.i496, %and.i.i497
  %cond.i.i499 = select i1 %cmp.not.i.i498, i32 %xor.i.i496, i32 %76
  %shl.i.i500 = shl i32 %cond.i.i499, 2
  %78 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i500, i32 %74)
  %79 = bitcast i32 %78 to float
  %add.i.i = fadd contract float %add.i, %79
  %cmp232 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_1.0 = select i1 %cmp232, float %div, float 0.000000e+00
  %mul245 = fmul contract float %condval_1.0, %mul.i.i
  %mul245.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul245.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul245.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %mul245.4 = fmul contract float %condval_1.0, %mul.i.i.4
  %mul245.5 = fmul contract float %condval_1.0, %mul.i.i.5
  %mul245.6 = fmul contract float %condval_1.0, %mul.i.i.6
  %mul245.7 = fmul contract float %condval_1.0, %mul.i.i.7
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245)
  %81 = insertelement <4 x i16> poison, i16 %80, i64 0
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.1)
  %83 = insertelement <4 x i16> %81, i16 %82, i64 1
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.2)
  %85 = insertelement <4 x i16> %83, i16 %84, i64 2
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.3)
  %87 = insertelement <4 x i16> %85, i16 %86, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %87 to <4 x half>
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.4)
  %89 = insertelement <4 x i16> poison, i16 %88, i64 0
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.5)
  %91 = insertelement <4 x i16> %89, i16 %90, i64 1
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.6)
  %93 = insertelement <4 x i16> %91, i16 %92, i64 2
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul245.7)
  %95 = insertelement <4 x i16> %93, i16 %94, i64 3
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %95 to <4 x half>
  br label %if.end273

if.end273:                                        ; preds = %for.cond25.preheader, %land.end
  %v.sroa.25.0 = phi <4 x half> [ %v.sroa.25.112.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.23.0 = phi <4 x half> [ %v.sroa.23.112.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.22.0 = phi <4 x half> [ %v.sroa.22.96.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.20.0 = phi <4 x half> [ %v.sroa.20.96.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.19.0 = phi <4 x half> [ %v.sroa.19.80.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.17.0 = phi <4 x half> [ %v.sroa.17.80.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.16.0 = phi <4 x half> [ %v.sroa.16.64.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.14.0 = phi <4 x half> [ %v.sroa.14.64.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.13.0 = phi <4 x half> [ %v.sroa.13.48.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.11.0 = phi <4 x half> [ %v.sroa.11.48.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.10.0 = phi <4 x half> [ %v.sroa.10.32.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.8.0 = phi <4 x half> [ %v.sroa.8.32.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.7.0 = phi <4 x half> [ %v.sroa.7.16.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.5.0 = phi <4 x half> [ %v.sroa.5.16.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.4.0 = phi <4 x half> [ %v.sroa.4.0.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %v.sroa.0.0 = phi <4 x half> [ %v.sroa.0.0.copyload, %for.cond25.preheader ], [ undef, %land.end ]
  %prob.sroa.7.0 = phi <4 x half> [ %prob.sroa.7.14.vec.insert, %for.cond25.preheader ], [ undef, %land.end ]
  %prob.sroa.0.0 = phi <4 x half> [ %prob.sroa.0.6.vec.insert, %for.cond25.preheader ], [ undef, %land.end ]
  br i1 %20, label %for.cond293.preheader.preheader, label %if.end317

for.cond293.preheader.preheader:                  ; preds = %if.end273
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.4.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.5.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.10.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.11.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.13.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer)
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.0, <4 x half> %prob.sroa.7.0, <4 x float> %96)
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.0, <4 x half> %prob.sroa.7.0, <4 x float> %97)
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.0, <4 x half> %prob.sroa.7.0, <4 x float> %98)
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.19.0, <4 x half> %prob.sroa.7.0, <4 x float> %99)
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.0, <4 x half> %prob.sroa.7.0, <4 x float> %100)
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.22.0, <4 x half> %prob.sroa.7.0, <4 x float> %101)
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.0, <4 x half> %prob.sroa.7.0, <4 x float> %102)
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.25.0, <4 x half> %prob.sroa.7.0, <4 x float> %103)
  br label %if.end317

if.end317:                                        ; preds = %for.cond293.preheader.preheader, %if.end273
  %out.sroa.86.0 = phi <4 x float> [ %111, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.74.0 = phi <4 x float> [ %110, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.62.0 = phi <4 x float> [ %109, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.50.0 = phi <4 x float> [ %108, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.38.0 = phi <4 x float> [ %107, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.26.0 = phi <4 x float> [ %106, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.14.0 = phi <4 x float> [ %105, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.0.0 = phi <4 x float> [ %104, %for.cond293.preheader.preheader ], [ zeroinitializer, %if.end273 ]
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %112 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %113 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %114 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %115 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert, %output_reg.sroa.0.6.insert.shift
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 0
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract)
  %output_reg.sroa.7.8.insert.ext = zext i16 %116 to i64
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 1
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract)
  %output_reg.sroa.7.10.insert.ext = zext i16 %117 to i64
  %output_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.7.10.insert.ext, 16
  %output_reg.sroa.7.10.insert.insert = or disjoint i64 %output_reg.sroa.7.10.insert.shift, %output_reg.sroa.7.8.insert.ext
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 2
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract)
  %output_reg.sroa.7.12.insert.ext = zext i16 %118 to i64
  %output_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.7.12.insert.ext, 32
  %output_reg.sroa.7.12.insert.insert = or disjoint i64 %output_reg.sroa.7.10.insert.insert, %output_reg.sroa.7.12.insert.shift
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %out.sroa.14.0, i64 3
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract)
  %output_reg.sroa.7.14.insert.ext = zext i16 %119 to i64
  %output_reg.sroa.7.14.insert.shift = shl nuw i64 %output_reg.sroa.7.14.insert.ext, 48
  %output_reg.sroa.7.14.insert.insert = or disjoint i64 %output_reg.sroa.7.12.insert.insert, %output_reg.sroa.7.14.insert.shift
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 0
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract)
  %output_reg.sroa.12.16.insert.ext = zext i16 %120 to i64
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 1
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract)
  %output_reg.sroa.12.18.insert.ext = zext i16 %121 to i64
  %output_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.18.insert.ext, 16
  %output_reg.sroa.12.18.insert.insert = or disjoint i64 %output_reg.sroa.12.18.insert.shift, %output_reg.sroa.12.16.insert.ext
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 2
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract)
  %output_reg.sroa.12.20.insert.ext = zext i16 %122 to i64
  %output_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.20.insert.ext, 32
  %output_reg.sroa.12.20.insert.insert = or disjoint i64 %output_reg.sroa.12.18.insert.insert, %output_reg.sroa.12.20.insert.shift
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 3
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract)
  %output_reg.sroa.12.22.insert.ext = zext i16 %123 to i64
  %output_reg.sroa.12.22.insert.shift = shl nuw i64 %output_reg.sroa.12.22.insert.ext, 48
  %output_reg.sroa.12.22.insert.insert = or disjoint i64 %output_reg.sroa.12.20.insert.insert, %output_reg.sroa.12.22.insert.shift
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 0
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract)
  %output_reg.sroa.17.24.insert.ext = zext i16 %124 to i64
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 1
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract)
  %output_reg.sroa.17.26.insert.ext = zext i16 %125 to i64
  %output_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.17.26.insert.ext, 16
  %output_reg.sroa.17.26.insert.insert = or disjoint i64 %output_reg.sroa.17.26.insert.shift, %output_reg.sroa.17.24.insert.ext
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract)
  %output_reg.sroa.17.28.insert.ext = zext i16 %126 to i64
  %output_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.17.28.insert.ext, 32
  %output_reg.sroa.17.28.insert.insert = or disjoint i64 %output_reg.sroa.17.26.insert.insert, %output_reg.sroa.17.28.insert.shift
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %out.sroa.38.0, i64 3
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract)
  %output_reg.sroa.17.30.insert.ext = zext i16 %127 to i64
  %output_reg.sroa.17.30.insert.shift = shl nuw i64 %output_reg.sroa.17.30.insert.ext, 48
  %output_reg.sroa.17.30.insert.insert = or disjoint i64 %output_reg.sroa.17.28.insert.insert, %output_reg.sroa.17.30.insert.shift
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 0
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract)
  %output_reg.sroa.22.32.insert.ext = zext i16 %128 to i64
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 1
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract)
  %output_reg.sroa.22.34.insert.ext = zext i16 %129 to i64
  %output_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.34.insert.ext, 16
  %output_reg.sroa.22.34.insert.insert = or disjoint i64 %output_reg.sroa.22.34.insert.shift, %output_reg.sroa.22.32.insert.ext
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 2
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract)
  %output_reg.sroa.22.36.insert.ext = zext i16 %130 to i64
  %output_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.36.insert.ext, 32
  %output_reg.sroa.22.36.insert.insert = or disjoint i64 %output_reg.sroa.22.34.insert.insert, %output_reg.sroa.22.36.insert.shift
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 3
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract)
  %output_reg.sroa.22.38.insert.ext = zext i16 %131 to i64
  %output_reg.sroa.22.38.insert.shift = shl nuw i64 %output_reg.sroa.22.38.insert.ext, 48
  %output_reg.sroa.22.38.insert.insert = or disjoint i64 %output_reg.sroa.22.36.insert.insert, %output_reg.sroa.22.38.insert.shift
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 0
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract)
  %output_reg.sroa.27.40.insert.ext = zext i16 %132 to i64
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 1
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract)
  %output_reg.sroa.27.42.insert.ext = zext i16 %133 to i64
  %output_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.27.42.insert.ext, 16
  %output_reg.sroa.27.42.insert.insert = or disjoint i64 %output_reg.sroa.27.42.insert.shift, %output_reg.sroa.27.40.insert.ext
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 2
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract)
  %output_reg.sroa.27.44.insert.ext = zext i16 %134 to i64
  %output_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.27.44.insert.ext, 32
  %output_reg.sroa.27.44.insert.insert = or disjoint i64 %output_reg.sroa.27.42.insert.insert, %output_reg.sroa.27.44.insert.shift
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %out.sroa.62.0, i64 3
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract)
  %output_reg.sroa.27.46.insert.ext = zext i16 %135 to i64
  %output_reg.sroa.27.46.insert.shift = shl nuw i64 %output_reg.sroa.27.46.insert.ext, 48
  %output_reg.sroa.27.46.insert.insert = or disjoint i64 %output_reg.sroa.27.44.insert.insert, %output_reg.sroa.27.46.insert.shift
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 0
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract)
  %output_reg.sroa.32.48.insert.ext = zext i16 %136 to i64
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 1
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract)
  %output_reg.sroa.32.50.insert.ext = zext i16 %137 to i64
  %output_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.50.insert.ext, 16
  %output_reg.sroa.32.50.insert.insert = or disjoint i64 %output_reg.sroa.32.50.insert.shift, %output_reg.sroa.32.48.insert.ext
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 2
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract)
  %output_reg.sroa.32.52.insert.ext = zext i16 %138 to i64
  %output_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.52.insert.ext, 32
  %output_reg.sroa.32.52.insert.insert = or disjoint i64 %output_reg.sroa.32.50.insert.insert, %output_reg.sroa.32.52.insert.shift
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 3
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract)
  %output_reg.sroa.32.54.insert.ext = zext i16 %139 to i64
  %output_reg.sroa.32.54.insert.shift = shl nuw i64 %output_reg.sroa.32.54.insert.ext, 48
  %output_reg.sroa.32.54.insert.insert = or disjoint i64 %output_reg.sroa.32.52.insert.insert, %output_reg.sroa.32.54.insert.shift
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 0
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract)
  %output_reg.sroa.37.56.insert.ext = zext i16 %140 to i64
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 1
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract)
  %output_reg.sroa.37.58.insert.ext = zext i16 %141 to i64
  %output_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.58.insert.ext, 16
  %output_reg.sroa.37.58.insert.insert = or disjoint i64 %output_reg.sroa.37.58.insert.shift, %output_reg.sroa.37.56.insert.ext
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 2
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract)
  %output_reg.sroa.37.60.insert.ext = zext i16 %142 to i64
  %output_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.60.insert.ext, 32
  %output_reg.sroa.37.60.insert.insert = or disjoint i64 %output_reg.sroa.37.58.insert.insert, %output_reg.sroa.37.60.insert.shift
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %out.sroa.86.0, i64 3
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract)
  %output_reg.sroa.37.62.insert.ext = zext i16 %143 to i64
  %output_reg.sroa.37.62.insert.shift = shl nuw i64 %output_reg.sroa.37.62.insert.ext, 48
  %output_reg.sroa.37.62.insert.insert = or disjoint i64 %output_reg.sroa.37.60.insert.insert, %output_reg.sroa.37.62.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and350 = shl nuw nsw i32 %2, 7
  %mul351 = and i32 %and350, 1920
  %shr354 = lshr i32 %2, 5
  %and357 = and i32 %2, 15
  %144 = lshr i32 %2, 2
  %mul364 = and i32 %144, 4
  %xor358 = xor i32 %shr354, %and357
  %mul359 = shl nuw nsw i32 %xor358, 3
  %add360 = add nuw nsw i32 %mul359, %mul351
  %add365 = or disjoint i32 %add360, %mul364
  %add.ptr367 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365
  store i64 %output_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr367, align 8
  %add355.1 = add nuw nsw i32 %shr354, 2
  %xor358.1 = xor i32 %add355.1, %and357
  %mul359.1 = shl nuw nsw i32 %xor358.1, 3
  %add360.1 = add nuw nsw i32 %mul359.1, %mul351
  %add365.1 = or disjoint i32 %add360.1, %mul364
  %add.ptr367.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.1
  store i64 %output_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr367.1, align 8
  %add355.2 = add nuw nsw i32 %shr354, 4
  %xor358.2 = xor i32 %add355.2, %and357
  %mul359.2 = shl nuw nsw i32 %xor358.2, 3
  %add360.2 = add nuw nsw i32 %mul359.2, %mul351
  %add365.2 = or disjoint i32 %add360.2, %mul364
  %add.ptr367.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.2
  store i64 %output_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr367.2, align 8
  %add355.3 = add nuw nsw i32 %shr354, 6
  %xor358.3 = xor i32 %add355.3, %and357
  %mul359.3 = shl nuw nsw i32 %xor358.3, 3
  %add360.3 = add nuw nsw i32 %mul359.3, %mul351
  %add365.3 = or disjoint i32 %add360.3, %mul364
  %add.ptr367.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.3
  store i64 %output_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr367.3, align 8
  %add355.4 = add nuw nsw i32 %shr354, 8
  %xor358.4 = xor i32 %add355.4, %and357
  %mul359.4 = shl nuw nsw i32 %xor358.4, 3
  %add360.4 = add nuw nsw i32 %mul359.4, %mul351
  %add365.4 = or disjoint i32 %add360.4, %mul364
  %add.ptr367.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.4
  store i64 %output_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr367.4, align 8
  %add355.5 = add nuw nsw i32 %shr354, 10
  %xor358.5 = xor i32 %add355.5, %and357
  %mul359.5 = shl nuw nsw i32 %xor358.5, 3
  %add360.5 = add nuw nsw i32 %mul359.5, %mul351
  %add365.5 = or disjoint i32 %add360.5, %mul364
  %add.ptr367.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.5
  store i64 %output_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr367.5, align 8
  %add355.6 = add nuw nsw i32 %shr354, 12
  %xor358.6 = xor i32 %add355.6, %and357
  %mul359.6 = shl nuw nsw i32 %xor358.6, 3
  %add360.6 = add nuw nsw i32 %mul359.6, %mul351
  %add365.6 = or disjoint i32 %add360.6, %mul364
  %add.ptr367.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.6
  store i64 %output_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr367.6, align 8
  %add355.7 = add nuw nsw i32 %shr354, 14
  %xor358.7 = xor i32 %add355.7, %and357
  %mul359.7 = shl nuw nsw i32 %xor358.7, 3
  %add360.7 = add nuw nsw i32 %mul359.7, %mul351
  %add365.7 = or disjoint i32 %add360.7, %mul364
  %add.ptr367.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.7
  store i64 %output_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr367.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %145 = shl nuw nsw i32 %2, 3
  %mul378 = and i32 %145, 8064
  %shr384 = lshr i32 %2, 4
  %invariant.gep524 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul378
  %add397 = add nuw nsw i32 %add, %145
  %146 = zext nneg i32 %add397 to i64
  %xor386 = xor i32 %shr384, %and357
  %add.ptr390.idx = shl nuw nsw i32 %xor386, 4
  %add.ptr390 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 %add.ptr390.idx
  %add.ptr402 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390, i64 16, i1 false), !tbaa.struct !27, !call_argsrelate !28
  %147 = add nuw nsw i32 %shr384, 4
  %xor386.1 = xor i32 %147, %and357
  %gep525.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 1024
  %add.ptr390.idx.1 = shl nuw nsw i32 %xor386.1, 4
  %add.ptr390.1 = getelementptr inbounds i8, ptr addrspace(3) %gep525.1, i32 %add.ptr390.idx.1
  %148 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146
  %add.ptr402.1 = getelementptr inbounds i8, ptr addrspace(1) %148, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390.1, i64 16, i1 false), !tbaa.struct !27, !call_argsrelate !28
  %149 = add nuw nsw i32 %shr384, 8
  %xor386.2 = xor i32 %149, %and357
  %gep525.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 2048
  %add.ptr390.idx.2 = shl nuw nsw i32 %xor386.2, 4
  %add.ptr390.2 = getelementptr inbounds i8, ptr addrspace(3) %gep525.2, i32 %add.ptr390.idx.2
  %150 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146
  %add.ptr402.2 = getelementptr inbounds i8, ptr addrspace(1) %150, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390.2, i64 16, i1 false), !tbaa.struct !27, !call_argsrelate !28
  %narrow = add nuw nsw i32 %shr384, 12
  %xor386.3 = xor i32 %narrow, %and357
  %gep525.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep524, i32 3072
  %add.ptr390.idx.3 = shl nuw nsw i32 %xor386.3, 4
  %add.ptr390.3 = getelementptr inbounds i8, ptr addrspace(3) %gep525.3, i32 %add.ptr390.idx.3
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %146
  %add.ptr402.3 = getelementptr inbounds i8, ptr addrspace(1) %151, i64 3072
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr402.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr390.3, i64 16, i1 false), !tbaa.struct !27, !call_argsrelate !28
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

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #9

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #9

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent mustprogress nofree nounwind willreturn memory(none) }
attributes #5 = { mustprogress nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent mustprogress nounwind willreturn }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { mustprogress nounwind willreturn }
attributes #9 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
!26 = !{i32 1, i32 -1, i32 -1}
!27 = !{i64 0, i64 4, !16, i64 4, i64 4, !16, i64 8, i64 4, !16, i64 12, i64 4, !16}
!28 = !{i32 2, i32 -1, i32 -1, i32 -1}
