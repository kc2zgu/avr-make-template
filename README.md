AVR Module Makefile Template
============================

This is a collection of makefiles for building AVR microcontroller
projects using the GNU toolchain (avr-gcc). Makefile targets are also
included for burning the compiled images to flash using a variety of
programming methods.

Using the Template in Your Project
----------------------------------

Create a Makefile in your project directory with the following:

    MCU_FAM=mega
    MCU_MODEL=328
    PROJECT=example
    SOURCE=main.c timer.c eeprom.c
    INC=
    LIBS=
    PROGMODE=isp
    
    include defaults.mk
    include build.mk
    include program.mk

MCU\_FAM and MCU\_MODEL set the chip being used (compiler -mmcu= and
avrdude -p flags are calculated from these). PROJECT is the name of
the project, used as a base for the output files. SOURCE is a list of
source code files (.c .cc .cpp and .S are allowed). INC and LIBS set
additional include directories and libraries. PROGMODE sets the
programming protocol to be used for writing the program to flash.

Compiling
---------

The default makefile target (all) will compile all source files, link
to a single .elf, and generate a .hex programming file.

Installing
----------

The install target will write the compiled program to flash memory. A
number of programming methods are supported, controlled by the
PROGMODE variable:

  * PROGMODE=serial Use a serial programmer or bootloader such as an
    STK500 board, Arduino bootloader, Xboot, etc.
  * PROGMODE=isp Use SPI-based ISP (In-System Programming) with a
    programmer such as the AVR ISP Mk.II, JTAG ICE, Atmel ICE, etc.
  * PROGMODE=pdi Use XMEGA PDI (Program and Debug Interface).
  * PROGMODE=updi Use the UPDI (Unified Programming and Debug
    Interface) with a UART adapter and the avr-updi tool (from the
    Device-AVR-UPDI CPAN distribution).

TODO
----

Features for the future:

  * Some way to handle libraries
  * Other programming modes like JTAG, HVSP, TPI

Credits
-------

Written by Stephen Cavilia, inspired by Pat Deegan's Makefile template
and Xboot's makefile.
