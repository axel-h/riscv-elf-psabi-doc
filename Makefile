NAME = riscv-abi

DATE = $(shell date '+%B %d, %Y')
MONTHYEAR = $(shell date '+%B %Y')

OPTIONS := --trace \
           -a compress \
           -a date="$(DATE)" \
           -a monthyear="$(MONTHYEAR)" \
           -a pdf-style=resources/themes/risc-v_spec-pdf.yml \
           -a pdf-fontsdir=resources/fonts \
           -D build \
           --failure-level=ERROR \
           -v

.PHONY: all
all: build-docs

.PHONY: clean
clean:
	rm -f $(NAME).pdf

build-docs: $(NAME).pdf $(NAME).html

$(NAME).html: $(NAME).adoc $(wildcard *.adoc) resources/themes/risc-v_spec-pdf.yml
	asciidoctor $(OPTIONS) -o $@ $<

$(NAME).pdf: $(NAME).adoc $(wildcard *.adoc) resources/themes/risc-v_spec-pdf.yml
	asciidoctor-pdf $(OPTIONS) -o $@ $<

regen_vector_type_infos:
	python3 gen_vector_type_infos.py > vector_type_infos.adoc
