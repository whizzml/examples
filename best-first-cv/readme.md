# Best-first feature selection for classifications with cross-validation

Script to select the `n` best features for modeling a given dataset,
using a greedy algorithm:

- Initialize the set `S` of selected features to the empty set
- For `i` in `1 ... n`:
  - For each feature `f` not in `S`, model and evaluate (with cross-validation)
    with feature set `S + f`
  - Greedily select the feature `f'` with the best performance and add
    it to `S`

If last features have not improved the performance of the model during a 
certain number of iterations, it will stop the execution.


The script takes as inputs

- the dataset to use
- the number of features (that is, dataset fields) to return
- the objective field (target)
- the configuration options for the models
- the number of k-folds to use in the cross-validation
- the subset of pre-selected features that will be used to append any other
  available feature
- an early-stop-performance improvement value (in %) used as a threshold
  to consider good performance of a feature
- the maximum number of iterations with bad performance allowed (as
  percentage of the initial number of features)

and yields as output a
list of the `n` (or lower if the algorithm stops due to bad performance) 
selected features, as field identifiers plus their names and the subsets 
and evaluations for each iteration step.

To select the best performance, the script uses the metric
`average_phi` in the evaluations it performs, which is only available
for classification problems.  Therefore, the script is only valid for
categorical objective fields. 

In cross-validation, the standard deviation is substracted to the average 
of all `average_phi` to use the *worst case* as metric of
performance. 

You can set the configuration for the model to be used in the analysis in the
`options` variable. For instance, if you set {"number_of_models": 2} an
ensemble will be used.
