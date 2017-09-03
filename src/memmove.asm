	bits	64		  ; Recognize 64bits asm
	global	memmove:function ; void *memmove(void *, const void *, size_t)
	section	.text		  ; Declare section text

memmove:
	push	rbp		; Add a element to the stack
	mov	rbp,    rsp	; Create a backup of the status stack
	xor	rcx,	rcx	; Create a counter and init to zero
	cmp	rdi,    0	; check if arg1 is NULL
	je	out		; if is NULL go return
	cmp	rsi,	0	; check if arg2 is NULL
	je	out		; if is NULL go return
	mov	rax,	rdi	; cpy arg1 to return val
	mov	r8,	rdi	; cpy to tmp arg1
	sub	r8,	rsi	; tmp -= arg2
	cmp	r8,	0	; compare arg1 - arg2 et 0
	jge	overlap		; if >= go overlap

loop:
	cmp	rdx,	rcx	   	; Compare i == arg3
	je 	out			; if true so go return_value
	mov	r8b,	[rsi + rcx] 	; cpy arg2[i] in tmp register
	mov	[rdi + rcx],	r8b 	; cpy tmp register to arg1[i]
	inc	rcx		    	; i++
	jmp	loop		    	; go loop again

overlap:
	dec	rdx			; arg3--
	jmp	overlap_loop		; go overlap_loop

overlap_loop:
	cmp	rdx,	0
	jl	out
	mov	r8b,	[rsi + rdx]
	mov	[rdi + rdx],	r8b
	dec	rdx
	jmp	overlap_loop

out:
	mov	rax,	rdi	; affect ptr to return it
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret 			; return (ptr)
