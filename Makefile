SLIDES=git_talk

default: markdown

markdown:
	landslide $(SLIDES).md -d $(SLIDES).html
