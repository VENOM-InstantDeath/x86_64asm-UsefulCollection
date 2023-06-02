%include "reverse.asm"
%include "strlen.asm"
_itoa: 				;; Int to String (rsi, r10)
	mov r9,0
	mov rax,rsi
	mov rcx,0
	call __itoa
	sub r10,r9
	mov rsi,r10
	call _strlen
	mov r10,rax
	call _reverse
	ret
__itoa:
	mov rdx,0
	mov rcx,10
	div rcx
	add rdx,48
	mov [r10],rdx
	cmp rax,0
	je _ret
	inc r10
	inc r9
	jmp __itoa
