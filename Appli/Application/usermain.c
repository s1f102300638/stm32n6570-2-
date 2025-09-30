/*
 *	STM32N6570-DK LED and Task Example for ﾎｼT-Kernel 3.0 BSP2
 *
 *    Copyright (C) 2025 by TRON Forum.
 *    This software is distributed under the T-License 2.1.
 *----------------------------------------------------------------------
 *
 *    Released by TRON Forum(http://www.tron.org) at 2025.
 */
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "main.h"

/* GPIO Port O base address for STM32N6 */
#if (TRUSTZONE_ENABLE && TRUSTZONE_SECURE)
/* #define GPIOO_BASE	0x56023800 */ /* Removed duplicate definition */
#else
#define GPIOO_BASE	0x46023800
#endif

/* LED pin on PO1 */
#define LED_PIN		(1 << 1)

LOCAL void task_led(INT stacd, void *exinf);	// LED control task
LOCAL ID	tskid_led;			// Task ID number
LOCAL T_CTSK ctsk_led = {			// Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_led,
	.tskatr		= TA_HLNG | TA_RNG3,
};

LOCAL void task_msg(INT stacd, void *exinf);	// Message output task
LOCAL ID	tskid_msg;			// Task ID number
LOCAL T_CTSK ctsk_msg = {			// Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_msg,
	.tskatr		= TA_HLNG | TA_RNG3,
};

/* LED control using direct register access */
LOCAL void led_on(void)
{
	/* Set PO1 high using ODR register */
	out_h(GPIO_ODR(O), in_h(GPIO_ODR(O)) | LED_PIN);
}

LOCAL void led_off(void)
{
	/* Set PO1 low using ODR register */
	out_h(GPIO_ODR(O), in_h(GPIO_ODR(O)) & ~LED_PIN);
}

LOCAL void led_toggle(void)
{
	/* Toggle PO1 using ODR register */
	out_h(GPIO_ODR(O), in_h(GPIO_ODR(O)) ^ LED_PIN);
}

/* Alternative LED control using HAL (if available) */
LOCAL void led_hal_toggle(void)
{
	GPIO_TypeDef* gpio_port = (GPIO_TypeDef*)GPIOO_BASE;
	HAL_GPIO_TogglePin(gpio_port, GPIO_PIN_1);
}

LOCAL void task_led(INT stacd, void *exinf)
{
	UINT counter = 0;
	
	tm_printf((UB*)"LED task started\n");
	
	while(1) {
		/* Method 1: Direct register access using macros */
		if(counter % 4 == 0) {
			tm_printf((UB*)"LED ON (direct)\n");
			led_on();
		} else if(counter % 4 == 1) {
			tm_printf((UB*)"LED OFF (direct)\n");
			led_off();
		} else if(counter % 4 == 2) {
			tm_printf((UB*)"LED Toggle (direct)\n");
			led_toggle();
		} else {
			tm_printf((UB*)"LED Toggle (HAL)\n");
			led_hal_toggle();
		}
		
		counter++;
		tk_dly_tsk(500);
	}
}

LOCAL void task_msg(INT stacd, void *exinf)
{
	UINT msg_count = 0;
	
	tm_printf((UB*)"Message task started\n");
	
	while(1) {
		tm_printf((UB*)"Message %d - System running\n", msg_count++);
		
		/* Check GPIO status */
		UINT gpio_status = in_h(GPIO_ODR(O));
		tm_printf((UB*)"GPIO Port O ODR: 0x%08X, LED is %s\n", 
			gpio_status, 
			(gpio_status & LED_PIN) ? "ON" : "OFF");
		
		tk_dly_tsk(700);
	}
}

/* Initialize GPIO for LED */
LOCAL void init_led_gpio(void)
{
	GPIO_InitTypeDef GPIO_InitStruct = {0};
	GPIO_TypeDef* gpio_port = (GPIO_TypeDef*)GPIOO_BASE;
	
	/* Enable GPIO Port O clock */
	__HAL_RCC_GPIOO_CLK_ENABLE();
	
	/* Enable VDDIO2 power supply for Port O */
	HAL_PWREx_EnableVddIO2();
	
	/* Configure PO1 as output */
	HAL_GPIO_WritePin(gpio_port, GPIO_PIN_1, GPIO_PIN_RESET);
	
	GPIO_InitStruct.Pin = GPIO_PIN_1;
	GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
	HAL_GPIO_Init(gpio_port, &GPIO_InitStruct);
	
	tm_putstring((UB*)"LED GPIO initialized (PO1)\n");
}

/* usermain髢｢謨ｰ */
EXPORT INT usermain(void)
{
	tm_putstring((UB*)"================================\n");
	tm_putstring((UB*)"Start User-main program.\n");
	tm_putstring((UB*)"STM32N6570-DK ﾎｼT-Kernel 3.0 BSP2\n");
	tm_putstring((UB*)"LED Control Demo\n");
	tm_putstring((UB*)"================================\n");

	/* Initialize LED GPIO */
	init_led_gpio();
	
	/* Turn off the LED initially */
	led_off();
	tm_putstring((UB*)"LED turned OFF initially\n");
	
	/* Test LED by blinking 3 times */
	tm_putstring((UB*)"Testing LED...\n");
	for(int i = 0; i < 3; i++) {
		led_on();
		tk_dly_tsk(200);
		led_off();
		tk_dly_tsk(200);
	}
	tm_putstring((UB*)"LED test complete\n");

	/* Create & Start LED control task */
	tskid_led = tk_cre_tsk(&ctsk_led);
	if(tskid_led > 0) {
		tk_sta_tsk(tskid_led, 0);
		tm_putstring((UB*)"LED task created and started\n");
	} else {
		tm_putstring((UB*)"ERROR: Failed to create LED task\n");
	}

	/* Create & Start message task */
	tskid_msg = tk_cre_tsk(&ctsk_msg);
	if(tskid_msg > 0) {
		tk_sta_tsk(tskid_msg, 0);
		tm_putstring((UB*)"Message task created and started\n");
	} else {
		tm_putstring((UB*)"ERROR: Failed to create message task\n");
	}

	tm_putstring((UB*)"Main task entering sleep mode\n");
	tk_slp_tsk(TMO_FEVR);

	return 0;
}
