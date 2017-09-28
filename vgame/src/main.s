.area _DATA

	;Controles
	key_right: .db #61
	key_left: .db #69
	key_jump: .db #59

	;Variables del héroe
	hero_x: .db #60
	hero_y: .db #80

	;Control Variables
	wait_time: .db #0x06

.area _CODE

	.include "cpctelera.h.s"

	;============================
	;JUST IN CASE CODE
	;============================

	;Checks if any key is pressed scanning through all the keyboard
	;.globl cpct_scanKeyboard_asm

	;.include "keyboard/keyboard.s"

	;checks if a given key in HL is pressed
	;.globl cpct_isKeyPressed_asm

	;============================
	;USING CODE
	;============================
	
	;2B DE) screen_start	Pointer to the start of the screen (or a backbuffer)
	;(1B C ) x	[0-79] Byte-aligned column starting from 0 (x coordinate,
	;(1B B ) y	[0-199] row starting from 0 (y coordinate) in bytes)
	.globl cpct_getScreenPtr_asm


	;(2B DE) memory	Video memory pointer to the upper left box corner byte
	;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
	;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
	;(1B B ) height	Box height in bytes (>0)
	.globl cpct_drawSolidBox_asm

	;wait por de raster to be at lowest screen part, to refresh all _DATA
	.globl cpct_waitVSYNC_asm


;Draws the main character on screen
;Needs
;	A = color pattern of the box

draw_hero:
	push af			;pushes color on the pile
	ld de, #0xC000	;beginning of screen

	ld a, (hero_x)
	ld c, a 		; b = hero_X

	ld a, (hero_y)
	ld b, a 		; c = hero_y
	
	call cpct_getScreenPtr_asm

	ex de, hl 		;HL holds the screen pointer, so we swap it with de for fast change
	;ld a, #0xFF  	;red colour
	pop af			;pops the colour
	ld bc, #0x0802 	;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
	
	call cpct_drawSolidBox_asm ;draw box itself
	ret


;Check if user pressed a key
checkUserInput:
	;;======
	;; Fran's approach
	;;======

	
	;call cpct_scanKeyboard_asm  ;checks a key is pressed
	;
	;ld hl, #Key_D 				 ;loads key_D in hl
	;call cpct_isKeyPressed_asm	 ;checks if the key loaded in hl is pressed
	;cp #0 						 ;checks if debugger leaves a 0 behind, if it is 0, then D is not pressed
	;jr z, d_not_pressed		 ;This goes to d not pressed zone, if not it is pressed


	;;=====================
	;; Own approach
	;;=====================
	ld a, (key_right)		;check if right button is pressed
	call #0xBB1E				;call the checker KM_TEST KEY
	jr nz, pressedRight			;Not Zero = pressed.


	;continous NOT pressed
	jr continueRight 		;if not pressed, just continues

	;PRESSED
	pressedRight:
		ld a, (hero_x)		;increases x position of the player
		inc a 				;and saves it in hero_x again
		ld (hero_x), a


	continueRight:

	ret

esperar:
	ld a, (wait_time)
	bucle:
		halt
		dec a
		jr nz, bucle

	call cpct_waitVSYNC_asm

	ret


;;====================
;; Main of the program
;;====================

_main::
	ld a, #0x00
	call draw_hero		;Erasing the hero


	call checkUserInput	;Checking if user pressed a key

	ld a, #0xFF
	call draw_hero		;paint hero on screen

	call esperar		;wait till repainting
	jr _main