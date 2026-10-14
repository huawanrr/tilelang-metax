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
  uint qr_w0[8];
  float acc_o[16];
  int _start_buffer_0[1];
  uint kr_w0[8];
  half_t V_reg[16];
  uint qr_w1[8];
  half_t qr_mma[16];
  half_t Q_reg[16];
  uint kr_w1[8];
  half_t kr_mma[16];
  float acc_s[4];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t O_reg[16];
  half_t kb[8];
  half_t vb[16];
  #pragma unroll
  for (int slot = 0; slot < 2; ++slot) {
    *(uint4*)(((half_t*)qr_w0) + (slot * 8)) = *(uint4*)(Q + (((((int)blockIdx.x) * 1024) + (slot * 512)) + (((int)threadIdx.x) * 8)));
  }
  int _selected_block = BlockIndices[((int)blockIdx.x)];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= _selected_block) && (_selected_block < 512)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
    _start_buffer_0[0] = (_selected_block * 16);
    #pragma unroll
    for (int slot_1 = 0; slot_1 < 2; ++slot_1) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((((int)threadIdx.x) >> 3) + _start_buffer_0[0]) >> 3) + slot_1) < 1024) && (0 <= (((slot_1 * 8) + (((int)threadIdx.x) >> 3)) + _start_buffer_0[0]))) && (((((((int)threadIdx.x) >> 3) + _start_buffer_0[0]) >> 3) + slot_1) < 1024))) {
        condval = *(uint4*)(K + (((((int64_t)slot_1) * (int64_t)512) + (((int64_t)_start_buffer_0[(int64_t)0]) * (int64_t)64)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(((half_t*)kr_w0) + (slot_1 * 8)) = condval;
    }
    #pragma unroll
    for (int i_1 = 0; i_1 < 2; ++i_1) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if (((((((((((int)threadIdx.x) >> 3) + _start_buffer_0[0]) >> 3) + i_1) < 1024) && (0 <= (((i_1 * 8) + (((int)threadIdx.x) >> 3)) + _start_buffer_0[0]))) && (0 <= (((i_1 * 8) + (((int)threadIdx.x) >> 3)) + _start_buffer_0[0]))) && (((((((int)threadIdx.x) >> 3) + _start_buffer_0[0]) >> 3) + i_1) < 1024))) {
        condval_1 = *(uint4*)(V + (((((int64_t)i_1) * (int64_t)512) + (((int64_t)_start_buffer_0[(int64_t)0]) * (int64_t)64)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
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
    ((uint*)qr_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[0], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[1], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[2], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[3], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[4], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[5], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[6], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)qr_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, qr_w1[7], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    #pragma unroll
    for (int i_2 = 0; i_2 < 16; ++i_2) {
      Q_reg[i_2] = qr_mma[i_2];
    }
    uint condval_14;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_14 = kr_w0[4];
    } else {
      condval_14 = kr_w0[0];
    }
    uint kr_cross_1_0 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_14, 4, 64);
    uint condval_15;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_15 = kr_w0[0];
    } else {
      condval_15 = kr_cross_1_0;
    }
    kr_w1[0] = condval_15;
    uint condval_16;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_16 = kr_cross_1_0;
    } else {
      condval_16 = kr_w0[4];
    }
    kr_w1[4] = condval_16;
    uint condval_17;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_17 = kr_w0[5];
    } else {
      condval_17 = kr_w0[1];
    }
    uint kr_cross_1_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_17, 4, 64);
    uint condval_18;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_18 = kr_w0[1];
    } else {
      condval_18 = kr_cross_1_1;
    }
    kr_w1[1] = condval_18;
    uint condval_19;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_19 = kr_cross_1_1;
    } else {
      condval_19 = kr_w0[5];
    }
    kr_w1[5] = condval_19;
    uint condval_20;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_20 = kr_w0[6];
    } else {
      condval_20 = kr_w0[2];
    }
    uint kr_cross_1_2 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_20, 4, 64);
    uint condval_21;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_21 = kr_w0[2];
    } else {
      condval_21 = kr_cross_1_2;
    }
    kr_w1[2] = condval_21;
    uint condval_22;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_22 = kr_cross_1_2;
    } else {
      condval_22 = kr_w0[6];
    }
    kr_w1[6] = condval_22;
    uint condval_23;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_23 = kr_w0[7];
    } else {
      condval_23 = kr_w0[3];
    }
    uint kr_cross_1_3 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_23, 4, 64);
    uint condval_24;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_24 = kr_w0[3];
    } else {
      condval_24 = kr_cross_1_3;
    }
    kr_w1[3] = condval_24;
    uint condval_25;
    if (((((int)threadIdx.x) & 4) == 0)) {
      condval_25 = kr_cross_1_3;
    } else {
      condval_25 = kr_w0[7];
    }
    kr_w1[7] = condval_25;
    ((uint*)kr_mma)[0] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[0], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[1] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[1], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[2] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[2], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[3] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[3], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[4] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[4], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[5] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[5], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[6] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[6], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    ((uint*)kr_mma)[7] = __shfl_sync((uint64_t)18446744073709551615, kr_w1[7], ((((((int)threadIdx.x) & 7) * 8) + (((((int)threadIdx.x) & 15) >> 3) * 4)) + (((int)threadIdx.x) >> 4)), 64);
    if (((int)blockIdx.x) < (_start_buffer_0[0] + 15)) {
      #pragma unroll
      for (int i_3 = 0; i_3 < 4; ++i_3) {
        float condval_26;
        if ((((((((int)threadIdx.x) >> 4) * 4) + _start_buffer_0[0]) + i_3) <= ((int)blockIdx.x))) {
          condval_26 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_26 = -MACART_INF_F;
        }
        acc_s[i_3] = condval_26;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
    #pragma unroll
    for (int ki = 0; ki < 2; ++ki) {
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
    for (int i_4 = 0; i_4 < 2; ++i_4) {
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
    float condval_27;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_27 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_27 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_27;
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
  for (int i_7 = 0; i_7 < 4; ++i_7) {
    float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_7 * 4)) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
  }
  if (((0 <= _selected_block) && (_selected_block < 512)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      for (int e = 0; e < 4; ++e) {
        vb[((j_1 * 4) + e)] = ((half_t*)buf_dyn_shmem)[(((((((int)threadIdx.x) >> 4) * 256) + (e * 64)) + (j_1 * 16)) + (((int)threadIdx.x) & 15))];
      }
    }
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      {
      *(((float32x4*)acc_o) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_2),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_2));
    };
    }
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 4; ++i_8) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_8 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(O_reg + (i_8 * 4)) = __2;
  }
  __syncwarp();
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_9 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_9 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_10 = 0; i_10 < 2; ++i_10) {
    *(uint4*)(Output + (((((int)blockIdx.x) * 1024) + (i_10 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_10 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

