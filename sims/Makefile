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
sij.Rout: sij.R units.rda

sij.incPlot.Rout: incPlot.R sij.rds
	$(pipeR)

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

-include makestuff/git.mk
-include makestuff/visual.mk
