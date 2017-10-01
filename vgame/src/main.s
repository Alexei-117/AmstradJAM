.area _DATA

	;==================
	;;;PRIVATE DATA
	;==================

	;Control Variables
	wait_time: .db #0x01

	;==================
	;;;PUBLIC DATA
	;==================
	;Background
	.globl _p_tileset
	.globl _p_palette
	.globl _pruebaMap

	;Main hero
	.globl _test_palette
	.globl _test_test

.area _CODE

	;==================
	;;;INCLUDE FUNCIONS
	;==================

	.include "cpctelera.h.s"
	.include "tiles/"
	.include "control.h.s"
	.include "sprite.h.s"
	.include "collision.h.s"
	;======
	;NUEVO|
	;======
	.include "hud.h.s"
	.include "menu.h.s"
	.include "shoot.h.s"
	.include "hero.h.s"
	;==================
	;;;PRIVATE FUNCIONS
	;==================

	;Loads the initial data options
	;Corrupts:
	;	C

	paint_background:
		ld hl, #_pruebaMap 					;Pushing the tilemap
		push hl
		ld hl, #0xC000 						;Point of memory starter
		push hl

		ld bc, #0x0000 						;Starting tilemap of painting
		ld de, #0x2828						;Size in tiles of the drawing
		ld a, #0x28 						;Map width
		call cpct_etm_drawTileBox2x4_asm 	;Drawing function
		ret

	initialize:
		
		;;Enable video mode 0
		
		call cpct_disableFirmware_asm	;disable firmware so we can set another options
		ld a, (0x0039) 					;saves data from firmware location
		ld c, #0 						;load video mode 0 on screen
		call cpct_setVideoMode_asm

		;;Set pallette
		ld hl, #_p_palette		;Paleta de los sprites
		ld de, #12
		call cpct_setPalette_asm

		;;Draw map Sprite

		ld hl, #_p_tileset 					;I've got to pass the beginning of the tileset
		call cpct_etm_setTileset2x4_asm
		
		call paint_background

		ret

	;Draws the main character on screen
	;Needs
	;	A = color pattern of the box
	;Corrupts:
	;	HL, DE, AF, BC

	draw_hero:
		ld de, #0xC000	;beginning of screen

		ld a, (hero_x)
		ld c, a 		; b = hero_X

		ld a, (hero_y)
		ld b, a 		; c = hero_y
		
		call cpct_getScreenPtr_asm	;gets pointer in HL with the data passed on the register

		;clean background
		ld hl, #_pruebaMap 					;Pushing the tilemap
		push hl
		ex de, hl 							;position of our character
		push hl

		;Starting tilemap of painting
		ld a, (hero_x)
		ld c, a
		sra c
		sra c
		ld a,c
		xor #0xF0 
		ld c,a
										;dividing in 4 the number the size of a tile
		ld a, (hero_y)
		ld b, a
		sra b
		sra b
		ld a,b
		xor #0xF0
		ld b,a 
								
		ld de, #0x0202						;Size in tiles of the drawing
		ld a, #0x28 						;Map width
		call cpct_etm_drawTileBox2x4_asm 	;Drawing function

		ld de, #0xC000
		ex de, hl 			;HL holds the screen pointer, so we swap it with de for fast change
		ld hl, #_test_test	;pointer to sprite of the test subject
		ld bc, #0x0804 		;heigh: 8x8 pixels on mode 1 (2 bytes every 4 pixels)
		
		call cpct_drawSprite_asm 	;draw sprite itself
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

	;======
	;NUEVO|
	;======
	checkStart:
		ld 		a, (selector)
		cp 		#0x0A
		jr 		z, clear
		ret
	;======
	;NUEVO|
	;======
	clear:
		;LIMPIAR PUTA PANTALLA
		ld 		hl, #0xC000
		working:
		ld 		a, #0x00
		ld 		(hl), a
		inc 	hl
		ld 		a, l
		sub 	#0xFF
		jr 		nz, working
		ld 		a, h
		sub 	#0xFF
		jr 		nz, working
		call	paint_background
		call 	loadHud
		jr 		_main_bucle
		ret

	;==================
	;;;PUBLIC FUNCIONS
	;==================

	_main::

		call initialize		;initializes all functions and firmware options
		;======
		;NUEVO|
		;======
		call 	loadMenu
		;======
		;NUEVO|
		;======
		_menu_bucle:
			call	checkMenuInput
			call 	checkStart
			call 	cpct_waitVSYNC_asm
			jr 		_menu_bucle
		_main_bucle:

			ld a, #0x00
			call drawBox 		;Erase testing box
			call moveBox		;move testBox

			;======
			;NUEVO|
			;======
			call hudUpdate
			

			;;;;;FUCK JUMPING
			;;;;;
			;call jumpControl	;check jumping situation of the character
			;;;;;

			call checkUserInput	;Checking if user pressed a key


			call draw_hero		;paint hero on screen

			ld a, #0xFF
			call drawBox 		;draw testing box

			;======
			;NUEVO|
			;======
			call shootBullet
			call shootUpdate

			call cpct_waitVSYNC_asm		;wait till repainting
			jr _main_bucle
