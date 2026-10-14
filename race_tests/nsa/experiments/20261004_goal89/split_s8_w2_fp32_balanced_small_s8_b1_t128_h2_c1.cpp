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
  *(uint4*)(ktile + 0) = *(uint4*)(K + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) >> 3) * 128)) + (((int)blockIdx.y) * 64)) + ((((int)threadIdx.x) & 7) * 8)));
  *(uint4*)(PackedK + ((((((int)blockIdx.x) * 2048) + (((int)blockIdx.y) * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + ((((((int)blockIdx.x) * 2048) + ((((int)threadIdx.x) >> 3) * 128)) + (((int)blockIdx.y) * 64)) + ((((int)threadIdx.x) & 7) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[((((((((((int)blockIdx.x) * 2048) + (((int)blockIdx.y) * 1024)) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
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
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  int indices[4];
  half_t q[16];
  float out[16];
  float sums[4];
  half_t k0[16];
  half_t v[16];
  float scores[4];
  half_t prob[4];
  float denom[1];
  half_t result[8];
  float partial_local_cast[4];
  float partial_local_cast_1[4];
  #pragma unroll
  for (int s = 0; s < 4; ++s) {
    indices[s] = Indices[((((((int)blockIdx.y) * 16) + (((int)blockIdx.x) * 8)) + (s * 2)) + (((int)threadIdx.x) >> 6))];
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.y) * 2048) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + (((((int)threadIdx.x) & 63) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sums + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  #pragma unroll
  for (int group = 0; group < 4; ++group) {
    int raw0 = indices[group];
    if (((0 <= raw0) && (raw0 < 8)) && (raw0 <= (((int)blockIdx.y) >> 4))) {
      #pragma unroll
      for (int i_2 = 0; i_2 < 2; ++i_2) {
        *(uint4*)(k0 + (i_2 * 8)) = *(uint4*)(K + ((((raw0 * 2048) + (((int)blockIdx.x) * 1024)) + (i_2 * 512)) + ((((int)threadIdx.x) & 63) * 8)));
      }
    }
    int raw = indices[group];
    if (((0 <= raw) && (raw < 8)) && (raw <= (((int)blockIdx.y) >> 4))) {
      #pragma unroll
      for (int i_3 = 0; i_3 < 2; ++i_3) {
        *(uint4*)(v + (i_3 * 8)) = *(uint4*)(V + ((((raw * 2048) + (((int)blockIdx.x) * 1024)) + (i_3 * 512)) + ((((int)threadIdx.x) & 63) * 8)));
      }
      #pragma unroll
      for (int i_4 = 0; i_4 < 4; ++i_4) {
        float condval;
        if (((((raw * 16) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + i_4) <= ((int)blockIdx.y))) {
          condval = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval = -MACART_INF_F;
        }
        scores[i_4] = condval;
      }
      for (int ki = 0; ki < 2; ++ki) {
        for (int kp = 0; kp < 2; ++kp) {
          {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k0) + ((ki * 2) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        scores[i_5] = exp2f(min((scores[i_5] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
        sums[i_5] = (sums[i_5] + scores[i_5]);
      }
      uint2 __1;
      float4 v_ = *(float4*)(scores + 0);
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob + 0) = __1;
      for (int j = 0; j < 4; ++j) {
        {
      *(((float32x4*)out) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + j),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j));
    };
      }
    }
  }
  denom[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    denom[0] = (denom[0] + sums[rv]);
  }
  denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[0])));
  #pragma unroll
  for (int i_6 = 0; i_6 < 4; ++i_6) {
    *(float4*)(((float*)buf_dyn_shmem) + ((((((int)threadIdx.x) >> 6) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + ((((i_6 * 4) + ((((int)threadIdx.x) & 63) >> 4)) ^ (((int)threadIdx.x) & 15)) * 4))) = *(float4*)(out + (i_6 * 4));
  }
  if (((((int)threadIdx.x) & 63) >> 4) == 0) {
    ((float*)buf_dyn_shmem)[((((((int)threadIdx.x) >> 6) * 16) + (((int)threadIdx.x) & 15)) + 2048)] = denom[0];
  }
  __syncthreads();
  #pragma unroll
  for (int i_7 = 0; i_7 < 2; ++i_7) {
    *(float4*)(partial_local_cast + 0) = *(float4*)(((float*)buf_dyn_shmem) + (((((int)threadIdx.x) >> 3) * 64) + (((((((int)threadIdx.x) & 7) * 2) + i_7) ^ (((int)threadIdx.x) >> 3)) * 4)));
    *(float4*)(partial_local_cast_1 + 0) = *(float4*)(((float*)buf_dyn_shmem) + ((((((int)threadIdx.x) >> 3) * 64) + (((((((int)threadIdx.x) & 7) * 2) + i_7) ^ (((int)threadIdx.x) >> 3)) * 4)) + 1024));
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    uint2 __2;
    float4 condval_1;
    if ((0x0p+0f/*0.000000e+00*/ < (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2048)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2064)]))) {
      float4 __3;
        float4 __4;
          float4 v__1 = *(float4*)(partial_local_cast + 0);
          float4 v__2 = *(float4*)(partial_local_cast_1 + 0);
          __4.x = (v__1.x+v__2.x);
          __4.y = (v__1.y+v__2.y);
          __4.z = (v__1.z+v__2.z);
          __4.w = (v__1.w+v__2.w);
        float4 v__3 = make_float4((((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2048)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2064)]), (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2048)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2064)]), (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2048)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2064)]), (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2048)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 2064)]));
        __3.x = (__4.x/v__3.x);
        __3.y = (__4.y/v__3.y);
        __3.z = (__4.z/v__3.z);
        __3.w = (__4.w/v__3.w);
      condval_1 = __3;
    } else {
      condval_1 = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
    }
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&condval_1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&condval_1))[1]);
    *(uint2*)(result + (i_7 * 4)) = __2;
  }
  *(uint4*)(Output + (((((int)blockIdx.y) * 2048) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8))) = *(uint4*)(result + 0);
}

