/*
 * cw1.asm
 *
 *  Created: 09.10.2025 09:47:50
 *   Author: LENOVO
 */ 


ldi R20, 3
mov R0, R20
JUMP:   dec R0
        rjmp JUMP