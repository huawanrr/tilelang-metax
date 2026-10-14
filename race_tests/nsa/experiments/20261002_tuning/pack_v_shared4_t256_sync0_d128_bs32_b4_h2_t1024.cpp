#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(256, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[16];
  half_t tile[16];
  extern __shared__ __align__(1024) half_t v_shared[];
  half_t packed_v[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + ((((((((int)blockIdx.z) * 262144) + (((int)blockIdx.x) * 8192)) + (i * 4096)) + ((((int)threadIdx.x) >> 4) * 256)) + (((int)blockIdx.y) * 128)) + ((((int)threadIdx.x) & 15) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 2; ++i_1) {
    *(uint4*)(PackedK + (((((((((int)blockIdx.z) * 262144) + (((int)blockIdx.x) * 8192)) + (((int)blockIdx.y) * 4096)) + (((((int)threadIdx.x) & 15) >> 2) * 1024)) + (i_1 * 512)) + ((((int)threadIdx.x) & 3) * 128)) + ((((int)threadIdx.x) >> 4) * 8))) = *(uint4*)(ktile + (i_1 * 8));
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 2; ++i_2) {
    *(uint4*)(tile + (i_2 * 8)) = *(uint4*)(V + ((((((((int)blockIdx.z) * 262144) + (((int)blockIdx.x) * 8192)) + (i_2 * 4096)) + ((((int)threadIdx.x) >> 4) * 256)) + (((int)blockIdx.y) * 128)) + ((((int)threadIdx.x) & 15) * 8)));
  }
  __syncthreads();
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    *(uint2*)(v_shared + ((((i_3 >> 1) * 2048) + ((((int)threadIdx.x) >> 4) * 128)) + (((((((int)threadIdx.x) & 15) * 2) + (i_3 & 1)) ^ (((int)threadIdx.x) >> 4)) * 4))) = *(uint2*)(tile + (i_3 * 4));
  }
  __syncthreads();
  #pragma unroll
  for (int i_4 = 0; i_4 < 16; ++i_4) {
    packed_v[i_4] = v_shared[((((((i_4 >> 3) * 2048) + (((((int)threadIdx.x) & 63) >> 4) * 512)) + ((i_4 & 3) * 128)) + ((((((((int)threadIdx.x) >> 6) * 8) + (((i_4 & 7) >> 2) * 4)) + ((((int)threadIdx.x) & 15) >> 2)) ^ ((((((int)threadIdx.x) & 63) >> 4) * 4) + (i_4 & 3))) * 4)) + (((int)threadIdx.x) & 3))];
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    *(uint4*)(Packed + (((((((int)blockIdx.z) * 262144) + (((int)blockIdx.x) * 8192)) + (((int)blockIdx.y) * 4096)) + (i_5 * 2048)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_v + (i_5 * 8));
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
  half_t k[64];
  half_t q[32];
  float scores[8];
  half_t v[64];
  float denom[1];
  float inv[1];
  half_t prob[8];
  half_t output_reg[32];
  float out[32];
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    *(uint2*)(q_stage + (i * 4)) = *(uint2*)(Q + ((((((((int)blockIdx.y) >> 1) * 4194304) + (((int)blockIdx.x) * 4096)) + ((((int)blockIdx.y) & 1) * 2048)) + (i * 256)) + (((int)threadIdx.x) * 4)));
  }
  int block = Indices[((((((int)blockIdx.y) >> 1) * 2048) + (((int)blockIdx.x) * 2)) + (((int)blockIdx.y) & 1))];
  bool valid = (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x)));
  if (valid) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 8; ++i_1) {
      *(uint4*)(k + (i_1 * 8)) = *(uint4*)(K + ((((((((int64_t)((int)blockIdx.y)) >> (int64_t)1) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + ((((int64_t)((int)blockIdx.y)) & (int64_t)1) * (int64_t)4096)) + (((int64_t)i_1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
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
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      float condval;
      if (((block < 32) && (((((block * 32) + ((i_4 >> 2) * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + (i_4 & 3)) <= ((int)blockIdx.x)))) {
        condval = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval = -MACART_INF_F;
      }
      scores[i_4] = condval;
    }
    for (int ki = 0; ki < 4; ++ki) {
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
    for (int i_5 = 0; i_5 < 8; ++i_5) {
      *(uint4*)(v + (i_5 * 8)) = *(uint4*)(V + ((((((((int64_t)((int)blockIdx.y)) >> (int64_t)1) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + ((((int64_t)((int)blockIdx.y)) & (int64_t)1) * (int64_t)4096)) + (((int64_t)i_5) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      scores[i_6] = exp2f(min((scores[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    denom[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int rv = 0; rv < 8; ++rv) {
      denom[0] = (denom[0] + scores[(((rv & 1) * 4) + (rv >> 1))]);
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
    for (int i_7 = 0; i_7 < 8; ++i_7) {
      scores[i_7] = (scores[i_7] * inv[0]);
    }
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      uint2 __1;
      float4 v_ = *(float4*)(scores + (i_8 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob + (i_8 * 4)) = __1;
    }
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 8; ++i_9) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_9 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (valid) {
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_1 = 0; j_1 < 8; ++j_1) {
        {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + ((ki_1 * 8) + j_1)),
                    *(((float16x4*)prob) + ki_1),
                    *(((float32x4*)out) + j_1));
    };
      }
    }
  }
  #pragma unroll
  for (int i_10 = 0; i_10 < 8; ++i_10) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_10 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(output_reg + (i_10 * 4)) = __2;
  }
  __syncwarp();
  #pragma unroll
  for (int i_11 = 0; i_11 < 8; ++i_11) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_11 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(output_reg + (i_11 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    *(uint4*)(Output + ((((((((int)blockIdx.y) >> 1) * 4194304) + (((int)blockIdx.x) * 4096)) + ((((int)blockIdx.y) & 1) * 2048)) + (i_12 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_12 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_12 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
  }
}

