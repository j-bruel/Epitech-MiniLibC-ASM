	bits	64
	global	putnstr:function
	extern	strlen
	section	.text

putnstr:
	push	rbp
	mov	rbp,	rsp
	cmp	rdi,	0
	je	out
	cmp	sil,	0
	Jle	out

check:
	push	rdi
	call	strlen wrt ..plt
	pop	rdi
	mov	r8,	rax
	cmp	rsi,	r8
	jg	bigger
	jmp	lower

bigger:
	mov	r11,	r8
	jmp	print

lower:
	mov	r11,	rsi
	jmp	print

print:
	mov	r10,	rdi
	mov	rax,	1
	mov	rdi,	1
	mov	rsi,	r10
	mov	rdx,	r11
	syscall

out:
	mov	rax,	rdi
	mov	rsp,	rbp
	pop	rbp
	ret
