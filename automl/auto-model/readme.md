# auto-model: Automated Model Selection

This script performs **Automated Model Selection**. It creates an
`OptiML` resource with the given `train-dataset`. Then, it uses the
**top `num-of-models` models from the `OptiML`** (where
`num-of-models` is an input param) to create a `Fusion`. From this
`Fusion` and the `test-dataset`, it creates a `batch prediction` and
its corresponding output dataset with the predictions. If a
`validation-dataset` is given, the script will return also an
`evaluation` of the `Fusion` model with this dataset.

If a `validation-dataset` is given, it will be used by the `OptiML` to
evaluate all the possible models. It it is not given, the `OptiML`
will evaluate the models with **Cross Validation** from the
`train-dataset`.

**NOTE**: This script is one part of the [**BigML
AutoML**](../readme.md). The easiest way of executing all the scripts
from `BigML AutoML` is using the
[orchestrator](../automl-orchestrator/readme.md)

**NOTE**: As the creation of the `OptiML` is very computationally
expensive, the execution of this script can take some minutes (or even
hours) to complete

The **inputs** for the script are:

* `train-dataset`: (dataset-id) Train dataset. **Optional** (if it is
  not given, an `optiml-id` must be specified)
* `validation-dataset`: (dataset-id) Validation dataset. **Optional**
* `test-dataset`: (dataset-id) Test dataset. **Optional**
* `optiml-id`: (optiml-id) OptiML from previous executions, to bypass
  the creation of the resource. **Optional** (if it is not given, a
  `train-dataset` must be specified**)
* `num-of-models`: (number) Number of models to include in the
  `Fusion` **Optional** (default: 5)

If you already have a previously created `OptiML`, and you only want
to create the `Fusion` and the predictions with a new `test-dataset`,
you can pass the `optiml-id` to the script and it will bypass the
creation of the `OptiML`.

The **outputs** for the script are:
* `output-dataset`: (dataset-id) Dataset with the final predictions
* `output-optiml-id`: (optiml-id)  OptiML from the given dataset
* `output-fusion-id`: (fusion-id) Fusion model created from the top
  models of the OptiML
* `evaluation-id`: (evaluation-id) Evaluation of the `Fusion` model
  using the `validation-dataset`
