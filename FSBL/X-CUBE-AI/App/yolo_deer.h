/**
  ******************************************************************************
  * @file    yolo_deer.h
  * @author  STEdgeAI
  * @date    2025-09-26 20:52:14
  * @brief   Minimal description of the generated c-implemention of the network
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2025 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  ******************************************************************************
  */
#ifndef LL_ATON_YOLO_DEER_H
#define LL_ATON_YOLO_DEER_H

/******************************************************************************/
#define LL_ATON_YOLO_DEER_C_MODEL_NAME        "yolo_deer"
#define LL_ATON_YOLO_DEER_ORIGIN_MODEL_NAME   "best"

/************************** USER ALLOCATED IOs ********************************/
// No user allocated inputs
// No user allocated outputs

/************************** INPUTS ********************************************/
#define LL_ATON_YOLO_DEER_IN_NUM        (1)    // Total number of input buffers
// Input buffer 1 -- Input_1_out_0
#define LL_ATON_YOLO_DEER_IN_1_ALIGNMENT   (32)
#define LL_ATON_YOLO_DEER_IN_1_SIZE_BYTES  (1228800)

/************************** OUTPUTS *******************************************/
#define LL_ATON_YOLO_DEER_OUT_NUM        (1)    // Total number of output buffers
// Output buffer 1 -- Concat_245_out_0
#define LL_ATON_YOLO_DEER_OUT_1_ALIGNMENT   (32)
#define LL_ATON_YOLO_DEER_OUT_1_SIZE_BYTES  (42000)

#endif /* LL_ATON_YOLO_DEER_H */
