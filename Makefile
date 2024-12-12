# Compiler
NVCC = nvcc

# Target executable
TARGET = bin/hello_world

# Source files
SRCS = src/hello_world.cu

# Module load for Casper
MODULE_FILE = config/config.modules

# Build
all: $(TARGET)

$(TARGET): $(SRCS)
	mkdir -p bin
	. $(MODULE_FILE) && $(NVCC) -o $@ $^

clean:
	rm -f $(TARGET)
	rmdir bin