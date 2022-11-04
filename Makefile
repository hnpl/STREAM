#CC = /riscv/_install/bin/riscv64-unknown-linux-gnu-gcc
OUTPUT_PATH ?= .
N_THREADS ?= 4
CFLAGS = -O2 -fopenmp -static

FC = gfortran
FFLAGS = -O2 -fopenmp

# if m5_build_path is defined, we build the STREAM benchmark with the m5 annotations
ifneq ($(M5_BUILD_PATH),)
  CFLAGS += -I$(M5_BUILD_PATH)/../../../../include/
  CFLAGS += -O -DGEM5_ANNOTATION=1 -v
  LDFLAGS += -lm5 -L$(M5_BUILD_PATH)/out/
endif

all: stream_c.exe

stream_f.exe: stream.f mysecond.o
	$(CC) $(CFLAGS) -c mysecond.c
	$(FC) $(FFLAGS) -c stream.f
	$(FC) $(FFLAGS) stream.o mysecond.o -o stream_f.exe

stream_c.exe: stream.c
	$(CC) $(CFLAGS) -O -DSTREAM_ARRAY_SIZE=$(ARRAY_SIZE) -DNTIMES=2 -DN_THREADS=$(N_THREADS) stream.c -o $(OUTPUT_PATH)/stream_c.$(ARRAY_SIZE) $(LDFLAGS)

clean:
	rm -f stream_f.exe stream_c.exe *.o stream_c.*

# an example of a more complex build line for the Intel icc compiler
stream.icc: stream.c
	icc -O3 -xCORE-AVX2 -ffreestanding -qopenmp -DSTREAM_ARRAY_SIZE=80000000 -DNTIMES=20 stream.c -o stream.omp.AVX2.80M.20x.icc
