#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  half_t q_0[8];
  float out[8];
  uint words_0[4];
  half_t v_0[8];
  uint mma_k_0[4];
  float scores[4];
  extern __shared__ __align__(1024) half_t shared[];
  float sums[1];
  half_t prob[4];
  half_t vb[8];
  half_t q_1[8];
  uint words_1[4];
  half_t v_1[8];
  uint mma_k_1[4];
  half_t Output_local_cast[4];
  half_t Output_local_cast_1[4];
  *(uint4*)(q_0 + 0) = *(uint4*)(Q + (((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  int index_0 = Indices[(((int)blockIdx.x) * 2)];
  bool valid_0 = (((0 <= index_0) && (index_0 < 4)) && (index_0 <= (((int)blockIdx.x) >> 3)));
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (valid_0) {
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval;
    if ((index_0 < 4)) {
      condval = *(uint4*)(K + ((((int64_t)index_0) * (int64_t)512) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint4*)(((half_t*)words_0) + 0) = condval;
    *(uint4*)(v_0 + 0) = *(uint4*)(V + ((((int64_t)index_0) * (int64_t)512) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    #pragma unroll
    for (int word = 0; word < 4; ++word) {
      mma_k_0[word] = __shfl_sync((uint64_t)18446744073709551615, words_0[word], (((((int)threadIdx.x) & 15) * 4) + (((int)threadIdx.x) >> 4)), 64);
    }
    if (((((int)blockIdx.x) >> 3) - index_0) < 1) {
      #pragma unroll
      for (int i_1 = 0; i_1 < 4; ++i_1) {
        float condval_1;
        if (((((index_0 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_1) <= (((int)blockIdx.x) * 2))) {
          condval_1 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_1 = -MACART_INF_F;
        }
        scores[i_1] = condval_1;
      }
    } else {
      float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(scores + 0) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
    }
    for (int kp = 0; kp < 2; ++kp) {
      {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)mma_k_0) + kp),
                    *(((float16x4*)q_0) + kp),
                    *(((float32x4*)scores) + 0));
    };
    }
    *(uint4*)(shared + (((int)threadIdx.x) * 8)) = *(uint4*)(v_0 + 0);
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      scores[i_2] = exp2f(min((scores[i_2] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    sums[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j = 0; j < 4; ++j) {
      sums[0] = (sums[0] + scores[j]);
    }
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 32, 64));
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 16, 64));
    float condval_2;
    if ((0x0p+0f/*0.000000e+00*/ < sums[0])) {
      condval_2 = (0x1p+0f/*1.000000e+00*/ / sums[0]);
    } else {
      condval_2 = 0x0p+0f/*0.000000e+00*/;
    }
    sums[0] = condval_2;
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      scores[i_3] = (scores[i_3] * sums[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(scores + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(prob + 0) = __1;
    __syncwarp();
    for (int col = 0; col < 2; ++col) {
      for (int e = 0; e < 4; ++e) {
        vb[((col * 4) + e)] = shared[(((((((int)threadIdx.x) >> 4) * 128) + (e * 32)) + (col * 16)) + (((int)threadIdx.x) & 15))];
      }
    }
    for (int j_1 = 0; j_1 < 2; ++j_1) {
      {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_1),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j_1));
    };
    }
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 2; ++i_4) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_4 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 32)) + (i_4 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
  *(uint4*)(q_1 + 0) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)) + 512));
  int index_1 = Indices[((((int)blockIdx.x) * 2) + 1)];
  bool valid_1 = (((0 <= index_1) && (index_1 < 4)) && (index_1 <= (((int)blockIdx.x) >> 3)));
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_5 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  }
  if (valid_1) {
    half_t broadcast_var_4 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_3;
    if ((index_1 < 4)) {
      condval_3 = *(uint4*)(K + ((((int64_t)index_1) * (int64_t)512) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval_3 = make_uint4(__pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4));
    }
    *(uint4*)(((half_t*)words_1) + 0) = condval_3;
    *(uint4*)(v_1 + 0) = *(uint4*)(V + ((((int64_t)index_1) * (int64_t)512) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    #pragma unroll
    for (int word_1 = 0; word_1 < 4; ++word_1) {
      mma_k_1[word_1] = __shfl_sync((uint64_t)18446744073709551615, words_1[word_1], (((((int)threadIdx.x) & 15) * 4) + (((int)threadIdx.x) >> 4)), 64);
    }
    if ((((int)blockIdx.x) - (index_1 * 8)) < 7) {
      #pragma unroll
      for (int i_6 = 0; i_6 < 4; ++i_6) {
        float condval_4;
        if (((((index_1 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_6) <= ((((int)blockIdx.x) * 2) + 1))) {
          condval_4 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_4 = -MACART_INF_F;
        }
        scores[i_6] = condval_4;
      }
    } else {
      float broadcast_var_5 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(scores + 0) = make_float4(broadcast_var_5, broadcast_var_5, broadcast_var_5, broadcast_var_5);
    }
    for (int kp_1 = 0; kp_1 < 2; ++kp_1) {
      {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)mma_k_1) + kp_1),
                    *(((float16x4*)q_1) + kp_1),
                    *(((float32x4*)scores) + 0));
    };
    }
    *(uint4*)(shared + ((((int)threadIdx.x) * 8) + 512)) = *(uint4*)(v_1 + 0);
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      scores[i_7] = exp2f(min((scores[i_7] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    sums[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      sums[0] = (sums[0] + scores[j_2]);
    }
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 32, 64));
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 16, 64));
    float condval_5;
    if ((0x0p+0f/*0.000000e+00*/ < sums[0])) {
      condval_5 = (0x1p+0f/*1.000000e+00*/ / sums[0]);
    } else {
      condval_5 = 0x0p+0f/*0.000000e+00*/;
    }
    sums[0] = condval_5;
    #pragma unroll
    for (int i_8 = 0; i_8 < 4; ++i_8) {
      scores[i_8] = (scores[i_8] * sums[0]);
    }
    uint2 __3;
    float4 v__2 = *(float4*)(scores + 0);
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(prob + 0) = __3;
    __syncwarp();
    for (int col_1 = 0; col_1 < 2; ++col_1) {
      for (int e_1 = 0; e_1 < 4; ++e_1) {
        vb[((col_1 * 4) + e_1)] = shared[((((((((int)threadIdx.x) >> 4) * 128) + (e_1 * 32)) + (col_1 * 16)) + (((int)threadIdx.x) & 15)) + 512)];
      }
    }
    for (int j_3 = 0; j_3 < 2; ++j_3) {
      {
      *(((float32x4*)out) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_3),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j_3));
    };
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 2; ++i_9) {
    uint2 __4;
    float4 v__3 = *(float4*)(out + (i_9 * 4));
    ((half2*)(&__4))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
    ((half2*)(&__4))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
    *(uint2*)(Output_local_cast_1 + 0) = __4;
    *(uint2*)(Output + (((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 32)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 512)) = *(uint2*)(Output_local_cast_1 + 0);
  }
}

