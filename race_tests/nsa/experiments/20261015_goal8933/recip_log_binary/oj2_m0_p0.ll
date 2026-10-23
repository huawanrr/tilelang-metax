; ModuleID = 'experiments/20261015_goal8933/recip_log_binary/oj2_m0_p0.bc'
source_filename = "/tmp/tmpshsk2msh/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %1, 6
  %mul7 = and i32 %and, 960
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64, !dbg !44
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72, !dbg !45
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  fence syncscope("warp") release, !dbg !46
  tail call void @llvm.mxc.barrier.warp(), !dbg !52
  fence syncscope("warp") acquire, !dbg !53
  %idxprom = zext nneg i32 %0 to i64, !dbg !54
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !54
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !54, !tbaa !30
  %cmp31 = icmp ugt i32 %5, 7
  %shr34 = lshr i32 %0, 4
  %cmp35.not = icmp ugt i32 %5, %shr34
  %or.cond350 = or i1 %cmp31, %cmp35.not, !dbg !55
  br i1 %or.cond350, label %entry.if.end217_crit_edge, label %for.cond36.preheader, !dbg !55

entry.if.end217_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  %.pre441 = and i32 %.pre, 252
  br label %if.end217, !dbg !55

for.cond36.preheader:                             ; preds = %entry
  %mul41 = shl nuw nsw i32 %5, 10
  %add45 = add nuw nsw i32 %mul11, %mul7
  %add47 = add nuw nsw i32 %add45, %mul41
  %6 = zext nneg i32 %add47 to i64, !dbg !56
  %add.ptr53 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6, !dbg !57
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr53, align 16, !dbg !58
  %k.sroa.4.0.add.ptr53.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr53, i64 8, !dbg !58
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr53.sroa_idx, align 8, !dbg !58
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6, !dbg !57
  %add.ptr53.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 64, !dbg !57
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr53.1, align 16, !dbg !58
  %k.sroa.7.16.add.ptr53.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 72, !dbg !58
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.add.ptr53.1.sroa_idx, align 8, !dbg !58
  %8 = shl nuw nsw i32 %1, 4
  %mul69 = and i32 %8, 16128
  %add70 = add nuw nsw i32 %mul41, %mul69
  %and78 = and i32 %1, 15
  %add79 = or disjoint i32 %add70, %and78, !dbg !59
  %idxprom80 = zext nneg i32 %add79 to i64, !dbg !60
  %arrayidx81 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80, !dbg !60
  %9 = load half, ptr addrspace(4) %arrayidx81, align 2, !dbg !61, !tbaa !62
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %9, i64 0, !dbg !61
  %add73.1 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.1 = or disjoint i32 %add73.1, 64, !dbg !59
  %idxprom80.1 = zext nneg i32 %add79.1 to i64, !dbg !60
  %arrayidx81.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.1, !dbg !60
  %10 = load half, ptr addrspace(4) %arrayidx81.1, align 2, !dbg !61, !tbaa !62
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %10, i64 1, !dbg !61
  %add73.2 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.2 = or disjoint i32 %add73.2, 128, !dbg !59
  %idxprom80.2 = zext nneg i32 %add79.2 to i64, !dbg !60
  %arrayidx81.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.2, !dbg !60
  %11 = load half, ptr addrspace(4) %arrayidx81.2, align 2, !dbg !61, !tbaa !62
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %11, i64 2, !dbg !61
  %add73.3 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.3 = or disjoint i32 %add73.3, 192, !dbg !59
  %idxprom80.3 = zext nneg i32 %add79.3 to i64, !dbg !60
  %arrayidx81.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.3, !dbg !60
  %12 = load half, ptr addrspace(4) %arrayidx81.3, align 2, !dbg !61, !tbaa !62
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %12, i64 3, !dbg !61
  %add76.4 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.4 = or disjoint i32 %add76.4, 16, !dbg !59
  %idxprom80.4 = zext nneg i32 %add79.4 to i64, !dbg !60
  %arrayidx81.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.4, !dbg !60
  %13 = load half, ptr addrspace(4) %arrayidx81.4, align 2, !dbg !61, !tbaa !62
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %13, i64 0, !dbg !61
  %add76.5 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.5 = or disjoint i32 %add76.5, 80, !dbg !59
  %idxprom80.5 = zext nneg i32 %add79.5 to i64, !dbg !60
  %arrayidx81.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.5, !dbg !60
  %14 = load half, ptr addrspace(4) %arrayidx81.5, align 2, !dbg !61, !tbaa !62
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %14, i64 1, !dbg !61
  %add76.6 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.6 = or disjoint i32 %add76.6, 144, !dbg !59
  %idxprom80.6 = zext nneg i32 %add79.6 to i64, !dbg !60
  %arrayidx81.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.6, !dbg !60
  %15 = load half, ptr addrspace(4) %arrayidx81.6, align 2, !dbg !61, !tbaa !62
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %15, i64 2, !dbg !61
  %add76.7 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.7 = or disjoint i32 %add76.7, 208, !dbg !59
  %idxprom80.7 = zext nneg i32 %add79.7 to i64, !dbg !60
  %arrayidx81.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.7, !dbg !60
  %16 = load half, ptr addrspace(4) %arrayidx81.7, align 2, !dbg !61, !tbaa !62
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %16, i64 3, !dbg !61
  %add76.8 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.8 = or disjoint i32 %add76.8, 32, !dbg !59
  %idxprom80.8 = zext nneg i32 %add79.8 to i64, !dbg !60
  %arrayidx81.8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.8, !dbg !60
  %17 = load half, ptr addrspace(4) %arrayidx81.8, align 2, !dbg !61, !tbaa !62
  %v.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %17, i64 0, !dbg !61
  %add76.9 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.9 = or disjoint i32 %add76.9, 96, !dbg !59
  %idxprom80.9 = zext nneg i32 %add79.9 to i64, !dbg !60
  %arrayidx81.9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.9, !dbg !60
  %18 = load half, ptr addrspace(4) %arrayidx81.9, align 2, !dbg !61, !tbaa !62
  %v.sroa.12.18.vec.insert = insertelement <4 x half> %v.sroa.12.16.vec.insert, half %18, i64 1, !dbg !61
  %add76.10 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.10 = or disjoint i32 %add76.10, 160, !dbg !59
  %idxprom80.10 = zext nneg i32 %add79.10 to i64, !dbg !60
  %arrayidx81.10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.10, !dbg !60
  %19 = load half, ptr addrspace(4) %arrayidx81.10, align 2, !dbg !61, !tbaa !62
  %v.sroa.12.20.vec.insert = insertelement <4 x half> %v.sroa.12.18.vec.insert, half %19, i64 2, !dbg !61
  %add76.11 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.11 = or disjoint i32 %add76.11, 224, !dbg !59
  %idxprom80.11 = zext nneg i32 %add79.11 to i64, !dbg !60
  %arrayidx81.11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.11, !dbg !60
  %20 = load half, ptr addrspace(4) %arrayidx81.11, align 2, !dbg !61, !tbaa !62
  %v.sroa.12.22.vec.insert = insertelement <4 x half> %v.sroa.12.20.vec.insert, half %20, i64 3, !dbg !61
  %add76.12 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.12 = or disjoint i32 %add76.12, 48, !dbg !59
  %idxprom80.12 = zext nneg i32 %add79.12 to i64, !dbg !60
  %arrayidx81.12 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.12, !dbg !60
  %21 = load half, ptr addrspace(4) %arrayidx81.12, align 2, !dbg !61, !tbaa !62
  %v.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %21, i64 0, !dbg !61
  %add76.13 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.13 = or disjoint i32 %add76.13, 112, !dbg !59
  %idxprom80.13 = zext nneg i32 %add79.13 to i64, !dbg !60
  %arrayidx81.13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.13, !dbg !60
  %22 = load half, ptr addrspace(4) %arrayidx81.13, align 2, !dbg !61, !tbaa !62
  %v.sroa.17.26.vec.insert = insertelement <4 x half> %v.sroa.17.24.vec.insert, half %22, i64 1, !dbg !61
  %add76.14 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.14 = or disjoint i32 %add76.14, 176, !dbg !59
  %idxprom80.14 = zext nneg i32 %add79.14 to i64, !dbg !60
  %arrayidx81.14 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.14, !dbg !60
  %23 = load half, ptr addrspace(4) %arrayidx81.14, align 2, !dbg !61, !tbaa !62
  %v.sroa.17.28.vec.insert = insertelement <4 x half> %v.sroa.17.26.vec.insert, half %23, i64 2, !dbg !61
  %add76.15 = or disjoint i32 %add70, %and78, !dbg !59
  %add79.15 = or disjoint i32 %add76.15, 240, !dbg !59
  %idxprom80.15 = zext nneg i32 %add79.15 to i64, !dbg !60
  %arrayidx81.15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom80.15, !dbg !60
  %24 = load half, ptr addrspace(4) %arrayidx81.15, align 2, !dbg !61, !tbaa !62
  %v.sroa.17.30.vec.insert = insertelement <4 x half> %v.sroa.17.28.vec.insert, half %24, i64 3, !dbg !61
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !63, !call_argsrelate !64
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %25), !dbg !63, !call_argsrelate !64
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.5.16.copyload, <4 x float> %26), !dbg !63, !call_argsrelate !64
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.7.16.copyload, <4 x float> %27), !dbg !63, !call_argsrelate !64
  %mul124 = shl nuw nsw i32 %5, 4
  %29 = lshr i32 %1, 2
  %mul127 = and i32 %29, 252
  %add128 = add nuw nsw i32 %mul124, %mul127
  %cmp131.not = icmp ugt i32 %add128, %0, !dbg !65
  %. = select i1 %cmp131.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0, !dbg !66
  %mul135 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !67
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul135, float 0x4024CB5EC0000000), !dbg !68
  %31 = tail call contract noundef float @llvm.exp.f32(float %30), !dbg !72
  %mul138 = fmul contract float %., %31, !dbg !75
  %cmp131.not.1.not = icmp ult i32 %add128, %0, !dbg !65
  %..1 = select i1 %cmp131.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1, !dbg !66
  %mul135.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !67
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul135.1, float 0x4024CB5EC0000000), !dbg !68
  %33 = tail call contract noundef float @llvm.exp.f32(float %32), !dbg !72
  %mul138.1 = fmul contract float %..1, %33, !dbg !75
  %add129.2 = or disjoint i32 %add128, 2, !dbg !76
  %cmp131.not.2 = icmp ugt i32 %add129.2, %0, !dbg !65
  %..2 = select i1 %cmp131.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2, !dbg !66
  %mul135.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !67
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul135.2, float 0x4024CB5EC0000000), !dbg !68
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !72
  %mul138.2 = fmul contract float %..2, %35, !dbg !75
  %add129.3 = or disjoint i32 %add128, 3, !dbg !76
  %cmp131.not.3 = icmp ugt i32 %add129.3, %0, !dbg !65
  %..3 = select i1 %cmp131.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3, !dbg !66
  %mul135.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !67
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul135.3, float 0x4024CB5EC0000000), !dbg !68
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !72
  %mul138.3 = fmul contract float %..3, %37, !dbg !75
  %add152 = fadd contract float %mul138, 0.000000e+00, !dbg !77
  %add152.1 = fadd contract float %add152, %mul138.1, !dbg !77
  %add152.2 = fadd contract float %add152.1, %mul138.2, !dbg !77
  %add152.3 = fadd contract float %add152.2, %mul138.3, !dbg !77
  %38 = bitcast float %add152.3 to i32, !dbg !78
  %39 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !81
  %40 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %39) #10, !dbg !86
  %xor.i.i = xor i32 %40, 32, !dbg !87
  %41 = and i32 %40, -64, !dbg !88
  %and.i.i = add nsw i32 %41, 64, !dbg !88
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !89
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %40, !dbg !90
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !91
  %42 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %38), !dbg !92
  %43 = bitcast i32 %42 to float, !dbg !93
  %add160 = fadd contract float %add152.3, %43, !dbg !94
  %44 = bitcast float %add160 to i32, !dbg !95
  %45 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !97
  %46 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %45) #10, !dbg !100
  %xor.i.i327 = xor i32 %46, 16, !dbg !101
  %47 = and i32 %46, -64, !dbg !102
  %and.i.i328 = add nsw i32 %47, 64, !dbg !102
  %cmp.not.i.i329 = icmp slt i32 %xor.i.i327, %and.i.i328, !dbg !103
  %cond.i.i330 = select i1 %cmp.not.i.i329, i32 %xor.i.i327, i32 %46, !dbg !104
  %shl.i.i331 = shl i32 %cond.i.i330, 2, !dbg !105
  %48 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i331, i32 %44), !dbg !106
  %49 = bitcast i32 %48 to float, !dbg !107
  %add165 = fadd contract float %add160, %49, !dbg !108
  %cmp168 = fcmp contract ogt float %add165, 0.000000e+00, !dbg !109
  %div = fdiv contract float 1.000000e+00, %add165, !dbg !110
  %condval_1.0 = select i1 %cmp168, float %div, float 0.000000e+00, !dbg !110
  %mul181 = fmul contract float %condval_1.0, %mul138, !dbg !111
  %mul181.1 = fmul contract float %condval_1.0, %mul138.1, !dbg !111
  %mul181.2 = fmul contract float %condval_1.0, %mul138.2, !dbg !111
  %mul181.3 = fmul contract float %condval_1.0, %mul138.3, !dbg !111
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181), !dbg !112
  %51 = insertelement <4 x i16> poison, i16 %50, i64 0, !dbg !121
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181.1), !dbg !112
  %53 = insertelement <4 x i16> %51, i16 %52, i64 1, !dbg !121
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181.2), !dbg !112
  %55 = insertelement <4 x i16> %53, i16 %54, i64 2, !dbg !121
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul181.3), !dbg !112
  %57 = insertelement <4 x i16> %55, i16 %56, i64 3, !dbg !121
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %57 to <4 x half>, !dbg !121
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !122
  br label %if.end217, !dbg !123

if.end217:                                        ; preds = %entry.if.end217_crit_edge, %for.cond36.preheader
  %mul259.pre-phi = phi i32 [ %.pre441, %entry.if.end217_crit_edge ], [ %mul127, %for.cond36.preheader ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %58, %for.cond36.preheader ], !dbg !124
  %out.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %59, %for.cond36.preheader ], !dbg !124
  %out.sroa.22.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %60, %for.cond36.preheader ], !dbg !124
  %out.sroa.32.0 = phi <4 x float> [ zeroinitializer, %entry.if.end217_crit_edge ], [ %61, %for.cond36.preheader ], !dbg !124
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0, !dbg !125
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !126
  %result.sroa.0.0.insert.ext = zext i16 %62 to i64, !dbg !130
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1, !dbg !125
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !126
  %result.sroa.0.2.insert.ext = zext i16 %63 to i64, !dbg !130
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !130
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !130
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2, !dbg !125
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !126
  %result.sroa.0.4.insert.ext = zext i16 %64 to i64, !dbg !130
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !130
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !130
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3, !dbg !125
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !126
  %result.sroa.0.6.insert.ext = zext i16 %65 to i64, !dbg !130
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !130
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !130
  %out.sroa.12.16.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 0, !dbg !125
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.16.vec.extract), !dbg !126
  %result.sroa.7.8.insert.ext = zext i16 %66 to i64, !dbg !130
  %out.sroa.12.20.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 1, !dbg !125
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.20.vec.extract), !dbg !126
  %result.sroa.7.10.insert.ext = zext i16 %67 to i64, !dbg !130
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !130
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !130
  %out.sroa.12.24.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 2, !dbg !125
  %68 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.24.vec.extract), !dbg !126
  %result.sroa.7.12.insert.ext = zext i16 %68 to i64, !dbg !130
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !130
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !130
  %out.sroa.12.28.vec.extract = extractelement <4 x float> %out.sroa.12.0, i64 3, !dbg !125
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.12.28.vec.extract), !dbg !126
  %result.sroa.7.14.insert.ext = zext i16 %69 to i64, !dbg !130
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !130
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !130
  %out.sroa.22.32.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 0, !dbg !125
  %70 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.32.vec.extract), !dbg !126
  %result.sroa.12.16.insert.ext = zext i16 %70 to i64, !dbg !130
  %out.sroa.22.36.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 1, !dbg !125
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.36.vec.extract), !dbg !126
  %result.sroa.12.18.insert.ext = zext i16 %71 to i64, !dbg !130
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16, !dbg !130
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext, !dbg !130
  %out.sroa.22.40.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 2, !dbg !125
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.40.vec.extract), !dbg !126
  %result.sroa.12.20.insert.ext = zext i16 %72 to i64, !dbg !130
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32, !dbg !130
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift, !dbg !130
  %out.sroa.22.44.vec.extract = extractelement <4 x float> %out.sroa.22.0, i64 3, !dbg !125
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.22.44.vec.extract), !dbg !126
  %result.sroa.12.22.insert.ext = zext i16 %73 to i64, !dbg !130
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48, !dbg !130
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift, !dbg !130
  %out.sroa.32.48.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 0, !dbg !125
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.48.vec.extract), !dbg !126
  %result.sroa.17.24.insert.ext = zext i16 %74 to i64, !dbg !130
  %out.sroa.32.52.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 1, !dbg !125
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.52.vec.extract), !dbg !126
  %result.sroa.17.26.insert.ext = zext i16 %75 to i64, !dbg !130
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16, !dbg !130
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext, !dbg !130
  %out.sroa.32.56.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 2, !dbg !125
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.56.vec.extract), !dbg !126
  %result.sroa.17.28.insert.ext = zext i16 %76 to i64, !dbg !130
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32, !dbg !130
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift, !dbg !130
  %out.sroa.32.60.vec.extract = extractelement <4 x float> %out.sroa.32.0, i64 3, !dbg !125
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.32.60.vec.extract), !dbg !126
  %result.sroa.17.30.insert.ext = zext i16 %77 to i64, !dbg !130
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48, !dbg !130
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift, !dbg !130
  %add256 = add nuw nsw i32 %add, %mul259.pre-phi
  %78 = zext nneg i32 %add256 to i64, !dbg !131
  %add.ptr262 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78, !dbg !132
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr262, align 8, !dbg !133
  %79 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78, !dbg !132
  %add.ptr262.1 = getelementptr inbounds i8, ptr addrspace(1) %79, i64 32, !dbg !132
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr262.1, align 8, !dbg !133
  %80 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78, !dbg !132
  %add.ptr262.2 = getelementptr inbounds i8, ptr addrspace(1) %80, i64 64, !dbg !132
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr262.2, align 8, !dbg !133
  %81 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %78, !dbg !132
  %add.ptr262.3 = getelementptr inbounds i8, ptr addrspace(1) %81, i64 96, !dbg !132
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr262.3, align 8, !dbg !133
  ret void, !dbg !134
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

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

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

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
attributes #10 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpshsk2msh/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpshsk2msh/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 20, column: 3, scope: !40)
!44 = !DILocation(line: 21, column: 42, scope: !40)
!45 = !DILocation(line: 21, column: 28, scope: !40)
!46 = !DILocation(line: 68, column: 3, scope: !47, inlinedAt: !49)
!47 = distinct !DISubprogram(name: "__barrier_warp", scope: !48, file: !48, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!48 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!49 = distinct !DILocation(line: 192, column: 3, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "__syncwarp", scope: !48, file: !48, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 23, column: 3, scope: !40)
!52 = !DILocation(line: 69, column: 3, scope: !47, inlinedAt: !49)
!53 = !DILocation(line: 70, column: 3, scope: !47, inlinedAt: !49)
!54 = !DILocation(line: 24, column: 15, scope: !40)
!55 = !DILocation(line: 30, column: 21, scope: !40)
!56 = !DILocation(line: 32, column: 5, scope: !40)
!57 = !DILocation(line: 33, column: 53, scope: !40)
!58 = !DILocation(line: 33, column: 32, scope: !40)
!59 = !DILocation(line: 37, column: 122, scope: !40)
!60 = !DILocation(line: 37, column: 16, scope: !40)
!61 = !DILocation(line: 37, column: 14, scope: !40)
!62 = !{!26, !26, i64 0}
!63 = !DILocation(line: 44, column: 37, scope: !40)
!64 = !{i32 1, i32 3, i32 -1}
!65 = !DILocation(line: 53, column: 69, scope: !40)
!66 = !DILocation(line: 58, column: 32, scope: !40)
!67 = !DILocation(line: 58, column: 44, scope: !40)
!68 = !DILocation(line: 354, column: 10, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "min", scope: !70, file: !70, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!70 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!71 = distinct !DILocation(line: 58, column: 27, scope: !40)
!72 = !DILocation(line: 288, column: 10, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "expf", scope: !70, file: !70, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!74 = distinct !DILocation(line: 58, column: 22, scope: !40)
!75 = !DILocation(line: 58, column: 125, scope: !40)
!76 = !DILocation(line: 53, column: 62, scope: !40)
!77 = !DILocation(line: 63, column: 34, scope: !40)
!78 = !DILocation(line: 1018, column: 9, scope: !79, inlinedAt: !80)
!79 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !48, file: !48, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!80 = distinct !DILocation(line: 65, column: 34, scope: !40)
!81 = !DILocation(line: 171, column: 37, scope: !82, inlinedAt: !83)
!82 = distinct !DISubprogram(name: "__lane_id", scope: !48, file: !48, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!83 = distinct !DILocation(line: 990, column: 14, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !48, file: !48, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!85 = distinct !DILocation(line: 1019, column: 11, scope: !79, inlinedAt: !80)
!86 = !DILocation(line: 171, column: 10, scope: !82, inlinedAt: !83)
!87 = !DILocation(line: 991, column: 20, scope: !84, inlinedAt: !85)
!88 = !DILocation(line: 992, column: 36, scope: !84, inlinedAt: !85)
!89 = !DILocation(line: 992, column: 17, scope: !84, inlinedAt: !85)
!90 = !DILocation(line: 992, column: 11, scope: !84, inlinedAt: !85)
!91 = !DILocation(line: 993, column: 43, scope: !84, inlinedAt: !85)
!92 = !DILocation(line: 993, column: 10, scope: !84, inlinedAt: !85)
!93 = !DILocation(line: 1020, column: 14, scope: !79, inlinedAt: !80)
!94 = !DILocation(line: 65, column: 32, scope: !40)
!95 = !DILocation(line: 1018, column: 9, scope: !79, inlinedAt: !96)
!96 = distinct !DILocation(line: 66, column: 34, scope: !40)
!97 = !DILocation(line: 171, column: 37, scope: !82, inlinedAt: !98)
!98 = distinct !DILocation(line: 990, column: 14, scope: !84, inlinedAt: !99)
!99 = distinct !DILocation(line: 1019, column: 11, scope: !79, inlinedAt: !96)
!100 = !DILocation(line: 171, column: 10, scope: !82, inlinedAt: !98)
!101 = !DILocation(line: 991, column: 20, scope: !84, inlinedAt: !99)
!102 = !DILocation(line: 992, column: 36, scope: !84, inlinedAt: !99)
!103 = !DILocation(line: 992, column: 17, scope: !84, inlinedAt: !99)
!104 = !DILocation(line: 992, column: 11, scope: !84, inlinedAt: !99)
!105 = !DILocation(line: 993, column: 43, scope: !84, inlinedAt: !99)
!106 = !DILocation(line: 993, column: 10, scope: !84, inlinedAt: !99)
!107 = !DILocation(line: 1020, column: 14, scope: !79, inlinedAt: !96)
!108 = !DILocation(line: 66, column: 32, scope: !40)
!109 = !DILocation(line: 68, column: 34, scope: !40)
!110 = !DILocation(line: 68, column: 9, scope: !40)
!111 = !DILocation(line: 76, column: 34, scope: !40)
!112 = !DILocation(line: 75, column: 10, scope: !113, inlinedAt: !115)
!113 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !114, file: !114, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!115 = distinct !DILocation(line: 984, column: 9, scope: !116, inlinedAt: !118)
!116 = distinct !DISubprogram(name: "__float2half", scope: !117, file: !117, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!118 = distinct !DILocation(line: 133, column: 53, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "__half", scope: !117, file: !117, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 80, column: 21, scope: !40)
!121 = !DILocation(line: 80, column: 18, scope: !40)
!122 = !DILocation(line: 84, column: 36, scope: !40)
!123 = !DILocation(line: 91, column: 3, scope: !40)
!124 = !DILocation(line: 0, scope: !40)
!125 = !DILocation(line: 94, column: 49, scope: !40)
!126 = !DILocation(line: 75, column: 10, scope: !113, inlinedAt: !127)
!127 = distinct !DILocation(line: 984, column: 9, scope: !116, inlinedAt: !128)
!128 = distinct !DILocation(line: 133, column: 53, scope: !119, inlinedAt: !129)
!129 = distinct !DILocation(line: 94, column: 41, scope: !40)
!130 = !DILocation(line: 94, column: 38, scope: !40)
!131 = !DILocation(line: 98, column: 3, scope: !40)
!132 = !DILocation(line: 99, column: 22, scope: !40)
!133 = !DILocation(line: 99, column: 140, scope: !40)
!134 = !DILocation(line: 101, column: 1, scope: !40)
