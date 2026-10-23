tid = T.get_thread_binding()
window = bx - NB * NR * NC
buckets = T.alloc_local([2], T.int32)
votes = T.alloc_local([2, 6], T.uint64)
active = T.alloc_local([2], T.uint64)
matches = T.alloc_local([2, 2], T.uint64)
counts = T.alloc_local([2], T.int32)
ranks = T.alloc_local([2], T.int32)
leaders = T.alloc_local([2], T.int32)
owned = T.alloc_local([2], T.int32)
scan = T.alloc_local([1], T.int32)
lane_bit = T.uint64(1) << T.cast(tid, "uint64")
lower_lanes = lane_bit - T.uint64(1)
upper_lanes = ~(lower_lanes | lane_bit)
for query in T.unroll(2):
    token = window * 128 + query * 64 + tid
    raw = T.if_then_else(token < seq_len, Indices[b, token, h, 0], -1)
    buckets[query] = T.if_then_else(raw >= 0 and raw < NB and (not is_causal or raw <= token // BS), raw, NB)
    if seq_len % 128 == 0:
        active[query] = T.uint64(18446744073709551615)
    else:
        active[query] = T.if_then_else(token < seq_len, lane_bit, T.uint64(0))
    for bit in T.unroll(6):
        votes[query, bit] = T.if_then_else((buckets[query] & (1 << bit)) != 0, lane_bit, T.uint64(0))
# Native T.ballot is not lowered by this MACA backend. These are ordinary,
# supported 64-lane shuffle-OR collectives, with no external device calls.
for step in T.unroll(6):
    for query in T.unroll(2):
        if seq_len % 128 != 0:
            active[query] = active[query] | T.shfl_xor(active[query], 1 << step, 64, 18446744073709551615)
        for bit in T.unroll(6):
            votes[query, bit] = votes[query, bit] | T.shfl_xor(votes[query, bit], 1 << step, 64, 18446744073709551615)
for query in T.unroll(2):
    for half in T.unroll(2):
        matches[query, half] = active[half]
        for bit in T.unroll(6):
            matches[query, half] = matches[query, half] & T.if_then_else((buckets[query] & (1 << bit)) != 0, votes[half, bit], ~votes[half, bit])
    counts[query] = T.cast(T.popcount(matches[query, 0]) + T.popcount(matches[query, 1]), "int32")
    leaders[query] = T.if_then_else(matches[query, 0] != 0,
        63 - T.cast(T.clz(matches[query, 0] | T.uint64(1)), "int32"),
        127 - T.cast(T.clz(matches[query, 1] | T.uint64(1)), "int32"))
    ranks[query] = T.cast(T.popcount(matches[query, query] & upper_lanes), "int32")
    if query == 1:
        ranks[query] += T.cast(T.popcount(matches[query, 0]), "int32")
    owned[query] = T.if_then_else(window * 128 + query * 64 + tid < seq_len and leaders[query] == query * 64 + tid, (counts[query] + 1) // 2, 0)
scan[0] = owned[0] + owned[1]
for step in T.unroll(6):
    preceding = T.shfl_up(scan[0], 1 << step, 64, 18446744073709551615)
    if tid >= (1 << step):
        scan[0] += preceding
prefix_record = scan[0] - owned[0] - owned[1] + owned[0] * 65536
total_tasks = T.shfl_sync(scan[0], 63, 64, 18446744073709551615)
for init_step in T.unroll(T.ceildiv(CAP, 64)):
    unused_task = init_step * 64 + tid
    if unused_task < CAP and unused_task >= total_tasks:
        Schedule[b, h, window, unused_task] = T.int64(0)
for query in T.unroll(2):
    prefix_from_leader = T.shfl_sync(prefix_record, leaders[query] % 64, 64, 18446744073709551615)
    task = prefix_from_leader % 65536 + T.if_then_else(leaders[query] >= 64, prefix_from_leader // 65536, 0) + ranks[query] // 2
    token = window * 128 + query * 64 + tid
    if token < seq_len and ranks[query] % 2 == 0:
        lower_match = matches[query, query] & lower_lanes
        partner_lane = T.if_then_else(query == 0 and lower_match == 0,
            127 - T.cast(T.clz(matches[query, 1] | T.uint64(1)), "int32"),
            query * 64 + 63 - T.cast(T.clz(lower_match | T.uint64(1)), "int32"))
        partner = T.if_then_else(ranks[query] + 1 < counts[query], window * 128 + partner_lane, -1)
        Schedule[b, h, window, task] = T.cast(token + 1, "int64") + T.cast(partner + 1, "int64") * T.int64(65536) + T.cast(buckets[query], "int64") * T.int64(4294967296)
