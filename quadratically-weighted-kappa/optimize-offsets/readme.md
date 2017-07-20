# Compute offsets for a regression predictor to miminize QWK

This script computes a set of offsets to the batch predictions made by a 
predictor to increase the quadratically weighted kappa (QWK) statistic
for the data set.

## Overview

The QWK statistic for a dataset with a multi-category objective compares 
ground truth to results produced by a learned predictor relative to
chance agreement.  The version implemented by this script does not
maximize the QWK statistic, but increases it as much as possible subject
to constraints imposed by the BigML platform and the Whizzml scripting
facility.

In brief, the algorithm:

- Partitions the batch prediction dataset into a user-specified
  number of sub-datasets for each (integer) step of the objective.
- For each sub-dataset determines the offset from the predicted
  value to the value that most increases QWK for the dataset.
- Returns the table of offsets to be used by the script
  for offsetting batch predictions made with the predictor. 

## The **inputs** for the script are:

* `dataset`: (dataset-id) Prediction dataset from which to derive offsets
* `objective-field`: (string) Objective name or id, or blank to use the 
                              dataset's default
* `prediction-field`: (string) Prediction name or id, or blank to use 
                               "Prediction" as default
* `total-sub-bins`: (numeric) Number of sub-bins per bin of the offset table
* `delete-ds`: (boolean) If true, clean up datasets created during analysis
* `optimize`: (boolean) If true, derive offsets

The script returns a map of offset information derived from the training
dataset.

## Routines

The script consists of four sets of routines

### BigML utilities

This is a small collection of functions from the 
[repair-missing](../../repair-missing) script by Charles Parker.

* `id-from-fields`: Retrieves ID of a field given its name
* `get-objective`: Resolves the objective field ID given the input
* `get-bad-fields`: Find fields that are missing data
* `filter-missing`: Compose a dataset containing only rows for which 
                    the specified field ID isn't missing
* `filter-not-missing`: Compose a dataset containing only rows for 
                        which the specified field ID is missing

### Array math utilties

Although WhizzML is a complete functional programming language, it
does not include data elements or operations for array operations.
In addition, the preferred form of arrays for this type of computation
are vectors and matrices of items representing 2-D and 3-D functions.

This script provides a library of array routines structured for their
explanatory value rather than for their performance. Because the
vectors and matrices are small, the performance is adequate for this
application.

* `reduce-array`: A core routine that sorts array elements into groups
                  with matching indices and then returns a single 
                  element for each group whose value is the sum of all
                  the values in the group.
* `row-sums`: Sum across the rows of a matrix.
* `column-sums`: Sum across the columns of a matrix.
* `matrix-sum`: Sum all elements in a matrix.
* `vector-sum`: Sum all elements in a vector.
* `compute-w`: Compute the quadratically-weighted kappa weight matrix.
* `outer-product`: Compute the outer product of a column and row vectors.
* `combine-arrays`: Combines two arrays on an elementwise basis.
* `frobenius-product`: Inner product of two matrices treated as vectors.
* `get-column`: Get a column as a vector from a matrix.
* `multiply-array`: Multiply an array by a constant.
* `change-columns`: Change the column index of a column in a matrix.

### QWK computations

These are the routines that do the QWK minimization. The computation
actually minimizes the complement QWK' = 1-QWK rather than directly 
maximizing QWK.

* `bound-matrix`: Cleans up a raw contingency matrix to produce a
                  final contingency matrix.
* `expected-value-marix`: Computes the expected value in the denominator
                          of the kappa statistic complement.
* `compute-kappa-parts`: Computes the numerator and denominator parts of
                         the quadratic weighted kappa statistic (actually
                         the complement value).
* `compute-kappa-offset`: Compute the offset values and kappa value when
                          a given column is relocated to a new column.
* `compute-offsets`: Computes the table of optimal offsets for the columns
                     in a contingency matrix.
* `quadratically-weighted-kappa`: Computes the complement of the 
                                  quadratically weighted kappa statistic
                                  for a contingency matrix in reduced form.
* `extract-offsets`: Extracts just the offset table from the map returned
                     by the contingency table optimization function.
* `offset-contingency-matrix`: Applies offsets to contingency matrix columns.
* `optimize-contingency-matrix`: Optimize a raw contingency matrix under the
                                 QWK statistic.


### Dataset processing routines

This final set of routines are the top level operations for processing a
dataset to derive an table of prediction offsets to maximize the QWK
statistic.

* `get-field`: Resolves field ID for a field name string.
* `get-dataset-parameters`: Get the relevant parameters for the dataset.
* `get-range`: Get the range for a field in the dataset.
* `filter-bin`: Filters out one sub-bin from the dataset.
* `create-partition`: Creates a partition of dataset.
* `build-partitions`: Build the partitions of a dataset.
* `extract-contingency-matrix`: Extracts a contingency matrix from the
                                list of metadata from a list of partitions.
* `clean-up`: Clean-up the BigML desktop.
* `fit-offset-corrections`: Sequence estimation of the optimized contingency matrix.

## Installation

Please see [the top-level readme](../../readme.md) for detailed installation
instructions.
 


