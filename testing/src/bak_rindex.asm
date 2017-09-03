	bits	64
	global	_rindex:function ; char	*rindex(const char *, int)
	extern	_strlen		 ; include the strlen fonction
	section	.text		 ; Declare section text

_rindex:
	push	rbp			; Add a element to the stack
	mov	rbp,	rsp		; Create a backup of the status stack
	cmp	rdi,	0		; Check if arg1 is NULL
	je	error			; if true go is_find (put NULL to value)
	cmp	rdx,	0	  	; Compare arg3, check if <= 0
	jg	end_str			; if true go at end_str
	jmp	error

end_str:
	push	rdi			; Add arg1 on the stack
	call	_strlen	wrt ..plt	; Call the function strlen
	pop	rdi			; Get back the arg1 from the stack
	mov	r8,	rdi		; Create tmp = arg1
	add	rdi,	rax		; arg1 += strlen(arg1)
	mov	rax,	0		; init value to 0

loop:
	cmp	byte[rdi],	sil	; compare arg1[size - i] == arg2
	je	is_find		; if == so go is_find
	cmp	rdi,	r8	; compare &arg1[size - i] and &arg1[i]
	je	error		; if == so go out
	dec	rdi		; &arg1[size]--
	jmp	loop		; go loop again

is_find:
	mov	rax,	rdi	; value = &arg1[size - i]
	jmp	out

error:
	mov	rax,	0

out:
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return (ptr)
