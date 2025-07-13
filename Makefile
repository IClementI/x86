.PHONY: asm/%

DIR := ''

asm/%:
	@if echo "$*" | grep -q /; then \
		DIR=$(word 1,$(subst /, ,$*)); \
		mkdir -p ./object/$$DIR; \
		mkdir -p ./bin/$$DIR; \
	fi
	
	@ if [ -f ./asm/$*.asm ]; then \
		echo "Compiling $*"; \
		nasm -f elf32 -g -F dwarf ./asm/$*.asm -o ./object/$*.o; \
		echo "Linking $*"; \
		ld -m elf_i386 ./object/$*.o -o ./bin/$*; \
		echo "End of compiling $*"; \
		echo "Running $*"; \
		./bin/$* \
	else \
		echo "Error: file $* not found"; \
		exit 0; \
	fi

# g means compiling with gcc 
g/%:
	@ if [ -f ./asm/$*.asm ]; then \
		echo "Compiling $*.asm"; \
		nasm -f elf32 -g -F dwarf ./asm/$*.asm -o ./object/$*.o; \
		gcc -g -m32 -no-pie ./object/$*.o -o ./bin/$*; \
		echo "End of compiling $*.asm"; \
		echo "Running $*.elf\n"; \
		./bin/$* \
	else \
		echo "Error: file $*.asm not found"; \
		exit 0; \
	fi

SOURCE_DIR := ./asm/big_project
CONTROLER_DIR := controler
ASM_SOURCES_FULL := $(wildcard $(SOURCE_DIR)/*.asm)
ASM_SOURCES := $(notdir $(ASM_SOURCES_FULL))
BASE_SOURCE := $(basename $(ASM_SOURCES))

ASM_SOURCES_CONTROLER_FULL := $(wildcard $(SOURCE_DIR)/$(CONTROLER_DIR)/*.asm)
ASM_SOURCES_CONTROLER := $(notdir $(ASM_SOURCES_CONTROLER_FULL))
ASM_SOURCES_CONTROLER_DIR := $(addprefix ./$(CONTROLER_DIR)/, $(ASM_SOURCES_CONTROLER))

ASM_FUSION_SOURCES := $(ASM_SOURCES) $(ASM_SOURCES_CONTROLER_DIR)

OBJECT_DIR := ./object/big_project/
OBJECT_SOURCES := $(patsubst %.asm, %.o, $(ASM_SOURCES))
OBJECT_SOURCES_CONTROLER := $(patsubst %.asm, %.o, $(ASM_SOURCES_CONTROLER_DIR))
OBJECT_SOURCES_CONTROLER_CLEANED := $(patsubst ./%,%,$(OBJECT_SOURCES_CONTROLER))

OBJECT_SOURCES_FULL := $(addprefix $(OBJECT_DIR), $(OBJECT_SOURCES))
OBJECT_SOURCES_FULL_CONTROLER := $(addprefix $(OBJECT_DIR), $(OBJECT_SOURCES_CONTROLER_CLEANED))

OBJECT_FUSION_SOURCES := $(OBJECT_SOURCES_FULL) $(OBJECT_SOURCES_FULL_CONTROLER)

OUTPUT_DIR := ./bin/big_project
OUTPUT := main

# First big project
all: input_parser
	
./object/big_project/%.o: ./asm/big_project/%.asm
	nasm -f elf32 -g -F dwarf $< -o $@

make_dir:
	mkdir -p $(OUTPUT_DIR)
	mkdir -p $(OBJECT_DIR)
	mkdir -p $(OBJECT_DIR)/controler/

input_parser: make_dir $(OBJECT_FUSION_SOURCES)
	@echo "COMPILING -----"
	ld -m elf_i386 $(OBJECT_FUSION_SOURCES) -o $(OUTPUT_DIR)/$(OUTPUT)
	@echo "RUNNING ------"
	@$(OUTPUT_DIR)/$(OUTPUT)

.PHONY: clean

clean:
	rm -rf ./object/*
	rm -rf ./bin/*

debug:
	@echo "DEBUGGING INFO ---------"
	@echo "ASM_SOURCES_FULL: " $(ASM_SOURCES_FULL)
	@echo "ASM_SOURCES: " $(ASM_SOURCES)
	@echo "BASE_SOURCE: " $(BASE_SOURCE)
	@echo "OBJECT_SOURCES: " $(OBJECT_SOURCES)
	@echo "OBJECT_SOURCES_FULL: " $(OBJECT_SOURCES_FULL)
	@echo "-------------------------"
	@echo "ASM_SOURCES_CONTROLER_FULL" $(ASM_SOURCES_CONTROLER_FULL)
	@echo "ASM_SOURCES_CONTROLER" $(ASM_SOURCES_CONTROLER)
	@echo "ASM_SOURCES_CONTROLER_DIR" $(ASM_SOURCES_CONTROLER_DIR)
	@echo "ASM_FUSION_SOURCES" $(ASM_FUSION_SOURCES)
	@echo "OBJECT_SOURCES_CONTROLER" $(OBJECT_SOURCES_CONTROLER)
	@echo "OBJECT_SOURCES_CONTROLER_CLEANED" $(OBJECT_SOURCES_CONTROLER_CLEANED)
	@echo "OBJECT_SOURCES_FULL_CONTROLER" $(OBJECT_SOURCES_FULL_CONTROLER)
	@echo "-------------------------"
	@echo "OUTPUT: " $(OUTPUT)
	@echo "END DEBUGGING INFO -----"
