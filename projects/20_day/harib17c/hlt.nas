[BITS 32]
		MOV		AL,'A'
;		CALL    2*8:0xbe3
		CALL    2*8:0xca4
fin:
		HLT
		JMP		fin
