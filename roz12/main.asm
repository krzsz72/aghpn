/*
 * main.asm
 *
 *  Created: 10.10.2025 10:44:29
 *   Author: KP
 *  cw 40 - cw 44
 */ 


/* ++++++++++++++++++++++
           cw36
   ++++++++++++++++++++++ 
        
 
 // Program odczytuje 4 bajty z tablicy sta³ych zdefiniowanej w pamiêci kodu do rejestrów
//R20..R23
ldi R30, low(Table<<1) // inicjalizacja rejestru Z
ldi R31, high(Table<<1)
lpm R20, Z // odczyt pierwszej sta³ej z tablicy Table
adiw R30:R31,1 // inkrementacja Z
lpm R21, Z // odczyt drugiej sta³ej
adiw R30:R31,1 // inkrementacja Z
lpm R22, Z // odczyt trzeciej sta³ej
adiw R30:R31,1 // inkrementacja Z
lpm R23, Z // odczyt czwartej sta³ej
nop
nop
nop
Table: .db 0x57, 0x58, 0x59, 0x5A // UWAGA: liczba bajtów zdeklarowanych
// w pamiêci kodu musi byæ parzysta
nop


/* ++++++++++++++++++++++
           cw37
   ++++++++++++++++++++++ 
        

main:
ldi r16, 2
rcall square
nop
nop

Table: .db 0, 1, 4, 9, 16, 25, 36, 49, 64, 81 // UWAGA: liczba bajtów zdeklarowanych
// w pamiêci kodu musi byæ parzysta
rjmp main


 square:
ldi R30, low(Table<<1) // inicjalizacja rejestru Z
ldi R31, high(Table<<1)

      ldi r20, 0

    cntr:   CP r16, r20
            breq skip
            inc r20
            rjmp cntr
    skip:
          add r30, r20
          lpm r16, z
          ret

 /* ++++++++++++++++++++++
           cw38
   ++++++++++++++++++++++ 
        

main:
ldi r16, 2
rcall Digitto7segCode
nop
nop

Table: .db 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111 // UWAGA: liczba bajtów zdeklarowanych
// w pamiêci kodu musi byæ parzysta
rjmp main


Digitto7segCode:
push r30
push r31
push r20

ldi R30, low(Table<<1) // inicjalizacja rejestru Z
ldi R31, high(Table<<1)

    ldi r20, 0

cntr:
    CP r16, r20
    breq skip
    inc r20
    rjmp cntr
skip:
    add r30, r20
    lpm r16, z

pop r20
pop r31
pop r30
    ret

 
 
 /* ++++++++++++++++++++++
           cw39
   ++++++++++++++++++++++ */
  

 /*--------   nazwy    --------*/
.equ Digits_P = PORTB
.equ Segments_P = PORTD


/*--------   tabele    --------*/
Table: .db 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111 // UWAGA: liczba bajtów zdeklarowanych  w pamiêci kodu musi byæ parzysta


/*--------   makra    --------*/
.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )
.endmacro

.macro SET_DIGIT
    
    ldi r21, @0
    //rcall DecToOneHot
    ldi r21, (2 << @0)
    

    out Digits_P, r21     //zalacz cyfre
    mov r20, Digit_@0             //cyfra
    out Segments_P, r20     //zalacz segmenty
    LOAD_CONST r17,r16,5    //delay time ms    
    rcall DelayInMs
    out Segments_P, r20    //wylacz segmenty
    out Digits_P, r21       //wylacz cyfre
    //rol r21                 //obroc razem z carry
    //adc r21, r19

.endmacro

/*.macro debug
    ldi r27, 0xAA
    mov Digit_@0, r27
.endmacro
*/

/*--------   def    --------*/
.def Digit_0 = r2
.def Digit_1 = r3
.def Digit_2 = r4
.def Digit_3 = r5

/*--------   ladowanie cyfr    --------*/
    ldi r16, 9
    rcall Digitto7segCode
    mov Digit_0, r16
    ldi r16, 8
    rcall Digitto7segCode
    mov Digit_1, r16
    ldi r16, 7
    rcall Digitto7segCode
    mov Digit_2, r16
    ldi r16, 6
    rcall Digitto7segCode
    mov Digit_3, r16



/*--------   pre main    --------*/
    
    clr r19
    ser r20


    out DDRB, r20
    out DDRD, r20
    ldi r21, 0x22       // rysowanie wyswietlacza od drugiej cyfry

/*--------   main    --------*/
Main: 

    SET_DIGIT 0
    SET_DIGIT 1
    SET_DIGIT 2
    SET_DIGIT 3
 
rjmp Main
         
/*--------   podprogramy    --------*/   
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

Digitto7segCode:
    push r30
    push r31
    push r20

        ldi R30, low(Table<<1) // inicjalizacja rejestru Z
        ldi R31, high(Table<<1)
        ldi r20, 0

    cntr0:
        CP r16, r20
        breq skip0
        inc r20
        rjmp cntr0
    skip0:
        add r30, r20
        lpm r16, z

    pop r20
    pop r31
    pop r30
     ret    

/*--------   template    --------*/
