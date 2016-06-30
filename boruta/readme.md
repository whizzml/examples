# Boruta algorithm

In this package you'll find a script implementing the Boruta algorithm to
determine important and unimportant fields in your dataset. The algorithm:

- Uploads a data souce from its remote location
- Creates the corresponding dataset
- Creates a new extended dataset. In the new dataset, each field has a
  corresponding shadow field which has the same type but contains a random
  sample of the values contained in the original one.
- Creates a random forest from the extended dataset
- Extracts the maximum of the importances for the shadow fields
- Uses this maximum as threshold. Any of the original
  fields scoring less than this threshold are considered unimportant and fields
  scoring more are considered important.
- Fields marked as unimportant are removed from the list of fields to be used
  as input fields for new datasets
- The procedure is repeated, and a new extended dataset is created with
  the remaining fields. The process stops when it reaches the provided number
  of runs or when all the original fields in the dataset are marked.

The **inputs** for the script are:

* `source-url`: (string) Remote URL where data is stored
* `objective`: (string) Name of the objective field
* `runs`: (integer) Maximum number of runs

# Using the boruta script

One example using the ``iris.csv`` example would be

```
(boruta "s3://bigml-public/csv/iris.csv"
        "species"
        2)
```

The **output** of the script will be a map of the fields maked as important
or unimportant.
