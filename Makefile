all: dataref.pdf

dataref.pdf: dataref.sty dataref.tex
	latexmk -pdf dataref.tex || touch dataref.tex

dataref-luatex.pdf: dataref.tex dataref.sty
	if [ -e dataref.pdf ]; then mv -f dataref.pdf dataref-tmp.pdf; fi
	lualatex dataref.tex
	lualatex dataref.tex
	lualatex dataref.tex
	mv dataref.pdf $@
	if [ -e dataref-tmp.pdf ]; then \
		mv -f dataref-tmp.pdf dataref.pdf; \
	fi



dataref.zip: dataref.sty dataref.tex dataref.pdf README.md
	mkdir -p dataref dataref/tex dataref/doc
	cp dataref.sty dataref/tex
	cp dataref.tex dataref/doc/dataref-doc.tex
	cp dataref.pdf dataref/doc/dataref-doc.pdf
	cp README.md   dataref/README.md
	zip -r dataref.zip dataref
	rm -rf dataref

test: testsuite.tex dataref.sty
	pdflatex testsuite.tex
	pdflatex testsuite.tex
