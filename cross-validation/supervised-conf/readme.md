# K-fold cross-validation for any existing supervised learning model

The objective of this script is to perform a k-fold cross validation of an
existing supervised model. The algorithm:

- Retrieves the model information to extract the dataset ID used for training
- Divides the dataset in k parts
- Holds out the data in one of the parts and builds a supervised model
  with the rest of data
- Evaluates the supervised model with the hold out data
- The second and third steps are repeated with each of the k parts, so that
  k evaluations are generated
- Finally, the evaluation metrics are averaged to provide the cross-validation
  metrics.

The **inputs** for the script are:

* `slm-id`: (supervised-learning-model-id) Model ID to be cross validated
* `k-folds`: (integer) Number of folds to split the dataset into (optional,
                       default=5)
* `evaluation-options`: (map) Options to be used in predictions when evaluating (optional)
* `delete-resources?`: (boolean) Whether to delete intermediate resources (optional, default=true)
* `stratified?`: (boolean) Whether to stratify the k-folds across classes (optional, default=false)

As you can see, most of the inputs are optional. They default to the defaults
in the platform.

# Using the supervised model's k-fold cross-validation script

One just needs to call

```
(cross-validation slm-id
                  k-folds
                  evaluation-options
                  delete-resources?
                  stratified?)
```

using the previously described inputs.

The **output** of the script will be an `evaluation ID`. This evaluation is a
cross-validation, meaning that its metrics are averages of the k evaluations
created in the cross-validation process.
