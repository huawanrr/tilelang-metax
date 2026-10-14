; ModuleID = 'experiments/20261002_goal885/coalesced_block_view_local_43.cpp'
source_filename = "experiments/20261002_goal885/coalesced_block_view_local_43.cpp"
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
  %K_reg = alloca [16 x %struct.__half], align 2, addrspace(5)
  %V_reg = alloca [16 x %struct.__half], align 2, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 32, ptr addrspace(5) %K_reg)
  call void @llvm.lifetime.start.p5(i64 32, ptr addrspace(5) %V_reg)
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
  %or.cond643 = or i1 %cmp34, %cmp37.not
  br i1 %or.cond643, label %if.end323, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul46 = shl nsw i32 %0, 16
  %mul47 = shl nuw nsw i32 %5, 10
  %add48 = or disjoint i32 %mul11, %mul46
  %add50 = add nuw nsw i32 %add48, %mul47
  %6 = zext nneg i32 %add50 to i64
  %add.ptr55 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  call void @llvm.memcpy.p5.p4.i64(ptr addrspace(5) noundef align 16 dereferenceable(16) %K_reg, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr55, i64 16, i1 false), !tbaa.struct !26, !call_argsrelate !27
  %7 = add nuw nsw i64 %6, 512
  %add.ptr55.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %add.ptr59.1 = getelementptr inbounds i8, ptr addrspace(5) %K_reg, i32 16
  call void @llvm.memcpy.p5.p4.i64(ptr addrspace(5) noundef align 16 dereferenceable(16) %add.ptr59.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr55.1, i64 16, i1 false), !tbaa.struct !26, !call_argsrelate !27
  %add.ptr78 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6
  call void @llvm.memcpy.p5.p4.i64(ptr addrspace(5) noundef align 16 dereferenceable(16) %V_reg, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr78, i64 16, i1 false), !tbaa.struct !26, !call_argsrelate !28
  %add.ptr78.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %add.ptr82.1 = getelementptr inbounds i8, ptr addrspace(5) %V_reg, i32 16
  call void @llvm.memcpy.p5.p4.i64(ptr addrspace(5) noundef align 16 dereferenceable(16) %add.ptr82.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr78.1, i64 16, i1 false), !tbaa.struct !26, !call_argsrelate !28
  %mul98 = and i32 %mul11, 8128
  %xor578 = and i32 %mul11, 56
  %call101.masked = and i32 %2, 1016
  %mul103 = xor i32 %xor578, %call101.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul98
  %invariant.gep612 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul103
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep612, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !29
  %gep613.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep613.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !29
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and116 = shl nuw nsw i32 %2, 6
  %mul117 = and i32 %and116, 960
  %shr120 = lshr i32 %2, 4
  %and123 = and i32 %2, 7
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul117
  %xor124 = xor i32 %shr120, %and123
  %add.ptr128.idx = shl nuw nsw i32 %xor124, 4
  %add.ptr128 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 %add.ptr128.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr128, align 16
  %Q_reg.sroa.4.0.add.ptr128.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr128, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr128.sroa_idx, align 8
  %add121.1 = add nuw nsw i32 %shr120, 4
  %xor124.1 = xor i32 %add121.1, %and123
  %add.ptr128.idx.1 = shl nuw nsw i32 %xor124.1, 4
  %add.ptr128.1 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 %add.ptr128.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr128.1, align 16
  %Q_reg.sroa.7.16.add.ptr128.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr128.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr128.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  call void @llvm.memcpy.p3.p5.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep612, ptr addrspace(5) noundef align 16 dereferenceable(16) %K_reg, i64 16, i1 false), !tbaa.struct !26
  call void @llvm.memcpy.p3.p5.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep613.1, ptr addrspace(5) noundef align 16 dereferenceable(16) %add.ptr59.1, i64 16, i1 false), !tbaa.struct !26
  %mul38 = shl nuw nsw i32 %5, 4
  %add164 = or disjoint i32 %mul38, 15
  %cmp165 = icmp ult i32 %1, %add164
  br i1 %cmp165, label %for.cond167.preheader, label %if.end192

for.cond167.preheader:                            ; preds = %if.then
  %9 = lshr i32 %2, 2
  %mul174 = and i32 %9, 252
  %add176 = add nuw nsw i32 %mul38, %mul174
  %cmp179.not = icmp ugt i32 %add176, %1
  %spec.select = select i1 %cmp179.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert686 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp179.not.1.not = icmp ult i32 %add176, %1
  %spec.select.1 = select i1 %cmp179.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert699 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert686, float %spec.select.1, i64 1
  %add177.2 = or disjoint i32 %add176, 2
  %cmp179.not.2 = icmp ugt i32 %add177.2, %1
  %spec.select.2 = select i1 %cmp179.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert712 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert699, float %spec.select.2, i64 2
  %add177.3 = or disjoint i32 %add176, 3
  %cmp179.not.3 = icmp ugt i32 %add177.3, %1
  %spec.select.3 = select i1 %cmp179.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert725 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert712, float %spec.select.3, i64 3
  br label %if.end192

if.end192:                                        ; preds = %if.then, %for.cond167.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert725, %for.cond167.preheader ], [ zeroinitializer, %if.then ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr128, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr128.sroa_idx, align 8
  %10 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0)
  %11 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %10)
  %kb.sroa.0.0.copyload680 = load <4 x half>, ptr addrspace(3) %add.ptr128.1, align 16
  %kb.sroa.6.0.copyload681 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr128.1.sroa_idx, align 8
  %12 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload680, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %11)
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload681, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %12)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr249.idx = shl nuw nsw i32 %2, 4
  %invariant.gep626 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr249.idx
  call void @llvm.memcpy.p3.p5.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep626, ptr addrspace(5) noundef align 16 dereferenceable(16) %V_reg, i64 16, i1 false), !tbaa.struct !26
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 1024
  call void @llvm.memcpy.p3.p5.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep.1, ptr addrspace(5) noundef align 16 dereferenceable(16) %add.ptr82.1, i64 16, i1 false), !tbaa.struct !26
  %acc_s.sroa.0.0.vec.extract688 = extractelement <4 x float> %13, i64 0
  %mul259 = fmul contract float %acc_s.sroa.0.0.vec.extract688, 0x3FC2776C60000000
  %14 = tail call contract noundef float @llvm.minnum.f32(float %mul259, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %14, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %14, %cond.i.i
  %15 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %15
  %acc_s.sroa.0.4.vec.extract701 = extractelement <4 x float> %13, i64 1
  %mul259.1 = fmul contract float %acc_s.sroa.0.4.vec.extract701, 0x3FC2776C60000000
  %16 = tail call contract noundef float @llvm.minnum.f32(float %mul259.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %16, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %16, %cond.i.i.1
  %17 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %17
  %acc_s.sroa.0.8.vec.extract714 = extractelement <4 x float> %13, i64 2
  %mul259.2 = fmul contract float %acc_s.sroa.0.8.vec.extract714, 0x3FC2776C60000000
  %18 = tail call contract noundef float @llvm.minnum.f32(float %mul259.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %18, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %18, %cond.i.i.2
  %19 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %19
  %acc_s.sroa.0.12.vec.extract727 = extractelement <4 x float> %13, i64 3
  %mul259.3 = fmul contract float %acc_s.sroa.0.12.vec.extract727, 0x3FC2776C60000000
  %20 = tail call contract noundef float @llvm.minnum.f32(float %mul259.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %20, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %20, %cond.i.i.3
  %21 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %21
  %add275 = fadd contract float %mul.i.i, 0.000000e+00
  %add275.1 = fadd contract float %add275, %mul.i.i.1
  %add275.2 = fadd contract float %add275.1, %mul.i.i.2
  %add275.3 = fadd contract float %add275.2, %mul.i.i.3
  %22 = bitcast float %add275.3 to i32
  %23 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12
  %24 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %23) #12
  %xor.i.i = xor i32 %24, 32
  %25 = and i32 %24, -64
  %and.i.i = add nsw i32 %25, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i580 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %24
  %shl.i.i = shl i32 %cond.i.i580, 2
  %26 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %22)
  %27 = bitcast i32 %26 to float
  %add283 = fadd contract float %add275.3, %27
  %28 = bitcast float %add283 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #12
  %xor.i.i581 = xor i32 %30, 16
  %31 = and i32 %30, -64
  %and.i.i582 = add nsw i32 %31, 64
  %cmp.not.i.i583 = icmp slt i32 %xor.i.i581, %and.i.i582
  %cond.i.i584 = select i1 %cmp.not.i.i583, i32 %xor.i.i581, i32 %30
  %shl.i.i585 = shl i32 %cond.i.i584, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i585, i32 %28)
  %33 = bitcast i32 %32 to float
  %add288 = fadd contract float %add283, %33
  %cmp291 = fcmp contract ogt float %add288, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add288
  %condval_1.0 = select i1 %cmp291, float %div, float 0.000000e+00
  %mul304 = fmul contract float %condval_1.0, %mul.i.i
  %mul304.1 = fmul contract float %condval_1.0, %mul.i.i.1
  %mul304.2 = fmul contract float %condval_1.0, %mul.i.i.2
  %mul304.3 = fmul contract float %condval_1.0, %mul.i.i.3
  %34 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !30
  %35 = fptrunc float %mul304 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %34), !noalias !30
  %36 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !30
  %37 = fptrunc float %mul304.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %36), !noalias !30
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %35, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %37, i64 1
  %38 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !35
  %39 = fptrunc float %mul304.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %38), !noalias !35
  %40 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !35
  %41 = fptrunc float %mul304.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %40), !noalias !35
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %39, i64 2
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %41, i64 3
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end323

if.end323:                                        ; preds = %if.end192, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %if.end192 ], [ undef, %entry ]
  br i1 %or.cond643, label %if.end393, label %for.cond345.preheader

for.cond345.preheader:                            ; preds = %if.end323
  %42 = shl nuw nsw i32 %2, 4
  %mul355 = and i32 %42, 16128
  %and361 = and i32 %2, 15
  %add362 = or disjoint i32 %mul355, %and361
  %arrayidx364 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362
  %43 = load half, ptr addrspace(3) %arrayidx364, align 2, !tbaa !40
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %43, i64 0
  %add357.1 = or disjoint i32 %mul355, %and361
  %add362.1 = or disjoint i32 %add357.1, 64
  %arrayidx364.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.1
  %44 = load half, ptr addrspace(3) %arrayidx364.1, align 2, !tbaa !40
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %44, i64 1
  %add357.2 = or disjoint i32 %mul355, %and361
  %add362.2 = or disjoint i32 %add357.2, 128
  %arrayidx364.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.2
  %45 = load half, ptr addrspace(3) %arrayidx364.2, align 2, !tbaa !40
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %45, i64 2
  %add357.3 = or disjoint i32 %mul355, %and361
  %add362.3 = or disjoint i32 %add357.3, 192
  %arrayidx364.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.3
  %46 = load half, ptr addrspace(3) %arrayidx364.3, align 2, !tbaa !40
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %46, i64 3
  %add359.1660 = or disjoint i32 %mul355, %and361
  %add362.1661 = or disjoint i32 %add359.1660, 16
  %arrayidx364.1662 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.1661
  %47 = load half, ptr addrspace(3) %arrayidx364.1662, align 2, !tbaa !40
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %47, i64 0
  %add359.1.1 = or disjoint i32 %mul355, %and361
  %add362.1.1 = or disjoint i32 %add359.1.1, 80
  %arrayidx364.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.1.1
  %48 = load half, ptr addrspace(3) %arrayidx364.1.1, align 2, !tbaa !40
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %48, i64 1
  %add359.2.1 = or disjoint i32 %mul355, %and361
  %add362.2.1 = or disjoint i32 %add359.2.1, 144
  %arrayidx364.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.2.1
  %49 = load half, ptr addrspace(3) %arrayidx364.2.1, align 2, !tbaa !40
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %49, i64 2
  %add359.3.1 = or disjoint i32 %mul355, %and361
  %add362.3.1 = or disjoint i32 %add359.3.1, 208
  %arrayidx364.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.3.1
  %50 = load half, ptr addrspace(3) %arrayidx364.3.1, align 2, !tbaa !40
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %50, i64 3
  %add359.2664 = or disjoint i32 %mul355, %and361
  %add362.2665 = or disjoint i32 %add359.2664, 32
  %arrayidx364.2666 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.2665
  %51 = load half, ptr addrspace(3) %arrayidx364.2666, align 2, !tbaa !40
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %51, i64 0
  %add359.1.2 = or disjoint i32 %mul355, %and361
  %add362.1.2 = or disjoint i32 %add359.1.2, 96
  %arrayidx364.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.1.2
  %52 = load half, ptr addrspace(3) %arrayidx364.1.2, align 2, !tbaa !40
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %52, i64 1
  %add359.2.2 = or disjoint i32 %mul355, %and361
  %add362.2.2 = or disjoint i32 %add359.2.2, 160
  %arrayidx364.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.2.2
  %53 = load half, ptr addrspace(3) %arrayidx364.2.2, align 2, !tbaa !40
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %53, i64 2
  %add359.3.2 = or disjoint i32 %mul355, %and361
  %add362.3.2 = or disjoint i32 %add359.3.2, 224
  %arrayidx364.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.3.2
  %54 = load half, ptr addrspace(3) %arrayidx364.3.2, align 2, !tbaa !40
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %54, i64 3
  %add359.3668 = or disjoint i32 %mul355, %and361
  %add362.3669 = or disjoint i32 %add359.3668, 48
  %arrayidx364.3670 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.3669
  %55 = load half, ptr addrspace(3) %arrayidx364.3670, align 2, !tbaa !40
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %55, i64 0
  %add359.1.3 = or disjoint i32 %mul355, %and361
  %add362.1.3 = or disjoint i32 %add359.1.3, 112
  %arrayidx364.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.1.3
  %56 = load half, ptr addrspace(3) %arrayidx364.1.3, align 2, !tbaa !40
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %56, i64 1
  %add359.2.3 = or disjoint i32 %mul355, %and361
  %add362.2.3 = or disjoint i32 %add359.2.3, 176
  %arrayidx364.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.2.3
  %57 = load half, ptr addrspace(3) %arrayidx364.2.3, align 2, !tbaa !40
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %57, i64 2
  %add359.3.3 = or disjoint i32 %42, %and361
  %add362.3.3 = or i32 %add359.3.3, 240
  %arrayidx364.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add362.3.3
  %58 = load half, ptr addrspace(3) %arrayidx364.3.3, align 2, !tbaa !40
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %58, i64 3
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end393

if.end393:                                        ; preds = %for.cond345.preheader, %if.end323
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end323 ], [ %59, %for.cond345.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end323 ], [ %60, %for.cond345.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end323 ], [ %61, %for.cond345.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end323 ], [ %62, %for.cond345.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %63 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %64 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %63), !noalias !41
  %65 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %66 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %65), !noalias !41
  %67 = bitcast half %64 to i16
  %68 = bitcast half %66 to i16
  %69 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %70 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %69), !noalias !46
  %71 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %72 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %71), !noalias !46
  %73 = bitcast half %70 to i16
  %74 = bitcast half %72 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %74 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %73 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %68 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %67 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %75 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %76 = fptrunc float %acc_o.sroa.16.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %75), !noalias !41
  %77 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %78 = fptrunc float %acc_o.sroa.16.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %77), !noalias !41
  %79 = bitcast half %76 to i16
  %80 = bitcast half %78 to i16
  %81 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %82 = fptrunc float %acc_o.sroa.16.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %81), !noalias !46
  %83 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %84 = fptrunc float %acc_o.sroa.16.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %83), !noalias !46
  %85 = bitcast half %82 to i16
  %86 = bitcast half %84 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %86 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %85 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %80 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %79 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %88 = fptrunc float %acc_o.sroa.30.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !noalias !41
  %89 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %90 = fptrunc float %acc_o.sroa.30.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %89), !noalias !41
  %91 = bitcast half %88 to i16
  %92 = bitcast half %90 to i16
  %93 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %94 = fptrunc float %acc_o.sroa.30.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %93), !noalias !46
  %95 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %96 = fptrunc float %acc_o.sroa.30.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %95), !noalias !46
  %97 = bitcast half %94 to i16
  %98 = bitcast half %96 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %98 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %97 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %92 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %91 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %99 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %100 = fptrunc float %acc_o.sroa.44.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %99), !noalias !41
  %101 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !41
  %102 = fptrunc float %acc_o.sroa.44.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %101), !noalias !41
  %103 = bitcast half %100 to i16
  %104 = bitcast half %102 to i16
  %105 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %106 = fptrunc float %acc_o.sroa.44.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %105), !noalias !46
  %107 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !46
  %108 = fptrunc float %acc_o.sroa.44.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %107), !noalias !46
  %109 = bitcast half %106 to i16
  %110 = bitcast half %108 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %110 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %109 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %104 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %103 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and428 = shl nuw nsw i32 %2, 6
  %mul429 = and i32 %and428, 960
  %shr432 = lshr i32 %2, 5
  %and435 = and i32 %2, 7
  %111 = lshr i32 %2, 2
  %mul442 = and i32 %111, 4
  %xor436 = xor i32 %shr432, %and435
  %mul437 = shl nuw nsw i32 %xor436, 3
  %add438 = add nuw nsw i32 %mul437, %mul429
  %add443 = or disjoint i32 %add438, %mul442
  %add.ptr445 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(3) %add.ptr445, align 8
  %add433.1 = add nuw nsw i32 %shr432, 2
  %xor436.1 = xor i32 %add433.1, %and435
  %mul437.1 = shl nuw nsw i32 %xor436.1, 3
  %add438.1 = add nuw nsw i32 %mul437.1, %mul429
  %add443.1 = or disjoint i32 %add438.1, %mul442
  %add.ptr445.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443.1
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(3) %add.ptr445.1, align 8
  %add433.2 = add nuw nsw i32 %shr432, 4
  %xor436.2 = xor i32 %add433.2, %and435
  %mul437.2 = shl nuw nsw i32 %xor436.2, 3
  %add438.2 = add nuw nsw i32 %mul437.2, %mul429
  %add443.2 = or disjoint i32 %add438.2, %mul442
  %add.ptr445.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443.2
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(3) %add.ptr445.2, align 8
  %add433.3 = add nuw nsw i32 %shr432, 6
  %xor436.3 = xor i32 %add433.3, %and435
  %mul437.3 = shl nuw nsw i32 %xor436.3, 3
  %add438.3 = add nuw nsw i32 %mul437.3, %mul429
  %add443.3 = or disjoint i32 %add438.3, %mul442
  %add.ptr445.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443.3
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(3) %add.ptr445.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul456 = and i32 %mul11, 8128
  %xor462574 = and i32 %mul11, 56
  %call460.masked = and i32 %2, 1016
  %mul463 = xor i32 %xor462574, %call460.masked
  %invariant.gep638 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul456
  %invariant.gep640 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep638, i32 %mul463
  %add.ptr478 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr478, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep640, i64 16, i1 false), !tbaa.struct !26, !call_argsrelate !51
  %gep641.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 1024
  %add.ptr478.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr478.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep641.1, i64 16, i1 false), !tbaa.struct !26, !call_argsrelate !51
  call void @llvm.lifetime.end.p5(i64 32, ptr addrspace(5) %V_reg)
  call void @llvm.lifetime.end.p5(i64 32, ptr addrspace(5) %K_reg)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #6

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #6

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #6

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #6

; Function Attrs: convergent mustprogress nounwind willreturn
declare void @llvm.mxc.barrier.warp() #7

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #5

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #5

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #5

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #6

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #6

; Function Attrs: mustprogress nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #6

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #9

; Function Attrs: mustprogress nofree nounwind speculatable willreturn memory(inaccessiblemem: read)
declare i32 @llvm.mxc.gethwreg(i32 immarg) #10

; Function Attrs: mustprogress nounwind willreturn
declare void @llvm.mxc.sethwreg(i32 immarg, i32) #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #9

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p5.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(5) noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p5.p4.i64(ptr addrspace(5) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #11

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent mustprogress nofree nounwind willreturn memory(none) }
attributes #6 = { mustprogress nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { convergent mustprogress nounwind willreturn }
attributes #8 = { mustprogress nounwind willreturn }
attributes #9 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { mustprogress nofree nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #11 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #12 = { nomerge }

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
!26 = !{i64 0, i64 4, !16, i64 4, i64 4, !16, i64 8, i64 4, !16, i64 12, i64 4, !16}
!27 = !{i32 -1, i32 1, i32 -1, i32 -1}
!28 = !{i32 -1, i32 4, i32 -1, i32 -1}
!29 = !{i32 -1, i32 3, i32 -1, i32 -1}
!30 = !{!31, !33}
!31 = distinct !{!31, !32, !"_ZL17__floats2half2_rnff: %agg.result"}
!32 = distinct !{!32, !"_ZL17__floats2half2_rnff"}
!33 = distinct !{!33, !34, !"_ZL17__float22half2_rn6float2: %agg.result"}
!34 = distinct !{!34, !"_ZL17__float22half2_rn6float2"}
!35 = !{!36, !38}
!36 = distinct !{!36, !37, !"_ZL17__floats2half2_rnff: %agg.result"}
!37 = distinct !{!37, !"_ZL17__floats2half2_rnff"}
!38 = distinct !{!38, !39, !"_ZL17__float22half2_rn6float2: %agg.result"}
!39 = distinct !{!39, !"_ZL17__float22half2_rn6float2"}
!40 = !{!11, !11, i64 0}
!41 = !{!42, !44}
!42 = distinct !{!42, !43, !"_ZL17__floats2half2_rnff: %agg.result"}
!43 = distinct !{!43, !"_ZL17__floats2half2_rnff"}
!44 = distinct !{!44, !45, !"_ZL17__float22half2_rn6float2: %agg.result"}
!45 = distinct !{!45, !"_ZL17__float22half2_rn6float2"}
!46 = !{!47, !49}
!47 = distinct !{!47, !48, !"_ZL17__floats2half2_rnff: %agg.result"}
!48 = distinct !{!48, !"_ZL17__floats2half2_rnff"}
!49 = distinct !{!49, !50, !"_ZL17__float22half2_rn6float2: %agg.result"}
!50 = distinct !{!50, !"_ZL17__float22half2_rn6float2"}
!51 = !{i32 2, i32 -1, i32 -1, i32 -1}
