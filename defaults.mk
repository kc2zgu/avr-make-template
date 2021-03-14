# AVR Modular Makefile template by Stephen Cavilia
# defaults.mk: default variable definitions

# programs

CC=avr-gcc
OBJCOPY=avr-objcopy
OBJDUMP=avr-objdump
SIZE=avr-size
RM=rm -f
AVRDUDE=avrdude
AVRUPDI=avr-updi

# expand MCU name
ifeq ($(MCU_FAM), tiny)
MCU=attiny$(MCU_MODEL)
PROGRAMMER_MCU=t$(MCU_MODEL)
else ifeq ($(MCU_FAM), mega)
MCU=atmega$(MCU_MODEL)
PROGRAMMER_MCU=m$(MCU_MODEL)
else ifeq ($(MCU_FAM), xmega)
MCU=atxmega$(MCU_MODEL)
PROGRAMMER_MCU=x$(MCU_MODEL)
endif

# toolchain flags
OPT=3
DEBUG_FMT=stabs
CSTD=gnu99
CXXSTD=gnu++11
COMMON_FLAGS=-I. $(INC) -g$(DEBUG_FMT) -mmcu=$(MCU) -O$(OPT) \
	-fpack-struct -fshort-enums -funsigned-bitfields -funsigned-char \
	-ffunction-sections -fdata-sections \
	-Wall -Wstrict-prototypes -Werror=implicit \
	-Wa,-adhlns=$(basename $<).lst
CFLAGS=$(COMMON_FLAGS) -std=$(CSTD)
CXXFLAGS=$(COMMON_FLAGS) -fno-exceptions -std=$(CXXSTD)
ASMFLAGS=-Wa,-adhlns=$(<:.S=.lst),-gstabs
LDFLAGS=-Wl,-Map,$(TRG).map -mmcu=$(MCU) -lm $(LIBS)
HEX_FMT=ihex

# programmer settings
ISP_PROGRAMMER=atmelice_isp
PDI_PROGRAMMER=atmelice_pdi
SERIAL_PROGRAMMER=arduino
PROGRAMMER_PORT=usb:
UART_PORT=/dev/ttyUSB0
AVRDUDE_BAUD=115200
UPDI_BAUD=115200
AVRDUDE_OPTS=
