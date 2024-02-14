%include "io.inc"

; #######################################################
; #                                                     #
; # Store your string literals in the data section      #
; # These variables cannot be changed at runtime        #
; #                                                     #
; #######################################################

segment .data 




; #######################################################
; #                                                     #
; # Store your variables in the data section            #
; # These variables can be changed at runtime           #
; #                                                     #
; #######################################################

segment .bss 

data1 resb 32
data2 resb 32
data3 resb 32
data4 resb 32
data5 resb 32



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
		
        mov rax, 0xFEED
        mov rbx, 0xBEEF
        mov rcx, 0xCAFE
        mov rdx, 0xDAAD
        mov r8, rax
        add r8, rbx
        mov [data1], r8
        sub r8, rcx
        mov [data2], r9
        mul rcx
        mov [data3], rax
        mul rdx
        add rax, 0xFFFF
        mov [data4], rax
        mul rdx
        add rax, 0xFFFF
check_data:
        mov [data5], rax
        

	
	    ;***************CODE ENDS HERE*****************************
        
        mov	rax, 0           ; return back to C
       	pop	rbp               
        ret
