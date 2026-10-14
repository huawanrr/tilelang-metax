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
  float K_reg[16];
  float V_reg[16];
  half_t Q_reg[16];
  float acc_s[4];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t O_reg[16];
  half_t K_blocks_local_cast[8];
  half_t V_blocks_local_cast_1[8];
  half_t V_shared_local_cast_2[8];
  half_t kb[8];
  half_t V_shared_local_cast_3[8];
  half_t vb[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_stage + (i * 8)) = *(uint4*)(Q + (((((int)blockIdx.x) * 1024) + (i * 512)) + (((int)threadIdx.x) * 8)));
  }
  int _selected_block = BlockIndices[((int)blockIdx.x)];
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= _selected_block) && (_selected_block < 512)) && (_selected_block <= (((int)blockIdx.x) >> 4))) {
    _start_buffer_0[0] = (_selected_block * 16);
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(K_blocks_local_cast + 0) = *(uint4*)(K_blocks + (((_selected_block * 1024) + (i_2 * 512)) + (((int)threadIdx.x) * 8)));
      for (int vec = 0; vec < 2; ++vec) {
        float4 __1;
        uint2 v_ = *(uint2*)(K_blocks_local_cast + (vec * 4));
        ((float2*)(&__1))[0] = __half22float2(((half2*)(&v_))[0]);
        ((float2*)(&__1))[1] = __half22float2(((half2*)(&v_))[1]);
        *(float4*)(K_reg + ((i_2 * 8) + (vec * 4))) = __1;
      }
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 2; ++i_3) {
      *(uint4*)(V_blocks_local_cast_1 + 0) = *(uint4*)(V_blocks + (((_selected_block * 1024) + (i_3 * 512)) + (((int)threadIdx.x) * 8)));
      for (int vec_1 = 0; vec_1 < 2; ++vec_1) {
        float4 __2;
        uint2 v__1 = *(uint2*)(V_blocks_local_cast_1 + (vec_1 * 4));
        ((float2*)(&__2))[0] = __half22float2(((half2*)(&v__1))[0]);
        ((float2*)(&__2))[1] = __half22float2(((half2*)(&v__1))[1]);
        *(float4*)(V_reg + ((i_3 * 8) + (vec_1 * 4))) = __2;
      }
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(Q_stage + (i_4 * 8));
    }
    __syncwarp();
    #pragma unroll
    for (int i_5 = 0; i_5 < 2; ++i_5) {
      *(uint4*)(Q_reg + (i_5 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 64) + ((((i_5 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
    }
    __syncwarp();
    #pragma unroll
    for (int i_6 = 0; i_6 < 2; ++i_6) {
      for (int vec_2 = 0; vec_2 < 2; ++vec_2) {
        uint2 __3;
        float4 v__2 = *(float4*)(K_reg + ((i_6 * 8) + (vec_2 * 4)));
        ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
        ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
        *(uint2*)(V_shared_local_cast_2 + (vec_2 * 4)) = __3;
      }
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_6 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(V_shared_local_cast_2 + 0);
    }
    if (((int)blockIdx.x) < (_start_buffer_0[0] + 15)) {
      #pragma unroll
      for (int i_7 = 0; i_7 < 4; ++i_7) {
        float condval;
        if ((((((((int)threadIdx.x) >> 4) * 4) + _start_buffer_0[0]) + i_7) <= ((int)blockIdx.x))) {
          condval = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval = -MACART_INF_F;
        }
        acc_s[i_7] = condval;
      }
    } else {
      float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
    }
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
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      for (int vec_3 = 0; vec_3 < 2; ++vec_3) {
        uint2 __4;
        float4 v__3 = *(float4*)(V_reg + ((i_8 * 8) + (vec_3 * 4)));
        ((half2*)(&__4))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
        ((half2*)(&__4))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
        *(uint2*)(V_shared_local_cast_3 + (vec_3 * 4)) = __4;
      }
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((i_8 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_shared_local_cast_3 + 0);
    }
    #pragma unroll
    for (int i_9 = 0; i_9 < 4; ++i_9) {
      acc_s[i_9] = exp2f(min((acc_s[i_9] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
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
      condval_1 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_1 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_1;
    #pragma unroll
    for (int i_10 = 0; i_10 < 4; ++i_10) {
      acc_s[i_10] = (acc_s[i_10] * lane_sum[0]);
    }
    uint2 __5;
    float4 v__4 = *(float4*)(acc_s + 0);
    ((half2*)(&__5))[0] = __float22half2_rn(((float2*)(&v__4))[0]);
    ((half2*)(&__5))[1] = __float22half2_rn(((float2*)(&v__4))[1]);
    *(uint2*)(acc_s_cast + 0) = __5;
    __syncwarp();
  }
  #pragma unroll
  for (int i_11 = 0; i_11 < 4; ++i_11) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_11 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
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
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    uint2 __6;
    float4 v__5 = *(float4*)(acc_o + (i_12 * 4));
    ((half2*)(&__6))[0] = __float22half2_rn(((float2*)(&v__5))[0]);
    ((half2*)(&__6))[1] = __float22half2_rn(((float2*)(&v__5))[1]);
    *(uint2*)(O_reg + (i_12 * 4)) = __6;
  }
  __syncwarp();
  #pragma unroll
  for (int i_13 = 0; i_13 < 4; ++i_13) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_13 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_13 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_14 = 0; i_14 < 2; ++i_14) {
    *(uint4*)(Output + (((((int)blockIdx.x) * 1024) + (i_14 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_14 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

