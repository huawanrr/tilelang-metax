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
  half_t K_reg[32];
  uint vs_w0[16];
  extern __shared__ __align__(1024) half_t V_shared[];
  float acc_s[4];
  uint vs_w1[16];
  uint vs_w2[16];
  uint vs_w3[16];
  uint vs_w4[16];
  half_t vs_mma[32];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t kb[8];
  half_t vb[32];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int i_s = (BlockIndices[((((int)blockIdx.z) * 1024) + ((int)blockIdx.x))] * 16);
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_2) < 256)) {
        condval = *(uint4*)(K + ((((((int)blockIdx.z) * 131072) + (i_2 * 512)) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(K_reg + (i_2 * 8)) = condval;
    }
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if ((((((int)threadIdx.x) >> 4) + ((slot + i_s) >> 2)) < 256)) {
        condval_1 = *(uint4*)(V + (((((((int)blockIdx.z) * 131072) + ((((int)threadIdx.x) >> 4) * 512)) + (slot * 128)) + (i_s * 128)) + ((((int)threadIdx.x) & 15) * 8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(((half_t*)vs_w0) + (slot * 8)) = condval_1;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      *(uint4*)(V_shared + (((i_3 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_3 * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(K_reg + (i_3 * 8));
    }
    if (((int)blockIdx.x) < (i_s + 15)) {
      #pragma unroll
      for (int i_4 = 0; i_4 < 4; ++i_4) {
        float condval_2;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_4) <= ((int)blockIdx.x))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        acc_s[i_4] = condval_2;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    for (int ki = 0; ki < 4; ++ki) {
      *(uint4*)(kb + 0) = *(uint4*)(V_shared + (((((int)threadIdx.x) & 15) * 128) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + kp),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
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
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_27 = vs_w2[2];
    } else {
      condval_27 = vs_w2[0];
    }
    uint vs_cross_3_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_27, 4, 64);
    uint condval_28;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_28 = vs_w2[0];
    } else {
      condval_28 = vs_cross_3_0;
    }
    vs_w3[0] = condval_28;
    uint condval_29;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_29 = vs_cross_3_0;
    } else {
      condval_29 = vs_w2[2];
    }
    vs_w3[2] = condval_29;
    uint condval_30;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_30 = vs_w2[3];
    } else {
      condval_30 = vs_w2[1];
    }
    uint vs_cross_3_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_30, 4, 64);
    uint condval_31;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_31 = vs_w2[1];
    } else {
      condval_31 = vs_cross_3_1;
    }
    vs_w3[1] = condval_31;
    uint condval_32;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_32 = vs_cross_3_1;
    } else {
      condval_32 = vs_w2[3];
    }
    vs_w3[3] = condval_32;
    uint condval_33;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_33 = vs_w2[6];
    } else {
      condval_33 = vs_w2[4];
    }
    uint vs_cross_3_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_33, 4, 64);
    uint condval_34;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_34 = vs_w2[4];
    } else {
      condval_34 = vs_cross_3_4;
    }
    vs_w3[4] = condval_34;
    uint condval_35;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_35 = vs_cross_3_4;
    } else {
      condval_35 = vs_w2[6];
    }
    vs_w3[6] = condval_35;
    uint condval_36;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_36 = vs_w2[7];
    } else {
      condval_36 = vs_w2[5];
    }
    uint vs_cross_3_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_36, 4, 64);
    uint condval_37;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_37 = vs_w2[5];
    } else {
      condval_37 = vs_cross_3_5;
    }
    vs_w3[5] = condval_37;
    uint condval_38;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_38 = vs_cross_3_5;
    } else {
      condval_38 = vs_w2[7];
    }
    vs_w3[7] = condval_38;
    uint condval_39;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_39 = vs_w2[10];
    } else {
      condval_39 = vs_w2[8];
    }
    uint vs_cross_3_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_39, 4, 64);
    uint condval_40;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_40 = vs_w2[8];
    } else {
      condval_40 = vs_cross_3_8;
    }
    vs_w3[8] = condval_40;
    uint condval_41;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_41 = vs_cross_3_8;
    } else {
      condval_41 = vs_w2[10];
    }
    vs_w3[10] = condval_41;
    uint condval_42;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_42 = vs_w2[11];
    } else {
      condval_42 = vs_w2[9];
    }
    uint vs_cross_3_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_42, 4, 64);
    uint condval_43;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_43 = vs_w2[9];
    } else {
      condval_43 = vs_cross_3_9;
    }
    vs_w3[9] = condval_43;
    uint condval_44;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_44 = vs_cross_3_9;
    } else {
      condval_44 = vs_w2[11];
    }
    vs_w3[11] = condval_44;
    uint condval_45;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_45 = vs_w2[14];
    } else {
      condval_45 = vs_w2[12];
    }
    uint vs_cross_3_12 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_45, 4, 64);
    uint condval_46;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_46 = vs_w2[12];
    } else {
      condval_46 = vs_cross_3_12;
    }
    vs_w3[12] = condval_46;
    uint condval_47;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_47 = vs_cross_3_12;
    } else {
      condval_47 = vs_w2[14];
    }
    vs_w3[14] = condval_47;
    uint condval_48;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_48 = vs_w2[15];
    } else {
      condval_48 = vs_w2[13];
    }
    uint vs_cross_3_13 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_48, 4, 64);
    uint condval_49;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_49 = vs_w2[13];
    } else {
      condval_49 = vs_cross_3_13;
    }
    vs_w3[13] = condval_49;
    uint condval_50;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_50 = vs_cross_3_13;
    } else {
      condval_50 = vs_w2[15];
    }
    vs_w3[15] = condval_50;
    uint condval_51;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_51 = vs_w3[4];
    } else {
      condval_51 = vs_w3[0];
    }
    uint vs_cross_4_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_51, 8, 64);
    uint condval_52;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_52 = vs_w3[0];
    } else {
      condval_52 = vs_cross_4_0;
    }
    vs_w4[0] = condval_52;
    uint condval_53;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_53 = vs_cross_4_0;
    } else {
      condval_53 = vs_w3[4];
    }
    vs_w4[4] = condval_53;
    uint condval_54;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_54 = vs_w3[5];
    } else {
      condval_54 = vs_w3[1];
    }
    uint vs_cross_4_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_54, 8, 64);
    uint condval_55;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_55 = vs_w3[1];
    } else {
      condval_55 = vs_cross_4_1;
    }
    vs_w4[1] = condval_55;
    uint condval_56;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_56 = vs_cross_4_1;
    } else {
      condval_56 = vs_w3[5];
    }
    vs_w4[5] = condval_56;
    uint condval_57;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_57 = vs_w3[6];
    } else {
      condval_57 = vs_w3[2];
    }
    uint vs_cross_4_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_57, 8, 64);
    uint condval_58;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_58 = vs_w3[2];
    } else {
      condval_58 = vs_cross_4_2;
    }
    vs_w4[2] = condval_58;
    uint condval_59;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_59 = vs_cross_4_2;
    } else {
      condval_59 = vs_w3[6];
    }
    vs_w4[6] = condval_59;
    uint condval_60;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_60 = vs_w3[7];
    } else {
      condval_60 = vs_w3[3];
    }
    uint vs_cross_4_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_60, 8, 64);
    uint condval_61;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_61 = vs_w3[3];
    } else {
      condval_61 = vs_cross_4_3;
    }
    vs_w4[3] = condval_61;
    uint condval_62;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_62 = vs_cross_4_3;
    } else {
      condval_62 = vs_w3[7];
    }
    vs_w4[7] = condval_62;
    uint condval_63;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_63 = vs_w3[12];
    } else {
      condval_63 = vs_w3[8];
    }
    uint vs_cross_4_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_63, 8, 64);
    uint condval_64;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_64 = vs_w3[8];
    } else {
      condval_64 = vs_cross_4_8;
    }
    vs_w4[8] = condval_64;
    uint condval_65;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_65 = vs_cross_4_8;
    } else {
      condval_65 = vs_w3[12];
    }
    vs_w4[12] = condval_65;
    uint condval_66;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_66 = vs_w3[13];
    } else {
      condval_66 = vs_w3[9];
    }
    uint vs_cross_4_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_66, 8, 64);
    uint condval_67;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_67 = vs_w3[9];
    } else {
      condval_67 = vs_cross_4_9;
    }
    vs_w4[9] = condval_67;
    uint condval_68;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_68 = vs_cross_4_9;
    } else {
      condval_68 = vs_w3[13];
    }
    vs_w4[13] = condval_68;
    uint condval_69;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_69 = vs_w3[14];
    } else {
      condval_69 = vs_w3[10];
    }
    uint vs_cross_4_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_69, 8, 64);
    uint condval_70;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_70 = vs_w3[10];
    } else {
      condval_70 = vs_cross_4_10;
    }
    vs_w4[10] = condval_70;
    uint condval_71;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_71 = vs_cross_4_10;
    } else {
      condval_71 = vs_w3[14];
    }
    vs_w4[14] = condval_71;
    uint condval_72;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_72 = vs_w3[15];
    } else {
      condval_72 = vs_w3[11];
    }
    uint vs_cross_4_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_72, 8, 64);
    uint condval_73;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_73 = vs_w3[11];
    } else {
      condval_73 = vs_cross_4_11;
    }
    vs_w4[11] = condval_73;
    uint condval_74;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_74 = vs_cross_4_11;
    } else {
      condval_74 = vs_w3[15];
    }
    vs_w4[15] = condval_74;
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
    #pragma unroll
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      acc_s[i_5] = exp2f(min((acc_s[i_5] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j = 0; j < 4; ++j) {
      lane_sum[0] = (lane_sum[0] + acc_s[j]);
    }
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
    float condval_75;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_75 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_75 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_75;
    #pragma unroll
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      acc_s[i_6] = (acc_s[i_6] * lane_sum[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + 0) = __1;
    for (int e = 0; e < 4; ++e) {
      *(uint4*)(vb + (e * 8)) = *(uint4*)(vs_mma + (e * 8));
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
  for (int i_7 = 0; i_7 < 8; ++i_7) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_7 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_7 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

