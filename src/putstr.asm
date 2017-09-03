	bits	64
	global	putstr:function
	extern	strlen
	section	.text

putstr:
	push	rbp
	mov	rbp,	rsp
	cmp	rdi,	0
	je	out

check:
	push	rdi
	call	strlen wrt ..plt
	pop	rdi
	mov	r8,	rax

print:
	mov	r10,	rdi
	mov	rax,	1
	mov	rdi,	1
	mov	rsi,	r10
	mov	rdx,	r8
	syscall

out:
	inc	r8
	mov	rax,	r8
	mov	rsp,	rbp
	pop	rbp
	ret
