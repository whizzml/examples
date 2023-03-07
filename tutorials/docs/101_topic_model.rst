.. toctree::
   :hidden:

WhizzML: 101 - Using a Topic Model
==================================

Following the schema described in the prediction workflow
document, this is the code snippet that shows the minimal workflow to
create a topic model and produce a single topic distribution.

.. code-block::

    ;; step 0: creating a source from the data in your remote "https://raw.githubusercontent.com/bigmlcom/python/master/data/spam.csv" file
    (define source-id (create-source {"remote" "https://raw.githubusercontent.com/bigmlcom/python/master/data/spam.csv"}))
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source`
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating a topic model
    (define topicmodel-id (create-topicmodel dataset-id))
    (log-info "Creating topic model from dataset: " topicmodel-id)
    ;; the new input data to score
    (define input-data {"Message": "Mobile offers, 20% discount."})
    ;; creating a topic distribution
    (define topicdistribution-id (create-topicdistribution
                                   topicmodel-id
                                   {"input_data" input-data}))
    (log-info "Creating topic distribution for some input data: " topicdistribution-id)
    ;; the topic distribution result contains a property where it stores
    ;; the probabilities associated to the topics
    (define topicdistribution-resource (fetch topicdistribution-id))
    ;; extracting the score value from the score resource
    (define topicdistribution (topicdistribution-resource
                                ["topic_distribution" "result"]))
    (log-info "The topic distribution for " input-data " is : " topicdistribution)

You can test this code in the `WhizzML REPL <https://bigml.com/labs/repl/>`_.

Remember that your dataset needs to have at least a text field to be able
to create a topic model.

Note that create calls are not waiting for the asynchronous resources to be
finished before returning control. However, when a resource is used to generate
another one, the next create call will wait for the origin resource to be
finished before starting the creation process (e.g, `(create-dataset source-id)`
will wait for the source to be finished before creating the dataset from it).

If you want to configure some of the attributes of your Topic Model,
like the number of topics selected,
you can use the second argument in the create call.


.. code-block::

    ;; step 2: creating a topic model with a final list the 20 topics
    (create-topicmodel dataset-id {"number_of_topics" 20})

You can check all the available creation arguments in the `API documentation
<https://bigml.com/api/topic_models?id=topic-model-arguments>`_.

If you want to assign topic distributions to the original dataset
(or a different dataset), you can do so by creating
a `batchtopicdistribution` resource. In the example, we'll be assuming you already
created a `topic model` following the steps 0 to 2 in the previous snippet and
that you want to find the topic distribution for the same data used to create it.

.. code-block::

    ;; step 3: creating a batch topic distribution
    (define batch-topicdistribution-id (create-batchtopicdistribution
                                         topicmodel-id
                                         dataset-id))
    ;; or you could explicitly set the arguments map
    (define batch-topicdistribution-v2-id (create-batchtopicdistribution
                                            {"topicmodel" topicmodel-id
                                             "dataset" dataset-id}))

The batch topic distribution output (as well as any of the resources created)
can be configured using additional arguments in the corresponding create calls.
For instance, to include all the information in the original dataset in the
output you would change `step 3` to:

.. code-block::

    (define batch-topicdistribution-id (create-batchtopicdistribution
                                         {"topicmodel" topicmodel-id
                                          "dataset" dataset-id
                                          "all_fields" true}))

and to generate a new dataset that adds the topic distributions as a new
columns, one per topic, appended at the end of the original ones and
retrieve the information therein, the steps would be:

.. code-block::

    ;; step 3: creating a batch topic distribution. Note that we now use
    ;; `create-and-wait-batchtopicdistribution` to ensure that we wait for the
    ;; resource to be finished to read its properties in the next step.
    ;; We can also use `create-batchtopicdistribution` and wait later for the
    ;; resource to finish using  `wait`. The `create-[resource-type]` and
    ;; `create-and-wait-[resource-type]` procedures are available for
    ;; all resources
    (define batch-topicdistribution-id (create-and-wait-batchtopicdistribution
                                         {"topicmodel" topicmodel-id
                                          "dataset" dataset-id
                                          "all_fields" true
                                          "output_dataset" true}))

    ;; step 4: We need to wait for the batch topic distribution to be created to
    ;; retrieve its information
    (define batch-topicdistribution-resource (fetch batch-topicdistribution-id))
    ;; step 5: We need to extract the output dataset ID and wait for it to be
    ;; finished too in order to use it. That ID is in the
    ;; `output_dataset_resource` attribute of the batch topic distribution info
    (define batch-topicdistribution-ds
      (wait (batch-topicdistribution-resource "output_dataset_resource")))

Check the `API documentation <https://bigml.com/api/>`_ to learn about the
available configuration options for any BigML resource.
