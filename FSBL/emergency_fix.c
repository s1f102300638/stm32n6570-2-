/**
  ******************************************************************************
  * @file    emergency_fix.c
  * @brief   Emergency fix to reduce memory usage
  ******************************************************************************
  */

/* 
 * EMERGENCY FIX INSTRUCTIONS:
 * 
 * 1. Add this file to the project
 * 2. In app_x-cube-ai.c, comment out these lines:
 *    // MX_X_CUBE_AI_Init();
 *    // MX_X_CUBE_AI_Process();
 * 
 * 3. In main.c, add at the top:
 *    #define DISABLE_YOLO_MODEL 1
 * 
 * This will disable the YOLO model temporarily to verify
 * the rest of the system builds correctly.
 */

#ifdef DISABLE_YOLO_MODEL

/* Stub functions to replace YOLO calls */
void* ai_yolo_deer_create(void *buffer, unsigned int size)
{
    return buffer;
}

int ai_yolo_deer_init(void *model, void *params)
{
    return 0;
}

int ai_yolo_deer_run(void *model, void *input, void *output)
{
    /* Return dummy detection result */
    return 0;
}

int ai_yolo_deer_get_info(void *model, void *info)
{
    return 0;
}

#endif /* DISABLE_YOLO_MODEL */

/* Reduce memory usage by providing smaller buffers */
#ifdef REDUCE_MEMORY_USAGE

/* Override large buffer allocations */
#define AI_BUFFER_SIZE_OVERRIDE 1024  /* 1KB instead of MB */

unsigned char mini_ai_buffer[AI_BUFFER_SIZE_OVERRIDE];

void emergency_memory_init(void)
{
    /* Use minimal buffers for testing */
}

#endif /* REDUCE_MEMORY_USAGE */
