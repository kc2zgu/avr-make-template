# AVR Modular Makefile template by Stephen Cavilia
# build.mk: build rules

# output files

TRG=$(PROJECT).elf
DUMPTRG=$(PROJECT).s
FLASHHEX=$(PROJECT).hex
EEHEX=$(PROJECT).ee.hex
HEXTRG=$(FLASHHEX) $(EEHEX)

# build rules

# all source files
CFILES=$(filter %.c, $(SOURCE))
CCFILES=$(filter %.cc, $(SOURCE))
CPPFILES=$(filter %.cpp, $(SOURCE))
ASMFILES=$(filter %.S, $(SOURCE))

# object files from source files
OBJS=$(CFILES:.c=.o) \
	$(CCFILES:.cc=.o) \
	$(CPPFILES:.cpp=.o) \
	$(ASMFILES:.S=.o)
LST=$(filter %.lst, $(OBJS:.o=.lst))
GENASMFILES=$(filter %.s, $(OBJS:.o=.s))

.SUFFIXES:
.SUFFIXES: .c .cc .cpp .o .elf .s .S .hex .ee.hex .h .hh .hpp
.PHONY: clean stats

all: $(TRG) $(HEXTRG)

disasm: $(DUMPTRG) stats

hex: $(HEXTRG)

# stats target shows the size of each object as well as total image
stats: $(TRG)
	$(OBJDUMP) -h $(TRG)
	$(SIZE) $(OBJS) $(TRG)

# disassemble target image
$(DUMPTRG): $(TRG)
	$(OBJDUMP) -S $< > $@

# link all objects into target image
$(TRG): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

# pattern rules
# compile to object
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cc
	$(CC) $(CXXFLAGS) -c $< $@

%.o: %.cpp
	$(CC) $(CXXFLAGS) -c $< $@

%.o: %.S
	$(CC) $(ASMFLAGS) -c $< -o $@

# compile to asm
%.s: %.c
	$(CC) -S $(CFLAGS) $< -o $@

%.s: %.cc
	$(CC) -S $(CXXFLAGS) $< -o $@

%.s: %.cpp
	$(CC) -S $(CXXFLAGS) $< -o $@

# hex file from ELF output
%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O $(HEX_FMT) $< $@

%.ee.hex: %.elf
	$(OBJCOPY) -j eeprom --change-section-lma .eeprom=0 -O $(HEX_FMT) $< $@

# clean target
clean:
	$(RM) $(TRG) $(TRG).map $(DUMPTRG) $(OBJS) $(LST) $(GENASMFILES) $(HEXTRG)
