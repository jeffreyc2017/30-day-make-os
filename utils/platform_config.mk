/*
 * Author: jeffreyc2017
 *
 * License: MIT
 */

# File: platform_config.mk

# Detect if we're on a Raspberry Pi
IS_RASPBERRY_PI := $(if $(RPI),1,0)
UNAME := $(shell uname -a)
RASPBERRY_PI := $(findstring raspberrypi,$(UNAME))

ifeq ($(RASPBERRY_PI),raspberrypi)
	IS_RASPBERRY_PI := 1
else
	IS_RASPBERRY_PI := 0
endif

# Default GCCPREFIX for x86 PC
GCCPREFIX :=

# Set GCCPREFIX for Raspberry Pi
ifeq ($(IS_RASPBERRY_PI),1)
	GCCPREFIX := i686-linux-gnu-
endif

# macOS specific configuration
ifeq ($(shell uname -s),Darwin)
	# Check if x86_64-elf-gcc and x86_64-elf-ld are installed
	ifeq ($(shell which x86_64-elf-gcc),)
		$(warning x86_64-elf-gcc not found. Please install it using Homebrew:)
		$(warning brew install x86_64-elf-gcc)
		$(error Aborting build)
	endif
	ifeq ($(shell which x86_64-elf-ld),)
		$(warning x86_64-elf-ld not found. Please install x86_64-elf-binutils using Homebrew:)
		$(warning brew install x86_64-elf-binutils)
		$(error Aborting build)
	endif
	GCCPREFIX := x86_64-elf-
endif

export GCCPREFIX
