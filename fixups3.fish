jq -c '. + {date: input_filename | split("/")[-1] | rtrimstr(".jsonl")}' immigrant_data/*.jsonl |
    lb json-keys-rename --country 'place of birth' --visa-type 'visa class' --count issuances --date date |
    jsonl2csv.py > immigrant_data.csv
