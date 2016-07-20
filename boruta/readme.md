# Boruta Feature Selection

In this package you'll find two scripts implementing Boruta Feature Selection:

- [Boruta 1-click Feature Selection](./1-click-boruta)
  Starting from a dataset, creates a new one removing the unimportant features
  according to the Boruta Feature Selection algorithm.
- [Boruta Feature Selection](./boruta)  General Boruta Feature Selection
  algorithm to rank fields from a dataset into three categories: important,
  unimportant and undecided.


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
