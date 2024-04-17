%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 

;--------User Input Prompt-----------------------------------------------------
input1prompt db "Enter the first number: ", 0
input1promptlen equ $ - input1prompt




; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 
;--------User Input Variable---------------------------------------------------
input1 resb 32




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
		
        

	
	    ;***************CODE ENDS HERE*****************************










done:
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret



;--------Take user input-------------------------------------------------------

get_input1:
    ; Create a new stack for the method--------------------
    push rbp
    mov rbp, rsp

    ; Pull in the arguments that had been puched-----------
    mov rbx, [rbp+16] ; Storage Variable Address
    mov rdx, [rbp+24] ; Length of the prompt
    mov rax, [rbp+32] ; prompt string to be printed out

    ; Print out the prmpt----------------------------------
    call print_string

    mov rax, rbx
    call read_input
    mov, 

    ; Exit the method by removing the new stack------------
    mov rsp, rbp
    pop rbp
    ret

























