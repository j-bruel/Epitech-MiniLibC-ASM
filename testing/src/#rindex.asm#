	bits	64
	global	_rindex:function ; char	*rindex(const char *, int)
	extern	_strlen		 ; include the strlen fonction
	section	.text		 ; Declare section text

_rindex:
	push	rbp			; Add a element to the stack
	mov	rbp,	rsp		; Create a backup of the status stack
	xor	rcx,	rcx
	cmp	rdi,	0		; Check if arg1 is NULL
	je	error			; if true go is_find (put NULL to value)
	cmp	rdx,	0	  	; Compare arg3, check if <= 0
	jg	end_str			; if true go at end_str
	jmp	error

end_str:
	push	rdi			; Add arg1 on the stack
	call	_strlen	wrt ..plt	; Call the function strlen
	pop	rdi			; Get back the arg1 from the stack
	add	rcx,	rax
	mov	rax,	0		; init value to 0

loop:
	cmp	[rdi + rcx],	sil	; compare arg1[size - i] == arg2
	je	is_find		; if == so go is_find
	cmp	rcx,	0
	je	error
	dec	rcx
	jmp	loop

is_find:
	mov	rax,	rdi	; value = &arg1[size - i]
	add	rax,	rcx
	jmp	out

error:
	mov	rax,	0
	jmp	out

out:
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return (ptr)
