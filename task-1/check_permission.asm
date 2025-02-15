%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text


check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    push    eax
    shr     eax, 24
    mov     edx, dword [ant_permissions + eax*4]  
    pop     eax
    
    push    eax
    and     eax, 0xFFFFFF
    mov     ecx, eax
    pop     eax
    
    push    eax
    mov     eax, edx
    and     eax, ecx
    mov     edx, eax
    pop     eax
    cmp     edx, ecx
    mov     edx, 1
    je     result
    mov     edx, 0

result:
    mov     [ebx], edx
    
    ;; Your code ends here

permission_done:
    popa
    leave
    ret
    
    ;; DO NOT MODIFY
