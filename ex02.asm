.MODEL SMALL
.STACK 100H

.DATA
array DW 10, 5, 25, 8, 12  ; Sample array
array_size DW 5             ; Number of elements
msg1 DB "Maximum value: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA AX, array    ; Load array address
    MOV BX, array_size  ; Load array size
    PUSH BX         ; Push size onto the stack
    PUSH AX         ; Push address onto the stack
    CALL find_max   ; Call the subroutine

    ; Print the maximum value
    MOV DX, OFFSET msg1
    MOV AH, 9
    INT 21H
    CALL print_num      ; Print the value in AX

    MOV AH, 4CH  ; Exit to DOS
    INT 21H
MAIN ENDP

; Subroutine to find the maximum value in an array
; Parameters:
;   [BP+4] -> Address of the array
;   [BP+6] -> Number of elements in the array
; Returns:
;   AX -> Maximum value in the array
find_max PROC
    PUSH BP
    MOV BP, SP

    MOV BX, [BP+4]  ; Address of the array
    MOV CX, [BP+6]  ; Number of elements

    MOV AX, [BX]    ; Initialize max with the first element

find_loop:
    CMP CX, 0
    JE find_done

    CMP AX, [BX]
    JG find_next

    MOV AX, [BX]    ; Update max if a greater value is found

find_next:
    ADD BX, 2       ; Move to the next element (assuming 16-bit integers)
    LOOP find_loop

find_done:
    POP BP
    RET
find_max ENDP

; Subroutine to print a number (assuming a separate print_num subroutine exists)
print_num PROC
    ; ... (Implementation for printing a number)
print_num ENDP

END MAIN
