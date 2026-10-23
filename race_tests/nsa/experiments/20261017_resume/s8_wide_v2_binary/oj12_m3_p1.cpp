#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  int indices[8];
  half_t qr[16];
  float sums[4];
  float out[16];
  float out_1[16];
  int starts[8];
  half_t kr[128];
  float scores[32];
  half_t vr[128];
  half_t probs[32];
  float den[1];
  float inv[1];
  half_t O_reg[16];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    int raw_index = BlockIndices[(((((int)blockIdx.x) * 8192) + (((int)blockIdx.z) * 8)) + si)];
    indices[si] = (min(max(raw_index, -1), 64) * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(qr + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  float broadcast_var = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sums + 0) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i_1 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out_1 + (i_2 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  }
  #pragma unroll
  for (int p = 0; p < 8; ++p) {
    starts[p] = indices[p];
  }
  #pragma unroll
  for (int kc = 0; kc < 2; ++kc) {
    #pragma unroll
    for (int p_1 = 0; p_1 < 8; ++p_1) {
      int pos = starts[p_1];
      if (((0 <= pos) && (pos < 1024)) && (pos <= ((int)blockIdx.z))) {
        *(uint4*)(kr + ((kc * 64) + (p_1 * 8))) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((pos >> 4) * 1024)) + (kc * 512)) + (((int)threadIdx.x) * 8)));
      } else {
        half_t broadcast_var_3 = half_t(0x0p+0f/*0.000000e+00*/);
        *(uint4*)(kr + ((kc * 64) + (p_1 * 8))) = make_uint4(__pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3));
      }
    }
  }
  #pragma unroll
  for (int p_2 = 0; p_2 < 8; ++p_2) {
    int pos_1 = starts[p_2];
    if (((0 <= pos_1) && (pos_1 < 1024)) && (pos_1 <= ((int)blockIdx.z))) {
      if (((int)blockIdx.z) < (pos_1 + 15)) {
        #pragma unroll
        for (int i_3 = 0; i_3 < 4; ++i_3) {
          float condval;
          if ((((((((int)threadIdx.x) >> 4) * 4) + pos_1) + i_3) <= ((int)blockIdx.z))) {
            condval = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval = -MACART_INF_F;
          }
          scores[((p_2 * 4) + i_3)] = condval;
        }
      } else {
        #pragma unroll
        for (int i_4 = 0; i_4 < 4; ++i_4) {
          scores[((p_2 * 4) + i_4)] = 0x0p+0f/*0.000000e+00*/;
        }
      }
    } else {
      #pragma unroll
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        scores[((p_2 * 4) + i_5)] = -MACART_INF_F;
      }
    }
  }
  for (int ki = 0; ki < 2; ++ki) {
    for (int kp = 0; kp < 2; ++kp) {
      for (int j = 0; j < 8; ++j) {
        {
      *(((float32x4*)scores) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kr) + (((ki * 16) + (j * 2)) + kp)),
                    *(((float16x4*)qr) + ((ki * 2) + kp)),
                    *(((float32x4*)scores) + j));
    };
      }
    }
  }
  #pragma unroll
  for (int p_3 = 0; p_3 < 8; ++p_3) {
    int pos_2 = starts[p_3];
    if (((0 <= pos_2) && (pos_2 < 1024)) && (pos_2 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int vc = 0; vc < 2; ++vc) {
        *(uint4*)(vr + ((p_3 * 16) + (vc * 8))) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((pos_2 >> 4) * 1024)) + (vc * 512)) + (((int)threadIdx.x) * 8)));
      }
    } else {
      #pragma unroll
      for (int vc_1 = 0; vc_1 < 2; ++vc_1) {
        half_t broadcast_var_4 = half_t(0x0p+0f/*0.000000e+00*/);
        *(uint4*)(vr + ((p_3 * 16) + (vc_1 * 8))) = make_uint4(__pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4));
      }
    }
  }
  #pragma unroll
  for (int p_4 = 0; p_4 < 8; ++p_4) {
    int pos_3 = starts[p_4];
    if (((0 <= pos_3) && (pos_3 < 1024)) && (pos_3 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_6 = 0; i_6 < 4; ++i_6) {
        scores[((p_4 * 4) + i_6)] = expf(min((scores[((p_4 * 4) + i_6)] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
      }
      #pragma unroll
      for (int i_7 = 0; i_7 < 4; ++i_7) {
        sums[i_7] = (sums[i_7] + scores[((p_4 * 4) + i_7)]);
      }
      #pragma unroll
      for (int ce = 0; ce < 4; ++ce) {
        probs[((p_4 * 4) + ce)] = ((half_t)scores[((p_4 * 4) + ce)]);
      }
    } else {
      #pragma unroll
      for (int ce_1 = 0; ce_1 < 4; ++ce_1) {
        probs[((p_4 * 4) + ce_1)] = half_t(0x0p+0f/*0.000000e+00*/);
      }
    }
  }
  #pragma unroll
  for (int p_5 = 0; p_5 < 8; ++p_5) {
    int pos_4 = starts[p_5];
    if (((0 <= pos_4) && (pos_4 < 1024)) && (pos_4 <= ((int)blockIdx.z))) {
      if ((p_5 % 2) == 0) {
        for (int j_1 = 0; j_1 < 4; ++j_1) {
          {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vr) + ((p_5 * 4) + j_1)),
                    *(((float16x4*)probs) + p_5),
                    *(((float32x4*)out) + j_1));
    };
        }
      } else {
        for (int j_2 = 0; j_2 < 4; ++j_2) {
          {
      *(((float32x4*)out_1) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vr) + ((p_5 * 4) + j_2)),
                    *(((float16x4*)probs) + p_5),
                    *(((float32x4*)out_1) + j_2));
    };
        }
      }
    }
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 16; ++i_8) {
    out[i_8] = (out[i_8] + out_1[i_8]);
  }
  den[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    den[0] = (den[0] + sums[rv]);
  }
  den[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(den[0], (&(((float*)buf_dyn_shmem)[0])));
  float condval_1;
  if ((0x0p+0f/*0.000000e+00*/ < den[0])) {
    condval_1 = (0x1p+0f/*1.000000e+00*/ / den[0]);
  } else {
    condval_1 = 0x0p+0f/*0.000000e+00*/;
  }
  inv[0] = condval_1;
  #pragma unroll
  for (int i_9 = 0; i_9 < 16; ++i_9) {
    out[i_9] = (out[i_9] * inv[0]);
  }
  #pragma unroll
  for (int cc = 0; cc < 4; ++cc) {
    #pragma unroll
    for (int ce_2 = 0; ce_2 < 4; ++ce_2) {
      O_reg[((cc * 4) + ce_2)] = ((half_t)out[((cc * 4) + ce_2)]);
    }
  }
  #pragma unroll
  for (int i_10 = 0; i_10 < 4; ++i_10) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_10 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_10 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_11 = 0; i_11 < 2; ++i_11) {
    *(uint4*)(Output + ((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + (i_11 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_11 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

