/* Temporary ISP stub to avoid compilation errors */
#ifndef ISP_SERVICES_STUB_H
#define ISP_SERVICES_STUB_H

// Define missing types
typedef struct {
    uint32_t dummy;
} DCMIPP_HandleTypeDef;

typedef struct {
    uint32_t dummy;
} DCMIPP_StatisticExtractionConfTypeDef;

// Define missing constants
#define DCMIPP_PIPE0 0
#define DCMIPP_PIPE1 1
#define DCMIPP_PIPE2 2
#define HAL_DCMIPP_STATE_READY 1

// Add stub functions
#define HAL_DCMIPP_GetState(x) HAL_DCMIPP_STATE_READY
#define HAL_DCMIPP_PIPE_DisableGammaConversion(x,y) HAL_OK
#define HAL_DCMIPP_PIPE_EnableGammaConversion(x,y) HAL_OK

#endif /* ISP_SERVICES_STUB_H */
