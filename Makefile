## This is immuneExplore, based on the PHAC 2023-11 contract

current: target
-include target.mk
Ignore = target.mk

-include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += abib.md manual.bib LICENSE

Sources += $(wildcard *.tex)

outline.pdf: outline.tex

######################################################################

## report.pdf: report.tex doc.tex

######################################################################

Sources += drop.md
## drop.filemerge: drop.md

######################################################################

Ignore += boost.33.pdf
boost.33.pdf:
	wget -O $@ https://dushoff.github.io/SIR_model_family/$@

Ignore += drop/report_pix.Rout.pdf
## Rule does not work (need to set up pages with Daniel's permission)
report_pix.Rout.pdf:
	wget -O $@ https://github.com/parksw3/immune-boosting/blob/master/outputs/report_pix.Rout.pdf

drop/report_pix.Rout.pdf:
	cp ../status/outputs/$(notdir $@) $@

######################################################################

Sources += download.mk

Sources += manual.bib

subdirs += sims

alldirs += $(subdirs)

Ignore += $(alldirs)

hotdirs += sims

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/01.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk
-include makestuff/ldrop.mk

## -include makestuff/pipeR.mk
-include makestuff/texi.mk
-include makestuff/hotcold.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/webpix.mk
