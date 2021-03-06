.PHONY: all clean odt pdf

PANDOC_OPTS := --filter pandoc-citeproc

SUBMISSION_NAME := Cope_Baker_Library_Carpentry

all: odt pdf zip

odt: abstract.odt abstract-anon.odt

pdf: abstract.pdf paper.pdf

zip: ${SUBMISSION_NAME}.zip

abstract.odt: abstract.md abstract-template.fodt
	pandoc -f markdown -t odt --template=abstract-template.fodt -o abstract.odt abstract.md

abstract-anon.odt: abstract.md abstract-template-anon.fodt
	pandoc -f markdown -t odt --template=abstract-template-anon.fodt -o abstract-anon.odt abstract.md

%.pdf: %.md idcc-template.tex references.bib
	pandoc -f markdown -t latex --template=idcc-template.tex ${PANDOC_OPTS} -o $@ $<

%.tex: %.md idcc-template.tex references.bib
	pandoc -f markdown -t latex --template=idcc-template.tex ${PANDOC_OPTS} -o $@ $<

${SUBMISSION_NAME}.zip: paper.tex paper.pdf
	zip $@ $?

clean:
	rm -f abstract.odt abstract-anon.odt abstract.pdf paper.pdf paper.tex ${SUBMISSION_NAME}.zip
