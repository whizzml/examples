# Recursive Feature Elimination
Script to select the `n` best features for modeling a given dataset, 
using a recursive algorithm:



- Initialize the set `S` of selected features to the full initial 
dataset
- Initialize `c` as the current number of features in `S`
- While `c` is greater than `n`:
  - Create random forest with features of `S`
  - Obtain importances from random forest
  - Remove from `S` the least important feature
  - If test-dataset is defined, evaluate the random forest
  - Update `c` with current number of features

The script takes as inputs:
  - the dataset to use
  - the number of features (that is, dataset fields) to return
  - the objective field (target)
  - the test dataset that should be used in the evaluation 
    If it is not given, the script won't perform evaluations.
  - the metric that we want to use for the evaluations
    - Possible metrics: accuracy, average_f_measure, 
    average_phi, average_precision, and average_recall 

and yields as output:
- The dataset with the selected fields
- Information about the features selected and the evaluation on 
  each iteration (only if test-dataset id given)

One common approach is to execute the script with a very low `n`.
In this way, observing the evaluation info, we will be able to guess
the optimal number of features.

**References**:  
- Guyon, I., Weston, J., Barnhill, S., & Vapnik, V., 
"Gene selection for cancer classification using support vector machines", 
Mach. Learn., 46(1-3), 389--422, 2002.