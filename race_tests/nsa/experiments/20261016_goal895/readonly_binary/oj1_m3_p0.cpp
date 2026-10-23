#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks) {
  float tiny_sum_one[1];
  half_t q[8];
  float out[8];
  half_t v[8];
  half_t k[8];
  float scores[4];
  half_t prob[4];
  float lane_sum[1];
  float tiny_sum_out[4];
  half_t result[8];
  tiny_sum_one[0] = 0x1p+0f/*1.000000e+00*/;
  *(uint4*)(q + 0) = *(uint4*)(Q + (((((int)blockIdx.x) * 512) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  __syncwarp();
  int block = __ldg(&(Indices[((int)blockIdx.x)]));
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= block) && (block < 4)) && (block <= (((int)blockIdx.x) >> 4))) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 8; ++i_1) {
      v[i_1] = __ldg(&(V_blocks[(((((block * 512) + ((((int)threadIdx.x) >> 4) * 128)) + ((i_1 & 3) * 32)) + ((i_1 >> 2) * 16)) + (((int)threadIdx.x) & 15))]));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      k[i_2] = __ldg(&(K_blocks[((((block * 512) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)) + i_2)]));
    }
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(scores + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
    for (int kp = 0; kp < 2; ++kp) {
      {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k) + kp),
                    *(((float16x4*)q) + kp),
                    *(((float32x4*)scores) + 0));
    };
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      float condval;
      if (((((block * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_3) <= ((int)blockIdx.x))) {
        condval = 0x1p+0f/*1.000000e+00*/;
      } else {
        condval = 0x0p+0f/*0.000000e+00*/;
      }
      scores[i_3] = (expf(min((scores[i_3] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/)) * condval);
    }
    #pragma unroll
    for (int lane = 0; lane < 4; ++lane) {
      prob[lane] = ((half_t)scores[lane]);
    }
    for (int j = 0; j < 2; ++j) {
      {
      *(((float32x4*)out) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + j),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j));
    };
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      lane_sum[0] = (lane_sum[0] + scores[j_1]);
    }
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(tiny_sum_out + 0) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
    {
      *(((float32x4*)tiny_sum_out) + 0) = __builtin_mxc_mma_16x16x4f32(*(((float*)tiny_sum_one) + 0),
                    *(((float*)lane_sum) + 0),
                    *(((float32x4*)tiny_sum_out) + 0));
    };
    float condval_1;
    if ((0x0p+0f/*0.000000e+00*/ < tiny_sum_out[0])) {
      condval_1 = expf((logf(tiny_sum_out[0]) * -0x1p+0f/*-1.000000e+00*/));
    } else {
      condval_1 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_1;
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      out[i_4] = (out[i_4] * lane_sum[0]);
    }
  }
  #pragma unroll
  for (int chunk = 0; chunk < 2; ++chunk) {
    #pragma unroll
    for (int lane_1 = 0; lane_1 < 4; ++lane_1) {
      result[((chunk * 4) + lane_1)] = ((half_t)out[((chunk * 4) + lane_1)]);
    }
  }
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    *(uint2*)(Output + ((((((int)blockIdx.x) * 512) + ((((int)threadIdx.x) & 15) * 32)) + (i_5 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(result + (i_5 * 4));
  }
}

