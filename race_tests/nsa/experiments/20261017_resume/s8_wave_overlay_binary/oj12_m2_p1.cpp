#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  int indices[8];
  half_t qr[16];
  float resident[32];
  half_t kr[64];
  half_t probs[4];
  float scores[4];
  float den[1];
  half_t oreg[16];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    int raw_index = BlockIndices[(((((int)blockIdx.x) * 8192) + (((int)blockIdx.z) * 8)) + si)];
    indices[si] = (min(max(raw_index, -1), 64) * 16);
  }
  if ((((int)threadIdx.x) >> 6) == 0) {
    #pragma unroll
    for (int kc = 0; kc < 2; ++kc) {
      *(uint4*)(qr + (kc * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (kc * 32)) + (((((int)threadIdx.x) & 63) >> 4) * 8)));
    }
    #pragma unroll
    for (int qi = 0; qi < 8; ++qi) {
      half_t v_ = qr[(qi * 2)];
      half_t v__1 = qr[((qi * 2) + 1)];
      uint v__2 = ((uint)(*(ushort *)(&(v_)))) | (((uint)(*(ushort *)(&(v__1)))) << (uint)16);
      resident[qi] = (*(float *)(&(v__2)));
    }
    #pragma unroll
    for (int ce = 0; ce < 4; ++ce) {
      resident[(ce + 8)] = 0x0p+0f/*0.000000e+00*/;
    }
  } else {
    #pragma unroll
    for (int i = 0; i < 8; ++i) {
      float broadcast_var = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(resident + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
    }
  }
  for (int step = 0; step < 3; ++step) {
    if (((((int)threadIdx.x) >> 6) == 0) && (step < 2)) {
      #pragma unroll
      for (int p = 0; p < 4; ++p) {
        int pos = indices[((step * 4) + p)];
        if (((0 <= pos) && (pos < 1024)) && (pos <= ((int)blockIdx.z))) {
          #pragma unroll
          for (int kc_1 = 0; kc_1 < 2; ++kc_1) {
            *(uint4*)(kr + ((p * 16) + (kc_1 * 8))) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((pos >> 4) * 1024)) + (kc_1 * 512)) + ((((int)threadIdx.x) & 63) * 8)));
          }
        }
      }
      #pragma unroll
      for (int p_1 = 0; p_1 < 4; ++p_1) {
        int pos_1 = indices[((step * 4) + p_1)];
        if (((0 <= pos_1) && (pos_1 < 1024)) && (pos_1 <= ((int)blockIdx.z))) {
          if (((int)blockIdx.z) < (pos_1 + 15)) {
            #pragma unroll
            for (int ce_1 = 0; ce_1 < 4; ++ce_1) {
              float condval;
              if (((((((((int)threadIdx.x) & 63) >> 4) * 4) + pos_1) + ce_1) <= ((int)blockIdx.z))) {
                condval = 0x0p+0f/*0.000000e+00*/;
              } else {
                condval = -MACART_INF_F;
              }
              scores[ce_1] = condval;
            }
          } else {
            float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
            *(float4*)(scores + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
          }
          #pragma unroll
          for (int ki = 0; ki < 4; ++ki) {
            {
      *(((float32x4*)scores) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kr) + ((p_1 * 4) + ki)),
                    *(((float16x4*)resident) + ki),
                    *(((float32x4*)scores) + 0));
    };
          }
          #pragma unroll
          for (int ce_2 = 0; ce_2 < 4; ++ce_2) {
            scores[ce_2] = expf(min((scores[ce_2] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
          }
          #pragma unroll
          for (int ce_3 = 0; ce_3 < 4; ++ce_3) {
            resident[(ce_3 + 8)] = (resident[(ce_3 + 8)] + scores[ce_3]);
            probs[ce_3] = ((half_t)scores[ce_3]);
          }
        } else {
          half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
          *(uint2*)(probs + 0) = make_uint2(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
        }
        *(uint2*)(((half_t*)buf_dyn_shmem) + (((step * 1024) + (p_1 * 256)) + ((((int)threadIdx.x) & 63) * 4))) = *(uint2*)(probs + 0);
      }
    }
    if (((((int)threadIdx.x) >> 6) == 1) && (0 < step)) {
      #pragma unroll
      for (int p_2 = 0; p_2 < 4; ++p_2) {
        int pos_2 = indices[(((step * 4) + p_2) - 4)];
        if (((0 <= pos_2) && (pos_2 < 1024)) && (pos_2 <= ((int)blockIdx.z))) {
          #pragma unroll
          for (int vc = 0; vc < 2; ++vc) {
            *(uint4*)(kr + (vc * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((pos_2 >> 4) * 1024)) + (vc * 512)) + ((((int)threadIdx.x) & 63) * 8)));
          }
          *(uint2*)(probs + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((step * 1024) + (p_2 * 256)) + ((((int)threadIdx.x) & 63) * 4)) - 1024));
          if ((p_2 % 2) == 0) {
            #pragma unroll
            for (int col = 0; col < 4; ++col) {
              {
      *(((float32x4*)resident) + col) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kr) + col),
                    *(((float16x4*)probs) + 0),
                    *(((float32x4*)resident) + col));
    };
            }
          } else {
            #pragma unroll
            for (int col_1 = 0; col_1 < 4; ++col_1) {
              {
      *(((float32x4*)resident) + (col_1 + 4)) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kr) + col_1),
                    *(((float16x4*)probs) + 0),
                    *(((float32x4*)resident) + (col_1 + 4)));
    };
            }
          }
        }
      }
    }
    __syncthreads();
  }
  if ((((int)threadIdx.x) >> 6) == 0) {
    den[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int ce_4 = 0; ce_4 < 4; ++ce_4) {
      den[0] = (den[0] + resident[(ce_4 + 8)]);
    }
    den[0] = (den[0] + __shfl_xor_sync((uint64_t)18446744073709551615, den[0], 32, 64));
    den[0] = (den[0] + __shfl_xor_sync((uint64_t)18446744073709551615, den[0], 16, 64));
    float condval_1;
    if ((0x0p+0f/*0.000000e+00*/ < den[0])) {
      condval_1 = (0x1p+0f/*1.000000e+00*/ / den[0]);
    } else {
      condval_1 = 0x0p+0f/*0.000000e+00*/;
    }
    den[0] = condval_1;
    ((float*)buf_dyn_shmem)[(((int)threadIdx.x) & 63)] = den[0];
  }
  __syncthreads();
  if ((((int)threadIdx.x) >> 6) == 1) {
    den[0] = ((float*)buf_dyn_shmem)[(((int)threadIdx.x) & 63)];
    __syncwarp();
    #pragma unroll
    for (int ce_5 = 0; ce_5 < 16; ++ce_5) {
      resident[ce_5] = (resident[ce_5] + resident[(ce_5 + 16)]);
      resident[ce_5] = (resident[ce_5] * den[0]);
      oreg[ce_5] = ((half_t)resident[ce_5]);
    }
    #pragma unroll
    for (int cc = 0; cc < 4; ++cc) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((cc * 2) + ((((int)threadIdx.x) & 63) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(oreg + (cc * 4));
    }
    __syncwarp();
    #pragma unroll
    for (int oc = 0; oc < 2; ++oc) {
      *(uint4*)(Output + ((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + (oc * 512)) + ((((int)threadIdx.x) & 63) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((oc * 512) + (((((int)threadIdx.x) & 63) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ ((((int)threadIdx.x) & 63) >> 3)) * 8)));
    }
  }
}

