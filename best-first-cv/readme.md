# Best-first feature selection for classifications with cross-validation

Script to select the `n` best features for modeling a given dataset,
using a greedy algorithm. It only works for classification problems,
i.e., this script needs a categorical objective field.

The script takes as inputs: 
- **dataset-id**: the dataset to use 
- **max-n**: the number of maximum features (that is, dataset fields)
to return. It also takes into account the pre-selected features. The
number of features to be returned can be lower due to the early stop.
- **objective-id**: the objective field (target). It needs to be
categorical. 
- **options**: the configuration options for the models
- **k-folds**: the number of k-folds to use in the cross-validation
- **pre-selected-fields**: the subset of pre-selected best-first features
that will be used from the beginning in `S` (see algorithm description
below).
- **early-stop-performance**: an early-stop-performance improvement
value (in %) used as a threshold to consider if a new feature has a
better performance compared to previous iterations.
- **max-low-perf-iterations**: the maximum number of consecutive
iterations allowed that may have a lower performance than the
early-stop performance set. It needs to be set as percentage of the
initial number of features in the dataset.

How the greedy algorithm works:
- The algorithm initializes the set of `S` features taking into
account the pre-selected best features from the dataset-id selected as
input. If there are not pre-selected features, `S` will be empty.
- For each iteration: 
  - For each feature `f` in the dataset-id selected as input that is not
in `S`, it trains a model with feature set `S + f`. By default, the
algorithm builds decision trees, however you can select another
algorithms and its parametrization by configuring the options. For
example, if you set `{"number_of_models": 40}` ensembles with 40 models
will be trained at each iteration.
  - Then each model built with the feature set `S + f` is evaluated
using k-fold cross-validation. 
  - The algorithm greedily selects the feature `f'` with the best
performance using the metric `average_phi` minus the standard deviation
(derived from the cross-validation) to use the worst case as metric of
performance.
  - If the feature `f'` improves the performance of the last
iteration, i.e. if the improvement is higher than the % set as the
early-stop-performance, it is added it to `S`.
  - If the feature `f'` have not improved the performance of the model,
i.e. the improvement is lower than the percentage set as
`early-stop-performance`, after a certain number of iterations (set by
`max-low-perf-iterations`) , the execution will stop. 

Script outputs:
- **output-features**: A map with two main keys:
  - selected-fields: Selected features names
  - iterations-info: List of maps with the following information for
    each iteration:
    - phi-score
    - standard deviation
    - (phi - standard deviation) metric
    - features used in the model
- **output-dataset**: the dataset with the selected features.
