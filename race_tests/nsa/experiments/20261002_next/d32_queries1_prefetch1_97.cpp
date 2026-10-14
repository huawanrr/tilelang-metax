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
  float out[8];
  uint mma_k_0[4];
  float scores[4];
  extern __shared__ __align__(1024) half_t shared[];
  float sums[1];
  half_t prob[4];
  half_t vb[8];
  half_t Output_local_cast[4];
  *(uint4*)(q_0 + 0) = *(uint4*)(Q + ((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 512)) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  int index_0 = Indices[((((int)blockIdx.y) * 96) + ((int)blockIdx.x))];
  bool valid_0 = (((0 <= index_0) && (index_0 < 6)) && ((min(max(index_0, -1), 6) * 16) <= ((int)blockIdx.x)));
  if (valid_0) {
    half_t broadcast_var = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval;
    if ((index_0 < 6)) {
      condval = *(uint4*)(K + (((((int64_t)((int)blockIdx.y)) * (int64_t)3072) + (max(((int64_t)index_0), (int64_t)-1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval = make_uint4(__pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var));
    }
    *(uint4*)(((half_t*)words_0) + 0) = condval;
    *(uint4*)(v_0 + 0) = *(uint4*)(V + (((((int)blockIdx.y) * 3072) + (min(max(index_0, -1), 6) * 512)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  if (valid_0) {
    #pragma unroll
    for (int word = 0; word < 4; ++word) {
      mma_k_0[word] = __shfl_sync((uint64_t)18446744073709551615, words_0[word], (((((int)threadIdx.x) & 15) * 4) + (((int)threadIdx.x) >> 4)), 64);
    }
    #pragma unroll
    for (int i_1 = 0; i_1 < 4; ++i_1) {
      float condval_1;
      if (((index_0 < 6) && ((((min(max(index_0, -1), 6) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_1) <= ((int)blockIdx.x)))) {
        condval_1 = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval_1 = -MACART_INF_F;
      }
      scores[i_1] = condval_1;
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
    uint2 __1;
    float4 __2;
      float4 v_ = *(float4*)(scores + 0);
      float4 v__1 = make_float4(sums[0], sums[0], sums[0], sums[0]);
      __2.x = (v_.x*v__1.x);
      __2.y = (v_.y*v__1.y);
      __2.z = (v_.z*v__1.z);
      __2.w = (v_.w*v__1.w);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&__2))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&__2))[1]);
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
  for (int i_3 = 0; i_3 < 2; ++i_3) {
    uint2 __3;
    float4 v__2 = *(float4*)(out + (i_3 * 4));
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(Output_local_cast + 0) = __3;
    *(uint2*)(Output + (((((((int)blockIdx.y) * 49152) + (((int)blockIdx.x) * 512)) + ((((int)threadIdx.x) & 15) * 32)) + (i_3 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

