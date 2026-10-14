#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  half_t Q_stage[32];
  float acc_o[16];
  int _start_buffer_0[1];
  half_t K_reg[64];
  half_t V_reg[64];
  half_t Q_reg[32];
  float acc_s[8];
  float lane_sum[1];
  half_t acc_s_cast[8];
  half_t O_reg[32];
  half_t kb[16];
  half_t vb[16];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(Q_stage + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + (i * 512)) + (((int)threadIdx.x) * 8)));
  }
  int _selected_block = BlockIndices[((((int)blockIdx.z) * 1024) + ((int)blockIdx.x))];
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= _selected_block) && (_selected_block < 32)) && (_selected_block <= (((int)blockIdx.x) >> 5))) {
    _start_buffer_0[0] = (_selected_block * 32);
    #pragma unroll
    for (int k_slot = 0; k_slot < 8; ++k_slot) {
      #pragma unroll
      for (int k_pair = 0; k_pair < 4; ++k_pair) {
        *(uint1*)(K_reg + ((k_slot * 8) + (k_pair * 2))) = *(uint1*)(K_blocks + (((((((int)blockIdx.z) * 131072) + (_selected_block * 4096)) + (k_slot * 512)) + (((int)threadIdx.x) * 8)) + (k_pair * 2)));
      }
    }
    #pragma unroll
    for (int v_slot = 0; v_slot < 8; ++v_slot) {
      #pragma unroll
      for (int v_pair = 0; v_pair < 4; ++v_pair) {
        *(uint1*)(V_reg + ((v_slot * 8) + (v_pair * 2))) = *(uint1*)(V_blocks + (((((((int)blockIdx.z) * 131072) + (_selected_block * 4096)) + (v_slot * 512)) + (((int)threadIdx.x) * 8)) + (v_pair * 2)));
      }
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_2 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_2 * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(Q_stage + (i_2 * 8));
    }
    __syncwarp();
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      *(uint4*)(Q_reg + (i_3 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 128) + ((((i_3 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
    }
    __syncwarp();
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_4 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_4 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(K_reg + (i_4 * 8));
    }
    if (((int)blockIdx.x) < (_start_buffer_0[0] + 31)) {
      #pragma unroll
      for (int i_5 = 0; i_5 < 8; ++i_5) {
        float condval;
        if (((((((i_5 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + _start_buffer_0[0]) + (i_5 & 3)) <= ((int)blockIdx.x))) {
          condval = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval = -MACART_INF_F;
        }
        acc_s[i_5] = condval;
      }
    } else {
      #pragma unroll
      for (int i_6 = 0; i_6 < 2; ++i_6) {
        float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + (i_6 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
      }
    }
    __syncwarp();
    for (int ki = 0; ki < 4; ++ki) {
      for (int j = 0; j < 2; ++j) {
        *(uint4*)(kb + (j * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((j * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
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
    __syncwarp();
    #pragma unroll
    for (int i_7 = 0; i_7 < 8; ++i_7) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((i_7 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_reg + (i_7 * 8));
    }
    #pragma unroll
    for (int i_8 = 0; i_8 < 8; ++i_8) {
      acc_s[i_8] = exp2f(min((acc_s[i_8] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
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
    float condval_1;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_1 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_1 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_1;
    #pragma unroll
    for (int i_9 = 0; i_9 < 8; ++i_9) {
      acc_s[i_9] = (acc_s[i_9] * lane_sum[0]);
    }
    #pragma unroll
    for (int i_10 = 0; i_10 < 2; ++i_10) {
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + (i_10 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + (i_10 * 4)) = __1;
    }
    __syncwarp();
  }
  #pragma unroll
  for (int vo = 0; vo < 2; ++vo) {
    #pragma unroll
    for (int i_11 = 0; i_11 < 4; ++i_11) {
      float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_o + (i_11 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
    }
    if (((0 <= _selected_block) && (_selected_block < 32)) && (_selected_block <= (((int)blockIdx.x) >> 5))) {
      for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
        for (int j_3 = 0; j_3 < 4; ++j_3) {
          for (int e = 0; e < 4; ++e) {
            vb[((j_3 * 4) + e)] = ((half_t*)buf_dyn_shmem)[((((((ki_1 * 2048) + ((((int)threadIdx.x) >> 4) * 512)) + (e * 128)) + (vo * 64)) + (j_3 * 16)) + (((int)threadIdx.x) & 15))];
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
    }
    #pragma unroll
    for (int i_12 = 0; i_12 < 4; ++i_12) {
      uint2 __2;
      float4 v__1 = *(float4*)(acc_o + (i_12 * 4));
      ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
      ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
      *(uint2*)(O_reg + ((vo * 16) + (i_12 * 4))) = __2;
    }
  }
  __syncwarp();
  #pragma unroll
  for (int i_13 = 0; i_13 < 8; ++i_13) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_13 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_13 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_14 = 0; i_14 < 4; ++i_14) {
    *(uint4*)(Output + ((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + (i_14 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_14 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_14 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
  }
}

