## Finding neighbors of a given dataset row within a cluster

This script takes as inputs a cluster identifier, an instance, i.e.,
a map with values for all fields used by the cluster, and a positive
count `n`.  It then:

- Finds the centroid in the cluster closer to the given instance `p`

- Selects within that centroid's dataset the `n` instances that are
  closest to `p`

- If there are less than `n` rows in the centroid's dataset, missing
  instances are read from the next closest centroid.

This workflow uses flatline to compute the distance between `p` and
the centroid datasets (via the `row-distance-squared` flatline
function) and add an extra column to the dataset, and then creates a
sample of the result, ordered by the computed distance.
