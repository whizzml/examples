# Batch Explanations

This script is a way to perform multiple predictions with
explanations, somewhat similarly to the batchprediction resource. It
is slower than our usual batchpredictions, and as it uses the sample
server, it can break for very wide datasets.

Given a dataset of points to be predicted and a model id, it creates a
prediction (with explanations) from the model for every instance in
the dataset. Returns a list of prediction resources.

# Inputs

- A dataset of instances to be predicted

- A previously trained model to predict with

# Outputs

- A list of prediction resource ids
