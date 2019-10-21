filename=memoire
.PHONY: clean all pvc bibtex pdf read fast final draft

SHELL=/bin/bash

MK = latexmk
PDFLTX = pdflatex -shell-escape
INTMOD = -interaction=batchmode 
MKFLAGS = -pdf -pdflatex="$(PDFLTX) $(INTMOD)"
DRFTFLGS = -pdf -pdflatex="$(PDFLTX) $(INTMOD) -draftmode %O %S && touch %D"
EBMK = tex4ebook
EBFLAGS = -f epub3
EBDRAFT = -m draft
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

ebook: epub_latex_draft bibtex epub_latex

epub_latex:
	$(EBMK) $(EBFLAGS) $(filename).tex "mathml"

epub_latex_draft:
	$(EBMK) $(EBFLAGS) $(EBDRAFT) $(filename).tex "mathml"


clean:
	$(MK) -CA
	-$(RM) -f *.pyg *.bbl *.brf *.fls *~ *.bak *.bibliography
	-$(RM) -rf _minted-memoire
	-$(RM) -f ${filename}.xmpdata
	-$(RM) -f pdfa.xmpi
	-$(RM) -f content.opf *.xhtml ${filename}.{4ct,4tc,css,epub,idv,lg,ncx,out.ps,tmp,xref} Figures/*-.png
	-$(RM) -rf memoire-epub3/

read:
	evince ${filename}.pdf 
	
