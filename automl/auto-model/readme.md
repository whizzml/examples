# auto-model: Automated Model Selection

This script performs **Automated Model Selection**. For it, it creates
an `OptiML` resource with the given dataset. Then, it uses the **top 5
models of the `OptiML`** to create a `Fusion`, and from this `Fusion`
and the `test-dataset`, it creates a `batch prediction` and its
corresponding output dataset with the predictions.

**NOTE**: This script is one part of the [**BigML
AutoML**](../readme.md). The easiest way of executing all the scripts
from `BigML AutoML` is using the
[orchestrator](../automl-orchestrator/readme.md)

**NOTE**: As the creation of the `OptiML` is very computationally
expensive, the execution of this script can take some minutes (or even
hours) to complete

The **inputs** for the script are:

* `train-ds`: (dataset-id) Train dataset
* `test-ds`: (dataset-id) Test dataset
* `optiml-id`: (optiml-id) OptiML from previous executions (to bypass the creation of the resource)

If you already have a previously created `OptiML`, and you only want to
create the `Fusion` and the predictions with a new **test dataset**, you can
pass the `optiml-id` to the script and it will bypass the creation of
the `OptiML`.


The **outputs** for the script are:
* `output-dataset`: (dataset-id) Dataset with the final predictions
* `optiml-id`: (optiml-id)  OptiML from the given dataset
