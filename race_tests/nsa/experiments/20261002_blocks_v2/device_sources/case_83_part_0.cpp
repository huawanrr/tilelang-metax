#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[32];
  half_t packed_v[32];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + (((((int)blockIdx.x) * 4096) + (i * 1024)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    *(uint4*)(PackedK + ((((((((int)blockIdx.x) * 4096) + (((((int)threadIdx.x) & 15) >> 2) * 1024)) + ((i_1 >> 1) * 512)) + ((((int)threadIdx.x) & 3) * 128)) + ((i_1 & 1) * 64)) + ((((int)threadIdx.x) >> 4) * 8))) = *(uint4*)(ktile + (i_1 * 8));
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 32; ++i_2) {
    packed_v[i_2] = V[((((((((((int)blockIdx.x) * 4096) + ((i_2 >> 4) * 2048)) + (((((int)threadIdx.x) & 63) >> 4) * 512)) + ((i_2 & 3) * 128)) + (((i_2 & 15) >> 3) * 64)) + ((((int)threadIdx.x) >> 6) * 32)) + (((i_2 & 7) >> 2) * 16)) + (((int)threadIdx.x) & 15))];
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    *(uint4*)(Packed + (((((int)blockIdx.x) * 4096) + (i_3 * 1024)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_v + (i_3 * 8));
  }
}

