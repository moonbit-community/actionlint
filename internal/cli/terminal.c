#include <moonbit.h>
#ifdef _WIN32
#include <io.h>
MOONBIT_FFI_EXPORT int32_t actionlint_isatty(int32_t fd) { return _isatty(fd); }
#else
#include <unistd.h>
MOONBIT_FFI_EXPORT int32_t actionlint_isatty(int32_t fd) { return isatty(fd); }
#endif
