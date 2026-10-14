#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ A, half_t* __restrict__ O);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const half_t* __restrict__ A, half_t* __restrict__ O) {
  extern __shared__ __align__(1024) half_t S[];
  b64vectype bar[1];
  for (int i = 0; i < 4; ++i) {
    bar[0] = memcpy_async<8>((void* __restrict__)(&(S[((((i * 256) + ((((int)threadIdx.x) >> 4) * 64)) + ((((((int)threadIdx.x) & 15) >> 1) ^ (((i & 1) * 4) + (((int)threadIdx.x) >> 4))) * 8)) + ((((int)threadIdx.x) & 1) * 4))])), (void* __restrict__)(&(A[((i * 256) + (((int)threadIdx.x) * 4))])));
    barrier_arrive_and_wait(bar[0]);
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 2; ++i_1) {
    *(uint4*)(O + ((i_1 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(S + (((i_1 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

