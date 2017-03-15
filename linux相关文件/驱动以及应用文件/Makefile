obj-m := ssd.o
KDIR := /home/archer/proj/linux-xlnx-xilinx-v14.7
CC=arm-xilinx-linux-gnueabi-gcc

all:
	-make -C $(KDIR) M=/home/archer modules
	$(CC) testssd.c -o cl
	rm -rf *.o *.mod.o *.mod.c *.symvers modules.order

clean:
	rm -rf *.o *.mod.o *.mod.c *.symvers modules.order


