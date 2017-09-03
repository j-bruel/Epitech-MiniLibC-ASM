	bits	64		 	; Recognize 64bits asm
	global	strrchr:function	; char *strchr(const char *, int)
	extern	strlen			; include the strlen fonction
	section	.text			; Declare section text

strrchr:
	push	rbp			; Add a element to the stack
	mov	rbp,	rsp		; Create a backup of the status stack
	xor	rcx,	rcx		; Create a counter and init to zero
	cmp	rdi,	0		; check if arg1 is NULL
	je	null_end		; If is NULL so go return (NULL)

init_counter:
	push	rdi
	call	strlen wrt ..plt
	pop	rdi
	add	rcx,	rax

loop:
	cmp	[rdi + rcx],	sil 	; Compare str[0 + i] == arg2
	je	unnull_end		; if previous instruction is true fo unnull_end
	cmp	rcx,	0		; compare if str[0 + i] == 0
	je	null_end		; if true so go null_end
	dec	rcx			; counter++
	jmp	loop			; go loop again

unnull_end:
	add	rdi,	rcx		; arg1 += counter, increase addr
	mov	rax,	rdi		; cpy the last ptr &arg1[counter]
	mov	rsp,	rbp		; Get back the status stack
	pop	rbp			; Delete the element to the stack
	ret				; return last value return (&arg1[counter]);

null_end:
	mov	rax,	0		; affect NULL for the return value
	mov	rsp,	rbp		; Get back the status stack
	pop	rbp			; Delete the element to the stack
	ret				; return (NULL)
