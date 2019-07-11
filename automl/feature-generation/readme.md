# feature-generation: Generating new dataset features

This script is the second step for **Automated Feature Generation**.

To run this script, you should have executed previously the
[unsupervised-generation](../unsupervised-generation) script.

The script **extends two given train and test datasets** with new
features that comes from **scoring with some unsupervised models**
created previously.

**NOTE**: This script is one part of the [**BigML
AutoML**](../readme.md). The easiest way of executing all the scripts
from `BigML AutoML` is using the
[orchestrator](../automl-orchestrator/readme.md)

Currently, the generated fields come from:

* `Batch centroid (Cluster)`
* `Batch anomaly score (Anomaly Detection)`
* `Batch association sets (Association Discovery)`
* `Batch topic distribution (Topic Model)`
* `Batch projection (PCA)`

The **inputs** for the script are:

* `train-dataset`: (string) Dataset ID for the train dataset to be extended. (e.g. dataset/5d267a147811dd0726000fdd)
* `test-dataset`: (string) Dataset ID for the test dataset to be extended. (e.g. dataset/5d267a147811dd0726000fdd)
* `unsupervised-generation-exec`: (execution-id) Execution of the
  [unsupervised-generation](../unsupervised-generation) script. (e.g. execution/4fg56h147811dd0726000a3v)

As you can see, `train-dataset` and `test-dataset` are **text** fields
instead **dataset-id** fields. You can pass to the script only train
or test dataset and leave the other input blank.

The **outputs** for the script are:
* `extended-train-dataset`: (dataset-id) Dataset ID for the extended train dataset
* `extended-test-dataset`: (dataset-id) Dataset ID for the extended test dataset

After adding new features to your dataset, you can choose between
running the [Automated Feature Selection](../feature-selection) or
directly passing your datasets to the [Automated Model
Selection](../auto-model). This is done, automatically, by the
[orchestrator](../automl-orchestrator/readme.md).
