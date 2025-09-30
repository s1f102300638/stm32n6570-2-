
/* Shared resources between camera and AI tasks */
/* #include "semphr.h" - Using uT-Kernel instead */

static volatile int g_new_frame_available = 0;
#include "main.h"

#include <stdint.h>
/* Temporary type definitions */

/*
 *	STM32N6570-DK Camera with YOLO Deer Detection
 *	for ﾎｼT-Kernel 3.0 BSP2
 *
 *    Copyright (C) 2025 by Ken Sakamura.
 *    This software is distributed under the T-License 2.1.
 *----------------------------------------------------------------------
 *
 *    Released by TRON Forum(http://www.tron.org) at 2025/07.
 */
#include <tk/tkernel.h>
#include <tm/tmonitor.h>

/* DCMIPP definitions - temporary fix */
#ifndef DCMIPP_PIPE1
#define DCMIPP_PIPE1 1
#endif
#ifndef DCMIPP_VIRTUAL_CHANNEL0
#define DCMIPP_VIRTUAL_CHANNEL0 0
#endif
#ifndef DCMIPP_MODE_CONTINUOUS
#define DCMIPP_MODE_CONTINUOUS 0
#endif

#include <main.h>
#include "isp_api.h"
#include "imx335_E27_isp_param_conf.h"
#include "stm32n6570_discovery.h"
#include "yolo_deer_detection.h"

/* DCMIPP definitions - temporary fix */
#ifndef DCMIPP_PIPE1
#define DCMIPP_PIPE1 1
#endif
#ifndef DCMIPP_VIRTUAL_CHANNEL0
#define DCMIPP_VIRTUAL_CHANNEL0 0
#endif
#ifndef DCMIPP_MODE_CONTINUOUS
#define DCMIPP_MODE_CONTINUOUS 0
#endif

extern DCMIPP_HandleTypeDef	hdcmipp;
extern ISP_HandleTypeDef	hcamera_isp;
extern void* hltdc; /* Placeholder */

/* Global variables for YOLO detection */
LOCAL yolo_model_t g_yolo_model;
LOCAL detection_result_t g_detection_result;
LOCAL float g_preprocessed_image[YOLO_INPUT_SIZE];
LOCAL float g_yolo_output[YOLO_OUTPUT_SIZE];
LOCAL BOOL g_detection_enabled = FALSE;
LOCAL ID g_detection_semid;
LOCAL uint32_t g_frame_counter = 0;
LOCAL uint32_t g_deer_detection_count = 0;

/* 
 * User Button Interrupt handler and task
 */
#define BTNINT_IRQ	33
#define BTNINT_EXTI	(MIN_EXTI_INTNO + 13)

LOCAL void inthdr_btn(UINT intno);		// Interrupt handler function
LOCAL T_DINT	dint_btn = {			// Interrupt handler definition information
	.intatr = TA_HLNG,
	.inthdr = inthdr_btn,
};

LOCAL void task_btn(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_btn;			// Task ID number
LOCAL T_CTSK ctsk_sw = {			// Task creation information
	.itskpri	= 9,
	.stksz		= 1024,
	.task		= task_btn,
	.tskatr		= TA_HLNG | TA_RNG3,
};

LOCAL void inthdr_btn(UINT intno)
{
	ClearInt(BTNINT_EXTI);
	tk_wup_tsk(tskid_btn);

	ClearInt(intno);
}

LOCAL void task_btn(INT stacd, void *exinf)
{
	BOOL	is_video_running = TRUE;

	/* Interrupt handler definition */
	tk_def_int(BTNINT_IRQ, &dint_btn);
	SetIntMode(BTNINT_EXTI, IM_EDGE | IM_LOW);
	EnableInt(BTNINT_EXTI, 0);
	EnableInt(BTNINT_IRQ, 10);

	while(1) {
		tk_slp_tsk(TMO_FEVR);

		if(is_video_running) {
			/* HAL_DCMIPP_CSI_PIPE_Stop(&hdcmipp, DCMIPP_PIPE1, DCMIPP_VIRTUAL_CHANNEL0); */
			is_video_running = FALSE;
			g_detection_enabled = FALSE;
			BSP_LED_Off(LED_GREEN);  // Turn off LED when video stops
			tm_putstring((UB*)"Video stopped - Detection disabled\n");
		} else {
			/* HAL_DCMIPP_CSI_PIPE_Start(&hdcmipp, DCMIPP_PIPE1, DCMIPP_MODE_CONTINUOUS); */
			is_video_running = TRUE;
			g_detection_enabled = TRUE;
			BSP_LED_On(LED_GREEN);  // Turn on LED when video starts
			tm_putstring((UB*)"Video started - Detection enabled\n");
			
			/* Signal detection task to start */
			tk_sig_sem(g_detection_semid, 1);
		}
	}
}

/*
 * Camera control task
 */
LOCAL void task_cam(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_cam;			// Task ID number
LOCAL T_CTSK ctsk_cam = {			// Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_cam,
	.tskatr		= TA_HLNG | TA_RNG3,
};

LOCAL void task_cam(INT stacd, void *exinf)
{
	UINT led_counter = 0;
	
	while(1) {
		if( ISP_BackgroundProcess(&hcamera_isp) != ISP_OK) break;
		
		/* Blink red LED periodically to show camera task is running */
		led_counter++;
		if(led_counter >= 10) {  // Every 1 second (100ms * 10)
			BSP_LED_Toggle(LED_RED);
			led_counter = 0;
		}
		
		tk_dly_tsk(100);
	}
	
	/* If ISP process fails, indicate error with LED */
	BSP_LED_Off(LED_GREEN);
	BSP_LED_On(LED_RED);
	tm_putstring((UB*)"Camera task error\n");
	
	tk_ext_tsk();
}

/*
 * YOLO Detection task
 */
LOCAL void task_detection(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_detection;			// Task ID number
LOCAL T_CTSK ctsk_detection = {			// Task creation information
	.itskpri	= 11,
	.stksz		= 4096,  // Larger stack for AI processing
	.task		= task_detection,
	.tskatr		= TA_HLNG | TA_RNG3,
};

LOCAL void task_detection(INT stacd, void *exinf)
{
	uint32_t start_time, end_time;
	int32_t ret;
	
	tm_putstring((UB*)"YOLO Detection task started\n");
	
	/* Initialize YOLO model */
	ret = YOLO_Init(&g_yolo_model);
	if (ret != 0) {
		tm_putstring((UB*)"Failed to initialize YOLO model\n");
		tk_ext_tsk();
		return;
	}
	
	tm_putstring((UB*)"YOLO model initialized successfully\n");
	YOLO_PrintStats(&g_yolo_model);
	
	while(1) {
		/* Wait for semaphore signal */
		tk_wai_sem(g_detection_semid, 1, TMO_FEVR);
		
		while (g_detection_enabled) {
			/* Get frame from camera buffer */
			uint8_t* frame_buffer = (uint8_t*)BUFFER_ADDRESS;
			
			/* Record start time */
			start_time = HAL_GetTick();
			
			/* Preprocess image for YOLO */
			ret = YOLO_PreprocessImage(frame_buffer, 800, 480, (int8_t*)g_preprocessed_image);
			if (ret != 0) {
				tm_putstring((UB*)"Image preprocessing failed\n");
				tk_dly_tsk(100);
				continue;
			}
			
			/* Run YOLO inference */
			ret = YOLO_RunInference(&g_yolo_model, (const int8_t*)g_preprocessed_image, (int8_t*)g_yolo_output);
			if (ret != 0) {
				tm_putstring((UB*)"YOLO inference failed\n");
				tk_dly_tsk(100);
				continue;
			}
			
			/* Post-process results */
			ret = YOLO_PostProcess((const int8_t*)g_yolo_output, &g_detection_result);
			if (ret != 0) {
				tm_putstring((UB*)"Post-processing failed\n");
				tk_dly_tsk(100);
				continue;
			}
			
			/* Record end time */
			end_time = HAL_GetTick();
			g_detection_result.inference_time_ms = end_time - start_time;
			
			/* Update frame counter */
			g_frame_counter++;
			
			/* Process detections */
			if (g_detection_result.num_detections > 0) {
				g_deer_detection_count++;
				
				/* Draw bounding boxes on display */
				YOLO_DrawDetections((uint16_t*)frame_buffer, 800, 480, &g_detection_result);
				
				/* Print detection info every 10 detections */
				if (g_deer_detection_count % 10 == 0) {
					tm_printf((UB*)"Deer detected! Count: %d, Frame: %d, Time: %dms\n",
							g_deer_detection_count, g_frame_counter, 
							g_detection_result.inference_time_ms);
					
					/* Print first detection details */
					if (g_detection_result.num_detections > 0) {
						YOLO_PrintDetection(&g_detection_result.detections[0]);
					}
				}
				
				/* Flash both LEDs to indicate detection */
				BSP_LED_On(LED_GREEN);
				BSP_LED_On(LED_RED);
				tk_dly_tsk(50);
				BSP_LED_Off(LED_RED);
			}
			
			/* Process at ~10 FPS */
			tk_dly_tsk(100);
			
			/* Print statistics every 100 frames */
			if (g_frame_counter % 100 == 0) {
				tm_printf((UB*)"Stats - Frames: %d, Detections: %d, Detection rate: %d%%\n",
						g_frame_counter, g_deer_detection_count,
						(g_deer_detection_count * 100) / g_frame_counter);
			}
		}
		
		/* Detection disabled, wait */
		tk_dly_tsk(100);
	}
}

/*
 * System monitoring task
 */
LOCAL void task_monitor(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_monitor;				// Task ID number
LOCAL T_CTSK ctsk_monitor = {			// Task creation information
	.itskpri	= 12,
	.stksz		= 512,
	.task		= task_monitor,
	.tskatr		= TA_HLNG | TA_RNG3,
};

LOCAL void task_monitor(INT stacd, void *exinf)
{
	uint32_t counter = 0;
	
	while(1) {
		/* Monitor system health every 5 seconds */
		tk_dly_tsk(5000);
		counter++;
		
		tm_printf((UB*)"\n=== System Monitor [%d] ===\n", counter);
		tm_printf((UB*)"Detection: %s\n", g_detection_enabled ? "ENABLED" : "DISABLED");
		tm_printf((UB*)"Frames processed: %d\n", g_frame_counter);
		tm_printf((UB*)"Deer detections: %d\n", g_deer_detection_count);
		
		if (g_detection_result.inference_time_ms > 0) {
			tm_printf((UB*)"Last inference time: %d ms\n", g_detection_result.inference_time_ms);
			tm_printf((UB*)"Estimated FPS: %d\n", 1000 / g_detection_result.inference_time_ms);
		}
		
		/* Check memory usage if needed */
		tm_putstring((UB*)"System running normally\n");
		tm_putstring((UB*)"=======================\n\n");
	}
}

/*
 * User Main function
 */
EXPORT INT usermain(void)
{
	T_CSEM csem;
	ER ercd __attribute__((unused));
	
	tm_putstring((UB*)"Start User-main program.\n");
	tm_putstring((UB*)"STM32N6570-DK Camera with YOLO Deer Detection\n");
	tm_putstring((UB*)"===============================================\n");

	/* Initialize LEDs using BSP */
	BSP_LED_Init(LED_GREEN);
	BSP_LED_Init(LED_RED);
	
	/* Turn off all LEDs initially */
	BSP_LED_Off(LED_GREEN);
	BSP_LED_Off(LED_RED);
	
	/* Flash LEDs to indicate system startup */
	tm_putstring((UB*)"System initialization...\n");
	for(int i = 0; i < 3; i++) {
		BSP_LED_On(LED_GREEN);
		BSP_LED_On(LED_RED);
		tk_dly_tsk(100);
		BSP_LED_Off(LED_GREEN);
		BSP_LED_Off(LED_RED);
		tk_dly_tsk(100);
	}
	
	tm_putstring((UB*)"LED initialization complete\n");

	/* Create semaphore for detection task synchronization */
	csem.sematr = TA_TFIFO | TA_FIRST;
	csem.isemcnt = 0;
	csem.maxsem = 1;
	g_detection_semid = tk_cre_sem(&csem);
	if (g_detection_semid < E_OK) {
		tm_putstring((UB*)"Failed to create semaphore\n");
		tk_slp_tsk(TMO_FEVR);
		return 0;
	}
	
	/* Create & Start Button Task */
	tskid_btn = tk_cre_tsk(&ctsk_sw);
	if(tskid_btn > 0) {
		tk_sta_tsk(tskid_btn, 0);
		tm_putstring((UB*)"Button task started\n");
	} else {
		tm_putstring((UB*)"Failed to create button task\n");
	}

	/* Create & Start Camera Task */
	tskid_cam = tk_cre_tsk(&ctsk_cam);
	if(tskid_cam > 0) {
		tk_sta_tsk(tskid_cam, 0);
		tm_putstring((UB*)"Camera task started\n");
	} else {
		tm_putstring((UB*)"Failed to create camera task\n");
	}
	
	/* Create & Start YOLO Detection Task */
	tskid_detection = tk_cre_tsk(&ctsk_detection);
	if(tskid_detection > 0) {
		tk_sta_tsk(tskid_detection, 0);
		tm_putstring((UB*)"YOLO detection task started\n");
	} else {
		tm_putstring((UB*)"Failed to create detection task\n");
	}
	
	/* Create & Start System Monitor Task */
	tskid_monitor = tk_cre_tsk(&ctsk_monitor);
	if(tskid_monitor > 0) {
		tk_sta_tsk(tskid_monitor, 0);
		tm_putstring((UB*)"System monitor task started\n");
	} else {
		tm_putstring((UB*)"Failed to create monitor task\n");
	}
	
	tm_putstring((UB*)"===============================================\n");
	tm_putstring((UB*)"System ready!\n");
	tm_putstring((UB*)"Press USER button to toggle video/detection\n");
	tm_putstring((UB*)"===============================================\n\n");
	
	/* Start with detection enabled */
	g_detection_enabled = TRUE;
	tk_sig_sem(g_detection_semid, 1);

	/* Main task sleeps forever */
	tk_slp_tsk(TMO_FEVR);
	return 0;
}












