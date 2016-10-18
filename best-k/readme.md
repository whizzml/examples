# best-k-means
The `best-k-means` library is a collection of WhizzML routines that
implement K-means clustering using the Pham-Dimov-Nguyen algorithm for
choosing the best K.
> "Selection of K in K-means clustering"<br>
> *Proc. IMechE, Part C: J. Mechanical Engineering Science*, v.219

## Components and installation

This package contains a library, `best-k-means`, that you must install
first using
[this url](https://github.com/whizzml/examples/tree/master/best-k/best-k-means),
and three scripts to apply the algorithm to
[clusters](https://github.com/whizzml/examples/tree/master/best-k/clusters),
[evaluations](./evaluation) and
[batch centroids](https://github.com/whizzml/examples/tree/master/best-k/batchcentroid),
which you can install individually afterwards.  When importing any of
the scripts, `Best K-Means` must be declared as a dependency.

If necessary, please see [the top-level readme](../readme.md) for more
detailed installation instructions.

## Routines
The library is organized into several functions described next.

### (best-batchcentroid ...)
```(best-batchcentroid dataset cluster-args k-min k-max bestcluster-args clean logf)```

**Inputs:**
* `dataset`: (string) Dataset ID for the dataset to be clustered
* `cluster-args`: (map) cluster arguments for the cluster search operation
* `k-min`: (number) minimum value of k
* `k-max`: (number) maximum value of k
* `bestcluster-args`: (map) cluster arguments for the final best cluster operation
* `clean`: (boolean) Delete all but the optimal cluster
* `logf`: (boolean) Enable logging

**Output:** (batchcentroid) Batchcentroid for best K-means clustering

This is the top-level routine of the library.  It uses the
Pham-Dimov-Nguyen algorithm to create a WhizzML batchcentroid object
and WhizzML dataset annotated with the best K-means clustering of the
supplied `dataset`.

The `clusters-args` and `bestcluster-args` parameters are maps that
one can use to optionally specify all the parameters for the cluster
function except the `dataset`, `k`, and `name` parameters. (See the
"Clusters Arguments" table in the BigML "Clusters" documentation for
details.)  `cluster-args` is used in the search phase for the best
*K*.  `bestcluster-args` allows one to specify different args for the
final stage of clustering with the best *K*. In particular, one might
do clustering on samples of the `dataset` during the search phase to
save time and other resources, then do the best clustering on the full
`dataset`.

If `bestcluster-args` matches `cluster-args`, the result for the best
*K* generated with `cluster-args` during the search phase is returned
by `(best-k-means ....)`.  If `bestcluster-args` differs from
`cluster-args`, the `dataset` is re-clustered with the best *K* and
that is returned by `(best-k-means ....)`.


### (best-k-means ...)
```(best-k-means dataset cluster-args k-min k-max bestcluster-args clean logf)```

**Inputs:**
* `dataset`: (string) Dataset ID for the dataset to be clustered
* `cluster-args`: (map) cluster arguments for the cluster search operation
* `k-min`: (number) minimum value of k
* `k-max`: (number) maximum value of k
* `bestcluster-args`: (map) cluster arguments for the final best cluster operation
* `clean`: (boolean) Delete all but the optimal cluster
* `logf`: (boolean) Enable logging

**Output:** (cluster) Best K-means cluster

This function uses the Pham-Dimov-Nguyen algorithm to create the best
K-means clustering and returns the WhizzML cluster object for the best
*K*.

This function is called by `(best-batchcentroid ...)` to do the actual
clustering.  It can also be called directly if one only needs the best
WhizzML cluster object and not the full WhizzML batchcentroid and
annotated dataset.

### (evaluate-k-means ...)
```(evaluate-k-means dataset cluster-args k-min k-max)```

**Inputs:**
* `dataset`: (string) Dataset ID for the dataset to be clustered
* `cluster-args`: (map) cluster arguments for the cluster search operation
* `k-min`: (number) minimum value of k
* `k-max`: (number) maximum value of k
* `clean`: (boolean) Delete all but the optimal cluster
* `logf`: (boolean) Enable logging

**Output:** (cluster) Evaluations over the range of K

This function is used by `(best-k-means ...)` to generate a list of
clusterings for `k-min` to `k-max` and computes the Pham-Dimov-Nguyen
evaluation function for each clustering.  It can also be called
directly to just generate the list of evaluations for further
analyses.


### (best-cluster ...)
```(best-cluster dataset cluster-args k)```

**Inputs:**
* `dataset`: (string) Dataset ID for the dataset to be clustered
* `cluster-args`: (map) cluster function arguments
* `k`: (number) number of clusters

**Output:** (cluster) Created cluster for K

This function is used by `(best-k-means ...)` to do a K-means
clustering of the `dataset` using the WhizzML cluster function with
the specified *K*.

### (clean-clusters ...)
```(clean-clusters evaluations cluster-id logf)```

**Inputs:**
* `evaluations`: (list) maps of evaluation results including cluster IDs
* `cluster-id`: (cluster) cluster to save (not delete)
* `logf`: (boolean) Enable logging

**Output:** Passes back `cluster-id`.

This Helper function is used by `(best-k-means ...)` and
`(evaluate-k-means ...)` to delete clusters created as intermediate
resources.


### (evaluate-clusters ...)
```(evaluate-clusters clusters)```

**Inputs:**
* `clusters`: (list) Cluster metadata maps implicitly ordered by k

**Output:** (list) Sequence of maps that have the field `fk` with the value *f(k)* added

This is the function used by `(evaluate-k-means ...)` to extract the
cluster metadata with `(extract-eval-data ...)` and compute the
Pham-Dimov-Nguyen evaluation function returned by `(evaluation-func
...)`.

### (evaluation-func ...)
```(evaluation-func n)```

**Inputs:**
* `n`: (number) number of covariates

**Output:** (function) returns the Pham-Dimov-Nguyen evaluation function

This is a factory function that returns a Pham-Dimov-Nguyen evaluation
function for the specified number of covariates *n*.

### (alpha-func ...)
```(alpha-func n)```

**Inputs:**
* `n`: (number) number of covariates

**Output:** (function) returns weighting function

This is a factory function that returns the `alpha(k)` function for
the specified number of covariates *n*.  This weighting function is
used by the Pham-Dimov-Nguyen evaluation function returned by
`(evaluation-func ...)`.

The weighting function in the Pham-Dimov-Nguyen paper is in recursive
form.  The version returned by this factory function is the
closed-form equivalent:

```
          / 1 - (3/4 * n )                             (for k = 2)
alpha_k = |
          \ (5/6)^(k-2) * alpha_2 + [1 - 5/6^(k-2)]    (for k > 2)
```

### (extract-eval-data ...)
```(extract-eval-data cluster)```

**Inputs:**
* `cluster`: (string) Cluster ID

**Output:** (map) Cluster data for use in the evaluation function

This helper function is used by `(evaluate-clusters ...)` to extract a
map of cluster data from a WhizzML cluster object for the
Pham-Dimov-Nguyen evaluation function returned by `(evaluation-func
...)`.

### (extract-cluster-ids ...)
```(extract-cluster-ids clusters)```

**Inputs:**
* `clusters`: (list) Cluster metadata of created clusters

**Output:** (list) Cluster IDs of clusters

This is convenience function (not used in the library) to extract a
list of WhizzML cluster object IDs from the list of WhizzML cluster
objects.

### (generate-clusters ...)
```(generate-clusters dataset cluster-args k-min k-max)```

**Inputs:**
* `dataset`: (string) Dataset ID for the dataset to be clustered
* `cluster-args`: (map) arguments for the cluster operation
* `k-min`: (number) minimum value of k
* `k-max`: (number) maximum value of k

**Output:** (list) Cluster metadata of created clusters

This function is used by `(evaluate-k-means)` to generate a list of
K-mean clusterings for `k-min` to `k-max`.

## Examples

The main function in the library can be called to generate the best
WhizzML batchcentroid and an annotated WhizzML dataset as:

```(define batchcentroid-id (best-batchcentroid dataset cluster-args k-min k-max bestcluster-args clean logf))```

<br>

If only the WhizzML best K-means cluster object is required, perhaps
for evaluating different ranges of `k-min` to `k-max`, one can use the
library function:

```(define cluster-id (best-k-means dataset cluster-args k-min k-max bestcluster-args clean logf))```

<br>

Finally, if one only seeks the list of Pham-Dimov-Nguyen function
evaluations of the K-mean clusterings for `k-min` to `k-max`, one can
use the library function:

```(define evaluations (evaluate-k-means dataset cluster-args k-min k-max))```

<br>

Setting `clean` to `true` causes the function to delete intermediate
datasets created during the computation.  Intermediate information
during execution of the function can be logged by setting `logf` to
`true`.
