	bits	64		 ;  Recognize 64bits asm
	global	memcpy:function ; void *memcpy(void *, const void *, size_t)
	section	.text		 ; Declare section text

memcpy:
	push	rbp		; Add a element to the stack
	mov	rbp,    rsp	; Create a backup of the status stack
	xor	rcx,	rcx	; Create a counter and init to zero
	cmp	rdi,    0	; check if arg1 is NULL
	je	return_value	; if is NULL go return
	cmp	rsi,	0	; check if arg2 is NULL
	je	return_value	; if is NULL go return
	cmp     rdx,    0	; compare arg3 et 0
	jg	loop		; if arg3 > 0 go loop
	jmp	return_value	; else go return_value

loop:
	cmp	byte[rsi + rcx], 0 	; Compare arg2[i] == 0
	je	return_value	   	; If true so go return_value
	cmp	rdx,	rcx	   	; Compare i == arg3
	je 	return_value	   	; if true so go return_value
	mov	r8b,	[rsi + rcx] 	; cpy arg2[i] in tmp register
	mov	[rdi + rcx],	r8b 	; cpy tmp register to arg1[i]
	inc	rcx		    	; i++
	jmp	loop		    	; go loop again

return_value:
	mov	rax,	rdi	; affect ptr to return it
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret 			; return (ptr)
