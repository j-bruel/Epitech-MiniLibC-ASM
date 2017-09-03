	bits	64			; Recognize 64bits asm
	global	_strcasecmp:function	; int strcasecmp(const char *, const char *);
	section	.text			; Declare section text

_strcasecmp:
	push	rbp		; Add a element to the stack
	mov	rbp,	rsp	; Create a backup of the status stack
	xor	rcx,	rcx	; Create a couter and init to zero
	cmp	rdi,	0	; compare arg1 and NULL
	je	out		; if true so  go out
	cmp	rsi,	0	; Compare arg2 and NULL
	je	out		; if true so go out
	jmp 	compare1	; else go compare1

compare1:
	mov	r8b,	[rdi + rcx] ; cpy in tmp arg1[i]
	cmp	r8b,	65	    ; compare arg1[i] and 'A'
	jl	compare2	    ; if arg1[i] < 'A'
	cmp	r8b,	90	    ; compare arg1[i] and 'Z'
	jl	islower1	    ; if 'A' < arg1[i] < 'Z'

compare2:
	mov	r9b,	[rsi + rcx] ; cpy in tmp arg2[i]
	cmp	r9b,	65	    ; compare arg2[i] and 'A'
	jl	comparef	    ; if arg2[i] < 'A'
	cmp	r9b,	90	    ; compare arg2[i] and 'Z'
	jl	islower2	    ; if 'A' < arg2[i] < 'Z'

comparef:
	cmp	r8b,	r9b	; compare arg1[i] and arg2[i]
	jne	out		; if arg1[i] != arg[i]
	cmp	r8b,	0	; compare arg1[i] and '\0'
	je	out		; if true go out
	cmp	r9b,	0	; compare arg2[i] and '\0'
	je	out		; if true go out
	inc	rcx		; i++
	jmp	compare1	; go compare1

islower1:
	add     r8b,    32	; arg1[i] += 32
	jmp     compare2	; go compare2

islower2:
	add     r9b,    32	; arg2[i] += 32
	jmp     comparef	; go comparef

out:
	sub	r8b,	r9b	; arg1[i] -= arg2[i]
	movsx	rax,	r8b	; get the sign value
	mov	rsp,	rbp	; Get back the status stack
	pop	rbp		; Delete the element to the stack
	ret			; return
