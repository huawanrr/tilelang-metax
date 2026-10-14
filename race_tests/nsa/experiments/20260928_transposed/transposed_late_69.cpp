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
  half_t q[32];
  float out[32];
  half_t k[64];
  half_t v[64];
  float scores[8];
  float denom[4];
  float inv[4];
  half_t ka[16];
  half_t prob_local_cast[4];
  half_t va[32];
  half_t pb[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int block = Indices[((((int)blockIdx.y) * 1024) + ((int)blockIdx.x))];
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      *(uint4*)(k + (i_2 * 8)) = *(uint4*)(K + ((((((int)blockIdx.y) * 131072) + (block * 4096)) + (i_2 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 8; ++i_3) {
      *(uint4*)(v + (i_3 * 8)) = *(uint4*)(V + ((((((int)blockIdx.y) * 131072) + (block * 4096)) + (i_3 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_4 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_4 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(k + (i_4 * 8));
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 8; ++i_5) {
      float condval;
      if (((((block * 32) + ((i_5 >> 2) * 16)) + (((int)threadIdx.x) & 15)) <= ((int)blockIdx.x))) {
        condval = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval = -MACART_INF_F;
      }
      scores[i_5] = condval;
    }
  }
  __syncthreads();
  if (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x))) {
    for (int ki = 0; ki < 4; ++ki) {
      for (int i_6 = 0; i_6 < 2; ++i_6) {
        *(uint4*)(ka + (i_6 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_6 * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
      }
      for (int kp = 0; kp < 2; ++kp) {
        for (int i_7 = 0; i_7 < 2; ++i_7) {
          {
      *(((float32x4*)scores) + i_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float16x4*)ka) + ((i_7 * 2) + kp)),
                    *(((float32x4*)scores) + i_7));
    };
        }
      }
    }
  }
  __syncthreads();
  if (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_8 = 0; i_8 < 8; ++i_8) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_8 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_8 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(v + (i_8 * 8));
    }
    #pragma unroll
    for (int i_9 = 0; i_9 < 8; ++i_9) {
      scores[i_9] = exp2f(min((scores[i_9] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_10 = 0; i_10 < 2; ++i_10) {
      uint2 __1;
      float4 v_ = *(float4*)(scores + (i_10 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob_local_cast + 0) = __1;
      *(uint2*)(((half_t*)buf_dyn_shmem) + (((((i_10 * 256) + ((((int)threadIdx.x) & 15) * 16)) + (((((int)threadIdx.x) >> 5) ^ ((((int)threadIdx.x) & 7) >> 2)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 4096)) = *(uint2*)(prob_local_cast + 0);
    }
  }
  __syncthreads();
  if (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x))) {
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int i_11 = 0; i_11 < 8; ++i_11) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          va[((i_11 * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((ki_1 * 2048) + ((((int)threadIdx.x) >> 4) * 512)) + (local_id * 128)) + ((((i_11 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ (((((int)threadIdx.x) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      for (int local_id_1 = 0; local_id_1 < 4; ++local_id_1) {
        pb[local_id_1] = ((half_t*)buf_dyn_shmem)[((((((ki_1 * 256) + ((((int)threadIdx.x) >> 4) * 64)) + (local_id_1 * 16)) + ((((((int)threadIdx.x) & 15) >> 3) ^ ((((int)threadIdx.x) & 31) >> 4)) * 8)) + (((int)threadIdx.x) & 7)) + 4096)];
      }
      for (int i_12 = 0; i_12 < 8; ++i_12) {
        {
      *(((float32x4*)out) + i_12) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)pb) + 0),
                    *(((float16x4*)va) + i_12),
                    *(((float32x4*)out) + i_12));
    };
      }
    }
    #pragma unroll
    for (int i_13 = 0; i_13 < 4; ++i_13) {
      denom[i_13] = 0x0p+0f/*0.000000e+00*/;
      #pragma unroll
      for (int rv = 0; rv < 2; ++rv) {
        denom[i_13] = (denom[i_13] + scores[((rv * 4) + i_13)]);
      }
      denom[i_13] = tl::AllReduce<tl::SumOp, 16, 1, 0>::run(denom[i_13]);
    }
    #pragma unroll
    for (int i_14 = 0; i_14 < 4; ++i_14) {
      float condval_1;
      if ((0x0p+0f/*0.000000e+00*/ < denom[i_14])) {
        condval_1 = (0x1p+0f/*1.000000e+00*/ / denom[i_14]);
      } else {
        condval_1 = 0x0p+0f/*0.000000e+00*/;
      }
      inv[i_14] = condval_1;
    }
    #pragma unroll
    for (int i_15 = 0; i_15 < 32; ++i_15) {
      out[i_15] = (out[i_15] * inv[(i_15 & 3)]);
    }
  }
  #pragma unroll
  for (int i_16 = 0; i_16 < 32; ++i_16) {
    Output[((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) >> 4) * 512)) + ((i_16 & 3) * 128)) + ((i_16 >> 2) * 16)) + (((int)threadIdx.x) & 15))] = ((half_t)out[i_16]);
  }
}

