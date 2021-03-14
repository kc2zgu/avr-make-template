# AVR modular makefile template

# Project setup:
# set these variables to describe your project

# MCU family (can be tiny, mega, or xmega) and model number
MCU_FAM=mega
MCU_MODEL=328

# project name
PROJECT=example

# all C/C++/asm source files
SOURCE=main.c timer.c serial.c sensors.c

# include directories and libraries
INC=
LIBS=

# the default programming protocol, can be serial, isp, pdi, or updi
PROGMODE=isp

# these makefiles define the rules to build and install (program) the project
include defaults.mk
include build.mk
include program.mk
