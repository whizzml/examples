# Examples of WhizzML scripts and libraries

Each script or library is in a directory in this folder.  For each one
you will always find a readme explaining what's its purpose and usage,
the actual whizzml code in a `.whizzml` file, and the JSON metadata
needed to create BigML resources.

By convention, when the artifact is a library, the files are called
`library.whizzml` and `metadata.json`, while for a script we use
`script.whizzml` and `metadata.json`.

## Examples

- `model-or-ensemble` Decide whether to use models or ensembles for
  predictions, given an input source.
- `remove-anomalies` Using Flatline and an anomaly detector, remove
  from an input dataset its anomalous rows.
- `find-neighbors`  Using cluster distances as a metric, find
  instances in a dataset close to a given row.
- `stacked-generalization` Simple
  [stacking](https://en.wikipedia.org/wiki/Ensemble_learning#Stacking)
  using decision tree, ensembles and logistic regression.
- `best-first` Feature selection using a greedy algorithm.
- `gradient-boosting` Boosting algorithm using gradient descent.
- `model-per-cluster` Scripts and library to model data after
  clustering and make predictions using the resulting per-cluster
  model.
