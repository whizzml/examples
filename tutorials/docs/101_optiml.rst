.. toctree::
   :hidden:

WhizzML: 101 - Using an OptiML
==============================

Following the schema described in the prediction workflow
document, this is the code snippet that shows the minimal workflow to
create an OptiML.

.. code-block::

    ;; step 0: creating a source from the data in your remote "https://static.bigml.com/csv/iris.csv" file
    (define source-id (create-source {"remote" "https://static.bigml.com/csv/iris.csv"}))
    (log-info "Creating remote source: " source-id)
    ;; step 1: creating a dataset from the previously created `source`
    (define dataset-id (create-dataset source-id))
    (log-info "Creating dataset from source: " dataset-id)
    ;; step 2: creating an optiml. You can configure the maximum training
    ;; time or other arguments to control the type of models used or set
    ;; weight to be used. The example sets a `max_training_time" of 300 seconds
    ;; and uses only decision trees and logistic regressions
    (define optiml-id (create-optiml dataset-id
                                     {"max_training_time" 300
                                      "model_types" ["model"
                                      "logisticregression"]}))
    (log-info "Creating optiml from dataset: " optiml-id)

You can test this code in the `WhizzML REPL <https://bigml.com/labs/repl/>`_.

You can check all the available creation arguments in the `API documentation
<https://bigml.com/api/optimls#op_optiml_arguments>`_.
