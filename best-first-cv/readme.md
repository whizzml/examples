# Best-first feature selection for classifications with cross-validation

Script to select the `n` best features for modeling a given dataset,
using a greedy algorithm:

- Initialize the set `S` of selected features to the empty set

- Split your dataset into training and test sets

- For `i` in `1 ... n`:
  - For each feature `f` not in `S`, model and evaluate with feature
    set `S + f`
  - Greedily select the feature `f'` with the best performance and add
    it to S

The script takes as inputs the dataset to use and the number of
features (that is, dataset fields) to return and yields as output a
list of the `n` selected features, as field identifiers.

To select the best performance, the script uses the metric
`average_phi` in the evaluations it performs, which is only available
for classification problems.  Therefore, the script is only valid for
categorical objective fields.

You can set the configuration for the model to be used in the analysis in the
`options` variable. For instance, if you set {"number_of_models": 2} an
ensemble will be used.
