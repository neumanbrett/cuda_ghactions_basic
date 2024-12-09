# Compiler
NVCC = nvcc

# Target executable
TARGET = bin/hello_world

# Source files
SRCS = src/hello_world.cu

# Build
all: $(TARGET)

$(TARGET): $(SRCS)
	mkdir -p bin
	$(NVCC) -o $@ $^
	@echo "Success: $(TARGET)"

clean:
	rm -f $(TARGET)
	rmdir bin