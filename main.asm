bits 16;16 bit os
;[org 0x7c00]
;section sys0boot vstart=0x7c00 start=0x7c00
section .boot
extern SYS1ENTRY
global boot
;--bootsector code (SYS0BOOT)
;mov ax, 7c0h;bios will load OS to memory at adress 0x7C00
;mov ds, ax
boot:
	;setup stack
	;mov sp, 0x7000
	;mov ax, 0x7c0
	;mov ds, ax
	;setup stack a bit before the bootloader
	mov esp, 0x7000 ; stack will grow from here
	;save drivenumber
	mov [drivenumber], dl
	;print message
	mov bx, msg1
	call asmprintln
	;read "partition table" from disk
	cld
	mov ah, 2h; read mode
	mov ch, 0h
	mov cl, 2h
	mov dh, 0h
	mov al, 11h;17 sectors
	xor bx, bx
	mov es, bx
	mov bx, 7E00h
	int 13h
	std
	;find the main system file and run it
runprog:
	mov bx, 7E00h;beginning of bootsector
findloop:
	cmp bx, 0xA600;end of bootsector
	je rpdone
	mov si, systemfile
	mov di, bx;go to next file entry
	dec di
	dec si
compare:
	inc di
	inc si
	mov al, [si]
	;x/10bs $di helps a lot
	cmp byte [di],al
	jne nextfile
	cmp al, 0h
	jne compare
	jmp loadsystemfile
nextfile:
	add bx, 20
	jmp findloop
loadsystemfile:
	push bx
	mov bx, found
	call asmprintln
	pop bx
	add bx, 16
	;
	cld
	mov ah, 2h;read mode
	mov ch, [bx];cylinder
	;mov ch, 0
	;mov cl, 1;18
	;mov dh, 1
	;mov al, 1
	mov cl, [bx+1];sector start 
	mov dh, [bx+2];head
	mov al, [bx+3];amount of sectors to read
	xor bx, bx;clear bx
	mov es, bx;clear es
	mov ds, bx
	mov bx, 0xA601;write SYS1 into memory right after SYS0 and partition table
	mov dl, [drivenumber]
	int 13h;read SYS1 into memory
	std
	jmp 0xA601;+0x7c00 ;jump to beginning of SYS1
rpdone:
	;no core system file found
	mov bx, error1;print error message
	call asmprint
	jmp $;hang

hello: db 'hello',0
msg1: db 'Attempting to find Main System File on boot disk...',0
systemfile: db 'SYS1CORE       ',0
error1: db 'FATAL BOOTLOADER ERROR!',0x0D,0x0A,'MAIN SYSTEM FILE NOT FOUND',0x0D,0x0A,'FS IS CORRUPTED OR SYSTEM FILE POINTER POINTS TO A FILE THAT DOES NOT EXIST',0
found: db 'Main System File found!',0
drivenumber: db 0
;--ASM "libraries"
%include "/opt/anos/print.asm";print functions
;%include "/opt/anos/basicconsts.asm";basic constants
;SYS1 must be in the first 17 sectors of partition table
;--End Of bootsector
times 510-($-$$) db 0;pad with zeros
dw 0xaa55;Tell BIOS this is bootable
;partition/file table
;each filename is limited to 15 bytes (1 byte for null terminator)
;each file location pointer is 5 bytes
;file location pointer format
;-------------Cylinder/track
;|  ----------Sector Start
;|  |  -------Head
;|  |  |  ----Size of file (sectors)
;|  |  |  |
;00 02 00 00
;SYS1 file location pointer
;00 01 01 10
;maximum of 511 files
;parition table will be 10240 bytes in size (10 kb) (20 sectors)
;partition start: 0x7e00
;actual partition data start: 0x7e14
;partition table end: 0xA600
db 'ANOSFSHEADER1.0',0,0,0,0,0;partition header
db 'SYS0BOOT       ',0,0,1,0,1
db 'SYS1CORE       ',0,0,1,1,20;filename and file location pointer
times 9216-($-$$) db 0;pad partition table accounting for boot sector and partition header
;0x2400
;end partition/file table
;main system file (SYS1CORE)
;section sys1core vstart=0xa601
;%include "symbols.asm"
;;
;mov byte [0xb8000], 'b'
cli
;mov eax, cr0
;or al, 1
;mov cr0, eax
call SYS1ENTRY
hlt
;;
;jmp _SYS1ENTRY;call _SYS1ENTRY

;%include "SYS1.asm"
;       |-----------Total size of a floppy disk
;       |      -----Total size of data before SYS1CORE
;		|      |
;times (1474560-9216)-($-$$) db 0x90;pad so all sectors can be read
;times 1465344-($-$$) db 0x90;pad so all sectors can be read
;b *0x7c6a
;x/512b 0xa601
