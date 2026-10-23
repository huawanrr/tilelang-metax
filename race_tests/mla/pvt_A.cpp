#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kern_kernel(const half_t* __restrict__ KV_g, half_t* __restrict__ Out, const half_t* __restrict__ S_g);
extern "C" __global__ void __launch_bounds__(128, 1) kern_kernel(const half_t* __restrict__ KV_g, half_t* __restrict__ Out, const half_t* __restrict__ S_g) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  float acc_o[64];
  half_t Out_local_cast[4];
  *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) >> 3) * 32) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + ((((int)threadIdx.x) & 1) * 4))) = *(uint2*)(S_g + (((int)threadIdx.x) * 4));
  #pragma unroll
  for (int i = 0; i < 16; ++i) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((((((((((int)threadIdx.x) & 63) >> 3) * 2048) + (i * 128)) + ((((int)threadIdx.x) >> 6) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((i & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (i & 1)) & 1) * 16)) + ((((((int)threadIdx.x) >> 6) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 512)) = *(uint4*)(KV_g + ((i * 1024) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 16; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  half_t A_local[4];
  half_t B_local[64];
  __syncthreads();
  for (int ki = 0; ki < 2; ++ki) {
    *(uint2*)(A_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j = 0; j < 16; ++j) {
      for (int local_id = 0; local_id < 4; ++local_id) {
        B_local[((j * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((((((((((int)threadIdx.x) >> 6) * 8192) + ((j >> 2) * 2048)) + (ki * 1024)) + (((((int)threadIdx.x) & 63) >> 4) * 256)) + (local_id * 64)) + (((((((int)threadIdx.x) & 31) >> 4) + ((j & 3) >> 1)) & 1) * 32)) + ((((local_id >> 1) + (j & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (local_id & 1)) & 1) * 8)) + (((int)threadIdx.x) & 7)) + 512)];
      }
    }
    for (int j_1 = 0; j_1 < 16; ++j_1) {
      {
      *(((float32x4*)acc_o) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local) + j_1),
                    *(((float16x4*)A_local) + 0),
                    *(((float32x4*)acc_o) + j_1));
    };
    }
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 16; ++i_2) {
    uint2 __1;
    float4 v_ = *(float4*)(acc_o + (i_2 * 4));
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(Out_local_cast + 0) = __1;
    *(uint2*)(Out + (((((((int)threadIdx.x) & 15) * 512) + ((((int)threadIdx.x) >> 6) * 256)) + (i_2 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4))) = *(uint2*)(Out_local_cast + 0);
  }
}

