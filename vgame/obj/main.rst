ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
   448C 01                    8 	wait_time: .db #0x01
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
                             25 ;;Checks if death collision happened between hero and object
                             26 ;;Saves in register A 1 death, 0 no death
                             27 ;;NEEDS:
                             28 ;;	Pushed 2 pointers to objects to check
                             29 ;;CORRUPTS: 
                             30 ;;  AF, BC
                             31 
                             32 .globl deathCollision
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             26 
                             27 	;==================
                             28 	;;;PRIVATE FUNCIONS
                             29 	;==================
                             30 
                             31 	;Loads the initial data options
                             32 	;Corrupts:
                             33 	;	C
                             34 
   40C0                      35 	initialize:
   40C0 CD 82 43      [17]   36 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   40C3 3A 39 00      [13]   37 		ld a, (0x0039) 					;saves data from firmware location
   40C6 0E 00         [ 7]   38 		ld c, #0 						;load video mode 0 on screen
   40C8 CD 75 43      [17]   39 		call cpct_setVideoMode_asm
                             40 
   40CB C9            [10]   41 		ret
                             42 
                             43 	;Draws the main character on screen
                             44 	;Needs
                             45 	;	A = color pattern of the box
                             46 	;Corrupts:
                             47 	;	HL, DE, AF, BC
                             48 
   40CC                      49 	draw_hero:
   40CC F5            [11]   50 		push af			;pushes color on the pile
   40CD 11 00 C0      [10]   51 		ld de, #0xC000	;beginning of screen
                             52 
   40D0 3A 91 44      [13]   53 		ld a, (hero_x)
   40D3 4F            [ 4]   54 		ld c, a 		; b = hero_X
                             55 
   40D4 3A 92 44      [13]   56 		ld a, (hero_y)
   40D7 47            [ 4]   57 		ld b, a 		; c = hero_y
                             58 		
   40D8 CD 3F 44      [17]   59 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             60 
   40DB EB            [ 4]   61 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             62 		;ld a, #0xFF  	;red colour
   40DC F1            [10]   63 		pop af			;pops the colour
   40DD 01 04 10      [10]   64 		ld bc, #0x1004 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             65 		
   40E0 CD 92 43      [17]   66 		call cpct_drawSolidBox_asm ;draw box itself
   40E3 C9            [10]   67 		ret
                             68 
                             69 
                             70 	;Waits the wait_time specified
                             71 	;Corrupts
                             72 	;	A;
                             73 
   40E4                      74 	esperar:
   40E4 3A 8C 44      [13]   75 		ld a, (wait_time)
   40E7                      76 		bucle:
   40E7 76            [ 4]   77 			halt
   40E8 3D            [ 4]   78 			dec a
   40E9 20 FC         [12]   79 			jr nz, bucle
                             80 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   40EB C9            [10]   81 		ret
                             82 
                             83 
                             84 	;==================
                             85 	;;;PUBLIC FUNCIONS
                             86 	;==================
                             87 
   40EC                      88 	_main::
                             89 
   40EC CD C0 40      [17]   90 		call initialize		;initializes all functions and firmware options
                             91 
   40EF                      92 		_main_bucle:
   40EF 3E 00         [ 7]   93 			ld a, #0x00
   40F1 CD CC 40      [17]   94 			call draw_hero		;Erasing the hero
                             95 
   40F4 3E 00         [ 7]   96 			ld a, #0x00
   40F6 CD 11 41      [17]   97 			call drawBox 		;Erase testing box
   40F9 CD 29 41      [17]   98 			call moveBox		;move testBox
                             99 
                            100 
   40FC CD 23 42      [17]  101 			call jumpControl	;check jumping situation of the character
   40FF CD 5D 42      [17]  102 			call checkUserInput	;Checking if user pressed a key
                            103 
   4102 3E FF         [ 7]  104 			ld a, #0xFF
   4104 CD CC 40      [17]  105 			call draw_hero		;paint hero on screen
                            106 
   4107 3E FF         [ 7]  107 			ld a, #0xFF
   4109 CD 11 41      [17]  108 			call drawBox 		;draw testing box
                            109 
                            110 
   410C CD 6D 43      [17]  111 			call cpct_waitVSYNC_asm		;wait till repainting
   410F 18 DE         [12]  112 			jr _main_bucle
