void kernel_main() {
    const char *str = "Welcome to K-Window!";
    char *video = (char*)0xb8000;
    for (int i = 0; str[i] != '\0'; i++) {
        video[i * 2] = str[i];
        video[i * 2 + 1] = 0x0F;
    }
    while (1);
}
