; find program based on its filename
;(pointer to null terminated string stored in bx)
; then jump to its adress
runprog:
	pusha;save all registers
	mov di, 0x119;beginning of bootsector
findloop:
	cmp di, 0x2815;end of bootsector
	jg rpdone
	mov si, 0
compareloop:
	mov ax, [di+si]
	cmp [bx+si], ax;compare
	jne next;not the right file, go to the next one
	cmp si, 20
	je found;file found!
	add si,2
	jmp compareloop;loop
next:
	add di, 20
	jmp findloop
found:
	
rpdone:
	popa;restore all registers
	ret;return