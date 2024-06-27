# The root directory to start the search
ROOT_DIR := ./projects

# The command to find Makefiles in sub-directories
MAKEFILES := $(shell find $(ROOT_DIR) -name Makefile)

.PHONY: all src_only
all: $(MAKEFILES)
	@echo "Found the following Makefiles:"
	@echo "$(MAKEFILES)" | tr ' ' '\n'
	@for makefile in $(MAKEFILES); do \
		subdir=$$(dirname $$makefile); \
		echo "Running make in $$subdir"; \
		$(MAKE) -C $$subdir || exit 1; \
	done

src_only: $(MAKEFILES)
	@echo "Found the following Makefiles:"
	@echo "$(MAKEFILES)" | tr ' ' '\n'
	@for makefile in $(MAKEFILES); do \
		subdir=$$(dirname $$makefile); \
		echo "Running make in $$subdir"; \
		$(MAKE) -C $$subdir src_only || exit 1; \
	done