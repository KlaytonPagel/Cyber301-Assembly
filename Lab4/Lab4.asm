%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################


segment .data 

;___________________Task 1 through 7___________________________________________
; prompt one set up______________________________________
prompt1 db "Please enter a number: ", 0
p1len equ $ - prompt1

;__________________Task 8______________________________________________________
;First number prompt_____________________________________
num1prompt db "Please enter a number: ", 0
num1promptlen equ $ - num1prompt

;Second number prompt____________________________________
num2prompt db "Please enter another number: ", 0
num2promptlen equ $ - num2prompt

;First value display_____________________________________
value1 db "First Value: ", 0
value1len equ $ - value1

;Second value display____________________________________
value2 db "Second Value: ", 0
value2len equ $ - value2

;Sum display_____________________________________________
sumprompt db "The sum of these two values is: ", 0
sumpromptlen equ $ - sumprompt

;difference display______________________________________
difprompt db "The difference of these two values is: ", 0
difpromptlen equ $ - difprompt

; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 

;___________________Task 1 through 7___________________________________________
; Prompt one input______________________________________
ui1 resb 32

;__________________Task 8______________________________________________________
;Users first number______________________________________
num1 resb 32
;Users second number_____________________________________
num2 resb 32
;Sum variable____________________________________________
sumnum resb 32
;Difference variable_____________________________________
difnum resb 32

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
		
        ;print prompt 1___________________________________________
;        mov rax, prompt1
;        mov rdx, p1len
;        call print_string

        ;prompt 1 user input______________________________________
;        mov rax, ui1
;        call read_input

        ;print users input back out_______________________________
;        mov rax, ui1
;        mov rdx, 32
;        call print_string
;        call print_nl

        ;convert user input to int________________________________
;        mov rax, ui1
;        call to_int
;        mov [ui1], rax

        ;print the value as an int________________________________
;        mov rax, [ui1]
;        call print_int

        ;add 5 to the inputed value then print____________________
;        add rax, 5
;        call print_int

        ;_____________________Task 8__________________________________________________________

        ;Get users first number and convert it to int______________

        ; ask user for input___________
        mov rax, num1prompt
        mov rdx, num1promptlen
        call print_string

        ; read input___________________
        mov rax, num1
        call read_input

        ; convert to int_______________
        mov rax, num1
        call to_int
        mov [num1], rax

        ;Get users second number and convert it to int______________

        ; ask user for input___________
        mov rax, num2prompt
        mov rdx, num2promptlen
        call print_string

        ; read input___________________
        mov rax, num2
        call read_input

        ; convert to int_______________
        mov rax, num2
        call to_int
        mov [num2], rax

        ;Display the users first value_____________________________

        ; Print first value string_____
        mov rax, value1
        mov rdx, value1len
        call print_string

        ; Print the users value________
        mov rax, [num1]
        call print_int

        ;Display the users second value_____________________________

        ; Print second value string_____
        mov rax, value2
        mov rdx, value2len
        call print_string

        ; Print the users value________
        mov rax, [num2]
        call print_int

        ;Calculate the sum of the two numbers______________________
        mov rax, [num1]
        add rax, [num2]
        mov [sumnum], rax
        
        ;Display the sum of the two numbers________________________
        ; Print sum prompt_____________
        mov rax, sumprompt
        mov rdx, sumpromptlen
        call print_string
        
        ; Print sum____________________
        mov rax, [sumnum]
        call print_int


        ;Calculate the difference of the two numbers_______________
        mov rax, [num1]
        sub rax, [num2]
        mov [difnum], rax

        ;Display the difference of the two numbers_________________
        ; Print difference prompt______
        mov rax, difprompt
        mov rdx, difpromptlen
        call print_string
        
        ; Print sum____________________
        mov rax, [difnum]
        call print_int
	
	    ;***************CODE ENDS HERE*****************************
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret
