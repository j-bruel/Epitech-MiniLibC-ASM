	bits	64	     	; Recognize 64bits format
	global _strcspn:function; int strcspn(const char *; const char *)
	section .text		; Declare section text
_strcspn:
	push	rbp		; Add an element to the stack
	mov	rbp,	rsp	; Create a backup of the status stack
	xor	rcx,	rcx	; Create a counter and start to zero
	xor	r15,	r15	; Create a second cout ?
	cmp	rdi,	0	; Check if arg1 is NULL
	je	end_strcspn	; if is NULL quit!
	cmp	rsi,	0	; Check if arg2 is NULL
	je	end_strcspn	; if is NULL quit!

loop:
	cmp	byte[rdi + rcx], 0 ; Compare str[i] == '\0'
	je	end_strcspn	   ; if previous is true jump to end
	jmp	check_args	   ; Jump to check args str2

check_args:
	mov	r8b,	[rdi + rcx]
	mov	r9b,	[rsi + r15]
	cmp	r8b,  	r9b	; Compare str[i] and str2[j];
	je	end_strcspn	; if previous is true jump to end
	cmp	r9b	, 0 ; if rsi[j] == '\0' jump
	je	reset_count	   ; reset counter
	inc 	r15
	jmp	check_args	; Back to previous function

reset_count:
	xor	r15,  r15
	inc	rcx		   ; i++
	jmp  	loop		; back to loop

end_strcspn:

	mov 	rax,	rcx
	mov	rsp,	rbp
	pop	rbp
	ret
