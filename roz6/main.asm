/*
 * main.asm
 *
 *  Created: 10.10.2025 10:44:29
 *   Author: KP
 */ 


/* ++++++++++++++++++++++
           cw8
   ++++++++++++++++++++++ 
nop
nop
rjmp 16
nop
nop
nop




   ++++++++++++++++++++++
           cw9
   ++++++++++++++++++++++ 

nop
nop
rjmp 4
nop
nop
nop



   ++++++++++++++++++++++
           cw10
   ++++++++++++++++++++++  


        
        ldi r20, 5
        dec r20
        rjmp 1
        nop
        nop


   ++++++++++++++++++++++
           cw11
   ++++++++++++++++++++++ */

        ldi r20, 5
Loop:   dec r20
        rjmp Loop
        nop
        nop
