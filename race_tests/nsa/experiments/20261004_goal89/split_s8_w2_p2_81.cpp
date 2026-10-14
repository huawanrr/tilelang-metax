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
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  int indices[4];
  half_t q[16];
  float out[16];
  float sums[4];
  half_t k0[16];
  half_t k1[16];
  half_t v[16];
  float scores[4];
  half_t prob[4];
  float denom[1];
  float inv[1];
  half_t partial_local_cast[4];
  half_t partial_local_cast_1[8];
  half_t partial_local_cast_2[8];
  half_t result[8];
  #pragma unroll
  for (int s = 0; s < 4; ++s) {
    indices[s] = Indices[((((((int)blockIdx.x) * 4096) + (((int)blockIdx.y) * 8)) + ((((int)threadIdx.x) >> 6) * 4)) + s)];
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 524288) + (((int)blockIdx.y) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + (((((int)threadIdx.x) & 63) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sums + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  #pragma unroll
  for (int group = 0; group < 2; ++group) {
    int raw0 = indices[(group * 2)];
    if (((0 <= raw0) && (raw0 < 32)) && (raw0 <= (((int)blockIdx.y) >> 4))) {
      #pragma unroll
      for (int i_2 = 0; i_2 < 2; ++i_2) {
        *(uint4*)(k0 + (i_2 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 32768) + (raw0 * 1024)) + (i_2 * 512)) + ((((int)threadIdx.x) & 63) * 8)));
      }
    }
    int raw1 = indices[((group * 2) + 1)];
    if (((0 <= raw1) && (raw1 < 32)) && (raw1 <= (((int)blockIdx.y) >> 4))) {
      #pragma unroll
      for (int i_3 = 0; i_3 < 2; ++i_3) {
        *(uint4*)(k1 + (i_3 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 32768) + (raw1 * 1024)) + (i_3 * 512)) + ((((int)threadIdx.x) & 63) * 8)));
      }
    }
    #pragma unroll
    for (int p = 0; p < 2; ++p) {
      int raw = indices[((group * 2) + p)];
      if (((0 <= raw) && (raw < 32)) && (raw <= (((int)blockIdx.y) >> 4))) {
        #pragma unroll
        for (int i_4 = 0; i_4 < 2; ++i_4) {
          *(uint4*)(v + (i_4 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 32768) + (raw * 1024)) + (i_4 * 512)) + ((((int)threadIdx.x) & 63) * 8)));
        }
        #pragma unroll
        for (int i_5 = 0; i_5 < 4; ++i_5) {
          float condval;
          if (((((raw * 16) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + i_5) <= ((int)blockIdx.y))) {
            condval = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval = -MACART_INF_F;
          }
          scores[i_5] = condval;
        }
        if (p == 0) {
          for (int ki = 0; ki < 2; ++ki) {
            for (int kp = 0; kp < 2; ++kp) {
              {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k0) + ((ki * 2) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + 0));
    };
            }
          }
        } else {
          for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
            for (int kp_1 = 0; kp_1 < 2; ++kp_1) {
              {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k1) + ((ki_1 * 2) + kp_1)),
                    *(((float16x4*)q) + ((ki_1 * 2) + kp_1)),
                    *(((float32x4*)scores) + 0));
    };
            }
          }
        }
        #pragma unroll
        for (int i_6 = 0; i_6 < 4; ++i_6) {
          scores[i_6] = exp2f(min((scores[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
          sums[i_6] = (sums[i_6] + scores[i_6]);
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
  }
  denom[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    denom[0] = (denom[0] + sums[rv]);
  }
  denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[0])));
  float condval_1;
  if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
    condval_1 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
  } else {
    condval_1 = 0x0p+0f/*0.000000e+00*/;
  }
  inv[0] = condval_1;
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
    *(uint2*)(partial_local_cast + 0) = __2;
    *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) >> 6) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_8 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4))) = *(uint2*)(partial_local_cast + 0);
  }
  if (((((int)threadIdx.x) & 63) >> 4) == 0) {
    ((float*)buf_dyn_shmem)[((((((int)threadIdx.x) >> 6) * 16) + (((int)threadIdx.x) & 15)) + 1024)] = denom[0];
  }
  __syncthreads();
  *(uint4*)(partial_local_cast_1 + 0) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((int)threadIdx.x) * 8));
  *(uint4*)(partial_local_cast_2 + 0) = *(uint4*)(((half_t*)buf_dyn_shmem) + ((((int)threadIdx.x) * 8) + 1024));
  for (int i_9 = 0; i_9 < 2; ++i_9) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    uint2 __3;
    float4 condval_2;
    if ((0x0p+0f/*0.000000e+00*/ < (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)]))) {
      float4 __4;
        float4 __5;
          float4 __6;
            float4 __7;
            uint2 v__2 = *(uint2*)(partial_local_cast_1 + (i_9 * 4));
            ((float2*)(&__7))[0] = __half22float2(((half2*)(&v__2))[0]);
            ((float2*)(&__7))[1] = __half22float2(((half2*)(&v__2))[1]);
            float4 v__3 = make_float4(((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)]);
            __6.x = (__7.x*v__3.x);
            __6.y = (__7.y*v__3.y);
            __6.z = (__7.z*v__3.z);
            __6.w = (__7.w*v__3.w);
          float4 __8;
            float4 __9;
            uint2 v__4 = *(uint2*)(partial_local_cast_2 + (i_9 * 4));
            ((float2*)(&__9))[0] = __half22float2(((half2*)(&v__4))[0]);
            ((float2*)(&__9))[1] = __half22float2(((half2*)(&v__4))[1]);
            float4 v__5 = make_float4(((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)], ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)]);
            __8.x = (__9.x*v__5.x);
            __8.y = (__9.y*v__5.y);
            __8.z = (__9.z*v__5.z);
            __8.w = (__9.w*v__5.w);
          __5.x = (__6.x+__8.x);
          __5.y = (__6.y+__8.y);
          __5.z = (__6.z+__8.z);
          __5.w = (__6.w+__8.w);
        float4 v__6 = make_float4((((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)]), (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)]), (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)]), (((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1024)] + ((float*)buf_dyn_shmem)[((((int)threadIdx.x) >> 3) + 1040)]));
        __4.x = (__5.x/v__6.x);
        __4.y = (__5.y/v__6.y);
        __4.z = (__5.z/v__6.z);
        __4.w = (__5.w/v__6.w);
      condval_2 = __4;
    } else {
      condval_2 = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
    }
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&condval_2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&condval_2))[1]);
    *(uint2*)(result + (i_9 * 4)) = __3;
  }
  *(uint4*)(Output + (((((int)blockIdx.x) * 524288) + (((int)blockIdx.y) * 1024)) + (((int)threadIdx.x) * 8))) = *(uint4*)(result + 0);
}

