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
  int indices[8];
  half_t Q_reg[16];
  float acc_o[16];
  float sum_acc[4];
  float scores_sum[1];
  float inv_sum[1];
  uint ks_w0[8];
  half_t V_reg[16];
  uint ks_w1[8];
  half_t ks_mma[16];
  float acc_s[4];
  half_t acc_s_cast[4];
  half_t kb[8];
  half_t vb[16];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    indices[si] = (BlockIndices[(((((int)blockIdx.z) * 4096) + (((int)blockIdx.x) * 8)) + si)] * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.z) * 524288) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sum_acc + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  float neg_inf = -MACART_INF_F;
  #pragma unroll 2
  for (int s = 0; s < 8; ++s) {
    int i_s = indices[s];
    if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
      #pragma unroll
      for (int slot = 0; slot < 2; ++slot) {
        half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
        uint4 condval;
        if ((((((((int)threadIdx.x) >> 3) + i_s) >> 3) + slot) < 64)) {
          condval = *(uint4*)(K + ((((((int)blockIdx.z) * 32768) + (slot * 512)) + (i_s * 64)) + (((int)threadIdx.x) * 8)));
        } else {
          condval = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
        }
        *(uint4*)(((half_t*)ks_w0) + (slot * 8)) = condval;
      }
      #pragma unroll
      for (int i_2 = 0; i_2 < 2; ++i_2) {
        half_t broadcast_var_3 = half_t(0x0p+0f/*0.000000e+00*/);
        uint4 condval_1;
        if ((((((((int)threadIdx.x) >> 3) + i_s) >> 3) + i_2) < 64)) {
          condval_1 = *(uint4*)(V + ((((((int)blockIdx.z) * 32768) + (i_2 * 512)) + (i_s * 64)) + (((int)threadIdx.x) * 8)));
        } else {
          condval_1 = make_uint4(__pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3));
        }
        *(uint4*)(V_reg + (i_2 * 8)) = condval_1;
      }
    }
    __syncthreads();
    if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
      uint condval_2;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_2 = ks_w0[4];
      } else {
        condval_2 = ks_w0[0];
      }
      uint ks_cross_1_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_2, 4, 64);
      uint condval_3;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_3 = ks_w0[0];
      } else {
        condval_3 = ks_cross_1_0;
      }
      ks_w1[0] = condval_3;
      uint condval_4;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_4 = ks_cross_1_0;
      } else {
        condval_4 = ks_w0[4];
      }
      ks_w1[4] = condval_4;
      uint condval_5;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_5 = ks_w0[5];
      } else {
        condval_5 = ks_w0[1];
      }
      uint ks_cross_1_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_5, 4, 64);
      uint condval_6;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_6 = ks_w0[1];
      } else {
        condval_6 = ks_cross_1_1;
      }
      ks_w1[1] = condval_6;
      uint condval_7;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_7 = ks_cross_1_1;
      } else {
        condval_7 = ks_w0[5];
      }
      ks_w1[5] = condval_7;
      uint condval_8;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_8 = ks_w0[6];
      } else {
        condval_8 = ks_w0[2];
      }
      uint ks_cross_1_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_8, 4, 64);
      uint condval_9;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_9 = ks_w0[2];
      } else {
        condval_9 = ks_cross_1_2;
      }
      ks_w1[2] = condval_9;
      uint condval_10;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_10 = ks_cross_1_2;
      } else {
        condval_10 = ks_w0[6];
      }
      ks_w1[6] = condval_10;
      uint condval_11;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_11 = ks_w0[7];
      } else {
        condval_11 = ks_w0[3];
      }
      uint ks_cross_1_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_11, 4, 64);
      uint condval_12;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_12 = ks_w0[3];
      } else {
        condval_12 = ks_cross_1_3;
      }
      ks_w1[3] = condval_12;
      uint condval_13;
      if (((((int)threadIdx.x) & 4) == 0)) {
        condval_13 = ks_cross_1_3;
      } else {
        condval_13 = ks_w0[7];
      }
      ks_w1[7] = condval_13;
      ((uint*)ks_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[0], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      ((uint*)ks_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[1], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      ((uint*)ks_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[2], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      ((uint*)ks_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[3], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      ((uint*)ks_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[4], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      ((uint*)ks_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[5], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      ((uint*)ks_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[6], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      ((uint*)ks_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, ks_w1[7], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
      if (((int)blockIdx.x) < (i_s + 15)) {
        #pragma unroll
        for (int i_3 = 0; i_3 < 4; ++i_3) {
          float condval_14;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_3) <= ((int)blockIdx.x))) {
            condval_14 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_14 = neg_inf;
          }
          acc_s[i_3] = condval_14;
        }
      } else {
        float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
      }
      #pragma unroll
      for (int ki = 0; ki < 2; ++ki) {
        *(uint4*)(kb + 0) = *(uint4*)(ks_mma + (ki * 8));
        for (int kp = 0; kp < 2; ++kp) {
          {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + kp),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_4 = 0; i_4 < 2; ++i_4) {
        *(uint4*)(((half_t*)buf_dyn_shmem) + ((i_4 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_reg + (i_4 * 8));
      }
      #pragma unroll
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        acc_s[i_5] = exp2f(min((acc_s[i_5] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_6 = 0; i_6 < 4; ++i_6) {
        sum_acc[i_6] = (sum_acc[i_6] + acc_s[i_6]);
      }
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + 0);
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + 0) = __1;
      __syncthreads();
      for (int j = 0; j < 4; ++j) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          vb[((j * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) >> 4) * 256) + (local_id * 64)) + (j * 16)) + (((int)threadIdx.x) & 15))];
        }
      }
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)acc_o) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_1));
    };
      }
    }
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[rv]);
  }
  __syncthreads();
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[0])));
  float condval_15;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_15 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_15 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_15;
  #pragma unroll
  for (int i_7 = 0; i_7 < 16; ++i_7) {
    acc_o[i_7] = (acc_o[i_7] * inv_sum[0]);
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 4; ++i_8) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_8 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.z) * 524288) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i_8 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

