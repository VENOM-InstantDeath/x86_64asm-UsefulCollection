_strlen: 			;; String length (rsi)
	mov rcx,0
	call __strlen
	sub rsi,rcx
	mov rax,rcx
	ret
__strlen:
	cmp byte [rsi],0
	je _ret
	inc rsi
	inc rcx
	jmp __strlen
