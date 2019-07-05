# Unsupervised models generation

This script is the first step for automated feature generation. It
will generate some unsupervised models from your training
dataset. After executing it, you will have to pass its execution-id to
the feature-generation script to generate a new dataset with the new
features.

The generated unsupervised models are:

* Cluster
* Anomaly detector
* Association discovery
* Topic model
* PCA

The user can configure the options of the generated unsupervised
models, or he can leave the inputs blank for using default
unsupervised models.

The **inputs** for the script are:

* `train-dataset`: (dataset-id) Dataset ID for the train dataset to be extended
* `cluster-params`: (map) **optional** Params of the cluster model. Leave blank for default 1-Click cluster
* `association-params`: (map) **optional** Params of the association discovery model. If association-params is not passed to the script, an association discovery with the `objective-id` as **Consequent** will be created.
* `anomaly-params`: (map) **optional** Params of the anomaly detector. Leave blank for default 1-Click anomaly detector
* `topic-params`: (map) **optional** Params of the topic model. Leave blank for default 1-Click topic model
* `pca-params`: (map) **optional** Params of the PCA model. Leave blank for default 1-Click PCA

The **outputs** for the script are:
* `cluster-id`: (cluster-id) Generated cluster
* `association-id`: (association-id) Generated association discovery
* `anomaly-id`: (anomaly-id) Generated anomaly detector
* `topicmodel-id`: (topicmodel-id) Generated topic model
* `pca-id`: (pca-id) Generated PCA
