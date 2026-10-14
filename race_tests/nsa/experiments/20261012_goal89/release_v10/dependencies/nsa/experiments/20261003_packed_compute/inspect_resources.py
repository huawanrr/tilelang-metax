"""Read MetaX resource metadata from the device ELF embedded in cached binaries.

This is a CPU-only diagnostic. It does not rebuild or change any device code.
Several cache entries may share C++ while using different compiler flags; all
matching entries are retained rather than attributing one arbitrarily.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct

import msgpack


def metax_notes(data):
    position = 0
    resources = []
    while True:
        start = data.find(b'\x7fELF', position)
        if start < 0:
            break
        position = start + 4
        if data[start+4:start+6] != b'\x02\x01':
            continue
        try:
            table = struct.unpack_from('<Q', data, start + 40)[0]
            entry_size, count = struct.unpack_from('<HH', data, start + 58)
            if entry_size != 64 or count > 1000:
                continue
            for index in range(count):
                fields = struct.unpack_from('<IIQQQQIIQQ', data, start + table + index * entry_size)
                if fields[1] != 7:
                    continue
                offset, length = start + fields[4], fields[5]
                end = offset + length
                while offset + 12 <= end:
                    namesize, descsize, kind = struct.unpack_from('<III', data, offset)
                    if offset + 12 + namesize + descsize > end:
                        break
                    name = data[offset+12:offset+12+namesize].rstrip(b'\0')
                    desc = offset + 12 + ((namesize + 3) // 4 * 4)
                    if name == b'MetaX':
                        metadata = msgpack.unpackb(data[desc:desc+descsize], raw=False)
                        for kernel in metadata.get('macahca.kernels', []):
                            resources.append({k: v for k, v in kernel.items() if k != '.args'})
                    offset = desc + (descsize + 3) // 4 * 4
        except (struct.error, ValueError, msgpack.exceptions.UnpackException):
            continue
    return resources


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('screen')
    p.add_argument('--case', default='oj6')
    p.add_argument('--output', required=True)
    args = p.parse_args()
    screen = json.loads(Path(args.screen).read_text())
    row = next(r for r in screen['rows'] if r['case'] == args.case)
    wanted = {value for hashes in row['device_source_sha256'] for value in hashes}
    found = {key: [] for key in wanted}
    for source in Path('/tmp/tilelang-cache-nsa').glob('*/kernels/*/device_kernel.cu'):
        digest = hashlib.sha256(source.read_bytes()).hexdigest()
        if digest not in wanted:
            continue
        library = source.with_name('executable.so')
        if not library.exists():
            continue
        resources = metax_notes(library.read_bytes())
        found[digest].append(dict(library=str(library), resources=resources))
    report = dict(case=args.case, config=row['config'], source_hashes=row['device_source_sha256'],
                  compile_flags=row['compile_flags'], matches=found,
                  caution='C++ hashes alone do not distinguish compiler flags. All matching cache entries are listed.')
    Path(args.output).write_text(json.dumps(report, indent=2)+'\n')
    for i, hashes in enumerate(row['device_source_sha256']):
        print('module', i, 'flags', row['compile_flags'][i])
        for digest in hashes:
            unique = {json.dumps(r, sort_keys=True) for m in found[digest] for r in m['resources']}
            print(' ', digest[:12], *sorted(unique))


if __name__ == '__main__':
    main()
