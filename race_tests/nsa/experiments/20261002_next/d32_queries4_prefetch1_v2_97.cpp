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
  uint words_0[4];
  half_t v_0[8];
  half_t q_1[8];
  uint words_1[4];
  half_t v_1[8];
  half_t q_2[8];
  uint words_2[4];
  half_t v_2[8];
  half_t q_3[8];
  uint words_3[4];
  half_t v_3[8];
  float out[8];
  uint mma_k_0[4];
  float scores[4];
  extern __shared__ __align__(1024) half_t shared[];
  float sums[1];
  half_t prob[4];
  half_t vb[8];
  uint mma_k_1[4];
  uint mma_k_2[4];
  uint mma_k_3[4];
  half_t Output_local_cast[4];
  half_t Output_local_cast_1[4];
  half_t Output_local_cast_2[4];
  half_t Output_local_cast_3[4];
  *(uint4*)(q_0 + 0) = *(uint4*)(Q + ((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  int index_0 = Indices[((((int)blockIdx.y) * 96) + (((int)blockIdx.x) * 4))];
  bool valid_0 = (((0 <= index_0) && (index_0 < 6)) && (index_0 <= (((int)blockIdx.x) >> 2)));
  if (valid_0) {
    half_t broadcast_var = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval;
    if ((index_0 < 6)) {
      condval = *(uint4*)(K + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_0) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval = make_uint4(__pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var));
    }
    *(uint4*)(((half_t*)words_0) + 0) = condval;
    *(uint4*)(v_0 + 0) = *(uint4*)(V + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_0) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
  }
  *(uint4*)(q_1 + 0) = *(uint4*)(Q + (((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)) + 512));
  int index_1 = Indices[(((((int)blockIdx.y) * 96) + (((int)blockIdx.x) * 4)) + 1)];
  bool valid_1 = (((0 <= index_1) && (index_1 < 6)) && (index_1 <= (((int)blockIdx.x) >> 2)));
  if (valid_1) {
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_1;
    if ((index_1 < 6)) {
      condval_1 = *(uint4*)(K + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval_1 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint4*)(((half_t*)words_1) + 0) = condval_1;
    *(uint4*)(v_1 + 0) = *(uint4*)(V + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
  }
  *(uint4*)(q_2 + 0) = *(uint4*)(Q + (((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)) + 1024));
  int index_2 = Indices[(((((int)blockIdx.y) * 96) + (((int)blockIdx.x) * 4)) + 2)];
  bool valid_2 = (((0 <= index_2) && (index_2 < 6)) && (index_2 <= (((int)blockIdx.x) >> 2)));
  if (valid_2) {
    half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_2;
    if ((index_2 < 6)) {
      condval_2 = *(uint4*)(K + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_2) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval_2 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
    }
    *(uint4*)(((half_t*)words_2) + 0) = condval_2;
    *(uint4*)(v_2 + 0) = *(uint4*)(V + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_2) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
  }
  *(uint4*)(q_3 + 0) = *(uint4*)(Q + (((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)) + 1536));
  int index_3 = Indices[(((((int)blockIdx.y) * 96) + (((int)blockIdx.x) * 4)) + 3)];
  bool valid_3 = (((0 <= index_3) && (index_3 < 6)) && (index_3 <= (((int)blockIdx.x) >> 2)));
  if (valid_3) {
    half_t broadcast_var_3 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_3;
    if ((index_3 < 6)) {
      condval_3 = *(uint4*)(K + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_3) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval_3 = make_uint4(__pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3));
    }
    *(uint4*)(((half_t*)words_3) + 0) = condval_3;
    *(uint4*)(v_3 + 0) = *(uint4*)(V + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (((int64_t)index_3) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i * 4)) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
  }
  if (valid_0) {
    #pragma unroll
    for (int word = 0; word < 4; ++word) {
      mma_k_0[word] = __shfl_sync((uint64_t)18446744073709551615, words_0[word], (((((int)threadIdx.x) & 15) * 4) + (((int)threadIdx.x) >> 4)), 64);
    }
    if (((((int)blockIdx.x) >> 2) - index_0) < 1) {
      #pragma unroll
      for (int i_1 = 0; i_1 < 4; ++i_1) {
        float condval_4;
        if (((((index_0 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_1) <= (((int)blockIdx.x) * 4))) {
          condval_4 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_4 = -MACART_INF_F;
        }
        scores[i_1] = condval_4;
      }
    } else {
      float broadcast_var_5 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(scores + 0) = make_float4(broadcast_var_5, broadcast_var_5, broadcast_var_5, broadcast_var_5);
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
    float condval_5;
    if ((0x0p+0f/*0.000000e+00*/ < sums[0])) {
      condval_5 = (0x1p+0f/*1.000000e+00*/ / sums[0]);
    } else {
      condval_5 = 0x0p+0f/*0.000000e+00*/;
    }
    sums[0] = condval_5;
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
    *(uint2*)(Output + (((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + (i_4 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    float broadcast_var_6 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_5 * 4)) = make_float4(broadcast_var_6, broadcast_var_6, broadcast_var_6, broadcast_var_6);
  }
  if (valid_1) {
    #pragma unroll
    for (int word_1 = 0; word_1 < 4; ++word_1) {
      mma_k_1[word_1] = __shfl_sync((uint64_t)18446744073709551615, words_1[word_1], (((((int)threadIdx.x) & 15) * 4) + (((int)threadIdx.x) >> 4)), 64);
    }
    if (((((int)blockIdx.x) * 2) - (index_1 * 8)) < 7) {
      #pragma unroll
      for (int i_6 = 0; i_6 < 4; ++i_6) {
        float condval_6;
        if (((((index_1 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_6) <= ((((int)blockIdx.x) * 4) + 1))) {
          condval_6 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_6 = -MACART_INF_F;
        }
        scores[i_6] = condval_6;
      }
    } else {
      float broadcast_var_7 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(scores + 0) = make_float4(broadcast_var_7, broadcast_var_7, broadcast_var_7, broadcast_var_7);
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
    float condval_7;
    if ((0x0p+0f/*0.000000e+00*/ < sums[0])) {
      condval_7 = (0x1p+0f/*1.000000e+00*/ / sums[0]);
    } else {
      condval_7 = 0x0p+0f/*0.000000e+00*/;
    }
    sums[0] = condval_7;
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
    *(uint2*)(Output + ((((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 512)) = *(uint2*)(Output_local_cast_1 + 0);
  }
  #pragma unroll
  for (int i_10 = 0; i_10 < 2; ++i_10) {
    float broadcast_var_8 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_10 * 4)) = make_float4(broadcast_var_8, broadcast_var_8, broadcast_var_8, broadcast_var_8);
  }
  if (valid_2) {
    #pragma unroll
    for (int word_2 = 0; word_2 < 4; ++word_2) {
      mma_k_2[word_2] = __shfl_sync((uint64_t)18446744073709551615, words_2[word_2], (((((int)threadIdx.x) & 15) * 4) + (((int)threadIdx.x) >> 4)), 64);
    }
    if (((((int)blockIdx.x) * 2) - (index_2 * 8)) < 7) {
      #pragma unroll
      for (int i_11 = 0; i_11 < 4; ++i_11) {
        float condval_8;
        if (((((index_2 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_11) <= ((((int)blockIdx.x) * 4) + 2))) {
          condval_8 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_8 = -MACART_INF_F;
        }
        scores[i_11] = condval_8;
      }
    } else {
      float broadcast_var_9 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(scores + 0) = make_float4(broadcast_var_9, broadcast_var_9, broadcast_var_9, broadcast_var_9);
    }
    for (int kp_2 = 0; kp_2 < 2; ++kp_2) {
      {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)mma_k_2) + kp_2),
                    *(((float16x4*)q_2) + kp_2),
                    *(((float32x4*)scores) + 0));
    };
    }
    *(uint4*)(shared + ((((int)threadIdx.x) * 8) + 1024)) = *(uint4*)(v_2 + 0);
    #pragma unroll
    for (int i_12 = 0; i_12 < 4; ++i_12) {
      scores[i_12] = exp2f(min((scores[i_12] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    sums[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      sums[0] = (sums[0] + scores[j_4]);
    }
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 32, 64));
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 16, 64));
    float condval_9;
    if ((0x0p+0f/*0.000000e+00*/ < sums[0])) {
      condval_9 = (0x1p+0f/*1.000000e+00*/ / sums[0]);
    } else {
      condval_9 = 0x0p+0f/*0.000000e+00*/;
    }
    sums[0] = condval_9;
    #pragma unroll
    for (int i_13 = 0; i_13 < 4; ++i_13) {
      scores[i_13] = (scores[i_13] * sums[0]);
    }
    uint2 __5;
    float4 v__4 = *(float4*)(scores + 0);
    ((half2*)(&__5))[0] = __float22half2_rn(((float2*)(&v__4))[0]);
    ((half2*)(&__5))[1] = __float22half2_rn(((float2*)(&v__4))[1]);
    *(uint2*)(prob + 0) = __5;
    __syncwarp();
    for (int col_2 = 0; col_2 < 2; ++col_2) {
      for (int e_2 = 0; e_2 < 4; ++e_2) {
        vb[((col_2 * 4) + e_2)] = shared[((((((((int)threadIdx.x) >> 4) * 128) + (e_2 * 32)) + (col_2 * 16)) + (((int)threadIdx.x) & 15)) + 1024)];
      }
    }
    for (int j_5 = 0; j_5 < 2; ++j_5) {
      {
      *(((float32x4*)out) + j_5) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_5),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j_5));
    };
    }
  }
  #pragma unroll
  for (int i_14 = 0; i_14 < 2; ++i_14) {
    uint2 __6;
    float4 v__5 = *(float4*)(out + (i_14 * 4));
    ((half2*)(&__6))[0] = __float22half2_rn(((float2*)(&v__5))[0]);
    ((half2*)(&__6))[1] = __float22half2_rn(((float2*)(&v__5))[1]);
    *(uint2*)(Output_local_cast_2 + 0) = __6;
    *(uint2*)(Output + ((((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + (i_14 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 1024)) = *(uint2*)(Output_local_cast_2 + 0);
  }
  #pragma unroll
  for (int i_15 = 0; i_15 < 2; ++i_15) {
    float broadcast_var_10 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_15 * 4)) = make_float4(broadcast_var_10, broadcast_var_10, broadcast_var_10, broadcast_var_10);
  }
  if (valid_3) {
    #pragma unroll
    for (int word_3 = 0; word_3 < 4; ++word_3) {
      mma_k_3[word_3] = __shfl_sync((uint64_t)18446744073709551615, words_3[word_3], (((((int)threadIdx.x) & 15) * 4) + (((int)threadIdx.x) >> 4)), 64);
    }
    if ((((int)blockIdx.x) - (index_3 * 4)) < 3) {
      #pragma unroll
      for (int i_16 = 0; i_16 < 4; ++i_16) {
        float condval_10;
        if (((((index_3 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_16) <= ((((int)blockIdx.x) * 4) + 3))) {
          condval_10 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_10 = -MACART_INF_F;
        }
        scores[i_16] = condval_10;
      }
    } else {
      float broadcast_var_11 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(scores + 0) = make_float4(broadcast_var_11, broadcast_var_11, broadcast_var_11, broadcast_var_11);
    }
    for (int kp_3 = 0; kp_3 < 2; ++kp_3) {
      {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)mma_k_3) + kp_3),
                    *(((float16x4*)q_3) + kp_3),
                    *(((float32x4*)scores) + 0));
    };
    }
    *(uint4*)(shared + ((((int)threadIdx.x) * 8) + 1536)) = *(uint4*)(v_3 + 0);
    #pragma unroll
    for (int i_17 = 0; i_17 < 4; ++i_17) {
      scores[i_17] = exp2f(min((scores[i_17] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    sums[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j_6 = 0; j_6 < 4; ++j_6) {
      sums[0] = (sums[0] + scores[j_6]);
    }
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 32, 64));
    sums[0] = (sums[0] + __shfl_xor_sync((uint64_t)18446744073709551615, sums[0], 16, 64));
    float condval_11;
    if ((0x0p+0f/*0.000000e+00*/ < sums[0])) {
      condval_11 = (0x1p+0f/*1.000000e+00*/ / sums[0]);
    } else {
      condval_11 = 0x0p+0f/*0.000000e+00*/;
    }
    sums[0] = condval_11;
    #pragma unroll
    for (int i_18 = 0; i_18 < 4; ++i_18) {
      scores[i_18] = (scores[i_18] * sums[0]);
    }
    uint2 __7;
    float4 v__6 = *(float4*)(scores + 0);
    ((half2*)(&__7))[0] = __float22half2_rn(((float2*)(&v__6))[0]);
    ((half2*)(&__7))[1] = __float22half2_rn(((float2*)(&v__6))[1]);
    *(uint2*)(prob + 0) = __7;
    __syncwarp();
    for (int col_3 = 0; col_3 < 2; ++col_3) {
      for (int e_3 = 0; e_3 < 4; ++e_3) {
        vb[((col_3 * 4) + e_3)] = shared[((((((((int)threadIdx.x) >> 4) * 128) + (e_3 * 32)) + (col_3 * 16)) + (((int)threadIdx.x) & 15)) + 1536)];
      }
    }
    for (int j_7 = 0; j_7 < 2; ++j_7) {
      {
      *(((float32x4*)out) + j_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_7),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j_7));
    };
    }
  }
  #pragma unroll
  for (int i_19 = 0; i_19 < 2; ++i_19) {
    uint2 __8;
    float4 v__7 = *(float4*)(out + (i_19 * 4));
    ((half2*)(&__8))[0] = __float22half2_rn(((float2*)(&v__7))[0]);
    ((half2*)(&__8))[1] = __float22half2_rn(((float2*)(&v__7))[1]);
    *(uint2*)(Output_local_cast_3 + 0) = __8;
    *(uint2*)(Output + ((((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 32)) + (i_19 * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + 1536)) = *(uint2*)(Output_local_cast_3 + 0);
  }
}

