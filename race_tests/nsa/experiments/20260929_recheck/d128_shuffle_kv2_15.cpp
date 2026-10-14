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
  uint ks_w0[16];
  uint vs_w0[16];
  uint ks_w1[16];
  uint ks_w2[16];
  half_t ks_mma[32];
  float acc_s[4];
  uint vs_w1[16];
  uint vs_w2[16];
  half_t vs_mma[32];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t kb[8];
  half_t vb[32];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int i_s = (BlockIndices[((int)blockIdx.x)] * 16);
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + slot) < 256)) {
        condval = *(uint4*)(K + (((slot * 512) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(((half_t*)ks_w0) + (slot * 8)) = condval;
    }
    #pragma unroll
    for (int slot_1 = 0; slot_1 < 16; ++slot_1) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint1 condval_1;
      if ((((((int)threadIdx.x) >> 4) + (((slot_1 >> 2) + i_s) >> 2)) < 256)) {
        condval_1 = *(uint1*)(V + (((((((int)threadIdx.x) >> 4) * 512) + (i_s * 128)) + (slot_1 * 32)) + ((((int)threadIdx.x) & 15) * 2)));
      } else {
        condval_1 = make_uint1(__pack_half2(broadcast_var_2, broadcast_var_2));
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
    uint condval_14;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_14 = ks_w0[12];
    } else {
      condval_14 = ks_w0[8];
    }
    uint ks_cross_1_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_14, 4, 64);
    uint condval_15;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_15 = ks_w0[8];
    } else {
      condval_15 = ks_cross_1_8;
    }
    ks_w1[8] = condval_15;
    uint condval_16;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_16 = ks_cross_1_8;
    } else {
      condval_16 = ks_w0[12];
    }
    ks_w1[12] = condval_16;
    uint condval_17;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_17 = ks_w0[13];
    } else {
      condval_17 = ks_w0[9];
    }
    uint ks_cross_1_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_17, 4, 64);
    uint condval_18;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_18 = ks_w0[9];
    } else {
      condval_18 = ks_cross_1_9;
    }
    ks_w1[9] = condval_18;
    uint condval_19;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_19 = ks_cross_1_9;
    } else {
      condval_19 = ks_w0[13];
    }
    ks_w1[13] = condval_19;
    uint condval_20;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_20 = ks_w0[14];
    } else {
      condval_20 = ks_w0[10];
    }
    uint ks_cross_1_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_20, 4, 64);
    uint condval_21;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_21 = ks_w0[10];
    } else {
      condval_21 = ks_cross_1_10;
    }
    ks_w1[10] = condval_21;
    uint condval_22;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_22 = ks_cross_1_10;
    } else {
      condval_22 = ks_w0[14];
    }
    ks_w1[14] = condval_22;
    uint condval_23;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_23 = ks_w0[15];
    } else {
      condval_23 = ks_w0[11];
    }
    uint ks_cross_1_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_23, 4, 64);
    uint condval_24;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_24 = ks_w0[11];
    } else {
      condval_24 = ks_cross_1_11;
    }
    ks_w1[11] = condval_24;
    uint condval_25;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_25 = ks_cross_1_11;
    } else {
      condval_25 = ks_w0[15];
    }
    ks_w1[15] = condval_25;
    uint condval_26;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_26 = ks_w1[8];
    } else {
      condval_26 = ks_w1[0];
    }
    uint ks_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_26, 8, 64);
    uint condval_27;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_27 = ks_w1[0];
    } else {
      condval_27 = ks_cross_2_0;
    }
    ks_w2[0] = condval_27;
    uint condval_28;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_28 = ks_cross_2_0;
    } else {
      condval_28 = ks_w1[8];
    }
    ks_w2[8] = condval_28;
    uint condval_29;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_29 = ks_w1[9];
    } else {
      condval_29 = ks_w1[1];
    }
    uint ks_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_29, 8, 64);
    uint condval_30;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_30 = ks_w1[1];
    } else {
      condval_30 = ks_cross_2_1;
    }
    ks_w2[1] = condval_30;
    uint condval_31;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_31 = ks_cross_2_1;
    } else {
      condval_31 = ks_w1[9];
    }
    ks_w2[9] = condval_31;
    uint condval_32;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_32 = ks_w1[10];
    } else {
      condval_32 = ks_w1[2];
    }
    uint ks_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_32, 8, 64);
    uint condval_33;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_33 = ks_w1[2];
    } else {
      condval_33 = ks_cross_2_2;
    }
    ks_w2[2] = condval_33;
    uint condval_34;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_34 = ks_cross_2_2;
    } else {
      condval_34 = ks_w1[10];
    }
    ks_w2[10] = condval_34;
    uint condval_35;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_35 = ks_w1[11];
    } else {
      condval_35 = ks_w1[3];
    }
    uint ks_cross_2_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_35, 8, 64);
    uint condval_36;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_36 = ks_w1[3];
    } else {
      condval_36 = ks_cross_2_3;
    }
    ks_w2[3] = condval_36;
    uint condval_37;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_37 = ks_cross_2_3;
    } else {
      condval_37 = ks_w1[11];
    }
    ks_w2[11] = condval_37;
    uint condval_38;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_38 = ks_w1[12];
    } else {
      condval_38 = ks_w1[4];
    }
    uint ks_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_38, 8, 64);
    uint condval_39;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_39 = ks_w1[4];
    } else {
      condval_39 = ks_cross_2_4;
    }
    ks_w2[4] = condval_39;
    uint condval_40;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_40 = ks_cross_2_4;
    } else {
      condval_40 = ks_w1[12];
    }
    ks_w2[12] = condval_40;
    uint condval_41;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_41 = ks_w1[13];
    } else {
      condval_41 = ks_w1[5];
    }
    uint ks_cross_2_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_41, 8, 64);
    uint condval_42;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_42 = ks_w1[5];
    } else {
      condval_42 = ks_cross_2_5;
    }
    ks_w2[5] = condval_42;
    uint condval_43;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_43 = ks_cross_2_5;
    } else {
      condval_43 = ks_w1[13];
    }
    ks_w2[13] = condval_43;
    uint condval_44;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_44 = ks_w1[14];
    } else {
      condval_44 = ks_w1[6];
    }
    uint ks_cross_2_6 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_44, 8, 64);
    uint condval_45;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_45 = ks_w1[6];
    } else {
      condval_45 = ks_cross_2_6;
    }
    ks_w2[6] = condval_45;
    uint condval_46;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_46 = ks_cross_2_6;
    } else {
      condval_46 = ks_w1[14];
    }
    ks_w2[14] = condval_46;
    uint condval_47;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_47 = ks_w1[15];
    } else {
      condval_47 = ks_w1[7];
    }
    uint ks_cross_2_7 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_47, 8, 64);
    uint condval_48;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_48 = ks_w1[7];
    } else {
      condval_48 = ks_cross_2_7;
    }
    ks_w2[7] = condval_48;
    uint condval_49;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_49 = ks_cross_2_7;
    } else {
      condval_49 = ks_w1[15];
    }
    ks_w2[15] = condval_49;
    ((uint*)ks_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[0], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[1], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[2], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[3], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[4], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[5], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[6], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[7], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[8] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[8], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[9] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[9], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[10] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[10], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[11] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[11], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[12] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[12], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[13] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[13], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[14] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[14], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[15] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[15], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    if (((int)blockIdx.x) < (i_s + 15)) {
      #pragma unroll
      for (int i_2 = 0; i_2 < 4; ++i_2) {
        float condval_50;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_2) <= ((int)blockIdx.x))) {
          condval_50 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_50 = -MACART_INF_F;
        }
        acc_s[i_2] = condval_50;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
    #pragma unroll
    for (int ki = 0; ki < 4; ++ki) {
      *(uint4*)(kb + 0) = *(uint4*)(ks_mma + (ki * 8));
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
    uint condval_51;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_51 = vs_w1[4];
    } else {
      condval_51 = vs_w1[0];
    }
    uint vs_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_51, 8, 64);
    uint condval_52;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_52 = vs_w1[0];
    } else {
      condval_52 = vs_cross_2_0;
    }
    vs_w2[0] = condval_52;
    uint condval_53;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_53 = vs_cross_2_0;
    } else {
      condval_53 = vs_w1[4];
    }
    vs_w2[4] = condval_53;
    uint condval_54;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_54 = vs_w1[5];
    } else {
      condval_54 = vs_w1[1];
    }
    uint vs_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_54, 8, 64);
    uint condval_55;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_55 = vs_w1[1];
    } else {
      condval_55 = vs_cross_2_1;
    }
    vs_w2[1] = condval_55;
    uint condval_56;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_56 = vs_cross_2_1;
    } else {
      condval_56 = vs_w1[5];
    }
    vs_w2[5] = condval_56;
    uint condval_57;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_57 = vs_w1[6];
    } else {
      condval_57 = vs_w1[2];
    }
    uint vs_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_57, 8, 64);
    uint condval_58;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_58 = vs_w1[2];
    } else {
      condval_58 = vs_cross_2_2;
    }
    vs_w2[2] = condval_58;
    uint condval_59;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_59 = vs_cross_2_2;
    } else {
      condval_59 = vs_w1[6];
    }
    vs_w2[6] = condval_59;
    uint condval_60;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_60 = vs_w1[7];
    } else {
      condval_60 = vs_w1[3];
    }
    uint vs_cross_2_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_60, 8, 64);
    uint condval_61;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_61 = vs_w1[3];
    } else {
      condval_61 = vs_cross_2_3;
    }
    vs_w2[3] = condval_61;
    uint condval_62;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_62 = vs_cross_2_3;
    } else {
      condval_62 = vs_w1[7];
    }
    vs_w2[7] = condval_62;
    uint condval_63;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_63 = vs_w1[12];
    } else {
      condval_63 = vs_w1[8];
    }
    uint vs_cross_2_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_63, 8, 64);
    uint condval_64;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_64 = vs_w1[8];
    } else {
      condval_64 = vs_cross_2_8;
    }
    vs_w2[8] = condval_64;
    uint condval_65;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_65 = vs_cross_2_8;
    } else {
      condval_65 = vs_w1[12];
    }
    vs_w2[12] = condval_65;
    uint condval_66;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_66 = vs_w1[13];
    } else {
      condval_66 = vs_w1[9];
    }
    uint vs_cross_2_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_66, 8, 64);
    uint condval_67;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_67 = vs_w1[9];
    } else {
      condval_67 = vs_cross_2_9;
    }
    vs_w2[9] = condval_67;
    uint condval_68;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_68 = vs_cross_2_9;
    } else {
      condval_68 = vs_w1[13];
    }
    vs_w2[13] = condval_68;
    uint condval_69;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_69 = vs_w1[14];
    } else {
      condval_69 = vs_w1[10];
    }
    uint vs_cross_2_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_69, 8, 64);
    uint condval_70;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_70 = vs_w1[10];
    } else {
      condval_70 = vs_cross_2_10;
    }
    vs_w2[10] = condval_70;
    uint condval_71;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_71 = vs_cross_2_10;
    } else {
      condval_71 = vs_w1[14];
    }
    vs_w2[14] = condval_71;
    uint condval_72;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_72 = vs_w1[15];
    } else {
      condval_72 = vs_w1[11];
    }
    uint vs_cross_2_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_72, 8, 64);
    uint condval_73;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_73 = vs_w1[11];
    } else {
      condval_73 = vs_cross_2_11;
    }
    vs_w2[11] = condval_73;
    uint condval_74;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_74 = vs_cross_2_11;
    } else {
      condval_74 = vs_w1[15];
    }
    vs_w2[15] = condval_74;
    ((uint*)vs_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[0], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[8], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[4], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[12], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[1], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[9], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[5], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[13], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[8] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[2], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[9] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[10], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[10] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[6], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[11] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[14], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[12] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[3], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[13] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[11], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[14] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[7], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    ((uint*)vs_mma)[15] = __shfl_sync((uint64_t)18446744073709551615, vs_w2[15], ((((((int)threadIdx.x) >> 4) * 16) + ((((int)threadIdx.x) & 1) * 8)) + ((((int)threadIdx.x) & 15) >> 1)), 64);
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      acc_s[i_3] = exp2f(min((acc_s[i_3] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
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
    for (int i_4 = 0; i_4 < 4; ++i_4) {
      acc_s[i_4] = (acc_s[i_4] * lane_sum[0]);
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
  for (int i_5 = 0; i_5 < 8; ++i_5) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_5 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + (i_5 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

