AS_FLAGS =-f elf32 -o
LD_FLAGS =-m elf_i386 -o
CC_FLAGS =-m32 
OBJECTS = init 
AS=nasm


.SILENT:

all: build

build:
	@for dir in $(OBJECTS); do \
		make -C $$dir CC_FLAGS=$(CC_FLAGS); \
	done

clean:
	@for dir in $(OBJECTS); do \
		make -C $$dir clean; \
	done


# Read source object files from a file
SRCOBJ = $(shell cat "$(DIR)/obj")

codebuild: 
	@for OBJ in $(SRCOBJ); do \
		PRE=$$(./parse.py $$OBJ 0); \
		INP=$$(./parse.py $$OBJ 1); \
		OUTP=$$(./parse.py $$OBJ 2); \
		if [ "$$PRE" = "AS" ]; then \
			$(AS) $(AS_FLAGS) "$(DIR)/$$OUTP" "$(DIR)/$$INP"; \
		fi; \
		if [ "$$PRE" = "CC" ]; then \
			$(CC) $(CC_FLAGS) -c -o "$(DIR)/$$OUTP" "$(DIR)/$$INP"; \
		fi; \
	done
	
	$(LD) $(LD_FLAGS) -T $(DIR)/link.ld -o $(DIR)/$(shell cat $(DIR)/target) $(DIR)/*.o
	
 

cleanbuild:
	@for OBJ in $(SRCOBJ); do \
		rm -fr $(DIR)/*.o; \
	done