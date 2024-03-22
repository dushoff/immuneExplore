## This is immuneExplore, based on the PHAC 2023-11 contract

current: target
-include target.mk
Ignore = target.mk

-include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += abib.md manual.bib

Sources += $(wildcard *.tex)

outline.pdf: outline.tex

######################################################################

report.pdf: report.tex doc.tex

######################################################################

Sources += drop.md
## drop.filemerge: drop.md

######################################################################

Ignore += boost.33.pdf
boost.33.pdf:
	wget -O $@ https://dushoff.github.io/SIR_model_family/$@

######################################################################

Sources += download.mk

Sources += manual.bib

subdirs += sims

Ignore += $(subdirs)

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk
-include makestuff/ldrop.mk

## -include makestuff/pipeR.mk
-include makestuff/texi.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/webpix.mk
