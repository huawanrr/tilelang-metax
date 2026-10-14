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
  int mask[1];
  half_t k[16];
  half_t v[16];
  float out[32];
  half_t q[32];
  float scores[8];
  half_t prob[8];
  float denom[1];
  half_t kb[16];
  half_t vb[32];
  half_t Output_local_cast[4];
  int raw = Indices[((((int)blockIdx.y) * 256) + ((int)threadIdx.x))];
  int condval_1;
  if ((((0 <= raw) && (raw < 32)) && ((raw * 32) <= ((((int)blockIdx.y) * 256) + ((int)threadIdx.x))))) {
    condval_1 = raw;
  } else {
    condval_1 = 32;
  }
  int condval;
  if ((condval_1 == ((int)blockIdx.x))) {
    condval = 1;
  } else {
    condval = 0;
  }
  mask[0] = condval;
  ((int*)buf_dyn_shmem)[((int)threadIdx.x)] = mask[0];
  __syncthreads();
  tl::CumSum1D<256, false>::run((&(((int*)buf_dyn_shmem)[0])), (&(((int*)buf_dyn_shmem)[0])), 256);
  __syncthreads();
  if (mask[0] != 0) {
    ((int*)buf_dyn_shmem)[(((int64_t)((int*)buf_dyn_shmem)[((int64_t)((int)threadIdx.x))]) + (int64_t)255)] = ((((int)blockIdx.y) * 256) + ((int)threadIdx.x));
  }
  __syncthreads();
  int count = ((int*)buf_dyn_shmem)[255];
  if (0 < count) {
    if (((int)blockIdx.x) < 32) {
      #pragma unroll
      for (int i = 0; i < 2; ++i) {
        *(uint4*)(k + (i * 8)) = *(uint4*)(K + (((((int)blockIdx.x) * 4096) + (i * 2048)) + (((int)threadIdx.x) * 8)));
      }
      #pragma unroll
      for (int i_1 = 0; i_1 < 2; ++i_1) {
        *(uint4*)(v + (i_1 * 8)) = *(uint4*)(V + (((((int)blockIdx.x) * 4096) + (i_1 * 2048)) + (((int)threadIdx.x) * 8)));
      }
    }
    for (int group = 0; group < ((count + 3) >> 2); ++group) {
      __syncthreads();
      int condval_2;
      if ((((group * 4) + (((int)threadIdx.x) >> 6)) < count)) {
        condval_2 = ((int*)buf_dyn_shmem)[(((((int64_t)group) * (int64_t)4) + (((int64_t)((int)threadIdx.x)) >> (int64_t)6)) + (int64_t)256)];
      } else {
        condval_2 = 0;
      }
      int token = condval_2;
      #pragma unroll
      for (int i_2 = 0; i_2 < 8; ++i_2) {
        float broadcast_var = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(out + (i_2 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
      }
      if (((int)blockIdx.x) < 32) {
        #pragma unroll
        for (int i_3 = 0; i_3 < 4; ++i_3) {
          half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
          uint4 condval_3;
          if ((((((group * 4) + (((int)threadIdx.x) >> 6)) < count) && (0 <= token)) && (token < 1024))) {
            condval_3 = *(uint4*)(Q + ((((((int64_t)token) * (int64_t)2048) + ((((int64_t)((int)threadIdx.x)) & (int64_t)15) * (int64_t)128)) + (((int64_t)i_3) * (int64_t)32)) + (((((int64_t)((int)threadIdx.x)) & (int64_t)63) >> (int64_t)4) * (int64_t)8)));
          } else {
            condval_3 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
          }
          *(uint4*)(q + (i_3 * 8)) = condval_3;
        }
      }
      __syncthreads();
      if (((int)blockIdx.x) < 32) {
        #pragma unroll
        for (int i_4 = 0; i_4 < 2; ++i_4) {
          *(uint4*)(((half_t*)buf_dyn_shmem) + ((((i_4 * 2048) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((int)threadIdx.x) >> 4)) * 8)) + 1024)) = *(uint4*)(k + (i_4 * 8));
        }
        #pragma unroll
        for (int i_5 = 0; i_5 < 8; ++i_5) {
          float condval_4;
          if (((((group * 4) + (((int)threadIdx.x) >> 6)) < count) && (((((((int)blockIdx.x) * 32) + ((i_5 >> 2) * 16)) + (((((int)threadIdx.x) & 63) >> 4) * 4)) + (i_5 & 3)) <= token))) {
            condval_4 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_4 = -MACART_INF_F;
          }
          scores[i_5] = condval_4;
        }
      }
      __syncthreads();
      if (((int)blockIdx.x) < 32) {
        for (int ki = 0; ki < 4; ++ki) {
          for (int j = 0; j < 2; ++j) {
            *(uint4*)(kb + (j * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + ((((j * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((ki * 4) + ((((int)threadIdx.x) & 63) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)) + 1024));
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
      if (((int)blockIdx.x) < 32) {
        #pragma unroll
        for (int i_6 = 0; i_6 < 2; ++i_6) {
          *(uint4*)(((half_t*)buf_dyn_shmem) + ((((i_6 * 2048) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((int)threadIdx.x) >> 4)) * 8)) + 1024)) = *(uint4*)(v + (i_6 * 8));
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
      if (((int)blockIdx.x) < 32) {
        for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
          for (int j_2 = 0; j_2 < 8; ++j_2) {
            for (int local_id = 0; local_id < 4; ++local_id) {
              vb[((j_2 * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[((((((ki_1 * 2048) + (((((int)threadIdx.x) & 63) >> 4) * 512)) + (local_id * 128)) + ((((j_2 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 63) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7)) + 1024)];
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
      if (((int)blockIdx.x) < 32) {
        denom[0] = 0x0p+0f/*0.000000e+00*/;
        #pragma unroll
        for (int rv = 0; rv < 8; ++rv) {
          denom[0] = (denom[0] + scores[(((rv & 1) * 4) + (rv >> 1))]);
        }
        denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[2560])));
        #pragma unroll
        for (int i_9 = 0; i_9 < 32; ++i_9) {
          float condval_5;
          if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
            condval_5 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
          } else {
            condval_5 = 0x0p+0f/*0.000000e+00*/;
          }
          out[i_9] = (out[i_9] * condval_5);
        }
      }
      if (((group * 4) + (((int)threadIdx.x) >> 6)) < count) {
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
}

