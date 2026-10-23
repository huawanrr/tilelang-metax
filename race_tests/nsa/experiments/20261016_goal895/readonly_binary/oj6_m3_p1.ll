; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj6_m3_p1.bc'
source_filename = "/tmp/tmpuv4rlwlb/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul6 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul6
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul10 = shl nuw nsw i32 %2, 2
  %add8 = add nuw nsw i32 %add, %mul10
  %3 = zext nneg i32 %add8 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %4 = load i64, ptr addrspace(4) %add.ptr, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 512, !dbg !44
  %6 = load i64, ptr addrspace(4) %add.ptr.1, align 8, !dbg !45
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1024, !dbg !44
  %8 = load i64, ptr addrspace(4) %add.ptr.2, align 8, !dbg !45
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 1536, !dbg !44
  %10 = load i64, ptr addrspace(4) %add.ptr.3, align 8, !dbg !45
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.4 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 2048, !dbg !44
  %12 = load i64, ptr addrspace(4) %add.ptr.4, align 8, !dbg !45
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.5 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 2560, !dbg !44
  %14 = load i64, ptr addrspace(4) %add.ptr.5, align 8, !dbg !45
  %15 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.6 = getelementptr inbounds i8, ptr addrspace(4) %15, i64 3072, !dbg !44
  %16 = load i64, ptr addrspace(4) %add.ptr.6, align 8, !dbg !45
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.7 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 3584, !dbg !44
  %18 = load i64, ptr addrspace(4) %add.ptr.7, align 8, !dbg !45
  %mul16 = shl nsw i32 %0, 10, !dbg !46
  %add18 = add nuw nsw i32 %mul16, %1, !dbg !47
  %idxprom = zext nneg i32 %add18 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !48
  %arrayidx.val = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !49, !tbaa !30
  %or.cond = icmp ult i32 %arrayidx.val, 32, !dbg !50
  br i1 %or.cond, label %land.rhs, label %if.else347, !dbg !50

land.rhs:                                         ; preds = %entry
  %mul22 = shl nuw nsw i32 %arrayidx.val, 5, !dbg !51
  %cmp24.not = icmp ugt i32 %mul22, %1, !dbg !52
  br i1 %cmp24.not, label %if.else347, label %for.cond25.preheader, !dbg !53

for.cond25.preheader:                             ; preds = %land.rhs
  %conv = zext nneg i32 %0 to i64
  %mul31 = shl nuw nsw i64 %conv, 18
  %19 = shl nuw nsw i32 %arrayidx.val, 13
  %mul33 = zext nneg i32 %19 to i64
  %20 = shl nuw nsw i32 %2, 3
  %mul40 = zext nneg i32 %20 to i64
  %add34 = or disjoint i64 %mul31, %mul40
  %add37 = or disjoint i64 %add34, %mul33
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add37, !dbg !54
  %22 = load <4 x half>, ptr addrspace(4) %21, align 2, !dbg !55, !tbaa !56
  %add41.4 = or disjoint i64 %add37, 4, !dbg !57
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %add41.4, !dbg !54
  %24 = load <4 x half>, ptr addrspace(4) %23, align 2, !dbg !55, !tbaa !56
  %arrayidx44.8 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 1024, !dbg !54
  %25 = load <4 x half>, ptr addrspace(4) %arrayidx44.8, align 2, !dbg !55, !tbaa !56
  %arrayidx44.12 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1024, !dbg !54
  %26 = load <4 x half>, ptr addrspace(4) %arrayidx44.12, align 2, !dbg !55, !tbaa !56
  %arrayidx44.16 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 2048, !dbg !54
  %27 = load <4 x half>, ptr addrspace(4) %arrayidx44.16, align 2, !dbg !55, !tbaa !56
  %arrayidx44.20 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2048, !dbg !54
  %28 = load <4 x half>, ptr addrspace(4) %arrayidx44.20, align 2, !dbg !55, !tbaa !56
  %arrayidx44.24 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 3072, !dbg !54
  %29 = load <4 x half>, ptr addrspace(4) %arrayidx44.24, align 2, !dbg !55, !tbaa !56
  %arrayidx44.28 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 3072, !dbg !54
  %30 = load <4 x half>, ptr addrspace(4) %arrayidx44.28, align 2, !dbg !55, !tbaa !56
  %arrayidx44.32 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 4096, !dbg !54
  %31 = load <4 x half>, ptr addrspace(4) %arrayidx44.32, align 2, !dbg !55, !tbaa !56
  %arrayidx44.36 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 4096, !dbg !54
  %32 = load <4 x half>, ptr addrspace(4) %arrayidx44.36, align 2, !dbg !55, !tbaa !56
  %arrayidx44.40 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 5120, !dbg !54
  %33 = load <4 x half>, ptr addrspace(4) %arrayidx44.40, align 2, !dbg !55, !tbaa !56
  %arrayidx44.44 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 5120, !dbg !54
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx44.44, align 2, !dbg !55, !tbaa !56
  %arrayidx44.48 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 6144, !dbg !54
  %35 = load <4 x half>, ptr addrspace(4) %arrayidx44.48, align 2, !dbg !55, !tbaa !56
  %arrayidx44.52 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 6144, !dbg !54
  %36 = load <4 x half>, ptr addrspace(4) %arrayidx44.52, align 2, !dbg !55, !tbaa !56
  %arrayidx44.56 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 7168, !dbg !54
  %37 = load <4 x half>, ptr addrspace(4) %arrayidx44.56, align 2, !dbg !55, !tbaa !56
  %arrayidx44.60 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 7168, !dbg !54
  %38 = load <4 x half>, ptr addrspace(4) %arrayidx44.60, align 2, !dbg !55, !tbaa !56
  %and66 = lshr i32 %2, 1
  %shr67 = and i32 %and66, 15
  %shr70 = lshr i32 %2, 5
  %add64 = and i32 %mul10, 3972
  %xor = xor i32 %shr70, %shr67, !dbg !58
  %39 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add64, !dbg !59
  %add.ptr79.idx = shl nuw nsw i32 %xor, 4, !dbg !59
  %add.ptr79 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %add.ptr79.idx, !dbg !59
  store i64 %4, ptr addrspace(3) %add.ptr79, align 8, !dbg !60
  %add71.1 = add nuw nsw i32 %shr70, 2, !dbg !61
  %xor.1 = xor i32 %add71.1, %shr67, !dbg !58
  %40 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 512, !dbg !59
  %add.ptr79.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !59
  %add.ptr79.1 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr79.idx.1, !dbg !59
  store i64 %6, ptr addrspace(3) %add.ptr79.1, align 8, !dbg !60
  %add71.2 = add nuw nsw i32 %shr70, 4, !dbg !61
  %xor.2 = xor i32 %add71.2, %shr67, !dbg !58
  %41 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 1024, !dbg !59
  %add.ptr79.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !59
  %add.ptr79.2 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %add.ptr79.idx.2, !dbg !59
  store i64 %8, ptr addrspace(3) %add.ptr79.2, align 8, !dbg !60
  %add71.3 = add nuw nsw i32 %shr70, 6, !dbg !61
  %xor.3 = xor i32 %add71.3, %shr67, !dbg !58
  %42 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 1536, !dbg !59
  %add.ptr79.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !59
  %add.ptr79.3 = getelementptr inbounds i8, ptr addrspace(3) %42, i32 %add.ptr79.idx.3, !dbg !59
  store i64 %10, ptr addrspace(3) %add.ptr79.3, align 8, !dbg !60
  %add71.4 = add nuw nsw i32 %shr70, 8, !dbg !61
  %xor.4 = xor i32 %add71.4, %shr67, !dbg !58
  %43 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 2048, !dbg !59
  %add.ptr79.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !59
  %add.ptr79.4 = getelementptr inbounds i8, ptr addrspace(3) %43, i32 %add.ptr79.idx.4, !dbg !59
  store i64 %12, ptr addrspace(3) %add.ptr79.4, align 8, !dbg !60
  %add71.5 = add nuw nsw i32 %shr70, 10, !dbg !61
  %xor.5 = xor i32 %add71.5, %shr67, !dbg !58
  %44 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 2560, !dbg !59
  %add.ptr79.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !59
  %add.ptr79.5 = getelementptr inbounds i8, ptr addrspace(3) %44, i32 %add.ptr79.idx.5, !dbg !59
  store i64 %14, ptr addrspace(3) %add.ptr79.5, align 8, !dbg !60
  %add71.6 = add nuw nsw i32 %shr70, 12, !dbg !61
  %xor.6 = xor i32 %add71.6, %shr67, !dbg !58
  %45 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 3072, !dbg !59
  %add.ptr79.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !59
  %add.ptr79.6 = getelementptr inbounds i8, ptr addrspace(3) %45, i32 %add.ptr79.idx.6, !dbg !59
  store i64 %16, ptr addrspace(3) %add.ptr79.6, align 8, !dbg !60
  %add71.7 = add nuw nsw i32 %shr70, 14, !dbg !61
  %xor.7 = xor i32 %add71.7, %shr67, !dbg !58
  %46 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 3584, !dbg !59
  %add.ptr79.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !59
  %add.ptr79.7 = getelementptr inbounds i8, ptr addrspace(3) %46, i32 %add.ptr79.idx.7, !dbg !59
  store i64 %18, ptr addrspace(3) %add.ptr79.7, align 8, !dbg !60
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !68
  fence syncscope("warp") acquire, !dbg !69
  %and89 = shl nuw nsw i32 %2, 7
  %mul90 = and i32 %and89, 1920
  %shr93 = lshr i32 %2, 4
  %and96 = and i32 %2, 15
  %47 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul90
  %xor97 = xor i32 %shr93, %and96, !dbg !70
  %add.ptr101.idx = shl nuw nsw i32 %xor97, 4, !dbg !71
  %add.ptr101 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx, !dbg !71
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101, align 16, !dbg !72
  %q.sroa.4.0.add.ptr101.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101, i32 8, !dbg !72
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.4.0.add.ptr101.sroa_idx, align 8, !dbg !72
  %add94.1 = add nuw nsw i32 %shr93, 4, !dbg !73
  %xor97.1 = xor i32 %add94.1, %and96, !dbg !70
  %add.ptr101.idx.1 = shl nuw nsw i32 %xor97.1, 4, !dbg !71
  %add.ptr101.1 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx.1, !dbg !71
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101.1, align 16, !dbg !72
  %q.sroa.7.16.add.ptr101.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101.1, i32 8, !dbg !72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.7.16.add.ptr101.1.sroa_idx, align 8, !dbg !72
  %add94.2 = add nuw nsw i32 %shr93, 8, !dbg !73
  %xor97.2 = xor i32 %add94.2, %and96, !dbg !70
  %add.ptr101.idx.2 = shl nuw nsw i32 %xor97.2, 4, !dbg !71
  %add.ptr101.2 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx.2, !dbg !71
  %q.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101.2, align 16, !dbg !72
  %q.sroa.10.32.add.ptr101.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101.2, i32 8, !dbg !72
  %q.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.10.32.add.ptr101.2.sroa_idx, align 8, !dbg !72
  %add94.3 = add nuw nsw i32 %shr93, 12, !dbg !73
  %xor97.3 = xor i32 %add94.3, %and96, !dbg !70
  %add.ptr101.idx.3 = shl nuw nsw i32 %xor97.3, 4, !dbg !71
  %add.ptr101.3 = getelementptr inbounds i8, ptr addrspace(3) %47, i32 %add.ptr101.idx.3, !dbg !71
  %q.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr101.3, align 16, !dbg !72
  %q.sroa.13.48.add.ptr101.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr101.3, i32 8, !dbg !72
  %q.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.13.48.add.ptr101.3.sroa_idx, align 8, !dbg !72
  %48 = lshr i32 %2, 2
  %mul122 = and i32 %48, 252
  %add119 = add nuw nsw i32 %mul22, %mul122
  %cmp127.not = icmp ugt i32 %add119, %1, !dbg !74
  %spec.select = select i1 %cmp127.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !76
  %cmp127.not.1.not = icmp ult i32 %add119, %1, !dbg !74
  %spec.select.1 = select i1 %cmp127.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !75
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !76
  %add123.2 = or disjoint i32 %add119, 2, !dbg !77
  %cmp127.not.2 = icmp ugt i32 %add123.2, %1, !dbg !74
  %spec.select.2 = select i1 %cmp127.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !76
  %add123.3 = or disjoint i32 %add119, 3, !dbg !77
  %cmp127.not.3 = icmp ugt i32 %add123.3, %1, !dbg !74
  %spec.select.3 = select i1 %cmp127.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !76
  %add125.4 = add nuw nsw i32 %add119, 16, !dbg !78
  %cmp127.not.4 = icmp ugt i32 %add125.4, %1, !dbg !74
  %spec.select.4 = select i1 %cmp127.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !76
  %add125.5 = add nuw nsw i32 %add119, 17, !dbg !78
  %cmp127.not.5 = icmp ugt i32 %add125.5, %1, !dbg !74
  %spec.select.5 = select i1 %cmp127.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.20.vec.insert = insertelement <4 x float> %scores.sroa.46.16.vec.insert, float %spec.select.5, i64 1, !dbg !76
  %add125.6 = add nuw nsw i32 %add119, 18, !dbg !78
  %cmp127.not.6 = icmp ugt i32 %add125.6, %1, !dbg !74
  %spec.select.6 = select i1 %cmp127.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.24.vec.insert = insertelement <4 x float> %scores.sroa.46.20.vec.insert, float %spec.select.6, i64 2, !dbg !76
  %add125.7 = add nuw nsw i32 %add119, 19, !dbg !78
  %cmp127.not.7 = icmp ugt i32 %add125.7, %1, !dbg !74
  %spec.select.7 = select i1 %cmp127.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !75
  %scores.sroa.46.28.vec.insert = insertelement <4 x float> %scores.sroa.46.24.vec.insert, float %spec.select.7, i64 3, !dbg !76
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %22, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !79, !call_argsrelate !80
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %25, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.46.28.vec.insert), !dbg !79, !call_argsrelate !80
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %24, <4 x half> %q.sroa.4.0.copyload, <4 x float> %49), !dbg !79, !call_argsrelate !80
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %q.sroa.4.0.copyload, <4 x float> %50), !dbg !79, !call_argsrelate !80
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %q.sroa.5.16.copyload, <4 x float> %51), !dbg !79, !call_argsrelate !80
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %q.sroa.5.16.copyload, <4 x float> %52), !dbg !79, !call_argsrelate !80
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %q.sroa.7.16.copyload, <4 x float> %53), !dbg !79, !call_argsrelate !80
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %q.sroa.7.16.copyload, <4 x float> %54), !dbg !79, !call_argsrelate !80
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %q.sroa.8.32.copyload, <4 x float> %55), !dbg !79, !call_argsrelate !80
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %q.sroa.8.32.copyload, <4 x float> %56), !dbg !79, !call_argsrelate !80
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %32, <4 x half> %q.sroa.10.32.copyload, <4 x float> %57), !dbg !79, !call_argsrelate !80
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %q.sroa.10.32.copyload, <4 x float> %58), !dbg !79, !call_argsrelate !80
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %q.sroa.11.48.copyload, <4 x float> %59), !dbg !79, !call_argsrelate !80
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %37, <4 x half> %q.sroa.11.48.copyload, <4 x float> %60), !dbg !79, !call_argsrelate !80
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %q.sroa.13.48.copyload, <4 x float> %61), !dbg !79, !call_argsrelate !80
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %38, <4 x half> %q.sroa.13.48.copyload, <4 x float> %62), !dbg !79, !call_argsrelate !80
  %invariant.gep = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !81
  %65 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add37, !dbg !82
  %66 = load <4 x half>, ptr addrspace(4) %65, align 2, !dbg !83, !tbaa !56
  %67 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep, i64 %add41.4, !dbg !82
  %68 = load <4 x half>, ptr addrspace(4) %67, align 2, !dbg !83, !tbaa !56
  %gep.8 = getelementptr i8, ptr addrspace(4) %65, i64 1024, !dbg !82
  %69 = load <4 x half>, ptr addrspace(4) %gep.8, align 2, !dbg !83, !tbaa !56
  %gep.12 = getelementptr i8, ptr addrspace(4) %67, i64 1024, !dbg !82
  %70 = load <4 x half>, ptr addrspace(4) %gep.12, align 2, !dbg !83, !tbaa !56
  %gep.16 = getelementptr i8, ptr addrspace(4) %65, i64 2048, !dbg !82
  %71 = load <4 x half>, ptr addrspace(4) %gep.16, align 2, !dbg !83, !tbaa !56
  %gep.20 = getelementptr i8, ptr addrspace(4) %67, i64 2048, !dbg !82
  %72 = load <4 x half>, ptr addrspace(4) %gep.20, align 2, !dbg !83, !tbaa !56
  %gep.24 = getelementptr i8, ptr addrspace(4) %65, i64 3072, !dbg !82
  %73 = load <4 x half>, ptr addrspace(4) %gep.24, align 2, !dbg !83, !tbaa !56
  %gep.28 = getelementptr i8, ptr addrspace(4) %67, i64 3072, !dbg !82
  %74 = load <4 x half>, ptr addrspace(4) %gep.28, align 2, !dbg !83, !tbaa !56
  %gep.32 = getelementptr i8, ptr addrspace(4) %65, i64 4096, !dbg !82
  %75 = load <4 x half>, ptr addrspace(4) %gep.32, align 2, !dbg !83, !tbaa !56
  %gep.36 = getelementptr i8, ptr addrspace(4) %67, i64 4096, !dbg !82
  %76 = load <4 x half>, ptr addrspace(4) %gep.36, align 2, !dbg !83, !tbaa !56
  %gep.40 = getelementptr i8, ptr addrspace(4) %65, i64 5120, !dbg !82
  %77 = load <4 x half>, ptr addrspace(4) %gep.40, align 2, !dbg !83, !tbaa !56
  %gep.44 = getelementptr i8, ptr addrspace(4) %67, i64 5120, !dbg !82
  %78 = load <4 x half>, ptr addrspace(4) %gep.44, align 2, !dbg !83, !tbaa !56
  %gep.48 = getelementptr i8, ptr addrspace(4) %65, i64 6144, !dbg !82
  %79 = load <4 x half>, ptr addrspace(4) %gep.48, align 2, !dbg !83, !tbaa !56
  %gep.52 = getelementptr i8, ptr addrspace(4) %67, i64 6144, !dbg !82
  %80 = load <4 x half>, ptr addrspace(4) %gep.52, align 2, !dbg !83, !tbaa !56
  %gep.56 = getelementptr i8, ptr addrspace(4) %65, i64 7168, !dbg !82
  %81 = load <4 x half>, ptr addrspace(4) %gep.56, align 2, !dbg !83, !tbaa !56
  %gep.60 = getelementptr i8, ptr addrspace(4) %67, i64 7168, !dbg !82
  %82 = load <4 x half>, ptr addrspace(4) %gep.60, align 2, !dbg !83, !tbaa !56
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %63, i64 0, !dbg !84
  %mul212 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !85
  %83 = tail call contract noundef float @llvm.minnum.f32(float %mul212, float 1.500000e+01), !dbg !86
  %cmp.i.i = fcmp contract olt float %83, -1.260000e+02, !dbg !90
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532 = fadd contract float %83, %cond.i.i, !dbg !90
  %84 = tail call contract float @llvm.exp2.f32(float %add.i.i532), !dbg !90
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i = fmul contract float %cond2.i.i, %84, !dbg !90
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %63, i64 1, !dbg !84
  %mul212.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !85
  %85 = tail call contract noundef float @llvm.minnum.f32(float %mul212.1, float 1.500000e+01), !dbg !86
  %cmp.i.i.1 = fcmp contract olt float %85, -1.260000e+02, !dbg !90
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532.1 = fadd contract float %85, %cond.i.i.1, !dbg !90
  %86 = tail call contract float @llvm.exp2.f32(float %add.i.i532.1), !dbg !90
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %86, !dbg !90
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %63, i64 2, !dbg !84
  %mul212.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !85
  %87 = tail call contract noundef float @llvm.minnum.f32(float %mul212.2, float 1.500000e+01), !dbg !86
  %cmp.i.i.2 = fcmp contract olt float %87, -1.260000e+02, !dbg !90
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532.2 = fadd contract float %87, %cond.i.i.2, !dbg !90
  %88 = tail call contract float @llvm.exp2.f32(float %add.i.i532.2), !dbg !90
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %88, !dbg !90
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %63, i64 3, !dbg !84
  %mul212.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !85
  %89 = tail call contract noundef float @llvm.minnum.f32(float %mul212.3, float 1.500000e+01), !dbg !86
  %cmp.i.i.3 = fcmp contract olt float %89, -1.260000e+02, !dbg !90
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532.3 = fadd contract float %89, %cond.i.i.3, !dbg !90
  %90 = tail call contract float @llvm.exp2.f32(float %add.i.i532.3), !dbg !90
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %90, !dbg !90
  %scores.sroa.46.16.vec.extract = extractelement <4 x float> %64, i64 0, !dbg !84
  %mul212.4 = fmul contract float %scores.sroa.46.16.vec.extract, 0x3FC2776C60000000, !dbg !85
  %91 = tail call contract noundef float @llvm.minnum.f32(float %mul212.4, float 1.500000e+01), !dbg !86
  %cmp.i.i.4 = fcmp contract olt float %91, -1.260000e+02, !dbg !90
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532.4 = fadd contract float %91, %cond.i.i.4, !dbg !90
  %92 = tail call contract float @llvm.exp2.f32(float %add.i.i532.4), !dbg !90
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %92, !dbg !90
  %scores.sroa.46.20.vec.extract = extractelement <4 x float> %64, i64 1, !dbg !84
  %mul212.5 = fmul contract float %scores.sroa.46.20.vec.extract, 0x3FC2776C60000000, !dbg !85
  %93 = tail call contract noundef float @llvm.minnum.f32(float %mul212.5, float 1.500000e+01), !dbg !86
  %cmp.i.i.5 = fcmp contract olt float %93, -1.260000e+02, !dbg !90
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532.5 = fadd contract float %93, %cond.i.i.5, !dbg !90
  %94 = tail call contract float @llvm.exp2.f32(float %add.i.i532.5), !dbg !90
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %94, !dbg !90
  %scores.sroa.46.24.vec.extract = extractelement <4 x float> %64, i64 2, !dbg !84
  %mul212.6 = fmul contract float %scores.sroa.46.24.vec.extract, 0x3FC2776C60000000, !dbg !85
  %95 = tail call contract noundef float @llvm.minnum.f32(float %mul212.6, float 1.500000e+01), !dbg !86
  %cmp.i.i.6 = fcmp contract olt float %95, -1.260000e+02, !dbg !90
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532.6 = fadd contract float %95, %cond.i.i.6, !dbg !90
  %96 = tail call contract float @llvm.exp2.f32(float %add.i.i532.6), !dbg !90
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %96, !dbg !90
  %scores.sroa.46.28.vec.extract = extractelement <4 x float> %64, i64 3, !dbg !84
  %mul212.7 = fmul contract float %scores.sroa.46.28.vec.extract, 0x3FC2776C60000000, !dbg !85
  %97 = tail call contract noundef float @llvm.minnum.f32(float %mul212.7, float 1.500000e+01), !dbg !86
  %cmp.i.i.7 = fcmp contract olt float %97, -1.260000e+02, !dbg !90
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !90
  %add.i.i532.7 = fadd contract float %97, %cond.i.i.7, !dbg !90
  %98 = tail call contract float @llvm.exp2.f32(float %add.i.i532.7), !dbg !90
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !90
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %98, !dbg !90
  %add232 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !93
  %add232.1 = fadd contract float %add232, %mul.i.i.4, !dbg !93
  %add232.2 = fadd contract float %add232.1, %mul.i.i.1, !dbg !93
  %add232.3 = fadd contract float %add232.2, %mul.i.i.5, !dbg !93
  %add232.4 = fadd contract float %add232.3, %mul.i.i.2, !dbg !93
  %add232.5 = fadd contract float %add232.4, %mul.i.i.6, !dbg !93
  %add232.6 = fadd contract float %add232.5, %mul.i.i.3, !dbg !93
  %add232.7 = fadd contract float %add232.6, %mul.i.i.7, !dbg !93
  %99 = bitcast float %add232.7 to i32, !dbg !94
  %100 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !105
  %101 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %100) #11, !dbg !110
  %xor.i.i = xor i32 %101, 32, !dbg !111
  %102 = and i32 %101, -64, !dbg !112
  %and.i.i = add nsw i32 %102, 64, !dbg !112
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !113
  %cond.i.i533 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %101, !dbg !114
  %shl.i.i = shl i32 %cond.i.i533, 2, !dbg !115
  %103 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %99), !dbg !116
  %104 = bitcast i32 %103 to float, !dbg !117
  %add.i = fadd contract float %add232.7, %104, !dbg !118
  %105 = bitcast float %add.i to i32, !dbg !121
  %106 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !128
  %107 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %106) #11, !dbg !131
  %xor.i.i534 = xor i32 %107, 16, !dbg !132
  %108 = and i32 %107, -64, !dbg !133
  %and.i.i535 = add nsw i32 %108, 64, !dbg !133
  %cmp.not.i.i536 = icmp slt i32 %xor.i.i534, %and.i.i535, !dbg !134
  %cond.i.i537 = select i1 %cmp.not.i.i536, i32 %xor.i.i534, i32 %107, !dbg !135
  %shl.i.i538 = shl i32 %cond.i.i537, 2, !dbg !136
  %109 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i538, i32 %105), !dbg !137
  %110 = bitcast i32 %109 to float, !dbg !138
  %add.i.i = fadd contract float %add.i, %110, !dbg !139
  %cmp241 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !141
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !142
  %condval_1.0 = select i1 %cmp241, float %div, float 0.000000e+00, !dbg !142
  %mul254 = fmul contract float %condval_1.0, %mul.i.i, !dbg !143
  %mul254.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !143
  %mul254.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !143
  %mul254.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !143
  %mul254.4 = fmul contract float %condval_1.0, %mul.i.i.4, !dbg !143
  %mul254.5 = fmul contract float %condval_1.0, %mul.i.i.5, !dbg !143
  %mul254.6 = fmul contract float %condval_1.0, %mul.i.i.6, !dbg !143
  %mul254.7 = fmul contract float %condval_1.0, %mul.i.i.7, !dbg !143
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254), !dbg !144
  %112 = insertelement <4 x i16> poison, i16 %111, i64 0, !dbg !153
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.1), !dbg !144
  %114 = insertelement <4 x i16> %112, i16 %113, i64 1, !dbg !153
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.2), !dbg !144
  %116 = insertelement <4 x i16> %114, i16 %115, i64 2, !dbg !153
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.3), !dbg !144
  %118 = insertelement <4 x i16> %116, i16 %117, i64 3, !dbg !153
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %118 to <4 x half>, !dbg !153
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.4), !dbg !144
  %120 = insertelement <4 x i16> poison, i16 %119, i64 0, !dbg !153
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.5), !dbg !144
  %122 = insertelement <4 x i16> %120, i16 %121, i64 1, !dbg !153
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.6), !dbg !144
  %124 = insertelement <4 x i16> %122, i16 %123, i64 2, !dbg !153
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul254.7), !dbg !144
  %126 = insertelement <4 x i16> %124, i16 %125, i64 3, !dbg !153
  %prob.sroa.7.14.vec.insert = bitcast <4 x i16> %126 to <4 x half>, !dbg !153
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %70, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %71, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %72, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !154, !call_argsrelate !80
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %127), !dbg !154, !call_argsrelate !80
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %128), !dbg !154, !call_argsrelate !80
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %77, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %129), !dbg !154, !call_argsrelate !80
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %78, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %130), !dbg !154, !call_argsrelate !80
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %79, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %131), !dbg !154, !call_argsrelate !80
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %132), !dbg !154, !call_argsrelate !80
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %81, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %133), !dbg !154, !call_argsrelate !80
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %82, <4 x half> %prob.sroa.7.14.vec.insert, <4 x float> %134), !dbg !154, !call_argsrelate !80
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %135, i64 0, !dbg !155
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !156
  %output_reg.sroa.0.0.insert.ext = zext i16 %143 to i64, !dbg !160
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %135, i64 1, !dbg !155
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !156
  %output_reg.sroa.0.2.insert.ext = zext i16 %144 to i64, !dbg !160
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !160
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !160
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %135, i64 2, !dbg !155
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !156
  %output_reg.sroa.0.4.insert.ext = zext i16 %145 to i64, !dbg !160
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !160
  %output_reg.sroa.0.4.insert.insert651 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !160
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %135, i64 3, !dbg !155
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !156
  %output_reg.sroa.0.6.insert.ext = zext i16 %146 to i64, !dbg !160
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !160
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert651, %output_reg.sroa.0.6.insert.shift, !dbg !160
  %out.sroa.14.16.vec.extract = extractelement <4 x float> %136, i64 0, !dbg !155
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.16.vec.extract), !dbg !156
  %output_reg.sroa.9.8.insert.ext = zext i16 %147 to i64, !dbg !160
  %out.sroa.14.20.vec.extract = extractelement <4 x float> %136, i64 1, !dbg !155
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.20.vec.extract), !dbg !156
  %output_reg.sroa.9.10.insert.ext = zext i16 %148 to i64, !dbg !160
  %output_reg.sroa.9.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.10.insert.ext, 16, !dbg !160
  %output_reg.sroa.9.10.insert.insert = or disjoint i64 %output_reg.sroa.9.10.insert.shift, %output_reg.sroa.9.8.insert.ext, !dbg !160
  %out.sroa.14.24.vec.extract = extractelement <4 x float> %136, i64 2, !dbg !155
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.24.vec.extract), !dbg !156
  %output_reg.sroa.9.12.insert.ext = zext i16 %149 to i64, !dbg !160
  %output_reg.sroa.9.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.9.12.insert.ext, 32, !dbg !160
  %output_reg.sroa.9.12.insert.insert657 = or disjoint i64 %output_reg.sroa.9.10.insert.insert, %output_reg.sroa.9.12.insert.shift, !dbg !160
  %out.sroa.14.28.vec.extract = extractelement <4 x float> %136, i64 3, !dbg !155
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.14.28.vec.extract), !dbg !156
  %output_reg.sroa.9.14.insert.ext = zext i16 %150 to i64, !dbg !160
  %output_reg.sroa.9.14.insert.shift = shl nuw i64 %output_reg.sroa.9.14.insert.ext, 48, !dbg !160
  %output_reg.sroa.9.14.insert.insert = or disjoint i64 %output_reg.sroa.9.12.insert.insert657, %output_reg.sroa.9.14.insert.shift, !dbg !160
  %out.sroa.26.32.vec.extract = extractelement <4 x float> %137, i64 0, !dbg !155
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.32.vec.extract), !dbg !156
  %output_reg.sroa.16.16.insert.ext = zext i16 %151 to i64, !dbg !160
  %out.sroa.26.36.vec.extract = extractelement <4 x float> %137, i64 1, !dbg !155
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.36.vec.extract), !dbg !156
  %output_reg.sroa.16.18.insert.ext = zext i16 %152 to i64, !dbg !160
  %output_reg.sroa.16.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.18.insert.ext, 16, !dbg !160
  %output_reg.sroa.16.18.insert.insert = or disjoint i64 %output_reg.sroa.16.18.insert.shift, %output_reg.sroa.16.16.insert.ext, !dbg !160
  %out.sroa.26.40.vec.extract = extractelement <4 x float> %137, i64 2, !dbg !155
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.40.vec.extract), !dbg !156
  %output_reg.sroa.16.20.insert.ext = zext i16 %153 to i64, !dbg !160
  %output_reg.sroa.16.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.20.insert.ext, 32, !dbg !160
  %output_reg.sroa.16.20.insert.insert663 = or disjoint i64 %output_reg.sroa.16.18.insert.insert, %output_reg.sroa.16.20.insert.shift, !dbg !160
  %out.sroa.26.44.vec.extract = extractelement <4 x float> %137, i64 3, !dbg !155
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.44.vec.extract), !dbg !156
  %output_reg.sroa.16.22.insert.ext = zext i16 %154 to i64, !dbg !160
  %output_reg.sroa.16.22.insert.shift = shl nuw i64 %output_reg.sroa.16.22.insert.ext, 48, !dbg !160
  %output_reg.sroa.16.22.insert.insert = or disjoint i64 %output_reg.sroa.16.20.insert.insert663, %output_reg.sroa.16.22.insert.shift, !dbg !160
  %out.sroa.38.48.vec.extract = extractelement <4 x float> %138, i64 0, !dbg !155
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.48.vec.extract), !dbg !156
  %output_reg.sroa.23.24.insert.ext = zext i16 %155 to i64, !dbg !160
  %out.sroa.38.52.vec.extract = extractelement <4 x float> %138, i64 1, !dbg !155
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.52.vec.extract), !dbg !156
  %output_reg.sroa.23.26.insert.ext = zext i16 %156 to i64, !dbg !160
  %output_reg.sroa.23.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.26.insert.ext, 16, !dbg !160
  %output_reg.sroa.23.26.insert.insert = or disjoint i64 %output_reg.sroa.23.26.insert.shift, %output_reg.sroa.23.24.insert.ext, !dbg !160
  %out.sroa.38.56.vec.extract = extractelement <4 x float> %138, i64 2, !dbg !155
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.56.vec.extract), !dbg !156
  %output_reg.sroa.23.28.insert.ext = zext i16 %157 to i64, !dbg !160
  %output_reg.sroa.23.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.23.28.insert.ext, 32, !dbg !160
  %output_reg.sroa.23.28.insert.insert669 = or disjoint i64 %output_reg.sroa.23.26.insert.insert, %output_reg.sroa.23.28.insert.shift, !dbg !160
  %out.sroa.38.60.vec.extract = extractelement <4 x float> %138, i64 3, !dbg !155
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.38.60.vec.extract), !dbg !156
  %output_reg.sroa.23.30.insert.ext = zext i16 %158 to i64, !dbg !160
  %output_reg.sroa.23.30.insert.shift = shl nuw i64 %output_reg.sroa.23.30.insert.ext, 48, !dbg !160
  %output_reg.sroa.23.30.insert.insert = or disjoint i64 %output_reg.sroa.23.28.insert.insert669, %output_reg.sroa.23.30.insert.shift, !dbg !160
  %out.sroa.50.64.vec.extract = extractelement <4 x float> %139, i64 0, !dbg !155
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.64.vec.extract), !dbg !156
  %output_reg.sroa.30.32.insert.ext = zext i16 %159 to i64, !dbg !160
  %out.sroa.50.68.vec.extract = extractelement <4 x float> %139, i64 1, !dbg !155
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.68.vec.extract), !dbg !156
  %output_reg.sroa.30.34.insert.ext = zext i16 %160 to i64, !dbg !160
  %output_reg.sroa.30.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.34.insert.ext, 16, !dbg !160
  %output_reg.sroa.30.34.insert.insert = or disjoint i64 %output_reg.sroa.30.34.insert.shift, %output_reg.sroa.30.32.insert.ext, !dbg !160
  %out.sroa.50.72.vec.extract = extractelement <4 x float> %139, i64 2, !dbg !155
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.72.vec.extract), !dbg !156
  %output_reg.sroa.30.36.insert.ext = zext i16 %161 to i64, !dbg !160
  %output_reg.sroa.30.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.36.insert.ext, 32, !dbg !160
  %output_reg.sroa.30.36.insert.insert675 = or disjoint i64 %output_reg.sroa.30.34.insert.insert, %output_reg.sroa.30.36.insert.shift, !dbg !160
  %out.sroa.50.76.vec.extract = extractelement <4 x float> %139, i64 3, !dbg !155
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.76.vec.extract), !dbg !156
  %output_reg.sroa.30.38.insert.ext = zext i16 %162 to i64, !dbg !160
  %output_reg.sroa.30.38.insert.shift = shl nuw i64 %output_reg.sroa.30.38.insert.ext, 48, !dbg !160
  %output_reg.sroa.30.38.insert.insert = or disjoint i64 %output_reg.sroa.30.36.insert.insert675, %output_reg.sroa.30.38.insert.shift, !dbg !160
  %out.sroa.62.80.vec.extract = extractelement <4 x float> %140, i64 0, !dbg !155
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.80.vec.extract), !dbg !156
  %output_reg.sroa.37.40.insert.ext = zext i16 %163 to i64, !dbg !160
  %out.sroa.62.84.vec.extract = extractelement <4 x float> %140, i64 1, !dbg !155
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.84.vec.extract), !dbg !156
  %output_reg.sroa.37.42.insert.ext = zext i16 %164 to i64, !dbg !160
  %output_reg.sroa.37.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.42.insert.ext, 16, !dbg !160
  %output_reg.sroa.37.42.insert.insert = or disjoint i64 %output_reg.sroa.37.42.insert.shift, %output_reg.sroa.37.40.insert.ext, !dbg !160
  %out.sroa.62.88.vec.extract = extractelement <4 x float> %140, i64 2, !dbg !155
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.88.vec.extract), !dbg !156
  %output_reg.sroa.37.44.insert.ext = zext i16 %165 to i64, !dbg !160
  %output_reg.sroa.37.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.37.44.insert.ext, 32, !dbg !160
  %output_reg.sroa.37.44.insert.insert681 = or disjoint i64 %output_reg.sroa.37.42.insert.insert, %output_reg.sroa.37.44.insert.shift, !dbg !160
  %out.sroa.62.92.vec.extract = extractelement <4 x float> %140, i64 3, !dbg !155
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.62.92.vec.extract), !dbg !156
  %output_reg.sroa.37.46.insert.ext = zext i16 %166 to i64, !dbg !160
  %output_reg.sroa.37.46.insert.shift = shl nuw i64 %output_reg.sroa.37.46.insert.ext, 48, !dbg !160
  %output_reg.sroa.37.46.insert.insert = or disjoint i64 %output_reg.sroa.37.44.insert.insert681, %output_reg.sroa.37.46.insert.shift, !dbg !160
  %out.sroa.74.96.vec.extract = extractelement <4 x float> %141, i64 0, !dbg !155
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.96.vec.extract), !dbg !156
  %output_reg.sroa.44.48.insert.ext = zext i16 %167 to i64, !dbg !160
  %out.sroa.74.100.vec.extract = extractelement <4 x float> %141, i64 1, !dbg !155
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.100.vec.extract), !dbg !156
  %output_reg.sroa.44.50.insert.ext = zext i16 %168 to i64, !dbg !160
  %output_reg.sroa.44.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.50.insert.ext, 16, !dbg !160
  %output_reg.sroa.44.50.insert.insert = or disjoint i64 %output_reg.sroa.44.50.insert.shift, %output_reg.sroa.44.48.insert.ext, !dbg !160
  %out.sroa.74.104.vec.extract = extractelement <4 x float> %141, i64 2, !dbg !155
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.104.vec.extract), !dbg !156
  %output_reg.sroa.44.52.insert.ext = zext i16 %169 to i64, !dbg !160
  %output_reg.sroa.44.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.52.insert.ext, 32, !dbg !160
  %output_reg.sroa.44.52.insert.insert687 = or disjoint i64 %output_reg.sroa.44.50.insert.insert, %output_reg.sroa.44.52.insert.shift, !dbg !160
  %out.sroa.74.108.vec.extract = extractelement <4 x float> %141, i64 3, !dbg !155
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.108.vec.extract), !dbg !156
  %output_reg.sroa.44.54.insert.ext = zext i16 %170 to i64, !dbg !160
  %output_reg.sroa.44.54.insert.shift = shl nuw i64 %output_reg.sroa.44.54.insert.ext, 48, !dbg !160
  %output_reg.sroa.44.54.insert.insert = or disjoint i64 %output_reg.sroa.44.52.insert.insert687, %output_reg.sroa.44.54.insert.shift, !dbg !160
  %out.sroa.86.112.vec.extract = extractelement <4 x float> %142, i64 0, !dbg !155
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.112.vec.extract), !dbg !156
  %output_reg.sroa.51.56.insert.ext = zext i16 %171 to i64, !dbg !160
  %out.sroa.86.116.vec.extract = extractelement <4 x float> %142, i64 1, !dbg !155
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.116.vec.extract), !dbg !156
  %output_reg.sroa.51.58.insert.ext = zext i16 %172 to i64, !dbg !160
  %output_reg.sroa.51.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.58.insert.ext, 16, !dbg !160
  %output_reg.sroa.51.58.insert.insert = or disjoint i64 %output_reg.sroa.51.58.insert.shift, %output_reg.sroa.51.56.insert.ext, !dbg !160
  %out.sroa.86.120.vec.extract = extractelement <4 x float> %142, i64 2, !dbg !155
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.120.vec.extract), !dbg !156
  %output_reg.sroa.51.60.insert.ext = zext i16 %173 to i64, !dbg !160
  %output_reg.sroa.51.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.51.60.insert.ext, 32, !dbg !160
  %output_reg.sroa.51.60.insert.insert693 = or disjoint i64 %output_reg.sroa.51.58.insert.insert, %output_reg.sroa.51.60.insert.shift, !dbg !160
  %out.sroa.86.124.vec.extract = extractelement <4 x float> %142, i64 3, !dbg !155
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.86.124.vec.extract), !dbg !156
  %output_reg.sroa.51.62.insert.ext = zext i16 %174 to i64, !dbg !160
  %output_reg.sroa.51.62.insert.shift = shl nuw i64 %output_reg.sroa.51.62.insert.ext, 48, !dbg !160
  %output_reg.sroa.51.62.insert.insert = or disjoint i64 %output_reg.sroa.51.60.insert.insert693, %output_reg.sroa.51.62.insert.shift, !dbg !160
  br label %if.end370, !dbg !161

if.else347:                                       ; preds = %entry, %land.rhs
  %.pre = shl nuw nsw i32 %2, 7
  %.pre832 = and i32 %.pre, 1920
  %.pre833 = lshr i32 %2, 5
  %.pre834 = and i32 %2, 15
  %.pre835 = lshr i32 %2, 2
  %.pre836 = add nuw nsw i32 %.pre833, 2, !dbg !164
  %.pre837 = add nuw nsw i32 %.pre833, 4, !dbg !164
  %.pre838 = add nuw nsw i32 %.pre833, 6, !dbg !164
  %.pre839 = add nuw nsw i32 %.pre833, 8, !dbg !164
  %.pre840 = add nuw nsw i32 %.pre833, 10, !dbg !164
  %.pre841 = add nuw nsw i32 %.pre833, 12, !dbg !164
  %.pre842 = add nuw nsw i32 %.pre833, 14, !dbg !164
  %.pre843 = shl nuw nsw i32 %2, 3
  %.pre845 = lshr i32 %2, 4
  %.pre846 = xor i32 %.pre845, %.pre834, !dbg !165
  %.pre847 = shl nuw nsw i32 %.pre846, 4, !dbg !166
  br label %if.end370, !dbg !161

if.end370:                                        ; preds = %for.cond25.preheader, %if.else347
  %add.ptr420.idx.pre-phi = phi i32 [ %add.ptr101.idx, %for.cond25.preheader ], [ %.pre847, %if.else347 ], !dbg !166
  %shr414.pre-phi = phi i32 [ %shr93, %for.cond25.preheader ], [ %.pre845, %if.else347 ]
  %.pre-phi844 = phi i32 [ %20, %for.cond25.preheader ], [ %.pre843, %if.else347 ]
  %add385.7.pre-phi = phi i32 [ %add71.7, %for.cond25.preheader ], [ %.pre842, %if.else347 ], !dbg !164
  %add385.6.pre-phi = phi i32 [ %add71.6, %for.cond25.preheader ], [ %.pre841, %if.else347 ], !dbg !164
  %add385.5.pre-phi = phi i32 [ %add71.5, %for.cond25.preheader ], [ %.pre840, %if.else347 ], !dbg !164
  %add385.4.pre-phi = phi i32 [ %add71.4, %for.cond25.preheader ], [ %.pre839, %if.else347 ], !dbg !164
  %add385.3.pre-phi = phi i32 [ %add71.3, %for.cond25.preheader ], [ %.pre838, %if.else347 ], !dbg !164
  %add385.2.pre-phi = phi i32 [ %add71.2, %for.cond25.preheader ], [ %.pre837, %if.else347 ], !dbg !164
  %add385.1.pre-phi = phi i32 [ %add71.1, %for.cond25.preheader ], [ %.pre836, %if.else347 ], !dbg !164
  %.pre-phi = phi i32 [ %48, %for.cond25.preheader ], [ %.pre835, %if.else347 ]
  %and387.pre-phi = phi i32 [ %and96, %for.cond25.preheader ], [ %.pre834, %if.else347 ]
  %shr384.pre-phi = phi i32 [ %shr70, %for.cond25.preheader ], [ %.pre833, %if.else347 ]
  %mul381.pre-phi = phi i32 [ %mul90, %for.cond25.preheader ], [ %.pre832, %if.else347 ]
  %output_reg.sroa.51.0 = phi i64 [ %output_reg.sroa.51.62.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.54.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  %output_reg.sroa.37.0 = phi i64 [ %output_reg.sroa.37.46.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.38.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  %output_reg.sroa.23.0 = phi i64 [ %output_reg.sroa.23.30.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.22.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  %output_reg.sroa.9.0 = phi i64 [ %output_reg.sroa.9.14.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond25.preheader ], [ 0, %if.else347 ], !dbg !167
  fence syncscope("warp") release, !dbg !161
  tail call void @llvm.mxc.barrier.warp(), !dbg !168
  fence syncscope("warp") acquire, !dbg !169
  %mul394 = and i32 %.pre-phi, 4
  %xor388 = xor i32 %shr384.pre-phi, %and387.pre-phi, !dbg !170
  %mul389 = shl nuw nsw i32 %xor388, 3, !dbg !171
  %add390 = add nuw nsw i32 %mul389, %mul381.pre-phi, !dbg !172
  %add395 = or disjoint i32 %add390, %mul394, !dbg !173
  %add.ptr397 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395, !dbg !174
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr397, align 8, !dbg !175
  %xor388.1 = xor i32 %add385.1.pre-phi, %and387.pre-phi, !dbg !170
  %mul389.1 = shl nuw nsw i32 %xor388.1, 3, !dbg !171
  %add390.1 = add nuw nsw i32 %mul389.1, %mul381.pre-phi, !dbg !172
  %add395.1 = or disjoint i32 %add390.1, %mul394, !dbg !173
  %add.ptr397.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.1, !dbg !174
  store i64 %output_reg.sroa.9.0, ptr addrspace(3) %add.ptr397.1, align 8, !dbg !175
  %xor388.2 = xor i32 %add385.2.pre-phi, %and387.pre-phi, !dbg !170
  %mul389.2 = shl nuw nsw i32 %xor388.2, 3, !dbg !171
  %add390.2 = add nuw nsw i32 %mul389.2, %mul381.pre-phi, !dbg !172
  %add395.2 = or disjoint i32 %add390.2, %mul394, !dbg !173
  %add.ptr397.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.2, !dbg !174
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr397.2, align 8, !dbg !175
  %xor388.3 = xor i32 %add385.3.pre-phi, %and387.pre-phi, !dbg !170
  %mul389.3 = shl nuw nsw i32 %xor388.3, 3, !dbg !171
  %add390.3 = add nuw nsw i32 %mul389.3, %mul381.pre-phi, !dbg !172
  %add395.3 = or disjoint i32 %add390.3, %mul394, !dbg !173
  %add.ptr397.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.3, !dbg !174
  store i64 %output_reg.sroa.23.0, ptr addrspace(3) %add.ptr397.3, align 8, !dbg !175
  %xor388.4 = xor i32 %add385.4.pre-phi, %and387.pre-phi, !dbg !170
  %mul389.4 = shl nuw nsw i32 %xor388.4, 3, !dbg !171
  %add390.4 = add nuw nsw i32 %mul389.4, %mul381.pre-phi, !dbg !172
  %add395.4 = or disjoint i32 %add390.4, %mul394, !dbg !173
  %add.ptr397.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.4, !dbg !174
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr397.4, align 8, !dbg !175
  %xor388.5 = xor i32 %add385.5.pre-phi, %and387.pre-phi, !dbg !170
  %mul389.5 = shl nuw nsw i32 %xor388.5, 3, !dbg !171
  %add390.5 = add nuw nsw i32 %mul389.5, %mul381.pre-phi, !dbg !172
  %add395.5 = or disjoint i32 %add390.5, %mul394, !dbg !173
  %add.ptr397.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.5, !dbg !174
  store i64 %output_reg.sroa.37.0, ptr addrspace(3) %add.ptr397.5, align 8, !dbg !175
  %xor388.6 = xor i32 %add385.6.pre-phi, %and387.pre-phi, !dbg !170
  %mul389.6 = shl nuw nsw i32 %xor388.6, 3, !dbg !171
  %add390.6 = add nuw nsw i32 %mul389.6, %mul381.pre-phi, !dbg !172
  %add395.6 = or disjoint i32 %add390.6, %mul394, !dbg !173
  %add.ptr397.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.6, !dbg !174
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr397.6, align 8, !dbg !175
  %xor388.7 = xor i32 %add385.7.pre-phi, %and387.pre-phi, !dbg !170
  %mul389.7 = shl nuw nsw i32 %xor388.7, 3, !dbg !171
  %add390.7 = add nuw nsw i32 %mul389.7, %mul381.pre-phi, !dbg !172
  %add395.7 = or disjoint i32 %add390.7, %mul394, !dbg !173
  %add.ptr397.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add395.7, !dbg !174
  store i64 %output_reg.sroa.51.0, ptr addrspace(3) %add.ptr397.7, align 8, !dbg !175
  fence syncscope("warp") release, !dbg !176
  tail call void @llvm.mxc.barrier.warp(), !dbg !179
  fence syncscope("warp") acquire, !dbg !180
  %mul408 = and i32 %.pre-phi844, 8064
  %invariant.gep563 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul408, !dbg !181
  %add427 = add nuw nsw i32 %add, %.pre-phi844
  %175 = zext nneg i32 %add427 to i64, !dbg !182
  %add.ptr420 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 %add.ptr420.idx.pre-phi, !dbg !166
  %add.ptr432 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175, !dbg !183
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420, i64 16, i1 false), !dbg !184, !tbaa.struct !185, !call_argsrelate !186
  %176 = add nuw nsw i32 %shr414.pre-phi, 4, !dbg !187
  %xor416.1 = xor i32 %176, %and387.pre-phi, !dbg !165
  %gep564.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 1024, !dbg !166
  %add.ptr420.idx.1 = shl nuw nsw i32 %xor416.1, 4, !dbg !166
  %add.ptr420.1 = getelementptr inbounds i8, ptr addrspace(3) %gep564.1, i32 %add.ptr420.idx.1, !dbg !166
  %177 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175, !dbg !183
  %add.ptr432.1 = getelementptr inbounds i8, ptr addrspace(1) %177, i64 1024, !dbg !183
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420.1, i64 16, i1 false), !dbg !184, !tbaa.struct !185, !call_argsrelate !186
  %178 = add nuw nsw i32 %shr414.pre-phi, 8, !dbg !187
  %xor416.2 = xor i32 %178, %and387.pre-phi, !dbg !165
  %gep564.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 2048, !dbg !166
  %add.ptr420.idx.2 = shl nuw nsw i32 %xor416.2, 4, !dbg !166
  %add.ptr420.2 = getelementptr inbounds i8, ptr addrspace(3) %gep564.2, i32 %add.ptr420.idx.2, !dbg !166
  %179 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175, !dbg !183
  %add.ptr432.2 = getelementptr inbounds i8, ptr addrspace(1) %179, i64 2048, !dbg !183
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420.2, i64 16, i1 false), !dbg !184, !tbaa.struct !185, !call_argsrelate !186
  %narrow = add nuw nsw i32 %shr414.pre-phi, 12, !dbg !187
  %xor416.3 = xor i32 %narrow, %and387.pre-phi, !dbg !165
  %gep564.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep563, i32 3072, !dbg !166
  %add.ptr420.idx.3 = shl nuw nsw i32 %xor416.3, 4, !dbg !166
  %add.ptr420.3 = getelementptr inbounds i8, ptr addrspace(3) %gep564.3, i32 %add.ptr420.idx.3, !dbg !166
  %180 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %175, !dbg !183
  %add.ptr432.3 = getelementptr inbounds i8, ptr addrspace(1) %180, i64 3072, !dbg !183
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr432.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr420.3, i64 16, i1 false), !dbg !184, !tbaa.struct !185, !call_argsrelate !186
  ret void, !dbg !188
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #9

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpuv4rlwlb/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpuv4rlwlb/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 23, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 48, scope: !40)
!45 = !DILocation(line: 24, column: 34, scope: !40)
!46 = !DILocation(line: 26, column: 51, scope: !40)
!47 = !DILocation(line: 26, column: 59, scope: !40)
!48 = !DILocation(line: 26, column: 23, scope: !40)
!49 = !DILocation(line: 26, column: 15, scope: !40)
!50 = !DILocation(line: 27, column: 31, scope: !40)
!51 = !DILocation(line: 27, column: 59, scope: !40)
!52 = !DILocation(line: 27, column: 65, scope: !40)
!53 = !DILocation(line: 28, column: 7, scope: !40)
!54 = !DILocation(line: 31, column: 24, scope: !40)
!55 = !DILocation(line: 31, column: 16, scope: !40)
!56 = !{!26, !26, i64 0}
!57 = !DILocation(line: 31, column: 175, scope: !40)
!58 = !DILocation(line: 35, column: 133, scope: !40)
!59 = !DILocation(line: 35, column: 42, scope: !40)
!60 = !DILocation(line: 35, column: 217, scope: !40)
!61 = !DILocation(line: 35, column: 146, scope: !40)
!62 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !65)
!63 = distinct !DISubprogram(name: "__barrier_warp", scope: !64, file: !64, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!64 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!65 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !67)
!66 = distinct !DISubprogram(name: "__syncwarp", scope: !64, file: !64, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!67 = distinct !DILocation(line: 37, column: 5, scope: !40)
!68 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !65)
!69 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !65)
!70 = !DILocation(line: 40, column: 150, scope: !40)
!71 = !DILocation(line: 40, column: 69, scope: !40)
!72 = !DILocation(line: 40, column: 32, scope: !40)
!73 = !DILocation(line: 40, column: 121, scope: !40)
!74 = !DILocation(line: 45, column: 114, scope: !40)
!75 = !DILocation(line: 45, column: 11, scope: !40)
!76 = !DILocation(line: 50, column: 19, scope: !40)
!77 = !DILocation(line: 45, column: 66, scope: !40)
!78 = !DILocation(line: 45, column: 101, scope: !40)
!79 = !DILocation(line: 56, column: 37, scope: !40)
!80 = !{i32 2, i32 -1, i32 -1}
!81 = !DILocation(line: 64, column: 5, scope: !40)
!82 = !DILocation(line: 65, column: 24, scope: !40)
!83 = !DILocation(line: 65, column: 16, scope: !40)
!84 = !DILocation(line: 69, column: 32, scope: !40)
!85 = !DILocation(line: 69, column: 44, scope: !40)
!86 = !DILocation(line: 354, column: 10, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: "min", scope: !88, file: !88, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!89 = distinct !DILocation(line: 69, column: 27, scope: !40)
!90 = !DILocation(line: 285, column: 49, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "exp2f", scope: !88, file: !88, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = distinct !DILocation(line: 69, column: 21, scope: !40)
!93 = !DILocation(line: 74, column: 28, scope: !40)
!94 = !DILocation(line: 1018, column: 9, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 396, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !98, file: !98, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!99 = distinct !DILocation(line: 129, column: 24, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !101, file: !101, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!102 = distinct !DILocation(line: 101, column: 14, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "run<float>", scope: !101, file: !101, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 76, column: 16, scope: !40)
!105 = !DILocation(line: 171, column: 37, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "__lane_id", scope: !64, file: !64, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = distinct !DILocation(line: 990, column: 14, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !64, file: !64, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!109 = distinct !DILocation(line: 1019, column: 11, scope: !95, inlinedAt: !96)
!110 = !DILocation(line: 171, column: 10, scope: !106, inlinedAt: !107)
!111 = !DILocation(line: 991, column: 20, scope: !108, inlinedAt: !109)
!112 = !DILocation(line: 992, column: 36, scope: !108, inlinedAt: !109)
!113 = !DILocation(line: 992, column: 17, scope: !108, inlinedAt: !109)
!114 = !DILocation(line: 992, column: 11, scope: !108, inlinedAt: !109)
!115 = !DILocation(line: 993, column: 43, scope: !108, inlinedAt: !109)
!116 = !DILocation(line: 993, column: 10, scope: !108, inlinedAt: !109)
!117 = !DILocation(line: 1020, column: 14, scope: !95, inlinedAt: !96)
!118 = !DILocation(line: 25, column: 14, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "operator()<float>", scope: !101, file: !101, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 129, column: 11, scope: !100, inlinedAt: !102)
!121 = !DILocation(line: 1018, column: 9, scope: !95, inlinedAt: !122)
!122 = distinct !DILocation(line: 396, column: 10, scope: !97, inlinedAt: !123)
!123 = distinct !DILocation(line: 129, column: 24, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !101, file: !101, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = distinct !DILocation(line: 101, column: 14, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "run<float>", scope: !101, file: !101, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!127 = distinct !DILocation(line: 134, column: 14, scope: !100, inlinedAt: !102)
!128 = !DILocation(line: 171, column: 37, scope: !106, inlinedAt: !129)
!129 = distinct !DILocation(line: 990, column: 14, scope: !108, inlinedAt: !130)
!130 = distinct !DILocation(line: 1019, column: 11, scope: !95, inlinedAt: !122)
!131 = !DILocation(line: 171, column: 10, scope: !106, inlinedAt: !129)
!132 = !DILocation(line: 991, column: 20, scope: !108, inlinedAt: !130)
!133 = !DILocation(line: 992, column: 36, scope: !108, inlinedAt: !130)
!134 = !DILocation(line: 992, column: 17, scope: !108, inlinedAt: !130)
!135 = !DILocation(line: 992, column: 11, scope: !108, inlinedAt: !130)
!136 = !DILocation(line: 993, column: 43, scope: !108, inlinedAt: !130)
!137 = !DILocation(line: 993, column: 10, scope: !108, inlinedAt: !130)
!138 = !DILocation(line: 1020, column: 14, scope: !95, inlinedAt: !122)
!139 = !DILocation(line: 25, column: 14, scope: !119, inlinedAt: !140)
!140 = distinct !DILocation(line: 129, column: 11, scope: !124, inlinedAt: !125)
!141 = !DILocation(line: 78, column: 34, scope: !40)
!142 = !DILocation(line: 78, column: 9, scope: !40)
!143 = !DILocation(line: 86, column: 34, scope: !40)
!144 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !147)
!145 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !146, file: !146, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!147 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !150)
!148 = distinct !DISubprogram(name: "__float2half", scope: !149, file: !149, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!150 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !152)
!151 = distinct !DISubprogram(name: "__half", scope: !149, file: !149, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = distinct !DILocation(line: 92, column: 49, scope: !40)
!153 = !DILocation(line: 92, column: 46, scope: !40)
!154 = !DILocation(line: 103, column: 36, scope: !40)
!155 = !DILocation(line: 113, column: 67, scope: !40)
!156 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !157)
!157 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !158)
!158 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !159)
!159 = distinct !DILocation(line: 113, column: 59, scope: !40)
!160 = !DILocation(line: 113, column: 56, scope: !40)
!161 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !162)
!162 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !163)
!163 = distinct !DILocation(line: 123, column: 3, scope: !40)
!164 = !DILocation(line: 126, column: 94, scope: !40)
!165 = !DILocation(line: 131, column: 253, scope: !40)
!166 = !DILocation(line: 131, column: 169, scope: !40)
!167 = !DILocation(line: 0, scope: !40)
!168 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !162)
!169 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !162)
!170 = !DILocation(line: 126, column: 123, scope: !40)
!171 = !DILocation(line: 126, column: 152, scope: !40)
!172 = !DILocation(line: 126, column: 78, scope: !40)
!173 = !DILocation(line: 126, column: 158, scope: !40)
!174 = !DILocation(line: 126, column: 40, scope: !40)
!175 = !DILocation(line: 126, column: 201, scope: !40)
!176 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !177)
!177 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !178)
!178 = distinct !DILocation(line: 128, column: 3, scope: !40)
!179 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !177)
!180 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !177)
!181 = !DILocation(line: 130, column: 8, scope: !40)
!182 = !DILocation(line: 130, column: 3, scope: !40)
!183 = !DILocation(line: 131, column: 22, scope: !40)
!184 = !DILocation(line: 131, column: 132, scope: !40)
!185 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!186 = !{i32 1, i32 -1, i32 -1, i32 -1}
!187 = !DILocation(line: 131, column: 267, scope: !40)
!188 = !DILocation(line: 133, column: 1, scope: !40)
