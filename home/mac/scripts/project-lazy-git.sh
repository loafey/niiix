#!/bin/bash

function ff () {
    (find ~/Git -type d -print 2>/dev/null) | while read dir; do
        if [ -d "$dir/.git" ]; then
            echo $dir
        fi
    done
}

lazygit -p "$(ff | fzf)"