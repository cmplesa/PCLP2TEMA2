section .rodata
	global sbox
	global num_rounds
	sbox db 126, 3, 45, 32, 174, 104, 173, 250, 46, 141, 209, 96, 230, 155, 197, 56, 19, 88, 50, 137, 229, 38, 16, 76, 37, 89, 55, 51, 165, 213, 66, 225, 118, 58, 142, 184, 148, 102, 217, 119, 249, 133, 105, 99, 161, 160, 190, 208, 172, 131, 219, 181, 248, 242, 93, 18, 112, 150, 186, 90, 81, 82, 215, 83, 21, 162, 144, 24, 117, 17, 14, 10, 156, 63, 238, 54, 188, 77, 169, 49, 147, 218, 177, 239, 143, 92, 101, 187, 221, 247, 140, 108, 94, 211, 252, 36, 75, 103, 5, 65, 251, 115, 246, 200, 125, 13, 48, 62, 107, 171, 205, 124, 199, 214, 224, 22, 27, 210, 179, 132, 201, 28, 236, 41, 243, 233, 60, 39, 183, 127, 203, 153, 255, 222, 85, 35, 30, 151, 130, 78, 109, 253, 64, 34, 220, 240, 159, 170, 86, 91, 212, 52, 1, 180, 11, 228, 15, 157, 226, 84, 114, 2, 231, 106, 8, 43, 23, 68, 164, 12, 232, 204, 6, 198, 33, 152, 227, 136, 29, 4, 121, 139, 59, 31, 25, 53, 73, 175, 178, 110, 193, 216, 95, 245, 61, 97, 71, 158, 9, 72, 194, 196, 189, 195, 44, 129, 154, 168, 116, 135, 7, 69, 120, 166, 20, 244, 192, 235, 223, 128, 98, 146, 47, 134, 234, 100, 237, 74, 138, 206, 149, 26, 40, 113, 111, 79, 145, 42, 191, 87, 254, 163, 167, 207, 185, 67, 57, 202, 123, 182, 176, 70, 241, 80, 122, 0
	num_rounds dd 10
section .text
	global treyfer_crypt
	global treyfer_dcrypt

; void treyfer_crypt(char text[8], char key[8]);
treyfer_crypt:
     ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov esi, [ebp + 8] ; plaintext
    mov edi, [ebp + 12] ; key
    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
	mov ecx, 0 ; contorul meu
	movzx eax, byte [esi] ; iau primul caracter din text
firstfor:

	mov ebx, 0 ; cu acesta voi tine contorul numarului de byttes
	
cryptround:

	push edi
	add edi, ebx ; adun la cheie valoarea lui ebx
	add al, byte [edi] ; adun la al valoarea din cheie
	pop edi

	push ecx
	lea ecx, [sbox + eax]  ; Load effective address of sbox + eax into ecx
	mov al, byte [ecx]     ; Move byte at address in ecx into al (lower byte of eax)
	mov dl, al             ; Move al into dl
	pop ecx

	push edx
	pop eax

	cmp ebx, 6
	jle normal
	jmp last

last:
	mov dl, byte [esi] ; iau ultimul caracter din text
	add al, dl ; adun la al valoarea din text
	rol al, 1
	mov byte [esi], al ; pun valoarea in text

	add ecx, 1
	cmp ecx, 10
	je ending
	jmp firstfor
normal:
	push esi
	push ebx
	add ebx, 1
	add esi, ebx
	mov dl, byte [esi] ; iau urmatorul caracter din text
	pop ebx
	pop esi

	add al, dl ; adun la al valoarea din text
	rol al, 1

	push esi
	push ebx
	add ebx, 1
	add esi, ebx
	mov byte [esi], al ; pun valoarea in text
	pop ebx
	pop esi
	add ebx, 1
	jmp cryptround
ending:
	xor esi, esi
	xor edi, edi
;; FREESTYLE ENDS HERE
;; DO NOT MODIFY
    popa
    leave
    ret
; void treyfer_dcrypt(char text[8], char key[8]);
treyfer_dcrypt:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;; TODO implement treyfer_dcrypt
	mov esi, [ebp +8]; plaintext 
	mov edi, [ebp+12]; key
	mov ecx, 0; contor runde
secondfor:
	mov ebx, 7; contor nr bytes -> parcurgem invers
dcryptround:
	xor eax, eax
	push esi
	push edi
	add esi, ebx
	add edi, ebx
	mov al, byte [esi]; al are byte ul coresp
	add al, [edi]
	pop edi
	pop esi
	movzx edx, byte [sbox + eax]
	push edx
	pop eax
	cmp ebx, 6
	jle notlast2
	jmp last2
notlast2:
	push esi
	push ebx
	add ebx, 1
	add esi, ebx
	mov dl, byte [esi] ; iau urmatorul caracter din text
	pop ebx
	pop esi
	ror dl, 1; in dl avem bottom
	push ecx
	mov cl, dl
	sub cl, al; in cl avem dl-al
	push esi
	push ebx
	add ebx, 1
	add esi, ebx
	mov byte [esi], cl ; iau urmatorul caracter din text
	pop ebx
	pop esi
	pop ecx
	sub ebx, 1
	cmp ebx, 0
	jl plus_ecx
	jmp dcryptround
last2:
	
	mov dl, byte [esi]
	ror dl, 1
	push ebx
	mov bl, dl
	sub bl, al
	mov byte [esi], bl
	pop ebx
	sub ebx, 1
	jmp dcryptround
plus_ecx:
	add ecx, 1
	cmp ecx, 10 
	je ending2
	jmp secondfor
ending2:
	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	xor esi, esi
	xor edi, edi
	popa
	leave
	ret

