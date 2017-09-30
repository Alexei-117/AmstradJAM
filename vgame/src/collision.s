.area _DATA
	;==================
	;;;PRIVATE DATA
	;==================


	;==================
	;;;PUBLIC FUNCIONS
	;==================

	;main character data
	obs_x:: .db #40
	obs_y:: .db #80

	obs_x_size:: .db #0x02
	obs_y_size:: .db #0x08

.area _CODE

	.include "cpctelera.h.s"

	drawBox::
		push	af 							;;Save A in the stack

		;;Calculate Screen position
		ld 		de, #0xC000					;;Video memory Pointer
		ld		a, (obs_x)					;; C=Hero_x
		ld		c, a        

		ld		a, (obs_y)					
		ld		b, a 						;; B=Hero_y

		call 	cpct_getScreenPtr_asm		;; Get pointer to screen

		;;ld	d, h
		;;ld    e, l
		ex		de, hl        				;;Swap data
		pop		af
		;; Draw A Box
		;; ld de, #0xC320				;;Location
		;;ld		a, #0x0F					;;Color
		ld 		bc, #0x0802					;;Width && height
		call 	cpct_drawSolidBox_asm

		ret

	;;CHecks Collision between an obstacle and the hero
	;;Input: HL: points to other entity
	;;Return XXXX XXXX
	obstacle_checkCollision_Y::
		; COLLISIONS ON Y
		;if(obs_y + obs_w <= hero_y) noCollision
		ld 		a, (obs_y)
		ld 		c, a
		ld 		a, (obs_y_size)
		add 	c
		sub 	(hl)

		jr 		z, no_collision
		jp 		m, no_collision
		;if(hero_y + hero_h <= obs_y)
		;;COLLISION
		ld 		a, (hl)
		inc 	hl
		inc 	hl
		add 	(hl)

		ld 		c, a
		ld 		a, (obs_y)
		ld 		b, a
		ld 		a, c
		sub 	b

		jr 		z, no_collision
		jp 		m, no_collision

		ld 		a, #1
		
		ret
	obstacle_checkCollision_X::
		; COLLISIONS ON X
		;;if(obs_x + obs_w <= hero_x) no Collision
		ld		a, (obs_x)
		ld		c, a
		ld		a, (obs_x_size)	
		add		c
		sub 	(hl)

		jr 		z, no_collision
		jp 		m, no_collision

		;;if (hero_x + hero_w <= obs_x)
		;; hero_x + hero_w - obs_x <= 0
		ld		a, (hl) 
		inc 	hl
		inc 	hl
		add 	(hl)

		ld 		c, a
		ld 		a, (obs_x)
		ld 		b, a
		ld 		a, c
		sub 	b

		jr 		z, no_collision
		jp 		m, no_collision
		
		ld 		a, #1

		ret
	;;NO COLLISION
	no_collision:
		ld 		a, #0
	ret	
