# WhizzML: 101 - Using Association Discovery

Following the schema described in the [training and prediction workflow](workflow.md)
document, this is the code snippet that shows the minimal workflow to
create an association and produce association sets.

```
    ;; step 0: creating a source from the data in your remote "https://raw.githubusercontent.com/bigmlcom/python/master/data/groceries.csv" file
    (define source-id (create-source {"remote" "https://raw.githubusercontent.com/bigmlcom/python/master/data/groceries.csv"}))
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source`
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating an association
    (define association-id (create-association dataset-id))
    (log-info "Creating association from dataset: " association-id)
    ;; the new input data to score
    (define input-data {"Products" "Fruit, Wine"})
    ;; creating a single association set
    (define associationset-id (create-associationset
                                association-id
                                {"input_data" input-data}))
    (log-info "Creating association set for some input data: " associationset-id)
```

You can test this code in the [WhizzML REPL](https://bigml.com/labs/repl/).

Note that create calls are not waiting for the asynchronous resources to be
finished before returning control. However, when a resource is used to generate
another one, the next create call will wait for the origin resource to be
finished before starting the creation process (e.g, `(create-dataset source-id)`
will wait for the source to be finished before creating the dataset from it).

Check the [API documentation](https://bigml.com/api/) to learn about the
available configuration options for any BigML resource.
