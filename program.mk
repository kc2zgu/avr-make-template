# AVR Modular Makefile template by Stephen Cavilia
# program.mk: targets for flash programming

.PHONY: common-program program-serial program-isp program-pdi program-updi

install: common-program

common-program: $(HEXTRG)

ifeq ($(PROGMODE),isp)
common-program: program-isp
else ifeq ($(PROGMODE),serial)
common-program: program-serial
else ifeq ($(PROGMODE),pdi)
common-program: program-pdi
else ifeq ($(PROGMODE),updi)
common-program: program-updi
else ifdef PROGMODE
common-program:
	@echo "Programming mode '${PROGMODE}' not supported"
else
common-program: program-undef
endif

program-serial:
	@echo "Programming $(FLASHHEX) with serial ($(SERIAL_PROGRAMMER))"
	$(AVRDUDE) -c $(SERIAL_PROGRAMMER) -P $(UART_PORT) -b $(AVRDUDE_BAUD) \
	-p $(PROGRAMMER_MCU) -D -e $(AVRDUDE_OPTS) -U flash:w:$(FLASHHEX)

program-isp:
	@echo "Programming $(FLASHHEX) with ISP"
	$(AVRDUDE) -c $(ISP_PROGRAMMER) -P $(PROGRAMMER_PORT) -b $(AVRDUDE_BAUD) \
	-p $(PROGRAMMER_MCU) -D -e $(AVRDUDE_OPTS) -U flash:w:$(FLASHHEX)

program-pdi:
	@echo "Programming $(FLASHHEX) with PDI"
	$(AVRDUDE) -c $(PDI_PROGRAMMER) -P $(PROGRAMMER_PORT) -b $(AVRDUDE_BAUD) \
	-p $(PROGRAMMER_MCU) -D -e $(AVRDUDE_OPTS) -U flash:w:$(FLASHHEX)

program-updi:
	@echo "Programming with UPDI"
	$(AVRUPDI) -P $(UART_PORT) -p $(PROGRAMMER_MCU) -B $(AVRDUDE_BAUD) write-flash $(FLASHHEX)

program-undef:
	echo "No programming mode defined"
