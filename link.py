#files listed by link position
files = ["boot.bin", "padding.bin"]
output = "boot.bin"
result = bytearray()
for file in files:
    f = open(file, 'rb')
    byte = f.read(1)
    while byte:
        result += byte
        byte = f.read(1)
    f.close()

f = open(output, "wb")
f.write(result)
f.close()
