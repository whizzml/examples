# Remove Low Coverage Fields

This script removes all the fields that have coverage less than a
given threshold coverage. For example, if given a dataset of 1000 rows
and a threshold value of 0.10, all fields with more than 900 missing
values will be eliminated.

# Inputs

-  The dataset you wish to alter

- A threshold value either as an integer, which will be taken as the
  largest number of missing values permitted, or a percent, which will
  be taken as the lowest coverage percent permittied.

# Output

- The dataset with the low coverage fields removed