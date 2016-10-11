# Modeling and prediction per cluster

With the [create-cluster-models script](create-cluster-models), you'll
generate a cluster for a given input dataset, and then create a
predictive model for each of the cluster's centroids, using only the
subset of rows belonging to that centroid.  You can then use those
models for making new predictions.

Given a new instance, one first finds its centroid (using the cluster
created by the previous script), and then perform a prediction using
the model associated with that centroid (again, found as one of the
outputs of `create-cluster-models`).

Predictions can be performed either on single input values, or over a
full input dataset.  Since both cases share lots of code, we have put
that common functionality in a library,
[use-cluster-models](use-cluster-models), that exports a couple of
functions for predicting using cluster models.

Finally, the trivial scripts [single-prediction](single-prediction)
and [batch-prediction](batch-prediction), simply use the functions
exported by the [use-cluster-models library](use-cluster-models) to
make predictions.

## How to install

### Using bigmler

If you have bigmler installed in your system, just checkout this
repository and, at its top level, issue the command:

        make compile PKG_DIR=model-per-cluster

That will create for you all necessary libraries and the three
scripts.

### Using the web UI

- Install the `create-cluster-models` script, using
  [this url](./create-cluster-models).
- Install the `use-cluster-models` library, using
  [this url](./use-cluster-models).
- Install [single-prediction](./single-prediction), with the previous
  library as its only dependency.
- Install [batch-prediction](./batch-prediction), with the previous
  library as its only dependency.
