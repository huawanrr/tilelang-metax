"""Try ordinary instruction ordering and register packing, keeping fences."""
from make_schedule_probes import main

if __name__ == "__main__":
    main({
        "mma": ["-mllvm", "--metaxgpu-mma-sched=true"],
        "igroup": ["-mllvm", "--metaxgpu-igroup=true", "-mllvm", "--metaxgpu-igroup-strategy=1"],
        "hireg": ["-mllvm", "--metaxgpu-use-hireg=true"],
        "warp_split": ["-mllvm", "--metaxgpu-warp-split=true"],
        "bsm_store_back": ["-mllvm", "--metaxgpu-bsm-store-back=true"],
    }, "schedule_extra_manifest.json")
