.MODEL SMALL
.STACK 100H

.DATA
prompt_msg DB "Enter a character: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 10  ; Counter for 10 characters

; Input loop
input_loop:
    MOV AH, 9
    LEA DX, prompt_msg
    INT 21H

    MOV AH, 1
    INT 21H
    PUSH AX     ; Push character onto stack

    LOOP input_loop

; Output loop
output_loop:
    POP DX      ; Pop character from stack
    MOV AH, 2
    INT 21H

    LOOP output_loop

    MOV AH, 4CH  ; Exit to DOS
    INT 21H
MAIN ENDP
END MAIN
