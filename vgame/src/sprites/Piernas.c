#include "Piernas.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015
// Palette uses hardware values.
<<<<<<< HEAD
const u8 sprite_palette[16] = { 0x54, 0x44, 0x55, 0x5c, 0x58, 0x5d, 0x4c, 0x45, 0x4d, 0x56, 0x46, 0x57, 0x5e, 0x52, 0x4b, 0x43 };

// Tile sprite_Piernas: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas[8 * 16] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc3, 0xd3, 0x00, 0x8a, 0x00,
	0x00, 0x00, 0x00, 0xc3, 0xd3, 0x00, 0x4d, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x0c, 0x00, 0x0c, 0x8a,
	0x00, 0x00, 0x00, 0x0c, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x8a, 0x04, 0x8a, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x8a, 0x04, 0x8a, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x00, 0x04, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x00, 0x04, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x4d, 0x00, 0x00, 0x4d, 0x00, 0x00,
	0x00, 0x00, 0x4d, 0x00, 0x00, 0x0c, 0x8a, 0x00,
	0x00, 0x04, 0x8a, 0x00, 0x00, 0x0c, 0x08, 0x00,
	0x00, 0x0c, 0x8a, 0x00, 0x00, 0x0c, 0x4d, 0x00,
	0x00, 0x4d, 0x8a, 0x00, 0x00, 0x0c, 0x4d, 0x00,
=======
const u8 sprite_palette[9] = { 0x54, 0x44, 0x55, 0x4c, 0x57, 0x5e, 0x52, 0x4b, 0x43 };

// Tile sprite_Piernas_0: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_0[8 * 16] = {
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc0, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc0, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x40, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x40, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x84, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x84, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x00, 0x90, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x00, 0x90, 0x00, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile sprite_Piernas_1: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_1[8 * 16] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc0, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc0, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x40, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x40, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile sprite_Piernas_2: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_2[8 * 16] = {
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc0, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc0, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x40, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x40, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x84, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x84, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x00, 0x90, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x00, 0x90, 0x00, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile sprite_Piernas_3: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_3[8 * 16] = {
	0x00, 0x00, 0x14, 0x03, 0x03, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0xc0, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x10, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x90, 0x10, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x80, 0x80, 0x10, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x80, 0x80, 0x10, 0x00, 0x00, 0x00,
	0x00, 0x00, 0xc0, 0x80, 0x90, 0x00, 0x00, 0x00,
	0x00, 0x00, 0xc0, 0x80, 0x90, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0xc0, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0xc0, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile sprite_Piernas_4: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_4[8 * 16] = {
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x3c, 0x28, 0x18, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x40, 0x20, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x40, 0x20, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x40, 0x20, 0x40, 0x20, 0x00, 0x00,
	0x00, 0x00, 0x84, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x84, 0x00, 0x40, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x00, 0x90, 0x00, 0x00,
	0x00, 0x00, 0x90, 0x00, 0x00, 0x90, 0x00, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x40, 0x20, 0x00, 0x00, 0xc0, 0x20, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile sprite_Piernas_5: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_5[8 * 16] = {
	0x00, 0x00, 0x24, 0x14, 0x3c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x24, 0x14, 0x3c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x40, 0xc0, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x40, 0xc0, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x80, 0x60, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x80, 0x60, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x80, 0x10, 0x80, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x80, 0x10, 0x80, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x80, 0x00, 0x48, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x80, 0x00, 0x48, 0x00, 0x00,
	0x00, 0x00, 0x60, 0x00, 0x00, 0x60, 0x00, 0x00,
	0x00, 0x00, 0x60, 0x00, 0x00, 0x60, 0x00, 0x00,
	0x00, 0x10, 0xc0, 0x00, 0x00, 0x10, 0x80, 0x00,
	0x00, 0x10, 0xc0, 0x00, 0x00, 0x10, 0x80, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile sprite_Piernas_6: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_6[8 * 16] = {
	0x00, 0x00, 0x00, 0x03, 0x03, 0x28, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x24, 0x14, 0x3c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x24, 0x14, 0x3c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x40, 0xc0, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x20, 0x60, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x20, 0x60, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x20, 0x40, 0x40, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x20, 0x40, 0x40, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x60, 0x40, 0xc0, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x60, 0x40, 0xc0, 0x00, 0x00,
	0x00, 0x00, 0x10, 0xc0, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x10, 0xc0, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

// Tile sprite_Piernas_7: 16x16 pixels, 8x16 bytes.
const u8 sprite_Piernas_7[8 * 16] = {
	0x00, 0x00, 0x24, 0x14, 0x3c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x24, 0x14, 0x3c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x10, 0x80, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x80, 0x10, 0x80, 0x00, 0x00,
	0x00, 0x00, 0x10, 0x80, 0x10, 0x80, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x80, 0x00, 0x48, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x80, 0x00, 0x48, 0x00, 0x00,
	0x00, 0x00, 0x60, 0x00, 0x00, 0x60, 0x00, 0x00,
	0x00, 0x00, 0x60, 0x00, 0x00, 0x60, 0x00, 0x00,
	0x00, 0x10, 0xc0, 0x00, 0x00, 0x10, 0x80, 0x00,
	0x00, 0x10, 0xc0, 0x00, 0x00, 0x10, 0x80, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>>>>> 60fbd1c2a1d49d64fa63cfbf8d8016fb08aea566
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};
