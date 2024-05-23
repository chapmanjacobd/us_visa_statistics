cat immigrant_data/*.jsonl |
    lb json-keys-rename --country 'place of birth' --visa-type 'visa class' --count 'issuances' |
    jsonl2csv.py > immigrant_data.csv
