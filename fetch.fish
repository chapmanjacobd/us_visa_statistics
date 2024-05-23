#!/bin/fish

for url in (lb links https://travel.state.gov/content/travel/en/legal/visa-law0/visa-statistics/immigrant-visa-statistics/monthly-immigrant-visa-issuances.html --text-include 'Issuances by FSC' --path-include .pdf)
    set date (lb dates "$url")
    set file "data/$date.jsonl"

    if not test -e "$file"
        echo "Saving $file"
        echo "$url"
        lb markdown-tables "$url" --start-row 1 --concat --to-json > "$file"
    end
end
