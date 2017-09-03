	bits	64		 ; Recognize 64bits asm
	global	memset:function ; void *memset(void *s, int c, size_t)
	section	.text		 ; Declare section text

memset:
	push	rbp		; Add a element to the stack
	mov	rbp,	rsp	; Create a backup of the status stack
	xor	rcx,	rcx	; Create a counter and init to zero
	cmp	rdi,	0	; check if arg1 is NULL
	je	return_value	; if is NULL go return
	cmp	rdx,	0	; compare arg3 et 0
	jg	loop		; if arg3 > 0 go loop
	jmp	return_value	; else go return_value

loop:
	cmp	rdx,	0	; Check if arg3 == 0
	je	return_value	; if true so go return value
	mov	byte[rdi + rcx], sil 	; arg1[i] = arg2
	dec	rdx		; arg3--
	inc	rcx		; i++
	jmp	loop		; go the loop again

return_value:
	mov	rax,	rdi	; affect ptr to return it
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return (ptr)
