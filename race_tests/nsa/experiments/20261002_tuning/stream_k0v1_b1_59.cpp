#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[16];
  half_t tile[16];
  extern __shared__ __align__(1024) half_t v_shared[];
  half_t packed_v[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + ((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 2048)) + (i * 1024)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 2; ++i_1) {
    *(uint4*)(PackedK + (((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_1 * 64)) + ((((int)threadIdx.x) >> 4) * 8))) = *(uint4*)(ktile + (i_1 * 8));
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 2; ++i_2) {
    *(uint4*)(tile + (i_2 * 8)) = *(uint4*)(V + ((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 2048)) + (i_2 * 1024)) + (((int)threadIdx.x) * 8)));
  }
  __syncthreads();
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    *(uint2*)(v_shared + ((((i_3 >> 1) * 1024) + ((((int)threadIdx.x) >> 4) * 128)) + (((((((int)threadIdx.x) & 15) * 2) + (i_3 & 1)) ^ (((i_3 >> 1) * 8) + (((int)threadIdx.x) >> 4))) * 4))) = *(uint2*)(tile + (i_3 * 4));
  }
  __syncthreads();
  #pragma unroll
  for (int i_4 = 0; i_4 < 16; ++i_4) {
    packed_v[i_4] = v_shared[((((((((int)threadIdx.x) & 63) >> 4) * 512) + ((i_4 & 3) * 128)) + (((((((i_4 >> 3) * 16) + ((((int)threadIdx.x) >> 6) * 8)) + (((i_4 & 7) >> 2) * 4)) + ((((int)threadIdx.x) & 15) >> 2)) ^ ((((((int)threadIdx.x) & 63) >> 4) * 4) + (i_4 & 3))) * 4)) + (((int)threadIdx.x) & 3))];
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    *(uint4*)(Packed + ((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 2048)) + (i_5 * 1024)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_v + (i_5 * 8));
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
  half_t q_stage[32];
  half_t k[32];
  half_t q[32];
  float scores[4];
  half_t v[32];
  float denom[1];
  float inv[1];
  half_t prob[4];
  half_t output_reg[32];
  float out[32];
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    *(uint2*)(q_stage + (i * 4)) = *(uint2*)(Q + ((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + (i * 256)) + (((int)threadIdx.x) * 4)));
  }
  int block = Indices[((((int)blockIdx.y) * 1024) + ((int)blockIdx.x))];
  if (((0 <= block) && (block < 64)) && ((block * 16) <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 4; ++i_1) {
      *(uint4*)(k + (i_1 * 8)) = *(uint4*)(K + ((((((int)blockIdx.y) * 131072) + (block * 2048)) + (i_1 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + ((((i_2 * 256) + ((((int)threadIdx.x) >> 5) * 128)) + ((((((int)threadIdx.x) & 31) >> 1) ^ ((i_2 * 2) + (((int)threadIdx.x) >> 5))) * 8)) + ((((int)threadIdx.x) & 1) * 4))) = *(uint2*)(q_stage + (i_2 * 4));
    }
    __syncwarp();
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      *(uint4*)(q + (i_3 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 128) + ((((i_3 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 4; ++i_4) {
      float condval;
      if (((((block * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_4) <= ((int)blockIdx.x))) {
        condval = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval = -MACART_INF_F;
      }
      scores[i_4] = condval;
    }
    for (int ki = 0; ki < 4; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k) + ((ki * 2) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + 0));
    };
      }
    }
    #pragma unroll
    for (int vd = 0; vd < 4; ++vd) {
      *(uint4*)(v + (vd * 8)) = *(uint4*)(V + ((((((int)blockIdx.y) * 131072) + (block * 2048)) + (vd * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      scores[i_5] = exp2f(min((scores[i_5] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    denom[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int rv = 0; rv < 4; ++rv) {
      denom[0] = (denom[0] + scores[rv]);
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
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      scores[i_6] = (scores[i_6] * inv[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(scores + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(prob + 0) = __1;
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 8; ++i_7) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_7 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= block) && (block < 64)) && ((block * 16) <= ((int)blockIdx.x))) {
    for (int j = 0; j < 8; ++j) {
      {
      *(((float32x4*)out) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + j),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j));
    };
    }
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 8; ++i_8) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_8 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(output_reg + (i_8 * 4)) = __2;
  }
  __syncwarp();
  #pragma unroll
  for (int i_9 = 0; i_9 < 8; ++i_9) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_9 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(output_reg + (i_9 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_10 = 0; i_10 < 4; ++i_10) {
    *(uint4*)(Output + ((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + (i_10 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_10 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_10 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
  }
}

