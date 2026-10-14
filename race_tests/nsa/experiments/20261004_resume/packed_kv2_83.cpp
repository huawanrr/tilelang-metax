#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[32];
  half_t packed_v[32];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + (((((int)blockIdx.x) * 4096) + (i * 1024)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    *(uint4*)(PackedK + ((((((((int)blockIdx.x) * 4096) + (((((int)threadIdx.x) & 15) >> 2) * 1024)) + ((i_1 >> 1) * 512)) + ((((int)threadIdx.x) & 3) * 128)) + ((i_1 & 1) * 64)) + ((((int)threadIdx.x) >> 4) * 8))) = *(uint4*)(ktile + (i_1 * 8));
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 32; ++i_2) {
    packed_v[i_2] = V[((((((((((int)blockIdx.x) * 4096) + ((i_2 >> 4) * 2048)) + (((((int)threadIdx.x) & 63) >> 4) * 512)) + ((i_2 & 3) * 128)) + (((i_2 & 15) >> 3) * 64)) + ((((int)threadIdx.x) >> 6) * 32)) + (((i_2 & 7) >> 2) * 16)) + (((int)threadIdx.x) & 15))];
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    *(uint4*)(Packed + (((((int)blockIdx.x) * 4096) + (i_3 * 1024)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_v + (i_3 * 8));
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
    *(uint2*)(q_stage + (i * 4)) = *(uint2*)(Q + (((((int)blockIdx.x) * 2048) + (i * 256)) + (((int)threadIdx.x) * 4)));
  }
  int block = Indices[((int)blockIdx.x)];
  bool valid = (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x)));
  if (valid) {
    #pragma unroll
    for (int packed_slot = 0; packed_slot < 8; ++packed_slot) {
      #pragma unroll
      for (int packed_word = 0; packed_word < 4; ++packed_word) {
        *(uint1*)(k + ((packed_slot * 8) + (packed_word * 2))) = *(uint1*)(K + ((((((int64_t)block) * (int64_t)4096) + (((int64_t)packed_slot) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + (((int64_t)packed_word) * (int64_t)2)));
      }
    }
    #pragma unroll
    for (int i_1 = 0; i_1 < 8; ++i_1) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + ((((i_1 * 256) + ((((int)threadIdx.x) >> 5) * 128)) + ((((((int)threadIdx.x) & 31) >> 1) ^ ((i_1 * 2) + (((int)threadIdx.x) >> 5))) * 8)) + ((((int)threadIdx.x) & 1) * 4))) = *(uint2*)(q_stage + (i_1 * 4));
    }
    __syncwarp();
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      *(uint4*)(q + (i_2 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 128) + ((((i_2 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 8; ++i_3) {
      float condval;
      if (((block < 32) && (((((block * 32) + ((i_3 >> 2) * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + (i_3 & 3)) <= ((int)blockIdx.x)))) {
        condval = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval = -MACART_INF_F;
      }
      scores[i_3] = condval;
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
    for (int packed_slot_1 = 0; packed_slot_1 < 8; ++packed_slot_1) {
      #pragma unroll
      for (int packed_word_1 = 0; packed_word_1 < 4; ++packed_word_1) {
        *(uint1*)(v + ((packed_slot_1 * 8) + (packed_word_1 * 2))) = *(uint1*)(V + ((((((int64_t)block) * (int64_t)4096) + (((int64_t)packed_slot_1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + (((int64_t)packed_word_1) * (int64_t)2)));
      }
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      scores[i_4] = exp2f(min((scores[i_4] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
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
    for (int i_5 = 0; i_5 < 8; ++i_5) {
      scores[i_5] = (scores[i_5] * inv[0]);
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 2; ++i_6) {
      uint2 __1;
      float4 v_ = *(float4*)(scores + (i_6 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob + (i_6 * 4)) = __1;
    }
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 8; ++i_7) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_7 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
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
    *(uint4*)(Output + (((((int)blockIdx.x) * 2048) + (i_10 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_10 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_10 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
  }
}

