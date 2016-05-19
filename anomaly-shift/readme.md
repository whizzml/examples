# anomaly shift

The `anomaly-shift` WhizzML library is a small collection of routines
that use the BigML anomaly detection functions to assess covariate
shift between a dataset used to train a model and a production
dataset.

In brief, the principle of the method is to compute an average anomaly
score of the production dataset relative to the model training dataset
as a measure of the covariate shift between the training dataset and
the production dataset. An anomaly detector is trained from the same
dataset used to train the model.  This anomaly detector is then used
to derive a batch anomaly score for the production dataset.  Finally,
the average value of that batch anomaly score is computed as an
indicator of covariate shift.

In practice, one might compute the average batch anomaly scores for
several pairs of subsets of the training and production datasets, and
then assess covariate shift based on the mean and variance of the
averge batch anomaly scores from those iterations.

## Routines

The library is organized into several functions described next.

### (anomaly-estimate ...)
```(anomaly-estimate train-dst train-exc prod-dst prod-exc seed niter clean logf)```

**Inputs:**
* `train-dst`: (string) Dataset ID for the training data
* `train-exc`: (list) Fields to exclude from the training dataset
* `prod-dst`: (string) Dataset ID for the production data
* `prod-exc`: (list) Fields to exclude from the production dataset
* `seed`: (string) Prefix for dataset seed. See "sample-dataset"
* `niter`: (number) Number of iterations to be averaged
* `clean`: (boolean) Delete intermediate datasets
* `logf`: (boolean) Enable logging

**Output:** (float) Average anomaly score for specified datasets over `niter` trials. Values between 0 and 1.

This is the main function to compute the average over `niter`
iterations of the batch anomaly score between a training dataset
`train-dst` and a production dataset `prod-dst`.  The parameters
`train-exc` and `prod-exc` are lists of fields that should be excluded
(ignored) when computing the anomaly detector and evaluating the batch
anomaly score.  The flag `clean` allows the developer to retain or
delete all the intermediate datasets created by the BigML platform in
the computation.  A limited about of logging can be enabled with the
`logf` flag.


### (anomaly-measures ...)
```(anomaly-measures train-dst train-exc prod-dst prod-exc seed niter clean logf)```

**Inputs:**
* `train-dst`: (string) Dataset ID for the training data
* `train-exc`: (list) Fields to exclude from the training dataset
* `prod-dst`: (string) Dataset ID for the production data
* `prod-exc`: (list) Fields to exclude from the production dataset
* `seed`: (string) Prefix for dataset seed. See "sample-dataset"
* `niter`: (number) Number of iterations to be averaged
* `clean`: (boolean) Delete intermediate datasets
* `logf`: (boolean) Enable logging

**Output:** (list) A list of average anomaly scores for specified datasets over `niter` trials. Values between 0 and 1.

This function computes a list of batch anomaly scores for a single
pair of training and production datasets.  The `(anomaly-estimate
...)` function uses this function and just returns the average of the
batch anomaly scores in the list.


### (anomaly-loop ...)
```(anomaly-loop train-dst train-exc prod-dst prod-exc seed niter clean logf)```

**Inputs:**
* `train-dst`: (string) Dataset ID for the training data
* `train-exc`: (list) Fields to exclude from the training dataset
* `prod-dst`: (string) Dataset ID for the production data
* `prod-exc`: (list) Fields to exclude from the production dataset
* `seed`: (string) Prefix for dataset seed. See "sample-dataset"
* `niter`: (number) Number of iterations to be averaged
* `clean`: (boolean) Delete intermediate datasets
* `logf`: (boolean) Enable logging

**Output:**  (list) A list of average anomaly scores for specified datasets over `niter` trials. Values between 0 and 1.

This function is the core loop functionality of the `(anomaly-measures
...)` function.  This could be implemented as a WhizzML `(map <proc>
<list>)` function that at least in principle requires a variable space
`<list>` argument.  It has been implemented here as a constant-space
`(loop ...)` function to facilitate logging and modification.


### (anomaly-measure ...)
```(anomaly-measure train-dst train-exc prod-dst prod-exc seed clean)```

**Inputs:**
* `train-dst`: (string) Dataset ID for the training data
* `train-exc`: (list) Fields to exclude from the training dataset
* `prod-dst`: (string) Dataset ID for the production data
* `prod-exc`: (list) Fields to exclude from the production dataset
* `seed`: (string) Prefix for dataset seed. See "sample-dataset"
* `clean`: (boolean) Delete intermediate datasets

**Output:** (float) Average anomaly score. Value between 0 and 1.

This function computes a single batch anomaly scores for a single pair
of training and production datasets.  This function is called in each
iteration of the `(anomaly-loop ...)` function.


### (avg-anomaly ...)
```(avg-anomaly evdst-id)```

**Inputs:**
* `evdst-id`: (string) Batch anomaly score dataset ID

**Output:**  (float) Average batch anomaly score for evaluation

This is a helper function used by `(anomaly-measure ...)` to compute
the average of the batch anomaly score for a single pair of training
and production datasets.


### (anomaly-evaluation ...)
```(anomaly-evaluation anomaly-id dst-id)```

**Inputs:**
* `anomaly-id`: (string) Anomaly detector ID
* `dst-id`: (string) Production dataset ID

**Output:** (string) Batch Anomaly Score ID

This helper function is used by `(anomaly-measure ...)` to compute the
batch anomaly score for the production dataset specified by `dst-id`
relative to the anomaly detector specified by `anomaly-id` derived for
the training dataset.


### (sample-dataset ...)
```(sample-dataset dst-id rate oob seed)```

**Inputs:**
* `dst-id`: (string) Dataset ID for the Dataset we want to sample.
* `rate`: (float) Value between 0 & 1. The size of the bigger sample. e.g. 0.8 -> 80% of original dataset is in the new dataset.
* `oob`: (boolean) Indicator of whether we want the bagged chunk of data or the out of bag chunk. e.g. if rate = 0.8, bagged = 80% of data, out of bag = remaining 20%
* `seed`: (string) Any string. Used to make the sampling determistic (repeatable)

**Output:** (string) Dataset ID for the new dataset

This helper function is used by the `(anomaly-measure ...)` function
to generate a subset of the training and production datasets.  (Note:
The `false` choice for `oob` parameter selects the out-of-bag subset
and the `true` choice selects the bagged subset.)

## Example

The main function in the library `(anomaly-estimate ...)` is called in
a straightforward manner:

```(define anomaly-estimate-value (anomaly-estimate train-dst train-exc prod-dst prod-exc seed niter clean logf))```

In the current implementation, 80% of the training dataset `train-dst`
is used to create the anomaly detector.  The batch anomaly score is
evaluated for 20% of the production dataset `prod-dst` and the average
batch anomaly score evaluated.  This is repeated `niter` times and the
average (of the average batch anomaly scores) returned as the final
estimate of the covariate shift between the training and production
datasets.

Setting `clean` to `true` causes the function to delete intermediate
datasets created during the computation.  Intermediate information
during execution of the function can be logged by setting `logf` to
`true`.
