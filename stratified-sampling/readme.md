# Stratified Sampling

This script is an implementation of [stratified sampling](https://en.wikipedia.org/wiki/Stratified_sampling). Suppose you
want a random sample of your dataset, but for a particular field you
want to be sure that certain values will be represented at certain
levels. Currently, it requires sample counts as input.

#Inputs

-  The dataset you wish to sample

- The id of the field of interest

- A map of the field values to their desired counts

#Output

- A dataset created from random samples of the desired size from each
  of the indicated strata

