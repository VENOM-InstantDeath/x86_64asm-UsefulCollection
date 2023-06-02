section .data
	NEWLINE db 0xA
section .text
_print: 			;; print a null-terminated string (rsi,r10)
	mov rax,0
	call _loop
	mov rdx,rax
	mov rax,1
	mov rdi,1
	sub rsi,rdx
	syscall
	cmp r10,1
	jne _ret
	mov rax,1
	mov rdi,1
	mov rsi,NEWLINE
	mov rdx,1
	syscall
	ret
_loop:
	cmp byte [rsi], 0
	je _ret
	inc rax
	inc rsi
	jmp _loop
