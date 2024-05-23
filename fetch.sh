#!/bin/bash

for url in $(lb links https://travel.state.gov/content/travel/en/legal/visa-law0/visa-statistics/immigrant-visa-statistics/monthly-immigrant-visa-issuances.html --text-include 'Issuances by FSC' --path-include .pdf);
do
    date=$(lb dates "$url")
    file="data/${date}.jsonl"

    if [ ! -f "$file" ]; then
        echo "Saving $file"
        lb markdown-tables "$url" --start-row 1 --concat --to-json > "$file"
    fi
done
