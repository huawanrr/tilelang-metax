#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(half_t* __restrict__ Output, const half_t* __restrict__ PackedKV, const half_t* __restrict__ Q, const int64_t* __restrict__ Schedule);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(half_t* __restrict__ Output, const half_t* __restrict__ PackedKV, const half_t* __restrict__ Q, const int64_t* __restrict__ Schedule) {
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
  float out[32];
  int64_t record = Schedule[((((int)blockIdx.y) * 80) + ((int)blockIdx.x))];
  if (1 <= ((int)(record & (int64_t)65535))) {
    #pragma unroll
    for (int pair_query = 0; pair_query < 2; ++pair_query) {
      int condval;
      if ((pair_query == 0)) {
        condval = min((((int)(record & (int64_t)65535)) - 1), 1023);
      } else {
        condval = min((((int)((record >> (int64_t)16) & (int64_t)65535)) - 1), 1023);
      }
      if (0 <= condval) {
        #pragma unroll
        for (int i = 0; i < 8; ++i) {
          half_t broadcast_var = half_t(0x0p+0f/*0.000000e+00*/);
          int condval_2;
          if ((pair_query == 0)) {
            condval_2 = min((((int)(record & (int64_t)65535)) - 1), 1023);
          } else {
            condval_2 = min((((int)((record >> (int64_t)16) & (int64_t)65535)) - 1), 1023);
          }
          uint2 condval_1;
          if ((condval_2 < 1024)) {
            int64_t condval_3;
            if ((((int64_t)pair_query) == (int64_t)0)) {
              condval_3 = min(((record & (int64_t)65535) - (int64_t)1), (int64_t)1023);
            } else {
              condval_3 = min((((record >> (int64_t)16) & (int64_t)65535) - (int64_t)1), (int64_t)1023);
            }
            int64_t condval_4;
            if ((((int64_t)pair_query) == (int64_t)0)) {
              condval_4 = min(((record & (int64_t)65535) - (int64_t)1), (int64_t)1023);
            } else {
              condval_4 = min((((record >> (int64_t)16) & (int64_t)65535) - (int64_t)1), (int64_t)1023);
            }
            condval_1 = *(uint2*)(Q + (((((((int64_t)((int)blockIdx.y)) >> (int64_t)3) * (int64_t)2097152) + (condval_4 * (int64_t)2048)) + (((int64_t)i) * (int64_t)256)) + (((int64_t)((int)threadIdx.x)) * (int64_t)4)));
          } else {
            condval_1 = make_uint2(__pack_half2(broadcast_var, broadcast_var), __pack_half2(broadcast_var, broadcast_var));
          }
          *(uint2*)(q_stage + (i * 4)) = condval_1;
        }
        int condval_5;
        if ((pair_query == 0)) {
          condval_5 = min((((int)(record & (int64_t)65535)) - 1), 1023);
        } else {
          condval_5 = min((((int)((record >> (int64_t)16) & (int64_t)65535)) - 1), 1023);
        }
        bool valid = (((0 <= ((int)(record >> (int64_t)32))) && (((int)(record >> (int64_t)32)) < 32)) && ((((int)(record >> (int64_t)32)) * 32) <= condval_5));
        if (valid) {
          if (pair_query == 0) {
            #pragma unroll
            for (int i_1 = 0; i_1 < 8; ++i_1) {
              *(uint4*)(k + (i_1 * 8)) = *(uint4*)(PackedKV + (((((((int64_t)((int)blockIdx.y)) >> (int64_t)3) * (int64_t)262144) + ((record >> (int64_t)32) * (int64_t)8192)) + (((int64_t)i_1) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
            }
          }
          #pragma unroll
          for (int i_2 = 0; i_2 < 8; ++i_2) {
            *(uint2*)(((half_t*)buf_dyn_shmem) + ((((i_2 * 256) + ((((int)threadIdx.x) >> 5) * 128)) + ((((((int)threadIdx.x) & 31) >> 1) ^ ((i_2 * 2) + (((int)threadIdx.x) >> 5))) * 8)) + ((((int)threadIdx.x) & 1) * 4))) = *(uint2*)(q_stage + (i_2 * 4));
          }
          __syncwarp();
          #pragma unroll
          for (int i_3 = 0; i_3 < 4; ++i_3) {
            *(uint4*)(q + (i_3 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 128) + ((((i_3 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
          }
          #pragma unroll
          for (int i_4 = 0; i_4 < 8; ++i_4) {
            int condval_7;
            if ((pair_query == 0)) {
              condval_7 = min((((int)(record & (int64_t)65535)) - 1), 1023);
            } else {
              condval_7 = min((((int)((record >> (int64_t)16) & (int64_t)65535)) - 1), 1023);
            }
            float condval_6;
            if (((((int)(record >> (int64_t)32)) < 32) && (((((((int)(record >> (int64_t)32)) * 32) + ((i_4 >> 2) * 16)) + ((((int)threadIdx.x) >> 4) * 4)) + (i_4 & 3)) <= condval_7))) {
              condval_6 = 0x0p+0f/*0.000000e+00*/;
            } else {
              condval_6 = -MACART_INF_F;
            }
            scores[i_4] = condval_6;
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
          if (pair_query == 0) {
            #pragma unroll
            for (int i_5 = 0; i_5 < 8; ++i_5) {
              *(uint4*)(v + (i_5 * 8)) = *(uint4*)(PackedKV + ((((((((int64_t)((int)blockIdx.y)) >> (int64_t)3) * (int64_t)262144) + ((record >> (int64_t)32) * (int64_t)8192)) + (((int64_t)i_5) * (int64_t)512)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)) + (int64_t)4096));
            }
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
          denom[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(denom[0], (&(((float*)buf_dyn_shmem)[1024])));
          float condval_8;
          if ((0x0p+0f/*0.000000e+00*/ < denom[0])) {
            condval_8 = (0x1p+0f/*1.000000e+00*/ / denom[0]);
          } else {
            condval_8 = 0x0p+0f/*0.000000e+00*/;
          }
          inv[0] = condval_8;
          #pragma unroll
          for (int i_7 = 0; i_7 < 8; ++i_7) {
            scores[i_7] = (scores[i_7] * inv[0]);
          }
          #pragma unroll
          for (int cast_chunk = 0; cast_chunk < 2; ++cast_chunk) {
            #pragma unroll
            for (int cast_lane = 0; cast_lane < 4; ++cast_lane) {
              prob[((cast_chunk * 4) + cast_lane)] = ((half_t)scores[((cast_chunk * 4) + cast_lane)]);
            }
          }
          #pragma unroll
          for (int i_8 = 0; i_8 < 8; ++i_8) {
            float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
            *(float4*)(out + (i_8 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
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
          for (int i_9 = 0; i_9 < 8; ++i_9) {
            half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
            *(uint2*)(output_reg + (i_9 * 4)) = make_uint2(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
          }
        }
        __syncwarp();
        #pragma unroll
        for (int i_10 = 0; i_10 < 8; ++i_10) {
          *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 128) + ((((i_10 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 15)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(output_reg + (i_10 * 4));
        }
        __syncwarp();
        #pragma unroll
        for (int i_11 = 0; i_11 < 4; ++i_11) {
          int condval_9;
          if ((pair_query == 0)) {
            condval_9 = min((((int)(record & (int64_t)65535)) - 1), 1023);
          } else {
            condval_9 = min((((int)((record >> (int64_t)16) & (int64_t)65535)) - 1), 1023);
          }
          if (condval_9 < 1024) {
            int condval_10;
            if ((pair_query == 0)) {
              condval_10 = min((((int)(record & (int64_t)65535)) - 1), 1023);
            } else {
              condval_10 = min((((int)((record >> (int64_t)16) & (int64_t)65535)) - 1), 1023);
            }
            int condval_11;
            if ((pair_query == 0)) {
              condval_11 = min((((int)(record & (int64_t)65535)) - 1), 1023);
            } else {
              condval_11 = min((((int)((record >> (int64_t)16) & (int64_t)65535)) - 1), 1023);
            }
            *(uint4*)(Output + (((((((int)blockIdx.y) >> 3) * 2097152) + (condval_11 * 2048)) + (i_11 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_11 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ ((i_11 * 4) + (((int)threadIdx.x) >> 4))) * 8)));
          }
        }
        __syncwarp();
      }
    }
  }
}

