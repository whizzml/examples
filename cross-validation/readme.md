# k-fold cross-validation

In this package you'll find three scripts implementing k-fold
cross-validation for different resources:

- [Basic 5-fold cross-validation](./basic)
  5-fold cross-validation of a model created with default parameters
- [Model k-fold cross-validation](./model)  General k-fold
  cross-validation for models.
- [Ensemble k-fold cross-validation](./ensemble) General k-fold
  cross-validation for ensembles.
- [Boosted Ensemble k-fold cross-validation](./boosted-ensemble) General k-fold
  cross-validation for boosted ensembles.
- [Logistic regression k-fold cross-validation](./logistic-regression)
  General k-fold
  cross-validation for logistic regressions.
- [Deepnet k-fold cross-validation](./deepnet)
  General k-fold
  cross-validation for deepnets.
- [Supervised Learning model k-fold cross-validation](./supervised-conf)
  General k-fold
  cross-validation for existing Supervised Learning Classification Models.


## Installation

Please see [the top-level readme](../readme.md) for detailed installation
instructions.

## Tests

The `test` directory contains a shell script named `test.sh`
which uses `BigMLer` to perform a basic test of the WhizzML code. To run the
test:

- BigMLer must be installed. For instructions to install BigMLer please refer
to the [BigMLer documentation](http://bigmler.readthedocs.io/en/latest/#bigmler-installation).
- Your credentials must be set as environment variables. Please refer to
the [BigML Authentication](http://bigmler.readthedocs.io/en/latest/#bigml-authentication)
section of docs for details.

Once the setup is complete, go to the test directory and run the shell script

```bash
    cd test
    ./test.sh
```
