#include <stdint.h>
#include "x86.hpp"
#include "cursor.hpp"
#include "tty.hpp"

int main() {    
    unsigned short blank = (0x1B << 8) | ' ';

    for (int i = 0; i < 80 * 25; i++) {
        video_mem[i] = blank;
    }

    disable_hardware_cursor();

    char string[4] = "hey";

    write_string((uint16_t*)string,0x1B,0);

    return 0;
}
