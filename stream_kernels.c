#include <sys/types.h>

#include "stream_common.h"

//static const STREAM_TYPE scalar = 3.0;

void copy(STREAM_TYPE* restrict dst, STREAM_TYPE* restrict src) {
    ssize_t j;
#pragma omp parallel for
    for (j=0; j<STREAM_ARRAY_SIZE; j++)
        dst[j] = src[j];
}

void scale(STREAM_TYPE* restrict dst, STREAM_TYPE* restrict src, const STREAM_TYPE scalar) {
    ssize_t j;
#pragma omp parallel for
    for (j=0; j<STREAM_ARRAY_SIZE; j++)
        dst[j] = scalar*src[j];
}

void add(STREAM_TYPE* restrict dst, STREAM_TYPE* restrict src1, STREAM_TYPE* restrict src2) {
    ssize_t j;
#pragma omp parallel for
    for (j=0; j<STREAM_ARRAY_SIZE; j++)
        dst[j] = src1[j]+src2[j];
}

void triad(STREAM_TYPE* restrict dst, STREAM_TYPE* restrict src1, STREAM_TYPE* restrict src2, const STREAM_TYPE scalar) {
    ssize_t j;
#pragma omp parallel for
    for (j=0; j<STREAM_ARRAY_SIZE; j++)
        dst[j] = src1[j]+scalar*src2[j];
}

