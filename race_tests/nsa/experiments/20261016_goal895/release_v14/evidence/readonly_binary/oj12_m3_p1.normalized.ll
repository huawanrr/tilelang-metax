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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %arrayidx.val = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val, i32 -1), !call_argsrelate !49
  %cond.i.i1212 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul12 = shl nsw i32 %cond.i.i1212, 4
  %3 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %3
  %arrayidx.val.1 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.1, i32 -1), !call_argsrelate !49
  %cond.i.i1212.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul12.1 = shl nsw i32 %cond.i.i1212.1, 4
  %4 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %arrayidx.val.2 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.2, i32 -1), !call_argsrelate !49
  %cond.i.i1212.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul12.2 = shl nsw i32 %cond.i.i1212.2, 4
  %5 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5
  %arrayidx.val.3 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.3, i32 -1), !call_argsrelate !49
  %cond.i.i1212.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul12.3 = shl nsw i32 %cond.i.i1212.3, 4
  %6 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %arrayidx.val.4 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.4, i32 -1), !call_argsrelate !49
  %cond.i.i1212.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul12.4 = shl nsw i32 %cond.i.i1212.4, 4
  %7 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %7
  %arrayidx.val.5 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.5, i32 -1), !call_argsrelate !49
  %cond.i.i1212.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul12.5 = shl nsw i32 %cond.i.i1212.5, 4
  %8 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %arrayidx.val.6 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.6, i32 -1), !call_argsrelate !49
  %cond.i.i1212.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul12.6 = shl nsw i32 %cond.i.i1212.6, 4
  %9 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %9
  %arrayidx.val.7 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.7, i32 -1), !call_argsrelate !49
  %cond.i.i1212.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul12.7 = shl nsw i32 %cond.i.i1212.7, 4
  %mul21 = shl nsw i32 %0, 20
  %mul23 = shl nsw i32 %1, 10
  %add24 = add nuw nsw i32 %mul21, %mul23
  %10 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %and = shl nuw nsw i32 %10, 6
  %mul26 = and i32 %and, 960
  %add27 = or disjoint i32 %add24, %mul26
  %11 = lshr i32 %10, 1
  %mul31 = and i32 %11, 504
  %add29 = add nuw nsw i32 %add27, %mul31
  %12 = zext nneg i32 %add29 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 64
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %13, i64 72
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8
  %mul102 = shl nsw i32 %0, 16
  %mul110 = shl nuw nsw i32 %10, 3
  %add105 = or disjoint i32 %mul110, %mul102
  %invariant.op = add nsw i32 %1, -15
  %14 = lshr i32 %10, 2
  %mul271 = and i32 %14, 252
  %or.cond = icmp ugt i32 %mul12, 1023
  %cmp95.not = icmp sgt i32 %mul12, %1
  %or.cond1288 = or i1 %or.cond, %cmp95.not
  br i1 %or.cond1288, label %if.end, label %for.cond96.preheader

for.cond96.preheader:                             ; preds = %entry
  %15 = shl nsw i32 %cond.i.i1212, 10
  %mul104 = and i32 %15, 64512
  %add108 = add nuw nsw i32 %add105, %mul104
  %idxprom114 = zext nneg i32 %add108 to i64
  %arrayidx115 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114
  %16 = load <4 x half>, ptr addrspace(4) %arrayidx115, align 2, !tbaa !63
  %add111.4 = or disjoint i32 %add108, 4
  %idxprom114.4 = zext nneg i32 %add111.4 to i64
  %arrayidx115.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114.4
  %17 = load <4 x half>, ptr addrspace(4) %arrayidx115.4, align 2, !tbaa !63
  %18 = zext nneg i32 %add108 to i64
  %19 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %18
  %arrayidx115.8 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 1024
  %20 = load <4 x half>, ptr addrspace(4) %arrayidx115.8, align 2, !tbaa !63
  %21 = zext nneg i32 %add108 to i64
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %21
  %arrayidx115.12 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1032
  %23 = load <4 x half>, ptr addrspace(4) %arrayidx115.12, align 2, !tbaa !63
  br label %if.end

if.end:                                           ; preds = %for.cond96.preheader, %entry
  %K_reg.sroa.32.0 = phi <4 x half> [ undef, %entry ], [ %23, %for.cond96.preheader ]
  %K_reg.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %20, %for.cond96.preheader ]
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %17, %for.cond96.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %16, %for.cond96.preheader ]
  %or.cond1289 = icmp ugt i32 %mul12.1, 1023
  %cmp127.not = icmp sgt i32 %mul12.1, %1
  %or.cond1290 = or i1 %or.cond1289, %cmp127.not
  br i1 %or.cond1290, label %if.end156, label %for.cond129.preheader

for.cond129.preheader:                            ; preds = %if.end
  %24 = shl nsw i32 %cond.i.i1212.1, 10
  %mul137 = and i32 %24, 64512
  %add141 = add nuw nsw i32 %add105, %mul137
  %idxprom147 = zext nneg i32 %add141 to i64
  %arrayidx148 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147
  %25 = load <4 x half>, ptr addrspace(4) %arrayidx148, align 2, !tbaa !63
  %add144.4 = or disjoint i32 %add141, 4
  %idxprom147.4 = zext nneg i32 %add144.4 to i64
  %arrayidx148.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147.4
  %26 = load <4 x half>, ptr addrspace(4) %arrayidx148.4, align 2, !tbaa !63
  %27 = zext nneg i32 %add141 to i64
  %28 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27
  %arrayidx148.8 = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1024
  %29 = load <4 x half>, ptr addrspace(4) %arrayidx148.8, align 2, !tbaa !63
  %30 = zext nneg i32 %add141 to i64
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30
  %arrayidx148.12 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1032
  %32 = load <4 x half>, ptr addrspace(4) %arrayidx148.12, align 2, !tbaa !63
  br label %if.end156

if.end156:                                        ; preds = %for.cond129.preheader, %if.end
  %K_reg1.sroa.32.0 = phi <4 x half> [ undef, %if.end ], [ %32, %for.cond129.preheader ]
  %K_reg1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %29, %for.cond129.preheader ]
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %26, %for.cond129.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %25, %for.cond129.preheader ]
  %or.cond1291 = icmp ugt i32 %mul12.2, 1023
  %cmp162.not = icmp sgt i32 %mul12.2, %1
  %or.cond1292 = or i1 %or.cond1291, %cmp162.not
  br i1 %or.cond1292, label %if.end191, label %for.cond164.preheader

for.cond164.preheader:                            ; preds = %if.end156
  %33 = shl nsw i32 %cond.i.i1212.2, 10
  %mul172 = and i32 %33, 64512
  %add176 = add nuw nsw i32 %add105, %mul172
  %idxprom182 = zext nneg i32 %add176 to i64
  %arrayidx183 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx183, align 2, !tbaa !63
  %add179.4 = or disjoint i32 %add176, 4
  %idxprom182.4 = zext nneg i32 %add179.4 to i64
  %arrayidx183.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182.4
  %35 = load <4 x half>, ptr addrspace(4) %arrayidx183.4, align 2, !tbaa !63
  %36 = zext nneg i32 %add176 to i64
  %37 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %36
  %arrayidx183.8 = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1024
  %38 = load <4 x half>, ptr addrspace(4) %arrayidx183.8, align 2, !tbaa !63
  %39 = zext nneg i32 %add176 to i64
  %40 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %39
  %arrayidx183.12 = getelementptr inbounds i8, ptr addrspace(4) %40, i64 1032
  %41 = load <4 x half>, ptr addrspace(4) %arrayidx183.12, align 2, !tbaa !63
  br label %if.end191

if.end191:                                        ; preds = %for.cond164.preheader, %if.end156
  %K_reg2.sroa.32.0 = phi <4 x half> [ undef, %if.end156 ], [ %41, %for.cond164.preheader ]
  %K_reg2.sroa.22.0 = phi <4 x half> [ undef, %if.end156 ], [ %38, %for.cond164.preheader ]
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end156 ], [ %35, %for.cond164.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end156 ], [ %34, %for.cond164.preheader ]
  %or.cond1293 = icmp ugt i32 %mul12.3, 1023
  %cmp197.not = icmp sgt i32 %mul12.3, %1
  %or.cond1294 = or i1 %or.cond1293, %cmp197.not
  br i1 %or.cond1294, label %if.end226, label %for.cond199.preheader

for.cond199.preheader:                            ; preds = %if.end191
  %42 = shl nsw i32 %cond.i.i1212.3, 10
  %mul207 = and i32 %42, 64512
  %add211 = add nuw nsw i32 %add105, %mul207
  %idxprom217 = zext nneg i32 %add211 to i64
  %arrayidx218 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217
  %43 = load <4 x half>, ptr addrspace(4) %arrayidx218, align 2, !tbaa !63
  %add214.4 = or disjoint i32 %add211, 4
  %idxprom217.4 = zext nneg i32 %add214.4 to i64
  %arrayidx218.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217.4
  %44 = load <4 x half>, ptr addrspace(4) %arrayidx218.4, align 2, !tbaa !63
  %45 = zext nneg i32 %add211 to i64
  %46 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %45
  %arrayidx218.8 = getelementptr inbounds i8, ptr addrspace(4) %46, i64 1024
  %47 = load <4 x half>, ptr addrspace(4) %arrayidx218.8, align 2, !tbaa !63
  %48 = zext nneg i32 %add211 to i64
  %49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %48
  %arrayidx218.12 = getelementptr inbounds i8, ptr addrspace(4) %49, i64 1032
  %50 = load <4 x half>, ptr addrspace(4) %arrayidx218.12, align 2, !tbaa !63
  br label %if.end226

if.end226:                                        ; preds = %for.cond199.preheader, %if.end191
  %K_reg3.sroa.32.0 = phi <4 x half> [ undef, %if.end191 ], [ %50, %for.cond199.preheader ]
  %K_reg3.sroa.22.0 = phi <4 x half> [ undef, %if.end191 ], [ %47, %for.cond199.preheader ]
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end191 ], [ %44, %for.cond199.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end191 ], [ %43, %for.cond199.preheader ]
  br i1 %or.cond1288, label %if.end375, label %for.cond234.preheader

for.cond234.preheader:                            ; preds = %if.end226
  %51 = shl nsw i32 %cond.i.i1212, 10
  %mul242 = and i32 %51, 64512
  %add246 = add nuw nsw i32 %add105, %mul242
  %idxprom252 = zext nneg i32 %add246 to i64
  %arrayidx253 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252
  %52 = load <4 x half>, ptr addrspace(4) %arrayidx253, align 2, !tbaa !63
  %add249.4 = or disjoint i32 %add246, 4
  %idxprom252.4 = zext nneg i32 %add249.4 to i64
  %arrayidx253.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252.4
  %53 = load <4 x half>, ptr addrspace(4) %arrayidx253.4, align 2, !tbaa !63
  %54 = zext nneg i32 %add246 to i64
  %55 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %54
  %arrayidx253.8 = getelementptr inbounds i8, ptr addrspace(4) %55, i64 1024
  %56 = load <4 x half>, ptr addrspace(4) %arrayidx253.8, align 2, !tbaa !63
  %57 = zext nneg i32 %add246 to i64
  %58 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %57
  %arrayidx253.12 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1032
  %59 = load <4 x half>, ptr addrspace(4) %arrayidx253.12, align 2, !tbaa !63
  %cmp263 = icmp sgt i32 %mul12, %invariant.op
  br i1 %cmp263, label %for.cond265.preheader, label %if.end288

for.cond265.preheader:                            ; preds = %for.cond234.preheader
  %add272 = add nuw nsw i32 %mul12, %mul271
  %cmp275.not = icmp sgt i32 %add272, %1
  %fneg. = select i1 %cmp275.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1460 = insertelement <4 x float> poison, float %fneg., i64 0
  %cmp275.not.1.not = icmp slt i32 %add272, %1
  %fneg..1 = select i1 %cmp275.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1561 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1460, float %fneg..1, i64 1
  %add273.2 = or disjoint i32 %add272, 2
  %cmp275.not.2 = icmp sgt i32 %add273.2, %1
  %fneg..2 = select i1 %cmp275.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1654 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1561, float %fneg..2, i64 2
  %add273.3 = or disjoint i32 %add272, 3
  %cmp275.not.3 = icmp sgt i32 %add273.3, %1
  %fneg..3 = select i1 %cmp275.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1747 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1654, float %fneg..3, i64 3
  br label %if.end288

if.end288:                                        ; preds = %for.cond234.preheader, %for.cond265.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1747, %for.cond265.preheader ], [ zeroinitializer, %for.cond234.preheader ]
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !88
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %60), !call_argsrelate !88
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %61), !call_argsrelate !88
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %62), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %63, i64 0
  %mul323 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul323, float 0x4024CB5EC0000000)
  %65 = tail call contract noundef float @llvm.exp.f32(float %64)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %63, i64 1
  %mul323.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul323.1, float 0x4024CB5EC0000000)
  %67 = tail call contract noundef float @llvm.exp.f32(float %66)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %63, i64 2
  %mul323.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul323.2, float 0x4024CB5EC0000000)
  %69 = tail call contract noundef float @llvm.exp.f32(float %68)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %63, i64 3
  %mul323.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul323.3, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %65)
  %73 = insertelement <4 x i16> poison, i16 %72, i64 0
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %67)
  %75 = insertelement <4 x i16> %73, i16 %74, i64 1
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %69)
  %77 = insertelement <4 x i16> %75, i16 %76, i64 2
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %79 = insertelement <4 x i16> %77, i16 %78, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %79 to <4 x half>
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %52, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !108
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %53, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !108
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !108
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %59, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !call_argsrelate !108
  br label %if.end375

if.end375:                                        ; preds = %if.end288, %if.end226
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %83, %if.end288 ]
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %82, %if.end288 ]
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %81, %if.end288 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %80, %if.end288 ]
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end226 ], [ %71, %if.end288 ]
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end226 ], [ %69, %if.end288 ]
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end226 ], [ %67, %if.end288 ]
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end226 ], [ %65, %if.end288 ]
  br i1 %or.cond1290, label %if.end525, label %for.cond383.preheader

for.cond383.preheader:                            ; preds = %if.end375
  %84 = shl nsw i32 %cond.i.i1212.1, 10
  %mul391 = and i32 %84, 64512
  %add395 = add nuw nsw i32 %add105, %mul391
  %idxprom401 = zext nneg i32 %add395 to i64
  %arrayidx402 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401
  %85 = load <4 x half>, ptr addrspace(4) %arrayidx402, align 2, !tbaa !63
  %add398.4 = or disjoint i32 %add395, 4
  %idxprom401.4 = zext nneg i32 %add398.4 to i64
  %arrayidx402.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401.4
  %86 = load <4 x half>, ptr addrspace(4) %arrayidx402.4, align 2, !tbaa !63
  %87 = zext nneg i32 %add395 to i64
  %88 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %87
  %arrayidx402.8 = getelementptr inbounds i8, ptr addrspace(4) %88, i64 1024
  %89 = load <4 x half>, ptr addrspace(4) %arrayidx402.8, align 2, !tbaa !63
  %90 = zext nneg i32 %add395 to i64
  %91 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90
  %arrayidx402.12 = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1032
  %92 = load <4 x half>, ptr addrspace(4) %arrayidx402.12, align 2, !tbaa !63
  %cmp412 = icmp sgt i32 %mul12.1, %invariant.op
  br i1 %cmp412, label %for.cond414.preheader, label %if.end438

for.cond414.preheader:                            ; preds = %for.cond383.preheader
  %add421 = add nuw nsw i32 %mul12.1, %mul271
  %cmp424.not = icmp sgt i32 %add421, %1
  %fneg.1201 = select i1 %cmp424.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1469 = insertelement <4 x float> poison, float %fneg.1201, i64 0
  %cmp424.not.1.not = icmp slt i32 %add421, %1
  %fneg.1201.1 = select i1 %cmp424.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1570 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1469, float %fneg.1201.1, i64 1
  %add422.2 = or disjoint i32 %add421, 2
  %cmp424.not.2 = icmp sgt i32 %add422.2, %1
  %fneg.1201.2 = select i1 %cmp424.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1663 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1570, float %fneg.1201.2, i64 2
  %add422.3 = or disjoint i32 %add421, 3
  %cmp424.not.3 = icmp sgt i32 %add422.3, %1
  %fneg.1201.3 = select i1 %cmp424.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1756 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1663, float %fneg.1201.3, i64 3
  br label %if.end438

if.end438:                                        ; preds = %for.cond383.preheader, %for.cond414.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1756, %for.cond414.preheader ], [ zeroinitializer, %for.cond383.preheader ]
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !call_argsrelate !88
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %93), !call_argsrelate !88
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %94), !call_argsrelate !88
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %95), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1471 = extractelement <4 x float> %96, i64 0
  %mul473 = fmul contract float %acc_s.sroa.0.0.vec.extract1471, 0x3FB99999A0000000
  %97 = tail call contract noundef float @llvm.minnum.f32(float %mul473, float 0x4024CB5EC0000000)
  %98 = tail call contract noundef float @llvm.exp.f32(float %97)
  %acc_s.sroa.0.4.vec.extract1572 = extractelement <4 x float> %96, i64 1
  %mul473.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1572, 0x3FB99999A0000000
  %99 = tail call contract noundef float @llvm.minnum.f32(float %mul473.1, float 0x4024CB5EC0000000)
  %100 = tail call contract noundef float @llvm.exp.f32(float %99)
  %acc_s.sroa.0.8.vec.extract1665 = extractelement <4 x float> %96, i64 2
  %mul473.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1665, 0x3FB99999A0000000
  %101 = tail call contract noundef float @llvm.minnum.f32(float %mul473.2, float 0x4024CB5EC0000000)
  %102 = tail call contract noundef float @llvm.exp.f32(float %101)
  %acc_s.sroa.0.12.vec.extract1758 = extractelement <4 x float> %96, i64 3
  %mul473.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1758, 0x3FB99999A0000000
  %103 = tail call contract noundef float @llvm.minnum.f32(float %mul473.3, float 0x4024CB5EC0000000)
  %104 = tail call contract noundef float @llvm.exp.f32(float %103)
  %add489 = fadd contract float %sum_acc.sroa.0.0, %98
  %add489.1 = fadd contract float %sum_acc.sroa.20.0, %100
  %add489.2 = fadd contract float %sum_acc.sroa.38.0, %102
  %add489.3 = fadd contract float %sum_acc.sroa.56.0, %104
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %98)
  %106 = insertelement <4 x i16> poison, i16 %105, i64 0
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %100)
  %108 = insertelement <4 x i16> %106, i16 %107, i64 1
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %102)
  %110 = insertelement <4 x i16> %108, i16 %109, i64 2
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %104)
  %112 = insertelement <4 x i16> %110, i16 %111, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1432 = bitcast <4 x i16> %112 to <4 x half>
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %85, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !call_argsrelate !108
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %86, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !call_argsrelate !108
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %89, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !call_argsrelate !108
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %92, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !call_argsrelate !108
  br label %if.end525

if.end525:                                        ; preds = %if.end438, %if.end375
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %116, %if.end438 ]
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %115, %if.end438 ]
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %114, %if.end438 ]
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %113, %if.end438 ]
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end375 ], [ %add489.3, %if.end438 ]
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end375 ], [ %add489.2, %if.end438 ]
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end375 ], [ %add489.1, %if.end438 ]
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end375 ], [ %add489, %if.end438 ]
  br i1 %or.cond1292, label %if.end675, label %for.cond533.preheader

for.cond533.preheader:                            ; preds = %if.end525
  %117 = shl nsw i32 %cond.i.i1212.2, 10
  %mul541 = and i32 %117, 64512
  %add545 = add nuw nsw i32 %add105, %mul541
  %idxprom551 = zext nneg i32 %add545 to i64
  %arrayidx552 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551
  %118 = load <4 x half>, ptr addrspace(4) %arrayidx552, align 2, !tbaa !63
  %add548.4 = or disjoint i32 %add545, 4
  %idxprom551.4 = zext nneg i32 %add548.4 to i64
  %arrayidx552.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551.4
  %119 = load <4 x half>, ptr addrspace(4) %arrayidx552.4, align 2, !tbaa !63
  %120 = zext nneg i32 %add545 to i64
  %121 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %120
  %arrayidx552.8 = getelementptr inbounds i8, ptr addrspace(4) %121, i64 1024
  %122 = load <4 x half>, ptr addrspace(4) %arrayidx552.8, align 2, !tbaa !63
  %123 = zext nneg i32 %add545 to i64
  %124 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %123
  %arrayidx552.12 = getelementptr inbounds i8, ptr addrspace(4) %124, i64 1032
  %125 = load <4 x half>, ptr addrspace(4) %arrayidx552.12, align 2, !tbaa !63
  %cmp562 = icmp sgt i32 %mul12.2, %invariant.op
  br i1 %cmp562, label %for.cond564.preheader, label %if.end588

for.cond564.preheader:                            ; preds = %for.cond533.preheader
  %add571 = add nuw nsw i32 %mul12.2, %mul271
  %cmp574.not = icmp sgt i32 %add571, %1
  %fneg.1202 = select i1 %cmp574.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1479 = insertelement <4 x float> poison, float %fneg.1202, i64 0
  %cmp574.not.1.not = icmp slt i32 %add571, %1
  %fneg.1202.1 = select i1 %cmp574.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1580 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1479, float %fneg.1202.1, i64 1
  %add572.2 = or disjoint i32 %add571, 2
  %cmp574.not.2 = icmp sgt i32 %add572.2, %1
  %fneg.1202.2 = select i1 %cmp574.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1673 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1580, float %fneg.1202.2, i64 2
  %add572.3 = or disjoint i32 %add571, 3
  %cmp574.not.3 = icmp sgt i32 %add572.3, %1
  %fneg.1202.3 = select i1 %cmp574.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1766 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1673, float %fneg.1202.3, i64 3
  br label %if.end588

if.end588:                                        ; preds = %for.cond533.preheader, %for.cond564.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1766, %for.cond564.preheader ], [ zeroinitializer, %for.cond533.preheader ]
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !call_argsrelate !88
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %126), !call_argsrelate !88
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %127), !call_argsrelate !88
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %128), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1481 = extractelement <4 x float> %129, i64 0
  %mul623 = fmul contract float %acc_s.sroa.0.0.vec.extract1481, 0x3FB99999A0000000
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul623, float 0x4024CB5EC0000000)
  %131 = tail call contract noundef float @llvm.exp.f32(float %130)
  %acc_s.sroa.0.4.vec.extract1582 = extractelement <4 x float> %129, i64 1
  %mul623.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1582, 0x3FB99999A0000000
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1, float 0x4024CB5EC0000000)
  %133 = tail call contract noundef float @llvm.exp.f32(float %132)
  %acc_s.sroa.0.8.vec.extract1675 = extractelement <4 x float> %129, i64 2
  %mul623.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1675, 0x3FB99999A0000000
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2, float 0x4024CB5EC0000000)
  %135 = tail call contract noundef float @llvm.exp.f32(float %134)
  %acc_s.sroa.0.12.vec.extract1768 = extractelement <4 x float> %129, i64 3
  %mul623.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1768, 0x3FB99999A0000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3, float 0x4024CB5EC0000000)
  %137 = tail call contract noundef float @llvm.exp.f32(float %136)
  %add639 = fadd contract float %sum_acc.sroa.0.1, %131
  %add639.1 = fadd contract float %sum_acc.sroa.20.1, %133
  %add639.2 = fadd contract float %sum_acc.sroa.38.1, %135
  %add639.3 = fadd contract float %sum_acc.sroa.56.1, %137
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131)
  %139 = insertelement <4 x i16> poison, i16 %138, i64 0
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133)
  %141 = insertelement <4 x i16> %139, i16 %140, i64 1
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135)
  %143 = insertelement <4 x i16> %141, i16 %142, i64 2
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137)
  %145 = insertelement <4 x i16> %143, i16 %144, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1434 = bitcast <4 x i16> %145 to <4 x half>
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %118, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.0.0), !call_argsrelate !108
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %119, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.34.0), !call_argsrelate !108
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.66.0), !call_argsrelate !108
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %125, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.98.0), !call_argsrelate !108
  br label %if.end675

if.end675:                                        ; preds = %if.end588, %if.end525
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end525 ], [ %149, %if.end588 ]
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end525 ], [ %148, %if.end588 ]
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end525 ], [ %147, %if.end588 ]
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end525 ], [ %146, %if.end588 ]
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end525 ], [ %add639.3, %if.end588 ]
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end525 ], [ %add639.2, %if.end588 ]
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end525 ], [ %add639.1, %if.end588 ]
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end525 ], [ %add639, %if.end588 ]
  br i1 %or.cond1294, label %if.end825, label %for.cond683.preheader

for.cond683.preheader:                            ; preds = %if.end675
  %150 = shl nsw i32 %cond.i.i1212.3, 10
  %mul691 = and i32 %150, 64512
  %add695 = add nuw nsw i32 %add105, %mul691
  %idxprom701 = zext nneg i32 %add695 to i64
  %arrayidx702 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701
  %151 = load <4 x half>, ptr addrspace(4) %arrayidx702, align 2, !tbaa !63
  %add698.4 = or disjoint i32 %add695, 4
  %idxprom701.4 = zext nneg i32 %add698.4 to i64
  %arrayidx702.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701.4
  %152 = load <4 x half>, ptr addrspace(4) %arrayidx702.4, align 2, !tbaa !63
  %153 = zext nneg i32 %add695 to i64
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153
  %arrayidx702.8 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024
  %155 = load <4 x half>, ptr addrspace(4) %arrayidx702.8, align 2, !tbaa !63
  %156 = zext nneg i32 %add695 to i64
  %157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156
  %arrayidx702.12 = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1032
  %158 = load <4 x half>, ptr addrspace(4) %arrayidx702.12, align 2, !tbaa !63
  %cmp712 = icmp sgt i32 %mul12.3, %invariant.op
  br i1 %cmp712, label %for.cond714.preheader, label %if.end738

for.cond714.preheader:                            ; preds = %for.cond683.preheader
  %add721 = add nuw nsw i32 %mul12.3, %mul271
  %cmp724.not = icmp sgt i32 %add721, %1
  %fneg.1203 = select i1 %cmp724.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1489 = insertelement <4 x float> poison, float %fneg.1203, i64 0
  %cmp724.not.1.not = icmp slt i32 %add721, %1
  %fneg.1203.1 = select i1 %cmp724.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1590 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1489, float %fneg.1203.1, i64 1
  %add722.2 = or disjoint i32 %add721, 2
  %cmp724.not.2 = icmp sgt i32 %add722.2, %1
  %fneg.1203.2 = select i1 %cmp724.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1683 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1590, float %fneg.1203.2, i64 2
  %add722.3 = or disjoint i32 %add721, 3
  %cmp724.not.3 = icmp sgt i32 %add722.3, %1
  %fneg.1203.3 = select i1 %cmp724.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1776 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1683, float %fneg.1203.3, i64 3
  br label %if.end738

if.end738:                                        ; preds = %for.cond683.preheader, %for.cond714.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1776, %for.cond714.preheader ], [ zeroinitializer, %for.cond683.preheader ]
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !call_argsrelate !88
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %159), !call_argsrelate !88
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %160), !call_argsrelate !88
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %161), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1491 = extractelement <4 x float> %162, i64 0
  %mul773 = fmul contract float %acc_s.sroa.0.0.vec.extract1491, 0x3FB99999A0000000
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul773, float 0x4024CB5EC0000000)
  %164 = tail call contract noundef float @llvm.exp.f32(float %163)
  %acc_s.sroa.0.4.vec.extract1592 = extractelement <4 x float> %162, i64 1
  %mul773.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1592, 0x3FB99999A0000000
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul773.1, float 0x4024CB5EC0000000)
  %166 = tail call contract noundef float @llvm.exp.f32(float %165)
  %acc_s.sroa.0.8.vec.extract1685 = extractelement <4 x float> %162, i64 2
  %mul773.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1685, 0x3FB99999A0000000
  %167 = tail call contract noundef float @llvm.minnum.f32(float %mul773.2, float 0x4024CB5EC0000000)
  %168 = tail call contract noundef float @llvm.exp.f32(float %167)
  %acc_s.sroa.0.12.vec.extract1778 = extractelement <4 x float> %162, i64 3
  %mul773.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1778, 0x3FB99999A0000000
  %169 = tail call contract noundef float @llvm.minnum.f32(float %mul773.3, float 0x4024CB5EC0000000)
  %170 = tail call contract noundef float @llvm.exp.f32(float %169)
  %add789 = fadd contract float %sum_acc.sroa.0.2, %164
  %add789.1 = fadd contract float %sum_acc.sroa.20.2, %166
  %add789.2 = fadd contract float %sum_acc.sroa.38.2, %168
  %add789.3 = fadd contract float %sum_acc.sroa.56.2, %170
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164)
  %172 = insertelement <4 x i16> poison, i16 %171, i64 0
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166)
  %174 = insertelement <4 x i16> %172, i16 %173, i64 1
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %168)
  %176 = insertelement <4 x i16> %174, i16 %175, i64 2
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %170)
  %178 = insertelement <4 x i16> %176, i16 %177, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1436 = bitcast <4 x i16> %178 to <4 x half>
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %151, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.0.0), !call_argsrelate !108
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %152, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.18.0), !call_argsrelate !108
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %155, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.34.0), !call_argsrelate !108
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %158, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.50.0), !call_argsrelate !108
  br label %if.end825

if.end825:                                        ; preds = %if.end738, %if.end675
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end675 ], [ %182, %if.end738 ]
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end675 ], [ %181, %if.end738 ]
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end675 ], [ %180, %if.end738 ]
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end675 ], [ %179, %if.end738 ]
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end675 ], [ %add789.3, %if.end738 ]
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end675 ], [ %add789.2, %if.end738 ]
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end675 ], [ %add789.1, %if.end738 ]
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end675 ], [ %add789, %if.end738 ]
  %or.cond.1 = icmp ugt i32 %mul12.4, 1023
  %cmp95.not.1 = icmp sgt i32 %mul12.4, %1
  %or.cond1288.1 = or i1 %or.cond.1, %cmp95.not.1
  br i1 %or.cond1288.1, label %if.end.1, label %for.cond96.preheader.1

for.cond96.preheader.1:                           ; preds = %if.end825
  %183 = shl nsw i32 %cond.i.i1212.4, 10
  %mul104.1 = and i32 %183, 64512
  %add108.1 = add nuw nsw i32 %add105, %mul104.1
  %idxprom114.11320 = zext nneg i32 %add108.1 to i64
  %arrayidx115.11321 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114.11320
  %184 = load <4 x half>, ptr addrspace(4) %arrayidx115.11321, align 2, !tbaa !63
  %add111.4.1 = or disjoint i32 %add108.1, 4
  %idxprom114.4.1 = zext nneg i32 %add111.4.1 to i64
  %arrayidx115.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114.4.1
  %185 = load <4 x half>, ptr addrspace(4) %arrayidx115.4.1, align 2, !tbaa !63
  %186 = zext nneg i32 %add108.1 to i64
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %186
  %arrayidx115.8.1 = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1024
  %188 = load <4 x half>, ptr addrspace(4) %arrayidx115.8.1, align 2, !tbaa !63
  %189 = zext nneg i32 %add108.1 to i64
  %190 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %189
  %arrayidx115.12.1 = getelementptr inbounds i8, ptr addrspace(4) %190, i64 1032
  %191 = load <4 x half>, ptr addrspace(4) %arrayidx115.12.1, align 2, !tbaa !63
  br label %if.end.1

if.end.1:                                         ; preds = %for.cond96.preheader.1, %if.end825
  %K_reg.sroa.32.1 = phi <4 x half> [ %K_reg.sroa.32.0, %if.end825 ], [ %191, %for.cond96.preheader.1 ]
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end825 ], [ %188, %for.cond96.preheader.1 ]
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end825 ], [ %185, %for.cond96.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end825 ], [ %184, %for.cond96.preheader.1 ]
  %or.cond1289.1 = icmp ugt i32 %mul12.5, 1023
  %cmp127.not.1 = icmp sgt i32 %mul12.5, %1
  %or.cond1290.1 = or i1 %or.cond1289.1, %cmp127.not.1
  br i1 %or.cond1290.1, label %if.end156.1, label %for.cond129.preheader.1

for.cond129.preheader.1:                          ; preds = %if.end.1
  %192 = shl nsw i32 %cond.i.i1212.5, 10
  %mul137.1 = and i32 %192, 64512
  %add141.1 = add nuw nsw i32 %add105, %mul137.1
  %idxprom147.11323 = zext nneg i32 %add141.1 to i64
  %arrayidx148.11324 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147.11323
  %193 = load <4 x half>, ptr addrspace(4) %arrayidx148.11324, align 2, !tbaa !63
  %add144.4.1 = or disjoint i32 %add141.1, 4
  %idxprom147.4.1 = zext nneg i32 %add144.4.1 to i64
  %arrayidx148.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147.4.1
  %194 = load <4 x half>, ptr addrspace(4) %arrayidx148.4.1, align 2, !tbaa !63
  %195 = zext nneg i32 %add141.1 to i64
  %196 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %195
  %arrayidx148.8.1 = getelementptr inbounds i8, ptr addrspace(4) %196, i64 1024
  %197 = load <4 x half>, ptr addrspace(4) %arrayidx148.8.1, align 2, !tbaa !63
  %198 = zext nneg i32 %add141.1 to i64
  %199 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %198
  %arrayidx148.12.1 = getelementptr inbounds i8, ptr addrspace(4) %199, i64 1032
  %200 = load <4 x half>, ptr addrspace(4) %arrayidx148.12.1, align 2, !tbaa !63
  br label %if.end156.1

if.end156.1:                                      ; preds = %for.cond129.preheader.1, %if.end.1
  %K_reg1.sroa.32.1 = phi <4 x half> [ %K_reg1.sroa.32.0, %if.end.1 ], [ %200, %for.cond129.preheader.1 ]
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end.1 ], [ %197, %for.cond129.preheader.1 ]
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %194, %for.cond129.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %193, %for.cond129.preheader.1 ]
  %or.cond1291.1 = icmp ugt i32 %mul12.6, 1023
  %cmp162.not.1 = icmp sgt i32 %mul12.6, %1
  %or.cond1292.1 = or i1 %or.cond1291.1, %cmp162.not.1
  br i1 %or.cond1292.1, label %if.end191.1, label %for.cond164.preheader.1

for.cond164.preheader.1:                          ; preds = %if.end156.1
  %201 = shl nsw i32 %cond.i.i1212.6, 10
  %mul172.1 = and i32 %201, 64512
  %add176.1 = add nuw nsw i32 %add105, %mul172.1
  %idxprom182.11326 = zext nneg i32 %add176.1 to i64
  %arrayidx183.11327 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182.11326
  %202 = load <4 x half>, ptr addrspace(4) %arrayidx183.11327, align 2, !tbaa !63
  %add179.4.1 = or disjoint i32 %add176.1, 4
  %idxprom182.4.1 = zext nneg i32 %add179.4.1 to i64
  %arrayidx183.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182.4.1
  %203 = load <4 x half>, ptr addrspace(4) %arrayidx183.4.1, align 2, !tbaa !63
  %204 = zext nneg i32 %add176.1 to i64
  %205 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %204
  %arrayidx183.8.1 = getelementptr inbounds i8, ptr addrspace(4) %205, i64 1024
  %206 = load <4 x half>, ptr addrspace(4) %arrayidx183.8.1, align 2, !tbaa !63
  %207 = zext nneg i32 %add176.1 to i64
  %208 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %207
  %arrayidx183.12.1 = getelementptr inbounds i8, ptr addrspace(4) %208, i64 1032
  %209 = load <4 x half>, ptr addrspace(4) %arrayidx183.12.1, align 2, !tbaa !63
  br label %if.end191.1

if.end191.1:                                      ; preds = %for.cond164.preheader.1, %if.end156.1
  %K_reg2.sroa.32.1 = phi <4 x half> [ %K_reg2.sroa.32.0, %if.end156.1 ], [ %209, %for.cond164.preheader.1 ]
  %K_reg2.sroa.22.1 = phi <4 x half> [ %K_reg2.sroa.22.0, %if.end156.1 ], [ %206, %for.cond164.preheader.1 ]
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end156.1 ], [ %203, %for.cond164.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end156.1 ], [ %202, %for.cond164.preheader.1 ]
  %or.cond1293.1 = icmp ugt i32 %mul12.7, 1023
  %cmp197.not.1 = icmp sgt i32 %mul12.7, %1
  %or.cond1294.1 = or i1 %or.cond1293.1, %cmp197.not.1
  br i1 %or.cond1294.1, label %if.end226.1, label %for.cond199.preheader.1

for.cond199.preheader.1:                          ; preds = %if.end191.1
  %210 = shl nsw i32 %cond.i.i1212.7, 10
  %mul207.1 = and i32 %210, 64512
  %add211.1 = add nuw nsw i32 %add105, %mul207.1
  %idxprom217.11329 = zext nneg i32 %add211.1 to i64
  %arrayidx218.11330 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217.11329
  %211 = load <4 x half>, ptr addrspace(4) %arrayidx218.11330, align 2, !tbaa !63
  %add214.4.1 = or disjoint i32 %add211.1, 4
  %idxprom217.4.1 = zext nneg i32 %add214.4.1 to i64
  %arrayidx218.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217.4.1
  %212 = load <4 x half>, ptr addrspace(4) %arrayidx218.4.1, align 2, !tbaa !63
  %213 = zext nneg i32 %add211.1 to i64
  %214 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %213
  %arrayidx218.8.1 = getelementptr inbounds i8, ptr addrspace(4) %214, i64 1024
  %215 = load <4 x half>, ptr addrspace(4) %arrayidx218.8.1, align 2, !tbaa !63
  %216 = zext nneg i32 %add211.1 to i64
  %217 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %216
  %arrayidx218.12.1 = getelementptr inbounds i8, ptr addrspace(4) %217, i64 1032
  %218 = load <4 x half>, ptr addrspace(4) %arrayidx218.12.1, align 2, !tbaa !63
  br label %if.end226.1

if.end226.1:                                      ; preds = %for.cond199.preheader.1, %if.end191.1
  %K_reg3.sroa.32.1 = phi <4 x half> [ %K_reg3.sroa.32.0, %if.end191.1 ], [ %218, %for.cond199.preheader.1 ]
  %K_reg3.sroa.22.1 = phi <4 x half> [ %K_reg3.sroa.22.0, %if.end191.1 ], [ %215, %for.cond199.preheader.1 ]
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end191.1 ], [ %212, %for.cond199.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end191.1 ], [ %211, %for.cond199.preheader.1 ]
  br i1 %or.cond1288.1, label %if.end375.1, label %for.cond234.preheader.1

for.cond234.preheader.1:                          ; preds = %if.end226.1
  %219 = shl nsw i32 %cond.i.i1212.4, 10
  %mul242.1 = and i32 %219, 64512
  %add246.1 = add nuw nsw i32 %add105, %mul242.1
  %idxprom252.11332 = zext nneg i32 %add246.1 to i64
  %arrayidx253.11333 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252.11332
  %220 = load <4 x half>, ptr addrspace(4) %arrayidx253.11333, align 2, !tbaa !63
  %add249.4.1 = or disjoint i32 %add246.1, 4
  %idxprom252.4.1 = zext nneg i32 %add249.4.1 to i64
  %arrayidx253.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252.4.1
  %221 = load <4 x half>, ptr addrspace(4) %arrayidx253.4.1, align 2, !tbaa !63
  %222 = zext nneg i32 %add246.1 to i64
  %223 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %222
  %arrayidx253.8.1 = getelementptr inbounds i8, ptr addrspace(4) %223, i64 1024
  %224 = load <4 x half>, ptr addrspace(4) %arrayidx253.8.1, align 2, !tbaa !63
  %225 = zext nneg i32 %add246.1 to i64
  %226 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %225
  %arrayidx253.12.1 = getelementptr inbounds i8, ptr addrspace(4) %226, i64 1032
  %227 = load <4 x half>, ptr addrspace(4) %arrayidx253.12.1, align 2, !tbaa !63
  %cmp263.1 = icmp sgt i32 %mul12.4, %invariant.op
  br i1 %cmp263.1, label %for.cond265.preheader.1, label %if.end288.1

for.cond265.preheader.1:                          ; preds = %for.cond234.preheader.1
  %add272.1 = add nuw nsw i32 %mul12.4, %mul271
  %cmp275.not.11335 = icmp sgt i32 %add272.1, %1
  %fneg..11336 = select i1 %cmp275.not.11335, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1501 = insertelement <4 x float> poison, float %fneg..11336, i64 0
  %cmp275.not.1.1.not = icmp slt i32 %add272.1, %1
  %fneg..1.1 = select i1 %cmp275.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1600 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1501, float %fneg..1.1, i64 1
  %add273.2.1 = or disjoint i32 %add272.1, 2
  %cmp275.not.2.1 = icmp sgt i32 %add273.2.1, %1
  %fneg..2.1 = select i1 %cmp275.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1693 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1600, float %fneg..2.1, i64 2
  %add273.3.1 = or disjoint i32 %add272.1, 3
  %cmp275.not.3.1 = icmp sgt i32 %add273.3.1, %1
  %fneg..3.1 = select i1 %cmp275.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1786 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1693, float %fneg..3.1, i64 3
  br label %if.end288.1

if.end288.1:                                      ; preds = %for.cond234.preheader.1, %for.cond265.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1786, %for.cond265.preheader.1 ], [ zeroinitializer, %for.cond234.preheader.1 ]
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !call_argsrelate !88
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %228), !call_argsrelate !88
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %229), !call_argsrelate !88
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %230), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1503 = extractelement <4 x float> %231, i64 0
  %mul323.11340 = fmul contract float %acc_s.sroa.0.0.vec.extract1503, 0x3FB99999A0000000
  %232 = tail call contract noundef float @llvm.minnum.f32(float %mul323.11340, float 0x4024CB5EC0000000)
  %233 = tail call contract noundef float @llvm.exp.f32(float %232)
  %acc_s.sroa.0.4.vec.extract1602 = extractelement <4 x float> %231, i64 1
  %mul323.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1602, 0x3FB99999A0000000
  %234 = tail call contract noundef float @llvm.minnum.f32(float %mul323.1.1, float 0x4024CB5EC0000000)
  %235 = tail call contract noundef float @llvm.exp.f32(float %234)
  %acc_s.sroa.0.8.vec.extract1695 = extractelement <4 x float> %231, i64 2
  %mul323.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1695, 0x3FB99999A0000000
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul323.2.1, float 0x4024CB5EC0000000)
  %237 = tail call contract noundef float @llvm.exp.f32(float %236)
  %acc_s.sroa.0.12.vec.extract1788 = extractelement <4 x float> %231, i64 3
  %mul323.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1788, 0x3FB99999A0000000
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul323.3.1, float 0x4024CB5EC0000000)
  %239 = tail call contract noundef float @llvm.exp.f32(float %238)
  %add339.11341 = fadd contract float %sum_acc.sroa.0.3, %233
  %add339.1.1 = fadd contract float %sum_acc.sroa.20.3, %235
  %add339.2.1 = fadd contract float %sum_acc.sroa.38.3, %237
  %add339.3.1 = fadd contract float %sum_acc.sroa.56.3, %239
  %240 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %233)
  %241 = insertelement <4 x i16> poison, i16 %240, i64 0
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %235)
  %243 = insertelement <4 x i16> %241, i16 %242, i64 1
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237)
  %245 = insertelement <4 x i16> %243, i16 %244, i64 2
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239)
  %247 = insertelement <4 x i16> %245, i16 %246, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1438 = bitcast <4 x i16> %247 to <4 x half>
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %220, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.0.1), !call_argsrelate !108
  %249 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %221, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.34.1), !call_argsrelate !108
  %250 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.66.1), !call_argsrelate !108
  %251 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %227, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.98.1), !call_argsrelate !108
  br label %if.end375.1

if.end375.1:                                      ; preds = %if.end288.1, %if.end226.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end226.1 ], [ %251, %if.end288.1 ]
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end226.1 ], [ %250, %if.end288.1 ]
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end226.1 ], [ %249, %if.end288.1 ]
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end226.1 ], [ %248, %if.end288.1 ]
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end226.1 ], [ %add339.3.1, %if.end288.1 ]
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end226.1 ], [ %add339.2.1, %if.end288.1 ]
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end226.1 ], [ %add339.1.1, %if.end288.1 ]
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end226.1 ], [ %add339.11341, %if.end288.1 ]
  br i1 %or.cond1290.1, label %if.end525.1, label %for.cond383.preheader.1

for.cond383.preheader.1:                          ; preds = %if.end375.1
  %252 = shl nsw i32 %cond.i.i1212.5, 10
  %mul391.1 = and i32 %252, 64512
  %add395.1 = add nuw nsw i32 %add105, %mul391.1
  %idxprom401.11342 = zext nneg i32 %add395.1 to i64
  %arrayidx402.11343 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401.11342
  %253 = load <4 x half>, ptr addrspace(4) %arrayidx402.11343, align 2, !tbaa !63
  %add398.4.1 = or disjoint i32 %add395.1, 4
  %idxprom401.4.1 = zext nneg i32 %add398.4.1 to i64
  %arrayidx402.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401.4.1
  %254 = load <4 x half>, ptr addrspace(4) %arrayidx402.4.1, align 2, !tbaa !63
  %255 = zext nneg i32 %add395.1 to i64
  %256 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %255
  %arrayidx402.8.1 = getelementptr inbounds i8, ptr addrspace(4) %256, i64 1024
  %257 = load <4 x half>, ptr addrspace(4) %arrayidx402.8.1, align 2, !tbaa !63
  %258 = zext nneg i32 %add395.1 to i64
  %259 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %258
  %arrayidx402.12.1 = getelementptr inbounds i8, ptr addrspace(4) %259, i64 1032
  %260 = load <4 x half>, ptr addrspace(4) %arrayidx402.12.1, align 2, !tbaa !63
  %cmp412.1 = icmp sgt i32 %mul12.5, %invariant.op
  br i1 %cmp412.1, label %for.cond414.preheader.1, label %if.end438.1

for.cond414.preheader.1:                          ; preds = %for.cond383.preheader.1
  %add421.1 = add nuw nsw i32 %mul12.5, %mul271
  %cmp424.not.11345 = icmp sgt i32 %add421.1, %1
  %fneg.1201.11346 = select i1 %cmp424.not.11345, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1513 = insertelement <4 x float> poison, float %fneg.1201.11346, i64 0
  %cmp424.not.1.1.not = icmp slt i32 %add421.1, %1
  %fneg.1201.1.1 = select i1 %cmp424.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1610 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1513, float %fneg.1201.1.1, i64 1
  %add422.2.1 = or disjoint i32 %add421.1, 2
  %cmp424.not.2.1 = icmp sgt i32 %add422.2.1, %1
  %fneg.1201.2.1 = select i1 %cmp424.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1703 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1610, float %fneg.1201.2.1, i64 2
  %add422.3.1 = or disjoint i32 %add421.1, 3
  %cmp424.not.3.1 = icmp sgt i32 %add422.3.1, %1
  %fneg.1201.3.1 = select i1 %cmp424.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1796 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1703, float %fneg.1201.3.1, i64 3
  br label %if.end438.1

if.end438.1:                                      ; preds = %for.cond383.preheader.1, %for.cond414.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1796, %for.cond414.preheader.1 ], [ zeroinitializer, %for.cond383.preheader.1 ]
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !call_argsrelate !88
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %261), !call_argsrelate !88
  %263 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %262), !call_argsrelate !88
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %263), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1515 = extractelement <4 x float> %264, i64 0
  %mul473.11350 = fmul contract float %acc_s.sroa.0.0.vec.extract1515, 0x3FB99999A0000000
  %265 = tail call contract noundef float @llvm.minnum.f32(float %mul473.11350, float 0x4024CB5EC0000000)
  %266 = tail call contract noundef float @llvm.exp.f32(float %265)
  %acc_s.sroa.0.4.vec.extract1612 = extractelement <4 x float> %264, i64 1
  %mul473.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1612, 0x3FB99999A0000000
  %267 = tail call contract noundef float @llvm.minnum.f32(float %mul473.1.1, float 0x4024CB5EC0000000)
  %268 = tail call contract noundef float @llvm.exp.f32(float %267)
  %acc_s.sroa.0.8.vec.extract1705 = extractelement <4 x float> %264, i64 2
  %mul473.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1705, 0x3FB99999A0000000
  %269 = tail call contract noundef float @llvm.minnum.f32(float %mul473.2.1, float 0x4024CB5EC0000000)
  %270 = tail call contract noundef float @llvm.exp.f32(float %269)
  %acc_s.sroa.0.12.vec.extract1798 = extractelement <4 x float> %264, i64 3
  %mul473.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1798, 0x3FB99999A0000000
  %271 = tail call contract noundef float @llvm.minnum.f32(float %mul473.3.1, float 0x4024CB5EC0000000)
  %272 = tail call contract noundef float @llvm.exp.f32(float %271)
  %add489.11351 = fadd contract float %sum_acc.sroa.0.4, %266
  %add489.1.1 = fadd contract float %sum_acc.sroa.20.4, %268
  %add489.2.1 = fadd contract float %sum_acc.sroa.38.4, %270
  %add489.3.1 = fadd contract float %sum_acc.sroa.56.4, %272
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %266)
  %274 = insertelement <4 x i16> poison, i16 %273, i64 0
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %268)
  %276 = insertelement <4 x i16> %274, i16 %275, i64 1
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %270)
  %278 = insertelement <4 x i16> %276, i16 %277, i64 2
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %272)
  %280 = insertelement <4 x i16> %278, i16 %279, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1440 = bitcast <4 x i16> %280 to <4 x half>
  %281 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %253, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.0.1), !call_argsrelate !108
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %254, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.18.1), !call_argsrelate !108
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %257, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.34.1), !call_argsrelate !108
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %260, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.50.1), !call_argsrelate !108
  br label %if.end525.1

if.end525.1:                                      ; preds = %if.end438.1, %if.end375.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end375.1 ], [ %284, %if.end438.1 ]
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end375.1 ], [ %283, %if.end438.1 ]
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end375.1 ], [ %282, %if.end438.1 ]
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end375.1 ], [ %281, %if.end438.1 ]
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end375.1 ], [ %add489.3.1, %if.end438.1 ]
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end375.1 ], [ %add489.2.1, %if.end438.1 ]
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end375.1 ], [ %add489.1.1, %if.end438.1 ]
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end375.1 ], [ %add489.11351, %if.end438.1 ]
  br i1 %or.cond1292.1, label %if.end675.1, label %for.cond533.preheader.1

for.cond533.preheader.1:                          ; preds = %if.end525.1
  %285 = shl nsw i32 %cond.i.i1212.6, 10
  %mul541.1 = and i32 %285, 64512
  %add545.1 = add nuw nsw i32 %add105, %mul541.1
  %idxprom551.11352 = zext nneg i32 %add545.1 to i64
  %arrayidx552.11353 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551.11352
  %286 = load <4 x half>, ptr addrspace(4) %arrayidx552.11353, align 2, !tbaa !63
  %add548.4.1 = or disjoint i32 %add545.1, 4
  %idxprom551.4.1 = zext nneg i32 %add548.4.1 to i64
  %arrayidx552.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551.4.1
  %287 = load <4 x half>, ptr addrspace(4) %arrayidx552.4.1, align 2, !tbaa !63
  %288 = zext nneg i32 %add545.1 to i64
  %289 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %288
  %arrayidx552.8.1 = getelementptr inbounds i8, ptr addrspace(4) %289, i64 1024
  %290 = load <4 x half>, ptr addrspace(4) %arrayidx552.8.1, align 2, !tbaa !63
  %291 = zext nneg i32 %add545.1 to i64
  %292 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %291
  %arrayidx552.12.1 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 1032
  %293 = load <4 x half>, ptr addrspace(4) %arrayidx552.12.1, align 2, !tbaa !63
  %cmp562.1 = icmp sgt i32 %mul12.6, %invariant.op
  br i1 %cmp562.1, label %for.cond564.preheader.1, label %if.end588.1

for.cond564.preheader.1:                          ; preds = %for.cond533.preheader.1
  %add571.1 = add nuw nsw i32 %mul12.6, %mul271
  %cmp574.not.11355 = icmp sgt i32 %add571.1, %1
  %fneg.1202.11356 = select i1 %cmp574.not.11355, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1525 = insertelement <4 x float> poison, float %fneg.1202.11356, i64 0
  %cmp574.not.1.1.not = icmp slt i32 %add571.1, %1
  %fneg.1202.1.1 = select i1 %cmp574.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1620 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1525, float %fneg.1202.1.1, i64 1
  %add572.2.1 = or disjoint i32 %add571.1, 2
  %cmp574.not.2.1 = icmp sgt i32 %add572.2.1, %1
  %fneg.1202.2.1 = select i1 %cmp574.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1713 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1620, float %fneg.1202.2.1, i64 2
  %add572.3.1 = or disjoint i32 %add571.1, 3
  %cmp574.not.3.1 = icmp sgt i32 %add572.3.1, %1
  %fneg.1202.3.1 = select i1 %cmp574.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1806 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1713, float %fneg.1202.3.1, i64 3
  br label %if.end588.1

if.end588.1:                                      ; preds = %for.cond533.preheader.1, %for.cond564.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1806, %for.cond564.preheader.1 ], [ zeroinitializer, %for.cond533.preheader.1 ]
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !call_argsrelate !88
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %294), !call_argsrelate !88
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %295), !call_argsrelate !88
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %296), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1527 = extractelement <4 x float> %297, i64 0
  %mul623.11360 = fmul contract float %acc_s.sroa.0.0.vec.extract1527, 0x3FB99999A0000000
  %298 = tail call contract noundef float @llvm.minnum.f32(float %mul623.11360, float 0x4024CB5EC0000000)
  %299 = tail call contract noundef float @llvm.exp.f32(float %298)
  %acc_s.sroa.0.4.vec.extract1622 = extractelement <4 x float> %297, i64 1
  %mul623.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1622, 0x3FB99999A0000000
  %300 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1.1, float 0x4024CB5EC0000000)
  %301 = tail call contract noundef float @llvm.exp.f32(float %300)
  %acc_s.sroa.0.8.vec.extract1715 = extractelement <4 x float> %297, i64 2
  %mul623.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1715, 0x3FB99999A0000000
  %302 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2.1, float 0x4024CB5EC0000000)
  %303 = tail call contract noundef float @llvm.exp.f32(float %302)
  %acc_s.sroa.0.12.vec.extract1808 = extractelement <4 x float> %297, i64 3
  %mul623.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1808, 0x3FB99999A0000000
  %304 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3.1, float 0x4024CB5EC0000000)
  %305 = tail call contract noundef float @llvm.exp.f32(float %304)
  %add639.11361 = fadd contract float %sum_acc.sroa.0.5, %299
  %add639.1.1 = fadd contract float %sum_acc.sroa.20.5, %301
  %add639.2.1 = fadd contract float %sum_acc.sroa.38.5, %303
  %add639.3.1 = fadd contract float %sum_acc.sroa.56.5, %305
  %306 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %299)
  %307 = insertelement <4 x i16> poison, i16 %306, i64 0
  %308 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %301)
  %309 = insertelement <4 x i16> %307, i16 %308, i64 1
  %310 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %303)
  %311 = insertelement <4 x i16> %309, i16 %310, i64 2
  %312 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %305)
  %313 = insertelement <4 x i16> %311, i16 %312, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1442 = bitcast <4 x i16> %313 to <4 x half>
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %286, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.0.2), !call_argsrelate !108
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %287, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.34.2), !call_argsrelate !108
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %290, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.66.2), !call_argsrelate !108
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %293, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.98.2), !call_argsrelate !108
  br label %if.end675.1

if.end675.1:                                      ; preds = %if.end588.1, %if.end525.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end525.1 ], [ %317, %if.end588.1 ]
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end525.1 ], [ %316, %if.end588.1 ]
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end525.1 ], [ %315, %if.end588.1 ]
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end525.1 ], [ %314, %if.end588.1 ]
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end525.1 ], [ %add639.3.1, %if.end588.1 ]
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end525.1 ], [ %add639.2.1, %if.end588.1 ]
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end525.1 ], [ %add639.1.1, %if.end588.1 ]
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end525.1 ], [ %add639.11361, %if.end588.1 ]
  br i1 %or.cond1294.1, label %if.end825.1, label %for.cond683.preheader.1

for.cond683.preheader.1:                          ; preds = %if.end675.1
  %318 = shl nsw i32 %cond.i.i1212.7, 10
  %mul691.1 = and i32 %318, 64512
  %add695.1 = add nuw nsw i32 %add105, %mul691.1
  %idxprom701.11362 = zext nneg i32 %add695.1 to i64
  %arrayidx702.11363 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701.11362
  %319 = load <4 x half>, ptr addrspace(4) %arrayidx702.11363, align 2, !tbaa !63
  %add698.4.1 = or disjoint i32 %add695.1, 4
  %idxprom701.4.1 = zext nneg i32 %add698.4.1 to i64
  %arrayidx702.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701.4.1
  %320 = load <4 x half>, ptr addrspace(4) %arrayidx702.4.1, align 2, !tbaa !63
  %321 = zext nneg i32 %add695.1 to i64
  %322 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %321
  %arrayidx702.8.1 = getelementptr inbounds i8, ptr addrspace(4) %322, i64 1024
  %323 = load <4 x half>, ptr addrspace(4) %arrayidx702.8.1, align 2, !tbaa !63
  %324 = zext nneg i32 %add695.1 to i64
  %325 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %324
  %arrayidx702.12.1 = getelementptr inbounds i8, ptr addrspace(4) %325, i64 1032
  %326 = load <4 x half>, ptr addrspace(4) %arrayidx702.12.1, align 2, !tbaa !63
  %cmp712.1 = icmp sgt i32 %mul12.7, %invariant.op
  br i1 %cmp712.1, label %for.cond714.preheader.1, label %if.end738.1

for.cond714.preheader.1:                          ; preds = %for.cond683.preheader.1
  %add721.1 = add nuw nsw i32 %mul12.7, %mul271
  %cmp724.not.11365 = icmp sgt i32 %add721.1, %1
  %fneg.1203.11366 = select i1 %cmp724.not.11365, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1537 = insertelement <4 x float> poison, float %fneg.1203.11366, i64 0
  %cmp724.not.1.1.not = icmp slt i32 %add721.1, %1
  %fneg.1203.1.1 = select i1 %cmp724.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1630 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1537, float %fneg.1203.1.1, i64 1
  %add722.2.1 = or disjoint i32 %add721.1, 2
  %cmp724.not.2.1 = icmp sgt i32 %add722.2.1, %1
  %fneg.1203.2.1 = select i1 %cmp724.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1723 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1630, float %fneg.1203.2.1, i64 2
  %add722.3.1 = or disjoint i32 %add721.1, 3
  %cmp724.not.3.1 = icmp sgt i32 %add722.3.1, %1
  %fneg.1203.3.1 = select i1 %cmp724.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1816 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1723, float %fneg.1203.3.1, i64 3
  br label %if.end738.1

if.end738.1:                                      ; preds = %for.cond683.preheader.1, %for.cond714.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1816, %for.cond714.preheader.1 ], [ zeroinitializer, %for.cond683.preheader.1 ]
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !call_argsrelate !88
  %328 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %327), !call_argsrelate !88
  %329 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %328), !call_argsrelate !88
  %330 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %329), !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1539 = extractelement <4 x float> %330, i64 0
  %mul773.11370 = fmul contract float %acc_s.sroa.0.0.vec.extract1539, 0x3FB99999A0000000
  %331 = tail call contract noundef float @llvm.minnum.f32(float %mul773.11370, float 0x4024CB5EC0000000)
  %332 = tail call contract noundef float @llvm.exp.f32(float %331)
  %acc_s.sroa.0.4.vec.extract1632 = extractelement <4 x float> %330, i64 1
  %mul773.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1632, 0x3FB99999A0000000
  %333 = tail call contract noundef float @llvm.minnum.f32(float %mul773.1.1, float 0x4024CB5EC0000000)
  %334 = tail call contract noundef float @llvm.exp.f32(float %333)
  %acc_s.sroa.0.8.vec.extract1725 = extractelement <4 x float> %330, i64 2
  %mul773.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1725, 0x3FB99999A0000000
  %335 = tail call contract noundef float @llvm.minnum.f32(float %mul773.2.1, float 0x4024CB5EC0000000)
  %336 = tail call contract noundef float @llvm.exp.f32(float %335)
  %acc_s.sroa.0.12.vec.extract1818 = extractelement <4 x float> %330, i64 3
  %mul773.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1818, 0x3FB99999A0000000
  %337 = tail call contract noundef float @llvm.minnum.f32(float %mul773.3.1, float 0x4024CB5EC0000000)
  %338 = tail call contract noundef float @llvm.exp.f32(float %337)
  %add789.11371 = fadd contract float %sum_acc.sroa.0.6, %332
  %add789.1.1 = fadd contract float %sum_acc.sroa.20.6, %334
  %add789.2.1 = fadd contract float %sum_acc.sroa.38.6, %336
  %add789.3.1 = fadd contract float %sum_acc.sroa.56.6, %338
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %332)
  %340 = insertelement <4 x i16> poison, i16 %339, i64 0
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %334)
  %342 = insertelement <4 x i16> %340, i16 %341, i64 1
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %336)
  %344 = insertelement <4 x i16> %342, i16 %343, i64 2
  %345 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %338)
  %346 = insertelement <4 x i16> %344, i16 %345, i64 3
  %acc_s_cast.sroa.0.6.vec.insert1444 = bitcast <4 x i16> %346 to <4 x half>
  %347 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %319, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.0.2), !call_argsrelate !108
  %348 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %320, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.18.2), !call_argsrelate !108
  %349 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %323, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.34.2), !call_argsrelate !108
  %350 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %326, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.50.2), !call_argsrelate !108
  br label %if.end825.1

if.end825.1:                                      ; preds = %if.end738.1, %if.end675.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end675.1 ], [ %350, %if.end738.1 ]
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end675.1 ], [ %349, %if.end738.1 ]
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end675.1 ], [ %348, %if.end738.1 ]
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end675.1 ], [ %347, %if.end738.1 ]
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end675.1 ], [ %add789.3.1, %if.end738.1 ]
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end675.1 ], [ %add789.2.1, %if.end738.1 ]
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end675.1 ], [ %add789.1.1, %if.end738.1 ]
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end675.1 ], [ %add789.11371, %if.end738.1 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0
  %add837 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1
  %add837.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2
  %add837.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3
  %add837.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0
  %add837.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1
  %add837.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2
  %add837.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3
  %add837.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0
  %add837.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1
  %add837.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2
  %add837.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3
  %add837.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0
  %add837.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1
  %add837.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2
  %add837.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3
  %add837.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract
  %add851 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00
  %add851.1 = fadd contract float %add851, %sum_acc.sroa.20.7
  %add851.2 = fadd contract float %add851.1, %sum_acc.sroa.38.7
  %add851.3 = fadd contract float %add851.2, %sum_acc.sroa.56.7
  %351 = bitcast float %add851.3 to i32
  %352 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %353 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %352) #11
  %xor.i.i = xor i32 %353, 32
  %354 = and i32 %353, -64
  %and.i.i = add nsw i32 %354, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i1213 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %353
  %shl.i.i = shl i32 %cond.i.i1213, 2
  %355 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %351)
  %356 = bitcast i32 %355 to float
  %add.i = fadd contract float %add851.3, %356
  %357 = bitcast float %add.i to i32
  %358 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %359 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %358) #11
  %xor.i.i1214 = xor i32 %359, 16
  %360 = and i32 %359, -64
  %and.i.i1215 = add nsw i32 %360, 64
  %cmp.not.i.i1216 = icmp slt i32 %xor.i.i1214, %and.i.i1215
  %cond.i.i1217 = select i1 %cmp.not.i.i1216, i32 %xor.i.i1214, i32 %359
  %shl.i.i1218 = shl i32 %cond.i.i1217, 2
  %361 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1218, i32 %357)
  %362 = bitcast i32 %361 to float
  %add.i.i = fadd contract float %add.i, %362
  %cmp860 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp860, float %div, float 0.000000e+00
  %mul873 = fmul contract float %condval_4.0, %add837
  %mul873.1 = fmul contract float %condval_4.0, %add837.1
  %mul873.2 = fmul contract float %condval_4.0, %add837.2
  %mul873.3 = fmul contract float %condval_4.0, %add837.3
  %mul873.4 = fmul contract float %condval_4.0, %add837.4
  %mul873.5 = fmul contract float %condval_4.0, %add837.5
  %mul873.6 = fmul contract float %condval_4.0, %add837.6
  %mul873.7 = fmul contract float %condval_4.0, %add837.7
  %mul873.8 = fmul contract float %condval_4.0, %add837.8
  %mul873.9 = fmul contract float %condval_4.0, %add837.9
  %mul873.10 = fmul contract float %condval_4.0, %add837.10
  %mul873.11 = fmul contract float %condval_4.0, %add837.11
  %mul873.12 = fmul contract float %condval_4.0, %add837.12
  %mul873.13 = fmul contract float %condval_4.0, %add837.13
  %mul873.14 = fmul contract float %condval_4.0, %add837.14
  %mul873.15 = fmul contract float %condval_4.0, %add837.15
  %363 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873)
  %O_reg.sroa.0.0.insert.ext = zext i16 %363 to i64
  %364 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.1)
  %O_reg.sroa.0.2.insert.ext = zext i16 %364 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %365 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.2)
  %O_reg.sroa.0.4.insert.ext = zext i16 %365 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %366 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.3)
  %O_reg.sroa.0.6.insert.ext = zext i16 %366 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %367 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.4)
  %O_reg.sroa.7.8.insert.ext = zext i16 %367 to i64
  %368 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.5)
  %O_reg.sroa.7.10.insert.ext = zext i16 %368 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %369 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.6)
  %O_reg.sroa.7.12.insert.ext = zext i16 %369 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %370 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.7)
  %O_reg.sroa.7.14.insert.ext = zext i16 %370 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %371 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.8)
  %O_reg.sroa.12.16.insert.ext = zext i16 %371 to i64
  %372 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.9)
  %O_reg.sroa.12.18.insert.ext = zext i16 %372 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %373 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.10)
  %O_reg.sroa.12.20.insert.ext = zext i16 %373 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %374 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.11)
  %O_reg.sroa.12.22.insert.ext = zext i16 %374 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %375 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.12)
  %O_reg.sroa.17.24.insert.ext = zext i16 %375 to i64
  %376 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.13)
  %O_reg.sroa.17.26.insert.ext = zext i16 %376 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %377 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.14)
  %O_reg.sroa.17.28.insert.ext = zext i16 %377 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %378 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.15)
  %O_reg.sroa.17.30.insert.ext = zext i16 %378 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  %shr915 = lshr i32 %10, 5
  %and918 = and i32 %10, 7
  %mul924 = and i32 %14, 4
  %xor = xor i32 %shr915, %and918
  %mul919 = shl nuw nsw i32 %xor, 3
  %add920 = add nuw nsw i32 %mul919, %mul26
  %add925 = or disjoint i32 %add920, %mul924
  %add.ptr927 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr927, align 8
  %add916.1 = add nuw nsw i32 %shr915, 2
  %xor.1 = xor i32 %add916.1, %and918
  %mul919.1 = shl nuw nsw i32 %xor.1, 3
  %add920.1 = add nuw nsw i32 %mul919.1, %mul26
  %add925.1 = or disjoint i32 %add920.1, %mul924
  %add.ptr927.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr927.1, align 8
  %add916.2 = add nuw nsw i32 %shr915, 4
  %xor.2 = xor i32 %add916.2, %and918
  %mul919.2 = shl nuw nsw i32 %xor.2, 3
  %add920.2 = add nuw nsw i32 %mul919.2, %mul26
  %add925.2 = or disjoint i32 %add920.2, %mul924
  %add.ptr927.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr927.2, align 8
  %add916.3 = add nuw nsw i32 %shr915, 6
  %xor.3 = xor i32 %add916.3, %and918
  %mul919.3 = shl nuw nsw i32 %xor.3, 3
  %add920.3 = add nuw nsw i32 %mul919.3, %mul26
  %add925.3 = or disjoint i32 %add920.3, %mul924
  %add.ptr927.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr927.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul938 = and i32 %mul110, 8128
  %xor9441199 = and i32 %mul110, 56
  %call942.masked = and i32 %10, 1016
  %mul945 = xor i32 %xor9441199, %call942.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul938
  %invariant.gep1285 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul945
  %add955 = add nuw nsw i32 %add24, %mul110
  %379 = zext nneg i32 %add955 to i64
  %add.ptr960 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %379
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr960, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1285, i64 16, i1 false), !tbaa.struct !258, !call_argsrelate !259
  %gep1286.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1285, i32 1024
  %380 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %379
  %add.ptr960.1 = getelementptr inbounds i8, ptr addrspace(1) %380, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr960.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1286.1, i64 16, i1 false), !tbaa.struct !258, !call_argsrelate !259
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


