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
  uint qr_w0[16];
  float acc_o[32];
  int _start_buffer_0[1];
  uint kr_w0[16];
  half_t V_reg[32];
  uint qr_w1[16];
  uint qr_w2[16];
  half_t qr_mma[32];
  half_t Q_reg[32];
  uint kr_w1[16];
  uint kr_w2[16];
  half_t kr_mma[32];
  float acc_s[4];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t O_reg[32];
  half_t kb[8];
  half_t vb[32];
  #pragma unroll
  for (int slot = 0; slot < 4; ++slot) {
    *(uint4*)(((half_t*)qr_w0) + (slot * 8)) = *(uint4*)(Q + ((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + (slot * 512)) + (((int)threadIdx.x) * 8)));
  }
  int _selected_block = BlockIndices[((((int)blockIdx.z) * 1024) + ((int)blockIdx.x))];
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= _selected_block) && (_selected_block < 64)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
    _start_buffer_0[0] = (_selected_block * 16);
    #pragma unroll
    for (int slot_1 = 0; slot_1 < 4; ++slot_1) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + slot_1) < 256) && (0 <= (((slot_1 * 4) + (((int)threadIdx.x) >> 4)) + _start_buffer_0[0]))) && (((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + slot_1) < 256))) {
        condval = *(uint4*)(K + ((((((int64_t)((int)blockIdx.z)) * (int64_t)131072) + (((int64_t)slot_1) * (int64_t)512)) + (((int64_t)_start_buffer_0[(int64_t)0]) * (int64_t)128)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(((half_t*)kr_w0) + (slot_1 * 8)) = condval;
    }
    #pragma unroll
    for (int i_1 = 0; i_1 < 4; ++i_1) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if (((((((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + i_1) < 256) && (0 <= (((i_1 * 4) + (((int)threadIdx.x) >> 4)) + _start_buffer_0[0]))) && (0 <= (((i_1 * 4) + (((int)threadIdx.x) >> 4)) + _start_buffer_0[0]))) && (((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + i_1) < 256))) {
        condval_1 = *(uint4*)(V + ((((((int64_t)((int)blockIdx.z)) * (int64_t)131072) + (((int64_t)i_1) * (int64_t)512)) + (((int64_t)_start_buffer_0[(int64_t)0]) * (int64_t)128)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(V_reg + (i_1 * 8)) = condval_1;
    }
    uint condval_2;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_2 = qr_w0[4];
    } else {
      condval_2 = qr_w0[0];
    }
    uint qr_cross_1_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_2, 4, 64);
    uint condval_3;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_3 = qr_w0[0];
    } else {
      condval_3 = qr_cross_1_0;
    }
    qr_w1[0] = condval_3;
    uint condval_4;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_4 = qr_cross_1_0;
    } else {
      condval_4 = qr_w0[4];
    }
    qr_w1[4] = condval_4;
    uint condval_5;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_5 = qr_w0[5];
    } else {
      condval_5 = qr_w0[1];
    }
    uint qr_cross_1_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_5, 4, 64);
    uint condval_6;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_6 = qr_w0[1];
    } else {
      condval_6 = qr_cross_1_1;
    }
    qr_w1[1] = condval_6;
    uint condval_7;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_7 = qr_cross_1_1;
    } else {
      condval_7 = qr_w0[5];
    }
    qr_w1[5] = condval_7;
    uint condval_8;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_8 = qr_w0[6];
    } else {
      condval_8 = qr_w0[2];
    }
    uint qr_cross_1_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_8, 4, 64);
    uint condval_9;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_9 = qr_w0[2];
    } else {
      condval_9 = qr_cross_1_2;
    }
    qr_w1[2] = condval_9;
    uint condval_10;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_10 = qr_cross_1_2;
    } else {
      condval_10 = qr_w0[6];
    }
    qr_w1[6] = condval_10;
    uint condval_11;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_11 = qr_w0[7];
    } else {
      condval_11 = qr_w0[3];
    }
    uint qr_cross_1_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_11, 4, 64);
    uint condval_12;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_12 = qr_w0[3];
    } else {
      condval_12 = qr_cross_1_3;
    }
    qr_w1[3] = condval_12;
    uint condval_13;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_13 = qr_cross_1_3;
    } else {
      condval_13 = qr_w0[7];
    }
    qr_w1[7] = condval_13;
    uint condval_14;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_14 = qr_w0[12];
    } else {
      condval_14 = qr_w0[8];
    }
    uint qr_cross_1_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_14, 4, 64);
    uint condval_15;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_15 = qr_w0[8];
    } else {
      condval_15 = qr_cross_1_8;
    }
    qr_w1[8] = condval_15;
    uint condval_16;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_16 = qr_cross_1_8;
    } else {
      condval_16 = qr_w0[12];
    }
    qr_w1[12] = condval_16;
    uint condval_17;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_17 = qr_w0[13];
    } else {
      condval_17 = qr_w0[9];
    }
    uint qr_cross_1_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_17, 4, 64);
    uint condval_18;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_18 = qr_w0[9];
    } else {
      condval_18 = qr_cross_1_9;
    }
    qr_w1[9] = condval_18;
    uint condval_19;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_19 = qr_cross_1_9;
    } else {
      condval_19 = qr_w0[13];
    }
    qr_w1[13] = condval_19;
    uint condval_20;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_20 = qr_w0[14];
    } else {
      condval_20 = qr_w0[10];
    }
    uint qr_cross_1_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_20, 4, 64);
    uint condval_21;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_21 = qr_w0[10];
    } else {
      condval_21 = qr_cross_1_10;
    }
    qr_w1[10] = condval_21;
    uint condval_22;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_22 = qr_cross_1_10;
    } else {
      condval_22 = qr_w0[14];
    }
    qr_w1[14] = condval_22;
    uint condval_23;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_23 = qr_w0[15];
    } else {
      condval_23 = qr_w0[11];
    }
    uint qr_cross_1_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_23, 4, 64);
    uint condval_24;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_24 = qr_w0[11];
    } else {
      condval_24 = qr_cross_1_11;
    }
    qr_w1[11] = condval_24;
    uint condval_25;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_25 = qr_cross_1_11;
    } else {
      condval_25 = qr_w0[15];
    }
    qr_w1[15] = condval_25;
    uint condval_26;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_26 = qr_w1[8];
    } else {
      condval_26 = qr_w1[0];
    }
    uint qr_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_26, 8, 64);
    uint condval_27;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_27 = qr_w1[0];
    } else {
      condval_27 = qr_cross_2_0;
    }
    qr_w2[0] = condval_27;
    uint condval_28;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_28 = qr_cross_2_0;
    } else {
      condval_28 = qr_w1[8];
    }
    qr_w2[8] = condval_28;
    uint condval_29;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_29 = qr_w1[9];
    } else {
      condval_29 = qr_w1[1];
    }
    uint qr_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_29, 8, 64);
    uint condval_30;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_30 = qr_w1[1];
    } else {
      condval_30 = qr_cross_2_1;
    }
    qr_w2[1] = condval_30;
    uint condval_31;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_31 = qr_cross_2_1;
    } else {
      condval_31 = qr_w1[9];
    }
    qr_w2[9] = condval_31;
    uint condval_32;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_32 = qr_w1[10];
    } else {
      condval_32 = qr_w1[2];
    }
    uint qr_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_32, 8, 64);
    uint condval_33;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_33 = qr_w1[2];
    } else {
      condval_33 = qr_cross_2_2;
    }
    qr_w2[2] = condval_33;
    uint condval_34;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_34 = qr_cross_2_2;
    } else {
      condval_34 = qr_w1[10];
    }
    qr_w2[10] = condval_34;
    uint condval_35;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_35 = qr_w1[11];
    } else {
      condval_35 = qr_w1[3];
    }
    uint qr_cross_2_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_35, 8, 64);
    uint condval_36;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_36 = qr_w1[3];
    } else {
      condval_36 = qr_cross_2_3;
    }
    qr_w2[3] = condval_36;
    uint condval_37;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_37 = qr_cross_2_3;
    } else {
      condval_37 = qr_w1[11];
    }
    qr_w2[11] = condval_37;
    uint condval_38;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_38 = qr_w1[12];
    } else {
      condval_38 = qr_w1[4];
    }
    uint qr_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_38, 8, 64);
    uint condval_39;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_39 = qr_w1[4];
    } else {
      condval_39 = qr_cross_2_4;
    }
    qr_w2[4] = condval_39;
    uint condval_40;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_40 = qr_cross_2_4;
    } else {
      condval_40 = qr_w1[12];
    }
    qr_w2[12] = condval_40;
    uint condval_41;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_41 = qr_w1[13];
    } else {
      condval_41 = qr_w1[5];
    }
    uint qr_cross_2_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_41, 8, 64);
    uint condval_42;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_42 = qr_w1[5];
    } else {
      condval_42 = qr_cross_2_5;
    }
    qr_w2[5] = condval_42;
    uint condval_43;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_43 = qr_cross_2_5;
    } else {
      condval_43 = qr_w1[13];
    }
    qr_w2[13] = condval_43;
    uint condval_44;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_44 = qr_w1[14];
    } else {
      condval_44 = qr_w1[6];
    }
    uint qr_cross_2_6 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_44, 8, 64);
    uint condval_45;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_45 = qr_w1[6];
    } else {
      condval_45 = qr_cross_2_6;
    }
    qr_w2[6] = condval_45;
    uint condval_46;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_46 = qr_cross_2_6;
    } else {
      condval_46 = qr_w1[14];
    }
    qr_w2[14] = condval_46;
    uint condval_47;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_47 = qr_w1[15];
    } else {
      condval_47 = qr_w1[7];
    }
    uint qr_cross_2_7 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_47, 8, 64);
    uint condval_48;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_48 = qr_w1[7];
    } else {
      condval_48 = qr_cross_2_7;
    }
    qr_w2[7] = condval_48;
    uint condval_49;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_49 = qr_cross_2_7;
    } else {
      condval_49 = qr_w1[15];
    }
    qr_w2[15] = condval_49;
    ((uint*)qr_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[0], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[1], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[2], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[3], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[4], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[5], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[6], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[7], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[8] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[8], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[9] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[9], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[10] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[10], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[11] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[11], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[12] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[12], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[13] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[13], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[14] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[14], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[15] = __shfl_sync((uint64_t)18446744073709551615, qr_w2[15], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    #pragma unroll
    for (int i_2 = 0; i_2 < 32; ++i_2) {
      Q_reg[i_2] = qr_mma[i_2];
    }
    uint condval_50;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_50 = kr_w0[4];
    } else {
      condval_50 = kr_w0[0];
    }
    uint kr_cross_1_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_50, 4, 64);
    uint condval_51;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_51 = kr_w0[0];
    } else {
      condval_51 = kr_cross_1_0;
    }
    kr_w1[0] = condval_51;
    uint condval_52;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_52 = kr_cross_1_0;
    } else {
      condval_52 = kr_w0[4];
    }
    kr_w1[4] = condval_52;
    uint condval_53;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_53 = kr_w0[5];
    } else {
      condval_53 = kr_w0[1];
    }
    uint kr_cross_1_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_53, 4, 64);
    uint condval_54;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_54 = kr_w0[1];
    } else {
      condval_54 = kr_cross_1_1;
    }
    kr_w1[1] = condval_54;
    uint condval_55;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_55 = kr_cross_1_1;
    } else {
      condval_55 = kr_w0[5];
    }
    kr_w1[5] = condval_55;
    uint condval_56;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_56 = kr_w0[6];
    } else {
      condval_56 = kr_w0[2];
    }
    uint kr_cross_1_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_56, 4, 64);
    uint condval_57;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_57 = kr_w0[2];
    } else {
      condval_57 = kr_cross_1_2;
    }
    kr_w1[2] = condval_57;
    uint condval_58;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_58 = kr_cross_1_2;
    } else {
      condval_58 = kr_w0[6];
    }
    kr_w1[6] = condval_58;
    uint condval_59;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_59 = kr_w0[7];
    } else {
      condval_59 = kr_w0[3];
    }
    uint kr_cross_1_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_59, 4, 64);
    uint condval_60;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_60 = kr_w0[3];
    } else {
      condval_60 = kr_cross_1_3;
    }
    kr_w1[3] = condval_60;
    uint condval_61;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_61 = kr_cross_1_3;
    } else {
      condval_61 = kr_w0[7];
    }
    kr_w1[7] = condval_61;
    uint condval_62;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_62 = kr_w0[12];
    } else {
      condval_62 = kr_w0[8];
    }
    uint kr_cross_1_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_62, 4, 64);
    uint condval_63;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_63 = kr_w0[8];
    } else {
      condval_63 = kr_cross_1_8;
    }
    kr_w1[8] = condval_63;
    uint condval_64;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_64 = kr_cross_1_8;
    } else {
      condval_64 = kr_w0[12];
    }
    kr_w1[12] = condval_64;
    uint condval_65;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_65 = kr_w0[13];
    } else {
      condval_65 = kr_w0[9];
    }
    uint kr_cross_1_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_65, 4, 64);
    uint condval_66;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_66 = kr_w0[9];
    } else {
      condval_66 = kr_cross_1_9;
    }
    kr_w1[9] = condval_66;
    uint condval_67;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_67 = kr_cross_1_9;
    } else {
      condval_67 = kr_w0[13];
    }
    kr_w1[13] = condval_67;
    uint condval_68;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_68 = kr_w0[14];
    } else {
      condval_68 = kr_w0[10];
    }
    uint kr_cross_1_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_68, 4, 64);
    uint condval_69;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_69 = kr_w0[10];
    } else {
      condval_69 = kr_cross_1_10;
    }
    kr_w1[10] = condval_69;
    uint condval_70;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_70 = kr_cross_1_10;
    } else {
      condval_70 = kr_w0[14];
    }
    kr_w1[14] = condval_70;
    uint condval_71;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_71 = kr_w0[15];
    } else {
      condval_71 = kr_w0[11];
    }
    uint kr_cross_1_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_71, 4, 64);
    uint condval_72;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_72 = kr_w0[11];
    } else {
      condval_72 = kr_cross_1_11;
    }
    kr_w1[11] = condval_72;
    uint condval_73;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_73 = kr_cross_1_11;
    } else {
      condval_73 = kr_w0[15];
    }
    kr_w1[15] = condval_73;
    uint condval_74;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_74 = kr_w1[8];
    } else {
      condval_74 = kr_w1[0];
    }
    uint kr_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_74, 8, 64);
    uint condval_75;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_75 = kr_w1[0];
    } else {
      condval_75 = kr_cross_2_0;
    }
    kr_w2[0] = condval_75;
    uint condval_76;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_76 = kr_cross_2_0;
    } else {
      condval_76 = kr_w1[8];
    }
    kr_w2[8] = condval_76;
    uint condval_77;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_77 = kr_w1[9];
    } else {
      condval_77 = kr_w1[1];
    }
    uint kr_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_77, 8, 64);
    uint condval_78;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_78 = kr_w1[1];
    } else {
      condval_78 = kr_cross_2_1;
    }
    kr_w2[1] = condval_78;
    uint condval_79;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_79 = kr_cross_2_1;
    } else {
      condval_79 = kr_w1[9];
    }
    kr_w2[9] = condval_79;
    uint condval_80;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_80 = kr_w1[10];
    } else {
      condval_80 = kr_w1[2];
    }
    uint kr_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_80, 8, 64);
    uint condval_81;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_81 = kr_w1[2];
    } else {
      condval_81 = kr_cross_2_2;
    }
    kr_w2[2] = condval_81;
    uint condval_82;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_82 = kr_cross_2_2;
    } else {
      condval_82 = kr_w1[10];
    }
    kr_w2[10] = condval_82;
    uint condval_83;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_83 = kr_w1[11];
    } else {
      condval_83 = kr_w1[3];
    }
    uint kr_cross_2_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_83, 8, 64);
    uint condval_84;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_84 = kr_w1[3];
    } else {
      condval_84 = kr_cross_2_3;
    }
    kr_w2[3] = condval_84;
    uint condval_85;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_85 = kr_cross_2_3;
    } else {
      condval_85 = kr_w1[11];
    }
    kr_w2[11] = condval_85;
    uint condval_86;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_86 = kr_w1[12];
    } else {
      condval_86 = kr_w1[4];
    }
    uint kr_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_86, 8, 64);
    uint condval_87;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_87 = kr_w1[4];
    } else {
      condval_87 = kr_cross_2_4;
    }
    kr_w2[4] = condval_87;
    uint condval_88;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_88 = kr_cross_2_4;
    } else {
      condval_88 = kr_w1[12];
    }
    kr_w2[12] = condval_88;
    uint condval_89;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_89 = kr_w1[13];
    } else {
      condval_89 = kr_w1[5];
    }
    uint kr_cross_2_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_89, 8, 64);
    uint condval_90;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_90 = kr_w1[5];
    } else {
      condval_90 = kr_cross_2_5;
    }
    kr_w2[5] = condval_90;
    uint condval_91;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_91 = kr_cross_2_5;
    } else {
      condval_91 = kr_w1[13];
    }
    kr_w2[13] = condval_91;
    uint condval_92;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_92 = kr_w1[14];
    } else {
      condval_92 = kr_w1[6];
    }
    uint kr_cross_2_6 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_92, 8, 64);
    uint condval_93;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_93 = kr_w1[6];
    } else {
      condval_93 = kr_cross_2_6;
    }
    kr_w2[6] = condval_93;
    uint condval_94;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_94 = kr_cross_2_6;
    } else {
      condval_94 = kr_w1[14];
    }
    kr_w2[14] = condval_94;
    uint condval_95;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_95 = kr_w1[15];
    } else {
      condval_95 = kr_w1[7];
    }
    uint kr_cross_2_7 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_95, 8, 64);
    uint condval_96;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_96 = kr_w1[7];
    } else {
      condval_96 = kr_cross_2_7;
    }
    kr_w2[7] = condval_96;
    uint condval_97;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_97 = kr_cross_2_7;
    } else {
      condval_97 = kr_w1[15];
    }
    kr_w2[15] = condval_97;
    ((uint*)kr_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[0], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[1], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[2], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[3], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[4], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[5], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[6], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[7], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[8] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[8], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[9] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[9], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[10] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[10], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[11] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[11], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[12] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[12], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[13] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[13], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[14] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[14], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[15] = __shfl_sync((uint64_t)18446744073709551615, kr_w2[15], ((((((int)threadIdx.x) & 3) * 16) + (((((int)threadIdx.x) & 15) >> 2) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    if (((int)blockIdx.x) < (_start_buffer_0[0] + 15)) {
      #pragma unroll
      for (int i_3 = 0; i_3 < 4; ++i_3) {
        float condval_98;
        if ((((((((int)threadIdx.x) >> 4) * 4) + _start_buffer_0[0]) + i_3) <= ((int)blockIdx.x))) {
          condval_98 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_98 = -MACART_INF_F;
        }
        acc_s[i_3] = condval_98;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
    #pragma unroll
    for (int ki = 0; ki < 4; ++ki) {
      *(uint4*)(kb + 0) = *(uint4*)(kr_mma + (ki * 8));
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + kp),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 4; ++i_4) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((i_4 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_reg + (i_4 * 8));
    }
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
    float condval_99;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_99 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_99 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_99;
    #pragma unroll
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      acc_s[i_6] = (acc_s[i_6] * lane_sum[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + 0) = __1;
    __syncwarp();
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 8; ++i_7) {
    float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_7 * 4)) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
  }
  if (((0 <= _selected_block) && (_selected_block < 64)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
    for (int j_1 = 0; j_1 < 8; ++j_1) {
      for (int e = 0; e < 4; ++e) {
        vb[((j_1 * 4) + e)] = ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) >> 4) * 512) + (e * 128)) + (j_1 * 16)) + (((int)threadIdx.x) & 15))];
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
    *(uint2*)(O_reg + (i_8 * 4)) = __2;
  }
  __syncwarp();
  #pragma unroll
  for (int i_9 = 0; i_9 < 8; ++i_9) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_9 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_9 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_10 = 0; i_10 < 4; ++i_10) {
    *(uint4*)(Output + ((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + (i_10 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_10 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_10 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
  }
}

