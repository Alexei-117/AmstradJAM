.area _DATA

	;==================
	;;;PRIVATE DATA
	;==================

	;Control Variables
	wait_time: .db #0x01

	;Screen limits
	limit_up: .db #0xC0
	limit_down: .db #0xC7
	limit_left: .db #0x00
	limit_right: .db #0x4F
	line_jump: .db #0x50


	;==================
	;;;PUBLIC DATA
	;==================



.area _CODE

	;==================
	;;;INCLUDE FUNCIONS
	;==================

	.include "cpctelera.h.s"
	.include "control.h.s"


	;==================
	;;;PRIVATE FUNCIONS
	;==================


	;Draws the main character on screen
	;Needs
	;	A = color pattern of the box
	;Corrupts:
	;	HL, DE, AF, BC

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


	;Waits the wait_time specified
	;Corrupts
	;	A;

	esperar:
		ld a, (wait_time)
		bucle:
			halt
			dec a
			jr nz, bucle

		call cpct_waitVSYNC_asm

		ret


	;==================
	;;;PUBLIC FUNCIONS
	;==================

	_main::
		ld a, #0x00
		call draw_hero		;Erasing the hero


		call checkUserInput	;Checking if user pressed a key

		ld a, #0xFF
		call draw_hero		;paint hero on screen

		call esperar		;wait till repainting
		jr _main