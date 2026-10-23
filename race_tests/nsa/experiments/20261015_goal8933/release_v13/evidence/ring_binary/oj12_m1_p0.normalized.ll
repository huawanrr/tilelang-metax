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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Packed.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedK.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 16
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul6 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul6
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %mul8 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul8
  %idx.ext = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext
  %and = shl nuw nsw i32 %2, 7
  %mul19 = and i32 %and, 896
  %shr = and i32 %2, 1016
  %add20 = add nuw nsw i32 %mul19, %shr
  %add23 = add nuw nsw i32 %add20, %add
  %idx.ext24 = zext nneg i32 %add23 to i64
  %add.ptr25 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %idx.ext24
  tail call void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr25, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !65
  %add.ptr35 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idx.ext
  %tile.sroa.0.0.copyload = load i16, ptr addrspace(4) %add.ptr35, align 16
  %tile.sroa.4.0.add.ptr35.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr35, i64 2
  %tile.sroa.4.0.copyload = load i16, ptr addrspace(4) %tile.sroa.4.0.add.ptr35.sroa_idx, align 2, !tbaa !30
  %tile.sroa.5.0.add.ptr35.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr35, i64 4
  %tile.sroa.5.0.copyload = load i16, ptr addrspace(4) %tile.sroa.5.0.add.ptr35.sroa_idx, align 4
  %tile.sroa.6.0.add.ptr35.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr35, i64 6
  %tile.sroa.6.0.copyload = load i16, ptr addrspace(4) %tile.sroa.6.0.add.ptr35.sroa_idx, align 2, !tbaa !30
  %tile.sroa.7.0.add.ptr35.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr35, i64 8
  %tile.sroa.7.0.copyload = load i16, ptr addrspace(4) %tile.sroa.7.0.add.ptr35.sroa_idx, align 8
  %tile.sroa.8.0.add.ptr35.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr35, i64 10
  %tile.sroa.8.0.copyload = load i16, ptr addrspace(4) %tile.sroa.8.0.add.ptr35.sroa_idx, align 2, !tbaa !30
  %tile.sroa.9.0.add.ptr35.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr35, i64 12
  %tile.sroa.9.0.copyload = load i16, ptr addrspace(4) %tile.sroa.9.0.add.ptr35.sroa_idx, align 4
  %tile.sroa.10.0.add.ptr35.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr35, i64 14
  %tile.sroa.10.0.copyload = load i16, ptr addrspace(4) %tile.sroa.10.0.add.ptr35.sroa_idx, align 2, !tbaa !30
  %mul46 = and i32 %and, 512
  %3 = shl nuw nsw i32 %2, 2
  %mul50 = and i32 %3, 3968
  %and53 = shl nuw nsw i32 %2, 6
  %mul54 = and i32 %and53, 64
  %4 = shl nuw nsw i32 %2, 1
  %mul61 = and i32 %4, 4
  %and64 = lshr i32 %2, 3
  %shr65 = and i32 %and64, 3
  %add62 = or disjoint i32 %add, %mul46
  %add47 = add nuw i32 %add62, %mul50
  %add51 = or disjoint i32 %add47, %mul54
  %add55 = or disjoint i32 %add51, %mul61
  %add57 = or disjoint i32 %add55, %shr65
  %idxprom67 = sext i32 %add57 to i64
  %arrayidx68 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67
  store i16 %tile.sroa.0.0.copyload, ptr addrspace(1) %arrayidx68, align 2, !tbaa !70
  %add66.1 = add i32 %add57, 8
  %idxprom67.1 = sext i32 %add66.1 to i64
  %arrayidx68.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67.1
  store i16 %tile.sroa.4.0.copyload, ptr addrspace(1) %arrayidx68.1, align 2, !tbaa !70
  %add66.2 = add i32 %add57, 16
  %idxprom67.2 = sext i32 %add66.2 to i64
  %arrayidx68.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67.2
  store i16 %tile.sroa.5.0.copyload, ptr addrspace(1) %arrayidx68.2, align 2, !tbaa !70
  %add66.3 = add i32 %add57, 24
  %idxprom67.3 = sext i32 %add66.3 to i64
  %arrayidx68.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67.3
  store i16 %tile.sroa.6.0.copyload, ptr addrspace(1) %arrayidx68.3, align 2, !tbaa !70
  %add66.4 = add i32 %add57, 32
  %idxprom67.4 = sext i32 %add66.4 to i64
  %arrayidx68.4 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67.4
  store i16 %tile.sroa.7.0.copyload, ptr addrspace(1) %arrayidx68.4, align 2, !tbaa !70
  %add66.5 = add i32 %add57, 40
  %idxprom67.5 = sext i32 %add66.5 to i64
  %arrayidx68.5 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67.5
  store i16 %tile.sroa.8.0.copyload, ptr addrspace(1) %arrayidx68.5, align 2, !tbaa !70
  %add66.6 = add i32 %add57, 48
  %idxprom67.6 = sext i32 %add66.6 to i64
  %arrayidx68.6 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67.6
  store i16 %tile.sroa.9.0.copyload, ptr addrspace(1) %arrayidx68.6, align 2, !tbaa !70
  %add66.7 = add i32 %add57, 56
  %idxprom67.7 = sext i32 %add66.7 to i64
  %arrayidx68.7 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %idxprom67.7
  store i16 %tile.sroa.10.0.copyload, ptr addrspace(1) %arrayidx68.7, align 2, !tbaa !70
  ret void
}

declare i32 @llvm.mxc.block.id.x() #4

declare i32 @llvm.mxc.block.id.y() #4

declare i32 @llvm.mxc.block.id.z() #4

declare i32 @llvm.mxc.thread.id.x() #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

declare i1 @llvm.mxc.is.private(ptr nocapture) #4

declare void @llvm.mxc.sleep(i32 immarg) #5

declare void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #6

attributes #0 = { mustprogress noreturn nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="128" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind willreturn }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }


