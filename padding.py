import os

bootloadersize = os.path.getsize("main.bin")
ccodesize = os.path.getsize("SYS1.bin")
paddingsize = 1474560-(bootloadersize+ccodesize)
print(f"Bootloader Size: {bootloadersize}")
print(f"C Code Size: {ccodesize}")
print(f"Padding Size: {paddingsize}")
buffer = []
for index in range(0,paddingsize):
    buffer.append(0x90)

f = open("padding.bin", "wb")
f.write(bytearray(buffer))
f.close()
