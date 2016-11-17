filename=memoire
.PHONY: clean all pvc bibtex pdf read fast final draft

MK = latexmk
PDFLTX = pdflatex -shell-escape
INTMOD = -interaction=batchmode 
MKFLAGS = -pdf -pdflatex="$(PDFLTX) $(INTMOD)"
DRFTFLGS = -pdf -pdflatex="$(PDFLTX) $(INTMOD) -draftmode %O %S && touch %D"
RM = rm


all: draft final # Compiles with no PDF, then build it
	$(MK) $(DRFTFLGS) ${filename} # Just so latexmk says 'up-to-dati

slow:
	$(MK) $(MKFLAGS) ${filename}

draft:
	$(MK) $(DRFTFLGS) ${filename}

final:
	$(PDFLTX) $(INTMOD) ${filename}

pvc: 
	$(MK) -pvc $(MKFLAGS) ${filename}

bibtex:
	bibtex ${filename}

pdf:
	$(PDFLTX) ${filename}

clean:
	$(MK) -CA
	-$(RM) -f *.pyg *.bbl *.brf *.fls *~ *.bak *.bibliography
	-$(RM) -rf _minted-memoire
	-$(RM) -f ${filename}.xmpdata
	-$(RM) -f pdfa.xmpi

read:
	evince ${filename}.pdf
	
