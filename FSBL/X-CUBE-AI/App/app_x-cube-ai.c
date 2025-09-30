/**
  ******************************************************************************
  * @file    app_x-cube-ai.c
  * @author  X-CUBE-AI C code generator (Fixed for STM32N6 v2)
  * @brief   AI program body - Fixed for Neural-ART NPU
  ******************************************************************************
  */

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <inttypes.h>
#include <string.h>

#include "app_x-cube-ai.h"
#include "main.h"

/* USER CODE BEGIN includes */
/* USER CODE END includes */

/* Private variables ---------------------------------------------------------*/
static uint8_t ai_initialized = 0;

/* Private function prototypes -----------------------------------------------*/
static void MX_NPU_Init(void);
static void MX_RAM_Init(void);

/**
  * @brief  Initialize all RAM banks for STM32N6
  * @retval None
  */
static void MX_RAM_Init(void)
{
    /* Enable clocks for all AXI SRAM banks */
    __HAL_RCC_AXISRAM1_MEM_CLK_ENABLE();
    __HAL_RCC_AXISRAM2_MEM_CLK_ENABLE();
    __HAL_RCC_AXISRAM3_MEM_CLK_ENABLE();
    __HAL_RCC_AXISRAM4_MEM_CLK_ENABLE();
    __HAL_RCC_AXISRAM5_MEM_CLK_ENABLE();
    __HAL_RCC_AXISRAM6_MEM_CLK_ENABLE();
    
    /* Enable FlexRAM and Cache RAM */
    __HAL_RCC_FLEXRAM_MEM_CLK_ENABLE();
    __HAL_RCC_CACHEAXIRAM_MEM_CLK_ENABLE();
    
    /* Wake up all SRAM banks from shutdown mode */
    /* Note: Using ISR register for status checking (not SR) */
    if (RAMCFG_SRAM1_AXI->CR & RAMCFG_CR_SRAMSD) {
        RAMCFG_SRAM1_AXI->CR &= ~RAMCFG_CR_SRAMSD;
        while(RAMCFG_SRAM1_AXI->ISR & RAMCFG_ISR_SRAMBUSY);
    }
    
    if (RAMCFG_SRAM2_AXI->CR & RAMCFG_CR_SRAMSD) {
        RAMCFG_SRAM2_AXI->CR &= ~RAMCFG_CR_SRAMSD;
        while(RAMCFG_SRAM2_AXI->ISR & RAMCFG_ISR_SRAMBUSY);
    }
    
    if (RAMCFG_SRAM3_AXI->CR & RAMCFG_CR_SRAMSD) {
        RAMCFG_SRAM3_AXI->CR &= ~RAMCFG_CR_SRAMSD;
        while(RAMCFG_SRAM3_AXI->ISR & RAMCFG_ISR_SRAMBUSY);
    }
    
    if (RAMCFG_SRAM4_AXI->CR & RAMCFG_CR_SRAMSD) {
        RAMCFG_SRAM4_AXI->CR &= ~RAMCFG_CR_SRAMSD;
        while(RAMCFG_SRAM4_AXI->ISR & RAMCFG_ISR_SRAMBUSY);
    }
    
    if (RAMCFG_SRAM5_AXI->CR & RAMCFG_CR_SRAMSD) {
        RAMCFG_SRAM5_AXI->CR &= ~RAMCFG_CR_SRAMSD;
        while(RAMCFG_SRAM5_AXI->ISR & RAMCFG_ISR_SRAMBUSY);
    }
    
    if (RAMCFG_SRAM6_AXI->CR & RAMCFG_CR_SRAMSD) {
        RAMCFG_SRAM6_AXI->CR &= ~RAMCFG_CR_SRAMSD;
        while(RAMCFG_SRAM6_AXI->ISR & RAMCFG_ISR_SRAMBUSY);
    }
}

/**
  * @brief  Initialize Neural-ART NPU
  * @retval None
  */
static void MX_NPU_Init(void)
{
    /* Enable NPU clock */
    __HAL_RCC_NPU_CLK_ENABLE();
    
    /* Reset NPU */
    __HAL_RCC_NPU_FORCE_RESET();
    HAL_Delay(1);
    __HAL_RCC_NPU_RELEASE_RESET();
    
    /* Wait for NPU to be ready */
    HAL_Delay(10);
}

/**
  * @brief  Set clocks to remain enabled in low power modes
  * @retval None
  */
static void set_clk_sleep_mode(void)
{
    /* Leave clocks enabled in Low Power modes */
#if defined (CPU_IN_SECURE_STATE)
    __HAL_RCC_DBG_CLK_SLEEP_ENABLE();
#endif
    __HAL_RCC_XSPIPHYCOMP_CLK_SLEEP_ENABLE();
    
    /* Low-power clock enable for memories */
    __HAL_RCC_AXISRAM1_MEM_CLK_SLEEP_ENABLE();
    __HAL_RCC_AXISRAM2_MEM_CLK_SLEEP_ENABLE();
    __HAL_RCC_AXISRAM3_MEM_CLK_SLEEP_ENABLE();
    __HAL_RCC_AXISRAM4_MEM_CLK_SLEEP_ENABLE();
    __HAL_RCC_AXISRAM5_MEM_CLK_SLEEP_ENABLE();
    __HAL_RCC_AXISRAM6_MEM_CLK_SLEEP_ENABLE();
    __HAL_RCC_FLEXRAM_MEM_CLK_SLEEP_ENABLE();
    __HAL_RCC_CACHEAXIRAM_MEM_CLK_SLEEP_ENABLE();
    
    /* LP clock AHB3 */
#if defined (CPU_IN_SECURE_STATE)
    __HAL_RCC_RIFSC_CLK_SLEEP_ENABLE();
    __HAL_RCC_RISAF_CLK_SLEEP_ENABLE();
    __HAL_RCC_IAC_CLK_SLEEP_ENABLE();
#endif
    
    /* LP clocks AHB5 */
    __HAL_RCC_XSPI1_CLK_SLEEP_ENABLE();
    __HAL_RCC_XSPI2_CLK_SLEEP_ENABLE();
    __HAL_RCC_CACHEAXI_CLK_SLEEP_ENABLE();
    __HAL_RCC_NPU_CLK_SLEEP_ENABLE();
    
    /* LP clocks APB2 */
    __HAL_RCC_USART1_CLK_SLEEP_ENABLE();
}

/**
  * @brief  Initialize X-CUBE-AI application
  * @retval None
  */
void MX_X_CUBE_AI_Init(void)
{
    /* Initialize all RAM banks */
    MX_RAM_Init();
    
    /* Enable external memory interfaces */
    __HAL_RCC_XSPI1_CLK_ENABLE();
    __HAL_RCC_XSPI2_CLK_ENABLE();
    
    /* Enable cache for better performance */
    __HAL_RCC_CACHEAXI_CLK_ENABLE();
    SCB_EnableICache();
    SCB_EnableDCache();
    
    /* Initialize Neural-ART NPU */
    MX_NPU_Init();
    
    /* Configure low power mode settings */
    set_clk_sleep_mode();
    
    /* Set initialization flag */
    ai_initialized = 1;
    
    /* USER CODE BEGIN 5 */
    /* USER CODE END 5 */
}

/**
  * @brief  Process AI inference
  * @retval None
  */
void MX_X_CUBE_AI_Process(void)
{
    /* USER CODE BEGIN 6 */
    
    /* Check if AI is initialized */
    if (!ai_initialized) {
        return;
    }
    
    /* Placeholder for AI processing */
    /* The actual Neural-ART runtime calls would go here */
    /* For now, this is just a stub to allow building */
    
#ifdef NEURAL_ART_ENABLED
    /* When Neural-ART is properly configured, use this code: */
    /*
    LL_ATON_RT_RuntimeInit();
    
    for (int i = 0; i < 10; i++) {
        // Initialize network
        LL_ATON_RT_Init_Network(&NN_Instance_yolo_deer);
        
        // Run inference
        LL_ATON_RT_RetValues_t ret;
        do {
            ret = LL_ATON_RT_RunEpochBlock(&NN_Instance_yolo_deer);
            if (ret == LL_ATON_RT_WFE) {
                LL_ATON_OSAL_WFE();
            }
        } while (ret != LL_ATON_RT_DONE);
        
        // Deinitialize network
        LL_ATON_RT_DeInit_Network(&NN_Instance_yolo_deer);
    }
    
    LL_ATON_RT_RuntimeDeInit();
    */
#else
    /* Stub implementation for testing */
    static int inference_count = 0;
    
    /* Simulate 10 inferences */
    for (int i = 0; i < 10; i++) {
        inference_count++;
        HAL_Delay(10); /* Simulate processing time */
    }
#endif
    
    /* USER CODE END 6 */
}

#ifdef __cplusplus
}
#endif
