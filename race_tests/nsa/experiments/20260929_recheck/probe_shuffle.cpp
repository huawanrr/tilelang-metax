#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ A, half_t* __restrict__ O);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const half_t* __restrict__ A, half_t* __restrict__ O) {
  uint words[4];
  uint outwords[4];
  *(uint4*)(((half_t*)words) + 0) = *(uint4*)(A + (((int)threadIdx.x) * 8));
  #pragma unroll
  for (int j = 0; j < 4; ++j) {
    outwords[j] = __shfl_sync((uint64_t)18446744073709551615, words[j], (((int)threadIdx.x) ^ 31), 64);
  }
  *(uint4*)(O + (((int)threadIdx.x) * 8)) = *(uint4*)(((half_t*)outwords) + 0);
}

