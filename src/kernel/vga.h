#include <stdint.h>

#define VIDEO_MEMORY 0xB8000
#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25

void write_char(char c, uint8_t color, uint16_t* x, uint16_t* y);
void write_to_video_memory(const char* message, uint8_t color, uint16_t* x, uint16_t* y);
void clear_screen(uint8_t color);