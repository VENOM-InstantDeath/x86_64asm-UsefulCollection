section .data
	c db 1
section .text
	global _start
_chomp: 			;; Replace \n with null terminator (rsi)
	mov r10,0 		;; Number of loops
	call __chomp
	sub rsi,r10
	mov rax,rsi
	ret
__chomp:
	cmp byte [rsi], 0
	je _ret
	cmp byte [rsi], 10
	je __chomp_ovw
	inc r10
	inc rsi
	jmp __chomp
__chomp_ovw:
	mov byte [rsi],0
	ret

_read: 				;; Read n chars from stdin (rsi,rdx)
	mov rax,0
	mov rdi,0
	sub rdx,1
	syscall 		;; read(0, buff)
	add rsi,rdx 		;; rsi += strlen(rsi)-1
	mov byte [rsi], 0 	;; Add null byte at the end
	sub rsi,rdx 		;; rsi -= strlen(rsi)-1
	push rsi
	call _discinp 		;; _discinp()
	pop rsi
	call _chomp 		;; _chomp(rsi, rdx)
	ret

_discinp: 			;; Discard input ()
	mov rax,72
	mov rdi,0
	mov rsi,3
	syscall 		;; fcntl(0, F_GETFL)
	mov rcx,rax
	mov r9,2048
	or rcx,r9
	mov rax,72
	mov rdi,0
	mov rsi,4
	mov rdx,rcx
	syscall 		;; fcntl(0, F_SETFL, flags | O_NONBLOCK)
	mov rax,0
	mov rdi,0
	mov rsi,c 
	mov rdx,1
	syscall 		;; getchar()
	cmp rax,0
	jle _ret
	cmp byte [c],10 	;; *c == 10
	jne _discinp
	ret
