# Modeling and prediction per category

With the [create-category-models script](create-category-models),
given an input dataset and one of its categorical fields, you'll
generate a new dataset for each of the categories in the given field,
containing each only those instances that belong to the same
category.  Once those datasets are created, a predict model is created
for each one, using the specified objective field.  The final result
of the script execution is thus a list of datasets and a list of
predictive models, one per category.

To make predictions for new instances using those models, you can use
accompanying scripts [single-prediction](single-prediction)
and [batch-prediction](batch-prediction).  Both take as one of their
inputs the identifier of the execution that created the models (that
is, an execution of [create-category-models](create-category-models)),
and either a single instance or an input dataset to perform either a
single prediction or a batch prediction using the category models.

Predictions are made by selecting the appropriate model, according to
the category of the input instances.

## How to install

### Using bigmler

If you have bigmler installed in your system, just checkout this
repository and, at its top level, issue the command:

        make compile PKG_DIR=model-per-category

That will create for you all three scripts.

### Using the web UI

- Install the `create-category-models` script, using
  [this url](./create-category-models).
- Install [single-prediction](./single-prediction) to be able to make
  single predictions given an execution of `create-category-models`.
- Install [batch-prediction](./batch-prediction) to be able to create
  batch predictions given an execution of `create-category-models`.
