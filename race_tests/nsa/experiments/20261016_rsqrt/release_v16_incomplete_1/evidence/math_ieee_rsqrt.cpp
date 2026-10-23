#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const float* __restrict__ X, float* __restrict__ Y);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const float* __restrict__ X, float* __restrict__ Y) {
  if (((((int)blockIdx.x) * 128) + ((int)threadIdx.x)) < 8755203) {
    float value = X[((((int)blockIdx.x) * 128) + ((int)threadIdx.x))];
    float condval;
    if ((0x0p+0f/*0.000000e+00*/ < value)) {
      condval = (__frsqrt_rn(value) * __frsqrt_rn(value));
    } else {
      condval = 0x0p+0f/*0.000000e+00*/;
    }
    Y[((((int)blockIdx.x) * 128) + ((int)threadIdx.x))] = condval;
  }
}

