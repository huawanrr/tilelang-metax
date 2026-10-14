"""Enumerate packed destinations, source ownership, shared addresses and tails."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    bs, dim = 32, 128
    checks = []
    for threads in (64, 128, 256):
        source_owners, packed_owners = set(), set()
        shared_writers, shared_readers = {}, {}
        packed_k, packed_v = set(), set()
        crossing_waves = 0
        for row in range(bs):
            for col in range(dim):
                linear = row * dim + col
                src = (linear // 8 % threads, linear // (threads * 8) * 8 + col % 8)
                assert src not in source_owners
                source_owners.add(src)
                kindex = (col // 32, row // 16, col % 32 // 8 * 16 + row % 16, col % 8)
                vindex = (row // 16, col // 32, row % 16 // 4 * 16 + col % 16,
                          col % 32 // 16 * 4 + row % 4)
                assert kindex not in packed_k and vindex not in packed_v
                packed_k.add(kindex)
                packed_v.add(vindex)
                tile, dpart, lane, element = vindex
                physical_lane = (tile * (dim // 32) + dpart) * 64 + lane
                dst = (physical_lane % threads, physical_lane // threads * 8 + element)
                assert dst not in packed_owners
                packed_owners.add(dst)
                shared = row * dim + ((col // 4) ^ (row % 16)) * 4 + col % 4
                assert shared not in shared_writers and shared not in shared_readers
                shared_writers[shared] = (src, row, col)
                shared_readers[shared] = (dst, row, col)
                crossing_waves += src[0] // 64 != dst[0] // 64
                kb, jb, klane, ke = kindex
                assert (jb * 16 + klane % 16, kb * 32 + klane // 16 * 8 + ke) == (row, col)
                assert (tile * 16 + lane // 16 * 4 + element % 4,
                        dpart * 32 + element // 4 * 16 + lane % 16) == (row, col)
        expected_owners = {(t, e) for t in range(threads) for e in range(bs * dim // threads)}
        assert source_owners == packed_owners == expected_owners
        assert set(shared_writers) == set(shared_readers) == set(range(bs * dim))
        for addr in shared_writers:
            assert shared_writers[addr][1:] == shared_readers[addr][1:]
        checks.append(dict(threads=threads, elements=bs * dim, unique_packed_k=len(packed_k),
                           unique_packed_v=len(packed_v), shared_bijection=True,
                           cross_wave_elements=crossing_waves,
                           required_sync='wave' if threads == 64 else 'block'))
    tails = []
    for length in (1, 15, 16, 17, 31, 32, 33, 37, 64, 127, 128, 129,
                   511, 512, 513, 1023, 1024, 1025, 2047, 2048, 2049):
        valid = [block * bs + row for block in range((length + bs - 1) // bs)
                 for row in range(bs) if block * bs + row < length]
        assert valid == list(range(length))
        tails.append(dict(seq_len=length, covered_rows=length, padded_rows=(-length) % bs))
    report = dict(status='PASS', shape=dict(D=dim, block_size=bs), checks=checks, tails=tails,
                  race_checks_disabled=False, bounds_checks_disabled=False,
                  scope='Ownership proof; actual live-input values, tail zeros and synchronization are verified separately on GPU.')
    (HERE / 'pack_layout_proof.json').write_text(json.dumps(report, indent=2) + '\n')
    print('PASS:', len(checks), 'thread configurations and', len(tails), 'tail families')


if __name__ == '__main__':
    main()
