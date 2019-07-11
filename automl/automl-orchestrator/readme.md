# automl-orchestrator: Orchestrating AutoML execution

This script coordinates the execution of all the AutoML scripts.  This
is **the only script that you will need to execute**. It will execute,
in the correct order, the other scripts to perform all the tasks
explained in the [main readme](../readme.md)

![orchestrator](https://cdn.pixabay.com/photo/2018/02/23/22/33/isolated-3176853_960_720.jpg)

The **inputs** for the script are:

* `train-dataset`: (string) Dataset id for the train dataset (e.g. dataset/5d272205eba31d61920005cd)
* `test-dataset`: (string) Dataset id for the test dataset (e.g. dataset/7j272205eba31d61920005vf)
* `orchestrator-exec`: (string) Previous execution of this script, to reuse created executions and models, e.g. execution/5d272205eba31d61920005cd

The **outputs** for the script are:
* `predictions-dataset`: (dataset-id) Dataset with final predictions for the test dataset
* `unsupervised-generation-exec`: (execution-id) Execution id of the unsupervised-generation script
* `feature-generation-exec`: (execution-id) Execution id of the feature-generation script
* `feature-selection-exec`: (execution-id) Execution id of the feature-selection script
* `auto-model-exec`: (execution-id) Execution id of the auto-model script


## Usage
There are two different ways of using this script:

### From a train and a test dataset
In this case, we should pass to the script the `train-dataset` and the
`test-dataset`, and we will left blank the `orchestrator-exec` input.

The script will run the full **automated Machine Learning pipeline**
and it will return, at the end of the process, the
**predictions-dataset** with the final predictions for the test
dataset using a `Fusion` with the best models from the created
`OptiML`.

### From a test dataset and a previous execution id
If we executed previously the orchestrator with a given train dataset
and, after some time, we have new data to predict, we don't need to
run all the automated Machine Learning pipeline again.

We can pass to the script the new `test-dataset` and the the last
execution orchestrator script id in the `orchestrator-exec` input. We
will left `train-dataset` input blank.

In this case, some steps of the process will be bypassed. The script
won't generate neither a new `OptiML` nor a **Recursive Feature
Selection** execution.
