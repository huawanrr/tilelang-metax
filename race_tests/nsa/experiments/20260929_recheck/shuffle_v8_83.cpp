#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  half_t Q_reg[32];
  float acc_o[32];
  half_t K_reg[64];
  uint vs_w0[32];
  extern __shared__ __align__(1024) half_t V_shared[];
  float acc_s[8];
  uint vs_w1[32];
  uint vs_w2[32];
  uint vs_w3[32];
  uint vs_w4[32];
  half_t vs_mma[64];
  float lane_sum[1];
  half_t acc_s_cast[8];
  half_t kb[16];
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
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_2) < 256)) {
        condval = *(uint4*)(K + (((i_2 * 512) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(K_reg + (i_2 * 8)) = condval;
    }
    #pragma unroll
    for (int slot = 0; slot < 8; ++slot) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if (((((((slot >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_s) + (slot & 3)) < 1024)) {
        condval_1 = *(uint4*)(V + ((((((slot >> 2) * 2048) + ((((int)threadIdx.x) >> 4) * 512)) + (i_s * 128)) + ((slot & 3) * 128)) + ((((int)threadIdx.x) & 15) * 8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(((half_t*)vs_w0) + (slot * 8)) = condval_1;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 8; ++i_3) {
      *(uint4*)(V_shared + (((i_3 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_3 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(K_reg + (i_3 * 8));
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
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    for (int ki = 0; ki < 4; ++ki) {
      for (int j = 0; j < 2; ++j) {
        *(uint4*)(kb + (j * 8)) = *(uint4*)(V_shared + (((j * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
      }
      for (int kp = 0; kp < 2; ++kp) {
        for (int j_1 = 0; j_1 < 2; ++j_1) {
          {
      *(((float32x4*)acc_s) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_1 * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + j_1));
    };
        }
      }
    }
    vs_w1[0] = ((vs_w0[0] & (uint)65535) | (vs_w0[4] << (uint)16));
    vs_w1[4] = ((vs_w0[0] >> (uint)16) | (vs_w0[4] & (uint)4294901760));
    vs_w1[1] = ((vs_w0[1] & (uint)65535) | (vs_w0[5] << (uint)16));
    vs_w1[5] = ((vs_w0[1] >> (uint)16) | (vs_w0[5] & (uint)4294901760));
    vs_w1[2] = ((vs_w0[2] & (uint)65535) | (vs_w0[6] << (uint)16));
    vs_w1[6] = ((vs_w0[2] >> (uint)16) | (vs_w0[6] & (uint)4294901760));
    vs_w1[3] = ((vs_w0[3] & (uint)65535) | (vs_w0[7] << (uint)16));
    vs_w1[7] = ((vs_w0[3] >> (uint)16) | (vs_w0[7] & (uint)4294901760));
    vs_w1[8] = ((vs_w0[8] & (uint)65535) | (vs_w0[12] << (uint)16));
    vs_w1[12] = ((vs_w0[8] >> (uint)16) | (vs_w0[12] & (uint)4294901760));
    vs_w1[9] = ((vs_w0[9] & (uint)65535) | (vs_w0[13] << (uint)16));
    vs_w1[13] = ((vs_w0[9] >> (uint)16) | (vs_w0[13] & (uint)4294901760));
    vs_w1[10] = ((vs_w0[10] & (uint)65535) | (vs_w0[14] << (uint)16));
    vs_w1[14] = ((vs_w0[10] >> (uint)16) | (vs_w0[14] & (uint)4294901760));
    vs_w1[11] = ((vs_w0[11] & (uint)65535) | (vs_w0[15] << (uint)16));
    vs_w1[15] = ((vs_w0[11] >> (uint)16) | (vs_w0[15] & (uint)4294901760));
    vs_w1[16] = ((vs_w0[16] & (uint)65535) | (vs_w0[20] << (uint)16));
    vs_w1[20] = ((vs_w0[16] >> (uint)16) | (vs_w0[20] & (uint)4294901760));
    vs_w1[17] = ((vs_w0[17] & (uint)65535) | (vs_w0[21] << (uint)16));
    vs_w1[21] = ((vs_w0[17] >> (uint)16) | (vs_w0[21] & (uint)4294901760));
    vs_w1[18] = ((vs_w0[18] & (uint)65535) | (vs_w0[22] << (uint)16));
    vs_w1[22] = ((vs_w0[18] >> (uint)16) | (vs_w0[22] & (uint)4294901760));
    vs_w1[19] = ((vs_w0[19] & (uint)65535) | (vs_w0[23] << (uint)16));
    vs_w1[23] = ((vs_w0[19] >> (uint)16) | (vs_w0[23] & (uint)4294901760));
    vs_w1[24] = ((vs_w0[24] & (uint)65535) | (vs_w0[28] << (uint)16));
    vs_w1[28] = ((vs_w0[24] >> (uint)16) | (vs_w0[28] & (uint)4294901760));
    vs_w1[25] = ((vs_w0[25] & (uint)65535) | (vs_w0[29] << (uint)16));
    vs_w1[29] = ((vs_w0[25] >> (uint)16) | (vs_w0[29] & (uint)4294901760));
    vs_w1[26] = ((vs_w0[26] & (uint)65535) | (vs_w0[30] << (uint)16));
    vs_w1[30] = ((vs_w0[26] >> (uint)16) | (vs_w0[30] & (uint)4294901760));
    vs_w1[27] = ((vs_w0[27] & (uint)65535) | (vs_w0[31] << (uint)16));
    vs_w1[31] = ((vs_w0[27] >> (uint)16) | (vs_w0[31] & (uint)4294901760));
    uint condval_3;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_3 = vs_w1[1];
    } else {
      condval_3 = vs_w1[0];
    }
    uint vs_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_3, 2, 64);
    uint condval_4;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_4 = vs_w1[0];
    } else {
      condval_4 = vs_cross_2_0;
    }
    vs_w2[0] = condval_4;
    uint condval_5;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_5 = vs_cross_2_0;
    } else {
      condval_5 = vs_w1[1];
    }
    vs_w2[1] = condval_5;
    uint condval_6;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_6 = vs_w1[3];
    } else {
      condval_6 = vs_w1[2];
    }
    uint vs_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_6, 2, 64);
    uint condval_7;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_7 = vs_w1[2];
    } else {
      condval_7 = vs_cross_2_2;
    }
    vs_w2[2] = condval_7;
    uint condval_8;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_8 = vs_cross_2_2;
    } else {
      condval_8 = vs_w1[3];
    }
    vs_w2[3] = condval_8;
    uint condval_9;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_9 = vs_w1[5];
    } else {
      condval_9 = vs_w1[4];
    }
    uint vs_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_9, 2, 64);
    uint condval_10;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_10 = vs_w1[4];
    } else {
      condval_10 = vs_cross_2_4;
    }
    vs_w2[4] = condval_10;
    uint condval_11;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_11 = vs_cross_2_4;
    } else {
      condval_11 = vs_w1[5];
    }
    vs_w2[5] = condval_11;
    uint condval_12;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_12 = vs_w1[7];
    } else {
      condval_12 = vs_w1[6];
    }
    uint vs_cross_2_6 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_12, 2, 64);
    uint condval_13;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_13 = vs_w1[6];
    } else {
      condval_13 = vs_cross_2_6;
    }
    vs_w2[6] = condval_13;
    uint condval_14;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_14 = vs_cross_2_6;
    } else {
      condval_14 = vs_w1[7];
    }
    vs_w2[7] = condval_14;
    uint condval_15;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_15 = vs_w1[9];
    } else {
      condval_15 = vs_w1[8];
    }
    uint vs_cross_2_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_15, 2, 64);
    uint condval_16;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_16 = vs_w1[8];
    } else {
      condval_16 = vs_cross_2_8;
    }
    vs_w2[8] = condval_16;
    uint condval_17;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_17 = vs_cross_2_8;
    } else {
      condval_17 = vs_w1[9];
    }
    vs_w2[9] = condval_17;
    uint condval_18;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_18 = vs_w1[11];
    } else {
      condval_18 = vs_w1[10];
    }
    uint vs_cross_2_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_18, 2, 64);
    uint condval_19;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_19 = vs_w1[10];
    } else {
      condval_19 = vs_cross_2_10;
    }
    vs_w2[10] = condval_19;
    uint condval_20;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_20 = vs_cross_2_10;
    } else {
      condval_20 = vs_w1[11];
    }
    vs_w2[11] = condval_20;
    uint condval_21;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_21 = vs_w1[13];
    } else {
      condval_21 = vs_w1[12];
    }
    uint vs_cross_2_12 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_21, 2, 64);
    uint condval_22;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_22 = vs_w1[12];
    } else {
      condval_22 = vs_cross_2_12;
    }
    vs_w2[12] = condval_22;
    uint condval_23;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_23 = vs_cross_2_12;
    } else {
      condval_23 = vs_w1[13];
    }
    vs_w2[13] = condval_23;
    uint condval_24;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_24 = vs_w1[15];
    } else {
      condval_24 = vs_w1[14];
    }
    uint vs_cross_2_14 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_24, 2, 64);
    uint condval_25;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_25 = vs_w1[14];
    } else {
      condval_25 = vs_cross_2_14;
    }
    vs_w2[14] = condval_25;
    uint condval_26;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_26 = vs_cross_2_14;
    } else {
      condval_26 = vs_w1[15];
    }
    vs_w2[15] = condval_26;
    uint condval_27;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_27 = vs_w1[17];
    } else {
      condval_27 = vs_w1[16];
    }
    uint vs_cross_2_16 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_27, 2, 64);
    uint condval_28;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_28 = vs_w1[16];
    } else {
      condval_28 = vs_cross_2_16;
    }
    vs_w2[16] = condval_28;
    uint condval_29;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_29 = vs_cross_2_16;
    } else {
      condval_29 = vs_w1[17];
    }
    vs_w2[17] = condval_29;
    uint condval_30;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_30 = vs_w1[19];
    } else {
      condval_30 = vs_w1[18];
    }
    uint vs_cross_2_18 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_30, 2, 64);
    uint condval_31;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_31 = vs_w1[18];
    } else {
      condval_31 = vs_cross_2_18;
    }
    vs_w2[18] = condval_31;
    uint condval_32;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_32 = vs_cross_2_18;
    } else {
      condval_32 = vs_w1[19];
    }
    vs_w2[19] = condval_32;
    uint condval_33;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_33 = vs_w1[21];
    } else {
      condval_33 = vs_w1[20];
    }
    uint vs_cross_2_20 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_33, 2, 64);
    uint condval_34;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_34 = vs_w1[20];
    } else {
      condval_34 = vs_cross_2_20;
    }
    vs_w2[20] = condval_34;
    uint condval_35;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_35 = vs_cross_2_20;
    } else {
      condval_35 = vs_w1[21];
    }
    vs_w2[21] = condval_35;
    uint condval_36;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_36 = vs_w1[23];
    } else {
      condval_36 = vs_w1[22];
    }
    uint vs_cross_2_22 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_36, 2, 64);
    uint condval_37;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_37 = vs_w1[22];
    } else {
      condval_37 = vs_cross_2_22;
    }
    vs_w2[22] = condval_37;
    uint condval_38;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_38 = vs_cross_2_22;
    } else {
      condval_38 = vs_w1[23];
    }
    vs_w2[23] = condval_38;
    uint condval_39;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_39 = vs_w1[25];
    } else {
      condval_39 = vs_w1[24];
    }
    uint vs_cross_2_24 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_39, 2, 64);
    uint condval_40;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_40 = vs_w1[24];
    } else {
      condval_40 = vs_cross_2_24;
    }
    vs_w2[24] = condval_40;
    uint condval_41;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_41 = vs_cross_2_24;
    } else {
      condval_41 = vs_w1[25];
    }
    vs_w2[25] = condval_41;
    uint condval_42;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_42 = vs_w1[27];
    } else {
      condval_42 = vs_w1[26];
    }
    uint vs_cross_2_26 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_42, 2, 64);
    uint condval_43;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_43 = vs_w1[26];
    } else {
      condval_43 = vs_cross_2_26;
    }
    vs_w2[26] = condval_43;
    uint condval_44;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_44 = vs_cross_2_26;
    } else {
      condval_44 = vs_w1[27];
    }
    vs_w2[27] = condval_44;
    uint condval_45;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_45 = vs_w1[29];
    } else {
      condval_45 = vs_w1[28];
    }
    uint vs_cross_2_28 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_45, 2, 64);
    uint condval_46;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_46 = vs_w1[28];
    } else {
      condval_46 = vs_cross_2_28;
    }
    vs_w2[28] = condval_46;
    uint condval_47;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_47 = vs_cross_2_28;
    } else {
      condval_47 = vs_w1[29];
    }
    vs_w2[29] = condval_47;
    uint condval_48;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_48 = vs_w1[31];
    } else {
      condval_48 = vs_w1[30];
    }
    uint vs_cross_2_30 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_48, 2, 64);
    uint condval_49;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_49 = vs_w1[30];
    } else {
      condval_49 = vs_cross_2_30;
    }
    vs_w2[30] = condval_49;
    uint condval_50;
    if (((((int)threadIdx.x) & 2) == 0)) {
      condval_50 = vs_cross_2_30;
    } else {
      condval_50 = vs_w1[31];
    }
    vs_w2[31] = condval_50;
    uint condval_51;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_51 = vs_w2[2];
    } else {
      condval_51 = vs_w2[0];
    }
    uint vs_cross_3_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_51, 4, 64);
    uint condval_52;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_52 = vs_w2[0];
    } else {
      condval_52 = vs_cross_3_0;
    }
    vs_w3[0] = condval_52;
    uint condval_53;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_53 = vs_cross_3_0;
    } else {
      condval_53 = vs_w2[2];
    }
    vs_w3[2] = condval_53;
    uint condval_54;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_54 = vs_w2[3];
    } else {
      condval_54 = vs_w2[1];
    }
    uint vs_cross_3_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_54, 4, 64);
    uint condval_55;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_55 = vs_w2[1];
    } else {
      condval_55 = vs_cross_3_1;
    }
    vs_w3[1] = condval_55;
    uint condval_56;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_56 = vs_cross_3_1;
    } else {
      condval_56 = vs_w2[3];
    }
    vs_w3[3] = condval_56;
    uint condval_57;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_57 = vs_w2[6];
    } else {
      condval_57 = vs_w2[4];
    }
    uint vs_cross_3_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_57, 4, 64);
    uint condval_58;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_58 = vs_w2[4];
    } else {
      condval_58 = vs_cross_3_4;
    }
    vs_w3[4] = condval_58;
    uint condval_59;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_59 = vs_cross_3_4;
    } else {
      condval_59 = vs_w2[6];
    }
    vs_w3[6] = condval_59;
    uint condval_60;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_60 = vs_w2[7];
    } else {
      condval_60 = vs_w2[5];
    }
    uint vs_cross_3_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_60, 4, 64);
    uint condval_61;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_61 = vs_w2[5];
    } else {
      condval_61 = vs_cross_3_5;
    }
    vs_w3[5] = condval_61;
    uint condval_62;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_62 = vs_cross_3_5;
    } else {
      condval_62 = vs_w2[7];
    }
    vs_w3[7] = condval_62;
    uint condval_63;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_63 = vs_w2[10];
    } else {
      condval_63 = vs_w2[8];
    }
    uint vs_cross_3_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_63, 4, 64);
    uint condval_64;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_64 = vs_w2[8];
    } else {
      condval_64 = vs_cross_3_8;
    }
    vs_w3[8] = condval_64;
    uint condval_65;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_65 = vs_cross_3_8;
    } else {
      condval_65 = vs_w2[10];
    }
    vs_w3[10] = condval_65;
    uint condval_66;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_66 = vs_w2[11];
    } else {
      condval_66 = vs_w2[9];
    }
    uint vs_cross_3_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_66, 4, 64);
    uint condval_67;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_67 = vs_w2[9];
    } else {
      condval_67 = vs_cross_3_9;
    }
    vs_w3[9] = condval_67;
    uint condval_68;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_68 = vs_cross_3_9;
    } else {
      condval_68 = vs_w2[11];
    }
    vs_w3[11] = condval_68;
    uint condval_69;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_69 = vs_w2[14];
    } else {
      condval_69 = vs_w2[12];
    }
    uint vs_cross_3_12 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_69, 4, 64);
    uint condval_70;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_70 = vs_w2[12];
    } else {
      condval_70 = vs_cross_3_12;
    }
    vs_w3[12] = condval_70;
    uint condval_71;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_71 = vs_cross_3_12;
    } else {
      condval_71 = vs_w2[14];
    }
    vs_w3[14] = condval_71;
    uint condval_72;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_72 = vs_w2[15];
    } else {
      condval_72 = vs_w2[13];
    }
    uint vs_cross_3_13 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_72, 4, 64);
    uint condval_73;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_73 = vs_w2[13];
    } else {
      condval_73 = vs_cross_3_13;
    }
    vs_w3[13] = condval_73;
    uint condval_74;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_74 = vs_cross_3_13;
    } else {
      condval_74 = vs_w2[15];
    }
    vs_w3[15] = condval_74;
    uint condval_75;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_75 = vs_w2[18];
    } else {
      condval_75 = vs_w2[16];
    }
    uint vs_cross_3_16 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_75, 4, 64);
    uint condval_76;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_76 = vs_w2[16];
    } else {
      condval_76 = vs_cross_3_16;
    }
    vs_w3[16] = condval_76;
    uint condval_77;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_77 = vs_cross_3_16;
    } else {
      condval_77 = vs_w2[18];
    }
    vs_w3[18] = condval_77;
    uint condval_78;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_78 = vs_w2[19];
    } else {
      condval_78 = vs_w2[17];
    }
    uint vs_cross_3_17 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_78, 4, 64);
    uint condval_79;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_79 = vs_w2[17];
    } else {
      condval_79 = vs_cross_3_17;
    }
    vs_w3[17] = condval_79;
    uint condval_80;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_80 = vs_cross_3_17;
    } else {
      condval_80 = vs_w2[19];
    }
    vs_w3[19] = condval_80;
    uint condval_81;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_81 = vs_w2[22];
    } else {
      condval_81 = vs_w2[20];
    }
    uint vs_cross_3_20 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_81, 4, 64);
    uint condval_82;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_82 = vs_w2[20];
    } else {
      condval_82 = vs_cross_3_20;
    }
    vs_w3[20] = condval_82;
    uint condval_83;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_83 = vs_cross_3_20;
    } else {
      condval_83 = vs_w2[22];
    }
    vs_w3[22] = condval_83;
    uint condval_84;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_84 = vs_w2[23];
    } else {
      condval_84 = vs_w2[21];
    }
    uint vs_cross_3_21 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_84, 4, 64);
    uint condval_85;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_85 = vs_w2[21];
    } else {
      condval_85 = vs_cross_3_21;
    }
    vs_w3[21] = condval_85;
    uint condval_86;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_86 = vs_cross_3_21;
    } else {
      condval_86 = vs_w2[23];
    }
    vs_w3[23] = condval_86;
    uint condval_87;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_87 = vs_w2[26];
    } else {
      condval_87 = vs_w2[24];
    }
    uint vs_cross_3_24 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_87, 4, 64);
    uint condval_88;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_88 = vs_w2[24];
    } else {
      condval_88 = vs_cross_3_24;
    }
    vs_w3[24] = condval_88;
    uint condval_89;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_89 = vs_cross_3_24;
    } else {
      condval_89 = vs_w2[26];
    }
    vs_w3[26] = condval_89;
    uint condval_90;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_90 = vs_w2[27];
    } else {
      condval_90 = vs_w2[25];
    }
    uint vs_cross_3_25 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_90, 4, 64);
    uint condval_91;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_91 = vs_w2[25];
    } else {
      condval_91 = vs_cross_3_25;
    }
    vs_w3[25] = condval_91;
    uint condval_92;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_92 = vs_cross_3_25;
    } else {
      condval_92 = vs_w2[27];
    }
    vs_w3[27] = condval_92;
    uint condval_93;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_93 = vs_w2[30];
    } else {
      condval_93 = vs_w2[28];
    }
    uint vs_cross_3_28 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_93, 4, 64);
    uint condval_94;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_94 = vs_w2[28];
    } else {
      condval_94 = vs_cross_3_28;
    }
    vs_w3[28] = condval_94;
    uint condval_95;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_95 = vs_cross_3_28;
    } else {
      condval_95 = vs_w2[30];
    }
    vs_w3[30] = condval_95;
    uint condval_96;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_96 = vs_w2[31];
    } else {
      condval_96 = vs_w2[29];
    }
    uint vs_cross_3_29 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_96, 4, 64);
    uint condval_97;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_97 = vs_w2[29];
    } else {
      condval_97 = vs_cross_3_29;
    }
    vs_w3[29] = condval_97;
    uint condval_98;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_98 = vs_cross_3_29;
    } else {
      condval_98 = vs_w2[31];
    }
    vs_w3[31] = condval_98;
    uint condval_99;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_99 = vs_w3[4];
    } else {
      condval_99 = vs_w3[0];
    }
    uint vs_cross_4_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_99, 8, 64);
    uint condval_100;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_100 = vs_w3[0];
    } else {
      condval_100 = vs_cross_4_0;
    }
    vs_w4[0] = condval_100;
    uint condval_101;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_101 = vs_cross_4_0;
    } else {
      condval_101 = vs_w3[4];
    }
    vs_w4[4] = condval_101;
    uint condval_102;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_102 = vs_w3[5];
    } else {
      condval_102 = vs_w3[1];
    }
    uint vs_cross_4_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_102, 8, 64);
    uint condval_103;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_103 = vs_w3[1];
    } else {
      condval_103 = vs_cross_4_1;
    }
    vs_w4[1] = condval_103;
    uint condval_104;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_104 = vs_cross_4_1;
    } else {
      condval_104 = vs_w3[5];
    }
    vs_w4[5] = condval_104;
    uint condval_105;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_105 = vs_w3[6];
    } else {
      condval_105 = vs_w3[2];
    }
    uint vs_cross_4_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_105, 8, 64);
    uint condval_106;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_106 = vs_w3[2];
    } else {
      condval_106 = vs_cross_4_2;
    }
    vs_w4[2] = condval_106;
    uint condval_107;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_107 = vs_cross_4_2;
    } else {
      condval_107 = vs_w3[6];
    }
    vs_w4[6] = condval_107;
    uint condval_108;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_108 = vs_w3[7];
    } else {
      condval_108 = vs_w3[3];
    }
    uint vs_cross_4_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_108, 8, 64);
    uint condval_109;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_109 = vs_w3[3];
    } else {
      condval_109 = vs_cross_4_3;
    }
    vs_w4[3] = condval_109;
    uint condval_110;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_110 = vs_cross_4_3;
    } else {
      condval_110 = vs_w3[7];
    }
    vs_w4[7] = condval_110;
    uint condval_111;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_111 = vs_w3[12];
    } else {
      condval_111 = vs_w3[8];
    }
    uint vs_cross_4_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_111, 8, 64);
    uint condval_112;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_112 = vs_w3[8];
    } else {
      condval_112 = vs_cross_4_8;
    }
    vs_w4[8] = condval_112;
    uint condval_113;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_113 = vs_cross_4_8;
    } else {
      condval_113 = vs_w3[12];
    }
    vs_w4[12] = condval_113;
    uint condval_114;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_114 = vs_w3[13];
    } else {
      condval_114 = vs_w3[9];
    }
    uint vs_cross_4_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_114, 8, 64);
    uint condval_115;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_115 = vs_w3[9];
    } else {
      condval_115 = vs_cross_4_9;
    }
    vs_w4[9] = condval_115;
    uint condval_116;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_116 = vs_cross_4_9;
    } else {
      condval_116 = vs_w3[13];
    }
    vs_w4[13] = condval_116;
    uint condval_117;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_117 = vs_w3[14];
    } else {
      condval_117 = vs_w3[10];
    }
    uint vs_cross_4_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_117, 8, 64);
    uint condval_118;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_118 = vs_w3[10];
    } else {
      condval_118 = vs_cross_4_10;
    }
    vs_w4[10] = condval_118;
    uint condval_119;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_119 = vs_cross_4_10;
    } else {
      condval_119 = vs_w3[14];
    }
    vs_w4[14] = condval_119;
    uint condval_120;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_120 = vs_w3[15];
    } else {
      condval_120 = vs_w3[11];
    }
    uint vs_cross_4_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_120, 8, 64);
    uint condval_121;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_121 = vs_w3[11];
    } else {
      condval_121 = vs_cross_4_11;
    }
    vs_w4[11] = condval_121;
    uint condval_122;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_122 = vs_cross_4_11;
    } else {
      condval_122 = vs_w3[15];
    }
    vs_w4[15] = condval_122;
    uint condval_123;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_123 = vs_w3[20];
    } else {
      condval_123 = vs_w3[16];
    }
    uint vs_cross_4_16 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_123, 8, 64);
    uint condval_124;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_124 = vs_w3[16];
    } else {
      condval_124 = vs_cross_4_16;
    }
    vs_w4[16] = condval_124;
    uint condval_125;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_125 = vs_cross_4_16;
    } else {
      condval_125 = vs_w3[20];
    }
    vs_w4[20] = condval_125;
    uint condval_126;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_126 = vs_w3[21];
    } else {
      condval_126 = vs_w3[17];
    }
    uint vs_cross_4_17 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_126, 8, 64);
    uint condval_127;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_127 = vs_w3[17];
    } else {
      condval_127 = vs_cross_4_17;
    }
    vs_w4[17] = condval_127;
    uint condval_128;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_128 = vs_cross_4_17;
    } else {
      condval_128 = vs_w3[21];
    }
    vs_w4[21] = condval_128;
    uint condval_129;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_129 = vs_w3[22];
    } else {
      condval_129 = vs_w3[18];
    }
    uint vs_cross_4_18 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_129, 8, 64);
    uint condval_130;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_130 = vs_w3[18];
    } else {
      condval_130 = vs_cross_4_18;
    }
    vs_w4[18] = condval_130;
    uint condval_131;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_131 = vs_cross_4_18;
    } else {
      condval_131 = vs_w3[22];
    }
    vs_w4[22] = condval_131;
    uint condval_132;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_132 = vs_w3[23];
    } else {
      condval_132 = vs_w3[19];
    }
    uint vs_cross_4_19 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_132, 8, 64);
    uint condval_133;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_133 = vs_w3[19];
    } else {
      condval_133 = vs_cross_4_19;
    }
    vs_w4[19] = condval_133;
    uint condval_134;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_134 = vs_cross_4_19;
    } else {
      condval_134 = vs_w3[23];
    }
    vs_w4[23] = condval_134;
    uint condval_135;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_135 = vs_w3[28];
    } else {
      condval_135 = vs_w3[24];
    }
    uint vs_cross_4_24 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_135, 8, 64);
    uint condval_136;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_136 = vs_w3[24];
    } else {
      condval_136 = vs_cross_4_24;
    }
    vs_w4[24] = condval_136;
    uint condval_137;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_137 = vs_cross_4_24;
    } else {
      condval_137 = vs_w3[28];
    }
    vs_w4[28] = condval_137;
    uint condval_138;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_138 = vs_w3[29];
    } else {
      condval_138 = vs_w3[25];
    }
    uint vs_cross_4_25 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_138, 8, 64);
    uint condval_139;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_139 = vs_w3[25];
    } else {
      condval_139 = vs_cross_4_25;
    }
    vs_w4[25] = condval_139;
    uint condval_140;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_140 = vs_cross_4_25;
    } else {
      condval_140 = vs_w3[29];
    }
    vs_w4[29] = condval_140;
    uint condval_141;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_141 = vs_w3[30];
    } else {
      condval_141 = vs_w3[26];
    }
    uint vs_cross_4_26 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_141, 8, 64);
    uint condval_142;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_142 = vs_w3[26];
    } else {
      condval_142 = vs_cross_4_26;
    }
    vs_w4[26] = condval_142;
    uint condval_143;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_143 = vs_cross_4_26;
    } else {
      condval_143 = vs_w3[30];
    }
    vs_w4[30] = condval_143;
    uint condval_144;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_144 = vs_w3[31];
    } else {
      condval_144 = vs_w3[27];
    }
    uint vs_cross_4_27 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_144, 8, 64);
    uint condval_145;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_145 = vs_w3[27];
    } else {
      condval_145 = vs_cross_4_27;
    }
    vs_w4[27] = condval_145;
    uint condval_146;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_146 = vs_cross_4_27;
    } else {
      condval_146 = vs_w3[31];
    }
    vs_w4[31] = condval_146;
    ((uint*)vs_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[0], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[8], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[1], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[9], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[2], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[10], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[3], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[11], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[8] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[4], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[9] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[12], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[10] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[5], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[11] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[13], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[12] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[6], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[13] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[14], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[14] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[7], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[15] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[15], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[16] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[16], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[17] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[24], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[18] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[17], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[19] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[25], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[20] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[18], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[21] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[26], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[22] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[19], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[23] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[27], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[24] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[20], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[25] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[28], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[26] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[21], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[27] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[29], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[28] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[22], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[29] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[30], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[30] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[23], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    ((uint*)vs_mma)[31] = __shfl_sync((uint64_t)18446744073709551615, vs_w4[31], (((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + (((((int)threadIdx.x) & 7) >> 1) * 2)) + ((((int)threadIdx.x) & 15) >> 3)), 64);
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      acc_s[i_6] = exp2f(min((acc_s[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int k = 0; k < 2; ++k) {
      #pragma unroll
      for (int j_2 = 0; j_2 < 4; ++j_2) {
        lane_sum[0] = (lane_sum[0] + acc_s[((k * 4) + j_2)]);
      }
    }
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
    float condval_147;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_147 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_147 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_147;
    #pragma unroll
    for (int i_7 = 0; i_7 < 8; ++i_7) {
      acc_s[i_7] = (acc_s[i_7] * lane_sum[0]);
    }
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + (i_8 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + (i_8 * 4)) = __1;
    }
    #pragma unroll
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int e = 0; e < 4; ++e) {
        *(uint4*)(vb + (e * 8)) = *(uint4*)(vs_mma + ((ki_1 * 32) + (e * 8)));
      }
      for (int j_3 = 0; j_3 < 8; ++j_3) {
        {
      *(((float32x4*)acc_o) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_3),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_o) + j_3));
    };
      }
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 8; ++i_9) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_9 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

