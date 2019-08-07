# AutoML: BigML Automated Machine Learning

In this repository, you can find a [`WhizzML Script`](./automl-script)
and a [`WhizzML Library`](./automl-library) to perform **Automated
Machine Learning** within BigML.

![BigML AutoML](./res/automl.png)


The [script](./automl-script) will execute, from a given set of
train/validation/test datasets, the three main stages in an Automated
Machine Learning pipeline: Feature Generation, Feature Selection and
Model Selection. The [library](./automl-library) contains some
lower-level functions to abstract away the complexity from the main
script.


## How to install

### Using bigmler

If you have `bigmler` installed in your system, just checkout the
[Whizzml examples repository](https://github.com/whizzml/examples/)
and, at its [top level](https://github.com/whizzml/examples/), issue
the command:

        make compile PKG=automl

That will create all necessary libraries and scripts for you.  Plase,
remember not to execute `make compile` from the [examples/automl](./)
folder, you should execute it from its parent folder, [examples](../).

If you can't execute `make` in your system, you can install the
library and the script simply with this command (from the
[examples/automl](./) directory):

     bigmler whizzml --package-dir=./

If necessary, please see [the top-level readme](../readme.md) for more general
installation instructions.

## How to execute
To create a new execution of the AutoML, please read the [script
readme](./automl-script).
