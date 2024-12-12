#include "tty.hpp"
#include "cursor.hpp"

uint16_t get_16_bit_teletype(Teletype teletype) {
    uint16_t bits16tty;
    bits16tty = (teletype.ColorData << 8) | teletype.Character;
    return bits16tty;
}

void write_teletype(uint16_t teletype, uint16_t location) {
    video_mem[location] = teletype;
}

void write_char(uint8_t character, uint8_t color, uint16_t location) {
    Teletype charac;
    charac.Character = character;
    charac.ColorData = color;
    uint16_t bits16tty;
    bits16tty = get_16_bit_teletype(charac);
    write_teletype(bits16tty, location);
}

void write_string(uint16_t* string, uint8_t color, uint16_t location) {
    uint16_t* reference = string;
    uint16_t offset = location;
    while (*reference != 0) {
        write_char(*reference, color, offset);
        offset += 2;
        ++reference;
    }
}