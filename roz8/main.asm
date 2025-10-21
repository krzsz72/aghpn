/*
 * main.asm
 *
 *  Created: 10.10.2025 10:44:29
 *   Author: KP
 */ 


/* ++++++++++++++++++++++
           cw20
   ++++++++++++++++++++++  
        

MainLoop:   rcall DelayNCycles ;
            rjmp MainLoop
DelayNCycles: ;zwyk³a etykieta
            nop
            nop
            nop
            ret 
/*
obliczenia: 3x NOP + ret = 3 cycles + 4 = 7 == 0,875us
*/

 /* ++++++++++++++++++++++
           cw21
   ++++++++++++++++++++++ 

 
MainLoop:   rcall DelayNCycles ;
            rjmp MainLoop
DelayNCycles: ;zwyk³a etykieta
            nop
            nop
            rcall test
            nop
            ret 

    test:
        nop
        nop
        nop
        nop
        ret

 /*  ++++++++++++++++++++++
           cw22
   ++++++++++++++++++++++  
   


MainLoop:  
            ldi R22, 1						//delay period         		
Delay:		ldi R24, LOW(2000)
			ldi R25, HIGH(2000)
            
            rcall DelayInMs ;
            rjmp MainLoop
DelayNCycles: ;zwyk³a etykieta
            nop
            nop
            nop
            ret 
            
DelayInMs:        
Count:		sbiw R25:R24, 1		//(R*4)+1
			brne Count
			dec R22
			brbc 1, Delay
			ret								

/*
   ++++++++++++++++++++++
           cw23
   ++++++++++++++++++++++    */
     
MainLoop:  
            ldi R22, 1			//delay time ms
Delay:		ldi R24, LOW(2000)
			ldi R25, HIGH(2000)
            ;tu musi byc od razu rcall DelayInMs
            rcall DelayInMs ;
            rjmp MainLoop

DelayNCycles: ;zwyk³a etykieta
            nop
            nop
            nop
            ret 
            
DelayInMs:  rcall DelayOneMs      
			dec R22
			brbc 1, Delay
			ret

DelayOneMs:	sbiw R25:R24, 1		//(R*4)+1
			brne DelayOneMs
            ret								




/*   ++++++++++++++++++++++
           cw24
   ++++++++++++++++++++++ 

   
     
        ldi r21, 20
loop2:  ldi r20, 100

loop:   dec r20
        nop  //instrukcje
        brne loop
        dec r21
        brne loop2
        


 ++++++++++++++++++++++
           cw25
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
           cw26
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
           cw27
   ++++++++++++++++++++++ 


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




            */