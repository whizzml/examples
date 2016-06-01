# clean-data
The `clean-data` library is a collection of WhizzML routines that for cleaning up a dataset before is used by other BigML functions on datasets.

## Routines
The library is includes several functions described next.  More may be added in the future as the library is expanded.

### (extract-meta ...)
```(extract-meta mpi)```

**Inputs:**
* `mpi`: (map) Nested map from one field in the `:fields` nested map

**Output:** (map) Filtered map

This core function used by `(extract-meta-func ...)` accepts a nested map for one field in the `:fields` nested map of the dataset meta-data and returns a filtered map.  That filtered map is a template for the map of default values supplied to the `(fill-missing ...)` function.


### (extract-meta-func ...)
```(extract-meta mpi)```

**Inputs:**
* `ds`: (map) Dataset meta-data from which the filter function will extract template data

**Output:** (function) Filtering function

This is a factory function that accepts a dataset meta-data map and returns a function for processing the fields in the `:fields` nested map of the metadata.  The returned function accepts the map for one field in the `fields` nested map and creates a filtered version for use as a template for the map of default value for that field.


### (generate-configmap ...)
```(generate-configmap dataset-id)```

**Inputs:**
* `dataset-id`: (string) ID of dataset to be processed to fill-in missing data

**Output:** (map) Filtered version of the `:fields` section of the dataset meta-data.

This standalone function extracts a map from the dataset meta-data that can be augmented with a `:default` field for each field in the dataset. The augmented map can be used as the input map specifying default values for missing data in the dataset.

The key format of the extracted map is:
```
{:000000
  {...
   :name "Employment Rate",
   ...
   :summary
   {...}
  },
:000001
  { ... },
  ...
}
```

### (fill-missing ...)
```(fill-missing dataset-id dflt-mp)```

**Inputs:**
* `dataset-id`: (string) Source dataset ID.
* `dflt-mp`: (map) Dataset fields and default fill values

**Output:** (string) Filled dataset ID.

This function combines WhizzML and Flatline to generate the result dataset from a source dataset with missing values in the dataset replaced by default values. WhizzML is used to create the result dataset, but a Flatline expression is passed to the BigML platform to specify how data in the source dataset is processed when creating the result dataset.

In particular, the Flatline expression
```
(all-with-defaults <field-designator-0> <field-value-0>
                   <field-designator-1> <field-value-1>
                     …
                   <field-designator-n> <field-value-n>)"
```
is generated using the WhizzML "(flatline …)" function as
```
(define x [...])
(define fl (flatline "(all-with-defaults @{x})"))
```

The string "fl" describing the function `(all-with defaults ...)` is then used in WhizzML as the (string) value passed to the backend as a value for parameter(s) of the `(create-and-wait-dataset ...)` function.

The fields and their default values are provided to this function in a augmented version of the field map returned by the (extract-meta …) function:
```
;; {:000000
;;  {...
;;   :name "Employment Rate",
;;   ...
;;   :summary
;;   {...}
;;   :default "value"
;;  },
;;  :000001
;;  { ... },
;;  ...
;; }
```

## Examples

The `(fill-missing ...)` function in the library fills missing values in `dataset-id` with default values specified in `dflt-mp` to create a new `filled-dataset-id`:

```(define filled-dataset-id (fill-missing dataset-id dflt-mp))```

<br>

To quickly generate a template map for `dflt-mp`, one can use the helper function

```(define config-mp (generate-configmap dataset-id))```

