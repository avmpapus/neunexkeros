// Multiboot header
asm(".align 4\n"
    ".long 0x1BADB002\n"  // Magic number
    ".long 0x00\n"        // Flags
    ".long -(0x1BADB002 + 0x00)\n");  // Checksum

    extern "C" void kernel_main() {
        const char *str = "This is kernel OS!";
        unsigned short *video_memory = (unsigned short*) 0xB8000; // Адреса текстового буфера VGA
        for (int i = 0; str[i] != '\0'; i++) {
            video_memory[i] = (video_memory[i] & 0xFF00) | str[i];
        }
        while (1); // Нескінченний цикл, щоб ядро не завершилось
    }
    