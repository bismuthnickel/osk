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

    const char my_string[] = "hello!";

    write_string(my_string,0x1b,0);

    return 0;
}
