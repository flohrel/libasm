; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = file descriptor
;			RSI = address of string
;			RDX = size of string
; Outputs:	RAX = return value (-1 if error, else number of bytes printed)
; Clobbers:	<none>

	extern	__errno_location
	global	ft_write

ft_write:
	mov		rax, 1						;; system call 1 = write
	syscall
	cmp		rax, 0						;; check write return value
	jl		error						;; jump to error if negative
	ret									;; else return

error:
	neg		rax							;; get absolute value of syscall return
	mov		rdi, rax					;; pass value as 1st parameter
	call	__errno_location wrt ..plt	;; get errno pointer
	mov		[rax], rdi					;; set errno
	mov		rax, -1						;; set write return value to -1
	ret
