.area _DATA

	;==================
	;;;PRIVATE DATA
	;==================

	;Control Variables
	wait_time: .db #0x01

	;==================
	;;;PUBLIC DATA
	;==================



.area _CODE

	;==================
	;;;INCLUDE FUNCIONS
	;==================

	.include "cpctelera.h.s"
	.include "control.h.s"
	.include "sprite.h.s"

	;==================
	;;;PRIVATE FUNCIONS
	;==================

	;Loads the initial data options
	;Corrupts:
	;	C

	initialize:
		call cpct_disableFirmware_asm	;disable firmware so we can set another options
		ld a, (0x0039) 					;saves data from firmware location
		ld c, #0 						;load video mode 0 on screen
		call cpct_setVideoMode_asm

		;ld (0x0039), a
		;call cpct_reenableFirmware_asm

		ret

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
		
		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register

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

		ret


	;==================
	;;;PUBLIC FUNCIONS
	;==================

	_main::

		call initialize		;initializes all functions and firmware options

		_main_bucle:
			ld a, #0x00
			call draw_hero		;Erasing the hero

			call jumpControl	;check jumping situation of the character
			call checkUserInput	;Checking if user pressed a key

			ld a, #0xFF
			call draw_hero		;paint hero on screen

			call cpct_waitVSYNC_asm		;wait till repainting
			jr _main_bucle
