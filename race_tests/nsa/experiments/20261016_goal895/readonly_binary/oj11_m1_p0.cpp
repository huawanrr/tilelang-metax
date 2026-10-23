#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  float short_sum_one[1];
  half_t q[16];
  int blocks[4];
  half_t k[16];
  half_t v[16];
  float out[16];
  float partial_sum[4];
  float lane_sum[1];
  float short_sum_out[4];
  half_t result[16];
  float scores[4];
  half_t prob[4];
  half_t vb[16];
  half_t kb[8];
  short_sum_one[0] = 0x1p+0f/*1.000000e+00*/;
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.y) * 524288) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int s = 0; s < 4; ++s) {
    blocks[s] = __ldg(&(Indices[(((((int)blockIdx.y) * 2048) + (((int)blockIdx.x) * 4)) + s)]));
  }
  int first_block = blocks[0];
  if (((0 <= first_block) && (first_block < 32)) && (first_block <= (((int)blockIdx.x) >> 4))) {
    #pragma unroll
    for (int slot = 0; slot < 2; ++slot) {
      #pragma unroll
      for (int word = 0; word < 4; ++word) {
        *(uint1*)(k + ((slot * 8) + (word * 2))) = *(uint1*)(K_blocks + (((((((int)blockIdx.y) * 32768) + (first_block * 1024)) + (slot * 512)) + (((int)threadIdx.x) * 8)) + (word * 2)));
      }
    }
    #pragma unroll
    for (int slot_1 = 0; slot_1 < 2; ++slot_1) {
      #pragma unroll
      for (int word_1 = 0; word_1 < 4; ++word_1) {
        *(uint1*)(v + ((slot_1 * 8) + (word_1 * 2))) = *(uint1*)(V_blocks + (((((((int)blockIdx.y) * 32768) + (first_block * 1024)) + (slot_1 * 512)) + (((int)threadIdx.x) * 8)) + (word_1 * 2)));
      }
    }
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(partial_sum + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  #pragma unroll 2
  for (int s_1 = 0; s_1 < 4; ++s_1) {
    int block = blocks[s_1];
    if (((0 <= block) && (block < 32)) && (block <= (((int)blockIdx.x) >> 4))) {
      #pragma unroll
      for (int i_2 = 0; i_2 < 2; ++i_2) {
        *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_2 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(k + (i_2 * 8));
      }
      if (((int)blockIdx.x) < ((block * 16) + 15)) {
        #pragma unroll
        for (int i_3 = 0; i_3 < 4; ++i_3) {
          float condval;
          if (((((block * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_3) <= ((int)blockIdx.x))) {
            condval = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval = -MACART_INF_F;
          }
          scores[i_3] = condval;
        }
      } else {
        float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(scores + 0) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
      }
      __syncwarp();
      for (int ki = 0; ki < 2; ++ki) {
        *(uint4*)(kb + 0) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 64) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
        for (int kp = 0; kp < 2; ++kp) {
          {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + kp),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_4 = 0; i_4 < 2; ++i_4) {
        *(uint4*)(((half_t*)buf_dyn_shmem) + ((((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)) + 1024)) = *(uint4*)(v + (i_4 * 8));
      }
      #pragma unroll
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        scores[i_5] = expf(min((scores[i_5] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
        partial_sum[i_5] = (partial_sum[i_5] + scores[i_5]);
      }
      #pragma unroll
      for (int lane = 0; lane < 4; ++lane) {
        prob[lane] = ((half_t)scores[lane]);
      }
      __syncwarp();
    }
    if (s_1 < 3) {
      int next_block = blocks[(s_1 + 1)];
      if (((0 <= next_block) && (next_block < 32)) && (next_block <= (((int)blockIdx.x) >> 4))) {
        #pragma unroll
        for (int slot_2 = 0; slot_2 < 2; ++slot_2) {
          #pragma unroll
          for (int word_2 = 0; word_2 < 4; ++word_2) {
            *(uint1*)(k + ((slot_2 * 8) + (word_2 * 2))) = *(uint1*)(K_blocks + (((((((int)blockIdx.y) * 32768) + (next_block * 1024)) + (slot_2 * 512)) + (((int)threadIdx.x) * 8)) + (word_2 * 2)));
          }
        }
        #pragma unroll
        for (int slot_3 = 0; slot_3 < 2; ++slot_3) {
          #pragma unroll
          for (int word_3 = 0; word_3 < 4; ++word_3) {
            *(uint1*)(v + ((slot_3 * 8) + (word_3 * 2))) = *(uint1*)(V_blocks + (((((((int)blockIdx.y) * 32768) + (next_block * 1024)) + (slot_3 * 512)) + (((int)threadIdx.x) * 8)) + (word_3 * 2)));
          }
        }
      }
    }
    if (((0 <= block) && (block < 32)) && (block <= (((int)blockIdx.x) >> 4))) {
      for (int j = 0; j < 4; ++j) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          vb[((j * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[((((((((int)threadIdx.x) >> 4) * 256) + (local_id * 64)) + ((((j * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7)) + 1024)];
        }
      }
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_1),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j_1));
    };
      }
    }
  }
  lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int j_2 = 0; j_2 < 4; ++j_2) {
    lane_sum[0] = (lane_sum[0] + partial_sum[j_2]);
  }
  float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(short_sum_out + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  {
      *(((float32x4*)short_sum_out) + 0) = __builtin_mxc_mma_16x16x4f32(*(((float*)short_sum_one) + 0),
                    *(((float*)lane_sum) + 0),
                    *(((float32x4*)short_sum_out) + 0));
    };
  float condval_1;
  if ((0x0p+0f/*0.000000e+00*/ < short_sum_out[0])) {
    float v_ = short_sum_out[0];
    uint v__1 = (uint)2129859011 - (*(uint *)(&(v_)));
    condval_1 = (((*(float *)(&(v__1))) * (0x1p+1f/*2.000000e+00*/ - (short_sum_out[0] * (*(float *)(&(v__1)))))) * (0x1p+1f/*2.000000e+00*/ - (short_sum_out[0] * ((*(float *)(&(v__1))) * (0x1p+1f/*2.000000e+00*/ - (short_sum_out[0] * (*(float *)(&(v__1)))))))));
  } else {
    condval_1 = 0x0p+0f/*0.000000e+00*/;
  }
  lane_sum[0] = condval_1;
  #pragma unroll
  for (int i_6 = 0; i_6 < 16; ++i_6) {
    out[i_6] = (out[i_6] * lane_sum[0]);
  }
  #pragma unroll
  for (int chunk = 0; chunk < 4; ++chunk) {
    #pragma unroll
    for (int lane_1 = 0; lane_1 < 4; ++lane_1) {
      result[((chunk * 4) + lane_1)] = ((half_t)out[((chunk * 4) + lane_1)]);
    }
  }
  __syncwarp();
  #pragma unroll
  for (int i_7 = 0; i_7 < 4; ++i_7) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_7 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(result + (i_7 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_8 = 0; i_8 < 2; ++i_8) {
    *(uint4*)(Output + ((((((int)blockIdx.y) * 524288) + (((int)blockIdx.x) * 1024)) + (i_8 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_8 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

