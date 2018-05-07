
OUTDIR = $(CURDIR)/_book

all:
	cd $(CURDIR)/src && \
	gitbook build && \
	rm -rf $(OUTDIR)
	mv $(CURDIR)/src/_book $(OUTDIR)
