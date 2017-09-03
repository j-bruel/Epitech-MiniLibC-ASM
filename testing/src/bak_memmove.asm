	bits	64		  ; Recognize 64bits asm
	global	_memmove:function ; void *memmove(void *, const void *, size_t)
	section	.text		  ; Declare section text

_memmove:
	push	rbp		; Add a element to the stack
	mov	rbp,    rsp	; Create a backup of the status stack
	xor	rcx,	rcx	; Create a counter and init to zero
	cmp	rdi,    0	; check if arg1 is NULL
	je	out		; if is NULL go return
	cmp	rsi,	0	; check if arg2 is NULL
	je	out		; if is NULL go return
	cmp     rdx,    0	; compare arg3 et 0
	jg	loop		; if arg3 > 0 go loop
	cmp	rdi,	rsi	; if arg1 == arg2
	je	out		; so go out
	jmp	loop2		; else go return_value

loop:
	cmp	rdx,	rcx	   	; Compare i == arg3
	je 	out			; if true so go return_value
	mov	r8b,	[rsi + rcx] 	; cpy arg2[i] in tmp register
	mov	[rdi + rcx],	r8b 	; cpy tmp register to arg1[i]
	inc	rcx		    	; i++
	jmp	loop		    	; go loop again

loop2:
	cmp	rdx,	0
	jl	out
	mov	r8b,	[rsi + rdx]
	mov	[rdi + rdx],	r8b
	dec	rdx
	jmp	loop2

out:
	mov	rax,	rdi	; affect ptr to return it
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret 			; return (ptr)
