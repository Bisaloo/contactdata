
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
152 countries. This data comes from

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
country:

``` r
library(contactdata)
contact_matrix("France")
#>         00_05   05_10   10_15   15_20   20_25   25_30   30_35   35_40   40_45
#> 00_05 2.78349 1.09714 0.59766 0.42514 0.54475 0.83666 1.12491 1.01569 0.63464
#> 05_10 1.33122 6.29510 1.27272 0.46477 0.35261 0.68506 1.02618 1.13031 0.99165
#> 10_15 0.39897 2.22464 9.84713 1.05305 0.45699 0.50444 0.66377 1.01329 1.16385
#> 15_20 0.30098 0.51971 3.20301 9.61013 1.15339 0.63465 0.54228 0.81646 0.95410
#> 20_25 0.37971 0.37347 0.44479 2.04600 3.20611 1.27444 0.82373 0.68958 0.68682
#> 25_30 0.72782 0.46144 0.35097 0.79856 1.67674 2.60892 1.49240 1.13783 0.96147
#> 30_35 0.79200 0.88463 0.67619 0.47619 0.92299 1.40768 2.20929 1.48891 1.13288
#> 35_40 0.74890 1.07171 0.88910 0.75047 0.72376 1.16507 1.45639 2.36740 1.65545
#> 40_45 0.51058 0.76735 1.06267 0.90561 0.87963 1.04440 1.34928 1.54511 2.22415
#> 45_50 0.33981 0.42638 0.67853 1.08318 0.90254 0.92989 1.09819 1.26458 1.37553
#> 50_55 0.31072 0.36274 0.59937 0.83731 1.00352 1.19355 1.06834 1.05459 1.36231
#> 55_60 0.39864 0.42351 0.50890 0.54609 0.71051 1.02643 1.13779 0.92754 1.01287
#> 60_65 0.38587 0.36993 0.34816 0.37182 0.48445 0.66960 0.78982 0.84058 0.74527
#> 65_70 0.29379 0.37405 0.33048 0.29065 0.37366 0.48083 0.65580 0.67714 0.68240
#> 70_75 0.20554 0.34026 0.38589 0.45420 0.31254 0.41868 0.44131 0.65480 0.77630
#> 75_80 0.26897 0.27668 0.35823 0.32506 0.26700 0.28903 0.42676 0.45384 0.51002
#>         45_50   50_55   55_60   60_65   65_70   70_75   75_80
#> 00_05 0.50544 0.52665 0.49783 0.39153 0.33717 0.26006 0.17979
#> 05_10 0.60923 0.49424 0.44941 0.41570 0.33297 0.24289 0.17912
#> 10_15 0.83145 0.55457 0.38642 0.30138 0.29915 0.26661 0.19652
#> 15_20 1.05109 0.63727 0.39461 0.28397 0.24315 0.19886 0.15800
#> 20_25 0.97167 0.70034 0.48631 0.29828 0.22838 0.24443 0.18815
#> 25_30 0.91936 0.95941 0.62849 0.43022 0.29327 0.22153 0.16448
#> 30_35 0.95357 0.83514 0.72204 0.51731 0.34141 0.23656 0.19808
#> 35_40 1.17352 0.91423 0.64593 0.56372 0.43426 0.33740 0.20415
#> 40_45 1.46235 1.06357 0.54927 0.52157 0.41118 0.33389 0.24101
#> 45_50 1.93332 1.16615 0.68328 0.45318 0.34997 0.32903 0.25424
#> 50_55 1.58509 1.70873 1.04120 0.59368 0.35534 0.33119 0.26512
#> 55_60 0.93730 1.19991 1.48381 0.82802 0.48857 0.32124 0.23713
#> 60_65 0.67297 0.67140 0.88300 1.21412 0.69313 0.50550 0.25726
#> 65_70 0.52748 0.55506 0.65119 0.74149 1.13052 0.52794 0.27354
#> 70_75 0.69078 0.54272 0.51067 0.89222 0.93588 1.25788 0.39716
#> 75_80 0.66095 0.66008 0.47413 0.41622 0.59534 0.62970 0.44627
```

You can also get several countries at once with the
`contact_df_countries()` function, as detailed in the
[vignette](https://bisaloo.github.io/contactdata/articles/visualise.html).

Because it is very likely that users of this package will also need data
about the population in each age group, it is also bundled in this
package for convenience. Please see `?age_df_countries` for more
information.
