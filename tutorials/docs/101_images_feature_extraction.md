# WhizzML: 101 - Images Feature Extraction

Following the schema described in the prediction workflow
document, this is the code snippet that shows the minimal workflow to
extract features from images and generate an enriched dataset that can be
used to train any kind of model.

```
    ;; step 0: creating a source from the data in your remote
    ;; "https://github.com/bigmlcom/python/blob/master/data/images/fruits_hist.zip?raw=true" file.
    ;; The file contains two folders, each
    ;; of which contains a collection of images. The folder name will be used
    ;; as label for each image it contains.
    ;; The source is created enabling image analysis and setting some of the
    ;; available features (see the API documentation at
    ;; https://bigml.com/api/sources?id=source-arguments
    ;; for details). In particular, we extract histogram of gradients and
    ;; average pixels.
    (define extracted_features ["average_pixels" "histogram_of_gradients"])
    (define source-id (create-source
                        {"remote" "https://github.com/bigmlcom/python/blob/master/data/images/fruits_hist.zip?raw=true"
                         "image_analysis" {"enabled" true
                                           "extracted_features" extracted_features}}))
    ;; When finished, results will be stored and the new ``image_id`` and
    ;; ``label`` fields will be generated in the source.
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source` and
    ;; extracting the requested features
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating an anomaly detector
    (define anomaly-id (create-anomaly dataset-id))
    (log-info "Creating anomaly detector from dataset: " anomaly-id)
    ;; the new input data to score
    (define input-data  {"image_id" "https://github.com/bigmlcom/python/raw/master/data/fruits1e.jpg"})
    ;; creating a single anomaly score: The image file is uploaded to BigML,
    ;; a new source is created for it using the same image_analysis
    ;; used in the image field, and its ID is used as value
    ;; for the ``image_id`` field in the input data to generate the prediction
    (define anomalyscore-id (create-anomalyscore anomaly-id
                                                 {"input_data" input-data}))
    (log-info "Anomaly score has been created: " anomaly-id)
    ;; the anomaly score info contains an `score` property where it stores
    ;; the anomaly score.
    (define anomalyscore-resource (fetch anomalyscore-id))
    ;; extracting the score from the anomaly score info
    (define score (anomalyscore-resource "score"))
    (log-info "Anomaly score: " score)
```

You can test this code in the [WhizzML REPL](https://bigml.com/labs/repl/).
