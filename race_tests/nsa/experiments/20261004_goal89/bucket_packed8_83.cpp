#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ PackedK, half_t* __restrict__ PackedV, int* __restrict__ Schedule, int* __restrict__ Sorted, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(256, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ PackedK, half_t* __restrict__ PackedV, int* __restrict__ Schedule, int* __restrict__ Sorted, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  half_t ktile[16];
  half_t vtile[16];
  half_t packed_v[16];
  if (((int)blockIdx.x) < 32) {
    #pragma unroll
    for (int i = 0; i < 2; ++i) {
      *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + (((((int)blockIdx.x) * 4096) + (i * 2048)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int i_1 = 0; i_1 < 2; ++i_1) {
      *(uint4*)(PackedK + (((((((int)blockIdx.x) * 4096) + (((((int)threadIdx.x) & 15) >> 2) * 1024)) + (i_1 * 512)) + ((((int)threadIdx.x) & 3) * 128)) + ((((int)threadIdx.x) >> 4) * 8))) = *(uint4*)(ktile + (i_1 * 8));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(vtile + (i_2 * 8)) = *(uint4*)(V + (((((int)blockIdx.x) * 4096) + (i_2 * 2048)) + (((int)threadIdx.x) * 8)));
    }
    __syncthreads();
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + ((((i_3 >> 1) * 2048) + ((((int)threadIdx.x) >> 4) * 128)) + (((((((int)threadIdx.x) & 15) * 2) + (i_3 & 1)) ^ (((int)threadIdx.x) >> 4)) * 4))) = *(uint2*)(vtile + (i_3 * 4));
    }
    __syncthreads();
    #pragma unroll
    for (int i_4 = 0; i_4 < 16; ++i_4) {
      packed_v[i_4] = ((half_t*)buf_dyn_shmem)[((((((i_4 >> 3) * 2048) + (((((int)threadIdx.x) & 63) >> 4) * 512)) + ((i_4 & 3) * 128)) + ((((((((int)threadIdx.x) >> 6) * 8) + (((i_4 & 7) >> 2) * 4)) + ((((int)threadIdx.x) & 15) >> 2)) ^ ((((((int)threadIdx.x) & 63) >> 4) * 4) + (i_4 & 3))) * 4)) + (((int)threadIdx.x) & 3))];
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 2; ++i_5) {
      *(uint4*)(PackedV + (((((int)blockIdx.x) * 4096) + (i_5 * 2048)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_v + (i_5 * 8));
    }
  } else {
    if (((int)threadIdx.x) < 64) {
      ((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 2048)] = 0;
    }
    if (((int)threadIdx.x) < 161) {
      #pragma unroll
      for (int field = 0; field < 3; ++field) {
        Schedule[((((int)threadIdx.x) * 3) + field)] = -1;
      }
    }
    __syncthreads();
    for (int step = 0; step < 4; ++step) {
      int raw = Indices[((step * 256) + ((int)threadIdx.x))];
      int condval;
      if ((((0 <= raw) && (raw < 32)) && ((raw * 32) <= ((step * 256) + ((int)threadIdx.x))))) {
        condval = raw;
      } else {
        condval = 32;
      }
      int slot = AtomicAddRet((&(((int*)buf_dyn_shmem)[(min(max(condval, 0), 32) + 2048)])), 1);
      if (0 <= slot) {
        if (slot < 1024) {
          int condval_1;
          if ((((0 <= raw) && (raw < 32)) && ((raw * 32) <= ((step * 256) + ((int)threadIdx.x))))) {
            condval_1 = raw;
          } else {
            condval_1 = 32;
          }
          Sorted[((min(max(condval_1, 0), 32) * 1024) + slot)] = ((step * 256) + ((int)threadIdx.x));
        }
      }
    }
    __syncthreads();
    if (((int)threadIdx.x) < 64) {
      ((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 2112)] = ((((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 2048)] + 7) >> 3);
    }
    __syncthreads();
    tl::CumSum1D<256, false>::run((&(((int*)buf_dyn_shmem)[2112])), (&(((int*)buf_dyn_shmem)[2112])), 64);
    __syncthreads();
    if (((int)threadIdx.x) < 33) {
      int count = ((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 2048)];
      for (int task = 0; task < ((count + 7) >> 3); ++task) {
        int dst = ((((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 2112)] + task) - ((count + 7) >> 3));
        if (0 <= dst) {
          if (dst < 161) {
            Schedule[(dst * 3)] = ((int)threadIdx.x);
            Schedule[((dst * 3) + 1)] = (task * 8);
            Schedule[((dst * 3) + 2)] = min(8, (count - (task * 8)));
          }
        }
      }
    }
  }
}

#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const int* __restrict__ Schedule, const int* __restrict__ Sorted, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(512, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const int* __restrict__ Schedule, const int* __restrict__ Sorted, const half_t* __restrict__ V) {
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
  half_t output_global[32];
  float out[32];
  int bucket = Schedule[(((int)blockIdx.x) * 3)];
  int first = Schedule[((((int)blockIdx.x) * 3) + 1)];
  int count = Schedule[((((int)blockIdx.x) * 3) + 2)];
  int condval;
  if (((0 <= bucket) && ((((int)threadIdx.x) >> 6) < count))) {
    int condval_1;
    if ((((0 <= ((((int)threadIdx.x) >> 6) + first)) && (((((int)threadIdx.x) >> 6) + first) < 1024)) && (bucket < 33))) {
      condval_1 = Sorted[(((((int64_t)bucket) * (int64_t)1024) + (((int64_t)((int)threadIdx.x)) >> (int64_t)6)) + ((int64_t)first))];
    } else {
      condval_1 = 0;
    }
    condval = condval_1;
  } else {
    condval = 1024;
  }
  int token = condval;
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    half_t broadcast_var = half_t(0x0p+0f/*0.000000e+00*/);
    uint2 condval_2;
    if (((token < 1024) && (0 <= token))) {
      condval_2 = *(uint2*)(Q + (((((int64_t)token) * (int64_t)2048) + (((int64_t)i) * (int64_t)256)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)63) * (int64_t)4)));
    } else {
      condval_2 = make_uint2(__pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var));
    }
    *(uint2*)(q_stage + (i * 4)) = condval_2;
  }
  int condval_3;
  if ((token < 1024)) {
    condval_3 = bucket;
  } else {
    condval_3 = -1;
  }
  int condval_4;
  if ((token < 1024)) {
    condval_4 = bucket;
  } else {
    condval_4 = -1;
  }
  int condval_5;
  if ((token < 1024)) {
    condval_5 = bucket;
  } else {
    condval_5 = -1;
  }
  bool valid = (((0 <= condval_3) && (condval_4 < 32)) && ((condval_5 * 32) <= token));
  if (valid) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 8; ++i_1) {
      int64_t condval_6;
      if ((((int64_t)token) < (int64_t)1024)) {
        condval_6 = ((int64_t)bucket);
      } else {
        condval_6 = (int64_t)-1;
      }
      int64_t condval_7;
      if ((((int64_t)token) < (int64_t)1024)) {
        condval_7 = ((int64_t)bucket);
      } else {
        condval_7 = (int64_t)-1;
      }
      *(uint4*)(k + (i_1 * 8)) = *(uint4*)(K + (((condval_7 * (int64_t)4096) + (((int64_t)i_1) * (int64_t)512)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)63) * (int64_t)8)));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((int)threadIdx.x) >> 6) * 2048) + (i_2 * 256)) + (((((int)threadIdx.x) & 63) >> 5) * 128)) + ((((((int)threadIdx.x) & 31) >> 1) ^ ((i_2 * 2) + ((((int)threadIdx.x) & 63) >> 5))) * 8)) + ((((int)threadIdx.x) & 1) * 4))) = *(uint2*)(q_stage + (i_2 * 4));
    }
    __syncwarp();
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      *(uint4*)(q + (i_3 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) >> 6) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((i_3 * 4) + ((((int)threadIdx.x) & 63) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      int condval_9;
      if ((token < 1024)) {
        condval_9 = bucket;
      } else {
        condval_9 = -1;
      }
      int condval_10;
      if ((token < 1024)) {
        condval_10 = bucket;
      } else {
        condval_10 = -1;
      }
      float condval_8;
      if (((condval_9 < 32) && (((((condval_10 * 32) + ((i_4 >> 2) * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + (i_4 & 3)) <= token))) {
        condval_8 = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval_8 = -MACART_INF_F;
      }
      scores[i_4] = condval_8;
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
      int64_t condval_11;
      if ((((int64_t)token) < (int64_t)1024)) {
        condval_11 = ((int64_t)bucket);
      } else {
        condval_11 = (int64_t)-1;
      }
      int64_t condval_12;
      if ((((int64_t)token) < (int64_t)1024)) {
        condval_12 = ((int64_t)bucket);
      } else {
        condval_12 = (int64_t)-1;
      }
      *(uint4*)(v + (i_5 * 8)) = *(uint4*)(V + (((condval_12 * (int64_t)4096) + (((int64_t)i_5) * (int64_t)512)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)63) * (int64_t)8)));
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
    float condval_13;
    if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
      condval_13 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
    } else {
      condval_13 = 0x0p+0f/*0.000000e+00*/;
    }
    inv[0] = condval_13;
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
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_9 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
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
    *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) >> 6) * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((i_11 * 2) + ((((int)threadIdx.x) & 63) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(output_reg + (i_11 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    *(uint4*)(output_global + (i_12 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((((int)threadIdx.x) >> 6) * 2048) + (i_12 * 512)) + (((((int)threadIdx.x) & 63) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_12 * 4) + ((((int)threadIdx.x) & 63) >> 4))) * 8)));
  }
  if (token < 1024) {
    #pragma unroll
    for (int i_13 = 0; i_13 < 4; ++i_13) {
      if (0 <= token) {
        *(uint4*)(Output + (((token * 2048) + (i_13 * 512)) + ((((int)threadIdx.x) & 63) * 8))) = *(uint4*)(output_global + (i_13 * 8));
      }
    }
  }
}

