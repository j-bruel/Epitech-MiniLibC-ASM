	bits	64
	global	putstr:function
	extern	_strlen
	section	.text

putstr:
	push	rbp
	mov	rbp,	rsp
	cmp	rdi,	0
	je	out

check:
	push	rdi
	call	_strlen wrt ..plt
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
	mov	rax,	rdi
	mov	rsp,	rbp
	pop	rbp
	ret
