/*
******************************************************************************
**
** @file        : STM32N6XX_AXISRAM2_fsbl_optimized.ld
**
** @author      : GPM Application Team (Optimized for STM32N6 with Neural-ART)
**
** @brief       : Optimized Linker script for STM32N6XX Device
**                - Proper memory layout for Neural-ART NPU
**                - External memory support for weights
**                - Correct RAM allocation
**
**  Target      : STMicroelectronics STM32N6
**
******************************************************************************
** @attention
**
** Copyright (c) 2024 STMicroelectronics.
** All rights reserved.
**
******************************************************************************
*/

/* Entry Point */
ENTRY(Reset_Handler)

/* Generate a link error if heap and stack don't fit into RAM */
_Min_Heap_Size = 0x800;   /* Increased heap for AI operations */
_Min_Stack_Size = 0x1000; /* Increased stack for AI operations */

/* Specify the memory areas */
MEMORY
{
  /* Internal SRAM - FSBL code and data */
  ROM    (xrw)    : ORIGIN = 0x34180400,   LENGTH = 255K
  RAM    (xrw)    : ORIGIN = 0x341C0000,   LENGTH = 256K
  
  /* CPU RAM for AI activations and buffers */
  AXISRAM2 (xrw)  : ORIGIN = 0x34100000,   LENGTH = 1024K
  
  /* NPU RAMs for Neural-ART accelerator */
  NPURAM3  (xrw)  : ORIGIN = 0x34200000,   LENGTH = 448K
  NPURAM4  (xrw)  : ORIGIN = 0x34270000,   LENGTH = 448K
  NPURAM5  (xrw)  : ORIGIN = 0x342E0000,   LENGTH = 448K
  NPURAM6  (xrw)  : ORIGIN = 0x34350000,   LENGTH = 448K
  
  /* External memories */
  XSPI1    (rx)   : ORIGIN = 0x90000000,   LENGTH = 32M    /* HyperRAM for large activations */
  XSPI2    (rx)   : ORIGIN = 0x71000000,   LENGTH = 128M   /* OctoFlash for AI weights */
}

/* Highest address of the user mode stack */
_estack = ORIGIN(RAM) + LENGTH(RAM);
_sstack = _estack - _Min_Stack_Size;

/* Define output sections */
SECTIONS
{
  /* The startup code goes first into ROM */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Startup code */
    . = ALIGN(4);
  } >ROM

  /* The program code and other data goes into ROM */
  .text :
  {
    . = ALIGN(4);
    *(.text)           /* .text sections (code) */
    *(.text*)          /* .text* sections (code) */
    *(.glue_7)         /* glue arm to thumb code */
    *(.glue_7t)        /* glue thumb to arm code */
    *(.eh_frame)
    
    KEEP (*(.init))
    KEEP (*(.fini))

    . = ALIGN(4);
    _etext = .;        /* define a global symbols at end of code */
  } >ROM

  /* Constant data goes into ROM */
  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)         /* .rodata sections (constants, strings, etc.) */
    *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
    . = ALIGN(4);
  } >ROM

  .ARM.extab   (READONLY) :
  {
    . = ALIGN(4);
    *(.ARM.extab* .gnu.linkonce.armextab.*)
    . = ALIGN(4);
  } >ROM

  .ARM (READONLY) :
  {
    . = ALIGN(4);
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
    . = ALIGN(4);
  } >ROM

  .preinit_array (READONLY) :
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
    . = ALIGN(4);
  } >ROM

  .init_array (READONLY) :
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
    . = ALIGN(4);
  } >ROM

  .fini_array (READONLY) :
  {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    PROVIDE_HIDDEN (__fini_array_end = .);
    . = ALIGN(4);
  } >ROM

  /* AI model weights in external flash (XSPI2) */
  .ai_weights :
  {
    . = ALIGN(32);  /* Align to cache line */
    __ai_weights_start = .;
    KEEP(*(.ai_weights))
    KEEP(*(.xspi2_data))
    KEEP(*yolo_deer*.o(.rodata*))  /* Place yolo_deer weights in external flash */
    __ai_weights_end = .;
  } >XSPI2

  /* AI activations in CPU RAM */
  .ai_activations (NOLOAD) :
  {
    . = ALIGN(32);
    __ai_activations_start = .;
    KEEP(*(.ai_activations))
    KEEP(*(.axisram2_data))
    . = ALIGN(32);
    __ai_activations_end = .;
  } >AXISRAM2

  /* NPU buffers */
  .npu_ram3 (NOLOAD) :
  {
    . = ALIGN(32);
    __npu_ram3_start = .;
    KEEP(*(.npuram3))
    __npu_ram3_end = .;
  } >NPURAM3

  .npu_ram4 (NOLOAD) :
  {
    . = ALIGN(32);
    __npu_ram4_start = .;
    KEEP(*(.npuram4))
    __npu_ram4_end = .;
  } >NPURAM4

  .npu_ram5 (NOLOAD) :
  {
    . = ALIGN(32);
    __npu_ram5_start = .;
    KEEP(*(.npuram5))
    __npu_ram5_end = .;
  } >NPURAM5

  .npu_ram6 (NOLOAD) :
  {
    . = ALIGN(32);
    __npu_ram6_start = .;
    KEEP(*(.npuram6))
    __npu_ram6_end = .;
  } >NPURAM6

  /* Large activation buffers in external HyperRAM */
  .xspi1_data (NOLOAD) :
  {
    . = ALIGN(32);
    __xspi1_start = .;
    KEEP(*(.xspi1_data))
    __xspi1_end = .;
  } >XSPI1

  /* Used by the startup to initialize data */
  _sidata = LOADADDR(.data);

  /* Initialized data sections */
  .data :
  {
    . = ALIGN(4);
    _sdata = .;        /* create a global symbol at data start */
    *(.data)           /* .data sections */
    *(.data*)          /* .data* sections */
    *(.RamFunc)        /* .RamFunc sections */
    *(.RamFunc*)       /* .RamFunc* sections */

    . = ALIGN(4);
    _edata = .;        /* define a global symbol at data end */
  } >RAM AT> ROM

  /* Noncacheable section */
  .noncacheable :
  {
    . = ALIGN(8);
    __snoncacheable = .;
    KEEP(*(noncacheable_buffer))
    . = ALIGN(8);
    __enoncacheable = .;
  } >RAM

  /* Secure Gateway stubs */
  .gnu.sgstubs :
  {
    . = ALIGN(4);
    *(.gnu.sgstubs*)
    . = ALIGN(4);
  } >ROM

  /* Uninitialized data section */
  . = ALIGN(4);
  .bss :
  {
    _sbss = .;
    __bss_start__ = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)

    . = ALIGN(4);
    _ebss = .;
    __bss_end__ = _ebss;
  } >RAM

  /* User_heap_stack section */
  ._user_heap_stack :
  {
    . = ALIGN(8);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
  } >RAM

  /* Remove information from the compiler libraries */
  /DISCARD/ :
  {
    libc.a ( * )
    libm.a ( * )
    libgcc.a ( * )
  }

  .ARM.attributes 0 : { *(.ARM.attributes) }
}
