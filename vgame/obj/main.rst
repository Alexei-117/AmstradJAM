ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;Controles
   4118 3D                    4 	key_right: .db #61
   4119 45                    5 	key_left: .db #69
   411A 3B                    6 	key_jump: .db #59
                              7 
                              8 	;Variables del héroe
   411B 3C                    9 	hero_x: .db #60
   411C 50                   10 	hero_y: .db #80
                             11 
                             12 	;Control Variables
   411D 06                   13 	wait_time: .db #0x06
                             14 
                             15 .area _CODE
                             16 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             17 	.include "cpctelera.h.s"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             18 
                             19 	;============================
                             20 	;JUST IN CASE CODE
                             21 	;============================
                             22 
                             23 	;Checks if any key is pressed scanning through all the keyboard
                             24 	;.globl cpct_scanKeyboard_asm
                             25 
                             26 	;.include "keyboard/keyboard.s"
                             27 
                             28 	;checks if a given key in HL is pressed
                             29 	;.globl cpct_isKeyPressed_asm
                             30 
                             31 	;============================
                             32 	;USING CODE
                             33 	;============================
                             34 	
                             35 	;2B DE) screen_start	Pointer to the start of the screen (or a backbuffer)
                             36 	;(1B C ) x	[0-79] Byte-aligned column starting from 0 (x coordinate,
                             37 	;(1B B ) y	[0-199] row starting from 0 (y coordinate) in bytes)
                             38 	.globl cpct_getScreenPtr_asm
                             39 
                             40 
                             41 	;(2B DE) memory	Video memory pointer to the upper left box corner byte
                             42 	;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
                             43 	;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
                             44 	;(1B B ) height	Box height in bytes (>0)
                             45 	.globl cpct_drawSolidBox_asm
                             46 
                             47 	;wait por de raster to be at lowest screen part, to refresh all _DATA
                             48 	.globl cpct_waitVSYNC_asm
                             49 
                             50 
                             51 ;Draws the main character on screen
                             52 ;Needs
                             53 ;	A = color pattern of the box
                             54 
   4000                      55 draw_hero:
   4000 F5            [11]   56 	push af			;pushes color on the pile
   4001 11 00 C0      [10]   57 	ld de, #0xC000	;beginning of screen
                             58 
   4004 3A 1B 41      [13]   59 	ld a, (hero_x)
   4007 4F            [ 4]   60 	ld c, a 		; b = hero_X
                             61 
   4008 3A 1C 41      [13]   62 	ld a, (hero_y)
   400B 47            [ 4]   63 	ld b, a 		; c = hero_y
                             64 	
   400C CD FC 40      [17]   65 	call cpct_getScreenPtr_asm
                             66 
   400F EB            [ 4]   67 	ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             68 	;ld a, #0xFF  	;red colour
   4010 F1            [10]   69 	pop af			;pops the colour
   4011 01 02 08      [10]   70 	ld bc, #0x0802 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             71 	
   4014 CD 4F 40      [17]   72 	call cpct_drawSolidBox_asm ;draw box itself
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



   4017 C9            [10]   73 	ret
                             74 
                             75 
                             76 ;Check if user pressed a key
   4018                      77 checkUserInput:
                             78 	;;======
                             79 	;; Fran's approach
                             80 	;;======
                             81 
                             82 	
                             83 	;call cpct_scanKeyboard_asm  ;checks a key is pressed
                             84 	;
                             85 	;ld hl, #Key_D 				 ;loads key_D in hl
                             86 	;call cpct_isKeyPressed_asm	 ;checks if the key loaded in hl is pressed
                             87 	;cp #0 						 ;checks if debugger leaves a 0 behind, if it is 0, then D is not pressed
                             88 	;jr z, d_not_pressed		 ;This goes to d not pressed zone, if not it is pressed
                             89 
                             90 
                             91 	;;=====================
                             92 	;; Own approach
                             93 	;;=====================
   4018 3A 18 41      [13]   94 	ld a, (key_right)		;check if right button is pressed
   401B CD 1E BB      [17]   95 	call #0xBB1E				;call the checker KM_TEST KEY
   401E 20 02         [12]   96 	jr nz, pressedRight			;Not Zero = pressed.
                             97 
                             98 
                             99 	;continous NOT pressed
   4020 18 07         [12]  100 	jr continueRight 		;if not pressed, just continues
                            101 
                            102 	;PRESSED
   4022                     103 	pressedRight:
   4022 3A 1B 41      [13]  104 		ld a, (hero_x)		;increases x position of the player
   4025 3C            [ 4]  105 		inc a 				;and saves it in hero_x again
   4026 32 1B 41      [13]  106 		ld (hero_x), a
                            107 
                            108 
   4029                     109 	continueRight:
                            110 
   4029 C9            [10]  111 	ret
                            112 
   402A                     113 esperar:
   402A 3A 1D 41      [13]  114 	ld a, (wait_time)
   402D                     115 	bucle:
   402D 76            [ 4]  116 		halt
   402E 3D            [ 4]  117 		dec a
   402F 20 FC         [12]  118 		jr nz, bucle
                            119 
   4031 CD 47 40      [17]  120 	call cpct_waitVSYNC_asm
                            121 
   4034 C9            [10]  122 	ret
                            123 
                            124 
                            125 ;;====================
                            126 ;; Main of the program
                            127 ;;====================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            128 
   4035                     129 _main::
   4035 3E 00         [ 7]  130 	ld a, #0x00
   4037 CD 00 40      [17]  131 	call draw_hero		;Erasing the hero
                            132 
                            133 
   403A CD 18 40      [17]  134 	call checkUserInput	;Checking if user pressed a key
                            135 
   403D 3E FF         [ 7]  136 	ld a, #0xFF
   403F CD 00 40      [17]  137 	call draw_hero		;paint hero on screen
                            138 
   4042 CD 2A 40      [17]  139 	call esperar		;wait till repainting
   4045 18 EE         [12]  140 	jr _main
