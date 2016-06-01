# Examples of WhizzML scripts and libraries

<p align=center><a href="http://bigml.com/whizzml"><img
src="https://static.horizon.bigml.com/static/img/whizzml/whizzml_share_logo.png"
alt="WhizzML" width=350></img></a></p>

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
- `smacdown-branin` Simple example of SMACdown, using the Branin
  function as evaluator.
- `smacdown-ensemble` Use SMACdown to discover the best possible
  ensemble to model a given dataset id.
- `find-neighbors`  Using cluster distances as a metric, find
  instances in a dataset close to a given row.
- `stacked-generalization` Simple
  [stacking](https://en.wikipedia.org/wiki/Ensemble_learning#Stacking)
  using decision tree, ensembles and logistic regression.
- `best-first` Feature selection using a greedy algorithm.
- `gradient-boosting`
  [Boosting](https://en.wikipedia.org/wiki/Gradient_boosting)
  algorithm using gradient descent.
- `model-per-cluster` Scripts and library to model data after
  clustering and make predictions using the resulting per-cluster
  model.
- `best-k` Scripts and library implementing Pham-Dimov-Nguyen
  algorithm for choosing the best k in k-means clusters.
- `anomaly-shift` Calculate the average anomaly between two given
  datasets.
- `cross-validation` Scripts for performing k-fold crossvalidation.
- `clean-dataset` Scripts and library for cleaning up a dataset
