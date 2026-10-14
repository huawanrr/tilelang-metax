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
  b128vectype bar[1];
  for (int step = 0; step < 2; ++step) {
    bar[0] = memcpy_async<16>((void* __restrict__)(&(S[(((step * 512) + ((((int)threadIdx.x) >> 3) * 64)) + ((((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) ^ (((int)threadIdx.x) >> 3)) * 8))])), (void* __restrict__)(&(A[(((step * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))])));
  }
  barrier_arrive_and_wait(bar[0]);
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(O + ((i * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(S + (((i * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

