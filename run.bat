@echo off
start "QEMU" "E:\Program Files\qemu\qemu-system-x86_64.exe" -S -s -fda .\main.bin
start "GDB" ".\GDB\gdb.exe" --command=gdbcommands
