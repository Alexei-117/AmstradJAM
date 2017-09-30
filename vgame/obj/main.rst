ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
<<<<<<< HEAD
   4A85 01                    8 	wait_time: .db #0x01
=======
   470C 01                    8 	wait_time: .db #0x01
>>>>>>> 60fbd1c2a1d49d64fa63cfbf8d8016fb08aea566
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
<<<<<<< HEAD
   46D8                      35 	initialize:
   46D8 CD 7B 49      [17]   36 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   46DB 3A 39 00      [13]   37 		ld a, (0x0039) 					;saves data from firmware location
   46DE 0E 00         [ 7]   38 		ld c, #0 						;load video mode 0 on screen
   46E0 CD 6E 49      [17]   39 		call cpct_setVideoMode_asm
                             40 
   46E3 C9            [10]   41 		ret
=======
   4439                      35 	initialize:
   4439 CD 02 46      [17]   36 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   443C 3A 39 00      [13]   37 		ld a, (0x0039) 					;saves data from firmware location
   443F 0E 00         [ 7]   38 		ld c, #0 						;load video mode 0 on screen
   4441 CD F5 45      [17]   39 		call cpct_setVideoMode_asm
                             40 
   4444 C9            [10]   41 		ret
>>>>>>> 60fbd1c2a1d49d64fa63cfbf8d8016fb08aea566
                             42 
                             43 	;Draws the main character on screen
                             44 	;Needs
                             45 	;	A = color pattern of the box
                             46 	;Corrupts:
                             47 	;	HL, DE, AF, BC
                             48 
<<<<<<< HEAD
   46E4                      49 	draw_hero:
   46E4 F5            [11]   50 		push af			;pushes color on the pile
   46E5 11 00 C0      [10]   51 		ld de, #0xC000	;beginning of screen
                             52 
   46E8 3A 8A 4A      [13]   53 		ld a, (hero_x)
   46EB 4F            [ 4]   54 		ld c, a 		; b = hero_X
                             55 
   46EC 3A 8B 4A      [13]   56 		ld a, (hero_y)
   46EF 47            [ 4]   57 		ld b, a 		; c = hero_y
                             58 		
   46F0 CD 38 4A      [17]   59 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             60 
   46F3 EB            [ 4]   61 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             62 		;ld a, #0xFF  	;red colour
   46F4 F1            [10]   63 		pop af			;pops the colour
   46F5 01 04 10      [10]   64 		ld bc, #0x1004 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             65 		
   46F8 CD 8B 49      [17]   66 		call cpct_drawSolidBox_asm ;draw box itself
   46FB C9            [10]   67 		ret
=======
   4445                      49 	draw_hero:
   4445 F5            [11]   50 		push af			;pushes color on the pile
   4446 11 00 C0      [10]   51 		ld de, #0xC000	;beginning of screen
                             52 
   4449 3A 0D 47      [13]   53 		ld a, (hero_x)
   444C 4F            [ 4]   54 		ld c, a 		; b = hero_X
                             55 
   444D 3A 0E 47      [13]   56 		ld a, (hero_y)
   4450 47            [ 4]   57 		ld b, a 		; c = hero_y
                             58 		
   4451 CD BF 46      [17]   59 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             60 
   4454 EB            [ 4]   61 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             62 		;ld a, #0xFF  	;red colour
   4455 F1            [10]   63 		pop af			;pops the colour
   4456 01 04 10      [10]   64 		ld bc, #0x1004 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             65 		
   4459 CD 12 46      [17]   66 		call cpct_drawSolidBox_asm ;draw box itself
   445C C9            [10]   67 		ret
>>>>>>> 60fbd1c2a1d49d64fa63cfbf8d8016fb08aea566
                             68 
                             69 
                             70 	;Waits the wait_time specified
                             71 	;Corrupts
                             72 	;	A;
                             73 
<<<<<<< HEAD
   46FC                      74 	esperar:
   46FC 3A 85 4A      [13]   75 		ld a, (wait_time)
   46FF                      76 		bucle:
   46FF 76            [ 4]   77 			halt
   4700 3D            [ 4]   78 			dec a
   4701 20 FC         [12]   79 			jr nz, bucle
=======
   445D                      74 	esperar:
   445D 3A 0C 47      [13]   75 		ld a, (wait_time)
   4460                      76 		bucle:
   4460 76            [ 4]   77 			halt
   4461 3D            [ 4]   78 			dec a
   4462 20 FC         [12]   79 			jr nz, bucle
>>>>>>> 60fbd1c2a1d49d64fa63cfbf8d8016fb08aea566
                             80 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



<<<<<<< HEAD
   4703 C9            [10]   81 		ret
=======
   4464 C9            [10]   81 		ret
>>>>>>> 60fbd1c2a1d49d64fa63cfbf8d8016fb08aea566
                             82 
                             83 
                             84 	;==================
                             85 	;;;PUBLIC FUNCIONS
                             86 	;==================
                             87 
<<<<<<< HEAD
   4704                      88 	_main::
                             89 
   4704 CD D8 46      [17]   90 		call initialize		;initializes all functions and firmware options
                             91 
   4707                      92 		_main_bucle:
   4707 3E 00         [ 7]   93 			ld a, #0x00
   4709 CD E4 46      [17]   94 			call draw_hero		;Erasing the hero
                             95 
   470C 3E 00         [ 7]   96 			ld a, #0x00
   470E CD 29 47      [17]   97 			call drawBox 		;Erase testing box
   4711 CD 41 47      [17]   98 			call moveBox		;move testBox
                             99 
                            100 
   4714 CD 3B 48      [17]  101 			call jumpControl	;check jumping situation of the character
   4717 CD 5E 48      [17]  102 			call checkUserInput	;Checking if user pressed a key
                            103 
   471A 3E FF         [ 7]  104 			ld a, #0xFF
   471C CD E4 46      [17]  105 			call draw_hero		;paint hero on screen
                            106 
   471F 3E FF         [ 7]  107 			ld a, #0xFF
   4721 CD 29 47      [17]  108 			call drawBox 		;draw testing box
                            109 
                            110 
   4724 CD 66 49      [17]  111 			call cpct_waitVSYNC_asm		;wait till repainting
   4727 18 DE         [12]  112 			jr _main_bucle
=======
   4465                      88 	_main::
                             89 
   4465 CD 39 44      [17]   90 		call initialize		;initializes all functions and firmware options
                             91 
   4468                      92 		_main_bucle:
   4468 3E 00         [ 7]   93 			ld a, #0x00
   446A CD 45 44      [17]   94 			call draw_hero		;Erasing the hero
                             95 
   446D 3E 00         [ 7]   96 			ld a, #0x00
   446F CD 3B 45      [17]   97 			call drawBox 		;Erase testing box
   4472 CD 53 45      [17]   98 			call moveBox		;move testBox
                             99 
                            100 
   4475 CD DB 44      [17]  101 			call jumpControl	;check jumping situation of the character
   4478 CD FE 44      [17]  102 			call checkUserInput	;Checking if user pressed a key
                            103 
   447B 3E FF         [ 7]  104 			ld a, #0xFF
   447D CD 45 44      [17]  105 			call draw_hero		;paint hero on screen
                            106 
   4480 3E FF         [ 7]  107 			ld a, #0xFF
   4482 CD 3B 45      [17]  108 			call drawBox 		;draw testing box
                            109 
                            110 
   4485 CD ED 45      [17]  111 			call cpct_waitVSYNC_asm		;wait till repainting
   4488 18 DE         [12]  112 			jr _main_bucle
>>>>>>> 60fbd1c2a1d49d64fa63cfbf8d8016fb08aea566
