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
  int indices[4];
  half_t q[16];
  float out[16];
  float sums[8];
  half_t k[32];
  float scores[8];
  half_t v_stage[32];
  half_t v[32];
  half_t prob[8];
  float denom[1];
  float inv[1];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int s = 0; s < 4; ++s) {
    indices[s] = Indices[((((int)blockIdx.x) * 4) + s)];
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 2; ++i_2) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(sums + (i_2 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  for (int group = 0; group < 2; ++group) {
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      int raw = indices[((group * 2) + (i_3 & 1))];
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if (((((0 <= raw) && (raw < 16)) && (raw < 16)) && (raw <= (((int)blockIdx.x) >> 4)))) {
        condval = *(uint4*)(K + ((((((int64_t)raw) * (int64_t)1024) + ((((int64_t)((int)threadIdx.x)) & (int64_t)15) * (int64_t)64)) + ((((int64_t)i_3) >> (int64_t)1) * (int64_t)32)) + ((((int64_t)((int)threadIdx.x)) >> (int64_t)4) * (int64_t)8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(k + (i_3 * 8)) = condval;
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      int raw_1 = indices[((group * 2) + (i_4 >> 2))];
      float condval_1;
      if (((((0 <= raw_1) && (raw_1 < 16)) && (raw_1 < 16)) && ((((raw_1 * 16) + ((((int)threadIdx.x) >> 4) * 4)) + (i_4 & 3)) <= ((int)blockIdx.x)))) {
        condval_1 = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval_1 = -MACART_INF_F;
      }
      scores[i_4] = condval_1;
    }
    for (int ki = 0; ki < 2; ++ki) {
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
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      int raw_2 = indices[((group * 2) + (i_5 >> 1))];
      half_t broadcast_var_3 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_2;
      if (((((0 <= raw_2) && (raw_2 < 16)) && (raw_2 < 16)) && (raw_2 <= (((int)blockIdx.x) >> 4)))) {
        condval_2 = *(uint4*)(V + (((((int64_t)raw_2) * (int64_t)1024) + ((((int64_t)i_5) & (int64_t)1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
      } else {
        condval_2 = make_uint4(__pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3));
      }
      *(uint4*)(v_stage + (i_5 * 8)) = condval_2;
    }
    __syncwarp();
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + ((((i_6 >> 1) * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((((int)threadIdx.x) & 7) * 2) + (i_6 & 1)) ^ ((((i_6 & 3) >> 1) * 8) + (((int)threadIdx.x) >> 3))) * 4))) = *(uint2*)(v_stage + (i_6 * 4));
    }
    __syncwarp();
    #pragma unroll
    for (int i_7 = 0; i_7 < 32; ++i_7) {
      v[i_7] = ((half_t*)buf_dyn_shmem)[((((((i_7 >> 4) * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + ((i_7 & 3) * 64)) + ((((((i_7 & 15) >> 2) * 4) + ((((int)threadIdx.x) & 15) >> 2)) ^ (((((int)threadIdx.x) >> 4) * 4) + (i_7 & 3))) * 4)) + (((int)threadIdx.x) & 3))];
    }
    #pragma unroll
    for (int i_8 = 0; i_8 < 8; ++i_8) {
      scores[i_8] = exp2f(min((scores[i_8] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_9 = 0; i_9 < 8; ++i_9) {
      sums[i_9] = (sums[i_9] + scores[i_9]);
    }
    #pragma unroll
    for (int i_10 = 0; i_10 < 2; ++i_10) {
      uint2 __1;
      float4 v_ = *(float4*)(scores + (i_10 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(prob + (i_10 * 4)) = __1;
    }
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + ((ki_1 * 4) + j_1)),
                    *(((float16x4*)prob) + ki_1),
                    *(((float32x4*)out) + j_1));
    };
      }
    }
  }
  denom[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 8; ++rv) {
    denom[0] = (denom[0] + sums[(((rv & 1) * 4) + (rv >> 1))]);
  }
  denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[0])));
  float condval_3;
  if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
    condval_3 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
  } else {
    condval_3 = 0x0p+0f/*0.000000e+00*/;
  }
  inv[0] = condval_3;
  #pragma unroll
  for (int i_11 = 0; i_11 < 16; ++i_11) {
    out[i_11] = (out[i_11] * inv[0]);
  }
  #pragma unroll
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_12 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_12 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

