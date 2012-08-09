SLIDES=git_talk

default: slides scriptum

slides: markdown-slides

scriptum: markdown-scriptum

markdown-slides:
	landslide $(SLIDES).md -d $(SLIDES).html

markdown-scriptum:
	bash make_scriptum.sh
