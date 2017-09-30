ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
   4248 01                    8 	wait_time: .db #0x01
                              9 
                             10 	;Screen limits
   4249 C0                   11 	limit_up: .db #0xC0
   424A C7                   12 	limit_down: .db #0xC7
   424B 00                   13 	limit_left: .db #0x00
   424C 4F                   14 	limit_right: .db #0x4F
   424D 50                   15 	line_jump: .db #0x50
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
                              5 ;============================
                              6 ;JUST IN CASE CODE
                              7 ;============================
                              8 
                              9 ;Reenables firmware to be used
                             10 ;CORRUPTS:
                             11 ;	HL
                             12 ;.globl cpct_reenableFirmware_asm
                             13 
                             14 ;============================
                             15 ;USING CODE
                             16 ;============================
                             17 
                             18 	;============================
                             19 	;SPRITE CODE
                             20 	;============================
                             21 
                             22 
                             23 ;2B DE) screen_start	Pointer to the start of the screen (or a backbuffer)
                             24 ;(1B C ) x	[0-79] Byte-aligned column starting from 0 (x coordinate,
                             25 ;(1B B ) y	[0-199] row starting from 0 (y coordinate) in bytes)
                             26 .globl cpct_getScreenPtr_asm
                             27 
                             28 
                             29 ;(2B DE) memory	Video memory pointer to the upper left box corner byte
                             30 ;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
                             31 ;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
                             32 ;(1B B ) height	Box height in bytes (>0)
                             33 .globl cpct_drawSolidBox_asm
                             34 
                             35 
                             36 	;============================
                             37 	;FIRMWARE CODE
                             38 	;============================
                             39 
                             40 ;wait por de raster to be at lowest screen part, to refresh all _DATA
                             41 ;CORRUPTS:
                             42 ;	AF, VC
                             43 .globl cpct_waitVSYNC_asm
                             44 
                             45 ;Disables firmware control, so we can use our colour mode, for example
                             46 .globl cpct_disableFirmware_asm
                             47 
                             48 ;Loads the video mode expressed in register C
                             49 ;CORRUPTS
                             50 ;	AF, BC, HL
                             51 .globl cpct_setVideoMode_asm
                             52 
                             53 	;============================
                             54 	;KEYBOARD CODE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 	;============================
                             56 
                             57 ;Checks if any key is pressed scanning through all the keyboard
                             58 .globl cpct_scanKeyboard_asm
                             59 
                             60 
                             61 ;checks if a given key in HL is pressed
                             62 .globl cpct_isKeyPressed_asm
                             63 
                             64 
                             65 
                             66 
                             67 
                             68 
                             69 
                             70 
                             71 
                             72 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
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
                             14 ;main character functions
                             15 .globl checkUserInput
                             16 .globl jumpControl
                             17 
                             18 ;generic functions
                             19 .globl moveObject
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             32 	.include "sprite.h.s"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             33 
                             34 	;==================
                             35 	;;;PRIVATE FUNCIONS
                             36 	;==================
                             37 
                             38 	;Loads the initial data options
                             39 	;Corrupts:
                             40 	;	C
                             41 
   4030                      42 	initialize:
   4030 CD 3E 41      [17]   43 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   4033 3A 39 00      [13]   44 		ld a, (0x0039) 					;saves data from firmware location
   4036 0E 00         [ 7]   45 		ld c, #0 						;load video mode 0 on screen
   4038 CD 31 41      [17]   46 		call cpct_setVideoMode_asm
                             47 
                             48 		;ld (0x0039), a
                             49 		;call cpct_reenableFirmware_asm
                             50 
   403B C9            [10]   51 		ret
                             52 
                             53 	;Draws the main character on screen
                             54 	;Needs
                             55 	;	A = color pattern of the box
                             56 	;Corrupts:
                             57 	;	HL, DE, AF, BC
                             58 
   403C                      59 	draw_hero:
   403C F5            [11]   60 		push af			;pushes color on the pile
   403D 11 00 C0      [10]   61 		ld de, #0xC000	;beginning of screen
                             62 
   4040 3A 4E 42      [13]   63 		ld a, (hero_x)
   4043 4F            [ 4]   64 		ld c, a 		; b = hero_X
                             65 
   4044 3A 4F 42      [13]   66 		ld a, (hero_y)
   4047 47            [ 4]   67 		ld b, a 		; c = hero_y
                             68 		
   4048 CD FB 41      [17]   69 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             70 
   404B EB            [ 4]   71 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             72 		;ld a, #0xFF  	;red colour
   404C F1            [10]   73 		pop af			;pops the colour
   404D 01 02 08      [10]   74 		ld bc, #0x0802 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             75 		
   4050 CD 4E 41      [17]   76 		call cpct_drawSolidBox_asm ;draw box itself
   4053 C9            [10]   77 		ret
                             78 
                             79 
                             80 	;Waits the wait_time specified
                             81 	;Corrupts
                             82 	;	A;
                             83 
   4054                      84 	esperar:
   4054 3A 48 42      [13]   85 		ld a, (wait_time)
   4057                      86 		bucle:
   4057 76            [ 4]   87 			halt
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   4058 3D            [ 4]   88 			dec a
   4059 20 FC         [12]   89 			jr nz, bucle
                             90 
   405B C9            [10]   91 		ret
                             92 
                             93 
                             94 	;==================
                             95 	;;;PUBLIC FUNCIONS
                             96 	;==================
                             97 
   405C                      98 	_main::
                             99 
   405C CD 30 40      [17]  100 		call initialize		;initializes all functions and firmware options
                            101 
   405F                     102 		_main_bucle:
   405F 3E 00         [ 7]  103 			ld a, #0x00
   4061 CD 3C 40      [17]  104 			call draw_hero		;Erasing the hero
                            105 
   4064 CD C5 40      [17]  106 			call jumpControl	;check jumping situation of the character
   4067 CD E8 40      [17]  107 			call checkUserInput	;Checking if user pressed a key
                            108 
   406A 3E FF         [ 7]  109 			ld a, #0xFF
   406C CD 3C 40      [17]  110 			call draw_hero		;paint hero on screen
                            111 
   406F CD 29 41      [17]  112 			call cpct_waitVSYNC_asm		;wait till repainting
   4072 18 EB         [12]  113 			jr _main_bucle
