SLIDES=git_talk

default: rst

rst:
	landslide $(SLIDES).rst -d $(SLIDES).html
