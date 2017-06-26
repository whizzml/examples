# Stratified Sampling

This script is an implementation of 
[stratified sampling](https://en.wikipedia.org/wiki/Stratified_sampling).

Suppose you want a random sample of your dataset, but for a particular
categorical field you want to sample at different rates for each class.

#Inputs

- The dataset you wish to sample

- The id or name of the categorical field to use for generating the stratified
  samples

- A map of the categorical field classes to their desired counts. For example,
  if there are three classes, red, green, and blue, and you would like a sample
  with 100 rows of each class, then the map would be 
  `{"red":100, "green":100, "blue":100}`

- A boolean that indicates if the counts are absolute or weighted. For example,
  if counts is `{"red": 10, "green": 20}` and weighted is `False`, then the
  dataset sample will have exactly 10 red and 20 green instances. However, if
  weighted is `True` then the sample will have twice as many green as red
  instances up to the maximum of the smallest weighted class. 

#Output

- A dataset created from random samples of the desired size from each
  of the indicated strata

Note: The counts are used to compute a sample-rate, which means that round-off
errors may adjust the counts slightly. 
