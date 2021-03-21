#!/bin/sh
pandoc --output notes.html --gladtex notes.md --standalone --filter ./gladtex.sh
