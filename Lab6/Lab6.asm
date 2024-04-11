%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 

;---------Arrays--------------------------------------------
array1 db 1, 2, 3, 4, 5, 6
array2 dw 10, 11, 12, 13, 14, 15, 16
array3 dd 100, 200, 300, 400, 500, 600

;---------Prompts-------------------------------------------
arr1prompt db "Array 1 address: ", 0
arr1promptlen equ $ - arr1prompt

arr2prompt db "Array 2 address: ", 0
arr2promptlen equ $ - arr2prompt

arr3prompt db "Array 3 address: ", 0
arr3promptlen equ $ - arr3prompt

newaddrprompt db "The new address is: ", 0
newaddrpromptlen equ $ - newaddrprompt

arrnumprompt db "Enter Array Number (1, 2, or 3): ", 0
arrnumpromptlen equ $ - arrnumprompt

sizeprompt db "Enter Size (1, 2, or 4): ", 0
sizepromptlen equ $ - sizeprompt

offsetprompt db "Enter Offset (An Integer): ", 0
offsetpromptlen equ $ - offsetprompt

; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 

;---------Size, Address, Offset User inputs------------------------------------

size resb 32
address resb 32
offset resb 32



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

;---------Task 6---------------------------------------------------------------

        call print_addr_1
        mov rax, array1
        call print_address

        call print_addr_2
        mov rax, array2
        call print_address

        call print_addr_3
        mov rax, array3
        call print_address

;---------Task 7---------------------------------------------------------------

        call getArrayNumberInput
        call getOffsetInput
        call getSizeInput

;---------Task 8---------------------------------------------------------------
        
        mov rax, [address]
        cmp rax, 2
        jl one
        jz two
        jg three

	    jmp done
	    ;***************CODE ENDS HERE*****************************


;---------Prints out address one-----------------------------------------------
print_addr_1:
    push rax
    push rdx

    mov rax, arr1prompt
    mov rdx, arr1promptlen

    call print_string

    pop rdx
    pop rax

    ret

;---------Prints out address two-----------------------------------------------
print_addr_2:
    push rax
    push rdx

    mov rax, arr2prompt
    mov rdx, arr2promptlen

    call print_string

    pop rdx
    pop rax

    ret

;---------Prints out address three---------------------------------------------
print_addr_3:
    push rax
    push rdx

    mov rax, arr3prompt
    mov rdx, arr3promptlen

    call print_string

    pop rdx
    pop rax

    ret

;---------Takes users input for array number-----------------------------------
getArrayNumberInput: 
    ;----Preserve registers-----------
    push rax
    push rdx

    ;-----Print Prompt-----------------
    mov rax, arrnumprompt
    mov rdx, arrnumpromptlen
    call print_string

    ;-----Take user input--------------
    mov rax, address
    call read_input
    mov [address], rax

    ;-----Convert to integer-----------
    mov rax, address
    call to_int
    mov [address], rax

    ;-----retrieve preserved registers-
    pop rdx
    pop rax

    ret

;---------Takes users input for offset number----------------------------------
getOffsetInput: 
    ;----Preserve registers-----------
    push rax
    push rdx

    ;-----Print Prompt-----------------
    mov rax, offsetprompt
    mov rdx, offsetpromptlen
    call print_string

    ;-----Take user input--------------
    mov rax, offset
    call read_input
    mov [offset], rax

    ;-----Convert to integer-----------
    mov rax, offset
    call to_int
    mov [offset], rax

    ;-----retrieve preserved registers-
    pop rdx
    pop rax

    ret

;---------Takes users input for size number------------------------------------
getSizeInput: 
    ;----Preserve registers-----------
    push rax
    push rdx

    ;-----Print Prompt-----------------
    mov rax, sizeprompt
    mov rdx, sizepromptlen
    call print_string

    ;-----Take user input--------------
    mov rax, size
    call read_input
    mov [size], rax

    ;-----Convert to integer-----------
    mov rax, size
    call to_int
    mov [size], rax

    ;-----retrieve preserved registers-
    pop rdx
    pop rax

    ret

;---------if the user enters 1 as the address----------------------------------

one:
    
    mov rcx, array1
    jmp done

;---------if the user enters 2 as the address----------------------------------


two:

    mov rcx, array2
    jmp done

;---------if the user enters 3 as the address----------------------------------

three:

    mov rcx, array3
    jmp done


done:
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret
