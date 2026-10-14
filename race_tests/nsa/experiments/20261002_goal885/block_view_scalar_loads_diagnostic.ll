; ModuleID = 'experiments/20261002_goal885/block_view_scalar_loads_diagnostic.cpp'
source_filename = "experiments/20261002_goal885/block_view_scalar_loads_diagnostic.cpp"
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
  %mul = shl nsw i32 %0, 20
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !15
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !25
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %4 = add nuw nsw i64 %3, 512
  %mul17 = shl nsw i32 %0, 10
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !16
  %cmp34 = icmp ugt i32 %5, 63
  %shr = lshr i32 %1, 4
  %cmp37.not = icmp ugt i32 %5, %shr
  %or.cond668 = or i1 %cmp34, %cmp37.not
  br i1 %or.cond668, label %if.end340, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul50 = shl nsw i32 %0, 16
  %mul51 = shl nuw nsw i32 %5, 10
  %add52 = or disjoint i32 %mul11, %mul50
  %add54 = add nuw nsw i32 %add52, %mul51
  %6 = zext nneg i32 %add54 to i64
  %add.ptr59 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %arrayidx61.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr59, i64 4
  %arrayidx61.4 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr59, i64 8
  %arrayidx61.6 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr59, i64 12
  %7 = add nuw nsw i64 %6, 512
  %add.ptr59.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %arrayidx61.2.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr59.1, i64 4
  %arrayidx61.4.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr59.1, i64 8
  %arrayidx61.6.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr59.1, i64 12
  %add.ptr93 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6
  %8 = load <2 x i16>, ptr addrspace(4) %add.ptr93, align 2, !tbaa !26
  %arrayidx95.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 4
  %9 = load <2 x i16>, ptr addrspace(4) %arrayidx95.2, align 2, !tbaa !26
  %arrayidx95.4 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 8
  %10 = load <2 x i16>, ptr addrspace(4) %arrayidx95.4, align 2, !tbaa !26
  %arrayidx95.6 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 12
  %11 = load <2 x i16>, ptr addrspace(4) %arrayidx95.6, align 2, !tbaa !26
  %add.ptr93.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %12 = load <2 x i16>, ptr addrspace(4) %add.ptr93.1, align 2, !tbaa !26
  %arrayidx95.2.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1, i64 4
  %13 = load <2 x i16>, ptr addrspace(4) %arrayidx95.2.1, align 2, !tbaa !26
  %arrayidx95.4.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1, i64 8
  %14 = load <2 x i16>, ptr addrspace(4) %arrayidx95.4.1, align 2, !tbaa !26
  %arrayidx95.6.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1, i64 12
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx95.6.1, align 2, !tbaa !26
  %mul119 = and i32 %mul11, 8128
  %xor601 = and i32 %mul11, 56
  %call122.masked = and i32 %2, 1016
  %mul124 = xor i32 %xor601, %call122.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul119
  %invariant.gep637 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul124
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep637, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !27
  %gep638.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep638.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !27
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and136 = shl nuw nsw i32 %2, 6
  %mul137 = and i32 %and136, 960
  %shr140 = lshr i32 %2, 4
  %and143 = and i32 %2, 7
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul137
  %xor144 = xor i32 %shr140, %and143
  %add.ptr148.idx = shl nuw nsw i32 %xor144, 4
  %add.ptr148 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr148.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16
  %Q_reg.sroa.4.0.add.ptr148.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8
  %add141.1 = add nuw nsw i32 %shr140, 4
  %xor144.1 = xor i32 %add141.1, %and143
  %add.ptr148.idx.1 = shl nuw nsw i32 %xor144.1, 4
  %add.ptr148.1 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr148.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16
  %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %17 = load <2 x i16>, ptr addrspace(4) %add.ptr59, align 2, !tbaa !26
  store <2 x i16> %17, ptr addrspace(3) %invariant.gep637, align 16
  %K_reg.sroa.5.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 4
  %18 = load <2 x i16>, ptr addrspace(4) %arrayidx61.2, align 2, !tbaa !26
  store <2 x i16> %18, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep642.sroa_idx, align 4
  %K_reg.sroa.7.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 8
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx61.4, align 2, !tbaa !26
  store <2 x i16> %19, ptr addrspace(3) %K_reg.sroa.7.0.invariant.gep642.sroa_idx, align 8
  %K_reg.sroa.9.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 12
  %20 = load <2 x i16>, ptr addrspace(4) %arrayidx61.6, align 2, !tbaa !26
  store <2 x i16> %20, ptr addrspace(3) %K_reg.sroa.9.0.invariant.gep642.sroa_idx, align 4
  %21 = load <2 x i16>, ptr addrspace(4) %add.ptr59.1, align 2, !tbaa !26
  store <2 x i16> %21, ptr addrspace(3) %gep638.1, align 16
  %K_reg.sroa.14.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1028
  %22 = load <2 x i16>, ptr addrspace(4) %arrayidx61.2.1, align 2, !tbaa !26
  store <2 x i16> %22, ptr addrspace(3) %K_reg.sroa.14.16.gep643.1.sroa_idx, align 4
  %K_reg.sroa.16.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1032
  %23 = load <2 x i16>, ptr addrspace(4) %arrayidx61.4.1, align 2, !tbaa !26
  store <2 x i16> %23, ptr addrspace(3) %K_reg.sroa.16.16.gep643.1.sroa_idx, align 8
  %K_reg.sroa.18.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1036
  %24 = load <2 x i16>, ptr addrspace(4) %arrayidx61.6.1, align 2, !tbaa !26
  store <2 x i16> %24, ptr addrspace(3) %K_reg.sroa.18.16.gep643.1.sroa_idx, align 4
  %mul38 = shl nuw nsw i32 %5, 4
  %add183 = or disjoint i32 %mul38, 15
  %cmp184 = icmp ult i32 %1, %add183
  br i1 %cmp184, label %for.cond186.preheader, label %if.end210

for.cond186.preheader:                            ; preds = %if.then
  %25 = lshr i32 %2, 2
  %mul192 = and i32 %25, 252
  %add194 = add nuw nsw i32 %mul38, %mul192
  %cmp197.not = icmp ugt i32 %add194, %1
  %spec.select = select i1 %cmp197.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert713 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp197.not.1.not = icmp ult i32 %add194, %1
  %spec.select.1 = select i1 %cmp197.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert726 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert713, float %spec.select.1, i64 1
  %add195.2 = or disjoint i32 %add194, 2
  %cmp197.not.2 = icmp ugt i32 %add195.2, %1
  %spec.select.2 = select i1 %cmp197.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert739 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert726, float %spec.select.2, i64 2
  %add195.3 = or disjoint i32 %add194, 3
  %cmp197.not.3 = icmp ugt i32 %add195.3, %1
  %spec.select.3 = select i1 %cmp197.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert752 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert739, float %spec.select.3, i64 3
  br label %if.end210

if.end210:                                        ; preds = %if.then, %for.cond186.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert752, %for.cond186.preheader ], [ zeroinitializer, %if.then ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0)
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %26)
  %kb.sroa.0.0.copyload707 = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16
  %kb.sroa.6.0.copyload708 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload707, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %27)
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload708, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %28)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr266.idx = shl nuw nsw i32 %2, 4
  %invariant.gep651 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr266.idx
  store <2 x i16> %8, ptr addrspace(3) %invariant.gep651, align 16
  %V_reg.sroa.5.0.invariant.gep651.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 4
  store <2 x i16> %9, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep651.sroa_idx, align 4
  %V_reg.sroa.7.0.invariant.gep651.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 8
  store <2 x i16> %10, ptr addrspace(3) %V_reg.sroa.7.0.invariant.gep651.sroa_idx, align 8
  %V_reg.sroa.9.0.invariant.gep651.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 12
  store <2 x i16> %11, ptr addrspace(3) %V_reg.sroa.9.0.invariant.gep651.sroa_idx, align 4
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 1024
  store <2 x i16> %12, ptr addrspace(3) %gep.1, align 16
  %V_reg.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 1028
  store <2 x i16> %13, ptr addrspace(3) %V_reg.sroa.14.16.gep.1.sroa_idx, align 4
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 1032
  store <2 x i16> %14, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 8
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 1036
  store <2 x i16> %15, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 4
  %acc_s.sroa.0.0.vec.extract715 = extractelement <4 x float> %29, i64 0
  %mul276 = fmul contract float %acc_s.sroa.0.0.vec.extract715, 0x3FC2776C60000000
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul276, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %30, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %30, %cond.i.i
  %31 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %31
  %acc_s.sroa.0.4.vec.extract728 = extractelement <4 x float> %29, i64 1
  %mul276.1 = fmul contract float %acc_s.sroa.0.4.vec.extract728, 0x3FC2776C60000000
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul276.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %32, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %32, %cond.i.i.1
  %33 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %33
  %acc_s.sroa.0.8.vec.extract741 = extractelement <4 x float> %29, i64 2
  %mul276.2 = fmul contract float %acc_s.sroa.0.8.vec.extract741, 0x3FC2776C60000000
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul276.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %34, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %34, %cond.i.i.2
  %35 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %35
  %acc_s.sroa.0.12.vec.extract754 = extractelement <4 x float> %29, i64 3
  %mul276.3 = fmul contract float %acc_s.sroa.0.12.vec.extract754, 0x3FC2776C60000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul276.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %36, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %36, %cond.i.i.3
  %37 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %37
  %add292 = fadd contract float %mul.i.i, 0.000000e+00
  %add292.1 = fadd contract float %add292, %mul.i.i.1
  %add292.2 = fadd contract float %add292.1, %mul.i.i.2
  %add292.3 = fadd contract float %add292.2, %mul.i.i.3
  %38 = bitcast float %add292.3 to i32
  %39 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %40 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %39) #11
  %xor.i.i = xor i32 %40, 32
  %41 = and i32 %40, -64
  %and.i.i = add nsw i32 %41, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i603 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %40
  %shl.i.i = shl i32 %cond.i.i603, 2
  %42 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %38)
  %43 = bitcast i32 %42 to float
  %add300 = fadd contract float %add292.3, %43
  %44 = bitcast float %add300 to i32
  %45 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %46 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %45) #11
  %xor.i.i604 = xor i32 %46, 16
  %47 = and i32 %46, -64
  %and.i.i605 = add nsw i32 %47, 64
  %cmp.not.i.i606 = icmp slt i32 %xor.i.i604, %and.i.i605
  %cond.i.i607 = select i1 %cmp.not.i.i606, i32 %xor.i.i604, i32 %46
  %shl.i.i608 = shl i32 %cond.i.i607, 2
  %48 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i608, i32 %44)
  %49 = bitcast i32 %48 to float
  %add305 = fadd contract float %add300, %49
  %cmp308 = fcmp contract ogt float %add305, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add305
  %condval_1.0 = select i1 %cmp308, float %div, float 0.000000e+00
  %mul321 = fmul contract float %condval_1.0, %mul.i.i
  %mul321.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul321.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul321.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %50 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !28
  %51 = fptrunc float %mul321 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %50), !noalias !28
  %52 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !28
  %53 = fptrunc float %mul321.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %52), !noalias !28
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %51, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %53, i64 1
  %54 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !33
  %55 = fptrunc float %mul321.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %54), !noalias !33
  %56 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !33
  %57 = fptrunc float %mul321.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %56), !noalias !33
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %55, i64 2
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %57, i64 3
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end340

if.end340:                                        ; preds = %if.end210, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %if.end210 ], [ undef, %entry ]
  br i1 %or.cond668, label %if.end410, label %for.cond362.preheader

for.cond362.preheader:                            ; preds = %if.end340
  %58 = shl nuw nsw i32 %2, 4
  %mul372 = and i32 %58, 16128
  %and378 = and i32 %2, 15
  %add379 = or disjoint i32 %mul372, %and378
  %arrayidx381 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379
  %59 = load half, ptr addrspace(3) %arrayidx381, align 2, !tbaa !26
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %59, i64 0
  %add374.1 = or disjoint i32 %mul372, %and378
  %add379.1 = or disjoint i32 %add374.1, 64
  %arrayidx381.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.1
  %60 = load half, ptr addrspace(3) %arrayidx381.1, align 2, !tbaa !26
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %60, i64 1
  %add374.2 = or disjoint i32 %mul372, %and378
  %add379.2 = or disjoint i32 %add374.2, 128
  %arrayidx381.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.2
  %61 = load half, ptr addrspace(3) %arrayidx381.2, align 2, !tbaa !26
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %61, i64 2
  %add374.3 = or disjoint i32 %mul372, %and378
  %add379.3 = or disjoint i32 %add374.3, 192
  %arrayidx381.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.3
  %62 = load half, ptr addrspace(3) %arrayidx381.3, align 2, !tbaa !26
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %62, i64 3
  %add376.1687 = or disjoint i32 %mul372, %and378
  %add379.1688 = or disjoint i32 %add376.1687, 16
  %arrayidx381.1689 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.1688
  %63 = load half, ptr addrspace(3) %arrayidx381.1689, align 2, !tbaa !26
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %63, i64 0
  %add376.1.1 = or disjoint i32 %mul372, %and378
  %add379.1.1 = or disjoint i32 %add376.1.1, 80
  %arrayidx381.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.1.1
  %64 = load half, ptr addrspace(3) %arrayidx381.1.1, align 2, !tbaa !26
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %64, i64 1
  %add376.2.1 = or disjoint i32 %mul372, %and378
  %add379.2.1 = or disjoint i32 %add376.2.1, 144
  %arrayidx381.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.2.1
  %65 = load half, ptr addrspace(3) %arrayidx381.2.1, align 2, !tbaa !26
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %65, i64 2
  %add376.3.1 = or disjoint i32 %mul372, %and378
  %add379.3.1 = or disjoint i32 %add376.3.1, 208
  %arrayidx381.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.3.1
  %66 = load half, ptr addrspace(3) %arrayidx381.3.1, align 2, !tbaa !26
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %66, i64 3
  %add376.2691 = or disjoint i32 %mul372, %and378
  %add379.2692 = or disjoint i32 %add376.2691, 32
  %arrayidx381.2693 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.2692
  %67 = load half, ptr addrspace(3) %arrayidx381.2693, align 2, !tbaa !26
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %67, i64 0
  %add376.1.2 = or disjoint i32 %mul372, %and378
  %add379.1.2 = or disjoint i32 %add376.1.2, 96
  %arrayidx381.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.1.2
  %68 = load half, ptr addrspace(3) %arrayidx381.1.2, align 2, !tbaa !26
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %68, i64 1
  %add376.2.2 = or disjoint i32 %mul372, %and378
  %add379.2.2 = or disjoint i32 %add376.2.2, 160
  %arrayidx381.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.2.2
  %69 = load half, ptr addrspace(3) %arrayidx381.2.2, align 2, !tbaa !26
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %69, i64 2
  %add376.3.2 = or disjoint i32 %mul372, %and378
  %add379.3.2 = or disjoint i32 %add376.3.2, 224
  %arrayidx381.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.3.2
  %70 = load half, ptr addrspace(3) %arrayidx381.3.2, align 2, !tbaa !26
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %70, i64 3
  %add376.3695 = or disjoint i32 %mul372, %and378
  %add379.3696 = or disjoint i32 %add376.3695, 48
  %arrayidx381.3697 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.3696
  %71 = load half, ptr addrspace(3) %arrayidx381.3697, align 2, !tbaa !26
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %71, i64 0
  %add376.1.3 = or disjoint i32 %mul372, %and378
  %add379.1.3 = or disjoint i32 %add376.1.3, 112
  %arrayidx381.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.1.3
  %72 = load half, ptr addrspace(3) %arrayidx381.1.3, align 2, !tbaa !26
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %72, i64 1
  %add376.2.3 = or disjoint i32 %mul372, %and378
  %add379.2.3 = or disjoint i32 %add376.2.3, 176
  %arrayidx381.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.2.3
  %73 = load half, ptr addrspace(3) %arrayidx381.2.3, align 2, !tbaa !26
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %73, i64 2
  %add376.3.3 = or disjoint i32 %58, %and378
  %add379.3.3 = or i32 %add376.3.3, 240
  %arrayidx381.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add379.3.3
  %74 = load half, ptr addrspace(3) %arrayidx381.3.3, align 2, !tbaa !26
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %74, i64 3
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end410

if.end410:                                        ; preds = %for.cond362.preheader, %if.end340
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end340 ], [ %75, %for.cond362.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end340 ], [ %76, %for.cond362.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end340 ], [ %77, %for.cond362.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end340 ], [ %78, %for.cond362.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %79 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %80 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %79), !noalias !38
  %81 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %82 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %81), !noalias !38
  %83 = bitcast half %80 to i16
  %84 = bitcast half %82 to i16
  %85 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %86 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %85), !noalias !43
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %88 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !noalias !43
  %89 = bitcast half %86 to i16
  %90 = bitcast half %88 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %90 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %89 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %84 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %83 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %91 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %92 = fptrunc float %acc_o.sroa.16.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %91), !noalias !38
  %93 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %94 = fptrunc float %acc_o.sroa.16.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %93), !noalias !38
  %95 = bitcast half %92 to i16
  %96 = bitcast half %94 to i16
  %97 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %98 = fptrunc float %acc_o.sroa.16.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %97), !noalias !43
  %99 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %100 = fptrunc float %acc_o.sroa.16.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %99), !noalias !43
  %101 = bitcast half %98 to i16
  %102 = bitcast half %100 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %102 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %101 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %96 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %95 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %103 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %104 = fptrunc float %acc_o.sroa.30.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %103), !noalias !38
  %105 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %106 = fptrunc float %acc_o.sroa.30.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %105), !noalias !38
  %107 = bitcast half %104 to i16
  %108 = bitcast half %106 to i16
  %109 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %110 = fptrunc float %acc_o.sroa.30.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %109), !noalias !43
  %111 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %112 = fptrunc float %acc_o.sroa.30.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %111), !noalias !43
  %113 = bitcast half %110 to i16
  %114 = bitcast half %112 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %114 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %113 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %108 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %107 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %115 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %116 = fptrunc float %acc_o.sroa.44.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %115), !noalias !38
  %117 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !38
  %118 = fptrunc float %acc_o.sroa.44.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %117), !noalias !38
  %119 = bitcast half %116 to i16
  %120 = bitcast half %118 to i16
  %121 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %122 = fptrunc float %acc_o.sroa.44.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %121), !noalias !43
  %123 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !43
  %124 = fptrunc float %acc_o.sroa.44.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %123), !noalias !43
  %125 = bitcast half %122 to i16
  %126 = bitcast half %124 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %126 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %125 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %120 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %119 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and445 = shl nuw nsw i32 %2, 6
  %mul446 = and i32 %and445, 960
  %shr449 = lshr i32 %2, 5
  %and452 = and i32 %2, 7
  %127 = lshr i32 %2, 2
  %mul459 = and i32 %127, 4
  %xor453 = xor i32 %shr449, %and452
  %mul454 = shl nuw nsw i32 %xor453, 3
  %add455 = add nuw nsw i32 %mul454, %mul446
  %add460 = or disjoint i32 %add455, %mul459
  %add.ptr462 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(3) %add.ptr462, align 8
  %add450.1 = add nuw nsw i32 %shr449, 2
  %xor453.1 = xor i32 %add450.1, %and452
  %mul454.1 = shl nuw nsw i32 %xor453.1, 3
  %add455.1 = add nuw nsw i32 %mul454.1, %mul446
  %add460.1 = or disjoint i32 %add455.1, %mul459
  %add.ptr462.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.1
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(3) %add.ptr462.1, align 8
  %add450.2 = add nuw nsw i32 %shr449, 4
  %xor453.2 = xor i32 %add450.2, %and452
  %mul454.2 = shl nuw nsw i32 %xor453.2, 3
  %add455.2 = add nuw nsw i32 %mul454.2, %mul446
  %add460.2 = or disjoint i32 %add455.2, %mul459
  %add.ptr462.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.2
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(3) %add.ptr462.2, align 8
  %add450.3 = add nuw nsw i32 %shr449, 6
  %xor453.3 = xor i32 %add450.3, %and452
  %mul454.3 = shl nuw nsw i32 %xor453.3, 3
  %add455.3 = add nuw nsw i32 %mul454.3, %mul446
  %add460.3 = or disjoint i32 %add455.3, %mul459
  %add.ptr462.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.3
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(3) %add.ptr462.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul473 = and i32 %mul11, 8128
  %xor479597 = and i32 %mul11, 56
  %call477.masked = and i32 %2, 1016
  %mul480 = xor i32 %xor479597, %call477.masked
  %invariant.gep663 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul473
  %invariant.gep665 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep663, i32 %mul480
  %add.ptr495 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr495, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep665, i64 16, i1 false), !tbaa.struct !48, !call_argsrelate !49
  %gep666.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep665, i32 1024
  %add.ptr495.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr495.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep666.1, i64 16, i1 false), !tbaa.struct !48, !call_argsrelate !49
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
declare void @llvm.mxc.sleep(i32 immarg) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #8

; Function Attrs: mustprogress nofree nounwind speculatable willreturn memory(inaccessiblemem: read)
declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

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
attributes #7 = { mustprogress nounwind willreturn }
attributes #8 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { mustprogress nofree nounwind speculatable willreturn memory(inaccessiblemem: read) }
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
!26 = !{!11, !11, i64 0}
!27 = !{i32 1, i32 3, i32 -1, i32 -1}
!28 = !{!29, !31}
!29 = distinct !{!29, !30, !"_ZL17__floats2half2_rnff: %agg.result"}
!30 = distinct !{!30, !"_ZL17__floats2half2_rnff"}
!31 = distinct !{!31, !32, !"_ZL17__float22half2_rn6float2: %agg.result"}
!32 = distinct !{!32, !"_ZL17__float22half2_rn6float2"}
!33 = !{!34, !36}
!34 = distinct !{!34, !35, !"_ZL17__floats2half2_rnff: %agg.result"}
!35 = distinct !{!35, !"_ZL17__floats2half2_rnff"}
!36 = distinct !{!36, !37, !"_ZL17__float22half2_rn6float2: %agg.result"}
!37 = distinct !{!37, !"_ZL17__float22half2_rn6float2"}
!38 = !{!39, !41}
!39 = distinct !{!39, !40, !"_ZL17__floats2half2_rnff: %agg.result"}
!40 = distinct !{!40, !"_ZL17__floats2half2_rnff"}
!41 = distinct !{!41, !42, !"_ZL17__float22half2_rn6float2: %agg.result"}
!42 = distinct !{!42, !"_ZL17__float22half2_rn6float2"}
!43 = !{!44, !46}
!44 = distinct !{!44, !45, !"_ZL17__floats2half2_rnff: %agg.result"}
!45 = distinct !{!45, !"_ZL17__floats2half2_rnff"}
!46 = distinct !{!46, !47, !"_ZL17__float22half2_rn6float2: %agg.result"}
!47 = distinct !{!47, !"_ZL17__float22half2_rn6float2"}
!48 = !{i64 0, i64 4, !16, i64 4, i64 4, !16, i64 8, i64 4, !16, i64 12, i64 4, !16}
!49 = !{i32 2, i32 -1, i32 -1, i32 -1}
