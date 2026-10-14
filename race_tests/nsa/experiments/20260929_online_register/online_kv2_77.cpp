#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  int indices[4];
  half_t Q_reg[16];
  float acc_o[16];
  float sum_acc[4];
  float scores_sum[1];
  float inv_sum[1];
  uint ks_w0[8];
  uint vs_w0[8];
  uint ks_w1[8];
  half_t ks_mma[16];
  float acc_s[4];
  uint vs_w1[8];
  uint vs_w2[8];
  half_t vs_mma[16];
  half_t acc_s_cast[4];
  half_t kb[8];
  half_t vb[16];
  extern __shared__ __align__(1024) float workspace[];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int si = 0; si < 4; ++si) {
    indices[si] = (BlockIndices[((((int)blockIdx.x) * 4) + si)] * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
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
  for (int s = 0; s < 4; ++s) {
    int i_s = indices[s];
    if (((0 <= i_s) && (i_s < 256)) && (i_s <= ((int)blockIdx.x))) {
      #pragma unroll
      for (int slot = 0; slot < 2; ++slot) {
        half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
        uint4 condval;
        if ((((((((int)threadIdx.x) >> 3) + i_s) >> 3) + slot) < 32)) {
          condval = *(uint4*)(K + (((slot * 512) + (i_s * 64)) + (((int)threadIdx.x) * 8)));
        } else {
          condval = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
        }
        *(uint4*)(((half_t*)ks_w0) + (slot * 8)) = condval;
      }
      #pragma unroll
      for (int slot_1 = 0; slot_1 < 8; ++slot_1) {
        half_t broadcast_var_3 = half_t(0x0p+0f/*0.000000e+00*/);
        uint1 condval_1;
        if ((((((int)threadIdx.x) >> 4) + (((slot_1 >> 1) + i_s) >> 2)) < 64)) {
          condval_1 = *(uint1*)(V + (((((((int)threadIdx.x) >> 4) * 256) + (i_s * 64)) + (slot_1 * 32)) + ((((int)threadIdx.x) & 15) * 2)));
        } else {
          condval_1 = make_uint1(__pack_half2(broadcast_var_3, broadcast_var_3));
        }
        *(uint1*)(((half_t*)vs_w0) + (slot_1 * 2)) = condval_1;
      }
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
        for (int i_2 = 0; i_2 < 4; ++i_2) {
          float condval_14;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_2) <= ((int)blockIdx.x))) {
            condval_14 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_14 = neg_inf;
          }
          acc_s[i_2] = condval_14;
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
      vs_w1[0] = ((vs_w0[0] & (uint)65535) | (vs_w0[2] << (uint)16));
      vs_w1[2] = ((vs_w0[0] >> (uint)16) | (vs_w0[2] & (uint)4294901760));
      vs_w1[1] = ((vs_w0[1] & (uint)65535) | (vs_w0[3] << (uint)16));
      vs_w1[3] = ((vs_w0[1] >> (uint)16) | (vs_w0[3] & (uint)4294901760));
      vs_w1[4] = ((vs_w0[4] & (uint)65535) | (vs_w0[6] << (uint)16));
      vs_w1[6] = ((vs_w0[4] >> (uint)16) | (vs_w0[6] & (uint)4294901760));
      vs_w1[5] = ((vs_w0[5] & (uint)65535) | (vs_w0[7] << (uint)16));
      vs_w1[7] = ((vs_w0[5] >> (uint)16) | (vs_w0[7] & (uint)4294901760));
      uint condval_15;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_15 = vs_w1[2];
      } else {
        condval_15 = vs_w1[0];
      }
      uint vs_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_15, 8, 64);
      uint condval_16;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_16 = vs_w1[0];
      } else {
        condval_16 = vs_cross_2_0;
      }
      vs_w2[0] = condval_16;
      uint condval_17;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_17 = vs_cross_2_0;
      } else {
        condval_17 = vs_w1[2];
      }
      vs_w2[2] = condval_17;
      uint condval_18;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_18 = vs_w1[3];
      } else {
        condval_18 = vs_w1[1];
      }
      uint vs_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_18, 8, 64);
      uint condval_19;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_19 = vs_w1[1];
      } else {
        condval_19 = vs_cross_2_1;
      }
      vs_w2[1] = condval_19;
      uint condval_20;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_20 = vs_cross_2_1;
      } else {
        condval_20 = vs_w1[3];
      }
      vs_w2[3] = condval_20;
      uint condval_21;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_21 = vs_w1[6];
      } else {
        condval_21 = vs_w1[4];
      }
      uint vs_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_21, 8, 64);
      uint condval_22;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_22 = vs_w1[4];
      } else {
        condval_22 = vs_cross_2_4;
      }
      vs_w2[4] = condval_22;
      uint condval_23;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_23 = vs_cross_2_4;
      } else {
        condval_23 = vs_w1[6];
      }
      vs_w2[6] = condval_23;
      uint condval_24;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_24 = vs_w1[7];
      } else {
        condval_24 = vs_w1[5];
      }
      uint vs_cross_2_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_24, 8, 64);
      uint condval_25;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_25 = vs_w1[5];
      } else {
        condval_25 = vs_cross_2_5;
      }
      vs_w2[5] = condval_25;
      uint condval_26;
      if (((((int)threadIdx.x) & 8) == 0)) {
        condval_26 = vs_cross_2_5;
      } else {
        condval_26 = vs_w1[7];
      }
      vs_w2[7] = condval_26;
      ((uint*)vs_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[0], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      ((uint*)vs_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[4], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      ((uint*)vs_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[2], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      ((uint*)vs_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[6], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      ((uint*)vs_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[1], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      ((uint*)vs_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[5], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      ((uint*)vs_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[3], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      ((uint*)vs_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[7], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
      #pragma unroll
      for (int i_3 = 0; i_3 < 4; ++i_3) {
        acc_s[i_3] = exp2f(min((acc_s[i_3] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_4 = 0; i_4 < 4; ++i_4) {
        sum_acc[i_4] = (sum_acc[i_4] + acc_s[i_4]);
      }
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + 0);
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + 0) = __1;
      for (int e = 0; e < 2; ++e) {
        *(uint4*)(vb + (e * 8)) = *(uint4*)(vs_mma + (e * 8));
      }
      for (int j = 0; j < 4; ++j) {
        {
      *(((float32x4*)acc_o) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j));
    };
      }
    }
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[rv]);
  }
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(workspace[0])));
  float condval_27;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_27 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_27 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_27;
  #pragma unroll
  for (int i_5 = 0; i_5 < 16; ++i_5) {
    acc_o[i_5] = (acc_o[i_5] * inv_sum[0]);
  }
  #pragma unroll
  for (int i_6 = 0; i_6 < 4; ++i_6) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_6 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_6 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

