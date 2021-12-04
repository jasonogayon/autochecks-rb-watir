ifeq ($(OS), Windows_NT)
    OSTYPE := Windows
else
    OSTYPE := $(shell sh -c 'uname -s 2>/dev/null || echo not')
endif

ORIG_PREFIX:= @
NEW_PREFIX:= -t @

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "    ui tags='[tags]'          Run a test, given cucumber tags"
	@echo ""


ui:
	@if [ -z $(env) ]; then \
		cucumber DEFAULT=$(defaults) $(subst $(ORIG_PREFIX),$(NEW_PREFIX),$(tags)); \
	else \
		cucumber $(subst $(env),-p $(env),$(env)) DEFAULT=$(defaults) $(subst $(ORIG_PREFIX),$(NEW_PREFIX),$(tags)); \
	fi

h:
	@if [ -z $(env) ]; then \
		cucumber BROWSER=headless DEFAULT=$(defaults) $(subst $(ORIG_PREFIX),$(NEW_PREFIX),$(tags)); \
	else \
		cucumber BROWSER=headless $(subst $(env),-p $(env),$(env)) DEFAULT=$(defaults) $(subst $(ORIG_PREFIX),$(NEW_PREFIX),$(tags)); \
	fi

.PHONY: clean init