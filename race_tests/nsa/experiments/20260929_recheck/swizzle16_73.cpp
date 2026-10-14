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
  half_t K_reg[32];
  half_t V_reg[32];
  float acc_s[4];
  float scores_inv_sum[1];
  half_t acc_s_cast[4];
  half_t kb[8];
  half_t vb[32];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 4096) + (((int)blockIdx.z) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int i_s = (BlockIndices[((((int)blockIdx.x) * 2) + ((int)blockIdx.z))] * 16);
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_2) < 128)) {
        condval = *(uint4*)(K + (((((i_2 * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + (i_s * 256)) + (((int)blockIdx.z) * 128)) + ((((int)threadIdx.x) & 15) * 8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(K_reg + (i_2 * 8)) = condval;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_3) < 128)) {
        condval_1 = *(uint4*)(V + (((((i_3 * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + (i_s * 256)) + (((int)blockIdx.z) * 128)) + ((((int)threadIdx.x) & 15) * 8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(V_reg + (i_3 * 8)) = condval_1;
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 4; ++i_4) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((((i_4 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + ((((((int)threadIdx.x) & 15) >> 1) ^ (((i_4 & 1) * 4) + (((int)threadIdx.x) >> 4))) * 16)) + ((((int)threadIdx.x) & 1) * 8))) = *(uint4*)(K_reg + (i_4 * 8));
    }
    if (((int)blockIdx.x) < (i_s + 15)) {
      #pragma unroll
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        float condval_2;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_5) <= ((int)blockIdx.x))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        acc_s[i_5] = condval_2;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    for (int ki = 0; ki < 4; ++ki) {
      *(uint4*)(kb + 0) = *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((ki * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 16)) + (((((int)threadIdx.x) & 31) >> 4) * 8)));
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + kp),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((((i_6 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + ((((((int)threadIdx.x) & 15) >> 1) ^ (((i_6 & 1) * 4) + (((int)threadIdx.x) >> 4))) * 16)) + ((((int)threadIdx.x) & 1) * 8))) = *(uint4*)(V_reg + (i_6 * 8));
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      acc_s[i_7] = exp2f(min((acc_s[i_7] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int rv = 0; rv < 4; ++rv) {
      scores_sum[0] = (scores_sum[0] + acc_s[rv]);
    }
    scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[1024])));
    float condval_3;
    if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
      condval_3 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
    } else {
      condval_3 = 0x0p+0f/*0.000000e+00*/;
    }
    scores_inv_sum[0] = condval_3;
    #pragma unroll
    for (int i_8 = 0; i_8 < 4; ++i_8) {
      acc_s[i_8] = (acc_s[i_8] * scores_inv_sum[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + 0) = __1;
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
    for (int j = 0; j < 8; ++j) {
      for (int local_id = 0; local_id < 4; ++local_id) {
        vb[((j * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) >> 4) * 512) + (local_id * 128)) + ((j ^ ((((((int)threadIdx.x) & 31) >> 4) * 4) + local_id)) * 16)) + (((int)threadIdx.x) & 15))];
      }
    }
    for (int j_1 = 0; j_1 < 8; ++j_1) {
      {
      *(((float32x4*)acc_o) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_1));
    };
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 8; ++i_9) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_9 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.x) * 4096) + (((int)blockIdx.z) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

