#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  half_t Q_reg[32];
  float acc_o[32];
  float scores_sum[1];
  half_t K_reg[64];
  half_t V_reg[64];
  float acc_s[8];
  float scores_inv_sum[1];
  half_t acc_s_cast[8];
  half_t vb[32];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int i_s = (BlockIndices[((int)blockIdx.x)] * 32);
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if (((((i_s + (((int)threadIdx.x) & 15)) >> 4) + (i_2 & 1)) < 32)) {
        condval = *(uint4*)(K + ((((((i_2 & 1) * 2048) + (i_s * 128)) + ((((int)threadIdx.x) & 15) * 128)) + ((i_2 >> 1) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(K_reg + (i_2 * 8)) = condval;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 8; ++i_3) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_3) < 128)) {
        condval_1 = *(uint4*)(V + (((i_3 * 512) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(V_reg + (i_3 * 8)) = condval_1;
    }
    if (((int)blockIdx.x) < (i_s + 31)) {
      #pragma unroll
      for (int i_4 = 0; i_4 < 8; ++i_4) {
        float condval_2;
        if (((((((i_4 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_s) + (i_4 & 3)) <= ((int)blockIdx.x))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        acc_s[i_4] = condval_2;
      }
    } else {
      #pragma unroll
      for (int i_5 = 0; i_5 < 2; ++i_5) {
        float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + (i_5 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
      }
    }
    for (int ki = 0; ki < 4; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        for (int j = 0; j < 2; ++j) {
          {
      *(((float32x4*)acc_s) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + (((ki * 4) + (j * 2)) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + j));
    };
        }
      }
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_6 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_6 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(V_reg + (i_6 * 8));
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 8; ++i_7) {
      acc_s[i_7] = exp2f(min((acc_s[i_7] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int rv = 0; rv < 8; ++rv) {
      scores_sum[0] = (scores_sum[0] + acc_s[(((rv & 1) * 4) + (rv >> 1))]);
    }
    scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[2048])));
    float condval_3;
    if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
      condval_3 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
    } else {
      condval_3 = 0x0p+0f/*0.000000e+00*/;
    }
    scores_inv_sum[0] = condval_3;
    #pragma unroll
    for (int i_8 = 0; i_8 < 8; ++i_8) {
      acc_s[i_8] = (acc_s[i_8] * scores_inv_sum[0]);
    }
    #pragma unroll
    for (int i_9 = 0; i_9 < 2; ++i_9) {
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + (i_9 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + (i_9 * 4)) = __1;
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_1 = 0; j_1 < 8; ++j_1) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          vb[((j_1 * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((ki_1 * 2048) + ((((int)threadIdx.x) >> 4) * 512)) + (local_id * 128)) + ((((j_1 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ (((((int)threadIdx.x) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int j_2 = 0; j_2 < 8; ++j_2) {
        {
      *(((float32x4*)acc_o) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_2),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_o) + j_2));
    };
      }
    }
  }
  #pragma unroll
  for (int i_10 = 0; i_10 < 8; ++i_10) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_10 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + (i_10 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

