#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Idx, const half_t* __restrict__ K, half_t* __restrict__ Out, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Idx, const half_t* __restrict__ K, half_t* __restrict__ Out, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  int match[4];
  half_t k[64];
  half_t v[64];
  float out[32];
  half_t q[32];
  float score[8];
  half_t prob[8];
  float denom[1];
  half_t Out_local_cast[4];
  for (int i_s = 0; i_s < 4; ++i_s) {
    int raw = Idx[((((((int)blockIdx.z) * 1024) + (((int)blockIdx.y) * 256)) + (((int)threadIdx.x) * 4)) + i_s)];
    int condval_1;
    if ((((0 <= raw) && (raw < 32)) && (0 <= (((((int)blockIdx.y) * 64) + ((int)threadIdx.x)) - (raw * 8))))) {
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
    match[i_s] = condval;
  }
  *(int4*)(((int*)buf_dyn_shmem) + (((int)threadIdx.x) * 4)) = *(int4*)(match + 0);
  __syncthreads();
  tl::CumSum1D<64, false>::run((&(((int*)buf_dyn_shmem)[0])), (&(((int*)buf_dyn_shmem)[0])), 256);
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    __syncthreads();
    if (match[i] != 0) {
      ((int*)buf_dyn_shmem)[(((int64_t)((int*)buf_dyn_shmem)[((((int64_t)((int)threadIdx.x)) * (int64_t)4) + ((int64_t)i))]) + (int64_t)255)] = (((((int)blockIdx.y) * 256) + (((int)threadIdx.x) * 4)) + i);
    }
  }
  __syncthreads();
  int count = ((int*)buf_dyn_shmem)[255];
  if (0 < count) {
    if (((int)blockIdx.x) < 32) {
      #pragma unroll
      for (int i_1 = 0; i_1 < 8; ++i_1) {
        *(uint4*)(k + (i_1 * 8)) = *(uint4*)(K + ((((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 4096)) + ((i_1 & 1) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + ((i_1 >> 1) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
      }
      #pragma unroll
      for (int i_2 = 0; i_2 < 64; ++i_2) {
        v[i_2] = V[(((((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 4096)) + ((i_2 >> 5) * 2048)) + ((((int)threadIdx.x) >> 4) * 512)) + ((i_2 & 3) * 128)) + (((i_2 & 31) >> 2) * 16)) + (((int)threadIdx.x) & 15))];
      }
    }
    for (int ti = 0; ti < count; ++ti) {
      __syncthreads();
      int token = ((int*)buf_dyn_shmem)[(ti + 256)];
      #pragma unroll
      for (int i_3 = 0; i_3 < 8; ++i_3) {
        float broadcast_var = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(out + (i_3 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
      }
      if (((int)blockIdx.x) < 32) {
        #pragma unroll
        for (int i_4 = 0; i_4 < 4; ++i_4) {
          half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
          uint4 condval_2;
          if (((0 <= token) && (token < 1024))) {
            condval_2 = *(uint4*)(Q + (((((((int64_t)((int)blockIdx.z)) * (int64_t)2097152) + (((int64_t)token) * (int64_t)2048)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)15) * (int64_t)128)) + (((int64_t)i_4) * (int64_t)32)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)4) * (int64_t)8)));
          } else {
            condval_2 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
          }
          *(uint4*)(q + (i_4 * 8)) = condval_2;
        }
        #pragma unroll
        for (int i_5 = 0; i_5 < 8; ++i_5) {
          float condval_3;
          if ((((((((int)blockIdx.x) * 32) + ((i_5 >> 2) * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + (i_5 & 3)) <= token)) {
            condval_3 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_3 = -MACART_INF_F;
          }
          score[i_5] = condval_3;
        }
        for (int ki = 0; ki < 4; ++ki) {
          for (int kp = 0; kp < 2; ++kp) {
            for (int j = 0; j < 2; ++j) {
              {
      *(((float32x4*)score) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k) + (((ki * 4) + (j * 2)) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)score) + j));
    };
            }
          }
        }
        #pragma unroll
        for (int i_6 = 0; i_6 < 8; ++i_6) {
          score[i_6] = exp2f(min((score[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
        }
        #pragma unroll
        for (int i_7 = 0; i_7 < 2; ++i_7) {
          uint2 __1;
          float4 v_ = *(float4*)(score + (i_7 * 4));
          ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
          ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
          *(uint2*)(prob + (i_7 * 4)) = __1;
        }
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
      __syncthreads();
      if (((int)blockIdx.x) < 32) {
        denom[0] = 0x0p+0f/*0.000000e+00*/;
        #pragma unroll
        for (int rv = 0; rv < 8; ++rv) {
          denom[0] = (denom[0] + score[(((rv & 1) * 4) + (rv >> 1))]);
        }
        denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[512])));
        #pragma unroll
        for (int i_8 = 0; i_8 < 32; ++i_8) {
          float condval_4;
          if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
            condval_4 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
          } else {
            condval_4 = 0x0p+0f/*0.000000e+00*/;
          }
          out[i_8] = (out[i_8] * condval_4);
        }
      }
      #pragma unroll
      for (int i_9 = 0; i_9 < 8; ++i_9) {
        uint2 __2;
        float4 v__1 = *(float4*)(out + (i_9 * 4));
        ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
        ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
        *(uint2*)(Out_local_cast + 0) = __2;
        if (0 <= token) {
          if (token < 1024) {
            *(uint2*)(Out + (((((((int)blockIdx.z) * 2097152) + (token * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Out_local_cast + 0);
          }
        }
      }
    }
  }
}

