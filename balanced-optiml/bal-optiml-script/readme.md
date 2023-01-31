# Balanced OptiML script

This script builds undersampled datasets to compensate imbalance in datasets
with a rare class that is considered to be the positive class,
and creates OptiMLs for them to provide a Balanced Automated search for
the best model.


Several operations are applied to the original dataset to try to compensate
for the positive class imbalance:

- A stratified split is applied to generate a training/validation/test
  dataset collection ensuring that the original proportion of instances in
  the positive class is maintained in all of them.
- The training dataset is used to generate a list of undersampled datasets.
  The datasets will contain all the instances belonging to the positive class
  and a sample of instances of the negative classes. The proportion of instances
  between the positive class and the rest classes can be provided by the user
  as an integer and 1 is used by default.
- An OptiML will be built for every undersampled dataset and optimization will
  be done for the user-given metric (`recall` will be used by default) and the
  positive class. Other OptiML configurations can also be provided.
- The test dataset created in the first step is returned as output for
  final evaluations

## Inputs

- The dataset you wish to sample.

- The id or name of the categorical field to use for generating the stratified
  split (usually the objective field).

- The positive class to be balanced.

- The rate of instances that you want to use for training (default is 0.8 and
  selects 80% of the instances). Test and Validation datasets will split
  50%-50% the hold out instances.

- The number of datasets that will be created by undersampling the common
  classes (default = 5).

- The common-classes sampling proportion to be used (default = 1).

- The metric to be used in the OptiML optimization process (default = recall).

- The OptiML parameters to be used as a map (default = {}).

## Output

- The collection of undersampled Datasets.

- The collection of undersampled OptiMLs.

- The unbalanced train dataset that has been used for the undersamples.

- The unbalanced validation dataset used in the OptiMLs search.

- The unbalanced test dataset that should be used in final evaluations.

- The OptiML for the unbalanced train dataset.
