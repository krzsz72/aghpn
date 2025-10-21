/*
 * avr.asm
 *
 *  Created: 09.10.2025 09:35:20
 *   Author: KP
 */ 


		ldi R16, 5
Loop:	nop
		nop
		nop
		dec R16
		rjmp Loop

