"""Run the shared dual-interface reference suite with TF32 explicitly disabled."""
from pathlib import Path
import sys

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from verify_nsa import main


if __name__ == '__main__':
    torch.backends.cuda.matmul.allow_tf32 = False
    main()
