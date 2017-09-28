.area _DATA
.area _CODE

;;====================
;; Main of the program
;;====================

_main::
	ld a, #0xFF		;Carga el pixel 1 rojo en A
	ld (0xC000), a	;lo mete en C0000

	jr .