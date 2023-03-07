# WhizzML: 101 - Using an Anomaly Detector

Following the schema described in the prediction workflow
document, this is the code snippet that shows the minimal workflow to
create an Anomaly Detector to produce a single Anomaly Score.


```
    ;; step 0: creating a source from the data in your remote "https://static.bigml.com/csv/iris.csv" file
    (define source-id (create-source {"remote" "https://static.bigml.com/csv/iris.csv"}))
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source`
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating an anomaly detector
    (define anomaly-id (create-anomaly dataset-id))
    (log-info "Creating anomaly detector from dataset: " anomaly-id)
    ;; the new input data to score
    (define input-data {"petal width" 1.75
                        "petal length" 2.45})
    ;; creating a single score
    (define score-id (create-anomalyscore anomaly-id
                                          {"input_data" input-data}))
    (log-info "Creating anomaly score for some input data: " score-id)
    ;; the score resource contains a `score` property where it stores
    ;; the anomaly score value.
    (define score-resource (fetch score-id))
    ;; extracting the score value from the score resource
    (define score (score-resource "score"))
    (log-info "The score for " input-data " is : " score)
```

You can test this code in the [WhizzML REPL](https://bigml.com/labs/repl/).

Note that create calls are not waiting for the asynchronous resources to be
finished before returning control. However, when a resource is used to generate
another one, the next create call will wait for the origin resource to be
finished before starting the creation process (e.g, `(create-dataset source-id)`
will wait for the source to be finished before creating the dataset from it).

If you want to configure some of the attributes of your Anomaly Detector,
like the number of top anomalies retrieved,
you can use the second argument in the create call.


```
    ;; step 2: creating an anomaly detector with a list of the 20 top anomalies
    (create-anomaly dataset-id {"top_n" 20})
```

You can check all the available creation arguments in the
[API documentation](https://bigml.com/api/anomalies?id=anomaly-detector-arguments).

If you want to assign scores to the original dataset (or a different dataset),
you can do so by creating
a `batchanomalyscore` resource. In the example, we'll be assuming you already
created an `anomaly` following the steps 0 to 2 in the previous snippet and
that you want to score the same data you used in the Anomaly Detector.

```
    ;; step 3: creating a batch anomaly score
    (define batch-anomalyscore-id (create-batchanomalyscore anomaly-id
                                                            dataset-id))
    ;; or you could explicitly set the arguments map
    (define batch-anomalyscore-v2-id (create-batchanomalyscore
                                       {"anomaly" anomaly-id
                                        "dataset" dataset-id}))
```

The batch anomaly score output (as well as any of the resources created)
can be configured using additional arguments in the corresponding create calls.
For instance, to include all the information in the original dataset in the
output you would change `step 3` to:

```
    (define batch-anomalyscore-id (create-batchanomalyscore
                                    {"anomaly" anomaly-id
                                     "dataset" dataset-id
                                     "all_fields" true}))
```

and to generate a new dataset that adds the anomaly score as a new column
appended at the end of the original ones and retrieve the information therein,
the steps would be:

```
    ;; step 3: creating a batch anomaly score. Note that we now use
    ;; `create-and-wait-batchanomalyscore` to ensure that we wait for the
    ;; resource to be finished to read its properties in the next step.
    ;; We can also use `create-batchanomalyscore` and wait later for the
    ;; resource to finish using  `wait`. The `create-[resource-type]` and
    ;; `create-and-wait-[resource-type]` procedures are available for
    ;; all resources
    (define batch-anomalyscore-id (create-and-wait-batchanomalyscore
                                    {"anomaly" anomaly-id
                                     "dataset" dataset-id
                                     "all_fields" true
                                     "output_dataset" true}))
    ;; step 4: We need to wait for the batch anomaly score to be created to
    ;; retrieve its information
    (define batch-anomalyscore-resource (fetch batch-anomalyscore-id))
    ;; step 5: We need to extract the output dataset ID and wait for it to be
    ;; finished too in order to use it. That ID is in the
    ;; `output_dataset_resource` attribute of the batch anomaly score info
    (define batch-anomalyscore-ds
      (wait (batch-anomalyscore-resource "output_dataset_resource")))
```

Check the [API documentation](https://bigml.com/api/) to learn about the
available configuration options for any BigML resource.
