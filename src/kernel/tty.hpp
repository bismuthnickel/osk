#pragma once

#include <stdint.h>
#include "cursor.hpp"

struct Teletype {
    uint8_t Character;
    uint8_t ColorData;
};

#define video_mem ((unsigned short*)0xB8000)

uint16_t get_16_bit_teletype(Teletype teletype);
void write_teletype(uint16_t teletype, uint16_t location);
void write_char(uint8_t character, uint8_t color, uint16_t location);
void write_string(uint16_t* string, uint8_t color, uint16_t location);