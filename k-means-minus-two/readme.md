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

- k: the number of clusters desired. By default is -1, which means
  that G-Means algorithm will be used to find the optimal number
  of clusters.

- l: the number of anomalies to be removed at each step
     If 0<l<1, it will be considered as a percentage of
     the total number of rows. 0.05% by default.

- threshold: the minimum desired Jaccard index between iterations. 0.8
  by default.

- maximum: the maximum number of desired iterations. 10 by default.

# Outputs

- cluster: the cluster id of the final cluster

- dataset: the original dataset appended with fields for cluster
  membership and distance to centroid

- anomalies-ds: The ID of a dataset containing the anomalies

- similarities: a list of the similarity coefficients from each step
