#CC = /riscv/_install/bin/riscv64-unknown-linux-gnu-gcc
OUTPUT_PATH ?= .
N_THREADS ?= 4
CFLAGS = -O2 -fopenmp -static

# if both m5ops_header_path and m5_build_path are defined, we build the STREAM benchmark with the m5 annotations
ifneq ($(M5_BUILD_PATH),)
  CFLAGS += -I$(M5OPS_HEADER_PATH)
  CFLAGS += -O -DGEM5_ANNOTATION=1 
  LDFLAGS += -lm5 -L$(M5_BUILD_PATH)/out/
endif

all: stream_c

stream_c: stream.c
	$(CC) $(CFLAGS) -O -DSTREAM_ARRAY_SIZE=$(ARRAY_SIZE) -DNTIMES=2 -DN_THREADS=$(N_THREADS) stream.c -o $(OUTPUT_PATH)/stream_c.$(ARRAY_SIZE) $(LDFLAGS)

clean:
	rm -f *.o stream_c.*

