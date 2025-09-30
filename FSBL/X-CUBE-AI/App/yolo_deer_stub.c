/**
  ******************************************************************************
  * @file    yolo_deer_stub.c
  * @author  X-CUBE-AI C code generator (Fixed stub version v2)
  * @brief   AI model implementation - Minimal stub for build testing
  ******************************************************************************
  */

#include "yolo_deer.h"
#include "yolo_deer_data_params.h"
#include <string.h>
#include <stddef.h>

/* Note: The actual Neural-ART instance is declared in the generated yolo_deer files */
/* This stub only provides compatibility functions for building */

/* Simplified stub implementation for build testing */

/**
 * @brief Stub function to satisfy linker
 * This is a minimal implementation to make the project compile
 */
void yolo_deer_stub_init(void)
{
    /* Initialization code will use the actual Neural-ART runtime */
    /* For now, this is just to resolve symbols */
}

/**
 * @brief Get network info (simplified)
 */
int yolo_deer_get_info_stub(void)
{
    return 0;
}

/* Provide minimal implementations to satisfy undefined references */
/* These will be replaced by actual Neural-ART implementations */

#ifdef STUB_MODE
/* Only compile these if we're in stub mode to avoid conflicts */

void* ai_yolo_deer_create(void)
{
    return (void*)1; /* Return non-NULL dummy pointer */
}

int ai_yolo_deer_get_info(void* network, void* report)
{
    if (report != NULL) {
        /* Fill with dummy values */
        memset(report, 0, sizeof(ai_network_report));
    }
    return 1; /* Success */
}

void* ai_yolo_deer_inputs_get(void* network, void* n_buffer)
{
    static ai_buffer dummy_buffer;
    memset(&dummy_buffer, 0, sizeof(ai_buffer));
    return &dummy_buffer;
}

void* ai_yolo_deer_outputs_get(void* network, void* n_buffer) 
{
    static ai_buffer dummy_buffer;
    memset(&dummy_buffer, 0, sizeof(ai_buffer));
    return &dummy_buffer;
}

int ai_yolo_deer_run(void* network, const void* input, void* output)
{
    return 1; /* Return success */
}

int ai_yolo_deer_get_error(void* network)
{
    return 0; /* No error */
}

#endif /* STUB_MODE */
