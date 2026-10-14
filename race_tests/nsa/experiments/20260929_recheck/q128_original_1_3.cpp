#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  uint qs_w0[16];
  uint qs_w1[16];
  uint qs_w2[16];
  half_t qs_mma[32];
  half_t Q_reg[32];
  float acc_o[32];
  half_t K_reg[32];
  half_t V_reg[32];
  float acc_s[4];
  extern __shared__ __align__(1024) half_t V_shared[];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t vb[32];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int slot = 0; slot < 4; ++slot) {
    *(uint4*)(((half_t*)qs_w0) + (slot * 8)) = *(uint4*)(Q + (((((int)blockIdx.x) * 2048) + (slot * 512)) + (((int)threadIdx.x) * 8)));
  }
  uint condval;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval = qs_w0[4];
  } else {
    condval = qs_w0[0];
  }
  uint qs_cross_1_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval, 4, 64);
  uint condval_1;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_1 = qs_w0[0];
  } else {
    condval_1 = qs_cross_1_0;
  }
  qs_w1[0] = condval_1;
  uint condval_2;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_2 = qs_cross_1_0;
  } else {
    condval_2 = qs_w0[4];
  }
  qs_w1[4] = condval_2;
  uint condval_3;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_3 = qs_w0[5];
  } else {
    condval_3 = qs_w0[1];
  }
  uint qs_cross_1_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_3, 4, 64);
  uint condval_4;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_4 = qs_w0[1];
  } else {
    condval_4 = qs_cross_1_1;
  }
  qs_w1[1] = condval_4;
  uint condval_5;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_5 = qs_cross_1_1;
  } else {
    condval_5 = qs_w0[5];
  }
  qs_w1[5] = condval_5;
  uint condval_6;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_6 = qs_w0[6];
  } else {
    condval_6 = qs_w0[2];
  }
  uint qs_cross_1_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_6, 4, 64);
  uint condval_7;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_7 = qs_w0[2];
  } else {
    condval_7 = qs_cross_1_2;
  }
  qs_w1[2] = condval_7;
  uint condval_8;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_8 = qs_cross_1_2;
  } else {
    condval_8 = qs_w0[6];
  }
  qs_w1[6] = condval_8;
  uint condval_9;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_9 = qs_w0[7];
  } else {
    condval_9 = qs_w0[3];
  }
  uint qs_cross_1_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_9, 4, 64);
  uint condval_10;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_10 = qs_w0[3];
  } else {
    condval_10 = qs_cross_1_3;
  }
  qs_w1[3] = condval_10;
  uint condval_11;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_11 = qs_cross_1_3;
  } else {
    condval_11 = qs_w0[7];
  }
  qs_w1[7] = condval_11;
  uint condval_12;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_12 = qs_w0[12];
  } else {
    condval_12 = qs_w0[8];
  }
  uint qs_cross_1_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_12, 4, 64);
  uint condval_13;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_13 = qs_w0[8];
  } else {
    condval_13 = qs_cross_1_8;
  }
  qs_w1[8] = condval_13;
  uint condval_14;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_14 = qs_cross_1_8;
  } else {
    condval_14 = qs_w0[12];
  }
  qs_w1[12] = condval_14;
  uint condval_15;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_15 = qs_w0[13];
  } else {
    condval_15 = qs_w0[9];
  }
  uint qs_cross_1_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_15, 4, 64);
  uint condval_16;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_16 = qs_w0[9];
  } else {
    condval_16 = qs_cross_1_9;
  }
  qs_w1[9] = condval_16;
  uint condval_17;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_17 = qs_cross_1_9;
  } else {
    condval_17 = qs_w0[13];
  }
  qs_w1[13] = condval_17;
  uint condval_18;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_18 = qs_w0[14];
  } else {
    condval_18 = qs_w0[10];
  }
  uint qs_cross_1_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_18, 4, 64);
  uint condval_19;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_19 = qs_w0[10];
  } else {
    condval_19 = qs_cross_1_10;
  }
  qs_w1[10] = condval_19;
  uint condval_20;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_20 = qs_cross_1_10;
  } else {
    condval_20 = qs_w0[14];
  }
  qs_w1[14] = condval_20;
  uint condval_21;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_21 = qs_w0[15];
  } else {
    condval_21 = qs_w0[11];
  }
  uint qs_cross_1_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_21, 4, 64);
  uint condval_22;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_22 = qs_w0[11];
  } else {
    condval_22 = qs_cross_1_11;
  }
  qs_w1[11] = condval_22;
  uint condval_23;
  if (((((int)threadIdx.x) & 4) == 0)) {
    condval_23 = qs_cross_1_11;
  } else {
    condval_23 = qs_w0[15];
  }
  qs_w1[15] = condval_23;
  uint condval_24;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_24 = qs_w1[8];
  } else {
    condval_24 = qs_w1[0];
  }
  uint qs_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_24, 8, 64);
  uint condval_25;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_25 = qs_w1[0];
  } else {
    condval_25 = qs_cross_2_0;
  }
  qs_w2[0] = condval_25;
  uint condval_26;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_26 = qs_cross_2_0;
  } else {
    condval_26 = qs_w1[8];
  }
  qs_w2[8] = condval_26;
  uint condval_27;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_27 = qs_w1[9];
  } else {
    condval_27 = qs_w1[1];
  }
  uint qs_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_27, 8, 64);
  uint condval_28;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_28 = qs_w1[1];
  } else {
    condval_28 = qs_cross_2_1;
  }
  qs_w2[1] = condval_28;
  uint condval_29;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_29 = qs_cross_2_1;
  } else {
    condval_29 = qs_w1[9];
  }
  qs_w2[9] = condval_29;
  uint condval_30;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_30 = qs_w1[10];
  } else {
    condval_30 = qs_w1[2];
  }
  uint qs_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_30, 8, 64);
  uint condval_31;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_31 = qs_w1[2];
  } else {
    condval_31 = qs_cross_2_2;
  }
  qs_w2[2] = condval_31;
  uint condval_32;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_32 = qs_cross_2_2;
  } else {
    condval_32 = qs_w1[10];
  }
  qs_w2[10] = condval_32;
  uint condval_33;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_33 = qs_w1[11];
  } else {
    condval_33 = qs_w1[3];
  }
  uint qs_cross_2_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_33, 8, 64);
  uint condval_34;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_34 = qs_w1[3];
  } else {
    condval_34 = qs_cross_2_3;
  }
  qs_w2[3] = condval_34;
  uint condval_35;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_35 = qs_cross_2_3;
  } else {
    condval_35 = qs_w1[11];
  }
  qs_w2[11] = condval_35;
  uint condval_36;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_36 = qs_w1[12];
  } else {
    condval_36 = qs_w1[4];
  }
  uint qs_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_36, 8, 64);
  uint condval_37;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_37 = qs_w1[4];
  } else {
    condval_37 = qs_cross_2_4;
  }
  qs_w2[4] = condval_37;
  uint condval_38;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_38 = qs_cross_2_4;
  } else {
    condval_38 = qs_w1[12];
  }
  qs_w2[12] = condval_38;
  uint condval_39;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_39 = qs_w1[13];
  } else {
    condval_39 = qs_w1[5];
  }
  uint qs_cross_2_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_39, 8, 64);
  uint condval_40;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_40 = qs_w1[5];
  } else {
    condval_40 = qs_cross_2_5;
  }
  qs_w2[5] = condval_40;
  uint condval_41;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_41 = qs_cross_2_5;
  } else {
    condval_41 = qs_w1[13];
  }
  qs_w2[13] = condval_41;
  uint condval_42;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_42 = qs_w1[14];
  } else {
    condval_42 = qs_w1[6];
  }
  uint qs_cross_2_6 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_42, 8, 64);
  uint condval_43;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_43 = qs_w1[6];
  } else {
    condval_43 = qs_cross_2_6;
  }
  qs_w2[6] = condval_43;
  uint condval_44;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_44 = qs_cross_2_6;
  } else {
    condval_44 = qs_w1[14];
  }
  qs_w2[14] = condval_44;
  uint condval_45;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_45 = qs_w1[15];
  } else {
    condval_45 = qs_w1[7];
  }
  uint qs_cross_2_7 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_45, 8, 64);
  uint condval_46;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_46 = qs_w1[7];
  } else {
    condval_46 = qs_cross_2_7;
  }
  qs_w2[7] = condval_46;
  uint condval_47;
  if (((((int)threadIdx.x) & 8) == 0)) {
    condval_47 = qs_cross_2_7;
  } else {
    condval_47 = qs_w1[15];
  }
  qs_w2[15] = condval_47;
  ((uint*)qs_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[0], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[1], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[2], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[3], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[4], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[5], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[6], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[7], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[8] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[8], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[9] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[9], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[10] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[10], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[11] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[11], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[12] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[12], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[13] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[13], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[14] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[14], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  ((uint*)qs_mma)[15] = __shfl_sync((uint64_t)18446744073709551615, qs_w2[15], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
  #pragma unroll
  for (int i = 0; i < 32; ++i) {
    Q_reg[i] = qs_mma[i];
  }
  int i_s = (BlockIndices[((int)blockIdx.x)] * 16);
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= i_s) && (i_s < 64)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_48;
      if (((i_s + (((int)threadIdx.x) & 15)) < 64)) {
        condval_48 = *(uint4*)(K + ((((i_s * 128) + ((((int)threadIdx.x) & 15) * 128)) + (i_2 * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
      } else {
        condval_48 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(K_reg + (i_2 * 8)) = condval_48;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_49;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_3) < 16)) {
        condval_49 = *(uint4*)(V + (((i_3 * 512) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval_49 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(V_reg + (i_3 * 8)) = condval_49;
    }
    if (((int)blockIdx.x) < (i_s + 15)) {
      #pragma unroll
      for (int i_4 = 0; i_4 < 4; ++i_4) {
        float condval_50;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_4) <= ((int)blockIdx.x))) {
          condval_50 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_50 = -MACART_INF_F;
        }
        acc_s[i_4] = condval_50;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
    for (int ki = 0; ki < 4; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + ((ki * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      *(uint4*)(V_shared + (((i_5 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_5 * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(V_reg + (i_5 * 8));
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      acc_s[i_6] = exp2f(min((acc_s[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j = 0; j < 4; ++j) {
      lane_sum[0] = (lane_sum[0] + acc_s[j]);
    }
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
    float condval_51;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_51 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_51 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_51;
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      acc_s[i_7] = (acc_s[i_7] * lane_sum[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + 0) = __1;
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 64)) && (i_s <= ((int)blockIdx.x))) {
    for (int j_1 = 0; j_1 < 8; ++j_1) {
      for (int local_id = 0; local_id < 4; ++local_id) {
        vb[((j_1 * 4) + local_id)] = V_shared[(((((((int)threadIdx.x) >> 4) * 512) + (local_id * 128)) + ((((j_1 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ (((((int)threadIdx.x) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
      }
    }
    for (int j_2 = 0; j_2 < 8; ++j_2) {
      {
      *(((float32x4*)acc_o) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_2),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_2));
    };
    }
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 8; ++i_8) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_8 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + (i_8 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

