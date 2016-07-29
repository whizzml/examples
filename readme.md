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

- `covariate-shift` Determine if there is a shift in data distribution
  between two datasets.
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
- `seeded-best-k` Scripts and library implementing Pham-Dimov-Nguyen
  algorithm for choosing the best k in k-means clusters, with
  user-provided seeds.
- `anomaly-shift` Calculate the average anomaly between two given
  datasets.
- `cross-validation` Scripts for performing k-fold crossvalidation.
- `clean-dataset` Scripts and library for cleaning up a dataset.
- `boruta` Script for feature selection using the Boruta algorithm.
- `cluster-classification` Script that determines which input fields
  are most important for differentiating between clusters


## Compiling packages and running tests

The [makefile](makefile) at the top level provides targets to register
packages and run tests (when they're available).  It needs a working
installation of [bigmler](https://bigml.com/tools/bigmler). Just type

```shell
make help
```

for a list of possibilities, including:

- `tests` to run all available test scripts (which live in the `test`
  subdirectory of some packages), which typically use bigmler.

- `compile` to use bigmler to register in BigML the resources
  associated with one or more packages in the repository.

- `clean` to delete resources and outputs (both remote and local)
  created by `compile`.

- `distcheck` combines most of the above to check that all the scripts
  in the repository are working: this target should build cleanly
  before merging into

The verbosity of the tests output can be controlled with the variable
`VERBOSITY`, which runs from 0 (the default, mostly silent) to 2.
E.g.:

```shell
make tests VERBOSITY=1
```

If you write your own test scripts, include
[test-utils.sh](test-utils.sh) for shared utilities.
