ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
   4131 01                    8 	wait_time: .db #0x01
                              9 
                             10 	;Screen limits
   4132 C0                   11 	limit_up: .db #0xC0
   4133 C7                   12 	limit_down: .db #0xC7
   4134 00                   13 	limit_left: .db #0x00
   4135 4F                   14 	limit_right: .db #0x4F
   4136 50                   15 	line_jump: .db #0x50
                             16 
                             17 
                             18 	;==================
                             19 	;;;PUBLIC DATA
                             20 	;==================
                             21 
                             22 
                             23 
                             24 .area _CODE
                             25 
                             26 	;==================
                             27 	;;;INCLUDE FUNCIONS
                             28 	;==================
                             29 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             30 	.include "cpctelera.h.s"
                              1 ;;;;;;;;;;;;;;;;;;;
                              2 ;CPCTELERA SYMBOLS;
                              3 ;;;;;;;;;;;;;;;;;;;
                              4 
                              5 
                              6 ;============================
                              7 ;JUST IN CASE CODE
                              8 ;============================
                              9 
                             10 ;Checks if any key is pressed scanning through all the keyboard
                             11 ;.globl cpct_scanKeyboard_asm
                             12 
                             13 ;.include "keyboard/keyboard.s"
                             14 
                             15 ;checks if a given key in HL is pressed
                             16 ;.globl cpct_isKeyPressed_asm
                             17 
                             18 ;============================
                             19 ;USING CODE
                             20 ;============================
                             21 
                             22 ;2B DE) screen_start	Pointer to the start of the screen (or a backbuffer)
                             23 ;(1B C ) x	[0-79] Byte-aligned column starting from 0 (x coordinate,
                             24 ;(1B B ) y	[0-199] row starting from 0 (y coordinate) in bytes)
                             25 .globl cpct_getScreenPtr_asm
                             26 
                             27 
                             28 ;(2B DE) memory	Video memory pointer to the upper left box corner byte
                             29 ;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
                             30 ;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
                             31 ;(1B B ) height	Box height in bytes (>0)
                             32 .globl cpct_drawSolidBox_asm
                             33 
                             34 ;wait por de raster to be at lowest screen part, to refresh all _DATA
                             35 .globl cpct_waitVSYNC_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             31 	.include "control.h.s"
                              1 ;===================
                              2 ;;;PUBLIC DATA
                              3 ;===================
                              4 .globl hero_x
                              5 .globl hero_y
                              6 .globl hero_x_size
                              7 .globl hero_y_size
                              8 
                              9 
                             10 ;===================
                             11 ;;;PUBLIC FUNCTIONS
                             12 ;===================
                             13 
                             14 .globl checkUserInput
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             32 
                             33 
                             34 	;==================
                             35 	;;;PRIVATE FUNCIONS
                             36 	;==================
                             37 
                             38 
                             39 	;Draws the main character on screen
                             40 	;Needs
                             41 	;	A = color pattern of the box
                             42 	;Corrupts:
                             43 	;	HL, DE, AF, BC
                             44 
   4000                      45 	draw_hero:
   4000 F5            [11]   46 		push af			;pushes color on the pile
   4001 11 00 C0      [10]   47 		ld de, #0xC000	;beginning of screen
                             48 
   4004 3A 3A 41      [13]   49 		ld a, (hero_x)
   4007 4F            [ 4]   50 		ld c, a 		; b = hero_X
                             51 
   4008 3A 3B 41      [13]   52 		ld a, (hero_y)
   400B 47            [ 4]   53 		ld b, a 		; c = hero_y
                             54 		
   400C CD 15 41      [17]   55 		call cpct_getScreenPtr_asm
                             56 
   400F EB            [ 4]   57 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             58 		;ld a, #0xFF  	;red colour
   4010 F1            [10]   59 		pop af			;pops the colour
   4011 01 02 08      [10]   60 		ld bc, #0x0802 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             61 		
   4014 CD 68 40      [17]   62 		call cpct_drawSolidBox_asm ;draw box itself
   4017 C9            [10]   63 		ret
                             64 
                             65 
                             66 	;Waits the wait_time specified
                             67 	;Corrupts
                             68 	;	A;
                             69 
   4018                      70 	esperar:
   4018 3A 31 41      [13]   71 		ld a, (wait_time)
   401B                      72 		bucle:
   401B 76            [ 4]   73 			halt
   401C 3D            [ 4]   74 			dec a
   401D 20 FC         [12]   75 			jr nz, bucle
                             76 
   401F CD 60 40      [17]   77 		call cpct_waitVSYNC_asm
                             78 
   4022 C9            [10]   79 		ret
                             80 
                             81 
                             82 	;==================
                             83 	;;;PUBLIC FUNCIONS
                             84 	;==================
                             85 
   4023                      86 	_main::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4023 3E 00         [ 7]   87 		ld a, #0x00
   4025 CD 00 40      [17]   88 		call draw_hero		;Erasing the hero
                             89 
                             90 
   4028 CD 45 40      [17]   91 		call checkUserInput	;Checking if user pressed a key
                             92 
   402B 3E FF         [ 7]   93 		ld a, #0xFF
   402D CD 00 40      [17]   94 		call draw_hero		;paint hero on screen
                             95 
   4030 CD 18 40      [17]   96 		call esperar		;wait till repainting
   4033 18 EE         [12]   97 		jr _main
