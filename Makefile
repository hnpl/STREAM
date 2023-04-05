# Compiler options
CC = gcc
CFLAGS = -O2 -fopenmp

# Output name
OUTPUT_SUFFIX = .hw.$(ARRAY_SIZE)

# Benchmark options
HARDCODED_OPTIONS = -DNTIMES=2 -DSTREAM_ARRAY_SIZE=$(ARRAY_SIZE)

# If NTHREADS is defined, the benchmark will always run using NTHREADS threads
ifdef NTHREADS
	HARDCODED_OPTIONS := $(HARDCODED_OPTIONS) -DNTHREADS=$(NTHREADS)
	OUTPUT_SUFFIX := $(OUTPUT_SUFFIX).$(NTHREADS)t
endif


all: stream_c.exe

stream_c.exe: stream.c
	$(CC) $(CFLAGS) $(HARDCODED_OPTIONS) stream.c -o stream_c$(OUTPUT_SUFFIX)

clean:
	rm -f stream_c.hw.* *.o
