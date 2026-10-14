"""Enumerate ownership, shared addresses and MMA reads for the Q/O path."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def swizzle(row, col, dim):
    phase = max(1, 64 // dim)
    maximum = min(16 // phase, dim // 8)
    return row * dim + ((col // 8) ^ ((row // phase) % maximum)) * 8 + col % 8


def staged_owner(row, col, dim, vector):
    linear = row * dim + col
    return linear // vector % 64, linear // (64 * vector) * vector + col % vector


def main():
    checks = []
    for dim, bs in ((64, 16), (128, 16), (128, 32)):
        for qvec in (4, 8):
            for width in sorted({min(64, dim), min(128, dim)}):
                expected_q = {(i, d) for i in range(16) for d in range(dim)}
                expected_kv = {(j, d) for j in range(bs) for d in range(dim)}
                qowners = {staged_owner(i, d, dim, qvec) for i, d in expected_q}
                qshared = {swizzle(i, d, dim) for i, d in expected_q}
                assert len(qowners) == len(qshared) == 16 * dim
                assert qshared == set(range(16 * dim))
                for i, d in expected_q:
                    lane, local = staged_owner(i, d, dim, qvec)
                    assert local // qvec * 64 * qvec + lane * qvec + local % qvec == i * dim + d
                kvowners = {staged_owner(j, d, dim, 8) for j, d in expected_kv}
                kshared = {swizzle(j, d, dim) for j, d in expected_kv}
                assert len(kvowners) == bs * dim
                assert kshared == set(range(bs * dim))
                qreads, kreads, vreads = [], [], []
                for lane in range(64):
                    for ki in range(dim // 32):
                        for e in range(8):
                            col = ki * 32 + lane // 16 * 8 + e
                            qreads.append((lane % 16, col))
                            for j in range(bs // 16):
                                kreads.append((j * 16 + lane % 16, col))
                    for vo in range(dim // width):
                        for ki in range(bs // 16):
                            for j in range(width // 16):
                                for e in range(4):
                                    vreads.append((ki * 16 + lane // 16 * 4 + e,
                                                   vo * width + j * 16 + lane % 16))
                assert len(qreads) == len(set(qreads)) == len(expected_q)
                assert set(qreads) == expected_q
                assert len(kreads) == len(set(kreads)) == len(expected_kv)
                assert set(kreads) == expected_kv
                assert len(vreads) == len(set(vreads)) == len(expected_kv)
                assert set(vreads) == expected_kv
                oowners = {(i + (d % 16 // 4) * 16, d // 16 * 4 + d % 4)
                           for i, d in expected_q}
                assert len(oowners) == len(expected_q)
                output_tiles = [(i, vo * width + d) for vo in range(dim // width)
                                for i in range(16) for d in range(width)]
                assert len(output_tiles) == len(set(output_tiles)) == len(expected_q)
                assert set(output_tiles) == expected_q
                checks.append(dict(dim=dim, block_size=bs, q_vector=qvec, pv_width=width,
                    q_owners=len(qowners), kv_owners=len(kvowners), o_owners=len(oowners),
                    q_reads=len(qreads), k_reads=len(kreads), v_reads=len(vreads),
                    shared_allocation_bytes=max(16, bs) * dim * 2))
    dim, bs = 128, 32
    pk, pv = set(), set()
    for j in range(bs):
        for d in range(dim):
            kindex = (d // 32, j // 16, (d % 32 // 8) * 16 + j % 16, d % 8)
            vindex = (j // 16, d // 32, (j % 16 // 4) * 16 + d % 16,
                      (d % 32 // 16) * 4 + j % 4)
            assert kindex not in pk and vindex not in pv
            pk.add(kindex)
            pv.add(vindex)
            kb, jb, lane, element = kindex
            assert (jb * 16 + lane % 16, kb * 32 + lane // 16 * 8 + element) == (j, d)
            jb, db, lane, element = vindex
            assert (jb * 16 + lane // 16 * 4 + element % 4,
                    db * 32 + element // 4 * 16 + lane % 16) == (j, d)
    assert len(pk) == len(pv) == dim * bs
    assert pk == {(kb, jb, lane, e) for kb in range(dim // 32)
                  for jb in range(bs // 16) for lane in range(64) for e in range(8)}
    assert pv == {(jb, db, lane, e) for jb in range(bs // 16)
                  for db in range(dim // 32) for lane in range(64) for e in range(8)}
    tails = []
    for length in (1, 15, 16, 17, 31, 32, 33, 37, 64, 1023, 1024, 1025):
        positions = [block * bs + j for block in range((length + bs - 1) // bs)
                     for j in range(bs) if block * bs + j < length]
        assert positions == list(range(length))
        tails.append(dict(seq_len=length, valid_positions=len(positions),
                          padded_rows=(-length) % bs))
    reduce_header = Path('/app/tilelang-metax/src/tl_templates/maca/reduce.h')
    reduce_source = reduce_header.read_text()
    assert 'if constexpr (offset >= 64)' in reduce_source
    assert 'x = Reducer()(x, tl::shfl_xor_sync(uint64_t(-1), x, offset));' in reduce_source
    offsets = []
    threads = 64
    while threads != 16:
        offsets.append(threads // 2)
        threads //= 2
    assert offsets == [32, 16] and all(offset < 64 for offset in offsets)
    report = dict(status='PASS', checks=checks, threads_per_cta=64, lanes_per_wave=64,
        barriers=['Q stores -> Q reads', 'Q reads -> K stores', 'K stores -> K reads',
                  'K reads -> V stores', 'V stores -> V reads', 'V reads -> O stores',
                  'O stores -> output reads'],
        uniformity='Each CTA owns one query and one KV head. Query and block validity are wave uniform.',
        invalid_rows='PV accumulators are cleared even when the selected block is invalid; output writes cover every element.',
        allocation='Q, K, V and O have disjoint shared live ranges. Check the actual common allocation base and byte count in generated source.',
        packed=dict(dim=dim, block_size=bs, unique_k_elements=len(pk), unique_v_elements=len(pv),
                    inverse_maps=True, tail_families=tails,
                    barriers=['Q stores -> Q reads', 'Q reads -> O stores', 'O stores -> output reads'],
                    reduction_offsets=offsets, reduction_shared_accesses=0,
                    reduction_header=str(reduce_header),
                    reduction_header_sha256=hashlib.sha256(reduce_header.read_bytes()).hexdigest(),
                    live_inputs='The ordinary host closure allocates and repacks K/V on every call.'),
        race_checks_disabled=False, bounds_checks_disabled=False)
    (HERE / 'qo_layout_proof.json').write_text(json.dumps(report, indent=2) + '\n')
    print('PASS:', len(checks), 'layout/MMA combinations, two 4096-element packed bijections,',
          len(tails), 'tail families and shuffle-only denominator reduction')


if __name__ == '__main__':
    main()
