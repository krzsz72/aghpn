/*
 * main.asm
 *
 *  Created: 10.10.2025 10:44:29
 *   Author: KP
 */ 


/* ++++++++++++++++++++++
           cw12
   ++++++++++++++++++++++  
        nop
        ldi r20, 5
Loop:   dec r20
        brne Loop
        nop
        nop



  ++++++++++++++++++++++
           cw13
   ++++++++++++++++++++++ 

        
        ldi r20, 2
Loop:   dec r20
        nop
        nop
        brne Loop
        nop
        nop
        nop
        nop
        nop
        nop

//cycles = (n + 1) * R20

 /*  ++++++++++++++++++++++
           cw14
   ++++++++++++++++++++++   
   

        ldi r21, 5
loop2:  ldi r20, 100

loop:   dec r20
        nop  //instrukcje
        brne loop
        dec r21
        brne loop2
        
        nop
        nop





   ++++++++++++++++++++++
           cw15
   ++++++++++++++++++++++    

   
        ldi r21, 100
loop2:  ldi r20, 100

loop:   dec r20
        nop  //instrukcje
        brne loop
        dec r21
        brne loop2
        
        nop
        nop

   ++++++++++++++++++++++
           cw16
   ++++++++++++++++++++++ 

   
     
        ldi r21, 20
loop2:  ldi r20, 100

loop:   dec r20
        nop  //instrukcje
        brne loop
        dec r21
        brne loop2
        


 ++++++++++++++++++++++
           cw17
   ++++++++++++++++++++++ 

        ldi r22, 10
mili:   ldi r21, 20
loop2:  ldi r20, 100

loop:   dec r20
        nop  //instrukcje
        brne loop
        dec r21
        brne loop2
        dec r22
        brne mili

   /* ------------------------stare
        ldi r22, 100

loop_mili: 
        ldi r20, 0xD0
        ldi r21, 0x07
        inc r21
Loop_big: nop
    Loop_small:     dec r20
                        nop  //instrukcje
                    brne Loop_small
        dec r21
        brne Loop_big
        
        dec r22
        brne loop_mili

        nop



/* ++++++++++++++++++++++
           cw18
   ++++++++++++++++++++++ 

        ldi r16,1
        ldi r17,0
        ldi r22, 1 //opoznienie w ms

loop_mili: 
        ldi r20, 0xE6 //0xD0
Loop_big: ldi r21, 0x9B //0x07


          nop  //instrukcje
    Loop_small:     adc r21,r16
                       
                    brcc Loop_small // trzeba od 07d0 odjac 1ms i wtedy carry sie ustawi jak dodajemy
        add r20, r16               // ffff- 07d0 = F82F
        brcc Loop_big
        
        dec r22
        brne loop_mili
        nop



 ++++++++++++++++++++++     0x6419
           cw19
   ++++++++++++++++++++++ */ 


   			ldi R22, 1						//delay period
					
			// R16 - m³odszy bajt
			// R17 - starszy bajt
			
			// - petla Delay
Delay:		ldi R24, LOW(2000)
			ldi R25, HIGH(2000)

Count:		sbiw R25:R24, 1		//(R*4)+1
			brne Count

			dec R22
			brbc 1, Delay
			// petla Delay -


			nop								//debug




