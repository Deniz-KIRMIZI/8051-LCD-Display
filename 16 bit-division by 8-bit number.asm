

	ORG 0

	mov R0, #0E2h ;specify the low of divident
	mov R1, #0BDh ;specify the high of divident
	mov R2, #039h ;specify the divisor

	mov R4, #00h
	mov R3, #00h
	mov R5, #00h


newcarry:
	JNC sub
	clr C
sub:	mov A, R0
	subb A, R2
	mov R0, A
	inc dptr
done:	JC loop
	sjmp sub
loop:	DJNZ R1, newcarry

last8:	mov R0, A
	subb A, R2
	JC Reminder
	mov R0, A
	inc dptr
done2:	sjmp last8

Reminder:
	mov R3, dph
	mov R4, dpl
	mov A, R0
	mov R5, A
	mov R0, #00h

	END		
	
	