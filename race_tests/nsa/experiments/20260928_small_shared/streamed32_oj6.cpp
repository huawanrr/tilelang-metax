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
  half_t k[16];
  half_t v[16];
  float scores[8];
  extern __shared__ __align__(1024) half_t kv[];
  half_t kb[16];
  float lane_sum[1];
  half_t prob[8];
  float out[8];
  half_t vb[8];
  half_t Output_local_cast[4];
  half_t Output_local_cast_1[4];
  half_t Output_local_cast_2[4];
  half_t Output_local_cast_3[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int block = Indices[((((int)blockIdx.y) * 1024) + ((int)blockIdx.x))];
  bool valid = (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x)));
  if (valid) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 2; ++i_1) {
      *(uint4*)(k + (i_1 * 8)) = *(uint4*)(K + (((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_1) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(v + (i_2 * 8)) = *(uint4*)(V + (((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_2) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)));
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
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(kv + (((i_4 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(k + (i_4 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int j = 0; j < 2; ++j) {
      *(uint4*)(kb + (j * 8)) = *(uint4*)(kv + (((j * 512) + ((((int)threadIdx.x) & 15) * 32)) + (((((int)threadIdx.x) >> 4) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)));
    }
    for (int kp = 0; kp < 2; ++kp) {
      for (int j_1 = 0; j_1 < 2; ++j_1) {
        {
      *(((float32x4*)scores) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_1 * 2) + kp)),
                    *(((float16x4*)q) + kp),
                    *(((float32x4*)scores) + j_1));
    };
      }
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 2; ++i_5) {
      *(uint4*)(k + (i_5 * 8)) = *(uint4*)(K + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_5) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)) + (int64_t)32));
    }
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_6 = 0; i_6 < 2; ++i_6) {
      *(uint4*)(kv + (((i_6 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(k + (i_6 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int j_2 = 0; j_2 < 2; ++j_2) {
      *(uint4*)(kb + (j_2 * 8)) = *(uint4*)(kv + (((j_2 * 512) + ((((int)threadIdx.x) & 15) * 32)) + (((((int)threadIdx.x) >> 4) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)));
    }
    for (int kp_1 = 0; kp_1 < 2; ++kp_1) {
      for (int j_3 = 0; j_3 < 2; ++j_3) {
        {
      *(((float32x4*)scores) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_3 * 2) + kp_1)),
                    *(((float16x4*)q) + (kp_1 + 2)),
                    *(((float32x4*)scores) + j_3));
    };
      }
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 2; ++i_7) {
      *(uint4*)(k + (i_7 * 8)) = *(uint4*)(K + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_7) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)) + (int64_t)64));
    }
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      *(uint4*)(kv + (((i_8 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(k + (i_8 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int j_4 = 0; j_4 < 2; ++j_4) {
      *(uint4*)(kb + (j_4 * 8)) = *(uint4*)(kv + (((j_4 * 512) + ((((int)threadIdx.x) & 15) * 32)) + (((((int)threadIdx.x) >> 4) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)));
    }
    for (int kp_2 = 0; kp_2 < 2; ++kp_2) {
      for (int j_5 = 0; j_5 < 2; ++j_5) {
        {
      *(((float32x4*)scores) + j_5) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_5 * 2) + kp_2)),
                    *(((float16x4*)q) + (kp_2 + 4)),
                    *(((float32x4*)scores) + j_5));
    };
      }
    }
    #pragma unroll
    for (int i_9 = 0; i_9 < 2; ++i_9) {
      *(uint4*)(k + (i_9 * 8)) = *(uint4*)(K + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_9) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)) + (int64_t)96));
    }
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_10 = 0; i_10 < 2; ++i_10) {
      *(uint4*)(kv + (((i_10 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(k + (i_10 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int j_6 = 0; j_6 < 2; ++j_6) {
      *(uint4*)(kb + (j_6 * 8)) = *(uint4*)(kv + (((j_6 * 512) + ((((int)threadIdx.x) & 15) * 32)) + (((((int)threadIdx.x) >> 4) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)));
    }
    for (int kp_3 = 0; kp_3 < 2; ++kp_3) {
      for (int j_7 = 0; j_7 < 2; ++j_7) {
        {
      *(((float32x4*)scores) + j_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_7 * 2) + kp_3)),
                    *(((float16x4*)q) + (kp_3 + 6)),
                    *(((float32x4*)scores) + j_7));
    };
      }
    }
    #pragma unroll
    for (int i_11 = 0; i_11 < 8; ++i_11) {
      scores[i_11] = exp2f(min((scores[i_11] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int block_k = 0; block_k < 2; ++block_k) {
      #pragma unroll
      for (int j_8 = 0; j_8 < 4; ++j_8) {
        lane_sum[0] = (lane_sum[0] + scores[((block_k * 4) + j_8)]);
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
    for (int i_12 = 0; i_12 < 8; ++i_12) {
      scores[i_12] = (scores[i_12] * lane_sum[0]);
    }
    #pragma unroll
    for (int i_13 = 0; i_13 < 2; ++i_13) {
      uint2 __1;
      float4 v_ = *(float4*)(scores + (i_13 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob + (i_13 * 4)) = __1;
    }
  }
  #pragma unroll
  for (int i_14 = 0; i_14 < 2; ++i_14) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_14 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_15 = 0; i_15 < 2; ++i_15) {
      *(uint4*)(kv + (((i_15 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(v + (i_15 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki = 0; ki < 2; ++ki) {
      for (int j_9 = 0; j_9 < 2; ++j_9) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          vb[((j_9 * 4) + local_id)] = kv[(((((ki * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (local_id * 32)) + ((((j_9 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 2) + (local_id >> 1))) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int j_10 = 0; j_10 < 2; ++j_10) {
        {
      *(((float32x4*)out) + j_10) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_10),
                    *(((float16x4*)prob) + ki),
                    *(((float32x4*)out) + j_10));
    };
      }
    }
  }
  #pragma unroll
  for (int i_16 = 0; i_16 < 2; ++i_16) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_16 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_16 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
  #pragma unroll
  for (int i_17 = 0; i_17 < 2; ++i_17) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_17 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  if (valid) {
    #pragma unroll
    for (int i_18 = 0; i_18 < 2; ++i_18) {
      *(uint4*)(v + (i_18 * 8)) = *(uint4*)(V + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_18) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)) + (int64_t)32));
    }
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_19 = 0; i_19 < 2; ++i_19) {
      *(uint4*)(kv + (((i_19 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(v + (i_19 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_11 = 0; j_11 < 2; ++j_11) {
        for (int local_id_1 = 0; local_id_1 < 4; ++local_id_1) {
          vb[((j_11 * 4) + local_id_1)] = kv[(((((ki_1 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (local_id_1 * 32)) + ((((j_11 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 2) + (local_id_1 >> 1))) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int j_12 = 0; j_12 < 2; ++j_12) {
        {
      *(((float32x4*)out) + j_12) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_12),
                    *(((float16x4*)prob) + ki_1),
                    *(((float32x4*)out) + j_12));
    };
      }
    }
  }
  #pragma unroll
  for (int i_20 = 0; i_20 < 2; ++i_20) {
    uint2 __3;
    float4 v__2 = *(float4*)(out + (i_20 * 4));
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(Output_local_cast_1 + 0) = __3;
    *(uint2*)(Output + ((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_20 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 32)) = *(uint2*)(Output_local_cast_1 + 0);
  }
  #pragma unroll
  for (int i_21 = 0; i_21 < 2; ++i_21) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_21 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  }
  if (valid) {
    #pragma unroll
    for (int i_22 = 0; i_22 < 2; ++i_22) {
      *(uint4*)(v + (i_22 * 8)) = *(uint4*)(V + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_22) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)) + (int64_t)64));
    }
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_23 = 0; i_23 < 2; ++i_23) {
      *(uint4*)(kv + (((i_23 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(v + (i_23 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
      for (int j_13 = 0; j_13 < 2; ++j_13) {
        for (int local_id_2 = 0; local_id_2 < 4; ++local_id_2) {
          vb[((j_13 * 4) + local_id_2)] = kv[(((((ki_2 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (local_id_2 * 32)) + ((((j_13 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 2) + (local_id_2 >> 1))) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int j_14 = 0; j_14 < 2; ++j_14) {
        {
      *(((float32x4*)out) + j_14) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_14),
                    *(((float16x4*)prob) + ki_2),
                    *(((float32x4*)out) + j_14));
    };
      }
    }
  }
  #pragma unroll
  for (int i_24 = 0; i_24 < 2; ++i_24) {
    uint2 __4;
    float4 v__3 = *(float4*)(out + (i_24 * 4));
    ((half2*)(&__4))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
    ((half2*)(&__4))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
    *(uint2*)(Output_local_cast_2 + 0) = __4;
    *(uint2*)(Output + ((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_24 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 64)) = *(uint2*)(Output_local_cast_2 + 0);
  }
  #pragma unroll
  for (int i_25 = 0; i_25 < 2; ++i_25) {
    float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_25 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  }
  if (valid) {
    #pragma unroll
    for (int i_26 = 0; i_26 < 2; ++i_26) {
      *(uint4*)(v + (i_26 * 8)) = *(uint4*)(V + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)131072) + (((int64_t)block) * (int64_t)4096)) + (((int64_t)i_26) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)2) * (int64_t)128)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)3) * (int64_t)8)) + (int64_t)96));
    }
  }
  __syncthreads();
  if (valid) {
    #pragma unroll
    for (int i_27 = 0; i_27 < 2; ++i_27) {
      *(uint4*)(kv + (((i_27 * 512) + ((((int)threadIdx.x) >> 2) * 32)) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(v + (i_27 * 8));
    }
  }
  __syncthreads();
  if (valid) {
    for (int ki_3 = 0; ki_3 < 2; ++ki_3) {
      for (int j_15 = 0; j_15 < 2; ++j_15) {
        for (int local_id_3 = 0; local_id_3 < 4; ++local_id_3) {
          vb[((j_15 * 4) + local_id_3)] = kv[(((((ki_3 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (local_id_3 * 32)) + ((((j_15 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 2) + (local_id_3 >> 1))) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int j_16 = 0; j_16 < 2; ++j_16) {
        {
      *(((float32x4*)out) + j_16) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_16),
                    *(((float16x4*)prob) + ki_3),
                    *(((float32x4*)out) + j_16));
    };
      }
    }
  }
  #pragma unroll
  for (int i_28 = 0; i_28 < 2; ++i_28) {
    uint2 __5;
    float4 v__4 = *(float4*)(out + (i_28 * 4));
    ((half2*)(&__5))[0] = __float22half2_rn(((float2*)(&v__4))[0]);
    ((half2*)(&__5))[1] = __float22half2_rn(((float2*)(&v__4))[1]);
    *(uint2*)(Output_local_cast_3 + 0) = __5;
    *(uint2*)(Output + ((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_28 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 96)) = *(uint2*)(Output_local_cast_3 + 0);
  }
}

