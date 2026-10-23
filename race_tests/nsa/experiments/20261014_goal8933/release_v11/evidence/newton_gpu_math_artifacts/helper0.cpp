#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const float* __restrict__ X, float* __restrict__ Y);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const float* __restrict__ X, float* __restrict__ Y) {
  if (((((int)blockIdx.x) * 128) + ((int)threadIdx.x)) < 8755201) {
    float value = X[((((int)blockIdx.x) * 128) + ((int)threadIdx.x))];
    float condval;
    if ((0x0p+0f/*0.000000e+00*/ < value)) {
      uint v_ = (uint)2129859011 - (*(uint *)(&(value)));
      condval = (((*(float *)(&(v_))) * (0x1p+1f/*2.000000e+00*/ - (value * (*(float *)(&(v_)))))) * (0x1p+1f/*2.000000e+00*/ - (value * ((*(float *)(&(v_))) * (0x1p+1f/*2.000000e+00*/ - (value * (*(float *)(&(v_)))))))));
    } else {
      condval = 0x0p+0f/*0.000000e+00*/;
    }
    Y[((((int)blockIdx.x) * 128) + ((int)threadIdx.x))] = condval;
  }
}


#ifdef _WIN32
#define TL_EXPORT __declspec(dllexport)
#else
#define TL_EXPORT
#endif

#define ERROR_BUF_SIZE 1024
static char error_buf[ERROR_BUF_SIZE];

extern "C" TL_EXPORT const char* get_last_error() {
    return error_buf;
}

extern "C" TL_EXPORT int init() {
    error_buf[0] = '\0';
    
    return 0;
}

extern "C" TL_EXPORT int call(float* __restrict__ X, float* __restrict__ Y, mcStream_t stream=mcStreamDefault) {
	kernel_kernel<<<dim3(68401, 1, 1), dim3(128, 1, 1), 0, stream>>>(X, Y);
	TILELANG_CHECK_LAST_ERROR("kernel_kernel");

	return 0;
}
