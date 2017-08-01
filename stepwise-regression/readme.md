# Forward stepwise regression

Script to select the best features for creating a logistic regression,
using a greedy algorithm:

- Initialize the set `S` of selected features to the empty set
- Split the dataset into a test and training set.
- For each feature `f` not in `S`, model and evaluate with feature
  set `S + f`
- Greedily select the feature `f'` with the best performance and add
  it to S

The script takes as inputs the dataset to use and some threshold
number `d` (zero by default). If the performance is not improved by at
least `d`, then no new feature is added and the output is returned. For
example, if an improvement of 1% is desired, the threshold should be
0.01. The output is a list of the selected features, as field
identifiers.

To select the best performance, the script uses the metric
`average_f_measure` in the evaluations it performs.
