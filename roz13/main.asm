/*
 * main.asm
 *
 *  Created: 10.10.2025 10:44:29
 *   Author: KP
 *  cw 40 - cw 44
 */ 


 /* ++++++++++++++++++++++
           cw41
   ++++++++++++++++++++++ */
  

 /*--------   nazwy    --------
.equ Digits_P = PORTB
.equ Segments_P = PORTD


/*--------   tabele    --------
Table: .db 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111 // UWAGA: liczba bajtów zdeklarowanych  w pamiêci kodu musi byæ parzysta


/*--------   makra    --------
.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )
.endmacro

.macro SET_DIGIT
    push r21
    push r20
    push r17
    push r16

    ser r20
    ldi r21, @0
    ldi r21, (2 << @0)
    

    out Digits_P, r21     //zalacz cyfre
    mov r20, Digit_@0             //cyfra
    out Segments_P, r20     //zalacz segmenty
    LOAD_CONST r17,r16,5   //delay time ms    
    rcall DelayInMs
    out Segments_P, r20    //wBLacz segmenty
    out Digits_P, r21       //wBLacz cyfre
    //rol r21                 //obroc razem z carry
    //adc r21, r19

    pop r16
    pop r17
    pop r20
    pop r21

.endmacro

/*.macro debug
    ldi r27, 0xAA
    mov Digit_@0, r27
.endmacro
*/

/*--------   def    --------
.def Digit_0 = r2
.def Digit_1 = r3
.def Digit_2 = r4
.def Digit_3 = r5

/*--------   ladowanie cyfr    --------
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_0, r16
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_1, r16
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_2, r16
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_3, r16



/*--------   pre main    --------
    
   // clr r19
    ser r20


    out DDRB, r20
    out DDRD, r20
    //ldi r21, 0x22       // rysowanie wyswietlacza od drugiej cyfry

    clr r20
    clr r17
    clr r18
    clr r19

    clr r16

    ldi r27, 0xA
    

/*--------   main    --------
Main: 
SET_DIGIT 0
SET_DIGIT 1
SET_DIGIT 2
SET_DIGIT 3

    inc r20
    mov r16, r20
    rcall Digitto7segCode
    mov Digit_3, r16
    cp r20,r27
    brne finishmain
    clr r20    

    inc r17
    mov r16, r17
    rcall Digitto7segCode
    mov Digit_2, r16
    cp r17,r27
    brne finishmain
    clr r17

    inc r18
    mov r16, r18
    rcall Digitto7segCode
    mov Digit_1, r16
    cp r18,r27
    brne finishmain
    clr r18

    inc r19
    mov r16, r19
    rcall Digitto7segCode
    mov Digit_0, r16
    cp r19,r27
    brne finishmain
    clr r19

finishmain:
rjmp Main

//rjmp Main


/*digit3:
            ldi r19, 0
/*                                    mov r16,r19
            rcall Digitto7segCode
            mov Digit_2, r16

            mov r16,r20
            rcall Digitto7segCode
            mov Digit_3, r16
            //rcall writedigits
            inc r20
            cp r20, r27
            brne branchExtend

branchExtend:

    rjmp digit0
*/

         
/*--------   podprogramy    --------
writedigits:
        SET_DIGIT 0
        SET_DIGIT 1
        SET_DIGIT 2
        SET_DIGIT 3
        ret
 
DelayInMs:  
            mov r25,r17
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

/*--------   template    --------

*/

/* ++++++++++++++++++++++
           cw42
   ++++++++++++++++++++++ 
       
.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )
.endmacro

 ;*** Divide ***
; X/Y -> Quotient,Remainder
; Input/Output: R16-19, Internal R24-25

; inputs
.def AL=R16 ; divident
.def AH=R17
.def BL=R18 ; divisor 
.def BH=R19

; outputs
.def RL=R16 ; remainder
.def RH=R17
.def QL=R18 ; quotient
.def QH=R19

; internal
.def QCtrL=R24
.def QCtrH=R25

main:
LOAD_CONST AH,AL,500
LOAD_CONST BH,BL,1000
nop
rcall Divide
nop
rjmp main


Divide:						//AH:AL - dzielna, BH:BL - dzielnik

	push QCtrL
	push QCtrH

DivideLoop:	cp AL, BL
			cpc AH, BH				//porównanie dzielnej i dzielnika

			brmi EndDiv				//je¿eli Y>X to zakoñcz dzielenie Y-Y<0

			sub AL, BL
			sbc AH, BH				//odjêcie dzielnika od dzilnej
			adiw QCtrH:QCtrL, 1		//zwiêkszenie licznika "ca³oœci"
			rjmp DivideLoop

EndDiv:		movw QH:QL, QCtrH:QCtrL

			movw RH:RL, AH:AL

	pop QCtrH
	pop QCtrL
ret
*/

/* ++++++++++++++++++++++
           cw43
   ++++++++++++++++++++++ 
       
.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )
.endmacro

 ;*** Divide ***
; X/Y -> Quotient,Remainder
; Input/Output: R16-19, Internal R24-25

; inputs
.def AL=R16 ; divident
.def AH=R17
.def BL=R18 ; divisor 
.def BH=R19

; outputs
.def RL=R16 ; remainder
.def RH=R17
.def QL=R18 ; quotient
.def QH=R19

; internal
.def QCtrL=R24
.def QCtrH=R25

;*** NumberToDigits ***
;input : Number: R16-17
;output: Digits: R16-19
;internals: X_R,Y_R,Q_R,R_R - see _Divide
; internals
.def Dig0=R22 ; Digits temps
.def Dig1=R23 ;
.def Dig2=R24 ;
.def Dig3=R25 ;

main:

LOAD_CONST r17,r16, 1357
//LOAD_CONST AH,AL,500 ;dzielna

LOAD_CONST BH,BL,1000 ;dzielnik
rcall Divide
mov Dig0, QL

LOAD_CONST BH,BL,100
rcall Divide
mov Dig1, QL

LOAD_CONST BH,BL,10 ;dzielnik
rcall Divide
mov Dig2, QL

mov Dig3, RL


nop
rjmp main


Divide:						//AH:AL - dzielna, BH:BL - dzielnik

	push QCtrL
	push QCtrH

DivideLoop:	cp AL, BL
			cpc AH, BH				//porównanie dzielnej i dzielnika

			brmi EndDiv				//je¿eli Y>X to zakoñcz dzielenie Y-Y<0

			sub AL, BL
			sbc AH, BH				//odjêcie dzielnika od dzilnej
			adiw QCtrH:QCtrL, 1		//zwiêkszenie licznika "ca³oœci"
			rjmp DivideLoop

EndDiv:		movw QH:QL, QCtrH:QCtrL

			movw RH:RL, AH:AL

	pop QCtrH
	pop QCtrL
ret

*/


/* ++++++++++++++++++++++
           cw44
   ++++++++++++++++++++++ */
  

 //--------   nazwy    --------
.equ Digits_P = PORTB
.equ Segments_P = PORTD

//--------   tabele    --------
Table: .db 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111 // UWAGA: liczba bajtów zdeklarowanych  w pamiêci kodu musi byæ parzysta

//--------   makra    --------
.macro LOAD_CONST
    ldi @1, low( @2 )
    ldi @0, high( @2 )
.endmacro

.macro SET_DIGIT
    push r21
    push r20
    push r17
    push r16

    ser r20
    ldi r21, @0
    ldi r21, (2 << @0)

    out Digits_P, r21     //zalacz cyfre
    mov r20, Digit_@0             //cyfra
    out Segments_P, r20     //zalacz segmenty
    LOAD_CONST r17,r16,5   //delay time ms    
    rcall DelayInMs
    out Segments_P, r20    //wBLacz segmenty
    out Digits_P, r21       //wBLacz cyfre
    //rol r21                 //obroc razem z carry
    //adc r21, r19

    pop r16
    pop r17
    pop r20
    pop r21

.endmacro

//--------   def    --------
.def Digit_0 = r2
.def Digit_1 = r3
.def Digit_2 = r4
.def Digit_3 = r5

 ;*** Divide ***
; A/B -> Quotient,Remainder
; Input/Output: R16-19, Internal R24-25

; inputs
.def AL=R16 ; divident
.def AH=R17
.def BL=R18 ; divisor 
.def BH=R19

; outputs
.def RL=R16 ; remainder
.def RH=R17
.def QL=R18 ; quotient
.def QH=R19

; internal
.def QCtrL=R24
.def QCtrH=R25

;*** NumberToDigits ***
;input : Number: R16-17
;output: Digits: R16-19
;internals: X_R,Y_R,Q_R,R_R - see _Divide
; internals
.def Dig0=R22 ; Digits temps
.def Dig1=R23 ;
.def Dig2=R24 ;
.def Dig3=R25 ;

;***licznik binarny***
.def PulseEdgeCtrL=R0
.def PulseEdgeCtrH=R1


//--------   ladowanie cyfr    --------
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_0, r16
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_1, r16
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_2, r16
    ldi r16, 0
    rcall Digitto7segCode
    mov Digit_3, r16

//--------   pre main    --------
    
   // clr r19
    ser r20

    out DDRB, r20
    out DDRD, r20

    clr r20      ;licznik dekadowy
    clr r17
    clr r18
    clr r19

    clr r16

    ldi r27, 0xA

//--------   main    --------
Main: 

movw AH:AL, PulseEdgeCtrH:PulseEdgeCtrL
rcall NumberToDigits
    mov r16, Dig3
    rcall Digitto7segCode
    mov Digit_3, r16

    mov r16, Dig2
    rcall Digitto7segCode
    mov Digit_2, r16

    mov r16, Dig1
    rcall Digitto7segCode
    mov Digit_1, r16

    mov r16, Dig0
    rcall Digitto7segCode
    mov Digit_0, r16

SET_DIGIT 0
SET_DIGIT 1
SET_DIGIT 2
SET_DIGIT 3

    movw r27:r26,PulseEdgeCtrH:PulseEdgeCtrL
    adiw r27:r26, 1
    movw PulseEdgeCtrH:PulseEdgeCtrL,r27:r26
    movw AH:AL,PulseEdgeCtrH:PulseEdgeCtrL
   // LOAD_CONST BH,BL,1000 ;dzielnik 1000
    //rcall Divide
    cpi AH,3
    brne skip
    cpi AL,0xE8
    brne skip
    clr PulseEdgeCtrH
    clr PulseEdgeCtrL
skip:
rjmp Main
    // tysiace podziel, zaladuj do wyswietlenia na trzeciej czyfrze
    // 
    //

    inc r20
    mov r16, r20
    rcall Digitto7segCode
    mov Digit_3, r16
    cp r20,r27
    brne finishmain
    clr r20    

    inc r17
    mov r16, r17
    rcall Digitto7segCode
    mov Digit_2, r16
    cp r17,r27
    brne finishmain
    clr r17

    inc r18
    mov r16, r18
    rcall Digitto7segCode
    mov Digit_1, r16
    cp r18,r27
    brne finishmain
    clr r18

    inc r19
    mov r16, r19
    rcall Digitto7segCode
    mov Digit_0, r16
    cp r19,r27
    brne finishmain
    clr r19

finishmain:
rjmp Main
         
//--------   podprogramy    --------

Divide:						//AH:AL - dzielna, BH:BL - dzielnik

	push QCtrL
	push QCtrH

DivideLoop:	cp AL, BL
			cpc AH, BH				//porównanie dzielnej i dzielnika

			brmi EndDiv				//je¿eli Y>X to zakoñcz dzielenie Y-Y<0

			sub AL, BL
			sbc AH, BH				//odjêcie dzielnika od dzilnej
			adiw QCtrH:QCtrL, 1		//zwiêkszenie licznika "ca³oœci"
			rjmp DivideLoop

EndDiv:		movw QH:QL, QCtrH:QCtrL

			movw RH:RL, AH:AL

	pop QCtrH
	pop QCtrL
ret

DelayInMs:  
            mov r25,r17
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

NumberToDigits:
    LOAD_CONST BH,BL,1000 ;dzielnik
    rcall Divide
    mov Dig0, QL

    LOAD_CONST BH,BL,100
    rcall Divide
    mov Dig1, QL

    LOAD_CONST BH,BL,10 ;dzielnik
    rcall Divide
    mov Dig2, QL

    mov Dig3, RL
ret

//--------   template    --------

