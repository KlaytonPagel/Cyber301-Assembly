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

input2prompt db "Enter the second number: ", 0
input2promptlen equ $ - input2prompt

input3prompt db "Enter the third number: ", 0
input3promptlen equ $ - input3prompt

;--------Min and Max prompts---------------------------------------------------
minprompt db "The minimum value is: ", 0
minpromptlen equ $ - minprompt

maxprompt db "The maximum value is: ", 0
maxpromptlen equ $ - maxprompt




; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 
;--------User Input Variable---------------------------------------------------
input1 resb 32
input2 resb 32
input3 resb 32

;--------Variables for the min and max number----------------------------------
MIN resb 32
MAX resb 32




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
		
        push input1prompt
        push input1promptlen
        push input1
        call readUserInput
        add rsp, 3*8

        push input2prompt
        push input2promptlen
        push input2
        call readUserInput
        add rsp, 3*8

        push input3prompt
        push input3promptlen
        push input3
        call readUserInput
        add rsp, 3*8

        push qword [input1]
        push qword [input2]
        push qword [input3]
        call sortNums
        add rsp, 3*8

        mov rax, [input1]
        call print_int
        mov rax, [input2]
        call print_int
        mov rax, [input3]
        call print_int

        call printVars

	
	    ;***************CODE ENDS HERE*****************************










done:
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret



;--------Take user input-------------------------------------------------------

readUserInput:
    ; Create a new stack for the method--------------------
    push rbp
    mov rbp, rsp

    ; Pull in the arguments that had been puched-----------
    mov rbx, [rbp+16] ; Storage Variable Address
    mov rdx, [rbp+24] ; Length of the prompt
    mov rax, [rbp+32] ; prompt string to be printed out

    ; Print out the prompt---------------------------------
    call print_string

    ; Capture User Input-----------------------------------
    mov rax, rbx
    call read_input
    mov rax, rbx

    ; Convert user input to an integer---------------------
    call to_int 
    mov rbx, [rbp+16]
    mov [rbx], rax

    ; Exit the method by removing the new stack------------
    mov rsp, rbp
    pop rbp
    ret

;--------Sorts the numbers-----------------------------------------------------

sortNums:
    ; Create a new stack for the method--------------------
    push rbp
    mov rbp, rsp

    ; Pull in the arguments that had been puched-----------
    mov rcx, [rbp+16] ; input 3
    mov rbx, [rbp+24] ; input 2
    mov rax, [rbp+32] ; input 1

    ; Check if RBX is less than RAX------------------------
    cmp rax, rbx
    jl swap1
    jmp pt2

    ; swap RAX, and RBX------------------------------------
    swap1:
        mov rdx, rax
        mov rax, rbx
        mov rbx, rdx
        jmp pt2

    ; check if RCX is less than RAX------------------------
    pt2:
        cmp rax, rcx
        jl swap2
        jmp pt3

    ; swap RCX and RAX-------------------------------------
    swap2:
        mov rdx, rax
        mov rax, rcx
        mov rcx, rdx
        jmp pt3

    ; check if RCX is less than RBX------------------------
    pt3:
        cmp rbx, rcx
        jl swap3
        jmp end
    
    ; swap RCX and RBX-------------------------------------
    swap3:
        mov rdx, rcx
        mov rcx, rbx
        mov rbx, rdx

    ; set values to variables------------------------------
    end:
        mov [MAX], rax
        mov [MIN], RCX

    ; Exit the method by removing the new stack------------
    mov rsp, rbp
    pop rbp
    ret

;--------Print Min and Max nums------------------------------------------------

printVars:
    ; Create a new stack for the method--------------------
    push rbp
    mov rbp, rsp

    ; print out max prompt-------------
    mov rax, maxprompt
    mov rdx, maxpromptlen
    call print_string
    
    ; print out max num----------------
    mov rax, [MAX]
    call print_int

    ; print out min prompt-------------
    mov rax, minprompt
    mov rdx, minpromptlen
    call print_string

    ; print out min num----------------    
    mov rax, [MIN]
    call print_int

    ; Exit the method by removing the new stack------------
    mov rsp, rbp
    pop rbp
    ret























