filename=memoire
.PHONY: clean all pvc bibtex pdf read fast final draft

MK = latexmk
PDFLTX = pdflatex -interaction=nonstopmode -shell-escape
MKFLAGS = -pdf -pdflatex="$(PDFLTX)"
DRFTFLGS = -pdf -pdflatex="$(PDFLTX) -draftmode %O %S && touch %D"
FNLFLAG = $(MKFLAGS) -g
RM = rm


all: draft final

slow:
	$(MK) $(MKFLAGS) ${filename}

draft:
	$(MK) $(DRFTFLGS) ${filename}

final:
	$(MK) $(FNLFLAG) ${filename}

pvc: 
	$(MK) -pvc $(MKFLAGS) ${filename}

bibtex:
	bibtex ${filename}

pdf:
	pdflatex -shell-escape ${filename}

clean:
	$(MK) -CA
	-$(RM) -f *.pyg *.bbl *.brf *.fls *~ *.bak
	-$(RM) -rf _minted-memoire

read:
	evince ${filename}.pdf
	
