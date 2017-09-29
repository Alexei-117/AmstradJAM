ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 
                              3 	;==================
                              4 	;;;PRIVATE DATA
                              5 	;==================
                              6 
                              7 	;Control Variables
   4208 01                    8 	wait_time: .db #0x01
                              9 
                             10 	;Screen limits
   4209 C0                   11 	limit_up: .db #0xC0
   420A C7                   12 	limit_down: .db #0xC7
   420B 00                   13 	limit_left: .db #0x00
   420C 4F                   14 	limit_right: .db #0x4F
   420D 50                   15 	line_jump: .db #0x50
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
                             10 ;Reenables firmware to be used
                             11 ;CORRUPTS:
                             12 ;	HL
                             13 ;.globl cpct_reenableFirmware_asm
                             14 
                             15 ;============================
                             16 ;USING CODE
                             17 ;============================
                             18 
                             19 	;============================
                             20 	;SPRITE CODE
                             21 	;============================
                             22 
                             23 
                             24 ;2B DE) screen_start	Pointer to the start of the screen (or a backbuffer)
                             25 ;(1B C ) x	[0-79] Byte-aligned column starting from 0 (x coordinate,
                             26 ;(1B B ) y	[0-199] row starting from 0 (y coordinate) in bytes)
                             27 .globl cpct_getScreenPtr_asm
                             28 
                             29 
                             30 ;(2B DE) memory	Video memory pointer to the upper left box corner byte
                             31 ;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
                             32 ;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
                             33 ;(1B B ) height	Box height in bytes (>0)
                             34 .globl cpct_drawSolidBox_asm
                             35 
                             36 
                             37 	;============================
                             38 	;FIRMWARE CODE
                             39 	;============================
                             40 
                             41 ;wait por de raster to be at lowest screen part, to refresh all _DATA
                             42 ;CORRUPTS:
                             43 ;	AF, VC
                             44 .globl cpct_waitVSYNC_asm
                             45 
                             46 ;Disables firmware control, so we can use our colour mode, for example
                             47 .globl cpct_disableFirmware_asm
                             48 
                             49 ;Loads the video mode expressed in register C
                             50 ;CORRUPTS
                             51 ;	AF, BC, HL
                             52 .globl cpct_setVideoMode_asm
                             53 
                             54 	;============================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 	;KEYBOARD CODE
                             56 	;============================
                             57 
                             58 ;Checks if any key is pressed scanning through all the keyboard
                             59 .globl cpct_scanKeyboard_asm
                             60 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             61 .include "keyboard/keyboard.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2014 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 .module cpct_keyboard
                             19 
                             20 ;; bndry directive does not work when linking previously compiled files
                             21 ;.bndry 16
                             22 ;;   16-byte aligned in memory to let functions use 8-bit maths for pointing
                             23 ;;   (alignment not working on user linking)
                             24 
   4030                      25 _cpct_keyboardStatusBuffer:: .ds 10
                             26 
                             27 ;;
                             28 ;; Assembly constant definitions for keyboard mapping
                             29 ;;
                             30 
                             31 ;; Matrix Line 0x00
                     0100    32 .equ Key_CursorUp     ,#0x0100  ;; Bit 0 (01h) => | 0000 0001 |
                     0200    33 .equ Key_CursorRight  ,#0x0200  ;; Bit 1 (02h) => | 0000 0010 |
                     0400    34 .equ Key_CursorDown   ,#0x0400  ;; Bit 2 (04h) => | 0000 0100 |
                     0800    35 .equ Key_F9           ,#0x0800  ;; Bit 3 (08h) => | 0000 1000 |
                     1000    36 .equ Key_F6           ,#0x1000  ;; Bit 4 (10h) => | 0001 0000 |
                     2000    37 .equ Key_F3           ,#0x2000  ;; Bit 5 (20h) => | 0010 0000 |
                     4000    38 .equ Key_Enter        ,#0x4000  ;; Bit 6 (40h) => | 0100 0000 |
                     8000    39 .equ Key_FDot         ,#0x8000  ;; Bit 7 (80h) => | 1000 0000 |
                             40 ;; Matrix Line 0x01
                     0101    41 .equ Key_CursorLeft   ,#0x0101
                     0201    42 .equ Key_Copy         ,#0x0201
                     0401    43 .equ Key_F7           ,#0x0401
                     0801    44 .equ Key_F8           ,#0x0801
                     1001    45 .equ Key_F5           ,#0x1001
                     2001    46 .equ Key_F1           ,#0x2001
                     4001    47 .equ Key_F2           ,#0x4001
                     8001    48 .equ Key_F0           ,#0x8001
                             49 ;; Matrix Line 0x02
                     0102    50 .equ Key_Clr          ,#0x0102
                     0202    51 .equ Key_OpenBracket  ,#0x0202
                     0402    52 .equ Key_Return       ,#0x0402
                     0802    53 .equ Key_CloseBracket ,#0x0802
                     1002    54 .equ Key_F4           ,#0x1002
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                     2002    55 .equ Key_Shift        ,#0x2002
                     4002    56 .equ Key_BackSlash    ,#0x4002
                     8002    57 .equ Key_Control      ,#0x8002
                             58 ;; Matrix Line 0x03
                     0103    59 .equ Key_Caret        ,#0x0103
                     0203    60 .equ Key_Hyphen       ,#0x0203
                     0403    61 .equ Key_At           ,#0x0403
                     0803    62 .equ Key_P            ,#0x0803
                     1003    63 .equ Key_SemiColon    ,#0x1003
                     2003    64 .equ Key_Colon        ,#0x2003
                     4003    65 .equ Key_Slash        ,#0x4003
                     8003    66 .equ Key_Dot          ,#0x8003
                             67 ;; Matrix Line 0x04
                     0104    68 .equ Key_0            ,#0x0104
                     0204    69 .equ Key_9            ,#0x0204
                     0404    70 .equ Key_O            ,#0x0404
                     0804    71 .equ Key_I            ,#0x0804
                     1004    72 .equ Key_L            ,#0x1004
                     2004    73 .equ Key_K            ,#0x2004
                     4004    74 .equ Key_M            ,#0x4004
                     8004    75 .equ Key_Comma        ,#0x8004
                             76 ;; Matrix Line 0x05
                     0105    77 .equ Key_8            ,#0x0105
                     0205    78 .equ Key_7            ,#0x0205
                     0405    79 .equ Key_U            ,#0x0405
                     0805    80 .equ Key_Y            ,#0x0805
                     1005    81 .equ Key_H            ,#0x1005
                     2005    82 .equ Key_J            ,#0x2005
                     4005    83 .equ Key_N            ,#0x4005
                     8005    84 .equ Key_Space        ,#0x8005
                             85 ;; Matrix Line 0x06
                     0106    86 .equ Key_6            ,#0x0106
                     0106    87 .equ Joy1_Up          ,#0x0106
                     0206    88 .equ Key_5            ,#0x0206
                     0206    89 .equ Joy1_Down        ,#0x0206
                     0406    90 .equ Key_R            ,#0x0406
                     0406    91 .equ Joy1_Left        ,#0x0406
                     0806    92 .equ Key_T            ,#0x0806
                     0806    93 .equ Joy1_Right       ,#0x0806
                     1006    94 .equ Key_G            ,#0x1006
                     1006    95 .equ Joy1_Fire1       ,#0x1006
                     2006    96 .equ Key_F            ,#0x2006
                     2006    97 .equ Joy1_Fire2       ,#0x2006
                     4006    98 .equ Key_B            ,#0x4006
                     4006    99 .equ Joy1_Fire3       ,#0x4006
                     8006   100 .equ Key_V            ,#0x8006
                            101 ;; Matrix Line 0x07
                     0107   102 .equ Key_4            ,#0x0107
                     0207   103 .equ Key_3            ,#0x0207
                     0407   104 .equ Key_E            ,#0x0407
                     0807   105 .equ Key_W            ,#0x0807
                     1007   106 .equ Key_S            ,#0x1007
                     2007   107 .equ Key_D            ,#0x2007
                     4007   108 .equ Key_C            ,#0x4007
                     8007   109 .equ Key_X            ,#0x8007
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            110 ;; Matrix Line 0x08
                     0108   111 .equ Key_1            ,#0x0108
                     0208   112 .equ Key_2            ,#0x0208
                     0408   113 .equ Key_Esc          ,#0x0408
                     0808   114 .equ Key_Q            ,#0x0808
                     1008   115 .equ Key_Tab          ,#0x1008
                     2008   116 .equ Key_A            ,#0x2008
                     4008   117 .equ Key_CapsLock     ,#0x4008
                     8008   118 .equ Key_Z            ,#0x8008
                            119 ;; Matrix Line 0x09
                     0109   120 .equ Joy0_Up          ,#0x0109
                     0209   121 .equ Joy0_Down        ,#0x0209
                     0409   122 .equ Joy0_Left        ,#0x0409
                     0809   123 .equ Joy0_Right       ,#0x0809
                     1009   124 .equ Joy0_Fire1       ,#0x1009
                     2009   125 .equ Joy0_Fire2       ,#0x2009
                     4009   126 .equ Joy0_Fire3       ,#0x4009
                     8009   127 .equ Key_Del          ,#0x8009
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             62 
                             63 ;checks if a given key in HL is pressed
                             64 .globl cpct_isKeyPressed_asm
                             65 
                             66 
                             67 
                             68 
                             69 
                             70 
                             71 
                             72 
                             73 
                             74 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             32 	.include "sprite.h.s"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
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
   403A                      42 	initialize:
   403A CD FE 40      [17]   43 		call cpct_disableFirmware_asm	;disable firmware so we can set another options
   403D 3A 39 00      [13]   44 		ld a, (0x0039) 					;saves data from firmware location
   4040 0E 00         [ 7]   45 		ld c, #0 						;load video mode 0 on screen
   4042 CD F1 40      [17]   46 		call cpct_setVideoMode_asm
                             47 
                             48 		;ld (0x0039), a
                             49 		;call cpct_reenableFirmware_asm
                             50 
   4045 C9            [10]   51 		ret
                             52 
                             53 	;Draws the main character on screen
                             54 	;Needs
                             55 	;	A = color pattern of the box
                             56 	;Corrupts:
                             57 	;	HL, DE, AF, BC
                             58 
   4046                      59 	draw_hero:
   4046 F5            [11]   60 		push af			;pushes color on the pile
   4047 11 00 C0      [10]   61 		ld de, #0xC000	;beginning of screen
                             62 
   404A 3A 0E 42      [13]   63 		ld a, (hero_x)
   404D 4F            [ 4]   64 		ld c, a 		; b = hero_X
                             65 
   404E 3A 0F 42      [13]   66 		ld a, (hero_y)
   4051 47            [ 4]   67 		ld b, a 		; c = hero_y
                             68 		
   4052 CD BB 41      [17]   69 		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register
                             70 
   4055 EB            [ 4]   71 		ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
                             72 		;ld a, #0xFF  	;red colour
   4056 F1            [10]   73 		pop af			;pops the colour
   4057 01 02 08      [10]   74 		ld bc, #0x0802 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
                             75 		
   405A CD 0E 41      [17]   76 		call cpct_drawSolidBox_asm ;draw box itself
   405D C9            [10]   77 		ret
                             78 
                             79 
                             80 	;Waits the wait_time specified
                             81 	;Corrupts
                             82 	;	A;
                             83 
   405E                      84 	esperar:
   405E 3A 08 42      [13]   85 		ld a, (wait_time)
   4061                      86 		bucle:
   4061 76            [ 4]   87 			halt
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   4062 3D            [ 4]   88 			dec a
   4063 20 FC         [12]   89 			jr nz, bucle
                             90 
   4065 C9            [10]   91 		ret
                             92 
                             93 
                             94 	;==================
                             95 	;;;PUBLIC FUNCIONS
                             96 	;==================
                             97 
   4066                      98 	_main::
                             99 
   4066 CD 3A 40      [17]  100 		call initialize		;initializes all functions and firmware options
                            101 
   4069                     102 		_main_bucle:
   4069 3E 00         [ 7]  103 			ld a, #0x00
   406B CD 46 40      [17]  104 			call draw_hero		;Erasing the hero
                            105 
                            106 
   406E CD 9D 40      [17]  107 			call checkUserInput	;Checking if user pressed a key
                            108 
   4071 3E FF         [ 7]  109 			ld a, #0xFF
   4073 CD 46 40      [17]  110 			call draw_hero		;paint hero on screen
                            111 
   4076 CD E9 40      [17]  112 			call cpct_waitVSYNC_asm		;wait till repainting
   4079 18 EE         [12]  113 			jr _main_bucle
