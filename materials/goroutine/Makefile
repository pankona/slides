
OUTDIR = $(CURDIR)/_book

all:
	cd $(CURDIR)/src && \
	gitbook build && \
	rm -r $(OUTDIR)
	mv $(CURDIR)/src/_book $(OUTDIR)
