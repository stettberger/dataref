all: dataref.pdf

dataref.pdf: dataref.dtx dataref.sty
	latexmk -pdf dataref.dtx

dataref.sty: dataref.ins dataref.dtx
	tex dataref.ins


dataref.zip: dataref.dtx dataref.ins dataref.pdf README.md
	mkdir dataref
	cp $^ dataref
	mv dataref/README.md dataref/README
	zip -r dataref.zip dataref
	rm -rf dataref
