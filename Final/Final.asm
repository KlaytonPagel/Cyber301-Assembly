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
welcome_prompt1 db "Welcome to Klaytons 301 Final Game!", 10, 0
welcome_prompt1_len equ $ - welcome_prompt1

;----Help Prompts--------
help_prompt1 db "This is a two player turn based fighting game.", 10, 0
help_prompt1_len equ $ - help_prompt1


help_prompt2 db "Two players will take turns making an attack until one player falls.", 10, 0
help_prompt2_len equ $ - help_prompt2


help_prompt3 db "Attacking does your damage amount to the other player.", 10, 0
help_prompt3_len equ $ - help_prompt3


help_prompt4 db "Health potions double your current health, but won't go above 100.", 10, 0
help_prompt4_len equ $ - help_prompt4


help_prompt5 db "Strength potions triple your damage for one attack", 10, 0
help_prompt5_len equ $ - help_prompt5


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
play1_h_label db "Player 1 Health:", 0
play1_h_label_len equ $ - play1_h_label


;----Player two health label----
play2_h_label db "Player 2 Health:", 0
play2_h_label_len equ $ - play2_h_label


;----Player one damage label----
play1_d_label db "         Damage:", 0
play1_d_label_len equ $ - play1_d_label


;----Player two damage label----
play2_d_label db "         Damage:", 0
play2_d_label_len equ $ - play2_d_label


;----Player one health potion label----
play1_hp_label db "         Health Potions:", 0
play1_hp_label_len equ $ - play1_hp_label


;----Player two health potion label----
play2_hp_label db "         Health Potions:", 0
play2_hp_label_len equ $ - play2_hp_label


;----Player one strength potion label----
play1_s_label db "         Strength Potions:", 0
play1_s_label_len equ $ - play1_s_label


;----Player two strength potion label----
play2_s_label db "         Strength Potions:", 0
play2_s_label_len equ $ - play2_s_label


;----incorrect response label----
incorrect db "Invalid Response", 10, 0
incorrect_len equ $ - incorrect


;----select option prompt----
choose_option db "Please select from the following options:", 10, 0
choose_option_len equ $ - choose_option

;----no potion available prompt----
no_potion_prompt db "That potion is unavailable!!!", 10, 0
no_potion_prompt_len equ $ - no_potion_prompt


;----player one wins----
play1_wins db "Player one wins!", 10, 0
play1_wins_len equ $ - play1_wins


;----player two wins----
play2_wins db "Player two wins!", 10, 0
play2_wins_len equ $ - play2_wins


;----play again prompt----
play_again db "would you like to play again. yes/no", 10, 0
play_again_len equ $ - play_again


;----Entry prompt----
entry db "###: ", 0
entry_len equ $ - entry


;----Players Options----
option1 db "1.  attack", 10, 0
option1_len equ $ - option1

option2 db "2.  drink health potion", 10, 0
option2_len equ $ - option2

option3 db "3.  drink strength potion", 10, 0
option3_len equ $ - option3

option4 db "4.  help", 10, 0
option4_len equ $ - option4


;--------Player Stat arrays------------------------------------------------------------------------
;----player one's health, damage, health potions, damage buffs----
player1 dq 100, 10, 2, 2


;----player two's health, damage, health potions, damage buffs----
player2 dq 100, 10, 2, 2





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
start:
        call set_player1
        call welcome
        jmp player_screen
	
	    ;***************CODE ENDS HERE*****************************
finish:       
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret


;--------Displays welcome message------------------------------------------------------------------
welcome:

    ;----Display string----
    mov rax, welcome_prompt1
    mov rdx, welcome_prompt1_len
    call print_string
    ret

;--------Displays help messages--------------------------------------------------------------------
help:

    mov rax, seperator
    mov rdx, seperator_len
    call print_string

    mov rax, help_prompt1
    mov rdx, help_prompt1_len
    call print_string

    mov rax, help_prompt2
    mov rdx, help_prompt2_len
    call print_string

    mov rax, help_prompt3
    mov rdx, help_prompt3_len
    call print_string

    mov rax, help_prompt4
    mov rdx, help_prompt4_len
    call print_string

    jmp player_screen

;--------Screen for players turn-------------------------------------------------------------------

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

    ;----print player one's damage----
    mov rax, play1_d_label
    mov rdx, play1_d_label_len
    call print_string

    call get_play1_damage
    mov rax, [rdx]
    call print_int

    ;----print player one's health potion count----
    mov rax, play1_hp_label
    mov rdx, play1_hp_label_len
    call print_string

    call get_play1_health_pot
    mov rax, [rdx]
    call print_int

    ;----print player one's strength potion count----
    mov rax, play1_s_label
    mov rdx, play1_s_label_len
    call print_string

    call get_play1_strength_pot
    mov rax, [rdx]
    call print_int

    ;----print player two's health----
    mov rax, play2_h_label
    mov rdx, play2_h_label_len
    call print_string

    mov rax, [player2]
    call print_int

    ;----print player two's damage----
    mov rax, play2_d_label
    mov rdx, play2_d_label_len
    call print_string

    call get_play2_damage
    mov rax, [rdx]
    call print_int

    ;----print player two's health potion count----
    mov rax, play2_hp_label
    mov rdx, play2_hp_label_len
    call print_string

    call get_play2_health_pot
    mov rax, [rdx]
    call print_int

    ;----print player two's strength potion count----
    mov rax, play2_s_label
    mov rdx, play2_s_label_len
    call print_string

    call get_play2_strength_pot
    mov rax, [rdx]
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

    ;----print screen seperator----
    mov rax, seperator
    mov rdx, seperator_len
    call print_string

    ;----display options----
    call display_options

    ;----decides based off of selected option----
    jmp check_option

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

    ;----displays option 2----
    mov rax, option2
    mov rdx, option2_len
    call print_string

    ;----displays option 3----
    mov rax, option3
    mov rdx, option3_len
    call print_string

    ;----displays option 4----
    mov rax, option4
    mov rdx, option4_len
    call print_string


    ;----display the entry prompt----
    mov rax, entry
    mov rdx, entry_len
    call print_string

    ret

;--------Checked the players selected option and makes a decision----------------------------------

check_option:

    ;----checkes selected option----
    call get_option

    ;----Check option----
    mov rax, [option]
    
    ;----option 1 attack----
    cmp rax, 1
    jz attack

    ;----option 2 health potion----
    cmp rax, 2
    jz drink_health

    ;----option 3 health potion----
    cmp rax, 3
    jz drink_strength

    ;----option 4 help----
    cmp rax, 4
    jz help

    ;----invalid option----
    mov rax, incorrect
    mov rdx, incorrect_len
    call print_string
    jmp player_screen

;--------Gets the players selected option and converts it to an integer----------------------------

get_option:

    ;----Read input----
    mov rax, option
    call read_input

    ;----convert to integer----
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

    ;----uses player two's damage to attack player one----
    attack_play1:
        call get_play2_damage
        mov rax, [rdx]
        mov rdx, rax
        call sub_play1_health

    ;----set player two's damage to the default 10----
        call get_play2_damage
        mov rax, 10
        mov [rdx], rax

        jmp check_dead

    ;----uses player one's damage to attack player two----
    attack_play2:
        call get_play1_damage
        mov rax, [rdx]
        mov rdx, rax
        call sub_play2_health

    ;----set player one's damage to the default 10----
        call get_play1_damage
        mov rax, 10
        mov [rdx], rax

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
;----!!!Stores the address in RDX!!!----

;----Get player one's damage----
get_play1_damage:  
    mov rcx, player1
    mov rax, 1
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, rcx

    ret

;----Get player two's damage----
get_play2_damage:  
    mov rcx, player2
    mov rax, 1
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, rcx

    ret

;--------Get the players health potion count-------------------------------------------------------
;----!!!Stores the address in RDX!!!----

;----Get player one's health potion count----
get_play1_health_pot:  
    mov rcx, player1
    mov rax, 2
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, rcx

    ret

;----Get player two's health potion count----
get_play2_health_pot:  
    mov rcx, player2
    mov rax, 2
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, rcx

    ret

;--------Get the players strength potion count-------------------------------------------------------
;----!!!Stores the address in RDX!!!----

;----Get player one's strength potion count----
get_play1_strength_pot:  
    mov rcx, player1
    mov rax, 3
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, rcx

    ret

;----Get player two's strength potion count----
get_play2_strength_pot:  
    mov rcx, player2
    mov rax, 3
    mov rbx, 8
    mul rbx
    add rcx, rax
    mov rdx, rcx

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
    
;--------Drinking a health potion for the current player-------------------------------------------
;----Health potions doubles the player's current health but won't take it over 100----------------- 
drink_health:

    ;----checks current player----
    call get_player
    mov rax, "player1"
    cmp rdx, rax
    jz play1_drink_health
    jmp play2_drink_health

    ;----health potion for player 1----
    play1_drink_health:

        ;----Checks if player has a potion----
        call get_play1_health_pot
        mov rax, 0
        cmp [rdx], rax
        jg use_play1_health_pot

        ;----if no health potions----
        jmp no_potions
        
        ;----sub one from player one's health potions----
        use_play1_health_pot:
            call get_play1_health_pot
            mov rax, 1
            sub [rdx], rax

            ;----get players health and double it----
            mov rax, [player1]
            mov rdx, 2
            mul rdx
            mov [player1], rax

            ;----Check if health is over 100----
            mov rax, [player1]
            cmp rax, 100
            jg set_play1_health_max
            jmp health_cont
            
            ;----set health to 100 if over----
            set_play1_health_max:
                mov rax, 100
                mov [player1], rax
                jmp health_cont

    ;----health potion for player 2----
    play2_drink_health:

        ;----Checks if player has a potion----
        call get_play2_health_pot
        mov rax, 0
        cmp [rdx], rax
        jg use_play2_health_pot

        ;----if no health potions----
        jmp no_potions
        
        ;----sub one from player one's health potions----
        use_play2_health_pot:
            call get_play2_health_pot
            mov rax, 1
            sub [rdx], rax

            ;----get players health and double it----
            mov rax, [player2]
            mov rdx, 2
            mul rdx
            mov [player2], rax

            ;----Check if health is over 100----
            mov rax, [player2]
            cmp rax, 100
            jg set_play2_health_max
            jmp health_cont
            
            ;----set health to 100 if over----
            set_play2_health_max:
                mov rax, 100
                mov [player2], rax
                jmp health_cont

    health_cont:
        jmp check_dead

;--------Drinking a strength potion for the current player-----------------------------------------
;----Strength potions triple the players attack for their next attack------------------------------
drink_strength:

    ;----checks current player----
    call get_player
    mov rax, "player1"
    cmp rdx, rax
    jz play1_drink_strength
    jmp play2_drink_strength

    ;----strength potion for player 1----
    play1_drink_strength:

        ;----Checks if player has a potion----
        call get_play1_strength_pot
        mov rax, 0
        cmp [rdx], rax
        jg use_play1_strength_pot

        ;----if no health potions----
        jmp no_potions
        
        ;----sub one from player one's strength potions----
        use_play1_strength_pot:
            call get_play1_strength_pot
            mov rax, 1
            sub [rdx], rax

            ;----get players damage and triple it----
            call get_play1_damage
            mov rax, [rdx]
            mov rdx, 3
            mul rdx
            push rax
            call get_play1_damage
            pop rax
            mov [rdx], rax

            jmp check_dead

    ;----strength potion for player 2----
    play2_drink_strength:

        ;----Checks if player has a potion----
        call get_play2_strength_pot
        mov rax, 0
        cmp [rdx], rax
        jg use_play2_strength_pot

        ;----if no health potions----
        jmp no_potions
        
        ;----sub one from player two's strength potions----
        use_play2_strength_pot:
            call get_play2_strength_pot
            mov rax, 1
            sub [rdx], rax

            ;----get players damage and triple it----
            call get_play2_damage
            mov rax, [rdx]
            mov rdx, 3
            mul rdx
            push rax
            call get_play2_damage
            pop rax
            mov [rdx], rax

            jmp check_dead

    
;--------If the player has no available potion, say so then go back to the option screen-----------
no_potions:

    ;----seperator prompt----
    mov rax, seperator
    mov rdx, seperator_len
    call print_string

    ;----no potion prompt----
    mov rax, no_potion_prompt
    mov rdx, no_potion_prompt_len
    call print_string

    jmp player_screen

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
        mov rax, play2_wins
        mov rdx, play2_wins_len
        call print_string
        jmp check_play_again

    ;----if player two is dead----
    play2_dead:
        mov rax, play1_wins
        mov rdx, play1_wins_len
        call print_string
        jmp check_play_again

;--------checks if the player would like to play again then decides--------------------------------
check_play_again:

    ;----asks the player if they want to play again----
    mov rax, play_again
    mov rdx, play_again_len
    call print_string

    mov rax, entry
    mov rdx, entry_len
    call print_string

    ;----Gets user input----
    mov rax, option
    call read_input

    ;----check if yes----
    mov rax, [option]
    cmp rax, "yes"
    jz restart

    ;----check if no----
    mov rax, [option]
    cmp rax, "no"
    jz finish

    ;----if not yes or no----
    mov rax, incorrect
    mov rdx, incorrect_len
    call print_string
    jmp check_play_again

;--------Sets player stats back and restarts the game----------------------------------------------
restart:

    ;----resets player one's health----
    mov rax, player1
    mov rdx, 100
    mov [rax], rdx

    ;----resets player two's health----
    mov rax, player2
    mov rdx, 100
    mov [rax], rdx

    ;----displays a few screen seperators----
    mov rax, seperator
    mov rdx, seperator_len
    call print_string
    call print_string
    call print_string

    jmp start
























