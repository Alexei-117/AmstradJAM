#include "test.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015
// Palette uses hardware values.
const u8 t_palette[16] = { 0x54, 0x44, 0x5c, 0x58, 0x45, 0x56, 0x46, 0x5e, 0x40, 0x47, 0x42, 0x53, 0x5a, 0x4a, 0x43, 0x4b };

// Tile t_test: 8x8 pixels, 4x8 bytes.
const u8 t_test[4 * 8] = {
	0xae, 0x5d, 0xae, 0x5d,
	0xae, 0x48, 0x0c, 0x5d,
	0xff, 0x85, 0x0e, 0xff,
	0xaf, 0x4a, 0x0d, 0x5d,
	0xff, 0x0e, 0x85, 0xff,
	0xaf, 0x0d, 0x48, 0x5f,
	0xaf, 0x0e, 0x85, 0xd5,
	0xff, 0x5f, 0xea, 0xff
};

