	ORG 0


	acall	CONFIGURE_LCD
	mov A, #'I'
	acall send_data
	mov A, #'N'
	acall send_data
	mov A, #'P'
	acall send_data
	mov A, #'U'
	acall send_data
	mov A, #'T'
	acall send_data
	mov A, #'='
	acall send_data
	

KEYBOARD_LOOP:
	acall KEYBOARD	;now, A has the key pressed
	acall SEND_DATA
	ANL A, #0FH
	MOV R3, A

	acall KEYBOARD	;now, A has the key pressed
	acall SEND_DATA
	ANL A, #0FH
	MOV R4, A

	acall KEYBOARD	;now, A has the key pressed
	acall SEND_DATA
	ANL A, #0FH
	MOV R5, A


definput:
	mov B, #100d
	mov A, R3
	mul AB
	mov R3, A
	mov A, r4
	mov B, #10d
	mul AB
	add A, R3
	add A, R5
	mov R3, A
	
	MOV A, #0c0h ; this block goes to next line in LCD
	acall send_command


	mov A, #'P'
	acall send_data
	mov A, #'='
	acall send_data
	mov A, #'('
	acall send_data

	mov DPTR, #lookup
loop:	clr A
	movc A, @A+DPTR
	
	CJNE A, #00h, continue
	mov A, #')'
	call send_data
	ljmp end
continue:
	mov B,A
	mov R6, A
	mov A, R3
	div AB
	mov R7, A
	mov A, B
	JZ write
	inc dptr
	sjmp loop

write:	mov A,R6
	mov B, #100d
	div AB
	mov R6, B
	JZ notwr
	add A, #30h
	call send_data
notwr:	mov A, R6
	mov B, #10d
	div AB
	mov R6, B
	JZ notwr2
	add A, #30h
	call send_data
notwr2:	mov A, R6
	add A, #30h
	call send_data
	mov A, #','
	call send_data
	mov A, R7
	mov R3, A
	sjmp loop	



lookup:
	DB 2, 3, 5,7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 53, 59, 61, 67, 71, 73,79, 83, 89, 87, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 181, 191, 193, 197, 199, 211, 223, 239, 241, 251, 0 	

	
	
	
	
	






	
	sjmp $




CONFIGURE_LCD:	;THIS SUBROUTINE SENDS THE INITIALIZATION COMMANDS TO THE LCD
	mov a,#38H	;TWO LINES, 5X7 MATRIX
	acall SEND_COMMAND
	mov a,#0FH	;DISPLAY ON, CURSOR BLINKING
	acall SEND_COMMAND
	mov a,#06H	;INCREMENT CURSOR (SHIFT CURSOR TO RIGHT)
	acall SEND_COMMAND

	mov a,#80H	;FORCE CURSOR TO BEGINNING OF THE FIRST LINE
	acall SEND_COMMAND
	ret



SEND_COMMAND:
	mov p1,a		;THE COMMAND IS STORED IN A, SEND IT TO LCD
	clr p3.5		;RS=0 BEFORE SENDING COMMAND
	clr p3.6		;R/W=0 TO WRITE
	setb p3.7	;SEND A HIGH TO LOW SIGNAL TO ENABLE PIN
	acall DELAY
	clr p3.7
	ret


SEND_DATA:
	mov p1,a		;SEND THE DATA STORED IN A TO LCD
	setb p3.5	;RS=1 BEFORE SENDING DATA
	clr p3.6		;R/W=0 TO WRITE
	setb p3.7	;SEND A HIGH TO LOW SIGNAL TO ENABLE PIN
	acall DELAY
	clr p3.7
	ret


DELAY:
	push 0
	push 1
	mov r0,#255
DELAY_OUTER_LOOP:
	mov r1,#255
	djnz r1,$
	djnz r0,DELAY_OUTER_LOOP
	pop 1
	pop 0
	ret


KEYBOARD: ;takes the key pressed from the keyboard and puts it to A
	mov	P0, #0ffh	;makes P0 input
K1:
	mov	P2, #0	;ground all rows
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, K1
K2:
	acall	DELAY
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, KB_OVER
	sjmp	K2
KB_OVER:
	acall DELAY
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, KB_OVER1
	sjmp	K2
KB_OVER1:
	mov	P2, #11111110B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_0
	mov	P2, #11111101B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_1
	mov	P2, #11111011B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_2
	mov	P2, #11110111B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_3
	ljmp	K2
	
ROW_0:
	mov	DPTR, #KCODE0
	sjmp	KB_FIND
ROW_1:
	mov	DPTR, #KCODE1
	sjmp	KB_FIND
ROW_2:
	mov	DPTR, #KCODE2
	sjmp	KB_FIND
ROW_3:
	mov	DPTR, #KCODE3
KB_FIND:
	rrc	A
	jnc	KB_MATCH
	inc	DPTR
	sjmp	KB_FIND
KB_MATCH:
	clr	A
	movc	A, @A+DPTR; get ASCII code from the table 
	ret

;ASCII look-up table 
KCODE0:	DB	'1', '2', '3', 'A'
KCODE1:	DB	'4', '5', '6', 'B'
KCODE2:	DB	'7', '8', '9', 'C'
KCODE3:	DB	'*', '0', '#', 'D'





	
end:	END


