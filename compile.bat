@echo off
rem compile
docker build -t anos-macos-build .
docker run -di anos-macos-build > cidtmp
set /p CID=<cidtmp
del cidtmp
docker cp %CID%:/opt/anos/boot.bin ./boot.bin
docker cp %CID%:/opt/anos/boot.dis ./boot.dis
docker stop %CID% > nul
docker rm %CID% > nul
docker images -f "dangling=true" -q > ditmp
set /p di=<ditmp
del ditmp
docker rmi %di% > nul
del disasm.asm
ndisasm main.dis >disasm.asm
