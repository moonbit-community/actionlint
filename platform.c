#include <stdlib.h>
#include <stdio.h>
#include <moonbit.h>
MOONBIT_FFI_EXPORT void actionlint_exit(int code) {
  fflush(NULL);
  exit(code);
}
