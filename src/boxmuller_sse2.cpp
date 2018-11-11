#include "test.h"

#ifdef USE_SSE2

#include "lcg.h"
#include <cassert>
#include <cmath>

static void normaldistf_boxmuller_sse2(float* data, size_t count) {
	assert(count % 8 == 0);
	const __m128 twopi = _mm_set1_ps(2.0f * 3.14159265358979323846f);
	const __m128 one = _mm_set1_ps(1.0f);
	const __m128 minustwo = _mm_set1_ps(-2.0f);

	LCG<__m128> r;
	for (size_t i = 0; i < count; i += 8) {
        __m128 u1 = _mm_sub_ps(one, r()); // [0, 1) -> (0, 1]
        __m128 u2 = r();
		__m128 radius = _mm_sqrt_ps(_mm_mul_ps(minustwo, log_ps(u1)));
		__m128 theta = _mm_mul_ps(twopi, u2);
        __m128 sintheta, costheta;
        sincos_ps(theta, &sintheta, &costheta);
		_mm_store_ps(&data[i    ], _mm_mul_ps(radius, costheta));
		_mm_store_ps(&data[i + 4], _mm_mul_ps(radius, sintheta));
	}
}

static void normaldistf_boxmuller_sse2_v2(float* data, size_t count) {
	assert(count % 8 == 0);
	const __m128 twopi = _mm_set1_ps(2.0f * 3.14159265358979323846f);
	const __m128 one = _mm_set1_ps(1.0f);
	const __m128 minustwo = _mm_set1_ps(-2.0f);

	LCG<__m128> r;
	for (size_t i = 0; i < count; i += 8) {
        const __m128 u1 = _mm_sub_ps(one, r()); // [0, 1) -> (0, 1]
        const __m128 u2 = r();
	    const __m128 theta = _mm_mul_ps(twopi, u2);

        // constants
        const __m128 t0 = sin_ps(theta);
        const __m128 t1 = _mm_mul_ps(minustwo, log_ps(u1));

        // V1 = sqrt(t1) * t0
        // V2 = sqrt(t1 * (1 - t0^2))

        __m128 V1;
        V1 = _mm_sqrt_ps(t1);
        V1 = _mm_mul_ps(V1, t0);

        __m128 V2;
        V1 = _mm_mul_ps(t0, t0);
        V1 = _mm_sub_ps(one, V1);
        V1 = _mm_mul_ps(t1, V1);
        V1 = _mm_sqrt_ps(V1);

		_mm_store_ps(&data[i    ], V1);
		_mm_store_ps(&data[i + 4], V2);
	}
}

REGISTER_TEST_FLOATONLY(boxmuller_sse2);
REGISTER_TEST_FLOATONLY(boxmuller_sse2_v2);

#endif // USE_SSE2
