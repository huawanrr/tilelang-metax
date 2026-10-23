#!/usr/bin/env bash
set -euo pipefail

HERE=$(cd "$(dirname "$0")" && pwd)
exec bash "$HERE/03_源码与复现/test/run_all.sh" "${1:-full}"
