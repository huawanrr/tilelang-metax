#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(int64_t* __restrict__ EncodedIndices, const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const int* __restrict__ RawIndices, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(int64_t* __restrict__ EncodedIndices, const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const int* __restrict__ RawIndices, const half_t* __restrict__ V) {
  half_t ktile[8];
  half_t tile[8];
  uint64_t tag_bits[1];
  *(uint4*)(ktile + 0) = *(uint4*)(K + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + ((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[((((((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
  }
  int raw_block = RawIndices[(((((int)blockIdx.z) * 8192) + (((int)blockIdx.x) * 128)) + ((int)threadIdx.x))];
  bool tag_valid = (((0 <= raw_block) && (raw_block < 64)) && (raw_block <= ((int)blockIdx.x)));
  bool tag_full = ((raw_block < 64) && (raw_block < (((((int)threadIdx.x) + 8) >> 7) + ((int)blockIdx.x))));
  int condval;
  if (tag_valid) {
    int condval_1;
    if (tag_full) {
      condval_1 = 128;
    } else {
      condval_1 = 64;
    }
    condval = ((raw_block & 63) | condval_1);
  } else {
    condval = 0;
  }
  tag_bits[0] = (((uint64_t)condval) << ((uint64_t)((((int)threadIdx.x) & 7) * 8)));
  tag_bits[0] = (tag_bits[0] | __shfl_xor_sync((uint64_t)18446744073709551615, tag_bits[0], 1, 64));
  tag_bits[0] = (tag_bits[0] | __shfl_xor_sync((uint64_t)18446744073709551615, tag_bits[0], 2, 64));
  tag_bits[0] = (tag_bits[0] | __shfl_xor_sync((uint64_t)18446744073709551615, tag_bits[0], 4, 64));
  if ((((int)threadIdx.x) % 8) == 0) {
    uint64_t v_ = tag_bits[0];
    EncodedIndices[(((((int)blockIdx.z) * 1024) + (((int)blockIdx.x) * 16)) + (((int)threadIdx.x) >> 3))] = (*(int64_t *)(&(v_)));
  }
}

