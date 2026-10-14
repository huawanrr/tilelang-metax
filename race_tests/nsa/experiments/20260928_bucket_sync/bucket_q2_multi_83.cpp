#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, int* __restrict__ Schedule, int* __restrict__ Sorted);
extern "C" __global__ void __launch_bounds__(256, 1) kernel_kernel(const int* __restrict__ Indices, int* __restrict__ Schedule, int* __restrict__ Sorted) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  if (((int)threadIdx.x) < 64) {
    ((int*)buf_dyn_shmem)[((int)threadIdx.x)] = 0;
  }
  for (int step = 0; step < 3; ++step) {
    if (((step * 256) + ((int)threadIdx.x)) < 545) {
      Schedule[((step * 768) + (((int)threadIdx.x) * 3))] = -1;
      Schedule[(((step * 768) + (((int)threadIdx.x) * 3)) + 1)] = -1;
      Schedule[(((step * 768) + (((int)threadIdx.x) * 3)) + 2)] = -1;
    }
  }
  __syncthreads();
  for (int step_1 = 0; step_1 < 4; ++step_1) {
    int raw = Indices[((step_1 * 256) + ((int)threadIdx.x))];
    int condval;
    if ((((0 <= raw) && (raw < 32)) && ((raw * 32) <= ((step_1 * 256) + ((int)threadIdx.x))))) {
      condval = raw;
    } else {
      condval = 32;
    }
    int slot = AtomicAddRet((&(((int*)buf_dyn_shmem)[min(max(condval, 0), 32)])), 1);
    if (0 <= slot) {
      if (slot < 1024) {
        int condval_1;
        if ((((0 <= raw) && (raw < 32)) && ((raw * 32) <= ((step_1 * 256) + ((int)threadIdx.x))))) {
          condval_1 = raw;
        } else {
          condval_1 = 32;
        }
        Sorted[((min(max(condval_1, 0), 32) * 1024) + slot)] = ((step_1 * 256) + ((int)threadIdx.x));
      }
    }
  }
  __syncthreads();
  if (((int)threadIdx.x) < 64) {
    ((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 64)] = ((((int*)buf_dyn_shmem)[((int)threadIdx.x)] + 1) >> 1);
  }
  __syncthreads();
  tl::CumSum1D<256, false>::run((&(((int*)buf_dyn_shmem)[64])), (&(((int*)buf_dyn_shmem)[64])), 64);
  __syncthreads();
  if (((int)threadIdx.x) < 33) {
    int count = ((int*)buf_dyn_shmem)[((int)threadIdx.x)];
    for (int group = 0; group < ((count + 1) >> 1); ++group) {
      int dst = ((((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 64)] + group) - ((count + 1) >> 1));
      if (0 <= dst) {
        if (dst < 545) {
          Schedule[(dst * 3)] = ((int)threadIdx.x);
          Schedule[((dst * 3) + 1)] = (group * 2);
          Schedule[((dst * 3) + 2)] = min(2, (count - (group * 2)));
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
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const int* __restrict__ Schedule, const int* __restrict__ Sorted, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  float out[32];
  half_t q[32];
  half_t k[32];
  half_t v[32];
  float scores[8];
  half_t prob[8];
  float denom[1];
  half_t kb[16];
  half_t vb[32];
  half_t Output_local_cast[4];
  int bucket = Schedule[(((int)blockIdx.x) * 3)];
  int start = Schedule[((((int)blockIdx.x) * 3) + 1)];
  int count = Schedule[((((int)blockIdx.x) * 3) + 2)];
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (0 <= bucket) {
    int condval;
    if ((((((((int)threadIdx.x) >> 6) < count) && (0 <= ((((int)threadIdx.x) >> 6) + start))) && (((((int)threadIdx.x) >> 6) + start) < 1024)) && (bucket < 33))) {
      condval = Sorted[(((((int64_t)bucket) * (int64_t)1024) + (((int64_t)((int)threadIdx.x)) >> (int64_t)6)) + ((int64_t)start))];
    } else {
      condval = 0;
    }
    int token = condval;
    if (bucket < 32) {
      #pragma unroll
      for (int i_1 = 0; i_1 < 4; ++i_1) {
        half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
        uint4 condval_1;
        if (((((((int)threadIdx.x) >> 6) < count) && (0 <= token)) && (token < 1024))) {
          condval_1 = *(uint4*)(Q + ((((((int64_t)token) * (int64_t)2048) + ((((int64_t)((int)threadIdx.x)) & (int64_t)15) * (int64_t)128)) + (((int64_t)i_1) * (int64_t)32)) + (((((int64_t)((int)threadIdx.x)) & (int64_t)63) >> (int64_t)4) * (int64_t)8)));
        } else {
          condval_1 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
        }
        *(uint4*)(q + (i_1 * 8)) = condval_1;
      }
      #pragma unroll
      for (int i_2 = 0; i_2 < 4; ++i_2) {
        *(uint4*)(k + (i_2 * 8)) = *(uint4*)(K + (((bucket * 4096) + (i_2 * 1024)) + (((int)threadIdx.x) * 8)));
      }
      #pragma unroll
      for (int i_3 = 0; i_3 < 4; ++i_3) {
        *(uint4*)(v + (i_3 * 8)) = *(uint4*)(V + (((bucket * 4096) + (i_3 * 1024)) + (((int)threadIdx.x) * 8)));
      }
      #pragma unroll
      for (int i_4 = 0; i_4 < 4; ++i_4) {
        *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_4 * 1024) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_4 & 1) * 8) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(k + (i_4 * 8));
      }
      #pragma unroll
      for (int i_5 = 0; i_5 < 8; ++i_5) {
        float condval_2;
        if ((((((int)threadIdx.x) >> 6) < count) && (((((bucket * 32) + ((i_5 >> 2) * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + (i_5 & 3)) <= token))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        scores[i_5] = condval_2;
      }
    }
    __syncthreads();
    if (bucket < 32) {
      for (int ki = 0; ki < 4; ++ki) {
        for (int j = 0; j < 2; ++j) {
          *(uint4*)(kb + (j * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((j * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((ki * 4) + ((((int)threadIdx.x) & 63) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
        }
        for (int kp = 0; kp < 2; ++kp) {
          for (int j_1 = 0; j_1 < 2; ++j_1) {
            {
      *(((float32x4*)scores) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_1 * 2) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + j_1));
    };
          }
        }
      }
    }
    __syncthreads();
    if (bucket < 32) {
      #pragma unroll
      for (int i_6 = 0; i_6 < 4; ++i_6) {
        *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_6 * 1024) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_6 & 1) * 8) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(v + (i_6 * 8));
      }
      #pragma unroll
      for (int i_7 = 0; i_7 < 8; ++i_7) {
        scores[i_7] = exp2f(min((scores[i_7] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
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
    __syncthreads();
    if (bucket < 32) {
      for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
        for (int j_2 = 0; j_2 < 8; ++j_2) {
          for (int local_id = 0; local_id < 4; ++local_id) {
            vb[((j_2 * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((ki_1 * 2048) + (((((int)threadIdx.x) & 63) >> 4) * 512)) + (local_id * 128)) + ((((j_2 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 63) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
          }
        }
        for (int j_3 = 0; j_3 < 8; ++j_3) {
          {
      *(((float32x4*)out) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_3),
                    *(((float16x4*)prob) + ki_1),
                    *(((float32x4*)out) + j_3));
    };
        }
      }
    }
    __syncthreads();
    if (bucket < 32) {
      denom[0] = 0x0p+0f/*0.000000e+00*/;
      #pragma unroll
      for (int rv = 0; rv < 8; ++rv) {
        denom[0] = (denom[0] + scores[(((rv & 1) * 4) + (rv >> 1))]);
      }
      denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[2048])));
      #pragma unroll
      for (int i_9 = 0; i_9 < 32; ++i_9) {
        float condval_3;
        if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
          condval_3 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
        } else {
          condval_3 = 0x0p+0f/*0.000000e+00*/;
        }
        out[i_9] = (out[i_9] * condval_3);
      }
    }
    if ((((int)threadIdx.x) >> 6) < count) {
      #pragma unroll
      for (int i_10 = 0; i_10 < 8; ++i_10) {
        uint2 __2;
        float4 v__1 = *(float4*)(out + (i_10 * 4));
        ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
        ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
        *(uint2*)(Output_local_cast + 0) = __2;
        if (0 <= token) {
          if (token < 1024) {
            *(uint2*)(Output + ((((token * 2048) + ((((int)threadIdx.x) & 15) * 128)) + (i_10 * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
          }
        }
      }
    }
  }
}

