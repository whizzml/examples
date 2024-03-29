# Examples of WhizzML scripts and libraries

<p align=center><a href="http://bigml.com/whizzml"><img
src="https://static.bigml.com/static/img/share/share_bigml_features_automating.jpg"
alt="WhizzML" width=350></img></a></p>

Each script or library is in a directory in this folder.  For each one
you will always find a readme explaining what's its purpose and usage,
the actual whizzml code in a `.whizzml` file, and the JSON metadata
needed to create BigML resources.

By convention, when the artifact is a library, the files are called
`library.whizzml` and `metadata.json`, while for a script we use
`script.whizzml` and `metadata.json`.

## Quick Start

The `tutorials` folder offers [101's](./tutorials/readme.md)
describing the WhizzML code needed to create the
canonical training and predicting workflows for the different available models
in BigML.

## Reference and Documentation

The [Getting Started](https://static.bigml.com/static/pdf/BigML_WhizzML_Primer.pdf),
[WhizzML Reference](https://static.bigml.com/static/pdf/BigML_WhizzML_Reference.pdf) and
[WhizzML Tutorials](https://static.bigml.com/static/pdf/BigML_WhizzML_Tutorials.pdf)
documents, provide all the information about the language's syntax and standard
library functions as well as examples of use.

## Examples

- `covariate-shift` Determine if there is a shift in data distribution
  between two datasets.
- `model-or-ensemble` Decide whether to use models or ensembles for
  predictions, given an input source.
- `deduplicate` Removes contiguos duplicate rows of a dataset, where
  "duplicate" means a concrete field's value is the same for a set of
  contiguous rows.
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
- `model-per-category` Scripts to model and predict from an input
  dataset with a hand-picked root node field.
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
  are most important for differentiating between clusters.
- `anomaly-benchmarking` Script that takes any dataset (classification
  or regression) and turns it into a binary classification problem
  with the two classes "normal" and "anomalous".
- `sliding-window` Script that extends a dataset with new fields
  containing row-shifted values from numeric fields. For casting time
  series forecasting as a supervised learning problem.
- `unify-optype` Script that matches the field optypes to a given dataset
- `stratified-sampling` Script that implements the stratified sampling
  technique.
- `stratified-split` Script that creates train/test splits maintaining classes
  proportion.
- `cluster-chronological-split`: Split dataset chronologically into a Training
  and Test dataset based on a Cluster.
- `low-coverage` Script that removes all the sparse fields that have
  coverage less than a given threshold coverage.
- `stacked-predictions` Script that builds several predictors and
  returns a copy of the original dataset with the last field the most
  popular prediction.
- `calendar-adjustment` Given a dataset containing one or more monthly
  time series and a datestamp, scales the time series values by the
  number of days in the corresponding months, returning a dataset
  extended with new fields containing the scaled values.
- `stepwise-regression` Finds the best features for building a
  logistic regression using a greedy algorithm.
- `ordinal-encoder` Given a dataset, encodes categorical fields using ordinal
  ecoding, which uses a single column of integers to represent field classes
  (levels).
- `batch-explanations` A simple way to perform many predictions with
  explanations
- `best-first-cv` Extends the `best-first` code to find the list of
  fields in your dataset that produce the best models. Allows iteration and
  uses cross-validation.
- `multi-label` Classification for datasets with a
  multi-label (items) objective field.
- `recursive-feature-elimination` Script to select the n best features for
  modeling a given dataset, using a recursive algorithm
- `name-clusters`  Script to give names to clusters using important field
  names and their values
- `dimensionality-reduction` Script for dimensionality reduction using
  PCA and topic modelling.
- `fuzzy-norms`: Computing fuzzy-logic T-norms and T-conorms as new dataset features
- `automl`: Automated Machine Learning withing BigML
- `correlations-matrix`: Generates a CSV that contains the matrix of
  correlations between the numeric and categorical fields in a dataset
- `batch-association-sets`: Adds new features to a dataset by creating new
  fields based on the combinations that appear in the association rules
  extracted from it.
- `supervised-model-quality`: Creates the evaluation associated to the
  user-given supervised model (fusions excluded). The evaluation is created
  by splitting the dataset used in the model into a train/test split.
- `bulk-move`: Moves selected resources in bulk to a user-provided project.
  The resources to be moved are selected by applying the user-provided
  filters.
- `statistical-tests`: Performs statistical tests from a given dataset
  and creates a report with the results
- `time-aware cross-validation`: Cross-Validation considering temporal order
- `balanced-optiml': OptiMLs for Unbalanced Datasets using undersampling
  techniques.

## How to install

There are three kinds of installable WhizzML artifacts in this repo,
identified by the field "kind" in their metadata: libraries, scripts
and packages. The latter are compounds of libraries and scripts,
possibly with interdependencies, meant to be installed together.

Libraries and scripts are easily installed at the BigML dashboard.  To
install a script, navigate to 'Scripts' and then hover over the
installation dropdown. Choose 'Import script from GitHub' and paste in
the url to the example's folder. To install a library, first navigate
to 'Libraries', and the rest of the process is the same.

Packages can be installed in either of the following ways:

### Using bigmler

If you have bigmler installed in your system, just checkout the
repository 'whizzml/examples' and, at its top level, issue the command:

        make compile PKG=example-name

replacing `example-name` with the actual example name. That will
create all of the example's scripts and libraries for you.

### Using the web UI

- Install each of the libraries separately, using the urls to each of
  their folders. (For example, https://github.com/whizzml/examples/tree/master/clean-dataset/clean-data)

- Install each of the scripts separately, using the
  urls to each of their folders.

- If a script requires a library, you will get the error message
  'Library ../my-library not loaded.' Load the library by clicking in
  the textbox above the error message and typing the first few letters
  of the library's name. Select the library, then create the script as
  usual.

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
