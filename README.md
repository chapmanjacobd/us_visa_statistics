# us_visa_statistics

Monthly Immigrant and Nonimmigrant Visa Issuances Data extracted from multi-page PDF tables

Depending on what you are looking for the [Office of Immigration Statistics](https://www.dhs.gov/ohss/topics/immigration/yearbook) data might be more useful. However, this is still a good example of how to [parse PDF table data in an automated way](https://github.com/chapmanjacobd/us_visa_statistics/blob/main/.github/workflows/immigrant.yaml).

## Graphs

<details><summary>Code setup</summary>

```R
require(data.table)
require(ggplot2)

D = data.table::fread('immigrant_data.csv')
D = D[country!='Other']
D[country == 'Bahamas', country := 'Bahamas, The']
D[country == 'Bosnia-Herzegovina', country := 'Bosnia and Herzegovina']
D[country == 'Burkina-Faso', country := 'Burkina Faso']
D[country == 'China - Mainland born', country := 'China - mainland born']
D[country == 'China – mainland born', country := 'China - mainland born']
D[country == 'China-Mainland born', country := 'China - mainland born']
D[country == 'China', country := 'China - mainland born']
D[country == 'China-Taiwan born', country := 'China - Taiwan born']
D[country == 'Taiwan', country := 'China - Taiwan born']
D[country == 'Hong Kong S.A.R', country := 'Hong Kong S.A.R.']
D[country == 'Hong Kong-BNO', country := 'Hong Kong S.A.R.']
D[country == 'Cocos (Keeling) Islands', country := 'Cocos Islands']
D[country == 'Czec Republic', country := 'Czech Republic']
D[country == 'Eswatini', country := 'eSwatini']
D[country == 'Swaziland', country := 'eSwatini']
D[country == 'Eswatini*', country := 'eSwatini']
D[country == 'Kyrgystan', country := 'Kyrgyzstan']
D[country == 'North Korea', country := 'Korea, North']
D[country == 'South Korea', country := 'Korea, South']
D[country == 'Northern Ireland (DV only)', country := 'Great Britain and Northern Ireland']
D[country == 'Saint Maarten', country := 'Sint Maarten']

library(grDevices)

extract_nth_wraparound <- function(x, n) {
  index <- (seq_along(x) - 1) %% n + 1
  ordered_indices <- order(index)
  return(x[ordered_indices])
}

create_divergent_palette <- function(factor_levels, pal="Zissou 1", repeat_n=8) {
  num_levels <- length(factor_levels)
  palette <- hcl.colors(num_levels, pal)
  palette <- extract_nth_wraparound(palette, num_levels / repeat_n)
  color_mapping <- setNames(palette, factor_levels)

  return(color_mapping)
}

# require('scales')
# show_col(create_divergent_palette(type_factors, pal="Zissou 1", repeat_n=10))
```

</details>

### Quantity of visas issued by visa type over time

![Bar chart: Visa Type over Time, showing COVID-19 Pandemic visa issuance impact](./images/visa_type_bar.avif)

I think this shows COVID-19 Pandemic impact on visa issuance pretty well

```R
type_counts <- aggregate(count ~ visa_type, data = D, FUN = sum)
type_factors = type_counts$visa_type[order(type_counts$count, decreasing = TRUE)]
color_palette = create_divergent_palette(type_factors)
D$visa_type <- factor(D$visa_type, levels = type_factors)

ggplot(D) +
  aes(x = date, fill = visa_type, weight = count) + geom_bar() +
  scale_fill_manual(values = create_divergent_palette(type_factors, pal="Zissou 1", repeat_n=7))
```

### Visa Type over Time

![Tile chart: Visa Type over Time, showing deprecation of certain visa types](./images/visa_type_tile.avif)

I think most of these abrupt start and stops are actually due to differences in reporting after 2020. For example: DV1,DV2,DV3 become DV in later PDFs

```R
ggplot(D) +
  aes(x = date, y = visa_type) + geom_tile()
```

### Facets of visas issued over time by type

![Bar chart for each visa type](./images/visa_types.avif)

```R
p = ggplot(D[count > 1]) +
  aes(x = date, weight = count) + geom_bar(fill = "#000") +
  theme_minimal() + theme(strip.text.x = element_text(size = 5), axis.text.y = element_text(size = 5), axis.text.x = element_blank()) +
  facet_wrap(vars(visa_type), scales = "free_y")

ggsave(plot=p, filename = "images/visa_types.png", width = 4000, height = 2500, units='px')
```

### Facets of visas issued over time by Foreign Service Center (FSC)

![Bar chart for each country](./images/countries.avif)

I'm just guessing with that acronym--can't find it documented anywhere but Foreign Service Officer (FSO) is a pretty well-known acronym so FSOs must work inside of FSCs or something like that...

```R
p = ggplot(D[count > 1]) +
  aes(x = date, weight = count) + geom_bar(fill = "#000") +
  theme_minimal() + theme(strip.text.x = element_text(size = 5), axis.text.y = element_text(size = 5), axis.text.x = element_blank()) +
  facet_wrap(vars(country), scales = "free_y")

ggsave(plot=p, filename = "images/countries.png", width = 4000, height = 2500, units='px')
```

<!--
```R
ggplot(D[(country == "Hong Kong S.A.R." & visa_type == 'CR1')]) +
  aes(x = date, fill = visa_type, weight = count) + geom_bar()
``` -->

## Notes

If you are using this data you should be aware that there are some data quality issues. Some of those issues have been identified by others [here](https://github.com/TashiNyangmi/Visa/blob/main/data_cleaning/monthly_update.py).

[Visa Symbol key](https://travel.state.gov/content/dam/visas/Statistics/Immigrant-Statistics/MonthlyIVIssuances/Immigrant%20Visa%20Symbols.pdf)

> The Visa Office has changed its methodology for calculating visa data beginning with the Fiscal Year (FY) 2019 annual Report of the Visa Office and continuing with FY 2020 data, to reflect the greater access to application-level data attained during FY 2019. Our previous methodology was based on a count of workload actions, which were not linked by application. The new methodology more accurately reflects final outcomes from the visa application process during a specified reporting period.  The new methodology follows visa applications, including updates to their status (i.e., issued or refused), which could change as the fiscal year progresses, or result in slight changes in data for earlier years.  Therefore, beginning with FY 2020, individual monthly issuance reports should not be aggregated, as this will not provide an accurate issuance total for the fiscal year to date.  Instead, refer to our annual Report of the Visa Office for final full Fiscal Year statistics.
> While the new methodology is more accurate, it does not mean that our prior methodology was flawed.  The two are simply not comparable.  However, based on our analysis, the discrepancies between the methodologies are minor.  For example, the difference between reported issuances of NIVs and IVs in FY 2018 (legacy methodology) and those in FY 2019 (new methodology) is less than one percent worldwide.
> [U.S. Department of State](https://travel.state.gov/content/travel/en/legal/visa-law0/visa-statistics/immigrant-visa-statistics/monthly-immigrant-visa-issuances.html)

## immigrant_data.csv

### Shape

(153458, 4)

### Sample of rows

|        | country     | visa_type   |   count | date       |
|--------|-------------|-------------|---------|------------|
|      0 | Afghanistan | CR1         |      11 | 2017-03-01 |
|      1 | Afghanistan | DV1         |       2 | 2017-03-01 |
|      2 | Afghanistan | DV2         |       1 | 2017-03-01 |
| 153455 | Zimbabwe    | IR1         |       1 | 2024-03-01 |
| 153456 | Zimbabwe    | IR2         |       3 | 2024-03-01 |
| 153457 | Zimbabwe    | IR5         |       4 | 2024-03-01 |

### Summary statistics

|       |       count |
|-------|-------------|
| count | 153458      |
| mean  |     21.2988 |
| std   |     92.6385 |
| min   |      1      |
| 25%   |      1      |
| 50%   |      3      |
| 75%   |     11      |
| max   |   5009      |

### Pandas columns with 'converted' dtypes

| column    | original_dtype   | converted_dtype   |
|-----------|------------------|-------------------|
| country   | object           | string            |
| visa_type | object           | string            |
| count     | int64            | Int64             |
| date      | object           | string            |

### Numerical columns

#### Bins

|                      |   count |
|----------------------|---------|
| (-4.008, 835.667]    |  153121 |
| (835.667, 1670.333]  |     239 |
| (1670.333, 2505.0]   |      73 |
| (2505.0, 3339.667]   |      18 |
| (3339.667, 4174.333] |       5 |
| (4174.333, 5009.0]   |       2 |

### Categorical columns

#### common values of country column

|                                    |   Count |   Percentage |
|------------------------------------|---------|--------------|
| India                              |    2384 |     1.55352  |
| China - mainland born              |    2332 |     1.51963  |
| Philippines                        |    2191 |     1.42775  |
| Vietnam                            |    2114 |     1.37758  |
| Mexico                             |    2088 |     1.36063  |
| Korea, South                       |    2054 |     1.33848  |
| Pakistan                           |    1960 |     1.27722  |
| Brazil                             |    1885 |     1.22835  |
| Venezuela                          |    1874 |     1.22118  |
| Colombia                           |    1851 |     1.20619  |
| Nigeria                            |    1814 |     1.18208  |
| China - Taiwan born                |    1804 |     1.17557  |
| Ukraine                            |    1792 |     1.16775  |
| Russia                             |    1781 |     1.16058  |
| Jamaica                            |    1769 |     1.15276  |
| Egypt                              |    1694 |     1.10389  |
| Ecuador                            |    1683 |     1.09672  |
| Dominican Republic                 |    1651 |     1.07586  |
| El Salvador                        |    1649 |     1.07456  |
| Great Britain and Northern Ireland |    1640 |     1.0687   |
| Iran                               |    1605 |     1.04589  |
| Bangladesh                         |    1560 |     1.01656  |
| Peru                               |    1552 |     1.01135  |
| Ghana                              |    1541 |     1.00418  |
| Jordan                             |    1527 |     0.995061 |
| Honduras                           |    1519 |     0.989847 |
| Nepal                              |    1516 |     0.987892 |
| Guatemala                          |    1514 |     0.986589 |
| Haiti                              |    1496 |     0.97486  |
| Turkey                             |    1455 |     0.948142 |

#### common values of visa_type column

|     |   Count |   Percentage |
|-----|---------|--------------|
| IR1 |   12096 |      7.88229 |
| CR1 |   10912 |      7.11074 |
| IR5 |   10679 |      6.95891 |
| IR2 |   10381 |      6.76472 |
| SB1 |    4133 |      2.69325 |
| FX  |    3904 |      2.54402 |
| CR2 |    3892 |      2.5362  |
| DV1 |    3730 |      2.43063 |
| FX1 |    3675 |      2.39479 |
| F11 |    3519 |      2.29314 |
| FX2 |    3321 |      2.16411 |
| DV  |    3311 |      2.15759 |
| F41 |    3172 |      2.06702 |
| F1  |    3154 |      2.05529 |
| F4  |    3053 |      1.98947 |
| DV2 |    2959 |      1.92821 |
| F43 |    2946 |      1.91974 |
| DV3 |    2687 |      1.75097 |
| F24 |    2661 |      1.73402 |
| F42 |    2606 |      1.69818 |
| E3  |    2500 |      1.62911 |
| F3  |    2409 |      1.56981 |
| F2B |    2341 |      1.5255  |
| F31 |    2325 |      1.51507 |
| F33 |    2298 |      1.49748 |
| F32 |    2228 |      1.45186 |
| F12 |    2189 |      1.42645 |
| FX3 |    1925 |      1.25441 |
| F21 |    1923 |      1.25311 |
| E2  |    1764 |      1.1495  |

#### common values of date column

|            |   Count |   Percentage |
|------------|---------|--------------|
| 2017-10-01 |    2687 |      1.75097 |
| 2018-05-01 |    2686 |      1.75032 |
| 2018-06-01 |    2633 |      1.71578 |
| 2018-04-01 |    2621 |      1.70796 |
| 2019-07-01 |    2613 |      1.70275 |
| 2018-10-01 |    2597 |      1.69232 |
| 2019-04-01 |    2596 |      1.69167 |
| 2019-06-01 |    2578 |      1.67994 |
| 2018-07-01 |    2574 |      1.67733 |
| 2019-05-01 |    2570 |      1.67473 |
| 2019-10-01 |    2567 |      1.67277 |
| 2018-08-01 |    2560 |      1.66821 |
| 2017-05-01 |    2552 |      1.663   |
| 2017-11-01 |    2547 |      1.65974 |
| 2017-12-01 |    2538 |      1.65387 |
| 2018-02-01 |    2538 |      1.65387 |
| 2018-03-01 |    2536 |      1.65257 |
| 2017-06-01 |    2514 |      1.63823 |
| 2019-12-01 |    2502 |      1.63041 |
| 2018-12-01 |    2490 |      1.62259 |
| 2018-11-01 |    2484 |      1.61868 |
| 2019-02-01 |    2466 |      1.60695 |
| 2019-01-01 |    2461 |      1.6037  |
| 2019-11-01 |    2452 |      1.59783 |
| 2020-01-01 |    2448 |      1.59522 |
| 2018-01-01 |    2441 |      1.59066 |
| 2017-03-01 |    2438 |      1.58871 |
| 2019-03-01 |    2406 |      1.56786 |
| 2017-04-01 |    2396 |      1.56134 |
| 2020-02-01 |    2355 |      1.53462 |

#### Low cardinality (many similar values)

- country
- date
- visa_type

### Missing values

0 nulls/NaNs (0.0% dataset values missing)
