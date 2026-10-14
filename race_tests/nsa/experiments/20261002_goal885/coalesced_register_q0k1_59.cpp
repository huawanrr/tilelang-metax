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
  half_t Q_stage[32];
  float acc_o[32];
  int _start_buffer_0[1];
  uint kr_w0[16];
  half_t V_reg[32];
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
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(Q_stage + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + (i * 512)) + (((int)threadIdx.x) * 8)));
  }
  int _selected_block = BlockIndices[((((int)blockIdx.z) * 1024) + ((int)blockIdx.x))];
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= _selected_block) && (_selected_block < 64)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
    _start_buffer_0[0] = (_selected_block * 16);
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + slot) < 256) && (0 <= (((slot * 4) + (((int)threadIdx.x) >> 4)) + _start_buffer_0[0]))) && (((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + slot) < 256))) {
        condval = *(uint4*)(K + ((((((int64_t)((int)blockIdx.z)) * (int64_t)131072) + (((int64_t)slot) * (int64_t)512)) + (((int64_t)_start_buffer_0[(int64_t)0]) * (int64_t)128)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(((half_t*)kr_w0) + (slot * 8)) = condval;
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if (((((((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + i_2) < 256) && (0 <= (((i_2 * 4) + (((int)threadIdx.x) >> 4)) + _start_buffer_0[0]))) && (0 <= (((i_2 * 4) + (((int)threadIdx.x) >> 4)) + _start_buffer_0[0]))) && (((((((int)threadIdx.x) >> 4) + _start_buffer_0[0]) >> 2) + i_2) < 256))) {
        condval_1 = *(uint4*)(V + ((((((int64_t)((int)blockIdx.z)) * (int64_t)131072) + (((int64_t)i_2) * (int64_t)512)) + (((int64_t)_start_buffer_0[(int64_t)0]) * (int64_t)128)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(V_reg + (i_2 * 8)) = condval_1;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_3 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_3 * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(Q_stage + (i_3 * 8));
    }
    __syncwarp();
    #pragma unroll
    for (int i_4 = 0; i_4 < 4; ++i_4) {
      *(uint4*)(Q_reg + (i_4 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 128) + ((((i_4 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
    }
    __syncwarp();
    uint condval_2;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_2 = kr_w0[4];
    } else {
      condval_2 = kr_w0[0];
    }
    uint kr_cross_1_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_2, 4, 64);
    uint condval_3;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_3 = kr_w0[0];
    } else {
      condval_3 = kr_cross_1_0;
    }
    kr_w1[0] = condval_3;
    uint condval_4;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_4 = kr_cross_1_0;
    } else {
      condval_4 = kr_w0[4];
    }
    kr_w1[4] = condval_4;
    uint condval_5;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_5 = kr_w0[5];
    } else {
      condval_5 = kr_w0[1];
    }
    uint kr_cross_1_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_5, 4, 64);
    uint condval_6;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_6 = kr_w0[1];
    } else {
      condval_6 = kr_cross_1_1;
    }
    kr_w1[1] = condval_6;
    uint condval_7;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_7 = kr_cross_1_1;
    } else {
      condval_7 = kr_w0[5];
    }
    kr_w1[5] = condval_7;
    uint condval_8;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_8 = kr_w0[6];
    } else {
      condval_8 = kr_w0[2];
    }
    uint kr_cross_1_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_8, 4, 64);
    uint condval_9;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_9 = kr_w0[2];
    } else {
      condval_9 = kr_cross_1_2;
    }
    kr_w1[2] = condval_9;
    uint condval_10;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_10 = kr_cross_1_2;
    } else {
      condval_10 = kr_w0[6];
    }
    kr_w1[6] = condval_10;
    uint condval_11;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_11 = kr_w0[7];
    } else {
      condval_11 = kr_w0[3];
    }
    uint kr_cross_1_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_11, 4, 64);
    uint condval_12;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_12 = kr_w0[3];
    } else {
      condval_12 = kr_cross_1_3;
    }
    kr_w1[3] = condval_12;
    uint condval_13;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_13 = kr_cross_1_3;
    } else {
      condval_13 = kr_w0[7];
    }
    kr_w1[7] = condval_13;
    uint condval_14;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_14 = kr_w0[12];
    } else {
      condval_14 = kr_w0[8];
    }
    uint kr_cross_1_8 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_14, 4, 64);
    uint condval_15;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_15 = kr_w0[8];
    } else {
      condval_15 = kr_cross_1_8;
    }
    kr_w1[8] = condval_15;
    uint condval_16;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_16 = kr_cross_1_8;
    } else {
      condval_16 = kr_w0[12];
    }
    kr_w1[12] = condval_16;
    uint condval_17;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_17 = kr_w0[13];
    } else {
      condval_17 = kr_w0[9];
    }
    uint kr_cross_1_9 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_17, 4, 64);
    uint condval_18;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_18 = kr_w0[9];
    } else {
      condval_18 = kr_cross_1_9;
    }
    kr_w1[9] = condval_18;
    uint condval_19;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_19 = kr_cross_1_9;
    } else {
      condval_19 = kr_w0[13];
    }
    kr_w1[13] = condval_19;
    uint condval_20;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_20 = kr_w0[14];
    } else {
      condval_20 = kr_w0[10];
    }
    uint kr_cross_1_10 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_20, 4, 64);
    uint condval_21;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_21 = kr_w0[10];
    } else {
      condval_21 = kr_cross_1_10;
    }
    kr_w1[10] = condval_21;
    uint condval_22;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_22 = kr_cross_1_10;
    } else {
      condval_22 = kr_w0[14];
    }
    kr_w1[14] = condval_22;
    uint condval_23;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_23 = kr_w0[15];
    } else {
      condval_23 = kr_w0[11];
    }
    uint kr_cross_1_11 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_23, 4, 64);
    uint condval_24;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_24 = kr_w0[11];
    } else {
      condval_24 = kr_cross_1_11;
    }
    kr_w1[11] = condval_24;
    uint condval_25;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_25 = kr_cross_1_11;
    } else {
      condval_25 = kr_w0[15];
    }
    kr_w1[15] = condval_25;
    uint condval_26;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_26 = kr_w1[8];
    } else {
      condval_26 = kr_w1[0];
    }
    uint kr_cross_2_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_26, 8, 64);
    uint condval_27;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_27 = kr_w1[0];
    } else {
      condval_27 = kr_cross_2_0;
    }
    kr_w2[0] = condval_27;
    uint condval_28;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_28 = kr_cross_2_0;
    } else {
      condval_28 = kr_w1[8];
    }
    kr_w2[8] = condval_28;
    uint condval_29;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_29 = kr_w1[9];
    } else {
      condval_29 = kr_w1[1];
    }
    uint kr_cross_2_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_29, 8, 64);
    uint condval_30;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_30 = kr_w1[1];
    } else {
      condval_30 = kr_cross_2_1;
    }
    kr_w2[1] = condval_30;
    uint condval_31;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_31 = kr_cross_2_1;
    } else {
      condval_31 = kr_w1[9];
    }
    kr_w2[9] = condval_31;
    uint condval_32;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_32 = kr_w1[10];
    } else {
      condval_32 = kr_w1[2];
    }
    uint kr_cross_2_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_32, 8, 64);
    uint condval_33;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_33 = kr_w1[2];
    } else {
      condval_33 = kr_cross_2_2;
    }
    kr_w2[2] = condval_33;
    uint condval_34;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_34 = kr_cross_2_2;
    } else {
      condval_34 = kr_w1[10];
    }
    kr_w2[10] = condval_34;
    uint condval_35;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_35 = kr_w1[11];
    } else {
      condval_35 = kr_w1[3];
    }
    uint kr_cross_2_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_35, 8, 64);
    uint condval_36;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_36 = kr_w1[3];
    } else {
      condval_36 = kr_cross_2_3;
    }
    kr_w2[3] = condval_36;
    uint condval_37;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_37 = kr_cross_2_3;
    } else {
      condval_37 = kr_w1[11];
    }
    kr_w2[11] = condval_37;
    uint condval_38;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_38 = kr_w1[12];
    } else {
      condval_38 = kr_w1[4];
    }
    uint kr_cross_2_4 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_38, 8, 64);
    uint condval_39;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_39 = kr_w1[4];
    } else {
      condval_39 = kr_cross_2_4;
    }
    kr_w2[4] = condval_39;
    uint condval_40;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_40 = kr_cross_2_4;
    } else {
      condval_40 = kr_w1[12];
    }
    kr_w2[12] = condval_40;
    uint condval_41;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_41 = kr_w1[13];
    } else {
      condval_41 = kr_w1[5];
    }
    uint kr_cross_2_5 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_41, 8, 64);
    uint condval_42;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_42 = kr_w1[5];
    } else {
      condval_42 = kr_cross_2_5;
    }
    kr_w2[5] = condval_42;
    uint condval_43;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_43 = kr_cross_2_5;
    } else {
      condval_43 = kr_w1[13];
    }
    kr_w2[13] = condval_43;
    uint condval_44;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_44 = kr_w1[14];
    } else {
      condval_44 = kr_w1[6];
    }
    uint kr_cross_2_6 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_44, 8, 64);
    uint condval_45;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_45 = kr_w1[6];
    } else {
      condval_45 = kr_cross_2_6;
    }
    kr_w2[6] = condval_45;
    uint condval_46;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_46 = kr_cross_2_6;
    } else {
      condval_46 = kr_w1[14];
    }
    kr_w2[14] = condval_46;
    uint condval_47;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_47 = kr_w1[15];
    } else {
      condval_47 = kr_w1[7];
    }
    uint kr_cross_2_7 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_47, 8, 64);
    uint condval_48;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_48 = kr_w1[7];
    } else {
      condval_48 = kr_cross_2_7;
    }
    kr_w2[7] = condval_48;
    uint condval_49;
    if (((((int)threadIdx.x) & 8) == 0)) {
      condval_49 = kr_cross_2_7;
    } else {
      condval_49 = kr_w1[15];
    }
    kr_w2[15] = condval_49;
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
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        float condval_50;
        if ((((((((int)threadIdx.x) >> 4) * 4) + _start_buffer_0[0]) + i_5) <= ((int)blockIdx.x))) {
          condval_50 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_50 = -MACART_INF_F;
        }
        acc_s[i_5] = condval_50;
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
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((i_6 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_reg + (i_6 * 8));
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      acc_s[i_7] = exp2f(min((acc_s[i_7] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
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
    for (int i_8 = 0; i_8 < 4; ++i_8) {
      acc_s[i_8] = (acc_s[i_8] * lane_sum[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + 0) = __1;
    __syncwarp();
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 8; ++i_9) {
    float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_9 * 4)) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
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
  for (int i_10 = 0; i_10 < 8; ++i_10) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_10 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(O_reg + (i_10 * 4)) = __2;
  }
  __syncwarp();
  #pragma unroll
  for (int i_11 = 0; i_11 < 8; ++i_11) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_11 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_11 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    *(uint4*)(Output + ((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + (i_12 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_12 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_12 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
  }
}

