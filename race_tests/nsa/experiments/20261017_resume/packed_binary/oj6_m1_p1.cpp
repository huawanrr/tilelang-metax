#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, half_t* __restrict__ Output, const half_t* __restrict__ PackedKV, const half_t* __restrict__ Q);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, half_t* __restrict__ Output, const half_t* __restrict__ PackedKV, const half_t* __restrict__ Q) {
  uint q_words[16];
  half_t k[64];
  half_t q_halves[32];
  half_t q[32];
  float scores[8];
  half_t v[64];
  float denom[1];
  float inv[1];
  half_t prob[8];
  half_t output_reg[32];
  uint output_words[16];
  uint output_exchange0[16];
  half_t output_halves[32];
  extern __shared__ __align__(1024) float workspace[];
  float out[32];
  #pragma unroll
  for (int slab = 0; slab < 2; ++slab) {
    #pragma unroll
    for (int half_row = 0; half_row < 2; ++half_row) {
      *(uint4*)(((half_t*)q_words) + ((slab * 16) + (half_row * 8))) = *(uint4*)(Q + (((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + (half_row * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + (slab * 64)) + (((((int)threadIdx.x) & 15) >> 3) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
    }
  }
  int block = Indices[((((int)blockIdx.y) * 1024) + ((int)blockIdx.x))];
  bool valid = (((0 <= block) && (block < 32)) && ((block * 32) <= ((int)blockIdx.x)));
  if (valid) {
    #pragma unroll
    for (int i = 0; i < 8; ++i) {
      *(uint4*)(k + (i * 8)) = *(uint4*)(PackedKV + ((((((int64_t)((int)blockIdx.y)) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + (((int64_t)i) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    }
    #pragma unroll
    for (int slab_1 = 0; slab_1 < 2; ++slab_1) {
      #pragma unroll
      for (int word = 0; word < 4; ++word) {
        uint q_lo = q_words[((slab_1 * 8) + word)];
        uint q_hi = q_words[(((slab_1 * 8) + word) + 4)];
        uint condval;
        if (((((int)threadIdx.x) & 15) < 8)) {
          condval = q_hi;
        } else {
          condval = q_lo;
        }
        uint q_rx = __shfl_xor_sync((uint64_t)18446744073709551615, condval, 8, 64);
        uint condval_1;
        if (((((int)threadIdx.x) & 15) < 8)) {
          condval_1 = q_lo;
        } else {
          condval_1 = q_rx;
        }
        ((uint*)q_halves)[((slab_1 * 8) + word)] = condval_1;
        uint condval_2;
        if (((((int)threadIdx.x) & 15) < 8)) {
          condval_2 = q_rx;
        } else {
          condval_2 = q_hi;
        }
        ((uint*)q_halves)[(((slab_1 * 8) + word) + 4)] = condval_2;
      }
    }
    #pragma unroll
    for (int slab_2 = 0; slab_2 < 4; ++slab_2) {
      #pragma unroll
      for (int element = 0; element < 8; ++element) {
        q[((slab_2 * 8) + element)] = q_halves[((slab_2 * 8) + element)];
      }
    }
    #pragma unroll
    for (int i_1 = 0; i_1 < 8; ++i_1) {
      float condval_3;
      if (((block < 32) && (((((block * 32) + ((i_1 >> 2) * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + (i_1 & 3)) <= ((int)blockIdx.x)))) {
        condval_3 = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval_3 = -MACART_INF_F;
      }
      scores[i_1] = condval_3;
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
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      *(uint4*)(v + (i_2 * 8)) = *(uint4*)(PackedKV + (((((((int64_t)((int)blockIdx.y)) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + (((int64_t)i_2) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + (int64_t)4096));
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 8; ++i_3) {
      scores[i_3] = exp2f(min((scores[i_3] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    denom[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int rv = 0; rv < 8; ++rv) {
      denom[0] = (denom[0] + scores[(((rv & 1) * 4) + (rv >> 1))]);
    }
    denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(workspace[0])));
    float condval_4;
    if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
      condval_4 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
    } else {
      condval_4 = 0x0p+0f/*0.000000e+00*/;
    }
    inv[0] = condval_4;
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      scores[i_4] = (scores[i_4] * inv[0]);
    }
    #pragma unroll
    for (int cast_chunk = 0; cast_chunk < 2; ++cast_chunk) {
      #pragma unroll
      for (int cast_lane = 0; cast_lane < 4; ++cast_lane) {
        prob[((cast_chunk * 4) + cast_lane)] = ((half_t)scores[((cast_chunk * 4) + cast_lane)]);
      }
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 8; ++i_5) {
      float broadcast_var = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(out + (i_5 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
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
    for (int cast_chunk_1 = 0; cast_chunk_1 < 8; ++cast_chunk_1) {
      #pragma unroll
      for (int cast_lane_1 = 0; cast_lane_1 < 4; ++cast_lane_1) {
        output_reg[((cast_chunk_1 * 4) + cast_lane_1)] = ((half_t)out[((cast_chunk_1 * 4) + cast_lane_1)]);
      }
    }
  } else {
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      *(uint2*)(output_reg + (i_6 * 4)) = make_uint2(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
  }
  #pragma unroll
  for (int chunk = 0; chunk < 8; ++chunk) {
    #pragma unroll
    for (int element_1 = 0; element_1 < 4; ++element_1) {
      ((half_t*)output_words)[((chunk * 4) + element_1)] = output_reg[((chunk * 4) + element_1)];
    }
  }
  #pragma unroll
  for (int group = 0; group < 4; ++group) {
    #pragma unroll
    for (int word_1 = 0; word_1 < 2; ++word_1) {
      uint output_lo = output_words[((group * 4) + word_1)];
      uint output_hi = output_words[(((group * 4) + word_1) + 2)];
      uint condval_5;
      if (((((int)threadIdx.x) & 15) < 8)) {
        condval_5 = output_hi;
      } else {
        condval_5 = output_lo;
      }
      uint output_rx = __shfl_xor_sync((uint64_t)18446744073709551615, condval_5, 8, 64);
      uint condval_6;
      if (((((int)threadIdx.x) & 15) < 8)) {
        condval_6 = output_lo;
      } else {
        condval_6 = output_rx;
      }
      output_exchange0[((group * 4) + word_1)] = condval_6;
      uint condval_7;
      if (((((int)threadIdx.x) & 15) < 8)) {
        condval_7 = output_rx;
      } else {
        condval_7 = output_hi;
      }
      output_exchange0[(((group * 4) + word_1) + 2)] = condval_7;
    }
  }
  #pragma unroll
  for (int group_1 = 0; group_1 < 2; ++group_1) {
    #pragma unroll
    for (int word_2 = 0; word_2 < 4; ++word_2) {
      uint output_lo_1 = output_exchange0[((group_1 * 8) + word_2)];
      uint output_hi_1 = output_exchange0[(((group_1 * 8) + word_2) + 4)];
      uint condval_8;
      if (((((int)threadIdx.x) & 7) < 4)) {
        condval_8 = output_hi_1;
      } else {
        condval_8 = output_lo_1;
      }
      uint output_rx_1 = __shfl_xor_sync((uint64_t)18446744073709551615, condval_8, 4, 64);
      uint condval_9;
      if (((((int)threadIdx.x) & 7) < 4)) {
        condval_9 = output_lo_1;
      } else {
        condval_9 = output_rx_1;
      }
      ((uint*)output_halves)[((group_1 * 8) + word_2)] = condval_9;
      uint condval_10;
      if (((((int)threadIdx.x) & 7) < 4)) {
        condval_10 = output_rx_1;
      } else {
        condval_10 = output_hi_1;
      }
      ((uint*)output_halves)[(((group_1 * 8) + word_2) + 4)] = condval_10;
    }
  }
  #pragma unroll
  for (int chunk_1 = 0; chunk_1 < 8; ++chunk_1) {
    *(uint2*)(Output + (((((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + ((chunk_1 & 1) * 1024)) + (((chunk_1 & 3) >> 1) * 512)) + ((((int)threadIdx.x) & 3) * 128)) + ((chunk_1 >> 2) * 64)) + (((((int)threadIdx.x) & 7) >> 2) * 32)) + (((((int)threadIdx.x) & 15) >> 3) * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(output_halves + (chunk_1 * 4));
  }
}

