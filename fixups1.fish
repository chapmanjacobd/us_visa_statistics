sed -i "/Grand Total/Id" immigrant_data/*

# {"Foreign State of Chargeability or Place of BirthVisa Class":"Afghanistan\nCR1","":"","Issuances":"11"}
for file in immigrant_data/2017-08-01.jsonl immigrant_data/2018-08-01.jsonl immigrant_data/2019-05-01.jsonl
    jq -c '. as $in |
      {
        "Foreign State of Chargeability or Place of Birth": ($in | .["Foreign State of Chargeability or Place of BirthVisa Class"] | split("\n") | .[0]),
        "Visa Class": ($in | .["Foreign State of Chargeability or Place of BirthVisa Class"] | split("\n") | .[1]),
        "Issuances": .["Issuances"]
      }
    ' $file | sponge $file
end
