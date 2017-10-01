ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
   576B 01                    8 	wait_time: .db #0x01
                              9 
                             10 	;==================
                             11 	;;;PUBLIC DATA
                             12 	;==================
                             13 	;Background
                             14 	.globl _p_tileset
                             15 	.globl _p_palette
                             16 	.globl _pruebaMap
                             17 
                             18 	;Main hero
                             19 	.globl _test_palette
                             20 	.globl _test_test
                             21 
                             22 .area _CODE
                             23 
                             24 	;==================
                             25 	;;;INCLUDE FUNCIONS
                             26 	;==================
                             27 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             28 	.include "cpctelera.h.s"
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
                             35 .globl cpct_setPalette_asm
                             36 
                             37 .globl cpct_etm_setTileset2x4_asm
                             38 
                             39 .globl cpct_etm_drawTileBox2x4_asm
                             40 
                             41 .globl cpct_drawSprite_asm
                             42 
                             43 	;============================
                             44 	;FIRMWARE CODE
                             45 	;============================
                             46 
                             47 ;wait por de raster to be at lowest screen part, to refresh all _DATA
                             48 ;CORRUPTS:
                             49 ;	AF, VC
                             50 .globl cpct_waitVSYNC_asm
                             51 
                             52 ;Disables firmware control, so we can use our colour mode, for example
                             53 .globl cpct_disableFirmware_asm
                             54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 ;Loads the video mode expressed in register C
                             56 ;CORRUPTS
                             57 ;	AF, BC, HL
                             58 .globl cpct_setVideoMode_asm
                             59 
                             60 	;============================
                             61 	;KEYBOARD CODE
                             62 	;============================
                             63 
                             64 ;Checks if any key is pressed scanning through all the keyboard
                             65 .globl cpct_scanKeyboard_asm
                             66 
                             67 
                             68 ;checks if a given key in HL is pressed
                             69 .globl cpct_isKeyPressed_asm
                             70 
                             71 
                             72 .globl cpct_drawCharM0_asm
                             73 
                             74 .globl cpct_drawStringM0_asm
                             75 
                             76 
                             77 
                             78 
                             79 
                             80 
                             81 
                             82 
                             83 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             29 	.include "tiles/"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             30 	.include "control.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             31 	.include "sprite.h.s"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             32 	.include "collision.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                             33 	;======
                             34 	;NUEVO|
                             35 	;======
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             36 	.include "hud.h.s"
                              1 .globl hudUpdate
                              2 .globl incPoints
                              3 .globl loadHud
                              4 .globl loseHP
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                             37 	.include "menu.h.s"
                              1 .globl loadMenu
                              2 .globl checkMenuInput
                              3 .globl selector
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             38 	.include "shoot.h.s"
                              1 .globl shootBullet
                              2 .globl shootUpdate
                              3 .globl bullet_x
                              4 .globl bullet_y
                              5 .globl bullet_w
                              6 .globl bullet_alive
                              7 .globl drawBullet
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             39 	.include "hero.h.s"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                             40 	;==================
                             41 	;;;PRIVATE FUNCIONS
                             42 	;==================
                             43 
                             44 	;Loads the initial data options
                             45 	;Corrupts:
                             46 	;	C
                             47 
   4FC4                      48 	paint_background:
   4FC4 21 D2 41      [10]   49 		ld hl, #_pruebaMap 					;Pushing the tilemap
   4FC7 E5            [11]   50 		push hl
   4FC8 21 00 C0      [10]   51 		ld hl, #0xC000 						;Point of memory starter
   4FCB E5            [11]   52 		push hl
                             53 
   4FCC 01 00 00      [10]   54 		ld bc, #0x0000 						;Starting tilemap of painting
   4FCF 11 28 28      [10]   55 		ld de, #0x2828						;Size in tiles of the drawing
   4FD2 3E 28         [ 7]   56 		ld a, #0x28 						;Map width
   4FD4 CD 49 54      [17]   57 		call cpct_etm_drawTileBox2x4_asm 	;Drawing function
   4FD7 C9            [10]   58 		ret
                             59 
   4FD8                      60 	initialize:
                             61 		
                             62 		;;Enable video mode 0
                             63 		
   4FD8 CD AC 55      [17]   64 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   4FDB 3A 39 00      [13]   65 		ld a, (0x0039) 					;saves data from firmware location
   4FDE 0E 00         [ 7]   66 		ld c, #0 						;load video mode 0 on screen
   4FE0 CD 9F 55      [17]   67 		call cpct_setVideoMode_asm
                             68 
                             69 		;;Set pallette
   4FE3 21 C2 4E      [10]   70 		ld hl, #_p_palette		;Paleta de los sprites
   4FE6 11 0C 00      [10]   71 		ld de, #12
   4FE9 CD 66 53      [17]   72 		call cpct_setPalette_asm
                             73 
                             74 		;;Draw map Sprite
                             75 
   4FEC 21 CE 4E      [10]   76 		ld hl, #_p_tileset 					;I've got to pass the beginning of the tileset
   4FEF CD D5 54      [17]   77 		call cpct_etm_setTileset2x4_asm
                             78 		
   4FF2 CD C4 4F      [17]   79 		call paint_background
                             80 
   4FF5 C9            [10]   81 		ret
                             82 
                             83 	;Draws the main character on screen
                             84 	;Needs
                             85 	;	A = color pattern of the box
                             86 	;Corrupts:
                             87 	;	HL, DE, AF, BC
                             88 
   4FF6                      89 	draw_hero:
   4FF6 11 00 C0      [10]   90 		ld de, #0xC000	;beginning of screen
                             91 
   4FF9 3A 7D 57      [13]   92 		ld a, (hero_x)
   4FFC 4F            [ 4]   93 		ld c, a 		; b = hero_X
                             94 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



   4FFD 3A 7E 57      [13]   95 		ld a, (hero_y)
   5000 47            [ 4]   96 		ld b, a 		; c = hero_y
                             97 		
   5001 CD 8A 56      [17]   98 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             99 
                            100 		;clean background
   5004 21 D2 41      [10]  101 		ld hl, #_pruebaMap 					;Pushing the tilemap
   5007 E5            [11]  102 		push hl
   5008 EB            [ 4]  103 		ex de, hl 							;position of our character
   5009 E5            [11]  104 		push hl
                            105 
                            106 		;Starting tilemap of painting
   500A 3A 7D 57      [13]  107 		ld a, (hero_x)
   500D 4F            [ 4]  108 		ld c, a
   500E CB 29         [ 8]  109 		sra c
   5010 CB 29         [ 8]  110 		sra c
   5012 79            [ 4]  111 		ld a,c
   5013 EE F0         [ 7]  112 		xor #0xF0 
   5015 4F            [ 4]  113 		ld c,a
                            114 										;dividing in 4 the number the size of a tile
   5016 3A 7E 57      [13]  115 		ld a, (hero_y)
   5019 47            [ 4]  116 		ld b, a
   501A CB 28         [ 8]  117 		sra b
   501C CB 28         [ 8]  118 		sra b
   501E 78            [ 4]  119 		ld a,b
   501F EE F0         [ 7]  120 		xor #0xF0
   5021 47            [ 4]  121 		ld b,a 
                            122 								
   5022 11 02 02      [10]  123 		ld de, #0x0202						;Size in tiles of the drawing
   5025 3E 28         [ 7]  124 		ld a, #0x28 						;Map width
   5027 CD 49 54      [17]  125 		call cpct_etm_drawTileBox2x4_asm 	;Drawing function
                            126 
   502A 11 00 C0      [10]  127 		ld de, #0xC000
   502D EB            [ 4]  128 		ex de, hl 			;HL holds the screen pointer, so we swap it with de for fast change
   502E 21 9C 41      [10]  129 		ld hl, #_test_test	;pointer to sprite of the test subject
   5031 01 04 08      [10]  130 		ld bc, #0x0804 		;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                            131 		
   5034 CD A9 53      [17]  132 		call cpct_drawSprite_asm 	;draw sprite itself
   5037 C9            [10]  133 		ret
                            134 
                            135 
                            136 	;Waits the wait_time specified
                            137 	;Corrupts
                            138 	;	A;
                            139 
   5038                     140 	esperar:
   5038 3A 6B 57      [13]  141 		ld a, (wait_time)
   503B                     142 		bucle:
   503B 76            [ 4]  143 			halt
   503C 3D            [ 4]  144 			dec a
   503D 20 FC         [12]  145 			jr nz, bucle
                            146 
   503F C9            [10]  147 		ret
                            148 
                            149 	;======
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            150 	;NUEVO|
                            151 	;======
   5040                     152 	checkStart:
   5040 3A 60 57      [13]  153 		ld 		a, (selector)
   5043 FE 0A         [ 7]  154 		cp 		#0x0A
   5045 28 01         [12]  155 		jr 		z, clear
   5047 C9            [10]  156 		ret
                            157 	;======
                            158 	;NUEVO|
                            159 	;======
   5048                     160 	clear:
                            161 		;LIMPIAR PUTA PANTALLA
   5048 21 00 C0      [10]  162 		ld 		hl, #0xC000
   504B                     163 		working:
   504B 3E 00         [ 7]  164 		ld 		a, #0x00
   504D 77            [ 7]  165 		ld 		(hl), a
   504E 23            [ 6]  166 		inc 	hl
   504F 7D            [ 4]  167 		ld 		a, l
   5050 D6 FF         [ 7]  168 		sub 	#0xFF
   5052 20 F7         [12]  169 		jr 		nz, working
   5054 7C            [ 4]  170 		ld 		a, h
   5055 D6 FF         [ 7]  171 		sub 	#0xFF
   5057 20 F2         [12]  172 		jr 		nz, working
   5059 CD C4 4F      [17]  173 		call	paint_background
   505C CD 97 50      [17]  174 		call 	loadHud
   505F 18 12         [12]  175 		jr 		_main_bucle
   5061 C9            [10]  176 		ret
                            177 
                            178 	;==================
                            179 	;;;PUBLIC FUNCIONS
                            180 	;==================
                            181 
   5062                     182 	_main::
                            183 
   5062 CD D8 4F      [17]  184 		call initialize		;initializes all functions and firmware options
                            185 		;======
                            186 		;NUEVO|
                            187 		;======
   5065 CD 43 4F      [17]  188 		call 	loadMenu
                            189 		;======
                            190 		;NUEVO|
                            191 		;======
   5068                     192 		_menu_bucle:
   5068 CD 68 4F      [17]  193 			call	checkMenuInput
   506B CD 40 50      [17]  194 			call 	checkStart
   506E CD 97 55      [17]  195 			call 	cpct_waitVSYNC_asm
   5071 18 F5         [12]  196 			jr 		_menu_bucle
   5073                     197 		_main_bucle:
                            198 
                            199 		
                            200 
                            201 			
                            202 
   5073 3E 00         [ 7]  203 			ld a, #0x00
   5075 CD 3D 51      [17]  204 			call drawBox 		;Erase testing box
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



   5078 CD 55 51      [17]  205 			call moveBox		;move testBox
                            206 
                            207 			;======
                            208 			;NUEVO|
                            209 			;======
   507B CD A1 50      [17]  210 			call hudUpdate
   507E CD F3 52      [17]  211 			call jumpControl	;check jumping situation of the character
   5081 CD 2D 53      [17]  212 			call checkUserInput	;Checking if user pressed a key
                            213 
                            214 
   5084 CD F6 4F      [17]  215 			call draw_hero		;paint hero on screen
                            216 
   5087 3E FF         [ 7]  217 			ld a, #0xFF
   5089 CD 3D 51      [17]  218 			call drawBox 		;draw testing box
                            219 
                            220 			;======
                            221 			;NUEVO|
                            222 			;======
   508C CD 02 52      [17]  223 			call shootBullet
   508F CD 1C 52      [17]  224 			call shootUpdate
                            225 
   5092 CD 97 55      [17]  226 			call cpct_waitVSYNC_asm		;wait till repainting
   5095 18 DC         [12]  227 			jr _main_bucle
