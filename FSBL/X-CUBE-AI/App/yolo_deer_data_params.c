/**
  ******************************************************************************
  * @file    yolo_deer_data_params.c
  * @author  X-CUBE-AI / STEdgeAI (Fixed for build)
  * @brief   AI model weights parameters - External memory placement
  ******************************************************************************
  */

#include "yolo_deer.h"
#include "yolo_deer_data_params.h"
#include "yolo_deer_config.h"

/* Place the AI model weights in external flash memory (XSPI2) */
/* This prevents the weights from being loaded into RAM */
__attribute__((section(".xspi2_data")))
__attribute__((aligned(32)))
const signed char g_yolo_deer_weights[1024] = {
  /* NOTE: This is a placeholder array - real weights are much larger */
  /* The actual weights should be loaded from external flash */
  0x00  /* Placeholder data */
};

/* Activation buffers - place in appropriate RAM regions */
__attribute__((section(".axisram2_data")))
__attribute__((aligned(32)))
uint8_t g_yolo_deer_activations[1024];  /* Simplified size for build test */

/* Input/Output buffers */
__attribute__((section(".axisram2_data")))
__attribute__((aligned(32)))
int8_t g_yolo_deer_input_buffer[1024];  /* Simplified size for build test */

__attribute__((section(".axisram2_data")))
__attribute__((aligned(32)))
int8_t g_yolo_deer_output_buffer[1024];  /* Simplified size for build test */

/* Get weights pointer */
const void* ai_yolo_deer_data_weights_get(void)
{
  return (const void*)g_yolo_deer_weights;
}

/* Get activations pointer */
void* ai_yolo_deer_data_activations_get(void)
{
  return (void*)g_yolo_deer_activations;
}
