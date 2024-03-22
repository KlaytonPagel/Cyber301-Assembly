%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 

; number prompts-------------------------------------------------------------------------------------------------------

num1prompt db "Enter the first number >> ", 0
num1promptlen equ $ - num1prompt

num2prompt db "Enter the second number >> ", 0
num2promptlen equ $ - num2prompt

num3prompt db "Enter the third number >> ", 0
num3promptlen equ $ - num3prompt

num4prompt db "Enter the fourth number >> ", 0
num4promptlen equ $ - num4prompt

; choice prompt--------------------------------------------------------------------------------------------------------

choiceprompt db "Enter 1, 2, or 3 >> ", 0
choicepromptlen equ $ - choiceprompt

; math prompts---------------------------------------------------------------------------------------------------------

sumprompt db "The sum of all numbers is: ", 0
sumpromptlen equ $ - sumprompt

difprompt db "The difference of all numbers is: ", 0
difpromptlen equ $ - difprompt

prodprompt db "The product of all numbers is: ", 0
prodpromptlen equ $ - prodprompt

; error prompt---------------------------------------------------------------------------------------------------------

errorprompt db "Invalid entry must be 1 through 3", 10, 0
errorpromptlen equ $ - errorprompt

; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 

; number variables-----------------------------------------------------------------------------------------------------

num1 resb 32
num2 resb 32
num3 resb 32
num4 resb 32
choice resb 32


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
		
        call get_num1
        call get_num2
        call get_num3
        call get_num4
        call get_choice
        call set_reg

        jmp decide
        

	
	    ;***************CODE ENDS HERE*****************************
       


; first number-----------------------------------------------------------------

get_num1:

; Ask for input------------------------
mov rax, num1prompt
mov rdx, num1promptlen
call print_string

; take input---------------------------
mov rax, num1
call read_input

; convert to int-----------------------
mov rax, num1
call to_int
mov [num1], rax

ret

; second number-----------------------------------------------------------------

get_num2:

; Ask for input------------------------
mov rax, num2prompt
mov rdx, num2promptlen
call print_string

; take input---------------------------
mov rax, num2
call read_input

; convert to int-----------------------
mov rax, num2
call to_int
mov [num2], rax

ret

; third number-----------------------------------------------------------------

get_num3:

; Ask for input------------------------
mov rax, num3prompt
mov rdx, num3promptlen
call print_string

; take input---------------------------
mov rax, num3
call read_input

; convert to int-----------------------
mov rax, num3
call to_int
mov [num3], rax

ret

; fourth number-----------------------------------------------------------------

get_num4:

; Ask for input------------------------
mov rax, num4prompt
mov rdx, num4promptlen
call print_string

; take input---------------------------
mov rax, num4
call read_input

; convert to int-----------------------
mov rax, num4
call to_int
mov [num4], rax

ret

; asks the user for their choice ----------------------------------------------

get_choice:

; Ask for input------------------------
mov rax, choiceprompt
mov rdx, choicepromptlen
call print_string

; take input---------------------------
mov rax, choice
call read_input

; convert to int-----------------------
mov rax, choice
call to_int
mov [choice], rax

ret

; set registers to the users numbers-------------------------------------------

set_reg:

mov rax, [num1]
mov rbx, [num2]
mov rcx, [num3]
mov rdx, [num4]

ret

; decides what function to run based off of users input------------------------

decide:

mov rax, [choice]

cmp rax, 1
jz sum
cmp rax, 2
jz prod
cmp rax, 3
jz dif

mov rax, errorprompt
mov rdx, errorpromptlen
call print_string

jmp done

; gets the sum of all user values----------------------------------------------

sum:

mov rax, sumprompt
mov rdx, sumpromptlen
call print_string

call set_reg

add rax, rbx
add rax, rcx
add rax, rdx

jmp print

; gets the difference of all user values---------------------------------------

dif:

mov rax, difprompt
mov rdx, difpromptlen
call print_string

call set_reg

sub rax, rbx
sub rax, rcx
sub rax, rdx

jmp print

; gets the product of all user values------------------------------------------

prod:

mov rax, prodprompt
mov rdx, prodpromptlen
call print_string

call set_reg

imul rax, rbx
imul rax, rcx
imul rax, rdx

jmp print

; prints the end value---------------------------------------------------------

print:

call print_int

; ends the program-------------------------------------------------------------

done:

mov	rax, 0
pop	rbp               
ret






















