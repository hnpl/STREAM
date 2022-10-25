#CC = /riscv/_install/bin/riscv64-unknown-linux-gnu-gcc
CFLAGS = -O2 -fopenmp -static

FC = gfortran
FFLAGS = -O2 -fopenmp

all: stream_c.exe

stream_f.exe: stream.f mysecond.o
	$(CC) $(CFLAGS) -c mysecond.c
	$(FC) $(FFLAGS) -c stream.f
	$(FC) $(FFLAGS) stream.o mysecond.o -o stream_f.exe

stream_c.exe: stream.c
	$(CC) $(CFLAGS) -O -DSTREAM_ARRAY_SIZE=$(ARRAY_SIZE) -DNTIMES=2 stream.c -o stream_c.$(ARRAY_SIZE)

clean:
	rm -f stream_f.exe stream_c.exe *.o stream_c.*

# an example of a more complex build line for the Intel icc compiler
stream.icc: stream.c
	icc -O3 -xCORE-AVX2 -ffreestanding -qopenmp -DSTREAM_ARRAY_SIZE=80000000 -DNTIMES=20 stream.c -o stream.omp.AVX2.80M.20x.icc
