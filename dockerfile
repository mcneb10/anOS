FROM anos-macos-build-baseimg
# dockerfile for compiling since macos is wierd
#LABEL author="mcneb10"
#LABEL name="MacOSBuild"
#WORKDIR /opt/docker/anos/
COPY . /opt/anos/
#RUN apt-get update
#RUN apt-get install -y gcc
#RUN apt-get install -y binutils
#RUN apt-get install -y nasm
#RUN apt-get install -y intel2gas
#RUN apt-get install -y wget
#RUN apt-get install -y unzip
RUN cd /opt/anos/
RUN nasm -f elf32 -o main.o main.asm
#RUN ld main.o -T bootloader.ld -r -o main.o
RUN gcc -m16 -nostdlib -Wall -Wextra -fno-asynchronous-unwind-tables -ffreestanding -mregparm=3 -static -fno-pie -c -o SYS1.o SYS1.c
RUN gcc -m16 -nostdlib -Wall -Wextra -fno-asynchronous-unwind-tables -ffreestanding -mregparm=3 -static -fno-pie -masm=intel -S SYS1.c
RUN ld main.o SYS1.o -m elf_i386 -T link.ld -o boot.bin
RUN cp boot.bin boot.dis
#RUN ld SYS1.o -T SYS1.ld -r -o SYS1.o
#RUN ld main.o SYS1.o -m elf_i386 --oformat binary -U -o boot.bin
####RUN ld main.o SYS1.o -m elf_i386 -fno-pie -T link.ld -o boot.bin
#RUN objconvl -fnasm -nu SYS1.o
##RUN objdump -t SYS1.o > symbols.txt
##RUN objcopy -O binary SYS1.o SYS1.bin
#COPY SYS1.asm ./SYS1.asm
# 1474560 = size of a floppy disk
RUN truncate -s 1474560 boot.bin
