#!/bin/sh
pandoc --output notes.html --gladtex notes.md --standalone --filter ./gladtex.sh
pandoc --output notes.pdf --pdf-engine xelatex notes.md --standalone

