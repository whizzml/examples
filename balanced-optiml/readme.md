# Balanced OptiML: BigML Model optimization for Unbalanced Datasets

In this repository, you can find a [`WhizzML Script`](./bal-optiml-script)
and a [`WhizzML Library`](./bal-optiml-library) to perform **Model search
Optimization for Unbalanced Datasets** within BigML.

The [script](./bal-optiml-script) will create a collection of OptiMLs
to find the best performing model from an Unbalanced Dataset using
undersampling techniques. The [library](./bal-optiml-library) contains some
lower-level functions to abstract away the complexity from the main
script.


## How to install

Balanced OptiML [`WhizzML Script`](./bal-optiml-script) imports a [`WhizzML
Library`](./bal-optiml-library), so the installation is a litle bit
different to other WhizzML scripts. You can still install it from the
Dashboard but you will need to perform an additional step.

### Using the Dashboard - 2 steps

Firstly, you should install the library. Open the WhizzML Libraries
view, as shown in the image.

![Import Library](../automl/res/import-library.png)

From that view, import the library from Github, as you would do with a
WhizzML Script, using [the link to the library ](./bal-optiml-library).

![Import Library](../automl/res/import-library2.png)

Then, in the Scripts view, import the [`WhizzML
Script`](./bal-optiml-script) from Github as you would do with other
WhizzML scripts.

![Import Script](../automl/res/import-script.png)

You may see the following error

![Import Library Error](../automl/res/lib-error.png)

In that case, import the library that you created in the previous step
by selecting it with the drop-down selector. After selecting it the
error will disappear.

Following these steps, you should be able to create the script in your
BigML account.


### Using BigMLer - 1 step
After checking that you have
[bigmler](https://bigmler.readthedocs.io/en/latest/) installed in your
system, just check out the [WhizzML examples
repository](https://github.com/whizzml/examples/) and, at its [top
level directory](https://github.com/whizzml/examples/), issue the
command:

     bigmler whizzml --package-dir=balanced-optiml



That will create both the Balanced OptiML library and script resources for you.
Please, make sure to execute the command above in the repository's top
level directory, *not* in [balanced-optiml](./).

See also [the top-level readme](../readme.md) for general information
on installing packages in this repository.

## How to execute

To create a new execution of the Balanced OptiML, please read the [script
readme](./bal-optiml-script).
