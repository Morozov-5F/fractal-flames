# Used binaries
CC = gcc
LD = gcc
RM = rm -rf

TARGET = fractal_flames
TOPDIR = ..

.PHONY: clean clean_all plot data all_data prepare_animate animation $(TARGET)

# Flags for c compiler
CFLAGS   = -ansi -Wall -Wpedantic -g
# Flags for linker
LDFLAGS	 = -L/usr/local/lib
# Shared libraries to link
L_FILES  = png16
# Include folders
I_PATH   = -I/usr/local/include

COMPILE_C   = $(CC) $(CFLAGS) $(I_PATH) -MD -c $< -o $@
LINK_BINARY = $(LD) $(LDFLAGS) $^ $(addprefix -l, $(L_FILES)) -o $@

# This var is used to add C files that are not in project folders
С_FILES +=
# This var contains folders with code in project
PRJ_C_SRC_DIRS = ./

# Object file to be produced
OBJS += $(patsubst %.c, %.o, $(C_FILES))
OBJS += $(patsubst %.c, %.o, $(wildcard  $(addsuffix /*.c, $(PRJ_C_SRC_DIRS))))

# Files to remove during clean
TOREMOVE += $(patsubst %.c, %.o, $(C_FILES))
TOREMOVE += $(patsubst %.c, %.d, $(C_FILES))
TOREMOVE += $(addsuffix /*.o,    $(PRJ_C_SRC_DIRS))
TOREMOVE += $(addsuffix /*.d,    $(PRJ_C_SRC_DIRS))
TOREMOVE += $(addsuffix .dbg,    $(TARGET))
# Remove plot data
TOREMOVE += $(addsuffix /*.png,  $(PRJ_C_SRC_DIRS))
TOREMOVE += $(addsuffix /*.log,  $(PRJ_C_SRC_DIRS))

$(TARGET): $(OBJS)
	@echo "Linking object files: " $<
	$(LINK_BINARY)

%.o: %.c
	@echo "Compiling C file: " $<
	@$(COMPILE_C)

clean:
	@echo "Cleaning: " $(TOREMOVE)
	@$(RM) $(TOREMOVE)

clean_all: clean
	@echo "Cleaning build directory"
	@$(RM) $(TARGET)

info:
	@echo "### Diagnostic info ###"
	@echo "Top directory:      " $(TOPDIR)
	@echo "Project directories:" $(PRJ_C_SRC_DIRS)
	@echo "Project name: " $(TARGET)
	@echo "C Files:      " $(wildcard  $(addsuffix *.c, $(PRJ_C_SRC_DIRS))) $(C_FILES)
	@echo "Object files: " $(OBJS)
	@echo "C compiler:   " $(CC)
	@echo "Include path: " $(I_PATH)
	@echo "LD flags:     " $(LDFLAGS)
	@echo "LD files:     " $(L_FILES)
	@echo "CC flags:     " $(CFLAGS)