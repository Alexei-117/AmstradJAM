;PERSONAL TRIES
	;;=====================
	;; checkUserInput: Our approach (Doesn't work for firmware disabled)
	;;=====================

	;RIGHT BUTTON FIRST
	;------------------

	;ld a, (key_right)		;check if right button is pressed
	;call #0xBB1E			;call the checker KM_TEST KEY
	;jr nz, pressedRight		;Not Zero = pressed.
	;jr skipRight			;Skips right function

	;	pressedRight:
	;		call moveRightMain	;Moves main character to right

	;skipRight:

	;ld a, (key_left)		;check if left button is pressed
	;call #0xBB1E			;call the checker KM_TEST KEY
	;jr nz, pressedLeft		;Not Zero = pressed.
	;jr skipLeft			;Skips right function

	;	pressedLeft:
	;		call moveLeftMain	;Moves main character to right

	;skipLeft:


.area _DATA
	;==================
	;;;PRIVATE DATA
	;==================

	;key positions
.equ key_right ,#0x2007
.equ key_left  ,#0x2008
.equ key_up    ,#0x0807
.equ key_down  ,#0x1007

.equ key_jump  ,#0x8005

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

	;Moving main character throughout 4 axis
	;CORRUPTS:
	;	AF

	moveRightMain:
		ld a, (hero_x)		
		inc a 				
		ld (hero_x), a
		ret

	moveLeftMain:
		ld a, (hero_x)		
		dec a 				
		ld (hero_x), a
		ret

	moveUpMain:
		ld a, (hero_y)		
		sub #04 				
		ld (hero_y), a
		ret

	moveDownMain:
		ld a, (hero_y)		
		add #04 				
		ld (hero_y), a
		ret

	;===================
	;;;PUBLIC FUNCTIONS
	;===================

	
	;;Corrupts HL, A registers.

	checkUserInput::
		;;======
		;; Fran's approach
		;;======

		
		call cpct_scanKeyboard_asm  ;checks a key is pressed
		
		ld hl, #key_right 			 ;loads key_D in hl
		call cpct_isKeyPressed_asm	 ;checks if the key loaded in hl is pressed
		cp #0 						 ;checks if debugger leaves a 0 behind, if it is 0, then D is not pressed
		jr z, skipRight				 ;This goes to Right not pressed

			;right is pressed
			call moveRightMain
			jr continueEnd			 ;one direction at a time

		skipRight:

		ld hl, #key_left			 ;loads key_A in hl
		call cpct_isKeyPressed_asm	 ;checks if the key loaded in hl is pressed
		cp #0 						 ;checks if debugger leaves a 0 behind, if it is 0, then A is not pressed
		jr z, skipLeft			 	 ;This goes to Left not pressed

			;left is pressed
			call moveLeftMain
			jr continueEnd			 ;one direction at a time

		skipLeft:

		ld hl, #key_up				 ;loads key_W in hl
		call cpct_isKeyPressed_asm	 ;checks if the key loaded in hl is pressed
		cp #0 						 ;checks if debugger leaves a 0 behind, if it is 0, then W is not pressed
		jr z, skipUp			 	 ;This goes to up not pressed

			;left is pressed
			call moveUpMain
			jr continueEnd			 ;one direction at a time

		skipUp:

		ld hl, #key_down			 ;loads key_S in hl
		call cpct_isKeyPressed_asm	 ;checks if the key loaded in hl is pressed
		cp #0 						 ;checks if debugger leaves a 0 behind, if it is 0, thens is not pressed
		jr z, skipDown			 	 ;This goes to down not pressed

			;left is pressed
			call moveDownMain
			jr continueEnd			 ;one direction at a time
	
		skipDown:

		continueEnd:

		ret