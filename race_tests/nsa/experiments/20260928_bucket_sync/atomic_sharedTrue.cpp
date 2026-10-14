#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(int* __restrict__ Counts, int* __restrict__ Slots, const int* __restrict__ Src);
extern "C" __global__ void __launch_bounds__(256, 1) kernel_kernel(int* __restrict__ Counts, int* __restrict__ Slots, const int* __restrict__ Src) {
  extern __shared__ __align__(1024) int local_counts[];
  if (((int)threadIdx.x) < 8) {
    local_counts[((int)threadIdx.x)] = 0;
  }
  __syncthreads();
  int bucket = min(max(Src[((int)threadIdx.x)], 0), 7);
  Slots[((int)threadIdx.x)] = AtomicAddRet((&(local_counts[((int64_t)bucket)])), 1);
  __syncthreads();
  if (((int)threadIdx.x) < 8) {
    Counts[((int)threadIdx.x)] = local_counts[((int)threadIdx.x)];
  }
}

