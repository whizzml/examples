# K-means minus two

A variation on the k-means-- algorithm proposed by Sanjay Chawla and
Aristides Gionis in their paper ["k-means--: A unified approach to
clustering and outlier detection".](http://pmg.it.usyd.edu.au/outliers.pdf)

Given a dataset, a number of clusters k and a number of anomalies l,
this script creates a BigML k-means cluster. The l instances that are
the farthest from their centroids are removed and another BigML
k-means cluster is created. This process is repeated until the Jaccard
index of subsequent sets of anomalies passes some threshold, or until
some maximum number of iterations.

# Inputs

- dataset: the dataset of interest

- k: the number of clusters desired

- l: the number of anomalies to be removed at each step

- threshold: the minimum desired Jaccard index between iterations

- maximum: the maximum number of desired iterations

# Outputs

- cluster: the cluster id of the final cluster

- dataset: the original dataset appended with fields for cluster
  membership and distance to centroid

- anomalies: a list of the anomalous instances

- similarities: a list of the similarity coefficients from each step
