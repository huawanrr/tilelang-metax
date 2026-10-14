"""Hash embedded device .text sections from the resource inspector's matches."""

import argparse
import hashlib
import json
from pathlib import Path
import struct


def device_texts(path):
    data = path.read_bytes()
    cursor = 4  # Skip the outer host ELF.
    result = []
    while True:
        start = data.find(b"\x7fELF", cursor)
        if start < 0:
            return result
        cursor = start + 4
        if data[start + 4:start + 6] != b"\x02\x01":
            continue
        try:
            table = struct.unpack_from("<Q", data, start + 40)[0]
            width, count, string_index = struct.unpack_from("<HHH", data, start + 58)
            if width != 64 or count > 1000:
                continue
            sections = [struct.unpack_from("<IIQQQQIIQQ", data, start + table + i * width)
                        for i in range(count)]
            string_section = sections[string_index]
            strings = data[start + string_section[4]:start + string_section[4] + string_section[5]]
            for section in sections:
                name = strings[section[0]:].split(b"\0", 1)[0]
                if name == b".text":
                    text = data[start + section[4]:start + section[4] + section[5]]
                    result.append(dict(size=len(text), sha256=hashlib.sha256(text).hexdigest()))
        except (IndexError, struct.error):
            continue


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("resources")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    resources = json.loads(Path(args.resources).read_text())
    rows = []
    for i, hashes in enumerate(resources["source_hashes"]):
        source = hashes[-1]
        matches = [dict(library=match["library"], texts=device_texts(Path(match["library"])))
                   for match in resources["matches"][source]]
        rows.append(dict(module=i, source_sha256=source, matches=matches,
                         compile_flags=resources["compile_flags"][i][-1]))
    report = dict(resources=args.resources, rows=rows,
                  note="All matching cached device .text sections retained; compiler flags recorded separately.")
    Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    for row in rows:
        print(row["module"], [text for match in row["matches"] for text in match["texts"]])


if __name__ == "__main__":
    main()
