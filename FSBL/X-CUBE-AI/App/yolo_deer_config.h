/**
  ******************************************************************************
  * @file    yolo_deer_config.h
  * @author  X-CUBE-AI Runtime
  * @brief   AI model configuration (Fixed version)
  ******************************************************************************
  */

#ifndef YOLO_DEER_CONFIG_H
#define YOLO_DEER_CONFIG_H

/* Model name and version */
#define AI_YOLO_DEER_MODEL_NAME          "yolo_deer"
#define AI_YOLO_DEER_ORIGIN_MODEL_NAME   "yolov8n_deer_int8"

/* Platform configuration */
#define AI_PLATFORM_API_VERSION_MAJOR     1
#define AI_PLATFORM_API_VERSION_MINOR     1
#define AI_PLATFORM_API_VERSION_MICRO     0

/* Define this to enable NPU acceleration */
#define USE_NPU_RAMS                       1

/* Define this to enable external memory for weights */
#define USE_EXTERNAL_FLASH_FOR_WEIGHTS    1

/* Memory alignment requirements */
#define AI_BUFFER_ALIGNMENT                32

/* NPU specific settings */
#define NEURAL_ART_NPU_ENABLED             1
#define NPU_CACHE_ENABLED                  1

/* Enable stub mode for initial build testing */
#define STUB_MODE                          1

/* Input/Output sizes based on ll_aton definitions */
#define AI_YOLO_DEER_IN_1_SIZE_BYTES     LL_ATON_YOLO_DEER_IN_1_SIZE_BYTES
#define AI_YOLO_DEER_OUT_1_SIZE_BYTES    LL_ATON_YOLO_DEER_OUT_1_SIZE_BYTES

/* Placeholder for weights and activations sizes */
#define AI_YOLO_DEER_DATA_WEIGHTS_SIZE     (11542656)  /* 11.5MB weights */
#define AI_YOLO_DEER_DATA_ACTIVATIONS_SIZE (1130496)   /* 1.1MB activations */

#endif /* YOLO_DEER_CONFIG_H */
