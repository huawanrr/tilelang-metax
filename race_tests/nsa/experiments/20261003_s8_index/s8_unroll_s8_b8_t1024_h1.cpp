#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[8];
  half_t tile[8];
  *(uint4*)(ktile + 0) = *(uint4*)(K + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + ((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[((((((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
  }
}

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
  half_t Q_reg[16];
  float acc_o[16];
  float acc_o_1[16];
  float acc_o_2[16];
  float acc_o_3[16];
  float sum_acc[4];
  float scores_sum[1];
  float inv_sum[1];
  half_t O_reg[16];
  half_t K_reg[16];
  half_t K_reg1[16];
  half_t K_reg2[16];
  half_t K_reg3[16];
  half_t V_reg[16];
  float acc_s[4];
  half_t acc_s_cast[4];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    indices[si] = (BlockIndices[(((((int)blockIdx.x) * 8192) + (((int)blockIdx.z) * 8)) + si)] * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o_1 + (i_2 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o_2 + (i_3 * 4)) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 4; ++i_4) {
    float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o_3 + (i_4 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
  }
  float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sum_acc + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
  float neg_inf = -MACART_INF_F;
  #pragma unroll
  for (int group = 0; group < 2; ++group) {
    int i_s0 = indices[(group * 4)];
    int i_s1 = indices[((group * 4) + 1)];
    int i_s2 = indices[((group * 4) + 2)];
    int i_s3 = indices[((group * 4) + 3)];
    if (((0 <= i_s0) && (i_s0 < 1024)) && (i_s0 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_5 = 0; i_5 < 2; ++i_5) {
        *(uint4*)(K_reg + (i_5 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((i_s0 >> 4) * 1024)) + (i_5 * 512)) + (((int)threadIdx.x) * 8)));
      }
    }
    if (((0 <= i_s1) && (i_s1 < 1024)) && (i_s1 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_6 = 0; i_6 < 2; ++i_6) {
        *(uint4*)(K_reg1 + (i_6 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((i_s1 >> 4) * 1024)) + (i_6 * 512)) + (((int)threadIdx.x) * 8)));
      }
    }
    if (((0 <= i_s2) && (i_s2 < 1024)) && (i_s2 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_7 = 0; i_7 < 2; ++i_7) {
        *(uint4*)(K_reg2 + (i_7 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((i_s2 >> 4) * 1024)) + (i_7 * 512)) + (((int)threadIdx.x) * 8)));
      }
    }
    if (((0 <= i_s3) && (i_s3 < 1024)) && (i_s3 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_8 = 0; i_8 < 2; ++i_8) {
        *(uint4*)(K_reg3 + (i_8 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((i_s3 >> 4) * 1024)) + (i_8 * 512)) + (((int)threadIdx.x) * 8)));
      }
    }
    if (((0 <= i_s0) && (i_s0 < 1024)) && (i_s0 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_9 = 0; i_9 < 2; ++i_9) {
        *(uint4*)(V_reg + (i_9 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((i_s0 >> 4) * 1024)) + (i_9 * 512)) + (((int)threadIdx.x) * 8)));
      }
      if (((int)blockIdx.z) < (i_s0 + 15)) {
        #pragma unroll
        for (int i_10 = 0; i_10 < 4; ++i_10) {
          float condval;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s0) + i_10) <= ((int)blockIdx.z))) {
            condval = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval = neg_inf;
          }
          acc_s[i_10] = condval;
        }
      } else {
        float broadcast_var_5 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + 0) = make_float4(broadcast_var_5, broadcast_var_5, broadcast_var_5, broadcast_var_5);
      }
      for (int ki = 0; ki < 2; ++ki) {
        for (int kp = 0; kp < 2; ++kp) {
          {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + ((ki * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_11 = 0; i_11 < 4; ++i_11) {
        acc_s[i_11] = exp2f(min((acc_s[i_11] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_12 = 0; i_12 < 4; ++i_12) {
        sum_acc[i_12] = (sum_acc[i_12] + acc_s[i_12]);
      }
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + 0);
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + 0) = __1;
      for (int j = 0; j < 4; ++j) {
        {
      *(((float32x4*)acc_o) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j));
    };
      }
    }
    if (((0 <= i_s1) && (i_s1 < 1024)) && (i_s1 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_13 = 0; i_13 < 2; ++i_13) {
        *(uint4*)(V_reg + (i_13 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((i_s1 >> 4) * 1024)) + (i_13 * 512)) + (((int)threadIdx.x) * 8)));
      }
      if (((int)blockIdx.z) < (i_s1 + 15)) {
        #pragma unroll
        for (int i_14 = 0; i_14 < 4; ++i_14) {
          float condval_1;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s1) + i_14) <= ((int)blockIdx.z))) {
            condval_1 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_1 = neg_inf;
          }
          acc_s[i_14] = condval_1;
        }
      } else {
        float broadcast_var_6 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + 0) = make_float4(broadcast_var_6, broadcast_var_6, broadcast_var_6, broadcast_var_6);
      }
      for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
        for (int kp_1 = 0; kp_1 < 2; ++kp_1) {
          {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg1) + ((ki_1 * 2) + kp_1)),
                    *(((float16x4*)Q_reg) + ((ki_1 * 2) + kp_1)),
                    *(((float32x4*)acc_s) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_15 = 0; i_15 < 4; ++i_15) {
        acc_s[i_15] = exp2f(min((acc_s[i_15] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_16 = 0; i_16 < 4; ++i_16) {
        sum_acc[i_16] = (sum_acc[i_16] + acc_s[i_16]);
      }
      uint2 __2;
      float4 v__1 = *(float4*)(acc_s + 0);
      ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
      ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
      *(uint2*)(acc_s_cast + 0) = __2;
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)acc_o_1) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_1) + j_1));
    };
      }
    }
    if (((0 <= i_s2) && (i_s2 < 1024)) && (i_s2 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_17 = 0; i_17 < 2; ++i_17) {
        *(uint4*)(V_reg + (i_17 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((i_s2 >> 4) * 1024)) + (i_17 * 512)) + (((int)threadIdx.x) * 8)));
      }
      if (((int)blockIdx.z) < (i_s2 + 15)) {
        #pragma unroll
        for (int i_18 = 0; i_18 < 4; ++i_18) {
          float condval_2;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s2) + i_18) <= ((int)blockIdx.z))) {
            condval_2 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_2 = neg_inf;
          }
          acc_s[i_18] = condval_2;
        }
      } else {
        float broadcast_var_7 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + 0) = make_float4(broadcast_var_7, broadcast_var_7, broadcast_var_7, broadcast_var_7);
      }
      for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
        for (int kp_2 = 0; kp_2 < 2; ++kp_2) {
          {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg2) + ((ki_2 * 2) + kp_2)),
                    *(((float16x4*)Q_reg) + ((ki_2 * 2) + kp_2)),
                    *(((float32x4*)acc_s) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_19 = 0; i_19 < 4; ++i_19) {
        acc_s[i_19] = exp2f(min((acc_s[i_19] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_20 = 0; i_20 < 4; ++i_20) {
        sum_acc[i_20] = (sum_acc[i_20] + acc_s[i_20]);
      }
      uint2 __3;
      float4 v__2 = *(float4*)(acc_s + 0);
      ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
      ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
      *(uint2*)(acc_s_cast + 0) = __3;
      for (int j_2 = 0; j_2 < 4; ++j_2) {
        {
      *(((float32x4*)acc_o_2) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_2),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_2) + j_2));
    };
      }
    }
    if (((0 <= i_s3) && (i_s3 < 1024)) && (i_s3 <= ((int)blockIdx.z))) {
      #pragma unroll
      for (int i_21 = 0; i_21 < 2; ++i_21) {
        *(uint4*)(V_reg + (i_21 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((i_s3 >> 4) * 1024)) + (i_21 * 512)) + (((int)threadIdx.x) * 8)));
      }
      if (((int)blockIdx.z) < (i_s3 + 15)) {
        #pragma unroll
        for (int i_22 = 0; i_22 < 4; ++i_22) {
          float condval_3;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s3) + i_22) <= ((int)blockIdx.z))) {
            condval_3 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_3 = neg_inf;
          }
          acc_s[i_22] = condval_3;
        }
      } else {
        float broadcast_var_8 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + 0) = make_float4(broadcast_var_8, broadcast_var_8, broadcast_var_8, broadcast_var_8);
      }
      for (int ki_3 = 0; ki_3 < 2; ++ki_3) {
        for (int kp_3 = 0; kp_3 < 2; ++kp_3) {
          {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg3) + ((ki_3 * 2) + kp_3)),
                    *(((float16x4*)Q_reg) + ((ki_3 * 2) + kp_3)),
                    *(((float32x4*)acc_s) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_23 = 0; i_23 < 4; ++i_23) {
        acc_s[i_23] = exp2f(min((acc_s[i_23] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_24 = 0; i_24 < 4; ++i_24) {
        sum_acc[i_24] = (sum_acc[i_24] + acc_s[i_24]);
      }
      uint2 __4;
      float4 v__3 = *(float4*)(acc_s + 0);
      ((half2*)(&__4))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
      ((half2*)(&__4))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
      *(uint2*)(acc_s_cast + 0) = __4;
      for (int j_3 = 0; j_3 < 4; ++j_3) {
        {
      *(((float32x4*)acc_o_3) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_3),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_3) + j_3));
    };
      }
    }
  }
  #pragma unroll
  for (int i_25 = 0; i_25 < 16; ++i_25) {
    acc_o[i_25] = (acc_o[i_25] + acc_o_1[i_25]);
    acc_o[i_25] = (acc_o[i_25] + acc_o_2[i_25]);
    acc_o[i_25] = (acc_o[i_25] + acc_o_3[i_25]);
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[rv]);
  }
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[0])));
  float condval_4;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_4 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_4 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_4;
  #pragma unroll
  for (int i_26 = 0; i_26 < 16; ++i_26) {
    acc_o[i_26] = (acc_o[i_26] * inv_sum[0]);
  }
  #pragma unroll
  for (int i_27 = 0; i_27 < 4; ++i_27) {
    uint2 __5;
    float4 v__4 = *(float4*)(acc_o + (i_27 * 4));
    ((half2*)(&__5))[0] = __float22half2_rn(((float2*)(&v__4))[0]);
    ((half2*)(&__5))[1] = __float22half2_rn(((float2*)(&v__4))[1]);
    *(uint2*)(O_reg + (i_27 * 4)) = __5;
  }
  #pragma unroll
  for (int i_28 = 0; i_28 < 4; ++i_28) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_28 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_28 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_29 = 0; i_29 < 2; ++i_29) {
    *(uint4*)(Output + ((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + (i_29 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_29 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

