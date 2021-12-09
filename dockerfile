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
RUN nasm -f elf32 -o /opt/anos/main.o /opt/anos/main.asm
#RUN ld /opt/anos/main.o -T /opt/anos/bootloader.ld -r -o /opt/anos/main.o
RUN gcc -m16 -nostdlib -Wall -Wextra -fno-asynchronous-unwind-tables --save-temps -ffreestanding -mregparm=3 -static -fno-pie -c -o /opt/anos/SYS1.o /opt/anos/SYS1.c
RUN ld /opt/anos/main.o /opt/anos/SYS1.o -m elf_i386 -T /opt/anos/link.ld -o /opt/anos/boot.bin
RUN cp /opt/anos/boot.bin /opt/anos/boot.dis
RUN wc -c /opt/anos/SYS1.o
#RUN ld /opt/anos/SYS1.o -T /opt/anos/SYS1.ld -r -o /opt/anos/SYS1.o
#RUN ld /opt/anos/main.o /opt/anos/SYS1.o -m elf_i386 --oformat binary -U -o /opt/anos/boot.bin
####RUN ld /opt/anos/main.o /opt/anos/SYS1.o -m elf_i386 -fno-pie -T /opt/anos/link.ld -o /opt/anos/boot.bin
#RUN /opt/anos/objconvl -fnasm -nu /opt/anos/SYS1.o
##RUN objdump -t SYS1.o > symbols.txt
##RUN objcopy -O binary /opt/anos/SYS1.o /opt/anos/SYS1.bin
#COPY /opt/anos/SYS1.asm ./SYS1.asm
# 1474560 = size of a floppy disk
RUN truncate -s 1474560 /opt/anos/boot.bin