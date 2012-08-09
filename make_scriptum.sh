#!/bin/sh

cat git_talk_script_frame.html |\
    sed "s/{{ content }}/$(markdown_py -o html5 git_talk_script.md | 
        sed -e 's/\//\\\//g' -e 's/$/\\n/g' | tr -d "\n")/ " \
    > git_talk_script.html
