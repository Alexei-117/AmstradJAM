.area _DATA

	hero_x: .db #60
	hero_y: .db #80

.area _CODE

	;2B DE) screen_start	Pointer to the start of the screen (or a backbuffer)
	;(1B C ) x	[0-79] Byte-aligned column starting from 0 (x coordinate,
	;(1B B ) y	[0-199] row starting from 0 (y coordinate) in bytes)
	.globl cpct_getScreenPtr_asm


	;(2B DE) memory	Video memory pointer to the upper left box corner byte
	;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
	;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
	;(1B B ) height	Box height in bytes (>0)
	.globl cpct_drawSolidBox_asm


;Draws the main character on screen
draw_hero:

	ld de, #0xC000	;beginning of screen

	ld a, (hero_x)
	ld b, a 		; b = hero_X

	ld a, (hero_y)
	ld c, a 		; c = hero_y
	
	call cpct_getScreenPtr_asm

	ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
	ld a, #0xFF  	;red colour
	ld bc, #0x0802 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
	
	call cpct_drawSolidBox_asm ;draw box itself
	ret
;;====================
;; Main of the program
;;====================

_main::
	call draw_hero	;paint hero on screen
	jr .