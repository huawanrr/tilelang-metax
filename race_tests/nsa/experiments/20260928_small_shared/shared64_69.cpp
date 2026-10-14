#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  half_t q[32];
  half_t k[64];
  half_t v[64];
  float scores[8];
  extern __shared__ __align__(1024) half_t kv[];
  half_t kb[16];
  float lane_sum[1];
  half_t prob[8];
  float out[16];
  half_t vb[16];
  half_t Output_local_cast[4];
  half_t Output_local_cast_1[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int block = Indices[((((int)blockIdx.y) * 1024) + ((int)blockIdx.x))];
  bool valid = (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x)));
  if (valid) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 8; ++i_1) {
      *(uint4*)(k + (i_1 * 8)) = *(uint4*)(K + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + ((((int64_t)i_1) & (int64_t)3) * (int64_t)1024)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)3) * (int64_t)128)) + ((((int64_t)i_1) >> (int64_t)2) * (int64_t)64)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)7) * (int64_t)8)));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      *(uint4*)(v + (i_2 * 8)) = *(uint4*)(V + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + ((((int64_t)i_2) & (int64_t)3) * (int64_t)1024)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)3) * (int64_t)128)) + ((((int64_t)i_2) >> (int64_t)2) * (int64_t)64)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)7) * (int64_t)8)));
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 8; ++i_3) {
      float condval;
      if (((block < 32) && (((((block * 32) + ((i_3 >> 2) * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + (i_3 & 3)) <= ((int)blockIdx.x)))) {
        condval = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval = -MACART_INF_F;
      }
      scores[i_3] = condval;
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      if (i_4 < 4) {
        *(uint4*)(kv + (((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(k + (i_4 * 8));
      }
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki = 0; ki < 2; ++ki) {
      for (int j = 0; j < 2; ++j) {
        *(uint4*)(kb + (j * 8)) = *(uint4*)(kv + (((j * 1024) + ((((int)threadIdx.x) & 15) * 64)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
      }
      for (int kp = 0; kp < 2; ++kp) {
        for (int j_1 = 0; j_1 < 2; ++j_1) {
          {
      *(((float32x4*)scores) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_1 * 2) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + j_1));
    };
        }
      }
    }
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      *(uint4*)(kv + (((i_5 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(k + ((i_5 * 8) + 32));
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_2 = 0; j_2 < 2; ++j_2) {
        *(uint4*)(kb + (j_2 * 8)) = *(uint4*)(kv + (((j_2 * 1024) + ((((int)threadIdx.x) & 15) * 64)) + ((((ki_1 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
      }
      for (int kp_1 = 0; kp_1 < 2; ++kp_1) {
        for (int j_3 = 0; j_3 < 2; ++j_3) {
          {
      *(((float32x4*)scores) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_3 * 2) + kp_1)),
                    *(((float16x4*)q) + (((ki_1 * 2) + kp_1) + 4)),
                    *(((float32x4*)scores) + j_3));
    };
        }
      }
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      scores[i_6] = exp2f(min((scores[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int block_k = 0; block_k < 2; ++block_k) {
      #pragma unroll
      for (int j_4 = 0; j_4 < 4; ++j_4) {
        lane_sum[0] = (lane_sum[0] + scores[((block_k * 4) + j_4)]);
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
    for (int i_7 = 0; i_7 < 8; ++i_7) {
      scores[i_7] = (scores[i_7] * lane_sum[0]);
    }
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      uint2 __1;
      float4 v_ = *(float4*)(scores + (i_8 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob + (i_8 * 4)) = __1;
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_9 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_10 = 0; i_10 < 8; ++i_10) {
      if (i_10 < 4) {
        *(uint4*)(kv + (((i_10 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(v + (i_10 * 8));
      }
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
      for (int j_5 = 0; j_5 < 4; ++j_5) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          vb[((j_5 * 4) + local_id)] = kv[(((((ki_2 * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + (local_id * 64)) + ((((j_5 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int j_6 = 0; j_6 < 4; ++j_6) {
        {
      *(((float32x4*)out) + j_6) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_6),
                    *(((float16x4*)prob) + ki_2),
                    *(((float32x4*)out) + j_6));
    };
      }
    }
  }
  #pragma unroll
  for (int i_11 = 0; i_11 < 4; ++i_11) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_11 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_11 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
  #pragma unroll
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_12 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_13 = 0; i_13 < 4; ++i_13) {
      *(uint4*)(kv + (((i_13 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(v + ((i_13 * 8) + 32));
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki_3 = 0; ki_3 < 2; ++ki_3) {
      for (int j_7 = 0; j_7 < 4; ++j_7) {
        for (int local_id_1 = 0; local_id_1 < 4; ++local_id_1) {
          vb[((j_7 * 4) + local_id_1)] = kv[(((((ki_3 * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + (local_id_1 * 64)) + ((((j_7 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 4) + local_id_1)) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int j_8 = 0; j_8 < 4; ++j_8) {
        {
      *(((float32x4*)out) + j_8) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_8),
                    *(((float16x4*)prob) + ki_3),
                    *(((float32x4*)out) + j_8));
    };
      }
    }
  }
  #pragma unroll
  for (int i_14 = 0; i_14 < 4; ++i_14) {
    uint2 __3;
    float4 v__2 = *(float4*)(out + (i_14 * 4));
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(Output_local_cast_1 + 0) = __3;
    *(uint2*)(Output + ((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_14 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 64)) = *(uint2*)(Output_local_cast_1 + 0);
  }
}

