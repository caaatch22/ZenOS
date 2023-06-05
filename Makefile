K = kernel
I = include
L = lib
U = user

TOOLPREFIX = riscv64-unknown-elf-
CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gcc
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
GDB = $(TOOLPREFIX)gdb

PY = python3

OBJDIR = build
C_SRCS = $(wildcard $K/*.c) $(wildcard $K/*/*.c)
AS_SRCS = $(wildcard $K/*.S) $(wildcard $K/*/*.S)
C_OBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(C_SRCS))))
AS_OBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(AS_SRCS))))


OBJS = $(C_OBJS) $(AS_OBJS)

HEADER_DEP = $(addsuffix .d, $(basename $(C_OBJS)))

ifeq (,$(findstring link_app.o,$(OBJS)))
	AS_OBJS += $(OBJDIR)/$K/link_app.o
endif

CFLAGS = \
-mcmodel=medany \
-I $(I) \
-static \
-nostdlib \
-fno-pie -no-pie \
-Wno-builtin-declaration-mismatch \
# -T $(K)/kernel.lds

# log flags
LOG ?= error

ifeq ($(LOG), error)
CFLAGS += -D LOG_LEVEL_ERROR
else ifeq ($(LOG), warn)
CFLAGS += -D LOG_LEVEL_WARN
else ifeq ($(LOG), info)
CFLAGS += -D LOG_LEVEL_INFO
else ifeq ($(LOG), debug)
CFLAGS += -D LOG_LEVEL_DEBUG
else ifeq ($(LOG), trace)
CFLAGS += -D LOG_LEVEL_TRACE
endif


LDFLAGS = -z max-page-size=4096

$(AS_OBJS): $(OBJDIR)/$K/%.o : $K/%.S
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

$(C_OBJS): $(OBJDIR)/$K/%.o : $K/%.c  $(OBJDIR)/$K/%.d
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

INCLUDEFLAGS = -I$(I)

$(HEADER_DEP): $(OBJDIR)/$K/%.d : $K/%.c
	@mkdir -p $(@D)
	@set -e; rm -f $@; $(CC) -MM $< $(INCLUDEFLAGS) > $@.$$$$; \
        sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
        rm -f $@.$$$$

kernel/link_app.o: kernel/link_app.S
kernel/link_app.S: scripts/pack.py
	@$(PY) scripts/pack.py
kernel/kernel_app.ld: scripts/kernelld.py
	@$(PY) scripts/kernelld.py

generate_link: kernel/kernel_app.ld kernel/link_app.S

build_kernel: generate_link build_os

build_os: $(OBJS)
	$(LD) $(LDFLAGS) -T kernel/kernel_app.ld -o $(OBJDIR)/os $(OBJS)
	$(OBJDUMP) -S $(OBJDIR)/os > $(OBJDIR)/os.asm
	$(OBJDUMP) -t $(OBJDIR)/os | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(OBJDIR)/os.sym
	@echo 'Build kernel done'

all: $(OBJDIR)
	$(CC) $(CFLAGS) $(C_SRCS) $(AS_SRCS) -o ./$(OBJDIR)/kernel

qemu: build_kernel
	qemu-system-riscv64 \
		-machine virt \
		-nographic \
		-bios default \
		-m 128M \
		-kernel ./build/os

$(OBJDIR):
	@mkdir -p $(OBJDIR)

clean:
	rm -rf $(OBJDIR) nfs/fs kernel/kernel_app.ld kernel/link_app.S

