#include <stdint.h>
#include "vga.h"

void write_char(char c, uint8_t color, uint16_t* x, uint16_t* y) {
    uint16_t position = (*y * SCREEN_WIDTH + *x) * 2;
    volatile uint8_t* video = (volatile uint8_t*)VIDEO_MEMORY;
    video[position] = c;
    video[position + 1] = color;
    *x += 1;
}

void write_to_video_memory(const char* message, uint8_t color, uint16_t* x, uint16_t* y) {
    for (int i = 0; message[i] != '\0'; ++i) {
        write_char(message[i], color, x, y);
    }
}

void clear_screen(uint8_t color) {
    volatile uint8_t* video = (volatile uint8_t*)VIDEO_MEMORY;
    for (uint16_t i = 0; i < SCREEN_WIDTH * SCREEN_HEIGHT; ++i) {
        video[i * 2] = ' ';
        video[i * 2 + 1] = color;
    }
}
