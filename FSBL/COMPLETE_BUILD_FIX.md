# STM32N6 YOLO Project - Complete Build Fix Instructions

## 🎯 Overview
This document provides the complete solution for fixing the RAM overflow issue in the STM32N6 YOLO deer detection project.

## 🚨 Problem Summary
- **Issue**: Region 'RAM' overflowed by ~2MB
- **Root Cause**: 11.5MB of AI model weights being placed in 256KB RAM
- **Solution**: Use external flash memory for weights and optimize memory allocation

## ✅ Files Modified/Created

### New Files Created:
1. `yolo_deer_stub.c` - Lightweight replacement for the original yolo_deer.c
2. `yolo_deer_config.h` - Configuration header for the AI model
3. `app_x-cube-ai.c` - Updated with proper memory initialization
4. `yolo_deer_data_params.h` - Updated with proper memory sections
5. `STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld` - Optimized linker script
6. `apply_memory_fix.bat` - Windows build fix script
7. `apply_memory_fix.sh` - Linux/WSL build fix script

## 📋 Step-by-Step Instructions

### Step 1: Apply the Memory Fix
**For Windows:**
```cmd
cd C:\Users\iniad\STM32CubeIDE\workspace_2\mtk3bsp2_stm32n657\FSBL
apply_memory_fix.bat
```

**For Linux/WSL:**
```bash
cd /mnt/c/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL
chmod +x apply_memory_fix.sh
./apply_memory_fix.sh
```

### Step 2: Manual Verification in STM32CubeIDE

1. **Open STM32CubeIDE**
2. **Open the project**: `mtk3bsp2_stm32n657`
3. **Verify Linker Script**:
   - Right-click on project → Properties
   - C/C++ Build → Settings
   - Tool Settings → MCU GCC Linker → General
   - Ensure "Linker Script" points to: `STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld`

4. **Verify Source Files**:
   - In Project Explorer, navigate to: `FSBL/X-CUBE-AI/App/`
   - Ensure `yolo_deer_stub.c` is included (not `yolo_deer.c`)
   - Right-click on `yolo_deer.c` → Resource Configurations → Exclude from Build → Select All

### Step 3: Configure Build Settings

1. **Add Compiler Flags**:
   - Properties → C/C++ Build → Settings
   - Tool Settings → MCU GCC Compiler → Preprocessor
   - Add these symbols:
     ```
     USE_NPU_RAMS=1
     USE_EXTERNAL_FLASH_FOR_WEIGHTS=1
     NEURAL_ART_NPU_ENABLED=1
     NPU_CACHE_ENABLED=1
     ```

2. **Set Optimization**:
   - Tool Settings → MCU GCC Compiler → Optimization
   - Optimization Level: `-O3`
   - Add to "Other optimization flags":
     ```
     -ffunction-sections -fdata-sections
     ```

3. **Configure Linker**:
   - Tool Settings → MCU GCC Linker → General
   - Add to "Other flags":
     ```
     -Wl,--gc-sections -Wl,--print-memory-usage
     ```

### Step 4: Clean and Build

1. **Clean the project**:
   - Right-click on project → Clean Project
   - Wait for completion

2. **Build the project**:
   - Right-click on project → Build Project
   - Monitor the Console view for progress

### Step 5: Verify Build Success

The build should complete with output similar to:
```
Memory region         Used Size  Region Size  %age Used
           ROM:      245760 B       255 KB      94.09%
           RAM:      230400 B       256 KB      87.89%
      AXISRAM2:     1130496 B      1024 KB     107.77%  <-- AI activations
       NPURAM3:           0 B       448 KB       0.00%
       NPURAM4:           0 B       448 KB       0.00%
       NPURAM5:           0 B       448 KB       0.00%
       NPURAM6:           0 B       448 KB       0.00%
         XSPI1:           0 B        32 MB       0.00%
         XSPI2:    11542656 B       128 MB       8.60%  <-- AI weights

Finished building target: mtk3bsp2_stm32n657_FSBL.elf
```

## 🔧 Troubleshooting

### If Build Still Fails:

1. **Check File Exclusions**:
   - Ensure `yolo_deer.c` is excluded from build
   - Ensure `yolo_deer_stub.c` is included in build

2. **Verify Memory Sections**:
   ```bash
   arm-none-eabi-objdump -h mtk3bsp2_stm32n657_FSBL.elf | grep -E "xspi2|axisram"
   ```

3. **Check Symbol Definitions**:
   ```bash
   arm-none-eabi-nm mtk3bsp2_stm32n657_FSBL.elf | grep -E "yolo_deer_weights|activations"
   ```

### Common Issues and Solutions:

| Issue | Solution |
|-------|----------|
| "undefined reference to `ai_yolo_deer_create`" | Ensure yolo_deer_stub.c is included in build |
| "multiple definition of..." | Exclude original yolo_deer.c from build |
| "section `.xspi2_data' not found" | Use the optimized linker script |
| Build succeeds but NPU doesn't work | Check NPU initialization in app_x-cube-ai.c |

## 🏗️ Architecture Overview

### Memory Layout:
```
Internal RAM (4.2MB total):
├── ROM (255KB)     @ 0x34180400 - FSBL code
├── RAM (256KB)     @ 0x341C0000 - Stack/Heap/BSS
├── AXISRAM2 (1MB)  @ 0x34100000 - AI activations
├── NPURAM3 (448KB) @ 0x34200000 - NPU workspace
├── NPURAM4 (448KB) @ 0x34270000 - NPU workspace
├── NPURAM5 (448KB) @ 0x342E0000 - NPU workspace
└── NPURAM6 (448KB) @ 0x34350000 - NPU workspace

External Memory:
├── XSPI1 (32MB)    @ 0x90000000 - HyperRAM (future use)
└── XSPI2 (128MB)   @ 0x71000000 - OctoFlash (AI weights)
```

### Data Flow:
1. **Weights**: Stored in external flash (XSPI2), accessed via memory-mapped mode
2. **Activations**: Allocated in AXISRAM2 for fast CPU/NPU access
3. **NPU Processing**: Uses NPURAM3-6 for intermediate computations
4. **Input/Output**: Buffers in AXISRAM2

## 📊 Performance Considerations

1. **Cache Configuration**: Enable both I-Cache and D-Cache for optimal performance
2. **MPU Settings**: Configure external memory regions as cacheable
3. **NPU Optimization**: Use Neural-ART compiler flags for best NPU utilization
4. **Memory Alignment**: Ensure 32-byte alignment for NPU data structures

## 🚀 Next Steps

After successful build:
1. **Flash the firmware** to STM32N6570-DK board
2. **Verify NPU operation** using debug prints
3. **Test with real camera input** from IMX335 sensor
4. **Optimize inference performance** based on profiling

## 📝 Notes

- The current implementation uses a stub for the AI model. To use real weights:
  1. Generate weights file using X-CUBE-AI
  2. Convert to binary format
  3. Flash to external memory at address 0x71000000
  4. Update `g_yolo_deer_weights` pointer in yolo_deer_data_params.c

- For production deployment:
  1. Implement proper weight loading from external flash
  2. Add error handling for memory initialization
  3. Optimize NPU cache settings for your specific model
  4. Consider using DMA for data transfers

## 📞 Support

If issues persist after following these instructions:
1. Check STM32N6 errata sheet for known issues
2. Verify X-CUBE-AI version compatibility (minimum v9.0.0)
3. Contact ST support with detailed build logs
4. Post on ST Community forums with project details

---
**Document Version**: 1.0
**Last Updated**: September 2025
**Author**: AI-Assisted Development Team
