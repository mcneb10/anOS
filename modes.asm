cr0s:
    dd 0
enter_protected:
    cli;disable interrupts
    mov eax, cr0;load cr0 into eax so we can work with it
    mov [cr0s], eax;save cr0 for when we want to go back
    or al, 1;set pe (proctected mode enable)
    mov cr0, eax
    call _setupidt
    mov eax, _idt_reg
    lidt eax
    ret

exit_protected:
    mov eax, [cr0s]
    mov cr0, eax
    sti
    ret