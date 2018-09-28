# Multi-label models and predictions

These scripts allow selecting an items field when modeling as objective field
and predicting with any
supervised algorithm in BigML. Note that it uses the
[items-to-features](items-to-features)
script, so you must previously create it in your account.

With the [create-item-models script](create-item-models),
given an input dataset and one of its tiems fields, you'll
generate a collection of predictive models based on the input data.
The dataset will be extended with a new binary field per item. Each one
of these fields will be used as objective field in one model in the
collection while the rest of items fields plus the original objective
field will be excluded.

To make predictions for new instances using those models, you can use
accompanying script [ml-batch-prediction](ml-batch-prediction).
It takes as one of their
inputs the identifier of the execution that created the models (that
is, an execution of [create-item-models](create-item-models)),
and an input dataset to perform a batch prediction using the items models.

## How to install

### Using bigmler

If you have bigmler installed in your system, just checkout this
repository and, at its top level, issue the commands:

        make compile PKG=items-to-features
        make compile PKG=multi-label

That will create all three scripts for you.

### Using the web UI

- Install the `items-to-features` script, using
  [this url](./items-to-features).
- Install the `create-item-models` script, using
  [this url](./create-item-models).
- Install [ml-batch-prediction](./ml-batch-prediction) to be able to create
  batch predictions given an execution of `create-item-models`.

If necessary, please see [the top-level readme](../readme.md) for more general
installation instructions.
