 %include "io.inc"

;======================================================================================================================
segment .data 

; Set up prompts-------------------------------------------------------------------------------------------------------
explain db "This is a basic calculator\nYou will enter the first numnber an operator, then a second number", 10, 0
explainlen equ $ - explain

val1prompt db "Enter your first value: ", 0
val1promptlen equ $ - val1prompt

operatorprompt db "Enter the operator: ", 0
operatorpropmtlen equ $ - operatorprompt

val2prompt db "Enter the second value: ", 0
val2promptlen equ $ - val2prompt

;======================================================================================================================
segment .bss 

; Variables for the values and operator--------------------------------------------------------------------------------

val1 resb 32
operator resb 32
val2 resb 32

;======================================================================================================================
segment .text
        global  asm_main

asm_main:
        push	rbp	         ; setup routine
	    
        ;***************CODE STARTS HERE***************************
		
        call initial_setup
        

	
	    ;***************CODE ENDS HERE*****************************
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret

; display initial propmts and gather user input------------------------------------------------------------------------
initial_setup:

    ; Display first prompt-----------------------------------------------------
    mov rax, val1prompt
    mov rdx, val1promptlen
    call print_string

    ; get users first value----------------------------------------------------
    mov rax, val1
    call read_input

    ; convert val1 into int----------------------------------------------------
    mov rax, val1
    call to_int
    mov [val1], rax

    mov rax, [val1]
    call print_int

    ret
    





















