"""Run the public dual-interface suite with the float32 reference and TF32 off."""
from pathlib import Path
import sys

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from verify_nsa import main


if __name__ == '__main__':
    torch.backends.cuda.matmul.allow_tf32 = False
    main()
