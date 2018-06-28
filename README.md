# Template-Memoire
Un gabarit pour mémoires et thèses, en LaTeX et en français.

## Fonctionnalités
- Options ajustables regroupées dans le préambule
	- Supporte la génération d'un fichier **PDF/A-1b** (ne pas utiliser pour le dépôt initial)
	- Version électronique/imprimée
- Gestion des métadonnées pour la page titre et le PDF
- *makefile* utilisant latexmk pour une compilation optimisée et/ou en temps réel


## Compilation
### makefile
On suggère d'utiser le makefile fourni, qui utilise latexmk et le mode "draft" pour minimiser les étapes de compilation et donc minimiser le temps de compilation.
- Compilation complète: `make all`
- Compilation en 'temps réel' : `make pvc` 
- Effacer tout les fichiers générés lors de la compilation: `make clean`

L'option *pvc* permet de compiler automatiquement à chaque modification (sauvegardée) de fichiers tex/bib/image en utilisant le moins d'étapes possibles. Si le lecteur PDF le supporte, le preview se mettra à jour lui-même.

### Manuelle
On suggère la procédure suivante pour compiler manuellement, pour sauver du temps:
``` bash
pdflatex -interaction=batchmode -draftmode memoire.tex
pdflatex -interaction=batchmode -draftmode memoire.tex
bibtex memoire
pdflatex memoire.tex
```


## Bug UTF8/PDFx et résolution (TeXLive 2016)

Le fichier pdfx.sty de TeXLive 2016 contient une erreur le rendant incompatible avec UTF8. Pour le résoudre, choisir une option parmi:
1. Patcher le fichier directement:
	1. Copier le fichier `/usr/local/texlive/2016/texmf-dist/tex/latex/pdfx/pdfx.sty` (ou l'équivalent pour windows/OSX) dans le dossier du mémoire. 
    2. À la ligne 1398, changer `\ifcat^^c0\active \pdf@activecharstrue\fi` pour `\ifcat\noexpand^^c0\noexpand~\pdf@activecharstrue\fi`
2. (avec un inconvénient) Changer l'ordre d'importation de inputenc/pdfx
	1. Commenter la ligne `\usepackage[utf8]{inputenc}` de `entete.sty`
	2. Insérer la ligne `\usepackage[utf8]{inputenc}` juste avant celle `\usepackage{filecontents}` dans `switchboard.tex`
	3. Il ne faut alors pas utiliser de caractère spécial dans les métadonnées de `memoire.tex` (`é` devient `\'e` etc.)
