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
  uint q_words[16];
  half_t k[64];
  half_t q_halves[32];
  half_t q[32];
  float scores[8];
  half_t v[32];
  float denom[1];
  float inv[1];
  half_t prob[8];
  float out[16];
  half_t output_reg[16];
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
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      *(uint4*)(v + (i_2 * 8)) = *(uint4*)(PackedKV + ((((((((int64_t)((int)blockIdx.y)) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + ((((int64_t)i_2) >> (int64_t)1) * (int64_t)2048)) + ((((int64_t)i_2) & (int64_t)1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + (int64_t)4096));
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
    denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[0])));
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
  }
  #pragma unroll
  for (int vo = 0; vo < 2; ++vo) {
    #pragma unroll
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      float broadcast_var = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(out + (i_5 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
    }
    if (valid) {
      if (0 < vo) {
        #pragma unroll
        for (int i_6 = 0; i_6 < 4; ++i_6) {
          *(uint4*)(v + (i_6 * 8)) = *(uint4*)(PackedKV + (((((((((int64_t)((int)blockIdx.y)) * (int64_t)262144) + (((int64_t)block) * (int64_t)8192)) + ((((int64_t)i_6) >> (int64_t)1) * (int64_t)2048)) + (((int64_t)vo) * (int64_t)1024)) + ((((int64_t)i_6) & (int64_t)1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + (int64_t)4096));
        }
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
    #pragma unroll
    for (int cast_chunk_1 = 0; cast_chunk_1 < 4; ++cast_chunk_1) {
      #pragma unroll
      for (int cast_lane_1 = 0; cast_lane_1 < 4; ++cast_lane_1) {
        output_reg[((cast_chunk_1 * 4) + cast_lane_1)] = ((half_t)out[((cast_chunk_1 * 4) + cast_lane_1)]);
      }
    }
    __syncwarp();
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_7 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(output_reg + (i_7 * 4));
    }
    __syncwarp();
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      *(uint4*)(Output + ((((((((int)blockIdx.y) * 2097152) + (((int)blockIdx.x) * 2048)) + (i_8 * 1024)) + ((((int)threadIdx.x) >> 3) * 128)) + (vo * 64)) + ((((int)threadIdx.x) & 7) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_8 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
    }
  }
}

