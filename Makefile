TARGET := orbit-beat
BUILD := build
SOURCES := source
DATA := assets
INCLUDES :=

ARCH := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CFLAGS := -g -Wall -O2 -mword-relocations -ffunction-sections $(ARCH)
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions -std=gnu++17
LDFLAGS := -specs=3dsx.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)
LIBS := -lctru

ifneq ($(BUILD),$(notdir $(CURDIR)))
export OUTPUT := $(CURDIR)/$(TARGET)
export TOPDIR := $(CURDIR)
export VPATH := $(foreach dir,$(SOURCES),$(CURDIR)/$(dir)) $(foreach dir,$(DATA),$(CURDIR)/$(dir))
CFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
SFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))
BINFILES := $(foreach dir,$(DATA),$(notdir $(wildcard $(dir)/*.*)))
export LD := $(CXX)
export CC := $(CC)
export CXX := $(CXX)
export CFLAGS := $(CFLAGS) $(INCLUDE)
export CXXFLAGS := $(CXXFLAGS) $(INCLUDE)
export LDFLAGS := $(LDFLAGS)
export LIBS := $(LIBS)
export OFILES_BIN := $(addsuffix .o,$(BINFILES))
export OFILES_SRC := $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)
export OFILES := $(OFILES_BIN) $(OFILES_SRC)
export HFILES := $(foreach dir,$(INCLUDES),$(wildcard $(dir)/*.h))
export INCLUDE := $(foreach dir,$(INCLUDES),-I$(CURDIR)/$(dir)) \
                  $(foreach dir,$(LIBDIRS),-I$(LIBDIRS)/include) \
                  -I$(CURDIR)/$(BUILD)
.PHONY: all clean
all: $(BUILD)

$(BUILD):
	@mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(TOPDIR)/Makefile

clean:
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(TOPDIR)/Makefile clean
else
.PHONY: all
all: $(OUTPUT).3dsx

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(ASFLAGS) -c $< -o $@

$(OUTPUT).3dsx: $(OUTPUT).elf
	3dsxtool $< $@

$(OUTPUT).elf: $(OFILES)
	$(CXX) $(LDFLAGS) $^ $(LIBS) -o $@

clean:
	@rm -f $(OFILES) $(OUTPUT).elf $(OUTPUT).3dsx
endif

-include $(DEPSDIR)/*.d
