SLIDES=git_talk

default: slides scriptum

slides: markdown-slides

scriptum: markdown-scriptum

markdown-slides:
	landslide $(SLIDES).md -d $(SLIDES).html

markdown-scriptum:
	markdown_py -f $(SLIDES)_script.html $(SLIDES)_script.md
