;RDI, RSI, RDX, RCX, R8, R9 (R10) XMM0, XMM1, XMM2, XMM3, XMM4, XMM5, XMM6 and XMM7 are used for the first floating point arguments.

sys_write equ 1
sys_read equ 0
sys_exit equ 60
stdout equ 1

segment .datai

printInt: db "%d",10,0
printNewline: db 10,0
error db "Not and integer.", 10
errorLen equ $ - error

extern printf

segment .text 
global print_int
global print_nl
global print_string
global read_input
global to_int
global zero_regs


; ###############################################################
; #                                                             #
; # Input: none                                                 #
; # Process: Zeros out all regular registers                    #
; # Ouput: none                                                 #
; #                                                             #
; ###############################################################
zero_regs:
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor r15, r15
    ret


; ###############################################################
; #                                                             #
; # Input: Variable address in RAX before calling               #
; # Process: Reads the input from the Console                   #
; # Ouput: Stores the Console input to the address in RAX       #
; # NOTE: Defaults to a Char                                    #
; #                                                             #
; ###############################################################
read_input:
    mov rsi, rax                ;Variable pointer to RSI
    mov r8, rax                 ;Variable pointer to R8
    mov rax, sys_read           ;Syscall mode in to RAX
    mov rdi, stdout             ;Read from console
    mov rdx, 64                 ;length of the input
    syscall                     ;Make system call, directly it is int 0x80    
    mov byte [r8-1+rax], 0      ;Zero terminate input
    ret


; ###############################################################
; #                                                             #
; # Input: Variable address in RAX before calling               #
; # Process: Converts value at address to an int                #
; # Ouput: Leaves the converted integer in RAX                  #
; #                                                             #
; ###############################################################
to_int:
    mov rcx, rax                ;Move address to rcx for iteration
    xor rax, rax                ;Zero RAX
    mov rbx, 10                 ;Move 10 multiplier to RBX
.ll1:
    movzx rdx, byte [rcx]       ;Move the leftmost non-zero byte into RDX, zero extend
    test rdx, rdx               ;Test if RDX is 0
    jz .done                    ;If zero, jump to .done label
    inc rcx                     ;Increment the address of varibale by one to get next byte
    cmp rdx, '0'                ;Compare RDX to '0' or 0x30
    jb _invalid                 ;If below, not an integer
    cmp rdx, '9'                ;Compare RDX to '9' or 0x39
    ja _invalid                 ;If greater than 0x39, not an integer
    sub rdx, '0'                ;Subtract from '0' ascii value (0x30) to convert to int
                                ;e.g. 0x53 = 5, 0x48 = 0, 53 - 48 = 5.
    add rax, rax                ;Convert to correct place
    lea rax, [rax + rax * 4]    ;e.g. If 56: for the 5... 5+5=10, 10*4+10=50, thus we get the 50
    add rax, rdx                ;Add the next digit that is in RDX to RAX
    jmp .ll1
.done:
    ret


; ###############################################################
; #                                                             #
; # Input: None                                                 #
; # Process: Prints error message                               #
; # Ouput: None                                                 #
; #                                                             #
; ###############################################################
_invalid:
    mov rax, sys_write
    mov rdi, stdout
    mov rsi, error
    mov rdx, errorLen
    syscall
    ret

; ###############################################################
; #                                                             #
; # Input: Data to be printed must be in RAX                    #
; # Process: Prints an Integer                                  #
; # Ouput: None                                                 #
; #                                                             #
; ###############################################################
print_int:
	push rax
	push rsi
	push rdi

    mov rsi, rax                ;Data to be printed, not address
	mov rax, 0x0                ;Zero rax
    lea rdi, printInt           ;Load the format string
    call printf                 ;Call printf

	pop rdi
	pop rsi
	pop rax
	ret

; ###############################################################
; #                                                             #
; # Input: None                                                 #
; # Process: Prints a new line                                  #
; # Ouput: None                                                 #
; #                                                             #
; ###############################################################
print_nl:
	push rax
	push rsi
	push rdi

	mov rsi, printNewline       ;Move the newline format string into RSI
    mov rdx, 1                  ;Place length of newline into RDX
    lea rdi, stdout             ;Print to the console
    mov rax, sys_write          ;Use the write mode
	syscall                     ;Make the syscall, int 0x80

	pop rdi
	pop rsi
	pop rax
	ret


; ###############################################################
; #                                                             #
; # Input: Place string address in RAX before calling           #
; # Input: Place length of string in RDX before calling         #
; # Process: Prints a string                                    #
; # Ouput: None                                                 #
; #                                                             #
; ###############################################################
print_string:
	push rax
	push rsi
	push rdi

	mov rsi, rax
	lea rdi, stdout
    mov rax, sys_write
	syscall

	pop rdi
	pop rsi
	pop rax
	ret

; ###############################################################
; #                                                             #
; # Input: Place char address in RAX before calling             #
; # Process: Prints a Character                                 #
; # Ouput: None                                                 #
; #                                                             #
; ###############################################################
print_char:
	push rax
	push rsi
	push rdi

	mov rsi, rax
	lea rdi, stdout
    mov rax, sys_write
    mov rdx, 1
	syscall

	pop rdi
	pop rsi
	pop rax
	ret
