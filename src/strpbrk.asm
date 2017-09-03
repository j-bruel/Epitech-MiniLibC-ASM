	bits	64			; Recognize 64 bits format
	global	strpbrk:function	; char *strpbrk(const char *, const char *);
	section	.text			; Declare section text

strpbrk:
	push    rbp		; Add and element to the stack
	mov     rbp,    rsp 	; Create a backup of the status stack
	xor     rcx,    rcx 	; Create a counter and init to 0
	cmp     rdi,    0 	; Compare arg1 and NULL
	je      error		; if == go out
	cmp     rsi,    0 	; arg2 and NULL
	je      error		; if == go out

loop:
	xor     r10,    r10 	; Create a counter and init to 0
	cmp     byte[rdi + rcx], 0	; compare arg1[i] and '\0'
	je      error		  	; if == go error
	cmp	byte[rsi + r10], 0	; compare arg2[i] and '\0'
	je 	error		  	; if == go error
	mov     r8b, byte[rdi + rcx]	; tmp = arg1[i]
	mov     r9b, byte[rsi + r10]	; tmp = arg2[i]
	cmp     r9b,    0		; compare arg2 and '\0'
	je      out			; if == go out
	cmp     r8b,    0		; compare arg1 and '\0'
	je     	out			; if == go out

check_loop:
	cmp	byte[rsi + r10], 0
	je	go_loop
	cmp	r8b,	byte[rsi + r10]
	je	out
	inc	r10
	jmp	check_loop

go_loop:
	inc	rdi
	jmp	loop

error:
	mov     rax,    0	; return (NULL)
	mov     rsp,    rbp	; Get back the status stack
	pop     rbp		; delete the element to the stack
	ret			; return

out:
	mov     rax,    rdi	; return (arg1[i]);
	mov     rsp,    rbp	; Get back the status stack
	pop     rbp		; Delete the element to the stack
	ret			; return
