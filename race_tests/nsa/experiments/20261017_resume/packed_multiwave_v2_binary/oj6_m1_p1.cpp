#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, half_t* __restrict__ Output, const half_t* __restrict__ PackedKV, const half_t* __restrict__ Q);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, half_t* __restrict__ Output, const half_t* __restrict__ PackedKV, const half_t* __restrict__ Q) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  half_t q_stage[32];
  half_t k[64];
  half_t q[32];
  float scores[8];
  half_t v[64];
  float denom[1];
  float inv[1];
  half_t prob[8];
  float out[32];
  half_t output_reg[32];
  half_t output_write[32];
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    *(uint2*)(q_stage + (i * 4)) = *(uint2*)(Q + ((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + (i * 256)) + (((int)threadIdx.x) * 4)));
  }
  int block = Indices[((((int)blockIdx.y) * 1024) + ((int)blockIdx.x))];
  bool valid = (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x)));
  if (valid) {
    #pragma unroll
    for (int ct = 0; ct < 8; ++ct) {
      *(uint4*)(k + (ct * 8)) = *(uint4*)(PackedKV + ((((((int64_t)((int)blockIdx.y)) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + (((int64_t)ct) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
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
    for (int ct_1 = 0; ct_1 < 8; ++ct_1) {
      *(uint4*)(v + (ct_1 * 8)) = *(uint4*)(PackedKV + (((((((int64_t)((int)blockIdx.y)) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + (((int64_t)ct_1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + (int64_t)4096));
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
    denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[1024])));
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
    for (int cc = 0; cc < 2; ++cc) {
      #pragma unroll
      for (int cl = 0; cl < 4; ++cl) {
        prob[((cc * 4) + cl)] = ((half_t)scores[((cc * 4) + cl)]);
      }
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      float broadcast_var = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(out + (i_6 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
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
    #pragma unroll
    for (int cc_1 = 0; cc_1 < 8; ++cc_1) {
      #pragma unroll
      for (int cl_1 = 0; cl_1 < 4; ++cl_1) {
        output_reg[((cc_1 * 4) + cl_1)] = ((half_t)out[((cc_1 * 4) + cl_1)]);
      }
    }
  } else {
    #pragma unroll
    for (int i_7 = 0; i_7 < 8; ++i_7) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      *(uint2*)(output_reg + (i_7 * 4)) = make_uint2(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
  }
  __syncwarp();
  #pragma unroll
  for (int i_8 = 0; i_8 < 8; ++i_8) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_8 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(output_reg + (i_8 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    *(uint4*)(output_write + (i_9 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_9 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_9 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
  }
  #pragma unroll
  for (int i_10 = 0; i_10 < 4; ++i_10) {
    *(uint4*)(Output + ((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + (i_10 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(output_write + (i_10 * 8));
  }
}

