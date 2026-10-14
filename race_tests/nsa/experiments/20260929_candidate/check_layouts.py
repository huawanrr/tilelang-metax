"""Exhaustively check the new shared writes and D32 word permutation."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    rows = []
    for bs in (16, 32, 64):
        for dim in (32, 64, 128):
            per_phase = max(1, 64 // dim)
            max_phase = min(16 // per_phase, dim // 8)
            writers, k_addresses, v_addresses = set(), set(), set()
            for j in range(bs):
                for d in range(dim):
                    lane = ((j * dim + d) // 8) % 64
                    local = ((j * dim + d) // 512) * 8 + d % 8
                    assert (lane, local) not in writers
                    writers.add((lane, local))
                    inverse = (local // 8) * 512 + lane * 8 + local % 8
                    assert (inverse // dim, inverse % dim) == (j, d)
                    k_address = j * dim + ((d // 8) ^ ((j // per_phase) % max_phase)) * 8 + d % 8
                    v_address = j * dim + d
                    assert k_address not in k_addresses and 0 <= k_address < bs * dim
                    assert v_address not in v_addresses and 0 <= v_address < bs * dim
                    k_addresses.add(k_address)
                    v_addresses.add(v_address)
            assert k_addresses == v_addresses == set(range(bs * dim))
            rows.append(dict(block_size=bs, dim=dim, unique_thread_local_owners=len(writers),
                             k_shared_bijection=True, v_shared_bijection=True, complete_coverage=True))
    # A raw vector contains eight adjacent half values. Shuffle four uint32
    # words from the source lane into the row/column ownership required by
    # the 16x32, k_pack=2 MMA operand. Each half retains its exact bits.
    values = set()
    for lane in range(64):
        source_lane = (lane % 16) * 4 + lane // 16
        assert 0 <= source_lane < 64
        for word in range(4):
            for half in range(2):
                e = word * 2 + half
                raw_linear = source_lane * 8 + e
                expected_linear = (lane % 16) * 32 + (lane // 16) * 8 + e
                assert raw_linear == expected_linear
                assert raw_linear not in values
                values.add(raw_linear)
    assert values == set(range(16 * 32))
    result = dict(status='PASS', shared_layouts=rows,
                  d32_shuffle=dict(exact_values=512, complete_coverage=True),
                  race_checks_disabled=False,
                  note='This verifies address bijections; GPU reference checks validate the actual generated kernels.')
    (HERE / 'layout_proof.json').write_text(json.dumps(result, indent=2) + '\n')
    print('PASS: 9 shared-layout bijections and all 512 D32 shuffle values; race checks remain enabled.')


if __name__ == '__main__':
    main()
