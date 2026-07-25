#!/usr/bin/env bash
OUTPUT_DIR=~/.local/share/applications

mapfile -t files < <(find . -maxdepth 1 -type f)
for file in "${files[@]}"; do
    if [[ "$file" = *.desktop ]]; then
        #        readlink gets absolute directory. This fixes ./
        ln -s "$(readlink -f "$file")" "$OUTPUT_DIR"
    fi
done
