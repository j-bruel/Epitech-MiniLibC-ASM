	bits	64			; Recognize 64 bits asm
	global	_strstr:function	; char *strstr(const char *, const char *);
	section	.text			; Declare section text

_strstr:
	push	rbp		; Add a element to the stack
	mov	rbp,	rsp	; Create a backup of the status stack
	cmp	rdi,	0	; compare arg1 and NULL
	je	error		; go error
	cmp	rsi,	0	; compare arg2 and NULL
	je	error		; go error
	jmp	init_counter	; go init_counter

init_value:
	cmp	r9b,	0	; compare arg1[i] and '\0'
	je	is_not_equal	; if == go is not_equal
	inc	rdi		; arg1++
	jmp	init_counter	; go init_counter

init_counter:
	mov	r9b,	[rsi]	; tmp = arg2[i]
	xor	rcx,	rcx	; init counter to 0
	jmp	loop		; go to loop

loop:
	mov	r9b,	[rdi + rcx]	; tmp = arg1[i]
	mov	r8b,	[rsi + rcx]	; tmp = arg2[i]
	cmp	r8b, 	0		; compare arg2 and '\0'
	je	is_equal		; if == so go is_equal
	cmp	r9b,	r8b		; compare arg1 and arg2
	jne	init_value		; if != go init_value
	inc	rcx			; i++
	jmp	loop			; go loop

is_equal:
	mov	rax,	rdi	; arg1[i] to return value
	jmp	out		; go out

is_not_equal:
	xor	rax,	rax	; put 0 to return value
	jmp	out		; go out

error:
	mov	rax,	0	; return (NULL)
	mov	rsp,	rbp	; get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return (ptr)

out:
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return (ptr)
