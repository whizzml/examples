# Making predictions using Cluster models

In this library you will find a couple of functions that take as input
an execution of the
[*Create cluster models* script](../create-cluster-models), and uses
the execution outputs to find out what cluster and model clusters to
perform a prediction on a new input row, or a batchprediction on a
full dataset.

The entry points for this library are thus `predict-by-cluster` and
`batch-predict-by-cluster`.  A script using this library and
performing a prediction on a single input map would be as simple as:

```
    (define result (predict-by-cluster execution-id input-data))
```

and the code for a batch predictor taking as input a full dataset
would read:

```
    (define result (batchpredict-by-cluster execution-id dataset-id))
```


The above scripts are defined, for your convenience, in
[single-prediction](../single-prediction) and
[batch-prediction](../batch-prediction).
