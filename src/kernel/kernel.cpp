#define VIDEO_MEMORY 0xB8000
#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25

int main() {
    unsigned short* video_memory = (unsigned short*)VIDEO_MEMORY;
    
    unsigned short blank = (0x1B << 8) | ' ';

    for (int i = 0; i < SCREEN_WIDTH * SCREEN_HEIGHT; i++) {
        video_memory[i] = blank;
    }

    return 0;
}
