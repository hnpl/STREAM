# Compiler options
CC = gcc
CFLAGS_KERNELS = -O2 -fopenmp
CFLAGS_MAIN = -O2 -fopenmp
LDFLAGS = -O2 -fopenmp

# Output name
OUTPUT_SUFFIX = .hw.$(ARRAY_SIZE)

# Benchmark options
HARDCODED_OPTIONS = -DNTIMES=2 -DSTREAM_ARRAY_SIZE=$(ARRAY_SIZE)

# If NTHREADS is defined, the benchmark will always run using NTHREADS threads
ifdef NTHREADS
	HARDCODED_OPTIONS := $(HARDCODED_OPTIONS) -DNTHREADS=$(NTHREADS)
	OUTPUT_SUFFIX := $(OUTPUT_SUFFIX).$(NTHREADS)t
endif


all: stream

stream_kernels$(OUTPUT_SUFFIX).o: stream_kernels.c
	$(CC) $(CFLAGS_KERNELS) -c $(HARDCODED_OPTIONS) stream_kernels.c -o stream_kernels$(OUTPUT_SUFFIX).o

stream_c$(OUTPUT_SUFFIX).o: stream.c
	$(CC) $(CFLAGS_MAIN) -c $(HARDCODED_OPTIONS) stream.c -o stream_c$(OUTPUT_SUFFIX).o

stream: stream_kernels$(OUTPUT_SUFFIX).o stream_c$(OUTPUT_SUFFIX).o
	$(CC) $(LDFLAGS) stream_kernels$(OUTPUT_SUFFIX).o stream_c$(OUTPUT_SUFFIX).o -o stream$(OUTPUT_SUFFIX)

clean:
	rm -f stream_kernels$(OUTPUT_SUFFIX).o stream_c$(OUTPUT_SUFFIX).o stream$(OUTPUT_SUFFIX)
