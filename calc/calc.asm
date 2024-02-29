 %include "io.inc"

;======================================================================================================================
segment .data 

; Set up prompts-------------------------------------------------------------------------------------------------------
explain db "This is a basic calculator\nYou will enter the first numnber an operator, then a second number", 10, 0
explainlen equ $ - explain

val1prompt db "Enter your first value: ", 0
val1promptlen equ $ - val1prompt

operatorprompt db "Enter the operator: ", 0
operatorpromptlen equ $ - operatorprompt

val2prompt db "Enter the second value: ", 0
val2promptlen equ $ - val2prompt

;======================================================================================================================
segment .bss 

; Variables for the values and operator--------------------------------------------------------------------------------

val1 resb 32
operator resb 32
val2 resb 32
total resb 32

;======================================================================================================================
segment .text
        global  asm_main

asm_main:
        push	rbp	         ; setup routine
	    
        ;***************CODE STARTS HERE***************************
		
        call initial_setup

        mov rax, [val1]
        call print_int

        mov rax, [val2]
        call print_int
        
        call check_operator

        mov rax, [total]
        call print_int

	
	    ;***************CODE ENDS HERE*****************************
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret

; display initial propmts and gather user input------------------------------------------------------------------------
initial_setup:

    ; First value--------------------------------------------------------------
    ; Display first prompt---------------------------------
    mov rax, val1prompt
    mov rdx, val1promptlen
    call print_string

    ; get users first value--------------------------------
    mov rax, val1
    call read_input

    ; convert val1 into int--------------------------------
    mov rax, val1
    call to_int
    mov [val1], rax

    ; operator value-----------------------------------------------------------
    ; Display operator prompt--------------------------------
    mov rax, operatorprompt
    mov rdx, operatorpromptlen
    call print_string

    ; get users operator value-------------------------------
    mov rax, operator
    call read_input

    ; Second value-------------------------------------------------------------
    ; Display second prompt--------------------------------
    mov rax, val2prompt
    mov rdx, val2promptlen
    call print_string

    ; get users second value-------------------------------
    mov rax, val2
    call read_input

    ; convert val2 into int--------------------------------
    mov rax, val2
    call to_int
    mov [val2], rax

    ret
    
; Checks what operator the user used and jumps to respective procedure-------------------------------------------------
check_operator:
    mov rax, [operator]
    cmp rax, '+'
    jz add_input
    cmp rax, '-'
    jz sub_input
    cmp rax, '*'
    jz mult_input
    cmp rax, '/'
    jz div_input
    
    ret

; adds the user inputs together----------------------------------------------------------------------------------------
add_input:
    mov rax, [val1]
    add rax, [val2]
    mov [total], rax

    
    
    ret

; subtracts the user inputs together-----------------------------------------------------------------------------------
sub_input:
    mov rax, [val1]
    sub rax, [val2]
    mov [total], rax

    ret

; mutliplies the user inputs together----------------------------------------------------------------------------------
mult_input:
    mov rax, [val1]
    mov rcx, [val2]
    mul rcx
    mov [total], rax

    ret

; divides the user inputs together-------------------------------------------------------------------------------------
div_input:
    mov rax, [val1]
    mov rcx, [val2]
    div rcx
    mov [total], rax

    ret



















