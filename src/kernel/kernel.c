#include "ostd.h"

#define write(color, character) \
    video_memory[*cursor] = ((color) << 8) | (character); \
    ++*cursor;

void entry() {
    uint16_t *video_memory = ((uint16_t *)VIDEO_MEMORY);
    uint16_t *cursor = ((uint16_t *)TEXT_CURSOR);
    write(0x1b, 'b');
    while (1) {}
}
