#include "tty.hpp"
#include "cursor.hpp"

Teletype generate_teletype(uint8_t character, uint8_t color) {
    Teletype teletype;
    teletype.Character = character;
    teletype.ColorData = color;
    return teletype;
}

uint16_t get_16_bit_teletype(Teletype teletype) {
    uint16_t bits16tty;
    bits16tty = (teletype.ColorData << 8) | teletype.Character;
    return bits16tty;
}

void write_teletype(uint16_t teletype, uint16_t location) {
    video_mem[location] = teletype;
}

void write_char(uint8_t character, uint8_t color, uint16_t location) {
    write_teletype(get_16_bit_teletype(generate_teletype(character,color)),location);
}

void write_string(const char* string, uint8_t color, uint16_t location) {
    uint16_t current_location = location; // Keep track of the current location in video memory

    // Loop through the string until the null terminator is reached
    for (const char* ptr = string; *ptr != '\0'; ++ptr) {
        write_char((uint8_t)*ptr, color, current_location); // Write the character
        ++current_location; // Move to the next location in video memory
    }
}