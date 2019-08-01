# AutoML: Bigml Automated Machine Learning

In this repository, you can find a [`WhizzML Script`](./automl-script)
and a [`WhizzML Library`](./automl-library) to perform **Automated
Machine Learning** within BigML.

![BigML AutoML](./res/automl.png)


The [script](./automl-script) will execute, from a given set of
train/validation/test datasets, the thhree main stages in a Automated
Machine Learning pipeline: Feature Generation, Feature Selection and
Model Selection. The [library](./automl-library) contains some
lower-level functions to abstract away the complexity from the main
script.


## How to install

### Using bigmler

If you have `bigmler` installed in your system, just checkout this
repository and, at its top level, issue the command:

        make compile PKG=automl

That will create all necessary libraries and scripts for you.

### Using the web UI

- Install the `automl` script, using
  [this url](./automl-script).
- Install the `automl` library, using
  [this url](./automl-library).

If necessary, please see [the top-level readme](../readme.md) for more general
installation instructions.

## How to execute
To create a new execution of the AutoML, please read the [script
readme](./automl-script).
