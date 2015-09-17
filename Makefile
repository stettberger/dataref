all: dataref.pdf

dataref.pdf: dataref.dtx dataref.sty
	latexmk -pdf dataref.dtx

dataref-luatex.pdf: dataref.dtx dataref.sty
	if [ -e dataref.pdf ]; then mv -f dataref.pdf dataref-tmp.pdf; fi
	lualatex dataref.dtx
	lualatex dataref.dtx
	lualatex dataref.dtx
	mv dataref.pdf $@
	if [ -e dataref-tmp.pdf ]; then \
		mv -f dataref-tmp.pdf dataref.pdf; \
	fi


dataref.sty: dataref.ins dataref.dtx
	tex dataref.ins


dataref.zip: dataref.dtx dataref.ins dataref.pdf README.md
	mkdir dataref
	cp $^ dataref
	mv dataref/README.md dataref/README
	zip -r dataref.zip dataref
	rm -rf dataref
