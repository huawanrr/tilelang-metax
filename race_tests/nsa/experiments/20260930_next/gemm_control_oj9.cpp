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
  float out[16];
  half_t qr[16];
  half_t kr[16];
  half_t vr[16];
  float score[4];
  float sums[1];
  half_t prob[4];
  half_t Output_local_cast[4];
  int pos = (Indices[((int)blockIdx.x)] * 16);
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(out + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= pos) && (pos < 8192)) && (pos <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 2; ++i_1) {
      *(uint4*)(qr + (i_1 * 8)) = *(uint4*)(Q + (((((int)blockIdx.x) * 1024) + (i_1 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((int)threadIdx.x) >> 3) + pos) >> 3) + i_2) < 1024)) {
        condval = *(uint4*)(K + (((i_2 * 512) + (pos * 64)) + (((int)threadIdx.x) * 8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
      }
      *(uint4*)(kr + (i_2 * 8)) = condval;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 2; ++i_3) {
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if ((((((((int)threadIdx.x) >> 3) + pos) >> 3) + i_3) < 1024)) {
        condval_1 = *(uint4*)(V + (((i_3 * 512) + (pos * 64)) + (((int)threadIdx.x) * 8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(vr + (i_3 * 8)) = condval_1;
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + ((((((int)threadIdx.x) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (((int)threadIdx.x) & 1)) & 1) * 8))) = *(uint4*)(qr + (i_4 * 8));
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 2; ++i_5) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((i_5 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + ((((((int)threadIdx.x) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 1024)) = *(uint4*)(kr + (i_5 * 8));
    }
    if ((pos + 15) <= ((int)blockIdx.x)) {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(score + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    } else {
      #pragma unroll
      for (int i_6 = 0; i_6 < 4; ++i_6) {
        float condval_2;
        if (((((((int)threadIdx.x) >> 4) + ((pos + i_6) >> 2)) < 2048) && (((((((int)threadIdx.x) >> 4) * 4) + pos) + i_6) <= ((int)blockIdx.x)))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        score[i_6] = condval_2;
      }
    }
  }
  __syncthreads();
  if (((0 <= pos) && (pos < 8192)) && (pos <= ((int)blockIdx.x))) {
    half_t A_local[4];
    half_t B_local[4];
    for (int ki = 0; ki < 4; ++ki) {
      *(uint2*)(A_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((((int)threadIdx.x) & 15) * 64) + (((((((int)threadIdx.x) & 7) >> 2) + (ki >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki & 1)) & 1) * 16)) + ((((((int)threadIdx.x) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)));
      *(uint2*)(B_local + 0) = *(uint2*)(((half_t*)buf_dyn_shmem) + (((((((((int)threadIdx.x) & 15) * 64) + (((((((int)threadIdx.x) & 7) >> 2) + (ki >> 1)) & 1) * 32)) + (((((((int)threadIdx.x) & 3) >> 1) + (ki & 1)) & 1) * 16)) + ((((((int)threadIdx.x) >> 5) + (((int)threadIdx.x) & 1)) & 1) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4)) + 1024));
      {
      *(((float32x4*)score) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local) + 0),
                    *(((float16x4*)A_local) + 0),
                    *(((float32x4*)score) + 0));
    };
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      score[i_7] = exp2f(min((score[i_7] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
  }
  __syncthreads();
  if (((0 <= pos) && (pos < 8192)) && (pos <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + ((((((i_8 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + ((((((int)threadIdx.x) >> 5) + ((((int)threadIdx.x) & 7) >> 2)) & 1) * 32)) + (((((((int)threadIdx.x) & 31) >> 4) + ((((int)threadIdx.x) & 3) >> 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (((int)threadIdx.x) & 1)) & 1) * 8)) + 1024)) = *(uint4*)(vr + (i_8 * 8));
    }
  }
  __syncthreads();
  if (((0 <= pos) && (pos < 8192)) && (pos <= ((int)blockIdx.x))) {
    sums[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int rv = 0; rv < 4; ++rv) {
      sums[0] = (sums[0] + score[rv]);
    }
    sums[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(sums[0], (&(((float*)buf_dyn_shmem)[0])));
    float condval_3;
    if ((0x0p+0f/*0.000000e+00*/ < sums[0])) {
      condval_3 = (0x1p+0f/*1.000000e+00*/ / sums[0]);
    } else {
      condval_3 = 0x0p+0f/*0.000000e+00*/;
    }
    sums[0] = condval_3;
    #pragma unroll
    for (int i_9 = 0; i_9 < 4; ++i_9) {
      score[i_9] = (score[i_9] * sums[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(score + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(prob + 0) = __1;
  }
  __syncthreads();
  if (((0 <= pos) && (pos < 8192)) && (pos <= ((int)blockIdx.x))) {
    half_t B_local_1[16];
    for (int j = 0; j < 4; ++j) {
      for (int local_id = 0; local_id < 4; ++local_id) {
        B_local_1[((j * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[((((((((((int)threadIdx.x) >> 4) * 256) + (local_id * 64)) + (((((((int)threadIdx.x) & 31) >> 4) + (j >> 1)) & 1) * 32)) + ((((local_id >> 1) + (j & 1)) & 1) * 16)) + (((((((int)threadIdx.x) & 15) >> 3) + (local_id & 1)) & 1) * 8)) + (((int)threadIdx.x) & 7)) + 1024)];
      }
    }
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)out) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)B_local_1) + j_1),
                    *(((float16x4*)prob) + 0),
                    *(((float32x4*)out) + j_1));
    };
    }
  }
  #pragma unroll
  for (int i_10 = 0; i_10 < 4; ++i_10) {
    uint2 __2;
    float4 v__1 = *(float4*)(out + (i_10 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_10 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

