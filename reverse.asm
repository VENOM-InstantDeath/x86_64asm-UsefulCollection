_reverse: 			;; (rsi, r10)
	mov rdx,0
	mov rax,r10
	mov r11,2
	div r11
	mov r11,rax
	mov rcx,0
	call __reverse
	sub rsi,rcx
	mov rax,rsi
	ret
__reverse:
	cmp rcx,r11
	je _ret
	mov r9b, byte [rsi]
	mov r8, rsi
	add r8, r10
	dec r8
	mov rax,2
	mul rcx
	sub r8, rax
	mov dil, byte [r8]
	mov byte [rsi], dil
	mov byte [r8], r9b
	inc rsi
	inc rcx
	jmp __reverse
