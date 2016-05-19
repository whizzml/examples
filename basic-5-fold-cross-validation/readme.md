# Basic 5-fold cross-validation

The objective of this script is to perform a 5-fold cross validation of the
model built from a dataset by using the default choices in all the available
configuration parameters. Thus, the only input needed in for the script to
run is the name of the dataset used to both train and test de models in the
cross validation. The algorithm:

- Divides the dataset in 5 parts
- Holds out the data in one of the parts and builds a model with the rest of
  data
- Evaluates the model with the hold out data
- The second and third steps are repeated with each of the 5 parts, so that
  5 evaluations are generated
- Finally, the evaluation metrics are averaged to provide the cross-validation
  metrics.

# Using the basic 5-fold cross-validation script

One just needs to call

```(cross-validation-1-click dataset-id)```

using as **input** the ID of the dataset we want to build our models from.

The **output** of the script will be an `evaluation ID`. This evaluation is a
cross-validation, meaning that its metrics are averages of the 5 evaluations
created in the cross-validation process.
