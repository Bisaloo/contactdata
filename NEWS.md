# contactdata 1.1.0

## Bug fix

* `age_df_countries()` now pads single-digit ages with a leading 0 to ensure 
correct ordering. The new behaviour also produces age bin labels that are 
consistent with the labels for the contact matrices 

  Before:
  
  ```
      country   age population
  945  France 70_74    3611581
  946  France 65_69    3915473
  947  France 60_64    4123982
  948  France   5_9    4179215
  949  France 55_59    4344144
  950  France 50_54    4445007
  951  France 45_49    4490632
  952  France 40_44    3991502
  953  France 35_39    4097635
  954  France 30_34    4036630
  955  France 25_29    3920126
  956  France 20_24    3959154
  957  France 15_19    4100855
  958  France 10_14    4201067
  959  France   0_4    4070454
  960  France   75+    6352464
  ```

  After:
  
  ```
      country   age population
  945  France 00_04    4070454
  946  France 05_09    4179215
  947  France 10_14    4201067
  948  France 15_19    4100855
  949  France 20_24    3959154
  950  France 25_29    3920126
  951  France 30_34    4036630
  952  France 35_39    4097635
  953  France 40_44    3991502
  954  France 45_49    4490632
  955  France 50_54    4445007
  956  France 55_59    4344144
  957  France 60_64    4123982
  958  France 65_69    3915473
  959  France 70_74    3611581
  960  France   75+    6352464
  ```

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
