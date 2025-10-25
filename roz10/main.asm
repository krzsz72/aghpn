/*
 * main.asm
 *
 *  Created: 10.10.2025 10:44:29
 *   Author: KP
 *  cw 28 - cw 35
 */ 


/* ++++++++++++++++++++++
           cw28
   ++++++++++++++++++++++ 
        
    ser r20
    out DDRB, r20
    ldi r21, 1
set1:   out PORTB, r21
        ;sec
        ROL r21
        brvc set1
        out PORTB, r21 
set0:
    out PORTB, r21
    clc
    ror r21
    brne set0

    rjmp set1

  ++++++++++++++++++++++
           cw29-32
   ++++++++++++++++++++++ 
        
.equ Digits_P = PORTB
.equ Segments_P = PORTD


.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )

.endmacro

    clr r30
    ser r20
    out DDRB, r20
    out DDRD, r20
    ldi r21, 0x11

Main: 
    out Digits_P, r21
    
    ldi r20, 0b00111111 ;cyfra zero
    out Segments_P, r20
    LOAD_CONST r17,r16,5			//delay time ms    
    rcall DelayInMs

    out Segments_P, r20    

    out Digits_P, r21
    rol r21
    adc r21, r30
    
 rjmp Main
            
DelayInMs:  mov r25,r17
            mov r24, r16
Delay:      push r25
            push r24
            LOAD_CONST r25,r24,2000
            rcall DelayOneMs  
            pop r24
            pop r25
            sbiw R25:R24, 1			
			brbc 1, Delay
			ret

DelayOneMs: sbiw R25:R24, 1		//(R*4)+1
			
            brne DelayOneMs
            ret		
            */


 /* ++++++++++++++++++++++
           cw34
   ++++++++++++++++++++++ */
  

                  
.equ Digits_P = PORTB
.equ Segments_P = PORTD

.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )

.endmacro

    ldi r21, 0b00000110;1
    ldi r22, 0b01011011;2
    ldi r23, 0b01001111;3
    ldi r24, 0b01100110;4

    .def Digit_0 = r2
    .def Digit_1 = r3
    .def Digit_2 = r4
    .def Digit_3 = r5

    mov Digit_0, r21
    mov Digit_1, r22
    mov Digit_2, r23
    mov Digit_3, r24

    clr r30
    ser r20
    out DDRB, r20
    out DDRD, r20
    ldi r21, 0x44



Main: 
    out Digits_P, r21
    mov r20, Digit_0 ;cyfra jeden
    out Segments_P, r20
    LOAD_CONST r17,r16,5			//delay time ms    
    rcall DelayInMs
     out Segments_P, r20    

    out Digits_P, r21
    rol r21
    adc r21, r30

    out Segments_P, r20    
    mov r20, Digit_1 ;cyfra dwa
    out Segments_P, r20
    LOAD_CONST r17,r16,5			//delay time ms    
    rcall DelayInMs
     out Segments_P, r20    
     
    out Digits_P, r21
    rol r21
    adc r21, r30

    out Segments_P, r20    
    mov r20, Digit_2 ;cyfra trzy
    out Segments_P, r20
    LOAD_CONST r17,r16,5			//delay time ms    
    rcall DelayInMs
     out Segments_P, r20    

    out Digits_P, r21
    rol r21
    adc r21, r30

    out Segments_P, r20    
    mov r20, Digit_3 ;cyfra cztery
    out Segments_P, r20
    LOAD_CONST r17,r16,5			//delay time ms    
    rcall DelayInMs
    
    out Segments_P, r20    

    out Digits_P, r21
    rol r21
    adc r21, r30
    
 rjmp Main
            
DelayInMs:  mov r25,r17
            mov r24, r16
Delay:      push r25
            push r24
            LOAD_CONST r25,r24,2000
            rcall DelayOneMs  
            pop r24
            pop r25
            sbiw R25:R24, 1			
			brbc 1, Delay
			ret

DelayOneMs: sbiw R25:R24, 1		//(R*4)+1
			
            brne DelayOneMs
            ret		
