ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
   79A6 01                    8 	wait_time: .db #0x01
                              9 
                             10 	;==================
                             11 	;;;PUBLIC DATA
                             12 	;==================
                             13 
                             14 
                             15 
                             16 .area _CODE
                             17 
                             18 	;==================
                             19 	;;;INCLUDE FUNCIONS
                             20 	;==================
                             21 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             22 	.include "cpctelera.h.s"
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
                             65 .globl cpct_drawCharM0_asm
                             66 
                             67 .globl cpct_drawStringM0_asm
                             68 
                             69 
                             70 
                             71 
                             72 
                             73 
                             74 
                             75 
                             76 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             23 	.include "control.h.s"
                              1 ;===================
                              2 ;;;PUBLIC DATA
                              3 ;===================
                              4 .globl hero_x
                              5 .globl hero_y
                              6 .globl hero_x_size
                              7 .globl hero_y_size
                              8 
                              9 ;===================
                             10 ;;;PUBLIC FUNCTIONS
                             11 ;===================
                             12 
                             13 ;main character functions
                             14 .globl checkUserInput
                             15 .globl jumpControl
                             16 
                             17 ;generic functions
                             18 .globl moveObject
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             24 	.include "sprite.h.s"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             25 	.include "collision.h.s"
                              1 ;===================
                              2 ;;;PUBLIC DATA
                              3 ;===================
                              4 .globl obs_x
                              5 .globl obs_y
                              6 .globl obs_x_size
                              7 .globl obs_y_size
                              8 
                              9 
                             10 ;===================
                             11 ;;;PUBLIC FUNCTIONS
                             12 ;===================
                             13 
                             14 .globl drawBox
                             15 .globl moveBox
                             16 
                             17 ;;Avoids collision between hero and objects
                             18 ;;Saves in register A if pushed or not
                             19 ;;NEEDS:
                             20 ;;	HL:pointer to hero position
                             21 ;;  DE:pointer to list of objects
                             22 ;;CORRUPTS: MY SOUL
                             23 .globl avoidCollision
                             24 
                             25 .globl avoidCollisionRight
                             26 
                             27 .globl avoidCollisionDown
                             28 
                             29 ;;Checks if death collision happened between hero and object
                             30 ;;Saves in register A 1 death, 0 no death
                             31 ;;NEEDS:
                             32 ;;	HL and DE pointers 2 pointers to objects to check
                             33 ;;CORRUPTS: 
                             34 ;;  AF, BC
                             35 
                             36 .globl deathCollision
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             26 	;======
                             27 	;NUEVO|
                             28 	;======
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             29 	.include "hud.h.s"
                              1 .globl hudUpdate
                              2 .globl incPoints
                              3 .globl loadHud
                              4 .globl loseHP
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             30 	.include "menu.h.s"
                              1 .globl loadMenu
                              2 .globl checkMenuInput
                              3 .globl selector
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             31 	.include "shoot.h.s"
                              1 .globl shootBullet
                              2 .globl shootUpdate
                              3 .globl bullet_x
                              4 .globl bullet_y
                              5 .globl bullet_w
                              6 .globl bullet_alive
                              7 .globl drawBullet
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             32 	.include "hero.h.s"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             33 	;==================
                             34 	;;;PRIVATE FUNCIONS
                             35 	;==================
                             36 
                             37 	;Loads the initial data options
                             38 	;Corrupts:
                             39 	;	C
                             40 
   7459                      41 	initialize:
                             42 		
                             43 		;;Enable video mode 0
                             44 		
   7459 CD 91 78      [17]   45 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   745C 3A 39 00      [13]   46 		ld a, (0x0039) 					;saves data from firmware location
   745F 0E 00         [ 7]   47 		ld c, #0 						;load video mode 0 on screen
   7461 CD 84 78      [17]   48 		call cpct_setVideoMode_asm
                             49 
                             50 
                             51 		;;Draw principal Sprite
                             52 
                             53 		
   7464 C9            [10]   54 		ret
                             55 
                             56 	;Draws the main character on screen
                             57 	;Needs
                             58 	;	A = color pattern of the box
                             59 	;Corrupts:
                             60 	;	HL, DE, AF, BC
                             61 
   7465                      62 	draw_hero:
   7465 F5            [11]   63 		push af			;pushes color on the pile
   7466 11 00 C0      [10]   64 		ld de, #0xC000	;beginning of screen
                             65 
   7469 3A B8 79      [13]   66 		ld a, (hero_x)
   746C 4F            [ 4]   67 		ld c, a 		; b = hero_X
                             68 
   746D 3A B9 79      [13]   69 		ld a, (hero_y)
   7470 47            [ 4]   70 		ld b, a 		; c = hero_y
                             71 		
   7471 CD 4E 79      [17]   72 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             73 
   7474 EB            [ 4]   74 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             75 		;ld a, #0xFF  	;red colour
   7475 F1            [10]   76 		pop af			;pops the colour
   7476 01 04 10      [10]   77 		ld bc, #0x1004 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             78 		
   7479 CD A1 78      [17]   79 		call cpct_drawSolidBox_asm ;draw box itself
   747C C9            [10]   80 		ret
                             81 
                             82 
                             83 	;Waits the wait_time specified
                             84 	;Corrupts
                             85 	;	A;
                             86 
   747D                      87 	esperar:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



   747D 3A A6 79      [13]   88 		ld a, (wait_time)
   7480                      89 		bucle:
   7480 76            [ 4]   90 			halt
   7481 3D            [ 4]   91 			dec a
   7482 20 FC         [12]   92 			jr nz, bucle
                             93 
   7484 C9            [10]   94 		ret
                             95 
                             96 	;======
                             97 	;NUEVO|
                             98 	;======
   7485                      99 	checkStart:
   7485 3A 9B 79      [13]  100 		ld 		a, (selector)
   7488 FE 0A         [ 7]  101 		cp 		#0x0A
   748A 28 01         [12]  102 		jr 		z, clear
   748C C9            [10]  103 		ret
                            104 	;======
                            105 	;NUEVO|
                            106 	;======
   748D                     107 	clear:
                            108 		;LIMPIAR PUTA PANTALLA
   748D 21 00 C0      [10]  109 		ld 		hl, #0xC000
   7490                     110 		working:
   7490 3E 00         [ 7]  111 		ld 		a, #0x00
   7492 77            [ 7]  112 		ld 		(hl), a
   7493 23            [ 6]  113 		inc 	hl
   7494 7D            [ 4]  114 		ld 		a, l
   7495 D6 FF         [ 7]  115 		sub 	#0xFF
   7497 20 F7         [12]  116 		jr 		nz, working
   7499 7C            [ 4]  117 		ld 		a, h
   749A D6 FF         [ 7]  118 		sub 	#0xFF
   749C 20 F2         [12]  119 		jr 		nz, working
   749E CD E0 74      [17]  120 		call 	loadHud
   74A1 18 12         [12]  121 		jr 		_main_bucle
   74A3 C9            [10]  122 		ret
                            123 
                            124 	;==================
                            125 	;;;PUBLIC FUNCIONS
                            126 	;==================
                            127 
   74A4                     128 	_main::
                            129 
   74A4 CD 59 74      [17]  130 		call initialize		;initializes all functions and firmware options
                            131 		;======
                            132 		;NUEVO|
                            133 		;======
   74A7 CD D8 73      [17]  134 		call 	loadMenu
                            135 		;======
                            136 		;NUEVO|
                            137 		;======
   74AA                     138 		_menu_bucle:
   74AA CD FD 73      [17]  139 			call	checkMenuInput
   74AD CD 85 74      [17]  140 			call 	checkStart
   74B0 CD 7C 78      [17]  141 			call 	cpct_waitVSYNC_asm
   74B3 18 F5         [12]  142 			jr 		_menu_bucle
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   74B5                     143 		_main_bucle:
   74B5 3E 00         [ 7]  144 			ld a, #0x00
   74B7 CD 65 74      [17]  145 			call draw_hero		;Erasing the hero
                            146 
   74BA 3E 00         [ 7]  147 			ld a, #0x00
   74BC CD 86 75      [17]  148 			call drawBox 		;Erase testing box
   74BF CD 9E 75      [17]  149 			call moveBox		;move testBox
                            150 
                            151 			;======
                            152 			;NUEVO|
                            153 			;======
   74C2 CD EA 74      [17]  154 			call hudUpdate
   74C5 CD 3C 77      [17]  155 			call jumpControl	;check jumping situation of the character
   74C8 CD 76 77      [17]  156 			call checkUserInput	;Checking if user pressed a key
                            157 
   74CB 3E FF         [ 7]  158 			ld a, #0xFF
   74CD CD 65 74      [17]  159 			call draw_hero		;paint hero on screen
                            160 
   74D0 3E FF         [ 7]  161 			ld a, #0xFF
   74D2 CD 86 75      [17]  162 			call drawBox 		;draw testing box
                            163 
                            164 			;======
                            165 			;NUEVO|
                            166 			;======
   74D5 CD 4B 76      [17]  167 			call shootBullet
   74D8 CD 65 76      [17]  168 			call shootUpdate
                            169 
   74DB CD 7C 78      [17]  170 			call cpct_waitVSYNC_asm		;wait till repainting
   74DE 18 D5         [12]  171 			jr _main_bucle
