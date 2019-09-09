# Ensemble's k-fold cross-validation

The objective of this script is to perform a k-fold cross validation of an
ensemble built from a dataset. The algorithm:

- Divides the dataset in k parts
- Holds out the data in one of the parts and builds an ensemble with the rest
  of data
- Evaluates the ensemble with the hold out data
- The second and third steps are repeated with each of the k parts, so that
  k evaluations are generated
- Finally, the evaluation metrics are averaged to provide the cross-validation
  metrics.

The **inputs** for the script are:

* `dataset-id`: (dataset-id) Dataset ID for the training data
* `k-folds`: (integer) Number of folds to split the dataset into (optional, default=5)
* `objective-id`: (string) ID of the objective field for the model (optional)
* `number-of-models`: (integer) Number of models in the ensemble (optional, default=10)
* `missing-splits`: (boolean) Model's missing_splits flag (optional, default=false)
* `stat-pruning`: (boolean) Model's statistical pruning flag (optional, default=false)
* `balance-objective`: (boolean) Model's balance objective flag (optional, default=false)
* `weight-field`: (string) ID of the field used in the model as weight field (optional, default="")
* `objective-weights`: (list) List of objective weights for the model (optional, default=[])
* `node-threshold`: (integer) Maximum number of nodes in the model (optional, default=-1)
* `sample-rate`: (number) Percentage of data used in sampling (optional, default=1)
* `replacement`: (boolean) Sets the ensemble replacement flag -- sample with replacement -- (optional, default=true)
* `randomize`: (boolean) Sets the ensemble randomize flag --random forest -- (optional, default=false)
* `seed`: (string) Seed used in random sampling (optional, default="cross-validation")
* `delete-resources`: (boolean) Whether to delete intermediate resources (optional, default=true)
* `stratified?`: (boolean) Whether to stratify the k-folds across classes (optional, default=false)

as you can see, most of the inputs are optional. They default to the defaults
in the platform. The `objective-id` will also be inferred from the one in
the dataset if it is not provided.

# Using the ensemble's k-fold cross-validation script

One just needs to call

```
(ensemble-cross-validation dataset-id
                           k-folds
                           objective-id
                           number-of-models
                           missing-splits
                           stat-pruning
                           balance-objective
                           weight-field
                           objective-weights
                           node-threshold
                           sample-rate
                           replacement
                           randomize
                           seed
                           delete-resources
                           stratified?)
```

using the previously described inputs.

The **output** of the script will be an `evaluation ID`. This evaluation is a
cross-validation, meaning that its metrics are averages of the k evaluations
created in the cross-validation process.
