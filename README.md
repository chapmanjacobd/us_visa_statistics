# us_visa_statistics
Monthly Immigrant and Nonimmigrant Visa Issuances Data

[Visa Symbol key](https://travel.state.gov/content/dam/visas/Statistics/Immigrant-Statistics/MonthlyIVIssuances/Immigrant%20Visa%20Symbols.pdf)

Note:

> The Visa Office has changed its methodology for calculating visa data beginning with the Fiscal Year (FY) 2019 annual Report of the Visa Office and continuing with FY 2020 data, to reflect the greater access to application-level data attained during FY 2019. Our previous methodology was based on a count of workload actions, which were not linked by application. The new methodology more accurately reflects final outcomes from the visa application process during a specified reporting period.  The new methodology follows visa applications, including updates to their status (i.e., issued or refused), which could change as the fiscal year progresses, or result in slight changes in data for earlier years.  Therefore, beginning with FY 2020, individual monthly issuance reports should not be aggregated, as this will not provide an accurate issuance total for the fiscal year to date.  Instead, refer to our annual Report of the Visa Office for final full Fiscal Year statistics.
> While the new methodology is more accurate, it does not mean that our prior methodology was flawed.  The two are simply not comparable.  However, based on our analysis, the discrepancies between the methodologies are minor.  For example, the difference between reported issuances of NIVs and IVs in FY 2018 (legacy methodology) and those in FY 2019 (new methodology) is less than one percent worldwide.
> [U.S. Department of State](https://travel.state.gov/content/travel/en/legal/visa-law0/visa-statistics/immigrant-visa-statistics/monthly-immigrant-visa-issuances.html)

## immigrant_data.csv

### Shape

(153459, 4)

### Sample of rows

|        | country     | visa_type   |   count | date       |
|--------|-------------|-------------|---------|------------|
|      0 | Afghanistan | CR1         |      11 | 2017-03-01 |
|      1 | Afghanistan | DV1         |       2 | 2017-03-01 |
|      2 | Afghanistan | DV2         |       1 | 2017-03-01 |
| 153456 | Zimbabwe    | IR1         |       1 | 2024-03-01 |
| 153457 | Zimbabwe    | IR2         |       3 | 2024-03-01 |
| 153458 | Zimbabwe    | IR5         |       4 | 2024-03-01 |

### Summary statistics

|       |       count |
|-------|-------------|
| count | 153459      |
| mean  |     21.2987 |
| std   |     92.6382 |
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
| (-4.008, 835.667]    |  153122 |
| (835.667, 1670.333]  |     239 |
| (1670.333, 2505.0]   |      73 |
| (2505.0, 3339.667]   |      18 |
| (3339.667, 4174.333] |       5 |
| (4174.333, 5009.0]   |       2 |

### Categorical columns

#### common values of country column

|                                    |   Count |   Percentage |
|------------------------------------|---------|--------------|
| India                              |    2384 |     1.55351  |
| Philippines                        |    2191 |     1.42774  |
| Vietnam                            |    2114 |     1.37757  |
| China - mainland born              |    2093 |     1.36388  |
| Mexico                             |    2088 |     1.36062  |
| Korea, South                       |    2042 |     1.33065  |
| Pakistan                           |    1960 |     1.27721  |
| Brazil                             |    1885 |     1.22834  |
| Venezuela                          |    1874 |     1.22117  |
| Colombia                           |    1851 |     1.20619  |
| Nigeria                            |    1814 |     1.18207  |
| Ukraine                            |    1792 |     1.16774  |
| Russia                             |    1781 |     1.16057  |
| Jamaica                            |    1769 |     1.15275  |
| Egypt                              |    1694 |     1.10388  |
| Ecuador                            |    1683 |     1.09671  |
| Dominican Republic                 |    1651 |     1.07586  |
| El Salvador                        |    1649 |     1.07455  |
| Great Britain and Northern Ireland |    1633 |     1.06413  |
| Iran                               |    1605 |     1.04588  |
| Bangladesh                         |    1560 |     1.01656  |
| Peru                               |    1552 |     1.01135  |
| Ghana                              |    1541 |     1.00418  |
| Jordan                             |    1527 |     0.995054 |
| Honduras                           |    1519 |     0.989841 |
| Nepal                              |    1516 |     0.987886 |
| Guatemala                          |    1514 |     0.986583 |
| Haiti                              |    1496 |     0.974853 |
| Turkey                             |    1455 |     0.948136 |
| Canada                             |    1443 |     0.940316 |

#### common values of visa_type column

|     |   Count |   Percentage |
|-----|---------|--------------|
| IR1 |   12096 |      7.88224 |
| CR1 |   10912 |      7.11069 |
| IR5 |   10680 |      6.95951 |
| IR2 |   10381 |      6.76467 |
| SB1 |    4133 |      2.69323 |
| FX  |    3904 |      2.544   |
| CR2 |    3892 |      2.53618 |
| DV1 |    3730 |      2.43062 |
| FX1 |    3675 |      2.39478 |
| F11 |    3519 |      2.29312 |
| FX2 |    3321 |      2.1641  |
| DV  |    3311 |      2.15758 |
| F41 |    3172 |      2.067   |
| F1  |    3154 |      2.05527 |
| F4  |    3053 |      1.98946 |
| DV2 |    2959 |      1.9282  |
| F43 |    2946 |      1.91973 |
| DV3 |    2687 |      1.75096 |
| F24 |    2661 |      1.73401 |
| F42 |    2606 |      1.69817 |
| E3  |    2500 |      1.6291  |
| F3  |    2409 |      1.5698  |
| F2B |    2341 |      1.52549 |
| F31 |    2325 |      1.51506 |
| F33 |    2298 |      1.49747 |
| F32 |    2228 |      1.45185 |
| F12 |    2189 |      1.42644 |
| FX3 |    1925 |      1.25441 |
| F21 |    1923 |      1.2531  |
| E2  |    1764 |      1.14949 |

#### common values of date column

|            |   Count |   Percentage |
|------------|---------|--------------|
| 2017-10-01 |    2687 |      1.75096 |
| 2018-05-01 |    2686 |      1.7503  |
| 2018-06-01 |    2633 |      1.71577 |
| 2018-04-01 |    2621 |      1.70795 |
| 2019-07-01 |    2613 |      1.70273 |
| 2018-10-01 |    2597 |      1.69231 |
| 2019-04-01 |    2596 |      1.69166 |
| 2019-06-01 |    2578 |      1.67993 |
| 2018-07-01 |    2574 |      1.67732 |
| 2019-05-01 |    2570 |      1.67471 |
| 2019-10-01 |    2567 |      1.67276 |
| 2018-08-01 |    2560 |      1.6682  |
| 2017-05-01 |    2552 |      1.66298 |
| 2017-11-01 |    2547 |      1.65973 |
| 2017-12-01 |    2538 |      1.65386 |
| 2018-02-01 |    2538 |      1.65386 |
| 2018-03-01 |    2536 |      1.65256 |
| 2017-06-01 |    2514 |      1.63822 |
| 2019-12-01 |    2502 |      1.6304  |
| 2018-12-01 |    2490 |      1.62258 |
| 2018-11-01 |    2484 |      1.61867 |
| 2019-02-01 |    2466 |      1.60694 |
| 2019-01-01 |    2461 |      1.60369 |
| 2019-11-01 |    2452 |      1.59782 |
| 2020-01-01 |    2448 |      1.59521 |
| 2018-01-01 |    2441 |      1.59065 |
| 2017-03-01 |    2438 |      1.5887  |
| 2019-03-01 |    2406 |      1.56785 |
| 2017-04-01 |    2396 |      1.56133 |
| 2020-02-01 |    2355 |      1.53461 |

#### Low cardinality (many similar values)

- country
- visa_type
- date

### Missing values

0 nulls/NaNs (0.0% dataset values missing)
