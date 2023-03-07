# WhizzML: 101 - Using a Cluster

Following the schema described in the prediction workflow
document, this is the code snippet that shows the minimal workflow to
create a Cluster and find the Centroid associated to a single instance.

```
    ;; step 0: creating a source from the data in your remote "https://static.bigml.com/csv/iris.csv" file
    (define source-id (create-source {"remote" "https://static.bigml.com/csv/iris.csv"}))
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source`
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating a cluster
    (define cluster-id (create-cluster dataset-id))
    (log-info "Creating cluster from dataset: " cluster-id)
    ;; the new input data to find the centroid. All numeric fields are to be
    ;; provided.
    (define input-data {"petal length" 4
                        "sepal length" 2
                        "petal width" 3
                        "sepal width" 1
                        "species" "Iris-setosa"})
    ;; creating the associated centroid
    (define centroid-id (create-centroid cluster-id
                                         {"input_data" input-data}))
    (log-info "Creating centroid for some input data: " centroid-id)
    ;; the centroid resource contains a `cluster` property where it stores
    ;; the centroid name, the centroid ID and the distance of input data
    ;; to the centroid
    (define centroid-resource (fetch centroid-id))
    ;; extracting the centroid name from the centroid resource
    (define centroid-name (centroid-resource "centroid_name"))
    (log-info "The centroid for " input-data " is : " centroid-name)
    (define centroid-distance (centroid-resource "distance"))
    (log-info "The distance from the centroid to " input-data " is :"
              centroid-distance)
```

You can test this code in the [WhizzML REPL](https://bigml.com/labs/repl/).

Note that create calls are not waiting for the asynchronous resources to be
finished before returning control. However, when a resource is used to generate
another one, the next create call will wait for the origin resource to be
finished before starting the creation process (e.g, `(create-dataset source-id)`
will wait for the source to be finished before creating the dataset from it).

If you want to configure some of the attributes of your Cluster,
like the default numeric value to use when a numeric field value is missing,
you can use the second argument in the create call.

```
    ;; step 2: creating a cluster and using the mean as default numeric value
    (create-cluster dataset-id {"default_numeric_value" "mean"})
```

You can check all the available creation arguments in the
[API documentation](https://bigml.com/api/clusters?id=cluster-arguments).

If you want to find the centroids for many inputs at once, you can do so by
creating a `batchcentroid` resource. You can create a `batchcentroid` using
the same `dataset` that you used to built the `cluster` and this will produce a
new dataset with a new column that contains the name of the cluster each
instance has been assigned to.

```
    ;; step 3: creating a batch centroid
    (define batch-centroid-id (create-batchcentroid cluster-id
                                                    dataset-id)
    ;; or you could explicitly set the arguments map
    (define batch-centroid-v2-id (create-batchcentroid
                                   {"cluster" cluster-id
                                    "dataset" dataset-id}))
```

The batch centroid output (as well as any of the resources created)
can be configured using additional arguments in the corresponding create calls.
For instance, to include all the information in the original dataset in the
output you would change `step 3` to:

```
    (define batch-centroid-id (create-batchcentroid
                                {"cluster" cluster-id
                                 "dataset" dataset-id
                                 "all_fields" true}))
```

and to generate a new dataset that adds the centroid as a new column
appended at the end of the original ones and retrieve the information therein,
the steps would be:

```
    ;; step 3: creating a batch centroid. Note that we now use
    ;; `create-and-wait-batchcentroid` to ensure that we wait for the
    ;; resource to be finished to read its properties in the next step.
    ;; We can also use `create-batchcentroid` and wait later for the
    ;; resource to finish using  `wait`. The `create-[resource-type]` and
    ;; `create-and-wait-[resource-type]` procedures are available for
    ;; all resources
    (define batch-centroid-id (create-and-wait-batchcentroid
                                {"cluster" cluster-id
                                 "dataset" dataset-id
                                 "all_fields" true
                                 "output_dataset" true}))
    ;; step 4: We need to wait for the batch centroid to be created to
    ;; retrieve its information
    (define batch-centroid-resource (fetch batch-centroid-id))
    ;; step 5: We need to extract the output dataset ID and wait for it to be
    ;; finished too in order to use it. That ID is in the
    ;; `output_dataset_resource` attribute of the batch centroid info
    (define batch-centroid-ds
      (wait (batch-centroid-resource "output_dataset_resource")))
```

Check the [API documentation](https://bigml.com/api/) to learn about the
available configuration options for any BigML resource.
