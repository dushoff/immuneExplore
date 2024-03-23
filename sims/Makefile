## This is immuneExplore sims subdirectory

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += $(wildcard *.R)

autopipeR = defined

## Proof of concept
units.Rout: units.R
sir.Rout: sir.R units.rda

## Two-strain model from Bologna
## Needs to be refactored carefully!
## Should be all one file with different parameters fed in.
sij.Rout: sij.R units.rda
noboost.Rout: noboost.R units.rda

noboost.incPlot.Rout: incPlot.R noboost.rds units.rda
	$(pipeR)

sij.incPlot.Rout: incPlot.R sij.rds units.rda
	$(pipeR)

combined.Rout: combined.R noboost.rds sij.rds units.rda
	$(pipeR)

## Redundant copy because of sync idiocy
newcomb.Rout: newcomb.R noboost.rds sij.rds units.rda
	$(pipeR)

######################################################################

Ignore += midReport.pan.pdf
## midReport.pan.pdf: midReport.md

Sources += sij.md midReport.md

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
## -include makestuff/ldrop.mk

-include makestuff/pipeR.mk
## -include makestuff/texi.mk
-include makestuff/pandoc.mk

-include makestuff/git.mk
-include makestuff/visual.mk
