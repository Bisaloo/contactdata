# contactdata (development version)

# contactdata 1.0.0

## New features

The updated data from Prem et al. (2021) has been added (#4). This results in a 
large number of cascading changes, including some breaking changes, detailed 
below.

### Breaking changes

* The new default returns data from the updated dataset. This means that any
re-run of code written with previous versions of contactdata will return a 
different result
* Arguments in `contact_df_countries()` have been removed and replaced by `...`
to increase flexibility. This is only an interface change and does not modify
the behaviour since all arguments were already forwarded to `contact_matrix()`.

### Non-breaking changes

* `list_countries()` and `contact_matrix()` now have two additional arguments:
  - `geographic_setting`, which specifies if you'd like to get the contact data
    from a `"rural"`, `"urban"` setting, or from `"all"` settings.
  - `data_source`, which indicates if the data should be extracted from Prem et
    al. (2017) or Prem et al. (2021)

# contactdata 0.2

* Addition of a new function `age_df_countries()` to get population
by age for all the countries for which we provide contact data.
This is motivated by the fact that models using contact data by
age will almost surely need population data by age as well.

# contactdata 0.1

* First release
