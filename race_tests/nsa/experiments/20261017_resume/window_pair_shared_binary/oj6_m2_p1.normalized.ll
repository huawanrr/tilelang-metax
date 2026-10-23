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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(1) noalias nocapture noundef readonly %Schedule.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = mul nuw nsw i32 %0, 80
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %add = add nuw nsw i32 %mul, %1
  %idxprom = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i64, ptr addrspace(1) %Schedule.coerce, i64 %idxprom
  %2 = load i64, ptr addrspace(1) %arrayidx, align 8, !tbaa !17
  %and = and i64 %2, 65535
  %conv = trunc nuw nsw i64 %and to i32
  %cmp.not = icmp eq i64 %and, 0
  br i1 %cmp.not, label %if.end657, label %for.cond.preheader

for.cond.preheader:                               ; preds = %entry
  %invariant.gep856 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192
  %3 = trunc i64 %2 to i32
  %4 = lshr i32 %3, 16
  %5 = tail call range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !57
  %6 = lshr i32 %0, 3
  %shr63 = zext nneg i32 %6 to i64
  %7 = shl nuw nsw i32 %5, 2
  %mul72 = zext nneg i32 %7 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %mul72
  %shr56 = lshr i64 %2, 16
  %and57 = and i64 %shr56, 65535
  %shr100 = ashr i64 %2, 32
  %conv101 = trunc nsw i64 %shr100 to i32
  %or.cond = icmp ult i64 %shr100, 32
  %mul108 = shl nsw i32 %conv101, 5
  %8 = shl nuw nsw i32 %5, 3
  %mul129 = zext nneg i32 %8 to i64
  %and154 = lshr i32 %5, 1
  %shr155 = and i32 %and154, 15
  %shr158 = lshr i32 %5, 5
  %add152 = and i32 %7, 3972
  %and176 = shl nuw nsw i32 %5, 7
  %mul177 = and i32 %and176, 1920
  %shr180 = lshr i32 %5, 4
  %and183 = and i32 %5, 15
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul177
  %10 = lshr i32 %5, 2
  %mul225 = and i32 %10, 252
  %add222 = add nuw nsw i32 %mul108, %mul225
  %gep857 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep856, i64 %mul129
  %.872 = tail call i32 @llvm.smin.i32(i32 %conv, i32 1024)
  %cmp109 = icmp slt i32 %mul108, %.872
  %or.cond791 = select i1 %or.cond, i1 %cmp109, i1 false
  br i1 %or.cond791, label %for.body116.preheader, label %if.end392

for.body116.preheader:                            ; preds = %for.cond.preheader
  %.idx = shl nuw nsw i64 %shr63, 22
  %11 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx
  %12 = getelementptr i8, ptr addrspace(4) %11, i64 -512
  %13 = tail call i64 @llvm.umin.i64(i64 %and, i64 1024)
  %gep.idx = shl nuw nsw i64 %13, 12
  %gep.7 = getelementptr i8, ptr addrspace(4) %12, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr inbounds i8, ptr addrspace(4) %gep.7, i64 4
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !tbaa !30
  %q_stage.sroa.44.60.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.7 to i64
  %q_stage.sroa.44.60.insert.shift = shl nuw i64 %q_stage.sroa.44.60.insert.ext, 32
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !tbaa !30
  %q_stage.sroa.44.56.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.7 to i64
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %q_stage.sroa.44.60.insert.shift, %q_stage.sroa.44.56.insert.ext
  %14 = getelementptr i8, ptr addrspace(4) %11, i64 -1024
  %gep.6 = getelementptr i8, ptr addrspace(4) %14, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr inbounds i8, ptr addrspace(4) %gep.6, i64 4
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !tbaa !30
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.6 to i64
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !tbaa !30
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.6 to i64
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext
  %15 = getelementptr i8, ptr addrspace(4) %11, i64 -1536
  %gep.5 = getelementptr i8, ptr addrspace(4) %15, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr inbounds i8, ptr addrspace(4) %gep.5, i64 4
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !tbaa !30
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.5 to i64
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !tbaa !30
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.5 to i64
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext
  %16 = getelementptr i8, ptr addrspace(4) %11, i64 -2048
  %gep.4 = getelementptr i8, ptr addrspace(4) %16, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr inbounds i8, ptr addrspace(4) %gep.4, i64 4
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !tbaa !30
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.4 to i64
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !tbaa !30
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.4 to i64
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext
  %17 = getelementptr i8, ptr addrspace(4) %11, i64 -2560
  %gep.3 = getelementptr i8, ptr addrspace(4) %17, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %gep.3, i64 4
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !tbaa !30
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.3 to i64
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !tbaa !30
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.3 to i64
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext
  %18 = getelementptr i8, ptr addrspace(4) %11, i64 -3072
  %gep.2 = getelementptr i8, ptr addrspace(4) %18, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %gep.2, i64 4
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !tbaa !30
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.2 to i64
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !tbaa !30
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.2 to i64
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext
  %19 = getelementptr i8, ptr addrspace(4) %11, i64 -3584
  %gep.1 = getelementptr i8, ptr addrspace(4) %19, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1, i64 4
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !tbaa !30
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.copyload.1 to i64
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !tbaa !30
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.copyload.1 to i64
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext
  %20 = getelementptr i8, ptr addrspace(4) %11, i64 -4096
  %gep = getelementptr i8, ptr addrspace(4) %20, i64 %gep.idx
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !tbaa !30
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0.copyload to i64
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %gep, align 8, !tbaa !30
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0.copyload to i64
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext
  %21 = and i64 %2, 4294901760
  %cmp282 = icmp eq i64 %21, 0
  %invariant.gep836 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul129
  %.idx880 = shl nuw nsw i64 %shr100, 14
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep836, i64 %.idx880
  %.idx881 = shl nuw nsw i64 %shr63, 19
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx881
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %23, align 16
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 8
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8
  %gep837.1 = getelementptr i8, ptr addrspace(4) %23, i64 1024
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep837.1, align 16
  %k.sroa.12.16.gep837.1.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 1032
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep837.1.sroa_idx, align 8
  %gep837.2 = getelementptr i8, ptr addrspace(4) %23, i64 2048
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep837.2, align 16
  %k.sroa.18.32.gep837.2.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 2056
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep837.2.sroa_idx, align 8
  %gep837.3 = getelementptr i8, ptr addrspace(4) %23, i64 3072
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep837.3, align 16
  %k.sroa.24.48.gep837.3.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 3080
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep837.3.sroa_idx, align 8
  %gep837.4 = getelementptr i8, ptr addrspace(4) %23, i64 4096
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep837.4, align 16
  %k.sroa.30.64.gep837.4.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 4104
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep837.4.sroa_idx, align 8
  %gep837.5 = getelementptr i8, ptr addrspace(4) %23, i64 5120
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep837.5, align 16
  %k.sroa.36.80.gep837.5.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 5128
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep837.5.sroa_idx, align 8
  %gep837.6 = getelementptr i8, ptr addrspace(4) %23, i64 6144
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep837.6, align 16
  %k.sroa.42.96.gep837.6.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 6152
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep837.6.sroa_idx, align 8
  %gep837.7 = getelementptr i8, ptr addrspace(4) %23, i64 7168
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep837.7, align 16
  %k.sroa.48.112.gep837.7.sroa_idx = getelementptr i8, ptr addrspace(4) %23, i64 7176
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep837.7.sroa_idx, align 8
  %xor = xor i32 %shr158, %shr155
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152
  %add.ptr167.idx = shl nuw nsw i32 %xor, 4
  %add.ptr167 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %add.ptr167.idx
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %add.ptr167, align 8
  %add159.1 = add nuw nsw i32 %shr158, 2
  %xor.1 = xor i32 %add159.1, %shr155
  %25 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 512
  %add.ptr167.idx.1 = shl nuw nsw i32 %xor.1, 4
  %add.ptr167.1 = getelementptr inbounds i8, ptr addrspace(3) %25, i32 %add.ptr167.idx.1
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %add.ptr167.1, align 8
  %add159.2 = add nuw nsw i32 %shr158, 4
  %xor.2 = xor i32 %add159.2, %shr155
  %26 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1024
  %add.ptr167.idx.2 = shl nuw nsw i32 %xor.2, 4
  %add.ptr167.2 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr167.idx.2
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %add.ptr167.2, align 8
  %add159.3 = add nuw nsw i32 %shr158, 6
  %xor.3 = xor i32 %add159.3, %shr155
  %27 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 1536
  %add.ptr167.idx.3 = shl nuw nsw i32 %xor.3, 4
  %add.ptr167.3 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr167.idx.3
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %add.ptr167.3, align 8
  %add159.4 = add nuw nsw i32 %shr158, 8
  %xor.4 = xor i32 %add159.4, %shr155
  %28 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2048
  %add.ptr167.idx.4 = shl nuw nsw i32 %xor.4, 4
  %add.ptr167.4 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr167.idx.4
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %add.ptr167.4, align 8
  %add159.5 = add nuw nsw i32 %shr158, 10
  %xor.5 = xor i32 %add159.5, %shr155
  %29 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 2560
  %add.ptr167.idx.5 = shl nuw nsw i32 %xor.5, 4
  %add.ptr167.5 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr167.idx.5
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %add.ptr167.5, align 8
  %add159.6 = add nuw nsw i32 %shr158, 12
  %xor.6 = xor i32 %add159.6, %shr155
  %30 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3072
  %add.ptr167.idx.6 = shl nuw nsw i32 %xor.6, 4
  %add.ptr167.6 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr167.idx.6
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %add.ptr167.6, align 8
  %add159.7 = add nuw nsw i32 %shr158, 14
  %xor.7 = xor i32 %add159.7, %shr155
  %31 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 3584
  %add.ptr167.idx.7 = shl nuw nsw i32 %xor.7, 4
  %add.ptr167.7 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr167.idx.7
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %add.ptr167.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor184 = xor i32 %shr180, %and183
  %add.ptr188.idx = shl nuw nsw i32 %xor184, 4
  %add.ptr188 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188, align 16
  %q.sroa.6.0.add.ptr188.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188, i32 8
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.sroa_idx, align 8
  %add181.1 = add nuw nsw i32 %shr180, 4
  %xor184.1 = xor i32 %add181.1, %and183
  %add.ptr188.idx.1 = shl nuw nsw i32 %xor184.1, 4
  %add.ptr188.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.1, align 16
  %q.sroa.12.16.add.ptr188.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1, i32 8
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.sroa_idx, align 8
  %add181.2 = add nuw nsw i32 %shr180, 8
  %xor184.2 = xor i32 %add181.2, %and183
  %add.ptr188.idx.2 = shl nuw nsw i32 %xor184.2, 4
  %add.ptr188.2 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.2, align 16
  %q.sroa.18.32.add.ptr188.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2, i32 8
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.sroa_idx, align 8
  %add181.3 = add nuw nsw i32 %shr180, 12
  %xor184.3 = xor i32 %add181.3, %and183
  %add.ptr188.idx.3 = shl nuw nsw i32 %xor184.3, 4
  %add.ptr188.3 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr188.3, align 16
  %q.sroa.24.48.add.ptr188.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3, i32 8
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.sroa_idx, align 8
  %cmp229.not.not = icmp slt i32 %add222, %.872
  %spec.select = select i1 %cmp229.not.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0
  %add226.1 = or disjoint i32 %add222, 1
  %cmp229.not.not.1 = icmp slt i32 %add226.1, %.872
  %spec.select.1 = select i1 %cmp229.not.not.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1
  %add226.2 = or disjoint i32 %add222, 2
  %cmp229.not.not.2 = icmp slt i32 %add226.2, %.872
  %spec.select.2 = select i1 %cmp229.not.not.2, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2
  %add226.3 = or disjoint i32 %add222, 3
  %cmp229.not.not.3 = icmp slt i32 %add226.3, %.872
  %spec.select.3 = select i1 %cmp229.not.not.3, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3
  %add228.4 = add nuw nsw i32 %add222, 16
  %cmp229.not.not.4 = icmp slt i32 %add228.4, %.872
  %spec.select.4 = select i1 %cmp229.not.not.4, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %add228.5 = add nuw nsw i32 %add222, 17
  %cmp229.not.not.5 = icmp slt i32 %add228.5, %.872
  %spec.select.5 = select i1 %cmp229.not.not.5, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1
  %add228.6 = add nuw nsw i32 %add222, 18
  %cmp229.not.not.6 = icmp slt i32 %add228.6, %.872
  %spec.select.6 = select i1 %cmp229.not.not.6, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2
  %add228.7 = add nuw nsw i32 %add222, 19
  %cmp229.not.not.7 = icmp slt i32 %add228.7, %.872
  %spec.select.7 = select i1 %cmp229.not.not.7, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !call_argsrelate !86
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !call_argsrelate !86
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %32), !call_argsrelate !86
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %33), !call_argsrelate !86
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %34), !call_argsrelate !86
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %35), !call_argsrelate !86
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %36), !call_argsrelate !86
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %37), !call_argsrelate !86
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %38), !call_argsrelate !86
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %39), !call_argsrelate !86
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %40), !call_argsrelate !86
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %41), !call_argsrelate !86
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %42), !call_argsrelate !86
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %43), !call_argsrelate !86
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %44), !call_argsrelate !86
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %45), !call_argsrelate !86
  br i1 %cmp282, label %for.body287.preheader, label %if.end311

for.body287.preheader:                            ; preds = %for.body116.preheader
  %.idx886 = shl nuw nsw i64 %shr100, 14
  %48 = getelementptr i8, ptr addrspace(4) %gep857, i64 %.idx886
  %.idx887 = shl nuw nsw i64 %shr63, 19
  %49 = getelementptr i8, ptr addrspace(4) %48, i64 %.idx887
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %49, align 16
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %49, i64 8
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8
  %gep848.1 = getelementptr i8, ptr addrspace(4) %49, i64 1024
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep848.1, align 16
  %v.sroa.12.16.gep848.1.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 1032
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep848.1.sroa_idx, align 8
  %gep848.2 = getelementptr i8, ptr addrspace(4) %49, i64 2048
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep848.2, align 16
  %v.sroa.18.32.gep848.2.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 2056
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep848.2.sroa_idx, align 8
  %gep848.3 = getelementptr i8, ptr addrspace(4) %49, i64 3072
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep848.3, align 16
  %v.sroa.24.48.gep848.3.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 3080
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep848.3.sroa_idx, align 8
  %gep848.4 = getelementptr i8, ptr addrspace(4) %49, i64 4096
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep848.4, align 16
  %v.sroa.30.64.gep848.4.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 4104
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep848.4.sroa_idx, align 8
  %gep848.5 = getelementptr i8, ptr addrspace(4) %49, i64 5120
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep848.5, align 16
  %v.sroa.36.80.gep848.5.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 5128
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep848.5.sroa_idx, align 8
  %gep848.6 = getelementptr i8, ptr addrspace(4) %49, i64 6144
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep848.6, align 16
  %v.sroa.42.96.gep848.6.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 6152
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep848.6.sroa_idx, align 8
  %gep848.7 = getelementptr i8, ptr addrspace(4) %49, i64 7168
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep848.7, align 16
  %v.sroa.48.112.gep848.7.sroa_idx = getelementptr i8, ptr addrspace(4) %49, i64 7176
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep848.7.sroa_idx, align 8
  br label %if.end311

if.end311:                                        ; preds = %for.body287.preheader, %for.body116.preheader
  %v.sroa.48.0 = phi <4 x half> [ %v.sroa.48.112.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.44.0 = phi <4 x half> [ %v.sroa.44.112.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.42.0 = phi <4 x half> [ %v.sroa.42.96.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.38.0 = phi <4 x half> [ %v.sroa.38.96.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.36.0 = phi <4 x half> [ %v.sroa.36.80.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.32.0 = phi <4 x half> [ %v.sroa.32.80.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.30.0 = phi <4 x half> [ %v.sroa.30.64.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.26.0 = phi <4 x half> [ %v.sroa.26.64.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.24.0 = phi <4 x half> [ %v.sroa.24.48.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.20.0 = phi <4 x half> [ %v.sroa.20.48.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.18.0 = phi <4 x half> [ %v.sroa.18.32.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.14.0 = phi <4 x half> [ %v.sroa.14.32.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.12.0 = phi <4 x half> [ %v.sroa.12.16.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.8.0 = phi <4 x half> [ %v.sroa.8.16.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.6.0 = phi <4 x half> [ %v.sroa.6.0.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %v.sroa.0.0 = phi <4 x half> [ %v.sroa.0.0.copyload, %for.body287.preheader ], [ undef, %for.body116.preheader ]
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0
  %mul318 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul318, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %50, -1.260000e+02
  %cond.i.i814 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i815 = fadd contract float %50, %cond.i.i814
  %51 = tail call contract float @llvm.exp2.f32(float %add.i.i815)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %51
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1
  %mul318.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul318.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %52, -1.260000e+02
  %cond.i.i814.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.1 = fadd contract float %52, %cond.i.i814.1
  %53 = tail call contract float @llvm.exp2.f32(float %add.i.i815.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %53
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2
  %mul318.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul318.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %54, -1.260000e+02
  %cond.i.i814.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.2 = fadd contract float %54, %cond.i.i814.2
  %55 = tail call contract float @llvm.exp2.f32(float %add.i.i815.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %55
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3
  %mul318.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul318.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %56, -1.260000e+02
  %cond.i.i814.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.3 = fadd contract float %56, %cond.i.i814.3
  %57 = tail call contract float @llvm.exp2.f32(float %add.i.i815.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %57
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %47, i64 0
  %mul318.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul318.4, float 1.500000e+01)
  %cmp.i.i.4 = fcmp contract olt float %58, -1.260000e+02
  %cond.i.i814.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.4 = fadd contract float %58, %cond.i.i814.4
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i815.4)
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %59
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %47, i64 1
  %mul318.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul318.5, float 1.500000e+01)
  %cmp.i.i.5 = fcmp contract olt float %60, -1.260000e+02
  %cond.i.i814.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.5 = fadd contract float %60, %cond.i.i814.5
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i815.5)
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %61
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %47, i64 2
  %mul318.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul318.6, float 1.500000e+01)
  %cmp.i.i.6 = fcmp contract olt float %62, -1.260000e+02
  %cond.i.i814.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.6 = fadd contract float %62, %cond.i.i814.6
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i815.6)
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %63
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %47, i64 3
  %mul318.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul318.7, float 1.500000e+01)
  %cmp.i.i.7 = fcmp contract olt float %64, -1.260000e+02
  %cond.i.i814.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.7 = fadd contract float %64, %cond.i.i814.7
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i815.7)
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %65
  %add338 = fadd contract float %mul.i.i, 0.000000e+00
  %add338.1 = fadd contract float %add338, %mul.i.i.4
  %add338.2 = fadd contract float %add338.1, %mul.i.i.1
  %add338.3 = fadd contract float %add338.2, %mul.i.i.5
  %add338.4 = fadd contract float %add338.3, %mul.i.i.2
  %add338.5 = fadd contract float %add338.4, %mul.i.i.6
  %add338.6 = fadd contract float %add338.5, %mul.i.i.3
  %add338.7 = fadd contract float %add338.6, %mul.i.i.7
  %66 = bitcast float %add338.7 to i32
  %67 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %68 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %67) #11
  %xor.i.i = xor i32 %68, 32
  %69 = and i32 %68, -64
  %and.i.i = add nsw i32 %69, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i816 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %68
  %shl.i.i = shl i32 %cond.i.i816, 2
  %70 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %66)
  %71 = bitcast i32 %70 to float
  %add.i = fadd contract float %add338.7, %71
  %72 = bitcast float %add.i to i32
  %73 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %74 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %73) #11
  %xor.i.i817 = xor i32 %74, 16
  %75 = and i32 %74, -64
  %and.i.i818 = add nsw i32 %75, 64
  %cmp.not.i.i819 = icmp slt i32 %xor.i.i817, %and.i.i818
  %cond.i.i820 = select i1 %cmp.not.i.i819, i32 %xor.i.i817, i32 %74
  %shl.i.i821 = shl i32 %cond.i.i820, 2
  %76 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i821, i32 %72)
  %77 = bitcast i32 %76 to float
  %add.i.i = fadd contract float %add.i, %77
  %cmp347 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_8.0 = select i1 %cmp347, float %div, float 0.000000e+00
  %mul360 = fmul contract float %condval_8.0, %mul.i.i
  %mul360.1 = fmul contract float %condval_8.0, %mul.i.i.1
  %mul360.2 = fmul contract float %condval_8.0, %mul.i.i.2
  %mul360.3 = fmul contract float %condval_8.0, %mul.i.i.3
  %mul360.4 = fmul contract float %condval_8.0, %mul.i.i.4
  %mul360.5 = fmul contract float %condval_8.0, %mul.i.i.5
  %mul360.6 = fmul contract float %condval_8.0, %mul.i.i.6
  %mul360.7 = fmul contract float %condval_8.0, %mul.i.i.7
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360)
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.1)
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.2)
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.3)
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.4)
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.5)
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.6)
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.7)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %86 = insertelement <4 x i16> poison, i16 %78, i64 0
  %87 = insertelement <4 x i16> %86, i16 %79, i64 1
  %88 = insertelement <4 x i16> %87, i16 %80, i64 2
  %89 = insertelement <4 x i16> %88, i16 %81, i64 3
  %90 = bitcast <4 x i16> %89 to <4 x half>
  %91 = insertelement <4 x i16> poison, i16 %82, i64 0
  %92 = insertelement <4 x i16> %91, i16 %83, i64 1
  %93 = insertelement <4 x i16> %92, i16 %84, i64 2
  %94 = insertelement <4 x i16> %93, i16 %85, i64 3
  %95 = bitcast <4 x i16> %94 to <4 x half>
  br label %if.end392

if.end392:                                        ; preds = %if.end311, %for.cond.preheader
  %v.sroa.48.1 = phi <4 x half> [ %v.sroa.48.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.44.1 = phi <4 x half> [ %v.sroa.44.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.42.1 = phi <4 x half> [ %v.sroa.42.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.38.1 = phi <4 x half> [ %v.sroa.38.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.36.1 = phi <4 x half> [ %v.sroa.36.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.32.1 = phi <4 x half> [ %v.sroa.32.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.30.1 = phi <4 x half> [ %v.sroa.30.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.26.1 = phi <4 x half> [ %v.sroa.26.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.24.1 = phi <4 x half> [ %v.sroa.24.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.20.1 = phi <4 x half> [ %v.sroa.20.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.18.1 = phi <4 x half> [ %v.sroa.18.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.14.1 = phi <4 x half> [ %v.sroa.14.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.12.1 = phi <4 x half> [ %v.sroa.12.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.8.1 = phi <4 x half> [ %v.sroa.8.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.6.1 = phi <4 x half> [ %v.sroa.6.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %v.sroa.0.1 = phi <4 x half> [ %v.sroa.0.0, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.48.1 = phi <4 x half> [ %k.sroa.48.112.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.44.1 = phi <4 x half> [ %k.sroa.44.112.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.42.1 = phi <4 x half> [ %k.sroa.42.96.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.38.1 = phi <4 x half> [ %k.sroa.38.96.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.36.1 = phi <4 x half> [ %k.sroa.36.80.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.32.1 = phi <4 x half> [ %k.sroa.32.80.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.30.1 = phi <4 x half> [ %k.sroa.30.64.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.26.1 = phi <4 x half> [ %k.sroa.26.64.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.24.1 = phi <4 x half> [ %k.sroa.24.48.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.20.1 = phi <4 x half> [ %k.sroa.20.48.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.18.1 = phi <4 x half> [ %k.sroa.18.32.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.14.1 = phi <4 x half> [ %k.sroa.14.32.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.12.1 = phi <4 x half> [ %k.sroa.12.16.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.8.1 = phi <4 x half> [ %k.sroa.8.16.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.6.1 = phi <4 x half> [ %k.sroa.6.0.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %k.sroa.0.1 = phi <4 x half> [ %k.sroa.0.0.copyload, %if.end311 ], [ undef, %for.cond.preheader ]
  %96 = phi <4 x half> [ %95, %if.end311 ], [ undef, %for.cond.preheader ]
  %97 = phi <4 x half> [ %90, %if.end311 ], [ undef, %for.cond.preheader ]
  %cmp16.not.1 = icmp ult i32 %3, 65536
  br i1 %cmp16.not.1, label %if.end392.1, label %if.end48.preheader.1

if.end48.preheader.1:                             ; preds = %if.end392
  %.872.1 = tail call i32 @llvm.smin.i32(i32 %4, i32 1024)
  %cmp109.1 = icmp slt i32 %mul108, %.872.1
  %or.cond791.1 = select i1 %or.cond, i1 %cmp109.1, i1 false
  br i1 %or.cond791.1, label %if.end139.1, label %if.end392.1

if.end139.1:                                      ; preds = %if.end48.preheader.1
  %.idx.1910 = shl nuw nsw i64 %shr63, 22
  %98 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1910
  %99 = getelementptr i8, ptr addrspace(4) %98, i64 -512
  %100 = tail call i64 @llvm.umin.i64(i64 %and57, i64 1024)
  %gep.idx.1911 = shl nuw nsw i64 %100, 12
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %99, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.7.1, i64 4
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !tbaa !30
  %q_stage.sroa.44.60.insert.ext1824 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64
  %q_stage.sroa.44.60.insert.shift1825 = shl nuw i64 %q_stage.sroa.44.60.insert.ext1824, 32
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !tbaa !30
  %q_stage.sroa.44.56.insert.ext1820 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64
  %q_stage.sroa.44.60.insert.insert1827 = or disjoint i64 %q_stage.sroa.44.60.insert.shift1825, %q_stage.sroa.44.56.insert.ext1820
  %101 = getelementptr i8, ptr addrspace(4) %98, i64 -1024
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %101, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.6.1, i64 4
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !tbaa !30
  %q_stage.sroa.38.52.insert.ext1814 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64
  %q_stage.sroa.38.52.insert.shift1815 = shl nuw i64 %q_stage.sroa.38.52.insert.ext1814, 32
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !tbaa !30
  %q_stage.sroa.38.48.insert.ext1810 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64
  %q_stage.sroa.38.52.insert.insert1817 = or disjoint i64 %q_stage.sroa.38.52.insert.shift1815, %q_stage.sroa.38.48.insert.ext1810
  %102 = getelementptr i8, ptr addrspace(4) %98, i64 -1536
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %102, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.5.1, i64 4
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !tbaa !30
  %q_stage.sroa.32.44.insert.ext1804 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64
  %q_stage.sroa.32.44.insert.shift1805 = shl nuw i64 %q_stage.sroa.32.44.insert.ext1804, 32
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !tbaa !30
  %q_stage.sroa.32.40.insert.ext1800 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64
  %q_stage.sroa.32.44.insert.insert1807 = or disjoint i64 %q_stage.sroa.32.44.insert.shift1805, %q_stage.sroa.32.40.insert.ext1800
  %103 = getelementptr i8, ptr addrspace(4) %98, i64 -2048
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %103, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.4.1, i64 4
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !tbaa !30
  %q_stage.sroa.26.36.insert.ext1794 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64
  %q_stage.sroa.26.36.insert.shift1795 = shl nuw i64 %q_stage.sroa.26.36.insert.ext1794, 32
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !tbaa !30
  %q_stage.sroa.26.32.insert.ext1790 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64
  %q_stage.sroa.26.36.insert.insert1797 = or disjoint i64 %q_stage.sroa.26.36.insert.shift1795, %q_stage.sroa.26.32.insert.ext1790
  %104 = getelementptr i8, ptr addrspace(4) %98, i64 -2560
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %104, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.3.1, i64 4
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !tbaa !30
  %q_stage.sroa.20.28.insert.ext1784 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64
  %q_stage.sroa.20.28.insert.shift1785 = shl nuw i64 %q_stage.sroa.20.28.insert.ext1784, 32
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !tbaa !30
  %q_stage.sroa.20.24.insert.ext1780 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64
  %q_stage.sroa.20.28.insert.insert1787 = or disjoint i64 %q_stage.sroa.20.28.insert.shift1785, %q_stage.sroa.20.24.insert.ext1780
  %105 = getelementptr i8, ptr addrspace(4) %98, i64 -3072
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %105, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.2.1, i64 4
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !tbaa !30
  %q_stage.sroa.14.20.insert.ext1774 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64
  %q_stage.sroa.14.20.insert.shift1775 = shl nuw i64 %q_stage.sroa.14.20.insert.ext1774, 32
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !tbaa !30
  %q_stage.sroa.14.16.insert.ext1770 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64
  %q_stage.sroa.14.20.insert.insert1777 = or disjoint i64 %q_stage.sroa.14.20.insert.shift1775, %q_stage.sroa.14.16.insert.ext1770
  %106 = getelementptr i8, ptr addrspace(4) %98, i64 -3584
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %106, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %gep.1.1, i64 4
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !tbaa !30
  %q_stage.sroa.8.12.insert.ext1764 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64
  %q_stage.sroa.8.12.insert.shift1765 = shl nuw i64 %q_stage.sroa.8.12.insert.ext1764, 32
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !tbaa !30
  %q_stage.sroa.8.8.insert.ext1760 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64
  %q_stage.sroa.8.12.insert.insert1767 = or disjoint i64 %q_stage.sroa.8.12.insert.shift1765, %q_stage.sroa.8.8.insert.ext1760
  %107 = getelementptr i8, ptr addrspace(4) %98, i64 -4096
  %gep.1912 = getelementptr i8, ptr addrspace(4) %107, i64 %gep.idx.1911
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1913 = getelementptr inbounds i8, ptr addrspace(4) %gep.1912, i64 4
  %condval_1.sroa.5.0.copyload.1914 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1913, align 4, !tbaa !30
  %q_stage.sroa.0.4.insert.ext1754 = zext i32 %condval_1.sroa.5.0.copyload.1914 to i64
  %q_stage.sroa.0.4.insert.shift1755 = shl nuw i64 %q_stage.sroa.0.4.insert.ext1754, 32
  %condval_1.sroa.0.0.copyload.1915 = load i32, ptr addrspace(4) %gep.1912, align 8, !tbaa !30
  %q_stage.sroa.0.0.insert.ext1750 = zext i32 %condval_1.sroa.0.0.copyload.1915 to i64
  %q_stage.sroa.0.4.insert.insert1757 = or disjoint i64 %q_stage.sroa.0.4.insert.shift1755, %q_stage.sroa.0.0.insert.ext1750
  %xor.1919 = xor i32 %shr158, %shr155
  %108 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add152
  %add.ptr167.idx.1920 = shl nuw nsw i32 %xor.1919, 4
  %add.ptr167.1921 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 %add.ptr167.idx.1920
  store i64 %q_stage.sroa.0.4.insert.insert1757, ptr addrspace(3) %add.ptr167.1921, align 8
  %add159.1.1 = add nuw nsw i32 %shr158, 2
  %xor.1.1 = xor i32 %add159.1.1, %shr155
  %109 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 512
  %add.ptr167.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4
  %add.ptr167.1.1 = getelementptr inbounds i8, ptr addrspace(3) %109, i32 %add.ptr167.idx.1.1
  store i64 %q_stage.sroa.8.12.insert.insert1767, ptr addrspace(3) %add.ptr167.1.1, align 8
  %add159.2.1 = add nuw nsw i32 %shr158, 4
  %xor.2.1 = xor i32 %add159.2.1, %shr155
  %110 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 1024
  %add.ptr167.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4
  %add.ptr167.2.1 = getelementptr inbounds i8, ptr addrspace(3) %110, i32 %add.ptr167.idx.2.1
  store i64 %q_stage.sroa.14.20.insert.insert1777, ptr addrspace(3) %add.ptr167.2.1, align 8
  %add159.3.1 = add nuw nsw i32 %shr158, 6
  %xor.3.1 = xor i32 %add159.3.1, %shr155
  %111 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 1536
  %add.ptr167.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4
  %add.ptr167.3.1 = getelementptr inbounds i8, ptr addrspace(3) %111, i32 %add.ptr167.idx.3.1
  store i64 %q_stage.sroa.20.28.insert.insert1787, ptr addrspace(3) %add.ptr167.3.1, align 8
  %add159.4.1 = add nuw nsw i32 %shr158, 8
  %xor.4.1 = xor i32 %add159.4.1, %shr155
  %112 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 2048
  %add.ptr167.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4
  %add.ptr167.4.1 = getelementptr inbounds i8, ptr addrspace(3) %112, i32 %add.ptr167.idx.4.1
  store i64 %q_stage.sroa.26.36.insert.insert1797, ptr addrspace(3) %add.ptr167.4.1, align 8
  %add159.5.1 = add nuw nsw i32 %shr158, 10
  %xor.5.1 = xor i32 %add159.5.1, %shr155
  %113 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 2560
  %add.ptr167.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4
  %add.ptr167.5.1 = getelementptr inbounds i8, ptr addrspace(3) %113, i32 %add.ptr167.idx.5.1
  store i64 %q_stage.sroa.32.44.insert.insert1807, ptr addrspace(3) %add.ptr167.5.1, align 8
  %add159.6.1 = add nuw nsw i32 %shr158, 12
  %xor.6.1 = xor i32 %add159.6.1, %shr155
  %114 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 3072
  %add.ptr167.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4
  %add.ptr167.6.1 = getelementptr inbounds i8, ptr addrspace(3) %114, i32 %add.ptr167.idx.6.1
  store i64 %q_stage.sroa.38.52.insert.insert1817, ptr addrspace(3) %add.ptr167.6.1, align 8
  %add159.7.1 = add nuw nsw i32 %shr158, 14
  %xor.7.1 = xor i32 %add159.7.1, %shr155
  %115 = getelementptr inbounds i8, ptr addrspace(3) %108, i32 3584
  %add.ptr167.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4
  %add.ptr167.7.1 = getelementptr inbounds i8, ptr addrspace(3) %115, i32 %add.ptr167.idx.7.1
  store i64 %q_stage.sroa.44.60.insert.insert1827, ptr addrspace(3) %add.ptr167.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor184.1922 = xor i32 %shr180, %and183
  %add.ptr188.idx.1923 = shl nuw nsw i32 %xor184.1922, 4
  %add.ptr188.1924 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1923
  %q.sroa.0.0.copyload1700 = load <4 x half>, ptr addrspace(3) %add.ptr188.1924, align 16
  %q.sroa.6.0.add.ptr188.1924.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1924, i32 8
  %q.sroa.6.0.copyload1701 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.add.ptr188.1924.sroa_idx, align 8
  %add181.1.1 = add nuw nsw i32 %shr180, 4
  %xor184.1.1 = xor i32 %add181.1.1, %and183
  %add.ptr188.idx.1.1 = shl nuw nsw i32 %xor184.1.1, 4
  %add.ptr188.1.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.1.1
  %q.sroa.8.16.copyload1704 = load <4 x half>, ptr addrspace(3) %add.ptr188.1.1, align 16
  %q.sroa.12.16.add.ptr188.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.1.1, i32 8
  %q.sroa.12.16.copyload1705 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.add.ptr188.1.1.sroa_idx, align 8
  %add181.2.1 = add nuw nsw i32 %shr180, 8
  %xor184.2.1 = xor i32 %add181.2.1, %and183
  %add.ptr188.idx.2.1 = shl nuw nsw i32 %xor184.2.1, 4
  %add.ptr188.2.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.2.1
  %q.sroa.14.32.copyload1708 = load <4 x half>, ptr addrspace(3) %add.ptr188.2.1, align 16
  %q.sroa.18.32.add.ptr188.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.2.1, i32 8
  %q.sroa.18.32.copyload1709 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.add.ptr188.2.1.sroa_idx, align 8
  %add181.3.1 = add nuw nsw i32 %shr180, 12
  %xor184.3.1 = xor i32 %add181.3.1, %and183
  %add.ptr188.idx.3.1 = shl nuw nsw i32 %xor184.3.1, 4
  %add.ptr188.3.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr188.idx.3.1
  %q.sroa.20.48.copyload1712 = load <4 x half>, ptr addrspace(3) %add.ptr188.3.1, align 16
  %q.sroa.24.48.add.ptr188.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr188.3.1, i32 8
  %q.sroa.24.48.copyload1713 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.add.ptr188.3.1.sroa_idx, align 8
  %cmp229.not.not.1927 = icmp slt i32 %add222, %.872.1
  %spec.select.1928 = select i1 %cmp229.not.not.1927, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.0.vec.insert1495 = insertelement <4 x float> poison, float %spec.select.1928, i64 0
  %add226.1.1 = or disjoint i32 %add222, 1
  %cmp229.not.not.1.1 = icmp slt i32 %add226.1.1, %.872.1
  %spec.select.1.1 = select i1 %cmp229.not.not.1.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1520 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1495, float %spec.select.1.1, i64 1
  %add226.2.1 = or disjoint i32 %add222, 2
  %cmp229.not.not.2.1 = icmp slt i32 %add226.2.1, %.872.1
  %spec.select.2.1 = select i1 %cmp229.not.not.2.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.8.vec.insert1545 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1520, float %spec.select.2.1, i64 2
  %add226.3.1 = or disjoint i32 %add222, 3
  %cmp229.not.not.3.1 = icmp slt i32 %add226.3.1, %.872.1
  %spec.select.3.1 = select i1 %cmp229.not.not.3.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.12.vec.insert1570 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1545, float %spec.select.3.1, i64 3
  %add228.4.1 = add nuw nsw i32 %add222, 16
  %cmp229.not.not.4.1 = icmp slt i32 %add228.4.1, %.872.1
  %spec.select.4.1 = select i1 %cmp229.not.not.4.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.16.vec.insert1611 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0
  %add228.5.1 = add nuw nsw i32 %add222, 17
  %cmp229.not.not.5.1 = icmp slt i32 %add228.5.1, %.872.1
  %spec.select.5.1 = select i1 %cmp229.not.not.5.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.20.vec.insert1636 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1611, float %spec.select.5.1, i64 1
  %add228.6.1 = add nuw nsw i32 %add222, 18
  %cmp229.not.not.6.1 = icmp slt i32 %add228.6.1, %.872.1
  %spec.select.6.1 = select i1 %cmp229.not.not.6.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.24.vec.insert1661 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1636, float %spec.select.6.1, i64 2
  %add228.7.1 = add nuw nsw i32 %add222, 19
  %cmp229.not.not.7.1 = icmp slt i32 %add228.7.1, %.872.1
  %spec.select.7.1 = select i1 %cmp229.not.not.7.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.90.28.vec.insert1686 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1661, float %spec.select.7.1, i64 3
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.1, <4 x half> %q.sroa.0.0.copyload1700, <4 x float> %scores.sroa.0.12.vec.insert1570)
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.1, <4 x half> %q.sroa.0.0.copyload1700, <4 x float> %scores.sroa.90.28.vec.insert1686)
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.1, <4 x half> %q.sroa.6.0.copyload1701, <4 x float> %116)
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.1, <4 x half> %q.sroa.6.0.copyload1701, <4 x float> %117)
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.1, <4 x half> %q.sroa.8.16.copyload1704, <4 x float> %118)
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.1, <4 x half> %q.sroa.8.16.copyload1704, <4 x float> %119)
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.1, <4 x half> %q.sroa.12.16.copyload1705, <4 x float> %120)
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.1, <4 x half> %q.sroa.12.16.copyload1705, <4 x float> %121)
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.1, <4 x half> %q.sroa.14.32.copyload1708, <4 x float> %122)
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.1, <4 x half> %q.sroa.14.32.copyload1708, <4 x float> %123)
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.1, <4 x half> %q.sroa.18.32.copyload1709, <4 x float> %124)
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.1, <4 x half> %q.sroa.18.32.copyload1709, <4 x float> %125)
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.1, <4 x half> %q.sroa.20.48.copyload1712, <4 x float> %126)
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.1, <4 x half> %q.sroa.20.48.copyload1712, <4 x float> %127)
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.1, <4 x half> %q.sroa.24.48.copyload1713, <4 x float> %128)
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.1, <4 x half> %q.sroa.24.48.copyload1713, <4 x float> %129)
  %.idx886.1936 = shl nuw nsw i64 %shr100, 14
  %132 = getelementptr i8, ptr addrspace(4) %gep857, i64 %.idx886.1936
  %.idx887.1937 = shl nuw nsw i64 %shr63, 19
  %133 = getelementptr i8, ptr addrspace(4) %132, i64 %.idx887.1937
  %v.sroa.48.112.gep848.7.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 7176
  %v.sroa.48.112.copyload1859 = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep848.7.1.sroa_idx, align 8
  %gep848.7.1 = getelementptr i8, ptr addrspace(4) %133, i64 7168
  %v.sroa.44.112.copyload1858 = load <4 x half>, ptr addrspace(4) %gep848.7.1, align 16
  %v.sroa.42.96.gep848.6.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 6152
  %v.sroa.42.96.copyload1855 = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep848.6.1.sroa_idx, align 8
  %gep848.6.1 = getelementptr i8, ptr addrspace(4) %133, i64 6144
  %v.sroa.38.96.copyload1854 = load <4 x half>, ptr addrspace(4) %gep848.6.1, align 16
  %v.sroa.36.80.gep848.5.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 5128
  %v.sroa.36.80.copyload1851 = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep848.5.1.sroa_idx, align 8
  %gep848.5.1 = getelementptr i8, ptr addrspace(4) %133, i64 5120
  %v.sroa.32.80.copyload1850 = load <4 x half>, ptr addrspace(4) %gep848.5.1, align 16
  %v.sroa.30.64.gep848.4.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 4104
  %v.sroa.30.64.copyload1847 = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep848.4.1.sroa_idx, align 8
  %gep848.4.1 = getelementptr i8, ptr addrspace(4) %133, i64 4096
  %v.sroa.26.64.copyload1846 = load <4 x half>, ptr addrspace(4) %gep848.4.1, align 16
  %v.sroa.24.48.gep848.3.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 3080
  %v.sroa.24.48.copyload1843 = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep848.3.1.sroa_idx, align 8
  %gep848.3.1 = getelementptr i8, ptr addrspace(4) %133, i64 3072
  %v.sroa.20.48.copyload1842 = load <4 x half>, ptr addrspace(4) %gep848.3.1, align 16
  %v.sroa.18.32.gep848.2.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 2056
  %v.sroa.18.32.copyload1839 = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep848.2.1.sroa_idx, align 8
  %gep848.2.1 = getelementptr i8, ptr addrspace(4) %133, i64 2048
  %v.sroa.14.32.copyload1838 = load <4 x half>, ptr addrspace(4) %gep848.2.1, align 16
  %v.sroa.12.16.gep848.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %133, i64 1032
  %v.sroa.12.16.copyload1835 = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep848.1.1.sroa_idx, align 8
  %gep848.1.1 = getelementptr i8, ptr addrspace(4) %133, i64 1024
  %v.sroa.8.16.copyload1834 = load <4 x half>, ptr addrspace(4) %gep848.1.1, align 16
  %v.sroa.6.0..sroa_idx1830 = getelementptr inbounds i8, ptr addrspace(4) %133, i64 8
  %v.sroa.6.0.copyload1831 = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx1830, align 8
  %v.sroa.0.0.copyload1829 = load <4 x half>, ptr addrspace(4) %133, align 16
  %scores.sroa.0.0.vec.extract1497 = extractelement <4 x float> %130, i64 0
  %mul318.1938 = fmul contract float %scores.sroa.0.0.vec.extract1497, 0x3FC2776C60000000
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul318.1938, float 1.500000e+01)
  %cmp.i.i.1939 = fcmp contract olt float %134, -1.260000e+02
  %cond.i.i814.1940 = select contract i1 %cmp.i.i.1939, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.1941 = fadd contract float %134, %cond.i.i814.1940
  %135 = tail call contract float @llvm.exp2.f32(float %add.i.i815.1941)
  %cond2.i.i.1942 = select contract i1 %cmp.i.i.1939, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1943 = fmul contract float %cond2.i.i.1942, %135
  %scores.sroa.0.4.vec.extract1522 = extractelement <4 x float> %130, i64 1
  %mul318.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1522, 0x3FC2776C60000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul318.1.1, float 1.500000e+01)
  %cmp.i.i.1.1 = fcmp contract olt float %136, -1.260000e+02
  %cond.i.i814.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.1.1 = fadd contract float %136, %cond.i.i814.1.1
  %137 = tail call contract float @llvm.exp2.f32(float %add.i.i815.1.1)
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %137
  %scores.sroa.0.8.vec.extract1547 = extractelement <4 x float> %130, i64 2
  %mul318.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1547, 0x3FC2776C60000000
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul318.2.1, float 1.500000e+01)
  %cmp.i.i.2.1 = fcmp contract olt float %138, -1.260000e+02
  %cond.i.i814.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.2.1 = fadd contract float %138, %cond.i.i814.2.1
  %139 = tail call contract float @llvm.exp2.f32(float %add.i.i815.2.1)
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %139
  %scores.sroa.0.12.vec.extract1572 = extractelement <4 x float> %130, i64 3
  %mul318.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1572, 0x3FC2776C60000000
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul318.3.1, float 1.500000e+01)
  %cmp.i.i.3.1 = fcmp contract olt float %140, -1.260000e+02
  %cond.i.i814.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.3.1 = fadd contract float %140, %cond.i.i814.3.1
  %141 = tail call contract float @llvm.exp2.f32(float %add.i.i815.3.1)
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %141
  %scores.sroa.90.16.vec.extract1613 = extractelement <4 x float> %131, i64 0
  %mul318.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1613, 0x3FC2776C60000000
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul318.4.1, float 1.500000e+01)
  %cmp.i.i.4.1 = fcmp contract olt float %142, -1.260000e+02
  %cond.i.i814.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.4.1 = fadd contract float %142, %cond.i.i814.4.1
  %143 = tail call contract float @llvm.exp2.f32(float %add.i.i815.4.1)
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %143
  %scores.sroa.90.20.vec.extract1638 = extractelement <4 x float> %131, i64 1
  %mul318.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1638, 0x3FC2776C60000000
  %144 = tail call contract noundef float @llvm.minnum.f32(float %mul318.5.1, float 1.500000e+01)
  %cmp.i.i.5.1 = fcmp contract olt float %144, -1.260000e+02
  %cond.i.i814.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.5.1 = fadd contract float %144, %cond.i.i814.5.1
  %145 = tail call contract float @llvm.exp2.f32(float %add.i.i815.5.1)
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %145
  %scores.sroa.90.24.vec.extract1663 = extractelement <4 x float> %131, i64 2
  %mul318.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1663, 0x3FC2776C60000000
  %146 = tail call contract noundef float @llvm.minnum.f32(float %mul318.6.1, float 1.500000e+01)
  %cmp.i.i.6.1 = fcmp contract olt float %146, -1.260000e+02
  %cond.i.i814.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.6.1 = fadd contract float %146, %cond.i.i814.6.1
  %147 = tail call contract float @llvm.exp2.f32(float %add.i.i815.6.1)
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %147
  %scores.sroa.90.28.vec.extract1688 = extractelement <4 x float> %131, i64 3
  %mul318.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1688, 0x3FC2776C60000000
  %148 = tail call contract noundef float @llvm.minnum.f32(float %mul318.7.1, float 1.500000e+01)
  %cmp.i.i.7.1 = fcmp contract olt float %148, -1.260000e+02
  %cond.i.i814.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i815.7.1 = fadd contract float %148, %cond.i.i814.7.1
  %149 = tail call contract float @llvm.exp2.f32(float %add.i.i815.7.1)
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %149
  %add338.1944 = fadd contract float %mul.i.i.1943, 0.000000e+00
  %add338.1.1 = fadd contract float %add338.1944, %mul.i.i.4.1
  %add338.2.1 = fadd contract float %add338.1.1, %mul.i.i.1.1
  %add338.3.1 = fadd contract float %add338.2.1, %mul.i.i.5.1
  %add338.4.1 = fadd contract float %add338.3.1, %mul.i.i.2.1
  %add338.5.1 = fadd contract float %add338.4.1, %mul.i.i.6.1
  %add338.6.1 = fadd contract float %add338.5.1, %mul.i.i.3.1
  %add338.7.1 = fadd contract float %add338.6.1, %mul.i.i.7.1
  %150 = bitcast float %add338.7.1 to i32
  %151 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %152 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %151) #11
  %xor.i.i.1 = xor i32 %152, 32
  %153 = and i32 %152, -64
  %and.i.i.1 = add nsw i32 %153, 64
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1
  %cond.i.i816.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %152
  %shl.i.i.1 = shl i32 %cond.i.i816.1, 2
  %154 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %150)
  %155 = bitcast i32 %154 to float
  %add.i.1 = fadd contract float %add338.7.1, %155
  %156 = bitcast float %add.i.1 to i32
  %157 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %158 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %157) #11
  %xor.i.i817.1 = xor i32 %158, 16
  %159 = and i32 %158, -64
  %and.i.i818.1 = add nsw i32 %159, 64
  %cmp.not.i.i819.1 = icmp slt i32 %xor.i.i817.1, %and.i.i818.1
  %cond.i.i820.1 = select i1 %cmp.not.i.i819.1, i32 %xor.i.i817.1, i32 %158
  %shl.i.i821.1 = shl i32 %cond.i.i820.1, 2
  %160 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i821.1, i32 %156)
  %161 = bitcast i32 %160 to float
  %add.i.i.1 = fadd contract float %add.i.1, %161
  %cmp347.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1
  %condval_8.0.1 = select i1 %cmp347.1, float %div.1, float 0.000000e+00
  %mul360.1945 = fmul contract float %condval_8.0.1, %mul.i.i.1943
  %mul360.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1
  %mul360.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1
  %mul360.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1
  %mul360.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1
  %mul360.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1
  %mul360.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1
  %mul360.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.1945)
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.1.1)
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.2.1)
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.3.1)
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.4.1)
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.5.1)
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.6.1)
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul360.7.1)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %170 = insertelement <4 x i16> poison, i16 %162, i64 0
  %171 = insertelement <4 x i16> %170, i16 %163, i64 1
  %172 = insertelement <4 x i16> %171, i16 %164, i64 2
  %173 = insertelement <4 x i16> %172, i16 %165, i64 3
  %174 = bitcast <4 x i16> %173 to <4 x half>
  %175 = insertelement <4 x i16> poison, i16 %166, i64 0
  %176 = insertelement <4 x i16> %175, i16 %167, i64 1
  %177 = insertelement <4 x i16> %176, i16 %168, i64 2
  %178 = insertelement <4 x i16> %177, i16 %169, i64 3
  %179 = bitcast <4 x i16> %178 to <4 x half>
  br label %if.end392.1

if.end392.1:                                      ; preds = %if.end139.1, %if.end48.preheader.1, %if.end392
  %v.sroa.48.3 = phi <4 x half> [ %v.sroa.48.1, %if.end392 ], [ %v.sroa.48.112.copyload1859, %if.end139.1 ], [ %v.sroa.48.1, %if.end48.preheader.1 ]
  %v.sroa.44.3 = phi <4 x half> [ %v.sroa.44.1, %if.end392 ], [ %v.sroa.44.112.copyload1858, %if.end139.1 ], [ %v.sroa.44.1, %if.end48.preheader.1 ]
  %v.sroa.42.3 = phi <4 x half> [ %v.sroa.42.1, %if.end392 ], [ %v.sroa.42.96.copyload1855, %if.end139.1 ], [ %v.sroa.42.1, %if.end48.preheader.1 ]
  %v.sroa.38.3 = phi <4 x half> [ %v.sroa.38.1, %if.end392 ], [ %v.sroa.38.96.copyload1854, %if.end139.1 ], [ %v.sroa.38.1, %if.end48.preheader.1 ]
  %v.sroa.36.3 = phi <4 x half> [ %v.sroa.36.1, %if.end392 ], [ %v.sroa.36.80.copyload1851, %if.end139.1 ], [ %v.sroa.36.1, %if.end48.preheader.1 ]
  %v.sroa.32.3 = phi <4 x half> [ %v.sroa.32.1, %if.end392 ], [ %v.sroa.32.80.copyload1850, %if.end139.1 ], [ %v.sroa.32.1, %if.end48.preheader.1 ]
  %v.sroa.30.3 = phi <4 x half> [ %v.sroa.30.1, %if.end392 ], [ %v.sroa.30.64.copyload1847, %if.end139.1 ], [ %v.sroa.30.1, %if.end48.preheader.1 ]
  %v.sroa.26.3 = phi <4 x half> [ %v.sroa.26.1, %if.end392 ], [ %v.sroa.26.64.copyload1846, %if.end139.1 ], [ %v.sroa.26.1, %if.end48.preheader.1 ]
  %v.sroa.24.3 = phi <4 x half> [ %v.sroa.24.1, %if.end392 ], [ %v.sroa.24.48.copyload1843, %if.end139.1 ], [ %v.sroa.24.1, %if.end48.preheader.1 ]
  %v.sroa.20.3 = phi <4 x half> [ %v.sroa.20.1, %if.end392 ], [ %v.sroa.20.48.copyload1842, %if.end139.1 ], [ %v.sroa.20.1, %if.end48.preheader.1 ]
  %v.sroa.18.3 = phi <4 x half> [ %v.sroa.18.1, %if.end392 ], [ %v.sroa.18.32.copyload1839, %if.end139.1 ], [ %v.sroa.18.1, %if.end48.preheader.1 ]
  %v.sroa.14.3 = phi <4 x half> [ %v.sroa.14.1, %if.end392 ], [ %v.sroa.14.32.copyload1838, %if.end139.1 ], [ %v.sroa.14.1, %if.end48.preheader.1 ]
  %v.sroa.12.3 = phi <4 x half> [ %v.sroa.12.1, %if.end392 ], [ %v.sroa.12.16.copyload1835, %if.end139.1 ], [ %v.sroa.12.1, %if.end48.preheader.1 ]
  %v.sroa.8.3 = phi <4 x half> [ %v.sroa.8.1, %if.end392 ], [ %v.sroa.8.16.copyload1834, %if.end139.1 ], [ %v.sroa.8.1, %if.end48.preheader.1 ]
  %v.sroa.6.3 = phi <4 x half> [ %v.sroa.6.1, %if.end392 ], [ %v.sroa.6.0.copyload1831, %if.end139.1 ], [ %v.sroa.6.1, %if.end48.preheader.1 ]
  %v.sroa.0.3 = phi <4 x half> [ %v.sroa.0.1, %if.end392 ], [ %v.sroa.0.0.copyload1829, %if.end139.1 ], [ %v.sroa.0.1, %if.end48.preheader.1 ]
  %180 = phi <4 x half> [ undef, %if.end392 ], [ %179, %if.end139.1 ], [ undef, %if.end48.preheader.1 ]
  %181 = phi <4 x half> [ undef, %if.end392 ], [ %174, %if.end139.1 ], [ undef, %if.end48.preheader.1 ]
  %shr428 = lshr i64 %2, 32
  %conv429 = trunc nuw i64 %shr428 to i32
  %cmp430 = icmp sgt i64 %2, -1
  %cmp434 = icmp slt i32 %conv429, 32
  %or.cond790 = select i1 %cmp430, i1 %cmp434, i1 false
  %mul438 = shl nsw i32 %conv429, 5
  %mul569 = and i32 %10, 4
  %mul624 = and i32 %8, 8064
  %invariant.gep867 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul624
  %182 = shl nuw nsw i32 %0, 18
  %mul639 = and i32 %182, 2145386496
  %add643 = add nsw i32 %8, -2048
  %mul640 = add nsw i32 %add643, %mul639
  %183 = tail call i32 @llvm.umin.i32(i32 %conv, i32 1024)
  %cmp439 = icmp slt i32 %mul438, %183
  %or.cond833 = select i1 %or.cond790, i1 %cmp439, i1 false
  br i1 %or.cond833, label %for.cond444.preheader, label %if.end545

for.cond444.preheader:                            ; preds = %if.end392.1
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %97, <4 x float> zeroinitializer)
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %97, <4 x float> zeroinitializer)
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %97, <4 x float> zeroinitializer)
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %97, <4 x float> zeroinitializer)
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %97, <4 x float> zeroinitializer)
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %97, <4 x float> zeroinitializer)
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %97, <4 x float> zeroinitializer)
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %97, <4 x float> zeroinitializer)
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %96, <4 x float> %184)
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %96, <4 x float> %185)
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %96, <4 x float> %186)
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %96, <4 x float> %187)
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %96, <4 x float> %188)
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %96, <4 x float> %189)
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %96, <4 x float> %190)
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %96, <4 x float> %191)
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %192, i64 0
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract)
  %output_reg.sroa.0.0.insert.ext = zext i16 %200 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %192, i64 1
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract)
  %output_reg.sroa.0.2.insert.ext = zext i16 %201 to i64
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %192, i64 2
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract)
  %output_reg.sroa.0.4.insert.ext = zext i16 %202 to i64
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32
  %output_reg.sroa.0.4.insert.insert1212 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %192, i64 3
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract)
  %output_reg.sroa.0.6.insert.ext = zext i16 %203 to i64
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1212, %output_reg.sroa.0.6.insert.shift
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %193, i64 0
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract)
  %output_reg.sroa.16.8.insert.ext = zext i16 %204 to i64
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %193, i64 1
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract)
  %output_reg.sroa.16.10.insert.ext = zext i16 %205 to i64
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %193, i64 2
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract)
  %output_reg.sroa.16.12.insert.ext = zext i16 %206 to i64
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32
  %output_reg.sroa.16.12.insert.insert1244 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %193, i64 3
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract)
  %output_reg.sroa.16.14.insert.ext = zext i16 %207 to i64
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1244, %output_reg.sroa.16.14.insert.shift
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %194, i64 0
  %208 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract)
  %output_reg.sroa.30.16.insert.ext = zext i16 %208 to i64
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %194, i64 1
  %209 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract)
  %output_reg.sroa.30.18.insert.ext = zext i16 %209 to i64
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %194, i64 2
  %210 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract)
  %output_reg.sroa.30.20.insert.ext = zext i16 %210 to i64
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32
  %output_reg.sroa.30.20.insert.insert1276 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %194, i64 3
  %211 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract)
  %output_reg.sroa.30.22.insert.ext = zext i16 %211 to i64
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1276, %output_reg.sroa.30.22.insert.shift
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %195, i64 0
  %212 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract)
  %output_reg.sroa.44.24.insert.ext = zext i16 %212 to i64
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %195, i64 1
  %213 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract)
  %output_reg.sroa.44.26.insert.ext = zext i16 %213 to i64
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %195, i64 2
  %214 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract)
  %output_reg.sroa.44.28.insert.ext = zext i16 %214 to i64
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32
  %output_reg.sroa.44.28.insert.insert1308 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %195, i64 3
  %215 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract)
  %output_reg.sroa.44.30.insert.ext = zext i16 %215 to i64
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1308, %output_reg.sroa.44.30.insert.shift
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %196, i64 0
  %216 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract)
  %output_reg.sroa.58.32.insert.ext = zext i16 %216 to i64
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %196, i64 1
  %217 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract)
  %output_reg.sroa.58.34.insert.ext = zext i16 %217 to i64
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %196, i64 2
  %218 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract)
  %output_reg.sroa.58.36.insert.ext = zext i16 %218 to i64
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32
  %output_reg.sroa.58.36.insert.insert1340 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %196, i64 3
  %219 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract)
  %output_reg.sroa.58.38.insert.ext = zext i16 %219 to i64
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1340, %output_reg.sroa.58.38.insert.shift
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %197, i64 0
  %220 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract)
  %output_reg.sroa.72.40.insert.ext = zext i16 %220 to i64
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %197, i64 1
  %221 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract)
  %output_reg.sroa.72.42.insert.ext = zext i16 %221 to i64
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %197, i64 2
  %222 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract)
  %output_reg.sroa.72.44.insert.ext = zext i16 %222 to i64
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32
  %output_reg.sroa.72.44.insert.insert1372 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %197, i64 3
  %223 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract)
  %output_reg.sroa.72.46.insert.ext = zext i16 %223 to i64
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1372, %output_reg.sroa.72.46.insert.shift
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %198, i64 0
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract)
  %output_reg.sroa.86.48.insert.ext = zext i16 %224 to i64
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %198, i64 1
  %225 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract)
  %output_reg.sroa.86.50.insert.ext = zext i16 %225 to i64
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %198, i64 2
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract)
  %output_reg.sroa.86.52.insert.ext = zext i16 %226 to i64
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32
  %output_reg.sroa.86.52.insert.insert1404 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %198, i64 3
  %227 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract)
  %output_reg.sroa.86.54.insert.ext = zext i16 %227 to i64
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1404, %output_reg.sroa.86.54.insert.shift
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %199, i64 0
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract)
  %output_reg.sroa.100.56.insert.ext = zext i16 %228 to i64
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %199, i64 1
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract)
  %output_reg.sroa.100.58.insert.ext = zext i16 %229 to i64
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %199, i64 2
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract)
  %output_reg.sroa.100.60.insert.ext = zext i16 %230 to i64
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32
  %output_reg.sroa.100.60.insert.insert1436 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %199, i64 3
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract)
  %output_reg.sroa.100.62.insert.ext = zext i16 %231 to i64
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1436, %output_reg.sroa.100.62.insert.shift
  br label %if.end545

if.end545:                                        ; preds = %if.end392.1, %for.cond444.preheader
  %output_reg.sroa.100.0 = phi i64 [ %output_reg.sroa.100.62.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  %output_reg.sroa.86.0 = phi i64 [ %output_reg.sroa.86.54.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  %output_reg.sroa.72.0 = phi i64 [ %output_reg.sroa.72.46.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  %output_reg.sroa.58.0 = phi i64 [ %output_reg.sroa.58.38.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.30.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.22.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.14.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond444.preheader ], [ 0, %if.end392.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor563 = xor i32 %shr158, %and183
  %mul564 = shl nuw nsw i32 %xor563, 3
  %add565 = add nuw nsw i32 %mul564, %mul177
  %add570 = or disjoint i32 %add565, %mul569
  %add.ptr572 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr572, align 8
  %add560.1 = add nuw nsw i32 %shr158, 2
  %xor563.1 = xor i32 %add560.1, %and183
  %mul564.1 = shl nuw nsw i32 %xor563.1, 3
  %add565.1 = add nuw nsw i32 %mul564.1, %mul177
  %add570.1 = or disjoint i32 %add565.1, %mul569
  %add.ptr572.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.1
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr572.1, align 8
  %add560.2 = add nuw nsw i32 %shr158, 4
  %xor563.2 = xor i32 %add560.2, %and183
  %mul564.2 = shl nuw nsw i32 %xor563.2, 3
  %add565.2 = add nuw nsw i32 %mul564.2, %mul177
  %add570.2 = or disjoint i32 %add565.2, %mul569
  %add.ptr572.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.2
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr572.2, align 8
  %add560.3 = add nuw nsw i32 %shr158, 6
  %xor563.3 = xor i32 %add560.3, %and183
  %mul564.3 = shl nuw nsw i32 %xor563.3, 3
  %add565.3 = add nuw nsw i32 %mul564.3, %mul177
  %add570.3 = or disjoint i32 %add565.3, %mul569
  %add.ptr572.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.3
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr572.3, align 8
  %add560.4 = add nuw nsw i32 %shr158, 8
  %xor563.4 = xor i32 %add560.4, %and183
  %mul564.4 = shl nuw nsw i32 %xor563.4, 3
  %add565.4 = add nuw nsw i32 %mul564.4, %mul177
  %add570.4 = or disjoint i32 %add565.4, %mul569
  %add.ptr572.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.4
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr572.4, align 8
  %add560.5 = add nuw nsw i32 %shr158, 10
  %xor563.5 = xor i32 %add560.5, %and183
  %mul564.5 = shl nuw nsw i32 %xor563.5, 3
  %add565.5 = add nuw nsw i32 %mul564.5, %mul177
  %add570.5 = or disjoint i32 %add565.5, %mul569
  %add.ptr572.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.5
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr572.5, align 8
  %add560.6 = add nuw nsw i32 %shr158, 12
  %xor563.6 = xor i32 %add560.6, %and183
  %mul564.6 = shl nuw nsw i32 %xor563.6, 3
  %add565.6 = add nuw nsw i32 %mul564.6, %mul177
  %add570.6 = or disjoint i32 %add565.6, %mul569
  %add.ptr572.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.6
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr572.6, align 8
  %add560.7 = add nuw nsw i32 %shr158, 14
  %xor563.7 = xor i32 %add560.7, %and183
  %mul564.7 = shl nuw nsw i32 %xor563.7, 3
  %add565.7 = add nuw nsw i32 %mul564.7, %mul177
  %add570.7 = or disjoint i32 %add565.7, %mul569
  %add.ptr572.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.7
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr572.7, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor632 = xor i32 %shr180, %and183
  %add.ptr636.idx = shl nuw nsw i32 %xor632, 4
  %add.ptr636 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 %add.ptr636.idx
  %condval_13.0 = shl nuw nsw i32 %183, 11
  %add646 = add i32 %mul640, %condval_13.0
  %idx.ext647 = sext i32 %add646 to i64
  %add.ptr648 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  %add631.1 = add nuw nsw i32 %shr180, 4
  %xor632.1 = xor i32 %add631.1, %and183
  %gep868.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 1024
  %add.ptr636.idx.1 = shl nuw nsw i32 %xor632.1, 4
  %add.ptr636.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.1, i32 %add.ptr636.idx.1
  %add641.1 = add nsw i32 %mul640, 512
  %add646.1 = add i32 %add641.1, %condval_13.0
  %idx.ext647.1 = sext i32 %add646.1 to i64
  %add.ptr648.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.1, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  %add631.2 = add nuw nsw i32 %shr180, 8
  %xor632.2 = xor i32 %add631.2, %and183
  %gep868.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 2048
  %add.ptr636.idx.2 = shl nuw nsw i32 %xor632.2, 4
  %add.ptr636.2 = getelementptr inbounds i8, ptr addrspace(3) %gep868.2, i32 %add.ptr636.idx.2
  %add641.2 = add nsw i32 %mul640, 1024
  %add646.2 = add i32 %add641.2, %condval_13.0
  %idx.ext647.2 = sext i32 %add646.2 to i64
  %add.ptr648.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.2
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.2, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  %add631.3 = add nuw nsw i32 %shr180, 12
  %xor632.3 = xor i32 %add631.3, %and183
  %gep868.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 3072
  %add.ptr636.idx.3 = shl nuw nsw i32 %xor632.3, 4
  %add.ptr636.3 = getelementptr inbounds i8, ptr addrspace(3) %gep868.3, i32 %add.ptr636.idx.3
  %add641.3 = add nsw i32 %mul640, 1536
  %add646.3 = add i32 %add641.3, %condval_13.0
  %idx.ext647.3 = sext i32 %add646.3 to i64
  %add.ptr648.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.3, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br i1 %cmp16.not.1, label %if.end657, label %if.then414.1

if.then414.1:                                     ; preds = %if.end545
  %232 = tail call i32 @llvm.umin.i32(i32 %4, i32 1024)
  %cmp439.1 = icmp slt i32 %mul438, %232
  %or.cond833.1 = select i1 %or.cond790, i1 %cmp439.1, i1 false
  br i1 %or.cond833.1, label %for.cond444.preheader.1, label %if.end545.1

for.cond444.preheader.1:                          ; preds = %if.then414.1
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %181, <4 x float> zeroinitializer)
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %181, <4 x float> zeroinitializer)
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %181, <4 x float> zeroinitializer)
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %181, <4 x float> zeroinitializer)
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %181, <4 x float> zeroinitializer)
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %181, <4 x float> zeroinitializer)
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %181, <4 x float> zeroinitializer)
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %181, <4 x float> zeroinitializer)
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %180, <4 x float> %233)
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %180, <4 x float> %234)
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %180, <4 x float> %235)
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %180, <4 x float> %236)
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %180, <4 x float> %237)
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %180, <4 x float> %238)
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %180, <4 x float> %239)
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %180, <4 x float> %240)
  %out.sroa.0.0.vec.extract1007 = extractelement <4 x float> %241, i64 0
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract1007)
  %output_reg.sroa.0.0.insert.ext1199 = zext i16 %249 to i64
  %out.sroa.0.4.vec.extract1012 = extractelement <4 x float> %241, i64 1
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract1012)
  %output_reg.sroa.0.2.insert.ext1203 = zext i16 %250 to i64
  %output_reg.sroa.0.2.insert.shift1204 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1203, 16
  %output_reg.sroa.0.2.insert.insert1206 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1204, %output_reg.sroa.0.0.insert.ext1199
  %out.sroa.0.8.vec.extract1017 = extractelement <4 x float> %241, i64 2
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract1017)
  %output_reg.sroa.0.4.insert.ext1214 = zext i16 %251 to i64
  %output_reg.sroa.0.4.insert.shift1215 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1214, 32
  %output_reg.sroa.0.4.insert.insert1217 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1206, %output_reg.sroa.0.4.insert.shift1215
  %out.sroa.0.12.vec.extract1022 = extractelement <4 x float> %241, i64 3
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract1022)
  %output_reg.sroa.0.6.insert.ext1219 = zext i16 %252 to i64
  %output_reg.sroa.0.6.insert.shift1220 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1219, 48
  %output_reg.sroa.0.6.insert.insert1222 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1217, %output_reg.sroa.0.6.insert.shift1220
  %out.sroa.26.16.vec.extract1031 = extractelement <4 x float> %242, i64 0
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract1031)
  %output_reg.sroa.16.8.insert.ext1231 = zext i16 %253 to i64
  %out.sroa.26.20.vec.extract1036 = extractelement <4 x float> %242, i64 1
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract1036)
  %output_reg.sroa.16.10.insert.ext1235 = zext i16 %254 to i64
  %output_reg.sroa.16.10.insert.shift1236 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1235, 16
  %output_reg.sroa.16.10.insert.insert1238 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1236, %output_reg.sroa.16.8.insert.ext1231
  %out.sroa.26.24.vec.extract1041 = extractelement <4 x float> %242, i64 2
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract1041)
  %output_reg.sroa.16.12.insert.ext1246 = zext i16 %255 to i64
  %output_reg.sroa.16.12.insert.shift1247 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1246, 32
  %output_reg.sroa.16.12.insert.insert1249 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1238, %output_reg.sroa.16.12.insert.shift1247
  %out.sroa.26.28.vec.extract1046 = extractelement <4 x float> %242, i64 3
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract1046)
  %output_reg.sroa.16.14.insert.ext1251 = zext i16 %256 to i64
  %output_reg.sroa.16.14.insert.shift1252 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1251, 48
  %output_reg.sroa.16.14.insert.insert1254 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1249, %output_reg.sroa.16.14.insert.shift1252
  %out.sroa.50.32.vec.extract1055 = extractelement <4 x float> %243, i64 0
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract1055)
  %output_reg.sroa.30.16.insert.ext1263 = zext i16 %257 to i64
  %out.sroa.50.36.vec.extract1060 = extractelement <4 x float> %243, i64 1
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract1060)
  %output_reg.sroa.30.18.insert.ext1267 = zext i16 %258 to i64
  %output_reg.sroa.30.18.insert.shift1268 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1267, 16
  %output_reg.sroa.30.18.insert.insert1270 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1268, %output_reg.sroa.30.16.insert.ext1263
  %out.sroa.50.40.vec.extract1065 = extractelement <4 x float> %243, i64 2
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract1065)
  %output_reg.sroa.30.20.insert.ext1278 = zext i16 %259 to i64
  %output_reg.sroa.30.20.insert.shift1279 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1278, 32
  %output_reg.sroa.30.20.insert.insert1281 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1270, %output_reg.sroa.30.20.insert.shift1279
  %out.sroa.50.44.vec.extract1070 = extractelement <4 x float> %243, i64 3
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract1070)
  %output_reg.sroa.30.22.insert.ext1283 = zext i16 %260 to i64
  %output_reg.sroa.30.22.insert.shift1284 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1283, 48
  %output_reg.sroa.30.22.insert.insert1286 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1281, %output_reg.sroa.30.22.insert.shift1284
  %out.sroa.74.48.vec.extract1079 = extractelement <4 x float> %244, i64 0
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract1079)
  %output_reg.sroa.44.24.insert.ext1295 = zext i16 %261 to i64
  %out.sroa.74.52.vec.extract1084 = extractelement <4 x float> %244, i64 1
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract1084)
  %output_reg.sroa.44.26.insert.ext1299 = zext i16 %262 to i64
  %output_reg.sroa.44.26.insert.shift1300 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1299, 16
  %output_reg.sroa.44.26.insert.insert1302 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1300, %output_reg.sroa.44.24.insert.ext1295
  %out.sroa.74.56.vec.extract1089 = extractelement <4 x float> %244, i64 2
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract1089)
  %output_reg.sroa.44.28.insert.ext1310 = zext i16 %263 to i64
  %output_reg.sroa.44.28.insert.shift1311 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1310, 32
  %output_reg.sroa.44.28.insert.insert1313 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1302, %output_reg.sroa.44.28.insert.shift1311
  %out.sroa.74.60.vec.extract1094 = extractelement <4 x float> %244, i64 3
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract1094)
  %output_reg.sroa.44.30.insert.ext1315 = zext i16 %264 to i64
  %output_reg.sroa.44.30.insert.shift1316 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1315, 48
  %output_reg.sroa.44.30.insert.insert1318 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1313, %output_reg.sroa.44.30.insert.shift1316
  %out.sroa.98.64.vec.extract1103 = extractelement <4 x float> %245, i64 0
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract1103)
  %output_reg.sroa.58.32.insert.ext1327 = zext i16 %265 to i64
  %out.sroa.98.68.vec.extract1108 = extractelement <4 x float> %245, i64 1
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract1108)
  %output_reg.sroa.58.34.insert.ext1331 = zext i16 %266 to i64
  %output_reg.sroa.58.34.insert.shift1332 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1331, 16
  %output_reg.sroa.58.34.insert.insert1334 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1332, %output_reg.sroa.58.32.insert.ext1327
  %out.sroa.98.72.vec.extract1113 = extractelement <4 x float> %245, i64 2
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract1113)
  %output_reg.sroa.58.36.insert.ext1342 = zext i16 %267 to i64
  %output_reg.sroa.58.36.insert.shift1343 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1342, 32
  %output_reg.sroa.58.36.insert.insert1345 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1334, %output_reg.sroa.58.36.insert.shift1343
  %out.sroa.98.76.vec.extract1118 = extractelement <4 x float> %245, i64 3
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract1118)
  %output_reg.sroa.58.38.insert.ext1347 = zext i16 %268 to i64
  %output_reg.sroa.58.38.insert.shift1348 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1347, 48
  %output_reg.sroa.58.38.insert.insert1350 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1345, %output_reg.sroa.58.38.insert.shift1348
  %out.sroa.122.80.vec.extract1127 = extractelement <4 x float> %246, i64 0
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract1127)
  %output_reg.sroa.72.40.insert.ext1359 = zext i16 %269 to i64
  %out.sroa.122.84.vec.extract1132 = extractelement <4 x float> %246, i64 1
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract1132)
  %output_reg.sroa.72.42.insert.ext1363 = zext i16 %270 to i64
  %output_reg.sroa.72.42.insert.shift1364 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1363, 16
  %output_reg.sroa.72.42.insert.insert1366 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1364, %output_reg.sroa.72.40.insert.ext1359
  %out.sroa.122.88.vec.extract1137 = extractelement <4 x float> %246, i64 2
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract1137)
  %output_reg.sroa.72.44.insert.ext1374 = zext i16 %271 to i64
  %output_reg.sroa.72.44.insert.shift1375 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1374, 32
  %output_reg.sroa.72.44.insert.insert1377 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1366, %output_reg.sroa.72.44.insert.shift1375
  %out.sroa.122.92.vec.extract1142 = extractelement <4 x float> %246, i64 3
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract1142)
  %output_reg.sroa.72.46.insert.ext1379 = zext i16 %272 to i64
  %output_reg.sroa.72.46.insert.shift1380 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1379, 48
  %output_reg.sroa.72.46.insert.insert1382 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1377, %output_reg.sroa.72.46.insert.shift1380
  %out.sroa.146.96.vec.extract1151 = extractelement <4 x float> %247, i64 0
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract1151)
  %output_reg.sroa.86.48.insert.ext1391 = zext i16 %273 to i64
  %out.sroa.146.100.vec.extract1156 = extractelement <4 x float> %247, i64 1
  %274 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract1156)
  %output_reg.sroa.86.50.insert.ext1395 = zext i16 %274 to i64
  %output_reg.sroa.86.50.insert.shift1396 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1395, 16
  %output_reg.sroa.86.50.insert.insert1398 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1396, %output_reg.sroa.86.48.insert.ext1391
  %out.sroa.146.104.vec.extract1161 = extractelement <4 x float> %247, i64 2
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract1161)
  %output_reg.sroa.86.52.insert.ext1406 = zext i16 %275 to i64
  %output_reg.sroa.86.52.insert.shift1407 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1406, 32
  %output_reg.sroa.86.52.insert.insert1409 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1398, %output_reg.sroa.86.52.insert.shift1407
  %out.sroa.146.108.vec.extract1166 = extractelement <4 x float> %247, i64 3
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract1166)
  %output_reg.sroa.86.54.insert.ext1411 = zext i16 %276 to i64
  %output_reg.sroa.86.54.insert.shift1412 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1411, 48
  %output_reg.sroa.86.54.insert.insert1414 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1409, %output_reg.sroa.86.54.insert.shift1412
  %out.sroa.170.112.vec.extract1175 = extractelement <4 x float> %248, i64 0
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1175)
  %output_reg.sroa.100.56.insert.ext1423 = zext i16 %277 to i64
  %out.sroa.170.116.vec.extract1180 = extractelement <4 x float> %248, i64 1
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1180)
  %output_reg.sroa.100.58.insert.ext1427 = zext i16 %278 to i64
  %output_reg.sroa.100.58.insert.shift1428 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1427, 16
  %output_reg.sroa.100.58.insert.insert1430 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1428, %output_reg.sroa.100.56.insert.ext1423
  %out.sroa.170.120.vec.extract1185 = extractelement <4 x float> %248, i64 2
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1185)
  %output_reg.sroa.100.60.insert.ext1438 = zext i16 %279 to i64
  %output_reg.sroa.100.60.insert.shift1439 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1438, 32
  %output_reg.sroa.100.60.insert.insert1441 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1430, %output_reg.sroa.100.60.insert.shift1439
  %out.sroa.170.124.vec.extract1190 = extractelement <4 x float> %248, i64 3
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1190)
  %output_reg.sroa.100.62.insert.ext1443 = zext i16 %280 to i64
  %output_reg.sroa.100.62.insert.shift1444 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1443, 48
  %output_reg.sroa.100.62.insert.insert1446 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1441, %output_reg.sroa.100.62.insert.shift1444
  br label %if.end545.1

if.end545.1:                                      ; preds = %if.then414.1, %for.cond444.preheader.1
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1446, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1414, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1382, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1350, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1318, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1286, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1254, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1222, %for.cond444.preheader.1 ], [ 0, %if.then414.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor563.1985 = xor i32 %shr158, %and183
  %mul564.1986 = shl nuw nsw i32 %xor563.1985, 3
  %add565.1987 = add nuw nsw i32 %mul564.1986, %mul177
  %add570.1988 = or disjoint i32 %add565.1987, %mul569
  %add.ptr572.1989 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.1988
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr572.1989, align 8
  %add560.1.1 = add nuw nsw i32 %shr158, 2
  %xor563.1.1 = xor i32 %add560.1.1, %and183
  %mul564.1.1 = shl nuw nsw i32 %xor563.1.1, 3
  %add565.1.1 = add nuw nsw i32 %mul564.1.1, %mul177
  %add570.1.1 = or disjoint i32 %add565.1.1, %mul569
  %add.ptr572.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.1.1
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr572.1.1, align 8
  %add560.2.1 = add nuw nsw i32 %shr158, 4
  %xor563.2.1 = xor i32 %add560.2.1, %and183
  %mul564.2.1 = shl nuw nsw i32 %xor563.2.1, 3
  %add565.2.1 = add nuw nsw i32 %mul564.2.1, %mul177
  %add570.2.1 = or disjoint i32 %add565.2.1, %mul569
  %add.ptr572.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.2.1
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr572.2.1, align 8
  %add560.3.1 = add nuw nsw i32 %shr158, 6
  %xor563.3.1 = xor i32 %add560.3.1, %and183
  %mul564.3.1 = shl nuw nsw i32 %xor563.3.1, 3
  %add565.3.1 = add nuw nsw i32 %mul564.3.1, %mul177
  %add570.3.1 = or disjoint i32 %add565.3.1, %mul569
  %add.ptr572.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.3.1
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr572.3.1, align 8
  %add560.4.1 = add nuw nsw i32 %shr158, 8
  %xor563.4.1 = xor i32 %add560.4.1, %and183
  %mul564.4.1 = shl nuw nsw i32 %xor563.4.1, 3
  %add565.4.1 = add nuw nsw i32 %mul564.4.1, %mul177
  %add570.4.1 = or disjoint i32 %add565.4.1, %mul569
  %add.ptr572.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.4.1
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr572.4.1, align 8
  %add560.5.1 = add nuw nsw i32 %shr158, 10
  %xor563.5.1 = xor i32 %add560.5.1, %and183
  %mul564.5.1 = shl nuw nsw i32 %xor563.5.1, 3
  %add565.5.1 = add nuw nsw i32 %mul564.5.1, %mul177
  %add570.5.1 = or disjoint i32 %add565.5.1, %mul569
  %add.ptr572.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.5.1
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr572.5.1, align 8
  %add560.6.1 = add nuw nsw i32 %shr158, 12
  %xor563.6.1 = xor i32 %add560.6.1, %and183
  %mul564.6.1 = shl nuw nsw i32 %xor563.6.1, 3
  %add565.6.1 = add nuw nsw i32 %mul564.6.1, %mul177
  %add570.6.1 = or disjoint i32 %add565.6.1, %mul569
  %add.ptr572.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.6.1
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr572.6.1, align 8
  %add560.7.1 = add nuw nsw i32 %shr158, 14
  %xor563.7.1 = xor i32 %add560.7.1, %and183
  %mul564.7.1 = shl nuw nsw i32 %xor563.7.1, 3
  %add565.7.1 = add nuw nsw i32 %mul564.7.1, %mul177
  %add570.7.1 = or disjoint i32 %add565.7.1, %mul569
  %add.ptr572.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add570.7.1
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr572.7.1, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %xor632.1992 = xor i32 %shr180, %and183
  %add.ptr636.idx.1993 = shl nuw nsw i32 %xor632.1992, 4
  %add.ptr636.1994 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 %add.ptr636.idx.1993
  %condval_13.0.1995 = shl nuw nsw i32 %232, 11
  %add646.1996 = add i32 %mul640, %condval_13.0.1995
  %idx.ext647.1997 = sext i32 %add646.1996 to i64
  %add.ptr648.1998 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.1997
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.1998, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.1994, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  %add631.1.1 = add nuw nsw i32 %shr180, 4
  %xor632.1.1 = xor i32 %add631.1.1, %and183
  %gep868.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 1024
  %add.ptr636.idx.1.1 = shl nuw nsw i32 %xor632.1.1, 4
  %add.ptr636.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.1.1, i32 %add.ptr636.idx.1.1
  %add641.1.1 = add nsw i32 %mul640, 512
  %add646.1.1 = add i32 %add641.1.1, %condval_13.0.1995
  %idx.ext647.1.1 = sext i32 %add646.1.1 to i64
  %add.ptr648.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.1.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.1.1, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  %add631.2.1 = add nuw nsw i32 %shr180, 8
  %xor632.2.1 = xor i32 %add631.2.1, %and183
  %gep868.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 2048
  %add.ptr636.idx.2.1 = shl nuw nsw i32 %xor632.2.1, 4
  %add.ptr636.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.2.1, i32 %add.ptr636.idx.2.1
  %add641.2.1 = add nsw i32 %mul640, 1024
  %add646.2.1 = add i32 %add641.2.1, %condval_13.0.1995
  %idx.ext647.2.1 = sext i32 %add646.2.1 to i64
  %add.ptr648.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.2.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.2.1, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  %add631.3.1 = add nuw nsw i32 %shr180, 12
  %xor632.3.1 = xor i32 %add631.3.1, %and183
  %gep868.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep867, i32 3072
  %add.ptr636.idx.3.1 = shl nuw nsw i32 %xor632.3.1, 4
  %add.ptr636.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep868.3.1, i32 %add.ptr636.idx.3.1
  %add641.3.1 = add nsw i32 %mul640, 1536
  %add646.3.1 = add i32 %add641.3.1, %condval_13.0.1995
  %idx.ext647.3.1 = sext i32 %add646.3.1 to i64
  %add.ptr648.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %idx.ext647.3.1
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr648.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr636.3.1, i64 16, i1 false), !tbaa.struct !201, !call_argsrelate !202
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end657

if.end657:                                        ; preds = %if.end545, %if.end545.1, %entry
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i16 @llvm.convert.to.fp16.f32(float) #6

declare void @llvm.mxc.barrier.warp() #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #8

declare float @llvm.exp2.f32(float) #9

declare i32 @llvm.smin.i32(i32, i32) #9

declare float @llvm.minnum.f32(float, float) #9

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

declare i64 @llvm.umin.i64(i64, i64) #9

declare i32 @llvm.umin.i32(i32, i32) #9

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }


