# AutoML Script

These WhizzML scripts will let the user run a **fully automated
Machine Learning pipeline** in BigML.

![BigML AutoML Steps](../res/steps.png)

From a train, validation and test datasets, the following tasks will be
automatically done:

-  `Unsupervised Models Generation`: Creating the following
  **unsupervised models**: `Cluster`, `Anomaly Detector`, `Association
  Discovery` (with lift and leverage as search_strategy), `PCA` and
  `Topic Model` (when there are text models in the dataset).
-  `Feature Generation`: Using the unsupervised models created
  previously for scoring the datasets and **generating, automatically,
  new features** for train, validation and test datasets
-  `Feature Selection`: Reducing, automatically, the number of fields
  of the datasets using the **Recursive Feature Eliminination**
  algorithm.
-  `Model Selection` Using OptiML to find the best models and using
  the top 5 models to create a `Fusion` model to predict all the test
  dataset instances. If a validation dataset is given, this script
  will return an evaluation of the final model too.


The **inputs** for the script are:

* `train-dataset`: (string) Dataset id for the train dataset
  (e.g. dataset/5d272205eba31d61920005cd). If you don't provide a
  train dataset, the script will reuse the models created in the
  provided `automl-execution`.
* `validation-dataset`: (string) Dataset id for the validation dataset
  (e.g. dataset/5d272205eba31d61920005cd). You can leave blank this
  input and the script won't return an `output-evaluation`.
* `test-dataset`: (string) Dataset id for the test dataset
  (e.g. dataset/7j272205eba31d61920005vf). You can leave blank this
  input and the script won't return an `output-dataset`.
* `automl-exection`: (string) Previous execution of this script, to
  reuse created executions and models,
  e.g. execution/5d272205eba31d61920005cd. If you don't provide a
  `train-dataset` you must provide an `automl-exection`. If both are
  provided, the script will generate new resources instead reusing
  them.
* `excluded-fields`: (list) List of field names to exclude from
  e.g. ["bmi", "age"]. Empty by default

The **outputs** for the script are:
* `output-dataset`: (dataset-id) Dataset with final predictions for the test dataset
* `output-evaluation`: (evaluation-id) Evaluation of the `Fusion`
  model using the `validation-dataset`
* `output-fusion`: (fusion-id) Output fusion model
* `selected-fields`: (list) Selected important field names
* `unsupervised-models`: (list) List of unsupervised models created
  from train-dataset

## Usage
There are two different ways of using this script:

### From a train and a test dataset (and an optional validation dataset)
In this case, we should pass to the script the `train-dataset` and the
`test-dataset`, and we will left blank the `automl-execution` input.
Remember to set previously the correct **objective field** in your
train and test datasets.

The script will run the full **automated Machine Learning pipeline**
and it will return, at the end of the process, the
**predictions-dataset** with the final predictions for the test
dataset using a `Fusion` with the best models from the created
`OptiML`.

If a validation dataset is given, the script will also return an
`evaluation` of the final `Fusion` model with the
`validation-dataset`.

### From a test dataset and a previous execution id
If we executed previously the orchestrator with a given train dataset
and, after some time, we have new data to predict, we don't need to
run all the automated Machine Learning pipeline again.

We can pass to the script the new `test-dataset` and the the last
execution orchestrator script id in the `automl-execution` input. We
will left `train-dataset` input blank. Remember to set previously the
correct **objective field** in your test datasets.

In this case, some steps of the process will be bypassed. The script
won't generate neither a new `OptiML` nor a **Recursive Feature
Selection** execution.

## FAQ
### Why can't I see in, in the scripts inputs in the BigML's dashboard, dropdowns menus to select the dataset, script, etc?
All the input parameters of these scripts are optional. So, they use a
**string** input type instead a `dataset-id` input type,
`execution-id` input type, etc. Using a **string** input type we can
provide a **default blank value** if the user don't want to pass one
input.
