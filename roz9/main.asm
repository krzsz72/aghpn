/*
 * main.asm
 *
 *  Created: 10.10.2025 10:44:29
 *   Author: KP
 */ 


/* ++++++++++++++++++++++
           cwm1
   ++++++++++++++++++++++  
        
.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )

.endmacro

nop
nop
nop
LOAD_CONST r17, r16, 1234



/*
obliczenia: 3x NOP + ret = 3 cycles + 4 = 7 == 0,875us
*/

 /* ++++++++++++++++++++++
           cwm2
   ++++++++++++++++++++++ */


        
.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )

.endmacro




MainLoop:  
            ldi R24, 2			//delay time ms
    		     ;tu musi byc od razu rcall DelayInMs
            rcall DelayInMs ;
            rjmp MainLoop

DelayNCycles: ;zwyk³a etykieta
            nop
            nop
            nop
            ret 
            
DelayInMs:  push r24
            LOAD_CONST r25,r24,2000
            rcall DelayOneMs  
            pop r24
			dec R24
			brbc 1, DelayInMs
			ret

DelayOneMs: sbiw R25:R24, 1		//(R*4)+1
			
            brne DelayOneMs
            ret		