#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void main_split_kernel(const half_t* __restrict__ KV, const half_t* __restrict__ K_pe, const half_t* __restrict__ Q, const half_t* __restrict__ Q_pe, float* __restrict__ glse, half_t* __restrict__ output_partial);
extern "C" __global__ void main_split_kernel_1(half_t* __restrict__ Output, const float* __restrict__ glse, const half_t* __restrict__ output_partial);
extern "C" __global__ void __launch_bounds__(128, 1) main_split_kernel(const half_t* __restrict__ KV, const half_t* __restrict__ K_pe, const half_t* __restrict__ Q, const half_t* __restrict__ Q_pe, float* __restrict__ glse, half_t* __restrict__ output_partial) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  float acc_o0[16];
  float acc_o1[16];
  float acc_o2[16];
  float acc_o3[16];
  float softmax_l[1];
  float acc_s[4];
  half_t acc_h[4];
  float scores_sum[1];
  half_t S_shared_local_cast[4];
  half_t output_partial_local_cast_1[4];
  half_t output_partial_local_cast_2[4];
  half_t output_partial_local_cast_3[4];
  half_t output_partial_local_cast_4[4];
  const dim3 blockIdx = tl::rasterization2DRow<10>();
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) & 63) >> 3) * 1024) + (i * 128)) + ((((int)threadIdx.x) >> 6) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((i & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (i & 1)) & 1) * 16)) + ((((((int)threadIdx.x) >> 6) + (((int)threadIdx.x) & 1)) & 1) * 8))) = *(uint4*)(Q + ((i * 1024) + (((int)threadIdx.x) * 8)));
  }
  *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((((int)threadIdx.x) >> 3) * 64) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 8192)) = *(uint4*)(Q_pe + (((int)threadIdx.x) * 8));
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
  softmax_l[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((i_5 * 1024) + ((((int)threadIdx.x) >> 3) * 64)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 9216)) = *(uint4*)(K_pe + (((((int)blockIdx.z) * 2048) + (i_5 * 1024)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_6 = 0; i_6 < 16; ++i_6) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((((((((((int)threadIdx.x) & 63) >> 3) * 2048) + (i_6 * 128)) + ((((int)threadIdx.x) >> 6) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((i_6 & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (i_6 & 1)) & 1) * 16)) + ((((((int)threadIdx.x) >> 6) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 11264)) = *(uint4*)(KV + (((((int)blockIdx.z) * 16384) + (i_6 * 1024)) + (((int)threadIdx.x) * 8)));
  }
  float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(acc_s + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
  half_t A_local[4];
  half_t B_local[4];
  __syncthreads();
  for (int ki = 0; ki < 32; ++ki) {
    *(uint2*)(A_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((ki >> 2) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((ki & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    *(uint2*)(B_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((ki >> 2) * 2048) + ((((int)threadIdx.x) >> 6) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((ki & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 11264));
    {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local) + 0),
                    *(((float16x4*)A_local) + 0),
                    *(((float32x4*)acc_s) + 0));
    };
  }
  half_t A_local_1[4];
  half_t B_local_1[4];
  for (int ki_1 = 0; ki_1 < 4; ++ki_1) {
    *(uint2*)(A_local_1 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((int)threadIdx.x) & 15) * 64) + (((((((int)threadIdx.x) & 7) >> 2) + (ki_1 >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki_1 & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 8192));
    *(uint2*)(B_local_1 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) >> 6) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + (ki_1 >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki_1 & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 9216));
    {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_1) + 0),
                    *(((float16x4*)A_local_1) + 0),
                    *(((float32x4*)acc_s) + 0));
    };
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 4; ++i_7) {
    acc_s[i_7] = exp2f(min((acc_s[i_7] * 0x1.ec709dbe8903ep-5f/*6.011229e-02*/), 0x1.ep+3f/*1.500000e+01*/));
  }
  uint2 __1;
  float4 v_ = *(float4*)(acc_s + 0);
  ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
  ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
  *(uint2*)(acc_h + 0) = __1;
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + ((float)acc_h[rv]));
  }
  __syncthreads();
  scores_sum[0] = tl::AllReduce<tl::SumOp, 128, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[0])));
  softmax_l[0] = (softmax_l[0] + scores_sum[0]);
  uint2 __2;
  float4 v__1 = *(float4*)(acc_s + 0);
  ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
  ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
  *(uint2*)(S_shared_local_cast + 0) = __2;
  __syncthreads();
  *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + ((((((int)threadIdx.x) >> 6) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(S_shared_local_cast + 0);
  #pragma unroll
  for (int i_8 = 0; i_8 < 32; ++i_8) {
    __syncthreads();
    ((half_t*)buf_dyn_shmem)[((((((int)threadIdx.x) * 32) + (((i_8 >> 3) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (i_8 & 7)) + 512)] = ((half_t*)buf_dyn_shmem)[((((((((((int)threadIdx.x) >> 6) * 2048) + (i_8 * 64)) + (((((((int)threadIdx.x) & 63) >> 5) + ((i_8 & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((i_8 & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (i_8 & 1)) & 1) * 8)) + (((int)threadIdx.x) & 7)) + 11264)];
  }
  half_t A_local_2[4];
  half_t B_local_2[16];
  __syncthreads();
  for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
    *(uint2*)(A_local_2 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_2) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j = 0; j < 4; ++j) {
      *(uint2*)(B_local_2 + (j * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((int)threadIdx.x) >> 6) * 2048) + (j * 512)) + ((((int)threadIdx.x) & 15) * 32)) + ((((ki_2 * 2) + ((((int)threadIdx.x) & 63) >> 5)) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 512));
    }
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)acc_o0) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_2) + j_1),
                    *(((float16x4*)A_local_2) + 0),
                    *(((float32x4*)acc_o0) + j_1));
    };
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 32; ++i_9) {
    __syncthreads();
    ((half_t*)buf_dyn_shmem)[((((((int)threadIdx.x) * 32) + (((i_9 >> 3) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (i_9 & 7)) + 512)] = ((half_t*)buf_dyn_shmem)[((((((((((int)threadIdx.x) >> 6) * 2048) + (i_9 * 64)) + (((((((int)threadIdx.x) & 63) >> 5) + ((i_9 & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((i_9 & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (i_9 & 1)) & 1) * 8)) + (((int)threadIdx.x) & 7)) + 15360)];
  }
  half_t A_local_3[4];
  half_t B_local_3[16];
  __syncthreads();
  for (int ki_3 = 0; ki_3 < 2; ++ki_3) {
    *(uint2*)(A_local_3 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_3) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      *(uint2*)(B_local_3 + (j_2 * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((int)threadIdx.x) >> 6) * 2048) + (j_2 * 512)) + ((((int)threadIdx.x) & 15) * 32)) + ((((ki_3 * 2) + ((((int)threadIdx.x) & 63) >> 5)) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 512));
    }
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      {
      *(((float32x4*)acc_o1) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_3) + j_3),
                    *(((float16x4*)A_local_3) + 0),
                    *(((float32x4*)acc_o1) + j_3));
    };
    }
  }
  #pragma unroll
  for (int i_10 = 0; i_10 < 32; ++i_10) {
    __syncthreads();
    ((half_t*)buf_dyn_shmem)[((((((int)threadIdx.x) * 32) + (((i_10 >> 3) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (i_10 & 7)) + 512)] = ((half_t*)buf_dyn_shmem)[((((((((((int)threadIdx.x) >> 6) * 2048) + (i_10 * 64)) + (((((((int)threadIdx.x) & 63) >> 5) + ((i_10 & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((i_10 & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (i_10 & 1)) & 1) * 8)) + (((int)threadIdx.x) & 7)) + 19456)];
  }
  half_t A_local_4[4];
  half_t B_local_4[16];
  __syncthreads();
  for (int ki_4 = 0; ki_4 < 2; ++ki_4) {
    *(uint2*)(A_local_4 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_4) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      *(uint2*)(B_local_4 + (j_4 * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((int)threadIdx.x) >> 6) * 2048) + (j_4 * 512)) + ((((int)threadIdx.x) & 15) * 32)) + ((((ki_4 * 2) + ((((int)threadIdx.x) & 63) >> 5)) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 512));
    }
    for (int j_5 = 0; j_5 < 4; ++j_5) {
      {
      *(((float32x4*)acc_o2) + j_5) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_4) + j_5),
                    *(((float16x4*)A_local_4) + 0),
                    *(((float32x4*)acc_o2) + j_5));
    };
    }
  }
  #pragma unroll
  for (int i_11 = 0; i_11 < 32; ++i_11) {
    __syncthreads();
    ((half_t*)buf_dyn_shmem)[((((((int)threadIdx.x) * 32) + (((i_11 >> 3) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (i_11 & 7)) + 512)] = ((half_t*)buf_dyn_shmem)[((((((((((int)threadIdx.x) >> 6) * 2048) + (i_11 * 64)) + (((((((int)threadIdx.x) & 63) >> 5) + ((i_11 & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((i_11 & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (i_11 & 1)) & 1) * 8)) + (((int)threadIdx.x) & 7)) + 23552)];
  }
  half_t A_local_5[4];
  half_t B_local_5[16];
  __syncthreads();
  for (int ki_5 = 0; ki_5 < 2; ++ki_5) {
    *(uint2*)(A_local_5 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_5) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    for (int j_6 = 0; j_6 < 4; ++j_6) {
      *(uint2*)(B_local_5 + (j_6 * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((int)threadIdx.x) >> 6) * 2048) + (j_6 * 512)) + ((((int)threadIdx.x) & 15) * 32)) + ((((ki_5 * 2) + ((((int)threadIdx.x) & 63) >> 5)) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 512));
    }
    for (int j_7 = 0; j_7 < 4; ++j_7) {
      {
      *(((float32x4*)acc_o3) + j_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_5) + j_7),
                    *(((float16x4*)A_local_5) + 0),
                    *(((float32x4*)acc_o3) + j_7));
    };
    }
  }
  #pragma unroll
  for (int i_12 = 0; i_12 < 16; ++i_12) {
    acc_o0[i_12] = (acc_o0[i_12] / softmax_l[0]);
  }
  #pragma unroll
  for (int i_13 = 0; i_13 < 16; ++i_13) {
    acc_o1[i_13] = (acc_o1[i_13] / softmax_l[0]);
  }
  #pragma unroll
  for (int i_14 = 0; i_14 < 16; ++i_14) {
    acc_o2[i_14] = (acc_o2[i_14] / softmax_l[0]);
  }
  #pragma unroll
  for (int i_15 = 0; i_15 < 16; ++i_15) {
    acc_o3[i_15] = (acc_o3[i_15] / softmax_l[0]);
  }
  softmax_l[0] = log2f(softmax_l[0]);
  if ((((int)threadIdx.x) >> 4) == 0) {
    glse[(((((int)threadIdx.x) & 15) * 64) + ((int)blockIdx.z))] = softmax_l[0];
  }
  #pragma unroll
  for (int i_16 = 0; i_16 < 4; ++i_16) {
    uint2 __3;
    float4 v__2 = *(float4*)(acc_o0 + (i_16 * 4));
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(output_partial_local_cast_1 + 0) = __3;
    *(uint2*)(output_partial + ((((((((int)threadIdx.x) & 15) * 32768) + (((int)blockIdx.z) * 512)) + ((((int)threadIdx.x) >> 6) * 64)) + (i_16 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4))) = *(uint2*)(output_partial_local_cast_1 + 0);
  }
  #pragma unroll
  for (int i_17 = 0; i_17 < 4; ++i_17) {
    uint2 __4;
    float4 v__3 = *(float4*)(acc_o1 + (i_17 * 4));
    ((half2*)(&__4))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
    ((half2*)(&__4))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
    *(uint2*)(output_partial_local_cast_2 + 0) = __4;
    *(uint2*)(output_partial + (((((((((int)threadIdx.x) & 15) * 32768) + (((int)blockIdx.z) * 512)) + ((((int)threadIdx.x) >> 6) * 64)) + (i_17 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + 128)) = *(uint2*)(output_partial_local_cast_2 + 0);
  }
  #pragma unroll
  for (int i_18 = 0; i_18 < 4; ++i_18) {
    uint2 __5;
    float4 v__4 = *(float4*)(acc_o2 + (i_18 * 4));
    ((half2*)(&__5))[0] = __float22half2_rn(((float2*)(&v__4))[0]);
    ((half2*)(&__5))[1] = __float22half2_rn(((float2*)(&v__4))[1]);
    *(uint2*)(output_partial_local_cast_3 + 0) = __5;
    *(uint2*)(output_partial + (((((((((int)threadIdx.x) & 15) * 32768) + (((int)blockIdx.z) * 512)) + ((((int)threadIdx.x) >> 6) * 64)) + (i_18 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + 256)) = *(uint2*)(output_partial_local_cast_3 + 0);
  }
  #pragma unroll
  for (int i_19 = 0; i_19 < 4; ++i_19) {
    uint2 __6;
    float4 v__5 = *(float4*)(acc_o3 + (i_19 * 4));
    ((half2*)(&__6))[0] = __float22half2_rn(((float2*)(&v__5))[0]);
    ((half2*)(&__6))[1] = __float22half2_rn(((float2*)(&v__5))[1]);
    *(uint2*)(output_partial_local_cast_4 + 0) = __6;
    *(uint2*)(output_partial + (((((((((int)threadIdx.x) & 15) * 32768) + (((int)blockIdx.z) * 512)) + ((((int)threadIdx.x) >> 6) * 64)) + (i_19 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + 384)) = *(uint2*)(output_partial_local_cast_4 + 0);
  }
}

extern "C" __global__ void __launch_bounds__(128, 1) main_split_kernel_1(half_t* __restrict__ Output, const float* __restrict__ glse, const half_t* __restrict__ output_partial) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  float split_lse[16];
  float weight_sum[1];
  float weighted_o[64];
  float output_accum[4];
  #pragma unroll
  for (int i = 0; i < 16; ++i) {
    split_lse[i] = glse[(((((int)blockIdx.x) * 64) + (i * 4)) + (((int)threadIdx.x) >> 5))];
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 16; ++i_1) {
    split_lse[i_1] = exp2f(split_lse[i_1]);
  }
  weight_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 16; ++rv) {
    weight_sum[0] = (weight_sum[0] + split_lse[rv]);
  }
  weight_sum[0] = tl::AllReduce<tl::SumOp, 128, 32, 0>::run(weight_sum[0], (&(((float*)buf_dyn_shmem)[0])));
  #pragma unroll
  for (int i_2 = 0; i_2 < 64; ++i_2) {
    weighted_o[i_2] = (((float)output_partial[((((((((int)blockIdx.x) * 32768) + ((i_2 >> 2) * 2048)) + ((((int)threadIdx.x) >> 5) * 512)) + (((int)blockIdx.z) * 128)) + ((i_2 & 3) * 32)) + (((int)threadIdx.x) & 31))]) * split_lse[(i_2 >> 2)]);
  }
  __syncthreads();
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    output_accum[i_3] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int rv_1 = 0; rv_1 < 16; ++rv_1) {
      output_accum[i_3] = (output_accum[i_3] + weighted_o[((rv_1 * 4) + i_3)]);
    }
    output_accum[i_3] = tl::AllReduce<tl::SumOp, 128, 32, 0>::run(output_accum[i_3], (&(((float*)buf_dyn_shmem)[0])));
  }
  Output[(((((int)blockIdx.x) * 512) + (((int)blockIdx.z) * 128)) + ((int)threadIdx.x))] = ((half_t)(output_accum[(((int)threadIdx.x) >> 5)] / weight_sum[0]));
}

