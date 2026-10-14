#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K_blocks, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V_blocks) {
  half_t q[16];
  float out[16];
  half_t k[16];
  half_t v[16];
  float scores[4];
  float lane_sum[1];
  half_t prob[4];
  half_t result[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(q + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  __syncwarp();
  int block = Indices[((int)blockIdx.x)];
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= block) && (block < 8)) && (block <= (((int)blockIdx.x) >> 4))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(k + (i_2 * 8)) = *(uint4*)(K_blocks + ((((block * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_2 * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 16; ++i_3) {
      v[i_3] = V_blocks[(((((block * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + ((i_3 & 3) * 64)) + ((i_3 >> 2) * 16)) + (((int)threadIdx.x) & 15))];
    }
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(scores + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
    for (int ki = 0; ki < 2; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)k) + ((ki * 2) + kp)),
                    *(((float16x4*)q) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 4; ++i_4) {
      float condval;
      if (((((block * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_4) <= ((int)blockIdx.x))) {
        condval = 0x1p+0f/*1.000000e+00*/;
      } else {
        condval = 0x0p+0f/*0.000000e+00*/;
      }
      scores[i_4] = (expf(min((scores[i_4] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/)) * condval);
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j = 0; j < 4; ++j) {
      lane_sum[0] = (lane_sum[0] + scores[j]);
    }
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
    float condval_1;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_1 = lane_sum[0];
    } else {
      condval_1 = 0x1p+0f/*1.000000e+00*/;
    }
    lane_sum[0] = (0x1p+0f/*1.000000e+00*/ / condval_1);
    #pragma unroll
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      scores[i_5] = (scores[i_5] * lane_sum[0]);
    }
    #pragma unroll
    for (int lane = 0; lane < 4; ++lane) {
      prob[lane] = ((half_t)scores[lane]);
    }
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)v) + j_1),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j_1));
    };
    }
  }
  #pragma unroll
  for (int chunk = 0; chunk < 4; ++chunk) {
    #pragma unroll
    for (int lane_1 = 0; lane_1 < 4; ++lane_1) {
      result[((chunk * 4) + lane_1)] = ((half_t)out[((chunk * 4) + lane_1)]);
    }
  }
  #pragma unroll
  for (int i_6 = 0; i_6 < 4; ++i_6) {
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_6 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(result + (i_6 * 4));
  }
}

