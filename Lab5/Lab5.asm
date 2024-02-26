%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 

; Set up welcome prompt--------------------------------------------------------
welcome db "Welcome to the program!", 10, 0
welcomelen equ $ - welcome



; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 
sum1 resb 32
sum2 resb 32




; #######################################################
; #                                                     #
; # Indicate the main method                            #
; #                                                     #
; #######################################################

segment .text
        global  asm_main



; #######################################################
; #                                                     #
; # Do your work here!                                  #
; #                                                     #
; #######################################################

asm_main:
        push	rbp	         ; setup routine
	    
        ;***************CODE STARTS HERE***************************
		
        ; Prints prompt 1------------------------------------------------------
        call print_prompt_1

        ; Rus prep stack and adds----------------------------------------------
        call prep_stack
        mov rax, [sum1]
        call print_int

        ; Runs stack addition--------------------------------------------------
        call stack_addition
        mov rax, [sum2]
        call print_int

        ; Preps and runs incremetal loop and counter---------------------------
        mov rcx, 0
        mov rax, 10
        mov rbx, 0
        call inc_loop
        call print_int

	
	    ;***************CODE ENDS HERE*****************************
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret

; Print out the welcome prompt-------------------------------------------------
print_prompt_1:
    mov rax, welcome
    mov rdx, welcomelen
    call print_string
    ret

; preserves registers using stack----------------------------------------------
prep_stack:
    push rax
    push rbx
    push rcx
    push rdx

    call do_addition

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

; adds numbers together--------------------------------------------------------
do_addition:
    mov rax, 3
    mov rbx, 5
    add rax, rbx
    mov [sum1], rax

; use stack for math-----------------------------------------------------------
stack_addition:
    push 5
    push 4
    push 3
    push 2
    
    pop rax
    pop rbx
    add rax, rbx
    pop rbx
    add rax, rbx
    pop rbx
    add rax, rbx

    mov [sum2], rax
    ret

; Print iterations of loop-----------------------------------------------------
inc_loop:
    push rcx
    
    add rbx, rcx    

    pop rcx
    mov rax, 10

    inc rcx
    cmp rax, rcx
    jg inc_loop
    mov rax, rbx
    ret

























