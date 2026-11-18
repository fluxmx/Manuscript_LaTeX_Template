LATEXMK ?= latexmk
FLAGS = -pdf -interaction=nonstopmode -halt-on-error
.PHONY: all pdf clean
all: pdf
pdf:
	$(LATEXMK) $(FLAGS) main.tex
clean:
	$(LATEXMK) -c main.tex
