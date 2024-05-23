# {"Foreign State of Chargeability or Place of Birth":"Zimbabwe","Visa ClassIssuances":"E22\n1","":""}
for file in immigrant_data/2018-02-01.jsonl immigrant_data/2018-11-01.jsonl immigrant_data/2019-02-01.jsonl
    jq -c '. as $in |
      {
        "Foreign State of Chargeability or Place of Birth": .["Foreign State of Chargeability or Place of Birth"],
        "Visa Class": ($in | .["Visa ClassIssuances"] | split("\n") | .[0]),
        "Issuances": ($in | .["Visa ClassIssuances"] | split("\n") | .[1])
      }
    ' $file | sponge $file
end
