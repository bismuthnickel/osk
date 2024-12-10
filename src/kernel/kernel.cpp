#include "x86.hpp"

#define VIDEO_MEMORY 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_CTRL_PORT 0x3D4
#define VGA_DATA_PORT 0x3D5

void set_cursor(int row, int col) {
    int position = (row * VGA_WIDTH) + col;  // Calculate linear position
    x86_outb(VGA_CTRL_PORT, 0x0E);               // Select cursor high byte
    x86_outb(VGA_DATA_PORT, (position >> 8) & 0xFF);  // Send high byte of position
    x86_outb(VGA_CTRL_PORT, 0x0F);               // Select cursor low byte
    x86_outb(VGA_DATA_PORT, position & 0xFF);        // Send low byte of position
}

int main() {
    unsigned short* video_memory = (unsigned short*)VIDEO_MEMORY;
    
    unsigned short blank = (0x1B << 8) | ' ';

    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        video_memory[i] = blank;
    }

    set_cursor(2,1);

    return 0;
}
