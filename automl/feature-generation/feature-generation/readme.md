# Feature Generation

This script is the second step for automated feature generation. To
use it, you should have executed previously the [unsupervised models
generation](../unsupervised-models) script

This script extends a given dataset with new features that comes from
applying unsupervised models. Currently, the generated fields come
from:

* cluster batch centroid
* anomaly score
* association rules
* topic distribution
* PCA batch projection

The **inputs** for the script are:

* `dataset-id`: (dataset-id) Dataset ID for the train dataset to be extended
* `unsupervised-gen-execution`: (execution-id) Execution of the unsupervised model generator script

The **outputs** for the script are:
* `extended-dataset`: (dataset-id) Dataset ID for the extended dataset
