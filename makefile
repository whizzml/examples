TEST_SCRIPTS := $(shell find . -type f -name test.sh)
TEST_DIRS := $(foreach f, $(TEST_SCRIPTS), $(dir $(f)))
PKG ?= .
BUILD_DIR := $(PKG)/.bigmler_build
VERBOSITY ?= 0

help:
	@echo "make compile - compile all packages"
	@echo "make clean - delete resources created by compile"
	@echo "make compile PKG=dirname - compile package in pkgname"
	@echo "make clean PKG=dirname - delete resources created in dirname"
	@echo "make tests - run all tests:"
	@for d in $(TEST_SCRIPTS); do echo "    $$d"; done

clean:
	bigmler delete --from-dir $(BUILD_DIR) --output-dir $(BUILD_DIR)
	rm -rf $(BUILD_DIR)
	rm -rf $(PKG)/.bigmler_*

compile: clean
	bigmler whizzml --package-dir $(PKG) --output-dir $(BUILD_DIR)

tests:
	@for t in $(TEST_DIRS); \
           do (cd $$t && VERBOSITY=$VERBOSITY ./test.sh); \
         done

distcheck:
	$(MAKE) compile
	$(MAKE) test
	$(MAKE) clean

.PHONY: clean compile test help distcheck
