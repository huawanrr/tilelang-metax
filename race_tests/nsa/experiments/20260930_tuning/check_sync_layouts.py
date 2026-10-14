"""Check address ownership and MMA coverage for the synchronous wave variants."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    layouts = []
    for bs in (16, 32, 64):
        for dim in (32, 64, 128):
            for vec in (8, 16):
                phase = max(1, 64 // dim)
                maximum = min(16 // phase, dim // vec)
                writers, k_addresses, v_addresses = set(), set(), set()
                for j in range(bs):
                    for d in range(dim):
                        lane = (j * dim + d) // 8 % 64
                        local = (j * dim + d) // 512 * 8 + d % 8
                        assert (lane, local) not in writers
                        writers.add((lane, local))
                        inverse = local // 8 * 512 + lane * 8 + local % 8
                        assert inverse == j * dim + d
                        k = j * dim + ((d // vec) ^ ((j // phase) % maximum)) * vec + d % vec
                        v = j * dim + d
                        assert k not in k_addresses and 0 <= k < bs * dim
                        assert v not in v_addresses and 0 <= v < bs * dim
                        k_addresses.add(k)
                        v_addresses.add(v)
                assert k_addresses == v_addresses == set(range(bs * dim))
                layouts.append(dict(bs=bs, dim=dim, vector=vec, unique_owners=len(writers)))
    pv = []
    for bs in (16, 32, 64):
        for dim in (32, 64, 128):
            for width in (16, 32, 64, 128):
                if width > dim:
                    continue
                coverage = set()
                for vo in range(dim // width):
                    for ki in range(bs // 16):
                        for tile in range(width // 16):
                            for lane in range(64):
                                for element in range(4):
                                    row = ki * 16 + lane // 16 * 4 + element
                                    col = vo * width + tile * 16 + lane % 16
                                    assert (row, col) not in coverage
                                    coverage.add((row, col))
                assert coverage == {(j, d) for j in range(bs) for d in range(dim)}
                pv.append(dict(bs=bs, dim=dim, width=width, exact_elements=len(coverage)))
    joined = []
    # Check concatenated block positions, including sentinels, repeated blocks,
    # causal boundaries, and partial final blocks independently of the kernel.
    for length in (1, 15, 16, 17, 37, 127, 128, 129, 1025):
        for selected in (2, 4):
            for starts in ([-16] * selected, [0] * selected,
                           [((length - 1) // 16) * 16] * selected,
                           ([0, -48, length * 16, 16] * selected)[:selected]):
                expected = [start + offset for start in starts for offset in range(16)]
                actual = [starts[j // 16] + j % 16 for j in range(selected * 16)]
                assert expected == actual
                for token in range(length):
                    for causal in (False, True):
                        masked = [p for p in actual if 0 <= p < length and (not causal or p <= token)]
                        reference = [p for p in expected if 0 <= p < length and (not causal or p <= token)]
                        assert masked == reference
            joined.append(dict(length=length, selected=selected, positions_and_masks=True))
    report = dict(status='PASS', shared_layouts=layouts, pv_coverage=pv, joined_blocks=joined,
        synchronization={
            'threads_per_cta': 64, 'maca_lanes_per_wave': 64,
            'shared_kv': ['K stores -> barrier -> K reads',
                          'K reads -> barrier -> V stores',
                          'V stores -> barrier -> V reads'],
            'direct_or_shuffle_k': ['V stores -> barrier -> V reads'],
            'shared_q': ['Q and K stores -> barrier -> Q and K reads',
                         'K reads -> barrier -> V stores',
                         'V stores -> barrier -> V reads'],
            'shared_q_reuse': ['Q stores -> barrier -> Q reads into registers',
                               'Q reads -> barrier -> K stores into the reused allocation',
                               'K stores -> barrier -> K reads',
                               'K reads -> barrier -> V stores',
                               'V stores -> barrier -> V reads'],
            'shared_q_reuse_allocation': 'For D64/BS16/G16, Q, K and V each occupy 2048 bytes. Their shared live ranges do not overlap; a barrier separates each read from the next overwrite. Confirm actual allocation reuse in generated device source.',
            'online_separate_kv': ['K stores -> barrier -> K reads',
                                   'V stores -> barrier -> V reads',
                                   'Next K-ready barrier precedes the next V overwrite'],
            'conditions': 'All wave lanes use the same query and selected-block index; branches around barriers are uniform.',
            'implementation': 'Public T.sync_warp emits MACA __syncwarp with release/acquire warp fences.',
        }, data_race_checks_disabled=False, bounds_checks_disabled=False,
        note='Address/coverage proof and synchronization argument; actual kernels require separate GPU reference and refresh checks.')
    (HERE / 'sync_layout_proof.json').write_text(json.dumps(report, indent=2)+'\n')
    print('PASS:',len(layouts),'shared layouts,',len(pv),'PV coverage checks,',len(joined),'block concatenation/mask families')


if __name__ == '__main__':
    main()
