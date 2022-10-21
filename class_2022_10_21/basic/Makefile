all: paper.html paper.pdf

paper.html: paper.qmd fig1/fig.png fig2/fig.png
	quarto render paper.qmd

fig1/fig.png: fig1/fig.R
	Rscript fig1/fig.R

fig2/fig.png: fig2/fig.R
	Rscript fig2/fig.R

clean:
	rm -f fig1/fig.png
	rm -f fig2/fig.png
	rm -f paper.html
	
.PHONY: all clean

