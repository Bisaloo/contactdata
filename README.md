
<!-- README.md is generated from README.Rmd. Please edit that file -->

# contactdata <img src="man/figures/logo.svg" align="right" alt="" width="120" />

<!-- badges: start -->

[![cran
version](https://www.r-pkg.org/badges/version-ago/contactdata)](https://cran.r-project.org/package=contactdata/)
[![R-CMD-check](https://github.com/Bisaloo/contactdata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Bisaloo/contactdata/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![Codecov test
coverage](https://codecov.io/gh/Bisaloo/contactdata/branch/main/graph/badge.svg)](https://codecov.io/gh/Bisaloo/contactdata?branch=main)
<!-- badges: end -->

The goal of contactdata is to provide access to social contact data for
177 geographical regions. This data comes from

> Kiesha Prem, Alex R. Cook, Mark Jit, *Projecting social contact
> matrices in 152 countries using contact surveys and demographic data*,
> PLoS Comp. Biol. (2017),
> <https://doi.org/10.1371/journal.pcbi.1005697>.

and

> Kiesha Prem, Kevin van Zandvoort, Petra Klepac, Rosalind M. Eggo,
> Nicholas G. Davies, CMMID COVID-19 Working Group, Alex R. Cook, Mark
> Jit, *Projecting contact matrices in 177 geographical regions: An
> update and comparison with empirical data for the COVID-19 era*, PLoS
> Comp. Biol. (2021), <https://doi.org/10.1371/journal.pcbi.1009098>.

(please cite them in your publications, alongside this package).

contactdata offers an easier access to this data, makes it readily
compatible with [tidyverse](https://www.tidyverse.org/) packages, such
as [ggplot2](https://ggplot2.tidyverse.org/), via the
`contact_countries()` function, and provides an easy way to harmonise
country nomenclature by using the
[countrycode](https://cran.r-project.org/package=countrycode) package as
authoritative name source.

## Installation

You can install this package from CRAN:

``` r
install.packages("contactdata")
```

or the development version from [GitHub](https://github.com/bisaloo),
via my [r-universe](https://bisaloo.r-universe.dev/):

``` r
install.packages("contactdata", repos = "https://bisaloo.r-universe.dev")
```

## Example

The most basic function allows you to get matrix data for a specific
region:

``` r
library(contactdata)
contact_matrix("France")
#>           00_05     05_10     10_15     15_20     20_25     25_30     30_35
#> 00_05 3.8049208 1.1064463 0.4119145 0.2553693 0.3417530 0.7532100 1.2090488
#> 05_10 1.0620240 5.0325631 1.0108210 0.2729936 0.1637277 0.4151037 0.9207158
#> 10_15 0.2383228 1.5384390 6.9859632 0.8459108 0.2870553 0.2443827 0.4032533
#> 15_20 0.1242916 0.3084664 2.3013378 7.8316731 1.3599526 0.6511973 0.5309225
#> 20_25 0.1997494 0.1682122 0.2555462 2.1654802 3.9337904 1.7076407 1.1677744
#> 25_30 0.5331867 0.2486300 0.1435870 0.7309595 1.9436259 3.4581082 1.7769048
#> 30_35 0.7222459 0.8480973 0.5299038 0.4228065 1.0050076 1.7204472 2.9192993
#> 35_40 0.7037954 1.0721441 0.8366342 0.6832771 0.7646973 1.4071985 1.7597999
#> 40_45 0.3095332 0.6566442 0.9827524 1.1093668 0.9235031 1.2518923 1.5914371
#> 45_50 0.4058094 0.4671793 0.6117632 1.5367229 0.9454052 0.9938984 1.2592405
#> 50_55 0.2517178 0.5947777 0.8288772 1.2016733 1.0188128 1.2906068 1.1792561
#> 55_60 0.5424359 0.6711899 0.5736708 0.7492978 0.6135626 0.9317515 0.9175372
#> 60_65 0.3961294 0.3629084 0.2566179 0.3614150 0.3387789 0.5080470 0.6393848
#> 65_70 0.1980189 0.3134375 0.2568708 0.1574851 0.2121279 0.3071351 0.4501078
#> 70_75 0.1052495 0.2944891 0.3077932 0.3553412 0.1558914 0.2445032 0.2530902
#> 75_80 0.2435584 0.3171220 0.4522256 0.3598813 0.1542999 0.1882229 0.3050821
#>           35_40     40_45     45_50     50_55     55_60      60_65      65_70
#> 00_05 1.0419960 0.4955829 0.3104594 0.3070544 0.2722105 0.18633754 0.12804520
#> 05_10 1.1384301 0.8451808 0.3314044 0.2073083 0.1854381 0.17691472 0.11164899
#> 10_15 0.8269250 1.0806856 0.5704767 0.2657533 0.1466135 0.10152928 0.08817052
#> 15_20 0.7621321 1.0248384 1.0489743 0.4785021 0.1639009 0.07173157 0.05282605
#> 20_25 1.1331411 0.9700452 1.2702652 0.8133999 0.3272061 0.08382776 0.04576510
#> 25_30 1.4707826 1.2626267 0.9969784 0.9610877 0.3574627 0.11253397 0.05165248
#> 30_35 1.8937794 1.4574822 1.1351731 0.8100567 0.4053920 0.18410812 0.08541583
#> 35_40 3.2108263 2.0977977 1.3443554 0.9195016 0.3641096 0.25969059 0.15240004
#> 40_45 1.8766171 2.9541130 1.6818322 1.1128901 0.2732150 0.18353558 0.11084809
#> 45_50 1.4654930 1.5731579 2.1964738 1.0863042 0.3406847 0.15129942 0.08636681
#> 50_55 1.2145400 1.5942381 1.7430635 1.9184501 0.6491669 0.26726729 0.11850585
#> 55_60 0.7479099 0.7927704 0.6808703 0.9229155 1.4619218 0.51294863 0.21825949
#> 60_65 0.6940436 0.5234400 0.4162769 0.4414520 0.6750623 1.40597284 0.42649139
#> 65_70 0.4543158 0.4253709 0.3023152 0.3242779 0.4404185 0.51803705 1.00304348
#> 70_75 0.4770518 0.5149822 0.4340009 0.3392186 0.3381533 0.65997723 0.61920693
#> 75_80 0.3824259 0.4514450 0.4428716 0.5388023 0.3440813 0.27980028 0.36715407
#>            70_75      75_80
#> 00_05 0.08780229 0.05386407
#> 05_10 0.05825985 0.05311071
#> 10_15 0.06970996 0.06966683
#> 15_20 0.03453706 0.02613884
#> 20_25 0.05447291 0.05237283
#> 25_30 0.03057661 0.02361016
#> 30_35 0.04700946 0.05253904
#> 35_40 0.09805799 0.04637476
#> 40_45 0.08697388 0.04801201
#> 45_50 0.08310938 0.08187873
#> 50_55 0.08806304 0.09026068
#> 55_60 0.11994582 0.09467785
#> 60_65 0.26297656 0.12855394
#> 65_70 0.27590642 0.13898285
#> 70_75 0.97407644 0.32576427
#> 75_80 0.36754549 0.64291815
```

You can also get several countries at once with the
`contact_df_countries()` function, as detailed in the
[vignette](https://bisaloo.github.io/contactdata/articles/visualise.html).

Because it is very likely that users of this package will also need data
about the population in each age group, it is also bundled in this
package for convenience. Please see `?age_df_countries` for more
information.
