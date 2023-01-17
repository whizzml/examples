# Balanced OptiML script

This script builds undersampled datasets to compensate imbalance in datasets
with a rare class and creates OptiMLs for them to provide a Balanced
Automated search for the best model.


Several operations are applied to the original dataset to try to compensate
for the rare class imbalance:

- A stratified split is applied to generate a training/validation/test
  dataset collection ensuring that the original proportion of instances in
  the rare class is maintained in all of them.
- The training dataset is used to generate a list of undersampled datasets.
  The datasets will contain all the instances belonging to the rare class
  and a sample of instances of the common classes. The proportion of instances
  between the rare and the common classes can be provided by the user as an
  integer and 1 is used by default.
- An OptiML will be built for every undersampled dataset and optimization will
  be done for the user-given metric (`recall` will be used by default) and the
  rare class. Other OptiML configurations can also be provided.
- The test dataset created in the first step is returned as output for
  final evaluations

## Inputs

- The dataset you wish to sample.

- The id or name of the categorical field to use for generating the stratified
  split (usually the objective field).

- The rare class to be balanced.

- The rate of instances that you want to use for training (default is 0.8 and
  selects 80% of the instances). Test and Validation datasets will split
  50%-50% the hold out instances.

- The number of datasets that will be created by undersampling the common
  classes. (default = 5).

- The common-classes sampling proportion to be used (default = 1).

- The metric to be used in the OptiML optimization process (default = recall).

- The OptiML parameters to be used as a map (default = {}).

## Output

- A collection of undersampled OptiMLs.

- The test dataset to be used in the final evaluation.
