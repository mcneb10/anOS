# anOS
## What is it?
**anOS** is an fully from scratch OS (bootloader, "kernel", shell and possibly window manager coming soon!)
## How to build

**Dependencies**:
* ndisasm (part of nasm) in your path
* docker
* QEMU and GDB (if you want to run and it using the compileandrunscript)

### Unix like systems

`./baseimg/buildbaseimg.sh`
`./compile`

### Windows
`baseimg/buildbaseimg.bat`
`compile.bat`