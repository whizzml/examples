# Stratified Sampling

This script is an implementation of 
[stratified sampling](https://en.wikipedia.org/wiki/Stratified_sampling).

Suppose you want a random sample of your dataset, but for a particular
categorical field you want to sample at different rates for each class.

Currently, it requires sample counts as input. 

#Inputs

- The dataset you wish to sample

- The id or name of the categorical field to use for generating the stratified samples

- A map of the categorical field classes to their desired counts. For example,
  if there are three classes, red, green, and blue, and you would like a sample
  with 100 rows of each class, then the map would be 
  `{"red":100, "green":100, "blue":100}`

#Output

- A dataset created from random samples of the desired size from each
  of the indicated strata

