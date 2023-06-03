#ifdef WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include <cstring>
#include <ctype.h>

// extern "C" {
// #include "git2.h"
// }

static char buffer[1024];

EXPORT
int add(int a, int b)
{
    // git_error_last();
    return a + b;
}

EXPORT
char* capitalize(char *str) {
    strcpy(buffer, str);
    buffer[0] = toupper(buffer[0]);
    return buffer;
}