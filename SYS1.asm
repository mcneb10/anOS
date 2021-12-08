global _vidIndex
_vidIndex:
db 0,0,0,0
global _strlen
_strlen:
push	ebp
mov	ebp, esp
sub	esp, 16
mov	DWORD [ebp-4], 0
nop
.L2:
mov	eax, DWORD [ebp-4]
lea	edx, [eax+1]
mov	DWORD [ebp-4], edx
mov	edx, eax
mov	eax, DWORD [ebp+8]
add	eax, edx
movzx	eax, BYTE [eax]
test	al, al
jne .L2
mov	eax, DWORD [ebp-4]
leave
ret
global _println
_println:
push	ebp
mov	ebp, esp
sub	esp, 16
mov	DWORD [ebp-8], 753664
mov	DWORD [ebp-4], 0
jmp .L5
.L6:
mov	edx, DWORD [ebp-4]
mov	eax, DWORD [ebp+8]
add	eax, edx
mov	ecx, DWORD _vidIndex
mov	edx, DWORD [ebp-4]
add	edx, ecx
mov	ecx, edx
mov	edx, DWORD [ebp-8]
add	edx, ecx
movzx	eax, BYTE [eax]
mov	BYTE [edx], al
add	DWORD [ebp-4], 2
.L5:
mov	edx, DWORD [ebp-4]
mov	eax, DWORD [ebp+8]
add	eax, edx
movzx	eax, BYTE [eax]
test	al, al
jne .L6
nop
nop
leave
ret
global _in
_in:
push	ebp
mov	ebp, esp
sub	esp, 20
mov	eax, DWORD [ebp+8]
mov	WORD [ebp-20], ax
movzx	eax, WORD [ebp-20]
mov	edx, eax
;/APP
; 20 "SYS1.c" 1
in al, dx
; 0 "" 2
;/NO_APP
mov	BYTE [ebp-1], al
movzx	eax, BYTE [ebp-1]
leave
ret
global _out
_out:
push	ebp
mov	ebp, esp
sub	esp, 8
mov	eax, DWORD [ebp+8]
mov	edx, DWORD [ebp+12]
mov	WORD [ebp-4], ax
mov	eax, edx
mov	BYTE [ebp-8], al
movzx	edx, WORD [ebp-4]
movzx	eax, BYTE [ebp-8]
;/APP
; 29 "SYS1.c" 1
out dx, al
; 0 "" 2
;/NO_APP
nop
leave
ret
global _itoa
_itoa:
push	ebp
mov	ebp, esp
push	ebx
sub	esp, 32
mov	DWORD [ebp-23], 858927408
mov	DWORD [ebp-19], 926299444
mov	WORD [ebp-15], 14648
mov	BYTE [ebp-13], 0
mov	eax, DWORD [ebp+12]
mov	DWORD [ebp-8], eax
cmp	DWORD [ebp+8], 0
jns .L11
mov	eax, DWORD [ebp-8]
lea	edx, [eax+1]
mov	DWORD [ebp-8], edx
mov	BYTE [eax], 45
neg	DWORD [ebp+8]
.L11:
mov	eax, DWORD [ebp+8]
mov	DWORD [ebp-12], eax
.L12:
add	DWORD [ebp-8], 1
mov	ecx, DWORD [ebp-12]
mov	edx, 1717986919
mov	eax, ecx
imul	edx
mov	eax, edx
sar	eax, 2
sar	ecx, 31
mov	edx, ecx
sub	eax, edx
mov	DWORD [ebp-12], eax
cmp	DWORD [ebp-12], 0
jne .L12
mov	eax, DWORD [ebp-8]
mov	BYTE [eax], 0
.L13:
mov	ecx, DWORD [ebp+8]
mov	edx, 1717986919
mov	eax, ecx
imul	edx
mov	eax, edx
sar	eax, 2
mov	ebx, ecx
sar	ebx, 31
sub	eax, ebx
mov	edx, eax
mov	eax, edx
sal	eax, 2
add	eax, edx
add	eax, eax
sub	ecx, eax
mov	edx, ecx
sub	DWORD [ebp-8], 1
movzx	edx, BYTE [ebp-23+edx]
mov	eax, DWORD [ebp-8]
mov	BYTE [eax], dl
mov	ecx, DWORD [ebp+8]
mov	edx, 1717986919
mov	eax, ecx
imul	edx
mov	eax, edx
sar	eax, 2
sar	ecx, 31
mov	edx, ecx
sub	eax, edx
mov	DWORD [ebp+8], eax
cmp	DWORD [ebp+8], 0
jne .L13
mov	eax, DWORD [ebp+12]
mov	ebx, DWORD [ebp-4]
leave
ret
LC0:
db 'Hello from C!',0
global _SYS1ENTRY
_SYS1ENTRY:
push	ebp
mov	ebp, esp
sub	esp, 20
mov	DWORD [ebp-4], LC0
mov	DWORD [ebp-8], 753664
mov	eax, DWORD [ebp-8]
mov	BYTE [eax], 98
;/APP
; 99 "SYS1.c" 1
cli
; 0 "" 2
;/NO_APP
mov	eax, DWORD [ebp-8]
add	eax, 10
mov	BYTE [eax], 91
;/APP
; 101 "SYS1.c" 1
jmp $
; 0 "" 2
;/NO_APP
mov	eax, DWORD [ebp-4]
mov	DWORD [esp], eax
call	_strlen
lea	edx, [eax+32]
mov	eax, DWORD [ebp-8]
add	eax, 2
mov	BYTE [eax], dl
.L16:
jmp .L16
