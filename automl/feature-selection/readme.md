# feature-selection: Obtaining the most important features

This scripts performs **Automated Feature Selection**. It filters out
the most important fields from a train, validation and test
datasets. The script uses [Recursive Feature Elimination
(RFE)](../../recursive-feature-elimination) script. RFE removes,
iteratively, the least important fields from a dataset until there is
only one field left. Furthermore, on each iteration, it performs an
evaluation. Analyzing the evaluations, this script is able to obtain
the **optimal number of features** and filter them out.

**NOTE**: This script is one part of the [**BigML
AutoML**](../readme.md). The easiest way of executing all the scripts
from `BigML AutoML` is using the
[orchestrator](../automl-orchestrator/readme.md)


The **inputs** for the script are:

* `train-dataset`: (string) Train dataset to filter (e.g. dataset/5d272205eba31d61920005cd) **Optional** (if it is not given, `pre-selected-fields` must be specified)
* `validation-dataset`: (string) Validation dataset to filter (e.g. dataset/5d272205eba31d61920005cd). **Optional**
* `test-dataset`: (string) Test dataset to filter (e.g. dataset/5d272205eba31d61920005cd) **Optional**
* `rfe-script-id`: (script-id) Script id of the [Recursive Feature
Elimination](../../recursive-feature-elimination) Whizzml script.
* `pre-selected-fields`: (list) List of the pre-selected field ids, to
bypass RFE. Leave blank to run RFE and obtain, from it, the most
important fields. **Optional** (if it is not give, `train-dataset`
must be specified).

If you already have the important field ids from your dataset, you can
directly filter them out from the dataset using the
**pre-selected-fields** input. In this case, Recursive Feature
Elimination won't be executed, and you can omit (if you want) the
`train-dataset` input.

Remember to set previously the correct **objective field** in your
train, validation and test datasets.

The **outputs** for the script are:
* `filtered-train-dataset`: (dataset-id) Filtered train dataset with only the important fields
* `filtered-validation-dataset`: (dataset-id) Filtered validation dataset with only the important fields
* `filtered-test-dataset`: (dataset-id) Filtered test dataset with only the important fields
* `selected-fields`: (list)  List of the selected field ids


After removing unimportant fields you will need to pass the generated
datasets to [Automated Model Selection](../auto-model). This is done,
automatically, by the [orchestrator](../automl-orchestrator/readme.md).
