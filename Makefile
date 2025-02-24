# Makefile for A-little-bit-of-Assembler

AS = nasm
ASFLAGS = -f elf64
SRC = src/main.asm
OBJ = $(SRC:.asm=.o)
TARGET = program

all: $(TARGET)

$(TARGET): $(OBJ)
	ld -o $@ $^

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)

.PHONY: all clean