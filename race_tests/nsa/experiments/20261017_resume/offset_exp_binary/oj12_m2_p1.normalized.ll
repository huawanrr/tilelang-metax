target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_flat_offsets.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_flat_offsets.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !call_argsrelate !48
  %cond.i.i1195 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i1195, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i1195.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i1195.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i1195.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i1195.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i1195.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i1195.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i1195.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i1195.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i1195.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i1195.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i1195.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i1195.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i1195.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i1195.7, 4
  %mul20 = shl nsw i32 %0, 20
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %18 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !54
  %and = shl nuw nsw i32 %18, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %19 = lshr i32 %18, 1
  %mul30 = and i32 %19, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %20 = zext nneg i32 %add28 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8
  %conv = zext nneg i32 %0 to i64
  %mul100 = shl nuw nsw i64 %conv, 16
  %22 = shl nuw nsw i32 %18, 3
  %mul110 = zext nneg i32 %22 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_flat_offsets.coerce, i64 %mul110
  %invariant.gep1216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_flat_offsets.coerce, i64 %mul110
  %invariant.op = add nsw i32 %1, -15
  %23 = lshr i32 %18, 2
  %mul265 = and i32 %23, 252
  %or.cond = icmp ugt i32 %mul11, 1023
  %cmp94.not = icmp sgt i32 %mul11, %1
  %or.cond1287 = or i1 %or.cond, %cmp94.not
  br i1 %or.cond1287, label %if.end, label %for.cond95.preheader

for.cond95.preheader:                             ; preds = %entry
  %24 = shl nsw i32 %cond.i.i1195, 10
  %25 = and i32 %24, 64512
  %mul103 = zext nneg i32 %25 to i64
  %add104 = or disjoint i64 %mul100, %mul103
  %26 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add104
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %26, align 16
  %K_reg.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %26, i64 8
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0..sroa_idx, align 8
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %26, i64 1024
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16
  %K_reg.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %26, i64 1032
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.gep.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %for.cond95.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond95.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond95.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond95.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond95.preheader ]
  %or.cond1288 = icmp ugt i32 %mul11.1, 1023
  %cmp125.not = icmp sgt i32 %mul11.1, %1
  %or.cond1289 = or i1 %or.cond1288, %cmp125.not
  br i1 %or.cond1289, label %if.end153, label %for.cond127.preheader

for.cond127.preheader:                            ; preds = %if.end
  %27 = shl nsw i32 %cond.i.i1195.1, 10
  %28 = and i32 %27, 64512
  %mul136 = zext nneg i32 %28 to i64
  %add137 = or disjoint i64 %mul100, %mul136
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add137
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %29, align 16
  %K_reg1.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %29, i64 8
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0..sroa_idx, align 8
  %gep1208.1 = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1024
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep1208.1, align 16
  %K_reg1.sroa.12.16.gep1208.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1032
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.gep1208.1.sroa_idx, align 8
  br label %if.end153

if.end153:                                        ; preds = %for.cond127.preheader, %if.end
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.12.16.copyload, %for.cond127.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.8.16.copyload, %for.cond127.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.6.0.copyload, %for.cond127.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond127.preheader ]
  %or.cond1290 = icmp ugt i32 %mul11.2, 1023
  %cmp159.not = icmp sgt i32 %mul11.2, %1
  %or.cond1291 = or i1 %or.cond1290, %cmp159.not
  br i1 %or.cond1291, label %if.end187, label %for.cond161.preheader

for.cond161.preheader:                            ; preds = %if.end153
  %30 = shl nsw i32 %cond.i.i1195.2, 10
  %31 = and i32 %30, 64512
  %mul170 = zext nneg i32 %31 to i64
  %add171 = or disjoint i64 %mul100, %mul170
  %32 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add171
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %32, align 16
  %K_reg2.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %32, i64 8
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0..sroa_idx, align 8
  %gep1211.1 = getelementptr inbounds i8, ptr addrspace(4) %32, i64 1024
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep1211.1, align 16
  %K_reg2.sroa.12.16.gep1211.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %32, i64 1032
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.gep1211.1.sroa_idx, align 8
  br label %if.end187

if.end187:                                        ; preds = %for.cond161.preheader, %if.end153
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end153 ], [ %K_reg2.sroa.12.16.copyload, %for.cond161.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end153 ], [ %K_reg2.sroa.8.16.copyload, %for.cond161.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end153 ], [ %K_reg2.sroa.6.0.copyload, %for.cond161.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end153 ], [ %K_reg2.sroa.0.0.copyload, %for.cond161.preheader ]
  %or.cond1292 = icmp ugt i32 %mul11.3, 1023
  %cmp193.not = icmp sgt i32 %mul11.3, %1
  %or.cond1293 = or i1 %or.cond1292, %cmp193.not
  br i1 %or.cond1293, label %if.end221, label %for.cond195.preheader

for.cond195.preheader:                            ; preds = %if.end187
  %33 = shl nsw i32 %cond.i.i1195.3, 10
  %34 = and i32 %33, 64512
  %mul204 = zext nneg i32 %34 to i64
  %add205 = or disjoint i64 %mul100, %mul204
  %35 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add205
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %35, align 16
  %K_reg3.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %35, i64 8
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0..sroa_idx, align 8
  %gep1214.1 = getelementptr inbounds i8, ptr addrspace(4) %35, i64 1024
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep1214.1, align 16
  %K_reg3.sroa.12.16.gep1214.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %35, i64 1032
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.gep1214.1.sroa_idx, align 8
  br label %if.end221

if.end221:                                        ; preds = %for.cond195.preheader, %if.end187
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end187 ], [ %K_reg3.sroa.12.16.copyload, %for.cond195.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end187 ], [ %K_reg3.sroa.8.16.copyload, %for.cond195.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end187 ], [ %K_reg3.sroa.6.0.copyload, %for.cond195.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end187 ], [ %K_reg3.sroa.0.0.copyload, %for.cond195.preheader ]
  br i1 %or.cond1287, label %if.end369, label %for.cond229.preheader

for.cond229.preheader:                            ; preds = %if.end221
  %36 = shl nsw i32 %cond.i.i1195, 10
  %37 = and i32 %36, 64512
  %mul238 = zext nneg i32 %37 to i64
  %add239 = or disjoint i64 %mul100, %mul238
  %38 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add239
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %38, align 16
  %V_reg.sroa.18.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %38, i64 8
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx, align 8
  %gep1217.1 = getelementptr inbounds i8, ptr addrspace(4) %38, i64 1024
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %gep1217.1, align 16
  %V_reg.sroa.42.16.gep1217.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %38, i64 1032
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1217.1.sroa_idx, align 8
  %cmp257 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp257, label %for.cond259.preheader, label %if.end282

for.cond259.preheader:                            ; preds = %for.cond229.preheader
  %add266 = add nuw nsw i32 %mul11, %mul265
  %cmp269.not = icmp sgt i32 %add266, %1
  %fneg. = select i1 %cmp269.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1451 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp269.not.1.not = icmp slt i32 %add266, %1
  %fneg..1 = select i1 %cmp269.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1552 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1451, float %fneg..1, i64 1
  %add267.2 = or disjoint i32 %add266, 2
  %cmp269.not.2 = icmp sgt i32 %add267.2, %1
  %fneg..2 = select i1 %cmp269.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1645 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1552, float %fneg..2, i64 2
  %add267.3 = or disjoint i32 %add266, 3
  %cmp269.not.3 = icmp sgt i32 %add267.3, %1
  %fneg..3 = select i1 %cmp269.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1738 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1645, float %fneg..3, i64 3
  br label %if.end282

if.end282:                                        ; preds = %for.cond229.preheader, %for.cond259.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1738, %for.cond259.preheader ], [ zeroinitializer, %for.cond229.preheader ]
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !81
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %39), !call_argsrelate !81
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %40), !call_argsrelate !81
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %41), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %42, i64 0
  %mul317 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul317, float 0x4024CB5EC0000000)
  %44 = tail call contract noundef float @llvm.exp.f32(float %43)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %42, i64 1
  %mul317.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul317.1, float 0x4024CB5EC0000000)
  %46 = tail call contract noundef float @llvm.exp.f32(float %45)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %42, i64 2
  %mul317.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %47 = tail call contract noundef float @llvm.minnum.f32(float %mul317.2, float 0x4024CB5EC0000000)
  %48 = tail call contract noundef float @llvm.exp.f32(float %47)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %42, i64 3
  %mul317.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul317.3, float 0x4024CB5EC0000000)
  %50 = tail call contract noundef float @llvm.exp.f32(float %49)
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %44)
  %52 = insertelement <4 x i16> poison, i16 %51, i64 0
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %46)
  %54 = insertelement <4 x i16> %52, i16 %53, i64 1
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %48)
  %56 = insertelement <4 x i16> %54, i16 %55, i64 2
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %50)
  %58 = insertelement <4 x i16> %56, i16 %57, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %58 to <4 x half>
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !101
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !101
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !101
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !101
  br label %if.end369

if.end369:                                        ; preds = %if.end282, %if.end221
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end221 ], [ %62, %if.end282 ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end221 ], [ %61, %if.end282 ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end221 ], [ %60, %if.end282 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end221 ], [ %59, %if.end282 ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end221 ], [ %50, %if.end282 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end221 ], [ %48, %if.end282 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end221 ], [ %46, %if.end282 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end221 ], [ %44, %if.end282 ]
  br i1 %or.cond1289, label %if.end518, label %for.cond377.preheader

for.cond377.preheader:                            ; preds = %if.end369
  %63 = shl nsw i32 %cond.i.i1195.1, 10
  %64 = and i32 %63, 64512
  %mul386 = zext nneg i32 %64 to i64
  %add387 = or disjoint i64 %mul100, %mul386
  %65 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add387
  %V_reg.sroa.0.0.copyload1823 = load <4 x half>, ptr addrspace(4) %65, align 16
  %V_reg.sroa.18.0..sroa_idx1830 = getelementptr inbounds i8, ptr addrspace(4) %65, i64 8
  %V_reg.sroa.18.0.copyload1831 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx1830, align 8
  %gep1230.1 = getelementptr inbounds i8, ptr addrspace(4) %65, i64 1024
  %V_reg.sroa.26.16.copyload1858 = load <4 x half>, ptr addrspace(4) %gep1230.1, align 16
  %V_reg.sroa.42.16.gep1230.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %65, i64 1032
  %V_reg.sroa.42.16.copyload1865 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1230.1.sroa_idx, align 8
  %cmp405 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp405, label %for.cond407.preheader, label %if.end431

for.cond407.preheader:                            ; preds = %for.cond377.preheader
  %add414 = add nuw nsw i32 %mul11.1, %mul265
  %cmp417.not = icmp sgt i32 %add414, %1
  %fneg.1184 = select i1 %cmp417.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1460 = insertelement <4 x float> poison, float %fneg.1184, i64 0
  %cmp417.not.1.not = icmp slt i32 %add414, %1
  %fneg.1184.1 = select i1 %cmp417.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1561 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1460, float %fneg.1184.1, i64 1
  %add415.2 = or disjoint i32 %add414, 2
  %cmp417.not.2 = icmp sgt i32 %add415.2, %1
  %fneg.1184.2 = select i1 %cmp417.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1654 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1561, float %fneg.1184.2, i64 2
  %add415.3 = or disjoint i32 %add414, 3
  %cmp417.not.3 = icmp sgt i32 %add415.3, %1
  %fneg.1184.3 = select i1 %cmp417.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1747 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1654, float %fneg.1184.3, i64 3
  br label %if.end431

if.end431:                                        ; preds = %for.cond377.preheader, %for.cond407.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1747, %for.cond407.preheader ], [ zeroinitializer, %for.cond377.preheader ]
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !81
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %66), !call_argsrelate !81
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %67), !call_argsrelate !81
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %68), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract1462 = extractelement <4 x float> %69, i64 0
  %mul466 = fmul contract float %acc_s.sroa.0.0.vec.extract1462, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul466, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %acc_s.sroa.0.4.vec.extract1563 = extractelement <4 x float> %69, i64 1
  %mul466.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1563, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul466.1, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %acc_s.sroa.0.8.vec.extract1656 = extractelement <4 x float> %69, i64 2
  %mul466.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1656, 0x3FB99999A0000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul466.2, float 0x4024CB5EC0000000)
  %75 = tail call contract noundef float @llvm.exp.f32(float %74)
  %acc_s.sroa.0.12.vec.extract1749 = extractelement <4 x float> %69, i64 3
  %mul466.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1749, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul466.3, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %add482 = fadd contract float %sum_acc.sroa.0.0, %71
  %add482.1 = fadd contract float %sum_acc.sroa.20.0, %73
  %add482.2 = fadd contract float %sum_acc.sroa.38.0, %75
  %add482.3 = fadd contract float %sum_acc.sroa.56.0, %77
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %79 = insertelement <4 x i16> poison, i16 %78, i64 0
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73)
  %81 = insertelement <4 x i16> %79, i16 %80, i64 1
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75)
  %83 = insertelement <4 x i16> %81, i16 %82, i64 2
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %85 = insertelement <4 x i16> %83, i16 %84, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1423 = bitcast <4 x i16> %85 to <4 x half>
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1823, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> zeroinitializer), !call_argsrelate !101
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1831, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> zeroinitializer), !call_argsrelate !101
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1858, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> zeroinitializer), !call_argsrelate !101
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1865, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1423, <4 x float> zeroinitializer), !call_argsrelate !101
  br label %if.end518

if.end518:                                        ; preds = %if.end431, %if.end369
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end369 ], [ %89, %if.end431 ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end369 ], [ %88, %if.end431 ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end369 ], [ %87, %if.end431 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end369 ], [ %86, %if.end431 ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end369 ], [ %add482.3, %if.end431 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end369 ], [ %add482.2, %if.end431 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end369 ], [ %add482.1, %if.end431 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end369 ], [ %add482, %if.end431 ]
  br i1 %or.cond1291, label %if.end667, label %for.cond526.preheader

for.cond526.preheader:                            ; preds = %if.end518
  %90 = shl nsw i32 %cond.i.i1195.2, 10
  %91 = and i32 %90, 64512
  %mul535 = zext nneg i32 %91 to i64
  %add536 = or disjoint i64 %mul100, %mul535
  %92 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add536
  %V_reg.sroa.0.0.copyload1824 = load <4 x half>, ptr addrspace(4) %92, align 16
  %V_reg.sroa.18.0..sroa_idx1832 = getelementptr inbounds i8, ptr addrspace(4) %92, i64 8
  %V_reg.sroa.18.0.copyload1833 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx1832, align 8
  %gep1244.1 = getelementptr inbounds i8, ptr addrspace(4) %92, i64 1024
  %V_reg.sroa.26.16.copyload1859 = load <4 x half>, ptr addrspace(4) %gep1244.1, align 16
  %V_reg.sroa.42.16.gep1244.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %92, i64 1032
  %V_reg.sroa.42.16.copyload1866 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1244.1.sroa_idx, align 8
  %cmp554 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp554, label %for.cond556.preheader, label %if.end580

for.cond556.preheader:                            ; preds = %for.cond526.preheader
  %add563 = add nuw nsw i32 %mul11.2, %mul265
  %cmp566.not = icmp sgt i32 %add563, %1
  %fneg.1185 = select i1 %cmp566.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1470 = insertelement <4 x float> poison, float %fneg.1185, i64 0
  %cmp566.not.1.not = icmp slt i32 %add563, %1
  %fneg.1185.1 = select i1 %cmp566.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1571 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1470, float %fneg.1185.1, i64 1
  %add564.2 = or disjoint i32 %add563, 2
  %cmp566.not.2 = icmp sgt i32 %add564.2, %1
  %fneg.1185.2 = select i1 %cmp566.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1664 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1571, float %fneg.1185.2, i64 2
  %add564.3 = or disjoint i32 %add563, 3
  %cmp566.not.3 = icmp sgt i32 %add564.3, %1
  %fneg.1185.3 = select i1 %cmp566.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1757 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1664, float %fneg.1185.3, i64 3
  br label %if.end580

if.end580:                                        ; preds = %for.cond526.preheader, %for.cond556.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1757, %for.cond556.preheader ], [ zeroinitializer, %for.cond526.preheader ]
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !81
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %93), !call_argsrelate !81
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %94), !call_argsrelate !81
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %95), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract1472 = extractelement <4 x float> %96, i64 0
  %mul615 = fmul contract float %acc_s.sroa.0.0.vec.extract1472, 0x3FB99999A0000000
  %97 = tail call contract noundef float @llvm.minnum.f32(float %mul615, float 0x4024CB5EC0000000)
  %98 = tail call contract noundef float @llvm.exp.f32(float %97)
  %acc_s.sroa.0.4.vec.extract1573 = extractelement <4 x float> %96, i64 1
  %mul615.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1573, 0x3FB99999A0000000
  %99 = tail call contract noundef float @llvm.minnum.f32(float %mul615.1, float 0x4024CB5EC0000000)
  %100 = tail call contract noundef float @llvm.exp.f32(float %99)
  %acc_s.sroa.0.8.vec.extract1666 = extractelement <4 x float> %96, i64 2
  %mul615.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1666, 0x3FB99999A0000000
  %101 = tail call contract noundef float @llvm.minnum.f32(float %mul615.2, float 0x4024CB5EC0000000)
  %102 = tail call contract noundef float @llvm.exp.f32(float %101)
  %acc_s.sroa.0.12.vec.extract1759 = extractelement <4 x float> %96, i64 3
  %mul615.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1759, 0x3FB99999A0000000
  %103 = tail call contract noundef float @llvm.minnum.f32(float %mul615.3, float 0x4024CB5EC0000000)
  %104 = tail call contract noundef float @llvm.exp.f32(float %103)
  %add631 = fadd contract float %sum_acc.sroa.0.1, %98
  %add631.1 = fadd contract float %sum_acc.sroa.20.1, %100
  %add631.2 = fadd contract float %sum_acc.sroa.38.1, %102
  %add631.3 = fadd contract float %sum_acc.sroa.56.1, %104
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %98)
  %106 = insertelement <4 x i16> poison, i16 %105, i64 0
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %100)
  %108 = insertelement <4 x i16> %106, i16 %107, i64 1
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %102)
  %110 = insertelement <4 x i16> %108, i16 %109, i64 2
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %104)
  %112 = insertelement <4 x i16> %110, i16 %111, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1425 = bitcast <4 x i16> %112 to <4 x half>
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1824, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !101
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1833, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o.sroa.34.0), !call_argsrelate !101
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1859, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o.sroa.66.0), !call_argsrelate !101
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1866, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1425, <4 x float> %acc_o.sroa.98.0), !call_argsrelate !101
  br label %if.end667

if.end667:                                        ; preds = %if.end580, %if.end518
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end518 ], [ %116, %if.end580 ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end518 ], [ %115, %if.end580 ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end518 ], [ %114, %if.end580 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end518 ], [ %113, %if.end580 ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end518 ], [ %add631.3, %if.end580 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end518 ], [ %add631.2, %if.end580 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end518 ], [ %add631.1, %if.end580 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end518 ], [ %add631, %if.end580 ]
  br i1 %or.cond1293, label %if.end816, label %for.cond675.preheader

for.cond675.preheader:                            ; preds = %if.end667
  %117 = shl nsw i32 %cond.i.i1195.3, 10
  %118 = and i32 %117, 64512
  %mul684 = zext nneg i32 %118 to i64
  %add685 = or disjoint i64 %mul100, %mul684
  %119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add685
  %V_reg.sroa.0.0.copyload1825 = load <4 x half>, ptr addrspace(4) %119, align 16
  %V_reg.sroa.18.0..sroa_idx1834 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 8
  %V_reg.sroa.18.0.copyload1835 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx1834, align 8
  %gep1258.1 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1024
  %V_reg.sroa.26.16.copyload1860 = load <4 x half>, ptr addrspace(4) %gep1258.1, align 16
  %V_reg.sroa.42.16.gep1258.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1032
  %V_reg.sroa.42.16.copyload1867 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1258.1.sroa_idx, align 8
  %cmp703 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp703, label %for.cond705.preheader, label %if.end729

for.cond705.preheader:                            ; preds = %for.cond675.preheader
  %add712 = add nuw nsw i32 %mul11.3, %mul265
  %cmp715.not = icmp sgt i32 %add712, %1
  %fneg.1186 = select i1 %cmp715.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1480 = insertelement <4 x float> poison, float %fneg.1186, i64 0
  %cmp715.not.1.not = icmp slt i32 %add712, %1
  %fneg.1186.1 = select i1 %cmp715.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1581 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1480, float %fneg.1186.1, i64 1
  %add713.2 = or disjoint i32 %add712, 2
  %cmp715.not.2 = icmp sgt i32 %add713.2, %1
  %fneg.1186.2 = select i1 %cmp715.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1674 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1581, float %fneg.1186.2, i64 2
  %add713.3 = or disjoint i32 %add712, 3
  %cmp715.not.3 = icmp sgt i32 %add713.3, %1
  %fneg.1186.3 = select i1 %cmp715.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1767 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1674, float %fneg.1186.3, i64 3
  br label %if.end729

if.end729:                                        ; preds = %for.cond675.preheader, %for.cond705.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1767, %for.cond705.preheader ], [ zeroinitializer, %for.cond675.preheader ]
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !81
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %120), !call_argsrelate !81
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %121), !call_argsrelate !81
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %122), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract1482 = extractelement <4 x float> %123, i64 0
  %mul764 = fmul contract float %acc_s.sroa.0.0.vec.extract1482, 0x3FB99999A0000000
  %124 = tail call contract noundef float @llvm.minnum.f32(float %mul764, float 0x4024CB5EC0000000)
  %125 = tail call contract noundef float @llvm.exp.f32(float %124)
  %acc_s.sroa.0.4.vec.extract1583 = extractelement <4 x float> %123, i64 1
  %mul764.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1583, 0x3FB99999A0000000
  %126 = tail call contract noundef float @llvm.minnum.f32(float %mul764.1, float 0x4024CB5EC0000000)
  %127 = tail call contract noundef float @llvm.exp.f32(float %126)
  %acc_s.sroa.0.8.vec.extract1676 = extractelement <4 x float> %123, i64 2
  %mul764.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1676, 0x3FB99999A0000000
  %128 = tail call contract noundef float @llvm.minnum.f32(float %mul764.2, float 0x4024CB5EC0000000)
  %129 = tail call contract noundef float @llvm.exp.f32(float %128)
  %acc_s.sroa.0.12.vec.extract1769 = extractelement <4 x float> %123, i64 3
  %mul764.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1769, 0x3FB99999A0000000
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul764.3, float 0x4024CB5EC0000000)
  %131 = tail call contract noundef float @llvm.exp.f32(float %130)
  %add780 = fadd contract float %sum_acc.sroa.0.2, %125
  %add780.1 = fadd contract float %sum_acc.sroa.20.2, %127
  %add780.2 = fadd contract float %sum_acc.sroa.38.2, %129
  %add780.3 = fadd contract float %sum_acc.sroa.56.2, %131
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %125)
  %133 = insertelement <4 x i16> poison, i16 %132, i64 0
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %127)
  %135 = insertelement <4 x i16> %133, i16 %134, i64 1
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %129)
  %137 = insertelement <4 x i16> %135, i16 %136, i64 2
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131)
  %139 = insertelement <4 x i16> %137, i16 %138, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1427 = bitcast <4 x i16> %139 to <4 x half>
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1825, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1427, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !101
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1835, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1427, <4 x float> %acc_o_alt.sroa.18.0), !call_argsrelate !101
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1860, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1427, <4 x float> %acc_o_alt.sroa.34.0), !call_argsrelate !101
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1867, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1427, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !101
  br label %if.end816

if.end816:                                        ; preds = %if.end729, %if.end667
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end667 ], [ %143, %if.end729 ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end667 ], [ %142, %if.end729 ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end667 ], [ %141, %if.end729 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end667 ], [ %140, %if.end729 ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end667 ], [ %add780.3, %if.end729 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end667 ], [ %add780.2, %if.end729 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end667 ], [ %add780.1, %if.end729 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end667 ], [ %add780, %if.end729 ]
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023
  %cmp94.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond1287.1 = or i1 %or.cond.1, %cmp94.not.1
  br i1 %or.cond1287.1, label %if.end.1, label %for.cond95.preheader.1

for.cond95.preheader.1:                           ; preds = %if.end816
  %144 = shl nsw i32 %cond.i.i1195.4, 10
  %145 = and i32 %144, 64512
  %mul103.1 = zext nneg i32 %145 to i64
  %add104.1 = or disjoint i64 %mul100, %mul103.1
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add104.1
  %K_reg.sroa.0.0.copyload1907 = load <4 x half>, ptr addrspace(4) %146, align 16
  %K_reg.sroa.6.0..sroa_idx1908 = getelementptr inbounds i8, ptr addrspace(4) %146, i64 8
  %K_reg.sroa.6.0.copyload1909 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0..sroa_idx1908, align 8
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1024
  %K_reg.sroa.8.16.copyload1912 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16
  %K_reg.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1032
  %K_reg.sroa.12.16.copyload1913 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.gep.1.1.sroa_idx, align 8
  br label %if.end.1

if.end.1:                                         ; preds = %for.cond95.preheader.1, %if.end816
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end816 ], [ %K_reg.sroa.12.16.copyload1913, %for.cond95.preheader.1 ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end816 ], [ %K_reg.sroa.8.16.copyload1912, %for.cond95.preheader.1 ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end816 ], [ %K_reg.sroa.6.0.copyload1909, %for.cond95.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end816 ], [ %K_reg.sroa.0.0.copyload1907, %for.cond95.preheader.1 ]
  %or.cond1288.1 = icmp ugt i32 %mul11.5, 1023
  %cmp125.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond1289.1 = or i1 %or.cond1288.1, %cmp125.not.1
  br i1 %or.cond1289.1, label %if.end153.1, label %for.cond127.preheader.1

for.cond127.preheader.1:                          ; preds = %if.end.1
  %147 = shl nsw i32 %cond.i.i1195.5, 10
  %148 = and i32 %147, 64512
  %mul136.1 = zext nneg i32 %148 to i64
  %add137.1 = or disjoint i64 %mul100, %mul136.1
  %149 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add137.1
  %K_reg1.sroa.0.0.copyload1898 = load <4 x half>, ptr addrspace(4) %149, align 16
  %K_reg1.sroa.6.0..sroa_idx1899 = getelementptr inbounds i8, ptr addrspace(4) %149, i64 8
  %K_reg1.sroa.6.0.copyload1900 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0..sroa_idx1899, align 8
  %gep1208.1.1 = getelementptr inbounds i8, ptr addrspace(4) %149, i64 1024
  %K_reg1.sroa.8.16.copyload1903 = load <4 x half>, ptr addrspace(4) %gep1208.1.1, align 16
  %K_reg1.sroa.12.16.gep1208.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %149, i64 1032
  %K_reg1.sroa.12.16.copyload1904 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.gep1208.1.1.sroa_idx, align 8
  br label %if.end153.1

if.end153.1:                                      ; preds = %for.cond127.preheader.1, %if.end.1
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %K_reg1.sroa.12.16.copyload1904, %for.cond127.preheader.1 ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end.1 ], [ %K_reg1.sroa.8.16.copyload1903, %for.cond127.preheader.1 ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end.1 ], [ %K_reg1.sroa.6.0.copyload1900, %for.cond127.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %K_reg1.sroa.0.0.copyload1898, %for.cond127.preheader.1 ]
  %or.cond1290.1 = icmp ugt i32 %mul11.6, 1023
  %cmp159.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond1291.1 = or i1 %or.cond1290.1, %cmp159.not.1
  br i1 %or.cond1291.1, label %if.end187.1, label %for.cond161.preheader.1

for.cond161.preheader.1:                          ; preds = %if.end153.1
  %150 = shl nsw i32 %cond.i.i1195.6, 10
  %151 = and i32 %150, 64512
  %mul170.1 = zext nneg i32 %151 to i64
  %add171.1 = or disjoint i64 %mul100, %mul170.1
  %152 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add171.1
  %K_reg2.sroa.0.0.copyload1889 = load <4 x half>, ptr addrspace(4) %152, align 16
  %K_reg2.sroa.6.0..sroa_idx1890 = getelementptr inbounds i8, ptr addrspace(4) %152, i64 8
  %K_reg2.sroa.6.0.copyload1891 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0..sroa_idx1890, align 8
  %gep1211.1.1 = getelementptr inbounds i8, ptr addrspace(4) %152, i64 1024
  %K_reg2.sroa.8.16.copyload1894 = load <4 x half>, ptr addrspace(4) %gep1211.1.1, align 16
  %K_reg2.sroa.12.16.gep1211.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %152, i64 1032
  %K_reg2.sroa.12.16.copyload1895 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.gep1211.1.1.sroa_idx, align 8
  br label %if.end187.1

if.end187.1:                                      ; preds = %for.cond161.preheader.1, %if.end153.1
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end153.1 ], [ %K_reg2.sroa.12.16.copyload1895, %for.cond161.preheader.1 ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end153.1 ], [ %K_reg2.sroa.8.16.copyload1894, %for.cond161.preheader.1 ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end153.1 ], [ %K_reg2.sroa.6.0.copyload1891, %for.cond161.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end153.1 ], [ %K_reg2.sroa.0.0.copyload1889, %for.cond161.preheader.1 ]
  %or.cond1292.1 = icmp ugt i32 %mul11.7, 1023
  %cmp193.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond1293.1 = or i1 %or.cond1292.1, %cmp193.not.1
  br i1 %or.cond1293.1, label %if.end221.1, label %for.cond195.preheader.1

for.cond195.preheader.1:                          ; preds = %if.end187.1
  %153 = shl nsw i32 %cond.i.i1195.7, 10
  %154 = and i32 %153, 64512
  %mul204.1 = zext nneg i32 %154 to i64
  %add205.1 = or disjoint i64 %mul100, %mul204.1
  %155 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add205.1
  %K_reg3.sroa.0.0.copyload1880 = load <4 x half>, ptr addrspace(4) %155, align 16
  %K_reg3.sroa.6.0..sroa_idx1881 = getelementptr inbounds i8, ptr addrspace(4) %155, i64 8
  %K_reg3.sroa.6.0.copyload1882 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0..sroa_idx1881, align 8
  %gep1214.1.1 = getelementptr inbounds i8, ptr addrspace(4) %155, i64 1024
  %K_reg3.sroa.8.16.copyload1885 = load <4 x half>, ptr addrspace(4) %gep1214.1.1, align 16
  %K_reg3.sroa.12.16.gep1214.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %155, i64 1032
  %K_reg3.sroa.12.16.copyload1886 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.gep1214.1.1.sroa_idx, align 8
  br label %if.end221.1

if.end221.1:                                      ; preds = %for.cond195.preheader.1, %if.end187.1
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end187.1 ], [ %K_reg3.sroa.12.16.copyload1886, %for.cond195.preheader.1 ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end187.1 ], [ %K_reg3.sroa.8.16.copyload1885, %for.cond195.preheader.1 ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end187.1 ], [ %K_reg3.sroa.6.0.copyload1882, %for.cond195.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end187.1 ], [ %K_reg3.sroa.0.0.copyload1880, %for.cond195.preheader.1 ]
  br i1 %or.cond1287.1, label %if.end369.1, label %for.cond229.preheader.1

for.cond229.preheader.1:                          ; preds = %if.end221.1
  %156 = shl nsw i32 %cond.i.i1195.4, 10
  %157 = and i32 %156, 64512
  %mul238.1 = zext nneg i32 %157 to i64
  %add239.1 = or disjoint i64 %mul100, %mul238.1
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add239.1
  %V_reg.sroa.0.0.copyload1826 = load <4 x half>, ptr addrspace(4) %158, align 16
  %V_reg.sroa.18.0..sroa_idx1836 = getelementptr inbounds i8, ptr addrspace(4) %158, i64 8
  %V_reg.sroa.18.0.copyload1837 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx1836, align 8
  %gep1217.1.1 = getelementptr inbounds i8, ptr addrspace(4) %158, i64 1024
  %V_reg.sroa.26.16.copyload1861 = load <4 x half>, ptr addrspace(4) %gep1217.1.1, align 16
  %V_reg.sroa.42.16.gep1217.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %158, i64 1032
  %V_reg.sroa.42.16.copyload1868 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1217.1.1.sroa_idx, align 8
  %cmp257.1 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp257.1, label %for.cond259.preheader.1, label %if.end282.1

for.cond259.preheader.1:                          ; preds = %for.cond229.preheader.1
  %add266.1 = add nuw nsw i32 %mul11.4, %mul265
  %cmp269.not.11335 = icmp sgt i32 %add266.1, %1
  %fneg..11336 = select i1 %cmp269.not.11335, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1492 = insertelement <4 x float> poison, float %fneg..11336, i64 0
  %cmp269.not.1.1.not = icmp slt i32 %add266.1, %1
  %fneg..1.1 = select i1 %cmp269.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1591 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1492, float %fneg..1.1, i64 1
  %add267.2.1 = or disjoint i32 %add266.1, 2
  %cmp269.not.2.1 = icmp sgt i32 %add267.2.1, %1
  %fneg..2.1 = select i1 %cmp269.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1684 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1591, float %fneg..2.1, i64 2
  %add267.3.1 = or disjoint i32 %add266.1, 3
  %cmp269.not.3.1 = icmp sgt i32 %add267.3.1, %1
  %fneg..3.1 = select i1 %cmp269.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1777 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1684, float %fneg..3.1, i64 3
  br label %if.end282.1

if.end282.1:                                      ; preds = %for.cond229.preheader.1, %for.cond259.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1777, %for.cond259.preheader.1 ], [ zeroinitializer, %for.cond229.preheader.1 ]
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !81
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %159), !call_argsrelate !81
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %160), !call_argsrelate !81
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %161), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract1494 = extractelement <4 x float> %162, i64 0
  %mul317.11340 = fmul contract float %acc_s.sroa.0.0.vec.extract1494, 0x3FB99999A0000000
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul317.11340, float 0x4024CB5EC0000000)
  %164 = tail call contract noundef float @llvm.exp.f32(float %163)
  %acc_s.sroa.0.4.vec.extract1593 = extractelement <4 x float> %162, i64 1
  %mul317.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1593, 0x3FB99999A0000000
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul317.1.1, float 0x4024CB5EC0000000)
  %166 = tail call contract noundef float @llvm.exp.f32(float %165)
  %acc_s.sroa.0.8.vec.extract1686 = extractelement <4 x float> %162, i64 2
  %mul317.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1686, 0x3FB99999A0000000
  %167 = tail call contract noundef float @llvm.minnum.f32(float %mul317.2.1, float 0x4024CB5EC0000000)
  %168 = tail call contract noundef float @llvm.exp.f32(float %167)
  %acc_s.sroa.0.12.vec.extract1779 = extractelement <4 x float> %162, i64 3
  %mul317.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1779, 0x3FB99999A0000000
  %169 = tail call contract noundef float @llvm.minnum.f32(float %mul317.3.1, float 0x4024CB5EC0000000)
  %170 = tail call contract noundef float @llvm.exp.f32(float %169)
  %add333.11341 = fadd contract float %sum_acc.sroa.0.3, %164
  %add333.1.1 = fadd contract float %sum_acc.sroa.20.3, %166
  %add333.2.1 = fadd contract float %sum_acc.sroa.38.3, %168
  %add333.3.1 = fadd contract float %sum_acc.sroa.56.3, %170
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164)
  %172 = insertelement <4 x i16> poison, i16 %171, i64 0
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166)
  %174 = insertelement <4 x i16> %172, i16 %173, i64 1
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %168)
  %176 = insertelement <4 x i16> %174, i16 %175, i64 2
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %170)
  %178 = insertelement <4 x i16> %176, i16 %177, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1429 = bitcast <4 x i16> %178 to <4 x half>
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1826, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1429, <4 x float> %acc_o.sroa.0.1), !call_argsrelate !101
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1837, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1429, <4 x float> %acc_o.sroa.34.1), !call_argsrelate !101
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1861, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1429, <4 x float> %acc_o.sroa.66.1), !call_argsrelate !101
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1868, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1429, <4 x float> %acc_o.sroa.98.1), !call_argsrelate !101
  br label %if.end369.1

if.end369.1:                                      ; preds = %if.end282.1, %if.end221.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end221.1 ], [ %182, %if.end282.1 ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end221.1 ], [ %181, %if.end282.1 ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end221.1 ], [ %180, %if.end282.1 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end221.1 ], [ %179, %if.end282.1 ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end221.1 ], [ %add333.3.1, %if.end282.1 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end221.1 ], [ %add333.2.1, %if.end282.1 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end221.1 ], [ %add333.1.1, %if.end282.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end221.1 ], [ %add333.11341, %if.end282.1 ]
  br i1 %or.cond1289.1, label %if.end518.1, label %for.cond377.preheader.1

for.cond377.preheader.1:                          ; preds = %if.end369.1
  %183 = shl nsw i32 %cond.i.i1195.5, 10
  %184 = and i32 %183, 64512
  %mul386.1 = zext nneg i32 %184 to i64
  %add387.1 = or disjoint i64 %mul100, %mul386.1
  %185 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add387.1
  %V_reg.sroa.0.0.copyload1827 = load <4 x half>, ptr addrspace(4) %185, align 16
  %V_reg.sroa.18.0..sroa_idx1838 = getelementptr inbounds i8, ptr addrspace(4) %185, i64 8
  %V_reg.sroa.18.0.copyload1839 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx1838, align 8
  %gep1230.1.1 = getelementptr inbounds i8, ptr addrspace(4) %185, i64 1024
  %V_reg.sroa.26.16.copyload1862 = load <4 x half>, ptr addrspace(4) %gep1230.1.1, align 16
  %V_reg.sroa.42.16.gep1230.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %185, i64 1032
  %V_reg.sroa.42.16.copyload1869 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1230.1.1.sroa_idx, align 8
  %cmp405.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp405.1, label %for.cond407.preheader.1, label %if.end431.1

for.cond407.preheader.1:                          ; preds = %for.cond377.preheader.1
  %add414.1 = add nuw nsw i32 %mul11.5, %mul265
  %cmp417.not.11342 = icmp sgt i32 %add414.1, %1
  %fneg.1184.11343 = select i1 %cmp417.not.11342, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1504 = insertelement <4 x float> poison, float %fneg.1184.11343, i64 0
  %cmp417.not.1.1.not = icmp slt i32 %add414.1, %1
  %fneg.1184.1.1 = select i1 %cmp417.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1601 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1504, float %fneg.1184.1.1, i64 1
  %add415.2.1 = or disjoint i32 %add414.1, 2
  %cmp417.not.2.1 = icmp sgt i32 %add415.2.1, %1
  %fneg.1184.2.1 = select i1 %cmp417.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1694 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1601, float %fneg.1184.2.1, i64 2
  %add415.3.1 = or disjoint i32 %add414.1, 3
  %cmp417.not.3.1 = icmp sgt i32 %add415.3.1, %1
  %fneg.1184.3.1 = select i1 %cmp417.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1787 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1694, float %fneg.1184.3.1, i64 3
  br label %if.end431.1

if.end431.1:                                      ; preds = %for.cond377.preheader.1, %for.cond407.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1787, %for.cond407.preheader.1 ], [ zeroinitializer, %for.cond377.preheader.1 ]
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !81
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %186), !call_argsrelate !81
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %187), !call_argsrelate !81
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %188), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract1506 = extractelement <4 x float> %189, i64 0
  %mul466.11347 = fmul contract float %acc_s.sroa.0.0.vec.extract1506, 0x3FB99999A0000000
  %190 = tail call contract noundef float @llvm.minnum.f32(float %mul466.11347, float 0x4024CB5EC0000000)
  %191 = tail call contract noundef float @llvm.exp.f32(float %190)
  %acc_s.sroa.0.4.vec.extract1603 = extractelement <4 x float> %189, i64 1
  %mul466.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1603, 0x3FB99999A0000000
  %192 = tail call contract noundef float @llvm.minnum.f32(float %mul466.1.1, float 0x4024CB5EC0000000)
  %193 = tail call contract noundef float @llvm.exp.f32(float %192)
  %acc_s.sroa.0.8.vec.extract1696 = extractelement <4 x float> %189, i64 2
  %mul466.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1696, 0x3FB99999A0000000
  %194 = tail call contract noundef float @llvm.minnum.f32(float %mul466.2.1, float 0x4024CB5EC0000000)
  %195 = tail call contract noundef float @llvm.exp.f32(float %194)
  %acc_s.sroa.0.12.vec.extract1789 = extractelement <4 x float> %189, i64 3
  %mul466.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1789, 0x3FB99999A0000000
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul466.3.1, float 0x4024CB5EC0000000)
  %197 = tail call contract noundef float @llvm.exp.f32(float %196)
  %add482.11348 = fadd contract float %sum_acc.sroa.0.4, %191
  %add482.1.1 = fadd contract float %sum_acc.sroa.20.4, %193
  %add482.2.1 = fadd contract float %sum_acc.sroa.38.4, %195
  %add482.3.1 = fadd contract float %sum_acc.sroa.56.4, %197
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %191)
  %199 = insertelement <4 x i16> poison, i16 %198, i64 0
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %193)
  %201 = insertelement <4 x i16> %199, i16 %200, i64 1
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %195)
  %203 = insertelement <4 x i16> %201, i16 %202, i64 2
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197)
  %205 = insertelement <4 x i16> %203, i16 %204, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1431 = bitcast <4 x i16> %205 to <4 x half>
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1827, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !101
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1839, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> %acc_o_alt.sroa.18.1), !call_argsrelate !101
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1862, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> %acc_o_alt.sroa.34.1), !call_argsrelate !101
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1869, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !101
  br label %if.end518.1

if.end518.1:                                      ; preds = %if.end431.1, %if.end369.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end369.1 ], [ %209, %if.end431.1 ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end369.1 ], [ %208, %if.end431.1 ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end369.1 ], [ %207, %if.end431.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end369.1 ], [ %206, %if.end431.1 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end369.1 ], [ %add482.3.1, %if.end431.1 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end369.1 ], [ %add482.2.1, %if.end431.1 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end369.1 ], [ %add482.1.1, %if.end431.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end369.1 ], [ %add482.11348, %if.end431.1 ]
  br i1 %or.cond1291.1, label %if.end667.1, label %for.cond526.preheader.1

for.cond526.preheader.1:                          ; preds = %if.end518.1
  %210 = shl nsw i32 %cond.i.i1195.6, 10
  %211 = and i32 %210, 64512
  %mul535.1 = zext nneg i32 %211 to i64
  %add536.1 = or disjoint i64 %mul100, %mul535.1
  %212 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add536.1
  %V_reg.sroa.0.0.copyload1828 = load <4 x half>, ptr addrspace(4) %212, align 16
  %V_reg.sroa.18.0..sroa_idx1840 = getelementptr inbounds i8, ptr addrspace(4) %212, i64 8
  %V_reg.sroa.18.0.copyload1841 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx1840, align 8
  %gep1244.1.1 = getelementptr inbounds i8, ptr addrspace(4) %212, i64 1024
  %V_reg.sroa.26.16.copyload1863 = load <4 x half>, ptr addrspace(4) %gep1244.1.1, align 16
  %V_reg.sroa.42.16.gep1244.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %212, i64 1032
  %V_reg.sroa.42.16.copyload1870 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1244.1.1.sroa_idx, align 8
  %cmp554.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp554.1, label %for.cond556.preheader.1, label %if.end580.1

for.cond556.preheader.1:                          ; preds = %for.cond526.preheader.1
  %add563.1 = add nuw nsw i32 %mul11.6, %mul265
  %cmp566.not.11349 = icmp sgt i32 %add563.1, %1
  %fneg.1185.11350 = select i1 %cmp566.not.11349, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1516 = insertelement <4 x float> poison, float %fneg.1185.11350, i64 0
  %cmp566.not.1.1.not = icmp slt i32 %add563.1, %1
  %fneg.1185.1.1 = select i1 %cmp566.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1611 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1516, float %fneg.1185.1.1, i64 1
  %add564.2.1 = or disjoint i32 %add563.1, 2
  %cmp566.not.2.1 = icmp sgt i32 %add564.2.1, %1
  %fneg.1185.2.1 = select i1 %cmp566.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1704 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1611, float %fneg.1185.2.1, i64 2
  %add564.3.1 = or disjoint i32 %add563.1, 3
  %cmp566.not.3.1 = icmp sgt i32 %add564.3.1, %1
  %fneg.1185.3.1 = select i1 %cmp566.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1797 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1704, float %fneg.1185.3.1, i64 3
  br label %if.end580.1

if.end580.1:                                      ; preds = %for.cond526.preheader.1, %for.cond556.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1797, %for.cond556.preheader.1 ], [ zeroinitializer, %for.cond526.preheader.1 ]
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !81
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %213), !call_argsrelate !81
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %214), !call_argsrelate !81
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %215), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract1518 = extractelement <4 x float> %216, i64 0
  %mul615.11354 = fmul contract float %acc_s.sroa.0.0.vec.extract1518, 0x3FB99999A0000000
  %217 = tail call contract noundef float @llvm.minnum.f32(float %mul615.11354, float 0x4024CB5EC0000000)
  %218 = tail call contract noundef float @llvm.exp.f32(float %217)
  %acc_s.sroa.0.4.vec.extract1613 = extractelement <4 x float> %216, i64 1
  %mul615.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1613, 0x3FB99999A0000000
  %219 = tail call contract noundef float @llvm.minnum.f32(float %mul615.1.1, float 0x4024CB5EC0000000)
  %220 = tail call contract noundef float @llvm.exp.f32(float %219)
  %acc_s.sroa.0.8.vec.extract1706 = extractelement <4 x float> %216, i64 2
  %mul615.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1706, 0x3FB99999A0000000
  %221 = tail call contract noundef float @llvm.minnum.f32(float %mul615.2.1, float 0x4024CB5EC0000000)
  %222 = tail call contract noundef float @llvm.exp.f32(float %221)
  %acc_s.sroa.0.12.vec.extract1799 = extractelement <4 x float> %216, i64 3
  %mul615.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1799, 0x3FB99999A0000000
  %223 = tail call contract noundef float @llvm.minnum.f32(float %mul615.3.1, float 0x4024CB5EC0000000)
  %224 = tail call contract noundef float @llvm.exp.f32(float %223)
  %add631.11355 = fadd contract float %sum_acc.sroa.0.5, %218
  %add631.1.1 = fadd contract float %sum_acc.sroa.20.5, %220
  %add631.2.1 = fadd contract float %sum_acc.sroa.38.5, %222
  %add631.3.1 = fadd contract float %sum_acc.sroa.56.5, %224
  %225 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %218)
  %226 = insertelement <4 x i16> poison, i16 %225, i64 0
  %227 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %220)
  %228 = insertelement <4 x i16> %226, i16 %227, i64 1
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %222)
  %230 = insertelement <4 x i16> %228, i16 %229, i64 2
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %224)
  %232 = insertelement <4 x i16> %230, i16 %231, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1433 = bitcast <4 x i16> %232 to <4 x half>
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1828, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !101
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1841, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.34.2), !call_argsrelate !101
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1863, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.66.2), !call_argsrelate !101
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1870, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.98.2), !call_argsrelate !101
  br label %if.end667.1

if.end667.1:                                      ; preds = %if.end580.1, %if.end518.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end518.1 ], [ %236, %if.end580.1 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end518.1 ], [ %235, %if.end580.1 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end518.1 ], [ %234, %if.end580.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end518.1 ], [ %233, %if.end580.1 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end518.1 ], [ %add631.3.1, %if.end580.1 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end518.1 ], [ %add631.2.1, %if.end580.1 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end518.1 ], [ %add631.1.1, %if.end580.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end518.1 ], [ %add631.11355, %if.end580.1 ]
  br i1 %or.cond1293.1, label %if.end816.1, label %for.cond675.preheader.1

for.cond675.preheader.1:                          ; preds = %if.end667.1
  %237 = shl nsw i32 %cond.i.i1195.7, 10
  %238 = and i32 %237, 64512
  %mul684.1 = zext nneg i32 %238 to i64
  %add685.1 = or disjoint i64 %mul100, %mul684.1
  %239 = getelementptr inbounds %struct.__half, ptr addrspace(4) %invariant.gep1216, i64 %add685.1
  %V_reg.sroa.0.0.copyload1829 = load <4 x half>, ptr addrspace(4) %239, align 16
  %V_reg.sroa.18.0..sroa_idx1842 = getelementptr inbounds i8, ptr addrspace(4) %239, i64 8
  %V_reg.sroa.18.0.copyload1843 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0..sroa_idx1842, align 8
  %gep1258.1.1 = getelementptr inbounds i8, ptr addrspace(4) %239, i64 1024
  %V_reg.sroa.26.16.copyload1864 = load <4 x half>, ptr addrspace(4) %gep1258.1.1, align 16
  %V_reg.sroa.42.16.gep1258.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %239, i64 1032
  %V_reg.sroa.42.16.copyload1871 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.gep1258.1.1.sroa_idx, align 8
  %cmp703.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp703.1, label %for.cond705.preheader.1, label %if.end729.1

for.cond705.preheader.1:                          ; preds = %for.cond675.preheader.1
  %add712.1 = add nuw nsw i32 %mul11.7, %mul265
  %cmp715.not.11356 = icmp sgt i32 %add712.1, %1
  %fneg.1186.11357 = select i1 %cmp715.not.11356, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1528 = insertelement <4 x float> poison, float %fneg.1186.11357, i64 0
  %cmp715.not.1.1.not = icmp slt i32 %add712.1, %1
  %fneg.1186.1.1 = select i1 %cmp715.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1621 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1528, float %fneg.1186.1.1, i64 1
  %add713.2.1 = or disjoint i32 %add712.1, 2
  %cmp715.not.2.1 = icmp sgt i32 %add713.2.1, %1
  %fneg.1186.2.1 = select i1 %cmp715.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1714 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1621, float %fneg.1186.2.1, i64 2
  %add713.3.1 = or disjoint i32 %add712.1, 3
  %cmp715.not.3.1 = icmp sgt i32 %add713.3.1, %1
  %fneg.1186.3.1 = select i1 %cmp715.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1807 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1714, float %fneg.1186.3.1, i64 3
  br label %if.end729.1

if.end729.1:                                      ; preds = %for.cond675.preheader.1, %for.cond705.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1807, %for.cond705.preheader.1 ], [ zeroinitializer, %for.cond675.preheader.1 ]
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !81
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %240), !call_argsrelate !81
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %241), !call_argsrelate !81
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %242), !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract1530 = extractelement <4 x float> %243, i64 0
  %mul764.11361 = fmul contract float %acc_s.sroa.0.0.vec.extract1530, 0x3FB99999A0000000
  %244 = tail call contract noundef float @llvm.minnum.f32(float %mul764.11361, float 0x4024CB5EC0000000)
  %245 = tail call contract noundef float @llvm.exp.f32(float %244)
  %acc_s.sroa.0.4.vec.extract1623 = extractelement <4 x float> %243, i64 1
  %mul764.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1623, 0x3FB99999A0000000
  %246 = tail call contract noundef float @llvm.minnum.f32(float %mul764.1.1, float 0x4024CB5EC0000000)
  %247 = tail call contract noundef float @llvm.exp.f32(float %246)
  %acc_s.sroa.0.8.vec.extract1716 = extractelement <4 x float> %243, i64 2
  %mul764.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1716, 0x3FB99999A0000000
  %248 = tail call contract noundef float @llvm.minnum.f32(float %mul764.2.1, float 0x4024CB5EC0000000)
  %249 = tail call contract noundef float @llvm.exp.f32(float %248)
  %acc_s.sroa.0.12.vec.extract1809 = extractelement <4 x float> %243, i64 3
  %mul764.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1809, 0x3FB99999A0000000
  %250 = tail call contract noundef float @llvm.minnum.f32(float %mul764.3.1, float 0x4024CB5EC0000000)
  %251 = tail call contract noundef float @llvm.exp.f32(float %250)
  %add780.11362 = fadd contract float %sum_acc.sroa.0.6, %245
  %add780.1.1 = fadd contract float %sum_acc.sroa.20.6, %247
  %add780.2.1 = fadd contract float %sum_acc.sroa.38.6, %249
  %add780.3.1 = fadd contract float %sum_acc.sroa.56.6, %251
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %245)
  %253 = insertelement <4 x i16> poison, i16 %252, i64 0
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %247)
  %255 = insertelement <4 x i16> %253, i16 %254, i64 1
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %249)
  %257 = insertelement <4 x i16> %255, i16 %256, i64 2
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %251)
  %259 = insertelement <4 x i16> %257, i16 %258, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1435 = bitcast <4 x i16> %259 to <4 x half>
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1829, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !101
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1843, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.18.2), !call_argsrelate !101
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1864, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.34.2), !call_argsrelate !101
  %263 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1871, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !101
  br label %if.end816.1

if.end816.1:                                      ; preds = %if.end729.1, %if.end667.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end667.1 ], [ %263, %if.end729.1 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end667.1 ], [ %262, %if.end729.1 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end667.1 ], [ %261, %if.end729.1 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end667.1 ], [ %260, %if.end729.1 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end667.1 ], [ %add780.3.1, %if.end729.1 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end667.1 ], [ %add780.2.1, %if.end729.1 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end667.1 ], [ %add780.1.1, %if.end729.1 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end667.1 ], [ %add780.11362, %if.end729.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add828 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add828.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add828.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add828.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add828.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add828.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add828.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add828.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add828.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add828.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add828.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add828.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add828.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add828.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add828.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add828.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add842 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add842.1 = fadd contract float %add842, %sum_acc.sroa.20.7
  %add842.2 = fadd contract float %add842.1, %sum_acc.sroa.38.7
  %add842.3 = fadd contract float %add842.2, %sum_acc.sroa.56.7
  %264 = bitcast float %add842.3 to i32
  %265 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %266 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %265) #11
  %xor.i.i = xor i32 %266, 32
  %267 = and i32 %266, -64
  %and.i.i = add nsw i32 %267, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i1196 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %266
  %shl.i.i = shl i32 %cond.i.i1196, 2
  %268 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %264)
  %269 = bitcast i32 %268 to float
  %add.i = fadd contract float %add842.3, %269
  %270 = bitcast float %add.i to i32
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11
  %xor.i.i1197 = xor i32 %272, 16
  %273 = and i32 %272, -64
  %and.i.i1198 = add nsw i32 %273, 64
  %cmp.not.i.i1199 = icmp slt i32 %xor.i.i1197, %and.i.i1198
  %cond.i.i1200 = select i1 %cmp.not.i.i1199, i32 %xor.i.i1197, i32 %272
  %shl.i.i1201 = shl i32 %cond.i.i1200, 2
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1201, i32 %270)
  %275 = bitcast i32 %274 to float
  %add.i.i = fadd contract float %add.i, %275
  %cmp851 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp851, float %div, float 0.000000e+00
  %mul864 = fmul contract float %condval_4.0, %add828
  %mul864.1 = fmul contract float %condval_4.0, %add828.1
  %mul864.2 = fmul contract float %condval_4.0, %add828.2
  %mul864.3 = fmul contract float %condval_4.0, %add828.3
  %mul864.4 = fmul contract float %condval_4.0, %add828.4
  %mul864.5 = fmul contract float %condval_4.0, %add828.5
  %mul864.6 = fmul contract float %condval_4.0, %add828.6
  %mul864.7 = fmul contract float %condval_4.0, %add828.7
  %mul864.8 = fmul contract float %condval_4.0, %add828.8
  %mul864.9 = fmul contract float %condval_4.0, %add828.9
  %mul864.10 = fmul contract float %condval_4.0, %add828.10
  %mul864.11 = fmul contract float %condval_4.0, %add828.11
  %mul864.12 = fmul contract float %condval_4.0, %add828.12
  %mul864.13 = fmul contract float %condval_4.0, %add828.13
  %mul864.14 = fmul contract float %condval_4.0, %add828.14
  %mul864.15 = fmul contract float %condval_4.0, %add828.15
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864)
  %O_reg.sroa.0.0.insert.ext = zext i16 %276 to i64
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %277 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %278 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %279 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %280 to i64
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %281 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %282 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %283 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %284 to i64
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %285 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %286 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %287 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %288 to i64
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %289 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %290 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul864.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %291 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr906 = lshr i32 %18, 5
  %and909 = and i32 %18, 7
  %mul915 = and i32 %23, 4
  %xor = xor i32 %shr906, %and909
  %mul910 = shl nuw nsw i32 %xor, 3
  %add911 = add nuw nsw i32 %mul910, %mul25
  %add916 = or disjoint i32 %add911, %mul915
  %add.ptr918 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add916
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr918, align 8
  %add907.1 = add nuw nsw i32 %shr906, 2
  %xor.1 = xor i32 %add907.1, %and909
  %mul910.1 = shl nuw nsw i32 %xor.1, 3
  %add911.1 = add nuw nsw i32 %mul910.1, %mul25
  %add916.1 = or disjoint i32 %add911.1, %mul915
  %add.ptr918.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add916.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr918.1, align 8
  %add907.2 = add nuw nsw i32 %shr906, 4
  %xor.2 = xor i32 %add907.2, %and909
  %mul910.2 = shl nuw nsw i32 %xor.2, 3
  %add911.2 = add nuw nsw i32 %mul910.2, %mul25
  %add916.2 = or disjoint i32 %add911.2, %mul915
  %add.ptr918.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add916.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr918.2, align 8
  %add907.3 = add nuw nsw i32 %shr906, 6
  %xor.3 = xor i32 %add907.3, %and909
  %mul910.3 = shl nuw nsw i32 %xor.3, 3
  %add911.3 = add nuw nsw i32 %mul910.3, %mul25
  %add916.3 = or disjoint i32 %add911.3, %mul915
  %add.ptr918.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add916.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr918.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul929 = and i32 %22, 8128
  %xor9351182 = and i32 %22, 56
  %call933.masked = and i32 %18, 1016
  %mul936 = xor i32 %xor9351182, %call933.masked
  %invariant.gep1282 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul929
  %invariant.gep1284 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep1282, i32 %mul936
  %add946 = add nuw nsw i32 %add23, %22
  %292 = zext nneg i32 %add946 to i64
  %add.ptr951 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %292
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr951, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1284, i64 16, i1 false), !tbaa.struct !248, !call_argsrelate !249
  %gep1285.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1284, i32 1024
  %293 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %292
  %add.ptr951.1 = getelementptr inbounds i8, ptr addrspace(1) %293, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr951.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1285.1, i64 16, i1 false), !tbaa.struct !248, !call_argsrelate !249
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare float @llvm.exp.f32(float) #6

declare i16 @llvm.convert.to.fp16.f32(float) #7

declare void @llvm.mxc.barrier.warp() #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare i32 @llvm.smax.i32(i32, i32) #6

declare i32 @llvm.smin.i32(i32, i32) #6

declare float @llvm.minnum.f32(float, float) #6

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


