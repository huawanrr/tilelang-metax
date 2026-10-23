export TILELANG_CACHE_DIR=${TILELANG_CACHE_DIR:-/tmp/tilelang-cache-nsa}
export MACA_PATH=${MACA_PATH:-/opt/maca}
export LD_LIBRARY_PATH="/app/tilelang-metax/build/lib:${MACA_PATH}/lib:${MACA_PATH}/mxgpu_llvm/lib:${LD_LIBRARY_PATH}"
export PATH="${MACA_PATH}/bin:${MACA_PATH}/mxgpu_llvm/bin:${PATH}"
export PYTHONPATH="/app/tilelang-metax:${PYTHONPATH}"
