# unsupervised-generation: Generating unsupervised models from datasets

This script is the first step for **Automated Feature Generation**.

It will generate some **unsupervised models** from your training
dataset. After executing it, you will have to pass its `execution-id`
to the [feature-generation script](../feature-generation) to generate
a dataset with the new features that come from scoring the datasets
with the created unsupervised models.

**NOTE**: This script is one part of the [**BigML
AutoML**](../readme.md). The easiest way of executing all the scripts
from `BigML AutoML` is using the
[orchestrator](../automl-orchestrator/readme.md)

The generated unsupervised models are:

* `Cluster`
* `Anomaly detector`
* `Association discovery using leverage as search strategy`
* `Association discovery using lift as search strategy`
* `Topic model`
* `PCA`

The user can configure the options of the generated unsupervised
models or he can leave the inputs blank for using default unsupervised
models. All the possible **configuration parameters** for each kind of
model can be found in the [API docs](https://bigml.com/api).

The **inputs** for the script are:

* `dataset`: (dataset-id) Origin dataset id for the creation of the models
* `exclude-objective`: (boolean) Whether to exclude the objective field from the models input fields. **Optional** True by default
* `cluster-params`: (map) Params of the cluster model. Leave blank for default 1-Click cluster. **Optional**
* `association-params`: (map) Params of the association discovery model. If association-params is not passed to the script, an association discovery with the `objective-id` as **Consequent** will be created. **Optional**
* `anomaly-params`: (map) Params of the anomaly detector. Leave blank for default 1-Click anomaly detector. **Optional**
* `topic-params`: (map) Params of the topic model. Leave blank for default 1-Click topic model. **Optional**
* `pca-params`: (map) Params of the PCA model. Leave blank for default 1-Click PCA. **Optional**

The **outputs** for the script are:
* `cluster-id`: (cluster-id) Generated cluster
* `association-leverage-id`: (association-id) Generated association discovery with *leverage* as `search strategy`
* `association-lift-id`: (association-id) Generated association discovery with *lift* as `search strategy`
* `anomaly-id`: (anomaly-id) Generated anomaly detector
* `topicmodel-id`: (topicmodel-id) Generated topic model
* `pca-id`: (pca-id) Generated PCA
