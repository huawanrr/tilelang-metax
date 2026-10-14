#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(256, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[16];
  half_t tile[16];
  extern __shared__ __align__(1024) half_t v_shared[];
  half_t packed_v[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + ((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 4096)) + (i * 2048)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 2; ++i_1) {
    *(uint4*)(PackedK + ((((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 4096)) + (((((int)threadIdx.x) & 15) >> 2) * 1024)) + (i_1 * 512)) + ((((int)threadIdx.x) & 3) * 128)) + ((((int)threadIdx.x) >> 4) * 8))) = *(uint4*)(ktile + (i_1 * 8));
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 2; ++i_2) {
    *(uint4*)(tile + (i_2 * 8)) = *(uint4*)(V + ((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 4096)) + (i_2 * 2048)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    *(uint2*)(v_shared + ((((i_3 >> 1) * 2048) + ((((int)threadIdx.x) >> 4) * 128)) + (((((((int)threadIdx.x) & 15) * 2) + (i_3 & 1)) ^ (((int)threadIdx.x) >> 4)) * 4))) = *(uint2*)(tile + (i_3 * 4));
  }
  __syncthreads();
  #pragma unroll
  for (int i_4 = 0; i_4 < 16; ++i_4) {
    packed_v[i_4] = v_shared[((((((i_4 >> 3) * 2048) + (((((int)threadIdx.x) & 63) >> 4) * 512)) + ((i_4 & 3) * 128)) + ((((((((int)threadIdx.x) >> 6) * 8) + (((i_4 & 7) >> 2) * 4)) + ((((int)threadIdx.x) & 15) >> 2)) ^ ((((((int)threadIdx.x) & 63) >> 4) * 4) + (i_4 & 3))) * 4)) + (((int)threadIdx.x) & 3))];
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    *(uint4*)(Packed + ((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 4096)) + (i_5 * 2048)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_v + (i_5 * 8));
  }
}

