@tilelang.jit
def prepare_buckets(B, N, H, BS, QT, causal):
    NB = tilelang.cdiv(N, BS)
    NS = max(64, tilelang.math.next_power_of_2(NB + 1))
    CAP = tilelang.cdiv(N, QT) + NB + 1
    @T.prim_func
    def kernel(Indices: T.Tensor([B, N, H, 1], T.int32),
               Sorted: T.Tensor([B, H, NB + 1, N], T.int32),
               Schedule: T.Tensor([B, H, CAP, 3], T.int32)):
        with T.Kernel(B * H, threads=256) as bh:
            tid = T.get_thread_binding()
            counts = T.alloc_shared([NS], T.int32)
            scan = T.alloc_shared([NS], T.int32)
            T.clear(counts)
            for step in T.serial(T.ceildiv(CAP, 256)):
                i = step * 256 + tid
                if i < CAP:
                    Schedule[bh // H, bh % H, i, 0] = -1
                    Schedule[bh // H, bh % H, i, 1] = -1
                    Schedule[bh // H, bh % H, i, 2] = -1
            T.sync_threads()
            for step in T.serial(T.ceildiv(N, 256)):
                t = step * 256 + tid
                if t < N:
                    raw = Indices[bh // H, t, bh % H, 0]
                    dest = T.if_then_else(raw >= 0 and raw < NB and (not causal or raw * BS <= t), raw, NB)
                    bucket = T.min(T.max(dest, 0), NB)
                    slot = T.atomic_add(counts[bucket], 1, return_prev=True)
                    Sorted[bh // H, bh % H, bucket, slot] = t
            T.sync_threads()
            for i in T.Parallel(NS):
                scan[i] = T.ceildiv(counts[i], QT)
            T.cumsum(scan)
            for step in T.serial(T.ceildiv(NB + 1, 256)):
                bucket = step * 256 + tid
                if bucket < NB + 1:
                    count = counts[bucket]
                    groups = T.ceildiv(count, QT)
                    for group in T.serial(groups):
                        dst = scan[bucket] - groups + group
                        Schedule[bh // H, bh % H, dst, 0] = bucket
                        Schedule[bh // H, bh % H, dst, 1] = group * QT
                        Schedule[bh // H, bh % H, dst, 2] = T.min(QT, count - group * QT)
    return kernel


def _make_bucket_attention(prepare, attention, B, N, H, BS, QT):
    sorted_shape = (B, H, (N + BS - 1) // BS + 1, N)
    schedule_shape = (B, H, (N + QT - 1) // QT + (N + BS - 1) // BS + 1, 3)
    def run(q, k, v, indices, output):
        sorted_indices = torch.empty(sorted_shape, device=q.device, dtype=torch.int32)
        schedule = torch.empty(schedule_shape, device=q.device, dtype=torch.int32)
        prepare(indices, sorted_indices, schedule)
        attention(q, k, v, sorted_indices, schedule, output)
    return run
