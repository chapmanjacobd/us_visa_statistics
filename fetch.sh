#!/bin/bash

lb links https://travel.state.gov/content/travel/en/legal/visa-law0/visa-statistics/immigrant-visa-statistics/monthly-immigrant-visa-issuances.html --text-include 'Issuances by FSC' --path-include .pdf | while read -r url;
do
    date=$(lb dates "$url")
    file="data/${date}.jsonl"

    if [ ! -f "$file" ]; then
        echo "Saving $file"
        echo lb markdown-tables "$url" --start-row 1 --concat --to-json > "$file"
    fi
done
