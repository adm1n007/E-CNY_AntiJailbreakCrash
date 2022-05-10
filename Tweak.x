#include <mach-o/dyld.h>
#include <mach-o/getsect.h>

extern void MSHookMemory(void *target, const void *data, size_t size);
static const uint8_t RET[] = {
    0xC0, 0x03, 0x5F, 0xD6
};
%ctor {
    const struct mach_header_64 *header = (const struct mach_header_64 *)_dyld_get_image_header(0);
    MSHookMemory(*(void **)(((intptr_t)header + getsectbynamefromheader_64(header, "__DATA", "__mod_init_func")->offset) + 8), (void *)RET, 4);
}
