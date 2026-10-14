"""Apply only the output lane exchange to the existing direct-output D64 path."""

import hashlib
import json

from prepare import BASE, HERE, ROOT, output_code, replace_tail


def main():
    source = BASE.read_text()
    names = ("native_sparse_attention_shared_q_blocks", "native_sparse_attention_shared_q_reuse")
    for name in names:
        source = replace_tail(source, name, "            T.copy(acc_o, Output[", output_code("acc_o"))
    path = HERE / "output_lane_mid.py"
    with path.open("x") as output:
        output.write(source)
    with (HERE / "mid_assembly.json").open("x") as output:
        output.write(json.dumps(dict(path=str(path.relative_to(ROOT)), changed_functions=names,
                                    sha256=hashlib.sha256(path.read_bytes()).hexdigest()), indent=2) + "\n")
    print(path.name)


if __name__ == "__main__":
    main()
