	bits	64		; 64 bits
	global	_index:function	; char*index(const char *, int)
	section	.text		; Declare section text

_index:
	push	rbp			; Add a element to the stack
	mov	rbp,	rsp		; Create a backup of the status stack
	cmp	rdi,	0		; Check if arg1 is NULL
	je	error			; if true go error
	cmp	sil,	0	  	; Compare arg2, check if <= 0
	jle	error			; if true go error
	jmp	loop			; go loop

loop:
	mov	r8b,	byte[rdi] 	; tmp = arg1[i]
	mov	r9b,	sil		; tmp = arg2
	cmp	r8b,	r9b		; compare arg1[i] == arg2
	je	out			; if == so go out
	cmp	r8b,	0		; compare arg1[size]
	je	error			; if == so go error
	inc	rdi			; arg1++
	jmp	loop			; go loop again

error:
	mov	rax,	0	; return (NULL);
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return

out:
	mov	rax,	rdi	; value = &arg1[size - i]
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return (ptr)
