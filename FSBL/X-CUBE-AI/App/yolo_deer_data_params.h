/**
  ******************************************************************************
  * @file    yolo_deer_data_params.h
  * @author  X-CUBE-AI / STEdgeAI (Fixed for build)
  * @brief   AI model data parameters header
  ******************************************************************************
  */

#ifndef YOLO_DEER_DATA_PARAMS_H
#define YOLO_DEER_DATA_PARAMS_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>

/* Function prototypes */
const void* ai_yolo_deer_data_weights_get(void);
void* ai_yolo_deer_data_activations_get(void);

/* External declarations for buffers */
extern int8_t g_yolo_deer_input_buffer[];
extern int8_t g_yolo_deer_output_buffer[];
extern uint8_t g_yolo_deer_activations[];

/* Compatibility definitions for ai_platform types if needed */
#ifndef AI_HANDLE_NULL
#define AI_HANDLE_NULL ((void*)0)
#endif

/* Basic type definitions for compatibility */
typedef void* ai_handle;
typedef uint8_t ai_u8;
typedef int8_t ai_i8;
typedef uint16_t ai_u16;
typedef uint32_t ai_u32;
typedef uint32_t ai_size;
typedef int32_t ai_i32;
typedef float ai_float;
typedef int32_t ai_buffer_format;
typedef uint32_t ai_flags;
typedef int32_t ai_bool;

/* Simple error structure */
typedef struct {
    int type;
    int code;
} ai_error;

/* Simple buffer structure */
typedef struct {
    ai_buffer_format format;
    void* data;
    void* meta_info;
    ai_flags flags;
    ai_size size;
    void* shape;
} ai_buffer;

/* Simple network report structure */
typedef struct {
    const char* model_name;
    uint32_t model_signature;
    const char* model_datetime;
    const char* compile_datetime;
    const char* runtime_revision;
    void* runtime_version;
    const char* tool_revision;
    void* tool_version;
    void* tool_api_version;
    void* api_version;
    void* interface_api_version;
    uint32_t n_macc;
    uint16_t n_inputs;
    uint16_t n_outputs;
    ai_buffer* inputs;
    ai_buffer* outputs;
    void* map_signature;
    void* map_weights;
    void* map_activations;
    uint32_t n_nodes;
    uint32_t signature;
} ai_network_report;

/* Simple network params structure */
typedef struct {
    void* params;
    void* activations;
} ai_network_params;

#ifdef __cplusplus
}
#endif

#endif /* YOLO_DEER_DATA_PARAMS_H */
