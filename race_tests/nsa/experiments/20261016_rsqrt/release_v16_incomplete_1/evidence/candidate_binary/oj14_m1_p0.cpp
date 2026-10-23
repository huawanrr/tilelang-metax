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
  half_t Q_stage[16];
  float acc_o[16];
  int _start_buffer_0[1];
  half_t K_reg[16];
  half_t V_reg[16];
  half_t Q_reg[16];
  float acc_s[4];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t O_reg[16];
  half_t kb[8];
  half_t vb[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_stage + (i * 8)) = *(uint4*)(Q + ((((((((int)blockIdx.z) >> 1) * 1048576) + (((int)blockIdx.x) * 2048)) + ((((int)blockIdx.z) & 1) * 1024)) + (i * 512)) + (((int)threadIdx.x) * 8)));
  }
  int _selected_block = BlockIndices[((((((int)blockIdx.z) >> 1) * 1024) + (((int)blockIdx.x) * 2)) + (((int)blockIdx.z) & 1))];
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= _selected_block) && (_selected_block < 32)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
    _start_buffer_0[0] = (_selected_block * 16);
    #pragma unroll
    for (int k_slot = 0; k_slot < 2; ++k_slot) {
      #pragma unroll
      for (int k_pair = 0; k_pair < 4; ++k_pair) {
        *(uint1*)(K_reg + ((k_slot * 8) + (k_pair * 2))) = *(uint1*)(K_blocks + ((((((((((int)blockIdx.z) >> 1) * 65536) + (_selected_block * 2048)) + (k_slot * 1024)) + ((((int)threadIdx.x) >> 3) * 128)) + ((((int)blockIdx.z) & 1) * 64)) + ((((int)threadIdx.x) & 7) * 8)) + (k_pair * 2)));
      }
    }
    #pragma unroll
    for (int v_slot = 0; v_slot < 2; ++v_slot) {
      #pragma unroll
      for (int v_pair = 0; v_pair < 4; ++v_pair) {
        *(uint1*)(V_reg + ((v_slot * 8) + (v_pair * 2))) = *(uint1*)(V_blocks + ((((((((((int)blockIdx.z) >> 1) * 65536) + (_selected_block * 2048)) + (v_slot * 1024)) + ((((int)threadIdx.x) >> 3) * 128)) + ((((int)blockIdx.z) & 1) * 64)) + ((((int)threadIdx.x) & 7) * 8)) + (v_pair * 2)));
      }
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_2 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(Q_stage + (i_2 * 8));
    }
    __syncwarp();
    #pragma unroll
    for (int i_3 = 0; i_3 < 2; ++i_3) {
      *(uint4*)(Q_reg + (i_3 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 64) + ((((i_3 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
    }
    __syncwarp();
    #pragma unroll
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(K_reg + (i_4 * 8));
    }
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_s + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
    __syncwarp();
    for (int ki = 0; ki < 2; ++ki) {
      *(uint4*)(kb + 0) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 64) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + kp),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    __syncwarp();
    #pragma unroll
    for (int i_5 = 0; i_5 < 2; ++i_5) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((i_5 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_reg + (i_5 * 8));
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      float condval;
      if (((((((int)threadIdx.x) >> 4) + ((_start_buffer_0[0] + i_6) >> 2)) < 128) && (((((((int)threadIdx.x) >> 4) * 4) + _start_buffer_0[0]) + i_6) <= ((int)blockIdx.x)))) {
        condval = expf(min((acc_s[i_6] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
      } else {
        condval = 0x0p+0f/*0.000000e+00*/;
      }
      acc_s[i_6] = condval;
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j = 0; j < 4; ++j) {
      lane_sum[0] = (lane_sum[0] + acc_s[j]);
    }
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
    float condval_1;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_1 = (rsqrtf(lane_sum[0]) * rsqrtf(lane_sum[0]));
    } else {
      condval_1 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_1;
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      acc_s[i_7] = (acc_s[i_7] * lane_sum[0]);
    }
    #pragma unroll
    for (int cast_lane = 0; cast_lane < 4; ++cast_lane) {
      acc_s_cast[cast_lane] = ((half_t)acc_s[cast_lane]);
    }
    __syncwarp();
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 4; ++i_8) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_8 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  }
  if (((0 <= _selected_block) && (_selected_block < 32)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
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
  for (int cast_chunk = 0; cast_chunk < 4; ++cast_chunk) {
    #pragma unroll
    for (int cast_lane_1 = 0; cast_lane_1 < 4; ++cast_lane_1) {
      O_reg[((cast_chunk * 4) + cast_lane_1)] = ((half_t)acc_o[((cast_chunk * 4) + cast_lane_1)]);
    }
  }
  __syncwarp();
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_9 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_9 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_10 = 0; i_10 < 2; ++i_10) {
    *(uint4*)(Output + ((((((((int)blockIdx.z) >> 1) * 1048576) + (((int)blockIdx.x) * 2048)) + ((((int)blockIdx.z) & 1) * 1024)) + (i_10 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_10 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

