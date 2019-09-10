# Library of functions for k-fold cross-validation

The objective of this library is to provide auxiliar procedures to
execute a k-fold cross validation of any classification model
built from a dataset. The algorithm:

- Divides the dataset in k parts
- Holds out the data in one of the parts and builds a logistic regression
  with the rest of data
- Evaluates the deepnet with the hold out data
- The second and third steps are repeated with each of the k parts, so that
  k evaluations are generated
- Finally, the evaluation metrics are averaged to provide the cross-validation
  metrics.
