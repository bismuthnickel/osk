#include <stdint.h>
#include "x86.hpp"
#include "vga.hpp"
#include "cursor.hpp"

int main() {
    unsigned short* video_memory = (unsigned short*)0xB8000;
    
    unsigned short blank = (0x1B << 8) | ' ';

    for (int i = 0; i < 80 * 25; i++) {
        video_memory[i] = blank;
    }

    disable_cursor();

    return 0;
}
