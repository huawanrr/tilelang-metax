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
  half_t Q_reg[8];
  float acc_o[8];
  float scores_sum[1];
  half_t K_reg[8];
  half_t V_reg[8];
  float acc_s[4];
  float scores_inv_sum[1];
  half_t acc_s_cast[4];
  half_t vb[8];
  half_t Output_local_cast[4];
  *(uint4*)(Q_reg + 0) = *(uint4*)(Q + (((((int)blockIdx.x) * 512) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  int raw_start = (BlockIndices[((int)blockIdx.x)] * 16);
  bool row_valid = (((0 <= raw_start) && (raw_start < 64)) && (raw_start <= ((int)blockIdx.x)));
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
  int condval_1;
  if (row_valid) {
    condval_1 = raw_start;
  } else {
    condval_1 = 0;
  }
  int condval_2;
  if (row_valid) {
    condval_2 = raw_start;
  } else {
    condval_2 = 0;
  }
  uint4 condval;
  if ((((condval_1 + (((int)threadIdx.x) & 15)) < 64) && (0 <= (condval_2 + (((int)threadIdx.x) & 15))))) {
    int64_t condval_3;
    if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)64)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
      condval_3 = ((int64_t)raw_start);
    } else {
      condval_3 = (int64_t)0;
    }
    int64_t condval_4;
    if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)64)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
      condval_4 = ((int64_t)raw_start);
    } else {
      condval_4 = (int64_t)0;
    }
    condval = *(uint4*)(K + (((condval_4 * (int64_t)32) + ((((int64_t)((int)threadIdx.x)) & (int64_t)15) * (int64_t)32)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)4) * (int64_t)8)));
  } else {
    condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
  }
  *(uint4*)(K_reg + 0) = condval;
  half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
  int condval_6;
  if (row_valid) {
    condval_6 = raw_start;
  } else {
    condval_6 = 0;
  }
  int condval_7;
  if (row_valid) {
    condval_7 = raw_start;
  } else {
    condval_7 = 0;
  }
  int condval_8;
  if ((((0 <= raw_start) && (raw_start < 64)) && (raw_start <= ((int)blockIdx.x)))) {
    condval_8 = raw_start;
  } else {
    condval_8 = 0;
  }
  int condval_9;
  if ((((0 <= raw_start) && (raw_start < 64)) && (raw_start <= ((int)blockIdx.x)))) {
    condval_9 = raw_start;
  } else {
    condval_9 = 0;
  }
  uint4 condval_5;
  if (((((((((int)threadIdx.x) >> 2) + condval_6) < 64) && (0 <= ((((int)threadIdx.x) >> 2) + condval_7))) && (0 <= ((((int)threadIdx.x) >> 2) + condval_8))) && (((((int)threadIdx.x) >> 2) + condval_9) < 64))) {
    int64_t condval_10;
    if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)64)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
      condval_10 = ((int64_t)raw_start);
    } else {
      condval_10 = (int64_t)0;
    }
    int64_t condval_11;
    if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)64)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
      condval_11 = ((int64_t)raw_start);
    } else {
      condval_11 = (int64_t)0;
    }
    condval_5 = *(uint4*)(V + ((condval_11 * (int64_t)32) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
  } else {
    condval_5 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
  }
  *(uint4*)(V_reg + 0) = condval_5;
  if (!row_valid) {
    float broadcast_var_3 = -MACART_INF_F;
    *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  } else {
    if (((int)blockIdx.x) < (raw_start + 15)) {
      #pragma unroll
      for (int i_1 = 0; i_1 < 4; ++i_1) {
        float condval_12;
        if ((((((((int)threadIdx.x) >> 4) * 4) + raw_start) + i_1) <= ((int)blockIdx.x))) {
          condval_12 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_12 = -MACART_INF_F;
        }
        acc_s[i_1] = condval_12;
      }
    } else {
      float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
    }
  }
  for (int kp = 0; kp < 2; ++kp) {
    {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + kp),
                    *(((float16x4*)Q_reg) + kp),
                    *(((float32x4*)acc_s) + 0));
    };
  }
  *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) >> 2) * 32) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(V_reg + 0);
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    acc_s[i_2] = exp2f(min((acc_s[i_2] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + acc_s[rv]);
  }
  __syncthreads();
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[256])));
  float condval_13;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_13 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_13 = 0x0p+0f/*0.000000e+00*/;
  }
  scores_inv_sum[0] = condval_13;
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    acc_s[i_3] = (acc_s[i_3] * scores_inv_sum[0]);
  }
  uint2 __1;
  float4 v_ = *(float4*)(acc_s + 0);
  ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
  ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
  *(uint2*)(acc_s_cast + 0) = __1;
  __syncthreads();
  for (int j = 0; j < 2; ++j) {
    for (int local_id = 0; local_id < 4; ++local_id) {
      vb[((j * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) >> 4) * 128) + (local_id * 32)) + ((((j * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 2) + (local_id >> 1))) * 8)) + (((int)threadIdx.x) & 7))];
    }
  }
  for (int j_1 = 0; j_1 < 2; ++j_1) {
    {
      *(((float32x4*)acc_o) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_1));
    };
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 2; ++i_4) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_4 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 512) + ((((int)threadIdx.x) & 15) * 32)) + (i_4 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

