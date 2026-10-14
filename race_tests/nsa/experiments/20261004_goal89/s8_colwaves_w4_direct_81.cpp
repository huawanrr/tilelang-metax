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
  *(uint4*)(ktile + 0) = *(uint4*)(K + (((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + ((((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + (((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[((((((((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
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
extern "C" __global__ void __launch_bounds__(256, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  half_t q[16];
  half_t k[32];
  float scores[8];
  float denom[1];
  half_t prob_shared_local_cast[4];
  half_t prob[32];
  half_t v[32];
  float out[4];
  half_t out_shared_local_cast_1[4];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 524288) + (((int)blockIdx.y) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + (((((int)threadIdx.x) & 63) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    int raw_k = Indices[((((((int)blockIdx.x) * 4096) + (((int)blockIdx.y) * 8)) + ((((int)threadIdx.x) >> 6) * 2)) + (i_1 & 1))];
    half_t broadcast_var = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval;
    if ((((0 <= raw_k) && (raw_k < 32)) && (raw_k <= (((int)blockIdx.y) >> 4)))) {
      condval = *(uint4*)(K + ((((((int64_t)((int)blockIdx.x)) * (int64_t)32768) + (((int64_t)raw_k) * (int64_t)1024)) + ((((int64_t)i_1) >> (int64_t)1) * (int64_t)512)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)63) * (int64_t)8)));
    } else {
      condval = make_uint4(__pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var));
    }
    *(uint4*)(k + (i_1 * 8)) = condval;
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 2; ++i_2) {
    for (int vec_s = 0; vec_s < 4; ++vec_s) {
      int raw_s = Indices[((((((int)blockIdx.x) * 4096) + (((int)blockIdx.y) * 8)) + ((((int)threadIdx.x) >> 6) * 2)) + i_2)];
      float condval_1;
      if (((((0 <= raw_s) && (raw_s < 32)) && (raw_s < 32)) && ((((raw_s * 16) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + vec_s) <= ((int)blockIdx.y)))) {
        condval_1 = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval_1 = -MACART_INF_F;
      }
      scores[((i_2 * 4) + vec_s)] = condval_1;
    }
  }
  for (int ki = 0; ki < 2; ++ki) {
    for (int kp = 0; kp < 2; ++kp) {
      for (int j = 0; j < 2; ++j) {
        {
      *(((float32x4*)scores) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k) + (((ki * 4) + (j * 2)) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + j));
    };
      }
    }
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 8; ++i_3) {
    scores[i_3] = exp2f(min((scores[i_3] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
  }
  denom[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 8; ++rv) {
    denom[0] = (denom[0] + scores[(((rv & 1) * 4) + (rv >> 1))]);
  }
  denom[0] = tl::AllReduce<tl::SumOp, 256, 64, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[0])));
  denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[0])));
  __syncthreads();
  #pragma unroll
  for (int i_4 = 0; i_4 < 2; ++i_4) {
    uint2 __1;
    float4 v_ = *(float4*)(scores + (i_4 * 4));
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(prob_shared_local_cast + 0) = __1;
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((((((int)threadIdx.x) >> 6) * 4) + (i_4 * 2)) + ((((int)threadIdx.x) & 63) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(prob_shared_local_cast + 0);
  }
  if ((((int)threadIdx.x) >> 4) == 0) {
    ((float*)buf_dyn_shmem)[((((int)threadIdx.x) & 15) + 1024)] = denom[0];
  }
  __syncthreads();
  #pragma unroll
  for (int i_5 = 0; i_5 < 8; ++i_5) {
    *(uint2*)(prob + (i_5 * 4)) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_5 * 2) + ((((int)threadIdx.x) & 63) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
  }
  #pragma unroll
  for (int i_6 = 0; i_6 < 8; ++i_6) {
    int raw_v = Indices[(((((int)blockIdx.x) * 4096) + (((int)blockIdx.y) * 8)) + i_6)];
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    uint2 condval_2;
    if ((((0 <= raw_v) && (raw_v < 32)) && (raw_v <= (((int)blockIdx.y) >> 4)))) {
      condval_2 = *(uint2*)(V + (((((((int64_t)((int)blockIdx.x)) * (int64_t)32768) + (((int64_t)raw_v) * (int64_t)1024)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)7) * (int64_t)512)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)63) * (int64_t)8)) + (((((int64_t)((int)threadIdx.x)) & (int64_t)127) >> (int64_t)6) * (int64_t)4)));
    } else {
      condval_2 = make_uint2(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint2*)(v + (i_6 * 4)) = condval_2;
  }
  float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(out + 0) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  for (int ki_1 = 0; ki_1 < 8; ++ki_1) {
    {
      *(((float32x4*)out) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + ki_1),
                    *(((float16x4*)prob) + ki_1),
                    *(((float32x4*)out) + 0));
    };
  }
  float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
  float4 condval_3;
  if ((0x0p+0f/*0.000000e+00*/ < ((float*)buf_dyn_shmem)[((((int)threadIdx.x) & 15) + 1024)])) {
    float4 __2;
      float4 v__1 = *(float4*)(out + 0);
      float4 v__2 = make_float4(((float*)buf_dyn_shmem)[((((int)threadIdx.x) & 15) + 1024)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) & 15) + 1024)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) & 15) + 1024)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) & 15) + 1024)]);
      __2.x = (v__1.x/v__2.x);
      __2.y = (v__1.y/v__2.y);
      __2.z = (v__1.z/v__2.z);
      __2.w = (v__1.w/v__2.w);
    condval_3 = __2;
  } else {
    condval_3 = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  }
  *(float4*)(out + 0) = condval_3;
  __syncthreads();
  uint2 __3;
  float4 v__3 = *(float4*)(out + 0);
  ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
  ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
  *(uint2*)(out_shared_local_cast_1 + 0) = __3;
  *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + (((((int)threadIdx.x) >> 5) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(out_shared_local_cast_1 + 0);
  __syncthreads();
  *(uint2*)(Output + (((((int)blockIdx.x) * 524288) + (((int)blockIdx.y) * 1024)) + (((int)threadIdx.x) * 4))) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) >> 4) * 64) + ((((((int)threadIdx.x) & 15) >> 1) ^ ((((int)threadIdx.x) & 127) >> 4)) * 8)) + ((((int)threadIdx.x) & 1) * 4)));
}

