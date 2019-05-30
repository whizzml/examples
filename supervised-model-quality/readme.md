# Supervised model quality

In this package you'll find a script that generates an evaluation from
an existing model by retrieving the dataset used for training and doing
an 80%-20% split of the data. The output of the script is a map with the
information needed to build a report about the estimated quality for the model.

The **inputs** for the script are:

* `resource-id`: (resource-id) Resource ID for the model to be analyzed

The **outputs** for the script are:
* `quality-info`: (map) Information to estimate the quality of the model:
  - `fields`: Fields structrue information
  - `rows`: Number of rows used in training
  - `model`: Model reference information
  - `model_fields`: Fields used in the model (when different from `fields`)
  - `evaluation`: Information about the model estimated performance
