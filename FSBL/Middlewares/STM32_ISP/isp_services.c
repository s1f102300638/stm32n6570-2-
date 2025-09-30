/* Minimal ISP service implementation */
#include "isp_services.h"

/* These functions are already defined in isp_core.c */
/* Using weak attributes or guards to avoid duplicate definition */

#ifndef ISP_CORE_IMPLEMENTATION
/* Only compile these if ISP_CORE is not providing them */

__attribute__((weak)) int ISP_Init(void) {
    return 0; /* Success */
}

__attribute__((weak)) int ISP_Start(void) {
    return 0; /* Success */
}

#endif /* ISP_CORE_IMPLEMENTATION */
