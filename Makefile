ATSHOMEQ=$(PATSHOME)
export PATSRELOCROOT=$(HOME)/ATS
ATSCC=$(ATSHOMEQ)/bin/patscc
ATSOPT=$(ATSHOMEQ)/bin/patsopt
ATSCCFLAGS=-DATS_MEMALLOC_LIBC -D_DEFAULT_SOURCE -g -IATS $(PATSRELOCROOT)
LIBS=
ifdef ATSLIB
	LIBS := -L $(PATSHOME)/ccomp/atslib/lib -latslib
endif
ifdef PTHREAD
	LIBS := -lpthread
endif
APP     = main
EXEDIR  = target
TESTDIR = test
LIBDIR  = lib
LIB     = libatsresult.so
ARCHIVE = libatsresult.a
SRCDIR  = src
OBJDIR  = .build
vpath %.dats src
vpath %.dats src/DATS
vpath %.sats src/SATS
dir_guard=@mkdir -p $(@D)
SRCS    := $(shell find $(SRCDIR) -name '*.dats' -type f -exec basename {} \;)
OBJS    := $(patsubst %.dats,$(OBJDIR)/%.o,$(SRCS))
.PHONY: clean setup
all: lib archive
lib: $(LIBDIR)/$(LIB)
archive: $(LIBDIR)/$(ARCHIVE)
$(LIBDIR)/$(LIB): $(OBJS) 
	$(dir_guard)
	$(ATSCC) $(ATSCCFLAGS) -shared -o $@ $(OBJS) $(LIBS)
$(LIBDIR)/$(ARCHIVE): $(OBJS)
	$(dir_guard)
	ar -cvq $@ $(OBJS)
.SECONDEXPANSION:
$(OBJDIR)/%.o: %.dats $$(wildcard src/SATS/$$*.sats)
	$(dir_guard)
	$(ATSCC) $(ATSCCFLAGS) -fpic -c $< -o $(OBJDIR)/$(@F) -cleanaft
RMF=rm -f
clean: 
	$(RMF) $(EXEDIR)/$(APP)
	$(RMF) $(LIBDIR)/$(LIB)
	$(RMF) $(LIBDIR)/$(ARCHIVE)
	$(RMF) $(OBJS)
	$(RMF) main
run: $(EXEDIR)/$(APP) test
	./$(EXEDIR)/$(APP)
test: $(EXEDIR)/$(APP)
$(EXEDIR)/%: $(TESTDIR)/%.dats $(LIBDIR)/$(ARCHIVE)
	$(dir_guard)
	PATSRELOCROOT=$(PWD) $(ATSCC) $(ATSCCFLAGS) -o $@ $< -cleanaft $(LIBDIR)/$(ARCHIVE)
	$(EXEDIR)/$(APP)
.SILENT: run
