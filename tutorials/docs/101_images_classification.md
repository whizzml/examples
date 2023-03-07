# WhizzML: 101 - Images Classification

Following the schema described in the prediction workflow
document, this is the code snippet that shows the minimal workflow to
create a deepnet from an images dataset and produce a single prediction.

```
    ;; step 0: creating a source from the data in your remote
    ;; "https://github.com/bigmlcom/python/blob/master/data/images/fruits_hist.zip?raw=true" file.
    ;; The file contains two folders, each
    ;; of which contains a collection of images. The folder name will be used
    ;; as label for each image it contains.
    ;; The source is created disabling image analysis, as we want the deepnet
    ;; model to take care of extracting the features. If not said otherwise,
    ;; the analysis would be enabled and features like the histogram of
    ;; gradients would be extracted to become part of the resulting dataset.
    (define source-id (create-source
                        {"remote" "https://github.com/bigmlcom/python/blob/master/data/images/fruits_hist.zip?raw=true"}))
    ;; When finished, results will be stored and the new ``image_id`` and
    ;; ``label`` fields will be generated in the source
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source`
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating a deepnet
    (define deepnet-id (create-deepnet dataset-id))
    (log-info "Creating deepnet from dataset: " deepnet-id)
    ;; the new input data to predict for
    (define input-data  {"image_id" "https://github.com/bigmlcom/python/raw/master/data/fruits1e.jpg"})
    ;; creating a single prediction: The image file is uploaded to BigML,
    ;; a new source is created for it and its ID is used as value
    ;; for the ``image_id`` field in the input data to generate the prediction
    (define prediction-id (create-prediction deepnet-id
                                             {"input_data" input-data}))
    (log-info "Prediction has been created: " prediction-id)
    ;; the prediction info contains an `output` property where it stores
    ;; the predicted value. Also, classifications will have `probability` and
    ;; a `confidence` attributes associated to it.
    (define prediction-resource (fetch prediction-id))
    ;; extracting the predicted value from the prediction info
    (define prediction (prediction-resource "output"))
    (log-info "Prediction: " prediction)
    ;; extracting the associated probability
    (define prediction-probability (prediction-resource "probability"))
    (log-info "Prediction probability: " prediction-probability)
```

You can test this code in the [WhizzML REPL](https://bigml.com/labs/repl/).
