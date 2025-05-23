# Script for purged k-fold cross-validation

The objective of this script is create a purged k-fold cross validation
starting form any classification model
built from a time-series kind of dataset that has been previously ordered.

The algorithm:

- Divides the dataset in k parts
- Holds out the data in one of the parts and builds the same supervised model
  used as input with the rest of data
- Creates a test dataset by purging its edges (15% of the hold out data) to
  avoid leakage.
- Evaluates the model with the test data
- The second, third and fourth steps are repeated with each of the k parts,
  so that k evaluations are generated
- Finally, the evaluation metrics are averaged to provide the cross-validation
  metrics.
