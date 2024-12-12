#include <stdint.h>
#include "vga.h"
#include "cursor.h"

uint8_t main() {
    disable_cursor();
    Cursor cursor;
    clear_screen(0x1B);
    const char msg_hey[] = "OSK - open source kernel";
    write_to_video_memory(msg_hey,0x1B,&cursor.x,&cursor.y);
    return 0;
}