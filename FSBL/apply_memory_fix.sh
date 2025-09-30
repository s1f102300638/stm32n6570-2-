#!/bin/bash
#******************************************************************************
# Apply Build Fix Script for STM32N6 YOLO Project
# This script modifies the build configuration to fix RAM overflow issues
#******************************************************************************

echo "==================================================="
echo "STM32N6 YOLO Project Build Fix Script"
echo "==================================================="

# Check if we're in the FSBL directory
if [ ! -f "STM32N657X0HXQ_AXISRAM2_fsbl.ld" ]; then
    echo "ERROR: Please run this script from the FSBL directory!"
    exit 1
fi

echo ""
echo "Step 1: Backing up original files..."
echo "--------------------------------------"

# Create backup directory
mkdir -p build_backup

# Backup original files
if [ -f ".cproject" ]; then
    cp .cproject build_backup/cproject.original
    echo "✓ Backed up .cproject"
fi

if [ -f "makefile" ]; then
    cp makefile build_backup/makefile.original
    echo "✓ Backed up makefile"
fi

if [ -f "Makefile" ]; then
    cp Makefile build_backup/Makefile.original
    echo "✓ Backed up Makefile"
fi

echo ""
echo "Step 2: Updating linker script references..."
echo "--------------------------------------"

# Update .cproject to use optimized linker script
if [ -f ".cproject" ]; then
    sed -i 's/STM32N657X0HXQ_AXISRAM2_fsbl\.ld/STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld/g' .cproject
    echo "✓ Updated .cproject to use optimized linker script"
fi

# Update makefile/Makefile
for mkfile in makefile Makefile; do
    if [ -f "$mkfile" ]; then
        # Update linker script reference
        sed -i 's/STM32N657X0HXQ_AXISRAM2_fsbl\.ld/STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld/g' "$mkfile"
        
        # Replace yolo_deer.c with yolo_deer_stub.c
        sed -i 's/yolo_deer\.c/yolo_deer_stub.c/g' "$mkfile"
        
        echo "✓ Updated $mkfile"
    fi
done

echo ""
echo "Step 3: Modifying source file lists..."
echo "--------------------------------------"

# Find and update any file that references yolo_deer.c
for mkfile in makefile Makefile; do
    if [ -f "$mkfile" ]; then
        # Check if yolo_deer.c is in the source list
        if grep -q "yolo_deer.c" "$mkfile"; then
            # Already handled by sed above
            echo "✓ Replaced yolo_deer.c with yolo_deer_stub.c in $mkfile"
        fi
        
        # Add optimization flags for NPU
        if ! grep -q "USE_NPU_RAMS" "$mkfile"; then
            # Add NPU definition to CFLAGS
            sed -i '/^CFLAGS/s/$/ -DUSE_NPU_RAMS=1 -DUSE_EXTERNAL_FLASH_FOR_WEIGHTS=1/' "$mkfile"
            echo "✓ Added NPU flags to $mkfile"
        fi
    fi
done

echo ""
echo "Step 4: Creating build configuration file..."
echo "--------------------------------------"

# Create a build configuration file
cat > build_config.mk << 'EOF'
#******************************************************************************
# Build Configuration for STM32N6 YOLO Project
#******************************************************************************

# Use optimized linker script
LDSCRIPT = STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld

# Additional compiler flags for NPU and external memory
CUSTOM_CFLAGS = \
    -DUSE_NPU_RAMS=1 \
    -DUSE_EXTERNAL_FLASH_FOR_WEIGHTS=1 \
    -DNEURAL_ART_NPU_ENABLED=1 \
    -DNPU_CACHE_ENABLED=1

# Optimization flags for Neural-ART
NPU_OPT_FLAGS = \
    -O3 \
    -ffunction-sections \
    -fdata-sections

# Memory section flags
SECTION_FLAGS = \
    -Wl,--gc-sections \
    -Wl,--print-memory-usage

# Include this in your main Makefile:
# include build_config.mk
# CFLAGS += $(CUSTOM_CFLAGS) $(NPU_OPT_FLAGS)
# LDFLAGS += $(SECTION_FLAGS)
EOF

echo "✓ Created build_config.mk"

echo ""
echo "Step 5: Checking file replacements..."
echo "--------------------------------------"

# Check if stub file exists
if [ -f "X-CUBE-AI/App/yolo_deer_stub.c" ]; then
    echo "✓ yolo_deer_stub.c exists"
else
    echo "⚠ WARNING: yolo_deer_stub.c not found!"
    echo "  Please ensure the stub file has been created"
fi

# Check if optimized linker script exists
if [ -f "STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld" ]; then
    echo "✓ Optimized linker script exists"
else
    echo "⚠ WARNING: STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld not found!"
    echo "  Please ensure the optimized linker script has been created"
fi

echo ""
echo "Step 6: Cleaning build artifacts..."
echo "--------------------------------------"

# Clean build directories
if [ -d "Debug" ]; then
    rm -rf Debug/*
    echo "✓ Cleaned Debug directory"
fi

if [ -d "Release" ]; then
    rm -rf Release/*
    echo "✓ Cleaned Release directory"
fi

echo ""
echo "==================================================="
echo "Build fix has been applied!"
echo "==================================================="
echo ""
echo "Next steps:"
echo "1. Open the project in STM32CubeIDE"
echo "2. Right-click on project -> Clean Project"
echo "3. Right-click on project -> Build Project"
echo ""
echo "If you still encounter issues:"
echo "1. Check that all modified files are saved"
echo "2. Refresh the project (F5)"
echo "3. Check the Console view for detailed error messages"
echo ""
echo "To restore original files:"
echo "  cp build_backup/* ."
echo ""
echo "==================================================="
