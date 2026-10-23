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
  float acc_o0[16];
  float acc_o1[16];
  float acc_o2[16];
  float acc_o3[16];
  *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) >> 3) * 32) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + ((((int)threadIdx.x) & 1) * 4))) = *(uint2*)(S_g + (((int)threadIdx.x) * 4));
  #pragma unroll
  for (int i = 0; i < 16; ++i) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((i * 1024) + (((int)threadIdx.x) * 8)) + 512)) = *(uint4*)(KV_g + ((i * 1024) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o0 + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o1 + (i_2 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o2 + (i_3 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 4; ++i_4) {
    float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o3 + (i_4 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  }
  __syncthreads();
  #pragma unroll
  for (int i_5 = 0; i_5 < 32; ++i_5) {
    ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) * 32) + ((((i_5 >> 4) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((i_5 & 15) >> 3) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (i_5 & 7)) + 16896)] = ((half_t*)buf_dyn_shmem)[(((i_5 * 512) + ((int)threadIdx.x)) + 512)];
  }
  half_t A_local[4];
  half_t B_local[16];
  __syncthreads();
  for (int ki = 0; ki < 2; ++ki) {
    *(uint2*)(A_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j = 0; j < 4; ++j) {
      *(uint2*)(B_local + (j * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) >> 6) * 2048) + (j * 512)) + ((((int)threadIdx.x) & 15) * 32)) + (((((((int)threadIdx.x) & 7) >> 2) + ki) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 16896));
    }
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)acc_o0) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local) + j_1),
                    *(((float16x4*)A_local) + 0),
                    *(((float32x4*)acc_o0) + j_1));
    };
    }
  }
  __syncthreads();
  #pragma unroll
  for (int i_6 = 0; i_6 < 32; ++i_6) {
    ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) * 32) + ((((i_6 >> 4) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((i_6 & 15) >> 3) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (i_6 & 7)) + 16896)] = ((half_t*)buf_dyn_shmem)[(((i_6 * 512) + ((int)threadIdx.x)) + 640)];
  }
  half_t A_local_1[4];
  half_t B_local_1[16];
  __syncthreads();
  for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
    *(uint2*)(A_local_1 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_1) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      *(uint2*)(B_local_1 + (j_2 * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) >> 6) * 2048) + (j_2 * 512)) + ((((int)threadIdx.x) & 15) * 32)) + (((((((int)threadIdx.x) & 7) >> 2) + ki_1) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 16896));
    }
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      {
      *(((float32x4*)acc_o1) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_1) + j_3),
                    *(((float16x4*)A_local_1) + 0),
                    *(((float32x4*)acc_o1) + j_3));
    };
    }
  }
  __syncthreads();
  #pragma unroll
  for (int i_7 = 0; i_7 < 32; ++i_7) {
    ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) * 32) + ((((i_7 >> 4) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((i_7 & 15) >> 3) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (i_7 & 7)) + 16896)] = ((half_t*)buf_dyn_shmem)[(((i_7 * 512) + ((int)threadIdx.x)) + 768)];
  }
  half_t A_local_2[4];
  half_t B_local_2[16];
  __syncthreads();
  for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
    *(uint2*)(A_local_2 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_2) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      *(uint2*)(B_local_2 + (j_4 * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) >> 6) * 2048) + (j_4 * 512)) + ((((int)threadIdx.x) & 15) * 32)) + (((((((int)threadIdx.x) & 7) >> 2) + ki_2) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 16896));
    }
    for (int j_5 = 0; j_5 < 4; ++j_5) {
      {
      *(((float32x4*)acc_o2) + j_5) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_2) + j_5),
                    *(((float16x4*)A_local_2) + 0),
                    *(((float32x4*)acc_o2) + j_5));
    };
    }
  }
  __syncthreads();
  #pragma unroll
  for (int i_8 = 0; i_8 < 32; ++i_8) {
    ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) * 32) + ((((i_8 >> 4) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((i_8 & 15) >> 3) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (i_8 & 7)) + 16896)] = ((half_t*)buf_dyn_shmem)[(((i_8 * 512) + ((int)threadIdx.x)) + 896)];
  }
  half_t A_local_3[4];
  half_t B_local_3[16];
  __syncthreads();
  for (int ki_3 = 0; ki_3 < 2; ++ki_3) {
    *(uint2*)(A_local_3 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_3) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j_6 = 0; j_6 < 4; ++j_6) {
      *(uint2*)(B_local_3 + (j_6 * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) >> 6) * 2048) + (j_6 * 512)) + ((((int)threadIdx.x) & 15) * 32)) + (((((((int)threadIdx.x) & 7) >> 2) + ki_3) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 16896));
    }
    for (int j_7 = 0; j_7 < 4; ++j_7) {
      {
      *(((float32x4*)acc_o3) + j_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_3) + j_7),
                    *(((float16x4*)A_local_3) + 0),
                    *(((float32x4*)acc_o3) + j_7));
    };
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    uint2 __1;
    float4 v_ = *(float4*)(acc_o0 + (i_9 * 4));
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(Out + (((((((int)threadIdx.x) & 15) * 512) + ((((int)threadIdx.x) >> 6) * 64)) + (i_9 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4))) = __1;
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o1 + (i_9 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Out + ((((((((int)threadIdx.x) & 15) * 512) + ((((int)threadIdx.x) >> 6) * 64)) + (i_9 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + 128)) = __2;
    uint2 __3;
    float4 v__2 = *(float4*)(acc_o2 + (i_9 * 4));
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(Out + ((((((((int)threadIdx.x) & 15) * 512) + ((((int)threadIdx.x) >> 6) * 64)) + (i_9 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + 256)) = __3;
    uint2 __4;
    float4 v__3 = *(float4*)(acc_o3 + (i_9 * 4));
    ((half2*)(&__4))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
    ((half2*)(&__4))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
    *(uint2*)(Out + ((((((((int)threadIdx.x) & 15) * 512) + ((((int)threadIdx.x) >> 6) * 64)) + (i_9 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + 384)) = __4;
  }
}

