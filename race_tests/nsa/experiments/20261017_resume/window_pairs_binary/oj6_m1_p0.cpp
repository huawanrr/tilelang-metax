#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ PackedKV, int* __restrict__ Schedule, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ Indices, const half_t* __restrict__ K, half_t* __restrict__ PackedKV, int* __restrict__ Schedule, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  half_t ktile[16];
  half_t tile[16];
  half_t packed_k[16];
  half_t packed_v[16];
  int buckets[1];
  int ranks[1];
  int scan[1];
  if (((int)blockIdx.x) < 128) {
    #pragma unroll
    for (int i = 0; i < 2; ++i) {
      *(uint4*)(ktile + (i * 8)) = *(uint4*)(K + ((((((((int)blockIdx.z) * 131072) + ((((int)blockIdx.x) >> 1) * 2048)) + (i * 1024)) + ((((int)threadIdx.x) >> 3) * 128)) + ((((int)blockIdx.x) & 1) * 64)) + ((((int)threadIdx.x) & 7) * 8)));
    }
    #pragma unroll
    for (int i_1 = 0; i_1 < 2; ++i_1) {
      *(uint4*)(tile + (i_1 * 8)) = *(uint4*)(V + ((((((((int)blockIdx.z) * 131072) + ((((int)blockIdx.x) >> 1) * 2048)) + (i_1 * 1024)) + ((((int)threadIdx.x) >> 3) * 128)) + ((((int)blockIdx.x) & 1) * 64)) + ((((int)threadIdx.x) & 7) * 8)));
    }
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_2 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(ktile + (i_2 * 8));
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      *(uint2*)(((half_t*)buf_dyn_shmem) + (((((i_3 >> 1) * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((((int)threadIdx.x) & 7) * 2) + (i_3 & 1)) ^ (((i_3 >> 1) * 8) + (((int)threadIdx.x) >> 3))) * 4)) + 1024)) = *(uint2*)(tile + (i_3 * 4));
    }
    __syncwarp();
    #pragma unroll
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(packed_k + (i_4 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 64) + ((((i_4 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 16; ++i_5) {
      packed_v[i_5] = ((half_t*)buf_dyn_shmem)[((((((((int)threadIdx.x) >> 4) * 256) + ((i_5 & 3) * 64)) + (((((i_5 >> 2) * 4) + ((((int)threadIdx.x) & 15) >> 2)) ^ (((((int)threadIdx.x) >> 4) * 4) + (i_5 & 3))) * 4)) + (((int)threadIdx.x) & 3)) + 1024)];
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 2; ++i_6) {
      *(uint4*)(PackedKV + ((((((((int)blockIdx.z) * 262144) + ((((int)blockIdx.x) >> 2) * 8192)) + ((((int)blockIdx.x) & 1) * 2048)) + (i_6 * 1024)) + (((((int)blockIdx.x) & 3) >> 1) * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(packed_k + (i_6 * 8));
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 2; ++i_7) {
      *(uint4*)(PackedKV + ((((((((int)blockIdx.z) * 262144) + ((((int)blockIdx.x) >> 2) * 8192)) + ((((int)blockIdx.x) & 3) * 1024)) + (i_7 * 512)) + (((int)threadIdx.x) * 8)) + 4096)) = *(uint4*)(packed_v + (i_7 * 8));
    }
  } else {
    ((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 1024)] = 0;
    __syncwarp();
    buckets[0] = 32;
    ranks[0] = 0;
    int raw = Indices[((((((int)blockIdx.z) * 1024) + (((int)blockIdx.x) * 64)) + ((int)threadIdx.x)) - 8192)];
    int condval;
    if ((((0 <= raw) && (raw < 32)) && ((raw + 256) <= ((((int)blockIdx.x) * 2) + (((int)threadIdx.x) >> 5))))) {
      condval = raw;
    } else {
      condval = 32;
    }
    buckets[0] = condval;
    ranks[0] = AtomicAddRet((&(((int*)buf_dyn_shmem)[(buckets[(int64_t)0] + 1024)])), 1);
    __syncwarp();
    scan[0] = ((((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 1024)] * 65536) + ((((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 1024)] + 1) >> 1));
    #pragma unroll
    for (int scan_step = 0; scan_step < 6; ++scan_step) {
      int received = __shfl_up_sync((uint64_t)18446744073709551615, scan[0], (1 << scan_step), 64);
      if ((1 << scan_step) <= ((int)threadIdx.x)) {
        scan[0] = (scan[0] + received);
      }
    }
    ((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 1088)] = ((scan[0] - ((((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 1024)] + 1) >> 1)) - (((int*)buf_dyn_shmem)[(((int)threadIdx.x) + 1024)] * 65536));
    if (((int)threadIdx.x) == 63) {
      Schedule[(((((int)blockIdx.z) * 2320) + (((int)blockIdx.x) * 145)) - 18560)] = (scan[0] & 65535);
    }
    __syncwarp();
    ((int*)buf_dyn_shmem)[(((((int64_t)((int*)buf_dyn_shmem)[(buckets[(int64_t)0] + 1088)]) >> (int64_t)16) + ((int64_t)ranks[(int64_t)0])) + (int64_t)1152)] = (((((int)blockIdx.x) * 64) + ((int)threadIdx.x)) - 8192);
    __syncwarp();
    if ((ranks[0] % 2) == 0) {
      int offset = ((int*)buf_dyn_shmem)[(buckets[(int64_t)0] + 1088)];
      int task = ((ranks[0] >> 1) + (offset & 65535));
      if (0 <= task) {
        if (task < 48) {
          Schedule[((((((int)blockIdx.z) * 2320) + (((int)blockIdx.x) * 145)) + (task * 3)) - 18559)] = buckets[0];
          Schedule[((((((int)blockIdx.z) * 2320) + (((int)blockIdx.x) * 145)) + (task * 3)) - 18558)] = (((((int)blockIdx.x) * 64) + ((int)threadIdx.x)) - 8192);
        }
      }
      if (-1 <= task) {
        if (task < 48) {
          int condval_1;
          if (((ranks[0] + 1) < ((int*)buf_dyn_shmem)[(buckets[(int64_t)0] + 1024)])) {
            condval_1 = ((int*)buf_dyn_shmem)[(((((int64_t)offset) >> (int64_t)16) + ((int64_t)ranks[(int64_t)0])) + (int64_t)1153)];
          } else {
            condval_1 = -1;
          }
          Schedule[((((((int)blockIdx.z) * 2320) + (((int)blockIdx.x) * 145)) + (task * 3)) - 18557)] = condval_1;
        }
      }
    }
  }
}

