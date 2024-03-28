Sources += $(wildcard *.pl)
Sources += download.bib download.ris

download.bib: 
	cat ~/Downloads/*.bib >> $@
	$(RM) ~/Downloads/*.bib

## MESSED up
download.ris.update: download.ris
	cat ~/Downloads/*.ris ~/Downloads/*.nbib >> $<
	$(RM) ~/Downloads/*.ris ~/Downloads/*.nbib

download.ris.pgr: download.ris ris.pl
	$(PUSH)

## Stop doing this craziness for a while 2024 Mar 22 (Fri)
download.ris.bib: download.ris.pgr bib.pl 
	$(PUSH)

