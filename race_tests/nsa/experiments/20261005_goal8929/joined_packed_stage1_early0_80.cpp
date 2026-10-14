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
  *(uint4*)(ktile + 0) = *(uint4*)(K + ((((int)blockIdx.x) * 1024) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + (((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + ((((int)blockIdx.x) * 1024) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[(((((((((int)blockIdx.x) * 1024) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
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
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  int indices[8];
  half_t q[16];
  half_t k[128];
  float scores[32];
  half_t v[128];
  half_t prob[32];
  float out[16];
  float denom[1];
  float inv[1];
  half_t out_half[16];
  #pragma unroll
  for (int s = 0; s < 8; ++s) {
    indices[s] = Indices[((((int)blockIdx.x) * 8) + s)];
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 16; ++i_1) {
    int raw = indices[(i_1 & 7)];
    half_t broadcast_var = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval;
    if ((((0 <= raw) && (raw < 16)) && (raw <= (((int)blockIdx.x) >> 4)))) {
      condval = *(uint4*)(K + (((((int64_t)raw) * (int64_t)1024) + ((((int64_t)i_1) >> (int64_t)3) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval = make_uint4(__pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var));
    }
    *(uint4*)(k + (i_1 * 8)) = condval;
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 32; ++i_2) {
    int raw_1 = indices[(i_2 >> 2)];
    float condval_1;
    if (((((0 <= raw_1) && (raw_1 < 16)) && (raw_1 < 16)) && ((((raw_1 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + (i_2 & 3)) <= ((int)blockIdx.x)))) {
      condval_1 = 0x0p+0f/*0.000000e+00*/;
    } else {
      condval_1 = -MACART_INF_F;
    }
    scores[i_2] = condval_1;
  }
  for (int ki = 0; ki < 2; ++ki) {
    for (int kp = 0; kp < 2; ++kp) {
      for (int j = 0; j < 8; ++j) {
        {
      *(((float32x4*)scores) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k) + (((ki * 16) + (j * 2)) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + j));
    };
      }
    }
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 16; ++i_3) {
    int raw_2 = indices[(i_3 >> 1)];
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_2;
    if ((((0 <= raw_2) && (raw_2 < 16)) && (raw_2 <= (((int)blockIdx.x) >> 4)))) {
      condval_2 = *(uint4*)(V + (((((int64_t)raw_2) * (int64_t)1024) + ((((int64_t)i_3) & (int64_t)1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval_2 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint4*)(v + (i_3 * 8)) = condval_2;
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 32; ++i_4) {
    scores[i_4] = exp2f(min((scores[i_4] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 8; ++i_5) {
    uint2 __1;
    float4 v_ = *(float4*)(scores + (i_5 * 4));
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(prob + (i_5 * 4)) = __1;
  }
  #pragma unroll
  for (int i_6 = 0; i_6 < 4; ++i_6) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_6 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  }
  for (int ki_1 = 0; ki_1 < 8; ++ki_1) {
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + ((ki_1 * 4) + j_1)),
                    *(((float16x4*)prob) + ki_1),
                    *(((float32x4*)out) + j_1));
    };
    }
  }
  denom[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 32; ++rv) {
    denom[0] = (denom[0] + scores[(((rv & 7) * 4) + (rv >> 3))]);
  }
  denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[0])));
  float condval_3;
  if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
    condval_3 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
  } else {
    condval_3 = 0x0p+0f/*0.000000e+00*/;
  }
  inv[0] = condval_3;
  #pragma unroll
  for (int i_7 = 0; i_7 < 16; ++i_7) {
    out[i_7] = (out[i_7] * inv[0]);
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 4; ++i_8) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_8 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(out_half + (i_8 * 4)) = __2;
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_9 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(out_half + (i_9 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_10 = 0; i_10 < 2; ++i_10) {
    *(uint4*)(Output + (((((int)blockIdx.x) * 1024) + (i_10 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_10 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

