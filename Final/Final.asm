%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 
;--------Prompts-----------------------------------------------------------------------------------

;----Welcome prompt and length----
welcome_prompt db "Welcome to Klaytons 301 Final Game! This is a two player turn based fighting game. Two players will take turns making an attack until one player falls. Type play to begin", 10, 0
welcome_prompt_len equ $ - welcome_prompt


;----screen seperator----
seperator db "#####################", 10, 0
seperator_len equ $ - seperator


;----player one's screen label----
play1_label db "##Player one's Turn##", 10, 0
play1_label_len equ $ - play1_label


;----player two's screen label----
play2_label db "##Player two's Turn##", 10, 0
play2_label_len equ $ - play2_label


;----Player one health label----
play1_h_label db "Player 1 health:", 0
play1_h_label_len equ $ - play1_h_label


;----Player two health label----
play2_h_label db "Player 2 health:", 0
play2_h_label_len equ $ - play2_h_label


;----select option prompt----
choose_option db "Please select from the following options:", 10, 0
choose_option_len equ $ - choose_option


;----Entry prompt----
entry db "###: ", 0
entry_len equ $ - entry


;----Players Options----
option1 db "1.  attack", 10, 0
option1_len equ $ - option1


;--------Player Stats------------------------------------------------------------------------------
;----player one's health, damage----
player1 dq 100, 10


;----player two's health, damage----
player2 dq 100, 10





; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 
;--------User Variables----------------------------------------------------------------------------
;----Check play----
play resb 32

;----Holds the current player----
current_player resb 32

;----Holds players selected option----
option resb 32

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

        call set_player1
        call welcome
        call check_start
        jmp player_screen
	
	    ;***************CODE ENDS HERE*****************************
finish:       
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret


;--------Displays welcome message------------------------------------------------------------------
welcome:

    ;----Display string----
    mov rax, welcome_prompt
    mov rdx, welcome_prompt_len
    call print_string

    ret

;--------Check users play input to see if they are starting the game-------------------------------
check_start:
   
    ;----Read Users input----
    mov rax, play
    call read_input

    ;----Check Users input----
    mov rax, [play]
    cmp rax, "play"

    ret

;--------Displays the players options--------------------------------------------------------------

display_options:

    ;----select option prompt---
    mov rax, choose_option
    mov rdx, choose_option_len
    call print_string

    ;----displays option 1----
    mov rax, option1
    mov rdx, option1_len
    call print_string

    ;----display the entry prompt----
    mov rax, entry
    mov rdx, entry_len
    call print_string

    ret

;--------Screen for player one's turn--------------------------------------------------------------

player_screen:

    ;----print screen seperator----
    mov rax, seperator
    mov rdx, seperator_len
    call print_string

    ;----print player one's health----
    mov rax, play1_h_label
    mov rdx, play1_h_label_len
    call print_string

    mov rax, [player1]
    call print_int

    ;----print player two's health----
    mov rax, play2_h_label
    mov rdx, play2_h_label_len
    call print_string

    mov rax, [player2]
    call print_int

    ;----print screen seperator----
    mov rax, seperator
    mov rdx, seperator_len
    call print_string

    ;----get current player and decide what label to use----
    call get_player
    mov rax, "player1"
    cmp rdx, rax
    je play1_screen
    jmp play2_screen

    ;----print player one's turn label----
    play1_screen:
        mov rax, play1_label
        mov rdx, play1_label_len
        call print_string

        jmp cont_screen

    ;----print player two's turn label----
    play2_screen:
        mov rax, play2_label
        mov rdx, play2_label_len
        call print_string

    cont_screen:

    ;----display options----
    call display_options

    ;----decides based off of selected option----
    call check_option

    jmp finish




;--------Checked the players selected option and makes a decision----------------------------------

check_option:

    ;----checkes selected option----
    call get_option

    ;----Check option----
    mov rax, [option]
    
    ;----option 1 attack----
    cmp rax, 1
    jz attack

    jmp finish

;--------Gets the players selected option and converts it to an intiger----------------------------

get_option:

    ;----Read input----
    mov rax, option
    call read_input

    ;----convert to intiger----
    mov rax, option
    call to_int
    mov [option], rax

ret

;--------Checks the current player then deals their damage to the other player--------------------
attack:

    ;----checks current player----
    call get_player
    mov rax, "player1"
    cmp rdx, rax
    
    jz attack_play2
    jmp attack_play1

    ;----uses player one's damage to attack player two----
    attack_play1:
        call get_play2_damage
        call sub_play1_health
        jmp check_dead

    ;----uses player two's damage to attack player one----
    attack_play2:
        call get_play1_damage
        call sub_play2_health
        jmp check_dead

;--------decrease the players health---------------------------------------------------------------
;----!!!Store amount of damage to be done in RDX!!!----

;----sub player one's health----
sub_play1_health:
    mov rax, player1
    sub qword [rax], rdx

    ret

;----sub player two's health----
sub_play2_health:
    mov rax, player2
    sub qword [rax], rdx

    ret

;--------Get the players damage--------------------------------------------------------------------
;----!!!Stores the damage in RDX!!!----

;----Get player one's damage----
get_play1_damage:  
    mov rcx, player1
    mov rax, 1
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, [rcx]

    ret

;----Get player two's damage----
get_play2_damage:  
    mov rcx, player2
    mov rax, 1
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, [rcx]

    ret

;--------Sets the current player to player 1-------------------------------------------------------
set_player1:
    
    mov rdx, "player1"
    mov [current_player], rdx

    ret

;--------Sets the current player to player 2-------------------------------------------------------
set_player2:
    
    mov rdx, "player2"
    mov [current_player], rdx

    ret

;--------Gets the current player and leaves it store in RDX----------------------------------------
get_player:
    
    mov rdx, [current_player]

    ret

;--------Switches the current player---------------------------------------------------------------
switch_player:
    
    ;----see if current player is player one---
    call get_player 
    mov rax, "player1"
    cmp rdx, rax
    
    ;----set player----
    jz set_player2
    jmp set_player1
    
;--------Checks if the player is dead, if not switch players and go back to screen-----------------
check_dead:

    ;----check player one's health----
    mov rax, [player1]
    cmp rax, 0
    jle play1_dead

    ;----check player two's health----
    mov rax, [player2]
    cmp rax, 0
    jle play2_dead

    ;----if niether dead switch player go back to screen----
    call switch_player
    jmp player_screen

    ;----if player one is dead----
    play1_dead:
        jmp finish

    ;----if player two is dead----
    play2_dead:
        jmp finish











