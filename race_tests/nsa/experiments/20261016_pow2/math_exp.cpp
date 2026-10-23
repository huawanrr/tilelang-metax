#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const float* __restrict__ X, float* __restrict__ Y);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const float* __restrict__ X, float* __restrict__ Y) {
  if (((((int)blockIdx.x) * 128) + ((int)threadIdx.x)) < 1000011) {
    float value = X[((((int)blockIdx.x) * 128) + ((int)threadIdx.x))];
    Y[((((int)blockIdx.x) * 128) + ((int)threadIdx.x))] = expf((value * 0x1.62e42fefa39efp-1f/*6.931472e-01*/));
  }
}

