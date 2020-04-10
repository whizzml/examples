# AutoML Script

These WhizzML scripts will let the user run a **fully automated
Machine Learning pipeline** in BigML.

![BigML AutoML Steps](../res/steps.png)

From a train, holdout and test datasets, the following tasks will
be automatically done:

-  `Unsupervised Models Generation`: Creating the following
  **unsupervised models**: `Cluster`, `Anomaly Detector`, `Association
  Discovery` (with leverage and lift as search_strategy), `PCA` and
  `Topic Model` (for datasets that contain text fields).
-  `Feature Generation`: Using the unsupervised models created
  previously to append automatically generated new features to all the
  user given datasets.
- `Feature Selection`: Reducing, automatically, the number of fields
  of the datasets using the **Recursive Feature Eliminination**
  algorithm. This step is bypassed if the total number of fields is
  lower than 50 (or 30 if `shallow_search` is `True`)
-  `Model Selection` Using OptiML to find the best models and using
  the top 3 models to create a `Fusion` model to predict all the test
  dataset instances. The script will return an evaluation of the final
  model too.


The **inputs** for the script are:

* `train-dataset`: (dataset-id) Dataset id for the train dataset
  (e.g. dataset/5d272205eba31d61920005cd). If no train dataset is
  provided, the script will expect an `automl-execution` and will use
  its models as starting point. Useful when we only want to perform
  scoring , using  a previous execution of AutoML.
* `holdout-dataset`: (dataset-id) Dataset id for the holdout dataset
  (e.g. dataset/5d272205ea31d61920005cd). It will be used **only at
  the end of the workflow** after the model has been trained, to
  evaluate the final model. If empty, some random rows from the
  `train-dataset` will be set aside and used as `holdout-dataset`. The
  parameter `holdout-rate` indicates the portion of the
  `train-dataset` that is sampled in the `holdout-dataset`
* `test-dataset`: (dataset-id) Dataset id for the test dataset
  (e.g. dataset/7j272205eba31d61920005vf). AutoML will create a batch
  prediction with this dataset at the end of the workflow. It won't be
  used during previouse stages. If empty, no output-dataset
  is returned.
* `automl-exection`: (execution-id) Previous execution of this script, to
  reuse created executions and models,
  e.g. execution/5d272205eba31d61920005cd. Either `train-dataset` or
  `automl-execution` should be provided for the script to work. When
  both are provided, the `automl-execution` argument is discarded and
  new resources are generated from the training data.
* `shallow-search`: (boolean) If true, AutoML will perform a more
  shallow (but faster) search of the best features and models. A
  ramdomly sampled dataset will be used in some stages of the process,
  only one association discovery will be created (with lift metric),
  the objective number of features to obtain from the feature
  selection process will be fixed to 30 and the maximum training time
  of the OptiML will be more limited. Default value is `True`.
* `configuration-params`: (map) Execution configuration
  parameters. They will be overwritten if automl-execution is
  given. The following values must be provided:
  * `excluded-fields`: (list) List of fields that will be excluded
    from any dataset before any other process starts. e.g. ["bmi",
    "age"]. Empty by default.
  * `excluded-models`: (list) List of unsupervised models that won't
    be created nor reused during feature generation. e.g. ["anomaly",
    "cluster"]. Possible values are: association, cluster, anomaly, pca
    or topicmodel. Empty by default
  * `pca-variance-threshold`: (number) The PCA projection uses the
    minimum number of components such that the cumulative explained
    variance is greater than the given threshold. Values from 0 to 1. A
    value of 1 means all the components will be used. Default value is
    0.8.
  * `max-association-rules`: (integer) Maximum number of association
    rules that should be included in the extended datasets for each
    association discovery created. Default value is 10. Please, note
    that the final number of association rules in the extended
    datasets can be higher than this value if more than one
    association discovery is created.
  * `holdout-rate`: (number) The portion of the `train-dataset`
    that is sampled in the `holdout-dataset`. Values from 0 to 0.5.
    This is used only if a `holdout-dataset` is not provided by the
    user. If `holdout-rate` is 0, the `holdout-dataset` won't be
    created. 0.2 by default (20% of the rows).
  * `balance-objective`: (boolean) Whether to balance classes
    proportionally to their category counts or not (during the
    creation of models). False by default.
  * `models-configuration`:  (map) Configuration parameters for the models
    created by AutoML. They won't be used if `automl-execution` is
    given. The following keys are accepted: `cluster`, `anomaly`,
    `association`, `pca`, `topicmodel`, `optiml`.
    E.g. `{"cluster": {"critical_value": 4},
           "anomaly": {"forest_size": 256},
           "optiml": {"number_of_model_candidates": 64}}`

**WARNING** To avoid confusion, `configuration-params` are always
overwritten by the corresponding input in `automl-execution` if this
is given.

**WARNING** All the fields that appear as `non-preferred` in train,
holdout or test datasets will be considered `non-preferred` in all
the resources created by AutoML. It doesn't matter in which dataset
(train, holdout or test) they are set as non-preferred fields.

**WARNING** In order to know your AutoML model performance, you should
use the final evaluation returned by this script. You shouldn't use
the evaluations created by the OptiML because they are not evaluating
the final **Fusion** model and because Cross Evaluation method can
return overoptimistic results in some situations. To avoid any kind of
leakage, Feature Selection and Model Selection steps will use
different validation datasets, both obtained from the training
one. The data used as validation for OptiML, won't have been used
during feature selection.

The **outputs** for the script are:
* `output-dataset`: (dataset-id) Dataset with final predictions for the test dataset
* `output-evaluation`: (evaluation-id) Evaluation of the `Fusion`
  model using the `holdout-dataset`
* `output-fusion`: (fusion-id) Output fusion model
* `selected-fields`: (list) Selected important field names
* `unsupervised-models`: (list) List of unsupervised models created
  from train-dataset

## Usage
There are two different ways of using this script:

### From a train and a test dataset (and an optional holdout dataset)
In this case, the expected inputs for the script are the
`train-dataset` and the `test-dataset`, with no `autml-execution`
input.  The objective field used in the script will be the one
associated to the datasets used, so remember to choose them previously
in both the training and holdout datasets.

The script will run the fully **automated Machine Learning pipeline**
and it will return, at the end of the process, the **output-dataset**
with the final predictions for the test dataset using a `Fusion` with
the best models from the created `OptiML`.

If a holdout dataset is given, the script will also return an
`evaluation` of the final `Fusion` model with the
`holdout-dataset`. If no `holdout-dataset` is given, but
`holdout-rate` is greater than 0, a subset of the original
`train-dataset` not used in any part of the process will be used to
generate this final `evaluation`.

### From a test dataset and a previous execution id (and an optional holdout dataset)
If we want to predict new data using the same models created by a
previously executed `automl` script, you can use the `automl-execution`
parameter (no `train-dataset` parameter needed) associated to that
previous execution and provide the test dataset ID in the
`test-dataset` parameter.

In this case, some steps of the process will be bypassed. The script
won't generate neither a new `OptiML`, unsupervised model nor a
**Recursive Feature Selection** execution.
