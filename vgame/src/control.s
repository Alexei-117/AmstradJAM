.area _DATA
	;==================
	;;;PRIVATE DATA
	;==================

	;key positions
	key_right: .db #61
	key_left: .db #69
	key_jump: .db #59

	;==================
	;;;PUBLIC FUNCIONS
	;==================

	;main character data
	hero_x:: .db #60
	hero_y:: .db #80
	hero_x_size:: .db #0x02
	hero_y_size:: .db #0x01

.area _CODE

	;===================
	;;;INCLUDE FUNCTIONS
	;===================

	.include "cpctelera.h.s"

	;===================
	;;;PRIVATE FUNCTIONS
	;===================

	moveRightMain:
		ld a, (hero_x)		;increases x position of the player
		inc a 				;and saves it in hero_x again
		ld (hero_x), a
		ret

	moveLeftMain:
		ld a, (hero_x)		;increases x position of the player
		dec a 				;and saves it in hero_x again
		ld (hero_x), a
		ret

	moveUpMain:

	moveDownMain:


	;===================
	;;;PUBLIC FUNCTIONS
	;===================

	
	;;Corrupts HL, A registers.

	checkUserInput::
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

		;RIGHT BUTTON FIRST
		;------------------

		ld a, (key_right)		;check if right button is pressed
		call #0xBB1E			;call the checker KM_TEST KEY
		jr nz, pressedRight		;Not Zero = pressed.
		jr skipRight			;Skips right function

			pressedRight:
				call moveRightMain	;Moves main character to right

		skipRight:

		ld a, (key_left)		;check if left button is pressed
		call #0xBB1E			;call the checker KM_TEST KEY
		jr nz, pressedLeft		;Not Zero = pressed.
		jr skipLeft			;Skips right function

			pressedLeft:
				call moveLeftMain	;Moves main character to right

		skipLeft:

		continueEnd:

		ret