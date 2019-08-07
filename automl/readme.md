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

If you have [bigmler](https://bigmler.readthedocs.io/en/latest/) and
`make` installed in your system, just check out the [Whizzml examples
repository](https://github.com/whizzml/examples/) and, at its [top
level directory](https://github.com/whizzml/examples/), issue the
command:

        make compile PKG=automl

That will create all necessary libraries and scripts resources for
you, and clean up any previous installations.  Please, make sure to
execute the `make` command above in the repository's top level
directory, *not* in [automl](./).

If `make` is not available in your system, you can install the library
and the script simply with this command (this time, [inside this
directory](./)):

     bigmler whizzml --package-dir=./

See also [the top-level readme](../readme.md) for general information
on installing packages in this repository.

## How to execute

To create a new execution of the AutoML, please read the [script
readme](./automl-script).
