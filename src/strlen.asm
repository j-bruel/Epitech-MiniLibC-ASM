	bits	64		 ; Recognize 64bits asm
	global	strlen:function ; int strlen(const char *)
	section	.text		 ; Declare section text

strlen:
	push	rbp		; Add a element to the stack
	mov	rbp,	rsp	; Create a backup of the status stack
	xor	rcx,	rcx	; Create a counter and start to zero
	cmp	rdi,	0	; Check if arg1 is NULL
	je	out		; if is NULL so quit

loop:
	cmp	byte[rdi + rcx], 0	; Compare str[i] == '\0'
	je	out			; If previous instruction is true so go func
	inc	rcx			; increment counter
	jmp	loop			; jump to loop function

out:
	mov	rax,	rcx	; Cpy counter value to the accumulateur
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return last value on the stack
