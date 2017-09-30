ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
   46DE 01                    8 	wait_time: .db #0x01
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
                             32 ;;	Pushed 2 pointers to objects to check
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
   4191                      41 	initialize:
   4191 CD C9 45      [17]   42 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   4194 3A 39 00      [13]   43 		ld a, (0x0039) 					;saves data from firmware location
   4197 0E 00         [ 7]   44 		ld c, #0 						;load video mode 0 on screen
   4199 CD BC 45      [17]   45 		call cpct_setVideoMode_asm
                             46 
   419C C9            [10]   47 		ret
                             48 
                             49 	;Draws the main character on screen
                             50 	;Needs
                             51 	;	A = color pattern of the box
                             52 	;Corrupts:
                             53 	;	HL, DE, AF, BC
                             54 
   419D                      55 	draw_hero:
   419D F5            [11]   56 		push af			;pushes color on the pile
   419E 11 00 C0      [10]   57 		ld de, #0xC000	;beginning of screen
                             58 
   41A1 3A F0 46      [13]   59 		ld a, (hero_x)
   41A4 4F            [ 4]   60 		ld c, a 		; b = hero_X
                             61 
   41A5 3A F1 46      [13]   62 		ld a, (hero_y)
   41A8 47            [ 4]   63 		ld b, a 		; c = hero_y
                             64 		
   41A9 CD 86 46      [17]   65 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             66 
   41AC EB            [ 4]   67 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             68 		;ld a, #0xFF  	;red colour
   41AD F1            [10]   69 		pop af			;pops the colour
   41AE 01 04 10      [10]   70 		ld bc, #0x1004 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             71 		
   41B1 CD D9 45      [17]   72 		call cpct_drawSolidBox_asm ;draw box itself
   41B4 C9            [10]   73 		ret
                             74 
                             75 
                             76 	;Waits the wait_time specified
                             77 	;Corrupts
                             78 	;	A;
                             79 
   41B5                      80 	esperar:
   41B5 3A DE 46      [13]   81 		ld a, (wait_time)
   41B8                      82 		bucle:
   41B8 76            [ 4]   83 			halt
   41B9 3D            [ 4]   84 			dec a
   41BA 20 FC         [12]   85 			jr nz, bucle
                             86 
   41BC C9            [10]   87 		ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                             88 
                             89 	;======
                             90 	;NUEVO|
                             91 	;======
   41BD                      92 	checkStart:
   41BD 3A D3 46      [13]   93 		ld 		a, (selector)
   41C0 FE 0A         [ 7]   94 		cp 		#0x0A
   41C2 28 01         [12]   95 		jr 		z, clear
   41C4 C9            [10]   96 		ret
                             97 	;======
                             98 	;NUEVO|
                             99 	;======
   41C5                     100 	clear:
                            101 		;LIMPIAR PUTA PANTALLA
   41C5 21 00 C0      [10]  102 		ld 		hl, #0xC000
   41C8                     103 		working:
   41C8 3E 00         [ 7]  104 		ld 		a, #0x00
   41CA 77            [ 7]  105 		ld 		(hl), a
   41CB 23            [ 6]  106 		inc 	hl
   41CC 7D            [ 4]  107 		ld 		a, l
   41CD D6 FF         [ 7]  108 		sub 	#0xFF
   41CF 20 F7         [12]  109 		jr 		nz, working
   41D1 7C            [ 4]  110 		ld 		a, h
   41D2 D6 FF         [ 7]  111 		sub 	#0xFF
   41D4 20 F2         [12]  112 		jr 		nz, working
   41D6 CD 18 42      [17]  113 		call 	loadHud
   41D9 18 12         [12]  114 		jr 		_main_bucle
   41DB C9            [10]  115 		ret
                            116 
                            117 	;==================
                            118 	;;;PUBLIC FUNCIONS
                            119 	;==================
                            120 
   41DC                     121 	_main::
                            122 
   41DC CD 91 41      [17]  123 		call initialize		;initializes all functions and firmware options
                            124 		;======
                            125 		;NUEVO|
                            126 		;======
   41DF CD 10 41      [17]  127 		call 	loadMenu
                            128 		;======
                            129 		;NUEVO|
                            130 		;======
   41E2                     131 		_menu_bucle:
   41E2 CD 35 41      [17]  132 			call	checkMenuInput
   41E5 CD BD 41      [17]  133 			call 	checkStart
   41E8 CD B4 45      [17]  134 			call 	cpct_waitVSYNC_asm
   41EB 18 F5         [12]  135 			jr 		_menu_bucle
   41ED                     136 		_main_bucle:
   41ED 3E 00         [ 7]  137 			ld a, #0x00
   41EF CD 9D 41      [17]  138 			call draw_hero		;Erasing the hero
                            139 
   41F2 3E 00         [ 7]  140 			ld a, #0x00
   41F4 CD BE 42      [17]  141 			call drawBox 		;Erase testing box
   41F7 CD D6 42      [17]  142 			call moveBox		;move testBox
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            143 
                            144 			;======
                            145 			;NUEVO|
                            146 			;======
   41FA CD 22 42      [17]  147 			call hudUpdate
                            148 
   41FD CD 74 44      [17]  149 			call jumpControl	;check jumping situation of the character
   4200 CD AE 44      [17]  150 			call checkUserInput	;Checking if user pressed a key
                            151 
   4203 3E FF         [ 7]  152 			ld a, #0xFF
   4205 CD 9D 41      [17]  153 			call draw_hero		;paint hero on screen
                            154 
   4208 3E FF         [ 7]  155 			ld a, #0xFF
   420A CD BE 42      [17]  156 			call drawBox 		;draw testing box
                            157 
                            158 			;======
                            159 			;NUEVO|
                            160 			;======
   420D CD 83 43      [17]  161 			call shootBullet
   4210 CD 9D 43      [17]  162 			call shootUpdate
                            163 
   4213 CD B4 45      [17]  164 			call cpct_waitVSYNC_asm		;wait till repainting
   4216 18 D5         [12]  165 			jr _main_bucle
