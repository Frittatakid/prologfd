#! /bin/bash

# Script de generació de presentació HTML

pandoc -t html5 \
	--template=jstemplate.html \
	--standalone \
	--section-divs \
	--variable theme="black" \
	--variable transition=linear \
	slides.md -o slides.html
