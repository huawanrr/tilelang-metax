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
  uint ks_w0[32];
  half_t V_reg[64];
  uint ks_w1[32];
  uint ks_w2[32];
  half_t ks_mma[64];
  float acc_s[8];
  extern __shared__ __align__(1024) half_t V_shared[];
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
    for (int slot = 0; slot < 8; ++slot) {
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
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_2) < 256)) {
        condval_1 = *(uint4*)(V + (((i_2 * 512) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(V_reg + (i_2 * 8)) = condval_1;
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
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_26 = ks_w0[20];
    } else {
      condval_26 = ks_w0[16];
    }
    uint ks_cross_1_16 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_26, 4, 64);
    uint condval_27;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_27 = ks_w0[16];
    } else {
      condval_27 = ks_cross_1_16;
    }
    ks_w1[16] = condval_27;
    uint condval_28;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_28 = ks_cross_1_16;
    } else {
      condval_28 = ks_w0[20];
    }
    ks_w1[20] = condval_28;
    uint condval_29;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_29 = ks_w0[21];
    } else {
      condval_29 = ks_w0[17];
    }
    uint ks_cross_1_17 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_29, 4, 64);
    uint condval_30;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_30 = ks_w0[17];
    } else {
      condval_30 = ks_cross_1_17;
    }
    ks_w1[17] = condval_30;
    uint condval_31;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_31 = ks_cross_1_17;
    } else {
      condval_31 = ks_w0[21];
    }
    ks_w1[21] = condval_31;
    uint condval_32;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_32 = ks_w0[22];
    } else {
      condval_32 = ks_w0[18];
    }
    uint ks_cross_1_18 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_32, 4, 64);
    uint condval_33;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_33 = ks_w0[18];
    } else {
      condval_33 = ks_cross_1_18;
    }
    ks_w1[18] = condval_33;
    uint condval_34;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_34 = ks_cross_1_18;
    } else {
      condval_34 = ks_w0[22];
    }
    ks_w1[22] = condval_34;
    uint condval_35;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_35 = ks_w0[23];
    } else {
      condval_35 = ks_w0[19];
    }
    uint ks_cross_1_19 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_35, 4, 64);
    uint condval_36;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_36 = ks_w0[19];
    } else {
      condval_36 = ks_cross_1_19;
    }
    ks_w1[19] = condval_36;
    uint condval_37;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_37 = ks_cross_1_19;
    } else {
      condval_37 = ks_w0[23];
    }
    ks_w1[23] = condval_37;
    uint condval_38;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_38 = ks_w0[28];
    } else {
      condval_38 = ks_w0[24];
    }
    uint ks_cross_1_24 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_38, 4, 64);
    uint condval_39;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_39 = ks_w0[24];
    } else {
      condval_39 = ks_cross_1_24;
    }
    ks_w1[24] = condval_39;
    uint condval_40;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_40 = ks_cross_1_24;
    } else {
      condval_40 = ks_w0[28];
    }
    ks_w1[28] = condval_40;
    uint condval_41;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_41 = ks_w0[29];
    } else {
      condval_41 = ks_w0[25];
    }
    uint ks_cross_1_25 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_41, 4, 64);
    uint condval_42;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_42 = ks_w0[25];
    } else {
      condval_42 = ks_cross_1_25;
    }
    ks_w1[25] = condval_42;
    uint condval_43;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_43 = ks_cross_1_25;
    } else {
      condval_43 = ks_w0[29];
    }
    ks_w1[29] = condval_43;
    uint condval_44;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_44 = ks_w0[30];
    } else {
      condval_44 = ks_w0[26];
    }
    uint ks_cross_1_26 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_44, 4, 64);
    uint condval_45;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_45 = ks_w0[26];
    } else {
      condval_45 = ks_cross_1_26;
    }
    ks_w1[26] = condval_45;
    uint condval_46;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_46 = ks_cross_1_26;
    } else {
      condval_46 = ks_w0[30];
    }
    ks_w1[30] = condval_46;
    uint condval_47;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_47 = ks_w0[31];
    } else {
      condval_47 = ks_w0[27];
    }
    uint ks_cross_1_27 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_47, 4, 64);
    uint condval_48;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_48 = ks_w0[27];
    } else {
      condval_48 = ks_cross_1_27;
    }
    ks_w1[27] = condval_48;
    uint condval_49;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_49 = ks_cross_1_27;
    } else {
      condval_49 = ks_w0[31];
    }
    ks_w1[31] = condval_49;
    uint condval_50;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_50 = ks_w1[8];
    } else {
      condval_50 = ks_w1[0];
    }
    uint ks_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_50, 8, 64);
    uint condval_51;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_51 = ks_w1[0];
    } else {
      condval_51 = ks_cross_2_0;
    }
    ks_w2[0] = condval_51;
    uint condval_52;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_52 = ks_cross_2_0;
    } else {
      condval_52 = ks_w1[8];
    }
    ks_w2[8] = condval_52;
    uint condval_53;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_53 = ks_w1[9];
    } else {
      condval_53 = ks_w1[1];
    }
    uint ks_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_53, 8, 64);
    uint condval_54;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_54 = ks_w1[1];
    } else {
      condval_54 = ks_cross_2_1;
    }
    ks_w2[1] = condval_54;
    uint condval_55;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_55 = ks_cross_2_1;
    } else {
      condval_55 = ks_w1[9];
    }
    ks_w2[9] = condval_55;
    uint condval_56;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_56 = ks_w1[10];
    } else {
      condval_56 = ks_w1[2];
    }
    uint ks_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_56, 8, 64);
    uint condval_57;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_57 = ks_w1[2];
    } else {
      condval_57 = ks_cross_2_2;
    }
    ks_w2[2] = condval_57;
    uint condval_58;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_58 = ks_cross_2_2;
    } else {
      condval_58 = ks_w1[10];
    }
    ks_w2[10] = condval_58;
    uint condval_59;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_59 = ks_w1[11];
    } else {
      condval_59 = ks_w1[3];
    }
    uint ks_cross_2_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_59, 8, 64);
    uint condval_60;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_60 = ks_w1[3];
    } else {
      condval_60 = ks_cross_2_3;
    }
    ks_w2[3] = condval_60;
    uint condval_61;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_61 = ks_cross_2_3;
    } else {
      condval_61 = ks_w1[11];
    }
    ks_w2[11] = condval_61;
    uint condval_62;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_62 = ks_w1[12];
    } else {
      condval_62 = ks_w1[4];
    }
    uint ks_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_62, 8, 64);
    uint condval_63;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_63 = ks_w1[4];
    } else {
      condval_63 = ks_cross_2_4;
    }
    ks_w2[4] = condval_63;
    uint condval_64;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_64 = ks_cross_2_4;
    } else {
      condval_64 = ks_w1[12];
    }
    ks_w2[12] = condval_64;
    uint condval_65;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_65 = ks_w1[13];
    } else {
      condval_65 = ks_w1[5];
    }
    uint ks_cross_2_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_65, 8, 64);
    uint condval_66;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_66 = ks_w1[5];
    } else {
      condval_66 = ks_cross_2_5;
    }
    ks_w2[5] = condval_66;
    uint condval_67;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_67 = ks_cross_2_5;
    } else {
      condval_67 = ks_w1[13];
    }
    ks_w2[13] = condval_67;
    uint condval_68;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_68 = ks_w1[14];
    } else {
      condval_68 = ks_w1[6];
    }
    uint ks_cross_2_6 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_68, 8, 64);
    uint condval_69;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_69 = ks_w1[6];
    } else {
      condval_69 = ks_cross_2_6;
    }
    ks_w2[6] = condval_69;
    uint condval_70;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_70 = ks_cross_2_6;
    } else {
      condval_70 = ks_w1[14];
    }
    ks_w2[14] = condval_70;
    uint condval_71;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_71 = ks_w1[15];
    } else {
      condval_71 = ks_w1[7];
    }
    uint ks_cross_2_7 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_71, 8, 64);
    uint condval_72;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_72 = ks_w1[7];
    } else {
      condval_72 = ks_cross_2_7;
    }
    ks_w2[7] = condval_72;
    uint condval_73;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_73 = ks_cross_2_7;
    } else {
      condval_73 = ks_w1[15];
    }
    ks_w2[15] = condval_73;
    uint condval_74;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_74 = ks_w1[24];
    } else {
      condval_74 = ks_w1[16];
    }
    uint ks_cross_2_16 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_74, 8, 64);
    uint condval_75;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_75 = ks_w1[16];
    } else {
      condval_75 = ks_cross_2_16;
    }
    ks_w2[16] = condval_75;
    uint condval_76;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_76 = ks_cross_2_16;
    } else {
      condval_76 = ks_w1[24];
    }
    ks_w2[24] = condval_76;
    uint condval_77;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_77 = ks_w1[25];
    } else {
      condval_77 = ks_w1[17];
    }
    uint ks_cross_2_17 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_77, 8, 64);
    uint condval_78;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_78 = ks_w1[17];
    } else {
      condval_78 = ks_cross_2_17;
    }
    ks_w2[17] = condval_78;
    uint condval_79;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_79 = ks_cross_2_17;
    } else {
      condval_79 = ks_w1[25];
    }
    ks_w2[25] = condval_79;
    uint condval_80;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_80 = ks_w1[26];
    } else {
      condval_80 = ks_w1[18];
    }
    uint ks_cross_2_18 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_80, 8, 64);
    uint condval_81;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_81 = ks_w1[18];
    } else {
      condval_81 = ks_cross_2_18;
    }
    ks_w2[18] = condval_81;
    uint condval_82;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_82 = ks_cross_2_18;
    } else {
      condval_82 = ks_w1[26];
    }
    ks_w2[26] = condval_82;
    uint condval_83;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_83 = ks_w1[27];
    } else {
      condval_83 = ks_w1[19];
    }
    uint ks_cross_2_19 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_83, 8, 64);
    uint condval_84;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_84 = ks_w1[19];
    } else {
      condval_84 = ks_cross_2_19;
    }
    ks_w2[19] = condval_84;
    uint condval_85;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_85 = ks_cross_2_19;
    } else {
      condval_85 = ks_w1[27];
    }
    ks_w2[27] = condval_85;
    uint condval_86;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_86 = ks_w1[28];
    } else {
      condval_86 = ks_w1[20];
    }
    uint ks_cross_2_20 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_86, 8, 64);
    uint condval_87;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_87 = ks_w1[20];
    } else {
      condval_87 = ks_cross_2_20;
    }
    ks_w2[20] = condval_87;
    uint condval_88;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_88 = ks_cross_2_20;
    } else {
      condval_88 = ks_w1[28];
    }
    ks_w2[28] = condval_88;
    uint condval_89;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_89 = ks_w1[29];
    } else {
      condval_89 = ks_w1[21];
    }
    uint ks_cross_2_21 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_89, 8, 64);
    uint condval_90;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_90 = ks_w1[21];
    } else {
      condval_90 = ks_cross_2_21;
    }
    ks_w2[21] = condval_90;
    uint condval_91;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_91 = ks_cross_2_21;
    } else {
      condval_91 = ks_w1[29];
    }
    ks_w2[29] = condval_91;
    uint condval_92;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_92 = ks_w1[30];
    } else {
      condval_92 = ks_w1[22];
    }
    uint ks_cross_2_22 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_92, 8, 64);
    uint condval_93;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_93 = ks_w1[22];
    } else {
      condval_93 = ks_cross_2_22;
    }
    ks_w2[22] = condval_93;
    uint condval_94;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_94 = ks_cross_2_22;
    } else {
      condval_94 = ks_w1[30];
    }
    ks_w2[30] = condval_94;
    uint condval_95;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_95 = ks_w1[31];
    } else {
      condval_95 = ks_w1[23];
    }
    uint ks_cross_2_23 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_95, 8, 64);
    uint condval_96;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_96 = ks_w1[23];
    } else {
      condval_96 = ks_cross_2_23;
    }
    ks_w2[23] = condval_96;
    uint condval_97;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_97 = ks_cross_2_23;
    } else {
      condval_97 = ks_w1[31];
    }
    ks_w2[31] = condval_97;
    ((uint*)ks_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[0], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[1], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[2], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[3], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[16], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[17], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[18], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[19], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[8] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[4], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[9] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[5], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[10] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[6], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[11] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[7], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[12] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[20], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[13] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[21], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[14] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[22], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[15] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[23], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[16] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[8], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[17] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[9], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[18] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[10], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[19] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[11], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[20] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[24], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[21] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[25], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[22] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[26], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[23] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[27], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[24] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[12], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[25] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[13], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[26] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[14], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[27] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[15], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[28] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[28], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[29] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[29], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[30] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[30], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)ks_mma)[31] = __shfl_sync((uint64_t)18446744073709551615, ks_w2[31], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    if (((int)blockIdx.x) < (i_s + 31)) {
      #pragma unroll
      for (int i_3 = 0; i_3 < 8; ++i_3) {
        float condval_98;
        if (((((((i_3 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_s) + (i_3 & 3)) <= ((int)blockIdx.x))) {
          condval_98 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_98 = -MACART_INF_F;
        }
        acc_s[i_3] = condval_98;
      }
    } else {
      #pragma unroll
      for (int i_4 = 0; i_4 < 2; ++i_4) {
        float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + (i_4 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
      }
    }
    #pragma unroll
    for (int ki = 0; ki < 4; ++ki) {
      for (int e = 0; e < 2; ++e) {
        *(uint4*)(kb + (e * 8)) = *(uint4*)(ks_mma + ((ki * 16) + (e * 8)));
      }
      for (int kp = 0; kp < 2; ++kp) {
        for (int j = 0; j < 2; ++j) {
          {
      *(((float32x4*)acc_s) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + j));
    };
        }
      }
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 8; ++i_5) {
      *(uint4*)(V_shared + (((i_5 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_5 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(V_reg + (i_5 * 8));
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      acc_s[i_6] = exp2f(min((acc_s[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int k = 0; k < 2; ++k) {
      #pragma unroll
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        lane_sum[0] = (lane_sum[0] + acc_s[((k * 4) + j_1)]);
      }
    }
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
    float condval_99;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_99 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_99 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_99;
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
    __syncthreads();
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_2 = 0; j_2 < 8; ++j_2) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          vb[((j_2 * 4) + local_id)] = V_shared[(((((ki_1 * 2048) + ((((int)threadIdx.x) >> 4) * 512)) + (local_id * 128)) + ((((j_2 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ (((((int)threadIdx.x) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
        }
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

