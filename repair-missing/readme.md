# Dataset Repair

The idea behind this script is to take a dataset as input and return a
"clean" dataset with no missing values (except possibly in the
objective) and only "preferred" fields.

The script "completes" missing fields by using predictive models to
impute value where they are missing.  The result is a dataset with the
columns containing missing values replaced by columns with the missing
values imputed.  In addition, for each completed column, we add a
binary column indicating whether or not the value was missing in the
original dataset.  Finally, we also remove non-preferred columns.

## Some Details

The script learns a random forest for each numeric or categorical
field that has missing data.  The random forest is trained with the
BigML defaults and uses all fields as input (except the objective
field if specified).  The training data for each field is composed of
all rows except those missing the target field value.

After training, we make predictions for all rows using the learned
model.  A flatline expression is then used to select between the
original field value (if present) or the prediction (if the value in
the original field is missing).

An additional binary column is generated for each field that required
completing, describing whether or not the field was missing in the
original column.  This is useful in the case where data is missing for
a reason that may have relevant semantics (such as a doctor deciding not to
administer a specific medical test).

For "text" or "items" fields, we replace missing values with the empty
string.  As text and items fields essentially comprise a set of binary
features, the empty string gives a sensible replacement for those
features.  We also generate the "was missing" column in this case.

Datetime fields are not imputed directly, but their constituent
fields are.

## Tests

The `test` directory contains a shell script named `test.sh` which
uses `BigMLer` to perform a basic test of the WhizzML code. To run the
test:

- BigMLer must be installed. For instructions to install BigMLer
please refer to the [BigMLer
documentation](http://bigmler.readthedocs.io/en/latest/#bigmler-installation).
- Your credentials must be set as environment variables. Please refer
to the [BigML
Authentication](http://bigmler.readthedocs.io/en/latest/#bigml-authentication)
section of docs for details.

Once the setup is complete, go to the test directory and run the shell
script

```
bash
cd test
VERBOSITY=0 ./test.sh
```

Note that changing the value of `VERBOSITY` to either 1 or 2 will give
you increasing levels of output as the tests are running.
