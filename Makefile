CC := clang
SRCDIR := src
BINDIR := bin
BLDDIR := build

ALL_SRCF := $(shell find $(SRCDIR) -type f -name *.c)
ALL_OBJF := $(patsubst $(SRCDIR)/%,$(BLDDIR)/%,$(ALL_SRCF:.c=.o))
#MAINF := # use nm to find file with main and include it
#FUNCF := $(filter-out $(MAIN_FILES), $(ALL_OBJF))

EXEC := c_koans

CFLAGS := $(shell cat compile_flags.txt)

.PHONY: setup all clean

all: setup $(EXEC)

debug: CFLAGS += $(DFLAGS)
debug: all

setup:
	@mkdir -p bin build

$(EXEC): $(ALL_OBJF)
	$(CC) $(CFLAGS) $(INC) $^ -o $(BINDIR)/$@ $(CRITERION)

$(BLDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) $(INC) $< -c -o $@

clean:
	$(RM) -r $(BLDDIR) $(BINDIR)
