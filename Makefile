all: dataref.pdf

dataref.pdf: dataref.dtx dataref.sty
	latexmk -pdf dataref.dtx

dataref.sty: dataref.ins dataref.dtx
	tex dataref.ins
