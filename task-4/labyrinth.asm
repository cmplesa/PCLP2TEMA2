%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss
section .data
    nr_lin dd 0
    nr_col dd 0
    moving dd 0
    compare dd 0

section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
    ;; Freestyle starts here

    push     eax
    push     ebx
    xor      eax, eax
    xor      ebx, ebx

    mov      eax, 0  
    ; line
    mov      ebx, 0   
    ; col
    sub      ecx, 1
    sub      edx, 1
    mov      [nr_lin], ecx
    mov      [nr_col], edx

labyrinth:

    ; ma mut pe ce linie vreau eu, practic e a[i]-> a cata linie de la 4*eax
    lea      edx, [4 * eax]
    add      edx, esi
    mov      edx, dword [edx]
    ; ma mut pe ce coloana vreau eu, practic e a[i][j]
    push     edx
    add      edx, ebx
    movzx    ecx, byte [edx]
    pop      edx

    push     edx
    add      edx, ebx
    mov      byte [edx], '1'
    push     edx
    add      edx, ebx
    movzx    ecx, byte [edx]
    pop      edx
    pop      edx
    
    
    cmp      ebx, [nr_col]
    je out ; aici o sa fac o functie care sa returneze datele de iesire din labirint

    cmp      eax, [nr_lin]
    je out ; aici o sa fac o functie care sa returneze datele de iesire din labirint

    ; acum o sa incep sa fac verificari jos,stanga,dreapta,sus
    xor      ecx, ecx
    xor      edx, edx

right:
    ; daca vreau sa verific in dreapta, raman pe aceeasi linie dar adaug 1 la coloana
    push     ebx
    add      ebx, 1

    lea      edx, [4 * eax]
    add      edx, esi
    mov      edx, dword [edx]
    push     edx
    add      edx, ebx
    movzx    ecx, byte [edx]
    pop      edx
    
    ; compar cu 0, care este 48 in ascii
    cmp      ecx, '0'
    je       m_right
    ; mut la dreapta

    pop      ebx
    jmp      down
    ; sar sa verific la stanga

left:
    ; daca vreau sa verific in stanga, raman pe aceeasi linie dar scad 1 la coloana
    push     ebx
    sub      ebx, 1

    lea      edx, [4 * eax]
    add      edx, esi
    mov      edx, dword [edx]
    push     edx
    add      edx, ebx
    movzx    ecx, byte [edx]
    pop      edx

    ; compar cu 0, care este 48 in ascii
    cmp      ecx, '0'
    je       m_left
    ; mut la stanga

    pop      ebx
    jmp      up
    ; sar sa verific in jos

down:
    ; daca vr sa verific in sus, se scade linia cu 1 si ramna coloana la fel
    push     eax
    add      eax, 1

    ; ca mai sus accesul la matrice
    lea      edx, [4 * eax]
    add      edx, esi
    mov      edx, dword [edx]
    push     edx
    add      edx, ebx
    movzx    ecx, byte [edx]
    pop      edx

    ; compar cu 0, care este 48 in ascii
    cmp      ecx, '0'
    ; daca e 0, ma duc in sus
    je       m_down

    pop      eax
    jmp      left
    ; sar sa verific la dreapta

up:
    ; daca vreau sa verific in jos, adaug 1 la linie si raman pe aceeasi coloana
    push     eax
    sub      eax, 1

    lea      edx, [4 * eax]
    add      edx, esi
    mov      edx, dword [edx]
    push     edx
    add      edx, ebx
    movzx    ecx, byte [edx]
    pop      edx

    cmp      ecx, '0'
    je       m_up

    pop      eax
    jmp      out

m_right:
    pop      ebx
    mov      [moving], ebx
    add      dword [moving], 1
    mov      ebx, [moving]
    jmp      labyrinth

m_up:
    pop      eax
    mov      [moving], eax
    sub      dword [moving], 1
    mov      eax, [moving]
    jmp      labyrinth

m_down:
    pop      eax
    mov      [moving], eax
    add      dword [moving], 1
    mov      eax, [moving]
    jmp      labyrinth

m_left:
    pop      ebx
    mov      [moving], ebx
    sub      dword [moving], 1
    mov      ebx, [moving]
    jmp      labyrinth

out:
    
    mov      edx, eax ; copiez linia din mom iesii in ecx
    mov      ecx, ebx ; copiez coloada din mom iesirii

    pop      eax
    pop      ebx

    mov      [eax], ecx
    mov      [ebx], edx
    ;; Freestyle esnds here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
