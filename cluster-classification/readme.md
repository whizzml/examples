# Global Field Importance for Clusters

This script determines which input fields are most important for
differentiating between clusters. Given a cluster id, it:

- Using batchcentroid, extends the dataset the cluster was
  built on with the centroid id each instance is a member of.
- Builds an ensemble (random forest) on that centroid id field.
- Averages the importance of each input field across all models
  in the ensemble.
- Returns a sorted list of input fields by importance.