#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  float short_sum_one[1];
  half_t Q_reg[16];
  int starts[2];
  float acc_o[16];
  half_t K_reg[32];
  half_t V_reg[32];
  extern __shared__ __align__(1024) half_t V_shared[];
  float acc_s[8];
  half_t kb[16];
  float lane_sum[1];
  float short_sum_out[4];
  half_t acc_s_cast[8];
  half_t vb[16];
  half_t O_cast[16];
  short_sum_one[0] = 0x1p+0f/*1.000000e+00*/;
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int si = 0; si < 2; ++si) {
    int _raw_block = BlockIndices[((((int)blockIdx.x) * 2) + si)];
    int condval;
    if (((0 <= _raw_block) && (_raw_block < 17))) {
      condval = _raw_block;
    } else {
      condval = -1;
    }
    starts[si] = (condval * 16);
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    int condval_1;
    if ((i_2 < 2)) {
      condval_1 = (((i_2 * 8) + (((int)threadIdx.x) >> 3)) + starts[0]);
    } else {
      condval_1 = ((((i_2 * 8) + (((int)threadIdx.x) >> 3)) + starts[1]) - 16);
    }
    int kpos = condval_1;
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_2;
    if (((0 <= kpos) && (kpos < 257))) {
      condval_2 = *(uint4*)(K + ((((int64_t)kpos) * (int64_t)64) + ((((int64_t)((int)threadIdx.x)) & (int64_t)7) * (int64_t)8)));
    } else {
      condval_2 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint4*)(K_reg + (i_2 * 8)) = condval_2;
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    int condval_3;
    if ((i_3 < 2)) {
      condval_3 = (((i_3 * 8) + (((int)threadIdx.x) >> 3)) + starts[0]);
    } else {
      condval_3 = ((((i_3 * 8) + (((int)threadIdx.x) >> 3)) + starts[1]) - 16);
    }
    int vpos = condval_3;
    half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_4;
    if (((0 <= vpos) && (vpos < 257))) {
      condval_4 = *(uint4*)(V + ((((int64_t)vpos) * (int64_t)64) + ((((int64_t)((int)threadIdx.x)) & (int64_t)7) * (int64_t)8)));
    } else {
      condval_4 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
    }
    *(uint4*)(V_reg + (i_3 * 8)) = condval_4;
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 4; ++i_4) {
    *(uint4*)(V_shared + (((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(K_reg + (i_4 * 8));
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_s + (i_5 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  }
  __syncthreads();
  for (int ki = 0; ki < 2; ++ki) {
    for (int j = 0; j < 2; ++j) {
      *(uint4*)(kb + (j * 8)) = *(uint4*)(V_shared + (((j * 1024) + ((((int)threadIdx.x) & 15) * 64)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
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
  __syncthreads();
  #pragma unroll
  for (int i_6 = 0; i_6 < 4; ++i_6) {
    *(uint4*)(V_shared + ((i_6 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_reg + (i_6 * 8));
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 8; ++i_7) {
    int condval_6;
    if ((i_7 < 4)) {
      condval_6 = ((((((int)threadIdx.x) >> 4) * 4) + starts[0]) + i_7);
    } else {
      condval_6 = ((((((i_7 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + starts[1]) + (i_7 & 3)) - 16);
    }
    int condval_7;
    if ((i_7 < 4)) {
      condval_7 = ((((((int)threadIdx.x) >> 4) * 4) + starts[0]) + i_7);
    } else {
      condval_7 = ((((((i_7 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + starts[1]) + (i_7 & 3)) - 16);
    }
    int condval_8;
    if ((i_7 < 4)) {
      condval_8 = ((((((int)threadIdx.x) >> 4) * 4) + starts[0]) + i_7);
    } else {
      condval_8 = ((((((i_7 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + starts[1]) + (i_7 & 3)) - 16);
    }
    float condval_5;
    if ((((0 <= condval_6) && (condval_7 < 257)) && (condval_8 <= ((int)blockIdx.x)))) {
      condval_5 = expf(min((acc_s[i_7] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    } else {
      condval_5 = 0x0p+0f/*0.000000e+00*/;
    }
    acc_s[i_7] = condval_5;
  }
  lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int k = 0; k < 2; ++k) {
    #pragma unroll
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      lane_sum[0] = (lane_sum[0] + acc_s[((k * 4) + j_2)]);
    }
  }
  float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(short_sum_out + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
  {
      *(((float32x4*)short_sum_out) + 0) = __builtin_mxc_mma_16x16x4f32(*(((float*)short_sum_one) + 0),
                    *(((float*)lane_sum) + 0),
                    *(((float32x4*)short_sum_out) + 0));
    };
  float condval_9;
  if ((0x0p+0f/*0.000000e+00*/ < short_sum_out[0])) {
    float v_ = short_sum_out[0];
    uint v__1 = (uint)2129859011 - (*(uint *)(&(v_)));
    condval_9 = (((*(float *)(&(v__1))) * (0x1p+1f/*2.000000e+00*/ - (short_sum_out[0] * (*(float *)(&(v__1)))))) * (0x1p+1f/*2.000000e+00*/ - (short_sum_out[0] * ((*(float *)(&(v__1))) * (0x1p+1f/*2.000000e+00*/ - (short_sum_out[0] * (*(float *)(&(v__1)))))))));
  } else {
    condval_9 = 0x0p+0f/*0.000000e+00*/;
  }
  lane_sum[0] = condval_9;
  #pragma unroll
  for (int i_8 = 0; i_8 < 8; ++i_8) {
    acc_s[i_8] = (acc_s[i_8] * lane_sum[0]);
  }
  #pragma unroll
  for (int cast_chunk = 0; cast_chunk < 2; ++cast_chunk) {
    #pragma unroll
    for (int cast_lane = 0; cast_lane < 4; ++cast_lane) {
      acc_s_cast[((cast_chunk * 4) + cast_lane)] = ((half_t)acc_s[((cast_chunk * 4) + cast_lane)]);
    }
  }
  __syncthreads();
  for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      for (int e = 0; e < 4; ++e) {
        vb[((j_3 * 4) + e)] = V_shared[(((((ki_1 * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + (e * 64)) + (j_3 * 16)) + (((int)threadIdx.x) & 15))];
      }
    }
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      {
      *(((float32x4*)acc_o) + j_4) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_4),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_o) + j_4));
    };
    }
  }
  #pragma unroll
  for (int output_chunk = 0; output_chunk < 4; ++output_chunk) {
    #pragma unroll
    for (int output_lane = 0; output_lane < 4; ++output_lane) {
      O_cast[((output_chunk * 4) + output_lane)] = ((half_t)acc_o[((output_chunk * 4) + output_lane)]);
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(O_cast + (i_9 * 4));
  }
}

