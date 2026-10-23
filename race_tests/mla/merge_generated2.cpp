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
  float acc_o[64];
  float softmax_l[1];
  float scores_max[1];
  float acc_s[4];
  float scores_max_prev[1];
  float scores_max_clear[1];
  float scores_scale[1];
  float scores_sum[1];
  half_t S_shared_local_cast[4];
  half_t output_partial_local_cast_1[4];
  const dim3 blockIdx = tl::rasterization2DRow<10>();
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) & 63) >> 3) * 1024) + (i * 128)) + ((((int)threadIdx.x) >> 6) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((i & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (i & 1)) & 1) * 16)) + ((((((int)threadIdx.x) >> 6) + (((int)threadIdx.x) & 1)) & 1) * 8))) = *(uint4*)(Q + ((i * 1024) + (((int)threadIdx.x) * 8)));
  }
  *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((((int)threadIdx.x) >> 3) * 64) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 8192)) = *(uint4*)(Q_pe + (((int)threadIdx.x) * 8));
  #pragma unroll
  for (int i_1 = 0; i_1 < 16; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  softmax_l[0] = 0x0p+0f/*0.000000e+00*/;
  scores_max[0] = -MACART_INF_F;
  #pragma unroll
  for (int i_2 = 0; i_2 < 16; ++i_2) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((((((((((int)threadIdx.x) & 63) >> 3) * 2048) + (i_2 * 128)) + ((((int)threadIdx.x) >> 6) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((i_2 & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (i_2 & 1)) & 1) * 16)) + ((((((int)threadIdx.x) >> 6) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 9216)) = *(uint4*)(KV + (((((int)blockIdx.z) * 16384) + (i_2 * 1024)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 2; ++i_3) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((i_3 * 1024) + ((((int)threadIdx.x) >> 3) * 64)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 25600)) = *(uint4*)(K_pe + (((((int)blockIdx.z) * 2048) + (i_3 * 1024)) + (((int)threadIdx.x) * 8)));
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(acc_s + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  half_t A_local[4];
  half_t B_local[4];
  __syncthreads();
  for (int ki = 0; ki < 32; ++ki) {
    *(uint2*)(A_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((ki >> 2) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((ki & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
    *(uint2*)(B_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((ki >> 2) * 2048) + ((((int)threadIdx.x) >> 6) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + ((ki & 3) >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 9216));
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
    *(uint2*)(B_local_1 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((((int)threadIdx.x) >> 6) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (((((((int)threadIdx.x) & 7) >> 2) + (ki_1 >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki_1 & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 25600));
    {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_1) + 0),
                    *(((float16x4*)A_local_1) + 0),
                    *(((float32x4*)acc_s) + 0));
    };
  }
  scores_max_prev[0] = scores_max[0];
  scores_max[0] = -MACART_INF_F;
  scores_max_clear[0] = -MACART_INF_F;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_max_clear[0] = max(scores_max_clear[0], acc_s[rv]);
  }
  __syncthreads();
  scores_max_clear[0] = tl::AllReduce<tl::MaxOp, 128, 16, 0>::run(scores_max_clear[0], (&(((float*)buf_dyn_shmem)[12800])));
  scores_max[0] = max(scores_max[0], scores_max_clear[0]);
  scores_max[0] = max(scores_max[0], scores_max_prev[0]);
  scores_scale[0] = exp2f(((scores_max_prev[0] - scores_max[0]) * 0x1.ec709dbe8903ep-5f/*6.011229e-02*/));
  #pragma unroll
  for (int i_4 = 0; i_4 < 4; ++i_4) {
    acc_s[i_4] = exp2f(((acc_s[i_4] - scores_max[0]) * 0x1.ec709dbe8903ep-5f/*6.011229e-02*/));
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv_1 = 0; rv_1 < 4; ++rv_1) {
    scores_sum[0] = (scores_sum[0] + acc_s[rv_1]);
  }
  __syncthreads();
  scores_sum[0] = tl::AllReduce<tl::SumOp, 128, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[12800])));
  uint2 __1;
  float4 v_ = *(float4*)(acc_s + 0);
  ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
  ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
  *(uint2*)(S_shared_local_cast + 0) = __1;
  __syncthreads();
  *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((int)threadIdx.x) & 15) * 32) + ((((((int)threadIdx.x) >> 6) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 25600)) = *(uint2*)(S_shared_local_cast + 0);
  softmax_l[0] = ((softmax_l[0] * scores_scale[0]) + scores_sum[0]);
  #pragma unroll
  for (int i_5 = 0; i_5 < 64; ++i_5) {
    acc_o[i_5] = (acc_o[i_5] * scores_scale[0]);
  }
  half_t A_local_2[4];
  half_t B_local_2[64];
  __syncthreads();
  for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
    *(uint2*)(A_local_2 + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((int)threadIdx.x) & 15) * 32) + (((((((int)threadIdx.x) & 7) >> 2) + ki_2) & 1) * 16)) + (((((((int)threadIdx.x) & 63) >> 5) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 25600));
    for (int j = 0; j < 16; ++j) {
      for (int local_id = 0; local_id < 4; ++local_id) {
        B_local_2[((j * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((((((((((int)threadIdx.x) >> 6) * 8192) + ((j >> 2) * 2048)) + (ki_2 * 1024)) + (((((int)threadIdx.x) & 63) >> 4) * 256)) + (local_id * 64)) + (((((((int)threadIdx.x) & 31) >> 4) + ((j & 3) >> 1)) & 1) * 32)) + ((((local_id >> 1) + (j & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (local_id & 1)) & 1) * 8)) + (((int)threadIdx.x) & 7)) + 9216)];
      }
    }
    for (int j_1 = 0; j_1 < 16; ++j_1) {
      {
      *(((float32x4*)acc_o) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_2) + j_1),
                    *(((float16x4*)A_local_2) + 0),
                    *(((float32x4*)acc_o) + j_1));
    };
    }
  }
  #pragma unroll
  for (int i_6 = 0; i_6 < 64; ++i_6) {
    acc_o[i_6] = (acc_o[i_6] / softmax_l[0]);
  }
  softmax_l[0] = (log2f(softmax_l[0]) + (scores_max[0] * 0x1.ec709dbe8903ep-5f/*6.011229e-02*/));
  if ((((int)threadIdx.x) >> 4) == 0) {
    glse[(((((int)threadIdx.x) & 15) * 64) + ((int)blockIdx.z))] = softmax_l[0];
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 16; ++i_7) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_7 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(output_partial_local_cast_1 + 0) = __2;
    *(uint2*)(output_partial + ((((((((int)threadIdx.x) & 15) * 32768) + (((int)blockIdx.z) * 512)) + ((((int)threadIdx.x) >> 6) * 256)) + (i_7 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4))) = *(uint2*)(output_partial_local_cast_1 + 0);
  }
}

extern "C" __global__ void __launch_bounds__(128, 1) main_split_kernel_1(half_t* __restrict__ Output, const float* __restrict__ glse, const half_t* __restrict__ output_partial) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  float split_lse[16];
  float max_lse[1];
  float weight_sum[1];
  float weighted_o[64];
  float output_accum[4];
  #pragma unroll
  for (int i = 0; i < 16; ++i) {
    split_lse[i] = glse[(((((int)blockIdx.x) * 64) + (i * 4)) + (((int)threadIdx.x) >> 5))];
  }
  max_lse[0] = -MACART_INF_F;
  #pragma unroll
  for (int rv = 0; rv < 16; ++rv) {
    max_lse[0] = max(max_lse[0], split_lse[rv]);
  }
  max_lse[0] = tl::AllReduce<tl::MaxOp, 128, 32, 0>::run(max_lse[0], (&(((float*)buf_dyn_shmem)[0])));
  #pragma unroll
  for (int i_1 = 0; i_1 < 16; ++i_1) {
    split_lse[i_1] = exp2f((split_lse[i_1] - max_lse[0]));
  }
  weight_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv_1 = 0; rv_1 < 16; ++rv_1) {
    weight_sum[0] = (weight_sum[0] + split_lse[rv_1]);
  }
  __syncthreads();
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
    for (int rv_2 = 0; rv_2 < 16; ++rv_2) {
      output_accum[i_3] = (output_accum[i_3] + weighted_o[((rv_2 * 4) + i_3)]);
    }
    output_accum[i_3] = tl::AllReduce<tl::SumOp, 128, 32, 0>::run(output_accum[i_3], (&(((float*)buf_dyn_shmem)[0])));
  }
  Output[(((((int)blockIdx.x) * 512) + (((int)blockIdx.z) * 128)) + ((int)threadIdx.x))] = ((half_t)(output_accum[(((int)threadIdx.x) >> 5)] / weight_sum[0]));
}

