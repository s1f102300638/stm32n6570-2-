/*
 * yolo_deer_detection.h
 * YOLOv8 nano Deer Detection for STM32N6570-DK
 * 
 * Copyright (C) 2025
 */

#ifndef __YOLO_DEER_DETECTION_H
#define __YOLO_DEER_DETECTION_H

#include <stdint.h>
#include <stdbool.h>
#include "ai_platform.h"

/* YOLOv8 nano configuration for 320x320 input */
#define YOLO_INPUT_WIDTH    320
#define YOLO_INPUT_HEIGHT   320
#define YOLO_INPUT_CHANNELS 3
#define YOLO_INPUT_SIZE     (YOLO_INPUT_WIDTH * YOLO_INPUT_HEIGHT * YOLO_INPUT_CHANNELS)

/* YOLOv8 output configuration */
#define YOLO_GRID_SIZE      8400  /* Total anchor boxes for YOLOv8 */
#define YOLO_NUM_CLASSES    1      /* Single class: deer */
#define YOLO_BBOX_SIZE      4      /* x, y, w, h */
#define YOLO_OUTPUT_SIZE    (YOLO_GRID_SIZE * (YOLO_BBOX_SIZE + YOLO_NUM_CLASSES + 1))

/* Detection thresholds */
#define CONFIDENCE_THRESHOLD 0.45f  /* Adjusted for deer detection */
#define NMS_THRESHOLD       0.4f
#define MAX_DETECTIONS      10

/* Memory allocation sizes for INT8 model */
#define AI_NETWORK_DATA_WEIGHTS_SIZE       (512 * 1024)   /* 512KB for INT8 YOLOv8 nano */
#define AI_NETWORK_DATA_ACTIVATIONS_SIZE   (256 * 1024)   /* 256KB for activations */

/* Detection structure */
typedef struct {
    float x;        /* Center X coordinate (0-1) */
    float y;        /* Center Y coordinate (0-1) */
    float width;    /* Width (0-1) */
    float height;   /* Height (0-1) */
    float confidence;
    uint8_t class_id;
} detection_t;

/* Detection result structure */
typedef struct {
    detection_t detections[MAX_DETECTIONS];
    uint8_t num_detections;
    uint32_t inference_time_ms;
    uint32_t preprocessing_time_ms;
    uint32_t postprocessing_time_ms;
} detection_result_t;

/* Image preprocessing structure */
typedef struct {
    uint8_t* raw_image;        /* Raw camera input RGB565 */
    uint16_t raw_width;
    uint16_t raw_height;
    int8_t* preprocessed_image;  /* Preprocessed INT8 image */
} image_data_t;

/* AI model handle */
typedef struct {
    ai_handle network;
    ai_network_report network_info;
    ai_u8* activations;
    ai_u8* weights;
    bool initialized;
    uint32_t total_inferences;
    uint32_t total_detections;
} yolo_model_t;

/* Function prototypes */

/* Initialize YOLO model */
int32_t YOLO_Init(yolo_model_t* model);

/* Deinitialize YOLO model */
void YOLO_DeInit(yolo_model_t* model);

/* Preprocess camera image for YOLO input (RGB565 to INT8) */
int32_t YOLO_PreprocessImage(const uint8_t* rgb565_input, 
                             uint16_t width, 
                             uint16_t height,
                             int8_t* output_buffer);

/* Run YOLO inference */
int32_t YOLO_RunInference(yolo_model_t* model, 
                          const int8_t* input_data,
                          int8_t* output_data);

/* Post-process YOLO output to get detections */
int32_t YOLO_PostProcess(const int8_t* raw_output,
                         detection_result_t* result);

/* Non-Maximum Suppression */
void YOLO_NMS(detection_t* detections, 
              uint8_t* num_detections,
              float nms_threshold);

/* Draw bounding boxes on display buffer */
void YOLO_DrawDetections(uint16_t* display_buffer,
                        uint16_t width,
                        uint16_t height,
                        const detection_result_t* result);

/* Convert YOLOv8 output format to bounding boxes */
void YOLO_DecodeOutput(const int8_t* raw_output,
                      detection_t* detections,
                      uint8_t* num_detections);

/* Utility functions */
float YOLO_Sigmoid(float x);
float YOLO_IoU(const detection_t* box1, const detection_t* box2);
int8_t YOLO_QuantizeFloat(float value, float scale, int32_t zero_point);
float YOLO_DequantizeInt8(int8_t value, float scale, int32_t zero_point);

/* Debug functions */
void YOLO_PrintDetection(const detection_t* detection);
void YOLO_PrintStats(const yolo_model_t* model);

#endif /* __YOLO_DEER_DETECTION_H */
