#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[8];
  half_t tile[8];
  *(uint4*)(ktile + 0) = *(uint4*)(K + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + ((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[((((((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
  }
}

#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  int indices[8];
  half_t q[16];
  float out[16];
  float sums[16];
  half_t k[64];
  half_t v[64];
  float scores[16];
  half_t prob[16];
  float denom[1];
  extern __shared__ __align__(1024) float workspace[];
  float inv[1];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    indices[si] = Indices[(((((int)blockIdx.x) * 8192) + (((int)blockIdx.y) * 8)) + si)];
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.y) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(sums + (i_2 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  for (int chunk = 0; chunk < 2; ++chunk) {
    #pragma unroll
    for (int nj = 0; nj < 4; ++nj) {
      int block = indices[((chunk * 4) + nj)];
      bool valid = (((0 <= block) && (block < 64)) && ((block * 16) <= ((int)blockIdx.y)));
      #pragma unroll
      for (int i_3 = 0; i_3 < 2; ++i_3) {
        half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
        uint4 condval;
        if (valid) {
          condval = *(uint4*)(K + ((((((int64_t)((int)blockIdx.x)) * (int64_t)65536) + (((int64_t)block) * (int64_t)1024)) + (((int64_t)i_3) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
        } else {
          condval = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
        }
        *(uint4*)(k + ((i_3 * 32) + (nj * 8))) = condval;
      }
      #pragma unroll
      for (int i_4 = 0; i_4 < 16; ++i_4) {
        half_t condval_1;
        if (valid) {
          condval_1 = V[((((((((int64_t)((int)blockIdx.x)) * (int64_t)65536) + (((int64_t)block) * (int64_t)1024)) + (((((int64_t)i_4) & (int64_t)3) >> (int64_t)1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + ((((int64_t)i_4) & (int64_t)1) * (int64_t)4)) + (((int64_t)i_4) >> (int64_t)2))];
        } else {
          condval_1 = half_t(0x0p+0f/*0.000000e+00*/);
        }
        v[(((nj * 16) + ((i_4 & 3) * 4)) + (i_4 >> 2))] = condval_1;
      }
      #pragma unroll
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        float condval_2;
        if (((valid && (block < 64)) && ((((block * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_5) <= ((int)blockIdx.y)))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        scores[((nj * 4) + i_5)] = condval_2;
      }
    }
    for (int ki = 0; ki < 2; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        for (int j = 0; j < 4; ++j) {
          {
      *(((float32x4*)scores) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k) + (((ki * 8) + (j * 2)) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + j));
    };
        }
      }
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 16; ++i_6) {
      scores[i_6] = exp2f(min((scores[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      sums[i_6] = (sums[i_6] + scores[i_6]);
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      uint2 __1;
      float4 v_ = *(float4*)(scores + (i_7 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob + (i_7 * 4)) = __1;
    }
    for (int ki_1 = 0; ki_1 < 4; ++ki_1) {
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + ((ki_1 * 4) + j_1)),
                    *(((float16x4*)prob) + ki_1),
                    *(((float32x4*)out) + j_1));
    };
      }
    }
  }
  denom[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 16; ++rv) {
    denom[0] = (denom[0] + sums[(((rv & 3) * 4) + (rv >> 2))]);
  }
  denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(workspace[0])));
  float condval_3;
  if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
    condval_3 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
  } else {
    condval_3 = 0x0p+0f/*0.000000e+00*/;
  }
  inv[0] = condval_3;
  #pragma unroll
  for (int i_8 = 0; i_8 < 16; ++i_8) {
    out[i_8] = (out[i_8] * inv[0]);
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_9 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.y) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

