PDFLATEX	:= pdflatex
PDFLATEXFLAGS	:= -interaction=nonstopmode -halt-on-error -file-line-error
# I'm using biblatex; I'm not sure what the difference between biblatex and bibtex is...
BIBTEX	:= biber

.PHONY: all
all: paper.pdf

# -draftmode for pdflatex, --no-pdf for xelatex
%.pdf: %.tex
	$(PDFLATEX) $(PDFLATEXFLAGS) --no-pdf $(basename $<)
	- $(BIBTEX) $(basename $@)
	$(PDFLATEX) $(PDFLATEXFLAGS) --no-pdf $(basename $<)
	$(PDFLATEX) $(PDFLATEXFLAGS) $(basename $<)

.PHONY: clean clean-all
clean:
	rm -f *.out *.log *.aux *.bbl *.bcf *.blg *.run.xml *.xdv paper.pdf *.toc

clean-all: clean
	rm -f *.pdf

.PHONY: container
container:
	docker build -t cs6110:latest .

.PHONY: run-container
run-container:
	docker run --rm -it cs6110:latest bash
