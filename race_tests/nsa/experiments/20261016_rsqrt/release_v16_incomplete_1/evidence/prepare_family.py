"""Predeclare neighboring configurations for the coherent initial signals."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    cases = json.loads((HERE / "cases.json").read_text())
    groups = {"joint_bs32": ["oj6"], "packed_s8": ["oj12"], "mid_multih": ["oj13"]}

    def add(group, name, base, **updates):
        assert name not in cases
        cases[name] = dict(cases[base], **updates)
        groups[group].append(name)

    add("joint_bs32", "bs32_b4_t1024", "oj6", B=4)
    add("joint_bs32", "bs32_b4_t2048", "oj6", B=4, SEQ_LEN=2048)
    add("joint_bs32", "bs32_b1_t4096", "oj6", B=1, SEQ_LEN=4096)
    add("joint_bs32", "bs32_b2_h2_t1024", "oj6", B=2, H=2, HQ=32)
    add("joint_bs32", "bs32_b8_t1024_c0", "oj6", is_causal=False)

    add("packed_s8", "s8_b2_t2048", "oj12", B=2, SEQ_LEN=2048)
    add("packed_s8", "s8_b1_h4_t1024", "oj12", B=1, H=4, HQ=64)
    add("packed_s8", "s8_b8_t1024", "oj12", B=8)
    add("packed_s8", "s8_b4_h2_t1024", "oj12", H=2, HQ=32)
    add("packed_s8", "s8_b4_t1024_c0", "oj12", is_causal=False)

    add("mid_multih", "mid_b1_h2_t384", "oj13", SEQ_LEN=384)
    add("mid_multih", "mid_b1_h2_t512", "oj13", SEQ_LEN=512)
    add("mid_multih", "mid_b2_h2_t384", "oj13", B=2, SEQ_LEN=384)
    add("mid_multih", "mid_b1_h3_t256", "oj13", H=3, HQ=48)
    add("mid_multih", "mid_b1_h4_t256", "oj13", H=4, HQ=64)
    add("mid_multih", "mid_b1_h4_t384", "oj13", H=4, HQ=64, SEQ_LEN=384)
    add("mid_multih", "mid_b3_h2_t256", "oj13", B=3)

    plan = dict(groups=groups, cases=[name for names in groups.values() for name in names],
                seeds=[0, 61], mode="ieee_rsqrt.py", status="predeclared before family timing",
                rationale="Positive initial signals in the existing BS32 joint, packed S8, and causal mid-size multihead builders; vary B/T/H and causal flag before considering any implementation.",
                storage_confirmation=dict(cases=["oj1", "oj13"], modes=["rsqrt.py", "ieee_rsqrt.py"],
                                          seeds=[0, 61], repeats=[96, 480], placements=4))
    for name, data in (("family_cases.json", cases), ("family_plan.json", plan)):
        with (HERE / name).open("x") as out:
            json.dump(data, out, indent=2)
            out.write("\n")
    print(",".join(plan["cases"]))


if __name__ == "__main__":
    main()
