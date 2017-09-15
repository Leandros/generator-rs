.code

prefetch_asm PROC FRAME
    .endprolog
    prefetcht1 [rcx]
    ret
prefetch_asm ENDP


bootstrap_green_task PROC FRAME
    .endprolog
    mov rcx, r12     ; setup the function arg
    mov rdx, r13     ; setup the function arg
    mov [rsp+8], r14 ; this is the new return adrress
    ret
bootstrap_green_task ENDP


swap_registers PROC FRAME
    .endprolog
    mov [rcx + 0*8], rbx
    mov [rcx + 1*8], rsp
    mov [rcx + 2*8], rbp
    mov [rcx + 4*8], r12
    mov [rcx + 5*8], r13
    mov [rcx + 6*8], r14
    mov [rcx + 7*8], r15
    mov [rcx + 9*8], rdi
    mov [rcx + 10*8], rsi

    ; Save non-volatile XMM registers:
    movapd [rcx + 16*8], xmm6
    movapd [rcx + 18*8], xmm7

    ; load NT_TIB
    mov r10, gs:[030h]
    ; save current stack base
    mov rax, [r10 + 08h]
    mov [rcx + 11*8],  rax
    ; save current stack limit
    mov rax,  [r10 + 010h]
    mov [rcx + 12*8], rax
    ; save current deallocation stack
    mov rax, [r10 + 01478h]
    mov [rcx + 13*8], rax
    ; save fiber local storage
    ; mov rax, [r10 + 0x18]
    ; mov [rcx + 14*8], rax

    mov [rcx + 3*8], rcx

    mov rbx, [rdx + 0*8]
    mov rsp, [rdx + 1*8]
    mov rbp, [rdx + 2*8]
    mov r12, [rdx + 4*8]
    mov r13, [rdx + 5*8]
    mov r14, [rdx + 6*8]
    mov r15, [rdx + 7*8]
    mov rdi, [rdx + 9*8]
    mov rsi, [rdx + 10*8]

    ; Restore non-volatile XMM registers:
    movapd xmm6, [rdx + 16*8]
    movapd xmm7, [rdx + 18*8]

    ; load NT_TIB
    mov r10, gs:[030h]
    ; restore fiber local storage
    ; mov [rdx + 14*8], rax
    ; movq rax, [r10 + 0x18]
    ; restore deallocation stack
    mov rax, [rdx + 13*8]
    mov [r10 + 01478h], rax
    ; restore stack limit
    mov rax, [rdx + 12*8]
    mov [r10 + 010h], rax
    ; restore stack base
    mov rax, [rdx + 11*8]
    mov [r10 + 08h], rax

    mov rcx, [rdx + 3*8]
    ret
swap_registers ENDP

END

