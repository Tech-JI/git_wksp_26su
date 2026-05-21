# Makefile for building Git workshop PDFs from markdown files

# Variables
PANDOC = pandoc
BEAMER_OPTS = --pdf-engine=xelatex -t beamer -F mermaid-filter --slide-level=2 --toc-depth=1 --listing
PDF_OPTS = --pdf-engine=xelatex --highlight-style=tango -V colorlinks=true -V linkcolor=blue -V urlcolor=blue
LATEX_OPTS = --pdf-engine=lualatex -V mainfont="Segoe UI" -V mainfontfallback="Segoe UI Emoji:mode=harf"

# Source files
MD_FILES = $(wildcard *.md)
BEAMER_FILES = part2.md
PDF_FILES = $(filter-out $(BEAMER_FILES), $(MD_FILES))
PDF_TARGETS = $(PDF_FILES:.md=.pdf)
BEAMER_TARGETS = $(BEAMER_FILES:.md=.pdf)

# Default target - only builds part2.pdf
part2.pdf: part2.md
	@echo "Building part2.pdf (beamer presentation)..."
	@$(PANDOC) $(BEAMER_OPTS) -o $@ $<
	@echo "Build success."

# Build all PDFs (including README.md)
all: $(BEAMER_TARGETS) $(PDF_TARGETS)
	@echo "All PDFs built successfully."

# Pattern rule for beamer presentations (like part2.md)
%.pdf: %.md
	@echo "Building $@ from $< (beamer format)..."
	@$(PANDOC) $(BEAMER_OPTS) -o $@ $<

# Pattern rule for regular PDFs (other .md files)
%.pdf: %.md
	@echo "Building $@ from $< (regular PDF format)..."
	@$(PANDOC) $(PDF_OPTS) -o $@ $<

# Clean up generated files
clean:
	@rm -f *.pdf
	@echo "Cleaned up all PDF files."

# Phony targets
.PHONY: all clean help

# Help target
help:
	@echo "Available targets:"
	@echo "  (default) - Build only part2.pdf"
	@echo "  all       - Build all PDF files (part2.pdf and README.pdf)"
	@echo "  clean     - Remove all generated PDF files"
	@echo "  help      - Show this help message"
	@echo ""
	@echo "Individual files can be built with:"
	@echo "  make part2.pdf"
	@echo "  make README.pdf"