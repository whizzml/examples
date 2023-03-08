# WhizzML: 101 - Using a Logistic Regression

Following the schema described in the [training and prediction workflow](workflow.md)
document, this is the code snippet that shows the minimal workflow to
create a logistic regression model and produce a single prediction.

```
    ;; step 0: creating a source from the data in your remote "https://static.bigml.com/csv/iris.csv" file
    (define source-id (create-source {"remote" "https://static.bigml.com/csv/iris.csv"}))
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source`
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating a logistic regression
    (define logisticregression-id (create-logisticregression dataset-id))
    (log-info "Creating logistic regression from dataset: "
              logisticregression-id)
    ;; the new input data to predict for
    (define input-data {"petal width" 1.75
                        "petal length" 2.45})
    ;; creating a single prediction
    (define prediction-id (create-prediction logisticregression-id
                                             {"input_data" input-data}))
    (log-info "Prediction has been created: " prediction-id)
    ;; the prediction info contains an `output` property where it stores
    ;; the predicted value. As a classification, will have the `probability`
    ;; attribute associated to it.
    (define prediction-resource (fetch prediction-id))
    ;; extracting the predicted value from the prediction info
    (define prediction (prediction-resource "output"))
    (log-info "Prediction: " prediction)
    ;; extracting the associated probability
    (define prediction-probability (prediction-resource "probability"))
    (log-info "Prediction probability: " prediction-probability)
```

You can test this code in the [WhizzML REPL](https://bigml.com/labs/repl/).

Note that create calls are not waiting for the asynchronous resources to be
finished before returning control. However, when a resource is used to generate
another one, the next create call will wait for the origin resource to be
finished before starting the creation process (e.g, `(create-dataset source-id)`
will wait for the source to be finished before creating the dataset from it).

If you want to create predictions for many new inputs, you can do so by
creating
a `batchprediction` resource. First, you will need to upload to the platform
all the input data that you want to predict for and create the corresponding
`source` and `dataset` resources. In the example, we'll be assuming you already
created a `logisticregression` following the steps 0 to 2 in the previous snippet.

```
    ;; step 3: creating a source from the data in your remote "https://static.bigml.com/csv/test_iris.csv" file
    (define test-source-id (create-source {"remote" "https://static.bigml.com/csv/test_iris.csv"))
    ;; step 4: creating a dataset from the previously created `source`
    (define test-dataset-id (create-dataset test-source-id))
    ;; step 5: creating a batch prediction
    (define batch-prediction-id (create-batchprediction logisticregression-id
                                                        test-dataset-id))
```

The batch prediction output (as well as any of the resources created)
can be configured using additional arguments in the corresponding create calls.
For instance, to include all the information in the original dataset in the
output you would change `step 5` to:

```
    (define batch-prediction-id (create-batchprediction
                                  {"model" logisticregression-id
                                   "dataset" test-dataset-id
                                   "all_fields" true}))
```

and to generate a new dataset that adds the prediction as a new column appended
at the end of the original ones and retrieve the information therein, the step
would be:

```
    ;; step 5: creating a batch prediction. Note that we now use
    ;; `create-and-wait-batchprediction` to ensure that we wait for the
    ;; resource to be finished to read its properties in the next step.
    ;; We can also use `create-batchprediction` and wait later for the
    ;; resource to finish using  `wait`. The `create-[resource-type]` and
    ;; `create-and-wait-[resource-type]` procedures are available for
    ;; all resources
    (define batch-prediction-id (create-and-wait-batchprediction
                                  {"model" logisticregression-id
                                   "dataset" test-dataset-id
                                   "all_fields" true
                                   "output_dataset" true}))
    ;; step 6: retrieving the batch prediction information
    (define batch-prediction-resource (fetch batch-prediction-id))
    ;; step 7: extracting the output dataset ID and waiting for it to be
    ;; finished too in order to use it.
    (define batch-prediction-ds
      (wait (batch-prediction-resource "output_dataset_resource")))
```

Check the [API documentation](https://bigml.com/api/) to learn about the
available configuration options for any BigML resource.
