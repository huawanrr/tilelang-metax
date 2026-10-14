#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  half_t ktile[16];
  half_t tile[16];
  half_t packed_k[16];
  half_t packed_v[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + (((((((((int)blockIdx.x) >> 1) * 4096) + (i * 2048)) + ((((int)threadIdx.x) >> 3) * 256)) + (((int)blockIdx.y) * 128)) + ((((int)blockIdx.x) & 1) * 64)) + ((((int)threadIdx.x) & 7) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 2; ++i_1) {
    *(uint4*)(tile + (i_1 * 8)) = *(uint4*)(V + (((((((((int)blockIdx.x) >> 1) * 4096) + (i_1 * 2048)) + ((((int)threadIdx.x) >> 3) * 256)) + (((int)blockIdx.y) * 128)) + ((((int)blockIdx.x) & 1) * 64)) + ((((int)threadIdx.x) & 7) * 8)));
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 2; ++i_2) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_2 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(ktile + (i_2 * 8));
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + (((((i_3 >> 1) * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((((int)threadIdx.x) & 7) * 2) + (i_3 & 1)) ^ (((i_3 >> 1) * 8) + (((int)threadIdx.x) >> 3))) * 4)) + 1024)) = *(uint2*)(tile + (i_3 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_4 = 0; i_4 < 2; ++i_4) {
    *(uint4*)(packed_k + (i_4 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 64) + ((((i_4 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 16; ++i_5) {
    packed_v[i_5] = ((half_t*)buf_dyn_shmem)[((((((((int)threadIdx.x) >> 4) * 256) + ((i_5 & 3) * 64)) + (((((i_5 >> 2) * 4) + ((((int)threadIdx.x) & 15) >> 2)) ^ (((((int)threadIdx.x) >> 4) * 4) + (i_5 & 3))) * 4)) + (((int)threadIdx.x) & 3)) + 1024)];
  }
  #pragma unroll
  for (int i_6 = 0; i_6 < 2; ++i_6) {
    *(uint4*)(PackedK + (((((((((int)blockIdx.x) >> 2) * 8192) + (((int)blockIdx.y) * 4096)) + ((((int)blockIdx.x) & 1) * 2048)) + (i_6 * 1024)) + (((((int)blockIdx.x) & 3) >> 1) * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_k + (i_6 * 8));
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 2; ++i_7) {
    *(uint4*)(Packed + ((((((((int)blockIdx.x) >> 2) * 8192) + (((int)blockIdx.y) * 4096)) + ((((int)blockIdx.x) & 3) * 1024)) + (i_7 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_v + (i_7 * 8));
  }
}

