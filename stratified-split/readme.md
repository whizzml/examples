# Stratified Split

This script splits the data in a dataset in two complementary datasets:
training and test. It samples at random the instances making sure that all
classes in the objective field are sampled using the same rate.

#Inputs

- The dataset you wish to sample

- The id or name of the categorical field to use for generating the stratified
  split (usually the objective field)

- The rate of instances that you want to use for training (default is 0.8 and
  selects 80% of the instances)

#Output

- A training dataset created from random samples of the desired size from each
  of the indicated strata
- A test dataset created with the complementary instances of the original
  dataset

Note: The counts are used to compute a sample-rate, which means that round-off
errors may adjust the counts slightly.
